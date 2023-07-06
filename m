Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5374A4F0
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:29:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVZi-0007L1-9V; Thu, 06 Jul 2023 16:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qHVZf-0007Km-BN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:27:35 -0400
Received: from mail-dm6nam11on2043.outbound.protection.outlook.com
 ([40.107.223.43] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Babu.Moger@amd.com>)
 id 1qHVZd-00059i-8k
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 16:27:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awyHSUbxtH+uEPE3xPu1dLDz2+jywoxxGpAX9ej6XB+IjPMx3DGGlvs3scRervwJcF2TVO5oCFpQl2QSdeM0dXFb/PNvWZLZOSHi+WZJuZuPdiryj0qalRWwL3aaYrP7izUPMLWX7T4hwd6jazUbxe+3kodBa4fDQiFtwyHxQLJJw9qQcCHSIvkaa+ShBpGSEVhjPR1VoW3Gu1Ft00oaJFxURqVcpj9aNedSzuUT0FdiyC9Nuv4HPXoYGnVXhDiO9JX9wLoNBXnpP2+ZzH7RbHTPk6BuFWR8GbCqwTms06wLTgWq5SDd0CGKfhcTT7lDSzskzdYpD93oylTA2GDnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJQY/xVQvs4ok74YoDPuTLRnPUUvklus3ond21HWf/E=;
 b=b5JT7M2Uca0/1Oyj0j6riEUyIOa8HEr4jNN0AGROv4qS9shUL1lVazAx9vzsFuna7vLXg4EOOnFKquoQsP3r60uGV8+I2z3ROaDXtO4PuhR/vISjue8TK5i4dx/72YPkK1mNbkosF26Hi5CkbXxcB9Hvc2FLlXIbCgggdZE5VHK6f6XfDJHq77zr8Ipf9+LHpJDG7J+mp9n8EtbHI503YDtaO08J35E+ddp74eTsMasDVJbUfp5BTruLJMNqDPymz87tW9YiDSFkAeWkUQlnSvfUxMyBallKiDlia2w5G/WwAs/GiTZwWuNpdF0fGLND9fhpZoO0kZznGh1dC8Dekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJQY/xVQvs4ok74YoDPuTLRnPUUvklus3ond21HWf/E=;
 b=VDwkHVK5YpPqe4BDe7E55FwoVSM8jzcTjXAzLZqvtE5RTrabdUJM4ILhNU0p3U4rf/0uDByRBoNNvTUwFzmE6PBTb+YYwNxQMiVDqjTaj35jS8HsWgdhZWfUw4SE+fhezIVI5E4ZjvPQj3RWIlREttMsmRFSyPyLONtaNqU4qn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 20:22:28 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbc1:dd6b:26eb:d46e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbc1:dd6b:26eb:d46e%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 20:22:28 +0000
Message-ID: <10122c07-3c46-3aa4-890a-0ae6e5a51900@amd.com>
Date: Thu, 6 Jul 2023 15:22:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] i386: Add support for SUCCOR feature
Content-Language: en-US
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, william.roche@oracle.com,
 joao.m.martins@oracle.com
