Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA97628AC
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 04:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOU70-0001B7-1h; Tue, 25 Jul 2023 22:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOU6x-00019S-T9
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 22:18:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qOU6u-0001Db-Oe
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 22:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690337924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcbJ70YxARdjQPU4k0x1ZdNkFoUW6ph9onErFypYqso=;
 b=LXCiyUXkpUAqUzp6zqfXzVlWt8UPlUDYyyTJ0EIUS0MLwdDopkTWAKBaZ+Q7X/kcloh0A1
 6FtIJnosmY89ymUwDbRR5waBgDc0V0w4DQDHNCkE1TC6knp3i0oBKZ3FGkEJsBLlqToevM
 etNExoYp0uXETHMud60YG+2gBTtFeco=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SDqTtDqHNJub3ToUBcKbMQ-1; Tue, 25 Jul 2023 22:18:42 -0400
X-MC-Unique: SDqTtDqHNJub3ToUBcKbMQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6f97c996dso58675931fa.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 19:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690337920; x=1690942720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JcbJ70YxARdjQPU4k0x1ZdNkFoUW6ph9onErFypYqso=;
 b=CqnYojTQ+ag/JAGOY0e5tU80RQetAil4ZrgFboAjFsXgcMFSOGFInFQShOXMITcaEs
 PLsNuUpx4S9WIS68VrwVM6MGD0TpaYE0Bf5m6aU+pPHJEPJsNaKMCPpW5qfNMofl07TS
 CQB4FhcKODBplmPjL0gAOinVxctKyHdSaEJG1u3vIiXr2W4bRpQThtl8f/q8sZJbll35
 WSv2Y1iDnvs4zm3+yp6Do+6Kk9WvjWT7I7/WcgPRm3hmDCnvP9Dg/SgVEmoTvwQNA9yp
 wyBmCCNBnGkApjJhxJ6NyZ+3vzO3IMacsUiwBysqLPq/fACqsJ6shNBxZrm3zkvnWBkU
 Lv5g==
X-Gm-Message-State: ABy/qLbi+kAd1ArvfVcDtIccuW0PhAwnfHjxF4Cfhos4U3xnDDE7NaH0
 D9IWJt2QbEElppTOZDd/7vBEyntI7iA2kYYXi6Kg1EO0a7PXHPLJVjylXK3xfFlw+CycksSG9sz
 A/uKyc6wuXteeUCWFUg+iUY+gp7Ug02g=
X-Received: by 2002:a2e:8692:0:b0:2b6:e361:4b3c with SMTP id
 l18-20020a2e8692000000b002b6e3614b3cmr386596lji.14.1690337920762; 
 Tue, 25 Jul 2023 19:18:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG08bktF4iQYq/JypkaorlqrYdlOH/avM2B5PeqG93KBnW8T0m9lhgPhOgHKsDh2Bor+2C0xKYzOYUFZnYqsSM=
X-Received: by 2002:a2e:8692:0:b0:2b6:e361:4b3c with SMTP id
 l18-20020a2e8692000000b002b6e3614b3cmr386589lji.14.1690337920473; Tue, 25 Jul
 2023 19:18:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690100802.git.yin31149@gmail.com>
 <e76a29f77bb3f386e4a643c8af94b77b775d1752.1690100802.git.yin31149@gmail.com>
 <CACGkMEuM8JdPhch4uV+3zBSq=8ss99xDwX-KAr9_8_Q8TJ9m+g@mail.gmail.com>
 <CAKrof1MxeP2r8uunF_GX2qZuq7KpQ-vz-MQcf5D9rXFto3tTrA@mail.gmail.com>
