Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBD727A73
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 10:51:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7BLi-0006aO-Hr; Thu, 08 Jun 2023 04:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7BLZ-0006a1-Cv
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:50:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q7BLX-0008Ru-Rb
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 04:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686214218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWRp37LPczLpOogERFiDJF5HGL/KXgRy/Y9Dq1Ac8qk=;
 b=Rg8yJbvenCaGYqkejYdVNJW+1IQaGFgAPIPeuXIU+NqfnolJDLfgpHOGQSSj3TRkjFNjyC
 EmkWgWDs3V9b5so4inJzaw6aBP56pikhV97xXQP0hvjVUwUrNQiQBkv8G4MX0l3JjoMYg+
 zq4fuaIkRECpr2cXLm6kaP2t9tZubfQ=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-FmKIIWIWMkCHBvyxuQNr1g-1; Thu, 08 Jun 2023 04:50:17 -0400
X-MC-Unique: FmKIIWIWMkCHBvyxuQNr1g-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-569fee67d9dso9572017b3.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 01:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686214217; x=1688806217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mWRp37LPczLpOogERFiDJF5HGL/KXgRy/Y9Dq1Ac8qk=;
 b=SncDsUH6MiBEe3Lit5HkSW2+uwb5AOwqxFBcWYzTWOg8uvmJRZwaL9vrpp9OeoQdTJ
 y2U8sL6S0JRlOoib2G7Daeg5VXv2VBNwhDFzWIr2kLRnuUXs/pSjkX1XhxjTK9g94bXo
 1u+cDdd6xmypMPNeuGVXlFdZeBnFpi4sBE+GiDcqxVMrChDcvSt9+yWjJ6UdyByc8YUO
 9wSZfgYxPfWjmNg4US5vkmcZW01xonajrSzKjq0etlsLOWYkYlkJZVQdNA9+wNNTMfcV
 jzgoR4rZictwGbC1iUo0/G/aMTPVjAA0UrbfVNjAPlUvjOzfwhyhYW3EQhccBU4zLa/k
 iUUg==
X-Gm-Message-State: AC+VfDz8h9TdqlvNtKNSsPYvb7oVfk4kwu5Cx1HIMEaZqZiCTPpdyyqa
 5dM0NQuh8Rgho4fsHDMJ4DACIju1U2DOBAmLvbxSGbhVCOLcPeUwxexpvKp8qY5jZgm07/aun67
 UmPK8K+/2CtOh2jhTtQNC5GxiBEHCw1k=
X-Received: by 2002:a0d:cc4d:0:b0:569:e9c6:5ca3 with SMTP id
 o74-20020a0dcc4d000000b00569e9c65ca3mr1738667ywd.4.1686214216864; 
 Thu, 08 Jun 2023 01:50:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4wFln/2uZsQGaHEONmbepkXLo6BWghv+tD6ck/1w6NXzxLYNd253+LgpFYHsP7vBKkhUFLxYGQ3chW2ruZGeg=
X-Received: by 2002:a0d:cc4d:0:b0:569:e9c6:5ca3 with SMTP id
 o74-20020a0dcc4d000000b00569e9c65ca3mr1738660ywd.4.1686214216624; Thu, 08 Jun
 2023 01:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230607170842.488489-1-lingshan.zhu@intel.com>
 <CAJaqyWdQRDb=cev7LUXKiK9-gBhB2CY7fmcT-M+pdjgb29qDcw@mail.gmail.com>
 <65fd10d6-2ede-3e91-4356-36623b53db5a@intel.com>
In-Reply-To: <65fd10d6-2ede-3e91-4356-36623b53db5a@intel.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 8 Jun 2023 10:49:40 +0200
Message-ID: <CAJaqyWfgeN1u97z5W0Z6cCrJYrZBRV1p9je3_DoOv2XghY9XTw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: dont check vhost_vdpa->suspended when unsupported
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Thu, Jun 8, 2023 at 9:07=E2=80=AFAM Zhu, Lingshan <lingshan.zhu@intel.co=
m> wrote:
>
>
>
> On 6/7/2023 9:51 PM, Eugenio Perez Martin wrote:
> > On Wed, Jun 7, 2023 at 11:09=E2=80=AFAM Zhu Lingshan <lingshan.zhu@inte=
l.com> wrote:
> >> When read the state of a virtqueue, vhost_vdpa need
> >> to check whether the device is suspended.
> >>
> >> This commit verifies whether VHOST_BACKEND_F_SUSPEND is
> >> negotiated when checking vhost_vdpa->suspended.
> >>
> > I'll add: Otherwise, qemu prints XXX error message.
> >
> > On second thought, not returning an error prevents the caller
> > (vhost.c:vhost_virtqueue_stop) from recovering used idx from the
> > guest.
> >
> > I'm not sure about the right fix for this, should we call
> > virtio_queue_restore_last_avail_idx here? Communicate that the backend
> > cannot suspend so vhost.c can print a better error message?
> I agree it is better not to return an error.
>
> Instead if neither the device does not support _F_SUSPEND nor failed to
> suspend,
> I think vhost_vdpa should try to read the last_avail_idx from
> the device anyway. We can print an error message here,
> like: failed to suspend, the value may not reliable.
>

We need to drop that value if it is not reliable. If the device keeps
using descriptors, used_idx may increase beyond avail_idx, so the
usual is to just restore whatever used_idx value the guest had at
stop.

Thanks!

> Thanks
> >
> > Thanks!
> >
> >> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> >> ---
> >>   hw/virtio/vhost-vdpa.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index b3094e8a8b..ae176c06dd 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -1397,7 +1397,7 @@ static int vhost_vdpa_get_vring_base(struct vhos=
t_dev *dev,
> >>           return 0;
> >>       }
> >>
> >> -    if (!v->suspended) {
> >> +    if ((dev->backend_cap & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) && (!v-=
>suspended)) {
> >>           /*
> >>            * Cannot trust in value returned by device, let vhost recov=
er used
> >>            * idx from guest.
> >> --
> >> 2.39.1
> >>
>


