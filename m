Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D982C2A3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 16:20:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOJJH-0000Vj-L5; Fri, 12 Jan 2024 10:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJIz-0000VT-Bd
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:18:45 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rOJIx-0003Zh-As
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 10:18:45 -0500
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40CFFvSW006931; Fri, 12 Jan 2024 15:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=tdtZ2SaYqWQXmzXa4m6mUFFJCsG26p2w2/h9BfiXWRM=;
 b=JFoU7GjZ1hDs0lG7LqmNp9FPEd9V1RD+37exvgT674v+4DtEHD0BuYeLkxJbyNwV6HLO
 h3azcOjJo/GH8E6euBIrjfj0B0GR1bXYkirDuiZrOISrSWrNiEe1/gs2OrTk6iEYcCfR
 YQUHb/HdLEA8eXTZdFHGZ1hBTh64YaXC5LVnczqe9WIBjlTHNx8rlHty9GMXFF7Lv25g
 EdFVhWtmCs4E9ZP/mYITjTfYkaEI8WttVXkwsHm587UouMg8SotWw+MPuSwGWDeKn1kc
 1ujICUyHNI+nBD8Iy1/G/vk7T1damFqIS7eXEZWZloNBYco6Jgxa4IXE5YLuRDCKGDmz Gg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vjcbkkr47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:18:41 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40CF94UL013795; Fri, 12 Jan 2024 15:18:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfurgdu3y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Jan 2024 15:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLce5mPW5Bzxui4hV9q9dioxpz6S+pxpAWDBvIV1dRP9V5QY3U4b37Fvn6aVDGNslj7uCjgGZOK4o4HTH17YWM+8gsQeZIDYLvfhpeyJV9TEJGzl772zSoJ2EN/O3ac70p5GrcL0Q+D0ksGvGQaCEztEI2PDqwrjLeKQ4FZI0A5uNCPC7EQColE/yyFacA4EBuCp1an8XZVvxy24ic4qNFlBFEfzUrWhkzbOwwWITJ4VTyZFbiLMoGFWtSNWrbeos20N+bwa8EyuTPLNvEhK6Yf2+gecA5rzOiaILBShn4gKV9E6ebu85Ke9LPhwaEZ1YZRDDNKbUJQKNzKs+EUb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdtZ2SaYqWQXmzXa4m6mUFFJCsG26p2w2/h9BfiXWRM=;
 b=S/xuThuYrf0UTj6H5p8c/JsOOLnwozxPLV8ke+3E3IwHU4HmJOmgd5d0VfmlgzUJ10sbwMe9JV3hoH8zQpkDHG5wne7aONepBHBp3DgpVspECEpRi4CHQTrXMtgAT/KlslNoJCguhGCnhsJJo+CyhTf08E+seXnxhvSmum79BUJe7x9QfX22H53HrKQ32NVZVAMjb0TY9FVVEB2eJe0AX1S+8qjrOjHFQmysd2TE0xV5ece8uhs1oByFwiELcuBt/VpvZaZ0QIbU0hvwqKElLacm/cV/OOb8Yn96DCuIO8g9UYuSp+I1sIwabuTt093vT1Q0X+Y1cxRngWsI1ZPHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdtZ2SaYqWQXmzXa4m6mUFFJCsG26p2w2/h9BfiXWRM=;
 b=ZH4J4zdLkjv8BH7O6wCzcgksKxHjRHwsAhEF7VAGyIeIPpJfN2b0CpSp6ryVlySczhSFEEwN77wIMpONAHtUmfFh3QqwHKyiW9PFUajMqDVECB3zxJ/jnMOz9DQ3FA2W2tafZaE3fVPpjBFq+2ne1Pa84CMcOcBZ2txWcv9sbZM=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB7333.namprd10.prod.outlook.com (2603:10b6:208:3fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Fri, 12 Jan
 2024 15:18:36 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 15:18:36 +0000
Message-ID: <e93556b1-6176-4c49-8d11-476659ccb570@oracle.com>
Date: Fri, 12 Jan 2024 10:18:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 05/11] migration: MigrationEvent for notifiers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-6-git-send-email-steven.sistare@oracle.com>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1705071910-174321-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:208:e8::47) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: a94232ab-9f52-4157-ddf2-08dc1381bf6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eVQQiIuX5Bhf09y4Z4aISlpkpwHaGzDut5TtIvzY9MnIPAmT0OBap4yUfAtWKTVAr6Rvz4JMPrXlMQn4xKhGrealoSlUHKgmWNXaGa8LMzCq62klxek6t6zc0plhfLQOusHUhYC3VBoCNRhMf0oLlbYnxLv+ox+ZZMB5Uga4orPOeMYIM4EEZwY7srDkq36FdokIn620N1EPQMwhUXHF5glw9DAwqu5aYWEay0FPNCz23cWxJN8efmhAKY0TB6lFWy0kkY6faws4giQXryj+BMzEfwOAk3G8THQhM+Fwid19ahk3jeu6iulqg1XLcY447w9glgWN9A8Syavhr0MIDnH9DRFUFWag8IYgQh8W2nHkywVp/YmOcp/LIRanXFv99nY9E4eIZEIlbZEiyJDVUp7L+s6nQDyFurrc7kM7ZmQ7kNJiHKzkDGuapAyRvAuChOG8qf3EKjZ7vAANxeo/FKN4h8aBHqz9q4CpED4J8a09sOu3GuZVYnIb9sTKhRcMFR4ZIBu0XVOtdK9aNETbhoSLqjhd1Vvfn3y2FoFFk0V0762z7CoTGVbVcrV+CfhlC/dG1KN9y2v2/LnGeEoa01c94ZRDYsjinqwuqaxMwPNADQzoGzwh4kNoFfNKymZ+SFiYoAiUcwfGa7HanvnxfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(53546011)(6512007)(6916009)(26005)(2616005)(4326008)(8676002)(38100700002)(6506007)(41300700001)(44832011)(2906002)(7416002)(8936002)(5660300002)(66946007)(36916002)(6666004)(66556008)(316002)(6486002)(54906003)(478600001)(86362001)(31696002)(36756003)(66476007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVpzNXlRVFlRUXlINlBsNmJ6dmhiZ05TandzVldKMGhQNGM0dUJuY3daZmt4?=
 =?utf-8?B?cDFCT1dCRUVSUSt5LzJndktJVDFpTEFqODRyTTBrOVgvbGdHNlQyZm43eVZ2?=
 =?utf-8?B?WUY3ZUVka28vVlBRVDY4cUt4QnpidHphakEwZXdBN2tkNHZLckhITHhuNUFG?=
 =?utf-8?B?NDFXaldqYml2SEhKeU5RYlFidW9zZkd3a1ZEdjNIdlh2Q1BJc0c3bXFibmdJ?=
 =?utf-8?B?UVpUUnMrZ0RFVURRK3JJSndNeGZUUGN6OFJGZWFja3crbHc0RDQrUGQ3K0c2?=
 =?utf-8?B?cXVoK2xDbDNodGx3VENUK08xOVkwNkI4OTE1dEVOMFlnWUVYdmcySW1XbWVR?=
 =?utf-8?B?bEdveWltSUdBT0JacVV0QnY2clNQekx0YzdpckNvRVMyMllpZXZBVnhMdkFy?=
 =?utf-8?B?d0R1ZGd3cFpBWXFGMUl0dE9NOXF2V3hXRkJCeGpPVUhPSkxtOFIwMjl4bS9x?=
 =?utf-8?B?eFNOcC9YK2o3ZkJBY2xGODlPZUF3N0s4Q1UrRXJIOEFoVlk2V1BOQTByWjNP?=
 =?utf-8?B?MllIb2dFQ3dNTVJmUTc0QUkvWThiWmRZYUU3SmpHWWh4aldkdFJudmU3YUp1?=
 =?utf-8?B?REF4dzR5ZnUvY0hKeGwxbkdEd1RrN0w0bVdBSTZCSWllQ2VHSmcyOG02S3Rt?=
 =?utf-8?B?N2QyZFYrMElmVjdBNkJtVWtvT0dQNE1GcVVvMEhKM25MQ3hvS1d2K2NPK0JO?=
 =?utf-8?B?WlY1NGtHYlVFMFFrdjYyV2lkU2xCNnVpNlNxaG42QThucGdiY1pVUmk0cWZ2?=
 =?utf-8?B?c1lSd1M1QWIyd0tNVFg3TG1vTG4vSWpHS3pqakFhZjR0MFV4eFk2SnFnUGNP?=
 =?utf-8?B?dmJsS0cyZEFUclpxc1ZNdW11QWZPKzRmYmRMQVpwOVhQd0xRbFJuQWc2Qk12?=
 =?utf-8?B?TjUwNiswQWtiRjB1aWxzQVJ1ZEpUK1NBdTdTVVNVcFV2NWtZdWk4TDFleEhJ?=
 =?utf-8?B?dk4xVXN6NUtGZERPSDRUMFZvbHcwOG1PRHBLVGJrWW9MQjg3RGNPUUZCYzVl?=
 =?utf-8?B?blBSNFkzdW0vMHhnSkIySnpUZkVYdlZtNTJSTjA1dW01NDZuUnZ3QkVnUml0?=
 =?utf-8?B?ODBieGY4WjJkbzJUejQyajF0QWMwRlNaMTl0V3dpd2pZZ3ozYVAvaUpjcll3?=
 =?utf-8?B?czZqa21ibk8xM1psekRSTTd5RzFsVzhUcXlleGZFSkFoaDhSVE5RaFhMSDd0?=
 =?utf-8?B?R29JVjA1T1BuUEViaktxdk5CbXFJa0VxQ2VVelp6ckxpNUd4UFhjdGZWblBC?=
 =?utf-8?B?cm9lb2tGSUlzYU5aVFNidVBnS2RQSXZXd2ZSbkFQcHVjK0MyNndlVCs4cUY0?=
 =?utf-8?B?RnNvVjk2SGwyejdDaEpPRnBKUUtVQUFwQU5IQVc3cnhaSnZ1b1JXSldPRVhn?=
 =?utf-8?B?aUJQM1dKR21tdy9hUklyZ28rUGYySWZMNHNlNUNMQkNXYkJEWlJCMHN0WnJw?=
 =?utf-8?B?YkIxV1g1NVNCaUJQcFR1K3cxSEpDc2pUeFU1RDRIUWRzRkhaMm9GNEo0ZFJv?=
 =?utf-8?B?VUdtTlJ5WGVJNVVKVk55amxVQk42OEpYaTdzdmRRdisyT2wxanRob1hlSE1S?=
 =?utf-8?B?Z2htQ3VhQ251SVd6ZFhSbEp6RWtxeFhjNEJ6Tm9WbWhZV1pSdk13QXhsZjF5?=
 =?utf-8?B?cmdITm93aVNpSTdMSWpmdSs5eGhHOW04QU5aTUc2aUlZUDlJYkRWczd6UCt0?=
 =?utf-8?B?Wkh5MVIzek8zeW54NnNNV2R2R2dLMEpPOTQ2cHNsaWg0amozSVBodmt1SHBq?=
 =?utf-8?B?Qit3UkZHTkJkb2tNai9pb0JjLzNITkF5d1RhWm5ITEo5VkxLYzY4V1NyVE92?=
 =?utf-8?B?RHBWRGYvK3JJMjA5UkZWRHcwNENGWDJyK1dNcmhRcldxRW04RG1Ub09aa1FN?=
 =?utf-8?B?SGVZYTlHdWpFR0xsOSt5MHVYelQzSHZkcTdXdzlTVWlmNTdrcGlzZy9CZmIz?=
 =?utf-8?B?Z1RzN0E3UmdQMkNKVFFmUGtPN2R3Yy9XZXJ0UGpRQ2l3dllDM002ZDU3TXMx?=
 =?utf-8?B?b3FjNU1COWtSZlpYS21tMFNwMytQdlRuc1VUMWdCOHJBWkdIV1QvMGxYNGRI?=
 =?utf-8?B?cUQwR284cGpZUzg2YlBYVVBaVHhoQ3dmZ1FybEliKzVTVDFUQkJBM2lUalN6?=
 =?utf-8?B?cXNoOFlQQ09TcFNLQVJiaHAxMmZnWW4zZzcrT2NaOXgxVFRycXROQWRESWF1?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +olLVZ9wDMGc2lBQpKUpCZz1tD3rcCqJ5G0RWDwz/qA0nEr7Vv14Fh3TWgrsDY02/Pr8YlDMn7BdJbHC7qARulg0RKyV3wl2QYEDZRy3GIOcNGBbnVauUjMy2+1NtT68vfjSAQFrmnJLh12a77bggI9nE1oQiJN1WP1ootDifKKmtR73ohGy5JJ48fJqmnJg43Hr09tMl/anw4fN0ubG44OWYXuDhg/7dmLAzDjmL9EuMNPQ+goywMVQ+qc9Qsujmp6VxX070gP68IImGM5j8QdN8MKu8Vx8Botxw1vzHhvQnZh+qBI7WGHhS7lVxzjmWhQ4RbQf87vdpex8JTgd3XFNBxPpbsu0eWrxGUwVmKn9mbexQH6JdGWJRCwBQW70OvRjEPXSTZYPlwXqCVVc2VjF+YkqYDOkvjmoUadN7/YxrBjeXZKvRvr0lBCptLbInnRRokGsLoxXc3hn7P0zcViF6pZz4zIr2wNKI5gaEnTp0LY73cGjX1Rme20+X9PfE1W4QzVphfin5oloOe6KgLj7cFNfjqY3cGdr98HlQ0guuQSSAtNf43qq5WOKstCuHTd3dILa2jwaQYqGLVSRDPWUL1psz58BNm4Q1ioywts=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94232ab-9f52-4157-ddf2-08dc1381bf6e
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 15:18:36.4440 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZPdwjttxCM5yFCYn/SLJx2wBC9bw3Vv+iHdIupMsI/k2k0lJHwQpaCNiLtbnT/QYsJHbuYCCfalAtwcg/+LI+ko27mAdlEedbBZivz2F3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-12_07,2024-01-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401120120
X-Proofpoint-ORIG-GUID: no--eLf68pqjWMB4N4ZSAI72UG7ISERL
X-Proofpoint-GUID: no--eLf68pqjWMB4N4ZSAI72UG7ISERL
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/12/2024 10:05 AM, Steve Sistare wrote:
> Passing MigrationState to notifiers is unsound because they could access
> unstable migration state internals or even modify the state.  Instead, pass
> the minimal info needed in a new MigrationEvent struct, which could be
> extended in the future if needed.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  [...]
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index dcc98bb..0b4ce0f 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -60,6 +60,11 @@ void migration_object_init(void);
>  void migration_shutdown(void);
>  bool migration_is_idle(void);
>  bool migration_is_active(MigrationState *);
> +
> +typedef struct MigrationEvent {
> +    MigrationStatus state;
> +} MigrationEvent;

Hi Peter, I chose to pass MigrationStatus rather than define a new enum and map
MigrationStatus to it.  IMO a new enum adds little value, yet it is more code and
another layer of abstraction for coders to grok.  

- Steve

