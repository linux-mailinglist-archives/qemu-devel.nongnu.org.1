Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CCE798B9D
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 19:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qefiR-00071O-WC; Fri, 08 Sep 2023 13:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qefiP-000717-RV; Fri, 08 Sep 2023 13:56:22 -0400
Received: from mail-co1nam11on20614.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::614]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qefiM-00070U-Ea; Fri, 08 Sep 2023 13:56:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I60eVhqzA1NSWN/yzvugankgTWRoG5XOQ/KBxzfybzwfTCk2qE5NTXsKuwvco/uKrgFSoiwvpVNdNnXe+56e1hpfq5C6YyocVVye6TOFLdNluc93jLYeWkauutSOLs3VRqbwp+0gaAJmaYUJd76xlIRGawUxwAa+q/NW3nFJ8yuwmtcPdQkXqVx3j0apVJmzemoN4WBQ1ddSBKG3vkWiWy4UdsL4BKkfjGqtfZ0hbkiUINWmoOTRQccdw4GaR18oZm9ysH6WDIkKBUttNxls3dQO1YM1++42fpDbme5PS3c6mHVsj8yR+J9xjR3ncXS/71ReX07V3OTwWOTUA0fpFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJWk/HC5OE73Arb24EDwLgU/3hb2jeRiNRK1HdPbFhY=;
 b=XKL3PESKzyr+CkDI74tHo3DvkFD7AnPuAzzjJCe8YZ3AN2k4mQwwqFItKtzNoRReVTsXlwrxpwTo48N0TER5XecuJuNxsenGZTAye7Z/h4DoPhnR2gFYUfCLedLglyM2AWGWDGTpJAFLfnCXf8X3rGrFiC8AsB2auJfaeipvFr4oYQYrURC02u75csEF2KLl+qp46QXbzQFnH7UcypMUhtWuAQep1wNaPC/n+AVl+EZJh0MXN3lZov38rMB3Y3hFvcUG3T34Q9JG54NfpxYaiBkRmTSmfsMfJcpeHsBhf0umC+zjuMIKG9qh81ipEe0ZPZRFgH/PKkfxLpXckCDUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJWk/HC5OE73Arb24EDwLgU/3hb2jeRiNRK1HdPbFhY=;
 b=q2htP3nRVjBfF9xoPKKCtgETOHf7pa0z1xZp/OWpepwoR8dHS0MhKoacH6dfQBxX2xgxxiKAa33sIZ80T67AjNQvH0qEddPzg5ARinsVeNnzPwknoyTV7Oqzi0ZHZcT0SpKCw2a4BRMQcyh0XiWuVKl8ndugKTAAawERaXG7tsw=
Received: from BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 by CH3PR12MB8073.namprd12.prod.outlook.com (2603:10b6:610:126::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 8 Sep
 2023 17:56:11 +0000
Received: from BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::8e6d:40ac:2547:e850]) by BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::8e6d:40ac:2547:e850%4]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 17:56:11 +0000
From: "Ho, Tong" <tong.ho@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: Richard Henderson <richard.henderson@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alistair@alistair23.me" <alistair@alistair23.me>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>
Subject: RE: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
Thread-Topic: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
Thread-Index: AQHZ3C85IdR/2hbobUC8AAIMe7DmJrAFEeUAgABB0kCAC6qWAIAAQNBQ
Date: Fri, 8 Sep 2023 17:56:11 +0000
Message-ID: <BL0PR12MB4882D72296EE27610D9B04D5E6EDA@BL0PR12MB4882.namprd12.prod.outlook.com>
References: <20230831171849.3297497-1-tong.ho@amd.com>
 <20230831171849.3297497-2-tong.ho@amd.com>
 <622751d4-8a89-b34e-171f-9e9f7ac99972@linaro.org>
 <BL0PR12MB48829589D59FA02B93549E65E6E4A@BL0PR12MB4882.namprd12.prod.outlook.com>
 <CAFEAcA_KJFnxg-msgwiaFBzPYkj4RPQeYwLzd4RCy3_br11AGQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_KJFnxg-msgwiaFBzPYkj4RPQeYwLzd4RCy3_br11AGQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4882:EE_|CH3PR12MB8073:EE_
