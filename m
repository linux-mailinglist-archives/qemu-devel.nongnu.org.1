Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8D071746B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 05:36:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4CdC-0008Rp-4g; Tue, 30 May 2023 23:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4CdA-0008Re-Cq
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q4Cd8-0001us-TW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:36:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685504170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMNl2ohd0bSpYzPDhvmJ+tNwQt8m8GsT/OU4FnOK+zw=;
 b=Ec4boSiFINjhgH23ztliwqq5e/Hs7O/A0gjkLCGXVjT8sqdHuQlgLUNWpoPl79dCjKuufb
 MWSEHs+9FTdMBUQJSsJgbP5G7Mic3LyHATVdf7GpRJxhZuiyn+fBwpGbGfDDaVQe6MRjl1
 MYxe+xvmhoZ2VzCBiBCD3bnWUtoUgvo=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-NZEjTAn2Oaudt-QGadylkA-1; Tue, 30 May 2023 23:36:08 -0400
X-MC-Unique: NZEjTAn2Oaudt-QGadylkA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2af2790f4a2so28531921fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 20:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685504166; x=1688096166;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qMNl2ohd0bSpYzPDhvmJ+tNwQt8m8GsT/OU4FnOK+zw=;
 b=ONjw3vcwwM6fhw9esoQsGXqRUTKQ3tFZaUPwIRZGoG+FF6xOJX7KkqVybtk6HMB4hu
 frPjLfNPuwhKPOiu5JldnJPTHMp+kf9N3Sod9daa9aGLEiDu36H9hPJCmIL/Srj8Gv6f
 vBa1NwIqM8EsKidgXS01Qadm1gnkONKvgk9ywo5LRsmuzXdmuzFBHfUIBztyJsrgXFUa
 pI0yO15GljLNN/Nnl/TeE1bKcoteduy9mGP5fYixSHJqMrYuLor+PQ1Ad7kAuJwBqMIs
 CFPR06qJdoj/gdlDonAnL9xRB+VXptBRy7qytcRuB1DyEDnoZw2LyLz61TNe0WGeGfLX
 WvIw==
X-Gm-Message-State: AC+VfDxi4qYuRQSGnrCgfvu0Ud6RLD3hDuTFqwiTh8aLF+wdSXiC4qc9
 s686+pTN6nz1+9M1nVb4TwjeKLeNt44wpfNqh9q8GNM2j8sK4HHWdG9sb6miPqNTIVK0hG27A+u
 J+K+0jvdl8Drl6RdSLR8Bf5IoCEgDGAPAXf4P1PzOPGz6
X-Received: by 2002:a2e:a170:0:b0:2ad:8380:770d with SMTP id
 u16-20020a2ea170000000b002ad8380770dmr1852967ljl.21.1685504166712; 
 Tue, 30 May 2023 20:36:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Zm3aY8K8rrtRbIb+e1RW9fywUs+HVW9EbRCQXZR06sypUumCPmiWX4p3jldAX+lqpOa61qOpBmgM+gU6ChhY=
X-Received: by 2002:a2e:a170:0:b0:2ad:8380:770d with SMTP id
 u16-20020a2ea170000000b002ad8380770dmr1852962ljl.21.1685504166403; Tue, 30
 May 2023 20:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230531031645.44335-1-jon@nutanix.com>
 <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
In-Reply-To: <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 11:35:55 +0800
Message-ID: <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
Subject: Re: [PATCH] tap: introduce IFF_NAPI
To: Jon Kohler <jon@nutanix.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Wed, May 31, 2023 at 11:32=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Wed, May 31, 2023 at 11:17=E2=80=AFAM Jon Kohler <jon@nutanix.com> wro=
te:
> >
> > If kernel supports IFF_NAPI, lets use it, which is especially useful
> > on kernels containing fb3f903769e8 ("tun: support NAPI for packets
> > received from batched XDP buffs"), as IFF_NAPI allows the
> > vhost_tx_batch path to use NAPI on XDP buffs.
> >
> > Benchmark w/ iperf -c (remote srv) -P (thread count) -l (stream size)
> > from a guest running kernel 5.10.105 to remote bare metal running
> > patched code on kernel 5.10.139. Guests were configured 1x virtio-net
> > device with 4x queues, resulting in 4x vhost-worker threads. Hosts are
> > identical with Intel ICX 4314 @ 2.4 GHz with Mellanox CX5 25GbE NIC ->
> > Arista 25GbE switch. vhost-worker threads largely maxed out on CPU on
> > "Before" and around ~50-60% utilization "After".
> >
> > Single Stream: iperf -P 1
> > iperf -l size | Before          | After          | Increase
> > 64B           | 593 Mbits/sec   | 712 Mbits/sec  | ~20%
> > 128B          | 1.00 Gbits/sec  | 1.18 Gbits/sec | ~18%
> > 4KB           | 17.6 Gbits/sec  | 22.7 Gbits/sec | ~29%
> >
> > Multiple Stream: iperf -P 12
> > iperf -l size | Before          | After          | Increase
> > 64B           | 6.35 Gbits/sec  | 7.78 Gbits/sec | ~23%
> > 128B          | 10.8 Gbits/sec  | 14.2 Gbits/sec | ~31%
> > 4KB           | 23.6 Gbits/sec  | 23.6 Gbits/sec | (line speed)
> >
> > Signed-off-by: Jon Kohler <jon@nutanix.com>
>
> Great, but I would suggest having an option.
>
> So we can:
>
> 1) ease the debug and compare
> 2) enable this by default only for 8.1, disable it for pre 8.1

More thought, if the performance boost only after fb3f903769e8, we
probably need to disable it by default and let the mgmt layer to
enable it.

Thanks

>
> Thanks
>
> Thanks
>
> > ---
> >  net/tap-linux.c | 4 ++++
> >  net/tap-linux.h | 1 +
> >  2 files changed, 5 insertions(+)
> >
> > diff --git a/net/tap-linux.c b/net/tap-linux.c
> > index f54f308d359..fd94df166e0 100644
> > --- a/net/tap-linux.c
> > +++ b/net/tap-linux.c
> > @@ -62,6 +62,10 @@ int tap_open(char *ifname, int ifname_size, int *vne=
t_hdr,
> >          ifr.ifr_flags |=3D IFF_ONE_QUEUE;
> >      }
> >
> > +    if (features & IFF_NAPI) {
> > +        ifr.ifr_flags |=3D IFF_NAPI;
> > +    }
> > +
> >      if (*vnet_hdr) {
> >          if (features & IFF_VNET_HDR) {
> >              *vnet_hdr =3D 1;
> > diff --git a/net/tap-linux.h b/net/tap-linux.h
> > index bbbb62c2a75..f4d8e55270b 100644
> > --- a/net/tap-linux.h
> > +++ b/net/tap-linux.h
> > @@ -37,6 +37,7 @@
> >
> >  /* TUNSETIFF ifr flags */
> >  #define IFF_TAP          0x0002
> > +#define IFF_NAPI         0x0010
> >  #define IFF_NO_PI        0x1000
> >  #define IFF_ONE_QUEUE    0x2000
> >  #define IFF_VNET_HDR     0x4000
> > --
> > 2.30.1 (Apple Git-130)
> >


