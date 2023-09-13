Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C4579DE9D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 05:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgGXL-0003u9-Gb; Tue, 12 Sep 2023 23:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1qgGXH-0003sl-Rl
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 23:27:28 -0400
Received: from mail-dm6nam10on2075.outbound.protection.outlook.com
 ([40.107.93.75] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pankaj.Gupta@amd.com>)
 id 1qgGXF-0008SC-3A
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 23:27:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6XovvOrXjMdkwNqLTHiGX85Hg/S/LlvYaM4nfk30ffm8jeClt1laahwwhSOgQAQZS6ZERBdmVAx7+wHpAAUkkz538uiavvXakYvXf8exAIuVQkGXDv5zU0vnvJR+IQyYtgoBrlMDIxTOVvj7xa950Gocv+pDrfG5D6dF4STj1mMICtCA6baguIITogbX63BQ3ishmBBjsmU5aHEXqRjaIkL1qHomi3nRCcS9UubBlbfLvT1Q8EQXWx/AlldA3OCLOImRPiggV22SssjbZEkpsmTEwIfwzMOKyiqm1Ly0Y4ekTuoXa12KpsWxG2SwNttfx4jBot34quQ5qBK0NjX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iU375bRNAmR0LywobJHBEUN3LL2d+F9SfsWQvNAdCg=;
 b=LKtWWdGle0MMaj16PT1GZRqZNgkx08AqGqBgRE7cNaggz/tIHr65iCthajEuhKA87ND2d65uAz5pBLoU1uzHVy4Z4zfUNjClvdy6FKbMo4QSjWQ9+tnCKCix0qO02HpZmsepJzAL0JiUBavriAdu5t/Iop2QMKoimZFpFl+ZvoKQXIqnkOHhlOUyAb4EnE5mTaO0HdLVb4lWywXhtwav9EcBOwBSZxW7WEK96LpnhDmrsf5VqxENyQ3PsCn5r8UM/w6jRMoPdhpgS/RrXDmq0Hh2KO/t4ZhPzK0QNPHUB+z3u+/EnborOvgJFjpykbpZNA3c4Qn7SSiF1nuztiUcUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iU375bRNAmR0LywobJHBEUN3LL2d+F9SfsWQvNAdCg=;
 b=Xn6lnBmhrDkrbzeRu2OSLZ6ObFH0U4WKxR4EHPvgRI6lVa7bMv/jq6gkis7T21kcItaQts4Dgd/uDl7ObqNHSltbYFtuoPp8Rjuomif6r2zqB+UnDRjVLPaiR3PxuSoSnVsBOjwfItbfj7UUpDiITdxDjV+UgtLhqAwrGvgW2sw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) by
 IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Wed, 13 Sep
 2023 03:22:18 +0000
Received: from DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb]) by DM6PR12MB2810.namprd12.prod.outlook.com
 ([fe80::9760:1a6e:8715:e4cb%7]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 03:22:17 +0000
Message-ID: <7ac865ff-5136-a327-77ca-3604a0217d9b@amd.com>
Date: Wed, 13 Sep 2023 05:22:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/3] i386: Explicitly ignore unsupported BUS_MCEERR_AO
 MCE on AMD guest
Content-Language: en-US
To: John Allen <john.allen@amd.com>, qemu-devel@nongnu.org
Cc: yazen.ghannam@amd.com, michael.roth@amd.com, babu.moger@amd.com,
 william.roche@oracle.com, joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
References: <20230912211824.90952-1-john.allen@amd.com>
 <20230912211824.90952-3-john.allen@amd.com>
