Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B171FA2FE6B
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Feb 2025 00:29:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thdBz-0007VK-63; Mon, 10 Feb 2025 18:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1thdBv-0007V4-IC
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 18:27:51 -0500
Received: from mail-dm6nam12on20619.outbound.protection.outlook.com
 ([2a01:111:f403:2417::619]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Thomas.Lendacky@amd.com>)
 id 1thdBq-0007mR-1X
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 18:27:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kj5BAm/1imDzn9a7z8USmTIkhUpIp+7p4tnKnzhTFx4QAU1ZEZTmn/RLNUBCJpMhF6+KwOgqeWAj7EaL6vENJUo5WtKu/knqFT+XrjUAH9lk25DS0EwdDmT4RQmDts2HA0PghigkW5xzd1T2ZP2zuOs/Wo10w9y2HQhpg1ogGE1o9GzgUjafTwfypkOiigq+DMY3hvZ/BZ62r8gD9ufBU0QYWCst4p9aWAPLm4X1agMomDmpweRGzuB14SrOSVcm5CRSk0RpbuGDUfrOrAifLzgiC9hMSbluLDlTiyl19XBL63dSFztpRUqTd50aD59EpPiY9qFojePy0wJpMUL83w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmCHE9iMxyx61j5Z/20OlZFn6ykttZzhrmTDEZdFeSE=;
 b=CriOzMEIePhuoJutcwE/QLNvXQ+D1ghXvzQrBHifEmBE74VGgbywhn9OqJlNiLf5yywFEpEutjyXzZGr5UYab0Mcr0JNVR9qmUpjI9lulbbQmhxQz3hfHJQGcYmgO9zYHn1Oxbf2amVjPzDKGnF2y1DhjNBcE8LTL5vow0QSah/xmpiN7rcN0bhxG+ifoam/ePHlSoSsC5yVO8TqYlbN9svKfzld9AhAeh24PN1JafyuVyInR+R26Sy1SDPO4EOV5VDNu/fVm/k6fybtFW1bkQrCwVib+uxTRYdOuVxM4no2b96gY4pZPFzfB8oHAIYR0gY3jrBJNP/W8ranDgNBwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmCHE9iMxyx61j5Z/20OlZFn6ykttZzhrmTDEZdFeSE=;
 b=vfYWSf0moyFpPVYpQmIw04zV2vEF1jtZZcnRJt6ZWoXhGoUkbUCkvk/BjcEppaG9e91PjifAADjMupZqhvpsqa2dwBTCHoA99CibPRegEuPlwaSr83x3U0nP7o0TTQ6C9B+xpmt2HlqTN7BPpLjJ8v4QHVtvZhMHY9k6JK9t20c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 23:27:39 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 23:27:38 +0000
Message-ID: <3022c822-5ad0-66c5-d56b-a6fc1d57d651@amd.com>
Date: Mon, 10 Feb 2025 17:27:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC] target/i386: sev: Add cmdline option to enable the Allowed
 SEV Features feature
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Kim Phillips <kim.phillips@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Cc: Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
 "Nikunj A . Dadhania" <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
References: <20250207233327.130770-1-kim.phillips@amd.com>
 <9d1643f8-f9f7-137d-8105-e9c06e2c8b72@amd.com>
