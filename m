Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A95A79868A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZsa-0002dS-6P; Fri, 08 Sep 2023 07:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeZsR-0002bG-ND; Fri, 08 Sep 2023 07:42:19 -0400
Received: from mail-db8eur05on20708.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::708]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeZsK-0000pW-Ct; Fri, 08 Sep 2023 07:42:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYNIYB8dl7ockQsEgjt1PLHXWXF3RxgNB4Fnh/ZJYDkr45Wg2uODX9YspOGaylQlJzi9+4p2TcfZttACANX+5x0YYQJw6DbHy0dJo+179OZOQ9u+WT/zfI3DYCMuQ/DYrutVQYgi4MYiz0hpzlwqQUNnKz2LJP77eZi5aSL9WcLPWRl0X2YhxGOkcXKZpV7dBueQnj214l2VhtvthOOnCpiW942HWR3REhXaYnjLFhJ6aTXJx49M0ptdfzx3ivjNVsybja/oEg4texWR8FYxvZ4aTuJu3EJvS2Rp5t+z92KKAyAmXrCE1TCOhv2mcjBK6DoNgS9X1Lrn/Cq1AUGeLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae9+rDEgK0WvGqiFu4uWpJlpo30YxBLcqjGaaLHJpTw=;
 b=ZcWz+g8Oan6p2ZpmCd3OIswBDnA2PWsKiXrBT+Pf2S2iCFA+RzRIkLjaa+RZdSmZ6Fb9QVrMzpB6FfijKK1qkD2m2kElJVhaoczVZYpYX9d67wbDwQddlIi8MTw4PZ6HWeD5PhqVXcjOcUiIZLyXMVGI3dts3TPwLPylxEvs9N4mMsEfhyuY/a6m9gjj9dN98wzPU05a/WU9qQC5TcsWIPvLBCLCsVW/PVGeTpSbw5pz6aOv3fWQFe9bpgMwzTPQ82uhgsEWwSZodru+NtoBoLj9rdyD+Hs6VRX7LrTAetcs9c9+wl5nlyaN3sLv0XCq931cJ6bskhJnYde59P+Rbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae9+rDEgK0WvGqiFu4uWpJlpo30YxBLcqjGaaLHJpTw=;
 b=DO1t+1WYdLPIERxqSl8ByD5XwBBuA7vesgisPWMWLcNahjB3gsFYF23nrqowZusdNz6Ki7c7qu6LNkUb4LtF5XDuayavMotS1Mz4D3v+n/CEhIvW7hUQ8s86DJPMwIkfQOmZSLG/24hsHJ2i3sLCG0W+7B2TU7NOnmnHq46avoYjrDyfK1KOnjOPfaAF+zNMHMpLa5FMZEcrEH32rim5LKlGZ8x5uzxoedsZdFuNDkgK9aCnIeg7CzT9r7SzWnrFtpG0fmMQPo3oS+35s6RL3Tj2PBhOfBiDm1msRbTSdN41pLOUxTwvwdLHZhDGCqrFyl/xWUddjljyh5eu+U8Dzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB9453.eurprd08.prod.outlook.com (2603:10a6:20b:5ef::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 11:42:04 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 11:42:04 +0000
Message-ID: <d87989e9-a14f-0236-b673-f7927293546f@virtuozzo.com>
Date: Fri, 8 Sep 2023 13:42:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 12/13] qemu-nbd: Restore "qemu-nbd -v --fork" output
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
To: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230908013535.990731-15-eblake@redhat.com>
 <20230908013535.990731-27-eblake@redhat.com>
 <CAJSP0QWYDPU-26Jt7-SN4s-hyL1jg4-_eXz+9huCfzO+nL8D=w@mail.gmail.com>
 <15abbb9a-eeff-1468-c512-97497c682a67@virtuozzo.com>
