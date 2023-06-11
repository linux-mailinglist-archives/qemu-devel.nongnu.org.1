Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D47A272B1BE
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 13:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8JdO-0006r8-Ce; Sun, 11 Jun 2023 07:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1q8JdM-0006r0-0Z
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 07:53:24 -0400
Received: from mail-db3eur04on0621.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::621]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1q8JdK-0007pr-5g
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 07:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qdwl9By+xQoytjGXVbLu/GnUq8oUB9/sWYaKikk9Zi2GzoyhvMG2QG1DGeynOYFT7pbdhgVpXwV0NSBZfFuZ7gqx/nkYhYkrd+fycmy5dcMn16CSow2r99+s9weNsiq/dqLMVHniodWoRLlFlIOPu4i1kDDP8CFPS5U5pd2nQAdFX2O8ESxYrgjeCQoDRXehEbh9raH1mEIwCjApTCjt85Vc818uvyR4OwfPX4Wk+2Ivbs+UOGQtV4wZazhPupLht8oEAZvzyBgOztMJsQvWcD1SCgzcf93+kvV79ns2uCoac6CXKIAQljvTzKD1EvXdYoTkZkbLhIH1ckmvU0yTbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ac+kyGreNuko/6qLj7LrK++Blfh36sZ6mOdhoWXgH8=;
 b=Nx0aWt7gF/koSVuCV+bh8/glFQGXHOWsRTB53Nmh7m6JHlH/Ruy1mbJGEGY4F2/pCWfq2XkUdPcf0SmmWmpmfJNoR6xZEiRIgkqjX0kmYTLee7QAKYegiV5cWSwEqLaG2QXREQb0rP+sB+V/pDHoFTNZ58+sTlVqjfQMd2wZum2NSYi1Qhk+r0mfDV3zHzRoZcueAHdj+869fbL+/gdvWE24QYiqU5NJBzdx/sCB8K7EN4xAsAs+ZG1OZ1+kFDx/mGQsYfQWVVXFk+ekwHyEqkks71kFFeMz+UyjHC2v4xc5XeYCnwOIKObDkAdUhWuJ/JoFnu2V3dErhrwLDIJXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ac+kyGreNuko/6qLj7LrK++Blfh36sZ6mOdhoWXgH8=;
 b=RBtXbKrLLscawRsi6lkg6rfoSjInQrpnYVXtbdv96p6ZayJo0cxcN0DBjoKL9og9w7C62wN8toWfe1Tju5SzZ/2q9QFEcFSJV99sxmPRceBBtgK1pA3Lz7AHP1ppavBTTvSegMbBkSTo7JhbRpqqY8uFngKY48WdzOdPG5Jhmsw=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by VI1PR07MB6606.eurprd07.prod.outlook.com (2603:10a6:800:185::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Sun, 11 Jun
 2023 11:53:17 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::568:2863:92fb:8e85]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::568:2863:92fb:8e85%7]) with mapi id 15.20.6455.030; Sun, 11 Jun 2023
 11:53:17 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH 1/2] target/arm: Handle IC IVAU to improve compatibility with
 JITs
Thread-Topic: [PATCH 1/2] target/arm: Handle IC IVAU to improve compatibility
 with JITs
