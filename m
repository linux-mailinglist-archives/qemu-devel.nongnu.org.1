Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D3682887A
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:49:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNDPT-0005kC-1T; Tue, 09 Jan 2024 09:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNDPQ-0005jo-L6
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rNDPO-0002M8-Px
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704811727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f0kkdzu6O2et3bnqvUGLEJulAQ/TCEAMYLMu0Bx5OP4=;
 b=MLHLeHViktS5L3SmiwthRQqZz7eLSFk0zigjJZBG+HU35+ofSHZ4BNlVfhwBOxAyI9eSOo
 35kTDZfBssx+wAqEzhbQmmhyljaNB6Hyr1cT8VFymh41HURqOHtC9GmTOMsnceVN4T/lvc
 xOvWbXweL5rQjJ7OdR3GcEDqOsfV59w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-OMh3mXgoODy0KI73SJH6uQ-1; Tue, 09 Jan 2024 09:48:44 -0500
X-MC-Unique: OMh3mXgoODy0KI73SJH6uQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C861A836F8A;
 Tue,  9 Jan 2024 14:48:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.71])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A83132026D66;
 Tue,  9 Jan 2024 14:48:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A506F21E6691; Tue,  9 Jan 2024 15:48:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 2/2] meson: mitigate against use of uninitialize
 stack for exploits
In-Reply-To: <20240103123414.2401208-3-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 3 Jan 2024 12:34:14
 +0000")
References: <20240103123414.2401208-1-berrange@redhat.com>
 <20240103123414.2401208-3-berrange@redhat.com>
Date: Tue, 09 Jan 2024 15:48:42 +0100
Message-ID: <87frz6lfzp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> When variables are used without being initialized, there is potential
> to take advantage of data that was pre-existing on the stack from an
> earlier call, to drive an exploit.
>
> It is good practice to always initialize variables, and the compiler
> can warn about flaws when -Wuninitialized is present. This warning,
> however, is by no means foolproof with its output varying depending
> on compiler version and which optimizations are enabled.
>
> The -ftrivial-auto-var-init option can be used to tell the compiler
> to always initialize all variables. This increases the security and
> predictability of the program, closing off certain attack vectors,
> reducing the risk of unsafe memory disclosure.
>
> While the option takes several possible values, using 'zero' is
> considered to be the  option that is likely to lead to semantically
> correct or safe behaviour[1]. eg sizes/indexes are not likely to
> lead to out-of-bounds accesses when initialized to zero. Pointers
> are less likely to point something useful if initialized to zero.
>
> Even with -ftrivial-auto-var-init=3Dzero set, GCC will still issue
> warnings with -Wuninitialized if it discovers a problem, so we are
> not loosing diagnostics for developers, just hardening runtime
> behaviour and making QEMU behave more predictably in case of hitting
> bad codepaths.
>
> [1] https://lists.llvm.org/pipermail/cfe-dev/2020-April/065221.html
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  meson.build | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/meson.build b/meson.build
> index eaa20d241d..efc1b4dd14 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -440,6 +440,11 @@ hardening_flags =3D [
>      # upon its return. This makes it harder to assemble
>      # ROP gadgets into something usable
>      '-fzero-call-used-regs=3Dused-gpr',
> +
> +    # Initialize all stack variables to zero. This makes
> +    # it harder to take advantage of uninitialized stack
> +    # data to drive exploits
> +    '-ftrivial-auto-var-init=3Dzero',
>  ]
>=20=20
>  qemu_common_flags +=3D cc.get_supported_arguments(hardening_flags)

Have you tried to throw in -Wtrivial-auto-var-init?

Documentation, for your convenience:

=E2=80=98-Wtrivial-auto-var-init=E2=80=99
     Warn when =E2=80=98-ftrivial-auto-var-init=E2=80=99 cannot initialize =
the automatic
     variable.  A common situation is an automatic variable that is
     declared between the controlling expression and the first case
     label of a =E2=80=98switch=E2=80=99 statement.


