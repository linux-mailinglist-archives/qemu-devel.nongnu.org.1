Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD6706300
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 10:35:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzCc2-0004w2-Eu; Wed, 17 May 2023 04:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzCbz-0004vt-Nk
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:34:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzCby-0006yg-1N
 for qemu-devel@nongnu.org; Wed, 17 May 2023 04:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684312456;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFaY0aJi9erMMDaXqVS4yjUVyANN3a+wojgKLQrzJa8=;
 b=Wp0Ti95cXsKkgA6KHKjidFxt0cthaP3iPQRjvSahNP+Dj1J/TvZrh+yfEhEFBgYvwgR10h
 4f0nAHGIw3ucoQw3izgJtv387oy+l+5Oy4CsTvOSCxfRbhjn+10NgSy8N7YXRqHS2TF71Y
 xyFW7U76je4hsm7+3xVqiY8j6mRL970=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-Sx4WzLnmPnq4qQg29QGArA-1; Wed, 17 May 2023 04:34:14 -0400
X-MC-Unique: Sx4WzLnmPnq4qQg29QGArA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41ce0a69fso1995015e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 01:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684312453; x=1686904453;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFaY0aJi9erMMDaXqVS4yjUVyANN3a+wojgKLQrzJa8=;
 b=D5gr5Tqqg//DnqQYpJ4S/NBkGyHrzyY8Gg45IacsYNeddQcdVzPFP9vr7hGW8H8SB5
 obSgr3STsDMYhYdXjpznKMuSlUUZqN8zRBmvE1DQkker69oqAM1r26Ce6d7tcbdB9sTR
 wtT6pHXXpZNG8fe253lBTEY17Fm8nYLHXqfp/h1f9w5/yKhlsuMkRlq1IoRMCMeu3DZl
 p2IKm/7WDcKZxINpITaJ4e6FLKJRZ1zzZgn3Xj9YvZJ2hd9baSLz6PL9lzWTwDq50W7Q
 SQM7mO/bvOmQfxpRjM9u8Yufm+dmf18rtujMrtyssPb1r0yJnQjl+9oldHF4iQuCJURJ
 disw==
X-Gm-Message-State: AC+VfDzqyo+qBXTC9TsIImJNTNDhIEsf9ZBsP4h2s/Ua2/DpJX8PJQXd
 QM9e1byxHL/IPLgEr61nbqvfm0J2jrk0VAZr+YQV5FP13CdCD6QcLexYY+5g2eNIwPzMfVdkCs3
 uzA9PZS3NfISTqMs=
X-Received: by 2002:a5d:4847:0:b0:309:3b8d:16af with SMTP id
 n7-20020a5d4847000000b003093b8d16afmr2097940wrs.49.1684312453337; 
 Wed, 17 May 2023 01:34:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7NKi42hdwEvIF0BMRwF21FRK6qAGjzA46eAqREk7GmIb7tHOTCJIdtAYWvoCUh6iaFUXkCQA==
X-Received: by 2002:a5d:4847:0:b0:309:3b8d:16af with SMTP id
 n7-20020a5d4847000000b003093b8d16afmr2097913wrs.49.1684312453019; 
 Wed, 17 May 2023 01:34:13 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 r18-20020adff712000000b003062d815fa6sm1874277wrp.85.2023.05.17.01.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 01:34:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com,  dgilbert@redhat.com,  pbonzini@redhat.com,
 armbru@redhat.com,  eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v4 8/8] migration: Introduced MigrateChannelList struct
 to migration code flow.
In-Reply-To: <06881487-aa29-ed63-53da-6f4323bd7cc6@nutanix.com> (Het Gala's
 message of "Tue, 16 May 2023 22:48:16 +0530")
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-9-het.gala@nutanix.com>
 <ZGIMk9wKg9h6pndM@redhat.com>
 <06881487-aa29-ed63-53da-6f4323bd7cc6@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 17 May 2023 10:34:11 +0200
