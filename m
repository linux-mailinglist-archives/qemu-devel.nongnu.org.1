Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CD87BB367
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 10:40:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qogNv-000381-Bv; Fri, 06 Oct 2023 04:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogNe-00033I-QF
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:40:19 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1qogNd-0002nl-Bi
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 04:40:18 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3967sDJG016338; Fri, 6 Oct 2023 08:40:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MmqcOmVy+hedvW8r1KWhg+YK09MYNTBj1LL7Se/pm6g=;
 b=lVp4W1RUoYze1w7URBHz3Io1foylH85/0m/1LTNtr6Lb26Mwmt9IhtFTllVN1l9PYWbF
 M7qneVWBf21I7UMA7psI48T3w455Y1DRSDCXcM13UAPRmGf6kysTZ4sjOSiBw7czNlk0
 Xo0i/xmQSMHaYLLxnxEDy7zP2LGki05WR6PNB2vuXqB3Y+q5N3RgRIId1AXxLCYPT8mC
 bCQe3nilxfiRTGj1+iASKeeJJ9Rjco1dnHyfmnCh8X/FG4xQv3AbpPoH1VWU7fZ6x8mx
 iphT80hU1K8GdwJXigmIT4WqZ2eLJm7uHQdt8AY127VMda3o1FpYHa3WSYuNwVMGZUZJ NA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea3ekc7v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:40:14 +0000
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 3968Zdrr000427; Fri, 6 Oct 2023 08:40:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3tea4a9a45-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 06 Oct 2023 08:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODrk3kOITAOllqWlTZ33UqDT6o/TlQHlNY1JpuKG4C8DXRLI4htx3g3HwINCd2kd8lH+SZX0nOwSwAL8QiVAkZ35rZvTQlQqX6msIMqVPIbpSaaoIsfowgM/bR1v5xkzMLdirGbgpgJB3BWW3CyISQ6hngCRxBUP3GJeJltVKbnH136HLqn/VHuiwBiXrzJ7EX7bOIM+tJPFcU/rEiI/56mPQxP6Teuj/1NOm0Z1RVVU2ORccm3knL5zjY/IB1B9d73YHV71yhk2L6e5P2OOLsHCn+bSRNkJz5cRDYQOQqh9PlYAyvLvSUOlmebwBQoHivT/Ztzrpby3av6VWMdkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmqcOmVy+hedvW8r1KWhg+YK09MYNTBj1LL7Se/pm6g=;
 b=MhydTzonrQJTRHj/PevJ+uLMVeejIxElfoBUQfnSXV0sQIetv0EahcMHOeAfztwYxlIjY0cJhFDo851SkCF7sfuFo6SC3u1srsxmuFXB0Qt2Tf7elmPPLCGQChPa4mpOq9bpayr+p2Sk+3tYAFim2pNuNQaJMRr7FI161TiuDfIRGtM/HedCn9KpXJVQC7gpoBHYJMbX1JCY1TtwG6FdXNF1Ivbsl9Tb+GFib7nvEbvMEWsA30RnnagoJ7SPIqy7U+oPwLBFT1KzD0WtzXQl7/CvVp9Z3PvduVDKX41lfoWK1EtM9uq3nDw4OSnEvmJMdXhPZZAtPfxZ3vft9MdcvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmqcOmVy+hedvW8r1KWhg+YK09MYNTBj1LL7Se/pm6g=;
 b=SAMRCYtbxnPoDO2rPU2Ca3NHBWK2pjWsbOzfPTiVtLK2QwUE7Rla0xHL5a6yFici/oa/BisUXTb61eBcgkmxkso3mb+eoMCSnaOe7Kwm3LhxOdd0st4ldi10IdlSMhzqZCNvUXKlBN1oKcg2CaGsY4KBtKD7uiOXn45i8h5PnhM=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Fri, 6 Oct
 2023 08:40:11 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::64b1:cd15:65a5:8e7d%5]) with mapi id 15.20.6838.039; Fri, 6 Oct 2023
 08:40:11 +0000
