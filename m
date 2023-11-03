Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF27E0661
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:25:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywym-0005cD-2G; Fri, 03 Nov 2023 12:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qywyj-0005bh-KD
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qywyh-0001v8-Kp
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699028698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQ9w9kMwiZXpa5cDEvhkM4a1+FdHL2Zar8VWi0HxfX8=;
 b=GFjshsdSEQS+x08BMAzSnWwZ4RVVhnx6u4fcfqmUOgPs/BskvpLEp6CYKrJZCialkoULCH
 wmBYoy2MIkg8s8Lj+/T/+tfl/YZdped+kUX0h4BjeH2FvCF9Ggrh6qfzjOr1acb1JFHcl1
 Wbmz4e9pFhafb+kMJfzW8d/f7n+XGfc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-oRY51m6VMfC3n6IDbZPZ8g-1; Fri, 03 Nov 2023 12:24:54 -0400
X-MC-Unique: oRY51m6VMfC3n6IDbZPZ8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F09F101A550;
 Fri,  3 Nov 2023 16:24:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E543D2166B26;
 Fri,  3 Nov 2023 16:24:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D80AA21E6A1F; Fri,  3 Nov 2023 17:24:52 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Luc
 Michel <luc.michel@amd.com>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Bernhard Beschow <shentey@gmail.com>,  qemu-ppc@nongnu.org,  "Edgar E .
 Iglesias" <edgar.iglesias@gmail.com>,  "Daniel P . Berrange"
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 3/5] hw/ppc/e500: QOM-attach CPUs to the machine container
References: <20231030143957.82988-1-philmd@linaro.org>
 <20231030143957.82988-4-philmd@linaro.org>
 <874ji32sj9.fsf@pond.sub.org>
 <8ef2a102-3d3a-3979-6610-036c68262f6f@linaro.org>
Date: Fri, 03 Nov 2023 17:24:52 +0100
In-Reply-To: <8ef2a102-3d3a-3979-6610-036c68262f6f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 3 Nov 2023 12:09:48
 +0100")
