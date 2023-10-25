Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 149427D7036
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:58:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfL1-0007st-0s; Wed, 25 Oct 2023 10:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvfKz-0007sj-PC
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:58:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvfKx-0008SM-QF
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698245901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Nonxx6UnLjj6O/4oTsbpBpYFUi7/wKP34Cgdahjmxs=;
 b=jN94wlb7u6x5JXU37nk1WErOmo1WQr1ZoYSavKDFDdKAfBBBQIntdI9XIs6atu6Vgl881N
 +PhfI5GQlEtG12OS+nNLjFjiM4f6lDiZ2zPtHtXxuYvGMriPEcWuoboFIwB9wsntnSiiaG
 2SChn/aVsKgXpUgGuCntvnJGlFanCOI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-iOX7PGogMMGN8DBqBmXR_Q-1; Wed, 25 Oct 2023 10:58:19 -0400
X-MC-Unique: iOX7PGogMMGN8DBqBmXR_Q-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e352779d5so2134201cf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 07:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698245899; x=1698850699;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Nonxx6UnLjj6O/4oTsbpBpYFUi7/wKP34Cgdahjmxs=;
 b=a11ws2FTR22ktJmMTVQoa8APmUL0rrF9rLwpW59ky10ywkPLuU1W18ld6SYONtZFMU
 zXiDbBHIZD7WzRpeZ26bk23riMA5uN+LWQNpgsnUHU0M+/uAupvr3BirONB2BVTgjDnt
 ysVDA7zTN5dTGV6MtqqiigjpYsmdDk8HkqQq2S+zZ16LAtNhDciQTd74eomCMqAUORPC
 zO4qAPQM3iOuEcNJU7T3hN81rEY5SPI7kdinnGiim6rCQx2z7znhOJMOrm9p5BdZm+Jc
 ZVYODyqEQoWk9xw7EGFClRSYX2U1QARM1luoMNuL+ofkQkZfy+aZAU7SRtxpL1D8dC/O
 W0Og==
X-Gm-Message-State: AOJu0Yz0QjSgIjCdz8ydoK/Qc7QQ7ntPXbZ7OQIbaAtM5/0NZw0kkMtF
 p7AhHznByUdeAKd+0h1UwmovNo/ZB1VftyQLvj8ZIYqR8j4MLjxydjOOq+Uv2SqQy+GBusmPP3h
 vPlyY2+mvzwwYcuQ=
X-Received: by 2002:a05:622a:3c8:b0:417:b902:16b4 with SMTP id
 k8-20020a05622a03c800b00417b90216b4mr19282657qtx.2.1698245899360; 
 Wed, 25 Oct 2023 07:58:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGde3oRlAtQS/4hp5KHS6CnasI7dwhksBA1TqzTXfx2o4RKQtgFIusxLe8RW5jW2sD2xtZbeA==
X-Received: by 2002:a05:622a:3c8:b0:417:b902:16b4 with SMTP id
 k8-20020a05622a03c800b00417b90216b4mr19282637qtx.2.1698245898957; 
 Wed, 25 Oct 2023 07:58:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f2-20020ac87f02000000b004198f67acbesm4247589qtk.63.2023.10.25.07.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 07:58:18 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:58:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTktCM/ccipYaJ80@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
 <ZTjWV9wQ5obKTpOG@redhat.com> <87y1fqerev.fsf@suse.de>
 <ZTkkICSD6j6Xf/KK@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTkkICSD6j6Xf/KK@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 25, 2023 at 03:20:16PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 25, 2023 at 10:57:12AM -0300, Fabiano Rosas wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > On Mon, Oct 23, 2023 at 05:35:45PM -0300, Fabiano Rosas wrote:
