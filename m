Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAD9717C78
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IX9-00013o-7E; Wed, 31 May 2023 05:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4IX6-00013M-71
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:54:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4IX2-00044z-W9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:54:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V9qL3h032011; Wed, 31 May 2023 09:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=GqGxerBZzprnlhxm06Dft1ZLq7h+gVpf8A5oW2dcuwQ=;
 b=dy8Azz12t4TwM5cj5yGfbXFPsssjXYrqCiXFGql9+UyOcp+G77F8KUmvXjTEVLI5xQjA
 Nk4Nq7+s4Pn65cBxKfbEBDFXF+ij1r0/MIb0hUDZc8hX3iM98SwvUpzs+ftzXwqXZGHN
 hJMlnbqYAFrFPK0zRLUwr12S8po382lJb8RKbJxTIC1tQJwO2Tu9swCErBAYbEbi7TG2
 4OX95RESCB7TfZntM2YuTGG/qgith4w7vyHPqxDUxIuxgypfKynj/fbxp8gnB1vJpDkh
 QPngC4CkJuURLoPu7cOn5oeYAfPKZ+3rgYQDWW6Nm9K7JIkRrirpIc7mfOnO5drC0jVR nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb95c3t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 09:54:11 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34V88ohK014592; Wed, 31 May 2023 09:54:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a59nr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 09:54:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsZdxQUi0Cq5IYi8h/ibzVTE3ZzbXfqKiCYdqjwEG5/UlYsoyU48j0RNn4L8A+NKXlq9NvMLxlzCxnuUS//39nvl5vY5pavJeuw9FQb6T8733uLCZMYmt8Dqi9s2ce1yd3zRAIibvvf49jOdnnmdbeGSPLMv274cvp0x/Y0niGi2R/2PwaFo/EpPqLgRP531A5wWW8co61g4QCagwZneKDJ9sydsyp2Vd5q9oGtq7dAxwgnWe2248bUQuKJlYg/d8UXx7TaLJNpoTHNTGVE5xQ/7B4DQ9R1oXg1BWaeFx4D0qJLGA19uZHYNHRUqCWucJsyui9aIMtBfxmAM2BVv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqGxerBZzprnlhxm06Dft1ZLq7h+gVpf8A5oW2dcuwQ=;
 b=WoGhLUfjxdOlDc8hTqYMcOi+sva8kFggnP3SyH/k88u5Wi/eCZfXFyKR+AA8jbjI8rzbc2gnko2BKz7qEG2vroUHSTySqidgBJ7+qZ+/WqV59dXDoTwWCkv013xCp5OKO970bu8ZQEeXgcPsro/KsRh9gake2cVNpYsUcY5q9Y+Dolw7VE6ULgwbxAVrqeIcse1zIsM2Zlec88qDJezeLi+tSGp7+R8beYENCOKf1oiVhIG1HPqgVxPbjwksum+qGlRa2X21sa/tnwwlZFvHy8ZNorcU6/l8DZSwTXpVaPE3tRH6xHBWjYHDmeLYM2cZdZQenFQ7TzagO7OYn+7+Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqGxerBZzprnlhxm06Dft1ZLq7h+gVpf8A5oW2dcuwQ=;
 b=ss+nYAm2XwfZyaMW2IZ3pmVs3RZuiLIjALA6uXldXdoTXkWQYjJG7LTv0rT6bn3tVxjmPT1BIYT5vZo8ZnWSdoo2jz7j/Fy1o5CfLMioCrgj1g5P5grIcW1l6bVVumcPfqpob0LvyBz2BcRsI9UipKvIq2QwDFcbsB+BP6MIN2A=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by PH7PR10MB6201.namprd10.prod.outlook.com (2603:10b6:510:1f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 09:54:08 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 09:54:08 +0000
Message-ID: <5c018403-f6fe-12ec-1c58-7dfa6abab53a@oracle.com>
Date: Wed, 31 May 2023 10:54:01 +0100
Subject: Re: [PATCH v3 10/15] intel-iommu: Implement IOMMU_ATTR_MAX_IOVA
 get_attr() attribute
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20230530175937.24202-1-joao.m.martins@oracle.com>
 <20230530175937.24202-11-joao.m.martins@oracle.com>
 <20790526-6640-3fd0-920a-ef09e5b306c0@linaro.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20790526-6640-3fd0-920a-ef09e5b306c0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::19) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|PH7PR10MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: f825d7e7-eb25-4de3-5799-08db61bcf9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIGi3EZF2uobDGM9ODna01bkrmgmpDUVo4cJPHaFv/av2tFSDO75X3cLJE/71T0ETTcX5LIMzgzJPHqgsuMrb0+ICyKcXxuy4U8zYco9Mlt6DTau1L5IiNqIdeR4yIyLTnZbV/3yTrA1PnuYD+kL6E24rot73MgxyNsOzRyAxST40+J03wOlIcVTGddVWXlHIyQjUCVvK1pk6Svxmsz0U2jcfXR3i+2IBRIizSB9sr2pXb6DQ90Oz3oyAffAOCe5ijzyhg15oelEpfCqHyk5owzlAzkKXszUfnYhV+2pBPAqiPk/rCievJ3GzLvrxiKlZtL8NYMkChWK1XclMyK/sbWa2Jwzr1G2RicUae84vd2e6FHLxYTDNKAd9IsdNcahz8F0tNquOqDKiWEXA7NuuRw9OvzJ6k03eGekm6zk7TxiujAgIge+66W5t7tn8HkxccK++GovOBlZoIu53BwhyGE5kct2i9OjFPkhmCFYXpU1lFIIsbRUu5SrPWg+aI+NG34X3F6yW4tuAUu2gr9YiU73Tsed8TaPBztyIBYzXRgCQbTBCCbQ/0fiUKzK/EIegHeIrY2FbKBKe+fD8m7O3DIl7GpVkWb2RD80bN+nX7gdaqkOOiwip94ynF89eBc4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199021)(26005)(186003)(6486002)(53546011)(6506007)(6512007)(316002)(6666004)(2906002)(5660300002)(41300700001)(7416002)(36756003)(8936002)(8676002)(478600001)(38100700002)(31686004)(54906003)(4326008)(86362001)(31696002)(2616005)(66946007)(66556008)(83380400001)(66476007)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDZCalJkYm9UVm5SMmw0Mk5rYkxCNmN1bEw1Nm8zL3l6NHlzNTRGZXdveXJT?=
 =?utf-8?B?U01MU2JqRXI3SEVmYjh0aHIyNmlqQzNNY2dmL082N0tOdm1CbTk2ZFdpeDZE?=
 =?utf-8?B?cFlZMGJtRnA2VXlwMFlsV2g1d2JGNk9tWHpJTTN1TndwbTlRb2JQRVZkWkZD?=
 =?utf-8?B?YWdCZk55L3k4enUrZTZmV00vQ3IzdlU4YjBqTUZzVTQ1MGs3Z3hocEJHMW51?=
 =?utf-8?B?SStvZzBmMTJzL2lQL3NNMVVTTEVJNEpWNGJlWVNPb013ckorOCtPYTN2bjUw?=
 =?utf-8?B?ekFsNjJlM0laY1ZiMU13NUtTTWI3L3pnZ3EzL1ZGdGp6ZWpaK0RqanFBNXBo?=
 =?utf-8?B?UDNqYWlTT2VTakkyZmticGdFaGtLWDNta0d4eVkxUzVNUittWjZhaFRvWmUy?=
 =?utf-8?B?MzFBek90N2JTdE9lL0Q5LzQzcG1OZk9Da2JDQVhXK09IZHdKeldzTjg4V2Vm?=
 =?utf-8?B?T1RzMkQwRERPeDVsODFYaU91WDBYd1dZV0VUUXI2WEVjNmFRZXFjdStSK1d3?=
 =?utf-8?B?bWR3S2trTUhBOUJ4cmZSeWtQSEZsMjQrSGNsNk1zbVRmNjRvYm03KzZGMVJN?=
 =?utf-8?B?YldUd1lXUDIybEloZHVObC9wSkxsUDcrUjRXd0hkbTJmZ3VuWm03MmJXeVU1?=
 =?utf-8?B?bUU1dVVkQTQxZkdhdTFUcEVPVXFjWWFTNjV0UHRpVktEQmVPYWhEWUliQ2NK?=
 =?utf-8?B?bWhvQlJzZ2FZZytwY01KN3FuSDBxODA4MDZqOHNiVGM1Si9vSXh5V0tiajNr?=
 =?utf-8?B?MFltdzRsU3lwTEk1SlRGRjZDTy8wWDhGZkdKelEzMlFzOG5ta1Nmbjh4cTBS?=
 =?utf-8?B?TXNkeVl3QUVDTndib2thMlJENDdhc0dNTDZNbDc2OURiQ0RyMjNiaXVrUkdy?=
 =?utf-8?B?Y0p1WVBjdittNFloR0ZEMEZoZnlkaVlyLy9yMS9nSlZnOFNYek9WSVpEakh0?=
 =?utf-8?B?cWN0NmIzSWlrZjlOenBjNmQvNVZLRVRTZ29aU2c1OGJRZ0ZEK3NhNDJVdjNy?=
 =?utf-8?B?cHUvUlhDUVhYNXB5SlNVOUg5UXE5RHB4UTNpcnFseWNKcFdBdFhQazdhOE03?=
 =?utf-8?B?cUM4UFpOYkpDMjVFT2RsQzYyLzhPZFRzTHVSTHZCbG5pczJxZ29MVWNvcEVZ?=
 =?utf-8?B?QUk3NmY1VDVObCsySm96Z2VIdVNqM1lkRFJRaXRyZTBGOXkzaU9tRHpERi9w?=
 =?utf-8?B?ZjI5N0RRUTI3anRQSUNLS2o4aGlXcW9yM09TQXdRb0M5aGNxcTlaeFBneGpR?=
 =?utf-8?B?TEQrbDIvaXJRdS9DWWJMVGIrL3lyM3lTUjNEZ1VmY3E2bzVTak5sc0lCVnov?=
 =?utf-8?B?Mk9aYldRNFR4cDNxOVA0RE1XTjByTWw5VEgvRXB1RmNBbjRmVFpXejhqOU5B?=
 =?utf-8?B?alJ5R0hCRFFhcUxYWHJURjgxRzYwVjlnT0dNQlJqR01VWlFuRUJNbjdiTHZC?=
 =?utf-8?B?dkNLcjdNSmtuLzUwM0s3bGxraE90NVdWMWZNaFRHNWlPOXFpT2JWM2xtODZx?=
 =?utf-8?B?LzNBbDNrelpvbXI1bnhvZVlON3VqT3YvQ1J6a3o2MU40bUtjSWhkRUVuRTlv?=
 =?utf-8?B?aGlMcC9XQkRteFVXbE9nTndkVTB2Z1Z1UXozVnNtV0RpWFF5ZkZoWkpYa3M5?=
 =?utf-8?B?Y2hFVTNPN09yeWFVbE9wMTI5RVJLcnN5N0NINnh6aytVMExQL25MenNtSEs0?=
 =?utf-8?B?MllIUnFNNDRpSGN0U1BmVTJLb3c0SGd0WWRQSEppMm90dGc0WC9MSE9DTUI2?=
 =?utf-8?B?aWFSVkZhSGJyQmI4OHVHSTRiZ1ppNFRNRXJYU05HcU9IcDkvQlp5Y3MxTUZZ?=
 =?utf-8?B?QUpGTWh6bW84eStKZitQTVR3Z21Ia2x2emdrWEt2dnl6bFlVc0FHaUlXT1Rx?=
 =?utf-8?B?clVHUEhJalY3WUNuOXc1VUxWWUJHelZ6TkxVaE5WVlA2RHlLWWVxMG1QRTJM?=
 =?utf-8?B?Mi9hZlBHbHcvWDEyMFNJRnk1U2MyQjdFOEFhV1I5alorRUhCdG5JQ2dnbTlx?=
 =?utf-8?B?MCtDRmVETi9NeE5yRjNDUGN3TkNjL0pUZXRFWnM2NytZOUIzSmxOTFlDYUkz?=
 =?utf-8?B?a3hIWEUwOHoraDB6SnJyNFBVZjl6U2ZIMzUzSlFIeHBETzl6UlZSTG1oUVY5?=
 =?utf-8?B?c2JHSW1zQjZhM0ZqSWppZUZFNVJFRUJGQjVTZ2srNTk2NGgxSmhlTkxsM0U5?=
 =?utf-8?B?SEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dUITG5exkxfKo+NGKcSlISYgN4rNDxJ9k8tkj1/dEXU688o5VivPmh6aJF+ujIKjCecgE3xFmbT7CecPxkqY4u+lPGV+BzUMcyTtGY655AuFgfeA0h9TOf/UrLDWghsHLFgemQbuduHvPPUJg2ZVezd4qFdbrTAfJC8VMgQRcx60++e8eF3gvwQgj0RhL1H9p4SlJBLv5pjVoMoRxlQhHTebX+Lp+l8MxXCD9WoCViyNjUYYqbQJE8cmmkig1hyIN5uiP909Qlu6UBKmKhq2UurBkYv5n5h85rTBQRvU9i8ymKJsV/8q2BpQ9FznRStuup8DfEoSGH1DGuaQbObhlyL4+9KuLiI0+GtvvfqRhyaJcNpBCTW9Zhya8GAjKk+Fr6W+9M9lwNgmfVgjEiIsIdT68Ks9H7TLCZh9iRRrHJw16fMz4Xvj/EKl7ZNsbZQRljC/7pWCaksm8nTT6W7BTKvlMGcIuhF8XlxQXhFLUjtoZKMH8i35OsGwERHUUIIuTOoWMFGKHS+Fae0CDOwqgcZmNwA921IdsB3Lj8tvH1uaRyw1kilPAqNhf9Um9IsYS9vKlx9hBQlCLlpfhST2g+HJb7pKy+jTe9MnofQZmkX+t+A3E8q40NstW/ron1I4l8tuf/oJindH0kCqXe+FGqTKDuRJ3LGQjQBKfyHmNxT95R8cE6jnENQKiSFoYgGVv0aSBRU8XwJEdvk6EGwB//zmqcflUUl6rKG+v/Kf8DhUItIEbuxn8rWSQs4MMsV/yxExEMB6T+U0kPH7MrjEpFZMYTadvJ37QS4ABHIVya7Pv2x45ijcVwAVk9J8Kw6BRDFNZtohskhACH/ysDqZuhs3Z6tQ1WMcewD0BO5DGXtVpcElLDOVghEUCfSuoLV/xvE6f5mZkgHRfuWJtUNNKw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f825d7e7-eb25-4de3-5799-08db61bcf9f8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 09:54:08.1047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7SuQygdTmsuUaeBzkK21LfNfdDPX2QeH0zmXJdqk15miOpcG6mpx+KDP2AWd6+waRkP6hwSHQAHPaX5qISRvmkm9Y/S6eXZoMnCYx4D/Es=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_06,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310086
