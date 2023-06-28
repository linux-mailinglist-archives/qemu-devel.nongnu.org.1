Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A2740EE9
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:35:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qESUq-0002Iz-9q; Wed, 28 Jun 2023 06:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qESUn-0002If-QW
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qESUk-0001eu-Sp
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687948432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g8sbc0Ch0I9gK+3zGui+c/LLbrOXDSJebTfT0lbyEb8=;
 b=Q95/wGi8eRtAjUn5KhywLyGaMSd/f8SUmmDbOHnnf8ck8E5Gdm8BA2H1QyRTUHGxvpTo4Z
 4zgCwaHXUkR3C3AEDiLEeb4Kz2r+hbPkOANuXfww7oZgwF5G2Gb1CdE2TfevTMj4a4Ql9H
 VsppyFgp8lJfM5cxemhvYLG1pUA8T34=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-sGgbTcLaPqauqKp3_eGCFw-1; Wed, 28 Jun 2023 06:33:51 -0400
X-MC-Unique: sGgbTcLaPqauqKp3_eGCFw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-67e3c6c4624so925576b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 03:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687948430; x=1690540430;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g8sbc0Ch0I9gK+3zGui+c/LLbrOXDSJebTfT0lbyEb8=;
 b=V5saQiKgZFEktdgu3BQk6yQYgGHM7aGculumh+f58x28JvWA+HWL0cC02e+aBuMrEH
 Q2sXDF/msjA8O1i7Q+K4ptsNEskEebL8ErYC9PMb/AgHqDoLPdytZ7CxObsdjJzDF9Yb
 JUhIxJ2+D73fOpAGPDHxr5Qn14deiqY2gQzigbtDUVUSi3OXf+Nt2iEFNw/fOqmWRzN0
 sF33VBdsw8NbJN//9fhEf5jVPth0Y2yqvSRX1tqFFsxsqZqicURkfC3nVd77+THT+FJn
 YWDJsgr+tvH6draiy1oGLn+FDu7iQ8Fl2xzkQfo6vyM7MOxlOcEi5Ej+Gywt9I3rWzs/
 rfnw==
X-Gm-Message-State: AC+VfDwvvnnWHkEbiV6DLBRC5anMIFcspKNrbvDcXf5PUINfvbACxqPI
 V7xPNDR5Bj6uk23wWIc9Jm2JysVMcz9tGKZGcmPHhnYLn/EuHmrhWq3kJCww9+Bv00ue0+TXSHx
 JBiKvq1ObNgDZ4J4=
X-Received: by 2002:a05:6a00:1341:b0:681:89eb:9c9b with SMTP id
 k1-20020a056a00134100b0068189eb9c9bmr793418pfu.11.1687948430086; 
 Wed, 28 Jun 2023 03:33:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6g6iIQZrlf3+kQkeQxcxof8LL6/wPQSXZlfHvEk4QMgQNJtsAgxRX9Ze2l5fzgzOTu1mlWow==
X-Received: by 2002:a05:6a00:1341:b0:681:89eb:9c9b with SMTP id
 k1-20020a056a00134100b0068189eb9c9bmr793396pfu.11.1687948429705; 
 Wed, 28 Jun 2023 03:33:49 -0700 (PDT)
Received: from smtpclient.apple ([115.96.122.163])
 by smtp.gmail.com with ESMTPSA id
 v1-20020aa78501000000b0067db7c32419sm2540546pfn.15.2023.06.28.03.33.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 28 Jun 2023 03:33:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PULL 52/53] vhost_net: add an assertion for TAP client backends
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <21cf43f3-4db1-e2a0-8bfe-03228c5263f3@redhat.com>
Date: Wed, 28 Jun 2023 16:03:44 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Jason Wang <jasowang@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2704D32C-D09E-4324-A8CB-744F5E5B47CD@redhat.com>
References: <cover.1687782442.git.mst@redhat.com>
 <0af710813dcde638379e3bece8f9b1bde31af2f6.1687782442.git.mst@redhat.com>
 <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
 <A0C56F97-3830-4DF3-8BDD-D49611418056@redhat.com>
 <21cf43f3-4db1-e2a0-8bfe-03228c5263f3@redhat.com>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 28-Jun-2023, at 1:00 PM, C=C3=A9dric Le Goater <clg@redhat.com> =
