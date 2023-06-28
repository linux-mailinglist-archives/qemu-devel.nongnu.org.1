Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9048740F50
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:51:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qESlU-00069V-Tr; Wed, 28 Jun 2023 06:51:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qESlN-00068T-1m
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qESlK-0007J5-BI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687949456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vxtQzNt/pBj7OcJIB6SxLWXaw/Q9wf2rcnn5/tdhts=;
 b=RKNYso2cxfOVDzb93N6JrII92u6Xo5CqyZTegMKjxqQQdo9T2iBET9dXqaaG6xu4HlT8Ry
 h6TxOzAEecTmloRz1f/Nm92UL3njhftf9Nk8EicebsmgjoxEbTicDJLWGo2uABT5DnOkEm
 Ka5UKPxcQYMYi8sHqE1sJvfMm6W5kuA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-FHu6KO5hORCj34BVk1vwIQ-1; Wed, 28 Jun 2023 06:50:53 -0400
X-MC-Unique: FHu6KO5hORCj34BVk1vwIQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313e6020882so381873f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 03:50:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687949452; x=1690541452;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8vxtQzNt/pBj7OcJIB6SxLWXaw/Q9wf2rcnn5/tdhts=;
 b=FUk4LWR6h+a01+swZowLALEe7aG3B+JmsvGz94/fxZC0azk/0Wm10JlTMibUgD+llP
 bwCbs6LxsX6PBsN8u20xJuh6oqF8STPiY/f76XwEXIoI6AxMCe2at9pXDcw3iTVc/vJN
 64HycO3vGuvIjMr79GI5AKdeMcnS5lcB12QwlVLZ5Evtvpt0R9pgwO6ro+FZBcbKi3Kg
 G6KPYKy/rh3cuYCVUDjVCtb8tj0aBYWj0jtEtqJD9S8sm6dv0iAQSR6SQC+Z2cz9Wp9N
 a/YZPjGUbFH0B+KKoeweZatq/z57x3sh7U+lM3d5QFXc2sBV2vli4k4EQ0RHwXdeiY5L
 VzIg==
X-Gm-Message-State: AC+VfDx/a7IE68i3BxrTj49CXyUfRr1GeR61HTFpmHrJ/SrUSChO1iKi
 EW6FHHEAPPilT5CcHuPD5FhE1SFzEm5cwzh24u93ad5d4A7RyOHrrsfJ2qhNG4yJBNVRxfBatOV
 XjT1Uru9hg3S6jAo=
X-Received: by 2002:adf:e803:0:b0:314:475:bc6b with SMTP id
 o3-20020adfe803000000b003140475bc6bmr1217703wrm.18.1687949452250; 
 Wed, 28 Jun 2023 03:50:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6aePT42892iGbtB4yyXzMMBHOw4O62IAMBq+/QDig2ltDPOkKsk+PxuzKXj8qenB3DQUsE5A==
X-Received: by 2002:adf:e803:0:b0:314:475:bc6b with SMTP id
 o3-20020adfe803000000b003140475bc6bmr1217680wrm.18.1687949451819; 
 Wed, 28 Jun 2023 03:50:51 -0700 (PDT)
Received: from redhat.com ([176.12.183.225]) by smtp.gmail.com with ESMTPSA id
 q18-20020adfcd92000000b003140f47224csm787569wrj.15.2023.06.28.03.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 03:50:51 -0700 (PDT)
Date: Wed, 28 Jun 2023 06:50:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PULL 52/53] vhost_net: add an assertion for TAP client backends
Message-ID: <20230628064927-mutt-send-email-mst@kernel.org>
References: <cover.1687782442.git.mst@redhat.com>
 <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
 <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
 <A0C56F97-3830-4DF3-8BDD-D49611418056@redhat.com>
 <21cf43f3-4db1-e2a0-8bfe-03228c5263f3@redhat.com>
 <2704D32C-D09E-4324-A8CB-744F5E5B47CD@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2704D32C-D09E-4324-A8CB-744F5E5B47CD@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jun 28, 2023 at 04:03:44PM +0530, Ani Sinha wrote:
