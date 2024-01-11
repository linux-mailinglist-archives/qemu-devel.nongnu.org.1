Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA182A7DA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 07:48:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNoqm-0006PL-Vh; Thu, 11 Jan 2024 01:47:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNoqj-0006Ox-IO
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:47:34 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNoqh-0001ls-VD
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 01:47:33 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40e60c01112so1401695e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 22:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704955648; x=1705560448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b4rLIFz3jamF5IQE8fOjn3Vo0LdIj7ZxS3Uv6QB7pgQ=;
 b=BBhCz0cdlfSOhO0QjesgQoylhYt+rh9Z+5Euz/KGxl3hdvxv2/YbWLVTm0TMwIXGXu
 o4ius9wWtxEIpRssJKxmgmsKED7ApvD6jTJs8fTJV9seZmBBacg7FD7lNdGckm6ahQTe
 ZTVl4A9wrPmSRjYEv1VFVlVFAYzZqrvvdnpFuatAeDPgBi6HJnJVL8YxgnkqeVyjKanz
 ebIr8hhY0EaxtLfuUh/ane1MarcB4pVhH5MAp4lbwv22RzSWkdKbf/y2cpGh19KCpoe8
 EZXn7bypW1CA/oUXFmNF0LoVYClO1Ea1QRf7gznGKBKaSzZ5u3G3VlKSoc8ZmOHuq2jF
 simg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704955648; x=1705560448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b4rLIFz3jamF5IQE8fOjn3Vo0LdIj7ZxS3Uv6QB7pgQ=;
 b=SsLGZZr4aMn5mJ5NBnR8yXvRBG2yl70ymvmT7pzg7aQuGDQEuuqckF4phk7fib62ek
 fUBIok1mN6i2SXB2ad3iKV5Hg1wr7VenhGInkt4VSVpLuSejmeCVyGgGalLOdPXRaiMg
 weABaNFaHuXxli7B2KkoQlFK7onhzAN4f0FfxGhM6HHk4hWpPammywA8euEcdjSTXcwB
 5K5s0uuwat4NMf9Ji1dkTSsO+hF0+WAtLvXGqDrWLXRQS+kX/MBxJzw3L9paT9YMeRPz
 6Kb20Os4XmDLmG1jvwwWzrNTG5awY+ZXwxaN4WPKhbh1xAQM9vv130H6w7b4glYWDDp6
 o3hA==
X-Gm-Message-State: AOJu0Yxw1iAEYUyXG4le2OExICTu2SDXDaYpSSRue60a0fHN+ntiDJjU
 Aha44e2oNrMrC+YCoA1H6XdsiDKaoWFaXIf2za4q8eeHFuM=
X-Google-Smtp-Source: AGHT+IEvv6PGl8OJK8VqCXpwjb/3SBRfziDD78uPfd0ekPy5or38xv7r0oBGHXV1YGouweywSXai9g==
X-Received: by 2002:a05:600c:6cf:b0:40e:4e43:db55 with SMTP id
 b15-20020a05600c06cf00b0040e4e43db55mr105241wmn.70.1704955648385; 
 Wed, 10 Jan 2024 22:47:28 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 i10-20020a5d438a000000b00336344c3c3fsm359398wrq.90.2024.01.10.22.47.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 22:47:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] hw/core: Handle cpu_model_from_type() returning NULL value
Date: Thu, 11 Jan 2024 07:47:23 +0100
Message-ID: <20240111064723.6920-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Per cpu_model_from_type() docstring (added in commit 445946f4dd):

  * Returns: CPU model name or NULL if the CPU class doesn't exist

We must check the return value in order to avoid surprises, i.e.:

 $ qemu-system-arm -machine virt -cpu cortex-a9
  qemu-system-arm: Invalid CPU model: cortex-a9
  The valid models are: cortex-a7, cortex-a15, (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), (null), max

Add assertions when the call can not fail (because the CPU type
must be registered).

Fixes: 5422d2a8fa ("machine: Print CPU model name instead of CPU type")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu-target.c          | 1 +
 hw/core/machine.c     | 5 +++++
 target/ppc/cpu_init.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/cpu-target.c b/cpu-target.c
index 5eecd7ea2d..b0f6deb13b 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -291,6 +291,7 @@ static void cpu_list_entry(gpointer data, gpointer user_data)
     const char *typename = object_class_get_name(OBJECT_CLASS(data));
     g_autofree char *model = cpu_model_from_type(typename);
 
+    assert(model);
     if (cc->deprecation_note) {
         qemu_printf("  %s (deprecated)\n", model);
     } else {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index fc239101f9..730ec10328 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1422,16 +1422,21 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
         /* The user specified CPU type isn't valid */
         if (!mc->valid_cpu_types[i]) {
             g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+            assert(requested);
             error_setg(errp, "Invalid CPU model: %s", requested);
             if (!mc->valid_cpu_types[1]) {
                 g_autofree char *model = cpu_model_from_type(
                                                  mc->valid_cpu_types[0]);
+                assert(model);
                 error_append_hint(errp, "The only valid type is: %s\n", model);
             } else {
                 error_append_hint(errp, "The valid models are: ");
                 for (i = 0; mc->valid_cpu_types[i]; i++) {
                     g_autofree char *model = cpu_model_from_type(
                                                  mc->valid_cpu_types[i]);
+                    if (!model) {
+                        continue;
+                    }
                     error_append_hint(errp, "%s%s",
                                       model,
                                       mc->valid_cpu_types[i + 1] ? ", " : "");
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 344196a8ce..58f0c1e30e 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7037,6 +7037,7 @@ static void ppc_cpu_list_entry(gpointer data, gpointer user_data)
     }
 
     name = cpu_model_from_type(typename);
+    assert(name);
     qemu_printf("PowerPC %-16s PVR %08x\n", name, pcc->pvr);
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
         PowerPCCPUAlias *alias = &ppc_cpu_aliases[i];
-- 
2.41.0


