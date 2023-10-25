Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F85B7D7441
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 21:29:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvjYF-0007RY-KA; Wed, 25 Oct 2023 15:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvjYE-0007RM-8g
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvjYC-00049v-6E
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 15:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698262098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrvshUsk2qPDe+9wbE7lmeB79cTPBUx2mLcJAxquVFU=;
 b=OYKsG+dL+lM8qBjTkHZDHnzCGE6vRSQyvO9rP0dEwLI1u73+du+kanHWAa2T/KQVKeHtoa
 WWTEIZnHR7M17Ls06hVUCyDej/dmh9Alc+1zuEHrce6auC2ULCQ1V+qWvStRntC/mINegz
 jLVcARQ+Ox8lVGbPpTUhUzUH8QJcUro=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-w4WRykGgP16C3zWrKjOE3w-1; Wed, 25 Oct 2023 15:28:16 -0400
X-MC-Unique: w4WRykGgP16C3zWrKjOE3w-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-66d48cfd295so347706d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 12:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698262096; x=1698866896;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yrvshUsk2qPDe+9wbE7lmeB79cTPBUx2mLcJAxquVFU=;
 b=mtawjHuQ6QpBFv5mVcmjwVXpEhTJ+tnz5q9p9ZVepfXN6Wzm1sGeMXN9e1YuEugGmr
 Whoy0xct6deXDc09wKaZAcjbPg4zHNYnJNjs5pDyu97u9mU+3HK1FWuYIcT3k89MZjWi
 28TKY3BPMLCkxQZ6tLuMWbtzdqS3QMJXIvQPCL95iQsEMFJ/0vbsObY/4sVnNtaJTM3N
 BzMHqwY0S0H/FWW36mGqJtWRlEwO3rixLJixRRCoSPPDlOBgbvahU+3Cy+0IfNVoPhh4
 T3e/irNQaOeA7t1vv8xZnB4DXPilN5Rm6hsghAkIiDR5dIl3lS86Irn69Nvd+f+JRDsv
 HHXg==
X-Gm-Message-State: AOJu0YyKoak5qiz/NUdmhmKKaCVxjX8ziXuF+6yC0+Gl+su47jcLc+qm
 8zBWoCyRH6HVd5eCRiIvzyUN48f6CtMMM/wBHACTVcQ6hTwtNsguWcMxKZ7dOresfIV4BlDspYT
 VGw2v5fSv/pZpVfk=
X-Received: by 2002:a05:620a:608c:b0:773:ad1f:3d5b with SMTP id
 dx12-20020a05620a608c00b00773ad1f3d5bmr19632650qkb.0.1698262095977; 
 Wed, 25 Oct 2023 12:28:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm5r+IMdFp8gLkn3b63cH2E7j44vSToBAd+8NNgA+pc1WwC2IMB/pF7XwS50w0kCCsAAmIug==
X-Received: by 2002:a05:620a:608c:b0:773:ad1f:3d5b with SMTP id
 dx12-20020a05620a608c00b00773ad1f3d5bmr19632633qkb.0.1698262095604; 
 Wed, 25 Oct 2023 12:28:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o27-20020a05620a22db00b007778503ebf4sm4411999qki.16.2023.10.25.12.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 12:28:15 -0700 (PDT)
Date: Wed, 25 Oct 2023 15:28:13 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTlsTSNwfuToqn2I@x1n>
References: <20231023203608.26370-7-farosas@suse.de>
 <ZTjWV9wQ5obKTpOG@redhat.com> <87y1fqerev.fsf@suse.de>
 <ZTkkICSD6j6Xf/KK@redhat.com> <ZTktCM/ccipYaJ80@x1n>
 <ZTkzY0nKtdeZJojP@redhat.com> <ZTk1++TzE+SiT3UH@x1n>
 <ZTk3BJD5cVbIhesr@redhat.com> <ZTlOdM2ETHLkTKOE@x1n>
 <ZTlRCWuE1c074ZRE@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTlRCWuE1c074ZRE@redhat.com>
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

