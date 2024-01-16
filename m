Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D779082ED6A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 12:10:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPhKF-0003v2-AM; Tue, 16 Jan 2024 06:09:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPhKD-0003tb-IA
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 06:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPhK9-0002JX-6k
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 06:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705403379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+2eEVMjcbnVY+WResrPUA93mbwnyhJHe09kzTkKi6g=;
 b=AW8g/B1IGqpex9GIz/DQd8Uwi3wYVhee8sleM86WiZNkUt3+sPjpc+vCn+Lmx6rxKSi6xx
 V9/D0zgSldTxBzibAq07tugvGgwvWL6InQ5gZ8/oHvDCj9+lSiw/ssWLq3YyjlsIpN16xA
 MjNBUH3qBqIuwQc5l5fdAh1Ts/o+jLE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-ZsMYprfqOc-zcnZhhnudMQ-1; Tue, 16 Jan 2024 06:09:36 -0500
X-MC-Unique: ZsMYprfqOc-zcnZhhnudMQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1AD9486EB22;
 Tue, 16 Jan 2024 11:09:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B920028AC;
 Tue, 16 Jan 2024 11:09:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8688621E680D; Tue, 16 Jan 2024 12:09:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 09/19] qapi/schema: allow resolve_type to be used for
 built-in types
In-Reply-To: <20240112222945.3033854-10-jsnow@redhat.com> (John Snow's message
 of "Fri, 12 Jan 2024 17:29:35 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-10-jsnow@redhat.com>
Date: Tue, 16 Jan 2024 12:09:33 +0100
Message-ID: <87cyu15yc2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

> allow resolve_type to be used for both built-in and user-specified
> type definitions. In the event that the type cannot be resolved, assert
> that 'info' and 'what' were both provided in order to create a usable
> QAPISemError.
>
> In practice, 'info' will only be None for built-in definitions, which
> *should not fail* type lookup.
>
> As a convenience, allow the 'what' and 'info' parameters to be elided
> entirely so that it can be used as a can-not-fail version of
> lookup_type.

The convenience remains unused until the next patch.  It should be added
there.

> Note: there are only three callsites to resolve_type at present where
> "info" is perceived to be possibly None:
>
>     1) QAPISchemaArrayType.check()
>     2) QAPISchemaObjectTypeMember.check()
>     3) QAPISchemaEvent.check()
>
>     Of those three, only the first actually ever passes None;

Yes.  More below.

>                                                               the other two
>     are limited by their base class initializers which accept info=None, but

They do?

>     neither actually use it in practice.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Hmm.

We look up types by name in two ways:

1. Failure is a semantic error

   Use .resolve_type(), passing real @info and @what.

   Users:

   * QAPISchemaArrayType.check() resolving the element type

     Fine print: when the array type is built-in, we pass None @info and
     @what.  The built-in array type's element type must exist for
     .resolve_type() to work.  This commit changes .resolve_type() to
     assert it does.

   * QAPISchemaObjectType.check() resolving the base type

   * QAPISchemaObjectTypeMember.check() resolving the member type

   * QAPISchemaCommand.check() resolving argument type (if named) and
     return type (which is always named).

   * QAPISchemaEvent.check() resolving argument type (if named).

   Note all users are in .check() methods.  That's where type named get
   resolved.

2. Handle failure

   Use .lookup_type(), which returns None when the named type doesn't
   exist.

   Users:

   * QAPISchemaVariants.check(), to look up the base type containing the
     tag member for error reporting purposes.  Failure would be a
     programming error.

   * .resolve_type(), which handles failure as semantic error

   * ._make_array_type(), which uses it as "type exists already"
      predicate.

   * QAPISchemaGenIntrospectVisitor._use_type(), to look up certain
     built-in types.  Failure would be a programming error.

The next commit switches the uses where failure would be a programming
error from .lookup_type() to .resolve_type() without @info and @what, so
failure trips its assertion.  I don't like it, because it overloads
.resolve_type() to serve two rather different use cases:

1. Failure is a semantic error; pass @info and @what

2. Failure is a programming error; don't pass @info and what

The odd one out is of course QAPISchemaArrayType.check(), which wants to
use 1. for the user's types and 2. for built-in types.  Let's ignore it
for a second.

I prefer to do 2. like typ = .lookup_type(); assert typ.  We can factor
this out into its own helper if that helps (pardon the pun).

Back to QAPISchemaArrayType.check().  Its need to resolve built-in
element types, which have no info, necessitates .resolve_type() taking
Optional[QAPISourceInfo].  This might bother you.  It doesn't bother me,
unless it leads to mypy complications I can't see.

We can simply leave it as is.  Adding the assertion to .resolve_type()
is fine.

Ot we complicate QAPISchemaArrayType.check() to simplify
.resolve_type()'s typing, roughly like this:

            if self.info:
                self.element_type = schema.resolve_type(
                    self._element_type_name,
                    self.info, self.info.defn_meta)
            else:               # built-in type
                self.element_type = schema.lookup_type(
                    self._element_type_name)
                assert self.element_type

Not sure it's worth the trouble.  Thoughts?

> ---
>  scripts/qapi/schema.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 66a78f28fd4..a77b51d1b96 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -1001,9 +1001,10 @@ def lookup_type(self, name):
>          assert typ is None or isinstance(typ, QAPISchemaType)
>          return typ
>  
> -    def resolve_type(self, name, info, what):
> +    def resolve_type(self, name, info=None, what=None):
>          typ = self.lookup_type(name)
>          if not typ:
> +            assert info and what  # built-in types must not fail lookup
>              if callable(what):
>                  what = what(info)
>              raise QAPISemError(


