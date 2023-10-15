Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC617C99D9
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 17:54:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs3RJ-0005A4-6K; Sun, 15 Oct 2023 11:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qs3RH-00059Z-LZ
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 11:53:59 -0400
Received: from mail-mr2fra01on2070c.outbound.protection.outlook.com
 ([2a01:111:f400:7e19::70c]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qs3RF-0008Uq-Pi
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 11:53:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz+8r3MUAdDqUVjzOOYAjhobUQoxBCzs+gvZcXBPYjPtLADZvcjAz6Y0HrtD9JmmCh/bmJJWzgL9KHTuXFQXexDACez2pysf1RmEGb5Z1Fnowfvzr+1ygCisWHm8XjGTBDASOPfhVh7vAIrX99QiZyzXeuPmwtySdboXeJns1JxUzqndlIhokKvMnMuTHdh5dRUQiGN9NNiYayL6jzgKAr6mPjxFl1pu8D/hWtsjW4gBKAjDqvbO+710UDLc0rKiiB6JwCiE9TS7wHhUmnQ3f/KbmDQFlhEb/1Ho9vwCoMUKbt3LOeNIQph3/LN3eSQCMbDINB8uPzZu3W2KjFws+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqfwwxL6Dl5/X9XKuLQfUtvn8TdOm3UGsWvEST7GzmE=;
 b=gPiCOWk5RtWE6vP25Xz9rzqsXjJQ8xAhVJ5crE8JZsDfecU3MrStsonmjPR3SsmYG/+zu2mgp0woLvkhNZ43bZQfx6Y9ryIQqcTRl1SrXcl6I3iQcuz2MkqvsGp8Fdx50RDsmaoNEM1nzejyDr/HfcmD5jKo8D9Xq3IPghCU5KK4obBKO6qz08/Y5FnkGChFXt2v0Gc664yX+fW9fWQnv/Gvw0vlYEVl426wP9nayd5cc+HahcgM0rnCnctioyEmw0IrcM3TNff66n5l+dOdJIvoynKJA3RZAX6jd039lZrAARh1B44gkuuoWW0PUtAfg868YCKzo8u0YNST5nKWrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqfwwxL6Dl5/X9XKuLQfUtvn8TdOm3UGsWvEST7GzmE=;
 b=fE+kdcteg2MzEUIbJ4y16hmMRCv8HQ8bpYSTMMVZFIXKfGnnUWZ1mjvXXheEbI/yOzEWzFq/i0+xrQ01MUs1oqEdb8b33OPYkqhWhhyBCfgIakE+SHbHKlC6kT9LM5HULVMZQ3iSrAScPf/W5HEtDM/xQSzhHv9FYdU2imloSJ0=
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::14)
 by PR0P264MB2439.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Sun, 15 Oct
 2023 15:53:54 +0000
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f]) by PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f%3]) with mapi id 15.20.6886.034; Sun, 15 Oct 2023
 15:53:54 +0000
From: Vincent Jardin <vincent.jardin@ekinops.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: Re: [RFC] virtio: enforce link up
Thread-Topic: [RFC] virtio: enforce link up
Thread-Index: AQHZ/rq5hgr+F0IIsUmQ9K0/o+z56bBJe9+AgABLLYCAAMKAAIAAeJcA
Date: Sun, 15 Oct 2023 15:53:54 +0000
Message-ID: <8f92ab18-a817-4e09-a9e3-3d42b9e9b415@ekinops.com>
References: <20231014162234.153808-1-vincent.jardin@ekinops.com>
 <20231014123635-mutt-send-email-mst@kernel.org>
 <8f110502-7ab7-4db2-9702-3717cf6afc58@ekinops.com>
 <20231015034428-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231015034428-mutt-send-email-mst@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR1P264MB2295:EE_|PR0P264MB2439:EE_
