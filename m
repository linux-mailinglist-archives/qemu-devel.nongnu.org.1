Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D757A1649
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 08:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh2V3-0000HP-74; Fri, 15 Sep 2023 02:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qh2V1-0000HC-23
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 02:40:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1qh2Uz-0005iQ-7r
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 02:40:18 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 38EL0Bn0017151; Fri, 15 Sep 2023 06:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Wzt/MtmAkywUcArUh36RdRD4xERp69AmY0li7bmBZ3M=;
 b=xi2n8Yx3ifFq8YnJaNR2X49mRhVA4eiXrGM6fLFJHJqKfBT9CzpoFYXKtqXVElkvLHQ+
 V4Deraq+3w4XqqCpBOtxFUSuciOV8jBDNYHZijVY3Y20hSTLq/5O7FFchBSVIQmeApae
 Si74NkyWP8hz6iImZoDehEywvC/0VrR8lcD2K5B32yJFzyo/MsfDih76zqOv7O4KWUI7
 iZ2iQnsZgjwfChaLw85arX2OPFW0FFGvHHoSJ6RCFRFJ6boNb9yMi2fyfIi+SvuyZZ3h
 yStHN94FJsapmQnTj3r0SVDxmxE2Xvc+T1mClxiR9yqznXOXRNzD+RKHz2amiTpZUpDC 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pq07u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 06:40:02 +0000
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 38F6Nkpt036194; Fri, 15 Sep 2023 06:40:01 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3t0f5fy2j6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 15 Sep 2023 06:40:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmtlg0In2Vc6KZU1zrXXvUcfYEb4GGtS+ACgeRq+k17oUPmkYE7GylSpyTvd0miF3p/G3EBhqeUkOVgMXcdNuiyovvxp5V456VpExgECd9x80Tex2m+blqEC7m4pnthfEu4LPW0dJ3hYoyd7aBQ4XMbtXsu8ZN+sAqrrdWWPc7Pvxqo6CbeTXtXcxIijd0y9Pk3uJZ7Hh7pxzfrwm92KoMLDpuK1bfJdXp8j84pso5vWeK+i6cxJv8d/p+lMXjb/JNqSqPk9ons1l5RrUAAd8rF/lNEUCaR3rSP1QUK1eea8C8/KVhcmP0wbLyQt0vbVzLHrxibk9md6bsBZytgURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wzt/MtmAkywUcArUh36RdRD4xERp69AmY0li7bmBZ3M=;
 b=IrjbGF+nnf5vlfxoHwy8f7H79Gx/pbUePt9ZeMxg708DXLe+zejh9xK+M1YRUKWhIcS7AsQGp2xjRR2cCWj0+++UjHdwLr15a2P9I+X1HTmDaHCZUdpo0AvesSxlN3TIdPM+rRAweca7AgLYP5/SaEx2r6DUR11GK5xUnRNIjfpUhWMLoFG4Mux2qx7BHpVPV3vJqeHgTMHYiUvuPv21L2X7oTOZrF82O2HA3SXE82fF2XS9BFlYhDPJfBLUM0LzKsG4tqWNBoTS/nRcmMf6MV4u4tgopPAsgnkgh6irXSjKVD27Nm2JHCdsDeee5tpCyBjY2aK1FiooR+z+oSp/gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wzt/MtmAkywUcArUh36RdRD4xERp69AmY0li7bmBZ3M=;
 b=Dfhl7VAjl/lYzpauNH46giKsiKSB9umA8IiETYPtbL0sbsl3OtXh4z9yVHxeD4lEMNIRvnfPvuVi952AtgwpGHFroqX+FiMBaooF7/rI6xlMJvTbIoWfLGn03HFGT4+F91OudMOVawXDOVi6m7wyI260vzKvdIJ/IcdUSNN5hLk=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS7PR10MB7321.namprd10.prod.outlook.com (2603:10b6:8:e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 06:39:59 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::9971:d29e:d131:cdc8%3]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 06:39:59 +0000
