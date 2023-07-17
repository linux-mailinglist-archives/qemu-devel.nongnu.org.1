Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860737560DD
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:48:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLlQ-0008Vj-Gr; Mon, 17 Jul 2023 06:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qLLlM-0008Td-1l
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:47:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qLLlJ-0004VH-EC
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:47:31 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 36H702A4012627; Mon, 17 Jul 2023 10:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zLAh58NjV5E16p/hDd+GVdZOaGioId4FABI9Ia5YEpI=;
 b=rCT4UTe7kj8oTq3RdEcERrKHOYiWoksdS94FyW+X6UgepUwuD7hcytuIxm6nnR7Tlhkc
 zyy7IYCUj+na5NvlxyZvLk7h80p/W/FRTHObbWHjDnB7qUISkGoqaeItadxFzRxLZFhT
 ofF0sh016igxJB2UHAMdEyG07CxUy+Y91y3AGScS3diDgik/QkShL4pCQVvPc2mby2At
 7YALFUZsVtLodOPpsfL2eM8QEFxA9ur6Vb161fbrEe/D3/Yz8KAsLFQTtiZtkZ5iOKkx
 JxqDayU8a1hY5HdYcP+Yz0FUfqisd0+e7sB7a1XY+UHE747T/vB3yoUQVU+WouQDs/xI hQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88jdg3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 10:47:15 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 36H9H5vY023826; Mon, 17 Jul 2023 10:47:14 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3ruhw3q1kj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Jul 2023 10:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAXDaXpo01ZIULTP2cvrcQAgzvMhVbXsQOsSa73DuBtz3VXEsm9CC0G1AgAGfVAQQLzNEGbBhtpfKJMkl5hGSx65GJ37xBdlVmqrBLWlUYT9Ms3rt+8gmijLXGCbjo0FzpGFuiaS5b5Ti9Y/S2vC6m1hGyLddeBaDAdjJi3xyF9QdwAj9ThwZluw+cWarblQXLxhtRJCERjU3q2/I9uUw9Wl6CQRehHJHE3rUwBCNhJ+zaIlWvGDz0YH8bXhbT/YxqQ1j2jvVwd9oAFJmjHvOY1Hl86liyQwd2Y7OTl3op2aMhCcfyi0zED8YmJ3zwB1sWTSeE3Dt1JzTfmdXvyAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLAh58NjV5E16p/hDd+GVdZOaGioId4FABI9Ia5YEpI=;
 b=hrPZ2ODmX3hNXMD3++vYwbcan2wL5ZOxPI2Lnb9cFpRPjnAYrWu6UCAPH3XcRJW1e0QneSrxKH6u4cNNaSSNtzMqOkLA3AQ9UY5Vi0mANI1g4r9B0k6giOvA2ilMtYna/zFJ7l3ZthH4bGIi3s7B4qWrTXMo8fB3hJSfWc4MoS1wf7u44AQ/m8azP/u2h8Zn8lk+qRQVBfO4lg4YxSmGu+iWqlNGJQ8/k/9L4b5Yrec8d+rTu/jSP8sEB3DdSboVDoTi88WYC37DSK6zCgY7TeezL44v7J0oE8EEPw+7GR3Tn5TMJBcUNtyn2eMoKpZirw9Lyz2LKjM5PBAhhAg98g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLAh58NjV5E16p/hDd+GVdZOaGioId4FABI9Ia5YEpI=;
 b=OknEhi4B4jWTsapRnvqHs+3N+qNcGcnLuzgAEz/OUQt9/1T9lpa5EibsHb8tf+2AMjk7lqGgFO7rsekrDQtW1k72lm72SyJsgYLPRW6knubel3XBvg9Aq0FIMcNNMctv7ffDct/M0Egk7Dr3cdaV73Zi7+YNpEabgo7zuBAlgD8=
