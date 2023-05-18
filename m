Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66AF708A5E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 23:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzl5L-0004kd-Am; Thu, 18 May 2023 17:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzl5H-0004kP-GP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1pzl5E-0004lf-SK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 17:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684444967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SNSSEtUeXrF8Ls6chkHX47IWTPb9CcjJxWWIofmF8c=;
 b=bfx6BTkdwXTb45iS5Zcd3zFTvTNNLQHteg01fWt8h/1VUOtPHHUJ1etLynk0268kVoV7fM
 DLQ02sNMd+IfzBZn9PkiIiyAalgnEUPRKNaAnmffNoxFT6q3qF5Tw8Mx5iggV1C933OQck
 QFA5NiQYqWQscS6MEO/6/Q2S5Zc/gPE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-yMRFS7tSOf2VxJYz6p01cw-1; Thu, 18 May 2023 17:22:45 -0400
X-MC-Unique: yMRFS7tSOf2VxJYz6p01cw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af1ed9514bso4489581fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684444964; x=1687036964;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5SNSSEtUeXrF8Ls6chkHX47IWTPb9CcjJxWWIofmF8c=;
 b=DUYG3fxpjBdNIu1isBFQi3Ske89EAgCU33hqY46IRl//9YfUpTgSeRBczuuIRp5qit
 nhYkq/F8zz+SCFqagNQj20WjKrNEH8/v3A0R1bN8ARjj2azSN3UhpqWFj0AeiK9AOlZg
 REqzav4qevHTrTXau8ht/wEBNl+u4KrOdQUMPVEC2plENrlg+xUEEGn3EzRHx32DJJcR
 UBXDY4kX1BlyX3+fpx+G+5q8a2eMLuPzhFgUkdBiJ7H0WyW3lAKqW7XndQ3jBOBkerN2
 K7WPRhFEv7FQpsuMoIK38fXc47HANVvBoo1ch3CkLXV0VlB9rwk/xXCsR07g1USJT+P7
 0BpA==
X-Gm-Message-State: AC+VfDw5XvjjRn0VRbrzJPzAy6muFmbRhCBFO+aZKp0KyHQkTiq9K8VE
 G9unRgupQFBVnS7iD9TW/a6Ia+ApD/jRMygzP3uZBNHffdiN3gh6QxAq874Disgg6zDj7rdDO0+
 uQLHQrsZXDlna1bc=
X-Received: by 2002:a05:6512:512:b0:4f3:a71a:9e5f with SMTP id
 o18-20020a056512051200b004f3a71a9e5fmr46896lfb.65.1684444964144; 
 Thu, 18 May 2023 14:22:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4umCirCVFpasQSSGs2o6+e2VczJcp2RlyRRMO7JqgpiDERw294YH2RY7WHr8NW+PLWGWaARw==
X-Received: by 2002:a05:6512:512:b0:4f3:a71a:9e5f with SMTP id
 o18-20020a056512051200b004f3a71a9e5fmr46880lfb.65.1684444963732; 
 Thu, 18 May 2023 14:22:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
 by smtp.gmail.com with ESMTPSA id
 w9-20020ac254a9000000b004eedb66983csm360656lfk.273.2023.05.18.14.22.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 14:22:43 -0700 (PDT)
Date: Thu, 18 May 2023 17:22:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Parav Pandit <parav@mellanox.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, longpeng2@huawei.com,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 alvaro.karsz@solid-run.com, Liuxiangdong <liuxiangdong5@huawei.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, si-wei.liu@oracle.com,
 Shannon Nelson <snelson@pensando.io>, Lei Yang <leiyang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Cindy Lu <lulu@redhat.com>
Subject: Re: [PATCH v3 5/5] vdpa: move CVQ isolation check to
 net_init_vhost_vdpa
