Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719957A083B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnnw-0003AG-4G; Thu, 14 Sep 2023 10:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgnnA-00034g-9O
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgnn0-0004YJ-HQ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694703473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XDTmTCut5/L8MUgx8kKfcXkI3rjaUua+4ckBX5B6UE=;
 b=iUVBXbKv0A1Ig/r/HtyYq1tPElcHFzUVhkSzQ44pOF/ZzvAVkG7WArqcU1/OY7+ufzGjU3
 8NimOdYtsGSBPks2+IjeXreVGCObuMDp6LRMgD+NFVb/Uh0kvwYqe3KqlmMbEU1iNSiXVb
 pBpFmwQ9FZjduX7V+byviqzIcUQVwZs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-bJ-LMEcWM52NTfJewAfb3A-1; Thu, 14 Sep 2023 10:57:50 -0400
X-MC-Unique: bJ-LMEcWM52NTfJewAfb3A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-413650a9d6dso2465051cf.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694703470; x=1695308270;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5XDTmTCut5/L8MUgx8kKfcXkI3rjaUua+4ckBX5B6UE=;
 b=fa15YlH3tYo+SObOXvhkfxlvwOt4lP/qIf6pbAvP86f/E2wXky1kaOW6Ik/f31Fumh
 7vtWwe3WgU+87T90R9J0M66Uyjuptny2Ra75iFX8l1ghDbcC0WbzpmLcu/g4tpvFRUIs
 Fb4Y9K4XuWbKvWfo6vUrk6llgVCDHJNLCESHyDeGjG8vMwhIxPdCELdg7jjYH0/FQJlb
 Rw72ZRwK0wwoQsbpt2wiNDiv6QENQxqByh3W3k/f76qx7ZoT0oQpGq1K8URWHtKOiYch
 T7I9LL3Ae6D8ZkzhUvBhqFgIaxy0kZ1N+0acx97kwX7liIqsgHF9/Zptx3l9jNyDIwcj
 mqww==
X-Gm-Message-State: AOJu0YzQocc0331RIw8I4Ip+QjGFBBPGXWtcz7fywSVRfruYiL7f3Y2e
 zuN0mitPq8gZ8JHdzldXPYHSpSfU4qqoueBeMWxb7N4a27xZ8N6kUUmmekeqNr1BxtwgGTBlJ7W
 8o8DWwUKO30PdKGE=
X-Received: by 2002:a05:622a:448:b0:412:2dac:acb7 with SMTP id
 o8-20020a05622a044800b004122dacacb7mr5925847qtx.1.1694703469733; 
 Thu, 14 Sep 2023 07:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHAxYDuuXOcCefpoENFFDb+sgoOZ9+aIVIPommSG5HxEYU8eriS2kfJdPJNHTmJA8Jh2CF1w==
X-Received: by 2002:a05:622a:448:b0:412:2dac:acb7 with SMTP id
 o8-20020a05622a044800b004122dacacb7mr5925830qtx.1.1694703469418; 
 Thu, 14 Sep 2023 07:57:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 hx17-20020a05622a669100b0040324785e4csm493072qtb.13.2023.09.14.07.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 07:57:49 -0700 (PDT)
Date: Thu, 14 Sep 2023 10:57:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
Message-ID: <ZQMfa38ulqQiRZ3d@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
 <87jzstkaen.fsf@suse.de> <ZQJKQLNNZe772MUA@x1n>
 <87h6nwkhwl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6nwkhwl.fsf@suse.de>
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

