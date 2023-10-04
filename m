Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502DF7B7EE0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0mw-0003Ws-6o; Wed, 04 Oct 2023 08:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qo0mm-0003Vg-RP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:15:29 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tejus.gk@nutanix.com>)
 id 1qo0mk-0007J0-Dr
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:15:28 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 393N0NEh006369; Wed, 4 Oct 2023 05:15:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:from:subject:to:cc:references:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=v1xQuXJ4E0wpmAGjx2pMakvzqBW4dq1fv9oTO+5hz
 kM=; b=CIPH+Jf35R3aHMBR2F7WnLGSq16qgk/EW/EJ9D9S3w4YTkDoBM52ccBYJ
 IuWue1dmN4Zp2ZrLG8AiMgrFXbe6U1zDDi12wPLhn9s8UaxSh3Lk1CXZCBqRXFSD
 TRG5wFLNNNW7wDjSI/nSqCqKY/kNMub4tCMamouUXxvqlBHhuZKqRnW8vRkHGyxd
 aIZ02kzdZsmPzr95jduYmiFZAzI3eMK5cpKJol+dj3YgB6AGDBc7JnIl5Cf1FH3p
 adP2toVEcDkSJrGjaAiLYpyPzYhye5dtDcqck1rq3UK53vjfYeoVaB0Xzg/d6OHW
 4jVhDp2FZlliq4risGohY+TapMz1A==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tefk6f5m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Oct 2023 05:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IprTBlegGmFlH+A54zZOKkzNXjcvmBgIJ70uSUPykIM82tp7PcXur8OoABfkEmHYClrk4pjEvMDz9tD5oc/xdGanNUbH7WQ9JSfkHgM0ENxXPRRi+g5BR51xu7P4KuVn6m3TQUN6Kzv1gCG+0qHYel0lIHKvp8r1nqQfE0ZHqW6pxKSaDG0GtXnQcI3gykyezS4EWqvO4P3EC9AYHVfhsedy3ov8Q0vjlVQM9MdjhYKUpc7NULMuSpLA8067/sqWrPLgnQ4+uWr4fyesmXMg7AyILKOK5yN2pXHk2NYfi5xGPaI5vTD4ETDAhLTKsi7HGJl+xVuDlIZEg9MnHdeASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1xQuXJ4E0wpmAGjx2pMakvzqBW4dq1fv9oTO+5hzkM=;
 b=cGsEk4Ch9RLEN5YZUx4tOOGu9JNDNJDbfsOztxSjlmuUJvWVQlAAFYhYn0wt3FwVmGJUC+ieYrChfDXhBHzyUXoQ9Ey784taG0ZlwZZAYOuJuUU49a1u+JirKHBFZwZa/RZvryrTaw48bsU17sCeban2CbivgyqGAyNlX6kbLY7JKtXuPfCtqDJDlKay8zLQre3WoZBNTd+3cGBIswEvqSbjs390WtGWKKnjufxk0SpPkmBGvsR3ssRaLAZjxsEYZ8c1pqpEa271tFsX6VUFni7aA2WUDS1pg91FvxjJnJwL+ecQ0n2EDLHpdMd+9wjWrWzHQNlXTIEbA887iJQ3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1xQuXJ4E0wpmAGjx2pMakvzqBW4dq1fv9oTO+5hzkM=;
 b=XWz3dIXsqPNJxQcVx+kX6xSmRJVWfeJl7ZLFzf/Gz6wd/HVge6x2cz/qy7gLYGmqj7Z3NyBIxU+Sky2MQ6TrCDMsoN7Qa76alEL60htu//0xW8JmXpmQY2DZqXT3C1jWaPLsDoWJmzhpuT2YsZUPGWsC76sD0sy4wNStolBjGNIVDMTWlmHMt2aMaqqX1Ujz10lPxbTqexP8My3cA8lGYGxxtATnqm1duHOWNvMtsD+jQ0BaBXSYE6zgi+JjIcm3gpVlork+E+g6REWrzhJxdnsOCpIxe048e4e5CuQrQHKt9fOPvYfRvWp/iXuZQsVzjOZwY8rtnNjHxHRDOPx1Yg==
Received: from BYAPR02MB4806.namprd02.prod.outlook.com (2603:10b6:a03:42::30)
 by CY8PR02MB9568.namprd02.prod.outlook.com (2603:10b6:930:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Wed, 4 Oct
 2023 12:15:17 +0000
Received: from BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77]) by BYAPR02MB4806.namprd02.prod.outlook.com
 ([fe80::4d3b:ac91:5aa8:d77%4]) with mapi id 15.20.6838.016; Wed, 4 Oct 2023
 12:15:16 +0000
