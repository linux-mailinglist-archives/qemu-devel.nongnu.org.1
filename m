Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 803937923D9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 17:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdXmN-0006ll-DC; Tue, 05 Sep 2023 11:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdXmL-0006lD-FQ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:15:45 -0400
Received: from mail-mw2nam10on20607.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::607]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <John.Allen@amd.com>)
 id 1qdXmI-0001Ri-DZ
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 11:15:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiVZKkZiT9ZRpNlB0uwQagyTnmzR5Ltlf5eZ54zjKeeY8rONd5nxb2+nMjFBRtad6wg9MQd3DSf+V1ahrz/ujwAf37PZR8fxPr755GiLzjJ1VCRD75dHhBCzJMnUufrtcJvmnkdf5fVhTJlvHwwaWB+viTKokLaWCT480pIeNstrtkmO9QQeOm8Sy115cZGhuryWmtxWO3TECFO4PO7Cs006SiMqHKYtDY3n2ru0sCDpuO+U3vxeaH5PZ4WEaGzZmyqSURmqbESX3Y3wmENbxY3npjSqZ4YZvqEf16W2JMosdp05Vj8B8GdQBTk2LijCtTCidqP+3E+ofP8l9mVh8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iRlztR/j7OnMahKpxn2+mdDYvBY1zjT02+tC/fyRX4=;
 b=Rmie6g7ZIWuJgxEFZ9O2A4GIc49v/sZidy8WmO8kbcC83er/mr40JLc0IOuCk7CkCUW7oaXQDsyImh62VKSvUlmcrUPaPq4FdNgbJgzmZCKcaT6jWOfSrdBlRNiyGRDeZLz2yl8Jq3lyBjDqLs+i0uuwky7vKdwQDVdDbLcTIZoZ7ov5lLiTXq+agfhDJPEh+tgruJARjnyvLtzU+grQUjmQFFwCrsjYt1eE1yxX41iHOmbGYMjFVZw9ZA+T+BUNPYxDmdMvFf5zkTTefywoJgDCYzo8vbnEfnbHh67oIDAoCidv0vTdZjogvNf6+IFuXuDtfvtRA7dbov9OCBPvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iRlztR/j7OnMahKpxn2+mdDYvBY1zjT02+tC/fyRX4=;
 b=4DxNaJPpNDbZjGH8PRRjeMdYxnxA5MHKG56i5YCUyNi+SCXp2v1ZIGfFcMer8sYawONqc0/dNE/LAyM+/xEGt0WnXvq2jiUeP8KnKPoeCFW+H7c3SCgwpk0O6hCN6YWsPM70zVrLXIBV5Yh11a9LhUiwm3MdELZ8JRvBJVGbBzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by MN2PR12MB4566.namprd12.prod.outlook.com (2603:10b6:208:26a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 15:15:34 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::1be:2aa7:e47c:e73e]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::1be:2aa7:e47c:e73e%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 15:15:32 +0000
Date: Tue, 5 Sep 2023 10:15:26 -0500
To: William Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, yazen.ghannam@amd.com, michael.roth@amd.com,
 babu.moger@amd.com, joao.m.martins@oracle.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net
Subject: Re: [PATCH v2 0/2] Fix MCE handling on AMD hosts
Message-ID: <ZPdGDsPM5Mrt3AAk@johallen-workstation>
References: <20230726204157.3604531-1-john.allen@amd.com>
 <ebaf4540-09da-305e-503e-d83d53f6f4ff@oracle.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebaf4540-09da-305e-503e-d83d53f6f4ff@oracle.com>