On Thu, Sep 14, 2023 at 10:23:38AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Sep 13, 2023 at 06:53:20PM -0300, Fabiano Rosas wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >> 
> >> > On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote:
> >> >> The core yank code is strict about balanced registering and
> >> >> unregistering of yank functions.
> >> >> 
> >> >> This creates a difficulty because the migration code registers one
> >> >> yank function per QIOChannel, but each QIOChannel can be referenced by
> >> >> more than one QEMUFile. The yank function should not be removed until
> >> >> all QEMUFiles have been closed.
> >> >> 
> >> >> Keep a reference count of how many QEMUFiles are using a QIOChannel
> >> >> that has a yank function. Only unregister the yank function when all
> >> >> QEMUFiles have been closed.
> >> >> 
> >> >> This improves the current code by removing the need for the programmer
> >> >> to know which QEMUFile is the last one to be cleaned up and fixes the
> >> >> theoretical issue of removing the yank function while another QEMUFile
> >> >> could still be using the ioc and require a yank.
> >> >> 
> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> >> ---
> >> >>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
> >> >>  migration/yank_functions.h |  8 ++++
> >> >>  2 files changed, 81 insertions(+), 8 deletions(-)
> >> >
> >> > I worry this over-complicate things.
> >> 
> >> It does. We ran out of simple options.
> >> 
> >> > If you prefer the cleaness that we operate always on qemufile level, can we
> >> > just register each yank function per-qemufile?
> >> 
> >> "just" hehe
> >> 
> >> we could, but:
> >> 
> >> i) the yank is a per-channel operation, so this is even more unintuitive;
> >
> > I mean we can provide something like:
> >
> > void migration_yank_qemufile(void *opaque)
> > {
> >     QEMUFile *file = opaque;
> >     QIOChannel *ioc = file->ioc;
> >
> >     qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
> > }
> >
> > void migration_qemufile_register_yank(QEMUFile *file)
> > {
> >     if (migration_ioc_yank_supported(file->ioc)) {
> >         yank_register_function(MIGRATION_YANK_INSTANCE,
> >                                migration_yank_qemufile,
> >                                file);
> >     }
> > }
> 
> Sure, this is what I was thinking as well. IMO it will be yet another
> operation that happens on the channel, but it performed via the
> file. Just like qio_channel_close() at qemu_fclose(). Not the end of the
> world, of course, I just find it error-prone.
> 
> >> 
> >> ii) multifd doesn't have a QEMUFile, so it will have to continue using
> >>     the ioc;
> >
> > We can keep using migration_ioc_[un]register_yank() for them if there's no
> > qemufile attached.  As long as the function will all be registered under
> > MIGRATION_YANK_INSTANCE we should be fine having different yank func.
> >
> 
> ok
> 
> >> 
> >> iii) we'll have to add a yank to every new QEMUFile created during the
> >>      incoming migration (colo, rdma, etc), otherwise the incoming side
> >>      will be left using iocs while the src uses the QEMUFile;
> >
> > For RDMA, IIUC it'll simply be a noop as migration_ioc_yank_supported()
> > will be a noop for it for either reg/unreg.
> >
> > Currently it seems we will also unreg the ioc even for RDMA (even though we
> > don't reg for it).  But since unreg will be a noop it seems all fine even
> > if not paired.. maybe we should still try to pair it, e.g. register also in
> > rdma_start_outgoing_migration() for the rdma ioc so at least they're paired.
> >
> > I don't see why COLO is special here, though.  Maybe I missed something.
> 
> For colo I was thinking we'd have to register the yank just to be sure
> that all paths unregistering it have something to unregister.
> 
> Maybe I should move the register into qemu_file_new_impl() with a
> matching unregister at qemu_fclose().

Sounds good.  Or...

> 
> >> 
> >> iv) this is a functional change of the yank feature for which we have no
> >>     tests.
> >
> > Having yank tested should be preferrable.  Lukas is in the loop, let's see
> > whether he has something. We can still smoke test it before a selftest
> > being there.
> >
> > Taking one step back.. I doubt whether anyone is using yank for migration?
> > Knowing that migration already have migrate-cancel (for precopy) and
> > migrate-pause (for postcopy).
> 
> Right, both already call qio_channel_shutdown().
> 
> > I never used it myself, and I don't think
> > it's supported for RHEL.  How's that in suse's case?
> 
> Never heard mention of it and I don't see it in our virtualization
> documentation.
> 
> >
> > If no one is using it, maybe we can even avoid registering migration to
> > yank?
> >
> 
> Seems reasonable to me.

... let's wait for a few days from Lukas to see whether he as any more
input, or I'd vote for dropping yank for migration as a whole. It caused
mostly more crashes that I knew than benefits, so far..

I also checked libvirt is not using yank.

> 
> >> 
> >> If that's all ok to you I'll go ahead and git it a try.
> >> 
> >> > I think qmp yank will simply fail the 2nd call on the qemufile if the
> >> > iochannel is shared with the other one, but that's totally fine, IMHO.
> >> >
> >> > What do you think?
> >> >
> >> > In all cases, we should probably at least merge patch 1-8 if that can
> >> > resolve the CI issue.  I think all of them are properly reviewed.
> >> 
> >> I agree. Someone needs to queue this though since Juan has been busy.
> >
> > Yes, I'll see what I can do.
> 
> Thanks. I could even send a pull request myself if it would make things
> easier. Let me know.

That's definitely an option.  But I want to make sure it's the same thing;
I replied in Stefan's report.  We can continue the discussion there for that.

-- 
Peter Xu


