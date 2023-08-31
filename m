Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5849B78F4DB
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 23:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbpZV-0008Cg-C7; Thu, 31 Aug 2023 17:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qbpOx-0002wU-Vb
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 17:40:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <william.roche@oracle.com>)
 id 1qbpOt-0001Cw-96
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 17:40:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37VJ4Dx4016568; Thu, 31 Aug 2023 21:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5l2G/vZsiAO4ZpTTKDl+mx3/ZvUXjo9o6WiJvzBkPBg=;
 b=BJ5EkYgRlcagMdpMzWgDDYTQ/q4WFHfEHhVcMlL1fC8Q1TozLq7jMossRJCiaRkjXSoy
 87boZaLxv/fqGGGpg/ta8/vsrXjS64TDUfMtkgoj8NZdoj63gIkTvKtpn1TF7vU7o3DS
 piQ8nDF/XXIakfGctarcRB+JmKn+wUfDL5+oZJpO5+hmxH4PbVccOKqAq1xfQl9XsKQl
 /koVzE6tJKiUerdQHA3pUe4VOiyunsxpeHOj45ERmypccFhaPOIVSXUSZLgRTdZoL0Fr
 mTAKEhDSMu5rl0fmygiXUNC309q9pT6orx0ntRIuJmgxDpwrvy4H3FbgmSpMShVT2hNK DQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9ge2rcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 21:40:19 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37VLU3uq024314; Thu, 31 Aug 2023 21:40:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6drj047-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 31 Aug 2023 21:40:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtTTSzTijFsuV9j5QmT67DCYr7vEYeZ4pdweZ6wp3TDx8X0MmWop/x5VtaSZDTDizvZjV6gXj7mGK9uiNhELJjEDX6hB57CcrUEciTqavJsG7ANwwZYY0Zfu6DIEWadsu3P5XkCXTFsu434lvKKKLcyZ3bC8cObzDJhQZGWYAUv+ksJDCLyj0ZrTBwOHxdJ8PGVmnPmaS3F88+Gpz+GGMEm8P24uB0PX/uwLbcglL774TA9BtnhsjxpjH+pIbRzNvD/bR0p7pz3ZavU6psCn0F/P8PtWpIDEIMdcRBmVCYQ2o/ZNqVbExM8Z9FLvE6PCZ4Q0f7CXAB2pBB2yv8urvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l2G/vZsiAO4ZpTTKDl+mx3/ZvUXjo9o6WiJvzBkPBg=;
 b=d6XoyrJbkaJA/qur2qYOJAcESouW7KX/u/XyGBYQWSrc6g1+3mRaH+x6NeMlDYO7L0w9aYhADMwPFCeHFbtuoB4vhjukwR8ZXcycDzh1oVSDLb9M/L25e9ELb44HxlrpDsXz+Q1QhU2XcVB5G9s90iwH1lOjlJzgiXp8TPVIpiZfgPDLvSNTVt8yHqEXEYDu7YoF1FfcnCMCVwJ/jfhUBfF4Cw7d7/WdYTQtBDtV47lTPLSdLQ2wAuTD6bigvDSk/GBJ8LhB7QX/MoWCtM0Q15y6sTO4+8BF/nWmt0BhgxbCLiUUbdYUuFa8WJVr+GlSQHcjxV7w/rekJZ3L4Kr13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l2G/vZsiAO4ZpTTKDl+mx3/ZvUXjo9o6WiJvzBkPBg=;
 b=e7mQdGsKJkY/vSSWmxF3G84EumsOHIkOxKEdmbeyU11GtTe80AhKrx4ELIO5vp/m/cOFDnogXUBykBcmCgeAPmD+ZBu0KhmhGaxdzwQ2bYrN5vVHn1oWZGBnRLbjHmUvvDLrQXkdIfUgjZQHXExrOV/a7bui312NV4/cZ3ZR7fM=
Received: from PH0PR10MB5481.namprd10.prod.outlook.com (2603:10b6:510:ea::5)
 by DS0PR10MB7051.namprd10.prod.outlook.com (2603:10b6:8:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 21:40:15 +0000
Received: from PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac]) by PH0PR10MB5481.namprd10.prod.outlook.com
 ([fe80::a3a4:998b:966b:41ac%3]) with mapi id 15.20.6745.015; Thu, 31 Aug 2023
 21:40:15 +0000
