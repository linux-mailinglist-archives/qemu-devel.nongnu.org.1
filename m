Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA58760CED
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 10:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qODMG-0003Oa-EE; Tue, 25 Jul 2023 04:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qODME-0003OB-2z
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qODMC-0001R4-BJ
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 04:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690273523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SSehegRlTJj0VOUmq7VA9VYfDUQ0Fo/nDxY5HQ9m71E=;
 b=VbtF2oYkFFnvL9EpmWR7beQq8Ei0yI0JQ92pNprfgz5HLt05L9WHaGOLPpr9VtXK0nGT0+
 KBjCKzuPFKmhFr30Y8Coujk/qqMqqM3Lurf5IKmIxwPTvcC2jOkUkDl7ViktcPirLQvLkw
 88a4Khy8AUGHbvZ4H+vBJaMm7d2njFo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-4uUE3aU2Phe61oDwh_IJlA-1; Tue, 25 Jul 2023 04:25:19 -0400
X-MC-Unique: 4uUE3aU2Phe61oDwh_IJlA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C001985A58A;
 Tue, 25 Jul 2023 08:25:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DE3C40C2063;
 Tue, 25 Jul 2023 08:25:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A609F21E668C; Tue, 25 Jul 2023 10:25:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Thomas Huth
 <thuth@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Daniel
 P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Eric
 Blake <eblake@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v6 0/6] Hyper-V Dynamic Memory Protocol driver
 (hv-balloon =?utf-8?B?8J+OiO+4jyk=?=
References: <cover.1689786474.git.maciej.szmigiero@oracle.com>
 <7b39c541-6aeb-3dc4-2451-67a6b2ff34c6@redhat.com>
Date: Tue, 25 Jul 2023 10:25:17 +0200
In-Reply-To: <7b39c541-6aeb-3dc4-2451-67a6b2ff34c6@redhat.com> (David
 Hildenbrand's message of "Mon, 24 Jul 2023 16:42:28 +0200")
Message-ID: <87351ciej6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

David Hildenbrand <david@redhat.com> writes:

> On 20.07.23 12:12, Maciej S. Szmigiero wrote:
>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>> This is a continuation of the v5 of the patch series located here:
>> https://lore.kernel.org/qemu-devel/cover.1686577753.git.maciej.szmigiero@oracle.com/
>> 
>
> We're now in QEMU soft-freeze, which means the memslot series might take a bit to land. I'm going to follow-up on that soonish.
>
>> Changes from v5:
>> * Incorporate David's rework of the driver on top of his virtio-mem-memslots
>> patches (specifically, commit 6769107d1a4f), making use of a memory region
>> container created upfront to avoid calling memory_device{,_pre}_plug()
>> functions from the driver and introducing a driver-specific MemoryDeviceInfo
>> sub-type.
>> * Include two additional David's memory-device patches necessary for the
>> aforementioned conversion in this patch set.
>> * Use multiple memslots to cover the hot-add memory backend in order to
>> reduce metadata size for the not-yet-hot-added part of the memory backend.
>> * Add David's "Co-developed-by:" to patches where he contributed some changes.
>> * Use OBJECT_DEFINE_TYPE_WITH_INTERFACES() and OBJECT_DECLARE_SIMPLE_TYPE()
>> macros instead of open-coding the equivalent functionality.
>> * Drop no longer necessary patch adding g_autoptr() cleanup function for the
>> Error type.
>> David Hildenbrand (2):
>>    memory-device: Support empty memory devices
>>    memory-device: Drop size alignment check
>> Maciej S. Szmigiero (4):
>>    Add Hyper-V Dynamic Memory Protocol definitions
>>    qapi: Add HvBalloonDeviceInfo sub-type to MemoryDeviceInfo
>>    qapi: Add HV_BALLOON_STATUS_REPORT event
>>    Add a Hyper-V Dynamic Memory Protocol driver (hv-balloon)
>
> That is still a gigantic patch. Is there any way to split that into reasonable chunks? For example, move the whole hotplug/memslot part into
> a dedicated patch?
>
> See below on splitting off the PC changes.
>
>>   Kconfig.host                     |    3 +
>>   hw/core/machine-hmp-cmds.c       |   15 +
>>   hw/hyperv/Kconfig                |    5 +
>>   hw/hyperv/hv-balloon.c           | 2246 ++++++++++++++++++++++++++++++
>>   hw/hyperv/meson.build            |    1 +
>>   hw/hyperv/trace-events           |   18 +
>>   hw/i386/pc.c                     |   22 +
>>   hw/mem/memory-device.c           |   45 +-
>>   include/hw/hyperv/dynmem-proto.h |  423 ++++++
>>   include/hw/hyperv/hv-balloon.h   |   18 +
>>   include/hw/mem/memory-device.h   |    7 +-
>>   meson.build                      |   28 +-
>>   meson_options.txt                |    2 +
>>   qapi/machine.json                |   64 +-
>>   scripts/meson-buildoptions.sh    |    3 +
>
> It's probably best to separate the actual device implementation from wiring up the machine. That is, have a HV_BALLOON_SUPPORTED kconfig
> (like VIRTIO_MEM_SUPPORTED), and activate that in a single commit for
> PC, where you also modify hw/i386/pc.c.
>
> That commit would be called something like "pc: Support hv-balloon".

Furthermore, try to factor out stuff related to QMP:

0. The driver with QMP stuff omitted / stubbed out

1. Enable query-memory-devices

2. Add HV_BALLOON_STATUS_REPORT event


