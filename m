Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 847927879B6
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 22:55:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZHLy-00064T-QE; Thu, 24 Aug 2023 16:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZHLw-00064A-Uy
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 16:54:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZHLu-0008FL-CA
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 16:54:52 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37OJEVCb007563; Thu, 24 Aug 2023 20:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UPdVXGzjDGng8C2QX9u4ewegrDc9X41fXJrHGsHO43c=;
 b=Q8crtwkVjR56V7fCJiZ/qgVn/jHGQQ6tPVcY1tUiqoRQ+UFFAkgDZAOKheoqc2sVeOEK
 JWTuHXqbjHdbgimLClDWeNq9mQgx0Lyd8mLeTsGBEeeqTancYiymBR/Z5uv5A09WWsqy
 VCHW6e9rc8v3W6ZQwefKYE7D1puezWgyBxfXOuXflxReogiMYLOEliFUJ3zmzjTxZUin
 0B6M7YW5IAyZhCasgNkZY4934NH/m8Zj87q7/U4FaCdtMjOgWbsaMgaN/27aH9DsFwUx
 NJflLfzTMw9DB5vSz/wbGC7gnFQ4lw8aXj7Iusc8AvkQTJ1Ao6TKcLc/dNcDbjvcqQ9r eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvw2gq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Aug 2023 20:54:48 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37OJV7AZ002156; Thu, 24 Aug 2023 20:54:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sn1yx88j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Aug 2023 20:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgOHx1IWMlbheajJZAYPguu2UCRpSCjTQBkQYQwdnv/bgYEaaHgaPtWNzrwm/6FE6HKTMegLJP0V7INj4cJu/SzpU3rj2zbJVZRdSC9bq7iT0brcLVzlpcAqYfGXm1istZz+OOOtYKH8LEAbQo0wNlahgoxxAFjI6FnRheGMb2dbikoolJ15srQ56phZs6Xs1cYMH3Z3YxE2ilZ36lWP8QHK5TR/NVRIS7+X9pylW0ZwCT7eKrU1rFMgMFG2HuLIiNWUEQHRZDnTYtJfTMFpL8mEUwRmaIdaAFYiGIW2r7YXLSlPC0BBVoepTOUrXCiy1mEXG3Gh2JfO2rZSgdmxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPdVXGzjDGng8C2QX9u4ewegrDc9X41fXJrHGsHO43c=;
 b=M3cJadjIQCY6hO5W/Jwfx+l/tlo8BNXIoGWPUw8Jz/kkk71gDveW3yGAvTjFvUv6i0RLewMhk5PJOTwuwc9lBU3W0xCRfP3yKnBCzbCA8R5BUxrCBeJWUf8OrZpJLTF+YYmARZPO421Jl0Tyl0dM0g5mpyGuHC6xfkO9FeSefD2hZNN3Y/aqgZ8zhLMBwtyDuDay468IaEabg5GRofEV8I4BTyXbLsycQsAe9VHNmaIoVleNQNDC1O+cr6u22BdJbHryep6J9R8MEsGRiQvFojivuLvkzLvw2qe5B5P+7B1qSBnEwoZX8Mrk7NC716w3nBCtWJMbr2I7Yv3LUAoIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPdVXGzjDGng8C2QX9u4ewegrDc9X41fXJrHGsHO43c=;
 b=V8Jz3RyYrDSLlmHSfVLOX+bKH1ONeJTkEyWHNhc6VkPn1QntU5Gsiwf2aP1rI3gRpJ7yfBqV3+AWVaAkF+6GoXDW1KehBHV87UPpX9O+5xV0UAHlebYlmMU9RO1vuwo1YNKZnm7mrn1BjlfrYz5sStGG7XRlDZfUD6V9SvlI/t0=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 20:54:44 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 20:54:44 +0000
Message-ID: <04ca9140-57c0-b41f-5d7d-2e99de83af1c@oracle.com>
Date: Thu, 24 Aug 2023 16:54:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V3 01/10] vl: start on wakeup request
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
 <1692039276-148610-2-git-send-email-steven.sistare@oracle.com>
 <ZN5ml+277ufAE2jm@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZN5ml+277ufAE2jm@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::17) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b62b2df-8f4a-4e23-121e-08dba4e45875
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Elcnj2Q4C+PL4ydUBGNLYUXRMCfQJYBaCfw7egpDcNbBuuum+W1JmH+WLu011dpwKzz3OKXxeYSDOUKM3Ip+9ZHtfP50wnlAotLc/f4QoXhKXj819JnTwNypJd70ZL4Tt/qWhkKjFq7Gg4QIpr3etM18CIg5xd3h57NSvdD4RJcxUCFAsLZR0K5bRmaXpzdzW0iqxfROh3tKzRr8uEzMek6tV3yKxugl260ebNZYEm5qg1Ej8fGScRNapO59kibX6bQ9IjYMpe+H+2ww+ei/hihH8/pEJGckAD4T4ISTSIV93HJ/8UrNYw5LnrHK4LgQj4smFXvIQ0Sbkk6xKT3VoG6NF+cHi8OZSuD1d49a0qKytT0kepVWRRCTPkNOPi+ZF7UEr0X8mt8nZpMjWBf0KI723P7XUUOgFo6ERVqByqDSCCL9/d9lRn62A8ljJ03WHw3FEGeWZsKA/SeMRwtAj1rt/j+a9DDMSykrSgYnTOrc3c+XiZzkqE4BCVW0ZnWrVyJ65H2Dtz3cUs0zNwN+D/EWGt/zLBl9JoxYl5qHwmp2z3f5m0wqr1aMitMI7UArRX0ly0RF3cEcPjhFsskF3/eoYgjBpG5szSdvWvTBpmCQxZrOlslnnYxvvGiNsKtj6cFwCKxipkrtDoPUh6DP6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(4744005)(53546011)(6486002)(36916002)(83380400001)(44832011)(5660300002)(86362001)(31686004)(31696002)(26005)(2616005)(4326008)(8936002)(316002)(66946007)(66476007)(66556008)(54906003)(6916009)(6506007)(38100700002)(6512007)(478600001)(8676002)(36756003)(41300700001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZ2UkxqQWtNK3YxSlJZaTZUUldVL09uN2lNSzZsbTErM0VhdllnVzZOMWFa?=
 =?utf-8?B?ckxCSWgvMU5XR083TlFQZzI0SUtaSzBKRGxOWWFLK0tsQUZETkR3Y01RZGR1?=
 =?utf-8?B?TmI4b2NlQ3RLS0J0THFCbzBkaXdjYzJNQzN0S2N0V0JnQlpPSjI2NEZsTTBl?=
 =?utf-8?B?b0NMdFNvazJHcDJob05BYnNqc0Q3S2wvaHcyZi90emV3OHdLdTR3MkYyaFBH?=
 =?utf-8?B?b1d6S1Y1NlNkNVZLL2x6eVVRcEtZWWgxVU1JUndCbndJTENsdTRFNXd0SWRp?=
 =?utf-8?B?cjhCMnB4L2c3MWVHZEZZNUIxQmIrT01peU1RMzZwVTVZQlZwTU5WMFdrcnBo?=
 =?utf-8?B?NXJmeEErLzIyVDVnY0hGUDNmWlJaUzZzWTM1VFpQL3dxV3JIUzYwS25uSkNp?=
 =?utf-8?B?eVdPWlJIK2E0VlBWSWR3YkJVQzd5ajZ5b1RaTC9QYnVUSTVlODhBcW51RjdP?=
 =?utf-8?B?ZVhqVk56aUhsMEV4d3ZrTncxUGRWTTh2RjN1L2pjOW4vbEhRQ1dUeVppeXF4?=
 =?utf-8?B?aENnVytWQml5MVN1YlRqZGxKR0JrV0lHTUN6eFM0OFZQVTlPR1hiT1BkR0x1?=
 =?utf-8?B?b09VSDZRUTFWV1VNWmp0Tm1mZnZsdGJ4RUp2cFh2K2l3Z0tRTVdoK2habXZk?=
 =?utf-8?B?ajIyL1hDa0loY0lDb1pabm1wNE43Tm1JSTNTQjB6K05WSHlLUXRWN2JjVkty?=
 =?utf-8?B?dTJUZVFuZjR2Ymp6Y3lUeXZ5NW1JL1hKZzU4MUxvOFVuNzJGMHhmVE0yRTJF?=
 =?utf-8?B?eDRoK1VjQ0dnMFR6MEFEako3bEMreUlVVFIzZmJnVG9YNE95cTI5N1VPT2Iw?=
 =?utf-8?B?US9jUWRMUmN2NDlBOHFORXNvSzR3ak9ES2R6STdpSW4xR1lBTlJ1K0xlSVNB?=
 =?utf-8?B?NTVBTjdKTkVOcjhNSUJlRjV2anNyUGN5QWw1TGFoVWdsK3dSWHduZmVralVI?=
 =?utf-8?B?RWtQdUM0b21hOEVwWHdtZ2ovU3E3Z0l0TVIxS1Q0ZXRHK2ZZZzRMZlUxbnhH?=
 =?utf-8?B?V1hPOXZNVWh6eFBaNWhDRyszL0F1MDRHMkhRL2dYbXNiQUFpS1l1TjRyMCtE?=
 =?utf-8?B?VFJZZmRpdXl0Q3B6Q2tCejMyYWVyL0pobW1ieUJmSzN4THJjVjZQenM4NGlS?=
 =?utf-8?B?R0JXQWZ5V0tBRkNEdnRBR0xvdEEwUHRXMUNwaDBXOW45QnJ3VW1JOUJCM0lG?=
 =?utf-8?B?TzRqSkN5TlJIN2VLNlJ4ZEY5bTZzaXFlbXFMWFd2VnFudW14dFZOZEUxTzJT?=
 =?utf-8?B?aFNwZlkxMnlLT0xiV3dJQ0E4eTNNNUc3QmJSS0NoUGxBQ2F4eWNjM0hVWEhF?=
 =?utf-8?B?ZHRreWlrdUsyOFY2bnI5QnpiSEhnVS9EZmJ3SCtMcUVINDBUTlF3eDNrWThV?=
 =?utf-8?B?RkFGWkVva3RBZ3JMZ2xwTHdCTjNOaTdLUmY0NGc4QXNZTzgzN21HSHBwaHJs?=
 =?utf-8?B?eVM1eFh4UXlqM3VWWEk4RHRYaEVncEZJbjlsM3Z2ZFlPeGJGVFJKdFdQMjQ1?=
 =?utf-8?B?bHlnRXNOZHM3K3JaN2Y3ekF4OEdZTEo0czlpNHlPMzhlcmlvek1oNGo1YXI3?=
 =?utf-8?B?Q0d4ZE00WENLWTdZR2NlZDJTNS91S2hQY2dYNUtoVlBhdTVxVWxldUNQNWRu?=
 =?utf-8?B?eEdKYkUybDlxQ0thM3pDMDRobFVkMjAyV0NYQmNHRXowOUdaWlU1N0VSQXFv?=
 =?utf-8?B?dFFpNXM4bkltai8xalQyYTFaL3lCQXV4RFRYWGd4Uk5YYVo1ekNSUExZbzVq?=
 =?utf-8?B?bnBKclhXNWpLV1FMUDRkWGJHRW1NaWxzaDZ0Y1dlSkwvdmpROU1yRTBwZ2V4?=
 =?utf-8?B?TTB5ZHFTZFNnZ0Q0RWU1OGlVRStnMWd1WUJCRVR1anYwYmJzbGRVTVptR0lt?=
 =?utf-8?B?ZTQ3ZDhLUnh5bnRuWU50emJJVGh4SThycE9XSTA2S3I4TS9GV2pybnRkSm9w?=
 =?utf-8?B?ZlVWYks5RWdqc0VvUnlFdVNHY0lVUnQybHhrMnkyM1dmSDZsK2c0azNnTE9J?=
 =?utf-8?B?dm9lQ016bzFvaWhESUd1RXVEU0VwVTJrY0pHVy8yY0c5YUdvRURwbEdRcDNy?=
 =?utf-8?B?TUVvT1ZZbTM3R2dUWXlsbm1CWXFTTmZpdTNTaWVDb1EzemdaZmpocThwVUxL?=
 =?utf-8?B?bjVKcUtCQ085QjBrMDAwYkowcU5XVlYvMk9qU01pVWtKdllsbjVoUzEvSnlV?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tsmQVEJnS2zQCX5SxvbOdsoo7n9kHQUucI6vpn/YBo383EcVpFYu7z85DrlkoDe24IIZLJ76MBaaqZXhSi8MX1McOY91aG0nwrFxp0dvKs8vAqy1lX7VoClBpGRCKj+dAnfR5ldYEp9lm7EUDQFUX/e7RvZrS0iLPqfE3ibzUpYimk542eBLfHkEO5u5zR4rSwyJgBGS2KJn75S/u9fgIkVn+HHkI1gBdAgQ8exqE0t8pFRgnb9igURgBoFKRn9JtNtVkR5TPdKHIfp2sbnwrUnr1szu5hi+oBnN0QB9bhCR90RmMcSTuWIz4Gz5ckiGpnNG39ahBaPS2h0SGF0QwHk3FCE9c66J649gsClpJMMpljmr+GNGEFKnxl4ukcboikxEBaiVaFe3GlDrqoK6vVsAxe2q4NSvAEC4at9j2zK5U9ftdg/TRbzvi5szXVd4y6fyhPEP9Mp+fQt5Lkx+hiM00xkFpMuw/Sk1UQxqpy5/SgA5wEh0DuPWsUiWlntzY85e1lcnEXQVm+uH6YbAtcV+jdxnwJa1Y+1MNxzON6DfIxloC7FnXAoEx+rXcYXRM1aIbcwggiVH/KD+5zSGhDcm3L0f94SQVRgdXoNS0GhxlpMu7V1NqFfqQ57+UAmqVeI/Gwr7xiflXvpdSyfM3hEaljKKVkl5ZyuJJkVa3Bnwi0+hFqi6wUuDf+pJta+IJj7zbwgsYOB+iWDaRfdhwhK1/qkCQimvnKAa6o3gKwadt0SiRAOotGlLwESQjutfJipeO7zJK6cTplYcLsMpuw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b62b2df-8f4a-4e23-121e-08dba4e45875
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 20:54:44.7942 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3XIGCTnFnZqNhLUX4WBBvotL3QE5W/CItycKTRNASGxOentHxTRdmYg3JFFaZsJrstKmKue3q/M6zSJcOuumeRIex1J2UyXBUYhe/t8zrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_17,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=667 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308240181
X-Proofpoint-ORIG-GUID: Tx6WgBSGhzFyHgTk7Q5nzUpUVjHq0PfJ
X-Proofpoint-GUID: Tx6WgBSGhzFyHgTk7Q5nzUpUVjHq0PfJ
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 8/17/2023 2:27 PM, Peter Xu wrote:
> On Mon, Aug 14, 2023 at 11:54:27AM -0700, Steve Sistare wrote:
>> +void vm_wakeup(void)
>> +{
>> +    if (!vm_started) {
>> +        vm_start();
> 
> (irrelevant of the global var that I wanted to remove..)
> 
> Calling vm_start() is wrong here, IMHO.
> 
> I think we need to notify everyone on the wakeup before really waking up
> the vcpus:
> 
>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
> 
> There's resume_all_vcpus() after that.  I don't know the side effect of
> resuming vcpus without such notifications, at least some acpi fields do not
> seem to be updated so the vcpu can see stale values (acpi_notify_wakeup()).

Agreed, good catch.

- Steve

>> +    } else {
>> +        runstate_set(RUN_STATE_RUNNING);
>>      }
>>  }
> 

