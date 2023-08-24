Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A03527879AF
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 22:54:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZHKb-0005JK-Cm; Thu, 24 Aug 2023 16:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZHKY-0005J7-Vy
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 16:53:27 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1qZHKV-0007z2-Nx
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 16:53:26 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 37OJEV8r007542; Thu, 24 Aug 2023 20:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b31OCQi2nKLdCtQk8bKFrkTjLmpvoqGE7ZBKdUGKtfQ=;
 b=baYA9v/BO4tS4KDy3JQQWg7xRVGrcYt1x57zZTeOJ5jIMoJlFPFhrZvn7uHlGYrSK53H
 yRL/TmAshY64Ew5v2w/uFL9n0tmlhaJwhFF4TQh+U/WvuPg4bMxrJwjXdYHCXUqXrX73
 HMbJ6v/crCh0k3sCBaSHrnhhdR6FsEzbiUA6bBskY/3g2L5MeDHFnL7PVTAMM2krptls
 6+t4RPTLWfbYL3ddmiM3FFYNDmze9WButTqlqv0IbKM6j6X6sKItl4iaATMye9s6m27W
 YUSAs5qCgkFO5P5w8cjK5zqvvApjFW797Joq7TtJc8dcHDR99jpCzIKimLxCrR8UQBvu Eg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvw2ff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Aug 2023 20:53:19 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 37OJnjSO036019; Thu, 24 Aug 2023 20:53:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3sn1ywg1sn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Aug 2023 20:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXxJeLyb2PFVDD8vbdTb+96RoLUmG20wfq2C8xPzkX4c3qUYxTEq7nkByDm5UnKCPShKJy2Gy+cPOMigveBfPArjBDSxUN0wNPI/b+8pzHYIBZHqzKgKTq69Abq3RQHq0OcPg9tD340SSHZxDa5OeA3KT4DSX8CNPA/sOoHXzIRBWVzTSu6YApD3dmkY/1TLB9/Zwyjj2SD8wQN3o8Pv9+iWYmmmB8tKMQgX3aq8qUkd8OwyXJ8CvtBjU2FA9D4YYk0MtRqywfbnyjiY7x2h8uZ5f5ui2Xv7Taa+TC3ap+4v2cKSnQ8/Wdf0qvxEaLAT5H9Uj88C4kmeNKS5JgnYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b31OCQi2nKLdCtQk8bKFrkTjLmpvoqGE7ZBKdUGKtfQ=;
 b=ecEa1Ltd/JyI90W3ZQAMgNIoXktpzgu2C6715g3ww34UJjUZN1+gEVwXocx1IT3VXf5fSD7zYzzA15ILgNNQAXbdvV+NoE1NF4n7mY7SRRyQh8YF71hqWK6UgNlcZJmMEBhtTQTe7jlJPOXKuOYgz7Fosh7/gHHTOIV2bzvrpT13ffAwWoG9Yd+kVh1UBeD7UKKBH4wm0W4ShB2KBGwbNG/7EyZx6j74Fbcjj1g+QcOYu9UHZjCXiGWE/VYcpnUCGNPKDDtZUegaPwbTG9eleqznS04uQ1mVlunHgQTNPoC4fj6271Ui+CHqZToQ158Pz6JrBNpw55ehRTIAbbxojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b31OCQi2nKLdCtQk8bKFrkTjLmpvoqGE7ZBKdUGKtfQ=;
 b=jl/zK5Xs0I4mqWQjFSeyn5UmB0wh1tYvUfNdpZOeD7W7tHk6nGJNvpNH3hCGw/Tz0Tk1hfSdCwsoPlb3Og64xcOFac/vUk7mwjuAE72c5oY77BOPyoN0ehY1SJ4A527nxkUB2eH+v/1s1CNjW0oKrnb1j8xAq2lUOZMU4zTLKuU=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 20:53:16 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d324:ad85:4523:fbb0%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 20:53:16 +0000
Message-ID: <b64bae85-1665-2ea5-3690-12cd5e67620b@oracle.com>
Date: Thu, 24 Aug 2023 16:53:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH V1 2/3] migration: fix suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <ZJIeR7svXvtHdgs4@x1n>
 <6adfae20-60fe-ae08-1685-160b2a1efab5@oracle.com> <ZJNdcyrv0TzFUKMy@x1n>
 <340b5f58-0924-6f8e-6f82-0462a5cc22cc@oracle.com> <ZJnYlApmsQLXBK/3@x1n>
 <918d1568-fa1f-9ebe-59f9-3e5e73200faf@oracle.com> <ZMF/ly/FyavT9AMJ@x1n>
 <9383f79e-561a-aeab-5df9-0501e8d0a831@oracle.com> <ZNqClofhPByQP13H@x1n>
 <22f21854-9565-65af-7794-ee2007e7f1aa@oracle.com> <ZN5kmZdvc1Q1446r@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZN5kmZdvc1Q1446r@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:8:55::33) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|MN2PR10MB4157:EE_
