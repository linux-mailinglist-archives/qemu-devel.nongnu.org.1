Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B417171392A
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 13:26:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3EWd-0006bF-Uk; Sun, 28 May 2023 07:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1q3EWX-0006Zh-PO
 for qemu-devel@nongnu.org; Sun, 28 May 2023 07:25:21 -0400
Received: from mail-dbaeur03on2070e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::70e]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1q3EWV-0007aZ-6p
 for qemu-devel@nongnu.org; Sun, 28 May 2023 07:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzWolVmsmXs5D6+CGNEA7rV/VjL5pM1BINwHgR47q88vvMUgI/rdmeHX8njrl/WyIknFziNoUFDdMwwc12v6eYLwZSF1bUCfwhRyoX21Cs+HIIw/VUD0GmcnCP1NjK2vj0KOL4D3It+Y1F4PjyB0biesK6X55tnKxMXOtpEi9xZqG/VhBu4wrZXw0qe1kYXXdDeZK4CXgxrdzLhBhWBp4Tq9rw+5HMfnPp/3FxXjWcgjikT/nr2st32EsEN06mBUka4yqfH3Auwhmxv0gFVoxG6akeRV1DFTTQKBnkMZCVVNhBlgSDaknq4d8Ore44CFpBYatb6/+UIOSNtBZ7YH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jcn/B7GAqcDu/e2BJE9NwuznCgmq9hmTuXATNmYpIm4=;
 b=EQkDv/lihUnv85iCQc4Xe7Dy8tWMDNpJL6zhSuq1Z48VNDDWZMUdOGvdHyVyQ0l11SmpXHL88day3k0i2twgNpoq96axbxMY0d67HXT5cOFWBWfw0K7ur6llX1XAd2qZlcuYJ/gJMif12jF5Q5AXnHSAHtAPQaw0VE4vimuihQXetxWv9txQY5rihJoSEKt45I3RFlUt8HIzY1AbLMLMBJGhNCoHC8MXCV7Rx4E2BUShACrcaCpTTDnYhZAk1ljRK4dwCEVJSJO+ZHUr/iGIxtOzyaOW4Vxnhl6FOasX0Tkgy5XAm0TM+hNH5ki0J0g4d+gb70gUb3aqtU9pJnWypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com; 
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jcn/B7GAqcDu/e2BJE9NwuznCgmq9hmTuXATNmYpIm4=;
 b=H5lkwz70I3cZH778L1n3itfev1FHtIut3lsz8bBVDy0XT5hSIdVWjOsVkFYvt/0DRo+2STLx3NT4G3Ui/HFY5DOTr9Q9BHDhiF1fwp4cBnvp6TP/ZarN1VljINJBFukqOgcYG+jLr4aPcsL5edPJg3Go7KEZkGjJ/clI5grZv3s=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by PR3P189MB0857.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.21; Sun, 28 May
 2023 11:25:15 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::57d:1bb3:9180:73b6%4]) with mapi id 15.20.6433.020; Sun, 28 May 2023
 11:25:15 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: [PATCH] igb: Add Function Level Reset to PF and VF
Thread-Topic: [PATCH] igb: Add Function Level Reset to PF and VF
Thread-Index: AQHZj/fQujQCROZFWkiFuksETv6UNa9vggJggAAL0XA=
Date: Sun, 28 May 2023 11:25:14 +0000
Message-ID: <DBBP189MB14335F641546F8C47ECC951095459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230526173035.69055-1-clg@redhat.com>
 <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
