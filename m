Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B337C7EA249
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:45:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2az8-0005tw-2m; Mon, 13 Nov 2023 12:44:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2az6-0005tS-72
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:44:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1r2az3-0002qe-TH
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:44:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1cc131e52f1so42411045ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1699897464; x=1700502264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gnSo2+UetrKjdnU5+rIUqmhfiSCC40dEvQmge0DnEmg=;
 b=SkXU6DHdgXqLlCsU8adSEwrXsqTYCNVPsPVaPxCpD+6iV9r+8bMgbBbyX0TpckTgez
 Al4ctIFBGaEAu9NHxTCskZkD+8gU0JVGmnu5tup36f24xJRsBdAcGp2duh0AZakDYxnZ
 RR4ignNHmhbIzv+sW9Mb+KKOTNCQ71uMOlh3R2wGMEopJ8Mz5XTo+9o8i3Jc4eHNubS6
 Cd7l/muRe0yoWLODoGSvDaIEpwQf+W9ffo03o2LwkSO0MMWlC0fTACnXr8fWY+IrDH+b
 EPqUqK3UeIEvRp+YyYp4uQBsQcp697SiE5RRzz29Mif1M8BfSWLmxARFY8QcWBQ7WkDD
 yf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897464; x=1700502264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gnSo2+UetrKjdnU5+rIUqmhfiSCC40dEvQmge0DnEmg=;
 b=D2ihuPqHvak7A/DSxbiMBhm+jzaouS/J2oW0clmwBi+un20yqrBTL74QpmIrMuVXRz
 m9IcO8D3X0W2fZfyjd8oTswNI1A2gCK7nRoajki5C/nDdg+UzCMBOXqoF5xmAeEbIyma
 82I8zgnEpMCn9wFdvu1RVNhDCvk9bC8fiWIdXkNQex/K7BYZOFwG97KYi/d5GNV3Ytzc
 /mCWc6X9yI6WU9Tj5ix75/u5UnXi2E97HpZmNIelhojEjjiN916nimuCNQj4fJz66UFw
 P4NmZ3OedUXyKMX11+Jb3czfCys4aj4Gr+o14kwETO1HUbTdTl9b9AUSvwgoMrUzlwCe
 tozg==
X-Gm-Message-State: AOJu0YxFNi0vuuY7DJyHXMeXa9mQAQeJvcke3JM3LCScaRjHPiOSg5dF
 muQn5tiqucPmv+BkVncoB1ekNE55TCzJbN+apQM=
X-Google-Smtp-Source: AGHT+IGtyZGa5e9sp7Q4cSuhlS2qZesP0MRV+yk2Zzto/aNgJnG4FDsEfxCMJJi1SgXIpXqLM9QM9g==
X-Received: by 2002:a17:902:f545:b0:1cc:3bc5:d259 with SMTP id
 h5-20020a170902f54500b001cc3bc5d259mr215332plf.30.1699897464356; 
 Mon, 13 Nov 2023 09:44:24 -0800 (PST)
Received: from [192.168.68.107] ([152.250.131.148])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a1709027e8c00b001c898328289sm4401096pla.158.2023.11.13.09.44.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Nov 2023 09:44:23 -0800 (PST)
Message-ID: <5d226848-8af5-41ee-a353-6bc53902085d@ventanamicro.com>
Date: Mon, 13 Nov 2023 14:44:20 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Stable-8.1.3 00/55] Patch Round-up for stable 8.1.3, freeze on
 2023-11-19
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <qemu-stable-8.1.3-20231109164030@cover.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Michael,

