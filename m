Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8630C728DD6
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 04:26:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7RnX-0002ZX-Dy; Thu, 08 Jun 2023 22:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnU-0002Xk-A4
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:16 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q7RnO-0005Yf-C2
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 22:24:16 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-651f2f38634so1298697b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686277448; x=1688869448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jYzak3aoTqyaCXFBe98vT/JIGFhQ55/+8K/T/AYz14=;
 b=lYON2gt/8/s18kMboMGRrBdbqPe5yOavlah+MRqAbyXMqfWPxcwwfN5+iDWS4Wu2+c
 Ok9GHz6rbz2qOjHBAQRp1FsxMPuRKZFKa+BD/78e7ey7bTEhVD1Z7u0VvQy/6UGQDrXh
 xAJbElBFt8rbQ0vepyYc+nZMYi2cCghN7Dsv7hSqeZj6jtELfQnFq9EcYhZXD79tCDiJ
 Ozn0vimw16ogs3zucnD6AiASFuKJq2pxYaAwneUENFVV+l4zvZDW289bOERiLrYjUmP/
 uzV+GT1rYv6yheT+lVaa9EgsTWpEInHRzOjsiue8VtMBAHjvXxyuCl0+GrOiYo8DT8YJ
 nZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686277448; x=1688869448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5jYzak3aoTqyaCXFBe98vT/JIGFhQ55/+8K/T/AYz14=;
 b=LCWh4C+A2Shj/mkI7oVFzhizfsXu2fkiQzF2nxhmWDu+dqfuc00Ok/WWMOYVTDtPzy
 UlqDnpdEMtAfx9pJbv3alV/FKo9E1WuQQAqBShrgjNjA2ZdG0yuOifRYW8vfZsMAypSX
 X3DhMl8GehJ28496U/uhFZBjT1HRIpaSVeP1zB6jAD42kINGphx9wqoz4JIENDA2QFkn
 wKWaWtLw8oDkpms3HkALNhA6My2UqPk1FixyK8S5s26Ly64ybjNRUm+H20LDrsNMOlbe
 flSt8clUITEQBtUuHrEdUFmWrZKMUfcGCzmQmWDySMBN9ffVE2LAutb64riFmp9AS5O0
 KEHg==
X-Gm-Message-State: AC+VfDzZzbHwOA/Kb0i2iBczwDWBiEBPIFrVpcxNlMMidwj5BhjTaRGr
 tl8JRMKVrYJ17A+ImfuMHQC4iTiBCg7cbhmG5Es=
X-Google-Smtp-Source: ACHHUZ4XGZrKsAbm2Z9BjgF7j1gZqvpJF7TzF8Qoz8VU0P47Q98ANsEmfPpojHs4i1BRg6fy1eV2Mg==
X-Received: by 2002:a05:6a20:244d:b0:10a:e9ff:808d with SMTP id
 t13-20020a056a20244d00b0010ae9ff808dmr153071pzc.0.1686277447995; 
 Thu, 08 Jun 2023 19:24:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b071:df63:5761:f449])
 by smtp.gmail.com with ESMTPSA id
 x25-20020a62fb19000000b0063afb08afeesm1686458pfm.67.2023.06.08.19.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 19:24:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 05/38] crypto/aes: Add constants for ShiftRows, InvShiftRows
Date: Thu,  8 Jun 2023 19:23:28 -0700
Message-Id: <20230609022401.684157-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609022401.684157-1-richard.henderson@linaro.org>
References: <20230609022401.684157-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

These symbols will avoid the indirection through memory
when fully unrolling some new primitives.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/aes.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 67bb74b8e3..cdf937883d 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -108,12 +108,58 @@ const uint8_t AES_isbox[256] = {
     0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D,
 };
 
+/* AES ShiftRows, for complete unrolling. */
+enum {
+    AES_SH_0 = 0x0,
+    AES_SH_1 = 0x5,
+    AES_SH_2 = 0xa,
+    AES_SH_3 = 0xf,
+    AES_SH_4 = 0x4,
+    AES_SH_5 = 0x9,
+    AES_SH_6 = 0xe,
+    AES_SH_7 = 0x3,
+    AES_SH_8 = 0x8,
+    AES_SH_9 = 0xd,
+    AES_SH_A = 0x2,
+    AES_SH_B = 0x7,
+    AES_SH_C = 0xc,
+    AES_SH_D = 0x1,
+    AES_SH_E = 0x6,
+    AES_SH_F = 0xb,
+};
+
 const uint8_t AES_shifts[16] = {
-    0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11
+    AES_SH_0, AES_SH_1, AES_SH_2, AES_SH_3,
+    AES_SH_4, AES_SH_5, AES_SH_6, AES_SH_7,
+    AES_SH_8, AES_SH_9, AES_SH_A, AES_SH_B,
+    AES_SH_C, AES_SH_D, AES_SH_E, AES_SH_F,
+};
+
+/* AES InvShiftRows, for complete unrolling. */
+enum {
+    AES_ISH_0 = 0x0,
+    AES_ISH_1 = 0xd,
+    AES_ISH_2 = 0xa,
+    AES_ISH_3 = 0x7,
+    AES_ISH_4 = 0x4,
+    AES_ISH_5 = 0x1,
+    AES_ISH_6 = 0xe,
+    AES_ISH_7 = 0xb,
+    AES_ISH_8 = 0x8,
+    AES_ISH_9 = 0x5,
+    AES_ISH_A = 0x2,
+    AES_ISH_B = 0xf,
+    AES_ISH_C = 0xc,
+    AES_ISH_D = 0x9,
+    AES_ISH_E = 0x6,
+    AES_ISH_F = 0x3,
 };
 
 const uint8_t AES_ishifts[16] = {
-    0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3
+    AES_ISH_0, AES_ISH_1, AES_ISH_2, AES_ISH_3,
+    AES_ISH_4, AES_ISH_5, AES_ISH_6, AES_ISH_7,
+    AES_ISH_8, AES_ISH_9, AES_ISH_A, AES_ISH_B,
+    AES_ISH_C, AES_ISH_D, AES_ISH_E, AES_ISH_F,
 };
 
 /*
-- 
2.34.1