x-ms-office365-filtering-correlation-id: 64abf597-94ea-4d54-7210-08dbcd96ef4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fyHS/XpkGbuP98WT7hoiOGDA+knFHXHoSI16RLtJNFn+eTzpaU93whHmUjrnRjUOOjD+V9JRPbCeHxUR/14cxdCOrr+5u2DV2p5GAIovRoC3ZdPNS5m+VFJ7inAItq1g0dzFe4R9MeLV14oJHyEREtZ+9AiIOKEmCGxDyY8IwJtkrghSgCdljUl74e5DH+nAMdgzwp16cO5ZiK6udWQpq7Yx50EDTWydmfBJJdItuj5kywPhDWcCS/lFMXhmy7erKOvfq/F8MV8LWlGBH2vFkojHI0amlTcyt9k17HD+i9KlftOeLhq3HMhQtE7uYSDxz9yI498fXfYnkUrBrBo6dBMKZA5jHSZLnWcYy5nraHPObejZtoEDNklDAaMouhP0HoPp0lH+pmFtIcMMAITeZXmzu8+AOlJaLGytUD4Az7STIG1ODXd9gmaWFgOqeKKAEkGXdO4v2UUrLYmW0jsN7laVqCYqGIdv6W36RerUdBVcRtaCWaJF3pp/Itda93P8wrWxFt0THU+eOsktdM7omo2ezBHFrxNlqhGKgqyqRqgjyVcFYcRDnPvhQZqu864T+xc8DgxEbBtGz5i9eOxwQAapZl797Wma70HWkDgIUNxHZ9ZksIFjTnN/ex8yWd+TWWN832MRrSpx/Q7HcfwY3oabnkFg72+OLuIYkpvJ3yI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39840400004)(136003)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(86362001)(31696002)(36756003)(122000001)(66476007)(44832011)(8936002)(4326008)(8676002)(41300700001)(5660300002)(66556008)(66946007)(54906003)(66446008)(64756008)(91956017)(76116006)(316002)(6916009)(2906002)(6506007)(6512007)(478600001)(31686004)(53546011)(26005)(2616005)(6486002)(71200400001)(966005)(38070700005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UW90R243YjdQdkNISjlUYWJ5S0dpcE1NT0p5VVVONDJCNzBPZWZ5KzVnaGpj?=
 =?utf-8?B?RHBoYlE3QmhFSEdQMHl6MnZLMFNEMXNSaW12bks5V0lMbElvS3c0Zm92RDI1?=
 =?utf-8?B?T254cEFja3VZZWVoSzc2STltYjVKTHU1U2cyOEJuWmYyRUx0R1pJSWljWWFN?=
 =?utf-8?B?bTZWYXNkNFZrYjZyNkZ3ZXc3YnRCYzJ3aXZpQnliRUptV2gycHNsMGZNS1BJ?=
 =?utf-8?B?a3Q1QW9XNXB1RHBObmxXakhCV3FEODdMMjB4U0tMUUJOTTFtNk1sbHppSlJL?=
 =?utf-8?B?V3dFa1R3aW5MMDd6Q1BkTFdQK3hJOFdiWHc2TzRqdHpOSldJcDUwMEpSY2hB?=
 =?utf-8?B?dkRlaGlyejNIM1puNUsrTy85UHpSalRmUWVSVnV1Qk5xcmVzNFZkNmZ5dGZ5?=
 =?utf-8?B?VDkwVkpMWmFzL2svWnZwTFllbmkrc0VjMy9TeUdEeklOcFE1ZU8yZnFYMXhp?=
 =?utf-8?B?MFpCZ1VUb3E1VGdoNGhNZ3RKL0JEZjBZUVBDME9CenlUcnppLzl1RlJCSzdH?=
 =?utf-8?B?MzlhbWVuRDNlTTNpZjVyUGpHdmt6K0g1NGZWS1lEVzdJKzhvSi9OVXluVUtn?=
 =?utf-8?B?TmQyUVpEUU1EM2ZGUW9IMnlQSGhzem9WQytRQ3h1TWZ4b2x6M2VycUJwOTdI?=
 =?utf-8?B?Q203aUxjR0Yxb2RFV2QvVHMrZ0xZZDdrK1VTRkg0ZU5hRml1bTRhVEFPUGp4?=
 =?utf-8?B?eGNqRFlGQXZKbjdCYjQwcmpTbFVjT1NhNTBuNWNYYjJVMUlWTFJDc0hWRTha?=
 =?utf-8?B?M1YzRTgwUzFsd1NYWmdHWUtzdGNuOEFUdHNwMkRMdXVTWDlpQ0JCbUo1TE1W?=
 =?utf-8?B?bW5UMmdJMU05c1l1MmF6ampOcGp0Lyt1M292UlRmNzMrTzhZZXBsRTlBa1Vn?=
 =?utf-8?B?RDg0NklwVDRtc0VCelFmTGZVemd5SWUwRWJWZXBGU1llNlVLdWFucDZRQ2hH?=
 =?utf-8?B?WWtpbGMySWU5VjRiYnRJaXMvZVlkU0dqWGxDTVVOMVdkczRZdENiRHR3T0xB?=
 =?utf-8?B?K0Q1QzJYN0g0U3BITjVPTUt4bDRKd0JjSXRTa3E4UG5sT21ZaXZreSsrUmM3?=
 =?utf-8?B?ZC9DbjRmbjNUcnFLWXZVL0RvT1lSYmhMSlpLUFczd2hpZGp0aVd1ZE9Jc3Yv?=
 =?utf-8?B?ZkZweGphdk9JZUNpaWlvemZDbHRPU1VSV1hyY2EwRWc5TW9aWkxNV29lTE8v?=
 =?utf-8?B?Q0hDQ2ZTdFRFckYrdENRRUMzSis5eURMUG5hcVdxRmJYTGltbEpSN3IyZG9R?=
 =?utf-8?B?MkR4dUp0QmVZYTVEMTRRd0xOWEhpOWZld0V0eXQvT2NKWUdKNmg1UkNIRyts?=
 =?utf-8?B?cnpCRElMZEZFM0hxbFI0SDhYdWNHU1R3MUNtay9EbGlYMVl6SFNxdG9XK0RM?=
 =?utf-8?B?SEtzNlVCdXpJUzA2N1YweWZwTEY5Qzd2OEJPUS92MW1xK2d3L2xQYUZ3YzFP?=
 =?utf-8?B?a3JIcUgxdDNWKzJuTnJ5aXh1dlhFNm4zT1BXcktpVEFmWHpXdkZJd09qWUlK?=
 =?utf-8?B?YzJEcUR3NHhJdFJ1emZyYUFUMk9RVGFsSXJTSUJ5dXM2MFRJY1NwR1JBQ0lk?=
 =?utf-8?B?NXRmMjhrSjhHdzBveGtDdHZoUFo1OWQzeUIyYXZ1cUcyWWpxajhlZW0yZnZL?=
 =?utf-8?B?QUhUQWxCK09IMFV1MHdqNGFUSCt5NFVGRXVGVGpHMVNjNXFiK3R4YnBoWUVK?=
 =?utf-8?B?M3AwU3hIQkxnSzhtS1RqR1NJRWlUQkVRZGhseFhYMHhDQVU0ZDhsaTMvZjho?=
 =?utf-8?B?aE5DQkpHZ0JDWGNBMHo0Z2dqd0hONnduaFZwOGdGT2duYURqWk1EZFkzQ0FV?=
 =?utf-8?B?am4zUGNKSGdBN2RxTkJJMFpwdlpxS2NjU3Z3YnFhT2R3cVJDb0wwa2FQOVZG?=
 =?utf-8?B?N1lxYy8yak1kZERRanhXQ3FLSWZaN2NjSVFkZWxPbHdraDBZaTZObW9PSi80?=
 =?utf-8?B?VHZWd0h0YTc4dzVaWCtmSmdXODdpWFJMUTJaNXlEOXFUK2VXbnVPRVVCMGZD?=
 =?utf-8?B?cDdoS1V6ZXlweFlJM284WHhrMmE3K1pRL3Z2MkJHSDlPaTlGZHQzS29RN0NK?=
 =?utf-8?B?aWIwQ1JDVnpxNE1UZ0dWQWJSeldiM2l1dWMrQlowTlo1SnhwRjhEZDJxNWVG?=
 =?utf-8?Q?ovci+HZ6p3mwgnEKSxjk3JtrB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C53AC298AD7C254FB87EB163B716CA12@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ekinops.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 64abf597-94ea-4d54-7210-08dbcd96ef4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2023 15:53:54.6319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wr+FYhfJMT8oP5+CuTW5Ma1zvkwFy7re7h02n0nmqK35omgLCMIVhw8ALV96+f3honnET/9iRB25xM+/s7WjkewfyYhYOF5ZUe84cRcR+0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2439
Received-SPF: pass client-ip=2a01:111:f400:7e19::70c;
 envelope-from=vincent.jardin@ekinops.com;
 helo=FRA01-MR2-obe.outbound.protection.outlook.com
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

T24gMTAvMTUvMjMgMTA6NDIsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gU2F0LCBP
Y3QgMTQsIDIwMjMgYXQgMDk6MDY6MDlQTSArMDAwMCwgVmluY2VudCBKYXJkaW4gd3JvdGU6DQo+
PiBPbiAxMC8xNC8yMyAxODozNywgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPj4+IE9uIFNh
dCwgT2N0IDE0LCAyMDIzIGF0IDA2OjIyOjM0UE0gKzAyMDAsIFZpbmNlbnQgSmFyZGluIHdyb3Rl
Og0KPj4+PiBVc2luZyBpbnRlcmZhY2UncyBzZXR0aW5ncywgbGV0J3MgZW5mb3JjZSBhbiBhbHdh
eXMgb24gbGluayB1cC4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBKYXJkaW4g
PHZpbmNlbnQuamFyZGluQGVraW5vcHMuY29tPg0KPj4+DQo+Pj4gV2hhdCBpcyBnb2luZyBvbiBo
ZXJlPyBKdXN0IGRvbid0IHNldCBpdCBkb3duLg0KPj4NCj4+IFRoZSBwdXJwb3NlIGlzIHRvIGhh
dmUgYSBzdGFibGUgdkxpbmsgZm9yIHRoZSBWTXMgdGhhdCBkb24ndCBzdXBwb3J0DQo+PiBzdWNo
IHN5c2N0bCBhcnBfZXZpY3Rfbm9jYXJyaWVyOg0KPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVs
Lm9yZy9wcm9qZWN0L25ldGRldmJwZi9wYXRjaC8yMDIxMTEwMTE3MzYzMC4zMDA5NjktMi1wcmVz
dHdvakBnbWFpbC5jb20vDQo+Pg0KPj4gV2UgYXJlIGZhY2luZyBzb21lIHVzZXJzIG9mIHZTd2l0
Y2hlcyB0aGF0IHVzZSB2aG9zdC11c2VyIGFuZCB0aGF0DQo+PiBkaXNjb25uZWN0IGFuZCByZWNv
bm5lY3QgZHVyaW5nIHNvbWUgb3BlcmF0aW9ucy4gRm9yIG1vc3Qgb2YgdGhlIFZNcyBvbg0KPj4g
dGhlaXIgZGVwbG95bWVudHMgd2l0aCBzdWNoIHZTd2l0Y2hlcywgdGhvc2UgVk1zJyB2TGluayBz
aG91bGQgbm90IGZsYXAuDQo+Pg0KPj4gRm9yIHRob3NlIFZNcywgdGhlIGZsYXBzIGFyZSBjcml0
aWNhbCBhbmQgdGhleSBjYW4gbGVhZCB0byBzb21lDQo+PiBjb252ZXJnZW5jZSBpc3N1ZXMuDQo+
Pg0KPj4gSWYgdGhpcyBjYXBhYmlsaXR5IGlzIG5vdCBhdCB0aGUgdmlydGlvLW5ldCBsZXZlbCwg
c2hvdWxkIGl0IGJlIGF0DQo+PiBxZW11J3MgbmV0X3Zob3N0X3VzZXJfZXZlbnQoKSA/DQo+PiBG
b3IgaW5zdGFuY2UsIGZyb20NCj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUvYmxvYi82
MzAxMTM3M2FkMjJjNzk0YTAxM2RhNjk2NjNjMDNmMTI5N2E1YzU2L25ldC92aG9zdC11c2VyLmMj
TDI2Ng0KPj4gPw0KPj4NCj4+IGJlc3QgcmVnYXJkcywNCj4+ICAgICBWaW5jZW50DQo+IA0KPiAN
Cj4gbWFrZXMgc2Vuc2UNCg0KT0ssIEkndmUganVzdCBzdWJtaXR0ZWQgYSBSRkMgZHJhZnQgdjIg
YXNzdW1pbmcgbmV0L3Zob3N0LXVzZXIuYyBpbnN0ZWFkIA0Kb2YgbmV0LXZpcnRpby4NCg0KDQoN
Cj4gDQo+Pg0KPj4+DQo+Pj4+IC0tLQ0KPj4+PiAgICBody9uZXQvdmlydGlvLW5ldC5jICAgICAg
ICAgICAgfCA4ICsrKysrKysrDQo+Pj4+ICAgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1uZXQu
aCB8IDIgKysNCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9uZXQvdmlydGlvLW5ldC5jIGIvaHcvbmV0L3ZpcnRpby1u
ZXQuYw0KPj4+PiBpbmRleCAyOWUzM2VhNWVkLi5lNzMxYjRmZGVhIDEwMDY0NA0KPj4+PiAtLS0g
YS9ody9uZXQvdmlydGlvLW5ldC5jDQo+Pj4+ICsrKyBiL2h3L25ldC92aXJ0aW8tbmV0LmMNCj4+
Pj4gQEAgLTc4LDYgKzc4LDkgQEANCj4+Pj4gICAgICAgdHNvL2dzby9ncm8gJ29mZicuICovDQo+
Pj4+ICAgICNkZWZpbmUgVklSVElPX05FVF9SU0NfREVGQVVMVF9JTlRFUlZBTCAzMDAwMDANCj4+
Pj4gICAgDQo+Pj4+ICsvKiBmb3JjZSBhbHdheXMgbGluayB1cCAqLw0KPj4+PiArI2RlZmluZSBW
SVJUSU9fTkVUX0xJTktfVVAgZmFsc2UNCj4+Pj4gKw0KPj4+PiAgICAjZGVmaW5lIFZJUlRJT19O
RVRfUlNTX1NVUFBPUlRFRF9IQVNIRVMgKFZJUlRJT19ORVRfUlNTX0hBU0hfVFlQRV9JUHY0IHwg
XA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJ
T19ORVRfUlNTX0hBU0hfVFlQRV9UQ1B2NCB8IFwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfVURQdjQgfCBc
DQo+Pj4+IEBAIC00NDcsNiArNDUwLDkgQEAgc3RhdGljIHZvaWQgdmlydGlvX25ldF9zZXRfbGlu
a19zdGF0dXMoTmV0Q2xpZW50U3RhdGUgKm5jKQ0KPj4+PiAgICAgICAgZWxzZQ0KPj4+PiAgICAg
ICAgICAgIG4tPnN0YXR1cyB8PSBWSVJUSU9fTkVUX1NfTElOS19VUDsNCj4+Pj4gICAgDQo+Pj4+
ICsgICAgaWYgKG4tPm5ldF9jb25mLmxpbmtfdXApDQo+Pj4+ICsgICAgICAgIG4tPnN0YXR1cyB8
PSBWSVJUSU9fTkVUX1NfTElOS19VUDsNCj4+Pj4gKw0KPj4+PiAgICAgICAgaWYgKG4tPnN0YXR1
cyAhPSBvbGRfc3RhdHVzKQ0KPj4+PiAgICAgICAgICAgIHZpcnRpb19ub3RpZnlfY29uZmlnKHZk
ZXYpOw0KPj4+PiAgICANCj4+Pj4gQEAgLTM5NDcsNiArMzk1Myw4IEBAIHN0YXRpYyBQcm9wZXJ0
eSB2aXJ0aW9fbmV0X3Byb3BlcnRpZXNbXSA9IHsNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgIFZJUlRJT19ORVRfRl9HVUVTVF9VU082LCB0cnVlKSwNCj4+Pj4gICAgICAgIERFRklORV9Q
Uk9QX0JJVDY0KCJob3N0X3VzbyIsIFZpcnRJT05ldCwgaG9zdF9mZWF0dXJlcywNCj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19ORVRfRl9IT1NUX1VTTywgdHJ1ZSksDQo+Pj4+
ICsgICAgREVGSU5FX1BST1BfQk9PTCgibGlua191cCIsIFZpcnRJT05ldCwgbmV0X2NvbmYubGlu
a191cCwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgVklSVElPX05FVF9MSU5LX1VQKSwN
Cj4+Pj4gICAgICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+Pj4+ICAgIH07DQo+Pj4+
ICAgIA0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW5ldC5oIGIv
aW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW5ldC5oDQo+Pj4+IGluZGV4IDU1OTc3ZjAxZjAuLjM4
NWJlYmFiMzQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1uZXQu
aA0KPj4+PiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tbmV0LmgNCj4+Pj4gQEAgLTU2
LDYgKzU2LDcgQEAgdHlwZWRlZiBzdHJ1Y3QgdmlydGlvX25ldF9jb25mDQo+Pj4+ICAgICAgICBj
aGFyICpkdXBsZXhfc3RyOw0KPj4+PiAgICAgICAgdWludDhfdCBkdXBsZXg7DQo+Pj4+ICAgICAg
ICBjaGFyICpwcmltYXJ5X2lkX3N0cjsNCj4+Pj4gKyAgICBib29sIGxpbmtfdXA7IC8qIGlmIHNl
dCBlbmZvcmNlIGxpbmsgdXAsIG5ldmVyIGRvd24gKi8NCj4+Pj4gICAgfSB2aXJ0aW9fbmV0X2Nv
bmY7DQo+Pj4+ICAgIA0KPj4+PiAgICAvKiBDb2FsZXNjZWQgcGFja2V0cyB0eXBlICYgc3RhdHVz
ICovDQo+Pj4+IEBAIC0xODAsNiArMTgxLDcgQEAgc3RydWN0IFZpcnRJT05ldCB7DQo+Pj4+ICAg
ICAgICBzaXplX3QgZ3Vlc3RfaGRyX2xlbjsNCj4+Pj4gICAgICAgIHVpbnQ2NF90IGhvc3RfZmVh
dHVyZXM7DQo+Pj4+ICAgICAgICB1aW50MzJfdCByc2NfdGltZW91dDsNCj4+Pj4gKyAgICB1aW50
MzJfdCBsaW5rX3VwOyAvKiBpZiBzZXQgZW5mb3JjZSBsaW5rIHVwLCBuZXZlciBkb3duICovDQo+
Pj4+ICAgICAgICB1aW50OF90IHJzYzRfZW5hYmxlZDsNCj4+Pj4gICAgICAgIHVpbnQ4X3QgcnNj
Nl9lbmFibGVkOw0KPj4+PiAgICAgICAgdWludDhfdCBoYXNfdWZvOw0KPj4+PiAtLSANCj4+Pj4g
Mi4zNC4xDQo+Pj4NCj4+DQo+IA0KDQo=

