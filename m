Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D5D76F3B7
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 21:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qReR8-0004ED-Tn; Thu, 03 Aug 2023 15:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReR7-0004Du-DU
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReR5-0007Dn-Nx
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691092598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=afDt+bNm0QQNLe08tkgQFrLH4rKpY/ef2T2tPkfCmko=;
 b=ERfk4Lcice/HciqUQRaF7fK0pTBqB9RthY7C67fNGIet4fy7nMIeBMsdAg3wWRolQB9Q/3
 LSLyqmpgkEsnd8TyH1lEaT6v2oAJoJH/UwCCCqLcfkB3oYjbKQQBlORtwzsqknz1mcHyuz
 TnnnYDs2/EZmAG0C7pxEumwVc0d837U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-tlLbn_AAOu29-zWHu2nTSg-1; Thu, 03 Aug 2023 15:56:37 -0400
X-MC-Unique: tlLbn_AAOu29-zWHu2nTSg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31444df0fafso746030f8f.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 12:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691092596; x=1691697396;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afDt+bNm0QQNLe08tkgQFrLH4rKpY/ef2T2tPkfCmko=;
 b=QWK5sBClUhsi7xjjbanqlGeo4d6ICT5EpYwfCPTFakEKqRQA9Ku3xfj0qVuUsm0XCo
 bOP93KzC3ocRvkrEwAkHqj17lDJPfsZ5HASP3C4S9Mb6aJBj9S9W9xe12gdCWumL3M/L
 F0sLwCIZyFKDcOPkqRE982/gJu28K533pncCmo0dZMdwLi+p1CiZ1BfphpZFYARA3e5q
 MT3jIY1oQx5NLuj1WWFjbHqsYg0Uor21eYPiGJ7hEnZ8ejnZYLN7kVGtIAHoBG/uzUm6
 6NoqY1rc8BwiFudQhEz+asc4OJCn4zp7vJaL9DeFu4ESBZqGdJmRnuuq7lwMXTU6H2AG
 UDFQ==
X-Gm-Message-State: ABy/qLb+ujKuTqCChPQHSTRoFqtH9rUCAJ1csubQ9eEKrwNWmIhNepzi
 NMlc3LSF0xYvnWbrCt8Gx9RIcgsqRdLvpmC6FeD8fCkUUxhKPjA99l1M87hXIehwUwKS5ba+Z9C
 Z4UlbMfMkmIPZSHs=
X-Received: by 2002:adf:ce8a:0:b0:317:5c18:f31d with SMTP id
 r10-20020adfce8a000000b003175c18f31dmr7811096wrn.35.1691092596218; 
 Thu, 03 Aug 2023 12:56:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFNbBe2jbuERNLYhqIkLbxjTnBWnAadIDgkGR6RCNv3OVm2j+y/XR8v/G85/QPuf+0CZTCnUQ==
X-Received: by 2002:adf:ce8a:0:b0:317:5c18:f31d with SMTP id
 r10-20020adfce8a000000b003175c18f31dmr7811093wrn.35.1691092595906; 
 Thu, 03 Aug 2023 12:56:35 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 e3-20020a5d5943000000b00317ac0642b0sm654012wri.27.2023.08.03.12.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 12:56:35 -0700 (PDT)
Date: Thu, 3 Aug 2023 15:56:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <20230803155616-mutt-send-email-mst@kernel.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <20230803153628-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803153628-mutt-send-email-mst@kernel.org>
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

On Thu, Aug 03, 2023 at 03:36:44PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 05, 2023 at 09:15:23AM +0200, Stefano Garzarella wrote:
> > This reverts commit 8cc5583abe6419e7faaebc9fbd109f34f4c850f2.
> > 
> > That commit causes several problems in Linux as described in the BZ.
> > In particular, after a while, other devices on the bus are no longer
> > usable even if those devices are not affected by the hotunplug.
> > This may be a problem in Linux, but we have not been able to identify
> > it so far. So better to revert this patch until we find a solution.
> > 
> > Also, Oracle, which initially proposed this patch for a problem with
> > Solaris, seems to have already reversed it downstream:
> >     https://linux.oracle.com/errata/ELSA-2023-12065.html
> > 
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2176702
> > Cc: qemu-stable@nongnu.org
> > Cc: Mark Kanda <mark.kanda@oracle.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> OK guys we are reverting this?


ignore me pls, replied to a wrong patch.

> > ---
> >  include/hw/scsi/scsi.h |  1 -
> >  hw/scsi/scsi-bus.c     | 18 ------------------
> >  hw/scsi/virtio-scsi.c  |  2 --
> >  3 files changed, 21 deletions(-)
> > 
> > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > index e2bb1a2fbf..7c8adf10b1 100644
> > --- a/include/hw/scsi/scsi.h
> > +++ b/include/hw/scsi/scsi.h
> > @@ -198,7 +198,6 @@ SCSIDevice *scsi_bus_legacy_add_drive(SCSIBus *bus, BlockBackend *blk,
> >                                        BlockdevOnError rerror,
> >                                        BlockdevOnError werror,
> >                                        const char *serial, Error **errp);
> > -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense);
> >  void scsi_bus_legacy_handle_cmdline(SCSIBus *bus);
> >  
> >  SCSIRequest *scsi_req_alloc(const SCSIReqOps *reqops, SCSIDevice *d,
> > diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> > index f80f4cb4fc..42a915f8b7 100644
> > --- a/hw/scsi/scsi-bus.c
> > +++ b/hw/scsi/scsi-bus.c
> > @@ -1617,24 +1617,6 @@ static int scsi_ua_precedence(SCSISense sense)
> >      return (sense.asc << 8) | sense.ascq;
> >  }
> >  
> > -void scsi_bus_set_ua(SCSIBus *bus, SCSISense sense)
> > -{
> > -    int prec1, prec2;
> > -    if (sense.key != UNIT_ATTENTION) {
> > -        return;
> > -    }
> > -
> > -    /*
> > -     * Override a pre-existing unit attention condition, except for a more
> > -     * important reset condition.
> > -     */
> > -    prec1 = scsi_ua_precedence(bus->unit_attention);
> > -    prec2 = scsi_ua_precedence(sense);
> > -    if (prec2 < prec1) {
> > -        bus->unit_attention = sense;
> > -    }
> > -}
> > -
> >  void scsi_device_set_ua(SCSIDevice *sdev, SCSISense sense)
> >  {
> >      int prec1, prec2;
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index 45b95ea070..1f56607100 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > @@ -1080,7 +1080,6 @@ static void virtio_scsi_hotplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >  
> >          virtio_scsi_acquire(s);
> >          virtio_scsi_push_event(s, &info);
> > -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> >          virtio_scsi_release(s);
> >      }
> >  }
> > @@ -1112,7 +1111,6 @@ static void virtio_scsi_hotunplug(HotplugHandler *hotplug_dev, DeviceState *dev,
> >      if (virtio_vdev_has_feature(vdev, VIRTIO_SCSI_F_HOTPLUG)) {
> >          virtio_scsi_acquire(s);
> >          virtio_scsi_push_event(s, &info);
> > -        scsi_bus_set_ua(&s->bus, SENSE_CODE(REPORTED_LUNS_CHANGED));
> >          virtio_scsi_release(s);
> >      }
> >  }
> > -- 
> > 2.41.0


