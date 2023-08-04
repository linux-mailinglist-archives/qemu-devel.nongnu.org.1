Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CCC77026E
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRvMJ-0004Jm-Es; Fri, 04 Aug 2023 10:00:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRvME-0004Hk-LO
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:00:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonah.palmer@oracle.com>)
 id 1qRvMB-0001oz-Sp
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:00:46 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 374BxJPr012709; Fri, 4 Aug 2023 14:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=KdFfeWiacIpyUBkRFCLv46Py2Hkb25MycH9+iU3s5Ls=;
 b=eCITrFkpZRJ3Sd9jXr0E6GsuY1vItiCZkSGnxDJJDp2SLcjc6k8qUpa17+xLtzAYHItb
 /YdXsWArCxOF4Un/N+OaB48L+V/3TiWkU62Hk4fxNJBcOEacC5iWoRYe0znoHFCCGtpH
 MnrMWbyfA23kwJb1Q+zWuO2AIYIMn+1OZ/meFTHFpwT4YZ4HSPxDAkY8byQ65evjwIs6
 uojSIf6rsOmvMKxsR2WCfT6UYGW1i5u8JRwq22yaK3iNFNMcyWA0zgXzz6GF9IhIp/PH
 9rId19e4QnWb/Gs7ymwAmRIrvV0wFqWOgR7Ac72Xn1UR+1b5l57zLQxp2PskEKjhpiRT 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttdby39-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Aug 2023 14:00:40 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 374DHxIN035075; Fri, 4 Aug 2023 14:00:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3s8m09bxya-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 04 Aug 2023 14:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTKGydph4pqQoZUhvwjY87UaLsYXntLbQKf642fGorIISflkfn9eqM/l8IKZ4g4r4aDAB+WBn0Mxs5mLCMEBjTAmQ4HqC0515zVrt1LMnHy1yb+BzTWR7uMJEI2sO24Gp88mY2CyeChpjiyYH/3NtHZTtfKXcoRtOw72AIM4UQYee8AfhlvjS9WgJcpew0jZybI+4Gbjq00UuU4QfpOJ18C5XoZp0IgCOpTbDK26iUJWeTccTowc91rV8ZAm3xPkG/ziK+qoRyfgyYnnohFCymn1tRI/KwtaYxR+TOStoto/ZxYvMfUX4nhC1WM/DykTTV1uCHcejGHA1HUGUOzcxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdFfeWiacIpyUBkRFCLv46Py2Hkb25MycH9+iU3s5Ls=;
 b=FWPWszixERsAEcuBYTl1U1Ee0J0tCjC7V/Kl72hVzoaZmZJIi6QXBtbJbkJEMwNxIvcE66xMAGrrVY3dVIi//ToTbAKl+BrqZNARrQGH2Qg9h7njvK6/MtM5CR9bHwUYCtORVSZ6akbG1mehlkKrBEh9sObWRQRycPCeYSSR+I60IBlM66O1wOlFFgMxDunCUK2xcpDiRkA2UKEyh1wP/iF9BrR9WWMvtgszWxepXFkKOywlr7TP8R76KqWy+/AgSSKRP1664rNuJInmUgbuJV26InfMP3gGLGmrMaM/RsAfPkVg6rm05Y4zCF26JKOmW4ySg4JcRbuYC3GGPQgplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdFfeWiacIpyUBkRFCLv46Py2Hkb25MycH9+iU3s5Ls=;
 b=Sa3h8zqhIvsJ1taABBJChvnqslePRH4aiNxez4T3ctW6nCu1ruiV0p32j29z1XfsFVJxdol1Z6yQE/9u1wyK5zb61Jt5GgDGj3KB/hUkZoV3/3kevOZ5QTkTgzBx4pmWWj0PjherPEBOXmB6/MwfaibNLgILKj/yY51qa6whDy0=
