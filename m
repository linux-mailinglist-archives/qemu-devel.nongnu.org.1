Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A9D71747D
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 05:48:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Co9-000497-1c; Tue, 30 May 2023 23:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1q4Co6-00048j-4h
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:47:30 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1q4Co0-0003VI-Da
 for qemu-devel@nongnu.org; Tue, 30 May 2023 23:47:29 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V0Q66q008349; Tue, 30 May 2023 20:47:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=MOAmxK8EuxidzcoC145ESlPYixy9YmhooaZQ/tmFRIc=;
 b=x8mbujnasdRlcF127hReU/NXILCenJ9wAgw8C3DMYDii5AwMU4ywB4lJKe4niKmuZlwr
 4PrDU03Ci7BRkpcX2E5EyM3+9ErxquvqR4vV7EtHi5YXEIi8QFmt7J8ErfbHRxvK0yXn
 PDHSxqrKOjBf9/x67b0PhJIUlnxBfsnzru3oFp3J5NzQYUL+rw65BYjnVYY3SkwtjwpY
 DnqgU+5gLkLZvcw0uwGIiveCZbJEL79u/FbDVG1W3hGnY/192S8Z2cbgV77nKeJfOpoA
 tovHEDGA/Uf71GT3gsoCmHU9XW4aAaR9rqmUdMrSL+nGxyLMUOUZCpFXlL81cuy245kw xg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3qufd6ry61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 May 2023 20:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGVrrQwMfTjKR+9eoAHascdPdDLodUuhIm/AD8kXNyBoj9DIaj4xYIaaYV3690bASJyuEayT0sFl/ScMi3bDUjx0OJBaDt1IEhxBmV2JhEUbGV5ijnBgUJLadEhqvvORvYc2ly6edCxkQN18LRYoDal6IhQxUyJyRm9maWFXLg221p22crq8T/CViSUBWqWrTR/hCNb+tT2XMp8W+eKjbSVmmgud5xChprnt8GduObx1v2PulPQZvCNI/Y4MFLscfhRtTZokaK1iUfqt7nYujMK3SJ6vz1YjEviH/p/Y95a0vivhH9NMLm/oEXMegYiVS5ihfU7yGQJLso3WCywkNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOAmxK8EuxidzcoC145ESlPYixy9YmhooaZQ/tmFRIc=;
 b=O0NfuXmNkYV1fvER25Y6tvJX/tb8h46auxXcZExC7nmQ3WaHsc9uSf3nqGfkGe1PFc/PB35GvWczI2wVqHjdtQBRSdg6kqFc5UBqv1s3IsznPgJwIuTB/vxdB1k0uvHb6egcI8HviSGT25/Y5Qa9SBC5SfUx8TVFBdz1BhMEtDhwcUA9DKHG7kAAMUiypFWvZZZDZG9FRWqBvtf3vOuFpOcqrYJZlISKJ/ou+UM9SFFFe81cQRPg9RlKLHZ7IU90Fzo45rPNn+X6SurW628OzY5I3S/2F9ksyVH3jlbDIvVexl4fRpIJ6Jmp1qHeH/7dHFi24L7499riFK63tZ/wPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOAmxK8EuxidzcoC145ESlPYixy9YmhooaZQ/tmFRIc=;
 b=twHBG+lHZulCfF9N2B1qgE+3NhTPW4O70LOIBLT3J9UuSikmeOwmpDC/CMu6rAdXtvycM/vcbJtkuAKw9T28Odugm0q/liHGnpKJa6l6QOk9novAwDR+OmtddZ16oscsamjUdKd8LDujcqMJkGjiQhbjDF7+UDMWJLiVd5KSRywMuFxp/y5U5/lQ7cD8A2WJ6mFBzg5T+WNeOjlVe66r8F0FoKfXk1SCQPdF6Dfov/oGJJ5wFp9+pgrpElx5b+e5ccywcOMfpkCmNZxhrpKpfFhynS4XalByDfYVQH7U7YZTW5TePBKxhkX7PD22uiG+EUQPQKOasI7zviTRu7GGxA==
