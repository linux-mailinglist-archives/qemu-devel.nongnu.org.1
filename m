Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E82B97426AF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:46:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEr12-0007hv-PN; Thu, 29 Jun 2023 08:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEr10-0007hU-FH
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:44:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qEr0x-0003bE-6t
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:44:50 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35TAoUB8008706; Thu, 29 Jun 2023 12:44:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SVf89Nls198NU5MEX12WWLZeJm0cJ+rpB1ue5dhaVoU=;
 b=pnl7baSyrddtocSv9ScrrIdW9tS59WyaBMmfcfkgf2BCVaf9xutq2qQbMOPFgK4T3io6
 vjQsJQqJ37jyWJ8Gz0o7rSGkkQr5I7q91Gy67Ro3PDkRB7k+RMLkRXf1CgCcWnCOwL2+
 U6KTV7m1yeLQgwmSkkbmxGeNxOGJkQMsZgbjNd+vwBKUFfJnNcY+IShBXHfGQLhHLJE6
 N7QNJM3LohZQ0l2skHoK49WJGdGnMjufCd4kLBYYz8YH41GcbGQWyLOCjRygJPGJbsqu
 cApu7QTOqnDs3qV+eh1YOplQkIOtfQLV3cEU57HWgb7LNxf47y0SXzp3CZ/KoZrvdUMG Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq93c3py-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 12:44:43 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35TBmCag020035; Thu, 29 Jun 2023 12:44:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxd413y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Jun 2023 12:44:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYxxn9HSR7o9sWI0WV9o13losGZkbw8gsh/sY7mdnybh54jSEucelh+JfnShJtdkUMTyIk87JN03lEm9Dyxue0mj/Bf1GDHUFfa9qlzWCb+T8iK5FdIe3Z46Z+uhBLRhuN0xfSxfkDbkP46qobAojxiRXLYUbdUMpgjf7N0/9k13QBPXHy45bUrqetjfEKqM1Yt9v5lGsDdcNEXW+DGhVFBOYZ+/8Tpq+hJoGe6O5lUomfy+lqQe0EMMJQRwnH6ZvWgdNT7QSWSK0kdgzRZAS/KeTI/0YIjmHmUu/pO1BmTxaMfQq63kAf7+1wGVr9VUKZ8Kz/qJe5q7c1XWj2eXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVf89Nls198NU5MEX12WWLZeJm0cJ+rpB1ue5dhaVoU=;
 b=U/oPtmTusVsLeDKf/BfQmi8wVY1kmNY0+VWZjZnrRtvowt6xmg2jMferrK3FJ+JPmaEvND7RLvTEdq1oG3rl1DKz3sCjb6pzhdYqASMGddrd8EeOnJizULD+x6z9sODn7Y79H20AC9Mf8hOvZFFeKYOmKOH3phY4esExsyUau4JpgPuAAE154vHQ+wDLs5gbTqXODVh2CcGzbQxlSDCb4VPG5ImTJ/GkOr5D67CvkInqjJKvkTfF+65Tms1FyC21vEIHtI39QZGPn0Vs3ZtAgE2bzfFVNxhRytHHAT4jdeBrx+Fb/H+qkeS2+lSZZMvM8E2dwHGRVqGsz4GOplf+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVf89Nls198NU5MEX12WWLZeJm0cJ+rpB1ue5dhaVoU=;
 b=XPWOBfljq+SfxQoaV0/y13jWP0eG70YGKcUATOuJA4r4fAW133D3oIa6DGTAp5yZBtftQ41EBK+zvwydqM/CUEmeSza/O65Az1S645U0wbdYqfwdDE8nyYvPY231LcvqwPKnSzu5RZnmadcv9S7Uh70PZStZEx5088ZYswR7z/c=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH0PR10MB5681.namprd10.prod.outlook.com (2603:10b6:510:146::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 12:44:40 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 12:44:40 +0000
Message-ID: <9aa97ee7-ee54-a2d3-2cde-36b1a1d1241d@oracle.com>
Date: Thu, 29 Jun 2023 13:44:32 +0100
Subject: Re: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, avihaih@nvidia.com,
 chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230629084042.86502-6-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::15) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH0PR10MB5681:EE_
