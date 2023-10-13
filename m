Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC817C7F04
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:54:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCw2-0004JH-MJ; Fri, 13 Oct 2023 03:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvx-0004Fy-PO
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvi-000462-WD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:02 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3231dff4343so1133325f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183393; x=1697788193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRSE8Uc0Qfl3ZRKEWagbHPFVdOsv1ON14ZcL2G49NJI=;
 b=CH2KRbENYkVyjcHLj82p1L6FAukMzQStYzCZ/MCfHk3pCimt++sxbTmIJ3DDmHmBDa
 PvyS7dq61kD1b816boAku/5se82oP0fawajU1Frjb/oM7n8OkZ9UVHLr3kKmXDG37UAI
 rPAIxlBWOGw9VgNjdHa9yFgHJaWV14whSMgSqHXJiFA9RrIi6vEYIijp26IEF2+6Dk2g
 KabqQ0gkiHLL6TSUxcASjqAd8IL6EzrhyKUy62wxOn8AObqaOjr6Bbk6OOBzajj4yMUK
 U6wXb5+VYb8AurBNZ7N1DwPTMvH61WEJmBzWqPX4T1WBrfIYB01LVp8xST6VTtPC6SUu
 pu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183393; x=1697788193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRSE8Uc0Qfl3ZRKEWagbHPFVdOsv1ON14ZcL2G49NJI=;
 b=ZxTR6k1w6DnvcDOx4oYnCxfeA89b+lBH0SUW7Mzx+7DL/4GG0710lGlpdA85Hpe0/Q
 PgdTrxkjv3S1O4opUNaY8qsNHj2F412oYngx9w+uSsqA1z56bwtV6wYAx6SHxEJAOCnq
 D796ZG9v8xSqcom3Btbd8oxZn5qf8bV1c0L1TVKLQ7Op+1Oa+kZ77dbxefgdSUwpvMz7
 RuOugz9STocv2OzsrgUsCPwzUczsJa0Ijdz7JbrEj8JC5nD8qdQqm5weppakgAZRL/rr
 HVTGzXSIczLaYRRQZwAX2y8E85Kvv+SG0AZHN+Dhglo2ZUn3as7OyqquNiWg5ytILQbE
 1YMw==
X-Gm-Message-State: AOJu0Yx4FRabBoNiRwqYLO5KyZAVmdGpEOwRNlH4l7AisBcQ58+DBy2z
 AzcS9hEl9DQnwXtITOPgTeaxkYcxhytw/AkSMeY=
X-Google-Smtp-Source: AGHT+IFG8AQCSw/hUIS/ssyhdSaTnsexnH58M/1iEWfmXorJbUAVm8RFTbmI+62rAl2qRV673jDJmQ==
X-Received: by 2002:adf:e749:0:b0:32d:888d:7598 with SMTP id
 c9-20020adfe749000000b0032d888d7598mr5765502wrn.4.1697183393382; 
 Fri, 13 Oct 2023 00:49:53 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:49:52 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH 05/78] qobject/json: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:09 +0300
Message-Id: <9425bbfc5ff333a6c476c5e01f08077d7821897a.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