Message-ID: <80844a84-525e-24c2-da95-fe8d13e43b61@oracle.com>
Date: Thu, 14 Sep 2023 23:39:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 0/5] Enable vdpa net migration with features depending
 on CVQ
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Shannon Nelson <snelson@pensando.io>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gautam Dawar <gdawar@xilinx.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>,
 Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>
References: <20230822085330.3978829-1-eperezma@redhat.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230822085330.3978829-1-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::24) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS7PR10MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5c82d2-586f-4a6d-ab4b-08dbb5b69507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2MBLERpre0xnEbWi9g/j42hMzgyC6BYh+f3aExqkilOfJ7hBHCC8BnCqhnDZYhbPXv6x8kI8YVJNq7Xu+SPWqUC54JHjoRLE7VgrSTTNNE9+832QVbeyt8NJx9UeXawWhzmPgGc/Hv7ZJGRKyIf/63Yl77M4CmAaY9GNja0pyzxA+EYU1hJmm48vynmfh9uYbkMT1z5l/EoKi+v5K5P1O8EqmqlrSfcgqFvWI8R3zxY3eMPeLe98VKnWGMewKK4UZzcxlSB06wNAOzkqeS2C5h64bYWj+QOr+dJIDuz3M5/7AzEdlg7Lwv+1ZGud4bphuhjhth5uEgCGNo9YztiQHH74+axldgxbmOpEAO9nZ88JzGpvObyoxeanxCpLvEWafjWiePakLmSQD+Qpxrazkm5I2snMDUyjBjSv6USwidjs5zZLAC18YyR/o3T6ZgtvSJiFmg2GhXymlsDkMihABRexbWW9x7ArDtGhce5bGKRe/SHrgQbQzn8bML/OikNe3UUvP5BjXydbsHq6J449MWOZjE+VM/r8JOR45MhaaCfQhwBWRXZzkE3fyDnB7FRwHlCewStixt+LRwXy7cqYm2XMEnGyrGDh7XL3rfrma3N5D3lRpuGZPCQXfyyzGODR8szLtB0DcrAiR9bCw40j9BvSawIT3cF8qPEBkvJ0Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(186009)(1800799009)(451199024)(966005)(6666004)(6512007)(6506007)(6486002)(53546011)(36916002)(83380400001)(38100700002)(31696002)(86362001)(36756003)(26005)(2616005)(66574015)(4326008)(2906002)(7416002)(8676002)(41300700001)(5660300002)(66946007)(316002)(54906003)(66556008)(66476007)(31686004)(478600001)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRiRSsvaTlSMFd4T2tKZjhacHQrZk9YQXpYajdCQTBkYXVJV1F0ekhpZ3pP?=
 =?utf-8?B?M3prTHY5N2ZlUlVWZ1RpUGJBQldzakRBL01aK01jUzZDdmVzSDlBN09SZnlM?=
 =?utf-8?B?RUQwbTRyaTg1bzlYOU5QZHduWDVlK0dLYTA3dDZhMnM3aVk2dThCaWZ4WlND?=
 =?utf-8?B?dXRsWTlGREtia3pyd0JlM2NCSVBaWVlKNkd4cnlZTThubHN5K0prRFhnWmhV?=
 =?utf-8?B?aEg5REpFQUZvbmUzWEVKSHdZOGdQZzFvU2VJTVNGM3JFRnY1cEYrOS9SaTY2?=
 =?utf-8?B?S3lkQTV0bjFZeUcyYisyTzAraGVKamxHNnJZSXZxZXdraWloRXFIVzhycnE4?=
 =?utf-8?B?UlFwWlZzaTF2OGNmRCtEektGdU1aRGMzREpCTytRY3pBejJqRFVwMnhieEVx?=
 =?utf-8?B?WHhLMXY4RFRZaEZpN2V1aVRyeHhzQXpOT2lLbUE5NDBNdHBId3VwbC9GVW9U?=
 =?utf-8?B?dHRialVhS0hGckNxTElsU0ZWenJWYUFYVW1YN1l2UW5GSEFOeWlXaFJTRUcv?=
 =?utf-8?B?cFJ0ZEpPMlZzb3FDb3ArSGFmTU9xOUZBNW9QZ2IxYmdlRHp5cnFQSUptQmsz?=
 =?utf-8?B?d1FRdzI4d3dXdndJa05GL0pNeWh4aEtVM3Q3VE1MdndRT0pHMDVIWmg4eWUv?=
 =?utf-8?B?elB6N2RHSE9ubU9xcHZOVUVSQjNIWXhha3FEUUVBaWdQQmQ3dGZRLzJBYVRz?=
 =?utf-8?B?ZjkzR3dYTWJLSENwK3kzYVZCOGZyei9IYkcyNjNnbDZOYUl4cGVKdGt3dzI3?=
 =?utf-8?B?eDJKYnhDVEI0RmNuK1Q0dE9aU2ozazRpOEhqeUlHR3dQbGV1UmRYbzFjN3pX?=
 =?utf-8?B?RUt0STJmQWxob1loU0N4Wnc2UTlWK3Q4Z1hTQ3NRNDByY3Y1M2wvbTlMSGty?=
 =?utf-8?B?dncraXV3Q2tsSWgxYjJTTGt1NGsrNDdtaGdNNG1HT1JRMUFVaWxrd1VYd0Iv?=
 =?utf-8?B?a3NEODJ4cTBQZXZpNVRCNmdPYjAxdkZnMWlIS2RSelZiNWZIZHFTZWEzbXBi?=
 =?utf-8?B?ZmVoelVYZkVjcXBId1JwRG45V0N6bm54NWpDeUE4ZXd4YmhYTzJnZUJiTHJ2?=
 =?utf-8?B?Y1ZqMEphVVlPVmdpdkNkOTJaY1pIWkwzaVMxd21iYnEwMTlXWURMMW8zbk9Y?=
 =?utf-8?B?Tlgxbld6WjFYaWEyYVA3MXBzTDFXNGt2TjNrWkhOb3pKRzZ3RG9EVE9vWlow?=
 =?utf-8?B?SW54SENqOXVqR1pmTTNHQmpXN0ZkdHJma0RqODUyZ1l4ZEFBcmFoNVBHTEhE?=
 =?utf-8?B?UnhrREZ4Tk95Zjlwd09nbVFDT0V2SmI3UGZ4TkRUc3dCZERENDZ1OVA1Q3FL?=
 =?utf-8?B?WFVHdHlGOEFEclZWREk5U1YvbDVpWmk1Z0FwQTZ0dWovem9nV0oyeDFFa1VI?=
 =?utf-8?B?L01MWVlyUFVoMW82bkUzUHNvTzIrRUNDSE5rSHphRVRiVUhjbTI1bElVVk9y?=
 =?utf-8?B?RDV6aEpyUDZNOEdHcHpXcDhhVCswVEhQd0VjVk9tN3JqMHBBUlcxRU9Qc0Zh?=
 =?utf-8?B?ZURJckFwb0ZMZXNmQ2VvQnp0RGlWL2t2bzZObzZVVGtkMFpCU0s4ZlpKNUhw?=
 =?utf-8?B?eWVoSFE2ek9kdUpjRzQxTTY5UG94MHpDV09SaTlYMG41YXRYa1RRYkxXQTBq?=
 =?utf-8?B?dTVMWkNVNU1heFJXVGNhYXBBZ1RETWFlaVJoN3JQeFhZUkNsNCtuKzY4cmhT?=
 =?utf-8?B?VE9EYnNndTd5Rk9CUWt3M1FuV2MxVzlqa0p4dzVBT1lEbUVIdnhwZkpuVG5s?=
 =?utf-8?B?TDdHdUdBeXpGMmRKSnlMLytkZXdwaU1Dbktqb04rY0p6dTJNMGJLQ3pJTUZw?=
 =?utf-8?B?RTRrODVnVmlRMVBzWGw5UWxTZWJUcDRxblFUazdaK1JpVmZ6UzRSZnhaYVhM?=
 =?utf-8?B?OFhXdmJVTFNEcmM2bnI3UjFxU2NVRTFLaE04UGVBT2tEZzlRd0tpcWhQQm9s?=
 =?utf-8?B?WVNGeUZXZ283akNMWnMvN0tUbWt2a0NTd0dLeXlBV0p1a0ZCRnFJayt4eVll?=
 =?utf-8?B?cHZKb3YvVkxmdUlhU3E3TXA5YWpSRTZuVGZUcDlWSkl0MFNMUm9YcVFaZzJl?=
 =?utf-8?B?SXNWY2hHM1Y0bWVnZjR5MVZOdHVJUXNIUElzdUtCQWs2VkZKNGxPemF6ci8v?=
 =?utf-8?Q?dtBMRrdlalp3vbKN1xVoiTVfR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R0F3bHJ0TzJSNkpRczBQQm1zY3pxVXd0eDI1b3ZzNDBJVC9xQ25HSUxrdVZp?=
 =?utf-8?B?UzdOdFptS05hV3RKbkppaDlaMGh4c3dkUjdDQlRNVmxpMUNBS3VubUJ3cTNv?=
 =?utf-8?B?WlFMbXRnQ0xTSVVNTHBBS2dGK1ZGREFXWngrS1dYZFZhcWNCRFNybXR0Qkgx?=
 =?utf-8?B?MGhnTk1ZVHM0K3dvdzBaeVJ6ckVLellORHhXYXl3K3BSNERBcE1yNU9sdEpW?=
 =?utf-8?B?YjlDLzhRTHdGdTZLQ3k5cWdlREJOK2hMTk0rQ01yQTNnL2IxQVcreUlJRjlX?=
 =?utf-8?B?U080Q1ArU1J2UmtqZVQ5NkRIdXZjS29haFJKS3pLTFlSKys0K0R2RWJ0enA4?=
 =?utf-8?B?ZkdxMUxVUHl6bi9HZlZzVzRYcUZHVzRPYTk3THUxVVAzb1IrUjJseXhDSC9i?=
 =?utf-8?B?ZnVkR3BydkNSUVhMRFpvWUgvV2ZWWmY4TWZXdmxSQVRkQzlaV0lQczB0OHFp?=
 =?utf-8?B?U2llbXI0R0Z0MGxnM1h2RDYyY25udUZTVUJKdzNObmJjSWNrcmhESE5uWEtW?=
 =?utf-8?B?UXcxYzROY2w3VFdxdGFTd2gxTFVXOU10R2JRR2JoWEVMVy80NHM3WXB1eWtm?=
 =?utf-8?B?SkhSRGo2VjhhemYyYlhOTzYvNE16cVhUZU9yV3RFM0djdkpwb1JaYjRPQmxH?=
 =?utf-8?B?Zk5wdWFVUGk0bFc0WFdVSk1rM0dNZVcraGpSVi9MQWN1bGFCK0RFSERXWGt1?=
 =?utf-8?B?dkRzczZnNjBUWjlFaTZwWld6N1Q3ZU9qSXErdzgxeDhaNjluczlISW9rcFRW?=
 =?utf-8?B?ZG1pc1FCa0xrcGlabHR4NDJkSVlxUC81NTUyS0RKN0M1elI2NGRiVWJHR0Ri?=
 =?utf-8?B?MHBWeDJmQlBuZ0J2TzllbTliak1HTHF6K1pWUEZDYWJ5OEg5RjhPVklPRWNo?=
 =?utf-8?B?emNYOVFFdlBEUkhCYXZOSjJBN3I2cGFzVmZYOE1SUHZQOEMyUWVqakIyS1Ay?=
 =?utf-8?B?TzBNWU1FRk1SMmVLaWcvVDVUaWI1ejUvKzQ2T01acTRHeGdYYzJzYjkzSDlY?=
 =?utf-8?B?UHk2MlM5NjZtOXpYaVpTS1Z3UE5Vb05NVm1jbEdITkFZdlZOSzF2Tnl2aDdG?=
 =?utf-8?B?UWRwMFRPSWY4enIxMythR1UzUUEzejdyZENyKzllblVYSkNWc2dndHh2OVdn?=
 =?utf-8?B?UXdZb1UrMUdXSnZUMi9lWjlUVEVrd1Jsc2lCcy9RV21Gd2Z2Z1IxeTdIbHVn?=
 =?utf-8?B?R2tvMGhZM1dYU2lvU3V4Z24vem4rdUQraW9iaHNFTW00N2FUUUYwcVEwamZB?=
 =?utf-8?B?SDcrQUN5d3lSYXhIZDVXcmtjNWdyb0ZIVlpNRDV2QVJUc3FhUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5c82d2-586f-4a6d-ab4b-08dbb5b69507
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 06:39:59.3845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /RKDAxcw+1dLlDHGCh97RspSD+wY04gGt6DyfLQuK3UPhTl1nhJqBYnZ5ySue/ROsbp/C/IUFAADRAHNCfnNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_05,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150058
X-Proofpoint-GUID: ZsFuxnZsfhimP5TioEnWSZvxS5EdQ1-J
X-Proofpoint-ORIG-GUID: ZsFuxnZsfhimP5TioEnWSZvxS5EdQ1-J
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Does this series need to work with the recently merged 
ENABLE_AFTER_DRIVER_OK series from kernel?

