Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B02047D7233
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:21:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhYz-00049n-2V; Wed, 25 Oct 2023 13:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvhYx-00049R-DP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvhYv-0002Mz-PK
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698254456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z4i/V1/ypky4sYeapNTu3oqmoZyGHF8sWabVaV8ZCQE=;
 b=iJuEPuBE1StQT9iL5rwoKqlri1eDOKicHaQXS4nlrtH6uWTMbNnxgF7OkXRjAArjiAKMjn
 K9m+Ms8qvNgVOt+Lhez5FsKS+jZJYT0dkFrZJaoLK/gzZxEAV5+yyCyJkCKIU5xW1gPgSE
 pub9XwdCCkG1jVqPoRfcyZDnnKkqI74=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-2jxHhd0VP46zpa3us7ecQQ-1; Wed, 25 Oct 2023 13:20:54 -0400
X-MC-Unique: 2jxHhd0VP46zpa3us7ecQQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a838ca1bdeso142180241.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 10:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698254454; x=1698859254;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z4i/V1/ypky4sYeapNTu3oqmoZyGHF8sWabVaV8ZCQE=;
 b=UzWDkxOZu2W3yMMV8f6mmlCvy3Nne+zpdma8kEbZ+pP+MPMsMhoX7CPQdq6VKg55B0
 7WYFK7Wf74/4PfYGGAowm0tcFUbuHGpj2QIHoArK0li+52ldPdzejB+hYOvc1Vr2yUiE
 DyHJDGCIXQ26whmirFqVJI4D4Cf87qQK9ixVEoZOTqPfkb5XcGeyE3J+OMJA1j2XIAcK
 DLIQWC8cTBLHvGvA7caEXzS2I1psLHoeLYdVPLeQOjXfkG+ZV1d9WnYW9TeK6Gjct/4Y
 0OewxyxX4qNROw7oEFlRDfaxtdXhVgAdjndMDaE3o9zjSg1B4XRAvYdJl9x9Kb5+1vQI
 p+2g==
X-Gm-Message-State: AOJu0YzQhwOla5ew8otB1mc1NHKfWzazJh2jjc8jWWetv31zwf5WzBjI
 oeyRmTRNOV3SxnFWazKG+NjO7UvftL7GTG/xZ4Lk5euKZj2IvEJkLyxgMvBpS1gvyxXGrPKmWmt
 W70KEot/qbfuz08U=
X-Received: by 2002:a05:6102:1589:b0:457:d5d3:c58e with SMTP id
 g9-20020a056102158900b00457d5d3c58emr9639201vsv.0.1698254454341; 
 Wed, 25 Oct 2023 10:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc2a6In5bkhOq5/lH8uyoQgTWLEwQTCDC+Xdxk9R3wo9SJxX7fUldN8C0MLocW62odbxK1rw==
X-Received: by 2002:a05:6102:1589:b0:457:d5d3:c58e with SMTP id
 g9-20020a056102158900b00457d5d3c58emr9639186vsv.0.1698254453996; 
 Wed, 25 Oct 2023 10:20:53 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u8-20020a0562140b0800b0066d11e63ba1sm4556914qvj.5.2023.10.25.10.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 10:20:53 -0700 (PDT)
Date: Wed, 25 Oct 2023 13:20:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTlOdM2ETHLkTKOE@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
 <ZTjWV9wQ5obKTpOG@redhat.com> <87y1fqerev.fsf@suse.de>
 <ZTkkICSD6j6Xf/KK@redhat.com> <ZTktCM/ccipYaJ80@x1n>
 <ZTkzY0nKtdeZJojP@redhat.com> <ZTk1++TzE+SiT3UH@x1n>
 <ZTk3BJD5cVbIhesr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTk3BJD5cVbIhesr@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 25, 2023 at 04:40:52PM +0100, Daniel P. Berrangé wrote:
> On Wed, Oct 25, 2023 at 11:36:27AM -0400, Peter Xu wrote:
> > On Wed, Oct 25, 2023 at 04:25:23PM +0100, Daniel P. Berrangé wrote:
> > > > Libvirt will still use fixed-ram for live snapshot purpose, especially for
> > > > Windows?  Then auto-pause may still be useful to identify that from what
> > > > Fabiano wants to achieve here (which is in reality, non-live)?
> > > > 
> > > > IIRC of previous discussion that was the major point that libvirt can still
> > > > leverage fixed-ram for a live case - since Windows lacks efficient live
> > > > snapshot (background-snapshot feature).
> > > 
> > > Libvirt will use fixed-ram for all APIs it has that involve saving to
> > > disk, with CPUs both running and paused.
> > 
> > There are still two scenarios.  How should we identify them, then?  For
> > sure we can always make it live, but QEMU needs that information to make it
> > efficient for non-live.
> > 
> > Considering when there's no auto-pause, then Libvirt will still need to
> > know the scenario first then to decide whether pausing VM before migration
> > or do nothing, am I right?
> 
> libvirt will issue a 'stop' before invoking 'migrate' if it
> needs to. QEMU should be able to optimize that scenario if
> it sees CPUs already stopped when migrate is started ?
> 
> > If so, can Libvirt replace that "pause VM" operation with setting
> > auto-pause=on here?  Again, the benefit is QEMU can benefit from it.
> > 
> > I think when pausing Libvirt can still receive an event, then it can
> > cooperate with state changes?  Meanwhile auto-pause=on will be set by
> > Libvirt too, so Libvirt will even have that expectation that QMP migrate
> > later on will pause the VM.
> > 
> > > 
> > > > From that POV it sounds like auto-pause is a good knob for that.
> > > 
> > > From libvirt's POV auto-pause will create extra work for integration
> > > for no gain.
> > 
> > Yes, I agree for Libvirt there's no gain, as the gain is on QEMU's side.
> > Could you elaborate what is the complexity for Libvirt to support it?
> 
> It increases the code paths because we will have to support
> and test different behaviour wrt CPU state for fixed-ram
> vs non-fixed ram usage.

To me if the user scenario is different, it makes sense to have a flag
showing what the user wants to do.

Guessing that from "whether VM is running or not" could work in many cases
but not all.

It means at least for dirty tracking, we only have one option to make it
fully transparent, starting dirty tracking when VM starts during such
migration.  The complexity moves from Libvirt into migration / kvm from
this aspect.

Meanwhile we lose some other potential optimizations for good, early
releasing of resources will never be possible anymore because they need to
be prepared to be reused very soon, even if we know they will never.  But
maybe that's not a major concern.

No strong opinion from my side.  I'll leave it to Fabiano.  I didn't see
any further optimization yet with the new cap in this series.  I think the
trick is current extra overheads are just not high enough for us to
care.. even if we know some work is pure overhead.  Then indeed we can also
postpone the optimizations until justified worthwhile.

Thanks,

-- 
Peter Xu


