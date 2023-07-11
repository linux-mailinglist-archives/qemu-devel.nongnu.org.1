Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D688A74F697
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJGpW-0006er-O2; Tue, 11 Jul 2023 13:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJGpK-0006e2-Ov
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qJGpJ-0002Xp-1N
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 13:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689095218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOdGGvbgcEuFz4AAMb4r9LISXx5jZgrZnx83pOkOCq8=;
 b=h90eCP4vCWpbVs/iPJtzqPgFyjKunG/wpeZd9P4IjPcdYZkHDGi9PIremPxyGES8kDxCGW
 pNlitC5wYx2eHAil5c6wlcd5DlNhs2eDLJ4JaAWEtFQQvAWqqcWW3gBJHHHf44uwGg0iiO
 ZGKaQKbf3Odzx+FpOLwGaKSCj5MES9A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-iNNLWb8UNrOpUxQdOiTs2A-1; Tue, 11 Jul 2023 13:06:44 -0400
X-MC-Unique: iNNLWb8UNrOpUxQdOiTs2A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31455dcc30eso3715583f8f.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 10:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689095191; x=1691687191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOdGGvbgcEuFz4AAMb4r9LISXx5jZgrZnx83pOkOCq8=;
 b=VjDn3K9ZVKgOnETXqMujCKCeIaxqqJT+rdkn51L9upKk40MTVIyMbigITjEuf0wgzD
 fKG7+toVWNtK0+fT2IPvvQZt6xiK4fvaq8D0tM7lkgypAx2MWpiUzSwhz0HQ1RW4zhxh
 h2ilx9qQ3l2IngBNKf3jVl7Z0a3lenPx/cwZpODWDhSfmxBMbQ+udzRNyLcnnmq6TLSx
 qbpuSpguKEBvuQHmqHpa6cl3sFEjgMi3+x3Y6t5qMt7Hn7UxiQNEE1l4jm9pYLtmKbG8
 q4QeHfvgVuwLrYN2M7Urw6JTYIYyW4zKMpDCGqhgKIh5puDRCOQM7AQMbO0oybNIzQHQ
 C1FQ==
X-Gm-Message-State: ABy/qLYSUXsoEdEBy2pboPZzTU0DrnJD/v8w9yOc+wlFR1qMtYdUJO1g
 bYsCuQLASzi0h0Rgn51NSPuHj1pAKFyvJNlBQS57OtDM72SaYet126Z04Pw9C2bBntYoD0X6Fif
 i69xL0nX7jbzKcaM=
X-Received: by 2002:a5d:65c8:0:b0:313:f5f8:b6d2 with SMTP id
 e8-20020a5d65c8000000b00313f5f8b6d2mr18131725wrw.48.1689095190855; 
 Tue, 11 Jul 2023 10:06:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE4vldYHOEvF7yZeJDgvQ0MibxJ3P7oVV4GCN4fn2ayrZQmDQr5Qk1k5wke7DG9oGRZbK24/w==
X-Received: by 2002:a5d:65c8:0:b0:313:f5f8:b6d2 with SMTP id
 e8-20020a5d65c8000000b00313f5f8b6d2mr18131698wrw.48.1689095190447; 
 Tue, 11 Jul 2023 10:06:30 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-6.retail.telecomitalia.it.
 [82.53.134.6]) by smtp.gmail.com with ESMTPSA id
 j3-20020a170906278300b00988a0765e29sm1387559ejc.104.2023.07.11.10.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 10:06:29 -0700 (PDT)
Date: Tue, 11 Jul 2023 19:06:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, 
 Mark Kanda <mark.kanda@oracle.com>, Jason Wang <jasowang@redhat.com>, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 virtualization@lists.linux-foundation.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
References: <20230705071523.15496-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230705071523.15496-1-sgarzare@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
since I found a few things in the virtio-scsi driver...

FYI we have seen that Linux has problems with a QEMU patch for the
virtio-scsi device (details at the bottom of this email in the revert
commit message and BZ).


This is what I found when I looked at the Linux code:

In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
(sshdr->asc == 0x3f && sshdr->ascq == 0x0e).

When `sdev_target->expecting_lun_change = 1` is set and we call
scsi_check_sense(), for example to check the next UNIT ATTENTION, it
will return NEEDS_RETRY, that I think will cause the issues we are
seeing.

`sdev_target->expecting_lun_change` is reset only in
scsi_decide_disposition() when `REPORT_LUNS` command returns with
SAM_STAT_GOOD.
That command is issued in scsi_report_lun_scan() called by
__scsi_scan_target(), called for example by scsi_scan_target(),
scsi_scan_host(), etc.

So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
send also the UNIT ATTENTION.

