Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A85AC4818
	for <lists+qemu-devel@lfdr.de>; Tue, 27 May 2025 08:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJnSd-0001Ts-0N; Tue, 27 May 2025 02:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1uJnSa-0001Th-Pa
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:06:49 -0400
Received: from mail-bn8nam11on2060e.outbound.protection.outlook.com
 ([2a01:111:f403:2414::60e]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Alexey.Kardashevskiy@amd.com>)
 id 1uJnSX-0003EL-T7
 for qemu-devel@nongnu.org; Tue, 27 May 2025 02:06:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr+uLRfc7hvdbv0iXfuZhilDZGqCUCPaf+3Nlo6vYVfTyFrNz0XQMkBwicRnj6sbJgMlKZ1n9sD5TmwdB/b2aFnUXLxfTtP43+y67/+FOHLSqa+po4uxkl4uzXI9xY9GVKMG47/oDEpaePWaQrvzbSRh21PxdPpBU3IczIInl9XcjFAkWKxc/io0HZFHlhDk9bcgAjjSlWZK6Yzwq85oum9JEwXIWrTqSZ8PshOD9ksJvn4sn0twyRP0zHf1ZOyM1d5jDtwO8GNBXcjYDTzTlr7jtY3sSpDIRjg74/HfcR5lI7Oi5pXvdPPKuXbRfVPnoGj5gQWJKMe7u96xziq0MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ETPgu24nDoELdR0IuB4V9oHYKC5wh8OPdYUeusToqk=;
 b=y928cjFsc+83Jgr4LQbgOHxDTKuxrd7GY3NS5ZuE5BIkWwMsYOwj7xW+YwmPCCZwbR/9y026As+R5mUvyGdj+GW9/xnHiRw3EfkfBj5EyyLht2XW6A9h4NLuuJhwcSRDPzKCNNOrBho34/l53tMFURdbbUSXL2nm/AAhAfdw/dpMy3yw0mKm/jUpC/NEH1ag9IyRHt6lNtFrVzZFvuzCIvThzHP+k9g3qh5atNjcJQHZklDnQSfvsXn41oJbO5bZWPZT8a1SlJYv9BzO5CColerNIZaIP0YkHwfPzDJFTfQ6NIMDoT8P8c5G1i23PtK6+YZX08prML+NTD9XYjRNCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ETPgu24nDoELdR0IuB4V9oHYKC5wh8OPdYUeusToqk=;
 b=gEnhs5QLC/0jawrncg18ows8fNq7rlYFb4//4FHgFGtfz6gSzTAci/H8hhrj4w79TE+fN1ivVLLxa3/sS0CdLefS7G7lPLDKvLEp3QUZei3bmLhJ3drZOP8yWVHgltYJakieSWmq6ffVlebHmmltRDg8UluV5clsZ31yiGcQ+CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 27 May
 2025 06:06:40 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8769.022; Tue, 27 May 2025
 06:06:39 +0000
