Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C75317E164E
	for <lists+qemu-devel@lfdr.de>; Sun,  5 Nov 2023 21:14:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzjU7-0003O0-6q; Sun, 05 Nov 2023 15:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU5-0003Ng-Tz
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:37 -0500
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qzjU3-00029h-Cw
 for qemu-devel@nongnu.org; Sun, 05 Nov 2023 15:12:37 -0500
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-581e5a9413bso2182917eaf.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 12:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699215154; x=1699819954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/NWt8/HhimxMcEILduOpW+WrJNp6qIGvrXM1RdrtRk=;
 b=OY2Db6rTciKYaJtAZzLVqvWKSfDnB4cCVlbLieJz2rRCa7555N0q7xLobUPmWBO6Kt
 gl2GJrJeVPZz+OHOFlU8Zva5Ea7J2ek20Odzu4QfX3NylTrZpvfEKgw7XG2qKELUQtfb
 1Ns/MwgAr6bLFGgtmmveUC9hQrZzr6SUORedFDmokcBIu49DfPS05Gq42GguW+KR8iqf
 50+q9M/bFtf1oRh+YDpw5g97ZSdWvaw9DOyG0MGqoEmAYQMhR14gbHtbcUBEg99GLvn8
 Fo0OvhaBG/1+ulP6tPiUYYEmhxnBCTu0JtDLgEYuRk4N5dI4/4Bgd2SVwXkY6v1CrKov
 OH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699215154; x=1699819954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q/NWt8/HhimxMcEILduOpW+WrJNp6qIGvrXM1RdrtRk=;
 b=LmzVf/p4xCvgwFrQxS657xz/kmK2cxrJiaG9ApXkXoRexOun+81NjULKiEDEQLRr6S
 xAzUL61t60iWJA/0F2phZcRX2Yn9zllX4IiiScshS2ItZ6hknWiG6wHQxqmf1kRTgO/a
 3baLIE4pSpxZ0Vf5avf9OFubjhd/COlUdKHh+YnOucipeY8DrCgVUwtGaUrIEE9VWczS
 CvX0bZK6Xfmp3f6AKwq/iS0+Xc5CSg3Bavx9FZUop6nyGanBmc1Q2wPxnEBByAsQwPG1
 yRWgr0sB/a2ZVcAemN3Od6c2F3CPrX47brSk6Rgl9y4V3d+h6eedr/w1AEgYleDQlp8t
 zFZg==
X-Gm-Message-State: AOJu0YzTUZlwUAzBx64/fAM8lg8j242raR6j0Hn5+NzyjbTTIeUWwnCL
 JzccKivJOQwDlI7E01uKA5a8LMPf3NKoEZT3s6w=
X-Google-Smtp-Source: AGHT+IEXFIfjmAwL9fpWfGMRrowI3+8Rl8kzBxE+zbE9hiXrATR8LfUcpw2YxS8eWhlgvFj/cZsS8A==
X-Received: by 2002:a54:4887:0:b0:3a8:6693:135d with SMTP id
 r7-20020a544887000000b003a86693135dmr28588957oic.49.1699215154141; 
 Sun, 05 Nov 2023 12:12:34 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u23-20020a056a00099700b006884549adc8sm4359777pfg.29.2023.11.05.12.12.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 12:12:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 12/21] target/sparc: Do flush_cond in advance_jump_cond
Date: Sun,  5 Nov 2023 12:12:13 -0800
Message-Id: <20231105201222.202395-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231105201222.202395-1-richard.henderson@linaro.org>
References: <20231105201222.202395-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Do this here instead of in each caller.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index dd6d43d1f1..2e7deb5e33 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2407,7 +2407,10 @@ static bool advance_jump_uncond_always(DisasContext *dc, bool annul,
 static bool advance_jump_cond(DisasContext *dc, DisasCompare *cmp,
                               bool annul, target_ulong dest)
 {
-    target_ulong npc = dc->npc;
+    target_ulong npc;
+
+    flush_cond(dc);
+    npc = dc->npc;
 
     if (annul) {
         TCGLabel *l1 = gen_new_label();
@@ -2481,8 +2484,6 @@ static bool do_bpcc(DisasContext *dc, arg_bcc *a)
     case 0x8:
         return advance_jump_uncond_always(dc, a->a, target);
     default:
-        flush_cond(dc);
-
         gen_compare(&cmp, a->cc, a->cond, dc);
         return advance_jump_cond(dc, &cmp, a->a, target);
     }
@@ -2505,8 +2506,6 @@ static bool do_fbpfcc(DisasContext *dc, arg_bcc *a)
     case 0x8:
         return advance_jump_uncond_always(dc, a->a, target);
     default:
-        flush_cond(dc);
-
         gen_fcompare(&cmp, a->cc, a->cond);
         return advance_jump_cond(dc, &cmp, a->a, target);
     }
@@ -2527,7 +2526,6 @@ static bool trans_BPr(DisasContext *dc, arg_BPr *a)
         return false;
     }
 
-    flush_cond(dc);
     gen_compare_reg(&cmp, a->cond, gen_load_gpr(dc, a->rs1));
     return advance_jump_cond(dc, &cmp, a->a, target);
 }
-- 
2.34.1


