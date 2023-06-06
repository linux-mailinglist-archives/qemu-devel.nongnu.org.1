Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7B725089
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 01:13:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6fqi-00036O-3Q; Tue, 06 Jun 2023 19:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6fqg-00036B-3V
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 19:12:22 -0400
Received: from mail-dm6nam10on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::61e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vikram.garhwal@amd.com>)
 id 1q6fqd-0004il-Gp
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 19:12:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrjEweLLAfbQPoVyQtePMkIgfolbnbAKQEwAqa3kCFJ87PcnMuKZZfz+UPtPUGVYHdmeHnqCaWftlikjNGT7ZAJ3zCZvwcO/DGY/FBrNEHlbFjj+QmioRWQIGk6iFH+A5tYQQ6ep79mZpEdfuNhtsJHsGLrbr1ZNuWeBaJAPJZoBpVQ+Ka22anxsC5ToED5j4zVAttTxSR1csTp4/uuJTT1W8dxZ7YZMPmXvdhLOOnAjKUmoPkkydPaDroXi5yIUzFaCypEq6cabux2gzWcCfTyGRzkuvNHkGvDdREsB/cW+XMhEdH4ztPWfgIOmEeImrHFT1yoWDor1WKHcFQhIbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P/7Aq715XFQow+uS7knKKLCgaJCfimG8gt/Cdg7Udo=;
 b=DxohRz0pDfqA5zFbFIMeOOPezjqTcJ4DYzEmT6smCjchE/OT29dCsvmhOPqL1jsl/KcIUIOYvGSGV9xJNewz2j7SiMGTeDxdi9szxF9pE4I94flwp0N+nx0KeM05yUjwYFxkSp9XyUmqgl00hVVhOVvntOw8sbQU/YPRgo7Ryem1JY+sDuMvQdkHCdRshpsOKT3u754N0g8vo5geamdftSjzGz7Yqkc0bT6LHLazdX7hpFN/CUBxmjsI4knVHeOueTqjCdCYF19Xz2um2JV9nKdrhmKdbXxzbvXO3jIqBazUPi96eIF2tjWBPBW2Yo3kZKMeeJdqOM0Z2IgC8UrrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P/7Aq715XFQow+uS7knKKLCgaJCfimG8gt/Cdg7Udo=;
 b=mkHmTxK2zH16EzoYYLT0tut65P1P2EQ0hctlpZfkZqcUvJk2Ykvx7m71TFmK7B2KtQ5vvjOd+792jAZHEBaa3nuzrdfAOKxhFpUuQqI+I5Wy2xxSs1E8ifAhCYkF69KNrdmiNx/IokswvJm1RZHOdkZ0uWwcsOcIs/NgQ7NaJO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4409.namprd12.prod.outlook.com (2603:10b6:303:2d::23)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 23:12:12 +0000
Received: from MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e]) by MW3PR12MB4409.namprd12.prod.outlook.com
 ([fe80::1182:e204:82d8:a4e%4]) with mapi id 15.20.6477.016; Tue, 6 Jun 2023
 23:12:12 +0000
Message-ID: <bab9cd3d-c1bb-343c-f80f-b90fb11cef60@amd.com>
Date: Tue, 6 Jun 2023 16:12:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PULL v3 0/10] xenpvh3-tag
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <alpine.DEB.2.22.394.2305021708010.974517@ubuntu-linux-20-04-desktop>
 <a01d5ddf-b6b3-7fc7-daef-44debf48ca77@linaro.org>
 <1f6b3666-fc7e-083a-50fb-b2e91ac2c012@amd.com>
 <dd7325e0-7db1-3b1f-7ce1-319aa58ebd1f@linaro.org>
 <MN2PR12MB440877291659B9B55ADC0CF79F52A@MN2PR12MB4408.namprd12.prod.outlook.com>
 <7465b3c6-ecf9-bf17-2504-2338bbef27b7@linaro.org>
