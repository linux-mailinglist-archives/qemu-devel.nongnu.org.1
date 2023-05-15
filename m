Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F0703083
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:49:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZTa-0005UN-CW; Mon, 15 May 2023 10:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyZTT-0005OK-If
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyZTR-0000Ic-Jo
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684162012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eYpI1k425YxQ9UcEiblzAPI8OJZf/BFrlHagvmmPOw=;
 b=b5i1xmoiGb5o+jeAemhjA9e6SayAVfFgxwHEZWKreZP4qlPYfzTte6c8SNOOvVSnpZVCxR
 TmAJwGlqj1C/qjNcQvkcFJMKaODulVnBdYAyjT4T5z7N8e04ETINSrXjAW7eizyL9Ekq9c
 lcAx/oiZRz9nMOm/79TH4uCWL84cjKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-FjW90b5dO6Gg1DLXpp_-ig-1; Mon, 15 May 2023 10:46:50 -0400
X-MC-Unique: FjW90b5dO6Gg1DLXpp_-ig-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3078df8ae31so6001485f8f.0
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 07:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684162009; x=1686754009;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8eYpI1k425YxQ9UcEiblzAPI8OJZf/BFrlHagvmmPOw=;
 b=VVPSyJW2SiuSDrLudMsKadfBygfTY2jn+F3XWPHG7Wpmy7mvWJXK5GPl5qWyxiyRoQ
 +VRVeOxU5ApIz6cZJI3XuZEHJ1WyLwKD3TClUghLYiUbV56CWEl7FTXXMuztHviOoEAv
 1SDadnCywIB2WFBynPeCiBTU0rKtZjBh9fDE9TDC6n+mw0sIjKqiMra7Qgngibhh/5Vy
 bODZNYvEO4CXyNmGIJxp17xgCRmVtNInDGDGYy9UIZJKqurH8ErWUk5cwgbfODKGqqYD
 oSACJLINvofU8hSMHOzj2bRfPyfz5qFLkAxNSuWRlKlj5zjw5sV6WESiqhNoBwaS3arv
 q9Lg==
X-Gm-Message-State: AC+VfDwdyxTMsyaS/uBu6uJLxJCSB0dLf8dPPZrvgHCFXWkqcEurMJXK
 Cr2uhixkwOfiezBhBo406luCqbb84/g7g+WAEcHbdMpLWVrInhMigSyOEnMjFVSxyj0iKY3xWJg
 bhvQh+gnSNiIjnsA=
X-Received: by 2002:adf:e547:0:b0:2e4:bfa0:8c30 with SMTP id
 z7-20020adfe547000000b002e4bfa08c30mr25566316wrm.47.1684162009488; 
 Mon, 15 May 2023 07:46:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gACjbOfd6ff2/ByGOqZzSJzUkHDdzoeVgttoPzt76v0jjCAouZFEZ87LZz6HbF/MNSA63dA==
X-Received: by 2002:adf:e547:0:b0:2e4:bfa0:8c30 with SMTP id
 z7-20020adfe547000000b002e4bfa08c30mr25566296wrm.47.1684162009155; 
 Mon, 15 May 2023 07:46:49 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 b12-20020adfee8c000000b00304832cd960sm22120wro.10.2023.05.15.07.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 07:46:48 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 prerna.saxena@nutanix.com,  dgilbert@redhat.com,  pbonzini@redhat.com,
 armbru@redhat.com,  eblake@redhat.com,  manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v4 3/8] migration: converts socket backend to accept
 MigrateAddress struct
In-Reply-To: <71658ac2-6aa9-cde3-0eb9-82dae3c7ed0b@nutanix.com> (Het Gala's
 message of "Mon, 15 May 2023 19:52:54 +0530")
References: <20230512143240.192504-1-het.gala@nutanix.com>
 <20230512143240.192504-4-het.gala@nutanix.com>
 <ZGIGxf5WaHwasY1p@redhat.com>
 <71658ac2-6aa9-cde3-0eb9-82dae3c7ed0b@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 15 May 2023 16:46:47 +0200
