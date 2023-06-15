Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E912A731BCF
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 16:52:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9oJB-0007TL-5B; Thu, 15 Jun 2023 10:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q9oJ4-0007RM-0W
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 10:50:42 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q9oJ2-0008WK-4h
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 10:50:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF9161FE25;
 Thu, 15 Jun 2023 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686840632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDt/01TN3vKLRLrQ5EAbnsFEJCZp2wAG9HgKc/igdd8=;
 b=ee79uRWdyZnMnBEkDl4SFBOxrQHS24GwJnSbF3+WofTIKSvnaI4DZ6T4rN6DVWHgNcfhLX
 wMUv60al4NgZBCiTg6iKUNhgQ/fTJiHIU0hLWkhrxm8n3VQvP8HLtav1qBC9AF9VXGdbO2
 IzOCKHanydp+PreyUWGT01qsdQM20fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686840632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LDt/01TN3vKLRLrQ5EAbnsFEJCZp2wAG9HgKc/igdd8=;
 b=ZTQXeHVE2nbMDeFwneX5BRhetwTFkFxWG4K7PZU74qAmRPvRdAVufnGuDnqzhPp+JK9GIO
 A0YSxJDHcwo+4QDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48F3213A32;
 Thu, 15 Jun 2023 14:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XneCATgli2T4AgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 15 Jun 2023 14:50:32 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH V2] migration: file URI
In-Reply-To: <ZIoJFoBlkS5WFOyZ@x1n>
References: <1686163139-256654-1-git-send-email-steven.sistare@oracle.com>
 <ZIdnj7Hr1L3iDVUG@x1n> <bddfc088-268b-2d9b-7a28-6345b8bfa2e7@oracle.com>
 <ZId4LggDVgxbtGTn@x1n> <877cs6ujtu.fsf@suse.de> <ZInhvxq9YgoM9ykZ@x1n>
 <874jn9vs9x.fsf@suse.de> <ZIoJFoBlkS5WFOyZ@x1n>
Date: Thu, 15 Jun 2023 11:50:28 -0300
Message-ID: <87cz1wzsnf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Jun 14, 2023 at 02:59:54PM -0300, Fabiano Rosas wrote:
>> In this message Daniel mentions virDomainSnapshotXXX which would benefit
>> from using the same "file" migration, but being done live:
>> 
>> https://lore.kernel.org/r/ZD7MRGQ+4QsDBtKR@redhat.com
>> 
>> And from your response here:
>>  https://lore.kernel.org/r/ZEA759BSs75ldW6Y@x1n
>> 
>> I had understood that having a new SUSPEND cap to decide whether to do
>> it live or non-live would be enough to cover all use-cases.
>
> Oh, I probably lost some of the contexts there, sorry about that - so it's
> about not being able to live snapshot on !LINUX worlds properly, am I
> right?
>

Right, so that gives us for now a reasonable use-case for keeping live
migration behavior possible with "file:".

> In the ideal world where we can always synchronously tracking guest pages
> (like what we do with userfaultfd wr-protections on modern Linux), the
> !SUSPEND case should always be covered by CAP_BACKGROUND_SNAPSHOT already
> in a more performant way.  IOW, !SUSPEND seems to be not useful to Linux,
> because whenever we want to set !SUSPEND we should just use BG_SNAPSHOT.
>

I agree.

> But I think indeed the live snapshot support is not good enough. Even on
> Linux, it lacks different memory type supports, multi-process support, and
> also no-go on very old kernels.  So I assume the fallback makes sense, and
> then we can't always rely on that.
>
> Then I agree we can keep "file:" the same as others like proposed here, but
> I'd like to double check with all of us so we're on the same page..

+1

> And maybe we should mention some discussions into commit message or
> comments where proper in the code, so we can track what has happened
> easier.
>

I'll add some words where appropriate in my series as well. A v2 is
already overdue with all the refactorings that have happened in the
migration code.

