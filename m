Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C55C7B8296
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo35z-0001lq-Ma; Wed, 04 Oct 2023 10:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo35v-0001lT-8L
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:43:24 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo35t-0007My-DI
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:43:22 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 86BFE1F38A;
 Wed,  4 Oct 2023 14:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696430595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17KhPT5RJhdlhve+rF+2xta0W2Lb9RKXHk29pcVXC5A=;
 b=rnAsYN2Y6EKcNcPVW7QH5lnNwRu+zeDpINav/e9IQ2i0fcyMsf7bVhBZVP0alKiKfbcWjx
 025Jf7J4CV/5omD3R7wTIgWdiKYscjvviCYEGX8UOyh+lSOP4kOSRwLB96rVdAHFUERnrd
 tHGyhKwAX5UqUPo8IZlEZVJzS4R2dBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696430595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=17KhPT5RJhdlhve+rF+2xta0W2Lb9RKXHk29pcVXC5A=;
 b=Kh7CWZexyY8fVb3NFuCowrGUMhGswrrVKNuaBQYEKSKLhqH+Usu8eEqKQAhKgXLDkSA5Ru
 Hdp7DUp3P4qtf9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1427513A2E;
 Wed,  4 Oct 2023 14:43:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nb0NNAJ6HWUuBAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 14:43:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
In-Reply-To: <20231004075851.219173-3-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com>
Date: Wed, 04 Oct 2023 11:43:12 -0300
Message-ID: <87jzs2phxb.fsf@suse.de>
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

Het Gala <het.gala@nutanix.com> writes:

> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
> string containing migration connection related information
> and stores them inside well defined 'MigrateAddress' struct.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  migration/exec.c      |  1 -
>  migration/exec.h      |  4 ++++
>  migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+), 1 deletion(-)
>
> diff --git a/migration/exec.c b/migration/exec.c
> index 2bf882bbe1..32f5143dfd 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -27,7 +27,6 @@
>  #include "qemu/cutils.h"
>=20=20
>  #ifdef WIN32
> -const char *exec_get_cmd_path(void);
>  const char *exec_get_cmd_path(void)
>  {
>      g_autofree char *detected_path =3D g_new(char, MAX_PATH);
> diff --git a/migration/exec.h b/migration/exec.h
> index b210ffde7a..736cd71028 100644
> --- a/migration/exec.h
> +++ b/migration/exec.h
> @@ -19,6 +19,10 @@
>=20=20
>  #ifndef QEMU_MIGRATION_EXEC_H
>  #define QEMU_MIGRATION_EXEC_H
> +
> +#ifdef WIN32
> +const char *exec_get_cmd_path(void);
> +#endif
>  void exec_start_incoming_migration(const char *host_port, Error **errp);
>=20=20
>  void exec_start_outgoing_migration(MigrationState *s, const char *host_p=
ort,
> diff --git a/migration/migration.c b/migration/migration.c
> index 6d3cf5d5cd..dcbd509d56 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -65,6 +65,7 @@
>  #include "sysemu/qtest.h"
>  #include "options.h"
>  #include "sysemu/dirtylimit.h"
> +#include "qemu/sockets.h"
>=20=20
>  static NotifierList migration_state_notifiers =3D
>      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
> @@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
>                        QAPI_CLONE(SocketAddress, address));
>  }
>=20=20
> +static bool migrate_uri_parse(const char *uri,
> +                              MigrationAddress **channel,
> +                              Error **errp)
> +{
> +    g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);

This cannot be g_autoptr because you're passing it out of scope at the
end of the function.

> +    SocketAddress *saddr =3D &addr->u.socket;

This attribution is useless. Down below you overwrite it with the result
of socket_parse.

> +    InetSocketAddress *isock =3D &addr->u.rdma;
> +    strList **tail =3D &addr->u.exec.args;
> +
> +    if (strstart(uri, "exec:", NULL)) {
> +        addr->transport =3D MIGRATION_ADDRESS_TYPE_EXEC;
> +#ifdef WIN32
> +        QAPI_LIST_APPEND(tail, g_strdup(exec_get_cmd_path()));
> +        QAPI_LIST_APPEND(tail, g_strdup("/c"));
> +#else
> +        QAPI_LIST_APPEND(tail, g_strdup("/bin/sh"));
> +        QAPI_LIST_APPEND(tail, g_strdup("-c"));
> +#endif
> +        QAPI_LIST_APPEND(tail, g_strdup(uri + strlen("exec:")));
> +    } else if (strstart(uri, "rdma:", NULL)) {
> +        if (inet_parse(isock, uri + strlen("rdma:"), errp)) {
> +            qapi_free_InetSocketAddress(isock);
> +            return false;
> +        }
> +        addr->transport =3D MIGRATION_ADDRESS_TYPE_RDMA;
> +    } else if (strstart(uri, "tcp:", NULL) ||
> +                strstart(uri, "unix:", NULL) ||
> +                strstart(uri, "vsock:", NULL) ||
> +                strstart(uri, "fd:", NULL)) {
> +        addr->transport =3D MIGRATION_ADDRESS_TYPE_SOCKET;
> +        saddr =3D socket_parse(uri, errp);
> +        if (!saddr) {
> +            qapi_free_SocketAddress(saddr);

Shouldn't free here. socket_parse() already does so on failure.

> +            return false;
> +        }

Then here you can set the values you intended to set.

addr->u.socket.type =3D saddr->type;
addr->u.socket.u =3D saddr->u;

> +    } else {
> +        error_setg(errp, "unknown migration protocol: %s", uri);
> +        return false;
> +    }
> +
> +    *channel =3D addr;
> +    return true;
> +}
> +
>  static void qemu_start_incoming_migration(const char *uri, Error **errp)
>  {
>      const char *p =3D NULL;
> +    g_autoptr(MigrationAddress) channel =3D g_new0(MigrationAddress, 1);

The memory is leaked here because the pointer is overwritten below. Just
set it to NULL. You can keep the g_autoptr.

>=20=20
>      /* URI is not suitable for migration? */
>      if (!migration_channels_and_uri_compatible(uri, errp)) {
>          return;
>      }
>=20=20
> +    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
> +        return;
> +    }
> +
>      qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>      if (strstart(uri, "tcp:", &p) ||
>          strstart(uri, "unix:", NULL) ||
> @@ -1671,12 +1721,17 @@ void qmp_migrate(const char *uri, bool has_blk, b=
ool blk,
>      Error *local_err =3D NULL;
>      MigrationState *s =3D migrate_get_current();
>      const char *p =3D NULL;
> +    g_autoptr(MigrationAddress) channel =3D g_new0(MigrationAddress, 1);

Same here.

>=20=20
>      /* URI is not suitable for migration? */
>      if (!migration_channels_and_uri_compatible(uri, errp)) {
>          return;
>      }
>=20=20
> +    if (!migrate_uri_parse(uri, &channel, errp)) {
> +        return;
> +    }
> +
>      resume_requested =3D has_resume && resume;
>      if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
>                           resume_requested, errp)) {