In-Reply-To: <15abbb9a-eeff-1468-c512-97497c682a67@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0011.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::23) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 02107241-e25d-4a05-bcb5-08dbb0609fbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6dU7ODAZwXhe93RAQahrOS7RPYKyGkCUmBloX0cHBpCdhP5u74Wjt7HxHg/6aU3X+9Repfs3ItIjrlU667V1aHiEmUe8xfLwkZJOrMwdjm/TamO2K5fMoo5h41Ox8xYF3OvLsMnSjFV6EQUqHbaZNegxD8AyrGaAmm9k1Lm+uyEfZiVrW0LhLviAOF5BSyoPtxDfWoekY2ias1FZM2WLZiJcCMIGYzn0zeJnOhYKSolRkd5QOxTgbc7FQjQ5jnfbSGH66YV7d4ioHclQnFdMZ4RYR3OTyzTY5lsq0VVXW3YwtLS6qQh9NUnR82CGIuZuCGGcbChdmKXCemLaK8oay9VrVh4vN8+VBxboGhIhoHQgiSTFtPqdwJDsW+92A2koHq/ZSN6Gm/M400+yRVlRWRm/qli1BKGdppk/yShGssV+rLzDwKOiaTRMIDO/0IR5ZjzBPLt57APVXovEoip/PWMQeJk1rU7eBRtsGJEbJ7LOI1YBh0yinjMxvCLLxF4gAtDtc5Gw4vZUZuG1u9l3Ygy8ujttxk27exuSBluVZzMx1MtvmEm+VAa3VBYJz+c8WUQGoKBEQ0pOJ4P9U/pCeCA0CySCHC6/1B0LRYpfjUwX5NCZlfl9G9y9SHGHtL1yi3g77asIwyR3XN5unBMxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39850400004)(451199024)(186009)(1800799009)(41300700001)(4326008)(5660300002)(8676002)(8936002)(31686004)(66946007)(66476007)(66556008)(54906003)(316002)(110136005)(2906002)(2616005)(83380400001)(38100700002)(36756003)(53546011)(26005)(86362001)(31696002)(6512007)(6666004)(6486002)(478600001)(966005)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm1FTFJOa1Fza04yT2VqbG5GYllMN1ZFckR6MHBkTSs0VEthRXVidlRnYjkz?=
 =?utf-8?B?NUtXM08xR1YzSHFjQ2Fna05CcWlJcjBYbkhCdjdVdFJneURJZTJaL0hMZFBI?=
 =?utf-8?B?S2NyYnBlclIzMG94TnRDYzhYb3NyOWJ1Vm54OEZpT1M1YjJURzZjSnNxdWxj?=
 =?utf-8?B?UTN1bEVMTXNUdkZSOHpXbk5qUmczakFnaEh0dUpxMmlLYzdTZDUxRjZaaHpa?=
 =?utf-8?B?VEtYMjdhRFJsZFJYQnN6Yy9Dd3VjVkVWcFczWUVlVVB6WEFMSXNTeXVPcEk0?=
 =?utf-8?B?Z0owcTNuUG1jcnRDUlVZM3FObzZiOHQvdS8yZm8ybWQ2eDBaUlRFUFVtVHpZ?=
 =?utf-8?B?bVIvamg0UWw5ZnpUQVBVTlltT1pxZkZrQWhPQzRwYlozMXhsYWdySkxJTUdX?=
 =?utf-8?B?MWJBUW5ydVhkRHlWKzY2eXlQMDFuZzR1ZlNocUsrSUYwZDJkUGljK3Ftc1kw?=
 =?utf-8?B?UHNEaXRqMGtGdEJwRTdGaUUxVWFXK1BiRG13aVlqcEhQdkQ4cFhkTmR4VVRi?=
 =?utf-8?B?RElXNUJTQnNYZ3l0Vm1iUnRIQzVKK1VkaStNelNweVBBejBlOGJWNkhuT095?=
 =?utf-8?B?U3o3TEJjWHV0ZGkzOGxoYTdOeXdXQys4WFRFc21ZenBMMk1uL3IvYjI5VkRD?=
 =?utf-8?B?bTlXc2s0ek9JNlpTZDdVTEJKeG5LdFpTSDF3WnpiN1NHaDVGSEhSaWsrcFQ4?=
 =?utf-8?B?bmppQ05xcGJoakpiNGt1Q3NSZlJyUjIwdWZydUFaYXRkSlIwek5pRzNlU255?=
 =?utf-8?B?elVrMmpxL1cwYUVIaURiOTdRQ2NjSlIvOTU1bG9kRGRyZUROZnR1eWoxd0ox?=
 =?utf-8?B?YVEyYjNNK01kamVkalNRSlo4NFFhbTJDTHEwMHdCcG1XOEs4UklVaFF1TnpX?=
 =?utf-8?B?OElCQU5FZHlyN2R1WjI5Q0VmSG1RbDJia0JuR2l1VzhMQ1RRWGhwQlNLRXZW?=
 =?utf-8?B?QzQyRjMrNTU3TDRlby9lUWhjcnBTZk9kMnAvWjNYSUt1RXpxbFl5YkRQUWtx?=
 =?utf-8?B?ZXZ1bzNhVk96MWNrNkJ6ZFU2Z1ZPVEwvVXl2clpLWUp0MWg4SnFYZ1lEOFFh?=
 =?utf-8?B?eU5GL0VmUWo2TTU1WWUyNTZoZTBEcEZmMGMzbUR3dHB2dEgrZjJCdVZ2Y0hn?=
 =?utf-8?B?cDZhRFY0UmQycWFiWTc1NlJVbmcxZUJqb0t0aTE5SFhOM0Y3WkVKYlZTaXBZ?=
 =?utf-8?B?bnl3YVRUQWdyKzQyUXVBYzhKWkZPVHJNNzRYbnRKdFlYYzFGL1c3RlRjNHNK?=
 =?utf-8?B?N09YMHlRUFo0S1ZjYjA0TnRqZzRRcTNVcEtKSXJmQ0dQSmtnZkRoVEhKMjhs?=
 =?utf-8?B?ZmhCOXMvaWd1VEVnL1QrS1BEakx2WFQ1VWRtU2JHU3NueDdsVmRLTHhYNTlr?=
 =?utf-8?B?YVRxRXVxQ1BxTkFnYjNrdm11SlhQQ2MrMXUySFlCNmhKbElON3lCWjFDVDN3?=
 =?utf-8?B?UnlGL0xPSm5JOXY5aWdVQS9xbUdvQ24va2lsMHJYMVJ4eGNvMUFJcjVoVldH?=
 =?utf-8?B?b29CV0lWSVZtUVlPZmpSWi8yN3lSVHlWRGM1WXJyaDlPbVM2UGp4S0Zjbldy?=
 =?utf-8?B?MVh2dTZRS1M0bVFCZGZ6UDNEWlozYVl4b1NyaVhqTHFiYmc5OVFBWGJJelVm?=
 =?utf-8?B?b3VnOUVlR01oM0t3NUNEaEdVbTd6NGllL3F0RFp4QWVwNHlJd2RtY29ocU5r?=
 =?utf-8?B?WWxYZ25CZTVVRC9lWDk5R3h5T2RYVkh4ZG9XakMrb1NWNkJ0d1FPL0VYVzF5?=
 =?utf-8?B?UFdWakpPaEJ2L0s2NWJFZ3pqcVpoL3BYcnUzMlV6eEtmZHNrTzhPWFBwSTYr?=
 =?utf-8?B?ampUemcyQldwcm1mejlLbFRCWDVkTlFNUW0waW1yQzJMVDlGM0VReW43bExt?=
 =?utf-8?B?YllOSE4yOUQwTWd3ZmNxWjIzVXg3TEwxNkJhZkhFeEN2bXhnOTgwTW41RXpW?=
 =?utf-8?B?cFdkSCs1VzZydDR4Zjdmekt5dTRZOEw0VjV3bnUrVmRCQnBpeVJpVHZkVTdu?=
 =?utf-8?B?K2pGKzR5VWIvSG8rZUlyVmYvcjRnVGxabFVicmJKbVdnRUhpRUd1ckt6dGd5?=
 =?utf-8?B?aVZnT1BxSW85VFR5c3pVQVJtSnVLenNTSTdZR3Q1aDd6cVVmUmZ6cWNxSU9k?=
 =?utf-8?Q?qc9UVzuzLt/1+l0fkTlyjhhYO?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02107241-e25d-4a05-bcb5-08dbb0609fbd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 11:42:04.7710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iGMPG8wG6iY+RJOz0YLoS41mJglVKzxxdnab27Ki8Rj/gV08UfIJ8pn49/Kd7F1xSYQKU9Keq0HYhV7WLaj2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9453
