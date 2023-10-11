Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A7F7C5008
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:25:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWNN-0006wT-Mv; Wed, 11 Oct 2023 06:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1qqWNK-0006vW-6F; Wed, 11 Oct 2023 06:23:34 -0400
Received: from mail-bn8nam11on20700.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::700]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1qqWNF-0002KL-Sv; Wed, 11 Oct 2023 06:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kv4vR8rK0mOsMbsgWGWH55+M6WPoKbT0GAT513RvzpBc8kWTivEdtPcAqwEZ2rKjfhr+/OIPGcftXSIX5L/k/SBL8VirIoaXs1MGDx0kgVjuPzkBjqOb/l18Y9mr6V3ToHJh1Znd+9FXw6Drla/amRa4WFRlMRbx0XRmGSmbHjGjrmODwUwhID3V6U9AG/FW8POELgL+AfFH5W2wIyzs5/A5MV0/2UVlos8yeMB7q3I0oTuUgdtwJhp5aI+83AqOMULumLBaIgDSKCgJlzcLrv6+4vfNedMuLvtzdbDSYPGZpGz3lFII0/PKuRTOVyvfiwFPJsJttFD4OD/zJPOf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGcRpjdXWtECreUfet3/NDUmDBPDQHWzqDSO7CinqAc=;
 b=HpcIR+Mgl7aqPIKM8BL7H79Voew4S5lIk7h8vXHWomEb2ljZty7unroi31XiNWD8t6NsXPw7zTXdp/H+Z+TXZ+v49ntMOZo4bkk6ANyByHTd2Tf/QgE3FMYbix7zy18QldtB9Wb13x3VI0He2Z4NVUsy92Tck3aUy4/MtiSUunZQ8mEjLkBQa7TEyf5IPzfarpp/Gp9c9Y3/fY8Zggi281ludMhk8mi22r3LmrIDmdE+1f9/5kK0gUNmjrAGHhXeleTnimr3czgR+qyx1I/Dd47fXFjFWrn3XQIFk5SWZcbgsDO1YyTRyroF+NuLJeLwqSNL4pUs4rdSF2icX4KaQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGcRpjdXWtECreUfet3/NDUmDBPDQHWzqDSO7CinqAc=;
 b=T6BFNA21Eoncb9N7F7UJq6GQbsJ1YIO1OLTaEbf7Uxfk4yDDCu8Xgxzh5rjEEL2clEMNQaRR1KvuchARvxQBh8cHg5k9P8XxXMxxzQO3iWogP/ILvQ0LIb1XUdzFd/CWlMcM1f1S2L7PQlZvBCyv2uKimpcTLe5RApcN+WmqI60=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from DM6PR01MB3689.prod.exchangelabs.com (2603:10b6:5:84::26) by
 CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 10:23:21 +0000
Received: from DM6PR01MB3689.prod.exchangelabs.com
 ([fe80::d6c4:a6a0:a804:d7c0]) by DM6PR01MB3689.prod.exchangelabs.com
 ([fe80::d6c4:a6a0:a804:d7c0%3]) with mapi id 15.20.6863.040; Wed, 11 Oct 2023
 10:23:20 +0000
Message-ID: <cfcca2d3-212e-2a90-1acc-1d23105c3804@amperemail.onmicrosoft.com>
Date: Wed, 11 Oct 2023 15:53:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
To: Salil Mehta <salil.mehta@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, imammedo@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com, will@kernel.org,
 ardb@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 mst@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn
