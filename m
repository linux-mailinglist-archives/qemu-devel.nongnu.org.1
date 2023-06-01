Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B8F7190B1
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 04:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4YMb-0006ly-IH; Wed, 31 May 2023 22:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4YMY-0006lc-Vd
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4YMW-0005ym-5M
 for qemu-devel@nongnu.org; Wed, 31 May 2023 22:48:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685587706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7I8e8nwFfquRhV9qYkigVtYY7kRKK9n7H+XSrOZGB34=;
 b=VNwkhYDINBf+uB3VMaaQefo9zYxlleqY26I5hVKNzITavsU1qFgTAmzj6hO5RPfzVRsbFs
 0zk2u10Z/gY4R8xYu9j2K0CqaYNCWhUzHl2QYdOztkFxtu66uTDIRq0Ae+tb9r/uO085Cq
 wa9m2sJuMSFHCOPJUUVRIcSDOlpn8d0=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-rvzSL2f1PSySm-Q_PWY5ZA-1; Wed, 31 May 2023 22:48:25 -0400
X-MC-Unique: rvzSL2f1PSySm-Q_PWY5ZA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af2ffb4e5aso2543931fa.1
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 19:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685587703; x=1688179703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7I8e8nwFfquRhV9qYkigVtYY7kRKK9n7H+XSrOZGB34=;
 b=e+p5XRZDrLInocnsLYaV+4ksV0keiM7QC2z1XbJOaLF72HDxBDA/9lUNxz3hOZ4TCk
 lr/cZ1CqC8BeI9xwOWcBK4/eLoNy5AaEe8pkyGVyUjn5WzjBYzxBDTWqgbBwRKOBPv3Q
 nPuQom9a6bbNOafts79VQWDY/4hf+YXjK4vYokxOO81bqezCJPJDq4unfsw5bqoVjIf2
 7uL37j+20MNFDR3aleG4m3owSFQ/VEIlvQBax3PnPPefFeQ/EQMVCjFncN+62drstcIP
 jZ1uj75AezHtoFfusG9KQembogyBrBBmFT7RyHBhUSskz06NaUL0mIBweib1E6DhMVET
 ij3g==
X-Gm-Message-State: AC+VfDyd/0oMceVLIriYPFGfdZwbkCAU3AN0AxfbN5uFADJ9Wx5OojaY
 NhIHsgpu88SJpg9DPr/z03368KrsbKt+bHm9ZovEfPjumA7D6oJdpczrFtWsATj9pysB1XZ9Vb9
 +ICuLwWt5ht+jEAC9W041NWU7BP+Jf8g=
X-Received: by 2002:a2e:9a8e:0:b0:2b0:5f62:8b8 with SMTP id
 p14-20020a2e9a8e000000b002b05f6208b8mr3719436lji.42.1685587703594; 
 Wed, 31 May 2023 19:48:23 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ73kCkeYxpkcMv8kp/InFPnCjC+kUQjE5K+MhI6P0NrXDuDkAlMcyonKMV60xfkOnSaTQXy/f2b+QfUsbuPEq0=
X-Received: by 2002:a2e:9a8e:0:b0:2b0:5f62:8b8 with SMTP id
 p14-20020a2e9a8e000000b002b05f6208b8mr3719433lji.42.1685587703178; Wed, 31
 May 2023 19:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230531031645.44335-1-jon@nutanix.com>
 <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
 <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
 <42F3C35E-EB0C-4AA9-8863-618E60792842@nutanix.com>
 <CACGkMEu51T2JHF+mGM5xfgmA5N=oSTZgCtRy1JG0c6yDxcVDtQ@mail.gmail.com>
 <CACGkMEtXtdqrOeS1QZvBtVC3_FOi9s=_28uTDtR=nLKFrTvoXQ@mail.gmail.com>
 <94C45D0D-3ED9-442D-B35E-03B1023C0346@nutanix.com>
