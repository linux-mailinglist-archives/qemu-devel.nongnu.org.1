Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B743C70E17B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UcP-0006zo-L2; Tue, 23 May 2023 12:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q1UcK-0006yo-PX
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:12:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1q1UcI-0003uP-6M
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:12:08 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34NFTLW3032572; Tue, 23 May 2023 16:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=W1yzjeh3wx+vLoeHfmqF/P0O6oyie0r97KR/ypUrkPc=;
 b=PNhbrsMDQKQHFlB+4TOfxiJwn2csoFP2ZfcvON9BqZsEEbJPFO5PoHIi8XdTx4yFnQqe
 eRhEi5Tph6R8telP8lATajkc7M5B3W8uxTYhlaldPQYg7Km8RDqrC6fcgyD8a8gfTz+Z
 rSlQoYbnetUr9RdoqaCOoMnLgWw2b7wFUVe3V4PvaIFWfQfJLAOOWvaIY7TjWX1hrvnV
 RD747RIYf2upSWXmle4olhvg2VgomwgIWKpLeyUFyM9FqhnlCnVyGdR7RKNMGL9bcNJx
 qmAs5DwTC3pPqfQMjVdqPJu1e8ME/XyreSuKJjkPILXHozCjxvI4Vvy9uNojT0KLtZGu qw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bnjmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 16:12:02 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 34NGAJ7e029055; Tue, 23 May 2023 16:12:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3qqk2b29ap-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 May 2023 16:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoB22m6JJNyWCmPLXxH/PYIDeFturzKBODV5QhIsNMLcS8P89l6xusmNzQ28xUEKDFf7cBme+muJG+gKCRr6CFw5xNuhzwCQzSEu4dClccjpYe5YgMStlRE72RpAIFBIsHH4HbAGNOcTL67FduPWxcNac91ojRnS72eE1en27333Ffo+kl8gaD3yErRNSbZ/Lo4TV8CkYa1yUs4Xv3l+vwJM29Y1MLhs3LN4vtT4Jim11vv26d3PSb6RY5wX7+/2icCNvaCqJiRtc290YgL1RZ3/ZCbpXaRe60D5HbjAf/G+UnEvvHKWegf84fHO9H9DGDNg7J7vbAZHNWqPf0IcqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1yzjeh3wx+vLoeHfmqF/P0O6oyie0r97KR/ypUrkPc=;
 b=C/4SXtfbyDQM62ypbnUGeMqEa5ax3YgH1mCAKoRH4RPj0bVIlOhM6U5j4W1zS200rnfZI5FRJYGKlqZQP+YYuCHEsDQ06CB6u4c+mFXKHdhkkLfjj4i6andebzq8+sVBs1tvTu1BzbKvxZBNBPmlrnqtVqSS8nFWL8GpEvRzDpEd5N0pCHCjxk0aN/9yW6B2UZar1HSei/ypvuZvUd1U3TdJj6EIzylo/aYs8CNURCN1j6m13K2KqwpTPikmZfVeGEhJa/SWOKKijTGf8ujNPFUFw45GXUGvxPiMxR+kfL1HIPh8lUlxeTjmkmiqS1L0AsJfHdg050vFZqjn11a/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1yzjeh3wx+vLoeHfmqF/P0O6oyie0r97KR/ypUrkPc=;
 b=LDgvNaipxdUOQKPikktYJXgH+V66UgrbRiv8LGUtAZRmlL3x+wsJ1fP1fsefdDgac990AWoigK6XzHPunmTBHXK4KbPaJ48bc5PXBAO4joMZ2F9LlK0aJ0zL0ULqAbe6lXSBUcNcE+ifuxcjuN4N73RbVG0jtgC6SXIzIxz7S/s=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by BY5PR10MB4388.namprd10.prod.outlook.com (2603:10b6:a03:212::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Tue, 23 May
 2023 16:11:55 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::b176:d5b0:55e9:1c2b%3]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 16:11:55 +0000
