Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F17A27D7275
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 19:37:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvhos-0006of-75; Wed, 25 Oct 2023 13:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvhon-0006j3-Ad
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:37:22 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvhol-0004iC-87
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 13:37:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A742621BDC;
 Wed, 25 Oct 2023 17:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698255004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riH23IoDp3+XWP3QMnTKXl0x9mIqagqXbgP0ssDGD1s=;
 b=1G8C8zJX/N4nZvXuPim/cDUcQt7+G8ChD24Qjk6yzrfV4/5aURUZIzT/xKsmoWmQCeJDRf
 qIWdGk79vh6IbNs5veoSVota9CKv24SaRpmmDClbiHl2G+1FICF5SOKoaPVfyZa/AoM9VN
 OIk1Z4RERt5jZHW7LyWrqZq2QnF2lV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698255004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riH23IoDp3+XWP3QMnTKXl0x9mIqagqXbgP0ssDGD1s=;
 b=s7ONM7cOwLuR1mKzmzFofHpO4IMGwYZoFg1pDwLsd3QalOwsQYwjxp/wxQR5hTpRXsFs7d
 jbtOZl4rmiKSkOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A4F3138E9;
 Wed, 25 Oct 2023 17:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KZ4nApxQOWWoZgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 17:30:04 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZTkpllWQdLSMw3pP@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de> <878r7svapt.fsf@pond.sub.org>
 <87msw7ddfp.fsf@suse.de> <ZTjVg9NVTd0MT6mW@redhat.com>
 <87cyx2epsv.fsf@suse.de> <ZTkpllWQdLSMw3pP@redhat.com>
Date: Wed, 25 Oct 2023 14:30:01 -0300
Message-ID: <8734xyehk6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
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

> On Wed, Oct 25, 2023 at 11:32:00AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Oct 24, 2023 at 04:32:10PM -0300, Fabiano Rosas wrote:
>> >> Markus Armbruster <armbru@redhat.com> writes:
>> >>=20
>> >> > Fabiano Rosas <farosas@suse.de> writes:
>> >> >
>> >> >> Add the direct-io migration parameter that tells the migration cod=
e to
>> >> >> use O_DIRECT when opening the migration stream file whenever possi=
ble.
>> >> >>
>> >> >> This is currently only used for the secondary channels of fixed-ram
>> >> >> migration, which can guarantee that writes are page aligned.
>> >> >>
>> >> >> However the parameter could be made to affect other types of
>> >> >> file-based migrations in the future.
>> >> >>
>> >> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> >
>> >> > When would you want to enable @direct-io, and when would you want to
>> >> > leave it disabled?
>> >>=20
>> >> That depends on a performance analysis. You'd generally leave it
>> >> disabled unless there's some indication that the operating system is
>> >> having trouble draining the page cache.
>> >
>> > That's not the usage model I would suggest.
>> >
>>=20
>> Hehe I took a shot at answering but I really wanted to say "ask Daniel".
>>=20
>> > The biggest value of the page cache comes when it holds data that
>> > will be repeatedly accessed.
>> >
>> > When you are saving/restoring a guest to file, that data is used
>> > once only (assuming there's a large gap between save & restore).
>> > By using the page cache to save a big guest we essentially purge
>> > the page cache of most of its existing data that is likely to be
>> > reaccessed, to fill it up with data never to be reaccessed.
>> >
>> > I usually describe save/restore operations as trashing the page
>> > cache.
>> >
>> > IMHO, mgmt apps should request O_DIRECT always unless they expect
>> > the save/restore operation to run in quick succession, or if they
>> > know that the host has oodles of free RAM such that existing data
>> > in the page cache won't be trashed, or
>>=20
>> Thanks, I'll try to incorporate this to some kind of doc in the next
>> version.
>>=20
>> > if the host FS does not support O_DIRECT of course.
>>=20
>> Should we try to probe for this and inform the user?
>
> qemu_open_internall will already do a nice error message. If it gets
> EINVAL when using O_DIRECT, it'll retry without O_DIRECT and if that
> works, it'll reoprt "filesystem does not support O_DIRECT"
>
> Having said that I see a problem with /dev/fdset handling, because
> we're only validating O_ACCMODE and that excludes O_DIRECT.
>
> If the mgmt apps passes an FD with O_DIRECT already set, then it
> won't work for VMstate saving which is unaligned.
>
> If the mgmt app passes an FD without O_DIRECT set, then we are
> not setting O_DIRECT for the multifd RAM threads.

Worse, the fds get dup'ed so even without O_DIRECT, we we enable it for
the secondary channels the main channel will break on unaligned writes.

For now I can only think of requiring two fds. One for the main channel
and a second one for the rest of the channels. And validating the fd
flags to make sure O_DIRECT is only allowed to be set in the second fd.

