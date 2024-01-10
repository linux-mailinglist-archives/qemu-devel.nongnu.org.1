Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FE282A018
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 19:09:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNczy-0006rw-3Z; Wed, 10 Jan 2024 13:08:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rNczw-0006rR-DZ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:08:16 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rNczu-0007aC-Dk
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 13:08:16 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 40AHke7f006344; Wed, 10 Jan 2024 18:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=kgbkHB8aeqCdHSE2mSxSMQyTDCkSdSqjcyohcmxeJGw=;
 b=EPzmJWVbHKqe83X/sPDFZy5GxVew1/1tSrSn3/dL/5rOgU2Veu/mLAtj9m3rHXAheSnK
 a2oeqgGcDgkhGeVAGpxOj/VXWSqn0v5gQ6OhwN2jq4fZWM4BeMtrJYMWAXUunuqn6b8C
 Z48mVAj5LoTVPNiQZ0EVVligIyJusBEYpxfS9wiEYpd1t2uIjSZRFz1cM2NR67z4/AZT
 eFM+blefbvDIYc/UyUwWe12aHsu6SpmZoGrpktiraYZRlx5M35igqM+2kffbmO7cO75L
 4jerlg5GUXog6BF201BCyWJRm1LzfTKdfSeBxUktoP2n9RySL25IN2lG89+l4sPuPhny DQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vhxrsr8ha-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 18:08:09 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 40AHRxuN006709; Wed, 10 Jan 2024 18:08:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3vfur5s000-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jan 2024 18:08:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O415J25qdSQi83QJVcCDwcbxtKt6vT9qllvTjxcikp68QxHKHHf/FCQrFkqKu9S4bxgQMke8qKTun+lAXuexIcbO8tknVdWfk3SD0SSQm6s97ET9E3aMRrB1mugL5z9KdNqlCFUrtC43WI2ghcACvz70jriz+99qDCur89ELWXZlrx40X9H2aK1gP/77mT+rfyXZpmjgmJHi/mNODftzhPkEyqiuzUxUlqyW6B3s+wzvq+zqIU0Omfao/7P9Ts6o/GVAbRH04U53+/RqL/Qo7AWueY31gt4E/L3wtx3wLSENsJ6ff0FinY6R8P3hutJ5SjV0NlPf4IpgIzHXxgnAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgbkHB8aeqCdHSE2mSxSMQyTDCkSdSqjcyohcmxeJGw=;
 b=OgSJGtWNUawMWlVL4e76tpJ2muYf38qcAvpXg6rbCA75vmK75KW3sXgben9Ka6/I028Damu5vD4gl7PZa4cfevLlj5La1vCjnUesT2XeEr1W+hDtnx9tlslqhe8pNJMx5vQn1ydhKr9E2rBi6Jlh3Up12AgJ3+g6AG5CiWO2dJq4ckVkM5oS2lxrBYo5pjIiUA/YXLfMsz2apvSKzXztATMemoTSLcnKW0ZvDecHuc6TTBF6gVdG2WY0zk7Gu+0gG9QKAVk2ZO1P88pWJPSDyOgFFX6VhjigPiq1bQUFlOxmQ6Ovung7vUV9UdUbD/UG0yatr4XmiD7wEibzf4RZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgbkHB8aeqCdHSE2mSxSMQyTDCkSdSqjcyohcmxeJGw=;
 b=wfNM3MHJys7sXK+uMNGH6s7FUvDolAy3pTh3LUVwIc1tqbMTu88VA+ChIMypsJgllD+IyD6XevPUF3tiZlr75aEXAcvZX7BqTTpgQ3XuK1OeJ3cXPqtgPug08bZEO28x6awezTgkjBbgpk8axaDG7De3v5HE4kXrNcjQzZbgLGo=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA1PR10MB6217.namprd10.prod.outlook.com (2603:10b6:208:3a6::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 18:08:06 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::c3ce:7c28:7db1:656b%6]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 18:08:06 +0000
