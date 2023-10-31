Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C417DD0C8
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:44:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxquT-0008Ka-GD; Tue, 31 Oct 2023 11:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxquL-0008EX-3x
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:43:57 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxquG-0004MS-T9
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:43:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so41999755e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698767031; x=1699371831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDNVwpmYCjZRgc0pESl6QMSe1qzSycWDAt4YskYoR74=;
 b=H2ZBgAIgcRK0O51cDJAB8bgWS473pHv04bMy9IZoWtuqw7uAGfxoKaWNaK9rJq541O
 0Ms5izmPqhmreNE6fX174LEyZw5FZ5xc7MSNNriTo+54/EyFRgopYklo+R/mBcN8zY5n
 W3V9SytcjNgGVvUZt2DCQsZ6XPBmbGkp03LoDVkUpwMVYTZjpiWqkUNRx19cOVKwGI2q
 N+fDx7f+yfFbZGFe1LY8r2n6iejJm60AxPh3QCzp+fu6GIwuC5+P7cUCXE22ZWUVP/d+
 ee0XvBaHx0hyDK8ybdF33/XLyg46giFQTOsAq7Ea/tznagR3FA42YnBSUltiXPCXrNL8
 7/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698767031; x=1699371831;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDNVwpmYCjZRgc0pESl6QMSe1qzSycWDAt4YskYoR74=;
 b=kYt/Lzf6fgX3wSbOC2mx1BpQeVYRcV3YlOvj+s2TVMp8GTZfaEAx76JrKwXyOebElf
 2V+enQUDT7XouK6sE5WnzDli3nvF0bK85KXYEpZ5hS6/ohqfRBqw7dVufgVMpBxUBLiM
 iF7PjwrJ++q+KTHihktQdthP+TpYAkYS+UEC8qYQkg+LgX87Mw9znSwuXVgNnrfkw2/0
 zYa9F44CHc3/2R/wfRpF0CqsoIW4Tt2P+fZNuVZi3ThQPsa5zEsdJRdSuUDM6itUu9J1
 i3+A/4YrCbeH+V935xaBPCCTWNlsP6ynJz1ZEAy+3qxpDSWhPqcfRU5gZYyp0FqCwWd+
 iQCQ==
X-Gm-Message-State: AOJu0YwfdLsr/LXr463YEBRQW8adcjqGAsMb87luanqHhO5r6wXWf9Lh
 mgi9HUIwlue0iI1VG/nPjtfN2Q==
X-Google-Smtp-Source: AGHT+IHcUpeyyIuGqZruyTEDKU8EYTRPNEGQlwvVyBC0fHfqyTIF1H4JYNrzXvspnG7ZQDV0Ta+jYw==
X-Received: by 2002:a05:600c:1913:b0:409:351:873d with SMTP id
 j19-20020a05600c191300b004090351873dmr11707732wmq.31.1698767031069; 
 Tue, 31 Oct 2023 08:43:51 -0700 (PDT)
Received: from [192.168.69.115] (gjh33-h01-176-171-208-14.dsl.sta.abo.bbox.fr.
 [176.171.208.14]) by smtp.gmail.com with ESMTPSA id
 c5-20020a5d63c5000000b0032f99801273sm1047574wrw.66.2023.10.31.08.43.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 08:43:50 -0700 (PDT)
Message-ID: <878a78c4-a07c-04bb-7618-5fb5c2347420@linaro.org>
Date: Tue, 31 Oct 2023 16:43:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] docs/specs/vmgenid: Convert to rST
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-9-peter.maydell@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230927151205.70930-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.053,
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

On 27/9/23 17:12, Peter Maydell wrote:
> Convert docs/specs/vmgenid.txt to rST format.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS            |   2 +-
>   docs/specs/index.rst   |   1 +
>   docs/specs/vmgenid.rst | 246 +++++++++++++++++++++++++++++++++++++++++
>   docs/specs/vmgenid.txt | 245 ----------------------------------------
>   4 files changed, 248 insertions(+), 246 deletions(-)
>   create mode 100644 docs/specs/vmgenid.rst
>   delete mode 100644 docs/specs/vmgenid.txt