From: Vikram Garhwal <vikram.garhwal@amd.com>
In-Reply-To: <7465b3c6-ecf9-bf17-2504-2338bbef27b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0090.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::31) To MW3PR12MB4409.namprd12.prod.outlook.com
 (2603:10b6:303:2d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4409:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf5aad9-c986-4052-9421-08db66e375a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBJyqHOHPSmnlvhJWNPHmhHfPKRqKTuQLazdIuuF4Ol77k5qtNjee1PdomuB+8jhKK1fPKxt9zbjfW1SANYjb96Zxl/2wGwyJseR0vzyZvfj33Lyrixu/XQy958c9xuknuGq7dfgq+0hQTX90zXlC9+VFiFWOEoy5Lo1K/yascHRR16dux5H5unvE9TPfahalbvA4F9azWqb5hvwZLHa8aPluibC8pNixGCs2kpP7noqNJWIqJRDjN7TwdMOebZhz+JS9iB2vZOszE2bNXmRKzf2HDUfsQqJQPBntKif/VKhNwPoG/BnPYv/SOUa+7hM9l+NDgmxjINCgsfedZcvrb5XlDidgfSWzZHYg8Y+TlFfgt5x8wWUsVcon1W+uPFWCsCrFmgPMSp5typQEcGKIXF2B7XfotTc3zXVCe/XM1mYrXT1E7SbTC1PWOqGMky6FV0OkQD4RYKnY7DrO2qBKW4wFMDRpAi0DzlpUCsDjFEKprM1LcbqpAVjDtVGpQOpBQhrDxkV5dmo7kJoDLExtA1itL2Jh4vh+Eweq8aYb2TChcLTNvZMCGeQv8b3OnYMJ6trHZs/8g7wEnfCb5yu5X3ylgQQcJ6Y2rG3YfgXkND3MScsHXuyi9p88G+7LgRo34mXQVNs/2MzmAfZ56fm0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4409.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(186003)(6506007)(6512007)(26005)(53546011)(2616005)(31686004)(966005)(83380400001)(86362001)(6486002)(6666004)(36756003)(2906002)(8676002)(8936002)(44832011)(110136005)(478600001)(38100700002)(5660300002)(4326008)(31696002)(316002)(41300700001)(66556008)(66946007)(66476007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjhGOVIrNTBzSTcwdjl0ZlhHNDZxcWFWSXVURXprdzhpYTR3UEdCdGxLZWhE?=
 =?utf-8?B?aFhmTm9TUHMrNk9vM212OUl0VkNyaHZRQ0hYTVZ1WmdKUWdDbUtzSDkzRE1E?=
 =?utf-8?B?blg5aUVHelNnREtOYitNRU5renJVNVBmMEh1R0tvc3FhcmhNNllaNnErZmtF?=
 =?utf-8?B?d1FJMWowcE9jd0tzQkF1VkdnbUhWUGF6VlFuU1VjMFQ4VGhBSU1seE90c1ZI?=
 =?utf-8?B?dnpQRnU2OGNHVGhFd2lCTXIyQzdBRFRjejR5NitKOCtCN3FRcERSbzNLTSsy?=
 =?utf-8?B?NnMyRHRub1A0V2FFOEFKTHZvYXdnOUZNS240L3VOdkdjQnQxYWJuVjRpUnAr?=
 =?utf-8?B?M3B3UVZ5MFR0UDU5VnY5QkIrVjUxNlVwZUM5dFZwMm0rWHY1RE1ST3pzRWlK?=
 =?utf-8?B?ZFFxY0lnK01JN1RLQmhwam91R3ZXTC9YaEg1TmRrb25KbWF1K09jLzhjcGNj?=
 =?utf-8?B?dERMd3ZFMnBwY3Z6WTdsUGdBKytTWi91RjRaSUc5eit5MWdIWWNhTVJ0Zm9Y?=
 =?utf-8?B?dFptaDJZQXpORk1YUXBJZmpoc202QUlBUFI5MFJuMWV3NUI2K3FDNWYzRzdi?=
 =?utf-8?B?YWNEeCtDMUlPL2Ivajl3UEVnV3RxNWhQdDgyVFR1bGNBOUs3ckdBcnp5TEtr?=
 =?utf-8?B?d0ZRU1ZqM3BCTXZKaWdPM2wvMmtXUGh3SnFwaFFhTmJVNmFtZENmRlY2TEVF?=
 =?utf-8?B?cHBBQkxpc1ExOGZmSkFFZTVnbTl0bDQ5WkorRWgvVUNQNXZxUFFyNUJ4cW4r?=
 =?utf-8?B?ck9TS2ozUWxUUGo0OFVXWExoY1YwdGFzWm5tWkplREh5NTV6WTdodzhBSGRS?=
 =?utf-8?B?d1Y4Tk53bXdMMHZ5aUdQRGJCaDh2emRWYmEvTHNoU0JtcStDVXpuY0hJMzBl?=
 =?utf-8?B?QmNXQ0hXU3BNOWQ0RSt6OTdNOGxhb2ZkRWRBTWpjOU9KRmw1cmxJMW1rZXpP?=
 =?utf-8?B?UWlBWUJDS2c0T0luYkpxWjNUdTNiWHBoVHZyTGpNeForU0d5UmNEazJ6Nks2?=
 =?utf-8?B?UjVmV0JQLzZ4aUkzYUU2NkJScDBYS0JhRjd0Qmp5RmxIclZOV25yeEJ1RURa?=
 =?utf-8?B?T2lRcDJSd1JtRGY2eDVYVzJ0cVFGZWtrOGZVZ0lheEthclVYOEx4YTBJMURU?=
 =?utf-8?B?cXR6UGpLcElvWlEvcU96cXR2K29KcTZRQTkrSFRaMkZyRzNydjBndkFHZlY0?=
 =?utf-8?B?d3dpdEJuL1lWQm0rU1d5VWR6eFVORnAybzlLMW5MQ3dQT1RtS05vTjV3Ykkx?=
 =?utf-8?B?RGhYemdyYU8rMWsrZjJtR3UrU3lNazNTMG9RQ2dXOWhrR2ZWakFFM0Z5Ti9t?=
 =?utf-8?B?NlBxQTliRUFiSnpFWTJPUlNiZXdCb3dsNnNtaUxMQWEvTjBBTjA5R2xuZ1FU?=
 =?utf-8?B?VkZYRzRZT2tMRDVhLzB6Nm1pOHlkdVpmRHBVQ1JiVUI5MXcyMHlnb0ZZVzJP?=
 =?utf-8?B?WE81eFRucTJ3djJQSDZxU1RiTnNMMnZWTzYrNGh3WEJSNmJSM0xmb0QvZVJa?=
 =?utf-8?B?MFRGdlZ0MzYrTEN4WS9iMy83Tk12QmFLWGE3Yzk3MDVwT3VyYWdyZlVIS3VJ?=
 =?utf-8?B?d1UwYzNvTGN5MFY2L2hQTHBTcDEzdFBiTVprb3k2YmlNMjFlVFhibmhXTSt3?=
 =?utf-8?B?WmdIYTVOOGdnTXVsTDdZU2lDWHdmOGhzQW1OYS85b2x4aVNncHE4VFd1Y1Jv?=
 =?utf-8?B?d1Z1SmRGbjF0MmNZQ3F3WS9DMkdPejczdE94Y3EyV3l0cjZUNktvR2hvMXgv?=
 =?utf-8?B?NFJYaEY3TktQY2prditnSWdhTFJlQm4yM2ZtcFlSWUwrS3I2MjNRQUZPd2lz?=
 =?utf-8?B?bmJPakxFbXFyVzgwRVlaNyt0cTJWczJpMDFuMVZRcXo2U2JRdFUvZ3Rma3JN?=
 =?utf-8?B?bnJXb2dLVmhMZFFpWGFaSDdBOEdrVFIwVjdIeVVDL2JkMXVoZHRUa2xBeUdz?=
 =?utf-8?B?WHhOWHFIYWp0bVpNbmtTQWh1VUdieVh4M0kxbFZ0RlZYV21yc3ppUzVpVnFO?=
 =?utf-8?B?R0sxbG1VdzQ4T09weHYrV0tpOFV5VmdVTmNrWC8reGdUOFZXMHRmN3o3ajln?=
 =?utf-8?B?R0MrajNueG94NnJWWS9KZHlxOUtzVkxjcTdZNmtmaXpBbEdMWmdzZ1MrYTZK?=
 =?utf-8?Q?VFs0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf5aad9-c986-4052-9421-08db66e375a7
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4409.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 23:12:12.2191 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTBxFwL+f0HZ6obnTNMXOL6DXZVPd7yn6ySNYsdPx8xdPfdzQaEql0QLgedFslOzOoDqhsR1hB0LJQ6CHdlFlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
Received-SPF: softfail client-ip=2a01:111:f400:7e88::61e;
 envelope-from=vikram.garhwal@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 SCC_BODY_URI_ONLY=1.439, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



On 6/6/23 3:50 PM, Richard Henderson wrote:
> On 6/6/23 11:51, Garhwal, Vikram wrote:
>> Hi Richard,
>>
>> I fixed the tsan-build issue but now seeing another issue with 
>> “—disable-tcg” option for cross builds xen. Here is the build failure 
>> message:
>> "include/tcg/oversized-guest.h:10:10: fatal error: 
>> tcg-target-reg-bits.h: No such file or directory
>>
>> 10 | #include "tcg-target-reg-bits.h”
>>
>>
>>
>> Full log for build fail: 
>> https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/jobs/4416773231 
>> <https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/jobs/4416773231>.
>>
>> This is my last patch which enables xen build for ARM: 
>> https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/commit/6f6667217bfc14ff5504ee5fdee23a948d60fb7f 
>> <https://gitlab.com/Vikram.garhwal/qemu-ioreq/-/commit/6f6667217bfc14ff5504ee5fdee23a948d60fb7f>. 
>>
>>
>> This seems something missing in disable-tcg config for ARM builds. 
>> Any hints on what might be causing this TCG issue?
>>
>> Thanks in advance for your help!
>
> I meant to cc you, but fix here:
>
> https://patchew.org/QEMU/20230606224609.208550-1-richard.henderson@linaro.org/ 
>
>
Thanks, Richard. This helps a lot. I will rebase my patches on this 
series and re-test gitlab ci.
>
> r~


