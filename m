Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E7C7DD933
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 00:19:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxxzz-0005ZV-E8; Tue, 31 Oct 2023 19:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxxzx-0005ZM-NJ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 19:18:13 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxxzv-0000V9-RR
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 19:18:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDA6C1F38C;
 Tue, 31 Oct 2023 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698794288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/xTlAFq0EB4dOGuQwDwdYIUplddStM+3Wl1MkuK4GE=;
 b=RmVbURu0L0J60NHTPIqmd4IO56x0wh02Frg3UOep2amKYzoE9f5qIHuTCczDlTByQtVE8H
 Q5gxc5tT0UmKwV2qUnH+d7Xpom71WVXzkUN12i5QrNElY5JaACAWeu2+2sqw+FIIgHO1OG
 smiruYq+HdPSeAJ9517EjLmjr2NVl6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698794288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D/xTlAFq0EB4dOGuQwDwdYIUplddStM+3Wl1MkuK4GE=;
 b=3mBTrccPe2fKOB7GXqoDGjV1NZzNnlw0anI3t8c5Na71fPis5BseFES0CmhLUBfLYmmXsV
 l1b2J9aS2sPO10Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EAC7138EF;
 Tue, 31 Oct 2023 23:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GB/PCjCLQWWIDwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 23:18:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 21/29] migration/multifd: Add pages to the receiving
 side
In-Reply-To: <ZUF7VG+CWvuOEbqD@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-22-farosas@suse.de> <ZUF7VG+CWvuOEbqD@x1n>
Date: Tue, 31 Oct 2023 20:18:06 -0300
Message-ID: <87il6mcrf5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

> On Mon, Oct 23, 2023 at 05:36:00PM -0300, Fabiano Rosas wrote:
>> Currently multifd does not need to have knowledge of pages on the
>> receiving side because all the information needed is within the
>> packets that come in the stream.
>> 
>> We're about to add support to fixed-ram migration, which cannot use
>> packets because it expects the ramblock section in the migration file
>> to contain only the guest pages data.
>> 
>> Add a pointer to MultiFDPages in the multifd_recv_state and use the
>> pages similarly to what we already do on the sending side. The pages
>> are used to transfer data between the ram migration code in the main
>> migration thread and the multifd receiving threads.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> If it'll be new code to maintain anyway, I think we don't necessarily
> always use multifd structs, right?
>

For the sending side, unrelated to this series, I'm experimenting with
defining a generic structure to be passed into multifd:

struct MultiFDData_t {
    void *opaque;
    size_t size;
    bool ready;
    void (*cleanup_fn)(void *);
};

The client code (ram.c) would use the opaque field to put whatever it
wants in it. Maybe we could have a similar concept on the receiving
side?

Here's a PoC I'm writing, if you're interested:

https://github.com/farosas/qemu/commits/multifd-packet-cleanups

(I'm delaying sending this to the list because we already have a
reasonable backlog of features and refactorings to merge.)

> Rather than introducing MultiFDPages_t into recv side, can we allow pages
> to be distributed in chunks of (ramblock, start_offset, end_offset) tuples?
> That'll be much more efficient than per-page.  We don't need page granule
> here on recv side, we want to load chunks of mem fast.
>
> We don't even need page granule on sender side, but since only myself cared
> about perf.. and obviously the plan is to even drop auto-pause, then VM can
> be running there, so sender must do that per-page for now.  But now on recv
> side VM must be stopped before all ram loaded, so there's no such problem.
> And since we'll introduce new code anyway, IMHO we can decide how to do
> that even if we want to reuse multifd.
>
> Main thread can assign these (ramblock, start_offset, end_offset) jobs to
> recv threads.  If ramblock is too small (e.g. 1M), assign it anyway to one
> thread.  If ramblock is >512MB, cut it into slices and feed them to multifd
> threads one by one.  All the rest can be the same.
>
> Would that be better?  I would expect measurable loading speed difference
> with much larger chunks and with that range-based tuples.

I need to check how that would interact with the existing recv_thread
code. Hopefully there's nothing there preventing us from using a
different data structure.


