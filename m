Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9F74F767
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 19:43:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJHN3-0005PJ-GX; Tue, 11 Jul 2023 13:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qJHMz-0005OW-7J; Tue, 11 Jul 2023 13:41:49 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qJHMv-0001Sa-Vg; Tue, 11 Jul 2023 13:41:47 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5636ab8240cso3213182eaf.3; 
 Tue, 11 Jul 2023 10:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689097304; x=1691689304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XqwavEubtW11DfezKBW1NY+jd+4AjXNT0PZqqB15Nt8=;
 b=i/6zzX3Bg2TMosmLksrm/UxDzKbRAodFwSPXaH/Vytf0QgUb+80Wu1V8JmVGImV5LN
 UqW3cS/HPgGTnSqq+5ESnms5mlWlOrpNMQBOjQecBdmdh1Qxovd20JgRqOKawY3t9zmR
 8z2rYMuYUOntge5lNy8IseBJ2ChSCyLgER3ClHPXPDG0oOE6oa4GK4VnHU7S42X1Hi4B
 TMzz+5oUZozjyXwv07IZJK2jOZ/I/uSgxO4tTLFJt7TyseewviL/zKqve2XtMJA9ws0o
 ujgREJqUFkaajB6bpb2hMmTVenIDlizLkqJ24PmCXPlK8wxGJF3cqEpoPXWpSksjt4A0
 IReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689097304; x=1691689304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqwavEubtW11DfezKBW1NY+jd+4AjXNT0PZqqB15Nt8=;
 b=FGEBrLiiUX1wVAEgUB5lF0nnzu10HI9f1gV2JomPpyvXDTxIV3SeZZS1yBRmAVn05x
 7rxikLROmwGMNioyHhAn2yGQtuS8Q2Q39oH4QpHdZDq2pD0kXGw/NbjrfwmK40O/gGO7
 PWBFawqEym96IoX7pEgm6ZBRJaanqRCVG5A+Zjd6PT91HCM01k/Q4sTLp7hJaq8N1cd4
 TJNI7puzCutf3/0NiaNp2gz+6Yds8HznQKqDRrkMoMzZjkVAjbt4Uiejoy3+5V+pbwrL
 dVdWHXX5/+JEdXTjyd8rj5rF4CCK1R/Nz6Cb/M4BX9dN6tc/doNFRaMe3ftAVlplVBj/
 3Hjg==
X-Gm-Message-State: ABy/qLYDM+78MQO8WPEhRPlouBtlA9mB97jUwalASqeHTLidnwXvPgWy
 ZnpZ5rPjDe8u5ifWojqRac5BcuBHVVxDIQD7DZ8=
X-Google-Smtp-Source: APBJJlGe64gVAtS1acHTyQl/DOyhaAkZ2zneyvrZc9Qw2Ny+KlNytYjI1BYI0HN9iOBHx77y7dEUQCWTmZDVTl7/DpU=
X-Received: by 2002:a4a:3744:0:b0:563:516e:ae3d with SMTP id
 r65-20020a4a3744000000b00563516eae3dmr9781979oor.6.1689097303762; Tue, 11 Jul
 2023 10:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
In-Reply-To: <i3od362o6unuimlqna3aaedliaabauj6g545esg7txidd4s44e@bkx5des6zytx>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 11 Jul 2023 13:41:31 -0400
Message-ID: <CAJSP0QX5bf1Gp6mnQ0620FS61n=cY6n_ca7O-cAcH7pYCV2frw@mail.gmail.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, 
 Thomas Huth <thuth@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 linux-scsi@vger.kernel.org, 
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-stable@nongnu.org, 
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, 
 "James E.J. Bottomley" <jejb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 11 Jul 2023 at 13:06, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> CCing `./scripts/get_maintainer.pl -f drivers/scsi/virtio_scsi.c`,
