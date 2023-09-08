Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B14257981CC
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUdn-0002U5-Hj; Fri, 08 Sep 2023 02:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdT-0001DC-Sg
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:32 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUdR-0005ze-FW
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:06:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso14061975ad.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153187; x=1694757987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g72WiAV5qZ1oQb/83wFsWAvyLD7y1PtWQ+7+Ow3xVqA=;
 b=HsmRsY0OOFkgdgcIGdMuPHLvwgRA3vRNHBW6jBiNZibsNv0vLDD7sL4zzdj+NbPyLJ
 p2cVHon/RG3PvuUYWCP6wiTHUAzUiF4AHuaJUtv0Gntf+AB9Uae24RiQggaKd8RxPKjk
 qhV8T6AOTuHWw6YPXiB4d8NfymqRFm+WywJjuFu/HYArHD7dvJ237DBouuRQLe7Hb6OJ
 P10QUFZAuKS8nFQV5o5t0Cq8RR9Te3tzBR+W64VCIsDjn6v59OSlW7nLg3deMmsWX7Vc
 LGBBzw3Fg0fu9DHXlFJAjPFilSJp6dClJFMCbKrLnpoi+O+Ex/T6yUSAWur/YAiuHZwj
 ePLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153187; x=1694757987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g72WiAV5qZ1oQb/83wFsWAvyLD7y1PtWQ+7+Ow3xVqA=;
 b=EP/a8NJj+1P9zRA31K3n12cBRm1g+urKPusLXPJmctsdYDqjUXpmTx/+jjMWWdN9Qu
 5evIT3gh/FZ1Oujdn7RhI/ayn4Ou650HHxBtND4JYxoUY4TS/a7TqXOIXZOXGU9RwHrV
 MHS7NaF4QVT0HWFmMVA73PEFaw17XaUULFE+U+GulEY7KLpUUx/8+e5NuoXPj6Xn8MDX
 nYzFypCzocXYkcmRtNOQs6b1rW6u+KsPwQVLbHPB8lxgNh/j73ePQiZsCUziui204fbZ
 WZCSJe54wvnbNsomFmQXc8+1x/egIOLIvH8dZJl1daWDiByOJQ4jR58vqaFv9dRQFPxm
 ICVA==
X-Gm-Message-State: AOJu0YzY7YA5Wq2na9ips3/E0ujWPmB7WbrDdJaFUuIqaK/7LxVMQwYe
 j0FCeU7M91pWR0cRsyT/hILzeh7Fsfg3BdPv
X-Google-Smtp-Source: AGHT+IF/souweECsQxcOaPS0vtGcewK+KKc69hUQLmQluF+Z0oRMFC99228JTfOLWjo6QTw/8PFQOw==
X-Received: by 2002:a17:902:6b88:b0:1bf:8779:e045 with SMTP id
 p8-20020a1709026b8800b001bf8779e045mr1328558plk.50.1694153187559; 
 Thu, 07 Sep 2023 23:06:27 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:06:26 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jason Chien <jason.chien@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 24/65] target/riscv: Add Zihintntl extension ISA string to DTS
Date: Fri,  8 Sep 2023 16:03:50 +1000
Message-ID: <20230908060431.1903919-25-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jason Chien <jason.chien@sifive.com>

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

These instructions are encoded with non-used opcode, e.g. ADD x0, x0, x2,
which QEMU already supports, and QEMU does not emulate cache. Therefore
these instructions can be considered as a no-op, and we only need to add
a new property for the Zihintntl extension.

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Jason Chien <jason.chien@sifive.com>
Message-ID: <20230726074049.19505-2-jason.chien@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg.h | 1 +
 target/riscv/cpu.c     | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index 61f6238756..0e6a0f245c 100644
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
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index dc4b88e625..fae1c92c5c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -87,6 +87,7 @@ static const struct isa_ext_data isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zicond, PRIV_VERSION_1_12_0, ext_zicond),
     ISA_EXT_DATA_ENTRY(zicsr, PRIV_VERSION_1_10_0, ext_icsr),
     ISA_EXT_DATA_ENTRY(zifencei, PRIV_VERSION_1_10_0, ext_ifencei),
+    ISA_EXT_DATA_ENTRY(zihintntl, PRIV_VERSION_1_10_0, ext_zihintntl),
     ISA_EXT_DATA_ENTRY(zihintpause, PRIV_VERSION_1_10_0, ext_zihintpause),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
     ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
@@ -1790,6 +1791,7 @@ static Property riscv_cpu_extensions[] = {
     DEFINE_PROP_BOOL("sscofpmf", RISCVCPU, cfg.ext_sscofpmf, false),
     DEFINE_PROP_BOOL("Zifencei", RISCVCPU, cfg.ext_ifencei, true),
     DEFINE_PROP_BOOL("Zicsr", RISCVCPU, cfg.ext_icsr, true),
+    DEFINE_PROP_BOOL("Zihintntl", RISCVCPU, cfg.ext_zihintntl, true),
     DEFINE_PROP_BOOL("Zihintpause", RISCVCPU, cfg.ext_zihintpause, true),
     DEFINE_PROP_BOOL("Zawrs", RISCVCPU, cfg.ext_zawrs, true),
     DEFINE_PROP_BOOL("Zfa", RISCVCPU, cfg.ext_zfa, true),
-- 
2.41.0


