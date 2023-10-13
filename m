Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AEE7C7FBD
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3l-00076W-1N; Fri, 13 Oct 2023 03:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3i-0006w0-17
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:10 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3e-0006jH-J0
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:09 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5043a01ee20so2338524e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183884; x=1697788684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRSE8Uc0Qfl3ZRKEWagbHPFVdOsv1ON14ZcL2G49NJI=;
 b=u904/AMb0ZH1/NvT1nOCbiVUoFNivQ8uj6wXyQt0pPhvIXIMW6ks9BFpQzhmSe3l0z
 PVN5uzKk1b1Kva31aK/LbyjHxZd5D3mg8K+5ymXtl5eieJsnASQlwN2CKKr1Pk6adL3z
 o5+XWGF6mLalIMXRn7BJ7OfmyRpR6QaZYX+OixXMUiJaI56MXRy9ElBG6AoAy89gneBC
 H18RmDT1ziCwVWgsnm4mZ568oHITMiuqwML+ehVG7It547fsU2TZP5AK0+95ZzbOdVcK
 PK1MmI+MqJ5vNULJCpxe6fuv95TdKZVv0u+zObxdeVg/EoDmahDFkIG49d4Szs+sNz7Y
 yH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183884; x=1697788684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRSE8Uc0Qfl3ZRKEWagbHPFVdOsv1ON14ZcL2G49NJI=;
 b=hpNTNxUegkojXMHZlD1xxeglGYln94rbjMrY+BpG2aim6GHe9LYSgvHjoikvoQvJM3
 pIAHM4JbdT2HrHPIqWoR32lTJ+NFqO47PMxvIYZazLKTYUdi5iwC/wHlSzEVj8pSlao1
 fsSUTnNXX2hAhqJTpifSnXNTNKXnNEzCeTKdWGEiCvky/oni0AqBFviOa57eq5wxQtxl
 KE4wwvwzMIPuPE450JcEi8PVT5xJ/T2DxNk1R4Reu8a9k60wlFZSKqyNKqiBzePZzXd1
 l6z+VyXbqJHxJDihMKHbJR7/ktJOAiSqnD3QtXNGZgOu73eIq4yhBDLjE+uILtnavbks
 lSow==
X-Gm-Message-State: AOJu0Yx96BeqhQJbOaE5cTwhNbYGN6wPkLgQUTrFAI8ibaN2GKa1y5xC
 89LvAuclfudrLODDNnCRrRnijNYJBPy5e6GMgMg=
X-Google-Smtp-Source: AGHT+IHXnllyvG6VWJ7X4/StDcNfsg3UzZt8insBoWkDzMeUNYjALvheCr6uzb5OVHagHN2uFZmQVw==
X-Received: by 2002:a05:6512:3494:b0:500:c348:7efd with SMTP id
 v20-20020a056512349400b00500c3487efdmr21172366lfr.59.1697183884550; 
 Fri, 13 Oct 2023 00:58:04 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:04 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v2 05/78] qobject/json: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:32 +0300
Message-Id: <9425bbfc5ff333a6c476c5e01f08077d7821897a.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qobject/json-lexer.c  | 4 ++--
 qobject/json-parser.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/qobject/json-lexer.c b/qobject/json-lexer.c