X-MS-Office365-Filtering-Correlation-Id: 74eba6a9-3ce0-4f2b-cb83-08db789e9aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHyzk3B3tt5FMzxducKcP7e2Jx6JujnhEA1274SMrpgkqobyTu+EFgwNAzcQXwEzLn7FPZ9NyATTuKvxeQsZabHx8CZIE0veuCvldkYulsPi2SkuOyK3tpxAMQTWCpRROlWt7w9bW31b56K7G4n6b1QRCFgpE+55G2Xj8SnxJ3/JYJsoT6Mc0/1MsFuAlvivNd70X9UgykI5NcTAauD4Q+Dyt0Rtxo6Kn3DnfWDBV+6eND7X3lm5WZBaYX85tD8grcAZZ7DgVpprhksrGo2IKYyYuao6uD9aq1/optoVBzSQOMAMxj1VfeJRGVhEkNz6poxk4G6NAalrsF7Bia08W6EP0cSrnMybJwDSG+mvSH82Rp5pzYOnP5d+9XVG0Vp+jBEp1aXbQJfZudMKxjGKsNpXg/aMbj5pL8v8nfzU4VldL1j2CuBlen/RQgXIbKaMTVnMfTogwreOaQnyPYPJ/CN77YiegJ/W5SCszD3kGy8KRTrt+GTVwQQUo/uHgevade56TBK+mdqcTlBOHv03YFctPGgX8uQtdh2KpTHs1w7Do1rmrl316SK/A5aIoQqQbrqhY/gTp1nTuVlMZ6hDPbCvZhkH04NiV7Gzkp/Wr2byQQqW5dYB3SM7F3V9Njpn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(6506007)(53546011)(186003)(36756003)(6512007)(26005)(83380400001)(2616005)(5660300002)(38100700002)(478600001)(316002)(66476007)(66556008)(4326008)(66946007)(8676002)(41300700001)(31686004)(8936002)(86362001)(31696002)(6486002)(2906002)(30864003)(6666004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3BDaDdyYzk5NDJZUFpkSXRDRmRTWm5rcnY1NGJmTWJIcEdYSFdkQ2RzY1RM?=
 =?utf-8?B?amhmSDRCNVZjUFFWZ093ZkR5WDZqZENFZ2R0ZnVRaVpiM2JuZHh1a3F3aXRu?=
 =?utf-8?B?QWR6ZktzeDJZR3k2Um1uVU5senB0L3lmNm40R25LQWVXQ2dNL0VmSTJjQ1Zj?=
 =?utf-8?B?bG1LQ3hSUkVxd0lXbmxVSFlhWW8vQ2pzZXZMSFl2S0lkcW0yYUNLQTk3WTh1?=
 =?utf-8?B?OGFkRWd2N1haSHdvVnZzYzlrR1RBbUdncDU4TEI0NzBwenBSRk1EY0JsWGt3?=
 =?utf-8?B?NUN6Tk9qT1hsdnp3ckxJSHhaQzIzeGczenExbCtmMUNEZUxmUVE2NkU0U3hQ?=
 =?utf-8?B?MkRJSkhrZFBTdzlocEhvTjB3M1U3V1d5c3RtVkMxd0QvZWpLWjdZYlA3VkV2?=
 =?utf-8?B?VXV2YmROYTRjNWdnQiticVJ4WEZjclFvV1AzelZJanFpNXVTeFozRWEwbG5R?=
 =?utf-8?B?L2ZIRjJjZnNNRmVDNWFnaUExYzg2RTdYSzR4UnNQUzFON296TDNXV1VDdVNm?=
 =?utf-8?B?UUY5TEpCYWY5bkxhejA0QXdYQlh5WFJRLzNoOTJxeDJOV0traFRrZEQrMEFi?=
 =?utf-8?B?S2ZHdFFWTWR0cytEZG9tVEVvR2VFay9JaEhkcm1LYXUxSUE2V1UrVm41aWt3?=
 =?utf-8?B?ZUxrdUZpVVZOaldOWklRY3hpemZKR0phNjlQNUYyaWYyQndhZXQ4emNxdThH?=
 =?utf-8?B?R0Y3N0Z4N0pCYTVoYWRMZE5SWXFWNEhnWkN3WHAwaWxQb0l2UEpFRUhXbDlY?=
 =?utf-8?B?WHN5WnJoeVdiQ0RlVzRBRjdwRThsUW9DdnRHK3B3VmZXYjI3aFBpTGE2ZHgy?=
 =?utf-8?B?R05EVHdGSjA3ek5zL05BWGE5TnJEU09ibTFSeFFwaUd3S0FqRys5SVFUVFlw?=
 =?utf-8?B?YTYxVGp4UnB1eU9CY2NSTHVaTjB0S1ErMEsrVi9NaTRtYWpBTXBWQ0lacFdL?=
 =?utf-8?B?bG5IREM0MzNCcEtsV2JxcWt1aHVjSlVxL0RVUFI1NFZNL2tnOGx6RklNNlRj?=
 =?utf-8?B?QmRXM05DcThKMys2UmFqYkI1MEdKRGVlT012Q3RrZWRUMnYzZG9wTnFpaGRN?=
 =?utf-8?B?Q2ZObkJVTzZtd09hbzZyaXpuSE1vN1JvVGVPcEFqSWJjMElXYzRoYms2Q0gz?=
 =?utf-8?B?b0ZUMll2RU9yQXpRSVF2MGtOZlZlblZuVkw0aHJNWmFLcmVNcXVUVjhoaGJW?=
 =?utf-8?B?OW5WRDd5QzdvTjk4NkUrMVUzNDYxV2VpN0hGSnZLWVVyL2NacDVZdmVQTndY?=
 =?utf-8?B?bnh2MERBRHdLc0NaRmp6TnM0eWpiakdXZHBZYU1TM0xMMzZmQmI3MWVjWU05?=
 =?utf-8?B?L29taXQ0aE5TdktrVXdBWlcyeExJV1FRd2V3V1duQkN1WGIwcDhJY1lYSldQ?=
 =?utf-8?B?OHVkMjhjcEVMWXl6OXB6TlFWWWFUNHNCNGswMWxTR3A4MHNCUVlqQ0hjcmZH?=
 =?utf-8?B?aDlUbkVqTVBraTgwb05jTC9uWU9SakhabTEzMnlEaUUra2QyL2haMmhWdldl?=
 =?utf-8?B?RnZSK09lNDQyVmtxU3NJTzZHNm5mSUl3QkZGa1pFeVZ3TlNrdDNUMkt4SnhT?=
 =?utf-8?B?RHlmY29GU3NMMW0rL2FjcXVqZzluZTNLTUVmRExvNXRXbHVJcEE5KzlmbDJo?=
 =?utf-8?B?N1RCOU5BY0xsN0xNYnJUbEZkTW9kbnRqYTBNRXZOdGlaczZPdHlScUNQN1cr?=
 =?utf-8?B?cENKenJsZVRoUjJFbDVMY3FSYm5MTTY0RFFDeHZWRm0vUlNmYSt0eHJWZ1Jm?=
 =?utf-8?B?WE1GbDFva1Q0KzNLOTdUdTdBanVpU0NBU3FrQUI5clc5Tzl5d1Njcm16UHo3?=
 =?utf-8?B?Vjhxc3lZa3N0N3ZXQ2tSNVhSUmUxcmJhdTJOWVNPWnBheHRuNXR3aVcvVGhu?=
 =?utf-8?B?NlNFUmhkVHVPVDdlVWZTWHdVY0NrNUxMbkJUdnh6ZG43cmZUcE5hcTlhSXgv?=
 =?utf-8?B?cGhyaktwTmJHb2hTejJkaXBnUndOT1R3NXRKcmVpNVhEVkNENlE4YzN4SVJY?=
 =?utf-8?B?MUc0U3FCNlRSS1NhZTVzYXVvU3NkTmZHSkpUNXNjbjNwaWl0QkE3V2pkc29l?=
 =?utf-8?B?UVpteXhpb25GeEdSa041dXhTemJXbzF3cmt5UEN5T0NXUWVkZXJsV3cwV0NV?=
 =?utf-8?B?aVE3cTBveWJWUlZFb2wvREpWTHVuYVloc1J5WXdFZHlGZTFKckpHbWJxQWxC?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z313nMhsg0yVRUkaFJ/JNnynJ0OBLAB7A3AG/o0aNBrYHREsU8db0rIEDvAkZJjiTH/gLtpFIZWKf4AGkE5W/d1LRhqhP1Ki70oiZHcKrwE4jidydSfIMFFSQ0k8JK7DrpPN9lXv+49BmCqqAkNw8TqlLwUoOvBsX461lvOeUaU7J7wPtPhu6IPNeQX8eq75nmA8EYUGbIJq5howPpu+vXtMTtLQg/ZjG/1WsTVrutm64zOOtrPvGgeWstzLhTKULmgfkkFPm/Q6tNu/5jS2ONlhVTiN4FlmBzuy1DEkvnSOwlDS9KAgHeP7Sx3hyGlQ8j/jmgMHJoW+T7WTOQn2YSYcnXV8bUKYyrHnKHiLntDPdqtP4jaiGUBr+k45gL8muxHbhb27cAcNOa8myD/3WNTJVPmX37bZn+xrVbG3u9ywtCHPW/IWT/hPSftn4qUKyCuD2o0uPSgGNvs8xNOxXMUEqnxYlt270bXfhYg1tx4Rs19Xa6P5w6Gcx3Akjr/6Rg+ayQ1AIcCXzEk/sXxrNwlwEx4+AZvsJzso9ToMGmY4WTa2BrbO+L3Tbgpq6Z2Z/kfjZjcMnP9XlOJiRiTx5hk96ApJhK4OiMDoRTVk4HH531200nAfSel6mkHQSPECBVhAuLKoaYoHcTG+I42fxKhR39HLdd4qMvHeeLJbO3muUZ4fwi4mROBia4K5iXmZXET2JkQBk/xvrvIm6mLQVDBv1tsbSXnr3gSCVaKdh8Mo0509jSVUM4Z5kLJwH5jIhi5GZLzEke7RW/c80a7Hi7e9GTplNBwc/mVhghIvnHrCEV2xGpCkX9z0FurJXD8dJEjLUsfB+wyV1YLr4EPoqg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eba6a9-3ce0-4f2b-cb83-08db789e9aa7
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 12:44:39.9524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQMmG6F1NTDjXdkmRs2Sgl/IECpbMK5dtXRYrl1sbLCZa1w/rBqDpreHAzyBbv44xw9k15iM/g6g7cf/6MyyJbxU/M8ICMEJ6/2DflS7viI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290114
X-Proofpoint-ORIG-GUID: lKCE04HtAn7TVuimcxkD9rq-IHAB7WlJ
X-Proofpoint-GUID: lKCE04HtAn7TVuimcxkD9rq-IHAB7WlJ
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/06/2023 09:40, Zhenzhong Duan wrote:
> This patch refactors vfio_migration_realize() and its dependend code
> as follows:
> 
> 1. It's redundant in vfio_migration_realize() to registers multiple blockers,
>    e.g: vIOMMU blocker can be refactored as per device blocker.
> 2. Change vfio_viommu_preset() to be only a per device checker.
> 3. Remove global vIOMMU blocker related stuff, e.g:
>    giommu_migration_blocker, vfio_[block|unblock]_giommu_migration()
>    and vfio_migration_finalize()
> 4. Change vfio_migration_realize(), vfio_block_multiple_devices_migration()
>    vfio_block_migration() and vfio_viommu_preset() to return bool type.
> 5. Print "Migration disabled" depending on enable_migration property
>    and print it as warning instead of error which is overkill.
> 
I am not enterily sure we need to keep "Migration disabled". Perhaps we should
just derisk from error to warning and use always the same error messages.

> migrate_add_blocker() returns 0 when successfully adding the migration blocker.
> However, the caller of vfio_migration_realize() considers that migration was
> blocked when the latter returned an error. What matters for migration is that
> the blocker is added in core migration, so this cleans up usability such that
> user sees "Migrate disabled" when any of the vfio migration blockers are active
> and it's not intentionally forced by user with enable-migration=off.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/vfio/common.c              | 66 +++++++----------------------------
>  hw/vfio/migration.c           | 30 +++++++++-------
>  hw/vfio/pci.c                 |  4 +--
>  include/hw/vfio/vfio-common.h |  7 ++--
>  4 files changed, 36 insertions(+), 71 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 77e2ee0e5c6e..c80ecb1da53f 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -362,7 +362,6 @@ bool vfio_mig_active(void)
>  }
>  
>  static Error *multiple_devices_migration_blocker;
> -static Error *giommu_migration_blocker;
>  
>  static unsigned int vfio_migratable_device_num(void)
>  {
> @@ -381,19 +380,19 @@ static unsigned int vfio_migratable_device_num(void)
>      return device_num;
>  }
>  
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>  {
>      int ret;
>  
>      if (multiple_devices_migration_blocker ||
>          vfio_migratable_device_num() <= 1) {
> -        return 0;
> +        return true;
>      }
>  
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_setg(errp, "Migration is currently not supported with multiple "
>                           "VFIO devices");
> -        return -EINVAL;
> +        return false;
>      }
>  
>      error_setg(&multiple_devices_migration_blocker,
> @@ -403,9 +402,15 @@ int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
>      if (ret < 0) {
>          error_free(multiple_devices_migration_blocker);
>          multiple_devices_migration_blocker = NULL;
> +    } else {
> +        /*
> +         * Only ON_OFF_AUTO_AUTO case, ON_OFF_AUTO_OFF is checked
> +         * in vfio_migration_realize().
> +         */
> +        warn_report("Migration disabled, not support multiple VFIO devices");
>      }
>  

Perhaps you could stash the previous error message and use it in the
warn_report_error to consolidate the error messages e.g.

bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp)
{
    Error *err = NULL;

    if (multiple_devices_migration_blocker ||
        vfio_migratable_device_num() <= 1) {
        return true;
    }

    error_setg(&err, "%s: Migration is currently not supported with multiple "
                     "VFIO devices", vbasedev->name);

    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
        error_propagate(errp, err);
        return -EINVAL;
    }

    ...
    if (ret < 0) {
    } else {
        /* Warns only on ON_OFF_AUTO_AUTO case */
        warn_report_err(err);
    }
}

