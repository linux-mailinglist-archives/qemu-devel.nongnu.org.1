Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE81817435
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 15:51:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFEwI-0004pz-E7; Mon, 18 Dec 2023 09:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rFEwC-0004pp-1s
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rFEw9-0004ZK-SC
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702910980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrLzWrW4smtE2Hxz/bSsmgYfxashVY6KsR/kYk5revk=;
 b=LET0R40zIogJBCvinUwwbNETi9V8e98lkQ4mj2wSf6X0bVgWrn08f9zVYz0LFwd3aknsCA
 FRsQlRKiDKfMUjeCBmWi3Kt/U1adFRmsWa4russcjNpAm48skX8iPycpw50KgzwnCmMyqs
 MG9ULBfsPNwSo3xjscKGk17FxEPe/iY=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-s3Z84ZYaNSyHa-y600dONQ-1; Mon, 18 Dec 2023 09:49:37 -0500
X-MC-Unique: s3Z84ZYaNSyHa-y600dONQ-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7cb9fd757adso381199241.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702910976; x=1703515776;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrLzWrW4smtE2Hxz/bSsmgYfxashVY6KsR/kYk5revk=;
 b=Uw0lBbDUmJq99XcBuIPT5/c3NLYq7y7x51pXX72jKznY9I/65whv4uEvBZara/KIuT
 lQwZLqB+3HQJjucsbEkTTGflwRgl8zfPCdBM3pPBYiZskGS9KbMTBaGZZmhOO4KSZj6M
 3t3VQagllJdjvsucEU3CInaDxZ/2+jdjhu4ddGMAMjA1sJh3Sb2LJbewd3o/n6A3mT7q
 HTqasJak7Q+5DfJeYOWIBiRUmKe9kH2GWmcQ11t8JprOpb5c4gUEZKdu1YqqQYSyubtu
 FsDP27rPos7ExiewK9WH59L8bPmZ6/8F+7b0kvITvG+NdMTgwEJ5Uu5CVG4WgwJM/MqM
 HUEw==
X-Gm-Message-State: AOJu0YzjEHkfLSoifT5uu27lMmTMgjmOmW5sHthSwsSG7YWMzaNs6ImL
 /gnGw0dIRTeWpVpNrFD8km9o5ouDJe3q7uIUZ6uPFfsiDUGuhxM9OP5J0hCvr6/68jRTfDujEG2
 MNUXXjYpbq3rF5gajYYboWprG/DqhVEw=
X-Received: by 2002:a1f:ee8b:0:b0:4b6:c810:ab7e with SMTP id
 m133-20020a1fee8b000000b004b6c810ab7emr748846vkh.28.1702910976672; 
 Mon, 18 Dec 2023 06:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfJnHvV/96Xgiw+KR+im4gh/PAqRWVwYk7RQsfOIJY33xfguch1aazMR6vmeNDBcPABXb6/BklEG3hFMWcHhs=
X-Received: by 2002:a1f:ee8b:0:b0:4b6:c810:ab7e with SMTP id
 m133-20020a1fee8b000000b004b6c810ab7emr748840vkh.28.1702910976424; Mon, 18
 Dec 2023 06:49:36 -0800 (PST)
MIME-Version: 1.0
References: <20231213211544.1601971-1-stefanha@redhat.com>
 <ba257408-5fb2-41d3-8b43-297ebcd312ea@proxmox.com>
 <20231214195352.GB1645604@fedora>
 <61c149da-ee22-418b-8575-b128b6836e38@proxmox.com>
In-Reply-To: <61c149da-ee22-418b-8575-b128b6836e38@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Dec 2023 15:49:24 +0100
Message-ID: <CABgObfZn4snAzgPhWV_8tJ8DEU4hw_Hc7EDa9wrPTvqe3+jWyg@mail.gmail.com>
Subject: Re: [RFC 0/3] aio-posix: call ->poll_end() when removing AioHandler
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.083,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 18, 2023 at 1:41=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
> I think it's because of nested drains, because when additionally
> checking that the drain count is zero and only executing the loop then,
> that issue doesn't seem to manifest

But isn't virtio_scsi_drained_end only run if bus->drain_count =3D=3D 0?

    if (bus->drain_count-- =3D=3D 1) {
        trace_scsi_bus_drained_end(bus, sdev);
        if (bus->info->drained_end) {
            bus->info->drained_end(bus);
        }
    }

Paolo

>
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 9c751bf296..d22c586b38 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -1164,9 +1164,13 @@ static void virtio_scsi_drained_end(SCSIBus *bus=
)
> >          return;
> >      }
> >
> > -    for (uint32_t i =3D 0; i < total_queues; i++) {
> > -        VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > -        virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> > +    if (s->bus.drain_count =3D=3D 0) {
> > +        for (uint32_t i =3D 0; i < total_queues; i++) {
> > +            VirtQueue *vq =3D virtio_get_queue(vdev, i);
> > +            virtio_queue_set_notification(vq, 1);
> > +            virtio_queue_notify(vdev, i);
> > +            virtio_queue_aio_attach_host_notifier(vq, s->ctx);
> > +        }
> >      }
> >  }
> >
>
> Best Regards,
> Fiona
>