Message-ID: <87wn19y7mw.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> On 15/05/23 3:47 pm, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, May 12, 2023 at 02:32:35PM +0000, Het Gala wrote:
>>> Socket transport backend for 'migrate'/'migrate-incoming' QAPIs accept
>>> new wire protocol of MigrateAddress struct.
>>>
>>> It is achived by parsing 'uri' string and storing migration parameters
>>> required for socket connection into well defined SocketAddress struct.
>>>
>>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>>> ---
>>>   migration/exec.c      |  4 ++--
>>>   migration/exec.h      |  4 ++++
>>>   migration/migration.c | 44 +++++++++++++++++++++++++++++++------------
>>>   migration/socket.c    | 34 +++++----------------------------
>>>   migration/socket.h    |  7 ++++---
>>>   5 files changed, 47 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/migration/exec.c b/migration/exec.c
>>> index 2bf882bbe1..c4a3293246 100644
>>> --- a/migration/exec.c
>>> +++ b/migration/exec.c
>>> @@ -27,7 +27,6 @@
>>>   #include "qemu/cutils.h"
>>>     #ifdef WIN32
>>> -const char *exec_get_cmd_path(void);
>>>   const char *exec_get_cmd_path(void)
> Even this, I will shift it to the 2nd patch, where I need to move
> exec_get_cmd_path() out accross other file (migration.c).

great.

>>>   {
>>>       g_autofree char *detected_path =3D g_new(char, MAX_PATH);
>>> @@ -40,7 +39,8 @@ const char *exec_get_cmd_path(void)
>>>   }
>>>   #endif
>>>   -void exec_start_outgoing_migration(MigrationState *s, const char
>>> *command, Error **errp)
>>> +void exec_start_outgoing_migration(MigrationState *s, const char *comm=
and,
>>> +                                   Error **errp)
>>>   {
>>>       QIOChannel *ioc;
> Sure, Juan. Will change this in the 2nd patch itself instead of
> here. I am not very convinved why should we have a different patch all
> together for this, because we are just using this code outside this
> file in my opinion? But if you still think so, I can make a different
> patch for that.

It is up to you.


> Juan, I get your point. But I think, we won't be needing local_err at
> all, if I use g_autoptr for 'channel' and 'saddr' is a part of
> 'channel'. Let me have a v2 patchset and if it is still not
> convinving, we can have a discussion on this.
>> THis leaks 'channel', and free's 'saddr' which actually  belongs
>> to channel.
>>
>> With my comments on the previous patch suggesting g_autoptr for
>> 'channel', we don't need any free calls for 'saddr' or 'channel'.
>
> Right. With g_autoptr used for freeing 'channel' in last patch, we
> wont have to worry about freeing 'saddr' at all. Thanks Daniel
>
> if (local_err) {
> =C2=A0=C2=A0=C2=A0 qapi_free_SocketAddress(saddr);
> =C2=A0=C2=A0=C2=A0 error_propagate(errp, local_err);
> =C2=A0=C2=A0=C2=A0 return;
> }
> And after changing the position for assigning 'saddr' and using
> g_autoptr for 'channel' I believe we can get rid of 'local_error'
> variable too and replace it with 'errp'. Please suggest if I am
> missing something here. TIA!

great.  That is much better.

>>>   -void socket_start_outgoing_migration(MigrationState *s,
>>> -                                     const char *str,
>>> -                                     Error **errp)
>>> -{
>>> -    Error *err =3D NULL;
>>> -    SocketAddress *saddr =3D socket_parse(str, &err);
>>> -    if (!err) {
>>> -        socket_start_outgoing_migration_internal(s, saddr, &err);
>>> -    }
>>> -    error_propagate(errp, err);
>>> -}
>>> -
> Actually Juan. I don't need this function at all, because parsing of
> uri into socketAddress using socket_parse is already done. So there is
> no use of having this function in the first place, so I decided to
> delete this fucntion all together. Same with incoming function.

What I mean is that this code was already there.  And it was doing it
wrong.  The parts that I corrected you were using this pattern, chcking
that err was NULL, intsead of cheking that saddr is NULL.

Later, Juan.


