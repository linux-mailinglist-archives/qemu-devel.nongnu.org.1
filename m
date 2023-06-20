Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A57736BE9
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaRG-00021a-3v; Tue, 20 Jun 2023 08:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bob.beckett@collabora.com>)
 id 1qBaRD-00020v-LZ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:26:23 -0400
Received: from madras.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e5ab])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bob.beckett@collabora.com>)
 id 1qBaRB-0005Y8-8c
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:26:23 -0400
Received: from [192.168.178.53] (82-71-8-225.dsl.in-addr.zen.co.uk
 [82.71.8.225])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested) (Authenticated sender: bbeckett)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id BAB3D6605718;
 Tue, 20 Jun 2023 13:26:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1687263978;
 bh=yZyDrMyO+3ejazrQfwtkejwWXQEo4FxnPnweMXfNVXE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H0ejeDa5cxYbiRL4VkfRPga/PpUl2v3TPO8gf3FZslRG5jCBuulgLFqjwfSrpqZ2V
 JENU9fvzeNJxdAyv2B2dTwz1xy64fbU20snkd7l6/u0WYYJrZIExP3wvYbZOu6jpEU
 B/sQYOYJ1T++2gSoh1f+YWcaw9+El6vWdK/CtTNhZK8JxcYGnyp6sDx7HBqxgUeb6f
 uBPFSk2N83WK6LH4lroINDJV6fJUt8iyVMQzKh66tus8ik6zmRTYSsDuaSrfsCMRan
 CuIoVF5HCWjG+uVVlXtEALFKUzhX/eWzQUqSnroT6ufLSleOiypQVBJn4P3vbMCxwe
 AF0vMySbAwKQA==
Message-ID: <2164ff79-aa09-d959-cc61-c7a2a21db5e3@collabora.com>
Date: Tue, 20 Jun 2023 13:26:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [QEMU PATCH 1/1] virtgpu: do not destroy resources when guest
 suspend
To: Gerd Hoffmann <kraxel@redhat.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
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
Content-Language: en-US
From: Robert Beckett <bob.beckett@collabora.com>
In-Reply-To: <lgan3p6wqmxht5fpduh5nvg3f5m5n636k7zrrealnu2lilghhh@qlbvgu3l4apw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1098:0:82:1000:25:2eeb:e5ab;
 envelope-from=bob.beckett@collabora.com; helo=madras.collabora.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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


On 20/06/2023 10:41, Gerd Hoffmann wrote:
>    Hi,
>
>>> The guest driver should be able to restore resources after resume.
>> Thank you for your suggestion!
>> As far as I know, resources are created on host side and guest has no backup, if resources are destroyed, guest can't restore them.
>> Or do you mean guest driver need to send commands to re-create resources after resume?
> The later.  The guest driver knows which resources it has created,
> it can restore them after suspend.


Are you sure that this is viable?

How would you propose that a guest kernel could reproduce a resource, 
including pixel data upload during a resume?

The kernel would not have any of the pixel data to transfer to host. 
This is normally achieved by guest apps calling GL calls and mesa asking 
the kernel to create the textures with the given data (often read from a 
file).
If your suggestion is to get the userland application to do it, that 
would entirely break how suspend/resume is meant to happen. It should be 
transparent to userland applications for the most part.

Could you explain how you anticipate the guest being able to reproduce 
the resources please?


>
>> If so, I have some questions. Can guest re-create resources by using
>> object(virtio_vpu_object) or others? Can the new resources replace the
>> destroyed resources to continue the suspended display tasks after
>> resume?
> Any display scanout information will be gone too, the guest driver needs
> re-create this too (after re-creating the resources).
>
> take care,
>    Gerd
>

