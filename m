Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FAE793A2E
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 12:46:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdq2B-0006Wm-JQ; Wed, 06 Sep 2023 06:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qdq29-0006Wc-35
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:45:17 -0400
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <sylv@sylv.io>) id 1qdq26-00073h-4L
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 06:45:16 -0400
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgfCR5zgXz9t0P;
 Wed,  6 Sep 2023 12:45:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
 t=1693997107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F4hegyeijP+pfuLdS9HjY8T90FXX6BCWDEvBCKk5FaA=;
 b=obG3vTvoppcLBEJK+CX4mlpDetujiXS58udRblljKZfZcUiq9A6Nrb4gAENTdK4msFrWWd
 Qg7v9OMnA3SboIDh9ulGBrOlXJEHahe/gvSNZnXnEWR51Vdc+HOEGW3Xi4kKfw8hiwr8eq
 PNsdg+LtWfmgnE9zMEZIN8j0j1ygz+CQhqomqb1fECXIJHMIByyTJeHukDVZdAjjL+C+HV
 hSh48QMtk50L6BKUQsZs22iS1c28UJvIm+TB7ZiLmN3zlRvWdgwlK1boNdbmCL3Li8EU4D
 fEynVgbsiC0b13zf/47zaQWS5Tzrm60H/e4q7Y8r5YRQy2nLeccyOK8MTXf0Xw==
Message-ID: <04159151-7e8d-4e70-91c4-36e135a6ca94@sylv.io>
Date: Wed, 6 Sep 2023 12:45:05 +0200
MIME-Version: 1.0
Content-Language: en-US, de-DE
To: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, ani@anisinha.ca,
 Patrick Rudolph <patrick.rudolph@9elements.com>
References: <66949448-1577-444a-b6d2-d907f9870765@sylv.io>
 <20230905123447-mutt-send-email-mst@kernel.org>
 <bfd8c202-0ceb-47c2-8e9c-9547bd4bdd5f@sylv.io>
 <20230905163919-mutt-send-email-mst@kernel.org>
 <20230906101924.0bbf4998@imammedo.users.ipa.redhat.com>
From: Marcello Sylverster Bauer <sylv@sylv.io>
Subject: Re: PCI Hotplug ACPI device names only 3 characters long
In-Reply-To: <20230906101924.0bbf4998@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RgfCR5zgXz9t0P
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

Hi Igor, Hi Michael,

On 9/6/23 10:19, Igor Mammedov wrote:
> On Tue, 5 Sep 2023 16:43:54 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> On Tue, Sep 05, 2023 at 07:45:12PM +0200, Marcello Sylverster Bauer wrote:
>>> Hi Michael,
>>>
>>> On 9/5/23 18:44, Michael S. Tsirkin wrote:
>>>> On Tue, Sep 05, 2023 at 05:05:33PM +0200, Marcello Sylverster Bauer wrote:
>>>>> Greetings,
>>>>>
>>>>> I'm currently working on a project to support Intel IPU6 in QEMU via VFIO so
>>>>> that the guest system can access the camera. This requires extending the
>>>>> ACPI device definition so that the guest knows how to access the camera.
>>>>>
>>>>> However, I cannot extend the PCI devices because their names are not 4
>>>>> characters long and therefore do not follow the ACPI specification.
>>>>>
>>>>> When I use '-acpitable' to include my own SSDT for the IPU6 PCI device, it
>>>>> does not allow me to declare the device as an External Object because it
>>>>> automatically adds padding underscores.
>>>>>
>>>>> e.g.
>>>>> Before:
>>>>> ```
>>>>> External(_SB.PCI0.S18.SA0, DeviceObj)
>>>>> ```
>>>>> After:
>>>>> ```
>>>>> External(_SB.PCI0.S18_.SA0_, DeviceObj)
>>>>> ```
>>>>>
>>>>> Adding the underscore padding is hard coded in iASL and also in QEMU when
>>>>> parsing an ASL file. (see: build_append_nameseg())
>>>>>
>>>>> So here are my questions:
>>>>> 1. Is there a solution to extend the ACPI PCI device using '-acpitable'
>>>>> without having to patch iASL or QEMU?
>>>>> 2. Are there any plans to change the names to comply with the ACPI spec?
>>>>> (e.g. use "S%.03X" format string instead)
>>>>>
>>>>> Thanks
>>>>> Marcello
>>>>
>>>>
>>>> 1.  All names in ACPI are always exactly 4 characters long. _ is a legal character
>>>>       but names beginning with _ are reserved.
>>>
>>> Exactly, which is why I want to address this issue here. Currently, Qemu
>>> generates ACPI device names with only 3 characters. (See
>>> build_append_pci_bus_devices() in hw/i386/acpi-build.c).
>>> For example, the device I want to append entries to has the path
>>> "_SB.PCI0.S18.SA0", but I can't because of the two auto-generated devices
>>> with only 3 characters in their names.
> 
> if your ssdt really has shorter names. You can use iasl to de-compile it
> wiht bytte code included and check manually if if namesegment(s) are short
> or padded with '_'.
> (ex: iasl -d -l DSDT)
>
>>
>> They are 4 characters otherwise OSPMs wouldn't work.
>> In your example the path is _SB.PCI0.S18_.SA0_ - you disassembler probably
>> just helpfully hides it for readability.