> since I found a few things in the virtio-scsi driver...
>
> FYI we have seen that Linux has problems with a QEMU patch for the
> virtio-scsi device (details at the bottom of this email in the revert
> commit message and BZ).
>
>
> This is what I found when I looked at the Linux code:
>
> In scsi_report_sense() in linux/drivers/scsi/scsi_error.c linux calls
> scsi_report_lun_change() that set `sdev_target->expecting_lun_change =
> 1` when we receive a UNIT ATTENTION with REPORT LUNS CHANGED
> (sshdr->asc == 0x3f && sshdr->ascq == 0x0e).
>
> When `sdev_target->expecting_lun_change = 1` is set and we call
> scsi_check_sense(), for example to check the next UNIT ATTENTION, it
> will return NEEDS_RETRY, that I think will cause the issues we are
> seeing.
>
> `sdev_target->expecting_lun_change` is reset only in
> scsi_decide_disposition() when `REPORT_LUNS` command returns with
> SAM_STAT_GOOD.
> That command is issued in scsi_report_lun_scan() called by
> __scsi_scan_target(), called for example by scsi_scan_target(),
> scsi_scan_host(), etc.
>
> So, checking QEMU, we send VIRTIO_SCSI_EVT_RESET_RESCAN during hotplug
> and VIRTIO_SCSI_EVT_RESET_REMOVED during hotunplug. In both cases now we
> send also the UNIT ATTENTION.
>
> In the virtio-scsi driver, when we receive VIRTIO_SCSI_EVT_RESET_RESCAN
> (hotplug) we call scsi_scan_target() or scsi_add_device(). Both of them
> will call __scsi_scan_target() at some points, sending `REPORT_LUNS`
> command to the device. This does not happen for
> VIRTIO_SCSI_EVT_RESET_REMOVED (hotunplug). Indeed if I remove the
> UNIT ATTENTION from the hotunplug in QEMU, everything works well.
>
> So, I tried to add a scan also for VIRTIO_SCSI_EVT_RESET_REMOVED:
>
> diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
> index bd5633667d01..c57658a63097 100644
> --- a/drivers/scsi/virtio_scsi.c
> +++ b/drivers/scsi/virtio_scsi.c
> @@ -291,6 +291,7 @@ static void virtscsi_handle_transport_reset(struct virtio_scsi *vscsi,
>                  }
>                  break;
>          case VIRTIO_SCSI_EVT_RESET_REMOVED:
> +               scsi_scan_host(shost);
>                  sdev = scsi_device_lookup(shost, 0, target, lun);
>                  if (sdev) {
>                          scsi_remove_device(sdev);
>
> This somehow helps, now linux only breaks if the plug/unplug frequency
> is really high. If I put a 5 second sleep between plug/unplug events, it
> doesn't break (at least for the duration of my test which has been
> running for about 30 minutes, before it used to break after about a
> minute).
>
> Another thing I noticed is that in QEMU maybe we should set the UNIT
> ATTENTION first and then send the event on the virtqueue, because the
> scan should happen after the unit attention, but I don't know if in any
> case the unit attention is processed before the virtqueue.
>
> I mean something like this:
>
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 45b95ea070..13db40f4f3 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -1079,8 +1079,8 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>           };
>
>           virtio_scsi_acquire(s);
> -        virtio_scsi_push_event(s, &info);
>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> +        virtio_scsi_push_event(s, &info);
>           virtio_scsi_release(s);
>       }
>   }
> @@ -1111,8 +1111,8 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
>
>       if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
>           virtio_scsi_acquire(s);
> -        virtio_scsi_push_event(s, &info);
>           scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> +        virtio_scsi_push_event(s, &info);
>           virtio_scsi_release(s);
>       }
>   }

That is racy. It's up to the guest whether the event virtqueue or the
UNIT ATTENTION will be processed first.

If the device wants to ensure ordering then it must withhold the event
until the driver has responded to the UNIT ATTENTION. That may not be
a good idea though.

