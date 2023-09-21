Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 189797A91EF
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 09:12:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDqp-0003q6-7C; Thu, 21 Sep 2023 03:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qjDqm-0003oy-1i; Thu, 21 Sep 2023 03:11:48 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qjDqk-0001Qd-AH; Thu, 21 Sep 2023 03:11:47 -0400
Received: from [192.168.68.112]
 (ppp14-2-88-115.adl-apt-pir-bras31.tpg.internode.on.net [14.2.88.115])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 585F320034;
 Thu, 21 Sep 2023 15:11:42 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1695280303;
 bh=YEOfyYBMEjXEsSB5+ijTzjaH2UDhyoRDH9AI+T7kK6M=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=msqie3g4wS3arYEbDG/rS4za+LctZfSTsUec879NwNX4MFdcQdZObj6NT4781QFoP
 Df6MXJkbIM5RJr1+wK+VzTUh+qBHTXs+1cgu47C50lRNkN4J3T6W3G0W6zdY/15Pud
 AVEdK4uTsbCd5yWQab+CENuWtSnnSvws6tjunDPzNqL3W5z+GZO9yTKn7v0/ifTxEq
 QFnykFznh4old/RqfvEukrQ8WQ8LzUfdGdIMdG6sTBRvwZQHs0gOIw9QtF/XlviVtB
 Anyg57GAT1O0T5w58ESAFn3a47an10iQVM0v/6Cb3QXnzMDOSbH8WChnHyXKVtowPZ
 A4DtRXCIM6c0Q==
Message-ID: <8c281addd173112061e9de7a3916c01493d138a0.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 1/3] hw/i2c: add smbus pec utility function
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Klaus Jensen <its@irrelevant.dk>, Corey Minyard <cminyard@mvista.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,  Keith Busch
 <kbusch@kernel.org>
Cc: Lior Weintraub <liorw@pliops.com>, Jeremy Kerr
 <jk@codeconstruct.com.au>,  Matt Johnston <matt@codeconstruct.com.au>,
 Peter Delevoryas <peter@pjd.dev>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>
Date: Thu, 21 Sep 2023 16:41:41 +0930
In-Reply-To: <20230914-nmi-i2c-v6-1-11bbb4f74d18@samsung.com>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
 <20230914-nmi-i2c-v6-1-11bbb4f74d18@samsung.com>
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

On Thu, 2023-09-14 at 11:53 +0200, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> Add i2c_smbus_pec() to calculate the SMBus Packet Error Code for a
> message.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

It at least looks a lot like the linux implementation :)

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

> ---
>  hw/i2c/smbus_master.c         | 26 ++++++++++++++++++++++++++
>  include/hw/i2c/smbus_master.h |  2 ++
>  2 files changed, 28 insertions(+)
>=20
> diff --git a/hw/i2c/smbus_master.c b/hw/i2c/smbus_master.c
> index 6a53c34e70b7..01a8e4700222 100644
> --- a/hw/i2c/smbus_master.c
> +++ b/hw/i2c/smbus_master.c
> @@ -15,6 +15,32 @@
>  #include "hw/i2c/i2c.h"
>  #include "hw/i2c/smbus_master.h"
> =20
> +static uint8_t crc8(uint16_t data)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < 8; i++) {
> +        if (data & 0x8000) {
> +            data ^=3D 0x1070U << 3;
> +        }
> +
> +        data <<=3D 1;
> +    }
> +
> +    return (uint8_t)(data >> 8);
> +}
> +
> +uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < len; i++) {
> +        crc =3D crc8((crc ^ buf[i]) << 8);
> +    }
> +
> +    return crc;
> +}
> +
>  /* Master device commands.  */
>  int smbus_quick_command(I2CBus *bus, uint8_t addr, int read)
>  {
> diff --git a/include/hw/i2c/smbus_master.h b/include/hw/i2c/smbus_master.=
h
> index bb13bc423c22..d90f81767d86 100644
> --- a/include/hw/i2c/smbus_master.h
> +++ b/include/hw/i2c/smbus_master.h
> @@ -27,6 +27,8 @@
> =20
>  #include "hw/i2c/i2c.h"
> =20
> +uint8_t i2c_smbus_pec(uint8_t crc, uint8_t *buf, size_t len);
> +
>  /* Master device commands.  */
>  int smbus_quick_command(I2CBus *bus, uint8_t addr, int read);
>  int smbus_receive_byte(I2CBus *bus, uint8_t addr);
>=20


