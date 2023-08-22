Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34FC783715
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 02:40:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYFPy-0006Ob-3M; Mon, 21 Aug 2023 20:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qYFPs-0006MP-TU
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:38:41 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.norwitz@nutanix.com>)
 id 1qYFPp-0001OJ-ST
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 20:38:40 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37LEj68U010176; Mon, 21 Aug 2023 17:38:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:references:in-reply-to
 :content-type:content-id:content-transfer-encoding:mime-version;
 s=proofpoint20171006; bh=5KjEK6K9zPQI1brHC7/vgadjcQkdXxXXL43mDw
 BZBa0=; b=r+YFHCq3OU8iYjdWn02yIiWnm29exn9mJvaDy0k1W0p0cOg3JQJC4z
 GW5sCeE1spASB9Dm+BdRf28opNpXl3q/cNQmcDQulWPz2Iz6mb2ErHm8Cevcehmk
 uOxJlIKjmZ46+xxeTBWnyOTBGFWSBJCVd6de0qDvrkjel7oiSp+p0zXFLbSKQGz5
 /joCpk1fhn6iPi/iRK6vSahoL6IWftjFLQWrkQVArAcH2vQ4gruOiEZrneQ5cqC5
 CbZ0YiL+gPHY2OCMyBySIoiEzrlfNRNmlu/Ocx6KarMikglpR2S8GDVu8IOHISYL
 42rT8c+FmHT6k4kJU+sz8WJeALrYYB/g==
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3skuk52egh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 21 Aug 2023 17:38:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbCC83UFjzBY4ungwK/r2r7w0mpM2qEpFk4j/E0FLR+CZE4jsoQhuggeFPLYJgpaNEdmasQHNTdUVEo7IavEBQnPsU+QacPNYus+dmNvHqjaHwlbrFxeoa1PybMq3++yJGVtHXMcl6rjRe5zvgUWTS/VExrD6J8ljRXZj7gjXHIteYRSauodhty+3F9Fa5beAl7RyynVJyqDz8QOJCUm+mb3zQqUWcpFNB41D1mOsG+mLt9irQ09P2o2KlQP+AWzdR5kn6KdxY/ydpD7f7bP9H7n7PUey0eIIluoB4EkvdqPrIvLQPQJxyaS2aznXwBEbAVCdCKTYevAL2JHS+Ym9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KjEK6K9zPQI1brHC7/vgadjcQkdXxXXL43mDwBZBa0=;
 b=Q69yz86dqnR/kkfWR+7Cm9J5z4CbJ+WhEW+ZyA1Tmu25LULdtEHaLE5JZ7sEEHv9CKDu3v86ANokXvzvDrEfTID7fK+xSia5oISEZlu+U4hVn9eRoEY6xLsgTdL46z8AFEECx419UunnwG5OREesl8NNfw6pwwQLAXw8zOy3bhSJWm/biXgcyxpOYWtungcPxp1dDn1UXad14zrxmW33mT1WM35RwGHy0jrQ6YoddnHemMBKfzK8xBaX+NryHAs68BTjMDRMDMycuE5mg3NxN6tM2GtCzRyU6cRFXk/r4k2yonNqAwlN3xrIWW5ESrhU3Q22LLy6BTUXnl7xuUrDow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KjEK6K9zPQI1brHC7/vgadjcQkdXxXXL43mDwBZBa0=;
 b=JydWAd852p7YSru+tj4helwN5H0FXNR998gTDsHcect1T+hooLrQOG28eZUH92REFKZhnSU7FAsXq18IPRqV32kauE0CPnYdy6zLfTv4/Oe3shVhxr49PmDH/a/iKw3Fe7mRY/2bjn7zoHmevGDwTY5i9ngK/eA5+ogFFyv6fBOkQFJNclNV6y51xRNaAP6Qee6NUEHD3Cm8gwW1yk40/++lDf0ra3xyBzZkyaQk+0HA/ZRNSU0Qa+BFBGxbjHXDDQfGBDgUZ+tfLlRJtZwwF1LJgyXbamXI9zpGtmtCd33SRJkHf73RKfLhuF3ywgBOY2oGCagG6pA4XWwkAKlPBA==
