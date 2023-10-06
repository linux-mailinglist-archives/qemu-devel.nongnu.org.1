Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628437BB36C
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:44:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogQv-0008TY-Nh; Fri, 06 Oct 2023 04:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogQs-0008TK-U9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:43:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogQr-0003XD-6E
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:43:38 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3967ruQq000665; Fri, 6 Oct 2023 08:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HTUF/geXvd9FZ7rbq5vpK0NwZFUHme9chDjSDizRe4s=;
 b=WYrzGYRJpYm6wZFwDXu4HMcAoNw6MOIn01HjRZ820H4ePFuRZGj7JtiTWxSmO0wY7WVs
 6N5W3DJgpumLCTibdHMIdiTFJ/PZ0Yifg4SAeyjqWaUSwImdZPenq4/7NnQRSgYwMaue
 0wPmc88ujmq8He6TXYUTv+gTckVYECx8XkVIUdMUcX1s+NdvO7SIaq4/Rtw2vwSS157Q
 ANm9hLbLcyRxHTbc7eLo69PMegSfIcizPgoGI+jXT/9643UfEYWvg1LSWZnGv71CJ0yv
 ix4yXGQyuAx2iK9qbSgzgNS4ReFDQMeVKR9GQLp49GJcBnTkRE4D03JbkHxC79XyOQY8 pQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea92be20-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:43:26 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3968X6SA009656; Fri, 6 Oct 2023 08:43:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3thcx854bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:43:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elZjj9UpBahbSEqmrJmo1W5+XAIDbkUf0mGjRni1KYwnoF4ZpmAaVHMStWhuMBMplJ9te6TdbKWWoRrNuk5L9lislUz2LBrHVltpMk3LSdBf0Xo59ZfsqzorlyQNN+IyqP5OiW2oAnxqw5f4G7b1JBcsvZZVTGKUcdHZ4XuMhRm2Qoz2sOWzmdXR/QHgTisXdPh0hjxAOjQRHm5MFAVGpIqOq6Q0lmOGcNZHV0j69+bEgqDN+5hjt0/LX4IBZvrytx9jxJVhYcxzIFvhMHOgtBqHMDutw91plLz1ayCsElLnC33oYKEiRj+FW/HCfKGB/hG5cRod56j4/Eow5QqlbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTUF/geXvd9FZ7rbq5vpK0NwZFUHme9chDjSDizRe4s=;
 b=Ok6s+jbyyfDp3Du5x8U7GgFXEKauG4Bu6cf2G6YnXyOGh5i9xF/voOplzjSCdrxY08c5NQSqqbwtmtFuFBvvW0yhI+cUj4MhVBRW+sZle6/W2bx4kRBXGm+VhvDwN0Z01RoeGbk3ysY/VusmfMeu50g1O1e5+jndQUVUy1dgT2GDtYqwptXN+l1F9G8Fz+94Aa9vQEhEzOY6Mtrgu+goW1mx4SNnJOCgzWGn25WMqnoT5wKh37trqc1SXty/4migLcAxfHwrGeXTTK9BGpZwZlhiUQNjRuHTDqgMh8OtK02HrKEtVnH41WXCp0+HJ5Hix0Pz1X/W+eJddZXyvi4yuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTUF/geXvd9FZ7rbq5vpK0NwZFUHme9chDjSDizRe4s=;
 b=qEcx8tvW8avmo14rxe7/93wE9FYyDEmtASRLxxaafxNAMsgtYNRtms2DVFVEg3eN7xT2HhVRohfvpdg149EnrSuIL9dwUm58lNjXSJ+I3eqxWz+xV/ILbSNJcuhW+mUSolHLTg21moxeDVN1wAPJw5EKln+VVWkGX1akUY+jf34=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 08:43:10 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 08:43:10 +0000