X-ClientProxiedBy: YQBPR0101CA0259.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::20) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|MN2PR12MB4566:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a12030-27af-4350-2616-08dbae22f2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0cn1VkXEciEgFpFeUVJ4tTHVDibHkxBlJkQPE4HA4JohyAgtVgZbrKX17l9v0zk/xpIFgbYAJy9Iz0U+qH43BXBXmJbX88P5dLRF2A2Rgwcd/W7vUn7vEcOHEd63y919H8c8p8uog70FMyKyD4UAkrtWn49djIYbyFTrRrPcH0y0njcrXaEIYmVvLUz6UwiOz85YUlhzcaxUBhxCf7C2xq5saDHKat0XGL3PIMz3amFtUBAOe+XxAY6t0bui4rI7ISbWOLgH5sCIboUZGv2kvY62duz/dg8/ed5WK1c0UPxOmMQ6QJNnj28pxqZ+NT1z7V/IK5qVkHZpG31oJgZb8t18FXtNGkq9p+8fqKJOmTNV0ryPKqjMTC/xla4fPURkbP0eEH2r1cEcn0GPMUBACw/bZNOvvUFk7M3V5ajk7bDxQEPgCF+C3NbVDIstX6fPbQSit9hfTr+4zndKTtQY9NoF8VQjcT7fG7kUz6HH+8/XHQYSdBVyrRPNVdADSTjE8AA80lJ6UU6CvVHc7hGPSpTnetibnRU1bGLSFKH1XShhEZEZB5SZLsVJ/o1U16bxwQxSltvIOPn/DcAzLOB3Zx2HPHvgx35PWVyrDT1n6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5995.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199024)(186009)(1800799009)(5660300002)(83380400001)(66556008)(66476007)(66946007)(8676002)(4326008)(8936002)(26005)(44832011)(9686003)(6512007)(66899024)(86362001)(2906002)(53546011)(41300700001)(6486002)(6506007)(33716001)(478600001)(38100700002)(316002)(6666004)(6916009)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?vcz7kckdGqzFV/yT1bnm679VdGW3ebS/+YSWTfMAL0eVR9mCUmaaDHfKfA?=
 =?iso-8859-1?Q?0kO+FxhXsWxCtWkOsDM0yk9h0uoe7k1f20BaNzYlm++9bu8kJW6weCAAGv?=
 =?iso-8859-1?Q?kqXtSy1VPK19MK2MsvurwzeEuLKMW6yowmjdrcGQq4zFNq9GqytOVemNAu?=
 =?iso-8859-1?Q?VPeUKS0EsLBX/r7bTTWI7WUnO5EH6ZLvhonmPWS4i0icuzUB6+a4JqWGVq?=
 =?iso-8859-1?Q?TiFB+wR9TAAfsvVrbMK+LfC2HHuLqUd5pof6DVuZkjxvs1GiTu6YNN/p7x?=
 =?iso-8859-1?Q?nR4UDr7BgRNbY2REK4krqQ8hvxu1z3segnKr9xsKC4/dekkTGL4J5A8G4V?=
 =?iso-8859-1?Q?JMwLwhHMkl8r0rsx/Gr++ZGJxTwpdLbRnDiWsiBmlRNg2aa73fkE8mf5oh?=
 =?iso-8859-1?Q?Ego142LAOFloFIuz0HAuuD2DJdzN2no+Fh7vb6VtySnTfp+0MGk199YSl7?=
 =?iso-8859-1?Q?Qh3tEoo1tg0f/WsWk8FeC5d53CLC5EjwTj2z6QpvoVtEZ0zWvzvUPGVzp9?=
 =?iso-8859-1?Q?/IMYJYrVJQKFXAIZqKG5b+9BHBABqEjeh5HcONgRrHD/ScNsnQajA0ZBQb?=
 =?iso-8859-1?Q?Fu8cqFVehhegB418gvrMXlfmdk54uhl74uulhCH0B3Ynm9MheuShR+95DK?=
 =?iso-8859-1?Q?FcSQSyIq+FTxWwf41LZI17kjRTIlPflITtzDJok0ppwabG8C7t+LpYy++5?=
 =?iso-8859-1?Q?AZEyFRkkbLllEw+HqYgDlwD7HYalCDjEsNp0Hd1RlyQj9XvOb5kRI6P8Vj?=
 =?iso-8859-1?Q?gHJUajcmJEvu2t4UEp7AYj6i/fJ1gt8e+YBZK7/Sa5iudrRgB1Bh+TUvEg?=
 =?iso-8859-1?Q?vxCPyMJkvb/1b7ti+KPgR05Lw011UnuYN5wvRioSV7IktmBk022Re/BaHm?=
 =?iso-8859-1?Q?u6Eep+raLYnt7ZUBE2xjXAyWsDIo2mf75K4621OJfRuMfOyCWNPmGyCxMc?=
 =?iso-8859-1?Q?GiB4nGoZSWZcFBSzJXV2C7G2DXjM3lmuw2drGfCQKpIrXiGEVn20BI49Hj?=
 =?iso-8859-1?Q?SoCSjVdLpIHPaYLkJacUPa2qWjYlDT03/Ri8qVrLG8anvtCy34XTmVSaeo?=
 =?iso-8859-1?Q?JBslartvs+l9zi2WT8bQhUdkXaj0vjUIKdwJN3IaqLy/4vcQq8zhu+0JgA?=
 =?iso-8859-1?Q?MjloYlRhqKVITRLoCOTff3FGAZavcCZB7P0qXwBEv6I6qNMncj3xew+9lS?=
 =?iso-8859-1?Q?mjyGMzYrL55hPUdVyTPZ0Kcj/hoBp0VL9+kFJCTQX4SrlheuRPciqoBYX9?=
 =?iso-8859-1?Q?sfhuSuDzMEvrt6EqkfZPvmN+G85ziOBSLndxqrq0yGxF5Jryzv0TYTDBJl?=
 =?iso-8859-1?Q?OE56vlCZAvWSdoPEzYZoFVMd8yR+lJjQLdl/W7oN+/FiKL05+PQZOt1SBA?=
 =?iso-8859-1?Q?8BHBcEf4sL6Rj1gH3cwZ4B7EVdph19Yl5yl6cHt7KJPNhPvH8OYg6s/0aR?=
 =?iso-8859-1?Q?IyJ3avXXaLzWKDDuvWJfcI57nAT9CIME65y945dri4/euPB9boLCLXH1bk?=
 =?iso-8859-1?Q?bnvUOPJr1zrfTSVFVoWdiW7Pz/XX0O8K3ijRedtafdZOxUlMBMG7f2RFrQ?=
 =?iso-8859-1?Q?ftixgN/HNlEdmf39obIVE06GACNrAe9i/xntVThcOEwQ6/3Yaw4E6bv+BV?=
 =?iso-8859-1?Q?lPKW4v2ipDdJdSTbt8z8KLAQpvPHVOhYO1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a12030-27af-4350-2616-08dbae22f2bc
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 15:15:32.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rFt2qOvJ7Qpx7c05DNam13Jdt1q2cxBIIMdDtKIvjWU8XBMF65y4vXrj3FMOsQKs2Q77afSdQ8zXCtBBGqmSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4566
Received-SPF: softfail client-ip=2a01:111:f400:7e89::607;
 envelope-from=John.Allen@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  John Allen <john.allen@amd.com>
