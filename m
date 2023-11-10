Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D247E7DE0
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 17:45:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1UdA-0006Dq-6D; Fri, 10 Nov 2023 11:45:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1r1Ucs-0006D6-Sq
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:44:58 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1r1Uco-00028l-JM
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 11:44:57 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1f256362bb5so1236860fac.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 08:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=koconnor.net; s=google; t=1699634689; x=1700239489; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zP7UhUYM+EQAVfTXC+oVS+BsNjuyUvHvyNAGZvlBBYM=;
 b=V0h9wRbxzcNMOAFSbIhsKotp9SmyAHmMtB1CNebCD7H7KQrpwKacO+xdzkIcdB/G45
 sKsl9HBDWRXbIP5ZWCQtwuX8jNF6JoKJDH+tcn/RcpSzhIh2SlYygBTHldvlJws6gUOq
 Co3GJ0+0bFipJOjCv9lZCzl22VTc+3rBiBtJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699634689; x=1700239489;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zP7UhUYM+EQAVfTXC+oVS+BsNjuyUvHvyNAGZvlBBYM=;
 b=egav1vNHrdD19b6HGuD08cCyJym/9lyZE4cShb7xxYAO9+RXuANWxR05WS1YlNhNJR
 TeeAWFoithVKK0CU3UyFtNu4Oa0P6fGennoRTlUAd+kz5R9i4I1eyZCcmDAxcP1rqsLa
 p6XONOpnr4ud9lfitVsKS5uIo9iu7IJzupYu/G295wH6gLS0SFYOWr+jtzvSD1OH+bgl
 CuxEW5qufe5WK/RLyx6uyDOAat+AAyAVEtsYGDpjiSNKKL17o1WNNCzuQ7J2lWOdlYfK
 Es65WgpEkeZflBaSzYkjKYDANZG9q0n8CExGeNI/ARC8H6ee374UNTIGWkRqD8X+QaYU
 0NGA==
X-Gm-Message-State: AOJu0YwltonQihOA/hrN86XXUe9kUcIaNjo25hQvCrBAuX+2WcV/7E59
 OJ7TkQzhCkI235rgUovpeT3wGA==
X-Google-Smtp-Source: AGHT+IF6xIniB2kufPUdqOFVM6bLSEIVxzr/Noui/NMAQxmFb0SuapcxlD9V+oAWxVzfjp6ANgIbrA==
X-Received: by 2002:a05:6871:4a02:b0:1bb:509a:824f with SMTP id
 tz2-20020a0568714a0200b001bb509a824fmr7313875oab.55.1699634689691; 
 Fri, 10 Nov 2023 08:44:49 -0800 (PST)
Received: from localhost ([64.18.11.67]) by smtp.gmail.com with ESMTPSA id
 i4-20020a05620a0a0400b007757eddae8bsm803819qka.62.2023.11.10.08.44.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 08:44:49 -0800 (PST)
Date: Fri, 10 Nov 2023 11:44:48 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Claudio Fontana <cfontana@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, seabios@seabios.org,
 qemu-devel@nongnu.org
Subject: Re: [SeaBIOS] [PATCH v5] limit physical address space size
Message-ID: <ZU5eAKNwo4kxVG8R@morn>
References: <20231107130309.3257776-1-kraxel@redhat.com>
 <ZUvVCHWbU29+eDm7@morn>
 <59437ef3-7b94-2aa4-31b4-012412ce160b@suse.de>
 <npmimli5x4vcwxb3csaaut3sobuzsex7pgtf4xbrbnfd22hnyz@ixh5tmn4xkpk>
 <iqerqemhgokkgemaxnfktoz6ssrk3uqc4bncoghmhhxaaycleo@u5k642niiya3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iqerqemhgokkgemaxnfktoz6ssrk3uqc4bncoghmhhxaaycleo@u5k642niiya3>
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=kevin@koconnor.net; helo=mail-oa1-x35.google.com
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

On Fri, Nov 10, 2023 at 12:04:24PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > This only changes the placement of the PCI bars.  The pci setup code is
> > the only consumer of that variable, guess it makes sense to move the
> > quirk to the pci code (as suggested by Kevin) to clarify this.
> 
> i.e. like this:
> 
> From d538dc7d4316e557ae302464252444d09de0681d Mon Sep 17 00:00:00 2001
> From: Gerd Hoffmann <kraxel@redhat.com>
> Date: Tue, 7 Nov 2023 13:49:31 +0100
> Subject: [PATCH] limit physical address space size
> 
> For better compatibility with old linux kernels,
> see source code comment.
> 
> Related (same problem in ovmf):
> https://github.com/tianocore/edk2/commit/c1e853769046
> 
> Reported-by: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  src/fw/pciinit.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
> index c7084f5e397e..7aeea61bfd05 100644
> --- a/src/fw/pciinit.c
> +++ b/src/fw/pciinit.c
> @@ -52,6 +52,7 @@ u64 pcimem64_start = BUILD_PCIMEM64_START;
>  u64 pcimem64_end   = BUILD_PCIMEM64_END;
>  u64 pci_io_low_end = 0xa000;
>  u32 pci_use_64bit  = 0;
> +u32 pci_phys_bits  = 0;

FWIW, all these flags are getting a bit confusing.  Maybe do something
like the patch below.