Oh my mistake, looks like Michael is right and the padding underscores 
are just hidden in the decompiled ACPI tables and in the Linux kernel 
ACPI bus_id, so I jumped to the wrong conclusion:

```
                 Device (SA0)
                 {

     2824: 5B 82 4F 04 53 41 30 5F                          // [.O.SA0_
```

dmesg
```
[    0.837141] DEBUG: adev=0000000073b4ccad bid="SA0"
```

>>
>>>> There's no rule in ACPI
>>>>       spec that says they need to follow S%.03X or any other specific format.
>>>>       I'm pretty sure we do follow the ACPI specification in this but feel free to
>>>>       prove me wrong.
>>>
>>> You have misunderstood me. Currently, Qemu uses the following format to
>>> create PCI ACPI devices:
>>>
>>> ```
>>> aml_name("S%.02X", devfn)
>>> ```
>>>
>>> My question is whether we should change it to something that results in a 4
>>> character name like "S%.03X" or "S%.02X_".
>>
>> I think you misunderstand the code. Look at build_append_nameseg and you will
>> see that the name is always ACPI_NAMESEG_LEN characters which equals 4.
> 
> ACPI 6.5 spec says this:
> 
> 20.2.2 Name Objects Encoding
> ...
> NameSeg :=
> ...
> // Notice that NameSegs shorter than 4 characters are filled with trailing underscores (‘_’s).
> 
> that's what QEMU does if user has supplied shorter than 4 characters name
>

Yes, that's what I meant, but it looks like I didn't understand the QEMU 
ACPI code properly.

Thanks for the clarification and sorry for the noise.

Marcello

>>
>>> I have tested it and it works fine as long as any hardcoded path references
>>> are adjusted. But I'm not 100% sure if this could cause any regressions.
>>>    
>>>> 2.  You can probably add something to existing ACPI devices using Scope().
>>>
>>> I'm pretty sure the external object is required when loading a separate
>>> SSDT, but I'll try by just using scopes.
>>>    
>>>>       I would not advise relying on this - current names are not a stable
>>>>       interface that we guarantee across QEMU versions.
>>>>       If adding this functionality is desirable, I think we'll need some new interface
>>>>       to set a stable ACPI name. Maybe using aliases.
>>>
>>> Currently I'm just working on a PoW to get IPU6 working in QEMU, so
>>> instability is fine.
>>>
>>> Thanks,
>>> Marcello
>>>    
>>>>
>>>>    
>>
> 

