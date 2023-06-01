Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA2C719EEC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4inb-0001mP-Fn; Thu, 01 Jun 2023 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5095203fe=Niklas.Cassel@wdc.com>)
 id 1q4inY-0001dj-AX; Thu, 01 Jun 2023 09:57:04 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=5095203fe=Niklas.Cassel@wdc.com>)
 id 1q4inV-0002Tr-FT; Thu, 01 Jun 2023 09:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1685627821; x=1717163821;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Ajg9oGiakbBq06e0F51u7n/gfpmBgS4PaEZn9tPyPIY=;
 b=am7QofM0HXB3sOqxcNcHybqf0Rw1Xzfb949yw8Wl9iV/PZK9O2vEJHVa
 eQikIOQo8Jz+PJ8tekrVlMsGE3/aCJC+qlbiKaGrb0ECWhN1JbefApgMi
 2xH6Vl1cHHvCJNqndmhG1lbevnGZsA8a9pCS3iYdlcGDM5h8zpgMStf6K
 rfYEjaY7k482R+1h7xrpHPH2+pVe0w2qEqv2jxcHxzrsWNt4u+D2c34qP
 YI4nwsI4F1DcS4nQTXnQGq4cfph1ZvahBQQ3lSheqFNWmu1E6B/pxxjF0
 01Ib91N0eqm55X/ieulwv00TII6E9UQDZPu2ClxAfSyaEd1QnvzANHJHx w==;
X-IronPort-AV: E=Sophos;i="6.00,210,1681142400"; d="scan'208";a="237104208"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
 by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2023 21:56:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQual3luYnDufKESNaFChjJUKAe9/CqPCgiVBK+pNAZpHrINy+/8vZdBqAQIeJbbMfO70kIzOlyOJ0qrSPUAqzgaScecyPdi8xZ1UOZKDHwmsf/fG2+LInAR9EtoQBXBIFiFK6hqXbJduvYLXCm1E8n+ReBvc3S1xvuerQrsl8G0ucuiHmHBBOJV72j2R8ikwl0i4dgNhQR6JMLZJZza5X/tkikVDAEPRWkY2Y4CS5gFb/BiHB+eLRGiDl2TK4oEUQkg1mf13fDf0b1FzJEGaEaklWyulqMkRAZSSZkITayK5gDK6eByhzsUdGL5FAthrRo4kHQMCJSpyRzr+MsijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ajg9oGiakbBq06e0F51u7n/gfpmBgS4PaEZn9tPyPIY=;
 b=bWHcOUHK4YuS22KdjqAb0XB82eRL+IA+YUYl6U3grSYNi29Fs7RP+rLdQ30zS2fFmFfm6sS7W6vqtSF7tQyOPCMtRqRBhyOs5TkHcstU7LXOATB69bTZWJxrghyg2U/IlBMspcTqRj2MIGAuekOC9Zr4r/OTcQhguWRPUc9nKassv1Hv5lZkQzxlu8YLVEFYvqCWHr4kMm9tocGC9WTE6WqKS55CpnxWTEq3OIw2aaoV8Vand33R6VFHmvp51be4dpQ4H55ZsVhahyKe5FuY0PNNl5Lu6NwsrUBiEA+6g0FnCKyY095uosaAqApGgB6jk1HuFUgGhfXNrEpdTXiHGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ajg9oGiakbBq06e0F51u7n/gfpmBgS4PaEZn9tPyPIY=;
 b=mSIzb35mVNDYS1ixw+OvtFaiY73rQMTjxs2nWnhX+LW1kMiBKYysGp39gfuYQWQrDt3WVmEAqR//JQzcDzkw36bF1xDr7e5d4BqXCAcWkD9zS9mYdzzYA4dPOPgUJgVzCoN9pd4ilarDYebuTCYVLHVfw3bq2dliWg1KiGMfYnw=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH0PR04MB8178.namprd04.prod.outlook.com (2603:10b6:610:f9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 13:56:53 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::d8ec:2aa9:9ddf:5af9%4]) with mapi id 15.20.6433.024; Thu, 1 Jun 2023
 13:56:53 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: Niklas Cassel <nks@flawful.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 0/9] misc AHCI cleanups
