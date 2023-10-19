Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF17D03D8
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:23:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaPZ-0004j9-VI; Thu, 19 Oct 2023 17:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtaPR-0004g0-84
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:25 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qtaPN-0003vW-6I
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:18:25 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39JKuTuE011471; Thu, 19 Oct 2023 21:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=K4iVavfJomv164tBjFnA7Qg7j5Qrb0zCj5Hb1j933zQ=;
 b=ZbR1Em08hUL2dCI1BYJZPWX+IHO8CMT2DrSOo/WfeSNt9poZXD8WWwuOB+x4Yta+iTha
 kupEjt4dKL2RNBjkKMdgFY+d9VeDdrn7quARv5iKBe1FZ5bxJsW78lMdewLqP/az7kyq
 zjS01mtQtrPA3ZOETs8iP/rrZg90et9FSMEnED2vXZ4US3tiJmdKsEKx/Hg8dCPR3JWG
 YokZa8c2I6Fgco8jPyFdKcUdZXSpNY3PygQs4JBcP+3Lia20TK2QW+V25L99+GBIC9AR
 P0Lngz9EFgBFuooT5/idNrDOBO2U4OyL/N/vMLDw5BhDFjbWG12LkUyPCBqOulzMweJD 4w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tubw801at-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 21:18:18 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39JKsj0Y014242; Thu, 19 Oct 2023 21:18:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tubwegsnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Oct 2023 21:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVbj92hF1mteukKdmfy9FYXs18IvmGuNTCSrDdld5Nm0QERosaFHue4fECHa6IsovBbRjPxL6mq0zKIehI0vFWqV7qDs9QWsDEUlNPNz9TA9VGrKtBw2VeUa6fxvRBzzDvU0JXm4yxikxJRfpvXwIh8V4J1YA/5h8TMqOVd2O6E8NWQF9PJKud1r76mzvxl4zO/sTLX+5JxdFuoFBwKxIrgTwvXVM+t7GorqPAjYRpAmDEtAJuD2IMJZy0EUwim/mf19dOzMZmjtLrL921It1UeYnouq9GSfOZq1oS1PI6hXVoFd7v+tZCa+t4hrgyjYpKjtngIT5D05osm8uMfSIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4iVavfJomv164tBjFnA7Qg7j5Qrb0zCj5Hb1j933zQ=;
 b=Tte+DdU+ZszAqCdRal9hVTY6rHydu8MjnpROHY/Yp7hd7gMCzvBx4J6ejEGcolWoBFEFan05ew6W8QzvMX5FeRVNdhp/H0XI5B4d1N5z69sI7lx9F1MTHnEfaRodB2kFWdtoZJ0FDWLKcA0MR3MMg/P4qzzBBICMvA7IfXdU0Bl9BiTdZGy6bd9ulutZJs3qStJkGeShQR4+wFYhhuB9kuDELWnPPqn7pp8GOBIuWR6C+ZZtFJnU/HQc53Es5XBd8fGJNuSO9jo76y7nnyVeTLW6BAwLevtDNY1BN8eeg72SUc74xkwB8Mjw6afP0P7XknyJo5IhNzuFNe7WssUVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4iVavfJomv164tBjFnA7Qg7j5Qrb0zCj5Hb1j933zQ=;
 b=wrL3bGw6ioq91lseuZ/h0mlLn4LBphzYJYYsWcIaB407tRPjXgk+Bhh1L9fttdRZqs95j3jwAKX8ovqFeCr65trBwcAahjZlcaKus++mwZTpucBSEl3JQnY1VHD67zJNWEHldUnsEcirv6/Oj8UP/HU4cdwUKdXRc63se9SLS4w=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by DM6PR10MB4171.namprd10.prod.outlook.com (2603:10b6:5:21f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 19 Oct
 2023 21:18:09 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 21:18:09 +0000
Message-ID: <26e34256-4b80-4b14-927b-47191c4586ce@oracle.com>
Date: Thu, 19 Oct 2023 17:18:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/4] Live Update reboot mode
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:208:236::13) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|DM6PR10MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e6c6fc9-a115-4c21-1c6e-08dbd0e8e4f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux4rGIJcFhKwd7VSThRvRVIDAE/rXiowVyrYejiYj9xEQ5ZlS7onzmyToCsa1WWWDJ9a6FG9TfrkI2nNymfaVljnfmRhRg10WDKpX2wDM0xA1Sp35bCFWq5GK8FeN20qnIL+fpeU894xNCbo56jSgcrlrQt0vhA+QUiwF02wE4U4SNnX44QfkvUjZNzWvxHxeF9ttmpuPe6Z+lSmhmS3Y0eKlnwcFs9siX0ix9hwY5tw6zMKncU9bUY6cZJs/K4gN/PO0NBO+KiwWCRLBkkgww3sRNLt8CxdgQDagRJlAXNuIRpAYmyPZFh2+i5IueUOc3rT6zWjy8D1+DCMLmGLgk3OE8tgqOBu96DiNvbkV59++X7ovBVjE+eokDR1cmRRN1G0McD9ejaFjTm7KWARehTH8T+qiInPr05u46yTYpnhzit0YiaMcUFTKezy7f/xFD75txKDniwKe6A9ONQmthafCAmCv1JvhLfr0Upshc2tZMpAnF6e93f2nBze4IThscizYGolq+S5WAvuumkAAyVI1Yx1ucdJiQ5l39Ay4bjJialzqdKfYqS278SR6+8O8wNfAud3/fcb9QHBmSoFVIxzGZ4aLGbUSsLd4kIj5jfwUyMKRHaEraODPv2A4hSweqP2+jnrxDKplKMpd5EzzR3zLBoElGXbAbir3HqBgjac1i+wENQljedZEcUyEyn6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(316002)(26005)(2616005)(66946007)(83380400001)(8676002)(38100700002)(8936002)(44832011)(4326008)(66476007)(5660300002)(6916009)(66556008)(54906003)(41300700001)(2906002)(15650500001)(53546011)(6666004)(36916002)(6512007)(6506007)(966005)(478600001)(6486002)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXBQZEpoSFl0U0ZCQTY1VklreC84U0pTNmZzMHFEaW4vVHJnYXpiNmFraTY2?=
 =?utf-8?B?Q1VvVWh3MU5nS0tQRnZXZ1oycUdZc3B5QkcvMy9FY0ZLQVZEaHp5QVUwMHRn?=
 =?utf-8?B?a01JSmlLZ2NkbE0veGdPbWF0S2JlNlNGQnU2Ukk1SExRQk0weFFZa1dtUWo2?=
 =?utf-8?B?TEkxMUFNRWVBaXE2L1ZSR2FrWmRKaDhHWDZkUHdwTHl4Rk85cHNSZDFFTFIy?=
 =?utf-8?B?VmZURFp6OXBDWlYxbW5Ec2RlSmQ5RldRT1RjTytRbTBjZldpbEdGdCs5dFZK?=
 =?utf-8?B?NC9EQjczN3FwZFZQeUprZDRaa2J3OGt3dUxlSG90WGMzUFFMbW1jdDZ3UmQy?=
 =?utf-8?B?NGNJalpGYXh2aXlCQ3ZZSEZ5N0I5ZThOL0ZHRVJDSkdtMVRIT1pXMmRWMVdv?=
 =?utf-8?B?eXd0ZjhKRFh0YnpWeWsvRlNUbVo0dTNDRUpod3hYNHpTUHhVZFdGckViWVY1?=
 =?utf-8?B?M0lrZytJQ0RIME5UbnprSURLbUNRZmovaWMzWkdtanJsVTNHM1VpTmYvNEs0?=
 =?utf-8?B?bDYzNlJtdTdzclBHV0VyYkZvVm1yY0NHUmVFUmpwS0xQRW10Q1AwU3Q5R0lq?=
 =?utf-8?B?U1Ewc1J2VlFHeEJLenorRzljcGV3YWNMYU1IZExmYnBUdGpES3hWQzdLOTJp?=
 =?utf-8?B?TW1jNTVKOEhHTzNUZCtqSDJNdDR6TnFnQWl3aXFxTUM3S2ZDUkJadWxycUF4?=
 =?utf-8?B?VGxvT3M0eWhucXBmMDBRYmVUSFhhR2RTL0ZmRUdXMTV5THg0RzJXT3QrRkhT?=
 =?utf-8?B?d3BtTk1vMmtaVWdZNHdFV0E4UERqTEpWRGdYN1pNb21DaGpwUStnTkdKVjVQ?=
 =?utf-8?B?bEl6Z3Z1SW9oTmpnM2ZwaWcxRmpGWmxLWHF4bW9QcWRYVnErTDFqb0tZZ0d1?=
 =?utf-8?B?SzNEaWMyNGNMZitOY29GY0JQQmx4cU5MTXJLTUN5UVRwaXF2ZnpQRnZ2MkRj?=
 =?utf-8?B?cGpsUGorTTBneFNoS0pUMHNpRDcvTG1jUmpRR2d3WFNZUmRZUHAxSmpNS00v?=
 =?utf-8?B?RWo0Ukt5elJMeUNEa1pYUkZMR1VndGlCVXFiM3FKL3pMM2JBQ3VnYTdCRHJU?=
 =?utf-8?B?U2k5Z0FFTjBTdDdYUGpvenF1VTNHSHdCZW1QcXR2RkJJcjZOVDhURThscXhT?=
 =?utf-8?B?M3BneVNuN2lKTUwwUWJxc0NwMmdHaTRWRW1XZXBxYjdZbi9FYitENkdkOTVP?=
 =?utf-8?B?NnNib2lab1AvMnJ6QVRqMzNpRkdqQWp4MmppNkwxWVEwbkdlSTRZMzBwd053?=
 =?utf-8?B?M0JYQ0RRR3BCSHNkNVd0dUlUNzJZOGZmWG5pUE95OHdUTFRKWkNBL1NCWVQz?=
 =?utf-8?B?QTBhUndQMnp1QVV1NThFSnpER1JCTjhsdmlhM2d6czg0OGZiQVVrVjF2dlds?=
 =?utf-8?B?akJQYnVFSTgrSFp5eENCOVMrK2ZmRWZZaldZTEE0aWxPNWFPMklLT1ZaYTU5?=
 =?utf-8?B?cDhETC9GSlN2YVBxNFpnWVY4bHkwVTV1M0t3OUFWY0h6QnA4QlJRbVZJRWhW?=
 =?utf-8?B?UjVROHEzS2xyTHZGekNYd3ArRW54bitmbkppbEdUSFZmU0NSLzBJY3p2MTJl?=
 =?utf-8?B?ay9ZRTEzdFN0NVVDWDBrZkYwUHdqUXQwbVN4NVhUYlVzWmlsQmc0ZjZ6dG5H?=
 =?utf-8?B?N1FleU9oVXQ2YTVLaXMwa09mQWQrdWFnaDExL1pVL0h1QU9WbXZFQkFEMHdG?=
 =?utf-8?B?YWVpRGQ1Y3lxL3liTVl6U2NDaUNmSHk4aWgxaUt6Nmw0dlVMRlhYbFBwUDNu?=
 =?utf-8?B?SGY1aDNsZmtXTHhKM1RsQjRma2VjVSs1NWdoNmhJaGc2Q05SUGdFWXUrSDdq?=
 =?utf-8?B?a0RTZDZOR1BUT0w2dnlyZ2V1ZEU0SGh1aFhOMHZhZ2hvK04rYXpTWWFySVVJ?=
 =?utf-8?B?Nnhhd3N1TWxPUzBEdFljUUdCNGYwQmdZVzBzSHoyQUJmWTF5U2MweTBsV09Y?=
 =?utf-8?B?TDYvSDNjcXRFZ3JwZzJtR09GTXVwbzhQc0JVNE1pQVpmemhyZFpxQTd3MmYx?=
 =?utf-8?B?aS9iaFVPVkhZTnR2cklMVFM0QXlPZUNRd2VBRzlzWUFobVZ1MEdSU1RqRXRh?=
 =?utf-8?B?UEFNUVZpRm5MRGs0VVNoT2lLZzVhWlpZNW9mZjE2dTZucXFtSWJ0cGRVcWRF?=
 =?utf-8?B?SUp6R09ka1FYRlBWN1R0WFZwRUJUVWRSdHY0S2lISHQ1d3AvSnJJeEczek1S?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eiJj2tgXMWizq+7CI03IaUgSKAjoei61h6T3BT7JytuctcP+caxqDY0sioe0/29EHAKczdRe6JQZcFhJdqiskhf6ZNheFbt4DzHvvoeKYyb5VpDfivY7lEcrM1qwXyzWJlp5r5/0Vo+hhjRWFrnAWS/NAD3N1j9xBnguaUjWZYVVHdylaVipqky4Wwyvxluvb82X7ZovoO7IpQSRlbLK3qGZiyCZ/7qel4pH9ebmlhExPYRo7PaTEAoDhCUjjTm+LHoAt49EZc/P2+lsDRRLxGFeMhmmpvSnv5PWMHG1BNl+tMruQ2FF5Vny6WRdcFDWuOr4K2brCiBx8FKmi1LqIZaLFnz3/Is5Wo45/9l1JVpXANUgzPDIyJwsPTePz45qpZtmS3ZRWoSa+I+XSNUAw8ZLjvAuNYonXF45wDeDjGoh89+CszQfugTde9ZZtFUeDrCUEZjjAtFBpON9pDGd+yRaqthgmQJMpXm5AC14viwFGNIbldO1+Wwvr5wpXKaddFW9L9VV5BgxK7eNr4ZMYPWDnZ9mlSHcukOV0LaPusRgmhqk5Xk9PKYb7WJftaTVQTksLAO0LUdPGWYvQmUZl/KkFCqZlXH68YAdHsBOeV6kEvETW/dPTNzmKfpxkEKgAHnnUmYvOXYYi7XwyXMiAXWXkQiqnzFOVhPWTbvyqfxh1UH0Q1oPZeNm1fCy1YVYqVjyf0MOP6x981hpOs6ZY2NCPh7qSFFWsRtVafpjPL/z9YCRJ3kGMoF+6dtn+vWyRPbFgLc+zAD3dHT4YUxJ64gCXEOTYH5D+dYNHSKAFa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6c6fc9-a115-4c21-1c6e-08dbd0e8e4f7
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 21:18:09.7256 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OA9tUvICLkOeX0WiqKtU+9x1fjOPT1N9lh5eMYZoNP7M9iSf6/mErUegahkrd980KB9wVzab9TgU8kPHzQn+dmtTBkx23CRaIFpU2a2/SiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_21,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310190180
X-Proofpoint-GUID: QdGOqRiGMBtiozykPIlgtDOmc5Vt5-Z5
X-Proofpoint-ORIG-GUID: QdGOqRiGMBtiozykPIlgtDOmc5Vt5-Z5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

