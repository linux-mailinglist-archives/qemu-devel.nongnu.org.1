Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B0F7B7018
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:42:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjIh-0000Kz-Hr; Tue, 03 Oct 2023 13:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIL-0000Cq-3H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:54 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjIE-0007td-Hq
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:34:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bf55a81eeaso9455355ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354485; x=1696959285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iHAgjLxRSILFNC2pEep3xi2eIcOstWehORC+CAofXOs=;
 b=lDtrZZjvk1BxEG2jwnCMDq3KAwCbAqTrW/sNIHaqpfFiQu8Q0jIz51zWWMwDbngiLl
 3kTdYCU60ioXv5cwkN0W5cgF75cI52ieVb7jmOuc/B/g26+1//W2NZ2yj2jUwbMEHgpS
 Gd2N9vV/wsoo6xfZja1L2BJdtssVyyXsQw6ryzAxb35NQeuabxJVMBBHxYIpHdNcFJoy
 40p1gzguxRnaciJgwkuhUbXa3fe3O866zLkXYZszQc+9Xd59aCll9iyBznsh98Sy/JAe
 1k5+vDEZrediIwfxzAAGQ7nbg+sf6v2fOqawsOdg4TcA6Y360rDR7JGwfN6aecLzJ29m
 YIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354485; x=1696959285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iHAgjLxRSILFNC2pEep3xi2eIcOstWehORC+CAofXOs=;
 b=wv4Svqc5bQkOYyKNiVVVtcd+u6hNuxKJ5GuC5/meNgDrcvsnExq24RmUk4A0Li3JCb
 b3oPx4xFwzJ+OIhVSchGbys5wOjTZLh9M1pp7XZAIVdCA8bKPo0zMDFpJGZjQJpd4sk0
 X/TMRAJRJKmBaG9kelRzvNXXBA8omw2KpVqpSJflJiKkb8zvOVNWZMnFOzcUnQvTOOro
 vhbK3lO3ZiThYDqlKvBNHNozSsnlajNpzTNgliebEdedX5os5uWg2rNuE5OQ/sf5vhEa
 RoiRv1JO80w21o2QAWr2FL40vY6TiQqLDYvGIq06o+U9YibXLRaJUzbJh+Zp56BJTlTd
 /17w==
X-Gm-Message-State: AOJu0Yzj3gZWqiPSqMgK+BjtQEmEpGDTRbmafT2CSwiI9SvtkB9zoRBd
 +TlVsoGjbq1C9izladXEPzPyn8XSaFBQU8CmHUc=
X-Google-Smtp-Source: AGHT+IGM0KbB9qSVjJoc34wF4Fz7NRyMAVYWUDpFAG1sJGPiGMR3pmrM/thl6yJ0a/vRfjFiRR9zcw==
X-Received: by 2002:a17:902:ec85:b0:1c4:749e:e725 with SMTP id
 x5-20020a170902ec8500b001c4749ee725mr334519plg.0.1696354485132; 
 Tue, 03 Oct 2023 10:34:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 y9-20020a17090322c900b001bc676df6a9sm1855118plg.132.2023.10.03.10.34.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:34:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: gaosong <gaosong@loongson.cn>
Subject: [PULL 47/47] tcg/loongarch64: Fix buid error
Date: Tue,  3 Oct 2023 10:30:52 -0700
Message-Id: <20231003173052.1601813-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: gaosong <gaosong@loongson.cn>

Fix:

  In file included from ../tcg/tcg.c:735:
  /home1/gaosong/bugfix/qemu/tcg/loongarch64/tcg-target.c.inc: In function ‘tcg_out_vec_op’:
  /home1/gaosong/bugfix/qemu/tcg/loongarch64/tcg-target.c.inc:1855:9: error: a label can only be part of a statement and a declaration is not a statement
           TCGCond cond = args[3];
           ^~~~~~~

Signed-off-by: gaosong <gaosong@loongson.cn>
Message-Id: <20230926075819.3602537-1-gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.c.inc | 68 ++++++++++++++++----------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index b701df50db..8f7091002b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -1852,43 +1852,45 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         tcg_out_opc_vnor_v(s, a0, a1, a1);
         break;
     case INDEX_op_cmp_vec:
-        TCGCond cond = args[3];
-        if (const_args[2]) {
-            /*
-             * cmp_vec dest, src, value
-             * Try vseqi/vslei/vslti
-             */
-            int64_t value = sextract64(a2, 0, 8 << vece);
-            if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
-                 cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
-                tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
-                                                 a0, a1, value));
-                break;
-            } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
-                (0x00 <= value && value <= 0x1f)) {
-                tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
-                                                 a0, a1, value));
-                break;
+        {
+            TCGCond cond = args[3];
+            if (const_args[2]) {
+                /*
+                 * cmp_vec dest, src, value
+                 * Try vseqi/vslei/vslti
+                 */
+                int64_t value = sextract64(a2, 0, 8 << vece);
+                if ((cond == TCG_COND_EQ || cond == TCG_COND_LE || \
+                     cond == TCG_COND_LT) && (-0x10 <= value && value <= 0x0f)) {
+                    tcg_out32(s, encode_vdvjsk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                     a0, a1, value));
+                    break;
+                } else if ((cond == TCG_COND_LEU || cond == TCG_COND_LTU) &&
+                    (0x00 <= value && value <= 0x1f)) {
+                    tcg_out32(s, encode_vdvjuk5_insn(cmp_vec_imm_insn[cond][vece], \
+                                                     a0, a1, value));
+                    break;
+                }
+
+                /*
+                 * Fallback to:
+                 * dupi_vec temp, a2
+                 * cmp_vec a0, a1, temp, cond
+                 */
+                tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
+                a2 = temp_vec;
             }
 
-            /*
-             * Fallback to:
-             * dupi_vec temp, a2
-             * cmp_vec a0, a1, temp, cond
-             */
-            tcg_out_dupi_vec(s, type, vece, temp_vec, a2);
-            a2 = temp_vec;
-        }
-
-        insn = cmp_vec_insn[cond][vece];
-        if (insn == 0) {
-            TCGArg t;
-            t = a1, a1 = a2, a2 = t;
-            cond = tcg_swap_cond(cond);
             insn = cmp_vec_insn[cond][vece];
-            tcg_debug_assert(insn != 0);
+            if (insn == 0) {
+                TCGArg t;
+                t = a1, a1 = a2, a2 = t;
+                cond = tcg_swap_cond(cond);
+                insn = cmp_vec_insn[cond][vece];
+                tcg_debug_assert(insn != 0);
+            }
+            tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         }
-        tcg_out32(s, encode_vdvjvk_insn(insn, a0, a1, a2));
         break;
     case INDEX_op_add_vec:
         tcg_out_addsub_vec(s, vece, a0, a1, a2, const_args[2], true);
-- 
2.34.1