Thread-Topic: [PATCH 0/9] misc AHCI cleanups
Thread-Index: AQHZedR64fhyQ27190WmE6xFMh3PGK9e0BMAgBdeGoA=
Date: Thu, 1 Jun 2023 13:56:53 +0000
Message-ID: <ZHijpToZ6lochuR5@x1-carbon>
References: <20230428132124.670840-1-nks@flawful.org>
 <CAFn=p-Zk37sNFjHd5e77UCqeCUczZmEOvFQ2QKZcE3eQJau5Nw@mail.gmail.com>
In-Reply-To: <CAFn=p-Zk37sNFjHd5e77UCqeCUczZmEOvFQ2QKZcE3eQJau5Nw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH0PR04MB8178:EE_
x-ms-office365-filtering-correlation-id: f227a8b4-5895-4835-d47c-08db62a80e55
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SdI/2f6xC3qv8TCmc9LvzAyl2ZFHpNoxk9J0JygGJliND9txB8x9jdkiocFaPqiXbta6vhc8rLjr6jqzM0lFt3QAU9BvctQLjP/J4SoGjyh8Gyf6jaIajNRETqrQdxEhvOVOc0gH3Y4ULa4tm5WyFFmQNZHLi+fMZP/X9CZrCLScw8+um69L65ksYvs2IenbKYMOJR3Kq7M3R4eGJNFp6R6keOWxsHYkZX/pWKjwZSzDIj36A8128CHu+zP8S7MszkGTMKn/Xl+XFa6L2F+OUGV8YZXtUthmhkoTndzkn/YiRM/Ci35HZyOGvTQLfMbgzO5+HLasjiw6GbapVlhP3pemZycVVwR8l3xUsGbbR3qis3Nh3Q09vcvtNXQ9sPBbREs1LwpNNLt4afZ6In9DHHN15co4WQuRPFR6B77vbLb0tq07rksYLvDcqbbKHmDE8r2Lf7RFFYqslQmCrzi0RJR2j5kqy2HnaNT+lyh3FDqMhzBPWMgZS+b4g+XEXO+ixSQblCbvVf1zZOpHppof1zm8zR+4GSESbAQVNHiiQjHhsNK8xPLGy5V43b6MSwRUlbgSlLZiqSEKCANd+yHVImaWdlOLJlP2DQqn4/Uo2k7R86/MPbtWhsg2d/dlupX5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(7916004)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199021)(83380400001)(86362001)(9686003)(66946007)(122000001)(66556008)(64756008)(66446008)(91956017)(76116006)(66476007)(41300700001)(186003)(6916009)(4326008)(82960400001)(2906002)(38070700005)(26005)(53546011)(6512007)(6506007)(8936002)(8676002)(33716001)(5660300002)(478600001)(71200400001)(316002)(38100700002)(6486002)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFQ2b3k1RTBoVm1xOS9jZThuRW4wdmhLV1hrV0Z1QjVBT21rbnV0eGZZdkc2?=
 =?utf-8?B?ZU9STjlhTGFWaDVGOUNXSzJvS1NjM09YMklxK2gveG80R3FQSmZjTEdTNHhn?=
 =?utf-8?B?N3hPVnVQTnRQOWw3M0FOcGovTndPcmRKaUtEVC9XaDFqc0d4dGhVaTJGaWhJ?=
 =?utf-8?B?QkNFRWJrWUVKSjU4QzROK052b0dvNng5ZjZJSGorVDJNV3pZaWVJZWpQd0M5?=
 =?utf-8?B?UGVDZ0Fka0hkVWVqSGlyUHVxOWgvNGFiS1VZOVAyWHcwVEVZdmxXR2lEMCtC?=
 =?utf-8?B?cjNjMWMyRnYyQURBSzVmWGpzTy95SVVITkJxNjVLelV4bmdoMWRBMVFZcU55?=
 =?utf-8?B?Z3RFOHN2RmwxcDJsQWU2MC9STEs5WGpEN0RGK2pMdHdpZEh3WG9uRjQrL1BZ?=
 =?utf-8?B?bmc4ZWFiek55Wk1GMnFZNWJSazBXQk5OZk1nM05tTU9rVGZEdUpCVU9RNGFu?=
 =?utf-8?B?SVJRcDcvdm9sZytSNUJ3ZFlhVUEvQUhVL0Fha1ZBOFJLREJlNkZyYWY4SURw?=
 =?utf-8?B?WGg4UnFPNThneHp0ZUV1NWRkQ3BQNGxmSU11RW5aQXVaM1Mycm9DVUJJWmZD?=
 =?utf-8?B?VWpOK2ErOFR0T21oOVR3VG1TZnFDR1RMNk5EMTZWOGp1OU5PTklTd1dXdzZF?=
 =?utf-8?B?OW9aU3lHQjhoQ2lXWldreEJVSmYyMzBkQks0dUg4Sk05UW9aakwvQWhjNTNM?=
 =?utf-8?B?QTBudlRmUzZOcjl5S1BxSjFLOERuUm5SQ2VmT203S0xMdWlOWm9vU1lsNkpq?=
 =?utf-8?B?SmIycDdxV29odXV5bnlldUs1a1JMdEZaKzVxTVB4Q3pSR2Vma0JpYU16c2xN?=
 =?utf-8?B?Yis1WG1CU0VINjNOZ3gvU05IZEFhVmhhNjNSbnlQcVJ3V3RmUk9qNWhMbHEy?=
 =?utf-8?B?aU9zc0dVTjhMMkdDZWpXQWVwN0QxYXEvd0xLeHVkbStML2ovemt6SitKamta?=
 =?utf-8?B?Tit3ZGVNekZBL09SMzdpQmhsY0hsb2piNDRtM3RUZDFpSWdHT0g4MjA5c0Qz?=
 =?utf-8?B?dVNzZklzeWswbW1jQlBraVQ0VVlueTdrZ0E4dC8wNXRaL3NvYkd5ZDBDYXAz?=
 =?utf-8?B?SU9aZTFpTzNoWkZZZlVZQTZ1MjhxendrV3A0SXl2QlpGcG9Jbzl3azVVWHN4?=
 =?utf-8?B?c2Z3T3hMWERJMndVRmdDcWVtQTBUTEt5QS85ZEJNWkZaQ0svMVloNEQ3aFpz?=
 =?utf-8?B?ZnRZN1dRUWJ5alNXbkZQOGZpLzVWUDU4RlVpYStRY1phcU5RcW0xaWgrY0Jz?=
 =?utf-8?B?YlV5RXQvVy9LOG5YTlp5Nml2ditFK2FjSmUwZVBuSWZLaHBHckR1SXpHRkVq?=
 =?utf-8?B?TmNEMnJkbittSFNhM25LbjVLa3BxaTBQVUsyVVBpMzRyVEpqRTlOZ0lNTkUv?=
 =?utf-8?B?UlFIVThGd1d0RWtEMkRPTXlTYmNMZVdqSFR2R0l0YkhEV1VyVW5Ba004dXl1?=
 =?utf-8?B?MERYSmVUL2xkZCtmMFFyMmQyTEMySFpPR1ptUmFpUkhvNkdGZERzMkVTdVZm?=
 =?utf-8?B?SXcwUUpFZ28zK0RRMTFtLzhoVGZBQWRKbVMxV1IrTEZxZjZ6b1Q1bUNFYUln?=
 =?utf-8?B?WkY1cFRydDVnb0pJWU9TQ014d0ZTS2RVdmRZd1krMjdxdE14NDJjME8wc2M1?=
 =?utf-8?B?dFUvNGtrTWhRYzI0K2lLMHhqQk0vWnVOQmpzLzBXdWsyZ0o1QzVmTmc4UGxj?=
 =?utf-8?B?eFJ0Ykd6cmljdDJVbUF2TXlVTVhzYkRacUdWZzFBNFVNdEt2eFB1Y1djWEpD?=
 =?utf-8?B?UFZTWjZoS0J0M1NhY1NkdmFrdjVPWXlNYllFa1J4bENtak9GWTEwOFY3RkxE?=
 =?utf-8?B?dGJiL21TWFMxeTdKVlZvUG82czVObU9ZMWYvNUFrdTh5ZDRMMkVtTytHV1ZH?=
 =?utf-8?B?TUN0bE1NVHRWOWJkYUl0WWhGc2VUeTExZkhraTVjanJ4aFZCNFh2K0FSWVNW?=
 =?utf-8?B?N2dvdjZpZ3d4TkxuYUprYUlIeDBJTTJDdHJUcFJhMHFIMjFYemRhTjlUaU9v?=
 =?utf-8?B?dnh4dTBxQUlaNjUyZmJNZkNZM0JKWE5yRHVVNWg1YVZ0MC9QMEJUaTlGMC9V?=
 =?utf-8?B?a1loRE9YUGUwb1Zpck41dkR6ZkJlWk4wZUMyRjZZczliNm9QRkZHZ3ZHUGc0?=
 =?utf-8?B?OTRoWFZBOWlRZytvcjE2K1F0cWZpOHNSSUlNMTV3WDRWTi9YZ2NGNWR3aE92?=
 =?utf-8?B?bFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A27F5CE5484C4A4CB2DBB6D844713BF9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NNxA9OBKldBp6/4jOyBwE4N3TLjiVQNa71XvJ2dMY8glIJ0sMnC/mNpw/7mcY3ncNbE0OlBGow4sRWuBlvZuxVM/FQrR2jyDupMQtwvoIi7CGNQJCg4kJ8l57/gpaie437P+dEv18GwD1ebLpiizHP7Fl2p/ZGjJ3W5rhMnSK/N2OGmdUFnb7JLF7+n0ng32pAUIaQeUZcYCEaP4Qf6Yt8pssJC2FbgbzXB6URwxJgq5JXOwBO6TlaCBGuXR4pra8Hg6PtTqGfvcEWRA+8Nuve8LbcnokaBnp0efiaji1V7zNkNr/R01Cz6B1f8hdKFkOhApADN4Ee+JegSt5tFIfBu9JDoqy8CSHvkn5pSgEZILaNjyLo9JlpUvSvfuMh6xgBr6roLBec9V9NTnhBjFstVHWNh8AKWT3TbWtanDiw44/uVVpsu/lrsgYRn85I7/7j/DuKyzhWmJB2idiei9vI0qiel7NGMNQB4pK6Nfj0jO7ds17BFmPbTaWDyOZzpZTMrlFKJicW0p6MmXR89z0T7QCY+vAIqHi5E02iEeW3/U7Z8nVDGdz0w9i5a0UQDY7eJSNeyKrZH//7tIE4JBU6dRrSytezPJCZwj83osFgxtYCUC1Cq6fusCNy+caT4NGuqt0Pfm+MAb26H/aWR5WswqwvkXrtz6nZYmYr7hfsb70iqro1ib95TYMq6fERK82qSsBF448NmwYWMY+79W3yBss+J1AFT3lGnBtnlbokTEWA0UD5gTTGLyHXzom+KG2L2VRabDeGbXey9RK9tAnxe80IaDeaquUrwbS/LOdXaQrd495qxsNHvt79mnA2hdOg2iJycvZFyheUf485KKnTH0NpSF8PfcfSkLKcB1GOM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f227a8b4-5895-4835-d47c-08db62a80e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 13:56:53.7016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMydIfplIR04gfcX4DJEu2oL2SE+4kFp9gai6RiaqW4bvx5dc2zQdb7bKb2oTl+948IlGU5bj9hqZu+aMdP7Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8178
