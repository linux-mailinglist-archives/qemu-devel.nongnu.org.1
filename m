Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 028888BB5C2
	for <lists+qemu-devel@lfdr.de>; Fri,  3 May 2024 23:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s30V5-0002m3-FU; Fri, 03 May 2024 17:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s30Ux-0002jh-DC
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:31:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s30Uu-0007rs-GG
 for qemu-devel@nongnu.org; Fri, 03 May 2024 17:31:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C004207DA;
 Fri,  3 May 2024 21:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714771870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV5HwJLA7mTLW+xOGeaI2GhAlmw4TYp6JGcKOjzMB4c=;
 b=I7dgdEjpgWwDA2YtamKGktlR3gRYxB1qtTWTNTyz7m/lMey+9njjLTBiEa1qm/v7Yc4uJK
 93IEm1HJuXk+IhDctg+VCHvRUKXMl161kraBIYGyt6N60q6DjEktuFwxKIZVL2mmxzDySp
 SQbpyb58pLIEEqOyJhGKBSUU3nOczk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714771870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV5HwJLA7mTLW+xOGeaI2GhAlmw4TYp6JGcKOjzMB4c=;
 b=ExbS9J69dtrtN5292C84QQo7As5P85rjwPSpU2jo/isxQjiql36zzfHEOfWA3XA8ZCZQjN
 j5+beDuE4kbw1yAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="QT/sqkIf";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=M4n0DNJn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714771869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV5HwJLA7mTLW+xOGeaI2GhAlmw4TYp6JGcKOjzMB4c=;
 b=QT/sqkIfxuG/I+UIHAfFOcevRscJfbLUq/Q8IaRGPwYIXzSwBjQnVTmUAO2nAxwQnbgFa+
 P8g7JByLw/9/K0WPL1tqVEKD4MLhZ0MG0daHuPo7HglAk/MrrG6yfN892B0cE7njHKWaWr
 GKfLa1bowW8+qBy16t/0xAos/lhC8+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714771869;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JV5HwJLA7mTLW+xOGeaI2GhAlmw4TYp6JGcKOjzMB4c=;
 b=M4n0DNJnpdYYoctW5n2Lbv4dYYAmB2mahrZtGt5LaiZi8w+XCywWzQ5/e5fRCnK0caZ2go
 VoLK+pUkmie4mVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 089B2139CB;
 Fri,  3 May 2024 21:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7nkZMJxXNWaoEwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 03 May 2024 21:31:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Claudio
 Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 2/9] migration: Fix file migration with fdset
In-Reply-To: <ZjVRS6yT6n7_wb0V@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-3-farosas@suse.de> <ZjUPl6XwB3Zt3cKR@x1n>
 <87a5l6oejr.fsf@suse.de> <ZjVRS6yT6n7_wb0V@x1n>
Date: Fri, 03 May 2024 18:31:06 -0300
Message-ID: <87plu2mvl1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7C004207DA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,treblig.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, May 03, 2024 at 04:56:08PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Fri, Apr 26, 2024 at 11:20:35AM -0300, Fabiano Rosas wrote:
>> >> When the migration using the "file:" URI was implemented, I don't
>> >> think any of us noticed that if you pass in a file name with the
>> >> format "/dev/fdset/N", this allows a file descriptor to be passed in
>> >> to QEMU and that behaves just like the "fd:" URI. So the "file:"
>> >> support has been added without regard for the fdset part and we got
>> >> some things wrong.
>> >>=20
>> >> The first issue is that we should not truncate the migration file if
>> >> we're allowing an fd + offset. We need to leave the file contents
>> >> untouched.
>> >
>> > I'm wondering whether we can use fallocate() instead on the ranges so =
that
>> > we always don't open() with O_TRUNC.  Before that..  could you remind =
me
>> > why do we need to truncate in the first place?  I definitely missed
>> > something else here too.
>>=20
>> AFAIK, just to avoid any issues if the file is pre-existing. I don't see
>> the difference between O_TRUNC and fallocate in this case.
>
> Then, shall we avoid truncations at all, leaving all the feasibility to
> user (also errors prone to make)?
>

Is this a big deal? I'd rather close that possible gap and avoid the bug
reports.

