Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD307CD960
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:36:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3v0-0001vK-2T; Wed, 18 Oct 2023 06:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3un-0001es-A7
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:36:39 -0400
Received: from mail-dm6nam10on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61b]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3ul-0004jM-1R
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:36:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q9ljlUJ43qnwZT9rAmFONJmQtXA79ukYCFIUamydirI7IKct3K73u9+AWk4f1y9SHjUyxxDpArDHiDc5I2DefsJn/f12IuIUJrwD2ZzF6X30h40XkYKeSKAf0itaMqjEY3BYOUzDigSkEQmrmCURmhCCq2gX4cHK8dec604yCs3Ey0nevMhiW/9X3WQyUAmdkxK8YVwfJzDAWo76ow6z/TMuFt/mUzjrTFZYJTnX1bWrtC0CLr2thLPgIxit4iMSsVCxfuwm5485rl3gW3QGzA+X/M3gdW8zF8DUNaQjSgjmX6bqAcZdCPSxrrh14GYPwiM7gQgraVg3k7LhWrdkGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbOur1gRf/RsiXemw/9vIpPo07YzFfrOfkmaTvSqGcc=;
 b=e49kOzoRZ2o27vme9mSgCQgQUmb8GlIy0qoPg58tSSMQ3WGNxDAAkRhKZ2vJz8oZJIKtF9lnBBpG6UqqHRlNl1RnYcLiIOwdVMg6qrZuX3ErA0i/X6fGvzCg8mXLCbrSPfKgUbDGyFwAnbNQRK+8+DdRXnnDctHaKjsuEyWO4XGAQ+0joWIQiQWWrbffIA7mDBpnNNO+YQc2Npfxjao6ubvrwkkeT2hNDeQ+s+4Ql5+DRI35gLYXlm/4pasLwnPsDPOG9JZxUxJk08y1S6xuRVCRkGxwR0pj5iTNDHvHbp+UX/L4qIvHj61/uqnerTII6FIbhOH4A/uUGpUh+QwQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbOur1gRf/RsiXemw/9vIpPo07YzFfrOfkmaTvSqGcc=;
 b=KnLRH1LF6rRnLgD+Ub3KWRnS+oSqk3e29DcWTAHh/KY97RxxsATex2GNhA5sWv/2ZSM+rhtQ6hkC5XnytrHRMO9VmsVjH6FYSh6uQKFvk2ReN7p2UoFIzwLg5xkphB2rZYkeE+1ZGesS94OuuvZVh1ZftvwfX0tDFMizk5T22MY=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 10:36:27 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:36:27 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "Iglesias,
 Francisco" <francisco.iglesias@amd.com>, "Konrad, Frederic"
 <Frederic.Konrad@amd.com>
Subject: RE: [PATCH 11/11] hw/net/cadence_gem: enforce 32 bits variable size
 for CRC
Thread-Topic: [PATCH 11/11] hw/net/cadence_gem: enforce 32 bits variable size
 for CRC
