Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05470828EB1
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 22:00:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNJBR-00016f-2Z; Tue, 09 Jan 2024 15:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNJBL-00015S-2o
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 15:58:43 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNJBJ-0006tq-7C
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 15:58:42 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A792F1F826;
 Tue,  9 Jan 2024 20:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704833919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmOw1c3+EuRes3x+t+I8pSPvo5ioRaoUS051I+lDZ94=;
 b=JCuALOmY/AHeniR8Rg9VX5S21Rm2ATSUfAUkW1qTWzupeVzfxea0qq+7aUj7uHTDkmwqEU
 SL1iRoPvIyqy/2yaUoSkTiQs1IOyOcm5GsXXuy7+mPVxFmGvzeL2jOZKevnL4/vqUh0IUa
 2/ZH0LTcaIlOKpwhE6DFjBrn3KTVWMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704833919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmOw1c3+EuRes3x+t+I8pSPvo5ioRaoUS051I+lDZ94=;
 b=b0w+L5uyJ9QgpeOFHDRqmLaCOyiRhvwQKpFyVMylbFEzQ6Fzxf8gekYYtG1M4j5sK7dVGE
 SXEVFFIotqZ1ClDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704833919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmOw1c3+EuRes3x+t+I8pSPvo5ioRaoUS051I+lDZ94=;
 b=JCuALOmY/AHeniR8Rg9VX5S21Rm2ATSUfAUkW1qTWzupeVzfxea0qq+7aUj7uHTDkmwqEU
 SL1iRoPvIyqy/2yaUoSkTiQs1IOyOcm5GsXXuy7+mPVxFmGvzeL2jOZKevnL4/vqUh0IUa
 2/ZH0LTcaIlOKpwhE6DFjBrn3KTVWMU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704833919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qmOw1c3+EuRes3x+t+I8pSPvo5ioRaoUS051I+lDZ94=;
 b=b0w+L5uyJ9QgpeOFHDRqmLaCOyiRhvwQKpFyVMylbFEzQ6Fzxf8gekYYtG1M4j5sK7dVGE
 SXEVFFIotqZ1ClDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DDA2134E8;
 Tue,  9 Jan 2024 20:58:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 68s4OX6znWXQSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jan 2024 20:58:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Thomas
 Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 3/4] ci: Add a migration compatibility test job
In-Reply-To: <7036da8a-7a52-49e0-bcd1-8484ae86b336@redhat.com>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-4-farosas@suse.de>
 <7036da8a-7a52-49e0-bcd1-8484ae86b336@redhat.com>
Date: Tue, 09 Jan 2024 17:58:36 -0300
Message-ID: <878r4y8br7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 1/5/24 19:04, Fabiano Rosas wrote:
>> The migration tests have support for being passed two QEMU binaries to
>> test migration compatibility.
>>=20
>> Add a CI job that builds the lastest release of QEMU and another job
>> that uses that version plus an already present build of the current
>> version and run the migration tests with the two, both as source and
>> destination. I.e.:
>>=20
>>   old QEMU (n-1) -> current QEMU (development tree)
>>   current QEMU (development tree) -> old QEMU (n-1)
>>=20
>> The purpose of this CI job is to ensure the code we're about to merge
>> will not cause a migration compatibility problem when migrating the
>> next release (which will contain that code) to/from the previous
>> release.
>>=20
>> I'm leaving the jobs as manual for now because using an older QEMU in
>> tests could hit bugs that were already fixed in the current
>> development tree and we need to handle those case-by-case.
>>=20
>> Note: for user forks, the version tags need to be pushed to gitlab
>> otherwise it won't be able to checkout a different version.
>>=20
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   .gitlab-ci.d/buildtest.yml | 53 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>=20
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index 91663946de..81163a3f6a 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -167,6 +167,59 @@ build-system-centos:
>>         x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
>>       MAKE_CHECK_ARGS: check-build
>>=20=20=20
>> +build-previous-qemu:
>> +  extends: .native_build_job_template
>> +  artifacts:
>> +    when: on_success
>> +    expire_in: 2 days
>> +    paths:
>> +      - build-previous
>> +    exclude:
>> +      - build-previous/**/*.p
>> +      - build-previous/**/*.a.p
>> +      - build-previous/**/*.fa.p
>> +      - build-previous/**/*.c.o
>> +      - build-previous/**/*.c.o.d
>> +      - build-previous/**/*.fa
>> +  needs:
>> +    job: amd64-opensuse-leap-container
>> +  variables:
>> +    QEMU_JOB_OPTIONAL: 1
>> +    IMAGE: opensuse-leap
>> +    TARGETS: x86_64-softmmu aarch64-softmmu
>> +  before_script:
>> +    - export QEMU_PREV_VERSION=3D"$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' =
VERSION)"
>> +    - git checkout $QEMU_PREV_VERSION
>> +  after_script:
>> +    - mv build build-previous
>> +
>> +.migration-compat-common:
>> +  extends: .common_test_job_template
>> +  needs:
>> +    - job: build-previous-qemu
>> +    - job: build-system-opensuse
>> +  allow_failure: true
>> +  variables:
>> +    QEMU_JOB_OPTIONAL: 1
>> +    IMAGE: opensuse-leap
>> +    MAKE_CHECK_ARGS: check-build
>> +  script:
>> +    - cd build
>> +    - QTEST_QEMU_BINARY_SRC=3D../build-previous/qemu-system-${TARGET}
>> +          QTEST_QEMU_BINARY=3D./qemu-system-${TARGET} ./tests/qtest/mig=
ration-test
>> +    - QTEST_QEMU_BINARY_DST=3D../build-previous/qemu-system-${TARGET}
>> +          QTEST_QEMU_BINARY=3D./qemu-system-${TARGET} ./tests/qtest/mig=
ration-test
>> +
>> +migration-compat-aarch64:
>> +  extends: .migration-compat-common
>> +  variables:
>> +    TARGET: aarch64
>> +
>> +migration-compat-x86_64:
>> +  extends: .migration-compat-common
>> +  variables:
>> +    TARGET: x86_64
>
>
> What about the others archs, s390x and ppc ? Do you lack the resources
> or are there any problems to address ?

Currently s390x and ppc are only tested on KVM. Which means they are not
tested at all unless someone runs migration-test on a custom runner. The
same is true for this test.

The TCG tests have been disabled:
    /*
     * On ppc64, the test only works with kvm-hv, but not with kvm-pr and T=
CG
     * is touchy due to race conditions on dirty bits (especially on PPC for
     * some reason)
     */

    /*
     * Similar to ppc64, s390x seems to be touchy with TCG, so disable it
     * there until the problems are resolved
     */

It would be great if we could figure out what these issues are and fix
them so we can at least test with TCG like we do for aarch64.

Doing a TCG run of migration-test with both archs (one binary only, not
this series):

- ppc survived one run, taking 6 minutes longer than x86/Aarch64.
- s390x survived one run, taking 40s less than x86/aarch64.

I'll leave them enabled on my machine and do some runs here and there,
see if I spot something. If not, we can consider re-enabling them once
we figure out why ppc takes so long.