x-ms-office365-filtering-correlation-id: 98a3728a-fe4c-4c53-311f-08dbb094e343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NLkBUDHF+tElEJ0SOOB9NEUdu6wgbLwN8ZwYS5+59Lr4e+qgebSFNS4oCaJ0ysV/1nUZOSIWWPqU8vqAcXRTfYflwGaArSy1NsgEjYcO+SAkR67HuYBq1c0ip+RBoavuikZSM1PUswApNvtiIwV2bmFSvanHSOIH20SsjjY9tp4B/avFjM7TV5vjwxGO2ZnrqW6Ca3r9U5mS2nVGRyxYtsHbcPwH93jWAnFHXdhkhnuy6UqJMoLHUlnmv7Kl0isAPkbCxY5FlEL7hNjHGQ1qQzITALqpd41p5fDzniUX8RhXVO09InuCxHJUvd8RV8o2ukn72mshvZcC3aR5bqCAcXny3iQkqYYZCTNvZaK6U4gBEmRdDTrdmB25iVP/aCkIqr/ndZNLo7AZMAT4FOErFpw6O6E19F77BCtVQt3npAAWZ+XCwA/QvdpebYqEUQDc2ivuRQ9kFEKogOY6jBowcTQuWG+PAuKZ7QobiA6+sLy2myaiu46Mxuq64z1q16Eb1QLs8wGYKN29m3ykRyRpd0Rxlskv+sns0DKDcZravjQCIqycP/FFBeOFfBw7LXoaWuRb8ZoobrPUp60P77vpwDHzHK38IgZmvhenaieh3d1YXz8ZNrn6GkmjgTe84azC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199024)(186009)(1800799009)(53546011)(71200400001)(6506007)(7696005)(9686003)(83380400001)(478600001)(26005)(6916009)(2906002)(66446008)(76116006)(64756008)(66556008)(316002)(66476007)(66946007)(54906003)(41300700001)(52536014)(8676002)(5660300002)(8936002)(4326008)(86362001)(33656002)(38100700002)(55016003)(38070700005)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDJ1dmNLbDV3OG44dmp3TWNsLzA5cHlqSktDVjludG8vRmNrWUNROUtnM01k?=
 =?utf-8?B?aFhHVWRybWNtY1A3QzRIL3kyUEw3TDQwUDRXZmxOcE1vVXRiZFhXclZzRTI4?=
 =?utf-8?B?Ymo1TDV3ZGE4djNiem1kYWoySWZZdHRFdjFuNk9ldEJMeWQ2cGplUmFtY0pq?=
 =?utf-8?B?cGF0ODl1ZStqck5kcTRhenJScGNJU2VKa3RMMG01V1k2Zmtnc3JiMUIzc00r?=
 =?utf-8?B?Y1BpUG10ZnNOb09udml4U1ZIWkdGaVM2ZjdiMTd0M3luaEZlY0FVRkpPdTJK?=
 =?utf-8?B?bWlDV2NUSnNsWXFwQ3JiT0RRZTlISXlHeG5VVG5Na2Qwa0JwUmVmTUhuOWJu?=
 =?utf-8?B?VlNxUkltRWFTb0g1dTFjRjIyWlZON3hHSGxGbUZ0dUtMOGNXOGtyczk2VmND?=
 =?utf-8?B?NVpGYWx0RXI3cGFwOVRrdzZ3K2dnUUNhREtKbUtKcGlyZzBDSmQvRmlUY0NF?=
 =?utf-8?B?NC9FQVlNT2hBK3BPZ3JtOGE5ZGRKcGZjQjFqams4THEvaTBuQnUwOXZVNkVN?=
 =?utf-8?B?aEtYY2d1VDhCOWtlSGFhWnordHlaem5zY2FlbmJENTFIV05reThocGtxZ0Vo?=
 =?utf-8?B?dWZBOEQ4ZW1IWnFSc1JKRDlscXl5ekNzZ244MEVhM2t0dVljSU1hdndxZjNQ?=
 =?utf-8?B?Z0FRcGw4QnlDU2tjZ29NM1J5Q0RsZlptcDZKSm5tY1ZVRUtIbHNLTkVaZnZi?=
 =?utf-8?B?V3AwaUxmaExJMWU4VmdyREVIUHdQYjRzTUlrWnFEK0tUUkdkTzhkUWF1ajNC?=
 =?utf-8?B?b2hmN2czVklWZmIyRnJPUU9ZUDdNbWpxb280TGJJTWNOUW13YWxnVUY0eGxs?=
 =?utf-8?B?L1d5QWQydEJsaGJlWCtyMHR2TW1yV1BDUGswWE0wWEE4ajVuMHRnbEFpZ1J0?=
 =?utf-8?B?MjZpaHMxaDZyMWdCZnRKQlpPUkFFY3V0eVl6aEVFWGdiWGx5aUtRTVE3dnpQ?=
 =?utf-8?B?R3JSMCtaSXhPUXdTYXRHM0pqVFF2UWQyR3Q4ckFtaHZhTjFuNzUrTGo4Yitt?=
 =?utf-8?B?dWtXTi84MEQzNkVWQ2VzQUlEQ1J1Q25FOW9BYmoyRURRNG5KSklzM3k0cUZ5?=
 =?utf-8?B?WFZNcHI5MlJQZFNpMFhwaHkzLzMybXB3K0NJc0lJTVR3Y0g1MGJrUDlLVmp5?=
 =?utf-8?B?ZWdKWUJabjY2Tlc2QSsybTE3S3IwTzVnU2FhRDZFVEdBaUZWSWRBK0tKR2My?=
 =?utf-8?B?QmxhYkJFSW5CNXhNZVN0VDVPTFVaSjdFM2dLSDg5YUpsZmt0Z3FVdndSR0F1?=
 =?utf-8?B?bGJwU0NudmM0eS9CMmRsUm5PV3BkK3hoRnQ3UngwYnMxdmN4dCtLWTkvYUpP?=
 =?utf-8?B?TUE0L3haR3hva1J0NzNBWHNoczNSc1d4WjBvcnNaSkxRb0d3MkQ2cmd5NlZt?=
 =?utf-8?B?SVFpSzNReEIyaE9pS0luazE3K2FKaHN3TGxyQUZmZndkSG8xWi8yNDJ2dmdN?=
 =?utf-8?B?WU50VVFiWndrZjJwWW45RmF5WHdubUtaa0V2Z3dpOU83djYwWUIxTFVRTFFB?=
 =?utf-8?B?WEU5OHFwMGZmSFpqeUpaS1R3YXZxYVRjZDZNaU84L0RwaVprWi9XeUgrNkhH?=
 =?utf-8?B?YzhsN2cwdW4rQjQ1OEdISk9uWHZRODVrQmY2empwS0k5WU14YTk2ZUFHWEUy?=
 =?utf-8?B?VlBXTUxwNmt3c0h5UTgydmNRZ0lvSGdqV1pmZ2U4RG9GZWlsS2hIYmJqYUpv?=
 =?utf-8?B?ei9XT1dSMk1lTFN6QVhBVFlNc0JyRUJRVWwxeisrQkdoZVFSanpLejduMHA5?=
 =?utf-8?B?a2wvcWdVRjRqSDYzaFYxNFliWklneS94Umd1blJ6Q2hvWXNSNW1PVnFLN1Zk?=
 =?utf-8?B?NHBMa0hkeHpnNUhHTlFYOVdVTG5QcEoxN2MrdzJ2aEpLL0VqUnRBU1czalNm?=
 =?utf-8?B?S01jU2dRS2hRa3Axa2h1TmJ2WmtaWDVXZU5TV0hQd0xsV1M4S0dFTGVxUmky?=
 =?utf-8?B?V205RHJweHVhTlJnZEUraHdmVHBvUjA3QWVVa2dXQXpzWVgralBqcXVBZE16?=
 =?utf-8?B?VEVQdjFvTzBCTjNYMDdOZ3BtTW00R2FTeERKMDh4T2pDbXpRNFUwM1JmVjB6?=
 =?utf-8?B?aVl5ZnNTcU9jbkdZa25MdEpuUEJmUUZ3LzcvT3IyOFhrc0p5OHdzMHdUVXMy?=
 =?utf-8?Q?/L6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4882.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98a3728a-fe4c-4c53-311f-08dbb094e343
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2023 17:56:11.7450 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltkKqOpFo7V4WbBe/vlyd+R4/yWQ8gwaVkdhGCbT4wRbcqC/s/ifZi2z0F2qqx5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8073
Received-SPF: softfail client-ip=2a01:111:f400:7eab::614;
 envelope-from=tong.ho@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

