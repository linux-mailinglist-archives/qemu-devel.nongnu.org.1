Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048DC803EEE
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 21:03:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAF9G-0002v1-9k; Mon, 04 Dec 2023 15:02:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAF9B-0002tP-RL
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 15:02:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAF99-0001ki-Mz
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 15:02:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701720146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pZciSvk1lMR/X6SwtXFYJDuVw0wZnUqE/Q1trtSxprE=;
 b=MYQgFW9RAQ1o5FjcaXeKPaTnZ40b2yDhAlpSRsfQhsH3ZXSVAkuGIp+36jIHXUaVvnDOwK
 irA9hpFtBLrtRZK++hg3y6Sh0qYOThE5lnZPka4AKpsXeTA9EU0BzY6o4tKEbSJw0GK4il
 4pdlulCDhYkuUvKYOHSNrEc3zzsuFTo=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-FyFHqv_LOPSQGHAF6PVMxw-1; Mon, 04 Dec 2023 15:02:24 -0500
X-MC-Unique: FyFHqv_LOPSQGHAF6PVMxw-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-35d601904dbso6138915ab.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 12:02:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701720143; x=1702324943;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pZciSvk1lMR/X6SwtXFYJDuVw0wZnUqE/Q1trtSxprE=;
 b=bRtf40X7nXrWw1qb5pyVFPjxWW6ewcm6T6+Zj5VSnT86hNYiLlv6QpwZRNT7GjXosg
 dokSFDGnZrRl+dyQqLlE8MdvLRIy0KJ6SMx48yyZt1L0EEOkblrnM2f1LOmAd/DyDhOI
 0eePDEjOMzMwfJ5soA6PvDV5DBdF6M4DxrmfTFemojI7WsSqdKe7ikk8gwSkjdB5hYpA
 ynG+uxBORZl3nTi5uuMT2gRsdfBcFchVyodTndh5SbOqcYNG/JKy1L4+n2H9D2SKjX69
 3D8sR3mOLRIXSDkTUj0LKzneHSgUkjk/4lJM3QDTqgjudIAqvsJF0mBt8FxJ5AqwehbR
 B8ew==
X-Gm-Message-State: AOJu0YxRB3VWaPsXKxsofH4RysL7/MSrtFxlxtOks6mCvxvBMsdupwg/
 pcIrn9Y+bCJE9kRDNNIEL1FYwkWDJJK2k6uDi0NqB1DECZbr8pVzC3jRpSo0V74XjvvhuELGPY+
 XeF6P0AgwEJsRoWw=
X-Received: by 2002:a05:6e02:168d:b0:35c:b3ba:8592 with SMTP id
 f13-20020a056e02168d00b0035cb3ba8592mr17706886ila.3.1701720143316; 
 Mon, 04 Dec 2023 12:02:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo21yOxAu7EOl4MOxan3xWZSpAiBK/GYswA7DFx0MKvrA93CTZEAakbGAHgudcRS/L0mi1Nw==
X-Received: by 2002:a05:6e02:168d:b0:35c:b3ba:8592 with SMTP id
 f13-20020a056e02168d00b0035cb3ba8592mr17706867ila.3.1701720143027; 
 Mon, 04 Dec 2023 12:02:23 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 y13-20020a056602214d00b007b433e5cc99sm1525469ioy.26.2023.12.04.12.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 12:02:22 -0800 (PST)
Date: Mon, 4 Dec 2023 15:02:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Message-ID: <ZW4wTK0dld9pPCtX@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n>
 <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n> <87r0k1n4r7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0k1n4r7.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 04, 2023 at 04:31:56PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Dec 01, 2023 at 11:23:33AM -0500, Steven Sistare wrote:
