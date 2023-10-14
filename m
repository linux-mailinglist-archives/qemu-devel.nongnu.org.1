Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5A7C966E
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 23:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrlpz-0005YZ-CW; Sat, 14 Oct 2023 17:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qrlpx-0005YN-Dz
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 17:06:17 -0400
Received: from mail-mr2fra01on20703.outbound.protection.outlook.com
 ([2a01:111:f400:7e19::703]
 helo=FRA01-MR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vincent.jardin@ekinops.com>)
 id 1qrlpu-0000ZM-L0
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 17:06:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUunPq+/46lCzgahLaTlCYTw/mB1ckxatzD9KPtfTdj2/icSCF0iMcwxEL/qo5cRe64pPTREDEKqm3lMmv6KZxXoXhIj5jroxoA6E0nhlrJWtajNCsSTo8qIwzcmfaL6fFUibT3np+BbQTZCddKWfSo4jMOM6b8WMcjHLpJsEH9VXgelMiV/8xj1te0/WherYRop92haNsIClz6RPewDbXcxlEMtquB09eAKbNeReU9LJ/Qn8/9zqL3QFOYNh2XOAQkX+kf2QEo9FXDJ4KaUp3aeqsiEArXwmY7hZD0VfIn/vY1wxW/703fFeJmqnuTe1FFzxNtdqtWxQLlawWM3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pwSGZlwNNYiaO4X9MvpBt6DpMmSUhP64K558urPQTc4=;
 b=gg9ft72nMt/OfGqyWYb7PZ1K3LvwDMwdkQIlD3btRFJwMBf0i8a6A/TCi44zqDScuA0lIjxkX00RNMBNJixikz6D0rpAwhRJWVPN7z9OkVYzqemit/sMScaOgaLquqtmpQm3qJyDqcdiCT0d+63H6ge2LPds8Da0MQESqwCIscOB617hGgxm7cUzY2Xk3l5R5rjM/5sm5lu8NZ0nriEfzLBMjhLugxGWx66I6OyJOimZkMZBdJAL/CzQe0mPVu6MdX4MKdoRWx9yW3wzZ5lzCR1XO1wFFaUiXwNUVPutimGQmC0XysozdyA4rG5iy8SlSeIexnCbi8rAwxnsvJD82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ekinops.com; dmarc=pass action=none header.from=ekinops.com;
 dkim=pass header.d=ekinops.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ekinops.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pwSGZlwNNYiaO4X9MvpBt6DpMmSUhP64K558urPQTc4=;
 b=Ceo7qGB7Sb9aatsEw1W3Y38PBvcmr9Rwvr8HQcYWtmz7REPlZ6MwavBD6tf3N1mkkZH+rlYIrDPuuXvUlKoY8w32moO+ebw9/MA4XOHQpqkECklQcU6exuBplwEemPXT7FgpGbLdM0k/K8fu5WElygADZWsYb7sLydWHlmHRBsk=
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::14)
 by PR1P264MB3447.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:182::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sat, 14 Oct
 2023 21:06:09 +0000
Received: from PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f]) by PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
 ([fe80::849f:914a:1a04:d28f%3]) with mapi id 15.20.6886.034; Sat, 14 Oct 2023
 21:06:09 +0000
From: Vincent Jardin <vincent.jardin@ekinops.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jasowang@redhat.com"
 <jasowang@redhat.com>
Subject: Re: [RFC] virtio: enforce link up
Thread-Topic: [RFC] virtio: enforce link up
Thread-Index: AQHZ/rq5hgr+F0IIsUmQ9K0/o+z56bBJe9+AgABLLYA=
Date: Sat, 14 Oct 2023 21:06:09 +0000
Message-ID: <8f110502-7ab7-4db2-9702-3717cf6afc58@ekinops.com>
References: <20231014162234.153808-1-vincent.jardin@ekinops.com>
 <20231014123635-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231014123635-mutt-send-email-mst@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ekinops.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR1P264MB2295:EE_|PR1P264MB3447:EE_
