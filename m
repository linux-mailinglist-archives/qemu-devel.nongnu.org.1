Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE298041AA
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 23:25:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAHMI-0001Tl-Lm; Mon, 04 Dec 2023 17:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAHMG-0001TX-Bo
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 17:24:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1rAHME-0004mw-6u
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 17:24:08 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3B4LqZ3b023880; Mon, 4 Dec 2023 22:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=vcPhrXwNFQoxD6yKnfhVtfPv/awswqcC1KHrBCYA0JY=;
 b=b5t4m0N3oycCUH8I8WvM4NtJQU0DvsipY4kXG5efSbxEMt1+SowG07dWOPFzbvItsU4G
 Z5cTANMnonjYKMpQ7LFq+d1qtMyQEQXDezTcxO4E3O0OC8gTfQD4KaO5p+iHj+zW4Gxz
 sqNoz5Z0lEPOJHCeuF1TZDZ0ZRN0h8Qfe887mizGbJop9vekF7ZbBDrkqBkKzQAdyj+x
 FeJC1Qf6hj6cCcUC84VpNPdLlaYWf51ioFyjJVesGvJi1SqoWDaL0W9bnHftM6Gc23lS
 WGK8gvP4sjvBUfa2CiwGTG6cn6X6WkXzl0GQlfB3yN9Ci/Nif/nYn4AEK7f9Coc2gghU cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3usq2gr28g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 22:24:03 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3B4MImlx025970; Mon, 4 Dec 2023 22:24:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3uqu16j890-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Dec 2023 22:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2s8Z8bkTzpITB0Z5lZbH+HR925TFIRkx49wPhb6joKwyQ0eOl0Zt1MLbp0wqTltSkGkkg7KrCrqCgklZT8h4jNtwChlscFZv0fe6RZkPCcYILxRbW7z+rOgiyoYmbLKPWF0shDPA3MiPzsKMkzzNuNSu5AJWSDucKEbfeSdb/MskQDAZFK1iHNMvOi9s2pD0PsPqaehWvsewlYchOUpyMWWH2YOPfEiZjboz/8qx0tQ0Gxah6iTYenngtkGSRGiJSrwvW9Log3tbPqgLC0j9D8ewvgzJxAsUITJF+VEr7Nx066rU1Zg28Ot1cFmgVhvwdFv8XXRYeceab7+Da3IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcPhrXwNFQoxD6yKnfhVtfPv/awswqcC1KHrBCYA0JY=;
 b=k3533Haw6bTuqDFxA/lFlGGxAExfNZo2JNk3gVxVEXq3gVohMttNJepUs/WweFmb4Q7bow4yw1lWlH0xjOYx+Omy2ZE6f1WqDEN8zWL/jYEuMJOK2z6eK/m2cEjbNC6JAvEBKPx0z2d4TvI5ldmw+3gXlDdjLRAQRGW8USdZL2etN8CE3sIF6kKF7LhZVT5ICicLAR85ZbTKGb642cqlgGzpHTBnDO6ydF//JF7MYuPmaDdKWjo1lbQXkLmrr3CTCvLuwfTe4D8ePO6VW91DWQrGHZzidaDzvCpdDVN3kczf9VZ0QPeMaGClVWMZdTvF987L/iSNXC0YtWfB1LJYIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcPhrXwNFQoxD6yKnfhVtfPv/awswqcC1KHrBCYA0JY=;
 b=j41v7bXLuvH03ikvUx4X1pP8I+Zq5jeIU3/Ve/rbipGQa2raT4fEsLfeth+89sS8sjEHiJa9X1SVS2XWVpabyqDfB2gb//c476popR5qw7HjX3528alXwAXieuU67yaVmay9fdrvJCkBFrOYsvnDPmtDNV8313vEyNJcIP9yeck=
Received: from SA2PR10MB4684.namprd10.prod.outlook.com (2603:10b6:806:119::14)
 by IA0PR10MB6770.namprd10.prod.outlook.com (2603:10b6:208:43d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 22:24:00 +0000
Received: from SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96]) by SA2PR10MB4684.namprd10.prod.outlook.com
 ([fe80::d609:b162:ba7c:4e96%4]) with mapi id 15.20.7046.028; Mon, 4 Dec 2023
 22:24:00 +0000
