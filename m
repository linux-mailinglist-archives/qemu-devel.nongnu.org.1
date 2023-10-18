Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728C7CE01B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:37:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7fB-00028k-Sm; Wed, 18 Oct 2023 10:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7f6-00023E-B1
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:36:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7f4-0000YZ-LR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:36:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1944A1F37E;
 Wed, 18 Oct 2023 14:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697639797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQg0Ip+bkeShtEgqIcpDt2jLzm0He39TlkOhi7b7L2Y=;
 b=dhMBfPTGbio7k5Jff+xWrBlr+sfetgDi/3a/CPPT5qGsfn21vlNc68OhmG1FJQM1qEo3jY
 fBmUSF55KfaUSIns7HDzyKJG+fjHF5hcpFAP6wQueXW19Y+K45VtoHWJEQpJpSZt7ih8q5
 8VPHtQHiBDh1TP60ZlgQC4a6utdqPDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697639797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQg0Ip+bkeShtEgqIcpDt2jLzm0He39TlkOhi7b7L2Y=;
 b=a0x3Dyvw7xS1l37Pp/tQtXVuwqvTBAr2dGAAvW56MCxv7cMYxm4aKsl0gNZTR9f8Dbuy3p
 fs18uIoNLn3GKjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A07E113780;
 Wed, 18 Oct 2023 14:36:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EiroGnTtL2UGXQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:36:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 10/11] tests/qtest/migration: Support more than one
 QEMU binary
In-Reply-To: <87edhs80u5.fsf@secure.mitica>
References: <20231018140736.3618-1-farosas@suse.de>
 <20231018140736.3618-11-farosas@suse.de> <87edhs80u5.fsf@secure.mitica>
Date: Wed, 18 Oct 2023 11:36:34 -0300
Message-ID: <87edhsdmkt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.86
X-Spamd-Result: default: False [-4.86 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.76)[84.15%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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
> D> We have strict rules around migration compatibility between different
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
>> Usage:
>> QTEST_QEMU_BINARY_SRC=../build-8.2.0/qemu-system-x86_64 \
>> QTEST_QEMU_BINARY_DST=../build-8.1.0/qemu-system-x86_64 \
>> ./tests/qtest/migration-test
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> The test works for me.  But I would really like to be able to specify
> the machine type for which I have to test.  I.e. right now, we can test:
>
> qemu-8.2 <-> qemu-8.1
>
> and it is going to use q35-8.1
>
> But in the case that I want to test that two binaries with q35-8.0,
> there is no way to setup that.

Sorry, I didn't catch that you wanted to test versions other than the
latest when you mentioned it the first time.

> So basically what I need is
>
> QTEST_QEMU_MACHINE_TYPE var, and if that exist, just use that instead of
> the value of "machine"
>
> What do you think?

I don't see why not.

I have to resend this series because I sent the wrong version by
accident. I'll add the new var then.

