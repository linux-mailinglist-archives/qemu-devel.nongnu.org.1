Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD35717628
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:28:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ENI-0001Aa-4j; Wed, 31 May 2023 01:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4ENF-0001AD-IG
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4END-00068n-Hw
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685510870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gFWDM3yP4Dl7NBtZnADndOMj3Ppw/+lHGLeEQWwRCmw=;
 b=DvPZ623HHTBerp7EFtbuoUqPFXK5mUXCSkMZVCtQC5K1FQI30aUQMTN+zXK7dfYsltX1fd
 c8Flx4cKmfe2J5K/khHzHVsxipiYWEQQ0KPSfo1fpOAHr2bzqzDPdd+Ltk6tl17+xQY1Je
 Z8wYwCkmRk9WniOvLlnJZf9RVfLdZiE=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-JQ4FwxexOQurPGDPqwHEkw-1; Wed, 31 May 2023 01:27:48 -0400
X-MC-Unique: JQ4FwxexOQurPGDPqwHEkw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b02539087aso25984581fa.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685510867; x=1688102867;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFWDM3yP4Dl7NBtZnADndOMj3Ppw/+lHGLeEQWwRCmw=;
 b=H2bE3a0D6fOQpc7VWZG1CGh3WPQCnOsrE8GRGYIelDEaKGMj8SHuVRcOCkPYbXOZkA
 FuIzCrhr/2k2GQSF1U3HGezDbRhB8s0IXAPuaObrXp/GW7eYuWpsd2m7hWxyDs5qr7jZ
 eRrb5WcHNJKMm5gsYw3kKQaBIKsZmEAnD8Cezta1KM0obQq/ViGipO8NjilEhTYZWi5n
 9inR680VyjliGaz62ZIRq5BMg4CJO5VhIPsLoedmfxasvgTWVOJIG0iijZXBYvERvAE4
 xVxLd0G2AnMqA0C4GIGTVrsSTO9IfcKhFCEiK1gE8QuiGtnG8MaQ8NuMwVXMcpJotzmg
 6EEQ==
X-Gm-Message-State: AC+VfDwSWgbvSeyRHPBTeTs1MEierQgBQj1+fjU0LV7Iz1reGkS0/6AN
 M98FKsoZkC+3bcAIr/0mQsurgtdvYI0FLVhQjDYiX+YmrAFodj+s+vkHi8E+2TW8fpub/IeeLs9
 apmQmChqzvPdMIVee+ouj/UDgx+wR/fQ=
X-Received: by 2002:a2e:9cd8:0:b0:2a8:ac69:bfe with SMTP id
 g24-20020a2e9cd8000000b002a8ac690bfemr1993151ljj.42.1685510867284; 
 Tue, 30 May 2023 22:27:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5p1ePNAbvNBMiYX6bfMZpmVTTyo7I79rY60lLGduTc0OEvfJimgDyyUoPvrRKQYTAn++xmN6xYDmj/1fEz1cU=
X-Received: by 2002:a2e:9cd8:0:b0:2a8:ac69:bfe with SMTP id
 g24-20020a2e9cd8000000b002a8ac690bfemr1993143ljj.42.1685510866885; Tue, 30
 May 2023 22:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230531031645.44335-1-jon@nutanix.com>
 <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
 <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
 <42F3C35E-EB0C-4AA9-8863-618E60792842@nutanix.com>
 <CACGkMEu51T2JHF+mGM5xfgmA5N=oSTZgCtRy1JG0c6yDxcVDtQ@mail.gmail.com>
