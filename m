Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 964D17BE23C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpr11-00029U-W4; Mon, 09 Oct 2023 10:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpr0z-00029J-RI
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:13:45 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpr0x-00078j-SK
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:13:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8EA91F390;
 Mon,  9 Oct 2023 14:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696860818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmqkR7zzRLJDQUUsc/nHiJJJuI3byOQb8Sn3/uNQfhM=;
 b=RYQOMqqAfLzKrxEs9d6q35/khTSzaKZUpO+cFpPxqtDEC146dz38OpljtI/Sc96PxdMltj
 qpseDlIV5vJRlD8zMz5ggjZb8jUmHkMHtsF4qcmLY1gX/SIgZneVNPrPpfHZ9aREbHHfWC
 O47SE3epHMEHCiXQi/U1PSH6v6aVS9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696860818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmqkR7zzRLJDQUUsc/nHiJJJuI3byOQb8Sn3/uNQfhM=;
 b=VysIp0I1AdMhyMO0+oQj0DnlgAvG6dnVvxb7oCqSY2oda+hEmKcD0g88hwjBfPqCGarq/r
 W6kH+4oFzcs3zmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5B56C13905;
 Mon,  9 Oct 2023 14:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 95LnCZIKJGW/BgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 14:13:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 02/10] migration: convert migration 'uri' into
 'MigrateAddress'
In-Reply-To: <b9a9b3ff-80ff-4b23-bbd8-996afe40e7d7@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-3-het.gala@nutanix.com> <87jzs2phxb.fsf@suse.de>
 <ZR2nuqQ7s1D5BweM@redhat.com> <87h6n65kac.fsf@suse.de>
 <b9a9b3ff-80ff-4b23-bbd8-996afe40e7d7@nutanix.com>
Date: Mon, 09 Oct 2023 11:13:35 -0300
Message-ID: <87a5srg9yo.fsf@suse.de>
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

> On 10/4/2023 11:42 PM, Fabiano Rosas wrote:
>> Daniel P. Berrang=C3=A9<berrange@redhat.com>  writes:
>>
>>> On Wed, Oct 04, 2023 at 11:43:12AM -0300, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>
>>>>> This patch parses 'migrate' and 'migrate-incoming' QAPI's 'uri'
>>>>> string containing migration connection related information
>>>>> and stores them inside well defined 'MigrateAddress' struct.
>>>>>
>>>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>>>> Reviewed-by: Daniel P. Berrang=C3=A9<berrange@redhat.com>
>>>>> ---
>>>>>   migration/exec.c      |  1 -
>>>>>   migration/exec.h      |  4 ++++
>>>>>   migration/migration.c | 55 ++++++++++++++++++++++++++++++++++++++++=
+++
>>>>>   3 files changed, 59 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/migration/exec.c b/migration/exec.c
>>>>> index 2bf882bbe1..32f5143dfd 100644
>>>>> --- a/migration/exec.c
>>>>> +++ b/migration/exec.c
>>>>> @@ -27,7 +27,6 @@
>>>>>   #include "qemu/cutils.h"
>>>>>=20=20=20
>>>>>   #ifdef WIN32
>>>>> -const char *exec_get_cmd_path(void);
>>>>>   const char *exec_get_cmd_path(void)
>>>>>   {
>>>>>       g_autofree char *detected_path =3D g_new(char, MAX_PATH);
>>>>> diff --git a/migration/exec.h b/migration/exec.h
>>>>> index b210ffde7a..736cd71028 100644
>>>>> --- a/migration/exec.h
>>>>> +++ b/migration/exec.h
>>>>> @@ -19,6 +19,10 @@
>>>>>=20=20=20
>>>>>   #ifndef QEMU_MIGRATION_EXEC_H
>>>>>   #define QEMU_MIGRATION_EXEC_H
>>>>> +
>>>>> +#ifdef WIN32
>>>>> +const char *exec_get_cmd_path(void);
>>>>> +#endif
>>>>>   void exec_start_incoming_migration(const char *host_port, Error **e=
rrp);
>>>>>=20=20=20
>>>>>   void exec_start_outgoing_migration(MigrationState *s, const char *h=
ost_port,
>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>> index 6d3cf5d5cd..dcbd509d56 100644
>>>>> --- a/migration/migration.c
>>>>> +++ b/migration/migration.c
>>>>> @@ -65,6 +65,7 @@
>>>>>   #include "sysemu/qtest.h"
>>>>>   #include "options.h"
>>>>>   #include "sysemu/dirtylimit.h"
>>>>> +#include "qemu/sockets.h"
>>>>>=20=20=20
>>>>>   static NotifierList migration_state_notifiers =3D
>>>>>       NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
>>>>> @@ -427,15 +428,64 @@ void migrate_add_address(SocketAddress *address)
>>>>>                         QAPI_CLONE(SocketAddress, address));
>>>>>   }
>>>>>=20=20=20
>>>>> +static bool migrate_uri_parse(const char *uri,
>>>>> +                              MigrationAddress **channel,
>>>>> +                              Error **errp)
>>>>> +{
>>>>> +    g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);
>>>> This cannot be g_autoptr because you're passing it out of scope at the
>>>> end of the function.
>>> It is still good to use g_autoptr to deal with the error paths.
>>>
>>> On the success path though you need   g_steal_pointer(&addr) to
>>> prevent the autofree cleanup running.
>> Ah good point, this has been suggested in an earlier version already, I
>> forgot to mention. We should definitely use g_steal_pointer() whenever
>> the variable goes out of scope.
> Okay. I get the point that g_autoptr helps to deal with freeing of=20
> pointer in case error occurs inside the function.

Yes, but note g_autoptr will free the memory any time the variable goes
out of scope, i.e. any time we return from the function. Even when
there's no error and we actually want that memory to still be around for
the callers to use.

> But I am still trying to figure out why we need g_steal_pointer() ? If=20
> you could please explain once again.
> My understanding till now was that if we want to return 'addr' variable=20
> as return type, then we would want to make use of g_steal_pointer(&addr)=
=20
> so instead of addr, we pass a temp ptr refrencing to the same location=20
> as addr, and then assign addr =3D NULL. But we are already assigning the=
=20
> memory location where addr was refrencing to 'channel'. Let me know if I=
=20
> am missing something ?

So now 'channel' points to the memory you allocated at the start of the
function with g_new0. When the function returns, g_autoptr has no idea
that someone is still using that memory, so it will just free it.

Whenever you want a chunk of memory to be accessed across function calls
like that you need to steal the reference. After stealing, the pointer
that was registered with g_autoptr (in this case 'addr') now points to
nothing and the pointer that was returned/assigned is a different one
that isn't known by any cleanup functions.

Note that after g_steal_pointer, that memory now becomes responsibility
of whatever piece of code owns that pointer. In this case,
qemu_start_incoming_migration() and qmp_migrate(). Those two functions
will have to free the memory once they are done with it. Or do the
g_autoptr/g_steal_pointer trick once more.

> I think the syntax follows as the second example given here:=20
> https://docs.gtk.org/glib/func.steal_pointer.html ?

Yep, that's it.

