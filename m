Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2317A9F458A
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Dec 2024 08:54:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNSON-0003MZ-3S; Tue, 17 Dec 2024 02:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tNSOD-0003Lt-UV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 02:53:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1tNSO9-0006XB-O9
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 02:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734421982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ojT71UhXOoyxpKCoQBmtH/9wPtVlM4Fejzb4e4LHz0=;
 b=ARPVdLhMdy09Hf2epz21+GkP63VTHp454ufO+8U27Ce9H50K0lJVWGET6BmeVjMRJJkDZg
 NSuKBLaP/cBhUHcmBrDSyTwyl3zdPaSixuqcJrOHErb3YT33v+hqtWTV3nL5K8GXiLLS2d
 WBfG8b/Hxc8mEE8eLMEwx3mQw6iQ/a8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-QWPMJnTkOPedZmk8nOJtaA-1; Tue, 17 Dec 2024 02:51:18 -0500
X-MC-Unique: QWPMJnTkOPedZmk8nOJtaA-1
X-Mimecast-MFC-AGG-ID: QWPMJnTkOPedZmk8nOJtaA
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-6ef66fd6e78so60287697b3.0
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 23:51:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734421878; x=1735026678;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ojT71UhXOoyxpKCoQBmtH/9wPtVlM4Fejzb4e4LHz0=;
 b=mQ7aYpknm7ngWZyXWYDkmoc3Omh9M3+el73x/vvmsVUyoBrfqT/xIc7LG1NZDnnJM5
 WCAUFoy1jzXEqZxRRFWPhrEe/4UkE0M34Vw2o0+vpFA81NVhFkFeIhZri6vYZLdOvCAm
 O9fHZ5p4711N+T7MnuzekpfAvzSGKiW6KyVKtAJ4SlD1vuVz6YVzfzDeMftfG9sjtd1E
 FC6Tl53hSnKO4aCaqJdwnp/1/iC00p5DkgtWuFrEpXkMbRAjwSPbXG7PK1hlqL4eVWAk
 Ax0V9zty/R1ZBD5+QN62Mrgdru+O63wgdfyL6dkvV46J5V+59UkcVQeglh2fB17UwKqk
 Y5gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU2mWIeK4duPDir2Cw8px6mvMdKs6mwsPQ7LXMNHm/c5u08q6s8oPkjMZzMbqJef56Ca2Ac/jrRawv@nongnu.org
X-Gm-Message-State: AOJu0Yx/65hWnhU68jcGlHrf7ho12q8BJGU7z2A7fUUt1J9DP6Q7EFL/
 zc2EaF92AP9q+pA65hyuDwql3hj3iPH/C2wzHWI8xtxJFFhMLXsAOlTYpHvP4zyejfQ3/pswA7n
 frld4BElxy8xWRkRedLnC+B39QlWbPTG8vl7DMAJeff+AEuo6GbRTdfT5UZQYOv0qSWhvRLCqbr
 7MyiAYIpJZJXX4wSwn26dnuUlnHeE=
X-Gm-Gg: ASbGncvQEFSFzwLPkdpgGzHiLoZpb2i/9OObXaxjNr2aE/J0hDHNpUVTXaOK+vwW7nz
 ZuHmbPE0huWivKxB0flHnkutMlDltu3o9s3PHFw==
X-Received: by 2002:a05:690c:83:b0:6ea:1230:2467 with SMTP id
 00721157ae682-6f2bb9c31cfmr19962857b3.2.1734421877994; 
 Mon, 16 Dec 2024 23:51:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEidNHdEsMvrlRVZTJI1J0hXaSNFer6hTqahzrSw4L87MRLNRY1CzNrKjq6tdQ1StGy26eoZ9UB0+afSjZUCx4=
X-Received: by 2002:a05:690c:83:b0:6ea:1230:2467 with SMTP id
 00721157ae682-6f2bb9c31cfmr19962777b3.2.1734421877551; Mon, 16 Dec 2024
 23:51:17 -0800 (PST)
MIME-Version: 1.0
References: <20241205203430.76251-1-sahilcdq@proton.me>
 <CAJaqyWerdWk5S0Sxt4oMUCc8FQJTxopyvhtyOV6ocbXmJ_p7Dw@mail.gmail.com>
 <f95a9e51-6aa1-4aeb-959e-99e9b31109be@gmail.com>
 <CAJaqyWdx6GGrQ8-Pm9k9jE11djdk3B1OHda+uGTQqYbq5tyX7w@mail.gmail.com>
 <d747027b-4c59-4f01-bb36-b9a00aa7d3a9@gmail.com>