x-ms-office365-filtering-correlation-id: cd358766-4f11-4a11-9cee-08dbccf963ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L0jSUrgzKKap0dGikoggGrtkr2SP6sYG5GRE0xTE8ARcutSwSDR/e6OmTU29FcOll6ZfX/ZH6OusZRMf6aQpncWm+cyKSoH7N9C+U/mme457UKuzSK9ZG3nW/0XankMsxCjye7C7cg7/IxGY2aLyuxx8safLpF//Knj1NraIWF3o9bO6Rj8x+4bhvSoW4sERFNcZjO/orryYaZPoFH8A3WD2Yc7MUYXI3QUpuE0+n7RsVEgndWjnb1TBnxkALOt0OQR5Vcf4eZ1vFJV3II9fR6JKuh5vfW9T5ZW4eq8yALERYYxht0MHwiPkqZYD/H33fXjSBuDpmEmxgoKwaN0bgIJlIbxHwAZHVrsp7CuRCOQPhOf2TarcqHtdldU2UCTEEeK2MzcT5c2vJt2BRtAJz7KJDPmair28nv3jKO3F6KsVhb5KYbw1SfxtSNr5dDPL9TOuBuCPZAP/QGhKipeA1erlcuqxlagQXgQtviC9VhfWB/buwViicmq0qFS0sQDH/ETRa+Q9E0UKiG1mHlFM0SIDFZItYEJ8WhAdUbU0llhxj8yqUDUXO5Irx6TAZJxv4svfo0SgoqRfROUr8WwbeV+/IRsxXqeEQbJekI7KhbwPYDnObeRO43HjThguEcl9AwOVIjdRpta2q5N/yPT89k7DJKbyjnu5LGl+zLxjP1s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39840400004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38100700002)(6512007)(38070700005)(26005)(2616005)(122000001)(478600001)(966005)(6486002)(44832011)(5660300002)(8936002)(8676002)(4326008)(86362001)(31696002)(2906002)(316002)(6916009)(54906003)(64756008)(66446008)(36756003)(41300700001)(66476007)(66556008)(66946007)(76116006)(91956017)(71200400001)(53546011)(6506007)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTlKWFJhK0ZvekpPejRtcXIySHpZaEYyWVNDRW1LeUU3RDBMQjVlOWJFTGVl?=
 =?utf-8?B?dzZvUmVORXBpdzJnMUZnd3lUN0g1M2pwMmNBSUU4azYxc0VNQ01KcXhuNS8y?=
 =?utf-8?B?VnRIdlJPV25qOXRyUTUzTDNnclczWURRSWhCOGF0WGpTWnlOZmo2RGt5aGVT?=
 =?utf-8?B?bVJTZkJhSkdpKzBYUkVHNGtwakRJWWZlSjBOQW53M3cySzhXTDBrZ1NWSnI0?=
 =?utf-8?B?WW9oTW9XVk0vbnBVT2JsazgrZml2QXB5RHhsQmNMd0dHVTg1cHk4Y2hoaFVH?=
 =?utf-8?B?U3Y3VytDb3pyamNOQWNIWGF6amc1QnpDZEMxd2NnYUlpcE1jaFJWZFM4RHR2?=
 =?utf-8?B?V0l4WklSQ2YrNytWUzhNbW9ESlRoSGtKOTkzQ054bVNuZkw2dnpQYlBzUFJS?=
 =?utf-8?B?Z0Vpdm96bUpLR0R3dFpVbG80UTd6SFVPRUdnTGplL1pkUDY0elgvSmt3RlB1?=
 =?utf-8?B?d0g5SVQ1OStLdXhUaU9OVytBQk9WV1hpQmlVRjZPNjZPZGUxSTg0MWVwMzlI?=
 =?utf-8?B?alNHM2QvVzFCZjByVW5WR1ZnUHR1SUpSeHcvTUE5Z0JQYXVQSVA3NXV5SDd0?=
 =?utf-8?B?eGJka2xKVmFqRnhYcXE1VTdPbE01VzMzQVFpR2M2N2xTMVV0bE9LQTk2ODcx?=
 =?utf-8?B?VWx6dXcyUkQwaGxhVVN3S3ZQdUI5bzYydFdqUElqTlFiaDlLeitvUTUzTUlF?=
 =?utf-8?B?K056TVRCbDlWTWpKYlpTNlR1VmZIWTdtQXJzTVdpcGR6V1ZETCtpcUluSGFH?=
 =?utf-8?B?ejBscjJUOHYvZXl0Z3FpaVpNd01IR1c5Q1NlNSsyREJwcktEdFZaSGNiVFNY?=
 =?utf-8?B?em5xam1QRTU4dTlzMmowVlQwK1VqUkpIOG5aVkpnOTB0SVU3V0JjVW9YNTEw?=
 =?utf-8?B?K2Y4Q3d0eHNIMjJiZFpjZXlnYlFTUG0wODN0RGNiVWRUV29DVjJPemVlSU0w?=
 =?utf-8?B?aktNT3ZTZ2VndzhHTXNrTGtvT1djOFFtTjY2NXlzdlVhZXZOemhxeUtWbU9z?=
 =?utf-8?B?OVNWbC9LbmxOcXplakpmSDZvYkZIYkJtVHQzbkZldVUyekpkWHIvS0haRXA4?=
 =?utf-8?B?ODV5SkFnWitaRHRpOHkzQ2p3KzRWZFYzeXF2Mk56QkpsT1pFT1VMRnBYWlRU?=
 =?utf-8?B?L2V0NElUZnNlSWs1c3FTVDE3TXVZejB4bUsrT0crUUtkL09NdkFyZVgyOUZt?=
 =?utf-8?B?VnU4QzJGb1NZQVoyS3ozTlNXamJCVmdvSk1WRlFoN09OVXhzMjVzZ3dWeVBP?=
 =?utf-8?B?d3J0Zmd2L01mOXZINGN6dUFYQ0lsU2hPaE0rSWNjRkdHZEdpMnRjNVpISHVk?=
 =?utf-8?B?SW1yVmlRTlAyWDBXZHE5emRZVS9iM0QraENQeEdpa2hWQ2N0K3prVWdOb0x4?=
 =?utf-8?B?dFR4aEpiMmlGL0hZWEVXN2hxa2w2SDU3SFlnRjlIcEdnLy9NS3lodE9GSUhk?=
 =?utf-8?B?cUpQYlI5TGhzWmUvSy93eUo4UjVEK0tPQjBJQitZQmRsdTYrMUx1UlNZeHNB?=
 =?utf-8?B?b1lnN0h6aGhoeU9nSm9NOGp0OHZvWlZuNXlQZWgxejk2UzVXWVZraVk5dUxI?=
 =?utf-8?B?bjUvU3AzUCt0UGlZUmZncHRmRGlOU256Zk9Xek9tNlNXYzBoaVpyZHNvSVBv?=
 =?utf-8?B?TktJWExjODVRNXhjbXQ1cXdBeXE0UUhSSHdEOElNaGFQYkU2WTNXTGNwS2tx?=
 =?utf-8?B?THBwRitrMWhSSkl5SWFzNmgyd1drT1Bockhwc09XY0U4ZzlsTExiN1YwbnVK?=
 =?utf-8?B?VnhtQlBDS3crZTllK1RNbllUVWNja1J1U0FLeU1vRjd3L0x5dmt5YUhXWXh0?=
 =?utf-8?B?cE8vRmFPS3BJcjFZS2JJM0tKSi9odUR0K2JBOUNIY0JpSTdlVUhvblZlbHIr?=
 =?utf-8?B?YlNDOFZadk5MVGNZa2Z1aFZNbUFzbWFxalUxZDlmR1F3aTBrUytXMnkyTTBu?=
 =?utf-8?B?L0pHVnp5bzZ6YXEyK0JXdkJ4MXArZjZzQVh1SDNxeGRTdDdoSnAvTS9qRmFD?=
 =?utf-8?B?eVc2V2RPZldEcUFveUE4c1MwcGZiY2JSaG9CY0tsOVY0SkZQM1JhQ0luc2Qr?=
 =?utf-8?B?S3RZZ1d3YXU3WmVudWRJL0MyQ0lCU1JXbjUyTFpPd29NeWVlWlh2UnBtdmRz?=
 =?utf-8?Q?DdhbalSRloOX/unwhN4pYFWbG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F1DA264CA1DE444B69CA55E42A8217A@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ekinops.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR1P264MB2295.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cd358766-4f11-4a11-9cee-08dbccf963ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2023 21:06:09.8261 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f57b78a6-c654-4771-a72f-837275f46179
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 77yedUNpYvCDbFa3nM4N0TZQeTKALMmWncXichTXf9GcYUX8OOXL4NLftqz3anlvK5sOFk4lLAdJLuk/aL/ANj9HL3IPDKqbFNBWcDg/izQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3447
Received-SPF: pass client-ip=2a01:111:f400:7e19::703;
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

