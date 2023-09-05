Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF4D792CB5
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:47:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qda7H-00036j-T3; Tue, 05 Sep 2023 13:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qda7G-00036X-2N
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:45:30 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qda7B-0005k0-BE
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:45:29 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgCZh1BCsz9t4h;
 Tue,  5 Sep 2023 19:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
 t=1693935916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PC0Z0ZM4FZL9hk6Q8shpjCEYbOy8Zid7j13xamUcIq8=;
 b=aaEgaOCcUBCEfNTzQNwqqKB4fMO4MAs+NvQSbnlRGsPU7AH77OeNm2u0BhlByFj1jrNS7P
 C0M4OVPtrurMDLdsR4PJ/+7G97IWfTUzi7k8gjtQmSo9fs2NFrwp1Fqf31ioqPe/C0naum
 zTEc4Cy0+bAerrsvS0qIk8ikNpTrUBh/oapDv1TpwefV5yiOKrz5/S4JIQ31UFYktPCVsH
 tY03UiXwDqpk/jx+cl6EVr5rzxqB7qBa0lpz3tSIXSTUlPOX/Vu11sDL3TgTTt6Fl0xbmv
 2ZbfGTdG6a53nxxruZS/sLwCjFnbiVMo4HZ0AXUuI0XeTHuca4JZLkh7Cz4HKQ==
Message-ID: <bfd8c202-0ceb-47c2-8e9c-9547bd4bdd5f@sylv.io>
Date: Tue, 5 Sep 2023 19:45:12 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
 <20230905123447-mutt-send-email-mst@kernel.org>
From: Marcello Sylverster Bauer <sylv@sylv.io>
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
In-Reply-To: <20230905123447-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4RgCZh1BCsz9t4h
Received-SPF: pass client-ip=80.241.56.172; envelope-from=sylv@sylv.io;
 helo=mout-p-202.mailbox.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi Michael,

On 9/5/23 18:44, Michael S. Tsirkin wrote:
> On Tue, Sep 05, 2023 at 05:05:33PM +0200, Marcello Sylverster Bauer wrote:
>> Greetings,
>>
>> I'm currently working on a project to support Intel IPU6 in QEMU via VFIO so
>> that the guest system can access the camera. This requires extending the
>> ACPI device definition so that the guest knows how to access the camera.
>>
>> However, I cannot extend the PCI devices because their names are not 4
>> characters long and therefore do not follow the ACPI specification.
>>
>> When I use '-acpitable' to include my own SSDT for the IPU6 PCI device, it
>> does not allow me to declare the device as an External Object because it
>> automatically adds padding underscores.
>>
>> e.g.
>> Before:
>> ```
>> External(_SB.PCI0.S18.SA0, DeviceObj)
>> ```
>> After:
>> ```
>> External(_SB.PCI0.S18_.SA0_, DeviceObj)
>> ```
>>
>> Adding the underscore padding is hard coded in iASL and also in QEMU when
>> parsing an ASL file. (see: build_append_nameseg())
>>
>> So here are my questions:
>> 1. Is there a solution to extend the ACPI PCI device using '-acpitable'
>> without having to patch iASL or QEMU?
>> 2. Are there any plans to change the names to comply with the ACPI spec?
>> (e.g. use "S%.03X" format string instead)
>>
>> Thanks
>> Marcello
> 
> 
> 1.  All names in ACPI are always exactly 4 characters long. _ is a legal character
>      but names beginning with _ are reserved.

Exactly, which is why I want to address this issue here. Currently, Qemu 
generates ACPI device names with only 3 characters. (See 
build_append_pci_bus_devices() in hw/i386/acpi-build.c).
For example, the device I want to append entries to has the path 
"_SB.PCI0.S18.SA0", but I can't because of the two auto-generated 
devices with only 3 characters in their names.

> There's no rule in ACPI
>      spec that says they need to follow S%.03X or any other specific format.
>      I'm pretty sure we do follow the ACPI specification in this but feel free to
>      prove me wrong.

You have misunderstood me. Currently, Qemu uses the following format to 
create PCI ACPI devices:

```
aml_name("S%.02X", devfn)
```

My question is whether we should change it to something that results in 
a 4 character name like "S%.03X" or "S%.02X_".

I have tested it and it works fine as long as any hardcoded path 
references are adjusted. But I'm not 100% sure if this could cause any 
regressions.

> 2.  You can probably add something to existing ACPI devices using Scope().

I'm pretty sure the external object is required when loading a separate 
SSDT, but I'll try by just using scopes.

>      I would not advise relying on this - current names are not a stable
>      interface that we guarantee across QEMU versions.
>      If adding this functionality is desirable, I think we'll need some new interface
>      to set a stable ACPI name. Maybe using aliases.

Currently I'm just working on a PoW to get IPU6 working in QEMU, so 
instability is fine.

Thanks,
Marcello

> 
> 