>  
>  struct pci_region_entry {
>      struct pci_device *dev;
> @@ -967,7 +968,7 @@ static int pci_bios_check_devices(struct pci_bus *busses)
>              if (hotplug_support == HOTPLUG_PCIE)
>                  resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
>              if (hotplug_support && pci_use_64bit && is64 && (type == PCI_REGION_TYPE_PREFMEM))
> -                align = (u64)1 << (CPUPhysBits - 11);
> +                align = (u64)1 << (pci_phys_bits - 11);
>              if (align > sum && hotplug_support && !resource_optional)
>                  sum = align; /* reserve min size for hot-plug */
>              if (size > sum) {
> @@ -1131,12 +1132,12 @@ static void pci_bios_map_devices(struct pci_bus *busses)
>          r64_mem.base = le64_to_cpu(romfile_loadint("etc/reserved-memory-end", 0));
>          if (r64_mem.base < 0x100000000LL + RamSizeOver4G)
>              r64_mem.base = 0x100000000LL + RamSizeOver4G;
> -        if (CPUPhysBits) {
> -            u64 top = 1LL << CPUPhysBits;
> +        if (pci_phys_bits) {

FYI, this is a change in behavior - previously this condition would
have been taken even if CPULongMode or RamSizeOver4G is false.  I'm
not sure if this change is intentional.  (My example patch below
follows your lead here.)

> +            u64 top = 1LL << pci_phys_bits;
>              u64 size = (ALIGN(sum_mem, (1LL<<30)) +
>                          ALIGN(sum_pref, (1LL<<30)));
>              if (pci_use_64bit)
> -                size = ALIGN(size, (1LL<<(CPUPhysBits-3)));
> +                size = ALIGN(size, (1LL<<(pci_phys_bits-3)));
>              if (r64_mem.base < top - size) {
>                  r64_mem.base = top - size;
>              }
> @@ -1181,8 +1182,16 @@ pci_setup(void)
>  
>      dprintf(3, "pci setup\n");
>  
> -    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G)
> +    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G) {
>          pci_use_64bit = 1;
> +        pci_phys_bits = CPUPhysBits;
> +        if (pci_phys_bits > 46) {
> +            // Old linux kernels have trouble dealing with more than 46
> +            // phys-bits, so avoid that for now.  Seems to be a bug in the
> +            // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
> +            pci_phys_bits = 46;
> +        }
> +    }
>  
>      dprintf(1, "=== PCI bus & bridge init ===\n");
>      if (pci_probe_host() != 0) {
> -- 
> 2.41.0
>


Possible alternate variable naming:

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index c7084f5..cd64d6e 100644
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
+// Memory resource allocation tracking
+static u64 pci_io_low_end = 0xa000;
+static u32 pci_use_64bit  = 0;
+static u64 pci_mem64_top  = 0;
 
 struct pci_region_entry {
     struct pci_device *dev;
@@ -966,8 +970,9 @@ static int pci_bios_check_devices(struct pci_bus *busses)
             int resource_optional = 0;
             if (hotplug_support == HOTPLUG_PCIE)
                 resource_optional = pcie_cap && (type == PCI_REGION_TYPE_IO);
-            if (hotplug_support && pci_use_64bit && is64 && (type == PCI_REGION_TYPE_PREFMEM))
-                align = (u64)1 << (CPUPhysBits - 11);
+            if (hotplug_support && pci_use_64bit && is64
+                && (type == PCI_REGION_TYPE_PREFMEM))
+                align = pci_mem64_top >> 11;
             if (align > sum && hotplug_support && !resource_optional)
                 sum = align; /* reserve min size for hot-plug */
             if (size > sum) {
@@ -1131,14 +1136,13 @@ static void pci_bios_map_devices(struct pci_bus *busses)
         r64_mem.base = le64_to_cpu(romfile_loadint("etc/reserved-memory-end", 0));
         if (r64_mem.base < 0x100000000LL + RamSizeOver4G)
             r64_mem.base = 0x100000000LL + RamSizeOver4G;
-        if (CPUPhysBits) {
-            u64 top = 1LL << CPUPhysBits;
+        if (pci_mem64_top) {
             u64 size = (ALIGN(sum_mem, (1LL<<30)) +
                         ALIGN(sum_pref, (1LL<<30)));
             if (pci_use_64bit)
-                size = ALIGN(size, (1LL<<(CPUPhysBits-3)));
-            if (r64_mem.base < top - size) {
-                r64_mem.base = top - size;
+                size = ALIGN(size, pci_mem64_top >> 3);
+            if (r64_mem.base < pci_mem64_top - size) {
+                r64_mem.base = pci_mem64_top - size;
             }
             if (e820_is_used(r64_mem.base, size))
                 r64_mem.base -= size;
@@ -1181,8 +1185,16 @@ pci_setup(void)
 
     dprintf(3, "pci setup\n");
 
-    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G)
+    if (CPUPhysBits >= 36 && CPULongMode && RamSizeOver4G) {
         pci_use_64bit = 1;
+        pci_mem64_top = 1LL << CPUPhysBits;
+        if (CPUPhysBits > 46) {
+            // Old linux kernels have trouble dealing with more than 46
+            // phys-bits, so avoid that for now.  Seems to be a bug in the
+            // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
+            pci_mem64_top = 1LL << 46;
+        }
+    }
 
     dprintf(1, "=== PCI bus & bridge init ===\n");
     if (pci_probe_host() != 0) {


Cheers,
-Kevin

