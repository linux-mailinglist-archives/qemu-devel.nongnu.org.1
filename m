Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE8376F384
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 21:38:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRe7w-00036Z-9Z; Thu, 03 Aug 2023 15:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRe7u-000367-99
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:36:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRe7s-00056e-EZ
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691091407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JaM2CDekX7tdkxIIMGOM4GxifmZH6XfI8qdJdXy4Emc=;
 b=YlF1tecMX6mqc6FdzRIMhVE/VgBdpUyTu/T2CJzz7Nos/1v24SDpxpuP3Me1IliqUlcRPG
 F3sNYujnkMRdg83w4/gU6dDBeXQ3CNvArJbkKPy5duasPYwZ3Zmqrgn4erXQ2LlIZhpljj
 L8afmAP0Xxh80oClza49zvfWxcZUgM4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-A3eMfC6VMJqFmDDjGR-DwQ-1; Thu, 03 Aug 2023 15:36:45 -0400
X-MC-Unique: A3eMfC6VMJqFmDDjGR-DwQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99c20561244so85469966b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 12:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691091404; x=1691696204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaM2CDekX7tdkxIIMGOM4GxifmZH6XfI8qdJdXy4Emc=;
 b=GS6RnBMDxVUip+dtx7wKe1mhYX2nF3xeregk/i9dwyL//VJx48oaeMGKBTnajv3xPW
 a4NIMypfcIpovd2aUIqT/TVQUe32obKYJDDy+9252eGKdJjmAmJp8DSBzQPHnQz/3HP+
 rCDYOomIm4yiWM5Ts4x8jqcBEoZ6U0Vphpc/x2owBLjPBODWcY+nkxOtx3FRygUk446w
 jAui5AP94HK7i+tAPe4ZobT7EFtF+FE6tcANIwW6oXZozdbHAWS8zKtpzScP0FIdxVFX
 aJZv82ze72vXlIb/1uhJcz278nFxQarTxlQKpT8o3R8mbNvabvKZiEFj0Aq+vuVH9gHT
 YIqA==
X-Gm-Message-State: ABy/qLZwW6mxocY6Gyd+G531NGzo+k+bZxcJdVHMSMhuGfffLXx3T2aJ
 wYStrFJGC6LqWcQasFHz4bJfv/n13Qw5U9G/L3bUZh4KXdYrD6cHRT3BVFvF7n5QSzqadtv8OVQ
 khevFujTiKyGJjfU=
X-Received: by 2002:a17:906:77d6:b0:992:b3a3:81f4 with SMTP id
 m22-20020a17090677d600b00992b3a381f4mr9131273ejn.50.1691091404790; 
 Thu, 03 Aug 2023 12:36:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPEj08V4XwXXh5+DIjq4HXBT41s5h92+drG5N8xG37H1lGZX4hB1UKmwWfjc9F+ehi2d0ihg==
X-Received: by 2002:a17:906:77d6:b0:992:b3a3:81f4 with SMTP id
 m22-20020a17090677d600b00992b3a381f4mr9131260ejn.50.1691091404480; 
 Thu, 03 Aug 2023 12:36:44 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 j27-20020a170906255b00b0099297782aa9sm224103ejb.49.2023.08.03.12.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 12:36:43 -0700 (PDT)
Date: Thu, 3 Aug 2023 15:36:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <20230803153628-mutt-send-email-mst@kernel.org>
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

OK guys we are reverting this?

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


