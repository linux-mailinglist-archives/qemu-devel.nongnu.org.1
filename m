Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4ED8074E5
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 17:26:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAuib-0001hL-Il; Wed, 06 Dec 2023 11:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAuiQ-0001fE-Ec
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:25:39 -0500
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rAuiM-0001Jn-M2
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 11:25:36 -0500
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1fb9c24a16aso5560fac.0
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 08:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701879933; x=1702484733; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cKM9J1YOZcbU/OIIdjPBZFdTMVE6utGI5pFwRVDPerk=;
 b=Sh90M3OJmNidJHc4ysBF0JVe+rt5ML6bt5AVtysabG5aJ4YHpzOAk6vHt+Q++xJe11
 9aKmwcvZiNf5ey0i/HHhiklJcGUFMX6l3VwoKCPJd2QjzPhvS2MM4BeyLUm/fA21JYN2
 ZL242ghGGIkOSHSk64ISVvxhxNAfzrJ9c5xHKICleCkJM5xKkbMrvpCd0coyZBYSX9sP
 NXyBJeyyv3KnQhVFi5JoZ3qhOQULJx/XHRspd0O+qCJxxwrFSZ9VV9UVHIv+iHrVhMIc
 h8lOdUtQ7qU25w2dF21nd3NG0yAIuubmjjoSAAcurYUHbSbFVnQMMy+VJrJ1F+0pV0hq
 /G1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701879933; x=1702484733;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cKM9J1YOZcbU/OIIdjPBZFdTMVE6utGI5pFwRVDPerk=;
 b=jAzTezFgaQfCUDojUEAqYnPjJPzWVBLyYGOyN4lwsjnij2zMw5U7JPIQv8R2wd+RTC
 tVy/Fk5Qjpmlf5QPzgJgHUiqwUtD0qs03rcYPVTo2N+jV7p1jRwr4XsGmjREimk2DhX6
 6puMMDpeKr7K3cbLxvx3zcivlYsdDpWauU7AVK2y4nbLxKdmeUBjLn9Dpy43MSB+ooQ4
 jWeYfQh59HwZq+es2bUi0zV16vUzJnhbWif3I/fsUnHNuhFXL7hDx/2g9UOlvXhRBLbu
 nxcBp0jmB9AxxBISySUPNgVtX1wW2oJGzXd5sMvYr2watb/g1PCEiQkilzrHi/yMcOpV
 lqCg==
X-Gm-Message-State: AOJu0YxCpVZKDXFwN477wNB7euthl9u1yInZIV80PulO9uagZ/4LtXzU
 XXW2rwZxC/d2gksGAf9m4zICrgshdwJyEmddIUk=
X-Google-Smtp-Source: AGHT+IEdDyHF05OqtxeqehoNhyUS+7+sz8IQRcoTY9FlmEmlpUch3NbAdhl8CPnKR/axebWbWQb8RoYfCXERWfjcPds=
X-Received: by 2002:a05:6870:ec8e:b0:1fb:22f9:17ac with SMTP id
 eo14-20020a056870ec8e00b001fb22f917acmr1249375oab.8.1701879933228; Wed, 06
 Dec 2023 08:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20231123194931.171598-1-stefanha@redhat.com>
 <20231123194931.171598-2-stefanha@redhat.com>
 <ZWoDwd-EeuAKyDE2@redhat.com> <20231204163002.GI1492005@fedora>
 <ZW70qXZ-xn5LSY67@redhat.com>
In-Reply-To: <ZW70qXZ-xn5LSY67@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 6 Dec 2023 11:25:21 -0500
Message-ID: <CAJSP0QW19U_nW-YqysrSLPU9Fc-+RGar5BfP2xWQshxBUiPmQg@mail.gmail.com>
Subject: Re: [PATCH 1/4] scsi: only access SCSIDevice->requests from one thread
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x35.google.com
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

