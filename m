Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 905DE7BAC17
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 23:32:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoVvd-0003fV-Te; Thu, 05 Oct 2023 17:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoVvZ-0003c9-41
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 17:30:38 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoVvV-0001nK-18
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 17:30:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF9E021862;
 Thu,  5 Oct 2023 21:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696541428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnB976b/RLO4QOJaPjiVR67mcruD0opPI6LoQI+FlAE=;
 b=kkyvKEVD1cRxqvm/inRvTklQ0kFobRxFdvk/YKRC0oOIncMIUPrTtk8uZmaCIKQygjdEb+
 ER0FK1XrJ9d+0rRMSqeSwGn8lgKig26rRCWYohbXOzzrsanfGIRVOZMkUZqSUaKEUbwuxM
 D/V1071cfniJB/txt+ZJm3AwpN/KXfs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696541428;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnB976b/RLO4QOJaPjiVR67mcruD0opPI6LoQI+FlAE=;
 b=oz6OSb9QocavP5nWs1Yx49v5zA245FjKcNU2zC3BlCTaVmkt1dTeItPEW4hwzOHmHtLXad
 xi9w542iezgEoLBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EE81139C2;
 Thu,  5 Oct 2023 21:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wISvCvQqH2VIfQAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 05 Oct 2023 21:30:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
In-Reply-To: <ZR3Nywj7Ymoi2kvH@x1n>
References: <20230927214756.14117-1-farosas@suse.de> <ZR3Nywj7Ymoi2kvH@x1n>
Date: Thu, 05 Oct 2023 18:30:26 -0300
Message-ID: <8734yog3kd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Wed, Sep 27, 2023 at 06:47:56PM -0300, Fabiano Rosas wrote:
>> I know this adds a python dependency to qtests and I'm not sure how
>> much we care about this script, but on the other hand it would be nice
>> to catch these errors early on.
>> 
>> This would also help with future work that touches the migration
>> stream (moving multifd out of ram.c and fixed-ram).
>> 
>> Let me know what you think.
>
> The test is good, but I think it'll be definitely less burden and cleaner
> if it can be written just in shell scripts.. that can even be put in a
> single line..
>
> $ (echo "migrate exec:cat>$IMAGE"; echo "quit") | $QEMU_BIN -monitor stdio; $DIR/scripts/analyze-migration.py -f $IMAGE
>
> Any chance to hook that in?

I tried but it's way worse.

We need to add the script to meson, pass the Python and QEMU binaries
in, make it be invoked for each architecture, but skip s390x and ppc
when using TCG only.

Then we need to add code to map target vs. machine type because arm has
no default machine.

We also need to produce TAP output for meson. And the migration script
outputs a ton of lines so Python barfs due to EAGAIN so we need to
handle that as well.

All of that is already there in migration-test.

I'll send a v2 of this patch with the improvements Thomas suggested and
try to dig out a fix for the script on ppc64 I made about 3 years ago
that seemed to have not been merged.

