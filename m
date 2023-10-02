Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1FB7B5B81
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 21:43:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnOny-0001Hx-7F; Mon, 02 Oct 2023 15:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnOnv-0001FW-Qf
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 15:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1qnOnu-0001Bt-38
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 15:42:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696275725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPyieEGN4++mSFH7NGwOBR1UBmfmz+dKiq7cWAzr8Rg=;
 b=heJ2Dm9Sw//WdwYIGEW9tJU373ERzgywk00MDp5P60Oap2pFMwhnIGp2VBF+1dGGEzX2kw
 dpPwP6pW4/zE1yhw6YtQIzTvD6wSlInfcV/lhxI1R8wRiF2ACT+cbGLQbXkgbBxYYm+X0y
 01ranZjOVJV/8Rhz782FpppFVhPRLgc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-444-9KbtG_KDMfiUTBDPR2tK1w-1; Mon, 02 Oct 2023 15:41:58 -0400
X-MC-Unique: 9KbtG_KDMfiUTBDPR2tK1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66A028032F6
 for <qemu-devel@nongnu.org>; Mon,  2 Oct 2023 19:41:58 +0000 (UTC)
Received: from [10.39.192.119] (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F167010EE6CE;
 Mon,  2 Oct 2023 19:41:56 +0000 (UTC)
Message-ID: <a8817c8e-8d8f-c713-b6f7-ba048aef3504@redhat.com>
Date: Mon, 2 Oct 2023 21:41:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/5] ramfb: make migration conditional
Content-Language: en-US
To: Alex Williamson <alex.williamson@redhat.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
 <20231002111154.1002655-5-marcandre.lureau@redhat.com>
 <f0e4b89b-b88b-edfa-7855-fa41d5c72b69@redhat.com>
 <20231002084134.22fee251.alex.williamson@redhat.com>
 <05c80aca-8134-49b8-286b-853a02359ed6@redhat.com>
 <20231002132631.669de736.alex.williamson@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
In-Reply-To: <20231002132631.669de736.alex.williamson@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/2/23 21:26, Alex Williamson wrote:
> On Mon, 2 Oct 2023 20:24:11 +0200
> Laszlo Ersek <lersek@redhat.com> wrote:
> 
>> On 10/2/23 16:41, Alex Williamson wrote:
>>> On Mon, 2 Oct 2023 15:38:10 +0200
>>> Cédric Le Goater <clg@redhat.com> wrote:
>>>   
>>>> On 10/2/23 13:11, marcandre.lureau@redhat.com wrote:  
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> RAMFB migration was unsupported until now, let's make it conditional.
>>>>> The following patch will prevent machines <= 8.1 to migrate it.
>>>>>
>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>    
>>>> Maybe localize the new 'ramfb_migrate' attribute close to 'enable_ramfb'
>>>> in VFIOPCIDevice. Anyhow,  
>>>
>>> Shouldn't this actually be tied to whether the device is migratable
>>> (which for GVT-g - the only ramfb user afaik - it's not)?  What does it
>>> mean to have a ramfb-migrate=true property on a device that doesn't
>>> support migration, or false on a device that does support migration.  I
>>> don't understand why this is a user controllable property.  Thanks,  
>>
>> The comments in <https://bugzilla.redhat.com/show_bug.cgi?id=1859424>
>> (which are unfortunately not public :/ ) suggest that ramfb migration
>> was simply forgotten when vGPU migration was implemented. So, "now
>> that vGPU migration is done", this should be added.
>>
>> Comment 8 suggests that the following domain XML snippet
>>
>>     <hostdev mode='subsystem' type='mdev' managed='no'
>> model='vfio-pci' display='on' ramfb='on'> <source>
>>         <address uuid='b155147a-663a-4009-ae7f-e9a96805b3ce'/>
>>       </source>
>>       <alias name='ua-b155147a-663a-4009-ae7f-e9a96805b3ce'/>
>>       <address type='pci' domain='0x0000' bus='0x07' slot='0x00'
>> function='0x0'/> </hostdev>
>>
>> is migratable, but the ramfb device malfunctions on the destination
>> host.
>>
>> There's also a huge QEMU cmdline in comment#0 of the bug; I've not
>> tried to read that.
>>
>> AIUI BTW the property is not for the user to control, it's just a
>> compat knob for versioned machine types. AIUI those are usually
>> implemented with such (user-visible / -tweakable) device properties.
> 
> If it's not for user control it's unfortunate that we expose it to the
> user at all, but should it at least use the "x-" prefix to indicate that
> it's not intended to be an API?

I *think* it was your commit db32d0f43839 ("vfio/pci: Add option to
disable GeForce quirks", 2018-02-06) that hda introduced me to the "x-"
prefixed properties!

For some reason though, machine type compat knobs are never named like
that, AFAIR.

> It's still odd to think that we can
> have scenarios of a non-migratable vfio device registering a migratable
> ramfb, and vice versa, but I suppose in the end it doesn't matter.

I do think it matters! For one, if migration is not possible with
vfio-pci-nohotplug, then how can QE (or anyone else) *test* the patch
(i.e. that it makes a difference)? In that case, the ramfb_setup() call
from vfio-pci-nohotplug should just open-code "false" for the
"migratable" parameter.

But, more importantly, I think either we're missing something about RHBZ
1859424, or that use case is just plain wrong. Gerd, any comments perhaps?

Migration certainly makes sense for ramfb-standalone though.

Laszlo


