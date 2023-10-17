Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FADF7CCFE8
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:13:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qssJ4-0001g3-R1; Tue, 17 Oct 2023 18:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssJ2-0001fX-CJ
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:52 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qssJ0-0002YC-Sd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:12:52 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-35743e88193so25254135ab.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 15:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1697580769; x=1698185569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tu1uQppmcaudXCZ6wZyPs+oZqs9eNWAN3vjDAnHlDMw=;
 b=I3fDPaHJ4uV9CvaCKB+RF83NuEcyUa+/itVLJuJfDXa7rpD7+hvUXxtpHMeB1+xE3+
 nxE7bDWc1KqxIQqOjl7cEZxWN0iSIizOPLfhVRQmKmsMOysB6YeIWxSS4rFBIDCxU6Iq
 y6ojwfq43INK6gHQHEkyC1izMXmkYmUovmkSJHL9s96QA/3iC2sE922OOekjKHJtyZz8
 xfHc38Ik32n7JFERrHmTqMKa90PErl8xC+LeZDLY16vDUw4be5vdP04HGZcHKQrbdmHG
 ax83YByN79yV0wZsJQPRuOsFn76AdDcI6Sv8EwbGbu4mwdxPe63eTYXHftg8oX2WCsbE
 fdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697580769; x=1698185569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tu1uQppmcaudXCZ6wZyPs+oZqs9eNWAN3vjDAnHlDMw=;
 b=dZKdHIozhdedswh/6aRxeHOy2KQryxJM3CJpQvDIeeuGTiTrmdbnNRuhOKpHe6Geeg
 43HLDGe0Z2lSxfnci7V83xjq+CsGYHQDf8Zff1VOT64wz+zrUHAxVrp49ge8vHDEN2hK
 eLq1ZP5dVVwYg38l4YUudE+IXA7bs5w/Yokudsgk2aAu9yTB5FcdTO7DUdXN/ZpzxnCX
 fMGSZhiUNGxwRgGaZF5z/ee8bYNERGTCUZYhb+LUWyO6J8KOakW8lwtyvDVa4CaZaPId
 zCxa98LifP0ACrAR5+eHyQTamoovgbI7MLFoqjRVMvSEMSQUP7Tlc2n8w2EDbRwYbB13
 dseg==
X-Gm-Message-State: AOJu0YxEh29P3i/o42wSSbTvYnW37dINnDYveas0P86DF877yKW6WGAJ
 sBS89ibxGEU7ETrweoHIBDw2FToGi8hrrNYMUe4=
X-Google-Smtp-Source: AGHT+IEgHkSaUJ+tzrikgdyRVO/qigwx8IgeyH5JPHSaAKB9FfwsiwqUKDcarl77j7c38i+aVerA6Q==
X-Received: by 2002:a05:6e02:1546:b0:357:6410:9494 with SMTP id
 j6-20020a056e02154600b0035764109494mr5115257ilu.15.1697580769242; 
 Tue, 17 Oct 2023 15:12:49 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([177.45.186.249])
 by smtp.gmail.com with ESMTPSA id
 t13-20020a62d14d000000b006be077531aesm2011023pfl.220.2023.10.17.15.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 15:12:48 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 6/6] target/riscv/kvm: add zihpm reg
Date: Tue, 17 Oct 2023 19:12:26 -0300
Message-ID: <20231017221226.136764-7-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231017221226.136764-1-dbarboza@ventanamicro.com>
References: <20231017221226.136764-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add zihpm support in the KVM driver now that QEMU supports it.

This reg was added in Linux 6.6.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/kvm/kvm-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 6c2a92d171..5246fc2bdc 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -217,6 +217,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zihintpause", ext_zihintpause, KVM_RISCV_ISA_EXT_ZIHINTPAUSE),
+    KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
     KVM_EXT_CFG("zbb", ext_zbb, KVM_RISCV_ISA_EXT_ZBB),
     KVM_EXT_CFG("ssaia", ext_ssaia, KVM_RISCV_ISA_EXT_SSAIA),
     KVM_EXT_CFG("sstc", ext_sstc, KVM_RISCV_ISA_EXT_SSTC),
-- 
2.41.0