In-Reply-To: <CACGkMEu51T2JHF+mGM5xfgmA5N=oSTZgCtRy1JG0c6yDxcVDtQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 13:27:35 +0800
Message-ID: <CACGkMEtXtdqrOeS1QZvBtVC3_FOi9s=_28uTDtR=nLKFrTvoXQ@mail.gmail.com>
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
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Wed, May 31, 2023 at 11:55=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, May 31, 2023 at 11:47=E2=80=AFAM Jon Kohler <jon@nutanix.com> wro=
te:
> >
> >
> >
> > > On May 30, 2023, at 11:35 PM, Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Wed, May 31, 2023 at 11:32=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > >>
> > >> On Wed, May 31, 2023 at 11:17=E2=80=AFAM Jon Kohler <jon@nutanix.com=
> wrote:
> > >>>
> > >>> If kernel supports IFF_NAPI, lets use it, which is especially usefu=
l
> > >>> on kernels containing fb3f903769e8 ("tun: support NAPI for packets
> > >>> received from batched XDP buffs"), as IFF_NAPI allows the
> > >>> vhost_tx_batch path to use NAPI on XDP buffs.
> > >>>
> > >>> Benchmark w/ iperf -c (remote srv) -P (thread count) -l (stream siz=
e)
> > >>> from a guest running kernel 5.10.105 to remote bare metal running
> > >>> patched code on kernel 5.10.139. Guests were configured 1x virtio-n=
et
> > >>> device with 4x queues, resulting in 4x vhost-worker threads. Hosts =
are
> > >>> identical with Intel ICX 4314 @ 2.4 GHz with Mellanox CX5 25GbE NIC=
 ->
> > >>> Arista 25GbE switch. vhost-worker threads largely maxed out on CPU =
on
> > >>> "Before" and around ~50-60% utilization "After".
> > >>>
> > >>> Single Stream: iperf -P 1
> > >>> iperf -l size | Before          | After          | Increase
> > >>> 64B           | 593 Mbits/sec   | 712 Mbits/sec  | ~20%
> > >>> 128B          | 1.00 Gbits/sec  | 1.18 Gbits/sec | ~18%
> > >>> 4KB           | 17.6 Gbits/sec  | 22.7 Gbits/sec | ~29%
> > >>>
> > >>> Multiple Stream: iperf -P 12
> > >>> iperf -l size | Before          | After          | Increase
> > >>> 64B           | 6.35 Gbits/sec  | 7.78 Gbits/sec | ~23%
> > >>> 128B          | 10.8 Gbits/sec  | 14.2 Gbits/sec | ~31%
> > >>> 4KB           | 23.6 Gbits/sec  | 23.6 Gbits/sec | (line speed)
> > >>>
> > >>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> > >>
> > >> Great, but I would suggest having an option.
> > >>
> > >> So we can:
> > >>
> > >> 1) ease the debug and compare
> > >> 2) enable this by default only for 8.1, disable it for pre 8.1
> >
> > Fair enough, one favor to ask though -
> > Would you be able to point me to an existing option like what you=E2=80=
=99re
> > proposing so I could make sure I=E2=80=99m on the same page?
>
> For example, the vhost option for tap. Maybe we can have an napi option.
>
> >
> > >
> > > More thought, if the performance boost only after fb3f903769e8, we
> > > probably need to disable it by default and let the mgmt layer to
> > > enable it.
> > >
> >
> > I focused my testing with that commit, but I could take it out and
> > we still should get benefit. Would you like me to profile that to valid=
ate?
> >
>
> One problem is that NAPI for TAP was originally used for kernel
> hardening. Looking at the history, it introduces a lot of bugs.
>
> Consider:
>
> 1) it has been merged for several years
> 2) tap has been widely used for a long time as well
>
> I think it would be still safe to keep the option off (at least for
> pre 8.1 machines).
>
> > Asking as NAPI support in tun.c has been there for a while, guessing
> > at first glance that there would be non-zero gains, with little downsid=
es.
> > Looking at git blame, seems about ~5-6 years of support.
>
> Yes.
>
> >
> > Also for posterity, that commit has been in since 5.18, so a little ove=
r 1 year.
>
> Then I think we can make it enabled by default for 8.1 and see.

Btw, it would be better if we can have some PPS benchmark as well.

Thanks

>
> Thanks
>
> >
> > > Thanks
> > >
> > >>
> > >> Thanks
> > >>
> > >> Thanks
> > >>
> > >>> ---
> > >>> net/tap-linux.c | 4 ++++
> > >>> net/tap-linux.h | 1 +
> > >>> 2 files changed, 5 insertions(+)
> > >>>
> > >>> diff --git a/net/tap-linux.c b/net/tap-linux.c
> > >>> index f54f308d359..fd94df166e0 100644
> > >>> --- a/net/tap-linux.c
> > >>> +++ b/net/tap-linux.c
> > >>> @@ -62,6 +62,10 @@ int tap_open(char *ifname, int ifname_size, int =
*vnet_hdr,
> > >>>         ifr.ifr_flags |=3D IFF_ONE_QUEUE;
> > >>>     }
> > >>>
> > >>> +    if (features & IFF_NAPI) {
> > >>> +        ifr.ifr_flags |=3D IFF_NAPI;
> > >>> +    }
> > >>> +
> > >>>     if (*vnet_hdr) {
> > >>>         if (features & IFF_VNET_HDR) {
> > >>>             *vnet_hdr =3D 1;
> > >>> diff --git a/net/tap-linux.h b/net/tap-linux.h
> > >>> index bbbb62c2a75..f4d8e55270b 100644
> > >>> --- a/net/tap-linux.h
> > >>> +++ b/net/tap-linux.h
> > >>> @@ -37,6 +37,7 @@
> > >>>
> > >>> /* TUNSETIFF ifr flags */
> > >>> #define IFF_TAP          0x0002
> > >>> +#define IFF_NAPI         0x0010
> > >>> #define IFF_NO_PI        0x1000
> > >>> #define IFF_ONE_QUEUE    0x2000
> > >>> #define IFF_VNET_HDR     0x4000
> > >>> --
> > >>> 2.30.1 (Apple Git-130)
> >