X-MS-Office365-Filtering-Correlation-Id: e167869e-da2e-4799-307c-08dba4e42396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3pOBGaLDi3jffLAi1tVH210SZdRzKZjt271WJsPqSvlRBvAlqB9LO/zOg3SpgvYJeyTQeyZvKgYICdor+WPFo1Hh9m8FYtqwL/2g3eztTQkkun1Go9KtIt3zr34qpOFjwYmCQKoFcC4NHZyNQUe/IbkqkrIQlmGsxAyRoDzN1CYeIJu9uP8EwjKAbgJcHx18nfji/CRYgG7lxfsRD9G65IlQQE46rZ7ZEUMXxEXoH5qWNUh1eiHCrsCf40lsPJk784YruOn6PkGvUEraa2tW4cRND03mfnNrN8kWoMCDZSShs29dRCqRs1BTSB/iOAhlaf4Sv+DN7xCcjSfBhXShMRZKZghhgaJpxWrixRKgGShrVUCUKMA495avSw3ybDbTE01yvC0W4DHh/m7xC/SrjIH25BiQDv4EtWf0JxJmGSdgU5VbNSk8Da7cdYFuOL4FaHmAVfbHB9+Dc4FdUgiR5CUafJKHQ4d35CWBgYds6aw+MC+FwVKMJxvUb+1ph0R6sXqXTNUQY8crnatDG0SK7tO3erutOVFnE6M/9dqxdNaZ7JeMxaR9Xnl8uAIbQh0CD5mPaoVBI/IUf9e0A5iJ00nUg7rq5eV2gcqJuZb0y0dIoMQvnULLgetC0KmAQgY75d3Wthc7iXJydbrFpSrPlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199024)(1800799009)(186009)(2906002)(53546011)(6486002)(36916002)(15650500001)(83380400001)(44832011)(5660300002)(86362001)(31686004)(31696002)(26005)(2616005)(4326008)(8936002)(316002)(66946007)(66476007)(66556008)(54906003)(6916009)(6506007)(38100700002)(6512007)(66899024)(478600001)(8676002)(36756003)(41300700001)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTlEZk9vUytFOTJseUNYKzJvMFpIVmtiemdOS1ZqN0h4WFpEUUhPVFlkaldY?=
 =?utf-8?B?S1RjdTFvd3BHdEFZQUhZOXR4K2NnL2R2bGQvRThwNE8xZzNVVDNzU3NwY3dN?=
 =?utf-8?B?VGxJclJGcStWVmhGYVpGR0FqVmc4aFhFZk9lS092YkJiMytqTW1FZVVTcC85?=
 =?utf-8?B?NlI2NFJGNlo5R0xZZkljWmhEWWd5SkxZV0RKYlpaTjNKMlBwQkxzTkZ6Wkpx?=
 =?utf-8?B?WFQ0cU15THlVR3hYRzd6Rno0N3FXa2NreklVZENybnF0bzNISUVSU2M4MlZM?=
 =?utf-8?B?ZGFmMC9nYi9KZGdrSWhsc0hSMUhXSE9PU2hkdHRqcW5rQzBqYzlaS1FKLzFU?=
 =?utf-8?B?dWNHbnM5SnlwSHhOeTU5MjJZbDVDV3hISjUxNTUyaDF2TWwzaW50dmlwd1c3?=
 =?utf-8?B?UFpWZWN6a1VCSXFiakRLdXVpUmdyRjZBVHlJVitpVEVBaGoxMi94QjEvZkZp?=
 =?utf-8?B?aFhrRmdVY3ZqV1BtdDZuQ1ZmRHl1d2xMYXlKTzQvTEYxVGFjU0cvTDVjNDRV?=
 =?utf-8?B?WDRYMUhRSkZ5ejN3ZGNxaXdtSTRYeWxyTGJKa2llU0ZMdE81WnlGT092Mlhz?=
 =?utf-8?B?Q082Y2dmcWYrdWFFRkJRT1Y3bVluenMrWnNkUVJWc3BoY0pCQXB4MlBja0Rk?=
 =?utf-8?B?Ry90SXN1YW5sWEVpMFJRUmpaaXJRSzJac0JYSjhrbnYrOUdPZGp4OXI1WDA5?=
 =?utf-8?B?MjQrQkpaVWQ2YXdpOUxmMWhpcHh6andvM0VDaldRU2t4L2V5R0ZyNm9oZnhm?=
 =?utf-8?B?Z0xFcktUWDd3SWNFS09BNkRxTXJ4U3VHWFhJUjcrR0tNc1lUZng1RFhiQWZF?=
 =?utf-8?B?ZEg1YXk4SkFEYWpHVU1xb0JDOVhGa3YxUTlubjJNNGRLMjF6NlgxOHJxalBy?=
 =?utf-8?B?bWtkbS9kK3JEa29kSE9yZE1OK2p4VmZQWmgrcEZXZVJGdUVMczBidER4Q0xF?=
 =?utf-8?B?dThzcjQxcDh5VTlKYUpBdEtpbUgvTyt5M1lDSTNTYWcwa3prQmY1NzEzOHJX?=
 =?utf-8?B?dkFuN25HUThMWmloeW5YcVVSOHNEV0sra3k0bTVoQi9LbFhDcS9aNDFyWTRy?=
 =?utf-8?B?ZjkwRTQvb0R0Y3d3QzBac1ZDWXVyamZIeW1oN0xlaUtrNTdXRlc0enlXbUp1?=
 =?utf-8?B?bVhEeHZsZllqMDFWdmRXTDFLTFJMaGhrTTdtQkFIRXIwcG9MZXArRnB2NkU4?=
 =?utf-8?B?d1doOUxHOHJJV201azNHMGdzeTFnejhKbHIwOWJ0U2Z2dFQ0dWo5NWMzMVht?=
 =?utf-8?B?dlR2OElNZ1ZoMlIzWGxrY2xSUDVrMlh2Ty9pQzU0Zm9LTUwzSTV6NlFXTGRU?=
 =?utf-8?B?SWFaWnFnOUZ1ZC8rYlF3QWV6MlhycHpnL1UyMEF3dFcwbmZCQlN2L05DaHB2?=
 =?utf-8?B?Q3lRbnE3TmRPNmJVTHM5TlBDUGdGK0Jia1RuT0tYUFY3U3owclQxMlFMQTNn?=
 =?utf-8?B?KzhUVHMyZzd0ZllxWU93N1lBM2tmMUFOeHkyVm5pd2VmaGIrb2p6U1dXckRU?=
 =?utf-8?B?RktMeFY5bGZYdHV2Z1BPa0g4VE9yWXFHd3NROE9vditYNytUYkpTUXZQTUFa?=
 =?utf-8?B?RG0ydXBPZFRSc1h0OFlRS1lFYnAyTGl0RGtCUTl6ZUtNVTJGdGR5RVJicmVu?=
 =?utf-8?B?c1RlMXZOLzk5aU8rUE1UQWtJQVdJcVJXR0NVdXo5alNJamV1Q0JSK21lVHZR?=
 =?utf-8?B?MlNuZFc4K25qQis5UlJrOU1xOWRUOTVKT3R4ckRJYUVDS3hxQVhqd1Q2M09O?=
 =?utf-8?B?VzR0MmZYUDU1U0hNQi9LalEyYXlVOHN6dVFJUFZzUW9OQjNTb3ErUStRczVT?=
 =?utf-8?B?SzlvazBSWFNtTmJQNXJsYUlMWlpLaTA0WTU1elJJNDZjTzJ4cExjcEFhcDIy?=
 =?utf-8?B?VER6VEdaQ0xYb0RWYjh2QktqZ1NVQXd2N1FaMUY4ZytqMUFISC8rTzJGNmZa?=
 =?utf-8?B?Ty9BMlpaV1NHV2Z0RWFYSUVwZ1BESUJKNnR6Z2RLWDVIcmxOd3VrU3lwTHlN?=
 =?utf-8?B?b0JZWkJpZGc0dE00NlBkVk0vcGl1KzhrN241Wms0eHVwUkNrMk9GWGJrYytG?=
 =?utf-8?B?Y3o0cGd4aVVhUGJzMWhBb3BGYUVZcXZsOVltby9KOVd4UUJPZysyWGw5NU9E?=
 =?utf-8?B?QldYYzMrTWJSd2sycmt6VkNqaW16QUl3NThXTlQvR0dNaE1JNWlBMGFibmRK?=
 =?utf-8?B?eEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uV4UpBvSh7eKy3Vw4bp4EBZpQlTYlkNAwujgdXkc3Q5/YmnYksI0Q5pZfxLIp6UOBBahjq5TuXzXcojaD0qHZ4f1nqrH5GGbzdBu0QOl1/cgOuSv/pcUUx1k79quYz1xSPHP4n00W2Kw17yiQKwe1MF6Ru2fBbj+z0WawOWh1BsViNJMUWgggr4GTS9cqLndCJ36X/UnizD2dAevmpTMUZFj1Sf3LvQSmTN4zKVw3AGT9zrke1pxakslvdjr62Rkqzd624WH/q5r7pNFy5cDZtGjwHM8P10KaJxGtvY99T5UIeaGDcVD6sZfCZ0nEmWzVIV5B6R35ZlHReSAoTn4qbhG/UQi7E/EmPBbRftfgku2cvqbU8d9B8f1YUFv2+v2Yxk4dnvkamoYKnkzVLnt1jf5rRWWgUh7p4UnTmNUWoOCoWsq92bQStS3a8vQen4Zfu9hR88nitnJBqE1OYbGHxaa8Yz+4e5hdsI6441cG2t4vSGn9yTnw2zDpgWs7oZH1I8NOyeChYZ5+RGzWRNHhLjCfGgg4mICC8j2xMAMpFtoazMU+kihdqPOaw56wTOqDxt+2cKVtgOOYOdjy5QYtMyoa1O2fMuZRWxOC4yPa2+PzdY4U+WYRjibxY379sI/CPlV2roHanH+INPzsJVXpLiZ92gXkmss7jK2S6e/vajycDEJhiA0wy0x58O4EELEIKnSDAOWmjj7XTI7IfmcRC2IvNATCQOZ6Jqdi0nHQQtZG0IlQ5STlDILHt/POG7en58TbrqAXCeKc31Uymf+UQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e167869e-da2e-4799-307c-08dba4e42396
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 20:53:16.1223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3loXzx/llbl+hsUucQ4aUXp5Ns7pGguDAbcFKtQoxpPSug0SCV5J8cUZobPojT9NIcZMZagWv5/N5Qzj3KylubDRy99h3kLbd9eZahI9HNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_17,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240180
X-Proofpoint-ORIG-GUID: 6Q-tilTle4O29p-bDL198AwsRgXrvwGq
X-Proofpoint-GUID: 6Q-tilTle4O29p-bDL198AwsRgXrvwGq
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