Message-ID: <047a0649-4a8c-4f08-a5c8-4168f975d5a3@amd.com>
Date: Tue, 27 May 2025 16:06:31 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v5 04/10] ram-block-attribute: Introduce RamBlockAttribute
 to manage RAMBlock with guest_memfd
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
 <20250520102856.132417-5-chenyi.qiang@intel.com>
 <e2e5c4ef-6647-49b2-a044-0634abd6a74e@redhat.com>
 <0bc65b4f-f28c-4198-8693-1810c9d11c9b@intel.com>
 <f28a7a55-be6e-409f-bc06-b9a9b4b3a878@amd.com>
 <6ebda777-f106-48fd-ac84-b8050a4b269f@intel.com>
 <173fd9e8-65f7-479e-b7ef-a8b9cca088e8@amd.com>
 <cc727bbc-fe37-4be5-9949-3f62d8734215@intel.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <cc727bbc-fe37-4be5-9949-3f62d8734215@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY6PR01CA0120.ausprd01.prod.outlook.com
 (2603:10c6:10:1b8::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: 440501df-a348-404d-f468-08dd9ce4a4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVc0K2FWeUpueU1ycjJRRzJqbWpkVHRUOXRBRWcvcUdpSTNhbktaQWQrRmU1?=
 =?utf-8?B?RmZ4SlAwRDl3d2NJalhwRndiK2Z0eklSTVZBN0hpVDdTRTFrQStRSXlHVDlI?=
 =?utf-8?B?RDFCTkUzQytEVmk3TmxDUDBhVG11aVNOaXZYY2laZVBIaUl6OUczUm9nUmZz?=
 =?utf-8?B?cnBYdDFMWEVWWC9JTnlTeDYyNWZweGgyQTdwVDVINVhYUlpMNHZndUxlcExq?=
 =?utf-8?B?djJtM2pJRDNDSmtMc1ZvNXNqVDdKcmR6ZUdTUC9rV0NQVUd0OVJMbWtOaVha?=
 =?utf-8?B?Nkg3U2ptTStBT1FHRE91N3JxZHd1Y2FuZVBzcHVsZERhMU9iQ0dnZjJub255?=
 =?utf-8?B?N0FKeWh4MWp3NStkL2VQZXlpSVNQTXBSd0VCTEQ2cExMT1NsaEVWeDdYbEhH?=
 =?utf-8?B?UDlvN3FONWxPNEFWWUxPdDExcFhQb1hMSzRZNG9yZHk1TmlxNS9Zek9NUXpT?=
 =?utf-8?B?OEp0ZzZZUzVaRUxtekt3QzlrMFZCMTRqZEtlZEVUYXd4Qm5TNE5wNWIrOGxT?=
 =?utf-8?B?QU1BZmpFb0U0dFhMYWtBWmRvL0o3cVN4VHIvUGdDYlRQV2J3cHl5VmVodHNW?=
 =?utf-8?B?SWMvUTd6VFRZVndROVpjUllCdGRRbURoTENJODJUZW1PU1JjbnFvdk9zODdE?=
 =?utf-8?B?d1pQU0pYakdtRjN4ZW1HYmpwbWVKTy9FWmxxcEpReGl5eDFaSUFFVFd0V0xi?=
 =?utf-8?B?SitpRHNWWFVkRWhIbU85eFJCSWw0WXJJbDh0WnJHWXFYZVhGMEIrcWdhc0FI?=
 =?utf-8?B?WlpFZVd2SkJHSnExUmRaSXBTVnd3RmZqWEprZDJsRVJBS0pFNTM0aHAzNWts?=
 =?utf-8?B?bWE4bXNLQnRrbE9GQ3pvWk92ZjRLczdhSVAreXZZOWpVZGEwdFZXcGFkeFRi?=
 =?utf-8?B?Qko5bWpPN2R3MG4xcng2bFA3bFN6RUQzU1FNcUUyZ0c4Y3o5N1E4dG1jbEJ2?=
 =?utf-8?B?T0kxSEJ2dVh4MnYxSlVtMlNuUnQ2VFVXTEtxNlpoSWhtejM2U2dIUnc5Ung2?=
 =?utf-8?B?U3U5SDlhM28xVHphdWlOWTNEVUhhL3VJNjl6RU5Kam9XczB4QmpVSFdJN2ti?=
 =?utf-8?B?czNjZlphVzFnOTAyRm9jdnV6MFAwUFJyajB2Y1RHMFlkcStxT3ZjYWd2MXJp?=
 =?utf-8?B?VGp3RmhzN2ZlOFZlMDdDQzd4cENpM2hQaWU0R1JYNk0zaG1pMHExSEVKL0Jv?=
 =?utf-8?B?UEhmUmlTWFZTRHlnZDdaYVJDSFlUUTMzencwWnNnQWpoYVpPRnJtakhiL0py?=
 =?utf-8?B?K1grMFk0c1QydnVsNHNobTlUVDRWVWhEUExYNFhpUkpMbERzNTJ4SlBsS2Q0?=
 =?utf-8?B?WmVMRDlEZVJadGw0RHBWOUtVd1YvU0svZ3Awc2U3N2ljQjQ0TVF1TlRLYVhh?=
 =?utf-8?B?a3EyS0RhdFBIdE1UUXBWckdFMytvSDZqc2hnbmZIcnlRa1E4ellrMXo2SXJB?=
 =?utf-8?B?Ui9GZU91UDdmUUJDVHdveVpoVWtReWxseENXQU1TZjVCL1YxVnlrcnoybGRy?=
 =?utf-8?B?aVJqMU1SZHJoZmlxeFI2TmhjSzJYdEg5RllJclkwWFVNN2pwcFRYcTlxWVVr?=
 =?utf-8?B?a1pVWEdXQzhub2Y5MjE3R01ZeDhGWTYvZlFqVitDaUROaEgvSTR5OXFVT1Nx?=
 =?utf-8?B?ZHV2M2JvRUp6VWwwalFtVkVqV1NpdjdEb0J1NmJEYW5sdzVLRzdkbUFhVDVl?=
 =?utf-8?B?d29XSjArTUQ4V1ZnMFRGU0xXNTdKaDFUNE1NNUt3d0lvU093NWhIK2lrRkxR?=
 =?utf-8?B?cjRXaUl5U1l1bTZCVzJMQk1WejIzUXVqS2lleEF3TDA0ZEIydUQwSjZScmt4?=
 =?utf-8?B?emZidWt2OHZtYS83Uks1M1l3NHdsK2dCcTcyck5PYW5MQmV4cnJtUVFyN0l6?=
 =?utf-8?B?empYZmM2cnJ3ZThSVEFLN2lGcXppL0pFMitMWm56eW9SMERZeHpzNU42U0N2?=
 =?utf-8?Q?tXYagr70WKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB9194.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJCUnhmK3lGUWVFR1R3STZRTytFR25vSlNJbjFkcHB1TytBWjVwQ0c0b0d6?=
 =?utf-8?B?cjN1RkpMZ0t0WGNUSUNFSTJ6SE1ia0pwK1duWHhRZmwvL1NOVFpmbmxEdlNF?=
 =?utf-8?B?SG1Ra2R4MGR0ME12QmFYa0pmYjk2dUlINzhWQUlNOC90akFHdWFleVBSTlp5?=
 =?utf-8?B?b1hBb2o4akZrd2krY05wUTVINUhXSG9IdEFSNXNqZVNlcmJLK2wvMS8yNS9M?=
 =?utf-8?B?SDIxQldYcmpkSDdMbzNxZEtlZkRpVkNGUG1SSmR2U2xuWlY5OHk2RitLZGxD?=
 =?utf-8?B?OFU2dmtHWEFwTjBqRUQwdk5JT0RrRjNtcWNRYUxzM2xRVnlsQjVBUVJhMVFr?=
 =?utf-8?B?SHpTZnR1M0RZSGRPSDBwU2RyRWxHamJRd014YU9SWEg2Z3E1RmRRZ0dYVEdI?=
 =?utf-8?B?bjNWcHNoaStOZEtVdVd1MWIzY0lGdmVvU0w4dGJsVzlTL01qMVM5bVRZNU9z?=
 =?utf-8?B?SHNHL1ZEN2VoLzRSWDVsZWp4UDhHeFdjbk40dkgrbkdzeGNTMjYvRWN1dDQr?=
 =?utf-8?B?WFF3MmdYcWZVdEFkbzZueFpkL2dBWlJLYndtUWl4K0prc3pPa0QzRFdWSlpi?=
 =?utf-8?B?Y3BxYytpdFp4bUNISktHWFNjMXNHLzdXR0oyanZVaUs0emNQMUFRZWRtcmtE?=
 =?utf-8?B?NDJJN1U1elNGV0wwS0RJcnRPZWM3WmpXQjk2RnIxUmxFSHhjMkpGUWRjcE1Z?=
 =?utf-8?B?TENGR29WelNVSVNzeTVmOS80eEpYZnZSQzlVVHovR2JCUVA2WW5uaUxQYlJH?=
 =?utf-8?B?TFpMQ3BucDJsOFh6UE9rRnFoaFVOVGI3MU51c1BIRUtTOXFVMEU2R09zZEw1?=
 =?utf-8?B?SjlHNEM0b1Z0RU5KWTVwYkE0K0VLN0I4SkF2NEpLWTJrWUEreXNKMFBwRHIr?=
 =?utf-8?B?RU8xbnpJMXVubDNJcVdKN2xRV2ZjNTkxUWpSd0tFeWFjMVJtZDBjM1NOZ2g1?=
 =?utf-8?B?NGc4VWY4aDAxd0lrOHNLczd1UlMrQXRsVEs3Wk1uWUQ5MDVBeEVQczBIclQ1?=
 =?utf-8?B?d21IbjRESWhDRjVBWVdVa3gwWGpwS0ZLakYrbXNtbXQxNVlGOGxIbkc2REwx?=
 =?utf-8?B?dWdyOEFFV2hobW5xck9pQ1R4eGVNRVd3SWZvTG1XSzFMUms3Z1NVR0ZEQXVP?=
 =?utf-8?B?YjFWTENsS2lFM2VxbWZKczVMdGhFY0hEbDR5UytrRlc1UDFFU0Rxb0JvdDJ1?=
 =?utf-8?B?cXorSTdwY1RaL0sxYkNrV1ZuUmVZMndXL0xoQzh1Rk90bGVGL2Mzc2l5Mm4z?=
 =?utf-8?B?VWlCNjhzT1FqN3AxQnVIOGZROURJa3diZWZBOStWYyswUmplbXNPSTZnNktL?=
 =?utf-8?B?WmpPc1BKVEl2ODhuTDIzZlJUb3ROLzNrWng2dnhRSWZ2SFNJaGFCaTNRV1gv?=
 =?utf-8?B?d1ZhVWY4Skd2SlVHTWM2bXpTOC8zcVNIZlMrVDhZdy9uQ0JvVldlbmUrMkNW?=
 =?utf-8?B?ZlNoNjM3cVlSZFpMeEFCNTFKbU1YOWsvV0FzdFFuU3cra0RUU2hkSDhIRUpu?=
 =?utf-8?B?VGlPTlFRNjRzWCt5dkIrN2lacFIxdisvRFc2YzR5WS8rQkpaKzBTQ0xoMDNK?=
 =?utf-8?B?dFJVRml2ZWswYU02SDFrVUNsR2kvZnltcmNXeWpaTkNUNER1WHdPSlVmT3d2?=
 =?utf-8?B?bkJSR0RsQ0Y0anY2NXFiVUo4R1YxOFZYVVJyMlVqOGJnNGxLbWxJQWNhaWtj?=
 =?utf-8?B?YVBZZjM3Qk81ck14bUdYQm5XdnU0UVdTY21pK1BFTldwTjYrMmh6MzNSMHhC?=
 =?utf-8?B?eHhzT3ZEd1lHekVMRDhhVk13MXBWcW1YZmtZdlB0M2RQNDMwVDcxZERVdXN1?=
 =?utf-8?B?R1FXSFhNckZtSE1xRzZLSFlwUll1d2I4dm5MWm9ETkhYeGJEY2E2WHhZUnNF?=
 =?utf-8?B?ejV2K1c0bFk4aVpVcnI2UmxUc3RreVprZm90RFRqR2Ewb09nTitic3I3bWVq?=
 =?utf-8?B?clNGMHVtRVpWOGtIamVnSEJObGVqYU1xa1pBb3V5U1didWU3bWNrN0FCQ0N6?=
 =?utf-8?B?OUExTG1pbEFrQ1d5Vm5oQkdzak53NkZIUzAvakJGUWc2cGF2TFIvdVBaazFK?=
 =?utf-8?B?RUV1aXJHaWZNS2J3RE9pL3JJL1FENHExVCsrQlJPdHBBd1FrTlhqZjh5OE1M?=
 =?utf-8?Q?7wMZiIcuo1am6WeoYeLYeWuUS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440501df-a348-404d-f468-08dd9ce4a4d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2025 06:06:39.2542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/usXt07WvruSTx6GvWbqG2yE1GtTYs54m7Lkinwr0tXh6HjK5LAEZ8aKtu2DepodEzLmb46roFK/DyIS9xZOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
Received-SPF: permerror client-ip=2a01:111:f403:2414::60e;
 envelope-from=Alexey.Kardashevskiy@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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



On 27/5/25 13:14, Chenyi Qiang wrote:
> 
> 
> On 5/27/2025 9:20 AM, Alexey Kardashevskiy wrote:
>>
>>
>> On 27/5/25 11:15, Chenyi Qiang wrote:
>>>
>>>
>>> On 5/26/2025 7:16 PM, Alexey Kardashevskiy wrote:
>>>>
>>>>
>>>> On 26/5/25 19:28, Chenyi Qiang wrote:
>>>>>
>>>>>
>>>>> On 5/26/2025 5:01 PM, David Hildenbrand wrote:
>>>>>> On 20.05.25 12:28, Chenyi Qiang wrote:
>>>>>>> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
>>>>>>> discard") highlighted that subsystems like VFIO may disable RAM block
>>>>>>> discard. However, guest_memfd relies on discard operations for page
>>>>>>> conversion between private and shared memory, potentially leading to
>>>>>>> stale IOMMU mapping issue when assigning hardware devices to
>>>>>>> confidential VMs via shared memory. To address this and allow shared
>>>>>>> device assignement, it is crucial to ensure VFIO system refresh its
>>>>>>> IOMMU mappings.
>>>>>>>
>>>>>>> RamDiscardManager is an existing interface (used by virtio-mem) to
>>>>>>> adjust VFIO mappings in relation to VM page assignment. Effectively
>>>>>>> page
>>>>>>> conversion is similar to hot-removing a page in one mode and
>>>>>>> adding it
>>>>>>> back in the other. Therefore, similar actions are required for page
>>>>>>> conversion events. Introduce the RamDiscardManager to guest_memfd to
>>>>>>> facilitate this process.
>>>>>>>
>>>>>>> Since guest_memfd is not an object, it cannot directly implement the
>>>>>>> RamDiscardManager interface. Implementing it in HostMemoryBackend is
>>>>>>> not appropriate because guest_memfd is per RAMBlock, and some
>>>>>>> RAMBlocks
>>>>>>> have a memory backend while others do not. Notably, virtual BIOS
>>>>>>> RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
>>>>>>> backend.
>>>>>>>
>>>>>>> To manage RAMBlocks with guest_memfd, define a new object named
>>>>>>> RamBlockAttribute to implement the RamDiscardManager interface. This
>>>>>>> object can store the guest_memfd information such as bitmap for
>>>>>>> shared
>>>>>>> memory, and handles page conversion notification. In the context of
>>>>>>> RamDiscardManager, shared state is analogous to populated and private
>>>>>>> state is treated as discard. The memory state is tracked at the host
>>>>>>> page size granularity, as minimum memory conversion size can be one
>>>>>>> page
>>>>>>> per request. Additionally, VFIO expects the DMA mapping for a
>>>>>>> specific
>>>>>>> iova to be mapped and unmapped with the same granularity.
>>>>>>> Confidential
>>>>>>> VMs may perform partial conversions, such as conversions on small
>>>>>>> regions within larger regions. To prevent such invalid cases and
>>>>>>> until
>>>>>>> cut_mapping operation support is available, all operations are
>>>>>>> performed
>>>>>>> with 4K granularity.
>>>>>>>
>>>>>>> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
>>>>>>> ---
>>>>>>> Changes in v5:
>>>>>>>         - Revert to use RamDiscardManager interface instead of
>>>>>>> introducing
>>>>>>>           new hierarchy of class to manage private/shared state,
>>>>>>> and keep
>>>>>>>           using the new name of RamBlockAttribute compared with the
>>>>>>>           MemoryAttributeManager in v3.
>>>>>>>         - Use *simple* version of object_define and object_declare
>>>>>>> since the
>>>>>>>           state_change() function is changed as an exported function
>>>>>>> instead
>>>>>>>           of a virtual function in later patch.
>>>>>>>         - Move the introduction of RamBlockAttribute field to this
>>>>>>> patch and
>>>>>>>           rename it to ram_shared. (Alexey)
>>>>>>>         - call the exit() when register/unregister failed. (Zhao)
>>>>>>>         - Add the ram-block-attribute.c to Memory API related part in
>>>>>>>           MAINTAINERS.
>>>>>>>
>>>>>>> Changes in v4:
>>>>>>>         - Change the name from memory-attribute-manager to
>>>>>>>           ram-block-attribute.
>>>>>>>         - Implement the newly-introduced PrivateSharedManager
>>>>>>> instead of
>>>>>>>           RamDiscardManager and change related commit message.
>>>>>>>         - Define the new object in ramblock.h instead of adding a new
>>>>>>> file.
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>>         - Some rename (bitmap_size->shared_bitmap_size,
>>>>>>>           first_one/zero_bit->first_bit, etc.)
>>>>>>>         - Change shared_bitmap_size from uint32_t to unsigned
>>>>>>>         - Return mgr->mr->ram_block->page_size in get_block_size()
>>>>>>>         - Move set_ram_discard_manager() up to avoid a g_free() in
>>>>>>> failure
>>>>>>>           case.
>>>>>>>         - Add const for the memory_attribute_manager_get_block_size()
>>>>>>>         - Unify the ReplayRamPopulate and ReplayRamDiscard and related
>>>>>>>           callback.
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>>         - Rename the object name to MemoryAttributeManager
>>>>>>>         - Rename the bitmap to shared_bitmap to make it more clear.
>>>>>>>         - Remove block_size field and get it from a helper. In
>>>>>>> future, we
>>>>>>>           can get the page_size from RAMBlock if necessary.
>>>>>>>         - Remove the unncessary "struct" before GuestMemfdReplayData
>>>>>>>         - Remove the unncessary g_free() for the bitmap
>>>>>>>         - Add some error report when the callback failure for
>>>>>>>           populated/discarded section.
>>>>>>>         - Move the realize()/unrealize() definition to this patch.
>>>>>>> ---
>>>>>>>      MAINTAINERS                  |   1 +
>>>>>>>      include/system/ramblock.h    |  20 +++
>>>>>>>      system/meson.build           |   1 +
>>>>>>>      system/ram-block-attribute.c | 311 ++++++++++++++++++++++++++++++
>>>>>>> +++++
>>>>>>>      4 files changed, 333 insertions(+)
>>>>>>>      create mode 100644 system/ram-block-attribute.c
>>>>>>>
>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>> index 6dacd6d004..3b4947dc74 100644
>>>>>>> --- a/MAINTAINERS
>>>>>>> +++ b/MAINTAINERS
>>>>>>> @@ -3149,6 +3149,7 @@ F: system/memory.c
>>>>>>>      F: system/memory_mapping.c
>>>>>>>      F: system/physmem.c
>>>>>>>      F: system/memory-internal.h
>>>>>>> +F: system/ram-block-attribute.c
>>>>>>>      F: scripts/coccinelle/memory-region-housekeeping.cocci
>>>>>>>        Memory devices
>>>>>>> diff --git a/include/system/ramblock.h b/include/system/ramblock.h
>>>>>>> index d8a116ba99..09255e8495 100644
>>>>>>> --- a/include/system/ramblock.h
>>>>>>> +++ b/include/system/ramblock.h
>>>>>>> @@ -22,6 +22,10 @@
>>>>>>>      #include "exec/cpu-common.h"
>>>>>>>      #include "qemu/rcu.h"
>>>>>>>      #include "exec/ramlist.h"
>>>>>>> +#include "system/hostmem.h"
>>>>>>> +
>>>>>>> +#define TYPE_RAM_BLOCK_ATTRIBUTE "ram-block-attribute"
>>>>>>> +OBJECT_DECLARE_SIMPLE_TYPE(RamBlockAttribute, RAM_BLOCK_ATTRIBUTE)
>>>>>>>        struct RAMBlock {
>>>>>>>          struct rcu_head rcu;
>>>>>>> @@ -42,6 +46,8 @@ struct RAMBlock {
>>>>>>>          int fd;
>>>>>>>          uint64_t fd_offset;
>>>>>>>          int guest_memfd;
>>>>>>> +    /* 1-setting of the bitmap in ram_shared represents ram is
>>>>>>> shared */
>>>>>>
>>>>>> That comment looks misplaced, and the variable misnamed.
>>>>>>
>>>>>> The commet should go into RamBlockAttribute and the variable should
>>>>>> likely be named "attributes".
>>>>>>
>>>>>> Also, "ram_shared" is not used at all in this patch, it should be
>>>>>> moved
>>>>>> into the corresponding patch.
>>>>>
>>>>> I thought we only manage the private and shared attribute, so name
>>>>> it as
>>>>> ram_shared. And in the future if managing other attributes, then rename
>>>>> it to attributes. It seems I overcomplicated things.
>>>>
>>>>
>>>> We manage populated vs discarded. Right now populated==shared but the
>>>> very next thing I will try doing is flipping this to populated==private.
>>>> Thanks,
>>>
>>> Can you elaborate your case why need to do the flip? populated and
>>> discarded are two states represented in the bitmap, is it workable to
>>> just call the related handler based on the bitmap?
>>
>>
>> Due to lack of inplace memory conversion in upstream linux, this is the
>> way to allow DMA for TDISP devices. So I'll need to make
>> populated==private opposite to the current populated==shared (+change
>> the kernel too, of course). Not sure I'm going to push real hard though,
>> depending on the inplace private/shared memory conversion work. Thanks,
> 
> Do you mean to operate only on private mapping? This is workable if you
> don't want to manipulate shared mapping. But if you want both,

But I do not want both at the moment as I only have a big knob to make all DMA trafic either private or shared but not both (well, I can have split the guest RAM in 2 halves by some bar address but that's it).

> for
> example, to_private conversion needs to discard shared mapping and
> populate private mapping in IOMMU, it may be possible to pass in a
> parameter to indicate the current operation, allowing the listener
> callback to decide how to proceed. Or other mechanisms to extend it.

True. Thanks,

> 
>>
>>
>>>
>>>>
>>>>>
>>>>>>
>>>>>>> +    RamBlockAttribute *ram_shared;
>>>>>>>          size_t page_size;
>>>>>>>          /* dirty bitmap used during migration */
>>>>>>>          unsigned long *bmap;
>>>>>>> @@ -91,4 +97,18 @@ struct RAMBlock {
>>>>>>>          ram_addr_t postcopy_length;
>>>>>>>      };
>>>>>>>      +struct RamBlockAttribute {
>>>>>>
>>>>>> Should this actually be "RamBlockAttributes" ?
>>>>>
>>>>> Yes. To match with variable name "attributes", it can be renamed as
>>>>> RamBlockAttributes.
>>>>>
>>>>>>
>>>>>>> +    Object parent;
>>>>>>> +
>>>>>>> +    MemoryRegion *mr;
>>>>>>
>>>>>>
>>>>>> Should we link to the parent RAMBlock instead, and lookup the MR from
>>>>>> there?
>>>>>
>>>>> Good suggestion! It can also help to reduce the long arrow operation in
>>>>> ram_block_attribute_get_block_size().
>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

-- 
Alexey


