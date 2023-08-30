Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D978D75B
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNYs-0006z7-8M; Wed, 30 Aug 2023 11:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qbNYn-0006ye-Qj
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:56:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qbNYl-0006ie-6x
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:56:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37U9iOVp022320; Wed, 30 Aug 2023 15:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g5CsjaJQrdKXuOSxyLYi7s+zvEUnx3kE0V1hjzBOPYg=;
 b=Djh3ENkp8crJwiuW2mBW5OYBvrBH4OzeLykK5LLZuB5zNQ8SLvqujhUm7NOqKGeFICe8
 8yMTqhW4tIyDf7qyeVHxMs0TpQhz7jNAQtd9wYc4t4TkVkB8R/91pORhC9wzEVP2Ex81
 EjEOg++hsQSW4ureT+rTVMgeO/DdZW5SeX3iRVbR6b3cerOzdqE653QvmPAvbyUF041r
 fN5OpBhVpuljIDmey6kzBMxYB3ZIZwX0iO9IjAyTSGu48j7fpHhB35s2vzuEq5Td1tfJ
 CbM5UG+rHFDewkKeto0u1w2zJi7+bdaLSNmZD46JLuTGrlQWQHJlj75RcYgZXsMXoA0E Qg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9gdynbd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 15:56:45 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37UF63V4024342; Wed, 30 Aug 2023 15:56:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3sr6dpqbmw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Aug 2023 15:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWZYbZ0k3T2UfrZlyFPnxxxjKUrlvn+fI+HkQD5hVX0A8KWO3nWFhSajWCvNxIU1hRuklmduCGMHYn7yeHfqs/pA/h9fL8UerDw1fb0SzVZTLbPQsBrX6D0HZsMLBpBaBAwLTmANfQmqK3XPIk7xjv/cBedLLxuckcXQkGmU7aavIHK5OwsExZwEgUTc2d/UReb2eFKWUWQWfWe9iQE3hh0nKtuidDoTPeojQkGyPSs4/3+XyOssZSuiT+HjWnQ1Pl8/5iQU9tHvLvAGo4EY37TOBppA0/KfgAIV1RYxz6jYjNawRGbLnXf3U7+Xe98za8fMe1HPBrF7xKM3r1FkXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5CsjaJQrdKXuOSxyLYi7s+zvEUnx3kE0V1hjzBOPYg=;
 b=nAmseZLU4Sup544jt8tz85yYjJJp4q+Hv4lSRkH4xr/mX0RSHPM2JIv/2Bf1v4VSTn/CpRl4Ki21qMWrbp9j0bie+Gc+Md53CrcsA4vNGnpH+JCE7tZJKjUZ/FgAYNyret0qS3Tow5bfqcBjahhInP5lSOvidA+lpMPMEh5rHIEcwCkycZtG85QP0AJQXrKe0vAJGTXMH204NI+2OgLD09AjAx6vTcPEpvFXOStn5NRMO8lw6a56J3uNDYuJs8+SDZMljyfOeKZsSXhYetMRrwWDSG+LmyaIyd6xwnGScCrQhrJivC5P6q3qL0zppc3/L7So9Eccxamvb4ggtUk6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5CsjaJQrdKXuOSxyLYi7s+zvEUnx3kE0V1hjzBOPYg=;
 b=zMbJDKM3FJM1TtLVGKHPAHF4KuPf4uqRRdtxY4mKZrBgQHzK6UII/yhxPrAIYWrwF1a+uNebAzvapgeq2Jf75WMChxM/o8lmF7Psnj6so9qZ1B6FJjSmovK8jiVrD2Hhp1UzC20SRT2i6zdyfuw4pOcpmOkCidtDRztkfbmqDL4=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by CO6PR10MB5651.namprd10.prod.outlook.com (2603:10b6:303:14e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Wed, 30 Aug
 2023 15:56:43 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 15:56:42 +0000
Message-ID: <926ccd13-cf67-a206-4722-6ebc26cff60e@oracle.com>
Date: Wed, 30 Aug 2023 11:56:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V4 01/11] cpus: pass runstate to vm_prepare_start
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1693333086-392798-1-git-send-email-steven.sistare@oracle.com>
 <1693333086-392798-2-git-send-email-steven.sistare@oracle.com>
 <ZO9loC9zzEAwZJjK@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZO9loC9zzEAwZJjK@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|CO6PR10MB5651:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b67134-a747-456b-b047-08dba971b475
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOWkZZ14PUDrLE2Xg7319JG3ipXQ692TbYudJXl2uKAjA8MtszqFjTyFFwaT4VAr+XH9uRJGpl2RKGsrAQ4J3KOM03QvrOYF26dkskKxAmr+q+74JxzKfcDJGBLXQOl2Zjsfgh+RGfNEeBHrNPQhcYAMPbDqKJDHRdMlcbEKiTEj7thfadjP6dJP1+pxV098B7u6MRxkpDdit3vKlYGoxEN2ZodSVTLzOyW2lyKgP6R1PcF4m8wqibfH3h4esYQJ2S8sI3ODoWoVyhGCrJiLOhHUWf2uCFW6BAR47skGeUvQlxr641b1x3vcjVdDD/fo2t8G4geh5+GUoCZ0bGz4CBoT8maACCV+hooTOAM9XpWaw8f9QgXQNsInlLq0aQ5vMNcTNpNnuvDpN4XBRsHUSmJF7WTer/N8NlcoqL5QcqWLSOFwjht0rFIQXibapsCxApmlpuc5QvV3Z9HOHs2WfkqdNa0ZfBB2i/F+gs/aStaECLtx2xqAFF6Ad9pczIDJXmvQhy5l/cBD4LsjiZZgu0w4MjcizkF3OkQq0dSMbfWMkdR031qk0PcXIP/P7WGuHsRI0DFPTjE0Amdy/6cRv+aDj7HPuuoLq8W+AF07aJ/bBPw8X1qU6R71sFyK+HgzGBTAkAOHVytia0G+Ua6OdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(186009)(1800799009)(451199024)(41300700001)(66556008)(8936002)(83380400001)(4326008)(8676002)(66476007)(478600001)(6666004)(66946007)(26005)(316002)(2616005)(6506007)(54906003)(6486002)(53546011)(36916002)(6916009)(6512007)(2906002)(38100700002)(44832011)(5660300002)(36756003)(86362001)(31696002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2dLM29wTHRxMWd3VUFLOFlOOGtVTVQvYU1JNzczSTFyVGZ4RHE2K203K3Nw?=
 =?utf-8?B?UzZsdUJSODVhZ1d4cFJhdkpubElPc0F5WFVDdEhORDZLRlJyUmJqR0RKbWxs?=
 =?utf-8?B?a1hMNlNjVnpPVTdET0VJWkFUcU1XMGJNbysrVTVJeHZHZFc2aWR4L3hqWUZS?=
 =?utf-8?B?R05qL1NHMHhpUDUwa0JRZVdjcURpemJpUjUzZ29zcFBzL3ZadDdoT200ajQv?=
 =?utf-8?B?bnpFUXgzdUxGYTc5MjZybUwyOXBZcVgrREpvRmdtZjg2L3lRUzZpdjRuMHNm?=
 =?utf-8?B?OXpVdHBpWFRwbkxQYkgxbUJkTVRoWHlDeW5OVmpseXUvSFlrSFg0WCtZanRN?=
 =?utf-8?B?K05zbUs1YTlWZmhxQVpsU3BqaU1Qd1piRGUyL1ZHM21vNDkySUVrMmdMZnhx?=
 =?utf-8?B?TlpWNnhnSGpBeUFlYmVOVDVBU1lNVHljalU2Y3ZNS1dpUWJ2MmxzVithVUNF?=
 =?utf-8?B?bThXUFFRbnp3ZFZjNFo2VDdQL1JkbVNLSExMNFJSbUxvMXU0dW1WaTFjdTZT?=
 =?utf-8?B?cDJESmJTQ1dDc05od0lHSWhYY2ZuU29UMHF0bWlNaTFnKzhvVmRzSkJhSWpw?=
 =?utf-8?B?R1haZCs3bzkvNlQwbG5ZZU5nVmtxclZRclZBRm40SWFYRFdIbUpUaHJtdVA1?=
 =?utf-8?B?TEZEaUNGaGpVL1BLZ203bmxTelhIU3gyMTJVNWtNRW0xby96SlJiSk5GSDNL?=
 =?utf-8?B?NzZ4Y1AvS3l1ZGpVSC9nM3ZjQUhlN0dFdTN5VnVOcklrOS9TT0VwSTRlNStE?=
 =?utf-8?B?OE1LK2JhaDRWQldoaFl0eTJoYlJjSHpHWVA4UHN4azU1YldocnRNY2EyTzlE?=
 =?utf-8?B?ZDBmblBFQm5YdkpscWZiaHE2T3NZR21jVEVyOFN1UnNocHBpYzRabHVoYi9k?=
 =?utf-8?B?V3BJM0o4QkUybzR1dkJPNDNGWDhvNisxZHBJQVVNRFZUbE1OZHQwZkNydWFv?=
 =?utf-8?B?OGlna1pMNkhJTzlrVW9ZdDc5UDRZZkdnaXBnWkNXN0drc3QvM1FoT1gwSDB3?=
 =?utf-8?B?SVh0dTBJSS8yck9tSW1uWkFsTXJ1Smg5QlRCQktoTXlXNSs1VEFaaUthNlRQ?=
 =?utf-8?B?QzNpbGNIUTBXbjVsak4xYnZUY044STQ0eUJod3ovRGtqU1ZHSStJRHlOWUxq?=
 =?utf-8?B?VmZ1Q1hEWTQ1M2tVVmhKK3dpWGE2OHB0aEd1RkJzWHEvc0k0aW0rSnh4ZFA4?=
 =?utf-8?B?bU1XdHlGWUdzQWVUZG5ROWRMcEI5WEpZZDhWRWlON2lzZlVvOFE2WjdBN25r?=
 =?utf-8?B?SXgrSDFzaytCeWNtWTFzTlh0ZWpvUUFGcmxhMExGMUVSZTIwUjFhT0FVMUdp?=
 =?utf-8?B?bi82NEZxbnF3MlV0enlvd1cyVmM1NEtXYWJ0REN3YjRvbVk5VnBvQUJ3VDhH?=
 =?utf-8?B?MStrVDRFVmwxSTh3MzV4VWhOdzhEcWR4UWRaNENFZDZhdTZnd2JkUzFnOElG?=
 =?utf-8?B?ZUMxSnhoME5oS3p6WllxbjJhcGVJSDQwQWk4My9SUGxrMEJYNXlWTDIwaVM4?=
 =?utf-8?B?dTZMZTlnempSa2VMYW9zenVIUDNlL1hITGhTVnNCdmdCQXBNY1Z4L3hlL0s1?=
 =?utf-8?B?WlFRQytrUjhCWEozUG8zdW1VV1dnclRyM3A5SWdLckxJWWZDWTVqdWRva1RH?=
 =?utf-8?B?QTVwM084SXFKbzR1Nk1OY3JzNHI2UmtUR28xM3Vuck8zUnYrRngwUXA4RFBM?=
 =?utf-8?B?Zm83Wm15OThvTEFuR1hIWFpVUDFHSHhMOVdERE5mNVZhbk5XMW11Tmk0emtu?=
 =?utf-8?B?S2tleWFadEZkV3ZXM3hYKzRSMlZQT1c1UGNrT0dXandraXBBOXhTVzJlQnNw?=
 =?utf-8?B?SXJTdHd4UngrOUgwMVJMWkUvdUVWMEk4RGNKbTVwc20xMC9KMncyUFZMU1Fo?=
 =?utf-8?B?aklYTzZFNG9UdzZwVkFEWmRRMUhlcTk4bTh5MEljaFdrSWVUTkhmUUtvTGNu?=
 =?utf-8?B?ejJRQnh2dThoR3psa08zdmJRaE1qWTdSdFBkQjJVYUNLcjQyOFVFV0lBa3lZ?=
 =?utf-8?B?aVhsaDVSREZ6azAxZkdBUFpCb0NtOVJGR2dxS0RzQXZUckhQYThwOWd1cnBo?=
 =?utf-8?B?cEhzLzJpU3VqdjdPbFM1NjFBZzhGQjcwV1dNRnRxZkRGcEdHTGZjMlJFN09k?=
 =?utf-8?B?K2U4MUdrTTFnYng3cTNTdVAyRkp2OWRvOTJLYnE1NVRjZXVvN3hxeVZYNVJi?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mVMp+st+LCiyXQP8YjZ6q4+d/2e2P4UD1RC0UVjSxhg9Aoj0mkKOhJWboeewrKZGI8h+Rn5SdH6xk1tNkwYqMeboUBIw3NT+/lsPa6YuuUS1ZPw9QR9toLr1NCV1/7rtqvtd3cDKwsgcxu0OzSOAbm13xxnvRIrV0NB0HGEh1vYrEo/9CejE/IsuDr9reDbZr4UjntJhwZSzMlu/tMh/nmj7hUObdm4gp31J4f1mjsVW9A4Qhho8hzS/9ai1XeZyvwYTnlznZ5+jCeIT3afI2vUrua8Dog19ZFFXAbuIWBL8cCLO6wTJklD2Kayqca0VW4OVatCX6bmuHiwI+PVsw5Aq3XfuU52xVz5FgC1QUzhW0a5gWmkR7n3dR02w8sCFM44/Bw0LVaQG6EgJhoIBsNw+ptrvOKkqqjotAn7+P74VYEwuBr1+SlZeltlmQBprJAYpsCqaL5zUrHMvU6GJ4ooYp+XvREccimfA2TwXS/LANL39WFrcPaJs2+mRccX9BDWkKOFNgrH+1V/kTzdGDOTyKgwtReozvqE3LVGceQTqPFpouRvU2p3jISEIm9yT+HxiNp+5TD5jGAfDjEt4XGiHSJ4XeAjl50BYqvYcN9IofXPFs0LOe5F5WXl0AEBLdUHhrT9XacAuKpidlIpMh3Wd4A29if05CJzz72qy9qKiWBQeb3s1YjPJ+6zYJhmpjYVCke8fWyIN0ECvTJCAh1b4nNmANxiCa/NignSu+/GAnyuMdRt5z+BZd3SLcwvKBGThOX3DS7HKAdIKMdvYvw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b67134-a747-456b-b047-08dba971b475
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 15:56:42.8888 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2E8/123EaPLcLe/Xupya8DALxBNZyZGz2iCs1HX7fTdgtz96o8tTVOD8miqq1mB7jJGQirw8TgH89JkHN1NRdIBR9tf66Hgzd3J0dJu6Gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_12,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=889 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300148
X-Proofpoint-ORIG-GUID: -9FIWDVU19C22-T5-B1q1WP74WUKyY1t
X-Proofpoint-GUID: -9FIWDVU19C22-T5-B1q1WP74WUKyY1t
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/30/2023 11:52 AM, Peter Xu wrote:
> On Tue, Aug 29, 2023 at 11:17:56AM -0700, Steve Sistare wrote:
>> When a vm in the suspended state is migrated, we must call vm_prepare_start
>> on the destination, so a later system_wakeup properly resumes the guest,
>> when main_loop_should_exit callsresume_all_vcpus.  However, the runstate
>> should remain suspended until system_wakeup is called, so allow the caller
>> to pass the new state to vm_prepare_start, rather than assume the new state
>> is RUN_STATE_RUNNING.  Modify vm state change handlers that check
>> RUN_STATE_RUNNING to instead use the running parameter.
>>
>> No functional change.
>>
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> I think all the call sites should be covered indeed, via:

Indeed, I laboriously checked every handler, like you, and then I realized
that searching for RUN_STATE_RUNNING outside of runstate.c yielded many
fewer call sites to check!

- Steve

> qemu_add_vm_change_state_handler_prio
>     qdev_add_vm_change_state_handler
>         virtio_blk_device_realize[1653] qdev_add_vm_change_state_handler(dev, virtio_blk_dma_restart_cb, s);
>         scsi_qdev_realize[289]         dev->vmsentry = qdev_add_vm_change_state_handler(DEVICE(dev),
>         vfio_migration_init[796]       migration->vm_state = qdev_add_vm_change_state_handler(vbasedev->dev,
>         virtio_init[3189]              vdev->vmstate = qdev_add_vm_change_state_handler(DEVICE(vdev),
>     qemu_add_vm_change_state_handler
>         xen_init[106]                  qemu_add_vm_change_state_handler(xen_change_state_handler, NULL);
>         audio_init[1827]               e = qemu_add_vm_change_state_handler (audio_vm_change_state_handler, s);
>         tpm_emulator_inst_init[978]    qemu_add_vm_change_state_handler(tpm_emulator_vm_state_change,
>         blk_root_activate[223]         blk->vmsh = qemu_add_vm_change_state_handler(blk_vm_state_changed,
>         gdbserver_start[384]           qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
>         pflash_post_load[1038]         pfl->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
>         qxl_realize_common[2202]       qemu_add_vm_change_state_handler(qxl_vm_change_state_handler, qxl);
>         kvmclock_realize[233]          qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
>         kvm_pit_realizefn[298]         qemu_add_vm_change_state_handler(kvm_pit_vm_state_change, s);
>         vapic_post_load[796]           qemu_add_vm_change_state_handler(kvmvapic_vm_state_change, s);
>         ide_bus_register_restart_cb[2767] bus->vmstate = qemu_add_vm_change_state_handler(ide_restart_cb, bus);
>         kvm_arm_its_realize[122]       qemu_add_vm_change_state_handler(vm_change_state_handler, s);
>         kvm_arm_gicv3_realize[888]     qemu_add_vm_change_state_handler(vm_change_state_handler, s);
>         kvmppc_xive_connect[794]       xive->change = qemu_add_vm_change_state_handler(
>         via1_post_load[971]            v1s->vmstate = qemu_add_vm_change_state_handler(
>         e1000e_core_pci_realize[3379]  qemu_add_vm_change_state_handler(e1000e_vm_state_change, core);
>         igb_core_pci_realize[4012]     core->vmstate = qemu_add_vm_change_state_handler(igb_vm_state_change, core);
>         spapr_nvram_post_load[235]     nvram->vmstate = qemu_add_vm_change_state_handler(postload_update_cb,
>         ppc_booke_timers_init[366]     qemu_add_vm_change_state_handler(cpu_state_change_handler, cpu);
>         spapr_machine_init[3070]       qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
>         kvm_s390_tod_realize[133]      qemu_add_vm_change_state_handler(kvm_s390_tod_vm_state_change, td);
>         usb_ehci_realize[2540]         s->vmstate = qemu_add_vm_change_state_handler(usb_ehci_vm_state_change, s);
>         usb_host_auto_check[1912]      usb_vmstate = qemu_add_vm_change_state_handler(usb_host_vm_state, NULL);
>         usbredir_realize[1466]         qemu_add_vm_change_state_handler(usbredir_vm_state_change, dev);
>         virtio_rng_device_realize[226] vrng->vmstate = qemu_add_vm_change_state_handler(virtio_rng_vm_state_change,
>         xen_do_ioreq_register[825]     qemu_add_vm_change_state_handler(xen_hvm_change_state_handler, state);
>         net_init_clients[1644]         qemu_add_vm_change_state_handler(net_vm_change_state_handler, NULL);
>         memory_global_dirty_log_stop[2978] vmstate_change = qemu_add_vm_change_state_handler(
>         hvf_arch_init[2036]            qemu_add_vm_change_state_handler(hvf_vm_state_change, &vtimer);
>         kvm_arch_init_vcpu[567]        qemu_add_vm_change_state_handler(kvm_arm_vm_state_change, cs);
>         kvm_arch_init_vcpu[2191]       cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
>         sev_kvm_init[1014]             qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
>         whpx_init_vcpu[2248]           qemu_add_vm_change_state_handler(whpx_cpu_update_state, cpu->env_ptr);
>         kvm_arch_init_vcpu[70]         qemu_add_vm_change_state_handler(kvm_mips_update_state, cs);
>         kvm_arch_init_vcpu[891]        qemu_add_vm_change_state_handler(kvm_riscv_vm_state_change, cs);
>         gtk_display_init[2410]         qemu_add_vm_change_state_handler(gd_change_runstate, s);
>         qemu_spice_display_init_done[651] qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
>         qemu_spice_add_interface[868]  qemu_add_vm_change_state_handler(vm_change_state_handler, NULL);
> 
> Looks all correct:
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 

