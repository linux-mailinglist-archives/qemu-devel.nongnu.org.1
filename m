Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF057D85DF
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 17:22:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw2AV-0007dl-1D; Thu, 26 Oct 2023 11:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AQ-0007Jx-40
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:21:02 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1qw2AM-0006PW-DG
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 11:21:01 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb85afef4so958034b3a.1
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 08:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1698333656; x=1698938456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtY6wohCh5Zl2XK1mCujzfBCcmKxx6U2AzlGqef/2aU=;
 b=FnRcBw0MmcCS0YTBUywxK1eusYb2ZmUOLeqbJUCGcLVgHS9jT3EJoZhT3TmSprDY37
 wG09aZOhGcygZjQg2f3w8rCSW887fnvc1Cv0SDvNdub5v+ljrpKWANTbJqbdjVHXwoJP
 qOhtiUA3Oy1oE+9aVsy82jG2WR+r6pqQCIBPKNzWX+uRY87uvWANcOGFUSGiYhNytrYL
 cKB2KilOE85q3xwy3SkEo8YDQ20M3Vc3zCMMC4qUVwoYoft6/upMgYtIHs3sta/iDjtE
 RZO4TKvF+ZDiXnvX/irqW805Ad6kumTk2+PdB+xrE2qK0EmW4zeadLGO1OBp6+fK/tHM
 TIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698333656; x=1698938456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HtY6wohCh5Zl2XK1mCujzfBCcmKxx6U2AzlGqef/2aU=;
 b=sy8xWX3qe+zz6JlMaC+VC+ivfLBneXXX7XeXuBnF+Euq5jApU/J0DMqZZA6+fW3t59
 wYEehfSpFIVFxJ2Vu82o+YJUPMfJRpl+jM3bA5u41TEap2QnCc7zSsN9+YXy/MT3BxvD
 G6gxWQNAaTR2URnF0bv6hIFCfBiFPISlVQbrT/TIGY9NRdNKqyfhm9ofDzNDMgf9tQ8c
 AEEl8gmrLqqSrWtCMBLu/KPLVGg5YE1XQz1XX48ebgqVbKI+HkAmAL2VTvzf9VCAE8f1
 IZBlK7eQRTW4ORRxV31SaMnU2Px09UDtu1DjU1q72gxpRS5DkSo0QiXO7fFo2LC/7BeL
 /bKQ==
X-Gm-Message-State: AOJu0YyT3twVOM6rObH8KvgLieNeWDe+GjAp8M+Qk8H5HKCp6WREdbSV
 u43m4Mgc5H4Qe01n4PveCgFDDSGsB2XlVwdviVtu8kj9pH4h6w9r7ShLG4f4pMUCucbGCbE1dxk
 EDeQn54EfJ44+itmmOyK0IdKxRrwIl2lNkBkwuLgu4e28WH3Hu9REaklGEhquIbQTqHUFpPfoq6
 1C
X-Google-Smtp-Source: AGHT+IFd6tsrH6go7h2GP8FBCDsaK3ioItIUXlfcC7gc+P0xKIq2B0rZAZeJs3Mx6moSop/o+Ia8+g==
X-Received: by 2002:a17:90b:398:b0:27d:1df4:26f3 with SMTP id
 ga24-20020a17090b039800b0027d1df426f3mr16447005pjb.15.1698333655811; 
 Thu, 26 Oct 2023 08:20:55 -0700 (PDT)
Received: from duncan.localdomain (125-228-20-175.hinet-ip.hinet.net.
 [125.228.20.175]) by smtp.gmail.com with ESMTPSA id
 nv18-20020a17090b1b5200b0027fee011cebsm1326061pjb.10.2023.10.26.08.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 08:20:55 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Max Chou <max.chou@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH v2 12/14] disas/riscv: Add rv_codec_vror_vi for vror.vi
Date: Thu, 26 Oct 2023 23:18:19 +0800
Message-Id: <20231026151828.754279-13-max.chou@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026151828.754279-1-max.chou@sifive.com>
References: <20231026151828.754279-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x434.google.com
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

Add rv_codec_vror_vi for the vector crypto instruction - vror.vi.
The rotate amount of vror.vi is defined by combining seperated bits.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 disas/riscv.c | 14 +++++++++++++-
 disas/riscv.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 8e89e1d1157..ec33e447f5b 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -4011,6 +4011,12 @@ static uint32_t operand_vzimm10(rv_inst inst)
     return (inst << 34) >> 54;
 }
 
+static uint32_t operand_vzimm6(rv_inst inst)
+{
+    return ((inst << 37) >> 63) << 5 |
+        ((inst << 44) >> 59);
+}
+
 static uint32_t operand_bs(rv_inst inst)
 {
     return (inst << 32) >> 62;
@@ -4393,6 +4399,12 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->imm = operand_vimm(inst);
         dec->vm = operand_vm(inst);
         break;
+    case rv_codec_vror_vi:
+        dec->rd = operand_rd(inst);
+        dec->rs2 = operand_rs2(inst);
+        dec->imm = operand_vzimm6(inst);
+        dec->vm = operand_vm(inst);
+        break;
     case rv_codec_vsetvli:
         dec->rd = operand_rd(inst);
         dec->rs1 = operand_rs1(inst);
@@ -4677,7 +4689,7 @@ static void format_inst(char *buf, size_t buflen, size_t tab, rv_decode *dec)
             append(buf, tmp, buflen);
             break;
         case 'u':
-            snprintf(tmp, sizeof(tmp), "%u", ((uint32_t)dec->imm & 0b11111));
+            snprintf(tmp, sizeof(tmp), "%u", ((uint32_t)dec->imm & 0b111111));
             append(buf, tmp, buflen);
             break;
         case 'j':
diff --git a/disas/riscv.h b/disas/riscv.h
index b242d73b25e..19e5ed2ce63 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -152,6 +152,7 @@ typedef enum {
     rv_codec_v_i,
     rv_codec_vsetvli,
     rv_codec_vsetivli,
+    rv_codec_vror_vi,
     rv_codec_zcb_ext,
     rv_codec_zcb_mul,
     rv_codec_zcb_lb,
-- 
2.34.1


