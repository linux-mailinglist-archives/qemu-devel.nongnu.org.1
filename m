Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BB073E54D
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:37:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDpDL-0003Vc-1h; Mon, 26 Jun 2023 12:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDpD3-0003UH-VD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:37:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qDpD1-0007gI-5d
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:37:01 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35QCV719005302; Mon, 26 Jun 2023 16:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4e0ICd10qKxJ4aWOMY8OtZBVn5gFG34fXnx5oecaCLI=;
 b=wAjOUzW0Ij9bojBTXecFEro6SdvnkVWYR5OcU6oMDFZtJun4pWbPCpMq7+K/cp20He33
 s51XjF/9X3B7+ilO2dlOpCopxEMYkoWSBRKrf7gPvQ70jEC2xe1k4QhSDAin+AcdKxAY
 OmWG2fOc693IuieFUlFMCaAm7kppAp9RWIlbnV1pf+dLR8+RAeKWMZkkeuu+xImQITE/
 bDI1U2+8GToj9w8HwETiwIrV5mwywMCX22YkxV8morfSB7Ns6bYl3aDZIoInKJRJzUfc
 YuD5V8tjV3HzUVTvV1RBDpMnrXfZj3IzSi0Cmz6AK8cSSITKgbUSzDNALRX0cDjSA2TC Zg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rds1u31t2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 16:36:55 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35QF93Mx005087; Mon, 26 Jun 2023 16:36:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpx9b6rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Jun 2023 16:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k4HOKOP4ge4fvfNUZhUh8E7q6t/PgijkIiH1Wh4u22lgA2ldldgOgP8F9ggByqpe/FK1CC1s6aToKcPyxeicElFivmrhzL8ogdxqH1oD49lYqFaHo/nJNEW6fSeGrvXU0diFrX7lDZP5St812sFesH3jIfykcoiKVCHQww9x4vFNKweTsxPlnb+KRXLAMcUQROHC63FzC5HoFLyl5fsP6KlQO1X+/5wwdZ44rti2C0t/umjcUKRoBSyP+3+mMLcQdILKV8oGamTs6/7RO+QRkErUugPhUB8bQx0jG90t9u6Vwv62u64wd5/aisXJ41CJ7CBSibQoez1cKKYaeh44Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4e0ICd10qKxJ4aWOMY8OtZBVn5gFG34fXnx5oecaCLI=;
 b=cLZGOcRTRaXvBAme5ugLeXR+X3brk44ctGAhLLePf7JmCwSs9CW2+7DaNknTVvXk2mQCmroQeEgZ97fQ5ZMr8fQAhN4lBtXm/3KI/pJr71l6DSBQYcDvtyhW2UHiuS6MxMCbbuZ8t4965dV4EKiXMjDfODcts/xaS8vdQVDGuYC3K9PACsxsv7ArrmwVqZ/tJjIJ8SpjCGrphSeIdTscqAwxSLY6iM0rV6hoKMvIpcaRZgXWBUZHE0UgVYBwL+shv3AHNhKH9m/nKWOaogGTiER/OjnkNq6V/oJJ6c5woF28r7MAu9O9U131IehylZkxS9o4bU75c20nWM3lb/MeEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4e0ICd10qKxJ4aWOMY8OtZBVn5gFG34fXnx5oecaCLI=;
 b=auNQiaypWbywTZpsZXNVNfPuSZhb7aHYXhE3huFCM9NEB9ivwK2BILV0hw/SrGh9SRw57q5x80O1m9Vs+kCoYoX2aY2X+QFd+et69kk+Ze8Qs4BX77OT8etQOqdHDBTFLizPAaBR6dRGg6oFL6L9b3Tarcr2yAdMcdIYVwtFDRg=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SN4PR10MB5621.namprd10.prod.outlook.com (2603:10b6:806:20f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 16:36:51 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%5]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 16:36:51 +0000