Received-SPF: pass client-ip=2a01:111:f400:7e1a::708;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/8/23 13:24, Denis V. Lunev wrote:
> On 9/8/23 13:03, Stefan Hajnoczi wrote:
>> Please resolve the following CI failure:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/5045998355
>>
>> ninja: job failed: cc -m64 -mcx16 -Iqemu-nbd.p -I. -I.. -Iqapi -Itrace
>> -Iui -Iui/shader -I/usr/include/p11-kit-1 -I/usr/include/glib-2.0
>> -I/usr/lib/glib-2.0/include -fdiagnostics-color=auto -Wall
>> -Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong
>> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wundef -Wwrite-strings
>> -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
>> -Wold-style-declaration -Wold-style-definition -Wtype-limits
>> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
>> -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
>> -Wimplicit-fallthrough=2 -Wmissing-format-attribute
>> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
>> -isystem /builds/qemu-project/qemu/linux-headers -isystem
>> linux-headers -iquote . -iquote /builds/qemu-project/qemu -iquote
>> /builds/qemu-project/qemu/include -iquote
>> /builds/qemu-project/qemu/host/include/x86_64 -iquote
>> /builds/qemu-project/qemu/host/include/generic -iquote
>> /builds/qemu-project/qemu/tcg/i386 -pthread -D_GNU_SOURCE
>> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
>> -fno-common -fwrapv -fPIE -MD -MQ qemu-nbd.p/qemu-nbd.c.o -MF
>> qemu-nbd.p/qemu-nbd.c.o.d -o qemu-nbd.p/qemu-nbd.c.o -c ../qemu-nbd.c
>> In file included from /usr/include/fortify/stdio.h:23,
>> from ../include/qemu/osdep.h:110,
>> from ../qemu-nbd.c:19:
>> ../qemu-nbd.c: In function 'nbd_client_thread':
>> ../qemu-nbd.c:340:39: error: expected identifier before '(' token
>> 340 | nbd_client_release_pipe(opts->stderr);
>> | ^~~~~~
>> ../qemu-nbd.c: In function 'main':
>> ../qemu-nbd.c:605:10: error: expected identifier before '(' token
>> 605 | .stderr = STDOUT_FILENO,
>> | ^~~~~~
>> ../qemu-nbd.c:962:22: error: expected identifier before '(' token
>> 962 | opts.stderr = dup(STDERR_FILENO);
>> | ^~~~~~
>> ../qemu-nbd.c:963:26: error: expected identifier before '(' token
>> 963 | if (opts.stderr < 0) {
>> | ^~~~~~
>> ../qemu-nbd.c:1200:38: error: expected identifier before '(' token
>> 1200 | nbd_client_release_pipe(opts.stderr);
>> | ^~~~~~
>
> quite interesting and surprising. Tried to reproduce with
>
> ./configure 
> --target-list=avr-softmmu,loongarch64-softmmu,mips64-softmmu,mipsel-softmmu 
> --enable-werror --disable-docs --enable-fdt=system
>
> locally but without success - the code is compiled fine.
>
> Is there any way to get into the Jenkins environment?
>
> Den
The only possible reason I could imagine is that 'stderr'
word is defined under by pre-processor.

Den

