Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59F72F1A2
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 03:22:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9FC4-0004bu-Ta; Tue, 13 Jun 2023 21:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FC3-0004av-7a
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:03 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1q9FC1-0004UW-I5
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 21:21:02 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-3f9b1f43bd0so14927201cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 18:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686705660; x=1689297660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzYKPbuynucDIAzF9ze+tOWHKtiot5KEw+AyGFozTco=;
 b=SWBlkoX03hXqPc7zSLKZNGx6/nSf6la+KzEysTQmPfG9wij97CDEUGcphSXRiv2R7P
 W40Zu1LKAsAf2Kw5BdCxEy6sFWUIj53zK1XM2TuZtIU8qzyOjT0HqDgu63eNb6TK37s0
 3b8SEwo41PVMsRe/R6JS01ydU3+XofLoxDwwXEt0xr2uri9ndRf3tjj85hq6ib64C4cz
 pxeLIKndcW4W3Zk4t+vA+0p1oFcuGI2fDmYx+mwNGijZt7yZCOLwWL9rvcMXSQ4S2D8v
 blH+2GH7UnRQj0Ii1RyJAfPhG3Ox+qJnvrYk9V2uG3O9S3i+XOzin3cjHLxnkqQaRCdf
 OoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686705660; x=1689297660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CzYKPbuynucDIAzF9ze+tOWHKtiot5KEw+AyGFozTco=;
 b=D/LfcU3cdH2o1uQNiP+gkv2K20yd6CgsPr1vKAmDveBw0yUefqYl7cZNLRwWP6PkN3
 UdWJjD6YZS0l4BzPEMsPlognunqYvJ+EkFcBftkjnObaoPyDTYtA5q3sMPG+5FfRrcqB
 0aORXiC71E93eIX4L7Ewnjh58qyUZ/+kLt6sl2guEOI3KmvEG/qDhormpUYadGORfpoD
 a68+Kpg6cj9cPwUQSp4MpJLiCMaZyZ9aaWngI1t2FIpG+A72TGUu+T8t1F24wXjp7lL2
 7t4p0lWDWzexhMMduBpPnLOlJ0OvEVYMjroPhN20VNf4ufdRoLjPsSmZNsdKz9vcDLhF
 nPFQ==
X-Gm-Message-State: AC+VfDzFiyuaQMh2Y2o9GzsjGz4K6DY2d7ChVj2Lj1311SzJKRksOfb0
 3FtEkXMPbXoKVPNKAu2KQRvtdYRX02eO/A==
X-Google-Smtp-Source: ACHHUZ5Vz6D6YpB8TxSktnx8O+YZygDxXEN6Ua9r+Ofu5mp8Huojib1C2DiTbEq09qoCoKubTteJDQ==
X-Received: by 2002:a05:622a:15ce:b0:3f6:bb5b:8111 with SMTP id
 d14-20020a05622a15ce00b003f6bb5b8111mr484677qty.60.1686705660450; 
 Tue, 13 Jun 2023 18:21:00 -0700 (PDT)
Received: from toolbox.wdc.com
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b0064f7c56d8b7sm9112238pfm.219.2023.06.13.18.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jun 2023 18:20:59 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 06/60] target/riscv: add PRIV_VERSION_LATEST
Date: Wed, 14 Jun 2023 11:19:23 +1000
Message-Id: <20230614012017.3100663-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230614012017.3100663-1-alistair.francis@wdc.com>
References: <20230614012017.3100663-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=alistair23@gmail.com; helo=mail-qt1-x830.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

All these generic CPUs are using the latest priv available, at this
moment PRIV_VERSION_1_12_0:

- riscv_any_cpu_init()
- rv32_base_cpu_init()
- rv64_base_cpu_init()
- rv128_base_cpu_init()

Create a new PRIV_VERSION_LATEST enum and use it in those cases. I'll
make it easier to update everything at once when a new priv version is
available.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230517135714.211809-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 2 ++
 target/riscv/cpu.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de7e43126a..15423585d0 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -61,6 +61,8 @@ enum {
     PRIV_VERSION_1_10_0 = 0,
     PRIV_VERSION_1_11_0,
     PRIV_VERSION_1_12_0,
+
+    PRIV_VERSION_LATEST = PRIV_VERSION_1_12_0,
 };
 
 #define VEXT_VERSION_1_00_0 0x00010000
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9fc9d1cc0f..a0c4acfb47 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -345,7 +345,7 @@ static void riscv_any_cpu_init(Object *obj)
         VM_1_10_SV32 : VM_1_10_SV57);
 #endif
 
-    env->priv_ver = PRIV_VERSION_1_12_0;
+    env->priv_ver = PRIV_VERSION_LATEST;
 }
 
 #if defined(TARGET_RISCV64)
@@ -356,7 +356,7 @@ static void rv64_base_cpu_init(Object *obj)
     set_misa(env, MXL_RV64, 0);
     riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_1_12_0;
+    env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
@@ -462,7 +462,7 @@ static void rv128_base_cpu_init(Object *obj)
     set_misa(env, MXL_RV128, 0);
     riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_1_12_0;
+    env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
 #endif
@@ -475,7 +475,7 @@ static void rv32_base_cpu_init(Object *obj)
     set_misa(env, MXL_RV32, 0);
     riscv_cpu_add_user_properties(obj);
     /* Set latest version of privileged specification */
-    env->priv_ver = PRIV_VERSION_1_12_0;
+    env->priv_ver = PRIV_VERSION_LATEST;
 #ifndef CONFIG_USER_ONLY
     set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV32);
 #endif
-- 
2.40.1


