Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30942AC4973
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 09:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJoyD-0000mR-FR; Tue, 27 May 2025 03:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1uJoxE-0000U7-9r
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:42:34 -0400
Received: from mail-mw2nam10on20601.outbound.protection.outlook.com
 ([2a01:111:f403:2412::601]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1uJox8-00004t-LC
 for qemu-devel@nongnu.org; Tue, 27 May 2025 03:42:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMBtQgPvY6zEEh2sybkklD6VWDcuHrWmD//w8R26fwArsEVPe7F9KTpSCoPhAsRKkA9kVYIPuRkViAoiUl9eSYICYcPPKPk25rpIZ8ZYF+y24d1tDcqUZhCszs0+9gZlk7hgJoxlsmpRcxJkJiB7uCflq/qWVnPWEC+TMQ1eHw2Y4qfxHhtWXVWX0CX7Bjf4UF6n3NnCCMbpxfN805QVb+CaiPPfiuNHnMn5ghFrhbBXSXARb1lmXCyV6M9gQ98KkxCGHRclnDmC4qyM8+xMQkc2PMDIvDZwdvIv3lhumi5EQvUTUiXDUJdsZILqUjm1CZUa+I2gob8tOiB8dJ0vww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEL88e3JEduLu7dLN/rsHyzXybjgUcqectbfVVMiPCc=;
 b=OYxcH8ESblaVah90iRs3jzndpeOVBsK+EdQau/yyXkQLqitrT16tYvMFkw1G3VxF+dKqIlGBjbS65yTOUItZ3HT2zSgBnZlv3dYBT/wgaepASZbihTeZKX8UtRidOLTvKSK0ebwH7jQKfGsoPtGe9pKRvVoksdFl/dfPA/5rScktCdp73GGRFkvaVIcbJp43lbn+qFjYN2qCviDRU2CS5gMJdlRcoBRFQ9m3hL82/sQ7YwjUK1eleP8OrAfB6SoU4k9yuOoPHkxPyhQfiJUg2GeKb5iW1wqN3TNzihpxD75ftEC3ZTKG/2g4Pb90FiTyDmsehkyFYJ3ya6j+FafJQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEL88e3JEduLu7dLN/rsHyzXybjgUcqectbfVVMiPCc=;
 b=wdCsdyC0ouxW+RB9ToefMq02N/pRHjPf8iAy+P+y99570DG4YBXlrgyHT7yg9nCR8WNtzz6ir/xVte9D6YL1f3TPXnffhK30AKCpDBwG7h6mobM5SM3vpZv8Z/kWdWimEe3ly6J0QALhvLgQmtc5ULsYmGnqGrmJlsyd+ve9anY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DM6PR12MB4089.namprd12.prod.outlook.com (2603:10b6:5:213::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Tue, 27 May
 2025 07:42:17 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 07:42:17 +0000
Message-ID: <2e7df939-e50d-45e7-97d1-f90396db98b6@amd.com>
Date: Tue, 27 May 2025 17:42:10 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 07/10] RAMBlock: Make guest_memfd require coordinate
 discard
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gupta Pankaj <pankaj.gupta@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250520102856.132417-1-chenyi.qiang@intel.com>
 <20250520102856.132417-8-chenyi.qiang@intel.com>
 <7af3f5c9-7385-432f-aad6-7c25db2fafe2@redhat.com>
 <cf9a8d77-c80f-459f-8a4b-d8b015418b98@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <cf9a8d77-c80f-459f-8a4b-d8b015418b98@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DM6PR12MB4089:EE_
X-MS-Office365-Filtering-Correlation-Id: db9131b0-ac40-44b2-61e0-08dd9cf200e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emNNRHVQTElDc29uLzJnTHREMEFDZi9KazRqQ3hEQnhLWldoT2NpMndPY0hD?=
 =?utf-8?B?M3lwM3ZSdjBhei9ncnQ3SmZKUk1tM01LaWNBb1g5SlkxZzZHUUR6Q0doS2hj?=
 =?utf-8?B?SlFRK3Y0RUsyMk1oaGNZV29JQ3R5VytBdWdreVBmaXJWelI1QTJTQkFxVHVp?=
 =?utf-8?B?SFdWKzVIdnBIQUUrc0g4a3hWcFdjeXhRMlFjRlMxQ09VT3dMeUZ3T3hKbjlN?=
 =?utf-8?B?US9qOUR6aitlUzN4OWhHeEYzYlJDR3hGTzR4UkhpaEFFMUNqS3dYVnNSWWdk?=
 =?utf-8?B?TTZBUmt3L1VFbUdwT3FoMzZ3OHprMXVDeFB2SWtIa3hGTXgvVGdnNnorYStP?=
 =?utf-8?B?dlljQWJIa2MrL2YrOXljSng5a2M0S3pyelVWWW9RajZIMFBieWM4N2Y3MC9T?=
 =?utf-8?B?MDROeE53YWdmWUlGRWF6b2ttb3ZaVXZieEFlY0pOWTdkdVdIU0NYM2FyUzZ0?=
 =?utf-8?B?MDdJcHBYR1RFTVUycFArbFJseVhWS3A2L1BCT3VIM2QwWTlySTZ1TTU1end3?=
 =?utf-8?B?MVN5c3BNdkhCSGhTbURrVjNER0doQXk3QkpxellTNGpqSVdlczRZNXB6NzRR?=
 =?utf-8?B?bVJheXRCbGM0a0xJV0s0UGkxb0FQdW9uelEzNVJhR1Q5dU1WbXR3UENza1VO?=
 =?utf-8?B?dnVnY2pOYTZUQ1pTVDNYekRCSVNWWmxDSW5RTzFDeXRDa2xyYXlra1ZQczZm?=
 =?utf-8?B?TkYrTitxVmhoZVNUTDdqMjI5N1hIWVJjcCtIRGg2aDZBb3Y5THBaazl0czFt?=
 =?utf-8?B?T0pOUTFNY0NyeTJlemZEdVFjbDVjUVlTeDJHSnFqNTdQZkJObjhFRkhXZGVz?=
 =?utf-8?B?enprUXpHZHI3STVVK21oRTRLQnBOREhTcHdtYmpDK3ZjL3BNLzd4K1Z3d3RG?=
 =?utf-8?B?UkR2YytqYW1HM1IwUks4elE3NXZCZm1FRUtrUnl3eTNVY0hHV1FOTk5MM1JY?=
 =?utf-8?B?QmM0TTF0ZmlNeEVIT2N0cXI2LzJXSEZva0NNZVRyMFk1YTlVcmw2T3FsamNt?=
 =?utf-8?B?aGdVRW1BV1VOOUtCMTI0WkVPbDEvaVNkaEd3UWJCM3JFZjR3SEtnbVV6Slo5?=
 =?utf-8?B?ejhlbklDODZRYitYRFF6aDV3Q3g0UUN2MmpPTEtFZllWU21iVnJYbnZvMU9G?=
 =?utf-8?B?eCtHTnBqcmZrMzZ4YXYvT24zNklscHJMVngvUTBrVnRKaDBaWEphT3NxTUlS?=
 =?utf-8?B?UHdPQXprMi9UQjZlVE1ncWNLRytmTk91Njl3KzUwV3VaWjAzb2hPclpzN0ZP?=
 =?utf-8?B?REVkdGxMckV6cVRvRGQvNU83YnQ3NkxjY1BSZG0zVElmMkJ0NmNJOHlMMS9p?=
 =?utf-8?B?NE9FRGYxYmNCYVVaKzNmTis3Wk45S1lqWUJ4S3JzamQzbnZ3UHkzamhPQkZj?=
 =?utf-8?B?VHA0ZFpQT0RYTWlUTUR6Tlhlc1QwMTRVWVVUVE9vdVVYTjNTeTVWWDZxK3cy?=
 =?utf-8?B?aUppdWVhNmJmcEY3SHlaSVdmRWpFVG4vM0FUeS8vVFpBeUkwTlNkT1BXNThO?=
 =?utf-8?B?dnhVbW9jWVYrRTZPbnVPT3B2djdEYWErN1kxRUdkQ1grNDdRTEFxNEppYVlh?=
 =?utf-8?B?VXJWUm8ybTJTSmIyaGMzNWRVNjNmWDYxMGhYMnJmUmJMY3VLSW15UkNwcFNq?=
 =?utf-8?B?aExNVDk2dU4rSGk3ZW5YQXZkMW55K0IxRVZFNTJIU05kUS9mS1B0U1dhVnUr?=
 =?utf-8?B?OG5NMnNpVGp5WlR2WlNxZFpkcDBPUkExQzBCR1pod1ZacW5lNHlJWVp0V2FF?=
 =?utf-8?B?SmtsWUZyc0dCSkdiQ3lZMWw2VHgwMlNvejd0MGtna2J4WTdpY2c1Rk1CY29v?=
 =?utf-8?B?eXMrcEtnKzAyWEsvYVFybTJiQnp0TUp2MzZvNnRsd0ZhWHlLUmlodiszSWVr?=
 =?utf-8?B?cCsydzVtSVozbTFJc3lCamNoUkJ1VDRIaDFDamw1WGl2amNuQlRnZmNmSUs1?=
 =?utf-8?Q?OQwjgq258K4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2Q0N1lBbGpPZWlBRXd1SkhvMytKemIvYmdKZjdpdFd5ZXZCNDZObFJXVnI1?=
 =?utf-8?B?cUFiVzRyUndWcVVxL3RoNUttK0ZleGFjYWs5SHdYSzBiWlRZU3p6MFVScGMr?=
 =?utf-8?B?ekZ1YU1Za1BvaStZSUhucHJWdFByS2pIZG9vTXg5aXdBaUpGVzh1YURqaGsx?=
 =?utf-8?B?eXE2ZzZHTXl6RjdkYXd5Wm9FYkNUVnoyQnhrdk90NEJnRC96ZWNvYUI3M09Y?=
 =?utf-8?B?Z1hoV2NpTGduTmZjN2E1N2ppWnIrUThGRUVIUjRQSFpYSU02bXg1UzZDb1hY?=
 =?utf-8?B?NjA3WWZNVnlIUUFhaEhkZVNmMXZSS2gxOWlDUDR0aDcyaDVvQUgxSFhkdUFZ?=
 =?utf-8?B?WTRJWDZSOEJyTEcxRlBkNGdXUHNDemIzaERibW4vbVpjZmxSbXRqZ29qVHJG?=
 =?utf-8?B?T3B3TVpUQVF2NVBTSGJ3aFFtTTAvU2wzMHBkbzg5bDFzSHhHZGluc2FOdWZy?=
 =?utf-8?B?Wlh1V1R4My9UQmJseVdyY2o5U0F0cXVQeUlZOUYwemh5SzZUTC8yTFZyUG9r?=
 =?utf-8?B?Q3VNK2RuLzdJbUR6QVB6NWpHcFoxQXJzdnRVSUJZemVGY096ZkIrc0UwbWlT?=
 =?utf-8?B?K1VXS1JydzdkWGQvcFQwS25UN2s0bFNWdHZCNURCZmhqcW1EcWFlMGZMQ2NE?=
 =?utf-8?B?RXVWTkxCZ2MrNG43YSsxTk9UZkIzSEQxV1U5bGdtVDE1QnNtOU1PYXpuV0pU?=
 =?utf-8?B?WVkvSzVJYXppSUFtSzc3VHZ0bG5hTkNHa2RxUUhFelhKT1JjVnp6eit4d1VQ?=
 =?utf-8?B?S1hoRzJtWUhEL3JFYS9CNk12dHBJMVJIazhLUmNQaXgrTUVUR296ckVDL0Vm?=
 =?utf-8?B?eExtQVdobExBSXFpU2UzbEw3K09RS1BpRGQwbHFabFFQd3QrNHc4ZnROVXFh?=
 =?utf-8?B?MFBISUJBS2VKUWVFVjRwWEFiUzcwR3kvSTNMM2hiY1Z5NmhWVW9xcGcxUFV0?=
 =?utf-8?B?NDlSb1Rob2xabTErSXFOOFA3V3R3eWh2NWtXU2JmaGxzOENrcXBlT1VOdmN2?=
 =?utf-8?B?K2YzUVFRTFhMRHQ4cHVYb1JFV0dDS0hRcjdBZmNFd1NXdGtIdWd6NEEyblJh?=
 =?utf-8?B?cDcyOUZBdmNXcml3eDhYTXZBNXRXODlXRjI5a2N3Mm1nTHVXQjhsVlNkZWFq?=
 =?utf-8?B?K01VaWRacXIwSnZCZm93RGl5aDJOWkpRK2xEdUhuamtTVU1YLzZYZk1XOFdI?=
 =?utf-8?B?R0dRejBxeVZvdDVkaFYzdlpwOTNGaU44OW1nK3pGcDAvQSszT3dRd3dlb25m?=
 =?utf-8?B?bEFDR2NROHd1RHF3YjYwME9wN2liQzJwYThod2Y2dlR3SXp4NjU0S05sUDdh?=
 =?utf-8?B?RzFZb3JPV1h2MDQwZHJxQWs0VS9OTitrTDQ1MDF2Z1dSRHVnT2M0bk1RWmdw?=
 =?utf-8?B?VzRBd3BjbEtiRVJuaFQ3YVVqZkowcHQzbm1YTDJEWWR6b0ZzcUhkcEtZd0xH?=
 =?utf-8?B?dkRHNFhJeUxOZzRWZ2tJTHV1UFpCanVkY1Vhbm9EUHl5VTV1elduRXpxaVB6?=
 =?utf-8?B?eWxlcVRvTFBOVmhlL1AwWHRaWVlOSG1xMkhBTjVRbm1RQ1VaNjVndHhsZ1Jw?=
 =?utf-8?B?Y1VvTWIrbDVMclB5ZXJnMk4wd1cxY3VvL2hQaVV2eDJuY25hcDN5a2U0SkVp?=
 =?utf-8?B?U2FPME5DbWU3RGhweW5zZ3hwWUN6ckVGTEVud3RFcFM1UWhtdEpoV0V2MmFq?=
 =?utf-8?B?UTk0S0NwMG9ZN1g3SUVRcjJCZmVlTEJjZnZWZWNreGZKek1tdXAwVEhQMWZl?=
 =?utf-8?B?TmtFV2xFSGIwREtaTVp2eWlTYWhKK0hKWFJ1OEFITDZ0YW1LdC9zZ2pBM1BT?=
 =?utf-8?B?ZVFvSkF4Rk5wcGdPRGhLdlFIL1JXMnc5N1Q2ZTVHVDBuQ2E2Y3VOTFJqcU9N?=
 =?utf-8?B?NnlXMEY5bVdkc3RZVml5VjczOHhkc1pEdFhWcUVMUXVaOTBwMGFVTmpHQ1Vl?=
 =?utf-8?B?azcwSlR1VG1IVUdta05Yd3hsZkNmNjdPOTlRMjVYTmphYW5nVmszT0E1akRM?=
 =?utf-8?B?ZXF1bGV6cUR4Z1BZVDVEUFNuSVA1Rnc2Z0Z0Njh0R1Qxc2dreWFtR3ZJYzlI?=
 =?utf-8?B?L2hVV1VZZDc3bFdWODFmbGxzUVlXOUJLNmZxT0V0eGNwM2R6eVNIbDNWd2Y4?=
 =?utf-8?Q?4e30UoY3HeFE0NNgkmyuR9PqN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9131b0-ac40-44b2-61e0-08dd9cf200e2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 07:42:17.0097 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1+iJURyegyJuANncWuulGvlMx0BXfKNzMQJOiuqisg6P0fgfndrq2rvc//W8GD6rFE2xv/sXP44b7F69oIEPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4089
Received-SPF: permerror client-ip=2a01:111:f403:2412::601;
 envelope-from=Alexey.Kardashevskiy@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
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



On 27/5/25 15:47, Chenyi Qiang wrote:
> 
> 
> On 5/26/2025 5:08 PM, David Hildenbrand wrote:
>> On 20.05.25 12:28, Chenyi Qiang wrote:
>>> As guest_memfd is now managed by RamBlockAttribute with
>>> RamDiscardManager, only block uncoordinated discard.
>>>
>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>> ---
>>> Changes in v5:
>>>       - Revert to use RamDiscardManager.
>>>
>>> Changes in v4:
>>>       - Modify commit message (RamDiscardManager->PrivateSharedManager).
>>>
>>> Changes in v3:
>>>       - No change.
>>>
>>> Changes in v2:
>>>       - Change the ram_block_discard_require(false) to
>>>         ram_block_coordinated_discard_require(false).
>>> ---
>>>    system/physmem.c | 6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/system/physmem.c b/system/physmem.c
>>> index f05f7ff09a..58b7614660 100644
>>> --- a/system/physmem.c
>>> +++ b/system/physmem.c
>>> @@ -1916,7 +1916,7 @@ static void ram_block_add(RAMBlock *new_block,
>>> Error **errp)
>>>            }
>>>            assert(new_block->guest_memfd < 0);
>>>    -        ret = ram_block_discard_require(true);
>>> +        ret = ram_block_coordinated_discard_require(true);
>>>            if (ret < 0) {
>>>                error_setg_errno(errp, -ret,
>>>                                 "cannot set up private guest memory:
>>> discard currently blocked");
>>> @@ -1939,7 +1939,7 @@ static void ram_block_add(RAMBlock *new_block,
>>> Error **errp)
>>>                 * ever develops a need to check for errors.
>>>                 */
>>>                close(new_block->guest_memfd);
>>> -            ram_block_discard_require(false);
>>> +            ram_block_coordinated_discard_require(false);
>>>                qemu_mutex_unlock_ramlist();
>>>                goto out_free;
>>>            }
>>> @@ -2302,7 +2302,7 @@ static void reclaim_ramblock(RAMBlock *block)
>>>        if (block->guest_memfd >= 0) {
>>>            ram_block_attribute_destroy(block->ram_shared);
>>>            close(block->guest_memfd);
>>> -        ram_block_discard_require(false);
>>> +        ram_block_coordinated_discard_require(false);
>>>        }
>>>          g_free(block);
>>
>>
>> I think this patch should be squashed into the previous one, then the
>> story in that single patch is consistent.
> 
> I think this patch is a gate to allow device assignment with guest_memfd
> and want to make it separately. 

It is not good for bisecability - whatever problem 06/10 may have - git bisect will point to this one.
And it is confusing when within the same patchset lines are added and then removed.
And 06/10 (especially after removing LiveMigration checks) and 07/10 are too small and too related to separate. Thanks,

> Can we instead add some commit message
> in previous one? like:
> 
> "Using guest_memfd with vfio is still blocked via
> ram_block_discard_disable()/ram_block_discard_require()."
> 
>>
> 

-- 
Alexey


