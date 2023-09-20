Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEAC7A74CE
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:49:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirxZ-0007CH-NX; Wed, 20 Sep 2023 03:49:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1qirxV-0007By-FY
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:49:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1qirxT-0007gT-9T
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:49:17 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40475103519so62467535e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695196153; x=1695800953; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1oB9CfeQ/Z/fpJsUaZhEoogiOZTeyWosaH8VFYq0qFo=;
 b=FD34IJxjxH5SAbKBOOlR80FCgfMwkF6mDYwq1QhObpxnZWzbsUf6UqmYywZ8Oz/2za
 gYLjn8Wc3U6FWjezBgQTuuZFKlNo/Ojg9fS/u5gAUoM7pqbNiJcc2rrOV/5A5M/8PGfX
 0Kg+EMaBNoGcU9yUb8qkg8Rj82XOadTkESV5bWnMRUhmHzqGPAjrLtABbBXawRHiX2jL
 O5go18awZl6FzEQqwrLLHHcL/KD0Psvl8rav92bRa3N9tROSFD9I2zalUZV+JhgaT0s8
 5tUWUIACO+Ae3ru/+9HkWd+PAubJe2v7xie3ea2W8SuAKzfnLYsFTMUumxLKjfIuZmMI
 4oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695196153; x=1695800953;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1oB9CfeQ/Z/fpJsUaZhEoogiOZTeyWosaH8VFYq0qFo=;
 b=A3/4ojybqZOaoR755fksup4wNEzAC/xCPMFzCDSLSfo05UTiE+cpYhAbnFjwYX/K9F
 X3v9vpWTz54mW+DkU007FNdwv49l+N6QjCcrWG4VMIzxfd2daYJGv9EAYJRZ2Zeg2/Jc
 Ou0qDNvnVH8GggeBZm9O8x2sVttPxBS3Z3jkYx/MLLmKpWLPc5qkQAIdIR5JYeETAfii
 60TW1OmGFt1lI+xmU76xqjpXtaS4xxsKKHMj1e4omaPewPrw1LYW0Tf5kIR989xI0L9t
 9lUKOGj8pdpGKNsaguY7A/+WgmMoH0A92nvPUzVcSOXrcCukJQGzE82A2DuQ8B9zWdxv
 +1lg==
X-Gm-Message-State: AOJu0Yw4dasnsEaPr+84kiypP9So6e9pjtCMM1wKT/CvNLean8EE/5xE
 CPNzRbkFQO4pzSZJOTKLDWA=
X-Google-Smtp-Source: AGHT+IFGPwzhxkCR5easQe/4cVFG8YK+ojAjNWV0alYz4yF+QNGJA03vGBde4VYAj5A35cfE1mS4Bg==
X-Received: by 2002:a5d:4c85:0:b0:321:6be7:d1be with SMTP id
 z5-20020a5d4c85000000b003216be7d1bemr1619699wrs.13.1695196152376; 
 Wed, 20 Sep 2023 00:49:12 -0700 (PDT)
Received: from jondnuc ([87.68.178.84]) by smtp.gmail.com with ESMTPSA id
 j15-20020a5d604f000000b0031779a6b451sm17536049wrt.83.2023.09.20.00.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 00:49:11 -0700 (PDT)