From:  John Allen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Aug 31, 2023 at 11:40:08PM +0200, William Roche wrote:
> Hello John,
> 
> I could test your fixes and I can confirm that the BUS_MCEERR_AR is now
> working on AMD:
> 
> Before the fix, the VM panics with:
> 
> qemu-system-x86_64: Guest MCE Memory Error at QEMU addr 0x7f89573ce000 and
> GUEST addr 0x10b5ce000 of type BUS_MCEERR_AR injected
> [   83.562579] mce: [Hardware Error]: CPU 0: Machine Check Exception: 5 Bank
> 1: a000000000000000
> [   83.562585] mce: [Hardware Error]: RIP !INEXACT! 10:<ffffffff81e8f6ff>
> {pv_native_safe_halt+0xf/0x20}
> [   83.562592] mce: [Hardware Error]: TSC 3d39402bdc
> [   83.562593] mce: [Hardware Error]: PROCESSOR 2:800f12 TIME 1693515449
> SOCKET 0 APIC 0 microcode 800126e
> [   83.562596] mce: [Hardware Error]: Machine check: Uncorrected error
> without MCA Recovery
> [   83.562597] Kernel panic - not syncing: Fatal local machine check
> [   83.563401] Kernel Offset: disabled
> 
> With the fix, the same error injection doesn't kill the VM, but generates
> the following console messages:
> 
> qemu-system-x86_64: Guest MCE Memory Error at QEMU addr 0x7fa430ab9000 and
> GUEST addr 0x118cb9000 of type BUS_MCEERR_AR injected
> [  250.851996] Disabling lock debugging due to kernel taint
> [  250.852928] mce: Uncorrected hardware memory error in user-access at
> 118cb9000
> [  250.853261] Memory failure: 0x118cb9: Sending SIGBUS to
> mce_process_rea:1227 due to hardware memory corruption
> [  250.854933] mce: [Hardware Error]: Machine check events logged
> [  250.855800] Memory failure: 0x118cb9: recovery action for dirty LRU page:
> Recovered
> [  250.856661] mce: [Hardware Error]: CPU 2: Machine Check Exception: 7 Bank
> 9: bc00000000000000
> [  250.860552] mce: [Hardware Error]: RIP 33:<00007f56b9ecbee5>
> [  250.861405] mce: [Hardware Error]: TSC 8c2c664410 ADDR 118cb9000 MISC 8c
> [  250.862679] mce: [Hardware Error]: PROCESSOR 2:800f12 TIME 1693508937
> SOCKET 0 APIC 2 microcode 800126e
> 
> 
> But a problem still exists with BUS_MCEERR_AO that kills the VM with:
> 
> qemu-system-x86_64: warning: Guest MCE Memory Error at QEMU addr
> 0x7f1d108e5000 and GUEST addr 0x114ae5000 of type BUS_MCEERR_AO injected
> [  157.392905] mce: [Hardware Error]: CPU 0: Machine Check Exception: 7 Bank
> 9: bc00000000000000
> [  157.392912] mce: [Hardware Error]: RIP 10:<ffffffff81e8f6ff>
> {pv_native_safe_halt+0xf/0x20}
> [  157.392919] mce: [Hardware Error]: TSC 60b92a54d0 ADDR 114ae5000 MISC 8c
> [  157.392921] mce: [Hardware Error]: PROCESSOR 2:800f12 TIME 1693500765
> SOCKET 0 APIC 0 microcode 800126e
> [  157.392924] mce: [Hardware Error]: Machine check: Uncorrected
> unrecoverable error in kernel context
> [  157.392925] Kernel panic - not syncing: Fatal local machine check
> [  157.402582] Kernel Offset: disabled
> 
> As AMD guests can't currently deal with BUS_MCEERR_AO MCE injection,
> according to me the fix is not complete, the 'AO' case must be handled. The
> simplest way is probably to filter it at the qemu level, to only inject the
> 'AR' case -- and it also gives the possibility to let qemu provide a message
> about an ignored 'AO' error.
> 
> I would suggest to add a 3rd patch implementing this AMD specific filter:
> 
> 
> commit bf8cc74df3fcc7bf958a7c42b876e9c059fe4d06
> Author: William Roche <william.roche@oracle.com>
> Date:   Thu Aug 31 18:54:57 2023 +0000
> 
>     i386: Explicitly ignore unsupported BUS_MCEERR_AO MCE on AMD guest
> 
>     AMD guests can't currently deal with BUS_MCEERR_AO MCE injection
>     as it panics the VM kernel. We filter this event and provide a
>     warning message.
> 
>     Signed-off-by: William Roche <william.roche@oracle.com>
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 9ca7187628..bd60d5697b 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -606,6 +606,10 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr,
> int code)
>              mcg_status |= MCG_STATUS_RIPV;
>          }
>      } else {
> +        if (code == BUS_MCEERR_AO) {
> +            /* XXX we don't support BUS_MCEERR_AO injection on AMD yet */
> +            return;
> +        }
>          mcg_status |= MCG_STATUS_EIPV | MCG_STATUS_RIPV;
>      }
> 
> @@ -657,7 +661,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void
> *addr)
>          if (ram_addr != RAM_ADDR_INVALID &&
>              kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr))
> {
>              kvm_hwpoison_page_add(ram_addr);
> -            kvm_mce_inject(cpu, paddr, code);
> +            if (!IS_AMD_CPU(env) || code != BUS_MCEERR_AO)
> +                kvm_mce_inject(cpu, paddr, code);
> 
>              /*
>               * Use different logging severity based on error type.
> @@ -670,8 +675,9 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void
> *addr)
>                      addr, paddr, "BUS_MCEERR_AR");
>              } else {
>                   warn_report("Guest MCE Memory Error at QEMU addr %p and "
> -                     "GUEST addr 0x%" HWADDR_PRIx " of type %s injected",
> -                     addr, paddr, "BUS_MCEERR_AO");
> +                     "GUEST addr 0x%" HWADDR_PRIx " of type %s %s",
> +                     addr, paddr, "BUS_MCEERR_AO",
> +                     IS_AMD_CPU(env) ? "ignored on AMD guest" :
> "injected");
>              }
> 
>              return;
> ---

Thanks, I think this will be a good solution for now while we can't
fully support AO errors. I will test this and include in the next
version of the series.

Thanks,
John

> 
> 
> I hope this can help.
> 
> William.
> 
> 
> On 7/26/23 22:41, John Allen wrote:
> > In the event that a guest process attempts to access memory that has
> > been poisoned in response to a deferred uncorrected MCE, an AMD system
> > will currently generate a SIGBUS error which will result in the entire
> > guest being shutdown. Ideally, we only want to kill the guest process
> > that accessed poisoned memory in this case.
> > 
> > This support has been included in qemu for Intel hosts for a long time,
> > but there are a couple of changes needed for AMD hosts. First, we will
> > need to expose the SUCCOR cpuid bit to guests. Second, we need to modify
> > the MCE injection code to avoid Intel specific behavior when we are
> > running on an AMD host.
> > 
> > v2:
> >    - Add "succor" feature word.
> >    - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
> > 
> > John Allen (2):
> >    i386: Add support for SUCCOR feature
> >    i386: Fix MCE support for AMD hosts
> > 
> >   target/i386/cpu.c     | 18 +++++++++++++++++-
> >   target/i386/cpu.h     |  4 ++++
> >   target/i386/helper.c  |  4 ++++
> >   target/i386/kvm/kvm.c | 19 +++++++++++++------
> >   4 files changed, 38 insertions(+), 7 deletions(-)
> > 

