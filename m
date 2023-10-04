Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 863D97B82D0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:56:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Hs-00049o-Fa; Wed, 04 Oct 2023 10:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3Hl-00045J-VU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:55:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3Hj-0004vq-SU
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:55:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4B42521855;
 Wed,  4 Oct 2023 14:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696431334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ido6CvnikoFHjSY3kjmtHVtdbgtj7AIgy0rY+xIxKwY=;
 b=1bIET3JYIubJsOgZZIOkaOV3Mk3tdET9G7WoE92wWJhcjan2RRe7qVgFluOaWZYFjNWrlw
 5IpWGVDmh3Jt34wXnAVZWNRQZJdyGlzgPCEM3f2FhKpZ/dC/vSlPnOjecONlpMhryFU7Ui
 X0J87h+QJdkGNGi15VciJCBjtWM1c4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696431334;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ido6CvnikoFHjSY3kjmtHVtdbgtj7AIgy0rY+xIxKwY=;
 b=ukUuabdrSV7u84lZoyE/2jal6VIo5c4JMCNksNx/hlyfqWjBacZCaTPrT3Jbwr4Hq3F8pI
 7HHmmkHldej1boDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1D2A13A2E;
 Wed,  4 Oct 2023 14:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kPr1JuV8HWWLCwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 14:55:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v11 05/10] migration: convert exec backend to accept
 MigrateAddress.
In-Reply-To: <20231004075851.219173-6-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-6-het.gala@nutanix.com>
Date: Wed, 04 Oct 2023 11:55:31 -0300
Message-ID: <87h6n6phcs.fsf@suse.de>
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

Het Gala <het.gala@nutanix.com> writes:

> Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
> new wire protocol of MigrateAddress struct.
>
> It is achived by parsing 'uri' string and storing migration parameters
> required for exec connection into strList struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  migration/exec.c      | 71 +++++++++++++++++++++++++++++++------------
>  migration/exec.h      |  4 +--
>  migration/migration.c | 10 +++---
>  3 files changed, 57 insertions(+), 28 deletions(-)
>
> diff --git a/migration/exec.c b/migration/exec.c
> index 32f5143dfd..8bc321c66b 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -39,20 +39,50 @@ const char *exec_get_cmd_path(void)
>  }
>  #endif
>=20=20
> -void exec_start_outgoing_migration(MigrationState *s, const char *comman=
d, Error **errp)
> +/* provides the length of strList */
> +static int
> +str_list_length(strList *list)
> +{
> +    int len =3D 0;
> +    strList *elem;
> +
> +    for (elem =3D list; elem !=3D NULL; elem =3D elem->next) {
> +        len++;
> +    }
> +
> +    return len;
> +}
> +
> +static void
> +init_exec_array(strList *command, char **argv, Error **errp)
> +{
> +    int i =3D 0;
> +    strList *lst;
> +
> +    for (lst =3D command; lst; lst =3D lst->next) {
> +        argv[i++] =3D lst->value;
> +    }
> +
> +    argv[i] =3D NULL;

This will write out of bounds.=20

> +    return;
> +}
> +
> +void exec_start_outgoing_migration(MigrationState *s, strList *command,
> +                                   Error **errp)
>  {
>      QIOChannel *ioc;
>=20=20
> -#ifdef WIN32
> -    const char *argv[] =3D { exec_get_cmd_path(), "/c", command, NULL };
> -#else
> -    const char *argv[] =3D { "/bin/sh", "-c", command, NULL };
> -#endif
> +    int length =3D str_list_length(command);
> +    g_auto(GStrv) argv =3D (char **) g_new0(const char *, length);

This allocation does not leave space for the NULL byte.

>=20=20
> -    trace_migration_exec_outgoing(command);
> -    ioc =3D QIO_CHANNEL(qio_channel_command_new_spawn(argv,
> -                                                    O_RDWR,
> -                                                    errp));
> +    init_exec_array(command, argv, errp);
> +    g_autofree char *new_command =3D g_strjoinv(" ", (char **)argv);
> +
> +    trace_migration_exec_outgoing(new_command);
> +    ioc =3D QIO_CHANNEL(
> +        qio_channel_command_new_spawn((const char * const *) argv,
> +                                      O_RDWR,
> +                                      errp));
>      if (!ioc) {
>          return;
>      }
> @@ -71,20 +101,21 @@ static gboolean exec_accept_incoming_migration(QIOCh=
annel *ioc,
>      return G_SOURCE_REMOVE;
>  }
>=20=20
> -void exec_start_incoming_migration(const char *command, Error **errp)
> +void exec_start_incoming_migration(strList *command, Error **errp)
>  {
>      QIOChannel *ioc;
>=20=20
> -#ifdef WIN32
> -    const char *argv[] =3D { exec_get_cmd_path(), "/c", command, NULL };
> -#else
> -    const char *argv[] =3D { "/bin/sh", "-c", command, NULL };
> -#endif
> +    int length =3D str_list_length(command);
> +    g_auto(GStrv) argv =3D (char **) g_new0(const char *, length);

Here as well.

> +
> +    init_exec_array(command, argv, errp);
> +    g_autofree char *new_command =3D g_strjoinv(" ", (char **)argv);
>=20=20
> -    trace_migration_exec_incoming(command);
> -    ioc =3D QIO_CHANNEL(qio_channel_command_new_spawn(argv,
> -                                                    O_RDWR,
> -                                                    errp));
> +    trace_migration_exec_incoming(new_command);
> +    ioc =3D QIO_CHANNEL(
> +        qio_channel_command_new_spawn((const char * const *) argv,
> +                                      O_RDWR,
> +                                      errp));
>      if (!ioc) {
>          return;
>      }
> diff --git a/migration/exec.h b/migration/exec.h
> index 736cd71028..3107f205e3 100644
> --- a/migration/exec.h
> +++ b/migration/exec.h
> @@ -23,8 +23,8 @@
>  #ifdef WIN32
>  const char *exec_get_cmd_path(void);
>  #endif
> -void exec_start_incoming_migration(const char *host_port, Error **errp);
> +void exec_start_incoming_migration(strList *host_port, Error **errp);
>=20=20
> -void exec_start_outgoing_migration(MigrationState *s, const char *host_p=
ort,
> +void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
>                                     Error **errp);
>  #endif
> diff --git a/migration/migration.c b/migration/migration.c
> index b41fda6f80..ebe14b9c38 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -474,7 +474,6 @@ static bool migrate_uri_parse(const char *uri,
>=20=20
>  static void qemu_start_incoming_migration(const char *uri, Error **errp)
>  {
> -    const char *p =3D NULL;
>      g_autoptr(MigrationAddress) channel =3D g_new0(MigrationAddress, 1);
>=20=20
>      /* URI is not suitable for migration? */
> @@ -500,8 +499,8 @@ static void qemu_start_incoming_migration(const char =
*uri, Error **errp)
>      } else if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_RDMA) {
>          rdma_start_incoming_migration(&channel->u.rdma, errp);
>  #endif
> -    } else if (strstart(uri, "exec:", &p)) {
> -        exec_start_incoming_migration(p, errp);
> +    } else if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_start_incoming_migration(channel->u.exec.args, errp);
>      } else {
>          error_setg(errp, "unknown migration protocol: %s", uri);
>      }
> @@ -1723,7 +1722,6 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
>      bool resume_requested;
>      Error *local_err =3D NULL;
>      MigrationState *s =3D migrate_get_current();
> -    const char *p =3D NULL;
>      g_autoptr(MigrationAddress) channel =3D g_new0(MigrationAddress, 1);
>=20=20
>      /* URI is not suitable for migration? */
> @@ -1761,8 +1759,8 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
>      } else if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_RDMA) {
>          rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
>  #endif
> -    } else if (strstart(uri, "exec:", &p)) {
> -        exec_start_outgoing_migration(s, p, &local_err);
> +    } else if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_EXEC) {
> +        exec_start_outgoing_migration(s, channel->u.exec.args, &local_er=
r);
>      } else {
>          error_setg(&local_err, QERR_INVALID_PARAMETER_VALUE, "uri",
>                     "a valid migration protocol");

