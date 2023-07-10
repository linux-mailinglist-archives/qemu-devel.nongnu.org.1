Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E9574D614
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqTT-00004t-8p; Mon, 10 Jul 2023 08:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1qIqTQ-0008Vx-08
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:58:40 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1qIqTN-0000B6-MI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:58:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id 7970C3200925;
 Mon, 10 Jul 2023 08:58:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Mon, 10 Jul 2023 08:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:date
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
 1688993906; x=1689080306; bh=q2ujNrhV942HBINBsQt4EQrco8FvM/B8ttB
 r12JV0yg=; b=G++0rszZrWRw0/+k27JR8zNoDN9zKT6ajtb9+6zZf6U/saOdOqB
 f38o4nerbmLVrXJuZ/5Nhc4/6vUOT2Zn8U2gGmYpoSlR+4kl8srfPsrMnuiBCqlM
 xncQlqN+57ZBBFQuVdt1rmA6A9f4eopECh8FxqFtbbTaefBbAOU8bauDqzPsRWaV
 bvAK8gAod8wnJLznCxQ4cLjTRPQwfSbJp/9wAgWx0ptWNq59ICF0H6mDG57VRcU+
 UHWAp+YxhJzlw/PA6po5v5v2U91Sn1cajSyq5jkd7D8tm9zr4ii1gVGGuEIsC/Yp
 PvXZN013x2vum65JfyMbOWxMj979fgrPwDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:content-type
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1688993906; x=
 1689080306; bh=q2ujNrhV942HBINBsQt4EQrco8FvM/B8ttBr12JV0yg=; b=T
 AJBqZ973yYaZ7F1EtPQzSm2xc2EWbhssuEDHXKyDA2KOsHLiMfd0Do2ECyg3NsGn
 b/3wZ/C3ntP+LYHeQvBxiX4GfoSRsXWTX4AomGP+EOiixR4MRjXfZqSvJCiH32ke
 na8nH0slRdFxgtTDUYhrII+TPiwLHNgRYc9Vps69GMvy4rHdV2306i0XkAHvee5Z
 BQbv1F/aW/TJy2iGHp0wER1d+WZTmurSZ5s7Ja2dayoEEb8RIK/RxqF8ewVaH6FF
 2wECCfakCpkcsPpnetmDrQW+w1dOdvFKEAykVdPZoPFVQSCUtNYkMvlOwhMd0OxJ
 bO/bCbCN5eiie8nOe1GUQ==
X-ME-Sender: <xms:cQCsZKMgoQ4YNsio16LCethJV7W-vlSHgu8dEdhf8QMFxbmpwvWIoQ>
 <xme:cQCsZI9zJ7bITUoAWARZDKiM_DciW7WAQYiHkOUF9nWx_V3unuW_JwUVBGg26m6j7
 BAaOB2FQk3tn4yqxgg>
X-ME-Received: <xmr:cQCsZBQG04HmXSSA473CBVaDVTkaVISG1N9nwhTwUi5l2I8Wu3WBlukoNVp6cOerVhKC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrvdekgdeglecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfhfhfgjtgfgsehtkeertddtfeejnecuhfhrohhmpeflihgrgihu
 nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
 ftrfgrthhtvghrnhepheeiuddvvefhkeejfedttdekieethfdukedvieeuueelgfelieej
 geehvdekudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
 homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:cQCsZKv6ohUs7spOaZE-jGByP6wFm1SexZd0hR2I6H2r-Ctg1WZ4tw>
 <xmx:cQCsZCchgj9kqu91GpQfGwVBbNxR1PeMurdSWOWdb-6ic7stkvWWog>
 <xmx:cQCsZO3DC9cDTWwYILoqeTU5V44XMFJ25GLSyGlUUWjG6I2shyr8qg>
 <xmx:cgCsZC7aHXHjPNJP8dH1xWocAhiRUEdnUNSerOd1je19goXuflBoRg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jul 2023 08:58:23 -0400 (EDT)
Message-ID: <ee19d8a2-733a-23c9-cce9-db8b8dc0e253@flygoat.com>
Date: Mon, 10 Jul 2023 20:58:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] target/mips: enable GINVx support for I6400 and I6500
To: Marcin Nowakowski <marcin.nowakowski@fungible.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
In-Reply-To: <20230630072806.3093704-1-marcin.nowakowski@fungible.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=64.147.123.21;
 envelope-from=jiaxun.yang@flygoat.com; helo=wout5-smtp.messagingengine.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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



在 2023/6/30 15:28, Marcin Nowakowski 写道:
> GINVI and GINVT operations are supported on MIPS I6400 and I6500 cores,
> so indicate that properly in CP0.Config5 register bits [16:15].
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@fungible.com>

VZ is unimplemented in TCG so perhaps we should leave them as not supported?

Thanks
- Jiaxun

> ---
>   target/mips/cpu-defs.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
> index d45f245a67..da122e72d7 100644
> --- a/target/mips/cpu-defs.c.inc
> +++ b/target/mips/cpu-defs.c.inc
> @@ -709,7 +709,7 @@ const mips_def_t mips_defs[] =
>           .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
>                          (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
>           .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
> -                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
> +                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
>           .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
>                                     (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
>           .CP0_LLAddr_rw_bitmask = 0,
> @@ -749,7 +749,7 @@ const mips_def_t mips_defs[] =
>           .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) |
>                          (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
>           .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP) |
> -                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP),
> +                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_GI),
>           .CP0_Config5_rw_bitmask = (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI) |
>                                     (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
>           .CP0_LLAddr_rw_bitmask = 0,


