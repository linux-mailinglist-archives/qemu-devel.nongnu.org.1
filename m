Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14926717C33
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 11:40:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IJW-00032y-16; Wed, 31 May 2023 05:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4IJQ-00030y-N7
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:40:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q4IJO-0001MK-5j
 for qemu-devel@nongnu.org; Wed, 31 May 2023 05:40:12 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34V802a4032435; Wed, 31 May 2023 09:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xyTf23x13x0owF5EGWyjXVKEwn5AKvzcUHu3Nh+3UVg=;
 b=OKoEP4Z09owt71HU3LfUJNXzAvgRjErQERv7/7+LXBugoX/822pPwN9Sx8agiZOrCilm
 0IzL1bXFhly91ALO1qRCvc5psYEBK8MnU2pB2QBORC5mH004sAOBDdBGs2TWIM2SAQ1Y
 f5tODFEihbL6f4LZC1ELRQVb7HHpgsoBKgkEa4/ue9wdeStuhRJNDHhhneHdEE12aC2X
 7ULB32MCNpZ2u0Wz4SzVJdmm4cj0HjkkY/y1wcEbxk9HtPxHUCuSUgKsLZdVzYlfKpjy
 1WjNWPYXVLDq2tiBehPkfquE8MOL8yFUeFfVsyhN+8J4KaDVeRy4HqYTcAHhXIusUqbS Gg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhb95b8f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 09:40:02 +0000
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34V9cUw4014665; Wed, 31 May 2023 09:40:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qu8a5967h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 31 May 2023 09:40:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZe/mtg3rxcAVykqdjeem6oaDQ0/4iP3uAbsnnlh0NKHrV3qUgSTjVM52CPveC4UWn4u0qmf7fio+IYe4P6PpiRg8R5pWlimQYLf860qh6HY8bwfBxCFImkdpmCILecpemJUYuh/3SeoZuXpaN6Su/ktDcZ2sQoPqt03JF2tMV1oleYxCQ+SUmEB9TCP+rL4rEhdr5d9t2E50aOSWk13wRYWq+nm5YzX5hek9OPrU5dUu0O7Jrw/yEMBJFllln8+k+h4LsVSxlgDyvRagrM338Bcu4hP9yd+ZHDO8WSXxg5oAHoiJhx1D5qkzvLYCzDRavIe8CnfGjjyvm+Iy4/2qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyTf23x13x0owF5EGWyjXVKEwn5AKvzcUHu3Nh+3UVg=;
 b=ArgT8wgTerY4MuzBnqPJGbq9JP+yv/tSK6RrAr0GvGTqSAfOVpN2GJ0y9uBcgDoE2+RtzwH1A4FgrEefM7K+8NVxxQBYJPwdXWotjHh6eyHo1t0mPmkWe/36jwNQFYN7ehElEJRw8FyXd6k4PFFgsV7L6MwmL7ygnC/Vef+irBq0zNZsfKtLckAoI74ovSMdmnJ7yBs+ZtTVDfUYsmHmb9r1varIp2igLr1TNXW5Wu+c5ETlxIDIWQ5WaIOd/100Gin/Us0E62HGrrZmu2qshfNdW93EtM8NpXwS/gE9bIZu08lii5uIHDntE/EZ6KwUDvgWLGr+tzaWVDEmILlMvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyTf23x13x0owF5EGWyjXVKEwn5AKvzcUHu3Nh+3UVg=;
 b=CoU5pzXEntzCm0E3lCsJU0aC6FalfCqt4q05vlRQNgBa8BS4v5On9FvjOZVlGtWHJSMx8VMrfQEd8P9HdA+9OSZCoXqlun5aRTMLtamQBGOSFvHbOYwS1ShY0hU/M99Q/YAQp+JwVTtEpzr/bOe7ZQNq72qRGGAdRh8cahKmUlA=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by LV8PR10MB7774.namprd10.prod.outlook.com (2603:10b6:408:1e8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 09:40:00 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%4]) with mapi id 15.20.6455.020; Wed, 31 May 2023
 09:40:00 +0000
