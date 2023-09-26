Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D7F7AF162
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:55:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBKb-0007AC-3Y; Tue, 26 Sep 2023 12:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwd@defmacro.it>)
 id 1qlBKH-00079E-ON; Tue, 26 Sep 2023 12:54:22 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jwd@defmacro.it>)
 id 1qlBJy-00054n-Nm; Tue, 26 Sep 2023 12:54:04 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailout.nyi.internal (Postfix) with ESMTP id E2F955C2642;
 Tue, 26 Sep 2023 12:53:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Tue, 26 Sep 2023 12:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1695747239; x=1695833639; bh=yC
 7ibexyvBI5MwQBs0b5M1FwVot7kTNft09nB/WcWI8=; b=cZ+n3PFVBMbiQlDOxq
 5qitIQlIPPln2YDqpd5LxOxEQ+mW6E1TPCBvGdZmSdyBjdCHzzGcttQ2YH2qPMNu
 pkqN4XwpkmE3jlpKdcQBHP5SxQnoizxqAFRahX8H545p2rNu60UgxfROm8MJbbvG
 fEygE9xLeV2A3QkkRCWOkzuVZwzQigROAlnUvH46pYXywW9nEIV3ZgsxbeqpZ1aC
 YuWtgPQz51p5Yp/IG0eQYqeAcRJJ2cL31+mMs1hE4Sz3OX6q9NyoNMACaCM5ZvFK
 Xk28upl7N13M1pE3253HSO7LGC4VcURSl1SAAgCzdTlCTjCJFwFLBQ/gg8kVOgYW
 WCjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1695747239; x=1695833639; bh=yC7ibexyvBI5M
 wQBs0b5M1FwVot7kTNft09nB/WcWI8=; b=aC0ofFr6nFJMMj8RPjqiUJ9ISg6Bf
 wFxS5Nvo3ldHvCW8nlQ0Zs0/S4RIbc7yrgl0WXtqrYUJBRBuxzEuL5O2IE4DVjwp
 f2prPjrkdj+Fb2VyxlLYJkLEZ6T6v9i9qTCP0tePV+/OvAgzZFWyhktc5x1Nlgqn
 1jBCSQZIlV6afdabie2ipi2LUfZ3jDpR99h1Uif2iDnVwIb21e6UPRqLE+z3qfqz
 W0GxgU0Hz8BkiyEvtdkXuQOte4twJA0ds8XqAN90Uerg1gueVK6OSTSAwx9qRZnY
 Soa1pWx9/QrqbY2Q7o8IboaPGwJMcIMjC7b9BTh2vrrLkIZNJxLqVWZ7A==
X-ME-Sender: <xms:pwwTZWPlhmCNmps6N7g_pVQsFO2lvYKZDfIjEUJ6LRtKkr4YqXL06w>
 <xme:pwwTZU-5wOQRTpGd5vgMldOeiK2Fp2jY_REoHXU3LPGVfpLV-EhE4iOV3sGxsXd2j
 2WwdA3X7QSTPdqGnlk>
X-ME-Received: <xmr:pwwTZdQ4wNoXcyY1enEiehG93CZzwACDIvCXjmRUW9RzNTzKTmTtqgLJzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdejjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpeflvghsphgv
 rhcuhggvnhguvghlucffvghvrghnthhivghruceojhifugesuggvfhhmrggtrhhordhith
 eqnecuggftrfgrthhtvghrnhepudfgvdfgvdefiedukeegvddtueekudetjeetvdegueeu
 kedvheeigfekgefghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
 hilhhfrhhomhepjhifugesuggvfhhmrggtrhhordhith
X-ME-Proxy: <xmx:pwwTZWsWOleH4mO1RIHOw55XyMDvw29jJ0RR4ATfvl7GRx-qcvibkw>
 <xmx:pwwTZedxxwT3QyEVt0UvQy_R26P_FsgAxwA3P3XFTF7Rfb3nuMcGmg>
 <xmx:pwwTZa2lGw3nOH-ko8ZdyQgd0Q2r8XHHv2M4JbszE_jeQERJf0aMqQ>
 <xmx:pwwTZd6PWbNly1vnraRBYjICacEeixW4ZdxXVSATY0zpDQtfEEocPg>
Feedback-ID: i0f41475f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Sep 2023 12:53:58 -0400 (EDT)
References: <20230925-fix-local-shadowing-v1-1-3a1172132377@samsung.com>
User-agent: mu4e 1.10.3; emacs 28.2
From: Jesper Wendel Devantier <jwd@defmacro.it>
To: Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org, Markus
 Armbruster <armbru@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/nvme: Clean up local variable shadowing in
 nvme_ns_init()
Date: Tue, 26 Sep 2023 18:51:12 +0200
In-reply-to: <20230925-fix-local-shadowing-v1-1-3a1172132377@samsung.com>
Message-ID: <87jzscswnv.fsf@defmacro.it>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jwd@defmacro.it;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Klaus Jensen <its@irrelevant.dk> writes:

> From: Klaus Jensen <k.jensen@samsung.com>
>
> Fix local variable shadowing in nvme_ns_init().
>
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
>  hw/nvme/ns.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
> index 44aba8f4d9cf..0eabcf5cf500 100644
> --- a/hw/nvme/ns.c
> +++ b/hw/nvme/ns.c
> @@ -107,7 +107,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>
>      ns->pif = ns->params.pif;
>
> -    static const NvmeLBAF lbaf[16] = {
> +    static const NvmeLBAF defaults[16] = {
>          [0] = { .ds =  9           },
>          [1] = { .ds =  9, .ms =  8 },
>          [2] = { .ds =  9, .ms = 16 },
> @@ -120,7 +120,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
>
>      ns->nlbaf = 8;
>
> -    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
> +    memcpy(&id_ns->lbaf, &defaults, sizeof(defaults));
>
>      for (i = 0; i < ns->nlbaf; i++) {
>          NvmeLBAF *lbaf = &id_ns->lbaf[i];
>
> ---
> base-commit: b55e4b9c0525560577384adfc6d30eb0daa8d7be
> change-id: 20230925-fix-local-shadowing-9606793e8ae9
>
> Best regards,
>

Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>

