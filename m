Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44179A46C83
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Feb 2025 21:35:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnO6H-0006q3-2k; Wed, 26 Feb 2025 15:33:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tnO6F-0006pP-66
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 15:33:47 -0500
Received: from mail-dm6nam04on2052.outbound.protection.outlook.com
 ([40.107.102.52] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1tnO6C-00089Z-K3
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 15:33:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYlyIcFOrqXZ83VIRfdXx2zeAJLu37y0FC53zaSmK1jvHOJ+mekJmK6hX7jtjjKcT9WQTDBYsuef0v94w0h+mwHNPgYHurbI8HuTgGVZLMNA680mVUGZGPIg9lAoyDHCBFY1tOP2h3LyD8FlAUILOwHsR2CeiRDryRN5Dsk33VvgQ+zKClKD4dr16eBnapPFeZtQihGm9gqNBpebp84NscFWX2hqpmWGOveZYYsEI3fINpAlHUnzdhz7E0BwhTy28SCHm+GJRai8B3Gb/DHbs3fTumGfyPUYXK+MiWxiO6lVSFdJKTxQyii2l3/1fbpYZvOG3gmA7bWAGdqU0hDPTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wv31dJeAjA2izbTtm8+aKL2CIW5G9uScph4lEXq+CrI=;
 b=wVfbJcWUfOYINZV9zmatNE4A1Nzdc1J4BL38mcWEEVgLu4T1oMfLNkjivFD5hFyOa5qokNOEiCBVbQ84DHy3s3OgIS2uivfGXvEStIbytUmvrYiCnI3xBzvHu+0dueEJFox1/i6Wawf1kLul2vRqSNE6zvxSYUuE0wtXfwg4EBV9tULUprQ43ZDmTilD7YiRdERQxOybE29uHnhorvYL1C76uA/RgtSdqKseFLNlI7kC9bcezqbpwIGUESpypo3Mep9Nop2gGru3xQpPBpaYUfiCSVI17qn/dAXlvNjbaBmjaegMSW9oLCO1wdbux/HxmcaxRcM792QLvxKIrxumRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wv31dJeAjA2izbTtm8+aKL2CIW5G9uScph4lEXq+CrI=;
 b=kniawHMRO4IGaILJ150YfEVr2qFfxQf1NPK6mv6vcAtOBc5QOHKdx3UAhFq79rDGdye1AEUSOo18OkF6eBgdE6t7M/sPMEUpuSO2gM6r9ws5Et6ALWMfKPSdusjzS4S10ZFfDD3wPZ/Ba1uGsPhLTrbfMmjA9tCCdW3LjKJXhco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH0PR12MB8824.namprd12.prod.outlook.com (2603:10b6:510:26f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Wed, 26 Feb
 2025 20:28:38 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8466.015; Wed, 26 Feb 2025
 20:28:38 +0000
Message-ID: <7822f511-6b64-417f-830f-3ef912e572d7@amd.com>
Date: Wed, 26 Feb 2025 14:28:35 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/6] target/i386: Update EPYC CPU model for Cache
 property, RAS, SVM feature bits
To: John Allen <john.allen@amd.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 davydov-max@yandex-team.ru, Joao Martins <joao.m.martins@oracle.com>
References: <cover.1738869208.git.babu.moger@amd.com>
 <c777bf763a636c8922164a174685b4f03864452f.1738869208.git.babu.moger@amd.com>
 <Z7cLFrIPmrUGuqp4@intel.com> <Z733dp+gePxwDsyW@AUSJOHALLEN.amd.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z733dp+gePxwDsyW@AUSJOHALLEN.amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0071.namprd05.prod.outlook.com
 (2603:10b6:803:41::48) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH0PR12MB8824:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e7d387c-3a30-4c48-fc73-08dd56a426b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dG5tSzRDMTNlSHp0UmFSNjJXSHZZMnArTWdVR21uWTBXNzRZbnVrR2F3TGZR?=
 =?utf-8?B?UzVSQklYcGFnYzBiaVl1TCtaMVBSanN2Um9lQTlhMFh4cTVOdmd6bjlEaDEw?=
 =?utf-8?B?MU10UTcvZ2JQQ0VyUERKa1EyZ3RNcVViUENlM1pHaEpMK3NxbXk3MWlLYnlL?=
 =?utf-8?B?L3dKamo0Zk1oWXlHdWRZTGJ2WHN0ckhhRk5RaVBCV3JVTGg4UTdWa2VndXJY?=
 =?utf-8?B?S3lvd3kvQm1mRzlHbm1EYkRiZ2l5M1VYZ040Zll1ZHIxaFIyVFdlSy9CaCsv?=
 =?utf-8?B?VTZLYzNZTXg1TzV0RThNQ2xUNkM2K291bjBQckNVWVZYbGVpU3Q1YXdYZFdI?=
 =?utf-8?B?dDZ0WDh5YkdxY2I2YnFSaXA5RzJyYkV6c29pQitGSXpPM1hwSk02MDhjUC9U?=
 =?utf-8?B?Wkp2TXZPZEhWYW9HSjVIbktVR1pGRGRvK1FhTkEzQjFsTmczd3kwTEsvT0pv?=
 =?utf-8?B?dEp2TXJXeUVpWkVYeGsza3NjM1dCTS9KV3VPR2dNc2d0c1B0UnVFK2dqWE92?=
 =?utf-8?B?T1BCZmhUVHAvU0dOTUdieVkvWU1pNlBOVG51Mm1pbzc5LzB5Qmd2a3BaZXdY?=
 =?utf-8?B?K3VBQzZzTU9Lbk81NnZid0xiWm5GVTh5cjBvMkM5R1RKcE5lY0RvaUlHSEZO?=
 =?utf-8?B?UDVtY3RGc3drb2d2c3dYVVlLMFBrRmEwdC81YmtvVEhUWEFwVmhENGVuTHRz?=
 =?utf-8?B?QkFadmQzb2lGYVhVbjJzRVJPRE9GbVk0K2YvV2ExQXp3K0pyQ3pkTDV6N3kr?=
 =?utf-8?B?RkhzU1lzaUh5Y3RqdFlON2V6akQ4RndPZ1hZSlJBc1NSMFZ6K2g2WGFDcm54?=
 =?utf-8?B?YzByTXZDaFVYSVJQRVNOL3dGc0VyYmlzekduM2o1ZEQzWXZGdEhkMElyY3hn?=
 =?utf-8?B?bXdTR2RNKzg1TmNqdnlLQjJPME5DS1kvK3czU2xlSnI1ajNhL3hLaHc0SlJZ?=
 =?utf-8?B?b0MrSUh4c3JSMnc0NXNIQldzaHFDWTlsdXVMNGlUaXNmQ1Q5MzVnYUFpcyth?=
 =?utf-8?B?dzRYWFVZK1NiNDZDTXZEVlNaUmdrdDZLNjgxMlZMaW10QlU4b2Q5elJuWE53?=
 =?utf-8?B?bWxpUzE1YU9YTm0reTEyK0dsd0hvM3Y3dEFuNVlCbEVIZGcxYjRkcUZYWVV5?=
 =?utf-8?B?Wnc0cFh2RlpJajVkUXZJY1IwVEk0TlJyclRsbWxBaWdaVmxqcHhpZ0tUZDJa?=
 =?utf-8?B?dzRGUzZxdHBjc3VtUUVOWnB5SFgwQ2xRK2lxeTZFYnVnVHJBcUNIdnlkY0V3?=
 =?utf-8?B?eFRnZmUvdkR2UVZxUGZkR3p2SlNDK0NMN0JlbEh2RWE5aHIvaithdGp5WDRR?=
 =?utf-8?B?T2JTaFBNQWJpMDFqVGY1TTRlMUVweXMwd2tTRVdMK2t2OWlldGhTL2pCbEN6?=
 =?utf-8?B?a0hodW14WStxTUlBNUEvT3E4Sk1kRmNpa3BvNXljbGI2cFgwYlNraFpVTTFP?=
 =?utf-8?B?Z0U3aThMZUJNNFJZZkhaMzhucWE2VURFd0pZaWh6TXBuaTRUTFV2eW1ZeFRu?=
 =?utf-8?B?TUkyVGgwdzlXTU9Cb2N5Qm80OGo1K3BoQ0Jkc2l6d3dCeTJBWVMzaHNjd1V4?=
 =?utf-8?B?S3RDYStwcU03M0Qvakh5NThhaWdseXkyako0aTEyRURwUFI5ZS8yeGZyRFd2?=
 =?utf-8?B?QXZ5aUNNTlNoMWpBUDdaUmRENzM1Q1E4aHJUUGlxdUhvSUVZUHRFbHo3OWFN?=
 =?utf-8?B?T2I3Y1lSY0Z2YUpRbkhQN2l6U1dMT04vRWt6Wm16SUlGTU5tWnMwRUlqa01E?=
 =?utf-8?B?T3NIS1VnK1pMbGptenBmNWczekpLeE5BeHNNY0tpVWNUVGV6a21EOEp5eE5o?=
 =?utf-8?B?TGNuVDdZNnhFdExhRElWN05EWFRLOTlhRWtWSmFqbnBDb0szTmlWRXBHQU9G?=
 =?utf-8?Q?gb0DAzEUwOrp/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTU3Y3luTlN2MTZqYkhzVE1VbFV6ZUpteXJDWW9pZ1l5ZG9BSS9GT1NiRTU3?=
 =?utf-8?B?TWpDdzU5Q3hRYlVhUnhvSlNXNEVMKys2Q042TmltekE1UlIxRUJtTzJ1ZVFu?=
 =?utf-8?B?eVV4NFR2Ukl3VitrSmNJT3BtN2U3MFZ1aVRkVHVGcUtxazZUTG4xOFZ5cG5B?=
 =?utf-8?B?cWlpQSswaDlwdnA4akJvME9nTXNsdXlSZlJhT2NCVnFhSjRLN0NNb1poemtJ?=
 =?utf-8?B?L2hJMzA1ellKdlFlZm9jakxnV1Z4RHhZY2lRdnUzOHFEVW1jcHNPWk52bzZE?=
 =?utf-8?B?TmkwRklWQTBBRlhKaUpuaXhWcUFBNTQ2dkpST2N0em1DNDgwNGJzV0N5TGtE?=
 =?utf-8?B?UnVHdUhvU0w1TUw1QWdkZmFESTNiaWZydm1aVHhGT3hYSmxEM0ZWNGxWcUZq?=
 =?utf-8?B?SXRCMm9hd0hCekhWcy9xbThEUW1welpVdEpCSkdHUWJDb1pUaVNkMmFwaWNI?=
 =?utf-8?B?a3BTRWc3WkZGNnZrOUVlMmRXV3V5bFlhQnZpeHlCSkRtS2ZUSEJ4SHBMdmRr?=
 =?utf-8?B?U1FRZ2I3SjRlU2ZmZjNxUXB6RWdhdFZrUnhZL05mdFVlUFI3SDR1bmdWRXNp?=
 =?utf-8?B?TU5kMGlnMVdKVFZMUnlSdDlGU2p1ZEo0QmluR1ZnOEdqd3JWcjdUc01vNnVi?=
 =?utf-8?B?QmRGcUpBTytmYXA4VHFTK2FUcXJXSFgxbGRob3A0QVUydFlNaFJkekZCdnRu?=
 =?utf-8?B?SnFxbGVDbk4wQmkwQVJHcENXV1hTWGxaVVRpZld3N1BXOGFRbS9xNFRXZ2tm?=
 =?utf-8?B?WVA5UEZlNHllUzFWU216L1JOOTJqSldYRFVCKzFZUXNMMXEvMGQ3RE1PRGgz?=
 =?utf-8?B?VHpwNllONkxqWldXQzVEWTRDcFRCY1lSSjlnTDZ3eGdCL080Qk51Mm54OGsy?=
 =?utf-8?B?QTVnNlRXaFpkZHVaaThNYi8xM3p2ZGllTlVDRENwazNNY2lqRGF6ZEYrZmwv?=
 =?utf-8?B?d1JWS3JlaDY3dk8zMzNVWDFiend5MU5rRWR3SGEwTEwyR1JhTTBwZ084bEgr?=
 =?utf-8?B?RjJRdmJ5WStWeGtaUGVUbVZUcVZiZm53YUh4cW9PeWNGQmVjTENrbmRacUFo?=
 =?utf-8?B?Q1RYcWNBVFdkUUgrSEt0VGo3M1c0THdONUczN1JtT2RlM05vOXl4M2tBNGJK?=
 =?utf-8?B?Y1FVMldSbTBydUdHQ0x3NEtqdTlQUEwwRElHNG5qT3pIOVoyYlhIa0ZsMWds?=
 =?utf-8?B?RzlTMGk1RXp2a0FWc1JGZEtQZWV5WDFpdTRmZ2VmdXdiNzJHNjhBWlEwd3BM?=
 =?utf-8?B?TjRKbWN2WDNqNkV6eXV1akpPaERHYjFDSlBnUS9qVUN5ekF3SGVIVFRJMG9i?=
 =?utf-8?B?bWZVa3B4WTdrWlFhNnpETGVUUGRFVGpFUExyUzZ1cTBYNXhnOHMyUGNhT0Jy?=
 =?utf-8?B?VjJRYy9DVGp4YVNWa0I1RTgxZzFjcU1yQzFNSy9nREpQUXh5c2laWjBkSW5z?=
 =?utf-8?B?M0grSnNmSFQ0VTl4cXllcUNLejlaRE5EV0h2NUx3aGpId3EzTDJGUUV4ZE1H?=
 =?utf-8?B?TDg5WjZMUExRcU5IVGM0cTVzVjJnUTdmdGs1Tmo2RlRsNm5IZ3ErTFkvVTEv?=
 =?utf-8?B?bEJCSHkxUmtXay9CNkNJMVF0cC93SkdmVUhGdHY3OW1mcEEvcEc2cE40T0Ft?=
 =?utf-8?B?Ti93OFAyWDRPdURLNlcxRTZtdHFJbXAyMURjVnJzRDQvcWpVay9jelZZYWRX?=
 =?utf-8?B?Z0h2UW5LZ0RLbWpMcGdFK2duY2JkQXl1ZUYrQjMwbUtib3JoU2QwUDIwREZ4?=
 =?utf-8?B?STZhRWJqeDNlRHBDVW0yekUrM2tJNkxQRG56NTUrRmVzREMzWlY5aXI4dGVE?=
 =?utf-8?B?OHVHWUd4eGYvRDdPQldlYlRvVEtPcnArZ0lJN09NejBWTnc1a3F5VW9Bc3lw?=
 =?utf-8?B?d2hDV3VFNG04Y2VFMUtiVmtQdHErZWlkKzI4NzROcHRrYmtPZFMzeHF3TkJX?=
 =?utf-8?B?VGZHcFRseW9ucVBxdERDTWFjdE9yUHRCWWVvYnV3djUrRmp3NDFXajcrS0c3?=
 =?utf-8?B?c0pPMmdxbEdMSEsvQkxORGtvKzVJcXYvMTY5b09kNkxHWFBBQ040cyt6SjFN?=
 =?utf-8?B?RlNZaG0va0VRR0ZXS1dZMkZTODY5Y2RvczFBSWRpYWQyQUNIZ2Z2OWdad0E1?=
 =?utf-8?Q?Zaw8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7d387c-3a30-4c48-fc73-08dd56a426b1
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 20:28:38.1849 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vqu5Fd11NOXQLNyp8FaESK/oGoqrXVCt5rI3H/ygARWqSsRE0YIl1fVzPB1UYPuZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8824
Received-SPF: permerror client-ip=40.107.102.52;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi John,

On 2/25/25 11:01, John Allen wrote:
> On Thu, Feb 20, 2025 at 06:59:34PM +0800, Zhao Liu wrote:
>> And one more thing :-) ...
>>
>>>  static const CPUCaches epyc_rome_cache_info = {
>>>      .l1d_cache = &(CPUCacheInfo) {
>>>          .type = DATA_CACHE,
>>> @@ -5207,6 +5261,25 @@ static const X86CPUDefinition builtin_x86_defs[] = {
>>>                  },
>>>                  .cache_info = &epyc_v4_cache_info
>>>              },
>>> +            {
>>> +                .version = 5,
>>> +                .props = (PropValue[]) {
>>> +                    { "overflow-recov", "on" },
>>> +                    { "succor", "on" },
>>
>> When I checks the "overflow-recov" and "succor" enabling, I find these 2
>> bits are set unconditionally.
>>
>> I'm not sure if all AMD platforms support both bits, do you think it's
>> necessary to check the host support?
> 
> Hi Zhao,
> 
> IIRC, we intentionally set these unconditionally since there is no
> specific support needed from the host side for guests to use these bits
> to handle MCEs. See the original discussion and rationale in this
> thread:
> 
> https://lore.kernel.org/all/20230706194022.2485195-2-john.allen@amd.com/
> 
> However, this discussion only applied to the SUCCOR feature and not the
> OVERFLOW_RECOV feature and now that you bring it up, I'm second guessing
> whether we can apply the same thinking to OVERFLOW_RECOV. I think we may
> want to keep setting the SUCCOR bit unconditionally, but we may want to
> handle OVERFLOW_RECOV normally. I'll have to track down some old
> hardware to see how this behaves when the hardware doesn't support it.

Yes. We need to verify it on pre-EPYC hardware. Please let us know how it
goes.

But, this series updates only the EPYC based CPU models. It should not be
a concern here. Right?


> 
> Thanks,
> John
> 
>>
>> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> index 6c749d4ee812..03e463076632 100644
>> --- a/target/i386/kvm/kvm.c
>> +++ b/target/i386/kvm/kvm.c
>> @@ -555,7 +555,10 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>>          cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
>>          ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
>>      } else if (function == 0x80000007 && reg == R_EBX) {
>> -        ret |= CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR;
>> +        uint32_t ebx;
>> +        host_cpuid(0x80000007, 0, &unused, &ebx, &unused, &unused);
>> +
>> +        ret |= ebx & (CPUID_8000_0007_EBX_OVERFLOW_RECOV | CPUID_8000_0007_EBX_SUCCOR);
>>      } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
>>          /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
>>           * be enabled without the in-kernel irqchip
>>
>> Thanks,
>> Zhao
>>
>>
> 

-- 
Thanks
Babu Moger