T24gMTAvMTQvMjMgMTg6MzcsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToNCj4gT24gU2F0LCBP
Y3QgMTQsIDIwMjMgYXQgMDY6MjI6MzRQTSArMDIwMCwgVmluY2VudCBKYXJkaW4gd3JvdGU6DQo+
PiBVc2luZyBpbnRlcmZhY2UncyBzZXR0aW5ncywgbGV0J3MgZW5mb3JjZSBhbiBhbHdheXMgb24g
bGluayB1cC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBWaW5jZW50IEphcmRpbiA8dmluY2VudC5q
YXJkaW5AZWtpbm9wcy5jb20+DQo+IA0KPiBXaGF0IGlzIGdvaW5nIG9uIGhlcmU/IEp1c3QgZG9u
J3Qgc2V0IGl0IGRvd24uDQoNClRoZSBwdXJwb3NlIGlzIHRvIGhhdmUgYSBzdGFibGUgdkxpbmsg
Zm9yIHRoZSBWTXMgdGhhdCBkb24ndCBzdXBwb3J0IA0Kc3VjaCBzeXNjdGwgYXJwX2V2aWN0X25v
Y2FycmllcjoNCmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9uZXRkZXZicGYv
cGF0Y2gvMjAyMTExMDExNzM2MzAuMzAwOTY5LTItcHJlc3R3b2pAZ21haWwuY29tLw0KDQpXZSBh
cmUgZmFjaW5nIHNvbWUgdXNlcnMgb2YgdlN3aXRjaGVzIHRoYXQgdXNlIHZob3N0LXVzZXIgYW5k
IHRoYXQgDQpkaXNjb25uZWN0IGFuZCByZWNvbm5lY3QgZHVyaW5nIHNvbWUgb3BlcmF0aW9ucy4g
Rm9yIG1vc3Qgb2YgdGhlIFZNcyBvbiANCnRoZWlyIGRlcGxveW1lbnRzIHdpdGggc3VjaCB2U3dp
dGNoZXMsIHRob3NlIFZNcycgdkxpbmsgc2hvdWxkIG5vdCBmbGFwLg0KDQpGb3IgdGhvc2UgVk1z
LCB0aGUgZmxhcHMgYXJlIGNyaXRpY2FsIGFuZCB0aGV5IGNhbiBsZWFkIHRvIHNvbWUgDQpjb252
ZXJnZW5jZSBpc3N1ZXMuDQoNCklmIHRoaXMgY2FwYWJpbGl0eSBpcyBub3QgYXQgdGhlIHZpcnRp
by1uZXQgbGV2ZWwsIHNob3VsZCBpdCBiZSBhdCANCnFlbXUncyBuZXRfdmhvc3RfdXNlcl9ldmVu
dCgpID8NCkZvciBpbnN0YW5jZSwgZnJvbSANCmh0dHBzOi8vZ2l0aHViLmNvbS9xZW11L3FlbXUv
YmxvYi82MzAxMTM3M2FkMjJjNzk0YTAxM2RhNjk2NjNjMDNmMTI5N2E1YzU2L25ldC92aG9zdC11
c2VyLmMjTDI2NiANCj8NCg0KYmVzdCByZWdhcmRzLA0KICAgVmluY2VudA0KDQoNCj4gDQo+PiAt
LS0NCj4+ICAgaHcvbmV0L3ZpcnRpby1uZXQuYyAgICAgICAgICAgIHwgOCArKysrKysrKw0KPj4g
ICBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tbmV0LmggfCAyICsrDQo+PiAgIDIgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9uZXQvdmlydGlv
LW5ldC5jIGIvaHcvbmV0L3ZpcnRpby1uZXQuYw0KPj4gaW5kZXggMjllMzNlYTVlZC4uZTczMWI0
ZmRlYSAxMDA2NDQNCj4+IC0tLSBhL2h3L25ldC92aXJ0aW8tbmV0LmMNCj4+ICsrKyBiL2h3L25l
dC92aXJ0aW8tbmV0LmMNCj4+IEBAIC03OCw2ICs3OCw5IEBADQo+PiAgICAgIHRzby9nc28vZ3Jv
ICdvZmYnLiAqLw0KPj4gICAjZGVmaW5lIFZJUlRJT19ORVRfUlNDX0RFRkFVTFRfSU5URVJWQUwg
MzAwMDAwDQo+PiAgIA0KPj4gKy8qIGZvcmNlIGFsd2F5cyBsaW5rIHVwICovDQo+PiArI2RlZmlu
ZSBWSVJUSU9fTkVUX0xJTktfVVAgZmFsc2UNCj4+ICsNCj4+ICAgI2RlZmluZSBWSVJUSU9fTkVU
X1JTU19TVVBQT1JURURfSEFTSEVTIChWSVJUSU9fTkVUX1JTU19IQVNIX1RZUEVfSVB2NCB8IFwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVU
X1JTU19IQVNIX1RZUEVfVENQdjQgfCBcDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVklSVElPX05FVF9SU1NfSEFTSF9UWVBFX1VEUHY0IHwgXA0KPj4gQEAg
LTQ0Nyw2ICs0NTAsOSBAQCBzdGF0aWMgdm9pZCB2aXJ0aW9fbmV0X3NldF9saW5rX3N0YXR1cyhO
ZXRDbGllbnRTdGF0ZSAqbmMpDQo+PiAgICAgICBlbHNlDQo+PiAgICAgICAgICAgbi0+c3RhdHVz
IHw9IFZJUlRJT19ORVRfU19MSU5LX1VQOw0KPj4gICANCj4+ICsgICAgaWYgKG4tPm5ldF9jb25m
LmxpbmtfdXApDQo+PiArICAgICAgICBuLT5zdGF0dXMgfD0gVklSVElPX05FVF9TX0xJTktfVVA7
DQo+PiArDQo+PiAgICAgICBpZiAobi0+c3RhdHVzICE9IG9sZF9zdGF0dXMpDQo+PiAgICAgICAg
ICAgdmlydGlvX25vdGlmeV9jb25maWcodmRldik7DQo+PiAgIA0KPj4gQEAgLTM5NDcsNiArMzk1
Myw4IEBAIHN0YXRpYyBQcm9wZXJ0eSB2aXJ0aW9fbmV0X3Byb3BlcnRpZXNbXSA9IHsNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19ORVRfRl9HVUVTVF9VU082LCB0cnVlKSwNCj4+
ICAgICAgIERFRklORV9QUk9QX0JJVDY0KCJob3N0X3VzbyIsIFZpcnRJT05ldCwgaG9zdF9mZWF0
dXJlcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19ORVRfRl9IT1NUX1VTTywg
dHJ1ZSksDQo+PiArICAgIERFRklORV9QUk9QX0JPT0woImxpbmtfdXAiLCBWaXJ0SU9OZXQsIG5l
dF9jb25mLmxpbmtfdXAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX0xJ
TktfVVApLA0KPj4gICAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4+ICAgfTsNCj4+
ICAgDQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW5ldC5oIGIvaW5j
bHVkZS9ody92aXJ0aW8vdmlydGlvLW5ldC5oDQo+PiBpbmRleCA1NTk3N2YwMWYwLi4zODViZWJh
YjM0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW5ldC5oDQo+PiAr
KysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8tbmV0LmgNCj4+IEBAIC01Niw2ICs1Niw3IEBA
IHR5cGVkZWYgc3RydWN0IHZpcnRpb19uZXRfY29uZg0KPj4gICAgICAgY2hhciAqZHVwbGV4X3N0
cjsNCj4+ICAgICAgIHVpbnQ4X3QgZHVwbGV4Ow0KPj4gICAgICAgY2hhciAqcHJpbWFyeV9pZF9z
dHI7DQo+PiArICAgIGJvb2wgbGlua191cDsgLyogaWYgc2V0IGVuZm9yY2UgbGluayB1cCwgbmV2
ZXIgZG93biAqLw0KPj4gICB9IHZpcnRpb19uZXRfY29uZjsNCj4+ICAgDQo+PiAgIC8qIENvYWxl
c2NlZCBwYWNrZXRzIHR5cGUgJiBzdGF0dXMgKi8NCj4+IEBAIC0xODAsNiArMTgxLDcgQEAgc3Ry
dWN0IFZpcnRJT05ldCB7DQo+PiAgICAgICBzaXplX3QgZ3Vlc3RfaGRyX2xlbjsNCj4+ICAgICAg
IHVpbnQ2NF90IGhvc3RfZmVhdHVyZXM7DQo+PiAgICAgICB1aW50MzJfdCByc2NfdGltZW91dDsN
Cj4+ICsgICAgdWludDMyX3QgbGlua191cDsgLyogaWYgc2V0IGVuZm9yY2UgbGluayB1cCwgbmV2
ZXIgZG93biAqLw0KPj4gICAgICAgdWludDhfdCByc2M0X2VuYWJsZWQ7DQo+PiAgICAgICB1aW50
OF90IHJzYzZfZW5hYmxlZDsNCj4+ICAgICAgIHVpbnQ4X3QgaGFzX3VmbzsNCj4+IC0tIA0KPj4g
Mi4zNC4xDQo+IA0KDQo=

