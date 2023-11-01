Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BA77DE546
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 18:22:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyEtT-0003XN-Vn; Wed, 01 Nov 2023 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyEtS-0003X1-9W
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:20:38 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyEtQ-0000ko-Hb
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:20:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA51021863;
 Wed,  1 Nov 2023 17:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698859234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tUaBsOas7R7K35PjP6+/tDde56faqqcy8r3COdEmIk=;
 b=x7HeCbeRwVH2WPWXI5bM/muZTzrxbq+Zlqnt2TAZEDoNKQzfZk8eatWr0ks/RCRdFh2GEo
 59RECECpSAYyl7AVXwINWS29AklfTNCgCm5QyhHJYQT23ksN24p5Oil+RFQmZcUJ+Z9g0F
 OP2CJg/ygkuqkfdGuM3j6u5Okiv4ImY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698859234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+tUaBsOas7R7K35PjP6+/tDde56faqqcy8r3COdEmIk=;
 b=Vx2DP6Jy7kU8UadlckkYgkGeg1w/NDqorHrde+PeQB4I5gl5Y2B33pBitLSE6WT8pwPUzx
 vC0F/NuxjP3Cg2Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7AC0B1348D;
 Wed,  1 Nov 2023 17:20:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1Gi+EeKIQmWBVwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 01 Nov 2023 17:20:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 21/29] migration/multifd: Add pages to the receiving
 side
In-Reply-To: <ZUJ01lcAJS1PaAIw@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-22-farosas@suse.de> <ZUF7VG+CWvuOEbqD@x1n>
 <87il6mcrf5.fsf@suse.de> <ZUJ01lcAJS1PaAIw@x1n>
Date: Wed, 01 Nov 2023 14:20:32 -0300
Message-ID: <87msvxfl0f.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Tue, Oct 31, 2023 at 08:18:06PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Mon, Oct 23, 2023 at 05:36:00PM -0300, Fabiano Rosas wrote:
>> >> Currently multifd does not need to have knowledge of pages on the
>> >> receiving side because all the information needed is within the
>> >> packets that come in the stream.
>> >> 
>> >> We're about to add support to fixed-ram migration, which cannot use
>> >> packets because it expects the ramblock section in the migration file
>> >> to contain only the guest pages data.
>> >> 
>> >> Add a pointer to MultiFDPages in the multifd_recv_state and use the
>> >> pages similarly to what we already do on the sending side. The pages
>> >> are used to transfer data between the ram migration code in the main
>> >> migration thread and the multifd receiving threads.
>> >> 
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > If it'll be new code to maintain anyway, I think we don't necessarily
>> > always use multifd structs, right?
>> >
>> 
>> For the sending side, unrelated to this series, I'm experimenting with
>> defining a generic structure to be passed into multifd:
>> 
>> struct MultiFDData_t {
>>     void *opaque;
>>     size_t size;
>>     bool ready;
>>     void (*cleanup_fn)(void *);
>> };
>> 
>> The client code (ram.c) would use the opaque field to put whatever it
>> wants in it. Maybe we could have a similar concept on the receiving
>> side?
>> 
>> Here's a PoC I'm writing, if you're interested:
>> 
>> https://github.com/farosas/qemu/commits/multifd-packet-cleanups
>> 
>> (I'm delaying sending this to the list because we already have a
>> reasonable backlog of features and refactorings to merge.)
>
> I went through the idea, I agree it's reasonable to generalize multifd to
> drop the page constraints.

Ok, I'll propose it once we get a slowdown on the ml volume

> Actually I'm wondering maybe it should be
> better that we have a thread pool model for migration, then multifd can be
> based on that.
>
> Something like: job submissions, proper locks, notifications, quits,
> etc. with a bunch of API to manipulate the thread pool.

I agree in principle.

> And actually.. I just noticed we have. :) See util/thread-pool.c.  I didn't
> have closer look, but that looks like something good if we can work on top
> (e.g., I don't think we want the bottom halfs..), or refactor to satisfy
> all our needs from migration pov.  Not something I'm asking right away, but
> maybe we can at least keep an eye on.
>

I wonder if adapting multifd to use a QIOTask for the channels would
make sense as an intermediary step. Seems simpler and would force us to
format multifd in more generic terms.


