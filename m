Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 459F69B3380
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Oct 2024 15:29:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QjR-0007Ja-G5; Mon, 28 Oct 2024 10:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t5QjO-0007Ij-QQ
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:28:30 -0400
Received: from mail-mw2nam10on2084.outbound.protection.outlook.com
 ([40.107.94.84] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1t5QjM-0003Z9-G3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TYYYckpx6Ox7396co+PujKA8wdWygpL+pKqKSuqgSLk/EfnhPXhj7ZQcBRFI3/3thywmjcReIsww4YR89gZ9Y2vtlWiXZNkoPFKauhqGBE0+eCxZt5Y34dBkWF7hoIOj57kQ6azYRum6IADaCZCLjB5JAagG+rIpqe6OyL2YEloicDbz07OHaC7oFeLr2oYNKIp80ydrUzGA9PGec3pHAc3MWwIqFEaSk/gfCcAxVCkJU+Qgy7gAe2lgAHsX2tvrq6Q1eATjOgHF1F2p/U08Vn+tDio8wrmuGMk0Txh3iGtUetUduPuXTKvuTayUKBxVOq0RBDD4CP3rMvAcgpKk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Wqpk+LXG6AraMXO31JnzVc6seAqY72TnJzlGJvy2OY=;
 b=m9KAwRJMrE0wUU/4Ms/wA6a3gzWbcfuwXa+XAiMU+vE1f2P2ES+fFuJOmG2gPICNeb0xy5CKtjUIfDkxHjMODyGj4dMDFOt40bAb7kYR8d1gjyt4gB/4NtjOYOBgKeizrhsZdJ78KfycdWEO7trgc93ZvVXKGwTn30s/JCeosgj1enRh2fsYvwbxo4r73m3EGjnz4PGQ7JR6QaNJ5byBAzTeGcnI8CvUALuqNeTA9O7j7RKPi6nfccqAzKwvk7AvMo75F8quslZviCVjMxBCO1tmqd1wjn58dPe7UZ8UD9NXwHVzIwmOfT0T5i9hWD8ElRmT9QZR2eOwlJ8MD9DTyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Wqpk+LXG6AraMXO31JnzVc6seAqY72TnJzlGJvy2OY=;
 b=w7S6MOEYF+Hj86W8S5Z8WfQTYdNU2gCy+VMGyz2VbxUMAKbLz8YSyvYyZTkpYb4D3/mWPdennso5wQO06Wh3ut9TvOtDceb1XvxrcLksJ8jAmL4GmMKitc1qGu+3ueW6qNtJjiiqiQEpWpuuUtI05VxxS6B8aHr6iXBqKt43zps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 14:28:15 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 14:28:15 +0000
Message-ID: <d53e3070-c925-48dc-bc89-8b8a1a66f476@amd.com>
Date: Mon, 28 Oct 2024 09:28:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] target/i386: Expose bits related to SRSO
 vulnerability
To: Zhao Liu <zhao1.liu@intel.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <cover.1729807947.git.babu.moger@amd.com>
 <dadbd70c38f4e165418d193918a3747bd715c5f4.1729807947.git.babu.moger@amd.com>
 <Zx9Rrtks38sqcn44@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Zx9Rrtks38sqcn44@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 64ed43df-7e51-40ea-6ce5-08dcf75cc2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVRCMkt6dkhKL3hndUxUZ01rOUVpZ2RORjZOR0NmWW9tZmlEVGI2dGppaEto?=
 =?utf-8?B?YUVEUFlRTTZZQkR2SnJRWG1qMkNOMWoxOW8rMGhrcCtFVnNJTExyQ0wxSEM1?=
 =?utf-8?B?RVFNcitzRVhQUzBHaTR4UXBtTU92ekpINTk4eVRyb1FqcWNiNTM5NnJSQUs0?=
 =?utf-8?B?L2loOUdINDNSZ3JHaVh5UklGcUZMcVlEMjZrbTdqc1JtUXdNYURFVE9hRHhW?=
 =?utf-8?B?VTJIems2TGkrd3AvSjZZTmVHN1RQZkg2TmNnRDJkOEpYOCtNWERQWEJNb1Rt?=
 =?utf-8?B?YXFKcHd4WTJYQi9GeGpMZmJXTGZzeG8yR1ZydjNzK2dPSGNEcGFPSUVwSzdx?=
 =?utf-8?B?OC90cXUwcTQ1cTNSUjFmUVg4cmpCTy9OQ3QyQzVwTmJFWEZrNUpEU2dnWWtI?=
 =?utf-8?B?aWM3S3Myc0FZdnU5dy9XMW52WTJmNVBuLzBnM25NdjlObWgzQkxDSENmVTFE?=
 =?utf-8?B?aFk5all6NzdZeHNPa3RWZDhPeUliWHFVRzBQZUNZcDlpbGV2OVhsSllDaE80?=
 =?utf-8?B?Z2JVSHpFc3NySnc2M0d5cVNUYS9Ea1JHUkQ5YUhZY0ExcllpOUNGUlprMUdr?=
 =?utf-8?B?cDR4UUVnR3V6SlM5aGo1RS9sWkVJc0ZyckU1QWZLay9aVk1mSm1XV2VMWEdh?=
 =?utf-8?B?NkV1WXAweGVYbFlXYmZDOWJhZUFRZGxYMkltNitNLzBkdytGNlZEdzJzUWVY?=
 =?utf-8?B?dVFQZThUMzJPSjY0Q3luOFNURTJVWFFScEc0aHY0UXQybDJhMnE2V09WWnRN?=
 =?utf-8?B?c2x2OEg3SHFhR2wwL25sZEREVTFIRDVjWnRqUkQ1Smw1UlBqS2lzdk5YTTJK?=
 =?utf-8?B?dDVIRTBsSExvSmRkbFdJOXZTdDlueFJTdUc5NFN6Z2tCZXVvZzgrQmNrQ0hW?=
 =?utf-8?B?Um05Yk1JRWJSY1lla2xXbXJ4SWh1ajRFTE5BV3Q3SXZjbmtMSW5kT1lJbWtG?=
 =?utf-8?B?aXd0MDEyV045T21EOG5IMExjd0wrWHB1bjhkc2NYVXVua0dFVXY0d2RWRXBy?=
 =?utf-8?B?YklidnFUT04zWVJTV040WWtWN2RkMldib1ovdEJ5Zzd1L1RaR0xTV3drRk9x?=
 =?utf-8?B?dDZrMlUrR0J5YlVBMkZZdHc5Vk1XWFdlL1FtbW00TmFZQW5lNHRUK3FHOVNu?=
 =?utf-8?B?V0JZWDc5eFBIU0dvc0JQZXlXQTlBQ2NVSXIvNDZiQmNmV2F3RWpZOFVBNXZB?=
 =?utf-8?B?VEpkY0VpMXdxakpYZVZwYkJKRThZNW9zY2VMUUtpNzVGbFY0aXE0bkErQXF6?=
 =?utf-8?B?SzhYaUFucUd3UVVDQTdTemdJbk8xeEJ0bVJzTWlYZ01SemwwM0JnZmtYSlpT?=
 =?utf-8?B?bmZnNmtiNEhEeTIrNnBIOEY3UTlJSW1sSXZVaVJBbHYvSVNRcE9OeWZpbWY4?=
 =?utf-8?B?Nm5SY0VITlZqYVhERDhubm4vOC91SjZzUXAzMFdOcjY0ckhHVkRCV2VxUGg2?=
 =?utf-8?B?eGVscDU5VnplQ3FkMVRyU0FKYXZtTzNRNVNwQzRHZzNXUVlyaEs2cFhqTkV5?=
 =?utf-8?B?d093YUpIbGNmaXgwbno5WHVhQkxScHVHYnNtRkFub3I3anFoOGV4UDNJQlJ4?=
 =?utf-8?B?bll4NkNZRVRxbFVCMFR6WWRYMUllRmhRdVFoWGFMdTF4czB5eGdzeEQ4SHE0?=
 =?utf-8?B?cnBkS05oMjl1K3MwTjRjUUt6T1hQUjZSeVhOZ3pkaVVSR05ib0ViRzhvOUFz?=
 =?utf-8?B?REpkNmIzUG51emFlYi9RcnNGMzcyZ3YxZTU4aHJFZ3pvUHJ0T3BEMXVjeWxT?=
 =?utf-8?Q?GIZHNpgfVwt/IZysoLjg4HTji94fw4p5LACcl2Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blgvei9uYjg1THkvSDNPa1luamxrZWkrQWZFQ3dpMytmeS9lMGFrbG4rcDBL?=
 =?utf-8?B?Z2ErQmZEblNtV0dWVUVUMUNEck1icnBsY28wcEJncTRpSWZSaTI5TlQyWVdF?=
 =?utf-8?B?bDZWNG9aaDdCOU9GdHBRaWUvZXRMUTNGSHBMdCtkeDQvNVlBMzdNR0NQV2Ra?=
 =?utf-8?B?bzE5QStJWWZnWlA4NG5penkySEVxSXc4Y1dnRktVOS9CamJ3RDg5cGtoOGc4?=
 =?utf-8?B?dTJqbnZPSVhFekR0OENCaWJqQW8yNGV6V1hmSzdCVHNWSFNVdnJoalhwNlBC?=
 =?utf-8?B?UXViWjdvcTVCbUF6MCtDUGo0TlZxLytuQWhUUm9vNXBSM1grZTkxSnNoTldt?=
 =?utf-8?B?WHlsLzlyb2dFbDFoUCswSU8yZ0RPMTdEYXFiT0d4aFNPOE1SK2hSMzlSU0lv?=
 =?utf-8?B?TWc1ZzNRRHNTZnRtRlBiUmpEY3Z4U09Ga3JmT3dSNEdSSkwrR0Y3TE82WjJQ?=
 =?utf-8?B?MTRhS1g4aGo1VVpTVTF4MDkrRGpUaVZWNFFrK2ZxelpZZ0hRMnl4dTAwRkY0?=
 =?utf-8?B?N3BrTVJ5blErZlY4V1FXZ01IMXUzK1A5ak91eC8xTjgxQXJsUnVYMnFndG9a?=
 =?utf-8?B?QTN5WjBmNFZWbE9vZGV2TUpoaG5SdzR6NnR4dTZheStrVWx5T1ViTWJhMHhH?=
 =?utf-8?B?Tlp1SUV3YTRkWVMzRFdvbmJqNExpQWQ1NUViNzFsdmUvd1pDbW9WSm0rRCtY?=
 =?utf-8?B?RmJwbXJnV0YxK0tWMkRoV1NTNWtHS0l2SEUzeW51bEdqY2NSWUtteitCL3ho?=
 =?utf-8?B?aGJ5TVl2ZDZ2ODFTSUN0Q2pYZUp2a0hONElSWEcveE5wY1hqVGVtL2lOZ29G?=
 =?utf-8?B?VG0vdlQ3N3VlSVdoZ2ROejVwR0RUWlhjbjVlNUFEWGtQSXNxdTBjU0lmcDNS?=
 =?utf-8?B?MVZmMGlvQU8rcG51aGViQy9pK2UwckpDRjZ4MXhXQnkzZFBsZ0Q5emR1dlJk?=
 =?utf-8?B?c0tVTC9rai9XeUZ5eVhlcDhTY1lNelp0VFp6OGx0MXh0VDd4VEZsN3k5MzZW?=
 =?utf-8?B?OTM2Ry8zUmdCMnI4Z0Y3ZlE5K2hNd2cwdStsV1IxaG45SVJvVVJ5cDhhMFRG?=
 =?utf-8?B?c2lWN0czSkJFSk15cG5vTDdPVUplc1dTTW5pQThRMTMxTFBZSjB5MmJYWXNN?=
 =?utf-8?B?dWRWMXdnR2RRbWdNbVdPdndRbzhrWGd0UkdkZlFvTS9sbHVBaFBuQzBXaWhG?=
 =?utf-8?B?cmUvck8rT04xU0RzSk92emZHR0VuY0ZQZ0dobVkycDhpUys1RGlFY1gyYzVp?=
 =?utf-8?B?em45dHlSS2lmSXFEY3RJYnFTMk95N3MzMnd5eU5KU0NMeGpRaGg1WWRrZDNa?=
 =?utf-8?B?K2JSVXBpSzRDcncvU0xpd0JKMytVU3I2cllNZW5PT25NVWhvSmlaVEdKMnI3?=
 =?utf-8?B?bGoyWStBUHlNM2xGQlFXYWlNQUQwd3crWjFZQXdCaDB4SEkvVTJDcWJKYU15?=
 =?utf-8?B?aGZ5SlRzWGZ3MlFEbFMwL3hUbEVmOFhPcEZtZ201d0VXVDdtNTV2WHYvcFp6?=
 =?utf-8?B?VTZSNzNvL3F0Qmw1UXBGbnZKMk8rTno3TlhSMXN2WERDU0luRSs3QzkvMXdC?=
 =?utf-8?B?R3RjRlc4QVMvZ2dXRkl0M0dibi9GSlVhZE03c0crQmRFR1RUcFBGQnVKcWNr?=
 =?utf-8?B?bkszUUhIdk5iMk1wVnhUTndLTDJ5UmJibEdUVE01bVl3VmM5Zy9uK2hxcEFm?=
 =?utf-8?B?M0NEaVY3MisxQU94YWVIQWxnZkYxODFQcm1RZlV1enFRdExjbkNjZnd4RmdX?=
 =?utf-8?B?T1BwZDM1U2pLTFR4TkFaSkdQNWVkUURhZEY0b3BvK1RtWnFMS2ZjVG05MnVZ?=
 =?utf-8?B?N2NVY1BQUmwxaXo1bFBXRmpnVm5sWFNRUUtScVR2Z0QxRy8vb05TTUdsVm92?=
 =?utf-8?B?ZnZES1hqMHFzL0ZIelp6SW52R1plbE5Gb2pwdk9JTS9TbzdNY2tmcUxPWFUr?=
 =?utf-8?B?cXB0Tml5VTFaQnN3L09Mc3diNGF5MjZWeFlUVXNvcDFtdU9CY2ErQ3pJRnF5?=
 =?utf-8?B?QlI3eXByNS9YSUVDc2pzT01laEFQTGVQeUJPM0RlZFlNUUJ0OTVDeG9hMWcv?=
 =?utf-8?B?QnJER1UyRlBKcjlibCtyczFHR1FJZDJheC9mRW5VdTJSSXY3SGtNY0tKT0N0?=
 =?utf-8?Q?7N+8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ed43df-7e51-40ea-6ce5-08dcf75cc2ba
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 14:28:15.7376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4rabag7d2gvViCzRBzn/vamRlOl0pVWLyUZAPE8ewM3A/pB6HzeZEP8hxWknpISe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
Received-SPF: permerror client-ip=40.107.94.84;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhao,