Message-ID: <b2386603-f444-4bcb-850e-2fc48444d680@oracle.com>
Date: Fri, 6 Oct 2023 09:40:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/15] hw/pci: Refactor pci_device_iommu_address_space()
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Avihai Horon <avihaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-3-joao.m.martins@oracle.com>
 <2380b011-eee6-252b-f523-9025cfdb16b6@redhat.com>
 <27aedcfb-c77a-4cfd-8f53-30d9acb29954@oracle.com>
In-Reply-To: <27aedcfb-c77a-4cfd-8f53-30d9acb29954@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR05CA0005.eurprd05.prod.outlook.com (2603:10a6:205::18)
 To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: a8af01a2-e5af-445a-fed8-08dbc647daa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97EhR+fYUmMzlul4+FyBFTHDBOUKfWcC3LcEfhCEQhiU+xisZnzK708ujIvF5CmG/519kNAExXV9WS8cQWpYlsM1D4HVfQimnHCIIewrNWNIzTc/Utz21XRUjNbi8O6FL5nIXgc7kbaoEVy7O3XoE/vy+rmq0UM2JYLMVvSKerOdYkP425SQL2JrghmzprBIhJB0RmCoJtE2VBhbvC46LqaO69gqNcv2GMNXrrmlbHzKQbHS5c8l428+wAm0eGxQPz2rDu/yGLLQI9OT8QIEw5l81faoKvjEC5udD8Z17fR1YrwVfMXOhF/WGZuBSqVezb7w7z6wIgW78b/96+6klRrChTD+U++ggHJEWcUVdKvV9AR8j33sEMJvS/blhLofkl1eDN4Y0T3VIR2TWpDYA0TeK4vY8y8KF0cTVPqTm8PGc/ZxAv5Gr7hriwL8rN0Ks7b8hVBzMhJ65sfnfbDMA3zwsXjFpoXCkdpxyI49gN59aDLJUolYF73C3f+wJ2Gx8v4te7tmwVxBBq1j1LBnMdKka/zGRgGgvThx+3SwCZvW4d11tit26lOPNm/5nx77UOw6ZpOOnF+Fy5uaKX+ETHWRZqnDn2ZIrdRUzp5p0eSceK5sRQgiSB1SSen/sf0k85D3NxfNE1zIxMyZ13ui3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR10MB4835.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4744005)(53546011)(2906002)(7416002)(86362001)(31696002)(38100700002)(36756003)(316002)(6512007)(41300700001)(66946007)(66476007)(66556008)(54906003)(6506007)(2616005)(6486002)(31686004)(6666004)(66574015)(8676002)(8936002)(26005)(5660300002)(478600001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NWR3FvS0J4UDJ1QUdnejg1aSszcW1oMU5BeitMVHBHT3JmdGpxSElwWkFw?=
 =?utf-8?B?QU5TQytYR0NNUnhzakRheDF6Rlk1VzVOM2h4RGR2NFQ0UzZCanhmK1EwOEpu?=
 =?utf-8?B?KzN0ODdSaHYrRHREZkk4RG1CaDNudkpaQTZtNkN3TDVFQ0FjbWtFZkhGUFRX?=
 =?utf-8?B?WEpueGp6bHY3NjVlL09kMDQvdUNlNE9tYTlvaXZ5NXl3R0F1ZWNBQTNLd3hC?=
 =?utf-8?B?Y211cnJUdnp6RENaMzhzRndKYUJKSTJjK2VucExtT1BmUTEzc2RXcWcxK0xD?=
 =?utf-8?B?WnE0cmQ0YVdUd3oxdXoxTmRJOXFObDVXRzg1Sm5rTy9sUjBIMHZCZjMvZ0RO?=
 =?utf-8?B?L01zN0pmeWFTSFlBWXZmWkRjUUttQ1VLZ3hyNVRSR3NmclRQUFV0Q1BNV3RN?=
 =?utf-8?B?dW4zbUZCYXZ4aHU4S0ZuaS83M25LL1M4bm1KOHZGUWZmZ3VRNWlFQm5wbVNo?=
 =?utf-8?B?Vk1BWFpJb0ZoT0lEMWU2WUZLcmxnazRiNDJnRlpScytOK2tqWWFza1UxcENC?=
 =?utf-8?B?eTV1MDRzYTBrbEFQandCVWFYaXFiMjRTMWhCMzY5Wm9LWkdGQzNhdkd1MXZ0?=
 =?utf-8?B?ZzRncEkwWEdYSHU3MlVvTndDS2t5WjNMcWFnaGpHdjNTZHlmQUVEL3ErNUdB?=
 =?utf-8?B?eXdxOENWenNrS2c2NXF2R3NiLzBZWnpnU0Y0a2FlNU5nOGNOK3pINWhRVkZX?=
 =?utf-8?B?RWFIWGhQWjRDNER4a0syWWV3ZlVqVlh3YUl2aXJLOWdXdGdnVE4rWXNwUlJq?=
 =?utf-8?B?RGdzV0hCM09rMEZ5cnp0bWhOd1Q1cU5DMnpLUUlvajJxVzh0SGVhTWZEWmhH?=
 =?utf-8?B?Ykl1dzc5bUlVQ3Z4TkZ4T3YvaTJHaFBMam9EVjNiemJBcFhGcllOQTh2MFg5?=
 =?utf-8?B?ZkdpczlSditVU1kybTRBYWtlYUxDUnowYTN2cnhPWHVVZG9wMzZPU1FjRkJW?=
 =?utf-8?B?SUErRzlSK3FhVEx0UU5oc1RoM0dqbUtab28vQkdYTE0xVjZweGNNVnRQMWJ3?=
 =?utf-8?B?ZUVYQklBOWh0RUl1VWN3QzIwRUMrT2dDU3FJcjZVREZ6ZkJjeWFUVnNMb0lu?=
 =?utf-8?B?dlVjNVNHR2VpSWh1dWNGc21PTndIeW9aSTZzODV5VDhJUG5xeER6dVlLZGxR?=
 =?utf-8?B?V3cwQXdER2wxMkNqK0VrT0hsSll5MDdNcHhsWThNczVsWGVzTUVYeGpIcXp0?=
 =?utf-8?B?eW9Fdk5DWitBaXpaQzhTNE1vY1l6cVRsUStYUnVidUpucVZPeE5KK3BvMGtL?=
 =?utf-8?B?V3QyUEl1bW9xZHA1R2ZnakZGOEU0RndQaEhEeHgwU3ZYOE5PbVpnYjQvRVFN?=
 =?utf-8?B?bHljMThVU3JRSEVsRHZhN2duUFhuenFBSnN5cERiZ3kzdGxvQVBPcXZwdUdI?=
 =?utf-8?B?ZGIyaXBXT2lqREQ2QnJLTml4WEJpNENRbVE0V0JIbFcxdmJkRGgzWlM4b3Ft?=
 =?utf-8?B?RkVDWGtRZzlxL3cycG1jOTh1NFpHTFZ5ckd1dUhqY0dKQ3M4bXhvSC9ZNE05?=
 =?utf-8?B?SSswclNKUGxaaWIzZ2c1eTlxNDA3b3RwOEh5Qm1SdHpBNnVxekUvYnk3dGVt?=
 =?utf-8?B?Rlc4WStDRFJNOTh5Rlh2TUd4YU8xUXJ0ekdsRkU2Y1ZiY0RGUUVPczdFVWsy?=
 =?utf-8?B?RVJIbHBla0c1dHNaT2k1T1UrSnJkSVZ5SVlBZi9nTUtscThwdlhrTkg0S1Fy?=
 =?utf-8?B?Z2hWL3BXNHliUjN0bFdobFdyQlB4WG84TSt4Nll4b1dOQ2Z6OTBQM2YyVmRC?=
 =?utf-8?B?MnFpSCtJRmRNcTNYbXY0M1RxWThHdzQwWW5BbXkxbUZBOWNJN2EvbkREM1J1?=
 =?utf-8?B?N2t1MzRGUEluZkd6UnducnNOMjZOeE42bmd6U3llUit1c2hqVGpIRmNSQzY1?=
 =?utf-8?B?bVRmTkxtV0U1SXkrV2RPQ0FHOXJmQVM5ZzB4aDJUNXc3YkRPbHJYdG9wbnVz?=
 =?utf-8?B?RnFvUkptVDhFdTFQck5VRXZLTUVkczhSak9mU0dEdS9RSlFLZi9vMkNSNk9s?=
 =?utf-8?B?K0hYMGlVUmllTy9VekRsUG9hTXN5TTN6cHJ2Y3NOZEpqR3hQQTBEVnd4dDFr?=
 =?utf-8?B?b011cUFFUUJCeUxsUmc2MGJPdGM1QUZqSC9PUWRlZ2xYSzUvUndZRlJaKzl3?=
 =?utf-8?B?RUdIaWE3M2Fud3k2QStvRGN3ckx2Skd6TERpQlhvN0hDNUsweFRzL2VFQ0NP?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tl4Lpx+nIkQUNRH87xpdiuorPtCg7wzkYdNtlxnuCnkXzE4nW8d4IHxXqcChbu9ALz8Zn9ZxYsuJ/QyWwvbfdL8VLv2/1u3hb75LfehTH/6GIvUUikOpixND0lYp3fPzT04GInHzj1lUaCCqXMaNrhwu/OCW5lX7ogc9tOk3rzwh4J87HUWGv7PnlOwbeLOoyJWb3IOdI8ZiijVQEml4JVPc2DQJhqMR4yI0kfGnbL7cUAvUKBhbD0seRgDfV0y4nH8mXlAMdXB+HO9PeDhUzdZ1crM/wgPzrjPQ14ujqDOJo+F16KzxBS1v/1EkkxauTadsttb78MOm+aU7Jghh9zy6xxoFHifLJtQW0HGlgzOfo2BSN6IHUdFGYfi1VArY7p9d9ug+sRfmhEIjiiEyg3/DlacLVEfCvwXbcIpZ+Dsl2xV3PRCRROVZeaOSIIAAkGKYQ9IpS1ZcFoHpOPb1NC57y6mBfU4bsiIR3b+Bb3jm6cTZ1T9pg1CAyNFOHRBiOTicuKuZiLVRWz3vamtm1avDlIm2TyjnhG04JHLiUOoyschRjEufaADYTWUvrCoBKnBadQJ56p57W8RelEkvFw4aRIvuzXfe8tkCNUFk+dMYXh4VSRRG5V78EZpNV69fF6tbfpllw35QDv4yM8ZwQOEibYXRHUiPCiSjxkxfw67kGThm5ocPI9Y61+usW6sDYZPCuMmKeWlowb6eJs5SlJxfyXL8of3TavGrBR6gElELIHW1L2rwGqDVdcCyOxWYzaYAoZCENUwSRy6x0uAnj+LdeXlzaNcInHgZ9SDtUwhu7FFPEIH+J1Z2CNFguRkhvoW8Hu33VGP4CMbkMfrYiIfdN/M1Qgmn6IMHoOm78a+B14Hj0pR1Qo5VnnptpMPWbWDtH+GzqnY50sQh7wFmTIMd3+CpU5F9Zj2iHUDpPUE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8af01a2-e5af-445a-fed8-08dbc647daa5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:40:11.7954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulM4Vs0VEwiCJiKhUz0dMIKt12+J3UbLm6yYuMqvC+CCEe0Ir61ujVIliyQvQo1OYm7t9E00nE51n43m5/SfX5ZtSnGELWZo31XTmgq4ix8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_06,2023-10-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=981 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310060061
X-Proofpoint-ORIG-GUID: L3A7aAWdmbI4vedPSGTg9LNVnLoGSeCk
X-Proofpoint-GUID: L3A7aAWdmbI4vedPSGTg9LNVnLoGSeCk
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



On 06/10/2023 09:39, Joao Martins wrote:
> 
> 
> On 02/10/2023 16:22, Cédric Le Goater wrote:
>> On 6/22/23 23:48, Joao Martins wrote:
>>> From: Yi Liu <yi.l.liu@intel.com>
>>>
>>> Refactor pci_device_iommu_address_space() and move the
>>> code that fetches the device bus and iommu bus into its
>>> own private helper pci_device_get_iommu_bus_devfn().
>>>
>>> This is in preparation to introduce pci_device_iommu_get_attr()
>>> which will need to use it too.
>>
>> Where is this routine used ?
>>
> 
> Patch 7 to understand if a configured vIOMMU supports DMA translation,
> regardless of whether the guest is doing.
> 

And then patch 12 to see the max IOVA boundaries of the vIOMMU possible address
space.

