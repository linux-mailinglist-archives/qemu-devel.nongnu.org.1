Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BD67D2138
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:01:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRW0-0000RI-F8; Sun, 22 Oct 2023 02:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVu-0000HZ-C7
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRVs-0001Tk-20
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:00:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-27d3ede72f6so1933983a91.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954434; x=1698559234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzYqIAe/hPtmLAqL3h5jbLKf5tJAkAbl6Tgcozc9Vko=;
 b=lNIKAva6NiL/wpUSWNSFVUvZSO3R8SnrlhHsAo1eqzrMlqguLdVwciv3XR7QGzivrw
 Bceq00DtmqmZ6+6MiDqeg3inmsXK/sdb/fgi8YP1QCOKFfYdMm0vc0AoU3tIC1EF+4xj
 hSTxRdAVFtpMDvVLQpjhzC5MqO8D7c5/lme0FH+NeSsN2HqGIO+RiYSy8fjYpsxuDuzc
 9gM7XmBUp7rIbrpGLUVbg+nhZYriWzYXJE9FQKQrD7PwaEfeZHkvsdYPZvp8IfxePZoI
 jZ688Dr5ZOIXzZR0oPoM7Wcr7yqhAzp06QRSH8BmOLas+SlKoA+rI3O+NhFImtB73xz1
 mzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954434; x=1698559234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzYqIAe/hPtmLAqL3h5jbLKf5tJAkAbl6Tgcozc9Vko=;
 b=RNHtWJ5y/by8M4HR2udSE20h30Somv8ALEX6poVO3I9SQegKfGv1b+DMmz88ziQPy9
 YFW2yfuO4cT16duqMpstEp7b2vrJj8o+w2zbp3+/TqNvJ/GPnHOcAta2Fwa2yHdEgIgg
 iDz8lR+oCvFow4jlcpDx+yS32VF8RGFzrAupQ0vxjKmEYBj2fTmgMcVarAMB9dgseQAz
 7YXdObNJvH7eNBYkUwou3R5Xd49jCpIt8UvYB+wL7my/aowTH15gZolq9di1vxJR/Yx4
 AOq9sLGjUVtkiNQQljGPFP3/Lio3necUzkDAwL0Sombjm0O4iEnGnvkxVN7jCl+Xnxg+
 Um/g==
X-Gm-Message-State: AOJu0YzAmo8StKUqthWMRB+qfSivcnKJ4timbgX1/0Fy4m5XgAs+yjO0
 GjGPyJ55ertZo8Kq4zTNdbp0ZcO9sL0hzydYx2U=
X-Google-Smtp-Source: AGHT+IEQqsThyQzz/+XwF1fSpYPpFkmp9rdhQzdcxmk93pYP/Ea9maFo6Ij+yLtlcZVuE4/kgRwKEA==
X-Received: by 2002:a17:902:f0d5:b0:1ca:18a3:a49b with SMTP id
 v21-20020a170902f0d500b001ca18a3a49bmr5302287pla.37.1697954433978; 
 Sat, 21 Oct 2023 23:00:33 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 je17-20020a170903265100b001c728609574sm3999887plb.6.2023.10.21.23.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:00:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	qemu-stable@nongnu.org
Subject: [PATCH v4 01/90] target/sparc: Clear may_lookup for npc == DYNAMIC_PC
Date: Sat, 21 Oct 2023 22:59:02 -0700
Message-Id: <20231022060031.490251-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

With pairs of jmp+rett, pc == DYNAMIC_PC_LOOKUP and
npc == DYNAMIC_PC.  Make sure that we exit for interrupts.

Cc: qemu-stable@nongnu.org
Fixes: 633c42834c7 ("target/sparc: Introduce DYNAMIC_PC_LOOKUP")
Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f92ff80ac8..8fabed28fd 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5654,10 +5654,10 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         }
 
+        may_lookup = true;
         if (dc->pc & 3) {
             switch (dc->pc) {
             case DYNAMIC_PC_LOOKUP:
-                may_lookup = true;
                 break;
             case DYNAMIC_PC:
                 may_lookup = false;
@@ -5667,10 +5667,24 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             }
         } else {
             tcg_gen_movi_tl(cpu_pc, dc->pc);
-            may_lookup = true;
         }
 
-        save_npc(dc);
+        if (dc->npc & 3) {
+            switch (dc->npc) {
+            case JUMP_PC:
+                gen_generic_branch(dc);
+                break;
+            case DYNAMIC_PC:
+                may_lookup = false;
+                break;
+            case DYNAMIC_PC_LOOKUP:
+                break;
+            default:
+                g_assert_not_reached();
+            }
+        } else {
+            tcg_gen_movi_tl(cpu_npc, dc->npc);
+        }
         if (may_lookup) {
             tcg_gen_lookup_and_goto_ptr();
         } else {
-- 
2.34.1


