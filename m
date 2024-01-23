Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2F5838BAC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 11:25:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSDxJ-0000Os-Ue; Tue, 23 Jan 2024 05:24:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxI-0000OW-GA
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:32 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSDxG-0004dE-S8
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 05:24:32 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bd9030d68fso2540432b6e.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 02:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706005469; x=1706610269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lU9aH7ZY0n7uAdgAxQsFLjxICAM1xx6kGJSgqsKuTsU=;
 b=ClHIIabe9jdBX5l1dancxndVv4tsnIyEYyZYA3k1CGaAIgAW2qn9MogGwmF0fKFXql
 xVcYPJkG4KdKKexqBRla63+E596FH9yDN0tc64ZBql0YDTbbUk5mTAcoPfwVryk8yWxa
 xVPfU7at+7+Va2gniicAaALyvKYMp97UORiCaNA+Zt8HKXhNDvoKrI2d4zovDrcs13tZ
 ticVaZp8e4BacTBqHqGgaOyDXOpBvPO2zrRR7sY2FvGnIT4fgq5OWTqlXDa2s15jNYAv
 tLiwVY97CioNCZqoxS5tdjeNDI37xi0wBclA5NHBVa8l8oecsMod1Xxb9Fjm/pCxL8sE
 46BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706005469; x=1706610269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lU9aH7ZY0n7uAdgAxQsFLjxICAM1xx6kGJSgqsKuTsU=;
 b=Yt9re4UhD1vwpSNhbdHYwDxeJft5o/0SYFviJhbrLiTsQroqQa03EpEd2IOF0BEjPE
 2EaXwKL6CA5DPBvEQVuG59JCkCpyzH6i52wWhXljmbsrkb0x765T24OocRdvWOi4ETiR
 836XxBBy6/H2YMs8JyNqheu/1dh3zQ8QvG1FXt6HKpNaUPohys+6Cnx5Ehh4iE6Buedj
 HJerSMdnCHz9CugjCbKAURt2HWTN2lY6W2rW/qdGxy00UmJQusELMxBixomMIczYl1jb
 sGdEkJHVeItHN8/vhfRDSifEwMR1EafCJK+1Crf3+Tv53ctzjs/GxZpE6UxnSv1PHti4
 RmhA==
X-Gm-Message-State: AOJu0YyDH8abRGImdI6x67hAuv+lFTsEL1ZkiV4I48BYMm7nFCT9U/Jx
 M0G43EWSVtCgeKxEvZxta0OTGpUazyIhVmgKXWvJEgRI88/jyiYWLk/wQMgSXCwUAqQiPkhqvhk
 v8Uo=
X-Google-Smtp-Source: AGHT+IGMv3XM0B+PZpvA1e6GdbfADmB4Z42FcPOZokGP+I0hzAU7gYDXgieyxcoP53uEosSAv5jiaA==
X-Received: by 2002:a05:6808:1b26:b0:3bd:c997:4c55 with SMTP id
 bx38-20020a0568081b2600b003bdc9974c55mr198701oib.11.1706005469621; 
 Tue, 23 Jan 2024 02:24:29 -0800 (PST)
Received: from stoup.lan
 (2001-44b8-2176-c800-b8a0-0408-58be-7d2e.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:b8a0:408:58be:7d2e])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a62f808000000b006d9ce7d3258sm11072408pfh.204.2024.01.23.02.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jan 2024 02:24:29 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL v2 4/8] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
Date: Tue, 23 Jan 2024 20:24:08 +1000
Message-Id: <20240123102412.4569-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123102412.4569-1-richard.henderson@linaro.org>
References: <20240123102412.4569-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

While the format names the second vector register 'v3',
it is still in the second position (bits 12-15) and
the argument to RXB must match.

Example error:
 -   e7 00 00 10 2a 33       verllf  %v16,%v0,16
 +   e7 00 00 10 2c 33       verllf  %v16,%v16,16

Cc: qemu-stable@nongnu.org
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: 22cb37b4172 ("tcg/s390x: Implement vector shift operations")
Fixes: 79cada8693d ("tcg/s390x: Implement tcg_out_dup*_vec")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2054
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240117213646.159697-2-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..7f6b84aa2c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -683,7 +683,7 @@ static void tcg_out_insn_VRIc(TCGContext *s, S390Opcode op,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
     tcg_out16(s, i2);
-    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRRa(TCGContext *s, S390Opcode op,
@@ -738,7 +738,7 @@ static void tcg_out_insn_VRSa(TCGContext *s, S390Opcode op, TCGReg v1,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
     tcg_out16(s, b2 << 12 | d2);
-    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRSb(TCGContext *s, S390Opcode op, TCGReg v1,
@@ -762,7 +762,7 @@ static void tcg_out_insn_VRSc(TCGContext *s, S390Opcode op, TCGReg r1,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | (r1 << 4) | (v3 & 0xf));
     tcg_out16(s, b2 << 12 | d2);
-    tcg_out16(s, (op & 0x00ff) | RXB(0, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(0, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRX(TCGContext *s, S390Opcode op, TCGReg v1,
-- 
2.34.1


