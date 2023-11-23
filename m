Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 424D57F5D36
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:05:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67VU-0006uW-AJ; Thu, 23 Nov 2023 06:04:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r67VS-0006u7-Vy
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r67VR-0003m1-6P
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:04:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700737463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXOeolurWxLNmBKz32ZfUnYjXpKtgFR03080oXE487c=;
 b=TK1iUcnH7RowP0uzNMHQAzgF0s0k1vKmSz+NztWaoODchwCoEN9IvRayJsgwufBUkL4Ktl
 cwIbrMf8NyVdonWKNEzhZvquM5Hv1D+Dw+ynKulTsAW2LSsqKnmzKLWd4KCYKSyjvoKOTY
 byUOwVbx3Dql4Jw5484MBb8NAfp/PPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-j4pcdJTBPlKWhBXN8ZnkZQ-1; Thu, 23 Nov 2023 06:04:21 -0500
X-MC-Unique: j4pcdJTBPlKWhBXN8ZnkZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67103811E7D;
 Thu, 23 Nov 2023 11:04:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F7121121306;
 Thu, 23 Nov 2023 11:04:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D16921E6A1F; Thu, 23 Nov 2023 12:04:20 +0100 (CET)
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
 <874jheugz5.fsf@pond.sub.org>
 <CAFn=p-axjksRWSA1G0iXLJFJOXx8Xbry3K6nowmQqVOkgg=r_g@mail.gmail.com>
Date: Thu, 23 Nov 2023 12:04:20 +0100
In-Reply-To: <CAFn=p-axjksRWSA1G0iXLJFJOXx8Xbry3K6nowmQqVOkgg=r_g@mail.gmail.com>
 (John Snow's message of "Wed, 22 Nov 2023 10:55:36 -0500")
Message-ID: <87edgg7mtn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Wed, Nov 22, 2023 at 7:09=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > On Tue, Nov 21, 2023, 9:21 AM Markus Armbruster <armbru@redhat.com> wr=
ote:
>> >
>> >> John Snow <jsnow@redhat.com> writes:
>> >>
>> >> > This function is a bit hard to type as-is; mypy needs some assertio=
ns to
>> >> > assist with the type narrowing.
>> >> >
>> >> > Signed-off-by: John Snow <jsnow@redhat.com>
>> >> > ---
>> >> >  scripts/qapi/schema.py | 8 ++++++--
>> >> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >> >
>> >> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> >> > index a1094283828..3308f334872 100644
>> >> > --- a/scripts/qapi/schema.py
>> >> > +++ b/scripts/qapi/schema.py
>> >> > @@ -968,8 +968,12 @@ def lookup_entity(self, name, typ=3DNone):
>> >> >              return None
>> >> >          return ent
>> >> >
>> >> > -    def lookup_type(self, name):
>> >> > -        return self.lookup_entity(name, QAPISchemaType)
>> >> > +    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:

[...]

>> >> > +        typ =3D self.lookup_entity(name, QAPISchemaType)
>> >> > +        if typ is None:
>> >> > +            return None
>> >> > +        assert isinstance(typ, QAPISchemaType)
>> >> > +        return typ
>> >>
>> >> Would
>> >>
>> >>            typ =3D self.lookup_entity(name, QAPISchemaType)
>> >>            assert isinstance(typ, Optional[QAPISchemaType])
>> >>            return typ
>> >>
>> >> work?
>> >>
>> >
>> > I don't *think* so, Optional isn't a runtime construct.
>>
>> Let me try...
>>
>>     $ python
>>     Python 3.11.5 (main, Aug 28 2023, 00:00:00) [GCC 12.3.1 20230508 (Re=
d Hat 12.3.1-1)] on linux
>>     Type "help", "copyright", "credits" or "license" for more informatio=
n.
>>     >>> from typing import Optional
>>     >>> x=3DNone
>>     >>> isinstance(x, Optional[str])
>>     True
>>     >>>
>
> Huh. I ... huh!
>
> Well, this apparently only works in Python 3.10!+
>
> TypeError: Subscripted generics cannot be used with class and instance ch=
ecks

We should be able to use it "soon" after 3.9 reaches EOL, approximately
October 2025.

*Sigh*

>>
>> >                                                         We can combine=
 it
>> > into "assert x is None or isinstance(x, foo)" though - I believe that's
>> > used elsewhere in the qapi generator.
>>
>> >> >
>> >> >      def resolve_type(self, name, info, what):
>> >> >          typ =3D self.lookup_type(name)
>> >>
>> >>
>>


