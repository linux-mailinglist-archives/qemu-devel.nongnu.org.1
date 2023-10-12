Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 834937C6ED7
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvSM-0008SC-NJ; Thu, 12 Oct 2023 09:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcagnin@quarkslab.com>)
 id 1qqu9k-0000Dx-5V; Thu, 12 Oct 2023 07:47:08 -0400
Received: from mail-pr2fra01on20718.outbound.protection.outlook.com
 ([2a01:111:f400:7e18::718]
 helo=FRA01-PR2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fcagnin@quarkslab.com>)
 id 1qqu9h-0002Au-OU; Thu, 12 Oct 2023 07:47:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em5IR7ztLrLlUHQA2m99RhkQvxetmGLk1ma2HYX/OfL97w470Ec4I85PHNXzt3QWm4tSYbAeShRQhEa5iOHclhezMrzDc0t0WcgQI/7XNH5vmm2tjhcj5ZuxBhXJODBmbFukf1BgfaYetUr/rfpWaH59GpbQCybluQ0sw+eJuCkd40w9O4jFTZwcaISOoDBs7xpxVmUAXhFzyARfd4sFoUIe9HZ28dZ6ip+g3MPhYqDv2n/6rF58p8IkIoHTw5Jw4D6kjKW1p8Qz2OsQy330T5SgBP0w/5iIkRFJw8A5Dsv//i9HxNzeRBuVLmAkqTyCc71YuKQpfw8PZV3gdUir8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LxWHhP7CeJTOFntoUAFSdVwYRsWAd4vddGDi3lXfBY=;
 b=CPskHCHL3ATBIzOCpt6zZlcMVOJWVyzyLSKhojGLTV9XzgKGnNzAF88eXMygoZMfLVxeuVjSBtOJxhEyRzMmqzwhuyrfwVIXJIfgOB+4DFNmRmtAzkCRgbqFeUVkvFJ3aEIUqcbEJ2MzNtCCM2T4xP3cnPfyy5cnNBGuMPB3xPbQXdtpgAFYJxVirYsKwR0R9auDZhM7je1wAs+1XjoD37s9SG37p9DhWi2QTNQtYgMdvjhfOrCdRR6h6ZaN262EckyY2EXOatgdQ/PtP1YsxBBxmVJz+SD/fjIoS+vNoJUjR+tP3A6L9oUoE7jOwjIcMO7izGOlJi079B80XJAQZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quarkslab.com; dmarc=pass action=none
 header.from=quarkslab.com; dkim=pass header.d=quarkslab.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quarkslab.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2LxWHhP7CeJTOFntoUAFSdVwYRsWAd4vddGDi3lXfBY=;
 b=myXqiGPB6EEBiUMPKv4plYVHR+KRK0QyHCTomPZ0P/4V3pDFAMXf1PVgLWMOaVNm2CGvo54yWlWaXxjsayzMF4ocuEDo6WVEAm4yAsZgit18YdtEzpP95nKw1RQoaH9YQdyT3QJz4fVfyT/MYku5A7Z4uYIbxay5DrvI+pHGWfB4RAuuD55sMSO6CofYH1M2H3bzE1EIlw3AzVjs3HTx/LaKQ+nQj4go2eflz5jCKaqCwuFkcSYgY8NOUrhmTFvwo1JtFrOA+fciNXwxIOCWay0P9oKwKv5miKzQpX86J47guRtVQz+Syfb5v6MunMYpolxJeuvWIWhlQFVVOQTalw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quarkslab.com;
Received: from PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11c::6)
 by PR1P264MB1918.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:192::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 11:47:00 +0000
Received: from PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f635:24b9:27c4:698e]) by PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f635:24b9:27c4:698e%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 11:47:00 +0000
Message-ID: <746bf183-d805-4e0d-8c5e-e989c5f46823@quarkslab.com>
Date: Thu, 12 Oct 2023 13:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] hw/vmapple/vmapple: Add vmapple machine type
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230830161425.91946-1-graf@amazon.com>
 <20230830161425.91946-13-graf@amazon.com>
From: Francesco Cagnin <fcagnin@quarkslab.com>
Autocrypt: addr=fcagnin@quarkslab.com; keydata=
 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
 XooHsgHHeYUgSIqwlkS7PofS55M=
