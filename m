Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C90EAB396C5
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Aug 2025 10:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urXpo-0004f1-T7; Thu, 28 Aug 2025 04:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1urXpk-0004e0-6H
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:18:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1urXpg-0004x2-Tf
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756369086;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D2XWcPIF6iN+qjsYgVKiETSlcFXiHy3mlm8R+J9zIDg=;
 b=jSGhjXXDak6QFCqdcqB2ZY/a0ICeNdW1X40dfoXr5kSvdjxjcXHtjbIURb8JvlrWFWWkxh
 eGY2M37chZwE+rgzydb0yT1wz3IJyjozBf/ttNZJJ0vVM9fFFOEPyokCmBpTGUqGGQ5kl9
 zzOuIDHRVl27pptkeTpjV0WLQm8kDOU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-7dT9AJpoPpy_godwcWostA-1; Thu, 28 Aug 2025 04:18:04 -0400
X-MC-Unique: 7dT9AJpoPpy_godwcWostA-1
X-Mimecast-MFC-AGG-ID: 7dT9AJpoPpy_godwcWostA_1756369083
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-7705115a2a5so606520b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 01:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756369080; x=1756973880;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:reply-to:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D2XWcPIF6iN+qjsYgVKiETSlcFXiHy3mlm8R+J9zIDg=;
 b=B2IWIGGzxGs7XmmaKfhk+ExenOZ/1lSHFZ+brOJD5W81ndrYXHATJTk4kEdDt25+Xh
 2QAlEywUExOJL4VL3HgcH6bd1B3+qfOmPby302trH5claJhjkpa423rEZxYTT5tA4lPY
 AqF4+jG2lZE8jLBfMVSAOvy0G66CbgZEGIsYnffmfPH2DzPcez7717OVNMMCVoH32osQ
 Efw7ldFel1nNEo0QgHhbSnZXQaIeIPdHJjNH4TvYF/Onmscd3sfYwLhn0xPwA5/GdEpl
 cpz3Mu52r/ziu1h/1+uO4GxSaf3VjRRpJ7QhpUJVD9b4c9kN3B0Vuz23MTRTUHBcAlSG
 13vw==
X-Gm-Message-State: AOJu0Yy5COegoaGQQmC2qj0kzsLFL+a7TIEjl7QIvkpurZwiziBMsKiY
 lppVCf2HGuvj+sKe5Bqxhd2Pfn18OrYWSibrr9AIJOQOtAVV81+dr8Y7VHhAwj9E7UkQTOrt7GS
 VU/LJoOnsgWv/f6u1t7Sgvc7RcxwZb+0qw+gnvnYrVtdLDjqAl35TjoPm
X-Gm-Gg: ASbGnctnwc9Ut2FPiL3DgMYJQy3okwRwMmk2Piw72O2MHluYVmwmDeqekjPuy0N4s8I
 hGifu+b1+wHWjiDFcAfN43qhNLfzBpvDCdifVcuPIm7AWMDDU6jgG1s5UhycrSA1gNIkCca1idC
 IsiJyDLvQFxUksJ+zCPN4VJ0VpgQJ2qxri0JbA6ud9sjBSezE2bMh+C6/8U5586NJCZsNabmXTJ
 A98sZzxDjlXKRqUoeoL48zQvt4K2AdGyvg4fAoOja39vY6dXRxy0Kd5ox13s44pSgTqiWb4a+UD
 zrOrNMPLD0MnVauZCmPmajrrnhGcubBbIDPigyWbM5em/AtiW5zQ
X-Received: by 2002:a05:6a00:2e99:b0:772:f71:d357 with SMTP id
 d2e1a72fcca58-7720f71d84emr4420480b3a.7.1756369079707; 
 Thu, 28 Aug 2025 01:17:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFJ2EtOU4Ak0vHo3crhCUZow17HpKOFVf0RwXQ3ApRXIb6AEuAvkSWH9k9pP2qyhDXPk1sQ==
X-Received: by 2002:a05:6a00:2e99:b0:772:f71:d357 with SMTP id
 d2e1a72fcca58-7720f71d84emr4420450b3a.7.1756369079164; 
 Thu, 28 Aug 2025 01:17:59 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.193.42])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77057368ca0sm12093974b3a.58.2025.08.28.01.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 01:17:58 -0700 (PDT)
