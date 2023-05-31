Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B996E717489
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 05:56:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Cvv-0005KP-Bw; Tue, 30 May 2023 23:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4Cvr-0005K7-3S
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4Cvm-00053R-Db
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685505325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CiPBB+Ea4d5qa7vN02xfT/GXaR2B+P2Uc/Y2hgIPTw=;
 b=RUwvYCIr/qavMT2oZNn+6VWI9XmbTzENcIIBar1bAZTPT7SXl3rhHgV61p8vFJlTNM7jvM
 H81T1G3ZHWaZSHA38qKpwZTDxm9/CC+gbAja0HY5FX6EtquXWCeCQVDlaZPS69FLvgbNmb
 0kzKTHgyhb2vNYMEWNt8CwkPsmBmVmU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-RQh3EChNNXeYHtV_EGnrsQ-1; Tue, 30 May 2023 23:55:23 -0400
X-MC-Unique: RQh3EChNNXeYHtV_EGnrsQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b05714a774so28212301fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 20:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505322; x=1688097322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CiPBB+Ea4d5qa7vN02xfT/GXaR2B+P2Uc/Y2hgIPTw=;
 b=EFoKeck3UHmpBiR9cfavVHU2lQOL4Sqhzvh1aC5MyryKtjKff+K39NkBiE99m9O9aO
 jOdt9u7xZ045pz392VljUWAbeyK2+GcfNPiAzq0UfrsX1vMbHqH2mj4bjqy9MvAEKyaF
 MNAjhEmgTQPOr3onjKN5LV7zgIDEnS9f5wYR7W/oxxACPB9srz84xvn6rsIE5JH+KuWb
 m78ZRJMjMWwu4laODr8kCA1jqNupiMDYxjexftHQW+Zjy+Q7h1A81iMlGnjT7bdq+92m
 RLDOBQIHFNH8DVvutym8Eo+Q2bhgxWO0wpw0CtltSCD90gim9L3DuyziqcfU29TUO9yL
 yChA==
X-Gm-Message-State: AC+VfDz/TztkzU0GbOluvSB05KOmjQ1E4Jadcn9x4mkQtOtkY3qZ9l2K
 z3qzkoF9Gk1VAy9z0lz5XCOn3KtAWMJUt4IgHVYAg3yT7PJZd9a/sMFKMaX0tvM1xRKGMPdyeCS
 CBPh/4AcjftMJPDd+AWaSlGnLFP8hDvfy2jKqAefspw==
X-Received: by 2002:a2e:9e47:0:b0:2af:a696:3691 with SMTP id
 g7-20020a2e9e47000000b002afa6963691mr1872739ljk.40.1685505322013; 
 Tue, 30 May 2023 20:55:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OLgfxNyfv+M9f9kuZJ2Uhh++ApHdMsmRxTWz6y7NaZMfEJO1LSxkFbzqK2+lfROSIMzukyOHUoBdtWVm5Ey0=
X-Received: by 2002:a2e:9e47:0:b0:2af:a696:3691 with SMTP id
 g7-20020a2e9e47000000b002afa6963691mr1872735ljk.40.1685505321692; Tue, 30 May
 2023 20:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230531031645.44335-1-jon@nutanix.com>
 <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
 <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
 <42F3C35E-EB0C-4AA9-8863-618E60792842@nutanix.com>
In-Reply-To: <42F3C35E-EB0C-4AA9-8863-618E60792842@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 11:55:10 +0800
Message-ID: <CACGkMEu51T2JHF+mGM5xfgmA5N=oSTZgCtRy1JG0c6yDxcVDtQ@mail.gmail.com>
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

