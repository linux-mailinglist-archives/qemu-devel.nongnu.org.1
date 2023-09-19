Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A97A6AFA
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 20:58:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qifuR-0007MB-20; Tue, 19 Sep 2023 14:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qifuP-0007M3-4O
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 14:57:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qifuL-0004Ku-IA
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 14:57:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33B5222679;
 Tue, 19 Sep 2023 18:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695149830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCJrxpPmJZq9LovHCRjjMxcvOFdPXJD/PSMP5R06pGY=;
 b=e42lSkJSuY+641v1oz6csgn4ahxmak0rT1/LZMVm2kOdIjmjPrBcMVcUf/LVuUGboQln0+
 irxTtBpjKv7dDR68Y6zhNUKf51xXP7u+5WI3+8aFX2g8VjFWnopzzukumqBwEyORnIBImQ
 EnzwIQYliB9Dh2RoZGamFAQQFOnWqe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695149830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCJrxpPmJZq9LovHCRjjMxcvOFdPXJD/PSMP5R06pGY=;
 b=5jIg2cn6AqRndIGLDwinjFf5MOdXYa1KlCODJ1+qE2r2XibRVtGwPkkTbd5N8Fid0U/AIn
 wtovnB55vhrCLTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBCC6134F3;
 Tue, 19 Sep 2023 18:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /iqxIQXvCWXCXwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 19 Sep 2023 18:57:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Peter Xu
 <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, leobras@redhat.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
In-Reply-To: <ZQnojJOqoFu73995@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <ZQnRKjo0M50BRbZh@x1n> <ZQnojJOqoFu73995@redhat.com>
Date: Tue, 19 Sep 2023 15:57:07 -0300
Message-ID: <87sf7aout8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 19, 2023 at 12:49:46PM -0400, Peter Xu wrote:
>> On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
>> > Oh dear, where to start.  There's so much wrong, and in pretty obvious
>> > ways.  This code should never have passed review.  I'm refraining from
>> > saying more; see the commit messages instead.
>> >=20
>> > Issues remaining after this series include:
>> >=20
>> > * Terrible error messages
>> >=20
>> > * Some error message cascades remain
>> >=20
>> > * There is no written contract for QEMUFileHooks, and the
>> >   responsibility for reporting errors is unclear
>>=20
>> Even being removed.. because no one is really extending that..
>>=20
>> https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.com/#t
>
> One day (in another 5-10 years) I still hope we'll get to
> the point where QEMUFile itself is obsolete :-) Getting
> rid of QEMUFileHooks is a great step in that direction.
> Me finishing a old PoC to bring buffering to QIOChannel
> would be another big step.
>

If you need any help with that let me know. I've been tripping over
QEMUFile weirdness on a daily basis.

Just last week I was looking into restricting the usage of
qemu_file_set_error() to qemu-file.c so we can get rid of this situation
where any piece of code that has a pointer to the QEMUFile can put
whatever it wants in f->last_error* and the rest of the code has to
guess when to call qemu_file_get_error().

*last_error actually stores the first error

Moving all the interesting parts into the channel and removing QEMUFile
would of course be the better solution. Multifd already ignores it
completly, so there's probably more code that could be made generic
after that change.

Also, looking at what people do with iovs in the block layer, it seems
the migration code is a little behind.

> The data rate limiting would be the biggest missing piece
> to enable migration/vmstate logic to directly consume
> a QIOChannel.
>
> Eliminating QEMUFile would help to bring Error **errp
> to all the vmstate codepaths.
>
>> > * There seem to be no tests whatsoever
>>=20
>> I always see rdma as "odd fixes" stage.. for a long time.  But maybe I w=
as
>> wrong.
>
> In the MAINTAINERS file RDMA still get classified as formally
> supported under the migration maintainers.  I'm not convinced
> that is an accurate description of its status.  I tend to agree
> with you that it is 'odd fixes' at the very best.
>
> Dave Gilbert had previously speculated about whether we should
> even consider deprecating it on the basis that latest non-RDMA
> migration is too much better than in the past, with multifd
> and zerocopy, that RDMA might not even offer a significant
> enough peformance win to justify.
>
>> Copying Zhijian for status of rdma; Zhijian, I saw that you just replied=
 to
>> the hwpoison issue.  Maybe we should have one entry for rdma too, just l=
ike
>> colo?
>
> With regards,
> Daniel