I'd like to understand the root cause before choosing a solution.

> At this point I think the problem is on the handling of the
> VIRTIO_SCSI_EVT_RESET_REMOVED event in the virtio-scsi driver, where
> somehow we have to redo the bus scan, but scsi_scan_host() doesn't seem
> to be enough when the event rate is very high.

Why is it necessary to rescan the whole bus instead of removing just
the device that has been unplugged?

> I don't know if along with this fix, we also need to limit the rate in
> QEMU somehow.

Why is a high rate problematic?

> Sorry for the length of this email, but I'm not familiar with SCSI and
> wanted some suggestions on how to proceed.
>
> Paolo, Stefan, Linux SCSI maintainers, any suggestion?

I don't know the Linux SCSI code well enough to say, sorry. I think we
need input from someone familiar with the code.

However, QEMU is not at liberty to make changes that break existing
guests. So even if it turns out the specs allow something or there is
an existing bug in virtio_scsi.ko, we still can't break existing
guests.

Stefan

>
>
> Thanks,
> Stefano
>
> On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
> >This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> >
> >That commit causes several problems in Linux as described in the BZ.
> >In particular, after a while, other devices on the bus are no longer
> >usable even if those devices are not affected by the hotunplug.
> >This may be a problem in Linux, but we have not been able to identify
> >it so far. So better to revert this patch until we find a solution.
> >
> >Also, Oracle, which initially proposed this patch for a problem with
> >Solaris, seems to have already reversed it downstream:
> >    https://linux.oracle.com/errata/ELSA-2023-12065.html
> >
> >Suggested-by: Thomas Huth <thuth@redhat.com>
> >Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> >Cc: qemu-stable@nongnu.org
> >Cc: Mark Kanda <mark.kanda@oracle.com>
> >Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >---
> > include/hw/scsi/scsi.h |  1 -
> > hw/scsi/scsi-bus.c     | 18 ------------------
> > hw/scsi/virtio-scsi.c  |  2 --
> > 3 files changed, 21 deletions(-)
> >
> >diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> >index e2bb1a2fbf..7c8adf10b1 100644
> >--- a/include/hw/scsi/scsi.h
> >+++ b/include/hw/scsi/scsi.h
> >@@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
> >                                       BlockdevOnError rerror,
> >                                       BlockdevOnError werror,
> >                                       const char *serial, Error **errp);
> >-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
> > void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
> >
> > SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
> >diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> >index f80f4cb4fc..42a915f8b7 100644
> >--- a/hw/scsi/scsi-bus.c
> >+++ b/hw/scsi/scsi-bus.c
> >@@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
> >     return (sense.asc << 8) | sense.ascq;
> > }
> >
> >-void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
> >-{
> >-    int prec1, prec2;
> >-    if (sense.key != UNIT_ATTENTION) {
> >-        return;
> >-    }
> >-
> >-    /*
> >-     * Override a pre-existing unit attention condition, except for a more
> >-     * important reset condition.
> >-     */
> >-    prec1 = scsi_ua_precedence(bus->unit_attention);
> >-    prec2 = scsi_ua_precedence(sense);
> >-    if (prec2 < prec1) {
> >-        bus->unit_attention = sense;
> >-    }
> >-}
> >-
> > void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
> > {
> >     int prec1, prec2;
> >diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> >index 45b95ea070..1f56607100 100644
> >--- a/hw/scsi/virtio-scsi.c
> >+++ b/hw/scsi/virtio-scsi.c
> >@@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >
> >         virtio_scsi_acquire(s);
> >         virtio_scsi_push_event(s, &info);
> >-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> >         virtio_scsi_release(s);
> >     }
> > }
> >@@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >     if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> >         virtio_scsi_acquire(s);
> >         virtio_scsi_push_event(s, &info);
> >-        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> >         virtio_scsi_release(s);
> >     }
> > }
> >--
> >2.41.0
> >
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization

