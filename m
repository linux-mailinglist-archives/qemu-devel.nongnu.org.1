Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 783547675D1
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 20:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPRn7-0005gs-PG; Fri, 28 Jul 2023 14:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qPRn5-0005gg-Ch
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 14:02:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1qPRn3-0002p1-Cz
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 14:02:15 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36SF5AfP012711; Fri, 28 Jul 2023 18:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2OwYoZPUdu39IiUjm8ImUwnlEiGaQsdJ0Fsq47wz0YM=;
 b=K7X+FnNA3hveDkrM8u5ooQyTCHAOO3UBIzn9g1gA7vo+fgl7g/v9v+i6PayIylZxReUh
 Xrg1HBPZGd6sqhIyCbvd2ytvVHdlhCPcmIUoRD+WcDbHfyT2+rMOnMjYmUcSMZdu7dKt
 8E0I5zijHLJKADhAXrzFPo2On0m8zfY6WwFy/+9sLrItOdl5DY1LYvSUbcggCmPPZXcM
 jjkrIelZ4QqorNF/jszedZvvuVOe9+f16P4g73WJoU7Uml9K9DoC/Oe60avGanCiO/PS
 +Hapz63K0vn/rRPv8HwU14XSOB7uA9MXGpnM0ynftekTRDfLNeguB53AGgZdejrLd2EA SQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q24gtx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jul 2023 18:02:08 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36SH6jmu033437; Fri, 28 Jul 2023 18:02:07 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3s05jfpy0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Jul 2023 18:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/n2jgOCkCrIpgchw/fqWPTB7Z6PLqkLpz/g0JLs/habq+j1xlsMn1EqoHhmVSFzW7ahZp4nh5+CHObSMnm0mTFk5C7mfB3IvxBihZywj62S9IZikcZegQw31NBsKPrKsRIIilKPJLIWxr0p7Ms2IiQ6sAdaory3wywe/cstBoAS8RZycmuH8KppTryM/s5BWBCXtJP/7VsV3xyFx8rjpWoHHkDCkDo/+Usj1kzpBjORW/4XaL2m8jFbaGq4CeUSOm2UAcOZ2SLszDAJVqzlxQ9vVbqUZroEEyRSihPdHZe4GKeGVBgbK3FSQe+Vz5hyAeuWO3jXvz5w1/RNIEFJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OwYoZPUdu39IiUjm8ImUwnlEiGaQsdJ0Fsq47wz0YM=;
 b=HYJvrORqcwbV9EB7pkqIHbeTDyNteiMMhyqEy6XjodStw2DyS71gcV8SIR+kR4QkYTV81FpfLiznyEYTSl/NjnMJofS+5Wgme6+Qd4lv8OldbaiXGb1WzU2wmVmT17m5U2C+1MvMcYL6J5IuFqsd7/rkxjjdtNhvyUeuPJrgXC/4UeD7Ws5Uc4bKmzFGtIjz8h2alBBWtOR7pP3KaxPmfeqPs/gtwilaW9Mm3lFz0d7Hfkfr9pFdWDTJrhtKbbzFvKyO2GBCxsbJIoOpEeVmrix1b7AtCOg73jpz94TurXI1y3RNv0XJp8L446CtdnMW3LXWeV1wmNy4vE90kPkmqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OwYoZPUdu39IiUjm8ImUwnlEiGaQsdJ0Fsq47wz0YM=;
 b=NeayKaW/bzOvF4QxeW2aXl+iVSNO2YyZ4AObRGYM2bcs/ozm/iGfrmGqoi3q++6YuYek2cj5QqImFuY1NVf38ZnqAhLHHLw1ru2cl7mO07uusqoE2DMlzJWsxWYiVF8rEXMprIjmqaHx2Vol1AgYcqYtTd9qAawtsbMjRDTPc2o=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by CH0PR10MB5051.namprd10.prod.outlook.com (2603:10b6:610:c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:02:05 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::9d24:e1d:4d31:10dc]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::9d24:e1d:4d31:10dc%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:02:05 +0000
Message-ID: <5d0d8d1c-b779-5117-d68d-6fdd3648353b@oracle.com>
Date: Fri, 28 Jul 2023 11:01:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] dump: kdump-zlib data pages not dumped with
 pvtime/aarch64