wrote:
>=20
> On 6/28/23 08:45, Ani Sinha wrote:
>>> On 28-Jun-2023, at 11:58 AM, C=C3=A9dric Le Goater <clg@redhat.com> =
wrote:
>>>=20
>>> Hello,
>>>=20
>>> On 6/26/23 14:30, Michael S. Tsirkin wrote:
>>>> From: Ani Sinha <anisinha@redhat.com>
>>>> An assertion was missing for tap vhost backends that enforces a =
non-null
>>>> reference from get_vhost_net(). Both vhost-net-user and =
vhost-net-vdpa
>>>> enforces this. Enforce the same for tap. Unit tests pass with this =
change.
>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>> Message-Id: <20230619041501.111655-1-anisinha@redhat.com>
>>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>  hw/net/vhost_net.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
>>>> index c4eecc6f36..6db23ca323 100644
>>>> --- a/hw/net/vhost_net.c
>>>> +++ b/hw/net/vhost_net.c
>>>> @@ -507,6 +507,7 @@ VHostNetState *get_vhost_net(NetClientState =
*nc)
>>>>      switch (nc->info->type) {
>>>>      case NET_CLIENT_DRIVER_TAP:
>>>>          vhost_net =3D tap_get_vhost_net(nc);
>>>> +        assert(vhost_net);
>>>>          break;
>>>>  #ifdef CONFIG_VHOST_NET_USER
>>>>      case NET_CLIENT_DRIVER_VHOST_USER:
>>>=20
>>> A system of mine without vhost_net (old host kernel) is reaching =
this assert
>> We need to understand why this assertion is being hit. It could be a =
bug somewhere else.
>=20
> sure.
>=20
>> What is the backtrace?=20
>=20
>=20
> #0  __pthread_kill_implementation (threadid=3D549621125152, =
signo=3Dsigno@entry=3D6, no_tid=3Dno_tid@entry=3D0) at =
./nptl/pthread_kill.c:44
> #1  0x0000007ff71df254 in __pthread_kill_internal (signo=3D6, =
threadid=3D<optimized out>) at ./nptl/pthread_kill.c:78
> #2  0x0000007ff719a67c in __GI_raise (sig=3Dsig@entry=3D6) at =
../sysdeps/posix/raise.c:26
> #3  0x0000007ff7187130 in __GI_abort () at ./stdlib/abort.c:79
> #4  0x0000007ff7193fd0 in __assert_fail_base
>    (fmt=3D0x7ff72ad3f8 "%s%s%s:%u: %s%sAssertion `%s' failed.\n%n", =
assertion=3Dassertion@entry=3D0x5556208c00 "vhost_net", =
file=3Dfile@entry=3D0x5556208ae0 "../hw/net/vhost_net.c", =
line=3Dline@entry=3D510, function=3Dfunction@entry=3D0x5556208de8 =
<__PRETTY_FUNCTION__.2> "get_vhost_net") at ./assert/assert.c:92
> #5  0x0000007ff7194040 in __GI___assert_fail
>    (assertion=3Dassertion@entry=3D0x5556208c00 "vhost_net", =
file=3Dfile@entry=3D0x5556208ae0 "../hw/net/vhost_net.c", =
line=3Dline@entry=3D510, function=3Dfunction@entry=3D0x5556208de8 =
<__PRETTY_FUNCTION__.2> "get_vhost_net") at ./assert/assert.c:101
> #6  0x0000005555a767ac in get_vhost_net (nc=3D<optimized out>) at =
../hw/net/vhost_net.c:510
> #7  0x0000005555e6aea8 in virtio_net_get_features (vdev=3D0x55578cc770, =
features=3D1105849221095, errp=3D<optimized out>) at =
../hw/net/virtio-net.c:807
> #8  0x0000005555b69da4 in virtio_bus_device_plugged =
(vdev=3Dvdev@entry=3D0x55578cc770, errp=3Derrp@entry=3D0x7fffffe640) at =
../hw/virtio/virtio-bus.c:66
> #9  0x0000005555e8b6a0 in virtio_device_realize (dev=3D0x55578cc770, =
errp=3D0x7fffffe6c0) at ../hw/virtio/virtio.c:3609
> #10 0x0000005555f1ead8 in device_set_realized (obj=3D0x55578cc770, =
value=3D<optimized out>, errp=3D0x7fffffe898) at ../hw/core/qdev.c:510
> #11 0x0000005555f22a14 in property_set_bool (obj=3D0x55578cc770, =
v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x5556be9ad0, =
errp=3D0x7fffffe898) at ../qom/object.c:2285
> #12 0x0000005555f260fc in object_property_set =
(obj=3Dobj@entry=3D0x55578cc770, name=3Dname@entry=3D0x555621c280 =
"realized", v=3Dv@entry=3D0x55578d9310, errp=3Derrp@entry=3D0x7fffffe898)
>    at ../qom/object.c:1420
> #13 0x0000005555f2a85c in object_property_set_qobject
>    (obj=3Dobj@entry=3D0x55578cc770, name=3Dname@entry=3D0x555621c280 =
"realized", value=3Dvalue@entry=3D0x55578d9250, =
errp=3Derrp@entry=3D0x7fffffe898) at ../qom/qom-qobject.c:28
> #14 0x0000005555f26820 in object_property_set_bool (obj=3D0x55578cc770, =
name=3D0x555621c280 "realized", value=3D<optimized out>, =
errp=3D0x7fffffe898) at ../qom/object.c:1489
> #15 0x0000005555aafd24 in pci_qdev_realize (qdev=3D<optimized out>, =
errp=3D<optimized out>) at ../hw/pci/pci.c:2116
> #16 0x0000005555f1ead8 in device_set_realized (obj=3D0x55578c43a0, =
value=3D<optimized out>, errp=3D0x7fffffeae8) at ../hw/core/qdev.c:510
> #17 0x0000005555f22a14 in property_set_bool (obj=3D0x55578c43a0, =
v=3D<optimized out>, name=3D<optimized out>, opaque=3D0x5556be9ad0, =
errp=3D0x7fffffeae8) at ../qom/object.c:2285
> #18 0x0000005555f260fc in object_property_set =
(obj=3Dobj@entry=3D0x55578c43a0, name=3Dname@entry=3D0x555621c280 =
"realized", v=3Dv@entry=3D0x55578d34c0, errp=3Derrp@entry=3D0x7fffffeae8)
>    at ../qom/object.c:1420
> #19 0x0000005555f2a85c in object_property_set_qobject
>    (obj=3Dobj@entry=3D0x55578c43a0, name=3Dname@entry=3D0x555621c280 =
"realized", value=3Dvalue@entry=3D0x55578d3450, =
errp=3Derrp@entry=3D0x7fffffeae8) at ../qom/qom-qobject.c:28
> #20 0x0000005555f26820 in object_property_set_bool (obj=3D0x55578c43a0, =
name=3D0x555621c280 "realized", value=3D<optimized out>, =
errp=3D0x7fffffeae8) at ../qom/object.c:1489
> #21 0x0000005555ba4f7c in qdev_device_add_from_qdict =
(opts=3Dopts@entry=3D0x55578c3110, from_json=3Dfrom_json@entry=3Dfalse, =
errp=3D0x7fffffeae8, errp@entry=3D0x5556b24a28 <error_fatal>)
>    at ../softmmu/qdev-monitor.c:714
> #22 0x0000005555ba5170 in qdev_device_add (opts=3D0x5556be6060, =
errp=3Derrp@entry=3D0x5556b24a28 <error_fatal>) at =
../softmmu/qdev-monitor.c:733
> #23 0x0000005555baa09c in device_init_func (opaque=3D<optimized out>, =
opts=3D<optimized out>, errp=3D0x5556b24a28 <error_fatal>) at =
../softmmu/vl.c:1152
> #24 0x00000055560b2124 in qemu_opts_foreach
>    (list=3D<optimized out>, func=3Dfunc@entry=3D0x5555baa080 =
<device_init_func>, opaque=3Dopaque@entry=3D0x0, =
errp=3Derrp@entry=3D0x5556b24a28 <error_fatal>) at =
../util/qemu-option.c:1135
> #25 0x0000005555bac88c in qemu_create_cli_devices () at =
../softmmu/vl.c:2573
> #26 qmp_x_exit_preconfig (errp=3D<optimized out>) at =
../softmmu/vl.c:2641
> #27 0x0000005555bafee4 in qmp_x_exit_preconfig (errp=3D<optimized =
out>) at ../softmmu/vl.c:2635
> #28 qemu_init (argc=3D<optimized out>, argv=3D<optimized out>) at =
../softmmu/vl.c:3648
> #29 0x00000055558e839c in main (argc=3D<optimized out>, =
argv=3D<optimized out>) at ../softmmu/main.c:47
>=20
>> What is the repro case?
>=20