Thanks for the review.

On 10/28/24 03:56, Zhao Liu wrote:
> Hi Babu
> 
> On Thu, Oct 24, 2024 at 05:18:23PM -0500, Babu Moger wrote:
>> Date: Thu, 24 Oct 2024 17:18:23 -0500
>> From: Babu Moger <babu.moger@amd.com>
>> Subject: [PATCH v3 5/7] target/i386: Expose bits related to SRSO
>>  vulnerability
>> X-Mailer: git-send-email 2.34.1
>>
>> Add following bits related Speculative Return Stack Overflow (SRSO).
>> Guests can make use of these bits if supported.
>>
>> These bits are reported via CPUID Fn8000_0021_EAX.
>> ===================================================================
>> Bit Feature Description
>> ===================================================================
>> 27  SBPB                Indicates support for the Selective Branch Predictor Barrier.
>> 28  IBPB_BRTYPE         MSR_PRED_CMD[IBPB] flushes all branch type predictions.
>> 29  SRSO_NO             Not vulnerable to SRSO.
>> 30  SRSO_USER_KERNEL_NO Not vulnerable to SRSO at the user-kernel boundary.
>> ===================================================================
>>
>> Link: https://www.amd.com/content/dam/amd/en/documents/corporate/cr/speculative-return-stack-overflow-whitepaper.pdf
>> Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57238.zip
> 
> I suggest updating the description of SRSO-related mitigations in the
> "Important CPU features for AMD x86 hosts" section of docs/system/
> cpu-models-x86.rst.inc.
> 
> If you could also synchronize the CPU model (you added in this series)
> in the "Preferred CPU models for AMD x86 hosts" section, that would be
> even better. :-)

