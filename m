Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 362D67E7E00
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:06:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1UwP-0006ry-Rf; Fri, 10 Nov 2023 12:05:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1r1UwO-0006rh-37
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:05:08 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1r1UwM-0006QZ-DG
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:05:07 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41c157bbd30so14770321cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 09:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=koconnor.net; s=google; t=1699635905; x=1700240705; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Bwh3BGIGBAH45Tbe+acgCu7li5SjWHmyNADyZQRg2mQ=;
 b=hj6IjHukLll5rwSXISduZM0g4vv672hkeuXZvCa8Q0aZQqzqg1MvQZcrEzvMbv1dAu
 Kei9ByhXvwbN13tSVb5MOy8MioX2kRFmZlwicbfjJonnWVYDHaag7GYopp8d8fEIZITW
 9bPPoV8nX5AvjN2WbVazYoJXKFVLYxQBMn9ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699635905; x=1700240705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bwh3BGIGBAH45Tbe+acgCu7li5SjWHmyNADyZQRg2mQ=;
 b=i8BYFgiMrZ+8IRFWTAuzhyB0OTEeGvXTNbT5pu1YFfUHHBjbKM8mg0g/8PECXL1e/n
 8eCGgpLeeJHUtwJu8rlR9wBggfdxA6qgQLiorgtLNNGsRguv2jN+axVTmDJmK8p6CmnS
 YyLGEnk/j6hNUtE250cDmXunZvz2V606Kv7lNYTJa+qG4MFHw2V6e5WPU1/a7IXJAjGb
 COoKtR/dBfoJUiyiTNt66QbVwfE3ae8XKetayE/2LQPUaVBDCjNjrknAmaQsGBJSdF47
 bbvFpM/hWvjs+sjQfOmnBFjwzdSMn6PL6LuOEH8/jYlHqyD9HuansyBe9hfbv/aNQ969
 nUyQ==
X-Gm-Message-State: AOJu0YwKvQDyEb0WJp6n54Ff9g1riQ0YSgMIuUymRX7+/WSXD/pVjYMW
 h5udW0KwR1VaQ8gvZev7m2GLrw==
X-Google-Smtp-Source: AGHT+IG8/chLjso3Q+5AiZ2LJUiTtOrTNGdxuP4MAAJtYdkPLOaI51QRJAP8s98OcCamYclwzyVmvg==
X-Received: by 2002:a05:622a:6:b0:421:bbb8:e70b with SMTP id
 x6-20020a05622a000600b00421bbb8e70bmr749858qtw.27.1699635905025; 
 Fri, 10 Nov 2023 09:05:05 -0800 (PST)
Received: from localhost ([64.18.11.67]) by smtp.gmail.com with ESMTPSA id
 h6-20020ac85686000000b0041818df8a0dsm2909785qta.36.2023.11.10.09.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 09:05:04 -0800 (PST)
Date: Fri, 10 Nov 2023 12:05:03 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, seabios@seabios.org,
 qemu-devel@nongnu.org
Subject: Re: [SeaBIOS] [PATCH v5] limit physical address space size
Message-ID: <ZU5iv5dSNyyoisTN@morn>
References: <20231107130309.3257776-1-kraxel@redhat.com>
 <ZUvVCHWbU29+eDm7@morn>
 <59437ef3-7b94-2aa4-31b4-012412ce160b@suse.de>
 <npmimli5x4vcwxb3csaaut3sobuzsex7pgtf4xbrbnfd22hnyz@ixh5tmn4xkpk>
 <iqerqemhgokkgemaxnfktoz6ssrk3uqc4bncoghmhhxaaycleo@u5k642niiya3>
 <ZU5eAKNwo4kxVG8R@morn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZU5eAKNwo4kxVG8R@morn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=kevin@koconnor.net; helo=mail-qt1-x82f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Nov 10, 2023 at 11:44:48AM -0500, Kevin O'Connor wrote:
> On Fri, Nov 10, 2023 at 12:04:24PM +0100, Gerd Hoffmann wrote:
> > -        if (CPUPhysBits) {
> > -            u64 top = 1LL << CPUPhysBits;
> > +        if (pci_phys_bits) {
> 
> FYI, this is a change in behavior - previously this condition would
> have been taken even if CPULongMode or RamSizeOver4G is false.  I'm
> not sure if this change is intentional.  (My example patch below
> follows your lead here.)
> 

On closer inspection, I think this change in behavior was not
intended.  How about variable names like the below instead.

-Kevin


diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index c7084f5..6b13cd5 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -46,12 +46,16 @@ static const char *region_type_name[] = {
     [ PCI_REGION_TYPE_PREFMEM ] = "prefmem",
 };
 
+// Memory ranges exported to legacy ACPI type table generation
 u64 pcimem_start   = BUILD_PCIMEM_START;
 u64 pcimem_end     = BUILD_PCIMEM_END;
 u64 pcimem64_start = BUILD_PCIMEM64_START;
 u64 pcimem64_end   = BUILD_PCIMEM64_END;
-u64 pci_io_low_end = 0xa000;
-u32 pci_use_64bit  = 0;
+
+// Resource allocation limits
+static u64 pci_io_low_end = 0xa000;
+static u64 pci_mem64_top  = 0;
+static u32 pci_pad_mem64  = 0;
 
 struct pci_region_entry {
     struct pci_device *dev;
@@ -966,8 +970,9 @@ static int pci_bios_check_devices(struct pci_bus *busses)
             int resource_optional = 0;
             if (hotplug_support == HOTPLUG_PCIE)
                 resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
-            if (hotplug_support && pci_use_64bit && is64 && (type == PCI_REGION_TYPE_PREFMEM))
-                align = (u64)1 << (CPUPhysBits - 11);
+            if (hotplug_support && pci_pad_mem64 && is64
+                && (type == PCI_REGION_TYPE_PREFMEM))
+                align = pci_mem64_top >> 11;
             if (align > sum && hotplug_support && !resource_optional)
                 sum = align; /* reserve min size for hot-plug */
             if (size > sum) {
@@ -1111,7 +1116,7 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         panic("PCI: out of I/O address space\n");
 
     dprintf(1, "PCI: 32: %016llx - %016llx\n", pcimem_start, pcimem_end);
-    if (pci_use_64bit || pci_bios_init_root_regions_mem(busses)) {
+    if (pci_pad_mem64 || pci_bios_init_root_regions_mem(busses)) {
         struct pci_region r64_mem, r64_pref;
         r64_mem.list.first = NULL;
         r64_pref.list.first = NULL;
@@ -1131,14 +1136,13 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         r64_mem.base = le64_to_cpu(romfile_loadint("etc/reserved-memory-end", 0));
         if (r64_mem.base < 0x100000000LL + RamSizeOver4G)
             r64_mem.base = 0x100000000LL + RamSizeOver4G;
-        if (CPUPhysBits) {
-            u64 top = 1LL << CPUPhysBits;
+        if (pci_mem64_top) {
             u64 size = (ALIGN(sum_mem, (1LL<<30)) +
                         ALIGN(sum_pref, (1LL<<30)));
-            if (pci_use_64bit)
-                size = ALIGN(size, (1LL<<(CPUPhysBits-3)));
-            if (r64_mem.base < top - size) {
-                r64_mem.base = top - size;
+            if (pci_pad_mem64)
+                size = ALIGN(size, pci_mem64_top >> 3);
+            if (r64_mem.base < pci_mem64_top - size) {
+                r64_mem.base = pci_mem64_top - size;
             }
             if (e820_is_used(r64_mem.base, size))
                 r64_mem.base -= size;
@@ -1181,8 +1185,18 @@ pci_setup(void)
 
     dprintf(3, "pci setup\n");
 
+    if (CPUPhysBits) {
+        pci_mem64_top = 1LL << CPUPhysBits;
+        if (CPUPhysBits > 46) {
+            // Old linux kernels have trouble dealing with more than 46
+            // phys-bits, so avoid that for now.  Seems to be a bug in the
+            // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
+            pci_mem64_top = 1LL << 46;
+        }
+    }
+
     if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G)
-        pci_use_64bit = 1;
+        pci_pad_mem64 = 1;
 
     dprintf(1, "=== PCI bus & bridge init ===\n");
     if (pci_probe_host() != 0) {