In-Reply-To: <DBBP189MB143330236AFF956285CD74F295459@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|PR3P189MB0857:EE_
x-ms-office365-filtering-correlation-id: 104a4bb4-b827-419a-8512-08db5f6e3564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vET47StpQuxD0Ws41+6nS+PXgbJRPn/exkYxEj/06DjueCQ81XzW2H8/z2iwMLt0zlLigdzLIF7VymdTUd6inzY043P33isKzG0kZZfiQJmoseAqdCO0fvgjoYMFbatszoPceiv69K6bfbNx11laktkoniAoBj4ybbXCCKRiepA/ercG09ThNnoxmtvsKq6lr3rroMjitqGZwJV2MSl2lu4DL1D3sRhJIRA8yr5WJM3mxTBs7APljpceER/BvRvQjIFL+ntsbORB3858TcDO+jBhn0/HyoS2XkrAa17DDHZb0BoUN5Ll63JxaYUbWVX3rg0T51pUgNJ4ef4FuFmhYPDgs+Wph18Awzk3z3kJXYmk/ggnGXktNDeZAJiHZ887yIswFLEjrI1ZDg63ihksswndwdUF8QW5P/dpEA5v8riXb/0wy5eoMcwEtdtWK8vJzBAwgUDn+uAP5sSUK9XuOx3LbDsJpWtkK/tm8sCQNgj7eIcAT7aYmckVUZzDrQWrpdtYNPZc8skPl0sLn3vbhWCIZHx+JX5L72L0sBsoDMrGH09P6r687R9QqlWt8rFD0ehzS3/ilrtqfR+GXSa6APkwRcF/pZn3NPN0/09RyXmJKnBLGiNE35ovWAIwc5lR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39830400003)(376002)(136003)(346002)(396003)(451199021)(38100700002)(122000001)(41300700001)(2940100002)(38070700005)(316002)(4326008)(33656002)(71200400001)(86362001)(8676002)(8936002)(2906002)(7696005)(52536014)(66946007)(76116006)(9686003)(110136005)(66446008)(66476007)(66556008)(53546011)(64756008)(54906003)(44832011)(6506007)(26005)(83380400001)(478600001)(66574015)(5660300002)(186003)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S0R4Qkdyck1rQkJSNzgyQkdXMkg2VjRIV1pBeGw1VjNqUnlwUW1pVmJOelgv?=
 =?utf-8?B?b0VLZWNqYXZOKzNLK1JobUlZSlpIWStsVy9TNVBHcFp0N0hoR1U1ZzNHRkRJ?=
 =?utf-8?B?RmdQS3AvK1FJdjFxckVvRWpvdUZVVjhMbVZDb1dkSWZhekp2Tzd5ZHlMd2Ja?=
 =?utf-8?B?MHlIZ1pwWnBSTkJLUWIzMkpuM1RBSDdSbDliNWdDUkltelZYL2JJandQSFp2?=
 =?utf-8?B?amllYzQ1MEdIbnlKakFBQ1o2VXE1Q0NSdEJxandaN0NXYUlZb1lkL2lKam5j?=
 =?utf-8?B?T05pSzNuSE5DMXhxN0UwS1IxdW9RM1B6a2UreGlkQkU5K0RNb3pMbUVQOWlU?=
 =?utf-8?B?Q2FBUHh0QkpibDVFbG1IdzRobTRTdW9QTVRlL1hHS0tZQUdjMU5aMVpqNlJF?=
 =?utf-8?B?NTdKcXQ1M2N5ODFLZ3J3aG5Jd00xWXdWaklHdXR4dnpiWUs3dis2YzBqM2oz?=
 =?utf-8?B?RWZ2RHhpcEtWRWFUU2ZhMXVYY1NTQjZTWjdpTnN4YS9pUGZkcHpDcEZocGhn?=
 =?utf-8?B?bC9YQ1UyenVneCsxVEdkcEdJV0p3M01saVlYd2QrVm1sZGt2ZUtPUjJNTER0?=
 =?utf-8?B?T0lBYjBIZFliNEgycVU4UTU0bUVBOXVLcWJjaStaNFl0WU0xRnpDZTlGZkdO?=
 =?utf-8?B?L1lTdWJ6aVdiU2M3RFlHTGl0ajVLTVAvdG0zUWRXOHNCMlJqUlBqazVGTkx1?=
 =?utf-8?B?VXVGdWFZc0FEZ2x4NERoWVNEcXBZNkxMeDZDY1lHR2IwQ3FXVk5DallqcEkz?=
 =?utf-8?B?QWVENkYyYlR6eU9SVkhCck9qOUlEZDNKVEtMMElGRUI0ZW9jSW9YRk9PNkIr?=
 =?utf-8?B?T2RDNEVsRUdyK3ZyZXVKeUNkRFJrUFpkNWpkMmZuTURoOHlXSE54TFF2OTJD?=
 =?utf-8?B?MW9DNVB5SXhJQ1BYekJKUk45VHdUVk5vZll5VjNodkd4bHovQThRdUFSajlm?=
 =?utf-8?B?VEliL3lvVWN3MHVCclZzUWxldS9yRlM3Y1dqaXJnaVBVNWVSSWdMM3NsamF4?=
 =?utf-8?B?WDlMQ1E0YzJCYkY4ZnFmTjJ1NVRjT2tsdWhxSG5sS2ozblNwL1dSVTRrYXA0?=
 =?utf-8?B?eCs3VkhqNXlYSituN09lMDNOemM2UC9wOWZZWFNiWFJuVS9kZU4xdTQ5b1hS?=
 =?utf-8?B?QnFUZGlCc2NuWmc2SDJTWGIrS2ZRTkNNNjhTUXR1a2k5c0Qza2UzemFvNDFm?=
 =?utf-8?B?Z0xWdHozV2NKdUtSYjdBRjR2b2krN0tiU2g4dS9TaENiZUc1SHFKKzVHMExL?=
 =?utf-8?B?S21oWU95NlptS01nYmpDT1RyUks0Y0tSckNCLzRoRGdDMm8yRVZ3WGZibkh4?=
 =?utf-8?B?SHQwUkJDUWhvT0U3a3R2TDZTUUVIaHVMaFk3OHRuMXdjYmpWeVdCTGRYTnl3?=
 =?utf-8?B?UXE1NEJpZFM5ek1Ka0RDbjdSVGNRYXJvZU1BbWlIcVhhSXFqVWcwcUFnYkQ4?=
 =?utf-8?B?aWd2Vmc4NUIzZ1lzcWNPMnJLQ1BMZE4yejBYdmhDNlprWlZaY2tHUEhSQk1E?=
 =?utf-8?B?Sml4ZlgzQzd5TlM2K2QzYzJFdFY0K1JOSW10Ri9WV1lDVTBDWHQ1U2NiajFt?=
 =?utf-8?B?UkZtdnBxNFdvVVR0b3VpcWI2aHdacTZCZlhIWmY2YTdDY0JUQU1xV2w3QUp6?=
 =?utf-8?B?VW1nb3pxaXhGMTRvbTZZVkpuRC9ZNFhuQkVOWlI5bDAyaG5HQWdzdktqeHA0?=
 =?utf-8?B?aUl3UWoyMmZUeUMzM3c5US9BdE9HdTZRdElXQjcwQVZsRS9oWGM3eEMwOEpR?=
 =?utf-8?B?a01BMy9yNi92MVR6d2wvUXlsQnRhcHBYQlA2S1orbFNPbTQraGhBSE1DajI5?=
 =?utf-8?B?WnptRzcwUXB1alhQSlZZeDZNSVJPSTJIOCtGSFltMHJvcnlScTFMZmE3NDJt?=
 =?utf-8?B?ODNkdk5wMWE1aGtUYlFsZFZERkFDci9EdUpybWlGNGw0R251M25ELzRSWXRa?=
 =?utf-8?B?YzQxR09RVWRTem1RWXBDOU51bGhLODRPdVNxZUFnMFV0dE1MeUZaeUJ1OFFQ?=
 =?utf-8?B?YWlyQ2Z5RjVJNXFucW9Qc3B0MitCVGdySkpURkNWWW9kc3BkZFgyT3NUTzlh?=
 =?utf-8?B?TVpWRHdBVDlxYmRWYUlRS1dKaEkzYzNpQWtQbi90WTd2NTBhbXZrcGFKUURV?=
 =?utf-8?Q?zve+7M6bw64N6LMW0W7XrZJSm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 104a4bb4-b827-419a-8512-08db5f6e3564
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2023 11:25:14.9592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YxH+7rxgP5ny/a9JnckuxlH5X+z5a5+GcmOmLYNMRHzffHnOK4c4hx2cNjS090q0Tci1wqvRAbZSUolcjWIOmJc151uCD5KaZG44CZ1AQcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P189MB0857
Received-SPF: pass client-ip=2a01:111:f400:fe1a::70e;
 envelope-from=sriram.yagnaraman@est.tech;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBxZW11LWRldmVsLWJvdW5jZXMr