From: "Gupta, Pankaj" <pankaj.gupta@amd.com>
In-Reply-To: <20230912211824.90952-3-john.allen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To DM6PR12MB2810.namprd12.prod.outlook.com
 (2603:10b6:5:41::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 323fd3e0-fb18-43b6-5262-08dbb408a1e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxu/ZIjk4askt8OvNrP+muv5WD4IDeJ9UGqVajQon+yoeTkIszdxIOgrqm05EPmqDg+H1eHYVOXAtLQC0NkUgZHju+H116ap8ktZ2qaac2vhRujOVjbLc8JUxAR03S9GtgXAAbHBVn7DZSHEJvEyR6BcpLT9/3vXh4eqCFi4WwgR82FEGarSONDnyXihTsw8cmWo5E/1ON8OXTBaJJytPkznbiHDED1OvOrOnHV1+DwKMdTXL1XhISaAplNFbaG+dO0zNRikX8mm4UsR/+W5uZR2tjFp4uhyBPAYgPRLSxIRPcYEw7nkBfa+KMs2PvRRCVhxkl9CWHW075yX1IcAcgMLeY4KyZtxeMVfjdbKwvPyuxlcW+EhWevavNCfEaAquvODYTu/IF433qt+n+LIixNjdEfyDJruRLeU5EUPFjDAHHX/0SjLI7F8vNVpfZ2qDwY4HTcJYHVO0UDxLB81S4PcFYnYsqIk1zF9NZXBY9rcnlX8DkmJObEIqZXk9zPHUdvP63HvoA1KvO0M+EepsTXhAiInxxEAGQpyJZX16/PapKOD/aprnKoMerrwuHOgIsI0R1X6cueGZrh+MGHpoCbQJrL+fJ/xO7L/gmDPFSvDhxWGXb0NsPqGr5fH7YJ46lqtxTZ/Z/xT98IyiWEnvmWgh7hnQ9+a4s8HbJQ6erI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2810.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(66899024)(6666004)(38100700002)(83380400001)(86362001)(31696002)(2616005)(36756003)(26005)(31686004)(316002)(41300700001)(4326008)(8676002)(66476007)(2906002)(478600001)(5660300002)(66946007)(8936002)(66556008)(21314003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V25uSnlFRjR1YUYvVU5JaUhzcGVxclZKZVZSMEEzdzkvSzVpR3ZQS1VXdGsv?=
 =?utf-8?B?V09BcXBqWmlOS2V1L3VVT2tOdjVYNHhVbHBMRlRBOHZKd3JLN2lETTkyT24y?=
 =?utf-8?B?cFlvMTluM2h3R3h6dkw5VkFybXBzSHBFcFdNTHhqWmdZa2llRjczaW40R1lD?=
 =?utf-8?B?TGJSQ2EzbkxmMm16NUVoWTNXZWxQa2tqZjFTQndIWWpoa0ZtVFdUTVcwMXhh?=
 =?utf-8?B?UUVsbzgvdEJVWk9oN2dVVnVGd0xWcmlURTRuby9GMWp4amRlMDgvUGhqT0dO?=
 =?utf-8?B?NDVVbS9IYUw3c1c1eHlHUGFpMk9JVTZ6aGtGTkliWFRTNmtuZGhvMlVMWmRM?=
 =?utf-8?B?elRPWkFsR04wVVo4WVNsYklPbEE4aFcyTEJZaUFrS09iOTdaVEtqdnc1YmUy?=
 =?utf-8?B?cUVaem16NWRoaG9qeGhZZnRScUV1cVBkTXF4KzVJSVJnRjRqTzhxaktHdE80?=
 =?utf-8?B?RlJTdldXVnZucVY4L0xpU1VRWGsyd00zakluZ1Jjdi9JbEJYZHE2MTd4eFY2?=
 =?utf-8?B?MHRpcVFLNXZzVUpCUWlnMFU1eGpyT0pncGRHUDZnOEhXWjZ6djNGUmtkS0Fs?=
 =?utf-8?B?MStIaWNNaUpMV1J1MXl2S3FMeWhwSFJZVHg1NzJDMUI3K0kvdG1pZWp4OFYv?=
 =?utf-8?B?a2RaSDlvbHlmUitOT1hJRXA4QXEvWk5zN1YvNzZ1SnlBMHFHVm5lcGZtVDAr?=
 =?utf-8?B?ZlVJekR2T2VKaWtxMk1wV0o5ck51NWordTJGVmQ3eDYxRmQ2b0VlRTQvTVVn?=
 =?utf-8?B?NkJVYkN1ZDFOZnFFendhQzIzbUZGN3E5SDlLM2JZTzRxNjZkdm5IdXZ4Wkdy?=
 =?utf-8?B?SEZheG9CYWpxNDZUNjFJUzlUZ1ljNzA0ZHhVV1BzYVkvRkJnMmc4TFBMR1ZE?=
 =?utf-8?B?WFpWN25xY2RoOG9pUXdOTUh0VlF6YzQ2U0JyS2J4OWVvVEhCRDBIekNPUzR0?=
 =?utf-8?B?cVNsS2xsTHQzTGZCOW5LWUFCQ0tnQ1kyUlRzUWJiZFROVi9YMGVMVU82SERQ?=
 =?utf-8?B?VDY2S1VzNG5sM0VabGV2M2FIU2k3RGRwbXI5QXFjVGdLZ0VrQ1htM09LcWhx?=
 =?utf-8?B?R3h5eXdEMS9uTVpSTWJvaFZUd0p6S2VjWDRBQTc1SE14akYxQkJOK1RxWjVn?=
 =?utf-8?B?c3puVkFmTFdMOEpxNDdBTHkwbnBwZGdFUStVc1lIWnhoQ2FndENpOHQ1U01q?=
 =?utf-8?B?bzh1UW5LMnFrcnppU2plVEVISlFZOStjTTc5bUt2dFdWTWo3Z1AxdHhKMVJt?=
 =?utf-8?B?NTErWDdIRnpISkNBYjNOek1wY1NOeDRlN3NiVFY1S2t6NXdxeGErU0VSVmVy?=
 =?utf-8?B?dERqamM0a2hubkJXNWhsc1pLQW1EY0g0UUF6U3IzYWRhb3JCNFpiZEIxS216?=
 =?utf-8?B?dFRyTDFVYzRZTlFJN2oxQlJCazNGd1hwWFZSL0dZRElyamIyVkJDMzB5N2xn?=
 =?utf-8?B?U01FOUZvcHpyS2FhajdtOUJMb0V2Q3dtTEtOK3JRVXA2dUdzKzF2bU5Hbnhi?=
 =?utf-8?B?bW9veHM5RjVFUUxTVW1FUTlMR2Nsek5RbmtOUXVOalIwQm1MUUFTa0Y1OWFK?=
 =?utf-8?B?eEVQR2NWcGkvSyt1QzBrRklHc1JPeERPcllkTExUc2d3OWxCV1orenBwbVJX?=
 =?utf-8?B?bXE3cC9KVnhSY2N3TEpPWXlNY2F0QnpGRXBjTllScyt1OHNUMHZDSWc2QkFL?=
 =?utf-8?B?b1hiblk5bDF6aUJmTnJJTDFubVczaXgyN3NOc1duVmZTQ0pFdEhhd3YvTTQ3?=
 =?utf-8?B?TkJ0WmRrVVNmRE5wUkllS1B6OEoxR3NtMGdDZ1BsQWc0YjUyUmxkWkp6VU1k?=
 =?utf-8?B?L2RFVW1xTkc5dVVzbERWS3pSeW15aUFYNFdsUlpyMzBLSFRGMlVUN3NhVDhu?=
 =?utf-8?B?V2FnelVGZWc2VjBaVUhsZ0lKSnA5b281VS9OQWxaMm8vZGYrL0xlRHJYLzRs?=
 =?utf-8?B?MjVvWWlLU3B4dEg0alEvWFlMOGg2VXN4V1NtU3Mza293SkRGaGFQelBsZTVk?=
 =?utf-8?B?dzRRbHdvQVN0UVkxbmRGaEhyTndKcnFnYlFWaFpoZmh2WDBscCtGWVIwVEpt?=
 =?utf-8?B?elF3c2xvVUxDWFl4VHhoeGFFZCtlbE5KbHRLTmJ2L2VhUTRJZXVoRGJmVXRU?=
 =?utf-8?Q?vF9CInG3xgn31lzL/RCTDcDID?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323fd3e0-fb18-43b6-5262-08dbb408a1e0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2810.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 03:22:17.6191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WZZk3m/1BcFRzDpMntsPx3QoDdx2iPrFjW3ssbQJPNKCOmbvLH/UgVUYyLKz+ATaUCwW+Jy+L4oEV+JhQ/OSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
Received-SPF: softfail client-ip=40.107.93.75;
 envelope-from=Pankaj.Gupta@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

> From: William Roche <william.roche@oracle.com>
> 
> AMD guests can't currently deal with BUS_MCEERR_AO MCE injection
> as it panics the VM kernel. We filter this event and provide a
> warning message.
> 
> Signed-off-by: William Roche <william.roche@oracle.com>
> ---
> v3:
>    - New patch
> v4:
>    - Remove redundant check for AO errors
> ---
>   target/i386/kvm/kvm.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 5fce74aac5..7e9fc0cac5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -604,6 +604,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
>               mcg_status |= MCG_STATUS_RIPV;
>           }
>       } else {
> +        if (code == BUS_MCEERR_AO) {
> +            /* XXX we don't support BUS_MCEERR_AO injection on AMD yet */
> +            return;
> +        }
>           mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>       }
>   
> @@ -668,8 +672,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
>                       addr, paddr, "BUS_MCEERR_AR");
>               } else {
>                    warn_report("Guest MCE Memory Error at QEMU addr %p and "
> -                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
> -                     addr, paddr, "BUS_MCEERR_AO");
> +                     "GUEST addr 0x%" HWADDR_PRIx " of type %s %s",
> +                     addr, paddr, "BUS_MCEERR_AO",
> +                     IS_AMD_CPU(env) ? "ignored on AMD guest" : "injected");
>               }
>   
>               return;

Reviewed-by: Pankaj Gupta <pankaj.gupta@amd.com>