Message-ID: <20230518172138-mutt-send-email-mst@kernel.org>
References: <20230509154435.1410162-1-eperezma@redhat.com>
 <20230509154435.1410162-6-eperezma@redhat.com>
 <CACGkMEvujW-VFhrxk8FD0d76UeT0Q3osYC5odqMHntwoTHmizA@mail.gmail.com>
 <CAJaqyWd8GbMrTCKPKz_65CUkg6a83Y3aRg41R4aSKLpnpFj23Q@mail.gmail.com>
 <CACGkMEutrxhYOEozQq1scXaPXDVfX+ZRcLr4+w8CvODoxJqTjQ@mail.gmail.com>
 <CAJaqyWe=cop=M_kz7JazvnCboaMAqA4xuVO7WBS9rks83JHgkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWe=cop=M_kz7JazvnCboaMAqA4xuVO7WBS9rks83JHgkw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, May 18, 2023 at 08:36:22AM +0200, Eugenio Perez Martin wrote:
> On Thu, May 18, 2023 at 7:50 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, May 17, 2023 at 2:30 PM Eugenio Perez Martin
> > <eperezma@redhat.com> wrote:
> > >
> > > On Wed, May 17, 2023 at 5:59 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Tue, May 9, 2023 at 11:44 PM Eugenio Pérez <eperezma@redhat.com> wrote:
> > > > >
> > > > > Evaluating it at start time instead of initialization time may make the
> > > > > guest capable of dynamically adding or removing migration blockers.
> > > > >
> > > > > Also, moving to initialization reduces the number of ioctls in the
> > > > > migration, reducing failure possibilities.
> > > > >
> > > > > As a drawback we need to check for CVQ isolation twice: one time with no
> > > > > MQ negotiated and another one acking it, as long as the device supports
> > > > > it.  This is because Vring ASID / group management is based on vq
> > > > > indexes, but we don't know the index of CVQ before negotiating MQ.
> > > > >
> > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > ---
> > > > > v2: Take out the reset of the device from vhost_vdpa_cvq_is_isolated
> > > > > v3: Only record cvq_isolated, true if the device have cvq isolated in
> > > > >     both !MQ and MQ configurations.
> > > > > ---
> > > > >  net/vhost-vdpa.c | 178 +++++++++++++++++++++++++++++++++++------------
> > > > >  1 file changed, 135 insertions(+), 43 deletions(-)
> > > > >
> > > > > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > > > > index 3fb833fe76..29054b77a9 100644
> > > > > --- a/net/vhost-vdpa.c
> > > > > +++ b/net/vhost-vdpa.c
> > > > > @@ -43,6 +43,10 @@ typedef struct VhostVDPAState {
> > > > >
> > > > >      /* The device always have SVQ enabled */
> > > > >      bool always_svq;
> > > > > +
> > > > > +    /* The device can isolate CVQ in its own ASID */
> > > > > +    bool cvq_isolated;
> > > > > +
> > > > >      bool started;
> > > > >  } VhostVDPAState;
> > > > >
> > > > > @@ -362,15 +366,8 @@ static NetClientInfo net_vhost_vdpa_info = {
> > > > >          .check_peer_type = vhost_vdpa_check_peer_type,
> > > > >  };
> > > > >
> > > > > -/**
> > > > > - * Get vring virtqueue group
> > > > > - *
> > > > > - * @device_fd  vdpa device fd
> > > > > - * @vq_index   Virtqueue index
> > > > > - *
> > > > > - * Return -errno in case of error, or vq group if success.
> > > > > - */
> > > > > -static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
> > > > > +static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index,
> > > > > +                                          Error **errp)
> > > > >  {
> > > > >      struct vhost_vring_state state = {
> > > > >          .index = vq_index,
> > > > > @@ -379,8 +376,7 @@ static int64_t vhost_vdpa_get_vring_group(int device_fd, unsigned vq_index)
> > > > >
> > > > >      if (unlikely(r < 0)) {
> > > > >          r = -errno;
> > > > > -        error_report("Cannot get VQ %u group: %s", vq_index,
> > > > > -                     g_strerror(errno));
> > > > > +        error_setg_errno(errp, errno, "Cannot get VQ %u group", vq_index);
> > > > >          return r;
> > > > >      }
> > > > >
> > > > > @@ -480,9 +476,9 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
> > > > >  {
> > > > >      VhostVDPAState *s, *s0;
> > > > >      struct vhost_vdpa *v;
> > > > > -    uint64_t backend_features;
> > > > >      int64_t cvq_group;
> > > > > -    int cvq_index, r;
> > > > > +    int r;
> > > > > +    Error *err = NULL;
> > > > >
> > > > >      assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
> > > > >
> > > > > @@ -502,41 +498,22 @@ static int vhost_vdpa_net_cvq_start(NetClientState *nc)
> > > > >      /*
> > > > >       * If we early return in these cases SVQ will not be enabled. The migration
> > > > >       * will be blocked as long as vhost-vdpa backends will not offer _F_LOG.
> > > > > -     *
> > > > > -     * Calling VHOST_GET_BACKEND_FEATURES as they are not available in v->dev
> > > > > -     * yet.
> > > > >       */
> > > > > -    r = ioctl(v->device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features);
> > > > > -    if (unlikely(r < 0)) {
> > > > > -        error_report("Cannot get vdpa backend_features: %s(%d)",
> > > > > -            g_strerror(errno), errno);
> > > > > -        return -1;
> > > > > +    if (!vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> > > > > +        return 0;
> > > > >      }
> > > > > -    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID)) ||
> > > > > -        !vhost_vdpa_net_valid_svq_features(v->dev->features, NULL)) {
> > > > > +
> > > > > +    if (!s->cvq_isolated) {
> > > > >          return 0;
> > > > >      }
> > > > >
> > > > > -    /*
> > > > > -     * Check if all the virtqueues of the virtio device are in a different vq
> > > > > -     * than the last vq. VQ group of last group passed in cvq_group.
> > > > > -     */
> > > > > -    cvq_index = v->dev->vq_index_end - 1;
> > > > > -    cvq_group = vhost_vdpa_get_vring_group(v->device_fd, cvq_index);
> > > > > +    cvq_group = vhost_vdpa_get_vring_group(v->device_fd,
> > > > > +                                           v->dev->vq_index_end - 1,
> > > > > +                                           &err);
> > > > >      if (unlikely(cvq_group < 0)) {
> > > > > +        error_report_err(err);
> > > > >          return cvq_group;
> > > > >      }
> > > > > -    for (int i = 0; i < cvq_index; ++i) {
> > > > > -        int64_t group = vhost_vdpa_get_vring_group(v->device_fd, i);
> > > > > -
> > > > > -        if (unlikely(group < 0)) {
> > > > > -            return group;
> > > > > -        }
> > > > > -
> > > > > -        if (group == cvq_group) {
> > > > > -            return 0;
> > > > > -        }
> > > > > -    }
> > > > >
> > > > >      r = vhost_vdpa_set_address_space_id(v, cvq_group, VHOST_VDPA_NET_CVQ_ASID);
> > > > >      if (unlikely(r < 0)) {
> > > > > @@ -799,6 +776,111 @@ static const VhostShadowVirtqueueOps vhost_vdpa_net_svq_ops = {
> > > > >      .avail_handler = vhost_vdpa_net_handle_ctrl_avail,
> > > > >  };
> > > > >
> > > > > +/**
> > > > > + * Probe the device to check control virtqueue is isolated.
> > > > > + *
> > > > > + * @device_fd vhost-vdpa file descriptor
> > > > > + * @features features to negotiate
> > > > > + * @cvq_index Control vq index
> > > > > + *
> > > > > + * Returns -1 in case of error, 0 if false and 1 if true
> > > > > + */
> > > > > +static int vhost_vdpa_cvq_is_isolated(int device_fd, uint64_t features,
> > > > > +                                      unsigned cvq_index, Error **errp)
> > > > > +{
> > > > > +    int64_t cvq_group;
> > > > > +    int r;
> > > > > +
> > > > > +    r = vhost_vdpa_set_dev_features_fd(device_fd, features);
> > > > > +    if (unlikely(r < 0)) {
> > > > > +        error_setg_errno(errp, -r, "Cannot set device features");
> > > > > +        return r;
> > > > > +    }
> > > > > +
> > > > > +    cvq_group = vhost_vdpa_get_vring_group(device_fd, cvq_index, errp);
> > > > > +    if (unlikely(cvq_group < 0)) {
> > > > > +        return cvq_group;
> > > > > +    }
> > > > > +
> > > > > +    for (int i = 0; i < cvq_index; ++i) {
> > > > > +        int64_t group = vhost_vdpa_get_vring_group(device_fd, i, errp);
> > > > > +
> > > > > +        if (unlikely(group < 0)) {
> > > > > +            return group;
> > > > > +        }
> > > > > +
> > > > > +        if (group == (int64_t)cvq_group) {
> > > > > +            return 0;
> > > > > +        }
> > > > > +    }
> > > > > +
> > > > > +    return 1;
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * Probe if CVQ is isolated when the device is MQ and when it is not MQ
> > > > > + *
> > > > > + * @device_fd         The vdpa device fd
> > > > > + * @features          Features offered by the device.
> > > > > + * @cvq_index         The control vq index if mq is negotiated. Ignored
> > > > > + *                    otherwise.
> > > > > + *
> > > > > + * Returns <0 in case of failure, 0 if false and 1 if true.
> > > > > + */
> > > > > +static int vhost_vdpa_probe_cvq_isolation(int device_fd, uint64_t features,
> > > > > +                                          int cvq_index, Error **errp)
> > > > > +{
> > > > > +    uint64_t backend_features;
> > > > > +    int r;
> > > > > +
> > > > > +    ERRP_GUARD();
> > > > > +
> > > > > +    r = ioctl(device_fd, VHOST_GET_BACKEND_FEATURES, &backend_features);
> > > > > +    if (unlikely(r < 0)) {
> > > > > +        error_setg_errno(errp, errno, "Cannot get vdpa backend_features");
> > > > > +        return r;
> > > > > +    }
> > > > > +
> > > > > +    if (!(backend_features & BIT_ULL(VHOST_BACKEND_F_IOTLB_ASID))) {
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    r = vhost_vdpa_cvq_is_isolated(device_fd,
> > > > > +                                   features & ~BIT_ULL(VIRTIO_NET_F_MQ), 2,
> > > > > +                                   errp);
> > > > > +    if (unlikely(r < 0)) {
> > > > > +        if (r != -ENOTSUP) {
> > > > > +            return r;
> > > > > +        }
> > > > > +
> > > > > +        /*
> > > > > +         * The kernel report VHOST_BACKEND_F_IOTLB_ASID if the vdpa frontend
> > > > > +         * support ASID even if the parent driver does not.  The CVQ cannot be
> > > > > +         * isolated in this case.
> > > > > +         */
> > > > > +        error_free(*errp);
> > > > > +        *errp = NULL;
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    if (r == 0) {
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    vhost_vdpa_reset_status_fd(device_fd);
> > > > > +    if (!(features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> > > > > +        return 0;
> > > > > +    }
> > > > > +
> > > > > +    r = vhost_vdpa_cvq_is_isolated(device_fd, features, cvq_index * 2, errp);
> > > >
> > > > I think checking this once should be sufficient. That is to say, it
> > > > should be a bug if there's hardware that puts cvq in a dedicated group
> > > > in MQ but not in SQ.
> > > >
> > >
> > > This is checking the NIC is not buggy :). Otherwise, we're giving
> > > access to the guest to the CVQ shadow vring. And, currently, SVQ code
> > > assumes only QEMU can access it.
> >
> > Just to make sure we are at the same page, I meant, the hardware
> > should be buggy if the isolation of cvq is not consistent between
> > single and multiqueue.
> >
> 
> Yes, I got you.
> 
> The problem with that particular bug is that we will handle guest's
> vring with the bad IOVA tree. Since QEMU is not sanitizing that
> descriptors anymore, the device can be used to write at qemu memory.
> At this time only SVQ vring and in buffers should be writable by this,
> so it's not a big deal.
> 
> This can also happen if the device is buggy in other ways. For
> example, reporting that CVQ is isolated at VHOST_VDPA_GET_VRING_GROUP
> but then handling maps ignoring the ASID parameter. There is no
> protection for that, so I agree this double check makes little sense.

Ok so you will repost with this check removed?

> > >
> > > But maybe this made more sense in previous versions, where the series
> > > also cached the cvq group here. If I understand you correctly, it is
> > > enough to check that CVQ is isolated in SQ, and assume it will be
> > > isolated also in MQ, right? I can modify the patch that way if you
> > > confirm this.
> >
> > I think so, or just negotiate with what hardware provides us and check.
> >
> 
> To always probe with SQ makes the code simpler, but let me know if you
> think there are advantages to probing otherwise.
> 
> Thanks!


