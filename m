Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F907D8D1B
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 04:27:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwCY5-00006U-EA; Thu, 26 Oct 2023 22:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qwCY3-000063-3G
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 22:26:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1qwCY0-0007iW-64
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 22:26:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39R1vdFP027521; Fri, 27 Oct 2023 02:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=eY1CqQaG/3ZuxqadRWs/iuNKAtPbjk78g4zH/jQ+eBg=;
 b=VKXGzrSZkd/R0ihNG2jmIXzVVJ74Cu+rnLQYNjf1puuXVsCKuaLSpFhTkB/NzObmSuzS
 qNOUzkDmdev8/abnbvWmrFRQBRXWmFvBHDLe4d9B2wL0y8Jk+7YN8pqVP1lzT795U520
 34ahXIJ28Bjm0UXEssHVT6FrVtVTIlVK3uiDj08x+OWE2YIHtzU1Ut5Q3Gpg260KVKrp
 7Ok0xecnBxhFBpv5g2/TvFYCyC4dFhZGe/ammahliYPCasr5FcoldhkcAiciX+e/tmfO
 GZav11RZ1rA2xJ98fCAHgB4NflPUUX20zzA920U6gU954nLPYz1eM80NtyLuTR4egz6a QQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tyww70v2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Oct 2023 02:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PzygrEJl9PuGwdWrKYiN5yuKWvpZNhgupLR2Ua7dC5XTKMdrjwhR/s1cwM1h+9koqYGyQ3CmN8GloKy8z5Iyy6ARPhCrQgv1JQiEVmtErRc/2g++ZTWV4QneZDf+3DgwsUDKan8w8X54Lqh/KtAKqxzGZj2ionXyzQ17+Mt9yKjbqq8+rLlBnBxpLg/fPSgyQztVjhu4HEjadsEHyLR533/MrV48QynwMHFBSDuKSRdaDGlbvqxhs9RiDioWNVB/dO0ySZmHahojM7kehTE1ZPgQV3SGOsn3dbfsyH8xvIfMDwBs7I80VccNi43fbC6HIlun6Pk8y7CWtQy9LGt5OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eY1CqQaG/3ZuxqadRWs/iuNKAtPbjk78g4zH/jQ+eBg=;
 b=FuEbiFQ0ofFXEkDn2NzgQo9LkiddaiKchWIeNvjOmJcBfanbspzzxaT4JCjlXNFscYK0ywtrQ5bdmEOJK2XM2KmfMtjPDasXmfwIZrXO+UjFAs4AbN4eMFxEizvvrtdv+qV/bTcyogmxBlJwZSfONuEjU94iwsKKuizk3F8LOvmb1MkW/QmHYLKF71LxzPfRBtRK45p8ytCu4AU95wd+yce/EOB4p9uCbtvr4EOg55RC7CsWdv48MYiV9OTn+8nAYIr9n0h6rxE7Qxi6lnHJYQoH1Qh6ZbaVL1jXkmjmO2LJBGy80yb8GXUMMYtYW2xlo4mkFjEayf7PYcn2im9RLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by CO6PR02MB7810.namprd02.prod.outlook.com (2603:10b6:303:ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 02:25:55 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::546b:93ec:1242:265c%6]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 02:25:55 +0000
From: Brian Cain <bcain@quicinc.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "marcandre.lureau@redhat.com"
 <marcandre.lureau@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "imp@bsdimp.com" <imp@bsdimp.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Subject: RE: [PATCH 0/1] Enable -Wshadow=local
Thread-Topic: [PATCH 0/1] Enable -Wshadow=local
Thread-Index: AQHaB82pOW22Vkc1A0yYo6143dJbTbBc0BcAgAAZqBA=
Date: Fri, 27 Oct 2023 02:25:55 +0000
Message-ID: <SN6PR02MB4205D555522B39BDD88B7BB1B8DCA@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20231026053115.2066744-1-armbru@redhat.com>
 <CAJSP0QW2uVv1s6JnNFj5HC13vO=yGsGB0wb_mRJvUQXoeCLvQA@mail.gmail.com>
