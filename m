Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A187DE086
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 12:50:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy9ii-0004nH-N3; Wed, 01 Nov 2023 07:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qy9if-0004mu-Bs
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qy9ic-0002Xp-Dg
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 07:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698839344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y33Eax6mlaY/wUILtbfLTsik+cFnK9tX94Cq3zG+Rus=;
 b=FIASElBOlGsbNKkekZCn1n5bqZRGSmD8XE8neZcEYvFi+p1d886Gx2FTgGcYpeZyyzG3qd
 cNtuN2qwBSZqOgEF4+FRXg5AvJo8oybjw2PXr3TbRcouzDjfRGHa2YQuzd/Y4uGVjH4Th/
 3RBM/2IW43WHSZsaaF3mNk38NatlPWo=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-XEXAZgJRN-icSrpVZbf4AQ-1; Wed, 01 Nov 2023 07:49:03 -0400
X-MC-Unique: XEXAZgJRN-icSrpVZbf4AQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-5b99683eefbso2650119a12.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 04:49:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698839341; x=1699444141;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y33Eax6mlaY/wUILtbfLTsik+cFnK9tX94Cq3zG+Rus=;
 b=Oq4xkLunnAiksMsjglpc97EubrWK1jZDzq/JfTHUghfwnCRHF+77c9HK13Upm5bpS8
 b7BK3H5kyoJ3fVKISQj79q69gFosGxbE9ccSzWdDpGF+I1tAFwOYkGkjndPjHgQD+ZvM
 myISaYAevEcVoZEaIsmvZ8k/DWNl8Jb1a6A+rbTreob7gQxboe5aqpGtb5HUy9yTqM5N
 Euh1cqwntN1PxsvuUToVZpyu7oPApWJdIBtZ3xrkfv9hEObrU197Rm/IrrDCbIBLMLpJ
 Lr6n3dXPEgWREWYSsCoKo5R8iWhE9MprSIa+J00R1pCjSvTCaMdPqwPgzTnlYVXdI/xF
 01Ew==
X-Gm-Message-State: AOJu0YwYyqzKoZ0DCcbPiL/PfbxaGY4sQx9b2cHNc8CumpCSSQvofN/c
 lTHp2tHwu0U5FHMrN3WUbOZDezjQVcvjtYND3YvlDvGA3r661EbouTkf7z6zkckuvsPq+8lNQDt
 9iUNb4TDyI9UUgRGSGnpDiuo=
X-Received: by 2002:a05:6a21:a598:b0:17b:7dda:c0fc with SMTP id
 gd24-20020a056a21a59800b0017b7ddac0fcmr15477792pzc.8.1698839341018; 
 Wed, 01 Nov 2023 04:49:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnw3MzuK54vhsUOIy0Yzisw8ZeMhdOD5ElmnJUgKkvEhM9upTNSQlYkj5gdEg8RsVHHk6BWw==
X-Received: by 2002:a05:6a21:a598:b0:17b:7dda:c0fc with SMTP id
 gd24-20020a056a21a59800b0017b7ddac0fcmr15477755pzc.8.1698839340367; 
 Wed, 01 Nov 2023 04:49:00 -0700 (PDT)
Received: from smtpclient.apple ([115.96.138.89])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a170902ee1200b001cc2bc10510sm1205504plb.128.2023.11.01.04.48.58
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 01 Nov 2023 04:48:59 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH 8/8] docs/specs/vmgenid: Convert to rST
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <878a78c4-a07c-04bb-7618-5fb5c2347420@linaro.org>
Date: Wed, 1 Nov 2023 17:18:56 +0530
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <934FE10E-3C91-4195-98EA-815236B38FB9@redhat.com>
References: <20230927151205.70930-1-peter.maydell@linaro.org>
 <20230927151205.70930-9-peter.maydell@linaro.org>
 <878a78c4-a07c-04bb-7618-5fb5c2347420@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 31-Oct-2023, at 9:13 PM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 27/9/23 17:12, Peter Maydell wrote:
>> Convert docs/specs/vmgenid.txt to rST format.
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  MAINTAINERS            |   2 +-
>>  docs/specs/index.rst   |   1 +
>>  docs/specs/vmgenid.rst | 246 =
+++++++++++++++++++++++++++++++++++++++++
>>  docs/specs/vmgenid.txt | 245 =
----------------------------------------
>>  4 files changed, 248 insertions(+), 246 deletions(-)
>>  create mode 100644 docs/specs/vmgenid.rst
>>  delete mode 100644 docs/specs/vmgenid.txt
>=20
> Cc'ing Ani.

