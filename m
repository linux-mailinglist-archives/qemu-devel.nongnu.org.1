Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAEE743D0F
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 15:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFEbH-0000jh-D4; Fri, 30 Jun 2023 09:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEWX-0006dz-F7
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qFEWV-0007P1-9y
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 09:50:57 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35UBObTc011898; Fri, 30 Jun 2023 13:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=slz7IEfxeUcJeV7By6Q8wLWO/B+DFHXkbpmqb0U0SYM=;
 b=BrLjOPq/7bbxou/YJGbrAc5nBl5ARp+hzCkjurpNQ5dQe38J7UfSf4MapQWFQqP3fXvd
 F2IFPzQhB9u7MVDdSKbKEGequVNveP+lZoDCcS8YCKEj2pd/wwTKXeqc7tPKTPYGKorm
 8tSv/DI1PliMvMwXtMoMZjpKKHXTtBvxQvfGPZZvSV3MXa6TFAuJ2FtAQSxOoBL4qEeV
 2yqiFMNr4ZuQcL1LBmLWSOvQmu4I/fOSd7SkSi5LprBB1+cfH/Hia6ZIZTgP0Q81otj7
 C57QBNh+qZLCqfAQzoor0MebEOMm1voVaM2Elx8OTx/r14XOTE23fv0cyA7N/WTsLSlY Qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdu10br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:50:51 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35UC0wSR004005; Fri, 30 Jun 2023 13:50:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3rdpxeweh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Jun 2023 13:50:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmd4OBXHsLpszBRU1+tysqvdyEOzCaYKbCnbrYNUmlt0WJ+QWw6H5XUIluCPJaI5BE4BWw02N3iS2CGs4h27mfmxH+S10tWDjWGluov7XeH/cu5BT5iQMZENHHvU0Uj10A1pM4Blsxnw6wk5Fiovl9JA+1wuDTQPntfG+nTJqWCIr1OIyyPN2yymI5rdy+wW1pR0zpaZFGUw7Ntclk2Kf6d9dX4mzQ57sJrXNSh6s4DTg3b3B4R0s86JJtNKrc5UpM5gqzbY49srHat1A3zKNRrt6oq4RU954rA8dZm/ke2fmKqTQwm3f2qvwQY4FWEP1q36jwIldPwfcwWAu8eMJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slz7IEfxeUcJeV7By6Q8wLWO/B+DFHXkbpmqb0U0SYM=;
 b=N7tVJ7fEWYyx3/TTiY5dqzu2nsfa9migdokaxtcxFpIWNVtGR8KsuXTFlMuOOXatToY4R4Rjq00JS6Sh4wsvOAJoDsAzAwNxlC8z98Bhm8wca9lfLpdOTxyokFMzKyohhRrr6+tjDlJNng679kr9AkiQfa41aDpnrBW9jgPdKVxL0mCo4EcM58EFUJWiFe47YpHbpTtPYNbnJzMmQ7xxHJPAQNqbk97uDulNbwH3hlna1rL1nrdhw86zrUgBeROHiNTXSj3L7Kerv3SXExDGbhJW0mAt/QIQ/+vA9O0r7aSVCABywx+hU9jIOvbfhEDQscYTfGWFQLaDZv10ymrxTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slz7IEfxeUcJeV7By6Q8wLWO/B+DFHXkbpmqb0U0SYM=;
 b=IxsaFUNNyn3hjHjSRQEINxESPpfg+RdQphQuC7pn7tmMj8quI5MTPOlYvvslbmSOMTdBSQLCo+wcWActkFbW7VZm4L9cOo+Amk0J9b4o+Ca6SyKPD5K3tVbX6UbdKrGbQ0JUmGqnzNWHNh6EtPF+IRNXlJkOzish7u1IwpjkHVY=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by PH0PR10MB4725.namprd10.prod.outlook.com (2603:10b6:510:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Fri, 30 Jun
 2023 13:50:48 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::2743:9347:3bf1:5f11%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 13:50:48 +0000
Message-ID: <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com>
Date: Fri, 30 Jun 2023 09:50:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1686860800-34667-1-git-send-email-steven.sistare@oracle.com>
 <1686860800-34667-3-git-send-email-steven.sistare@oracle.com>
 <ZJIeR7svXvtHdgs4@x1n> <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com>
 <ZJNdcyrv0TzFUKMy@x1n> <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com>
 <ZJnYlApmsQLXBK/3@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZJnYlApmsQLXBK/3@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0167.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::12) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|PH0PR10MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 637ee25b-9ccd-4e7d-6714-08db79710225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0welTvx56PZesTcWl2RbEKiXvMc5zPr0cOmQvsbUINfPFXIc50yYmDjZY/0SrIptlKtdMPJ8RR+U0xMbtO96qPpozhQKeB19QGHiruchxTQATH4SYh5rlUGvn4YhmBCGzMw1bsXLVUvsxvtpWT/C0DELoDO86F9beLO9eD980fgGEk65uVk8jfL3L14XQPimqNx9wTV9Wz0VR17dzowOYVj2HJmQTTu1TQvDqhZgVUz8+kCKcjzHqDApJde1v9NNzCn8t08cOShu8UUmE5c1BfHT2a3yFCWntlxQZS3UBpfyro78hbCitePGilXnzulSR90rbbCdP63pHfdcvV+kiaLQ9Veq9LKs2XQ8ahzKK6RiZgElQqtzuOGa3hjy8Bi+vJilyq8hY6MWveoeWSWE01ZLvtuZC/8DBL8b7XH9JolEF58BfvpVnJuXWfGQuKInpbkqrhymqdZTb6WEaWwY8/R2u/2OK3i3mf8Cxe1NK4S0Ghnhbt3Ckvptn62QO2gTne9D1WFB3Y4WgvQlDla0gILJjLMfzFe+aaCKhF6VbLTA4lD027J2DMSdJ8UOf2H9VBHFtaDPSe2pRRAIB+4boxhFVnKxINEq8UNH8Vz4bWlS3kSxhL4NdjDD8Hm3eU8AFuPeUp0HMkA8TUiWlzbDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(316002)(83380400001)(6916009)(2616005)(31696002)(86362001)(38100700002)(5660300002)(44832011)(41300700001)(66476007)(4326008)(8676002)(8936002)(36756003)(66556008)(15650500001)(53546011)(6666004)(36916002)(6486002)(6506007)(26005)(66946007)(478600001)(54906003)(6512007)(186003)(31686004)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhUeWtRQTJmZ2ZZQU53U1ZaNDNqc3pLT1RLWEorZWZIWThQTVhiai9xM3Nv?=
 =?utf-8?B?cWl4eDlqK1Y1US9mY0JaRkF2dUwydldMSlBmZm5CbkREclR6UktNMjhZUWNZ?=
 =?utf-8?B?OTBSZTN6eHcwQU1BWGtUT1FPeHcrakNuM01kSVQrdjdJZTNkK1FzNmlhOU8x?=
 =?utf-8?B?bVo5cm11TW1jMmV0VVlCTXVBQ29RNlZycTE4RHo5bkhrbVgyVWZlM3B0L1Ji?=
 =?utf-8?B?cDdrNGk2akpJMVVFTFFIcVY3RDlrOGdOaEppVVJFM0hxQ2lJN1B2V0FKUVpm?=
 =?utf-8?B?VGVUeXp1R0pwSHBNeGFTMEFqWkl3QVVhd1dKc2dFZWMzQjZlelpCL2dud1o1?=
 =?utf-8?B?N040bUg2bmQvQlNBY3ZmOVlRbjdubDJyb29QS3d0VUJTZ2dmcmFMazJFYWdh?=
 =?utf-8?B?R05OMWY1RDFhY2FFRjZRVlFsZXNEejJYRG1kNlNRZXhHeUg0MEw1K3Yzd01T?=
 =?utf-8?B?bG5nTDVDMHhlV3gvMUpHVnBBN0Z0bUNKa2o3aDRaTThsK09WaTR2RE5vRk9i?=
 =?utf-8?B?Q2JqekRyTnl1ZnJ0KzVVR3NrSm9ReVV5MHk1M0Z5V2xJMTlOU3VUMmNWb1g2?=
 =?utf-8?B?cC9aSG45aHczYW10N2RnVzNKSTRlV2NpNlBjeWc2VVhDNnpKTjU0Qy9Cb3lN?=
 =?utf-8?B?d0pHMG42N0ViQ3F1L0ZGdCtZTERlQmlwa1FlVFlwU0F4dWZpTzVHb0xUZFhM?=
 =?utf-8?B?cDVCNHZBOWF0UGpwWHFrK01UdXhyMTlpekJrTVlrcE9FWm8vdVRaVWt5Yklj?=
 =?utf-8?B?SjAzMmZIK0QvTjRPL3ZmTkhJRnFSQ01WSWtuUjl6d0dMMXdVRjU1dCtMaVdM?=
 =?utf-8?B?dktVSStqNXpmT2V3cGZKcUJpMnN6dzZvQXBsVWVpNXlZWUxEUXVKMGk5UzMz?=
 =?utf-8?B?VWdCTElxMDZDQWM2SzhPcnJqQkVXeU5ia2NxSEVqdGlSNGdVbTNrUm9iQlIy?=
 =?utf-8?B?VzhsNW1MYXQ4Q0dMeVlwNWVmdGFOYUpXOHhhVC9ScWI3S0NSeC9xbEhPYS9P?=
 =?utf-8?B?cG9WSGRncjMxVEVIZFRqbEhkMndjTzNpaDNxVGprTG93aS9QSHkwV3FHYU1O?=
 =?utf-8?B?ZnhrMjdaUFFlZTVTa3FOVkcvTURMaGhpWFhTM29ONm5Cc1NSUlhnaFlBbS9T?=
 =?utf-8?B?aTNUdk5vNjczUGtKS3N1KytCaTlqdG1PUGFOd0dEL281Q1lHeDVrK09yVGpw?=
 =?utf-8?B?UmFYeng0eis5QmZKeG9QZmlrQVl1Ym5vYmtqb0tqVlZ2VmhQcHpIL1JydGJQ?=
 =?utf-8?B?eDYxSHhjSTIxMlV2UnF6Sjk4Z2w0eTcyTmphUldOUjVJcXBIRnBLbTRhZE1o?=
 =?utf-8?B?ZVQ3R05HVDZqQThGNktKbnhicUpscm1qWUJtZFNHR2lRM01qemcrMC8xZys2?=
 =?utf-8?B?cm81cHBiaTJhVURDa3hJRy9pcVlMZFNPdkx0U0NyVG9IV0IvK0lYRnlGSUpE?=
 =?utf-8?B?c2dGSHJzR1N3YmFRVEUyZjhmMTROZjFiYW9ZK0d4VU5BaDkybWJ1OEZaYVMv?=
 =?utf-8?B?QVlzdFczRDJiZmdtbFdDM2xvdFhHK09FdGRhR1hVRkpJdXNMamhwREgzdkFK?=
 =?utf-8?B?L2h5TVh2VVpHcXdTRFJUWnJVcURSU25EQSs3MnVZcFJpUmZqSlBldXNNQWNK?=
 =?utf-8?B?bFpyMm5Ba0szNGdkcHErdmcxa3VWcUdJREZzODFKZ2hWNVB4Rko2T3Frd3lO?=
 =?utf-8?B?VUZDcDAzbzhtb0Qxdng1WG5EeHFONk1sWUlYU2taVG40OGdzbGJ6MU05TDlK?=
 =?utf-8?B?YTYxQVUvTm1kTnNORXA1OUJZRmhxbnR0VWxVamttdklEVDJkTWhYMW95aDht?=
 =?utf-8?B?dGVVaG14S2ZJMVVJcE1oZ0ttWm91ZEh6RTE4anFuTCtKRUw2Wm0yOEVrUUxs?=
 =?utf-8?B?MDdZWlhsTHB3N2x1K3dVVnhkRUw3QU4wSG1EbE1WY3dSRVlMVnp3WFJ1Mkph?=
 =?utf-8?B?RXgzMWZWcEFEWG9odndDaWFZQ2JGNWZjdTdsOHNTVTdQMjhKOXpXdGROdXhT?=
 =?utf-8?B?Uk5iL2tDVGZBdDh3UmpVaVpDM3lkaUhYTnhFSGQ0RGo5UG5YNk9lUzFYcVIr?=
 =?utf-8?B?dFVyREw2cW1yeVpaYzBnUnJ3a2FoQ1VaTXlTZU5Ub1NaMjJRY0ZsaGR3dlo3?=
 =?utf-8?B?eFJRYncyUjlLMEs4Sk0xdk8ybEVUdjVZOVprSGtEdXl5VFFVSnVMbUk0Uk1w?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zCVLNXknITbIkgQJOqX9nZ311t8/eM9cYlphj0alstiJ5ZFDFvmEoZvOq02QfH2ypNTNAFilhFoB1iaj6sL0pK2iBew7MHX3IeRBNwhPPVHftD9HazQZMN9lJYBD8P0urGLx2Yr5m+aPUWlAdrsRxK0z+34Ac9DNczack5a8SqPJjBwzIBZvHx9RmEkTLmFmyv9dR3Qc2hfOnpSaaFTXijiwekp5dPsjptHSLnLVxQ4Bbx0s2Ccs2JHiJQhMYA9AG4tU5ONK9idTVh5heqm4+vTEvoYzkVeRL+u9BotZvZuzyP3rlhhbjviyGjJSpo8od1xJfxEEkuP+G9QereANuo97k5jg8q247BIhWfkxX+37gevJcmPC17yrLwkQoBClBE7wB4TEmEf2rnuZB7OoUdctHFTa48PTg0OuNXIbDg03qYIOC6oXuBpkMFFY4AArhYO0QqrwkD0aOMyKQmCQAuDbU5PB6+ZXGaFX56fjHlqacrUxsQDXSHGrsJFAtKwwgogXmrTbtZmHBQWoGKCG/rLSEfO+1H0GO2XRx1Uik38ea7+0fBpmoBKakn+JamIkgZ2kBrrLTI2O4e+df+YwockWtEVXP94pKjHMW9uaZJWMDix4AyJY43aKZGLbHZ/a6aJVTfqQe/UK0IJQNvg1Yu/C2nv0W3TZDPbB7L9LKsiTeM70rRuITu4NFIeYFz0SpS+S3dNQlnLa/tSyFz+jayiUSehbmnYlJrr+hQzXL3dgPiob1+f4gJLEoJ0pvGymX1nFQkPMp8mKWh1574dipQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 637ee25b-9ccd-4e7d-6714-08db79710225
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 13:50:47.9730 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cRaqJr2xV50XUllsawzU9r5c1zo2YLOdGuo6e1znPaJ4uCuho2i/PZvBZoD7PKGMQYTMZ/9sf7Th+5LkqmDx5CpYYQpCOUVnoSL2audzLSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4725
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_05,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300118
X-Proofpoint-GUID: tZmEpEU9qYIGGBX3HKeXm3OKSHFw7ZAP
X-Proofpoint-ORIG-GUID: tZmEpEU9qYIGGBX3HKeXm3OKSHFw7ZAP
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/26/2023 2:27 PM, Peter Xu wrote:
> On Fri, Jun 23, 2023 at 02:25:05PM -0400, Steven Sistare wrote:
>> On 6/21/2023 4:28 PM, Peter Xu wrote:
>>> On Wed, Jun 21, 2023 at 03:15:42PM -0400, Steven Sistare wrote:
>>>> On 6/20/2023 5:46 PM, Peter Xu wrote:
>>>>> On Thu, Jun 15, 2023 at 01:26:39PM -0700, Steve Sistare wrote:
>>>>>> Migration of a guest in the suspended state is broken.  The incoming
>>>>>> migration code automatically tries to wake the guest, which IMO is
>>>>>> wrong -- the guest should end migration in the same state it started.
>>>>>> Further, the wakeup is done by calling qemu_system_wakeup_request(), which
>>>>>> bypasses vm_start().  The guest appears to be in the running state, but
>>>>>> it is not.
>>>>>>
>>>>>> To fix, leave the guest in the suspended state, but call
>>>>>> qemu_system_start_on_wakeup_request() so the guest is properly resumed
>>>>>> later, when the client sends a system_wakeup command.
>>>>>>
>>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>>>> ---
>>>>>>  migration/migration.c | 11 ++++-------
>>>>>>  softmmu/runstate.c    |  1 +
>>>>>>  2 files changed, 5 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>> index 17b4b47..851fe6d 100644
>>>>>> --- a/migration/migration.c
>>>>>> +++ b/migration/migration.c
>>>>>> @@ -496,6 +496,10 @@ static void process_incoming_migration_bh(void *opaque)
>>>>>>          vm_start();
>>>>>>      } else {
>>>>>>          runstate_set(global_state_get_runstate());
>>>>>> +        if (runstate_check(RUN_STATE_SUSPENDED)) {
>>>>>> +            /* Force vm_start to be called later. */
>>>>>> +            qemu_system_start_on_wakeup_request();
>>>>>> +        }
>>>>>
>>>>> Is this really needed, along with patch 1?
>>>>>
>>>>> I have a very limited knowledge on suspension, so I'm prone to making
>>>>> mistakes..
>>>>>
>>>>> But from what I read this, qemu_system_wakeup_request() (existing one, not
>>>>> after patch 1 applied) will setup wakeup_reason and kick the main thread
>>>>> using qemu_notify_event().  Then IIUC the e.g. vcpu wakeups will be done in
>>>>> the main thread later on after qemu_wakeup_requested() returns true.
>>>>
>>>> Correct, here:
>>>>
>>>>     if (qemu_wakeup_requested()) {
>>>>         pause_all_vcpus();
>>>>         qemu_system_wakeup();
>>>>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>>>>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>>>>         resume_all_vcpus();
>>>>         qapi_event_send_wakeup();
>>>>     }
>>>>
>>>> However, that is not sufficient, because vm_start() was never called on the incoming
>>>> side.  vm_start calls the vm state notifiers for RUN_STATE_RUNNING, among other things.
>>>>
>>>>
>>>> Without my fixes, it "works" because the outgoing migration automatically wakes a suspended
>>>> guest, which sets the state to running, which is saved in global state:
>>>>
>>>>     void migration_completion(MigrationState *s)
>>>>         qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
>>>>         global_state_store()
>>>>
>>>> Then the incoming migration calls vm_start here:
>>>>
>>>>     migration/migration.c
>>>>         if (!global_state_received() ||
>>>>             global_state_get_runstate() == RUN_STATE_RUNNING) {
>>>>             if (autostart) {
>>>>                 vm_start();
>>>>
>>>> vm_start must be called for correctness.
>>>
>>> I see.  Though I had a feeling that this is still not the right way to do,
>>> at least not as clean.
>>>
>>> One question is, would above work for postcopy when VM is suspended during
>>> the switchover?
>>
>> Good catch, that is broken.
>> I added qemu_system_start_on_wakeup_request to loadvm_postcopy_handle_run_bh
>> and now it works.
>>
>>     if (global_state_get_runstate() == RUN_STATE_RUNNING) {
>>         if (autostart) {
>>             vm_start();
>>         } else {
>>             runstate_set(RUN_STATE_PAUSED);
>>         }
>>     } else {
>>         runstate_set(global_state_get_runstate());
>>         if (runstate_check(RUN_STATE_SUSPENDED)) {
>>             qemu_system_start_on_wakeup_request();
>>         }
>>     }
>>
>>> I think I see your point that vm_start() (mostly vm_prepare_start())
>>> contains a bunch of operations that maybe we must have before starting the
>>> VM, but then.. should we just make that vm_start() unconditional when
>>> loading VM completes?  I just don't see anything won't need it (besides
>>> -S), even COLO.
>>>
>>> So I'm wondering about something like this:
>>>
>>> ===8<===
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -481,19 +481,28 @@ static void process_incoming_migration_bh(void *opaque)
>>>  
>>>      dirty_bitmap_mig_before_vm_start();
>>>  
>>> -    if (!global_state_received() ||
>>> -        global_state_get_runstate() == RUN_STATE_RUNNING) {
>>> -        if (autostart) {
>>> -            vm_start();
>>> -        } else {
>>> -            runstate_set(RUN_STATE_PAUSED);
>>> -        }
>>> -    } else if (migration_incoming_colo_enabled()) {
>>> +    if (migration_incoming_colo_enabled()) {
>>>          migration_incoming_disable_colo();
>>> +        /* COLO should always have autostart=1 or we can enforce it here */
>>> +    }
>>> +
>>> +    if (autostart) {
>>> +        RunState run_state = global_state_get_runstate();
>>>          vm_start();
>>
>> This will resume the guest for a brief time, against the user's wishes.  Not OK IMO.
> 
> Ah okay..
> 
> Can we do whatever we need in vm_prepare_start(), then? I assume these
> chunks are needed:
> 
>     /*
>      * WHPX accelerator needs to know whether we are going to step
>      * any CPUs, before starting the first one.
>      */
>     if (cpus_accel->synchronize_pre_resume) {
>         cpus_accel->synchronize_pre_resume(step_pending);
>     }
> 
>     /* We are sending this now, but the CPUs will be resumed shortly later */
>     qapi_event_send_resume();
> 
>     cpu_enable_ticks();
> 
> While these may not be needed, but instead only needed if RUN_STATE_RUNNING
> below (runstate_set() will be needed regardless):
> 
>     runstate_set(RUN_STATE_RUNNING);
>     vm_state_notify(1, RUN_STATE_RUNNING);
> 
> So here's another of my attempt (this time also taking
> !global_state_received() into account)...
> 
>     RunState run_state;
> 
>     if (migration_incoming_colo_enabled()) {
>         migration_incoming_disable_colo();
>     }
> 
>     if (!global_state_received()) {
>         run_state = RUN_STATE_RUNNING;
>     } else {
>         run_state = global_state_get_runstate();
>     }
> 
>     if (autostart) {
>         /* Part of vm_prepare_start(), may isolate into a helper? */
>         if (cpus_accel->synchronize_pre_resume) {
>             cpus_accel->synchronize_pre_resume(step_pending);
>         }
>         qapi_event_send_resume();
>         cpu_enable_ticks();
>         /* Setup the runstate on src */
>         runstate_set(run_state);
>         if (run_state == RUN_STATE_RUNNING) {
>             vm_state_notify(1, RUN_STATE_RUNNING);
>         }
>     } else {
>         runstate_set(RUN_STATE_PAUSED);
>     }
> 
> The whole idea is still do whatever needed here besides resuming the vcpus,
> rather than leaving the whole vm_start() into system wakeup.  It then can
> avoid touching the system wakeup code which seems cleaner.

The problem is that some actions cannot be performed at migration finish time,
such as vm_state_notify RUN_STATE_RUNNING.  The wakeup code called later still 
needs to know that vm_state_notify has not been called, and call it.

I just posted a new series with a cleaner wakeup, but it still uses a global.

- Steve

>>> IIUC this can drop qemu_system_start_on_wakeup_request() along with the
>>> other global var.  Would something like it work for us?
>>
>> Afraid not.  start_on_wake is the only correct solution I can think of.
> 
> Please check again above, I just hope we can avoid yet another global to
> QEMU if possible.
> 
> Thanks,
> 

