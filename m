Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0597BC91F
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 18:58:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpAbd-00047F-Pt; Sat, 07 Oct 2023 12:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpAbc-00046p-0V
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 12:56:44 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qpAbZ-0002xR-QX
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 12:56:43 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 397DZDWa010284; Sat, 7 Oct 2023 09:56:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=MS7Im6ERiVup
 26VuzaKDSaGAK2L5FthrE0IeYtBDXd0=; b=nwsiDk0N+CMDFOkEvkg0wS4BrqI6
 ThBM9SMnXeTKQKPgkxJbQOsI5t/U57S9A574qjINaFRsMdN3GNCXc12JnbPL44ew
 wMiCKuV9iTBb4sykSVRF+V/fI0xh+SdE3PM3g9ipaekXsSWb3+qXFfCcHIbv1FzX
 rfggoyx93ItRE6ge//mHiQsDq6YwACemZQ3uTrAEudb5wumtTlb5rkH0TiPGGqb/
 eBAaXGjReIu8I92ZOxRni5SM6zoYObLrJuE+ICHhCWOw0wr5WIftYgOsJ/ln2C3f
 SqP7KcnnY/VwXTUI2ZIVZEOSqKLGKmJ46ZrER1I///069Hy+yWhEFzorPw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3tk6uxrang-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 07 Oct 2023 09:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq1mHw35/45P7AhpYbHd8wTT+vV1acc/iVjT9n2cgYmS/+xu1tHqdZbjVuLoG3CbArzuKBw9KxOAqBFn41X4EwjdN84206pZ+ZkM0c6TPt2a/K5ZF5dmUxWHJHmBn9EVP26sEBtltbkn+VhqYrX1eUSdV+G5Cnoe3ioEdauGMQ159vPNA4mhO+OxajMGr59Qp84+j9VD7yZZ1Wg2LnpOuGc/K8o1NiGtGpdaP4TwqdAsR8bowDqtVfWeTP9otxAvd+SPYHr7q/BP50gWww2G7dDehdcaYHI+kbVzAmmSDXlQnV7ZelhEmFMnB04Ww/K8adFdB37pBKFudcnMniifCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS7Im6ERiVup26VuzaKDSaGAK2L5FthrE0IeYtBDXd0=;
 b=Qzw0iSKfKSOTIu25GypLRVDiMmQ6705xP7bhHWzxdzQlzJbawB5G9zjiIyLjFRc16oO44jQ4M7uHkQXTNxzs1o/AcCJYkOvRyJ/7PEhD1HdegUXZV1gw9qatikoJAyBI4g1YGaUfXXDy9CDAh0by5Gz3xmFhv8h0nTK3QICd7PBocaYTS2dcoIvxYL2TX3B2ne5BmAJx10YWnX7PZe7e6nR07xEK5tRVFQUqHkG8yMnu5Cdrp3JPSPGZ9u0XUqSmen646uKSLEkvFPLp9ZRMgFvkq75LqigKoLByjqYn5ylR6TOfJrdvhmH/nxJx5KURgHqKowfv/gMim2lKZqdtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS7Im6ERiVup26VuzaKDSaGAK2L5FthrE0IeYtBDXd0=;
 b=PSsR06zulVxD8H8sctAXAI24g0n5KHUKSfZrMMLjbehv/2KlhuKDx/oVaiKQU/SY7tBdoE3ueLkd6OIipTwFboxRviXQl8I0hsj5cE64ktbTxLpmM72zpLEO23AjS/JjI2crLWauJJ+FWYjPgUJbgIIFClrOTVqBgdef2cO4tlWiWgvm1zS37dTq8g8RXjWefijdG9X6m7dKj1MEf5ea+XSV0TyZffnfLPVA9+PpMXtTKTnAIrg+dcJZjhu3A7NAsJEAlNL5NOr72tXK6H4MbNb0vcYO8H2v2vwmFD+tDxDpkv+RnFX5chQLuRgyE5ME4Sh6XS6Oa0jjg0kyMKeehA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8231.namprd02.prod.outlook.com (2603:10b6:8:d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.41; Sat, 7 Oct 2023 16:56:36 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6838.039; Sat, 7 Oct 2023
 16:56:36 +0000
Content-Type: multipart/alternative;
 boundary="------------TnQQHDuyDk6es08dQPwII3Op"
Message-ID: <f41198b2-bf86-4ef4-9bab-6c834b011ae7@nutanix.com>
Date: Sat, 7 Oct 2023 22:26:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 09/10] migration: Implement MigrateChannelList to hmp
 migration flow.