References: <20230926100436.28284-1-salil.mehta@huawei.com>
Content-Language: en-US
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <20230926100436.28284-1-salil.mehta@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:610:20::19) To DM6PR01MB3689.prod.exchangelabs.com
 (2603:10b6:5:84::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR01MB3689:EE_|CH0PR01MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbf05b5-a2cf-4d83-444a-08dbca44169f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Huj4VHnScEJ9TFST8Qi2NQSnwPy2Tc4J4SPm+ieX9w2WesOH4JgsPkVfxDhfxuhneSE69TA+Gptx/u2Wc8BInrVwERe92/9z3DaizDqzdJnURS2iuP/JVLkkO9cynq0BUoGTlIQnX84bxCT54WOMzmilQXnliZWIkSq6TtEN688AEQTId3JGgEUqdAmcEGvty5ZeLx2FUShwpIRFyHLZdDJuBYcdlzxaaxvsLNUQdn6tqRc7Y9Z688wNsCKBbjuUmtEUuCH3ZW7u7Qo4WeNFtRsP93aZB5QH/oILBKW5/lBxNkaD9nuDxcxBD2hTHCIPeMngseEg3XyA0mjEyke/HVLV0Yjk11MSgKw80Y4z48BmRielwYJSUYhQQr6ChOAz0Mw/oRhB9jCEKvrDSFnx0qOpe9cN+P5+JeU8oAIAwklDeAxE3yxMJbxKvd+QgWByrITe7EwTlojPIrtEKRfATeVtCdyJIA/FdDafGmWA7sOrttbvV52XN5Udcg7spb6Z8yzSMpYlGz2PjGGDOSjSHIbmxduAUCM2JlxJXH1K7/jAJzGB4mdjdpjYAnlQW9ZdXeMrkaBtmCap/NARzAIlDA6b9srvYrTA1qxhVf6t5oE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR01MB3689.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(396003)(39850400004)(136003)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6506007)(26005)(42882007)(83170400001)(38100700002)(83380400001)(8676002)(4326008)(8936002)(30864003)(66556008)(66476007)(66946007)(53546011)(41300700001)(6512007)(6486002)(2616005)(2906002)(478600001)(7416002)(6666004)(966005)(316002)(5660300002)(7406005)(31696002)(31686004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhscmIyTUFoV0hLTlp5K3NtZEtzc1JOeEtBNENDSjlaSzYyMXlNZ2xpR0Nr?=
 =?utf-8?B?Q0JTS29MU2VEOXMwU1JxTjlsdHVFSWo3QjFjTVVqYi9udGUyN2hRdU5saGJq?=
 =?utf-8?B?L3BQMmJDT244bzh3UkZ2c3FSNkF3NmtEdXVDcDgwRHNrZW1OdzhYUE0vNFhr?=
 =?utf-8?B?di9UeG9UMVZRSGhkTzhqK3NWb0s5N2NPTWFhcm40MVkzTmlxUHovY2E1R2ZS?=
 =?utf-8?B?MmQ5YVNhUS84ck5VNXdnRzJVeXpqbjhWVGw5dHN5ZU9qMjAzb09samt4dWVT?=
 =?utf-8?B?Q2JiUGxjb2tzS0ZuVTV1Umh0T2RxRktYdFdPSG1OS2NaVHU0Z1MzWWdXQ0wv?=
 =?utf-8?B?emZQVkZWTkVsTHJwbjBQWFJuYXg1UnhiMHh2MWZsd1E5aU9MV1VlakpqNjlw?=
 =?utf-8?B?R2tMeTVXVUMwbE05UjlvdS9JLzBISjZIakJMbXBIajhkbDl1S3MvZHh4Y3pl?=
 =?utf-8?B?VWJPV0p6UnJEQkZVb1V0czFhVmkvMUlJSlI3ZHJIa0ZTQWlpU2ZGazkxNUtK?=
 =?utf-8?B?bkR3b1JPQkFOcWNYZjNBSnRXUVQxbDM5b3F4cTZ5U1pWSVc1eVZmaDdRVU5J?=
 =?utf-8?B?MkdCb0xQbUV6ZXBtNlB4UG5HMWp4bWFLYzNvZVgvWU41OS9acUpHSlJ5b1Vr?=
 =?utf-8?B?dFlTNC80NlJpaGJEUVZSbFNmcW0xQmV3MUEzZFZmcEVSdmJIdnUzb1FJeXNI?=
 =?utf-8?B?cTlRd1NVOER2WnJiSzJSUHZUbFZFVzFaT1NpMmJZUExEZlp4eHl1T1pCbjNR?=
 =?utf-8?B?eWxsRGg0S0cvd3psZkswOXYzOFhBeDN6dUI3bDBjVy9RaUFYWGgvNUp0OHJv?=
 =?utf-8?B?WnlCMUFDVk1USm5JMTZOZk5QY3FCMS9helpSU0JvQS9UeklvY3IzYVpjWmUx?=
 =?utf-8?B?ZHRhKzE1ei9kUHBNM1FuTHRxcTQ5SFh6RyswenB4KzgzanNoM0QyYUhvRENF?=
 =?utf-8?B?eXQvZ3dlR1ZZSlNpMHVlVWsxbWUrcnJkV2crUmRPMUdrTWV2bm1XNm5CcnFC?=
 =?utf-8?B?TmM4cDNIY25pdUNWMmxFODYvdlNOSEVGbEZETHE4dVlPSXVDTmRyTFgxam9F?=
 =?utf-8?B?cHlUVEt1Z3IzUmpDY1lBd3NybkNVV2pmZUhJYitxYUJ5em1PZE1ydklybGhQ?=
 =?utf-8?B?YjdrS3YxSk55L3pHOTloLzl1blN1ZmVCWVBXY0VnNldHeWtkdzBJWkJTOXda?=
 =?utf-8?B?QmplQkQ2S1dtLy9KTU1zSWU1QnZNQWxDamFJWERvR2UyQzB6SitLTnVXK1BJ?=
 =?utf-8?B?dk1SOFhtVS93eUluRXZxVEN3WDBNSGpqL0xJZXVLM0pmQ3VsNEhwZTg1ak9J?=
 =?utf-8?B?WUZ4dC9lZWlQVUE2ZFJQV01KbXFpb0xlcHB5cWFpMVJXaUVFaEZMRWMwWUpG?=
 =?utf-8?B?SjJJUmRhYkxUOXJ5R0NLcG4rSFVnYmZiTHBVbitjb2s3NW5ZOE9KditCR0dW?=
 =?utf-8?B?NFBnRHZvSE45N09Fa0JBQjNQQk53N1lzclYyRFZua1hZS3dSTG42eWU4M3N3?=
 =?utf-8?B?Nk5zRW01Z3FsNCtKckFHRVdNRzc2Tnhkd2JIaFdVOUhLRnZUazNBZ1U3KzBZ?=
 =?utf-8?B?bFJPSVZ0L2V6WmlzTVhPdHB3enMrRGFFOUVBbDRjM2Z6TnFTK3o2eGRxMU9M?=
 =?utf-8?B?Tk9hOXZ3ejQ1cWx4UUNubnVOcTlXa01MSjdtT0Z5Q3dCZWg1QS85eG03YVNO?=
 =?utf-8?B?allPZ25qZmFOd3ZUaktkLzZpOW5rSC9TeStSTEZiKzJzOFpsaTA0YjRXVGVS?=
 =?utf-8?B?elpORkdrR0luai9xeUl4Y09IREhPZmprcmJYMXVnY3NIUy9PWGVLOGZWMS92?=
 =?utf-8?B?NkFKVHJNdDg1amJNNGRZZm5heTFoWU1QM2FJZE1pUTVMSWVOamM2RWs3SVA0?=
 =?utf-8?B?S1p0QVF2K1hqZnBna2lkQkxjQ05taFl0OW9GZERGY3dsaitZSWlhUFptTjgy?=
 =?utf-8?B?bGxkQ3QwcEtyQVA3cUNGLzVGNzlyMEEzRUV2NW9MdENZZGd3L2Y5MEV2YjJw?=
 =?utf-8?B?OXRHcXJqeThHaEJHbDA3eGZ5RnMwQlk1VFV6R0QwTjJrRElab0w4eDFteVNH?=
 =?utf-8?B?SFJ6ano5Y2pDa1BmUE1nSVJpb1A4UjFTUllsOG1oWEcyc3l2UndHdW10MFZh?=
 =?utf-8?B?eTcrYldOVklHcHp3RmtQY05XZW51SnFxWDVRRU02QjBIYlF3T2R3RHFkZWpU?=
 =?utf-8?Q?v7yL4sxWmtAtsDUQfkiH8RI=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbf05b5-a2cf-4d83-444a-08dbca44169f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR01MB3689.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 10:23:19.3094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jDVewGElmk2sQ+KaBBftiQkizKimBcW5cqnnDRsjQg4ICvZ6WE466VlAFV7YXeCFncV2qtrBWPSi7kufxf2JSDNBDQ659vfx4vCYfUEASUwhwO1tE/+HrYYLoYPcVG2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7153
Received-SPF: pass client-ip=2a01:111:f400:7eae::700;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-3.339, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URI_DOTEDU=1 autolearn=ham autolearn_force=no
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

Hi Salil,

On 26-09-2023 15:33, Salil Mehta wrote:
> [ *REPEAT: Sent patches got held at internal server yesterday* ]
>
> PROLOGUE
> ========
>
> To assist in review and set the right expectations from this RFC, please first
> read below sections *APPENDED AT THE END* of this cover letter,
>
> 1. Important *DISCLAIMER* [Section (X)]
> 2. Work presented at KVMForum Conference (slides available) [Section (V)F]
> 3. Organization of patches [Section (XI)]
> 4. References [Section (XII)]
> 5. Detailed TODO list of the leftover work or work-in-progress [Section (IX)]
>
> NOTE: There has been an interest shown by other organizations in adapting
> this series for their architecture. I am planning to split this RFC into
> architecture *agnostic* and *specific* patch-sets in subsequent releases. ARM
> specific patch-set will continue as RFC V3 and architecture agnostic patch-set
> will be floated without RFC tag and can be consumed in this Qemu cycle if
> MAINTAINERs ack it.
>
> [Please check section (XI)B for details of architecture agnostic patches]
>
>
> SECTIONS [I - XIII] are as follows :
>
> (I) Key Changes (RFC V1 -> RFC V2)
>      ==================================
>
>      RFC V1: https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
>
> 1. ACPI MADT Table GIC CPU Interface can now be presented [6] as ACPI
>     *online-capable* or *enabled* to the Guest OS at the boot time. This means
>     associated CPUs can have ACPI _STA as *enabled* or *disabled* even after boot
>     See, UEFI ACPI 6.5 Spec, Section 05, Table 5.37 GICC CPU Interface Flags[20]
> 2. SMCC/HVC Hypercall exit handling in userspace/Qemu for PSCI CPU_{ON,OFF}
>     request. This is required to {dis}allow online'ing a vCPU.
> 3. Always presenting unplugged vCPUs in CPUs ACPI AML code as ACPI _STA.PRESENT
>     to the Guest OS. Toggling ACPI _STA.Enabled to give an effect of the
>     hot{un}plug.
> 4. Live Migration works (some issues are still there)
> 5. TCG/HVF/qtest does not support Hotplug and falls back to default.
> 6. Code for TCG support do exists in this release (it is a work-in-progress)
> 7. ACPI _OSC method can now be used by OSPM to negotiate Qemu VM platform
>     hotplug capability (_OSC Query support still pending)
> 8. Misc. Bug fixes
>
> (II) Summary
>       =======
>
> This patch-set introduces the virtual CPU hotplug support for ARMv8 architecture
> in QEMU. Idea is to be able to hotplug and hot-unplug the vCPUs while guest VM
> is running and no reboot is required. This does *not* makes any assumption of
> the physical CPU hotplug availability within the host system but rather tries to
> solve the problem at virtualizer/QEMU layer. Introduces ACPI CPU hotplug hooks
> and event handling to interface with the guest kernel, code to initialize, plug
> and unplug CPUs. No changes are required within the host kernel/KVM except the
> support of hypercall exit handling in the user-space/Qemu which has recently
> been added to the kernel. Its corresponding Guest kernel changes have been
> posted on the mailing-list [3] [4] by James Morse.
>
> (III) Motivation
>        ==========
>
> This allows scaling the guest VM compute capacity on-demand which would be
> useful for the following example scenarios,
>
> 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the orchestration
>     framework which could adjust resource requests (CPU and Mem requests) for
>     the containers in a pod, based on usage.
> 2. Pay-as-you-grow Business Model: Infrastructure provider could allocate and
>     restrict the total number of compute resources available to the guest VM
>     according to the SLA (Service Level Agreement). VM owner could request for
>     more compute to be hot-plugged for some cost.
>
> For example, Kata Container VM starts with a minimum amount of resources (i.e.
> hotplug everything approach). why?
>
> 1. Allowing faster *boot time* and
> 2. Reduction in *memory footprint*
>
> Kata Container VM can boot with just 1 vCPU and then later more vCPUs can be
> hot-plugged as per requirement.
>
> (IV) Terminology
>       ===========
>
> (*) Posssible CPUs: Total vCPUs which could ever exist in VM. This includes
>                      any cold booted CPUs plus any CPUs which could be later
>                      hot-plugged.
>                      - Qemu parameter(-smp maxcpus=N)
> (*) Present CPUs:   Possible CPUs which are ACPI 'present'. These might or might
>                      not be ACPI 'enabled'.
>                      - Present vCPUs = Possible vCPUs (Always on ARM Arch)
> (*) Enabled CPUs:   Possible CPUs which are ACPI ‘present’ and 'enabled' and can
>                      now be ‘onlined’ (PSCI) for use by Guest Kernel. All cold
>                      booted vCPUs are ACPI 'enabled' at boot. Later, using
>                      device_add more vCPUs can be hotplugged and be made ACPI
>                      'enabled.
>                      - Qemu parameter(-smp cpus=N). Can be used to specify some
> 		      cold booted vCPUs during VM init. Some can be added using
> 		      '-device' option.
>
> (V) Constraints Due To ARMv8 CPU Architecture [+] Other Impediments
>      ===============================================================
>
> A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
>     1. ARMv8 CPU architecture does not support the concept of the physical CPU
>        hotplug.
>        a. There are many per-CPU components like PMU, SVE, MTE, Arch timers etc.
>           whose behaviour need to be clearly defined when CPU is hot(un)plugged.
>           There is no specification for this.
>
>     2. Other ARM components like GIC etc. have not been designed to realize
>        physical CPU hotplug capability as of now. For example,
>        a. Every physical CPU has a unique GICC (GIC CPU Interface) by construct.
>           Architecture does not specifies what CPU hot(un)plug would mean in
>           context to any of these.
>        b. CPUs/GICC are physically connected to unique GICR (GIC Redistributor).
>           GIC Redistributors are always part of always-on power domain. Hence,
>           cannot be powered-off as per specification.
>
> B. Impediments in Firmware/ACPI (Architectural Constraint)
>
>     1. Firmware has to expose GICC, GICR and other per-CPU features like PMU,
>        SVE, MTE, Arch Timers etc. to the OS. Due to architectural constraint
>        stated in above section A1(a),  all interrupt controller structures of
>        MADT describing GIC CPU Interfaces and the GIC Redistibutors MUST be
>        presented by firmware to the OSPM during the boot time.
>     2. Architectures that support CPU hotplug can evaluate ACPI _MAT method to
>        get this kind of information from the firmware even after boot and the
>        OSPM has capability to process these. ARM kernel uses information in MADT
>        interrupt controller structures to identify number of Present CPUs during
>        boot and hence does not allow to change these after boot. Number of
>        present CPUs cannot be changed. It is an architectural constraint!
>
> C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural Constraint)
>
>     1. KVM VGIC:
>         a. Sizing of various VGIC resources like memory regions etc. related to
>            the redistributor happens only once and is fixed at the VM init time
>            and cannot be changed later after initialization has happened.
>            KVM statically configures these resources based on the number of vCPUs
>            and the number/size of redistributor ranges.
>         b. Association between vCPU and its VGIC redistributor is fixed at the
>            VM init time within the KVM i.e. when redistributor iodevs gets
>            registered. VGIC does not allows to setup/change this association
>            after VM initialization has happened. Physically, every CPU/GICC is
>            uniquely connected with its redistributor and there is no
>            architectural way to set this up.
>     2. KVM vCPUs:
>         a. Lack of specification means destruction of KVM vCPUs does not exist as
>            there is no reference to tell what to do with other per-vCPU
>            components like redistributors, arch timer etc.
>         b. Infact, KVM does not implements destruction of vCPUs for any
>            architecture. This is independent of the fact whether architecture
>            actually supports CPU Hotplug feature. For example, even for x86 KVM
>            does not implements destruction of vCPUs.
>
> D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints->Arch)
>
>     1. Qemu CPU Objects MUST be created to initialize all the Host KVM vCPUs to
>        overcome the KVM constraint. KVM vCPUs are created, initialized when Qemu
>        CPU Objects are realized. But keepinsg the QOM CPU objects realized for
>        'yet-to-be-plugged' vCPUs can create problems when these new vCPUs shall
>        be plugged using device_add and a new QOM CPU object shall be created.
>     2. GICV3State and GICV3CPUState objects MUST be sized over *possible vCPUs*
>        during VM init time while QOM GICV3 Object is realized. This is because
>        KVM VGIC can only be initialized once during init time. But every
>        GICV3CPUState has an associated QOM CPU Object. Later might corresponds to
>        vCPU which are 'yet-to-be-plugged'(unplugged at init).
>     3. How should new QOM CPU objects be connected back to the GICV3CPUState
>        objects and disconnected from it in case CPU is being hot(un)plugged?
>     4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented in the
>        QOM for which KVM vCPU already exists? For example, whether to keep,
>         a. No QOM CPU objects Or
>         b. Unrealized CPU Objects
>     5. How should vCPU state be exposed via ACPI to the Guest? Especially for
>        the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not exists
>        within the QOM but the Guest always expects all possible vCPUs to be
>        identified as ACPI *present* during boot.
>     6. How should Qemu expose GIC CPU interfaces for the unplugged or
>        yet-to-beplugged vCPUs using ACPI MADT Table to the Guest?
>
> E. Summary of Approach ([+] Workarounds to problems in sections A, B, C & D)
>
>     1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e. even
>        for the vCPUs which are yet-to-be-plugged in Qemu but keep them in the
>        powered-off state.
>     2. After the KVM vCPUs have been initialized in the Host, the KVM vCPU
>        objects corresponding to the unplugged/yet-to-be-plugged vCPUs are parked
>        at the existing per-VM "kvm_parked_vcpus" list in Qemu. (similar to x86)
>     3. GICV3State and GICV3CPUState objects are sized over possible vCPUs during
>        VM init time i.e. when Qemu GIC is realized. This in turn sizes KVM VGIC
>        resources like memory regions etc. related to the redistributors with the
>        number of possible KVM vCPUs. This never changes after VM has initialized.
>     4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged vCPUs are
>        released post Host KVM CPU and GIC/VGIC initialization.
>     5. Build ACPI MADT Table with below updates
>        a. Number of GIC CPU interface entries (=possible vCPUs)
>        b. Present Boot vCPU as MADT.GICC.Enabled=1 (Not hot[un]pluggable)
>        c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=1
>           - MADT.GICC.Enabled=0 (Mutually exclusive) [6][7]
> 	 - vCPU can be ACPI enabled+onlined after Guest boots (Firmware Policy)
> 	 - Some issues with above (details in later sections)
>     6. Expose below ACPI Status to Guest kernel
>        a. Always _STA.Present=1 (all possible vCPUs)
>        b. _STA.Enabled=1 (plugged vCPUs)
>        c. _STA.Enabled=0 (unplugged vCPUs)
>     7. vCPU hotplug *realizes* new QOM CPU object. Following happens,
>        a. Realizes, initializes QOM CPU Object & spawns Qemu vCPU thread
>        b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list)
>           - Attaches to QOM CPU object.
>        c. Reinitializes KVM vCPU in the Host
>           - Resets the core and sys regs, sets defaults etc.
>        d. Runs KVM vCPU (created with "start-powered-off")
> 	 - vCPU thread sleeps (waits for vCPU reset via PSCI)
>        e. Updates Qemu GIC
>           - Wires back IRQs related to this vCPU.
>           - GICV3CPUState association with QOM CPU Object.
>        f. Updates [6] ACPI _STA.Enabled=1
>        g. Notifies Guest about new vCPU (via ACPI GED interface)
> 	 - Guest checks _STA.Enabled=1
> 	 - Guest adds processor (registers CPU with LDM) [3]
>        h. Plugs the QOM CPU object in the slot.
>           - slot-number = cpu-index{socket,cluster,core,thread}
>        i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC)
>           - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>           - Qemu powers-on KVM vCPU in the Host
>     8. vCPU hot-unplug *unrealizes* QOM CPU Object. Following happens,
>        a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event
>           - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC)
>        b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>           - Qemu powers-off the KVM vCPU in the Host
>        c Guest signals *Eject* vCPU to Qemu
>        d. Qemu updates [6] ACPI _STA.Enabled=0
>        e. Updates GIC
>           - Un-wires IRQs related to this vCPU
>           - GICV3CPUState association with new QOM CPU Object is updated.
>        f. Unplugs the vCPU
> 	 - Removes from slot
>           - Parks KVM vCPU ("kvm_parked_vcpus" list)
>           - Unrealizes QOM CPU Object & joins back Qemu vCPU thread
> 	 - Destroys QOM CPU object
>        g. Guest checks ACPI _STA.Enabled=0
>           - Removes processor (unregisters CPU with LDM) [3]
>
> F. Work Presented at KVM Forum Conferences:
>     Details of above work has been presented at KVMForum2020 and KVMForum2023
>     conferences. Slides are available at below links,
>     a. KVMForum 2023
>        - Challenges Revisited in Supporting Virt CPU Hotplug on architectures that don't Support CPU Hotplug (like ARM64)
>          https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
>     b. KVMForum 2020
>        - Challenges in Supporting Virtual CPU Hotplug on SoC Based Systems (like ARM64) - Salil Mehta, Huawei
>          https://sched.co/eE4m
>
> (VI) Commands Used
>       =============
>
>      A. Qemu launch commands to init the machine
>
>      $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
>      -cpu host -smp cpus=4,maxcpus=6 \
>      -m 300M \
>      -kernel Image \
>      -initrd rootfs.cpio.gz \
>      -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2 acpi=force" \
>      -nographic \
>      -bios  QEMU_EFI.fd \
>
>      B. Hot-(un)plug related commands
>
>      # Hotplug a host vCPU(accel=kvm)
>      $ device_add host-arm-cpu,id=core4,core-id=4
>
>      # Hotplug a vCPU(accel=tcg)
>      $ device_add cortex-a57-arm-cpu,id=core4,core-id=4
>
>      # Delete the vCPU
>      $ device_del core4
>
>      Sample output on guest after boot:
>
>      $ cat /sys/devices/system/cpu/possible
>      0-5
>      $ cat /sys/devices/system/cpu/present
>      0-5
>      $ cat /sys/devices/system/cpu/enabled
>      0-3
>      $ cat /sys/devices/system/cpu/online
>      0-1
>      $ cat /sys/devices/system/cpu/offline
>      2-5
>
>      Sample output on guest after hotplug of vCPU=4:
>
>      $ cat /sys/devices/system/cpu/possible
>      0-5
>      $ cat /sys/devices/system/cpu/present
>      0-5
>      $ cat /sys/devices/system/cpu/enabled
>      0-4
>      $ cat /sys/devices/system/cpu/online
>      0-1,4
>      $ cat /sys/devices/system/cpu/offline
>      2-3,5
>
>      Note: vCPU=4 was explicitly 'onlined' after hot-plug
>      $ echo 1 > /sys/devices/system/cpu/cpu4/online
>
> (VII) Repository
>        ==========
>
>   (*) QEMU changes for vCPU hotplug could be cloned from below site,
>       https://github.com/salil-mehta/qemu.git virt-cpuhp-armv8/rfc-v2
>   (*) Guest Kernel changes (by James Morse, ARM) are available here:
>       https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git virtual_cpu_hotplug/rfc/v2
>
>
> (VIII) KNOWN ISSUES
>         ============
>
> 1. Migration has been lightly tested. Below are some of the known issues:
>     - Ocassional CPU stall (not always repeatable)
>     - Negative test case like asymmetric source/destination VM config causes dump.
>     - Migration with TCG is not working properly.
> 2. TCG with Single threaded mode is broken.
> 3. HVF and qtest support is broken.
> 4. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-capable are
>     mutually exclusive i.e. as per the change [6] a vCPU cannot be both
>     GICC.Enabled and GICC.online-capable. This means,
>        [ Link: https://bugzilla.tianocore.org/show_bug.cgi?id=3706 ]
>     a. If we have to support hot-unplug of the cold-booted vCPUs then these MUST
>        be specified as GICC.online-capable in the MADT Table during boot by the
>        firmware/Qemu. But this requirement conflicts with the requirement to
>        support new Qemu changes with legacy OS which dont understand
>        MADT.GICC.online-capable Bit. Legacy OS during boot time will ignore this
>        bit and hence these vCPUs will not appear on such OS. This is unexpected
>        behaviour.
>     b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to unplug
>        these cold-booted vCPUs from OS (which in actual should be blocked by
>        returning error at Qemu) then features like 'kexec' will break.
>     c. As I understand, removal of the cold-booted vCPUs is a required feature
>        and x86 world allows it.
>     d. Hence, either we need a specification change to make the MADT.GICC.Enabled
>        and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT support
>        removal of cold-booted vCPUs. In the later case, a check can be introduced
>        to bar the users from unplugging vCPUs, which were cold-booted, using QMP
>        commands. (Needs discussion!)
>        Please check below patch part of this patch-set:
>            [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled]
> 5. Code related to the notification to GICV3 about hot(un)plug of a vCPU event
>     might need further discussion.
>
>
> (IX) THINGS TO DO
>       ============
>
> 1. Fix the Migration Issues
> 2. Fix issues related to TCG/Emulation support.
> 3. Comprehensive Testing. Current testing is very basic.
>     a. Negative Test cases
> 4. Qemu Documentation(.rst) need to be updated.
> 5. Fix qtest, HVF Support
> 6. Fix the design issue related to ACPI MADT.GICC flags discussed in known
>     issues. This might require UEFI ACPI specification change!
> 7. Add ACPI _OSC 'Query' support. Only part of _OSC support exists now.
>
>   Above is *not* a complete list. Will update later!
>
> Best regards
> Salil.
>
> (X) DISCLAIMER
>      ==========
>
> This work is an attempt to present a proof-of-concept of the ARM64 vCPU hotplug
> implementation to the community. This is *not* a production level code and might
> have bugs. Only a basic testing has been done on HiSilicon Kunpeng920 SoC for
> servers. Once the design and core idea behind the implementation has been
> verified more efforts can be put to harden the code.
>
> This work is *mostly* in the lines of the discussions which have happened in the
> previous years[see refs below] across different channels like mailing-list,
> Linaro Open Discussions platform, various conferences like KVMFourm etc. This
> RFC is being used as a way to verify the idea mentioned in this cover-letter and
> to get community views. Once this has been agreed, a formal patch shall be
> posted to the mailing-list for review.
>
> [The concept being presented has been found to work!]
>
> (XI) ORGANIZATION OF PATCHES
>       =======================
>   
>   A. All patches [Architecture 'agnostic' + 'specific']:
>
>     [Patch 1-9, 23, 36] logic required during machine init
>      (*) Some validation checks
>      (*) Introduces core-id property and some util functions required later.
>      (*) Refactors Parking logic of vCPUs
>      (*) Logic to pre-create vCPUs
>      (*) GIC initialization pre-sized with possible vCPUs.
>      (*) Some refactoring to have common hot and cold plug logic together.
>      (*) Release of disable QOM CPU objects in post_cpu_init()
>      (*) Support of ACPI _OSC method to negotiate platform hotplug capabilities
>     [Patch 10-22] logic related to ACPI at machine init time
>      (*) Changes required to Enable ACPI for cpu hotplug
>      (*) Initialization ACPI GED framework to cater CPU Hotplug Events
>      (*) Build ACPI AML related to CPU control dev
>      (*) ACPI MADT/MAT changes
>     [Patch 24-35] Logic required during vCPU hot-(un)plug
>      (*) Basic framework changes to suppport vCPU hot-(un)plug
>      (*) ACPI GED changes for hot-(un)plug hooks.
>      (*) wire-unwire the IRQs
>      (*) GIC notification logic
>      (*) ARMCPU unrealize logic
>      (*) Handling of SMCC Hypercall Exits by KVM to Qemu
>     
>   B. Architecture *agnostic* patches part of patch-set:
>
>     [Patch 5,9,11,13,16,20,24,31,33] Common logic to support hotplug
>      (*) Refactors Parking logic of vCPUs
>      (*) Introduces ACPI GED Support for vCPU Hotplug Events
>      (*) Introduces ACPI AML change for CPU Control Device
>
> (XII) REFERENCES
>        ==========
>
> [1] https://lore.kernel.org/qemu-devel/20200613213629.21984-1-salil.mehta@huawei.com/
> [2] https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-salil.mehta@huawei.com/
> [3] https://lore.kernel.org/lkml/20230203135043.409192-1-james.morse@arm.com/
> [4] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [5] https://lore.kernel.org/all/20230404154050.2270077-1-oliver.upton@linux.dev/
> [6] https://bugzilla.tianocore.org/show_bug.cgi?id=3706
> [7] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic-cpu-interface-gicc-structure
> [8] https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
> [9] https://cloud.google.com/kubernetes-engine/docs/concepts/verticalpodautoscaler
> [10] https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-autoscaler.html
> [11] https://lkml.org/lkml/2019/7/10/235
> [12] https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
> [13] https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
> [14] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
> [15] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01168.html
> [16] https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
> [17] https://op-lists.linaro.org/archives/list/linaro-open-discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
> [18] https://lore.kernel.org/lkml/20210608154805.216869-1-jean-philippe@linaro.org/
> [19] https://lore.kernel.org/all/20230913163823.7880-1-james.morse@arm.com/
> [20] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gicc-cpu-interface-flags
>
> (XIII) ACKNOWLEDGEMENTS
>         ================
>
> I would like to take this opportunity to thank below people for various
> discussions with me over different channels during the development:
>
> Marc Zyngier (Google)               Catalin Marinas (ARM),
> James Morse(ARM),                   Will Deacon (Google),
> Jean-Phillipe Brucker (Linaro),     Sudeep Holla (ARM),
> Lorenzo Pieralisi (Linaro),         Gavin Shan (Redhat),
> Jonathan Cameron (Huawei),          Darren Hart (Ampere),
> Igor Mamedov (Redhat),              Ilkka Koskinen (Ampere),
> Andrew Jones (Redhat),              Karl Heubaum (Oracle),
> Keqian Zhu (Huawei),                Miguel Luis (Oracle),
> Xiongfeng Wang (Huawei),            Vishnu Pajjuri (Ampere),
> Shameerali Kolothum (Huawei)        Russell King (Oracle)
> Xuwei/Joy (Huawei),                 Peter Maydel (Linaro)
> Zengtao/Prime (Huawei),             And all those whom I have missed!
>
> Many thanks to below people for their current or past contributions:
>
> 1. James Morse (ARM)
>     (Current Kernel part of vCPU Hotplug Support on AARCH64)
> 2. Jean-Philippe Brucker (Linaro)
>     (Protoyped one of the earlier PSCI based POC [17][18] based on RFC V1)
> 3. Keqian Zhu (Huawei)
>     (Co-developed Qemu prototype)
> 4. Xiongfeng Wang (Huawei)
>     (Co-developed earlier kernel prototype)
> 5. Vishnu Pajjuri (Ampere)
>     (Verification on Ampere ARM64 Platforms + fixes)
> 6. Miguel Luis (Oracle)
>     (Verification on Oracle ARM64 Platforms + fixes)
>
>
> Author Salil Mehta (1):
>    target/arm/kvm,tcg: Register/Handle SMCCC hypercall exits to VMM/Qemu
>
> Jean-Philippe Brucker (2):
>    hw/acpi: Make _MAT method optional
>    target/arm/kvm: Write CPU state back to KVM on reset
>
> Miguel Luis (1):
>    tcg/mttcg: enable threads to unregister in tcg_ctxs[]
>
> Salil Mehta (33):
>    arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id property
>    cpus-common: Add common CPU utility for possible vCPUs
>    hw/arm/virt: Move setting of common CPU properties in a function
>    arm/virt,target/arm: Machine init time change common to vCPU {cold|hot}-plug
>    accel/kvm: Extract common KVM vCPU {creation,parking} code
>    arm/virt,kvm: Pre-create disabled possible vCPUs @machine init
>    arm/virt,gicv3: Changes to pre-size GIC with possible vcpus @machine init
>    arm/virt: Init PMU at host for all possible vcpus
>    hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>    arm/acpi: Enable ACPI support for vcpu hotplug
>    hw/acpi: Add ACPI CPU hotplug init stub
>    hw/acpi: Use qemu_present_cpu() API in ACPI CPU hotplug init
>    hw/acpi: Init GED framework with cpu hotplug events
>    arm/virt: Add cpu hotplug events to GED during creation
>    arm/virt: Create GED dev before *disabled* CPU Objs are destroyed
>    hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>    arm/virt/acpi: Build CPUs AML with CPU Hotplug support
>    arm/virt: Make ARM vCPU *present* status ACPI *persistent*
>    hw/acpi: ACPI/AML Changes to reflect the correct _STA.{PRES,ENA} Bits to Guest
>    hw/acpi: Update GED _EVT method AML with cpu scan
>    hw/arm: MADT Tbl change to size the guest with possible vCPUs
>    arm/virt: Release objects for *disabled* possible vCPUs after init
>    hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>    arm/virt: Add/update basic hot-(un)plug framework
>    arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
>    hw/arm,gicv3: Changes to update GIC with vCPU hot-plug notification
>    hw/intc/arm-gicv3*: Changes required to (re)init the vCPU register info
>    arm/virt: Update the guest(via GED) about CPU hot-(un)plug events
>    hw/arm: Changes required for reset and to support next boot
>    physmem,gdbstub: Common helping funcs/changes to *unrealize* vCPU
>    target/arm: Add support of *unrealize* ARMCPU during vCPU Hot-unplug
>    hw/arm: Support hotplug capability check using _OSC method
>    hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled
>
>   accel/kvm/kvm-all.c                    |  61 +-
>   accel/tcg/tcg-accel-ops-mttcg.c        |   1 +
>   cpus-common.c                          |  37 ++
>   gdbstub/gdbstub.c                      |  13 +
>   hw/acpi/acpi-cpu-hotplug-stub.c        |   6 +
>   hw/acpi/cpu.c                          |  91 ++-
>   hw/acpi/generic_event_device.c         |  33 +
>   hw/arm/Kconfig                         |   1 +
>   hw/arm/boot.c                          |   2 +-
>   hw/arm/virt-acpi-build.c               | 110 +++-
>   hw/arm/virt.c                          | 863 ++++++++++++++++++++-----
>   hw/core/gpio.c                         |   2 +-
>   hw/i386/acpi-build.c                   |   2 +-
>   hw/intc/arm_gicv3.c                    |   1 +
>   hw/intc/arm_gicv3_common.c             |  66 +-
>   hw/intc/arm_gicv3_cpuif.c              | 265 ++++----
>   hw/intc/arm_gicv3_cpuif_common.c       |   5 +
>   hw/intc/arm_gicv3_kvm.c                |  39 +-
>   hw/intc/gicv3_internal.h               |   2 +
>   include/exec/cpu-common.h              |   8 +
>   include/exec/gdbstub.h                 |   1 +
>   include/hw/acpi/cpu.h                  |   7 +-
>   include/hw/acpi/cpu_hotplug.h          |   4 +
>   include/hw/acpi/generic_event_device.h |   5 +
>   include/hw/arm/boot.h                  |   2 +
>   include/hw/arm/virt.h                  |  10 +-
>   include/hw/core/cpu.h                  |  77 +++
>   include/hw/intc/arm_gicv3_common.h     |  23 +
>   include/hw/qdev-core.h                 |   2 +
>   include/sysemu/kvm.h                   |   2 +
>   include/tcg/tcg.h                      |   1 +
>   softmmu/physmem.c                      |  25 +
>   target/arm/arm-powerctl.c              |  51 +-
>   target/arm/cpu-qom.h                   |   3 +
>   target/arm/cpu.c                       | 112 ++++
>   target/arm/cpu.h                       |  17 +
>   target/arm/cpu64.c                     |  15 +
>   target/arm/gdbstub.c                   |   6 +
>   target/arm/helper.c                    |  27 +-
>   target/arm/internals.h                 |  12 +-
>   target/arm/kvm.c                       |  93 ++-
>   target/arm/kvm64.c                     |  59 +-
>   target/arm/kvm_arm.h                   |  24 +
>   target/arm/meson.build                 |   1 +
>   target/arm/{tcg => }/psci.c            |   8 +
>   target/arm/tcg/meson.build             |   4 -
>   tcg/tcg.c                              |  23 +
>   47 files changed, 1873 insertions(+), 349 deletions(-)
>   rename target/arm/{tcg => }/psci.c (97%)
Tested on Ampere's platform for vCPU hotplug/unplug with reboot, 
suspend/resume and save/restore.
Also tested for vCPU hotplug/unplug along with VM live migration.

Please feel free to add,
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>

Thanks,
Vishnu

