Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14607728E68
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 05:15:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7SZZ-0008LB-4u; Thu, 08 Jun 2023 23:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q7SZX-0008Kg-9K
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q7SZP-0007l8-Gk
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686280425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GBNT32cgbsF9mS/OgLiaKEN7CR/3u06xjt3w+e5qBM=;
 b=jPcHW3e17oTtpCkEjb3ORm2tjSYIYm9hCoNxNWS6pkzq62pAK/6ZtaFZPs8ug6rs/f2Tno
 0yqD6bwj3wpXbcSeFObepdYDUwjCJZDkWFsU+2i64wIZnuAw1EQnL/oLls8SbECo6dOWPA
 4v86MZIV7vF/q8YehLd9gleUXymZgow=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-CGkrWoHzNb22S183-TDYUQ-1; Thu, 08 Jun 2023 23:13:42 -0400
X-MC-Unique: CGkrWoHzNb22S183-TDYUQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b1adee343dso7547461fa.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 20:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686280421; x=1688872421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1GBNT32cgbsF9mS/OgLiaKEN7CR/3u06xjt3w+e5qBM=;
 b=G9zeH5wk7hvKOzqQRePeFXw14tPSUaCChr10SyMUQ/EzpQ11AuvtAoMsJ4J8Bxr6DP
 U0tdmvUu1/AXdlW4M3OOnRBP9f3UDmXqpzo8gJIZrcsSPY8Zik1mxhe2TWi2bK12Qjk3
 Dew9G7EYVPYsSQIVFDShz6fkpuEUJ6dqAhRV+Lpw3M6iSUuzJGUy4hPn+TEoC1Hfwt3V
 sl4lEEvTA64CpL6GSh2eOj+k/+WaPX/4lngzCiixM366/bltYUt4wAqpgPtMNxFf0po/
 J69Ai8J89idj68qu91u7ilhaEdt4AAGWWhx22jW8DpaODpbHegPX8NueVTq+pdS1Joj1
 D9xg==
X-Gm-Message-State: AC+VfDwXnvcFFxj9fgol0xk9zjrJTPCLENwv7yCtfcf7ksLwutXNncrB
 9SiLpKUm72B2wAxYLTN5RoseKbT764RZBpDlz67hD36GTMrll8gnAsJkGBtw3AMBcdFQZftR3mz
 Mz67TEeYmxhBiwVCss0DN8NC4ODSrg+g=
X-Received: by 2002:a2e:9bce:0:b0:2ad:98ec:6b1d with SMTP id
 w14-20020a2e9bce000000b002ad98ec6b1dmr159665ljj.46.1686280421542; 
 Thu, 08 Jun 2023 20:13:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tu7St7s/v46t9YYCAT7nBdnRrLfRxk95VflMcuUYs1UcLBMJx/f7yjsnODHY+Ozk+wM6hp4xrWc3IelLFBbg=
X-Received: by 2002:a2e:9bce:0:b0:2ad:98ec:6b1d with SMTP id
 w14-20020a2e9bce000000b002ad98ec6b1dmr159661ljj.46.1686280421232; Thu, 08 Jun
 2023 20:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
 <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
In-Reply-To: <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 9 Jun 2023 11:13:30 +0800
Message-ID: <CACGkMEvsX0=QsrbjgHVxZ9BAz4b+64waErtvX6bZcPcgpJV-pg@mail.gmail.com>
Subject: Re: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Jun 7, 2023 at 11:37=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Jun 7, 2023 at 11:09=E2=80=AFAM Zhu Lingshan <lingshan.zhu@intel.=
com> wrote:
> >
> > When read the state of a virtqueue, vhost_vdpa need
> > to check whether the device is suspended.
> >
> > This commit verifies whether VHOST_BACKEND_F_SUSPEND is
> > negotiated when checking vhost_vdpa->suspended.
> >
>
> I'll add: Otherwise, qemu prints XXX error message.
>
> On second thought, not returning an error prevents the caller
> (vhost.c:vhost_virtqueue_stop) from recovering used idx from the
> guest.
>
> I'm not sure about the right fix for this, should we call
> virtio_queue_restore_last_avail_idx here?

It should be the duty of the caller:

E.g in vhost_virtqueue_stop() we had:

=3D>  r =3D dev->vhost_ops->vhost_get_vring_base(dev, &state);
    if (r < 0) {
        VHOST_OPS_DEBUG(r, "vhost VQ %u ring restore failed: %d", idx, r);
        /* Connection to the backend is broken, so let's sync internal
         * last avail idx to the device used idx.
         */
virtio_queue_restore_last_avail_idx(vdev, idx);
    } else {
        virtio_queue_set_last_avail_idx(vdev, idx, state.num);

Thansk

> Communicate that the backend
> cannot suspend so vhost.c can print a better error message?
>
> Thanks!
>
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> >  hw/virtio/vhost-vdpa.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index b3094e8a8b..ae176c06dd 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vhost=
_dev *dev,
> >          return 0;
> >      }
> >
> > -    if (!v->suspended) {
> > +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!v->=
suspended)) {
> >          /*
> >           * Cannot trust in value returned by device, let vhost recover=
 used
> >           * idx from guest.
> > --
> > 2.39.1
> >
>


