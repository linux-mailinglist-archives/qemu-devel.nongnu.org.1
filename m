Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 209187F3D72
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 06:38:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5fwd-0002pN-1z; Wed, 22 Nov 2023 00:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwb-0002iu-2X
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:37 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5fwZ-0007Ae-Bb
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 00:38:36 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so53735245ad.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 21:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700631513; x=1701236313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfdNnE304ZcORy8+jKuKo1TUlW31ZX6mKgVvqcTL9E4=;
 b=WALXjzQ0Zf+zJLoJ0H5ZOlPFYGUZeEkC7YdcHAvWwu0aIyQN0zyeIgY3uPILke8ap7
 XAGBLzAUzjU9ktKve6ZTjx3watp9QoJj5VVO1Yke0yPLV4V/gzA1Syth/lwxLZcSUNli
 oclHIwmd67u0BIHKjbPaRcoiPprucIZmeOnnJW3FnP7WXCkYq8cD/FECIUo4l45DhXb1
 PVZytHiM7rE0UWxUjU2kTupLME1pq07vKQEnnX4i4oRFrRkCte03PGljKSI1BGAJCC7V
 nf+LE+uTJJeHbKbF5LclzW2treGr3fS/cd62IBd3olXc/qNoyFPPRdqZyb9J6hkNr0Si
 aF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700631513; x=1701236313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfdNnE304ZcORy8+jKuKo1TUlW31ZX6mKgVvqcTL9E4=;
 b=G6hC79umBPQ+4oUF1+olLYDY73uS7U8XFvdkZpQYTLWQ/Q27vld+l2EVATXTLjFIlX
 Ucm43G3eDga6XTZm/eCTYk4TOT0y5hzDD+mjp/FqITo5a7T7fadA3WHnKS4MfFlrwR/V
 tSbv8fp4dUYkG+j91uPhl8yt0WsWAlHrwyGJg/XNSsLlcfNWxKAWMtZjMLlWen2RDwD5
 UFR0P/Hp8vk5t4hOj1HNJ1ELBWbrMJ8gRbiczHq/pF6hJihg8VEY64beWkfzadKdBzIk
 cqPevmLrLcMALy8smDjAUDXpGaEpfbJYG0p7xTRfsucrCVSB7Sp4UT4oJ+ts0f0VXFME
 3xPw==
X-Gm-Message-State: AOJu0YyjQqRrstJo5xZjbf+i5uOB+64/QyEMdueOBLBuUlinCfuNNyRG
 uStQ4SkxIoZs9M0xM/fdszZxdNqUshSs3Q==
X-Google-Smtp-Source: AGHT+IFlNip6xknP3Kv6zaxZtOJvecxWi7X2NxPfFrN0Z7C1N+m2qkvU4DjZ2SUDVaBN8sXDf1iDMw==
X-Received: by 2002:a17:902:b784:b0:1cf:5670:243e with SMTP id
 e4-20020a170902b78400b001cf5670243emr1502648pls.13.1700631513602; 
 Tue, 21 Nov 2023 21:38:33 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a170903124c00b001c0a4146961sm8923952plh.19.2023.11.21.21.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 21:38:32 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ivan Klokov <ivan.klokov@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 6/6] target/riscv/cpu_helper.c: Fix mxr bit behavior
Date: Wed, 22 Nov 2023 15:38:00 +1000
Message-ID: <20231122053800.1531799-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122053800.1531799-1-alistair.francis@wdc.com>
References: <20231122053800.1531799-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
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

From: Ivan Klokov <ivan.klokov@syntacore.com>

According to RISCV Specification sect 9.5 on two stage translation when
V=1 the vsstatus(mstatus in QEMU's terms) field MXR, which makes
execute-only pages readable, only overrides VS-stage page protection.
Setting MXR at HS-level(mstatus_hs), however, overrides both VS-stage
and G-stage execute-only permissions.

The hypervisor extension changes the behavior of MXR\MPV\MPRV bits.
Due to RISCV Specification sect. 9.4.1 when MPRV=1, explicit memory
accesses are translated and protected, and endianness is applied, as
though the current virtualization mode were set to MPV and the current
nominal privilege mode were set to MPP. vsstatus.MXR makes readable
those pages marked executable at the VS translation stage.

Fixes: 36a18664ba ("target/riscv: Implement second stage MMU")

Signed-off-by: Ivan Klokov <ivan.klokov@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20231121071757.7178-3-ivan.klokov@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_helper.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 9ff0952e46..e7e23b34f4 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -1032,13 +1032,29 @@ restart:
         prot |= PAGE_WRITE;
     }
     if (pte & PTE_X) {
-        bool mxr;
+        bool mxr = false;
 
-        if (first_stage == true) {
+        /*
+         * Use mstatus for first stage or for the second stage without
+         * virt_enabled (MPRV+MPV)
+         */
+        if (first_stage || !env->virt_enabled) {
             mxr = get_field(env->mstatus, MSTATUS_MXR);
-        } else {
-            mxr = get_field(env->vsstatus, MSTATUS_MXR);
         }
+
+        /* MPRV+MPV case, check VSSTATUS */
+        if (first_stage && two_stage && !env->virt_enabled) {
+            mxr |= get_field(env->vsstatus, MSTATUS_MXR);
+        }
+
+        /*
+         * Setting MXR at HS-level overrides both VS-stage and G-stage
+         * execute-only permissions
+         */
+        if (env->virt_enabled) {
+            mxr |= get_field(env->mstatus_hs, MSTATUS_MXR);
+        }
+
         if (mxr) {
             prot |= PAGE_READ;
         }
-- 
2.42.0