Message-ID: <59c4ad2c-4638-4c20-a581-7e9590c224cd@oracle.com>
Date: Fri, 6 Oct 2023 09:43:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-11-joao.m.martins@oracle.com>
 <d6787c69-e66b-9e09-2efd-8f60129f0ea5@nvidia.com>
 <2cca62e2-6b16-9736-d015-15883ed1b02d@oracle.com>
 <b68270df-58a2-083b-9760-c16ab04ad8fd@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <b68270df-58a2-083b-9760-c16ab04ad8fd@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::17) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: b57e4a11-0a14-4162-c609-08dbc6484518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T5ffyisnpn74rKZIESLuSWpgJoOvzeq/lHymQLeCwmVyi88S1EzDgPke5OSLiwqyHadTzOFBLXwKCQiWqdpU3W0gCZQ0gS7mZI7qIVpUaZIyCWDOWVN2zwUny5KgBu27m7zPbeaRwz5BCnbP4TCth5ILuzSlC0IUcAlu/7HTQ51bT9F3sO8wH7WOYXT2tZR2Oe7w7gohwhfn2iDY6cswOrnVNkg7R5uWROiLfJrPLy40u62Apk2CuBM3Jn4hMMu6d+D2RSaReV4C9ECNwmpT6Ob/h8OH+KvCtLV/pqPZMlbpYuwrTL7m59Ugkq6a5nbeuUbuWF9IwT2Lm1615naehy+7Ma6Tb+dRJtHbKVZ/rl6gowOeY5S2b/AS0NobNdpOww8g6A6zkB6dG3JRz1+EphdYjHZpLQ5X247/pDUu2VWfCfJ/cit3HQAtY0ZKDmMovNIwqxOQU+vazO9PQYf8ChXKkEusVyh32PzP4ZlUBdnOGUuY0J44F5LPOMVQM09ud6EWK9kJRewHZCk5ouJy0b9ccfi1xjU/Sjge6xVpSJrzXon0vK5/qefRMyk2Ol6t7NPzAFiu7zbmwNIym4Z9lfMP5nTQv+eAblKc4KkIk0rMZ7reQ+YVvsTvIP3s2yw5bnYtCBSbwVqN/9hYM0SpVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(2906002)(7416002)(86362001)(31696002)(38100700002)(36756003)(316002)(6512007)(41300700001)(66946007)(66476007)(66556008)(54906003)(6506007)(110136005)(2616005)(6486002)(31686004)(6666004)(8676002)(8936002)(26005)(5660300002)(478600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUpUQjhkaEtLcUpPRnNYbThKblIva0FaRkhNbEFFQkEyb3VCTXgxdVZ3STBr?=
 =?utf-8?B?YzFXakZ6N0ViekxnNVVTOFVkQWk5QnpJYndINUxWb2N5Y3Y5SGlESTQ1b1Ey?=
 =?utf-8?B?S0lBWFBteDlUK0lWVzIveGRVaHZrTVdYTDloY0gxNG5pS3c2YlpjdXhUTTVD?=
 =?utf-8?B?azBxcjZJcTBZcVc1L2ZSUVlTUkMrTVBrcjJBTlZ1V3kvMHRzR2p4dzhjbFhp?=
 =?utf-8?B?RmpqejN4WTdDcDdqZzVLVy9TNGJyanJKZVBGbkpGNXZaTk1pS0dGTFhnb0Nz?=
 =?utf-8?B?SDBZTm1ZRk5qUWRnSEVMeEEwNFdWSHdzQ0NmSVlwR1l0SlhERUorOXVNTGVQ?=
 =?utf-8?B?TTNhZFdUdnhhODBwbWsvd2dhNUNCSDdjYVJDVzZjTkFwUlluSytuUHNvcWlN?=
 =?utf-8?B?Q2QxNUM5T2hjMzFSUzNsWC9xN1hmZWE3M2ZyKyswdDNXQzEyL05QVjhRcXBW?=
 =?utf-8?B?K0g1azFkK1BxWVZ5TnhqSWFsR2o5RTMwYnRURGRjdDM3MFhRRW93bjVsUXpj?=
 =?utf-8?B?bUNvRk5xdnkrcHBiV04wZElPUEtzWDNRd0xOUGNDNG9DTjBUMjB2ak1zS0p6?=
 =?utf-8?B?L3VpZnVoWmUra2tCZ1FxZnR6cXhISkxWa0lZNzV6bXJqVmJoMnd4RXhWM2Vs?=
 =?utf-8?B?VXVGNGVXWFNGS1pPQTBPQ2doam15cGJmVDdERHp2eTNtTmZWTTgrWVBKeFh6?=
 =?utf-8?B?a3JaNUxHeUw5NFdvcDQyUUxsbGFQc2lxWFZGM29rc0t6YXJBUW1ZVDlEU000?=
 =?utf-8?B?MUFoU1N5cHRraEQ4RnBXTTNMNDhpODdhWkx6RUM2SU41bU1HQVNGSHl0aEJQ?=
 =?utf-8?B?WEpJUDNFQVBtTXRCWmJUZS9oVk9kRXRyNGlWY21QUEhKLzZZWE4vSThkL0o3?=
 =?utf-8?B?ZFpCN3NYdnRUUDJxQmwwUXgraFVkUVlpcUxyeE5MTzdZeVEvRGxsbzZ6Q1lL?=
 =?utf-8?B?NnJsUGRWOWR4S0dodStDYlRxMTd0KzdlNGUvRjBmVW1pZDl1czdVdHpSdy8y?=
 =?utf-8?B?aFRqdWtsb1ZGYjRaNTIybFE5b2pnZnJ3b1hKVDlNbTl6N0l1cnE3eEtqdERr?=
 =?utf-8?B?djFDUzRnZWxCMWJqczRuelZtajFVSHZwMzN3b2swS2FKRERZcFlMckNZb2Va?=
 =?utf-8?B?aExlZ2N0UGE3MGdNTGxUbnFTTjU5VzU1R0Judk9LRmZnZkRxT1NjMGxxajM2?=
 =?utf-8?B?VFhDRkErQTNLY2RYLy8yVU83VGhicUIySDFmMUp2cjArYktMelNtZy9zTHhp?=
 =?utf-8?B?ZExMZkRrM2xUcW5VWmtVTm11REY4YmlBUjBZaTlKS3o2ZjV0Zm8zVkpBMTR5?=
 =?utf-8?B?Q21rVmN1ZnFGa3BqdHhSRjFlejlkZVo5MnVZMG1lLytBcVZMa3BzUEJhVUpE?=
 =?utf-8?B?UHBZTVpXYmQ3OW9XenVEREZUbU5vVGM0ZjI3L1dTTXY5K25wUVV5MG5WTzhK?=
 =?utf-8?B?Q2dsL2d5eGM0WDM2aU9va3FIbmZhTWtRRmhqbzl0TXB1WkNiYlEwYjhuZER6?=
 =?utf-8?B?MVpkcHdJY1BvNnNiOFpJdGNtWkpidFc5Q0F3MDJJanBsU1Axc2s3dnVCVzcz?=
 =?utf-8?B?WlgzVjBtcTNsd1B2ck4rRU8rSFk3dkFBUzQrMURSV1ZUL1BJS2I0UnRZaDgr?=
 =?utf-8?B?dHNWOU4vSnVTK1M1aGkwRWpTWERydGh3RDF0Q3l4NFIwRnRhZVp6dWNEWWpP?=
 =?utf-8?B?eE5DU0ovYkRSQVVGWG1reTdsU1F5WUw4TzhnaWw5MEdLVUdnMXdZY2ZEc2Nn?=
 =?utf-8?B?U2k3RkZ4cFV1dHpvMEJsSUlTZ0kzV2dDYmN2UzdxanA3SmlvZ3BOdVh3N3Bp?=
 =?utf-8?B?Y0t4SFBzLytmUkZWblF4OWhSQkZuSitRY2x4SnpPV3JpcE8rRjVLTk1YanVO?=
 =?utf-8?B?RS9wTE84Z09iTDBDWmhYQ1hlRDg1S1k4bEdxNFRGZ0RMc3BxaWJzNEszTXpG?=
 =?utf-8?B?TnV5WTZOcGhCcFVkYmMyRkxKSlQ4MXNtVXhSU3BEbUdjVmFhZ2MyS3FXN1dL?=
 =?utf-8?B?YkZkcXpTOUwyM0V2YXoxT0RSL3BQV0pMOEV5UzFEbTFSVzMzQS80QjdrTkEz?=
 =?utf-8?B?Tmoxbis4QzJqQWRidmpTVFZCVnRNVHprRnJqcjJGLy9Janc4cHF4Z25SSnlK?=
 =?utf-8?B?dTBHUkdlTWZnV2pIZHA4T3pFcjNBVk55bDhINGs3ZW5GMmlBRTBYVFBrWkxX?=
 =?utf-8?B?SXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VZ+btizFzC+jGLsDdqs3ZFTOMDEm4ouNHnN3iFs098gP/BOrNq+LVg+AkX8gNI0J6Tfg1fnZmTQ/qCyvjWfCRxECP8ppwQJXm5rJWa342TVAu8kQcQERog1aMM6MgUHH+upere7pBSwUnbZUNXOb2j5Q7eHzfgbuIDpua6gNU9yAfFFOXeR8w5kwXvn562hu5OcKoShK+UCD3FvlRrx95pi76dQgSkXOYhN20Oh6EBcAkud5E9/Q7OYFPC5MvKWVi/fXf+UP5jE6ROibwqUF/J06zWak/q++aep8NF8bl+6kNEPUmpW8Za2wMYU2uwg/pq12nxSYniaQU+VWd+ceX76dG0PwWbFTQ40wGJ1c+YuxBluhpjTth1SHBd5OkJtPcb69O/P0Lywt3daTXiQXXK/lSHG7GXUL96CpmY8GT2A51p172rh53dHpamUPyLfaH0yQXsUbAOznzedU/V/MZBAyy1kXRA+6aoR84H21wemKY7KXFbolglawprtIBKHu0eyC5EBXpVIflL8orCLKhUJyafTbZuBgqB6yr10ctgnA56Su2mzmGf/6JDdmreJp1eQpUsdXww7xtEtDxUH48Ctw4FiYcTv+RlBQqsOma/96JwhDACNlJ3UvqJKl8ybMdsJQu/p6EPdFE3wy6NXn3DA90lCk4NUYk+9f3004cKTmVRnbDeXXNHlpwSNXBdR9k2YPlhqfW2a5srEjBchPJWga7Qf+H4jw8QjCkAZOpmDqp/qoDwoZMDzoQP+5zAGDvPRE3pVRVASIPd595PzR7NIL6ScVa/LTdQessj+i+SuZT2J3xSOYTirgh47hhSUDJP8iuWpRyi0kXuX7Y2oYf80w2u7BUSL87wiB1dktzLPzX/w3p1yKLxPRWFDUXkbfYPRC4u1GUiNRVetx70hFDA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b57e4a11-0a14-4162-c609-08dbc6484518
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:43:10.5285 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LF+hS76YsdNSu2gLnhryyTlZ0ZhHLQ5TbxHZZHHkDmNCo1mbNp8mlNrNSDem/iYicShMDhWvLt3G+t0YO2n12v8MBryzP+VQ6kII/8oqI7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060062
X-Proofpoint-GUID: XUdknMhDIhAQTLbfY4eNgHIzlSXNGXUx
X-Proofpoint-ORIG-GUID: XUdknMhDIhAQTLbfY4eNgHIzlSXNGXUx
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 02/10/2023 16:42, Cédric Le Goater wrote:
> On 7/10/23 15:44, Joao Martins wrote:
>>
>>
>> On 09/07/2023 16:17, Avihai Horon wrote:
>>>
>>> On 23/06/2023 0:48, Joao Martins wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> From: Avihai Horon <avihaih@nvidia.com>
>>>>
>>>> Implement get_attr() method and use the address width property to report
>>>> the IOMMU_ATTR_MAX_IOVA attribute.
>>>
>>> Nit: get_attr() method was already implemented in patch #6.
>>> Maybe just "Use address width property to report IOMMU_ATTR_MAX_IOVA attribute"?
>>>
>> Yeap, makes sense.
> 
> I would merge with the previous patch also.
> 

OK

>>
>>> Thanks.
>>>
>>>>
>>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> ---
>>>>    hw/i386/intel_iommu.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>>>> index ed2a46e008df..989993e303a6 100644
>>>> --- a/hw/i386/intel_iommu.c
>>>> +++ b/hw/i386/intel_iommu.c
>>>> @@ -3876,6 +3876,13 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion
>>>> *iommu_mr,
>>>>            *enabled = s->dma_translation;
>>>>            break;
>>>>        }
>>>> +    case IOMMU_ATTR_MAX_IOVA:
>>>> +    {
>>>> +        hwaddr *max_iova = (hwaddr *)(uintptr_t) data;
>>>> +
>>>> +        *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);;
> 
> one ; is enough.
> 
Oh, spurious one, let me remove it.

> Thanks,
> 
> C.
> 
>>>> +        break;
>>>> +    }
>>>>        default:
>>>>            ret = -EINVAL;
>>>>            break;
>>>> -- 
>>>> 2.17.2
>>>>
>>
> 

