Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A27E6C42
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:13:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r15fw-0006KE-Au; Thu, 09 Nov 2023 09:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1r126A-0004Yr-HC
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 05:17:20 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Santosh.Shukla@amd.com>)
 id 1r1267-0005Yl-S5
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 05:17:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJQfXuWbr+zW3xIj79x8fitjttxwYr6Va/bxHiyqRQpoSJOmQxeaPRTV5Y+6x3HS+2Lh8fx1PRnDzAagekZCmuvPwN/izJwoMDmZ6zBmKlCgLPnh74XjYqjekGZMDq3Rd4Pvk39v8XxKLA3Gd1NY3dUh9TwAi7+qgoGYwYi0gUFDIBCImuo0fqLJJU63wf8HG05LND4kWXA2886RI7Line9aozsdbxJIf/OMrs15+ltETgHnPEW5QUWE2NGB6k29+aTkJ8CwhX42znBtoItUhPjuh4sOOaaeqN3QqsqS3I8W0NhsKszdLmvk6rwftQ++VXn+dnfQAbqyBgx5ihXxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LquPhbiXbVifjIU86tDBcWiLQ08rD6dDPFQMBUyC40s=;
 b=aaU/eBkX8ZVBMDR0tHEeCLNZ7hrwghGrwjuaB42EFi5/X2jzE5zSSnesqCdTQ6rCoW2+F1dB/1CQoaXDdzUytw5kzi798Em4F+N9fYUNMa+/jF/ilESG6wCTaZFGuN/Xpky+VFq5avOAk9pOCNdisMQJCDd6a8ql5xfr6sUir2CyaiLsZFJWJhq4sXBSCUXg2oo9X8lDdwftkQnXjlw6glRMLHJBiAgwV0Bs/7UYPDeg0UFgJqtZCQLHhU+YrlCNl4NOkJksoUy9dAoxmZdcfPmFglNB21+HG6Ej/DUN9Ci1Wpl9nt4Qo5x6nEmSBA0WDBZ+V1W6BnJ5AGlXHwEhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LquPhbiXbVifjIU86tDBcWiLQ08rD6dDPFQMBUyC40s=;
 b=XEz5ypCe4rkJVtlg+XonTv2tNZhqe4dxpiGFL1r4XvrpwA6rn6A6vSQrb2GTExqlPWh4a7ycd8Hv9iEeixgUd+YOKyeWRR76fM2iq71oznoYQ4MpMoYQOng1Mct54beOt+fMlPIaKO7UyZb40b4hsJzVBydDJI4vZyqeH9lIsZg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11)
 by SJ2PR12MB8874.namprd12.prod.outlook.com (2603:10b6:a03:540::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 10:12:10 +0000
Received: from CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::13ec:1cba:876:cf40]) by CY5PR12MB6323.namprd12.prod.outlook.com
 ([fe80::13ec:1cba:876:cf40%6]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 10:12:09 +0000
Message-ID: <8bbae7b9-3923-b5cd-ff89-50baeccb5d02@amd.com>
Date: Thu, 9 Nov 2023 15:41:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 0/5] Support x2APIC mode with TCG accelerator
Content-Language: en-US
To: Bui Quang Minh <minhquangbui99@gmail.com>, qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Joao Martins <joao.m.martins@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <20231024152105.35942-1-minhquangbui99@gmail.com>
From: Santosh Shukla <santosh.shukla@amd.com>
In-Reply-To: <20231024152105.35942-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0212.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::11) To CY5PR12MB6323.namprd12.prod.outlook.com
 (2603:10b6:930:20::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6323:EE_|SJ2PR12MB8874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc35956-e670-4755-3d55-08dbe10c559e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aD6ctCLJHGfqxyroe1oMW1W5bAEgeSR4925s9UCrvK/sYZqxgllqZEWEYzdGOJGbXyyJXAqjattXyKKMzYPKF/0vWLJ1rcrW+Zko95q/m+gKRB0iVC6WseynB+SO0tle6pLWyTk9Uyh+QscphXbEKG5uMIFJlGzmqSNP+Oyrg4TqZcpoRvRUvmEiyamwx9GAt+A63Sq3RRmoOv/G2K7uB4lET2gCuWjoi9FFpWUDuEDnIt7BmvSdlp88wNtBzvb8TxeDvn5jNr1+McfzOE79iB8805A1ovqtUpKPDFbUPJXTbhU4wy0wBRiNaXGKwMF2EGmWbsmuBJutyMbdoJoGYrOaa4jKNeJfrihP4rrL6TwYdCLS3YLsW0qNXlbl+vLuKbctS5soSz0SuoBv7v3nf4AZ900jn4/d44PPhLczjY5iN9Vy65WrI5ossn9MCBGu+JAAqwTmxu7oaoIgawXqu/psynne0fKEEeVbUCJBjhOqsa6Azj12rG66Hshr5xLWgdJAWxX0fkQuEOilGCI1XvAdz9uhAhRN98Wv3kRg1P+j9kqRFReHg1+Z7znm/mL+Rbue6Eh26uPIUqyqeREInMMS607E6CFicFoVfinMqKImC03zl2tw3LwvROU/5EawE9zMJyJVYyCC4rH2lLgCVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(316002)(8676002)(8936002)(36756003)(41300700001)(4326008)(2906002)(31696002)(38100700002)(5660300002)(53546011)(6486002)(66556008)(6512007)(66476007)(54906003)(31686004)(86362001)(7416002)(44832011)(66946007)(83380400001)(26005)(2616005)(6666004)(6506007)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdjVkgrRXpJUktpQXJjOHovYU5BNG0vMXcwemxPRVRmaVhsSmRLQm5GNDV1?=
 =?utf-8?B?blZIdGl5dlNNaklUNlJHNVU0Rk91SVRDMjV4cnhoQktUd0hRWEVMRURRbmdM?=
 =?utf-8?B?d2VMUURwWjdXRzgzTzJ3My9vYk0zb0tCSHlrOVRpb2FZZy9HcXZhWm5qTk1t?=
 =?utf-8?B?R2Npbmg4dFl6K1gzRGVtVVdtT0R2MU5Ma3JHUWdDR3NnSTdaejVDbnJKb2Jz?=
 =?utf-8?B?T3F4cFQ0OHhZYkJpcDRZNkNxOVFibUtvTlhXQnR4MWR3enhIVlBIbUF2eTZN?=
 =?utf-8?B?U3dRc0IwWXhURzkyNGR6MDVpZkhDWmc1M2Q3Q1RuS0FqNmxmT29POHpCaDBC?=
 =?utf-8?B?Umx1cDFpdGhJSThBSTVPSExLWk1IRkErcTFzbEU1V0h2Y3JyTWxxVzFlTWgy?=
 =?utf-8?B?ZUI5UExyR0xqTFhxYkNFZUMxNGhDRkFhS0NsaG8zcythWmZqNy9tQ1dZNjlk?=
 =?utf-8?B?dUhIOFRVY3k0VGVpdHFJN3hKV2ZsbHFBVFEyWUJ1Smg0cTF6WVI2am9xdmQ1?=
 =?utf-8?B?cjVpdTZiNU5rZVU2MDVZSnJmNWtiN3dhL1pEa3o2cGJnRlBNYU1NeFpqaHpZ?=
 =?utf-8?B?SGhlaUcycEdDR1ZMbXRLS1lSRVMrbkgrdTNCTEpBS2xUeWFOcC9sWm9UWEJJ?=
 =?utf-8?B?R3lwL2RlVWxxamE5UDQrZHZZWTlqb0p2M2lML2F6dVVaOFo5ZXhyUkN2cEo1?=
 =?utf-8?B?dXRJNzM2elhLRzcyU1hoZThuQlViQTBHM0VVdzNVRzF6dWpsNnAyTlZwbFpu?=
 =?utf-8?B?TWFMc3RlWUhwZm5ZRE5Ja1ZqUjZCSGk4d1Q2R3MrV2ZnZHlzVjBaZWRWQkJj?=
 =?utf-8?B?SlJhaGo0MG93aGhzMDRQZXdtNE5xRTgwY25jdm1kZzVKNmNDRXdGMllhVmpE?=
 =?utf-8?B?cGpQREdwSkNGM3JSY1dYNk93bU9SNnMwU01qZjVXakVaOXkvdW84YVJYdlI1?=
 =?utf-8?B?NFNOeXlObkhLOU1KZVVEbDM1dmRNdVBjNTJrU25sQlc4TFgvVjc0Zno2WnU4?=
 =?utf-8?B?SlZMS3FxN01pZm13T0tSajRGSGxKUnNzbUtRdENaRzR3SVBRaFBrOEJoSUh1?=
 =?utf-8?B?ZFhrbFptSkVMWFR6VUtScHpwMDhYVzBoMmU4RUNtQURsaURmbDcyamZadWRj?=
 =?utf-8?B?UGhtc2xqOFlIekVFb0dnSkpKckFRWHl1QXJvT28zYW0wWjVqcVUxZ1g5U3R1?=
 =?utf-8?B?Q2RXdkI1ZnY4VXkxaENpa0FqTWR6MWNsdEZyNVhNYXU1Kzd0NWRiNDZLMmQz?=
 =?utf-8?B?VXRQd1RMNVRQZ09qL0Y0SXRHaEMyajY3UXRvUVVFcFhVR0dlY3ZXT0t4Y2F3?=
 =?utf-8?B?d0dzNEFZWUhKZWI5SWdyeWdiSUJOanBXMVhTM2VKc3VkUXQvSDVDc0R3VDBR?=
 =?utf-8?B?NTlvWGlocCtIVHlIUWVublQxYklrMGJ2TGpHNGg0WHVUSjNtNWREMzlISy9q?=
 =?utf-8?B?RUcrMmpFUXF4S1IzN2NkOGpzd0JteEJmejhMd1luT05MSTFXY09xNGJlN0pW?=
 =?utf-8?B?Z0RCSWhCN2hhazZ5TEJLL1p2M2ltaDBuL2x4eGVIOHMrVWlrb1hOM1MyS2ZW?=
 =?utf-8?B?ZmhwRThYWndTRTFKRDlONGpDZ1d1Y3cxOXdMaTNmZVNSVkl4UjNqV0VzeXhr?=
 =?utf-8?B?aS9vKzl6UDhtZVp0NVpzQjBuVlpiVDFRakJDUCt0YkdoNGlnYnlTajBLWGxS?=
 =?utf-8?B?YUNJaS93b3B1WXM4eUdXYkh6T2pMNnJScC9tVmVnQWtrbktkdVRWeWdIblkr?=
 =?utf-8?B?Q3FyN0dzUk5RNWNDNTRTNjdJNzJyQ1dDc2dHOHJhN2R3aHovQnJXTXp3c3Vp?=
 =?utf-8?B?SDd1Q1BUODJiNjNvRGg2c2FQbEpObkQvQzMzVFhDUHlVSVdubEJQa1drTUI1?=
 =?utf-8?B?QXhYblgvbGZDc0NDZmY2N1NDVEFaMHU4aTJxbzVSc1lOL0VBRXNFU0ZYQzUz?=
 =?utf-8?B?NzFQQjFEMFF5eklxOTJlUGhmU2c4eEFnRndQamFUOWxMWVltWWpNTHpabk1K?=
 =?utf-8?B?QXBXdE1BT09wWERpTng4ekViRTVBTFRvaUdxRVMyS0VhL2dEY0NuUk9sMXlo?=
 =?utf-8?B?VDdURWN0QUh4QTV6UlBaWHI1ZHI3b2JDNnB0eHBRTmdWNnMxWVZ2RTZtU2J0?=
 =?utf-8?Q?DD+KY1AnD9jkyNEqwsO8HMcD7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc35956-e670-4755-3d55-08dbe10c559e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 10:12:09.8867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9o6FjzQTG2X0CZEgH32QuMZOeNhkcGmJMyhaG2ZtQdtWqB2n95IZGfA0B+1yr1s0y/JCqYLl0/vV9RI6cqG+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8874
Received-SPF: softfail client-ip=40.107.236.41;
 envelope-from=Santosh.Shukla@amd.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.277, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Nov 2023 09:05:20 -0500
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

On 10/24/2023 8:51 PM, Bui Quang Minh wrote:
> Hi everyone,
> 
> This series implements x2APIC mode in userspace local APIC and the
> RDMSR/WRMSR helper to access x2APIC registers in x2APIC mode. Intel iommu
> and AMD iommu are adjusted to support x2APIC interrupt remapping. With this
> series, we can now boot Linux kernel into x2APIC mode with TCG accelerator
> using either Intel or AMD iommu.
> 
> Testing to boot my own built Linux 6.3.0-rc2, the kernel successfully boot
> with enabled x2APIC and can enumerate CPU with APIC ID 257
> 
> Using Intel IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>   -smp 2,maxcpus=260 \
>   -cpu qemu64,x2apic=on \
>   -machine q35 \
>   -device intel-iommu,intremap=on,eim=on \
>   -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>   -m 2G \
>   -kernel $KERNEL_DIR \
>   -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>   -drive file=$IMAGE_DIR,format=raw \
>   -nographic \
>   -s
> 
> Using AMD IOMMU
> 
> qemu/build/qemu-system-x86_64 \
>   -smp 2,maxcpus=260 \
>   -cpu qemu64,x2apic=on \
>   -machine q35 \
>   -device amd-iommu,intremap=on,xtsup=on \
>   -device qemu64-x86_64-cpu,x2apic=on,core-id=257,socket-id=0,thread-id=0 \
>   -m 2G \
>   -kernel $KERNEL_DIR \
>   -append "nokaslr console=ttyS0 root=/dev/sda earlyprintk=serial net.ifnames=0" \
>   -drive file=$IMAGE_DIR,format=raw \
>   -nographic \
>   -s
> 
> Testing the emulated userspace APIC with kvm-unit-tests, disable test
> device with this patch
> 
> diff --git a/lib/x86/fwcfg.c b/lib/x86/fwcfg.c
> index 1734afb..f56fe1c 100644
> --- a/lib/x86/fwcfg.c
> +++ b/lib/x86/fwcfg.c
> @@ -27,6 +27,7 @@ static void read_cfg_override(void)
> 
>         if ((str = getenv("TEST_DEVICE")))
>                 no_test_device = !atol(str);
> +       no_test_device = true;
> 
>         if ((str = getenv("MEMLIMIT")))
>                 fw_override[FW_CFG_MAX_RAM] = atol(str) * 1024 * 1024;
> 
> ~ env QEMU=/home/minh/Desktop/oss/qemu/build/qemu-system-x86_64 ACCEL=tcg \
> ./run_tests.sh -v -g apic
> 
> TESTNAME=apic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/apic.flat -smp 2
> -cpu qemu64,+x2apic,+tsc-deadline -machine kernel_irqchip=split FAIL
> apic-split (54 tests, 8 unexpected failures, 1 skipped)
> TESTNAME=ioapic-split TIMEOUT=90s ACCEL=tcg ./x86/run x86/ioapic.flat -smp
> 1 -cpu qemu64 -machine kernel_irqchip=split PASS ioapic-split (19 tests)
> TESTNAME=x2apic TIMEOUT=30 ACCEL=tcg ./x86/run x86/apic.flat -smp 2 -cpu
> qemu64,+x2apic,+tsc-deadline FAIL x2apic (54 tests, 8 unexpected failures,
> 1 skipped) TESTNAME=xapic TIMEOUT=60 ACCEL=tcg ./x86/run x86/apic.flat -smp
> 2 -cpu qemu64,-x2apic,+tsc-deadline -machine pit=off FAIL xapic (43 tests,
> 6 unexpected failures, 2 skipped)
> 
>   FAIL: apic_disable: *0xfee00030: 50014
>   FAIL: apic_disable: *0xfee00080: f0
>   FAIL: apic_disable: *0xfee00030: 50014
>   FAIL: apic_disable: *0xfee00080: f0
>   FAIL: apicbase: relocate apic
> 
> These errors are because we don't disable MMIO region when switching to
> x2APIC and don't support relocate MMIO region yet. This is a problem
> because, MMIO region is the same for all CPUs, in order to support these we
> need to figure out how to allocate and manage different MMIO regions for
> each CPUs. This can be an improvement in the future.
> 
>   FAIL: nmi-after-sti
>   FAIL: multiple nmi
> 
> These errors are in the way we handle CPU_INTERRUPT_NMI in core TCG.
> 
>   FAIL: TMCCT should stay at zero
> 
> This error is related to APIC timer which should be addressed in separate
> patch.
> 
> Version 9 changes,

Hi Bui,

I have tested v9 on EPYC-Genoa system with kvm acceleration mode on, I could
see > 255 vCPU for Linux and Windows Guest.

Tested-by: Santosh Shukla <Santosh.Shukla@amd.com>

Thanks,
Santosh

