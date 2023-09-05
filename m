Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A34792C5B
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:26:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZo2-0001ZL-Cn; Tue, 05 Sep 2023 13:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdZny-0001Yq-45
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:25:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qdZnv-0001qe-PV
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:25:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 902D51FF48;
 Tue,  5 Sep 2023 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693934728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwV3dlz14yGJex4eZZKnQ/gyoWGbLEBhyf32kV2h9Dk=;
 b=Fzj89QwWrHOgYxpZJbkcDCbGLRaTG9T4xCTQnJRhW1vRcKSSf2TllKPpu2qhmGgXp7PRcL
 mWWc7qvIoPc7ZX8nRFlGcmA7r92dx1zatJx4OvyArdMCkChWV0qvGiGPznlEnLkt5ArSaS
 69cRM8lDyhvVrQCD2N3f1yDV2114YtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693934728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dwV3dlz14yGJex4eZZKnQ/gyoWGbLEBhyf32kV2h9Dk=;
 b=BR1yAFMmTvTfYh/Y573UqpEyng162ABTl5rrSVZvIyX49ag8unOnjK9Cbx7Bouw9HXmCXT
 ruhHjuXcR9P+UCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2278513911;
 Tue,  5 Sep 2023 17:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ij6fN4dk92QyOAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 05 Sep 2023 17:25:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>
Subject: Re: [PATCH v5 8/8] migration: Add a wrapper to cleanup migration files
In-Reply-To: <ZPdKcfjGEfFKU6gV@x1n>
References: <20230831183916.13203-1-farosas@suse.de>
 <20230831183916.13203-9-farosas@suse.de> <ZPILtYXBVVCKDlWX@x1n>
 <878r9pagrk.fsf@suse.de> <ZPdKcfjGEfFKU6gV@x1n>
Date: Tue, 05 Sep 2023 14:25:25 -0300
Message-ID: <87il8own0a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Sep 01, 2023 at 03:29:51PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Aug 31, 2023 at 03:39:16PM -0300, Fabiano Rosas wrote:
>> >> @@ -1166,16 +1183,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>> >>          qemu_mutex_lock_iothread();
>> >>  
>> >>          multifd_save_cleanup();
>> >> -        qemu_mutex_lock(&s->qemu_file_lock);
>> >> -        tmp = s->to_dst_file;
>> >> -        s->to_dst_file = NULL;
>> >> -        qemu_mutex_unlock(&s->qemu_file_lock);
>> >> -        /*
>> >> -         * Close the file handle without the lock to make sure the
>> >> -         * critical section won't block for long.
>> >> -         */
>> >> -        migration_ioc_unregister_yank_from_file(tmp);
>> >> -        qemu_fclose(tmp);
>> >> +
>> >> +        migration_ioc_unregister_yank_from_file(s->to_dst_file);
>> >
>> > I think you suggested that we should always take the file lock when
>> > operating on them, so this is slightly going backwards to not hold any lock
>> > when doing it. But doing so in migrate_fd_cleanup() is probably fine (as it
>> > serializes with bql on all the rest qmp commands, neither should migration
>> > thread exist at this point).  Your call; it's still much cleaner.
>> 
>> I think I was mistaken. We need the lock on the thread that clears the
>> pointer so that we can safely dereference it on another thread under the
>> lock.
>> 
>> Here we're accessing it from the same thread that later does the
>> clearing. So that's a slightly different problem.
>
> But this is not the only place to clear it, so you still need to justify
> why the other call sites (e.g., postcopy_pause() won't happen in parallel
> with this call site.
>
> The good thing about your proposal (of always taking that lock) is we avoid
> those justifications, as you said before. :)
>

Yes, I should probably try harder to keep it under the lock.

The issue is that without using the QIOChannel reference count or
keeping a flag there's no way to pair the register/unregister of the
yank. Because 1) we'll never be sure whether the yank was previously
registered when calling the unregister and 2) we don't store the ioc, so
we need to access it from the QEMUFile, but then several QEMUFiles can
have the same ioc.

The easiest way to keep it under the lock would be to add a flag:

migration_file_release(QEMUFile **file, bool unregister_yank);

... and only set it when we're sure the yank has been registered. It is
still a bit hand-wavy though.