From: Dongli Zhang <dongli.zhang@oracle.com>
To: marcandre.lureau@redhat.com
Cc: joe.jin@oracle.com, qemu-devel@nongnu.org
References: <20230713055819.30497-1-dongli.zhang@oracle.com>
Content-Language: en-US
In-Reply-To: <20230713055819.30497-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2663:EE_|CH0PR10MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c95836b-22a7-45da-a8b9-08db8f94c063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aTFyeqYFVmF4BbRbFyghpRFmNBWZoTqumw3RJAVkP7K3EX1AeSuP42Hbx1DxmE/LmIq+vVax9R5EJc+F4LZFK7cYps8ACPC080OXMGFAA7EgIrv6ExiQz7aW69BmzHkpozsDyvCV68tTx579sEhVgJffqG1H1ls5X6ij8rj0lE1QNBCwijJWe9cXHGYVz4UChRrEs7uWJTaHXg3Dhdz5dkf1IYLAXC264Ish2xZ3fSggify9WK5n5Q3kcjegt4v1FoKg68EYP2G/LObfTgoSmimx4DMQba//8ICaNBSL39UXJlPl09W11rd1kcU/ZAYCN/xOrIEkO6/k1jnNYjV8ylYQIhzMe/wOV1tCCBFPoNv0SIK6oHBivA4vEwqWm7ISj6bIkf7XE3tXgQ6VKFf68YxkkP9VTtFhIix/bc1THZAZsoiM5U2YB7uQt63LcdB9rWAooxrkFryb9eB1Hkk8cgOQ/F0UD0Gqf1+NlAH71q9HX2YQJVH88MxBp7zCniN+y6x65Uop4wGC13U+M6MZlPoMRO4/mIwVpG2ebzoKZ4EbxmdLWwbz+uZr6wWefWnuE0bWpWiXOclOvsVxFzcDXIGbHnKICB53vnIcsAXyfVUZbdCFYRW7eABauOv9yiu7KukgOzqWr2cNf8cOUnJYkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR10MB2663.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(478600001)(6512007)(6666004)(6486002)(6506007)(53546011)(66476007)(2616005)(6916009)(26005)(2906002)(66556008)(316002)(8936002)(5660300002)(8676002)(44832011)(41300700001)(66946007)(38100700002)(36756003)(31696002)(86362001)(83380400001)(4326008)(31686004)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXJsdUxacW5CY0lIVjlVV0k3SHFYdE9FRXlrL2EwOStKRUM3T0xEVjBRenNl?=
 =?utf-8?B?cXlwZnFQckx5YVhReE9ockJEYmRyZ0ovUmQwRzN2ZnJud2lBcU1LTE5VU3FL?=
 =?utf-8?B?NVE3SnY3dkQ2WkVidVZ1aHVDeXg0K2JmWSs5eGdGUElERUVzUk45YmdmVmlH?=
 =?utf-8?B?Umg1VWxkd2dTKzJCTmZLbzd4OUwreFZyVzArUjJoaFNzWEVmN3hQR21yM2to?=
 =?utf-8?B?RXRoUlpiZHNFWFgyUUhWQWQrWnFwbUptWVMzSmhZVmc5clZCNmFIenZFem54?=
 =?utf-8?B?SGlvMEVmck8reFBZRWw4MmRua2wwMFZxUGs5MDZ2WkdiMkJyZlVnQ3FJTDdJ?=
 =?utf-8?B?S1NrTFRORGtRTEdSVWVmTnVNRzVweVhUWFZ0R3ppbzAxK0hJL1liWUd3NzJ3?=
 =?utf-8?B?eUFnTytNVngxK09PTUlvYkVMQzd0YWVtNkRwRUYvbDhnbTUrWElpRCtEdFRq?=
 =?utf-8?B?Y3VhZHhRVmRUeFdocDVJVEJDRUxHdndhTlBOTG5xbzcrTkRDQlN5YzVuS3dW?=
 =?utf-8?B?RGZSU1NiMkVaaUtyUlloMXpZNTVVY1lFWStlTXJPNVRGS3B1VEdlYy9JdWs2?=
 =?utf-8?B?dFVDVHFRYUdiWm9sYSsxM1grSXZBYklXRUkwNGxmQVZTekI2blQwVVpLa2pa?=
 =?utf-8?B?R1ZlVFF6YUJ6Rm5pQ3Z0WDIva0h5YXZ6WGZ2TUhDZWFqZGxoT08zY1k2cFJt?=
 =?utf-8?B?VCtSYm5iU3JjUXdxTG8xeGI3OGduemJVOE5zWGQzTmdHUnFTVGo1MjlaVmYx?=
 =?utf-8?B?dC8ra2JsN2N4NVpIUDRwK3FlemRTQlY5ajd1aXIyRDJNY1c0R0hBazlSNDM5?=
 =?utf-8?B?V1hGenRzMnNXR3ZodWRHVHBCNXJoaDVmaVZ5ZmNQelVnUGNBcXEyQll2azA5?=
 =?utf-8?B?QklaTzhFaGk3bzlMOXNRcTJ3YzlVeGNiNENGQ1laOWZJSlU3cFhzYUlnQnVP?=
 =?utf-8?B?Z09OUVh6OEk0QVlxekNWVlY0Z3gwSFFmalgrSGU2WjJ6amQyTFdXaUZkOFVn?=
 =?utf-8?B?SjBmL3U2cmNaemovY2s0bFRMZERuc1hUVk10eTFsazlXSDJQd0k0WXE1MjNE?=
 =?utf-8?B?MEpLa3E1R2pIR21xanBxSWIzcGdVMkNOdmoyNGxRaVdmK0hrcWlnWDV0eHBx?=
 =?utf-8?B?Mnh6VkpZNkw4UTY0a1ZQcTRxbHk0eUZnbkJsRHNTNFp6WEZTb2lCMnpoaUdt?=
 =?utf-8?B?U2dVVTNkM0JpalNDcllTZ3BQOEEvRytJSy9oTFY0cThrdnBCa25GQVdpekVS?=
 =?utf-8?B?TlA3RXUxdWVXQ0tPVW9JL20zc2JCSGEzdVR5UkdjekFRa01OWFhmV0FJbnhj?=
 =?utf-8?B?T05STzgrdCtHWllFOXBWd1BmZ081YlNKNGFQcUorN3lvQS9NZjNCdnF6WGVE?=
 =?utf-8?B?c0N1aHlpMytROXJoMDh6SW5xdUg0MUhEYi9weUlvK3JOQjVrRXJ6NWlab3Rj?=
 =?utf-8?B?T3ZhYm9xV1ZKMFFHL1FwazltNWx1ejFZUUFzOThidk5CSjRraGI4TzA0Qk1K?=
 =?utf-8?B?dDMyaUNSVDhKUHZlMG5Jelp6MkVhait0MDl0c3pFcFJTVlM4ckNnOEVRdlpY?=
 =?utf-8?B?OXRLa2JzR0N4dmVsN1JtWEtIbTdBQkpVSVpYcjlhTWowcXRwdEhxM0d2a1ps?=
 =?utf-8?B?NTAyejA1WWZSQ3JzdXFsUUlRMERkNllIODNDenNNWC9vVzVIQ0NYdk5leDV2?=
 =?utf-8?B?MTJpRFp0ZWRZT0gzUWgyeVFTbjdtVHpwd1FwM1kxWmhRY1FZNXZYRlhUdDlt?=
 =?utf-8?B?bzNDZlNNQThSdmRlL3ZydFJlZUhCeHlORGwySm5LbGVMYmtCdWxzcXUyaGIr?=
 =?utf-8?B?N0RnQVRIdC95ZURLNGlua2R3enROb0toUmc0UTFuZUlYWnNyTzdxNm1mU2VG?=
 =?utf-8?B?eVlZaWZNbjh2ODd1WTQ3emN0anlDdHlEMWE0TFBrTUtFcDBHZ3F0azRxZzlk?=
 =?utf-8?B?RGFjL3hPVFhreWsrR2E2Vll4aVFIVjQzWFlOSEExODJTSmN0WlV5N3lkcVVB?=
 =?utf-8?B?OERyN1pWcDhFNUVLMldQNUxqeGlTTmVFSHYxMzRQUkZLOXFlMzAzSkhVcDJE?=
 =?utf-8?B?ZDI2dzd3dS92STlXcUNNb014OHM1RXFrMHFyQ3RuWDZsWmFQL25ac1hnNWcv?=
 =?utf-8?Q?B7D4oKmzZ2JAOGWUzWmYcvCKQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8E0bWxm5J9nZuL2PK4AMCGEbrFBbG7tBYZEdjlRDCl/shFjI1IOyiA6JUsOBg7uL/jAHUla2TLMsod1S13ChBqDZedAED9kKf0mFKCgaCflbY+dWUiWkJENiuqgFigGVTq7ojsz8faBysFMBBtxQP8HxM0xHdHU0jzIqQdmCGJKCUNFglYiJ6eHQ65/BJLltE4WmqmACuvuqoK+ZmavTpqJzZXUFFIupa1BOajivFujwPfoV0X8WpX+vafJRcj0+tER/jzP8R3qo4eBHGHgJtQQlAEkZJLzReSuZ1HIciyDiIFQvZ2++5jpR2Fr71TPAY9qWIxkyTftZr0zc60zY+yICqaigmiTvY7YhYId+gzlSDoorT9oYUOOCyQwGT/N3yrWbxvW8yvxKsdoqnUeIXEIaouzc5KOfIDRfaUkyYdAZ+T0gQQ8bLSX4yZ9/oWDH45Cz9mLkxu5IaSR/V/VEoj+M0dO4tVg9l9+a4U48E0NKDLnWy6lmU+xxTMFjPLN6SkngZZU3wVudmxbHWpyHZqYytj+x98KArSHGQnqVcUa6dpI8Fs43RruVFkMnY2h/1vOucBso6bBokdBXMQeIR42UWcbe37xfH43R6Fmirt4d3wYF+AeHxahz7Q5SjOEobdP3CHTvTIv5YNilcmIh13+DidcUTgSsqPLO97bWeNm6TiI6eA3B8tgHkbioT2SyNoL8aSlZLQNPHz7sNSrtFOgdAWNzI6KE1Pzp/af1rb5ophx/2ZtnKJXfKej7FOd2Ih/nUfvBUA/bO8reafFAwQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c95836b-22a7-45da-a8b9-08db8f94c063
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:02:05.0495 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QEf61e4GPeQfFDMFnOy6msT176ISGvqAjKRecrB+Fpys4VXaVvUVyomGR6LweIQLJiWPyFT1SwzclJz5wBZbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280163
X-Proofpoint-GUID: 38z0N7-ha64TCJyS7ueDmov-QaGN4bM7
X-Proofpoint-ORIG-GUID: 38z0N7-ha64TCJyS7ueDmov-QaGN4bM7
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

