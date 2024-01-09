Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 865888286AA
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 14:01:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNBia-0000I6-Vc; Tue, 09 Jan 2024 08:00:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNBiT-0000Eb-OJ
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:00:25 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNBiR-00007b-S4
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 08:00:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 682831F7FD;
 Tue,  9 Jan 2024 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704805220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxDBxcW036CVK4/xghT7i5fvh6aUZH7F0Qpa5F+y7Hw=;
 b=tyquDihnDvZ9FPBUhTGvKO3CdwH85ZpSp4oqvKpbacEEfk/SaotUhn13K6JLLGkolFPu9B
 OiYHILMKVXbA8gUf694WH1qW44CLxVfEkzsesukesfPY7VwcTCZui+qFVYKaXRPvdH8IoT
 CesquuceQak6eX4h9sJcGF5KEoZ9doo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704805220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxDBxcW036CVK4/xghT7i5fvh6aUZH7F0Qpa5F+y7Hw=;
 b=lz2LiYduxFnipltrGGqVlABToDw/o6s5kYVcvVV695UqRdeIKl/75HkccDsDY/8Cb+xwGs
 jTYSXGYDZXaM8rBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704805220; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxDBxcW036CVK4/xghT7i5fvh6aUZH7F0Qpa5F+y7Hw=;
 b=tyquDihnDvZ9FPBUhTGvKO3CdwH85ZpSp4oqvKpbacEEfk/SaotUhn13K6JLLGkolFPu9B
 OiYHILMKVXbA8gUf694WH1qW44CLxVfEkzsesukesfPY7VwcTCZui+qFVYKaXRPvdH8IoT
 CesquuceQak6eX4h9sJcGF5KEoZ9doo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704805220;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JxDBxcW036CVK4/xghT7i5fvh6aUZH7F0Qpa5F+y7Hw=;
 b=lz2LiYduxFnipltrGGqVlABToDw/o6s5kYVcvVV695UqRdeIKl/75HkccDsDY/8Cb+xwGs
 jTYSXGYDZXaM8rBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4BF21392C;
 Tue,  9 Jan 2024 13:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4CfVKWNDnWWfRwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 09 Jan 2024 13:00:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v3 3/4] ci: Add a migration compatibility test job
In-Reply-To: <ZZzyZhUbgt9WhaAP@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-4-farosas@suse.de> <ZZzyZhUbgt9WhaAP@x1n>
Date: Tue, 09 Jan 2024 10:00:17 -0300
Message-ID: <8734v68xwe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 05, 2024 at 03:04:48PM -0300, Fabiano Rosas wrote:
>> The migration tests have support for being passed two QEMU binaries to
>> test migration compatibility.
>> 
>> Add a CI job that builds the lastest release of QEMU and another job
>> that uses that version plus an already present build of the current
>> version and run the migration tests with the two, both as source and
>> destination. I.e.:
>> 
>>  old QEMU (n-1) -> current QEMU (development tree)
>>  current QEMU (development tree) -> old QEMU (n-1)
>> 
>> The purpose of this CI job is to ensure the code we're about to merge
>> will not cause a migration compatibility problem when migrating the
>> next release (which will contain that code) to/from the previous
>> release.
>> 
>> I'm leaving the jobs as manual for now because using an older QEMU in
>> tests could hit bugs that were already fixed in the current
>> development tree and we need to handle those case-by-case.
>
> Can we opt-out those broken tests using either your "since:" thing or
> anything similar?

If it's something migration related, then yes. But there might be other
types of breakages that have nothing to do with migration. Our tests are
not resilent enough (nor they should) to detect when QEMU aborted for
other reasons. Think about the -audio issue: the old QEMU would just say
"there's no -audio option, abort" and that's a test failure of course.

> I hope we can start to run something by default in the CI in 9.0 to cover
> n-1 -> n, even if starting with a subset of tests.  Is it possible?

We could maybe have it enabled with "allow_failure" set. The important
thing here is that we don't want to get reports of "flaky test". These
tests are kind of flaky by definition, there's no way to backport a fix
to the older QEMU, so there's always the chance that this test will be
broken for a whole release cycle. We should act fast in adding the
"since" annotation or other workaround, but that depends on our
availability and the type of bug that we hit.

