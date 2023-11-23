Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4087F6135
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 15:14:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6ARf-0000OI-3g; Thu, 23 Nov 2023 09:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6ARc-0000O8-2S
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r6ARa-0001H8-91
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 09:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700748756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3/xz6mYIYcAx5LHKYlcJQpn+uer2uLsSzI32X8bGY5c=;
 b=NcVkwAaPKVs8UfAp9dzIqzR9dZC3NW6djFJryODKckhHqHDvgBeqmOVT41Mjj0ibXU6NJW
 Tewc9vfGvnriT1SqwYPbOhNmdeLaVEsVlGcSWgor6GXz/mNExkwP57Bk2SEaGBlgJsD0aP
 PeP3M3Fa/0Q4JHtaHyjRLeUPcWOghWc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-_MOt5hUrNI2znSCVT2U9Cw-1; Thu, 23 Nov 2023 09:12:33 -0500
X-MC-Unique: _MOt5hUrNI2znSCVT2U9Cw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B64DD80C827;
 Thu, 23 Nov 2023 14:12:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95E94492BFA;
 Thu, 23 Nov 2023 14:12:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8D75C21E6A1F; Thu, 23 Nov 2023 15:12:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 15/19] qapi/parser: demote QAPIExpression to Dict[str, Any]
References: <20231116014350.653792-1-jsnow@redhat.com>
 <20231116014350.653792-16-jsnow@redhat.com>
Date: Thu, 23 Nov 2023 15:12:31 +0100
In-Reply-To: <20231116014350.653792-16-jsnow@redhat.com> (John Snow's message
 of "Wed, 15 Nov 2023 20:43:46 -0500")
Message-ID: <8734ww4kz4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
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

> Dict[str, object] is a stricter type, but with the way that code is
> currently arranged, it is infeasible to enforce this strictness.
>
> In particular, although expr.py's entire raison d'=C3=AAtre is normalizat=
ion
> and type-checking of QAPI Expressions, that type information is not
> "remembered" in any meaningful way by mypy because each individual
> expression is not downcast to a specific expression type that holds all
> the details of each expression's unique form.
>
> As a result, all of the code in schema.py that deals with actually
> creating type-safe specialized structures has no guarantee (myopically)
> that the data it is being passed is correct.
>
> There are two ways to solve this:
>
> (1) Re-assert that the incoming data is in the shape we expect it to be, =
or
> (2) Disable type checking for this data.
>
> (1) is appealing to my sense of strictness, but I gotta concede that it
> is asinine to re-check the shape of a QAPIExpression in schema.py when
> expr.py has just completed that work at length. The duplication of code
> and the nightmare thought of needing to update both locations if and
> when we change the shape of these structures makes me extremely
> reluctant to go down this route.
>
> (2) allows us the chance to miss updating types in the case that types
> are updated in expr.py, but it *is* an awful lot simpler and,
> importantly, gets us closer to type checking schema.py *at
> all*. Something is better than nothing, I'd argue.
>
> So, do the simpler dumber thing and worry about future strictness
> improvements later.

Yes.

While Dict[str, object] is stricter than Dict[str, Any], both are miles
away from the actual, recursive type.

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index bf31018aef0..b7f08cf36f2 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -19,6 +19,7 @@
>  import re
>  from typing import (
>      TYPE_CHECKING,
> +    Any,
>      Dict,
>      List,
>      Mapping,
> @@ -43,7 +44,7 @@
>  _ExprValue =3D Union[List[object], Dict[str, object], str, bool]
>=20=20
>=20=20
> -class QAPIExpression(Dict[str, object]):
> +class QAPIExpression(Dict[str, Any]):
>      # pylint: disable=3Dtoo-few-public-methods
>      def __init__(self,
>                   data: Mapping[str, object],

There are several occurences of Dict[str, object] elsewhere.  Would your
argument for dumbing down QAPIExpression apply to (some of) them, too?

Skimming them, I found this in introspect.py:

    # These types are based on structures defined in QEMU's schema, so we
    # lack precise types for them here. Python 3.6 does not offer
    # TypedDict constructs, so they are broadly typed here as simple
    # Python Dicts.
    SchemaInfo =3D Dict[str, object]
    SchemaInfoEnumMember =3D Dict[str, object]
    SchemaInfoObject =3D Dict[str, object]
    SchemaInfoObjectVariant =3D Dict[str, object]
    SchemaInfoObjectMember =3D Dict[str, object]
    SchemaInfoCommand =3D Dict[str, object]

Can we do better now we have 3.8?