Hi Marc-André,

May I get any feedback on this bugfix?

Feel free to let me know if I can help by collecting any data from the aarch64
server.

Since the pvtime is supported by default by QEMU/linux, this indicates currently
the dump does not work for aarch64 with new version of QEMU/linux.

Thank you very much!

Dongli Zhang

On 7/12/23 22:58, Dongli Zhang wrote:
> The kdump-zlib data pages are not dumped from aarch64 host when the
> 'pvtime' is involved, that is, when the block->target_end is not aligned to
> page_size. In the below example, it is expected to dump two blocks.
> 
> (qemu) info mtree -f
> ... ...
>   00000000090a0000-00000000090a0fff (prio 0, ram): pvtime KVM
> ... ...
>   0000000040000000-00000001bfffffff (prio 0, ram): mach-virt.ram KVM
> ... ...
> 
> However, there is an issue with get_next_page() so that the pages for
> "mach-virt.ram" will not be dumped.
> 
> At line 1296, although we have reached at the end of the 'pvtime' block,
> since it is not aligned to the page_size (e.g., 0x10000), it will not break
> at line 1298.
> 
> 1255 static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
> 1256                           uint8_t **bufptr, DumpState *s)
> ... ...
> 1294             memcpy(buf + addr % page_size, hbuf, n);
> 1295             addr += n;
> 1296             if (addr % page_size == 0) {
> 1297                 /* we filled up the page */
> 1298                 break;
> 1299             }
> 
> As a result, get_next_page() will continue to the next
> block ("mach-virt.ram"). Finally, when get_next_page() returns to the
> caller:
> 
> - 'pfnptr' is referring to the 'pvtime'
> - but 'blockptr' is referring to the "mach-virt.ram"
> 
> When get_next_page() is called the next time, "*pfnptr += 1" still refers
> to the prior 'pvtime'. It will exit immediately because it is out of the
> range of the current "mach-virt.ram".
> 
> The fix is to break when it is time to come to the next block, so that both
> 'pfnptr' and 'blockptr' refer to the same block.
> 
> Fixes: 94d788408d2d ("dump: fix kdump to work over non-aligned blocks")
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  dump/dump.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/dump/dump.c b/dump/dump.c
> index 1f1a6edcab..c93e4c572f 100644
> --- a/dump/dump.c
> +++ b/dump/dump.c
> @@ -1293,8 +1293,8 @@ static bool get_next_page(GuestPhysBlock **blockptr, uint64_t *pfnptr,
>  
>              memcpy(buf + addr % page_size, hbuf, n);
>              addr += n;
> -            if (addr % page_size == 0) {
> -                /* we filled up the page */
> +            if (addr % page_size == 0 || addr >= block->target_end) {
> +                /* we filled up the page or the current block is finished */
>                  break;
>              }
>          } else {