In-Reply-To: <d747027b-4c59-4f01-bb36-b9a00aa7d3a9@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 17 Dec 2024 08:50:41 +0100
Message-ID: <CAJaqyWeKW3VVATqdWMrRUxCZxsrCUur7uwiyDqk2Y2W1wqZusQ@mail.gmail.com>
Subject: Re: [RFC v4 0/5] Add packed virtqueue to shadow virtqueue
To: Sahil Siddiq <icegambit91@gmail.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 Sahil Siddiq <sahilcdq@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Dec 17, 2024 at 6:45=E2=80=AFAM Sahil Siddiq <icegambit91@gmail.com=
> wrote:
>
> Hi,
>
> Thank you for your reply.
>
> On 12/16/24 2:09 PM, Eugenio Perez Martin wrote:
> > On Sun, Dec 15, 2024 at 6:27=E2=80=AFPM Sahil Siddiq <icegambit91@gmail=
.com> wrote:
> >> On 12/10/24 2:57 PM, Eugenio Perez Martin wrote:
> >>> On Thu, Dec 5, 2024 at 9:34=E2=80=AFPM Sahil Siddiq <icegambit91@gmai=
l.com> wrote:
> >>>> [...]
> >>>> I have been following the "Hands on vDPA: what do you do
> >>>> when you ain't got the hardware v2 (Part 2)" [1] blog to
> >>>> test my changes. To boot the L1 VM, I ran:
> >>>>
> >>>> sudo ./qemu/build/qemu-system-x86_64 \
> >>>> -enable-kvm \
> >>>> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=
=3Ddisk,if=3Dvirtio \
> >>>> -net nic,model=3Dvirtio \
> >>>> -net user,hostfwd=3Dtcp::2222-:22 \
> >>>> -device intel-iommu,snoop-control=3Don \
> >>>> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-mod=
ern=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3D=
off,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Don,event_idx=3D=
off,bus=3Dpcie.0,addr=3D0x4 \
> >>>> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >>>> -nographic \
> >>>> -m 8G \
> >>>> -smp 4 \
> >>>> -M q35 \
> >>>> -cpu host 2>&1 | tee vm.log
> >>>>
> >>>> Without "guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,
> >>>> guest_announce=3Doff" in "-device virtio-net-pci", QEMU
> >>>> throws "vdpa svq does not work with features" [2] when
> >>>> trying to boot L2.
> >>>>
> >>>> The enums added in commit #2 in this series is new and
> >>>> wasn't in the earlier versions of the series. Without
> >>>> this change, x-svq=3Dtrue throws "SVQ invalid device feature
> >>>> flags" [3] and x-svq is consequently disabled.
> >>>>
> >>>> The first issue is related to running traffic in L2
> >>>> with vhost-vdpa.
> >>>>
> >>>> In L0:
> >>>>
> >>>> $ ip addr add 111.1.1.1/24 dev tap0
> >>>> $ ip link set tap0 up
> >>>> $ ip addr show tap0
> >>>> 4: tap0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel s=
tate UNKNOWN group default qlen 1000
> >>>>       link/ether d2:6d:b9:61:e1:9a brd ff:ff:ff:ff:ff:ff
> >>>>       inet 111.1.1.1/24 scope global tap0
> >>>>          valid_lft forever preferred_lft forever
> >>>>       inet6 fe80::d06d:b9ff:fe61:e19a/64 scope link proto kernel_ll
> >>>>          valid_lft forever preferred_lft forever
> >>>>
> >>>> I am able to run traffic in L2 when booting without
> >>>> x-svq.
> >>>>
> >>>> In L1:
> >>>>
> >>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>> -nographic \
> >>>> -m 4G \
> >>>> -enable-kvm \
> >>>> -M q35 \
> >>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vd=
pa0 \
> >>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disa=
ble-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,add=
r=3D0x7 \
> >>>> -smp 4 \
> >>>> -cpu host \
> >>>> 2>&1 | tee vm.log
> >>>>
> >>>> In L2:
> >>>>
> >>>> # ip addr add 111.1.1.2/24 dev eth0
> >>>> # ip addr show eth0
> >>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel s=
tate UP group default qlen 1000
> >>>>       link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>>>       altname enp0s7
> >>>>       inet 111.1.1.2/24 scope global eth0
> >>>>          valid_lft forever preferred_lft forever
> >>>>       inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
> >>>>          valid_lft forever preferred_lft forever
> >>>>
> >>>> # ip route
> >>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>>>
> >>>> # ping 111.1.1.1 -w3
> >>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>>> 64 bytes from 111.1.1.1: icmp_seq=3D1 ttl=3D64 time=3D0.407 ms
> >>>> 64 bytes from 111.1.1.1: icmp_seq=3D2 ttl=3D64 time=3D0.671 ms
> >>>> 64 bytes from 111.1.1.1: icmp_seq=3D3 ttl=3D64 time=3D0.291 ms
> >>>>
> >>>> --- 111.1.1.1 ping statistics ---
> >>>> 3 packets transmitted, 3 received, 0% packet loss, time 2034ms
> >>>> rtt min/avg/max/mdev =3D 0.291/0.456/0.671/0.159 ms
> >>>>
> >>>>
> >>>> But if I boot L2 with x-svq=3Dtrue as shown below, I am unable
> >>>> to ping the host machine.
> >>>>
> >>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>> -nographic \
> >>>> -m 4G \
> >>>> -enable-kvm \
> >>>> -M q35 \
> >>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtrue,=
id=3Dvhost-vdpa0 \
> >>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disa=
ble-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,add=
r=3D0x7 \
> >>>> -smp 4 \
> >>>> -cpu host \
> >>>> 2>&1 | tee vm.log
> >>>>
> >>>> In L2:
> >>>>
> >>>> # ip addr add 111.1.1.2/24 dev eth0
> >>>> # ip addr show eth0
> >>>> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel s=
tate UP group default qlen 1000
> >>>>       link/ether 52:54:00:12:34:57 brd ff:ff:ff:ff:ff:ff
> >>>>       altname enp0s7
> >>>>       inet 111.1.1.2/24 scope global eth0
> >>>>          valid_lft forever preferred_lft forever
> >>>>       inet6 fe80::9877:de30:5f17:35f9/64 scope link noprefixroute
> >>>>          valid_lft forever preferred_lft forever
> >>>>
> >>>> # ip route
> >>>> 111.1.1.0/24 dev eth0 proto kernel scope link src 111.1.1.2
> >>>>
> >>>> # ping 111.1.1.1 -w10
> >>>> PING 111.1.1.1 (111.1.1.1) 56(84) bytes of data.
> >>>>   From 111.1.1.2 icmp_seq=3D1 Destination Host Unreachable
> >>>> ping: sendmsg: No route to host
> >>>>   From 111.1.1.2 icmp_seq=3D2 Destination Host Unreachable
> >>>>   From 111.1.1.2 icmp_seq=3D3 Destination Host Unreachable
> >>>>
> >>>> --- 111.1.1.1 ping statistics ---
> >>>> 3 packets transmitted, 0 received, +3 errors, 100% packet loss, time=
 2076ms
