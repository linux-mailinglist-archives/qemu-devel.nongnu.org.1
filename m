Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C72747E10
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 09:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGwjl-0005HQ-QE; Wed, 05 Jul 2023 03:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qGwjg-0005Gf-Ok
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:15:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qGwje-0003WG-LB
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 03:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688541333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7R0sZB+JneRtfun5KKR7NBgUvJmWzVAf9Vqm9UdmAJ8=;
 b=Fk8XzvBql2wzCUilBj9CkQ8HKTopVrsrezsqZ8IFgyZtAneVCVdh1vkOhXTvgJCEFmM95m
 Q5YapaYnP/MAmUymyynZ7gIqTk0N2ETXOG/bQd/fJkYGT419KCiWDrrXMLC9FtRwMfqGtR
 +ZXY4REd4EjDi4PPzKUhSn6dc/0RYB8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-JW1dyaWRPAuumOP5XwHo7w-1; Wed, 05 Jul 2023 03:15:32 -0400
X-MC-Unique: JW1dyaWRPAuumOP5XwHo7w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-514b3b99882so3687631a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 00:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688541331; x=1691133331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7R0sZB+JneRtfun5KKR7NBgUvJmWzVAf9Vqm9UdmAJ8=;
 b=Ul6rqjNhhkx65v8mBBMfIU0F7qe6sz1S4qRT/FwgchN4cJ6YF+m/A6MlEeRrD/TQo4
 BlP5a5OinsTVTjB+EmHXH7x8cVAGb4HmgBChUBkufcTTmog7Dtmi0NPjrdABCsGpE1Z9
 Rjizwr4chlR9DfnzKgNYAFWqLoH1Ba7A1gzObJwVDiTGw7mPfGr+BhNZKRYrZC5/pQan
 lJCIdXTenRZrNzUXb63XiUK6GHBLmjGoS8mdUVWUNp54XCaKCphjktKVIK+H+tNNaLO1
 +EwADWE2rEQhWW6Rmoa3MWZaqSB0/g71oyhS6241TI4s2THnN/RtK/N5GY5JafCbAKGN
 URkg==
X-Gm-Message-State: ABy/qLZjZJOuo6k0VYAWPVGV1iqRDVJrATXnWrnIBBte0p97lZCMSr4x
 7fQ+LN0haGIO1eRKxe/00JKr3Gi4MgOmInXsyRM96VnA8BLAX6ttonrPJbx4pVh34mPqd60Ua0W
 M2T8NgSRJHcgzdsZ9ehCxUyUjKt7F8w8ZaEuz9QiQUGex0Csdy49a35cV/sG2hozPWIVfH7j2wF
 w=
X-Received: by 2002:aa7:c453:0:b0:51e:d3d:6498 with SMTP id
 n19-20020aa7c453000000b0051e0d3d6498mr6724599edr.10.1688541331135; 
 Wed, 05 Jul 2023 00:15:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+IXDCqGOGPbGPySPYJi2tqGewmIULI6JIJoPxGDeT4ueRQpgeDduN/MxbDAIiJo2E2Ed2Zw==
X-Received: by 2002:aa7:c453:0:b0:51e:d3d:6498 with SMTP id
 n19-20020aa7c453000000b0051e0d3d6498mr6724575edr.10.1688541330814; 
 Wed, 05 Jul 2023 00:15:30 -0700 (PDT)
Received: from localhost.localdomain
 (host-79-46-200-163.retail.telecomitalia.it. [79.46.200.163])
 by smtp.gmail.com with ESMTPSA id
 b15-20020aa7dc0f000000b0051a1ef536c9sm12470131edu.64.2023.07.05.00.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 00:15:30 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefano Garzarella <sgarzare@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org,
 Mark Kanda <mark.kanda@oracle.com>
Subject: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense data
 upon disk hotplug events"
Date: Wed,  5 Jul 2023 09:15:23 +0200
Message-ID: <20230705071523.15496-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.

That commit causes several problems in Linux as described in the BZ.
In particular, after a while, other devices on the bus are no longer
usable even if those devices are not affected by the hotunplug.
This may be a problem in Linux, but we have not been able to identify
it so far. So better to revert this patch until we find a solution.

Also, Oracle, which initially proposed this patch for a problem with
Solaris, seems to have already reversed it downstream:
    https://linux.oracle.com/errata/ELSA-2023-12065.html

Suggested-by: Thomas Huth <thuth@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
Cc: qemu-stable@nongnu.org
Cc: Mark Kanda <mark.kanda@oracle.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/hw/scsi/scsi.h |  1 -
 hw/scsi/scsi-bus.c     | 18 ------------------
 hw/scsi/virtio-scsi.c  |  2 --
 3 files changed, 21 deletions(-)

diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
index e2bb1a2fbf..7c8adf10b1 100644
--- a/include/hw/scsi/scsi.h
+++ b/include/hw/scsi/scsi.h
@@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
                                       BlockdevOnError rerror,
                                       BlockdevOnError werror,
                                       const char *serial, Error **errp);
-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
 void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
 
 SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index f80f4cb4fc..42a915f8b7 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
     return (sense.asc << 8) | sense.ascq;
 }
 
-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
-{
-    int prec1, prec2;
-    if (sense.key != UNIT_ATTENTION) {
-        return;
-    }
-
-    /*
-     * Override a pre-existing unit attention condition, except for a more
-     * important reset condition.
-     */
-    prec1 = scsi_ua_precedence(bus->unit_attention);
-    prec2 = scsi_ua_precedence(sense);
-    if (prec2 < prec1) {
-        bus->unit_attention = sense;
-    }
-}
-
 void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
 {
     int prec1, prec2;
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 45b95ea070..1f56607100 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, &info);
-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
         virtio_scsi_release(s);
     }
 }
@@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
         virtio_scsi_acquire(s);
         virtio_scsi_push_event(s, &info);
-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
         virtio_scsi_release(s);
     }
 }
-- 
2.41.0