> 
> 
> > On 28-Jun-2023, at 1:00 PM, Cédric Le Goater <clg@redhat.com> wrote:
> > 
> > On 6/28/23 08:45, Ani Sinha wrote:
> >>> On 28-Jun-2023, at 11:58 AM, Cédric Le Goater <clg@redhat.com> wrote:
> >>> 
> >>> Hello,
> >>> 
> >>> On 6/26/23 14:30, Michael S. Tsirkin wrote:
> >>>> From: Ani Sinha <anisinha@redhat.com>
> >>>> An assertion was missing for tap vhost backends that enforces a non-null
> >>>> reference from get_vhost_net(). Both vhost-net-user and vhost-net-vdpa
> >>>> enforces this. Enforce the same for tap. Unit tests pass with this change.
> >>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >>>> Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
> >>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >>>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> >>>> ---
> >>>>  hw/net/vhost_net.c | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >>>> index c4eecc6f36..6db23ca323 100644
> >>>> --- a/hw/net/vhost_net.c
> >>>> +++ b/hw/net/vhost_net.c
> >>>> @@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState *nc)
> >>>>      switch (nc->info->type) {
> >>>>      case NET_CLIENT_DRIVER_TAP:
> >>>>          vhost_net = tap_get_vhost_net(nc);
> >>>> +        assert(vhost_net);
> >>>>          break;
> >>>>  #ifdef CONFIG_VHOST_NET_USER
> >>>>      case NET_CLIENT_DRIVER_VHOST_USER:
> >>> 
> >>> A system of mine without vhost_net (old host kernel) is reaching this assert
> >> We need to understand why this assertion is being hit. It could be a bug somewhere else.
> > 
> > sure.
> > 
> >> What is the backtrace? 
> > 
> > 
> > #0  __pthread_kill_implementation (threadid=549621125152, signo=signo@entry=6, no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
> > #1  0x0000007ff71df254 in __pthread_kill_internal (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
> > #2  0x0000007ff719a67c in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
> > #3  0x0000007ff7187130 in __GI_abort () at ./stdlib/abort.c:79
> > #4  0x0000007ff7193fd0 in __assert_fail_base
> >    (fmt=0x7ff72ad3f8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", assertion=assertion@entry=0x5556208c00 "vhost_net", file=file@entry=0x5556208ae0 "../hw/net/vhost_net.c", line=line@entry=510, function=function@entry=0x5556208de8 <__PRETTY_FUNCTION__.2> "get_vhost_net") at ./assert/assert.c:92
> > #5  0x0000007ff7194040 in __GI___assert_fail
> >    (assertion=assertion@entry=0x5556208c00 "vhost_net", file=file@entry=0x5556208ae0 "../hw/net/vhost_net.c", line=line@entry=510, function=function@entry=0x5556208de8 <__PRETTY_FUNCTION__.2> "get_vhost_net") at ./assert/assert.c:101
> > #6  0x0000005555a767ac in get_vhost_net (nc=<optimized out>) at ../hw/net/vhost_net.c:510
> > #7  0x0000005555e6aea8 in virtio_net_get_features (vdev=0x55578cc770, features=1105849221095, errp=<optimized out>) at ../hw/net/virtio-net.c:807
> > #8  0x0000005555b69da4 in virtio_bus_device_plugged (vdev=vdev@entry=0x55578cc770, errp=errp@entry=0x7fffffe640) at ../hw/virtio/virtio-bus.c:66
> > #9  0x0000005555e8b6a0 in virtio_device_realize (dev=0x55578cc770, errp=0x7fffffe6c0) at ../hw/virtio/virtio.c:3609
> > #10 0x0000005555f1ead8 in device_set_realized (obj=0x55578cc770, value=<optimized out>, errp=0x7fffffe898) at ../hw/core/qdev.c:510
> > #11 0x0000005555f22a14 in property_set_bool (obj=0x55578cc770, v=<optimized out>, name=<optimized out>, opaque=0x5556be9ad0, errp=0x7fffffe898) at ../qom/object.c:2285
> > #12 0x0000005555f260fc in object_property_set (obj=obj@entry=0x55578cc770, name=name@entry=0x555621c280 "realized", v=v@entry=0x55578d9310, errp=errp@entry=0x7fffffe898)
> >    at ../qom/object.c:1420
> > #13 0x0000005555f2a85c in object_property_set_qobject
> >    (obj=obj@entry=0x55578cc770, name=name@entry=0x555621c280 "realized", value=value@entry=0x55578d9250, errp=errp@entry=0x7fffffe898) at ../qom/qom-qobject.c:28
> > #14 0x0000005555f26820 in object_property_set_bool (obj=0x55578cc770, name=0x555621c280 "realized", value=<optimized out>, errp=0x7fffffe898) at ../qom/object.c:1489
> > #15 0x0000005555aafd24 in pci_qdev_realize (qdev=<optimized out>, errp=<optimized out>) at ../hw/pci/pci.c:2116
> > #16 0x0000005555f1ead8 in device_set_realized (obj=0x55578c43a0, value=<optimized out>, errp=0x7fffffeae8) at ../hw/core/qdev.c:510
> > #17 0x0000005555f22a14 in property_set_bool (obj=0x55578c43a0, v=<optimized out>, name=<optimized out>, opaque=0x5556be9ad0, errp=0x7fffffeae8) at ../qom/object.c:2285
> > #18 0x0000005555f260fc in object_property_set (obj=obj@entry=0x55578c43a0, name=name@entry=0x555621c280 "realized", v=v@entry=0x55578d34c0, errp=errp@entry=0x7fffffeae8)
> >    at ../qom/object.c:1420
> > #19 0x0000005555f2a85c in object_property_set_qobject
> >    (obj=obj@entry=0x55578c43a0, name=name@entry=0x555621c280 "realized", value=value@entry=0x55578d3450, errp=errp@entry=0x7fffffeae8) at ../qom/qom-qobject.c:28
> > #20 0x0000005555f26820 in object_property_set_bool (obj=0x55578c43a0, name=0x555621c280 "realized", value=<optimized out>, errp=0x7fffffeae8) at ../qom/object.c:1489
> > #21 0x0000005555ba4f7c in qdev_device_add_from_qdict (opts=opts@entry=0x55578c3110, from_json=from_json@entry=false, errp=0x7fffffeae8, errp@entry=0x5556b24a28 <error_fatal>)
> >    at ../softmmu/qdev-monitor.c:714
> > #22 0x0000005555ba5170 in qdev_device_add (opts=0x5556be6060, errp=errp@entry=0x5556b24a28 <error_fatal>) at ../softmmu/qdev-monitor.c:733
> > #23 0x0000005555baa09c in device_init_func (opaque=<optimized out>, opts=<optimized out>, errp=0x5556b24a28 <error_fatal>) at ../softmmu/vl.c:1152
> > #24 0x00000055560b2124 in qemu_opts_foreach
> >    (list=<optimized out>, func=func@entry=0x5555baa080 <device_init_func>, opaque=opaque@entry=0x0, errp=errp@entry=0x5556b24a28 <error_fatal>) at ../util/qemu-option.c:1135
> > #25 0x0000005555bac88c in qemu_create_cli_devices () at ../softmmu/vl.c:2573
> > #26 qmp_x_exit_preconfig (errp=<optimized out>) at ../softmmu/vl.c:2641
> > #27 0x0000005555bafee4 in qmp_x_exit_preconfig (errp=<optimized out>) at ../softmmu/vl.c:2635
> > #28 qemu_init (argc=<optimized out>, argv=<optimized out>) at ../softmmu/vl.c:3648
> > #29 0x00000055558e839c in main (argc=<optimized out>, argv=<optimized out>) at ../softmmu/main.c:47
> > 
> >> What is the repro case?
> > 
> 
> I have been able to repro this even on x86, using the following command line:
> 
> ./qemu-system-x86_64 \
> -accel kvm \
> -machine pc-q35-8.0 \
> -m 8192 \
> -nodefaults \
> -boot strict=on \
> -nographic \
> -device virtio-net,netdev=net0,mac=C0:FF:EE:00:00:12,bus=pcie.0,addr=0x3 \
> -netdev tap,id=net0,helper=/usr/libexec/qemu-bridge-helper,br=virbr0,vhost=off \
> -monitor stdio \
> -qmp tcp:0:5555,server,nowait \
> -vnc :0
> 
> 
> > Nothing special :
> > 
> > qemu-system-aarch64 -M virt -accel kvm -cpu host -nographic -m 2G \
> > -drive if=pflash,format=raw,file=./EFI/efi.img,readonly=on \
> > -drive if=pflash,format=raw,file=fedora-varstore.img \
> > -device virtio-net,netdev=net0,mac=C0:FF:EE:00:00:12,bus=pcie.0,addr=0x3 \
> > -netdev tap,id=net0,helper=/usr/lib/qemu/qemu-bridge-helper,br=virbr0,vhost=off \
>                                                                        ^^^^^^^^^^^
> This is what is causing the crash. With vhost=off or without that option (and no vhostfd provided or forced) , within net_init_tap_one(), tap->vhost is False (when vhost=off) or tap->has_vhost is False (when no vhost option is provided). Thus vhost_net_init() will never be called since the following conditional evaluates to false :
> 
>     if (tap->has_vhost ? tap->vhost :
>         vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {
> 
> and s->vhost_net pointer will remain NULL.
> 
> The crash does not happen when passing vhost=on in the commandline.
> 
> Its sad we did not have a test for it and did not catch this scenario.
> 
> I will replace the assert() with a comment as to why the assert() is absent in tap network case.
>  
> > -drive file=fedora-arm64.qcow2,if=none,id=disk,format=qcow2,cache=none \
> > -device virtio-blk-device,drive=disk \
> > -serial mon:stdio
> > qemu-system-aarch64: ../hw/net/vhost_net.c:510: get_vhost_net: Assertion `vhost_net' failed.
> 

Thanks! Pls post quickly and I'll do a pull with just this fixup, so
people don't suffer from the regression.

-- 
MST


