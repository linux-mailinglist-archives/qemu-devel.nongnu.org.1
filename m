Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8163D82D52F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 09:43:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPIXp-0006S6-V9; Mon, 15 Jan 2024 03:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPIXn-0006Rt-G8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:42:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPIXl-0005hc-C0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705308123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIoFtpEOALPIvKh10CAInujCuvPMpycvinLMha2xsNM=;
 b=EjiY7g+eqTHt29kloNsKJF/qnK05zu3cP8gU4Ne1cMLA4fsmurds+UvPQoZDgT8wBoBlrk
 6iazTQNwbbp9OzBUy6c5vC40jnarAyLwpw5XzOFNLckTfpHc6IFnQDkdXaB30oWlbHwVGD
 QBqkQkugW4nUSyZk4wVLDspjFTDA4/A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-3-ezopB-MLaeeZi7KpSE8Q-1; Mon, 15 Jan 2024 03:42:01 -0500
X-MC-Unique: 3-ezopB-MLaeeZi7KpSE8Q-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28c987b2fb1so2387673a91.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 00:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705308120; x=1705912920;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XIoFtpEOALPIvKh10CAInujCuvPMpycvinLMha2xsNM=;
 b=SOEsmDhGI7SsOL3cWpb5FG2V6Q3Nr/zGm4b012hyAvCX66cui/pNIrr1kaV7rsYkPU
 tqTm8KtNi0N9ywfHUNdwicxmI2b7QBaANH1u7AomOSWIZGP6GNHGlaKA2ClsU3j/BXw9
 Q7Y2khTKdhQkQJgF/QRbczh7PHuiKYgXOKoyq/qXNOCDOTqYbI8uiCGUEn8AtgQfFWIz
 6mc9z1TDLOQh6PXrrd04/pmxpAnE5YwiUXqkNOzqQVnmXZbEuYOUy4ywkc0KTF+Sw1km
 nk+lPIqu4lCWveGd8ZWUIVmOtuBV/HtA8Xo7JFQjurzXJuZxifv7QmfjM5f3NRJT9cIh
 MdnA==
X-Gm-Message-State: AOJu0Yxv/c5U4SaecyEly/0YsAUIAMTBDukSS/5RIbDXQzIPgcvj4uwl
 yrfTwqCNGrkuKy1RPKy7ScF/35pZckY76BSeFd/aPxSCKDNVsZWA1qqllAS/H9No+4kOdXgo7r2
 0NqJUKZe/o/0rQbRejNarAeU=
X-Received: by 2002:a05:6a21:3982:b0:19a:999c:6653 with SMTP id
 ad2-20020a056a21398200b0019a999c6653mr11854437pzc.2.1705308120156; 
 Mon, 15 Jan 2024 00:42:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbMUBYaFQwpIpStE6braHIqBY2++1rskRt4532GYeA/1tsx/E2AgNSJwLNUYeYZEl7AhUAlg==
X-Received: by 2002:a05:6a21:3982:b0:19a:999c:6653 with SMTP id
 ad2-20020a056a21398200b0019a999c6653mr11854429pzc.2.1705308119780; 
 Mon, 15 Jan 2024 00:41:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 t22-20020a170902b21600b001d5b93560c3sm3252887plr.167.2024.01.15.00.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 00:41:59 -0800 (PST)
Date: Mon, 15 Jan 2024 16:41:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 00/30] migration: File based migration with
 multifd and fixed-ram
Message-ID: <ZaTvzu9YI9owFi6M@x1n>
References: <20231127202612.23012-1-farosas@suse.de> <ZZ_IElHLW1D-lrec@x1n>
 <87zfxbn2ag.fsf@suse.de> <ZaTPNwFcfrM-JUlg@x1n>
 <ZaTog6-cNMNqyyFG@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaTog6-cNMNqyyFG@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Jan 15, 2024 at 08:11:40AM +0000, Daniel P. Berrangé wrote:
