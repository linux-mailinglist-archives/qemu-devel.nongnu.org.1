Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A26273823E
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 13:14:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBvn3-0003wI-Nw; Wed, 21 Jun 2023 07:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bob.beckett@collabora.com>)
 id 1qBvn1-0003s4-5e
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:14:19 -0400
Received: from madras.collabora.co.uk ([46.235.227.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bob.beckett@collabora.com>)
 id 1qBvmz-0002xB-87
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 07:14:18 -0400
Received: from [192.168.178.53] (82-71-8-225.dsl.in-addr.zen.co.uk
 [82.71.8.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbeckett)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id E5D586606F8B;
 Wed, 21 Jun 2023 12:14:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1687346055;
 bh=MJIa8GnFWfms/olooPp651/+u8wmfzSy1yn/q7OMU28=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=TlctRtqxSe2Xfa93NmrfOZsDe3qO+n5QormbBFMXTqpdUajdSHjL7aC6Oxlxd1bDK
 2nYpU77KYpXJkWmEViBea8NjmWeM+Wnd4K38CSYLVt7HzIZFMTZ0JCf9s3UVwZqBmH
 gxhUEZb2cfbKeE5cm69nLVrjTt77BOXHu06WoDST4zUNqAL6M42gdsevvM1sY9SceH
 8FVltG6sbbgf61AIwFkoqJKA4+LXTyPjhMegrOokmeXhLtoc9GErYo18Le5WSCAfd1
 yFVm7p4XY/v5CT1u9dn1Exw4RHic1pLUcUJR/w9UvRYoMMtPNF7WJlY8XPd8UM+wPA
 zknwi14bIv5Qg==
Message-ID: <e9e10508-c26c-cf2a-6407-8e26a1342370@collabora.com>
Date: Wed, 21 Jun 2023 12:14:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [QEMU PATCH 1/1] virtgpu: do not destroy resources when guest
 suspend
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Chen, Jiqian" <Jiqian.Chen@amd.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
 Jan Beulich <jbeulich@suse.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
 Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
References: <20230608025655.1674357-1-Jiqian.Chen@amd.com>
 <20230608025655.1674357-2-Jiqian.Chen@amd.com>
 <CAJ+F1CKjTW7zycr2xAW0x+d_7CEy+LxWur2Tqp2dvsb=PoJ5Dw@mail.gmail.com>
 <q2rpqbg5b4bqxb7oayclzgbf5fplofm3dmxgmpmskjf4mcfzpn@peeiuxwkqxbb>
 <BL1PR12MB58491E2E13F959365AA3F594E75CA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <lgan3p6wqmxht5fpduh5nvg3f5m5n636k7zrrealnu2lilghhh@qlbvgu3l4apw>
 <2164ff79-aa09-d959-cc61-c7a2a21db5e3@collabora.com>
 <2s33vb2tfogntkyk5laxzcmgexf42mhkpwr2gh3gjvpitav6ez@h5zbmuklzmv5>
Content-Language: en-US
From: Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <2s33vb2tfogntkyk5laxzcmgexf42mhkpwr2gh3gjvpitav6ez@h5zbmuklzmv5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.235.227.172;
 envelope-from=bob.beckett@collabora.com; helo=madras.collabora.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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


On 21/06/2023 09:39, Gerd Hoffmann wrote:
> On Tue, Jun 20, 2023 at 01:26:15PM +0100, Robert Beckett wrote:
>> On 20/06/2023 10:41, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>>> The guest driver should be able to restore resources after resume.
>>>> Thank you for your suggestion!
>>>> As far as I know, resources are created on host side and guest has no backup, if resources are destroyed, guest can't restore them.
>>>> Or do you mean guest driver need to send commands to re-create resources after resume?
>>> The later.  The guest driver knows which resources it has created,
>>> it can restore them after suspend.
>> Are you sure that this is viable?
>>
>> How would you propose that a guest kernel could reproduce a resource,
>> including pixel data upload during a resume?
>>
>> The kernel would not have any of the pixel data to transfer to host.
> Depends on the of resource type.  For resources which are created by
> uploading pixel data (using VIRTIO_GPU_CMD_TRANSFER_TO_HOST_*) a guest
> mirror exists which can be used for re-upload.

unfortunately this is not always the case.

https://gitlab.freedesktop.org/mesa/mesa/-/blob/main/src/gallium/drivers/virgl/virgl_resource.c#L668

Often mesa will decide that it won't need to access a resource again 
after initial upload (textures etc). In this case, if it is able to copy 
back from host if needed, it will not maintain the guest shadow copy. 
Instead it will create a single page proxy object. The transfer to host 
will then over fill it to the correct size.

I think this was a fairly huge optimization for them.

>
> For resources filled by gl rendering ops this is indeed not the case.
>
>> Could you explain how you anticipate the guest being able to reproduce the
>> resources please?
> Same you do on physical hardware?  Suspend can poweroff your PCI
> devices, so there must be some standard way to handle that situation
> for resources stored in gpu device memory, which is very similar to
> the problem we have here.

In traditional PCI gfx card setups, TTM is used as the memory manager in 
the kernel. This is used to migrate the buffers back from VRAM to system 
pages during a suspend.

This would be suitable for use to track host blob buffers that get 
mapped to guest via the PCI BAR, though would be a significant 
re-architecting of virtio gpu driver.

It would not help with the previously mentioned proxied resources. 
Though in theory the driver could read the resources back from host to 
guest pages during suspend, this would then be potentially complicated 
by suspend time alloc failures etc.


As virtio drivers are by design paravirt drivers ,I think it is 
reasonable to accept some knowledge with and cooperation with the host 
to manage suspend/resume.

It seems to me like a lot of effort and long term maintenance to add 
support for transparent suspend/resume that would otherwise be unneeded.

Perhaps others have alternative designs for this?

>
> take care,
>    Gerd
>

