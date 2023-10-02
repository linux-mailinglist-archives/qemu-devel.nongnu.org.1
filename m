Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869147B4B87
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 08:35:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnCVo-0006TQ-Cl; Mon, 02 Oct 2023 02:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qnCVm-0006Sv-E7; Mon, 02 Oct 2023 02:34:34 -0400
Received: from mail-ve1eur01on0730.outbound.protection.outlook.com
 ([2a01:111:f400:fe1f::730]
 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qnCVj-0000JL-3T; Mon, 02 Oct 2023 02:34:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxjzHz2iS6Vk3tTXpnLg2A3pl/h17bN+KJppiITTCAOLO+G2vXbfsUo7dVXS231MvMMxt8vkKtF4AfyX73pnaKffyUSJZ0bQqEJZF70bg/Cxf1gSHjm/bhdGdLE5Yy4yKaJyg5TSGVWjVUy9x7u42wcOIyb8JiWC3dkdg3J0qUKi/shpJt2f1yQqwIgKUZF7Ugi1NDrMQKEmaVOyDxtToFiVs+emteyRHmt/hifPSSSEHUTppgW1LFHYJwvpndhLnsqhNg6hqIw1wUyiMRJAAEBgel57s37yyVi2DCq/6RVf9wsbbGFLT7uVZbiDkm0RAkVVOuP1a+PjiF3d4u6kKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSAQHkC0Gopf7Glq/YKGEPx9SF9U1SO2jhr3g4TWEkA=;
 b=DOQmEP8UY5xQAcmM9w30i1dX6XrJLEpHkU144klm+l73Hlokj6gDLWflxX6nIQ5ANhF9k5zSim24X0AXHmNWNMJqsMRG3cyvhqg4sYGgmzf/oQ0MmXh2RlT//lba6+RFwzVzikh+dUbX1wWWCapzVowvpY/WuZgXFxRDWhYmuVwmX0XWeaanQB/Nk2SqzcA/O4itBs5m5Xl5bbktw67qTLgR0RujCsJfaazLFUPWq9P5qfrePaN+qDOfPyiFiDpOyFO7VB1l6rEVEIcQQ0pUSB3SAyfIaR6IxPPV5Hukb1pJaF9jl3rHx97xPh9IISeUxMAL/mg9ZMoywsAb+Wa6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSAQHkC0Gopf7Glq/YKGEPx9SF9U1SO2jhr3g4TWEkA=;
 b=OvV0OlIFEHY9/SK8r3JuhH2/QRKjQMkiXi7yGP1DNFrLLCwYYZgMKZUW1JemF+Z3eCLsUdi8CbZvuovTFQKCkzVTYUtC4f/iBRJnFgTviYdXnzdkjlycOkQRLhrSkxjSaoL9pSQGDtMWMlrp1smdGshrmmFBITYYbSLccick45BEQcwUo7fzCjX0BBQoC9C26+XOtualKZebTFfOVJBOpX+Zr5RFqQvJqH9Y5MKtmbBw73xzbeHwvvzNOSFAQBuQI+qVQaIk7DYaZNr6J8MGvb6vjekoK85O7camEKSoF40u+CS/FXALC/GsUDEI8lBNUo2jKSumBCFsERynifcC7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com (2603:10a6:3:c1::13)
 by AS8PR08MB7992.eurprd08.prod.outlook.com (2603:10a6:20b:571::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Mon, 2 Oct
 2023 06:34:25 +0000
Received: from HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8]) by HE1PR0802MB2331.eurprd08.prod.outlook.com
 ([fe80::4190:cf8e:abd7:68c8%11]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 06:34:25 +0000
Message-ID: <fd716469-6aed-49de-a736-452e713eb1cd@virtuozzo.com>
Date: Mon, 2 Oct 2023 10:35:31 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] qemu-img: rebase: add compression support
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, den@virtuozzo.com
References: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230919165804.439110-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::14) To HE1PR0802MB2331.eurprd08.prod.outlook.com
 (2603:10a6:3:c1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2331:EE_|AS8PR08MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: eb94e28e-03d3-45a0-37e3-08dbc3119eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QA3Cw1GSXx7GlfIcG2mwuT2y95i6nzvKlHMBezFUqfaSFYEZ8mXXTvsaTRYZxuQ2fudG3PO7llRWiNTd9KauTQhvVqkyCdkkErgmkH+qsv5CsHS26kYF634ldpwjhfYQdPwmXC+njFz2vuBudUb6ejtt9DMZIRpP8w+vwxElvWIUkjh36WfEPW/M7522Iq9W5QAWPTrRhC7yOdO0MC+MX1XYvzO1cy2DMUtjwD6plJ7RyY09+MV7WzblWPNh65jLb504PFIYceMTdoJsyLNFlpsFvzM/jxvpuJoHhTnpUPoIZcLShf0lY0GJmZxkvj4zAB+kGkHamutk1gXbZ7whHZUi11QOyH/WK+wqjUFBK5+mO4AcRdK871QGhf4MFQq6BD4q0uyLrJBT+PHr9Bylo690gur+55OTFSyX8K3WCHUC7PiAFzfKfssxpfnmb7vheAN727MoylsK2FnBBZ2IV0FeVyCouSwh2uD2FJHcWDjCEBNo1pbO0un4ndBHt4+N7DQjpowQGj4GCWGl0D3bqXKA9P4m9prxLPUZi5ZeHwierQEVuGkIwoWVOxxVnFdWTKJc9FruE9SYXUR/+XrRzsjZmDn02K94/iDjqkIuaP4FMQV3InhQQpe0wWLfwf8aOISwODR9VHhrLUhdPFx5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0802MB2331.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39840400004)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(26005)(38100700002)(4326008)(8676002)(8936002)(31696002)(53546011)(2906002)(6506007)(6666004)(6512007)(36756003)(44832011)(86362001)(107886003)(2616005)(6486002)(966005)(5660300002)(478600001)(66476007)(66946007)(66556008)(316002)(6916009)(31686004)(41300700001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGcwM2xGaVZWeHhCOExFVmdSYnFQWXdIeVdqOFhXeDNqZWdmS3NuVHByU3JX?=
 =?utf-8?B?bmRiL29Sek5PeExlektCMHFRYWl3RTB0UXVNcTNZSmVOdnZkVlhiUHNVU3kw?=
 =?utf-8?B?MU8xcFZVLzBKNGZEaXRmL1RERnFBRXdLelpVVWRZRnVSTVYwT1NVaHZ2OTFJ?=
 =?utf-8?B?Q0wrMCtJN3F0VERyYUltSGNMYXhGU2ZkSzJxYzYydmdoejQ1Y0g2WklnbW9B?=
 =?utf-8?B?ZDFFQTZDTVRlVmZpcEUvUHZxVXRTR0tuV2NOK3U2YUEyb0ttL1hwcTBZSndK?=
 =?utf-8?B?bEYvUGFsZS9NWTArdU5mMUdQZEkwYjIwOXVtaWpjditobnozV3RTbFNoaUdU?=
 =?utf-8?B?czRLbE9FemNidTZSZWFta3ZKRWdpb1hOY1hyc3pxK0NjZGh2eGo4NmdBL2Za?=
 =?utf-8?B?YlZyYm0zQkpjNEtnSTRaTXRJRytHTG5MTmtvbmRIbS9UZjM0enpuYldFeE1s?=
 =?utf-8?B?T1o4TUJNUFo0SC8vQXhMUEZLcHlqWEZadkJEVDBCVGRLcWhaVk9mNG4ycFRW?=
 =?utf-8?B?dUpUUExjYlREMEI4bVR0REd6ekFldVl5MWdCZE9aYkUrOGRVOVpId3lYemdU?=
 =?utf-8?B?cHhsNlplMmI4azV2ek5naWRORWFDUUI4cW1QbmQyK1d0eVpnWDZRUFhaREY1?=
 =?utf-8?B?aXdiMzZZVS9JUDA1bktZRVdlcjJ6TjdtZkE4bURya3NRQTZla1REbHVPT1Ur?=
 =?utf-8?B?V3c0MStUNk9ZN1Q4WUdhdmczbThnczZnVUYrQU5iSmd0elNTQnRoNFVVODdQ?=
 =?utf-8?B?bko2ejVRYWc0QXpxYnFmZFpoQmNYN0djYngvYUFHYU1IajNyVXcvSGNrVFR3?=
 =?utf-8?B?M0pkR0dNQ2Q0ZXVjZjBWMThTR3htV1pwNU91dmYrWnk1ZFc2TDNlOXdld2lm?=
 =?utf-8?B?TlFNUENBT2hyNzZxTFZZdVgzRzJNMnF4aTFGWG56bU9xeFlVQVg1QU9jZHh0?=
 =?utf-8?B?YkRDMWNtUThnTzRqcnc5MHM0RjFLaHZUbFNiTEtTK3FGZjkxZVFRMk5BUitw?=
 =?utf-8?B?K2VuZ3JQcFZMb2NqSTVkZWdsSFN5WXZNa1MrekV0aWhZVWxBMTlvamhZaWd1?=
 =?utf-8?B?NWpMSXJXUjZuTU91cGM3ekI3cVJHMGVOUWltUlBqSm02U2ZDOGxDYmdmelJ1?=
 =?utf-8?B?TUpRMVdaOHNvS3dTVXlmemNoZzNQcVRaS0VneVJCMTR6ZkRJSVhzNUVlY09i?=
 =?utf-8?B?ZGk2bThDMHFya3RJUGhQVlhlUXhXc0ErciszaVpDZE9Wb3luSkJsMms2ODRJ?=
 =?utf-8?B?Y3VCMExDeERWQXMyM3gvRWlVUy9Za0phN2VjYVgrWW9yRjRWYW4rQ0pWamJn?=
 =?utf-8?B?VGVIclNqSGhVWno5b3NVOVVuS1pVbkIwTWtsejZqT0t4TW5tWEY1YmFLRTBv?=
 =?utf-8?B?Ukt4SWVReFpiOFhPT09ZalZJeHJ2SGMwa1h3cXkvNlFFQ21HZTI3UnRXeCtw?=
 =?utf-8?B?cHBIS3FXZDd2VGM0ZnZNK1NXZlM3MG5lZlZGd0RwQlJnbXZOdGtuaE9rUCs3?=
 =?utf-8?B?Q3hnUWRpN2tkcTRmTkc4NWxrTEFSbWtxTnUwSjRtWm5mUSs4Y09QY0t3aTB3?=
 =?utf-8?B?elAzd0x2STc1YUg5dzNMR2g5ZWN0Q1FGU1IzV0R3cGJha2RaWXA1R1FmSlVY?=
 =?utf-8?B?M2VTMTZoQ3EvQ0dINzhyZzJKTkhVODlVMUtuSU9GVk5MbnRTTkJobnRCVjE1?=
 =?utf-8?B?NE1TTWhCOVNRRG9uanBJM3BackpFdnlUQlVRcWZLZXlscGhlV013VTdzMEE0?=
 =?utf-8?B?dzZYZ3poNWlYdTQrblR2U1hHQWR4bzZ0dE1QSytpNUJwcTdSNndYLzJnRGpQ?=
 =?utf-8?B?andoWGpGb0liNlVOeStCQ1hsTTJTRU5obHhPQVFwOHVwZjhBL3dpUUptZHNu?=
 =?utf-8?B?Y3dhdlB1UDVpRjErSnU4SHRVbXc0TCtpUGdFWWtKbngzdjM3WURGTWp0R2NR?=
 =?utf-8?B?dnR0Rm43QlVpdGk3Wlc4SU1HTEozTDNHMjZCb1ZvUldQUkM4S0JCV3h3SERR?=
 =?utf-8?B?aEdrQnpnSFh3MFVXeXlmZGZ6MjhaMEdzcVk3V2VYc2lXbXZPbzh5SzZLb1B6?=
 =?utf-8?B?ZURUOE54cFdsRDZWbmViMzI3by83R3V6TFcyeHI1clhpeUVNekFuRGo2djlw?=
 =?utf-8?B?S3hOU3lFeVYxRm1meC9jUWwvRXFZbGJjMEd1ZTg3YkV6eHhZamU5NlhVME8z?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb94e28e-03d3-45a0-37e3-08dbc3119eb8
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2331.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2023 06:34:25.1645 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqLk2VDFUD4jUQY7cmkXRKHuBs5qgekNeRti6XMoJ+r12xZ9E79F3NHVv64hmRoNGY7zpPjlRy9POBq58tFFkuzNk+9mf39dYyv9qj+i3sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7992
Received-SPF: pass client-ip=2a01:111:f400:fe1f::730;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/19/23 20:57, Andrey Drobyshev wrote:
> v2 --> v3:
>  * Patch 3/8: fixed logic in the if statement, so that we align on blk
>    when blk_old_backing == NULL;
>  * Patch 4/8: comment fix;
>  * Patch 5/8: comment fix; dropped redundant "if (blk_new_backing)"
>    statements.
> 
> v2: https://lists.nongnu.org/archive/html/qemu-block/2023-09/msg00448.html
> 
> Andrey Drobyshev (8):
>   qemu-img: rebase: stop when reaching EOF of old backing file
>   qemu-iotests: 024: add rebasing test case for overlay_size >
>     backing_size
>   qemu-img: rebase: use backing files' BlockBackend for buffer alignment
>   qemu-img: add chunk size parameter to compare_buffers()
>   qemu-img: rebase: avoid unnecessary COW operations
>   iotests/{024, 271}: add testcases for qemu-img rebase
>   qemu-img: add compression option to rebase subcommand
>   iotests: add tests for "qemu-img rebase" with compression
> 
>  docs/tools/qemu-img.rst    |   6 +-
>  qemu-img-cmds.hx           |   4 +-
>  qemu-img.c                 | 136 ++++++++++++++++++++++--------
>  tests/qemu-iotests/024     | 117 ++++++++++++++++++++++++++
>  tests/qemu-iotests/024.out |  73 ++++++++++++++++
>  tests/qemu-iotests/271     | 131 +++++++++++++++++++++++++++++
>  tests/qemu-iotests/271.out |  82 ++++++++++++++++++
>  tests/qemu-iotests/314     | 165 +++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/314.out |  75 +++++++++++++++++
>  9 files changed, 752 insertions(+), 37 deletions(-)
>  create mode 100755 tests/qemu-iotests/314
>  create mode 100644 tests/qemu-iotests/314.out
> 

Ping