Message-ID: <6503e1b0-a4e3-a95d-7e28-01976f85f1b6@oracle.com>
Date: Tue, 23 May 2023 17:11:49 +0100
Subject: Re: [PATCH v1 1/2] exec/ram_addr: add dirty arg to
 cpu_physical_memory_set_dirty_lebitmap()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>, Avihai Horon
 <avihaih@nvidia.com>, qemu-devel@nongnu.org
References: <20230523151217.46427-1-joao.m.martins@oracle.com>
 <20230523151217.46427-2-joao.m.martins@oracle.com>
 <d5cce13f-3e90-6699-90da-b2befdc7e1d5@redhat.com>
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <d5cce13f-3e90-6699-90da-b2befdc7e1d5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0157.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::18) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|BY5PR10MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: 87111ddb-9405-41f8-a80e-08db5ba86d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCPnmwJemGO80hP1oscCHlKW7mXPjog1n5GLeWnmRF070PpuDDWiH3cWTQpJn8tbaBafoPDYa7D2Hz+xYnOXz8bGBv3kQlBMvH8pZyGcvbJRlx7GRiFi1ZcAtMPQ75vGtcaynvZD9mZ2jZguL0yn7vrNVZ3ZQGh6qJg7J69ttH7C7u277CWeFko1AZzatbYvc9vNqbzLlEfUhTwlR6TbdLG6pj6Po2JKRURFJ2q3F7FCrvAsfTMXja+2HtC30sp1BR22iCpo0C3pX3vwyhzOggHyzkjo0PRetREEX5Ox9772bOvkPDuubDIzZPy43YaiqEl8nwxAO6fimd3B92nwA0+s7kFJErj/REB/qveCRkK29Oe7lNT8lGtYfNrf2xNA/ifV6KXdRs0qoDa9RZkPGVbnkd1fAuYexNcbCRWh/NcbaWAOkFPGcw1K4/foIcAkreoADPnmpDpBaAnIaF040vywterL09/gtv/LVNfUbZzZeF3yMXFTPkK63y8k0phWM7L3vBqGXApQoZ0UHHfsol3+ebfx8bDnoTbZNo9+OnleBgZkzNAauTp3Opk25snYiPHv1kxsCknhMdeAnNWiULC8+uXMYzjtWjrPnsjpeOcl0ZMarjGl+m+JkON/K5Y0vhOOOhWWjKuo1BYHHSVJPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(31686004)(36756003)(38100700002)(86362001)(31696002)(8676002)(8936002)(5660300002)(26005)(6506007)(6512007)(2906002)(2616005)(186003)(83380400001)(6486002)(6666004)(66946007)(41300700001)(66556008)(316002)(54906003)(478600001)(4326008)(53546011)(6916009)(66476007)(14143004)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3lEOTZKeHpCbmNqL0dJTkhwTVdiakk5YXBLY2ZCaXhGWlNkcWtoc1ZzVmpq?=
 =?utf-8?B?RURKbnR3dHJBYjcrZUl5cjlnNm1Odm4rdGYreXZRYTlVQ24wUUwyL3B2aWlT?=
 =?utf-8?B?S2g1YzNkZzVHVlUwcDhQT2pxdDU1UmUvN2RrV0d2NncvTHhic2xWVlhoZ0xa?=
 =?utf-8?B?SDA5V3ZmSnRjQ2JIaDFjSHE5OTRBUHVGa3Z6Nit4SGs4MzdIcEdIQ29pWk1I?=
 =?utf-8?B?cDF5ck1JNGpYUFdPOTVDRkhvdGFPeFFNdkxkdUV5VHJzQjg0TXJpS1RYR3J4?=
 =?utf-8?B?cWxlODk0YnUyUlZsSzR1NytuMnJTZHFHNFdRVXoxQXBNc2pwZUJIL0ZZSG1L?=
 =?utf-8?B?T3FmNDkvclVUbytEdzdtTjQySmNmeW5YT21nY1g0amJrYTkxUCszK01BRGZI?=
 =?utf-8?B?L0loTHVNb21PZHhnZ05EUDJIQXlLcTR2bEM0STRjVXQvMmpZcndmNjI0UkUr?=
 =?utf-8?B?ODc0QUFEWHBxdWlrMVVrOVJVMmJMVHlqU0x5d2cxWW5Xd2RJRm9pbWF4aVha?=
 =?utf-8?B?c25zeXhGMjRUcGRDVHErYUx4SUpwUERoNFVpRG55SjI0aTVvTmZZZzgwVSt1?=
 =?utf-8?B?ekJXcDdkblFXQWxlanRCUENCRHRsNnhQY0toUXlEdllmT0ZTTE1Ydlp2UkVT?=
 =?utf-8?B?L001VFlsQ2RXMWtFM243UnovNk5NZnVRMit4NU9XUVVtQy9iaWNuN3U4ekt0?=
 =?utf-8?B?RXlza0FLeDhEK3BxSW9nR3BFSnBjNXErVUZTVlo4Vk5pQzJrNXBsajNZK2ZB?=
 =?utf-8?B?UXJmZGI4U1hEaytPNkxtRGFpREh5akthQ0dsT3ZORlQzZ1VsNXhxdE5XbXNZ?=
 =?utf-8?B?L3IwalhiK0lRR3NRM2s4cnpDNWRxaVpuMGVYTmRBYlFzcnh0V2J4eGFZUGxl?=
 =?utf-8?B?WU5uaUFSOHBnNUNEV1VEc3NheGx2b0JSL2k0cVN1TUlOMTBZSGRIQ0k4Q3lq?=
 =?utf-8?B?OUVtd2Z6ZVFWem1VbGRJSkhMeWxjV1g3K0t5TmdTR3RvdnBtNWREdTBJYmV2?=
 =?utf-8?B?bURhajlKZUZWTStKMXNVVmtwekZKa2FhR0J4RWpQWlNSYXlESVcxWTRBSGJB?=
 =?utf-8?B?UGZCU0swTnpvTzdkK1pDRTJ6KzFyVzhEb3FQV2o3WmtST0loc2VUMnBCbHhr?=
 =?utf-8?B?cWQxNUxSQlJXeERHN3JzdzUrd2lIRitYeWVjQlZSQ2JOeGJYUlN4NUlYNTE5?=
 =?utf-8?B?OFZWRlVWUWNGb1NzR01zc1J6S0NESE9RQXNaK1hWMForZkF1WTFTOThUMmNZ?=
 =?utf-8?B?Y0JMMGI3M01XTFgrd2JWWEtQTFM5QU10ZlUxdUNPVXVsM1loeWZqTUFWWFNw?=
 =?utf-8?B?eGJOc2l3MW55Nk10d2tVcFFPV0FUZmg2RlBhOFlPaC9aNjA2ei9kdzdUaVI3?=
 =?utf-8?B?dmtzdkxITG0yd1pFM1k2MGRMc0JqaE5TUXpFRHR6aFFzZUplb0pSSDFxOS9a?=
 =?utf-8?B?cnRLNTBLWnkxRlFoQWg2b1p1ZDVUMVlsNDBsQmxRSTRsUkRtNW9CeXBGTEsy?=
 =?utf-8?B?RkxadzVaTUVqbVR3blY4SXQxOWFuTjRlWncrc1JwUGtYV055UFI4R2lYaUdy?=
 =?utf-8?B?Qm5FbjZtdHBqeElrMW5FMEpLaTlxTk1XbmFwTjQwbU5WMENOU3FRRXVScmV5?=
 =?utf-8?B?VUxxV0R4UTkzYnVyU29xZkZXVmg4ZVpZNzdkY2dtTk5wRTV2bkRrN2dNRlJ2?=
 =?utf-8?B?cytPZ3h5dU1yeENhVHVxbXZyMTN2MDJ1VXlxaERXdHVmZEJuK1lVR3Rua1A3?=
 =?utf-8?B?YVhUd3RUREJneUJrZEJTRVF6Nzd0WnZBYTM1Y0ZReVF1bEExMHBPaUFXTzMz?=
 =?utf-8?B?L3JaWUM1cUoxWVhDQmhSblozckc0aTVRZG4rc0Jnc3VjK2xsV0JUR3pEWGFV?=
 =?utf-8?B?THRHZG0xdDR2cGVUNGluSlVCYUwzVFlIdmQrblc2eHBESy9uV0NaMjdMbkh0?=
 =?utf-8?B?UFJEVDIvM3lvOHpZUGVwaThscUxlUFFucEMzZmI2cGxySUZIaEtQdXo3MkNH?=
 =?utf-8?B?SDRKdDdrcVZqUXN6c3JVQkt5ZUltY2owSWUrODA1cHczVjlWSTVxNENTeHJZ?=
 =?utf-8?B?U2JmdXdPendkaHlVb3lXcG5yNlY4OVEyZzg3UXljdk84UENHYlFGL2JhUFl3?=
 =?utf-8?B?V0ZnQ0N6ZkFMMnlvRE5RRW1Lc1VHV2V2eHJGbE1KUDZxTFdLdkl6dWRhcXE1?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XgdIet9C9UX16rC/bpx07JJpnLYWKDlJ/m7/TMpgyRe8C5ZUQTov6Jp3kIntg7WdiLnKQx8LulAgvEMeUODfrYEzvzf4hZu74l1tJTCuIConrU69/cNxzt3cRb4u+wUskG1YQUdMyh5LQLrJx5cMDvFLfHyqrJ/3SdFtugI8266peJWz0sTwrgmi2Pj1TpK0Dw82Aps3p3zNVWGMQxgbwwIKj/mI4lEfzkblMpFBuZW4jCyWBO49Mz4nTECCn8++f1BHMNu39QBTSimY7Nec5xvjGBpBcdfiFh6mZ7gZ/QNAoQ+1yRFb4jiURmlrQYB7gvyBK8lf0n5BMU+EkkWVXmmICrmoVoxF5Rl0nJ2U46WgsWELWUDxIhiw/U2bOvndT4ZQtFpBwrCf5mj8FGB8HpCJ1IG9ufWvIpjlmIDQboU6oov2/IW73ECRs+ea3jspQ1D5/esaouYjldjgjlPAeqBAdGyLObFO1N6dpRbnhm81W+EDRFCdmymSkWkUv5cJ4SLDJf1iQx2KqQNAOHpJCHahjIzPdJ1wbzNJEwbK2FErKyQjtlpML1tM3wIg5EJ6Hzes7ZMHBI1LrIRxjgY1r5mvfo5u31449NxAMMaPjINGUsu1MP65li+mr1QKf2Lfy3rTKlmA+D54xOX8QWepttHX/jLMnGFmYcCK6SedvqFUyZ7SyBNVdM+YTUHHYdflVAndcV3kNs+8/AQ/IwJT77Kv0HsKt166VUyxuZyC5egabtT3iI5fSvUYKA27fN483eqgzrSu16OHAiX04fT7PlOtWxgqifMjjcWVHBn57s+EvmEvKRoPNQs9eSJP0/o/4npZ9CdPdHn0M4520MlQtQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87111ddb-9405-41f8-a80e-08db5ba86d63
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:11:55.2810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4Lji8QckDu/Tv6dh5ap9rSsOyCdd+zCV9BeRwKqA4oybMpQY7hsQOli4RfGLWY+imF0k+rKiTPvPI/363PTBEBwsh+s9fH7q2m16sN9uuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4388
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230128
X-Proofpoint-GUID: MqindLlWzMmHx4wvpzgU2-qnsMq3QD9X
X-Proofpoint-ORIG-GUID: MqindLlWzMmHx4wvpzgU2-qnsMq3QD9X
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On 23/05/2023 17:07, Cédric Le Goater wrote:
> On 5/23/23 17:12, Joao Martins wrote:
>> In preparation to including the number of dirty pages in the
>> vfio_get_dirty_bitmap() tracepoint, return the number of dirty pages in the
>> range passed by @dirty argument in cpu_physical_memory_set_dirty_lebitmap().
>>
>> For now just set the callers to NULL, no functional change intended.
> 
> Why not return the number of dirty pages to be consistent with
> cpu_physical_memory_sync_dirty_bitmap () ?
> 

