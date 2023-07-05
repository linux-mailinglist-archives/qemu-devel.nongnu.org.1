Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81F5748464
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 14:50:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH1x6-0004vY-9o; Wed, 05 Jul 2023 08:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qH1x2-0004n5-2r
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:49:45 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qH1wz-0007LO-LD
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 08:49:43 -0400
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3659SM9G031190; Wed, 5 Jul 2023 05:49:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=JG6G9520FhHygclb5E60aah0i/dIIchXTFvUvGh6IeA=;
 b=QQtQDUazSdZpghG65XlUT/Pfun2tRjO+466Lripz8DB1MGc7vTT6YVWhtKc6c57GcNVy
 lcB2KbjplCwyrDjB7wU/Qy7TmlnQTdCpGBuCw0yluq3rR8UrtuQ5EAVFmhUQKh+w4kx+
 Td8NcGyniRr+gq22NClSLz3Aixwziu1FTBt0zzwFzrNiTGSHgxRHcWwNwIXEv4cH0M9h
 T6VAcUhSUVcLIzi0crK+GKx3WLw7ZmFcxBxYQKCcXwh6/GpNqy9ksG9pc47U4VcMhVg+
 KjXpKAl7uu4mEpeTryIUSwlGLPvupnyy83RC9oZjeGMFvXY8JT10T8MCDuN+5AYOVEcy cg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3rjhp6fba3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 05 Jul 2023 05:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEKEc9o8D6k2Ziit+WFEuvC988nXzYaFIqkgWRHv5VrDigCo2Eke1erwLLQGGNKnbNOLxK8cbJV7h4ZGKNKPOwf4Ue55Xd7arWKjmvK5AZ2nW2m2ILMTfh7p9KXPgoqoIJc7JNZL7Xvkrvxb2g50xd7QHr/zSlxkI1iM7Y4+bO5NaWYBf5oLMpjUwTx3eFfFMQGxLTB1qRjcRPeel/nKK6DZQFx8rK0h1i/BJsWpTZuPaDaC+sUOnNGvnL5y2Pv3rd6RFBitF9id5pCJuHcYLoZmXy8R8oH+izQ4AJ5rJmFez+1P6budRfRzQ3+eSG9BJ2WK1bSxCWNZll0bQfXndQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG6G9520FhHygclb5E60aah0i/dIIchXTFvUvGh6IeA=;
 b=acRFFtoCXQzez1EsTSh6FoX1ApOR7N121YrEGWaY803Ndm4vaF3Sv5Iw+ekrdyaCAmLC4pMZML6UyZyEn5xgZNY1xWGS2hrM0IF/JcIL8VFwDP4GGjOYH+T+Udn1O8GB+D4XkZByOjnzh74ZOPWf0x6GMJCkJ7zoqX8laIlJCXaCKf2czYNUel5BFP5XJBUjbVA0CHvpGNdQwJl61YX26RKAulCx+Q4NVPOikHTAxywNskiigO4nXRSiDxhgBZ5AT50rqQRBrC+Xlnry5Lr9JMZ4q0CJycLrLD1qvRP+EB/dJ6xK164mNq6jA1zFjBujsYzQJLJs0G7sSUokiY7JnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG6G9520FhHygclb5E60aah0i/dIIchXTFvUvGh6IeA=;
 b=LL8hrpTEMBO08mQTU5cgGFpa++47VLvYZVY1jKrpXPSqsZ2H2+R7dyphVzq8jVnmZSoJ9D0r90Pa/Sy7JNY8T4X3npHAPBuGKR2SQQZjOkcLK3S9o9YlzQXC1Z5ZV/uut/H9f7rd981iyc5cfwc4D8CmTetbik1MWSRxNB1d8REc2ydd8QH45LkZbeaOsUW7vLFj0cqr+Wirw0qjwzhWD5L8SfqdOmsZgncBSUnMep5e/886dFBdNbNgbAloMm9O0DFJirweG4xWxXbjBB9p6o3Xg+hfOepd0rcV4cO2nyTPAAMdWx04pnk6fOztgo+JYim5FE0kp0VHEBbsZ6JSyg==