Message-ID: <ebaf4540-09da-305e-503e-d83d53f6f4ff@oracle.com>
Date: Thu, 31 Aug 2023 23:40:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/2] Fix MCE handling on AMD hosts
Content-Language: en-US, fr
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230726204157.3604531-1-john.allen@amd.com>
From: William Roche <william.roche@oracle.com>
In-Reply-To: <20230726204157.3604531-1-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To PH0PR10MB5481.namprd10.prod.outlook.com
 (2603:10b6:510:ea::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5481:EE_|DS0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 18708948-61d1-4524-f3c8-08dbaa6adcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbm8183h3r3z3Z0QOVKtZyHnWG7gdufBsrfw7PZMnd/Y/Uie4txRhExt3qR68qSaRc2nISlk0vCB+fr77XmLlKuTfYLN72FDm4Z/AtbkyeHoncYtWdR+pP4OV4iqhQqZvhV6Jguf+UCrTsZgnz2aQLb4E9n/CBF4EARVlSUbB8NWGFOOq9Vi8hgCo2NfDOqMPBy7ZGC13SSRLgTnFuybwgTEKXiyqz399r8QeEjBwDeMC/y4c3b2MugQIvJjvVjJcwOcNAerzXpwZItq2If34U3Wr+yIxHdXCvI2fdRnTloFzUhl9J4u+AJHejFPWML6Vk7EZJ5nYvii7hy9hA0E4AmglmcAaNMi3HBjcmeSq9aYzu7Ol8Kwi6r0iGZ9Tq/P9i6rTd+HWucOxhCK69sRuXM/D0An2VwlVyFIb4/XhnkX5QiGzgmpx+KX6BYbtQlgiIGk6qqBxNV8KX6zQf7HWfYt0lifAgcmgnYK4UQO2YRJBH5DlFVkaTADz+9WhtbyPH3vWF1wPO4+GuRd0vcs+1LtRnh3bTMrXReq6yHRrAJj4df/jb/IWb1JcO/n6nC22EbXtHWAKWG8Ya4i48D6ZFddMBq7nctmESSMsCHkghZVLfuJJ7rGZGPOGhng78LGKRb4EfDfGXTxI0eWciT2DwYZkiPE/m6JnC4iU8+Rdz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5481.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(396003)(346002)(1800799009)(451199024)(186009)(66899024)(2906002)(66556008)(316002)(66476007)(66946007)(478600001)(38100700002)(86362001)(8936002)(8676002)(5660300002)(41300700001)(4326008)(44832011)(83380400001)(6512007)(2616005)(6506007)(53546011)(6666004)(6486002)(26005)(31696002)(36756003)(31686004)(21314003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDZUaU1EbEJVMnQvNmhlK2dJNjRRUk5YK0d4UDFLbUo3ZjlHSWlWTnp6anpp?=
 =?utf-8?B?bXY2VmJqUHhIamluMUpEUVJTUFhrbU5UazZOdUkxN2pSazl3N1pHU0xDenFk?=
 =?utf-8?B?S1phbDZpM3pCZkVocUVZM0E0Tmc3TTNZQXlCR2UxMEpnUmIxTmlScGsvODJr?=
 =?utf-8?B?Vk5xN3B2eVh2bnpzTGsrbk1NUFVpZ2ZXeWxncG5kZFBvcUE0WkY0aGh5elVn?=
 =?utf-8?B?VVZMUTUwRXNSMlVaUjQ3U2VyMnRKT1Z3cFkwUDI5dUtYc3k3MDcvU0dHM09O?=
 =?utf-8?B?MWJBWjdRNkF3d0FTWlhKWGRrVHhYUTF0MDQzUUtJcmhLcEtIaTNIU2ZCM0I0?=
 =?utf-8?B?aUh2WGkzUXlrL3BHK0tsMGd4WFYxdm5xa3ZCdDVLM1dsaU5xaE0yVjc3aEVN?=
 =?utf-8?B?N2Y3Mk40RFlRcWtTTjIrNGQvb1pNcEZodnJEdHNDZkhhRmpHSDhGVDhwVGRm?=
 =?utf-8?B?Wmp4YnZKdmdJZ1F5S2RGMzREcTRmMll4Skx6QUtmNEV1bVEzbWlIMVVQK1NY?=
 =?utf-8?B?NFRVL0gwYmI5dkpoWmlwVk4ybE9HbDE2c3l5K25kRU8zckIydU91b2xqd2pW?=
 =?utf-8?B?K0dhY1FtL25PY05sb1NoWXcvcVZGaUVtb0Y1cE9vd3RDaEdnTlZpS0piVVJW?=
 =?utf-8?B?aDhUNWJrVWZRSkw2Z3h1NUZuUVN1VTdPTFI0Q2pxbGNyZEhGMGdqUE9tdHh2?=
 =?utf-8?B?TXNxc3Uza2hOUkY2OC82djZ5ejlaVTVZTTEyVkFMNHBlc0JRb3pWRUFLTUcw?=
 =?utf-8?B?NzhKbHB1b1ZrdVJJNnc4QWtBT1FYbUxYZU9ucld2ZVlYR0VCcFpVck9VZWdD?=
 =?utf-8?B?bndIK1hNdllqczVlbTRFaVErZGpoYmN3dlBGdVBSY2l3SVM5TkZnQ2ozcWxj?=
 =?utf-8?B?MDhvdnVRdmxPMVRnK0VNSXdxSUhXTlo2TmMvTUxEQWNsTDYvR2E3ZGtveWJO?=
 =?utf-8?B?ZlJUZlJ0YUlVRHlIdnhBeGFOUERKd25sRGliUU9QT0lLb2NYcHdOVnBOQVRk?=
 =?utf-8?B?bFBCTERDcXkzdU9DVk9kWTAxaVlTZ1BOSncyYUc3bjFtZmxmRlZhWm5kaEdm?=
 =?utf-8?B?SFpsZXpPcGszWkhDVDVLS1VaancrTTJyY2lZUW1xTEttVVFuSVNCaDZKZFgz?=
 =?utf-8?B?ditSbzl6NFUyeUR0eS9OTVpqYlh2V0puWTN1alJQOHFYRWx6VS9TQ3Awd1Ro?=
 =?utf-8?B?TDhla3FISUNJKytZYXVvdjRZV3pub1BNNTZIajkvY09rU2h4bEZ0Wnl2SGZt?=
 =?utf-8?B?NEtZbC96THhrK002dUFpenFJQmRWdFRjaGFYdEJhbnUweDRZTVRRKzRKZlcv?=
 =?utf-8?B?MTgwSUlnSDE4dldjRklBRDRlNFoxMHR0aHh4ZTIrSHh0L29zN2NnQ2tEQ0lv?=
 =?utf-8?B?K1hxQ1VCcDZlRHFsZ3B4WXdBVW9GeEQzWXVseW82dG5TVkhST1J6V3R6bW01?=
 =?utf-8?B?b3c3ODArQS9Va3IvQ2lhamZaenNmMWxIbHY1WkV0QzdvM3RYbEpTMldRc213?=
 =?utf-8?B?QWxuUFNUTHA0VDNQYVNISlFaQU9YQUxSR0FaMW5NNG1kd1U5Qmg2ejg5Z0c5?=
 =?utf-8?B?L0Z4eDZIbEF0ek5iVm5Icm9hR3NVOHJsU2JWYnNPYzlXRVlUYy9lY1BqeHVM?=
 =?utf-8?B?QktYUkttcHprUDlsTDNKSm9IRmpiaTdqdkdvdzhNVFphRmwxNTdXSHZUSUFG?=
 =?utf-8?B?anV2aG9GZWoyOGRXQklkZG5RRUZvaU9WTUhUc1pEWmoyQUZnaGFsb3Z6MnNk?=
 =?utf-8?B?L0ZmM0IyQUxnQVVsWHhPT1BqYmJnQmJwZDk1NW5MbUJTQldqalpZUW1IZ1JB?=
 =?utf-8?B?aDNmRmRldzE0ODRwZEM5dkRkTGJmcFFUbmh5ZXN0VEM3cEl6MlFDS0xPYlhM?=
 =?utf-8?B?N3FoWHZvWG1QOWo3VTJnekluZDUzSktOZUxJY0c2Mmk3Zi9oS0c4Y1RXNk54?=
 =?utf-8?B?bGlzVGtWSjBsemRQYWpsY09jUmVreGNtRGxpK1FzM3Vic2ZIeWs2VWFHSDAv?=
 =?utf-8?B?U2tkWURyZU85aGppa05qbkMrMGFGQm5jN3FOVTQ2OVVIaWZrSmlxd0kyRHI0?=
 =?utf-8?B?V2NrcmxFMGZLRCsxaWRKQkd3UUlPTkNSV1BUd1IrV2U4cmhxQkxPZzQrdFVx?=
 =?utf-8?B?YTc1dGErOURmT3JsZ3FXMmsyV0d1aTM4eFI2WVJ0Q0JHMGkrWTloVFczUTBh?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: paKqjwdimQJc+VSr30nqqoHxDgMZxbwYX2ufoCTiKJPdJMChBN1RRGaxsAvRKp8SiwwQBIh8L1DgmOO/u0yufoghRJ7t+VsbKSBE8OL4enm5CnnKKUm6YzNzK2yiU0K2MTzPtxEl89YxpE/En6gNJUyFzzPOtazdZa5EZdTUO/2shQ9nqWIOg+nyvkT4yw2ByhLad4Jzp13dEtt2Kfo3DQe/iqQWAPN9AbxElsxzLvD/A0jpUdc8vzirpPcNO8jLC/NVg97qI4+sC41aPdxlnJu6CU/kCO2LQr6gwRtvy58bcMzcZPOy32mBFSoB4pUaxGntZ8Jl2Q3zlO1FN+yT0yq37Vs/g+5In50fwPDsOCTvhtA1R0kqP6cpnnK4vNzFMOJbABfg4753LR2BBJO+eh+rBKHl5PyPu/9f4LNFDgpbdQp6+wVmnwrhHHVqxH0YrmkrO8AL9SYTfIh0cUh6nQ5xf2PC7sp1YGDJeVxVaOVPXauKYkSATQ0QoeKZ62ASGtQvQfF3s6cFuNrYm/5eGojg6vrna8bsq2z5o/pPg1QIjBIEmYZae2olR8D1c67OFYYnC+dWAX2dPolQLVPLM4uVVrQTaNTCzN2j7BUPJ7bfMOIkZRlIGJDYOf6ynRT46BlDE8JB3RC8V/4oH2y8+60TySRm0oKAYNpCuHy0y18iD5uk2ocJiHOnpmOvT4FT4sMTLqZj5qHM9jcAWO8Qv9/1J2SZon7wQRJu4Z65r41U1SEAAlNXf0L8haPoCkwgiIrbbDadNkGsKbTCUZY1pL+EREwtSdX0UOulNJLssfHdWRKeKu12jlGJwaYg3vCIG7qeN4kpmuHqNU0pU7Smg6wFk22Xzj0yNTrLfZ1bdbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18708948-61d1-4524-f3c8-08dbaa6adcd5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5481.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 21:40:15.3471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kf9iK/zs7uLnjWtzgOuNzJRLl2CQ0arNAymrz/62gRP5+l166K5Ohq85E3k+5kVkuamaXPDoej6TKK6KYMBl4aUhvx3rxNyENlxU3oDTGpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_19,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310194
X-Proofpoint-ORIG-GUID: KNvrx0X62przL8H9_xCIqx8zSbx86wFh
X-Proofpoint-GUID: KNvrx0X62przL8H9_xCIqx8zSbx86wFh
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=william.roche@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.478,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 31 Aug 2023 17:51:21 -0400
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

Hello John,

I could test your fixes and I can confirm that the BUS_MCEERR_AR is now 
working on AMD:

Before the fix, the VM panics with:

qemu-system-x86_64: Guest MCE Memory Error at QEMU addr 0x7f89573ce000 
and GUEST addr 0x10b5ce000 of type BUS_MCEERR_AR injected
[   83.562579] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 
Bank 1: a000000000000000
[   83.562585] mce: [Hardware Error]: RIP !INEXACT! 
10:<ffffffff81e8f6ff> {pv_native_safe_halt+0xf/0x20}
[   83.562592] mce: [Hardware Error]: TSC 3d39402bdc
[   83.562593] mce: [Hardware Error]: PROCESSOR 2:800f12 TIME 1693515449 
SOCKET 0 APIC 0 microcode 800126e
[   83.562596] mce: [Hardware Error]: Machine check: Uncorrected error 
without MCA Recovery
[   83.562597] Kernel panic - not syncing: Fatal local machine check
[   83.563401] Kernel Offset: disabled

With the fix, the same error injection doesn't kill the VM, but 
generates the following console messages:

qemu-system-x86_64: Guest MCE Memory Error at QEMU addr 0x7fa430ab9000 
and GUEST addr 0x118cb9000 of type BUS_MCEERR_AR injected
[  250.851996] Disabling lock debugging due to kernel taint
[  250.852928] mce: Uncorrected hardware memory error in user-access at 
118cb9000
[  250.853261] Memory failure: 0x118cb9: Sending SIGBUS to 
mce_process_rea:1227 due to hardware memory corruption
[  250.854933] mce: [Hardware Error]: Machine check events logged
[  250.855800] Memory failure: 0x118cb9: recovery action for dirty LRU 
page: Recovered
[  250.856661] mce: [Hardware Error]: CPU 2: Machine Check Exception: 7 
Bank 9: bc00000000000000
[  250.860552] mce: [Hardware Error]: RIP 33:<00007f56b9ecbee5>
[  250.861405] mce: [Hardware Error]: TSC 8c2c664410 ADDR 118cb9000 MISC 8c
[  250.862679] mce: [Hardware Error]: PROCESSOR 2:800f12 TIME 1693508937 
SOCKET 0 APIC 2 microcode 800126e


But a problem still exists with BUS_MCEERR_AO that kills the VM with:

qemu-system-x86_64: warning: Guest MCE Memory Error at QEMU addr 
0x7f1d108e5000 and GUEST addr 0x114ae5000 of type BUS_MCEERR_AO injected
[  157.392905] mce: [Hardware Error]: CPU 0: Machine Check Exception: 7 
Bank 9: bc00000000000000
[  157.392912] mce: [Hardware Error]: RIP 10:<ffffffff81e8f6ff> 
{pv_native_safe_halt+0xf/0x20}
[  157.392919] mce: [Hardware Error]: TSC 60b92a54d0 ADDR 114ae5000 MISC 8c
[  157.392921] mce: [Hardware Error]: PROCESSOR 2:800f12 TIME 1693500765 
SOCKET 0 APIC 0 microcode 800126e
[  157.392924] mce: [Hardware Error]: Machine check: Uncorrected 
unrecoverable error in kernel context
[  157.392925] Kernel panic - not syncing: Fatal local machine check
[  157.402582] Kernel Offset: disabled

As AMD guests can't currently deal with BUS_MCEERR_AO MCE injection, 
according to me the fix is not complete, the 'AO' case must be handled. 
The simplest way is probably to filter it at the qemu level, to only 
inject the 'AR' case -- and it also gives the possibility to let qemu 
provide a message about an ignored 'AO' error.

I would suggest to add a 3rd patch implementing this AMD specific filter:


commit bf8cc74df3fcc7bf958a7c42b876e9c059fe4d06
Author: William Roche <william.roche@oracle.com>
Date:   Thu Aug 31 18:54:57 2023 +0000

     i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest

     AMD guests can't currently deal with BUS_MCEERR_AO MCE injection
     as it panics the VM kernel. We filter this event and provide a
     warning message.

     Signed-off-by: William Roche <william.roche@oracle.com>

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9ca7187628..bd60d5697b 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -606,6 +606,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr 
paddr, int code)
              mcg_status |= MCG_STATUS_RIPV;
          }
      } else {
+        if (code == BUS_MCEERR_AO) {
+            /* XXX we don't support BUS_MCEERR_AO injection on AMD yet */
+            return;
+        }
          mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
      }

