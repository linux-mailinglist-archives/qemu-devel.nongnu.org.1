Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B4726244
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:07:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tn9-0005mN-Dl; Wed, 07 Jun 2023 10:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6tmu-0005mF-Uh
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:05:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1q6tms-0000zF-OZ
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:05:24 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3576KGXD007279; Wed, 7 Jun 2023 14:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FwUh7c5Bma8WEd4of+09fgVI5GhdBwuP/9SqnVIKM3U=;
 b=xwjEOWDIbG8ibvX9ZXqnkFOBzEkqj+FFnWH1fZuSLG77h0iAkzvwUmxQmPESJeZKeseL
 +0hIVwOhK+M4w9ELysQn7Pvzpth3nFtGdJR4aCAgdbfKrdO48uCXrvOm033G+hC5fIzD
 PNdihhanoAHXeysNMBZQhs4HIAd6jf1ayrZ2SVKTufCsWXMHic01JR1yLkUPryWM9WAv
 IfnT0rmn25JDt0IEImZK6tfEa6kgD8EyziDhaDtowiKmXvs7q5DDTDRi72AreQw4ZJJ1
 bpdxV/Cw2ij5jwHDS+SOf/Yvba3dGQ+4a7W8xn44fX+zE67ZQnuUQ+NDs7b/APm0Cmk1 3Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6shvnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 14:05:19 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 357DF2ub036752; Wed, 7 Jun 2023 14:05:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3r2a6h9f1x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 07 Jun 2023 14:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZ85z4h69rlTLf1GFH1bTGdi04zMEM24Ah+SnSnycV7FnZIbtCrrrsLlvydXXQ34F/2/5U5XDBgOm6fbPHTZYe05QsrbNRVG48aFL9L3tyc4VGj6hHXeFMplN9sKZU3q0bmWBX47dYCago55/haKgQE8ZbgaTG1RaLgfPp0nu9D9Y89EFJokJMqAPx3kB6rTuDghspdZ8MkWfSBxE/KzyZh8BlpYQGzVIDB3ZdcwDplxwCAT5OJSndyMTTGQMfQLquvNzXTrTQ5AV6vPnnt5peSKqsJvK/dwuH9VFvwj2fr0/2n91fmsTFHzZfTI905JKeOyFivn6exvdfssO1jDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwUh7c5Bma8WEd4of+09fgVI5GhdBwuP/9SqnVIKM3U=;
 b=YFGW4/yEUswrBiD+TxIlbNA4We2dCes7Il9rIghvocoHnuxVI4qWtDCaPws8cUcXu+yYkzsHsRgyz7HHbiGwVmWBMMYd1QY8qzM5LZ81AK3FvGXsz0RyOcE27fCqgtnrYdVrY4xyXivMoi/Ty2kHRWuxQybtZ67Old+msPBxKtQE8jLyKSwok9vO6Fy+XZm7nLPUBtVqyzY/l7Zw2lieSwTe1VUSwX2duN7TQpJvpC8FksVeL9GgZRU0gQxzBfqQTZKgHrnUCIMIS7Hrz6shBH1czmeoFgbrf6Er+d7XN1uxpa/L3VeE7Fy1VfXjsbfOI4msfbWVuI8mkYnw+gZreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwUh7c5Bma8WEd4of+09fgVI5GhdBwuP/9SqnVIKM3U=;
 b=WWJCMW4Twz0xy+ypD/WFj9hO4inT490mzjk9drn3V2SkUM6ALEyA2JFACm3N4fpAkIkdPZZJxgBzq6S1fREBheA5SLR6WEpP88khGyoJxLUTTkdPXwF1qNd2Exk1csvEZiP+4Uk3FFusheLOMhPxAdNPb09et1TPLaZdodkVR54=
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com (2603:10b6:a03:2d7::23)
 by IA1PR10MB6899.namprd10.prod.outlook.com (2603:10b6:208:421::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 14:05:15 +0000
Received: from SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120]) by SJ0PR10MB4686.namprd10.prod.outlook.com
 ([fe80::36d3:42ea:8103:b120%3]) with mapi id 15.20.6455.027; Wed, 7 Jun 2023
 14:05:15 +0000
