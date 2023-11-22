Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0947F4576
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:11:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5m3O-0005S9-O1; Wed, 22 Nov 2023 07:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5m3J-0005R8-MG
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5m3I-0005K3-3p
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700654995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0IODFiSBONxbwIcD8qaIucLftU2TzIMC/Bzpwa35gs=;
 b=NMX6rCK1QxzDYcnlFlptH5Z97BpOHyM2dcClTr2j3F/47OPprsi9+b8MjpfdPYdarInIZm
 n+JrR6IoyNRK9ARsVKdyFXgPdmel9CzpVzv4g9jzJlBqGyUX2l21U+8A6ZnyPjNa8nSt7G
 YTSwWzBuBB3C266/fgkynMEor28j5HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-BWijoahwOqOEcl5iZnVhtg-1; Wed, 22 Nov 2023 07:09:51 -0500
X-MC-Unique: BWijoahwOqOEcl5iZnVhtg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FD03811E7D;
 Wed, 22 Nov 2023 12:09:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F2E5492BFA;
 Wed, 22 Nov 2023 12:09:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CD9121E6A1F; Wed, 22 Nov 2023 13:09:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 08/19] qapi/schema: add static typing and assertions to
 lookup_type()
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-9-jsnow@redhat.com>
 <87jzqb2nmp.fsf@pond.sub.org>
 <CAFn=p-bHuJsMG=HOdw8kxGwgAFQpvUWeHHD0xXtOV3+ytQfJQw@mail.gmail.com>
Date: Wed, 22 Nov 2023 13:09:50 +0100
In-Reply-To: <CAFn=p-bHuJsMG=HOdw8kxGwgAFQpvUWeHHD0xXtOV3+ytQfJQw@mail.gmail.com>
 (John Snow's message of "Tue, 21 Nov 2023 11:46:37 -0500")
Message-ID: <874jheugz5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

John Snow <jsnow@redhat.com> writes:

> On Tue, Nov 21, 2023, 9:21 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > This function is a bit hard to type as-is; mypy needs some assertions to
>> > assist with the type narrowing.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/schema.py | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index a1094283828..3308f334872 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>> > @@ -968,8 +968,12 @@ def lookup_entity(self, name, typ=None):
>> >              return None
>> >          return ent
>> >
>> > -    def lookup_type(self, name):
>> > -        return self.lookup_entity(name, QAPISchemaType)
>> > +    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
>>
>> Any particular reason not to delay the type hints until PATCH 16?
>>
>
> I forget. In some cases I did things a little differently so that the type
> checking would pass for each patch in the series, which sometimes required
> some concessions.
>
> Is this one of those cases? Uh, I forget.
>
> If it isn't, its almost certainly the case that I just figured I'd type
> this one function in one place instead of splitting it apart into two
> patches.
>
> I can try to shift the typing later and see what happens if you prefer it
> that way.

Well, you structured the series as "minor code changes to prepare for
type hints", followed by "add type hints".  So that's what I expect.
When patches deviate from what I expect, I go "am I missing something?"

Adding type hints along the way could work, too.  But let's try to stick
to the plan, and add them all in PATCH 16.

>> > +        typ = self.lookup_entity(name, QAPISchemaType)
>> > +        if typ is None:
>> > +            return None
>> > +        assert isinstance(typ, QAPISchemaType)
>> > +        return typ
>>
>> Would
>>
>>            typ = self.lookup_entity(name, QAPISchemaType)
>>            assert isinstance(typ, Optional[QAPISchemaType])
>>            return typ
>>
>> work?
>>
>
> I don't *think* so, Optional isn't a runtime construct.

Let me try...

    $ python
    Python 3.11.5 (main, Aug 28 2023, 00:00:00) [GCC 12.3.1 20230508 (Red Hat 12.3.1-1)] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> from typing import Optional
    >>> x=None
    >>> isinstance(x, Optional[str])
    True
    >>> 

>                                                         We can combine it
> into "assert x is None or isinstance(x, foo)" though - I believe that's
> used elsewhere in the qapi generator.

>> >
>> >      def resolve_type(self, name, info, what):
>> >          typ = self.lookup_type(name)
>>
>>