On 8/17/2023 2:19 PM, Peter Xu wrote:
> On Wed, Aug 16, 2023 at 01:48:13PM -0400, Steven Sistare wrote:
>> On 8/14/2023 3:37 PM, Peter Xu wrote:
>>> On Mon, Aug 14, 2023 at 02:53:56PM -0400, Steven Sistare wrote:
>>>>> Can we just call vm_state_notify() earlier?
>>>>
>>>> We cannot.  The guest is not running yet, and will not be until later.
>>>> We cannot call notifiers that perform actions that complete, or react to, 
>>>> the guest entering a running state.
>>>
>>> I tried to look at a few examples of the notifees and most of them I read
>>> do not react to "vcpu running" but "vm running" (in which case I think
>>> "suspended" mode falls into "vm running" case); most of them won't care on
>>> the RunState parameter passed in, but only the bool "running".
>>>
>>> In reality, when running=true, it must be RUNNING so far.
>>>
>>> In that case does it mean we should notify right after the switchover,
>>> since after migration the vm is indeed running only if the vcpus are not
>>> during suspend?
>>
>> I cannot parse your question, but maybe this answers it.
>> If the outgoing VM is running and not suspended, then the incoming side
>> tests for autostart==true and calls vm_start, which calls the notifiers,
>> right after the switchover.
> 
> I meant IMHO SUSPENDED should be seen as "vm running" case to me, just like
> RUNNING.  Then, we should invoke vm_prepare_start(), just need some touch
> ups.
> 
>>
>>> One example (of possible issue) is vfio_vmstate_change(), where iiuc if we
>>> try to suspend a VM it should keep to be VFIO_DEVICE_STATE_RUNNING for that
>>> device; this kind of prove to me that SUSPEND is actually one of
>>> running=true states.
>>>
>>> If we postpone all notifiers here even after we switched over to dest qemu
>>> to the next upcoming suspend wakeup, I think it means these devices will
>>> not be in VFIO_DEVICE_STATE_RUNNING after switchover but perhaps
>>> VFIO_DEVICE_STATE_STOP.
>>
>> or VFIO_DEVICE_STATE_RESUMING, which is set in vfio_load_setup.
>> AFAIK it is OK to remain in that state until wakeup is called later.
> 
> So let me provide another clue of why I think we should call
> vm_prepare_start()..
> 
> Firstly, I think RESUME event should always be there right after we
> switched over, no matter suspeneded or not.  I just noticed that your test
> case would work because you put "wakeup" to be before RESUME.  I'm not sure
> whether that's correct.  I'd bet people could rely on that RESUME to
> identify the switchover.

