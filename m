Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA73A7BABD7
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 23:11:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoVc6-0003rv-Vn; Thu, 05 Oct 2023 17:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoVc4-0003rj-Oq
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 17:10:28 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoVc3-0005UQ-2u
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 17:10:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B57A91F45E;
 Thu,  5 Oct 2023 21:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696540223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+VagTN+epR036U5LvfP4oVGHe7O1rnkJOlsKLVWESk=;
 b=BTe7XTed55MFXFgvbf4ObFOd70Dt2l8XBYlXszVq7e0NwLqEQ6CfABYxDYJMb7vxLHSSHP
 OttfT7kiFCd6p1mcl3pmaczkGXmLv59LRg7fmmLQNa8NzigvqsPqen+SUHtm44QuNjD8w9
 AAl9MJc6Nyc5h+cM5BTu+1pEyAWJL6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696540223;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X+VagTN+epR036U5LvfP4oVGHe7O1rnkJOlsKLVWESk=;
 b=hpcxC//zWZdKFCsfRHdjBnKXtqAkjpcKUIBLo+HnAw8vsbhUPTN9jzzskm+MEbxu6VzpyV
 0l26BfKnHxj9xtCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 49368139C2;
 Thu,  5 Oct 2023 21:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cpV/BT8mH2XMdAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 05 Oct 2023 21:10:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <ZR8iwwOeXWI+x9YX@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com> <87edi9fbh5.fsf@suse.de>
 <878r8hfavf.fsf@suse.de> <ZR8iwwOeXWI+x9YX@x1n>
Date: Thu, 05 Oct 2023 18:10:20 -0300
Message-ID: <875y3kg4hv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

> On Thu, Oct 05, 2023 at 10:37:56AM -0300, Fabiano Rosas wrote:
>> >> +    /*
>> >> +     * Make sure both QEMU instances will go into RECOVER stage, then test
>> >> +     * kicking them out using migrate-pause.
>> >> +     */
>> >> +    wait_for_postcopy_status(from, "postcopy-recover");
>> >> +    wait_for_postcopy_status(to, "postcopy-recover");
>> >
>> > Is this wait out of place? I think we're trying to resume too fast after
>> > migrate_recover():
>> >
>> > # {
>> > #     "error": {
>> > #         "class": "GenericError",
>> > #         "desc": "Cannot resume if there is no paused migration"
>> > #     }
>> > # }
>> >
>> 
>> Ugh, sorry about the long lines:
>> 
>> {
>>     "error": {
>>         "class": "GenericError",
>>         "desc": "Cannot resume if there is no paused migration"
>>     }
>> }
>
> Sorry I didn't get you here.  Could you elaborate your question?
>

The test is sometimes failing with the above message.

But indeed my question doesn't make sense. I forgot migrate_recover
happens on the destination. Nevermind.

The bug is still present nonetheless. We're going into migrate_prepare
in some state other than POSTCOPY_PAUSED.

