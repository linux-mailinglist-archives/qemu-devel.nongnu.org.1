Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 781507F42D7
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:52:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jsn-0003Z5-8C; Wed, 22 Nov 2023 04:50:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5jsl-0003Yf-C1
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:50:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5jsj-0002dj-Gq
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:50:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700646652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gMWHhJZ5ykPCMvEXGSHNw3/4eLiWqFUrWU2KSXTbbH0=;
 b=hpnKt4anQ0FnT5JeqzUCHAOHCRm8Cs5IR0ct6Lki77M4GkiWlbR3i4e7BwR3HNh11/oCe8
 O6IqOx3Y0rC70uARQK42jw4S8HiWPJMHK12gNYW7fpOT66kstD0KrEY1jhXtC4E3hAFCTq
 qX/ZHNPQpuhKqfuyTLlzV1NXWG4iNDA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-lQOhl8rcOvGhyHW0QnL26A-1; Wed,
 22 Nov 2023 04:50:49 -0500
X-MC-Unique: lQOhl8rcOvGhyHW0QnL26A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B367429AA2C4;
 Wed, 22 Nov 2023 09:50:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 76E5D40C6EB9;
 Wed, 22 Nov 2023 09:50:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6FD3421E6A1F; Wed, 22 Nov 2023 10:50:47 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  qemu-devel <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Michael Roth
 <michael.roth@amd.com>
Subject: Re: [PATCH 05/19] qapi/schema: make c_type() and json_type()
 abstract methods
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-6-jsnow@redhat.com>
 <87jzqb4495.fsf@pond.sub.org> <ZVy0BAmoJ3ZcWg8q@redhat.com>
 <CAFn=p-b76n31iBw3JQ3ofQwWofBjAEF-bGXZpOVLMJms9akvxg@mail.gmail.com>
 <ZVzcMtRCQDkaGuJI@redhat.com>
Date: Wed, 22 Nov 2023 10:50:47 +0100
In-Reply-To: <ZVzcMtRCQDkaGuJI@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Tue, 21 Nov 2023 16:34:58 +0000")
Message-ID: <87il5uw1zc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Nov 21, 2023 at 11:28:17AM -0500, John Snow wrote:
>> On Tue, Nov 21, 2023, 8:43 AM Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om>
>> wrote:
>>=20
>> > On Tue, Nov 21, 2023 at 02:36:54PM +0100, Markus Armbruster wrote:
>> > > John Snow <jsnow@redhat.com> writes:
>> > >
>> > > > These methods should always return a str, it's only the default
>> > abstract
>> > > > implementation that doesn't. They can be marked "abstract" by rais=
ing
>> > > > NotImplementedError(), which requires subclasses to override the m=
ethod
>> > > > with the proper return type.
>> > > >
>> > > > Signed-off-by: John Snow <jsnow@redhat.com>
>> > > > ---
>> > > >  scripts/qapi/schema.py | 8 ++++----
>> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
>> > > >
>> > > > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > > > index c5fdd625452..4600a566005 100644
>> > > > --- a/scripts/qapi/schema.py
>> > > > +++ b/scripts/qapi/schema.py
>> > > > @@ -233,8 +233,8 @@ def visit(self, visitor):
>> > > >  class QAPISchemaType(QAPISchemaEntity):
>> > > >      # Return the C type for common use.
>> > > >      # For the types we commonly box, this is a pointer type.
>> > > > -    def c_type(self):
>> > > > -        pass
>> > > > +    def c_type(self) -> str:
>> > > > +        raise NotImplementedError()
>> > > >
>> > > >      # Return the C type to be used in a parameter list.
>> > > >      def c_param_type(self):
>> > > > @@ -244,8 +244,8 @@ def c_param_type(self):
>> > > >      def c_unboxed_type(self):
>> > > >          return self.c_type()
>> > > >
>> > > > -    def json_type(self):
>> > > > -        pass
>> > > > +    def json_type(self) -> str:
>> > > > +        raise NotImplementedError()
>> > > >
>> > > >      def alternate_qtype(self):
>> > > >          json2qtype =3D {
>> > >
>> > > I wish abstract methods could be done in a more concise way.
>> >
>> > The canonical way would be to use the 'abc' module:
>> >
>> >   from abc import ABCMeta, abstractmethod
>> >
>> >   class A(metaclass=3DABCMeta):
>> >       @abstractmethod
>> >       def foo(self): pass
>> >
>> > Not sure if the @abstractmethod decorator is enough to keep the static
>> > typing checker happy about a 'str' return type, when there is no body
>> > impl
>>=20
>> In practice, I'm under the belief that mypy and pylint both recognize a
>> method raising NotImplementedError as marking an abstract method without
>> needing to explicitly inherit from the ABC.
>>=20
>> I suppose there's also
>> https://docs.python.org/3/library/abc.html#abc.abstractmethod which I am
>> guessing just does this same thing. I'll see what makes mypy happy. I'm
>> assuming Markus would like to see something like this decorator to make =
it
>> more obvious that it's an abstract method.
>
> The 'abc' module described is an official PEP standard
>
>   https://peps.python.org/pep-3119/

Compare:

    @abstractmethod
    def c_type(self) -> str:
        pass

    def c_type(self) -> str:
        raise NotImplementedError()

I prefer the former, because it's more explicit.

Bonus: prevents accidental instantiation, and sub-classes don't need to
know what's abstract in the super-class, they can blindly use super()
calls.  docs.python.org:

    Using this decorator requires that the class=E2=80=99s metaclass is ABC=
Meta
    or is derived from it.  A class that has a metaclass derived from
    ABCMeta cannot be instantiated unless all of its abstract methods
    and properties are overridden.  The abstract methods can be called
    using any of the normal =E2=80=98super=E2=80=99 call mechanisms.  abstr=
actmethod()
    may be used to declare abstract methods for properties and
    descriptors.

Hardly matters here, but since it's free...


