Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118982E03A
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 19:48:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPS09-0005bA-Ne; Mon, 15 Jan 2024 13:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPS05-0005b0-2v
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 13:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rPS03-0002Fc-Eo
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 13:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705344473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x92BVtARW4xF5AKJYczxYLETSVMseXN6hfCjxMOJfDg=;
 b=T5Lvt8ZfMfOaLzNFVw/f9L4fc6AyqvmHycBhMJei+z8PijQzWQepJUct5Fb5zaUWp6ixKy
 lLnWph6poWZtzhkysDaBy3SILEVxK3Ak1tm7nMt790c/Ko5CnkJ5f1OTFdlgYZjYfgCgLZ
 IPRtIdy2SHHW0hKSQG18LQq0j/fHfNI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-q_zl2-NWNTW3PQ0WnBv7sw-1; Mon, 15 Jan 2024 13:47:46 -0500
X-MC-Unique: q_zl2-NWNTW3PQ0WnBv7sw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DE3882DFE2;
 Mon, 15 Jan 2024 18:47:46 +0000 (UTC)
Received: from localhost (unknown [10.39.192.194])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D24645B7B;
 Mon, 15 Jan 2024 18:47:45 +0000 (UTC)
Date: Mon, 15 Jan 2024 13:47:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Lingfeng Yang <lfy@google.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] coroutine-ucontext: Save fake stack for pooled coroutine
Message-ID: <20240115184739.GB1143584@fedora>
References: <20240112-asan-v1-1-e330f0d0032c@daynix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="THfJBBUn0xFa7HUe"
Content-Disposition: inline
In-Reply-To: <20240112-asan-v1-1-e330f0d0032c@daynix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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


--THfJBBUn0xFa7HUe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 07:36:19PM +0900, Akihiko Odaki wrote:
> Coroutine may be pooled even after COROUTINE_TERMINATE if
> CONFIG_COROUTINE_POOL is enabled and fake stack should be saved in
> such a case to keep AddressSanitizerUseAfterReturn working. Even worse,
> I'm seeing stack corruption without fake stack being saved.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  util/coroutine-ucontext.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)

Adding Marc-Andr=E9 Lureau and Lingfeng Yang, who authored the code in
question.

Stefan

>=20
> diff --git a/util/coroutine-ucontext.c b/util/coroutine-ucontext.c
> index 7b304c79d942..e62ced5d6779 100644
> --- a/util/coroutine-ucontext.c
> +++ b/util/coroutine-ucontext.c
> @@ -124,8 +124,9 @@ void start_switch_fiber_asan(CoroutineAction action, =
void **fake_stack_save,
>  {
>  #ifdef CONFIG_ASAN
>      __sanitizer_start_switch_fiber(
> -            action =3D=3D COROUTINE_TERMINATE ? NULL : fake_stack_save,
> -            bottom, size);
> +        !IS_ENABLED(CONFIG_COROUTINE_POOL) && action =3D=3D COROUTINE_TE=
RMINATE ?
> +            NULL : fake_stack_save,
> +        bottom, size);
>  #endif
>  }
> =20
> @@ -269,10 +270,26 @@ static inline void valgrind_stack_deregister(Corout=
ineUContext *co)
>  #endif
>  #endif
> =20
> +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
> +static void coroutine_fn terminate(void *opaque)
> +{
> +    CoroutineUContext *to =3D DO_UPCAST(CoroutineUContext, base, opaque);
> +
> +    __sanitizer_start_switch_fiber(NULL, to->stack, to->stack_size);
> +    siglongjmp(to->env, COROUTINE_ENTER);
> +}
> +#endif
> +
>  void qemu_coroutine_delete(Coroutine *co_)
>  {
>      CoroutineUContext *co =3D DO_UPCAST(CoroutineUContext, base, co_);
> =20
> +#if defined(CONFIG_ASAN) && defined(CONFIG_COROUTINE_POOL)
> +    co_->entry_arg =3D qemu_coroutine_self();
> +    co_->entry =3D terminate;
> +    qemu_coroutine_switch(co_->entry_arg, co_, COROUTINE_ENTER);
> +#endif
> +
>  #ifdef CONFIG_VALGRIND_H
>      valgrind_stack_deregister(co);
>  #endif
>=20
> ---
> base-commit: f614acb7450282a119d85d759f27eae190476058
> change-id: 20240112-asan-eb695c769f40
>=20
> Best regards,
> --=20
> Akihiko Odaki <akihiko.odaki@daynix.com>
>=20

--THfJBBUn0xFa7HUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmWlfcsACgkQnKSrs4Gr
c8i1ZggAmrp9uFYrfat3oDCGLsnUdf/eIZ/SjUB9vWxmTv2WtxexjZQrB+nPL8Qt
q7voU9q+puTMEqqRGSi6NBG/Xwh+0rOXex8oTk2tVvVH9yJqKNly5BE3ZFdhgmvj
Ltf5yMyGqyg6gqMGZVJS9PoQBzU0K8+xryUsvI9NXQeGSLuUUaxd09GAWDLcmVyC
MMkGlSmrrAGmaMxtWF3sbrZnlNM7jbzk4yYCF93nK50bsXmzIAVXM77RFSSP1Kvt
vXoFvFGk7OwjtHZmNQKSdVG/bAO90u5dUAku/05PWiJo9+tEA9L6371Q3VsaHyzw
Xd969V6E1Z/kFrfqmwoNY2GqgxHPZw==
=+d3h
-----END PGP SIGNATURE-----

--THfJBBUn0xFa7HUe--


