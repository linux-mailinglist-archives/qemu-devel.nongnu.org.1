Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F597A1638
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 08:38:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh2Rp-00071q-Tj; Fri, 15 Sep 2023 02:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qh2Rn-00071O-Ip; Fri, 15 Sep 2023 02:36:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qh2Rl-00059u-Ak; Fri, 15 Sep 2023 02:36:59 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EKxZdV029217; Fri, 15 Sep 2023 06:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nsEolf/wq773mf54wTaaYIrHG0GqSBsOs5vUxUwuHAM=;
 b=hgNQ9MytIimUNmCC1UIZ82/nBjHv1od+qjuujtRlg5jxX90YqDPiJPUIFfFDuPSCkmT7
 2QImRD7Y5rOlbV+OFfsURfRQRNHuXSG03IqX+CpJz6kNX0N4wRcRpqnjd84Mk2XEkHkC
 E3fTQnz8U0nzWHuR31qRZT8KWn95c5AKss006Kp81mNjWY5geKpLGlHWyNDGbsLFNa9Q
 OWlnAg9OvTmQo9T0qXU3+M8M47DbE3wtKH717U9PHwAbwMCp34Tny05ghHdyFyJmSe6B
 OjDX7j4FDmCAB4Yc4FAITcczeUOmebBKPfZLQHZO6o7GEW7Yr/OY+3K9rkurDC8kojsv Og== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rf6nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 06:36:37 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38F49oQ8007400; Fri, 15 Sep 2023 06:36:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5aeajm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 06:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZ1CAZ9MvORJHWXJjxRc/VdFzRqvgGZs0mv8f0+fTivzzI0A5kcbU8F1YgNley1xLRdnVlArmr2c08AsPXHBPnBJobad1YxTmz04zDqMDE7goDQ1/nzYbHl926lMzMqDZst35Ux25uYecMt8bHNOo20WBgRHBkJ7snPP2+6COkB4iflkoseog0qy7goqNhpmV8GmgRuAh8N5uiwPqDmOw0o9Lgy6JP7DHF+kZCebhghZ5rIKpTe4GwxfGmEdLbJtKnUoM1Y3PR+EiznCd32LuVLs9TqdyX7fLARyiKWB/rQbOccXTKuF8cdMM8l4mDV5kEi6ZS4HRSNYYlcgLaV6sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsEolf/wq773mf54wTaaYIrHG0GqSBsOs5vUxUwuHAM=;
 b=GTzHI0uCQ6y9yn/0JwN5PIupeUSlt64y+3fjjUyZLRL6l/bLcBNmWPsWIxFW+Y6VVOXK12fJFAkNoUun7v3INZED3Xz2OpVCVNoBH5IwFhxhb2CYN+zajbi+k4mN52V2tLQB8e6HKb3hgy5mhTSBEFRaP6/eAAdKFFY2Sl0rwH39x3axhVpe717l/5yrABKjUZt56Fhh693+uDkWEpxVKGgypFdj4UR2vgs5CCxxVIZDksBRQyxmRr/gOx3zKN8ppw5oKSYuv1VFL7h6z3crm+Itp9ETehqYbAvVv9W9GKMD1QAN+Y88tB8QOjhoSWHUFNdwPy1qzr0qfXTFBoFbwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nsEolf/wq773mf54wTaaYIrHG0GqSBsOs5vUxUwuHAM=;
 b=rUYPXDY+see39W4rKKdrnfd5G/nuHBBg7Sv7YZvJaNpMRJp97DO9oj0mvetJt+rTpIabdlDSX8ZX7rM5OI0zFKjdHSTxvXbmbEKs0ZdzcNtqYY5Vh+/P5lp+d2/8fmoiJ55Q8mL/55Yx20ugsG9+1V6105WqikGVnGYdRnw0Y2Y=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 06:36:33 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 06:36:33 +0000
Message-ID: <ccc03b55-5b93-6f0f-568f-a1854286d77e@oracle.com>
Date: Thu, 14 Sep 2023 23:36:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] vdpa net: zero vhost_vdpa iova_tree pointer at cleanup
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Lei Yang <leiyang@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
 <lingshan.zhu@intel.com>, yama@redhat.com,
 Hawkins Jiawei <yin31149@gmail.com>, Cindy Lu <lulu@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