Message-ID: <331c7f30-a68c-2253-5bb4-f67935e1bca5@oracle.com>
Date: Wed, 7 Jun 2023 10:05:11 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V2] memory: RAM_NAMED_FILE flag
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe.mathieu.daude@gmail.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>
References: <1675796613-235716-1-git-send-email-steven.sistare@oracle.com>
 <Y+KzMDdc+F9zHMh2@x1n> <25b316ac-18da-cd63-fd36-472db6ae9b51@oracle.com>
 <Y+P2k6iDQc0x0xtT@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y+P2k6iDQc0x0xtT@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:806:126::19) To SJ0PR10MB4686.namprd10.prod.outlook.com
 (2603:10b6:a03:2d7::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4686:EE_|IA1PR10MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb4365a-1f31-4311-8ef5-08db676037e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u2gxoPsththmlG5PXfC3yfymhD9i+98iMdpk/xIxfuGkW7Nnh2QgEUfOvXWDQlW2GJSy/cl+DT30uIFD0gciUE+iy4dHBwg36A1jizGZKtP4Jp6fCzeyzTwJcw/dVi3kyCJOnTLRhNFf85zLdPjtqT3ZmJcq/tPSleTstF3w8kej5Prs6EhVH+zy8LghS2B2enkKTkucOwi/YEYQ643e3WGpOuNSSdelycKOGtdsOqk2n3mpYQCZXQaRwz7RKeWWn5EOD/VGrmxiJFKA2T8ew6pJbO3CcCaat81ocu/b1I9f0K0G8/k3SNNdL4VQpukS+D372Ydh59RNg7h0szM4YDbVFcZNq98/MsEz9PxG1awmjvZ+LvEGtQ51bCREvNb2QHwvxF8UHifIYdVllC2C8e4zyeWYlZhzr1FiS40va0ZfZMg6Qbzb5eagH6pupLh3oVyRlleCtYOejMGP+QyU7ytKz5R+jNeqhKHCW6PoWQEs0/OVELkAQ9JJuD281Cl04bRhEFCIaChBxpttPBQuSue9WGDwFyLWkrKklRgLYOQVAZjeMTS8AVMwCwQSBDVlzmCfnCi7fMQSwDwZLWqiGh3aF31M8C6V8HGdHKHmMel4cqCUDvHbVBE6T0n2ePj0m4ETKm3r9gacoLpatlqTgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR10MB4686.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(31696002)(2906002)(83380400001)(2616005)(36756003)(86362001)(38100700002)(6486002)(36916002)(41300700001)(6666004)(5660300002)(316002)(8676002)(8936002)(54906003)(478600001)(66556008)(66946007)(31686004)(66476007)(4326008)(6512007)(53546011)(6506007)(6916009)(26005)(186003)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW5Xb2FVTHdTQ004aFNRRHpYQXZqbS9PUDJ0enNLWFdyL1lQRXFUdFRKeFdR?=
 =?utf-8?B?YUpWdlg4MzRJUXFVTys1NmtrMTNIV1ZsTXBxdVh4dkpJVWRWRFFCVGtrRjY2?=
 =?utf-8?B?Q1JFZlk4Qy9sV0xtTW5mZDV3b3dOOTJVMTJUZ0ZQOTZ6VDZQYWdPMVpNd2c3?=
 =?utf-8?B?MTg5Z2FMVWhQTTl1OUQ0bkovamhzRDFzb1BBNlJmRmVaNW1WRnZ2a0doZG9F?=
 =?utf-8?B?K0JpN1ZkV1ZiNVFzMUdxSkRuZ0E2S2VKUnVhb0dOSElHTmR4dGN0WkYyQXp2?=
 =?utf-8?B?Wm9Fc05lTktNQzBIVW1uTlg3VEJLdE5IY1RVVHo5NkhCd3orUEhzc1ZIRHN6?=
 =?utf-8?B?V1FuTGpJVThYZlRWTlJwN1VuWXQxaGtTWFVtZGFzZ0RPanVIWWxjbGE3UUda?=
 =?utf-8?B?SzJ5SEdnNXphTEdxV001N1hVOFRpZ2dYQXNaVmhRdk5YZ05lSlZ6Y1NhWWlQ?=
 =?utf-8?B?NUpJSnZwckI3akxFNEx6dXpMeHpwU1ZDN0xtMHVWZzBZTkh5anhPeGYvN2kw?=
 =?utf-8?B?ZHgrM1JHNkxaUTBEU0xxWjRWVHBNamJseVdzWXpJck1MZEhxS2FiaDhZSjVG?=
 =?utf-8?B?Y3lsOWwzNGZMTGFVQ3F2MUZyRmViQzFmcVQrWm51ampDTjlRNE1FZDdNRHg1?=
 =?utf-8?B?OElqUGc4UEVtanNrYy9tcGk4ZjFRVVg0VjRON3RCaytaVnBwQTlaWEhDMHRp?=
 =?utf-8?B?S2g0dGRpZ1RiYWtnZmRDSnh3MTZqQnR4YVZFQ2JGMnB1MmhucEsvemx6Sng1?=
 =?utf-8?B?M1YzWTN2K3hweXBXTlZWL3p1OVdITlNjZlRRTURua3R4TWRDeElDUE5sekVR?=
 =?utf-8?B?SnV1NUViVWZ2Wm0zbXY3Y2VkMEM2RWcyRStxbUZLWVp0ZGV5VU15TzJLWnRs?=
 =?utf-8?B?YmlOL2REOHBmT3FrVm01RkUrZXhaUHJ0d3dseDlIeTRJdHhRdGZOdHk1Q3o2?=
 =?utf-8?B?a3pKOU5MZm5jck45dGZWZDY3YmY2NXhMRC9HZ2xMOEFtYWIyV0FzdnU5WHlu?=
 =?utf-8?B?RGlQUElYNmNvNVV2QU5WU1RUMWwwSFhSSTd2VnloQ2ZQM2NWMERReTRTT3NU?=
 =?utf-8?B?RVFpZG1OMi9YNVBOL1hIT2lGN1l3QXJZc3hEeUU3VERpZzkvS29tcWRxTVRr?=
 =?utf-8?B?elZxb3hWQWlRdGkwUlZmTVVtSW5Vdkgwb2dBUWNkc256S0tSY0ErdytXTWZp?=
 =?utf-8?B?RkhQOG93djB0VERyRThIZkRZM09jZHdrcnFuc3pUWCt6N0hscmx4WFZYaGZk?=
 =?utf-8?B?azNGb1hEUHVObWNqUVlLTnhQN0lIU1N4RmlxVStPR21wVzcyZG54T2d4Y3B6?=
 =?utf-8?B?N01KT2xqQUJ3U2x6QlJ4TDFhK0VtakdLRVY1QVQzRlFvZHgvbmtpblpmSjFr?=
 =?utf-8?B?WTZVTUhXeDJhNEoxblhENm1rbkNoWVpUSStBTmJpa1h3MHNBN05lVmFXbzB6?=
 =?utf-8?B?NVQ4aUNpSXZBS3gzU1JJVXB0cThHVmg4UnBDMGJFQkdjeEJLOGlrWVZKU2Vy?=
 =?utf-8?B?NDg2SFY1YVNUcjdPMnBvMzNjQzBUeWk1QzVnM2lYS1NWdjN2K1E2WkorNXlo?=
 =?utf-8?B?bUtrUEtmT3NiWExGY29HZDUxdU9SZ3FKQUVzRXhrUzVDNW1MRVZpL2l3akpk?=
 =?utf-8?B?QWFwNklzQ2l3Z1c2SXZkbVFzOW43amtNcS8rQW1oUlNLVXdxbmFvRXRkY3dK?=
 =?utf-8?B?YlRqVVFJU3ZsNldMR00vd3h1SnBmdkhVcUhYSGNqNXdkbXJuVUhtalFDd2dl?=
 =?utf-8?B?cngramtIcnU3SCtiMUtJQmlsR3Erd0thZ1Z6WnFLanZ5Q0tlMzJqV3QvbkFm?=
 =?utf-8?B?eGx4eXk2bmJxdEtsanp0cWhyUHhqdEpwSi96dHpkaEc0NVY2eGRsbUJUZmlm?=
 =?utf-8?B?ZDJlT1pqZG9nbHNaVkgzT0g0Qm9YcUhjZ2JkOXpiamxmam5jYlcrUFR3SHdq?=
 =?utf-8?B?NXkzYklta0V0TGl1NDJzY0tyTElWc1BaTFVqMWRBTHdIRU5vQ3A5Qjg2T0Y4?=
 =?utf-8?B?SlhqYnFHZW8yam5qRGd4SXF0c1k0R0Rwbk1lVmVpU1NnNXpFY2dTMm9rM0Fk?=
 =?utf-8?B?aHdrQ3c1eFVvVncyQmU0SmRYSHVuZXVMSGZ2TGd0WEkxOFFRRHFZTVo5aGFE?=
 =?utf-8?B?MExuTTlxRVZtVjJNYmtEb21LM0NXQzd1YVdKMU1Oa2d6a3NDekRxQkErNFFD?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ousvVROHQUz5hHYlhbqpK/z9Tz1z1BYSW2C/3XrAb52ateQGu2r1XcF2UjZCPXIsTcU0MTJXTbSzPGTlsDlnP2yLRbztIRKBeWOUbI6TQ+AYe1zMgZlqJxErT9OtgVgxhNPTlJha68uaMyjnxgFPHcEVxSWYUEagUanlxCjo+5mPWdR4jrfoE9tefweMzEsM0vmdzh5iUoxN1tsEJswofReTaqjmGBdl868aj6APn+e7i/026IACFovr/Kw4KQokUn/c00TbNYtL/RF9buJGMXG1aRl9maU8MzJWljAqv10J3dlMRsKcUOA3ROV5NN03k0j0fSb2Mg8Rmb7TceoixTY4GWWhF9qHK4Dd5wvYSzfqgUiwzl7UcRp80o+fatNBKZC1ddXEHbkV+KBg9slulRdeTbeMr2R30/oES1Kt72Rj2e0uLkV6jWQt9qyMer2QynD60MXG3rXye38R+v6mqYToJBxl7JDIIadIRi3rxuQ027uvxMrOw9puDMixq7YVaHx5leug5BDsqNK9LHZh5Q/noNyj/7DwGA17+92ov+lrE6Ya+O+XhtydfFtTOZ4bL9XRLdft8T0lUnwu1oLF0VkMhpyFAGdaEVN9wtfltFVls5C/uZiNWH4Bqi5iKrnOWkTHwzZ5qFs1Hu9jJ08zgAIIpy5q1XwzaEjzoQVqOaqrHCq+R/Lqv3JI6wurjRqlsJSPGwD7waQbc2PwQh+mOr+QxP8l7ngGkV9rMxhU/6eplIaBPEMD5t53wlOYv9qreSTCV5UO5zd8qIDoSNIPXtt2RBTPNT3RYjZnAKF3r2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb4365a-1f31-4311-8ef5-08db676037e9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4686.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 14:05:15.7924 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOrJLSWtvTI40tnzB2SujBF8TG1guayptaAhExD1vTSdrN2BGITy/g9qBMuaSGj4Cd5kzBPGW+IpFKYiYaHb4110aUuwnI20c2It93HH1Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 mlxscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306070119
X-Proofpoint-GUID: xJbs9eudOKsgND2yEcZ2KLGbwFdYsjv_
X-Proofpoint-ORIG-GUID: xJbs9eudOKsgND2yEcZ2KLGbwFdYsjv_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 2/8/2023 2:22 PM, Peter Xu wrote:
> On Wed, Feb 08, 2023 at 01:34:18PM -0500, Steven Sistare wrote:
>> On 2/7/2023 3:23 PM, Peter Xu wrote:
>>> On Tue, Feb 07, 2023 at 11:03:33AM -0800, Steve Sistare wrote:
>>>> migrate_ignore_shared() is an optimization that avoids copying memory
>>>> that is visible and can be mapped on the target.  However, a
>>>> memory-backend-ram or a memory-backend-memfd block with the RAM_SHARED
>>>> flag set is not migrated when migrate_ignore_shared() is true.  This is
>>>> wrong, because the block has no named backing store, and its contents will
>>>> be lost.  To fix, ignore shared memory iff it is a named file.  Define a
>>>> new flag RAM_NAMED_FILE to distinguish this case.
>>>
>>> There's also TYPE_MEMORY_BACKEND_EPC.  Reading the commit message it seems
>>> it can still be used in similar ways.  Pasting commit message from c6c0232:
>>>
>>>     Because of its unique requirements, Linux manages EPC separately from
>>>     normal memory.  Similar to memfd, the device /dev/sgx_vepc can be
>>>     opened to obtain a file descriptor which can in turn be used to mmap()
>>>     EPC memory.
>>>
>>> I'm not sure whether it means that should apply for RAM_NAMED_FILE too,
>>> neither do I think it's super important..  Still better to define it
>>> properly.
>>
>> The RAM_NAMED_FILE flag will be false for TYPE_MEMORY_BACKEND_EPC, so 
>> ramblock_is_ignored will return false, and the contents will be copied
>> over the socket to the target, and the segment will be recreated there.
>>
>> However, perhaps I do not understand your point.
> 
> My point was it looked like it should apply RAM_NAMED_FILE too, because
> it's also a named file.
> 
> But..  I don't think another QEMU can share the same data if opening the
> same file.  Based on my zero knowledge on it... I quickly looked up
> sgx_vepc_open() in the Linux impl where sgx_vepc.page_array plays a role of
> page cache iiuc, while it's private per vma even if VM_SHARED.
> 
> So please ignore my comment..
> 
>>
>>> Another comment is, AFAIK this patch will modify senamtics of the old
>>> capability "x-ignore-shared".  But I'd say in a sensible way.  Maybe worth
>>> directly modify qapi/migration.json to reflect it (especially it's x-
>>> prefixed) to something like:
>>>
>>> # @x-ignore-shared: If enabled, QEMU will not migrate named shared memory
>>> #                   (since 4.0) 
>>
>> Good idea.  I propose:
>>
>> # @x-ignore-shared: If enabled, QEMU will not migrate shared memory that is
>> #                   accessible on the target. (since 4.0)
> 
> I would use s/target/destination host/ because target can be misread as the
> VM itself (at least a general term in migration code base).  Other than
> that looks good to me.

Hi Peter, I will rebase to the tip, modify the wording, and repost.  
Can I add your RB?

- Steve