Thanks Phil. I looked at the rendering here:
=
https://gitlab.com/anisinha/qemu/-/blob/review/docs/specs/vmgenid.rst?ref_=
type=3Dheads

And it looks good.

Based on this

Reviewed-by: Ani Sinha <anisinha@redhat.com>

>=20
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23ee617acaf..d2338e3beb6 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2369,7 +2369,7 @@ S: Orphan
>>  R: Ani Sinha <ani@anisinha.ca>
>>  F: hw/acpi/vmgenid.c
>>  F: include/hw/acpi/vmgenid.h
>> -F: docs/specs/vmgenid.txt
>> +F: docs/specs/vmgenid.rst
>>  F: tests/qtest/vmgenid-test.c
>>    LED
>> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
>> index 7a56ccb2155..b3f482b0aa5 100644
>> --- a/docs/specs/index.rst
>> +++ b/docs/specs/index.rst
>> @@ -31,3 +31,4 @@ guest hardware that is specific to QEMU.
>>     standard-vga
>>     virt-ctlr
>>     vmcoreinfo
>> +   vmgenid
>> diff --git a/docs/specs/vmgenid.rst b/docs/specs/vmgenid.rst
>> new file mode 100644
>> index 00000000000..9a3cefcd828
>> --- /dev/null
>> +++ b/docs/specs/vmgenid.rst
>> @@ -0,0 +1,246 @@
>> +Virtual Machine Generation ID Device
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +..
>> +   Copyright (C) 2016 Red Hat, Inc.
>> +   Copyright (C) 2017 Skyport Systems, Inc.
>> +
>> +   This work is licensed under the terms of the GNU GPL, version 2 =
or later.
>> +   See the COPYING file in the top-level directory.
>> +
>> +The VM generation ID (``vmgenid``) device is an emulated device =
which
>> +exposes a 128-bit, cryptographically random, integer value =
identifier,
>> +referred to as a Globally Unique Identifier, or GUID.
>> +
>> +This allows management applications (e.g. libvirt) to notify the =
guest
>> +operating system when the virtual machine is executed with a =
different
>> +configuration (e.g. snapshot execution or creation from a template). =
 The
