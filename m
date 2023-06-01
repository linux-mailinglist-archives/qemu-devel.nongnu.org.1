Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C0C719EDF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:54:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4il3-0007Lx-L9; Thu, 01 Jun 2023 09:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4il2-0007Lj-2L
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1q4il0-0001rG-Gw
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685627665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtU7zaUDvpMyXn+j45xF/YIapIMEvvBROzS5cl1hqBk=;
 b=aYK7PPBenODLvlPIitpzSoO+FvmAyuY3/v4JkUHdnD4SDzeNYEu86McawVfWkXuTPr8AOu
 4r9xS0KQxSh51a8iWZsGpO3c0W3h7TwFfIeSJwMnMgP7Q8xZCWPmX/8MpVBBmkpjHmw0be
 BP1sVqsboCANcVU2lKmGyViDkxC9QWA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-367-Y0V1CeOYOs69Wh6uYqUulA-1; Thu, 01 Jun 2023 09:54:24 -0400
X-MC-Unique: Y0V1CeOYOs69Wh6uYqUulA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 255DD800BFF;
 Thu,  1 Jun 2023 13:54:24 +0000 (UTC)
Received: from localhost (unknown [10.39.194.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B1BC5492B00;
 Thu,  1 Jun 2023 13:54:23 +0000 (UTC)
Date: Thu, 1 Jun 2023 09:54:22 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 01/11] *-user: remove the guest_user_syscall tracepoints
Message-ID: <20230601135422.GE1538357@fedora>
References: <20230531194815.1508961-1-stefanha@redhat.com>
 <20230531194815.1508961-2-stefanha@redhat.com>
 <5c0e79d6-6810-5429-656a-041e114b9b5e@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LbM5afTqwJq2kEKn"
Content-Disposition: inline
In-Reply-To: <5c0e79d6-6810-5429-656a-041e114b9b5e@linaro.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


--LbM5afTqwJq2kEKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2023 at 02:29:49PM -0700, Richard Henderson wrote:
> On 5/31/23 12:48, Stefan Hajnoczi wrote:
> > --- a/bsd-user/freebsd/os-syscall.c
> > +++ b/bsd-user/freebsd/os-syscall.c
> > @@ -531,7 +531,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num,=
 abi_long arg1,
> >       CPUState *cpu =3D env_cpu(cpu_env);
> >       abi_long ret;
> > -    trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, a=
rg6, arg7, arg8);
> >       if (do_strace) {
> >           print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6=
);
> >       }
> > @@ -541,7 +540,6 @@ abi_long do_freebsd_syscall(void *cpu_env, int num,=
 abi_long arg1,
> >       if (do_strace) {
> >           print_freebsd_syscall_ret(num, ret);
> >       }
> > -    trace_guest_user_syscall_ret(cpu, num, ret);
> >       return ret;
> >   }
>=20
> Failed to remove the now unused cpu variable:
>=20
> https://gitlab.com/qemu-project/qemu/-/jobs/4387911615#L6426
>=20
> ../bsd-user/freebsd/os-syscall.c:531:15: error: unused variable 'cpu'
> [-Werror,-Wunused-variable]
>     CPUState *cpu =3D env_cpu(cpu_env);
>               ^
> 1 error generated.

I'll send a v2 with the unused variable warning fixed.

Stefan

--LbM5afTqwJq2kEKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmR4ow4ACgkQnKSrs4Gr
c8j60Af9H+3+PvLFJZZK13uTSrMb9aKQ7oUDifIuPGW5oBwUt9zej3iT8p11WjzJ
Vqb6cVhcEUtGK1LWbhRuC4mMgwMC3yH40PrAy8oxpuJTiQkR8vtRTE37p6gQLJvJ
4OUQzCjbvpjUr8Zsm/etiQnWw3fm6XULsqats/DTYUCm5xtCDH3g4b1FZrZ/TLTw
NDMvYn/xh8yrJUlzP7GCH01WVFPvElI+l3ZnKhhvk/+gTcsqz/p1M27zqxLr42WN
CGxSFkgSPWSq5ZmrQhNdHdbWP9hQl8k/4inrAnyWnFV4pm7HF/3xV62hO7FAfD2D
/Nm6tXLlzD2IL21/+ylmGvgETDAa8A==
=mdID
-----END PGP SIGNATURE-----

--LbM5afTqwJq2kEKn--