BTW, this series depends on the patch "migration: simplify blockers".

- Steve

On 10/19/2023 4:47 PM, Steve Sistare wrote:
> Add a mode migration parameter that can be used to select alternate
> migration algorithms.  The default mode is normal, representing the
> current migration algorithm, and does not need to be explicitly set.
> 
> Provide the cpr-reboot migration mode for live update, which saves state to
> a file.  This allows one to quit qemu, reboot to an updated kernel, install
> an updated version of qemu, and resume via the migrate-incoming command.
> The caller must specify a migration URI that writes to and reads from a file,
> and must set the mode parameter before invoking the migrate or migrate-incoming
> commands.
> 
> Unlike normal mode, the use of certain local storage options does not block
> cpr-reboot mode, but the caller must not modify guest block devices between
> the quit and restart.  The guest RAM memory-backend must be shared, and the
> @x-ignore-shared migration capability must be set, to avoid saving RAM to the
> file.  Guest RAM must be non-volatile across reboot, which can be achieved by
> backing it with a dax device, or /dev/shm PKRAM as proposed in
> https://lore.kernel.org/lkml/1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com
> but this is not enforced.  The restarted qemu arguments must match those used
> to initially start qemu, plus the -incoming option.
> 
> This patch series contains minimal functionality.  Future patches will enhance
> reboot mode by preserving vfio devices for suspended guests.  They will also
> add a new mode for updating qemu using the exec system call, which will keep
> vfio devices and certain character devices alive.
> 
> Here is an example of updating the host kernel using reboot mode.
> 
> window 1                                        | window 2
>                                                 |
> # qemu-system-$arch -monitor stdio              |
>   mem-path=/dev/dax0.0 ...                      |
> QEMU 8.1.50 monitor - type 'help' for more info |
> (qemu) info status                              |
> VM status: running                              |
>                                                 | # yum update kernel-uek
> (qemu) migrate_set_capability x-ignore-shared on|
> (qemu) migrate_set_parameter mode cpr-reboot    |
> (qemu) migrate -d file:vm.state                 |
> (qemu) info status                              |
> VM status: paused (postmigrate)                 |
> (qemu) quit                                     |
>                                                 |
> # systemctl kexec                               |
> kexec_core: Starting new kernel                 |
> ...                                             |
>                                                 |
> # qemu-system-$arch -monitor stdio              |
>   mem-path=/dev/dax0.0 -incoming defer ...      |
> QEMU 8.1.50 monitor - type 'help' for more info |
> (qemu) info status                              |
> VM status: paused (inmigrate)                   |
> (qemu) migrate_set_capability x-ignore-shared on|
> (qemu) migrate_set_parameter mode cpr-reboot    |
> (qemu) migrate_incoming file:vm.state           |
> (qemu) info status                              |
> VM status: running                              |
> 
> Steve Sistare (4):
>   migration: mode parameter
>   migration: per-mode blockers
>   cpr: relax some blockers
>   cpr: reboot mode
> 
>  backends/tpm/tpm_emulator.c         |  2 +-
>  block/parallels.c                   |  2 +-
>  block/qcow.c                        |  2 +-
>  block/vdi.c                         |  2 +-
>  block/vhdx.c                        |  2 +-
>  block/vmdk.c                        |  2 +-
>  block/vpc.c                         |  2 +-
>  block/vvfat.c                       |  2 +-
>  hw/9pfs/9p.c                        |  2 +-
>  hw/core/qdev-properties-system.c    | 12 +++++
>  hw/scsi/vhost-scsi.c                |  2 +-
>  hw/virtio/vhost.c                   |  2 +-
>  include/hw/qdev-properties-system.h |  4 ++
>  include/migration/blocker.h         | 44 +++++++++++++++--
>  include/migration/misc.h            |  1 +
>  migration/migration-hmp-cmds.c      |  8 ++++
>  migration/migration.c               | 95 ++++++++++++++++++++++++++++++++-----
>  migration/options.c                 | 21 ++++++++
>  migration/options.h                 |  1 +
>  qapi/migration.json                 | 41 ++++++++++++++--
>  stubs/migr-blocker.c                | 10 ++++
>  target/i386/nvmm/nvmm-all.c         |  3 +-
>  22 files changed, 230 insertions(+), 32 deletions(-)
> 

