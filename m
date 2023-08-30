Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA578D50A
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:13:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIC0-0007wk-He; Wed, 30 Aug 2023 06:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1qbIBy-0007wL-Gz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:12:54 -0400
Received: from mail-db5eur02on20730.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::730]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sriram.yagnaraman@est.tech>)
 id 1qbIBw-00083N-5G
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:12:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bO3UIoPADw/T4RvevXqFMIcxM8JQri1sa54Ujd6wFUQI9gD1GP8/HLLzqSKqGQC2YPb9EEHh8f8LJdNXO1kMyQiX9vsBFO2WrG7DQ41kEdwUqa5wBwLybQ38+VrtZojW/xF5JuAxJ2n1030sDbWHooovINJlIHnBIxGHwB96JR5dxLBWiDIV6eJBeTfnsQGw+UPQADlzSCMc+ZXbUvPDygN6jubdPCFJWJ+W7oDlO/bAEeYQQOjypQH5faiVUmmheKgX7n2u4Y+gtzUHxnaKZIPc83M91ptk1XbVHcy8RpLgxDTKLs3N+qbt50lqeDp8RMLXnML1P+5np0RE2n6KlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4S0qjuIJG1Pi0bLidMUBNwYV5dpvFUb+LbiV4QC7WMc=;
 b=SpeONtirUF7riqqSYpuDTLwY+4Tg8zzuh/4uF+iZ2Qg9skBbMVzi6pnOKHVBdNbSJpS54aBnCe6vWdLL39H9QJ+XmfeMVIIn13EXG7HqIl0WuJ6uZQFiwf4aIHhy0srUeuLIZBjhaXdpYV+8vEeJ3xNqWfqE3/fh85L2vpp3sD/yBjYc4p94j+G+uNK6njV6c8l4+1I6LB+82vjtR5pbwfEZ3+JcA2Y4OF9Df2cfgx0FT/TGyAto0Gv/eOqmx4MaYS9iwtM6lX7n5+G6nYti54V3cBrhAup//ESrLSuVfkdfGBlNoKvewS2f+P9ziL/5DPfm/MzHD8ck47GCUR8YtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=estab.onmicrosoft.com; 
 s=selector2-estab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4S0qjuIJG1Pi0bLidMUBNwYV5dpvFUb+LbiV4QC7WMc=;
 b=HYl2P1hRP467fPqMGwwG/rS6g71qswL0n9BHjX+wf46lpwfcPUffkZh5JZaO9hJ5YdkJUfEdKv+rcLTwcacmegPQD8z48iSoA2CQ3KJ0o919hoiu2L9UfKY+8wNbSTlnApkQnkDeHZMWe2WLtSu9/alFe3HIZtxBYHuD2JEHwhY=
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e7::15)
 by PAXP189MB1648.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:13f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 10:12:15 +0000
Received: from DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670]) by DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
 ([fe80::759b:94eb:c2e8:c670%6]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 10:12:15 +0000
From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang
 <jasowang@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
Subject: RE: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
Thread-Topic: [PATCH 2/2] igb: Add Function Level Reset to PF and VF
Thread-Index: AQHZ2lgBnwFIGYB4vEmQx7LqAHY6SrACoCkQ
Date: Wed, 30 Aug 2023 10:12:15 +0000
Message-ID: <DBBP189MB1433BECF94518F8A10D0E44E95E6A@DBBP189MB1433.EURP189.PROD.OUTLOOK.COM>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-3-clg@kaod.org>
In-Reply-To: <20230829090529.184438-3-clg@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBP189MB1433:EE_|PAXP189MB1648:EE_
x-ms-office365-filtering-correlation-id: 70dcc29d-34cf-4b9b-ec11-08dba94195a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xVWu3mClTNQ2bLU1eVlD+M7+wOzIlKEKGbnwXZkmQiuo8ty0kcfcuoAey1qVp4iEMhNi+R4JvyzLsXBj+VAKhIRQ4+kI44dmwnqeF4/AbwLTRl7GaUzZXffAokEsK8Kj8JRtJHu7ZBAtPB3Utbss96RegoXHfGQfiNwIHxBSbfTjgoMsO/bkJSs92PbxXqGKGSuV7JwkFE5kwMLlZYbwFhsOA8e+/Uwf6HmvDwavLQmdJm7iuOGVT+VVrYZYuomB/TrO+5Q8hA76Lx1QnA88EC9w3GeTInPuno0WeZ2XbuFJRXh0/B7jxutXFglntoz5ryF4gYJQRqU1822h1tuQS08cEKZhkYSoc+6ngIajSmQw4fEuROXVuufyxxv+YG+vvIQMeNM+wAdd0TmgkyjtfProH/LCtxQI7McS96PdwrtSmM7vqmMii7nT+zg3HAZCPEba7U+uSp4qAKYEsLLKDU27lidehKybr5W3Xt+TDeLHHvzlTYG/rS96/gAirEfWn8iisqQVKIPV2zBXYb9PE+x37Aw0r1zPdxzCyccQe3ITFq+qJX9SI3gaHxfz3ZQ8R9UscmGJbri5hcWVzeR+GAcoec1WFd8KPUwmvVDL92qGyU9+ENG1hPdtSDqTfiM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBP189MB1433.EURP189.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(39830400003)(376002)(451199024)(1800799009)(186009)(33656002)(55016003)(83380400001)(52536014)(86362001)(44832011)(41300700001)(5660300002)(53546011)(4326008)(8676002)(8936002)(6506007)(7696005)(26005)(71200400001)(9686003)(478600001)(76116006)(110136005)(4744005)(2906002)(38100700002)(38070700005)(122000001)(66556008)(66446008)(54906003)(66476007)(66946007)(64756008)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TE55bXFCQURiMElFL1VzMHB2NlYvQ1diakpRYkNMNHh5ekE2cThOVkpzU3lU?=
 =?utf-8?B?eTRYdHB2bTRVS2p1N3kwUkZiTnNZUVdIWUQ2M3RrNmdyeUxvNXgyT2I1K2dI?=
 =?utf-8?B?dVBxTXhFS0RuSHVSYmpkMlA5TzhtUllEY0s1eExsczg4TjBTZGMxRTJld2Np?=
 =?utf-8?B?ZSthbVc4K0ZxTU9XU0g1akZYRWpzNTAwOEtRVHpaTlRpd2l3RytGakVvejNa?=
 =?utf-8?B?dEE2WlRxL1ZObm9UWWZsVXFMeUVWZGdQV2Z1aGVUSzc3VEMrSVkzeUw2N0lV?=
 =?utf-8?B?UUpVUGZTV1dYMnM1bHpkeFgzU0kwM3VmcUUxUk1YODBFQTRSaUZ2Z09EUUpo?=
 =?utf-8?B?SFYyL2NUMEVSZHRPWmoxUWNCYkRYdWMxVTdSVmRNWW5yT0dNR2RzNXphdDRz?=
 =?utf-8?B?cEJzNHM3ZXVrekt0Q2RmNC8rSENEb20xMzZGU3dZdGJyNmlPa1ZwNmxUQ0Fp?=
 =?utf-8?B?YzF1UmFjUlBSM25FVXlvM0RPc29scXVRTlVpb2VkM0lkSWEwZEdaK0RBS3dI?=
 =?utf-8?B?dCt6MzhDS3lVM3laSFRpQi84Yko2QjV6Tm5rMFdkM25BemRESnRaS1pXeGt1?=
 =?utf-8?B?cXNBQUkzUmR6emFadTk0RVNmV3MwcDRGUnJ3S3BVOFFWaXQ5UnRBZG41ai94?=
 =?utf-8?B?MkhKREhMb0pkcXo0RHJjbEJ3dkZIZUJoM09zMVpDZ0lIMHRaeGFaNXpXTVMz?=
 =?utf-8?B?b20rSnJNelFwR0NHVnNDcDl3L295WjRMWG8wSUVKcGVHa2xGTnBXMUF0a0I2?=
 =?utf-8?B?ejNLMzQrMlJLR3NZdkVrQ3pDNDBOMkhoZWNHb1FtcFVDa2JyNkZNTDVTTDBh?=
 =?utf-8?B?VE5nQTF4QnF5eVp0aFhUUFVOVktlNVpralJ1NE1qZjZjb2x6ZlZWcHlvd0E1?=
 =?utf-8?B?TUFTMjg5RGhlRFk1b3ZRdm05a1VlUzdLS0J0UnJIQ0FWNDM0WHlncTY1MzhR?=
 =?utf-8?B?T1RPTTJxcE0rL2JQcVQ4MmQxQS84NVJtL0puUDNYNGZnNi82K3F5WDUwNnZt?=
 =?utf-8?B?d25TZVVHenZvRkNJcUFNclVsMW51YUFiaHE2RkVJOFZsbnFJbkVIN2dabFll?=
 =?utf-8?B?dzhueUR1WGhHNXJHdjhXZGsyME1WYVBYc1JmdE00a1pBaFV0U2ludmVCakYr?=
 =?utf-8?B?emRBSkhtQUZLa1JMREZjSWNoellSaU8rbHFkZHM4bnFmek1Cd004ODVwWXN2?=
 =?utf-8?B?SkEvVE85MEh3d3RvQk10NlBJenBpRWdvdWlEZ1dsYk9uc09palBIZCt4aHBS?=
 =?utf-8?B?SHZGdnlrYVRpTmhlU2cveWpPTFhRbWppWXZVTEZoRXhiWG1FMkhYVVcxdUgw?=
 =?utf-8?B?KzdHU2tYSVNsVW1UTXVJZ2EydG5IVWdDaDRpU0s0VE5YUGU1RXZPS0ZVdEtG?=
 =?utf-8?B?c09EeG4yeEhDVFVHek9vVXRBYmIyN3gyTE9QQmxydFl0T3dEQUowR0Q5ZlV3?=
 =?utf-8?B?UEpKR2Y0Um1VTFpZWTBhNVRXb3FBeXV0K2VXTmVoYjRZR2xOMUN1MkZFTzJV?=
 =?utf-8?B?d3BRbTJhSXJPY2ZCRjhCTktXWStDTjdTRU55aUNsV0NYd3VUWDlyMjVFY1V0?=
 =?utf-8?B?ZjhOeXRvVTh5VUhzWEF5bjRlV3YzVUNVZmRjcTJNN0Jnc2VxdllkU1FabHJ5?=
 =?utf-8?B?SUZVNExFdGhSaG1sYkVHYkJMUnl5L2NoUXpvWUtBS2lHRUJQUi9GaXJhY3JL?=
 =?utf-8?B?WEloVmhGUU11QUIwajRTMGRlR0ZzRnhTaHF5Rkg5U0JMc2tLaFVBanZ2UktX?=
 =?utf-8?B?bCtiNDI0UnU1WTdmMWpvVnJCTzV4Yzhnb0s3Uzdzd0dQN2d6Sk1qTllNS3Vl?=
 =?utf-8?B?ZDJBNzFHK1NCNEwxZkRJVGtGMlRVd2FuY2c4N1dXT0pJemNKbmhQL0RLNm5H?=
 =?utf-8?B?bndMNmZKR3Y4MUZsSXdqNjZVcDd2SklHL1VCblErVkhQVkc1UGdhMEt4bjl6?=
 =?utf-8?B?ckNPWUh2TU5KRUZDZE9LQ2tPZ29NT0l3ak1PWks0cks2TE8xTWdva2JoK3hl?=
 =?utf-8?B?a1A5NThvK3BPRThVLzFRQjZsMUZkcWRuaTNENnhEQXdEOCtjeElnTXlaQlZr?=
 =?utf-8?B?WmhxeDFJeEJJNVRqUzVZVndZOWFHemo4ZzN6eDBiMnpnUjQwYVdnZkprcHVC?=
 =?utf-8?Q?Gs3LWJaMFUVRapBgcnjpYFDvS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBP189MB1433.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 70dcc29d-34cf-4b9b-ec11-08dba94195a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 10:12:15.1835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QIW7sJkDYDlW3BjClaNKD4yX1QIdnfVwkEWEdz5guRhB9mJyp85mqgWAaFy1QqwHKgCBPOP9zkE6O/VcAo3oOivBdLm4K1xkE2Tdg4dn0zo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1648
Received-SPF: pass client-ip=2a01:111:f400:fe12::730;
 envelope-from=sriram.yagnaraman@est.tech;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_PASS=-0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0
ZXIgPGNsZ0BrYW9kLm9yZz4NCj4gU2VudDogVHVlc2RheSwgMjkgQXVndXN0IDIwMjMgMTE6MDUN
Cj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBDYzogQWtpaGlrbyBPZGFraSA8YWtpaGlr
by5vZGFraUBkYXluaXguY29tPjsgU3JpcmFtIFlhZ25hcmFtYW4NCj4gPHNyaXJhbS55YWduYXJh
bWFuQGVzdC50ZWNoPjsgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT47IEPDqWRyaWMN
Cj4gTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4gU3ViamVjdDogW1BBVENIIDIvMl0gaWdi
OiBBZGQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQgdG8gUEYgYW5kIFZGDQo+IA0KPiBGcm9tOiBDw6lk
cmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+IA0KPiBUaGUgSW50ZWwgODI1NzZFQiBH
YkUgQ29udHJvbGxlciBzYXkgdGhhdCB0aGUgUGh5c2ljYWwgYW5kIFZpcnR1YWwgRnVuY3Rpb25z
DQo+IHN1cHBvcnQgRnVuY3Rpb24gTGV2ZWwgUmVzZXQuIEFkZCB0aGUgY2FwYWJpbGl0eSB0byBl
YWNoIGRldmljZSBtb2RlbC4NCj4gDQo+IENjOiAgU3JpcmFtIFlhZ25hcmFtYW4gPHNyaXJhbS55
YWduYXJhbWFuQGVzdC50ZWNoPg0KPiBGaXhlczogM2E5NzdkZWViZTZiICgiSW50cmRvY3VlIGln
YiBkZXZpY2UgZW11bGF0aW9uIikNCj4gUmV2aWV3ZWQtYnk6IEFraWhpa28gT2Rha2kgPGFraWhp
a28ub2Rha2lAZGF5bml4LmNvbT4NCj4gVGVzdGVkLWJ5OiBBa2loaWtvIE9kYWtpIDxha2loaWtv
Lm9kYWtpQGRheW5peC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICBody9uZXQvaWdiLmMgICB8IDMgKysrDQo+ICBody9u
ZXQvaWdidmYuYyB8IDMgKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0K
PiANCg0KUmV2aWV3ZWQtYnk6IFNyaXJhbSBZYWduYXJhbWFuIDxzcmlyYW0ueWFnbmFyYW1hbkBl
c3QudGVjaD4NCg==

