Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F939A05A15
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Jan 2025 12:39:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVUOG-0002ng-3t; Wed, 08 Jan 2025 06:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1tVUOD-0002mv-8w
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:38:21 -0500
Received: from mail-bn8nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f403:2414::630]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1tVUOA-0004fC-Jz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 06:38:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQZt00oMKAM/wkVRpQXvj2UZnhbp83qI/eHm9pwqxRYudvTubtUjRNyq9MTmtCdhRRu1zAm6OKR56IwvYLATikwck9RLxQ9V2fD78YOxO3XOmlzSsXgW/zUynzZbsKciNmdXlLVacXWOl5/HBV2DRc5JnYIYujM+kteonPq3KI8/cXXmPXmwOS/LyGQvyIW/EIMr/GucnghoBhD7i4Jk/k+S0nYT0qhhjZw1NNBViaHDDfkl3gT4Z+1vITkpgJD1fNRFRO2Ys2FImgIzMQAqJwUluuuo9t7kp4ZEYUMCpNivAQd50lEDk+CDMjPMw3Ml9rXg5IMqUYRLpA+Eii1gMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO4xKCaCkJQw2OoBICQP2soq7vpXAJjM1abS2vS5Cg4=;
 b=VRh4S8GbKGSvroxKpu+2iiXoHwy79YunCLZcBVcZu9CeLa8VFnlBxKGjeIplB1obx3K4ETl9iD/KvEyNPPR9saLrWT8RbSdLLjZcl447/Vvyclky3SO4zkxrvcwN2PxseXAJYwKphh+bZoFgPS9KFTAcG555K3gO4aku1+7pF/9drvOTieHsfsUI3K7jhMZRs76G2Z3XG30q7aaPAUEyXRqC4tOaI3ZuW0B/IqL3VRK3yj8Qw+KZx36zPqwnuELlXoQQnkrMDDQXraJB1BzhnA9m66yJvaoWAV15kUmQ3XW00ivpk21Ah8+yaBQF/4DjgWoSIm7ZI8++geK9Sq7mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO4xKCaCkJQw2OoBICQP2soq7vpXAJjM1abS2vS5Cg4=;
 b=d4vXOQvWWbLjfXvVVHMav7WDaGjOy4DPa8pIezASU3Z8InnR7YfrNrhljh+JECTI+vQ8X9y7dMsDHbjq4AS2Tb+yh0NC6VHb8FOiHm6lp4fkryREN726AZFWcoww2CBGiA7jVtAgl7gPtTOyXw5FfZ1Ulc8Inuy3UQr2hgTzbhA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 11:38:11 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 11:38:11 +0000
