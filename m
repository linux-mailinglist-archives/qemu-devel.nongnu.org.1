Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C3F76210D
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMUN-0000tA-1E; Tue, 25 Jul 2023 14:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qOMUK-0000sn-Jv
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:10:24 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mail@maciej.szmigiero.name>)
 id 1qOMUI-0002nK-LL
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:10:24 -0400
Received: from MUA by vps-vb.mhejs.net with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <mail@maciej.szmigiero.name>)
 id 1qOMTz-0004Yl-Pb; Tue, 25 Jul 2023 20:10:03 +0200
Message-ID: <2212c3f5-954a-84a6-7011-b40bbc54ad23@maciej.szmigiero.name>
Date: Tue, 25 Jul 2023 20:09:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US, pl-PL
To: David Hildenbrand <david@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <7b39c541-6aeb-3dc4-2451-67a6b2ff34c6@redhat.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v6_0/6=5d_Hyper-V_Dynamic_Memory_Protocol_?=
 =?UTF-8?B?ZHJpdmVyIChodi1iYWxsb29uIPCfjojvuI8p?=
In-Reply-To: <7b39c541-6aeb-3dc4-2451-67a6b2ff34c6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.28.154.113;
 envelope-from=mail@maciej.szmigiero.name; helo=vps-vb.mhejs.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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

On 24.07.2023 16:42, David Hildenbrand wrote:
> On 20.07.23 12:12, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>
>> This is a continuation of the v5 of the patch series located here:
>> https://lore.kernel.org/qemu-devel/cover.1686577753.git.maciej.szmigiero@oracle.com/
>>
> 
> We're now in QEMU soft-freeze, which means the memslot series might take a bit to land. I'm going to follow-up on that soonish.

Ack, [1] even says that we're in a hard-freeze already.

>>
>> Changes from v5:
>> * Incorporate David's rework of the driver on top of his virtio-mem-memslots
>> patches (specifically, commit 6769107d1a4f), making use of a memory region
>> container created upfront to avoid calling memory_device{,_pre}_plug()
>> functions from the driver and introducing a driver-specific MemoryDeviceInfo
>> sub-type.
>>
>> * Include two additional David's memory-device patches necessary for the
>> aforementioned conversion in this patch set.
>>
>> * Use multiple memslots to cover the hot-add memory backend in order to
>> reduce metadata size for the not-yet-hot-added part of the memory backend.
>>
>> * Add David's "Co-developed-by:" to patches where he contributed some changes.
>>
>> * Use OBJECT_DEFINE_TYPE_WITH_INTERFACES() and OBJECT_DECLARE_SIMPLE_TYPE()
>> macros instead of open-coding the equivalent functionality.
>>
>> * Drop no longer necessary patch adding g_autoptr() cleanup function for the
>> Error type.
>>
>>
>> David Hildenbrand (2):
>>    memory-device: Support empty memory devices
>>    memory-device: Drop size alignment check
>>
>> Maciej S. Szmigiero (4):
>>    Add Hyper-V Dynamic Memory Protocol definitions
>>    qapi: Add HvBalloonDeviceInfo sub-type to MemoryDeviceInfo
>>    qapi: Add HV_BALLOON_STATUS_REPORT event
>>    Add a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
> 
> That is still a gigantic patch. Is there any way to split that into reasonable chunks? For example, move the whole hotplug/memslot part into
> a dedicated patch?

Will move hot-add support from the initial driver patch to a separate one.

> See below on splitting off the PC changes.
> 
>>
>>   Kconfig.host                     |    3 +
>>   hw/core/machine-hmp-cmds.c       |   15 +
>>   hw/hyperv/Kconfig                |    5 +
>>   hw/hyperv/hv-balloon.c           | 2246 ++++++++++++++++++++++++++++++
>>   hw/hyperv/meson.build            |    1 +
>>   hw/hyperv/trace-events           |   18 +
>>   hw/i386/pc.c                     |   22 +
>>   hw/mem/memory-device.c           |   45 +-
>>   include/hw/hyperv/dynmem-proto.h |  423 ++++++
>>   include/hw/hyperv/hv-balloon.h   |   18 +
>>   include/hw/mem/memory-device.h   |    7 +-
>>   meson.build                      |   28 +-
>>   meson_options.txt                |    2 +
>>   qapi/machine.json                |   64 +-
>>   scripts/meson-buildoptions.sh    |    3 +
> 
> It's probably best to separate the actual device implementation from wiring up the machine. That is, have a HV_BALLOON_SUPPORTED kconfig
> (like VIRTIO_MEM_SUPPORTED), and activate that in a single commit for
> PC, where you also modify hw/i386/pc.c.
> 
> That commit would be called something like "pc: Support hv-balloon".

If I remove the driver from Kconfig in the initial patch then AFAIK
this initial patch will add a dead driver file that it is not possible
to build yet, right?

Or is there some configure-time override for lack of specific Kconfig option?

Thanks,
Maciej

[1]: https://wiki.qemu.org/Planning/8.1