Date: Wed, 20 Sep 2023 10:49:10 +0300
From: Jon Doron <arilou@gmail.com>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
Subject: Re: Concerns regarding e17bebd049 ("dump: Set correct vaddr for ELF
 dump")
Message-ID: <ZQqj9tFS7cLMTkHv@jondnuc>
References: <87h6nqxdth.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6nqxdth.fsf@oracle.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Stephen,

Like you have said the reason is as I wrote in the commit message, 
without "fixing" the vaddr GDB is messing up mapping and working with 
the generated core file.

This patch is almost 4 years old, perhaps some changes to GDB has been 
introduced to resolve this, I have not checked since then.

As I'm no longer using this feature and have not worked and tested it 
in a long while, so I have no obligations to this change, but perhaps
someone else might be using it...

-- Jon.

On 19/09/2023, Stephen Brennan wrote:
>Hello all,
>
>I've started working on better support and documentation around
>hypervisor vmcores in the Drgn debugger[1]. Of course there's quite a
>lot of different implementations out there, but recently I'm looking at
>Qemu kdump and ELF vmcores generated via dump-guest-memory, and one
>thing caught my eye. I generated a ELF vmcore without the paging option
>enabled, and without the guest note loaded, and the resulting core
>dump's program header looked like this:
>
>$ eu-readelf -l dumpfile2
>Program Headers:
>  Type           Offset   VirtAddr           PhysAddr           FileSiz  MemSiz   Flg Align
>  NOTE           0x000168 0x0000000000000000 0x0000000000000000 0x001980 0x001980     0x0
>  LOAD           0x001ae8 0x0000000000000000 0x0000000000000000 0x80000000 0x80000000     0x0
>  LOAD           0x80001ae8 0x00000000fffc0000 0x00000000fffc0000 0x040000 0x040000     0x0
>
>In particular, the "VirtAddr" field for the loadable segment shows a
>confusing address - it appears to reuse the segment's physical address,
>despite the fact that there's no actual corresponding mapping.
>
>By comparison, the /proc/kcore and /proc/vmcore ELF vmcores use the
>VirtAddr in the program header to represent the real virtual memory
>mappings in use by the kernel. Debuggers can directly use these without
>needing to walk page tables. If there is no virtual memory mapping
>information available, I would have expected a placeholder value such as
>0000... or FFFF... to take the place of VirtAddr here so a debugger can
>detect the lack of virtual mappings and know that it needs to use
>architecture-specific details (and the vmcoreinfo) to find the page
>tables and accurately determine memory mappings. As it is, this program
>header seems to advertise to a debugger, "yes, we have the virtual
>memory mappings" when in fact, that's not the case.
>
>It seems that this behavior was introduced in e17bebd049 ("dump: Set
>correct vaddr for ELF dump")[2], a small commit I'll reproduce below.
>The justification seems to be that it fixes an issue reading the vmcore
>with GDB, but I wonder if that's not a GDB bug which should have been
>fixed with them? If GDB aims to support ELF kernel core dumps,
>presumably it should be handling physical addresses separately from
>virtual addresses. And if GDB doesn't aim for this, but you'd like to
>con it into reading your core dump, presumably the onus is on you to
>edit the ELF VirtAddr field to suit your needs? It should be QEMU's
>primary goal to produce a *correct* vmcore, not work around limitations
>or bugs in GDB.
>
>I'd like to propose reverting this, since it makes it impossible to
>interpret QEMU ELF vmcores, unless you discard all the virtual addresses
>in the program headers, and unconditionally do all the page table walks
>yourself. But I wanted to see if there was some justification for this
>behavior that I missed.
>
>Thanks,
>Stephen
>
>[1]: https://github.com/osandov/drgn
>[2]: https://lore.kernel.org/qemu-devel/20181225125344.4482-1-arilou@gmail.com/
>
>---
>
>commit e17bebd049d78f489c2cff755e2b66a0536a156e
>Author: Jon Doron <arilou@gmail.com>
>Date:   Wed Jan 9 10:22:03 2019 +0200
>
>    dump: Set correct vaddr for ELF dump
>
>    vaddr needs to be equal to the paddr since the dump file represents the
>    physical memory image.
>
>    Without setting vaddr correctly, GDB would load all the different memory
>    regions on top of each other to vaddr 0, thus making GDB showing the wrong
>    memory data for a given address.
>
>    Signed-off-by: Jon Doron <arilou@gmail.com>
>    Message-Id: <20190109082203.27142-1-arilou@gmail.com>
>    Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>    Tested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>    Acked-by: Laszlo Ersek <lersek@redhat.com>
>
>diff --git a/dump.c b/dump.c
>index ef1d8025c9..107a67165a 100644
>--- a/dump.c
>+++ b/dump.c
>@@ -192,7 +192,7 @@ static void write_elf64_load(DumpState *s, MemoryMapping *memory_mapping,
>     phdr.p_paddr = cpu_to_dump64(s, memory_mapping->phys_addr);
>     phdr.p_filesz = cpu_to_dump64(s, filesz);
>     phdr.p_memsz = cpu_to_dump64(s, memory_mapping->length);
>-    phdr.p_vaddr = cpu_to_dump64(s, memory_mapping->virt_addr);
>+    phdr.p_vaddr = cpu_to_dump64(s, memory_mapping->virt_addr) ?: phdr.p_paddr;
>
>     assert(memory_mapping->length >= filesz);
>
>@@ -216,7 +216,8 @@ static void write_elf32_load(DumpState *s, MemoryMapping *memory_mapping,
>     phdr.p_paddr = cpu_to_dump32(s, memory_mapping->phys_addr);
>     phdr.p_filesz = cpu_to_dump32(s, filesz);
>     phdr.p_memsz = cpu_to_dump32(s, memory_mapping->length);
>-    phdr.p_vaddr = cpu_to_dump32(s, memory_mapping->virt_addr);
>+    phdr.p_vaddr =
>+        cpu_to_dump32(s, memory_mapping->virt_addr) ?: phdr.p_paddr;
>
>     assert(memory_mapping->length >= filesz);
>
>diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
>index 198cd0fe40..2c587cbefc 100644
>--- a/scripts/dump-guest-memory.py
>+++ b/scripts/dump-guest-memory.py
>@@ -163,6 +163,7 @@ def add_segment(self, p_type, p_paddr, p_size):
>         phdr = get_arch_phdr(self.endianness, self.elfclass)
>         phdr.p_type = p_type
>         phdr.p_paddr = p_paddr
>+        phdr.p_vaddr = p_paddr
>         phdr.p_filesz = p_size
>         phdr.p_memsz = p_size
>         self.segments.append(phdr)

