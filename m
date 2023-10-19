Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC727CFD6C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:58:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUTd-0002gl-7J; Thu, 19 Oct 2023 10:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtUTa-0002Xi-TM
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:58:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtUTZ-00085F-Dl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:58:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 404A221A80;
 Thu, 19 Oct 2023 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697727496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oPPSTrteIjwLwcDXSrWIPEVGaBqZ94eF+TmZVLoXbwo=;
 b=C56bBsMKUcKSkLdvPgetD4FBI1xkU0huqTID6nkWa5wb2SIV6J/mxYhddt/kPWERienZji
 RL4wHr1TpT0veo0Le94VKJ2ey3s9Q8JVlcDWGkEzWI1YtSVs9ztAT5gw/Aleg/CybRmOHl
 87PSOQJJCbNbpLEWGkdOkc9xW+1ZjCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697727496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oPPSTrteIjwLwcDXSrWIPEVGaBqZ94eF+TmZVLoXbwo=;
 b=Y+YtyZ99gT3Odcjq7pCO/gFRy2tw4wmBoL5ag7RwxmxenCxN9ld6Rw7RLtnG0eTusD/JOo
 SbA8tNNSp9hv56DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C89131357F;
 Thu, 19 Oct 2023 14:58:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eE2UJAdEMWUoEwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 14:58:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 2/6] migration/multifd: Stop checking p->quit in
 multifd_send_thread
In-Reply-To: <87o7gv6kt6.fsf@secure.mitica>
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-3-farosas@suse.de> <87o7gv6kt6.fsf@secure.mitica>
Date: Thu, 19 Oct 2023 11:58:13 -0300
Message-ID: <87o7guy7zu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.03
X-Spamd-Result: default: False [-6.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.93)[94.64%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> We don't need to check p->quit in the multifd_send_thread() because it
>> is shadowed by the 'exiting' flag. Ever since that flag was added
>> p->quit became obsolete as a way to stop the thread.
>>
>> Since p->quit is set at multifd_send_terminate_threads() under the
>> p->mutex lock, the thread will only see it once it loops, so 'exiting'
>> will always be seen first.
>>
>> Note that setting p->quit at multifd_send_terminate_threads() still
>> makes sense because we need a way to inform multifd_send_pages() that
>> the channel has stopped.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
>
> But then should we remove the quit altogether?
>

It still serves a purpose to allow multifd_send_pages() to see that the
channel has exited. While that function does also check
multifd_send_state->exiting, it could already be waiting at the mutex
when the channel aborts. So we need to either check 'exiting' again or
keep p->quit.

