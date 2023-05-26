Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E5A711FE1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:26:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2QtU-0005Fm-Gy; Fri, 26 May 2023 02:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1q2Qt9-0005DJ-Tz
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:25:26 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yongxuan.wang@sifive.com>)
 id 1q2Qt8-0000n8-80
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:25:23 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b011cffef2so2307155ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 23:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1685082320; x=1687674320;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8pjWV+qRwkWtypfMGoFq3ZGcEhsUFF0yGFVJo0XrtJA=;
 b=fGss6BTA5pCNjGPPJ5z3HpJnY6aLtBaMchFmXG2tk4RG7wdAROb8hpqz8lwxWROar1
 xnVWOedM4UnFNxwWDAURfSlUT5uXdfdVK6sdllrLZtCui0XMpGwxO2NOiG5k2HObrYIk
 S/T7RPDxv3/F1XoPI1WrRRNBqxoSlcsyp5jOYsesb4C+fbX2iNSztQoNF1mKqgrD6mri
 9pCBzT/i+0A6acZCKd1eTCbkXVkbQB4luf1ggw2BVOryPEZhfGFqKpBTO7a/NYuh+puY
 6hkeTrgg3Brziaj0fIWh64MgIac5fjY8JwANAeUjJ3JVcFQFSXA1p7TxoZ+MXcqQi+Id
 zHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685082320; x=1687674320;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8pjWV+qRwkWtypfMGoFq3ZGcEhsUFF0yGFVJo0XrtJA=;
 b=Jos1lSgUXq/oTOgCHZmE7FbwN45DJ4EqdnbBWBTK/ZyZhqQ1bCYNqSTrogrEVYkgQ9
 hoQLhO55MztVZuJz3AW6iFiq6GQIsRYWEVONvXsef0M+5spFEpj3knKD3Mp80t76LEKr
 +Vs0KfeAKciNGQwIyeaE7eKqB3iNDQ19rYk7eBAbzXp4lzuQBuhItlHLE98AA0Kv5SxL
 fmSlfyiSL5o5RzwqGrOkxcl70bGWqZ8HbS2x1Xjb/l4LOB6rRw/i+8CepFw6e4734WSv
 Rvy9ciFOHfqhcZCF2o/YqQXcKDZE8PW0I0WcX3k9+urPynVmNDanauIfMVi2IiNIRJS+
 l/oQ==
X-Gm-Message-State: AC+VfDxcLu+sPaieXnjPn83NZ3X6gPU5qlBRHriP4sRYod7g87iyRjls
 tVaRjZgAAdVpMW+WK4tbprgsqkaCNZg6Ukcvaua9RG28x8nlTUMzc5V9TLymMAvUK3sbZxVN7mf
 MJ4TVhg6yQn6NRdUj2wN+BSnBQo/YyjvobJe8t96AMnflAqRP77atm1aj2CcMMO2//OG0piAx6R
 OvhGWy
X-Google-Smtp-Source: ACHHUZ6O8dzd9yUsfl8GUCl6aVOP3BspJLNVH1Q07otLAI1jB83wxDYWlmcb+Hwj+w1yDUUnETNtZg==
X-Received: by 2002:a17:903:d3:b0:1af:beae:c0b with SMTP id
 x19-20020a17090300d300b001afbeae0c0bmr1283573plc.22.1685082320559; 
 Thu, 25 May 2023 23:25:20 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 m24-20020a170902bb9800b001a94a497b50sm2429150pls.20.2023.05.25.23.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 23:25:19 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, rkanwal@rivosinc.com,
 anup@brainfault.org, dbarboza@ventanamicro.com, atishp@atishpatra.org,
 vincent.chen@sifive.com, greentime.hu@sifive.com, frank.chang@sifive.com,
 jim.shu@sifive.com
Cc: Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Juan Quintela <quintela@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, kvm@vger.kernel.org
Subject: [PATCH v3 1/6] update-linux-headers: sync-up header with Linux for
 KVM AIA support placeholder
