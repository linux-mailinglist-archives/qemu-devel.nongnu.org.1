Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93882791767
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8wn-00039Z-U4; Mon, 04 Sep 2023 08:44:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wJ-0002Sz-Ck
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:26 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qd8wG-0004jm-IJ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:44:22 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52c74a2e8edso2066318a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693831456; x=1694436256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yBy9B8/ychOxzyt4MqhLID6RA2iJpJf7s2rkxq992Dw=;
 b=n9Zlk/JxQSQeyjWxZ0k1QN5K7D6XrWm2b3o4NH4540tb1b1p0D0S5lYxkMpbLlu9Ln
 H1SMqdDqu1dukMczUMpMWbkZR9uLMO22/ML7KlBxJGIjFhjVo+3vvMTW25/x6glgdtL8
 DcCs4wrq2XcUnM1Vnmj3a3qetfkln48Nd2uGWEREv6dXMQWYimxt6FQRPd8xpZhUtVqV
 +qFZBWGqzwdsdp73e6c3BUkDkiIWOpM6yg7C6b7EPGv2Rju8VRpNBLbAh+YkSY3S82J3
 TI5/VlF8z8afAfVniWqi9K78LYIeDB6vztQGZbgfMs+SLyMbfHAuCtWrSRz21BTbiMGQ
 peHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693831456; x=1694436256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yBy9B8/ychOxzyt4MqhLID6RA2iJpJf7s2rkxq992Dw=;
 b=KJcYLMlNtTAsTPezXPBq/J2nSdUHU3zjyf4Uh6g41gl+pxRSycscXOLr6uzmzjOfMK
 Dp+saZBAHoazXh2e6ALF6grcrZ8kPyAcMJ50qkdz1+rbzfZc0XcxZlsUhMVqta4+8Zrq
 UziNftkcSpdebalYuZVI6tVjyPiXl9bsSaeKjQHWKVkEtEFVtlReRQx7InX6WCif7FYI
 bnamYcw09jt/bJ+Wbyya3kGsAtv/V0IiuDJj8leycm/3vNHVIj4SL19CBKzFyPhwR8ce
 XLCF54Ror4fMMbJan/AZ2r4JoF1+Fdx6XWLcta93+WvjsnaNVexLE1w73VSkmNxOuz7t
 0KNA==
X-Gm-Message-State: AOJu0Yye3qeKDkc4nVQA1CZ0UquyxwvSrHB1LVtQY+dPysUdLBDJG7Ah
 nLR5kUvDDAizd/TwotveToCx/obHXo6xMvuR09k=
X-Google-Smtp-Source: AGHT+IG4z1vB/QZFvcTz4ZepoUXgBUZve8udAT7n1n0cJ/4FcFU6pkPiPnNOm13Rql1ddwKB2By5rQ==
X-Received: by 2002:aa7:d3d2:0:b0:523:2dd6:62bf with SMTP id
 o18-20020aa7d3d2000000b005232dd662bfmr8674466edr.34.1693831455850; 
 Mon, 04 Sep 2023 05:44:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 m7-20020aa7c2c7000000b00523a43f9b1dsm5777597edp.22.2023.09.04.05.44.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 05:44:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 08/13] target/i386: Allow elision of kvm_hv_vpindex_settable()
Date: Mon,  4 Sep 2023 14:43:19 +0200
Message-ID: <20230904124325.79040-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904124325.79040-1-philmd@linaro.org>
References: <20230904124325.79040-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Call kvm_enabled() before kvm_hv_vpindex_settable()
to let the compiler elide its call.

kvm-stub.c is now empty, remove it.

Suggested-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/x86.c               |  2 +-
 target/i386/kvm/kvm-stub.c  | 18 ------------------
 target/i386/kvm/meson.build |  2 --
 3 files changed, 1 insertion(+), 21 deletions(-)
 delete mode 100644 target/i386/kvm/kvm-stub.c

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d2920af792..ecf16ef402 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -424,7 +424,7 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
     cpu->thread_id = topo_ids.smt_id;
 
     if (hyperv_feat_enabled(cpu, HYPERV_FEAT_VPINDEX) &&
-        !kvm_hv_vpindex_settable()) {
+        kvm_enabled() && !kvm_hv_vpindex_settable()) {
         error_setg(errp, "kernel doesn't allow setting HyperV VP_INDEX");
         return;
     }
diff --git a/target/i386/kvm/kvm-stub.c b/target/i386/kvm/kvm-stub.c
deleted file mode 100644
index 62cccebee4..0000000000
--- a/target/i386/kvm/kvm-stub.c
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
- * QEMU KVM x86 specific function stubs
- *
- * Copyright Linaro Limited 2012
- *
- * Author: Peter Maydell <peter.maydell@linaro.org>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-#include "qemu/osdep.h"
-#include "kvm_i386.h"
-
-bool kvm_hv_vpindex_settable(void)
-{
-    return false;
-}
diff --git a/target/i386/kvm/meson.build b/target/i386/kvm/meson.build
index 40fbde96ca..5d9174bbb5 100644
--- a/target/i386/kvm/meson.build
+++ b/target/i386/kvm/meson.build
@@ -1,5 +1,3 @@
-i386_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
-
 i386_softmmu_kvm_ss = ss.source_set()
 
 i386_softmmu_kvm_ss.add(files(
-- 
2.41.0


