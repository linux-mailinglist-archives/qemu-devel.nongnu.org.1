Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 382B3713919
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 12:57:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3E43-0008MF-L6; Sun, 28 May 2023 06:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1q3E3y-0008M7-SZ
 for qemu-devel@nongnu.org; Sun, 28 May 2023 06:55:51 -0400
Received: from mail-vi1eur02on2113.outbound.protection.outlook.com
 ([40.107.241.113] helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1q3E3w-0001l5-FF
 for qemu-devel@nongnu.org; Sun, 28 May 2023 06:55:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B36GY3n/CoObaz7999g9eq/5XAfceCe4frfdin+NwogPcAcvHwYFEni2BpsQRwuTdbyZMsMBrsDytm/GHlHWQkwEh+ROmlhgZNleO01U99rXpQslG8p4bx9/Tb65nL/qB1TmSLGobQK+tEBNQtQNU40Jrabys5tvWNPwUhur2qninsX5gzjfS+FGpD7e6DFNk5gNPNubbelOAMpXV8Rdk36jNUucAzpnw5+rfXLvn+hOWU8xYi0xCHBVD8yytC0E5LO+Q8KwKw2FQ1cnr95GGwOOzp49wYUvF/jEDJ0zm9VjOvYa3rwQjqgBLZTlamnLrDP3mYJ4jCbCs3mB/B667Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kci0nq50v4k/JQdZVnN0b8C1VgkkVC/aqSIqAxcKvk8=;
 b=TrLBRNE7Dxgqei5xK2z7RT01hGMGf86yGp7PoU6gTJWGik4xqjpJL4XhgvvMdhsEkDjP5Vba7nizqcdZ4/sBCht1d6bEaVPwdJ2oFOawPQi7aAvxuTenhWzrBuI/mkLXMX8iT5+md/ryiQBbEisjXft5eshvU8tf7EHWXlX7iscQ4jpWH8pWAQ7Ao3odyA8zpNFTirogZstKIcV8J4tWTtgr39WSps8Aw0qvgib3UfNBnVhnaP8z6RP5CLE78OgOnzz1IyiJboE4M78xd6mcuwkNHYcu90Q/f4Mpct8IakTMAid5Am6uq0QfYYywBKmLagst3pSdlHQCmkc8vEAsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com; 
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kci0nq50v4k/JQdZVnN0b8C1VgkkVC/aqSIqAxcKvk8=;
 b=L8DNAX2EeUEDbYYSiF202T15gXRNhz0rI7PN7qqSHhlRdR76k4MQW/N86PC8pXQsnNGIjWqhLsHGof9qtCOqVevun/jouHThErha5ozlFKRvPixDDtcIlBi1uUcN8AjgbcAClHa9pEMakQkGrE7CxiYFCRvhK7zYlUm8iqTsGw8=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by AS4P189MB1822.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 10:50:43 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6433.020; Sun, 28 May 2023
 10:50:43 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH] igb: Add Function Level Reset to PF and VF
