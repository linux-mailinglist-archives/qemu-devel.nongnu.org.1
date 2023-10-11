Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374EC7C511C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 13:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqX5V-00040x-VR; Wed, 11 Oct 2023 07:09:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1qqX5Q-00040B-EZ; Wed, 11 Oct 2023 07:09:08 -0400
Received: from mail-mw2nam10on2072d.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::72d]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishnu@os.amperecomputing.com>)
 id 1qqX5I-00063Y-TO; Wed, 11 Oct 2023 07:09:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNwscfb3l2goGUtNUxko4Q+OxlCWkqEGt1JHCY0ZajQPJMR3hi5qXoqvVVflmByWTNxn5zQ4Ta8z7tgE1ONW89F5XNDrEyYyYV//WpebyueaHTE/I0aosp/PkDKGgQMT/z6UacBNOw+dagh+y3Z5yyxBpUzeHjhBiGxm/BAKnWoush0DTsWfD0g3nIdo1k6tDXH+HU3NxCaNsI1qBvUpYTFfkT251lKWkhXR3wvwT7TAjIoFL1/5WS1jzeSNnsU3T7y04Ctib1rqir62DsqJpEZGKrHSq+j9sXNGnxOhbTnt8ZshTRw05dDnjmG5R9Q78RGF57jkKm6osQuzv8ifew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26L1T3Jh3VOp694cSS/5sAFINN+YCEcKPuYplAG8y1s=;
 b=fDKvGh9iRIAz4WWUAWt1a+3/Tj9vclHf0vjsm1y6a1TPeZfGb584Nkx4xPYRWzkyTGFGRlnrX/BP39g9Taf1lvMaOaALuduSxreI+EZDSmGeodCQp3RNTnt2eb5yn7Hw/r8WA2Q27MOMUkTCDHV4KTINHS8SeqeriY5FACuY5biAtOSgjiKBedjLR3hBhzzaDyhOfa85hRTvA4+N/DCj73tUNZJi+AjTLg9AA+08t13q4C2kyBPt79NNrlp2ZznliI9yXf0JuM3oc+m60HYN8JYXEgAbQRnc32OUpUo8NQSsCEPe7mjNKQ3d0Veflfc/DUg7I3a16DaXHix0E1f+7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26L1T3Jh3VOp694cSS/5sAFINN+YCEcKPuYplAG8y1s=;
 b=MvGHbwGn1saAH2hFhd0oSmH8nzQIPCXD0mw4UuxTYS5B2bhtVSloxOCar2xqfQZWGR538ppC/dYWJTKC5Yo5wDnpfGYgWcOtK3bNN4dxTOWsV8hZIIC8Vx1eDPdAmWhhfPVtWxpuENlTEwx8V4VJ1qUnV2LxMlKU4lEDkCRzGDY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BYAPR01MB3685.prod.exchangelabs.com (2603:10b6:a02:8e::13) by
 PH0PR01MB7896.prod.exchangelabs.com (2603:10b6:510:28c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Wed, 11 Oct 2023 11:08:49 +0000
Received: from BYAPR01MB3685.prod.exchangelabs.com
 ([fe80::cb75:71bb:e8be:64da]) by BYAPR01MB3685.prod.exchangelabs.com
 ([fe80::cb75:71bb:e8be:64da%6]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 11:08:48 +0000
Content-Type: multipart/alternative;
 boundary="------------Rox80qaG0QIKoVLQOf2ozQRh"
Message-ID: <721d05b7-ee2b-999c-da72-d369483cfbb2@amperemail.onmicrosoft.com>
Date: Wed, 11 Oct 2023 16:38:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8 Arch
Content-Language: en-US
To: Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <cfcca2d3-212e-2a90-1acc-1d23105c3804@amperemail.onmicrosoft.com>
 <c6eb2290323644e89c40c834bb934f62@huawei.com>
From: Vishnu Pajjuri <vishnu@amperemail.onmicrosoft.com>
In-Reply-To: <c6eb2290323644e89c40c834bb934f62@huawei.com>
X-ClientProxiedBy: CY5PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:930:16::17) To BYAPR01MB3685.prod.exchangelabs.com
 (2603:10b6:a02:8e::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB3685:EE_|PH0PR01MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: a6efaa1f-cb36-4ba1-1e04-08dbca4a7093
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cj2DBiYWpDrBSqGEfMyaej9yMlb5FhVQiOE+k6GhgeSsIRkK77GoQ9ykhc13th6ise9QY4VL+soP8BesUUsZuAuI7c1eF7vJH+2/hLBN8iVDSw5YYeSFo43T07PtZQXcfNKk6GmPwM27UYkMnmXWidlBh0dg+k8UWP7BPcGpKf9g9s6zSq0LOKpSUkro24b2sUVvedcKPaYrfL+IR8sorH3lLzIgPZOvwHp4edyVkdlYHRYVRsrX9VyL1a7QKLko/mSr6Xx7VbXn2p4/7eOdL4TgD+D/6TUWXABjCyNIDMavyAQZJ2r1h7zMnVR9ITzgR65emDDO61rv0y/pfsle48Of8YwNSJDHM1lHpTcB+bCl8HEnibckJnfhvVF2XQDa8wmHnXjEvC8Ekfg27hlBBzi4V/bQCkKHqKTxBxTKeb46wNr/u7klYQ7vIoMfGxipJjGjsEFo7IDzBrDV9kHatO6heIa+qwJjm1/V6EjMTuM0el4ZHF1VTFxr4Zk3ZhK1Bs+uvCM+gfH43ETDUvNBdJ9iEDOCkEPw4kUWaeydIMxecRpE8Mun9YEoF8dc3SBgAafyty8mYDIF8TFtcasGDzJJD+ykEPAp1noN+9bA8oU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR01MB3685.prod.exchangelabs.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39850400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(30864003)(6512007)(6666004)(478600001)(42882007)(26005)(83380400001)(53546011)(2906002)(31696002)(33964004)(6506007)(2616005)(166002)(83170400001)(6486002)(966005)(38100700002)(21615005)(41300700001)(5660300002)(66556008)(66476007)(66946007)(110136005)(316002)(54906003)(31686004)(4326008)(8936002)(8676002)(7406005)(7416002)(43740500002)(559001)(579004);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFJOa0pKTTBRT1JsWlVOcWZzSFljdWZQVExkd0g2SVlLaTRHVlI3UzZlN2Zr?=
 =?utf-8?B?VEVkSW5pNXovQmpjTUs1NjdZdkoyVi9sNTlMY2d5N1dPZmVQT3FLYjFNSEtp?=
 =?utf-8?B?c3pUQ1pEcWp6cVlvVzJRSGJWcVRZU3NyQzFUcU8ycEF3VDJRVm1DUHhoS3A3?=
 =?utf-8?B?b0ozYTJXajh5Q1o4M1Q4QjlmaGY3U2I2a2wyOGhTUlpvWElYSC9EU09PUXlh?=
 =?utf-8?B?TXFLSEJobUIzdE1UZTNaWWxoSmducllrTzl5TEZHblJ3VE5sUldRYzYxUXA0?=
 =?utf-8?B?OGkwdWhGbjNJbG1qZFY5QlRSTHpscFZpeTEwMFBvNjZvdFJlK3FPeS9DZktr?=
 =?utf-8?B?QnJXSEFuRDZVN0xNYWFQaUpobHFCUFZGdGIzMkFqVmozYzU1MWRqWERYYUUv?=
 =?utf-8?B?by8vZDI5aWNmZEF4dGFyeEFsTTh6Y2pyMlR1ajhkSXZ1L1NCc09LRU5CdFBK?=
 =?utf-8?B?V3ZTVGtVSFpqM1FJWDQxK2JWU3JLNzg4ak8rZy9CRFBxUzBiV0ZFQlJOcjBZ?=
 =?utf-8?B?OVplSUM2S1h4Szh0NGdGV3NpblIrTHVDMjV4YW9YOGxFZjdTQTMvYVAzNWJl?=
 =?utf-8?B?eHNPK0lvOHFRbC9GWEhvSVJXK1JzR1JlQ2dGby9PY2VQdnJxd25WUWVlby9w?=
 =?utf-8?B?TzMxUU8vZGd1aU40RVVnRWpIaytLYzRMdjhiMWs5K2JVaEFjNFBqUXVuTmZs?=
 =?utf-8?B?YXdHYXVvSjJKR2ZHQVk3aHZ3Ui8ycWNvTy9Fb1VhWDhOYjNQQTNvWE01TXFP?=
 =?utf-8?B?YW5lRW01aTNRc254R2IrTkNqbUk3YmZ3NFlDbm5wS3YyeEgwRTRKRnRad2l2?=
 =?utf-8?B?Z1J2S2g1eWpXRDlnZEJadFZaZ0k2TSs3ZjRLLzdaaUJLZU1IS0hpdzdTUzhv?=
 =?utf-8?B?TEVVSHIrQXMrVTRLMUUvMUJoVG9TVk5oT3lvODk3WU1PV0M1eDNVcWxzdzEx?=
 =?utf-8?B?QW1GWEFnY2xFRENFb01HMml5NGFrWkVmblRBV1BjT3VhUzQ3TEZVRXFlZml3?=
 =?utf-8?B?eUROa3dLQkVEdVlyV3hhdXNja2s4M0JLVkpJTDF6QW1CYmFQUnptUEd2MlFN?=
 =?utf-8?B?RVdSU2hkSzBkTnRPK3pWU200RHhaMURWUzVxZVlpZHkySFdycXJyYmNhQm9t?=
 =?utf-8?B?TTRxQURJQWJOSkdCb0JOamFoS0czaTdGaDl2VTE5TW1YejZzdjg3OTg0NGRn?=
 =?utf-8?B?T0FYV01STDQ3QnlKUjBxeXkyMGRBclJWdFd6dFVOYWhTOFJxbWR4TlBIYm8y?=
 =?utf-8?B?ZFNnZVhpR0VETGhHZzM3MXRRMzk0RHhQWnpFRkNQVGkwMUtrT0x4MnFXSCtR?=
 =?utf-8?B?RWt0V1dQV2FsTVJNMDVmYU03Wkk0NUpDdGtwaDhaMXkvUU50a2p6VnFtdzZv?=
 =?utf-8?B?TnFESFAzUUFBVVBQZVRQRE1XU0dEUDc2bllhU0cxOVh0YTk5ZGJDbmtva1RC?=
 =?utf-8?B?aFdaZWxFU1h0SHJzT2ZHaDJQYlU1MkdsaUFmU256VVhhejVsTjBtT1pQTjRQ?=
 =?utf-8?B?YXkxaks0ditmNDBsRWQ0VHFLQTA3NG1aNXRmSktPVVlKSldYTlhjcVdPU1pW?=
 =?utf-8?B?QUVYVVZDSThwWjB2S1NVQ0lKVG1OR3g4dGJ6cWdLbE5icXk1ZGppdklrTjZV?=
 =?utf-8?B?U0YrM09sZDJMRStJNXVOMUFBRCtqZVpHWTUwb3YxN0lFTktnUHhpcnljbEpK?=
 =?utf-8?B?SE1PNm5MbWc3dTNlV2RuSkoyeWQ4cUExdkl6WithcXlaZ0R4OWZQSGRrUnZX?=
 =?utf-8?B?RlVFRjB2RWQyTTFnSmF5aXJ3TmtUYjNTM044VmcvVkJUQ0FZMTlGSCtiaEUy?=
 =?utf-8?B?R1VLLzI3dGZqUVkrY3dnUm1iYndaempTYXp4cnhlUjM0L1RiSVNVL1dYUC9M?=
 =?utf-8?B?UXdjbDdLbmVuNXEzNGl6dy9BZU9YR29WZytVT2l4R2xwV1lVMXVySzZKbFZB?=
 =?utf-8?B?eXRJdWYzUU9ybWhIRUhuSDl0M2ttNjBCMDc4YjVXZzhPOHQ5KzI4Ym51M2ZV?=
 =?utf-8?B?a0FsenJ6dWtUb0FwNituQUFoRjZmTlhjZGpvN1FWeFFwMDhHb1R3Z1RHMXA5?=
 =?utf-8?B?blozM0hBRVd0NFBSREJiMEh2QW1HUzZNa3JWZjV5QW1TQlJSVjVXbjRMVVRi?=
 =?utf-8?B?bTVWcW4zd2VxeVcvQitJU2Qxa2kxc2MyTHVLNFBHS2o5U3FBb1hZVjFITnV1?=
 =?utf-8?Q?IkaVNsazua/9t8kB3IEYQMM=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6efaa1f-cb36-4ba1-1e04-08dbca4a7093
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB3685.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 11:08:47.6016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzO4fUVSjQI51LPqSxg6Oh/Q0E+DMrtgwSkySeJW72PWppxWtMSTaUHwm2WWEEpuYQqRVwCGfdz6SOvcdCKdK5iG/3HWoAVmKOreBRpRU4bBkXM21phahiK8W2rJFflX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7896
Received-SPF: pass client-ip=2a01:111:f400:7e89::72d;
 envelope-from=vishnu@os.amperecomputing.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, HTML_MESSAGE=0.001, NICE_REPLY_A=-3.339,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URI_DOTEDU=1 autolearn=ham autolearn_force=no
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

--------------Rox80qaG0QIKoVLQOf2ozQRh
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Salil,

On 11-10-2023 16:02, Salil Mehta wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
>
>
> Hi Vishnu,
>
>> From: Vishnu Pajjuri<vishnu@amperemail.onmicrosoft.com>
>> Sent: Wednesday, October 11, 2023 11:23 AM
>> To: Salil Mehta<salil.mehta@huawei.com>;qemu-devel@nongnu.org; qemu-
>> arm@nongnu.org
>> Cc:maz@kernel.org;jean-philippe@linaro.org; Jonathan Cameron
>> <jonathan.cameron@huawei.com>;lpieralisi@kernel.org;
>> peter.maydell@linaro.org;richard.henderson@linaro.org;
>> imammedo@redhat.com;andrew.jones@linux.dev;david@redhat.com;
>> philmd@linaro.org;eric.auger@redhat.com;will@kernel.org;ardb@kernel.org;
>> oliver.upton@linux.dev;pbonzini@redhat.com;mst@redhat.com;
>> gshan@redhat.com;rafael@kernel.org;borntraeger@linux.ibm.com;
>> alex.bennee@linaro.org;linux@armlinux.org.uk;
>> darren@os.amperecomputing.com;ilkka@os.amperecomputing.com;
>> vishnu@os.amperecomputing.com;karl.heubaum@oracle.com;
>> miguel.luis@oracle.com;salil.mehta@opnsrc.net; zhukeqian
>> <zhukeqian1@huawei.com>; wangxiongfeng (C)<wangxiongfeng2@huawei.com>;
>> wangyanan (Y)<wangyanan55@huawei.com>;jiakernel2@gmail.com;
>> maobibo@loongson.cn;lixianglai@loongson.cn
>> Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8
>> Arch
>>
>> Hi Salil,
>>
>> On 26-09-2023 15:33, Salil Mehta wrote:
>>> [ *REPEAT: Sent patches got held at internal server yesterday* ]
>>>
>>> PROLOGUE
>>> ========
>>>
>>> To assist in review and set the right expectations from this RFC, please
>> first
>>> read below sections *APPENDED AT THE END* of this cover letter,
>>>
>>> 1. Important *DISCLAIMER* [Section (X)]
>>> 2. Work presented at KVMForum Conference (slides available) [Section
>> (V)F]
>>> 3. Organization of patches [Section (XI)]
>>> 4. References [Section (XII)]
>>> 5. Detailed TODO list of the leftover work or work-in-progress [Section
>> (IX)]
>>> NOTE: There has been an interest shown by other organizations in adapting
>>> this series for their architecture. I am planning to split this RFC into
>>> architecture *agnostic* and *specific* patch-sets in subsequent releases.
>> ARM
>>> specific patch-set will continue as RFC V3 and architecture agnostic
>> patch-set
>>> will be floated without RFC tag and can be consumed in this Qemu cycle if
>>> MAINTAINERs ack it.
>>>
>>> [Please check section (XI)B for details of architecture agnostic patches]
>>>
>>>
>>> SECTIONS [I - XIII] are as follows :
>>>
>>> (I) Key Changes (RFC V1 -> RFC V2)
>>>       ==================================
>>>
>>>       RFC V1:https://lore.kernel.org/qemu-devel/20200613213629.21984-1-
>> salil.mehta@huawei.com/
>>> 1. ACPI MADT Table GIC CPU Interface can now be presented [6] as ACPI
>>>      *online-capable* or *enabled* to the Guest OS at the boot time. This
>> means
>>>      associated CPUs can have ACPI _STA as *enabled* or *disabled* even
>> after boot
>>>      See, UEFI ACPI 6.5 Spec, Section 05, Table 5.37 GICC CPU Interface
>> Flags[20]
>>> 2. SMCC/HVC Hypercall exit handling in userspace/Qemu for PSCI
>> CPU_{ON,OFF}
>>>      request. This is required to {dis}allow online'ing a vCPU.
>>> 3. Always presenting unplugged vCPUs in CPUs ACPI AML code as ACPI
>> _STA.PRESENT
>>>      to the Guest OS. Toggling ACPI _STA.Enabled to give an effect of the
>>>      hot{un}plug.
>>> 4. Live Migration works (some issues are still there)
>>> 5. TCG/HVF/qtest does not support Hotplug and falls back to default.
>>> 6. Code for TCG support do exists in this release (it is a work-in-
>> progress)
>>> 7. ACPI _OSC method can now be used by OSPM to negotiate Qemu VM platform
>>>      hotplug capability (_OSC Query support still pending)
>>> 8. Misc. Bug fixes
>>>
>>> (II) Summary
>>>        =======
>>>
>>> This patch-set introduces the virtual CPU hotplug support for ARMv8
>> architecture
>>> in QEMU. Idea is to be able to hotplug and hot-unplug the vCPUs while
>> guest VM
>>> is running and no reboot is required. This does *not* makes any
>> assumption of
>>> the physical CPU hotplug availability within the host system but rather
>> tries to
>>> solve the problem at virtualizer/QEMU layer. Introduces ACPI CPU hotplug
>> hooks
>>> and event handling to interface with the guest kernel, code to
>> initialize, plug
>>> and unplug CPUs. No changes are required within the host kernel/KVM
>> except the
>>> support of hypercall exit handling in the user-space/Qemu which has
>> recently
>>> been added to the kernel. Its corresponding Guest kernel changes have
>> been
>>> posted on the mailing-list [3] [4] by James Morse.
>>>
>>> (III) Motivation
>>>         ==========
>>>
>>> This allows scaling the guest VM compute capacity on-demand which would
>> be
>>> useful for the following example scenarios,
>>>
>>> 1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the
>> orchestration
>>>      framework which could adjust resource requests (CPU and Mem requests)
>> for
>>>      the containers in a pod, based on usage.
>>> 2. Pay-as-you-grow Business Model: Infrastructure provider could allocate
>> and
>>>      restrict the total number of compute resources available to the guest
>> VM
>>>      according to the SLA (Service Level Agreement). VM owner could
>> request for
>>>      more compute to be hot-plugged for some cost.
>>>
>>> For example, Kata Container VM starts with a minimum amount of resources
>> (i.e.
>>> hotplug everything approach). why?
>>>
>>> 1. Allowing faster *boot time* and
>>> 2. Reduction in *memory footprint*
>>>
>>> Kata Container VM can boot with just 1 vCPU and then later more vCPUs can
>> be
>>> hot-plugged as per requirement.
>>>
>>> (IV) Terminology
>>>        ===========
>>>
>>> (*) Posssible CPUs: Total vCPUs which could ever exist in VM. This
>> includes
>>>                       any cold booted CPUs plus any CPUs which could be
>> later
>>>                       hot-plugged.
>>>                       - Qemu parameter(-smp maxcpus=N)
>>> (*) Present CPUs:   Possible CPUs which are ACPI 'present'. These might
>> or might
>>>                       not be ACPI 'enabled'.
>>>                       - Present vCPUs = Possible vCPUs (Always on ARM
>> Arch)
>>> (*) Enabled CPUs:   Possible CPUs which are ACPI ‘present’ and 'enabled'
>> and can
>>>                       now be ‘onlined’ (PSCI) for use by Guest Kernel. All
>> cold
>>>                       booted vCPUs are ACPI 'enabled' at boot. Later,
>> using
>>>                       device_add more vCPUs can be hotplugged and be made
>> ACPI
>>>                       'enabled.
>>>                       - Qemu parameter(-smp cpus=N). Can be used to
>> specify some
>>>                    cold booted vCPUs during VM init. Some can be added using
>>>                    '-device' option.
>>>
>>> (V) Constraints Due To ARMv8 CPU Architecture [+] Other Impediments
>>>       ===============================================================
>>>
>>> A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
>>>      1. ARMv8 CPU architecture does not support the concept of the
>> physical CPU
>>>         hotplug.
>>>         a. There are many per-CPU components like PMU, SVE, MTE, Arch
>> timers etc.
>>>            whose behaviour need to be clearly defined when CPU is
>> hot(un)plugged.
>>>            There is no specification for this.
>>>
>>>      2. Other ARM components like GIC etc. have not been designed to
>> realize
>>>         physical CPU hotplug capability as of now. For example,
>>>         a. Every physical CPU has a unique GICC (GIC CPU Interface) by
>> construct.
>>>            Architecture does not specifies what CPU hot(un)plug would mean
>> in
>>>            context to any of these.
>>>         b. CPUs/GICC are physically connected to unique GICR (GIC
>> Redistributor).
>>>            GIC Redistributors are always part of always-on power domain.
>> Hence,
>>>            cannot be powered-off as per specification.
>>>
>>> B. Impediments in Firmware/ACPI (Architectural Constraint)
>>>
>>>      1. Firmware has to expose GICC, GICR and other per-CPU features like
>> PMU,
>>>         SVE, MTE, Arch Timers etc. to the OS. Due to architectural
>> constraint
>>>         stated in above section A1(a),  all interrupt controller
>> structures of
>>>         MADT describing GIC CPU Interfaces and the GIC Redistibutors MUST
>> be
>>>         presented by firmware to the OSPM during the boot time.
>>>      2. Architectures that support CPU hotplug can evaluate ACPI _MAT
>> method to
>>>         get this kind of information from the firmware even after boot and
>> the
>>>         OSPM has capability to process these. ARM kernel uses information
>> in MADT
>>>         interrupt controller structures to identify number of Present CPUs
>> during
>>>         boot and hence does not allow to change these after boot. Number
>> of
>>>         present CPUs cannot be changed. It is an architectural constraint!
>>>
>>> C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural
>> Constraint)
>>>      1. KVM VGIC:
>>>          a. Sizing of various VGIC resources like memory regions etc.
>> related to
>>>             the redistributor happens only once and is fixed at the VM
>> init time
>>>             and cannot be changed later after initialization has happened.
>>>             KVM statically configures these resources based on the number
>> of vCPUs
>>>             and the number/size of redistributor ranges.
>>>          b. Association between vCPU and its VGIC redistributor is fixed
>> at the
>>>             VM init time within the KVM i.e. when redistributor iodevs
>> gets
>>>             registered. VGIC does not allows to setup/change this
>> association
>>>             after VM initialization has happened. Physically, every
>> CPU/GICC is
>>>             uniquely connected with its redistributor and there is no
>>>             architectural way to set this up.
>>>      2. KVM vCPUs:
>>>          a. Lack of specification means destruction of KVM vCPUs does not
>> exist as
>>>             there is no reference to tell what to do with other per-vCPU
>>>             components like redistributors, arch timer etc.
>>>          b. Infact, KVM does not implements destruction of vCPUs for any
>>>             architecture. This is independent of the fact whether
>> architecture
>>>             actually supports CPU Hotplug feature. For example, even for
>> x86 KVM
>>>             does not implements destruction of vCPUs.
>>>
>>> D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints-
>>> Arch)
>>>
>>>      1. Qemu CPU Objects MUST be created to initialize all the Host KVM
>> vCPUs to
>>>         overcome the KVM constraint. KVM vCPUs are created, initialized
>> when Qemu
>>>         CPU Objects are realized. But keepinsg the QOM CPU objects
>> realized for
>>>         'yet-to-be-plugged' vCPUs can create problems when these new vCPUs
>> shall
>>>         be plugged using device_add and a new QOM CPU object shall be
>> created.
>>>      2. GICV3State and GICV3CPUState objects MUST be sized over *possible
>> vCPUs*
>>>         during VM init time while QOM GICV3 Object is realized. This is
>> because
>>>         KVM VGIC can only be initialized once during init time. But every
>>>         GICV3CPUState has an associated QOM CPU Object. Later might
>> corresponds to
>>>         vCPU which are 'yet-to-be-plugged'(unplugged at init).
>>>      3. How should new QOM CPU objects be connected back to the
>> GICV3CPUState
>>>         objects and disconnected from it in case CPU is being
>> hot(un)plugged?
>>>      4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented
>> in the
>>>         QOM for which KVM vCPU already exists? For example, whether to
>> keep,
>>>          a. No QOM CPU objects Or
>>>          b. Unrealized CPU Objects
>>>      5. How should vCPU state be exposed via ACPI to the Guest? Especially
>> for
>>>         the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not
>> exists
>>>         within the QOM but the Guest always expects all possible vCPUs to
>> be
>>>         identified as ACPI *present* during boot.
>>>      6. How should Qemu expose GIC CPU interfaces for the unplugged or
>>>         yet-to-beplugged vCPUs using ACPI MADT Table to the Guest?
>>>
>>> E. Summary of Approach ([+] Workarounds to problems in sections A, B, C &
>> D)
>>>      1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e.
>> even
>>>         for the vCPUs which are yet-to-be-plugged in Qemu but keep them in
>> the
>>>         powered-off state.
>>>      2. After the KVM vCPUs have been initialized in the Host, the KVM
>> vCPU
>>>         objects corresponding to the unplugged/yet-to-be-plugged vCPUs are
>> parked
>>>         at the existing per-VM "kvm_parked_vcpus" list in Qemu. (similar
>> to x86)
>>>      3. GICV3State and GICV3CPUState objects are sized over possible vCPUs
>> during
>>>         VM init time i.e. when Qemu GIC is realized. This in turn sizes
>> KVM VGIC
>>>         resources like memory regions etc. related to the redistributors
>> with the
>>>         number of possible KVM vCPUs. This never changes after VM has
>> initialized.
>>>      4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged
>> vCPUs are
>>>         released post Host KVM CPU and GIC/VGIC initialization.
>>>      5. Build ACPI MADT Table with below updates
>>>         a. Number of GIC CPU interface entries (=possible vCPUs)
>>>         b. Present Boot vCPU as MADT.GICC.Enabled=1 (Not hot[un]pluggable)
>>>         c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=1
>>>            - MADT.GICC.Enabled=0 (Mutually exclusive) [6][7]
>>>       - vCPU can be ACPI enabled+onlined after Guest boots (Firmware
>> Policy)
>>>       - Some issues with above (details in later sections)
>>>      6. Expose below ACPI Status to Guest kernel
>>>         a. Always _STA.Present=1 (all possible vCPUs)
>>>         b. _STA.Enabled=1 (plugged vCPUs)
>>>         c. _STA.Enabled=0 (unplugged vCPUs)
>>>      7. vCPU hotplug *realizes* new QOM CPU object. Following happens,
>>>         a. Realizes, initializes QOM CPU Object & spawns Qemu vCPU thread
>>>         b. Unparks the existing KVM vCPU ("kvm_parked_vcpus" list)
>>>            - Attaches to QOM CPU object.
>>>         c. Reinitializes KVM vCPU in the Host
>>>            - Resets the core and sys regs, sets defaults etc.
>>>         d. Runs KVM vCPU (created with "start-powered-off")
>>>       - vCPU thread sleeps (waits for vCPU reset via PSCI)
>>>         e. Updates Qemu GIC
>>>            - Wires back IRQs related to this vCPU.
>>>            - GICV3CPUState association with QOM CPU Object.
>>>         f. Updates [6] ACPI _STA.Enabled=1
>>>         g. Notifies Guest about new vCPU (via ACPI GED interface)
>>>       - Guest checks _STA.Enabled=1
>>>       - Guest adds processor (registers CPU with LDM) [3]
>>>         h. Plugs the QOM CPU object in the slot.
>>>            - slot-number = cpu-index{socket,cluster,core,thread}
>>>         i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC)
>>>            - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>>>            - Qemu powers-on KVM vCPU in the Host
>>>      8. vCPU hot-unplug *unrealizes* QOM CPU Object. Following happens,
>>>         a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event
>>>            - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC)
>>>         b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
>>>            - Qemu powers-off the KVM vCPU in the Host
>>>         c Guest signals *Eject* vCPU to Qemu
>>>         d. Qemu updates [6] ACPI _STA.Enabled=0
>>>         e. Updates GIC
>>>            - Un-wires IRQs related to this vCPU
>>>            - GICV3CPUState association with new QOM CPU Object is updated.
>>>         f. Unplugs the vCPU
>>>       - Removes from slot
>>>            - Parks KVM vCPU ("kvm_parked_vcpus" list)
>>>            - Unrealizes QOM CPU Object & joins back Qemu vCPU thread
>>>       - Destroys QOM CPU object
>>>         g. Guest checks ACPI _STA.Enabled=0
>>>            - Removes processor (unregisters CPU with LDM) [3]
>>>
>>> F. Work Presented at KVM Forum Conferences:
>>>      Details of above work has been presented at KVMForum2020 and
>> KVMForum2023
>>>      conferences. Slides are available at below links,
>>>      a. KVMForum 2023
>>>         - Challenges Revisited in Supporting Virt CPU Hotplug on
>> architectures that don't Support CPU Hotplug (like ARM64)
>>>           https://kvm-forum.qemu.org/2023/talk/9SMPDQ/
>>>      b. KVMForum 2020
>>>         - Challenges in Supporting Virtual CPU Hotplug on SoC Based
>> Systems (like ARM64) - Salil Mehta, Huawei
>>>           https://sched.co/eE4m
>>>
>>> (VI) Commands Used
>>>        =============
>>>
>>>       A. Qemu launch commands to init the machine
>>>
>>>       $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
>>>       -cpu host -smp cpus=4,maxcpus=6 \
>>>       -m 300M \
>>>       -kernel Image \
>>>       -initrd rootfs.cpio.gz \
>>>       -append "console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2
>> acpi=force" \
>>>       -nographic \
>>>       -bios  QEMU_EFI.fd \
>>>
>>>       B. Hot-(un)plug related commands
>>>
>>>       # Hotplug a host vCPU(accel=kvm)
>>>       $ device_add host-arm-cpu,id=core4,core-id=4
>>>
>>>       # Hotplug a vCPU(accel=tcg)
>>>       $ device_add cortex-a57-arm-cpu,id=core4,core-id=4
>>>
>>>       # Delete the vCPU
>>>       $ device_del core4
>>>
>>>       Sample output on guest after boot:
>>>
>>>       $ cat /sys/devices/system/cpu/possible
>>>       0-5
>>>       $ cat /sys/devices/system/cpu/present
>>>       0-5
>>>       $ cat /sys/devices/system/cpu/enabled
>>>       0-3
>>>       $ cat /sys/devices/system/cpu/online
>>>       0-1
>>>       $ cat /sys/devices/system/cpu/offline
>>>       2-5
>>>
>>>       Sample output on guest after hotplug of vCPU=4:
>>>
>>>       $ cat /sys/devices/system/cpu/possible
>>>       0-5
>>>       $ cat /sys/devices/system/cpu/present
>>>       0-5
>>>       $ cat /sys/devices/system/cpu/enabled
>>>       0-4
>>>       $ cat /sys/devices/system/cpu/online
>>>       0-1,4
>>>       $ cat /sys/devices/system/cpu/offline
>>>       2-3,5
>>>
>>>       Note: vCPU=4 was explicitly 'onlined' after hot-plug
>>>       $ echo 1 > /sys/devices/system/cpu/cpu4/online
>>>
>>> (VII) Repository
>>>         ==========
>>>
>>>    (*) QEMU changes for vCPU hotplug could be cloned from below site,
>>>        https://github.com/salil-mehta/qemu.git  virt-cpuhp-armv8/rfc-v2
>>>    (*) Guest Kernel changes (by James Morse, ARM) are available here:
>>>        https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
>> virtual_cpu_hotplug/rfc/v2
>>>
>>> (VIII) KNOWN ISSUES
>>>          ============
>>>
>>> 1. Migration has been lightly tested. Below are some of the known issues:
>>>      - Ocassional CPU stall (not always repeatable)
>>>      - Negative test case like asymmetric source/destination VM config
>> causes dump.
>>>      - Migration with TCG is not working properly.
>>> 2. TCG with Single threaded mode is broken.
>>> 3. HVF and qtest support is broken.
>>> 4. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-
>> capable are
>>>      mutually exclusive i.e. as per the change [6] a vCPU cannot be both
>>>      GICC.Enabled and GICC.online-capable. This means,
>>>         [ Link:https://bugzilla.tianocore.org/show_bug.cgi?id=3706  ]
>>>      a. If we have to support hot-unplug of the cold-booted vCPUs then
>> these MUST
>>>         be specified as GICC.online-capable in the MADT Table during boot
>> by the
>>>         firmware/Qemu. But this requirement conflicts with the requirement
>> to
>>>         support new Qemu changes with legacy OS which dont understand
>>>         MADT.GICC.online-capable Bit. Legacy OS during boot time will
>> ignore this
>>>         bit and hence these vCPUs will not appear on such OS. This is
>> unexpected
>>>         behaviour.
>>>      b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to
>> unplug
>>>         these cold-booted vCPUs from OS (which in actual should be blocked
>> by
>>>         returning error at Qemu) then features like 'kexec' will break.
>>>      c. As I understand, removal of the cold-booted vCPUs is a required
>> feature
>>>         and x86 world allows it.
>>>      d. Hence, either we need a specification change to make the
>> MADT.GICC.Enabled
>>>         and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT
>> support
>>>         removal of cold-booted vCPUs. In the later case, a check can be
>> introduced
>>>         to bar the users from unplugging vCPUs, which were cold-booted,
>> using QMP
>>>         commands. (Needs discussion!)
>>>         Please check below patch part of this patch-set:
>>>             [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled]
>>> 5. Code related to the notification to GICV3 about hot(un)plug of a vCPU
>> event
>>>      might need further discussion.
>>>
>>>
>>> (IX) THINGS TO DO
>>>        ============
>>>
>>> 1. Fix the Migration Issues
>>> 2. Fix issues related to TCG/Emulation support.
>>> 3. Comprehensive Testing. Current testing is very basic.
>>>      a. Negative Test cases
>>> 4. Qemu Documentation(.rst) need to be updated.
>>> 5. Fix qtest, HVF Support
>>> 6. Fix the design issue related to ACPI MADT.GICC flags discussed in
>> known
>>>      issues. This might require UEFI ACPI specification change!
>>> 7. Add ACPI _OSC 'Query' support. Only part of _OSC support exists now.
>>>
>>>    Above is *not* a complete list. Will update later!
>>>
>>> Best regards
>>> Salil.
>>>
>>> (X) DISCLAIMER
>>>       ==========
>>>
>>> This work is an attempt to present a proof-of-concept of the ARM64 vCPU
>> hotplug
>>> implementation to the community. This is *not* a production level code
>> and might
>>> have bugs. Only a basic testing has been done on HiSilicon Kunpeng920 SoC
>> for
>>> servers. Once the design and core idea behind the implementation has been
>>> verified more efforts can be put to harden the code.
>>>
>>> This work is *mostly* in the lines of the discussions which have happened
>> in the
>>> previous years[see refs below] across different channels like mailing-
>> list,
>>> Linaro Open Discussions platform, various conferences like KVMFourm etc.
>> This
>>> RFC is being used as a way to verify the idea mentioned in this cover-
>> letter and
>>> to get community views. Once this has been agreed, a formal patch shall
>> be
>>> posted to the mailing-list for review.
>>>
>>> [The concept being presented has been found to work!]
>>>
>>> (XI) ORGANIZATION OF PATCHES
>>>        =======================
>>>
>>>    A. All patches [Architecture 'agnostic' + 'specific']:
>>>
>>>      [Patch 1-9, 23, 36] logic required during machine init
>>>       (*) Some validation checks
>>>       (*) Introduces core-id property and some util functions required
>> later.
>>>       (*) Refactors Parking logic of vCPUs
>>>       (*) Logic to pre-create vCPUs
>>>       (*) GIC initialization pre-sized with possible vCPUs.
>>>       (*) Some refactoring to have common hot and cold plug logic
>> together.
>>>       (*) Release of disable QOM CPU objects in post_cpu_init()
>>>       (*) Support of ACPI _OSC method to negotiate platform hotplug
>> capabilities
>>>      [Patch 10-22] logic related to ACPI at machine init time
>>>       (*) Changes required to Enable ACPI for cpu hotplug
>>>       (*) Initialization ACPI GED framework to cater CPU Hotplug Events
>>>       (*) Build ACPI AML related to CPU control dev
>>>       (*) ACPI MADT/MAT changes
>>>      [Patch 24-35] Logic required during vCPU hot-(un)plug
>>>       (*) Basic framework changes to suppport vCPU hot-(un)plug
>>>       (*) ACPI GED changes for hot-(un)plug hooks.
>>>       (*) wire-unwire the IRQs
>>>       (*) GIC notification logic
>>>       (*) ARMCPU unrealize logic
>>>       (*) Handling of SMCC Hypercall Exits by KVM to Qemu
>>>
>>>    B. Architecture *agnostic* patches part of patch-set:
>>>
>>>      [Patch 5,9,11,13,16,20,24,31,33] Common logic to support hotplug
>>>       (*) Refactors Parking logic of vCPUs
>>>       (*) Introduces ACPI GED Support for vCPU Hotplug Events
>>>       (*) Introduces ACPI AML change for CPU Control Device
>>>
>>> (XII) REFERENCES
>>>         ==========
>>>
>>> [1]https://lore.kernel.org/qemu-devel/20200613213629.21984-1-
>> salil.mehta@huawei.com/
>>> [2]https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1-
>> salil.mehta@huawei.com/
>>> [3]https://lore.kernel.org/lkml/20230203135043.409192-1-
>> james.morse@arm.com/
>>> [4]https://lore.kernel.org/all/20230913163823.7880-1-
>> james.morse@arm.com/
>>> [5]https://lore.kernel.org/all/20230404154050.2270077-1-
>> oliver.upton@linux.dev/
>>> [6]https://bugzilla.tianocore.org/show_bug.cgi?id=3706
>>> [7]
>> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic
>> -cpu-interface-gicc-structure
>>> [8]https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
>>> [9]https://cloud.google.com/kubernetes-
>> engine/docs/concepts/verticalpodautoscaler
>>> [10]https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod-
>> autoscaler.html
>>> [11]https://lkml.org/lkml/2019/7/10/235
>>> [12]https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html
>>> [13]https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html
>>> [14]https://op-lists.linaro.org/archives/list/linaro-open-
>> discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/
>>> [15]http://lists.nongnu.org/archive/html/qemu-devel/2018-
>> 07/msg01168.html
>>> [16]https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html
>>> [17]https://op-lists.linaro.org/archives/list/linaro-open-
>> discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/
>>> [18]https://lore.kernel.org/lkml/20210608154805.216869-1-jean-
>> philippe@linaro.org/
>>> [19]https://lore.kernel.org/all/20230913163823.7880-1-
>> james.morse@arm.com/
>>> [20]
>> https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic
>> c-cpu-interface-flags
>>> (XIII) ACKNOWLEDGEMENTS
>>>          ================
>>>
>>> I would like to take this opportunity to thank below people for various
>>> discussions with me over different channels during the development:
>>>
>>> Marc Zyngier (Google)               Catalin Marinas (ARM),
>>> James Morse(ARM),                   Will Deacon (Google),
>>> Jean-Phillipe Brucker (Linaro),     Sudeep Holla (ARM),
>>> Lorenzo Pieralisi (Linaro),         Gavin Shan (Redhat),
>>> Jonathan Cameron (Huawei),          Darren Hart (Ampere),
>>> Igor Mamedov (Redhat),              Ilkka Koskinen (Ampere),
>>> Andrew Jones (Redhat),              Karl Heubaum (Oracle),
>>> Keqian Zhu (Huawei),                Miguel Luis (Oracle),
>>> Xiongfeng Wang (Huawei),            Vishnu Pajjuri (Ampere),
>>> Shameerali Kolothum (Huawei)        Russell King (Oracle)
>>> Xuwei/Joy (Huawei),                 Peter Maydel (Linaro)
>>> Zengtao/Prime (Huawei),             And all those whom I have missed!
>>>
>>> Many thanks to below people for their current or past contributions:
>>>
>>> 1. James Morse (ARM)
>>>      (Current Kernel part of vCPU Hotplug Support on AARCH64)
>>> 2. Jean-Philippe Brucker (Linaro)
>>>      (Protoyped one of the earlier PSCI based POC [17][18] based on RFC
>> V1)
>>> 3. Keqian Zhu (Huawei)
>>>      (Co-developed Qemu prototype)
>>> 4. Xiongfeng Wang (Huawei)
>>>      (Co-developed earlier kernel prototype)
>>> 5. Vishnu Pajjuri (Ampere)
>>>      (Verification on Ampere ARM64 Platforms + fixes)
>>> 6. Miguel Luis (Oracle)
>>>      (Verification on Oracle ARM64 Platforms + fixes)
>>>
>>>
>>> Author Salil Mehta (1):
>>>     target/arm/kvm,tcg: Register/Handle SMCCC hypercall exits to VMM/Qemu
>>>
>>> Jean-Philippe Brucker (2):
>>>     hw/acpi: Make _MAT method optional
>>>     target/arm/kvm: Write CPU state back to KVM on reset
>>>
>>> Miguel Luis (1):
>>>     tcg/mttcg: enable threads to unregister in tcg_ctxs[]
>>>
>>> Salil Mehta (33):
>>>     arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id
>> property
>>>     cpus-common: Add common CPU utility for possible vCPUs
>>>     hw/arm/virt: Move setting of common CPU properties in a function
>>>     arm/virt,target/arm: Machine init time change common to vCPU
>> {cold|hot}-plug
>>>     accel/kvm: Extract common KVM vCPU {creation,parking} code
>>>     arm/virt,kvm: Pre-create disabled possible vCPUs @machine init
>>>     arm/virt,gicv3: Changes to pre-size GIC with possible vcpus @machine
>> init
>>>     arm/virt: Init PMU at host for all possible vcpus
>>>     hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
>>>     arm/acpi: Enable ACPI support for vcpu hotplug
>>>     hw/acpi: Add ACPI CPU hotplug init stub
>>>     hw/acpi: Use qemu_present_cpu() API in ACPI CPU hotplug init
>>>     hw/acpi: Init GED framework with cpu hotplug events
>>>     arm/virt: Add cpu hotplug events to GED during creation
>>>     arm/virt: Create GED dev before *disabled* CPU Objs are destroyed
>>>     hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
>>>     arm/virt/acpi: Build CPUs AML with CPU Hotplug support
>>>     arm/virt: Make ARM vCPU *present* status ACPI *persistent*
>>>     hw/acpi: ACPI/AML Changes to reflect the correct _STA.{PRES,ENA} Bits
>> to Guest
>>>     hw/acpi: Update GED _EVT method AML with cpu scan
>>>     hw/arm: MADT Tbl change to size the guest with possible vCPUs
>>>     arm/virt: Release objects for *disabled* possible vCPUs after init
>>>     hw/acpi: Update ACPI GED framework to support vCPU Hotplug
>>>     arm/virt: Add/update basic hot-(un)plug framework
>>>     arm/virt: Changes to (un)wire GICC<->vCPU IRQs during hot-(un)plug
>>>     hw/arm,gicv3: Changes to update GIC with vCPU hot-plug notification
>>>     hw/intc/arm-gicv3*: Changes required to (re)init the vCPU register
>> info
>>>     arm/virt: Update the guest(via GED) about CPU hot-(un)plug events
>>>     hw/arm: Changes required for reset and to support next boot
>>>     physmem,gdbstub: Common helping funcs/changes to *unrealize* vCPU
>>>     target/arm: Add support of *unrealize* ARMCPU during vCPU Hot-unplug
>>>     hw/arm: Support hotplug capability check using _OSC method
>>>     hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled
>>>
>>>    accel/kvm/kvm-all.c                    |  61 +-
>>>    accel/tcg/tcg-accel-ops-mttcg.c        |   1 +
>>>    cpus-common.c                          |  37 ++
>>>    gdbstub/gdbstub.c                      |  13 +
>>>    hw/acpi/acpi-cpu-hotplug-stub.c        |   6 +
>>>    hw/acpi/cpu.c                          |  91 ++-
>>>    hw/acpi/generic_event_device.c         |  33 +
>>>    hw/arm/Kconfig                         |   1 +
>>>    hw/arm/boot.c                          |   2 +-
>>>    hw/arm/virt-acpi-build.c               | 110 +++-
>>>    hw/arm/virt.c                          | 863 ++++++++++++++++++++-----
>>>    hw/core/gpio.c                         |   2 +-
>>>    hw/i386/acpi-build.c                   |   2 +-
>>>    hw/intc/arm_gicv3.c                    |   1 +
>>>    hw/intc/arm_gicv3_common.c             |  66 +-
>>>    hw/intc/arm_gicv3_cpuif.c              | 265 ++++----
>>>    hw/intc/arm_gicv3_cpuif_common.c       |   5 +
>>>    hw/intc/arm_gicv3_kvm.c                |  39 +-
>>>    hw/intc/gicv3_internal.h               |   2 +
>>>    include/exec/cpu-common.h              |   8 +
>>>    include/exec/gdbstub.h                 |   1 +
>>>    include/hw/acpi/cpu.h                  |   7 +-
>>>    include/hw/acpi/cpu_hotplug.h          |   4 +
>>>    include/hw/acpi/generic_event_device.h |   5 +
>>>    include/hw/arm/boot.h                  |   2 +
>>>    include/hw/arm/virt.h                  |  10 +-
>>>    include/hw/core/cpu.h                  |  77 +++
>>>    include/hw/intc/arm_gicv3_common.h     |  23 +
>>>    include/hw/qdev-core.h                 |   2 +
>>>    include/sysemu/kvm.h                   |   2 +
>>>    include/tcg/tcg.h                      |   1 +
>>>    softmmu/physmem.c                      |  25 +
>>>    target/arm/arm-powerctl.c              |  51 +-
>>>    target/arm/cpu-qom.h                   |   3 +
>>>    target/arm/cpu.c                       | 112 ++++
>>>    target/arm/cpu.h                       |  17 +
>>>    target/arm/cpu64.c                     |  15 +
>>>    target/arm/gdbstub.c                   |   6 +
>>>    target/arm/helper.c                    |  27 +-
>>>    target/arm/internals.h                 |  12 +-
>>>    target/arm/kvm.c                       |  93 ++-
>>>    target/arm/kvm64.c                     |  59 +-
>>>    target/arm/kvm_arm.h                   |  24 +
>>>    target/arm/meson.build                 |   1 +
>>>    target/arm/{tcg => }/psci.c            |   8 +
>>>    target/arm/tcg/meson.build             |   4 -
>>>    tcg/tcg.c                              |  23 +
>>>    47 files changed, 1873 insertions(+), 349 deletions(-)
>>>    rename target/arm/{tcg => }/psci.c (97%)
>> Tested on Ampere's platform for vCPU hotplug/unplug with reboot,
>> suspend/resume and save/restore.
>> Also tested for vCPU hotplug/unplug along with VM live migration.
>>
>> Please feel free to add,
>> Tested-by: Vishnu Pajjuri<vishnu@os.amperecomputing.com>
> Many thanks for this.
>
> As you are aware, we have now split above patch-set into:
>
> 1. Architecture agnostic patch-set (being reviewed below)
>     https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/#t
> 2. ARM specific patch-set (Would soon be following as RFC V3)
>
>
> If possible, can I request you to sanity test the Architecture
> agnostic patch-set as well for regression and provide the
> Tested-by Tag for this patch-set as well?

Sure, I'll do.

> This is to ensure these changes if accepted do not break any
> existing features.
>
>
> Many thanks again for your past efforts all these times!
It was great working experience with you.
And my pleasure to contribute to new feature like vCPU hotplug on ARM64 
platform.

_Regards_,
-Vishnu
>
> Cheers
> Salil.
>
>
--------------Rox80qaG0QIKoVLQOf2ozQRh
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Salil,<br>
    </p>
    <div class="moz-cite-prefix">On 11-10-2023 16:02, Salil Mehta wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:c6eb2290323644e89c40c834bb934f62@huawei.com">
      <pre class="moz-quote-pre" wrap="">[EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]


Hi Vishnu,

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">From: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@amperemail.onmicrosoft.com">&lt;vishnu@amperemail.onmicrosoft.com&gt;</a>
Sent: Wednesday, October 11, 2023 11:23 AM
To: Salil Mehta <a class="moz-txt-link-rfc2396E" href="mailto:salil.mehta@huawei.com">&lt;salil.mehta@huawei.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>; qemu-
<a class="moz-txt-link-abbreviated" href="mailto:arm@nongnu.org">arm@nongnu.org</a>
Cc: <a class="moz-txt-link-abbreviated" href="mailto:maz@kernel.org">maz@kernel.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:jean-philippe@linaro.org">jean-philippe@linaro.org</a>; Jonathan Cameron
<a class="moz-txt-link-rfc2396E" href="mailto:jonathan.cameron@huawei.com">&lt;jonathan.cameron@huawei.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:lpieralisi@kernel.org">lpieralisi@kernel.org</a>;
<a class="moz-txt-link-abbreviated" href="mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>;
<a class="moz-txt-link-abbreviated" href="mailto:imammedo@redhat.com">imammedo@redhat.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:andrew.jones@linux.dev">andrew.jones@linux.dev</a>; <a class="moz-txt-link-abbreviated" href="mailto:david@redhat.com">david@redhat.com</a>;
<a class="moz-txt-link-abbreviated" href="mailto:philmd@linaro.org">philmd@linaro.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:eric.auger@redhat.com">eric.auger@redhat.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:will@kernel.org">will@kernel.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:ardb@kernel.org">ardb@kernel.org</a>;
<a class="moz-txt-link-abbreviated" href="mailto:oliver.upton@linux.dev">oliver.upton@linux.dev</a>; <a class="moz-txt-link-abbreviated" href="mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:mst@redhat.com">mst@redhat.com</a>;
<a class="moz-txt-link-abbreviated" href="mailto:gshan@redhat.com">gshan@redhat.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:rafael@kernel.org">rafael@kernel.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:borntraeger@linux.ibm.com">borntraeger@linux.ibm.com</a>;
<a class="moz-txt-link-abbreviated" href="mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>; <a class="moz-txt-link-abbreviated" href="mailto:linux@armlinux.org.uk">linux@armlinux.org.uk</a>;
<a class="moz-txt-link-abbreviated" href="mailto:darren@os.amperecomputing.com">darren@os.amperecomputing.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:ilkka@os.amperecomputing.com">ilkka@os.amperecomputing.com</a>;
<a class="moz-txt-link-abbreviated" href="mailto:vishnu@os.amperecomputing.com">vishnu@os.amperecomputing.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:karl.heubaum@oracle.com">karl.heubaum@oracle.com</a>;
<a class="moz-txt-link-abbreviated" href="mailto:miguel.luis@oracle.com">miguel.luis@oracle.com</a>; <a class="moz-txt-link-abbreviated" href="mailto:salil.mehta@opnsrc.net">salil.mehta@opnsrc.net</a>; zhukeqian
<a class="moz-txt-link-rfc2396E" href="mailto:zhukeqian1@huawei.com">&lt;zhukeqian1@huawei.com&gt;</a>; wangxiongfeng (C) <a class="moz-txt-link-rfc2396E" href="mailto:wangxiongfeng2@huawei.com">&lt;wangxiongfeng2@huawei.com&gt;</a>;
wangyanan (Y) <a class="moz-txt-link-rfc2396E" href="mailto:wangyanan55@huawei.com">&lt;wangyanan55@huawei.com&gt;</a>; <a class="moz-txt-link-abbreviated" href="mailto:jiakernel2@gmail.com">jiakernel2@gmail.com</a>;
<a class="moz-txt-link-abbreviated" href="mailto:maobibo@loongson.cn">maobibo@loongson.cn</a>; <a class="moz-txt-link-abbreviated" href="mailto:lixianglai@loongson.cn">lixianglai@loongson.cn</a>
Subject: Re: [PATCH RFC V2 00/37] Support of Virtual CPU Hotplug for ARMv8
Arch

Hi Salil,

On 26-09-2023 15:33, Salil Mehta wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[ *REPEAT: Sent patches got held at internal server yesterday* ]

PROLOGUE
========

To assist in review and set the right expectations from this RFC, please
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">first
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">read below sections *APPENDED AT THE END* of this cover letter,

1. Important *DISCLAIMER* [Section (X)]
2. Work presented at KVMForum Conference (slides available) [Section
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(V)F]
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">3. Organization of patches [Section (XI)]
4. References [Section (XII)]
5. Detailed TODO list of the leftover work or work-in-progress [Section
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(IX)]
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
NOTE: There has been an interest shown by other organizations in adapting
this series for their architecture. I am planning to split this RFC into
architecture *agnostic* and *specific* patch-sets in subsequent releases.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">ARM
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">specific patch-set will continue as RFC V3 and architecture agnostic
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">patch-set
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">will be floated without RFC tag and can be consumed in this Qemu cycle if
MAINTAINERs ack it.

[Please check section (XI)B for details of architecture agnostic patches]


SECTIONS [I - XIII] are as follows :

(I) Key Changes (RFC V1 -&gt; RFC V2)
     ==================================

     RFC V1: <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20200613213629.21984-1">https://lore.kernel.org/qemu-devel/20200613213629.21984-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:salil.mehta@huawei.com/">salil.mehta@huawei.com/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
1. ACPI MADT Table GIC CPU Interface can now be presented [6] as ACPI
    *online-capable* or *enabled* to the Guest OS at the boot time. This
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">means
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    associated CPUs can have ACPI _STA as *enabled* or *disabled* even
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">after boot
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    See, UEFI ACPI 6.5 Spec, Section 05, Table 5.37 GICC CPU Interface
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Flags[20]
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">2. SMCC/HVC Hypercall exit handling in userspace/Qemu for PSCI
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">CPU_{ON,OFF}
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    request. This is required to {dis}allow online'ing a vCPU.
3. Always presenting unplugged vCPUs in CPUs ACPI AML code as ACPI
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">_STA.PRESENT
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    to the Guest OS. Toggling ACPI _STA.Enabled to give an effect of the
    hot{un}plug.
4. Live Migration works (some issues are still there)
5. TCG/HVF/qtest does not support Hotplug and falls back to default.
6. Code for TCG support do exists in this release (it is a work-in-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">progress)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">7. ACPI _OSC method can now be used by OSPM to negotiate Qemu VM platform
    hotplug capability (_OSC Query support still pending)
8. Misc. Bug fixes

(II) Summary
      =======

This patch-set introduces the virtual CPU hotplug support for ARMv8
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">architecture
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">in QEMU. Idea is to be able to hotplug and hot-unplug the vCPUs while
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">guest VM
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">is running and no reboot is required. This does *not* makes any
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">assumption of
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">the physical CPU hotplug availability within the host system but rather
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">tries to
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">solve the problem at virtualizer/QEMU layer. Introduces ACPI CPU hotplug
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">hooks
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">and event handling to interface with the guest kernel, code to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">initialize, plug
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">and unplug CPUs. No changes are required within the host kernel/KVM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">except the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">support of hypercall exit handling in the user-space/Qemu which has
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">recently
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">been added to the kernel. Its corresponding Guest kernel changes have
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">been
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">posted on the mailing-list [3] [4] by James Morse.

(III) Motivation
       ==========

This allows scaling the guest VM compute capacity on-demand which would
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">be
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">useful for the following example scenarios,

1. Vertical Pod Autoscaling [9][10] in the cloud: Part of the
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">orchestration
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    framework which could adjust resource requests (CPU and Mem requests)
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">for
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    the containers in a pod, based on usage.
2. Pay-as-you-grow Business Model: Infrastructure provider could allocate
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">and
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    restrict the total number of compute resources available to the guest
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">VM
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    according to the SLA (Service Level Agreement). VM owner could
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">request for
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    more compute to be hot-plugged for some cost.

For example, Kata Container VM starts with a minimum amount of resources
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(i.e.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">hotplug everything approach). why?

1. Allowing faster *boot time* and
2. Reduction in *memory footprint*

Kata Container VM can boot with just 1 vCPU and then later more vCPUs can
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">be
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">hot-plugged as per requirement.

(IV) Terminology
      ===========

(*) Posssible CPUs: Total vCPUs which could ever exist in VM. This
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">includes
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     any cold booted CPUs plus any CPUs which could be
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">later
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     hot-plugged.
                     - Qemu parameter(-smp maxcpus=N)
(*) Present CPUs:   Possible CPUs which are ACPI 'present'. These might
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">or might
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     not be ACPI 'enabled'.
                     - Present vCPUs = Possible vCPUs (Always on ARM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Arch)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">(*) Enabled CPUs:   Possible CPUs which are ACPI ‘present’ and 'enabled'
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">and can
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     now be ‘onlined’ (PSCI) for use by Guest Kernel. All
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">cold
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     booted vCPUs are ACPI 'enabled' at boot. Later,
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">using
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     device_add more vCPUs can be hotplugged and be made
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">ACPI
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                     'enabled.
                     - Qemu parameter(-smp cpus=N). Can be used to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">specify some
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                  cold booted vCPUs during VM init. Some can be added using
                  '-device' option.

(V) Constraints Due To ARMv8 CPU Architecture [+] Other Impediments
     ===============================================================

A. Physical Limitation to Support CPU Hotplug: (Architectural Constraint)
    1. ARMv8 CPU architecture does not support the concept of the
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">physical CPU
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       hotplug.
       a. There are many per-CPU components like PMU, SVE, MTE, Arch
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">timers etc.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">          whose behaviour need to be clearly defined when CPU is
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">hot(un)plugged.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">          There is no specification for this.

    2. Other ARM components like GIC etc. have not been designed to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">realize
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       physical CPU hotplug capability as of now. For example,
       a. Every physical CPU has a unique GICC (GIC CPU Interface) by
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">construct.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">          Architecture does not specifies what CPU hot(un)plug would mean
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">in
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">          context to any of these.
       b. CPUs/GICC are physically connected to unique GICR (GIC
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Redistributor).
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">          GIC Redistributors are always part of always-on power domain.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Hence,
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">          cannot be powered-off as per specification.

B. Impediments in Firmware/ACPI (Architectural Constraint)

    1. Firmware has to expose GICC, GICR and other per-CPU features like
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">PMU,
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       SVE, MTE, Arch Timers etc. to the OS. Due to architectural
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">constraint
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       stated in above section A1(a),  all interrupt controller
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">structures of
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       MADT describing GIC CPU Interfaces and the GIC Redistibutors MUST
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">be
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       presented by firmware to the OSPM during the boot time.
    2. Architectures that support CPU hotplug can evaluate ACPI _MAT
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">method to
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       get this kind of information from the firmware even after boot and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       OSPM has capability to process these. ARM kernel uses information
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">in MADT
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       interrupt controller structures to identify number of Present CPUs
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">during
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       boot and hence does not allow to change these after boot. Number
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">of
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       present CPUs cannot be changed. It is an architectural constraint!

C. Impediments in KVM to Support Virtual CPU Hotplug (Architectural
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Constraint)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
    1. KVM VGIC:
        a. Sizing of various VGIC resources like memory regions etc.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">related to
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           the redistributor happens only once and is fixed at the VM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">init time
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           and cannot be changed later after initialization has happened.
           KVM statically configures these resources based on the number
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">of vCPUs
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           and the number/size of redistributor ranges.
        b. Association between vCPU and its VGIC redistributor is fixed
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">at the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           VM init time within the KVM i.e. when redistributor iodevs
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">gets
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           registered. VGIC does not allows to setup/change this
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">association
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           after VM initialization has happened. Physically, every
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">CPU/GICC is
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           uniquely connected with its redistributor and there is no
           architectural way to set this up.
    2. KVM vCPUs:
        a. Lack of specification means destruction of KVM vCPUs does not
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">exist as
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           there is no reference to tell what to do with other per-vCPU
           components like redistributors, arch timer etc.
        b. Infact, KVM does not implements destruction of vCPUs for any
           architecture. This is independent of the fact whether
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">architecture
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           actually supports CPU Hotplug feature. For example, even for
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">x86 KVM
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">           does not implements destruction of vCPUs.

D. Impediments in Qemu to Support Virtual CPU Hotplug (KVM Constraints-
Arch)

    1. Qemu CPU Objects MUST be created to initialize all the Host KVM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">vCPUs to
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       overcome the KVM constraint. KVM vCPUs are created, initialized
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">when Qemu
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       CPU Objects are realized. But keepinsg the QOM CPU objects
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">realized for
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       'yet-to-be-plugged' vCPUs can create problems when these new vCPUs
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">shall
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       be plugged using device_add and a new QOM CPU object shall be
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">created.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    2. GICV3State and GICV3CPUState objects MUST be sized over *possible
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">vCPUs*
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       during VM init time while QOM GICV3 Object is realized. This is
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">because
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       KVM VGIC can only be initialized once during init time. But every
       GICV3CPUState has an associated QOM CPU Object. Later might
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">corresponds to
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       vCPU which are 'yet-to-be-plugged'(unplugged at init).
    3. How should new QOM CPU objects be connected back to the
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">GICV3CPUState
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       objects and disconnected from it in case CPU is being
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">hot(un)plugged?
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    4. How should 'unplugged' or 'yet-to-be-plugged' vCPUs be represented
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">in the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       QOM for which KVM vCPU already exists? For example, whether to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">keep,
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">        a. No QOM CPU objects Or
        b. Unrealized CPU Objects
    5. How should vCPU state be exposed via ACPI to the Guest? Especially
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">for
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       the unplugged/yet-to-be-plugged vCPUs whose CPU objects might not
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">exists
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       within the QOM but the Guest always expects all possible vCPUs to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">be
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       identified as ACPI *present* during boot.
    6. How should Qemu expose GIC CPU interfaces for the unplugged or
       yet-to-beplugged vCPUs using ACPI MADT Table to the Guest?

E. Summary of Approach ([+] Workarounds to problems in sections A, B, C &amp;
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">D)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
    1. At VM Init, pre-create all the possible vCPUs in the Host KVM i.e.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">even
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       for the vCPUs which are yet-to-be-plugged in Qemu but keep them in
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       powered-off state.
    2. After the KVM vCPUs have been initialized in the Host, the KVM
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">vCPU
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       objects corresponding to the unplugged/yet-to-be-plugged vCPUs are
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">parked
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       at the existing per-VM &quot;kvm_parked_vcpus&quot; list in Qemu. (similar
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">to x86)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    3. GICV3State and GICV3CPUState objects are sized over possible vCPUs
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">during
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       VM init time i.e. when Qemu GIC is realized. This in turn sizes
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">KVM VGIC
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       resources like memory regions etc. related to the redistributors
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">with the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       number of possible KVM vCPUs. This never changes after VM has
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">initialized.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    4. Qemu CPU objects corresponding to unplugged/yet-to-be-plugged
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">vCPUs are
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       released post Host KVM CPU and GIC/VGIC initialization.
    5. Build ACPI MADT Table with below updates
       a. Number of GIC CPU interface entries (=possible vCPUs)
       b. Present Boot vCPU as MADT.GICC.Enabled=1 (Not hot[un]pluggable)
       c. Present hot(un)pluggable vCPUs as MADT.GICC.online-capable=1
          - MADT.GICC.Enabled=0 (Mutually exclusive) [6][7]
     - vCPU can be ACPI enabled+onlined after Guest boots (Firmware
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Policy)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">     - Some issues with above (details in later sections)
    6. Expose below ACPI Status to Guest kernel
       a. Always _STA.Present=1 (all possible vCPUs)
       b. _STA.Enabled=1 (plugged vCPUs)
       c. _STA.Enabled=0 (unplugged vCPUs)
    7. vCPU hotplug *realizes* new QOM CPU object. Following happens,
       a. Realizes, initializes QOM CPU Object &amp; spawns Qemu vCPU thread
       b. Unparks the existing KVM vCPU (&quot;kvm_parked_vcpus&quot; list)
          - Attaches to QOM CPU object.
       c. Reinitializes KVM vCPU in the Host
          - Resets the core and sys regs, sets defaults etc.
       d. Runs KVM vCPU (created with &quot;start-powered-off&quot;)
     - vCPU thread sleeps (waits for vCPU reset via PSCI)
       e. Updates Qemu GIC
          - Wires back IRQs related to this vCPU.
          - GICV3CPUState association with QOM CPU Object.
       f. Updates [6] ACPI _STA.Enabled=1
       g. Notifies Guest about new vCPU (via ACPI GED interface)
     - Guest checks _STA.Enabled=1
     - Guest adds processor (registers CPU with LDM) [3]
       h. Plugs the QOM CPU object in the slot.
          - slot-number = cpu-index{socket,cluster,core,thread}
       i. Guest online's vCPU (CPU_ON PSCI call over HVC/SMC)
          - KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
          - Qemu powers-on KVM vCPU in the Host
    8. vCPU hot-unplug *unrealizes* QOM CPU Object. Following happens,
       a. Notifies Guest (via ACPI GED interface) vCPU hot-unplug event
          - Guest offline's vCPU (CPU_OFF PSCI call over HVC/SMC)
       b. KVM exits HVC/SMC Hypercall [5] to Qemu (Policy Check).
          - Qemu powers-off the KVM vCPU in the Host
       c Guest signals *Eject* vCPU to Qemu
       d. Qemu updates [6] ACPI _STA.Enabled=0
       e. Updates GIC
          - Un-wires IRQs related to this vCPU
          - GICV3CPUState association with new QOM CPU Object is updated.
       f. Unplugs the vCPU
     - Removes from slot
          - Parks KVM vCPU (&quot;kvm_parked_vcpus&quot; list)
          - Unrealizes QOM CPU Object &amp; joins back Qemu vCPU thread
     - Destroys QOM CPU object
       g. Guest checks ACPI _STA.Enabled=0
          - Removes processor (unregisters CPU with LDM) [3]

F. Work Presented at KVM Forum Conferences:
    Details of above work has been presented at KVMForum2020 and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">KVMForum2023
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    conferences. Slides are available at below links,
    a. KVMForum 2023
       - Challenges Revisited in Supporting Virt CPU Hotplug on
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">architectures that don't Support CPU Hotplug (like ARM64)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">         <a class="moz-txt-link-freetext" href="https://kvm-forum.qemu.org/2023/talk/9SMPDQ/">https://kvm-forum.qemu.org/2023/talk/9SMPDQ/</a>
    b. KVMForum 2020
       - Challenges in Supporting Virtual CPU Hotplug on SoC Based
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Systems (like ARM64) - Salil Mehta, Huawei
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">         <a class="moz-txt-link-freetext" href="https://sched.co/eE4m">https://sched.co/eE4m</a>

(VI) Commands Used
      =============

     A. Qemu launch commands to init the machine

     $ qemu-system-aarch64 --enable-kvm -machine virt,gic-version=3 \
     -cpu host -smp cpus=4,maxcpus=6 \
     -m 300M \
     -kernel Image \
     -initrd rootfs.cpio.gz \
     -append &quot;console=ttyAMA0 root=/dev/ram rdinit=/init maxcpus=2
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">acpi=force&quot; \
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">     -nographic \
     -bios  QEMU_EFI.fd \

     B. Hot-(un)plug related commands

     # Hotplug a host vCPU(accel=kvm)
     $ device_add host-arm-cpu,id=core4,core-id=4

     # Hotplug a vCPU(accel=tcg)
     $ device_add cortex-a57-arm-cpu,id=core4,core-id=4

     # Delete the vCPU
     $ device_del core4

     Sample output on guest after boot:

     $ cat /sys/devices/system/cpu/possible
     0-5
     $ cat /sys/devices/system/cpu/present
     0-5
     $ cat /sys/devices/system/cpu/enabled
     0-3
     $ cat /sys/devices/system/cpu/online
     0-1
     $ cat /sys/devices/system/cpu/offline
     2-5

     Sample output on guest after hotplug of vCPU=4:

     $ cat /sys/devices/system/cpu/possible
     0-5
     $ cat /sys/devices/system/cpu/present
     0-5
     $ cat /sys/devices/system/cpu/enabled
     0-4
     $ cat /sys/devices/system/cpu/online
     0-1,4
     $ cat /sys/devices/system/cpu/offline
     2-3,5

     Note: vCPU=4 was explicitly 'onlined' after hot-plug
     $ echo 1 &gt; /sys/devices/system/cpu/cpu4/online

(VII) Repository
       ==========

  (*) QEMU changes for vCPU hotplug could be cloned from below site,
      <a class="moz-txt-link-freetext" href="https://github.com/salil-mehta/qemu.git">https://github.com/salil-mehta/qemu.git</a> virt-cpuhp-armv8/rfc-v2
  (*) Guest Kernel changes (by James Morse, ARM) are available here:
      <a class="moz-txt-link-freetext" href="https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git">https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git</a>
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">virtual_cpu_hotplug/rfc/v2
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">

(VIII) KNOWN ISSUES
        ============

1. Migration has been lightly tested. Below are some of the known issues:
    - Ocassional CPU stall (not always repeatable)
    - Negative test case like asymmetric source/destination VM config
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">causes dump.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    - Migration with TCG is not working properly.
2. TCG with Single threaded mode is broken.
3. HVF and qtest support is broken.
4. ACPI MADT Table flags [7] MADT.GICC.Enabled and MADT.GICC.online-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">capable are
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    mutually exclusive i.e. as per the change [6] a vCPU cannot be both
    GICC.Enabled and GICC.online-capable. This means,
       [ Link: <a class="moz-txt-link-freetext" href="https://bugzilla.tianocore.org/show_bug.cgi?id=3706">https://bugzilla.tianocore.org/show_bug.cgi?id=3706</a> ]
    a. If we have to support hot-unplug of the cold-booted vCPUs then
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">these MUST
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       be specified as GICC.online-capable in the MADT Table during boot
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">by the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       firmware/Qemu. But this requirement conflicts with the requirement
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">to
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       support new Qemu changes with legacy OS which dont understand
       MADT.GICC.online-capable Bit. Legacy OS during boot time will
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">ignore this
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       bit and hence these vCPUs will not appear on such OS. This is
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">unexpected
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       behaviour.
    b. In case we decide to specify vCPUs as MADT.GICC.Enabled and try to
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">unplug
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       these cold-booted vCPUs from OS (which in actual should be blocked
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">by
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       returning error at Qemu) then features like 'kexec' will break.
    c. As I understand, removal of the cold-booted vCPUs is a required
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">feature
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       and x86 world allows it.
    d. Hence, either we need a specification change to make the
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">MADT.GICC.Enabled
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       and MADT.GICC.online-capable Bits NOT mutually exclusive or NOT
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">support
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       removal of cold-booted vCPUs. In the later case, a check can be
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">introduced
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       to bar the users from unplugging vCPUs, which were cold-booted,
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">using QMP
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">       commands. (Needs discussion!)
       Please check below patch part of this patch-set:
           [hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled]
5. Code related to the notification to GICV3 about hot(un)plug of a vCPU
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">event
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    might need further discussion.


(IX) THINGS TO DO
      ============

1. Fix the Migration Issues
2. Fix issues related to TCG/Emulation support.
3. Comprehensive Testing. Current testing is very basic.
    a. Negative Test cases
4. Qemu Documentation(.rst) need to be updated.
5. Fix qtest, HVF Support
6. Fix the design issue related to ACPI MADT.GICC flags discussed in
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">known
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    issues. This might require UEFI ACPI specification change!
7. Add ACPI _OSC 'Query' support. Only part of _OSC support exists now.

  Above is *not* a complete list. Will update later!

Best regards
Salil.

(X) DISCLAIMER
     ==========

This work is an attempt to present a proof-of-concept of the ARM64 vCPU
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">hotplug
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">implementation to the community. This is *not* a production level code
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">and might
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">have bugs. Only a basic testing has been done on HiSilicon Kunpeng920 SoC
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">for
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">servers. Once the design and core idea behind the implementation has been
verified more efforts can be put to harden the code.

This work is *mostly* in the lines of the discussions which have happened
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">in the
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">previous years[see refs below] across different channels like mailing-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">list,
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Linaro Open Discussions platform, various conferences like KVMFourm etc.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">This
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">RFC is being used as a way to verify the idea mentioned in this cover-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">letter and
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">to get community views. Once this has been agreed, a formal patch shall
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">be
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">posted to the mailing-list for review.

[The concept being presented has been found to work!]

(XI) ORGANIZATION OF PATCHES
      =======================

  A. All patches [Architecture 'agnostic' + 'specific']:

    [Patch 1-9, 23, 36] logic required during machine init
     (*) Some validation checks
     (*) Introduces core-id property and some util functions required
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">later.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">     (*) Refactors Parking logic of vCPUs
     (*) Logic to pre-create vCPUs
     (*) GIC initialization pre-sized with possible vCPUs.
     (*) Some refactoring to have common hot and cold plug logic
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">together.
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">     (*) Release of disable QOM CPU objects in post_cpu_init()
     (*) Support of ACPI _OSC method to negotiate platform hotplug
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">capabilities
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">    [Patch 10-22] logic related to ACPI at machine init time
     (*) Changes required to Enable ACPI for cpu hotplug
     (*) Initialization ACPI GED framework to cater CPU Hotplug Events
     (*) Build ACPI AML related to CPU control dev
     (*) ACPI MADT/MAT changes
    [Patch 24-35] Logic required during vCPU hot-(un)plug
     (*) Basic framework changes to suppport vCPU hot-(un)plug
     (*) ACPI GED changes for hot-(un)plug hooks.
     (*) wire-unwire the IRQs
     (*) GIC notification logic
     (*) ARMCPU unrealize logic
     (*) Handling of SMCC Hypercall Exits by KVM to Qemu

  B. Architecture *agnostic* patches part of patch-set:

    [Patch 5,9,11,13,16,20,24,31,33] Common logic to support hotplug
     (*) Refactors Parking logic of vCPUs
     (*) Introduces ACPI GED Support for vCPU Hotplug Events
     (*) Introduces ACPI AML change for CPU Control Device

(XII) REFERENCES
       ==========

[1] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20200613213629.21984-1">https://lore.kernel.org/qemu-devel/20200613213629.21984-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:salil.mehta@huawei.com/">salil.mehta@huawei.com/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[2] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1">https://lore.kernel.org/linux-arm-kernel/20200625133757.22332-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:salil.mehta@huawei.com/">salil.mehta@huawei.com/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[3] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/lkml/20230203135043.409192-1">https://lore.kernel.org/lkml/20230203135043.409192-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:james.morse@arm.com/">james.morse@arm.com/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[4] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230913163823.7880-1">https://lore.kernel.org/all/20230913163823.7880-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:james.morse@arm.com/">james.morse@arm.com/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[5] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230404154050.2270077-1">https://lore.kernel.org/all/20230404154050.2270077-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:oliver.upton@linux.dev/">oliver.upton@linux.dev/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[6] <a class="moz-txt-link-freetext" href="https://bugzilla.tianocore.org/show_bug.cgi?id=3706">https://bugzilla.tianocore.org/show_bug.cgi?id=3706</a>
[7]
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic">https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic</a>
-cpu-interface-gicc-structure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[8] <a class="moz-txt-link-freetext" href="https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5">https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5</a>
[9] <a class="moz-txt-link-freetext" href="https://cloud.google.com/kubernetes">https://cloud.google.com/kubernetes</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">engine/docs/concepts/verticalpodautoscaler
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[10] <a class="moz-txt-link-freetext" href="https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod">https://docs.aws.amazon.com/eks/latest/userguide/vertical-pod</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">autoscaler.html
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[11] <a class="moz-txt-link-freetext" href="https://lkml.org/lkml/2019/7/10/235">https://lkml.org/lkml/2019/7/10/235</a>
[12] <a class="moz-txt-link-freetext" href="https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html">https://lists.cs.columbia.edu/pipermail/kvmarm/2018-July/032316.html</a>
[13] <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html">https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg06517.html</a>
[14] <a class="moz-txt-link-freetext" href="https://op-lists.linaro.org/archives/list/linaro-open">https://op-lists.linaro.org/archives/list/linaro-open</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/">discussions@op-lists.linaro.org/thread/7CGL6JTACPUZEYQC34CZ2ZBWJGSR74WE/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[15] <a class="moz-txt-link-freetext" href="http://lists.nongnu.org/archive/html/qemu-devel/2018">http://lists.nongnu.org/archive/html/qemu-devel/2018</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">07/msg01168.html
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[16] <a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html">https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg00131.html</a>
[17] <a class="moz-txt-link-freetext" href="https://op-lists.linaro.org/archives/list/linaro-open">https://op-lists.linaro.org/archives/list/linaro-open</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/">discussions@op-lists.linaro.org/message/X74JS6P2N4AUWHHATJJVVFDI2EMDZJ74/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[18] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/lkml/20210608154805.216869-1-jean">https://lore.kernel.org/lkml/20210608154805.216869-1-jean</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:philippe@linaro.org/">philippe@linaro.org/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[19] <a class="moz-txt-link-freetext" href="https://lore.kernel.org/all/20230913163823.7880-1">https://lore.kernel.org/all/20230913163823.7880-1</a>-
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-abbreviated" href="mailto:james.morse@arm.com/">james.morse@arm.com/</a>
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">[20]
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic">https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#gic</a>
c-cpu-interface-flags
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">
(XIII) ACKNOWLEDGEMENTS
        ================

I would like to take this opportunity to thank below people for various
discussions with me over different channels during the development:

Marc Zyngier (Google)               Catalin Marinas (ARM),
James Morse(ARM),                   Will Deacon (Google),
Jean-Phillipe Brucker (Linaro),     Sudeep Holla (ARM),
Lorenzo Pieralisi (Linaro),         Gavin Shan (Redhat),
Jonathan Cameron (Huawei),          Darren Hart (Ampere),
Igor Mamedov (Redhat),              Ilkka Koskinen (Ampere),
Andrew Jones (Redhat),              Karl Heubaum (Oracle),
Keqian Zhu (Huawei),                Miguel Luis (Oracle),
Xiongfeng Wang (Huawei),            Vishnu Pajjuri (Ampere),
Shameerali Kolothum (Huawei)        Russell King (Oracle)
Xuwei/Joy (Huawei),                 Peter Maydel (Linaro)
Zengtao/Prime (Huawei),             And all those whom I have missed!

Many thanks to below people for their current or past contributions:

1. James Morse (ARM)
    (Current Kernel part of vCPU Hotplug Support on AARCH64)
2. Jean-Philippe Brucker (Linaro)
    (Protoyped one of the earlier PSCI based POC [17][18] based on RFC
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">V1)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">3. Keqian Zhu (Huawei)
    (Co-developed Qemu prototype)
4. Xiongfeng Wang (Huawei)
    (Co-developed earlier kernel prototype)
5. Vishnu Pajjuri (Ampere)
    (Verification on Ampere ARM64 Platforms + fixes)
6. Miguel Luis (Oracle)
    (Verification on Oracle ARM64 Platforms + fixes)


Author Salil Mehta (1):
   target/arm/kvm,tcg: Register/Handle SMCCC hypercall exits to VMM/Qemu

Jean-Philippe Brucker (2):
   hw/acpi: Make _MAT method optional
   target/arm/kvm: Write CPU state back to KVM on reset

Miguel Luis (1):
   tcg/mttcg: enable threads to unregister in tcg_ctxs[]

Salil Mehta (33):
   arm/virt,target/arm: Add new ARMCPU {socket,cluster,core,thread}-id
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">property
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">   cpus-common: Add common CPU utility for possible vCPUs
   hw/arm/virt: Move setting of common CPU properties in a function
   arm/virt,target/arm: Machine init time change common to vCPU
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">{cold|hot}-plug
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">   accel/kvm: Extract common KVM vCPU {creation,parking} code
   arm/virt,kvm: Pre-create disabled possible vCPUs @machine init
   arm/virt,gicv3: Changes to pre-size GIC with possible vcpus @machine
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">init
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">   arm/virt: Init PMU at host for all possible vcpus
   hw/acpi: Move CPU ctrl-dev MMIO region len macro to common header file
   arm/acpi: Enable ACPI support for vcpu hotplug
   hw/acpi: Add ACPI CPU hotplug init stub
   hw/acpi: Use qemu_present_cpu() API in ACPI CPU hotplug init
   hw/acpi: Init GED framework with cpu hotplug events
   arm/virt: Add cpu hotplug events to GED during creation
   arm/virt: Create GED dev before *disabled* CPU Objs are destroyed
   hw/acpi: Update CPUs AML with cpu-(ctrl)dev change
   arm/virt/acpi: Build CPUs AML with CPU Hotplug support
   arm/virt: Make ARM vCPU *present* status ACPI *persistent*
   hw/acpi: ACPI/AML Changes to reflect the correct _STA.{PRES,ENA} Bits
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">to Guest
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">   hw/acpi: Update GED _EVT method AML with cpu scan
   hw/arm: MADT Tbl change to size the guest with possible vCPUs
   arm/virt: Release objects for *disabled* possible vCPUs after init
   hw/acpi: Update ACPI GED framework to support vCPU Hotplug
   arm/virt: Add/update basic hot-(un)plug framework
   arm/virt: Changes to (un)wire GICC&lt;-&gt;vCPU IRQs during hot-(un)plug
   hw/arm,gicv3: Changes to update GIC with vCPU hot-plug notification
   hw/intc/arm-gicv3*: Changes required to (re)init the vCPU register
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">info
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">   arm/virt: Update the guest(via GED) about CPU hot-(un)plug events
   hw/arm: Changes required for reset and to support next boot
   physmem,gdbstub: Common helping funcs/changes to *unrealize* vCPU
   target/arm: Add support of *unrealize* ARMCPU during vCPU Hot-unplug
   hw/arm: Support hotplug capability check using _OSC method
   hw/arm/virt: Expose cold-booted CPUs as MADT GICC Enabled

  accel/kvm/kvm-all.c                    |  61 +-
  accel/tcg/tcg-accel-ops-mttcg.c        |   1 +
  cpus-common.c                          |  37 ++
  gdbstub/gdbstub.c                      |  13 +
  hw/acpi/acpi-cpu-hotplug-stub.c        |   6 +
  hw/acpi/cpu.c                          |  91 ++-
  hw/acpi/generic_event_device.c         |  33 +
  hw/arm/Kconfig                         |   1 +
  hw/arm/boot.c                          |   2 +-
  hw/arm/virt-acpi-build.c               | 110 +++-
  hw/arm/virt.c                          | 863 ++++++++++++++++++++-----
  hw/core/gpio.c                         |   2 +-
  hw/i386/acpi-build.c                   |   2 +-
  hw/intc/arm_gicv3.c                    |   1 +
  hw/intc/arm_gicv3_common.c             |  66 +-
  hw/intc/arm_gicv3_cpuif.c              | 265 ++++----
  hw/intc/arm_gicv3_cpuif_common.c       |   5 +
  hw/intc/arm_gicv3_kvm.c                |  39 +-
  hw/intc/gicv3_internal.h               |   2 +
  include/exec/cpu-common.h              |   8 +
  include/exec/gdbstub.h                 |   1 +
  include/hw/acpi/cpu.h                  |   7 +-
  include/hw/acpi/cpu_hotplug.h          |   4 +
  include/hw/acpi/generic_event_device.h |   5 +
  include/hw/arm/boot.h                  |   2 +
  include/hw/arm/virt.h                  |  10 +-
  include/hw/core/cpu.h                  |  77 +++
  include/hw/intc/arm_gicv3_common.h     |  23 +
  include/hw/qdev-core.h                 |   2 +
  include/sysemu/kvm.h                   |   2 +
  include/tcg/tcg.h                      |   1 +
  softmmu/physmem.c                      |  25 +
  target/arm/arm-powerctl.c              |  51 +-
  target/arm/cpu-qom.h                   |   3 +
  target/arm/cpu.c                       | 112 ++++
  target/arm/cpu.h                       |  17 +
  target/arm/cpu64.c                     |  15 +
  target/arm/gdbstub.c                   |   6 +
  target/arm/helper.c                    |  27 +-
  target/arm/internals.h                 |  12 +-
  target/arm/kvm.c                       |  93 ++-
  target/arm/kvm64.c                     |  59 +-
  target/arm/kvm_arm.h                   |  24 +
  target/arm/meson.build                 |   1 +
  target/arm/{tcg =&gt; }/psci.c            |   8 +
  target/arm/tcg/meson.build             |   4 -
  tcg/tcg.c                              |  23 +
  47 files changed, 1873 insertions(+), 349 deletions(-)
  rename target/arm/{tcg =&gt; }/psci.c (97%)
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">Tested on Ampere's platform for vCPU hotplug/unplug with reboot,
suspend/resume and save/restore.
Also tested for vCPU hotplug/unplug along with VM live migration.

Please feel free to add,
Tested-by: Vishnu Pajjuri <a class="moz-txt-link-rfc2396E" href="mailto:vishnu@os.amperecomputing.com">&lt;vishnu@os.amperecomputing.com&gt;</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Many thanks for this.

As you are aware, we have now split above patch-set into:

1. Architecture agnostic patch-set (being reviewed below)
   <a class="moz-txt-link-freetext" href="https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/#t">https://lore.kernel.org/qemu-devel/20231009203601.17584-1-salil.mehta@huawei.com/#t</a>
2. ARM specific patch-set (Would soon be following as RFC V3)


If possible, can I request you to sanity test the Architecture
agnostic patch-set as well for regression and provide the
Tested-by Tag for this patch-set as well?
</pre>
    </blockquote>
    <p>Sure, I'll do.<br>
    </p>
    <blockquote type="cite" cite="mid:c6eb2290323644e89c40c834bb934f62@huawei.com">
      <pre class="moz-quote-pre" wrap="">
This is to ensure these changes if accepted do not break any
existing features.


Many thanks again for your past efforts all these times!
</pre>
    </blockquote>
    <div class="elementToProof" style="border: 0px; font-style: inherit;
      font-variant: inherit; font-weight: inherit; font-stretch:
      inherit; font-size: 12pt; line-height: inherit; font-family:
      Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,
      Helvetica, sans-serif; font-optical-sizing: inherit; font-kerning:
      inherit; font-feature-settings: inherit; font-variation-settings:
      inherit; margin: 0px; padding: 0px; vertical-align: baseline;
      color: rgb(0, 0, 0);">It was great working experience with you.</div>
    <div class="elementToProof" style="border: 0px; font-style: inherit;
      font-variant: inherit; font-weight: inherit; font-stretch:
      inherit; font-size: 12pt; line-height: inherit; font-family:
      Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,
      Helvetica, sans-serif; font-optical-sizing: inherit; font-kerning:
      inherit; font-feature-settings: inherit; font-variation-settings:
      inherit; margin: 0px; padding: 0px; vertical-align: baseline;
      color: rgb(0, 0, 0);">And my pleasure to contribute to new feature
      like vCPU hotplug on ARM64 platform.<br>
    </div>
    <div class="elementToProof" style="border: 0px; font-style: inherit;
      font-variant: inherit; font-weight: inherit; font-stretch:
      inherit; font-size: 12pt; line-height: inherit; font-family:
      Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,
      Helvetica, sans-serif; font-optical-sizing: inherit; font-kerning:
      inherit; font-feature-settings: inherit; font-variation-settings:
      inherit; margin: 0px; padding: 0px; vertical-align: baseline;
      color: rgb(0, 0, 0);"><br>
    </div>
    <div class="elementToProof" style="border: 0px; font-style: inherit;
      font-variant: inherit; font-weight: inherit; font-stretch:
      inherit; font-size: 12pt; line-height: inherit; font-family:
      Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,
      Helvetica, sans-serif; font-optical-sizing: inherit; font-kerning:
      inherit; font-feature-settings: inherit; font-variation-settings:
      inherit; margin: 0px; padding: 0px; vertical-align: baseline;
      color: rgb(0, 0, 0);"><u>Regards</u>,</div>
    <div class="elementToProof" style="border: 0px; font-style: inherit;
      font-variant: inherit; font-weight: inherit; font-stretch:
      inherit; font-size: 12pt; line-height: inherit; font-family:
      Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Calibri,
      Helvetica, sans-serif; font-optical-sizing: inherit; font-kerning:
      inherit; font-feature-settings: inherit; font-variation-settings:
      inherit; margin: 0px; padding: 0px; vertical-align: baseline;
      color: rgb(0, 0, 0);">-Vishnu<br>
    </div>
    <blockquote type="cite" cite="mid:c6eb2290323644e89c40c834bb934f62@huawei.com">
      <pre class="moz-quote-pre" wrap="">

Cheers
Salil.


</pre>
    </blockquote>
  </body>
</html>

--------------Rox80qaG0QIKoVLQOf2ozQRh--