index 51341d96e4..ab74470ac6 100644
--- a/qobject/json-lexer.c
+++ b/qobject/json-lexer.c
@@ -283,61 +283,61 @@ void json_lexer_init(JSONLexer *lexer, bool enable_interpolation)
 static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
 {
     int new_state;
     bool char_consumed = false;
 
     lexer->x++;
     if (ch == '\n') {
         lexer->x = 0;
         lexer->y++;
     }
 
     while (flush ? lexer->state != lexer->start_state : !char_consumed) {
         new_state = next_state(lexer, ch, flush, &char_consumed);
         if (char_consumed) {
             assert(!flush);
             g_string_append_c(lexer->token, ch);
         }
 
         switch (new_state) {
         case JSON_LCURLY:
         case JSON_RCURLY:
         case JSON_LSQUARE:
         case JSON_RSQUARE:
         case JSON_COLON:
         case JSON_COMMA:
         case JSON_INTERP:
         case JSON_INTEGER:
         case JSON_FLOAT:
         case JSON_KEYWORD:
         case JSON_STRING:
             json_message_process_token(lexer, lexer->token, new_state,
                                        lexer->x, lexer->y);
-            /* fall through */
+            fallthrough;
         case IN_START:
             g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
             break;
         case JSON_ERROR:
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
             new_state = IN_RECOVERY;
-            /* fall through */
+            fallthrough;
         case IN_RECOVERY:
             g_string_truncate(lexer->token, 0);
             break;
         default:
             break;
         }
         lexer->state = new_state;
     }
 
     /* Do not let a single token grow to an arbitrarily large size,
      * this is a security consideration.
      */
     if (lexer->token->len > MAX_TOKEN_SIZE) {
         json_message_process_token(lexer, lexer->token, lexer->state,
                                    lexer->x, lexer->y);
         g_string_truncate(lexer->token, 0);
         lexer->state = lexer->start_state;
     }
 }
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d498db6e70..4dc622dcc9 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -95,137 +95,137 @@ static int cvt4hex(const char *s)
 /**
  * parse_string(): Parse a JSON string
  *
  * From RFC 8259 "The JavaScript Object Notation (JSON) Data
  * Interchange Format":
  *
  *    char = unescaped /
  *        escape (
  *            %x22 /          ; "    quotation mark  U+0022
  *            %x5C /          ; \    reverse solidus U+005C
  *            %x2F /          ; /    solidus         U+002F
  *            %x62 /          ; b    backspace       U+0008
  *            %x66 /          ; f    form feed       U+000C
  *            %x6E /          ; n    line feed       U+000A
  *            %x72 /          ; r    carriage return U+000D
  *            %x74 /          ; t    tab             U+0009
  *            %x75 4HEXDIG )  ; uXXXX                U+XXXX
  *    escape = %x5C              ; \
  *    quotation-mark = %x22      ; "
  *    unescaped = %x20-21 / %x23-5B / %x5D-10FFFF
  *
  * Extensions over RFC 8259:
  * - Extra escape sequence in strings:
  *   0x27 (apostrophe) is recognized after escape, too
  * - Single-quoted strings:
  *   Like double-quoted strings, except they're delimited by %x27
  *   (apostrophe) instead of %x22 (quotation mark), and can't contain
  *   unescaped apostrophe, but can contain unescaped quotation mark.
  *
  * Note:
  * - Encoding is modified UTF-8.
  * - Invalid Unicode characters are rejected.
  * - Control characters \x00..\x1F are rejected by the lexer.
  */
 static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
 {
     const char *ptr = token->str;
     GString *str;
     char quote;
     const char *beg;
     int cp, trailing;
     char *end;
     ssize_t len;
     char utf8_buf[5];
 
     assert(*ptr == '"' || *ptr == '\'');
     quote = *ptr++;
     str = g_string_new(NULL);
 
     while (*ptr != quote) {
         assert(*ptr);
         switch (*ptr) {
         case '\\':
             beg = ptr++;
             switch (*ptr++) {
             case '"':
                 g_string_append_c(str, '"');
                 break;
             case '\'':
                 g_string_append_c(str, '\'');
                 break;
             case '\\':
                 g_string_append_c(str, '\\');
                 break;
             case '/':
                 g_string_append_c(str, '/');
                 break;
             case 'b':
                 g_string_append_c(str, '\b');
                 break;
             case 'f':
                 g_string_append_c(str, '\f');
                 break;
             case 'n':
                 g_string_append_c(str, '\n');
                 break;
             case 'r':
                 g_string_append_c(str, '\r');
                 break;
             case 't':
                 g_string_append_c(str, '\t');
                 break;
             case 'u':
                 cp = cvt4hex(ptr);
                 ptr += 4;
 
                 /* handle surrogate pairs */
                 if (cp >= 0xD800 && cp <= 0xDBFF
                     && ptr[0] == '\\' && ptr[1] == 'u') {
                     /* leading surrogate followed by \u */
                     cp = 0x10000 + ((cp & 0x3FF) << 10);
                     trailing = cvt4hex(ptr + 2);
                     if (trailing >= 0xDC00 && trailing <= 0xDFFF) {
                         /* followed by trailing surrogate */
                         cp |= trailing & 0x3FF;
                         ptr += 6;
                     } else {
                         cp = -1; /* invalid */
                     }
                 }
 
                 if (mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp) < 0) {
                     parse_error(ctxt, token,
                                 "%.*s is not a valid Unicode character",
                                 (int)(ptr - beg), beg);
                     goto out;
                 }
                 g_string_append(str, utf8_buf);
                 break;
             default:
                 parse_error(ctxt, token, "invalid escape sequence in string");
                 goto out;
             }
             break;
         case '%':
             if (ctxt->ap) {
                 if (ptr[1] != '%') {
                     parse_error(ctxt, token, "can't interpolate into string");
                     goto out;
                 }
                 ptr++;
             }
-            /* fall through */
+            fallthrough;
         default:
             cp = mod_utf8_codepoint(ptr, 6, &end);
             if (cp < 0) {
                 parse_error(ctxt, token, "invalid UTF-8 sequence in string");
                 goto out;
             }
             ptr = end;
             len = mod_utf8_encode(utf8_buf, sizeof(utf8_buf), cp);
             assert(len >= 0);
             g_string_append(str, utf8_buf);
         }
     }
 
     return qstring_from_gstring(str);
