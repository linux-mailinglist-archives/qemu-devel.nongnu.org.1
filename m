Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A687F1D8E
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 20:50:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5AHL-0005cy-LP; Mon, 20 Nov 2023 14:49:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5AHJ-0005ck-7N
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:49:53 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1r5AHD-0004DE-2I
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 14:49:52 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3AKInpvX020899; Mon, 20 Nov 2023 19:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OPUrsS6ogSKCuoAPuK4HJOEEaPwLnDMLhSmf9wx9SDs=;
 b=DYKN2OOA1FluAf80PDib2ihjx0deKVFE4Mt45rDrfzCgI+nH/tYFQBfh0hhtTAzHU2ph
 pv7cTksuXlGlPYDYq3+PEWOtzwTOs+huv+yzmSUHeWR/RMzvbBbteS3etg8Fr+vP8+MY
 4Lyo7iM1jM2E/UOFIGyzjEDKuVj2NdKC7KKAHi96sZA8vawo+Zv6HXSJAZL+MgxGiKC8
 Noc6Qw4tDFSQmWVpQfbuYPUT9FrX0Iwf7JU4Gv+k+DrTBD/ohFwse9lD7YeRrszyMip2
 ptYCOnqCNnPcoU7KaXVC5JCCas/8gT75JlqOQvKSR1jXaheQlHyhokYAN9GXsXIfjsZS /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem6cbj47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:49:41 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3AKI6CKG002364; Mon, 20 Nov 2023 19:49:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uekq5vk3h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 20 Nov 2023 19:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzvnMkiEvrMRZBkRAxDgJvyfoYGFRb0wU3szWJiXjAOAWXizZPf4sYSNEmjHbffYZv+wq8ucFfzWh1KGxylwCKDpGscCnV+NE+nY9M8XeoluPOAfWNK0+Dpy1iPXRKGXBXJSeYSAvPEwMCDcW35ExvSnVrfWFXyUZoD6AwRbf4Gj9peAfQ6fE8+gOvx2ZSprw0m3z1KGV+3GKAOzBAEOLH5Vn/WhYnRWhf/hTrg65kd6HvWi2K8/BeF3OnBub7wCQU+R+T4goAjCkxrNroJfpU6ga8/Y9psuG4IaGMaol5wDQNgR426pd9v/pN0leKI9JHzwDtrol0m/2fDO6jKbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPUrsS6ogSKCuoAPuK4HJOEEaPwLnDMLhSmf9wx9SDs=;
 b=OY3XtCOToMPGjpGE/tT28g4sWtYH8XM4lHGDZICwXYkX98Qh8T1rLQYl7bX2dwodcwVSryZDPjWhi0P1j0Nfv2/E/F3bt8GlCB0osnjM9PT44z82F4h3PyKesOQTOpu1/wmq42RDS93ys1PaKwtem/Gr2yeSeywWzr8EMMEdAdQsKuOH+U7Iy2RLEOCM2/XOEQsAUC7KRPA+xqhifVbm6bDCIlVs5FM2eSCMyAAeZ8Nnh23H4OQ1lvSsGpaDH2epWrIKnLcxRjSmInrR9oq3qMRqY+VDX+TV35g8hvw8FJUS8FuEZV7/Z1Ql+poxAZ1UX2w3JIwOYeSII2ipSfXjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPUrsS6ogSKCuoAPuK4HJOEEaPwLnDMLhSmf9wx9SDs=;
 b=lInYCW9lxQ/PaS6tT9OxzZyTbmg/HsOanSJCIX3IYD/P4ZhVKGd5NmWdvJTfS7N9ChHSE8zWTSqWNl8054NIlUErMAvuU5MzkVBy9kzRs5GWMc+7+mRojPlgmMxlD0A7+N+X99XoEOjSmfxK0vV9VZsgzG/YRqYGK6EUrQto1GQ=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Mon, 20 Nov
 2023 19:49:23 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 19:49:23 +0000