> >> >> @@ -109,6 +117,7 @@ static int global_state_post_load(void *opaque, int version_id)
> >> >>          return -EINVAL;
> >> >>      }
> >> >>      s->state = r;
> >> >> +    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
> >> > 
> >> > IIUC current vm_was_suspended (based on my read of your patch) was not the
> >> > same as a boolean representing "whether VM is suspended", but only a
> >> > temporary field to remember that for a VM stop request.  To be explicit, I
> >> > didn't see this flag set in qemu_system_suspend() in your previous patch.
> >> > 
> >> > If so, we can already do:
> >> > 
> >> >   vm_set_suspended(s->vm_was_suspended);
> >> > 
> >> > Irrelevant of RUN_STATE_SUSPENDED?
> >> 
> >> We need both terms of the expression.
> >> 
> >> If the vm *is* suspended (RUN_STATE_SUSPENDED), then vm_was_suspended = false.
> >> We call global_state_store prior to vm_stop_force_state, so the incoming
> >> side sees s->state = RUN_STATE_SUSPENDED and s->vm_was_suspended = false.
> >
> > Right.
> >
> >> However, the runstate is RUN_STATE_INMIGRATE.  When incoming finishes by
> >> calling vm_start, we need to restore the suspended state.  Thus in 
> >> global_state_post_load, we must set vm_was_suspended = true.
> >
> > With above, shouldn't global_state_get_runstate() (on dest) fetch SUSPENDED
> > already?  Then I think it should call vm_start(SUSPENDED) if to start.
> >
> > Maybe you're talking about the special case where autostart==false?  We
> > used to have this (existing process_incoming_migration_bh()):
> >
> >     if (!global_state_received() ||
> >         global_state_get_runstate() == RUN_STATE_RUNNING) {
> >         if (autostart) {
> >             vm_start();
> >         } else {
> >             runstate_set(RUN_STATE_PAUSED);
> >         }
> >     }
> >
> > If so maybe I get you, because in the "else" path we do seem to lose the
> > SUSPENDED state again, but in that case IMHO we should logically set
> > vm_was_suspended only when we "lose" it - we didn't lose it during
> > migration, but only until we decided to switch to PAUSED (due to
> > autostart==false). IOW, change above to something like:
> >
> >     state = global_state_get_runstate();
> >     if (!global_state_received() || runstate_is_alive(state)) {
> >         if (autostart) {
> >             vm_start(state);
> >         } else {
> >             if (runstate_is_suspended(state)) {
> >                 /* Remember suspended state before setting system to STOPed */
> >                 vm_was_suspended = true;
> >             }
> >             runstate_set(RUN_STATE_PAUSED);
> >         }
> >     }
> >
> > It may or may not have a functional difference even if current patch,
> > though.  However maybe clearer to follow vm_was_suspended's strict
> > definition.
> >
> >> 
> >> If the vm *was* suspended, but is currently stopped (eg RUN_STATE_PAUSED),
> >> then vm_was_suspended = true.  Migration from that state sets
> >> vm_was_suspended = s->vm_was_suspended = true in global_state_post_load and 
> >> ends with runstate_set(RUN_STATE_PAUSED).
> >> 
> >> I will add a comment here in the code.
> >>  
> >> >>      return 0;
> >> >>  }
> >> >> @@ -134,6 +143,7 @@ static const VMStateDescription vmstate_globalstate = {
> >> >>      .fields = (VMStateField[]) {
> >> >>          VMSTATE_UINT32(size, GlobalState),
> >> >>          VMSTATE_BUFFER(runstate, GlobalState),
> >> >> +        VMSTATE_BOOL(vm_was_suspended, GlobalState),
> >> >>          VMSTATE_END_OF_LIST()
> >> >>      },
> >> >>  };
> >> > 
> >> > I think this will break migration between old/new, unfortunately.  And
> >> > since the global state exist mostly for every VM, all VM setup should be
> >> > affected, and over all archs.
> >> 
> >> Thanks, I keep forgetting that my binary tricks are no good here.  However,
> >> I have one other trick up my sleeve, which is to store vm_was_running in
> >> global_state.runstate[strlen(runstate) + 2].  It is forwards and backwards
> >> compatible, since that byte is always 0 in older qemu.  It can be implemented
> >> with a few lines of code change confined to global_state.c, versus many lines 
> >> spread across files to do it the conventional way using a compat property and
> >> a subsection.  Sound OK?  
> >
> > Tricky!  But sounds okay to me.  I think you're inventing some of your own
> > way of being compatible, not relying on machine type as a benefit.  If go
> > this route please document clearly on the layout and also what it looked
> > like in old binaries.
> >
> > I think maybe it'll be good to keep using strings, so in the new binaries
> > we allow >1 strings, then we define properly on those strings (index 0:
> > runstate, existed since start; index 2: suspended, perhaps using "1"/"0" to
> > express, while 0x00 means old binary, etc.).
> >
> > I hope this trick will need less code than the subsection solution,
> > otherwise I'd still consider going with that, which is the "common
> > solution".
> >
> > Let's also see whether Juan/Fabiano/others has any opinions.
> 
> Can't we pack the structure and just go ahead and slash 'runstate' in
> half? That would claim some unused bytes for future backward
> compatibility issues.

What I meant is something like:

  runstate[100] = {"str1", 0x00, "str2", 0x00, ...}

Where str1 is runstate, and str2 can be either "0"/"1" to reflect suspended
value.  We define all the strings separated by 0x00, then IIUC we save the
most chars for potential future extension of this string.

Thanks,

-- 
Peter Xu


