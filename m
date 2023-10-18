Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 485D77CDE29
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:00:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt75l-000785-M2; Wed, 18 Oct 2023 10:00:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt75f-00077m-Ki
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:00:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qt75Z-0002Ej-LN
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:00:03 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 39ICwmlC013191; Wed, 18 Oct 2023 13:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VdiIva+25yfJmmUjGZhtoenVfKjKcBV5XcD39qDU88M=;
 b=IvR4GpRs7lKT8zsTxsHZCD+pNxtnUdLy8M6UJYB/1PZb7Ee6nXuzXcrjnmck7YSilt52
 xLIpA4j9GhuVLk6AIjjBDw81kkTeOCqK70IoYOK9Js3zfbjbhn5LoYuoDPTt3OBYWSXr
 nbhfZVK1GxZGMTTLf/Yf2AGPijFIrHALsx6K6/rZjO1UKsxPR131y2yWkhn3G8W0bruv
 doZP4HsUlIVr8FsB9OtBCpnl/KOT7hTe8k5sdIJ3PlMy3fR8gKxlxnOVapKr3Ijonvmv
 oZwPhqe3LOuFznzsT3LgfeYr0uq9z2kYicsmnspU6IDLuejn9SqIVliyOEpuUzQpjrMT yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu7mpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:59:53 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 39IDS5EO027111; Wed, 18 Oct 2023 13:59:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3trg55bbmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Oct 2023 13:59:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa9VFDe8GMFLgDU4MMimdlp159ML36O2alBJ7/zj/1Cfqhh/3ioQylV4ozKo7A8ugbEB81JM86OWWTksHTK4b4Mtmk48w84xtOBIdqoFVEaafaatHOFVtbLfebcvme8nKnZV0BpBlKG+nrRQDSaKQnbcNrFT66EY6yCub+xmouoj2BBEv3uu0CdFqJ4RhIOfS0U2jNz6AdBJdj8JfXY3FSsDOEbTnA63MF78ZRDfL8STgLmo4vze16RSgZEanzoyoXZNBCxxmr0Wt5a+lTRTf6XsYLezVdVhplcH9AHfZlNY7qcoHv6YrHxk/ACILTOMDyn4qNUOkwfBsi37YtEbcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdiIva+25yfJmmUjGZhtoenVfKjKcBV5XcD39qDU88M=;
 b=GouHpx+KqwVsLJPIe1d2BSEJpYvcpwL1kCPCzKvkMhUGd5szuW9oJsg2gC0PY9pSCKlXJC+fvLVndiHst5fmH3hmeFFuLNh+r3VnayVRAP6/CA0hZaB7e95/SkoQFjrieVwuaanb2v3AJNIkOCXDJAIf466w0iXoKSfxA/9w9n95+b67X0nlvLs8LypSrzDGAFKZCGbDns+FMGuMo+GyqeRQKVOx+mBCeD1CzKWBx9mzpp/C1NnWVv+mBKIJl7ZGTt47dQCJNLmcUqQNhpL8GzpEtQA2Zre7fZTIkyWyioueYbduUmCPGAQGI3cc8rlEquIbQGeuwxn8upglxaR5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdiIva+25yfJmmUjGZhtoenVfKjKcBV5XcD39qDU88M=;
 b=Q7dxLuyV4ZsMvPyfOJbw4AXHPiq8Q8P8gYQBd0lHDADikbe6KVdFJpqu4RlslHJKct1frcuA+BjzieSCUXnilWUYMfM5o0v//9e/iBL2QEVjx79GLEmZ4bCprW2ZMTkxTWO1D327dw8FkIK6X2p+S4Xvg39OuvAtLCBOa9jA9+s=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 13:59:51 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::f630:6779:7c5c:fa65%7]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 13:59:50 +0000
