Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5425473EE6F
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 00:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDuIs-0003Y5-Iy; Mon, 26 Jun 2023 18:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuIB-0001e3-F3
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:39 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qDuI8-0005vu-5r
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 18:02:38 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1b0138963ffso2684659fac.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 15:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1687816955; x=1690408955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=II+nHTsp9rVq4LDzVJKLAPoPS1TtHejY67WxxM6JyBC1otMZ8O0L6fE5U8GTTmjpyk
 VMm9+cn/h/45aZy3fymTAXDLkfwlwCSEgVofs46MHwKikAOVbyUa6IWAyKZsLOM0XzUF
 e15gNcrKiYTAsiLLLKv0J6i/LaT1MI0ysjOXuIwFf8sbnGvXNBj++3ylta1DayPwsQ2l
 JuFoDqUvDK2hp4u+52C2tkUQvpdk/4djnsDfQ1M7mMQKNPFWc78aqs9wxZhvLz1e9CVq
 o4llUXd4yVpSr8L5QtcjBj+I2AgpnRPSp6UdQtEcsdwYAjSDJfjkOe41icMphchr6Za8
 pyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687816955; x=1690408955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zsw0pJ1ZMaa7pJqxBp9+XWOi9ryOdYncMUElEND8Y8o=;
 b=Ozfg/iMVgCFmiPKDbA5pVkcjwsivAa/Bg++xg489GdST5y+M5wsenMcHmIo/Po6vAm
 cI1WviEC0MC/3rROLl0iL3Xy+b5+tDN1t4r6Uqc4/ReEgmhrpnBIkibA7fwWVX6sx0gq
 xZnuh4A9m6dtC9Ddk08D1cM3h04OU1z66Hbn6TeCSdE4ChhEVcP1rGfJnYz8zmug3iJH
 TJ6rb/NrK42wZB4rx2RFv++RPizn2vb8FvWAHb2i/BP47Cll47caEOoif5wfgk4NUqdu
 IOhZ5VzykQB/UE9tge8ndVhcoyBHWx2Ztf0CD/nxCpD3kNT+FRQyIQCz1Tl1oJ+oXdZd
 p14Q==
X-Gm-Message-State: AC+VfDxGZkp7gt1i4dLdfMBbyq+tJ9+sjPtF6Kgcq7e6ItSCi0IKuvEv
 dXiKxlruNJeSPOzb0oi2zwMDgQytDvCohVMc8/0=
X-Google-Smtp-Source: ACHHUZ6xroM1/WmzJB2ClhCWH62hFfLXtfb2UJ0Cv4SejGLyMDMqyTLiyPxasEN1ZnvDdVIAI3DadA==
X-Received: by 2002:a05:6870:ab84:b0:1a3:67a6:4676 with SMTP id
 gs4-20020a056870ab8400b001a367a64676mr38240119oab.29.1687816954793; 
 Mon, 26 Jun 2023 15:02:34 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com
 (201-69-66-110.dial-up.telesp.net.br. [201.69.66.110])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a056870a10c00b001b03fbfa0c5sm1831419oae.39.2023.06.26.15.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 15:02:34 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 07/19] target/riscv: read marchid/mimpid in
 kvm_riscv_init_machine_ids()
Date: Mon, 26 Jun 2023 19:01:57 -0300
Message-ID: <20230626220209.22142-8-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626220209.22142-1-dbarboza@ventanamicro.com>
References: <20230626220209.22142-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x30.google.com
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

Allow 'marchid' and 'mimpid' to also be initialized in
kvm_riscv_init_machine_ids().

After this change, the handling of mvendorid/marchid/mimpid for the
'host' CPU type will be equal to what we already have for TCG named
CPUs, i.e. the user is not able to set these values to a different val
than the one that is already preset.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/kvm.c b/target/riscv/kvm.c
index 37f0f70794..cd2974c663 100644
--- a/target/riscv/kvm.c
+++ b/target/riscv/kvm.c
@@ -378,6 +378,22 @@ static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvmcpu)
     if (ret != 0) {
         error_report("Unable to retrieve mvendorid from host, error %d", ret);
     }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(marchid));
+    reg.addr = (uint64_t)&cpu->cfg.marchid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve marchid from host, error %d", ret);
+    }
+
+    reg.id = kvm_riscv_reg_id(env, KVM_REG_RISCV_CONFIG,
+                              KVM_REG_RISCV_CONFIG_REG(mimpid));
+    reg.addr = (uint64_t)&cpu->cfg.mimpid;
+    ret = ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
+    if (ret != 0) {
+        error_report("Unable to retrieve mimpid from host, error %d", ret);
+    }
 }
 
 void kvm_riscv_init_user_properties(Object *cpu_obj)
-- 
2.41.0


