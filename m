Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8587EEABA
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 02:35:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3nkt-00047K-Gv; Thu, 16 Nov 2023 20:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r3nkk-0003nA-Cd; Thu, 16 Nov 2023 20:34:40 -0500
Received: from mail-tyzapc01on20600.outbound.protection.outlook.com
 ([2a01:111:f403:2011::600]
 helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <KFTING@nuvoton.com>)
 id 1r3nkh-00018w-RF; Thu, 16 Nov 2023 20:34:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXaxHv+BaY2QMqkOsDIbYFJfFob98EJGBnV2BY6MIk6iP+UnMf6vwwrcJwHlEPDG+XqBrjlfMFRhj2XzgOyuJJlH539YHrtIW5g7+ArXmW3dFqK4geU0tnqGHrJgWxqViNc02jURAn9+CVJvt/GCNNZ0zV2/mWVGCfBVTlTHqzMpU/sBAP8SuevUUlnKoa/WGqfQf8ycd7s7OfTdemRSaFrR/EYiVN4Rw8K6AlTOIerVqss8Ph0zLk8craiuLoPI/+tfpsCtJw8K8BFThl+nqze0t08Qnxd89RHvFVKFAmXpp5ZO21q9D2kvBIYIzgVfEP8L1A9w7b4NoQg+89y2nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGSZTpQR+zyDG4RxXlKg33JsQ3bNWC2jcXdBb1joOJI=;
 b=K0uxL5thF65XXrRd6o1RfOSSG8fke2HxPyqWc+LPoS59K+oKVCwp00Xru4IIgc+/fviPLgEobjfU7xBi3iasSfI0d7BDEHZY7HurK+avIQIUM9Mrb2C9etxqFs+5RHT/tZf9dK6E9YYjcnI6Lt/S0IKxhR/18p5FWoRmeovRChpCUmvhNfhXWksr3wrjXk5bElI/257KJ4gepep78sOYKNI2h5evwxTVGpKMnk1/+b/cg2Jz+QvUsQfRUfEvNa+5dJDH20l5rusQRwQfrUXOcEV/Nyot16insZn9w3ixsLWqhycg2UCQ5PKO6obVxE1u9VtDWbdQ81ERrVm9/hGbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGSZTpQR+zyDG4RxXlKg33JsQ3bNWC2jcXdBb1joOJI=;
 b=SPsCb+6UaV1V0zE7aRoBhdPrC4FwD6jilN1tA1OKLGDF44w/42TsE+0PXfQnirCRwgnuMfYE0Hl9h9GCI55o6cjjv/pnWBLf1/mBtfIcSs+ukdvQErZCMj7pflVSYhAMVkRf3Gr6eV99ieToZ95Iyop+VqP82JoZoAJRHzEHFBQ=
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com (2603:1096:820:ed::12)
 by SEZPR03MB7417.apcprd03.prod.outlook.com (2603:1096:101:10e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Fri, 17 Nov
 2023 01:34:31 +0000
Received: from KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b]) by KL1PR03MB7744.apcprd03.prod.outlook.com
 ([fe80::1947:30aa:d3b2:ac3b%5]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 01:34:30 +0000
From: "KFTING@nuvoton.com" <KFTING@nuvoton.com>
To: Nabih Estefan <nabihestefan@google.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "jasonwang@redhat.com" <jasonwang@redhat.com>, "Avi.Fishman@nuvoton.com"
 <Avi.Fishman@nuvoton.com>, "KWLIU@nuvoton.com" <KWLIU@nuvoton.com>,
 "tomer.maimon@nuvoton.com" <tomer.maimon@nuvoton.com>,
 "Hila.Miranda-Kuzi@nuvoton.com" <Hila.Miranda-Kuzi@nuvoton.com>
Subject: RE: [PATCH v5 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
Thread-Topic: [PATCH v5 02/11] hw/arm: Add PCI mailbox module to Nuvoton SoC
Thread-Index: AQHaCP7OEIIn+RaAbkGYKqaTRccfUrB3tl4AgAYj5SA=
Date: Fri, 17 Nov 2023 01:34:30 +0000
Message-ID: <KL1PR03MB7744B4C5870E8A684C522D69DBB7A@KL1PR03MB7744.apcprd03.prod.outlook.com>
References: <20231027175532.3601297-1-nabihestefan@google.com>
 <20231027175532.3601297-3-nabihestefan@google.com>
 <KL1PR03MB7744EF7DCA386E8E8E79C645DBB3A@KL1PR03MB7744.apcprd03.prod.outlook.com>
In-Reply-To: <KL1PR03MB7744EF7DCA386E8E8E79C645DBB3A@KL1PR03MB7744.apcprd03.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB7744:EE_|SEZPR03MB7417:EE_
x-ms-office365-filtering-correlation-id: fb8196a0-0c5d-4756-1fae-08dbe70d588b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDE4pqR/tFQjEALPNC2dUJdIxAcssE+vunuV8QZ/UvA+msE4N1uw46cHFdk7B+Al3wLW0i9dBn47H3LsPjlcZK6hVVjlcjdo5oP2cnQTbx8+mcDOCDgGFUUzb1PkS5H22y1j71E6w7RucLH06zph6TTVr8vO4cbN7X54vHF0MTwRI2gm5tFrHcB3lv8GtCWO7dBQKME+/2vR9YnK4Bb2fx+xv7qB8Lr4Ksq6sQCtGRQn0/xIjcl4TmBjIGOBWcOIz7Xx+V6xdgr0bBN6r21zJIZeXgfwwo9EI4dn2Dc1XPzKNwIMoSErJ4iLujZpbwupZiFDbzw3Q9IUw3KPlFJBaLUFBWvXvU5SCyOhwD4JJHzmQGYwDFTNWnhRioXsBEhT5Lwca2OHyRLETXzOpLlFaf/dkCvY1BJDMEkfkbAkVOdN/m7mWbAYd8UUxFh3I2cfOQbxTXYdsuzqJFwWslqJ9LDdB/ht+AGDZ0LE6TXvTlRo2L1S5HA76SXJ5e/CXx8jt7+Nyhz4DUN31f0/LteOqpDOZo0Xt0AXPvoCHnux2PBAF5YhEkYH7eMPVSINeF4KLYIP2u1OFZGaWjaO0GggTWcTlPVZjUUH39xsG0NpQR2SQbK9YzXynQHMyK59N3mS9Fk4ukasIsrSVC5YOqeem98Hj8t+nlmk3LLdSDTI9cU/m6qGKcvIEPCck4+sli5eGdzMDoDWy5ro5kDE7ZYGGw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR03MB7744.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799009)(451199024)(15650500001)(2906002)(33656002)(41300700001)(316002)(107886003)(54906003)(66556008)(64756008)(66446008)(66476007)(55016003)(71200400001)(38070700009)(8936002)(52536014)(38100700002)(8676002)(76116006)(66946007)(4326008)(110136005)(478600001)(19627235002)(86362001)(5660300002)(122000001)(83380400001)(7696005)(6506007)(26005)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmdFWkltS1FQRUdJK3AvQUt4WnhLaDVlTTkvN1Z5R0FBMDZ5cm5kcDFab1I1?=
 =?utf-8?B?Ti9iMGVjUVFLS2ZxRU9YTXZQdklFUCt0U21kYTkxekZHWEVmc1kwRmN2QmFP?=
 =?utf-8?B?Nnp6L3JyemE4YlEyekJVT0hQakd4T0hTSkl2RnFLVXRWTlZ6Q1A2SzFXYnRn?=
 =?utf-8?B?Qkc0RUttc0xVbkRLRVdxbjhnbThnWWY1VFp2RVZla0x0eGZodTFCSzNCN243?=
 =?utf-8?B?WC9XdXNMdmhkY0EwMzNub1NGa0U5eFFmbzlPVG1VM2ZuSlhqUFB2ZkUxeWFy?=
 =?utf-8?B?VDh0VGx4UndOMEViRnA5eVBpVFhjQnZDOUxFUkVhaWRveW1vaElPNmJLUVZN?=
 =?utf-8?B?K2dRNzA2MjN6NVR3UzV3dzIwVjN3NUk1UCtLZU5JT2JGZHN5RGwrd3hxVzJx?=
 =?utf-8?B?d2JuK1RmVVNIZVU3Vm9kOGc4aEtUSmxUTTRhWTY0VExINTJRZzM4czJyWGow?=
 =?utf-8?B?MEtiT01qcml4QWpQYlp2WGRiQ0pWc1Jhb2d5dGsrcTZ1eTk2T1VYdmxJeHJn?=
 =?utf-8?B?VDBYYVRwMTZ4dG8rSlpyZ1JmTnRnR0FZa1J6czB0UlAxUS9BY1JCTHpFU24w?=
 =?utf-8?B?NXFvM1lvQXlTYkdNS1ZGdVJqaFdVLys5QjR1OU9ZQitxMnlBNHpCejJxb1Vi?=
 =?utf-8?B?N2UzTnNxQjBYTzY5NHU4TmNoWDFBOFp6cFl5MU1QTEt1NjhzUDRHVktmd1FR?=
 =?utf-8?B?aWNqL2N3TU95cEJydTkvc0x2VGpLK3lUWGJnVU5JQURZem1wODFOWWErRU5G?=
 =?utf-8?B?YTZKcUU4NHJsdTBQN2RBaTZya3AvVGtsREtuOHNiMkdVR0dHditUVlh2clZt?=
 =?utf-8?B?QnlHSWRDbjQzVTc1eXM2bjloUG9ONzBkcmFUdzJxcTFmNVBIZFRrRXdjdTNw?=
 =?utf-8?B?RmxJRHBiZGFpa2xKeVJaUEVDU09IWTJoenczWVg4eWh4MVU2ZG0wZVRpQ2Zk?=
 =?utf-8?B?SHM5MUN2RkdnWkVBM1piOTBWa1Q3YlQxQjlXeXZkM0Z1OVBDSUt4RytWcHlG?=
 =?utf-8?B?MGR4VVBZMjJJUkhpTXNtN2lYY3JCS1R2SGdObEIycy91SFp4SG5vRElHRDlT?=
 =?utf-8?B?SjY5cFM0blZsWW9lVVMwbzAyaEdJSVZtN2pDRmwrdEV6ZVJwSi9ESUMrY1Zz?=
 =?utf-8?B?Sm5INjdQanFSRUZFZHRZUk1panRtZy9INW54ZktBYkNoVHFiMDZWTTVtSG0x?=
 =?utf-8?B?V3FuaENDRTBJVjZXaHIwRlVaZTU0ZVFacGtqd21pREJmbENWNU4yUVlyQnFt?=
 =?utf-8?B?NTdhT0RLZnVlNG1GczVmNXhqYU1pSnVwRm52WXoyVGVzVHpSUkNzM0NFQXFI?=
 =?utf-8?B?UmhaUEJmOVBaMXpSM1BDNXNaL2hWcWZHWjNvKzk3MU5pTWYyczhMc3Jwb3Vq?=
 =?utf-8?B?QjMwMlAxSnd4QWVrcWtmUlZ0NUErQUlhbUhOMkxjcDhTMkZXNzdsWVpSWEEy?=
 =?utf-8?B?RDRtOXBuNlhBdUliYkU2TjlWY0RPRjh3aGVaVjF0L0NsREdCcXZ0NVlGcHFL?=
 =?utf-8?B?dFFZd0FRaUVXYXBPbjNsYVJwZkJ5Y0Z6RXpkNFU2dzQ0VTRhNWNBWHd0RlJz?=
 =?utf-8?B?emtEWk92ZVFxeGxiaU1IS084akJFZ2FpWTdsNEJGZDNLT2Rqbi9iVXFHbGxO?=
 =?utf-8?B?ZkVuMmd4WG1YZmlUYks5Z0hzTGMydG9UbEtIYXlJOFUzLzYvSnFtOEE4TkE4?=
 =?utf-8?B?VVFRTk9laHdyeVo1OTd1TUthaDRSemx4SFpNL0hzMmtwenpkdkhBbzRMRFNR?=
 =?utf-8?B?eTFUcUVYaTkzNkp5Z0prLy8zdGdkbG0rRXdIWWM0Y252aFRJMW8zT1FLRzhI?=
 =?utf-8?B?SUVFYXlqN0lNenpEWGtyWWJFbFg0M2paa2RuS0RlcWdpUnpmQkZGZW8yQVp3?=
 =?utf-8?B?VFcwTlpxTXZwSUhRWHdzZUlhTnhEckZpV2M2YnFLbUZIOTUrSDd6cFVYeFhl?=
 =?utf-8?B?QSsvQ0VJLzBOcVBKU01SZVhwUUw3QldVVnN6QzA5b0pQTnlFaDVFZFYxWUxa?=
 =?utf-8?B?Qno1Y0o1bFYrSGtmQk1BZ3Y4aWxoVWp0NmJZMnZYNGRJNVB4ZVJGSWt1eG1i?=
 =?utf-8?B?czExNE1CKzhiN25DZzZkMi9JU2J2MmRabnFIdXVpQ3lIL3RtRDNwMm9aU2hD?=
 =?utf-8?Q?7EDS/VvDVM2p5Pqz0IOfXjh5J?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7744.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8196a0-0c5d-4756-1fae-08dbe70d588b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 01:34:30.8717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOphnN9lR+gyUZH+DDQ4dtAdrwojqRPP6QIors2X7CXSzf6+hQ3vv1s7N+yiuSDslNhUf/vBcwhLaSHieEeKig==
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

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBDUzIwIEtGVGluZw0KU2VudDog
TW9uZGF5LCBOb3ZlbWJlciAxMywgMjAyMyAxMTo0OSBBTQ0KVG86IE5hYmloIEVzdGVmYW4gPG5h
YmloZXN0ZWZhbkBnb29nbGUuY29tPjsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpDYzogcWVt
dS1hcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyB3dWhhb3RzaEBnb29nbGUu
Y29tOyBqYXNvbndhbmdAcmVkaGF0LmNvbTsgSVMyMCBBdmkgRmlzaG1hbiA8QXZpLkZpc2htYW5A
bnV2b3Rvbi5jb20+OyBDUzIwIEtXTGl1IDxLV0xJVUBudXZvdG9uLmNvbT47IElTMjAgVG9tZXIg
TWFpbW9uIDx0b21lci5tYWltb25AbnV2b3Rvbi5jb20+OyBJTjIwIEhpbGEgTWlyYW5kYS1LdXpp
IDxIaWxhLk1pcmFuZGEtS3V6aUBudXZvdG9uLmNvbT4NClN1YmplY3Q6IFJFOiBbUEFUQ0ggdjUg
MDIvMTFdIGh3L2FybTogQWRkIFBDSSBtYWlsYm94IG1vZHVsZSB0byBOdXZvdG9uIFNvQw0KDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE5hYmloIEVzdGVmYW4gPG5hYmlo
ZXN0ZWZhbkBnb29nbGUuY29tPg0KU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMjgsIDIwMjMgMTo1
NSBBTQ0KVG86IHBldGVyLm1heWRlbGxAbGluYXJvLm9yZw0KQ2M6IHFlbXUtYXJtQG5vbmdudS5v
cmc7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgQ1MyMCBLRlRpbmcgPEtGVElOR0BudXZvdG9uLmNv
bT47IHd1aGFvdHNoQGdvb2dsZS5jb207IGphc29ud2FuZ0ByZWRoYXQuY29tOyBJUzIwIEF2aSBG
aXNobWFuIDxBdmkuRmlzaG1hbkBudXZvdG9uLmNvbT47IG5hYmloZXN0ZWZhbkBnb29nbGUuY29t
OyBDUzIwIEtXTGl1IDxLV0xJVUBudXZvdG9uLmNvbT47IElTMjAgVG9tZXIgTWFpbW9uIDx0b21l
ci5tYWltb25AbnV2b3Rvbi5jb20+OyBJTjIwIEhpbGEgTWlyYW5kYS1LdXppIDxIaWxhLk1pcmFu
ZGEtS3V6aUBudXZvdG9uLmNvbT4NClN1YmplY3Q6IFtQQVRDSCB2NSAwMi8xMV0gaHcvYXJtOiBB
ZGQgUENJIG1haWxib3ggbW9kdWxlIHRvIE51dm90b24gU29DDQoNCkNBVVRJT04gLSBFeHRlcm5h
bCBFbWFpbDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlv
dSBhY2tub3dsZWRnZSB0aGUgc2VuZGVyIGFuZCBjb250ZW50Lg0KDQoNCkZyb206IEhhbyBXdSA8
d3VoYW90c2hAZ29vZ2xlLmNvbT4NCg0KVGhpcyBwYXRjaCB3aXJlcyB0aGUgUENJIG1haWxib3gg
bW9kdWxlIHRvIE51dm90b24gU29DLg0KDQpDaGFuZ2UtSWQ6IEk5NDIxZmY2YmM3ZDM2NWIwNTU5
YzBhMWY2Yjk4Y2ZkMjRiNmYyZDlmDQpTaWduZWQtb2ZmLWJ5OiBIYW8gV3UgPHd1aGFvdHNoQGdv
b2dsZS5jb20+DQpTaWduZWQtb2ZmLWJ5OiBOYWJpaCBFc3RlZmFuIDxuYWJpaGVzdGVmYW5AZ29v
Z2xlLmNvbT4NCi0tLQ0KIGRvY3Mvc3lzdGVtL2FybS9udXZvdG9uLnJzdCB8IDIgKysNCiBody9h
cm0vbnBjbTd4eC5jICAgICAgICAgICAgfCAzICsrLQ0KIGluY2x1ZGUvaHcvYXJtL25wY203eHgu
aCAgICB8IDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQoNCmRpZmYgLS1naXQgYS9kb2NzL3N5c3RlbS9hcm0vbnV2b3Rvbi5yc3QgYi9kb2NzL3N5
c3RlbS9hcm0vbnV2b3Rvbi5yc3QgaW5kZXggMDQyNGNhZTRiMC4uZTYxMTA5OTU0NSAxMDA2NDQN
Ci0tLSBhL2RvY3Mvc3lzdGVtL2FybS9udXZvdG9uLnJzdA0KKysrIGIvZG9jcy9zeXN0ZW0vYXJt
L251dm90b24ucnN0DQpAQCAtNTAsNiArNTAsOCBAQCBTdXBwb3J0ZWQgZGV2aWNlcw0KICAqIEV0
aGVybmV0IGNvbnRyb2xsZXIgKEVNQykNCiAgKiBUYWNob21ldGVyDQogICogUGVyaXBoZXJhbCBT
UEkgY29udHJvbGxlciAoUFNQSSkNCisgKiBCSU9TIFBPU1QgY29kZSBGSUZPDQorICogUENJIE1h
aWxib3gNCg0KIE1pc3NpbmcgZGV2aWNlcw0KIC0tLS0tLS0tLS0tLS0tLQ0KZGlmZiAtLWdpdCBh
L2h3L2FybS9ucGNtN3h4LmMgYi9ody9hcm0vbnBjbTd4eC5jIGluZGV4IGM2OWU5MzY2NjkuLmM5
ZTg3MTYyY2IgMTAwNjQ0DQotLS0gYS9ody9hcm0vbnBjbTd4eC5jDQorKysgYi9ody9hcm0vbnBj
bTd4eC5jDQpAQCAtODYsNyArODYsNiBAQCBlbnVtIE5QQ003eHhJbnRlcnJ1cHQgew0KICAgICBO
UENNN1hYX1VBUlQxX0lSUSwNCiAgICAgTlBDTTdYWF9VQVJUMl9JUlEsDQogICAgIE5QQ003WFhf
VUFSVDNfSVJRLA0KLSAgICBOUENNN1hYX1BFQ0lfSVJRICAgICAgICAgICAgPSA2LA0KICAgICBO
UENNN1hYX1BDSV9NQk9YX0lSUSAgICAgICAgPSA4LA0KICAgICBOUENNN1hYX0tDU19ISUJfSVJR
ICAgICAgICAgPSA5LA0KICAgICBOUENNN1hYX0dNQUMxX0lSUSAgICAgICAgICAgPSAxNCwNCkBA
IC00NjMsNiArNDYyLDggQEAgc3RhdGljIHZvaWQgbnBjbTd4eF9pbml0KE9iamVjdCAqb2JqKQ0K
ICAgICAgICAgb2JqZWN0X2luaXRpYWxpemVfY2hpbGQob2JqLCAicHNwaVsqXSIsICZzLT5wc3Bp
W2ldLCBUWVBFX05QQ01fUFNQSSk7DQogICAgIH0NCg0KKyAgICBvYmplY3RfaW5pdGlhbGl6ZV9j
aGlsZChvYmosICJwY2ktbWJveCIsICZzLT5wY2lfbWJveCwNCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVFlQRV9OUENNN1hYX1BDSV9NQk9YKTsNCiAgICAgb2JqZWN0X2luaXRpYWxpemVf
Y2hpbGQob2JqLCAibW1jIiwgJnMtPm1tYywgVFlQRV9OUENNN1hYX1NESENJKTsgIH0NCg0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvYXJtL25wY203eHguaCBiL2luY2x1ZGUvaHcvYXJtL25wY203
eHguaCBpbmRleCAyNzMwOTBhYzYwLi5jZWMzNzkyYTJlIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9o
dy9hcm0vbnBjbTd4eC5oDQorKysgYi9pbmNsdWRlL2h3L2FybS9ucGNtN3h4LmgNCkBAIC0xMDUs
NiArMTA1LDcgQEAgc3RydWN0IE5QQ003eHhTdGF0ZSB7DQogICAgIE9IQ0lTeXNCdXNTdGF0ZSAg
ICAgb2hjaTsNCiAgICAgTlBDTTd4eEZJVVN0YXRlICAgICBmaXVbMl07DQogICAgIE5QQ003eHhF
TUNTdGF0ZSAgICAgZW1jWzJdOw0KKyAgICBOUENNN3h4UENJTUJveFN0YXRlIHBjaV9tYm94Ow0K
ICAgICBOUENNN3h4U0RIQ0lTdGF0ZSAgIG1tYzsNCiAgICAgTlBDTVBTUElTdGF0ZSAgICAgICBw
c3BpWzJdOw0KIH07DQotLQ0KMi40Mi4wLjgyMC5nODNhNzIxYTEzNy1nb29nDQoNClNpZ25lZC1v
ZmYtYnk6IFR5cm9uZSBUaW5nIDxrZnRpbmdAbnV2b3Rvbi5jb20+DQoNCg0KDQoNCg0KUmV2aWV3
ZWQtYnk6IFR5cm9uZSBUaW5nIDxrZnRpbmdAbnV2b3Rvbi5jb20+DQoNCg0KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQog
VGhlIHByaXZpbGVnZWQgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBpbiB0aGlz
IGVtYWlsIGlzIGludGVuZGVkIGZvciB1c2Ugb25seSBieSB0aGUgYWRkcmVzc2VlcyBhcyBpbmRp
Y2F0ZWQgYnkgdGhlIG9yaWdpbmFsIHNlbmRlciBvZiB0aGlzIGVtYWlsLiBJZiB5b3UgYXJlIG5v
dCB0aGUgYWRkcmVzc2VlIGluZGljYXRlZCBpbiB0aGlzIGVtYWlsIG9yIGFyZSBub3QgcmVzcG9u
c2libGUgZm9yIGRlbGl2ZXJ5IG9mIHRoZSBlbWFpbCB0byBzdWNoIGEgcGVyc29uLCBwbGVhc2Ug
a2luZGx5IHJlcGx5IHRvIHRoZSBzZW5kZXIgaW5kaWNhdGluZyB0aGlzIGZhY3QgYW5kIGRlbGV0
ZSBhbGwgY29waWVzIG9mIGl0IGZyb20geW91ciBjb21wdXRlciBhbmQgbmV0d29yayBzZXJ2ZXIg
aW1tZWRpYXRlbHkuIFlvdXIgY29vcGVyYXRpb24gaXMgaGlnaGx5IGFwcHJlY2lhdGVkLiBJdCBp
cyBhZHZpc2VkIHRoYXQgYW55IHVuYXV0aG9yaXplZCB1c2Ugb2YgY29uZmlkZW50aWFsIGluZm9y
bWF0aW9uIG9mIE51dm90b24gaXMgc3RyaWN0bHkgcHJvaGliaXRlZDsgYW5kIGFueSBpbmZvcm1h
dGlvbiBpbiB0aGlzIGVtYWlsIGlycmVsZXZhbnQgdG8gdGhlIG9mZmljaWFsIGJ1c2luZXNzIG9m
IE51dm90b24gc2hhbGwgYmUgZGVlbWVkIGFzIG5laXRoZXIgZ2l2ZW4gbm9yIGVuZG9yc2VkIGJ5
IE51dm90b24uDQo=

