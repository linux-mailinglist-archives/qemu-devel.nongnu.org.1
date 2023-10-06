Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 029427BB5DE
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:05:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoidM-0005gh-7U; Fri, 06 Oct 2023 07:04:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoid4-0005XX-4V
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:04:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qoicz-0005c8-Ew
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:04:19 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3969EVfW000458; Fri, 6 Oct 2023 11:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=libKMGqpMK9u7Oujwkz8ZhHmpvjluDcu5OSbSVuzxl8=;
 b=XfhyQ1oNoNhvxtlPxcnH3m0lRP8K50Fn9c8uEkCRPuWWSL2PedMgcdd6oG+13kwLWjCD
 a354x1KRnOHJIQ55laVGtSEIGXbBNgXYIsVFuO2KjBajdObqFsgx/fkzWu1+Px0dtj4o
 Q16zroHHwzlGeRoKgXtklsFcpfZindV2fOn8a8Y+XZbaVryJgsmE4qklXOHmo7yHv421
 kQX19zw70Mhao/N9E3Jcga+CAK5O8NSVcUGET4DV25u6go88P87Bo6Y43aNZqbbcErCF
 IbxM0/CNKsSx3xaOnBeor2MEBMnbW550ZXdo4sDTTEtQ+MinN/4bOvIhen8Ns1CUrEgU kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tebqe3nyb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:04:03 +0000
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 396Ac57l008714; Fri, 6 Oct 2023 11:04:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4b127n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 11:04:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4L1EH/MoFXTvtimaQAbMiWIxtfJYfEpqJ6V66uQ8z7qW4rAvOKZucUYokshZhv0IFVBxcShepw5fjvundlRv+Gtk7HF1N0ugF9Zexarm9PJTsFE5cXO236TQSGS4tpcGX+IRx6pyEReBrCHzP/h92Ae5/SQZ5gLL2D1CC/OvqO26RMLjxwWdKlOY4EgBMxb185MA94hSeOoQ7onqaDYJ9qz3MQlcMiz/PivVYJdcvJF5wQBls3INvj5jGKTS0Tp7JuJftBiYY+ASzXigwd7huXvfXp0dOtDJvgAlva+FL5TK1oMOu4eXqOxEeUsxNCtMiS97OivRdL/1I/2FLXCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libKMGqpMK9u7Oujwkz8ZhHmpvjluDcu5OSbSVuzxl8=;
 b=Rjc/x9CUgDNDGr+nsXg5XcBKYbQvO+pJs5YINJ1BfUyF7Gu88IlJr3rkJU4tyKVXkPKwmDdiQRR5VD+r/eVTOq0nEP9qgUiRRkrVRBTmPFJ9bxmPiqbQrAutCfJ2lUK2S6lYFTLnZqMF3SGQHtGoffVo4jO5cZuZJall5iB5XyANAMHYtpAI9BqB0ugwJjDIn1++l5lvScBWbAd/oYOviZk9oKBBd/mRe95kHZ5FNOR240HQqRidDqYPojLZV7uHWXNcyRMUKYDapu7SQZVknFaIcDnF10/M8/NXT24uJqIEHYIX58pKX+q9dXtVXyeZ/LdN6ymblnw7A1bR3JMbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=libKMGqpMK9u7Oujwkz8ZhHmpvjluDcu5OSbSVuzxl8=;
 b=j6k8TA7w5oxIumzxXlVDb21cA7Q2qE6bQ8TlEm4p0JOiz6GmjkAxC4N4yElwc00CWI7sWWXfxAWFDr+YK52CFQ88k0YGdGJI6DlNKkK3mf6/Tr3ayJqiWD65WFF2xRAq6s18U9P2hlA2pHy6gkTU1y7OLzUQYsktjOmBpytUT60=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BLAPR10MB5266.namprd10.prod.outlook.com (2603:10b6:208:331::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Fri, 6 Oct
 2023 11:04:00 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 11:04:00 +0000
Message-ID: <1e83822f-0073-446a-ac7e-87a76bad99da@oracle.com>
Date: Fri, 6 Oct 2023 12:03:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/15] hw/pci: Add a pci_setup_iommu_ops() helper
Content-Language: en-US
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-2-joao.m.martins@oracle.com>
 <439d42e6-0627-43d1-1a45-dbc92ef83380@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <439d42e6-0627-43d1-1a45-dbc92ef83380@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0158.apcprd04.prod.outlook.com (2603:1096:4::20)
 To BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BLAPR10MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7b69e5-7830-4c55-04e9-08dbc65bf168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LLqgmnar0wPBtbJV2l7xPQSZwvPw4PqPvGca3yKMgGsHkoQQaZW+vn+GatjO7cDeiEqmMTphmO4hxV4E76gA2lC4LAO2RKZfBxvX1edIcDrMCACl0u8Pgw/D8d9k6Yi1oce53U5gpP1aPNyMVL2GobZC3liQ2eJNhx/rFdJmrDn2ulEzT6rRO4QIbWvS4WABJVjJeNAFW4NWjKK1gEi0J+dxHUCPt4Z73L56i/WgrZUT8rCHy9u2rOQ/HJkb4h7jZwYAbng6auxbIDg0PFWITMA+gtMRmo+603/iZCqgrs2O70zP8E8whAGYaDy6aFYVrpZmcTDFzvQMGC2h3CEO+shABSkD+uLjx4PDbx9NDCoDp1gYlcsDYVMvYHFLXfc8EuKegNePk7GCf2H3PAJNsItx6gTpaHp1PFsRHvyUVjad+RJbjM9g/LRxjoUmCrqRXEedG19xJZwn+v3vp8Ka3kl/Rgfyf4ctSkbZod9I7a6O2A0vI6sJKtsdK65lAdE4afjP0crdGX7ExErlC9nE6gDTPB8lzA2tlPWVGReTkvUi3Qou82V/rvMSTJyVT85FX434fG/ioVJS5MNWqB1YJlPMzVk7LA71AfaXkuzw8DwKHZwodAwxQO/rCZRoPN+kVjQCDJiaUoCxbh4rMW/RGg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(31686004)(5660300002)(2906002)(4326008)(8936002)(8676002)(41300700001)(66556008)(316002)(66476007)(66946007)(54906003)(2616005)(6506007)(6666004)(36756003)(26005)(53546011)(6512007)(86362001)(83380400001)(31696002)(478600001)(966005)(6486002)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3V2MHdUNDVYNGRYbmI5b1psSTdwcGFRWGJ5NTBuU2dNQUtQbEMyNEo3WDlR?=
 =?utf-8?B?RFI1UjNoUEcyWWNqL2VtamV1MFBjUXhtTUxybE1GZGp5VUtOVGsrZkd1Misy?=
 =?utf-8?B?RElEdFNaalorOHhqRUdYYmNHWU8zMjBOeU9yeG9mRDViQVFvWkpISUJjdlVw?=
 =?utf-8?B?ZlpuVEdMOGFlUUNMdHNJbWpZejVrMDA0NjZWTkdTa1lQUEpyb1ZHeDNPV1VQ?=
 =?utf-8?B?OHlOZ3JDSUIrS1dGY2ZMczdjWjNZeGF6K2VoNENmd3RVYXliOUFQRmhrUDEz?=
 =?utf-8?B?cnpWL1ZQRlZLWGloSHNUcXlHbW4vNWlUZlVOL2djSkJPUk51U0g4N1VWSzZ3?=
 =?utf-8?B?TmNuQnpqY2xqZjI2bTJTaEdSZlJTUnJVYXNITk83aS9BMTR4VGd4SE1ha1hy?=
 =?utf-8?B?eFZCM1h6TDVtcDFINXg0dE5QM3RRN2w4MldwVUxSN2FnbDVxb2JpcWZTWjJC?=
 =?utf-8?B?Qmw1ZVBxaHZmazBVMy8wQy84TTE2RStSMXRvbVh0R0Nrc09CY3NzYmtLUEFo?=
 =?utf-8?B?dTBsMGxKclQ0ajQzclRFNHRlYkJTOWYyN0htZVlnMFBVbW1ZdENrSTJpMmoy?=
 =?utf-8?B?bHN4TmRneE5XYWRpQVpLWjRLczZvdWRyZE5aWktORXdtVVFybTh1cGJmT21l?=
 =?utf-8?B?TFNMUUVYcVphNUdoa0JLUUozVndPcDlDRnJhdmllZmFybDRBRHVQVHphdXJp?=
 =?utf-8?B?K2pqcUVTeVlpZ3ZvZlVDOVFmSzNrMU4yZmpjbExjYWM0Z0VKRmVCMEFwb1la?=
 =?utf-8?B?RnA3bG5JbktvYUdmNk5OTStKM1cyalNsYjRzY3NNQUdERmlYUGZjQTUrR2VT?=
 =?utf-8?B?bzV2MnhsRnNoMEN5RmttMzNWREhjNUFrT2NZTWttRUlkZlAvYy9KWlBBWlVC?=
 =?utf-8?B?Z014YWNpVzVwMCtBVGFnNktMZ1NlS3AwYTdUVkV3WGp2KzB3T0RWdnFTSDdU?=
 =?utf-8?B?QmFLN0w3L2MzbXJleCtoNXI1b3J6RDk5OUkxekxuRkhPWWpiVUw5WUNMQnVz?=
 =?utf-8?B?UDRsNXB3MmhwWjM0VTFoU1d5MmRmWTVPckUyWXN1K1hKVHR3SkRPRzJTTWJZ?=
 =?utf-8?B?N2dnbEVpRzFtRlU1ZnZ5ckZpNXEzVXRXbnA4S0xUWlFqZlB6K2M2K0xIUE5q?=
 =?utf-8?B?ZDIzVEZtMGdFbEZkQzRDbC9SV0oyRHJPWjQ5WTZRelJpalpMM3dxQmx2Z2Y1?=
 =?utf-8?B?VStGM1p5RFZ0RGJRV0FHNE1PME5KU25ZU1BWOVMvdU1CZTBwSWZtMTFVYlNz?=
 =?utf-8?B?OGhjd25OWFpoWE1xam5Va2FtUFBySHlrTlIwZ2ZIcjAySHlObWp1Z0FWa1lP?=
 =?utf-8?B?ZmJoeGo4Ni9mQWFPcVE1b0VIYlQ2NllNMGlkNU05RXRmSmJmVzJacVFhbnM1?=
 =?utf-8?B?NDJzeGVKSDU4aHAwcVFtYitMby9Nclp2QkNuRENFdGd5T2VaZENLUUNDUzBJ?=
 =?utf-8?B?RTN5d0JMY2x6dVZIME5jSmlpWkVBcHRZVkUrUFdSb3BKWjFMQ0lUcjhlaWpw?=
 =?utf-8?B?SzFVaTMrZlNqRmFnZTF0alB6VUVlVVRpTFoyWE9yU3JaS1diNSs1b2UxNjdh?=
 =?utf-8?B?aXFyd1pWMXJvdE1EZmd3UEQ2Ums3cWl6MGxDcGlzVVZ5OU5DUitpTDlKYjFt?=
 =?utf-8?B?R2FDK1YwZ29WRXk5N2pET01YQS9oN085ZXIzZ2tVcm1zRTAraFBDY2x2MzY0?=
 =?utf-8?B?Zld2ODlobnhHUURvdkhCTGdOOCsrbXFVcllBbHMxdmxPc1NpNk44WDkzWUpj?=
 =?utf-8?B?TU9kR0o2RnFGRXY3ekRHMmhCd1NuWW11cENacGxFcHdESTFqQTZlMS9NN1ZL?=
 =?utf-8?B?VDh1dkduQzBvc3BycFdmaWRmVWd2a09uVmJFRWRwQlNxNExtNTJXZ1NNc045?=
 =?utf-8?B?VVBSa3kwbVR0OUJqaW83KzFodWV4bVpPemtiTlJYczROdDZWQThscmpaNWpa?=
 =?utf-8?B?Ny9adUZlSEJaRGIyYmEyN05XandIRlJTclJ3NHk2cS9jNFJibDdsZDliUW5o?=
 =?utf-8?B?QkM1ZlJRUGUvMytvSVFkc0pnY0xVRlVzQjNhdHRVMEFqaGhDWEpxL2Rvamc0?=
 =?utf-8?B?bGhYQmQ5TTNxQ2VYdkVHSkxwWEVEOVdNMWthcklaT1Bvcm1PbXpmVGozMWRH?=
 =?utf-8?B?ZVAwaitzS3JPdi9RTGVDVndaSTR3RXRaRHhXamJUNVExUXlCZlJnUGxzQnZJ?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7eBOqy5yRZCdnXK3nSQj371n5poHM04dYBRZd8tUfcAgfhlJ7JnEmUQNjfaLUnce5QbBG5WMdDIjGQUcc61iARHq7xpoEKBKC8klFlce/qnm7b5FTjYuMYYT9dMjTxM5IZRL+ZUROpdFmo8Pr65qjDEDXhQQ0MjCtyvLqWgOBNQxspdOd8v+uIvwe88FHvKY1SM+nkFdbDfFPFSzcuxpSolUTGtTLtftJY+RMRLnO6TPfFekcUgUA83pW+hrus9vNv0PmoYuhixTFtYXBfb1UUcjTAgTsMAyIjBqxLqcwV/AnRstXgsqmpuqi/Lcl9LX9fw43I9l+P9IN7RNcPQ7fQz/27FD7HAfvAUURXkbp4IKYqczkU4YTZlQRHazae0S5G+ni0kDkY9utbWifQtL2Tw+R81o7xmJYHLo+SUIc56Z+c866FGWYvtVATS7kKee0hoRljp3bljID5rVtKbXkhvPOg2Ag6FQe9oCtfnZStMN6eLHgNgq0YXafEVE2TRhFW51VueTjE4neWL847OEPCZRHeezmFqpc2imBZrzAIs49Wo345JrY/sGUL0uYSNAn/wDmWyeggrUmShb5rlwOM1rhz3qf49dMak7lPlO38HuSntck1LYbWRNVz8PjBg3LYTfkdztAqtUvC18XWtcEwuwFAK/wNpO3ey3fD5bWzkRNmn0jrPj9rCBp6tSIfmN91FrSUOrpV6O4dNOWEKI96U5YYu+T/jqJECbkay15XlNTZngrjgaETGkVHTSEn9g3Kr9rUd7qijl3aDqIN5WgGJd+KuDUujta9+C78709dzr+6kq1goNnygXNJGV9FxFV4q0qXwKl+UXbEUqgVKlTkW233pIc+O1swa9XoiisEMWlbzM3/Rp65/tkWc7sCyFPzwye/LCbbriGPrOiLieejgqbLpz7/3zFKCAM6V4eXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7b69e5-7830-4c55-04e9-08dbc65bf168
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 11:04:00.1200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KrWf9Gkuoeyd9KksrYE4348EFqbIkwYbTEkvO5rJZTruAmyi7YzXHV8eHAtmXo64xvl84jwmqvoO3W9+SMyqqL6NtY1WTPRx9MZBp2baS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5266
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_08,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310060081
X-Proofpoint-GUID: 1VzdrMHRfyJg9Z3FUZHrLeEPelcNSd0U
X-Proofpoint-ORIG-GUID: 1VzdrMHRfyJg9Z3FUZHrLeEPelcNSd0U
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
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