Message-ID: <87r0l6ls8b.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 3/11/23 08:40, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Instead of having CPUs dangling in the /unattached/device
>>> bucket, attach them to the machine container.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>   hw/ppc/e500.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>>> index e04114fb3c..f8177c0280 100644
>>> --- a/hw/ppc/e500.c
>>> +++ b/hw/ppc/e500.c
>>> @@ -946,6 +946,7 @@ void ppce500_init(MachineState *machine)
>>>               exit(1);
>>>           }
>>>   +        object_property_add_child(OBJECT(machine), "cpu[*]", OBJECT(=
cs));
>>>           /*
>>>            * Secondary CPU starts in halted state for now. Needs to cha=
nge
>>>            * when implementing non-kernel boot.
>> A peek at "info qom-tree" confirms the CPU is in /machine/unattached/.
>> Along with most onboard devices.  Details below.
>>
>> Quick test...  I count 563 machines.  394 seem to have CPU(s) in or
>> below /machine/unattached/, 129 elsewhere, and 40 I can't easily
>> examine, because they don't start to monitor without additional CLI
>> arguments.
>>
>> Where should CPUs be?
>
> It is machine specific.
>
> - For System-on-Chip, it would be in /soc
>
> - For systems that fully model CPU topology, I'd expect a consistent
>   topology path. (If it is part of a cluster, in that /cluster).
>
> - For mainframes, it should be part of the CPU cards that can be
>   inserted?
>
> - For a single Pentium CPU, maybe /machine is sufficient.
>
>> Is /machine/unattached/ basically where we dump products of lazy
>> modelling?
>
> Unfortunately, yes. Also where CLI created devices are I guess.

No, these go into /machine/peripheral/ (with id=3D...) or
/machine/peripheral-anon/ (without).

/unattached has a different role: it's where objects without a parent go
when a parent is needed.  For instance, when a device without a QOM
parent gets realized, device_set_realized() makes it a child of
/unattached/.  Similar logic in hw/core/gpio.c, system/ioport.c and
system/memory.c.

>> If yes, should we try to empty it out?
>
> If it is useful. For components expected to be referenced externally
> by humans, probably. If only used by scripts, maybe not, except if
> human have to debug.
>
>> If we shouldn't, then why move this one out?
>
> When looking for a component in the tree, I start to look at /machine,
> having to fish for it elsewhere is not very natural. I'd change your
> question by:
> - Why do we need /unattached?

Because we can't be bothered to pick parents?

Perhaps an excusable shortcut when we had to convert a big pile of
devices to QOM.  But we take the shortcut for new objects, too.
Surprise, surprise.

> or
> - Why do we have 2 different folders, /machine and /unattached?
> If it is a headache, why not just simply merge them both?

I guess a justification for having both could be:

    /machine/: somebody spent a brain wave or two on the proper parent

    /unattached/: what's a parent, and why should I care?

Merging them would lose information.  Do we care?

>> $ qemu-system-ppc -nodefaults -S -display none -M ppce500 -monitor stdio
>> QEMU 8.1.50 monitor - type 'help' for more information
>> (qemu) info qom-tree
>> /machine (ppce500-machine)
>>    /e500-ccsr (e500-ccsr)
>>      /e500-ccsr[0] (memory-region)
>>      /e500-pci-bar0[0] (memory-region)
>>    /pci-host (e500-pcihost)
>>      /bm-e500[0] (memory-region)
>>      /pci bus memory[0] (memory-region)
>>      /pci-conf-data[0] (memory-region)
>>      /pci-conf-idx[0] (memory-region)
>>      /pci-container[0] (memory-region)
>>      /pci-pio[0] (memory-region)
>>      /pci.0 (PCI)
>>      /pci.reg[0] (memory-region)
>>    /peripheral (container)
>>    /peripheral-anon (container)
> [...]
>
>>    /unattached (container)
>>      /device[0] (e500v2_v30-powerpc-cpu)
>>        /unnamed-gpio-in[0] (irq)
>>        /unnamed-gpio-in[1] (irq)
>>        /unnamed-gpio-in[2] (irq)
>>        /unnamed-gpio-in[3] (irq)
>>        /unnamed-gpio-in[4] (irq)
>>        /unnamed-gpio-in[5] (irq)
>>        /unnamed-gpio-in[6] (irq)
>>      /device[1] (mpc-i2c)
>>        /i2c (i2c-bus)
>>        /mpc-i2c[0] (memory-region)
>>      /device[2] (ds1338)
>>      /device[3] (unimplemented-device)
>>        /esdhc[0] (memory-region)
>>      /device[4] (generic-sdhci)
>>        /sd-bus (sdhci-bus)
>>        /sdhci[0] (memory-region)
>>      /device[5] (mpc8544-guts)
>>        /mpc8544.guts[0] (memory-region)
>>      /device[6] (e500-host-bridge)
>>        /bus master container[0] (memory-region)
>>        /bus master[0] (memory-region)
>>      /device[7] (e500-spin)
>>        /e500 spin pv device[0] (memory-region)
>>      /device[8] (mpc8xxx_gpio)
>>        /mpc8xxx_gpio[0] (memory-region)
>>        /unnamed-gpio-in[0] (irq)
>>        /unnamed-gpio-in[10] (irq)
>>        /unnamed-gpio-in[11] (irq)
>>        /unnamed-gpio-in[12] (irq)
>>        /unnamed-gpio-in[13] (irq)
>>        /unnamed-gpio-in[14] (irq)
>>        /unnamed-gpio-in[15] (irq)
>>        /unnamed-gpio-in[16] (irq)
>>        /unnamed-gpio-in[17] (irq)
>>        /unnamed-gpio-in[18] (irq)
>>        /unnamed-gpio-in[19] (irq)
>>        /unnamed-gpio-in[1] (irq)
>>        /unnamed-gpio-in[20] (irq)
>>        /unnamed-gpio-in[21] (irq)
>>        /unnamed-gpio-in[22] (irq)
>>        /unnamed-gpio-in[23] (irq)
>>        /unnamed-gpio-in[24] (irq)
>>        /unnamed-gpio-in[25] (irq)
>>        /unnamed-gpio-in[26] (irq)
>>        /unnamed-gpio-in[27] (irq)
>>        /unnamed-gpio-in[28] (irq)
>>        /unnamed-gpio-in[29] (irq)
>>        /unnamed-gpio-in[2] (irq)
>>        /unnamed-gpio-in[30] (irq)
>>        /unnamed-gpio-in[31] (irq)
>>        /unnamed-gpio-in[3] (irq)
>>        /unnamed-gpio-in[4] (irq)
>>        /unnamed-gpio-in[5] (irq)
>>        /unnamed-gpio-in[6] (irq)
>>        /unnamed-gpio-in[7] (irq)
>>        /unnamed-gpio-in[8] (irq)
>>        /unnamed-gpio-in[9] (irq)
>>      /device[9] (platform-bus-device)
>>        /platform bus[0] (memory-region)
>
> Actually most of these do have a QOM parent.

They don't or else they wouldn't be here.  Do you mean "the proper
parent is obvious"?

> Correctly placing them in the tree should help when trying to
> resolve a component and avoiding an ambiguous match.

Yes.

>>      /io[0] (memory-region)
>>      /non-qdev-gpio[0] (irq)
>>      /sysbus (System)
>>      /system[0] (memory-region)