In-Reply-To: <94C45D0D-3ED9-442D-B35E-03B1023C0346@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 1 Jun 2023 10:48:12 +0800
Message-ID: <CACGkMEtL+1j9WoiV2aeKyohBtY+9hfuu=udVXPCgUkGaRY5AFg@mail.gmail.com>
Subject: Re: [PATCH] tap: introduce IFF_NAPI
To: Jon Kohler <jon@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 9:46=E2=80=AFPM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On May 31, 2023, at 1:27 AM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, May 31, 2023 at 11:55=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>
> >> On Wed, May 31, 2023 at 11:47=E2=80=AFAM Jon Kohler <jon@nutanix.com> =
wrote:
> >>>
> >>>
> >>>
> >>>> On May 30, 2023, at 11:35 PM, Jason Wang <jasowang@redhat.com> wrote=
:
> >>>>
> >>>> On Wed, May 31, 2023 at 11:32=E2=80=AFAM Jason Wang <jasowang@redhat=
.com> wrote:
> >>>>>
> >>>>> On Wed, May 31, 2023 at 11:17=E2=80=AFAM Jon Kohler <jon@nutanix.co=
m> wrote:
> >>>>>>
> >>>>>> If kernel supports IFF_NAPI, lets use it, which is especially usef=
ul
> >>>>>> on kernels containing fb3f903769e8 ("tun: support NAPI for packets
> >>>>>> received from batched XDP buffs"), as IFF_NAPI allows the
> >>>>>> vhost_tx_batch path to use NAPI on XDP buffs.
> >>>>>>
> >>>>>> Benchmark w/ iperf -c (remote srv) -P (thread count) -l (stream si=
ze)
> >>>>>> from a guest running kernel 5.10.105 to remote bare metal running
> >>>>>> patched code on kernel 5.10.139. Guests were configured 1x virtio-=
net
> >>>>>> device with 4x queues, resulting in 4x vhost-worker threads. Hosts=
 are
> >>>>>> identical with Intel ICX 4314 @ 2.4 GHz with Mellanox CX5 25GbE NI=
C ->
> >>>>>> Arista 25GbE switch. vhost-worker threads largely maxed out on CPU=
 on
> >>>>>> "Before" and around ~50-60% utilization "After".
> >>>>>>
> >>>>>> Single Stream: iperf -P 1
> >>>>>> iperf -l size | Before          | After          | Increase
> >>>>>> 64B           | 593 Mbits/sec   | 712 Mbits/sec  | ~20%
> >>>>>> 128B          | 1.00 Gbits/sec  | 1.18 Gbits/sec | ~18%
> >>>>>> 4KB           | 17.6 Gbits/sec  | 22.7 Gbits/sec | ~29%
> >>>>>>
> >>>>>> Multiple Stream: iperf -P 12
> >>>>>> iperf -l size | Before          | After          | Increase
> >>>>>> 64B           | 6.35 Gbits/sec  | 7.78 Gbits/sec | ~23%
> >>>>>> 128B          | 10.8 Gbits/sec  | 14.2 Gbits/sec | ~31%
> >>>>>> 4KB           | 23.6 Gbits/sec  | 23.6 Gbits/sec | (line speed)
> >>>>>>
> >>>>>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>>>>
> >>>>> Great, but I would suggest having an option.
> >>>>>
> >>>>> So we can:
> >>>>>
> >>>>> 1) ease the debug and compare
> >>>>> 2) enable this by default only for 8.1, disable it for pre 8.1
> >>>
> >>> Fair enough, one favor to ask though -
> >>> Would you be able to point me to an existing option like what you=E2=
=80=99re
> >>> proposing so I could make sure I=E2=80=99m on the same page?
> >>
> >> For example, the vhost option for tap. Maybe we can have an napi optio=
n.
>
> OK thanks, I=E2=80=99ll see what I can do there.
>
> >>
> >>>
> >>>>
> >>>> More thought, if the performance boost only after fb3f903769e8, we
> >>>> probably need to disable it by default and let the mgmt layer to
> >>>> enable it.
> >>>>
> >>>
> >>> I focused my testing with that commit, but I could take it out and
> >>> we still should get benefit. Would you like me to profile that to val=
idate?
> >>>
> >>
> >> One problem is that NAPI for TAP was originally used for kernel
> >> hardening. Looking at the history, it introduces a lot of bugs.
> >>
> >> Consider:
> >>
> >> 1) it has been merged for several years
> >> 2) tap has been widely used for a long time as well
> >>
> >> I think it would be still safe to keep the option off (at least for
> >> pre 8.1 machines).
> >>
> >>> Asking as NAPI support in tun.c has been there for a while, guessing
> >>> at first glance that there would be non-zero gains, with little downs=
ides.
> >>> Looking at git blame, seems about ~5-6 years of support.
> >>
> >> Yes.
> >>
> >>>
> >>> Also for posterity, that commit has been in since 5.18, so a little o=
ver 1 year.
> >>
> >> Then I think we can make it enabled by default for 8.1 and see.
>
> OK, I=E2=80=99ll see what I can come up with.
>
> >
> > Btw, it would be better if we can have some PPS benchmark as well.
> >
> > Thanks
>
> Is there a set of specific benchmark(s) that you want to see? Certain pac=
ket
> sizes? TCP/UDP? Certain tool (netperf, iperf, etc)?