I have been able to repro this even on x86, using the following command =
line:

./qemu-system-x86_64 \
-accel kvm \
-machine pc-q35-8.0 \
-m 8192 \
-nodefaults \
-boot strict=3Don \
-nographic \
-device virtio-net,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:12,bus=3Dpcie.0,addr=
=3D0x3 \
-netdev =
tap,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3Dvirbr0,vhost=3D=
off \
-monitor stdio \
-qmp tcp:0:5555,server,nowait \
-vnc :0


> Nothing special :
>=20
> qemu-system-aarch64 -M virt -accel kvm -cpu host -nographic -m 2G \
> -drive if=3Dpflash,format=3Draw,file=3D./EFI/efi.img,readonly=3Don \
> -drive if=3Dpflash,format=3Draw,file=3Dfedora-varstore.img \
> -device =
virtio-net,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:12,bus=3Dpcie.0,addr=3D0x3 =
\
> -netdev =
tap,id=3Dnet0,helper=3D/usr/lib/qemu/qemu-bridge-helper,br=3Dvirbr0,vhost=3D=
off \
                                                                       =
^^^^^^^^^^^
This is what is causing the crash. With vhost=3Doff or without that =
option (and no vhostfd provided or forced) , within net_init_tap_one(), =
tap->vhost is False (when vhost=3Doff) or tap->has_vhost is False (when =
no vhost option is provided). Thus vhost_net_init() will never be called =
since the following conditional evaluates to false :

    if (tap->has_vhost ? tap->vhost :
        vhostfdname || (tap->has_vhostforce && tap->vhostforce)) {

and s->vhost_net pointer will remain NULL.

The crash does not happen when passing vhost=3Don in the commandline.

Its sad we did not have a test for it and did not catch this scenario.

I will replace the assert() with a comment as to why the assert() is =
absent in tap network case.
=20
> -drive file=3Dfedora-arm64.qcow2,if=3Dnone,id=3Ddisk,format=3Dqcow2,cach=
e=3Dnone \
> -device virtio-blk-device,drive=3Ddisk \
> -serial mon:stdio
> qemu-system-aarch64: ../hw/net/vhost_net.c:510: get_vhost_net: =
Assertion `vhost_net' failed.



