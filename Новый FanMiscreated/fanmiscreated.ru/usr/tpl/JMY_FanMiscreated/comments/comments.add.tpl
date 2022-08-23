[open]
<div class="comment_form shadow_b">
<div id="reply_comment"></div>
{%BB_AREA%}
<input type="hidden" name="nid" value="{%ID%}" id="nid" />
<input type="hidden" value="0" id="reply_to" />
<input type="hidden" name="mod" value="{%MOD%}" id="mod" />

<div class="comment_form_paste"><a id="sub" title="Отправить" onclick="comment_post('commentBox'); return false;">Отправить</a></div>
</div>
[/open]
<script type="text/javascript">
function reply_comment(id){gid('reply_to').value = id; gid('reply_comment').innerHTML = (id > 0 ? '<strong>Ответ на комментарий №:</strong> '+id + ' <a href="javascript:void(0)" onclick="reply_comment(0);">не отвечать</a>' : ''); window.scroll(0, parseInt(gid('comment_add').offsetTop));}
</script>
