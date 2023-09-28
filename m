Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B517B1EE9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:48:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrMv-0001Kk-W3; Thu, 28 Sep 2023 09:47:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlrMt-00017O-3v
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:47:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qlrMr-0006AM-9y
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:47:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 88965211CE;
 Thu, 28 Sep 2023 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695908867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsSplpacFdSwaTTKCcjFihF9jzZtlXN3/Pz0pfnuT0E=;
 b=M9JTWmdPpYhAu3sG4/B/nMMvfBYHz8Agbmrpa6O/viG7SAhQdVvBd01QyO43ze6+JdS2gI
 LXBEIhh2brt8fqxHTjA3i4g+WC956yYO+apzBWfPrJGJCN270Va7nQiHhcXCA1aeV5Yp5W
 5GZtj9TRdHrgkmq7ryof8Q6sZZBG+lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695908867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XsSplpacFdSwaTTKCcjFihF9jzZtlXN3/Pz0pfnuT0E=;
 b=M3fqWBNcd7auoEM1iZD/LdxgXfknEgxsVP1N6k94w9ybc+zCN1JMSEwIkKExrgFvcOqZdL
 VnPnUGZvQ48pvVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D616138E9;
 Thu, 28 Sep 2023 13:47:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xzWnNgKEFWUMegAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 28 Sep 2023 13:47:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qtest/migration: Add a test for the analyze-migration
 script
In-Reply-To: <9a3212d0-f89a-33a9-a82b-53dcc3e4dcf6@redhat.com>
References: <20230927214756.14117-1-farosas@suse.de>
 <62c405c9-27f2-a77a-1f94-8d03cf65fff6@redhat.com> <8734yyo22f.fsf@suse.de>
 <9a3212d0-f89a-33a9-a82b-53dcc3e4dcf6@redhat.com>
Date: Thu, 28 Sep 2023 10:47:44 -0300
Message-ID: <87zg16mmtb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Thomas Huth <thuth@redhat.com> writes:

> On 28/09/2023 15.32, Fabiano Rosas wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>> 
>>> On 27/09/2023 23.47, Fabiano Rosas wrote:
>>>> Add a smoke test that migrates to a file and gives it to the
>>>> script. It should catch the most annoying errors such as changes in
>>>> the ram flags.
>>>>
>>>> After code has been merged it becomes way harder to figure out what is
>>>> causing the script to fail, the person making the change is the most
>>>> likely to know right away what the problem is.
>>>>
>>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>>> ---
>>>> I know this adds a python dependency to qtests and I'm not sure how
>>>> much we care about this script, but on the other hand it would be nice
>>>> to catch these errors early on.
>>>>
>>>> This would also help with future work that touches the migration
>>>> stream (moving multifd out of ram.c and fixed-ram).
>>>>
>>>> Let me know what you think.
>>>
>>> Without looking at this too closely, my first thought was: This sounds
>>> rather like a good candidate for an avocado test instead. It's using Python,
>>> so tests/avocado/ sounds like a better fit. Have you considered adding it as
>>> an avocado test already?
>>>
>> 
>> I intended to keep all migration tests at the same place. And well, to
>> be honest, I have given up on avocado. Too unmaintained, incrutable
>> logging and last time I tried to use it locally, it was leaving stale
>> processes behind upon failure.
>> 
>> Of course, if that's the preferred place to put python tests I could do
>> it, but I don't find it too compelling.
>
> Well, I guess this test here is kind of borderline, since it does not 
> introduce new Python code, but just calls a pre-existing python script...
> maybe that's still ok for the qtests ... what do other people think?
>
>>>   >+#define ANALYZE_SCRIPT "tests/qtest/analyze-migration.py"
>>>
>>> Why can't you use scripts/analyze-migration.py directly?
>>>
>> 
>> I'm not entirely sure that's the case with QEMU, but generally build
>> directories can move/not be directly under the source tree. The test
>> wouldn't know from where to fetch the script.
>
> AFAIK the build system puts a symlink for the scripts folder into the build 
> directory, at least I have one in mine.
>

Oh, I have one too. It never crossed my mind that it could already be
there! I should be able to use it then.

Thanks!

