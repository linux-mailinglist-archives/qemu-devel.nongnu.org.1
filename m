Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E956688DA83
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Mar 2024 10:52:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpPwZ-0002FO-B7; Wed, 27 Mar 2024 05:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwX-0002F6-7q
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpPwV-0006cM-DY
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 05:51:37 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-56bf6591865so6191541a12.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711533093; x=1712137893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nBAy082BGnicpTR9HTkkFTBoGpDwmw0PRBVIrlqsu0g=;
 b=bvsrENBNyBTi72XTAyP7IbOMKmFqRwLZDQXozlVxVpjW+Vf+tGf2kEDB+r4PrNIGOH
 QcZbIwF/d/QQJ3H9STROQ55FDixzeR3VNUkebvMntYr3x2Qj+JeqneJpTS9kN7mLp74s
 2YaL/eDyE/NkpD78ykxs5no4Az0piPrSPIQMZNmflRoDi3KHr8GrkXdRvef6z05cCDRA
 SoR3uHwezKdRYDixhtHMmCtniOL3ClR/igE1mZEVZUVGViKfssXy1vYskMQluSHZWgKi
 fQW1TojObe+qLz+cCEilGnaZfJeU5zlyaTVxi0xRrrYjuz60xAdkAsYN0yKQ+Mu1no9K
 ZV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711533093; x=1712137893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nBAy082BGnicpTR9HTkkFTBoGpDwmw0PRBVIrlqsu0g=;
 b=OiqrGBZrRW85Jn5kzmjuPSaOE5DMoX5lE3/aw5RRPP0ItDOGSJ9wtDvrgWeKS+hpNA
 IpSEJAU60i8zDUyiXeFCrOwhB/fP4b/syISOCt3ak8SWtEwfNCTkgMKAkhIeoKL96Uem
 zaWTfPqq+Y9OO/zCx1w0b+bTlQpaUUIeiD3ZAgdwG3iM/xlgN+lODrlRe+VlF2akbzwm
 HQ7L8pO4A0XgFhwaYKm9FbQYD1YR91t8RwC6pcLaTnRF45T8qSQYz8+KppSThsYUwN+U
 jvUK6RPekOVT8AHV63D3L6LImK8g8Nz667XOsO1OcJ2pQzv31+LlxBCZqqlmAgWlllOG
 tuXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlcvu19RmtxYj8ea5wz+SaeJQ+n5seuPTwJ6h5vxLA/nnXoIGZRg0ala9suahFqETs65ozkQ34RQW8JCZf8Cvvqhm1Cks=
X-Gm-Message-State: AOJu0Yy1NHUaVrLka2RNRupAqW6f8vNLrZlpTr5BMvQ6m/CzLfSyAVpv
 IwilePfZA5UtLG4E3DZxYWUpPGs+r9mgAPIGkTvCCbDgyxu1n4eUa89aTHnuuZw=
X-Google-Smtp-Source: AGHT+IHRy81znAmxXO5ClOjnVu9DCPLIi8FYLPm1Dap94aWRip8C28mC3sIkpREG+9zqQDJivRmG9A==
X-Received: by 2002:a17:906:53ce:b0:a47:3526:81a3 with SMTP id
 p14-20020a17090653ce00b00a47352681a3mr2425820ejo.48.1711533093526; 
 Wed, 27 Mar 2024 02:51:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 x15-20020a1709060a4f00b00a455519bcb3sm5236741ejf.55.2024.03.27.02.51.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Mar 2024 02:51:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Zhao Liu <zhao1.liu@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH-for-9.1 v2 01/21] hw/i386/pc: Remove deprecated pc-i440fx-2.0
 machine
Date: Wed, 27 Mar 2024 10:51:03 +0100
Message-ID: <20240327095124.73639-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240327095124.73639-1-philmd@linaro.org>
References: <20240327095124.73639-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

The pc-i440fx-2.0 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240305134221.30924-2-philmd@linaro.org>
---
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    | 15 -------------
 hw/i386/pc_piix.c               | 37 ---------------------------------
 5 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 7b548519b5..b567415d62 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,7 +219,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
+``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f9cf874f7b..51119e623f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -816,7 +816,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-1.7`` (removed in 4.0 up to 8.2)
+``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27a68071d7..67856f54c3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -285,9 +285,6 @@ extern const size_t pc_compat_2_2_len;
 extern GlobalProperty pc_compat_2_1[];
 extern const size_t pc_compat_2_1_len;
 
-extern GlobalProperty pc_compat_2_0[];
-extern const size_t pc_compat_2_0_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index e80f02bef4..e7b6abf237 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -311,21 +311,6 @@ GlobalProperty pc_compat_2_1[] = {
 };
 const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
 
-GlobalProperty pc_compat_2_0[] = {
-    PC_CPU_MODEL_IDS("2.0.0")
-    { "virtio-scsi-pci", "any_layout", "off" },
-    { "PIIX4_PM", "memory-hotplug-support", "off" },
-    { "apic", "version", "0x11" },
-    { "nec-usb-xhci", "superspeed-ports-first", "off" },
-    { "nec-usb-xhci", "force-pcie-endcap", "on" },
-    { "pci-serial", "prog_if", "0" },
-    { "pci-serial-2x", "prog_if", "0" },
-    { "pci-serial-4x", "prog_if", "0" },
-    { "virtio-net-pci", "guest_announce", "off" },
-    { "ICH9-LPC", "memory-hotplug-support", "off" },
-};
-const size_t pc_compat_2_0_len = G_N_ELEMENTS(pc_compat_2_0);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 18ba076609..585231ef7b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,11 +441,6 @@ static void pc_compat_2_1_fn(MachineState *machine)
     x86_cpu_change_kvm_default("svm", NULL);
 }
 
-static void pc_compat_2_0_fn(MachineState *machine)
-{
-    pc_compat_2_1_fn(machine);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -872,38 +867,6 @@ static void pc_i440fx_2_1_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
                       pc_i440fx_2_1_machine_options);
 
-static void pc_i440fx_2_0_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_1_machine_options(m);
-    m->hw_version = "2.0.0";
-    compat_props_add(m->compat_props, pc_compat_2_0, pc_compat_2_0_len);
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    /* This value depends on the actual DSDT and SSDT compiled into
-     * the source QEMU; unfortunately it depends on the binary and
-     * not on the machine type, so we cannot make pc-i440fx-1.7 work on
-     * both QEMU 1.7 and QEMU 2.0.
-     *
-     * Large variations cause migration to fail for more than one
-     * consecutive value of the "-smp" maxcpus option.
-     *
-     * For small variations of the kind caused by different iasl versions,
-     * the 4k rounding usually leaves slack.  However, there could be still
-     * one or two values that break.  For QEMU 1.7 and QEMU 2.0 the
-     * slack is only ~10 bytes before one "-smp maxcpus" value breaks!
-     *
-     * 6652 is valid for QEMU 2.0, the right value for pc-i440fx-1.7 on
-     * QEMU 1.7 it is 6414.  For RHEL/CentOS 7.0 it is 6418.
-     */
-    pcmc->legacy_acpi_table_size = 6652;
-    pcmc->acpi_data_size = 0x10000;
-}
-
-DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
-                      pc_i440fx_2_0_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