@@ -657,7 +661,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, 
void *addr)
          if (ram_addr != RAM_ADDR_INVALID &&
              kvm_physical_memory_addr_from_host(c->kvm_state, addr, 
&paddr)) {
              kvm_hwpoison_page_add(ram_addr);
-            kvm_mce_inject(cpu, paddr, code);
+            if (!IS_AMD_CPU(env) || code != BUS_MCEERR_AO)
+                kvm_mce_inject(cpu, paddr, code);

              /*
               * Use different logging severity based on error type.
@@ -670,8 +675,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, 
void *addr)
                      addr, paddr, "BUS_MCEERR_AR");
              } else {
                   warn_report("Guest MCE Memory Error at QEMU addr %p and "
-                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
-                     addr, paddr, "BUS_MCEERR_AO");
+                     "GUEST addr 0x%" HWADDR_PRIx " of type %s %s",
+                     addr, paddr, "BUS_MCEERR_AO",
+                     IS_AMD_CPU(env) ? "ignored on AMD guest" : 
"injected");
              }

              return;
---


I hope this can help.

William.


On 7/26/23 22:41, John Allen wrote:
> In the event that a guest process attempts to access memory that has
> been poisoned in response to a deferred uncorrected MCE, an AMD system
> will currently generate a SIGBUS error which will result in the entire
> guest being shutdown. Ideally, we only want to kill the guest process
> that accessed poisoned memory in this case.
>
> This support has been included in qemu for Intel hosts for a long time,
> but there are a couple of changes needed for AMD hosts. First, we will
> need to expose the SUCCOR cpuid bit to guests. Second, we need to modify
> the MCE injection code to avoid Intel specific behavior when we are
> running on an AMD host.
>
> v2:
>    - Add "succor" feature word.
>    - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
>
> John Allen (2):
>    i386: Add support for SUCCOR feature
>    i386: Fix MCE support for AMD hosts
>
>   target/i386/cpu.c     | 18 +++++++++++++++++-
>   target/i386/cpu.h     |  4 ++++
>   target/i386/helper.c  |  4 ++++
>   target/i386/kvm/kvm.c | 19 +++++++++++++------
>   4 files changed, 38 insertions(+), 7 deletions(-)
>

