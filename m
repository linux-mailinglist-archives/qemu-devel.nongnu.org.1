Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AD48076A2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 18:31:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAvjN-0004ET-He; Wed, 06 Dec 2023 12:30:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAvj7-0004Cw-9j
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:30:25 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAviv-0005QW-3K
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 12:30:23 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B6EYmsY004992; Wed, 6 Dec 2023 17:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=neA0v/USY7kXbyIFashf2cUILhXZ2iRjhEv3UEGZjSk=;
 b=kPS2D5NYjw/bBi7RDuSuxNawcEca0zdsbldNWiHwBvQjeYtXOc7e9dlKuuyL92QW5j9P
 aa/aFQnrogqT06C8WBxZ51v8K7+YNLIgDpjZqwRxgK4FoM/ERAWepLgKEAhPm9oNkjpX
 hbjo+7HCoWnBXHOBsirqrJhJoQgj/N2eZcwaPsOQrLu5YL98l43MbVYa2a0+eLwpmKFO
 oMurkPyr7TD7XNlPV7bQqW8Q1yGzTW4zdz5sl6RVirseV5pmLXBnJyEtcytvHotOu0vX
 zSyccsJ6EdNRyjxxkzFx4cgzeFNmJv+93FDVR6Sj9QFciK9frxx/bGrdNFR0mb3/L9Ww UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd0hj18x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:30:09 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B6GqEt1032269; Wed, 6 Dec 2023 17:30:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3utan9fp7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 Dec 2023 17:30:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1cmAmbBu9zfMsvYlCaA1ca7lEpPIJXOBTxwcaVLey6j0RD5ezGeG6TA63S7Obq+ugeRCUwfqWC26quwfKeuih96aINbhRQUWG2vfRyTgiZK8CQrCmD76Ckm482wGqEtNNmGyD7Us/LthlDz8dAbv48Jz62ruc+G3qn28iSzBu0m4lsA/YnLnhJarJWCxNdDeZn12cEbuamUk+YE8lENxZr7PZZzQHoq6ySJlDpJPm9MVbNJAhjz74FpJBRxBSxrBE2i4KG8l0wp5UWYuOjWNHlIfM/OKD2+yAb1JaSwS+/pE+ZjHrN1pms1ybNb5jST3gCJfjYDjPyg9Ozfy97OSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neA0v/USY7kXbyIFashf2cUILhXZ2iRjhEv3UEGZjSk=;
 b=d2mLNiqa8v6o0XdAPIeZZ4b+ztDEVhDGCej+tJQYjFunb7AS8djwVQcXkG/iMItP1pVpCLtm8ry0v1nzoC+MuTbE50jWJG3ZvNrsHPyZZVgDWh/vOZw+iT1Gs8fVu1Kpxt2KzufF02qmgolpX163Fi7hJuiVNfMD+JHsnvy288vZLDRyMTVILeU84m5At/rbyYsp7lt6GeJVZqZMcBymbd0jiKcamZtnJepP2FKj9ynYhiAwYMULVqsxO+9zvWvduHMj65dqiSr6tL4kCp4tseyhvDV2aPEw0Zhx6ZbL1bRRp5BX8RbW8hxdeIFBIz2JpfNh23Eis572sWXYc6XoZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neA0v/USY7kXbyIFashf2cUILhXZ2iRjhEv3UEGZjSk=;
 b=qIhI3UlkRSaR0ygyYitW//+HMBTyZXIUaqdX8yKwuUs9WzpdDUDhiP1+XFxoN/50kzXJ8MH3tg+6UCpHfZF63SfP0T+npEbrCiEos8kX/FyWGacPyW8FFG68yCoq2lFj12M6JAbk3S87v4W5esa6FfPoY322ETrS0l9fh4a4IRg=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB6807.namprd10.prod.outlook.com (2603:10b6:208:429::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 17:30:06 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 17:30:06 +0000
