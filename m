Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4749837528
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 22:23:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS1kP-0002n3-6h; Mon, 22 Jan 2024 16:22:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>)
 id 1rS1kD-0002m9-V3; Mon, 22 Jan 2024 16:22:13 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sw@weilnetz.de>)
 id 1rS1kA-0003td-Kd; Mon, 22 Jan 2024 16:22:13 -0500
Received: from [192.168.178.59] (p5b1519e5.dip0.t-ipconnect.de [91.21.25.229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTPSA id 7DB1DDA0F70;
 Mon, 22 Jan 2024 22:22:06 +0100 (CET)
Content-Type: multipart/alternative;
 boundary="------------6YLkwTRtHQJAGBUQJcV7ph74"
Message-ID: <8c728584-8bf2-4122-bc2b-a8063d89fbe8@weilnetz.de>
Date: Mon, 22 Jan 2024 22:22:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] util/uri: Simplify uri_string_unescape()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-trivial@nongnu.org
References: <20240122191753.103118-1-thuth@redhat.com>
 <20240122191753.103118-3-thuth@redhat.com>
Autocrypt: addr=sw@weilnetz.de; keydata=
 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
In-Reply-To: <20240122191753.103118-3-thuth@redhat.com>
Received-SPF: pass client-ip=37.120.169.71; envelope-from=sw@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

This is a multi-part message in MIME format.
--------------6YLkwTRtHQJAGBUQJcV7ph74
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 22.01.24 um 20:17 schrieb Thomas Huth:

> uri_string_unescape() basically does the same as the glib function
> g_uri_unescape_string(), with just an additional length parameter.
> So we can simplify this function a lot by limiting the length with
> g_strndup() first and then by calling g_uri_unescape_string() instead
> of walking through the string manually.
>
> Suggested-by: Stefan Weil<stefan.weil@weilnetz.de>

Can my e-mail address be replaced by another one (sw@weilnetz.de)?

> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   util/uri.c | 49 +++----------------------------------------------
>   1 file changed, 3 insertions(+), 46 deletions(-)
>
> diff --git a/util/uri.c b/util/uri.c
> index 33b6c7214e..2a75f535ba 100644
> --- a/util/uri.c
> +++ b/util/uri.c
> @@ -1561,15 +1561,6 @@ done_cd:
>       return 0;
>   }
>   
> -static int is_hex(char c)
> -{
> -    if (((c >= '0') && (c <= '9')) || ((c >= 'a') && (c <= 'f')) ||
> -        ((c >= 'A') && (c <= 'F'))) {
> -        return 1;
> -    }
> -    return 0;
> -}
> -
>   /**
>    * uri_string_unescape:
>    * @str:  the string to unescape
> @@ -1585,8 +1576,7 @@ static int is_hex(char c)
>    */
>   char *uri_string_unescape(const char *str, int len)
>   {
> -    char *ret, *out;
> -    const char *in;
> +    g_autofree char *lstr = NULL;


Is it necessary to assign NULL? It does not look so.


>   
>       if (str == NULL) {
>           return NULL;
> @@ -1594,42 +1584,9 @@ char *uri_string_unescape(const char *str, int len)
>       if (len <= 0) {
>           len = strlen(str);
>       }
> -    if (len < 0) {
> -        return NULL;
> -    }
> -
> -    ret = g_malloc(len + 1);
> +    lstr = g_strndup(str, len);
>   
> -    in = str;
> -    out = ret;
> -    while (len > 0) {
> -        if ((len > 2) && (*in == '%') && (is_hex(in[1])) && (is_hex(in[2]))) {
> -            in++;
> -            if ((*in >= '0') && (*in <= '9')) {
> -                *out = (*in - '0');
> -            } else if ((*in >= 'a') && (*in <= 'f')) {
> -                *out = (*in - 'a') + 10;
> -            } else if ((*in >= 'A') && (*in <= 'F')) {
> -                *out = (*in - 'A') + 10;
> -            }
> -            in++;
> -            if ((*in >= '0') && (*in <= '9')) {
> -                *out = *out * 16 + (*in - '0');
> -            } else if ((*in >= 'a') && (*in <= 'f')) {
> -                *out = *out * 16 + (*in - 'a') + 10;
> -            } else if ((*in >= 'A') && (*in <= 'F')) {
> -                *out = *out * 16 + (*in - 'A') + 10;
> -            }
> -            in++;
> -            len -= 3;
> -            out++;
> -        } else {
> -            *out++ = *in++;
> -            len--;
> -        }
> -    }
> -    *out = 0;
> -    return ret;
> +    return g_uri_unescape_string(lstr, NULL);
>   }
>   
>   /**


Thank you.

Reviewed-by: Stefan Weil <sw@weilnetz.de>


--------------6YLkwTRtHQJAGBUQJcV7ph74
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Am 22.01.24 um 20:17 schrieb Thomas Huth:</p>
    <blockquote type="cite"
      cite="mid:20240122191753.103118-3-thuth@redhat.com">
      <pre class="moz-quote-pre" wrap="">uri_string_unescape() basically does the same as the glib function
g_uri_unescape_string(), with just an additional length parameter.
So we can simplify this function a lot by limiting the length with
g_strndup() first and then by calling g_uri_unescape_string() instead
of walking through the string manually.

Suggested-by: Stefan Weil <a class="moz-txt-link-rfc2396E" href="mailto:stefan.weil@weilnetz.de">&lt;stefan.weil@weilnetz.de&gt;</a></pre>
    </blockquote>
    <br>
    <p>Can my e-mail address be replaced by another one
      (<a class="moz-txt-link-abbreviated" href="mailto:sw@weilnetz.de">sw@weilnetz.de</a>)?<br>
    </p>
    <p><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite"
      cite="mid:20240122191753.103118-3-thuth@redhat.com">
      <pre class="moz-quote-pre" wrap="">Signed-off-by: Thomas Huth <a class="moz-txt-link-rfc2396E" href="mailto:thuth@redhat.com">&lt;thuth@redhat.com&gt;</a>
---
 util/uri.c | 49 +++----------------------------------------------
 1 file changed, 3 insertions(+), 46 deletions(-)

diff --git a/util/uri.c b/util/uri.c
index 33b6c7214e..2a75f535ba 100644
--- a/util/uri.c
+++ b/util/uri.c
@@ -1561,15 +1561,6 @@ done_cd:
     return 0;
 }
 
-static int is_hex(char c)
-{
-    if (((c &gt;= '0') &amp;&amp; (c &lt;= '9')) || ((c &gt;= 'a') &amp;&amp; (c &lt;= 'f')) ||
-        ((c &gt;= 'A') &amp;&amp; (c &lt;= 'F'))) {
-        return 1;
-    }
-    return 0;
-}
-
 /**
  * uri_string_unescape:
  * @str:  the string to unescape
@@ -1585,8 +1576,7 @@ static int is_hex(char c)
  */
 char *uri_string_unescape(const char *str, int len)
 {
-    char *ret, *out;
-    const char *in;
+    g_autofree char *lstr = NULL;</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Is it necessary to assign NULL? It does not look so.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20240122191753.103118-3-thuth@redhat.com">
      <pre class="moz-quote-pre" wrap="">
 
     if (str == NULL) {
         return NULL;
@@ -1594,42 +1584,9 @@ char *uri_string_unescape(const char *str, int len)
     if (len &lt;= 0) {
         len = strlen(str);
     }
-    if (len &lt; 0) {
-        return NULL;
-    }
-
-    ret = g_malloc(len + 1);
+    lstr = g_strndup(str, len);
 
-    in = str;
-    out = ret;
-    while (len &gt; 0) {
-        if ((len &gt; 2) &amp;&amp; (*in == '%') &amp;&amp; (is_hex(in[1])) &amp;&amp; (is_hex(in[2]))) {
-            in++;
-            if ((*in &gt;= '0') &amp;&amp; (*in &lt;= '9')) {
-                *out = (*in - '0');
-            } else if ((*in &gt;= 'a') &amp;&amp; (*in &lt;= 'f')) {
-                *out = (*in - 'a') + 10;
-            } else if ((*in &gt;= 'A') &amp;&amp; (*in &lt;= 'F')) {
-                *out = (*in - 'A') + 10;
-            }
-            in++;
-            if ((*in &gt;= '0') &amp;&amp; (*in &lt;= '9')) {
-                *out = *out * 16 + (*in - '0');
-            } else if ((*in &gt;= 'a') &amp;&amp; (*in &lt;= 'f')) {
-                *out = *out * 16 + (*in - 'a') + 10;
-            } else if ((*in &gt;= 'A') &amp;&amp; (*in &lt;= 'F')) {
-                *out = *out * 16 + (*in - 'A') + 10;
-            }
-            in++;
-            len -= 3;
-            out++;
-        } else {
-            *out++ = *in++;
-            len--;
-        }
-    }
-    *out = 0;
-    return ret;
+    return g_uri_unescape_string(lstr, NULL);
 }
 
 /**
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thank you.<br>
    </p>
    <p>Reviewed-by: Stefan Weil <a class="moz-txt-link-rfc2396E"
        href="mailto:sw@weilnetz.de">&lt;sw@weilnetz.de&gt;</a> <br>
    </p>
    <p><br>
    </p>
  </body>
</html>

--------------6YLkwTRtHQJAGBUQJcV7ph74--

