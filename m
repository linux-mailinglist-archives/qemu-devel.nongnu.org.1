Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D747DC2A4
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 23:52:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxb6m-0005lN-Ho; Mon, 30 Oct 2023 18:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxb6k-0005k6-5g
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:51:42 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxb6i-0006xc-1r
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 18:51:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D0B41F37E;
 Mon, 30 Oct 2023 22:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698706297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+dxBJqSfTkiYByQBeXz71xpv6mtDNqFoiO3qGQpZcc=;
 b=ZPdp4L78oiamez86pcVrStK1dE3NlDyOM1NB2lFaXMd7q0mReIyp19yd/LUNtBMUxubm/Z
 FDwlR8kmjChitDasoK+dgn310TMC3E/CMe+kwdAbKoDKajH8Y58byYxFGvF8TfpIx/vfpt
 pHRmeoK7KDOkC+ACs+N/ETl6ELTxB/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698706297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9+dxBJqSfTkiYByQBeXz71xpv6mtDNqFoiO3qGQpZcc=;
 b=zt983IoDI0eZvABL+ijKta223OMEZMP15DQ6ZX/rbcaLB7QC35GvqD7HdD1djHeWetML2z
 WcR2DQE8ni5AiTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93415138EF;
 Mon, 30 Oct 2023 22:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VIKbF3gzQGW9RAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 30 Oct 2023 22:51:36 +0000
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
Date: Mon, 30 Oct 2023 19:51:34 -0300
Message-ID: <87cywvenbd.fsf@suse.de>
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

I could use some advice on how to solve this situation. The fdset code
at monitor/fds.c and the add-fd command don't seem to be usable outside
the original use-case of passing fds with different open flags.

There are several problems, the biggest one being that there's no way to
manipulate the set of file descriptors aside from asking for duplication
of an fd that matches a particular set of flags.

That doesn't work for us because the two fds we need (one for main
channel, other for secondary channels) will have the same open flags. So
the fdset code will always return the first one it finds in the set.

Another problem (or feature) of the fdset code is that it only removes
an fd when qmp_remove_fd() is called if the VM runstate is RUNNING,
which means that the migration code cannot remove the fds after use
reliably. We need to be able to remove them to make sure we use the
correct fds in a subsequent migration.

I see some paths forward:

1) Require the user to put the fds in separate fdsets.

  This would be the easiest to handle in the migration code, but we
  would have to come up with special file: URL syntax to accomodate more
  than one fdset. Perhaps "file:/dev/fdsets/1,2" ?

2) Require the two fds in the same fdset and separate them ourselves.

  This would require extending the fdset code to allow more ways of
  manipulating the fdset. There's two options here:

  a) Implement a pop() operation in the fdset code. We receive the
     fdset, pop one fd from it and put it in a new fdset. I did some
     experimentation with this by having an fd->present flag and just
     skipping the fd during query-fdsets and
     monitor_fdset_dup_fd_add(). It works, but it's convoluted.

  b) Add support for removing the original fd when given the dup()ed
     fd. The list of duplicated fds is currently by-fdset and not
     by-original-fd, so this would require a larger code change.

3) Design a whole new URI.

  Here, there are the usual benefits and drawbacks of doing something
  from scratch. With the added drawback of dissociating from the file:
  URI which is already well tested and easy to use when doing QEMU-only
  migration.


With the three options above there's still the issue of removing the
fd. I think the original commit[1] might have been mistaken in adding
the runstate_is_running() check for *both* the "removed =3D true" clause
and the "fd was never duplicated" clause. But it's hard to tell since
this whole feature is a bit opaque to me.

1- ebe52b592d (monitor: Prevent removing fd from set during init)
https://gitlab.com/qemu-project/qemu/-/commit/ebe52b592d

All in all, I'm inclined to consider the first option, unless someone
has a better idea. Assuming we can figure out the removal issue, that
is.

Thoughts?