Yes, possibly.

> More importantly, I'm wondering whether RTC should still be running during
> the suspended mode?  Sorry again if my knowledge over there is just
> limited, so correct me otherwise - but my understanding is during suspend
> mode (s1 or s3, frankly I can't tell which one this belongs..), rtc should
> still be running along with the system clock.  It means we _should_ at
> least call cpu_enable_ticks() to enable rtc:

Agreed.  The comment above cpu_get_ticks says:
  * return the time elapsed in VM between vm_start and vm_stop
Suspending a guest does not call vm_stop, so ticks keeps running.
I also verified that experimentally.

> /*
>  * enable cpu_get_ticks()
>  * Caller must hold BQL which serves as mutex for vm_clock_seqlock.
>  */
> void cpu_enable_ticks(void)
> 
> I think that'll enable cpu_get_tsc() and make it start to work right.
> 
>>
>>> Ideally I think we should here call vm_state_notify() with running=true and
>>> state=SUSPEND, but since I do see some hooks are not well prepared for
>>> SUSPEND over running=true, I'd think we should on the safe side call
>>> vm_state_notify(running=true, state=RUNNING) even for SUSPEND at switch
>>> over phase.  With that IIUC it'll naturally work (e.g. when wakeup again
>>> later we just need to call no notifiers).
>>
>> Notifiers are just one piece, all the code in vm_prepare_start must be called.
>> Is it correct to call all of that long before we actually resume the CPUs in
>> wakeup?  I don't know, but what is the point?
> 
> The point is not only for cleaness (again, I really, really don't like that
> new global.. sorry), but also now I think we should make the vm running.

