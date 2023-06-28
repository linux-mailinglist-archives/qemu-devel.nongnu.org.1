Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDB27409B5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:32:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPeF-0000HB-1m; Wed, 28 Jun 2023 03:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEPeC-0000Gb-V9
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qEPeA-0006cw-JT
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687937485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A0MaxIoMx5vEsgD+F7RwW5QYpXc+I7/nMk/8B3/AhCc=;
 b=H1+LMQKpQ6lfOHfsv/9ZhKK0cXe8x2RrpmMkzn5d2m0HbdoZqrxTsAVodDvzwL2E6OP6Od
 LnjtAV5pkOixBwPP3ZVsF7dVARAxmnkFhfQI3QLgrSeKlzyiZ8LCti+Svj3pfw0YxcHoew
 oXykEVtHKRn2Au9LxBWXISBYZEH5nJM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-eDkOvex6NqKRCT9ah8vOcA-1; Wed, 28 Jun 2023 03:30:22 -0400
X-MC-Unique: eDkOvex6NqKRCT9ah8vOcA-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40285915ca8so18733321cf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687937422; x=1690529422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A0MaxIoMx5vEsgD+F7RwW5QYpXc+I7/nMk/8B3/AhCc=;
 b=Kq65ij3GKHNpm3wmJBZuMm8IltvPpfQyDOXjJioepIX1oo44FJcgkv8M/cWgwEPxTx
 4c/E7fhrmwwVugLA8Iu+rViWB8H1cI0VOZWuRAT/yOn3ipMqpMiXWpxZxbSdR0xQBHrD
 MofF/C9wwv89zVtxD6JnGFp1AUNYWZ8i85fGIxPMFTEr591RjlV6Q0ryzUms2bxzrI+z
 i7G/B2gzT3GqVfIqT2jeU2lQ0C2yJOC/ONsGZpYO0KuIpePieNBRBivmxpPCwGkQI+iY
 RAGf3v/okdE5mi7cI73AiOXe6O5AiKMvGN6HgYvBGtHZqnraOYs2M6QR2oKsZVHkqkQr
 /zCg==
X-Gm-Message-State: AC+VfDwTaH7d5XpBZreXJONB8tbpTueQDPX7LRARvl+5GobXuVNny6qp
 p1WVwFE0cu8CuocUydApevVo2/RgXJ5ohlZW4WKiDicaiWlQeaNNyFrMpJf3WjUeAE3HPoGZQMW
 J2A1y2KA9VHwDpvNc2PKHJjs=
X-Received: by 2002:a05:622a:1823:b0:3ff:3360:c738 with SMTP id
 t35-20020a05622a182300b003ff3360c738mr29556845qtc.39.1687937421631; 
 Wed, 28 Jun 2023 00:30:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5pMW9feXf0niID0Qes5HuQU3q17N53yw6620lXaCK4zKYvw372rpe+M06T+RlVFWJ9JQp6ZQ==
X-Received: by 2002:a05:622a:1823:b0:3ff:3360:c738 with SMTP id
 t35-20020a05622a182300b003ff3360c738mr29556830qtc.39.1687937421345; 
 Wed, 28 Jun 2023 00:30:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 m26-20020ac866da000000b003fe0a89447fsm5527868qtp.14.2023.06.28.00.30.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:30:21 -0700 (PDT)
Message-ID: <21cf43f3-4db1-e2a0-8bfe-03228c5263f3@redhat.com>
Date: Wed, 28 Jun 2023 09:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 52/53] vhost_net: add an assertion for TAP client backends
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
 <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
 <A0C56F97-3830-4DF3-8BDD-D49611418056@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <A0C56F97-3830-4DF3-8BDD-D49611418056@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.103, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/28/23 08:45, Ani Sinha wrote:
