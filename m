Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E837DE446
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 16:56:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyDZc-0006Ix-3R; Wed, 01 Nov 2023 11:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyDZZ-0006IX-Tb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyDZY-0007wM-29
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698854158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aeEOZnWoJ0B9WYKfzwMnTHWLz0u9QxE9iBRr0kTPLA0=;
 b=fw3SFaznZva09JgZaIn5mBjhPc0mRl+NaE46ljMImFOcpFdHJrhhSzw620Yz3e1eLhcgFl
 fnW35T4yYaZsEQROrULqzGZfEQry4qXUKWuLNYmXlik0K/dfR0hY5Vb6unj+8KEmW0vGYW
 8mdJXyYkIRI3IdNaDfTA3l6j8WreLl8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Ac8S4C5fOmCJh32QvnQ5lA-1; Wed, 01 Nov 2023 11:55:57 -0400
X-MC-Unique: Ac8S4C5fOmCJh32QvnQ5lA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6ce29f5dc6cso2103574a34.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 08:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698854156; x=1699458956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aeEOZnWoJ0B9WYKfzwMnTHWLz0u9QxE9iBRr0kTPLA0=;
 b=J0VbsSxpkV+VLUaEekmaqTeWbS9p9B0jYcwOB8NswbA+IhHE3drSvuUQVcVRVECo7P
 CTlnuLuHIaWX+h7amFDDO2W5QDjl3Ahh0mV9Gy1knknGtq9o+qWXb5okS9A5LHI4JxV7
 Rg5k9u5zM5gMrb3FZ/EglEUOuki5NYENtkKZIEqhLeUww17bHkVGjpR+vibel++nPkCU
 JNf8hD2p8Sy1BZoMbVNiJV0r1vJhikoZmlxa8ZzWDO2EQPImat40b8dhCSGlB/BjISf3
 m1tTPCzU9TbhUbFjRvg49XK5vbW3oVQvtZwn3Vgpt+lOpiHnrQ1AKy+uMMBDn2dgIybr
 3v3Q==
X-Gm-Message-State: AOJu0Yz54SwgzibS1TVkRx5hW3f+Ku7yUaSO3soB8JN79lCsctvGmOAI
 qIEaTbhiKUUBxQT0gmn7teNiofF7LHaJYpzHPX3xU/cLVQ2CnHbdEozMTYTua2Yn0zNWiM/pQcS
 HOB/zLOPHLIUXL20=
X-Received: by 2002:a05:6830:2a0b:b0:6b9:d3bd:3985 with SMTP id
 y11-20020a0568302a0b00b006b9d3bd3985mr16652396otu.1.1698854156591; 
 Wed, 01 Nov 2023 08:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRAvE0N2hufHW4UvHT1Wrsu6fZU+PqEIz+NApiO0UlLa4wZeZbfQpWpyaIG4GZZl2qvvXp/g==
X-Received: by 2002:a05:6830:2a0b:b0:6b9:d3bd:3985 with SMTP id
 y11-20020a0568302a0b00b006b9d3bd3985mr16652373otu.1.1698854156233; 
 Wed, 01 Nov 2023 08:55:56 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y14-20020ac8524e000000b00419801b1094sm1495500qtn.13.2023.11.01.08.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 08:55:55 -0700 (PDT)
Date: Wed, 1 Nov 2023 11:55:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 21/29] migration/multifd: Add pages to the receiving
 side
Message-ID: <ZUJ01lcAJS1PaAIw@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-22-farosas@suse.de> <ZUF7VG+CWvuOEbqD@x1n>
 <87il6mcrf5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il6mcrf5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Tue, Oct 31, 2023 at 08:18:06PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Oct 23, 2023 at 05:36:00PM -0300, Fabiano Rosas wrote:
> >> Currently multifd does not need to have knowledge of pages on the
> >> receiving side because all the information needed is within the
> >> packets that come in the stream.
> >> 
> >> We're about to add support to fixed-ram migration, which cannot use
> >> packets because it expects the ramblock section in the migration file
> >> to contain only the guest pages data.
> >> 
> >> Add a pointer to MultiFDPages in the multifd_recv_state and use the
> >> pages similarly to what we already do on the sending side. The pages
> >> are used to transfer data between the ram migration code in the main
> >> migration thread and the multifd receiving threads.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > If it'll be new code to maintain anyway, I think we don't necessarily
> > always use multifd structs, right?
> >
> 
> For the sending side, unrelated to this series, I'm experimenting with
> defining a generic structure to be passed into multifd:
> 
> struct MultiFDData_t {
>     void *opaque;
>     size_t size;
>     bool ready;
>     void (*cleanup_fn)(void *);
> };
> 
> The client code (ram.c) would use the opaque field to put whatever it
> wants in it. Maybe we could have a similar concept on the receiving
> side?
> 
> Here's a PoC I'm writing, if you're interested:
> 
> https://github.com/farosas/qemu/commits/multifd-packet-cleanups
> 
> (I'm delaying sending this to the list because we already have a
> reasonable backlog of features and refactorings to merge.)

I went through the idea, I agree it's reasonable to generalize multifd to
drop the page constraints.  Actually I'm wondering maybe it should be
better that we have a thread pool model for migration, then multifd can be
based on that.

Something like: job submissions, proper locks, notifications, quits,
etc. with a bunch of API to manipulate the thread pool.

And actually.. I just noticed we have. :) See util/thread-pool.c.  I didn't
have closer look, but that looks like something good if we can work on top
(e.g., I don't think we want the bottom halfs..), or refactor to satisfy
all our needs from migration pov.  Not something I'm asking right away, but
maybe we can at least keep an eye on.

> 
> > Rather than introducing MultiFDPages_t into recv side, can we allow pages
> > to be distributed in chunks of (ramblock, start_offset, end_offset) tuples?
> > That'll be much more efficient than per-page.  We don't need page granule
> > here on recv side, we want to load chunks of mem fast.
> >
> > We don't even need page granule on sender side, but since only myself cared
> > about perf.. and obviously the plan is to even drop auto-pause, then VM can
> > be running there, so sender must do that per-page for now.  But now on recv
> > side VM must be stopped before all ram loaded, so there's no such problem.
> > And since we'll introduce new code anyway, IMHO we can decide how to do
> > that even if we want to reuse multifd.
> >
> > Main thread can assign these (ramblock, start_offset, end_offset) jobs to
> > recv threads.  If ramblock is too small (e.g. 1M), assign it anyway to one
> > thread.  If ramblock is >512MB, cut it into slices and feed them to multifd
> > threads one by one.  All the rest can be the same.
> >
> > Would that be better?  I would expect measurable loading speed difference
> > with much larger chunks and with that range-based tuples.
> 
> I need to check how that would interact with the existing recv_thread
> code. Hopefully there's nothing there preventing us from using a
> different data structure.

Sure, thanks.  Maybe there's a good way to provide a middle ground on both
"less code changes" and "easily maintainable", if that helps on this series
being merged.

What I want to make sure is we don't introduce new complicated logic but
even not doing the job as correct as we can.

-- 
Peter Xu


