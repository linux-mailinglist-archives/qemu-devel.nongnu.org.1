Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDA982EFCF
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:38:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPjcx-00075W-SK; Tue, 16 Jan 2024 08:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPjcs-00074o-RV
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:37:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rPjcr-0006Dl-2i
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 08:37:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705412224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3xiDVbhl1k2GzH8T7LJUpl/lB3dEh5bqgNO25RDKFc=;
 b=eMBD50C8/TbV4X7a8Scm56vh6O/lzRWRf4DpV8g6XvLUIsvlQnMpccbHKS044m8tK8BKce
 mv26ozYlJqIZLWEiYkOeOoJUl8jOrLKAL9KcAsonflLXEn6oD6h1hhm1HbaHbJJp0yQa6K
 k5ioZkSfYJUafT+W5g4xOXEQPP6lGsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-K2ynPZq2OTeK1TZ8L-Bp5g-1; Tue, 16 Jan 2024 08:37:02 -0500
X-MC-Unique: K2ynPZq2OTeK1TZ8L-Bp5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08133185A781;
 Tue, 16 Jan 2024 13:37:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E021121312;
 Tue, 16 Jan 2024 13:37:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D68A821E66CF; Tue, 16 Jan 2024 14:37:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 12/19] qapi/schema: assert info is present when
 necessary
In-Reply-To: <20240112222945.3033854-13-jsnow@redhat.com> (John Snow's message
 of "Fri, 12 Jan 2024 17:29:38 -0500")
References: <20240112222945.3033854-1-jsnow@redhat.com>
 <20240112222945.3033854-13-jsnow@redhat.com>
Date: Tue, 16 Jan 2024 14:37:00 +0100
Message-ID: <87h6jdtn5v.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

> QAPISchemaInfo instances are sometimes defined as an Optional
> field/argument because built-in definitions don't *have* a source
> definition. As a consequence, there are a few places where we need to
> assert that it's present because the root entity definition can only
> enforce that it is "Optional".

Well, we need to assert to help mypy over the hump.  But that's later in
this series.  Just like "enforce that is is 'Optional'".  My point is:
the commit message is less than clear unless the reader already knows
where we're going.

Here's my try:

  QAPISchemaInfo arguments can often be None because build-in
  definitions don't have such information.  The type hint can only be
  Optional[QAPISchemaInfo] then.  But then mypy gets upset about all the
  places where we exploit that it can't actually be None there.  Add
  assertions that will help mypy over the hump, to enable adding the
  type hints.

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  scripts/qapi/schema.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
> index 43af756ed47..eefa58a798b 100644
> --- a/scripts/qapi/schema.py
> +++ b/scripts/qapi/schema.py
> @@ -758,6 +758,7 @@ def describe(self, info):
>              else:
>                  assert False
>=20=20
> +        assert info is not None
>          if defined_in !=3D info.defn_name:
>              return "%s '%s' of %s '%s'" % (role, self.name, meta, define=
d_in)
>          return "%s '%s'" % (role, self.name)
> @@ -848,6 +849,7 @@ def __init__(self, name, info, doc, ifcond, features,
>          self.coroutine =3D coroutine
>=20=20
>      def check(self, schema):
> +        assert self.info is not None
>          super().check(schema)
>          if self._arg_type_name:
>              arg_type =3D schema.resolve_type(


