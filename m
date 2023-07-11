Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE9774E67C
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 07:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ6EP-0003Ch-NQ; Tue, 11 Jul 2023 01:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qJ6Dn-0003BY-59
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 01:47:35 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qJ6Di-0007nI-PC
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 01:47:34 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b1238a013so3818892a12.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 22:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689054449; x=1691646449;
 h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b/77eFVto5A887RQXZN2BqRW+JvaFiGxADJ7e3quoS8=;
 b=Rtw7zG/qAalf2Z/BGOxSESCaArqFnXBPV3pNqqm7/HHF8vrHL4krBn16no6+pJT8fG
 kl/VgM2n2DacQyZ0EwDCSyLQD7a++gxJkQn3SMMffdToBI2hhtBcXH1TVqWzikaAt2xp
 km+QkTgjiroerBUTPDKVlA40C422HQOt9XCLfs8i2sUOivCBBtA4xa1Scjc6oSH3MiMZ
 id1TR/3dMnziiZqFieWxTsufLOFREWMkLPt/DRMEP5j1+grsovf8viYZn4y+GeocxPtn
 TbBs389ux6R/j6mLCjx7gvAygJTKODtnDOieXDnV/6YSQ0iOKcDIWSdHwTrSFo0Nu7zZ
 AwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689054449; x=1691646449;
 h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b/77eFVto5A887RQXZN2BqRW+JvaFiGxADJ7e3quoS8=;
 b=AvONffJ9VFSlEPLM+tWzf6ffo/EvZi+OIb1IOs178YgCDN3Ic9O2DsOLioXmnPUMAV
 ThVdXufGGRdORm7uaYFgesmpKaAhZwiTD4WKnj2LXetE8LMYzzQGhEOB6a7SJK+1BCaA
 2VoIUiz2Ud0d0TO8sOQs56xbqAagTBqvJBxoAxY2KbBQ4NNtLTUK1JtiD9pScDW7jZWu
 vvoUnlqUVfcZbU3BlPBgtgWmkkO3h0HZAl2w4AuHG0WQxgIk8NzbSEZ4xskKHiwIh23V
 L8J5fqEcMOAPQGhLVrBryw+BKUombpJKyud8wdRgt2aMdOJOhe3Y76uS/O8vts9a+4mX
 4QOg==
X-Gm-Message-State: ABy/qLbX5kWAQgITBzWpe64/4t2s+HnFl82gvtqveSa2Vnw7lYwZ+JRQ
 V3OiyrKzLnzgmaM3N8nzQv/q0f2X87ARh+iocvxsYLApN+zRXVw3SxSrUDxE7hnIvbqivLYTMiU
 QUjhJYkoKzKLEVST25X3erg5PfqvZlj1U1f+so2Wxo5q7NTi9/NyC9yEy+v2Zbkit97dXdAZps6
 NW7V3g
X-Google-Smtp-Source: APBJJlE5jodRFgaSe7A1LHCNalNiMTmdzvHXlgPiKmq1uwreVeNZRBJ/zu4eVuo1T43Ax2VwgPd7ZA==
X-Received: by 2002:a05:6a21:32a2:b0:130:d234:c914 with SMTP id
 yt34-20020a056a2132a200b00130d234c914mr14134883pzb.26.1689054448348; 
 Mon, 10 Jul 2023 22:47:28 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a62bd02000000b00679a4b56e41sm784346pff.43.2023.07.10.22.47.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 22:47:27 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2] target/riscv: Add Zihintntl extension ISA string to DTS
Date: Tue, 11 Jul 2023 05:47:20 +0000
Message-Id: <20230711054722.15721-1-jason.chien@sifive.com>
X-Mailer: git-send-email 2.17.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x52b.google.com
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

RVA23 Profiles states:
The RVA23 profiles are intended to be used for 64-bit application
processors that will run rich OS stacks from standard binary OS
distributions and with a substantial number of third-party binary user
applications that will be supported over a considerable length of time
in the field.

The chapter 4 of the unprivileged spec introduces the Zihintntl extension
and Zihintntl is a mandatory extension presented in RVA23 Profiles, whose
purpose is to enable application and operating system portability across
different implementations. Thus the DTS should contain the Zihintntl ISA
string in order to pass to software.

The unprivileged spec states:
Like any HINTs, these instructions may be freely ignored. Hence, although
they are described in terms of cache-based memory hierarchies, they do not
mandate the provision of caches.

These instructions are encoded with used opcode, e.g. ADD x0, x0, x2, which
QEMU already supports, and QEMU does not emulate cache. Therefore these
instructions can be considered as a no-op, and we only need to add a new
property for the Zihintntl extension.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 target/riscv/cpu.c     | 2 ++
 target/riscv/cpu_cfg.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 9339c0241d..b7e99cccd9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -87,6 +87,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
+    ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
     ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
@@ -1755,6 +1756,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
+    DEFINE_PROP_BOOL("Zihintntl", RISCVCPU, cfg.ext_zihintntl, true),
     DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true),
     DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
     DEFINE_PROP_BOOL("Zfa", RISCVCPU, cfg.ext_zfa, true),
diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 2bd9510ba3..518686eaa3 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -66,6 +66,7 @@ struct RISCVCPUConfig {
     bool ext_icbom;
     bool ext_icboz;
     bool ext_zicond;
+    bool ext_zihintntl;
     bool ext_zihintpause;
     bool ext_smstateen;
     bool ext_sstc;
-- 
2.17.1


