Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C231198E4E5
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Oct 2024 23:26:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw6qe-00072w-Nd; Wed, 02 Oct 2024 17:25:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sw6qU-00072g-Qu
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 17:25:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sw6qO-0000Tk-BF
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 17:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727904309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TxnEt0CyqN7CcJOssuLrK7ckHzx2Sn37e777HcuaewU=;
 b=FP4vh/VYXTDZbzoc6HTNF+CszL0YhxTMK3yUPTplkQ+en5ahI1AOWVgcQAIRpOGnwceN0Z
 MkhktdOu6mD+QSWqfvkM3hdRXCEeHUcHD6I0FHcbK/QJ/S20WJpCaONy5PY94IXY8d41+g
 Gj/2+G4XtceirrSGo4KfciCCY5yJwrs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-c9mlSDM1Oq26vOiH2bgqBg-1; Wed, 02 Oct 2024 17:25:07 -0400
X-MC-Unique: c9mlSDM1Oq26vOiH2bgqBg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d8b4a23230so260642a91.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 14:25:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727904306; x=1728509106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TxnEt0CyqN7CcJOssuLrK7ckHzx2Sn37e777HcuaewU=;
 b=m6jSuI2LnGzZdUk5MmScUnpCLjKBz54lPErePBmoVjQwuHG2v9tGCFYXDm2OATLKqg
 yl+sVkq1z5NR+d77Y/ltbJmv90vUf51216U0u8Bn2tmUVTMBDJ3DlU/r278Cw3V6tby1
 8WSpP30sLs676HK1VnNNWjySETUKT0Fz0GIvsSwimqCaorSK068UAsGo2oWkrlVKPuPQ
 EoIWlX/o2TCCa/nOIY3ycS8K+LcIqRvu29YRY1Nr2KJo4XIjeuyYyIiuzsYbWljlKCDf
 p2bOv10Oz/JftrIE2LSNT8VNodOjrE4IyuJsAYZCmYct78f23rtp0kLTRdxor0a8gdal
 zWmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHzDgxXB0QHILW5qNi0F6soulbGiiu02TMWuO66BysLRhD7xX2XWGwYGEdLTCHaxwZAD60ykHVoyRI@nongnu.org
X-Gm-Message-State: AOJu0Yx1n0BEXHKBLf++FVJUGCUJ+NAUVcx841pdi8gp4bJrLDl1SOrf
 IC2CmRc+6e5CJqFupOoBZmffCd1nmxCBcGxkYBoRIqC4TbpyUKYpf4s61sbyF8Ephv0yjcJ35HT
 SjVXyO9SWuxS8GTwqyfvmBUcevnY2oyWIxIAQGvW7rMcLz4BxQbdm
X-Received: by 2002:a17:90b:378e:b0:2d3:da6d:8330 with SMTP id
 98e67ed59e1d1-2e184529ed1mr5214330a91.4.1727904306045; 
 Wed, 02 Oct 2024 14:25:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqB7TnpqtIxhn8f+yZEVGmpsfzluVJ9LUYHfC7sBYORe2zlqdhmzwDYXI3FMIwD0L3rP88sA==
X-Received: by 2002:a17:90b:378e:b0:2d3:da6d:8330 with SMTP id
 98e67ed59e1d1-2e184529ed1mr5214293a91.4.1727904305277; 
 Wed, 02 Oct 2024 14:25:05 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e18f74189dsm2122817a91.9.2024.10.02.14.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 14:25:04 -0700 (PDT)
Date: Wed, 2 Oct 2024 17:25:00 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
Message-ID: <Zv26LE_2YIjKk4FL@x1n>
References: <ZuyTjQJujZo6tw9p@x1n>
 <bbed8165-de5c-4ebe-a6cc-ff33f9ea363a@maciej.szmigiero.name>
 <Zu2mvrKOvmD1WtvD@x1n>
 <848ba96d-c3ca-4fbb-9ec4-92023230c026@maciej.szmigiero.name>
 <ZvYCGFnI_68B_w3h@x1n>
 <c013f26f-6e55-4426-9ec9-e160e8179a7a@maciej.szmigiero.name>
 <ZvsesAPD6G4Ef9m0@x1n>
 <927023c9-c8ba-4cdf-9d42-bf1109a139af@maciej.szmigiero.name>
 <ZvxqE0i5qGGiSFk0@x1n>
 <cba181bd-0961-4ea8-962b-2f6bbf09d94a@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cba181bd-0961-4ea8-962b-2f6bbf09d94a@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 02, 2024 at 10:11:33PM +0200, Maciej S. Szmigiero wrote:
> On 1.10.2024 23:30, Peter Xu wrote:
> > On Tue, Oct 01, 2024 at 10:41:14PM +0200, Maciej S. Szmigiero wrote:
> > > On 30.09.2024 23:57, Peter Xu wrote:
> > > > On Mon, Sep 30, 2024 at 09:25:54PM +0200, Maciej S. Szmigiero wrote:
> > > > > On 27.09.2024 02:53, Peter Xu wrote:
> > > > > > On Fri, Sep 27, 2024 at 12:34:31AM +0200, Maciej S. Szmigiero wrote:
> > > > > > > On 20.09.2024 18:45, Peter Xu wrote:
> > > > > > > > On Fri, Sep 20, 2024 at 05:23:08PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > On 19.09.2024 23:11, Peter Xu wrote:
> > > > > > > > > > On Thu, Sep 19, 2024 at 09:49:10PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > > > On 9.09.2024 22:03, Peter Xu wrote:
> > > > > > > > > > > > On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
> > > > > > > > > > > > > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > > > > > > > > > > > > 
> > > > > > > > > > > > > load_finish SaveVMHandler allows migration code to poll whether
> > > > > > > > > > > > > a device-specific asynchronous device state loading operation had finished.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > In order to avoid calling this handler needlessly the device is supposed
> > > > > > > > > > > > > to notify the migration code of its possible readiness via a call to
> > > > > > > > > > > > > qemu_loadvm_load_finish_ready_broadcast() while holding
> > > > > > > > > > > > > qemu_loadvm_load_finish_ready_lock.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >        include/migration/register.h | 21 +++++++++++++++
> > > > > > > > > > > > >        migration/migration.c        |  6 +++++
> > > > > > > > > > > > >        migration/migration.h        |  3 +++
> > > > > > > > > > > > >        migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
> > > > > > > > > > > > >        migration/savevm.h           |  4 +++
> > > > > > > > > > > > >        5 files changed, 86 insertions(+)
> > > > > > > > > > > > > 
> > > > > > > > > > > > > diff --git a/include/migration/register.h b/include/migration/register.h
> > > > > > > > > > > > > index 4a578f140713..44d8cf5192ae 100644
> > > > > > > > > > > > > --- a/include/migration/register.h
> > > > > > > > > > > > > +++ b/include/migration/register.h
> > > > > > > > > > > > > @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
> > > > > > > > > > > > >            int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
> > > > > > > > > > > > >                                     Error **errp);
> > > > > > > > > > > > > +    /**
> > > > > > > > > > > > > +     * @load_finish
> > > > > > > > > > > > > +     *
> > > > > > > > > > > > > +     * Poll whether all asynchronous device state loading had finished.
> > > > > > > > > > > > > +     * Not called on the load failure path.
> > > > > > > > > > > > > +     *
> > > > > > > > > > > > > +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> > > > > > > > > > > > > +     *
> > > > > > > > > > > > > +     * If this method signals "not ready" then it might not be called
> > > > > > > > > > > > > +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> > > > > > > > > > > > > +     * while holding qemu_loadvm_load_finish_ready_lock.
> > > > > > > > > > > > 
> > > > > > > > > > > > [1]
> > > > > > > > > > > > 
> > > > > > > > > > > > > +     *
> > > > > > > > > > > > > +     * @opaque: data pointer passed to register_savevm_live()
> > > > > > > > > > > > > +     * @is_finished: whether the loading had finished (output parameter)
> > > > > > > > > > > > > +     * @errp: pointer to Error*, to store an error if it happens.
> > > > > > > > > > > > > +     *
> > > > > > > > > > > > > +     * Returns zero to indicate success and negative for error
> > > > > > > > > > > > > +     * It's not an error that the loading still hasn't finished.
> > > > > > > > > > > > > +     */
> > > > > > > > > > > > > +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);
> > > > > > > > > > > > 
> > > > > > > > > > > > The load_finish() semantics is a bit weird, especially above [1] on "only
> > > > > > > > > > > > allowed to be called once if ..." and also on the locks.
> > > > > > > > > > > 
> > > > > > > > > > > The point of this remark is that a driver needs to call
> > > > > > > > > > > qemu_loadvm_load_finish_ready_broadcast() if it wants for the migration
> > > > > > > > > > > core to call its load_finish handler again.
> > > > > > > > > > > 
> > > > > > > > > > > > It looks to me vfio_load_finish() also does the final load of the device.
> > > > > > > > > > > > 
> > > > > > > > > > > > I wonder whether that final load can be done in the threads,
> > > > > > > > > > > 
> > > > > > > > > > > Here, the problem is that current VFIO VMState has to be loaded from the main
> > > > > > > > > > > migration thread as it internally calls QEMU core address space modification
> > > > > > > > > > > methods which explode if called from another thread(s).
> > > > > > > > > > 
> > > > > > > > > > Ahh, I see.  I'm trying to make dest qemu loadvm in a thread too and yield
> > > > > > > > > > BQL if possible, when that's ready then in your case here IIUC you can
> > > > > > > > > > simply take BQL in whichever thread that loads it.. but yeah it's not ready
> > > > > > > > > > at least..
> > > > > > > > > 
> > > > > > > > > Yeah, long term we might want to work on making these QEMU core address space
> > > > > > > > > modification methods somehow callable from multiple threads but that's
> > > > > > > > > definitely not something for the initial patch set.
> > > > > > > > > 
> > > > > > > > > > Would it be possible vfio_save_complete_precopy_async_thread_config_state()
> > > > > > > > > > be done in VFIO's save_live_complete_precopy() through the main channel
> > > > > > > > > > somehow?  IOW, does it rely on iterative data to be fetched first from
> > > > > > > > > > kernel, or completely separate states?
> > > > > > > > > 
> > > > > > > > > The device state data needs to be fully loaded first before "activating"
> > > > > > > > > the device by loading its config state.
> > > > > > > > > 
> > > > > > > > > > And just curious: how large is it
> > > > > > > > > > normally (and I suppose this decides whether it's applicable to be sent via
> > > > > > > > > > the main channel at all..)?
> > > > > > > > > 
> > > > > > > > > Config data is *much* smaller than device state data - as far as I remember
> > > > > > > > > it was on order of kilobytes.
> > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > > then after
> > > > > > > > > > > > everything loaded the device post a semaphore telling the main thread to
> > > > > > > > > > > > continue.  See e.g.:
> > > > > > > > > > > > 
> > > > > > > > > > > >           if (migrate_switchover_ack()) {
> > > > > > > > > > > >               qemu_loadvm_state_switchover_ack_needed(mis);
> > > > > > > > > > > >           }
> > > > > > > > > > > > 
> > > > > > > > > > > > IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
> > > > > > > > > > > > when all things are loaded?  We can then get rid of this slightly awkward
> > > > > > > > > > > > interface.  I had a feeling that things can be simplified (e.g., if the
> > > > > > > > > > > > thread will take care of loading the final vmstate then the mutex is also
> > > > > > > > > > > > not needed? etc.).
> > > > > > > > > > > 
> > > > > > > > > > > With just a single call to switchover_ack_needed per VFIO device it would
> > > > > > > > > > > need to do a blocking wait for the device buffers and config state load
> > > > > > > > > > > to finish, therefore blocking other VFIO devices from potentially loading
> > > > > > > > > > > their config state if they are ready to begin this operation earlier.
> > > > > > > > > > 
> > > > > > > > > > I am not sure I get you here, loading VFIO device states (I mean, the
> > > > > > > > > > non-iterable part) will need to be done sequentially IIUC due to what you
> > > > > > > > > > said and should rely on BQL, so I don't know how that could happen
> > > > > > > > > > concurrently for now.  But I think indeed BQL is a problem.
> > > > > > > > > Consider that we have two VFIO devices (A and B), with the following order
> > > > > > > > > of switchover_ack_needed handler calls for them: first A get this call,
> > > > > > > > > once the call for A finishes then B gets this call.
> > > > > > > > > 
> > > > > > > > > Now consider what happens if B had loaded all its buffers (in the loading
> > > > > > > > > thread) and it is ready for its config load before A finished loading its
> > > > > > > > > buffers.
> > > > > > > > > 
> > > > > > > > > B has to wait idle in this situation (even though it could have been already
> > > > > > > > > loading its config) since the switchover_ack_needed handler for A won't
> > > > > > > > > return until A is fully done.
> > > > > > > > 
> > > > > > > > This sounds like a performance concern, and I wonder how much this impacts
> > > > > > > > the real workload (that you run a test and measure, with/without such
> > > > > > > > concurrency) when we can save two devices in parallel anyway; I would
> > > > > > > > expect the real diff is small due to the fact I mentioned that we save >1
> > > > > > > > VFIO devices concurrently via multifd.
> > > > > > > > 
> > > > > > > > Do you think we can start with a simpler approach?
> > > > > > > 
> > > > > > > I don't think introducing a performance/scalability issue like that is
> > > > > > > a good thing, especially that we already have a design that avoids it.
> > > > > > > 
> > > > > > > Unfortunately, my current setup does not allow live migrating VMs with
> > > > > > > more than 4 VFs so I can't benchmark that.
> > > > > > 
> > > > > > /me wonders why benchmarking it requires more than 4 VFs.
> > > > > 
> > > > > My point here was that the scalability problem will most likely get more
> > > > > pronounced with more VFs.
> > > > > 
> > > > > > > 
> > > > > > > But I almost certain that with more VFs the situation with devices being
> > > > > > > ready out-of-order will get even more likely.
> > > > > > 
> > > > > > If the config space is small, why loading it in sequence would be a
> > > > > > problem?
> > > > > > 
> > > > > > Have you measured how much time it needs to load one VF's config space that
> > > > > > you're using?  I suppose that's vfio_load_device_config_state() alone?
> > > > > 
> > > > > It's not the amount of data to load matters here but that these address
> > > > > space operations are slow.
> > > > > 
> > > > > The whole config load takes ~70 ms per device - that's time equivalent
> > > > > of transferring 875 MiB of device state via a 100 GBit/s link.
> > > > 
> > > > What's the downtime of migration with 1/2/4 VFs?  I remember I saw some
> > > > data somewhere but it's not in the cover letter.  It'll be good to mention
> > > > these results in the cover letter when repost.
> > > 
> > > Downtimes with the device state transfer being disabled / enabled:
> > >              4 VFs   2 VFs    1 VF
> > > Disabled: 1783 ms  614 ms  283 ms
> > > Enabled:  1068 ms  434 ms  274 ms
> > > 
> > > Will add these numbers to the cover letter of the next patch set version.
> > 
> > Thanks.
> > 
> > > 
> > > > I'm guessing 70ms isn't a huge deal here, if your NIC has 128GB internal
> > > > device state to migrate.. but maybe I'm wrong.
> > > 
> > > It's ~100 MiB of device state per VF here.
> > 
> > Ouch..
> > 
> > I watched your kvm forum talk recording, I remember that's where I get that
> > 128 number but probably get the unit wrong.. ok that makes sense.
> > 
> > > 
> > > And it's 70ms of downtime *per device*:
> > > so with 4 VF it's ~280ms of downtime taken by the config loads.
> > > That's a lot - with perfect parallelization this downtime should
> > > *reduce by* 210ms.
> > 
> > Yes, in this case it's a lot.  I wonder why it won't scale as good even
> > with your patchset.
> > 
> > Did you profile why?  I highly doubt in your case network is an issue, as
> > there's only 100MB per-dev data, so even on 10gbps it takes 100ms only to
> > transfer for each, while now assuming it can run concurrently.  I think you
> > mentioned you were using 100gbps, right?
> 
> Right, these 2 test machines are connected via a 100 GBbps network.
> 
> > Logically when with multiple threads, VFIO read()s should happen at least
> > concurrently per-device.  Have you checked that there's no kernel-side
> > global VFIO lock etc. that serializes portions of the threads read()s /
> > write()s on the VFIO fds?
> 
> For these devices the kernel side has been significantly improved a year ago:
> https://lore.kernel.org/kvm/20230911093856.81910-1-yishaih@nvidia.com/
> 
> In the mlx5 driver the in-kernel device reading task (work) is separated
> from the userspace (QEMU) read()ing task via a double/multi buffering scheme.
> 
> If there was indeed some global lock serializing all device accesses we
> wouldn't be seeing that much improvement from this patch set as we are
> seeing - especially that the improvement seems to *increase* with the
> increased VF count in a single PF.
> 
> > It's just a pity that you went this far, added all these logics, but
> > without making it fully concurrent at least per device.
> 
> AFAIK NVIDIA/Mellanox are continuously working on improving the mlx5 driver,
> but to benefit from the driver parallelism we need parallelism in QEMU
> too so the userspace won't become the serialization point/bottleneck.
> 
> In other words, it's kind of a chicken and egg problem.
> 
> That's why I want to preserve as much parallelism in this patch set as
> possible to avoid accidental serialization which (even if not a problem
> right now) may become the bottleneck at some point.
> 
> > I'm OK if you want this in without that figured out, but if I were you I'll
> > probably try to dig a bit to at least know why.
> > 
> > > 
> > > > I also wonder whether you profiled a bit on how that 70ms contributes to
> > > > what is slow.
> > > 
> > > I think that's something we can do after we have parallel config loads
> > > and it turns out their downtime for some reason still scales strongly
> > > linearly with the number of VFIO devices (rather than taking roughly
> > > constant time regardless of the count of these devices if running perfectly
> > > in parallel).
> > 
> > Similarly, I wonder whether the config space load() can involves something
> > globally shared.  I'd also dig a bit here, but I'll leave that to you to
> > decide.
> 
> Making config loads thread-safe/parallelizable is definitely on my future
> TODO list.
> 
> Just wanted to keep the amount of changes in the first version of this
> patch set within reasonable bounds - one has to draw a line somewhere
> otherwise we'll keep working on this patch set forever, with the
> QEMU code being a moving target meanwhile.
> 
> > > 
> > > > > 
> > > > > > > 
> > > > > > > > So what I'm thinking could be very clean is, we just discussed about
> > > > > > > > MIG_CMD_SWITCHOVER and looks like you also think it's an OK approach.  I
> > > > > > > > wonder when with it why not we move one step further to have
> > > > > > > > MIG_CMD_SEND_NON_ITERABE just to mark that "iterable devices all done,
> > > > > > > > ready to send non-iterable".  It can be controlled by the same migration
> > > > > > > > property so we only send these two flags in 9.2+ machine types.
> > > > > > > > 
> > > > > > > > Then IIUC VFIO can send config data through main wire (just like most of
> > > > > > > > other pci devices! which is IMHO a good fit..) and on destination VFIO
> > > > > > > > holds off loading them until passing the MIG_CMD_SEND_NON_ITERABE phase.
> > > > > > > 
> > > > > > > Starting the config load only on MIG_CMD_SEND_NON_ITERABE would (in addition
> > > > > > > to the considerations above) also delay starting the config load until all
> > > > > > > iterable devices were read/transferred/loaded and also would complicate
> > > > > > > future efforts at loading that config data in parallel.
> > > > > > 
> > > > > > However I wonder whether we can keep it simple in that VFIO's config space
> > > > > > is still always saved in vfio_save_state().  I still think it's easier we
> > > > > > stick with the main channel whenever possible.  For this specific case, if
> > > > > > the config space is small I think it's tricky you bypass this with:
> > > > > > 
> > > > > >        if (migration->multifd_transfer) {
> > > > > >            /* Emit dummy NOP data */
> > > > > >            qemu_put_be64(f, VFIO_MIG_FLAG_END_OF_STATE);
> > > > > >            return;
> > > > > >        }
> > > > > > 
> > > > > > Then squash this as the tail of the iterable data.
> > > > > > 
> > > > > > On the src, I think it could use a per-device semaphore, so that iterable
> > > > > > save() thread will post() only if it finishes dumping all the data, then
> > > > > > that orders VFIO iterable data v.s. config space save().
> > > > > 
> > > > > In the future we want to not only transfer but also load the config data
> > > > > in parallel.
> > > > 
> > > > How feasible do you think this idea is?  E.g. does it involve BQL so far
> > > > (e.g. memory updates, others)?  What's still missing to make it concurrent?
> > > 
> > > My gut feeling is that is feasible overall but it's too much of a rabbit
> > > hole for the first version of this device state transfer feature.
> > > 
> > > I think it will need some deeper QEMU core address space management changes,
> > > which need to be researched/developed/tested/reviewed/etc. on their own.
> > > 
> > > If it was an easy task I would have gladly included such support in this
> > > patch set version already for extra downtime reduction :)
> > 
> > Yes I understand.
> > 
> > Note that it doesn't need to be implemented and resolved in one shot, but I
> > wonder if it'll still be good to debug the issue and know where is not
> > scaling.
> > 
> > Considering that your design is fully concurrent as of now on iterable data
> > from QEMU side, it's less persuasive to provide perf numbers that still
> > doesn't scale that much; 1.78s -> 1.06s is a good improvement, but it
> > doesn't seem to solve the scalability issue that this whole series wanted
> > to address in general.
> > 
> > An extreme (bad) example is if VFIO has all ioctl()/read()/write() take a
> > global lock, then any work in QEMU trying to run things in parallel will be
> > a vain.  Such patchset cannot be accepted because the other issue needs to
> > be resolved first.
> > 
> > Now it's in the middle of best/worst condition, where it did improve but it
> > still doesn't scale that well.  I think it can be accepted, but still I
> > feel like we're ignoring some of the real issues.  We can choose to ignore
> > the kernel saying that "it's too much to do together", but IMHO the issues
> > should be tackled in the other way round.. the normal case is one should
> > work out the kernel scalability issues, then QEMU should be on top.. Simply
> > because any kernel change that might scale >1 device save()/load() can
> > affect future QEMU change and design, not vice versa.
> > 
> > Again, I know you wished we make some progress, so I don't have a strong
> > opinion.  Just FYI.
> > 
> 
> As I wrote above, the kernel side of things are being taken care of by
> the mlx5 driver maintainers.
> 
> And these performance numbers suggest that there isn't some global lock
> serializing all device accesses as otherwise it would quickly become
> the bottleneck and we would be seeing diminishing improvement from
> increased VF count instead of increased improvement.