I do believe it is safe to call vm_prepare_start immediately, since the vcpus
are never running when it is called.

>> The wakeup code still needs
>> modification to conditionally resume the vcpus.  The scheme would be roughly:
>>
>>     loadvm_postcopy_handle_run_bh()
>>         runstat = global_state_get_runstate();
>>         if (runstate == RUN_STATE_RUNNING) {
>>             vm_start()
>>         } else if (runstate == RUN_STATE_SUSPENDED)
>>             vm_prepare_start();   // the start of vm_start()
>>         }
>>
>>     qemu_system_wakeup_request()
>>         if (some condition)
>>             resume_all_vcpus();   // the remainder of vm_start()
>>         else
>>             runstate_set(RUN_STATE_RUNNING)
> 
> No it doesn't.  wakeup_reason is set there, main loop does the resuming.
> See:
> 
>     if (qemu_wakeup_requested()) {
>         pause_all_vcpus();
>         qemu_system_wakeup();
>         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
>         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
>         resume_all_vcpus();
>         qapi_event_send_wakeup();
>     }

Agreed, we can rely on that main loop code to call resume_all_vcpus, and not
modify qemu_system_wakeup_request.  That is cleaner. 

>> How is that better than my patches
>>     [PATCH V3 01/10] vl: start on wakeup request
>>     [PATCH V3 02/10] migration: preserve suspended runstate
>>
>>     loadvm_postcopy_handle_run_bh()
>>         runstate = global_state_get_runstate();
>>         if (runstate == RUN_STATE_RUNNING)
>>             vm_start()
>>         else
>>             runstate_set(runstate);    // eg RUN_STATE_SUSPENDED
>>
>>     qemu_system_wakeup_request()
>>         if (!vm_started)
>>             vm_start();
>>         else
>>             runstate_set(RUN_STATE_RUNNING);
>>
>> Recall this thread started with your comment "It then can avoid touching the 
>> system wakeup code which seems cleaner".  We still need to touch the wakeup
>> code.
> 
> Let me provide some code and reply to your new patchset inlines.

Thank you, I have more comments there.

- Steve