Message-ID: <16d749b8-5d79-4fd3-944a-1be1361af019@oracle.com>
Date: Wed, 18 Oct 2023 09:59:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] migration: simplify blockers
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1697634216-84215-1-git-send-email-steven.sistare@oracle.com>
 <87r0ls82al.fsf@secure.mitica>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87r0ls82al.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0083.namprd03.prod.outlook.com
 (2603:10b6:a03:331::28) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|SJ0PR10MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e0a05a5-f620-406f-eb22-08dbcfe27f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0jf06N8CfwJ9WGSNdqEvEdBN+Q+CsXLc4S2RDeh+sC+U5cvkbPR6aEvtN0BUGoy/foHbKctiPCLnMTg65npoXCb+m3g1fU34bF09+8dGMJVGVnwyRNd6KATUprFNcI4CYbL36bqaOYN+UUE9w9oD7ZtgwSdR6DhEmoBRewIyzYOWKGTRuTQ3PB+wxsA9kDl/81rgwBwH4wNb2Td9Ra+zqmMmUlQISarthKvNsIJ4aoIDSGDG0+dkQ7+nEGOHHQLAyRJcc6sweYtLqHpdOLSDWBivswY8BVtQeVHa9QE5Zu45dFneDl/SyIGJQ1LJ1OcGZpCT8c3+QN1LCmWOMX8PcZMQ404tZWSsAGOfvIqa2gxUaOH8K+VvjQr6Fzk1mS4g5qKv6KXJYGV5a+Wv5lgD9+tkEUjHNZZY/L4jvCnPMUV0LNO1n0Pp4NQLJBh03uSLn81VzKTpyvtsD/YP1sYWDKXZaRzqVRoC7ZXEBokKd1TvQX2I0T1vfIjAk7ecxVcnNbbarv3N0q6sco1K5aGzKAm/5jJkWWiDgtJtsdU1p5XBs6+OVX2oMgKIU5V/WQmpeJM566fg30o2cnbj31DyANFVIkOgNSsY5GMRPoDUfucwUqJAXG1n05gl6scmWyIxrc/27kn8DXHXnnwa8JIUZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(366004)(376002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(83380400001)(6506007)(53546011)(6512007)(6486002)(36916002)(6666004)(38100700002)(31686004)(26005)(2616005)(44832011)(5660300002)(41300700001)(8936002)(316002)(8676002)(4326008)(6916009)(66476007)(54906003)(31696002)(86362001)(66946007)(66556008)(2906002)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZklYTmZRNkN4Ync2RjF3bHN2SmlPTGNKanRNUlhLQ0VpV1dkUWVzZlljMi9m?=
 =?utf-8?B?enhET1lyUzh4Z1hac0ZVUjZtdm1ydTdSNWtBZzJTM2Zrd0MwSWlSQ1VtZkZE?=
 =?utf-8?B?WnVzZXc0SFVRL3YyeENrTTBLL1Y1Y1NWQzR4bXFWajc3RFZ1a2k1eWpFUlZz?=
 =?utf-8?B?dzQrMG1wc2x2bVBpbmNMNjRwMDJPUmxJeldoQUc0QkxzS3M0cXJWaTB4d1ZE?=
 =?utf-8?B?MVNtWjEyc0RsY0hTL0JyR1dLQkpHTEdGTmE5R0w5RURGaDdDNG8weXBwcGlG?=
 =?utf-8?B?TFhEaWY2ZE5paUJGankzWjBQR29rbFZGQXZmcndvcjBVencwRkw2WXBFT2lB?=
 =?utf-8?B?Ny9LenVQc0RQalBQcUltZTI2eko0R2tOVGJ1aXh2c0NZUlZTbk1IeW9FWmdY?=
 =?utf-8?B?aW9ncXRTNGhrdXVSNWo0S2ZyQjNXeEVBRW5UNVdIaGpXcVFzS1ZLMHU5N3ZB?=
 =?utf-8?B?eGlDWFVpbWdja0hmMzdUSGE1d3JzMDcyWWNoV2loN1djRlR4anB2NFhyQ0s3?=
 =?utf-8?B?ZHR4dCtTMkp0b1kwSGtYcm9vbzNSbENFb1I3VnFpbnNMWS9DZG52aVJKOThX?=
 =?utf-8?B?cTc4QkhTK2dibi9TcS92ZW9ibVhkMWlIanNtM3NrVkRFQzFOalNQRGRlYXlk?=
 =?utf-8?B?RWw4R2xtdzFCOW45SUNaUCtBUFUrYzVxNi96SHVucHhvZ2JNT1NLUkduV0VR?=
 =?utf-8?B?QWZuWmFSb3Uzbnp5TzZiaGREdFdXcnA3Q2RseUtQRDR5c2F3QThpRXVTL2VD?=
 =?utf-8?B?MkhGVlQzV1RBaXB6SHZZMHBvOUo4OUhYMnh6Rmc1Vy95RmpuWWdGbU1QK25B?=
 =?utf-8?B?KzU2SVpJa29SRVZiWkJybmlOYWYySWxaVXNlaHVaZ29qWkE2UGRPaGNVc1RO?=
 =?utf-8?B?VEhSSE16d1I3eVNRdEJWNklRUEYvMEw2TjRvOC9KdHJJTERQcDc4OWlxSUhl?=
 =?utf-8?B?WUlxbXdnL3ZvQWJxWXYxVU9BM2JDK05JT21yZ01oMHJkQ0U4RWhLa3N5NDFv?=
 =?utf-8?B?eWJkM1c3eHpYdUpRKzBtaUxlZFdHNVFKMGNiT3FDbXNTSTY3VDVkWU5OY2g1?=
 =?utf-8?B?NUhVVkJkUVQ2K1VBaEcrbStwQ2w4bGltNzBmWVl6SWE3bVRDS0hQb05TMHpS?=
 =?utf-8?B?QUtrc0RUZXpzNllGUGw1Ri8rSUI1MWM0NHk0MUswQk5lb050M3dPM0ZwaUhH?=
 =?utf-8?B?aWMwK21RSVBRNHJPa1lLKzkyMXBTTVFIa2ZnY053VUQ4Z3hNWENyQm84RG1m?=
 =?utf-8?B?UU5OYkd4UG5BL05sYllhWlpNYlRrY1NFRmNpM2F5L2s4UFZsZi9RVFkwaVo0?=
 =?utf-8?B?anphVi9EdjVTdmNUK0N0bEdwNlljOTJNWHVUa1JtZXQ4azRhdDZITnBrdmt0?=
 =?utf-8?B?L29Nc1ZjcTBFQVlIQ2hBRHFmMnZSZDBsWUlSb3lZdHd3V2N2OXNBazZtUGEr?=
 =?utf-8?B?dnQ5OWY5TjBobjhyWTlTK1RmZlVONDdRYms5Q0NRdjlRYmR3dmhIOXZRblMz?=
 =?utf-8?B?L3QzYldGUDlWV2czQXhjd0RCVFpXaDVmVTVjOTVUekp1Qkw2MGl1N21YQkkw?=
 =?utf-8?B?bUpzZ3Z1VDNUYlhOaUk0MXhtUXNWY1pwQkNkZFQ5VEIyZUhJSC91dlNlS3di?=
 =?utf-8?B?RXQ1UFdhMy9BMTV0ODFQRnQ5cVhsU3VGYlhkZENObWdBWlVlUm5nRjA5bHRQ?=
 =?utf-8?B?RFBrV2k4cjZKSFpubVV1RE9OUzBuQnRsWXdhNXpKWXhSd3gxQ0I3QXVVVlVZ?=
 =?utf-8?B?N3REU2VxZG0xTldIeHZOS3RwQlUyQlplV001UUUvaFdJd2VCMGdOYjhYL2pj?=
 =?utf-8?B?MmszbVNyTE81UTQyT0szODg4UEU5RUFSTm5WeEpFVlR5S2NPUDBCZG1LYmRP?=
 =?utf-8?B?SjhNUlZTcm5ULzdYdS9mYjZMNkF1OSt4VEEzZlZTY3d0aXBnT3RiZ2JpVnN1?=
 =?utf-8?B?OFNaK0g2NElGTm9zL3RGUTc1WjZ4aVZOcWo2Nzg4V2hzTDhoTnE4MjBLMG5X?=
 =?utf-8?B?Y0xPQzZrY2ExSFlvUzV4dFg3MkM2bG5PcWpVdUxVV3RlWXFGUk9CRUM0S09N?=
 =?utf-8?B?SHdNU2JmUUY3TFJnS3VWa1lkbG80OXdUeTc0RkxFQnR5MUdvWjJBTHdmZ21m?=
 =?utf-8?B?MDJFdVZPYmFUeFBvWG9IZXNhSjJIWnhoVlQ4SGE3Tko4MFNoT3JXa2tydEl1?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PB4bMK/Jn5ZdWT+CINNqiPxsD/OD/UuppzoP/9n7eS/CYBUm1LaKIddBYcf2sJ9cxcJ7Ed3zboMuCA1C/hqBzXINOeOYNopyBIr6Z5jbCOlrPhhO9TTKiju4wJjLn3/diCiscT6MCFN0TYJCIzeHAIaVI6NrIdJgajHboJp/bkTwYqRirCOQEr4d85gAV9pwiaL0EOtOLWAYE4Op/OaDEKFAUYDQJX0JJ9+k2ia29SiE/TQEaRPrLDN48+tAFJ/MLsxoxXnwPVPjRW0yorIYEAh6qOdE2alBD1q2utDriLDqnuZLOjgDnyTyIVC8xy/T7PtuX5+xt4OwjmNclQcM8zCuERBDsqI6/vOeNW0smPuTS34LllvqogfHhG0cbQO8jUDOB9KMD7mxtp1F3PAZSqxzFNSojFOHOcKYewSDM5kAWivcdQ/7t/bbVjnMsaNZW2UQLmfy1JSMKaARZRUH5X8mUYm5xyMhGpePLwd7vnHlM5siFmtdhMEM9jyy2LZ4hGEU4YnHHYpT35HT79/Vg+nTqsTMRf462k8XP0JyEVJgNkw5U3t4N626DDn2OxS2jye1NT+420srrwZSVhCLPpgguFX1w3rsbCmzUCGlsMuXgCKEfytzJtq7HNpSF9v8m0fprJ3pmmYh4KvRG0INAhgoeocKw7LlT0d/mCAAI6RV/YCQkhWb+BUoUPyNGnS5UKQvx8Prmq5ogIV7/ANUAEMnJXRn5RCr+AqDJpfo4TB5ogqxf0Drggsb8ipVzc6PRv3umofK+LWP5jQH/nNWKfiu1hSgc92TpO44niyowFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e0a05a5-f620-406f-eb22-08dbcfe27f26
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:59:50.7140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDydl/X2JfUiQpBoGocSSjjge744lPctnmaQLTNzSa23iAgCAW+xgclzxsa2REMEXTjthAAuRch5bq3EDIN1YP+JW7Pp8EWnbQTWuD+Boho=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_12,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310180116
X-Proofpoint-GUID: 96tmm-At588xx6uGKh50eyq4YZLGqxlW
X-Proofpoint-ORIG-GUID: 96tmm-At588xx6uGKh50eyq4YZLGqxlW
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 10/18/2023 9:53 AM, Juan Quintela wrote:
> Steve Sistare <steven.sistare@oracle.com> wrote:
>> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
>> reason.  This allows migration to own the Error object, so that if
>> an error occurs in migrate_add_blocker, migration code can free the Error
>> and clear the client handle, simplifying client code.  It also simplifies
>> the migrate_del_blocker call site.
>>
>> In addition, this is a pre-requisite for a proposed future patch that would
>> add a mode argument to migration requests to support live update, and
>> maintain a list of blockers for each mode.  A blocker may apply to a single
>> mode or to multiple modes, and passing Error** will allow one Error object
>> to be registered for multiple modes.
>>
>> No functional change.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
>> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> Something weird happened with your rebase:
> 
> (next *|AM 1/1)$ find . -name "*rej"
> ./block/vpc.c.rej
> ./block/qcow.c.rej
> ./block/parallels.c.rej
> ./block/vdi.c.rej
> (next *|AM 1/1)$ 
> 
> trivial to fix, so I did it.
> 
> queued.

That's strange, thanks for the fixup!

- Steve