>>=20
>> >
>> >>=20
>> >> The second issue is that there's an expectation that QEMU removes the
>> >> fd after the migration has finished. That's what the "fd:" code
>> >> does. Otherwise a second migration on the same VM could attempt to
>> >> provide an fdset with the same name and QEMU would reject it.
>> >
>> > Let me check what we do when with "fd:" and when migration completes or
>> > cancels.
>> >
>> > IIUC it's qio_channel_file_close() that does the final cleanup work on
>> > e.g. to_dst_file, right?  Then there's qemu_close(), and it has:
>> >
>> >     /* Close fd that was dup'd from an fdset */
>> >     fdset_id =3D monitor_fdset_dup_fd_find(fd);
>> >     if (fdset_id !=3D -1) {
>> >         int ret;
>> >
>> >         ret =3D close(fd);
>> >         if (ret =3D=3D 0) {
>> >             monitor_fdset_dup_fd_remove(fd);
>> >         }
>> >
>> >         return ret;
>> >     }
>> >
>> > Shouldn't this done the work already?
>>=20
>> That removes the mon_fdset_fd_dup->fd, we want to remove the
>> mon_fdset_fd->fd.
>
> What I read so far is when we are removing the dup-fds, we'll do one more
> thing:
>
> monitor_fdset_dup_fd_find_remove():
>                     if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
>                         monitor_fdset_cleanup(mon_fdset);
>                     }
>
> It means if we removed all the dup-fds correctly, we should also remove t=
he
> whole fdset, which includes the ->fds, IIUC.
>

Since mon_fdset_fd->removed =3D=3D false, we hit the runstate_is_running()
problem. I'm not sure, but probably mon_refcount > 0 as well. So the fd
would not be removed.

But I'll retest this on Monday just be sure, it's been a while since I
wrote some parts of this.

>>=20
>> >
>> > Off topic: I think this code is over complicated too, maybe I missed
>> > something, but afaict we don't need monitor_fdset_dup_fd_find at all..=
 we
>> > simply walk the list and remove stuff..  I attach a patch at the end t=
hat I
>> > tried to clean that up, just in case there's early comments.  But we c=
an
>> > ignore that so we don't get side-tracked, and focus on the direct-io
>> > issues.
>>=20
>> Well, I'm not confident touching this code. This is more than a decade
>> old, I have no idea what the original motivations were. The possible
>> interactions with the user via command-line (-add-fd), QMP (add-fd) and
>> the monitor lifetime make me confused. Not to mention the fdset part
>> being plumbed into the guts of a widely used qemu_open_internal() that
>> very misleadingly presents itself as just a wrapper for open().
>
> If to make QEMU long live, we'll probably need to touch it at some
> point.. or at least discuss about it and figure things out. We pay tech
> debts like this when there's no good comment / docs to refer in this case,
> then the earlier, perhaps also the better.. to try taking the stab, imho.
>
> Definitely not a request to clean everything up. :) Let's see whether
> others can chim in with better knowledge of the history.
>
>>=20
>> >
>> > Thanks,
>> >
>> > =3D=3D=3D=3D=3D=3D=3D
>> >
>> > From 2f6b6d1224486d8ee830a7afe34738a07003b863 Mon Sep 17 00:00:00 2001
>> > From: Peter Xu <peterx@redhat.com>
>> > Date: Fri, 3 May 2024 11:27:20 -0400
>> > Subject: [PATCH] monitor: Drop monitor_fdset_dup_fd_add()
>> > MIME-Version: 1.0
>> > Content-Type: text/plain; charset=3DUTF-8
>> > Content-Transfer-Encoding: 8bit
>> >
>> > This function is not needed, one remove function should already work.
>> > Clean it up.
>> >
>> > Here the code doesn't really care about whether we need to keep that d=
upfd
>> > around if close() failed: when that happens something got very wrong,
>> > keeping the dup_fd around the fdsets may not help that situation so fa=
r.
>> >
>> > Cc: Dr. David Alan Gilbert <dave@treblig.org>
>> > Cc: Markus Armbruster <armbru@redhat.com>
>> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> > Cc: Paolo Bonzini <pbonzini@redhat.com>
>> > Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  include/monitor/monitor.h |  1 -
>> >  monitor/fds.c             | 27 +++++----------------------
>> >  stubs/fdset.c             |  5 -----
>> >  util/osdep.c              | 15 +--------------
>> >  4 files changed, 6 insertions(+), 42 deletions(-)
>> >
>> > diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
>> > index 965f5d5450..fd9b3f538c 100644
>> > --- a/include/monitor/monitor.h
>> > +++ b/include/monitor/monitor.h
>> > @@ -53,7 +53,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fds=
et_id, int64_t fdset_id,
>> >                                  const char *opaque, Error **errp);
>> >  int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags);
>> >  void monitor_fdset_dup_fd_remove(int dup_fd);
>> > -int64_t monitor_fdset_dup_fd_find(int dup_fd);
>> >=20=20
>> >  void monitor_register_hmp(const char *name, bool info,
>> >                            void (*cmd)(Monitor *mon, const QDict *qdic=
t));
>> > diff --git a/monitor/fds.c b/monitor/fds.c
>> > index d86c2c674c..d5aecfb70e 100644
>> > --- a/monitor/fds.c
>> > +++ b/monitor/fds.c
>> > @@ -458,7 +458,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int=
 flags)