> -    return ret;
> +    return !ret;
>  }
>  
>  void vfio_unblock_multiple_devices_migration(void)
> @@ -420,55 +425,10 @@ void vfio_unblock_multiple_devices_migration(void)
>      multiple_devices_migration_blocker = NULL;
>  }
>  
> -static bool vfio_viommu_preset(void)
> +/* Block migration with a vIOMMU */

I meant in the previous version to put the comment on top of the caller, not on
the definition. But with the new code structure from Avihai the error message
further below... it will look a bit redundant.

> +bool vfio_viommu_preset(VFIODevice *vbasedev)
>  {
> -    VFIOAddressSpace *space;
> -
> -    QLIST_FOREACH(space, &vfio_address_spaces, list) {
> -        if (space->as != &address_space_memory) {
> -            return true;
> -        }
> -    }
> -
> -    return false;
> -}
> -
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp)
> -{
> -    int ret;
> -
> -    if (giommu_migration_blocker ||
> -        !vfio_viommu_preset()) {
> -        return 0;
> -    }
> -
> -    if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
> -        error_setg(errp,
> -                   "Migration is currently not supported with vIOMMU enabled");
> -        return -EINVAL;
> -    }
> -
> -    error_setg(&giommu_migration_blocker,
> -               "Migration is currently not supported with vIOMMU enabled");
> -    ret = migrate_add_blocker(giommu_migration_blocker, errp);
> -    if (ret < 0) {
> -        error_free(giommu_migration_blocker);
> -        giommu_migration_blocker = NULL;
> -    }
> -
> -    return ret;
> -}
> -
> -void vfio_migration_finalize(void)
> -{
> -    if (!giommu_migration_blocker ||
> -        vfio_viommu_preset()) {
> -        return;
> -    }
> -
> -    migrate_del_blocker(giommu_migration_blocker);
> -    error_free(giommu_migration_blocker);
> -    giommu_migration_blocker = NULL;
> +    return vbasedev->group->container->space->as != &address_space_memory;
>  }
>  