Message-ID: <bc78cac4-b254-4184-be53-11b70ec7e2ce@oracle.com>
Date: Mon, 20 Nov 2023 14:49:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 01/12] cpus: refactor vm_stop
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-2-git-send-email-steven.sistare@oracle.com>
 <87leas5zlo.fsf@suse.de> <250d0338-d29d-4cd0-8e33-0520fd1fb354@oracle.com>
 <ZVu3oawbZS6IEbHO@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZVu3oawbZS6IEbHO@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0004.namprd04.prod.outlook.com
 (2603:10b6:a03:217::9) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: aafb57c6-f84a-4471-4694-08dbea01cb8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shF3BynwSnnphEt+Ys1/FLuCiD2Gs4krO+axdZZJR5X/vIGdnptigPN96S/DbRSbSi2VR634Yrvmlmm6YxHmxAO1+wNCvF4M1LZ5PC/wPep9MBkJIKFHO0p8lho6x97XpSxEpdVCAdoBaic4Bo+I7m/OrbATJE0otNTVxqFhjQ5x1soz0aiwEaSdv1BZlnxPEyk8Yt4RETXXZyFD9xwh0PPj2oYtNOPo8Y2wF+MHFUHm4YjW0TB4MV7St0ioG5cUnykh2DfsTQi/vfIpNh7L+G7lk6vDWFJ2zHLsWb+jhc7uUewzSjFTsrjcjiQVQM2uduPkE6+F1gw9rvq+pnjK6ZVSgKVNH1MpVYyIUMxuG2ehXmybySP+eMzRUCj2GTfzBev100Cli0b7LpvibUpmBtThtVVopBZdPv3brlKuvfPXTKiBIAeiw/ZunVqm9YtZgHIsB1jKOoDWtXwpxvtj/sfP1jQtAZjTiY7SUhg/og4tcg4tKNfl4ZOGO7dgBGMOhOtysq3JWArm/Ulp/dOdnjvSGDEGGSxO7E4ioJi+PuRFx5+oUBI76c07BhTjdH4HE++oxeX0RQRM0QurrnfdMvKG9au+qob8xRsFkr7BF56cO+Rewln0gWAz+kceU0FExKLu39W4fala1KQJ9UDg6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(6916009)(6666004)(86362001)(31696002)(5660300002)(41300700001)(8676002)(36756003)(2906002)(4326008)(44832011)(8936002)(38100700002)(2616005)(26005)(83380400001)(6486002)(31686004)(53546011)(36916002)(6512007)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlOeVUxSEEyaW5HZ0dCZFRHaFhQUWgwWTdaSnBuZzB1N2w0Yk1VZVJNVVJi?=
 =?utf-8?B?ZEI3QnNVZ09QR0RYWWtxQkQzeS9GbDV0dk9TZi9ydTdXM1ZudGVyOU8wNnEy?=
 =?utf-8?B?bzhwUnZPSUtzUDJUam04K2pEVlVydEtqYm80cEt1SE13cnRadFl2emZCRzI0?=
 =?utf-8?B?SGh6elFvTExVSTM5OUl0cVVpa2JVMWxsSk50OWpQLzJjb0ppV2g4TVlLZGhv?=
 =?utf-8?B?dHZGdldIYXpEOWtIUmxrL0ZBR2Z1Z1pYRWRZeHBkdW1rTUROZzFqU3FIbGkw?=
 =?utf-8?B?U21XUUZkeUVtQ1NwR0tUelVpcjZGL1UreXVEMTJIQUNxT1I1QTg1QXlEUW1T?=
 =?utf-8?B?RlFYeTdybjFxbzJyalpIK1ZBNXdPeGxFRElTdXZ1VzY3Yjd3bk50RkRVaVdv?=
 =?utf-8?B?cVZINm5CVVcxRUpVeTlCL1hGU2RRYmVtTzArTXdkZXpDdlVpOUpkekdrTTcr?=
 =?utf-8?B?d1JGWitKZ3dJU1hKeEZMTmtDdjVDRkRSSXcxbVlqbU40eW1mS2FBVkc0ZGlF?=
 =?utf-8?B?cWxNTmZBV21CZVQ0Y1NIaGtvYStoQ29nc0JUWmxUcXhyaE1oUTdqdGJ1bGpz?=
 =?utf-8?B?QUVjb3FQUXZTamF1NWZjbXgzWC90WkFaRWQrcTRhcDVodkhHa2ZreDE1OG9i?=
 =?utf-8?B?TGsySHFPRHhPVWpZQU1Cbm1RczBNK1NqQ2pydzdqanJ6c0Z1V2dnOUdsRXRj?=
 =?utf-8?B?NDlaNG9yUlZHL3ZzL2oyTGI4OC9HMEkwRHhrVi9vVGE5MUZuU2tCaDZHV0t2?=
 =?utf-8?B?UkFqOUh4STlWY2tEWTRUdHdMWFdxYm5zNGVQVXJzemt6WjE4NlhEOE9xTzA5?=
 =?utf-8?B?SGpxTUpKc0pXUzkranpvTjVNeHByYkVPbzZYWGlPVGNaMWJ5Vlo2cUNKQ3hu?=
 =?utf-8?B?T1MzeTh2ZDFlaFVDRU9hVEdMcmJjRkhyRHhKakZlZUd6Wk0vejlXVzZtZ29N?=
 =?utf-8?B?ZjdaMVVKdWJlQVJneE9QUDBNVXVxc2ZXV21tSjBPTmJkbkpXc0xOVTMwVmtp?=
 =?utf-8?B?TUhVUmZHdTdKR1BCc3N4dW9FNmJZeThWNWpRa1h6aWJUK0FTSVl1b3FZVVpL?=
 =?utf-8?B?UmNjT0lqSXFNUThHcWFSMkladTAycXpQbW1ncnhVbXRSSm8rN2Z2YlJySjE4?=
 =?utf-8?B?ekV0L3dTNHJUeHZURjVlYmptKzlyVFpDVmNPNzZVeThmb1hrZ2lSR0VVM1l0?=
 =?utf-8?B?N0FSb2lVOGJMM3ZUK3dwK2kvV3lkaUhQandBdTRQWGdyTy90cTFKd3pOL1cr?=
 =?utf-8?B?MGZOTHNpaHBJL3ZhZVM3ME5oZDhzak5sbHpwZkxVMVE5MHBXVE1kSjZTbUNz?=
 =?utf-8?B?Q2V6bnQrRG1lTWtYSUJHSlVKcFovVFJDOFZZaW1wc0s1eEZ6bWE0ZDErMHpW?=
 =?utf-8?B?QUJ1ZnRvSUlyQUVMTHdpMk80MEtnM0xoSDNGcXVMOFVqd053TVBnK0ZlK0lu?=
 =?utf-8?B?TU1HaDZyYW9XcmZDcVoyNDBNUDB2dE5YbStDS2FFRExBZzZweHNPZWd0TlZy?=
 =?utf-8?B?WkpZOFFQanZ5T2doVmRUUDZJM1g2eUN6d2Z1TFlJTDVEL3RwdCs3eEwva2tw?=
 =?utf-8?B?dWtJaC9CS0FqSlZ6Q28xVWZLMTdzMjUxWWY5M3ppMWRoOEppM1hYZmFCeFRq?=
 =?utf-8?B?eGVURGl3dUhzWkR5ZjJkQlhYdDBrUjEyTFkwVk14eGxLa3BpM2V1eXhUdktp?=
 =?utf-8?B?WWRTTlJ3dTcrL1RXWGFZUkNUTkVwUGxjcERkQ080MVh0NW1QL3UxY0VZemZL?=
 =?utf-8?B?aVZVZlprYVMvalNJNG4wdlRtYmFWa2t1NGc0dXBhWDVZZnd1UnpZZ3pvU01m?=
 =?utf-8?B?OEVGc0ZaYTJRd25YY0x5UzhlMlNzSmFZK0RFcEdpdU5kRHExMXBOdGhEMWZO?=
 =?utf-8?B?U2pJcGJ3b1p1ZTRncDNYeFF1cDFHNHJWQnVRUUJ0eFUwMWxZU2lUcktqNWNW?=
 =?utf-8?B?QllIUjZNWHFsVzJoUmJHamkyL2MwMStNZXVlaTlBSm85OFhNTDR5SWNRWUtX?=
 =?utf-8?B?L1BYZHF5Z2FyY2tHeU43bTI4WGl0Q1ZiQ1NpZkVpMklPNTljNEx2emszM1ZQ?=
 =?utf-8?B?QWp5TFFrSkF5U01peENocWt0OXpvajYvZC9CZXR5aW5QeXRNT3lBUlVkRVg3?=
 =?utf-8?B?Ukx0QlJERWl2Y205MVgyY0NjcHBYZ3RUNW5rL2U5V0o4QkMvQWlOZytmcys5?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 30yV1FN9VM5um1FJiq8ZAe2gk46eWhB3BJAqtNDZ20FaNKApa5rA7p2tTZSdRUu3fnBW6H1Pj8owdORNqwOqAUPL/03eJWzv7KdVVmb7FPY0bar6+xeeH8v5r7VMcxyFTwFkGd3ljJAoreuVXAqmFm/FdQSUifvnx6+aQweNXg0P7HInJAgAAYsGRzT3cRBIRZhQ8UWEP3UmuQzUPq9s0DXwHhDtDpldZObvjq1WOqGGp7Unfl03KFdxyvWTP5sGvd7Vqp/5l22JU2ZKRoVb58TzMTVWMkCUodryeuD4GlKwAN7Ati3m6R/PtpIVg5YWj4+KJqxU1D8MaKadMX6Sa6p8tvevnDR7Zw2eQ8MX5ut33/zDtSjBlrtiBgcPFEp/qnco0oMYSzWtyMCGaVUe0MP+TsNYuEaGkn/vMd340ju3qek0QSddvT+Ee2Q5g+nnj/Ntl1emDVR3zgpRcwC2EcCaYgsUvzS7NtEZHb+xabnqKh4cZN+Ic3v89ap+ZIm78x0wYA5alWaoaGzb6Rqgc+HyMPWOS9zrY4ob95T0qomPcaL1rtY9l1bpvxw5NKNLlrmBT5GuJwQs0xqTQiCjk2lHLDGrz5oGNfG1k5N6ySfVLLNuq0CuB2JfUa/lxXVKCK+uFEVba6sBF7wxoEP8kDo1SVsyHLurk9C1aRiX3JVjbvKwo1/B6X0vhLQ3beh2l9gKnVE74wJWWkkvhYArqVClZXR+rfcX/UplsLb5Lib0mzQyGFW69cTMMIj9hX2x0vtx+OHJhFAa03K0OTkH01tl5rbJXvHdedzYEIIwiaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aafb57c6-f84a-4471-4694-08dbea01cb8c
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 19:49:23.8539 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaK9FDcUQYCZq8HcctVZk92E33kWz5MoD0OQX2iGiAnyXWnWJuHWMhXOUXOI9d37o/+grgtWQxfnmE3Yg6NmVhJ+ppBI5zU6sqKben1d39U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_20,2023-11-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311200144
X-Proofpoint-ORIG-GUID: FEwB-l7uAartJl7cF0mc7K6HiQQNoc4o
X-Proofpoint-GUID: FEwB-l7uAartJl7cF0mc7K6HiQQNoc4o
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 11/20/2023 2:46 PM, Peter Xu wrote:
> On Mon, Nov 20, 2023 at 02:09:31PM -0500, Steven Sistare wrote:
>> On 11/20/2023 8:22 AM, Fabiano Rosas wrote:
>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>> Refactor the vm_stop functions into one common subroutine do_vm_stop called
>>>> with options.  No functional change.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> ---
>>>>  system/cpus.c | 44 +++++++++++++++++---------------------------
>>>>  1 file changed, 17 insertions(+), 27 deletions(-)
>>>>
>>>> diff --git a/system/cpus.c b/system/cpus.c
>>>> index 0848e0d..f72c4be 100644
>>>> --- a/system/cpus.c
>>>> +++ b/system/cpus.c
>>>> @@ -252,10 +252,21 @@ void cpu_interrupt(CPUState *cpu, int mask)
>>>>      }
>>>>  }
>>>>  
>>>> -static int do_vm_stop(RunState state, bool send_stop)
>>>> +static int do_vm_stop(RunState state, bool send_stop, bool force)
>>>>  {
>>>>      int ret = 0;
>>>>  
>>>> +    if (qemu_in_vcpu_thread()) {
>>>> +        qemu_system_vmstop_request_prepare();
>>>> +        qemu_system_vmstop_request(state);
>>>> +        /*
>>>> +         * FIXME: should not return to device code in case
>>>> +         * vm_stop() has been requested.
>>>> +         */
>>>> +        cpu_stop_current();
>>>> +        return 0;
>>>> +    }
>>>
>>> At vm_stop_force_state(), this block used to be under
>>> runstate_is_running(), but now it runs unconditionally.
>>
>> vm_stop_force_state callers should never be called in a vcpu thread, so this block
>> is never executed for them.  I could assert that.
>>
>>> At vm_shutdown(), this block was not executed at all, but now it is.
>>
>> vm_shutdown should never be called from a vcpu thread.
>> I could assert that.
> 
> Would you split the patch into two?  Moving qemu_in_vcpu_thread() is one,
> the rest can be put into another, IMHO.  That may also help to make the
> review easier.  OTOH the code changes look all correct here.  Thanks,

Will do, thanks - steve