References: <20230913123408.2819185-1-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230913123408.2819185-1-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0155.namprd03.prod.outlook.com
 (2603:10b6:a03:338::10) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: c81c7b0a-4f7c-44e6-8f91-08dbb5b61a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIkzIB0itRJmwajvxFMXQiP6SdMUehfdQKS7qbJG4q12FZyn7opdUDGS3GAkIDNFuFe6TgBozsksXLBq4fVTVrmTEONrvSUHucfufSHZ6l9ap/oPDv5gra2e++JYuZri4EmzeCTxBEvwIlfTy1I1ofvroK0pSbX0DgjgkElWIOC6t9ddjz175gttMxOM7SX2Kqjxj/lDL2wBNqGfZnIYb8p2pVrn8cZdR0aX7huqi7Wvg6gAuzwAJIpn63oDIg+r15z6ICVmtTSjBQxq/JBDaraIFrfJM3SFApVHp/Xwa2aThKzEmvn6mAsGNnv1bxBaLd+l/P35NjWE2Vtdf4TShrKu6YU3xUW8NuHNfY5+w+t3aUBQD10IA18uU9U9VIsZAZmCa0cJlbE2ZYue3NVaPl5ivnH5b7AlSWe1lt6QTh4juTFxhQXDZ/2GWpPALJ81zBdGa1udqOwIjWOXCTpuYfRjZrRgiTR5fmp0cVnElZTt5DS88OmARiKXrupw/o6XNbMzVq6Y/fjTmBXtm30CnMtPwAxUi7eVQBM8tKGtXu1j+q/unxpyMUx+B+INvot56ChffOAccvA3sfmDHN2x1tgSe86B1cn4xKdtNv7KzEZc9GRDTYdUGvky45kV0XTv4Uaatc4As48euPJM61dUtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(6512007)(6506007)(6486002)(53546011)(36916002)(83380400001)(38100700002)(31696002)(86362001)(36756003)(26005)(2616005)(66574015)(4326008)(2906002)(7416002)(8676002)(41300700001)(5660300002)(66946007)(316002)(54906003)(66556008)(66476007)(31686004)(478600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDFaRGYxZ3o0cDBxRTM1SXZvSHdJeEIrVTNGWlhsbDZqanIvdXB2NzBPVW9j?=
 =?utf-8?B?b0xRa1BsRkdLUGF1S1Q1bUdadVg1RjdNNnhaZUJBSHZQV3FVMWpKd0QvV29n?=
 =?utf-8?B?V1QvR2M0eXM4RVZhdkxzZ0VBWkNNYllIMWVQZmxwTHV3STFlYTFYRE1SWG8z?=
 =?utf-8?B?QUthcE16dHNnSG1xaHE3QzdJdWJObVR5bE1LNnhQQ1hHRmlrS1ZIRDQzK0xC?=
 =?utf-8?B?TG5QNTNYbU1rN3VRdHlidHVxMzZjVXhBOVpEMjduRWRHSWU2bXlFVmtWQ1dk?=
 =?utf-8?B?eklHQ3RRaXZ4K0l5OFhmS1FUdmdMc0JsQ0lyQmk1Q1V2SngySVpwcHNGQUEz?=
 =?utf-8?B?ZjZIK29yb2xtQVc3eW55aCtYZDk3Y2ZGM0dsUTZLcWR2TUs2VjFUcWgxcCtS?=
 =?utf-8?B?Q0pTN1p0S1Nub3k0WE5JeHgreExxdTl1bjNzRFQrRUQ0VDB0UXhnb1V0Zkh2?=
 =?utf-8?B?VWdpWHY0aXNJaGRMaUdaTVJzUi9SZHVCb2VDdGdiSG8zWVpnejQ1U3FrNUw5?=
 =?utf-8?B?clRySmtBQm1SV2hyVDQzY2w5QjNMSXJ0eVFDR0pYYmVWOGEzbFMrRXZqMzdt?=
 =?utf-8?B?THpBU3grYmhpeU4rd2dMVE5xYUkxMi8xc0hqSXU4SFJpdEZoeXp3TEJwZ0xx?=
 =?utf-8?B?R0FIK1FMUzVXcno5enpZOXEzQWlzajkyZmdUY0ZaTXlncWlWNTB4bUxReUVs?=
 =?utf-8?B?UlUvSVFwQUpFZ1lvT1RMU1QzTElXTmFiVG5jNUgwUUhsVjJTODBBdXRKZHZX?=
 =?utf-8?B?SE9LakszTkVKK1VZMy9hQUpRNk1PN2lDKzBYZE12QTFKUjd5RzE1L3Bhcjd2?=
 =?utf-8?B?bXk1MTNLdnNrcEx1azAyMk94R1VGcVBNVGYvVHJlMk5wYVdLNXBLZHUzbmhZ?=
 =?utf-8?B?eGx2SHJMSGw0RHRZWEJrZzNUbjUrMGN4dENLWVA0MnQvSjNWVmF4TnBSTkNU?=
 =?utf-8?B?R1hvaDNZQU9mQkhOOWJzRUF5cThUUGVmdjRkSWF6UmNGL0sxL1ZiVndkcHlY?=
 =?utf-8?B?VHNnbXJZY000clFTaEpTbUhGQXR2eGZtQnE0WkluaUMrYjE3eFBnczlsOC9l?=
 =?utf-8?B?NzRvOXJQM3Q0RWUyWmJoS1JvWFlwcWVVNjljMjNndEZaYlVvRjBtbnFKay93?=
 =?utf-8?B?NS9BYnhmUWhlWmVkK0VKR2M0VmlWVERBY2gwZ09FMjRhdmlTRHB3RlZpQ2V4?=
 =?utf-8?B?UWI5OWJRNVN1MExETTNtTlZMNWpmMnphUTV0KzE0TlpKQnAxTWxhUVpxV3RW?=
 =?utf-8?B?Um1rWTFUUkF4RVVXMEVHc1ZxWlVjTEVMSlY4eDhsNmh5OEg0bUdRV2c3L0xo?=
 =?utf-8?B?TTJhdUVpNnBUZHQvMzZQUzMxcUNsS0RnbFRQWDNFYzk1WWxSZDJtRWl5ZU5s?=
 =?utf-8?B?MEJ4eEVvM0JwL1pWZi9uZE9mZ1JkdUM5akhweExaTmozc2RpN3hRMzdCdElZ?=
 =?utf-8?B?K2dMS1dqY3pBZUlUVXdkQnpWT1VqdFdaYm9uUUN3d0NkSXF0K21lS2Y1TlAy?=
 =?utf-8?B?RFNZR2RqbUxZVjh5aVVsVnZIZzBVUWlZVlFSSjBJSTIxa1ZkVFlReTZxTGFF?=
 =?utf-8?B?aWg0UEFla0ZhQVRXZWl1UmNMaFVYeG00cVUxNlVrc0pVMDFJZEpBYkYwaFhP?=
 =?utf-8?B?aWpZLzJPTjJ2MEx3TXFGZWYwclUrMGQ2aXQ5b0d6T1lQSFdVNEFua2N4Nk4z?=
 =?utf-8?B?aEN3T09YVUpZa0I4STJHZHQ3ZUhNQmx2TmplaDNIMFhBcGNlTFplNC9PbGdR?=
 =?utf-8?B?ZWdKZ0xPQThaS0JVejU3UmJQSGFVcE5NZkNSK1lLendOYmpNZHdpdysrNE0v?=
 =?utf-8?B?Wk5DTEpLZ0V6Y3huZzRzV2daS1pjSGFXcUpwS3ZMSEVPSGVFdFpOdm1SQ3Bl?=
 =?utf-8?B?bXMrc3kzS2FnNkJGdGpBMkJaUnBhNDFHODg1Uzlua3RHbS9kSFp0dkY5OG1Y?=
 =?utf-8?B?bzNQdkhtOUZ2OFpSTmZYNUIwUmpOTURiU0tURWZIY1ptSkk0QTZnaVhocTB5?=
 =?utf-8?B?QjFZVlowVmdBcmdYNFY5SzFlRlE2NWhFNFpKOEFaTUcrWFdBbnZmTzd5dEJq?=
 =?utf-8?B?UHBhUFB0V2VqMFJ1ZG43ZDFCL1pERzFzZzdybzlwditNb3V0R0ZZQnJaZmxx?=
 =?utf-8?Q?HVfmsIMiF5sTD9x1PlyjchRZp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dATQe8RzFypnlsQ0c9D1c3KSr36GKp0yW8XnN5iX5pWSmtfx84K75ZDU9s4LXqIqpDSAUSke2wJ3d8kQxo3fQK0pcWxF10lb/e89vEIe0IGSAI+NCTcxbTgmdUqiCHnnMdmHt/yNiXzAyWIVY10LFD9v5Tvn4jis35FuJxLT99m9mZEvbEcoQFRC5CtEMJXz46IAP+1mQZPrkrCKB7Zvk0ovx0ecQb1iQBhz3+htKrW2bVefp4rCuL64zbAQJLGjvKv0hECIItVSFiSvCwCDVf/S7tA856NHV8At334HKPzKpKgNc80TIwAUxpWwwXYiVeGPER4y0AMBvRcFxLKQCEyEwHWfWAKqCv7oG57+T2yxsO2+eJDz6d7sWIeZWkulw4v+uggPZElWLuf6XGfYHKtLgy26p9TG63yvkSllQ7ooxx9fU8H7q9JlrrZUEQE7YZgEuNqNhdHjYicFn95z2pP1hPqpp/QjJEVyQpGCNPoUoxEedjmVocKJpzqw8oQHoG87Nau90tDSfoOdxBJ+BZNSvYlIOmk3A5jtt3Vvb4NfLcWoASGDGDNlFt/3iYGP+I1vMJ+eoaeE4NgPI2ON4rjaGKlOfGZV4m/4O8e1da7ZHmBlafE8EWSC4pBKH70YpJFva/k88G3ZBEXyJBvvV+AzzMDUVxpeHjzSql1VH7E164eEYT8J6jx6tItpoBJIWLklmbiuYmADRtQQ7xykBB7dTYzlDUVe+YN57QPPiw2kG7cJKRm6gLqbikCJS+jQr+z9ys8b5OLiZVo99B1jqArgHeShRKDGrvNEWsmgii5oVoVyiEEbX3HEO7KHnzhnWZ3JsS4N/ia905BLabj6gds/vLIqWbBZ5RqVZyFSkCTdRo9v1K0E8sPD4dZKsMAptnThnfUXSVTWu3TjmUFh5g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81c7b0a-4f7c-44e6-8f91-08dbb5b61a63
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:36:33.5571 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5HIX7o+B1a/EYeNGItsx+KRgZfJF//SAOlQ/HMgTm36lNPPh619l2PveIDLIJe6n7Mcf0bfrUxHR+ALCtfJ73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150057
X-Proofpoint-ORIG-GUID: XTqTeGqn3GW5OTM2N7TqO-0pDpxqhez5
X-Proofpoint-GUID: XTqTeGqn3GW5OTM2N7TqO-0pDpxqhez5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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



On 9/13/2023 5:34 AM, Eugenio Pérez wrote:
> Not zeroing it causes a SIGSEGV if the live migration is cancelled, at
> net device restart.
>
> This is caused because CVQ tries to reuse the iova_tree that is present
> in the first vhost_vdpa device at the end of vhost_vdpa_net_cvq_start.
> As a consequence, it tries to access an iova_tree that has been already
> free.
>
> Fixes: 00ef422e9fbf ("vdpa net: move iova tree creation from init to start")
> Reported-by: Yanhui Ma <yama@redhat.com>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>   net/vhost-vdpa.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 34202ca009..1714ff4b11 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -385,6 +385,8 @@ static void vhost_vdpa_net_client_stop(NetClientState *nc)
>       dev = s->vhost_vdpa.dev;
>       if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
>           g_clear_pointer(&s->vhost_vdpa.iova_tree, vhost_iova_tree_delete);
> +    } else {
> +        s->vhost_vdpa.iova_tree = NULL;
>       }
>   }
>   


