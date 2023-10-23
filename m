Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFE7D4369
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 01:46:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv4bu-0001vt-ME; Mon, 23 Oct 2023 19:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qv4br-0001vb-M3; Mon, 23 Oct 2023 19:45:23 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qv4bq-0002cs-0w; Mon, 23 Oct 2023 19:45:23 -0400
Received: from [192.168.68.112]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6D45320059;
 Tue, 24 Oct 2023 07:45:18 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698104718;
 bh=3ZHK3vEh8ndmFxb4KjOUtanJEShBbkCR4uH7p9d7RHM=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=nEsnu3exw7p+L8vSjk047B044xcI46cu3zE8Uv1NTsMC5K5A1/clWiHZ085VMWDYi
 Fhr6RdcUmhUezcXVl6655V3vUuLQTTrNr3LgShWe8iBhs8vhHmlYv26CYTUfR+Y/y9
 WG0GeTMRMBJyTR5J0QJK6pGOBn5ji95Yt5Ks+huno8QRf/xuRhai3hT0uOUlL4iX5v
 ThO0oSOeemh6423abWoaoxMPxkVFkuB/NReeGHcti/ZhZco2REzoY6vjtjbGoR22qh
 VU6nfJVp0rm3viTOuNET85ChM+gtiAYKc48mAD82HDMHHZB77TE9HIGCQbSQ0VKcqp
 z5VRxUeca+jkg==
Message-ID: <3bf8cd017b5d1386e1ed15392c74ed647b993011.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/3] misc/pca9552: Fix inverted input status
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, philmd@linaro.org
Date: Tue, 24 Oct 2023 10:15:17 +1030
In-Reply-To: <20231020182321.163109-2-milesg@linux.vnet.ibm.com>
References: <20231020182321.163109-1-milesg@linux.vnet.ibm.com>
 <20231020182321.163109-2-milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Fri, 2023-10-20 at 13:23 -0500, Glenn Miles wrote:
> The pca9552 INPUT0 and INPUT1 registers are supposed to
> hold the logical values of the LED pins.  A logical 0
> should be seen in the INPUT0/1 registers for a pin when
> its corresponding LSn bits are set to 0, which is also
> the state needed for turning on an LED in a typical
> usage scenario.  Existing code was doing the opposite
> and setting INPUT0/1 bit to a 1 when the LSn bit was
> set to 0, so this commit fixes that.
>=20
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

I sent a Reviewed-by tag for v1, don't forget to collect those on your
patches before sending out a new set. Something for next time :)

Anyway,

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>