-Siwei

On 8/22/2023 1:53 AM, Eugenio Pérez wrote:
> At this moment the migration of net features that depends on CVQ is not
>
> possible, as there is no reliable way to restore the device state like mac
>
> address, number of enabled queues, etc to the destination.  This is mainly
>
> caused because the device must only read CVQ, and process all the commands
>
> before resuming the dataplane.
>
>
>
> This series lift that requirement, sending the VHOST_VDPA_SET_VRING_ENABLE
>
> ioctl for dataplane vqs only after the device has processed all commands.
>
> ---
>
> v3:
>
> * Fix subject typo and expand message of patch ("vdpa: move
>
>    vhost_vdpa_set_vring_ready to the caller").
>
>
>
> v2:
>
> * Factor out VRING_ENABLE ioctls from vhost_vdpa_dev_start to the caller,
>
>    instead of providing a callback to know if it must be called or not.
>
> * at https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg05447.html
>
>
>
> RFC:
>
> * Enable vqs early in case CVQ cannot be shadowed.
>
> * at https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01325.html
>
>
>
> Eugenio Pérez (5):
>
>    vdpa: use first queue SVQ state for CVQ default
>
>    vdpa: export vhost_vdpa_set_vring_ready
>
>    vdpa: rename vhost_vdpa_net_load to vhost_vdpa_net_cvq_load
>
>    vdpa: move vhost_vdpa_set_vring_ready to the caller
>
>    vdpa: remove net cvq migration blocker
>
>
>
>   include/hw/virtio/vhost-vdpa.h |  1 +
>
>   hw/virtio/vdpa-dev.c           |  3 ++
>
>   hw/virtio/vhost-vdpa.c         | 22 +++++-----
>
>   net/vhost-vdpa.c               | 75 +++++++++++++++++++---------------
>
>   hw/virtio/trace-events         |  2 +-
>
>   5 files changed, 57 insertions(+), 46 deletions(-)
>
>
>


