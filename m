Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4A74AE61
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 11:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHiDV-0005XG-4G; Fri, 07 Jul 2023 05:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHiDS-0005Ws-Mb
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHiDQ-0007EX-TB
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 05:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688723848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/dIX253dVfraFuoXO78AeOKruzKxsZtte4eZK0L+66I=;
 b=Vf+LPL/wEH7fD9suGpVM8zzg0uYMPl/HTzsS+Ol90Rby4N2oX8kNUGRK9eJSxcbijzBqcF
 NXuxw7cwWb3we7GxhJMD8xM/YP114uHLxBKTUAQNM6fNuD2V7zbt46KIImjUdl0+dwV4Bu
 7UH48ToIjDx28mVSUIfLpCWpKG0hEZM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-jeYZaxBcNRm9s_ZVlJZDnw-1; Fri, 07 Jul 2023 05:57:26 -0400
X-MC-Unique: jeYZaxBcNRm9s_ZVlJZDnw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31400956ce8so879569f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 02:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688723846; x=1691315846;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/dIX253dVfraFuoXO78AeOKruzKxsZtte4eZK0L+66I=;
 b=Swoc+2ILETVn+3jItMXtj4Mf10DmfqEfcVd4WPlG62lUN5h0Vs/8XB3JWvbX6l5A9U
 KxME3N9b94FAGfSlKAPTlgTmqZewIPb4st0lXw4L/9b2LZYeuVLYKP128ddG/hx/JTrV
 0YxpN6KdO/Y23nT9mFwx5ax45mhRArql/j6fSGnqQ+OKzg+v/arHg3NGRIIg6O4uOv6Y
 h7cwmkCNhOWbG4BB2sGv6YasWq7z1ud8aIo/v0CKujXtC19hatf+ocgk2Sf+lRLt2Ziv
 cIMI3bVur0o0onCRlWCF6KnRJeFEzfj1uATx4Hk6Ui/wxQ3dEzJorzW9ZWpcLhai/IWr
 NaVA==
X-Gm-Message-State: ABy/qLZPWoILxZbFqNU9j8eTy4FCKPjT8BEVOtgd0cfkxRrerd9pInec
 qX8Cj5O6U69u+0UEo5sljcV8lGPYK98Z96xJY76E5Z18ZzmONpJ8aPBbd9i65YjG0GoxSFbDOL+
 bYkzAxHZ3MWqn3hg=
X-Received: by 2002:adf:fc4e:0:b0:314:10d8:b491 with SMTP id
 e14-20020adffc4e000000b0031410d8b491mr3698233wrs.67.1688723845816; 
 Fri, 07 Jul 2023 02:57:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlERWKNZgkUMMqALvFBDmlw5jND4B8XuLB6IlHMKB0k0yTjunZn48hyqZBSGBWFIzHzElcC3ig==
X-Received: by 2002:adf:fc4e:0:b0:314:10d8:b491 with SMTP id
 e14-20020adffc4e000000b0031410d8b491mr3698220wrs.67.1688723845511; 
 Fri, 07 Jul 2023 02:57:25 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 t4-20020a5d5344000000b0031417fd473csm4035474wrv.78.2023.07.07.02.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 02:57:24 -0700 (PDT)
Date: Fri, 7 Jul 2023 05:57:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, slp@redhat.com,
 marcandre.lureau@redhat.com, stefanha@redhat.com,
 viresh.kumar@linaro.org, sgarzare@redhat.com,
 takahiro.akashi@linaro.org, erik.schilling@linaro.org,
 manos.pitsidianakis@linaro.org, mathieu.poirier@linaro.org
Subject: Re: [RFC PATCH] docs/interop: define STANDALONE protocol feature for
 vhost-user
Message-ID: <20230707055141-mutt-send-email-mst@kernel.org>
References: <20230704123600.1808604-1-alex.bennee@linaro.org>
 <20230706124347-mutt-send-email-mst@kernel.org>
 <87ilawdtug.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ilawdtug.fsf@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Jul 07, 2023 at 08:58:00AM +0100, Alex Bennée wrote:
> 
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Tue, Jul 04, 2023 at 01:36:00PM +0100, Alex Bennée wrote:
> >> Currently QEMU has to know some details about the back-end to be able
> >> to setup the guest. While various parts of the setup can be delegated
> >> to the backend (for example config handling) this is a very piecemeal
> >> approach.
> >
> >> This patch suggests a new feature flag (VHOST_USER_PROTOCOL_F_STANDALONE)
> >> which the back-end can advertise which allows a probe message to be
> >> sent to get all the details QEMU needs to know in one message.
> >
> > The reason we do piecemeal is that these existing pieces can be reused
> > as others evolve or fall by wayside.
> 
> Sure I have no objection in principle but we then turn code like:
> 
>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_STANDALONE)) {
>             err = vhost_user_get_backend_specs(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_specs failed");
>                 return -EPROTO;
>             }
>         }
> 
> to
> 
>         if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_ID) &&
>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_CFGSZ) &&
>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MINVQ) &&
>             dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MAXVQ)
>         ) {
>             err = vhost_user_get_virtio_id(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_id failed");
>                 return -EPROTO;
>             }
>             err = vhost_user_get_virtio_cfgsz(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_cfgsz failed");
>                 return -EPROTO;
>             }
>             err = vhost_user_get_virtio_minvq(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_minvq failed");
>                 return -EPROTO;
>             }
>             err = vhost_user_get_virtio_maxvq(dev, errp);
>             if (err < 0) {
>                 error_setg_errno(errp, EPROTO, "vhost_get_backend_maxvq failed");
>                 return -EPROTO;
>             }
>             dev->specs.valid = true;
>         }
> 
> for little gain IMHO.
>
> > For example, I can think of instances where you want to connect
> > specifically to e.g. networking backend, and specify it
> > on command line. Reasons could be many, e.g. for debugging,
> > or to prevent connecting to wrong device on wrong channel
> > (kind of like type safety).
> 
> I don't quite follow what you are trying to say here.

That some or all of these might be better on qemu command line
not come from backend. Then we'll want to *send* it to backend.
All this at our discretion without protocol changes.


> > What is the reason to have 1 message? startup latency?
> > How about we allow pipelining several messages then?
> > Will be easier.
> 
> I'm not overly worried about performance because this is all at
> start-up. I am worried about excessive complexity though. We already
> have quite a lot of interacting protocol messages.
> 
> >
> >
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >> 
> >> ---
> >> Initial RFC for discussion. I intend to prototype this work with QEMU
> >> and one of the rust-vmm vhost-user daemons.
> >> ---
> >>  docs/interop/vhost-user.rst | 37 +++++++++++++++++++++++++++++++++++++
> >>  hw/virtio/vhost-user.c      |  8 ++++++++
> >>  2 files changed, 45 insertions(+)
> >> 
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index 5a070adbc1..85b1b1583a 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -275,6 +275,21 @@ Inflight description
> >>  
> >>  :queue size: a 16-bit size of virtqueues
> >>  
> >> +Backend specifications
> >> +^^^^^^^^^^^^^^^^^^^^^^
> >> +
> >> ++-----------+-------------+------------+------------+
> >> +| device id | config size |   min_vqs  |   max_vqs  |
> >> ++-----------+-------------+------------+------------+
> >> +
> >> +:device id: a 32-bit value holding the VirtIO device ID
> >> +
> >> +:config size: a 32-bit value holding the config size (see ``VHOST_USER_GET_CONFIG``)
> >> +
> >> +:min_vqs: a 32-bit value holding the minimum number of vqs supported
> >> +
> >> +:max_vqs: a 32-bit value holding the maximum number of vqs supported, must be >= min_vqs
> >> +
> >
> > looks like a weird set of info.
> 
> It's basically the information you need for -device vhost-user-device to
> start-up (and what is essentially the information set by the stubs as
> they start-up).
> 
> > why would we want # of vqs and not their sizes?
> 
> I thought the vring's themselves where allocated by the driver. We only
> need to the number of vqs so we can allocate the tracking structures.

size is specified by device though

> > why config size but not config itself?
> 
> We already have GET_CONFIG and SET_CONFIG but without knowing the size
> of the config space we can't properly set it up.

I don't get it. each message includes size already.

> <snip>
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro


