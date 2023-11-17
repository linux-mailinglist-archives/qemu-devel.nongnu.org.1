Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAED7EEAB8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 02:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3njn-0002xj-EZ; Thu, 16 Nov 2023 20:33:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r3njX-0002su-C0; Thu, 16 Nov 2023 20:33:24 -0500
Received: from mail-tyzapc01on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2011::600]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r3njU-0000jk-2J; Thu, 16 Nov 2023 20:33:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P9tAsWs8yagIkX1gyZbf22EsoM73GRbxBLbThpgC5iccnsR90f9x6uzNGztgJ1YRNU9hlyUtKdosoVq/q5icNmSiJAwEfTPMR5P2QD/i3AnJiCZU2IggU0ckWgq2566FBwojwq1FQVHdkt5lNSW66OilsxAsyb557EAidGQf80xtXDTLu6VuX++yZ985zOTTTdIYf34CAFWrCh7zjNB3kITofJZNjsoE62I121Pd4BaBA5cvCRTEz1+w803dGq9Vafig+EFZZ3z69hAsC69DI41e7o+D33eDonR4AL7SKBkCTMwB2TCRPdRrxOeBz058/e2DM5kroNZ+shtUfK8WKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5mqW4i3PJrCa+DJExIIF7f3QNjV/bsmML5DQMxdP8E8=;
 b=QWU8oPopj7AfMc76gU2vGSwxPR9/V81vl+MGBQAJUqs9fgfG61JBeYR1YjO7wl0YOULND9+4K/Y5vq9DLAqwwesjayhfF3q7vrX5Zqrp1JX7KOJs7IIKWkVfhY2MF0gZemnVk9+WahPj713xx2MG32epNc7t7jXvWT4v2cyBZJcx6UO1oZlCqdhN5nY4KjK1MNpllZ9eNsdsQJNRPQiaRy2W9kEcwoGJ9ql3xu9D3pABybVxoos3lFWB8qmdMqZvhqqPyEhMG/lhmxF10eHJjNWtyxbNFNLmrQeEYVoN88CM9JkhSNf0Hg3c033MNxMGsLHis4TfQK+p7rcGUk9GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5mqW4i3PJrCa+DJExIIF7f3QNjV/bsmML5DQMxdP8E8=;
 b=Z9D11qlfycuWYjCIPweXSXYJGfHEvYmoK06uhaUxPLpxDrxiNteCgp++fOP2XnUGM9Dn/IhhkIp6TBbeP75xHQuFa+W3BEht8I0RpjqTk5t8PPAJRwp49SgKtkXDD1HtO0eXU/PJ+DUp6aRYuVdHXIioQAO1lacpGX5+bVxZ6K4=
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12)
 by SEZPR03MB7417.apcprd03.prod.outlook.com (2603:1096:101:10e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 01:33:09 +0000
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b]) by KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b%5]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 01:33:08 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Nabih Estefan <nabihestefan@google.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "wuhaotsh@google.com" <wuhaotsh@google.com>, "Avi.Fishman@nuvoton.com"
 <Avi.Fishman@nuvoton.com>, "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "Hila.Miranda-Kuzi@nuvoton.com" <Hila.Miranda-Kuzi@nuvoton.com>
Subject: RE: [PATCH v5 03/11] hw/misc: Add qtest for NPCM7xx PCI Mailbox
Thread-Topic: [PATCH v5 03/11] hw/misc: Add qtest for NPCM7xx PCI Mailbox
Thread-Index: AQHaCP7Q61gwJ7Nz0k+5kv3ABox+AbB5IF6wgACghACAAPRM8IACi7UAgACYwFA=
Date: Fri, 17 Nov 2023 01:33:08 +0000
Message-ID: <KL1PR03MB7744B1E8D67CA72BCA412826DBB7A@KL1PR03MB7744.apcprd03.prod.outlook.com>
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-4-nabihestefan@google.com>
 <KL1PR03MB7744A70A81045E5DC49C8191DBB2A@KL1PR03MB7744.apcprd03.prod.outlook.com>
 <CAFEAcA_9HT=tccyTu9RffMxq7Cm5GEanM+OcSxfkpbnJW2m6hQ@mail.gmail.com>
 <KL1PR03MB7744B774223D04CF466EC2BEDBB1A@KL1PR03MB7744.apcprd03.prod.outlook.com>
 <CAFEAcA98TjKa7tK+dgp7d0R4BcYv+s-jo+AwTn0L2RFYZkm09A@mail.gmail.com>
In-Reply-To: <CAFEAcA98TjKa7tK+dgp7d0R4BcYv+s-jo+AwTn0L2RFYZkm09A@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7744:EE_|SEZPR03MB7417:EE_
x-ms-office365-filtering-correlation-id: d9a0714f-0cb3-4c88-467a-08dbe70d276a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M90zUmlXqFzO8Dkmt9qfKlimxwzxXUG9bKn9iJefKxDgQjIdWVyKbA68AvZKU6zZmpwxbVd/9wltr/oWHPBQ+DIlrcfWfZzIfqnH4nTnhEXtTfU49D8pYFwUcJ/wFH21bwAvPiYxGcBlnztkCQ2X/N+dG3PS6IIvcMm0Nxyi6YYjAvdhNsgvzijUqd+GrvZLPKPgI6pcMYjUWbrWtf54f7iveTLpA19WzGX9Bkm7TM69r41U3JQz9nLSfjuD2UXzdC7HUVJRhI2ZZEOG7lNQCtjYb1N9Uc6pInPCy4QHALYAZQbxmPbuyrkhCMZvpJeUJSFcM/q0Skx7tLDtIlJNY/IA7hqhXwZahlPXLaz0iwgEmrcmlgUqpGk1mh0stR86XAMFKOrC2YLW2cAlRCG3SD3Zx9uOLlKUHW14Z3vE+tVP4gWsbYmdXrXEuVrMxPyACx4VL/30XvFpK5nA3DbJ5016DlsPKVcB3Er96Wppimug0yNbUHh4We+8L5oVpfivfT+06uAEoqGQnLVBCBon47TxmNrVcg9KWyWDwVtDFmBoCWGqXM54ObqfVuDNsTRimKuloOTDqYRG6SS+TRQOMt9qv4+oOZ9dar7VgZkTt2RfCbihKxEb9cldkpwSFNG/FTAumH4f/GOg4pNPCjA1Hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7744.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(15650500001)(2906002)(33656002)(41300700001)(316002)(107886003)(54906003)(66556008)(64756008)(66446008)(66476007)(55016003)(71200400001)(38070700009)(8936002)(52536014)(38100700002)(8676002)(76116006)(66946007)(6916009)(4326008)(966005)(478600001)(86362001)(5660300002)(122000001)(83380400001)(7696005)(45080400002)(6506007)(26005)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C4SlteNtG7olhhoZxz4kGN3RNSp3YK3yaieGARzvzdxsz7A81ZgSWE7NEUDn?=
 =?us-ascii?Q?A4z240rcR2QOL7YalfrBTWitiVq7ClPm3LkGG/KEWndKs2tZZeyD+/92Hc3o?=
 =?us-ascii?Q?/a02+BUB1Yiop0Sqp6gtG+IZA4+rwegoeTgAeBiHtH6f0nof4qfClPV1BJ+F?=
 =?us-ascii?Q?wdDg4IzQPHbJ1AlOhFwE5YW771w5J6qnoGgDOoMMADSj5FpnkwMJyvFLXNOU?=
 =?us-ascii?Q?Q9aIYhUkEpFl/NkY3ztypBcoML+MMJCV46i6lXAO2B2C49CoJtr7L8EakOho?=
 =?us-ascii?Q?SVBAXNki/yYuIhWXiY2dHhP/fMWTAVAUoI33bElBI3HMShqnhdI1yrbpLDi5?=
 =?us-ascii?Q?9iC+KXf5KP5qEaowj57meoLaRDyanft1tQUg2PdrpOIxcVInZOo5TNH0/w4T?=
 =?us-ascii?Q?6MzaEIz7B2HU2pilJxvpY8wC5sKoZSQXD95a1A0B7/AxvtQ+2uSb0yS961MT?=
 =?us-ascii?Q?UKP7ke+dKJu7DuLUN1TU8uhEE8iaYSz4sowT8MJJmACbX2bi0WSd3bxemgrD?=
 =?us-ascii?Q?+z/SrqQHtFvByz2+r20NvUWG/nrD95sTKy5lJbBT2D2p6f8UroAXREr5Dtlm?=
 =?us-ascii?Q?ayOD6uCM+8HFK7VHrbeFp62c2Y3yDgYDfaZmzHEWiBYnLVANe2T8CUrddJT+?=
 =?us-ascii?Q?MrRJ6PrbJRHDNmXgy6HlEo5uTzpX2VddmmAAnJWybbKOMlwguASt2Ks26ndT?=
 =?us-ascii?Q?9bvzv8qOQZd9VZAbmVqjIsE4+4R1QwF2SlwA+kItpg5b7Xn0RNcYn/uvRv9i?=
 =?us-ascii?Q?ZUBtRwRI5xen2l1eXMHxHw++e7VnzGDamJ3YyksF1ezLv3BoW+5XZLiubBHA?=
 =?us-ascii?Q?vHdiSrPM70OC6eaL4Qu62j9KqXg2NT/tUeiXAUqFtmUfEQ2uMNm4tXi/x7ig?=
 =?us-ascii?Q?7E6BC2scy9Hf9OfM6QDPjDNTWAwNv/dGYxoo+PmvBSYx93sg58QaNEDnGd50?=
 =?us-ascii?Q?L5knXkm/QYcO2IANjeSIUs+cDHzzNOTuNMC8qUzq2FKM8sPIxiRRF4UfINaI?=
 =?us-ascii?Q?hYGm6qxmaoPpucGjiouQSmgtGlZk4Zzup7A94s7qfOYzawELJhSf4AYl1lHx?=
 =?us-ascii?Q?kQaS6EEOqh0XpH8/bRvpF7s4HtSsljpD4z6nkP13kOM7vMHPgbg1YYsLdTBY?=
 =?us-ascii?Q?2nqNMzAl+c1R44ZnXtTPjlnhu+yvFq9lrGhlrvlVEakVYbeNL4h+yglviyCa?=
 =?us-ascii?Q?W5dPNXo2A6yEW7LcL+TXVeaOhpW7zZnL/yMBJPlNnbfscSuDHpwyzDzHdLwi?=
 =?us-ascii?Q?Fsy1gryb3qQJ3Od6mb+gYV3yWm70tu5UOKnxYw1rsuBhFAZgMaLHj5VhXgfe?=
 =?us-ascii?Q?K150rfslJsnxuVDAjvRznuMi7DbhgM6zd4Y1O8TxfsrzrP3F3FGb6DzcYYTR?=
 =?us-ascii?Q?PLbCUrgwC4C2nx7KFvIXvdO6d5vAtLwfMNKtuibqapxzTpMjTMp8hmvLGUYg?=
 =?us-ascii?Q?bGRjpYLPW9DDFecyN9vVcLaVo/0RgmHtdaE2fAZM+3Z6op0SVpuqzyF0K6Jf?=
 =?us-ascii?Q?lka3IEW84aQhJBfHaS6Qu9jtSA8IyDRxZwQSaIGxwMdl+xfhc0aNpj4Y9npM?=
 =?us-ascii?Q?58/W/svlKNoX5PriRATdfiU+GpGgRXMlL04sQDUB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7744.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a0714f-0cb3-4c88-467a-08dbe70d276a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:33:08.4897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Ll+L5RcZoBDjUrAPR/mfoKGRo0FpvNm0JGudV/1hDQksXUjNXkugRo/vpXKRuvD5Dlz1QYM0X97Ob116iB+jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7417
Received-SPF: pass client-ip=2a01:111:f403:2011::600;
 envelope-from=KFTING@nuvoton.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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



-----Original Message-----
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Friday, November 17, 2023 12:25 AM
To: CS20 KFTing <KFTING@nuvoton.com>
Cc: Nabih Estefan <nabihestefan@google.com>; qemu-arm@nongnu.org; qemu-deve=
l@nongnu.org; wuhaotsh@google.com; IS20 Avi Fishman <Avi.Fishman@nuvoton.co=
m>; CS20 KWLiu <KWLIU@nuvoton.com>; IS20 Tomer Maimon <tomer.maimon@nuvoton=
.com>; IN20 Hila Miranda-Kuzi <Hila.Miranda-Kuzi@nuvoton.com>
Subject: Re: [PATCH v5 03/11] hw/misc: Add qtest for NPCM7xx PCI Mailbox



On Wed, 15 Nov 2023 at 01:35, KFTING@nuvoton.com <KFTING@nuvoton.com> wrote=
:
> Peter Maydell wrote:
> On Tue, 14 Nov 2023 at 01:24, KFTING@nuvoton.com <KFTING@nuvoton.com> wro=
te:
> > Signed-off-by: Tyrone Ting <kfting@nuvoton.com>
>
> Hi; can you clarify what you mean with this Signed-off-by: tag?
> Generally we use those where either you're the author of the code or else=
 when you're taking somebody else's patch and including it in work you are =
sending to the list, and it doesn't seem like either of those are the case =
here.

> Thank you for your comments. In the email thread " [PATCH v4 00/11]
> Implementation of NPI Mailbox and GMAC Networking Module", it says " Hi; =
I'm afraid this is going to miss the 8.2 release, because it is still missi=
ng any review from Google or Nuvoton people."
>
> Is it okay to post "Acked by:" or "Reviewed by:" by someone from Nuvoton?

If you've reviewed the code and believe it to be good (i.e., it doesn't nee=
d any changes), then, yes, by all means please post your Reviewed-by tag. A=
nybody who has done the work of code review on a patch can send in a Review=
ed-by tag to say they've done it.

If you've reviewed the code and think there's something that needs to be ch=
anged or that you have a question about that, you can reply to the patch to=
 say so.

We basically follow the same process here that the Linux kernel does; you c=
an read about the various tags here:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#using=
-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

The meaning of "Acked-by:" is a little more disputed; personally I use that=
 for "I haven't reviewed this code, but as a maintainer of the subsystem I =
don't object to it".

thanks
-- PMM

Hi:

Understood and I'll use the Reviewed-by tag then.

Thank you for your advice.

Regards,
Tyrone
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