Cc'ing Ani.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23ee617acaf..d2338e3beb6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2369,7 +2369,7 @@ S: Orphan
>   R: Ani Sinha <ani@anisinha.ca>
>   F: hw/acpi/vmgenid.c
>   F: include/hw/acpi/vmgenid.h
> -F: docs/specs/vmgenid.txt
> +F: docs/specs/vmgenid.rst
>   F: tests/qtest/vmgenid-test.c
>   
>   LED
> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
> index 7a56ccb2155..b3f482b0aa5 100644
> --- a/docs/specs/index.rst
> +++ b/docs/specs/index.rst
> @@ -31,3 +31,4 @@ guest hardware that is specific to QEMU.
>      standard-vga
>      virt-ctlr
>      vmcoreinfo
> +   vmgenid
> diff --git a/docs/specs/vmgenid.rst b/docs/specs/vmgenid.rst
> new file mode 100644
> index 00000000000..9a3cefcd828
> --- /dev/null
> +++ b/docs/specs/vmgenid.rst
> @@ -0,0 +1,246 @@
> +Virtual Machine Generation ID Device
> +====================================
> +
> +..
> +   Copyright (C) 2016 Red Hat, Inc.
> +   Copyright (C) 2017 Skyport Systems, Inc.
> +
> +   This work is licensed under the terms of the GNU GPL, version 2 or later.
> +   See the COPYING file in the top-level directory.
> +
> +The VM generation ID (``vmgenid``) device is an emulated device which
> +exposes a 128-bit, cryptographically random, integer value identifier,
> +referred to as a Globally Unique Identifier, or GUID.
> +
> +This allows management applications (e.g. libvirt) to notify the guest
> +operating system when the virtual machine is executed with a different
> +configuration (e.g. snapshot execution or creation from a template).  The
> +guest operating system notices the change, and is then able to react as
> +appropriate by marking its copies of distributed databases as dirty,
> +re-initializing its random number generator etc.
> +
> +
> +Requirements
> +------------
> +
> +These requirements are extracted from the "How to implement virtual machine
> +generation ID support in a virtualization platform" section of
> +`the Microsoft Virtual Machine Generation ID specification
> +<http://go.microsoft.com/fwlink/?LinkId=260709>`_ dated August 1, 2012.
> +
> +- **R1a** The generation ID shall live in an 8-byte aligned buffer.
> +
> +- **R1b** The buffer holding the generation ID shall be in guest RAM,
> +  ROM, or device MMIO range.
> +
> +- **R1c** The buffer holding the generation ID shall be kept separate from
> +  areas used by the operating system.
> +
> +- **R1d** The buffer shall not be covered by an AddressRangeMemory or
> +  AddressRangeACPI entry in the E820 or UEFI memory map.
> +
> +- **R1e** The generation ID shall not live in a page frame that could be
> +  mapped with caching disabled. (In other words, regardless of whether the
> +  generation ID lives in RAM, ROM or MMIO, it shall only be mapped as
> +  cacheable.)
> +
> +- **R2** to **R5** [These AML requirements are isolated well enough in the
> +  Microsoft specification for us to simply refer to them here.]
> +
> +- **R6** The hypervisor shall expose a _HID (hardware identifier) object
> +  in the VMGenId device's scope that is unique to the hypervisor vendor.
> +
> +
> +QEMU Implementation
> +-------------------
> +
> +The above-mentioned specification does not dictate which ACPI descriptor table
> +will contain the VM Generation ID device.  Other implementations (Hyper-V and
> +Xen) put it in the main descriptor table (Differentiated System Description
> +Table or DSDT).  For ease of debugging and implementation, we have decided to
> +put it in its own Secondary System Description Table, or SSDT.
> +
> +The following is a dump of the contents from a running system::
> +
> +  # iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
> +
> +  Intel ACPI Component Architecture
> +  ASL+ Optimizing Compiler version 20150717-64
> +  Copyright (c) 2000 - 2015 Intel Corporation
> +
> +  Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Length
> +  00000198 (0x0000C6)
> +  ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 BXPC 00000001)
> +  Acpi table [SSDT] successfully installed and loaded
> +  Pass 1 parse of [SSDT]
> +  Pass 2 parse of [SSDT]
> +  Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> +
> +  Parsing completed
> +  Disassembly completed
> +  ASL Output:    ./SSDT.dsl - 1631 bytes
> +  # cat SSDT.dsl
> +  /*
> +   * Intel ACPI Component Architecture
> +   * AML/ASL+ Disassembler version 20150717-64
> +   * Copyright (c) 2000 - 2015 Intel Corporation
> +   *
> +   * Disassembling to symbolic ASL+ operators
> +   *
> +   * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 00:19:37 2017
> +   *
> +   * Original Table Header:
> +   *     Signature        "SSDT"
> +   *     Length           0x000000CA (202)
> +   *     Revision         0x01
> +   *     Checksum         0x4B
> +   *     OEM ID           "BOCHS "
> +   *     OEM Table ID     "VMGENID"
> +   *     OEM Revision     0x00000001 (1)
> +   *     Compiler ID      "BXPC"
> +   *     Compiler Version 0x00000001 (1)
> +   */
> +  DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001)
> +  {
> +      Name (VGIA, 0x07FFF000)
> +      Scope (\_SB)
> +      {
> +          Device (VGEN)
> +          {
> +              Name (_HID, "QEMUVGID")  // _HID: Hardware ID
> +              Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
> +              Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
> +              Method (_STA, 0, NotSerialized)  // _STA: Status
> +              {
> +                  Local0 = 0x0F
> +                  If ((VGIA == Zero))
> +                  {
> +                      Local0 = Zero
> +                  }
> +
> +                  Return (Local0)
> +              }
> +
> +              Method (ADDR, 0, NotSerialized)
> +              {
> +                  Local0 = Package (0x02) {}
> +                  Index (Local0, Zero) = (VGIA + 0x28)
> +                  Index (Local0, One) = Zero
> +                  Return (Local0)
> +              }
> +          }
> +      }
> +
> +      Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> +      {
> +          Notify (\_SB.VGEN, 0x80) // Status Change
> +      }
> +  }
> +
> +
> +Design Details:
> +---------------
> +
> +Requirements R1a through R1e dictate that the memory holding the
> +VM Generation ID must be allocated and owned by the guest firmware,
> +in this case BIOS or UEFI.  However, to be useful, QEMU must be able to
> +change the contents of the memory at runtime, specifically when starting a
> +backed-up or snapshotted image.  In order to do this, QEMU must know the
> +address that has been allocated.
> +
> +The mechanism chosen for this memory sharing is writable fw_cfg blobs.
> +These are data object that are visible to both QEMU and guests, and are
> +addressable as sequential files.
> +
> +More information about fw_cfg can be found in :doc:`fw_cfg`.
> +
> +Two fw_cfg blobs are used in this case:
> +
> +``/etc/vmgenid_guid``
> +
> +- contains the actual VM Generation ID GUID
> +- read-only to the guest
> +
> +``/etc/vmgenid_addr``
> +
> +- contains the address of the downloaded vmgenid blob
> +- writable by the guest
> +
> +
> +QEMU sends the following commands to the guest at startup:
> +
> +1. Allocate memory for vmgenid_guid fw_cfg blob.
> +2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI variable as
> +   shown above in the iasl dump).  Note that this change is not propagated
> +   back to QEMU.
> +3. Write the address of vmgenid_guid back to QEMU's copy of vmgenid_addr
> +   via the fw_cfg DMA interface.
> +
> +After step 3, QEMU is able to update the contents of vmgenid_guid at will.
> +
> +Since BIOS or UEFI does not necessarily run when we wish to change the GUID,
> +the value of VGIA is persisted via the VMState mechanism.
> +
> +As spelled out in the specification, any change to the GUID executes an
> +ACPI notification.  The exact handler to use is not specified, so the vmgenid
> +device uses the first unused one:  ``\_GPE._E05``.
> +
> +
> +Endian-ness Considerations:
> +---------------------------
> +
> +Although not specified in Microsoft's document, it is assumed that the
> +device is expected to use little-endian format.
> +
> +All GUID passed in via command line or monitor are treated as big-endian.
> +GUID values displayed via monitor are shown in big-endian format.
> +
> +
> +GUID Storage Format:
> +--------------------
> +
> +In order to implement an OVMF "SDT Header Probe Suppressor", the contents of
> +the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There is also
> +significant padding in order to align and fill a memory page, as shown in the
> +following diagram::
> +
> +  +----------------------------------+
> +  | SSDT with OEM Table ID = VMGENID |
> +  +----------------------------------+
> +  | ...                              |       TOP OF PAGE
> +  | VGIA dword object ---------------|-----> +---------------------------+
> +  | ...                              |       | fw-allocated array for    |
> +  | _STA method referring to VGIA    |       | "etc/vmgenid_guid"        |
> +  | ...                              |       +---------------------------+
> +  | ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
> +  | ...                              |       |     suppressor            |
> +  +----------------------------------+       | 36: padding for 8-byte    |
> +                                             |     alignment             |
> +                                             | 40: GUID                  |
> +                                             | 56: padding to page size  |
> +                                             +---------------------------+
> +                                             END OF PAGE
> +
> +
> +Device Usage:
> +-------------
> +
> +The device has one property, which may be only be set using the command line:
> +
> +``guid``
> +  sets the value of the GUID.  A special value ``auto`` instructs
> +  QEMU to generate a new random GUID.
> +
> +For example::
> +
> +  QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
> +  QEMU  -device vmgenid,guid=auto
> +
> +The property may be queried via QMP/HMP::
> +
> +  (QEMU) query-vm-generation-id
> +  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
> +
> +Setting of this parameter is intentionally left out from the QMP/HMP
> +interfaces.  There are no known use cases for changing the GUID once QEMU is
> +running, and adding this capability would greatly increase the complexity.
> diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
> deleted file mode 100644
> index 80ff69f31cc..00000000000
> --- a/docs/specs/vmgenid.txt
> +++ /dev/null
> @@ -1,245 +0,0 @@
> -VIRTUAL MACHINE GENERATION ID
> -=============================
> -
> -Copyright (C) 2016 Red Hat, Inc.
> -Copyright (C) 2017 Skyport Systems, Inc.
> -
> -This work is licensed under the terms of the GNU GPL, version 2 or later.
> -See the COPYING file in the top-level directory.
> -
> -===
> -
> -The VM generation ID (vmgenid) device is an emulated device which
> -exposes a 128-bit, cryptographically random, integer value identifier,
> -referred to as a Globally Unique Identifier, or GUID.
> -
> -This allows management applications (e.g. libvirt) to notify the guest
> -operating system when the virtual machine is executed with a different
> -configuration (e.g. snapshot execution or creation from a template).  The
> -guest operating system notices the change, and is then able to react as
> -appropriate by marking its copies of distributed databases as dirty,
> -re-initializing its random number generator etc.
> -
> -
> -Requirements
> -------------
> -
> -These requirements are extracted from the "How to implement virtual machine
> -generation ID support in a virtualization platform" section of the
> -specification, dated August 1, 2012.
> -
> -
> -The document may be found on the web at:
> -  http://go.microsoft.com/fwlink/?LinkId=260709
> -
> -R1a. The generation ID shall live in an 8-byte aligned buffer.
> -
> -R1b. The buffer holding the generation ID shall be in guest RAM, ROM, or device
> -     MMIO range.
> -
> -R1c. The buffer holding the generation ID shall be kept separate from areas
> -     used by the operating system.
> -
> -R1d. The buffer shall not be covered by an AddressRangeMemory or
> -     AddressRangeACPI entry in the E820 or UEFI memory map.
> -
> -R1e. The generation ID shall not live in a page frame that could be mapped with
> -     caching disabled. (In other words, regardless of whether the generation ID
> -     lives in RAM, ROM or MMIO, it shall only be mapped as cacheable.)
> -
> -R2 to R5. [These AML requirements are isolated well enough in the Microsoft
> -          specification for us to simply refer to them here.]
> -
> -R6. The hypervisor shall expose a _HID (hardware identifier) object in the
> -    VMGenId device's scope that is unique to the hypervisor vendor.
> -
> -
> -QEMU Implementation
> --------------------
> -
> -The above-mentioned specification does not dictate which ACPI descriptor table
> -will contain the VM Generation ID device.  Other implementations (Hyper-V and
> -Xen) put it in the main descriptor table (Differentiated System Description
> -Table or DSDT).  For ease of debugging and implementation, we have decided to
> -put it in its own Secondary System Description Table, or SSDT.
> -
> -The following is a dump of the contents from a running system:
> -
> -# iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
> -
> -Intel ACPI Component Architecture
> -ASL+ Optimizing Compiler version 20150717-64
> -Copyright (c) 2000 - 2015 Intel Corporation
> -
> -Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Length
> -00000198 (0x0000C6)
> -ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 BXPC
> -00000001)
> -Acpi table [SSDT] successfully installed and loaded
> -Pass 1 parse of [SSDT]
> -Pass 2 parse of [SSDT]
> -Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
> -
> -Parsing completed
> -Disassembly completed
> -ASL Output:    ./SSDT.dsl - 1631 bytes
> -# cat SSDT.dsl
> -/*
> - * Intel ACPI Component Architecture
> - * AML/ASL+ Disassembler version 20150717-64
> - * Copyright (c) 2000 - 2015 Intel Corporation
> - *
> - * Disassembling to symbolic ASL+ operators
> - *
> - * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 00:19:37 2017
> - *
> - * Original Table Header:
> - *     Signature        "SSDT"
> - *     Length           0x000000CA (202)
> - *     Revision         0x01
> - *     Checksum         0x4B
> - *     OEM ID           "BOCHS "
> - *     OEM Table ID     "VMGENID"
> - *     OEM Revision     0x00000001 (1)
> - *     Compiler ID      "BXPC"
> - *     Compiler Version 0x00000001 (1)
> - */
> -DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, "BOCHS ",
> -"VMGENID", 0x00000001)
> -{
> -    Name (VGIA, 0x07FFF000)
> -    Scope (\_SB)
> -    {
> -        Device (VGEN)
> -        {
> -            Name (_HID, "QEMUVGID")  // _HID: Hardware ID
> -            Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
> -            Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
> -            Method (_STA, 0, NotSerialized)  // _STA: Status
> -            {
> -                Local0 = 0x0F
> -                If ((VGIA == Zero))
> -                {
> -                    Local0 = Zero
> -                }
> -
> -                Return (Local0)
> -            }
> -
> -            Method (ADDR, 0, NotSerialized)
> -            {
> -                Local0 = Package (0x02) {}
> -                Index (Local0, Zero) = (VGIA + 0x28)
> -                Index (Local0, One) = Zero
> -                Return (Local0)
> -            }
> -        }
> -    }
> -
> -    Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered GPE
> -    {
> -        Notify (\_SB.VGEN, 0x80) // Status Change
> -    }
> -}
> -
> -
> -Design Details:
> ----------------
> -
> -Requirements R1a through R1e dictate that the memory holding the
> -VM Generation ID must be allocated and owned by the guest firmware,
> -in this case BIOS or UEFI.  However, to be useful, QEMU must be able to
> -change the contents of the memory at runtime, specifically when starting a
> -backed-up or snapshotted image.  In order to do this, QEMU must know the
> -address that has been allocated.
> -
> -The mechanism chosen for this memory sharing is writable fw_cfg blobs.
> -These are data object that are visible to both QEMU and guests, and are
> -addressable as sequential files.
> -
> -More information about fw_cfg can be found in "docs/specs/fw_cfg.txt"
> -
> -Two fw_cfg blobs are used in this case:
> -
> -/etc/vmgenid_guid - contains the actual VM Generation ID GUID
> -                  - read-only to the guest
> -/etc/vmgenid_addr - contains the address of the downloaded vmgenid blob
> -                  - writable by the guest
> -
> -
> -QEMU sends the following commands to the guest at startup:
> -
> -1. Allocate memory for vmgenid_guid fw_cfg blob.
> -2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI variable as
> -   shown above in the iasl dump).  Note that this change is not propagated
> -   back to QEMU.
> -3. Write the address of vmgenid_guid back to QEMU's copy of vmgenid_addr
> -   via the fw_cfg DMA interface.
> -
> -After step 3, QEMU is able to update the contents of vmgenid_guid at will.
> -
> -Since BIOS or UEFI does not necessarily run when we wish to change the GUID,
> -the value of VGIA is persisted via the VMState mechanism.
> -
> -As spelled out in the specification, any change to the GUID executes an
> -ACPI notification.  The exact handler to use is not specified, so the vmgenid
> -device uses the first unused one:  \_GPE._E05.
> -
> -
> -Endian-ness Considerations:
> ----------------------------
> -
> -Although not specified in Microsoft's document, it is assumed that the
> -device is expected to use little-endian format.
> -
> -All GUID passed in via command line or monitor are treated as big-endian.
> -GUID values displayed via monitor are shown in big-endian format.
> -
> -
> -GUID Storage Format:
> ---------------------
> -
> -In order to implement an OVMF "SDT Header Probe Suppressor", the contents of
> -the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There is also
> -significant padding in order to align and fill a memory page, as shown in the
> -following diagram:
> -
> -+----------------------------------+
> -| SSDT with OEM Table ID = VMGENID |
> -+----------------------------------+
> -| ...                              |       TOP OF PAGE
> -| VGIA dword object ---------------|-----> +---------------------------+
> -| ...                              |       | fw-allocated array for    |
> -| _STA method referring to VGIA    |       | "etc/vmgenid_guid"        |
> -| ...                              |       +---------------------------+
> -| ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
> -| ...                              |       |     suppressor            |
> -+----------------------------------+       | 36: padding for 8-byte    |
> -                                           |     alignment             |
> -                                           | 40: GUID                  |
> -                                           | 56: padding to page size  |
> -                                           +---------------------------+
> -                                           END OF PAGE
> -
> -
> -Device Usage:
> --------------
> -
> -The device has one property, which may be only be set using the command line:
> -
> -  guid - sets the value of the GUID.  A special value "auto" instructs
> -         QEMU to generate a new random GUID.
> -
> -For example:
> -
> -  QEMU  -device vmgenid,guid="324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
> -  QEMU  -device vmgenid,guid=auto
> -
> -The property may be queried via QMP/HMP:
> -
> -  (QEMU) query-vm-generation-id
> -  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
> -
> -Setting of this parameter is intentionally left out from the QMP/HMP
> -interfaces.  There are no known use cases for changing the GUID once QEMU is
> -running, and adding this capability would greatly increase the complexity.