> On Mon, Jan 15, 2024 at 02:22:47PM +0800, Peter Xu wrote:
> > On Thu, Jan 11, 2024 at 03:38:31PM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > On Mon, Nov 27, 2023 at 05:25:42PM -0300, Fabiano Rosas wrote:
> > > >> Hi,
> > > >> 
> > > >> In this v3:
> > > >> 
> > > >> Added support for the "file:/dev/fdset/" syntax to receive multiple
> > > >> file descriptors. This allows the management layer to open the
> > > >> migration file beforehand and pass the file descriptors to QEMU. We
> > > >> need more than one fd to be able to use O_DIRECT concurrently with
> > > >> unaligned writes.
> > > >> 
> > > >> Dropped the auto-pause capability. That discussion was kind of
> > > >> stuck. We can revisit optimizations for non-live scenarios once the
> > > >> series is more mature/merged.
> > > >> 
> > > >> Changed the multifd incoming side to use a more generic data structure
> > > >> instead of MultiFDPages_t. This allows multifd to restore the ram
> > > >> using larger chunks.
> > > >> 
> > > >> The rest are minor changes, I have noted them in the patches
> > > >> themselves.
> > > >
> > > > Fabiano,
> > > >
> > > > Could you always keep a section around in the cover letter (and also in the
> > > > upcoming doc file fixed-ram.rst) on the benefits of this feature?
> > > >
> > > > Please bare with me - I can start to ask silly questions.
> > > >
> > > 
> > > That's fine. Ask away!
> > > 
> > > > I thought it was about "keeping the snapshot file small".  But then when I
> > > > was thinking the use case, iiuc fixed-ram migration should always suggest
> > > > the user to stop the VM first before migration starts, then if the VM is
> > > > stopped the ultimate image shouldn't be large either.
> > > >
> > > > Or is it about performance only?  Where did I miss?
> > > 
> > > Performance is the main benefit because fixed-ram enables the use of
> > > multifd for file migration which would otherwise not be
> > > parallelizable. To use multifd has been the direction for a while as you
> > > know, so it makes sense.
> > > 
> > > A fast file migration is desirable because it could be used for
> > > snapshots with a stopped vm and also to replace the "exec:cat" hack
> > > (this last one I found out about recently, Juan mentioned it in this
> > > thread: https://lore.kernel.org/r/87cyx5ty26.fsf@secure.mitica).
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
> > > 
> > > The size aspect is just an interesting property, not necessarily a
> > > reason.
> > 
> > See above on the 2nd "live" use case of fixed-ram. I think in that case,
> > size is still a matter, then, because that one cannot stop the VM vcpus.
> > 
> > > It's about having the file bounded to the RAM size. So a running
> > > guest would not produce a continuously growing file. This is in contrast
> > > with previous experiments (libvirt code) in using a proxy to put
> > > multifd-produced data into a file.
> > > 
> > > I'll add this^ information in a more organized matter to the docs and
> > > cover letter. Let me know what else I need to clarify.
> > 
> > Thanks.
> > 
> > > 
> > > Some notes about fixed-ram by itself:
> > > 
> > > This series also enables fixed-ram without multifd, which would only
> > > take benefit of the size property. That is not part of our end goal
> > > which is to have multifd + fixed-ram, but I kept it nonetheless because
> > > it helps to debug/reason about the fixed-ram format without conflating
> > > matters with multifd.
> > 
> > Yes, makes sense.
> > 
> > > 
> > > Fixed-ram without multifd also allows the file migration to take benefit
> > > of direct io because the data portion of the file (pages) will be
> > > written with alignment. This version of the series does not yet support
> > > it, but I have a simple patch for the next version.
> > > 
> > > I also had a - perhaps naive - idea that we could merge the io code +
> > > fixed-ram first, to expedite things and later bring in the multifd and
> > > directio enhancements, but the review process ended up not being that
> > > modular.
> > 
> > What's the review process issue you're talking about?
> > 
> > If you can split the series that'll help merging for sure to me.  IIRC
> > there's complexity on passing the o-direct fds around, and not sure whether
> > that chunk can be put at the last, similarly to split the multifd bits.
> > 
> > One thing I just noticed is fixed-ram seems to be always preferred for
> > "file:" migrations.  Then can we already imply fixed-ram for "file" URIs?
> > 
> > I'm even thinking whether we can make it the default and drop the fixed-ram
> > capability: fixed-ram won't work besides file, and file won't make sense if
> > not using offsets / fixed-ram.  There's at least one problem, where we have
> > released 8.2 with "file:", so it means it could break users already using
> > "file:" there.  I'm wondering whether that'll be worthwhile considering if
> > we can drop the (seems redundant..) capability.  What do you think?
> 
> The 'fd' protocol should support 'fixed-ram' too if passed a seekable
> FD.

Ah ok, then the cap is still needed.

> 
> The 'file' protocol should be able to create save images compatible with
> older QEMU too IMHO.

This is less of a concern, IMHO, but indeed if we have the cap anyway then
it makes sense to do so.

Thanks,

-- 
Peter Xu


