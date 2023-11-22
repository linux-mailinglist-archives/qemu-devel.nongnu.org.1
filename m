Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EDA7F42E2
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:53:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5juj-0004Gc-Bn; Wed, 22 Nov 2023 04:52:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5juh-0004GE-Iz
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:52:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5juS-0002mK-DE
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700646759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F0ucRbXSa5x6qxzTnrkJbom7ZEHVQotMjDwj+9AbWfI=;
 b=AdVZXQu3AcKbuO3M8wrWL9FauKkOXiBVMDEUMRJ0+SMOKxHZMqI/QIETv9RLcXCqQ/MB0Y
 mnTspJEtjaehhZvUy2/p7EVpI82rZfdsvb8MR8EunwXrklSpfF9aR07zQdVt7iakYJF/tn
 dFJcIn+bVuZFqG4Rz7s8v0F1Wtfk8Xo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-z_qLgiQCNLGhAhJRgDrrRA-1; Wed, 22 Nov 2023 04:52:36 -0500
X-MC-Unique: z_qLgiQCNLGhAhJRgDrrRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA16784AEE0;
 Wed, 22 Nov 2023 09:52:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B97C5492BE0;
 Wed, 22 Nov 2023 09:52:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B71DF21E6A1F; Wed, 22 Nov 2023 10:52:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 07/19] qapi/introspect: assert schema.lookup_type did
 not fail
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-8-jsnow@redhat.com>
 <87pm032nt1.fsf@pond.sub.org>
 <CAFn=p-ZJB6nfeGaaG=YiGrzGmdQnm=PYjfsLVRDQLxW26Ha65w@mail.gmail.com>
Date: Wed, 22 Nov 2023 10:52:34 +0100
In-Reply-To: <CAFn=p-ZJB6nfeGaaG=YiGrzGmdQnm=PYjfsLVRDQLxW26Ha65w@mail.gmail.com>
 (John Snow's message of "Tue, 21 Nov 2023 11:41:12 -0500")
Message-ID: <87bkbmw1wd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> On Tue, Nov 21, 2023, 9:17 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > lookup_type() is capable of returning None, but introspect.py isn't
>> > prepared for that. (And rightly so, if these built-in types are absent,
>> > something has gone hugely wrong.)
>> >
>> > RFC: This is slightly cumbersome as-is, but a patch at the end of this
>> series
>> > tries to address it with some slightly slicker lookup functions that
>> > don't need as much hand-holding.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/introspect.py | 8 ++++++--
>> >  1 file changed, 6 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
>> > index 67c7d89aae0..42981bce163 100644
>> > --- a/scripts/qapi/introspect.py
>> > +++ b/scripts/qapi/introspect.py
>> > @@ -227,10 +227,14 @@ def _use_type(self, typ: QAPISchemaType) -> str:
>> >
>> >          # Map the various integer types to plain int
>> >          if typ.json_type() =3D=3D 'int':
>> > -            typ =3D self._schema.lookup_type('int')
>> > +            tmp =3D self._schema.lookup_type('int')
>> > +            assert tmp is not None
>>
>> More laconic: assert tmp
>>
>
> *looks up "laconic"*
>
> hey, "terse" is even fewer letters!

Touch=C3=A9!

> (but, you're right. I think I adopted the "is not none" out of a habit for
> distinguishing false-y values from the None value, but in this case we

It's a good habit.

> really wouldn't want to have either, so the shorter form is fine, though
> for mypy's sake we only care about guarding against None here.)

Right.

>> > +            typ =3D tmp
>> >          elif (isinstance(typ, QAPISchemaArrayType) and
>> >                typ.element_type.json_type() =3D=3D 'int'):
>> > -            typ =3D self._schema.lookup_type('intList')
>> > +            tmp =3D self._schema.lookup_type('intList')
>> > +            assert tmp is not None
>> > +            typ =3D tmp
>> >          # Add type to work queue if new
>> >          if typ not in self._used_types:
>> >              self._used_types.append(typ)
>>
>> Not fond of naming things @tmp, but I don't have a better name to offer.
>>
>> We could avoid the lookup by having _def_predefineds() set suitable
>> attributes, like it serts .the_empty_object_type.  Matter of taste.  Not
>> now unless you want to.
>>
>
>  Check the end of the series for different lookup methods, too. We can
> discuss your preferred solution then, perhaps?

Works for me.


