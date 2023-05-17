Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB297071E2
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 21:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzMgf-0006vw-28; Wed, 17 May 2023 15:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzMgd-0006rI-Hs
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzMgb-0001yt-IU
 for qemu-devel@nongnu.org; Wed, 17 May 2023 15:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684351181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PjCqFkXANaKDTfOySlfgpYt4v/a7nsuNQ6Bq6032fFg=;
 b=anoHQJBJyhiY/MX0Gytwb5ODP2PaAdrS++yRr4j+AgqVr4Gcf7f3FsuQhM8truEi3nA2eP
 pNCXtT+iatgBtXfAk10cbOvdoDtNWC2DVo1zds3iBMNq80+Pjztnvt2s6IP2cI0SMQBXU/
 kRSKHyx8ylM75yZlP4IZCOGn/j01AcU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-rm-UEc1APhqyiRO0zZY6eg-1; Wed, 17 May 2023 15:19:37 -0400
X-MC-Unique: rm-UEc1APhqyiRO0zZY6eg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-61b636b5f90so2219416d6.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 12:19:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684351172; x=1686943172;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjCqFkXANaKDTfOySlfgpYt4v/a7nsuNQ6Bq6032fFg=;
 b=PY5On3KUPSD1I6799QLLCllxOrRvQ2YE5IaGJ87zTqrNv0t6Ednv6F5wEJxBguNhn7
 Lc8HOf0TupMYXEwsGAjP8gZWJZ8JL7qX99oOkA9ET3EslK+obfmpzWyhcb0N69CjJ1ra
 is1LHgkYqjiay/5+9pD0wq5qHCMr0JBmGumaVIcGfdFulkah8C/iJfPSIJrJHspgwkSs
 VcADtGk55UAOre3QjRSffINTuwrxJP0dTOa3P/cCD+mvMnVdjAJxIBtdqm/qSckKxL3O
 coDs6yyL4rRJ10ZqPQvVyAslVWTm1Z1OKr1hX0FZeum11cKWDmoFY9WRRIQQ6VWsNQPI
 ODqg==
X-Gm-Message-State: AC+VfDwSbQy8ZrjokReFNnS63JhY29O7UkkEXgjQkc53SWe3DScm82J2
 Y+PO59YKXfEiVE+yR0mLbumxuBYJC433hov4SWfrTgIaB3gB84VxolAomWaqrF7Z0VHCUWBMx0y
 4ACZ+6zgmU8AtNow=
X-Received: by 2002:a05:6214:21a7:b0:616:73d9:b9d8 with SMTP id
 t7-20020a05621421a700b0061673d9b9d8mr7096129qvc.3.1684351172120; 
 Wed, 17 May 2023 12:19:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ513wRe8QUKSJ9nBdaxMJiyDlao7HVgWiwxr9CS3L/b+BgFeaIP8KMr/buK5S3BTliKwsATrQ==
X-Received: by 2002:a05:6214:21a7:b0:616:73d9:b9d8 with SMTP id
 t7-20020a05621421a700b0061673d9b9d8mr7096067qvc.3.1684351171642; 
 Wed, 17 May 2023 12:19:31 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 r23-20020ac87ef7000000b003b63b8df24asm7276260qtc.36.2023.05.17.12.19.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 12:19:31 -0700 (PDT)
Date: Wed, 17 May 2023 15:19:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org,
 leobras@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, stefanha@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org, pbonzini@redhat.com, t.lamprecht@proxmox.com,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] migration: for snapshots, hold the BQL during setup
 callbacks
Message-ID: <ZGUowUPuj+nzxpLq@x1n>
References: <20230505134652.140884-1-f.ebner@proxmox.com>
 <ZFUZuiubiReBGucl@x1n> <87v8h0aea6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v8h0aea6.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, May 10, 2023 at 08:31:13AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> 
> Hi
> 
> [Adding Kevin to the party]
> 
> > On Fri, May 05, 2023 at 03:46:52PM +0200, Fiona Ebner wrote:
> >> To fix it, ensure that the BQL is held during setup. To avoid changing
> >> the behavior for migration too, introduce conditionals for the setup
> >> callbacks that need the BQL and only take the lock if it's not already
> >> held.
> >
> > The major complexity of this patch is the "conditionally taking" part.
> 
> Yeap.
> 
> I don't want that bit.
> 
> This is another case of:
> - I have a problem
> - I will use recursive mutexes to solve it
> 
> Now you have two problems O:-)
> 
> > Pure question: what is the benefit of not holding BQL always during
> > save_setup(), if after all we have this coroutine issue to be solved?
> 
> Dunno.
> 
> I would like that paolo commented on this.  I "reviewed the code" 10
> years ago.  I don't remember at all why we wanted to change that.
> 
> > I can understand that it helps us to avoid taking BQL too long, but we'll
> > need to take it anyway during ramblock dirty track initializations, and so
> > far IIUC it's the major time to be consumed during setup().
> >
> > Commit message of 9b0950375277467 says, "Only the migration_bitmap_sync()
> > call needs the iothread lock". Firstly I think it's also covering
> > enablement of dirty tracking:
> >
> > +    qemu_mutex_lock_iothread();
> > +    qemu_mutex_lock_ramlist();
> > +    bytes_transferred = 0;
> > +    reset_ram_globals();
> > +
> >      memory_global_dirty_log_start();
> >      migration_bitmap_sync();
> > +    qemu_mutex_unlock_iothread();
> >
> > And I think enablement itself can be slow too, maybe even slower than
> > migration_bitmap_sync() especially with KVM_DIRTY_LOG_INITIALLY_SET
> > supported in the kernel.
> >
> > Meanwhile I always got confused on why we need to sync dirty bitmap when
> > setup at all.  Say, what if we drop migration_bitmap_sync() here?  After
> > all, shouldn't all pages be dirty from start (ram_list_init_bitmaps())?
> 
> How do you convince KVM (or the other lists) to start doing dirty
> tracking?  Doing a bitmap sync.

I think memory_global_dirty_log_start() kicks off the tracking already.

Take KVM as example, normally the case is KVM_MEM_LOG_DIRTY_PAGES is set
there, then ioctl(KVM_SET_USER_MEMORY_REGION) will start dirty tracking for
all of the guest memory slots necessary (including wr-protect all pages).

KVM_DIRTY_LOG_INITIALLY_SET is slightly special, it'll skip that procedure
during ioctl(KVM_SET_USER_MEMORY_REGION), but that also means the kernel
assumed the userapp (QEMU) marked all pages dirty initially (always the
case for QEMU, I think..).  Hence in this case the sync doesn't help either
because we'll simply get no new dirty bits in this shot..

> 
> And yeap, probably there is a better way of doing it.
> 
> > This is slightly off-topic, but I'd like to know if someone can help
> > answer.
> >
> > My whole point is still questioning whether we can unconditionally take bql
> > during save_setup().
> 
> I agree with you.
> 
> > I could have missed something, though, where we want to do in setup() but
> > avoid holding BQL.  Help needed on figuring this out (and if there is, IMHO
> > it'll be worthwhile to put that into comment of save_setup() hook).
> 
> I am more towards revert completely
> 9b0950375277467fd74a9075624477ae43b9bb22
> 
> and call it a day.  On migration we don't use coroutines on the sending
> side (I mean the migration code, the block layer uses coroutines for
> everything/anything).
> 
> Paolo, Stefan any clues for not run setup with the BKL?
> 
> Later, Juan.
> 

-- 
Peter Xu


