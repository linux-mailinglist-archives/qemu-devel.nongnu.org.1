Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6467AD033
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 08:32:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkf7o-00036x-KR; Mon, 25 Sep 2023 02:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1qkf7b-00035x-SA; Mon, 25 Sep 2023 02:31:09 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@aj.id.au>)
 id 1qkf7Y-0007I4-2x; Mon, 25 Sep 2023 02:31:07 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 5735C5C02D3;
 Mon, 25 Sep 2023 02:30:58 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
 by compute6.internal (MEProxy); Mon, 25 Sep 2023 02:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
 1695623458; x=1695709858; bh=awLDbtd3e+lrkkCJOXgn7E13WDcyQAcTU7l
 611G/7dg=; b=I1/9godh2MzfEZ60ILPyCTNJBW5Bo+jQ1HKLPrN5gbGDUU4DESR
 XEpQZ8si7iPaBCyROOuh5WGtE6mEDJQ7TOYCEAt+RstusLWd4Qky5mXaQycyl8hU
 7Ncaa5F2BWE6q8cfDcLr3Go1ENwvIDNqviOzRJRJK8iw/KBf0tw2neVrz9surP/v
 ExY+0htdsbQpTggTLAT7WV7Ext4vJGjRgUDx42YalTjYoh2SbDDP6xVnQ7RMJ3QQ
 re7fTS2Oq6sG1qi9blBj88nJXtGC88ov4NOkZ7EWv0Agx2bUNbU/+z07papUFSn9
 Z5O46G9NnHK7vA92PPWja+zl7SRdO5emE1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1695623458; x=1695709858; bh=awLDbtd3e+lrkkCJOXgn7E13WDcyQAcTU7l
 611G/7dg=; b=QEw/EWGDISGTxQnIaFCvD1I9mulz516jB1BQxXvwKse36cNi4FA
 NUDG+qWfG8VXw89hYM4k2sdEJVE3/dEO+vxJsCdu/ONjKsk5weMQ4jblbJNSLrOZ
 ZRlEuBA5pfm+pcAC33ItWnOae4mx8lQc76MvyCGYPe+W5S2Yyqi8NLEw5qIlroCp
 gKBCcTmZnliTEulhn7uix8qEZLW8PHVxUtuypChgvI/cci+uJNd6SF1k0+Yr8GHp
 L3FGnGEusnLSk5Nj6YvvnNt1lRD/Tjjx40CHLc4DulIhf8JRM+mHbomJDgtDUeW1
 RUsxuBJuuQrdzwNVr7PIUww5UxSI/yQoavQ==
X-ME-Sender: <xms:ISkRZTX1EmTzdjpo0t6PPmDlKcTl-1dsqLST7Met0W5KIcrV005sMg>
 <xme:ISkRZbkhMu_TGhcH9L-wH9oV138Cqe0YgfrWRloieUDl0Ggod4ZyHBFrgJ4jIl5EI
 8LD6Z7Tm8gpoNskaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelfedguddutdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
 tehnughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenuc
 ggtffrrghtthgvrhhnpefgieeitedtleekheffveeiteegjeegffevfefhffekvddufedu
 vdevjeegheehveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
 hrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:ISkRZfbpkF5xgZOFPFVN7QlA-WRyqpDgKf4S6DCxeugNSJ8uHv0Q9g>
 <xmx:ISkRZeUNkr0QgT6wKxD35yfIJREnUo1unmaUX3_hzMeKKOTBEhE_cA>
 <xmx:ISkRZdlsC5H5ER_kxYzvArOAAlfRFqp3ti9foWE1GMJ8e8PNuZxRCw>
 <xmx:IikRZThQ21IHJWUXFfltcGtZh-uFyhOg_37XXF-N_i4hfWp-DRVpSg>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id A65C21700089; Mon, 25 Sep 2023 02:30:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <9b0bf077-5a68-4479-a84a-f9995f20c4bf@app.fastmail.com>
In-Reply-To: <1a6c49b1-5e5e-481d-96d8-8c08d5aefcdc@linaro.org>
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-4-clg@kaod.org>
 <1a6c49b1-5e5e-481d-96d8-8c08d5aefcdc@linaro.org>
Date: Mon, 25 Sep 2023 15:59:26 +0930
From: "Andrew Jeffery" <andrew@aj.id.au>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9_via?= <qemu-arm@nongnu.org>,
 "Cameron Esfahani via" <qemu-devel@nongnu.org>
Cc: "Joel Stanley" <joel@jms.id.au>, "Markus Armbruster" <armbru@redhat.com>
Subject: Re: [PATCH 3/4] aspeed/i3c: Rename variable shadowing a local
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



On Sat, 23 Sep 2023, at 03:58, Philippe Mathieu-Daud=C3=A9 wrote:
> On 22/9/23 17:59, C=C3=A9dric Le Goater wrote:
>> to fix warning :
>>=20
>>    ../hw/i3c/aspeed_i3c.c: In function =E2=80=98aspeed_i3c_realize=E2=
=80=99:
>>    ../hw/i3c/aspeed_i3c.c:1959:17: warning: declaration of =E2=80=98d=
ev=E2=80=99 shadows a parameter [-Wshadow=3Dlocal]
>>     1959 |         Object *dev =3D OBJECT(&s->devices[i]);
>>          |                 ^~~
>>    ../hw/i3c/aspeed_i3c.c:1942:45: note: shadowed declaration is here
>>     1942 | static void aspeed_i3c_realize(DeviceState *dev, Error **e=
rrp)
>>          |                                ~~~~~~~~~~~~~^~~
>>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>   hw/misc/aspeed_i3c.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/hw/misc/aspeed_i3c.c b/hw/misc/aspeed_i3c.c
>> index f54f5da522b3..d1ff61767167 100644
>> --- a/hw/misc/aspeed_i3c.c
>> +++ b/hw/misc/aspeed_i3c.c
>> @@ -296,13 +296,13 @@ static void aspeed_i3c_realize(DeviceState *dev=
, Error **errp)
>
> Alternatively:
>
> -- >8 --
>
> -static void aspeed_i3c_realize(DeviceState *dev, Error **errp)
> +static void aspeed_i3c_realize(DeviceState *ctrl, Error **errp)
>   {
>       int i;
> -    AspeedI3CState *s =3D ASPEED_I3C(dev);
> -    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    AspeedI3CState *s =3D ASPEED_I3C(ctrl);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(ctrl);

Hmm, I feel like `dev` isn't an unreasonable or unusual name for the for=
mal parameter? Switching to `ctrl` isn't my immediate preference.

>
> ---
>
>>       memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem=
);
>>  =20
>>       for (i =3D 0; i < ASPEED_I3C_NR_DEVICES; ++i) {
>> -        Object *dev =3D OBJECT(&s->devices[i]);
>> +        Object *i3c_dev =3D OBJECT(&s->devices[i]);

Maybe `s/i3c_dev/subdev`? I dunno. That bikeshed isn't gonna get painted=
 on its own.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

>>  =20
>> -        if (!object_property_set_uint(dev, "device-id", i, errp)) {
>> +        if (!object_property_set_uint(i3c_dev, "device-id", i, errp)=
) {
>>               return;
>>           }
>>  =20
>> -        if (!sysbus_realize(SYS_BUS_DEVICE(dev), errp)) {
>> +        if (!sysbus_realize(SYS_BUS_DEVICE(i3c_dev), errp)) {
>>               return;
>>           }
>>  =20
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

