Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 950467AD298
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 10:01:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkgW7-0006HT-2d; Mon, 25 Sep 2023 04:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1qkgW3-0006Gh-9h; Mon, 25 Sep 2023 04:00:27 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1qkgW1-0008H6-Ty; Mon, 25 Sep 2023 04:00:27 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id F34F65C267A;
 Mon, 25 Sep 2023 04:00:24 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
 by compute6.internal (MEProxy); Mon, 25 Sep 2023 04:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1695628824; x=1695715224; bh=B3dXfWLZbRllQxksWoYPFj6NtfGWJR1k9X6
 pjadXcnA=; b=ajOO5UxeI7L6aIdygdPXNKJPeOlxkJmZMS2nJ9bJssl/RgB+nz6
 z6RpMuuPqS7BGh9bTihGo4vjs1lrr33wt1KGumEHKqgX7hZAH2oQSPZH3w82rU+o
 uYUZjJNPN+st0FaQlEbL9ZD0elRFQRw/S8Njj8BXnvJPJoIDMkjoI9si7oUOlOim
 nWr2+iQvO13jJQ+W/oMo0QCvhhnxBc5nSZv50H+M0Y6d1TVd3hORLIZYFNynZwed
 hD0GzZKvHKxkN0R2oBjd8OITjUYdcHuiuwUtLxvcuo7u1vxFuqiXZ718Q6hNJHFc
 h3xk62wwr8Un3tMsPTmjspf/T2bD7HmwLCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1695628824; x=1695715224; bh=B3dXfWLZbRllQxksWoYPFj6NtfGWJR1k9X6
 pjadXcnA=; b=fJLhF7n3mp4uVevt3CQLkgB0WJg6yWlNefJs9fHLw3/RTXsHAL3
 3EbDcMUqdjzWktVo/qbHZuRG4tBi8ek/ivQGU6EN4+CXG2hq52Bv+w5HiEniXAIY
 WYvid8BxTRQLlo63pv58s7QEshGlaVbLY69Q9LPuLoz0/JV9WpaFkoIG5muGZfi2
 MDXDKWTSK0JChdUwsoE+sJfQWXW+mNY8OPMp1QdvsV3d3RXQ99UUNvzbtPaB3yql
 aqdbznpZUyE9/KcB0yGm5i/u/wmAiTEDh3+lAao2snUPC04emjjAiN51LMl1xfp7
 uYUa6ZBuH9Ch9xjf2MxQ4N8tyuUUUSoushg==
X-ME-Sender: <xms:Fz4RZR7jfWiwMrCRpevgyVT5BQi0929uXLWh5PRUiuEywAC-Z-rNaA>
 <xme:Fz4RZe7DREMJeiwAAkgkZZcU7QIUcXx5WbzB_Q5wSe5-pWNnUsl5dL9Lq72CVRHI8
 HNU6ouPhkm4KbBmlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelfedguddvkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 tehnughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenuc
 ggtffrrghtthgvrhhnpefgieeitedtleekheffveeiteegjeegffevfefhffekvddufedu
 vdevjeegheehveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:GD4RZYeYF2enAGnUpYFjqZ-yadNIHP4ugtjwh6NW8eNYc9Slj4yGpw>
 <xmx:GD4RZaKnbAuzCBqAT5SajhjUNJYS7AZvZ_exEHpw660TSlP2cXldGg>
 <xmx:GD4RZVKwer1ERV_tajfNQ3_uH6fa6zCZkFeblP6zPb9-kH9Sp4ZYtQ>
 <xmx:GD4RZV1sz6FOiB9bOYlkut_uRvnRJBg7DuQx6sSqoBvH5BE4PFethw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E0D9B1700090; Mon, 25 Sep 2023 04:00:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <bde2efca-6449-4c67-b962-958e835bf963@app.fastmail.com>
In-Reply-To: <a79f00cd-795d-9f5d-5461-2ae532b2f82b@kaod.org>
References: <20230925062212.66112-1-andrew@codeconstruct.com.au>
 <a79f00cd-795d-9f5d-5461-2ae532b2f82b@kaod.org>
Date: Mon, 25 Sep 2023 17:30:01 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>
Cc: "Joel Stanley" <joel@jms.id.au>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9_via?= <qemu-arm@nongnu.org>
Subject: Re: [PATCH] MAINTAINERS: aspeed: Update Andrew's email address
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=66.111.4.27; envelope-from=andrew@aj.id.au;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On Mon, 25 Sep 2023, at 17:28, C=C3=A9dric Le Goater wrote:
> On 9/25/23 08:22, Andrew Jeffery wrote:
>> I've changed employers, have company email that deals with patch-based
>> workflows without too much of a headache, and am trying to steer some
>> content out of my personal mail.
>>=20
>> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
>> ---
>>=20
>> Hi C=C3=A9dric, do you mind including this in your Aspeed queue?
>
> Sure. It's on aspeed-8.2 for now. I will send a PR when I have more
> material for QEMU 8.2
>

Thanks!