Message-ID: <6ac5ddea-42d8-40f2-beec-be490f6f289c@amd.com>
Date: Wed, 8 Jan 2025 22:38:03 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 0/7] Enable shared device assignment
Content-Language: en-US
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <2737cca7-ef2d-4e73-8b5a-67698c835e77@amd.com>
 <8457e035-40b0-4268-866e-baa737b6be27@intel.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <8457e035-40b0-4268-866e-baa737b6be27@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME3PR01CA0002.ausprd01.prod.outlook.com
 (2603:10c6:220:19e::21) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c6f092-906d-4589-976f-08dd2fd8ee32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekdyUWRjZUFSeGpxM2g3T0tsZTJOWE9zOWhkUk43N29GNDNKY0hxbVJGanM2?=
 =?utf-8?B?NlE0V2hLVUVqWEFwVFVPdWlWUG9zeTQraU41aXNveTJEOWMxdkFjUjl2SnNK?=
 =?utf-8?B?NE94aWpRdUUycWNOaWh5Tm44WTNlNzZkeW5GejFPUG1oSlZBelM2T3RudVRP?=
 =?utf-8?B?eFBVblUzR2FZbTk3cE00cTM2d0pab1hjRzFkdnNBTUNwRXQ2NmM3VUZRaW95?=
 =?utf-8?B?bXVmOEMrNXo3dWV2VGNWRTV5U09wUUNTQWdZRE9UMHhBOVhwdHNlT25OZkZr?=
 =?utf-8?B?bjVrS00rcmdnYUNONDlvYlNBNWxROGdVRklDM1NRK0dBOTlRVmlJUzJxNDRI?=
 =?utf-8?B?WGhUS29zOUVqV2JOV1dxT2FCdDhZS01UWVZRdllBNjgyZDZEMnpycDIrWE1D?=
 =?utf-8?B?cWhrMUZOSlBCdGVSbVl1SFZNRkF4Y0xIVU5sR2FjVEVLMXVTaHlJdVZDOER5?=
 =?utf-8?B?MkNXUm8wSDh5MElXT0dRN3ZZbTdmU2g4dlhjV0pSZUFET1hTUGxSSm9FL3dt?=
 =?utf-8?B?UGNuVkRyUXZtTDdJd3VhemtzcFBDMW54c1VXZ2FWRy9NRGVYSmE4eDRXSmwr?=
 =?utf-8?B?eDdDWXJCc0FmTndidXFpYTZEZkpQc1FmWFllSDBMVlMycjhocmxuWW9hZVd1?=
 =?utf-8?B?d3JhanlTc3RoMkR2dUpzYnNmdjg0VUZxQmxwUEVUWGlJaXhxYjM5UVlOT2ZO?=
 =?utf-8?B?S01wZHVjS3UyYU1UVU1hVnNCTlQrclg3UFZiUW0zL2FXcWtpL0dUL3NiSHY5?=
 =?utf-8?B?eWN5SEk4cEp1OXBrUDJPd2VFZnltWUxXS1hUNk1PVnlZRnF4SjdxaEd1SGFP?=
 =?utf-8?B?b0dwTnNjSjRla2tkKzlnT0tHVlJNSTN5Q252dGlQR0NKbmxzU2ZmTzJiczFi?=
 =?utf-8?B?TmlxaFF1T05ROStXdUxvZ1NvWnAybDFsMTRmZlhMb0dVS3Z2UVBBdmpFVFFy?=
 =?utf-8?B?TmM4MzJ6OXBmVzBzNFdCeUJLSkRJSUtOUk5vU1RhQmx3cExEWHVnUVkyaHda?=
 =?utf-8?B?K2N0aU9HY21KK29wS0NjSmFqbW54UjZzM0dYNERTQlBVMEpiSjR4RjFWanIv?=
 =?utf-8?B?aHB4OGxKSzFwK2F3UHkrN2tzdkp3Snp6dmgrRGZRZE1nQXVhT0xrK0x5V284?=
 =?utf-8?B?V1FaQWxhNHBSWnRZN3U1bmQ0QUVvVWtlMjR3OFhwODdZaDBadDEwc2YyeXFJ?=
 =?utf-8?B?VmNCRU9xdXg5VjlDMEtPbElxa0g2Q3RGUlVrN1VRKzgycWY3anUvdGRUR3Ju?=
 =?utf-8?B?VlA2eVRzVytwK3J0ZStMaUVlWDVDbzdtbkowblB0M3gwV3ZhS0N4VDVpcU8r?=
 =?utf-8?B?ZXNIN3I0MG93RS9jNjVOWk14YU5DMTAzL1NQK0R1V2lxZDR2WWdINW1uY29r?=
 =?utf-8?B?U1pGRkN6RkZXMnNaY2FzUkJ3ZEh1N3Q1RG15RENqTjF0T0cvbzFCd2xCeEQ5?=
 =?utf-8?B?aVhBNjBUbWZWZ0R0cStPdmdkeXBpQm1zYmN2NlZHN0lUM3BOZmsxcUQ1NEo1?=
 =?utf-8?B?SCtWZHYxbXpCN0prMnUwaG9mRjRQOGtxOEVuZ2JrVFQxeUJ3T24xKzkySHB6?=
 =?utf-8?B?WFRGRm5kVytuajZhcUJOTlkxaTZITXZ3SWFmS2VnSWxvWTBQMWw1QnZMVnQ4?=
 =?utf-8?B?aFJhQzZjQS9LR1VzL0NweldxVmZyWXBOM0lRVVBtczNjYUdRQ0NuSElxU2VX?=
 =?utf-8?B?ZGVUeTFUcXdOT2lNcXBEU0hQSTROZnVGSEtyNTRNOHVNejBzemJYVTJXaFBZ?=
 =?utf-8?B?TGdoQXZaTVk3Q214ZHROWnFoMGxHY2t5cDFZRXJOc2cyRUVqcmUvTVNVQTlk?=
 =?utf-8?B?RnNtUGh5blJNTnJ1eUNCQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QU9ITWlNWW9uTVBnS0tOenZLRlZQQzA2QkQ0UXFPM3BseWJEbE9CZWpJN0lE?=
 =?utf-8?B?TkhYSy81OGt0Vm1wRDVFZHVGNlFVREhNWjF0cThWUDh4VHdyU3FxSmVXV1Rt?=
 =?utf-8?B?RHBLRUVWSTlUaVM4NVpwMk80emUrcVZKbGp0MjIzT3dvaVU5dzZtVjU3UE96?=
 =?utf-8?B?NmxLT0VyUlc1YWt2bWJlTG1iRUhVZE40a015aXZoOTRIUGR5M2VFN2dFS3FJ?=
 =?utf-8?B?b2J0dTRDL2tFVlpHQ0k4YWJtcWJ6WjlMdWFXWXJBNE55ZjZRMEhsaW9kaUFE?=
 =?utf-8?B?ZlhtRkRoTllOS0g4RUNFME5XV0o2Ym5zaENJMVhlcW9QR0JoSE5ldFUxS3Rj?=
 =?utf-8?B?WUsvWklZMHVaWFdwSTRSem56ZzdpNGR5TGpHRmFiL24zRkE1MjlvbVNMaEh6?=
 =?utf-8?B?b2hPQTlTL3J5UzdzOEIvRTFDSUd4UHBhRThmTkplMkhOdnNCK1lDdXBXdGY4?=
 =?utf-8?B?OFIzSnBGbkVQaXpsdjFlclBXRjQwaHR1b1p3dlJDYmhlUmt4RHlhRlBCVzdl?=
 =?utf-8?B?L2dRNGorTlMraW52MDljZmtxQnlSNi9BanA5Z1NEZGEvbW1TTkdrbGJkSE9J?=
 =?utf-8?B?V2JFWjRlZzA2NzRkcTlRN2dxd053eTZwcW12SGFxbit2OVRaWXJ4VEFxbGZw?=
 =?utf-8?B?VEpKWjBBVnBUVkNxTFFDR2tIRSszUmhYUmZ1dldJWG5HRXIvWFF1dmNUSjRo?=
 =?utf-8?B?UGw5emRNV242YTNzeFhkNlhYWWJBSlJXa0REdFdaYmVrSlZJR0lpNEpuV2Jx?=
 =?utf-8?B?dTA4eGNRdzIxV3kxdUR0c0JUQ3BHbFZQQnpZZWxvR0gyTXZRZFRMVS9xbzd5?=
 =?utf-8?B?cms3QUZWSG9yVFZIVXEzQkxNeXZDUlRZUmIyeU1sOVdpNUhaT1VKVk11dGRW?=
 =?utf-8?B?VndLbisrdDJMYUhPdEJZT0xtVkM0L1NoenBoZ0ZjbW9mY2JLVzVRcnJ6S1hT?=
 =?utf-8?B?N0NWTDJGR21OTEJqdWhHaEllNW1Takh4RWVteHhERXdRZG1NZFZXVWgzZ3Nv?=
 =?utf-8?B?SzJXRFBMRGY4c2tTbXo4VnhvQk0vdFM5a2V4aVl2d2VmNzlRU2luaXFpUGtY?=
 =?utf-8?B?MFhwY1R2cUhoSmEwbnJsY2Q3QkQ5YmFZaEltNjFwaVZMa0ZXWW4rV0VlOHdo?=
 =?utf-8?B?MlpCRThqVWcvaHpESHNTb0FoR0ZqY2NvVmhPNVdmUHZSb3Zic2FHK3h3Snor?=
 =?utf-8?B?cTlvVlV2V2w0SjY3NjRIeDg5cGlwb3NaSUZSclZpL1kwblRhR01vTG1aekZX?=
 =?utf-8?B?azQwT3BaSG9mNGJkYnVOL09VU2JPUDNWSWJ5cVJJcThVR3czUExldkRUVHNq?=
 =?utf-8?B?R1lDdDc4K0ZPdWNWQ1J0ZnZXTzE1RjloUzNSdGNaM2sxeDk3VXRUMDVlWGNE?=
 =?utf-8?B?cER3MHVrS0laTkNQV1pGSkdIODJYalpEb2U0TUJ5Z0l6NjBmVzdVQ1pEZ0tG?=
 =?utf-8?B?Qnkrelg3amZxTXBCbHY4TWhKRldtSHd1OEE4amxvSXlsTHRuRUhrSFJzQUxl?=
 =?utf-8?B?d2gyeWVkNmV4WlI3Y1Y3cmk4Z25lb2p6VGdtcjlHQ3VmV2FhTjFlNUI3VzBs?=
 =?utf-8?B?RlljNy9iZkFINmRnQ1g3RmIveWxHRTNEMTdLWFBBeU9uencwSHREdDVKazNx?=
 =?utf-8?B?SEp4UVlEMmhzSWVib254OUdSejBPMEgxMnUwNjhybHVKc2xWMjZlYUlSZVln?=
 =?utf-8?B?eDF4U2F3MStLL044YXBkamUyZi9IWS9kVlU5eVM2OW1yWHgvd3hCMHJ5TVZY?=
 =?utf-8?B?SkkvcGJ0MkU2MU0wa2IvWTF4elNDUUJMRVRIclFBL1lRL1p0M3dhZkhrelRK?=
 =?utf-8?B?L1UyeFI2YnJ2SXRJV2ttZU9oTGtYWU5yR2ZHdUlzNFhtZkxRaTVodDFQSE83?=
 =?utf-8?B?c08yM0lmN0lpajhtbkFKT2Vvb1dEdmZydzhUdEp3TStyOGhKWCtLamtnZWwv?=
 =?utf-8?B?MDl4dXA0eDJMRkM3bndCVWlZQjNjWDhzVGxsVEdLYjhkYlFCY0J1V281K3Av?=
 =?utf-8?B?S1RFRW16TEhwY29oZmFqeDVxZWpBTTNTUkFsWC9zM2xQaDFDSTRSOUs0alUv?=
 =?utf-8?B?VjY0MDVWMkhsU2FsWUhYSmdmQkNtVjlXZEhzQmlOTllOMVFqSFNiempha2NM?=
 =?utf-8?Q?fuFvkow/vEnDamDM8DKwZ8+S/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c6f092-906d-4589-976f-08dd2fd8ee32
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 11:38:11.3383 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsyj+VGwKypHJnxafH3n1BRS1x228BBDRmWVo4LHtvLE/RjU6YgQBjzVXuBRUuzAN//pU5zB2SnyxTsfaEcd0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
Received-SPF: permerror client-ip=2a01:111:f403:2414::630;
 envelope-from=Alexey.Kardashevskiy@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 8/1/25 17:28, Chenyi Qiang wrote:
