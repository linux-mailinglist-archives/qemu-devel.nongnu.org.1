Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C387DE0AB
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 13:18:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyA9Y-0007Td-4F; Wed, 01 Nov 2023 08:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyA9I-0007Nb-7D
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 08:16:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyA9G-0008Rs-9x
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 08:16:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A966721854;
 Wed,  1 Nov 2023 12:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698840996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViD5gk77ywZD7AtBE4YAuDTAX9UPhVM+8jUdyQujzzU=;
 b=pql1phq/KQ1f3jxG81gNlUjWRA1MLXrzZ4a3WTYqNQJEw2/a21W6PZ231/8/nRW6YyUVI2
 VxH6gTmJSZrPVK9Sj7LG8zy2MoIu8fVV/gGrLU2ZTrebKabNOJsZ5UbsjnmCicN93czhZs
 T7atCFa1MNvNXHBFCutYuVene1NaTqc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698840996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ViD5gk77ywZD7AtBE4YAuDTAX9UPhVM+8jUdyQujzzU=;
 b=0XW63fWeQVL4KrbeWTggz0nx1lv7m0p0Wl3Ofkhdz9DXRAXLqt7H4ZGy8DuadmuLii0oUa
 6MpkP/nP3JpKaKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BF0E1348D;
 Wed,  1 Nov 2023 12:16:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id djZ7AqRBQmUTUAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 01 Nov 2023 12:16:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZUIav68fksPZpIJm@redhat.com>
References: <ZTkpllWQdLSMw3pP@redhat.com> <87cywvenbd.fsf@suse.de>
 <ZUDC4aoPZZQAF6JU@redhat.com> <878r7jdjrf.fsf@suse.de>
 <ZUEE9XP4YTJkZTv7@redhat.com> <875y2meua3.fsf@suse.de>
 <ZUEbzvRLdGjl4gl+@redhat.com> <8734xqeqly.fsf@suse.de>
 <ZUEkOb8M4fgfEITi@redhat.com> <87wmv2d33p.fsf@suse.de>
 <ZUIav68fksPZpIJm@redhat.com>
Date: Wed, 01 Nov 2023 09:16:33 -0300
Message-ID: <87zfzxfz32.fsf@suse.de>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Oct 31, 2023 at 04:05:46PM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Tue, Oct 31, 2023 at 12:52:41PM -0300, Fabiano Rosas wrote:
>> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >> >
>> >> > I guess I'm not seeing the problem still.  A single FD is passed ac=
ross
>> >> > from libvirt, but QEMU is free to turn that into *many* FDs for its
>> >> > internal use, using dup() and then setting O_DIRECT on as many/few =
of
>> >> > the dup()d FDs as its wants to.
>> >>=20
>> >> The problem is that duplicated FDs share the file status flags. If we
>> >> set O_DIRECT on the multifd channels and the main thread happens to do
>> >> an unaligned write with qemu_file_put* then the filesystem will fail
>> >> that write.
>> >
>> > Doh, I had forgotten that sharing.
>> >
>> > Do we have any synchronization between multifd  channels and the main
>> > thread ?  eg does the main thread wait for RAM sending completion
>> > before carrying on writing other non-RAM data ?
>>=20
>> We do have, but the issue with that approach is that there are no rules
>> for adding data into the stream. Anyone could add a qemu_put_* call
>> right in the middle of the section for whatever reason.
>>=20
>> That is almost a separate matter due to our current compatibility model
>> being based on capabilities rather than resilience of the stream
>> format. So extraneous data in the stream always causes the migration to
>> break.
>>=20
>> But with the O_DIRECT situation we'd be adding another aspect to
>> this. Not only changing the code requires syncing capabilities (as it
>> does today), but it would also require knowing which parts of the stream
>> can be interrupted by new data and which cannot.
>>=20
>> So while it would probably work, it's also a little fragile. If QEMU
>> were given 2 FDs or given access to the file, then only the multifd
>> channels would get O_DIRECT and they are guaranteed to not have
>> extraneous unaligned data showing up.
>
> So the problem with add-fd is that when requesting a FD, the monitor
> code masks flags with O_ACCMODE.  What if we extended it such that
> the monitor masked with O_ACCMODE | O_DIRECT.
>
> That would let us pass 1 plain FD and one O_DIRECT fd, and be able
> to ask for each separately by setting O_DIRECT or not.

That would likely work. The usage gets a little more complicated, but
we'd be using fdset as it was intended.

Should we keep the direct-io capability? If the user now needs to set
O_DIRECT and also set the cap, that seems a little redundant. I could
keep O_DIRECT in the flags (when supported) and test after open if we
got the flag set. If it's not set, then we remove O_DIRECT from the
flags and retry.

> Existing users of add-fd are not likely to be affected since none of
> them will be using O_DIRECT.

I had thought of passing a comparison function into
monitor_fdset_dup_fd_add() to avoid affecting existing users. That would
require plumbing it through qemu_open_internal() or moving
monitor_fdset_dup_fd_add() earlier in the stack (probably more
sensible). I'll not worry about that for now though, let's first make
sure the approach you suggested works.