Message-ID: <e7b55ad1-88a0-4d0c-9f4a-2df92ee4ff16@oracle.com>
Date: Wed, 6 Dec 2023 12:30:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 00/12] fix migration of suspended runstate
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::20) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB6807:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9cdc8b-1cc8-44e2-8daa-08dbf680fcbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wuXN6LgfaasHOpPF14W3exFnFej0yRYM58eNfKeAaxT2CKnl3gk5Xc4yOheANW5o9K99HOrFSeaKIAcW1gir0TdRvCYaYmR/REmJ97ITLGgkIINWOAQsLN3ZC6vkOb7QJC6QhKUieqtIkiLmCPvAnl27mjFYxNYjdbjh2MsrB/ebATNs2DJi3SLc5MlQQZIf54ggGbLUwWxdoCT41oWPuYiS0B2xjIVXpHjbFXUpM2xDqiXpb8IiI+4c6xaEhM6aqz8fJ7vMhC/DVz62MsF37Bz32Sb5h1YJH8FFxgkRRdMYsSDJViEClFpVML4FLGOg9xDKax07JvBEy24rQo1XyBF1mE7DOT6Jb3qsDYZNq7ciTYQ0c4MpKLLoosEJjhWDnNbkMr+S5Wb8B2jV/RMYVyHKllEBGBrXH1hagSbl2L1oaDufPTVrkhiFpS4+Ztzdz1E4lXvN3STvIymvsiKwdKyt2lEMaLYDivRLNHEvqS9VhQOrMppLwUZf5Ah+VRYMm48ERz+fEmixvTZ6A+uE4h7eVeo6TLf3XrVT2KlciWeLHaj1eQDq2a/+428aOP+b/XArx19Nk50ZCL8/RXyyT59XqHLf46mJiyDawRLR3QOXecL+HNkPCEIl/+8+YoPpRTKCZTvqrUQMyu0lFYlniA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(396003)(376002)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6486002)(53546011)(478600001)(26005)(5660300002)(6506007)(6666004)(66556008)(66476007)(54906003)(316002)(36916002)(6512007)(31686004)(2616005)(66946007)(6916009)(83380400001)(8936002)(15650500001)(2906002)(86362001)(31696002)(41300700001)(38100700002)(36756003)(44832011)(4326008)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEh2eGx6ZzZrR1BlSjRMTjJXTlF6QTFHVWRDL0RseVNxOVM1dXBBVkZJTzVl?=
 =?utf-8?B?TWcvKzFLUy9IRVF6bmx0RnFjWDc5VGVLYlJITHJwWjdhTWN0RStHVWhHUmxY?=
 =?utf-8?B?TzRPajR6c2s0MTd3dFZqN1dvVnprd3poWEtBYVZYWThLQXpYMmo0c0FmV0t2?=
 =?utf-8?B?dXFEYnJwVE1scVdSYjdPTjNkTnJMWWl0Q2dMMDBNNldmQTN1dFgza0ZTa1pZ?=
 =?utf-8?B?RC82ZThNUGoyaGwxTDBUU0tJbGd3eFQvdXYzemNWL1Q1SDJGM29RVVZ2M3Nn?=
 =?utf-8?B?eDBQRC9sbnNDMytabjIxT1lrUVhxMEdHY2NydGhXcGNTQURSTGZUbmdWSzhR?=
 =?utf-8?B?S2tUenFrMWYrc2hWd1ZXRjdHY3RZdGp2clRIZURkVUxia01iR1FRc25KM09o?=
 =?utf-8?B?NlFwcEloR0hiQmt3L0pobGxObXNYNkMrM3ZSeFJjMjdDTlkrMU95Q1ZPOUV6?=
 =?utf-8?B?Q0RmcjZlUCsvMlNKRCtUUFNJSE9FN0ErS0pHbmpZQjNWZXJXRlJyYVNVRGpM?=
 =?utf-8?B?OVZDRktxai84WmUweG5pRXNwdXFGUElNNG50enpQbGRKOWQvbjNiMk16bVh3?=
 =?utf-8?B?VERvNjJKQXJxOSt4VndVRk5GMHp6b1NRYUE4Y1J4WmNGSVMvVG5ndE9rQjBY?=
 =?utf-8?B?UURDclJnUklLbnZON2NnODV6T0VxU2l1YmsydGx0TXBUa0llbFJxTFZKbkEx?=
 =?utf-8?B?aUJSV0dSYUxZcjRudm5ydm9rZktIZEdPNjdRUE1OWWhZWG1uR2IyQldxRzZ3?=
 =?utf-8?B?VnptMzlRSEZZRUVYSzJFY2pOVm1XdUtHaHpMWm0rYlRBZ2JFbEtwN1FOWlJ4?=
 =?utf-8?B?SjF3Q1NtYTFxWllzYW0xL2s1RmJUSmN2V0lEK1BaaGd4eUdFdVRQcFovaUpz?=
 =?utf-8?B?NStaK1NHeXVEWldvTWY4RC92bUl4ZEd1RWJtV1RJcmZLUzFVQlJscWN5Mjgz?=
 =?utf-8?B?b0xBelYvQU5SSmRTUC8yOHNzdERjQkRqWnBweWdzQVZ5elpRcmJsbHk5TVUx?=
 =?utf-8?B?bW5idTlzKzMzZGlhVzc5QVkxeDd2bG5PRXBDNTFRemJMdVo1Q05aY3g2cjdC?=
 =?utf-8?B?K1JRY2xiQ0V3eDYwZWdoUXdaTFVMUkd5QU9BeW1pZWU3NzFkNTFIKy9ya3Fx?=
 =?utf-8?B?WHpIaGR2LzRURzlkUXk0VlBHVmYvM21LREM4MHd5YXpLMFFUYkh1N2Q3Sk5r?=
 =?utf-8?B?bUZqSTc3KzM2VGJGNURGckNnYlQ0YzdkekRnQkRTT0FVRU1VdCtnaHRBV0xo?=
 =?utf-8?B?TlF6dFZYbEpiSXppaktHVm9PYy9mWWg5Ti9kRGgzcklpdFQyYVpyemF3M2VL?=
 =?utf-8?B?K05aQmlWTjhXQWpiSHNxYTczQWtScGp1WnpmOTZseDlSeTZ4QkUvZjh0NmVL?=
 =?utf-8?B?WlVxZGZGOURtSEpmVWwvTmVuelIxbEV5cHp1NDJkaVJnTmNlQWhMZ2wvM2tw?=
 =?utf-8?B?eHBCUUhzdkM3bW85NG5SUC95ZVBzZmhLVnhhd0ErRGJ2Q1UwbFQ2dUcwcHhZ?=
 =?utf-8?B?WlJ1bHZsUFhZS01ycWhBblhINEIxN2k1cHhJdWNIeHR2c0tlV29PeHFPVXIx?=
 =?utf-8?B?OWNYczRJRm9WcU5IZFRPVmNNSjhOUW9xM2RPbzdtSFZkSHMvUHIvdFNNZFI4?=
 =?utf-8?B?a3VVbVhNSzlpUmhtdTN0bm1kZVRUVXRrdSs2U3FOeVFsOFFhT1A1a2twYlph?=
 =?utf-8?B?QXlPNmtBZDQ0MGdrTEx5NFlweWZYd0VuL1hSdWZqMDFkUHJZT1BOVS9lMkRN?=
 =?utf-8?B?eDRLRHhnTkNqbE5KMmFXamErOW0rTTE2MDRwSjQ5NzlWTVFwQUlTVHUwOHJ6?=
 =?utf-8?B?L2RLaUs3NWszelNLRGhtY2V2cFVwYXdvaFdLaUVoOFZFS1JTZkpSS20xb1lr?=
 =?utf-8?B?QmVxWXFWbURwUFo5dzNWeFp4NThGKysrZ08yRmhlNzh4USs0UU9GdzE1Y2lz?=
 =?utf-8?B?bVFVcmIzYTZZcXpqQ2wzRlFVQkF2Qm9rUlM4eGhiVWZGMlZiVWk0OU1KaVlC?=
 =?utf-8?B?UG9YTVhiSjZoRGs0bTZhZ1BsUngyN2FFSlNOamVWVkNyalhEVnkwcHRtSSts?=
 =?utf-8?B?amxOMnVlZ0taWEsrK0VKRFdqYlpnNllybUJ0UUNDUk0vVU40M1l4RlFYanJW?=
 =?utf-8?B?a3NHNEJseG10RHdUdldyUnJSVUxqVnFiWkoxSXBZM2RlVWxxQ3RadGtyUzRh?=
 =?utf-8?B?eVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qDgmHI4D9U/r38RBFfwlIrHxwA6cas+COXmkinL+82qadNw+NoC6SOWyBK0RtnlQ+URK+r9MiGJSvYbCoRSmu45YyYBJlRsnro0JeA6sZB3eOyNUDItkVJdui40onxBdB6sp3uD0FyuLaaaY5ALq+Kw8JT+wB1oGpgCSnYvudxLuV66zbdSh1DhIbkMwcjMYD04lze1tMZdMw9QwH/fM6Oq4f6UBA25bOizETsfPYmLmNy8zd3QbVckGBvO73MZm8rSJW+5pqoN8w3174bwE8vG9e/NCfRowzeC9L7N3hSIQoZB74HXhy7k2hu6K5cw60NhPqA4Vd1EqVNNAyWE6CtqxrslW2pCI7JLT/wDwz1Vv7EPCGr7hbgjPcsWxDyhNmyrx+wtPJBvorEoUKufrV1Air24wSqj36GKLiwaifVl60qC3CZQ34JlzLTNzDCVXVTMSQZ4qblS//HYlW4o/f8xbyWIxAeRsWqqGUsE0OAjBQnMk1zN6TBTRouSmI/qO56RoJONP2vHH32g6vL3Ur+z7hg6Yh115n5zi2FdzGJKzqj4AmuWfmZez3rAIcoPwKcCJVhqW64Qkw/5I75V6R/6IWzXC3LZcQ9k4iIEV9S+7o3rRXX4alg3+fSW9TgBlBHYV20tD8+eVbvaqoU/z/VUeJ9hoW3u6tOcMFhQXPSHZVfznTNd4e+05ll9vP/qPBHuk9/ELyAv2KSVq3yQauI2uHJPYzN1xaHcC4rM3rz+m4pXkJnwDehQDOlYcdsZaH75+qi3+zcY7CsmgDjxru3B2SEZh9JBqhZpIFA65FxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9cdc8b-1cc8-44e2-8daa-08dbf680fcbc
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 17:30:06.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FunnHx0uWECmce9xuMAD6ZYI7s/ZFRu/BS9ighYMplOxB7mpeBQHJGoFk3mYWaDYIHv5jD7xKQY/JbIaiKeO8RbzA2S1dhoDqlTtpc95qwg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_16,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060141
X-Proofpoint-GUID: ErirpR87RLAFYlFe1dYVlhSMYf_F0PmF
X-Proofpoint-ORIG-GUID: ErirpR87RLAFYlFe1dYVlhSMYf_F0PmF
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