Personally I am not satisfied with scaling with these numbers..

  1VF       2VFs      4VFs
  274 ms -> 434 ms -> 1068 ms

The lock doesn't need to be as stupid as a global lock that all ioctl()s
take and it might not be as obvious that we can easily see.  It can hide
internally, it can be not in the form of a lock at all.

1068 is almost 4x of 274 here, that's really not scalable at all even if it
is improvement for sure..  I still feel like something is off.  If you
think kernel isn't the bottleneck, I am actually more curious on why,
especially if that could be relevant to the qemu design.

> 
> (..)
> > > > > 
> > > > > >        that I feel like perhaps can be replaced by a sem (then to drop the
> > > > > >        condvar)?
> > > > > 
> > > > > Once we have ability to load device config state outside main migration
> > > > > thread replacing "load_finish" handler with a semaphore should indeed be
> > > > > possible (that's internal migration API so there should be no issue
> > > > > removing it as not necessary anymore at this point).
> > > > > 
> > > > > But for now, the devices need to have ability to run their config load
> > > > > code on the main migration thread, and for that they need to be called
> > > > > from this handler "load_finish".
> > > > 
> > > > A sem seems a must here to notify the iterable data finished loading, but
> > > > that doesn't need to hook to the vmstate handler, but some post-process
> > > > tasks, like what we do around cpu_synchronize_all_post_init() time.
> > > > 
> > > > If per-device vmstate handler hook version of load_finish() is destined to
> > > > look as weird in this case, I'd rather consider a totally separate way to
> > > > enqueue some jobs that needs to be run after all vmstates loaded.  Then
> > > > after one VFIO device fully loads its data, it enqueues the task and post()
> > > > to one migration sem saying that "there's one post-process task, please run
> > > > it in migration thread".  There can be a total number of tasks registered
> > > > so that migration thread knows not to continue until these number of tasks
> > > > processed.  That counter can be part of vmstate handler, maybe, reporting
> > > > that "this vmstate handler has one post-process task".
> > > > 
> > > > Maybe you have other ideas, but please no, let's avoid this load_finish()
> > > > thing..
> > > 
> > > I can certainly implement the task-queuing approach instead of the
> > > load_finish() handler API if you like such approach more.
> > 
> > I have an even simpler solution now.  I think you can reuse precopy
> > notifiers.
> > 
> > You can add one new PRECOPY_NOTIFY_INCOMING_COMPLETE event, invoke it after
> > vmstate load all done.
> > 
> > As long as VFIO devices exist, VFIO can register with that event, then it
> > can do whatever it wants in the main loader thread with BQL held.
> > 
> > You can hide that sem post() / wait() all there, then it's completely VFIO
> > internal.  Then we leave vmstate handler alone; it just doesn't sound
> > suitable when the hooks need to be called out of order.
> 
> I can certainly implement this functionality via a new
> precopy_notify(PRECOPY_NOTIFY_INCOMING_COMPLETE) notifier, for example
> by having a single notify handler registered by the VFIO driver, which
> handler will be common to all VFIO devices.
> 
> This handler on the VFIO driver side will then take care of proper operation
> ordering between the existing VFIO devices.