> Thanks Alexey for your review!
> 
> On 1/8/2025 12:47 PM, Alexey Kardashevskiy wrote:
>> On 13/12/24 18:08, Chenyi Qiang wrote:
>>> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
>>> discard") effectively disables device assignment when using guest_memfd.
>>> This poses a significant challenge as guest_memfd is essential for
>>> confidential guests, thereby blocking device assignment to these VMs.
>>> The initial rationale for disabling device assignment was due to stale
>>> IOMMU mappings (see Problem section) and the assumption that TEE I/O
>>> (SEV-TIO, TDX Connect, COVE-IO, etc.) would solve the device-assignment
>>> problem for confidential guests [1]. However, this assumption has proven
>>> to be incorrect. TEE I/O relies on the ability to operate devices against
>>> "shared" or untrusted memory, which is crucial for device initialization
>>> and error recovery scenarios. As a result, the current implementation
>>> does
>>> not adequately support device assignment for confidential guests,
>>> necessitating
>>> a reevaluation of the approach to ensure compatibility and functionality.
>>>
>>> This series enables shared device assignment by notifying VFIO of page
>>> conversions using an existing framework named RamDiscardListener.
>>> Additionally, there is an ongoing patch set [2] that aims to add 1G page
>>> support for guest_memfd. This patch set introduces in-place page
>>> conversion,
>>> where private and shared memory share the same physical pages as the
>>> backend.
>>> This development may impact our solution.
>>>
>>> We presented our solution in the guest_memfd meeting to discuss its
>>> compatibility with the new changes and potential future directions
>>> (see [3]
>>> for more details). The conclusion was that, although our solution may
>>> not be
>>> the most elegant (see the Limitation section), it is sufficient for
>>> now and
>>> can be easily adapted to future changes.
>>>
>>> We are re-posting the patch series with some cleanup and have removed
>>> the RFC
>>> label for the main enabling patches (1-6). The newly-added patch 7 is
>>> still
>>> marked as RFC as it tries to resolve some extension concerns related to
>>> RamDiscardManager for future usage.
>>>
>>> The overview of the patches:
>>> - Patch 1: Export a helper to get intersection of a MemoryRegionSection
>>>     with a given range.
>>> - Patch 2-6: Introduce a new object to manage the guest-memfd with
>>>     RamDiscardManager, and notify the shared/private state change during
>>>     conversion.
>>> - Patch 7: Try to resolve a semantics concern related to
>>> RamDiscardManager
>>>     i.e. RamDiscardManager is used to manage memory plug/unplug state
>>>     instead of shared/private state. It would affect future users of
>>>     RamDiscardManger in confidential VMs. Attach it behind as a RFC
>>> patch[4].
>>>
>>> Changes since last version:
>>> - Add a patch to export some generic helper functions from virtio-mem
>>> code.
>>> - Change the bitmap in guest_memfd_manager from default shared to default
>>>     private. This keeps alignment with virtio-mem that 1-setting in bitmap
>>>     represents the populated state and may help to export more generic
>>> code
>>>     if necessary.
>>> - Add the helpers to initialize/uninitialize the guest_memfd_manager
>>> instance
>>>     to make it more clear.
>>> - Add a patch to distinguish between the shared/private state change and
>>>     the memory plug/unplug state change in RamDiscardManager.
>>> - RFC: https://lore.kernel.org/qemu-devel/20240725072118.358923-1-
>>> chenyi.qiang@intel.com/
>>>
>>> ---
>>>
>>> Background
>>> ==========
>>> Confidential VMs have two classes of memory: shared and private memory.
>>> Shared memory is accessible from the host/VMM while private memory is
>>> not. Confidential VMs can decide which memory is shared/private and
>>> convert memory between shared/private at runtime.
>>>
>>> "guest_memfd" is a new kind of fd whose primary goal is to serve guest
>>> private memory. The key differences between guest_memfd and normal memfd
>>> are that guest_memfd is spawned by a KVM ioctl, bound to its owner VM and
>>> cannot be mapped, read or written by userspace.
>>
>> The "cannot be mapped" seems to be not true soon anymore (if not already).
>>
>> https://lore.kernel.org/all/20240801090117.3841080-1-tabba@google.com/T/
> 
> Exactly, allowing guest_memfd to do mmap is the direction. I mentioned
> it below with in-place page conversion. Maybe I would move it here to
> make it more clear.
> 
>>
>>
>>>
>>> In QEMU's implementation, shared memory is allocated with normal methods
>>> (e.g. mmap or fallocate) while private memory is allocated from
>>> guest_memfd. When a VM performs memory conversions, QEMU frees pages via
>>> madvise() or via PUNCH_HOLE on memfd or guest_memfd from one side and
>>> allocates new pages from the other side.
>>>
> 
> [...]
> 
>>>
>>> One limitation (also discussed in the guest_memfd meeting) is that VFIO
>>> expects the DMA mapping for a specific IOVA to be mapped and unmapped
>>> with
>>> the same granularity. The guest may perform partial conversions, such as
>>> converting a small region within a larger region. To prevent such invalid
>>> cases, all operations are performed with 4K granularity. The possible
>>> solutions we can think of are either to enable VFIO to support partial
>>> unmap

btw the old VFIO does not split mappings but iommufd seems to be capable 
of it - there is iopt_area_split(). What happens if you try unmapping a 
smaller chunk that does not exactly match any mapped chunk? thanks,


-- 
Alexey


