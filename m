Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E526A731525
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 12:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9k7u-0008Ag-EV; Thu, 15 Jun 2023 06:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q9k7q-0008A7-PF
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:22:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q9k7m-00073Y-Ay
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 06:22:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 35F9AduK011566; Thu, 15 Jun 2023 10:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=74ApJSbzXfoDDqZ7P8zlW8I6Cxs/aJkOkiDnY6eq5MA=;
 b=dSusckAVTNyIKUJdbjs+lD5jdx4wX9da6zz5UaABzPPhmmb31pzGOn4pkHCNKn951P1R
 P1RviyERhRMeQCVt5FnRiMxF9SrdXqhXvi5NYx4aqdh4mmwrf2JFYLxD96yHPkG2JCyL
 G27wEBBc1rTcYjx7/uoy0ZKRopZwKigTsxV4winNo6Fqq7MGSF961JUFbBbfVdh23w+g
 B5hVVPQyurJZ8jWG+zSKS7jQ1jJg5ySgT2XGVfb4tTBAyMnUfeMooSxF4VLWO8JAXhRd
 tyOEipJ4gvdevPjWlU+Z4kMFdGyxkSuf6X+Xw9NGbqoxnk2b91BNdL/aR05VWOClaNR5 Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hqusp7n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 10:22:38 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 35F9v11O008351; Thu, 15 Jun 2023 10:22:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3r4fmd12cm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Jun 2023 10:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryv9gBuPwswU7godxH1BCnBCFFSc8f4aTWaPNUwmnKrFH5XcfpCH+6O3QD2JAl1pc1Te6S6XkHBvdGYYX932Z/AfFv8R9Blj/VP8Oxg9R8WFbEtyN0zMMBs0InqbZjuDzhGhzf1CR0BieJmYThnWb/N7Gip7CneG45bBikh4g19mImtc61wQlNqvhd4/kLCwXLsJNfZVh/NxIMwEY4X3ygJtw6X6moDFn3V8LeaUorJ5YDhV6MgyYcDd5+McDlvt3Jc4CMCWwI9hgTyhw3XLUWBqxZcbiwO/YDTuU67IianNy/WUFZd32zyygQLoAheZOm+gWBLnSU8C7dcf/OKtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74ApJSbzXfoDDqZ7P8zlW8I6Cxs/aJkOkiDnY6eq5MA=;
 b=BW/yXIenCbTIiz50oUypWyTU/owJkiEuRWCCL39AZw4DK8Zj/hl2L8i+ueFy8eBkv1EcMOMEno0WygxMxzKZqvaGGiHI4aD3tzKf6D7vLO8hmvJHPRS5Om1v3fLpWBhDtuvgPk8wbOcgfulJ4T4uVj+1fqQGLyfuDQMeLzdt4+KSt9ZdQLi80aXcFLk2HQV1p4cHJk8hgRG6b+5uv6/UrZt7ps46dTpQitfZfp2htJePb6IeZVuO2SlMA+C+LjzP9voVy62grOe0uJ/xJo6rwB6JMTOVpCL5UJF/83I2FTEQP42W55KtCJmIq6pNvBQqf4Px+Zy8XKAbU/vKIDe3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74ApJSbzXfoDDqZ7P8zlW8I6Cxs/aJkOkiDnY6eq5MA=;
 b=Zj4jpVvCYLx0rfApklDacF7P16d+b/F3vZ2A754P7crWVmZUYibBCaIiD3Vr9hmd7YZSt7MRWdTfRZIna5Y1VWBSDYc2kmRejsGkqpRPEV1BSLUuqRtVNccE3Iwx2fY1A5HnznjZngZqhwTVU+hdlXSrEI3BW21chTkuk6n6sII=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BL3PR10MB6090.namprd10.prod.outlook.com (2603:10b6:208:3b6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Thu, 15 Jun
 2023 10:22:35 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::f7ba:4a04:3f37:6d0f%4]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 10:22:35 +0000