Message-ID: <38a8b047-4c60-4e6f-9ccd-a307d0358f53@oracle.com>
Date: Mon, 4 Dec 2023 17:23:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 05/14] migration: propagate suspended runstate
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-6-git-send-email-steven.sistare@oracle.com>
 <ZWkVbiQNl16hC1LW@x1n> <ea771378-33c4-4d4e-9de2-d39310028d10@oracle.com>
 <ZW4LX9FpfTj77TZv@x1n>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZW4LX9FpfTj77TZv@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0351.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::26) To SA2PR10MB4684.namprd10.prod.outlook.com
 (2603:10b6:806:119::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PR10MB4684:EE_|IA0PR10MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f003a7a-e2d2-43b8-b73d-08dbf517b698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dv0KajQwTHnWihKJ7BzlxrxtJ0gP0SgPWPj2oEoXsAqWVi9jPsYUU1/jfIgmspz57XAPHuBTWYYEfIVfk8itVaAnrF9F+H4ddPeXrHP1kemBZaE0FuJL5OUTi9SieBQgC0FS4995+CmGuRUBsw5fixxhnx7uALqt3Gv9K4VsJs4Ct6PE5B2Z8Ft4aIKNb9lRwIsIYgFzXe2S6AM7p+oL4EeuKgYf1+N1iWrT4qX/WmIJPoRdT5SZ2VaVPAv67RNbD+jX+RInFowIXVfjBWIRUdXGL0ChV/x5XPhOp25k2sJGBQfpMikZ8PNSpET/md52S520Gcb8EtCK4l/YxW0V+LRjRDfY3fom1pL0U2l3m3ZqmKwYOWuvw1sGoYg5sTqohDuqvQA6MeueQ/n0NLMNQbITqbNDHe9FbPyBtdWrHJWRnfyes3lXxhAsAItE96fUU3dNwPGMpq72/s9PtTa0MbzlWxTptPkoJ8JZnI8lfqKHKobaOoudPMbERu2FeLUrEDrj1q/3c1YI5ZvFdVwVV4VkGH2mMfcyz8ugT6ZRSh6w30ICNG6CVNpBaGUIAlohbQbM0FhyxwaY1ix4PmvnWKiTl/oHFr0PjLfQscvnZnr4zDKQV86K9NRbyL8sQTU6jNIvdQ/8Hy32C1tuupT9bQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA2PR10MB4684.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(66899024)(6916009)(54906003)(66476007)(8936002)(86362001)(316002)(8676002)(44832011)(4326008)(31696002)(66556008)(66946007)(478600001)(6486002)(36756003)(41300700001)(15650500001)(2906002)(5660300002)(26005)(2616005)(6506007)(6512007)(53546011)(36916002)(83380400001)(6666004)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OENKSW5yaTVsWGRpeXVBYlNxVWRxU0FRMlB5YmlwZURoand0dW1Lcm1OTVU5?=
 =?utf-8?B?aG5IN3FaOWJJTlhrLzJQWTFDK2pQcnJXaCtpZktzbUg0Snc1eE1JOXR6ZzIy?=
 =?utf-8?B?WHlQS1FTOVVwSUNtK3ZodnQ4V1V0dmc5b2h3eTdJNXRxMUpGekxadVpDRk1H?=
 =?utf-8?B?Zlp3bEtLV1ZQZEpySXdWc0VmQmE2RHB4ekpidit1T3lFNHY5dXRMS3FSaW8x?=
 =?utf-8?B?UmtreXJNWHVpemNxMXA0b0xkL201MVptUDNCWEVFMDlBblltMGlxa2UyVW5l?=
 =?utf-8?B?RUNPTEdjbG9UVGdBUlNKdjd4NW82UnEvTUx6ZXlDU2svTWdYZlZwdXBkN2tL?=
 =?utf-8?B?TmVjcURzWklrNS9QTUNBTjhoYXVIajNkZkJwUi9FNm5LUldGN1ozeEMwM2l0?=
 =?utf-8?B?a3hCOHgxVVIrdVhGZGhaYmxsSjdYcTBkT0FHcGI4aHZsdXFjVGRTYlMrQjFH?=
 =?utf-8?B?dUVERG51V0ZZQi9MMHRuUGdWWTVrWVhuSzFqNUdRQTJGQ0RMLytlS1BVVDV5?=
 =?utf-8?B?Q1RzNGxrRHdnZVk5VjdGaHIxdDdKZlVzVVorT1dpRXBZSk1oK0JUbkYwemha?=
 =?utf-8?B?ME1QTlJoNVlYWGdBZE9SWm5JVXFoN3VTZ3VGS0NaTkZrVlpVWWVBMlpqWEds?=
 =?utf-8?B?d2s4UlNXZThndGpydXZaMnkrL2dFRWdoN1RtRy9qVFQ4WVY1TVZCeDdRQlVL?=
 =?utf-8?B?TVdMcksxRzJvTEFsdTJVZkQyVWwvNHFZUjViS2JvQzBoTTF3cTBEQmJUak5a?=
 =?utf-8?B?ZU9zOHdmZkJzUkovZ0gyRytaNnVJcW1JbjlndDdMa3lNL293WGZJTjVJZUg4?=
 =?utf-8?B?OHdNa05XdDExdjNpYU5JbWkva2Fqbmt0UGZRQU1EcWtFS2xvMFVoYm00VTBq?=
 =?utf-8?B?U01HMENMWkV1VzdhM3dESmJIczVWb1RkQS9SVjVHNm5oK1E4UzE0WkRmYVJo?=
 =?utf-8?B?RERYaXZQdERQcnljWWZEU2VaVFZnci9rcEladUVTLysxckFnejJOS3NycGVn?=
 =?utf-8?B?NmFJSkEwQTZKbkRNTmtlOUpPUHd5NkU0UlNTbTYwNTRvdmZNRDJ0ZXlVQi9V?=
 =?utf-8?B?RUdYaXBMeDk0REF1Z1E4TGQ2VmYxclNXM3FReFFnNjBPU0RmSFYwM1pyWWVW?=
 =?utf-8?B?VkR1bXJtRmM2UGxXUWk4ZmlqWnYzUFhrK3RLbFdYbWM5VDBrZk92L1Z3emg3?=
 =?utf-8?B?czB1OFhqSDIzdUE3cXdTNDUvSFZYNVJ0MlBTaERaTEdsc0pTd3RWQ215NDhH?=
 =?utf-8?B?Uzh4ZzF2ODllODBvTGdCbVFNcHE1K1FpYkV1RTVlVXpHejB3YStkY1l4aDMr?=
 =?utf-8?B?UldGWVdhVDE4Q2RHWlppcm9DNHFGVXF6ZWJrVExrdm9CNXdSczJsRlJob2pF?=
 =?utf-8?B?WDk3Y1dDdVFKaE5hcllFM2YwWG9HR3NKYTlUb1JZTk5RUnQ5VHY1RlM2aDJB?=
 =?utf-8?B?cnhuRjRrLzk5MVBOWlJaOWQ1S0c4dUJ4MUgvV2VKeFp2QUl6eGx4a1creGMz?=
 =?utf-8?B?OVlBYWw1Wjhsc05xU0Z4dG9QUkxIY2FMVERkbXUycmgvUFJIdjdqL1lnMjJw?=
 =?utf-8?B?dWszNnVDMWE3d2Z2eGZWZm5MalZqaHhxZHdoSzV4cnlIRUNoVHZmcHh4dVYx?=
 =?utf-8?B?dDFIVENWUFQyVnBtVGVqTFIxSVZ4RmRiUWduNXR1eUg3emU3T2lsdFV1MFJN?=
 =?utf-8?B?TVRpZ2JzTTdTSnFvTndyeVFnRmFBdjhlTnJFMHhxVVBVblY5bXBLVWFXVzlu?=
 =?utf-8?B?WHQxeVFTQjVhbzdkRU1ZMVdWWEtKWlRXemtHQUVkOXk3OVJnczJoVGIrTzQ2?=
 =?utf-8?B?cWovbUxLRExRK1dFNFd4Y1BwMWZlQVJzRmp4alJqclFBcFdJaVk3dm9BSisx?=
 =?utf-8?B?d09wOFFvT1o4U2M1WkNkVDg0V1Y2TDBCYnhWNU45R2VMWUZMcGk2WW5xbFJZ?=
 =?utf-8?B?MU9uSERCUnZTMStjVm9NRjZsdzltUk5WUU1RNytsYlA1Tnp5WE5YN1o1Z0sv?=
 =?utf-8?B?ZG5GdXJWQXJMSC9FSEVJTXpOMGRYMEZHTlMzbXFQUU5PMkVNTjNCSnVXc0J6?=
 =?utf-8?B?S1EyU1I5QWJUZStWWkt6ZllNNnBnZGNYSDNnWU8zWHVrVEVvSzcwd3FKL04r?=
 =?utf-8?B?YUUvOEErVWRBZ3VvL3ZydkRrMlJ0N2ViWW8rMmxlMENlNjhJYlJpWk5wdy9D?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yw+3EW11Y+78RvMdlaQya05IHChPMACiXtB6fP1VRyxQifwv93RZkAEmavtNYBSFKMhHvcAc5Zj0Pg7z+KZurx8odh8brNFNwRh1dkKciHd2TGMUZBQWx+zRoXtPdqRC+u9lXtAm3SfEus5v+4LKfyRv2fzv3cTpgbMfeObWAgbKE4qiaf85jigadjnT5FosqI4q3ZaWPiY2A1L1O+rmYJVs9LAXxnHxG+9LfcgZcQRd2Tpf5PTSTTUIAVVrzpQgONd2k/6lJWR8jJ95nfWDxfPwr2m/nQ/EzeCXTgIK7B5sL8ve4AjsPxBXQ8rbMPpIA6M/mk97nhjk/MZLWGiKlUqJfskiW5Lp/1zC7836TY3OchfTMBO5XipJxjQq06/jfFYUJTliyWLHGJ4jPIHGYWAcEm/3ZxIjIsVFqg9YobcWNz6fw/a44PdC+A8L8QTWy2HHbIXKcZAY24H4vFwhB7CpsqslHgHoeaqcfhGFQ6K/Lt6bBTzI8U50HxKCgBIrARG9hwCoJwuSmB0RwHGgTMByDHa4PEqG8zc34Mxel36baScT8X4jbBmTYfNLQ+oj68ykSpMJdXKBlNZp5OlbpjzT/31o3dSPnW+bOwuLWenVrrSbsg0xa7hqgVmHDsb5qW6ZlAEbCuijj9B17hti+mIDrv2s4CqIEPJx7Qvrjbiq+nV+1o/4lNx+G7y+GgHtZP12NMu7Ew94h+9jhQo4NRKXZkrpl/5aTIzXWWYOWBapPdhGUKHb8g1lkQNAIhchmNOEAfRoXv/cASa+rSNr4O7Z+8hYl6tgwXyKSBbxjDg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f003a7a-e2d2-43b8-b73d-08dbf517b698
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4684.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:24:00.1032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LH4mGR/Eaftd1IeZ7Xg3KGNupzyl8OK/MO6tznf1wHmRXmpF9NVwSpLeSZtinHsg1ZmPS06E3DeW5gQS9OJ4Ioihq/ln8CCWr/nUJgUYfFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_21,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040176
X-Proofpoint-ORIG-GUID: cE4Vj7r_RKBXduqEWqgFEMN0wl61pzKy
X-Proofpoint-GUID: cE4Vj7r_RKBXduqEWqgFEMN0wl61pzKy
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

On 12/4/2023 12:24 PM, Peter Xu wrote:
> On Fri, Dec 01, 2023 at 11:23:33AM -0500, Steven Sistare wrote:
>>>> @@ -109,6 +117,7 @@ static int global_state_post_load(void *opaque, int version_id)
>>>>          return -EINVAL;
>>>>      }
>>>>      s->state = r;
>>>> +    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
>>>
>>> IIUC current vm_was_suspended (based on my read of your patch) was not the
>>> same as a boolean representing "whether VM is suspended", but only a
>>> temporary field to remember that for a VM stop request.  To be explicit, I
>>> didn't see this flag set in qemu_system_suspend() in your previous patch.
>>>
>>> If so, we can already do:
>>>
>>>   vm_set_suspended(s->vm_was_suspended);
>>>
>>> Irrelevant of RUN_STATE_SUSPENDED?
>>
>> We need both terms of the expression.
>>
>> If the vm *is* suspended (RUN_STATE_SUSPENDED), then vm_was_suspended = false.
>> We call global_state_store prior to vm_stop_force_state, so the incoming
>> side sees s->state = RUN_STATE_SUSPENDED and s->vm_was_suspended = false.
> 
> Right.
> 
>> However, the runstate is RUN_STATE_INMIGRATE.  When incoming finishes by
>> calling vm_start, we need to restore the suspended state.  Thus in 
>> global_state_post_load, we must set vm_was_suspended = true.
> 
> With above, shouldn't global_state_get_runstate() (on dest) fetch SUSPENDED
> already?  Then I think it should call vm_start(SUSPENDED) if to start.

