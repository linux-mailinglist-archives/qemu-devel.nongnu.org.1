Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BD97B8825
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 20:13:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo6MQ-0003Gh-4q; Wed, 04 Oct 2023 14:12:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo6ML-0003Du-Ao
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:12:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo6MJ-0007Sk-M9
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 14:12:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1F1341F460;
 Wed,  4 Oct 2023 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696443150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13YR344gzaY6V0Kz7wIUpu7FJ+r0opgDhEHFcseJ8z0=;
 b=dYf5usBzRTHhep9Jdb3gkUkRdGesXEdZ1kSuY8xEW7tHizr1HhohuQZerKvEGbErkISjvM
 CtGoaqwTtpCsnpBn41mHiQFwlrOCMqasXK5/vw5OdJzmrdRr6YPGzCZtbhLH0mT/g5mVN8
 AI+Vmz23KHpaFz9AYwsiQNQ5jmbrQ3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696443150;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13YR344gzaY6V0Kz7wIUpu7FJ+r0opgDhEHFcseJ8z0=;
 b=+O98SZJMImIrn09Hs+N1mtTKBGGf/HPZDUJ39v6tHgkdU1/054JIFbnoSuhqVcjQ0I3YB/
 QXLFKUTdv6jQ5wCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6831139F9;
 Wed,  4 Oct 2023 18:12:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RkBsHA2rHWW6bAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 18:12:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 manish.mishra@nutanix.com, aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
In-Reply-To: <ZR2nuqQ7s1D5BweM@redhat.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com> <87jzs2phxb.fsf@suse.de>
 <ZR2nuqQ7s1D5BweM@redhat.com>
Date: Wed, 04 Oct 2023 15:12:27 -0300
Message-ID: <87h6n65kac.fsf@suse.de>
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

> On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
>> Het Gala <het.gala@nutanix.com> writes:
>>=20
>> > This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
>> > string containing migration connection related information
>> > and stores them inside well defined 'MigrateAddress' struct.
>> >
>> > Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> > Signed-off-by: Het Gala <het.gala@nutanix.com>
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  migration/exec.c      |  1 -
>> >  migration/exec.h      |  4 ++++
>> >  migration/migration.c | 55 +++++++++++++++++++++++++++++++++++++++++++
>> >  3 files changed, 59 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/migration/exec.c b/migration/exec.c
>> > index 2bf882bbe1..32f5143dfd 100644
>> > --- a/migration/exec.c
>> > +++ b/migration/exec.c
>> > @@ -27,7 +27,6 @@
>> >  #include "qemu/cutils.h"
>> >=20=20
>> >  #ifdef WIN32
>> > -const char *exec_get_cmd_path(void);
>> >  const char *exec_get_cmd_path(void)
>> >  {
>> >      g_autofree char *detected_path =3D g_new(char, MAX_PATH);
>> > diff --git a/migration/exec.h b/migration/exec.h
>> > index b210ffde7a..736cd71028 100644
>> > --- a/migration/exec.h
>> > +++ b/migration/exec.h
>> > @@ -19,6 +19,10 @@
>> >=20=20
>> >  #ifndef QEMU_MIGRATION_EXEC_H
>> >  #define QEMU_MIGRATION_EXEC_H
>> > +
>> > +#ifdef WIN32
>> > +const char *exec_get_cmd_path(void);
>> > +#endif
>> >  void exec_start_incoming_migration(const char *host_port, Error **err=
p);
>> >=20=20
>> >  void exec_start_outgoing_migration(MigrationState *s, const char *hos=
t_port,
>> > diff --git a/migration/migration.c b/migration/migration.c
>> > index 6d3cf5d5cd..dcbd509d56 100644
>> > --- a/migration/migration.c
>> > +++ b/migration/migration.c
>> > @@ -65,6 +65,7 @@
>> >  #include "sysemu/qtest.h"
>> >  #include "options.h"
>> >  #include "sysemu/dirtylimit.h"
>> > +#include "qemu/sockets.h"
>> >=20=20
>> >  static NotifierList migration_state_notifiers =3D
>> >      NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
>> > @@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
>> >                        QAPI_CLONE(SocketAddress, address));
>> >  }
>> >=20=20
>> > +static bool migrate_uri_parse(const char *uri,
>> > +                              MigrationAddress **channel,
>> > +                              Error **errp)
>> > +{
>> > +    g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);
>>=20
>> This cannot be g_autoptr because you're passing it out of scope at the
>> end of the function.
>
> It is still good to use g_autoptr to deal with the error paths.
>
> On the success path though you need   g_steal_pointer(&addr) to
> prevent the autofree cleanup running.

Ah good point, this has been suggested in an earlier version already, I
forgot to mention. We should definitely use g_steal_pointer() whenever
the variable goes out of scope.

