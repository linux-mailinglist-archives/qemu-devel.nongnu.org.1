Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2633A0B7B6
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Jan 2025 14:08:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKAS-0004Ke-GM; Mon, 13 Jan 2025 08:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tXKAP-0004A3-4N; Mon, 13 Jan 2025 08:07:41 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tXKAN-0000Li-9Q; Mon, 13 Jan 2025 08:07:40 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 75AE61F381;
 Mon, 13 Jan 2025 13:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736773657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=782ksho9GeDgWJ40ZShlKOm3VcehHtkPcAksBXfnGl0=;
 b=krzxlXtqo6/1Zqfb+GpeUu08BffasNtWKltQXa5zPae+KFzE3vHXy5ooRjX3LjXbg5AuyZ
 15dGfeZLe8EsfXIOPYaRPkriO7kdbKYT7to1KNADAh89pvZyrGm+2yacEwAP4ly2hCw6uW
 gHeZHq/ro07NhAfZYnnjnk3HZIwt/sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736773657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=782ksho9GeDgWJ40ZShlKOm3VcehHtkPcAksBXfnGl0=;
 b=fMdyquKWypbIJav3rodStBqJiOMaNtYPfdFxYoMZ971PQ3t+STdfszdFGDgsFx7XtkWJwe
 K9ffQF5x+3SlfhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736773657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=782ksho9GeDgWJ40ZShlKOm3VcehHtkPcAksBXfnGl0=;
 b=krzxlXtqo6/1Zqfb+GpeUu08BffasNtWKltQXa5zPae+KFzE3vHXy5ooRjX3LjXbg5AuyZ
 15dGfeZLe8EsfXIOPYaRPkriO7kdbKYT7to1KNADAh89pvZyrGm+2yacEwAP4ly2hCw6uW
 gHeZHq/ro07NhAfZYnnjnk3HZIwt/sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736773657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=782ksho9GeDgWJ40ZShlKOm3VcehHtkPcAksBXfnGl0=;
 b=fMdyquKWypbIJav3rodStBqJiOMaNtYPfdFxYoMZ971PQ3t+STdfszdFGDgsFx7XtkWJwe
 K9ffQF5x+3SlfhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E622013876;
 Mon, 13 Jan 2025 13:07:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z9c5KhgQhWeiHgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 13 Jan 2025 13:07:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v3 3/7] migration: Fix parsing of s390 stream
In-Reply-To: <87ed16hnnd.fsf@suse.de>
References: <20250109185249.23952-1-farosas@suse.de>
 <20250109185249.23952-4-farosas@suse.de>
 <35911935-6f5c-40a3-aa73-3586dfdf3268@tls.msk.ru>
 <de853776-69cc-4605-9f9b-e3a60964c3b6@tls.msk.ru>
 <3cc941b1-b09d-4076-9234-9a385c762d3f@redhat.com>
 <fcc69fae-9c5a-4c7b-a6e3-cf445afc205d@tls.msk.ru>
 <a54d8f52-c11e-4eab-bdb7-c3ac1f353f3e@redhat.com>
 <d89067d5-31d0-42ba-b4e4-b9af1e921a3f@tls.msk.ru> <87ed16hnnd.fsf@suse.de>
Date: Mon, 13 Jan 2025 10:07:34 -0300
Message-ID: <87bjwahnft.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[gitlab.com:url,suse.de:mid,suse.de:email,analyze-migration.py:url,tls.msk.ru:email,imap1.dmz-prg2.suse.org:helo,analyze-script.py:url];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Michael Tokarev <mjt@tls.msk.ru> writes:
>
>> 13.01.2025 11:19, Thomas Huth wrote:
>>> On 13/01/2025 08.51, Michael Tokarev wrote:
>>
>>>> Picked up:
>>>>
>>>> =C2=A0=C2=A01/7 migration: Add more error handling to analyze-migratio=
n.py
>>>> =C2=A0=C2=A03/7 migration: Fix parsing of s390 stream
>>>> =C2=A0=C2=A07/7 s390x: Fix CSS migration
>>>>
>>>> but still getting the same error:
>>>>
>>>> =C2=A0=C2=A0https://gitlab.com/mjt0k/qemu/-/jobs/8832218999 (9.2 branc=
h)
>>>> =C2=A0=C2=A0https://gitlab.com/mjt0k/qemu/-/jobs/8832224338 (9.1 branc=
h)
>>>=20
>>> Blindly guessing: You need now patch 4/7 and 5/7, too? ... hopefully Fa=
biano could reply and point you to the exact set of patches that you need...
>>
>> Yes, after picking up ALL 7 out of 7 in this patchset (b/c even the
>> trivial 2/7, "migration: Remove unused argument in vmsd_desc_field_end",
>> is needed or else the subsequent fixes doesn't apply) it is now green
>> finally, eg, https://gitlab.com/mjt0k/qemu/-/jobs/8832849813
>>
>> Fabiano, what do you think, - should the whole patchset be picked up
>> for 9.2 and 9.1?
>
> Yeah, sorry, I was focused on unbreaking the migration PR and added a
> bunch of patches without thinking of stable.
>
> So the s390x regression (1/7) is 9.1, but 9.0 already had the broken

7/7

> analyze-script.py (3/7) and the broken array compression code (4-6/7).
>
> We definitely need 1/7 for 9.1 and 9.2. The rest of the series is "just"

7/7

> to avoid breaking the tests. If you can apply it easily I think that's
> preferable. Otherwise maybe we could disable the analyze-migration.py
> test for stable? I can also work on a backport if needed. Let me know
> what you prefer.
>
>>
>> Thanks,
>>
>> /mjt

