Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3974B027
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjie-0007IR-LX; Fri, 07 Jul 2023 07:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjid-0007Gv-2j; Fri, 07 Jul 2023 07:33:47 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjib-00073F-2s; Fri, 07 Jul 2023 07:33:46 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5634d8d1db0so1348486eaf.0; 
 Fri, 07 Jul 2023 04:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729623; x=1691321623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tOjAEOyitW8En/gKHjIOGm/jesZx5icwf+MIpZ7SZwI=;
 b=s4SvdQ7FWgKDDql7/W1/yavoXGoEf9P5+Z689MLRRrF+vGDMy9Yveh1FCjKobmmMPz
 Z0h6kwtsE5Yqj4jeYumI4vesUEeqB08DixuBVXzapdgZb/8kXTDuMcFCoT6Yj8uWXdMu
 QhWyCqWyE4HsNAB0HexmDKVHykIB9/jnMThb/jhLbY04vAhtRRzSMYH6ocYhLaQW+RHw
 40E/64f/5mwAKBXknUeHA3x3XnTW/fv0txSWgNam9WrQcsm9KrlgbkRNUdNgqRumw97Z
 ypdPoM1EDMqfgs0U3vc4CXTfdE5XMIolDEjUCJ+JPhLY0hRVpdA8BTJ0ADs6aVOwNTau
 EgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729623; x=1691321623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tOjAEOyitW8En/gKHjIOGm/jesZx5icwf+MIpZ7SZwI=;
 b=CWv1veZ5bV1U7WIJ6nTTHFYxnoj3to5Mn7Tx78Ksop7OaK3S6xtbz2zJ2Rkq1iPQPM
 PYsCdMKbsXPkT6FeJWhDIfnhEP1erdPfIZBSdd9cUsjilqTQIMXza700zLn+vLqv6p7y
 9zjfTzjjA0L0XqWplb+I8UQ0vgJSXo+PV3Z72KErgDi2Nf9GHGAK9ecJFCJcKT8tDhlX
 tEpf3XJ56xC4jCAOe4vUh34GYDhdl+ABYNCVp04vT0mlQ5yXYFZQWySG2boqWzh0z9/G
 wB5nIHwI2oR1tATpPbGBJvmBkwvyythLYehg2D/lGGr4M5PLLZIRTT7FfSMY17ezjZjA
 jOZg==
X-Gm-Message-State: ABy/qLZoI6gx1E6UtlMEUKKb6TNr86AXBIw3X5i7hQ0Mquj5D5HRqnvH
 ySyTftHFy7GSoJ5pO0W+EEaBkr3cIsA=
X-Google-Smtp-Source: APBJJlHNE6PwtkTOtxTe7ygEX7lAQe0LUuI1BoOom/QHyhQ5Lpgy4nzG5htxHaK4mRaAO+NzkJVURg==
X-Received: by 2002:a4a:2c89:0:b0:563:2489:dfe6 with SMTP id
 o131-20020a4a2c89000000b005632489dfe6mr3870477ooo.5.1688729623431; 
 Fri, 07 Jul 2023 04:33:43 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:33:43 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Greg Kurz <groug@kaod.org>
Subject: [PULL 56/60] target/ppc: Define TYPE_HOST_POWERPC_CPU in cpu-qom.h
Date: Fri,  7 Jul 2023 08:31:04 -0300
Message-ID: <20230707113108.7145-57-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=danielhb413@gmail.com; helo=mail-oo1-xc36.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TYPE_HOST_POWERPC_CPU is used in various places of cpu_init.c,
in order to restrict "kvm_ppc.h" to sysemu, move this QOM-related
definition to cpu-qom.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-ID: <20230627115124.19632-5-philmd@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/cpu-qom.h | 2 ++
 target/ppc/kvm_ppc.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index c2a66a90f7..be33786bd8 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -35,6 +35,8 @@ OBJECT_DECLARE_CPU_TYPE(PowerPCCPU, PowerPCCPUClass, POWERPC_CPU)
 #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
 #define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
 
+#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
+
 ObjectClass *ppc_cpu_class_by_name(const char *name);
 
 typedef struct CPUArchState CPUPPCState;
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 49954a300b..901e188c9a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -13,8 +13,6 @@
 #include "exec/hwaddr.h"
 #include "cpu.h"
 
-#define TYPE_HOST_POWERPC_CPU POWERPC_CPU_TYPE_NAME("host")
-
 #ifdef CONFIG_KVM
 
 uint32_t kvmppc_get_tbfreq(void);
-- 
2.41.0


