Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E682E336
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 00:21:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPWG9-0002AQ-TJ; Mon, 15 Jan 2024 18:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPWG7-00028S-88
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:20:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPWG5-0000uk-1F
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:20:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705360844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LwzeDVkbqnKusr41BAegi+QswMGzffAXgd5okkuuKR8=;
 b=il0E1zWJMmxUZsWe72ANriJyHigj1/Vg5lU5FBeFIyVXT1a9VEeohyGly/zAiFaq2h4l8i
 lIoeISUm9PwYz5kzAQCGR0XXNovXD2B4kShwNAgAh02MHvPV/WP4w/biWXhjRNZUGKWVcG
 zCXCPATU9O8C6aZ/yWEaRKnpVcX2OcQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-RB2ltc2bNfalXCwdVa_TgQ-1; Mon, 15 Jan 2024 18:20:37 -0500
X-MC-Unique: RB2ltc2bNfalXCwdVa_TgQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so2483859b3a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705360836; x=1705965636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LwzeDVkbqnKusr41BAegi+QswMGzffAXgd5okkuuKR8=;
 b=VdkEpdUNWK/w8TgOzxV+1LhWtQbHoNtYsQw9cVZpA/g5vmsNB2a8DgUu0YFRQqZLvj
 UKMRRhjvzQxhS2t3Q40H0ZQftm/hfxmmhZXmfZbGTcBleqDCr1KHvKvrmnsZxn6l1JiT
 /lgC1gEyj/5eR1RXx+A3EgJHkRcXPi/WmjIj5Vl38nsuTlFAcoleOO8W6cMhCLqri4e3
 FaRgil8atGVK6MZVNHHWmsfejfW3wyuhspLOBw6YTEgrCKZjgbWY/m7/PNxZU6K/T7/5
 hBkAB4WF4l/IEfGmD0N+iseOD+7Lk8l2LINcyT2SXGVB1Ab9Ww/yQXICfrImkw1CgdwF
 wNFA==
X-Gm-Message-State: AOJu0YwASE/QbwlE0AoAtCsbfDdfyo8gEkz7yLwd5Ki4k7iZ6n1Uib2a
 zJZKA4kbuBQJ4o3XY3a6tVN6yk62JBrM6A5ynMfrsgDNWdXSKufsar3G/gmdEBxnkbQGtKa0LnJ
 AFW/xoeUmAO2P0pqn65e0w7s=
X-Received: by 2002:a05:6a00:a03:b0:6d8:f420:da04 with SMTP id
 p3-20020a056a000a0300b006d8f420da04mr14536538pfh.0.1705360836075; 
 Mon, 15 Jan 2024 15:20:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPIkfwPUMw5R6m4DvN8IVYjCdB5I+zYlKLqjEoRNTPR42Xp8MQImWouLcynn29jU49XZBMVg==
X-Received: by 2002:a05:6a00:a03:b0:6d8:f420:da04 with SMTP id
 p3-20020a056a000a0300b006d8f420da04mr14536524pfh.0.1705360835752; 
 Mon, 15 Jan 2024 15:20:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 p3-20020a625b03000000b006cbe1bb5e3asm8457552pfb.138.2024.01.15.15.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 15:20:35 -0800 (PST)
Date: Tue, 16 Jan 2024 07:20:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 00/30] migration: File based migration with
 multifd and fixed-ram
Message-ID: <ZaW9vMGKy19y0Hww@x1n>
References: <20231127202612.23012-1-farosas@suse.de> <ZZ_IElHLW1D-lrec@x1n>
 <87zfxbn2ag.fsf@suse.de> <ZaTPNwFcfrM-JUlg@x1n>
 <87zfx64bzo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zfx64bzo.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, Jan 15, 2024 at 04:45:15PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jan 11, 2024 at 03:38:31PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Nov 27, 2023 at 05:25:42PM -0300, Fabiano Rosas wrote:
