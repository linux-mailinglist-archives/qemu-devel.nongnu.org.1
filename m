Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D10AD7DCF45
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:34:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxpoR-0000Z5-KC; Tue, 31 Oct 2023 10:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxpoE-0000Qy-Ca
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:33:35 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxpoB-0008Ot-KH
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:33:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7A5121AD7;
 Tue, 31 Oct 2023 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698762806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEkuDzSjRmO+QDQshVX2CEQANLKyTTX0Euo/GxC+pvA=;
 b=IURV6RGhWoqMngoBkGu9QNwmNivvLKX5ujx/7xz+W1jA+xIlgWv8ZOfncU4GChQ64FNVV0
 qlahCR7c//hGlu+VCHdvSI4hvcXIPaYr4acz/jJtGOHF3yUCh55lQOP3V+OrVGwHwnw0Cz
 oXBk/TQOCtEI3sxbc76XNjvcsNCirLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698762806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GEkuDzSjRmO+QDQshVX2CEQANLKyTTX0Euo/GxC+pvA=;
 b=wmj8VJ41Zbue29rcL8CXv3wZe1FDZ6XvYVrhbwLguRwfCQNRWb0V/IYRnzjxv4wQQWKEtd
 CYdtUYeeMEnfTnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A56C1391B;
 Tue, 31 Oct 2023 14:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RcHECTYQQWVdFQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 14:33:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Juan
 Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 28/29] migration: Add direct-io parameter
In-Reply-To: <ZUEE9XP4YTJkZTv7@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-29-farosas@suse.de> <878r7svapt.fsf@pond.sub.org>
 <87msw7ddfp.fsf@suse.de> <ZTjVg9NVTd0MT6mW@redhat.com>
 <87cyx2epsv.fsf@suse.de> <ZTkpllWQdLSMw3pP@redhat.com>
 <87cywvenbd.fsf@suse.de> <ZUDC4aoPZZQAF6JU@redhat.com>
 <878r7jdjrf.fsf@suse.de> <ZUEE9XP4YTJkZTv7@redhat.com>
Date: Tue, 31 Oct 2023 11:33:24 -0300
Message-ID: <875y2meua3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

> On Tue, Oct 31, 2023 at 10:05:56AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Oct 30, 2023 at 07:51:34PM -0300, Fabiano Rosas wrote:
>> >> I could use some advice on how to solve this situation. The fdset code
>> >> at monitor/fds.c and the add-fd command don't seem to be usable outsi=
de
>> >> the original use-case of passing fds with different open flags.
>> >>=20
>> >> There are several problems, the biggest one being that there's no way=
 to
>> >> manipulate the set of file descriptors aside from asking for duplicat=
ion
>> >> of an fd that matches a particular set of flags.
>> >>=20
>> >> That doesn't work for us because the two fds we need (one for main
>> >> channel, other for secondary channels) will have the same open flags.=
 So
>> >> the fdset code will always return the first one it finds in the set.
>> >
>> > QEMU may want multiple FDs *internally*, but IMHO that fact should
>> > not be exposed to mgmt applications. It would be valid for a QEMU
>> > impl to share the same FD across multiple threads, or have a different
>> > FD for each thread. All threads are using pread/pwrite, so it is safe
>> > for them to use the same FD if they desire. It is a private impl choice
>> > for QEMU at any given point in time and could change over time.
>> >
>>=20
>> Sure, I don't disagree. However up until last week we had a seemingly
>> usable "add-fd" command that allows the user to provide a *set of file
>> descriptors* to QEMU. It's just now that we're learning that interface
>> serves only a special use-case.
>
> AFAICT though we don't need add-fd to support passing many files
> for our needs. Saving only requires a single FD. All others can
> be opened by dup(), so the limitation of add-fd is irrelevant
> surely ?

Only once we decide to use one FD. If we had a generic add-fd backend,
then that's already a user-facing API, so the "implementation detail"
argument becomes weaker.

With a single FD we'll need to be very careful about what code is
allowed to run while the multifd channels are doing IO. Since O_DIRECT
is not widely supported, now we have to also be careful about someone
using that QEMUFile handle to do unaligned writes and not even noticing
that it breaks direct IO. None of this in unworkable, of course, I just
find the design way clearer with just the file name + offset.

>> > Thus from the POV of the mgmt app, QEMU is writing to a single file, no
>> > matter how many threads are involved & thus it should only need to sup=
ply
>> > a single FD for thta file. QEMU can then call 'dup()' on that FD as ma=
ny
>> > times as it desires, and use fcntl() to toggle O_DIRECT if and when
>> > it needs to.
>>=20
>> Ok, so I think the way to go here is for QEMU to receive a file + offset
>> instead of an FD. That way QEMU can have adequate control of the
>> resources for the migration. I don't remember why we went on the FD
>> tangent. Is it not acceptable for libvirt to provide the file name +
>> offset?
>
> FD passing means QEMU does not need privileges to open the file
> which could be useful.

Ok, let me give this a try. Let's see how bad it is to juggle the flag
around the main channel.

