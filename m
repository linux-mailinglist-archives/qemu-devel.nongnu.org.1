Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CD67C5592
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZNG-0006I0-3R; Wed, 11 Oct 2023 09:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqZMv-0006DS-OO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:35:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqZMp-0007qM-Rh
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:35:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5613B1FEB4;
 Wed, 11 Oct 2023 13:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697031314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9SV10ltbpv6+2ycxTOTblqgTBp3dKWpi0Zwm0h0ZLpM=;
 b=usCc/gX3iW42CO2vW4pRoq9VmRTHEYIjymK+AHVqJqqs8nLKMysgEcx+TGZs6mkT67h110
 NqcPAubj5gQVJli1ME6s+UkpsSeWqyiLEvfl9iJAttd+TArBaaWoHKa/cdHIOrA6bZ5bN5
 75xn51jUO2CbmaMlFH8NtR3fy0eSH4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697031314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9SV10ltbpv6+2ycxTOTblqgTBp3dKWpi0Zwm0h0ZLpM=;
 b=A69r7DMurj8Exh3DeqNYcdvMWMCNrwmLkVH9ypgEqgN5oYtg+r+YMasCVHbVFyiHwa1hcU
 Ll4XSfY7f383H5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBE47134F5;
 Wed, 11 Oct 2023 13:35:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EJp/KZGkJmVNUAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 13:35:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 6/6] tests/qtest/migration: Add a test for the
 analyze-migration script
In-Reply-To: <87mswp9tkp.fsf@secure.mitica>
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-7-farosas@suse.de> <87mswp9tkp.fsf@secure.mitica>
Date: Wed, 11 Oct 2023 10:35:11 -0300
Message-ID: <87mswp1dv4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> Add a smoke test that migrates to a file and gives it to the
>> script. It should catch the most annoying errors such as changes in
>> the ram flags.
>>
>> After code has been merged it becomes way harder to figure out what is
>> causing the script to fail, the person making the change is the most
>> likely to know right away what the problem is.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
>
>> ---
>>  tests/qtest/meson.build      |  2 ++
>>  tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 62 insertions(+)
>>
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 1fba07f4ed..5e82eccb62 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -356,6 +356,8 @@ foreach dir : target_dirs
>>      test_deps += [qsd]
>>    endif
>>  
>> +  qtest_env.set('PYTHON', python.full_path())
>> +
>
> I accept it, but I think that this part of the test should be in a
> different patch so meson people could comment O:-)
>
>> +
>> +    pid = fork();
>
> live and see, g_test and qemu don't have a function to execute a script?

gtest has one to execute a _function_ in a fork, but fork+exec no.