Great!

> 
> > > > > 
> > > > > >      - How qemu_loadvm_load_finish_ready_broadcast() interacts with all
> > > > > >        above..
> > > > > > 
> > > > > > So if you really think it matters to load whatever VFIO device who's
> > > > > > iterable data is ready first, then let's try come up with some better
> > > > > > interface..  I can try to think about it too, but please answer me
> > > > > > questions above so I can understand what I am missing on why that's
> > > > > > important.  Numbers could help, even if 4 VF and I wonder how much diff
> > > > > > there can be.  Mostly, I don't know why it's slow right now if it is; I
> > > > > > thought it should be pretty fast, at least not a concern in VFIO migration
> > > > > > world (which can take seconds of downtime or more..).
> > > > > > 
> > > > > > IOW, it sounds more reasonalbe to me that no matter whether vfio will
> > > > > > support multifd, it'll be nice we stick with vfio_load_state() /
> > > > > > vfio_save_state() for config space, and hopefully it's also easier it
> > > > > > always go via the main channel to everyone.  In these two hooks, VFIO can
> > > > > > do whatever it wants to sync with other things (on src, sync with
> > > > > > concurrent thread pool saving iterable data and dumping things to multifd
> > > > > > channels; on dst, sync with multifd concurrent loads). I think it can
> > > > > > remove the requirement on the load_finish() interface completely.  Yes,
> > > > > > this can only load VFIO's pci config space one by one, but I think this is
> > > > > > much simpler, and I hope it's also not that slow, but I'm not sure.
> > > > > 
> > > > > To be clear, I made a following diagram describing how the patch set
> > > > > is supposed to work right now, including changing per-device
> > > > > VFIO_MIG_FLAG_DEV_DATA_STATE_COMPLETE into a common MIG_CMD_SWITCHOVER.
> > > > > 
> > > > > Time flows on it left to right (->).
> > > > > 
> > > > > ----------- DIAGRAM START -----------
> > > > > Source overall flow:
> > > > > Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable                                                                          -> non iterable
> > > > > Multifd channels:                                       \ multifd device state read and queue (1) -> multifd config data read and queue (1) /
> > > > > 
> > > > > Target overall flow:
> > > > > Main channel: live VM phase data -> MIG_CMD_SWITCHOVER -> iterable -> non iterable -> config data load operations
> > > > > Multifd channels:                                       \ multifd device state (1) -> multifd config data read (1)
> > > > > 
> > > > > Target config data load operations flow:
> > > > > multifd config data read (1) -> config data load (2)
> > > > > 
> > > > > Notes:
> > > > > (1): per device threads running in parallel
> > > > 
> > > > Here I raised this question before, but I'll ask again: do you think we can
> > > > avoid using a separate thread on dest qemu, but reuse multifd recv threads?
> > > > 
> > > > Src probably needs its own threads because multifd sender threads takes
> > > > request, so it can't block on its own.
> > > > 
> > > > However dest qemu isn't like that, it's packet driven so I think maybe it's
> > > > ok VFIO directly loads the data in the multifd threads.  We may want to
> > > > have enough multifd threads to make sure IO still don't block much on the
> > > > NIC, but I think tuning the num of multifd threads should work in this
> > > > case.
> > > 
> > > We need to have the receiving threads decoupled from the VFIO device state
> > > loading threads at least because otherwise:
> > > 1) You can have a deadlock if device state for multiple devices arrives
> > > out of order, like here:
> > > 
> > > Time flows left to right (->).
> > > Multifd channel 1: (VFIO device 1 buffer 2) (VFIO device 2 buffer 1)
> > > Multifd channel 2: (VFIO device 2 buffer 2) (VFIO device 1 buffer 1)
> > > 
> > > Both channel receive/load threads would be stuck forever in this case,
> > > since they can't load buffer 2 for devices 1 and 2 until they load
> > > buffer 1 for each of these devices.
> > > 
> > > 2) If devices are loading buffers at different speeds you don't want
> > > to block the faster device from receiving new buffer just because
> > > the slower one hasn't finished its loading yet.
> > 
> > I don't see why it can't be avoided.  Let me draw this in columns.
> > 
> > How I picture this is:
> > 
> >     multifd recv thread 1                     multifd recv thread 2
> >     ---------------------                     ---------------------
> >     recv VFIO device 1 buffer 2             recv VFIO device 2 buffer 2
> >      -> found that (dev1, buf1) missing,      -> found that (dev2, buf1) missing,
> >         skip load                                skip load
> >     recv VFIO device 2 buffer 1             recv VFIO device 1 buffer 1
> >      -> found that (dev2, buf1+buf2) ready,   -> found that (dev1, buf1+buf2) ready,
> >         load buf1+2 for dev2 here                load buf1+2 for dev1 here
> > Here right after one multifd thread recvs a buffer, it needs to be injected
> > into the cache array (with proper locking), so that whoever receives a full
> > series of those buffers will do the load (again, with proper locking..).
> > 
> > Would this not work?
> > 
> 
> For sure but that's definitely more complicated logic than just having
> a simple device loading thread that naturally loads incoming buffers
> for that device in-order.

