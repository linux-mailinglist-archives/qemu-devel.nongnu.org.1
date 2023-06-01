Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45DAC71A06A
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:39:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jRn-0003VC-Fr; Thu, 01 Jun 2023 10:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4jRj-0003MH-Fi
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q4jRf-0001lD-Fv
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685630309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2MfbSdscJ7S8hTl/kQ2LqfYiaQXu/lXwfkkwlmhHJI=;
 b=an/cdlyMVbZBnTucxA4rOcFJJ7w1ycCtTkRQUmeGwDFWZZoISw9SNU/xSfhWOteEemyCNQ
 oM83LVXi3aZzA+E36RdzbqXm4O0UWQq0b6iQix+tordOx5qeafGFFq4UKpIyl/16aOp+Sh
 RVwFC6D+uM38BPzQjg1C74uWNdRDCXY=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-yExm4apOO0GYPFdM-TGxgg-1; Thu, 01 Jun 2023 10:38:28 -0400
X-MC-Unique: yExm4apOO0GYPFdM-TGxgg-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-19f1c6a85acso803230fac.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:38:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685630307; x=1688222307;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2MfbSdscJ7S8hTl/kQ2LqfYiaQXu/lXwfkkwlmhHJI=;
 b=daMULIFiW1SDUa73dfzzdrLjiU8OS/00/w6ijBak7/MR13pfAyVaHz1SUXuJ64LWii
 WbqX+RPyfa02zHdVUZKcfmAf6xHFLqHNsOByFSeZ8mHZY45Qfq1s5sJaQxoSZWbYG/Pj
 5diwN6+CnaJu9yZqDdof2XWaQMMlKyM9Pk+oB2TsE4BtPsdb1f7hGhfBKB2Z0H5RceZh
 mjDL1ffHMb2yud3NGnFBViJQq6brsK9ZKVgamJtYtKsHZPmcn4HNyUP5vcgojqUKF82v
 CSXGJ01UrgRGYP80GWBDNINVeXjk+VtM/7UsN9tIabEJSsWDx8QeEE4TK+ZU9b+V1Sqx
 Hj1w==
X-Gm-Message-State: AC+VfDzyrJ1nr1gfdqKNRGFS8MdyrEQlfHYtT7GO5CSyDpxJuiPizkxe
 dQHI2DF9BhAdQXChomzwS9TWKF48vL3RnpNkkic1YzxAcrkMiWucdjViKnSO5bQiBNgZSeletyW
 IqjHsPsPXHSJd9odGsRRMZJNy8798uhA=
X-Received: by 2002:a05:6870:d0c8:b0:19a:24cf:1597 with SMTP id
 k8-20020a056870d0c800b0019a24cf1597mr8138566oaa.27.1685630307682; 
 Thu, 01 Jun 2023 07:38:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oXGSV8RYbtOf2672FA5hXDhrO9URW2Wp864LRHUa4ez6+yL9RV41YTZuxJZyoS2iOub58Y0Bb31XoRTvFHoY=
X-Received: by 2002:a05:6870:d0c8:b0:19a:24cf:1597 with SMTP id
 k8-20020a056870d0c800b0019a24cf1597mr8138549oaa.27.1685630307427; Thu, 01 Jun
 2023 07:38:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685584543.git.yin31149@gmail.com>
 <39fddc462ad4c7619843a4cd7cba92e0bbc48c45.1685584543.git.yin31149@gmail.com>
 <CAKrof1OyEL5RGTWgHjgfMSkMC-afiWW8VAF5qirCy3juErWSqA@mail.gmail.com>
 <CAJaqyWewHKZebftQc6HrhDQEV5cTWiJUkVL4NgzOVqoGdP+6Sw@mail.gmail.com>
 <CAKrof1N0s2prVBUUz=quD-DofUcwJC=Ck_2gry9d2E+14y=Ypw@mail.gmail.com>
In-Reply-To: <CAKrof1N0s2prVBUUz=quD-DofUcwJC=Ck_2gry9d2E+14y=Ypw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 1 Jun 2023 16:37:51 +0200
Message-ID: <CAJaqyWfS8tRsPfBgr+JDUD1d0TFtsXh=g8eirL2zxi37D_PrTg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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

On Thu, Jun 1, 2023 at 3:59=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> On 2023/6/1 21:43, Eugenio Perez Martin wrote:
> > On Thu, Jun 1, 2023 at 11:05=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> On Thu, 1 Jun 2023 at 16:48, Hawkins Jiawei <yin31149@gmail.com> wrote=
:
> >>>
> >>> To support restoring offloads state in vdpa, need to expose
> >>> the function virtio_net_supported_guest_offloads(), then vdpa
> >>> uses this function to get the guest supported offloads.
> >>
> >> Here it should be changed to "then QEMU uses this function
> >> to get the guest supported offloads.". I will correct the commit
> >> message in the v3 patch.
> >>
> >
> > Maybe "to get the device supported offloads allow qemu to know the
> > defaults, so it can skip the control message sending if they match
> > with the driver's configuration"?
> >
> > We can also add "This will be the default at guest's startup, these
> > values can mismatch only at live migration".
>
> Hi Eugenio,
>
> I sent the v3 patch before seeing this email:(.
>

Moving the discussion to v3 then :).

Thanks!

> I refactor the commit message to
> "To support restoring offloads state in vdpa, need to expose
> the function virtio_net_supported_guest_offloads().
> QEMU uses this function to get the guest supported offloads
> and no needs to send the corresponding CVQ command if guest
> enables all supported features." in v3 patch.
>
> Do you think there is still some refactoring needed here?
>
> Thanks!
>
>
> >
> > What do you think?
> >
> > Thanks!
> >
> >> Thanks!
> >>
> >>>
> >>> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> >>> ---
> >>>   hw/net/virtio-net.c            | 2 +-
> >>>   include/hw/virtio/virtio-net.h | 1 +
> >>>   2 files changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >>> index 7b27dad6c4..7e8897a8bc 100644
> >>> --- a/hw/net/virtio-net.c
> >>> +++ b/hw/net/virtio-net.c
> >>> @@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_feat=
ures(uint32_t features)
> >>>       return guest_offloads_mask & features;
> >>>   }
> >>>
> >>> -static inline uint64_t virtio_net_supported_guest_offloads(const Vir=
tIONet *n)
> >>> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
> >>>   {
> >>>       VirtIODevice *vdev =3D VIRTIO_DEVICE(n);
> >>>       return virtio_net_guest_offloads_by_features(vdev->guest_featur=
es);
> >>> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virti=
o-net.h
> >>> index ef234ffe7e..5f5dcb4572 100644
> >>> --- a/include/hw/virtio/virtio-net.h
> >>> +++ b/include/hw/virtio/virtio-net.h
> >>> @@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *v=
dev,
> >>>                                     unsigned out_num);
> >>>   void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
> >>>                                      const char *type);
> >>> +uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
> >>>
> >>>   #endif
> >>> --
> >>> 2.25.1
> >>>
> >>
> >
>