Thread-Topic: [PATCH] igb: Add Function Level Reset to PF and VF
Thread-Index: AQHZj/fQujQCROZFWkiFuksETv6UNa9vggJg
Date: Sun, 28 May 2023 10:50:42 +0000
Message-ID: <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230526173035.69055-1-clg@redhat.com>
In-Reply-To: <20230526173035.69055-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|AS4P189MB1822:EE_
x-ms-office365-filtering-correlation-id: e8e32ba2-1f95-444b-a01b-08db5f69623a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jARi3naoQPem24wMiSbAmHlMuHBZvkZxH+GpQ8hzN6NHKht5cVBgbCaSJgj5ksxzZeByXHYtIaVwPXY47i7Mjwd1ACBUcOCmf5gJ0tVs8ruPjADgUpSLmoM+w54JDxHXic2L1T80CvZKSsIiEt9Z+PKcXnhX/Q4idC0ffMwGug+w4mx0Kk52LbZdAxvJKxTgwLyECIwRRBEKiuyigZAC4rOnZLY880V+sidVKYoPAR+w5RixFBdcAI9NzrbBVQEYL+zP6gqvvIJASx/HxfpagALJLB9qir8OUx/Ql1ETRUgDUJNZlc4ruGHdu/zZeM61OGB6UD23jhudwy3NxmpaWYXqmUNFz3hW2IYzMkNLrYnRjU/wRdIPyLymaxGGMlOkXqlEiI2JdkiQXZIfU73kCRFevAIqFcyRIG9ArP+8M595bXVlLDtzF36m1RzNmgfw9XX/PQmYTC2LgnSKVNDw0jvUyhms9JMbPp8yla0PhK3m+Nk863xUZyYdxqikT1qdEEtiXK8Ka3MHVg1HW+wnov8y5RCRUWJrDJYAw1tLEIFc4z85XFaBhkbUR5ZuvoBu6owYaBiHm7RBQpwv6xF56OYw1V6j+67g3Y6Yo1Q+sYifKWoq0tT2nLykg9eG1BXE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(39830400003)(366004)(136003)(376002)(396003)(346002)(451199021)(83380400001)(66574015)(71200400001)(33656002)(5660300002)(316002)(66946007)(76116006)(64756008)(66446008)(66476007)(66556008)(52536014)(4326008)(8676002)(122000001)(41300700001)(38100700002)(7696005)(8936002)(86362001)(55016003)(44832011)(110136005)(54906003)(53546011)(2906002)(6506007)(38070700005)(9686003)(186003)(478600001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHY4eDU1aloyV3kzNTVGVVBYZCtGZlcxMERrRWxYOVNUbitPNWRZdnpidU5D?=
 =?utf-8?B?V2lCZEM4dG9NT1NZMDlpZFVmOWtjYXYyelo4QlBiOXJ3OWc2bmtFQWQxUGsr?=
 =?utf-8?B?R2xzYTVObitQa1BXUlozNDBNUU5WKzg4ays5OHYvWk1vLzU1YWZJSmlwYWRB?=
 =?utf-8?B?YkcwNkhIZGJXS0pGUGtkeGpBL3diMHBLVnk1a0V4MHZLdGhwbGFuOWlnWDlx?=
 =?utf-8?B?WlNyU0cwdWpUN241ZVFJMzF0MEs1T2lNMXBCYk9vaU5rZlNybE42MDJlc3Fu?=
 =?utf-8?B?V0VCTHU0c2p6Y1VsbnBHOFViOVNqdHZ0c0VYT1dNeE9TS0hud0R2NG1sQ3gy?=
 =?utf-8?B?aFRXVGZ1eUdoamhka21iUDdkc3RTVmhyL1ZzaVJSTVVvZ0s5WjNmaUFhMUJX?=
 =?utf-8?B?RU9TSC85bWd4SmZmVVlaSHpwdFRvR3d5Unc4ZXRNZzl5b2EwT055UktjWjBh?=
 =?utf-8?B?WkRDN2d6T3I3djViZjdRWWZ2MERqWWRCMCtVcko5TTZHSnZQaEd3Vm1MaEVB?=
 =?utf-8?B?RjJrYXNCdHMyZlZrSlhUVk9iQnlwSk10aU1RbUF2YnNBa1dhekdYcWhJUm1z?=
 =?utf-8?B?TGpMcmkzeWdvbFNaRFpmTE8xTlBWdUhJVjlUa0tRdnZXVUs2aElDeEdaVHVM?=
 =?utf-8?B?YW9PcXhRWTRPUmZmRE5ZWGkrbk1OWmNyZHZsNFA0bmp4WE4veGZZcmRTN3Fw?=
 =?utf-8?B?TVJ0VWpYbGxHWkk4MUQ1cmpwUklRSlRLRXcxQ2o0VWwrSGU4bG9PSk5RZlFs?=
 =?utf-8?B?blZ6YXdwZ2laN1UrWVNIbVIwa3lPWHFCd1pqUmJIZ2dIUmh6MUVrRFcyT3l6?=
 =?utf-8?B?YTNDdlJ0dzZaZXpwaFBndnltWWhkd1JxYXZ1V0toWDFEVmhCdjl1SnIyb2Rj?=
 =?utf-8?B?MkNUOUpNS3NLc0J4TEVmUHExUlhiS1FpNXJIU1JUeVpOK2h2RGZxUkw0NTRV?=
 =?utf-8?B?YXo3UHpwSHRnRmFwY3JNeU1CL1lQLzZPQy9WTU43NURtUERMZXRBSmtlMy9K?=
 =?utf-8?B?VE1LWWxpajRjZTZ1K1Z1eXkxVEYreVpiMW45QXdJL2pnQUZER3VsN1ZpZklv?=
 =?utf-8?B?TDNIL0ZldkZ5WUlkUUpCNlh6VEVqUW4reWRBcGh5bXNZbzQyYWJUdXhSVW9G?=
 =?utf-8?B?WkRFZk8xVXUrY0tZUnMwZ3liZ0hweVdicGlSVFpoZE1vODdhQlc2d0VVdGdh?=
 =?utf-8?B?bUpYVGxJRGtHa2UrcmphM29yeFZhUWJlL2tOb1htaXhHVVVscTJENERYbGNx?=
 =?utf-8?B?bHFIS1hJTHlxT0xrdzZ5TGR4eVdUK2p4eFdmcFV2Rm41blphMkIxNERKVk9y?=
 =?utf-8?B?eWtyUzlIell5TkczanFhZ2YwV1ZwQXFzR2pwbHpsemlhWGlkSlFaekI2djVl?=
 =?utf-8?B?V2V1YklFR2RzVVl2TmFkRUxlK01jRlFDbCtpNkNIQXBCK2N6RmxzbVhNQjgr?=
 =?utf-8?B?b2l4YTFHOFNkWWJnc0pPVEZ5Z1lZRW0yYy8zdnpONStKeGxRT0UxaDMraTBM?=
 =?utf-8?B?MXMyRmRxbWNpTTBEcHoxMWltRExZRHgyMnV6cGJiR1c0RmJ6dVZxblpsV2Rm?=
 =?utf-8?B?TXVYb21mSFpMeU1KeTg1bjBRenRMWk1iWHhPaC9EZlNIOHZ4RkJudTBaTXVK?=
 =?utf-8?B?TUxEd3ZHdk9ONnNmcjk4NzNJOHdBVVhaOU8zWUlQdnEzOW1HVUdoYUdkR1Rl?=
 =?utf-8?B?aDlRRlFNQ0hldkxjRGovWGwzazNnUXpwQzBsejAxQUhUeWVXWHNUVGIxelpy?=
 =?utf-8?B?RWlqMDcxUnFNK1pNRHFjRDFUSzZ3bGsvS0FEZTRYZjBHcWY3MEhseEIzKzdE?=
 =?utf-8?B?ZEN6VnF5Zk4yUGRkTVo0RDM4S2dkSzJ0VVhQM3M5YndBUEo3eFVCYnlJL2Ey?=
 =?utf-8?B?Q3Z6dTNHaDFHWU5KQzkvQ1llM25nOGFjMFFOZUEvMnBESXZuZE5TbzJ2cldm?=
 =?utf-8?B?UVlMQ2pKUEhDaFZFaHN4blZrajdGWlQ2emNRZWZ6RVlxeXlDWXEwM2NMRkVL?=
 =?utf-8?B?ZFZGNjBrWG9XOHVsdGpZRjhWaGVRUW8vVHdhOENFWHVKNzZMOTR5a2I4NHlF?=
 =?utf-8?B?NkZxeFZ4TVNhMEJwSUdtYTJ1bGxJUExMNE1tRW5NV3JJTnZBM1hHRUlIOVFX?=
 =?utf-8?Q?ceB+R1AonLXPoDVES9NuvtZF0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e32ba2-1f95-444b-a01b-08db5f69623a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2023 10:50:42.7124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1buRW162vN6as4VMLJfV9kI25SmMFq+PkZEqgwYd00tEc1N4no2hE9KFIfMSqSBbubzMEFah95NtgzSOoGlKUYSDUobPu12RayQgVeIMKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1822
Received-SPF: pass client-ip=40.107.241.113;
 envelope-from=sriram.yagnaraman@est.tech;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj4gU2VudDogRnJpZGF5LCAyNiBNYXkgMjAyMyAxOTozMQ0KPiBU
bzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBBa2loaWtvIE9kYWtpIDxha2loaWtvLm9k
YWtpQGRheW5peC5jb20+OyBTcmlyYW0gWWFnbmFyYW1hbg0KPiA8c3JpcmFtLnlhZ25hcmFtYW5A
ZXN0LnRlY2g+OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsgQ8OpZHJpYw0KPiBM
ZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPiBTdWJqZWN0OiBbUEFUQ0hdIGlnYjogQWRkIEZ1
bmN0aW9uIExldmVsIFJlc2V0IHRvIFBGIGFuZCBWRg0KPiANCj4gVGhlIEludGVsIDgyNTc2RUIg
R2JFIENvbnRyb2xsZXIgc2F5IHRoYXQgdGhlIFBoeXNpY2FsIGFuZCBWaXJ0dWFsIEZ1bmN0aW9u
cw0KPiBzdXBwb3J0IEZ1bmN0aW9uIExldmVsIFJlc2V0LiBBZGQgdGhlIGNhcGFiaWxpdHkgdG8g
ZWFjaCBkZXZpY2UgbW9kZWwuDQo+IA0KPiBDYzogQWtpaGlrbyBPZGFraSA8YWtpaGlrby5vZGFr
aUBkYXluaXguY29tPg0KPiBGaXhlczogM2E5NzdkZWViZTZiICgiSW50cmRvY3VlIGlnYiBkZXZp
Y2UgZW11bGF0aW9uIikNCj4gU2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0By
ZWRoYXQuY29tPg0KPiAtLS0NCj4gIGh3L25ldC9pZ2IuYyAgIHwgMyArKysNCj4gIGh3L25ldC9p
Z2J2Zi5jIHwgMyArKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaHcvbmV0L2lnYi5jIGIvaHcvbmV0L2lnYi5jIGluZGV4IDFjOTg5ZDc2
NzcyNS4uMDhlMzg5MzM4ZGNhDQo+IDEwMDY0NA0KPiAtLS0gYS9ody9uZXQvaWdiLmMNCj4gKysr
IGIvaHcvbmV0L2lnYi5jDQo+IEBAIC0xMDEsNiArMTAxLDcgQEAgc3RhdGljIHZvaWQgaWdiX3dy
aXRlX2NvbmZpZyhQQ0lEZXZpY2UgKmRldiwgdWludDMyX3QNCj4gYWRkciwNCj4gDQo+ICAgICAg
dHJhY2VfaWdiX3dyaXRlX2NvbmZpZyhhZGRyLCB2YWwsIGxlbik7DQo+ICAgICAgcGNpX2RlZmF1
bHRfd3JpdGVfY29uZmlnKGRldiwgYWRkciwgdmFsLCBsZW4pOw0KPiArICAgIHBjaWVfY2FwX2Zs
cl93cml0ZV9jb25maWcoZGV2LCBhZGRyLCB2YWwsIGxlbik7DQo+IA0KPiAgICAgIGlmIChyYW5n
ZV9jb3ZlcnNfYnl0ZShhZGRyLCBsZW4sIFBDSV9DT01NQU5EKSAmJg0KPiAgICAgICAgICAoZGV2
LT5jb25maWdbUENJX0NPTU1BTkRdICYgUENJX0NPTU1BTkRfTUFTVEVSKSkgeyBAQCAtNDI3LDYN
Cj4gKzQyOCw4IEBAIHN0YXRpYyB2b2lkIGlnYl9wY2lfcmVhbGl6ZShQQ0lEZXZpY2UgKnBjaV9k
ZXYsIEVycm9yICoqZXJycCkNCj4gICAgICB9DQo+IA0KPiAgICAgIC8qIFBDSWUgZXh0ZW5kZWQg
Y2FwYWJpbGl0aWVzIChpbiBvcmRlcikgKi8NCj4gKyAgICBwY2llX2NhcF9mbHJfaW5pdChwY2lf
ZGV2KTsNCj4gKw0KPiAgICAgIGlmIChwY2llX2Flcl9pbml0KHBjaV9kZXYsIDEsIDB4MTAwLCAw
eDQwLCBlcnJwKSA8IDApIHsNCj4gICAgICAgICAgaHdfZXJyb3IoIkZhaWxlZCB0byBpbml0aWFs
aXplIEFFUiBjYXBhYmlsaXR5Iik7DQo+ICAgICAgfQ0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L2ln
YnZmLmMgYi9ody9uZXQvaWdidmYuYyBpbmRleA0KPiAyODRlYTYxMTg0OGIuLjBhNThkYWQwNjgw
MiAxMDA2NDQNCj4gLS0tIGEvaHcvbmV0L2lnYnZmLmMNCj4gKysrIGIvaHcvbmV0L2lnYnZmLmMN
Cj4gQEAgLTIwNCw2ICsyMDQsNyBAQCBzdGF0aWMgdm9pZCBpZ2J2Zl93cml0ZV9jb25maWcoUENJ
RGV2aWNlICpkZXYsDQo+IHVpbnQzMl90IGFkZHIsIHVpbnQzMl90IHZhbCwgIHsNCj4gICAgICB0
cmFjZV9pZ2J2Zl93cml0ZV9jb25maWcoYWRkciwgdmFsLCBsZW4pOw0KPiAgICAgIHBjaV9kZWZh
dWx0X3dyaXRlX2NvbmZpZyhkZXYsIGFkZHIsIHZhbCwgbGVuKTsNCj4gKyAgICBwY2llX2NhcF9m
bHJfd3JpdGVfY29uZmlnKGRldiwgYWRkciwgdmFsLCBsZW4pOw0KPiAgfQ0KPiANCj4gIHN0YXRp
YyB1aW50NjRfdCBpZ2J2Zl9tbWlvX3JlYWQodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRkciwgdW5z
aWduZWQgc2l6ZSkNCj4gQEAgLTI2Niw2ICsyNjcsOCBAQCBzdGF0aWMgdm9pZCBpZ2J2Zl9wY2lf
cmVhbGl6ZShQQ0lEZXZpY2UgKmRldiwgRXJyb3INCj4gKiplcnJwKQ0KPiAgICAgICAgICBod19l
cnJvcigiRmFpbGVkIHRvIGluaXRpYWxpemUgUENJZSBjYXBhYmlsaXR5Iik7DQo+ICAgICAgfQ0K
PiANCj4gKyAgICBwY2llX2NhcF9mbHJfaW5pdChkZXYpOw0KDQpTb3JyeSBmb3IgbXkgbmFpdmUg
cXVlc3Rpb24sIGFuZCBwZXJoYXBzIG5vdCByZWxhdGVkIHRvIHlvdXIgcGF0Y2gsIElHQlZGIGRl
dmljZSBjbGFzcyBkb2Vzbid0IHNlZW0gdG8gaGF2ZSBhbnkgcmVzZXQgZnVuY3Rpb25zIHJlZ2lz
dGVyZWQgdmlhIGlnYnZmX2NsYXNzX2luaXQoKS4gU28sIEkgYW0gZ3Vlc3NpbmcgYW4gRkxSIHdp
bGwgbm90IHRyaWdnZXIgaWdiX3ZmX3Jlc2V0KCksIHdoaWNoIGlzIHByb2JhYmx5IHdoYXQgd2Ug
d2FudC4NCg0KPiArDQo+ICAgICAgaWYgKHBjaWVfYWVyX2luaXQoZGV2LCAxLCAweDEwMCwgMHg0
MCwgZXJycCkgPCAwKSB7DQo+ICAgICAgICAgIGh3X2Vycm9yKCJGYWlsZWQgdG8gaW5pdGlhbGl6
ZSBBRVIgY2FwYWJpbGl0eSIpOw0KPiAgICAgIH0NCj4gLS0NCj4gMi40MC4xDQoNCg==

