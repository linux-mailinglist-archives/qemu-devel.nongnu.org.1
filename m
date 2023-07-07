Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E463474AC4D
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 09:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgEr-00056y-3i; Fri, 07 Jul 2023 03:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qHgEn-00056C-HU
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 03:50:45 -0400
Received: from mail-vi1eur04on0609.outbound.protection.outlook.com
 ([2a01:111:f400:fe0e::609]
 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qHgEl-0004MG-HI
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 03:50:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeRIVY/mVBSDfuzkEd0ByQE9mwYQ/IdmfnZ27bN0PHN7Bug03P5wI9vujyBzepAK31tSAl27GzWCdW139jmRMSbMPI+0nwJWhr6/Xxg+iLyUjXLNglsB/XfxnC4AzCyP+0WfH19bbTAumD0pdxa1RMduAAZAVRkiTX7c2kYEqPq8R59ChmuMYr42GuTQlVQ9gomriLnGrUF0XjNyUgzfNprbFSxzkBI/rxVXXRgec9ksyViHDHfhcr9Igt8zhdRIvuSzIvsV3qqbPVw2n1AzFjqeFGlOwxDh0uMh2Z1WYoYbAxyH6tumHFw00Uiv0KBxFMwxu+0rr4hSFQoKeYa1Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ACyCco/UH8aKsojQnc4jGY9sMb5fyAH+twenS3uc0Io=;
 b=bRNRs/31FlTcgHokw/cQLv4tlM2yY69LERl/B+VvLZqoHiL0Jgn+yTL7NOcl+MeT8z7uXblngzCDXIc0Y45wwtsQ5oQMtuj51ad1toT8y+W88gqDmDkoL/P7VTA6p3gFwpgP/A4TU+m+G6li9s6Lp1AWN7MwM9iCVKKRrMBfx8Nh/sAURbKMI/XQyi+WZ47NBjpc8ooBmSVrlncvW4FpG8vR6XG57eC+rrbWMXw5EuuzCHmSNHycQJdm/Mw7oG7VLYOHFsAuBfOqHpK5h/jGqyaQTOB2JTDsUItjp0xAJXu/0UVAyyRWKGJTRsRm/dFLwmYrn3uPdRoleVNBkWB5GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ACyCco/UH8aKsojQnc4jGY9sMb5fyAH+twenS3uc0Io=;
 b=FWBNpN47SVjW9Qx/Gcf6z04/R29Mei59hpL1MxBni7blp1chrlWQ76JZwzXaEB10d/ZrGdZHHgBVFddb3IdagN2FfDuWJNVAG39MwBHb61JhI+7HJB8UA80nV5LC6fQZbj3IQJC2dh0aHDLdYEg5uA4R4kKoOkzS+32zbTY6Yo4=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by DBBPR07MB7436.eurprd07.prod.outlook.com (2603:10a6:10:1e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 07:50:39 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 07:50:39 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: Re: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Thread-Topic: [PULL 07/11] tests/tcg/aarch64: Add testcases for IC IVAU and
 dual-mapped code
Thread-Index: AQHZrpXy6z7PV/lvLU251CqHWLCVua+qnCOAgABL3ACAAcUCgIAABVUAgAAChYCAAT1pAA==
Date: Fri, 7 Jul 2023 07:50:39 +0000
Message-ID: <f4a209832dc6a1e39fdbadad14b2ca2ddd356174.camel@ericsson.com>
References: <20230704163634.3188465-1-peter.maydell@linaro.org>
 <20230704163634.3188465-8-peter.maydell@linaro.org>
 <2e39933a-b9d9-5792-8c4e-dd558d4aad5d@linaro.org>
 <dd6a96b4-1b72-67e2-58ce-8011203128ae@linaro.org>
 <CAFEAcA8o8nG7_DWnjYHOL7R2x1DjJdQ-=Moe_jkSibXscZ2mQg@mail.gmail.com>
 <9cc96e295ba6ee2e8cad5cf82da6b926713fa9fd.camel@ericsson.com>
 <CAFEAcA8KOsqS-T7rdrvnhkac5DuAhgkgZCsNgMGkWbk2kdsfuw@mail.gmail.com>
In-Reply-To: <CAFEAcA8KOsqS-T7rdrvnhkac5DuAhgkgZCsNgMGkWbk2kdsfuw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|DBBPR07MB7436:EE_
x-ms-office365-filtering-correlation-id: 782bd05c-10a8-4eb9-30d3-08db7ebedb58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCawRvwBvXIUUAvYO5J9+lppvZppJtoCNJtSjirzaWEy0q+j717x0LsgOwNJ4Fc4gbiIo3igGeSxJYv5K4eUAS3MvMGrmIGnVF9V8i3uNLb2JFX3U9reekr7dJoR7ZaN/KAwPbF9AnD6Yfh5jIx6yeNZmMVLG3IgvFojeEfOtK05NtQ3Zlbn0hLm3STbQgjjogJ4BpixCZL25cK7pKUZ8qorOAcmLMATzjicLrs/FcxxtQYLPRbquX0eLC9R76r2Xk5MXP/rOUjjkMoA6ZzHBFLKxkLE38CqZHKlG0wnTBHsZZCs9v30DJmxmHZXcD8ycf+zL3EAJ7867PDEja/1hU0D/qAA88w4ICsLe+mp/oVDtiLMwXLPq1VyqXsgt/FBLQ1U9311bfs6DdrE8pkJrbaWUGrz1/Cj+VVfeKiIcrrEPOVcW8T4lPKE4OtfTe3pYmHyzIRwLik++36v3WvhpbAZYp3W34g0fs6SUOwzKzmjhG3ZVZM8n+RtOc2iHpu5S5kavtq66qvpLmM11EEtDTcJFL0vlRPUEBGosro80Qpvp0zhQd1o+kZZsOwZMdropHdoT1OYLNfLB535Zs/AVvRqgmEKkeBC7Pa80vIu+FS+S7ddhxDh/S6ok8rlaVVZaIODWd6Ph8touk5KRTtkZg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(451199021)(6916009)(54906003)(82960400001)(91956017)(6486002)(122000001)(66476007)(66946007)(71200400001)(478600001)(41300700001)(8936002)(8676002)(4326008)(38100700002)(66556008)(64756008)(2616005)(66446008)(316002)(76116006)(66574015)(186003)(83380400001)(6512007)(966005)(26005)(6506007)(86362001)(2906002)(5660300002)(38070700005)(85202003)(36756003)(85182001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmdacVJZRURsUkNvZFRjZzRmeWxQMFNnUFZLcnVLNENSbWhVQUlQR0d0Mkd6?=
 =?utf-8?B?N3J1SU5QVW4xSEtkaUtpVzcrcTRDYXNLaVZ5WFM1Y25uRlVQY1RSbGowaTBi?=
 =?utf-8?B?Y2NEQ2VYU3QvbTFMLzZDMy9uOXByc3dybkdzSXJDbm5oWjdMN0dwSEJxWVZN?=
 =?utf-8?B?cmk4dWRraTlKeVRWMWlvT0pveHI0NTRhT0NTb3dIR3IwdHZsTlpQcUc0Zmxj?=
 =?utf-8?B?UXU5Q3FJR0NhZDd2b3FJWndkcUk0UEpEd3g3L0wzZDFpTkMycHluSkE1cFRQ?=
 =?utf-8?B?YmQyN1g1dFBhTDdpaW00SmRwYzhqZGU1NzhFeWVGcEQrd09UL01pdWJzL0cr?=
 =?utf-8?B?MlIyRENsUHZ4NVdhc2dYRGlkRDlER2RoTkI2c2pvWDhQWlBPTG9wb2duREJD?=
 =?utf-8?B?V1A0VXVpbnF0UE9hMWRtWGIvRlRoNW8vSnNLalI4LzVlYTBpSnpyT1lORk1C?=
 =?utf-8?B?T2NmanJ1Ty96Rm5TSy9jSnFHMXpPbitwYjZjKzRMSFZqVG1VU2QxZmRyS2RU?=
 =?utf-8?B?MTJiS25DeEsvWGVZdGRrL2RWeVltSkNycFh2b09wbXd6UUxIcWduWUpHY01z?=
 =?utf-8?B?NjFCcTJWVkwzdnA2TTNnbDBJdXJYZTBvZnprSURnZ1RSZVhyMlY4Mk81azF4?=
 =?utf-8?B?U0ZRcHdTbVF4cHpvdnpzTVo0SzRXTUpBUjA1dDVlZGwzd2F5eU1TSXBSN3BG?=
 =?utf-8?B?ZC9jRExoNTI5N0tpMStveWtXT3VTeXI1aHBya3l3K0hzVSthaTQyajFyN0lE?=
 =?utf-8?B?cDlvZkZ1TTVlNVpZRnlMWmhOM0lnSFhPMFo2SGdjZGxqUDNpTDMwZnVKdVpP?=
 =?utf-8?B?QlpvNHpLTzlsd1JxTUltNk1BQmJFalhyZWgvblJYb0tvcjNBTWoyOWwvdjc4?=
 =?utf-8?B?bkVUSHRqWXhEaUdxdXd4UVZxUTJEa29od2xzK1NJSmFpYUJMUTdiU0hyQ05p?=
 =?utf-8?B?bm5DT2hPbm1ZMVMvUTVGbjJralIrSmhVSlgxMWxtdlZMdEtrRlVHU2xhWGxC?=
 =?utf-8?B?Z0djSnBkVWc2ODI1S1VBVFVDUmNTUUFtWmZVemxaamtBQkxZMWxidjFQUm8w?=
 =?utf-8?B?aVRPYWlBQmVqWWI1TVdoZzBSdUMrR3NycHpCcUpyZXI4NjVBZ2l4NVZYNkkw?=
 =?utf-8?B?MUJwak8zUW5XU3k4cVhZNTZrL3pFbmE5QWRMOEcvczRsVzBSSjRjd0RTai9G?=
 =?utf-8?B?QVNwdXdCS015QW1hd0kvM1luUzZZV0Y3ZDJGQ0tRRWdBZ0tZeVFSUzUrN0JT?=
 =?utf-8?B?dTE5UVdzMDBHK2tFOFBDSWNvdEo4TVBFRHA5dVBZTElPV3BNbm5VSUJubE5a?=
 =?utf-8?B?QVJTdEFZNE1HYTRpOHJOa3NLcldoZ29INGVZUkxTSHc1L2kxQUtZaDVmcmJ6?=
 =?utf-8?B?U1prbVR4c0NiV2xkQ01ER05aVkJ2b2pSalRlajZEcVMxb3g4TXZLWXU1WmI3?=
 =?utf-8?B?LzZUZ2g2WEszbkpwMnZNR2FVaWNBUFYvb3pHd3ovMk1kSjdPS1RXcWdpdkky?=
 =?utf-8?B?K0JGRkwzdTNmbzYrRXYrdy84MFFQd09sN0tzRWt0Z3dpa3JQVDlnZ25RU2tK?=
 =?utf-8?B?L1JnNy8wemlnVXlGUDZoTytVenZOSFdIZGZyVjZ6NFBhR2R4WUtvdXllMVZx?=
 =?utf-8?B?aWVQbzBnbVJ2Umd1THN3QldtOU5yaG5jQVFGT1YrRG1rTDg4WmljYkRrVkdR?=
 =?utf-8?B?eXNxTk5pdmcxNTlDUm1yMWZqOE5xaEhKcSt1SGxzK0cwcEZ0eWVpeldjbzR0?=
 =?utf-8?B?L2liZUFVenF0M0pScC9lTHhjUHI0M0NWeklLaXJKLzBsNDd4bmlCUytlMkRL?=
 =?utf-8?B?dFk5ZXhTMTJvdEJLRW93Q2NPN01WQSsxTUxQOWpwV0Q1MXpwNnQ2NGhKMFk3?=
 =?utf-8?B?dnk5NVhteHVaMnNGTW1UTVc3Z3NyM1EvNkx4Wm1jdkFNTDBqaTRFL285eWw5?=
 =?utf-8?B?eWp6TXVIR2w0bVBSaVB0aHBOVnlUQmxlYzJwR3RQSm1IN2NudVd4SkNMQWRP?=
 =?utf-8?B?VFVEeFFOOU1IUjd5bWEyRDV2R01JS1YyL1VVUTZhWFIreitzZGYxOHIwbHRm?=
 =?utf-8?B?Zm1xblgwdHo2YnU4aVB2UkZzS3dSVzFFSTlCZEhQblBHcDRjUXBjN0lwaTU5?=
 =?utf-8?B?U0JpWVZwZzNjNGMwcHFNWVl1SlRxVWRzdHdrMmxrTVZyVDZESUU2WmhJUTRV?=
 =?utf-8?B?cGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1AC00009BC927448B868532918551495@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782bd05c-10a8-4eb9-30d3-08db7ebedb58
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 07:50:39.1335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZnZUTxcvL+vZY1AF/5AqklF/vmGK6QtC0P5U8DCSpbMGCh05ZW8n0+yYFRqPe0xTEKCgI/EHjiC9gUaMkN4GP42EOXI6bsNsXTsn3G5sO3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7436
Received-SPF: pass client-ip=2a01:111:f400:fe0e::609;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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

QWxyaWdodCwgdGhhbmtzLiBXaGVyZSBzaG91bGQgSSBnbyBmcm9tIGhlcmU/IFNob3VsZCBJIHNl
bmQgaW4gYW5vdGhlcg0KcGF0Y2ggdGhhdCB0cmllcyB0byBkZWJ1ZyB0aGlzPw0KDQovSm9obg0K
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIu
bWF5ZGVsbEBsaW5hcm8ub3JnPg0KVG86IEpvaG4gSMO2Z2JlcmcgPGpvaG4uaG9nYmVyZ0Blcmlj
c3Nvbi5jb20+DQpDYzogcGhpbG1kQGxpbmFyby5vcmcgPHBoaWxtZEBsaW5hcm8ub3JnPiwgcmlj
aGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0KPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+
LCBxZW11LWRldmVsQG5vbmdudS5vcmcNCjxxZW11LWRldmVsQG5vbmdudS5vcmc+DQpTdWJqZWN0
OiBSZTogW1BVTEwgMDcvMTFdIHRlc3RzL3RjZy9hYXJjaDY0OiBBZGQgdGVzdGNhc2VzIGZvciBJ
QyBJVkFVDQphbmQgZHVhbC1tYXBwZWQgY29kZQ0KRGF0ZTogVGh1LCAwNiBKdWwgMjAyMyAxMzo1
NDozNSArMDEwMA0KDQpPbiBUaHUsIDYgSnVsIDIwMjMgYXQgMTM6NDUsIEpvaG4gSMO2Z2Jlcmcg
PGpvaG4uaG9nYmVyZ0Blcmljc3Nvbi5jb20+DQp3cm90ZToNCj4gDQo+ID4gVGhhdCBpcyBlbm91
Z2ggdG8gZ2V0IGl0IHRvIGJ1aWxkLCBidXQgdGhlbiBpbiB0aGUgQ0kgdGhlIHRlc3QNCj4gPiBj
b25zaXN0ZW50bHkgZmFpbHM6DQo+ID4gDQo+ID4gaHR0cHM6Ly9naXRsYWIuY29tL3BtMjE1L3Fl
bXUvLS9qb2JzLzQ2MDY0NDc4NzUNCj4gPiANCj4gPiBURVNUIGljaXZhdSBvbiBhYXJjaDY0DQo+
ID4gbWFrZVsxXTogKioqIFtNYWtlZmlsZToxNzg6IHJ1bi1pY2l2YXVdIEVycm9yIDENCj4gPiAN
Cj4gPiBJJ20gZ29pbmcgdG8gZHJvcCB0aGlzIHBhdGNoIGZyb20gdGhlIHB1bGxyZXEgdW50aWwg
d2UNCj4gPiBjYW4gZmlndXJlIG91dCB3aGF0J3MgZ29pbmcgb24uLi4NCj4gDQo+IE9vcHMsIC1w
dGhyZWFkIHdhc24ndCByZXF1aXJlZCBvbiBteSBtYWNoaW5lLg0KPiANCj4gSSdtIHVuYWJsZSB0
byByZXByb2R1Y2UgdGhlIGZhaWx1cmUgbG9jYWxseS4gSXMgaXQgcG9zc2libGUgdG8gc3RyYWNl
DQo+IGl0DQo+IGFuZCBzZWUgd2hldGhlciBpdCB3YXMgY2F1c2VkIGJ5IGZhaWxpbmcgdG8gc2V0
IHVwIGR1YWwtbWFwcGVkIGNvZGU/DQoNCk9uIHRoZSBDSSBtYWNoaW5lcyBhbGwgeW91IGdldCBp
cyB3aGF0IHRoZSB0ZXN0IGNhc2UgKGFuZA0Kd2hhdGV2ZXIgdGhlIG1ha2VmaWxlIGNob29zZXMg
dG8gd3JhcCBpdCBpbikgd3JpdGVzDQp0byBzdGRvdXQvc3RkZXJyLg0KDQp0aGFua3MNCi0tIFBN
TQ0KDQo=