>> +guest operating system notices the change, and is then able to react =
as
>> +appropriate by marking its copies of distributed databases as dirty,
>> +re-initializing its random number generator etc.
>> +
>> +
>> +Requirements
>> +------------
>> +
>> +These requirements are extracted from the "How to implement virtual =
machine
>> +generation ID support in a virtualization platform" section of
>> +`the Microsoft Virtual Machine Generation ID specification
>> +<http://go.microsoft.com/fwlink/?LinkId=3D260709>`_ dated August 1, =
2012.
>> +
>> +- **R1a** The generation ID shall live in an 8-byte aligned buffer.
>> +
>> +- **R1b** The buffer holding the generation ID shall be in guest =
RAM,
>> +  ROM, or device MMIO range.
>> +
>> +- **R1c** The buffer holding the generation ID shall be kept =
separate from
>> +  areas used by the operating system.
>> +
>> +- **R1d** The buffer shall not be covered by an AddressRangeMemory =
or
>> +  AddressRangeACPI entry in the E820 or UEFI memory map.
>> +
>> +- **R1e** The generation ID shall not live in a page frame that =
could be
>> +  mapped with caching disabled. (In other words, regardless of =
whether the
>> +  generation ID lives in RAM, ROM or MMIO, it shall only be mapped =
as
>> +  cacheable.)
>> +
>> +- **R2** to **R5** [These AML requirements are isolated well enough =
in the
>> +  Microsoft specification for us to simply refer to them here.]
>> +
>> +- **R6** The hypervisor shall expose a _HID (hardware identifier) =
object
>> +  in the VMGenId device's scope that is unique to the hypervisor =
vendor.
>> +
>> +
>> +QEMU Implementation
>> +-------------------
>> +
>> +The above-mentioned specification does not dictate which ACPI =
descriptor table
>> +will contain the VM Generation ID device.  Other implementations =
(Hyper-V and
>> +Xen) put it in the main descriptor table (Differentiated System =
Description
>> +Table or DSDT).  For ease of debugging and implementation, we have =
decided to
>> +put it in its own Secondary System Description Table, or SSDT.
>> +
>> +The following is a dump of the contents from a running system::
>> +
>> +  # iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
>> +
>> +  Intel ACPI Component Architecture
>> +  ASL+ Optimizing Compiler version 20150717-64
>> +  Copyright (c) 2000 - 2015 Intel Corporation
>> +
>> +  Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - =
Length
>> +  00000198 (0x0000C6)
>> +  ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 =
BXPC 00000001)
>> +  Acpi table [SSDT] successfully installed and loaded
>> +  Pass 1 parse of [SSDT]
>> +  Pass 2 parse of [SSDT]
>> +  Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>> +
>> +  Parsing completed
>> +  Disassembly completed
>> +  ASL Output:    ./SSDT.dsl - 1631 bytes
>> +  # cat SSDT.dsl
>> +  /*
>> +   * Intel ACPI Component Architecture
>> +   * AML/ASL+ Disassembler version 20150717-64
>> +   * Copyright (c) 2000 - 2015 Intel Corporation
>> +   *
>> +   * Disassembling to symbolic ASL+ operators
>> +   *
>> +   * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 =
00:19:37 2017
>> +   *
>> +   * Original Table Header:
>> +   *     Signature        "SSDT"
>> +   *     Length           0x000000CA (202)
>> +   *     Revision         0x01
>> +   *     Checksum         0x4B
>> +   *     OEM ID           "BOCHS "
>> +   *     OEM Table ID     "VMGENID"
>> +   *     OEM Revision     0x00000001 (1)
>> +   *     Compiler ID      "BXPC"
>> +   *     Compiler Version 0x00000001 (1)
>> +   */
>> +  DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, =
"BOCHS ", "VMGENID", 0x00000001)
>> +  {
>> +      Name (VGIA, 0x07FFF000)
>> +      Scope (\_SB)
>> +      {
>> +          Device (VGEN)
>> +          {
>> +              Name (_HID, "QEMUVGID")  // _HID: Hardware ID
>> +              Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
>> +              Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device =
Name
>> +              Method (_STA, 0, NotSerialized)  // _STA: Status
>> +              {
>> +                  Local0 =3D 0x0F
>> +                  If ((VGIA =3D=3D Zero))
>> +                  {
>> +                      Local0 =3D Zero
>> +                  }
>> +
>> +                  Return (Local0)
>> +              }
>> +
>> +              Method (ADDR, 0, NotSerialized)
>> +              {
>> +                  Local0 =3D Package (0x02) {}
>> +                  Index (Local0, Zero) =3D (VGIA + 0x28)
>> +                  Index (Local0, One) =3D Zero
>> +                  Return (Local0)
>> +              }
>> +          }
>> +      }
>> +
>> +      Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered =
GPE
>> +      {
>> +          Notify (\_SB.VGEN, 0x80) // Status Change
>> +      }
>> +  }
>> +
>> +
>> +Design Details:
>> +---------------
>> +
>> +Requirements R1a through R1e dictate that the memory holding the
>> +VM Generation ID must be allocated and owned by the guest firmware,
>> +in this case BIOS or UEFI.  However, to be useful, QEMU must be able =
to
>> +change the contents of the memory at runtime, specifically when =
starting a
>> +backed-up or snapshotted image.  In order to do this, QEMU must know =
the
>> +address that has been allocated.
>> +
>> +The mechanism chosen for this memory sharing is writable fw_cfg =
blobs.
>> +These are data object that are visible to both QEMU and guests, and =
are
>> +addressable as sequential files.
>> +
>> +More information about fw_cfg can be found in :doc:`fw_cfg`.
>> +
>> +Two fw_cfg blobs are used in this case:
>> +
>> +``/etc/vmgenid_guid``
>> +
>> +- contains the actual VM Generation ID GUID
>> +- read-only to the guest
>> +
>> +``/etc/vmgenid_addr``
>> +
>> +- contains the address of the downloaded vmgenid blob
>> +- writable by the guest
>> +
>> +
>> +QEMU sends the following commands to the guest at startup:
>> +
>> +1. Allocate memory for vmgenid_guid fw_cfg blob.
>> +2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI =
variable as
>> +   shown above in the iasl dump).  Note that this change is not =
propagated
>> +   back to QEMU.
>> +3. Write the address of vmgenid_guid back to QEMU's copy of =
vmgenid_addr
>> +   via the fw_cfg DMA interface.
>> +
>> +After step 3, QEMU is able to update the contents of vmgenid_guid at =
will.
>> +
>> +Since BIOS or UEFI does not necessarily run when we wish to change =
the GUID,
>> +the value of VGIA is persisted via the VMState mechanism.
>> +
>> +As spelled out in the specification, any change to the GUID executes =
an
>> +ACPI notification.  The exact handler to use is not specified, so =
the vmgenid
>> +device uses the first unused one:  ``\_GPE._E05``.
>> +
>> +
>> +Endian-ness Considerations:
>> +---------------------------
>> +
>> +Although not specified in Microsoft's document, it is assumed that =
the
>> +device is expected to use little-endian format.
>> +
>> +All GUID passed in via command line or monitor are treated as =
big-endian.
>> +GUID values displayed via monitor are shown in big-endian format.
>> +
>> +
>> +GUID Storage Format:
>> +--------------------
>> +
>> +In order to implement an OVMF "SDT Header Probe Suppressor", the =
contents of
>> +the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There =
is also
>> +significant padding in order to align and fill a memory page, as =
shown in the
>> +following diagram::
>> +
>> +  +----------------------------------+
>> +  | SSDT with OEM Table ID =3D VMGENID |
>> +  +----------------------------------+
>> +  | ...                              |       TOP OF PAGE
>> +  | VGIA dword object ---------------|-----> =
+---------------------------+
>> +  | ...                              |       | fw-allocated array =
for    |
>> +  | _STA method referring to VGIA    |       | "etc/vmgenid_guid"    =
    |