> >>>> pipe 3
> >>>>
> >>>> The other issue is related to booting L2 with "x-svq=3Dtrue"
> >>>> and "packed=3Don".
> >>>>
> >>>> In L1:
> >>>>
> >>>> $ ./qemu/build/qemu-system-x86_64 \
> >>>> -nographic \
> >>>> -m 4G \
> >>>> -enable-kvm \
> >>>> -M q35 \
> >>>> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >>>> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,id=3Dvhost-vd=
pa0,x-svq=3Dtrue \
> >>>> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disa=
ble-modern=3Doff,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Doff,guest_ann=
ounce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,packed=3Don,bus=3Dpci=
e.0,addr=3D0x7 \
> >>>> -smp 4 \
> >>>> -cpu host \
> >>>> 2>&1 | tee vm.log
> >>>>
> >>>> The kernel throws "virtio_net virtio1: output.0:id 0 is not
> >>>> a head!" [4].
> >>>>
> >>>
> >>> So this series implements the descriptor forwarding from the guest to
> >>> the device in packed vq. We also need to forward the descriptors from
> >>> the device to the guest. The device writes them in the SVQ ring.
> >>>
> >>> The functions responsible for that in QEMU are
> >>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_flush, which is called b=
y
> >>> the device when used descriptors are written to the SVQ, which calls
> >>> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf. We need to do
> >>> modifications similar to vhost_svq_add: Make them conditional if we'r=
e
> >>> in split or packed vq, and "copy" the code from Linux's
> >>> drivers/virtio/virtio_ring.c:virtqueue_get_buf.
> >>>
> >>> After these modifications you should be able to ping and forward
> >>> traffic. As always, It is totally ok if it needs more than one
> >>> iteration, and feel free to ask any question you have :).
> >>>
> >>
> >> I misunderstood this part. While working on extending
> >> hw/virtio/vhost-shadow-virtqueue.c:vhost_svq_get_buf() [1]
> >> for packed vqs, I realized that this function and
> >> vhost_svq_flush() already support split vqs. However, I am
> >> unable to ping L0 when booting L2 with "x-svq=3Dtrue" and
> >> "packed=3Doff" or when the "packed" option is not specified
> >> in QEMU's command line.
> >>
> >> I tried debugging these functions for split vqs after running
> >> the following QEMU commands while following the blog [2].
> >>
> >> Booting L1:
> >>
> >> $ sudo ./qemu/build/qemu-system-x86_64 \
> >> -enable-kvm \
> >> -drive file=3D//home/valdaarhun/valdaarhun/qcow2_img/L1.qcow2,media=3D=
disk,if=3Dvirtio \
> >> -net nic,model=3Dvirtio \
> >> -net user,hostfwd=3Dtcp::2222-:22 \
> >> -device intel-iommu,snoop-control=3Don \
> >> -device virtio-net-pci,netdev=3Dnet0,disable-legacy=3Don,disable-moder=
n=3Doff,iommu_platform=3Don,guest_uso4=3Doff,guest_uso6=3Doff,host_uso=3Dof=
f,guest_announce=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,packed=3Doff,event_idx=3Do=
ff,bus=3Dpcie.0,addr=3D0x4 \
> >> -netdev tap,id=3Dnet0,script=3Dno,downscript=3Dno \
> >> -nographic \
> >> -m 8G \
> >> -smp 4 \
> >> -M q35 \
> >> -cpu host 2>&1 | tee vm.log
> >>
> >> Booting L2:
> >>
> >> # ./qemu/build/qemu-system-x86_64 \
> >> -nographic \
> >> -m 4G \
> >> -enable-kvm \
> >> -M q35 \
> >> -drive file=3D//root/L2.qcow2,media=3Ddisk,if=3Dvirtio \
> >> -netdev type=3Dvhost-vdpa,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Dtrue,id=
=3Dvhost-vdpa0 \
> >> -device virtio-net-pci,netdev=3Dvhost-vdpa0,disable-legacy=3Don,disabl=
e-modern=3Doff,ctrl_vq=3Don,ctrl_rx=3Don,event_idx=3Doff,bus=3Dpcie.0,addr=
=3D0x7 \
> >> -smp 4 \
> >> -cpu host \
> >> 2>&1 | tee vm.log
> >>
> >> I printed out the contents of VirtQueueElement returned
> >> by vhost_svq_get_buf() in vhost_svq_flush() [3].
> >> I noticed that "len" which is set by "vhost_svq_get_buf"
> >> is always set to 0 while VirtQueueElement.len is non-zero.
> >> I haven't understood the difference between these two "len"s.
> >>
> >
> > VirtQueueElement.len is the length of the buffer, while the len of
> > vhost_svq_get_buf is the bytes written by the device. In the case of
> > the tx queue, VirtQueuelen is the length of the tx packet, and the
> > vhost_svq_get_buf is always 0 as the device does not write. In the
> > case of rx, VirtQueueElem.len is the available length for a rx frame,
> > and the vhost_svq_get_buf len is the actual length written by the
> > device.
> >
> > To be 100% accurate a rx packet can span over multiple buffers, but
> > SVQ does not need special code to handle this.
> >
> > So vhost_svq_get_buf should return > 0 for rx queue (svq->vq->index =3D=
=3D
> > 0), and 0 for tx queue (svq->vq->index % 2 =3D=3D 1).
> >
> > Take into account that vhost_svq_get_buf only handles split vq at the
> > moment! It should be renamed or splitted into vhost_svq_get_buf_split.
>
> In L1, there are 2 virtio network devices.
>
> # lspci -nn | grep -i net
> 00:02.0 Ethernet controller [0200]: Red Hat, Inc. Virtio network device [=
1af4:1000]
> 00:04.0 Ethernet controller [0200]: Red Hat, Inc. Virtio 1.0 network devi=
ce [1af4:1041] (rev 01)
>
> I am using the second one (1af4:1041) for testing my changes and have
> bound this device to the vp_vdpa driver.
>
> # vdpa dev show -jp
> {
>      "dev": {
>          "vdpa0": {
>              "type": "network",
>              "mgmtdev": "pci/0000:00:04.0",
>              "vendor_id": 6900,
>              "max_vqs": 3,

How is max_vqs=3D3? For this to happen L0 QEMU should have
virtio-net-pci,...,queues=3D3 cmdline argument. It's clear the guest is
not using them, we can add mq=3Doff to simplify the scenario.

>              "max_vq_size": 256
>          }
>      }
> }
>
> The max number of vqs is 3 with the max size being 256.
>
> Since, there are 2 virtio net devices, vhost_vdpa_svqs_start [1]
> is called twice. For each of them. it calls vhost_svq_start [2]
> v->shadow_vqs->len number of times.
>