Thread-Index: AQHZnFtPrEhTrZ0ltkC3c3xO2ZlyFA==
Date: Sun, 11 Jun 2023 11:53:17 +0000
Message-ID: <6fc5af6f04a15a84a862b8d65ab3629891234649.camel@ericsson.com>
References: <833e7382b3fb90a2bbb007932cb5dbb8cfff5a33.camel@ericsson.com>
In-Reply-To: <833e7382b3fb90a2bbb007932cb5dbb8cfff5a33.camel@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|VI1PR07MB6606:EE_
x-ms-office365-filtering-correlation-id: bded32a8-69c2-455f-14b9-08db6a72721a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mc0RgDKTn4PNIe055aDrsuY+a7CNsE0LMZyiECa+h3yYlgkuPEFppHk/ajUhQtA0ZMHc9CK0ijBJZN9hXkoygpIT2LEUuov85TVx+myRrUe6SwCXcIEOd51DYQGz1EuuTYXEwg7N9to6h6v0nhFrc4dIi7N82U32wnEZe5FegfuurwdtIyNzP1xNLYjf3cWBBDzsJzaP/8g8XPQy4tRvdy+l0E69l/joO4/PEAm5hWyH1q7LiWVV+GS8/z4qjynFO8rou3kfnBzex7UWYDsrcjjwH1YFCgaeCzIRg1c6ldtgF8rsDp/D+q8nE8kurQ6yYf2R1r4WbqHD2KNJPDLWAeUKizBJerbOtdzjoVqQJTpdFmcSy2WkmS38Na4I+Is0lQSS8JTKertEKwUGHrfBEaeakJd+5QST+QtEK5x1m9950Vi5beh4weZHXMX1gr0qKmZwjpZmpH1taoTp2fh/Et4nN0gHk6Q2nQepux+1ADjuNIm+jucSKcaYhS2QMNdt7nX8YlJNoLQCzmmtBfaz+xQSogSjor66tpArWi7Brk5+YYYFJ4rOpEWbByKR90Rx/qJqn3V6s7beC+NiACm9Vc4OkaWQ1JnFofj5v1baeY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(966005)(6486002)(316002)(41300700001)(2616005)(83380400001)(186003)(38070700005)(26005)(6506007)(86362001)(66574015)(6512007)(2906002)(82960400001)(122000001)(38100700002)(5660300002)(85182001)(36756003)(8936002)(85202003)(8676002)(66946007)(66556008)(66476007)(76116006)(91956017)(478600001)(71200400001)(66446008)(4326008)(6916009)(64756008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YldqWks0cFNtRzlnaW1FU0podFZKM3pua2N4M24zTm9Cc0hrRXNUUUwrYTUw?=
 =?utf-8?B?VnNsV0I3V0dCTlM2SE5PaE8vWng0TTNIQ2tqa1dnbEFiY0hXYm9XR3QyQWhp?=
 =?utf-8?B?K29DbHUxVXQ0MzB0ckJtbnNzWUczb0hZbHROQ1RHTzA5RFJNZjhjOFNoTEpB?=
 =?utf-8?B?ZEFVN0ZvRkNYV0FmYTZVZ3dWbUQveDRuYUJzWldaM0lhcy9zZ203dFMrRlI1?=
 =?utf-8?B?SVF3TXdkbVFSU3JxSHNKWERwbE1LcUJjRDNqbWZmTzl5azJPTkF0bk1JckV2?=
 =?utf-8?B?cUFjVXMzY0dFMDhib0lUM1A1MHc5a1VtcjBnK2JLZkhrWHpTU0lLK0lneXR3?=
 =?utf-8?B?dmJrRWt5Rk5qMzBKQW1pRy9Xek5JWFFDOGM3RkNwVS9lL0haekdvOVJpZDlv?=
 =?utf-8?B?WWVweW16eVJmanhvcjE5Nk5JWXpEYlI2RlA4T1JxSkdVZTYwTE12WFhhRGlJ?=
 =?utf-8?B?emVEalNTZ0NwTU41dGh6aXJRTUNaS2tYNDNVdWJQdWZzWVpxV1p1SU1HSjFT?=
 =?utf-8?B?NWtCazhTWXREL0VEeXZCclR6MFFETEUzSHNZZzYyMSt2d2V4Z3FRa0tnaGZE?=
 =?utf-8?B?UkNnYmJ2akwwZzlvQnA1ZjJSK0FsZ2dhWDFRTFVIOEgxQUdTZmEwTklURGJN?=
 =?utf-8?B?RWRPZXJBL1lwMFlsdXR1VVhWVmV4L3R2Q29wMk0zcEhldHJyNy9RL2xRTVNm?=
 =?utf-8?B?MlhFcndrMGFTTC9nOFlZZVVHOURsV3hsaUN6aWZ6a1dXUnBZajQvTHNqaEJZ?=
 =?utf-8?B?WExPbGdrTUNEa0s0cHJCQ25weCsyVFRoaWUvVy9mZDA3SVRraWR6YTF2R21X?=
 =?utf-8?B?STUvSHNRcm85SUZhRytEaVZwbmMvcXM4K1BSdlZDTDluc0c3cEtpcXRrbytu?=
 =?utf-8?B?RFVWUGprZmUrTkM0dkZQT2hVYjE1QUg4VnpBMmp6Y2xqRkVoOVkzbmVPek5n?=
 =?utf-8?B?KzZkekhPZjJDTnplUFI4NDdBNG1kVTlKT0M4bC9OZnlLM0p6NlZpdWJaWWJX?=
 =?utf-8?B?MlVLUDdXd09tVUZ5RnRKN0MydndweUdSOHZJSHFPb3FqVEw2SjREaGdxT1lY?=
 =?utf-8?B?WCsrcGU4M1MwR2x5anFmNUx0aWU0eWM0R0h3UlJXZjc2TE1lYlJ1Y200ZHI2?=
 =?utf-8?B?NzNHUmVKby82RU5MWitBU1NySU4yeEM3MXJBL2xtaWttVC9VbFZlbTB3NUFD?=
 =?utf-8?B?NDhsem9JVncxUTIzTHFqOEZvRC9FSCtaVXcwR1JmT1VBWFdxTzFRaWtqOUR0?=
 =?utf-8?B?cHhlaTIyVWlUR2xqbDJZenVtelF6UHF5KzNlNnpYTjRMYTBpNUJ2UW9DQmV1?=
 =?utf-8?B?WEhuMXF2TnF4TzIvVW05bXJhZzJlNklSZEtiY3d3eGJlaXI1Y1REVk81YWZy?=
 =?utf-8?B?bVFNT2NLRWpoQWFCZnlsSVloNjViOHl5YkxicUgybEtmYXAvTDhnMVllTitI?=
 =?utf-8?B?cVBLZFI4UCtMMks0c1ZIVGdPZjZzVjJGOS9lcU5hbG16bkxZNjZiOFVnYXJi?=
 =?utf-8?B?bnd1QXUyck9Vc25VS1hrZFU2dmFhcXNhNVh2VCtqM0p2dDhPRDAxQ2hrWk50?=
 =?utf-8?B?S0dhR3JncTk5ejNwd2NVRFBrOTgwTlhNV0RqdjRTTUxEc1p3SWhWMndINWtU?=
 =?utf-8?B?ZHFZbDA5MjVTQXp6SXM4ZFlFQ21uRVU5c0xVaXJ0cElsQTRyZFIrby84a1Bv?=
 =?utf-8?B?TEFzNnFaK3gzWE1OYkZoS0dZYmNid2Q4WWd6U202Vno1a1lUQjdiNCtwOXNL?=
 =?utf-8?B?Y29XOWxNNk9KVkNacGoxRnhUWGNVeHBpZWxGeFkyMFAwb1YxK1R3WGo0aUk0?=
 =?utf-8?B?T3pCT2xtV2xLL0MxbDBoYXRiZVFNY1ZJQ2ZYNlVBdThJMWZKY2tQYlgzS3hs?=
 =?utf-8?B?ZDh5SEhtZlM3aHBnbkxQYlVTa0VYMlFOaEhrc1hUS1VuM2FXTFdmMlpYYzdw?=
 =?utf-8?B?Nyt0RzNqRjRDNHY0d1pEa21BWFRlNXJ0Y1d5NU5raWJmVmJGQWs0Ui9tT015?=
 =?utf-8?B?QWZFUU1rdDdaUjVyQ2RoNk9mbjRzdC9qTGtSQUwxZG1acnE4eGplY2NmN3Rh?=
 =?utf-8?B?NjZHbmk0RUxrU2JmQmRPcFdnUmFiL1dCUGZRQlQ2OThTSWtaL2U0SFFEeDVw?=
 =?utf-8?B?R0lOOUhUU1JTeUZaWWpwYU13bW1rVkw2MHRRMjR6R1pjckdQMm5QYjBJZFZ4?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27FC9ED308F033429CAEA166BF378D90@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bded32a8-69c2-455f-14b9-08db6a72721a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 11:53:17.5998 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKV8T9MF0hCMSAkf6VpxYj8dAE7HbafMY+UB/1wE8KpcyQbxbt02MHDYa0UlrnVYp3VbWKrW8FCnYU893+JR+JY86hLkU3+D3Jv0atVDZM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6606
Received-SPF: pass client-ip=2a01:111:f400:fe0c::621;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

VW5saWtlIGFyY2hpdGVjdHVyZXMgd2l0aCBwcmVjaXNlIHNlbGYtbW9kaWZ5aW5nIGNvZGUgc2Vt
YW50aWNzDQooZS5nLiB4ODYpIEFSTSBwcm9jZXNzb3JzIGRvIG5vdCBtYWludGFpbiBjb2hlcmVu
Y3kgZm9yIGluc3RydWN0aW9uDQpleGVjdXRpb24gYW5kIG1lbW9yeSwgYW5kIHJlcXVpcmUgdGhl
IGV4cGxpY2l0IHVzZSBvZiBjYWNoZQ0KbWFuYWdlbWVudCBpbnN0cnVjdGlvbnMgYXMgd2VsbCBh
cyBhbiBpbnN0cnVjdGlvbiBiYXJyaWVyIHRvIG1ha2UNCmNvZGUgdXBkYXRlcyB2aXNpYmxlICh0
aGUgbGF0dGVyIG9uIGV2ZXJ5IGNvcmUgdGhhdCBpcyBnb2luZyB0bw0KZXhlY3V0ZSBzYWlkIGNv
ZGUpLg0KDQpXaGlsZSB0aGlzIGlzIHJlcXVpcmVkIHRvIG1ha2UgSklUcyB3b3JrIG9uIGFjdHVh
bCBoYXJkd2FyZSwgUUVNVQ0KaGFzIGdvdHRlbiBhd2F5IHdpdGggbm90IGhhbmRsaW5nIHRoaXMg
c2luY2UgaXQgZG9lcyBub3QgZW11bGF0ZQ0KY2FjaGVzLCBhbmQgdW5jb25kaXRpb25hbGx5IGlu
dmFsaWRhdGVzIGNvZGUgd2hlbmV2ZXIgdGhlIHNvZnRtbXUNCm9yIHRoZSB1c2VyLW1vZGUgcGFn
ZSBwcm90ZWN0aW9uIGxvZ2ljIGRldGVjdHMgdGhhdCBjb2RlIGhhcyBiZWVuDQptb2RpZmllZC4N
Cg0KVW5mb3J0dW5hdGVseSB0aGUgbGF0dGVyIGRvZXMgbm90IHdvcmsgaW4gdGhlIGZhY2Ugb2Yg
ZHVhbC1tYXBwZWQNCmNvZGUgKGEgY29tbW9uIFdeWCB3b3JrYXJvdW5kKSwgd2hlcmUgb25lIHBh
Z2UgaXMgZXhlY3V0YWJsZSBhbmQNCnRoZSBvdGhlciBpcyB3cml0YWJsZTogdXNlci1tb2RlIGhh
cyBubyB3YXkgdG8gY29ubmVjdCBvbmUgd2l0aCB0aGUNCm90aGVyIGFzIHRoYXQgaXMgb25seSBr
bm93biB0byB0aGUga2VybmVsIGFuZCB0aGUgZW11bGF0ZWQNCmFwcGxpY2F0aW9uLg0KDQpUaGlz
IGNvbW1pdCB3b3JrcyBhcm91bmQgdGhlIGlzc3VlIGJ5IGludmFsaWRhdGluZyBjb2RlIGluDQpJ
QyBJVkFVIGluc3RydWN0aW9ucy4NCg0KUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11
LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8xMDM0DQoNCkNvLWF1dGhvcmVkLWJ5OiBSaWNoYXJkIEhl
bmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NClNpZ25lZC1vZmYtYnk6IEpv
aG4gSMO2Z2JlcmcgPGpvaG4uaG9nYmVyZ0Blcmljc3Nvbi5jb20+DQotLS0NCiB0YXJnZXQvYXJt
L2hlbHBlci5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5jIGIvdGFyZ2V0L2FybS9oZWxwZXIuYw0K
aW5kZXggZDRiZWU0M2JkMC4uMjM1ZTNjZDBiNiAxMDA2NDQNCi0tLSBhL3RhcmdldC9hcm0vaGVs
cGVyLmMNCisrKyBiL3RhcmdldC9hcm0vaGVscGVyLmMNCkBAIC01MjI4LDYgKzUyMjgsMzYgQEAg
c3RhdGljIHZvaWQgbWRjcl9lbDJfd3JpdGUoQ1BVQVJNU3RhdGUgKmVudiwNCmNvbnN0IEFSTUNQ
UmVnSW5mbyAqcmksDQogICAgIH0NCiB9DQogDQorI2lmZGVmIENPTkZJR19VU0VSX09OTFkNCisv
Kg0KKyAqIGBJQyBJVkFVYCBpcyBoYW5kbGVkIHRvIGltcHJvdmUgY29tcGF0aWJpbGl0eSB3aXRo
IEpJVHMgdGhhdCBkdWFsLQ0KbWFwIHRoZWlyDQorICogY29kZSB0byBnZXQgYXJvdW5kIFdeWCBy
ZXN0cmljdGlvbnMsIHdoZXJlIG9uZSByZWdpb24gaXMgd3JpdGFibGUNCmFuZCB0aGUNCisgKiBv
dGhlciBpcyBleGVjdXRhYmxlLg0KKyAqDQorICogU2luY2UgdGhlIGV4ZWN1dGFibGUgcmVnaW9u
IGlzIG5ldmVyIHdyaXR0ZW4gdG8gd2UgY2Fubm90IGRldGVjdA0KY29kZQ0KKyAqIGNoYW5nZXMg
d2hlbiBydW5uaW5nIGluIHVzZXIgbW9kZSwgYW5kIHJlbHkgb24gdGhlIGVtdWxhdGVkIEpJVA0K
dGVsbGluZyB1cw0KKyAqIHRoYXQgdGhlIGNvZGUgaGFzIGNoYW5nZWQgYnkgZXhlY3V0aW5nIHRo
aXMgaW5zdHJ1Y3Rpb24uDQorICovDQorc3RhdGljIHZvaWQgaWNfaXZhdV93cml0ZShDUFVBUk1T
dGF0ZSAqZW52LCBjb25zdCBBUk1DUFJlZ0luZm8gKnJpLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgdWludDY0X3QgdmFsdWUpDQorew0KKyAgICB1aW50NjRfdCBpY2FjaGVfbGluZV9tYXNr
LCBzdGFydF9hZGRyZXNzLCBlbmRfYWRkcmVzczsNCisgICAgY29uc3QgQVJNQ1BVICpjcHU7DQor
DQorICAgIGNwdSA9IGVudl9hcmNoY3B1KGVudik7DQorDQorICAgIGljYWNoZV9saW5lX21hc2sg
PSAoNCA8PCBleHRyYWN0MzIoY3B1LT5jdHIsIDAsIDQpKSAtIDE7DQorICAgIHN0YXJ0X2FkZHJl
c3MgPSB2YWx1ZSAmIH5pY2FjaGVfbGluZV9tYXNrOw0KKyAgICBlbmRfYWRkcmVzcyA9IHZhbHVl
IHwgaWNhY2hlX2xpbmVfbWFzazsNCisNCisgICAgbW1hcF9sb2NrKCk7DQorDQorICAgIHRiX2lu
dmFsaWRhdGVfcGh5c19yYW5nZShzdGFydF9hZGRyZXNzLCBlbmRfYWRkcmVzcyk7DQorDQorICAg
IG1tYXBfdW5sb2NrKCk7DQorfQ0KKyNlbmRpZg0KKw0KIHN0YXRpYyBjb25zdCBBUk1DUFJlZ0lu
Zm8gdjhfY3BfcmVnaW5mb1tdID0gew0KICAgICAvKg0KICAgICAgKiBNaW5pbWFsIHNldCBvZiBF
TDAtdmlzaWJsZSByZWdpc3RlcnMuIFRoaXMgd2lsbCBuZWVkIHRvIGJlDQpleHBhbmRlZA0KQEAg
LTUyNjcsNyArNTI5NywxMCBAQCBzdGF0aWMgY29uc3QgQVJNQ1BSZWdJbmZvIHY4X2NwX3JlZ2lu
Zm9bXSA9IHsNCiAgICAgeyAubmFtZSA9ICJDVVJSRU5URUwiLCAuc3RhdGUgPSBBUk1fQ1BfU1RB
VEVfQUE2NCwNCiAgICAgICAub3BjMCA9IDMsIC5vcGMxID0gMCwgLm9wYzIgPSAyLCAuY3JuID0g
NCwgLmNybSA9IDIsDQogICAgICAgLmFjY2VzcyA9IFBMMV9SLCAudHlwZSA9IEFSTV9DUF9DVVJS
RU5URUwgfSwNCi0gICAgLyogQ2FjaGUgb3BzOiBhbGwgTk9QcyBzaW5jZSB3ZSBkb24ndCBlbXVs
YXRlIGNhY2hlcyAqLw0KKyAgICAvKg0KKyAgICAgKiBJbnN0cnVjdGlvbiBjYWNoZSBvcHMuIEFs
bCBvZiB0aGVzZSBleGNlcHQgYElDIElWQVVgIE5PUA0KYmVjYXVzZSB3ZQ0KKyAgICAgKiBkb24n
dCBlbXVsYXRlIGNhY2hlcy4NCisgICAgICovDQogICAgIHsgLm5hbWUgPSAiSUNfSUFMTFVJUyIs
IC5zdGF0ZSA9IEFSTV9DUF9TVEFURV9BQTY0LA0KICAgICAgIC5vcGMwID0gMSwgLm9wYzEgPSAw
LCAuY3JuID0gNywgLmNybSA9IDEsIC5vcGMyID0gMCwNCiAgICAgICAuYWNjZXNzID0gUEwxX1cs
IC50eXBlID0gQVJNX0NQX05PUCwNCkBAIC01MjgwLDkgKzUzMTMsMTcgQEAgc3RhdGljIGNvbnN0
IEFSTUNQUmVnSW5mbyB2OF9jcF9yZWdpbmZvW10gPSB7DQogICAgICAgLmFjY2Vzc2ZuID0gYWNj
ZXNzX3RvY3UgfSwNCiAgICAgeyAubmFtZSA9ICJJQ19JVkFVIiwgLnN0YXRlID0gQVJNX0NQX1NU
QVRFX0FBNjQsDQogICAgICAgLm9wYzAgPSAxLCAub3BjMSA9IDMsIC5jcm4gPSA3LCAuY3JtID0g
NSwgLm9wYzIgPSAxLA0KLSAgICAgIC5hY2Nlc3MgPSBQTDBfVywgLnR5cGUgPSBBUk1fQ1BfTk9Q
LA0KKyAgICAgIC5hY2Nlc3MgPSBQTDBfVywNCiAgICAgICAuZmd0ID0gRkdUX0lDSVZBVSwNCi0g
ICAgICAuYWNjZXNzZm4gPSBhY2Nlc3NfdG9jdSB9LA0KKyAgICAgIC5hY2Nlc3NmbiA9IGFjY2Vz
c190b2N1LA0KKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZDQorICAgICAgLnR5cGUgPSBBUk1fQ1Bf
Tk9fUkFXLA0KKyAgICAgIC53cml0ZWZuID0gaWNfaXZhdV93cml0ZQ0KKyNlbHNlDQorICAgICAg
LnR5cGUgPSBBUk1fQ1BfTk9QDQorI2VuZGlmDQorICAgIH0sDQorICAgIC8qIENhY2hlIG9wczog
YWxsIE5PUHMgc2luY2Ugd2UgZG9uJ3QgZW11bGF0ZSBjYWNoZXMgKi8NCiAgICAgeyAubmFtZSA9
ICJEQ19JVkFDIiwgLnN0YXRlID0gQVJNX0NQX1NUQVRFX0FBNjQsDQogICAgICAgLm9wYzAgPSAx
LCAub3BjMSA9IDAsIC5jcm4gPSA3LCAuY3JtID0gNiwgLm9wYzIgPSAxLA0KICAgICAgIC5hY2Nl
c3MgPSBQTDFfVywgLmFjY2Vzc2ZuID0gYWE2NF9jYWNoZW9wX3BvY19hY2Nlc3MsDQotLSANCjIu
MzQuMQ0KDQoNCg==