On 06/10/2023 09:45, Eric Auger wrote:
> Hi Joao,
> 
> On 6/22/23 23:48, Joao Martins wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> Add a pci_setup_iommu_ops() that uses a newly added structure
>> (PCIIOMMUOps) instead of using PCIIOMMUFunc. The old pci_setup_iommu()
>> that uses PCIIOMMUFunc is still kept for other IOMMUs to get an
>> an address space for a PCI device in vendor specific way.
> double 'an'

OK

>>
>> In preparation to expand to supplying vIOMMU attributes, add a
>> alternate helper pci_setup_iommu_ops() to setup the PCI device IOMMU.
>> For now the PCIIOMMUOps just defines the address_space, but it will
>> be extended to have another callback.
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> [joao: Massage commit message and subject, and make it a complementary
>> rather than changing every single consumer of pci_setup_iommu()]
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>> v1: https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
>> ---
>>  include/hw/pci/pci.h     |  7 +++++++
>>  include/hw/pci/pci_bus.h |  1 +
>>  hw/pci/pci.c             | 26 +++++++++++++++++++++++---
>>  3 files changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>> index e6d0574a2999..f59aef5a329a 100644
>> --- a/include/hw/pci/pci.h
>> +++ b/include/hw/pci/pci.h
>> @@ -368,6 +368,13 @@ typedef AddressSpace *(*PCIIOMMUFunc)(PCIBus *, void *, int);
>>  AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>>  void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque);
>>  
>> +typedef struct PCIIOMMUOps PCIIOMMUOps;
>> +struct PCIIOMMUOps {
>> +    AddressSpace * (*get_address_space)(PCIBus *bus,
>> +                                void *opaque, int32_t devfn);
>> +};
>> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *iommu_ops, void *opaque);
>> +
>>  pcibus_t pci_bar_address(PCIDevice *d,
>>                           int reg, uint8_t type, pcibus_t size);
>>  
>> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
>> index 56531759578f..fb770b236d69 100644
>> --- a/include/hw/pci/pci_bus.h
>> +++ b/include/hw/pci/pci_bus.h
>> @@ -35,6 +35,7 @@ struct PCIBus {
>>      enum PCIBusFlags flags;
>>      PCIIOMMUFunc iommu_fn;
>>      void *iommu_opaque;
>> +    const PCIIOMMUOps *iommu_ops;
>>      uint8_t devfn_min;
>>      uint32_t slot_reserved_mask;
>>      pci_set_irq_fn set_irq;
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index bf38905b7dc0..4e32c09e81d6 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -2639,7 +2639,15 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>      PCIBus *iommu_bus = bus;
>>      uint8_t devfn = dev->devfn;
>>  
>> -    while (iommu_bus && !iommu_bus->iommu_fn && iommu_bus->parent_dev) {
>> +    /*
>> +     * get_address_space() callback is mandatory when iommu uses
>> +     * pci_setup_iommu_ops(), so needs to ensure its presence in
>> +     * the iommu_bus search.
> the fact that it is mandatory should also be documented along with the
> PCIIOMMUOps struct definition and enforced at  pci_setup_iommu_ops()
> removing the need for checking iommu_bus->iommu_ops->get_address_space

OK

>> +     */
>> +    while (iommu_bus &&
>> +           !(iommu_bus->iommu_fn ||
>> +            (iommu_bus->iommu_ops && iommu_bus->iommu_ops->get_address_space)) &&
>> +           iommu_bus->parent_dev) {
>>          PCIBus *parent_bus = pci_get_bus(iommu_bus->parent_dev);
>>  
>>          /*
>> @@ -2678,8 +2686,14 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
>>  
>>          iommu_bus = parent_bus;
>>      }
>> -    if (!pci_bus_bypass_iommu(bus) && iommu_bus && iommu_bus->iommu_fn) {
>> -        return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
>> +    if (!pci_bus_bypass_iommu(bus) && iommu_bus) {
>> +        if (iommu_bus->iommu_fn) {
>> +           return iommu_bus->iommu_fn(bus, iommu_bus->iommu_opaque, devfn);
>> +        } else if (iommu_bus->iommu_ops &&
>> +                   iommu_bus->iommu_ops->get_address_space) {
>> +           return iommu_bus->iommu_ops->get_address_space(bus,
>> +                                           iommu_bus->iommu_opaque, devfn);
>> +        }
>>      }
>>      return &address_space_memory;
>>  }
>> @@ -2690,6 +2704,12 @@ void pci_setup_iommu(PCIBus *bus, PCIIOMMUFunc fn, void *opaque)
>>      bus->iommu_opaque = opaque;
>>  }
>>  
>> +void pci_setup_iommu_ops(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
>> +{
>> +    bus->iommu_ops = ops;
>> +    bus->iommu_opaque = opaque;
> maybe assert if both iommu_fn and iommu_ops are set to make sure the
> conversion is not done partially? If I understand it correctly either of
> those 2 ops should be set and not both.

Good idea.