X-Proofpoint-GUID: iqbuuqOhzH0iRGFxjed45qd6OauJrEPV
X-Proofpoint-ORIG-GUID: iqbuuqOhzH0iRGFxjed45qd6OauJrEPV
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
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



On 30/05/2023 22:45, Philippe Mathieu-Daudé wrote:
> On 30/5/23 19:59, Joao Martins wrote:
>> From: Avihai Horon <avihaih@nvidia.com>
>>
>> Implement get_attr() method and use the address width property to report
>> the IOMMU_ATTR_MAX_IOVA attribute.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/i386/intel_iommu.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index 1906f3a67960..829dd6eadc6c 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -3876,6 +3876,13 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
>>           *enabled = s->dma_translation;
>>           break;
>>       }
>> +    case IOMMU_ATTR_MAX_IOVA:
>> +    {
>> +        hwaddr *max_iova = data;
> 
> Shouldn't we cast to uintptr_t to be safe?
> 
Perhaps you mean something like this:

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 829dd6eadc6c..479307f1228f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -3878,7 +3878,7 @@ static int vtd_iommu_get_attr(IOMMUMemoryRegion *iommu_mr,
     }
     case IOMMU_ATTR_MAX_IOVA:
     {
-        hwaddr *max_iova = data;
+        hwaddr *max_iova = (hwaddr *)(uintptr_t) data;

         *max_iova = (1ULL << s->aw_bits) - 1;
         break;

I guess the thinking is to prevent 32-bit failures.

>> +        *max_iova = (1ULL << s->aw_bits) - 1;
> 
> Alternatively:
> 
>            *max_iova = MAKE_64BIT_MASK(0, s->aw_bits);
> 

I'll switch to your suggestion. Wasn't aware of this macro :)

>> +        break;
>> +    }
>>       default:
>>           ret = -EINVAL;
>>           break;
> 

