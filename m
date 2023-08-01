Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338176B862
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQr99-0005FB-3B; Tue, 01 Aug 2023 11:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQr95-0005Ex-SB
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:18:48 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQr91-0001Kn-Rn
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:18:47 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 93BD032009A2;
 Tue,  1 Aug 2023 11:18:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 01 Aug 2023 11:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1690903119; x=1690989519; bh=gK
 TMezlAZXZLImfZDKMvSC6T8tm1QmUiMbTh84M0xlo=; b=ovyijGSiWccVsPM5LP
 mLyMxH3VROLZ4l/kQr3qlGvMgO8daNDKKYy99yRZmc6c+MJzSwGgNzxZdWBBEKpS
 hIcJkiGRt9ZVtBY3ZIdugQfBHLLSLlz3xNVUfu70KI6TqVJmMSCw7NX3AgxD9sC/
 2ofUM3t0XplxTIUvu+yewI7TaCXrbuomfejMHFyhf+P1oaJKWLCL8AuN+i4Eg6jH
 21Rf8ppzgEnnih5ZU3OsAE/TxbR3KwKoYmMJHEUCbw8eA3ZlpOZoxxSY6C7wvSEw
 sbJoZBEyG+l/LdmG7zg6WYDSI6rovT23077yd3i8yyUMQWs8S8gtvBG3EF6fYf2O
 K6VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1690903119; x=1690989519; bh=gKTMezlAZXZLI
 mfZDKMvSC6T8tm1QmUiMbTh84M0xlo=; b=zQPm13N9wJ0Ny0R9VPv00Uf+Bx9G/
 r9D9+Gms/H8IC7PIds3o1wjfZCRcxNdR9hJ90cjn8Fyw/aZFwpG6lzpgNJ4Jo/x7
 42AN4rBmkPI20nueBiUnfgABzQsJQu6WcetgqgGxLOfK4WD75htTCvpqmaOeueuh
 rwGFOhDVNJUgsoEVT/Y4c9zW2AMrhonNj7JVE8yQoiFBbrgvYZl5FuHFvWsqbOV7
 IgfqZJ+RiURUWhMYo/zqEsxtpvK4Alytg4QAjitK9eY12Bo+lnEmyZviOdbuQGFu
 Hq0oC81sD/lpqFbjquuBjpUgVwEUIO0NTaJmUQ6u/hGzA3ecWOPSTxysA==
X-ME-Sender: <xms:TiLJZJ2l8HH5vptTQJEaJpS9u0y_lPWWRlgRBkMFWFOmjTMG2E-6Cg>
 <xme:TiLJZAGu89JjzDuOvYfR_R9s6v6zE_mn4X_rFG4CSQ7W9T6fLF0yYdZLmTZa9z4XM
 pBtU9Dx-GU-C9u5nQ>
X-ME-Received: <xmr:TiLJZJ5UYv7jjOY59uX10OWhb-fisrFVt1DR-didqfgUXRzi-EZsj1s_OXInA9FIFyrvlq23G2ZdaTuwzS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdekgecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddtjeenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepleeihf
 dvgeetveevgfffkeefjeehueekvdekieevgfdvgefhtedutdduudehkeejnecuffhomhgr
 ihhnpegtrhhrvghvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
 hmrghilhhfrhhomhephhhisegrlhihshhsrgdrihhs
X-ME-Proxy: <xmx:TiLJZG1nb_Jl9aO4xDRzB1AiaJAhlT5BGHYYGq7MkfM2JWcKQBTY8A>
 <xmx:TiLJZMG7GmtVgQzoKxISOycTLzvo8o23EtBx1hdN2nGsvfK3Dn82YA>
 <xmx:TiLJZH_z45NjdJ2nVztHYKpr3GePEBNZgmuIDTsIxkIiXio4HV0mcA>
 <xmx:TyLJZKag5ypJudkgjgALxcwj7f5wWDsdv_-IwziRo8sNPflfXqoC-Q>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 11:18:38 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 614F2756C; Tue,  1 Aug 2023 15:18:37 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, dmitry.osipenko@collabora.com, ray.huang@amd.com,
 alex.bennee@linaro.org, shentey@gmail.com, crosvm-dev@chromium.org