Message-ID: <be569fed-4a85-989f-4973-57e3e3b25219@oracle.com>
Date: Wed, 31 May 2023 10:39:52 +0100
Subject: Re: [PATCH v3 08/15] vfio/common: Relax vIOMMU detection when DMA
 translation is off
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
 <20230530175937.24202-9-joao.m.martins@oracle.com>
 <661455ce-b310-adbb-268c-3b0771d8bf7f@linaro.org>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <661455ce-b310-adbb-268c-3b0771d8bf7f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::16) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|LV8PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdaee09-7092-45f1-5fb1-08db61bb0072
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Tguttt7gg0s6di0TpHpxurS9ECdAwwIKhtXwYZ7UjsMeAJiiUI6fe+CIEvTae5XyHOHBbIstjCXtwZhE1z56bIhB04/bTFJsF9U5R1sJTjLFYFrAlE2hPpVkgjjpsxBfZRsfi5X9+c1oFIG49vzOqL4h3r4CRrLU00MjZHm481YOurKUjK/B9KGup1hdKqVmDPNvdAbebPRMGgyQfxJ1V3d2oRPHviadAhNQXI9ZZ2GOUr5ZiMempOHy82MP27PuVm9GGPF8i5j7G1hytdZBi7cnTMyaMCRRC8mnnqXHbLLwY8GmB/Y792b/J4p6SZiBFsaSk8qFJ0HeICGxF/IpkRjxJuptkcw4spbpg9XvTQ5p6H57A2WN1POX3uoKzV7zlyvab0op8my2wQf6Kp2RVR9TpZ5FpXYgitiV+fluWyBVHl3Hf7qLCDlaZVg/FdoOHP25FqmAo8gjy9fxtnDCOWmZMw9hENObvBoPjFTjAGIGJ1BJLZn9wZNrww5Mqpxg0E7ZGiTkxWTAsTIai1lr+GiCEjQMYhO94/D4WWC9rCdCkTis3RBY4pn5YRUq+G4dgvlX9r4KwuZoE4i4TCcn9KWXzIZ8xly0P1P9IJaiv0/6RxqzIwO6vAAg9Kh/Hx8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(186003)(2616005)(38100700002)(41300700001)(31686004)(83380400001)(53546011)(6512007)(26005)(6666004)(6506007)(6486002)(478600001)(54906003)(66556008)(66946007)(66476007)(4326008)(316002)(8676002)(8936002)(5660300002)(7416002)(31696002)(2906002)(86362001)(36756003)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmJlVkF2MzZrajRrTndkQUM0SUxOdmorWEJMQkV1YWxrUDJ3MnZyd3hlZVds?=
 =?utf-8?B?MlN5QkpFOXNrRmlZMzhzeFBtYXkzNVJkUEkydTZHNFh6YUFSaDBHd1RRbE1H?=
 =?utf-8?B?am5UZ3FSUjV3YUhtczVhMGprWE5MczI4clJXRmVBbjlkV1p6SGdQWlZ2Rlcy?=
 =?utf-8?B?eGJWaTFHRDN5UFpYZnI1Uk5VQ1dXT0hld05DSDlRc25HT3BseWJEMDVOTWRj?=
 =?utf-8?B?TG1PKy96anFZK0Z2WFUyOCtpWGFTTWorajBaOEJ0cmVmMmxtU3h6M2M1djJo?=
 =?utf-8?B?T3RtYkxrZmpvT2U3cEgxK00vNUx6SlhGOG02aFpTVE5oZCtFT3dlVDFCZ2Qz?=
 =?utf-8?B?SnZXUTRHbjVzZ044Z1BBNVI2RFYrdEU1RjJ1L0pQdFd4RThzZysyeW5QMFVD?=
 =?utf-8?B?SzNwUTZoNzNjWEsyUG1zemM1SysrKzQ1amNpMDlUUU83SmJ3dHhtWTdNYjRa?=
 =?utf-8?B?TVRYcnNSSFVxNVcyZndpV2RFL1Y5UGM4STY5TjhPOGV3R3k5OUx5ZnVsV1RI?=
 =?utf-8?B?N2FLSE9rTDlwaWRVQi8zRGlWajFXYllCVVFXOFRrRSs5MEJmRzhYRjhScFY3?=
 =?utf-8?B?Q3Foc2wrSnJISGlIdHFXWmk2cm5zbGRaaWlJNm14ai85Y2IwWTQrY2JNOVYx?=
 =?utf-8?B?QVp5dkxFdnZyT3gwRnpYSVpueU9pWGl4Y2cwSzdxd2Uvcld4dWF2b2RWc1Ny?=
 =?utf-8?B?bzYvb1hETGl5RDdKcDhoaXF1SUpDaXJpWWRYb0xJVS8zRy9VenFSZUdBbVZl?=
 =?utf-8?B?QXkxdW4zN1FEb2hmY1J2RlV3cXhwTThGM21HNkpUWDVDa3hoRnZWanNWZWMw?=
 =?utf-8?B?eEs3TitVTVdTOUdKb2xkalBKZXFzd2d6czRGU3hGZ1FwNkxxbmZHdWp6QW1x?=
 =?utf-8?B?dVQ0NndGNGd5cTZicjVBWHJRVHE4UXhMNStYMjBoNnFBeFo3cm1BdWd6SHJk?=
 =?utf-8?B?dm9CcE15a2NERmNYbzVZc1RodWRPUUYvdUdiUlV5SWhzMjhkNjBYYlhoV0JN?=
 =?utf-8?B?Zmpta2NWQlg3cU4rbjFIcTBHUXBCb2MwWEFJU2JLU0JueWF2RFZXVTFDcFdv?=
 =?utf-8?B?dVpUYUhwVzV6bHd4V2IwcmhiOUZYb2xrUGVnM2h2N2FQTDd5TmtLZTNxV3hh?=
 =?utf-8?B?VVNFaHJQUFduWG1JZTQrTjRycHFicytwVkpxMkV3R1ArRXA5MHBQYkVYcTN0?=
 =?utf-8?B?bTkrL04xTFJLS04yRVNTL0c1SGtLb0diM29KbFprR0RaaWVDMzBGUWZNdms2?=
 =?utf-8?B?S3UrOVlwM0dvQlAxUThzUXJrcnVvUDZGSjNER0k4RXM5cmVtUkdGTHRoNGtB?=
 =?utf-8?B?Z0s2RTlzL2xJT3FiZmlMVjhiQVZoVXErVlZrZFp0VFkzUWx4SXhhdGFqbG9C?=
 =?utf-8?B?Z05HQVhlYTZQZHQvc1NTU01leDNIc2luc2YwOENPOXZRUWw0YXpHdnJmK0xh?=
 =?utf-8?B?M1RtSnB4cmduRkx6ZTMyaVY4VU5HTFNNY0l0cDk2WEFDVjhIaTFXSEg1U3or?=
 =?utf-8?B?RXR3dEFjSFVoRU9rcXpNa2pUckpueHh0ZEZvYmRGU3pxNWZJV2NSUnJoZzF2?=
 =?utf-8?B?eVRJcEExQ3A1d2tYeUpuWG44U2hkaCtJZS83c2kwOEVFbWRKa1JxVHRQanEx?=
 =?utf-8?B?QU9FSFVRVTZmWmxnTFNrRWRnOFUrV2JmU0djdE5ta3ZZZm82YU4vMHlPV1lR?=
 =?utf-8?B?OFE3TkZKcHg0NlJlc0xjUWlweDREWTN3WGNTSFZKOEFQVVphRHhabFZnOUh3?=
 =?utf-8?B?V1ZLQUJ2ZWVVdEEzdWhBMC8xZHRtZFBaRW84UitZcnljR2ZibWhNR3o4Qmlx?=
 =?utf-8?B?WjNseXZCaFVGT1VjVitGb3NJTnQybjlSK3FyNjcyNHp1OWtiLzJiU1d1cEQ5?=
 =?utf-8?B?cE9KM25RQlZqU2VVNDhrOTMyWHEva2VWaE03bHZUS05OSkFDUDFvZDhTVXRZ?=
 =?utf-8?B?SFNIOWRielFXOW03U3JJbTE2OUNjMllEZGEvSkd1TU1UdU5zVkxrdjJKMmdR?=
 =?utf-8?B?SUE3VXg5VEpOQTI0VEtHREkwbnR6WmhRTDJvVEZicGQ0akw0cWhIU2hMRnlp?=
 =?utf-8?B?RkFTTkRpb1E0TlF6VkZEdTJBS3hHTW1XN3RUS1RhV3hoOXJXcDBVSVZIQzZv?=
 =?utf-8?B?OWE1OXhZaUVtNjJ1R1RuMEtWMW9PTXBhRVBMRXlNK1lER0h1SE9QTnNtbGxk?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NQrbig6JbgJZKiE2Vzr638b+neNaGxhNJO/BJzgI9mtC6wHJf4NWSkHhcYZIFMFVOxb3dlQ3tYGRJabwm9mmc48gtQ1Kvk4+yAWQTPsBy4A2uOyNuiNIWBe8zLV0qYdhxaFujkGoi3kKtiwFqtBCRmTsg9Xb+y7Qr6F3z6qhK3M0UFKNjWZvLDuhLRg+Su5iCU3wZcPZf4OwAO0JgWfgxpVP6QYV1nJVo4M6+eMlLpPKs23D8CRGGAZbk4eNiObr2MT1WDTihU6xbfmVKYjrBLE1iYLi0RRkxyAJqntFh4wa/hRthSqo3MeJTmOaUki9O8dfM8KWcQmVuYvvHZN5eNEApAx7EegrhV7dlmOrFVUx3yWOlyqGgaxhNQ241dbXvQjhNY2stkU6WiuxdzNxlbwNrAkd8BAo8OOkPZyz3GtfYYchPlr4Gb4IjmvYgxURwoOgi65qyay7StDzlgJ7vV4Xjp3OsJXvMH9OlZhsqtupb3n9GwuhTSF/bo4NekkVDyudcbJJglSiVuigyQSIUmikBdIkprWYA3S0VmtaFo4TPkUkgGN9opafywT52rKkwp6oloPgaTwMYz4gRQ0UYOFleU22OF078lxnedvXp4Vx3VdOa9bbItj4QxCDt6P8iPKUJNI1D0Qwo5rmq5uzrrdt23Zdmr2ymDZEDu8N2udvqE/PrgT9sxFWe5MkPIFEP/3lGbw4ARH3TRvxlu5ql8I/oWmQG7nhW87ogeZPpvu0R4k40ktlA6p+kDzsad1rvYm94UqCf6y11VyHMpLBQ4LPwl/3C4iZW5+5ugR29lF6dWJUc4mJkQiF/sNp+GKIb6lo7L30VuKjHPHYEtg0Yup7Pwgz8RWzjIyZvG6BFksViF80dtI5Q52FqwvT0hEoDVo3YypWWqtEwx4X9rNYYA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdaee09-7092-45f1-5fb1-08db61bb0072
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 09:39:59.9604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vPHTFR0eX1B6T3P8ls5GRdBQbB8RPj1w4HV7hStO6DiPfjIDStDI0ZO/lZqKsTwLhLkKbs/Nlk1y8EMJ8sUF5tPzQbn23yG/sjvBX6NKG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_05,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310083
X-Proofpoint-GUID: f1l4F3lFNcnsYkh14FgbL0cNUOIjIBuB
X-Proofpoint-ORIG-GUID: f1l4F3lFNcnsYkh14FgbL0cNUOIjIBuB
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



