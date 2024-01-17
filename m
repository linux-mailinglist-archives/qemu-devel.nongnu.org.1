Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B532A830EB2
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:37:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDav-0000z3-BV; Wed, 17 Jan 2024 16:37:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQDaq-0000xr-2R
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:37:04 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rQDan-000214-Jq
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:37:03 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d5f388407bso13605325ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 13:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705527420; x=1706132220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR7j/cQ2q9J+BBWwmPWf5u1K7zFcq0NhwGS7s5IaHdc=;
 b=gG/WyUNbCxT9k5FLhULIcKrzCQtvI9f3kaCuhpI6Q0OmW7QcJU+7ptimjAFI0CueDU
 Lp430YmRjd9UoO13oyo4gvMBE0Ak/Nj9UyvyD6B9+M5W8z14LNQ/vK5agfO2tQBTmHe4
 3MKfCBPMl8YSH7VybjBB6v09/luDHwA+Vlrqp/wOTqk1pIlIPLPD2jTi/ju420m6NxF9
 ynzZ1lAmmMYrcQxPC7pbFSlMe1GEGDBIjSd/KbtDC2IuzN74s5A436ovmWNKx7QrKOMd
 ws+3cayTzQb8qbh7FzP6h8LhA8IEQ9cK8+5IrIqsy1ZWZW8/xOk6MYi5iWDbVMlEXeli
 Yz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705527420; x=1706132220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oR7j/cQ2q9J+BBWwmPWf5u1K7zFcq0NhwGS7s5IaHdc=;
 b=LMJZKb7kkVH2QdAA8G/W98zIax4LS8ZsnI0NaxCAju85Zkmy3aJX0rma0mv6onVWXK
 XFyQN2xmeyur1Jl8YwRYID2+9Nf4m2ncST0gSqBlV1dHqD/uHPkz5IB4pHW6QB8ZNZFV
 fLJG/ZFPkghOw0Uk28sBNH2lxjniGzDJ488ZcBli3S3VzSuAyWLkB46b2NtOQ89css0n
 Gnpnv+LjcKvvJvJ3A8psK3WOhjQXCMkE26NAIuMzgza5pI75KAhj5OBDrwAk6avWNYHq
 Cv7uPUsEvwHBHg2a7z6KvHb7Kb4aLpDtOr114sXf+TOo0JfGKFDuujW6bEoAlHNkG30y
 C/ig==
X-Gm-Message-State: AOJu0Yza45ANEVrv1EQgg9ebSuq9NJrn7FAlWJtP4kO6AILZxIJU//h6
 QPYynvhinNeUn5tkuTolg2nzTkYuiakRUdchtvv2Yf7YcNdcAA==
X-Google-Smtp-Source: AGHT+IEf/QyeyFsyS+pYMqn+i0Zwv8oRIzpDYesCeq9RDM+/jp8Hf01jjOmFKrzmCVfONEyHzkcMAQ==
X-Received: by 2002:a17:903:1252:b0:1d4:e1f1:ef6b with SMTP id
 u18-20020a170903125200b001d4e1f1ef6bmr6804453plh.114.1705527420118; 
 Wed, 17 Jan 2024 13:37:00 -0800 (PST)
Received: from stoup.net ([2001:8004:2728:321b:5fc1:fe4b:9b89:f799])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a170903410b00b001ca86a9caccsm104824pld.228.2024.01.17.13.36.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 13:36:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, thuth@redhat.com, david@redhat.com,
 philmd@linaro.org, mjt@tls.msk.ru, qemu-stable@nongnu.org
Subject: [PATCH 1/2] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
Date: Thu, 18 Jan 2024 08:36:45 +1100
Message-Id: <20240117213646.159697-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240117213646.159697-1-richard.henderson@linaro.org>
References: <20240117213646.159697-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


