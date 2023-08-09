Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAFE775621
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 11:07:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTf9s-0004hi-M5; Wed, 09 Aug 2023 05:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qTf9q-0004ha-Ik
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:07:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qTf9o-0007np-L7
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 05:07:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691572027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/k0s8lbzPHbnGG/ljWXFMlAZUSIq0AZDFBRifWjR/ts=;
 b=IK4N8po21/V+Qhb0li8aS/3NnWHHHZIE2u4LytQBI0rWGqqrFfyVWZcdU8wXds8e3vk7Da
 vOkQjnF/YxpnGL8v6JDrG+uXjUJCfYdouwtoaTB2Rc5qRKZb3JVFFYTuZZbkIFOGOxplJG
 gCdNRXA3r7ckPEDd61pqC1NYsCZzJd0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-w-klq3hkMmSkq4Ek1GD8rg-1; Wed, 09 Aug 2023 05:07:05 -0400
X-MC-Unique: w-klq3hkMmSkq4Ek1GD8rg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF3F6185A794
 for <qemu-devel@nongnu.org>; Wed,  9 Aug 2023 09:07:04 +0000 (UTC)
Received: from [10.39.193.134] (unknown [10.39.193.134])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BA232026D4B;
 Wed,  9 Aug 2023 09:07:04 +0000 (UTC)
Message-ID: <2c6e0090-c3c5-7215-7810-662d19fadab4@redhat.com>
Date: Wed, 9 Aug 2023 11:07:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] vfio/pci: hide ROM BAR on SFC9220 10/40G Ethernet
 Controller PF
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
References: <20230808145916.81657-1-lersek@redhat.com>
 <20230808094041.41ebe3b6.alex.williamson@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20230808094041.41ebe3b6.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/8/23 17:40, Alex Williamson wrote:
> On Tue,  8 Aug 2023 16:59:16 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> The Solarflare Communications SFC9220 NIC's physical function (PF) appears
>> to expose an expansion ROM with the following characteristics:
>>
>> (1) Single-image ROM, with only a legacy BIOS image (no UEFI driver).
>> Alex's rom-parser utility dumps it like this:
>>
>>> Valid ROM signature found @0h, PCIR offset 20h
>>>         PCIR: type 0 (x86 PC-AT), vendor: 1924, device: 0a03, class: 000002
>>>         PCIR: revision 3, vendor revision: 1
>>>         Last image  
>>
>> (2) The BIOS image crashes when booted on i440fx.
>>
>> (3) The BIOS image prints the following messages on q35:
>>
>>> Solarflare Boot Manager (v5.2.2.1006)
>>> Solarflare Communications 2008-2019
>>> gPXE (http://etherboot.org) - [...] PCI[...] PnP PMM[...]  
>>
>> So it appears like a modified derivative of old gPXE.
>>
>> Alex surmised in advance that the BIOS image could be accessing
>> host-physical addresses rather than guest-phys ones, leading to the crash
>> on i440fx.
> 
> ROMs sometimes take shortcuts around the standard interfaces to the
> device and can therefore hit gaps in the virtualization, which is why
> that's suspect to me.  However if it works on q35 but not 440fx it
> might be more that we're not matching a PCI topology expectation of the
> ROM.  Was it only tested on 440fx attached to the root bus or does it
> also fail if the PF is attached downstream of a PCI-to-PCI bridge?

I don't know; I'll need to test both of these setups then.

> 
>> Don't expose the option ROM BAR to the VM by default. While this prevents
>> netbooting the VM off the PF on q35/SeaBIOS (a relatively rare scenario),
>> it does not make any difference for UEFI, and at least the VM doesn't
>> crash during boot on i440fx/SeaBIOS (a relatively frequent scenario).
>> Users can restore the original behavior via the QEMU cmdline and the
>> libvirt domain XML.
>>
>> (In two years, we've not seen any customer interest in this bug, hence
>> there's no incentive to investigate (2).)
>>
>> Cc: Alex Williamson <alex.williamson@redhat.com> (supporter:VFIO)
>> Cc: "Cédric Le Goater" <clg@redhat.com> (supporter:VFIO)
>> Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1975776
>> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
>> ---
>>  hw/vfio/pci-quirks.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
>> index f4ff83680572..270eb16b91fa 100644
>> --- a/hw/vfio/pci-quirks.c
>> +++ b/hw/vfio/pci-quirks.c
>> @@ -45,6 +45,10 @@ static const struct {
>>      uint32_t device;
>>  } rom_denylist[] = {
>>      { 0x14e4, 0x168e }, /* Broadcom BCM 57810 */
>> +    { 0x1924, 0x0a03 }, /* Solarflare Communications
>> +                         * SFC9220 10/40G Ethernet Controller
>> +                         * https://bugzilla.redhat.com/show_bug.cgi?id=1975776
> 
> Unfortunately this is not a public bz so there's not much point in
> referencing it in public code or commit log :-\  Thanks,

The BZ is not public because it was originally (mis-)filed for the RH
kernel, and those BZs are private by default. I'd corrected the BZ
component yesterday, but didn't realize I should relax the BZ's
visibility. I'll do that now. (That's the right thing to do regardless
of whether this patch gets in or not.)

Thanks!
Laszlo

> 
> Alex
> 
>> +                         */
>>  };
>>  
>>  bool vfio_opt_rom_in_denylist(VFIOPCIDevice *vdev)
> 


