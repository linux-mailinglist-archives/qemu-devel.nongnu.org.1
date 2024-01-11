Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BE82A8E3
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:18:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqGB-00070h-N3; Thu, 11 Jan 2024 03:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqGA-00070Y-9o
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rNqG8-0000TD-46
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704961070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JH0ggIt+9t2t3k2wxQ5TXL39mrGGiv50mFwT4t11ZrA=;
 b=e1vPC7E8pK256OW+PeZW/bLiepAzvUYfwYlMy5b7xs9nqcoQGetzrsgDJncfcBEF6v3Vj5
 QikRakhfH6kfufmKOU+6EvN9bRtJVOTIOvFMDQtSuthxvhcwOY4xEWbfjhjY8siVTUB0Mv
 nHnwB9qzkicUHgYAqAvUcbeAxAEbpA8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-cijW_WYHOcq0HgY6UAg0Ow-1; Thu, 11 Jan 2024 03:17:49 -0500
X-MC-Unique: cijW_WYHOcq0HgY6UAg0Ow-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6d9bd2deabfso2960103b3a.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:17:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704961068; x=1705565868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JH0ggIt+9t2t3k2wxQ5TXL39mrGGiv50mFwT4t11ZrA=;
 b=advoaGiKolVOGmjfZ1sJSnKuyC95v3csRctFpcrVOcxzdswHCtk6Zi6/gsSBNBkBj6
 BZzUS5za3XGNLLgpochGpdpIG88JuS2FstKRKlP6LWIAycUXy+/xHgsVDIyvHjbpW+dP
 kWjw/HJKteSsFGJhYiI6wzqOiTMAgvG5yTD5vXaIccAjEPWUGg41wQNUmPtqjiwfWTLE
 uQx8jpTziiq4DJXUoJB0R6MQdnnNVz/RWu2hevKeGCSjo3iatvUkoBIy0m524CCTnft2
 7odIeliY08sukKmDR1g59e0fKlPHRb+Lmy4J9cP9j/+iAq/pYeIs9MMuIsMKfpyO/ZZP
 s6Tg==
X-Gm-Message-State: AOJu0YzceSmMnbQHDDsoUP5BZOCetNRP++tl64yLoiu+BfL3Xb7CpenN
 mco2rBwkU4Cu+YacG7GgIxMjR9MzocG9d+BGJIvDPN3DHaQmTFt35DZNyXGBLVqV6N31o8lSy2m
 wIQAGGo1rPi50eACwfVvjq9UulE4c08kuAZB7w68=
X-Received: by 2002:a05:6a00:928f:b0:6d0:8b0d:b8c6 with SMTP id
 jw15-20020a056a00928f00b006d08b0db8c6mr1138685pfb.34.1704961068327; 
 Thu, 11 Jan 2024 00:17:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrGZIs14BBmAovAHimitjQGnFX/dLVkmJPFFJKfnrHnHvVQALNKdnafHvCGCX/tKIcjpA04zRJgadqBnAUoj4=
X-Received: by 2002:a05:6a00:928f:b0:6d0:8b0d:b8c6 with SMTP id
 jw15-20020a056a00928f00b006d08b0db8c6mr1138651pfb.34.1704961067260; Thu, 11
 Jan 2024 00:17:47 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-17-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-17-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 11 Jan 2024 16:17:36 +0800
Message-ID: <CACGkMEvfzviAsjV8W_4RYN0AdMhcRGq0Z4qbxMt2nUoDya2khQ@mail.gmail.com>
Subject: Re: [PATCH 16/40] vdpa: indicate SVQ switching via flag
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
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

On Fri, Dec 8, 2023 at 2:50=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> svq_switching indicates the case where SVQ mode change
> is on going. Positive (1) means switching from the
> normal passthrough mode to SVQ mode, and negative (-1)
> meaning switch SVQ back to the passthrough; zero (0)
> indicates that there's no SVQ mode switch taking place.

Ok, so the previous patch forgot to describe the zero(0).

And it looks to me we'd better use enum instead of the magic number here.

Thanks

>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  net/vhost-vdpa.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 7b8f047..04718b2 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -320,6 +320,7 @@ static void vhost_vdpa_net_log_global_enable(VhostVDP=
AState *s, bool enable)
>      data_queue_pairs =3D n->multiqueue ? n->max_queue_pairs : 1;
>      cvq =3D virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ) ?
>                                    n->max_ncs - n->max_queue_pairs : 0;
> +    v->shared->svq_switching =3D enable ? 1 : -1;
>      /*
>       * TODO: vhost_net_stop does suspend, get_base and reset. We can be =
smarter
>       * in the future and resume the device if read-only operations betwe=
en
> @@ -332,6 +333,7 @@ static void vhost_vdpa_net_log_global_enable(VhostVDP=
AState *s, bool enable)
>      if (unlikely(r < 0)) {
>          error_report("unable to start vhost net: %s(%d)", g_strerror(-r)=
, -r);
>      }
> +    v->shared->svq_switching =3D 0;
>  }
>
>  static void vdpa_net_migration_state_notifier(Notifier *notifier, void *=
data)
> --
> 1.8.3.1
>


