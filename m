Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B739B7DC906
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:07:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkhz-0005RG-6Y; Tue, 31 Oct 2023 05:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxkhw-0005LC-KX
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:06:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxkhv-0007xy-0Q
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 05:06:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698743202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tLFG3ctul/fwPAzgAHHYanagP70hz72z3RbShxU7kw4=;
 b=cIz6/BhzWNfaDTKsghH37fb2u0IJ/3Ji5h35MmYH2pf5np2nsPhrhyCqZww2xOzrBMi37b
 dykaCehDJib+rPN74xwiMb3wFfEWrr0hJz9PfuwLvY0cBs0o2xegRCw8ooqebL+UwSd7uP
 +ltqr0b0x0HsYm1ffimOEnfSx2vsphg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-6-dMqu2ANRO70_JmB37Hcg-1; Tue,
 31 Oct 2023 05:06:35 -0400
X-MC-Unique: 6-dMqu2ANRO70_JmB37Hcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 768F71C07828
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:06:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 561091121306
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:06:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56A8621E6A1F; Tue, 31 Oct 2023 10:06:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/5] dump: Fix g_array_unref(NULL) in dump-guest-memory
References: <20231030133712.2822276-1-armbru@redhat.com>
 <20231030133712.2822276-3-armbru@redhat.com>
 <CAMxuvaxy_mwut2rH0cAOaOgiRTTeBBBCKprTS4bmetHqb7C8Ww@mail.gmail.com>
 <87zfzzkvv5.fsf@pond.sub.org>
Date: Tue, 31 Oct 2023 10:06:34 +0100
In-Reply-To: <87zfzzkvv5.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 31 Oct 2023 10:02:38 +0100")
Message-ID: <87lebjkvol.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Hi
>>
>> On Mon, Oct 30, 2023 at 5:37=E2=80=AFPM Markus Armbruster <armbru@redhat=
.com> wrote:
>>>
>>> When dump_init()'s check for non-zero @length fails, dump_cleanup()
>>> passes null s->string_table_buf to g_array_unref(), which spews "GLib:
>>> g_array_unref: assertion 'array' failed" to stderr.
>>>
>>> Guard the g_array_unref().
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>>> ---
>>>  dump/dump.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/dump/dump.c b/dump/dump.c
>>> index a1fad17f9c..d8ea364af2 100644
>>> --- a/dump/dump.c
>>> +++ b/dump/dump.c
>>> @@ -100,7 +100,9 @@ static int dump_cleanup(DumpState *s)
>>>      memory_mapping_list_free(&s->list);
>>>      close(s->fd);
>>>      g_free(s->guest_note);
>>> -    g_array_unref(s->string_table_buf);
>>> +    if (s->string_table_buf) {
>>> +        g_array_unref(s->string_table_buf);
>>> +    }
>>
>> or:
>> g_clear_pointer(&s->string_table_buf, g_array_unref)
>
> Since dump_cleanup() doesn't clear any of the other members of @s, I'll
> stick to g_array_unref() for consistency and simplicity.

Wait!  You suggest *unconditional*

         g_clear_pointer(&s->string_table_buf, g_array_unref)=20=20=20=20=
=20=20=20=20=20

don't you?

Got a preference?

>>>      s->guest_note =3D NULL;
>>>      if (s->resume) {
>>>          if (s->detached) {
>>> --
>>> 2.41.0
>>>
>
> Thanks!


