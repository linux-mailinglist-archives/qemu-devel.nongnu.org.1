Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB2A7C80D8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpe-0007U7-Mj; Fri, 13 Oct 2023 04:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpV-0007Iu-Qn
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:33 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpR-0000lE-2d
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:31 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso1786002f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186841; x=1697791641; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=im2O2dvrIf4MNaQHeEt9gfy6fXkfAQn7GmVj1wsEI/0=;
 b=UwhrGjc5+dR70TxzdemvZ+EV9r9E9izqVwY0dj7HcpFyvnUTziuEOup7mXni/946jR
 uHtNPiX9uthVRlEoVVGnIUJnrEh27uWmKguALWRIPWVXAA+zEsv4Eyxo92rf/tNiOixs
 1qowAcevDFCxZlUQ4UP4XROFCQYXWBeLGNOPnxaYSs58g7CMPVUOHkZVDQaxIZCl+6UE
 QSWSF1ooQ1c/fbVdv0VujZGUoYRY/KcvBmNJhf6G+/NW4Pr9wJduGRnf3A2wymo2NpaO
 5PueRofqaugdTMyjIIa4QOR7QhjQYlYLynRqo03mXNwfaBJDYUABqChFM/WKAam/KXx0
 L9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186841; x=1697791641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=im2O2dvrIf4MNaQHeEt9gfy6fXkfAQn7GmVj1wsEI/0=;
 b=f+/R3BJy+BmUm3RkIn0QAKuGxAkrptJ0B+LFL2T0I+4/LtXqrqn8JtHj+2NF4Twk/F
 LAZ4KIbeEZ8hSFjh02dYT9xOg4Sl6EwBBAeuY//Yp90VMC3yDggFVZL60Z2f/SYQviKj
 VD5fSc0FG/N1s4AiUQJWkQDJkapT3GMNvW56l4pqAKXizPBTBOaE03YDVJ0jmGs7vN6W
 YRIWK4BUkiheD4+qE9zncxbavLlDmYxbg16bsG1QNz1lyuZ9KlNj0ZVo1k5DNkqzbzhl
 dPv/Cs3VGsucw6gDaVqzermvCCmtGuMAC+ftsundgTHtIcfUAqOC3D4J3iuOq9Z0C3so
 UQaA==
X-Gm-Message-State: AOJu0YzZN24iJtsuomJh5k6kclSQ4e3a3JTaEeb+18UdMMDXTsIiNjyf
 9+xmbWHKn+bm1oHP5nNFU2r9CUAY+YwXEiV1zfg=
X-Google-Smtp-Source: AGHT+IHiP+h+boDQf6XbcBwNRi2ZUb+PteVk50eBBGiSTqOnH9ixIKhHEm+kaJs+ajYEhm1aAC5fOg==
X-Received: by 2002:adf:ef42:0:b0:32d:9d3d:8b98 with SMTP id
 c2-20020adfef42000000b0032d9d3d8b98mr734422wrp.71.1697186841379; 
 Fri, 13 Oct 2023 01:47:21 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:20 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH v3 05/78] qobject/json: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:33 +0300
Message-Id: <9425bbfc5ff333a6c476c5e01f08077d7821897a.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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
@@ -312,7 +312,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
         case JSON_STRING:
             json_message_process_token(lexer, lexer->token, new_state,
                                        lexer->x, lexer->y);
-            /* fall through */
+            fallthrough;
         case IN_START:
             g_string_truncate(lexer->token, 0);
             new_state = lexer->start_state;
@@ -321,7 +321,7 @@ static void json_lexer_feed_char(JSONLexer *lexer, char ch, bool flush)
             json_message_process_token(lexer, lexer->token, JSON_ERROR,
                                        lexer->x, lexer->y);
             new_state = IN_RECOVERY;
-            /* fall through */
+            fallthrough;
         case IN_RECOVERY:
             g_string_truncate(lexer->token, 0);
             break;
diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index d498db6e70..4dc622dcc9 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -214,7 +214,7 @@ static QString *parse_string(JSONParserContext *ctxt, JSONToken *token)
                 }
                 ptr++;
             }
-            /* fall through */
+            fallthrough;
         default:
             cp = mod_utf8_codepoint(ptr, 6, &end);
             if (cp < 0) {
@@ -518,8 +518,9 @@ static QObject *parse_literal(JSONParserContext *ctxt)
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
-- 
2.39.2