>> >  #endif
>> >  }
>> >=20=20
>> > -static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remo=
ve)
>> > +void monitor_fdset_dup_fd_remove(int dup_fd)
>> >  {
>> >      MonFdset *mon_fdset;
>> >      MonFdsetFd *mon_fdset_fd_dup;
>> > @@ -467,31 +467,14 @@ static int64_t monitor_fdset_dup_fd_find_remove(=
int dup_fd, bool remove)
>> >      QLIST_FOREACH(mon_fdset, &mon_fdsets, next) {
>> >          QLIST_FOREACH(mon_fdset_fd_dup, &mon_fdset->dup_fds, next) {
>> >              if (mon_fdset_fd_dup->fd =3D=3D dup_fd) {
>> > -                if (remove) {
>> > -                    QLIST_REMOVE(mon_fdset_fd_dup, next);
>> > -                    g_free(mon_fdset_fd_dup);
>> > -                    if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
>> > -                        monitor_fdset_cleanup(mon_fdset);
>> > -                    }
>> > -                    return -1;
>> > -                } else {
>> > -                    return mon_fdset->id;
>> > +                QLIST_REMOVE(mon_fdset_fd_dup, next);
>> > +                g_free(mon_fdset_fd_dup);
>> > +                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
>> > +                    monitor_fdset_cleanup(mon_fdset);
>> >                  }
>> >              }
>> >          }
>> >      }
>> > -
>> > -    return -1;
>> > -}
>> > -
>> > -int64_t monitor_fdset_dup_fd_find(int dup_fd)
>> > -{
>> > -    return monitor_fdset_dup_fd_find_remove(dup_fd, false);
>> > -}
>> > -
>> > -void monitor_fdset_dup_fd_remove(int dup_fd)
>> > -{
>> > -    monitor_fdset_dup_fd_find_remove(dup_fd, true);
>> >  }
>> >=20=20
>> >  int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp)
>> > diff --git a/stubs/fdset.c b/stubs/fdset.c
>> > index d7c39a28ac..389e368a29 100644
>> > --- a/stubs/fdset.c
>> > +++ b/stubs/fdset.c
>> > @@ -9,11 +9,6 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int fl=
ags)
>> >      return -1;
>> >  }
>> >=20=20
>> > -int64_t monitor_fdset_dup_fd_find(int dup_fd)
>> > -{
>> > -    return -1;
>> > -}
>> > -
>> >  void monitor_fdset_dup_fd_remove(int dupfd)
>> >  {
>> >  }
>> > diff --git a/util/osdep.c b/util/osdep.c
>> > index e996c4744a..2d9749d060 100644
>> > --- a/util/osdep.c
>> > +++ b/util/osdep.c
>> > @@ -393,21 +393,8 @@ int qemu_open_old(const char *name, int flags, ..=
.)
>> >=20=20
>> >  int qemu_close(int fd)
>> >  {
>> > -    int64_t fdset_id;
>> > -
>> >      /* Close fd that was dup'd from an fdset */
>> > -    fdset_id =3D monitor_fdset_dup_fd_find(fd);
>> > -    if (fdset_id !=3D -1) {
>> > -        int ret;
>> > -
>> > -        ret =3D close(fd);
>> > -        if (ret =3D=3D 0) {
>> > -            monitor_fdset_dup_fd_remove(fd);
>> > -        }
>> > -
>> > -        return ret;
>> > -    }
>> > -
>> > +    monitor_fdset_dup_fd_remove(fd);
>> >      return close(fd);
>> >  }
>> >=20=20
>> > --=20
>> > 2.44.0
>>=20