>> +  | ...                              |       =
+---------------------------+
>> +  | ADDR method referring to VGIA    |       |  0: OVMF SDT Header =
probe |
>> +  | ...                              |       |     suppressor        =
    |
>> +  +----------------------------------+       | 36: padding for =
8-byte    |
>> +                                             |     alignment         =
    |
>> +                                             | 40: GUID              =
    |
>> +                                             | 56: padding to page =
size  |
>> +                                             =
+---------------------------+
>> +                                             END OF PAGE
>> +
>> +
>> +Device Usage:
>> +-------------
>> +
>> +The device has one property, which may be only be set using the =
command line:
>> +
>> +``guid``
>> +  sets the value of the GUID.  A special value ``auto`` instructs
>> +  QEMU to generate a new random GUID.
>> +
>> +For example::
>> +
>> +  QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>> +  QEMU  -device vmgenid,guid=3Dauto
>> +
>> +The property may be queried via QMP/HMP::
>> +
>> +  (QEMU) query-vm-generation-id
>> +  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>> +
>> +Setting of this parameter is intentionally left out from the QMP/HMP
>> +interfaces.  There are no known use cases for changing the GUID once =
QEMU is
>> +running, and adding this capability would greatly increase the =
complexity.
>> diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
>> deleted file mode 100644
>> index 80ff69f31cc..00000000000
>> --- a/docs/specs/vmgenid.txt
>> +++ /dev/null
>> @@ -1,245 +0,0 @@
>> -VIRTUAL MACHINE GENERATION ID
>> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> -
>> -Copyright (C) 2016 Red Hat, Inc.
>> -Copyright (C) 2017 Skyport Systems, Inc.
>> -
>> -This work is licensed under the terms of the GNU GPL, version 2 or =
later.
>> -See the COPYING file in the top-level directory.
>> -
>> -=3D=3D=3D
>> -
>> -The VM generation ID (vmgenid) device is an emulated device which
>> -exposes a 128-bit, cryptographically random, integer value =
identifier,
>> -referred to as a Globally Unique Identifier, or GUID.
>> -
>> -This allows management applications (e.g. libvirt) to notify the =
guest
>> -operating system when the virtual machine is executed with a =
different
>> -configuration (e.g. snapshot execution or creation from a template). =
 The
