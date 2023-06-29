Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B754F7426E1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErHb-0004lq-Fz; Thu, 29 Jun 2023 09:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rma.ma@jaguarmicro.com>)
 id 1qEnlA-0000i0-Ce
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:16:17 -0400
Received: from mail-tyzapc01on2060a.outbound.protection.outlook.com
 ([2a01:111:f403:704b::60a]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rma.ma@jaguarmicro.com>)
 id 1qEnl7-00038r-3t
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:16:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9oz2lxbotNTqt5wsT8w1P/Kmaov0sRNkiUqexeUNEHHBhkhd9q+aelojzJavMY4ppsmI+xLC9oKgTKtFvt/n/XrUbi8dK1RRqN2Rgu/BymKch9GZppbGrZxAXZvJcICynG1t4dsSy1DyCMgBmaWYmYTM9PPejpPAY7LNzbRriPXmLMIOudoka2qx9rj9cxH8DDD19fAcsOa9smgJufg4tHTidr3LJE2bnxPH6I5Y2NOeSSr3mamVuzx+5k/tT9y+iKU639ucQLoZwlMU6I5KRfiGLOaKMOicaI29Bcb6Go0uU7G7pXzolMRGK48/8UO3o1YgujMheBvS1OgsaAXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+wJxvBWyvdPEE10bLPehz5yf5UcFmPswnD2WTaQ6pE=;
 b=Bp15c+DSuwy58/zwYPB2EJMYRBc62efx/yjpLMxTomNPgHeBwIzbNbzXlZ3UrFOnqABN2CIxEwTT8so+TbO56DJ7WlX4r4vO5dUwVD98ZehuwMIjli5C8YS2D0iTeOi6vGOoCQa4M0adQnNF+SDPckzkmajRt10IWSAuNy0LQGzWazdJrDbokEHUQXrG2pSIJo7tF2ALRdTLdeZmmdWBj2iNPRVpbLJoS0FaO9EkM+7IpvnbzE4eSa5IKfDp30uASSABTSiyUjWdCbObks/EkyFme8a66UgQeQfHIDo01ISrUMZq51kcsDimOL09EEjGcsWqAijy5wlFmS4CA/Y26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+wJxvBWyvdPEE10bLPehz5yf5UcFmPswnD2WTaQ6pE=;
 b=M07PgkyUgq2cVKIXrPQ4Ktyn4rdUSdXOvH8VXGvxVeQWabxSz+kLbROfuaFg1S8D2pMKMQexx+cNrC+3FQrJ5EqpfgK2epwXNJe8b0XJ3uMVNzrFcl9FEk18njhie+xso1+QFNxhlWwYN2LDDGQRVJdTBm46pvnYsEhBPWzY0wbpipsW0GZy5jSkyTU68akamHZK4z8vewGUuqpwoBASmuGth/wD9RjNRr51cGhBVVPfWViB+Tvdzak1ECYYs5xiSPgNnibGwGB7v84Sd8CoMlH7ZJ7SwHXHKiqB7l8DWUr2OGMerJ4xLjzN6Q3zdfsnNawmGosAsXWM4wWwgjwJkw==