On 11/9/23 10:42, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v8.1.3:
> 
>    https://gitlab.com/qemu-project/qemu/-/commits/staging-8.1
> 
> Patch freeze is 2023-11-19, and the release is planned for 2023-11-21:
> 
>    https://wiki.qemu.org/Planning/8.1
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional patches
> you think should (or shouldn't) be included in the release.

It would be good to have these 2:

082e9e4a58 ("target/riscv/kvm: improve 'init_multiext_cfg' error msg")
608bdebb60 ("target/riscv/kvm: support KVM_GET_REG_LIST")

The first is an error msg fix. The second fixes a problem with KVM guests when
running Linux 6.6 and QEMU 8.1.


This is not a clear cherry-pick though. I'll send both in separate for you
convenience. Thanks,


Daniel

> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.
> 
> Thanks!
> 
> /mjt
> 
> --------------------------------------
> 01 85fc35afa93c Yuval Shaia:
>     hw/pvrdma: Protect against buggy or malicious guest driver
> 02 caea03279e11 Fabiano Rosas:
>     migration: Fix analyze-migration read operation signedness
> 03 d4f34485ca8a Juan Quintela:
>     migration: Non multifd migration don't care about multifd flushes
> 04 acf873873ae3 John Snow:
>     python/qmp: remove Server.wait_closed() call for Python 3.12
> 05 a5e3cb3b90a6 Paolo Bonzini:
>     tests/docker: avoid invalid escape in Python string
> 06 e4b6532cc0a5 Paolo Bonzini:
>     docs/sphinx: avoid invalid escape in Python string
> 07 e41c40d101fc Paolo Bonzini:
>     target/hexagon: avoid invalid escape in Python string
> 08 1b5f3f65cc71 Paolo Bonzini:
>     tests/avocado: avoid invalid escape in Python string
> 09 86a8989d4557 Paolo Bonzini:
>     tests/vm: avoid invalid escape in Python string
> 10 e6d8e5e6e366 Paolo Bonzini:
>     tracetool: avoid invalid escape in Python string
> 11 e6e66b032873 Richard Henderson:
>     linux-user: Fixes for zero_bss
> 12 6fad9b4bb91d Mikulas Patocka:
>     linux-user/mips: fix abort on integer overflow
> 13 3b894b699c9a Mikulas Patocka:
>     linux-user/sh4: Fix crashes on signal delivery
> 14 a1e6a5c46219 Helge Deller:
>     lasips2: LASI PS/2 devices are not user-createable
> 15 d01448c79d89 Michal Orzel:
>     target/arm: Fix CNTPCT_EL0 trapping from EL0 when HCR_EL2.E2H is 0
> 16 ae5f70baf549 Lu Gao:
>     hw/sd/sdhci: Block Size Register bits [14:12] is lost
> 17 4ab9a7429bf7 Peter Maydell:
>     hw/rdma/vmw/pvrdma_cmd: Use correct struct in query_port()
> 18 930f1865cc65 Richard Henderson:
>     target/sparc: Clear may_lookup for npc == DYNAMIC_PC
> 19 307521d6e29e Peter Maydell:
>     target/arm: Fix syndrome for FGT traps on ERET
> 20 6f83dc67168d Glenn Miles:
>     misc/led: LED state is set opposite of what is expected
> 21 fed824501501 Kevin Wolf:
>     block: Fix locking in media change monitor commands
> 22 580731dcc87e Akihiko Odaki:
>     tests/tcg: Add -fno-stack-protector
> 23 8b097fd6b06e Andrey Drobyshev:
>     qemu-img: rebase: stop when reaching EOF of old backing file
> 24 827171c31805 Andrey Drobyshev:
>     qemu-iotests: 024: add rebasing test case for overlay_size > backing_size
> 25 b11293c212c2 Richard Henderson:
>     target/arm: Fix SVE STR increment
> 26 4c09abeae870 Peter Maydell:
>     target/arm: Correctly propagate stage 1 BTI guarded bit in a two-stage walk
> 27 721da0396cfa Cédric Le Goater:
>     util/uuid: Add UUID_STR_LEN definition
> 28 f8d6f3b16c37 Cédric Le Goater:
>     vfio/pci: Fix buffer overrun when writing the VF token
> 29 4ef9d97b1a37 Cédric Le Goater:
>     util/uuid: Remove UUID_FMT_LEN
> 30 e969f992c656 David Woodhouse:
>     i386/xen: Don't advertise XENFEAT_supervisor_mode_kernel
> 31 e7dbb62ff19c David Woodhouse:
>     i386/xen: fix per-vCPU upcall vector for Xen emulation
> 32 18e83f28bf39 David Woodhouse:
>     hw/xen: select kernel mode for per-vCPU event channel upcall vector
> 33 3de75ed35241 David Woodhouse:
>     hw/xen: don't clear map_track[] in xen_gnttab_reset()
> 34 4a5780f52095 David Woodhouse:
>     hw/xen: fix XenStore watch delivery to guest
> 35 debc995e883b David Woodhouse:
>     hw/xen: take iothread mutex in xen_evtchn_reset_op()
> 36 a1c1082908dd David Woodhouse:
>     hw/xen: use correct default protocol for xen-block on x86
> 37 9c549ab6895a Marc-André Lureau:
>     virtio-gpu: block migration of VMs with blob=true
> 38 cc8fb0c3ae3c Vladimir Sementsov-Ogievskiy:
>     block/nvme: nvme_process_completion() fix bound for cid
> 39 5722fc471296 Peter Maydell:
>     target/arm: Fix A64 LDRA immediate decode
> 40 b2b109041ecd Jean-Louis Dupond:
>     qcow2: keep reference on zeroize with discard-no-unref enabled
> 41 10b9e0802a07 Sam Li:
>     block/file-posix: fix update_zones_wp() caller
> 42 ad4feaca61d7 Naohiro Aota:
>     file-posix: fix over-writing of returning zone_append offset
> 43 08730ee0cc01 BALATON Zoltan:
>     ati-vga: Implement fallback for pixman routines
> 44 565f85a9c293 Marc-André Lureau:
>     ui/gtk: force realization of drawing area
> 45 47fd6ab1e334 Dongwon Kim:
>     ui/gtk-egl: apply scale factor when calculating window's dimension
> 46 6f189a08c1b0 Antonio Caggiano:
>     ui/gtk-egl: Check EGLSurface before doing scanout
> 47 04591b3ddd9a Philippe Mathieu-Daudé:
>     target/mips: Fix MSA BZ/BNZ opcodes displacement
> 48 18f86aecd6a1 Philippe Mathieu-Daudé:
>     target/mips: Fix TX79 LQ/SQ opcodes
> 49 7d7512019fc4 Fiona Ebner:
>     hw/ide: reset: cancel async DMA operation before resetting state
> 50 cc610857bbd3 Fiona Ebner:
>     tests/qtest: ahci-test: add test exposing reset issue with pending callback
> 51 aba2ec341c6d Ilya Leoshkevich:
>     target/s390x: Fix CLC corrupting cc_src
> 52 43fecbe7a53f Ilya Leoshkevich:
>     tests/tcg/s390x: Test CLC with inaccessible second operand
> 53 bea402482a8c Ilya Leoshkevich:
>     target/s390x: Fix LAALG not updating cc_src
> 54 ebc14107f1f3 Ilya Leoshkevich:
>     tests/tcg/s390x: Test LAALG with negative cc_src
> 55 b523a3d54f3d Niklas Cassel:
>     hw/ide/ahci: trigger either error IRQ or regular IRQ, not both
> 