> >> >> Hi,
> >> >> 
> >> >> In this v3:
> >> >> 
> >> >> Added support for the "file:/dev/fdset/" syntax to receive multiple
> >> >> file descriptors. This allows the management layer to open the
> >> >> migration file beforehand and pass the file descriptors to QEMU. We
> >> >> need more than one fd to be able to use O_DIRECT concurrently with
> >> >> unaligned writes.
> >> >> 
> >> >> Dropped the auto-pause capability. That discussion was kind of
> >> >> stuck. We can revisit optimizations for non-live scenarios once the
> >> >> series is more mature/merged.
> >> >> 
> >> >> Changed the multifd incoming side to use a more generic data structure
> >> >> instead of MultiFDPages_t. This allows multifd to restore the ram
> >> >> using larger chunks.
> >> >> 
> >> >> The rest are minor changes, I have noted them in the patches
> >> >> themselves.
> >> >
> >> > Fabiano,
> >> >
> >> > Could you always keep a section around in the cover letter (and also in the
> >> > upcoming doc file fixed-ram.rst) on the benefits of this feature?
> >> >
> >> > Please bare with me - I can start to ask silly questions.
> >> >
> >> 
> >> That's fine. Ask away!
> >> 
> >> > I thought it was about "keeping the snapshot file small".  But then when I
> >> > was thinking the use case, iiuc fixed-ram migration should always suggest
> >> > the user to stop the VM first before migration starts, then if the VM is
> >> > stopped the ultimate image shouldn't be large either.
> >> >
> >> > Or is it about performance only?  Where did I miss?
> >> 
> >> Performance is the main benefit because fixed-ram enables the use of
> >> multifd for file migration which would otherwise not be
> >> parallelizable. To use multifd has been the direction for a while as you
> >> know, so it makes sense.
> >> 
> >> A fast file migration is desirable because it could be used for
> >> snapshots with a stopped vm and also to replace the "exec:cat" hack
> >> (this last one I found out about recently, Juan mentioned it in this
> >> thread: https://lore.kernel.org/r/87cyx5ty26.fsf@secure.mitica).
> >
> > I digged again the history, and started to remember the "live" migration
> > case for fixed-ram. IIUC that is what Dan mentioned in below email
> > regarding to the "virDomainSnapshotXXX" use case:
> >
> > https://lore.kernel.org/all/ZD7MRGQ+4QsDBtKR@redhat.com/
> >
> > So IIUC "stopped VM" is not always the use case?
> >
> > If you agree with this, we need to document these two use cases clearly in
> > the doc update:
> >
> >   - "Migrate a VM to file, then destroy the VM"
> >
> >     It should be suggested to stop the VM first before triggering such
> >     migration in this use case in the documents.
> >
> >   - "Take a live snapshot of the VM"
> >
> >     It'll be ideal if there is a portable interface to synchronously track
> >     dirtying of guest pages, but we don't...
> >
> >     So fixed-ram seems to be the solution for such a portable solution for
> >     taking live snapshot across-platforms as long as async dirty tracking
> >     is still supported on that OS (aka KVM_GET_DIRTY_LOG).  If async
> >     tracking is not supported, snapshot cannot be done live on the OS then,
> >     and one needs to use "snapshot-save".
> >
> >     For this one, IMHO it would be good to mention (from QEMU perspective)
> >     the existance of background-snapshot even though libvirt didn't support
> >     it for some reason.  Currently background-snapshot lacks multi-thread
> >     feature (nor O_DIRECT), though, so it may be less performant than
> >     fixed-ram.  However if with all features there I believe that's even
> >     more performant.  Please consider mention to a degree of detail on
> >     this.
> >
> 
> I'll include these in some form in the docs update.

Thanks.

Fixed-ram should also need a separate file after the doc series applied.
I'll try to prepare a pull this week so both fixed-ram and cpr should
hopefully have place to hold its own file under docs/devel/migration/.

PS: just in case it didn't land as soon, feel free to fetch migration-next
of my github.com/peterx/qemu repo; I only put things there if they at least
pass one round of CI, so the content should be relatively stable even
though not fully guranteed.

> 
> >> 
> >> The size aspect is just an interesting property, not necessarily a
> >> reason.
> >
> > See above on the 2nd "live" use case of fixed-ram. I think in that case,
> > size is still a matter, then, because that one cannot stop the VM vcpus.
> >
> >> It's about having the file bounded to the RAM size. So a running
> >> guest would not produce a continuously growing file. This is in contrast
> >> with previous experiments (libvirt code) in using a proxy to put
> >> multifd-produced data into a file.
> >> 
> >> I'll add this^ information in a more organized matter to the docs and
> >> cover letter. Let me know what else I need to clarify.
> >
> > Thanks.
> >
> >> 
> >> Some notes about fixed-ram by itself:
> >> 
> >> This series also enables fixed-ram without multifd, which would only
> >> take benefit of the size property. That is not part of our end goal
> >> which is to have multifd + fixed-ram, but I kept it nonetheless because
> >> it helps to debug/reason about the fixed-ram format without conflating
> >> matters with multifd.
> >
> > Yes, makes sense.
> >
> >> 
> >> Fixed-ram without multifd also allows the file migration to take benefit
> >> of direct io because the data portion of the file (pages) will be
> >> written with alignment. This version of the series does not yet support
> >> it, but I have a simple patch for the next version.
> >> 
> >> I also had a - perhaps naive - idea that we could merge the io code +
> >> fixed-ram first, to expedite things and later bring in the multifd and
> >> directio enhancements, but the review process ended up not being that
> >> modular.
> >
> > What's the review process issue you're talking about?
> 
> No issue per-se. I'm just mentioning that I split the series in a
> certain way and no one seemed to notice. =)