Received-SPF: pass client-ip=216.71.153.141;
 envelope-from=prvs=5095203fe=Niklas.Cassel@wdc.com; helo=esa3.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMDE6MDY6MDZQTSAtMDQwMCwgSm9obiBTbm93IHdyb3Rl
Og0KPiBPbiBGcmksIEFwciAyOCwgMjAyMyBhdCA5OjIy4oCvQU0gTmlrbGFzIENhc3NlbCA8bmtz
QGZsYXdmdWwub3JnPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IE5pa2xhcyBDYXNzZWwgPG5pa2xh
cy5jYXNzZWxAd2RjLmNvbT4NCj4gPg0KPiA+IEhlbGxvIEpvaG4sDQo+ID4NCj4gDQo+IEhpIE5p
a2xhcyENCj4gDQo+IEkgaGF2ZW4ndCBiZWVuIGFjdGl2ZWx5IGludm9sdmVkIHdpdGggQUhDSSBm
b3IgYSB3aGlsZSwgc28gSSBhbSBub3QNCj4gc3VyZSBJIGNhbiBmaW5kIHRoZSB0aW1lIHRvIGdp
dmUgdGhpcyBhIGRlZXAgc2NydWIuIEknbSBnb2luZyB0bw0KPiBhc3N1bWUgYmFzZWQgb24gJ0B3
ZGMuY29tYCB0aGF0IHlvdSBwcm9iYWJseSBrbm93IGEgdGhpbmcgb3IgdHdvIG1vcmUNCj4gYWJv
dXQgQUhDSSB0aGFuIEkgZG8sIHRob3VnaC4gQ2FuIHlvdSB0ZWxsIG1lIHdoYXQgdGVzdGluZyB5
b3UndmUNCj4gcGVyZm9ybWVkIG9uIHRoaXM/IEFzIGxvbmcgYXMgaXQgZG9lc24ndCBjYXVzZSBh
bnkgb2J2aW91cw0KPiByZWdyZXNzaW9ucywgd2UgbWlnaHQgYmUgYWJsZSB0byBwdXNoIGl0IHRo
cm91Z2gsIGJ1dCBpdCBtaWdodCBub3QgYmUNCj4gdXAgdG8gbWUgYW55bW9yZS4gSSBjYW4gZ2l2
ZSBpdCBhIHJldmlldyBvbiB0ZWNobmljYWwgbWVyaXQsIGJ1dCB3aXRoDQo+IHJlZ2FyZHMgdG8g
ImNvcnJlY3RuZXNzIiBJIGhhdmUgdG8gYWRtaXQgSSBhbSBmbHlpbmcgYmxpbmQuDQoNCkhlbGxv
IEpvaG4sDQoNClRoZSB0ZXN0aW5nIGlzIG1vc3RseSB1c2luZyBsaW51eCBhbmQgaW5qZWN0aW5n
IE5DUSBlcnJvcnMgdXNpbmcgc29tZQ0KYWRkaXRpb25hbCBRRU1VIHBhdGNoZXMgdGhhdCBhcmUg
bm90IHBhcnQgb2YgdGhpcyBzZXJpZXMuDQoNCj4gDQo+IChJIGhhdmVuJ3QgbG9va2VkIGF0IHRo
ZSBwYXRjaGVzIHlldCwgYnV0IGlmIGluIHlvdXIgY29tbWl0IG1lc3NhZ2VzDQo+IHlvdSBjYW4g
cG9pbnQgdG8gdGhlIHJlbGV2YW50IHNlY3Rpb25zIG9mIHRoZSByZWxldmFudCBzcGVjaWZpY2F0
aW9ucywNCj4gdGhhdCdkIGhlbHAgaW1tZW5zZWx5LikNCj4gDQo+ID4gSGVyZSBjb21lcyBzb21l
IG1pc2MgQUhDSSBjbGVhbnVwcy4NCj4gPg0KPiA+IE1vc3QgYXJlIHJlbGF0ZWQgdG8gZXJyb3Ig
aGFuZGxpbmcuDQo+IA0KPiBJJ3ZlIGFsd2F5cyBmb3VuZCB0aGlzIHRoZSBtb3N0IGRpZmZpY3Vs
dCBwYXJ0IHRvIHZlcmlmeS4gSW4gYSByZWFsDQo+IHN5c3RlbSwgdGhlIHJlZ2lzdGVycyBiZXR3
ZWVuIEFIQ0kgYW5kIHRoZSBhY3R1YWwgaGFyZCBkaXNrIGFyZQ0KPiAqcGh5c2ljYWxseSBzZXBh
cmF0ZSosIGFuZCB0aGV5IHVwZGF0ZSBhdCBzcGVjaWZpYyB0aW1lcyBiYXNlZCBvbiB0aGUNCj4g
dHJhbnNtaXNzaW9uIG9mIHRoZSBGSVMgcGFja2V0cy4gVGhlIG1vZGVsIGluIFFFTVUgZG9lc24n
dCBib3RoZXIgd2l0aA0KPiBhIHBlcmZlY3QgcmVwcm9kdWN0aW9uIG9mIHRoYXQsIGFuZCBzbyBp
dCdzIGJlZW4gYSBsaXR0bGUgdG91Z2ggdG8NCj4gdmVyaWZ5IGNvcnJlY3RuZXNzLiBJIHRyaWVk
IHRvIGltcHJvdmUgaXQgYSBiaXQgYmFjayBpbiB0aGUgZGF5LCBidXQNCj4gbXkgdW5kZXJzdGFu
ZGluZyBoYXMgYWx3YXlzIGJlZW4gYSBiaXQgbGltaXRlZCA6KQ0KPiANCj4gQXJlIHRoZXJlIGFu
eSB2ZW5kb3IgdG9vbHMgeW91J3JlIGF3YXJlIG9mIHRoYXQgaGF2ZSB0ZXN0IHN1aXRlcyB3ZQ0K
PiBjb3VsZCB1c2UgdG8gdmVyaWZ5IGJlaGF2aW9yPw0KDQpVbmZvcnR1bmF0ZWx5LCBJIGRvbid0
IGtub3cgb2YgYW55IGdvb2QgdGVzdCBzdWl0ZS4NCg0KPiBBIHF1ZXN0aW9uIGZvciB5b3U6IGlz
IGl0IHdvcnRoIHNvbGlkaWZ5aW5nIHdoaWNoIEFUQSBzcGVjaWZpY2F0aW9uIHdlDQo+IGNvbmZv
cm0gdG8/IEkgZG9uJ3QgYmVsaWV2ZSB3ZSBhZGhlcmUgdG8gYW55IG9uZSBzcGVjaWZpYyBtb2Rl
bCwNCj4gYmVjYXVzZSBhIGxvdCBvZiB0aGUgY29kZSBpcyBzaGFyZWQgYmV0d2VlbiBQQVRBIGFu
ZCBTQVRBLCBhbmQgd2UgImluDQo+IHRoZW9yeSIgc3VwcG9ydCBJREUgaGFyZCBkcml2ZXMgZm9y
IGZhaXJseSBvbGQgZ3Vlc3Qgb3BlcmF0aW5nIHN5c3RlbXMNCj4gdGhhdCBtYXkgb3IgbWF5IG5v
dCBwcmVkYXRlIHRoZSBETUEgZXh0ZW5zaW9ucy4gQXMgYSByZXN1bHQsIHRoZQ0KPiBhY3R1YWwg
ZGV2aWNlIGVtdWxhdGlvbiBpcyBraW5kIG9mIGEgbWlzaC1tYXNoIG9mIGRpZmZlcmVudCBBVEEN
Cj4gc3BlY2lmaWNhdGlvbnMsIGdlbmVyYWxseSB3aGljaGV2ZXIgdmVyc2lvbiBwcm92aWRlZCB0
aGUNCj4gbGVhc3QtYWJzdHJhY3RlZCBkZXRhaWwgYW5kIHdhcyBlYXN5IHRvIGltcGxlbWVudC4N
Cj4gDQo+IElmIHlvdSdyZSBhZGRpbmcgdGhlIGxvZ2dpbmcgZmVhdHVyZXMsIHRoYXQgc2VlbXMg
dG8gcHVzaCB1cyB0b3dhcmRzDQo+IHRoZSBuZXdlciBlbmQgb2YgdGhlIHNwZWN0cnVtLCBidXQg
SSdtIG5vdCBzdXJlIGlmIHRoaXMgY2F1c2VzIGFueQ0KPiBwcm9ibGVtcyBmb3IgZ3Vlc3Qgb3Bl
cmF0aW5nIHN5c3RlbXMgZG9pbmcgcHJvYmluZyB0byBndWVzcyB3aGF0IGtpbmQNCj4gb2YgZGV2
aWNlIHRoZXkncmUgdGFsa2luZyB0by4NCj4gDQo+IEFueSBpbnB1dD8NCg0KSSBhZ3JlZS4NCg0K
SW4gbXkgbmV4dCBzZXJpZXMsIGFmdGVyIHdlIGhhdmUgR2VuZXJhbCBQdXJwb3NlIExvZ2dpbmcg
c3VwcG9ydCwNCkkgaW50ZW5kIHRvIGJ1bXAgdGhlIG1ham9yIHZlcnNpb24gdG8gaW5kaWNhdGUg
QUNTLTUgc3VwcG9ydC4NCkkgd2lsbCBuZWVkIHRvIHZlcmlmeSB0aGF0IHdlIGFyZSBub3QgbWlz
c2luZyBhbnkgb3RoZXIgbWFqb3INCmZlYXR1cmUgZnJvbSBBQ1MtNSBmaXJzdCB0aG91Z2ggKG90
aGVyIHRoYW4gR1BMKS4NCg0KDQpLaW5kIHJlZ2FyZHMsDQpOaWtsYXM=