In-Reply-To: <20230830161425.91946-13-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0212.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::12) To PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11c::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAYP264MB3320:EE_|PR1P264MB1918:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c9db08-e21b-47a2-2e94-08dbcb18f22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klDPqs573mW8GlH8q/k16ZIiO63FmrMhJINGupi1i1QVx4q60QO3tUVZiwb4a2sQsCfxdC39gQIiGN9wE8AZS2y+cZ1gHbdNeY1/xvYzA49YMPC46chtF976ZMu+KMxfCRAkS5CZwop0kSp1b3MgK1PaDmxwhyiyEf9R0kwBRO8UtESHn/cUJrW6hr1PrKveusYqBqICpJpbqZS1MbZQ2sU1JgF7qoZ+QB6SZ6rQ3bu9YpHCklVFlSQ19NqZeGwROPKp4m4U7QPWHJRbPsX8QN1RiNUO7uT7f+MsExj/YIvRDJ8gEH0Vza3hozxh7KM5XutkRssGTksjQSiC4yis0Fxw1zfD5Rw7MA0guSmNP+cllafrvndiVgMilJ+CSnj9KIb/u/p4zN/7oG4AVyHj5DdxKStU1iW6IJNfMDtZrBIKsLHDlRqo3R+oRk+MUDaN4qj+UuohD3PzajUDwkryKa33yKtESCOuWg28Ka9Zbybc9MmP2rgFfZr75iyAad2wLmCPLPS3jS+qB8H7qk7fW3pQiEvLvO2dtIgZF0fwTXXvIrpS02DoJD++Pr/JRwEjinBkWd4xgLy/f/XnJfO0bP/26wvgPwIWPvLkxQZ2E4b7NgN+REnevyyjFOPXQ9c4kJjzsWPokDHo8YGUfPKjRg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39840400004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4744005)(2906002)(5660300002)(8936002)(8676002)(4326008)(7416002)(66476007)(316002)(66556008)(66946007)(54906003)(478600001)(41300700001)(6486002)(31686004)(6512007)(2616005)(6506007)(26005)(36756003)(31696002)(86362001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBpbTU5cUd0ZWFQelJiTFprOEhKMnJYWHFQa1lVRXhHOVg4Z3h6VVFTZ0Fl?=
 =?utf-8?B?VFpsT1F3MWxJQ1RGU1pYWE1vZTdMck4yM293b2xNN3dMOElQYm1TblY5SU5W?=
 =?utf-8?B?YTJnSS9VSElDLzNFOXVOYzFtV01KdExRWkJrTkpLSVA0Z2FDOHZ6NTllV2Zx?=
 =?utf-8?B?UGFGUzBGbkJ1MEQ5UXcxdTZWV2FCNExjdmdwMVQxc2JlZW55Mlp4SDFjdURj?=
 =?utf-8?B?WGJNN2w1WFNMaVdoRHpsY2hScCtkaWpsYS9oK0tGMnNPd0FsQWZwV2J4VndO?=
 =?utf-8?B?Y2xmN2NGY1FWMkhmR1hqUUcwUUpDdU4xM0lMNDZ4S1dOK3VwK3VROUphUS8y?=
 =?utf-8?B?dlBZak9JRTVZK0RQVmlqeXp6YTBsdU1hSXh5VXI0NGUzSFlTblY3K2RSeEdv?=
 =?utf-8?B?WmVHMXdiMnBSUHdCa0xiSnBzUTRNS3FMWDJObWQxdzlXeVBOdnFDV0FYT3M3?=
 =?utf-8?B?ODBJdmlzTzVrMWNvdkd1KzBaeXN5Y2RlQnRpRlkxQnA1TzlObHVGWTN0Rmxu?=
 =?utf-8?B?d2lEVWtSZzlpdkpTOWI4NGJ0VkRGdlhlNkY2M2U5VWhjclR6NUg1WXMvOFp4?=
 =?utf-8?B?ZERHanI1YXRGdHZnY3ZvZEFhcjJGeGpjNS9QY0prUmFKTE4xMWRLRXRZeWZD?=
 =?utf-8?B?WFRGY3VXTklPY2ZlSTVSdHo4WjY2UE0rTy9aVlRZZ2RhNDdLei90NFpxbjJV?=
 =?utf-8?B?VXowWkNhOVZKZFJyV1cvbGsyRGx3SkV0MDI0UFBjNXBaSGo2Zm1MT0x4SmhJ?=
 =?utf-8?B?YXM3Rk9XWEJLWWdkU0NncWUzVll3Ny81c3ZYOTVQNGV4blVNRHFxM3dvUGgw?=
 =?utf-8?B?VnJidzdYSEMzcTdGWlZ5YTgwa0l2aXdyTmtZSHptMUJCcUJMdVJ3NFFGYTFL?=
 =?utf-8?B?RjdTQWpMbDB0RDl3M0VJSWNzeWlhemRQd0FwSGIvRGhWS0NROU15Mk8wdU5v?=
 =?utf-8?B?TitmZFVZSUFPK0xvYzk1dUNPbExXQjFlalpGVTlHTXA2WExzbGJYL1dGMTMr?=
 =?utf-8?B?NFpjSkI0UnI3QUdjVHl6VUNWTTg2QkZZekVBN3dhRmMrR2U2SUg0dnFPRTVS?=
 =?utf-8?B?ajUwbkxtbTlBVDRoSVltRjBZU0EwNE5tL3JvbVF0Q04vMTU1d3prNDNlVnIy?=
 =?utf-8?B?R2wzR0JRT3RUL2g2MUpzNnNScWp3Uisyb29tNis2Tm5hUHNyejdnTUpzY2hQ?=
 =?utf-8?B?VUFDRGllY01TUFVKV0k2S3dXSUI5VThlT2Nxb3VxanEvaDI3TlNFOU9rZVZm?=
 =?utf-8?B?M1pZN3F5WEc4WFQrTG5QWTRWMEYwZFZJT0ZqMzJ0WEt0ZE5maVNKaXF6Z3k3?=
 =?utf-8?B?RVF3alU4c2ZDTndiOTc2aHRYTFBhLzFMWWNhMm1QdUdmbU9tRXFDMzBXMUZ0?=
 =?utf-8?B?Z2tpRXQvcG5sSUJVMXNZdDBsaURXd2dGbStCUDZ0MEhzSEVYaDZoc0R3Z0E2?=
 =?utf-8?B?T3FSKzEzQjJlTy9aMDl2dDNHSjZiSjhTOE92dG9FYmJZaHU3QlNLUzFEZzBl?=
 =?utf-8?B?cXpDQVhyTmpEblo5dGwzNkNOajA3UEY1MHFJWG44YUxaTmFPY0huTExJM1VX?=
 =?utf-8?B?dUc4b01iUkJrTlJxZDJ3aktNWDNIdkR4T09FUTZwZCtYcHprU2k1NWFyVzNm?=
 =?utf-8?B?MlZaZE9vYVE4RjAxOEVkNUowaWVtMUs1MzI3UUZ5cVB5eUFzNnYybWFtV2Ro?=
 =?utf-8?B?cE9jTi9pbFlUL1lQaFBxQ2d5eEZRV2tGR3pzZlFEYVJQQVlEZFNtTHlKZ01u?=
 =?utf-8?B?MjNuc3JrVUl0MU5kb25sVWxzRUJFQVNzTUZQMldyeUdMQjFuT05zZlFtdFJV?=
 =?utf-8?B?cWdWa2hnU1JzT0d2eitpblkwK05MY1JjRWFmS210Tjh0THhpZmZuekFwMzdG?=
 =?utf-8?B?djBoK1hzL21WdGxxUlFtOENjUnlaajl5dFNSd2VOcllDUCtqUmpOSEJQeVp1?=
 =?utf-8?B?eWNnMHhHVmszVmN5V2xJMG9CQStvUXNsMHEvQTBQMVl6NmZ6N2huVGltbU9N?=
 =?utf-8?B?aXNkUmhjUU83Rlk4UkZYMGx0U0xsblpLRWhRWmtyZm85R2YxckFDY2tDU1Zo?=
 =?utf-8?B?U3BtZm04d1JmQWhiWkZRYVFyc1dIdXdiNTJ2K0hkeUg4YmJSN0RsM1BJN2VP?=
 =?utf-8?Q?PJ3xb7UhROxGWSvOZdARlIaaO?=
X-OriginatorOrg: quarkslab.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c9db08-e21b-47a2-2e94-08dbcb18f22b
X-MS-Exchange-CrossTenant-AuthSource: PAYP264MB3320.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 11:47:00.6818 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6a0d73c7-78c3-4da6-8044-d2eae999a5c5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QgoQ4yVsY8Pq6uk8AAhP/oIHxWnMMOJxM7/ySOCArrFXGZhb++fyLPeAiX5I4UOnakKdd3AFjLSf3Q1P0gI4QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1918
Received-SPF: pass client-ip=2a01:111:f400:7e18::718;
 envelope-from=fcagnin@quarkslab.com;
 helo=FRA01-PR2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Oct 2023 09:09:56 -0400
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

Hi Alexander,

awesome work, thanks!

I don't know if it's the most appropriate fix but to have the patch series
working I had to add `select VMAPPLE_VIRTIO_BLK` to `hw/vmapple/Kconfig`:

 >  config VMAPPLE
 >      bool
 >      depends on ARM && HVF
 >      default y if ARM && HVF
 >      imply PCI_DEVICES
 >      select ARM_GIC
 >      select PLATFORM_BUS
 >      select PCI_EXPRESS
 >      select PCI_EXPRESS_GENERIC_BRIDGE
 >      select PL011 # UART
 >      select PL031 # RTC
 >      select PL061 # GPIO
 >      select GPIO_PWR
 >      select PVPANIC_MMIO
 >      select VMAPPLE_AES
 >      select VMAPPLE_BDIF
 >      select VMAPPLE_CFG
 >      select VMAPPLE_PVG
 > +    select VMAPPLE_VIRTIO_BLK

Otherwise QEMU raises the error `'vmapple-virtio-root' is not a valid device
model name`.

Francesco