Received: from BL3PR02MB7938.namprd02.prod.outlook.com (2603:10b6:208:355::20)
 by DS0PR02MB9498.namprd02.prod.outlook.com (2603:10b6:8:df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 00:38:24 +0000
Received: from BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8]) by BL3PR02MB7938.namprd02.prod.outlook.com
 ([fe80::1da1:b8:e69e:79c8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 00:38:24 +0000
From: Raphael Norwitz <raphael.norwitz@nutanix.com>
To: Li Feng <fengli@smartx.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/2] vhost-user: fix lost reconnect
Thread-Topic: [PATCH 1/2] vhost-user: fix lost reconnect
Thread-Index: AQHZxpTSe3WncXIlnk6ipNyEGIOYZ6/pwLIAgARdiwCAB3aAgA==
Date: Tue, 22 Aug 2023 00:38:24 +0000
Message-ID: <2D662C4C-B636-453A-B2D0-F4EDA4B43041@nutanix.com>
References: <20230804052954.2918915-1-fengli@smartx.com>
 <20230804052954.2918915-2-fengli@smartx.com>
 <894CEF7E-9523-444F-8459-330BE4236B7A@nutanix.com>
 <F0FCF1EC-8E24-4515-A800-BD01D9D3D526@smartx.com>
In-Reply-To: <F0FCF1EC-8E24-4515-A800-BD01D9D3D526@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR02MB7938:EE_|DS0PR02MB9498:EE_
x-ms-office365-filtering-correlation-id: 95b8d1c8-3b18-4383-c7e5-08dba2a8180b
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LCT0/dn4+XHuOB7rfCWkJLfyOrj737xK13D2nTsaD7lHmqKBmgLPHYfLK4fOuaYBSLpv8h82Gs1CUS61PdfUxt7p/lVPqoTxT9vjV9SaLz2gJHdQLZ4k7WlFiEVc9FqfJjOL38eRJH/ylAAgaUl6HKtgOPkk+3UZ+inG7eXo1jMtKh/Fci2arPqCr0OBC1QE+F6hcFIDt15Tx4VeKqYvIs0yIeEy2q8J6iD1fmZJysasuvz1GTxl8HLFuCEIY3kAL+h/4n3LPlUxvznvDryqKiZmIZJt7ikr5G0eiGDBMj+6xyEN266/iJSSkRkZ/b6wNmg9xr6wAc96hANiIOHSbLhSk+XnizRBhevpTN1/5AcnJuTnwpDfH5W8wSG//+iEr8fYQ1d72qol0MRUKJEGbQC8EgdaTMg1lXyJADy/l57hYPc4vwWHxdQ0qChWChaOC4NFBcdq7iKGzy6APMdB4CIp7G1CWbnj2u8UHCiYvJQamlxHTOtdD2RoWfLC8gke0X8lu1K0nCBCY/WKjwX+DDXb+g2RJtyj5K+1vGDfYutCBQXWa4y4aq5ayxKIlf3M1PYcRp2dGEYnSU3QnGTB5j1DIwAThcGTaDR2ZkOP7+Mb7Qjh5xBc8TUah3J4MHWpO1hobBADsE7NgtbjTPHyKw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR02MB7938.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(186009)(1800799009)(451199024)(5660300002)(8676002)(8936002)(44832011)(122000001)(4326008)(66476007)(66446008)(64756008)(41300700001)(316002)(66556008)(6916009)(66946007)(38100700002)(83380400001)(86362001)(2906002)(76116006)(38070700005)(6512007)(71200400001)(36756003)(6506007)(26005)(53546011)(6486002)(2616005)(54906003)(33656002)(91956017)(478600001)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGpHZkVYN1ZhbkJ1NXJlSDY3NGJ2TEpSV1NLTGdudU9LWEk3NVJLMEN1enZ0?=
 =?utf-8?B?TCs1eWR6Zm55b1c0dFlVc0xRcUdnTEh4SUd3ZlhIbUsydEZIc2UyYnRyRUhq?=
 =?utf-8?B?bnVlTFpuVlJtTzVqVUJlZmt2aFF5ekRiVy8xOUdTbXFtdDFSWlVIbmhLRW43?=
 =?utf-8?B?TThlUXNYYnYyQ2IrU1lCQXVoYVFSbXNqWlZxVGY5L1FJQzdkTWF4dWczVHg5?=
 =?utf-8?B?TFpCT21Rb3FiYmd5TVFVZGNEQytJellaV1JnSjBWSC85NmlndGNmVURrSm9D?=
 =?utf-8?B?RlJGOUJnUEN1NUY5S3BoeCtLdTE3aHBGb2xsUXlDN0ovUE91NG11U1M1RVRM?=
 =?utf-8?B?U0MvamhpbG9RU0hudkxrZEpOQkpkcVJaTjU2YnZ6d1lTN0Mya01WRTBiUk9i?=
 =?utf-8?B?dE4rT3R6NGtMSXVjVkhwQzhGNm1UdEZZWHZQR0dMUGhiL0RNUHRHTVRRRHJv?=
 =?utf-8?B?N2JoNEE0WkJWdi9DajQrOGNUMHQvZDRsVnlKWVlQYnpidjdhTzlXTkd6ZFF3?=
 =?utf-8?B?YnhPVjBBa1d5NlkvQ3NKR0pvOUs3S29id29pRFZ3aGZKV1R0a3d0Q0xHOHgw?=
 =?utf-8?B?OUk5c3daQWs5a2lnNFJ4WFNzOXF4YzFoRHJPdHZUWE5Sc0RxbzZIK0d0bGZI?=
 =?utf-8?B?Q3JQU2tvdCtOODQ4ZFkzNU91TW9hN0pOSitTM1piandieDRUcnZPL1EwQVFy?=
 =?utf-8?B?d1ZYLzJxWjFhM1FhZEhTelR3RUFxc1pHWHJieSsvVGIzeFNxa3pFUjU5R0lT?=
 =?utf-8?B?cWt6Rm52ajV1aVJtQkVneUxTdk1tOHdtQkRxMER4YzkxM2FDcTNrck5sd2py?=
 =?utf-8?B?NFhRQUx6WHQ0SUs3dE1YYko2azR1c2ZXTUVyREoybi9hcDlTejVvNGx1aVI3?=
 =?utf-8?B?Um5ZYUxyKzY4LzN6UUFlMVkyK21JbUV3ZytUWTJ3NExGWEw4bVgrM2lqSnl4?=
 =?utf-8?B?NnB0TXZ1czIxN3ZrdW5LODFyRlpETDhtRTRtYWIvb01pSU5ndWZtZEc1WDBi?=
 =?utf-8?B?RHU1V3BHcm0vY3pLRlNJQWlldnVlaGI4VHVTVkxpdkRBYzNobzFBWVZzQlN4?=
 =?utf-8?B?Tyt2SXp2QVNxMStLSS9WZ2F0dzhtRVh0eDNnQUxKd1VMREhqOUg3MnR3S2FK?=
 =?utf-8?B?YldSQnpqc3puaFRORDQ1T2tERVU3K015bk1IMlFsZ2hRVVNyQVpGdTVQdzBr?=
 =?utf-8?B?OEx2SExHbmlERE9ncUQzUE9BZ2owQm53cnZlMmR4RTIycGhqLzVFdE5tUWho?=
 =?utf-8?B?VUZtaDc2b2twTUVnaWNTSFRWUUNXU3pybXM0b1FLb0ZYM3c5bGs2dUk5OXI4?=
 =?utf-8?B?eXl0UDJnVFJjamo3a281cW1tZnFYYnl2c24xRDgzdldPRGtIZGVYSjM3cE0v?=
 =?utf-8?B?bkMxOE1WczRVNE5KczJZVlNXRXJ0YThWY2I2bXU0ZFk2RWl0R0JiSmhBa2hE?=
 =?utf-8?B?TlM3UnhVbXdPYVNMQlJlczl5dTBOUythYnNjcng3YTZDbEZIZUdLWnFvL2VW?=
 =?utf-8?B?c3MremVkSytHellZTjJzUGlVM01oR2E4RTRTY1ROOHpjQ3M1c1pTQkRlbytw?=
 =?utf-8?B?Z204OEpvK2h1QUFVOEtJVWRRNUh3ajcycHRmZnhhSXhIYm1rU3dXcTJaS0JP?=
 =?utf-8?B?M0c3bEd1ZW01dEJCRmhpdlZ2NzFyTm9xRExZZVltMFpaTjZvTXpYOWpXMkRC?=
 =?utf-8?B?S211RzVJSUtxUEtmby9EZFhmdU1oYVJGVE5pelZJTitROTZaRWdKb0NTQm0z?=
 =?utf-8?B?NEd4blAxVzQ4bFJGYzEyeTdqckl6U29tRHF4L3ljeFFEYk9ZQUlGZDA4KzA1?=
 =?utf-8?B?aktVZTlzem5TcjE0RE5wOUtjeXVKam1sRnlmMW1GbUZBaWFLa3pkV3ZnT1pV?=
 =?utf-8?B?Vkl4NVNZb2dOSFl2VDc3UGtTQ3pyZUNaeTVydEJ6cVU5UFZsM1dRQWYzOG8x?=
 =?utf-8?B?SStRNzB4VUFFVVhkV2JFbFh4ZU11WHZyVzF1L0hnUWl0ek82TGVuaG9zZVU0?=
 =?utf-8?B?NyszZGJKaGlmRmMrZlh4QXhOK1RBYTBmRXVpVys5aW1HMXB3QjZURWlmbDVk?=
 =?utf-8?B?RWZzWG5KQ0M1WktFN3BEK1krVG1tb1dQYUV0RVBKWExKbVROYzR0YisyYi8w?=
 =?utf-8?B?RTVJZmlaQSt5NVljZ052eGdIUi93T3lMV0dXdU5ES3o1MUxjcmR2M3Y2NlhJ?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1D2B54D046B904096B2BC7E55D61E56@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR02MB7938.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8d1c8-3b18-4383-c7e5-08dba2a8180b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 00:38:24.4515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nvfe0x4OyuJKbF6FjRKnXaXsrKxnozTajKz0Sj1DCVRTxHsJHd0YE6SB+VosAd1VoyTVb54kSerYfOd9ojN35oTZ0/q35buHRpSExIOLYcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9498
X-Proofpoint-GUID: eHTSzFFYrCvvmQOn5dxHsSznWAotuns_
X-Proofpoint-ORIG-GUID: eHTSzFFYrCvvmQOn5dxHsSznWAotuns_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_13,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=raphael.norwitz@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQo+IE9uIEF1ZyAxNywgMjAyMywgYXQgMjo0MCBBTSwgTGkgRmVuZyA8ZmVuZ2xpQHNtYXJ0eC5j
b20+IHdyb3RlOg0KPiANCj4gDQo+PiAyMDIz5bm0OOaciDE05pelIOS4i+WNiDg6MTHvvIxSYXBo
YWVsIE5vcndpdHogPHJhcGhhZWwubm9yd2l0ekBudXRhbml4LmNvbT4g5YaZ6YGT77yaDQo+PiAN
Cj4+IFdoeSBjYW7igJl0IHdlIHJhdGhlciBmaXggdGhpcyBieSBhZGRpbmcgYSDigJxldmVudF9j
YuKAnSBwYXJhbSB0byB2aG9zdF91c2VyX2FzeW5jX2Nsb3NlIGFuZCB0aGVuIGNhbGwgcWVtdV9j
aHJfZmVfc2V0X2hhbmRsZXJzIGluIHZob3N0X3VzZXJfYXN5bmNfY2xvc2VfYmgoKT8NCj4+IA0K
Pj4gRXZlbiBpZiBjYWxsaW5nIHZob3N0X2Rldl9jbGVhbnVwKCkgdHdpY2UgaXMgc2FmZSB0b2Rh
eSBJIHdvcnJ5IGZ1dHVyZSBjaGFuZ2VzIG1heSBlYXNpbHkgc3R1bWJsZSBvdmVyIHRoZSByZWNv
bm5lY3QgY2FzZSBhbmQgaW50cm9kdWNlIGNyYXNoZXMgb3IgZG91YmxlIGZyZWVzLg0KPj4gDQo+
IEkgdGhpbmsgYWRkIGEgbmV3IGV2ZW50X2NiIGlzIG5vdCBnb29kIGVub3VnaC4g4oCYcWVtdV9j
aHJfZmVfc2V0X2hhbmRsZXJz4oCZIGhhcyBiZWVuIGNhbGxlZCBpbiB2aG9zdF91c2VyX2FzeW5j
X2Nsb3NlLCBhbmQgd2lsbCBiZSBjYWxsZWQgaW4gZXZlbnQtPmNiLCBzbyB3aHkgbmVlZCBhZGQg
YQ0KPiBuZXcgZXZlbnRfY2I/DQo+IA0KDQpJ4oCZbSBzdWdnZXN0aW5nIGNhbGxpbmcgdGhlIGRh
dGEtPmV2ZW50X2NiIGluc3RlYWQgb2YgdGhlIGRhdGEtPmNiIGlmIHdlIGhpdCB0aGUgZXJyb3Ig
Y2FzZSB3aGVyZSB2aG9zdC0+dmRldiBpcyBOVUxMLiBTb21ldGhpbmcgbGlrZToNCg0KZGlmZiAt
LWdpdCBhL2h3L3ZpcnRpby92aG9zdC11c2VyLmMgYi9ody92aXJ0aW8vdmhvc3QtdXNlci5jDQpp
bmRleCA4ZGNmMDQ5ZDQyLi5lZGYxZGNjZDQ0IDEwMDY0NA0KLS0tIGEvaHcvdmlydGlvL3Zob3N0
LXVzZXIuYw0KKysrIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIuYw0KQEAgLTI2NDgsNiArMjY0OCwx
MCBAQCB0eXBlZGVmIHN0cnVjdCB7DQogc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9hc3luY19jbG9z
ZV9iaCh2b2lkICpvcGFxdWUpDQogew0KICAgICBWaG9zdEFzeW5jQ2FsbGJhY2sgKmRhdGEgPSBv
cGFxdWU7DQorDQorICAgIFZpcnRJT0RldmljZSAqdmRldiA9IFZJUlRJT19ERVZJQ0UoZGF0YS0+
ZGV2KTsNCisgICAgVkhvc3RVc2VyQmxrICpzID0gVkhPU1RfVVNFUl9CTEsodmRldik7DQorDQog
ICAgIHN0cnVjdCB2aG9zdF9kZXYgKnZob3N0ID0gZGF0YS0+dmhvc3Q7DQogDQogICAgIC8qDQpA
QCAtMjY1Nyw2ICsyNjYxLDkgQEAgc3RhdGljIHZvaWQgdmhvc3RfdXNlcl9hc3luY19jbG9zZV9i
aCh2b2lkICpvcGFxdWUpDQogICAgICAqLw0KICAgICBpZiAodmhvc3QtPnZkZXYpIHsNCiAgICAg
ICAgIGRhdGEtPmNiKGRhdGEtPmRldik7DQorICAgIH0gZWxzZSBpZiAoZGF0YS0+ZXZlbnRfY2Ip
IHsNCisgICAgICAgIHFlbXVfY2hyX2ZlX3NldF9oYW5kbGVycygmcy0+Y2hhcmRldiwgTlVMTCwg
TlVMTCwgZGF0YS0+ZXZlbnRfY2IsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
TlVMTCwgZGF0YS0+ZGV2LCBOVUxMLCB0cnVlKTsNCiAgICAgfQ0KIA0KICAgICBnX2ZyZWUoZGF0
YSk7DQoNCmRhdGEtPmV2ZW50X2NiIHdvdWxkIGJlIHZob3N0X3VzZXJfYmxrX2V2ZW50KCkuDQoN
CkkgdGhpbmsgdGhhdCBtYWtlcyB0aGUgZXJyb3IgcGF0aCBhIGxvdCBlYXNpZXIgdG8gcmVhc29u
IGFib3V0IGFuZCBtb3JlIGZ1dHVyZSBwcm9vZi4NCg0KPiBGb3IgYXZvaWRpbmcgdG8gY2FsbCB0
aGUgdmhvc3RfZGV2X2NsZWFudXAoKSB0d2ljZSwgYWRkIGEg4oCYaW5pdGVk4oCZIGluIHN0cnVj
dCB2aG9zdC1kZXYgdG8gbWFyayBpZiBpdOKAmXMgaW5pdGVkIGxpa2UgdGhpczoNCj4gDQoNClRo
aXMgaXMgYmV0dGVyIHRoYW4gdGhlIG9yaWdpbmFsLCBidXQgbGV0IG1lIGtub3cgd2hhdCB5b3Ug
dGhpbmsgb2YgbXkgYWx0ZXJuYXRpdmUuDQoNCj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9z
dC5jIGIvaHcvdmlydGlvL3Zob3N0LmMNCj4gaW5kZXggZTJmNmZmYjQ0Ni4uZWRjODBjMDIzMSAx
MDA2NDQNCj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LmMNCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0
LmMNCj4gQEAgLTE1MDIsNiArMTUwMiw3IEBAIGludCB2aG9zdF9kZXZfaW5pdChzdHJ1Y3Qgdmhv
c3RfZGV2ICpoZGV2LCB2b2lkICpvcGFxdWUsDQo+ICAgICAgICAgZ290byBmYWlsX2J1c3lsb29w
Ow0KPiAgICAgfQ0KPiANCj4gKyAgICBoZGV2LT5pbml0ZWQgPSB0cnVlOw0KPiAgICAgcmV0dXJu
IDA7DQo+IA0KPiBmYWlsX2J1c3lsb29wOg0KPiBAQCAtMTUyMCw2ICsxNTIxLDEwIEBAIHZvaWQg
dmhvc3RfZGV2X2NsZWFudXAoc3RydWN0IHZob3N0X2RldiAqaGRldikNCj4gew0KPiAgICAgaW50
IGk7DQo+IA0KPiArICAgIGlmICghaGRldi0+aW5pdGVkKSB7DQo+ICsgICAgICAgIHJldHVybjsN
Cj4gKyAgICB9DQo+ICsgICAgaGRldi0+aW5pdGVkID0gZmFsc2U7DQo+ICAgICB0cmFjZV92aG9z
dF9kZXZfY2xlYW51cChoZGV2KTsNCj4gDQo+ICAgICBmb3IgKGkgPSAwOyBpIDwgaGRldi0+bnZx
czsgKytpKSB7DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oIGIvaW5j
bHVkZS9ody92aXJ0aW8vdmhvc3QuaA0KPiBpbmRleCBjYTMxMzFiMWFmLi43NGIxYWVjOTYwIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC5oDQo+ICsrKyBiL2luY2x1ZGUv
aHcvdmlydGlvL3Zob3N0LmgNCj4gQEAgLTEyMyw2ICsxMjMsNyBAQCBzdHJ1Y3Qgdmhvc3RfZGV2
IHsNCj4gICAgIC8qIEBzdGFydGVkOiBpcyB0aGUgdmhvc3QgZGV2aWNlIHN0YXJ0ZWQ/ICovDQo+
ICAgICBib29sIHN0YXJ0ZWQ7DQo+ICAgICBib29sIGxvZ19lbmFibGVkOw0KPiArICAgIGJvb2wg
aW5pdGVkOw0KPiAgICAgdWludDY0X3QgbG9nX3NpemU7DQo+ICAgICBFcnJvciAqbWlncmF0aW9u
X2Jsb2NrZXI7DQo+ICAgICBjb25zdCBWaG9zdE9wcyAqdmhvc3Rfb3BzOw0KPiANCj4gVGhhbmtz
Lg0KPiANCj4+IA0KPj4+IE9uIEF1ZyA0LCAyMDIzLCBhdCAxOjI5IEFNLCBMaSBGZW5nIDxmZW5n
bGlAc21hcnR4LmNvbT4gd3JvdGU6DQo+Pj4gDQo+Pj4gV2hlbiB0aGUgdmhvc3QtdXNlciBpcyBy
ZWNvbm5lY3RpbmcgdG8gdGhlIGJhY2tlbmQsIGFuZCBpZiB0aGUgdmhvc3QtdXNlciBmYWlscw0K
Pj4+IGF0IHRoZSBnZXRfZmVhdHVyZXMgaW4gdmhvc3RfZGV2X2luaXQoKSwgdGhlbiB0aGUgcmVj
b25uZWN0IHdpbGwgZmFpbA0KPj4+IGFuZCBpdCB3aWxsIG5vdCBiZSByZXRyaWdnZXJlZCBmb3Jl
dmVyLg0KPj4+IA0KPj4+IFRoZSByZWFzb24gaXM6DQo+Pj4gV2hlbiB0aGUgdmhvc3QtdXNlciBm
YWlsIGF0IGdldF9mZWF0dXJlcywgdGhlIHZob3N0X2Rldl9jbGVhbnVwIHdpbGwgYmUgY2FsbGVk
DQo+Pj4gaW1tZWRpYXRlbHkuDQo+Pj4gDQo+Pj4gdmhvc3RfZGV2X2NsZWFudXAgY2FsbHMgJ21l
bXNldChoZGV2LCAwLCBzaXplb2Yoc3RydWN0IHZob3N0X2RldikpJy4NCj4+PiANCj4+PiBUaGUg
cmVjb25uZWN0IHBhdGggaXM6DQo+Pj4gdmhvc3RfdXNlcl9ibGtfZXZlbnQNCj4+PiB2aG9zdF91
c2VyX2FzeW5jX2Nsb3NlKC4uIHZob3N0X3VzZXJfYmxrX2Rpc2Nvbm5lY3QgLi4pDQo+Pj4gICBx
ZW11X2Nocl9mZV9zZXRfaGFuZGxlcnMgPC0tLS0tIGNsZWFyIHRoZSBub3RpZmllciBjYWxsYmFj
aw0KPj4+ICAgICBzY2hlZHVsZSB2aG9zdF91c2VyX2FzeW5jX2Nsb3NlX2JoDQo+Pj4gDQo+Pj4g
VGhlIHZob3N0LT52ZGV2IGlzIG51bGwsIHNvIHRoZSB2aG9zdF91c2VyX2Jsa19kaXNjb25uZWN0
IHdpbGwgbm90IGJlDQo+Pj4gY2FsbGVkLCB0aGVuIHRoZSBldmVudCBmZCBjYWxsYmFjayB3aWxs
IG5vdCBiZSByZWluc3RhbGxlZC4NCj4+PiANCj4+PiBXaXRoIHRoaXMgcGF0Y2gsIHRoZSB2aG9z
dF91c2VyX2Jsa19kaXNjb25uZWN0IHdpbGwgY2FsbCB0aGUNCj4+PiB2aG9zdF9kZXZfY2xlYW51
cCgpIGFnYWluLCBpdCdzIHNhZmUuDQo+Pj4gDQo+Pj4gQWxsIHZob3N0LXVzZXIgZGV2aWNlcyBo
YXZlIHRoaXMgaXNzdWUsIGluY2x1ZGluZyB2aG9zdC11c2VyLWJsay9zY3NpLg0KPj4+IA0KPj4+
IEZpeGVzOiA3MWUwNzZhMDdkICgiaHcvdmlydGlvOiBnZW5lcmFsaXNlIENIUl9FVkVOVF9DTE9T
RUQgaGFuZGxpbmciKQ0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IExpIEZlbmcgPGZlbmdsaUBz
bWFydHguY29tPg0KPj4+IC0tLQ0KPj4+IGh3L3ZpcnRpby92aG9zdC11c2VyLmMgfCAxMCArLS0t
LS0tLS0tDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA5IGRlbGV0aW9ucygt
KQ0KPj4+IA0KPj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdXNlci5jIGIvaHcvdmly
dGlvL3Zob3N0LXVzZXIuYw0KPj4+IGluZGV4IDhkY2YwNDlkNDIuLjY5N2I0MDNmZTIgMTAwNjQ0
DQo+Pj4gLS0tIGEvaHcvdmlydGlvL3Zob3N0LXVzZXIuYw0KPj4+ICsrKyBiL2h3L3ZpcnRpby92
aG9zdC11c2VyLmMNCj4+PiBAQCAtMjY0OCwxNiArMjY0OCw4IEBAIHR5cGVkZWYgc3RydWN0IHsN
Cj4+PiBzdGF0aWMgdm9pZCB2aG9zdF91c2VyX2FzeW5jX2Nsb3NlX2JoKHZvaWQgKm9wYXF1ZSkN
Cj4+PiB7DQo+Pj4gICBWaG9zdEFzeW5jQ2FsbGJhY2sgKmRhdGEgPSBvcGFxdWU7DQo+Pj4gLSAg
ICBzdHJ1Y3Qgdmhvc3RfZGV2ICp2aG9zdCA9IGRhdGEtPnZob3N0Ow0KPj4+IA0KPj4+IC0gICAg
LyoNCj4+PiAtICAgICAqIElmIHRoZSB2aG9zdF9kZXYgaGFzIGJlZW4gY2xlYXJlZCBpbiB0aGUg
bWVhbnRpbWUgdGhlcmUgaXMNCj4+PiAtICAgICAqIG5vdGhpbmcgbGVmdCB0byBkbyBhcyBzb21l
IG90aGVyIHBhdGggaGFzIGNvbXBsZXRlZCB0aGUNCj4+PiAtICAgICAqIGNsZWFudXAuDQo+Pj4g
LSAgICAgKi8NCj4+PiAtICAgIGlmICh2aG9zdC0+dmRldikgew0KPj4+IC0gICAgICAgIGRhdGEt
PmNiKGRhdGEtPmRldik7DQo+Pj4gLSAgICB9DQo+Pj4gKyAgICBkYXRhLT5jYihkYXRhLT5kZXYp
Ow0KPj4+IA0KPj4+ICAgZ19mcmVlKGRhdGEpOw0KPj4+IH0NCj4+PiAtLSANCj4+PiAyLjQxLjAN
Cj4+PiANCj4+IA0KPiANCg0K