Date: Thu, 28 Aug 2025 13:47:46 +0530
From: Arun Menon <armenon@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v12 02/27] migration: push Error **errp into
 vmstate_load_state()
Message-ID: <aLAQqhtqzwaRj7Ar@armenon-kvm.bengluru.csb>
References: <20250821-propagate_tpm_error-v12-0-72b803e707dc@redhat.com>
 <20250821-propagate_tpm_error-v12-2-72b803e707dc@redhat.com>
 <2f079847-8b78-4db0-b14e-a3f643b6cc98@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f079847-8b78-4db0-b14e-a3f643b6cc98@rsg.ci.i.u-tokyo.ac.jp>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

H Akihiko,

Thanks for the review.

On Thu, Aug 28, 2025 at 10:34:54AM +0900, Akihiko Odaki wrote:
> On 2025/08/21 17:43, Arun Menon wrote:
> > This is an incremental step in converting vmstate loading
> > code to report error via Error objects instead of directly
> > printing it to console/monitor.
> > It is ensured that vmstate_load_state() must report an error
> > in errp, in case of failure.
> > 
> > The errors are temporarily reported using warn_report_err().
> > This is removed in the subsequent patches in this series,
> > when we are actually able to propagate the error to the calling
> > function using errp. Whereas, if we want the function to exit on
> > error, then error_fatal is passed.
> > 
> > Reviewed-by: Marc-Andr� Lureau <marcandre.lureau@redhat.com>
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/display/virtio-gpu.c     |  2 +-
> >   hw/pci/pci.c                |  3 ++-
> >   hw/s390x/virtio-ccw.c       |  2 +-
> >   hw/scsi/spapr_vscsi.c       |  4 ++-
> >   hw/vfio/pci.c               |  5 +++-
> >   hw/virtio/virtio-mmio.c     |  3 ++-
> >   hw/virtio/virtio-pci.c      |  2 +-
> >   hw/virtio/virtio.c          |  7 +++--
> >   include/migration/vmstate.h |  2 +-
> >   migration/cpr.c             |  3 +--
> >   migration/savevm.c          |  8 ++++--
> >   migration/vmstate-types.c   | 22 +++++++++++----
> >   migration/vmstate.c         | 65 +++++++++++++++++++++++++++++++--------------
> >   tests/unit/test-vmstate.c   | 63 ++++++++++++++++++++++++++++++++++++-------
> >   ui/vdagent.c                |  5 +++-
> >   15 files changed, 147 insertions(+), 49 deletions(-)
> > 
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index 0a1a625b0ea6cf26cb0d799171a57ed3d3ab2442..5dc31bc6bfb0272e29a4364ab10de2595a4bedf7 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -1343,7 +1343,7 @@ static int virtio_gpu_load(QEMUFile *f, void *opaque, size_t size,
> >       }
> >       /* load & apply scanout state */
> > -    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1);
> > +    vmstate_load_state(f, &vmstate_virtio_gpu_scanouts, g, 1, &error_fatal);
> >       return 0;
> >   }
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..6be932d3bb67ff0c4808707db2a7b6378a90e82b 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -934,7 +934,8 @@ void pci_device_save(PCIDevice *s, QEMUFile *f)
> >   int pci_device_load(PCIDevice *s, QEMUFile *f)
> >   {
> >       int ret;
> > -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id);
> > +    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> > +                             &error_fatal);
> >       /* Restore the interrupt status bit. */
> >       pci_update_irq_status(s);
> >       return ret;
> > diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> > index d2f85b39f30f7fc82e0c600144c0a958e1269b2c..6a9641a03d5d3a38a4de7ceb9deffc0cc303bcff 100644
> > --- a/hw/s390x/virtio-ccw.c
> > +++ b/hw/s390x/virtio-ccw.c
> > @@ -1136,7 +1136,7 @@ static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> >   static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> >   {
> >       VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> > -    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1);
> > +    return vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &error_fatal);
> >   }
> >   static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> > diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
> > index 20f70fb2729de78b9636a6b8c869695dab4f8902..8622419497db650523d51bcb41557bbca254eaa3 100644
> > --- a/hw/scsi/spapr_vscsi.c
> > +++ b/hw/scsi/spapr_vscsi.c
> > @@ -642,15 +642,17 @@ static void *vscsi_load_request(QEMUFile *f, SCSIRequest *sreq)
> >       VSCSIState *s = VIO_SPAPR_VSCSI_DEVICE(bus->qbus.parent);
> >       vscsi_req *req;
> >       int rc;
> > +    Error *local_err = NULL;
> >       assert(sreq->tag < VSCSI_REQ_LIMIT);
> >       req = &s->reqs[sreq->tag];
> >       assert(!req->active);
> >       memset(req, 0, sizeof(*req));
> > -    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1);
> > +    rc = vmstate_load_state(f, &vmstate_spapr_vscsi_req, req, 1, &local_err);
> >       if (rc) {
> >           fprintf(stderr, "VSCSI: failed loading request tag#%u\n", sreq->tag);
> > +        warn_report_err(local_err);
> >           return NULL;
> >       }
> >       assert(req->active);
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..a65e34b6979eadfa0851666aeae7cf731a00fa40 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2790,13 +2790,16 @@ static int vfio_pci_load_config(VFIODevice *vbasedev, QEMUFile *f)
> >       PCIDevice *pdev = &vdev->pdev;
> >       pcibus_t old_addr[PCI_NUM_REGIONS - 1];
> >       int bar, ret;
> > +    Error *local_err = NULL;
> >       for (bar = 0; bar < PCI_ROM_SLOT; bar++) {
> >           old_addr[bar] = pdev->io_regions[bar].addr;
> >       }
> > -    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1);
> > +    ret = vmstate_load_state(f, &vmstate_vfio_pci_config, vdev, 1,
> > +                             &local_err);
> >       if (ret) {
> > +        warn_report_err(local_err);
> >           return ret;
> >       }
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index 532c67107ba1d2978a76cf49f9cdc1de1dea3e11..0a688909fc606a3c9fde933667ae8c309ab527d0 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -34,6 +34,7 @@
> >   #include "qemu/error-report.h"
> >   #include "qemu/log.h"
> >   #include "trace.h"
> > +#include "qapi/error.h"
> >   static bool virtio_mmio_ioeventfd_enabled(DeviceState *d)
> >   {
> > @@ -619,7 +620,7 @@ static int virtio_mmio_load_extra_state(DeviceState *opaque, QEMUFile *f)
> >   {
> >       VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
> > -    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1);
> > +    return vmstate_load_state(f, &vmstate_virtio_mmio, proxy, 1, &error_fatal);
> >   }
> >   static bool virtio_mmio_has_extra_state(DeviceState *opaque)
> > diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> > index 767216d795998708f5716a23ae16c79cd90ff489..b04faa1e5c91b5cef40e54ec41d92422d16bfc13 100644
> > --- a/hw/virtio/virtio-pci.c
> > +++ b/hw/virtio/virtio-pci.c
> > @@ -161,7 +161,7 @@ static int virtio_pci_load_extra_state(DeviceState *d, QEMUFile *f)
> >   {
> >       VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
> > -    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1);
> > +    return vmstate_load_state(f, &vmstate_virtio_pci, proxy, 1, &error_fatal);
> >   }
> >   static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index 9a81ad912e013fc254899c4e55cff1f76a6112a4..419f3516c9f0a3df43831eebc77aa1e6dfcd0f41 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -3235,6 +3235,7 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >       BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> >       VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
> >       VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
> > +    Error *local_err = NULL;
> >       /*
> >        * We poison the endianness to ensure it does not get used before
> > @@ -3327,15 +3328,17 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
> >       }
> >       if (vdc->vmsd) {
> > -        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id);
> > +        ret = vmstate_load_state(f, vdc->vmsd, vdev, version_id, &local_err);
> >           if (ret) {
> > +            warn_report_err(local_err);
> 
> I think error_report_err() should be used instead because this is replacing
> error_report().
> 
> If I read correctly, warn_report_err() is essentially error_report_err()
> prefixing the message with "warning: ". However, the error messages handled
> in this series do not have such prefixes so you shouldn't add them in
> intemediate changes.

If I am not wrong, we have introduced warn_report_err() not as a replacement to
error_report(). They are newly added ones. Besides, some of them are not intermediate
changes, because they do end up in the final version. for example in hw/virtio/virtio-pci.c
In some places in the intermediate patches a warn_report_err() is added right after
error_report(), both to be replaced with error_setg()/error_prepend() later in the series.

Do you want to replace warn_report_err() everywhere with error_report_err()?

> 
> Regards,
> Akihiko Odaki
> 

Regards,
Arun Menon