FYI, these patches still need RB:
  migration: propagate suspended runstate
  tests/qtest: precopy migration with suspend
  tests/qtest: postcopy migration with suspend

This has RB, but the interaction between vm_start and vm_prepare_start
changed, so needs another look.
    cpus: stop vm in suspended runstate

- Steve

On 12/6/2023 12:23 PM, Steve Sistare wrote:
> Migration of a guest in the suspended runstate is broken.  The incoming
> migration code automatically tries to wake the guest, which is wrong;
> the guest should end migration in the same runstate it started.  Further,
> after saving a snapshot in the suspended state and loading it, the vm_start
> fails.  The runstate is RUNNING, but the guest is not.
> 
> See the commit messages for the details.
> 
> Changes in V2:
>   * simplify "start on wakeup request"
>   * fix postcopy, snapshot, and background migration
>   * refactor fixes for each type of migration
>   * explicitly handled suspended events and runstate in tests
>   * add test for postcopy and background migration
> 
> Changes in V3:
>   * rebase to tip
>   * fix hang in new function migrate_wait_for_dirty_mem
> 
> Changes in V4:
>   * rebase to tip
>   * add patch for vm_prepare_start (thanks Peter)
>   * add patch to preserve cpu ticks
> 
> Changes in V5:
>   * rebase to tip
>   * added patches to completely stop vm in suspended state:
>       cpus: refactor vm_stop
>       cpus: stop vm in suspended state
>   * added patch to partially resume vm in suspended state:
>       cpus: start vm in suspended state
>   * modified "preserve suspended ..." patches to use the above.
>   * deleted patch "preserve cpu ticks if suspended".  stop ticks in
>     vm_stop_force_state instead.
>   * deleted patch "add runstate function".  defined new helper function
>     migrate_new_runstate in "preserve suspended runstate"
>   * Added some RB's, but removed other RB's because the patches changed.
> 
> Changes in V6:
>   * all vm_stop calls completely stop the suspended state
>   * refactored and updated the "cpus" patches
>   * simplified the "preserve suspended" patches
>   * added patch "bootfile per vm"
> 
> Changes in V7:
>   * rebase to tip, add RB-s
>   * fix backwards compatibility for global_state.vm_was_suspended
>   * delete vm_prepare_start state argument, and rename patch
>     "pass runstate to vm_prepare_start" to
>     "check running not RUN_STATE_RUNNING"
>   * drop patches:
>       tests/qtest: bootfile per vm
>       tests/qtest: background migration with suspend
>   * rename runstate_is_started to runstate_is_live
>   * move wait_for_suspend in tests
> 
> Steve Sistare (12):
>   cpus: vm_was_suspended
>   cpus: stop vm in suspended runstate
>   cpus: check running not RUN_STATE_RUNNING
>   cpus: vm_resume
>   migration: propagate suspended runstate
>   migration: preserve suspended runstate
>   migration: preserve suspended for snapshot
>   migration: preserve suspended for bg_migration
>   tests/qtest: migration events
>   tests/qtest: option to suspend during migration
>   tests/qtest: precopy migration with suspend
>   tests/qtest: postcopy migration with suspend
> 
>  backends/tpm/tpm_emulator.c          |   2 +-
>  hw/usb/hcd-ehci.c                    |   2 +-
>  hw/usb/redirect.c                    |   2 +-
>  hw/xen/xen-hvm-common.c              |   2 +-
>  include/migration/snapshot.h         |   7 ++
>  include/sysemu/runstate.h            |  16 ++++
>  migration/global_state.c             |  35 ++++++-
>  migration/migration-hmp-cmds.c       |   8 +-
>  migration/migration.c                |  15 +--
>  migration/savevm.c                   |  23 +++--
>  qapi/misc.json                       |  10 +-
>  system/cpus.c                        |  47 +++++++--
>  system/runstate.c                    |   9 ++
>  system/vl.c                          |   2 +
>  tests/migration/i386/Makefile        |   5 +-
>  tests/migration/i386/a-b-bootblock.S |  50 +++++++++-
>  tests/migration/i386/a-b-bootblock.h |  26 +++--
>  tests/qtest/migration-helpers.c      |  27 ++----
>  tests/qtest/migration-helpers.h      |  11 ++-
>  tests/qtest/migration-test.c         | 181 +++++++++++++++++++++++++----------
>  20 files changed, 354 insertions(+), 126 deletions(-)
> 

