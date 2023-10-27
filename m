Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3672F7D8E6A
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwFx3-0002Rw-7p; Fri, 27 Oct 2023 02:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qwFx0-0002Rb-Mk; Fri, 27 Oct 2023 02:04:07 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qwFwy-0007RI-BG; Fri, 27 Oct 2023 02:04:06 -0400
Received: from [192.168.68.112]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8AAD20038;
 Fri, 27 Oct 2023 14:03:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698386636;
 bh=j37K8FxIXu/gC4Ll3V0MQsq6GE3o5InyQ6X/EJ2m94A=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=Xx2NDsX5k1SWeyYVoTJ7bSGMLnFjc+Fn4x5r6myB0FMW/wvwymx/Pcpica4eV9WGp
 qhH5tL52yYwl02LJ1p7QFheTklaxy3Nq/7dqFCLUkVZLSGAZZbHkMowRPTde3djXLH
 HdnWXD4Y64GfM9udjfaXcjrrziJeSQep690SGnuwFHaq2djHtzfd2zN81apYLNL+aE
 ZqG59g5UqlYCA/KjvZvc1xtmXSEW+IkMwiERI2YbNhI/IHyQ4fCjB28ZxMOWvOHsoA
 3LArFlMkDyfleXGk7igo/dhhZqztjRyGOYpW1rNJyaQ0+i67By/QAUPgRsxYSnP9qs
 bGFt6BW/mv/GQ==
Message-ID: <ba4267af6624c203322b88ac9228675c4d18eef0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] misc/led: LED state is set opposite of what is expected
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Glenn Miles <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, clg@kaod.org, joel@jms.id.au, philmd@linaro.org
Date: Fri, 27 Oct 2023 16:33:54 +1030
In-Reply-To: <20231024191115.4134426-1-milesg@linux.vnet.ibm.com>
References: <20231024191115.4134426-1-milesg@linux.vnet.ibm.com>
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

On Tue, 2023-10-24 at 14:11 -0500, Glenn Miles wrote:
> Testing of the LED state showed that when the LED polarity was
> set to GPIO_POLARITY_ACTIVE_LOW and a low logic value was set on
> the input GPIO of the LED, the LED was being turn off when it was
> expected to be turned on.
>=20
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