c3JpcmFtLnlhZ25hcmFtYW49ZXN0LnRlY2hAbm9uZ251Lm9yZw0KPiA8cWVtdS1kZXZlbC1ib3Vu
Y2VzK3NyaXJhbS55YWduYXJhbWFuPWVzdC50ZWNoQG5vbmdudS5vcmc+IE9uIEJlaGFsZg0KPiBP
ZiBTcmlyYW0gWWFnbmFyYW1hbg0KPiBTZW50OiBTdW5kYXksIDI4IE1heSAyMDIzIDEyOjUxDQo+
IFRvOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+OyBxZW11LWRldmVsQG5vbmdu
dS5vcmcNCj4gQ2M6IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT47IEph
c29uIFdhbmcNCj4gPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hd
IGlnYjogQWRkIEZ1bmN0aW9uIExldmVsIFJlc2V0IHRvIFBGIGFuZCBWRg0KPiANCj4gDQo+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCAyNiBNYXkgMjAyMyAxOTozMQ0KPiA+
IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gPiBDYzogQWtpaGlrbyBPZGFraSA8YWtpaGlr
by5vZGFraUBkYXluaXguY29tPjsgU3JpcmFtIFlhZ25hcmFtYW4NCj4gPiA8c3JpcmFtLnlhZ25h
cmFtYW5AZXN0LnRlY2g+OyBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPjsNCj4gQ8Op
ZHJpYw0KPiA+IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+ID4gU3ViamVjdDogW1BBVENI
XSBpZ2I6IEFkZCBGdW5jdGlvbiBMZXZlbCBSZXNldCB0byBQRiBhbmQgVkYNCj4gPg0KPiA+IFRo
ZSBJbnRlbCA4MjU3NkVCIEdiRSBDb250cm9sbGVyIHNheSB0aGF0IHRoZSBQaHlzaWNhbCBhbmQg
VmlydHVhbA0KPiA+IEZ1bmN0aW9ucyBzdXBwb3J0IEZ1bmN0aW9uIExldmVsIFJlc2V0LiBBZGQg
dGhlIGNhcGFiaWxpdHkgdG8gZWFjaCBkZXZpY2UNCj4gbW9kZWwuDQo+ID4NCj4gPiBDYzogQWtp
aGlrbyBPZGFraSA8YWtpaGlrby5vZGFraUBkYXluaXguY29tPg0KPiA+IEZpeGVzOiAzYTk3N2Rl
ZWJlNmIgKCJJbnRyZG9jdWUgaWdiIGRldmljZSBlbXVsYXRpb24iKQ0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gPiAtLS0NCj4gPiAgaHcv
bmV0L2lnYi5jICAgfCAzICsrKw0KPiA+ICBody9uZXQvaWdidmYuYyB8IDMgKysrDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcv
bmV0L2lnYi5jIGIvaHcvbmV0L2lnYi5jIGluZGV4DQo+ID4gMWM5ODlkNzY3NzI1Li4wOGUzODkz
MzhkY2ENCj4gPiAxMDA2NDQNCj4gPiAtLS0gYS9ody9uZXQvaWdiLmMNCj4gPiArKysgYi9ody9u
ZXQvaWdiLmMNCj4gPiBAQCAtMTAxLDYgKzEwMSw3IEBAIHN0YXRpYyB2b2lkIGlnYl93cml0ZV9j
b25maWcoUENJRGV2aWNlICpkZXYsDQo+ID4gdWludDMyX3QgYWRkciwNCj4gPg0KPiA+ICAgICAg
dHJhY2VfaWdiX3dyaXRlX2NvbmZpZyhhZGRyLCB2YWwsIGxlbik7DQo+ID4gICAgICBwY2lfZGVm
YXVsdF93cml0ZV9jb25maWcoZGV2LCBhZGRyLCB2YWwsIGxlbik7DQo+ID4gKyAgICBwY2llX2Nh
cF9mbHJfd3JpdGVfY29uZmlnKGRldiwgYWRkciwgdmFsLCBsZW4pOw0KPiA+DQo+ID4gICAgICBp
ZiAocmFuZ2VfY292ZXJzX2J5dGUoYWRkciwgbGVuLCBQQ0lfQ09NTUFORCkgJiYNCj4gPiAgICAg
ICAgICAoZGV2LT5jb25maWdbUENJX0NPTU1BTkRdICYgUENJX0NPTU1BTkRfTUFTVEVSKSkgeyBA
QCAtDQo+IDQyNyw2DQo+ID4gKzQyOCw4IEBAIHN0YXRpYyB2b2lkIGlnYl9wY2lfcmVhbGl6ZShQ
Q0lEZXZpY2UgKnBjaV9kZXYsIEVycm9yDQo+ID4gKyoqZXJycCkNCj4gPiAgICAgIH0NCj4gPg0K
PiA+ICAgICAgLyogUENJZSBleHRlbmRlZCBjYXBhYmlsaXRpZXMgKGluIG9yZGVyKSAqLw0KPiA+
ICsgICAgcGNpZV9jYXBfZmxyX2luaXQocGNpX2Rldik7DQo+ID4gKw0KPiA+ICAgICAgaWYgKHBj
aWVfYWVyX2luaXQocGNpX2RldiwgMSwgMHgxMDAsIDB4NDAsIGVycnApIDwgMCkgew0KPiA+ICAg
ICAgICAgIGh3X2Vycm9yKCJGYWlsZWQgdG8gaW5pdGlhbGl6ZSBBRVIgY2FwYWJpbGl0eSIpOw0K
PiA+ICAgICAgfQ0KPiA+IGRpZmYgLS1naXQgYS9ody9uZXQvaWdidmYuYyBiL2h3L25ldC9pZ2J2
Zi5jIGluZGV4DQo+ID4gMjg0ZWE2MTE4NDhiLi4wYTU4ZGFkMDY4MDIgMTAwNjQ0DQo+ID4gLS0t
IGEvaHcvbmV0L2lnYnZmLmMNCj4gPiArKysgYi9ody9uZXQvaWdidmYuYw0KPiA+IEBAIC0yMDQs
NiArMjA0LDcgQEAgc3RhdGljIHZvaWQgaWdidmZfd3JpdGVfY29uZmlnKFBDSURldmljZSAqZGV2
LA0KPiA+IHVpbnQzMl90IGFkZHIsIHVpbnQzMl90IHZhbCwgIHsNCj4gPiAgICAgIHRyYWNlX2ln
YnZmX3dyaXRlX2NvbmZpZyhhZGRyLCB2YWwsIGxlbik7DQo+ID4gICAgICBwY2lfZGVmYXVsdF93
cml0ZV9jb25maWcoZGV2LCBhZGRyLCB2YWwsIGxlbik7DQo+ID4gKyAgICBwY2llX2NhcF9mbHJf
d3JpdGVfY29uZmlnKGRldiwgYWRkciwgdmFsLCBsZW4pOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3Rh
dGljIHVpbnQ2NF90IGlnYnZmX21taW9fcmVhZCh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLCB1
bnNpZ25lZA0KPiA+IHNpemUpIEBAIC0yNjYsNiArMjY3LDggQEAgc3RhdGljIHZvaWQgaWdidmZf
cGNpX3JlYWxpemUoUENJRGV2aWNlDQo+ID4gKmRldiwgRXJyb3INCj4gPiAqKmVycnApDQo+ID4g
ICAgICAgICAgaHdfZXJyb3IoIkZhaWxlZCB0byBpbml0aWFsaXplIFBDSWUgY2FwYWJpbGl0eSIp
Ow0KPiA+ICAgICAgfQ0KPiA+DQo+ID4gKyAgICBwY2llX2NhcF9mbHJfaW5pdChkZXYpOw0KPiAN
Cj4gU29ycnkgZm9yIG15IG5haXZlIHF1ZXN0aW9uLCBhbmQgcGVyaGFwcyBub3QgcmVsYXRlZCB0
byB5b3VyIHBhdGNoLCBJR0JWRg0KPiBkZXZpY2UgY2xhc3MgZG9lc24ndCBzZWVtIHRvIGhhdmUg
YW55IHJlc2V0IGZ1bmN0aW9ucyByZWdpc3RlcmVkIHZpYQ0KPiBpZ2J2Zl9jbGFzc19pbml0KCku
IFNvLCBJIGFtIGd1ZXNzaW5nIGFuIEZMUiB3aWxsIG5vdCB0cmlnZ2VyIGlnYl92Zl9yZXNldCgp
LCB3aGljaA0KPiBpcyBwcm9iYWJseSB3aGF0IHdlIHdhbnQuDQo+IA0KDQpTb21ldGhpbmcgbGlr
ZSB0aGlzIHBlcmhhcHM/IE5vdCBjb21waWxlIHRlc3RlZCwganVzdCBhbiBpZGVhLg0KZGlmZiAt
LWdpdCBhL2h3L25ldC9pZ2J2Zi5jIGIvaHcvbmV0L2lnYnZmLmMNCmluZGV4IDI4NGVhNjExODQu
LjlmMDc5ODNiYzkgMTAwNjQ0DQotLS0gYS9ody9uZXQvaWdidmYuYw0KKysrIGIvaHcvbmV0L2ln
YnZmLmMNCkBAIC0yODMsOSArMjgzLDE3IEBAIHN0YXRpYyB2b2lkIGlnYnZmX3BjaV91bmluaXQo
UENJRGV2aWNlICpkZXYpDQogICAgIG1zaXhfdW5pbml0KGRldiwgJnMtPm1zaXgsICZzLT5tc2l4
KTsNCiB9DQogDQorc3RhdGljIHZvaWQgaWdidmZfcWRldl9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
KQ0KK3sNCisgICAgdHJhY2VfZTEwMDBlX2NiX3FkZXZfcmVzZXRfaG9sZCgpOw0KKw0KKyAgICBp
Z2J2Zl9tbWlvX3dyaXRlKG9iaiwgRTEwMDBfQ1RSTCwgRTEwMDBfQ1RSTF9SU1QsIDB4NCk7IC8q
IFdyaXRlIHRvIFZUQ1RSTCB0byB0cmlnZ2VyIFZGIHJlc2V0ICovDQorfQ0KKw0KIHN0YXRpYyB2
b2lkIGlnYnZmX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmNsYXNzLCB2b2lkICpkYXRhKQ0KIHsN
CiAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGNsYXNzKTsNCisgICAgUmVzZXR0
YWJsZUNsYXNzICpyYyA9IFJFU0VUVEFCTEVfQ0xBU1MoY2xhc3MpOw0KICAgICBQQ0lEZXZpY2VD
bGFzcyAqYyA9IFBDSV9ERVZJQ0VfQ0xBU1MoY2xhc3MpOw0KIA0KICAgICBjLT5yZWFsaXplID0g
aWdidmZfcGNpX3JlYWxpemU7DQpAQCAtMjk1LDYgKzMwMyw4IEBAIHN0YXRpYyB2b2lkIGlnYnZm
X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKmNsYXNzLCB2b2lkICpkYXRhKQ0KICAgICBjLT5yZXZp
c2lvbiA9IDE7DQogICAgIGMtPmNsYXNzX2lkID0gUENJX0NMQVNTX05FVFdPUktfRVRIRVJORVQ7
DQogDQorICAgIHJjLT5waGFzZXMuaG9sZCA9IGlnYnZmX3FkZXZfcmVzZXRfaG9sZDsNCisNCiAg
ICAgZGMtPmRlc2MgPSAiSW50ZWwgODI1NzYgVmlydHVhbCBGdW5jdGlvbiI7DQogICAgIGRjLT51
c2VyX2NyZWF0YWJsZSA9IGZhbHNlOw0KDQo+ID4gKw0KPiA+ICAgICAgaWYgKHBjaWVfYWVyX2lu
aXQoZGV2LCAxLCAweDEwMCwgMHg0MCwgZXJycCkgPCAwKSB7DQo+ID4gICAgICAgICAgaHdfZXJy
b3IoIkZhaWxlZCB0byBpbml0aWFsaXplIEFFUiBjYXBhYmlsaXR5Iik7DQo+ID4gICAgICB9DQo+
ID4gLS0NCj4gPiAyLjQwLjENCg0K

