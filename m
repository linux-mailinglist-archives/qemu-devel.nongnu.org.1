Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48437988A1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qecOK-00079v-0Y; Fri, 08 Sep 2023 10:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qecOH-00071r-Bk
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:23:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qecOE-0001zk-KV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:23:21 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 388DxHZT024937; Fri, 8 Sep 2023 14:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FwREaWxIb/z4n+3dIRPmGixzmoIGF7TZdnomeFMxk1A=;
 b=aSGtkAazxBr+qv3fMgCuXMUyaw8tO0nF6mp5JZGb+SteUv6qmDY7+2U7qvRDWqMzz1Yw
 w3pfYP6C7n93AWe8H6aVAcsmFi2RgxR9+pthh3HHNSkOf2P7LuCy9LrNKSzqIGnmYT1W
 bp2wtVyU/ZZaG1UbHISPfQG59C/G1YMw7WXPtlO6CSUu4c7+DXar6nrkPKNkJGYgdfda
 R7B70+Iswh/uSS3AAWchvmKmZPcTnCpm4CXA77//kw5r08yzK2V72wQSTgvIvktzGlpt
 PTbM8oqyFc05lxqYEQYqn4bKVZrgHSPybXvxO2Pik4akSrMQnD4psFhnYK0Covr8vyzr CQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t04sjr47a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 14:23:16 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 388Ced27016706; Fri, 8 Sep 2023 14:23:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3suugffyng-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 Sep 2023 14:23:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLoi6kiOLVSv8nL1b+TrzFK9m/epoP8VGDGQ53auxiJXfzaU5siuadXAxkzWqsrtLh7K6y+oZ6kvDJfSU5G/wOEqTgp3WIZW2iOPPIk+c8v0KzbXhOgsKJyBn/T2KU/LHkG99qY/ThKzTQu2P7YqJ6N+kyuq57fRG2QVtF3sbBfNa3c+5/PHi9QD2HQTbcZam5QLb/Grycv/fccQBovAqu8qto4o9wT2vWNZC8tFbnrRRVzTTHEAk8nEarjr6+k+envy/w/FC+U2U921I8rERlgSLiIHkDWjF8elv/q5AG4whlKnTh7elcwOa/AUxBTpHeSS2M8r2c78dULSVOEEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwREaWxIb/z4n+3dIRPmGixzmoIGF7TZdnomeFMxk1A=;
 b=XhXSsOUGRW4gqPY/SP9W/lNcWdKMZ+Un4AuJTEZFwQV7jXsBonFQW61mz+SuMUTxYUrKRjqYdWTjqD6RdJXUwoRYUOwB7Vit7IeE2bg5lIRBBquiJTR3Sd6i+rbIpMwLUNQkcammuKwKv/ImoS34vF+0q/JzR1/oiTw0vKaBiNnFZcx6avgyytLmrCNOZzrGtYDq1Jm8xumBMPv5J1qQdbwCkU66KUN97N0+JgYZ7CCAftd977WKHMbhhaECHzZiS97jIblLrqLOV30MmIoEwNiRJvVr+sDPCxtHeTiKYAKSKkUcGUtcmuXS+7ET+Yr10mmsIQcTJCzYAKpJjA5XJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwREaWxIb/z4n+3dIRPmGixzmoIGF7TZdnomeFMxk1A=;
 b=LL9OMUnVGkPuVRI6YWcw0JEtgkIu0GOdVFB/OcL6fbZK291fDoYKxTl9Cpgh1JjOfz7SJSq1oEMvck34o8mW13okhfXi08BzloRIpZeZIFg9zQ1bhnLRIzm8zKNArRWja8jn3PGaEPStm4bUZALdErOy3XiEiInyT2ygn/oW1tM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SN4PR10MB5543.namprd10.prod.outlook.com (2603:10b6:806:1ea::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 8 Sep
 2023 14:23:12 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 14:23:12 +0000
Message-ID: <b61811e3-b248-9221-cc43-67d1ebe33d93@oracle.com>
Date: Fri, 8 Sep 2023 10:23:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V4 1/2] migration: file URI
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <1688135108-316997-2-git-send-email-steven.sistare@oracle.com>
 <ZO9BNnnOnLjH3bcD@redhat.com>
 <2dbbaf06-81cb-0442-05f2-f0f00deb5618@oracle.com>
 <ZPr8+zjFneDQ90Vy@redhat.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZPr8+zjFneDQ90Vy@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0498.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SN4PR10MB5543:EE_
