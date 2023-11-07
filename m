Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C0B7E3305
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:34:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0BrE-0002af-VE; Mon, 06 Nov 2023 21:30:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0BrA-0002aQ-MW
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r0Br8-0002Py-QQ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:30:20 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so37164195ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699324217; x=1699929017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VU6si+0E3Qg7ouGUROVbzC3lFxvjyf5vQ9quDXL+/E=;
 b=FWbJnT268cEx4aA/tOvvEpIauri4h6xtGVPt34mrhbUGMVH+jg2tt/vjQQwqXrSuTD
 iWD40/yjdyuefX+uCykHJ9Nsgu4suaL2W5WqMtYzmDI2jw7+rpW+CgCFy8ADma/QdGVV
 OsXFqRVBhbnVPhV0RF/mcl2WyNvRA6v5DS3cjFhAPsFqiMgvjwD5SScBzI5Nd5nQN2JD
 h57VcRoiYGGj5q4N6Kt7q4uor5g8w5U0oPZTFFU5ZyqtkQpKKmL5zSpYIqv3V0/cpXLN
 5Fy/1+EFN0+DDd/liSuI4hrORw+q2SaE3hDGq9ks/N/ZQQ+opiRLjEBhRBYfRz5jtlY5
 W/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699324217; x=1699929017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5VU6si+0E3Qg7ouGUROVbzC3lFxvjyf5vQ9quDXL+/E=;
 b=MAa2uqjyWOGw8PjyLbvCFSENTcBbATb/GH+Q3tmB/OzPQWqilE3/QX3x9JdxUxdJdx
 Z2uvmopg5Fl3O1vv2Ch52NTuQmpZR38Li4wVmVHODkedcYTUU3sJDQv2B+Pd4y1KX+Rt
 LrJgbjoi2qzwwZzrxsrANuhdVk2hChul4uAWixmhm/sGoEyk98eK1cMxjtR8sz+biLVk
 7mlGzmXz0WhL203jaHM03geq0bTa6TFkO8QcLagR1F/SB7Derh/8H/Nu4agCoGocP48t
 OU44l1HWUvwk4wA68f6R0WRETOB/L90TIHBkqb8vLqG3vrU9h4r3jIPADxUwmo8gT4Uz
 XdWA==
X-Gm-Message-State: AOJu0YxEBGyoOQA1H/XLPnPPTKvxvYVRk0OsRA4r+8jIfB4RtY6B9357
 SHevEHPhGYe60z2e59ipN/KFHep4+EIPVA==
X-Google-Smtp-Source: AGHT+IFrQr+kmGr5ZwAmrRXO3PlK0AN5VIGe0i6Tg1fWc7Ibi64lN7/jsrFnHpe+zc3E00gR7STUGQ==
X-Received: by 2002:a17:902:d18d:b0:1c9:e2ed:66fe with SMTP id
 m13-20020a170902d18d00b001c9e2ed66femr20937026plb.52.1699324216894; 
 Mon, 06 Nov 2023 18:30:16 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a170902e5d200b001cc32f46757sm6487649plf.107.2023.11.06.18.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:30:16 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/49] target/riscv: Check for async flag in case of
 RISCV_EXCP_SEMIHOST.
Date: Tue,  7 Nov 2023 12:29:02 +1000
Message-ID: <20231107022946.1055027-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231107022946.1055027-1-alistair.francis@wdc.com>
References: <20231107022946.1055027-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Rajnesh Kanwal <rkanwal@rivosinc.com>

RISCV_EXCP_SEMIHOST is set to 0x10, which can be a local interrupt id
as well. This change moves RISCV_EXCP_SEMIHOST to switch case so that
async flag check is performed before invoking semihosting logic.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20231016111736.28721-3-rkanwal@rivosinc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 8c28241c18..aaeb1d0d5c 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1605,15 +1605,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
     target_ulong htval = 0;
     target_ulong mtval2 = 0;
 
-    if  (cause == RISCV_EXCP_SEMIHOST) {
-        do_common_semihosting(cs);
-        env->pc += 4;
-        return;
-    }
-
     if (!async) {
         /* set tval to badaddr for traps with address information */
         switch (cause) {
+        case RISCV_EXCP_SEMIHOST:
+            do_common_semihosting(cs);
+            env->pc += 4;
+            return;
         case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
         case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
         case RISCV_EXCP_LOAD_ADDR_MIS:
-- 
2.41.0


