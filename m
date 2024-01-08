Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2138273A7
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:38:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrhN-0007ED-4V; Mon, 08 Jan 2024 10:37:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMrhL-0007E1-H3
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:37:55 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMrhJ-0007jx-Rn
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:37:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39E831F7B1;
 Mon,  8 Jan 2024 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704728271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zldRdguGkMMKip5BB+DzFzzvdalQBIgIn/UouPwGpVA=;
 b=IwCmYO6cq/IHA3MwK4PbHu+v3ll3IL/kYmt8uR2WbxkqWApijXvPKzClkNEuPmxifQw9s0
 6FVAxjIeiMU8on0ZTzg2cpyGJZF7a+tzYiHpIlqP9Je0ntt4R0gSbiOlH6zGRWYsSJfc01
 gU/8RgjKEJl62j9dRtmposN7bKavTxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704728271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zldRdguGkMMKip5BB+DzFzzvdalQBIgIn/UouPwGpVA=;
 b=B+/VnPK+a/U2WPW5jI1ZT0vfjZzxDUq+2fqysIUt2O88m7ph7iO/U5urVQ573Px/FSBhK7
 cflxqK02ZtiuqjBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704728271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zldRdguGkMMKip5BB+DzFzzvdalQBIgIn/UouPwGpVA=;
 b=IwCmYO6cq/IHA3MwK4PbHu+v3ll3IL/kYmt8uR2WbxkqWApijXvPKzClkNEuPmxifQw9s0
 6FVAxjIeiMU8on0ZTzg2cpyGJZF7a+tzYiHpIlqP9Je0ntt4R0gSbiOlH6zGRWYsSJfc01
 gU/8RgjKEJl62j9dRtmposN7bKavTxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704728271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zldRdguGkMMKip5BB+DzFzzvdalQBIgIn/UouPwGpVA=;
 b=B+/VnPK+a/U2WPW5jI1ZT0vfjZzxDUq+2fqysIUt2O88m7ph7iO/U5urVQ573Px/FSBhK7
 cflxqK02ZtiuqjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1AB913686;
 Mon,  8 Jan 2024 15:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tx5sFs4WnGVOXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Jan 2024 15:37:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
In-Reply-To: <ZZuvDREDrQ07HsGs@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
Date: Mon, 08 Jan 2024 12:37:46 -0300
Message-ID: <877ckj3kfp.fsf@suse.de>
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
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 05, 2024 at 03:04:49PM -0300, Fabiano Rosas wrote:
>> [This patch is not necessary anymore after 8.2 has been released]
>> 
>> Add the 'since' annotations to recently added tests and adapt the
>> postcopy test to use the older "uri" API when needed.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> You marked this as not-for-merge.  Would something like this still be
> useful in the future?  IIUC it's a matter of whether we'd still want to
> test those old binaries.
>

Technically yes, but I fail to see what benefit testing old binaries
would bring us. I'm thinking maybe it could be useful for bisecting
compatibility issues, but I can't think of a scenario where we'd like to
change the older QEMU instead of the newer.

I'm of course open to suggestions if you or anyone else has an use case
that you'd like to keep viable.

So far, my idea is that once a new QEMU is released, all the "since:"
annotations become obsolete. We could even remove them. This series is
just infrastructure to make our life easier if a change is ever
introduced that is incompatible with the n-1 QEMU. IMO we cannot have
compatibility testing if a random change might break a test and make it
more difficult to run the remaining tests. So we'd use 'since' or the
vercmp function to skip/adapt the offending tests until the next QEMU is
released.

I'm basing myself on this loosely worded support statement from our
docs:

  "In general QEMU tries to maintain forward migration compatibility
  (i.e. migrating from QEMU n->n+1) and there are users who benefit from
  backward compatibility as well."



