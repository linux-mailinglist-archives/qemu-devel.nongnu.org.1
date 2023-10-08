Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 197897BCD43
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 10:51:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpPVT-00017S-1h; Sun, 08 Oct 2023 04:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPVF-000161-47
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:51:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qpPVC-0004sZ-5v
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 04:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696755065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzAOsQL/3DNymmLYybpgZMjFD3Ing40O1nsvGqcsAg4=;
 b=Zw3NrD2eEI5gj7c7HTx+iniZgjxWa+3vV1iIFoPyxBCnmvEnc60Bij34UTJxZkRsIgyuQP
 b2/jgk4O3A9hp69f8tmbwZAbe2wJ2Ushi0oEPmlOi5dZJNS2YOGXs5YeCDHadBstX7h1RW
 yBJ+WgXCU+UBge+GDtrTUL//6B21LRI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-DUD-VbfPO_Cj2liTxzkMDg-1; Sun, 08 Oct 2023 04:51:00 -0400
X-MC-Unique: DUD-VbfPO_Cj2liTxzkMDg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9adad8f306fso273676266b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 01:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696755059; x=1697359859;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TzAOsQL/3DNymmLYybpgZMjFD3Ing40O1nsvGqcsAg4=;
 b=HGj7TCQkc0sWXZmbwoskFytuMboCsL7GsYjbR6yGEfqWsPsKlsb/n7hi7j+pBTLUG2
 euFLAEBB05/fjsfUh0Wu40wPdLNYdMeOjKm75LZ31Btx+0Qjg0SDiuPGwfqNh6/EyA6C
 pFI2OB8EJlDjmwlV1D8gQ/6ZU75yzDj5Ht6IP6SapyawRqmkAziD86c5DHct74pZ6eec
 PnF+2JOZuxxXp7PfYdiFxcfyHUScNBEY9lOHgp49urSGU3n/qnSsAg0HWv/Nc7QGtJnN
 5ATPOcRFwyox8wuDLPNankHGTvDuPC3cng8kH3PgyAMV29Zuv+qauZEq2kP9ZakXcXli
 OQ7w==
X-Gm-Message-State: AOJu0YzftUk77UV9ghM01TdqCxWKiwxhG5R0XdYwkwtZhSjVYAqW+K3w
 iAI2vQNie+ec2YboLlg6illltWijzSquGW8TSDI/t5SOdXWSyF1Kqu/IYa+NLtcQuXX6asSUwYh
 +6/MY/T/2rNDotrc=
X-Received: by 2002:a17:906:328b:b0:9b7:58:52a8 with SMTP id
 11-20020a170906328b00b009b7005852a8mr11203999ejw.19.1696755059741; 
 Sun, 08 Oct 2023 01:50:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElgYe8PYK0SbJtwLU5uroTVh5uNwPNRjZVhiEzcOPIZGK5Ag++7wWvC/ZlFi4U2fuSkb4E8g==
X-Received: by 2002:a17:906:328b:b0:9b7:58:52a8 with SMTP id
 11-20020a170906328b00b009b7005852a8mr11203982ejw.19.1696755059263; 
 Sun, 08 Oct 2023 01:50:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:d74e:e6b1:da81:860a:5e9e])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a170906139700b009a5f1d15642sm5241945ejc.158.2023.10.08.01.50.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Oct 2023 01:50:58 -0700 (PDT)
Date: Sun, 8 Oct 2023 04:50:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Li Feng <fengli@smartx.com>
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/5] vhost-user-common: send get_inflight_fd once
Message-ID: <20231008044946-mutt-send-email-mst@kernel.org>
References: <20230721105205.1714449-1-fengli@smartx.com>
 <20230922114625.5786-1-fengli@smartx.com>
 <20230922114625.5786-2-fengli@smartx.com>
 <D5AD3E2E-8C4B-4ADA-B054-B42E2B030808@nutanix.com>
 <CAHckoCxb3kgF_2cc6kb05v24Jes107MixquB2fYxcKePiSvUzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHckoCxb3kgF_2cc6kb05v24Jes107MixquB2fYxcKePiSvUzg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, Oct 08, 2023 at 04:49:05PM +0800, Li Feng wrote:
