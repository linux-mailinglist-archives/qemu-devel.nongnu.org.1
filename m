Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698DF7D6EBD
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:33:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvewH-0006c0-C4; Wed, 25 Oct 2023 10:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvevb-0006VU-7P
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:32:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvevX-0003bD-JO
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:32:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8C2F21DDD;
 Wed, 25 Oct 2023 14:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698244323; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeIaHaudNwOex2nJBgziT5M5Ge8GpmHX29BdczpdW5M=;
 b=Vro4Cc1HVgy8PnJ/Zr1aNB9DPWyjmrHHrrI7YxH40yVDfrto0uSMgnkwOomejxhJvgFebb
 23P2ieMebFZE8KxmV12zlij5gpOFVdpo80rgc7I7vEBkLuBszt4KNU/2nPE3OebeDbcWw5
 sAYrucOd6kMs9v/HwdWx58+Q5XFvhbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698244323;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeIaHaudNwOex2nJBgziT5M5Ge8GpmHX29BdczpdW5M=;
 b=4szJfPSrjuGh9L/IUdusTBk1CE/MhJ5cnIoBn26BPY+nQT7yQq5rD/Vo6v3C2f8LsjnVNU
 /6OK9DmtTQ9yreCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A253138E9;
 Wed, 25 Oct 2023 14:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Rk+sAeMmOWUvHwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 14:32:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZTjVg9NVTd0MT6mW@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de> <878r7svapt.fsf@pond.sub.org>
 <87msw7ddfp.fsf@suse.de> <ZTjVg9NVTd0MT6mW@redhat.com>
Date: Wed, 25 Oct 2023 11:32:00 -0300
Message-ID: <87cyx2epsv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.97
X-Spamd-Result: default: False [-4.97 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.87)[85.68%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

> On Tue, Oct 24, 2023 at 04:32:10PM -0300, Fabiano Rosas wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>> > Fabiano Rosas <farosas@suse.de> writes:
>> >
>> >> Add the direct-io migration parameter that tells the migration code to
>> >> use O_DIRECT when opening the migration stream file whenever possible.
>> >>
>> >> This is currently only used for the secondary channels of fixed-ram
>> >> migration, which can guarantee that writes are page aligned.
>> >>
>> >> However the parameter could be made to affect other types of
>> >> file-based migrations in the future.
>> >>
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > When would you want to enable @direct-io, and when would you want to
>> > leave it disabled?
>>=20
>> That depends on a performance analysis. You'd generally leave it
>> disabled unless there's some indication that the operating system is
>> having trouble draining the page cache.
>
> That's not the usage model I would suggest.
>

Hehe I took a shot at answering but I really wanted to say "ask Daniel".

> The biggest value of the page cache comes when it holds data that
> will be repeatedly accessed.
>
> When you are saving/restoring a guest to file, that data is used
> once only (assuming there's a large gap between save & restore).
> By using the page cache to save a big guest we essentially purge
> the page cache of most of its existing data that is likely to be
> reaccessed, to fill it up with data never to be reaccessed.
>
> I usually describe save/restore operations as trashing the page
> cache.
>
> IMHO, mgmt apps should request O_DIRECT always unless they expect
> the save/restore operation to run in quick succession, or if they
> know that the host has oodles of free RAM such that existing data
> in the page cache won't be trashed, or

Thanks, I'll try to incorporate this to some kind of doc in the next
version.

> if the host FS does not support O_DIRECT of course.

Should we try to probe for this and inform the user?

