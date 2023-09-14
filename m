Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF457A1150
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 00:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgvEB-0003X1-FH; Thu, 14 Sep 2023 18:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgvE9-0003Wr-Fv
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 18:54:25 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgvE7-0008FR-LX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 18:54:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17068211B7;
 Thu, 14 Sep 2023 22:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694732062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJVvysg7EeHW+lHN9y30sXzx21+P9BuxdrA6zmus6+o=;
 b=nelPOWDFt0DCJ6yb9Hzl6qVEJpbUG3rDiUZiQnjbHdTyl1LXPPqfFu4si0Kf0cwdFNdPTd
 Ccoqfx8fNHjbY7KxGRDtdOPQjsesTjzTbfyvw0UEFhbSF+cZEbuHz0Hvp1wFmUC8oRxsGj
 4avirb83SIKYWs49L5kTEQTI65y01pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694732062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uJVvysg7EeHW+lHN9y30sXzx21+P9BuxdrA6zmus6+o=;
 b=EpYOnXGSzmLGPrdZmJinIRyrJzNZIZTMd8Jh3N3NSXypbo7dT9kDj+Uqx9jePPn+OaFqXY
 ZIb5vtyS608yVvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 53A1213580;
 Thu, 14 Sep 2023 22:54:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wgnjAB2PA2WhTgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 14 Sep 2023 22:54:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <87led8e9vv.fsf@suse.de>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de> <ZQMoUzRH1BZKs39g@x1n>
 <87bke4kasr.fsf@suse.de> <ZQM3SV4eqSltoQSe@x1n> <87led8e9vv.fsf@suse.de>
Date: Thu, 14 Sep 2023 19:54:17 -0300
Message-ID: <87r0n0nz6u.fsf@suse.de>
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
>>> I managed to reproduce it. It's not the return path error. In hindsight
>>> that's obvious because that error happens in the 'recovery' test and this
>>> one in the 'plain' one. Sorry about the noise.
>>
>> No worry.  It's good to finally identify that.
>>
>>> 
>>> This one reproduced with just 4 iterations of preempt/plain. I'll
>>> investigate.
>
> It seems that we're getting a tcp disconnect (ECONNRESET) on when doing
> that shutdown() on postcopy_qemufile_src. The one from commit 6621883f93
> ("migration: Fix potential race on postcopy_qemufile_src").
>
> I'm trying to determine why that happens when other times it just
> returns 0 as expected.
>
> Could this mean that we're kicking the dest too soon while it is still
> receiving valid data?

Looking a bit more into this, what's happening is that
postcopy_ram_incoming_cleanup() is shutting the postcopy_qemufile_dst
while ram_load_postcopy() is still running.

The postcopy_ram_listen_thread() function waits for the
main_thread_load_event, but that only works when not using preempt. With
the preempt thread, the event is set right away and we proceed to do the
cleanup without waiting.

So the assumption of commit 6621883f93 that the incoming side knows when
it has finished migrating is wrong IMO. Without the EOS we're relying on
the chance that the shutdown() happens after the last recvmsg has
returned and not during it.

Peter, what do you think?

