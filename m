Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C428A74DE5F
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:42:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwkJ-0004rF-Nq; Mon, 10 Jul 2023 15:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIwkI-0004oM-4j
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIwkG-0003Gn-Fj
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689018027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DwQ5wQQLhXxhY1Oy4FpllmVxZpS53IC9wFjx6Kck8k=;
 b=EkjVbv2NRcXsplWOIHcJPFxdwcfV55yp79Xp77l/q7n/UASg50kgawnAT7ew9Hg1aFGdDY
 NhUrJnNww61Z8YRY7WE8HRkPeQ9Eaei0kEg4Z/i2zHzEXPoXi32FYnmjYMo4z438QiGygK
 W63DK/oSAzMY4EQJE7k5PmLsMR8qNUE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-a4fmsTxGM6qKJ-KhRdeSEg-1; Mon, 10 Jul 2023 15:40:26 -0400
X-MC-Unique: a4fmsTxGM6qKJ-KhRdeSEg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbdde92299so28507755e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689018024; x=1691610024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DwQ5wQQLhXxhY1Oy4FpllmVxZpS53IC9wFjx6Kck8k=;
 b=e86cCfLnqb7u/pELKbZtb7eMq1gQ+o+Xs+CDdzH4RZoDARrdBTxD9Gl/rTTZGuYygj
 ++VDA/Xsnf6218sA+I6EEjLUysmzMb/HjsrTRZw5V37Iyqor5sEb9+6Ms9neOCixJ64Z
 aNOmW4vubxlIoODdQ7b7qbG0WExa/e2xICdra0SZ5XyTNGc3Sdw4IztiJ4ruNXoyWM1f
 Jp4CmI/lBRTp1m7tSkJPtQ+dxK36EvXzhAc9nIQ+qy+JXSJbjtbnMS9Ri+oBxYAjAoKD
 D4R3JbJKIHozbXjmgLYgnupVHQwLQDGNcddFJZe6TSu84mEp2E2ygq28IjH8LiRA9w0i
 wHoA==
X-Gm-Message-State: ABy/qLZKCsMnBD83/r2zpT1lgVn7lezGblwdLSea3nSdsgliFRAwAheL
 HTFoRiFYphScQB5UCW8ux13Ylnr7Lc9tzUKYvSTixqKaymkKzEe9hLw4SWM8fS2scHxrJ16WX8S
 4DAWibr+HChMsIulg6vrV9y4=
X-Received: by 2002:a5d:61cc:0:b0:313:fce9:c568 with SMTP id
 q12-20020a5d61cc000000b00313fce9c568mr8013140wrv.31.1689018024623; 
 Mon, 10 Jul 2023 12:40:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFkCS9frfL5ZzUNeq7sFv2iAdm0NqYGCW80K4oKYOjhXbEL+9rxzB41EyJ0miWU5et8eWzePg==
X-Received: by 2002:a5d:61cc:0:b0:313:fce9:c568 with SMTP id
 q12-20020a5d61cc000000b00313fce9c568mr8013121wrv.31.1689018024291; 
 Mon, 10 Jul 2023 12:40:24 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 m15-20020adfdc4f000000b003142ea7a661sm248222wrj.21.2023.07.10.12.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 12:40:23 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:40:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <20230710153942-mutt-send-email-mst@kernel.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705071523.15496-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
> This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> 
> That commit causes several problems in Linux as described in the BZ.
> In particular, after a while, other devices on the bus are no longer
> usable even if those devices are not affected by the hotunplug.
> This may be a problem in Linux, but we have not been able to identify
> it so far. So better to revert this patch until we find a solution.
> 
> Also, Oracle, which initially proposed this patch for a problem with
> Solaris, seems to have already reversed it downstream:
>     https://linux.oracle.com/errata/ELSA-2023-12065.html
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> Cc: qemu-stable@nongnu.org
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

Seems safest to revert, but I'll let storage guys decide whether to
queue this.

> ---
>  include/hw/scsi/scsi.h |  1 -
>  hw/scsi/scsi-bus.c     | 18 ------------------
>  hw/scsi/virtio-scsi.c  |  2 --
>  3 files changed, 21 deletions(-)
> 
> diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> index e2bb1a2fbf..7c8adf10b1 100644
> --- a/include/hw/scsi/scsi.h
> +++ b/include/hw/scsi/scsi.h
> @@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>                                        BlockdevOnError rerror,
>                                        BlockdevOnError werror,
>                                        const char *serial, Error **errp);
> -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
>  void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
>  
>  SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
> diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> index f80f4cb4fc..42a915f8b7 100644
> --- a/hw/scsi/scsi-bus.c
> +++ b/hw/scsi/scsi-bus.c
> @@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
>      return (sense.asc << 8) | sense.ascq;
>  }
>  
> -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
> -{
> -    int prec1, prec2;
> -    if (sense.key != UNIT_ATTENTION) {
> -        return;
> -    }
> -
> -    /*
> -     * Override a pre-existing unit attention condition, except for a more
> -     * important reset condition.
> -     */
> -    prec1 = scsi_ua_precedence(bus->unit_attention);
> -    prec2 = scsi_ua_precedence(sense);
> -    if (prec2 < prec1) {
> -        bus->unit_attention = sense;
> -    }
> -}
> -
>  void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
>  {
>      int prec1, prec2;
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 45b95ea070..1f56607100 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>  
>          virtio_scsi_acquire(s);
>          virtio_scsi_push_event(s, &info);
> -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>          virtio_scsi_release(s);
>      }
>  }
> @@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>      if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>          virtio_scsi_acquire(s);
>          virtio_scsi_push_event(s, &info);
> -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>          virtio_scsi_release(s);
>      }
>  }
> -- 
> 2.41.0