Message-ID: <e0b267ee-680c-8ee5-a601-623bbd3363bc@oracle.com>
Date: Mon, 26 Jun 2023 17:36:43 +0100
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, qemu-devel@nongnu.org
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SN4PR10MB5621:EE_
X-MS-Office365-Filtering-Correlation-Id: 18b54cc6-80da-40eb-6c61-08db76638b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i1uWIzqXkThDnJfZtJVthDtNhdMQU9Z4Bc3hO8UJ0/VWIZw9O/m5LnwWhgrsjJUZpVAzuMOy66vrrYAbV4z6Tn9HQHdoiZ86Ra8LVxEjZh617Q4CN7au3hQteUUQhZr9yXVaJICi25YvkilXCjzxMuyvDzicNoVZ97tgf2zm4xLojLnJTKK5FuFoUh+A2X5aORxIqz/xFy+fP6CBsO9Hgn7LuTmoW2T6JDrw5JmmMlwqJzUqFh0qWZmTmvX+162CR8WK8qiqeAB0sKFg1iHzBBBKoS1dqPm8Ln8+l159o3N++sGpVw3iw8/Br4UBDH0Rq4tcR9mj2INoha+PJaalHOsMhyHzwtb+rmEjI09jo8YmQyCNpm+/QeLBDnxHlffxKV8Qtv6HfgfwRNzq5n/CZhjQdKSzTDSF/RzbG1Uee+N7XeHhU4GVTMahqpqDAR9MQsPIj3KlbJtc67lLBshdO6T1TyomIdI8fboYTkC+5S2E6KbVHJd2+T0IuzrUeC0cZ2Kp2Ci+Q+ToShhIMuvpdFM2xd3MuSeTKeOHmnw2iNGRwWwGP9vAUxUsD/3hqRlO9IM/H0WxMGtFfQWOVP18kWxcUwueSe/lIKLKVG9QzGBQcm6mowBOMcmSFkA8OUks
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(376002)(346002)(136003)(39860400002)(366004)(451199021)(110136005)(6666004)(6486002)(478600001)(54906003)(53546011)(2906002)(6512007)(6506007)(26005)(186003)(66476007)(66556008)(66946007)(7416002)(316002)(8676002)(41300700001)(5660300002)(8936002)(38100700002)(36756003)(4326008)(86362001)(31696002)(83380400001)(66574015)(2616005)(31686004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXpDYkI5NnFYS2xOZHlpQWg3aUZoM3ptNVFPSGFLcFMza0xiMnB4YUVJREJa?=
 =?utf-8?B?ZCtwbjN6UWxZQUVjbnVvaWF4SDdzQ3FYQXhrZlVZUU0wZndaSmdWb0VUTDkw?=
 =?utf-8?B?eEtQKzdjYk1Nb1g0Y3UrODZzRnFMV0NQS0l2MXMzWUV2dm5RTDdtSk95eTgr?=
 =?utf-8?B?dHNCcnhqU1hMKzMvbVRHYSsvdWxaeDVCQml6NEdRU3RrajNZUGFUSmdnQ045?=
 =?utf-8?B?ZnlqNlByL0pqUm43c3RSOEl5STFUZCsrYVUrQ1RZMDZmelh2RmxNMTh3L29o?=
 =?utf-8?B?WFcrb0pZMENOTXRUODFMZGNPUGJWN28zWWU2clZCSDMySTAyRDQ3a3k2aXpT?=
 =?utf-8?B?MUZMNlhUaEE3dEQyUk9CU3dNUlFJejA3Sk9BbjlJOWVKdEdIUjI5Q3BqblBH?=
 =?utf-8?B?ZW01V3EvL2c5NGdxMVA4aXAyU25Va1YvVkNpK1RmL1NGeGRSZ3Rad3BsNlVR?=
 =?utf-8?B?NC9SWFNWMzRmaUgxTFdmcFBCMnZGUzBuVkpycHdGM1BDcm5yRDRGM2pYOURU?=
 =?utf-8?B?aUdldmVmOGJwZ0RvTFppNUVRNDZINFFrbGRNNmdwYjY5czd0VzZRRDREM1NX?=
 =?utf-8?B?NU5LRjJsWndmbzArNG93SE4ySWFpTEJ3L1pBdVY3N2UvUVM5MWVFY2Fzb3Zj?=
 =?utf-8?B?M1U0QnE0YnA3MGh2S3lobVdqNFpCay9BZTJJSklLMkxGL1dYOElweFJlRkN5?=
 =?utf-8?B?YjlYdll1UW1yNk9ka3NSd0VqSTM5d0dIL2xXUUIwNUE0VVE3ZlNmcC9uZW0x?=
 =?utf-8?B?RGpSZC80QjhiQzloTjdxZUxKcE1nWmk1UjZlZjN2MGYyUG9SckxrUzBpeHRQ?=
 =?utf-8?B?cjVMaUREc2lBY2FFNVNoaHpHeDUxYW1CZUF6YmJ3TitvN2JlbmdORGVQNU9P?=
 =?utf-8?B?eUM2dWVTRElJTEpNcWlKSUFCemlGeWJjR3Zib0QvbElVOFBpb2E2dk5NeG1y?=
 =?utf-8?B?b2NVa1Noblk1Z05aNi9PUWhpcUU5Y25KdzREVHpxUkJodjRieE5ZUEplSWYx?=
 =?utf-8?B?cXJUUmNEVUFyRnFLYjk3ZmlNYjc2VjNUYWNacnQ3WDN4UTh1Sy9ya0dTcWdE?=
 =?utf-8?B?R01XNW5ySDQrR0FoNXlLdXJlMjBtVHRoVi9jN21KYWhBeStEWEdQSm5lUVlM?=
 =?utf-8?B?Rm9GTElYWFAzbDVtYkRkeXhZVGhLQnlIalNqT2xzNUJBWWRxd3pqR044SHV6?=
 =?utf-8?B?M2FnRnV2ZnZHUnJuTWZNVXlpM2pTKzkzWFpRb3ovaE5FTytUYVpGNUpveHpY?=
 =?utf-8?B?VE1GbEl5UXdnbWZKUHAyMEpIRnhCNEdzdXRxUkkyS3cwQm50cXRPekdCSGhH?=
 =?utf-8?B?M3lFYXg5eXpFME1ZK2t1WkI4S3V4VHQ3Ukc5cFdGZUt1ZjJkdEpqUks2Tm50?=
 =?utf-8?B?bTZiZEl1M1liaTFLM1JiRnhQak1WMGVFdFFlckFLbDhvU0RHSUY5Ty9BelEx?=
 =?utf-8?B?Q1YrajlkbEtPNzkwZkU0MWNvclNrQlg0cDY0VVJiY0toN2ZjaG56dFZyc0di?=
 =?utf-8?B?b3IyaDc3V21pekZLNmdXWTRKc29oYmx2Y21vSVBnSVFkRWZWVUpXUlhQOGtw?=
 =?utf-8?B?TjJlU2dKcGs1aTJORWhPWStHRGpFWFhVMEhES1NCdlM0MzlMcXVTU2cvVytM?=
 =?utf-8?B?TEYyZnM3TEE3cDJvMFZMRFRkT3ZKQU4vSXZMSFN1dzF5T2lhaFQxbTNlRGVo?=
 =?utf-8?B?VVZ2MG43REs3OGc0cWN5MElyd3d3S1RIb2FPMmxUWTlUeEc5c0I5bEVOTS9M?=
 =?utf-8?B?WVVKOVVxa3Z0Snlua24wSGJ5MHNBY1FIVDRobzlwd04vSURNckU5NlJGaHNN?=
 =?utf-8?B?ZVNLSjhETC9WMXRESmNwcGJYbjNuTkdUYmk5NHRPdVdQM29tMzhneTBQUFVV?=
 =?utf-8?B?RFpET0hlcm95bSszTytJMHZPdnAzV0dEczE2TE03NHMxZ2YxM3RzVHNWT0NJ?=
 =?utf-8?B?aTJRMnBYUGlzcExhOEVVUzF3UHRjYTZFUlJxWUhKRVZ0TDJmQXJHSHJlMTZV?=
 =?utf-8?B?S1ZOS0tVWTdKOHhPUTZ1T1BDeGFJTmRjTGtWdWFSTVNib1dNcGdDRGRwcndX?=
 =?utf-8?B?V1VmcUZvK2dhQTMxSFRWLzhMVjBQU2REMUdramRMM3RKSGJxdjdHUEduZzFt?=
 =?utf-8?B?SkUya1BBRms4T0JwSzVid09NZUdVL3k2ZVNhQWljQVVsWWxXY3hEU0VjWXFr?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: s4O45b7EAUd3Ye/Of6ioRbw1N7s2W1e5vXZ7ri7mKajvUWyiiTAdfcYO8f4VcsZMqliPsJiUBzHGpts91FgJ6l4ZNEu+MWyaQ0ABCRRgyExzFs9unOnR85TjFyf3QyJAgCzkeTmeQjy9JO4GwTTZsHeWbEju9L7l8gGKg7/X7a2Y84Ho2j39GDJ2hu196/JisRtSWlwCru9+m7DVygZU+06sbM5mlR+j1ArFvEXEgGXM9K+sa02BXnuCjF2WOG42XCqowoW02Ki6QG6AA22aMkhzj4s93cOm7K76yifB2IeP4bhZ6+SRD+l8bwZA4Yg53+c4TzuvGOL7yfLm0GJH6HzL7PXVQQ54s5WPftJfEQHcGbi7CjevXflL44QHcRzTC1yt5Z4jeuIpzKvVyJx8ZU5lN7IRek4ddJOoc8l+y0U7j17T7KaS91PummiNiZz43zuKVLyxGAujyGbfOFVYBkddundVqXblnfzQFb+Tgwo8ordIt4Fd4qfwFkI57sVr7DOzT4AhIlI/IDI2LcrPpvImeX4YmFJSmBnWfC7DU7wlQkBawvf2dcPQFBHOgaIdxm4ba33HARIczuuHnivC/04MP/YUcCadwqYt606IHM25Nw47+00omG2EIldriQq0zu5SkIFFEI+8Kz1GDsoRq3lYkrkecmRBzI2NgX5JMOqCYBNH0rUOFhhk6zwCIovo8vzl33G24moi0zBO82EW++JpAvd3iIZa+2l0dWS46/Ptrow75cBIBfKBi5ZiLKIW9RLd9neRWZ91c4vhSX7/thMDJs9u1cf3AJFyOc/BZIC9T82fYgAqceCK7VrjvAPNtwMZRtlGCG7cZIFwnxOJSQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18b54cc6-80da-40eb-6c61-08db76638b69
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 16:36:51.7614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c19/1mmUgrlI0XDucPU6qRSUBZMMXB7LlFmgBA4oSau14pD3n3P+/bmPFAHmgl0LeMcYSoNsc3/+vP+ZUtX12moAqh0bFygSdqGaZLRQfbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_14,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=909 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260151
X-Proofpoint-GUID: 94yxa4hcHvmVoJDQpwIrsKziYHhTj-7S
X-Proofpoint-ORIG-GUID: 94yxa4hcHvmVoJDQpwIrsKziYHhTj-7S
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 26/06/2023 16:26, Cédric Le Goater wrote:
> On 6/26/23 15:40, Joao Martins wrote:
>> On 26/06/2023 14:20, Cédric Le Goater wrote:
>>> On 6/26/23 10:23, Avihai Horon wrote:
>>>> +        error_setg(&vbasedev->migration_blocker,
>>>> +                   "%s: Migration couldn't be initialized for VFIO device, "
>>>> +                   "err: %d (%s)",
>>>> +                   vbasedev->name, ret, strerror(-ret));
>>>> +        goto add_blocker;
>>>> +    }
>>>> +
>>>> +    if (vbasedev->enable_migration == ON_OFF_AUTO_AUTO &&
>>>> +        !vbasedev->dirty_pages_supported) {
>>>
>>> I don't agree with this test.
>>>
>>
>> The alternative right now is perceptual dirty tracking. How is that OK as a
>> default? It's not like we have even an option :(
>>
>> Maybe perhaps you refer to avoid strongly enforcing *always* it to allow testing
>> of the non dirty tracking parts? Maybe when you 'force' enabling with
>> enable-migration=on is when you ignore the dirty tracking which is what this is
>> doing.
> 
> 
> I see ON_OFF_AUTO_ON as a way to abort the machine startup while
> ON_OFF_AUTO_AUTO would let it run but block migration. We would
> need an extra property to relax the checks, else we are hijacking
> some pre-existing option to fit our need.
> 
OK

> Since dirty tracking is a must-have to implement migration support
> for any existing and future VFIO PCI variant driver, anything else
> would be experimental code and we are trying to remove the flag !
> Please correct me if I am wrong.
> 
My thinking was mainly requiring the default migration case without any relaxing
from the user to require dirty tracking by default. hisilicon driver is the
current vfio driver upstream that doesn't support dirty tracking (neither P2P).

> So, the case !vbasedev->dirty_pages_supported is just an extra
> information to report for why migration is not supported. Does
> that sound reasonable ?
> 
We can always piggy back on the x-pre-copy-dirty-page-tracking (which already
exists too) as means to relax this option, and that should cover this other
case. My comment was more targetted at your suggestion of making it optional *by
default* to not use the dirty tracking.

	Joao

