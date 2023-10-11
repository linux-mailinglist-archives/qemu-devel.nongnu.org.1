Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669E7C572B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:41:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqaOX-0008RT-Sh; Wed, 11 Oct 2023 10:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqaOW-0008OV-0Q
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:41:04 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqaOP-0006f0-S1
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:41:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AD24D21836;
 Wed, 11 Oct 2023 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697035252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F5qNuva8HmXpkA2FihlnA8jOB0lu4bT0n6kn8Oo/+qo=;
 b=A3/uPRD2mJoHN0KjtJQSR4gT8eF3HhHhdxZYdoETcdhIQm7QBOVLu9E2eesQoB/71wg1HP
 RDUpFnoDxvsfQ/8magtP4jkeVMf4FFC4nWFHzMLUvPq61pNmwgP998b+nP2iqEa45GBaeh
 AEJZ1QcMkHIPYCUS9kwzfEe7UKpAKYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697035252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F5qNuva8HmXpkA2FihlnA8jOB0lu4bT0n6kn8Oo/+qo=;
 b=50n3SPe0olVIKjLPBcPuaZSydiaJSCTruucQp0Qw8N30b0QtZJpvWIN+Y/3Vrsc1gcjmtm
 GdTAznCM6iw47/Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FA98138EF;
 Wed, 11 Oct 2023 14:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NyFBA/SzJmUAcwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 14:40:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/9] tests/qtest/migration: Define a machine for all
 architectures
In-Reply-To: <87h6mx8c86.fsf@secure.mitica>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-8-farosas@suse.de> <87h6mx8c86.fsf@secure.mitica>
Date: Wed, 11 Oct 2023 11:40:49 -0300
Message-ID: <87h6mx1atq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.10
X-Spamd-Result: default: False [-0.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[18.10%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> Stop relying on defaults and select a machine explicitly for every
>> architecture.
>>
>> This is a prerequisite for being able to select machine types for
>> migration using different QEMU binaries for source and destination.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration-test.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 46f1c275a2..7c10ac925b 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -746,6 +746,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>      const char *kvm_opts = NULL;
>>      const char *arch = qtest_get_arch();
>>      const char *memory_size;
>> +    const char *machine;
>>  
>>      if (args->use_shmem) {
>>          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> @@ -758,11 +759,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>      got_dst_resume = false;
>>      if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
>>          memory_size = "150M";
>> +        machine = "pc";
>
> I would suggest:
>
>       if (strcmp(arch, "i386")) {
>           machine = "pc";
>       } else {
>           machine = "q35";
>       }
>
> New development is happening in q35, so I think this should be the more tested.
>

Ok, I'll change it.

>> @@ -774,10 +777,12 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>>                                        "'nvramrc=hex .\" _\" begin %x %x "
>>                                        "do i c@ 1 + i c! 1000 +loop .\" B\" 0 "
>>                                        "until'", end_address, start_address);
>> +        machine = "pseries";
>>          arch_opts = g_strdup("-nodefaults -machine vsmt=8");
>>      } else if (strcmp(arch, "aarch64") == 0) {
>>          memory_size = "150M";
>> -        arch_opts = g_strdup_printf("-machine virt,gic-version=max -cpu max "
>> +        machine = "virt";
>> +        arch_opts = g_strdup_printf("-machine gic-version=max -cpu max "
>
> Does this double -machine command line works?
>
> I expect yes, but who knows.

I remember it did. But I'll double check just in case.