Received: from BL0PR02MB4579.namprd02.prod.outlook.com (2603:10b6:208:4b::10)
 by MW4PR02MB7267.namprd02.prod.outlook.com (2603:10b6:303:7b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 03:47:16 +0000
Received: from BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f]) by BL0PR02MB4579.namprd02.prod.outlook.com
 ([fe80::b138:ab35:d489:67f%4]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 03:47:16 +0000
From: Jon Kohler <jon@nutanix.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tap: introduce IFF_NAPI
Thread-Topic: [PATCH] tap: introduce IFF_NAPI
Thread-Index: AQHZk25qRa2mfA5TFEenDhqyNeJCB69zuhcAgAABD4CAAAMqgA==
Date: Wed, 31 May 2023 03:47:16 +0000
Message-ID: <42F3C35E-EB0C-4AA9-8863-618E60792842@nutanix.com>
References: <20230531031645.44335-1-jon@nutanix.com>
 <CACGkMEvA6ren7Xb_ujYjeajjCEMKw=imYqf3-pNvn6wFxp0a=Q@mail.gmail.com>
 <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
In-Reply-To: <CACGkMEtCLmi5CzpWye=tNgs_xhYoysCndDTQ+Mf8WoAGQv894g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR02MB4579:EE_|MW4PR02MB7267:EE_
x-ms-office365-filtering-correlation-id: 50bbeae4-782f-4d02-765a-08db6189b9fe
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lRC91DoIRdRa7ohtV3DZeI04L9JyKRnOJH99dl16dpz+PVVi4MvSY0H8OeFrGts36b7rO9PlKj66t6v9Gw1mxSM5OaJRWYfZ6YVv+JfZIa1OuuDEx1nv38aJ4YnKKV0tFUyi7QBbP9ZgKJ1ZLcqnxVfiy25fbXR8v8iRjqt+S5+zlcyrEcjif3VjkGAblNJV7xI2VHYiuZf0+EJtHV6wG5fHmIIBAv3FSk5suYWUcSiRl3aXw5xAOHWvN/aUW6BneeYc5rMGoQvXrx//0RdkYeGu34BSMfyor4lWVm88R3bNsOeUEqKjzVP7IIdidyy3dDlzTW0LUP6VukZbUxln87u5z5m6bhPFioeqiopmLVRCZBXiGo6Bd1AlBr+FSkKog/Zte9v61z/Gj8MwmPI+fYXH4t/s2Z3HPkAhm9CTqGSgzg4+r9AI/5vqVFooF/kqFFmSmfDKlAyqL1dECA5hWjoOq09ua4dGMPKbKJQuQQHp3e0fASgtYXE5Yw1t9adBt57onJA2RDXZJiZ9JnfvBNUSMIQDL501Z3Sw23U+B2qw8IXUos1Wh6u4H8m7YfrA6IWmVwxXmUbigchwcSBsnY95aPevsEM/X6kEF5zEU5Lw+pAq559Gw3mcoJRfoDyigEoxfpmG9LV8UjDHkh+v6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR02MB4579.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199021)(86362001)(83380400001)(33656002)(71200400001)(66476007)(76116006)(316002)(5660300002)(64756008)(66446008)(4326008)(6916009)(66556008)(36756003)(91956017)(8936002)(6486002)(38100700002)(122000001)(8676002)(66946007)(41300700001)(2616005)(2906002)(53546011)(6506007)(6512007)(38070700005)(186003)(478600001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0YySTlRWXJpenBEK2ltRWEveTNQRzdEbkJ3YWJjVTdqcGxNa2hLZFBJQkow?=
 =?utf-8?B?WDU3NS9GN3NSb28weXZhTU1Xb0Z0RzcrK0hHVFVIaDBxVzFXS2h0QVVDeXNz?=
 =?utf-8?B?MG1NZjRURTV3V1pqdWtCRTFmTDVPOElqUFArU0QxRnB5cm1HUDVZZzNON3ov?=
 =?utf-8?B?WkpFYzZxVkFramRIcXFnbUhNSCtnaHpYZURYZDU2blVtbWhCODdmR1ZzbFFC?=
 =?utf-8?B?YlVjMktRWEJBMFcxbjZ1cnF0S2phaVpnV0lINWl3aURCK1lDMkN3Zkp4aTNE?=
 =?utf-8?B?L3lNN2RSTjFEdlA0c0xFcEU1STNwWUd4SCsxSVp4Mk5VclkzNUl6eEpSTXpr?=
 =?utf-8?B?Uy9BT2JzYkhJa2phalFMRDlsblRjNjVsZzdFbElieEYyU3dvTEVyZ3BGaklp?=
 =?utf-8?B?YjJoRDhaSXZnV0prNVN3cDZNOWNocWpJbFlTZDFaeHFBRzMrYm1ZWXZYU2Js?=
 =?utf-8?B?OUVRV1JhUVA0R2JPai9JUVQrb3FhMDdGNWNRTWhETHRZQ21ESFpGbkVXUlFu?=
 =?utf-8?B?SDZTVWFZSGoxdXB3OUpVN0JnZmJSODhOVWJVVEZEUW1Ic05VYVFtV3RsYkFt?=
 =?utf-8?B?a1Y0SDgyenh1cnpJSElsKzB0UkdIczhVK2dLZ082eUI2Qkw2RGZUaitRZ2hZ?=
 =?utf-8?B?UVd0eFhMK1FoclRuOVdjRFBkV29uc2wyNzlueHBOYmsvQlZEVDYzZytMUkhQ?=
 =?utf-8?B?QUlObStmaSt4ZUhvTjZUVS9IYkoyNkN4ckRQa25KMUFjMEJWV2dxelA3V0lF?=
 =?utf-8?B?U2x4OXo4ai9HWC9IQlpUMUJlOXJjanE2UlBDb0RhUEZsV1NpWmhMUGlyRjY0?=
 =?utf-8?B?bEZTZzZURkNkWEZMOHV4cEtuMlRrVDgrRWYzUCtIaGxEbHkvcHZJcmx2TDlv?=
 =?utf-8?B?M1dKVlhEVUZONDFYL3BEM3ZlVDltSFFqZHZIK0tlL0FqQnhvSjFPZjBoVTNF?=
 =?utf-8?B?MXovT0xrNmtKenhvdThkMDBRdktlcDB4V294UHJXM29ISndFNE9mb1JoaWUr?=
 =?utf-8?B?dmxEQXl3NjFBWksrYTczYm5odzNqK0sxcFRQdXdRVjlJQmxacndEU05xU0xr?=
 =?utf-8?B?T2QvRTU1ZEFYeTJHcVlydUJOYTRya09Pb2tLNHhqSmx4ZzBnMkZlT0JyQ0hm?=
 =?utf-8?B?RWJtb3NxMWlRVnNCRkZYMXFLUncxWEV5eUNoN3JzTWlOajM3aytycVNKMGZj?=
 =?utf-8?B?U0U1Rk9CSGd0MlNabHl3UG11bXhsTU0vdndXbG0vMm40cjQ5c1Z3OHF0QWpD?=
 =?utf-8?B?cFoxZU43dGgxSnNHZmtyTHZxaHlLNDkrRFVaNzhTR2cxM0cvN3VMRFgwTEtL?=
 =?utf-8?B?NlNkZkdpTHJzRElFUXFqMFZ4Mmp4UGdncjgrcldndlVBc0pkTDdmN1lQd0M4?=
 =?utf-8?B?SndEOHJoaUQ0MlRkcWtpcm0rZ1hpOXUrZDJrU210MUtZUEl4OHUxVmJOdTJF?=
 =?utf-8?B?TmZXT0N2bE1oV0kyVmh1MWFsRkVaUkhsQ2FpSzdaNGN0ZlJ1MS8waldnUnZ6?=
 =?utf-8?B?a293b0hSN2tjVm1NL25seG9sYm5OeUQ3OCttVnovVDJzRlcrVlhpV0lQRmpx?=
 =?utf-8?B?Z3ZKOUtnSnhYVm5zeFFRTGRWczZuL0NUWkIyZWQwNmFJV1J4Y08vMG1uVVkw?=
 =?utf-8?B?RDJqd2w4ZTIxRE1UYUZOM2JiQkN4aVg5Sm9lT0hTMVpkSlpIQzQ4bkk3aFZ5?=
 =?utf-8?B?MUdUN05wc2VoSXhoZFhFeW8wV1pRdkJaVWRRTzZCdFRObUQvOUhIQU5qZ3Nx?=
 =?utf-8?B?NmpWYXAyMXVMU0pqWUtIOUVPV3h6dFJFaTc0Nk85N3JGMG8xa1JYY2pyMWlN?=
 =?utf-8?B?cU52T0hpSWoxZmVMZ0FLNzFaL2ZYRXJXOWg5U2dyZlR6YVVIcktTU05MQWtS?=
 =?utf-8?B?NFBmWmdCQVFCQ280NjhnVXdERWZpOGdjUHBMazVpTi9EUFh3dlBMY0lpRXlG?=
 =?utf-8?B?OVF0ejdIVEJFMTRlSnlzYzd4Qi9ySzdjd3FiV0VKUFJ2ak9DQU5lWkpoaUc1?=
 =?utf-8?B?RmluZW15NVJZNm16STRkbVIvKzZwalEvd1BwcjkyR3EzRU91Y0JTNXVMUmtT?=
 =?utf-8?B?T0o1bWVIS294TmVpTlNKNTdFei92RXV0b3JSWUdTUHpCbzFXeEJPODBjY0xp?=
 =?utf-8?B?ZHVhbU5Xazk5WGRKeFdGS3R6MWRaV1hERFNmTjBKaDNuTlhOUjUvaXRLek0w?=
 =?utf-8?B?MldZK1pxd1JncDlLTy91NGNZVExrelN3SU94UVNxTlJLUW9yWER5a05iU2lU?=
 =?utf-8?B?amxQczRsWUZqckVxZFB1U2xoeDV3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <71019A06797AEA4C940B733996AFE374@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4579.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50bbeae4-782f-4d02-765a-08db6189b9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 03:47:16.1425 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9cEGHtG4KmkpsQtL1FFZVh32cNjvnoOBtBNQ4hX10l8CDdnRGBaxzizjvr7TxANwBXUQQ2WBtVIFaMaEzTCzaA9U7BiTi342eSRt5sNMKsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7267
X-Proofpoint-ORIG-GUID: yMdsRQBf6mSlNoQJfeAGf3dRo5-nwDW7
X-Proofpoint-GUID: yMdsRQBf6mSlNoQJfeAGf3dRo5-nwDW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_18,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

DQoNCj4gT24gTWF5IDMwLCAyMDIzLCBhdCAxMTozNSBQTSwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE1heSAzMSwgMjAyMyBhdCAxMTozMuKA
r0FNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4gDQo+PiBPbiBX
ZWQsIE1heSAzMSwgMjAyMyBhdCAxMToxN+KAr0FNIEpvbiBLb2hsZXIgPGpvbkBudXRhbml4LmNv
bT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSWYga2VybmVsIHN1cHBvcnRzIElGRl9OQVBJLCBsZXRzIHVz
ZSBpdCwgd2hpY2ggaXMgZXNwZWNpYWxseSB1c2VmdWwNCj4+PiBvbiBrZXJuZWxzIGNvbnRhaW5p
bmcgZmIzZjkwMzc2OWU4ICgidHVuOiBzdXBwb3J0IE5BUEkgZm9yIHBhY2tldHMNCj4+PiByZWNl
aXZlZCBmcm9tIGJhdGNoZWQgWERQIGJ1ZmZzIiksIGFzIElGRl9OQVBJIGFsbG93cyB0aGUNCj4+
PiB2aG9zdF90eF9iYXRjaCBwYXRoIHRvIHVzZSBOQVBJIG9uIFhEUCBidWZmcy4NCj4+PiANCj4+
PiBCZW5jaG1hcmsgdy8gaXBlcmYgLWMgKHJlbW90ZSBzcnYpIC1QICh0aHJlYWQgY291bnQpIC1s
IChzdHJlYW0gc2l6ZSkNCj4+PiBmcm9tIGEgZ3Vlc3QgcnVubmluZyBrZXJuZWwgNS4xMC4xMDUg
dG8gcmVtb3RlIGJhcmUgbWV0YWwgcnVubmluZw0KPj4+IHBhdGNoZWQgY29kZSBvbiBrZXJuZWwg
NS4xMC4xMzkuIEd1ZXN0cyB3ZXJlIGNvbmZpZ3VyZWQgMXggdmlydGlvLW5ldA0KPj4+IGRldmlj
ZSB3aXRoIDR4IHF1ZXVlcywgcmVzdWx0aW5nIGluIDR4IHZob3N0LXdvcmtlciB0aHJlYWRzLiBI
b3N0cyBhcmUNCj4+PiBpZGVudGljYWwgd2l0aCBJbnRlbCBJQ1ggNDMxNCBAIDIuNCBHSHogd2l0
aCBNZWxsYW5veCBDWDUgMjVHYkUgTklDIC0+DQo+Pj4gQXJpc3RhIDI1R2JFIHN3aXRjaC4gdmhv
c3Qtd29ya2VyIHRocmVhZHMgbGFyZ2VseSBtYXhlZCBvdXQgb24gQ1BVIG9uDQo+Pj4gIkJlZm9y
ZSIgYW5kIGFyb3VuZCB+NTAtNjAlIHV0aWxpemF0aW9uICJBZnRlciIuDQo+Pj4gDQo+Pj4gU2lu
Z2xlIFN0cmVhbTogaXBlcmYgLVAgMQ0KPj4+IGlwZXJmIC1sIHNpemUgfCBCZWZvcmUgICAgICAg
ICAgfCBBZnRlciAgICAgICAgICB8IEluY3JlYXNlDQo+Pj4gNjRCICAgICAgICAgICB8IDU5MyBN
Yml0cy9zZWMgICB8IDcxMiBNYml0cy9zZWMgIHwgfjIwJQ0KPj4+IDEyOEIgICAgICAgICAgfCAx
LjAwIEdiaXRzL3NlYyAgfCAxLjE4IEdiaXRzL3NlYyB8IH4xOCUNCj4+PiA0S0IgICAgICAgICAg
IHwgMTcuNiBHYml0cy9zZWMgIHwgMjIuNyBHYml0cy9zZWMgfCB+MjklDQo+Pj4gDQo+Pj4gTXVs
dGlwbGUgU3RyZWFtOiBpcGVyZiAtUCAxMg0KPj4+IGlwZXJmIC1sIHNpemUgfCBCZWZvcmUgICAg
ICAgICAgfCBBZnRlciAgICAgICAgICB8IEluY3JlYXNlDQo+Pj4gNjRCICAgICAgICAgICB8IDYu
MzUgR2JpdHMvc2VjICB8IDcuNzggR2JpdHMvc2VjIHwgfjIzJQ0KPj4+IDEyOEIgICAgICAgICAg
fCAxMC44IEdiaXRzL3NlYyAgfCAxNC4yIEdiaXRzL3NlYyB8IH4zMSUNCj4+PiA0S0IgICAgICAg
ICAgIHwgMjMuNiBHYml0cy9zZWMgIHwgMjMuNiBHYml0cy9zZWMgfCAobGluZSBzcGVlZCkNCj4+
PiANCj4+PiBTaWduZWQtb2ZmLWJ5OiBKb24gS29obGVyIDxqb25AbnV0YW5peC5jb20+DQo+PiAN
Cj4+IEdyZWF0LCBidXQgSSB3b3VsZCBzdWdnZXN0IGhhdmluZyBhbiBvcHRpb24uDQo+PiANCj4+
IFNvIHdlIGNhbjoNCj4+IA0KPj4gMSkgZWFzZSB0aGUgZGVidWcgYW5kIGNvbXBhcmUNCj4+IDIp
IGVuYWJsZSB0aGlzIGJ5IGRlZmF1bHQgb25seSBmb3IgOC4xLCBkaXNhYmxlIGl0IGZvciBwcmUg
OC4xDQoNCkZhaXIgZW5vdWdoLCBvbmUgZmF2b3IgdG8gYXNrIHRob3VnaCAtIA0KV291bGQgeW91
IGJlIGFibGUgdG8gcG9pbnQgbWUgdG8gYW4gZXhpc3Rpbmcgb3B0aW9uIGxpa2Ugd2hhdCB5b3Xi
gJlyZQ0KcHJvcG9zaW5nIHNvIEkgY291bGQgbWFrZSBzdXJlIEnigJltIG9uIHRoZSBzYW1lIHBh
Z2U/DQoNCj4gDQo+IE1vcmUgdGhvdWdodCwgaWYgdGhlIHBlcmZvcm1hbmNlIGJvb3N0IG9ubHkg
YWZ0ZXIgZmIzZjkwMzc2OWU4LCB3ZQ0KPiBwcm9iYWJseSBuZWVkIHRvIGRpc2FibGUgaXQgYnkg
ZGVmYXVsdCBhbmQgbGV0IHRoZSBtZ210IGxheWVyIHRvDQo+IGVuYWJsZSBpdC4NCj4gDQoNCkkg
Zm9jdXNlZCBteSB0ZXN0aW5nIHdpdGggdGhhdCBjb21taXQsIGJ1dCBJIGNvdWxkIHRha2UgaXQg
b3V0IGFuZA0Kd2Ugc3RpbGwgc2hvdWxkIGdldCBiZW5lZml0LiBXb3VsZCB5b3UgbGlrZSBtZSB0
byBwcm9maWxlIHRoYXQgdG8gdmFsaWRhdGU/DQoNCkFza2luZyBhcyBOQVBJIHN1cHBvcnQgaW4g
dHVuLmMgaGFzIGJlZW4gdGhlcmUgZm9yIGEgd2hpbGUsIGd1ZXNzaW5nDQphdCBmaXJzdCBnbGFu
Y2UgdGhhdCB0aGVyZSB3b3VsZCBiZSBub24temVybyBnYWlucywgd2l0aCBsaXR0bGUgZG93bnNp
ZGVzLg0KTG9va2luZyBhdCBnaXQgYmxhbWUsIHNlZW1zIGFib3V0IH41LTYgeWVhcnMgb2Ygc3Vw
cG9ydC4NCg0KQWxzbyBmb3IgcG9zdGVyaXR5LCB0aGF0IGNvbW1pdCBoYXMgYmVlbiBpbiBzaW5j
ZSA1LjE4LCBzbyBhIGxpdHRsZSBvdmVyIDEgeWVhci4NCg0KPiBUaGFua3MNCj4gDQo+PiANCj4+
IFRoYW5rcw0KPj4gDQo+PiBUaGFua3MNCj4+IA0KPj4+IC0tLQ0KPj4+IG5ldC90YXAtbGludXgu
YyB8IDQgKysrKw0KPj4+IG5ldC90YXAtbGludXguaCB8IDEgKw0KPj4+IDIgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspDQo+Pj4gDQo+Pj4gZGlmZiAtLWdpdCBhL25ldC90YXAtbGludXgu
YyBiL25ldC90YXAtbGludXguYw0KPj4+IGluZGV4IGY1NGYzMDhkMzU5Li5mZDk0ZGYxNjZlMCAx
MDA2NDQNCj4+PiAtLS0gYS9uZXQvdGFwLWxpbnV4LmMNCj4+PiArKysgYi9uZXQvdGFwLWxpbnV4
LmMNCj4+PiBAQCAtNjIsNiArNjIsMTAgQEAgaW50IHRhcF9vcGVuKGNoYXIgKmlmbmFtZSwgaW50
IGlmbmFtZV9zaXplLCBpbnQgKnZuZXRfaGRyLA0KPj4+ICAgICAgICAgaWZyLmlmcl9mbGFncyB8
PSBJRkZfT05FX1FVRVVFOw0KPj4+ICAgICB9DQo+Pj4gDQo+Pj4gKyAgICBpZiAoZmVhdHVyZXMg
JiBJRkZfTkFQSSkgew0KPj4+ICsgICAgICAgIGlmci5pZnJfZmxhZ3MgfD0gSUZGX05BUEk7DQo+
Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICAgICBpZiAoKnZuZXRfaGRyKSB7DQo+Pj4gICAgICAgICBp
ZiAoZmVhdHVyZXMgJiBJRkZfVk5FVF9IRFIpIHsNCj4+PiAgICAgICAgICAgICAqdm5ldF9oZHIg
PSAxOw0KPj4+IGRpZmYgLS1naXQgYS9uZXQvdGFwLWxpbnV4LmggYi9uZXQvdGFwLWxpbnV4LmgN
Cj4+PiBpbmRleCBiYmJiNjJjMmE3NS4uZjRkOGU1NTI3MGIgMTAwNjQ0DQo+Pj4gLS0tIGEvbmV0
L3RhcC1saW51eC5oDQo+Pj4gKysrIGIvbmV0L3RhcC1saW51eC5oDQo+Pj4gQEAgLTM3LDYgKzM3
LDcgQEANCj4+PiANCj4+PiAvKiBUVU5TRVRJRkYgaWZyIGZsYWdzICovDQo+Pj4gI2RlZmluZSBJ
RkZfVEFQICAgICAgICAgIDB4MDAwMg0KPj4+ICsjZGVmaW5lIElGRl9OQVBJICAgICAgICAgMHgw
MDEwDQo+Pj4gI2RlZmluZSBJRkZfTk9fUEkgICAgICAgIDB4MTAwMA0KPj4+ICNkZWZpbmUgSUZG
X09ORV9RVUVVRSAgICAweDIwMDANCj4+PiAjZGVmaW5lIElGRl9WTkVUX0hEUiAgICAgMHg0MDAw
DQo+Pj4gLS0NCj4+PiAyLjMwLjEgKEFwcGxlIEdpdC0xMzApDQoNCg==

