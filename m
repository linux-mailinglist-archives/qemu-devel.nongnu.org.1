Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FDB76B82C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 17:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQqs6-0006zU-Kf; Tue, 01 Aug 2023 11:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQqs2-0006yV-At
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:01:10 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hi@alyssa.is>) id 1qQqry-0003eA-3N
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 11:01:10 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id D53E43200786;
 Tue,  1 Aug 2023 11:01:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Tue, 01 Aug 2023 11:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1690902061; x=1690988461; bh=rm
 5fpZk6EIdLla0xTAaJB1GZgwgYSd7SatNtFeemLDU=; b=VImkqr/ZlVuobqchb2
 Oh5Z7rEEpj7eGWRowJ85Re99MLKcxUO+PfRKLbOVudG8VBlqqsiKVujGd/M9VwTd
 lUN58THxCrMNzxcSnJfysBWCJ/dbYFDWolE7F80cdbI/X3N23uaotxcRtYMShPA4
 hPxjDJMXtGz1S2iYaK4ldSlPUa5keUa7xiSnHlsjGezoZvj2rBMzBGd/UsaVFwpN
 VNvIkyG4iu2774n8NTt+53tYnsLukC+ANDdyhQ7Q0sgbR6lj/Fxe1uCoNPiLuADQ
 eGFq45a1khO25/MOr4Hq0Z+oOJ1WOqDWVuSuXRHtJc5Y3j4+/NSuf1oATh7v7kcB
 jtbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1690902061; x=1690988461; bh=rm5fpZk6EIdLl
 a0xTAaJB1GZgwgYSd7SatNtFeemLDU=; b=f1bzlCvGkWtuou1Q55J2cyy52GsMp
 1zwuoIReshCnpTUY7iLjnFQ9K3x+RzKo0Qh/gSGRNFkTWespljDBZ1TLRyRBmrDT
 ldrpzJbNlD1v7PG3UP8vCKS6lsMaOP0wtP9suC8yyisOBi7XUZAYKJpbDWJ3qgIP
 B9Ts1o2J1CLhO4rYyi/weybyQto3MC/AWSnSIcUCDoi4o2bgsLLTaGGD3GSwWyRx
 HLd/RHCTEQHgiWAou0mbpl7IZmZaPbcEneO4XzKoO4hm/UeXb4J2ih+MJQ730Ds3
 EbMT2HZnW9hSe+9grn/vCUIwET9G2GyoXYBwrxkDhf74bh7HbmSyP/KHA==
X-ME-Sender: <xms:LB7JZDiWSxBfGYDeoIc-vCxu68fD_Lc5Oxg03jkOHtAR_lHa903LEw>
 <xme:LB7JZABiuyxohGyT7I8XeJFnVNLHJkePfQUrVijtGuSUcQoFgszz637w6O57aMS3P
 gIslrzyeiLHOLxx8Q>
X-ME-Received: <xmr:LB7JZDESNbV4eMtJmRpFE4td6SRMzuXY7KWP6C_eAuQij9te82yKh-OgTcXY2HmMvCpILhrKZ7rOAVb1P44>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeeigdekudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihsshgr
 ucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepieduff
 euieelgfetgfdttddtkeekheekgfehkedufeevteegfeeiffetvdetueevnecuvehluhhs
 thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihshhsrg
 drihhs
X-ME-Proxy: <xmx:LB7JZAQxAF4HZrZcZElgMwAHnfEOm8c64q5MjjmkcSu-ATt8hMmMKQ>
 <xmx:LB7JZAw7EhYN9upM1UogWg-Mbg5dEB9A0l0vDvWkqnn9AZtzmdRnHw>
 <xmx:LB7JZG6Ixh7n5u2JR4jFh3B_D6Orla28umumg7Fpt1Ko0lqLrBLQVg>
 <xmx:LR7JZDxswSzcxYaj7nWlf303zr7FcQkSK-pymfZRAe2VbNTxrc0xvA>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Aug 2023 11:00:59 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
 id 7A0E87566; Tue,  1 Aug 2023 15:00:57 +0000 (UTC)
From: Alyssa Ross <hi@alyssa.is>
To: Gurchetan Singh <gurchetansingh@chromium.org>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com, marcandre.lureau@redhat.com, akihiko.odaki@gmail.com,
 dmitry.osipenko@collabora.com, ray.huang@amd.com, alex.bennee@linaro.org,
 shentey@gmail.com
Subject: Re: [PATCH v2 0/9] gfxstream + rutabaga_gfx
In-Reply-To: <20230801011723.627-1-gurchetansingh@chromium.org>
References: <20230801011723.627-1-gurchetansingh@chromium.org>
Date: Tue, 01 Aug 2023 15:00:55 +0000
Message-ID: <87a5vabye0.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Received-SPF: pass client-ip=64.147.123.21; envelope-from=hi@alyssa.is;
 helo=wout5-smtp.messagingengine.com
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
Content-Type: text/plain

I was able to replicate my existing crosvm cross-domain testing setup
using QEMU, and all worked.  I didn't test any other capsets.

Tested-by: Alyssa Ross <hi@alyssa.is>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmTJHicACgkQ+dvtSFmy
ccC+bRAApywwWEG/W4aFgECTJ31aK9aVMfUZetumFUzhkBOKKz50XzFq7rTlUvAT
9o5gnyG30itQQNaVitbb+HF/zgFbPGVVmMq9La3BwtU8LTFUMPZnikoxAcKCyrm+
2vM3Y0fdXV/KwN9bJoTe+jFvGKFAiUuKOuDeIZLIRKiRBe7rmNT0g4q3LeStzpc3
PEvdChD7qgsEPz0WRp9HVWQBTFyUxJ3M6/XOf9wFvGuV+EFbaYxQNeuM6hN3KTIt
MsVsPrNsOoOJKWRPISYzErNNSRz5VAvDmU3W9ldHj1zFwxWalVuvPHBwrYB1ptx3
FSu3MReb7Ww9llCSE585/nw21eu8gEk2l2nzcSp9bM6tHibjUSJAEtAQDM02BjSs
K0JShZppfVWI8S0W6u73WKp6Nb8tOZWQgFTIYsnue2/dUEm8WOuN/4M7/PlnrU9/
W/ovxLrQ5uHXYGyV8sVWHYb6dok4LDQGeFK3eVdQcnZjoK+bnFx/YN8+0ih4z76t
m+Tpv33hZnhSmG10d0NIzm3rdcPqMmU1WnKsGf7mRigxUOMykK/a9vgFkUHiXv0X
tNWascy1gJG6jdRciNtetFiJ87VTlqd+/5k2GXt+mUf9m0d2XQOIp2P+3jLlcVQw
R2Z5iUzdwWl6cqSodSLP7DyR4EQ5FZf25QCVgQi6j9+Y8uMgPmI=
=/O45
-----END PGP SIGNATURE-----
--=-=-=--