In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
(hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
command to the device. This does not happen for
VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
UNIT ATTENTION from the hotunplug in QEMU, everything works well.

So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index bd5633667d01..c57658a63097 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -291,6 +291,7 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
                 }
                 break;
         case VIRTIO_SCSI_EVT_RESET_REMOVED:
+               scsi_scan_host(shost);
                 sdev = scsi_device_lookup(shost, 0, target, lun);
                 if (sdev) {
                         scsi_remove_device(sdev);

This somehow helps, now linux only breaks if the plug/unplug frequency
is really high. If I put a 5 second sleep between plug/unplug events, it
doesn't break (at least for the duration of my test which has been
running for about 30 minutes, before it used to break after about a
minute).

Another thing I noticed is that in QEMU maybe we should set the UNIT
ATTENTION first and then send the event on the virtqueue, because the
scan should happen after the unit attention, but I don't know if in any
case the unit attention is processed before the virtqueue.

I mean something like this:

diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 45b95ea070..13db40f4f3 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1079,8 +1079,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
          };

          virtio_scsi_acquire(s);
-        virtio_scsi_push_event(s, &info);
          scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
+        virtio_scsi_push_event(s, &info);
          virtio_scsi_release(s);
      }
  }
@@ -1111,8 +1111,8 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,

      if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
          virtio_scsi_acquire(s);
-        virtio_scsi_push_event(s, &info);
          scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
+        virtio_scsi_push_event(s, &info);
          virtio_scsi_release(s);
      }
  }

At this point I think the problem is on the handling of the
VIRTIO_SCSI_EVT_RESET_REMOVED event in the virtio-scsi driver, where
somehow we have to redo the bus scan, but scsi_scan_host() doesn't seem
to be enough when the event rate is very high.

I don't know if along with this fix, we also need to limit the rate in
QEMU somehow.

Sorry for the length of this email, but I'm not familiar with SCSI and
wanted some suggestions on how to proceed.

Paolo, Stefan, Linux SCSI maintainers, any suggestion?


Thanks,
Stefano

On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
>This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
>
>That commit causes several problems in Linux as described in the BZ.
>In particular, after a while, other devices on the bus are no longer
>usable even if those devices are not affected by the hotunplug.
>This may be a problem in Linux, but we have not been able to identify
>it so far. So better to revert this patch until we find a solution.
>
>Also, Oracle, which initially proposed this patch for a problem with
>Solaris, seems to have already reversed it downstream:
>    https://linux.oracle.com/errata/ELSA-2023-12065.html
>
>Suggested-by: Thomas Huth <thuth@redhat.com>
>Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
>Cc: qemu-stable@nongnu.org
>Cc: Mark Kanda <mark.kanda@oracle.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/hw/scsi/scsi.h |  1 -
> hw/scsi/scsi-bus.c     | 18 ------------------
> hw/scsi/virtio-scsi.c  |  2 --
> 3 files changed, 21 deletions(-)
>
>diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
>index e2bb1a2fbf..7c8adf10b1 100644
>--- a/include/hw/scsi/scsi.h
>+++ b/include/hw/scsi/scsi.h
>@@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
>                                       BlockdevOnError rerror,
>                                       BlockdevOnError werror,
>                                       const char *serial, Error **errp);
>-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
> void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
>
> SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
>diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
>index f80f4cb4fc..42a915f8b7 100644
>--- a/hw/scsi/scsi-bus.c
>+++ b/hw/scsi/scsi-bus.c
>@@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
>     return (sense.asc << 8) | sense.ascq;
> }
>
>-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
>-{
>-    int prec1, prec2;
>-    if (sense.key != UNIT_ATTENTION) {
>-        return;
>-    }
>-
>-    /*
>-     * Override a pre-existing unit attention condition, except for a more
>-     * important reset condition.
>-     */
>-    prec1 = scsi_ua_precedence(bus->unit_attention);
>-    prec2 = scsi_ua_precedence(sense);
>-    if (prec2 < prec1) {
>-        bus->unit_attention = sense;
>-    }
>-}
>-
> void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
> {
>     int prec1, prec2;
>diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
>index 45b95ea070..1f56607100 100644
>--- a/hw/scsi/virtio-scsi.c
>+++ b/hw/scsi/virtio-scsi.c
>@@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>
>         virtio_scsi_acquire(s);
>         virtio_scsi_push_event(s, &info);
>-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>         virtio_scsi_release(s);
>     }
> }
>@@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>         virtio_scsi_acquire(s);
>         virtio_scsi_push_event(s, &info);
>-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
>         virtio_scsi_release(s);
>     }
> }
>-- 
>2.41.0
>


