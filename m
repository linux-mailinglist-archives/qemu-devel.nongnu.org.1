Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C87832A11
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:06:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQoYU-0003RZ-Hq; Fri, 19 Jan 2024 08:05:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoYS-0003Qr-4o
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:05:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoYQ-0003mJ-8G
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:05:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E02C31FD17;
 Fri, 19 Jan 2024 13:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705669500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wljbv8pXNnEWRU4IbJZudcpIu0eR3Lgd40IiX3Mo+ss=;
 b=bAy/me0a/0EGG7wMjHNcNP6yKrPRBfMED1EwUVtseH2rUoyQ1Zg7R+60Ezia1FJzuB2ZZL
 1EPk3o/5ehi/+Wjp+lbbGhCS+vX/e+bU5QSIHarZmmF5qyyw25XSMcuug225+n01U1soga
 XnpqAvDX6hsKMBm3Wd8xToY6qcDzV8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705669500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wljbv8pXNnEWRU4IbJZudcpIu0eR3Lgd40IiX3Mo+ss=;
 b=N+aue9M0HjswDICmHYAAdaCcsnA2tiTuCamByyHaw8DBXR2AwjFLVI3U86nTC6H4E5V6vp
 eM9Z5db9+FU9pRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705669499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wljbv8pXNnEWRU4IbJZudcpIu0eR3Lgd40IiX3Mo+ss=;
 b=QXxdxiEN7ov19ntFSXDbnl87/iO9rjSmOwUsvc7djxICf5u+mw+3Svv8LZAkOIIwI9qfG1
 d6KjwfWOEx2+Oi2tJOdps+yM5cMQ1DF8GXc+C/hwnqzmW9/du3RpgikprtQj4jzSCuHpkM
 1/jrSRpai54G8bfizA7CRUIpNIehiUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705669499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wljbv8pXNnEWRU4IbJZudcpIu0eR3Lgd40IiX3Mo+ss=;
 b=UG6c2eaP3R1ng6b+lAa3ewRtDHjdla57pMk80OQR+IaHJtTy5Sxy7ywWxED9t89ZmDt7wD
 zovR0KiPr1wUxQDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 683DD13894;
 Fri, 19 Jan 2024 13:04:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wlYDDHtzqmWLFgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 13:04:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v4 3/3] ci: Disable migration compatibility tests for
 aarch64
In-Reply-To: <Zan0EOYX1pEEzlFz@x1n>
References: <20240118164951.30350-1-farosas@suse.de>
 <20240118164951.30350-4-farosas@suse.de> <Zan0EOYX1pEEzlFz@x1n>
Date: Fri, 19 Jan 2024 10:04:56 -0300
Message-ID: <87sf2tzd6v.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.10
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

> On Thu, Jan 18, 2024 at 01:49:51PM -0300, Fabiano Rosas wrote:
>> Until 9.0 is out, we need to keep the aarch64 job disabled because the
>> tests always use the n-1 version of migration-test. That happens to be
>> broken for aarch64 in 8.2. Once 9.0 is out, it will become the n-1
>> version and it will bring the fixed tests.
>> 
>> We can revert this patch when 9.0 releases.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index f0b0edc634..b344a4685f 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -217,10 +217,14 @@ build-previous-qemu:
>>      - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
>>            QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
>>  
>> +# This job is disabled until we release 9.0. The existing
>> +# migration-test in 8.2 is broken on aarch64. The fix was already
>> +# commited, but it will only take effect once 9.0 is out.
>>  migration-compat-aarch64:
>>    extends: .migration-compat-common
>>    variables:
>>      TARGET: aarch64
>> +    QEMU_JOB_OPTIONAL: 1
>
> Optionally you can move the whole migration-compat-aarch64 from previous
> patch to here, then even if someone kicks off CI for previous commit it
> won't fail.

I want to avoid having to think about this when 9.0 is out. This way
it'll be just a revert of this patch.

>
> Would QEMU_JOB_SKIPPED suits more here?
>
>         https://www.qemu.org/docs/master/devel/ci.html
>
>         QEMU_JOB_OPTIONAL
>
>         The job is expected to be successful in general, but is not run by
>         default due to need to conserve limited CI resources. It is
>         available to be started manually by the contributor in the CI
>         pipelines UI.
>
>         QEMU_JOB_SKIPPED
>
>         The job is not reliably successsful in general, so is not currently
>         suitable to be run by default. Ideally this should be a temporary
>         marker until the problems can be addressed, or the job permanently
>         removed.
>
> I suppose they all fall into "manual trigger" as a result, but just in case
> it'll behave differently in the future.
>
Ok, we can use SKIPPED.

>>  
>>  migration-compat-x86_64:
>>    extends: .migration-compat-common
>> -- 
>> 2.35.3
>> 

