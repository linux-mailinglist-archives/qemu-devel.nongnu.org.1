Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15C8222B4
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 21:46:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKldF-0003au-Az; Tue, 02 Jan 2024 15:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rKldC-0003am-NE
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 15:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rKldA-0002G3-26
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 15:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704228294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2j/FiJUy7j1S8SXl4MH8nhm/KlCfdDCzIDICljwL1io=;
 b=aRxxBq7K0UhPlKIeCPk8y2XtOWYU5XQjDXAGw17Kak4dD+QRT3BZYOcS+DRIaXojodq1QI
 BvTOnI1u3Yv6t1ykGolvrK+Bw75GI09HtLaOPLseVSoYaMLpOAc/D7rHR9mQlxVi6056v5
 TulKkwhkJjdJxRTDr5Tv4LFUwxY/rs8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-sOqoKm1CNRSQ1z1OEIooCQ-1; Tue,
 02 Jan 2024 15:44:51 -0500
X-MC-Unique: sOqoKm1CNRSQ1z1OEIooCQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0F8981C05EA3;
 Tue,  2 Jan 2024 20:44:51 +0000 (UTC)
Received: from localhost (unknown [10.39.193.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 04F16492BE6;
 Tue,  2 Jan 2024 20:44:49 +0000 (UTC)
Date: Tue, 2 Jan 2024 15:44:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Michael Tokarev <mjt@tls.msk.ru>, Zhao Liu <zhao1.liu@intel.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] docs/devel: Document conventional file prefixes and
 suffixes
Message-ID: <20240102204448.GA525972@fedora>
References: <20231226150441.97501-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9bQpbe3IJQaZCx31"
Content-Disposition: inline
In-Reply-To: <20231226150441.97501-1-philmd@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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


--9bQpbe3IJQaZCx31
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 04:04:41PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Some header and source file names use common prefix / suffix
> but we never really ruled a convention. Start doing so with
> the current patterns from the tree.
>=20
> Suggested-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> ---
>  docs/devel/style.rst | 49 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>=20
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b50079..4da50eb2ea 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -162,6 +162,55 @@ pre-processor. Another common suffix is ``_impl``; i=
t is used for the
>  concrete implementation of a function that will not be called
>  directly, but rather through a macro or an inline function.
> =20
> +File Naming Conventions
> +-----------------------
> +
> +Public headers
> +~~~~~~~~~~~~~~
> +
> +Headers expected to be access by multiple subsystems must reside in

s/access/accessed/

> +the ``include/`` folder. Headers local to a subsystem should reside in
> +the sysbsystem folder, if any (for example ``qobject/qobject-internal.h``

s/sysbsystem/subsystem/

> +can only be included by files within the ``qobject/`` folder).
> +
> +Header file prefix and suffix hints
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When headers relate to common concept, it is useful to use a common

Either "common concepts" (plural) or "a common concept" (singular with
an indefinite article).

> +prefix or suffix.
> +
> +When headers relate to the same (guest) subsystem, the subsystem name is
> +often used as prefix. If headers are already in a folder named as the
> +subsystem, prefixing them is optional.

"named as the subsystem" sounds strange. I suggest something like:

"If headers are already in a folder with the subsystem in its name,
prefixing them is optional."

or

"Prefixing header files is optional if the folder name already contains
the subsystem name."

> +
> +For example, hardware models related to the Aspeed systems are named
> +using the ``aspeed_`` prefix.
> +
> +Headers related to the same (host) concept can also use a common prefix.

Is there a need to distinguish between "(guest)" above and "(host)" here
since we end up recommending the same thing for both?

> +For example OS specific headers use the ``-posix`` and ``-win32`` suffix=
es.

The previous sentence is about prefixes but this sentence focusses on
suffixes. That's a little confusing. I guess you mean "foo-posix" and
"foo-win32" have a common prefix. It may help to express it in terms of
the prefix instead of mentioning the suffix.

> +
> +Registered file suffixes
> +~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +* ``.inc``
> +
> +  Source files meant to be included by other source files as templates
> +  must use the ``.c.inc`` suffix. Similarly, headers meant to be included
> +  multiple times as template must use the ``.h.inc`` suffix.
> +
> +Recommended file prefixes / suffixes
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +* ``target`` and ``common`` suffixes
> +
> +  Files which are specific to a target should use the ``target`` suffix.
> +  Such ``target`` suffixed headers usually *taint* the files including t=
hem
> +  by making them target specific.

Is there any particular macro or pattern for enforcing this? I remember
there are #error preprocessor directives in some header files to prevent
including them from the wrong source file, but I'm not sure if you're
referring to anything specific here.

> +
> +  Files common to all targets should use the ``common`` suffix, to provi=
de
> +  a hint that these files can be safely included from common code.

This statement is too general. For example, files in util/ can be used
=66rom common code but don't have a suffix. I think target and common
suffixes are useful when something is split into target-specific and
common parts. Otherwise it's not necessary.

--9bQpbe3IJQaZCx31
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWUdcAACgkQnKSrs4Gr
c8h++gf5AShKR6lIQ000tHdxOBkmtuu4Ih6eIwLNYquwsms02wAUxTzOBfCRmUzV
WuT4cNQHCXKEba+BARNincQleA25ZyfU0iowJSQxFImA3xDWQzDr/6VT6dkPuEIe
klLwuOufyBKFPafn1l0Q5K5BWUqKVQaS4HeZuB+SL/2CpqftrWou2uTxak8IkF+v
Mxn220qybMy9FnB43mEp9gmVkHALuG0+sBQKV53/Ap0b6RjcgHkREusuotT0QUkU
s8COPBBd8ymiRXVOy5xJsGqFwBEa4ldjAxu9/0iIt75wpdFRFfBFgKHA836VdKXO
3q+xZs+NRapJ4nqQ7Lg81WvGm0dcmQ==
=dMjM
-----END PGP SIGNATURE-----

--9bQpbe3IJQaZCx31--