Received: from PH0PR10MB4664.namprd10.prod.outlook.com (2603:10b6:510:41::11)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:00:36 +0000
Received: from PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::565f:a60:aaf8:bae]) by PH0PR10MB4664.namprd10.prod.outlook.com
 ([fe80::565f:a60:aaf8:bae%6]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 14:00:36 +0000
Content-Type: multipart/alternative;
 boundary="------------ffQylokT14IEFIUSQ1xc7R8g"
Message-ID: <05617559-ff16-7525-1d99-e412019f8c79@oracle.com>
Date: Fri, 4 Aug 2023 10:00:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] qmp: remove virtio_list, search QOM tree instead
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, laurent@vivier.eu,
 mst@redhat.com, boris.ostrovsky@oracle.com, alex.bennee@linaro.org,
 viresh.kumar@linaro.org, armbru@redhat.com, pbonzini@redhat.com,
 eduardo@habkost.net
References: <20230803145500.2108691-1-jonah.palmer@oracle.com>
 <20230803145500.2108691-2-jonah.palmer@oracle.com>
 <ZMvCPyQxQPi58mmM@redhat.com>
Content-Language: en-US
From: Jonah Palmer <jonah.palmer@oracle.com>
In-Reply-To: <ZMvCPyQxQPi58mmM@redhat.com>
X-ClientProxiedBy: BL1PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:208:2be::13) To PH0PR10MB4664.namprd10.prod.outlook.com
 (2603:10b6:510:41::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4664:EE_|CH0PR10MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: c5605683-60ba-411c-7dd2-08db94f32d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g+7GBGqd20yOIeH4oZtBqNC9p7P3yEd/qHfXZJQ/odgyD1xdT6whljp4VWLdoQruDwQA+LzAJml2MhyW7M6sjdLHXKXJunNe8hOa0dkS4CVDXz1MzSZ9d9Ha9iNujMFEC97RfPBGM4OgpdUQf4EKD2wJsLBOQl6b0DSgR8DSLRee4j0M0N6hOtm87L/gxqzuyd7BefKCYd87i2jj3YD6fllOKVAakX/cm425IVk2gJLa8G9At4Focjj0VqfGMDCTfqIyDFcRCZSG45inZIEFyc1UpZzBSwvMU4LQupqApHVpnC2xw+4JV+nVT1El63GNH8Seq4bgdE6M3D8jA6oh4m81JMBkP0x/eaPUp44FxwP+DM62srMLQKgnXCr+80aCKuZuC4i+ZKAzpauOeHNEZAoafNufDXFeQ7O2Yug+EjWAiusBiRFvsScbnX2uaZm8S84U18HU07s4RJvbCbJO0Ik4sgwYkHQm3fPP5PGrquh0WJ9FKGCy3eyoYqaXBWoF1F2u2MrtdEvvStmh+3ao8pDmJ/8A4dd0dRdVPQJHdi5IJhEULmwowbrdx4GL8EqWEakwvxPC5MyFQ83avj7O7FcIePliEOWjyVuunPj2s00nnubkagTrKgAZWTskf4uL7ye+wvdkn5LQ5wnvjtXSSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4664.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(346002)(366004)(396003)(39860400002)(186006)(451199021)(1800799003)(44832011)(66476007)(66946007)(66556008)(4326008)(6916009)(2906002)(38100700002)(2616005)(53546011)(6506007)(7416002)(83380400001)(86362001)(6512007)(31696002)(26005)(478600001)(36756003)(33964004)(6486002)(6666004)(8936002)(8676002)(5660300002)(41300700001)(316002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU1nanBtTi9Pd1YxM1RobzUrYnU4RjQzdE5QellnQkR5NnF1c01tSlA4TGto?=
 =?utf-8?B?emZhdmthOG03ZjVKb2swTGk0bVF1bVBVZHpPZzhIcUtaelVLcXA3NWw3V21Q?=
 =?utf-8?B?OHBkOWhLajVZVjhoR1BmOTlPNEVPOWFOTkd3bWxaWnpLaVN0RlAwc0ZrVzZQ?=
 =?utf-8?B?cFJwNlRSb0luTzR0enMwTGZtVW5zcEVoMFRGS1JqRHZEdWYwOVRKenNqU2Rj?=
 =?utf-8?B?OHlLV0ZwQWRYRFI0dHRMNm41ajMrWk52ZFAxRmZKOGJ6bStTZmFJb0JMYzZi?=
 =?utf-8?B?SytvVFdOOVV3WVZtOXdKdVFUT1JhY0VEclRDdkR1WXNSRVdGenNES1FiTEs2?=
 =?utf-8?B?WG0yNDdMZE5MSElGeGI2cnpIYlpLMGpvMnNTbkd4TEFjUEpVK1hOKzlwcUMx?=
 =?utf-8?B?UlVLWnZrOWpoaGoxYkczZnhtWEpmQXdjVi82S2d5L2VRbm9qM3FmVkY3VTJF?=
 =?utf-8?B?TGtmU0NmaWk3aysyYjFHWWs3RlpURjYvZmczTEVCQm92VVltcDBPUEZPeVJB?=
 =?utf-8?B?ektXOXlYMTVPcS9SMkIxMUdXS29IRlM0ZTMrT3RYWGFUYnZITll1RURnR3lx?=
 =?utf-8?B?RGlndDhROVRTY3VkNzdXdHNaSnpzNWR2ejhDZ3B1T1JWTlVWa2ZGSy9qbTFh?=
 =?utf-8?B?YUoweHg5YUEzUjRuYzZlaktZTkFHcG1GM3Y3cG1PelV6RUVnUWp4c1c2RWhJ?=
 =?utf-8?B?dDBreTI4RndKUFd4NDNuYlFUYytjTkRURnhXVzYxcXczSXVqVytLL2NhL3hL?=
 =?utf-8?B?WVRGQm1qK2JETlFkS2ZtU2lJb3ozM1czMlZEcUhkTzdqYkx2bmw1YzNEclR2?=
 =?utf-8?B?MGY5cndYUUl6S3VnUXlXYndhMDczWlI3Tnp4UHpQNlhtaHllcmNPaTJndlU2?=
 =?utf-8?B?bUdqUndOdDVMbi9kSkhheVpBSDA1dlRVM1hpa0VocjY2Y1o1VmZLWmNuczRx?=
 =?utf-8?B?amxlT1I1ZTVENkpRRXc5a3hHMnEyTHhoaEZDOHpjVmRaMGsydnFrT3FpUk5W?=
 =?utf-8?B?YWhmWk9yRzlSUDViSFVpWHo2UUlOYW0weCtDNSt1c2h3VjBxOTluUDNzWTNP?=
 =?utf-8?B?eVgyV3psSW1HVFFJVVNQQ1FRVWFudEJIQktIS0tncCtXSHhSSWxTcWlhUnB1?=
 =?utf-8?B?Ni9EYzNEdm9QZlVZdVNpMVB2SlMxeThJWWIrcGp2eFo2VWR5M1hoT3Z5Mzhi?=
 =?utf-8?B?RzBjTFlFSHdTSk55QlppOHRZR3VsUStyWFN0S1RnWFlTZHpNZ3laLzd4ZWsv?=
 =?utf-8?B?V09yRUZMbXRJL1JtSGZPa1VkQXl5aS9YVngvSW12RlIvNXlCWnpBSFYraXhs?=
 =?utf-8?B?eW5YcjIxdDBwalhaVkVjc2s1NFQzcWRGT2hEMlBhaWVUdTA5bm9jYWVzNXlD?=
 =?utf-8?B?QmNMUnl0VFJxNDhXT0VwOEVKYUpYVzJidTNDdHR2cnFkbXNuUUkzaTVvQWs1?=
 =?utf-8?B?a1E5eEwxcFpoUk9hV1M0dFg2MnpwZ0ppY2wxSGIzbkxJT0tVY2tlY0xDb0dn?=
 =?utf-8?B?ZnhSYWxYMno2ZTF5STlDbmhCNDNXVEkwUTdRY2t4MXlKaHczTlg5Z1psbncy?=
 =?utf-8?B?SnFnRHI5UzhIb0Fmcm5Rb0h2R3JIc0dtTk1VcVRqbHF0YmVodWN1VGt4YjR5?=
 =?utf-8?B?MlN5M2lhbzRsTnV0bXp0RjBTTk5BNDlrbFB4NDNFM2FNTGFBUkZnNld0TG8x?=
 =?utf-8?B?QWRCa0czRTg3dEV4dW9DcTdnbG9FNHNONkMzaFpRUk93cUxWazNWZjlpdmxv?=
 =?utf-8?B?QjZWMldramZWTWhFL3ZHQklPYWNEWHh5ZmhXRytFNFZ1R3RVa2N2SHpKRzNI?=
 =?utf-8?B?cjE1ejdoTFV3Q2F6amRlUFB3U1dzTEdnWGNHUUxzL3V1RUFtRFA2UUdPSXIv?=
 =?utf-8?B?Y0tZWm1lNCttSkNIY1lBOSsvTDlqTlU2Y2xrazk2UW9uU3lVc05oZnJHdjY5?=
 =?utf-8?B?N3BZWDEwVytYRmNGR3ZmY0tDaDk2YWx6eWsvbDZPU3ozRXBUWlhKdUxwTmcv?=
 =?utf-8?B?UWE2N1NWUU9EVW1mMVlPMjlEeWdGNjVsVTdUWWsrS3BlTWQ1ci8xQnZWM01N?=
 =?utf-8?B?ZHFHQWhxVlhoWExBZHhTQzg0Wjc5TWg3SStIa1l0L0RPZU9HRkhLWFpKN09z?=
 =?utf-8?Q?g0sYGn4LjA/CIuETYi0fJF5hc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IBnC5jq3oBFYQw9u9vFfJT3P6aZ9NkcN6m+CJcHfLm8NGU9klbim0NyKjHCSEgTfC6jQhuoPShNLVZJ2xhlR1plZXJYp+W/JBVY8pgyBs6Kt0bwDLKhTz4sTtuD59kdt93+C4EOJxbEh9IQvOJRvDCzFR4hhzHxXXmTiHD/NSpnkDsSZ10GsO3j7iafssZK81vlr9v57dS8mUx1+NMJek5fLAoM0dKFU8Lrvo0Hl5AiNYiw6S5/xfiUETK6l1JV7A/lhbjfx8vQY5jgs75og4YoUYq0/akvqmwScB08ufICoCY1jPm7aWz3Y73pmRrub75ZUY2MUPVP4DksTXh7Xte38wvmcOvv5o1eJcYVCMnFZpZpo2nM7ia6voYbt+H8sX4PmCCeIcyuNbbeJrJ+Wb8h9M9sFX9kBCmpWFAv3eN6GQG7MYyAgXZGLmHcWOiru7UJ/uqvHnXP4NJcqhG7/v7Uv0tjAuOEd7os3nWY7FIqa2fVbkJHwfpc9fI4OB1h9lhV9RGR1SttHylRYsgOZaA6aI8iVcKEc57gj8GF3eUxRy0N9RHIAjB2OttZwQgpwuss87DIPWz9pp4RwWc8PBZp6+9jQCAS01wJRKg36v0ZIGD7UC96UUOFBaHucL0soM26IM/jk1xxW475aXddbO3hvRsZIOpWFcqdZyHKMonDGRavEB34rlszSHNHhISSVFEygpKEM2a5MWolD8EflafZ+Xow+sNo8zxTBExhaNYwCE9CMHzFyehAyvzcRW4D4t7aYgdAc7O2fdb1Ox6c1jnkbC4vWkbDNXL9Ytt6jK4ZBzcWVkYD9/F6takS1rSqy4ms7oBP3/NqGYQCN0cXJVYydWE9uVrWB5HCjeycWctk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5605683-60ba-411c-7dd2-08db94f32d25
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4664.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:00:35.9972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JusgQEkq/CAln33cnuu0QDoNxrdYrL0QMlufoWqSnkxlgIoRtkxihiEG7iY5orHGFa3VvZ4RR8wQLw0toL0sAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_13,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040125
X-Proofpoint-GUID: WimkO2VHW-IhvuQvXUhtZRrmmesXASTH
X-Proofpoint-ORIG-GUID: WimkO2VHW-IhvuQvXUhtZRrmmesXASTH
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=jonah.palmer@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--------------ffQylokT14IEFIUSQ1xc7R8g
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/3/23 11:05, Daniel P. Berrangé wrote:

> On Thu, Aug 03, 2023 at 10:54:58AM -0400, Jonah Palmer wrote:
>> The virtio_list duplicates information about virtio devices that already
>> exist in the QOM composition tree. Instead of creating this list of
>> realized virtio devices, search the QOM composition tree instead.
>>
>> This patch modifies the QMP command qmp_x_query_virtio to instead
>> recursively search the QOM composition tree for devices of type
>> 'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
>> realized.
>>
>> [Jonah: In the previous commit the qmp_x_query_virtio function was
>>   iterating through devices found via. qmp_qom_list and appending
>>   "/virtio-backend" to devices' paths to check if they were a virtio
>>   device.
>>
>>   This method was messy and involved unneeded string manipulation.
>>
>>   Instead, we can use recursion with object_get_root to iterate through
>>   all parent and child device paths to find virtio devices.
>>
>>   The qmp_find_virtio_device function was also updated to simplify the
>>   method of determining if a path is to a valid and realized virtio
>>   device.]
> FWIW, this "history" would typically go after the '---' but before
> the diffstat, as it is relevant to reviewers of this new v3, but
> doesn't need to get into the permanent git log once merged.

Yes, you're right, my apologies. I'm still familiarizing myself with
these kinds of things. I will move this comment to the correct
location in v4 so it won't show up in the git log.

Thank you for the clarification!

>> Signed-off-by: Jonah Palmer<jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/virtio-qmp.c | 96 ++++++++++++++++++------------------------
>>   hw/virtio/virtio-qmp.h |  7 ---
>>   hw/virtio/virtio.c     |  6 ---
>>   3 files changed, 40 insertions(+), 69 deletions(-)
> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>
>
> With regards,
> Daniel
--------------ffQylokT14IEFIUSQ1xc7R8g
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>
</pre>
    <div class="moz-cite-prefix">
      <pre>On 8/3/23 11:05, Daniel P. Berrangé wrote:</pre>
    </div>
    <blockquote type="cite" cite="mid:ZMvCPyQxQPi58mmM@redhat.com">
      <pre class="moz-quote-pre" wrap="">On Thu, Aug 03, 2023 at 10:54:58AM -0400, Jonah Palmer wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">The virtio_list duplicates information about virtio devices that already
exist in the QOM composition tree. Instead of creating this list of
realized virtio devices, search the QOM composition tree instead.

This patch modifies the QMP command qmp_x_query_virtio to instead
recursively search the QOM composition tree for devices of type
'TYPE_VIRTIO_DEVICE'. The device is also checked to ensure it's
realized.

[Jonah: In the previous commit the qmp_x_query_virtio function was
 iterating through devices found via. qmp_qom_list and appending
 &quot;/virtio-backend&quot; to devices' paths to check if they were a virtio
 device.

 This method was messy and involved unneeded string manipulation.

 Instead, we can use recursion with object_get_root to iterate through
 all parent and child device paths to find virtio devices.

 The qmp_find_virtio_device function was also updated to simplify the
 method of determining if a path is to a valid and realized virtio
 device.]
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
FWIW, this &quot;history&quot; would typically go after the '---' but before
the diffstat, as it is relevant to reviewers of this new v3, but
doesn't need to get into the permanent git log once merged.
</pre>
    </blockquote>
    <pre>Yes, you're right, my apologies. I'm still familiarizing myself with
these kinds of things. I will move this comment to the correct
location in v4 so it won't show up in the git log.

Thank you for the clarification!
</pre>
    <blockquote type="cite" cite="mid:ZMvCPyQxQPi58mmM@redhat.com">
      <pre class="moz-quote-pre" wrap="">
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Jonah Palmer <a class="moz-txt-link-rfc2396E" href="mailto:jonah.palmer@oracle.com">&lt;jonah.palmer@oracle.com&gt;</a>
---
 hw/virtio/virtio-qmp.c | 96 ++++++++++++++++++------------------------
 hw/virtio/virtio-qmp.h |  7 ---
 hw/virtio/virtio.c     |  6 ---
 3 files changed, 40 insertions(+), 69 deletions(-)
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap=""><pre>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>


With regards,
Daniel
</pre></pre>
    </blockquote>
  </body>
</html>

--------------ffQylokT14IEFIUSQ1xc7R8g--