Subject: Rutabaga backwards compatibility
In-Reply-To: <CAAfnVBkm6yjR8HVWgpCCQkzpQ53unBCTP4Ngk=Z8QeEZ-7MbMw@mail.gmail.com>
References: <20230711025649.708-1-gurchetansingh@chromium.org>
 <87351diqf9.fsf@alyssa.is>
 <CAAfnVBkm6yjR8HVWgpCCQkzpQ53unBCTP4Ngk=Z8QeEZ-7MbMw@mail.gmail.com>
Date: Tue, 01 Aug 2023 15:18:35 +0000
Message-ID: <87zg3aaj04.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=64.147.123.25; envelope-from=hi@alyssa.is;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> On Mon, Jul 24, 2023 at 2:56=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Gurchetan Singh <gurchetansingh@chromium.org> writes:
>>
>> > In terms of API stability/versioning/packaging, once this series is
>> > reviewed, the plan is to cut a "gfxstream upstream release branch".  We
>> > will have the same API guarantees as any other QEMU project then, i.e =
no
>> > breaking API changes for 5 years.
>>
>> What about Rutabaga?
>
> Yes, rutabaga + gfxstream will both be versioned and maintain API
> backwards compatibility in line with QEMU guidelines.

In that case, I should draw your attention to
<https://crrev.com/c/4584252>, which I've just realised while testing v2
of your series here breaks the build of the rutabaga ffi, and which will
require the addition of a "prot" field to struct rutabaga_handle (a
breaking change).  I'll push a new version of that CL to fix rutabaga
ffi in the next few days.

Since this is already coming up, before the release has even been made,
is it worth exploring how to limit the rutabaga API to avoid more
breaking changes after the release?  Could there be more use of opaque
structs, for example?

(CCing the crosvm list)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTJIkwACgkQ+dvtSFmy
ccDAOBAAkhjp2+P+SZF4Cqhq4P0VjGU9G3dUpg0dQ+KpuzuYOye8Rv7LTwQlCSev
SW265G6DN7lJ+PCrVET3hB9t33wiGt2MbHqzgejFNkG+zXzM7GqEIUHso9ErzdR7
2shS6NRrsc0TiCctZugMiBwlc9fBTqAdpqZM9rZ0eOozHSGcznZiQVBOtiG0FrCc
uQlVd7zhkq8wQ5F73Ksvi4Qx6msW84Y9SYmOsdkapJc+ILyABrLKF/HZL8D6jV8I
QBN8ueFfGut5we3O33KUTcibMn+sQDlzFGeQjTag5cGjXAw5YBVUV8KKatVFiXqX
fV0ce4TFOJbrAUXvcgO0fKmu4ax4whxZDk454Wvw+/rUba3NJfuKnUkkbR+kw/l/
qlSy6i4hQaVtFMQe/e9w8+Mzd/vazKDm/7pq4gBBTvN2QziFwVhqnq3wwmGut+Q4
g0NJ6cpVC+DkYtLG15sM1yrl7aLmjIGO2kPaC4xa/RbG+3HKAN3GgULWpyIOgwAe
A5t/87zVaSXFphJ8LN+Ht7X33/nNpMvpnRc+Wo5QG6tensPFun7EToFX8Bg3DDlX
CnrBbGxqfnzkc6HXq2Of7QPlto4RWejq2yYDfuTPbN8oGGh1NU8JSgeaqxQMyZe0
4gBK6yV0ryz3+0W9bUAik8P8XI5+4y53HuoKNBHB6kXzU29+jmU=
=hC0G
-----END PGP SIGNATURE-----
--=-=-=--

