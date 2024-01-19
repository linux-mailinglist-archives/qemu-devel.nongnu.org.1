Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A9883301E
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 22:14:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQwBE-0007Rt-JN; Fri, 19 Jan 2024 16:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rQwBB-0007Rh-8P
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:13:33 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rQwB4-00081g-KP
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 16:13:32 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id 7AC7F5C01CA;
 Fri, 19 Jan 2024 16:13:21 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Fri, 19 Jan 2024 16:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1705698801; x=1705785201; bh=JdzgbrxKb6
 j20zlK8ja15pbzl7ZjuJOeNkYCKEiy19Y=; b=IJN6NN05aOpUox3owEm6YxH477
 Yx2hkyFtjPqZ0RPkdoafBfVlrJZaE8HsR1vjii6AczFaqHhrJWNcLhlEzkLHrZ/k
 pt/PQ+KBvQhVlIbw3lsCG8MN9FhcKdyIGWbDE507HZ6hV9o4U4VcYA3bN3Xc7Nid
 lPzCYBTlHI5ggjSq/6qgKfkdUZD8Y5CiKxZTiJGjj6LWx+IOM8IecNPlTsrzLBss
 aDtxSzP1uhLhh70fcLGN+zyAo0j/JI7N/eVXJ30Y3+pluQ5HyiCMXtkqrTAPd7lC
 RSsymXyXwLxqq/UkF53HIL1G7KyUEouCzljzOYekkFQhsUujTO1i/BxkK1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1705698801; x=1705785201; bh=JdzgbrxKb6j20zlK8ja15pbzl7Zj
 uJOeNkYCKEiy19Y=; b=lq9JPO98FKLLsIWZhCRdU3BR6E4q031A+YleKClMyYa7
 sU+XPqUNZiNXAsHPRfPCp8MY7Poxanfn4M88WmK+4kmVQDe/gMS+L1mdgndFASSz
 AVLTd1Fjw7MFsM35IsS1zUJOIX0LORVnmeEbKSpg8gNN/E4RHFfow4qZ9fXlb+bY
 VvcAFUry3+usqZcMigeCxBKUgTZTA3Zw7l+mCEs2l16eBSfhVkv/H3A3IAIgvs8y
 2gSkyHFAcCVSH/hprMUYAtIacb4d0ghPh09HMXiBGtxUAJ+KLTQSKLQYGOuIz9Pq
 d69XzILPZAPTnfVI91ydA0rr6ijVdrMdFxP+JFgf0g==
X-ME-Sender: <xms:8eWqZblnhuJglOLfliOfTxOm2O1pnvbUOJKdzFJQ4kNbz17kmwj7kA>
 <xme:8eWqZe177IiznMm6rndYQumVTT6d2Inf3ugMZM4mmaHDyx48Kprhz6a49VPS9CFHz
 JxnCVgyqPeH-deIYQ>
X-ME-Received: <xmr:8eWqZRoK5H9GNScLPG3MBc0nWoYRPWDneER04WkAx5e7v5D4s--Tgy92Eb0w7cZdhp2AohhQR8_0TYdA-bzcvRdaPoSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudeggecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihs
 shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhephf
 egffejtdeffefgtdeihfefuddtgfeiteeuffeivdehfeejvddugeektdeivddtnecuffho
 mhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:8eWqZTkVB3ZrzmZ2waTPsBKrMZ9LvkUhYp9ZW_a-9r5Wsvv3kqBmpA>
 <xmx:8eWqZZ0D5djXBwXjAoZE_w9JsNkXhop9xI6ByqtIrdAjc332JUKMBA>
 <xmx:8eWqZSs0ZBafmfJEjGI8bjqAaVdPH3hwMKLxnMQ3uJn0pk5DHm2JlQ>
 <xmx:8eWqZTz23yCydPyCerdCKTvqLvhdJVDk9qs4TEdjqT1UQPHsOaPFVQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jan 2024 16:13:20 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 59316C019; Fri, 19 Jan 2024 22:13:18 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
 <87wms9d0fi.fsf@alyssa.is>
 <CAAfnVBmiaesEQkZOk4zf08JTh-WM3tqNT8RoyaL=49Lm--5HSQ@mail.gmail.com>
Date: Fri, 19 Jan 2024 22:13:08 +0100
Message-ID: <87cytxni1n.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.26; envelope-from=hi@alyssa.is;
 helo=out2-smtp.messagingengine.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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
Content-Type: text/plain

Hi Gurchetan,

> Thanks for the reminder.  I did make a request to create the release
> tags, but changes were requested by Fedora packaging effort:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2242058
> https://bugzilla.redhat.com/show_bug.cgi?id=2241701
>
> So the request was canceled, but never re-requested.  I'll fire off
> another request, with:
>
> gfxstream: 23d05703b94035ac045df60823fb1fc4be0fdf1c ("gfxstream:
> manually add debug logic")
> AEMU: dd8b929c247ce9872c775e0e5ddc4300011d0e82 ("aemu: improve licensing")
>
> as the commits.  These match the Fedora requests, and the AEMU one has
> been merged into Fedora already it seems.

These revisions have the problem I mentioned in my previous message:

>> The gfxstream ref mentioned here isn't compatible with
>> v0.1.2-rutabaga-release, because it no longer provides logging_base.pc,

rutabaga was not fixed to use the new AEMU package names until after the
v0.1.2-rutabaga-release tag, in commit 5dfd74a06.  So will there be a
new Rutabaga release that's compatible with these release versions of
gfxstream and AEMU?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmWq5eQACgkQ+dvtSFmy
ccCt4Q//UQr+nH1j0d7ULAajmQ5VQoItYeH5Y858UamGlRYwSK8VB2InHQULNTEs
iv7mkQdsHXUVKJQBwjk6vhNWPtU569OE6XOXg88usi5Vg0MdKwToW2dpX70Z3t9Z
gTMMwvjVuzjSWH7os2liJEedw8FYVbwjG8XacV2ULqt6wms822TPDBYoYInEvnpV
qPxmaWKwVdd4mO9sh5l3Ii+MkRihUkbwMbnq9WnP3FLemuOvvD1G0pkFaygqudGN
SLmh/m8lf8ARpW+4kbaTHAidIHQXulD7+f0s9fsqFEnPyGt0/I2wmI7dPqxdoFaY
4POaqwGndMJEUQ9k1txldJvMARQuJyr1IrGXFru7OoeFNacFB+ZrlkzpQfvR970u
yTqYQqWqxVPAiEBJmxmhVlrjpsFFiaZSi3/wad7kG6l7MfopZ9dQRV9TBE97vDtp
I559GZoUitqO2ZFItX/lnbg98ygIG6AsnQ6256c0wje+F98GPmJbdO3dgvvfxcpH
8CNm9CTZfXuZM7NJIiga/nzSlr7lo9e+vpY6LHic5LS4GywCIWbdPa8/U/6qzhZj
ZP8pK4YJeUbLU+UdffF9X4XpOJs89TAMkOmSYk0yDYVcwfUVfX4Sr8+KU3LT2pxM
e4MHFIaDZ2A8Zvf0KJ9k3aX4iks1baXWx7bkKELEAo+zQg6zj6I=
=qOC4
-----END PGP SIGNATURE-----
--=-=-=--

