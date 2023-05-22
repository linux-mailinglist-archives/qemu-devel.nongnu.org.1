Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9294C70BE9A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:43:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14sm-0005u2-02; Mon, 22 May 2023 08:43:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q14sj-0005tp-Uh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:43:22 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q14sg-000184-Nf
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:43:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 4554C3200077;
 Mon, 22 May 2023 08:43:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 22 May 2023 08:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1684759395; x=1684845795; bh=9/3hUMex5j9dkxiF15z+pbS5QYvZrR7yhTL
 NjuM6te0=; b=B5IwIA7fNm6CHptqg8m6syrpv3VP9+xmAIVygShaFwKhkufOg55
 /1nCMipLMvYHNuAJonUhkzCGX4QfeSYL2O9Ewmt8GcCKtautF4zXyLbpdZa0OpA4
 qYjpqvDqHqFM9ppd7weOiGCaLsr91dguXhqT8bZZN8bRw2npMw8Vmo4FYInIDNXt
 jXxMVz9/TCxuyK1b56vxSlBLR5fjmZuIdGUkekQlxSFMJ2/rpLLZ/K7j/oe39vNc
 yD2gX8/uM2FuSL2ZYb97IiK/vjUp46TmVWAHK5Rt8kqKYxjVTlm5BO++JZSP0Jtv
 WyFjtuFlXST4pvZr20cNXNWWwO76glOqd0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1684759395; x=1684845795; bh=9/3hUMex5j9dkxiF15z+pbS5QYvZrR7yhTL
 NjuM6te0=; b=W5WnymMftFJ/WKGEQiaiD1sT2saAX/SBsjwqe/mH2qY0/ANSwqL
 ifyCP7rtwLzNjb+A4O4tNywYuKOIR/Qwr0HaRcKAV/XC2l3RXuv2iuc/lrvnqN71
 3szOKq3hykdgb7oDy5hmeX2J8Rzc4CrItqB6urlz5seibFnYS110MQpHfbk/A8iq
 c5p6o74VPmoKmrLrt4CZ3uNc3u9IeV5why4wB/MokaTnv5p6ZtsRWeGjNkLX2UEM
 1N4pvsVjnPtRblZ+4rTipQoxzLBr9vOUXhJqE/bwnzRFxuezJI2E8yIBuZSF4uNQ
 S+KAo3BBP+BbPaVuz8i1sw1cbhWucDhUKvQ==
X-ME-Sender: <xms:Y2NrZHG-mt69D0C-RLLlktEzaO_BiUtuzWrZ1gGiulV4xcFP2gU4hA>
 <xme:Y2NrZEW4HqWkPYKLtUBEdTqhmPGTN4t5zFAZXvQLR59nvjfernhC92BF4PLVxsNp9
 S7zLfui1J1FugIFhPs>
X-ME-Received: <xmr:Y2NrZJLLnpQ8PCTlR4rxCSXfMn3d9yq_Zi8TcS1-jjXN2Ad5KCn31lY1x9q44TVw5EKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddggedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnheptdelfefhueduleekheeitedutdeigeekuefhtedviedvfeej
 udehhfekfeekjedvnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvg
 hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhg
 sehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:Y2NrZFFF_X1gMNflFK9xy08mo7HtmuOUhIhexlzGHLBr1g-eDF8xYg>
 <xmx:Y2NrZNUNDZL4rhy0rLWsWxnEHphEJpSNJskJZ8dmK4C5Bd3kKgoxQA>
 <xmx:Y2NrZAPePuFzn8lA_fASWi7Njnwl1Y5KN2ZBcgdCm643o0pzJ0CtQA>
 <xmx:Y2NrZAThFe71DqCx0FqswBbyzPTQe3Qhs9vAAsS_zel4EaWyu1JhPg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 08:43:14 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH 2/2] hw/mips/loongson3_virt: Remove CPU restrictions for
 TCG
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <543abfb5-87b6-e4c8-a88e-72c9369a6b5e@linaro.org>
Date: Mon, 22 May 2023 13:43:03 +0100
Cc: QEMU devel <qemu-devel@nongnu.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C79AED5B-6E5A-41A0-9F4B-77A68B4D966C@flygoat.com>
References: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
 <20230521214832.20145-3-jiaxun.yang@flygoat.com>
 <543abfb5-87b6-e4c8-a88e-72c9369a6b5e@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3731.500.231)
Received-SPF: pass client-ip=64.147.123.21;
 envelope-from=jiaxun.yang@flygoat.com; helo=wout5-smtp.messagingengine.com
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



> 2023=E5=B9=B45=E6=9C=8822=E6=97=A5 13:08=EF=BC=8CPhilippe =
Mathieu-Daud=C3=A9 <philmd@linaro.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On 21/5/23 23:48, Jiaxun Yang wrote:
>> After implemented CPUCFG and CSR, we are now able to boot Linux
>> kernel with Loongson-3A4000 CPU, so there is no point to restrict
>> CPU type for TCG.
>=20
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1639
> ?

Potentially yes, although I think the issue itself is just a question on =
usage
of the board.

Thanks
- Jiaxun

>=20
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>  hw/mips/loongson3_virt.c | 4 ----
>>  1 file changed, 4 deletions(-)
>=20
>=20