On Wed, May 31, 2023 at 11:47=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote=
:
>
>
>
> > On May 30, 2023, at 11:35 PM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, May 31, 2023 at 11:32=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> >>
> >> On Wed, May 31, 2023 at 11:17=E2=80=AFAM Jon Kohler <jon@nutanix.com> =
wrote:
> >>>
> >>> If kernel supports IFF_NAPI, lets use it, which is especially useful
> >>> on kernels containing fb3f903769e8 ("tun: support NAPI for packets
> >>> received from batched XDP buffs"), as IFF_NAPI allows the
> >>> vhost_tx_batch path to use NAPI on XDP buffs.
> >>>
> >>> Benchmark w/ iperf -c (remote srv) -P (thread count) -l (stream size)
> >>> from a guest running kernel 5.10.105 to remote bare metal running
> >>> patched code on kernel 5.10.139. Guests were configured 1x virtio-net
> >>> device with 4x queues, resulting in 4x vhost-worker threads. Hosts ar=
e
> >>> identical with Intel ICX 4314 @ 2.4 GHz with Mellanox CX5 25GbE NIC -=
>
> >>> Arista 25GbE switch. vhost-worker threads largely maxed out on CPU on
> >>> "Before" and around ~50-60% utilization "After".
> >>>
> >>> Single Stream: iperf -P 1
> >>> iperf -l size | Before          | After          | Increase
> >>> 64B           | 593 Mbits/sec   | 712 Mbits/sec  | ~20%
> >>> 128B          | 1.00 Gbits/sec  | 1.18 Gbits/sec | ~18%
> >>> 4KB           | 17.6 Gbits/sec  | 22.7 Gbits/sec | ~29%
> >>>
> >>> Multiple Stream: iperf -P 12
> >>> iperf -l size | Before          | After          | Increase
> >>> 64B           | 6.35 Gbits/sec  | 7.78 Gbits/sec | ~23%
> >>> 128B          | 10.8 Gbits/sec  | 14.2 Gbits/sec | ~31%
> >>> 4KB           | 23.6 Gbits/sec  | 23.6 Gbits/sec | (line speed)
> >>>
> >>> Signed-off-by: Jon Kohler <jon@nutanix.com>
> >>
> >> Great, but I would suggest having an option.
> >>
> >> So we can:
> >>
> >> 1) ease the debug and compare
> >> 2) enable this by default only for 8.1, disable it for pre 8.1
>
> Fair enough, one favor to ask though -
> Would you be able to point me to an existing option like what you=E2=80=
=99re
> proposing so I could make sure I=E2=80=99m on the same page?

For example, the vhost option for tap. Maybe we can have an napi option.

>
> >
> > More thought, if the performance boost only after fb3f903769e8, we
> > probably need to disable it by default and let the mgmt layer to
> > enable it.
> >
>
> I focused my testing with that commit, but I could take it out and
> we still should get benefit. Would you like me to profile that to validat=
e?
>

One problem is that NAPI for TAP was originally used for kernel
hardening. Looking at the history, it introduces a lot of bugs.

Consider:

1) it has been merged for several years
2) tap has been widely used for a long time as well

I think it would be still safe to keep the option off (at least for
pre 8.1 machines).

> Asking as NAPI support in tun.c has been there for a while, guessing
> at first glance that there would be non-zero gains, with little downsides=
.
> Looking at git blame, seems about ~5-6 years of support.

Yes.

>
> Also for posterity, that commit has been in since 5.18, so a little over =
1 year.

Then I think we can make it enabled by default for 8.1 and see.

Thanks

>
> > Thanks
> >
> >>
> >> Thanks
> >>
> >> Thanks
> >>
> >>> ---
> >>> net/tap-linux.c | 4 ++++
> >>> net/tap-linux.h | 1 +
> >>> 2 files changed, 5 insertions(+)
> >>>
> >>> diff --git a/net/tap-linux.c b/net/tap-linux.c
> >>> index f54f308d359..fd94df166e0 100644
> >>> --- a/net/tap-linux.c
> >>> +++ b/net/tap-linux.c
> >>> @@ -62,6 +62,10 @@ int tap_open(char *ifname, int ifname_size, int *v=
net_hdr,
> >>>         ifr.ifr_flags |=3D IFF_ONE_QUEUE;
> >>>     }
> >>>
> >>> +    if (features & IFF_NAPI) {
> >>> +        ifr.ifr_flags |=3D IFF_NAPI;
> >>> +    }
> >>> +
> >>>     if (*vnet_hdr) {
> >>>         if (features & IFF_VNET_HDR) {
> >>>             *vnet_hdr =3D 1;
> >>> diff --git a/net/tap-linux.h b/net/tap-linux.h
> >>> index bbbb62c2a75..f4d8e55270b 100644
> >>> --- a/net/tap-linux.h
> >>> +++ b/net/tap-linux.h
> >>> @@ -37,6 +37,7 @@
> >>>
> >>> /* TUNSETIFF ifr flags */
> >>> #define IFF_TAP          0x0002
> >>> +#define IFF_NAPI         0x0010
> >>> #define IFF_NO_PI        0x1000
> >>> #define IFF_ONE_QUEUE    0x2000
> >>> #define IFF_VNET_HDR     0x4000
> >>> --
> >>> 2.30.1 (Apple Git-130)
>