Ok I understand this confusion, as the code is not intuitive :). Take
into account you can only have svq in vdpa devices, so both
vhost_vdpa_svqs_start are acting on the vdpa device.

You are seeing two calls to vhost_vdpa_svqs_start because virtio (and
vdpa) devices are modelled internally as two devices in QEMU: One for
the dataplane vq, and other for the control vq. There are historical
reasons for this, but we use it in vdpa to always shadow the CVQ while
leaving dataplane passthrough if x-svq=3Doff and the virtio & virtio-net
feature set is understood by SVQ.

If you break at vhost_vdpa_svqs_start with gdb and go higher in the
stack you should reach vhost_net_start, that starts each vhost_net
device individually.

To be 100% honest, each dataplain *queue pair* (rx+tx) is modelled
with a different vhost_net device in QEMU, but you don't need to take
that into account implementing the packed vq :).

> Printing the values of dev->vdev->name, v->shadow_vqs->len and
> svq->vring.num in vhost_vdpa_svqs_start gives:
>
> name: virtio-net
> len: 2
> num: 256
> num: 256

First QEMU's vhost_net device, the dataplane.

> name: virtio-net
> len: 1
> num: 64
>

Second QEMU's vhost_net device, the control virtqueue.

> I am not sure how to match the above log lines to the
> right virtio-net device since the actual value of num
> can be less than "max_vq_size" in the output of "vdpa
> dev show".
>