Message-ID: <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
Date: Thu, 15 Jun 2023 11:22:30 +0100
Subject: Re: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0036.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::49) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BL3PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 68802bfa-b04c-45dd-88a6-08db6d8a6ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAdff9+JOO6N5StzXbOFMvqJbIK3z594kalEFvbxnOayF2b6X3453fDbTqMyF/oj76Bebjd/n9a6EnlNaK1bNWCGY7MKxSbJEvrGa7yS+RU9AXvrInLAxXvGX1jMpMhuXfQ2e+M72G2mh2ySrgxDaZdfY0i1D/aT/L/1+yOvxXem+RPjollZvwoVw84yMHCz4QcN24epZJljsGY4IaVAKO11tLIN0vHRZ9E6PMB18g8rd5WD/vSrLoxqJe/hRuBdsheZra95Ez/Hbbj4dE82w10ZMCtvAyJaiuyuS0hyXP8vjFoJsjfFndcqwIQGGfVW5QdZlBv3tPa0XlBRFy2A2bxVbPO3trS32TcuTmNVqreYL1+WmzyJGBHWcj7LePhRMO8yjLN9W+456pDuXKygrNz5v0AIlUeysQOfSbK9qrGqZUrWBQ9epaSxkcxKG9RI+lBpeQCjyOrvrrkrti3cSHpr7yt0OaTMi+3JBYolijTfEFT+aMXSsXM/L/z1zaUg6bq1q7eO4d7BQWNLu1jYdqtdLnYJoNsOSwpOJQAo72j4MFN01+LENNoqbY31Ig2P92VnESrOUIxOQT/pL5z8HsuRUy3dKZwQXegnJCCQhTQbhnTl6XCcM18SQBCtIE0v
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(36756003)(31696002)(86362001)(2906002)(31686004)(66476007)(6486002)(6666004)(186003)(6512007)(6506007)(83380400001)(53546011)(26005)(5660300002)(478600001)(41300700001)(54906003)(66946007)(316002)(6916009)(66556008)(38100700002)(2616005)(8936002)(4326008)(8676002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnQveWhjWVFJQTJRaWl0VURUWE1lWVdpcGFGS1VWNTFlaWdzYjBZaTBTNjBs?=
 =?utf-8?B?ZElVR09ScFd6UkhGSFhMWmdGQlpsc3dEaXljNDdOa25TSS9ka1o1SC9LVUdn?=
 =?utf-8?B?NTl3UUlrcmpCNzM5ekg1MG9nazFWM28wZlFCVGtEMjZNekg2S2dtazYzZWJT?=
 =?utf-8?B?RzR4dlh1a1dzMTN1MHFrMDRlendQK1p5QnZLYmUvRllDSXUvckZSRzBiRGs3?=
 =?utf-8?B?T2RqdDZXMVpQUEFaL1F6RGFQbmVZdHlsRjNSSktrMVJrK2xqRDFZbTYxM21R?=
 =?utf-8?B?dDhoa09Xd1AvY3FMcjlmaFZHTEhqR2dXMHluSnNZZStRQkVrWnF2NFYza1hr?=
 =?utf-8?B?dzQ2SktvMEJkZXRib2R4ZGVIZ2JORFZkWnEycm8wRFc1RmloYU52S3g4UTU5?=
 =?utf-8?B?eHlNU2k4TmkyclVsU3lvSXNtU015S2tQYTNuNGpZcWFnUDM0MTFNbUl5OTFY?=
 =?utf-8?B?OG8wbVp3ZkVvY0UwVXZBSFlmOGNVOGtEbFNVNmpOMXBkTGxtTldBSlc2OFhl?=
 =?utf-8?B?c0NyTGRFSlc4WDdjaTRkSktvcm8zNFBGUlo4ZHE1ZS9ua1VEeVA3RThPSUVw?=
 =?utf-8?B?WldWeEJoMGc4QmNYZDNQY1A5aytCSjMzVk9PRE4xU1RBZ3JHRk9jS2xjellK?=
 =?utf-8?B?dzZTeHBNVENJZmt6ZEYvNStRNFB1ci9kR2tUWjJjT0c2UmNYRWwxQ2ZXVWhz?=
 =?utf-8?B?NGxXdEpSd0JmSENXZGl0RVlkRktEcjI3VHJKNWs2djFvMVIwNVJuNjNDc1Ir?=
 =?utf-8?B?VVlFaFQ3eGxjUXovL01jdThHekF5VmRITmdDOFFkaEtGZHduQkZyZDdxMGN5?=
 =?utf-8?B?bGtTTktwc2ZvQjRHazBCQ0ZaUlFaREIyc2RvUnVDNjNoVzNWclVYdjBPdjhI?=
 =?utf-8?B?eVF0Vk1wYlRhVkNSZGE3S2JaT3NzMzdrY0pJdndzQ3FYRHJLSGFNWTlEcEw2?=
 =?utf-8?B?VllNWTFJMG1kLzV6RUV1b3B0QTVUU2xpc0ZzM1NzT3I2dDhsZVl3N3loVzkr?=
 =?utf-8?B?c21xYkdTejJjenIvOUtnYWtNMURMaDJaQlJkYnQzcDJYVjlnSFhZcSt4ODFW?=
 =?utf-8?B?Ym1ENE9tMlp2VzFQZnQ0aEJ1elBvVGhtU1liSUs0OEZQR2JESUVHVERSRkZs?=
 =?utf-8?B?di9ic0RkdWltRWZ1WHd0SlA4QmdvNy9NOEVMN05HdEZza1hlV1dYbWxic21y?=
 =?utf-8?B?YU5kTUVqeDExd3lnWTE2M1Y1VkRjYlRyK25MVUVzZFVrYTQrZldxRjFna3Bv?=
 =?utf-8?B?Nk8xN0c0R2RkQUNGdDlwK3lvT2ljQnpKTnVGaEFOWEZkak5HUEtiRUIwdi9N?=
 =?utf-8?B?Vm5oWm1VTVpPVHNaNENzMGhjQ1phaENoU0RrRit4c0E4ajkySnorSVhpc1p0?=
 =?utf-8?B?L29yd3lOMFhOZGdVbEZ6aTJDeEt3czgxNGRPdWRWRTUwSFFDVTc4VTZCbVlm?=
 =?utf-8?B?eStSbmtMWDlQYVhVZjlCM2Fzd2lqSDJsMEp0ajhWOHA0bkc4WGVkTmdFWmN6?=
 =?utf-8?B?eXU5VDBvVGRNZktlSlNVajlzRmxkWXN3SjlXdGtHZHBRT3R2TUM4YzNiTW9q?=
 =?utf-8?B?bXluams5YU1uZDVQNWFwbjVDSk12WFlmamw3ZUNXZVZmL1FRMnJZSldlQnow?=
 =?utf-8?B?VVBMdHlJRkdESy8wT2dUYXArVjNGeDVySUo4RFlob09jNDlrQVIycDdVNUhr?=
 =?utf-8?B?YXJ5WXJZN1FROVEyMmRIRllKZG9objhmemloMDNIQWFoTGo4MFVqS0lvekN2?=
 =?utf-8?B?MWdrUEZKWGhobDk1S1dTK0ZRL2hGSjMwYnAzVC82M3dDNGV0aFl5bDQrWTQ4?=
 =?utf-8?B?cTg5L2x4dlJPM0JlSHl5M284elZPd3IwM1ptamI4SDF3OXppdC92YUhjTi9W?=
 =?utf-8?B?T0tpWmlwcEgyK0dqMHJpcW5ETnQ3MFJ0QmRCQXZHOEdKeDZMS1hFMHZkWGlC?=
 =?utf-8?B?UkxWd3hzaWg3M2NnWG1UUFBCTGo0L0FQc1BiVUNiZ3l5VW41Uy80VlpKWTRv?=
 =?utf-8?B?TVM5b1h2KzlYMWsxb01qUFpQOFBYRzlhWGFjRGpRaXZHd2Npbi8xZkU1Q2VT?=
 =?utf-8?B?RDZZa1gzWENuS0lXNUlBUXU2c2wwVXN5U0NHbFY3aFBnRlhQTVEva2tRZEtH?=
 =?utf-8?B?OWk3UjBMLzBobnNZRGJXQlpMREtXd0wvMENXaTZzSFN2L2hvNlJJeE1lK25T?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BXFRhH/GLp4a6IQ6MLU4Ew2UCi2kw9CwDGWONtVTQhasf/3MbN9EvA+Pl2EMHS8WO0Ufs5m6r4h9k2QVMQNGN06975XizneU58i2YBsYjMZFPvs6NWxsl4f00UFvVA+qM1p3ZT/YsNz5KzsP5yFQsHBoofHFdO1QxLdOh99UofCQ7XzgsnAg11BXsgvmaaIwUTZqMGSMY5PS9g7ZwoKrlRmhunDecee9b+M2CexKHyYKQptsTkhcSAazMH+OBw/JUj6aTW5ZWntPI5nNEwQt+cg941WFbVSr/B/XbrYsuyW2YSEENbkcNZ/lxOyd5n8uRJnCi9YFW+R81OeBf9fC+5vlbMvHVZv4v4EP7FpGYU3T9JUTmbN6939zW91uvTCqIEEuYO7EJ0VqAOwdzGWs+1YhQXwvZxc/a5XnKNlkmcSE6fO1HJH0ps+zJhEqjqk+kXwXmzh2U8SRJ+DgOybZrsVLdk6yaEy1s9xOKTn6ZH0O9Mwhs+kcdffRYBIVu9EmS0nNOzQcUTFIzP1eFIL2Hwo1pqpoGDtC/Dkhqbrep7E/OCh5cZamvqM4JLiFmzEnoMSy1DrdRbLOjsf2NBXB4YqW09+3a93TzTo49NIzIdAR5BvXVxhtiJ7rfF6C77SUO7JwJ7Ui6saxcPr1rfyiiXvznfMNhyIg0uM6Qawl0kBvGw+H7kaJ5DTk3P7BFmMi1l8J4LpocNOrZsNnSp9Gh/eDBG4ptTRe2xJZUj3VsWkfaJ6kCa74NvxlVnvC9EavGuUbpeKCGekO0A4j4JiG6m8r9qsW4pjf0AeEijN8wEzB8uBhYmOiZVbstpmgGei/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68802bfa-b04c-45dd-88a6-08db6d8a6ffb
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 10:22:35.6633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqNCytjryzKrJnDoRQ5Ock6XOheVGGY0JG2mSe11sXDsK5VVHoSnga871bv+gGymNW1OprCziDSWfDpxc03rLtLVCiOpYhqrhUP1zFORJ8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_06,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150089
X-Proofpoint-ORIG-GUID: TPYldQvdy9cXEkKDjvShqdRn2OsPBbf7
X-Proofpoint-GUID: TPYldQvdy9cXEkKDjvShqdRn2OsPBbf7
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

On 15/06/2023 10:19, Duan, Zhenzhong wrote:
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Sent: Thursday, June 15, 2023 4:54 PM
>> To: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>> Cc: alex.williamson@redhat.com; clg@redhat.com; qemu-devel@nongnu.org;
>> Peng, Chao P <chao.p.peng@intel.com>
>> Subject: Re: [PATCH] vfio/migration: Fix return value of vfio_migration_realize()
>>
>>
>>
>> On 15/06/2023 09:18, Zhenzhong Duan wrote:
>>> We should print "Migration disabled" when migration is blocked in
>>> vfio_migration_realize().
>>>
>>> Fix it by reverting return value of migrate_add_blocker(), meanwhile
>>> error out directly once migrate_add_blocker() failed.
>>>
>>
>> It wasn't immediately obvious from commit message that this is mainly about
>> just printing an error message when blockers get added and that well
>> migrate_add_blocker() returns 0 on success and caller of
>> vfio_migration_realize expects the opposite when blockers are added.
>>
>> Perhaps better wording would be:
>>
>> migrate_add_blocker() returns 0 when successfully adding the migration
>> blocker. However, the caller of vfio_migration_realize() considers that
>> migration was blocked when the latter returned an error. Fix it by negating the
>> return value obtained by migrate_add_blocker(). What matters for migration
>> is that the blocker is added in core migration, so this cleans up usability such
>> that user sees "Migrate disabled" when any of the vfio migration blockers are
>> active.
> 
> Great, I'll use your words.
> 
>>
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>> ---
>>>  hw/vfio/common.c    | 4 ++--
>>>  hw/vfio/migration.c | 6 +++---
>>>  2 files changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c index
>>> fa8fd949b1cf..8505385798f3 100644
>>> --- a/hw/vfio/common.c
>>> +++ b/hw/vfio/common.c
>>> @@ -399,7 +399,7 @@ int vfio_block_multiple_devices_migration(Error
>> **errp)
>>>          multiple_devices_migration_blocker = NULL;
>>>      }
>>>
>>> -    return ret;
>>> +    return !ret;
>>>  }
>>>
>>>  void vfio_unblock_multiple_devices_migration(void)
>>> @@ -444,7 +444,7 @@ int vfio_block_giommu_migration(Error **errp)
>>>          giommu_migration_blocker = NULL;
>>>      }
>>>
>>> -    return ret;
>>> +    return !ret;
>>>  }
>>>
>>>  void vfio_migration_finalize(void)
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c index
>>> 6b58dddb8859..0146521d129a 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -646,12 +646,12 @@ int vfio_migration_realize(VFIODevice *vbasedev,
>> Error **errp)
>>>      }
>>>
>>>      ret = vfio_block_multiple_devices_migration(errp);
>>> -    if (ret) {
>>> +    if (ret || (errp && *errp)) {
>>
>> Why do you need this extra clause?
> 
> Now that error happens, no need to add other blockers which will fail for
> same reason.
> 

But you don't need the (errp && *errp) for that as that's the whole point of
negating the result.

And if there's an error set it means migrate_add_blocker failed to add the
blocker (e.g. snapshotting IIUC), and you would be failing here unnecessarily?

Still it feels strange to use the error pointer to check for that, it's better
to return error appropriately.

>>
>>>          return ret;
>>>      }
>>>
>>>      ret = vfio_block_giommu_migration(errp);
>>> -    if (ret) {
>>> +    if (ret || (errp && *errp)) {
>>
>> Same here?
> 
> To avoid calling into trace_vfio_migration_probe() which hints vfio migration realize succeed.
> 

That was clear, my question was more related to second clause you are adding..

> Thanks
> Zhenzhong
> 
>>
>>>          return ret;
>>>      }
>>>
>>> @@ -667,7 +667,7 @@ add_blocker:
>>>          error_free(vbasedev->migration_blocker);
>>>          vbasedev->migration_blocker = NULL;
>>>      }
>>> -    return ret;
>>> +    return !ret;
>>>  }
>>>
>>>  void vfio_migration_exit(VFIODevice *vbasedev)