Date: Fri, 26 May 2023 06:25:01 +0000
Message-Id: <20230526062509.31682-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230526062509.31682-1-yongxuan.wang@sifive.com>
References: <20230526062509.31682-1-yongxuan.wang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=yongxuan.wang@sifive.com; helo=mail-pl1-x634.google.com
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

Sync-up Linux header to get latest KVM RISC-V headers having AIA support.

Note: This is a placeholder commit and could be replaced when all referenced Linux patchsets are mainlined.

The linux-headers changes are from 2 different patchsets.
[1] https://lore.kernel.org/lkml/20230404153452.2405681-1-apatel@ventanamicro.com/
[2] https://www.spinics.net/lists/kernel/msg4791872.html

Currently, patchset 1 is already merged into mainline kernel in v6.4-rc1 and patchset 2 is not.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 linux-headers/linux/kvm.h |  2 ++
 target/riscv/kvm_riscv.h  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 599de3c6e3..a9a4f5791d 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -1434,6 +1434,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_XIVE		KVM_DEV_TYPE_XIVE
 	KVM_DEV_TYPE_ARM_PV_TIME,
 #define KVM_DEV_TYPE_ARM_PV_TIME	KVM_DEV_TYPE_ARM_PV_TIME
+	KVM_DEV_TYPE_RISCV_AIA,
+#define KVM_DEV_TYPE_RISCV_AIA		KVM_DEV_TYPE_RISCV_AIA
 	KVM_DEV_TYPE_MAX,
 };
 
diff --git a/target/riscv/kvm_riscv.h b/target/riscv/kvm_riscv.h
index ed281bdce0..606968a4b7 100644
--- a/target/riscv/kvm_riscv.h
+++ b/target/riscv/kvm_riscv.h
@@ -22,4 +22,37 @@
 void kvm_riscv_reset_vcpu(RISCVCPU *cpu);
 void kvm_riscv_set_irq(RISCVCPU *cpu, int irq, int level);
 
+#define KVM_DEV_RISCV_AIA_GRP_CONFIG            0
+#define KVM_DEV_RISCV_AIA_CONFIG_MODE           0
+#define KVM_DEV_RISCV_AIA_CONFIG_IDS            1
+#define KVM_DEV_RISCV_AIA_CONFIG_SRCS           2
+#define KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS     3
+#define KVM_DEV_RISCV_AIA_CONFIG_GROUP_SHIFT    4
+#define KVM_DEV_RISCV_AIA_CONFIG_HART_BITS      5
+#define KVM_DEV_RISCV_AIA_CONFIG_GUEST_BITS     6
+#define KVM_DEV_RISCV_AIA_MODE_EMUL             0
+#define KVM_DEV_RISCV_AIA_MODE_HWACCEL          1
+#define KVM_DEV_RISCV_AIA_MODE_AUTO             2
+#define KVM_DEV_RISCV_AIA_IDS_MIN               63
+#define KVM_DEV_RISCV_AIA_IDS_MAX               2048
+#define KVM_DEV_RISCV_AIA_SRCS_MAX              1024
+#define KVM_DEV_RISCV_AIA_GROUP_BITS_MAX        8
+#define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MIN       24
+#define KVM_DEV_RISCV_AIA_GROUP_SHIFT_MAX       56
+#define KVM_DEV_RISCV_AIA_HART_BITS_MAX         16
+#define KVM_DEV_RISCV_AIA_GUEST_BITS_MAX        8
+
+#define KVM_DEV_RISCV_AIA_GRP_ADDR              1
+#define KVM_DEV_RISCV_AIA_ADDR_APLIC            0
+#define KVM_DEV_RISCV_AIA_ADDR_IMSIC(__vcpu)    (1 + (__vcpu))
+#define KVM_DEV_RISCV_AIA_ADDR_MAX              \
+        (1 + KVM_DEV_RISCV_APLIC_MAX_HARTS)
+
+#define KVM_DEV_RISCV_AIA_GRP_CTRL              2
+#define KVM_DEV_RISCV_AIA_CTRL_INIT             0
+
+#define KVM_DEV_RISCV_AIA_GRP_APLIC             3
+
+#define KVM_DEV_RISCV_AIA_GRP_IMSIC             4
+
 #endif
-- 
2.17.1