>> -guest operating system notices the change, and is then able to react =
as
>> -appropriate by marking its copies of distributed databases as dirty,
>> -re-initializing its random number generator etc.
>> -
>> -
>> -Requirements
>> -------------
>> -
>> -These requirements are extracted from the "How to implement virtual =
machine
>> -generation ID support in a virtualization platform" section of the
>> -specification, dated August 1, 2012.
>> -
>> -
>> -The document may be found on the web at:
>> -  http://go.microsoft.com/fwlink/?LinkId=3D260709
>> -
>> -R1a. The generation ID shall live in an 8-byte aligned buffer.
>> -
>> -R1b. The buffer holding the generation ID shall be in guest RAM, =
ROM, or device
>> -     MMIO range.
>> -
>> -R1c. The buffer holding the generation ID shall be kept separate =
from areas
>> -     used by the operating system.
>> -
>> -R1d. The buffer shall not be covered by an AddressRangeMemory or
>> -     AddressRangeACPI entry in the E820 or UEFI memory map.
>> -
>> -R1e. The generation ID shall not live in a page frame that could be =
mapped with
>> -     caching disabled. (In other words, regardless of whether the =
generation ID
>> -     lives in RAM, ROM or MMIO, it shall only be mapped as =
cacheable.)
>> -
>> -R2 to R5. [These AML requirements are isolated well enough in the =
Microsoft
>> -          specification for us to simply refer to them here.]
>> -
>> -R6. The hypervisor shall expose a _HID (hardware identifier) object =
in the
>> -    VMGenId device's scope that is unique to the hypervisor vendor.
>> -
>> -
>> -QEMU Implementation
>> --------------------
>> -
>> -The above-mentioned specification does not dictate which ACPI =
descriptor table
>> -will contain the VM Generation ID device.  Other implementations =
(Hyper-V and
>> -Xen) put it in the main descriptor table (Differentiated System =
Description
>> -Table or DSDT).  For ease of debugging and implementation, we have =
decided to
>> -put it in its own Secondary System Description Table, or SSDT.
>> -
>> -The following is a dump of the contents from a running system:
>> -
>> -# iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
>> -
>> -Intel ACPI Component Architecture
>> -ASL+ Optimizing Compiler version 20150717-64
>> -Copyright (c) 2000 - 2015 Intel Corporation
>> -
>> -Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Length
>> -00000198 (0x0000C6)
>> -ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 =
BXPC
>> -00000001)
>> -Acpi table [SSDT] successfully installed and loaded
>> -Pass 1 parse of [SSDT]
>> -Pass 2 parse of [SSDT]
>> -Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
>> -
>> -Parsing completed
>> -Disassembly completed
>> -ASL Output:    ./SSDT.dsl - 1631 bytes
>> -# cat SSDT.dsl
>> -/*
>> - * Intel ACPI Component Architecture
>> - * AML/ASL+ Disassembler version 20150717-64
>> - * Copyright (c) 2000 - 2015 Intel Corporation
>> - *
>> - * Disassembling to symbolic ASL+ operators
>> - *
>> - * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 =
00:19:37 2017
>> - *
>> - * Original Table Header:
>> - *     Signature        "SSDT"
>> - *     Length           0x000000CA (202)
>> - *     Revision         0x01
>> - *     Checksum         0x4B
>> - *     OEM ID           "BOCHS "
>> - *     OEM Table ID     "VMGENID"
>> - *     OEM Revision     0x00000001 (1)
>> - *     Compiler ID      "BXPC"
>> - *     Compiler Version 0x00000001 (1)
>> - */
>> -DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, =
"BOCHS ",
>> -"VMGENID", 0x00000001)
>> -{
>> -    Name (VGIA, 0x07FFF000)
>> -    Scope (\_SB)
>> -    {
>> -        Device (VGEN)
>> -        {
>> -            Name (_HID, "QEMUVGID")  // _HID: Hardware ID
>> -            Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
>> -            Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
>> -            Method (_STA, 0, NotSerialized)  // _STA: Status
>> -            {
>> -                Local0 =3D 0x0F
>> -                If ((VGIA =3D=3D Zero))
>> -                {
>> -                    Local0 =3D Zero
>> -                }
>> -
>> -                Return (Local0)
>> -            }
>> -
>> -            Method (ADDR, 0, NotSerialized)
>> -            {
>> -                Local0 =3D Package (0x02) {}
>> -                Index (Local0, Zero) =3D (VGIA + 0x28)
>> -                Index (Local0, One) =3D Zero
>> -                Return (Local0)
>> -            }
>> -        }
>> -    }
>> -
>> -    Method (\_GPE._E05, 0, NotSerialized)  // _Exx: Edge-Triggered =
GPE
>> -    {
>> -        Notify (\_SB.VGEN, 0x80) // Status Change
>> -    }
>> -}
>> -
>> -
>> -Design Details:
>> ----------------
>> -
>> -Requirements R1a through R1e dictate that the memory holding the
>> -VM Generation ID must be allocated and owned by the guest firmware,
>> -in this case BIOS or UEFI.  However, to be useful, QEMU must be able =
to
>> -change the contents of the memory at runtime, specifically when =
starting a
>> -backed-up or snapshotted image.  In order to do this, QEMU must know =
the
>> -address that has been allocated.
>> -
>> -The mechanism chosen for this memory sharing is writable fw_cfg =
blobs.
>> -These are data object that are visible to both QEMU and guests, and =
are
>> -addressable as sequential files.
>> -
>> -More information about fw_cfg can be found in =
"docs/specs/fw_cfg.txt"
>> -
>> -Two fw_cfg blobs are used in this case:
>> -
>> -/etc/vmgenid_guid - contains the actual VM Generation ID GUID
>> -                  - read-only to the guest
>> -/etc/vmgenid_addr - contains the address of the downloaded vmgenid =
blob
>> -                  - writable by the guest
>> -
>> -
>> -QEMU sends the following commands to the guest at startup:
>> -
>> -1. Allocate memory for vmgenid_guid fw_cfg blob.
>> -2. Write the address of vmgenid_guid into the SSDT (VGIA ACPI =
variable as
>> -   shown above in the iasl dump).  Note that this change is not =
propagated
>> -   back to QEMU.
>> -3. Write the address of vmgenid_guid back to QEMU's copy of =
vmgenid_addr
>> -   via the fw_cfg DMA interface.
>> -
>> -After step 3, QEMU is able to update the contents of vmgenid_guid at =
will.
>> -
>> -Since BIOS or UEFI does not necessarily run when we wish to change =
the GUID,
>> -the value of VGIA is persisted via the VMState mechanism.
>> -
>> -As spelled out in the specification, any change to the GUID executes =
an
>> -ACPI notification.  The exact handler to use is not specified, so =
the vmgenid
>> -device uses the first unused one:  \_GPE._E05.
>> -
>> -
>> -Endian-ness Considerations:
>> ----------------------------
>> -
>> -Although not specified in Microsoft's document, it is assumed that =
the
>> -device is expected to use little-endian format.
>> -
>> -All GUID passed in via command line or monitor are treated as =
big-endian.
>> -GUID values displayed via monitor are shown in big-endian format.
>> -
>> -
>> -GUID Storage Format:
>> ---------------------
>> -
>> -In order to implement an OVMF "SDT Header Probe Suppressor", the =
contents of
>> -the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There =
is also
>> -significant padding in order to align and fill a memory page, as =
shown in the
>> -following diagram:
>> -
>> -+----------------------------------+
>> -| SSDT with OEM Table ID =3D VMGENID |
>> -+----------------------------------+
>> -| ...                              |       TOP OF PAGE
>> -| VGIA dword object ---------------|-----> =
+---------------------------+
>> -| ...                              |       | fw-allocated array for  =
  |
