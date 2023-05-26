Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8EA7127FE
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 16:06:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Y4I-0000Mg-BC; Fri, 26 May 2023 10:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q2Y4F-0000Li-FV; Fri, 26 May 2023 10:05:19 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q2Y4D-00015D-5M; Fri, 26 May 2023 10:05:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5B5971F86C;
 Fri, 26 May 2023 14:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685109911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WAMmg+6DhVXBeZaK+4ytscykqDtaJa8xMmoZwcTwEM=;
 b=bkd4ZQ3zM/636s1Wtz6lE9djXZOO2K+9D4BMZWTN/C6cH7EWYC70S60zWgnJD6mao/gYDk
 2qZksEOeSANxGG0987Bb+7jQF0IJeTidmiDthZ7Qt1p8/Sd6KJNoiJMUGOJqa3H22TmIIO
 nrzbDCDEdpuK/SAPbMRBVgXsfhGhfD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685109911;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+WAMmg+6DhVXBeZaK+4ytscykqDtaJa8xMmoZwcTwEM=;
 b=PWDmRH4NP8UbrMF0AIKcPDFuX9vGaQ2zJT878EB/OjSFgH2S0XZaxe8A2BEBUIQ9ckUQNk
 ovDfHlyN2bb7sqCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3DB2138E6;
 Fri, 26 May 2023 14:05:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0VgwJ5a8cGSfbgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 26 May 2023 14:05:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Jo=C3=A3o?= Silva <jsilva@suse.de>, Lin Ma
 <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [RFC PATCH 3/6] Convert query-block/info_block to coroutine
In-Reply-To: <i2zakx3qtd5kodcay6uablx7pawdkx2sh2pl33ump4ssxwhuiv@z7auumqij7ry>
References: <20230523213903.18418-1-farosas@suse.de>
 <20230523213903.18418-4-farosas@suse.de>
 <i2zakx3qtd5kodcay6uablx7pawdkx2sh2pl33ump4ssxwhuiv@z7auumqij7ry>
Date: Fri, 26 May 2023 11:05:08 -0300
Message-ID: <87bki79oiz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

> On Tue, May 23, 2023 at 06:39:00PM -0300, Fabiano Rosas wrote:
>> From: Lin Ma <lma@suse.com>
>> 
>> Sometimes the query-block performs time-consuming I/O(say waiting for
>> the fstat of NFS complete), So let's make this QMP handler runs in a
>> coroutine.
>
> Grammar suggestions:
>
> Sometimes the query-block command performs time-consuming I/O (say
> waiting for the fstat of NFS to complete), so let's make this QMP
> handler run in a coroutine.
>

Thanks!

>> 
>> The following patch moves the fstat() into a thread pool.
>> 
>> Signed-off-by: Lin Ma <lma@suse.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
>> ---
>> +++ b/qapi/block-core.json
>> @@ -838,7 +838,7 @@
>>  #    }
>>  ##
>>  { 'command': 'query-block', 'returns': ['BlockInfo'],
>> -  'allow-preconfig': true }
>> +  'allow-preconfig': true, 'coroutine': true }
>
> Rereading docs/devel/qapi-code-gen.rst:
>
> | Coroutine safety can be hard to prove, similar to thread safety.  Common
> | pitfalls are:
> | 
> | - The global mutex isn't held across ``qemu_coroutine_yield()``, so
> |   operations that used to assume that they execute atomically may have
> |   to be more careful to protect against changes in the global state.
> | 
> | - Nested event loops (``AIO_WAIT_WHILE()`` etc.) are problematic in
> |   coroutine context and can easily lead to deadlocks.  They should be
> |   replaced by yielding and reentering the coroutine when the condition
> |   becomes false.
> | 
> | Since the command handler may assume coroutine context, any callers
> | other than the QMP dispatcher must also call it in coroutine context.
> | In particular, HMP commands calling such a QMP command handler must be
> | marked ``.coroutine = true`` in hmp-commands.hx.
>
> I agree that you also need to change the HMP handler, but the commit
> message didn't mention that other than in the subject line.  The

Ok, I'll update the message for v2.

> commit message could also do a better job at explaining how you have
> audited that merely adding the coroutine marker is safe (ie. that all
> of the calls made by query_block are already coroutine safe).  While
> the intent behind this patch is on the right track, I'm not sure if I
> have enough information to say whether it is safe, or if there are
> other lurking problems we will need to fix first.

Fair point, I've been trusting the tests too much. A closer code audit
is necessary indeed.