In-Reply-To: <9d1643f8-f9f7-137d-8105-e9c06e2c8b72@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:806:d3::15) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7e8ced-4a27-4c56-a54e-08dd4a2a81f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFVMTTMyWmRQd3Y4allXaEpocTVOMDJ0S1R4RVN5RVJ0OTJSTFpSYkFtM2RY?=
 =?utf-8?B?WU5LVlByQkR6RkFoWHRFVTVteUFwbVNrYnBnY3BudTRsWnplbUtvVkNDWEZ2?=
 =?utf-8?B?RUU4dWE0aXpKMDBUZzNuSzIyUTlORFZ4ZW96aERSVE5zQXp1WGdwNlpCR0g3?=
 =?utf-8?B?MlNFMTRoQVJTNm9JRVRoS3hXT2tPT2pwZEJEcW0yVFd2Mit1bkIvdWxSREpx?=
 =?utf-8?B?aHF2TXR3dnFPd2xLSzJoUkNEUmxwWUFpTTNiNjRHNVN2T2xlU2R5SndTbnJH?=
 =?utf-8?B?VFFCQjFjWGQyYVU4SElXQ1JEVVN6eVNoRFhlbW5vVzZtV0x5K0NhN244bkdR?=
 =?utf-8?B?bDI3NGwycDgyRG1FL1Rmd1ZQclFrUXQyOFRZOFpjL2FlNi9iY1dpdXpFODAz?=
 =?utf-8?B?WGNMWG4rdlFidDdweVgyQ0VIRGtxc211Wi9PczNtcGdHRmhXY21rMzVJRjNB?=
 =?utf-8?B?NERXM0drWW05cjRTK0hDU09iNmx4L2dCUjQ0V2xWRjlQV0NqZ0xUUkdSVEpa?=
 =?utf-8?B?MnhObUZoUjNOS3FXTmtKV0paSWVSNE9nSE5EL1J6QmhhU3YwZ2VmeitzZHR4?=
 =?utf-8?B?bXUzY1RvVmVRQTRJNzVndXUwWnJnbnVDdW9lemRVMjg0ZGYzazUzaEYvNGhi?=
 =?utf-8?B?bVdzcllBamJJZGYzdkxQQVJaTmY2em9sUitRMy9qelRxTlVIM3Y5WElna2ZO?=
 =?utf-8?B?VG1YZm5yM25UYndGRDYzOUNJVWVEUHdNajRLVFF2by9tcGJTRkNJcmdncW9m?=
 =?utf-8?B?Y0crUkV6Z25TaVdVZXV0S2g2NUtrdGdhbkpZNzB6Q3ZEOHpEMCt0Vy8zR0ky?=
 =?utf-8?B?ZTNVTU9iWDhRcEZWUzFpVEJGS29mWkZkaWw2SzI5OFNUMVJVemFBQ1VUVmNn?=
 =?utf-8?B?cElDb0duTWV3VnBOdFBOMkY1ODZ6VGo1UW8yRStITlk3ZHI4L3pMVGhTTEdV?=
 =?utf-8?B?WGxCSTc1RXZScTBNdUVjUkxZQVhRYmpQMTVSaWQ1dDNQeDdjaWRxWm1vMXNC?=
 =?utf-8?B?TUk3aSs4L085UHVUUHhMeC9YSlI5SmV2NXpOZy9ScE03akJUWTNqMitHK1lW?=
 =?utf-8?B?a3NOYS85QTN6R2duZnRpeWZBbWhvaWErU0RCbnhkWUhIYkx0RFYwK0lET2Fl?=
 =?utf-8?B?blVWeXpIT3hRNkhPVjByUGRRN3lsaUJLOWt3VUNzVTRkNmlMaGNpN2dmbDZC?=
 =?utf-8?B?a2Y5d1BBaXRiaWhPU3lSU3pvM09ZQjExckN3VEdMeUVsaVU2RjV0SkhkaHR2?=
 =?utf-8?B?dkpnSTBFNVZxT2FrTU5PV1ZtY1VRdHN4UnpSRi9OM25VV3k0QzJHTFUrWGZP?=
 =?utf-8?B?TU9EdzNaUmxFSnFMRTdYdnF6ZWkzRnFCemlkNTFCQnhDS2J6OFplbS9Ia2l2?=
 =?utf-8?B?aWNycWpXTkdWTG5YcXhIQkNQY2xrTVlBS1JnY21HeTdPWkJUallqczMwdUYx?=
 =?utf-8?B?OFBzMndVRzdHN3RzYTdPYndsaGgvSzZJUk5iSVZ1MC91STl0akZ4ZmJ4WjFK?=
 =?utf-8?B?RnRVOUUwMG14NllmQ3RNcG1qRGVNTjF3YndFd3pZaVIvNUs2L1A3OE82MGt1?=
 =?utf-8?B?N3NIRmlZeS8wZjRkWWpNWEhkcXA0ZEJnWWZWQy9XV0xyZTE3QUxTcUsvT3ZG?=
 =?utf-8?B?UmZ5SWk1VzZZTERZSXlZMWQ4cENmdUNGc05KRTl6NS9YWDNGMlFKSENUbHFW?=
 =?utf-8?B?eXhwZTEydEJ6ZjB5UDJsUFQvNVZQQW1DVkJMaWtUZXduTGRDZGdKakdNWFFS?=
 =?utf-8?B?bWo5NWcrL2IvY0t6VnVnUmRzVm9OcGtZYTg4cXVEdjZ3U1BqangyVDJ0b2t1?=
 =?utf-8?B?bi92T1JNTFBwUGRtU1Z5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5070.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWJGQndrbXZNZDZ2cmoyanRmKzlVVEM0dUFTaTNlaXlURTFIL0JBRTFmTENM?=
 =?utf-8?B?NVdmNXgwRWkyMFplbDhZUEZuSXNrRDhab2lNRDZDTDBUdlRpQ2dOZkZmTlBI?=
 =?utf-8?B?elZxSWdTSWo4eUswRTU3QUNCS3VaQWltK3lIOFRXNVNSQlpEVmkvbHF3d1FL?=
 =?utf-8?B?TEptdS9qQ0twakxJbGRkdHQwaVBRQ1MvZjMrL3pJZXZWK2ZHa2lCUjU2aEth?=
 =?utf-8?B?RGorbjNiZW1rMGdvZXpSTE1WL2gycHdVNEt5M2o5TjVYMkd1N0dtdDJvSkFE?=
 =?utf-8?B?dHFtVXdkK0xrMDh0NE4xYXlLY1hmODBoSjdwNVpJMzBaUUVyTmM2NWVXcnNK?=
 =?utf-8?B?MlVhQlFUYnUvSm95LzUzNmJtM2JFQmloTjNnSzgyWkI4c0tPM0ZjcGN0YnVY?=
 =?utf-8?B?MG5qUlFOVlBiT0hHUFlRa2xTODdmeHFIU1JOUnVETmUvWFVZQnVJK0JHaisw?=
 =?utf-8?B?S3hOMU96VnNrUnUxVXVXeTEwQmI3ZUV2UEVVQ0djMHhFYjkwL2t6N0ZoNUN1?=
 =?utf-8?B?UWV0OVBJNWNWamI4cVc2MTVLUll4cEx6MjB0WE9ZdUM1U2JJOUNwMVZ1Vkxw?=
 =?utf-8?B?QVVqaHN1MGhPdWZJRlhXWjYxR1F5WDZzS1Uzd3R6elFRSkJjVVZUUUtZUHVm?=
 =?utf-8?B?ZEFxYmE5dC9OUURGU1p1akxNdG9DaUpQTWlaTHFMZE5NaFFkL2xnckM1TVQ3?=
 =?utf-8?B?T0N0ZzVpZUdYTnFrRG9QQ1p3SFNLQ2paNkdsZXVMMjFXMlRDMklvYVk4UzZt?=
 =?utf-8?B?bmFiMEJMWFNCL3BpbUgyR0ZSOGsrNktGcWhBVE1aa1pUbk1jZitZQVVGa1Q0?=
 =?utf-8?B?THd3YVhxSGlUbDZTR2tNR2wxSStQOXlYSkdSL3hBd29yNm5BM1lJdDZKaFky?=
 =?utf-8?B?Ritzb2sxdGpxaTEvN0F2bE1TVVhQakV6MUV2aG1TcHhJNHBWYVBub3VhbnhH?=
 =?utf-8?B?Z0wwZUc4U3NHclVTQU1DeGpCUEdSK3ppN2hYSEZKdE9BL0VYYXlFbjcrTXB5?=
 =?utf-8?B?cnhJRjlydFhXeEVTenV0bEFRQ21Pb2xrMzF1akhEcnVpd1k5QWVNVFNwNGFM?=
 =?utf-8?B?REVoRmxSKzhXY1hVWHNWalFJNUtvdWdsTGMyUFRSMThuTXprNENBYkdDY0lK?=
 =?utf-8?B?UXJwaG15YkNvYWdLUXc2VzluMmdXMStSRkZCYURlK2pMaytIaXdWV052Z2RP?=
 =?utf-8?B?bmR3MnlCWE94YmVacml1dkxqbnBBSzI4eXE4N0trL0JySDdkNnNqU1FvTXRF?=
 =?utf-8?B?Ymh3TmVRV09na1poWGFBdHFkV2xPenM4QmUySnRVdlV0Z240K3lURmp5MXBi?=
 =?utf-8?B?aFNpVDBmeHhrUGtLNDNQVFVzQlVOUXd6VVhIQStyditIU1lRdVhpc04zNmFL?=
 =?utf-8?B?aTVSUHNMZEpHTWcrMmNZcFBPMElqaDkzdERCdlVYTzJFTGtWWEdVOVhhZWh2?=
 =?utf-8?B?WC9tVlNURFliN1RHYWFpVGU5Q3AwUW5aaTVBVG5kdjhMd3ZTckdFYlc2V2FI?=
 =?utf-8?B?dHVnbGxLUXlHOHdubmhoVFNkYlhlUUJXSW5YUG4vU3Vudm95cU94QlFwazJk?=
 =?utf-8?B?eVhEUGJnaGpVUGhaVUcyRXc4TWkvQUJ2WVVvTXRnSkJUb2paTUxsOFdIa01D?=
 =?utf-8?B?Y0FTa3RFM2xVK1g2RXNiUzRoUk9NVUFmL3RQdWlyUGhlWUNvQmJYeHBHR3hZ?=
 =?utf-8?B?V2FJVmpFOGMxaW9VWGhQdmhSZXhpYVRNenVpNE1iVkxjWXZOQWU3dlVVMHZB?=
 =?utf-8?B?SFR3NXhCdkc1RjI4YzJOSlY2RHhwN1VYSHAwaVp2V0kxemticktGUHFkbWNE?=
 =?utf-8?B?NEcvUVFlWVYvdldIcmdEMGJkOHoxbGhjNEd0UVJ4SFJIaWk3eUJaZFpzdWg2?=
 =?utf-8?B?WjZZMGE5cU5aejQ0Mm5Vc0RVUVJCTlVMREZTOVhsMnJKamEzSFNFYjAwK0hK?=
 =?utf-8?B?YUczY2xYT3BxQTRHNVhBcy9ESWNCSGNNek43MmZaRW1Qc1FhVjNQUWMzOGc0?=
 =?utf-8?B?VzBCbi9rUVVTUnl0YVUvY0NaUkxOZFFRRUFLZ2Vjbm8vVStERmxuVnpSK0dG?=
 =?utf-8?B?Z2tubzBHYjFFOWRvbkd4M3NEZWpoV054TFN4YjU4ZmNwMTVmUzdzYnJVb29B?=
 =?utf-8?Q?Er7lVvafMPlEDPkgY+ivxNpMv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7e8ced-4a27-4c56-a54e-08dd4a2a81f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 23:27:38.8423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g3Xr8t+Dp6TWg0ieyUePRK6JJnDzyvUHpzrfoY2bFLvCOvwM/PIkrVL9IQr6Zt1YCWxtaDGnQBSwCeh5JO+FLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
