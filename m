Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AE1B2E04B
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Aug 2025 17:09:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uokR7-0002Wx-4D; Wed, 20 Aug 2025 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uokQr-0002Vs-Mt
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 11:08:59 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uokQp-0004X1-Vb
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 11:08:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6ADB41FDCF;
 Wed, 20 Aug 2025 15:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755702532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5pf6WVZAOhDjmEqMRlVrOnuN11OJL1Ege0D06wVos0=;
 b=a0bg6W2Uu2L4X2lv/ZUmOjPjo1tUjEh+RXjzR4lqVWPWn7iHWbbBOntGZ0woku8iXByDIs
 6KeIn5pJgRK1Oh/6Zc5oGayX/YG/Q6sbMQp4X7fWDTuzY3lkT0oHpdt0wxBP4Sa8s8dZQI
 lAoW5hWgOh7lWaM1Xnv+Y2aMly5e2Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755702532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5pf6WVZAOhDjmEqMRlVrOnuN11OJL1Ege0D06wVos0=;
 b=Jwle7e5GvhXSqrtLakRPiJW0a5VIXfpxx0W4oArGKGpfa7Yt9Td7egPHbKHQ5UNE9+3zQK
 cT6HnLoCcNCviyAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755702532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5pf6WVZAOhDjmEqMRlVrOnuN11OJL1Ege0D06wVos0=;
 b=a0bg6W2Uu2L4X2lv/ZUmOjPjo1tUjEh+RXjzR4lqVWPWn7iHWbbBOntGZ0woku8iXByDIs
 6KeIn5pJgRK1Oh/6Zc5oGayX/YG/Q6sbMQp4X7fWDTuzY3lkT0oHpdt0wxBP4Sa8s8dZQI
 lAoW5hWgOh7lWaM1Xnv+Y2aMly5e2Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755702532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t5pf6WVZAOhDjmEqMRlVrOnuN11OJL1Ege0D06wVos0=;
 b=Jwle7e5GvhXSqrtLakRPiJW0a5VIXfpxx0W4oArGKGpfa7Yt9Td7egPHbKHQ5UNE9+3zQK
 cT6HnLoCcNCviyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEECF13867;
 Wed, 20 Aug 2025 15:08:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZVXRIQPlpWjQaAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Aug 2025 15:08:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Fabian Vogt <fvogt@suse.de>, Peter
 Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [RFC PATCH 3/4] tests/functional: Add a OS level migration test
 for pseries
In-Reply-To: <8eb9dd92-b33f-41c5-ade1-416f22b215a7@redhat.com>
References: <20250819223905.2247-1-farosas@suse.de>
 <20250819223905.2247-4-farosas@suse.de>
 <8eb9dd92-b33f-41c5-ade1-416f22b215a7@redhat.com>
Date: Wed, 20 Aug 2025 12:08:48 -0300
Message-ID: <87plcqvxmn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,suse.de,redhat.com,linux.ibm.com];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On 20/08/2025 00.39, Fabiano Rosas wrote:
>> There's currently no OS level test for ppc64le. Add one such test by
>> reusing the boot level tests that are already present.
>> 
>> The test boots the source machine, waits for it to reach a mid-boot
>> message, migrates and checks that the destination has reached the
>> final boot message (VFS error due to no disk).
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   tests/functional/test_ppc64_pseries.py | 41 ++++++++++++++++++++++++++
>>   1 file changed, 41 insertions(+)
>> 
>> diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/test_ppc64_pseries.py
>> index 67057934e8..7a7e0fe8ae 100755
>> --- a/tests/functional/test_ppc64_pseries.py
>> +++ b/tests/functional/test_ppc64_pseries.py
>> @@ -9,6 +9,8 @@
>>   
>>   from qemu_test import QemuSystemTest, Asset
>>   from qemu_test import wait_for_console_pattern
>> +from qemu_test.migration import Migration
>> +from qemu_test.ports import Ports
>>   
>>   class pseriesMachine(QemuSystemTest):
>>   
>> @@ -87,5 +89,44 @@ def test_ppc64_linux_big_boot(self):
>>           wait_for_console_pattern(self, console_pattern, self.panic_message)
>>           wait_for_console_pattern(self, self.good_message, self.panic_message)
>>   
>> +    def test_ppc64_linux_migration(self):
>> +        with Ports() as ports:
>> +            port = ports.find_free_port()
>> +            if port is None:
>> +                self.skipTest('Failed to find a free port')
>> +        uri = 'tcp:localhost:%u' % port
>
>   Hi,
>
> this is not how to use the context for Ports: Once the "with" block is left, 
> the locking for the free port will be gone and you're subject to a race 
> condition with other tests running in parallel (see the __enter__ and 
> __exit__ methods in tests/functional/qemu_test/ports.py ... and yes, there 
> should be more documentation for this).
>

Haha, I'm dumb. It never crossed my mind.

Thanks


