Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5019A7BE2D2
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:31:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprGE-0007g7-4p; Mon, 09 Oct 2023 10:29:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qprGC-0007fT-2J
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:29:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qprGA-0001ZR-6Q
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:29:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D34EE21880;
 Mon,  9 Oct 2023 14:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696861763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASGhNxJMg8WY+XbWP+itvDjTCgMcz43wokWZnl+TPT8=;
 b=F0y3+q3fHxDTm9WejegMNQJyxjUatsFIAGQOUoRwIb+uZk69TbL5Oxg5kSh4OBxfE6QaVv
 kWsVQOCii85HkA1tM8r1gvZLjs/a+rYrlDXe64XmeOoTLDEADW+Q8rbO0UXlHcXYt1CloZ
 k5TeVIzjnLVkv3187n5qoYRzgit8iDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696861763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ASGhNxJMg8WY+XbWP+itvDjTCgMcz43wokWZnl+TPT8=;
 b=KjlpUgAfbYSQvbZauiwqJxW9/dehZeXFJqou6X1OAOuJxBV5UpsFOcqmFbLz2vZtLQYvr5
 YxfbFNEgRkW534AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 62B9F13905;
 Mon,  9 Oct 2023 14:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h26YC0MOJGXODwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 14:29:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 08/10] migration: Implement MigrateChannelList to
 qmp migration flow.
In-Reply-To: <1fa0fa5d-0989-43df-8f58-881b859f3f09@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-9-het.gala@nutanix.com> <87ediapg58.fsf@suse.de>
 <1fa0fa5d-0989-43df-8f58-881b859f3f09@nutanix.com>
Date: Mon, 09 Oct 2023 11:29:21 -0300
Message-ID: <877cnvg98e.fsf@suse.de>
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

> On 10/4/2023 8:51 PM, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> Integrate MigrateChannelList with all transport backends
>>> (socket, exec and rdma) for both src and dest migration
>>> endpoints for qmp migration.
>>>
>>> For current series, limit the size of MigrateChannelList
>>> to single element (single interface) as runtime check.
>>>
>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9<berrange@redhat.com>
>>> ---
>>>   migration/migration.c | 95 +++++++++++++++++++++++--------------------
>>>   1 file changed, 52 insertions(+), 43 deletions(-)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 6f948988ec..3eae32e616 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -432,9 +432,10 @@ void migrate_add_address(SocketAddress *address)
>>>   }
>>>=20=20=20
>>>   static bool migrate_uri_parse(const char *uri,
>>> -                              MigrationAddress **channel,
>>> +                              MigrationChannel **channel,
>>>                                 Error **errp)
>>>   {
>>> +    g_autoptr(MigrationChannel) val =3D g_new0(MigrationChannel, 1);
>> Here val is passed out of scope so it shouldn't be g_autoptr.
> I guess, same as for 'addr' we need to go with adding=20
> g_steal_pointer(&val) here too ?

Yes, you cannot give the same pointer to *channel because this one is
already being tracked by g_autoptr and it will free the memory when it
gets the chance. So we need to steal it from g_autoptr, so to speak.

>>>       g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);
>>>       SocketAddress *saddr =3D &addr->u.socket;
>>>       InetSocketAddress *isock =3D &addr->u.rdma;
>>> @@ -471,7 +472,9 @@ static bool migrate_uri_parse(const char *uri,
>>>           return false;
>>>       }
>>>=20=20=20
>>> -    *channel =3D addr;
>>> +    val->channel_type =3D MIGRATION_CHANNEL_TYPE_MAIN;
>>> +    val->addr =3D addr;
>>> +    *channel =3D val;
>>>       return true;
>>>   }
>>>=20=20=20
>>> @@ -479,41 +482,44 @@ static void qemu_start_incoming_migration(const c=
har *uri, bool has_channels,
>>>                                             MigrationChannelList *chann=
els,
>>>                                             Error **errp)
>>>   {
>>> -    g_autoptr(MigrationAddress) channel =3D g_new0(MigrationAddress, 1=
);
>>> +    g_autoptr(MigrationChannel) channel =3D g_new0(MigrationChannel, 1=
);
>>> +    g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);
>> Here we want just the pointer, no allocation, no freeing. For both
>> channel and addr.
> Ack, same as channel in patch 2.

This is actually one of the cases where we need to think about how we
are going to free that memory. You need to make sure no one is using the
'addr' after you call into the *_incoming_migration functions. All users
should either use the value and return or make a copy if they intend to
pass it forward. If you determine that no one is using 'addr' and
'channel', then we could bring the channel g_autoptr back.