SGkgUGV0ZXIsDQoNClRoZSBWZXJzYWwgVFJORyBkZXZpY2UgaXMgcmVxdWlyZWQgdG8gc3VwcG9y
dCBib3RoIFRSTkcgbW9kZSBhbmQgUFJORyBtb2RlLCBhbmQgdGFyZ2V0L2d1ZXN0DQpzb2Z0d2Fy
ZSBzZWxlY3RzIGFuZCBjaGFuZ2VzIHRoZSBtb2RlIGF0IHdpbGwgZHVyaW5nIHJ1bnRpbWUuDQoN
CkkgZG8gYWdyZWUgdGhhdCwgaW4gdGhlIFRSTkcgbW9kZSwgdGhlIG1vZGVsIHVzaW5nIHFlbXVf
Z3Vlc3RfZ2V0cmFuZG9tKCkgd2lsbCB3b3JrIHdpdGhvdXQgYW55IGlzc3Vlcy4NCg0KV2hlbiBz
b2Z0d2FyZSBzZWxlY3RzIHRoZSBQUk5HIG1vZGUsIHRoZSBWZXJzYWwgVFJORyBkZXZpY2UgaXMg
ZXhwZWN0ZWQgdG8gb3V0cHV0IGEgcmVwcm9kdWNpYmxlDQphbmQgZGV0ZXJtaW5pc3RpYyBzZXF1
ZW5jZSBvZiB2YWx1ZXMgZm9yIGEgZ2l2ZW4gc2VlZC4gIFRoaXMgaXMgcGFydCBvZiB0aGUgaGFy
ZHdhcmUgc3BlYy4NCg0KSSBmYWlsIHRvIHNlZSBob3cgcWVtdV9ndWVzdF9nZXRyYW5kb20oKSBj
YW4gYmUgdXNlZCB0byBtb2RlbCBzdWNoIHJlcXVpcmVtZW50IGNvcnJlY3RseS4NCg0KUmVnYXJk
cywNClRvbmcgSG8NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBldGVyIE1h
eWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz4gDQpTZW50OiBGcmlkYXksIFNlcHRlbWJl
ciA4LCAyMDIzIDY6NTAgQU0NClRvOiBIbywgVG9uZyA8dG9uZy5ob0BhbWQuY29tPg0KQ2M6IFJp
Y2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgcWVtdS1hcm1A
bm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnOyBhbGlzdGFpckBhbGlzdGFpcjIzLm1l
OyBlZGdhci5pZ2xlc2lhc0BnbWFpbC5jb20NClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBody9t
aXNjOiBJbnRyb2R1Y2UgQU1EL1hpbGl4IFZlcnNhbCBUUk5HIGRldmljZQ0KDQpPbiBGcmksIDEg
U2VwdCAyMDIzIGF0IDA1OjE2LCBIbywgVG9uZyA8dG9uZy5ob0BhbWQuY29tPiB3cm90ZToNCj4N
Cj4gSGkgUmljaGFyZCwNCj4NCj4gVGhhbmtzIGZvciB5b3VyIGlucHV0Lg0KPg0KPiBJIGhhdmUg
cXVlc3Rpb25zIHJlZ2FyZGluZyB1c2luZyBxZW11L2d1ZXN0LXJhbmRvbS5oIGZvciBRRU1VIGRl
dmljZSBtb2RlbHMuDQo+DQo+IFVzaW5nIHFlbXUvZ3Vlc3QtcmFuZG9tLmgsIGhvdyBjYW4gdGhp
cyBUUk5HIG1vZGVsIGVuc3VyZSBpdHMgDQo+IGluZGVwZW5kZW5jZSBmcm9tIG90aGVyIHVzZXMg
b2YgdGhlIHNhbWUgcWVtdV9ndWVzdF9nZXRyYW5kb20oKSBhbmQgcWVtdV9ndWVzdF9yYW5kb21f
c2VlZF8qKCk/DQo+DQo+IEJ5ICJvdGhlciB1c2VzIiwgSSBtZWFuIGNvbXBvbmVudHMgYW5kL29y
IGRldmljZXMgdXNpbmcgcWVtdS9ndWVzdC1yYW5kb20uaCBidXQgdW5yZWxhdGVkIHRvIHRoaXMg
WGlsaW54IFZlcnNhbCBUUk5HIGRldmljZS4NCj4NCj4gQnkgImluZGVwZW5kZW50IiwgSSBtZWFu
IHRoZSBYaWxpbnggVmVyc2FsIFRSTkcgZGV2aWNlIGlzOg0KPg0KPiAxLiBOb3QgaW1wYWN0ZWQg
Ynkgb3RoZXIgdXNlcyB0aGF0IG1heSBvciBtYXkgbm90IG5lZWQgdG8gc2V0IHRoZSANCj4gJy1z
ZWVkJyBvcHRpb24sIGFuZA0KPg0KPiAyLiBOb3QgaW1wYWN0aW5nIG90aGVyIHVzZXMganVzdCBi
ZWNhdXNlIGEgWGlsaW54IFZlcnNhbCBtYWNoaW5lIHVzZXIgZGVjaWRlcyB0byB1c2UgZGV0ZXJt
aW5pc3RpYyBtb2RlICpvbmx5IiBmb3IgdGhpcyBUUk5HIGRldmljZS4NCj4NCj4gQWxzbywgSSBh
bSBhdCBhIGxvc3MgaW4gaG93IHVucmVsYXRlZCBRRU1VIGRldmljZXMgY2FuIHJlbWFpbiBpbmRl
cGVuZGVudCB3aGVuOg0KPg0KPiAzLiBxZW11L2d1ZXN0LXJhbmRvbS5oIHVzZXMgJ19fdGhyZWFk
JyB2YXJpYWJsZSBmb3IgR1JhbmQgY29udGV4dCwgYnV0DQo+DQo+IDQuIFFFTVUgZGV2aWNlcyBy
dW4gbW9zdGx5IGFzIGNvLXJvdXRpbmVzIGFuZCBub3QgYXMgc2VwYXJhdGUgdGhyZWFkcy4NCg0K
WW91IHNob3VsZG4ndCBuZWVkIHRvIGNhcmUgYWJvdXQgYW55IG9mIHRoaXMuIEp1c3QgYXNzdW1l
IHlvdSBjYW4gZ2V0IGRlY2VudCBxdWFsaXR5IHJhbmRvbSBudW1iZXJzIGZyb20gcWVtdV9ndWVz
dF9nZXRyYW5kb20oKSBvciBxZW11X2d1ZXN0X2dldHJhbmRvbV9ub2ZhaWwoKS4gVGhlIC1zZWVk
IG9wdGlvbiBpcyBmb3IgdGhlIGVudGlyZSBzaW11bGF0aW9uLCBub3Qgc3BlY2lmaWMgdG8gaW5k
aXZpZHVhbCBSTkcgZGV2aWNlcy4NCg0KPiBJIHN1cHBvc2UgdGhlIFZlcnNhbCBUUk5HIGltcGxl
bWVudGF0aW9uIGNvdWxkIHVzZSBnX3JhbmRfKigpIA0KPiBkaXJlY3RseSwgaGF2aW5nIGEgR1Jh
bmQgb2JqZWN0IGluIHRoZSBkZXZpY2Ugc3RhdGUgYW5kIHNlZWRpbmcgdGhyb3VnaCBnX3JhbmRf
c2V0X3NlZWRfYXJyYXkoKS4NCg0KRG9uJ3QgZG8gc29tZXRoaW5nIG5vbi1zdGFuZGFyZC4gV3Jp
dGUgdGhpcyBSTkcgZGV2aWNlIHRoZSBzYW1lIHdheSB3ZSBkbyBhbGwgb3RoZXIgUk5HIGRldmlj
ZXMgaW4gUUVNVS4NCg0KdGhhbmtzDQotLSBQTU0NCg==