Received: from DS7PR10MB4846.namprd10.prod.outlook.com (2603:10b6:5:38c::24)
 by PH7PR10MB6602.namprd10.prod.outlook.com (2603:10b6:510:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 10:47:12 +0000
Received: from DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::9a48:710c:5432:7760]) by DS7PR10MB4846.namprd10.prod.outlook.com
 ([fe80::9a48:710c:5432:7760%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 10:47:12 +0000
Message-ID: <4f5a644e-8341-798a-bfe3-27eeb5816623@oracle.com>
Date: Mon, 17 Jul 2023 11:47:05 +0100
Subject: Re: [PATCH v6 4/5] intel_iommu: allow Extended Interrupt Mode when
 using userspace APIC
Content-Language: en-US
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Peter Xu
 <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230715152224.54757-1-minhquangbui99@gmail.com>
 <20230715152224.54757-5-minhquangbui99@gmail.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20230715152224.54757-5-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0557.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::13) To DS7PR10MB4846.namprd10.prod.outlook.com
 (2603:10b6:5:38c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4846:EE_|PH7PR10MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d9cd9ff-a3f6-48a4-fb91-08db86b32d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdKtxFaewXc+jZvd+XyAhzgtnPAl3p2YpKOWFeeamVjO+949YrMHMqvYYNTRBCi2/H/Muvfx53CGgnWvrQpEIGw8O2ZrW3Ing7LQWvH4vjt5rriS9jhhhsQ0t4bnS07MAoJfaqTzExT8qrew+PTUuHxHAymmG8neb1jiW1x5u1UlZITcA8kLbeJgPZyvBo4ubWeus7RmYzRUKxm+S3TaKzjOdo1dJJU0rwz4QaLdXoPUzJK4UGUY3thskqcgyMjGU3GK2X19lKD6iuWm2z6AYdEN/8WJ8/Thv6OYKGuirMtbWiWA8O8GdmsTA1SCtk1Ai0TKAPfRuW+ZZYH2ecymfE484foDJKJDe3bgUTc896vmjxtUY7ibnkSIW2ktIlY5lv74GeRZVaWP2dwDz/xi3PhTiz0NuWOIZ4ACKqOZQc5HKRL0VwnT2XC4Xs2AEtSERlRmvUHj1vLVNUhcC96ZXOeAn4LJ/oljLoO2WsxaWv9nky79+hkAhpH3InnL3kGt4c9vaOwb2WazsZbdA8IddNW44yLrU1D+raodF+pQPNQ8IHTq8oVHg6dqdbKv9ytlPL+TIaCvpapqfC6ZOyUMhHWTmBgX/UvWpphdZ4ZbIRCVDHakSdx5oZN0pNRXcvvP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR10MB4846.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(31686004)(6486002)(54906003)(6666004)(478600001)(83380400001)(2616005)(31696002)(86362001)(2906002)(26005)(186003)(6506007)(53546011)(6512007)(38100700002)(6916009)(66476007)(66946007)(66556008)(41300700001)(316002)(4326008)(8676002)(8936002)(5660300002)(7416002)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckZSMndhMWZBakptTTVEV013ZCt3U05ncHh1NWdIUEJXS2tYOUJkRE5CbTky?=
 =?utf-8?B?aXM0c2NnOGMvSk8wWDFPVGo5bWVpWlVRQU93eXJJcTNuUEdBR0FtLys5dnVE?=
 =?utf-8?B?Y2VmYXFqT2RNcEt3MkdvRFZVMEIwM2pBcDRPY0FFajBaK1dIOVh2R1dnY3J4?=
 =?utf-8?B?aURUVzJyaGFhMEVuV2ZORVcrYnJWaVZBb2tCNFlKOFFvUVBEbUZrRytmRmFh?=
 =?utf-8?B?amIyRFA2S24ySU40QzdCUlREc1hLZWFtZjkxMC9CRGEzOVNxU3dvUHluU01K?=
 =?utf-8?B?Rk1DRmsyRVZhSEhYVWtKQVdlVm5UN2tOSldlWmk0V2pxa2ZmN291bVR6b2tR?=
 =?utf-8?B?L3ZOVktQSVF5Q3lKR2dJS3NkQ0EzR1FmRE1kRzNrZitCZUVRRTZvMzl4THB0?=
 =?utf-8?B?dHhOaWZSZ1BGRmxjSTBQUmxYVjR3cXlMUHVUd2p4Vzl5TUlNYUIrRzJHa0RZ?=
 =?utf-8?B?MDUvMHRQNk91eGR6dUVETEF2bERJZHNEUDhoTTdrUFNhYkYxL0tFaXJnakFU?=
 =?utf-8?B?a2FTOFU2aGhOejZNOEVhNjBpNUFCUnBKeVk3N3FiOVdPL0xlV3g3REF3S2p5?=
 =?utf-8?B?SVYySFVpY01aWkQzQXhuZlBhbnZKR1QzclphN0ZyK2k0YWdyLzFJYXZzQ2V6?=
 =?utf-8?B?RE1ndHM2S3RMc05kVWZqTHo1K0s3NlVWMGhnNTgwRXI4Y2R2Ti9wTExvUlRQ?=
 =?utf-8?B?VGx3cGJtYkJUbVNUZm1BdWZlSW5NNkpVZGc2VFRjczljUk1aT3RCaEo4dTY5?=
 =?utf-8?B?RUxsd2ZuVnN5M2lrZW5YdFZQeXB3NWN2eENKZTVHc2daZ29KTjZMQTYyeUlM?=
 =?utf-8?B?UmZmTklaV29Bd1NLcmNkRlB6NGhsNmY4bUt4TWxoQkdxcnMwUXk0QVlVMG1y?=
 =?utf-8?B?UDQ2SS9ZOGpMOVQ5SlE1TjBldERLR2RlZzdKRnQzMi91dXN2ZHJTRUtjenRr?=
 =?utf-8?B?S0tVdisxb01lRGE4NHRWSFl3UG5OSjA1VDk1d2dYUEx4eDY3ODFWWGZmbVhm?=
 =?utf-8?B?ajNHNzJkNno2NWJJWDdjL0NlU2NuRnoybDlPcWdGbm5kME5aV2ZMTGp5ZjhS?=
 =?utf-8?B?eS9pcWpObkoyc0cvWGo4WmhDTTc1T0h4QTR1Rld1WExNQnhaMnYrOHkxcVNH?=
 =?utf-8?B?bDVxN1NCL1pobktiWmYwaU9DUS82c0IxZHF6Ull3eDQ5cTRlMGZ3TVJnYURK?=
 =?utf-8?B?UGdIUzd2bWJSdlRFYzhDMm42aUY2MWlQeDNhL2xQcHNLZkVzRnY5TlZLcWF1?=
 =?utf-8?B?L1YwakR4TWxsNkpmOVVoTi9YbExSTUMxSi9VTVJjSzhCVUJrYlY1eG9CZk5I?=
 =?utf-8?B?MWMrSGJ6OHNLR3ovaTF3N3M1RWlKTG5SRTdSaFVzVjhqNVBQQWsyWDJwbU4x?=
 =?utf-8?B?ZDFkT0VHcXNlY0ZOellVWklYc05QYU14U0w3ZDJZMHVLM01JVy83eHB1ZHBp?=
 =?utf-8?B?V3IzbFNZSGFJMnVDZVdkNFVjRDBtblFrQ2pSVlJ4UjErYjFVSmdWaHZyeWxl?=
 =?utf-8?B?OHdVaFkwR3lYWEgrQm9VckpKZGEyazJtcmdnbDYyMTJpUS92WVJUTWdEUSth?=
 =?utf-8?B?NFpCcVNqYU92VmVVSUJrR1dnNjdBYU1vSEs4U21mZ0lQUXVJamVncE9HVFNj?=
 =?utf-8?B?ZlY5Q1ZoR29Jd0xENCtxdGQ3aVJLR2hGU25iM1pJVTAwcmFCWkxkUWpKdGJE?=
 =?utf-8?B?S1BNU1c0N2NrdGlabEdzenFnZFV5d0JYK0NrcEJuVXhOV1pmQ3RnZ0VVS1Qx?=
 =?utf-8?B?OHNzNGRRb21McTZHODlSUTJoa3N5c2htOXJ3T3hIMFN6aW4zZzZHRW9aNEFr?=
 =?utf-8?B?TXdmU3RqM2xUb1dLM2FtSUYrckRzcEg0SGtUbnJMSzBqV0l2blY2eWQzT0V5?=
 =?utf-8?B?Rlo1cnl6cnFaNWNwRDRJMzZvWS9qUXc4RVpWSFAyVGZJdEV3b0lQb0syRER0?=
 =?utf-8?B?eXNBTGc0RWtTRlk5TlRUa0VmajdVOWxOb0hWZlpoUDAySmFJclk1Qk1MM1c4?=
 =?utf-8?B?RkI4RnNjdzRPTHhueDJ0c0ZJclhlY2loUzdZbXl0OW8wMW1acmJLTFdmSlNt?=
 =?utf-8?B?VGRRNHpuNUU1TjRJRnltWFlWSDh6RFFSOVZoUEpLeDNKdUpjeVZyeHpuLzdn?=
 =?utf-8?B?VzhsOUZBZmFJbmx5K3YvbXkrcDRYUFZIdjA1c1NPbFp6V3R6RzdyRnNmRWRT?=
 =?utf-8?B?c0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E15Lqrda8oi4sf8EGOkWO35+pSWClLaKPdbEG9ZLWDcrNcO5E6MiAIh/osHFuF4bg8IUm6Va6T5CqszB/njgKx4Kq01XRHlNdZfNtSfGv84Geqvy4EIKdPQ9hlH1HO6U0ltoXJPyVWGl8MUJOQWHgpt1b3g2kqBVGmebZJUvWcClcz2qci0ce/+w4zj/cOTtVOBEAfKtACFkXwa5yoeAtkMlc1r0W8PhZDxpGITT/XURZJWBFOdhRE6aTf5Qy6gKFGq5vdpYSFCaFqb9nJotMaOGo0MIzyVEFtRJrIynF0PKxkfM+3VjPZ6X8i9LnMtddoHDTsg44BT4o8GCE1YfxrZRsPoivAaN7qhKQw14aKhlvQXAXAOVaBH4ATiT/LsgPXAslgu8c7CbtbDmoS8/gjEvZD+ZP/a+gV0n6A/xP56FkZq0w+br64/Q46F1v5GnCI+gu+PmDHQWtalmKycYjCNZjC4IH4gDTGuQKFpuIuhMANpUc2zqthLYgYCHin49wqqL4rBa2cM6dl9nkABP52mvte88nqXVRHrCOL1i2f9DwzGDMvjpKmmHDVSUxYGiDXipjYOgSZxZzv6S4ASl877ujk+MmsjaGgqiT6wM66s0ZVTYmW/jxAw/wQ5awhvOp/LiA08YMgbbpHcC+0YPI0Mv/lcAaFnhBMmr8U4+zKXmVOWQqgwlz9TKWiAqew+Dkp4w44YBmvzhnNjgHOi9yMd+jKt7QK7eKnDiMxMCrNqkhxOWz5Njo9ThRwOhYtZS1AC6k93ZQPuWpxLmX4VzHhqR0trjX4vPro4+4yWmfwX8zJf8QK91K5x024dQYrZQsFrayrAq+q0FdaQwy9qGrhnxix3efcvy+6oEDtCtxCW3fumlfUVUdq9blqdYBHWha15uk7OVkAHEp8sRM2HPxw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d9cd9ff-a3f6-48a4-fb91-08db86b32d61
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4846.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 10:47:12.5186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVscC6PTepgBUTRoSLlK2YI5UpCQvsde5YUiWbMYemrLlbUXw9qUsx0DplaPZJps/sm3KY0o94iTPuL/niFaF1IQAKT6ow7b6z7t0l8n+hA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170097
X-Proofpoint-GUID: ftqGMIQxYzBYZ1JqeYCMH5UYfXZwMKa3
X-Proofpoint-ORIG-GUID: ftqGMIQxYzBYZ1JqeYCMH5UYfXZwMKa3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

+Peter, +Jason (intel-iommu maintainer/reviewer)

On 15/07/2023 16:22, Bui Quang Minh wrote:
> As userspace APIC now supports x2APIC, intel interrupt remapping
> hardware can be set to EIM mode when userspace local APIC is used.
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  hw/i386/intel_iommu.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index dcc334060c..5e576f6059 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4043,17 +4043,6 @@ static bool vtd_decide_config(IntelIOMMUState *s, Error **errp)
>                        && x86_iommu_ir_supported(x86_iommu) ?
>                                                ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
>      }
> -    if (s->intr_eim == ON_OFF_AUTO_ON && !s->buggy_eim) {
> -        if (!kvm_irqchip_is_split()) {
> -            error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split");
> -            return false;
> -        }
> -        if (!kvm_enable_x2apic()) {
> -            error_setg(errp, "eim=on requires support on the KVM side"
> -                             "(X2APIC_API, first shipped in v4.7)");
> -            return false;
> -        }
> -    }
>  
Given commit 20ca47429e ('Revert "intel_iommu: Fix irqchip / X2APIC
configuration checks"'), won't we regress behaviour again  for the accel=kvm
case by dropping the kvm_enable_x2apic() call here?

Perhaps if we support userspace APIC with TCG the check just needs to be redone
to instead avoid always requiring kvm e.g.:

if (kvm_irqchip_in_kernel()) {
    error_setg(errp, "eim=on requires accel=kvm,kernel-irqchip=split"
               "(X2APIC_API, first shipped in v4.7)");
}

if (kvm_irqchip_is_split() && !kvm_enable_x2apic()) {
    error_setg(errp, "eim=on requires support on the KVM side"
               "(X2APIC_API, first shipped in v4.7)");
    return false;
}