The V6 code does not pass a state to vm_start, and knowledge of vm_was_suspended
is confined to the global_state and cpus functions.  IMO this is a more modular
and robust solution, as multiple sites may call vm_start(), and the right thing
happens.  Look at patch 6.  The changes are minimal because vm_start "just works".

> Maybe you're talking about the special case where autostart==false?  We
> used to have this (existing process_incoming_migration_bh()):
> 
>     if (!global_state_received() ||
>         global_state_get_runstate() == RUN_STATE_RUNNING) {
>         if (autostart) {
>             vm_start();
>         } else {
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     }
> 
> If so maybe I get you, because in the "else" path we do seem to lose the
> SUSPENDED state again, but in that case IMHO we should logically set
> vm_was_suspended only when we "lose" it - we didn't lose it during
> migration, but only until we decided to switch to PAUSED (due to
> autostart==false). IOW, change above to something like:
> 
>     state = global_state_get_runstate();
>     if (!global_state_received() || runstate_is_alive(state)) {
>         if (autostart) {
>             vm_start(state);
>         } else {
>             if (runstate_is_suspended(state)) {
>                 /* Remember suspended state before setting system to STOPed */
>                 vm_was_suspended = true;
>             }
>             runstate_set(RUN_STATE_PAUSED);
>         }
>     }

This is similar to V5 which tested suspended and fiddled with runstate at
multiple call sites in migration and snapshot.  I believe V6 is cleaner.

> It may or may not have a functional difference even if current patch,
> though.  However maybe clearer to follow vm_was_suspended's strict
> definition.
> 
>>
>> If the vm *was* suspended, but is currently stopped (eg RUN_STATE_PAUSED),
>> then vm_was_suspended = true.  Migration from that state sets
>> vm_was_suspended = s->vm_was_suspended = true in global_state_post_load and 
>> ends with runstate_set(RUN_STATE_PAUSED).
>>
>> I will add a comment here in the code.
>>  
>>>>      return 0;
>>>>  }
>>>> @@ -134,6 +143,7 @@ static const VMStateDescription vmstate_globalstate = {
>>>>      .fields = (VMStateField[]) {
>>>>          VMSTATE_UINT32(size, GlobalState),
>>>>          VMSTATE_BUFFER(runstate, GlobalState),
>>>> +        VMSTATE_BOOL(vm_was_suspended, GlobalState),
>>>>          VMSTATE_END_OF_LIST()
>>>>      },
>>>>  };
>>>
>>> I think this will break migration between old/new, unfortunately.  And
>>> since the global state exist mostly for every VM, all VM setup should be
>>> affected, and over all archs.
>>
>> Thanks, I keep forgetting that my binary tricks are no good here.  However,
>> I have one other trick up my sleeve, which is to store vm_was_running in
>> global_state.runstate[strlen(runstate) + 2].  It is forwards and backwards
>> compatible, since that byte is always 0 in older qemu.  It can be implemented
>> with a few lines of code change confined to global_state.c, versus many lines 
>> spread across files to do it the conventional way using a compat property and
>> a subsection.  Sound OK?  
> 
> Tricky!  But sounds okay to me.  I think you're inventing some of your own
> way of being compatible, not relying on machine type as a benefit.  If go
> this route please document clearly on the layout and also what it looked
> like in old binaries.
> 
> I think maybe it'll be good to keep using strings, so in the new binaries
> we allow >1 strings, then we define properly on those strings (index 0:
> runstate, existed since start; index 2: suspended, perhaps using "1"/"0" to
> express, while 0x00 means old binary, etc.).
> 
> I hope this trick will need less code than the subsection solution,
> otherwise I'd still consider going with that, which is the "common
> solution".
> 
> Let's also see whether Juan/Fabiano/others has any opinions.

