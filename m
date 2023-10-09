Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D47BE2FE
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qprMM-0002VY-6G; Mon, 09 Oct 2023 10:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qprMK-0002V3-0T
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:35:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qprMH-0002wh-1C
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:35:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0D9691F749;
 Mon,  9 Oct 2023 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696862143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p0dtw74uc6ZQlX09AqXvsQ7K/LJiKq8aNNswdIY4Nw=;
 b=zpl1J1jyyI1YuBVP125MVcOCSn31zjst/57r6qdoegZXSiaasXXvl9z3wi8qVAD1EhsVuf
 MJnPfTYHK7CrQr97jSIjhu4w9daD5k39XuUx0pDppIhY2n1Kyo4uca7UNj5k34AsPQ6jdG
 kZgrdmCssC0Lj2WGi4sjCuFQE2z5WcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696862143;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1p0dtw74uc6ZQlX09AqXvsQ7K/LJiKq8aNNswdIY4Nw=;
 b=ZYFfxVPoTdc5/Imyvp1PvM8Zire7Vui6v6XOINiIRMgYTEKvGS/AgeuQAbtKsSm8hvrg3J
 qWogXuro2Gb01rDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9320613905;
 Mon,  9 Oct 2023 14:35:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZC07F74PJGVZEwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 14:35:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v11 09/10] migration: Implement MigrateChannelList to
 hmp migration flow.
In-Reply-To: <f41198b2-bf86-4ef4-9bab-6c834b011ae7@nutanix.com>
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-10-het.gala@nutanix.com> <87bkdepfyk.fsf@suse.de>
 <f41198b2-bf86-4ef4-9bab-6c834b011ae7@nutanix.com>
Date: Mon, 09 Oct 2023 11:35:40 -0300
Message-ID: <874jizg8xv.fsf@suse.de>
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

Het Gala <het.gala@nutanix.com> writes:

> On 10/4/2023 8:55 PM, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> Integrate MigrateChannelList with all transport backends
>>> (socket, exec and rdma) for both src and dest migration
>>> endpoints for hmp migration.
>>>
>>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Reviewed-by: Daniel P. Berrang=C3=A9<berrange@redhat.com>
>>> ---
>>>   migration/migration-hmp-cmds.c | 15 +++++++++++++--
>>>   migration/migration.c          |  5 ++---
>>>   migration/migration.h          |  3 ++-
>>>   3 files changed, 17 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-c=
mds.c
>>> index a2e6a5c51e..a1657f3d37 100644
>>> --- a/migration/migration-hmp-cmds.c
>>> +++ b/migration/migration-hmp-cmds.c
>>> @@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDic=
t *qdict)
>>>   {
>>>       Error *err =3D NULL;
>>>       const char *uri =3D qdict_get_str(qdict, "uri");
>>> +    MigrationChannelList *caps =3D NULL;
>>> +    g_autoptr(MigrationChannel) channel =3D g_new0(MigrationChannel, 1=
);
>> Just the pointer here. If I remember correctly the g_autoptr here would
>> cause a double free when freeing the caps.
>
> Yes, we'll just have 'g_autoptr(MigrationChannel) channel =3D NULL'.
>
> Is it because inside QAPI_LIST_PREPEND, caps will be refrencing to the=20
> same memory as 'channel', we don't need to free channel ?

Slightly different scenario here. Here the issue is that we will free
the caps with qapi_free_MigrationChannel() before returning. Then, at
function exit the g_autoptr will try to free 'channel', which has
already been freed along with 'caps'. That's a double free, I think it
hits an assert inside glib, if I remember correctly.

> I am still not=20
> sure what is the right place to use g_steal_pointer(), is this a right=20
> place to use (non-error paths) ?

It doesn't look like we need it here. As long as the qapi list has a
reference and we're freeing the caps, then channel should be freed by
that function already.

>>>=20=20=20
>>> -    qmp_migrate_incoming(uri, false, NULL, &err);
>>> +    migrate_uri_parse(uri, &channel, &err);
>>> +    QAPI_LIST_PREPEND(caps, channel);
>>>=20=20=20
>>> +    qmp_migrate_incoming(NULL, true, caps, &err);
>>> +    qapi_free_MigrationChannelList(caps);
>>>       hmp_handle_error(mon, err);
>>>   }
>>>=20=20=20
>>> @@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>>       bool resume =3D qdict_get_try_bool(qdict, "resume", false);
>>>       const char *uri =3D qdict_get_str(qdict, "uri");
>>>       Error *err =3D NULL;
>>> +    MigrationChannelList *caps =3D NULL;
>>> +    g_autoptr(MigrationChannel) channel =3D g_new0(MigrationChannel, 1=
);
>> Same here. We free the channel via caps and we attribute it below, no
>> need to allocate.
> Ack.
>>>=20=20=20
>>> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>>> +    migrate_uri_parse(uri, &channel, &err);
>>> +    QAPI_LIST_PREPEND(caps, channel);
>>> +
>>> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>>>                    false, false, true, resume, &err);
>>> +    qapi_free_MigrationChannelList(caps);
>>>       if (hmp_handle_error(mon, err)) {
> Regards,
> Het Gala