Oh :)

> 
> Basically everything up until patch 10/30 is one chunk that is mostly
> separate from multifd support (patches 11-22/30) and direct-io + fdset
> (32-30/30).

You can describe these in the cover letter.  Personally I can always merge
initial M patches when they're ready out of N; there'll be quite a few
iochannel ones though in the first batch, so I'll check with Dan when
the 1st chunk in ready stage on how it should go in.

> 
> >
> > If you can split the series that'll help merging for sure to me.  IIRC
> > there's complexity on passing the o-direct fds around, and not sure whether
> > that chunk can be put at the last, similarly to split the multifd bits.
> >
> 
> The logical sequence for merging in my view would be:
> 
> 1 - file: support - Steven already did that
> 2 - file: + fixed-ram
>   2a- file: + fixed-ram + direct-io (optional, I will send a patch in v4)
> 3 - file: + fixed-ram + multifd
> 4 - file: + fixed-ram + multifd + direct-io (here we get the full perf. benefits)
> 5 - file:/dev/fdset + fixed-ram + multifd + direct-io (here we can go
>     enable libvirt support)

Sounds good.

Such planning is IMHO fine to be put into TODO section of
devel/migration/fixed-ram.rst if you want, especially you already plan to
post separate series.  So you can start with the .rst file with the whole
design all in; we can merge it first.  You remove todos along with patchset
goes in.

Your call on how to do it.

> 
> > One thing I just noticed is fixed-ram seems to be always preferred for
> > "file:" migrations.  Then can we already imply fixed-ram for "file" URIs?
> >
> 
> The file URI alone is good to replace the exec:cat trick. We'll need it
> once we deprecate exec: to be able to do debugging of the stream.

I didn't follow up much on Juan's previous plan to deprecate exec.  But
yeah anyway let's start with that cap.

> 
> > I'm even thinking whether we can make it the default and drop the fixed-ram
> > capability: fixed-ram won't work besides file, and file won't make sense if
> > not using offsets / fixed-ram.  There's at least one problem, where we have
> > released 8.2 with "file:", so it means it could break users already using
> > "file:" there.  I'm wondering whether that'll be worthwhile considering if
> > we can drop the (seems redundant..) capability.  What do you think?
> 

-- 
Peter Xu