X-MS-Office365-Filtering-Correlation-Id: f0100140-ab27-42e7-fc13-08dbb0772250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RsBxMddlkh69cvpobVOYx9kn6Ec7F48jE+35N8kF717xe6obvic2Yu8eXczrMOmy5d1VOgHFpUCRkhJw+EcViLja8X9/5PXBPzKc/0zL36hePruUyMj/lGX053QaCW9brPABZ7piggCFPjsPcepUvhtZQjdkOxoJR1uUOzsY8ws9z8CL/xNt4ASH8I4cf69PmvuC5fdp93+68bKsjUJ1UeghEUXk/JhZ+5PNWhaEUyScCiUW5X0Bs5uE3A35aUjt3hUD84NfxMbMNlcdTYzZjnaBcvAgBMFZMBI8WqRy4mo5BqzhmGtJZbphjbYImlwbGytcRL2BgqO7KOvxFXCjCjokWaAJq/nEE4CvPTBSUUHi1WHjDVTNG/ISSDFrC9OgLjvSEvMvUgeP2vp7GLhK33TG4ke435a5xpyqbEthZ9vY/JR9kq2NPxwJCvsryk+ozO0taxXQI0/gjw/iYsi8+/2jooZO4B4bPO5htOsUJIUuRBN2vMHrD1DQl+68bDu+NWPmOmG/K9lHDIe9l12JuH/Q1bJ3fNMe+5Sji3n9n2+8XbOfpLx2fFPw6zPfvdx7sDvn5iYSAkSxZ15k6iE7BXtp7jtbTxvviLU54Kk0LTcWOzHf9+bNeinCHJ6qMpqgnV3z9kS4cXeUrvHiohFXYw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(136003)(346002)(366004)(396003)(1800799009)(451199024)(186009)(38100700002)(36756003)(83380400001)(2906002)(54906003)(66946007)(66556008)(53546011)(66476007)(31696002)(6916009)(316002)(6506007)(6666004)(31686004)(6512007)(6486002)(86362001)(36916002)(478600001)(2616005)(26005)(44832011)(4326008)(8936002)(8676002)(5660300002)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9TTVo1SzI4N0pYK09xODdacDgxazE3QXBTN24rbmZmbmNoK05sZi9VYjBj?=
 =?utf-8?B?OG9ib09abjA5TTVLYWFIckQvcDE0TlI4N1BocXVkbXVaTmtUclRDK0Jpd0Yw?=
 =?utf-8?B?cFZ3aGFQMW5kMlhqYk5RMFhOSXBXbDNDQU1KOFF3Q3NlTkVPNDk1aW93SU1l?=
 =?utf-8?B?RDltQXpCeS9SbndFMGJ0ZjNmM3l3NWl1RFJPLzd1ZmJoY3paWmxUWHhPSG0z?=
 =?utf-8?B?RVpNUkhYM3EzbXlkSzk0R1N5blpmWW5sWXZNT2RIcGdWaWk2NFQ1YkpERVhw?=
 =?utf-8?B?dFVlQXAvSzg2azB5TXJybkJzSjZSczVZVHgzWTQrdnlDTmx2ZEhFK3hYUUh0?=
 =?utf-8?B?cjhVVFBkN3NDb3ByTXlBYVNwSVNmd3NPaTVkZmdaVVRtRDIzMUVhaHBqOU9s?=
 =?utf-8?B?aktOS3ArOUg3aHFEamcvR0VaVjA0OG5HL1JqcmV0d04zMzdSMUtNV2daZmVO?=
 =?utf-8?B?SUdseVhNRjh1eGI0MkxHRXNiMklGK2pUN3BtWHJRQ0xiK0FwZHBlT28xYWN1?=
 =?utf-8?B?d2w2L2NBZThwZTNObmpXNDlPd1RSOS9qZ2dJbVExQm01TzVUZGRibTlaZXg3?=
 =?utf-8?B?dGloUDhDWnQ4R1J4blVncjRNVS9HeFZ2T2lqbzMzd0JvdllIQTArb2Z5em9h?=
 =?utf-8?B?OW5ZUGJjd25xODVEU3EyRDQ3ZEFLUXE4NHFVQWdMRFpGWENWSktBV1hVK3c3?=
 =?utf-8?B?bXdzMXZIRXJleXdxcDQzL1d2NUY1UkxqWHcrTjBTYVkxdlNuQVdFK2FjWWRv?=
 =?utf-8?B?OFBWVUJ4U1FkWFlpallLTXYxeEtTWjRsU2t0QXRTWGZuVnpOWEJ6a25vQWdi?=
 =?utf-8?B?V1B0b1FDSGQ3S3ROMEYvSnZyMjM4eG82RDhxeWFYc3JFNFQ2Y0k3UXNWTW1o?=
 =?utf-8?B?NndOdzZXNnRLN3RaY05qbHYvNUJQOGFFRHcrZnk3TlYvenJkYkk0U0YyNkcy?=
 =?utf-8?B?UGJOSCtQZWZiVXZJOVJJUHYrMTJLWmRYU2E2TTV5YVBDMTdDWFNIVW9MSUpu?=
 =?utf-8?B?R1JBUU9NU2pvaWFvRVh0WmVtS29NcHpKR3RJdUFNNS9UeTRUbjdTWm9wQWU3?=
 =?utf-8?B?U2JLaDBPQjgvQ3N2bEZTaFFuR2NNQWJQSTVRL3ptM3pCVnVJRzU4Nm9QcnBK?=
 =?utf-8?B?N1BrOXhjaUFQS3RNVUhXaXdNVisyc1kzQVdQWmxubDlYNHR3OFZ3VlduZzN4?=
 =?utf-8?B?TGc2LzNpRTVuL3czai8vOFZVS2l6RUN0QXFkNXEwbytuKzI3cnIrcTNxdTFk?=
 =?utf-8?B?NXNHUm9FeTVSV2hIb3FVRFJrdU4rVjN2VmJCam93c1FvY2xKMFVMT2tiVHZ3?=
 =?utf-8?B?WVdmanhHNEFrM01uQVNxTFV5UmYyRTdzNDJVdEtWbjhaRVh3MHlVSEt6cmNL?=
 =?utf-8?B?Ykt6cDRoeG1zMEk2ZXVjeEhyKzdhY2xxOEhYM0Rna3hHTENsNWk4eHUyZXQ2?=
 =?utf-8?B?S05GcFpwN0NYWkZ5ZkZIalcrbzViS1QzcEF6QUlvcDlTWmpIdVZGcWZPOFJh?=
 =?utf-8?B?a1BjeW8xaWxHdWdudzdjcExGUUpCaWtZdEREZnVLcmZOWHJhc0hjdEZ0dEpQ?=
 =?utf-8?B?RXRPWkZrQTJBdGcxazUvQ09ab0JJVHVpdW1Dbzl3SSt5MjhncnlPcW16TWZa?=
 =?utf-8?B?bFBrYm9zVzRscE1MTC8ydmh6TFdYb0orTUhRanJ6djVSQng0anNibDF6czh5?=
 =?utf-8?B?Nmx6MjNxSzdlSDdubHJmaWxRSVZUZGlHVXJiQTdTdU1pK0YzQlgyb2FXUFBV?=
 =?utf-8?B?Vys4OFluaG1LOEREc0kwUXp0NTZZRU1vaUxSUWgwa05ycTl6WE9MRFNBNXRz?=
 =?utf-8?B?NXkwcE50QUJMd2ZiNkdPVVUydjhHcys2MnRlWHZXdlBneDdLaE1TMUZGdzFs?=
 =?utf-8?B?S2Exa2dzRTBQYUxFU2syLzZlc3pNWnlOdE5wQlQwalRXbno1MmZ2bUQxUHNT?=
 =?utf-8?B?aE1lT3BhK1BtWmZaTFRmY1RDYVQrYlhVUXFDUDVzeEdwQ3ZQM0VWRVhTRlZQ?=
 =?utf-8?B?cG1Ia3FPdXVxekprMDMvTnU3ZElzMjJkZTMrZ1JaZDd6VUlxNkZwT3E5OUFN?=
 =?utf-8?B?ZDNEMWtTdlpycHhMc3pwUXNLMU5LQ05DTkowL0FIbFlmeGZIZS9QaHF1MUdm?=
 =?utf-8?B?WVJPY25WNVE0QnFtV1BIMTVqVjRtbzRMOXkvN2d6ODZQODExc21pbGMvWkhR?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uSxawJlXzAFhRBSc6d5R1cKNH2X5uy0zQqIxjfUq/1UcQ2s96tY3BAcz3cdeqsCcW0DKd4+BEsWJ9Un6C/jkAw35pTH5kD0mROz0y9fEOWw1JxQBiK+EQJvF76joHaLgFu4o2JCkXTtJfHG5FOdjZXy/+HHMWNFPWE2tdIpyYzZCoXgKK3NrFMQ8eFhZxb+e3b6YEH+tF0QAWLxbrfdbp1bZVfXfh8tC762zZEcvTr8Ya//WgsGxwkjThJrXHIuEXqxqNL4CA8uYy0LEkGd6286a1bOKTZzpfwJiEe1RvhLx+zMwsL79wE0TB+Lnjzm+7ESJ3MPVqgJuXsDy9IHGzfhchWvw6IuHJickICWioG/9FvCU9uEqQq0WRL8rVqxC0ZeUrdj7oj+bkN8M20EBcT4lsGhkcTsTcdfpoHYhJkutwghlJ/mWWDXWFIqfZgXcPBECmsRolGRufAip1+wEyFu5WPkxItESUlHSA8zOpDvJSw//o/TfaWuflw0NR/DrpX1QLfxPRvrmm0QRkWJt+Dx7z7DAaOlVvIlIcKUqCisrwtVVUTAYZpXVDtMuErYO5IF+snOEoGB6JZpFDG+WjH7mzQA6EpZhP1/j+falRFU6ggOtnMJMoGDED6rTsU4l9Y62W4OoMsazmu+b/C5UVNSaybLmuI0/o5yHGbDD2V8QWA0JIQpGNj2lH41sDLOUI4HKXzUlUN1bzIgTKzVbfsTm4drC+rR4ScfgOtzAVewaKi1pvsJbTwNU8ibfQLlaGBT8cUoSUa+ufLyotvXo6dmYBPPwPADLS9l4tY/ABLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0100140-ab27-42e7-fc13-08dbb0772250
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 14:23:12.8651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VV1rpzAr0blZQjwFmb17j79IHlzZetnbeLe42tERyV+9l8tEWyXq2hZuYpswbSHX5B5cCdf9g4GAEE/XnnZqCH4aABXgjVc2JqAvKjQgOyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_11,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080133
X-Proofpoint-GUID: GoLsH0DZ4_tu3KDFpt8gT3m_TjCC7Yq_
X-Proofpoint-ORIG-GUID: GoLsH0DZ4_tu3KDFpt8gT3m_TjCC7Yq_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/8/2023 6:52 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 30, 2023 at 10:15:43AM -0400, Steven Sistare wrote:
>> On 8/30/2023 9:16 AM, Daniel P. Berrangé wrote:
>>> On Fri, Jun 30, 2023 at 07:25:07AM -0700, Steve Sistare wrote:
>>>> Extend the migration URI to support file:<filename>.  This can be used for
>>>> any migration scenario that does not require a reverse path.  It can be
>>>> used as an alternative to 'exec:cat > file' in minimized containers that
>>>> do not contain /bin/sh, and it is easier to use than the fd:<fdname> URI.
>>>> It can be used in HMP commands, and as a qemu command-line parameter.
>>>>
>>>> For best performance, guest ram should be shared and x-ignore-shared
>>>> should be true, so guest pages are not written to the file, in which case
>>>> the guest may remain running.  If ram is not so configured, then the user
>>>> is advised to stop the guest first.  Otherwise, a busy guest may re-dirty
>>>> the same page, causing it to be appended to the file multiple times,
>>>> and the file may grow unboundedly.  That issue is being addressed in the
>>>> "fixed-ram" patch series.
>>>>
>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>  migration/file.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  migration/file.h       | 14 ++++++++++++
>>>>  migration/meson.build  |  1 +
>>>>  migration/migration.c  |  5 ++++
>>>>  migration/trace-events |  4 ++++
>>>>  qemu-options.hx        |  6 ++++-
>>>>  6 files changed, 91 insertions(+), 1 deletion(-)
>>>>  create mode 100644 migration/file.c
>>>>  create mode 100644 migration/file.h
>>>>
>>>> diff --git a/migration/file.c b/migration/file.c
>>>> new file mode 100644
>>>> index 0000000..8e35827
>>>> --- /dev/null
>>>> +++ b/migration/file.c
>>>> @@ -0,0 +1,62 @@
>>>> +/*
>>>> + * Copyright (c) 2021-2023 Oracle and/or its affiliates.
>>>> + *
>>>> + * This work is licensed under the terms of the GNU GPL, version 2.
>>>
>>> Was it an intentional decision to assign this under the version 2 *only* ?
>>>
>>> QEMU's LICENSE file states
>>>
>>> [quote]
>>> As of July 2013, contributions under version 2 of the GNU General Public
>>> License (and no later version) are only accepted for the following files
>>> or directories: bsd-user/, linux-user/, hw/vfio/, hw/xen/xen_pt*.
>>> [/quote]
>>>
>>> Thus we'd expect this new file to be version 2, or later.
>>
>> My mistake, sorry.  It should say "GNU GPL, version 2 or later"
> 
> Could you re-post, as aside from that, this series looks
> ready for merge.

Done, thanks, see V5.

- Steve