> > >> Add a capability that allows the management layer to delegate to QEMU
> > >> the decision of whether to pause a VM and perform a non-live
> > >> migration. Depending on the type of migration being performed, this
> > >> could bring performance benefits.
> > >
> > > I'm not really see what problem this is solving.
> > >
> > 
> > Well, this is the fruit of your discussion with Peter Xu in the previous
> > version of the patch.
> > 
> > To recap: he thinks QEMU is doing useless work with file migrations
> > because they are always asynchronous. He thinks we should always pause
> > before doing fixed-ram migration. You said that libvirt would rather use
> > fixed-ram for a more broad set of savevm-style commands, so you'd rather
> > not always pause. I'm trying to cater to both of your wishes. This new
> > capability is the middle ground I came up with.
> > 
> > So fixed-ram would always pause the VM, because that is the primary
> > use-case, but libvirt would be allowed to say: don't pause this time.
> 
> If the VM is going to be powered off immediately after saving
> a snapshot then yes, you might as well pause it, but we can't
> assume that will be the case.  An equally common use case
> would be for saving periodic snapshots of a running VM. This
> should be transparent such that the VM remains running the
> whole time, except a narrow window at completion of RAM/state
> saving where we flip the disk snapshots, so they are in sync
> with the RAM snapshot.

Libvirt will still use fixed-ram for live snapshot purpose, especially for
Windows?  Then auto-pause may still be useful to identify that from what
Fabiano wants to achieve here (which is in reality, non-live)?

IIRC of previous discussion that was the major point that libvirt can still
leverage fixed-ram for a live case - since Windows lacks efficient live
snapshot (background-snapshot feature).

From that POV it sounds like auto-pause is a good knob for that.

> 
> IOW, save/restore to disk can imply paused, but snapshotting
> should not imply paused. So I don't see an unambiguous
> rationale that we should diverge when fixed-ram is set and
> auto-pause the VM.
> 
> > > Mgmt apps are perfectly capable of pausing the VM before issuing
> > > the migrate operation.
> > >
> > 
> > Right. But would QEMU be allowed to just assume that if a VM is paused
> > at the start of migration it can then go ahead and skip all dirty page
> > mechanisms?
> 
> Skipping dirty page tracking would imply that the mgmt app cannot
> resume CPUs without either letting the operation complete, or
> aborting it.
> 
> That is probably a reasonable assumption, as I can't come up with
> a use case for starting out paused and then later resuming, unless
> there was a scearnio where you needed to synchronous something
> external with the start of migration.  Sychronizing storage though
> is something that happens at the end of migration instead.
> 
> > Without pausing, we're basically doing *live* migration into a static
> > file that will be kept on disk for who knows how long before being
> > restored on the other side. We could release the src QEMU resources (a
> > bit) earlier if we paused the VM beforehand.
> 
> Can we really release resources early ?  If the save operation fails
> right at the end, we want to be able to resume execution of CPUs,
> which assumes all resources are still available, otherwise we have
> a failure scenario where we've not successfully saved to disk and
> also don't still have the running QEMU.

Indeed we need to consider if the user starts the VM again during the
auto-pause enabled migration.  A few options, and one of them should allow
early free of resources.  Assuming auto-pause=on and migration started,
then:

  1) Allow VM starts later

    1.a) Start dirty tracking right at this point

         Not prefer this.  This will make all things transparent but IMHO
         unnecessary complexity on maintaining dirty tracking status.

    1.b) Fail the migration

         Can be a good option, IMHO, treating auto-pause as a promise from
         the user that VM won't need to be running anymore.  If VM starts,
         promise break, migration fails.

  2) Doesn't allow VM starts later

         Can also be a good option.  In this case VM resources (I think
         mostly, RAM) can be freed right after migrated.  If user request
         VM start, fail the start instead of migration itself.  Migration
         must succeed or data lost.

Thanks,

> 
> > We're basically talking about whether we want the VM to be usable in the
> > (hopefully) very short time between issuing the migration command and
> > the migration being finished. We might be splitting hairs here, but we
> > need some sort of consensus.
> 
> The time may not be very short for large VMs.
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
> 

-- 
Peter Xu


