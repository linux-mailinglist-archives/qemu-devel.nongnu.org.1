Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0DD79F426
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 23:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgXnd-0004cd-GJ; Wed, 13 Sep 2023 17:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgXnb-0004cR-6l
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 17:53:27 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgXnZ-0001Tc-G0
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 17:53:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15E54215E6;
 Wed, 13 Sep 2023 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694642004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2WOgp3IZfd/6UhwnsAkaKgM2lYZ4ASBTBX+ueRMarw=;
 b=B9tcg1jdaDbOZ0woCU4m+cPHti9gijmZhlS8oIHeKfSLtIqFkiXISsXH2ljx09aMqwt0Bh
 dvi1a4JEWNVnJDVVdW/a3yJEj9uLcv9bdiVmPG8/Vf94je82QbmPn938pDd3VJLdwl3ILi
 iREcKMuSE1PqB/uocqcso9uwkBiWB+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694642004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O2WOgp3IZfd/6UhwnsAkaKgM2lYZ4ASBTBX+ueRMarw=;
 b=0J/+zDkSsbwQB8Ox08V/967mguBf2beXGxUm98tXr31ti/tdkIFQgMnz8Um/F4YnlUqNVT
 4OTjn7CiSZmgHPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F02213440;
 Wed, 13 Sep 2023 21:53:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lsWgD1MvAmXIJgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 13 Sep 2023 21:53:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
In-Reply-To: <ZQIX+KUgL5V6H/gj@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
Date: Wed, 13 Sep 2023 18:53:20 -0300
Message-ID: <87jzstkaen.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote:
>> The core yank code is strict about balanced registering and
>> unregistering of yank functions.
>> 
>> This creates a difficulty because the migration code registers one
>> yank function per QIOChannel, but each QIOChannel can be referenced by
>> more than one QEMUFile. The yank function should not be removed until
>> all QEMUFiles have been closed.
>> 
>> Keep a reference count of how many QEMUFiles are using a QIOChannel
>> that has a yank function. Only unregister the yank function when all
>> QEMUFiles have been closed.
>> 
>> This improves the current code by removing the need for the programmer
>> to know which QEMUFile is the last one to be cleaned up and fixes the
>> theoretical issue of removing the yank function while another QEMUFile
>> could still be using the ioc and require a yank.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
>>  migration/yank_functions.h |  8 ++++
>>  2 files changed, 81 insertions(+), 8 deletions(-)
>
> I worry this over-complicate things.

It does. We ran out of simple options.

> If you prefer the cleaness that we operate always on qemufile level, can we
> just register each yank function per-qemufile?

"just" hehe

we could, but:

i) the yank is a per-channel operation, so this is even more unintuitive;

ii) multifd doesn't have a QEMUFile, so it will have to continue using
    the ioc;

iii) we'll have to add a yank to every new QEMUFile created during the
     incoming migration (colo, rdma, etc), otherwise the incoming side
     will be left using iocs while the src uses the QEMUFile;

iv) this is a functional change of the yank feature for which we have no
    tests.

If that's all ok to you I'll go ahead and git it a try.

> I think qmp yank will simply fail the 2nd call on the qemufile if the
> iochannel is shared with the other one, but that's totally fine, IMHO.
>
> What do you think?
>
> In all cases, we should probably at least merge patch 1-8 if that can
> resolve the CI issue.  I think all of them are properly reviewed.

I agree. Someone needs to queue this though since Juan has been busy.

