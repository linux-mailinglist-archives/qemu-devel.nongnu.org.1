Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188AD7CFC0E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTfU-0000Jz-F2; Thu, 19 Oct 2023 10:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtTfS-0000JH-3g
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:06:30 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtTfQ-0000jy-D1
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:06:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 411701F45B;
 Thu, 19 Oct 2023 14:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697724386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pb3pIMVuAI7ym7iUexfGdolhi6SAgvoGd1vbEJM5n4g=;
 b=E2qhYZZXwbWACEDm2Rt2z5acU1QqtVq+2jz4pnPGCH3YURom1pCZJET62lHcNBMkNoOnRo
 8hUsurxLEsNxvPunUJ5ZsD965YVSk4Vc1T8ulLFoKyG82MXw9+U+L2S9ttMcE4dVrH//Q+
 3t5G2TxNUpvyT7/tGXd4JyZoWM7C2s0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697724386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pb3pIMVuAI7ym7iUexfGdolhi6SAgvoGd1vbEJM5n4g=;
 b=evkSv7wbGPvhBtgX5ugKS2DxomvJfrvlTTpbL+PJ7HO4Bp8m6iEERFl0+Q0mYFCtZ2AAcz
 +zAuJbxJHBISrVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5AFC139C2;
 Thu, 19 Oct 2023 14:06:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pxLtI+E3MWWndAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 14:06:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 10/12] tests/qtest/migration: Support more than one
 QEMU binary
In-Reply-To: <e4645bfb-9ded-41cb-adc5-6c81effea275@redhat.com>
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-11-farosas@suse.de>
 <e4645bfb-9ded-41cb-adc5-6c81effea275@redhat.com>
Date: Thu, 19 Oct 2023 11:06:23 -0300
Message-ID: <87y1fyyae8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Thomas Huth <thuth@redhat.com> writes:

> On 18/10/2023 21.27, Fabiano Rosas wrote:
>> We have strict rules around migration compatibility between different
>> QEMU versions but no test to validate the migration state between
>> different binaries.
>> 
>> Add infrastructure to allow running the migration tests with two
>> different QEMU binaries as migration source and destination.
>> 
>> The code now recognizes two new environment variables
>> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST. In the absence of
>> either of them, the test will use the QTEST_QEMU_BINARY variable. If
>> both are missing then the tests are run with single binary as
>> previously.
>> 
>> The machine type is selected automatically as the latest machine type
>> version that works with both binaries.
>> 
>> Usage (only one of SRC|DST is allowed):
>> 
>> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
>> QTEST_QEMU_BINARY=../build-8.1.0/qemu-system-x86_64 \
>> ./tests/qtest/migration-test
>> 
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/qtest/migration-test.c | 28 ++++++++++++++++++++++++----
>>   1 file changed, 24 insertions(+), 4 deletions(-)
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> I wonder whether we could test this in the gitlab-CI, too, e.g. by using a 
> Debian container and installing the qemu-system-x86_64 from the Debian 
> distro there (since this should be close enough to an older version of an 
> upstream release), then run the test with that version from Debian and the 
> one that has just been compiled from the master branch? Anyway, just an 
> idea, this can certainly be done later.

Yes, something like this is the goal. It's not in this series because my
docker-fu is a bit rusty, so I didn't want to delay the qtest part.

I think taking a built-from-tree QEMU would be better than a
distro-shipped one.

I also think that we should have this disabled in CI, due to the issues
I described in the other thread. And possibly enable it with fewer
migration-test tests. I don't see the need to run *all* of the
migration-tests in this "compat testing" scheme.

