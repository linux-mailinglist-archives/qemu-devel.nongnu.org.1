Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46178AAEC58
	for <lists+qemu-devel@lfdr.de>; Wed,  7 May 2025 21:40:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCkcJ-0006oP-4p; Wed, 07 May 2025 15:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uCkcC-0006mO-Lb
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:39:36 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uCkc2-0002mw-LU
 for qemu-devel@nongnu.org; Wed, 07 May 2025 15:39:35 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B1161F393;
 Wed,  7 May 2025 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746646762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGq2jclFge5T5IF8ARS1XqbV8s7Q1evWx5wHdCgfC+Y=;
 b=s7+79h9gs+F9hGPZsE+BbOTrYt0hxd2JsNhmy7rXYnzdbr35s7IkAkavYz6UTj4IXaod3r
 hqqPTAdtKtb6kwXag618PhvI0A+bN8CJKiYC3mN+62rS4VFHLxVyzVVs4g5YoZWDa97h/y
 4L/dUGhPX/LG9IEaxvjfkBeky65zF/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746646762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGq2jclFge5T5IF8ARS1XqbV8s7Q1evWx5wHdCgfC+Y=;
 b=N+eN0ufwObBVb2Ckb2EbDwboyN5qppNgBREkgGeI1xQXJBTrTmX8T4MYBz2xdpRMS6T96+
 gw7LXz0zbHaIRTDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s7+79h9g;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=N+eN0ufw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1746646762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGq2jclFge5T5IF8ARS1XqbV8s7Q1evWx5wHdCgfC+Y=;
 b=s7+79h9gs+F9hGPZsE+BbOTrYt0hxd2JsNhmy7rXYnzdbr35s7IkAkavYz6UTj4IXaod3r
 hqqPTAdtKtb6kwXag618PhvI0A+bN8CJKiYC3mN+62rS4VFHLxVyzVVs4g5YoZWDa97h/y
 4L/dUGhPX/LG9IEaxvjfkBeky65zF/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1746646762;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xGq2jclFge5T5IF8ARS1XqbV8s7Q1evWx5wHdCgfC+Y=;
 b=N+eN0ufwObBVb2Ckb2EbDwboyN5qppNgBREkgGeI1xQXJBTrTmX8T4MYBz2xdpRMS6T96+
 gw7LXz0zbHaIRTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C948413882;
 Wed,  7 May 2025 19:39:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vZpqIem2G2j2KgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 07 May 2025 19:39:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 2/3] ci: Fix build-previous-qemu when the version tag is
 absent
In-Reply-To: <aBuvb1adcWnw3Jim@x1.local>
References: <20250507155835.31074-1-farosas@suse.de>
 <20250507155835.31074-3-farosas@suse.de> <aBuvb1adcWnw3Jim@x1.local>
Date: Wed, 07 May 2025 16:39:19 -0300
Message-ID: <87jz6sfbx4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 5B1161F393
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,gitlab.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Wed, May 07, 2025 at 12:58:34PM -0300, Fabiano Rosas wrote:
>> Stefan reports that during QEMU release, pushing a series with the
>> VERSION bump commit, but not pushing the new git tag in the same
>> command will cause a failure of the build-previous-qemu job at the git
>> fetch step.
>> 
>> Since the job is intended to produce a build of the previous QEMU
>> version for consumption by the migration-compat-* jobs, there's no
>> reason to produce a build of the release commit because the migration
>> job would end up testing the release against itself.
>> 
>> Skip the job when VERSION contains the newly release version number.
>> 
>> I'm opting for 'exit 0' for both the build and the test jobs because
>> allow_failure would mask any real error in the jobs. It also avoids
>> having an orange ! on every release pipeline.
>> 
>> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> This is better than before for sure:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Though nitpicks below.
>
>> ---
>>  .gitlab-ci.d/buildtest.yml | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>> index ccf69fb8dd..159bdde2e8 100644
>> --- a/.gitlab-ci.d/buildtest.yml
>> +++ b/.gitlab-ci.d/buildtest.yml
>> @@ -203,6 +203,11 @@ build-previous-qemu:
>>      GIT_FETCH_EXTRA_FLAGS: --prune --quiet
>>    before_script:
>>      - source scripts/ci/gitlab-ci-section
>> +    # Skip if this series contains the release bump commit. During the
>> +    # release process there might be a window of commits when the
>> +    # version tag is not yet present in the remote and git fetch would
>> +    # fail.
>> +    - if grep -q "\.0$" VERSION; then exit 0; fi
>>      - export QEMU_PREV_VERSION="$(sed 's/\([0-9.]*\)\.[0-9]*/v\1.0/' VERSION)"
>>      - git remote add upstream https://gitlab.com/qemu-project/qemu
>>      - git fetch upstream refs/tags/$QEMU_PREV_VERSION:refs/tags/$QEMU_PREV_VERSION
>> @@ -226,7 +231,8 @@ build-previous-qemu:
>>      # Use the migration-tests from the older QEMU tree. This avoids
>>      # testing an old QEMU against new features/tests that it is not
>>      # compatible with.
>> -    - cd build-previous
>> +    # Skip if build-previous-qemu has failed.
>
> This is inaccurate?  As this job could only run if the dependent job
> succeeded IIUC (aka, exit 0 means success).  Meanwhile..
>
>> +    - cd build-previous || exit 0
>
> .. It'll be nice if we could still fail this job if something wrong
> happened in build-previous..
>
> Maybe it's clearer we check .0 here too?  It's oneliner so we could dup it
> I guess.

Ok, let me respin...

> I wished the CI jobs can have nested "rules:"..
>

IIUC, we can't use rules because they're evaluated before the pipeline
starts, so the repo would not have been cloned yet.

>>      # old to new
>>      - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
>>            QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
>> -- 
>> 2.35.3
>> 