Received: from SI2PR06MB4752.apcprd06.prod.outlook.com (2603:1096:4:14c::14)
 by SEZPR06MB6531.apcprd06.prod.outlook.com (2603:1096:101:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 09:16:05 +0000
Received: from SI2PR06MB4752.apcprd06.prod.outlook.com
 ([fe80::25f2:1ee4:9de:7b00]) by SI2PR06MB4752.apcprd06.prod.outlook.com
 ([fe80::25f2:1ee4:9de:7b00%3]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 09:16:04 +0000
From: Rma Ma <rma.ma@jaguarmicro.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel <qemu-devel@nongnu.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB2aG9zdC11c2VyOiB1c2UgbmV3IHRocmVhZCB0byBs?=
 =?gb2312?Q?oop_backend_channel.?=
Thread-Topic: [PATCH] vhost-user: use new thread to loop backend channel.
Thread-Index: AQHZqlac5jAoMce/bkWPzBcuI5OAnq+hXdYAgAAh1dg=
Date: Thu, 29 Jun 2023 09:16:04 +0000
Message-ID: <SI2PR06MB47521E154DFBC4583DAD0D969925A@SI2PR06MB4752.apcprd06.prod.outlook.com>
References: <20230629065415.8211-1-rma.ma@jaguarmicro.com>
 <20230629030821-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629030821-mutt-send-email-mst@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB4752:EE_|SEZPR06MB6531:EE_
x-ms-office365-filtering-correlation-id: 31e8c0dd-cfe1-48cb-1611-08db7881773c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3IPHJ9Lp9f4+BoSgoaoE5LP/fD5zk2dj9wtr5BMW/Sc12FE5SaEGDLxUybMg0LFsxHoq2i7halWnHn/11u/d//E707Kj+CLeL8nhEGU8uRTGQ7ohWBf+zyBOo2SPJpX012YvrWxm7Wy7iY/SmmkzO1Ub34lbsvTRv8aHv5X6GHUDuNNQ3mpm1qXxAzIgNyi7K68YyRAkVcuylqnTtW1sqmJJQ3a8DEGHgL/3SuHXfzcl57KEi1n7iO+s2/BepRq8FqfZOZ+zxV6VPl6tN8NnQ5VhmraRAZUQ2FPJ8uIkwmS+sfANHisCA1b5bXcky5cnLf9kqdoKp/Snyy24yyD2X186vyeVhP5FbDwpW8HUa7bwAByFFmVDByqT77EQojLODSdsncd2MPdhua8iAPwp7hLYon6eE/aDRnEkuNTiXu4K9TcUf1HCiH9c9fsqcSTVMkPOAfQ0Yzb53u12zGCKH0fMXWM2q0c5qFIRRmKrdUg2hi2Fs4hDn5LelSCNJLcirW2R77/uRRzR1qOKoPeY1f7YpqhvoQSRhAFHmZcZwYwfan++NNzEDjqjKDb94x2E2ilo9Ql7xHx/NmCchgPyRmo5migrvi/voC4xZoo0BPbcZM3QXV75ZsjN0Esum1A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4752.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39840400004)(396003)(346002)(376002)(366004)(451199021)(19627405001)(316002)(66556008)(33656002)(66946007)(76116006)(64756008)(6916009)(66476007)(66446008)(4326008)(38070700005)(224303003)(478600001)(5660300002)(52536014)(8936002)(44832011)(55016003)(86362001)(41300700001)(2906002)(9686003)(7696005)(6506007)(186003)(83380400001)(38100700002)(71200400001)(26005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VXppNk5JNTFDU1BrRUxWb2JBRWJlZERwazVrZHA1bmpKclVzb0NpU3RsRDZ1?=
 =?gb2312?B?dFBHa042NUhuTjQ4eHZzekhoeHFhcVZPOTc0M09HYkdXdC9CNnF1QU5ScWlv?=
 =?gb2312?B?NVB0VDJJb1BQQi9DTkRha0FHM2g2U3BLU1JYMEdhVWNkNkJRY0hLcisyM0xF?=
 =?gb2312?B?anJ5Y29IWEI0THRoeHNpZGM4bUhyNEx5clpCRnJrOTNUNkh5bnArRWdndGtr?=
 =?gb2312?B?K0V6UUZ0K0FVdmJLd2pETmRKS2NjZXVMcno3ZEpINHlVOGdqSjlDdm5ITThU?=
 =?gb2312?B?bDNSTURhVzEvc0RVUjRSR1Fia1haR05oUndzamZCdi80a29VUk44Z0wrcW5w?=
 =?gb2312?B?K2N0MkpRNXlESkw5cnJYVFlZWUVDWHBNOWtkbHI2VGVmVkx0bDBlazV0SkU1?=
 =?gb2312?B?VzdIYUVGM3VLRkJ6LzluUzRSSVFydXdlWU9vM1A2ZlU2QTdFblJjeS9JajdH?=
 =?gb2312?B?SE1UVWFFL283c25PMlQ3ZE95NHlJQngwekJRT3BHL1pOTFU0ZHo1YjNxVEkw?=
 =?gb2312?B?OXRzUFJMdElQMmxkTktjZ2FSaFI0WGZ2ckY4b1FXaFduVmNkcU9nb29YUkZy?=
 =?gb2312?B?NzRUa0xDNHVxd3pRblNUU282S3FrNnpjVHFvZ2ViY2FoWGcvMUtjYTVkQ1FY?=
 =?gb2312?B?bmNWdkxuMjJZM280ZzdNMU14Y3oyT0VIQUVVbk1lSkFaSHRYYjFDU2hudisr?=
 =?gb2312?B?UFI4bk9ITWw1ZFlGamh6bGkvL2dxd0U3c1c0VHU0dVY0OEJRdzcyMDExRjlW?=
 =?gb2312?B?WTZVcHVXYVJMYTVKZEgwU2VseU5RaWxWOTd0YTlvMEo4ZllWVVBvdUc3L1ZJ?=
 =?gb2312?B?RnlNNGJvNU5QNFVUTmZ1Y0ZkR29yanBTTzFLQmhmendhQ3k1VkNBcWpNNTNO?=
 =?gb2312?B?VUprUGVkS3FPRzRkSGVpL2s5MEw1Q2xkYWJQTmFJbTRsR2Q4N1NqU3M2aDdv?=
 =?gb2312?B?YkZDd3ZDRGcyN2lJbTdVS1FyWUg2V2lsMTdKYVJ2NHlyd29SQTFmUGg5eGRQ?=
 =?gb2312?B?enZYVmRsNG5DcmZkbFlIUDFOZXRIazc3TlRZaW5YNFNjdWVPdnRiYnVYeXlC?=
 =?gb2312?B?SzVjMHVSY05iWXZIZGtmZGFuT2EyUm1aODFCWlVQRWhYMkJTWWg0Z3lXNlM0?=
 =?gb2312?B?UUQwaUVzL2tFckJjWVo5OFFPdHF4QVYvTVd6bVlKR2puUlhlU0tLL2JzQ2U1?=
 =?gb2312?B?Y3Qwak5JemZXYUFkZ0pCc0JOMXV1VFdtb3J4R3B0dDF4VExHTVpYY25HUjVX?=
 =?gb2312?B?ZWU3MXRhZUhpaWJ2Tm9EOHJsZWpFUFh3SW03bk1GUmcxeng1amVwd2F5VzBX?=
 =?gb2312?B?U2F2OGdrVmlEbFExazNUOE5TYnFTTmovamVzTU9Eb2VtY3pLbUNRU05JWHlo?=
 =?gb2312?B?VjhRYXg5WXljR0sxWDRBQWhGVmprVTRaK2pvMDczdzRxWjFMSEpTdEtPVTJo?=
 =?gb2312?B?L014MDZlYTRDN3QvMTM2RTcySmhNcVpQclhldGovQ0xRZTEyWXdDdG92RWxw?=
 =?gb2312?B?UlloSXg5T3R0djc4RGhORHJYMW9TeVZ2SFRBdzkyNHh3bmFKL2QxUXgzK09K?=
 =?gb2312?B?ZmlrM08wSXh1MUpNcU53MThYeEhDb2ZLNkMyVEZERGo5b0FJQTJnS09SQ3ND?=
 =?gb2312?B?aHhPc1VoRkhZMG1YOCs0R0YyNjJkREZ0SVNNQlZjRDRZVjFSOWdKT2pWYWZU?=
 =?gb2312?B?Z3ZrcVlYNGdxN1Y1NzdxSXR0dUY1czVJOW1NRUZKYVNaMEwzOStWMzVJQy91?=
 =?gb2312?B?S2tHbEdwYUgxeERRU1ZOeHMxcGd2MEZQUFJVbFhhTkdLekdneU8wZFhWUnN1?=
 =?gb2312?B?MlFBV0hSa2orWHV6QVVjbW9jcXcyVHp6VzhYc3NwR2xtYi9vbzlTMEliNnlj?=
 =?gb2312?B?UmVjUHluSU8xWmFHZlBYOUcyeTJLRXlHaWw5TmlCVEJjSmlvR0V1Smp6MHJt?=
 =?gb2312?B?L3paSlMvWHh1NjR2enZobjlQMjg0cTgxa2N2L1NWRklCWTFmNGdZdDB3cnk3?=
 =?gb2312?B?LytOTGh1Nll1bnVoVGtGdDczdnBueWluc0h1bzNHdWxrYldvSC9TMGY5V2Zx?=
 =?gb2312?B?L1FhTHVud0VrY2w1K1lHQ2lENlpUVHdseUpRdmp6V05Hb3Y5ak5YNWNPNitF?=
 =?gb2312?Q?Qx9sbVloH05ZPnEKNadl8ZSjK?=
Content-Type: multipart/alternative;
 boundary="_000_SI2PR06MB47521E154DFBC4583DAD0D969925ASI2PR06MB4752apcp_"
MIME-Version: 1.0
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4752.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e8c0dd-cfe1-48cb-1611-08db7881773c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 09:16:04.9054 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01uuOdp+sgOEvNVgSFvWu7Ppvu5IUaAcOi10MjImfhateWJOtzZguYKeF2yhzRzJn91TGJuzPOCB8u2STPMQhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6531
Received-SPF: pass client-ip=2a01:111:f403:704b::60a;
 envelope-from=rma.ma@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: 35
X-Spam_score: 3.5
X-Spam_bar: +++
X-Spam_report: (3.5 / 5.0 requ) BAYES_00=-1.9, CHARSET_FARAWAY_HEADER=3.2,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, MIME_CHARSET_FARAWAY=2.45, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Jun 2023 09:01:55 -0400
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

--_000_SI2PR06MB47521E154DFBC4583DAD0D969925ASI2PR06MB4752apcp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

V2hlbiB0aGUgdm0gaXMgY3JlYXRlZKOsaXQgd2lsbCBwcm9jZXNzIHZob3N0X2Rldl9zdGFydCBp
biBrdm1fdmNwdV90aHJlYWRfZm6jrA0KYW5kIGJhY2tlbmQgY2hhbm5lbCBpbiBtYWluIHRocmVh
ZKOsaXQgc2VlbXMgdGhhdCB0aGVyZSBpcyBubyBtdWx0aXRocmVhZGVkIHN5bmNocm9ub3VzIHBy
b2JsZW0NCg0KYWZ0ZXIgbGl2ZSBtaWdyYXRpb24sIGl0IHdpbGwgcHJvY2VzcyB2aG9zdF9kZXZf
c3RhcnQgaW4gb3NfaG9zdF9tYWluX2xvb3Bfd2FpdCwNCmFuZCBiYWNrZW5kIGNoYW5uZWwgaXMg
YWxzbyBpbiBtYWluIHRocmVhZCwgaXQgd2lsbCByaXNrIG9mIHBvdGVudGlhbCBkZWFkbG9jaw0K
DQpzbyBpIHRoaW5rIGJhY2tlbmQgY2hhbm5lbCBpbiBzZXBhcmF0ZSB0aHJlYWQgY2FuIGZpeCBk
ZWFkbG9jaw0KDQpkb2VzIGl0IHJlYWxseSBleGlzdCBtdWx0aXRocmVhZGVkIHN5bmNocm9ub3Vz
IHByb2JsZW0gd2hpbGUgYmFja2VuZCBjaGFubmVsIGluIHNlcGFyYXRlIHRocmVhZD8NCg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4NCreiy83KsbzkOiAyMDIzxOo21MIyOcjVIDE1OjEzDQrK1bz+yMs6
IFJtYSBNYSA8cm1hLm1hQGphZ3Vhcm1pY3JvLmNvbT4NCrOty806IHFlbXUtZGV2ZWwgPHFlbXUt
ZGV2ZWxAbm9uZ251Lm9yZz4NCtb3zOI6IFJlOiBbUEFUQ0hdIHZob3N0LXVzZXI6IHVzZSBuZXcg
dGhyZWFkIHRvIGxvb3AgYmFja2VuZCBjaGFubmVsLg0KDQpPbiBUaHUsIEp1biAyOSwgMjAyMyBh
dCAwMjo1NDoxNVBNICswODAwLCBSbWEgTWEgd3JvdGU6DQo+IGZpeDogUUVNVSBkZWFkbG9jayB3
aXRoIGRwZGstdmRwYQ0KPg0KPiBRRU1VIHN0YXJ0IHZob3N0LXVzZXIgd2l0aCBtb2Rlcm4gbmV0
IGFuZCBibGssIGJhY2tlbmQgdXNlIGRwZGstdmRwYSBwcm9jZXNzLA0KPiBhZnRlciBsaXZlIG1p
Z3JhdGlvbiwgZGVzdCBRRU1VIGRlYWRsb2NrIHdpdGggZHBkay12ZHBhDQo+DQo+IC0gUUVNVSBz
ZW5kcyBWSE9TVF9VU0VSX1NFVF9WUklOR19LSUNLIHRvIGRwZGstdmRwYSBuZXQNCj4gLSBRRU1V
IGRvZXMgbm90IG5lZWQgdG8gd2FpdCBmb3IgYSByZXNwb25zZSB0byB0aGlzIG1lc3NhZ2UNCj4g
LSBRRU1VIHRoZW4gc2VuZHMgVkhPU1RfVVNFUl9TRVRfTUVNX1RBQkxFIHRvIGRwZGstdmRwYSBi
bGsNCj4gLSBRRU1VIG5lZWRzIHRvIHdhaXQgcmVwbHkgaW4gdGhpcyBtZXNzYWdlDQo+IC0gd2hl
biBkcGRrLXZkcGEgcmVjdiBWSE9TVF9VU0VSX1NFVF9WUklOR19LSUNLLCBpdCB3aWxsIHNlbmQg
VkhPU1RfVVNFUl9CQUNLRU5EX1ZSSU5HX0hPU1RfTk9USUZJRVJfTVNHIHRvIFFFTVUNCj4gLSBk
cGRrLXZkcGEgbmVlZHMgdG8gd2FpdCBmb3IgYSByZXNwb25zZSB0byB0aGlzIG1lc3NhZ2UNCj4g
LSBzaW5jZSBRRU1VIHZob3N0X3VzZXJfcmVhZCBhbmQgYmFja2VuZCBjaGFubmVsIGFyZSBzeW5j
aHJvbm91cyBpbiB0aGUgc2FtZSB0aHJlYWQNCj4gLSBRRU1VIHdpbGwgZGVhZGxvY2sgd2l0aCBk
cGRrLXZkcGENCj4NCj4gU2lnbmVkLW9mZi1ieTogUm1hIE1hIDxybWEubWFAamFndWFybWljcm8u
Y29tPg0KDQpIbW0gdGhpcyB3aWxsIG5lZWQgc29tZSB0aG91Z2h0LiBJJ20gY29uY2VybmVkIHRo
YXQgdGhpcw0KaXMgbWFraW5nIHdoYXQgd2FzIHByZXZpb3VzbHkgYSBzaW1wbGUgc3luY2hyb25v
dXMNCmNvZGUsIG11bHRpdGhyZWFkZWQuDQoNCkFsc28gSSBmZWVsIGRwZGsgbmVlZHMgdG8gZml4
IHRoaXMgdG9vLg0KDQpMZXQncyBkb2N1bWVudCBpbiB0aGUgZG9jIHRoYXQgd2hlbiBiYWNrZW5k
IGlzIGFsbG93ZWQgdG8gc2VuZCBtZXNzYWdlcw0KKFZIT1NUX1VTRVJfUFJPVE9DT0xfRl9CQUNL
RU5EX1JFUSkgLCBuZWl0aGVyIHNpZGUgaXMgYWxsb3dlZCB0byBibG9jaw0KcHJvY2Vzc2luZyBp
bmNvbWluZyBtZXNzc2FnZXMgd2hpbGUgd2FpdGluZyBmb3IgcmVzcG9uc2UuDQoNCg0KPiAtLS0N
Cj4gIGh3L3ZpcnRpby92aG9zdC11c2VyLmMgfCA2NyArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYyBi
L2h3L3ZpcnRpby92aG9zdC11c2VyLmMNCj4gaW5kZXggYzRlMGNiZDcwMi4uMWY2YjNhNWE2MyAx
MDA2NDQNCj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYw0KPiArKysgYi9ody92aXJ0aW8v
dmhvc3QtdXNlci5jDQo+IEBAIC0yNzQsNiArMjc0LDE3IEBAIHN0cnVjdCBzY3J1Yl9yZWdpb25z
IHsNCj4gICAgICBpbnQgZmRfaWR4Ow0KPiAgfTsNCj4NCj4gK3N0cnVjdCBiYWNrZW5kX3RocmVh
ZCB7DQo+ICsgICAgUWVtdVRocmVhZCB0aHJlYWQ7DQo+ICsgICAgUWVtdVNlbWFwaG9yZSBpbml0
X2RvbmVfc2VtOw0KPiArICAgIGludCB0aHJlYWRfaWQ7DQo+ICsgICAgR01haW5Db250ZXh0ICpj
dHh0Ow0KPiArICAgIEdNYWluTG9vcCAqbG9vcDsNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBzdHJ1
Y3QgYmFja2VuZF90aHJlYWQgKmJhY2tlbmRfdGg7DQo+ICtzdGF0aWMgYm9vbCBiYWNrZW5kX3Ro
cmVhZF9ydW47DQo+ICsNCj4gIHN0YXRpYyBib29sIGlvZXZlbnRmZF9lbmFibGVkKHZvaWQpDQo+
ICB7DQo+ICAgICAgcmV0dXJuICFrdm1fZW5hYmxlZCgpIHx8IGt2bV9ldmVudGZkc19lbmFibGVk
KCk7DQo+IEBAIC0xNjk2LDcgKzE3MDcsOCBAQCBmZGNsZWFudXA6DQo+ICAgICAgcmV0dXJuIHJj
Ow0KPiAgfQ0KPg0KPiAtc3RhdGljIGludCB2aG9zdF9zZXR1cF9iYWNrZW5kX2NoYW5uZWwoc3Ry
dWN0IHZob3N0X2RldiAqZGV2KQ0KPiArc3RhdGljIGludCB2aG9zdF9zZXR1cF9iYWNrZW5kX2No
YW5uZWwoc3RydWN0IHZob3N0X2RldiAqZGV2LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgR01haW5Db250ZXh0ICpjdHh0KQ0KPiAgew0KPiAgICAgIFZob3N0VXNl
ck1zZyBtc2cgPSB7DQo+ICAgICAgICAgIC5oZHIucmVxdWVzdCA9IFZIT1NUX1VTRVJfU0VUX0JB
Q0tFTkRfUkVRX0ZELA0KPiBAQCAtMTcyOCw3ICsxNzQwLDcgQEAgc3RhdGljIGludCB2aG9zdF9z
ZXR1cF9iYWNrZW5kX2NoYW5uZWwoc3RydWN0IHZob3N0X2RldiAqZGV2KQ0KPiAgICAgIHUtPmJh
Y2tlbmRfaW9jID0gaW9jOw0KPiAgICAgIHUtPmJhY2tlbmRfc3JjID0gcWlvX2NoYW5uZWxfYWRk
X3dhdGNoX3NvdXJjZSh1LT5iYWNrZW5kX2lvYywNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEdfSU9fSU4gfCBHX0lPX0hVUCwNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJhY2tlbmRfcmVhZCwgZGV2
LCBOVUxMLCBOVUxMKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJhY2tlbmRfcmVhZCwgZGV2LCBOVUxMLCBjdHh0KTsNCj4NCj4gICAgICBpZiAo
cmVwbHlfc3VwcG9ydGVkKSB7DQo+ICAgICAgICAgIG1zZy5oZHIuZmxhZ3MgfD0gVkhPU1RfVVNF
Ul9ORUVEX1JFUExZX01BU0s7DQo+IEBAIC0xOTgxLDYgKzE5OTMsNDIgQEAgc3RhdGljIGludCB2
aG9zdF91c2VyX3Bvc3Rjb3B5X25vdGlmaWVyKE5vdGlmaWVyV2l0aFJldHVybiAqbm90aWZpZXIs
DQo+ICAgICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+ICtzdGF0aWMgdm9pZCAqdmhvc3RfYmFja2Vu
ZF9jaGFubmVsX3dvcmtlcih2b2lkICpvcGFxdWUpDQo+ICt7DQo+ICsgICAgc3RydWN0IGJhY2tl
bmRfdGhyZWFkICpiYWNrZW5kX3RoID0gb3BhcXVlOw0KPiArDQo+ICsgICAgcmN1X3JlZ2lzdGVy
X3RocmVhZCgpOw0KPiArDQo+ICsgICAgYmFja2VuZF90aC0+Y3R4dCA9IGdfbWFpbl9jb250ZXh0
X25ldygpOw0KPiArICAgIGJhY2tlbmRfdGgtPmxvb3AgPSBnX21haW5fbG9vcF9uZXcoYmFja2Vu
ZF90aC0+Y3R4dCwgZmFsc2UpOw0KPiArICAgIGJhY2tlbmRfdGgtPnRocmVhZF9pZCA9IHFlbXVf
Z2V0X3RocmVhZF9pZCgpOw0KPiArDQo+ICsgICAgcWVtdV9zZW1fcG9zdCgmYmFja2VuZF90aC0+
aW5pdF9kb25lX3NlbSk7DQo+ICsNCj4gKyAgICBnX21haW5fbG9vcF9ydW4oYmFja2VuZF90aC0+
bG9vcCk7DQo+ICsNCj4gKyAgICBnX21haW5fbG9vcF91bnJlZihiYWNrZW5kX3RoLT5sb29wKTsN
Cj4gKyAgICBnX21haW5fY29udGV4dF91bnJlZihiYWNrZW5kX3RoLT5jdHh0KTsNCj4gKyAgICBn
X2ZyZWUoYmFja2VuZF90aCk7DQo+ICsgICAgcmN1X3VucmVnaXN0ZXJfdGhyZWFkKCk7DQo+ICsg
ICAgcmV0dXJuIE5VTEw7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyB2b2lkIHZob3N0X2JhY2tlbmRf
dGhyZWFkX2luaXQodm9pZCkNCj4gK3sNCj4gKyAgICBiYWNrZW5kX3RoID0gZ19tYWxsb2MwKHNp
emVvZihzdHJ1Y3QgYmFja2VuZF90aHJlYWQpKTsNCj4gKyAgICBiYWNrZW5kX3RoLT50aHJlYWRf
aWQgPSAtMTsNCj4gKyAgICBxZW11X3NlbV9pbml0KCZiYWNrZW5kX3RoLT5pbml0X2RvbmVfc2Vt
LCAwKTsNCj4gKw0KPiArICAgIHFlbXVfdGhyZWFkX2NyZWF0ZSgmYmFja2VuZF90aC0+dGhyZWFk
LCAiYmFja2VuZC1jaGFubmVsLXdvcmtlciIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHZo
b3N0X2JhY2tlbmRfY2hhbm5lbF93b3JrZXIsIGJhY2tlbmRfdGgsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIFFFTVVfVEhSRUFEX0RFVEFDSEVEKTsNCj4gKw0KPiArICAgIHdoaWxlIChiYWNr
ZW5kX3RoLT50aHJlYWRfaWQgPT0gLTEpIHsNCj4gKyAgICAgICAgcWVtdV9zZW1fd2FpdCgmYmFj
a2VuZF90aC0+aW5pdF9kb25lX3NlbSk7DQo+ICsgICAgfQ0KPiArfQ0KPiArDQo+ICBzdGF0aWMg
aW50IHZob3N0X3VzZXJfYmFja2VuZF9pbml0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdm9pZCAq
b3BhcXVlLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApDQo+ICB7DQo+IEBAIC0yMTA4LDEwICsyMTU2LDE3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdXNl
cl9iYWNrZW5kX2luaXQoc3RydWN0IHZob3N0X2RldiAqZGV2LCB2b2lkICpvcGFxdWUsDQo+ICAg
ICAgfQ0KPg0KPiAgICAgIGlmIChkZXYtPnZxX2luZGV4ID09IDApIHsNCj4gLSAgICAgICAgZXJy
ID0gdmhvc3Rfc2V0dXBfYmFja2VuZF9jaGFubmVsKGRldik7DQo+IC0gICAgICAgIGlmIChlcnIg
PCAwKSB7DQo+IC0gICAgICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIEVQUk9UTywgInZo
b3N0X2JhY2tlbmRfaW5pdCBmYWlsZWQiKTsNCj4gLSAgICAgICAgICAgIHJldHVybiAtRVBST1RP
Ow0KPiArICAgICAgICBpZiAoIWJhY2tlbmRfdGhyZWFkX3J1bikgew0KPiArICAgICAgICAgICAg
dmhvc3RfYmFja2VuZF90aHJlYWRfaW5pdCgpOw0KPiArICAgICAgICAgICAgYmFja2VuZF90aHJl
YWRfcnVuID0gdHJ1ZTsNCj4gKyAgICAgICAgfQ0KPiArDQo+ICsgICAgICAgIGlmIChiYWNrZW5k
X3RocmVhZF9ydW4gJiYgYmFja2VuZF90aCkgew0KPiArICAgICAgICAgICAgZXJyID0gdmhvc3Rf
c2V0dXBfYmFja2VuZF9jaGFubmVsKGRldiwgYmFja2VuZF90aC0+Y3R4dCk7DQo+ICsgICAgICAg
ICAgICBpZiAoZXJyIDwgMCkgew0KPiArICAgICAgICAgICAgICAgIGVycm9yX3NldGdfZXJybm8o
ZXJycCwgRVBST1RPLCAidmhvc3RfYmFja2VuZF9pbml0IGZhaWxlZCIpOw0KPiArICAgICAgICAg
ICAgICAgIHJldHVybiAtRVBST1RPOw0KPiArICAgICAgICAgICAgfQ0KPiAgICAgICAgICB9DQo+
ICAgICAgfQ0KPg0KPiAtLQ0KPiAyLjE3LjENCg0K

--_000_SI2PR06MB47521E154DFBC4583DAD0D969925ASI2PR06MB4752apcp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
When the vm is created=A3=ACit will process vhost_dev_start in kvm_vcpu_thr=
ead_fn=A3=AC
<div class=3D"ContentPasted0">and backend channel in main thread=A3=ACit se=
ems that there is no multithreaded synchronous problem</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">after live migration, it will process vhost_d=
ev_start in os_host_main_loop_wait,</div>
<div class=3D"ContentPasted0">and backend channel is also in main thread, i=
t will risk of potential deadlock</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">so i think backend channel in separate thread=
 can fix deadlock</div>
<div><br class=3D"ContentPasted0">
</div>
does it really exist multithreaded synchronous problem while backend channe=
l in separate thread?<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>=B7=A2=BC=FE=C8=CB:</b> Michael=
 S. Tsirkin &lt;mst@redhat.com&gt;<br>
<b>=B7=A2=CB=CD=CA=B1=BC=E4:</b> 2023=C4=EA6=D4=C229=C8=D5 15:13<br>
<b>=CA=D5=BC=FE=C8=CB:</b> Rma Ma &lt;rma.ma@jaguarmicro.com&gt;<br>
<b>=B3=AD=CB=CD:</b> qemu-devel &lt;qemu-devel@nongnu.org&gt;<br>
<b>=D6=F7=CC=E2:</b> Re: [PATCH] vhost-user: use new thread to loop backend=
 channel.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Jun 29, 2023 at 02:54:15PM +0800, Rma Ma w=
rote:<br>
&gt; fix: QEMU deadlock with dpdk-vdpa<br>
&gt; <br>
&gt; QEMU start vhost-user with modern net and blk, backend use dpdk-vdpa p=
rocess,<br>
&gt; after live migration, dest QEMU deadlock with dpdk-vdpa<br>
&gt; <br>
&gt; - QEMU sends VHOST_USER_SET_VRING_KICK to dpdk-vdpa net<br>
&gt; - QEMU does not need to wait for a response to this message<br>
&gt; - QEMU then sends VHOST_USER_SET_MEM_TABLE to dpdk-vdpa blk<br>
&gt; - QEMU needs to wait reply in this message<br>
&gt; - when dpdk-vdpa recv VHOST_USER_SET_VRING_KICK, it will send VHOST_US=
ER_BACKEND_VRING_HOST_NOTIFIER_MSG to QEMU<br>
&gt; - dpdk-vdpa needs to wait for a response to this message<br>
&gt; - since QEMU vhost_user_read and backend channel are synchronous in th=
e same thread<br>
&gt; - QEMU will deadlock with dpdk-vdpa<br>
&gt; <br>
&gt; Signed-off-by: Rma Ma &lt;rma.ma@jaguarmicro.com&gt;<br>
<br>
Hmm this will need some thought. I'm concerned that this<br>
is making what was previously a simple synchronous<br>
code, multithreaded.<br>
<br>
Also I feel dpdk needs to fix this too.<br>
<br>
Let's document in the doc that when backend is allowed to send messages<br>
(VHOST_USER_PROTOCOL_F_BACKEND_REQ) , neither side is allowed to block<br>
processing incoming messsages while waiting for response.<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; hw/virtio/vhost-user.c | 67 ++++++++++++++++++++++++++++++++++++=
++----<br>
&gt;&nbsp; 1 file changed, 61 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c <br>
&gt; index c4e0cbd702..1f6b3a5a63 100644<br>
&gt; --- a/hw/virtio/vhost-user.c<br>
&gt; +++ b/hw/virtio/vhost-user.c<br>
&gt; @@ -274,6 +274,17 @@ struct scrub_regions {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int fd_idx;<br>
&gt;&nbsp; };<br>
&gt;&nbsp; <br>
&gt; +struct backend_thread {<br>
&gt; +&nbsp;&nbsp;&nbsp; QemuThread thread;<br>
&gt; +&nbsp;&nbsp;&nbsp; QemuSemaphore init_done_sem;<br>
&gt; +&nbsp;&nbsp;&nbsp; int thread_id;<br>
&gt; +&nbsp;&nbsp;&nbsp; GMainContext *ctxt;<br>
&gt; +&nbsp;&nbsp;&nbsp; GMainLoop *loop;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct backend_thread *backend_th;<br>
&gt; +static bool backend_thread_run;<br>
&gt; +<br>
&gt;&nbsp; static bool ioeventfd_enabled(void)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return !kvm_enabled() || kvm_eventfds_en=
abled();<br>
&gt; @@ -1696,7 +1707,8 @@ fdcleanup:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -static int vhost_setup_backend_channel(struct vhost_dev *dev)<br>
&gt; +static int vhost_setup_backend_channel(struct vhost_dev *dev,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; GMainContext *ctxt)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VhostUserMsg msg =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .hdr.request =3D=
 VHOST_USER_SET_BACKEND_REQ_FD,<br>
&gt; @@ -1728,7 +1740,7 @@ static int vhost_setup_backend_channel(struct vh=
ost_dev *dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u-&gt;backend_ioc =3D ioc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u-&gt;backend_src =3D qio_channel_add_wa=
tch_source(u-&gt;backend_ioc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; G=
_IO_IN | G_IO_HUP,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; backend_rea=
d, dev, NULL, NULL);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; backend_rea=
d, dev, NULL, ctxt);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reply_supported) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg.hdr.flags |=
=3D VHOST_USER_NEED_REPLY_MASK;<br>
&gt; @@ -1981,6 +1993,42 @@ static int vhost_user_postcopy_notifier(Notifie=
rWithReturn *notifier,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; +static void *vhost_backend_channel_worker(void *opaque)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; struct backend_thread *backend_th =3D opaque;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; rcu_register_thread();<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; backend_th-&gt;ctxt =3D g_main_context_new();<br>
&gt; +&nbsp;&nbsp;&nbsp; backend_th-&gt;loop =3D g_main_loop_new(backend_th=
-&gt;ctxt, false);<br>
&gt; +&nbsp;&nbsp;&nbsp; backend_th-&gt;thread_id =3D qemu_get_thread_id();=
<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; qemu_sem_post(&amp;backend_th-&gt;init_done_sem);<=
br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; g_main_loop_run(backend_th-&gt;loop);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; g_main_loop_unref(backend_th-&gt;loop);<br>
&gt; +&nbsp;&nbsp;&nbsp; g_main_context_unref(backend_th-&gt;ctxt);<br>
&gt; +&nbsp;&nbsp;&nbsp; g_free(backend_th);<br>
&gt; +&nbsp;&nbsp;&nbsp; rcu_unregister_thread();<br>
&gt; +&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void vhost_backend_thread_init(void)<br>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; backend_th =3D g_malloc0(sizeof(struct backend_thr=
ead));<br>
&gt; +&nbsp;&nbsp;&nbsp; backend_th-&gt;thread_id =3D -1;<br>
&gt; +&nbsp;&nbsp;&nbsp; qemu_sem_init(&amp;backend_th-&gt;init_done_sem, 0=
);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; qemu_thread_create(&amp;backend_th-&gt;thread, &qu=
ot;backend-channel-worker&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vhost_backe=
nd_channel_worker, backend_th,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; QEMU_THREAD=
_DETACHED);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; while (backend_th-&gt;thread_id =3D=3D -1) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_sem_wait(&amp;backend=
_th-&gt;init_done_sem);<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt;&nbsp; static int vhost_user_backend_init(struct vhost_dev *dev, void *=
opaque,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Erro=
r **errp)<br>
&gt;&nbsp; {<br>
&gt; @@ -2108,10 +2156,17 @@ static int vhost_user_backend_init(struct vhos=
t_dev *dev, void *opaque,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dev-&gt;vq_index =3D=3D 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =3D vhost_setup_backen=
d_channel(dev);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err &lt; 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; er=
ror_setg_errno(errp, EPROTO, &quot;vhost_backend_init failed&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; re=
turn -EPROTO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!backend_thread_run) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vh=
ost_backend_thread_init();<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ba=
ckend_thread_run =3D true;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (backend_thread_run &am=
p;&amp; backend_th) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; er=
r =3D vhost_setup_backend_channel(dev, backend_th-&gt;ctxt);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (err &lt; 0) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; error_setg_errno(errp, EPROTO, &quot;vhost_backend_in=
it failed&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EPROTO;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; -- <br>
&gt; 2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SI2PR06MB47521E154DFBC4583DAD0D969925ASI2PR06MB4752apcp_--

