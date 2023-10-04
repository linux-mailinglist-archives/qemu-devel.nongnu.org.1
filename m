Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6257B8383
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:26:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3kz-0005F4-FF; Wed, 04 Oct 2023 11:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3kx-00056D-AN
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:25:47 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo3kv-0007Td-7E
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:25:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1C6D11F85D;
 Wed,  4 Oct 2023 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696433142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZaTeojmK3IpIpJK9TsE/ek7qFY3AtHHi+aovFTtg1Q=;
 b=PslD3lpTc1mEvXDpS0HL6PpPhh56xzsY4LC2wAWgvs3wGW6WWOV2N5S/6FAVBPV2d3+Fi1
 q0dqTb1bWqybzBRgbRfaylg3vSEbmD9sbCArsWtkwuAaA7Ncw5OJp56KZiEM8zzXS/ufZ3
 vA792Bjx/FxprgFO6vjs4i675hI4F04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696433142;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IZaTeojmK3IpIpJK9TsE/ek7qFY3AtHHi+aovFTtg1Q=;
 b=ZqaSNvAOXB19MIrV4KvxGrI3VpC1Ll/ZdBh3oFZT+1ndUCG1vUN3GiGsWZUoYvrpyFCkdU
 ibXbSLsmV9djkuCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A165B13A2E;
 Wed,  4 Oct 2023 15:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fNcyGvWDHWVsHAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 15:25:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: Re: [PATCH v11 09/10] migration: Implement MigrateChannelList to
 hmp migration flow.
In-Reply-To: <20231004075851.219173-10-het.gala@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-10-het.gala@nutanix.com>
Date: Wed, 04 Oct 2023 12:25:39 -0300
Message-ID: <87bkdepfyk.fsf@suse.de>
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

> Integrate MigrateChannelList with all transport backends
> (socket, exec and rdma) for both src and dest migration
> endpoints for hmp migration.
>
> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  migration/migration-hmp-cmds.c | 15 +++++++++++++--
>  migration/migration.c          |  5 ++---
>  migration/migration.h          |  3 ++-
>  3 files changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmd=
s.c
> index a2e6a5c51e..a1657f3d37 100644
> --- a/migration/migration-hmp-cmds.c
> +++ b/migration/migration-hmp-cmds.c
> @@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict =
*qdict)
>  {
>      Error *err =3D NULL;
>      const char *uri =3D qdict_get_str(qdict, "uri");
> +    MigrationChannelList *caps =3D NULL;
> +    g_autoptr(MigrationChannel) channel =3D g_new0(MigrationChannel, 1);

Just the pointer here. If I remember correctly the g_autoptr here would
cause a double free when freeing the caps.

>=20=20
> -    qmp_migrate_incoming(uri, false, NULL, &err);
> +    migrate_uri_parse(uri, &channel, &err);
> +    QAPI_LIST_PREPEND(caps, channel);
>=20=20
> +    qmp_migrate_incoming(NULL, true, caps, &err);
> +    qapi_free_MigrationChannelList(caps);
>      hmp_handle_error(mon, err);
>  }
>=20=20
> @@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>      bool resume =3D qdict_get_try_bool(qdict, "resume", false);
>      const char *uri =3D qdict_get_str(qdict, "uri");
>      Error *err =3D NULL;
> +    MigrationChannelList *caps =3D NULL;
> +    g_autoptr(MigrationChannel) channel =3D g_new0(MigrationChannel, 1);

Same here. We free the channel via caps and we attribute it below, no
need to allocate.

>=20=20
> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
> +    migrate_uri_parse(uri, &channel, &err);
> +    QAPI_LIST_PREPEND(caps, channel);
> +
> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>                   false, false, true, resume, &err);
> +    qapi_free_MigrationChannelList(caps);
>      if (hmp_handle_error(mon, err)) {
>          return;
>      }
> diff --git a/migration/migration.c b/migration/migration.c
> index 3eae32e616..7d2d5ae329 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -431,9 +431,8 @@ void migrate_add_address(SocketAddress *address)
>                        QAPI_CLONE(SocketAddress, address));
>  }
>=20=20
> -static bool migrate_uri_parse(const char *uri,
> -                              MigrationChannel **channel,
> -                              Error **errp)
> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> +                       Error **errp)
>  {
>      g_autoptr(MigrationChannel) val =3D g_new0(MigrationChannel, 1);
>      g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);
> diff --git a/migration/migration.h b/migration/migration.h
> index 972597f4de..f9127707f5 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -511,7 +511,8 @@ bool check_dirty_bitmap_mig_alias_map(const BitmapMig=
rationNodeAliasList *bbm,
>                                        Error **errp);
>=20=20
>  void migrate_add_address(SocketAddress *address);
> -
> +bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> +                       Error **errp);
>  int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque);
>=20=20
>  #define qemu_ram_foreach_block \