> 
> 
>> On 28-Jun-2023, at 11:58 AM, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> Hello,
>>
>> On 6/26/23 14:30, Michael S. Tsirkin wrote:
>>> From: Ani Sinha <anisinha@redhat.com>
>>> An assertion was missing for tap vhost backends that enforces a non-null
>>> reference from get_vhost_net(). Both vhost-net-user and vhost-net-vdpa
>>> enforces this. Enforce the same for tap. Unit tests pass with this change.
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>   hw/net/vhost_net.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>> index c4eecc6f36..6db23ca323 100644
>>> --- a/hw/net/vhost_net.c
>>> +++ b/hw/net/vhost_net.c
>>> @@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
>>>       switch (nc->info->type) {
>>>       case NET_CLIENT_DRIVER_TAP:
>>>           vhost_net = tap_get_vhost_net(nc);
>>> +        assert(vhost_net);
>>>           break;
>>>   #ifdef CONFIG_VHOST_NET_USER
>>>       case NET_CLIENT_DRIVER_VHOST_USER:
>>
>> A system of mine without vhost_net (old host kernel) is reaching this assert
> 
> We need to understand why this assertion is being hit. It could be a bug somewhere else.

sure.

> What is the backtrace? 


#0  __pthread_kill_implementation (threadid=549621125152, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
#1  0x0000007ff71df254 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
#2  0x0000007ff719a67c in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
#3  0x0000007ff7187130 in __GI_abort () at ./stdlib/abort.c:79
#4  0x0000007ff7193fd0 in __assert_fail_base
     (fmt=0x7ff72ad3f8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x5556208c00 "vhost_net", file=file@entry=0x5556208ae0 "../hw/net/vhost_net.c", line=line@entry=510, function=function@entry=0x5556208de8 <__PRETTY_FUNCTION__.2> "get_vhost_net") at ./assert/assert.c:92
#5  0x0000007ff7194040 in __GI___assert_fail
     (assertion=assertion@entry=0x5556208c00 "vhost_net", file=file@entry=0x5556208ae0 "../hw/net/vhost_net.c", line=line@entry=510, function=function@entry=0x5556208de8 <__PRETTY_FUNCTION__.2> "get_vhost_net") at ./assert/assert.c:101
#6  0x0000005555a767ac in get_vhost_net (nc=<optimized out>) at ../hw/net/vhost_net.c:510
#7  0x0000005555e6aea8 in virtio_net_get_features (vdev=0x55578cc770, features=1105849221095, errp=<optimized out>) at ../hw/net/virtio-net.c:807
#8  0x0000005555b69da4 in virtio_bus_device_plugged (vdev=vdev@entry=0x55578cc770, errp=errp@entry=0x7fffffe640) at ../hw/virtio/virtio-bus.c:66
#9  0x0000005555e8b6a0 in virtio_device_realize (dev=0x55578cc770, errp=0x7fffffe6c0) at ../hw/virtio/virtio.c:3609
#10 0x0000005555f1ead8 in device_set_realized (obj=0x55578cc770, value=<optimized out>, errp=0x7fffffe898) at ../hw/core/qdev.c:510
#11 0x0000005555f22a14 in property_set_bool (obj=0x55578cc770, v=<optimized out>, name=<optimized out>, opaque=0x5556be9ad0, errp=0x7fffffe898) at ../qom/object.c:2285
#12 0x0000005555f260fc in object_property_set (obj=obj@entry=0x55578cc770, name=name@entry=0x555621c280 "realized", v=v@entry=0x55578d9310, errp=errp@entry=0x7fffffe898)
     at ../qom/object.c:1420
#13 0x0000005555f2a85c in object_property_set_qobject
     (obj=obj@entry=0x55578cc770, name=name@entry=0x555621c280 "realized", value=value@entry=0x55578d9250, errp=errp@entry=0x7fffffe898) at ../qom/qom-qobject.c:28
#14 0x0000005555f26820 in object_property_set_bool (obj=0x55578cc770, name=0x555621c280 "realized", value=<optimized out>, errp=0x7fffffe898) at ../qom/object.c:1489
#15 0x0000005555aafd24 in pci_qdev_realize (qdev=<optimized out>, errp=<optimized out>) at ../hw/pci/pci.c:2116
#16 0x0000005555f1ead8 in device_set_realized (obj=0x55578c43a0, value=<optimized out>, errp=0x7fffffeae8) at ../hw/core/qdev.c:510
#17 0x0000005555f22a14 in property_set_bool (obj=0x55578c43a0, v=<optimized out>, name=<optimized out>, opaque=0x5556be9ad0, errp=0x7fffffeae8) at ../qom/object.c:2285
#18 0x0000005555f260fc in object_property_set (obj=obj@entry=0x55578c43a0, name=name@entry=0x555621c280 "realized", v=v@entry=0x55578d34c0, errp=errp@entry=0x7fffffeae8)
     at ../qom/object.c:1420
#19 0x0000005555f2a85c in object_property_set_qobject
     (obj=obj@entry=0x55578c43a0, name=name@entry=0x555621c280 "realized", value=value@entry=0x55578d3450, errp=errp@entry=0x7fffffeae8) at ../qom/qom-qobject.c:28
#20 0x0000005555f26820 in object_property_set_bool (obj=0x55578c43a0, name=0x555621c280 "realized", value=<optimized out>, errp=0x7fffffeae8) at ../qom/object.c:1489
#21 0x0000005555ba4f7c in qdev_device_add_from_qdict (opts=opts@entry=0x55578c3110, from_json=from_json@entry=false, errp=0x7fffffeae8, errp@entry=0x5556b24a28 <error_fatal>)
     at ../softmmu/qdev-monitor.c:714
#22 0x0000005555ba5170 in qdev_device_add (opts=0x5556be6060, errp=errp@entry=0x5556b24a28 <error_fatal>) at ../softmmu/qdev-monitor.c:733
#23 0x0000005555baa09c in device_init_func (opaque=<optimized out>, opts=<optimized out>, errp=0x5556b24a28 <error_fatal>) at ../softmmu/vl.c:1152
#24 0x00000055560b2124 in qemu_opts_foreach
     (list=<optimized out>, func=func@entry=0x5555baa080 <device_init_func>, opaque=opaque@entry=0x0, errp=errp@entry=0x5556b24a28 <error_fatal>) at ../util/qemu-option.c:1135
#25 0x0000005555bac88c in qemu_create_cli_devices () at ../softmmu/vl.c:2573
#26 qmp_x_exit_preconfig (errp=<optimized out>) at ../softmmu/vl.c:2641
#27 0x0000005555bafee4 in qmp_x_exit_preconfig (errp=<optimized out>) at ../softmmu/vl.c:2635
#28 qemu_init (argc=<optimized out>, argv=<optimized out>) at ../softmmu/vl.c:3648
#29 0x00000055558e839c in main (argc=<optimized out>, argv=<optimized out>) at ../softmmu/main.c:47

> What is the repro case?

Nothing special :

qemu-system-aarch64 -M virt -accel kvm -cpu host -nographic -m 2G \
  -drive if=pflash,format=raw,file=./EFI/efi.img,readonly=on \
  -drive if=pflash,format=raw,file=fedora-varstore.img \
  -device virtio-net,netdev=net0,mac=C0:FF:EE:00:00:12,bus=pcie.0,addr=0x3 \
  -netdev tap,id=net0,helper=/usr/lib/qemu/qemu-bridge-helper,br=virbr0,vhost=off \
  -drive file=fedora-arm64.qcow2,if=none,id=disk,format=qcow2,cache=none \
  -device virtio-blk-device,drive=disk \
  -serial mon:stdio
qemu-system-aarch64: ../hw/net/vhost_net.c:510: get_vhost_net: Assertion `vhost_net' failed.

Thanks,

C.


