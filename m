Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B8376F3C9
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 22:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qReWr-0005C2-G5; Thu, 03 Aug 2023 16:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReWp-0005B9-45
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReWl-00017e-Ak
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691092950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zQDovkt9xNu1DbpTrJFS/0eEus0OaIWwzX719Fnag9A=;
 b=Tb3OxD1Eqc/dI/MMesyZiKAUk0En3b42MQoq8m9VJBZFnVEU4I/NcoKWz283kDhYkyWuOl
 y6OU6ypoa0ORpTBrjUI4HbMln/BVQ6jnh5OR+n23iR+qLN9lqWATKY6dNg3sIcCcfvuU/I
 Shw7dcxsWEN4RE8oEkM0fEA5o+X1LHo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-YWpWMFxcNHKlAvG54Avx-w-1; Thu, 03 Aug 2023 16:02:28 -0400
X-MC-Unique: YWpWMFxcNHKlAvG54Avx-w-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bfe6a531bso125189966b.1
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 13:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691092947; x=1691697747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQDovkt9xNu1DbpTrJFS/0eEus0OaIWwzX719Fnag9A=;
 b=bREoFU8C1XjIOb9bBJAu/XiYFIQhNOqiSY+N/tt1Z3e4mVbG7cP95bb9OkrSyZjN8H
 KzuIwNElnysjM76giHh6k+NYjJDcpN2gmiMimf/u91/v9kssp0Cni8PrnnDUUOkxBzLM
 +yRZ2mHyo45StiUuo+hrLfIkFHabTztWJtyoLmRX7DieYg2trddjUMgDn+KmzXG/JxG2
 EwVoomaGaOqOiuAFU3Zg2t72dpaWIplyHQx5LmsUXw+MiJW9OPyKa/2ekMY8A5089Ui8
 Dt/KxsyVKSQ/DLjm8amqN0fXbWtFytyyCL/W8/RbTBX6p3N7MWcfS6aU+qFONS0sAgDO
 0iwg==
X-Gm-Message-State: ABy/qLbqYTdkYhJyrzYHZCgtuyrc871R9ff2piVvsYqx5ujklg8Qb1Pa
 PTQh7/F5EIMgdZexnX7B/M0mRKMzw7VWiXMOa7g1GRkO+rmzsmjcpDuKqIe+PBpCvSS2pOUf3MZ
 qH06qpTkUEIa/dW4=
X-Received: by 2002:a17:906:9bc4:b0:994:34a6:50cf with SMTP id
 de4-20020a1709069bc400b0099434a650cfmr8510648ejc.49.1691092947279; 
 Thu, 03 Aug 2023 13:02:27 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE9ctPgCZ/P1O/VzAzbm5oD7RX28rFb72H/YEBEKaOdYEsEW2x6SuYsRgSc5DKvMoe8dt3ywQ==
X-Received: by 2002:a17:906:9bc4:b0:994:34a6:50cf with SMTP id
 de4-20020a1709069bc400b0099434a650cfmr8510628ejc.49.1691092946958; 
 Thu, 03 Aug 2023 13:02:26 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 pv10-20020a170907208a00b00977eec7b7e8sm252237ejb.68.2023.08.03.13.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 13:02:26 -0700 (PDT)
Date: Thu, 3 Aug 2023 16:02:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <20230803160101-mutt-send-email-mst@kernel.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705071523.15496-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

scsi maintainers, what should be done about this patch?
we don't want a regression in the release ...
revert for now and think what's the right thing to do is
after the release?


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