Yes, the device can set a different vq max per vq, and the driver can
negotiate a lower vq size per vq too.

> I think the first 3 log lines correspond to the virtio
> net device that I am using for testing since it has
> 2 vqs (rx and tx) while the other virtio-net device
> only has one vq.
>
> When printing out the values of svq->vring.num,
> used_elem.len and used_elem.id in vhost_svq_get_buf,
> there are two sets of output. One set corresponds to
> svq->vring.num =3D 64 and the other corresponds to
> svq->vring.num =3D 256.
>
> For svq->vring.num =3D 64, only the following line
> is printed repeatedly:
>
> size: 64, len: 1, i: 0
>

This is with packed=3Doff, right? If this is testing with packed, you
need to change the code to accommodate it. Let me know if you need
more help with this.

In the CVQ the only reply is a byte, indicating if the command was
applied or not. This seems ok to me.

The queue can also recycle ids as long as they are not available, so
that part seems correct to me too.

> For svq->vring.num =3D 256, the following line is
> printed 20 times,
>
> size: 256, len: 0, i: 0
>
> followed by:
>
> size: 256, len: 0, i: 1
> size: 256, len: 0, i: 1
>

This makes sense for the tx queue too. Can you print the VirtQueue index?

> used_elem.len is used to set the value of len that is
> returned by vhost_svq_get_buf, and it's always 0.
>
> So the value of "len" returned by vhost_svq_get_buf
> when called in vhost_svq_flush is also 0.
>
> Thanks,
> Sahil
>
> [1] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vd=
pa.c#L1243
> [2] https://gitlab.com/qemu-project/qemu/-/blob/master/hw/virtio/vhost-vd=
pa.c#L1265
>


