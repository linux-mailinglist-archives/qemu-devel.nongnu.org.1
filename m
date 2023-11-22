Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487287F4548
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 13:02:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5luW-0001mt-Gk; Wed, 22 Nov 2023 07:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5luT-0001mg-HZ
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:00:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r5luR-0002zn-NG
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 07:00:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700654446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z5P/colIC8kFhRSaX0gV5bPJ2zQ9fyXpztbdLpGE1E0=;
 b=hUByC7YeV3+bzSOVzgVq6V+uaJ/eIMwGxkzaA564eBo48U+aRoZx0ZTo6QyMZfEW+4DRFv
 5+4WF0DNVEvqQJmY6LylLUjpvGwHRJXkiDsSahunYktp8LyhOsJG9FJz3Bq8Ka60zQeKGQ
 sWzj+M9MHJBVwa2MlG1VOmQChxRcbhg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-XZUoWA3gOXeA1LCpmOygmQ-1; Wed,
 22 Nov 2023 07:00:42 -0500
X-MC-Unique: XZUoWA3gOXeA1LCpmOygmQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 770BF381A889;
 Wed, 22 Nov 2023 12:00:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3602A2026D4C;
 Wed, 22 Nov 2023 12:00:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2FC5221E6A1F; Wed, 22 Nov 2023 13:00:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 06/19] qapi/schema: adjust type narrowing for mypy's
 benefit
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-7-jsnow@redhat.com>
 <87ttpf2o6t.fsf@pond.sub.org>
 <CAFn=p-bd6E0kYJXyzjU=BR8BzEAXvdiQbsMT+_E1O7COaXNfJA@mail.gmail.com>
Date: Wed, 22 Nov 2023 13:00:41 +0100
In-Reply-To: <CAFn=p-bd6E0kYJXyzjU=BR8BzEAXvdiQbsMT+_E1O7COaXNfJA@mail.gmail.com>
 (John Snow's message of "Tue, 21 Nov 2023 11:36:19 -0500")
Message-ID: <87cyw2uhee.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
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

> On Tue, Nov 21, 2023, 9:09 AM Markus Armbruster <armbru@redhat.com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > We already take care to perform some type narrowing for arg_type and
>> > ret_type, but not in a way where mypy can utilize the result. A simple
>> > change to use a temporary variable helps the medicine go down.
>> >
>> > Signed-off-by: John Snow <jsnow@redhat.com>
>> > ---
>> >  scripts/qapi/schema.py | 17 +++++++++--------
>> >  1 file changed, 9 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
>> > index 4600a566005..a1094283828 100644
>> > --- a/scripts/qapi/schema.py
>> > +++ b/scripts/qapi/schema.py
>> > @@ -825,13 +825,14 @@ def __init__(self, name, info, doc, ifcond, features,
>> >      def check(self, schema):
>> >          super().check(schema)
>> >          if self._arg_type_name:
>> > -            self.arg_type = schema.resolve_type(
>> > +            arg_type = schema.resolve_type(
>> >                  self._arg_type_name, self.info, "command's 'data'")
>> > -            if not isinstance(self.arg_type, QAPISchemaObjectType):
>> > +            if not isinstance(arg_type, QAPISchemaObjectType):
>> >                  raise QAPISemError(
>> >                      self.info,
>> >                      "command's 'data' cannot take %s"
>> > -                    % self.arg_type.describe())
>> > +                    % arg_type.describe())
>> > +            self.arg_type = arg_type
>> >              if self.arg_type.variants and not self.boxed:
>> >                  raise QAPISemError(
>> >                      self.info,

Same story as for QAPISchemaEvent.check() below.  Correct?

>> > @@ -848,8 +849,7 @@ def check(self, schema):
>> >              if self.name not in self.info.pragma.command_returns_exceptions:
>> >                  typ = self.ret_type
>> >                  if isinstance(typ, QAPISchemaArrayType):
>> > -                    typ = self.ret_type.element_type
>> > -                    assert typ
>> > +                    typ = typ.element_type
>>
>
> In this case, we've narrowed typ but not self.ret_type and mypy is not sure
> they're synonymous here (lack of power in mypy's model, maybe?). Work in
> terms of the temporary type we've already narrowed so mypy knows we have an
> element_type field.

The conditional ensures @typ is QAPISchemaArrayType.

In mypy's view, @typ is QAPISchemaArrayType, but self.ret_type is only
Optional[QAPISchemaType].

Therefore, it chokes on self.ret_type.element_type, but is happy with
typ.element_type.

Correct?

Why delete the assertion?  Oh!  Hmm, should the deletion go into PATCH
10?

>>                  if not isinstance(typ, QAPISchemaObjectType):
>> >                      raise QAPISemError(
>> >                          self.info,
>> > @@ -885,13 +885,14 @@ def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
>> >      def check(self, schema):
>> >          super().check(schema)
>> >          if self._arg_type_name:
>> > -            self.arg_type = schema.resolve_type(
>> > +            typ = schema.resolve_type(
>> >                  self._arg_type_name, self.info, "event's 'data'")
>> > -            if not isinstance(self.arg_type, QAPISchemaObjectType):
>> > +            if not isinstance(typ, QAPISchemaObjectType):
>> >                  raise QAPISemError(
>> >                      self.info,
>> >                      "event's 'data' cannot take %s"
>> > -                    % self.arg_type.describe())
>> > +                    % typ.describe())
>> > +            self.arg_type = typ
>> >              if self.arg_type.variants and not self.boxed:
>> >                  raise QAPISemError(
>> >                      self.info,
>>
>> Harmless enough.  I can't quite see the mypy problem, though.  Care to
>> elaborate a bit?
>>
>
> self.arg_type has a narrower type- or, it WILL at the end of this series -
> so we need to narrow a temporary variable first before assigning it to the
> object state.
>
> We already perform the necessary check/narrowing, so this is really just
> pointing out that it's a bad idea to assign the state before the type
> check. Now we type check before assigning state.

After PATCH 16, .resolve_type() will return QAPISchemaType, and
self.arg_type will be Optional[QAPISchemaObjectType].  Correct?


