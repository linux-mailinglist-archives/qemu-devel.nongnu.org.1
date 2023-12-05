Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9468057B0
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 15:45:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAWeo-00023B-9O; Tue, 05 Dec 2023 09:44:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAWem-00020O-Df
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:44:16 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1rAWej-0000Zm-2e
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 09:44:16 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B5Ei3aa024241; Tue, 5 Dec 2023 14:44:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=VUP6JRvETEGEXVo4fJZKlrAoyJFS39ktiWguFpuO1jo=;
 b=PLO+bkwE2+QoT7j61fM7fbt9SBXSyc456zge0DvaXePrw/+pA5QdHzCBt01HtzFxwpsK
 BopQBfosGPLAcIYl1cW6Mm4k+aNj6vpkJbAM4/2FDExEtOqeFfTY+AEre+mpZL7SMeru
 Ghkd3nmlCOE1HWJV3R0jRTFCgPHAdUrv8fwK4MYN6volQU3hvoRh8vud6YfECULzTZ4D
 EdERxFstWFEFGp5l3AmUu784ClawXg2rLVeHgiFEr3CxuQIGqupGn01JoJTe/LqcyCZ6
 Ecof+jhIzs6olN2EU0XiMcH+gRS331VJEtRLIz3ODQ/bOy/iB3JBdU6GwyC3ws+ClsAt tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ut0548tg2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 14:44:10 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B5EQN0Q014057; Tue, 5 Dec 2023 14:44:10 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu17k7yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 05 Dec 2023 14:44:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjlRuC/6jewv5nMWQ61SqRBMzc8e1VbNabCQ8b5dRhvtpmAt4Ssj4qlKyM0H7swVLOSOo/aZQQF+dZp0t/aYyf297F/i0wnIvf0r03v/qBHdxlYLC+3L2EtE4bIlm+2/y7A/9Tgx523YTyqp9eC4b46YGLIVb0Ks7FWHI2/fAK7uMijWtdEON/kkEPGRe6aMs4Aarilw4EBFz3dYCMfpO+o/TTQY/vxLf0yiqEAda3HFlfErlmwRR4FPTGNdEv5ULrvzKI4+VdQAwY2FewBKI7IVrRfF21wenovQuNf4FpRdfspn1HJt8mh1ZnRLjeD0aCFQRMewXs5+vaHpozrjOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUP6JRvETEGEXVo4fJZKlrAoyJFS39ktiWguFpuO1jo=;
 b=BG/OlStwrWnKaHc8MFSetUyTfJ7qsmpi6K878DTown3+MYjNgzSyMposyL9e3Z9GlJaoDaYYVKwcGfDDxw7jxJg6sMPCbwJR+VFFaIpZK5W3m695MhINiRKIfTs11YD19PEd4BpDYFkB4ZllG/EK6pc4A5nxidrtbxgGeALoYVbefQyYZGdLdmkv6YZI7LPiOq72zikpaon3zde3pBthb9DXTI5tXik89njC0F0RUpsqh+lT4Xt7EMK/RRhh6QaDD68b8X8HN+TG6xJjROMosUvggMvwF62Sau25NlSYTXQmEZwwauVhLY6J/a0diT29y6LdTP4/Wo0XbNg4pLypaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VUP6JRvETEGEXVo4fJZKlrAoyJFS39ktiWguFpuO1jo=;
 b=wrm9wxG/5ifhLR9PHUrjXK7Fi0eGxCcRAaXcpAFVlDyJxDIUTDEcNFLXB4VSuB1mbTegg4uUt1yar0gWz28RuO12GD23NSJ25h9ERB5KSvdzvv2c3ZRPP3h1x0bqDFkNKrDRkhjRVhvi8eUW8c9NtZgWXwDFYTRqSlcO2dwl5cI=