Content-Language: en-GB
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20231004075851.219173-1-het.gala@nutanix.com>
 <20231004075851.219173-10-het.gala@nutanix.com> <87bkdepfyk.fsf@suse.de>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87bkdepfyk.fsf@suse.de>
X-ClientProxiedBy: SJ0PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:a03:331::11) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 253db253-e33a-48f9-c934-08dbc7565d54
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Jw1vfpiWCXjkAsYjl/dtkxfPH32dLpD+DcD1z3CvxkisQvAGsjqRKz679NBb3XKwWJ+ZMKeAsxdRm0yAMJNKemfzRNNgsUJbl99m1hVwf4UP58863Vke+/0CnG1DPB9bpa/CyFyu/kyApw3HXkmxBcbiJGDRqJuIgQvyoGf7u62hztGKZE+nPNxnKWne6u3ThLYl3FBpG59DtikiH1k6lo4F+NxzTX4l5Ppw4prGK/8wLZGFO8gcHTMjnnHrDDOhUncTlk4y31Ty77YgMKA97MEWIkjtrh6vVvqWvrpw1UIbYZDzfESImaDqNR9SQRIBjYRBQvq0XvZMSLkcdOWMVyjLNlWWIaAdv6Wcr8oc2hWMcWM0j3SY91jSRYQNQj9kO7nH5rt2LJbgGlOQfsq+b7M3BYaR4FN27ARS+dc7TLx8Z6/X2BQe+dVl+sZUXDfyf1rZy4hpXdbYldkVFzD3Vv7Hcd54diaKTlqLjWf/hmORSMuNMYzpOaHca+AA0Ue7X9vA4axrLJ8/nGglVRDMgOO6CczIY3+Oa63+xxxU+aKJGQvEfMTs66G8Y2dKKG9DUZ1yKAgE7aTNN5vwPRDDZgN2IPuGowmTeiuEhgH6VNVR3PfpYVP3yQprnKBdnFkxufwqF6TQK/3pkDthJeo5v2Lb/Hl0IynJYGX9VW6FTwI4us8t+kSQFb0XsdYD/Re
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(33964004)(53546011)(6506007)(6486002)(478600001)(6512007)(6666004)(26005)(107886003)(2616005)(316002)(83380400001)(8936002)(8676002)(4326008)(36756003)(41300700001)(44832011)(66946007)(5660300002)(66476007)(66556008)(38100700002)(86362001)(31696002)(2906002)(31686004)(43740500002)(45980500001)(309714004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhRekxzdnllUHRZeTBwMlo4T01qVW1MdEQ1RG1KRHBIU3pBODUzTS9VOXcv?=
 =?utf-8?B?Q2dBU05RS05nTnVRZEFTZ0JXSkNwaXpMKzg4ZGpwZk5LYi8rYjYxWStiMnBO?=
 =?utf-8?B?KzcxRlVzNkxkTUkzaldJTkdxWElRS1dEL1FiT2Fsck5sczRZOUk2bE5EcmV5?=
 =?utf-8?B?MWgxZHhEcXJLM1p0ZDJLNjFPRkRHbVNQeWtYNEp0d1RLNmR5ei83U1Q0UFRR?=
 =?utf-8?B?WTh0OVFUQlg3QStVcHliK253SmhZWjd3LzJiZmFHZXc3TllSUkVXbVUzSXBz?=
 =?utf-8?B?VlF3QUNoVWJoa3FqMG1ROWp2VFRzb2VyM1ZFS3ZjOC9hMG1TeDlBeWpkODVa?=
 =?utf-8?B?di93c0NQT2kyWUo5RzJtT1FpNC81VHRYdTFlZXViTEU1ZkpxQU5ZS1V5YXY4?=
 =?utf-8?B?THJXUGVLekY4VUFaVE1ObVRIb25XcUtPTHVYclNEa3ZOT1BsNzBNVkJHZEl2?=
 =?utf-8?B?REtQOUc2eGlYd2x4Y0RBOTRpb3A5MTRnOEtCUVQ5cFBoZTFxNzlySEJmSVRq?=
 =?utf-8?B?TlAzWnRWbGwvZXlmN3c4Y3NIK3BQZFdlSEtSa0VLS3Y0OEs3cUFxemowQ205?=
 =?utf-8?B?OVB4TnlOYU1lYXE2bTU2YTRVak9CTnBBUnFYV1JudVlIZUh6dzNuUGUxQzNw?=
 =?utf-8?B?MTAxNUVrVWZaR1EyQStQSTZjSXVmK3FpSmRjc05MeWtpRUtoSXlXcjNBRjYr?=
 =?utf-8?B?aXpQd0VGY0tuaVJBbzlzZ21yR2lxbWwvNlZQSHVjVGpzNzBpZ2ZUTVZoZHht?=
 =?utf-8?B?N0thcjQ5RXJ1LzAxWmdrOXA1OVRqY0ZhdTg5UWhRa0RoNSt5SFpSTzdkTzNn?=
 =?utf-8?B?N0djSW1tTDRVb1EzNWl2bzFYbnJ2WnNGQXFWY1NDSlR1eVBzU2RYMWM5NE9h?=
 =?utf-8?B?L3RiVlhIdUgxazE5ZFJ0S1l0c29LTmxYZkpZMzZYb1BQUlFKVzk4WU1kNEVP?=
 =?utf-8?B?SXgzWUprdXAvcWg2U3E2Q1ZzYW1VZDQwYTJUcWtrOGRHSWZyR2dzSlJBMFIy?=
 =?utf-8?B?RklpVU5ZSmEvRWlrejc5cUMxOWtoUjl3ckNQU3hwOVc4QW1OcG5PSW8xREg5?=
 =?utf-8?B?SkYxV0VvdmJnK3RWTFR0Q2k1Y3lLYlo3YUdHVjV5TnFxQ1k4eWlGVDFaWGlT?=
 =?utf-8?B?RFgrdWwzMWUrZFRiMWxteGpyR2o4Nko0ajBWWXk0NExQSE12ODd4YUV1cnlp?=
 =?utf-8?B?cHlxcnlHR3NhZ25tb281UGVnamVoZUhWeDBENVBhQkJ2MCs5ZGwzSFNTMDRG?=
 =?utf-8?B?WitrbEdjN3MrWWNzV1dlK0dKOW5FN0Jxd3I0dnJ0T2lXS1h4eXpLSlljZWkv?=
 =?utf-8?B?VG4zRVBXYmJjem9wSGMwOXpqMjVlQnpIVXhCby9PbjdkMm9wWXM1TmhncUhz?=
 =?utf-8?B?NDM2NjR2djIwUGRKbml3Z3EwemJUNW1wSHRZN0NObVlqUGo1K2NPczlvOW0x?=
 =?utf-8?B?OGFXcWJRYlhDb2VYaU1SVzV6ZjBlejNNcDcyVm84VnJSOHVxUzZVMjBBUE1Q?=
 =?utf-8?B?LzRmYW1QSnUraG51Q0szd0tzZitFU2E3RTQ2QXZsTm5pNE85SEZnWStRRFRn?=
 =?utf-8?B?ZVMxRE9RUFFVRGZaa1VCUnlXUUg2TTJHQmJaVnkyN08yQm5Da1MybC9FT2w5?=
 =?utf-8?B?WHB6dEErZHBwM08zdlF2RHlQTWJCYmFNWElnN1c0RTNhTE9zM21HMDdzOUNM?=
 =?utf-8?B?MVo3WFFFZ0d1KzJOYWVPd3NCcUVKTnpBdUQ0Rk5TMkN6SURPWEJJYkxzekdN?=
 =?utf-8?B?MFllNG04eGxiVkk3Qkh1bVZwbE1kNW1lWGdlUnQrUTJNOTlnR2hWVks5V0ll?=
 =?utf-8?B?NUdyVm4rMXlVQk4za3c2SGxTNG95ekRUaFFZclFONkhjNk52Y2RuRDRVS1pO?=
 =?utf-8?B?LzVZMnZaTWdkT1FjRFNadlVpWGxtSzc0MXdtQS9qMVJYSzlhcXgyYVN0UzBY?=
 =?utf-8?B?ZlRzc0NxL1RTSVR5Ynd2NkxBQS9vV2RSbjZNc01lS3RnU09QbEQ5T3JISGxF?=
 =?utf-8?B?UjhtUE90M3RPNkxQNVJ0RW9ZcTgzalBiaTJ3b0hndncvQStKWGdRWWRqTXhk?=
 =?utf-8?B?WElrSUVtekdJdWttc2tScW9haGQrQ0lpRU85M2tkQk1PRWhCZGtVZjZwTE9T?=
 =?utf-8?Q?iiZ/BtmLlUBXPrcQB0UV2qMcC?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253db253-e33a-48f9-c934-08dbc7565d54
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 16:56:35.5372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBDp1QAZ1/Z9u1vkUt+rjd9Mu3juEb9pprvwfL2SiNaU8EQ5N6QahmuL6TaQ7+UrYupwGyMLT6KOX8ywuD7DOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8231
X-Proofpoint-ORIG-GUID: fQu6EDUoaKKNOl3rKvgRyg_QHOWGhlYy
X-Proofpoint-GUID: fQu6EDUoaKKNOl3rKvgRyg_QHOWGhlYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--------------TnQQHDuyDk6es08dQPwII3Op
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/4/2023 8:55 PM, Fabiano Rosas wrote:
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Integrate MigrateChannelList with all transport backends
>> (socket, exec and rdma) for both src and dest migration
>> endpoints for hmp migration.
>>
>> Suggested-by: Aravind Retnakaran<aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> Reviewed-by: Daniel P. Berrangé<berrange@redhat.com>
>> ---
>>   migration/migration-hmp-cmds.c | 15 +++++++++++++--
>>   migration/migration.c          |  5 ++---
>>   migration/migration.h          |  3 ++-
>>   3 files changed, 17 insertions(+), 6 deletions(-)
>>
>> diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
>> index a2e6a5c51e..a1657f3d37 100644
>> --- a/migration/migration-hmp-cmds.c
>> +++ b/migration/migration-hmp-cmds.c
>> @@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
>>   {
>>       Error *err = NULL;
>>       const char *uri = qdict_get_str(qdict, "uri");
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> Just the pointer here. If I remember correctly the g_autoptr here would
> cause a double free when freeing the caps.

Yes, we'll just have 'g_autoptr(MigrationChannel) channel = NULL'.

Is it because inside QAPI_LIST_PREPEND, caps will be refrencing to the 
same memory as 'channel', we don't need to free channel ? I am still not 
sure what is the right place to use g_steal_pointer(), is this a right 
place to use (non-error paths) ?

>>   
>> -    qmp_migrate_incoming(uri, false, NULL, &err);
>> +    migrate_uri_parse(uri, &channel, &err);
>> +    QAPI_LIST_PREPEND(caps, channel);
>>   
>> +    qmp_migrate_incoming(NULL, true, caps, &err);
>> +    qapi_free_MigrationChannelList(caps);
>>       hmp_handle_error(mon, err);
>>   }
>>   
>> @@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
>>       bool resume = qdict_get_try_bool(qdict, "resume", false);
>>       const char *uri = qdict_get_str(qdict, "uri");
>>       Error *err = NULL;
>> +    MigrationChannelList *caps = NULL;
>> +    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
> Same here. We free the channel via caps and we attribute it below, no
> need to allocate.
Ack.
>>   
>> -    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
>> +    migrate_uri_parse(uri, &channel, &err);
>> +    QAPI_LIST_PREPEND(caps, channel);
>> +
>> +    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
>>                    false, false, true, resume, &err);
>> +    qapi_free_MigrationChannelList(caps);
>>       if (hmp_handle_error(mon, err)) {
Regards,
Het Gala
--------------TnQQHDuyDk6es08dQPwII3Op
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 10/4/2023 8:55 PM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87bkdepfyk.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Integrate MigrateChannelList with all transport backends
(socket, exec and rdma) for both src and dest migration
endpoints for hmp migration.

Suggested-by: Aravind Retnakaran <a class="moz-txt-link-rfc2396E" href="mailto:aravind.retnakaran@nutanix.com">&lt;aravind.retnakaran@nutanix.com&gt;</a>
Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
Reviewed-by: Daniel P. Berrangé <a class="moz-txt-link-rfc2396E" href="mailto:berrange@redhat.com">&lt;berrange@redhat.com&gt;</a>
---
 migration/migration-hmp-cmds.c | 15 +++++++++++++--
 migration/migration.c          |  5 ++---
 migration/migration.h          |  3 ++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index a2e6a5c51e..a1657f3d37 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -441,9 +441,14 @@ void hmp_migrate_incoming(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
     const char *uri = qdict_get_str(qdict, &quot;uri&quot;);
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Just the pointer here. If I remember correctly the g_autoptr here would
cause a double free when freeing the caps.</pre>
    </blockquote>
    <p>Yes, we'll just have '<span style="white-space: pre-wrap">g_autoptr(MigrationChannel) channel = NULL'.</span></p>
    <p><span style="white-space: pre-wrap">Is it because inside QAPI_LIST_PREPEND, caps will be refrencing to the same memory as 'channel', we don't need to free channel ? I am still not sure what is the right place to use g_steal_pointer(), is this a right place to use (non-error paths) ?</span></p>
    <blockquote type="cite" cite="mid:87bkdepfyk.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
-    qmp_migrate_incoming(uri, false, NULL, &amp;err);
+    migrate_uri_parse(uri, &amp;channel, &amp;err);
+    QAPI_LIST_PREPEND(caps, channel);
 
+    qmp_migrate_incoming(NULL, true, caps, &amp;err);
+    qapi_free_MigrationChannelList(caps);
     hmp_handle_error(mon, err);
 }
 
@@ -730,9 +735,15 @@ void hmp_migrate(Monitor *mon, const QDict *qdict)
     bool resume = qdict_get_try_bool(qdict, &quot;resume&quot;, false);
     const char *uri = qdict_get_str(qdict, &quot;uri&quot;);
     Error *err = NULL;
+    MigrationChannelList *caps = NULL;
+    g_autoptr(MigrationChannel) channel = g_new0(MigrationChannel, 1);
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Same here. We free the channel via caps and we attribute it below, no
need to allocate.</pre>
    </blockquote>
    Ack.<span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:87bkdepfyk.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
-    qmp_migrate(uri, false, NULL, !!blk, blk, !!inc, inc,
+    migrate_uri_parse(uri, &amp;channel, &amp;err);
+    QAPI_LIST_PREPEND(caps, channel);
+
+    qmp_migrate(NULL, true, caps, !!blk, blk, !!inc, inc,
                  false, false, true, resume, &amp;err);
+    qapi_free_MigrationChannelList(caps);
     if (hmp_handle_error(mon, err)) {
</pre>
      </blockquote>
    </blockquote>
    Regards,<br>
    <span style="white-space: pre-wrap">Het Gala
</span>
  </body>
</html>

--------------TnQQHDuyDk6es08dQPwII3Op--

