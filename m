Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4057CCFE7
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:13:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssJ9-0001ow-G1; Tue, 17 Oct 2023 18:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssJ7-0001o8-CP
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:57 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssIs-0002Wh-1a
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:57 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-6c0b8f42409so4228001a34.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697580760; x=1698185560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Juy9Fo26ThtU0g+UY2hVD044MQTFgCmF6GOFzAjzMiI=;
 b=gsainKF7k7KzOWMP7nQ4d/tgFOZ2JYBdFRMVQLS1LzGsl9/kES730mu10IC9B/mNMa
 AmZulnP2Jk/V26AutgHlAdpIlcvu7/MMIGpvAGUAikks9nIjSK7xYIsSm7VddBvRbZLz
 26NY5VRKgjcySlHjyJqhbG9+LoUwgdIOgIYrb4tWOPfkPJTbhmdHDocE/TEoU26Tc5bU
 LBL0Tvnr0y5o2mGzkhepppYa/C9wNCOez2DFnYOtxT5F8XBW+vnCkB3qEhWXCtoNFTOU
 XIM7+Zy0fhrT+ps+5STApzDjeSu4rQ0TBizbbOx4KpiLJ32LY1Zk9Glg0UnMGqTDVUcx
 O6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697580760; x=1698185560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Juy9Fo26ThtU0g+UY2hVD044MQTFgCmF6GOFzAjzMiI=;
 b=W4f38kqeUNtsZibifL2y8ZSxcPjiWz5LmRLNLDnIJz2mZEnSIYKcrV6tWs8awzu2yb
 oSlT82s5+nas3dVxW176tpceu9gL+DZUHtd1xz9lDxT16IxRmdtpZw8M6hcRhtG3K6ru
 wNSCCJBFN50OX3VPxmW3/WMcGMvh9fdupy0PDWEBYI2gtHtJEuw2NY7vYwbZt85rX5pK
 xK04nQ2SZRn6rsU8VzX3gGkLUJ80dZN7unS6TvyA1J8rgk0lhprC4o7fza22WLQQ7Bj5
 wcM3I7za5CNN3F/I6xHxchQqtvgICmbb6xgDfmrTC+xfWW5FsjxaW3tobGtu/UU46YVH
 XGYA==
X-Gm-Message-State: AOJu0YwBwDKvNEVPEnyTjdbZVLTQfVPAjn0ysyAAv9B9Z6oYSAQnn409
 6UlS63P36pwV38EzD0MkGTguZewCJUmQE9K7a74=
X-Google-Smtp-Source: AGHT+IF8BPJuoys33rsqefNcP1VEer+wmPKM60y6SCkUqstQQEo04SYBNz7yZTAZmSFdi0BVRHViHQ==
X-Received: by 2002:a05:6830:71a2:b0:6b8:f730:7ab4 with SMTP id
 el34-20020a05683071a200b006b8f7307ab4mr4689556otb.0.1697580760616; 
 Tue, 17 Oct 2023 15:12:40 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62d14d000000b006be077531aesm2011023pfl.220.2023.10.17.15.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 15:12:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 3/6] target/riscv/kvm: add zicntr reg
Date: Tue, 17 Oct 2023 19:12:23 -0300
Message-ID: <20231017221226.136764-4-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017221226.136764-1-dbarboza@ventanamicro.com>
References: <20231017221226.136764-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add zicntr support in the KVM driver now that QEMU supports it.

This reg was added in Linux 6.6.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 5695f2face..6c2a92d171 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -215,6 +215,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
-- 
2.41.0