Received: from DM6PR10MB2523.namprd10.prod.outlook.com (2603:10b6:5:b2::27) by
 BN0PR10MB5367.namprd10.prod.outlook.com (2603:10b6:408:125::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 14:44:06 +0000
Received: from DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::b99c:2487:feac:f0d5]) by DM6PR10MB2523.namprd10.prod.outlook.com
 ([fe80::b99c:2487:feac:f0d5%4]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 14:44:05 +0000
Message-ID: <82eae840-1513-18db-d75a-ef758bac6b87@oracle.com>
Date: Tue, 5 Dec 2023 09:43:57 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, imammedo@redhat.com
Cc: miguel.luis@oracle.com
References: <20231205002143.562-1-annie.li@oracle.com>
 <20231205002356.1239-1-annie.li@oracle.com>
 <f873dd1e-b5ee-452e-9dd7-2f25ef2ada7b@linaro.org>
From: "Annie.li" <annie.li@oracle.com>
In-Reply-To: <f873dd1e-b5ee-452e-9dd7-2f25ef2ada7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To DM6PR10MB2523.namprd10.prod.outlook.com
 (2603:10b6:5:b2::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB2523:EE_|BN0PR10MB5367:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b5eaaa-46d9-46a0-3a07-08dbf5a0a172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: stzfzNveg31/vUUTU9TpK94m8E1AWyK7WDWuqqK1RdqCADPDRqDHwVDNtD6HTd2De6srupwtVkaUgf/Kmh6gVCQSkOdbrrjJtbOIRjRaEDalFHrHLZSTf2NlpCZnlCe8zlHF6ra0TaEpANjYvoLgk4W2LXQ+cm3DIJ0gpLbGZtodLojWGz7JJTb7pLzYrINSC0UJtuxzQ1vHDOkHI3MZe3sId8b1BpfTL2bkq6oUY7GGTa/Iig8vHo3xvALAVim8oTtOaSMC/XgbQX0ecqRAMkjofofsMIuL3WMyYlAKzyoy2XiIgT8oSdVhHivOxsL9OMyJYTOBX7EtFo1wbguVsd8f7RyvlqOM80sMs5HbqddxpZ1psRGkI6b6Pdetzmeaqqt+DZ9ADIA+tncWhSshuZeh2lsZcCvNoimvpWywjgRk7le8y7H9j/H2NlrBFuQXXBWirGBb9gH0KvgE1957vElGBecGNUyR3ePNXtz3YOtmdPfvJygks+JF4bQnU8MY3vYKdI7ZSY7e6PHlAYIsFWK73NsPPQo2rMpSK/J+k4w/xSJrB0vjr0NiU8ldo320UQ1zP5JyZzsuhm2vjN+l1YvLwk9tdj53aqrIe4Ah2RMWNHdVb/QcfYT4Zts1CQhU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR10MB2523.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31686004)(6512007)(478600001)(6506007)(6486002)(8676002)(966005)(53546011)(107886003)(6666004)(2616005)(26005)(4326008)(66476007)(66556008)(66946007)(83380400001)(8936002)(316002)(38100700002)(36756003)(41300700001)(5660300002)(86362001)(31696002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTN4RW1lT1RzSFFVcVNIYnFsNzNqdlZlZ0RwWFlwQmdiL3huTHhLRzVVSHhO?=
 =?utf-8?B?QTl0NmpQRWVJaHRsVHYrK2R5NERaTmJGT3RqTENCeHJLT3MxT0tzVm0zVUQ4?=
 =?utf-8?B?Y0lCT0IyT2RIWmw5aG1XdlU2SGhjMmJPZWY1SEtsb1lPNTRvTEk2ZFJXSTdP?=
 =?utf-8?B?ZTI0S09ZYVBqRDMyVkN2MW90UW8yMU9yN0JmS015cmVCTlVzUytPeDN3NXhJ?=
 =?utf-8?B?dTRQYS93Y3YyOHlYbytEQStSeTlmZGpKK2RhaUtteFpFdHd0bVE2NmhZWGpL?=
 =?utf-8?B?azRuRjNCNUhSMFI0UzQxbitwSGUvaHpxeC9qT1dwcGJmSm9SdjErcTlPakZp?=
 =?utf-8?B?SEtLVlJjZ0NrYjFrQ0dMTDZzaVZFaEtqdkltVDRJcm02Y2RPSE96Z1Jzem5H?=
 =?utf-8?B?SUcyZzNIZi9MVzNSTnhOVnp6YStjckdIYlJoY3k3TTc0VzZ4TncrRndvNE9X?=
 =?utf-8?B?UWtqS2FSakcwd1hMV1l4T1NOeW13UVdFZ0dUTTNNWUMrTFBNa3dmTGxSaGpl?=
 =?utf-8?B?b2RHUXZmaUc2alZ1UURXcUsza3BlWDI3ZXB6Tis1aXFXMGhMV2hoNWRseFJZ?=
 =?utf-8?B?Z2hnL0dZcy9kd1NSQ0ROdmFxcnYydTR2QTAxaWdVUURXaUJJdDRWY0J6MFRq?=
 =?utf-8?B?VHZOM3VWYWFSdzZPQ2Q0Zms3NXp5dkR4d1c1dkJPbFA4eDFZRXRUb09ON2dW?=
 =?utf-8?B?SFdiMHNjUkZtMkVtQXBsb0xDTkdvS1FrL09CZllSSWJFOVJLdkd2aW0xZHdn?=
 =?utf-8?B?S042YlhuLys4b29wazV0MnNsaVpjUytlK2pjeHNQSURZTHp6RkRVbDh2WGxF?=
 =?utf-8?B?VTh4ZTZ5MmEyaFJ5cFlhczQ3S0pVaXBjNXlCYVV4YjZzSnV6SkRlZjNBTnBQ?=
 =?utf-8?B?ZGhBOGpYc3dpNmNySE5WUk1wczlZc3VxOGx6MEdiZDVxZE9PKzYwb0U1dTBV?=
 =?utf-8?B?aDBpb0JjQ3M3UzY0Z0FxeGNPNkVsQVVJOGRnOEFvVkVGM01BY3lCNTFZdW5j?=
 =?utf-8?B?MEZYU005QnNobGMzZGEyUUZ4RDBXcC9jT2s1Yk5pb25iVVdZL1dtdWlhWjVS?=
 =?utf-8?B?UmNIZUFqNVJtMEtmMXVPVmlqODNIRGwzM2VxU0tEck1XK2YrWFVQTFZGeWNq?=
 =?utf-8?B?azlRc3ZGK1A1UDVQSDdGSUd2MHA2YXA0bC9ORVdPblF5MDl4RW5LL1h4cVBL?=
 =?utf-8?B?bG1MMVRUTlV4RDl5MUc1SHY4MmY5b1NNNFllZmJSUHV1MnM4NlFieUNjdDls?=
 =?utf-8?B?bHozN0lwOS9Kb0JGNzk5bnQzbFg1V0tKK3JIampOL3NiUHZSZWh2TGtLYzQ2?=
 =?utf-8?B?N2FIay9nblE5WTVkbDFzbytMcXpPZFd1eTNuT0hWazFmVFRaYWZ5cFZyblpa?=
 =?utf-8?B?UmQxeEIvemd3MTA1TE9UNjEydXoxSmNTbnlVaG81QUU5Y3pkNVFiMTdKMDNi?=
 =?utf-8?B?S0dCREhIZ3R2UC83RUFVR003RCsrMUlrZmVONVg3emF2bGszRCtHd2FPcks2?=
 =?utf-8?B?ZGF4WXh4M3ByQWx6dGVIWkljTjFUWlNndmJXTWJLV2UwK24rOE10VlJ4TEZw?=
 =?utf-8?B?d0JxM2RDNGNQRGdsVjRtcEJzdGJnaS9XMmJHL3RjRVdMTFpKSlYwN3hLRzJM?=
 =?utf-8?B?K2lSdFB1RnRrVUpRUE52b2RKNG1heGgwZzRkUXh0bUtyTG1PU25GTk5rdFR0?=
 =?utf-8?B?L0JnTHNoNzRtSEN4RmRrVEFCK0hsZkNKTC9VOVIyTVY5SEZFMmhnU0JVTnFy?=
 =?utf-8?B?eHFTa3p6TWh6bGtrM1UvcGY4MElUbnJ5SDYydVJocnM2akF2Y3VIZDRUN0xY?=
 =?utf-8?B?QzVxb0x3Tzh3bnZNQXFJMDJBRjF2MU95UWdOWFVrb3RjcXBzNFpCTHNUcks2?=
 =?utf-8?B?QUNadXZ3bnFMQ0N6RjgwUEt0T3Z2UVJkN3pYVGg4dDVtYWRmb21HMjZDMzRh?=
 =?utf-8?B?M25ZVmFxRTluYjM5SHp4aUxpNFliWlhXL2dKWlZqUHp5VWd4dmlDRGs4UXNS?=
 =?utf-8?B?RmFwdGQ5SXpLOGgzbGRPMVdzVC9JeUFGM0pRejBTZkFHc0wzcFBlRUZXMDIr?=
 =?utf-8?B?RVNCTlN4dGQxU2prZUsxQ3h1TkR0aFhDTVFGOUNpM2xEWHY2K1BIdWE2NXpP?=
 =?utf-8?Q?P5ZbLzlWlpcJAHhUcnRwCL9XJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FbKbchvHoE66/oHKgBvXYQ8cJMDcML8Kg4F/eBVrMbY1c0mkRrSaRFFe/vjUlM+FQo2Io3K6yku1Ah9Js91ye4/WgW6N1t8dRBduTO7/07JnKiZi2nHW1tQumryhRZcnQj65y6cEWbT3WPkKB/fYmv7OxMggotql+/H5Vd9ODv5hwRN3mGgOYItZloH+ELg/T8grVnARcwfsuh7c+M0xnVnl2exkf4GQMxzeIbNvag0lajqoyWfeseuXl1JBNVguvsUVMN6xd4IfY53Sp8BEtXXPVS/YO5nDzDsCnkdwuEkkkC2qe+/OJ6aAK3e/E8ZA/dqRO9D6xeB9Szlx7Efx9iWoqttFsYQdo2MjvvbSOnwZ3G/enMhpTAiAIvzl+JiGCvB8zjB3fB1Sx/rFc7boVO/WFa8gyFXX4Faxi1/UEcYVCjZypht0pUC6/pN8PtNDpG201dvrxI4R3u0rQOkxJfE/mILi5WNteofqtmHBc97/+69HtMdRFm4DN2cnIPByBeqvL+t61Bpiy1uX4I+sZKypaL7v1nq/r3qilJrbyWnK1vGU8iYjJ2pvfg8CaBv78AFzawTKaVrmCUDwbQJFUrWmsP+QOKebQnciUaEwKPsPexfHk0aeoi4xG7JZYNNtBLuf47FAwGsbv6ys4tZakiWXaKmyMGBWTgt+4KAVmwoHUzRAXra2SOMBTndHip2AyC6gpLEyf6tQWv0Ykh91Stx7d2P5yjWqMkYK2sTJa1pBr6XMccJo41DE/UpJan91qEOAzVMBv19DiB6TBkGyDJrReTnyqeR6oEnXM/mzGrVw1ileI8eW90Ekb1eWnD7z
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b5eaaa-46d9-46a0-3a07-08dbf5a0a172
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2523.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 14:44:05.8583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CDOmxhuw0o1S1AF0d+KrXaEPiK0pqMZYh+Von8jByfFV/gXlNvY7h5xru4/vKQw39d6bVuDWl3WI8++s0G8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-05_09,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312050116
X-Proofpoint-GUID: w-K7ZNy7zWrYdzn-11kmVQViOPQ37fN6
X-Proofpoint-ORIG-GUID: w-K7ZNy7zWrYdzn-11kmVQViOPQ37fN6
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.02,
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

Hi Philippe,

On 12/5/2023 4:44 AM, Philippe Mathieu-Daudé wrote:
> Hi Annie,
>
> On 5/12/23 01:23, Annie Li wrote:
>> Following hmp/qmp commands are implemented for pressing virtual
>> sleep button,
>>
>> hmp: system_sleep
>> qmp: { "execute": "system_sleep" }
>>
>> These commands put the guest into suspend or other power states
>> depending on the power settings inside the guest.
>>
>> Signed-off-by: Annie Li <annie.li@oracle.com>
>> ---
>>   hmp-commands.hx            | 14 ++++++++++++++
>>   hw/core/machine-hmp-cmds.c |  5 +++++
>>   hw/core/machine-qmp-cmds.c |  9 +++++++++
>>   include/monitor/hmp.h      |  1 +
>>   qapi/machine.json          | 18 ++++++++++++++++++
>>   qapi/pragma.json           |  1 +
>>   6 files changed, 48 insertions(+)
>
>
>> index b6d634b30d..3ac69df92f 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -297,6 +297,24 @@
>>   ##
>>   { 'command': 'system_reset' }
>>   +##
>> +# @system_sleep:
>
> @since 9.0
Nod
>
>> +#
>> +# Requests that a guest perform a ACPI sleep transition by pushing a 
>> virtual
>> +# sleep button.
>> +#
>> +# Notes: A guest may or may not respond to this command. This command
>> +#        returning does not indicate that a guest has accepted the 
>> request
>> +#        or that it has gone to sleep.
>> +#
>> +# Example:
>> +#
>> +# -> { "execute": "system_sleep" }
>> +# <- { "return": {} }
>> +#
>> +##
>> +{ 'command': 'system_sleep' }
>
> Do we want a 'mode' argument, starting here with control_method?
As what has been discussed previously in the following thread,
https://lore.kernel.org/all/20210920095316.2dd133be@redhat.com/T/#mfe24f89778020deeacfe45083f3eea3cf9f55961
the Control Method Sleep button can be shared among various
architectures. It is very likely that there will be one type of sleep
button(Control Method) implemented, so the extra argument
isn't necessary.

Thanks
Annie
>
>> +
>>   ##
>>   # @system_powerdown:
>>   #