In-Reply-To: <CAKrof1MxeP2r8uunF_GX2qZuq7KpQ-vz-MQcf5D9rXFto3tTrA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 10:18:29 +0800
Message-ID: <CACGkMEs-uo1-CqS2Zo7kd3KxKXYShU-k1jmy5B0-_XyZku4KDg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] vdpa: Restore vlan filtering state
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: mst@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Tue, Jul 25, 2023 at 3:48=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> On 2023/7/25 14:47, Jason Wang wrote:
> > On Sun, Jul 23, 2023 at 5:28=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> This patch introduces vhost_vdpa_net_load_single_vlan()
> >> and vhost_vdpa_net_load_vlan() to restore the vlan
> >> filtering state at device's startup.
> >>
> >> Co-developed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> >> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> >
> > But this seems to be a source of latency killer as it may at most send
> > 1024 commands.
> >
> > As discussed in the past, we need a better cvq command to do this: for
> > example, a single command to carray a bitmap.
>
> Hi Jason,
>
> Thanks for your review.
>
> You are right, we need some improvement here.
>
> Therefore, I have submitted another patch series titled "vdpa: Send all
> CVQ state load commands in parallel" at [1], which allows QEMU to delay
> polling and checking the device used buffer until either the SVQ is full
> or control commands shadow buffers are full, so that QEMU can send all
> the SVQ control commands in parallel, which has better performance
> improvement.
>
> To test that patch series, I created 4094 VLANS in guest to build an
> environment for sending multiple CVQ state load commands. According to
> the result on the real vdpa device at [2], this patch series can improve
> latency from 23296 us to 6539 us.
>
> Thanks!
>
> [1]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03726.html
> [2]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03947.html
>

That's great, and if we can use a single command to get/set vid it
would be still helpful (I meant we can extend the virtio spec).

Thanks

>
> >
> > Thanks
> >
> >> ---
> >> v2:
> >>   - remove the extra line pointed out by Eugenio
> >>
> >> v1: https://lore.kernel.org/all/0a568cc8a8d2b750c2e09b2237e9f05cece07c=
3f.1689690854.git.yin31149@gmail.com/
> >>
> >>   net/vhost-vdpa.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 48 insertions(+)
> >>
> >> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> >> index 9795306742..347241796d 100644
> >> --- a/net/vhost-vdpa.c
> >> +++ b/net/vhost-vdpa.c
> >> @@ -965,6 +965,50 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState =
*s,
> >>       return 0;
> >>   }
> >>
> >> +static int vhost_vdpa_net_load_single_vlan(VhostVDPAState *s,
> >> +                                           const VirtIONet *n,
> >> +                                           uint16_t vid)
> >> +{
> >> +    const struct iovec data =3D {
> >> +        .iov_base =3D &vid,
> >> +        .iov_len =3D sizeof(vid),
> >> +    };
> >> +    ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTR=
L_VLAN,
> >> +                                                  VIRTIO_NET_CTRL_VLA=
N_ADD,
> >> +                                                  &data, 1);
> >> +    if (unlikely(dev_written < 0)) {
> >> +        return dev_written;
> >> +    }
> >> +    if (unlikely(*s->status !=3D VIRTIO_NET_OK)) {
> >> +        return -EIO;
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static int vhost_vdpa_net_load_vlan(VhostVDPAState *s,
> >> +                                    const VirtIONet *n)
> >> +{
> >> +    int r;
> >> +
> >> +    if (!virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_VL=
AN)) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    for (int i =3D 0; i < MAX_VLAN >> 5; i++) {
> >> +        for (int j =3D 0; n->vlans[i] && j <=3D 0x1f; j++) {
> >> +            if (n->vlans[i] & (1U << j)) {
> >> +                r =3D vhost_vdpa_net_load_single_vlan(s, n, (i << 5) =
+ j);
> >> +                if (unlikely(r !=3D 0)) {
> >> +                    return r;
> >> +                }
> >> +            }
> >> +        }
> >> +    }
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>   static int vhost_vdpa_net_load(NetClientState *nc)
> >>   {
> >>       VhostVDPAState *s =3D DO_UPCAST(VhostVDPAState, nc, nc);
> >> @@ -995,6 +1039,10 @@ static int vhost_vdpa_net_load(NetClientState *n=
c)
> >>       if (unlikely(r)) {
> >>           return r;
> >>       }
> >> +    r =3D vhost_vdpa_net_load_vlan(s, n);
> >> +    if (unlikely(r)) {
> >> +        return r;
> >> +    }
> >>
> >>       return 0;
> >>   }
> >> --
> >> 2.25.1
> >>
> >
>