I thought it was mostly your logic that was implemented, but yeah I didn't
check too much details on VFIO side.

> That thread isn't even in the purview of the migration code since
> it's a VFIO driver internal implementation detail.
> 
> And we'd still lose parallelism if it happens that two buffers that
> are to be loaded next for two devices happen to arrive in the same
> multifd channel:
> Multifd channel 1: (VFIO device 1 buffer 1) (VFIO device 2 buffer 1)
> Multifd channel 2: (VFIO device 2 buffer 2) (VFIO device 1 buffer 2)
> 
> Now device 2 buffer 1 has to wait until loading device 1 buffer 1
> finishes even thought with the decoupled loading thread implementation
> from this patch set these would be loaded in parallel.

Well it's possible indeed, but with normally 8 or more threads being there,
possibility of having such dependency is low.

Cedric has similar comment on starting from simple on the thread model.
I'd still suggest if ever possible we try reuse multifd recv threads; I do
expect the results should be similar.

I am sorry to ask for this, Fabiano already blames me for this, but..
logically it'll be best we use no new thread in the series, then one patch
on top with your new thread solution to justify its performance benefits
and worthwhile to having those threads at all.

PS: I'd suggest if you really need those threads it should still be managed
by migration framework like the src thread pool.  Sorry I'm pretty stubborn
on this, especially after I notice we have query-migrationthreads API just
recently.. even if now I'm not sure whether we should remove that API.  I
assume that shouldn't need much change, even if necessary.

Thanks,

-- 
Peter Xu