The disadvantage of using strings '0' and '1' is the additional check for
the backwards compatible value 0x00.  No big deal, and I'll do that if you prefer, 
but it seems unnecessary. I had already written this for binary 0/1. Not yet tested, 
and still needs comments:

-----------
diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8..8a59554 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -32,9 +32,10 @@ static GlobalState global_state;
 static void global_state_do_store(RunState state)
 {
     const char *state_str = RunState_str(state);
-    assert(strlen(state_str) < sizeof(global_state.runstate));
+    assert(strlen(state_str) < sizeof(global_state.runstate) - 2);
     strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
               state_str, '\0');
+    global_state.runstate[strlen(state_str) + 1] = vm_get_suspended();
 }

 void global_state_store(void)
@@ -68,6 +69,12 @@ static bool global_state_needed(void *opaque)
         return true;
     }

+    /* If the suspended state must be remembered, it is needed */
+
+    if (vm_get_suspended()) {
+        return true;
+    }
+
     /* If state is running or paused, it is not needed */

     if (strcmp(runstate, "running") == 0 ||
@@ -109,6 +116,8 @@ static int global_state_post_load(void *opaque, int version_
         return -EINVAL;
     }
     s->state = r;
+    bool vm_was_suspended = runstate[strlen(runstate) + 1];
+    vm_set_suspended(vm_was_suspended || r == RUN_STATE_SUSPENDED);

     return 0;
 }
------------

- Steve