Received-SPF: permerror client-ip=2a01:111:f403:2417::619;
 envelope-from=Thomas.Lendacky@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.023, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/10/25 12:53, Tom Lendacky wrote:
> On 2/7/25 17:33, Kim Phillips wrote:
>> The Allowed SEV Features feature allows the host kernel to control
>> which SEV features it does not want the guest to enable [1].
>>
>> This has to be explicitly opted-in by the user because it has the
>> ability to break existing VMs if it were set automatically.
>>
>> Currently, both the PmcVirtualization and SecureAvic features
>> require the Allowed SEV Features feature to be set.
>>
>> Based on a similar patch written for Secure TSC [2].
>>
>> [1] Section 15.36.20 "Allowed SEV Features", AMD64 Architecture
>>     Programmer's Manual, Pub. 24593 Rev. 3.42 - March 2024:
>>     https://bugzilla.kernel.org/attachment.cgi?id=306250
>>
>> [2] https://github.com/qemu/qemu/commit/4b2288dc6025ba32519ee8d202ca72d565cbbab7
>>
>> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
>> ---
>>  qapi/qom.json     |  6 ++++-
>>  target/i386/sev.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
>>  target/i386/sev.h |  2 ++
>>  3 files changed, 67 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/qom.json b/qapi/qom.json
>> index 28ce24cd8d..113b44ad74 100644
>> --- a/qapi/qom.json
>> +++ b/qapi/qom.json
>> @@ -948,13 +948,17 @@
>>  #     designated guest firmware page for measured boot with -kernel
>>  #     (default: false) (since 6.2)
>>  #
>> +# @allowed-sev-features: true if secure allowed-sev-features feature
>> +#     is to be enabled in an SEV-ES or SNP guest. (default: false)
>> +#
>>  # Since: 9.1
>>  ##
>>  { 'struct': 'SevCommonProperties',
>>    'data': { '*sev-device': 'str',
>>              '*cbitpos': 'uint32',
>>              'reduced-phys-bits': 'uint32',
>> -            '*kernel-hashes': 'bool' } }
>> +            '*kernel-hashes': 'bool',
>> +            '*allowed-sev-features': 'bool' } }
>>  
>>  ##
>>  # @SevGuestProperties:
>> diff --git a/target/i386/sev.c b/target/i386/sev.c
>> index 0e1dbb6959..85ad73f9a0 100644
>> --- a/target/i386/sev.c
>> +++ b/target/i386/sev.c
>> @@ -98,6 +98,7 @@ struct SevCommonState {
>>      uint32_t cbitpos;
>>      uint32_t reduced_phys_bits;
>>      bool kernel_hashes;
>> +    uint64_t vmsa_features;
>>  
>>      /* runtime state */
>>      uint8_t api_major;
>> @@ -411,6 +412,33 @@ sev_get_reduced_phys_bits(void)
>>      return sev_common ? sev_common->reduced_phys_bits : 0;
>>  }
>>  
>> +static __u64
>> +sev_supported_vmsa_features(void)
> 
> s/sev_/sev_get_/ ?
> 
>> +{
>> +    uint64_t supported_vmsa_features = 0;
>> +    struct kvm_device_attr attr = {
>> +        .group = KVM_X86_GRP_SEV,
>> +        .attr = KVM_X86_SEV_VMSA_FEATURES,
>> +        .addr = (unsigned long) &supported_vmsa_features
>> +    };
>> +
>> +    bool sys_attr = kvm_check_extension(kvm_state, KVM_CAP_SYS_ATTRIBUTES);
>> +    if (!sys_attr) {
>> +        return 0;
>> +    }
>> +
>> +    int rc = kvm_ioctl(kvm_state, KVM_GET_DEVICE_ATTR, &attr);
>> +    if (rc < 0) {
>> +        if (rc != -ENXIO) {
>> +            warn_report("KVM_GET_DEVICE_ATTR(0, KVM_X86_SEV_VMSA_FEATURES) "
>> +                        "error: %d", rc);
>> +        }
>> +        return 0;
>> +    }
>> +
>> +    return supported_vmsa_features;
>> +}
>> +
>>  static SevInfo *sev_get_info(void)
>>  {
>>      SevInfo *info;
>> @@ -1524,6 +1552,20 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>>      case KVM_X86_SNP_VM: {
>>          struct kvm_sev_init args = { 0 };
>>  
>> +        if (sev_es_enabled()) {
> 
> Shouldn't this be
> 
> if (sev_es_enabled() && (sev_common->vmsa_features & SEV_VMSA_ALLOWED_SEV_FEATURES)) {

Actually, I guess it doesn't matter. The vmsa_features field will be 0
by default and only be set if "allowed-sev-features=on" is specified. So
doing this will just error out a bit earlier than KVM erroring out on
the INIT2 call if some vmsa_feature bit is set that KVM doesn't know about.

Thanks,
Tom

> 
>> +            __u64 vmsa_features, supported_vmsa_features;
> 
> s/__u64/uint64_t/ ?
> 
>> +
>> +            supported_vmsa_features = sev_supported_vmsa_features();
>> +            vmsa_features = sev_common->vmsa_features;
>> +            if ((vmsa_features & supported_vmsa_features) != vmsa_features) {
>> +                error_setg(errp, "%s: requested sev feature mask (0x%llx) "
>> +                           "contains bits not supported by the host kernel "
>> +                           " (0x%llx)", __func__, vmsa_features,
>> +                           supported_vmsa_features);
>> +            return -1;
>> +            }
> 
> Add a blank line
> 
>> +            args.vmsa_features = vmsa_features;
>> +        }
> 
> Add a blank line
> 
> Thanks,
> Tom
> 
>>          ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
>>          break;
>>      }
>> @@ -2044,6 +2086,19 @@ static void sev_common_set_kernel_hashes(Object *obj, bool value, Error **errp)
>>      SEV_COMMON(obj)->kernel_hashes = value;
>>  }
>>  
>> +static bool
>> +sev_snp_guest_get_allowed_sev_features(Object *obj, Error **errp)
>> +{
>> +    return SEV_COMMON(obj)->vmsa_features & SEV_VMSA_ALLOWED_SEV_FEATURES;
>> +}
>> +
>> +static void
>> +sev_snp_guest_set_allowed_sev_features(Object *obj, bool value, Error **errp)
>> +{
>> +    if (value)
>> +        SEV_COMMON(obj)->vmsa_features |= SEV_VMSA_ALLOWED_SEV_FEATURES;
>> +}
>> +
>>  static void
>>  sev_common_class_init(ObjectClass *oc, void *data)
>>  {
>> @@ -2061,6 +2116,11 @@ sev_common_class_init(ObjectClass *oc, void *data)
>>                                     sev_common_set_kernel_hashes);
>>      object_class_property_set_description(oc, "kernel-hashes",
>>              "add kernel hashes to guest firmware for measured Linux boot");
>> +    object_class_property_add_bool(oc, "allowed-sev-features",
>> +                                   sev_snp_guest_get_allowed_sev_features,
>> +                                   sev_snp_guest_set_allowed_sev_features);
>> +    object_class_property_set_description(oc, "allowed-sev-features",
>> +            "Enable the Allowed SEV Features feature");
>>  }
>>  
>>  static void
>> diff --git a/target/i386/sev.h b/target/i386/sev.h
>> index 373669eaac..07447c4b01 100644
>> --- a/target/i386/sev.h
>> +++ b/target/i386/sev.h
>> @@ -44,6 +44,8 @@ bool sev_snp_enabled(void);
>>  #define SEV_SNP_POLICY_SMT      0x10000
>>  #define SEV_SNP_POLICY_DBG      0x80000
>>  
>> +#define SEV_VMSA_ALLOWED_SEV_FEATURES BIT_ULL(63)
>> +
>>  typedef struct SevKernelLoaderContext {
>>      char *setup_data;
>>      size_t setup_size;