Message-ID: <a929ea94-1c43-4153-add6-b351e3d79d18@oracle.com>
Date: Wed, 10 Jan 2024 13:08:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/3] migration: check mode in notifiers
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
References: <1702491093-383782-1-git-send-email-steven.sistare@oracle.com>
 <1702491093-383782-2-git-send-email-steven.sistare@oracle.com>
 <ZZ5CkQOhau48sqjn@x1n>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZZ5CkQOhau48sqjn@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0048.namprd02.prod.outlook.com
 (2603:10b6:a03:54::25) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA1PR10MB6217:EE_
X-MS-Office365-Filtering-Correlation-Id: a313a3f1-e542-462f-618e-08dc12071866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9USgQprXQZCSpGXu92IxuuJqhPmvfgYgToUcj09rIMBJEGW2ywVavNhm1K0bc8V/DCVEXHKsJ6t+NJXZUXxA5Qo/DldlGxSeOsPGEPWQDOyuIr6eWwyUmg7BhPwstYTV4AIqou2483T1cUFJSz7WGVdJ9qiVijmZ/u0IB16PIx5iAf7m5KOMYt2uOGicACT6mkedv8/BLGCXRj1Yi8zEmyJARK8bz1ReOUUMfnwF7T+zv+gY5ojFcqDicq3ZIbYumyM6CNdWT5NNlPdWh03VG4NVGT96YSBqcYJlqiIuU1HTlrBWF0+jIQPbkMGuVb/RmUpDz/B4kwumQACjRcIp+k9sox+6mnjeYJ2jwmgUW6/ombZ1+LWQ+c6/4TEUjd1g1d5iJTZBi9q9/Si3tOuNkugO/63SjpLkAAeU913C6V1MkKj43Ub0+CzX7FQtVXvOohaQMqKQyYIrZ3z/eMZiLLux0wj8gmO0+I7McModlMEb0zFA3pAwiUA0Lr/Hi69UJzkhe3RiYf5yJjQY9nKfuVffamgK2TbBTEmbbod4K9db2f0cQ+EUDoxSgVal0od4M7jjdIQNpOkIrPaVC2n4ITo2akilFiSexIkMefKefrqP0Be0WOaYv99wjDpgWDWz+pA5nZ4GhYWDvEfMZdvAMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(2906002)(7416002)(5660300002)(6666004)(478600001)(4326008)(44832011)(38100700002)(66946007)(316002)(66476007)(66556008)(54906003)(6916009)(36756003)(41300700001)(6512007)(31696002)(6486002)(8676002)(36916002)(6506007)(53546011)(2616005)(86362001)(26005)(8936002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDlMN1EvK1ZoNitQWkd5VDcrZkpmUk4rY0VSSHBXQzhXb3lDN2xpRFVMNEdx?=
 =?utf-8?B?c3BNUW5qT3I0K01kMEJLZllhaGJkU3FsNzR6UXZJRG9KWlB4SnkxYVJyNyto?=
 =?utf-8?B?VDVBUFh2aUkxUm9BV2FGak00RENyR2F1d2hhd2VXMnF4TkNsZHlnQ2JCeUJp?=
 =?utf-8?B?ZTRsaTN0LzB5Sk54bVFydGlyTTdnSndnUWJERk9FeDEvb0FMVW5IMG00WkdY?=
 =?utf-8?B?UnhTdHZTL0E4T2RTTFV2ZldCYjd6MnRJT0lCd2tFRHZvdCtUd2VUZWlxZkJh?=
 =?utf-8?B?anJlbkQ5TWhnL3graUozbURmR2tUK0F4TGYyTGNqK25VQUk3aXBPMTdaY3pn?=
 =?utf-8?B?TVRpbitLRFZVcHBQMUtidHBPN2liMk9laHJ5UE1ITmRuTGNULzlkeU5tc3Ri?=
 =?utf-8?B?K1F3NFZ6L0FKY3hic2tmblpNRVJNcS9tZ0FjWUZiVk5sRUFYYnBYb3RDMncz?=
 =?utf-8?B?cFRqT2t2UnJjYVFDalkrRnBCWXMwNHFJVVdRTzNRNlJVOTlDS09aUlZuN2Nm?=
 =?utf-8?B?ayt6eXN6VVFhOFZtemFYek5qZWxlWXdINTBTUmU3VS91VjlKanBRbWE3Vk9S?=
 =?utf-8?B?UEdnR1FpdU01dzB1WWhSZkpaVnJCYzBvWmNnZzBod2l4NG5nbTFjc08rdFFm?=
 =?utf-8?B?N0NqM25sUUhMVkJ6YU5OMy9Ha2tNSVhtVG9nSlRPcGJEVVlBNjNaN2NPazQy?=
 =?utf-8?B?K2RlamppSnN6UGdCYWpCNUQ2RjVpditDQjlpcjNVOUR4TFlMcHlVMDlUYko0?=
 =?utf-8?B?TEVEaEd0TFdFRGUzSlVQRFlaRHljVFdWcWNQQ0pDOW0yRnVqeTVaaFVUZzNh?=
 =?utf-8?B?YnF6bXJRWSthWGUwSzN3TXQyYUxxaW9VdDk0UWdLUm84OFlzcUh0aVpIVkhm?=
 =?utf-8?B?eXMwa053dDBFQUx6RnVaekFXeUttUWQ0ci8zdDR0cElTYlZlN1I4S2VCSmJJ?=
 =?utf-8?B?SE16THNkOEkvZU5yMkpZYzhyaTlVYmowV1JSNGd6a1MzOVViNEJFb1ZuZlZ5?=
 =?utf-8?B?ajJCMVBBY3RNaTA3RmZGUmw5MXZ2elREWXQ0Qm5QZTBubmVmOVN0aTFWZ294?=
 =?utf-8?B?MUttdVRPTWpWR29pUVI0bjdwVUdwYTdZL1lFVytGM253Zk9UeU9kK3NPbXZt?=
 =?utf-8?B?Y1MvbHJlMDdmWU5EdmdSeURPeUx6N1Vzb09ySWxmbGYyNHJEeFVtMkxoUjNu?=
 =?utf-8?B?R29hY3YrTEkzaDVHZGM1Z291NXI5dHdmUnBZdCtoQ1JjVjhJWmRSTEU3bUZ3?=
 =?utf-8?B?UnZyNW8zUmJOYWlHTjZyd0ZOSWJCZDFvZElDbmJzaDliNGtGV0p5K0RULzJk?=
 =?utf-8?B?ZnBlQWJwVit2aXA0ZVVMamxKUUJOV016YzduMUZPZHIybjF2MnQvcDhNZ0FX?=
 =?utf-8?B?RndzQlY1VjRPQ3l3Z2lrR0lZK2orQkpOTnRGQWZLMU8rd3hPb2EvZnpDMmhU?=
 =?utf-8?B?cXNZTjJ6am1KQ3dma2YyZ25pbVQ1emVRUURvbjM5NFZWWk9KVU5Vd0pUc1Nz?=
 =?utf-8?B?VjhKazZLenJ4ZVVJZjFwNG95dnlDZXludDdXZDN2SmdzQ3ZlK1NKTVY1WlMw?=
 =?utf-8?B?c3NvQmxKMlJtcTFKUGJOOW44U1hGZ0FDMm9NVmJ1MTZteHVpTmlDS1VsK25W?=
 =?utf-8?B?eklsOXZIdlg2aERKSldKLzRuVVFpdTU0MkVhMHlCbDU1SDFjMkdtMmRqMWZZ?=
 =?utf-8?B?RHZtenpGVGVvUmlvQUpqT2Evb0tUU05ZM01BOEdJenEvdFRpUEhJQkIwQ25O?=
 =?utf-8?B?dHZaZk9yRW10ZGJiSFpXWm40eHRETEEwWi9Sa0R4aVlZYlZjOXYyQ3FtcXpi?=
 =?utf-8?B?U2k4MHFRM0dVdkltYk10bjFoK2t3ODBZRUYxOTZQSWh4WUUvdCtVZ2JrYXoy?=
 =?utf-8?B?djlCQmlISHozaGx4Vk1vR1NsbXBlRkZMeElrWEh1RGQrMVpYc0JBZzhpSE1L?=
 =?utf-8?B?ZFZxQ3U2ZHFGRE9DbGZ2dWZQMkl2Qm9vQ0tHTGppZHlwNUh4bDRyUzNvN0R1?=
 =?utf-8?B?ZzFuQVRjTVJpU2JhUnJqcnBURVJhWTVCdG9nUlJGZXRwZmdqWGdJQVg5bHV0?=
 =?utf-8?B?TTRpV3l1Sm5Ya2ZtUi9wR2V3c25zdVhwbTBJc0lDUFRFYTBFQktsb3JqaGZt?=
 =?utf-8?B?YVNhdzRJUTdnSjFFTk5qaUNQcGNRWGxtOFlaWXJhczBJWHUxUm5hcDVHaTVB?=
 =?utf-8?B?Zmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E0yvuqdRJzNzeYula8fBf4z4Kr8z2Puy0glRkKVMc9A0f3wiWIPBjR25V7UzTvGicb31qDG9B51LvsZM71TIT7k192j+icTMMAshG7Qq7rW7YqdnDeG+UghNLO0um5bkVcmsL3+IIYV7qsLto5NcmunZUqJKQ0kO22obexjXheG3/czl0n4FVXl2bH0yC/X5qJQY8WdKts4b0qczX7p2yTgGENpByD+aaBFELaA0GR7s8mrxQ8AwHXrr+yACCOg+zVUAbIj0OmWUKy7/qp7nL9EIcdgTjh2UE0yJdTkWqM0Vu/aQ9S6LDXlgLGpnrR2F5HW05q3hMxWswCmujedtEeR1vGxQLRBPoPVYXp2nh38fTxB194CRFWPvoV6lIr4b/BIFj8fk9eyUWbYUwe3XyqXVuHpX+qNYII36NJWnP2HwPExdvYSAlDpHkdFcen4CEnEeKftDKK0f5bZeMARtvLoGBFmAEC215LCLb06CwKzBusoPpavju94dFiBqtl5vJgMx3AKC7TFTGNzymvRuwLhzDXhC9YowW66bwLHcJKfla1LH3olIhnBgHvmD9QwXMGoDk1tYiFCDSH+VgzYXUJBoF765BGrnxq7mBSfvdHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a313a3f1-e542-462f-618e-08dc12071866
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 18:08:06.4577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4cH8zaRS0lBbTvOGujHEGgtpxFk4Q6fWhKBFV8+5WhVYZ2M8H4vbpUwHEtPhC0EI5r9WrsescidyMGT/xFt0BBvKeCGLwwIBfwFEazEsos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6217
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-10_08,2024-01-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=827 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401100144
X-Proofpoint-GUID: QKzAOKHX7TvsTq5a9awzj0bQod9sms-i
X-Proofpoint-ORIG-GUID: QKzAOKHX7TvsTq5a9awzj0bQod9sms-i
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

On 1/10/2024 2:09 AM, Peter Xu wrote:
> On Wed, Dec 13, 2023 at 10:11:31AM -0800, Steve Sistare wrote:
>> The existing notifiers should only apply to normal mode.
>>
>> No functional change.
> 
> Instead of adding such check in every notifier, why not make CPR a separate
> list of notifiers?  Just like the blocker lists.

Sure.   I proposed minimal changes in this current series, but extending the 
api to take migration mode would be nicer.

> Aside of this patch, I just started to look at this "notifier" code, I
> really don't think we should pass in MigrationState* into the notifiers.
> IIUC we only need the "state" as an enum.  Then with two separate
> registers, the device code knows the migration mode.
> 
> What do you think?

If we pass state, the notifier must either compare to enum values such as
MIGRATION_STATUS_COMPLETED instead of calling migration_has_finished(s), or
we must define new accessors such as migration_state_is_finished(state).

IMO passing MigrationState is the best approach.
MigrationState is an incomplete type in most notifiers, and the client can
pass it to a limited set of accessors to get more information -- exactly what 
we want to hide migration internals.  However, we could further limit the
allowed accessors, eg move these to a new file "include/migration/notifier.h".

----------------------------------------
#include "qemu/notify.h"
void migration_add_notifier(Notifier *notify,
                            void (*func)(Notifier *notifier, void *data));
void migration_remove_notifier(Notifier *notify);
bool migration_is_active(MigrationState *);
bool migration_in_setup(MigrationState *);
bool migration_has_finished(MigrationState *);
bool migration_has_failed(MigrationState *);
-----------------------------------------------

- Steve