On Tue, 5 Dec 2023 at 05:01, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 04.12.2023 um 17:30 hat Stefan Hajnoczi geschrieben:
> > On Fri, Dec 01, 2023 at 05:03:13PM +0100, Kevin Wolf wrote:
> > > Am 23.11.2023 um 20:49 hat Stefan Hajnoczi geschrieben:
> > > > Stop depending on the AioContext lock and instead access
> > > > SCSIDevice->requests from only one thread at a time:
> > > > - When the VM is running only the BlockBackend's AioContext may access
> > > >   the requests list.
> > > > - When the VM is stopped only the main loop may access the requests
> > > >   list.
> > > >
> > > > These constraints protect the requests list without the need for locking
> > > > in the I/O code path.
> > > >
> > > > Note that multiple IOThreads are not supported yet because the code
> > > > assumes all SCSIRequests are executed from a single AioContext. Leave
> > > > that as future work.
> > > >
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > ---
> > > >  include/hw/scsi/scsi.h |   7 +-
> > > >  hw/scsi/scsi-bus.c     | 174 ++++++++++++++++++++++++++++-------------
> > > >  2 files changed, 124 insertions(+), 57 deletions(-)
> > > >
> > > > diff --git a/include/hw/scsi/scsi.h b/include/hw/scsi/scsi.h
> > > > index 3692ca82f3..10c4e8288d 100644
> > > > --- a/include/hw/scsi/scsi.h
> > > > +++ b/include/hw/scsi/scsi.h
> > > > @@ -69,14 +69,19 @@ struct SCSIDevice
> > > >  {
> > > >      DeviceState qdev;
> > > >      VMChangeStateEntry *vmsentry;
> > > > -    QEMUBH *bh;
> > > >      uint32_t id;
> > > >      BlockConf conf;
> > > >      SCSISense unit_attention;
> > > >      bool sense_is_ua;
> > > >      uint8_t sense[SCSI_SENSE_BUF_SIZE];
> > > >      uint32_t sense_len;
> > > > +
> > > > +    /*
> > > > +     * The requests list is only accessed from the AioContext that executes
> > > > +     * requests or from the main loop when IOThread processing is stopped.
> > > > +     */
> > > >      QTAILQ_HEAD(, SCSIRequest) requests;
> > > > +
> > > >      uint32_t channel;
> > > >      uint32_t lun;
> > > >      int blocksize;
> > > > diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
> > > > index fc4b77fdb0..b8bfde9565 100644
> > > > --- a/hw/scsi/scsi-bus.c
> > > > +++ b/hw/scsi/scsi-bus.c
> > > > @@ -85,6 +85,82 @@ SCSIDevice *scsi_device_get(SCSIBus *bus, int channel, int id, int lun)
> > > >      return d;
> > > >  }
> > > >
> > > > +/*
> > > > + * Invoke @fn() for each enqueued request in device @s. Must be called from the
> > > > + * main loop thread while the guest is stopped. This is only suitable for
> > > > + * vmstate ->put(), use scsi_device_for_each_req_async() for other cases.
> > > > + */
> > > > +static void scsi_device_for_each_req_sync(SCSIDevice *s,
> > > > +                                          void (*fn)(SCSIRequest *, void *),
> > > > +                                          void *opaque)
> > > > +{
> > > > +    SCSIRequest *req;
> > > > +    SCSIRequest *next_req;
> > > > +
> > > > +    assert(!runstate_is_running());
> > > > +    assert(qemu_in_main_thread());
> > > > +
> > > > +    QTAILQ_FOREACH_SAFE(req, &s->requests, next, next_req) {
> > > > +        fn(req, opaque);
> > > > +    }
> > > > +}
> > > > +
> > > > +typedef struct {
> > > > +    SCSIDevice *s;
> > > > +    void (*fn)(SCSIRequest *, void *);
> > > > +    void *fn_opaque;
> > > > +} SCSIDeviceForEachReqAsyncData;
> > > > +
> > > > +static void scsi_device_for_each_req_async_bh(void *opaque)
> > > > +{
> > > > +    g_autofree SCSIDeviceForEachReqAsyncData *data = opaque;
> > > > +    SCSIDevice *s = data->s;
> > > > +    SCSIRequest *req;
> > > > +    SCSIRequest *next;
> > > > +
> > > > +    /*
> > > > +     * It is unlikely that the AioContext will change before this BH is called,
> > > > +     * but if it happens then ->requests must not be accessed from this
> > > > +     * AioContext.
> > > > +     */
> > >
> > > What is the scenario where this happens? I would have expected that
> > > switching the AioContext of a node involves draining the node first,
> > > which would execute this BH before the context changes.
> >
> > I don't think aio_poll() is invoked by bdrv_drained_begin() when there
> > are no requests in flight. In that case the BH could remain pending
> > across bdrv_drained_begin()/bdrv_drained_end().
>
> Hm, I wonder if that is actually a bug. Without executing pending BHs,
> you can't be sure that nothing touches the node any more.
>
> Before commit 5e8ac217, we always polled at least once, though I think
> that was an unintentional side effect.

It makes the programming model easier and safer if aio_bh_poll() is
guaranteed to be called by bdrv_drained_begin().

Then I could convert this conditional into an assertion and assume it
never happens.

> > > The other option I see is an empty BlockBackend, which can change its
> > > AioContext without polling BHs, but in that case there is no connection
> > > to other users, so the only change could come from virtio-scsi itself.
> > > If there is such a case, it would probably be helpful to be specific in
> > > the comment.
> > >
> > > > +    if (blk_get_aio_context(s->conf.blk) == qemu_get_current_aio_context()) {
> > > > +        QTAILQ_FOREACH_SAFE(req, &s->requests, next, next) {
> > > > +            data->fn(req, data->fn_opaque);
> > > > +        }
> > > > +    }
> > >
> > > Of course, if the situation does happen, the question is why just doing
> > > nothing is correct. Wouldn't that mean that the guest still sees stuck
> > > requests?
> > >
> > > Would rescheduling the BH in the new context be better?
> >
> > In the case where there are no requests it is correct to do nothing,
> > but it's not a general solution.
>
> Why is it correct when there are no requests? I can see this for
> scsi_device_purge_requests() because it only cancels in-flight requests,
> but scsi_dma_restart_cb() is about requests queued at the device level
> that are not in flight in the block layer. Not restarting them if there
> aren't any other requests in flight seems wrong.

You're right!

> > > > +
> > > > +    /* Drop the reference taken by scsi_device_for_each_req_async() */
> > > > +    object_unref(OBJECT(s));
> > > > +}
> > > > +
> > > > +/*
> > > > + * Schedule @fn() to be invoked for each enqueued request in device @s. @fn()
> > > > + * runs in the AioContext that is executing the request.
> > > > + */
> > > > +static void scsi_device_for_each_req_async(SCSIDevice *s,
> > > > +                                           void (*fn)(SCSIRequest *, void *),
> > > > +                                           void *opaque)
> > >
> > > If we keep the behaviour above (doesn't do anything if the AioContext
> > > changes), then I think it needs to be documented for this function and
> > > callers should be explicit about why it's okay.
> >
> > I think your suggestion to reschedule in the new AioContext is best.
>
> Ok, then the answer for the above is less important.

I already sent v2 but will send a v3 if you think bdrv_drained_begin()
should always call aio_poll()?

Stefan

