Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4A37923AD
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 16:52:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXPV-0001b9-V1; Tue, 05 Sep 2023 10:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXPT-0001aK-45
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:52:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdXPP-0004qH-U9
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 10:52:06 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so2290236f8f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693925522; x=1694530322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Aj/k5ei/HoslYuKYXUEeJtwy9gqYX4RgxXvRAwOL6fc=;
 b=ho98EVyAVTwzszLBym2LZXCjTsKvdMuJb8ekl8BqBEosNPui2U+4/UYAKPMpf/ViAR
 Dg3d2IOQAQFD6+lyN0bAnw6TjfILLrXXKZEDkMOQBWG/nwlD3MG1cjiX5N4joVb25swZ
 PwsbfZ1s+uU5OGSv6gA7lSqWHdD0XuxhaYPIno9VvTCeWwteowLQAnpmWGmMn+tOa86B
 Lz/aiGqSJS46ZHNh9MhOGNcZ88Sc2zdkqWwL5RRdZWnSHVp5Iuie8zVysxW2cWOiYAHS
 C7OU+VNgAaUsYDn9Qzf9s8t93rdAvpaDOa5sOEecPkvVP2/wSNzpBWud9P3HFEAVkrk0
 vG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693925522; x=1694530322;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Aj/k5ei/HoslYuKYXUEeJtwy9gqYX4RgxXvRAwOL6fc=;
 b=AhTEQgo2Axu/2kpfXEORKNMLS1A6j3288XL2xNcNbmeGTuB39q6Q6KzaYHkpvMi/cG
 Xy+IvQCzEq5zj81j2Yflze7F//rxE/dBn//JU0lwfQRxvnoinMbCDPL9zIq4sLBrZAkk
 YJsWezR76uOLxR0aMD3Kc7FPl1v6J0O6NAfSVhFdzxuKfdDHd+SL1QXQGo95AC4gpUiK
 fw8SyMKrdT92kIGbuNAZtVYINCZLgWGSYR4EWyLpCtRpM0IcMBnqwbl8NTG2mCqKiE00
 37y9dnERes5XbMoGeQFfFdDDvkEXbCG5t/In637TSKj/FrREA2XR+oXhsV3W24Mr4YbV
 TN8w==
X-Gm-Message-State: AOJu0YwzcktqXkmb8q93WYJcHeDgdMbTsyCfrlO5C0ZvkwAZtibNH7dJ
 hl+j1VkfJh+9mBd6J+F/wKWSiR7EvApGhPmFLCc=
X-Google-Smtp-Source: AGHT+IEq8KT/Rmc8M8bzyOH6ajom94gOwZzzsnFebgf8IqDwj/OtmWfFILeeM9CdG1t6TiGqSeJpQQ==
X-Received: by 2002:a5d:4570:0:b0:31c:8880:5d0f with SMTP id
 a16-20020a5d4570000000b0031c88805d0fmr65153wrc.11.1693925522007; 
 Tue, 05 Sep 2023 07:52:02 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 y23-20020a7bcd97000000b003fbc9d178a8sm20593405wmj.4.2023.09.05.07.52.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 07:52:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/i386: Rename kvmvapic.c -> vapic.c
Date: Tue,  5 Sep 2023 16:51:59 +0200
Message-ID: <20230905145159.7898-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

vAPIC isn't KVM specific, so having its name prefixed 'kvm'
is misleading. Rename it simply 'vapic'. Rename the single
function prefixed 'kvm'.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Interestingly there is a strong dependency on (Kconfig) APIC,
but I couldn't get a single x86 machine building without the
Kconfig 'APIC' key.
---
 hw/i386/{kvmvapic.c => vapic.c} | 5 ++---
 hw/i386/meson.build             | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)
 rename hw/i386/{kvmvapic.c => vapic.c} (99%)

diff --git a/hw/i386/kvmvapic.c b/hw/i386/vapic.c
similarity index 99%
rename from hw/i386/kvmvapic.c
rename to hw/i386/vapic.c
index 43f8a8f679..35e3a56b35 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/vapic.c
@@ -747,8 +747,7 @@ static void do_vapic_enable(CPUState *cs, run_on_cpu_data data)
     s->state = VAPIC_ACTIVE;
 }
 
-static void kvmvapic_vm_state_change(void *opaque, bool running,
-                                     RunState state)
+static void vapic_vm_state_change(void *opaque, bool running, RunState state)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     VAPICROMState *s = opaque;
@@ -793,7 +792,7 @@ static int vapic_post_load(void *opaque, int version_id)
 
     if (!s->vmsentry) {
         s->vmsentry =
-            qemu_add_vm_change_state_handler(kvmvapic_vm_state_change, s);
+            qemu_add_vm_change_state_handler(vapic_vm_state_change, s);
     }
     return 0;
 }
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index cfdbfdcbcb..4909703a89 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -1,7 +1,7 @@
 i386_ss = ss.source_set()
 i386_ss.add(files(
   'fw_cfg.c',
-  'kvmvapic.c',
+  'vapic.c',
   'e820_memory_layout.c',
   'multiboot.c',
   'x86.c',
-- 
2.41.0