> On Fri, Sep 29, 2023 at 8:55 AM Raphael Norwitz
> <raphael.norwitz@nutanix.com> wrote:
> >
> >
> >
> > > On Sep 22, 2023, at 7:46 AM, Li Feng <fengli@smartx.com> wrote:
> > >
> > > Currently the get_inflight_fd will be sent every time the device is started, and
> > > the backend will allocate shared memory to save the inflight state. If the
> > > backend finds that it receives the second get_inflight_fd, it will release the
> > > previous shared memory, which breaks inflight working logic.
> > >
> > > This patch is a preparation for the following patches.
> >
> > This looks identical to the v3 patch I reviewed? If I’ve missed something can you please point it out?
> Yes, nothing changed in this patch.


Then you should include tags such as reviewed/acked by for previous
version. if you drop tags you indicate to people they have to
re-review.
also, mentioning which patches changed in the cover letter is
a courtesy to reviewers.

> >
> >
> > > Signed-off-by: Li Feng <fengli@smartx.com>
> > > ---
> > > hw/scsi/vhost-scsi-common.c | 37 ++++++++++++++++++-------------------
> > > 1 file changed, 18 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/hw/scsi/vhost-scsi-common.c b/hw/scsi/vhost-scsi-common.c
> > > index a06f01af26..a61cd0e907 100644
> > > --- a/hw/scsi/vhost-scsi-common.c
> > > +++ b/hw/scsi/vhost-scsi-common.c
> > > @@ -52,20 +52,28 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> > >
> > >     vsc->dev.acked_features = vdev->guest_features;
> > >
> > > -    assert(vsc->inflight == NULL);
> > > -    vsc->inflight = g_new0(struct vhost_inflight, 1);
> > > -    ret = vhost_dev_get_inflight(&vsc->dev,
> > > -                                 vs->conf.virtqueue_size,
> > > -                                 vsc->inflight);
> > > +    ret = vhost_dev_prepare_inflight(&vsc->dev, vdev);
> > >     if (ret < 0) {
> > > -        error_report("Error get inflight: %d", -ret);
> > > +        error_report("Error setting inflight format: %d", -ret);
> > >         goto err_guest_notifiers;
> > >     }
> > >
> > > -    ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> > > -    if (ret < 0) {
> > > -        error_report("Error set inflight: %d", -ret);
> > > -        goto err_guest_notifiers;
> > > +    if (vsc->inflight) {
> > > +        if (!vsc->inflight->addr) {
> > > +            ret = vhost_dev_get_inflight(&vsc->dev,
> > > +                                        vs->conf.virtqueue_size,
> > > +                                        vsc->inflight);
> > > +            if (ret < 0) {
> > > +                error_report("Error getting inflight: %d", -ret);
> > > +                goto err_guest_notifiers;
> > > +            }
> > > +        }
> > > +
> > > +        ret = vhost_dev_set_inflight(&vsc->dev, vsc->inflight);
> > > +        if (ret < 0) {
> > > +            error_report("Error setting inflight: %d", -ret);
> > > +            goto err_guest_notifiers;
> > > +        }
> > >     }
> > >
> > >     ret = vhost_dev_start(&vsc->dev, vdev, true);
> > > @@ -85,9 +93,6 @@ int vhost_scsi_common_start(VHostSCSICommon *vsc)
> > >     return ret;
> > >
> > > err_guest_notifiers:
> > > -    g_free(vsc->inflight);
> > > -    vsc->inflight = NULL;
> > > -
> > >     k->set_guest_notifiers(qbus->parent, vsc->dev.nvqs, false);
> > > err_host_notifiers:
> > >     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> > > @@ -111,12 +116,6 @@ void vhost_scsi_common_stop(VHostSCSICommon *vsc)
> > >     }
> > >     assert(ret >= 0);
> > >
> > > -    if (vsc->inflight) {
> > > -        vhost_dev_free_inflight(vsc->inflight);
> > > -        g_free(vsc->inflight);
> > > -        vsc->inflight = NULL;
> > > -    }
> > > -
> > >     vhost_dev_disable_notifiers(&vsc->dev, vdev);
> > > }
> > >
> > > --
> > > 2.41.0
> > >
> >