Great idea, let me switch to that. Didn't realize sync variant was using the
return value as dirty pages. That also avoids some churn in the current callers.

> bitmap_count_one() would also give the same result but at the cost
> of extra loops.
> 
> Thanks,
> 
> C.
> 
>>
>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>> ---
>>   accel/kvm/kvm-all.c     |  2 +-
>>   hw/vfio/common.c        |  4 ++--
>>   include/exec/ram_addr.h | 10 +++++++++-
>>   3 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index cf3a88d90e92..1524a34f1786 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -559,7 +559,7 @@ static void kvm_slot_sync_dirty_pages(KVMSlot *slot)
>>       ram_addr_t start = slot->ram_start_offset;
>>       ram_addr_t pages = slot->memory_size / qemu_real_host_page_size();
>>   -    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages);
>> +    cpu_physical_memory_set_dirty_lebitmap(slot->dirty_bmap, start, pages,
>> NULL);
>>   }
>>     static void kvm_slot_reset_dirty_pages(KVMSlot *slot)
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index 78358ede2764..dcbf7c574d85 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -587,7 +587,7 @@ static int vfio_dma_unmap_bitmap(VFIOContainer *container,
>>       ret = ioctl(container->fd, VFIO_IOMMU_UNMAP_DMA, unmap);
>>       if (!ret) {
>>           cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
>> -                iotlb->translated_addr, vbmap.pages);
>> +                iotlb->translated_addr, vbmap.pages, NULL);
>>       } else {
>>           error_report("VFIO_UNMAP_DMA with DIRTY_BITMAP : %m");
>>       }
>> @@ -1773,7 +1773,7 @@ static int vfio_get_dirty_bitmap(VFIOContainer
>> *container, uint64_t iova,
>>       }
>>         cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
>> -                                           vbmap.pages);
>> +                                           vbmap.pages, NULL);
>>         trace_vfio_get_dirty_bitmap(container->fd, iova, size, vbmap.size,
>>                                   ram_addr);
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index f4fb6a211175..07bf9e1502b6 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -335,7 +335,8 @@ static inline void
>> cpu_physical_memory_set_dirty_range(ram_addr_t start,
>>   #if !defined(_WIN32)
>>   static inline void cpu_physical_memory_set_dirty_lebitmap(unsigned long
>> *bitmap,
>>                                                             ram_addr_t start,
>> -                                                          ram_addr_t pages)
>> +                                                          ram_addr_t pages,
>> +                                                          unsigned long *dirty)
>>   {
>>       unsigned long i, j;
>>       unsigned long page_number, c;
>> @@ -380,6 +381,10 @@ static inline void
>> cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>                           }
>>                       }
>>   +                    if (dirty) {
>> +                        *dirty += ctpopl(temp);
>> +                    }
>> +
>>                       if (tcg_enabled()) {
>>                           qatomic_or(&blocks[DIRTY_MEMORY_CODE][idx][offset],
>>                                      temp);
>> @@ -411,6 +416,9 @@ static inline void
>> cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
>>                   if (unlikely(global_dirty_tracking &
>> GLOBAL_DIRTY_DIRTY_RATE)) {
>>                       total_dirty_pages += ctpopl(c);
>>                   }
>> +                if (dirty) {
>> +                    *dirty += ctpopl(c);
>> +                }
>>                   do {
>>                       j = ctzl(c);
>>                       c &= ~(1ul << j);
> 

