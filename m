Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB4712822
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2YJW-0005sU-2S; Fri, 26 May 2023 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q2YJK-0005rp-Mn; Fri, 26 May 2023 10:20:54 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q2YJH-0007FJ-S9; Fri, 26 May 2023 10:20:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4E981FD88;
 Fri, 26 May 2023 14:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685110849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzST/zccVFV9Q3DLL8zPRdDUhTRpUOyutU41z3TCEcA=;
 b=S6MlerT0yzPN31F0e18REPXyR12key/rnchf5ZK7bcUjDqGN/wDOsoSCVGfidzPplCN9Ou
 qagAZcl0zQ2/740vbZcFoh7Ex8AUWZSCDxatETxMARH0fXxS8BBkOob071OUnwovjRt8OZ
 SUFpRSdVDtv74EKjbOcOrG7qpTIsuCA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685110849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XzST/zccVFV9Q3DLL8zPRdDUhTRpUOyutU41z3TCEcA=;
 b=KJd4p/zI7TL38srSqiURb/7vuCavmJ12YByP2RPx6lQnH/cSBFkKOHA36B7iUM6ci7Qc9m
 1aIDFgtqjyRt6LAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E1E2138E6;
 Fri, 26 May 2023 14:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2lQCDkHAcGSRcwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 26 May 2023 14:20:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Jo=C3=A3o?= Silva <jsilva@suse.de>, Lin Ma
 <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>
Subject: Re: [RFC PATCH 6/6] block: Add a thread-pool version of fstat
In-Reply-To: <tgkuil4lqa3x7tkzup4shdeie2z2j6uzzrn7ccf42uimjm64yz@7ksw3twdshye>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-7-farosas@suse.de>
 <tgkuil4lqa3x7tkzup4shdeie2z2j6uzzrn7ccf42uimjm64yz@7ksw3twdshye>
Date: Fri, 26 May 2023 11:20:47 -0300
Message-ID: <877csv9nsw.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Eric Blake <eblake@redhat.com> writes:

> On Tue, May 23, 2023 at 06:39:03PM -0300, Fabiano Rosas wrote:
>> From: Jo=C3=A3o Silva <jsilva@suse.de>
>>=20
>> The fstat call can take a long time to finish when running over
>> NFS. Add a version of it that runs in the thread pool.
>>=20
>> Adapt one of its users, raw_co_get_allocated_file size to use the new
>> version. That function is called via QMP under the qemu_global_mutex
>> so it has a large chance of blocking VCPU threads in case it takes too
>> long to finish.
>>=20
>> Signed-off-by: Jo=C3=A3o Silva <jsilva@suse.de>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  block/file-posix.c      | 40 +++++++++++++++++++++++++++++++++++++---
>>  include/block/raw-aio.h |  4 +++-
>>  2 files changed, 40 insertions(+), 4 deletions(-)
>
> Should this change occur earlier in the series, before calling
> commands are marked with QAPI coroutine flags?  Otherwise, you have a
> bisection bug, where something marked coroutine can end up hanging
> when it calls a blocking syscall in the wrong context without the help
> of this patch offloading the syscall into a helper thread.

Hmm, I'm not sure. To submit the work to the thread pool we need to be
in a coroutine already. If the syscall blocks for too long we'd be
trading blocking the coroutine vs. blocking a vcpu thread anyway.

I have tested each patch to avoid bisection issues, but maybe it would
be warranted to merge both parts into a single patch. Or arrange them in
some other way... I'll experiment with it.


