Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B177082D8
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 15:35:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzdlO-0006Mv-Gp; Thu, 18 May 2023 09:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyn-0000Dr-64
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1pzbyl-0002WQ-8G
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:39:32 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9d4so18553435e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1684409968; x=1687001968; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=erus5ABQqsHoSUUKbAryAoIx/sTkHxYWibzmmckFzwE=;
 b=mSRulgNf0cd9JOthDyGfjdAeHHAoIjbFh2Rsj8Xn/TDHx2YRjFV+Egeb01e4VV6qa4
 W/dS3IpZOAyHoGKlzzgNOBOq8172P2kAjpf44ZgAz3CfQPrSwgwP0BdntQJz1SHYxc9T
 n+rKJt23LcJF16eaj7Cw6nOYUkA0dnQRRtetvM2LzrtNXucr8dzMOoJBffxpi9GoCtFm
 6QE2YFBbNx1EF3Aet1Zn2dRdIDAd/QwCjpjWpCAmgHmtUABT6AC45fjWxAoez+3d/5Md
 4XZiDp4+elS8Rx9/C9n5YzDDIEqrHnXBmVZFrMeIlWnGjALTcc/D7B9IvSZzu3nkpKrq
 FUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409968; x=1687001968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erus5ABQqsHoSUUKbAryAoIx/sTkHxYWibzmmckFzwE=;
 b=UISOWqsoiYHm7+wg4VEepDMJg2xCWHfwT/uMcVVzFLeuDYmHnfOGys9scx6U8Bcwlf
 eYbtCjpcBGfosqSrifI3lI33/QX6iAi19Z8oXa3cLvJvejVgPE8aceiUkMl58fMmYyKB
 qmWlKjkQUlty0wX4qzoGLjJWXhhUrGUomakd1CRzy91TqM2MwGzBJ2pP65SCBpdQqVNF
 E8+3GsDJQFl4QiGAAvumDVATQwCP6jmsM9pN2mGUxMOg6Ll0LOP8ogXD/ofAsoKB1D3T
 JyQFHjwC7PHjDNcXSkBLNrIqZoylohTHcIs6oJj+QNPVm+oMg3VbuUDRZ6gkfF3DvL4w
 SMFg==
X-Gm-Message-State: AC+VfDyfpdZuTHspn8cFH0k+8bGdtorhBPq62tvHd/IsUO7aS9SU46Y/
 WSPm1rIHdEyeQM2yZ9TuLfEdcg==
X-Google-Smtp-Source: ACHHUZ4atxuAbltrSLDsTYOD9/2fTVgWHl3al5HIrAHTyeGpLF45j9capZUhn/3JK4vl4k/lNG5ZuQ==
X-Received: by 2002:a1c:ed01:0:b0:3f4:f012:5cae with SMTP id
 l1-20020a1ced01000000b003f4f0125caemr1372957wmh.20.1684409967917; 
 Thu, 18 May 2023 04:39:27 -0700 (PDT)
Received: from localhost.localdomain
 (cpc98982-watf12-2-0-cust57.15-2.cable.virginm.net. [82.26.13.58])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1c7406000000b003f4272c2d10sm5083982wmc.1.2023.05.18.04.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:39:27 -0700 (PDT)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, atishp@rivosinc.com, apatel@ventanamicro.com,
 Rajnesh Kanwal <rkanwal@rivosinc.com>
Subject: [PATCH 3/6] target/riscv: Set VS* bits to one in mideleg when H-Ext
 is enabled
Date: Thu, 18 May 2023 12:38:35 +0100
Message-Id: <20230518113838.130084-4-rkanwal@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518113838.130084-1-rkanwal@rivosinc.com>
References: <20230518113838.130084-1-rkanwal@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 May 2023 09:33:46 -0400
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

With H-Ext supported, VS bits are all hardwired to one in MIDELEG
denoting always delegated interrupts. This is being done in rmw_mideleg
but given mideleg is used in other places when routing interrupts
this change initializes it in riscv_cpu_realize to be on the safe side.

Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
---
 target/riscv/cpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index db0875fb43..90460cfe64 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1288,6 +1288,11 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* With H-Ext VSSIP, VSTIP, VSEIP and SGEIP are hardwired to one. */
+    if (riscv_has_ext(env, RVH)) {
+        env->mideleg = MIP_VSSIP | MIP_VSTIP | MIP_VSEIP | MIP_SGEIP;
+    }
+
     riscv_cpu_register_gdb_regs_for_features(cs);
 
     qemu_init_vcpu(cs);
-- 
2.25.1