@@ -481,51 +481,52 @@ static QObject *parse_interpolation(JSONParserContext *ctxt)
 static QObject *parse_literal(JSONParserContext *ctxt)
 {
     JSONToken *token;
 
     token = parser_context_pop_token(ctxt);
     assert(token);
 
     switch (token->type) {
     case JSON_STRING:
         return QOBJECT(parse_string(ctxt, token));
     case JSON_INTEGER: {
         /*
          * Represent JSON_INTEGER as QNUM_I64 if possible, else as
          * QNUM_U64, else as QNUM_DOUBLE.  Note that qemu_strtoi64()
          * and qemu_strtou64() fail with ERANGE when it's not
          * possible.
          *
          * qnum_get_int() will then work for any signed 64-bit
          * JSON_INTEGER, qnum_get_uint() for any unsigned 64-bit
          * integer, and qnum_get_double() both for any JSON_INTEGER
          * and any JSON_FLOAT (with precision loss for integers beyond
          * 53 bits)
          */
         int ret;
         int64_t value;
         uint64_t uvalue;
 
         ret = qemu_strtoi64(token->str, NULL, 10, &value);
         if (!ret) {
             return QOBJECT(qnum_from_int(value));
         }
         assert(ret == -ERANGE);
 
         if (token->str[0] != '-') {
             ret = qemu_strtou64(token->str, NULL, 10, &uvalue);
             if (!ret) {
                 return QOBJECT(qnum_from_uint(uvalue));
             }
             assert(ret == -ERANGE);
         }
+        /* fall through to JSON_FLOAT */
+        fallthrough;
     }
-    /* fall through to JSON_FLOAT */
     case JSON_FLOAT:
         /* FIXME dependent on locale; a pervasive issue in QEMU */
         /* FIXME our lexer matches RFC 8259 in forbidding Inf or NaN,
          * but those might be useful extensions beyond JSON */
         return QOBJECT(qnum_from_double(strtod(token->str, NULL)));
     default:
         abort();
     }
 }
-- 
2.39.2