>>>=20=20=20
>>>       /*
>>>        * Having preliminary checks for uri and channel
>>>        */
>>> -    if (has_channels) {
>>> -        error_setg(errp, "'channels' argument should not be set yet.");
>>> -        return;
>>> -    }
>>> -
>>>       if (uri && has_channels) {
>>>           error_setg(errp, "'uri' and 'channels' arguments are mutually=
 "
>>>                      "exclusive; exactly one of the two should be prese=
nt in "
>>>                      "'migrate-incoming' qmp command ");
>>>           return;
>>> -    }
>>> -
>>> -    if (!uri && !has_channels) {
>>> +    } else if (channels) {
>>> +        /* To verify that Migrate channel list has only item */
>>> +        if (channels->next) {
>>> +            error_setg(errp, "Channel list has more than one entries");
>>> +            return;
>>> +        }
>>> +        channel =3D channels->value;
>>> +    } else if (uri) {
>>> +        /* caller uses the old URI syntax */
>>> +        if (!migrate_uri_parse(uri, &channel, errp)) {
>>> +            return;
>>> +        }
>>> +    } else {
>>>           error_setg(errp, "neither 'uri' or 'channels' argument are "
>>>                      "specified in 'migrate-incoming' qmp command ");
>>>           return;
>>>       }
>>> -
>>> -    if (uri && !migrate_uri_parse(uri, &channel, errp)) {
>>> -        return;
>>> -    }
>>> +    addr =3D channel->addr;
>>>=20=20=20
>>>       /* transport mechanism not suitable for migration? */
>>> -    if (!migration_channels_and_transport_compatible(channel, errp)) {
>>> +    if (!migration_channels_and_transport_compatible(addr, errp)) {
>>>           return;
>>>       }
>>>=20=20=20
>>>       qapi_event_send_migration(MIGRATION_STATUS_SETUP);
>>> -    if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_SOCKET) {
>>> -        SocketAddress *saddr =3D &channel->u.socket;
>>> +    if (addr->transport =3D=3D MIGRATION_ADDRESS_TYPE_SOCKET) {
>>> +        SocketAddress *saddr =3D &addr->u.socket;
>>>           if (saddr->type =3D=3D SOCKET_ADDRESS_TYPE_INET ||
>>>               saddr->type =3D=3D SOCKET_ADDRESS_TYPE_UNIX ||
>>>               saddr->type =3D=3D SOCKET_ADDRESS_TYPE_VSOCK) {
>>> @@ -522,11 +528,11 @@ static void qemu_start_incoming_migration(const c=
har *uri, bool has_channels,
>>>               fd_start_incoming_migration(saddr->u.fd.str, errp);
>>>           }
>>>   #ifdef CONFIG_RDMA
>>> -    } else if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_RDMA) {
>>> -        rdma_start_incoming_migration(&channel->u.rdma, errp);
>>> -#endif
>>> -    } else if (channel->transport =3D=3D MIGRATION_ADDRESS_TYPE_EXEC) {
>>> -        exec_start_incoming_migration(channel->u.exec.args, errp);
>>> +    } else if (addr->transport =3D=3D MIGRATION_ADDRESS_TYPE_RDMA) {
>>> +        rdma_start_incoming_migration(&addr->u.rdma, errp);
>>> + #endif
>>> +    } else if (addr->transport =3D=3D MIGRATION_ADDRESS_TYPE_EXEC) {
>>> +        exec_start_incoming_migration(addr->u.exec.args, errp);
>>>       } else {
>>>           error_setg(errp, "unknown migration protocol: %s", uri);
>>>       }
>>> @@ -1750,35 +1756,38 @@ void qmp_migrate(const char *uri, bool has_chan=
nels,
>>>       bool resume_requested;
>>>       Error *local_err =3D NULL;
>>>       MigrationState *s =3D migrate_get_current();
>>> -    g_autoptr(MigrationAddress) channel =3D g_new0(MigrationAddress, 1=
);
>>> +    g_autoptr(MigrationChannel) channel =3D g_new0(MigrationChannel, 1=
);
>>> +    g_autoptr(MigrationAddress) addr =3D g_new0(MigrationAddress, 1);
>> Again just the pointers.
>>
>> We'll have to make another pass and check whether we're missing freeing
>> something. But for now let's first clear all the errors then we can look
>> at the code working and do the necessary changes.
> Ack.
>>>=20=20=20
>>>       /*
>>>        * Having preliminary checks for uri and channel
>>>        */
>>> -    if (has_channels) {
>>> -        error_setg(errp, "'channels' argument should not be set yet.");
>>> -        return;
>>> -    }
>>>=20=20=20=20
> Regards,
> Het Gala