Message-ID: <68db0be7-694a-44da-8513-e761109d5902@nutanix.com>
Date: Wed, 4 Oct 2023 17:45:06 +0530
User-Agent: Mozilla Thunderbird
From: Tejus GK <tejus.gk@nutanix.com>
Subject: Re: [PATCH v5 2/2] migration: Update error description outside
 migration.c
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peterx@redhat.com, leobras@redhat.com,
 farosas@suse.de
References: <20231003065538.244752-1-tejus.gk@nutanix.com>
 <20231003065538.244752-3-tejus.gk@nutanix.com> <874jj77u4a.fsf@secure.mitica>
 <c281b1e9-a027-4871-a1d5-7fc10f4ba1ed@nutanix.com>
 <871qea6bk1.fsf@secure.mitica>
Content-Language: en-US
In-Reply-To: <871qea6bk1.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::15) To BYAPR02MB4806.namprd02.prod.outlook.com
 (2603:10b6:a03:42::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4806:EE_|CY8PR02MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: c7614367-0274-4fc0-182e-08dbc4d3918a
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdviHviyDCQMFL/ZfXcgucVvqnjna36MyXnd9dcJtakKHmK0937lH+g+SzrdRt1cANLMjAXQTW3c7WByUc3rK9ngz0bBMu7WjbM+lRnPsKkAhW6MJklJAkbrD9rqQurc06kRB2DVJmtzMV37WwUMGj1OwTNGqJXLO6QVeZq6cX1MXzhpYD4KvXlDQPwxWHOTN5XpCZvkbnqoKCVRhomIKzKGgaXquidLxf+ZtwDfPDmKnr9ZtbiX3vsek3ltJAC7oUxmsdIiGe9kvjsDqk0jRPCdDeS++ZoG+ltlYj1hgZhsBjiCdPdMifmowXz+zq02PT5IzILq61hJREzNDdtqIH/kvWKae/jza4pxjDAj17MMT6ug//NHp1FRxDhugJ1kA1zY97bgoZwXPLl9iu/bruj6yPgCDf6KNFwJR/40tbnefC/tzz8qFDOKM8darhIup7Z4xOcshLuOj0jQspUQwf9HrwOLn2BELToIsJ+0RsrkW183d1lio1j/HWqBRJnx5G2mXsLCcw1VdY5SAiAjbkOYVZAGPTR8N/i/YqU6SKVgUuzXqshUbcOkYIbLQqQQC7bxm2LJ22zm9S1I+WK7DN38hteWjOWWYO+wEaGGT6H/+Aa11LDz3qI6jTMzFkRsS9Oje9qoezjaqvHwo0J7U6QaRSbMNJ2TB0Dw0Oer7Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4806.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(31686004)(15650500001)(5660300002)(8936002)(2906002)(4326008)(8676002)(41300700001)(2616005)(316002)(6916009)(66946007)(66556008)(66476007)(26005)(6666004)(6506007)(36756003)(53546011)(52116002)(6512007)(83380400001)(31696002)(86362001)(38100700002)(478600001)(966005)(6486002)(38350700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0xHYkN1ZXRmbDh5U3d4Ykhkb3BreTJLUDlRRE5ha1dnL3pFNVZ3WlRDVVFV?=
 =?utf-8?B?QWt1dUU0UEd1OURKdjYzbENOSEVKSWxnK2ZQeEhXcjlFYXAwcmk0c0MrajJo?=
 =?utf-8?B?U3JMTk1GVDVha1NhYmNtb1gwT0NjcUM1SUFmQ0VwMkp1bHVIZ3UxYzZHT1Jm?=
 =?utf-8?B?S0ZuL1JvUkp2dVhJWVk1ZUhSaE5DcElDYkRjOVE2cVNWWVRmSnkrdFMyVExQ?=
 =?utf-8?B?UGRxaXdmeUdZS29xdWRhajlGZitzMzVzZWp2UWJLVDVYYW1Vc1VvR0ZpbTJB?=
 =?utf-8?B?RG0yVUo1UG13aTcySGRIbUFqU0tPSGpzWEhBSVpUZkY2T0kzN05BVm4xeEp1?=
 =?utf-8?B?WVozb2dOYWhURWhiYXdZalp0WTFIdHYxQzQyTHJZTDdFOVNVT2kvekNhWGVR?=
 =?utf-8?B?VmNTcm9kSm95RHFhU3oyZUZ4ZEY4WHY0UVlKeHJsbnl3NHZ6bkJFQUNTcW13?=
 =?utf-8?B?V0Fxb2hTajBzYjRKWlZoa1pXWDBnbEh2d1FmVWtuaDhTWUxVT1hCUGVkZXZU?=
 =?utf-8?B?bVVDL25hNVRLNmU0WnArbjYxdHhuNXNvK1VDT1VvQjhuMzk3NUU2bWl3UFFl?=
 =?utf-8?B?ZE5WQkJqUExsRk5LbWJiTGxmdWFIbWkxNWxGWkxOM3N3bXFEb2N5NVYrekxY?=
 =?utf-8?B?ajVuMmM1cGc1dnEzZHZpYkpTYTYvbFhQTG9WZ3VaYXp5dVBSMi85ay85c1RQ?=
 =?utf-8?B?U0RpMHR1ZENrSXFYMXoxczNkZHArWUdBUU05ZVhxZm02UnJpc21hVVBTVDFH?=
 =?utf-8?B?NGNTMnA3L1FvQ0puNC8xQ2lsRlJoS3RISllNbkJEYVJNaFNIcDZMNXZibldM?=
 =?utf-8?B?Tll4SzdMNk8ySGtxaTlEU21NRytXV2R2ZXdhMnZRY0dYcjBWcHlTUmN2czhp?=
 =?utf-8?B?bDRZK1ZmRWYvektpRkJQRGtvR1pla3ZKVEtqUytTbi9Id3RHQzlSVjRQQjdL?=
 =?utf-8?B?NWxSQU12aXduQTVodndQSkZPMGgveVU0emdqVGxRbjJhaHdlMGoxclpheFUw?=
 =?utf-8?B?R3BnamFYa1BNZWtWdVRKTzJrS2pwZWdPUlg1aFJZNWR4YlFsZXJmZllXS0JJ?=
 =?utf-8?B?SW90K25aa1BEa3BhSjQ1K3BmOW5CUTcyeVBlN3lPbkZmMTNxTlQrMS9kQ0dH?=
 =?utf-8?B?N3lvMG9jKzlDZ251MFpRTkgrdVNUTU9SN2xodUJXbW1FK0phWjc1eDBSYjJ0?=
 =?utf-8?B?UytkeDlDTEJmOENZdUxmWU1DYnVOZ3hvdjBaSVE4YnZYUS9ZLzhpVTVGS1Rv?=
 =?utf-8?B?QkZ0L0VuM0xQQXFRNnFMTy9jS0lsb3hXR20xNHM1c3FQRGd3d2FRZlZBN1pP?=
 =?utf-8?B?ZzVlbWk5eXRORFZXUjdWUzNzRk03YTR0TWx1TXh1U2gxZmQrUTAzYWlEcUwy?=
 =?utf-8?B?bnQ2cURDYWllRCtJMWVFU2Y2LzRuUCtpS3lzNmZBc1NWMURDMGVNL1ZwS21B?=
 =?utf-8?B?ajJZcTFtQlpmZ2VCK3RyajBPVEppSUhzRzJuSE1CSmhKUFN3a0JmYWlIVWdE?=
 =?utf-8?B?WXJtTXM4WWVDamNGSVp6YnlaMjhVYXU0bVNMSW1mZ3ZZZ0d2ZzZabUNWb29I?=
 =?utf-8?B?N2F6eHhwZU1TUlBnL1pKcGpSdEswWWNOM1NBbGJ2OFVkelE1ZkVRb3R5Y3hH?=
 =?utf-8?B?MjVqLzFlSGF1ekM3a2RLK2FNY0hHaFhreG9pWHEwRHdUMkNnQXFZOTBadXBB?=
 =?utf-8?B?dVR1azNYQ3JwZmZlOUxkN1NFb3BRT24xS2gyOTY3OFIvcnBwTXBDcWhIWWRD?=
 =?utf-8?B?WHk5YjVNbjd0MHR1RTlXRVJ1NVFDc2RiK3cvVko3dFhnSjlIKzFUWkxzSFor?=
 =?utf-8?B?U05ZOWRBTEIvYnB6aThNU0hjVE9yUUNkOXhMZDA0VWRDUzAraUVjTzJzN29K?=
 =?utf-8?B?UHlXS2xFRFNwM2cyMmxxN2RXaEdUTkdtdlNUN2hGSSs0cER1cW1JT0IwRm5x?=
 =?utf-8?B?SDRNK1RuSC85N3hNaXRKZXZCMVlXY09ZaC9WLzRXQm13MTlCQVZQcWdiNk4w?=
 =?utf-8?B?NmZCRytPSDk0Q1dOL0E5RkNqNjZkZ1ZXTU1VbmhIU0hDbzlSQmtuZyszZCtx?=
 =?utf-8?B?MkV6ZlZJVXZoTFNEQTNYMksyS0ZudDZUU3BzcGI0Sm42S0IvTW9rOXFPbnN6?=
 =?utf-8?Q?f7DGleNh0YgqDSQFgKk7I4eq5?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7614367-0274-4fc0-182e-08dbc4d3918a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4806.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 12:15:16.5936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SgI4jJgxEU8OFKS6oBHO8JYRjzuTFOWGro8Hs8NUi7GUhIBYrtQD9pjRZllli22s3QMr/G7aW17qCHggBasAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR02MB9568
X-Proofpoint-GUID: 46fvsHeHR4cM2FUhrNHKCT3o2kPZURhs
X-Proofpoint-ORIG-GUID: 46fvsHeHR4cM2FUhrNHKCT3o2kPZURhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=tejus.gk@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 04/10/23 1:53 pm, Juan Quintela wrote:
> Tejus GK <tejus.gk@nutanix.com> wrote:
>> On 03/10/23 6:14 pm, Juan Quintela wrote:
>>> Tejus GK <tejus.gk@nutanix.com> wrote:
>>>> A few code paths exist in the source code,where a migration is
>>>> marked as failed via MIGRATION_STATUS_FAILED, but the failure happens
>>>> outside	of migration.c
>>>>
>>>> In such	cases, an error_report() call is made, however the current
>>>> MigrationState is never	updated	with the error description, and	hence
>>>> clients	like libvirt never know	the actual reason for the failure.
>>>>
>>>> This patch covers such cases outside of	migration.c and	updates	the
>>>> error description at the appropriate places.
>>>>
>>>> Acked-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Tejus GK <tejus.gk@nutanix.com>
>>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>> Queued.
>> Thanks, will be sending out a patch with the "Reviewed by" trailer added.
> 
> Send the other one.  This one is already queued.
> 
> I think that the error_report() thing, you need to review more things
> than the one in this patch.

Not sure what you mean here? The only other patch I have on the list 
apart from this one is 
https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg00280.html , 
which you marked as reviewed as well.
> 
>>>
>>>>                return ret;
>>>>            }
>>>>        }
>>>> @@ -389,8 +390,8 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>>>                                         vmdesc_loop);
>>>>                    }
>>>>                    if (ret) {
>>>> -                    error_report("Save of field %s/%s failed",
>>>> -                                 vmsd->name, field->name);
>>>> +                    error_setg(errp, "Save of field %s/%s failed",
>>>> +                                vmsd->name, field->name);
>>> Same here.
>> You're right, I'm only setting it here and reporting it eventually in
>> savevm.c. The trivial solution for this would have been directly doing
>> a migrate_set_error() here, but that ended up breaking the build for
>> the unit test test-vmstate.c
> 
> What was the error?  Because the problem could be on the test.
This is what I keep getting.

FAILED: tests/unit/test-vmstate
cc -m64 -mcx16  -o tests/unit/test-vmstate 
tests/unit/test-vmstate.p/test-vmstate.c.o -Wl,--as-needed 
-Wl,--no-undefined -pie -Wl,--whole-archive -Wl,--start-group 
libevent-loop-base.a libqom.fa libio.fa libcrypto.fa libauthz.fa 
-Wl,--no-whole-archive -fstack-protector-strong -Wl,-z,relro -Wl,-z,now 
-Wl,--warn-common libqemuutil.a 
subprojects/libvhost-user/libvhost-user-glib.a 
subprojects/libvhost-user/libvhost-user.a libmigration.fa libqom.fa 
libio.fa libcrypto.fa libauthz.fa /usr/lib64/libz.so 
/usr/lib64/libgio-2.0.so /usr/lib64/libgobject-2.0.so 
/usr/lib64/libglib-2.0.so /usr/lib64/libgmodule-2.0.so -pthread -lm 
/usr/lib64/libpixman-1.so -Wl,--end-group
libmigration.fa.p/migration_vmstate.c.o: In function `vmstate_save_state_v':
/rpmbuild/SOURCES/qemu/build/../migration/vmstate.c:333: undefined 
reference to `migrate_get_current'
/rpmbuild/SOURCES/qemu/build/../migration/vmstate.c:344: undefined 
reference to `migrate_set_error'
collect2: error: ld returned 1 exit status

I tried to figure out how the dependencies work out for unit test, but 
found no luck with that.
> 
>>>
>>>>                        if (vmsd->post_save) {
>>>>                            vmsd->post_save(opaque);
>>>>                        }
>>> So, I am wondering if it could be better to just report the error in
>>> a
>>> single place for migration, and set it whenever we need it?
>> Yes, that would be very convenient, for all the errors to be reported
>> in lets say migration.c. Though that'd also require all the subsystems
>> under migration.c to properly propagate the errors.
> 
> Yeap, it requires auditing all the entry points, but will make easier to
> know when we just need to set the error, the system will do the rest.
> 
> Thanks, Juan.
> 

regards,
tejus