Received: from BYAPR02MB4343.namprd02.prod.outlook.com (2603:10b6:a03:57::18)
 by BY5PR02MB6534.namprd02.prod.outlook.com (2603:10b6:a03:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 12:49:36 +0000
Received: from BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920]) by BYAPR02MB4343.namprd02.prod.outlook.com
 ([fe80::26a6:11ae:fb38:5920%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 12:49:35 +0000
Message-ID: <696fa0ec-1c36-f245-80d1-e65fa60d5368@nutanix.com>
Date: Wed, 5 Jul 2023 18:19:20 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v6 1/9] migration: introduced 'MigrateAddress' in QAPI for
 migration wire protocol.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, prerna.saxena@nutanix.com, quintela@redhat.com,
 dgilbert@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
References: <20230606101557.202060-1-het.gala@nutanix.com>
 <20230606101557.202060-2-het.gala@nutanix.com> <87cz16iox5.fsf@pond.sub.org>
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87cz16iox5.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::18) To BYAPR02MB4343.namprd02.prod.outlook.com
 (2603:10b6:a03:57::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR02MB4343:EE_|BY5PR02MB6534:EE_
X-MS-Office365-Filtering-Correlation-Id: f823506d-6910-4c65-02ce-08db7d564921
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE1Bf46ux7fx/JcGu8DZcGRzr/AE9Bfmxe1399pHOq3+8RZQ8a7OubgXtYWfnukNsp8FrYnWZn5ih7iyKfg3EijyAo5lTho9ZvmtPs8w7cmbg5t8ZpDyrdv9M2E1ilcl64Q437QKmCikO9QsdVCA07lsfaEeW+o8BTt6kBvt8Tljd7KPvN15U07J3VJar1cDu9DvEE8AUEYE2sfXrL3dy3vYuHu+40pL8cEcl/0YrX9tDZFMq9pbjCvGp9cId5jdYpWnBXMbSTMQHMZbnoNXz3lRxjmNU6YmOLGxp2ioelgDJ5C2oaE/iNPtp9+91jkehvLROSyTQlMHFk382JYTA/f+B1KlIn+K8MMF25tynkwA4PrFOEVsDWcU95e+oLq2eqV5PGQFMxBxwlecusKwBgewio9lHvtz7O0fts4eyAnuYWA3avLO3oNkmGZU2OjSNb5Vto4n4O54WE1xDYPiyXYYfa2/RL0h0NjmmGyI4+OSoCPn+TS+BS6grvdO4ffI0PDYPCYKT63UeezgU9WM/+d3QOwZP862RIyChWjglBPciPD2xFTe4YYOUqcVq/LL/AaRjhvMOnV7mBH56ibdhMIh6uwu7QPdnNLrpzKazySBeqRQCq60ryaOL4Lpnskj7nAfmrTmdNGJImlPnB7xmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4343.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39850400004)(376002)(136003)(346002)(396003)(451199021)(66476007)(4326008)(6916009)(66556008)(66946007)(2616005)(38100700002)(107886003)(86362001)(186003)(31696002)(6506007)(53546011)(83380400001)(6666004)(478600001)(6512007)(6486002)(36756003)(41300700001)(8936002)(8676002)(31686004)(66899021)(5660300002)(2906002)(44832011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ujd5YTRNajR3YktkZzFFSGFkcHNqdTkxZVZHR2RETjg4VU9FanVYMWc2Ymhy?=
 =?utf-8?B?Sng4SVkybkZvSVRoWHducU5hS2hvOUpFN1BwWG5KWDAyQkY5bnhXOFVtRG5u?=
 =?utf-8?B?QmkzcHVYdGdhRHlzL25JOXhISyt5Z21MMmVXY2pIQ0lJZmdTWnNwQmRhN01U?=
 =?utf-8?B?NUhsSmJRcnVIbHo4MGdFdHB2aFRnbjBySVZHQUtHeklTVU1Qb0RtWUszeHdE?=
 =?utf-8?B?R3h0SDBaWGlZOUs1dHNsWHF3WkZmRTdnR0Q3Y3lRby9ZTjRwVHdibjdVMXBk?=
 =?utf-8?B?MElNaktDRjFTSE9XSDZOOTNQbk40NExkVzVOUGtiSUh4OWFJWndLaTRzZUxr?=
 =?utf-8?B?TGppa200YmFObExQZlpHRlAzUythaFhMR1VsRmdCSW00MU4rSWJ0SmNYZmE0?=
 =?utf-8?B?eHdPR25Xc1VKeHovQTBKcWhDK2I3c2o2NzUxcHYxSzV6NGRKWkJlbGsvVVZ2?=
 =?utf-8?B?KzBIOERmWXpjUUhIY2FBMDJiNS80WENQUXcrdXhPMlNjM0hzdzYwVVBhSzM1?=
 =?utf-8?B?cHY0d0NoS2EzTmFmNHQvZlE3dlphSURxbEhEeWQ4SVVZMldVYTduWjJlNXhu?=
 =?utf-8?B?dXNQRENyaG1uNDFuY2s3UndNSFo1dys4SGxvaGoyUG1kR0JrWXprbDFmOS9Q?=
 =?utf-8?B?Y2RGOHg4NHl3WUpGS2dNQmIvV05ZUWNXV0tmdERVV3FkMjFnMk5CWTdpd1Fu?=
 =?utf-8?B?TTB2REJ6cThzNHdmdi90blZSeTE5V3dkek1IR0ZHV1htWkIwWnhjb1lpOFdG?=
 =?utf-8?B?NGUyczJTbDI5QmNZYUN1S2tYMHNDY1FXaHRNMTY1M2cxYWllUnUva1N0b21l?=
 =?utf-8?B?V2wvK0RWekdqREZ3dGlRczh3UTdsandWUFcvNHI0NzM3cnVtRjYwREVsNmlX?=
 =?utf-8?B?NEpZa2QrY3g5TzluTG1RMU5McTB2QTg5VUZiNXJpSDBOOVU1bjJSdk4vb3Fk?=
 =?utf-8?B?UkZuSFcrOXJxeGRrcUxITCtyWVZSSU13dW5Wby9ldjdQbjZVQkF0bndMMXRH?=
 =?utf-8?B?a1pub1lnYzIweE8xalNoSWNiVndldnZab0x2R0hpcksvdG9FOHA4dk1CUjBp?=
 =?utf-8?B?bjh0NzFaS3k1VmZqNGMyMTlES1B4YmYvU1dGeVhXTVJlRVUzeHFTSHRaSlhk?=
 =?utf-8?B?TWVCRFcvV1lKYzJGa2xaYU9jeSsvaDUwWFhvbVZWWHhKZDVCcjAyMmk3aHNz?=
 =?utf-8?B?dWo0eGpTZ2tTNk5ZV01RcGRrQVpPUXF6c25HMWZsU2lsWFNtUmYvRWszRlpD?=
 =?utf-8?B?NGJIT1A0ZkZFUDZLYnVaSysvYVQ5QnhTSWtQZWhENlhaZ1h2K1RIOFE5K1A0?=
 =?utf-8?B?Wm05NGhuTTNnbjB2RTdXejNVWUMyS0JzTU8wQ05ybmtZVUpFYUpsMnRBTnJO?=
 =?utf-8?B?Ui8wakRGWEJsVVF4NXpOVUQ2VENYQmhqR2h3L1NUU3J6cnU0aTFYL01ucDVo?=
 =?utf-8?B?cE9mZXhuSUNLTmpETEt1YkE3WkRIOUNEamZ0RWVKM1Z1ZnpOQS9lZk8waWZY?=
 =?utf-8?B?ai9qcm5IUDR4QXBvYVh0T0VTYzVZMFNwK0kxUVdZOTZyZzZKQXhUcEs1YXMv?=
 =?utf-8?B?WWtwMHhHQkpMMVdjRllnbHdvYWdBb2RlUzkxbFQ5ZFIyLzN1YUVDUlFrcjVH?=
 =?utf-8?B?QW8xZnVLWjRFN3dNeXdrY1I5dHJXdENmTlVEdVVkanVBSmVSTUk3WWYwb1kv?=
 =?utf-8?B?VHNhQ1ljd1R6d25jV3M1MmVwRkw5Z0FLb3RiUWJSOWlsMmhiZ3ptR2lJbjZB?=
 =?utf-8?B?eHBDUXBBY0plOWZrNHpGaVMwdzJTRU8rU2hpVGMwTmZBZzkyaUt5WTc5d1NW?=
 =?utf-8?B?WVpwN09MQkVZYkRnTlhjOUo5Zi85V24xMEpyT1k5SVBEVjFDVWhGV0F4NlE4?=
 =?utf-8?B?SGw5Y3dXY21JR0srYmpNdzNZcTV3Zkl0ZUh5MkFrZmk4VTA5Q2YvNHBSVU5F?=
 =?utf-8?B?N0F2dGJMV2xmZGJkZkc5K1RkaitFZ2dqa3ZFdlI1ZDRJZ2p4L1BYMDcwZEVv?=
 =?utf-8?B?aTBuYXFmam5RS2s0aUlOV3JEMlB6TGZjTGx3TlRWMG9PbWlxQUpORGoxeG1n?=
 =?utf-8?B?VGdHamJHR05WdTliaWQ1eU03Y2lrOG1WSkFHTEJPMWwwa1dVcFdMOHl5amg0?=
 =?utf-8?B?bldLeDJPQXlhN0EyaDlUalJOZ05iRWRPM3NsdFZCbEdpL3pYVlJLaWZ6Rnhs?=
 =?utf-8?Q?338hzcvXJ/nNR0iYB2zJp2Su+r9tVULU9wRbJe0N9E0K?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f823506d-6910-4c65-02ce-08db7d564921
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4343.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 12:49:35.4722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DIcd0qvkIO9adI8fErWnsHmEIHFxiZaxiO3Bu7JV4kp3v9EWVl+bARlSdhOnzw/54j/4c3p28j9myFsslymJ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6534
X-Proofpoint-GUID: z1JondhkJc5jmEJ5s61TR4xYchIxmmjv
X-Proofpoint-ORIG-GUID: z1JondhkJc5jmEJ5s61TR4xYchIxmmjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_05,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


On 05/07/23 4:51 pm, Markus Armbruster wrote:
> Het Gala <het.gala@nutanix.com> writes:
>
>> This patch introduces well defined MigrateAddress struct and its related
>> child objects.
>>
>> The existing argument of 'migrate' and 'migrate-incoming' QAPI - 'uri'
>> is of string type. The current migration flow follows double encoding
>> scheme for  fetching migration parameters such as 'uri' and this is
>> not an ideal design.
>>
>> Motive for intoducing struct level design is to prevent double encoding
>> of QAPI arguments, as Qemu should be able to directly use the QAPI
>> arguments without any level of encoding.
>>
>> Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
>> Signed-off-by: Het Gala <het.gala@nutanix.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>   qapi/migration.json | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 179af0c4d8..e61d25eba2 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1407,6 +1407,51 @@
>>   ##
>>   { 'command': 'migrate-continue', 'data': {'state': 'MigrationStatus'} }
>>   
>> +##
>> +# @MigrationAddressType:
>> +#
>> +# The migration stream transport mechanisms.
>> +#
>> +# @socket: Migrate via socket.
>> +#
>> +# @exec: Direct the migration stream to another process.
>> +#
>> +# @rdma: Migrate via RDMA.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'enum': 'MigrationAddressType',
>> +  'data': ['socket', 'exec', 'rdma'] }
>> +
>> +##
>> +# @MigrationExecCommand:
>> +#
>> +# @args: list of commands for migraton stream execution to a file.
> Typo: migration
>
>> +#
>> +# Notes:
>> +#
>> +# 1. @args[0] needs to be the path to the new program.
> @args can't be a "list of commands", as we're spawning just one process.
> So what is it?
>
> Digging through the code with the entire series applied...  Member @args
> is used in two places:
>
> 1. qemu_start_incoming_migration() passes it to
>     exec_start_incoming_migration(), which translates it into an array
>     and passes it to qio_channel_command_new_spawn().
>
> 2. qmp_migrate() passes it to exec_start_outgoing_migration(), which
>     does the same.
>
> qio_channel_command_new_spawn() passes it to
> g_spawn_async_with_pipes().  A close read of the latter's documentation
> leads me to:
>
> * args[0] is the excutable's file name.  As usual, a relative name is
>    relative to the QEMU process's current working directory.
>
> * args[1..] are the arguments.
>
> Unlike POSIX interfaces like execv() and posix_spawn(), this doesn't
> separate the executable's file name and 0-th argument.
>
> In short, the head of @args is the executable's filename, and the
> remainder are the arguments.  The fact that the the executable's
> filename is passed as 0-th argument to the child process is detail.
>
> Perhaps this could do:
>
>     ##
>     # @MigrationExecCommand:
>     #
>     # @args: command and arguments to execute.
>
> If we want more detail, perhaps:
>
>     # @args: command (list head) and arguments (list tail) to execute.
>
> Not sure we need it.  Thoughts?
 From a user prespective, I think defining that command / executable's 
filename is the list head would be good ? something like

@args: command (list head) and arguments to execute.

>> +#
>> +# Since 8.1
>> +##
>> +{ 'struct': 'MigrationExecCommand',
>> +  'data': {'args': [ 'str' ] } }
>> +
>> +##
>> +# @MigrationAddress:
>> +#
>> +# Migration endpoint configuration.
>> +#
>> +# Since 8.1
>> +##
>> +{ 'union': 'MigrationAddress',
>> +  'base': { 'transport' : 'MigrationAddressType'},
>> +  'discriminator': 'transport',
>> +  'data': {
>> +    'socket': 'SocketAddress',
>> +    'exec': 'MigrationExecCommand',
>> +    'rdma': 'InetSocketAddress' } }
>> +
>>   ##
>>   # @migrate:
>>   #
Regards,
Het Gala

