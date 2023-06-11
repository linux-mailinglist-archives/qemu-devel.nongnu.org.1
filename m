Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A564272B1BD
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 13:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8JZs-0005lA-LB; Sun, 11 Jun 2023 07:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1q8JZp-0005kv-Rv
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 07:49:46 -0400
Received: from mail-vi1eur04on2075.outbound.protection.outlook.com
 ([40.107.8.75] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1q8JZn-0006xZ-Ke
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 07:49:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZBQqgzjsbWW9jHAG7CUMuQfN4b9IWWkMH2k32hPUvCM5CDZTLZOgVXPbVz7OcxcMUCaz/LN4o0yPI4Z62Boo12+SH7LVJ8Aeueu3Q7EWYSzVWzMNVulSyPm4il+XJ9TEm/j5CaMB2rKrbb7UVV7mTICaKKrwFpFoi6MoKULVcxESvRTML+0S+kvhGQnAikz1W+Yfiz7MRRgUAkwinQL3EiderLGbOTxn8arAFYH9NyNCkKmqQqjG58EOZsFBkw7tGyIUQ9aW9p2BWAwdIjcCvlqD2BgNkS/RenzQGpTjDAGow9O39OB7qSfOjxMDWEaJFwTn6YLSknZpmpWjjGx5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUO6zvaAmG0st79KcojVvBY0Woouunoi9B9FK7yEIGo=;
 b=lnejamYF6xNOtSpLL5PNNxLdOEys3y7471TtbyvnVlnt0iGfEdTo/6RY1irIh9TLB7aMPjCqY82vgLy4OxY8IsTH2EYIEFMHPYPX6vWGA4vkyCycMhK8GL7tF0M3uT6v62myLH+LnAtAW7GU1xyH+wck5MJnrs+Pz6I1t7qEYcH0nHnC/kvaZY2k/tOUAQl/RmYN13G/UDw13i7RNiNWxweMPG0UAt/xXXzLtQb5CSoa9Vz153skG5PjPGgbVpX4t2FOUMPdVzjloGnH78t2Ql9YnfVr6sUJoGXOUNc0MYq0ElN/rUjEpKVoTa0EtVBEN3PuYIKE9/n+1OYjtyH5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUO6zvaAmG0st79KcojVvBY0Woouunoi9B9FK7yEIGo=;
 b=caAWzckja+gytK5+AuzMhw2EtOOx5pn6l1nhM95wboZHOhIpWH7GUos28OQAlfUq1EoxpsNTGRqBAwVSDYwzfAqPEfil5i9TKd8U47fQmPBuYPkCWW2UVLlTXbKVsPXkRGan5g3/0ZZUBNg8Ch2db3MGtOlR/00qi5fE6xeS3iQ=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by DU0PR07MB8396.eurprd07.prod.outlook.com (2603:10a6:10:353::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Sun, 11 Jun
 2023 11:44:36 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::568:2863:92fb:8e85]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::568:2863:92fb:8e85%7]) with mapi id 15.20.6455.030; Sun, 11 Jun 2023
 11:44:36 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: [PATCH 0/2] target/arm: Improve user-mode compatibility with JITs