References: <20230706194022.2485195-1-john.allen@amd.com>
 <20230706194022.2485195-2-john.allen@amd.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20230706194022.2485195-2-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:806:122::16) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d4d081d-98f9-407c-f0fe-08db7e5eb7d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yOgxutcMv7DeN1C/UVhR8Fu87CUK3+7yIFe1rCByJ+7mbfue0O6MQCE0AYS9igKrqEo3rVFInn+T97wrczqbMbVDWPjKZvpxwTswRmtkQNlRJoJ/AYhw30bqncflFKYPdhvAl5zSXpqsdYDCyrUj8eJ6udpxItzfBRQeZ0qRtY5uJ/tYsf67MRGihsDj33ZPXHo/hfL2sp/QfkXP2HGyevmRYQkaIVoIT7cqoOLtuREmNO5lEqonuWGjfyXnKUl+YqMY/4rPuhTCWc/Dy7YIYkiJK4kDBaBrcFWEENezhuO1OlGGriPTOCUXwMH4coqUs8q2ljm3Ie53ZXQG4K7ltJqHp59uPONKF+eVnYT6Axx4VGvHXTkIBU0qfQAFogsZ7xQyblAOyAE/xAS/Ip157zVtk4zoWg4MZ/oWja1RKS1GPx9mr1X8h9wmQdj4j9Z3+mRcXf52N4+7dsM3ZIaXFagHJMbNj2URn0ruvCLjV3QFsx2nRD251AhE0jIYGJQb3zrqVj/B0QekyfQAwprihfl0yPJplyAZPYiVXy78q8pWgD0R5ACUBFN1q8opLgtlgQUURBrbqgfjMXGJUg3SHoJtbMPRZG2EnSsRAaKg/RZz7B+qwNLasFTDfL5v6jPtrKQhzHxiipVXcxNfy2IciA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4553.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199021)(41300700001)(66946007)(66556008)(3450700001)(478600001)(6512007)(86362001)(31696002)(38100700002)(6486002)(4326008)(83380400001)(6666004)(36756003)(316002)(66476007)(8936002)(8676002)(2616005)(2906002)(5660300002)(31686004)(26005)(186003)(53546011)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmsvUDhKQVBKdG9YM1pnajRGOHNvM3BHdWJub20xY2lyVFVkZXN3cGY3dGlP?=
 =?utf-8?B?SzlMaHZZYlNYZFBZWVZDQjJ1YWFtQTdRVVloa1dadjFXMHZRZHZhVWtDb0dp?=
 =?utf-8?B?M2RhdURKWlFCcW5yZllyUVI5SXVmdy9zOS8ycWdIbjhVckk5eHN5S2V6eUpF?=
 =?utf-8?B?SFAvZFJiVHlmM0dTbHNRRStLTXpnKzdCNDdsdXB1cGZvNUVFTjlaMDFKb1RK?=
 =?utf-8?B?WkhjVmtlTy9jQUR4YVlXUHhKK2FPUXp2QnJsQXBSM2NpZHI5ZWFneTd2TGsw?=
 =?utf-8?B?YUR2bjFvajZscVZaaFJFeE1YNnNwejlBMHQ3Y0xIU3RLRzRkU2ZTc1hLcDBv?=
 =?utf-8?B?SHFESmFYem5JVlNHK1J3eHdNdmNSSmZiVmE0c20yZlFldjI0RDB1bk9oS25a?=
 =?utf-8?B?dGdGUit4SnhIdklkWlVCODNYL0RZNTFyUzZCblZiSEtQcGJBQjZpN2x0MVBE?=
 =?utf-8?B?TUJuenhlb2JPajluSjRGUFNlTEdsUUNSWEt3b1FUK2tZY2pKWlFyK2ZlS1cy?=
 =?utf-8?B?R3hHVzcyMEtSb2FMT2RqSEZqa2RJWDdic1dNcm1mTnZQdUtUcEowSUZKemF5?=
 =?utf-8?B?UkhCRnZrQjM5eWExZUxyMVRSR0Jja3RycjZoTXlOZmloOGZSRlVYM3pkSlFi?=
 =?utf-8?B?Q3Mxc3liSFpOVnNCV2xvNW9aYVN3ZHVaY2xJekRhV2R3cFF2V0xIZUYwOWlF?=
 =?utf-8?B?eC9ndXd1RFJSSUE5UitiUm9KVm1PdHBJNzhUVGlWTGJ2OWVFMnNuOEFkbUZw?=
 =?utf-8?B?N0NrUVdvQTdpSHIyOEw2ZnJ1bVJlTDNIZzZsUWdYZ0NsYXI5eXZ4ZnRQNjln?=
 =?utf-8?B?aGxER3g5ckMxdEFBYWIwSUJyT3ZyMVpOQWZ3MnpiSGRRbExsVGNkcWsxZG5X?=
 =?utf-8?B?dUMwOEdYYXd4ejZmTXJXTHliMktoT0ozTmRSZHhmWFJYQXVYS1lHNnRreWc5?=
 =?utf-8?B?eFJ0TGs3cWpnY09ZeWc2Qm9ZVkFoRXg4cTFEMlZIdFUvYjZzWnRtYzgzR2xa?=
 =?utf-8?B?YUQraGxKb2FhZ0xHaEkxNStxTTRPTmVmcjZ3UEVZMUdzTW1WZUxQMzNySTlB?=
 =?utf-8?B?bnF3eUJLcWNlbmFnT2dUWmNxUUNLNVRkREhUWWViYkw0MVpoNEJySnZBUzZi?=
 =?utf-8?B?bnN0NkFVckYyZFBEV1dIYUhmcGNZcVE3Z0dlOUwrR2VVeFY2amsxYUdsdllu?=
 =?utf-8?B?cXdHZEU0ak9FR3ZXeHlWa0Vxc1hQOWt1U0VDTERrQi9HbC9RUWJ6dW1NUWFY?=
 =?utf-8?B?YThSTFFKazJncHUydUlkaW9GZW5qSWlLRjR0bXRHZnNtaVd0ZU9FNmNad1dY?=
 =?utf-8?B?ZlNSMlc1RzNGeGNiVWNaUlNERU5uTWRaUVBPaURuMlE3cm1uMGpvTlEvaU9j?=
 =?utf-8?B?REpmOWpZQjVmSXJGUjNmSC9ObFcyU1ZFS093Tlg2Qi9xUzExeEpmUzdRV1FB?=
 =?utf-8?B?QitPdmUxa1psV2Y4YXl5LzhzdlZ6RkMxdllLRHRyZERxRXBZcHR6Vk5WbnNM?=
 =?utf-8?B?c0RWczlocEh1UllCN1pqSjJPQ2tudUppZjc2K0M0dFBXRWthWnNhZVdXSWpL?=
 =?utf-8?B?bUdJK3UrbjQ0Z2xGajF3Z1MvNkhuOFVlYk1OanVrWHM4a2lzMzR1TlVzWHh1?=
 =?utf-8?B?Y1h5bFdnY2xFRmc4U1UrN2R6UFNvdmluQklaQXAxVTBQZFVnWllKQ3FaSVhE?=
 =?utf-8?B?bkh2MHZEV3VyZ05QMXZCYWRwNDNlRVZ5NzBFQ2FNZnVnRURIMEdEdjAyZldN?=
 =?utf-8?B?QldiSDh2SjFuOGNsazBYSERrblZaaVZoY3JnMjByU1BoekM2b0xIOEhiYVNO?=
 =?utf-8?B?UmlQVWRDNG5BZG14bkFjNGROcFdGQVRuTHNiRXNwSFF5eFU1akRNVUIwaXZp?=
 =?utf-8?B?QkpQWm9xanBGNURXSjA4bmNQTEVjOERiUFE5MHhNQTRjbHZXMW1KMjBib01i?=
 =?utf-8?B?NmFCSHF0a0d5b29HM1ZTd3VsaUtlRENvWGh6RDZGZjNwNVNzSGpvUTRVNXpv?=
 =?utf-8?B?RldGcTlVSndZT3A5bU9XSS8rWlhtUWlnNEhPOFBaS09IVUNKaHg2SnB2ZTF5?=
 =?utf-8?B?ejU3R01ERzZGNFd4YXRsTFIxVWVvVzZkZzk0ZXhZc211dUMyd25wVjVqZncz?=
 =?utf-8?Q?PjBE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4d081d-98f9-407c-f0fe-08db7e5eb7d5
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 20:22:28.1556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8/7Pm/0tGlRVqtPM+3lpvmK7FXSZEqp4Lv0LBt78a50UbUYq9ChlSjU8PHxladY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278
Received-SPF: softfail client-ip=40.107.223.43;
 envelope-from=Babu.Moger@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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
Reply-To: babu.moger@amd.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi John,
Thanks for the patches. Few comments below.

On 7/6/23 14:40, John Allen wrote:
> Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
> be exposed to guests to allow them to handle machine check exceptions on AMD
> hosts.
> 
> Reported-by: William Roche <william.roche@oracle.com>
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 4 ++++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 06009b80e8..09fae9337a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -5874,7 +5874,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0x80000007:
>          *eax = 0;
> -        *ebx = 0;
> +        *ebx = env->features[FEAT_8000_0007_EBX] | CPUID_8000_0007_EBX_SUCCOR;

This is adding this feature unconditionally which does not seem right.
Couple of things.
1. Add the feature word for SUCCOR. Users can add this feature using the
feature word "+succor".

2. Also define  CPUID_8000_0007_EBX_SUCCOR : In this case, we can add this
feature as part of the EPYC Model update.

Thanks
Babu