Message-ID: <87ttwbfjb0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Het Gala <het.gala@nutanix.com> wrote:
> On 15/05/23 4:12 pm, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, May 12, 2023 at 02:32:40PM +0000, Het Gala wrote:
>>> Integrated MigrateChannelList with all transport backends (socket, exec
>>> and rdma) for both source and destination migration code flow.
>>>
>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>> ---
>>>   migration/migration.c | 95 +++++++++++++++++++++++++++----------------
>>>   migration/socket.c    |  5 ++-
>>>   2 files changed, 64 insertions(+), 36 deletions(-)
>>>
>>>       Error *local_err =3D NULL;
>>> +    MigrateChannel *val =3D g_new0(MigrateChannel, 1);
>>>       MigrateAddress *addrs =3D g_new0(MigrateAddress, 1);
>>>       SocketAddress *saddr;
>>>       InetSocketAddress *isock =3D &addrs->u.rdma;
>>> @@ -441,6 +442,7 @@ static bool migrate_uri_parse(const char *uri,
>>>       }
>>>         if (local_err) {
>>> +        qapi_free_MigrateChannel(val);
>>>           qapi_free_MigrateAddress(addrs);
>>>           qapi_free_SocketAddress(saddr);
>>>           qapi_free_InetSocketAddress(isock);
>>> @@ -448,7 +450,9 @@ static bool migrate_uri_parse(const char *uri,
>>>           return false;
>>>       }
>>>   -    *channel =3D addrs;
>>> +    val->channeltype =3D MIGRATE_CHANNEL_TYPE_MAIN;
>>> +    val->addr =3D addrs;
>>> +    *channel =3D val;
>>>       return true;
>>>   }
>>>   @@ -457,8 +461,9 @@ static void
>>> qemu_start_incoming_migration(const char *uri, bool has_channels,
>>>                                             Error **errp)
>>>   {
>>>       Error *local_err =3D NULL;
>>> -    MigrateAddress *channel =3D g_new0(MigrateAddress, 1);
>>> +    MigrateAddress *addrs;
>>>       SocketAddress *saddr;
>>> +    MigrateChannel *channel =3D NULL;
>>>         /*
>>>        * Having preliminary checks for uri and channel
>>> @@ -467,22 +472,30 @@ static void qemu_start_incoming_migration(const c=
har *uri, bool has_channels,
>>>           error_setg(errp, "'uri' and 'channels' arguments are mutually=
 "
>>>                      "exclusive; exactly one of the two should be prese=
nt in "
>>>                      "'migrate-incoming' qmp command ");
>>> -        return;
>>> -    }
>>> -
>>> -    /* URI is not suitable for migration? */
>>> -    if (!migration_channels_and_uri_compatible(uri, errp)) {
>>>           goto out;
>>> -    }
>>> +    } else if (channels) {
>>> +        /* To verify that Migrate channel list has only item */
>>> +        if (channels->next) {
>>> +            error_setg(errp, "Channel list has more than one entries");
>>> +            goto out;
>>> +        }
>>> +        channel =3D channels->value;
>>> +    } else {
>>> +        /* URI is not suitable for migration? */
>>> +        if (!migration_channels_and_uri_compatible(uri, errp)) {
>>> +            goto out;
>>> +        }
>> THis check only gets executed when the caller uses the old
>> URI syntax. We need to it be run when using the modern
>> MigrateChannel QAPI syntax too.
>>
>> IOW, migration_channels_and_uri_compatible() needs converting
>> to take a 'MigrateChannel' object instead of URI, and then
>> the check can be run after the URI -> MigrateCHannel conversion
>
> Yes, Daniel. Got your point. Will change it in the next version.
>
> For Juan's comments, I have not explored the test side code still, so
> is the idea to have some similar test functions like
> test_precopy_tcp_plain, test_precopy_unix_plain but with the new
> syntax ? Please confirm this, and any advice on how appraoch this?

There are several places that use this syntax:

    rsp =3D wait_command(to, "{ 'execute': 'migrate-incoming',"
                           "  'arguments': { 'uri': 'tcp:127.0.0.1:0' }}");

Just change a couple of them to the new syntax.

I guess you will want to do the multifd tests with the new syntax, not
sure if it makes sense to also test the old one.

I guess you will also want to check that your are catching errors (like
different number of channels on source/destination).

Later, Juan.