>> -| _STA method referring to VGIA    |       | "etc/vmgenid_guid"      =
  |
>> -| ...                              |       =
+---------------------------+
>> -| ADDR method referring to VGIA    |       |  0: OVMF SDT Header =
probe |
>> -| ...                              |       |     suppressor          =
  |
>> -+----------------------------------+       | 36: padding for 8-byte  =
  |
>> -                                           |     alignment           =
  |
>> -                                           | 40: GUID                =
  |
>> -                                           | 56: padding to page =
size  |
>> -                                           =
+---------------------------+
>> -                                           END OF PAGE
>> -
>> -
>> -Device Usage:
>> --------------
>> -
>> -The device has one property, which may be only be set using the =
command line:
>> -
>> -  guid - sets the value of the GUID.  A special value "auto" =
instructs
>> -         QEMU to generate a new random GUID.
>> -
>> -For example:
>> -
>> -  QEMU  -device vmgenid,guid=3D"324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"
>> -  QEMU  -device vmgenid,guid=3Dauto
>> -
>> -The property may be queried via QMP/HMP:
>> -
>> -  (QEMU) query-vm-generation-id
>> -  {"return": {"guid": "324e6eaf-d1d1-4bf6-bf41-b9bb6c91fb87"}}
>> -
>> -Setting of this parameter is intentionally left out from the QMP/HMP
>> -interfaces.  There are no known use cases for changing the GUID once =
QEMU is
>> -running, and adding this capability would greatly increase the =
complexity.
>=20