On Wed, Oct 25, 2023 at 06:31:53PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 25, 2023 at 01:20:52PM -0400, Peter Xu wrote:
> > On Wed, Oct 25, 2023 at 04:40:52PM +0100, Daniel P. Berrangé wrote:
> > > On Wed, Oct 25, 2023 at 11:36:27AM -0400, Peter Xu wrote:
> > > > On Wed, Oct 25, 2023 at 04:25:23PM +0100, Daniel P. Berrangé wrote:
> > > > > > Libvirt will still use fixed-ram for live snapshot purpose, especially for
> > > > > > Windows?  Then auto-pause may still be useful to identify that from what
> > > > > > Fabiano wants to achieve here (which is in reality, non-live)?
> > > > > > 
> > > > > > IIRC of previous discussion that was the major point that libvirt can still
> > > > > > leverage fixed-ram for a live case - since Windows lacks efficient live
> > > > > > snapshot (background-snapshot feature).
> > > > > 
> > > > > Libvirt will use fixed-ram for all APIs it has that involve saving to
> > > > > disk, with CPUs both running and paused.
> > > > 
> > > > There are still two scenarios.  How should we identify them, then?  For
> > > > sure we can always make it live, but QEMU needs that information to make it
> > > > efficient for non-live.
> > > > 
> > > > Considering when there's no auto-pause, then Libvirt will still need to
> > > > know the scenario first then to decide whether pausing VM before migration
> > > > or do nothing, am I right?
> > > 
> > > libvirt will issue a 'stop' before invoking 'migrate' if it
> > > needs to. QEMU should be able to optimize that scenario if
> > > it sees CPUs already stopped when migrate is started ?
> > > 
> > > > If so, can Libvirt replace that "pause VM" operation with setting
> > > > auto-pause=on here?  Again, the benefit is QEMU can benefit from it.
> > > > 
> > > > I think when pausing Libvirt can still receive an event, then it can
> > > > cooperate with state changes?  Meanwhile auto-pause=on will be set by
> > > > Libvirt too, so Libvirt will even have that expectation that QMP migrate
> > > > later on will pause the VM.
> > > > 
> > > > > 
> > > > > > From that POV it sounds like auto-pause is a good knob for that.
> > > > > 
> > > > > From libvirt's POV auto-pause will create extra work for integration
> > > > > for no gain.
> > > > 
> > > > Yes, I agree for Libvirt there's no gain, as the gain is on QEMU's side.
> > > > Could you elaborate what is the complexity for Libvirt to support it?
> > > 
> > > It increases the code paths because we will have to support
> > > and test different behaviour wrt CPU state for fixed-ram
> > > vs non-fixed ram usage.
> > 
> > To me if the user scenario is different, it makes sense to have a flag
> > showing what the user wants to do.
> > 
> > Guessing that from "whether VM is running or not" could work in many cases
> > but not all.
> > 
> > It means at least for dirty tracking, we only have one option to make it
> > fully transparent, starting dirty tracking when VM starts during such
> > migration.  The complexity moves from Libvirt into migration / kvm from
> > this aspect.
> 
> Even with auto-pause we can't skip dirty tracking, as we don't
> guarantee the app won't run 'cont' at some point.
> 
> We could have an explicit capability 'dirty-tracking' which an app
> could set as an explicit "promise" that it won't ever need to
> (re)start CPUs while migration is running.   If dirty-tracking==no,
> then any attempt to run 'cont' should return an hard error while
> migration is running.

I do have some thoughts even before this series on disabling dirty
tracking, but until now I think it might be better to make "dirty track" be
hidden as an internal flag, decided by other migration caps/parameters.

For example, postcopy-only migration will not require dirty tracking in
whatever form.  But that can be a higher level "postcopy-only" capability
or even a higher concept than that, then it'll set dirty_tracking=false
internally.

I tried to list our options in the previous email.  Quotting from that:

https://lore.kernel.org/qemu-devel/ZTktCM%2FccipYaJ80@x1n/

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

So indeed we can fail the migration already if auto-pause=on.

> 
> > Meanwhile we lose some other potential optimizations for good, early
> > releasing of resources will never be possible anymore because they need to
> > be prepared to be reused very soon, even if we know they will never.  But
> > maybe that's not a major concern.
> 
> What resources can we release early, without harming our ability to
> restart the current QEMU on failure ?  

We can't if we always allow a restart indeed.

I think releasing resources early may not be a major benefit here even if
with the option, depending on whether that can make a difference in any of
the use cases. I don't see much yet.

Consider release-ram for postcopy, that makes sense only because we'll
initiate two QEMUs, so that early release guarantees total memory
consumption, more or less, to ~1 VM only.  Here we have only one single VM
anyway, may not be a problem to release everything later.

However I still think there can be something done by QEMU if QEMU knows for
sure the VM won't ever be restarted.  Dirty tracking can be omitted is one
of them.  One simple example of an extention of dirty tracking: consider
the case where a device doesn't support dirty tracking, then it will need
to block live migration normally, but it'll work if auto-pause=true,
because tracking is not needed.  But as long as such migration starts, we
can only either fail migration if VM restarts, or rejects the VM restart
request.  So that can be more than "dirty tracking overhead" itself.

Thanks,

-- 
Peter Xu