nice consolidation

>  static void vfio_set_migration_error(int err)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 1db7d52ab2c1..84036e5cfc01 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -802,13 +802,13 @@ static int vfio_migration_init(VFIODevice *vbasedev)
>      return 0;
>  }
>  
> -static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
> +static bool vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>  {
>      int ret;
>  
>      if (vbasedev->enable_migration == ON_OFF_AUTO_ON) {
>          error_propagate(errp, err);
> -        return -EINVAL;
> +        return false;
>      }
>  
>      vbasedev->migration_blocker = error_copy(err);
> @@ -818,9 +818,11 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>      if (ret < 0) {
>          error_free(vbasedev->migration_blocker);
>          vbasedev->migration_blocker = NULL;
> +    } else if (vbasedev->enable_migration != ON_OFF_AUTO_OFF) {
> +        warn_report("%s: Migration disabled", vbasedev->name);
>      }
>  
Perhaps you can use the the local error to expand on why migration was disabled e.g.

	warn_report_err(err);

> -    return ret;
> +    return !ret;
>  }
>  
>  /* ---------------------------------------------------------------------- */
> @@ -835,7 +837,12 @@ void vfio_reset_bytes_transferred(void)
>      bytes_transferred = 0;
>  }
>  
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> +/*
> + * Return true when either migration initialized or blocker registered.
> + * Currently only return false when adding blocker fails which will
> + * de-register vfio device.
> + */
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>  {
>      Error *err = NULL;
>      int ret;
> @@ -873,18 +880,17 @@ int vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>                      vbasedev->name);
>      }
>  
> -    ret = vfio_block_multiple_devices_migration(vbasedev, errp);
> -    if (ret) {
> -        return ret;
> +    if (!vfio_block_multiple_devices_migration(vbasedev, errp)) {
> +        return false;
>      }
>  
> -    ret = vfio_block_giommu_migration(vbasedev, errp);
> -    if (ret) {
> -        return ret;
> +    if (vfio_viommu_preset(vbasedev)) {

The /* Block migration with a vIOMMU */

Would go above, but I don't think we need it anymore ...

> +        error_setg(&err, "%s: Migration is currently not supported "
> +                   "with vIOMMU enabled", vbasedev->name);
> +        return vfio_block_migration(vbasedev, err, errp);

... as the error message when placed here makes it obvious. So the comment I
suggested won't add much. Unless others disagree.

>      }
>  
> -    trace_vfio_migration_realize(vbasedev->name);
> -    return 0;
> +    return true;
>  }
>  
I think somewhere in function we should have vfio_migration_exit() being called
behind a label or elsewhere from vfio_migration_realize (...)

>  void vfio_migration_exit(VFIODevice *vbasedev)
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index dc69d3031b24..184d08568154 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3209,7 +3209,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
>      if (!pdev->failover_pair_id) {
>          ret = vfio_migration_realize(vbasedev, errp);
>          if (ret) {
> -            error_report("%s: Migration disabled", vbasedev->name);
> +            trace_vfio_migration_realize(vbasedev->name);
> +        } else {
>              goto out_vfio_migration;
>          }
>      }

(...) Which then void the need for this change. Perhaps your previous patch
(4/5) could come after this refactor patch instead ... where you would fix the
unwinding error path inside the vfio_migration_realize() as opposed to
vfio_realize().

> @@ -3257,7 +3258,6 @@ static void vfio_instance_finalize(Object *obj)
>       */
>      vfio_put_device(vdev);
>      vfio_put_group(group);
> -    vfio_migration_finalize();
>  }
>  
>  static void vfio_exitfn(PCIDevice *pdev)
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 93429b9abba0..3c18572322fc 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -225,9 +225,9 @@ typedef QLIST_HEAD(VFIOGroupList, VFIOGroup) VFIOGroupList;
>  extern VFIOGroupList vfio_group_list;
>  
>  bool vfio_mig_active(void);
> -int vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_block_multiple_devices_migration(VFIODevice *vbasedev, Error **errp);
>  void vfio_unblock_multiple_devices_migration(void);
> -int vfio_block_giommu_migration(VFIODevice *vbasedev, Error **errp);
> +bool vfio_viommu_preset(VFIODevice *vbasedev);
>  int64_t vfio_mig_bytes_transferred(void);
>  void vfio_reset_bytes_transferred(void);
>  
> @@ -252,8 +252,7 @@ int vfio_spapr_create_window(VFIOContainer *container,
>  int vfio_spapr_remove_window(VFIOContainer *container,
>                               hwaddr offset_within_address_space);
>  
> -int vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
> +bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>  void vfio_migration_exit(VFIODevice *vbasedev);
> -void vfio_migration_finalize(void);
>  
>  #endif /* HW_VFIO_VFIO_COMMON_H */

