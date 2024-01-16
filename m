Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF26482ECE1
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:44:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPguJ-00018B-39; Tue, 16 Jan 2024 05:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rPguE-00017l-M6
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:42:54 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1rPguC-00063b-DA
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:42:53 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id 7B7CA5C00BD;
 Tue, 16 Jan 2024 05:42:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 16 Jan 2024 05:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1705401768; x=1705488168; bh=0D8nRRiQpf
 Ii2SW9oYND5WkWMVZoNXmDA5r+T/LntJs=; b=QtmNZfLkuqDxV5ZUJ3w9uKwh1Z
 c/SfF1bMXu87GRchobD0wJEHNYl+e/b//lFXr70qVc8e8UJoqzKph3MjfPgbHV6T
 pMaboiAjVLKX6ho5GPOZ7HDAng+bbIwGfx83tencR2vR+FFkZaef89UIVjqdoslI
 W5UCoyisa3Zo+mc28pkRfIgHgPt1fkl+bdJ0kCIkW5bIkl2i4X5QUQngFm1Tj85+
 5+edywVp+GeZwsf0SBMdgV2nstS9J6/mNxExKOJziGj0exDoQxYTiZp93/zssM3l
 JepW/oTCzUR5EK9c9kg/C45es/rLDzqQxM7KOa05/ypTbk/8BNVluJlSX5bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1705401768; x=1705488168; bh=0D8nRRiQpfIi2SW9oYND5WkWMVZo
 NXmDA5r+T/LntJs=; b=j1p396IVuSdTbs8fiKW6xq9WbFFTykJZQ7mZoPijK808
 tG9cuocj/aERGN6sXVQF2J23sXBlDmxHeecnKfXo795/OfTU0g2KhmZa5i07u4N4
 bjJ4xfQw4vBdDwq+swxG4+wm4+7uD9UdPfroAvkptviJJ+t7BIzgKpom9Lzgc1Mn
 PoadeGLU/v6MLYe71O6f2xR4i0mD0PidiMaKocRLORxV+C1ujyD/V7EMOV9i7+69
 eHXABwU/n4oBkExCS2WoUQdtKPgbGflp+tfMKIlI+r5Vjy1aeFZ730WdVA54Ni0R
 rbJjPuOS+2bzpCPhFd7CZgC2Yh46p+v4tRoQjtomkA==
X-ME-Sender: <xms:qF2mZTeTykYFu-RW0m4a3NAsx-aKnm52OAXcfLluNynNNz-NYFSywQ>
 <xme:qF2mZZM0LtVV0IVrKTrr31IRO-VFuliwXyFY0f3Zx-dufGyFlCM0GVsFfXyecGOXq
 38EJt9HGGzHs0BHrA>
X-ME-Received: <xmr:qF2mZcjMzDDMIM7FeqyGjaKJopuSrScI7OVDWL9v7Rvx5G38hlWaJYVSyKXIlVBbQsVbjhw2_p9OY6hAipFzPwP20SaN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgudekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephffvvefujghffffkgggtsehgtderredttddtnecuhfhrohhmpeetlhihshhs
 rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeeiud
 ffueeilefgtefgtddttdekkeehkefgheekudefveetgeefiefftedvteeuveenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihssh
 grrdhish
X-ME-Proxy: <xmx:qF2mZU9NckQJ6UdDEET6cFeCGBZ31-8R5FSsBS-LxbHGiT57aypDHw>
 <xmx:qF2mZfuoN9mFsL5H6FycT-4BDql7oN4HuuLiVH9SZttf27SlRSkdbA>
 <xmx:qF2mZTERz3BPilU5lZdE8ye4r3iPrbnEEAEt_ljT_XFIVmDOElwxXg>
 <xmx:qF2mZdJfgQo7DLDjEvJQtCu9YYTKBgAPGN4Fr0hUGT8xlOzpwLbiXg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 05:42:47 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
 id 4AAEFBCF5; Tue, 16 Jan 2024 11:42:45 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 akihiko.odaki@gmail.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com, ernunes@redhat.com, manos.pitsidianakis@linaro.org,
 mark.cave-ayland@ilande.co.uk, thuth@redhat.com
Subject: Re: [PATCH v15 0/9] rutabaga_gfx + gfxstream
In-Reply-To: <20231003204500.518-1-gurchetansingh@chromium.org>
References: <20231003204500.518-1-gurchetansingh@chromium.org>
Date: Tue, 16 Jan 2024 11:42:25 +0100
Message-ID: <87wms9d0fi.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=66.111.4.25; envelope-from=hi@alyssa.is;
 helo=out1-smtp.messagingengine.com
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

Gurchetan Singh <gurchetansingh@chromium.org> writes:

> - As mentioned in v14:
>     * AEMU: d6e6b99 "Delete VpxFrameParser.cpp"
>     * gfxstream: 2131f78d Merge "gfxstream: add egl & gles deps.."
>
> are the proposed v.0.1.2 release points.  If those commits are sufficient
> for packaging AEMU + gfxstream, let me know and I'll have official release
> tags made.  If additional changes are required for packaging, let me know
> as well.

Were these releases ever made?

The gfxstream ref mentioned here isn't compatible with
v0.1.2-rutabaga-release, because it no longer provides logging_base.pc,
and this email is the last mention I can find of these releases.

In Nixpkgs, I've gone for packaging gfxstream and aemu with your initial
proposed release points, which works fine, but it would be great to have
this clearer upstream.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmWmXZIACgkQ+dvtSFmy
ccCsuQ/8Ce/2Wq5K3W1SLtT3UviQat2chF8kX8nSwnfgAK1XRHPH3T/aACwkDW+X
mg0gBpXq37aZp+Up6JRNrkmINaeaipS6l320P78UtlmzT1KBaN0WfxwVMi4y1juB
I+nMN4xoEf93SUFkBjnU4flMydslDKXWaHkRxbGGTUMmFHwro4addeDbEBUVAerC
/jCxn2yfqQZBeensSZQLxQ65OEBJJZSQOLbwDB2MmaSBN1tTdXmZ6KsxVp4ahxOi
LfMoZSoIIfynY+mYMJcrILeHbwVHF3JyZxrWpf9gZjPBNi3bn4qu+B9eF89E0WNL
Yhur99MmKgJIEtn34nhsEqm74y1HVgU4Zg4uSrNFC8BspCQzQYOmIOU37Z+UXwA/
8iwjbwLKWyxgQBMmV26dDzoqmPylgFmEle5zicQFTxnuS6llcW3gIUJy+Cr2OhwG
nPAQSX8vys5ZcxtZyNII8z0ImkkneQgDwR3dFVjBJHffVX5+Ltjos4qatTmYAWTF
sNn/d0aZSyFptXdQdSUXZ2BCajtktkZ59obEGw6+UsN+Yz4dH2MuL6U5IUMwIgMx
hJMG0tPmGhx7Dd8MVxBCQysNlX8zdNdE1lxI3vsYXrNiPVVH6XnHtzR5HK5dDSdB
wAml0RAwNSUHjgZk6Qi9fgabPo7eQ360ruHjeY5HZ0dtQgYEpXI=
=8jvQ
-----END PGP SIGNATURE-----
--=-=-=--