Thread-Topic: [PATCH 0/2] target/arm: Improve user-mode compatibility with JITs
Thread-Index: AQHZnFoYHww65hpZGUWDxjw7BDeovQ==
Date: Sun, 11 Jun 2023 11:44:36 +0000
Message-ID: <833e7382b3fb90a2bbb007932cb5dbb8cfff5a33.camel@ericsson.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|DU0PR07MB8396:EE_
x-ms-office365-filtering-correlation-id: a1b547eb-332d-4d04-028b-08db6a713b82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjkQIQ9vTpHa4sBpIPU9l7KJ+eBeO+GoBKwdObgHTYLwxET2pKkatgQ/c4j6XQBSN/ESkjeKadyA2aTxQM8NwOFUpRjoEqUgx1Z45mw2M/NrUnwZ+/5CovPyD162fJegYUUvIXo33KWcTVfA5NP+yoKh6R5iZ9aLB10L7ORc+u97BJWwDASDWEbrOKwE9JVkjZ88IZog+vah5hYXQ2j3Ef2WkWdTfhJ9/YuluI8p2XK1ys/X4rsjrnjCBbwByiW+qL5Qn81fmtRGHRwZNoNNypSEMbgmL1/O9daWB9cgriOqJpx5pyJ2G3wk4SL2VMKJmkefMQivDl/Hnd3UZGu4VtzUhmz4tNgAiNktdW3eO5AQjLYdgSIHf1l0Ubf19Rxre0bzgsLW5tV1HxjyCXjY2CUaqkO7FgDH7t9vhc+4/7b5oo7K8PeMJxh6l4yoAjmMIYDwY2JSTgD1KHvEfUd3kuCUAqJd0LPYBJ5tRXDPN/6Yy05+PxV+iTDaSvprOkZGRRq7JRyuz5MUCqlnMTleMiZ0Gu7RQhcl+CZzHjjeHmN6xUKUwhuts1PxHaoPFre8IyU73Mgg0X6h2iKB6NjIiZzdJb5b3bQKc8x7mg2oXXQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(39860400002)(396003)(136003)(346002)(451199021)(41300700001)(85182001)(71200400001)(966005)(8936002)(36756003)(8676002)(5660300002)(6916009)(64756008)(66476007)(91956017)(76116006)(66556008)(316002)(4326008)(66946007)(66446008)(478600001)(2906002)(38100700002)(6486002)(83380400001)(85202003)(6506007)(6512007)(26005)(186003)(38070700005)(2616005)(122000001)(82960400001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0ZkcVVnVHBYSy9jdUl3STQyYm9vdHhrT25QM0ZoWGlYYUl5OHNSL3gwSjFW?=
 =?utf-8?B?bFpyaEpkNVJxOVVpM0VhUTJEVkpzbjJqK3NDT09qTUlhbklzN0tRUXNDeVdY?=
 =?utf-8?B?V3JKbFhqbDk2c1NPQytmcTAvMHJaVTZmazY1L3BqOHMwZHRpdEQrYUxSb2lE?=
 =?utf-8?B?enBQMjUzZ09JQjVEYWVHUS9EYWM5bHN6STd1NW93Ulo1ZE1sbU4ybStVY1A3?=
 =?utf-8?B?N1cvSk8raGFYWkovdk1ibEdPUlJ6M1Q1bERXVUozRFIvaDFrb2VFdlhUc2gy?=
 =?utf-8?B?ckVrTi9aUy9jak5hYlZjckdFRkdKVnpUbFlkN1BYU04yazdGa3o0akdJVnRn?=
 =?utf-8?B?ZE9NSEVWVjdVWnlQTXdhOHdJQVJVUG40NWliR0hMYmZ3YzRQaXJnU0F3MjJ0?=
 =?utf-8?B?Zit1MXNqbndOU0tLbnVoVkNDVXMyTnc1QlhTY3oyQXp0TkMzdG1uQS9UYVR5?=
 =?utf-8?B?WTl2ZDhhTldNdHY0Q3oyM09yL3QycGxtSkhtM3NxWGZPcmtmVzhhM0VCcnM3?=
 =?utf-8?B?STQ3OTFMYXFQTGc1MDk2a1VIc0R0VlhjVlUrT2hsTktJMHpSeDdZbk1XekJZ?=
 =?utf-8?B?Z3ladHhGUTNjT2k4Q0xCSjNYV2tGb1FvV3I2bzdrM3NxT2pwRTNmZU85QXR3?=
 =?utf-8?B?MG1HNDhRSGVMTXVocEhGSWprTnd0enh0OGMvMWVYNmY5WnBoNS9zcGIyNHRS?=
 =?utf-8?B?cm1aMTFBamRpVG9QQnVYSm5xcTJYZk5ndVpnM0YyUGQzYzFObFVzcnI4Tkxh?=
 =?utf-8?B?elpuVGMvZk5FaWNITHpxWkl5R1Q1ekNzZVpLY2d4S2tHZUtzS3VESmp0UmNE?=
 =?utf-8?B?czhBQTRkRGU3T2U2N3lwaGpTQ1VwK1hlMkhhNGJLU0xGK0VIM1phbm5TNm91?=
 =?utf-8?B?Rzh6alp1RTQ3UzFKMmhwemdLdGJsR0o1SFhyQ2JZRFBic1dKMnRvOUVvSC9z?=
 =?utf-8?B?Q2UwMUZEZ09TSWZ0OVhKd1Z2QW5EUEZKL0lWVUhJUlc1bHdKZW13TmhTQnUv?=
 =?utf-8?B?SjhSSi9La2YxVkN0eFhueHFUVjl2WVVKbjQza0YvNDNZRFNGNFJraHkzU09p?=
 =?utf-8?B?REFDb09QdWdjTnY3ckVuT0s1SVEySGdORXdwQmVHWnhKYzBSdHF1U3NUOXhZ?=
 =?utf-8?B?MGR1ZDhQYkhLR0V1cFBrc2daYXg3bWhjSURmZkdLZHFrbkJMdk15UW1FS2xQ?=
 =?utf-8?B?Q3MzdjVFWG14VU5yeDVvdDNpWXdTbGY4SVJpNW9sNERwTlJrV2VzaVJLWmkv?=
 =?utf-8?B?T1M4U0p0RU1JN2dZcGFGam5FOUoxTzRFcTRsWWVLa29KNkxZWXdnSVp5UGdB?=
 =?utf-8?B?TUdBVU4vNTBhQmlsUW11cGpHYU5oTWxhUTY1RUhZRHAvWkxyZ1ZQS1dsZFIx?=
 =?utf-8?B?SXRjQ1REaUdVV3ZzRnU1c0VkR09mS0VyRnAybEVsS0N6bkFjYmJybkdaUzBo?=
 =?utf-8?B?L1F5S3JaNXZqU3gybWtyK0xrc29NcjFSdDJQMGVKbDU2dy9TdDllc3M5K0pV?=
 =?utf-8?B?V1hEazdSWTd3ajYwRmFGYjFIT09SdWk4QkJkc1MvK3BxTCtXenhGaGZFdDRT?=
 =?utf-8?B?N1hvcGIzb29OVTJQMGFJNGJCVTQzSGhYM3RadXpFZjVqcy9CWmtoQUZpZzBa?=
 =?utf-8?B?TGhSVEIrR0JoRS9wQTF6bGU5S28vMW5aTXJ0K1psOU9SMjU5ajM0RDFiR1VE?=
 =?utf-8?B?K0l5RHFVdjBaWmlkVTYvUWJXOWNsYkVTZFNqdU9xNXhQSmwzSlBwQ2FkUlpF?=
 =?utf-8?B?eEFPNmZITG02ZFl2SlhrLzBDa1Y3ckdKeVR2YkxBNWRqVXI0dC9QeXcrNS9Z?=
 =?utf-8?B?aFJFcyswZ2tWb282M0tNeGNkQko2ZThPZUVtYkdqcGxkbVUwd3RET1NOOXlM?=
 =?utf-8?B?bG1Ba3RnSmQ3QWZRTmsyelh1cTJQYnNPVGN3R1pNSlk1S0oybzhmTi9Ma01q?=
 =?utf-8?B?VkhQYWQxdDBQbUV5MERTREQ1bmNMZWQ1NmFMWXJHaWJacE9ZeGt3MEZHQUFP?=
 =?utf-8?B?MHFPbmNXRlRsMTBNNlNZZlA2VW9Vek1VaFc3cnpKeTZFcEVBbkpHWThMMTl0?=
 =?utf-8?B?OGtaSXRFeWRVZWxqQWRUaWNqVStxRUdGcDdnTk84VTRmNUhYN0hjZUd5dlhD?=
 =?utf-8?B?MDFEenVXbjdCeDFEM3BKVFRiVkJUVVJWY29RdXloYyt1UFZZMHh3OVZDbWdq?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D71248574BED954ABA2FE4DFE5333607@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b547eb-332d-4d04-028b-08db6a713b82
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2023 11:44:36.5148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W6XONc+vN/4PeMXZmQzD/K4GrbjWm1r7ZZ8SPsM24nqwoUPMNJz1kogorGYVWCi4NLXXuW/PnyWbHC4rlhJ2MuCm47yJSgRZ2T+Sf2No+5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8396
Received-SPF: pass client-ip=40.107.8.75;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

V2hlbiBydW5uaW5nIGluIHVzZXItbW9kZSBRRU1VIGN1cnJlbnRseSBmYWlscyB0byBlbXVsYXRl
IEpJVHMgdGhhdA0KdXNlIGR1YWwtbWFwcGVkIGNvZGUgdG8gZ2V0IGFyb3VuZCBXXlggcmVzdHJp
Y3Rpb25zLCB3aGVyZSBvbmUgbWFwcGluZw0KaXMgd3JpdGFibGUgYW5kIG9uZSBpcyBleGVjdXRh
YmxlLiBBcyBpdCBoYXMgbm8gd2F5IG9mIGtub3dpbmcgdGhhdCBhDQp3cml0ZSB0byB0aGUgd3Jp
dGFibGUgcmVnaW9uIGlzIHJlZmxlY3RlZCBpbiB0aGUgZXhlY3V0YWJsZSBvbmUsIGl0DQpmYWls
cyB0byBpbnZhbGlkYXRlIHByZXZpb3VzbHkgdHJhbnNsYXRlZCBjb2RlIHdoaWNoIGxlYWRzIHRv
IGEgY3Jhc2gNCmF0IGJlc3QuDQoNCihOb3RlIHRoYXQgc3lzdGVtIG1vZGUgaXMgdW5hZmZlY3Rl
ZCBhcyB0aGUgc29mdG1tdSBpcyBmdWxseSBhd2FyZSBvZg0Kd2hhdCBpcyBnb2luZyBvbi4pDQoN
ClRoaXMgcGF0Y2ggc2VyaWVzIGNhdGNoZXMgY2hhbmdlcyB0byBkdWFsLW1hcHBlZCBjb2RlIGJ5
wqBob25vcmluZyB0aGUNCmNhY2hlIG1hbmFnZW1lbnQgaW5zdHJ1Y3Rpb25zIHJlcXVpcmVkIHRv
IG1ha2UgdGhpbmdzIHdvcmsgb24gYWN0dWFsDQpoYXJkd2FyZS4NCg0KU2VlIGh0dHBzOi8vZ2l0
bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8xMDM0IGZvciBtb3JlIGRldGFpbHMN
Cg0KSm9obiBIw7ZnYmVyZyAoMik6DQogIHRhcmdldC9hcm06IEhhbmRsZSBJQyBJVkFVIHRvIGlt
cHJvdmUgY29tcGF0aWJpbGl0eSB3aXRoIEpJVHMNCiAgdGVzdHMvdGNnL2FhcmNoNjQ6IEFkZCB0
ZXN0Y2FzZXMgZm9yIElDIElWQVUgYW5kIGR1YWwtbWFwcGVkIGNvZGUNCg0KIHRhcmdldC9hcm0v
aGVscGVyLmMgICAgICAgICAgICAgICB8ICA0NyArKysrKystDQogdGVzdHMvdGNnL2FhcmNoNjQv
TWFrZWZpbGUudGFyZ2V0IHwgICAzICstDQogdGVzdHMvdGNnL2FhcmNoNjQvaWNpdmF1LmMgICAg
ICAgIHwgMjA0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIDMgZmlsZXMgY2hhbmdl
ZCwgMjUwIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RzL3RjZy9hYXJjaDY0L2ljaXZhdS5jDQoNCi0tIA0KMi4zNC4xDQoNCg0K

