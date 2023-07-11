Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E66F74E7A7
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 09:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ7Q2-0008VN-Bb; Tue, 11 Jul 2023 03:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qJ7Q0-0008Uz-9b
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:04:16 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1qJ7Px-0002xK-OT
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 03:04:15 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-262e839647eso3970758a91.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1689059052; x=1691651052;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K1JAZVR+gGNhkdosrtc0SmyfpPXPE5kNM3tUmy+gKuk=;
 b=AVhMNx6lbLgRR1VbINb4Ja6Of4R+3MJMxllKcBnOee9v+lzzER/gtG35Knrr7lzBwm
 e+yYVNTEFzslJKzKNMWy1pBLlGKiBQ5ktNxoesW7PK7au0Y296opPzxsOg6DqEut6ezT
 qzxu2DKXjipv22jGHJGG8N/dCX6KlfA37A+/Fqjk8p5jSCsEuct/u+aTOp4fxR/20gqt
 Tu1hvpDl5h2VGsAQ/AgQ1BkqVypzwF/ItQibXTJW7fPbU8/GWMqGiTa7ImtHUlrewJfL
 szMDMVz8VhVwfB2NAUKqjXKCjGl2hztFvoP9LC6gu/m1NPBIkkYVvhM22LipbSDvHyda
 qm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689059052; x=1691651052;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K1JAZVR+gGNhkdosrtc0SmyfpPXPE5kNM3tUmy+gKuk=;
 b=gu2BHZLTJxPpByfIxyqEsSE5dXHcWngfNMe+ZQFqLX4XfJ65TExXTcwYGUkJg59LUI
 C/CDXl/fHJs8Z0CS89ISkdF4uX2T/IfgFcqp9Jl3v6FxjxPnJThUc1FvJLsbCiBSYtRc
 DInWflbY724rJ9xGdrZ7B8P5bUHlPNIYuBSKSt/otrEs3TZ16kC1t1ocPV9xc3Hbadq9
 MSjExsczXRheGOMQPS8jxgLxrFxaYeeFBnBNJylSixFWORmoeksxP/RV0X8b7YBGJdo7
 I243DZ7T/ZfZt/DtiRkY4k2FguiPmsXt2eq3F/p7A2VYlW0Oq4062VsGKfoNWeq9osPz
 eiNw==
X-Gm-Message-State: ABy/qLZ7IoFjZPsIDLX1EzMJo/b172sCkeXlJotz6yznjuK1n8/lT8U6
 p0VW8JYoGZ3II4p2YwpaRtYE/xMW3CafiawQt/4yz7L1h96Su2N8sfRQh8hrOlnNQY1OuuPMZjO
 PpzI0tL3Fw78LaxT9C5Bc9yheclr12O83zfBBP5X0d4o1C7qHogSI6YtxexkYgQD5d/XjlsA8DY
 SXxg==
X-Google-Smtp-Source: APBJJlFzBhJGxOU5/jiBdUZ9zwaXDa82Qc/U4OZwxPIwAy6i//JQya0PoOzoraapW7ivUqtATCUcGA==
X-Received: by 2002:a17:90b:ec5:b0:263:f896:2165 with SMTP id
 gz5-20020a17090b0ec500b00263f8962165mr14869879pjb.46.1689059051786; 
 Tue, 11 Jul 2023 00:04:11 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 l21-20020a170902d35500b001b9dab0397bsm1078724plk.29.2023.07.11.00.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 00:04:11 -0700 (PDT)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Jason Chien <jason.chien@sifive.com>
Subject: [PATCH v3 1/1] target/riscv: Add Zihintntl extension ISA string to DTS
Date: Tue, 11 Jul 2023 07:03:57 +0000
Message-Id: <20230711070402.5846-2-jason.chien@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230711070402.5846-1-jason.chien@sifive.com>
References: <20230711070402.5846-1-jason.chien@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x102a.google.com
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

Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
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