On 30/05/2023 22:39, Philippe Mathieu-Daudé wrote:
> On 30/5/23 19:59, Joao Martins wrote:
>> Relax the vIOMMU migration blocker when the underlying IOMMU reports that
>> DMA translation disabled. When it is disabled there will be no DMA mappings
>> via the vIOMMU and the guest only uses it for Interrupt Remapping.
>>
>> The latter is done via the vfio_viommu_preset() return value whereby in
>> addition to validating that the address space is memory, we also check
>> whether the IOMMU MR has DMA translation on.
> 
>> Assume it is enabled if
>> there's no IOMMU MR or if no dma-translation property is supported.
> 
> This comment ^ ...
> 
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   hw/vfio/common.c | 22 +++++++++++++++++++++-
>>   1 file changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index fa8fd949b1cf..060acccb3443 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -414,12 +414,32 @@ void vfio_unblock_multiple_devices_migration(void)
>>       multiple_devices_migration_blocker = NULL;
>>   }
>>   +static bool vfio_viommu_dma_translation_enabled(VFIOAddressSpace *space)
>> +{
>> +    bool enabled = false;
>> +    int ret;
>> +
>> +    if (!space->iommu_mr) {
>> +        return true;
>> +    }
>> +
>> +    ret = memory_region_iommu_get_attr(space->iommu_mr,
>> +                                       IOMMU_ATTR_DMA_TRANSLATION,
>> +                                       &enabled);
>> +    if (ret || enabled) {
> 
> ... could be helpful if duplicated here.
> 

I'll add it.

>> +        return true;
>> +    }
>> +
>> +    return false;
>> +}
> 

