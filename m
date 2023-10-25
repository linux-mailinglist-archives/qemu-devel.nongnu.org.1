Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF77D7044
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:01:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfNB-0001Lq-94; Wed, 25 Oct 2023 11:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvfMt-0000rX-4I
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:00:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qvfMn-0000a1-So
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:00:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 961081FF75;
 Wed, 25 Oct 2023 15:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698246015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DUUUsQbiFl6tVPuKXCknahsql5mquXlXUzOg4upTJo=;
 b=LQpcQlBYhEWrKCFfqMYZoU0KDdQApUD3slJvePPbtSA9dvAHv5Cguqu2+7msokAfBlJeI8
 ZOydW0RDgNthZGxFxjxAiryFGb37Fszri6aE+mBn1OA/ccNuq0DUY6oC3G5ltvZjlIvkzs
 X2ckCF7rb4v8DkL3PwRZmMdRX8LalNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698246015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4DUUUsQbiFl6tVPuKXCknahsql5mquXlXUzOg4upTJo=;
 b=eQSo+gINp+AWjNf/Nj62k1YCCPhyjenoCxMIAEq/iWcs2d89LzVT5jhC9ycERdp3JFcTEm
 T4oUVzz5SJNPlbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28366138E9;
 Wed, 25 Oct 2023 15:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2lj9OH4tOWVALAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 15:00:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 19/29] migration/multifd: Add outgoing QIOChannelFile
 support
In-Reply-To: <ZTkk9MxXydXNlXcU@redhat.com>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-20-farosas@suse.de> <ZTjlQsw9AvA19+QO@redhat.com>
 <87o7gmeqp5.fsf@suse.de> <ZTkk9MxXydXNlXcU@redhat.com>
Date: Wed, 25 Oct 2023 12:00:12 -0300
Message-ID: <877cnaeohv.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

> On Wed, Oct 25, 2023 at 11:12:38AM -0300, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Mon, Oct 23, 2023 at 05:35:58PM -0300, Fabiano Rosas wrote:
>> >> Allow multifd to open file-backed channels. This will be used when
>> >> enabling the fixed-ram migration stream format which expects a
>> >> seekable transport.
>> >>=20
>> >> The QIOChannel read and write methods will use the preadv/pwritev
>> >> versions which don't update the file offset at each call so we can
>> >> reuse the fd without re-opening for every channel.
>> >>=20
>> >> Note that this is just setup code and multifd cannot yet make use of
>> >> the file channels.
>> >>=20
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >> ---
>> >>  migration/file.c      | 64 +++++++++++++++++++++++++++++++++++++++++=
--
>> >>  migration/file.h      | 10 +++++--
>> >>  migration/migration.c |  2 +-
>> >>  migration/multifd.c   | 14 ++++++++--
>> >>  migration/options.c   |  7 +++++
>> >>  migration/options.h   |  1 +
>> >>  6 files changed, 90 insertions(+), 8 deletions(-)
>> >>=20
>> >> diff --git a/migration/file.c b/migration/file.c
>> >> index cf5b1bf365..93b9b7bf5d 100644
>> >> --- a/migration/file.c
>> >> +++ b/migration/file.c
>> >> @@ -17,6 +17,12 @@
>> >
>> >> +void file_send_channel_create(QIOTaskFunc f, void *data)
>> >> +{
>> >> +    QIOChannelFile *ioc;
>> >> +    QIOTask *task;
>> >> +    Error *errp =3D NULL;
>> >> +
>> >> +    ioc =3D qio_channel_file_new_path(outgoing_args.fname,
>> >> +                                    outgoing_args.flags,
>> >> +                                    outgoing_args.mode, &errp);
>> >> +    if (!ioc) {
>> >> +        file_migration_cancel(errp);
>> >> +        return;
>> >> +    }
>> >> +
>> >> +    task =3D qio_task_new(OBJECT(ioc), f, (gpointer)data, NULL);
>> >> +    qio_task_run_in_thread(task, qio_channel_file_connect_worker,
>> >> +                           (gpointer)data, NULL, NULL);
>> >> +}
>> >> +
>> >>  void file_start_outgoing_migration(MigrationState *s, const char *fi=
lespec,
>> >>                                     Error **errp)
>> >>  {
>> >> -    g_autofree char *filename =3D g_strdup(filespec);
>> >>      g_autoptr(QIOChannelFile) fioc =3D NULL;
>> >> +    g_autofree char *filename =3D g_strdup(filespec);
>> >>      uint64_t offset =3D 0;
>> >>      QIOChannel *ioc;
>> >> +    int flags =3D O_CREAT | O_TRUNC | O_WRONLY;
>> >> +    mode_t mode =3D 0660;
>> >>=20=20
>> >>      trace_migration_file_outgoing(filename);
>> >>=20=20
>> >> @@ -50,12 +105,15 @@ void file_start_outgoing_migration(MigrationStat=
e *s, const char *filespec,
>> >>          return;
>> >>      }
>> >>=20=20
>> >> -    fioc =3D qio_channel_file_new_path(filename, O_CREAT | O_WRONLY =
| O_TRUNC,
>> >> -                                     0600, errp);
>>=20
>> By the way, we're experimenting with add-fd to flesh out the interface
>> with libvirt and I see that the flags here can conflict with the flags
>> set on the fd passed through `virsh --pass-fd ...` due to this at
>> monitor_fdset_dup_fd_add():
>>=20
>>     if ((flags & O_ACCMODE) =3D=3D (mon_fd_flags & O_ACCMODE)) {
>>         fd =3D mon_fdset_fd->fd;
>>         break;
>>     }
>>=20
>> We're requiring the O_RDONLY, O_WRONLY, O_RDWR flags defined here to
>> match the fdset passed into QEMU. Should we just sync the code of the
>> two projects to use the same flags? That feels a little clumsy to me.
>
> Is there a reason for libvirt to have set O_RDONLY for a file used
> for outgoing migration ?  I can't recall off-hand.
>

The flags need to match exactly, so either libvirt or QEMU could in the
future decide to use O_RDWR. Then we'd have a compatibility problem when
passing the fds around.