In-Reply-To: <CAJSP0QW2uVv1s6JnNFj5HC13vO=yGsGB0wb_mRJvUQXoeCLvQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4205:EE_|CO6PR02MB7810:EE_
x-ms-office365-filtering-correlation-id: 5e92bcca-074a-46fa-5d6b-08dbd6940c88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s9RLCvZLcFZKOHsgJL2Tqk2VOCczPwXl0vOzjUhEKAdsZbzZcp+cBxPVyF0iPUcCr/CrfC7r2NwUcHhdBWp1De70LK303o9gAcy9xowUxBX6aJMWWCe9qGoUawlxOocuheqilIptrdAsO1cqNxMqE6gT71y4QtSSd4sa2d5KXZ9N2u9Vik42SprdSTC3+cOteSsGqkPEcSAYZAEdS20ONDyBRlySr/7JdJ25G3SWgB7yWtqV4K6WIG3vWeXqKgXW80zWZUVYE+Vu0LeJ16F6G7BfjaNn9zAQIVIG2pHDcffmd+cktRBYOOU8EOnQCW9UYPnPo6GzNPUox3dKcr8rhdaKa/priOuMrr+NPDRqn6uuPKc3pge1NXVogRvX3cgZ8gCIIWDu5pppjxQrpgSje2qwEyoq5HfNMbhJiRt4Es51IGFEYOTNdSrxrgVttiw0LQBTwXyj5zFD6yGKl0a1ExzeE6gkAQeA1ssg+dziy68eXkOKW/3lQYPzD4JNf31G3PHDGXn6qqXjAh5EZriMzfhUOcrjm8OdZ/KpYzzxpvPe0zIu7P0vBVmuhJOgCXsWHk2+M11ZahV9jRlt1O32k1VCBdIIxAJhwco959MAQdCyCIjS8Bvcl3hcgjnBNz+VmRJiKe1GSBTEx36XCNotng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR02MB4205.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(83380400001)(7696005)(6506007)(53546011)(9686003)(71200400001)(76116006)(66946007)(110136005)(64756008)(54906003)(122000001)(478600001)(26005)(316002)(84970400001)(66556008)(66476007)(66446008)(8936002)(38070700009)(8676002)(4326008)(5660300002)(55016003)(41300700001)(7416002)(2906002)(86362001)(52536014)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amxQN2twZFQ5WFR0eGZJaVdTMmRJcy9kazBQWW12U1RxaEYrZ0QrZ09IeE8y?=
 =?utf-8?B?OVZRdnVZazBiTWNPVVphcjVIRENneDRzM0RZMi9BNFdsMTh0VFhINWIzdUNi?=
 =?utf-8?B?L2ZSN2xVT2tWK05iczZFY0lNTy9oSnlTK3VrMDVBVFB5VFFtY0F4ZGdjcWly?=
 =?utf-8?B?dFVYNThXVFUzeGIrb2xzNGhzNWdFYXFXdFphRHZUQ0swYkpuUmh1QWx0YkxW?=
 =?utf-8?B?TXRvU2dRc0ZSeFVUc2YwUUpoTkdZV2hyL3NhVjBhRmxuQ29oOTZtTW1GZ05w?=
 =?utf-8?B?SmRXSDA2aDRkR3dZQnJFS1lHOHo2SWJiYlF1UjVqTEE0WDVXaUVON21WT0R4?=
 =?utf-8?B?RUdxNXpJVDZIMngwSlJLYytJbjBwSHE1cVprRitLUm9xUm91OTdzMVFVOHlm?=
 =?utf-8?B?K1d4a05wWWt6SElnOWdJSW13OTB6NEl1bWVFOHdUc0k5ZzI0SGllOWVZYS85?=
 =?utf-8?B?aEZqQUgxUmxJT0d3cTV6VU1kMTJWMHRJczFhcmM1U21MNTFxejdtSmF4VU1x?=
 =?utf-8?B?c0Z1MTdneC9PaXR4TXFzS2hHeFRVUCswY0NYeG14L3lkNy84LzB1VmNlVkRD?=
 =?utf-8?B?a3lEVWp1emorQlUreFJCcjVEOWNhbEJTN002KzNSN2s3bVJRb2EzSFVaR1NE?=
 =?utf-8?B?Nko1bWM0M0RkR0ErU2QzdGRSMGdWdVNMWkpuZ3BFMVVXMXdQV3AyZ0l2WThK?=
 =?utf-8?B?OW9sVTBCWmQ0T1kxR3JxRjJLUENST0FzWEFtUUVwMXp6TnFuNjhYaldSYzZh?=
 =?utf-8?B?WjVBNHJheWpqTzltOCsxeXo4REVRd3pVNzREZzNuVzFhWG9ueWVaVHErOGVm?=
 =?utf-8?B?M2QzWkNIcC9ZazNsMitZMTlzU2FZQVFuc3RpbW85bjhQYjg3UkgxUVZrQlVJ?=
 =?utf-8?B?MzRwZGIvODZlOUpJMDJqeGIxYVg5a0M1clRUUjY2blZYVEpLcUhxYmQyT0Zm?=
 =?utf-8?B?ckxZQkxCVzg3SEE0MHhNUlpnUy9QN3Y3YjRVcUlxSjlFNDlOUnd6WnFIUy92?=
 =?utf-8?B?cmoyaVZYcjNRUnJHbm10dVM5cDRlU3J2dkdSN0R3QTZ0SjlqVmpOc1FFZ2RV?=
 =?utf-8?B?akVRUHcxRFJkZjBtQldlZzVzRHV3QVIvN2Q3eEVyVXBXLzlQazJNa0lhbE94?=
 =?utf-8?B?L3JBOHBkV3o2Z1VHcFVTNzRlczV4OUlydWE1Q2hCTTJ5NXFoMTVQY3ovOFBo?=
 =?utf-8?B?MDJ0OVVIM1BhTUd5OEVwQkIwZlVLbzJNYmhGWm1ERmM1bDMrb2lrSnNxVHcw?=
 =?utf-8?B?cXNnZlF0Wm1HU2tyWkFIbXJJbUorb3lTM2JFSUhidHhuRjRWdHdPQlA3NlJW?=
 =?utf-8?B?Z2VOZVBvZ1ZQMUZvUHVTUTEwNFV4QmJNZmtTQUU4NGdSZkhlYkpMOHk0cndi?=
 =?utf-8?B?RHZmaWlXK0l6SVMwQUVHNGtUSjluTFpPYWZ1QWZDTXlCZElUWTZWU2ZIS3ps?=
 =?utf-8?B?VVNnVEVMQ0tzeUdMUTdVSUtZcDNHUzJnaEVvMnZxWnlZTXRhTXljOVdhZUI5?=
 =?utf-8?B?VnNIaGxHVFpTdXFGbzhkaFh0N3ljeVF1UHJWcGpQMWlpNmZDR1oxZjdpdVRL?=
 =?utf-8?B?NHBNMTVwUDhidysxU24wUmN0b3Rra25EejZ2YVdnQ2MxZlNYUnVweVZPRFdr?=
 =?utf-8?B?RkVRRCsvWHJiZGFLRTRaSWZyTFRHQnRuN3VIOUg5eDBEQU9DT0tXQW5NQ1E2?=
 =?utf-8?B?UU9UZ3JkQ09WQ3hnbE9CdWZwY0NMb3QzeVZMRE9RcGdFdGlvb0lIRmpsMW5w?=
 =?utf-8?B?cTd0MnpsK204V01oTitrc0s3K0p3amplazc5cWE1NkxMNFg4WXV5V1BuOFda?=
 =?utf-8?B?eUdHUzFNNTJRMm85eGYxQzJwNXFWb2czSmlqcnRvdXAxZ3lOek9GenRhcmlK?=
 =?utf-8?B?ZFhyeEhWWUt5aU9hMEpXMFVONGFTcTRxOE9rczBNc1EzcHZtU3p1aVRPcG5T?=
 =?utf-8?B?eWw3UzFmeWlCMlUzbkdZeWZCY0pnWmY1N0VuRVpqSGliN3paVDRQazFvNGxj?=
 =?utf-8?B?d3FxeFFmQUNDMEdEY0NXUUJ2dVlBNzIxNXU1ZmpxcE5ncG1sUlg3ZGsxaVNX?=
 =?utf-8?B?aU9iQTN1cDZSQ1VPNVJaUTY0QWd3YjRKclJtTUJQclE1THZpMDdyVi9CUW5t?=
 =?utf-8?Q?UiU0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0WbEI6OKfVgZtyl1Pvytzdyqv12Aw9qJnDkLrBoS/SHoAf6M5jrNMqM6+bxqC1qxWwxd5QZVnKXamOTjIBeBf/HLqqp8sEypwzf5xRtSn3PXDYBA2TnUQdwJUqaWibfPWFsyvM6tTC8jpu/uXIl/bSsS23KWp1PXyyDtxXHgt3QZ5jfxRi/TtkPmbI/kXHj60rPzETY4BogqMCH8EhMoYNjLzaqRIQiKTDs9bfvwN2NDfCyELrLE+RTeoBjZACHdmEws8sZUYTecvzSf5uRxInnJ+/4Dz+WFZ6ZBXI9l0SkA77whRJVFveowL4lDqJBR/sYxSo3HxmIyMTB3QQNg5qU3LvAZ7Ks4HMNAPuZXbLwRqMVspTDyXdGonx1OGM1uXOKmkUR9Te+qWAInfnUB91JHL1RYj6gEcUnTwiScQ43bsPua42blp7JkTgesms7bkHNNQsiAshW944WayVykEVMgd+awo3GPSwR/rz4A4e/D6xT2yxY/fkKwsHjCTmeewqkyt4soyxe7zQS+tc4QdpPyxOIXdLGyg891SX7B2eAb3mm4AeLBysqUwvXKYaMm2uGeRaoV3VyzEh1MBmJ2AANL6Hqz3wSRlaxeTBWzOYuCxr+HYNZ1P28avtDHjI+t/m8pCd6yxijTWym/cxh5Lc95Fim7ARd1HaCnzMx2yf6t+Fkf0f6doKqXUUhoY3yA5xicsUSjyEzQmR4BvJOcngEW19wclrk5tKSRM5Apk2RiaTtixSoYMMYJo+TTOyQW/Yft+fzA76Fn/XGvYPqxC/3a75OqXQAFsnMT8yeENG4h17647nRbvLuFWv5bUUMDmqdEasNHFExRd74ymzrBLQcYYSqLxa4LpfjAPQ3IDxsSrzZqKL8+DOXEmSJMRQSs
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e92bcca-074a-46fa-5d6b-08dbd6940c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 02:25:55.6815 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkdVZuUaw5MOREYDuRz7L50tceBXjaQzkwfa/A1W3oYOIOVB4kKEwDXPGBthzuUvRCKRwwpqYYnVs6HSSc/mSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7810
X-Proofpoint-ORIG-GUID: WUUZGqUGMPrt-4T7b1wHZWAc2cV_IzTH
X-Proofpoint-GUID: WUUZGqUGMPrt-4T7b1wHZWAc2cV_IzTH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-26_22,2023-10-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=397 priorityscore=1501
 bulkscore=0 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310270020
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIEhham5vY3pp
IDxzdGVmYW5oYUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDI2LCAyMDIz
IDc6NTIgUE0NCj4gVG86IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCj4g
Q2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj4gbWFyY2Fu
ZHJlLmx1cmVhdUByZWRoYXQuY29tOyBiZXJyYW5nZUByZWRoYXQuY29tOyB0aHV0aEByZWRoYXQu
Y29tOw0KPiBwaGlsbWRAbGluYXJvLm9yZzsgQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+
OyBpbXBAYnNkaW1wLmNvbTsNCj4gc3RlZmFuaGFAcmVkaGF0LmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDAvMV0gRW5hYmxlIC1Xc2hhZG93PWxvY2FsDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVt
YWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBv
Zg0KPiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4N
Cj4gDQo+IE9uIFRodSwgMjYgT2N0IDIwMjMgYXQgMTQ6MzIsIE1hcmt1cyBBcm1icnVzdGVyIDxh
cm1icnVAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBSZXF1aXJlcyBCcmlhbidzIHB1
bGwgcmVxdWVzdCBhbmQgdHdvIHBhdGNoZXMgZnJvbSBUaG9tYXMgdG8gY29tcGlsZToNCj4gPg0K
PiA+ICAgICBbUFVMTCAwLzJdIGhleCBxdWV1ZSAtIEdFVFBDKCkgZml4ZXMsIHNoYWRvd2luZyBm
aXhlcw0KPiA+ICAgICBbUEFUQ0ggdjJdIGJsb2NrL3NuYXBzaG90OiBGaXggY29tcGlsZXIgd2Fy
bmluZyB3aXRoIC1Xc2hhZG93PWxvY2FsDQo+ID4gICAgIFtQQVRDSCB2Ml0gbWlncmF0aW9uL3Jh
bTogRml4IGNvbXBpbGF0aW9uIHdpdGggLVdzaGFkb3c9bG9jYWwNCj4gPg0KPiA+IFN0ZWZhbiwg
dGhlIFBSIHdhcyBwb3N0ZWQgYSB3ZWVrIGFnbzsgYW55dGhpbmcgYmxvY2tpbmcgaXQ/DQo+IA0K
PiBJdCdzIG5vdCBpbiBhIHB1bGwgcmVxdWVzdCwgc28gSSB3b24ndCBzZWUgaXQuIEkgZG9uJ3Qg
aGF2ZSB0b29saW5nDQo+IHRoYXQgY2FuIHNwb3QgaW5kaXZpZHVhbCBwYXRjaCBzZXJpZXMgdGhh
dCBuZWVkIHRvIGdvIGludG8NCj4gcWVtdS5naXQvbWFzdGVyLCBzbyBJIHJlbHkgb24gYmVpbmcg
ZW1haWxlZCBhYm91dCB0aGVtLg0KDQpNeSBtaXN0YWtlIC0tIEkgdGhvdWdodCBJIGhhZCBlbWFp
bGVkIHlvdS4gIEJ1dCBJIHNlZSBub3cgdGhhdCBJIGxpa2VseSB1c2VkIHRoZSB3cm9uZyBlbWFp
bCBhZGRyZXNzLg0KDQo+IA0KPiBXb3VsZCB5b3UgbGlrZSBtZSB0byBtZXJnZSB0aGlzIHBhdGNo
IHNlcmllcyBpbnRvIHFlbXUuZ2l0L21hc3Rlcj8NCj4gDQo+IFN0ZWZhbg0KPiANCj4gPiBXYXJu
ZXIsIEkgYmVsaWV2ZSBub3Qgd2FpdGluZyBmb3IgeW91ciBjbGVhbnVwIG9mIGJzZC11c2VyIGlz
IGZpbmUuDQo+ID4gUGxlYXNlIGhvbGxlciBpZiBpdCBpc24ndC4NCj4gPg0KPiA+IEJhc2VkLW9u
OiA8MjAyMzEwMTkwMjE3MzMuMjI1ODU5Mi0xLWJjYWluQHF1aWNpbmMuY29tPg0KPiA+IEJhc2Vk
LW9uOiA8MjAyMzEwMjMxNzUwMzguMTExNjA3LTEtdGh1dGhAcmVkaGF0LmNvbT4NCj4gPiBCYXNl
ZC1vbjogPDIwMjMxMDI0MDkyMjIwLjU1MzA1LTEtdGh1dGhAcmVkaGF0LmNvbT4NCj4gPg0KPiA+
IE1hcmt1cyBBcm1icnVzdGVyICgxKToNCj4gPiAgIG1lc29uOiBFbmFibGUgLVdzaGFkb3c9bG9j
YWwNCj4gPg0KPiA+ICBtZXNvbi5idWlsZCB8IDEgKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykNCj4gPg0KPiA+IC0tDQo+ID4gMi40MS4wDQo+ID4NCj4gPg0K