Thread-Index: AQHaATJrQn1RQCk+ckigX5XKzH2HUrBPW26g
Date: Wed, 18 Oct 2023 10:36:27 +0000
Message-ID: <DS7PR12MB5741C42E9F56F65FD6CA44DEB6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-12-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-12-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|SA1PR12MB7126:EE_
x-ms-office365-filtering-correlation-id: 314b6e70-8f8e-4b5e-a172-08dbcfc61593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7k804zl8oC7FntpkIw6IqtyLbQ1d33tb0yMKfkoFOUAKMLma1lA/EUh9HtofN5KIVBOfBHz4XngJDoEUj3aa2S83FJxb3WZQ1TQc2KZtQNKucguGLUw7e1ZacGdQhPS/bZZ8jIUNjXSdRlo2Wa1aK6MeT51TQ64pslf/qtAnuIVe10VmQPLBAAt/dPmeRYENv3JBZcnbihULWM7dcGJ2w3ySvuruImlzAOn1cbA1mi8A24/TuGMF0AfTECFfacRJ0A5BWHvexxnnsQhKoVP537rV2gACpFAEV5rQWZwvovd6BsPiTkWCm+Jvn4X8RAZYxpU+p3CgroyuDcb/agpBINR5Cm+1h2jsrkc1hHp4TLeo5d8k70qwolfMEZn2oXtNrSpvLpccOED2UgTrfbsIIZ1ogQvtNcy/WwqBKLFyWg9xj78b6+csdfVzSJtcSLjZ9AFuriLOfxntEKk7fAmvntAAoFyG/vsdEq74Ma0NvAAnizpyz7ky7Q6cskWtv1eXfQc9TONhNLEt1hJHvCw2H1N97exH0eMS/RZ8/JhlcYFrCP8ferM/xFJ2lIv6Ia/amiUtZ7SCmIlwMdz5L3o9XnrqY0oJWuWXi9qHrFj6IN6GyC5hhE5YRb0fshFHQENS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(55016003)(33656002)(26005)(122000001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(478600001)(52536014)(110136005)(76116006)(66946007)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(6506007)(7696005)(38070700005)(9686003)(41300700001)(71200400001)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?H5SrVV6nOnqDJvujxIZ2qUFmgJACY5awdKXHis+J6VFb4oO+h4AvxBo2hc?=
 =?iso-8859-1?Q?wyqmjgTIaPpn9havV0o3OHmEt8Z0lcgGL7WPLFrgXoYtfGARPtIvAlDuHw?=
 =?iso-8859-1?Q?JjZB3momgmPEOnQr87frYylVFiW0ybwaY7e4auz7hXb888X/TvlZoGgUms?=
 =?iso-8859-1?Q?4RMCvnKdVMs2ujR1mHYhbOILhpgPVnkcxvPB+tYI8DZY0Ijk0iq4OpUvcW?=
 =?iso-8859-1?Q?y1sLghoZR1PPlif+tEXakWs/yR69GNgPTBTqhRqtZK8wBUFJRFiDUSqVvP?=
 =?iso-8859-1?Q?VmNro50odZA+5pvHug9RHObmQH4VCYyIF9JBoqfz7s05Be3nFOy9sIHmEy?=
 =?iso-8859-1?Q?EXVcYtVHIBDUf0AsqqSNlH2u4JcvZdXVhhHXORDZc0e4vO+5ss3rj2yaj3?=
 =?iso-8859-1?Q?vjp8LiaeEqeY8j5V/KpfrV2EB7s1oDHWEm/WQS695ChsGQJbPIZ61kNKWw?=
 =?iso-8859-1?Q?32JtNJIwk1ZwHlPY5s+6jxNPXTbbH3htJszQapVzADoCbk13xDtwdn95gs?=
 =?iso-8859-1?Q?iMOMvk69++k2Ujei6RJ8JvvcqeL/wsB46odFw61fWzBVf290saSrIYxaWn?=
 =?iso-8859-1?Q?pl3CPQ1HEHkcl1/FkOURdo1W4gU0kOf1qTTk15uCFZAnfAIvowxmiZtz4v?=
 =?iso-8859-1?Q?cN+MCWRvaSwm5af4vpbiOKQY9b/AIRhNTPIjMxbWSnr/jxHFr6o2AOTe7r?=
 =?iso-8859-1?Q?Iv/yUH6PFry7VqZgPgLmPSHkAVgt/sDB1mu3rAFefuR7vN+hg+2tMxGjtn?=
 =?iso-8859-1?Q?IXCSjEmFicSNWXPjVmWugKaT4j3uLf7PF9ptnRxanyCZ/2LXuX46ajkC9E?=
 =?iso-8859-1?Q?gim77UAa0ochNBt3vv+LVWmZ0Utlsg9abvKJnmAQlr/du5Cg/gF7QG+8bZ?=
 =?iso-8859-1?Q?hEzNQHXAqgqBGQVIqOWnG/OaQcmrtTLDVMmpY3Gj3DGiF2bhemQE2mW7RA?=
 =?iso-8859-1?Q?tHAGqNw8CvntEhyLwdmMRwkrUq2CZBA9zsvUOaYq2QaYBAlffaX0JtQGJE?=
 =?iso-8859-1?Q?tkF0q594MrJl8yMeyU+KJUIxywvau2M5JLWJA4sSRjusOee7ihyTdu0XH+?=
 =?iso-8859-1?Q?+I4rsQ9nsKM9xejZuTacpj19JzCkleFiro5gP1RXlal87ZyR2UCO3Wdqbr?=
 =?iso-8859-1?Q?Z0iTsalgFqm2RnmpXFc9WxiROdHtdYxxCuIqEYnOyiQNK2bCoXcqr/nYlK?=
 =?iso-8859-1?Q?C5AAhOq9EI59Xvpq7vxpqDgnsh8KQWDRujt+afB1uCUkdu7LuM0l5BsFH/?=
 =?iso-8859-1?Q?8gP5a2MqrNpOrbpjlyAsFBYFqpgvvlS9IbxxNfILTtFzQpolUl3PSws0Ev?=
 =?iso-8859-1?Q?tnRvrmpiFJ8DNoB1A2GoU9b4jkcztweGc53CDxxuN5gsSS26hKiWKql2h0?=
 =?iso-8859-1?Q?3CFjsn5MrAgOMJqg+YxtUyepHZRf1snECI/bIW7Hx2J3iG/BfD7pEpVf57?=
 =?iso-8859-1?Q?cgzb96XWk8jMxvgZYCOJ6RnkVxsl1iLXX4wPv/OO5cbkFampXEifP5ushY?=
 =?iso-8859-1?Q?Ze9/Un+r66A8J/oUJaenwrzUiW8Td9+sBuHuFWNSMaOJEK6hSIoxQpFv6n?=
 =?iso-8859-1?Q?RieDTBOvvjxWT9ma0exdBmxW9/dQMA4jL7A7i68oV5XqZHZrSaPPM4FBR4?=
 =?iso-8859-1?Q?+IetdTOdbdao4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 314b6e70-8f8e-4b5e-a172-08dbcfc61593
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:36:27.4920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3GAIPsj9BhKn3UycqKzzDqcjAzsBhkLNWlHBPlxyNMqWpkd4OZF3m0zLzz2ld6kw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
Received-SPF: softfail client-ip=2a01:111:f400:7e88::61b;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



>-----Original Message-----
>From: Luc Michel <luc.michel@amd.com>
>Sent: Wednesday, October 18, 2023 1:14 AM
>To: qemu-devel@nongnu.org
>Cc: Michel, Luc <Luc.Michel@amd.com>; qemu-arm@nongnu.org; Edgar E .
>Iglesias <edgar.iglesias@gmail.com>; Alistair Francis <alistair@alistair23=
.me>;
>Peter Maydell <peter.maydell@linaro.org>; Jason Wang
><jasowang@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
>Iglesias, Francisco <francisco.iglesias@amd.com>; Konrad, Frederic
><Frederic.Konrad@amd.com>; Boddu, Sai Pavan
><sai.pavan.boddu@amd.com>
>Subject: [PATCH 11/11] hw/net/cadence_gem: enforce 32 bits variable size f=
or
>CRC
>
>The CRC was stored in an unsigned variable in gem_receive. Change it for a
>uint32_t to ensure we have the correct variable size here.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com


>---
> hw/net/cadence_gem.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>21146f4242..d52530bae4 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -1103,11 +1103,11 @@ static ssize_t gem_receive(NetClientState *nc,
>const uint8_t *buf, size_t size)
>
>     /* Strip of FCS field ? (usually yes) */
>     if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, FCS_REMOVE)) {
>         rxbuf_ptr =3D (void *)buf;
>     } else {
>-        unsigned crc_val;
>+        uint32_t crc_val;
>
>         if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
>             size =3D MAX_FRAME_SIZE - sizeof(crc_val);
>         }
>         bytes_to_copy =3D size;
>--
>2.39.2