It could be like this:

1) Netperf TCP_STREAM with various packet size 64 to maximum
2) Pktgen test from guest to host

> The existing benchmarks
> in the commit msg have both single and multi stream and multiple payload
> sizes, all of which are a corollary to PPS, no?

The problem is that it's the PPS of the TCP, various layers in the
middle. For example, if TCP coalesce usersapce write to larger
packets, we will end up with a low PPS.

Using pktgen may help to know if TAP can deal with more packets per second.

Thanks

>
> Happy to do more profiling, just want to make sure I get you exactly what=
 you
> want.
>
> >
> >>
> >> Thanks
> >>
> >>>
> >>>> Thanks
> >>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>>> ---
> >>>>>> net/tap-linux.c | 4 ++++
> >>>>>> net/tap-linux.h | 1 +
> >>>>>> 2 files changed, 5 insertions(+)
> >>>>>>
> >>>>>> diff --git a/net/tap-linux.c b/net/tap-linux.c
> >>>>>> index f54f308d359..fd94df166e0 100644
> >>>>>> --- a/net/tap-linux.c
> >>>>>> +++ b/net/tap-linux.c
> >>>>>> @@ -62,6 +62,10 @@ int tap_open(char *ifname, int ifname_size, int=
 *vnet_hdr,
> >>>>>>        ifr.ifr_flags |=3D IFF_ONE_QUEUE;
> >>>>>>    }
> >>>>>>
> >>>>>> +    if (features & IFF_NAPI) {
> >>>>>> +        ifr.ifr_flags |=3D IFF_NAPI;
> >>>>>> +    }
> >>>>>> +
> >>>>>>    if (*vnet_hdr) {
> >>>>>>        if (features & IFF_VNET_HDR) {
> >>>>>>            *vnet_hdr =3D 1;
> >>>>>> diff --git a/net/tap-linux.h b/net/tap-linux.h
> >>>>>> index bbbb62c2a75..f4d8e55270b 100644
> >>>>>> --- a/net/tap-linux.h
> >>>>>> +++ b/net/tap-linux.h
> >>>>>> @@ -37,6 +37,7 @@
> >>>>>>
> >>>>>> /* TUNSETIFF ifr flags */
> >>>>>> #define IFF_TAP          0x0002
> >>>>>> +#define IFF_NAPI         0x0010
> >>>>>> #define IFF_NO_PI        0x1000
> >>>>>> #define IFF_ONE_QUEUE    0x2000
> >>>>>> #define IFF_VNET_HDR     0x4000
> >>>>>> --
> >>>>>> 2.30.1 (Apple Git-130)
> >>>
> >
>