Sure. Will look into both of these.

> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v3: New patch
>> ---
>>  target/i386/cpu.c |  2 +-
>>  target/i386/cpu.h | 14 +++++++++++---
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index 690efd4085..642e71b636 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -1221,7 +1221,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, NULL, NULL,
>>              NULL, NULL, NULL, "sbpb",
>> -            "ibpb-brtype", NULL, NULL, NULL,
>> +            "ibpb-brtype", "srso-no", "srso-user-kernel-no", NULL,
>>          },
>>          .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
>>          .tcg_features = 0,
>> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
>> index e0dea1ba54..792518b62d 100644
>> --- a/target/i386/cpu.h
>> +++ b/target/i386/cpu.h
>> @@ -1015,13 +1015,21 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>>  #define CPUID_8000_0008_EBX_AMD_PSFD    (1U << 28)
>>  
>>  /* Processor ignores nested data breakpoints */
>> -#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP    (1U << 0)
>> +#define CPUID_8000_0021_EAX_NO_NESTED_DATA_BP            (1U << 0)
>>  /* LFENCE is always serializing */
>>  #define CPUID_8000_0021_EAX_LFENCE_ALWAYS_SERIALIZING    (1U << 2)
>>  /* Null Selector Clears Base */
>> -#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE    (1U << 6)
>> +#define CPUID_8000_0021_EAX_NULL_SEL_CLR_BASE            (1U << 6)
>>  /* Automatic IBRS */
>> -#define CPUID_8000_0021_EAX_AUTO_IBRS   (1U << 8)
>> +#define CPUID_8000_0021_EAX_AUTO_IBRS                    (1U << 8)
>> +/* Selective Branch Predictor Barrier */
>> +#define CPUID_8000_0021_EAX_SBPB                         (1U << 27)
>> +/* IBPB includes branch type prediction flushing */
>> +#define CPUID_8000_0021_EAX_IBPB_BRTYPE                  (1U << 28)
>> +/* Not vulnerable to Speculative Return Stack Overflow */
>> +#define CPUID_8000_0021_EAX_SRSO_NO                      (1U << 29)
>> +/* Not vulnerable to SRSO at the user-kernel boundary */
>> +#define CPUID_8000_0021_EAX_SRSO_USER_KERNEL_NO          (1U << 30)
> 
> These feature bits defination could be added in patch 7 because only
> patch 7 uses these macros.

Sure. Looks like Paolo already pulled this in. I will take care of this if
there is another revision.


> BTW, which platform supports CPUID_8000_0021_EAX_SRSO_NO? I found that
> even the Turin model added in patch 7 does not support this feature.

SRSO_NO is not supported in Turin. I added it for completion as it is in
the same CPUID fn.

> 
> Thanks,
> Zhao
> 
>>  /* Performance Monitoring Version 2 */
>>  #define CPUID_8000_0022_EAX_PERFMON_V2  (1U << 0)
>> -- 
>> 2.34.1
>>
>>
> 

-- 
Thanks
Babu Moger

