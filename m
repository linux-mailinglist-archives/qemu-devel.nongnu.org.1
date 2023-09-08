Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B444F79866F
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:25:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZbZ-0005ay-GY; Fri, 08 Sep 2023 07:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeZb0-00051v-9v; Fri, 08 Sep 2023 07:24:20 -0400
Received: from mail-am0eur02on20716.outbound.protection.outlook.com
 ([2a01:111:f400:fe13::716]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qeZar-00043w-S8; Fri, 08 Sep 2023 07:24:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJzC35Pc4exRMa972Py7n2W3LZIYewVlbXQA1jw8TtrCp2vSVFdPNZw5CUAsxvRkn5D6Tqz+XWnB1dAEqQshYwHTaFs0JSesN7bxEeY5jD7cGqekbVuVbQnhcsfalV3MselewZ8eDx8+NBwFLpK5ZyiIBsQLt5d/4WBcYbaRgN1Aym8bylnVvIKb7XDmOdWtGct7mB2LSFioxtb1UjkrY+gS5jNH3pB+jpyL5poUFLj3D0Hta/CY2sUbV8BaeU4ayuG2tcHY7EDfigeX9PvW7lHSBeWmIIAv/8JjA2odHvkUCc2mCqd58nBupbUD4Flf01gBxmrRy9pxYAEzdjSlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YFdk4PnVCC2ywfWu1CQdS8D8Eynt8tkmPtgpet/fyT8=;
 b=fUJnB5P0evSZOZM0Vxi4oLGcIXjsr/Nodr82NiLG50pQQthj4JEePRsELWfy0rNOCYegLzcrlLdHpN5ERcTEZlnhkKSC+qn1grfbWE9nvF3ZMdvNR/KfNIanecjATtCp2re/V0N3yd/rX0qvQ3vF2bqbPb/tnA52EtHLhppqRztHteMx3r3kH8gaUAcxyIHqaDapmfVB9OeliYRLZ7UsjBZCVDza1xgDp4kPLUvLwmrAwG6S156rz1kvIVeZKDQMRfvXLAlLgepuTEH35mpaT+qVYDY7VomeoU4N4a6G9nYtbbR/WfgyoEFT4VMmsvrEbF6kEUaPfhijNSYuUJtsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFdk4PnVCC2ywfWu1CQdS8D8Eynt8tkmPtgpet/fyT8=;
 b=VwqBhgKvs92xHsZ+t5bn7Cz0MbgWuySJGdHIFpoxtI6Ei29HSdb8p42nwhI+8YKjkwo2JSuV3YAPGBq3RBaNsnYQ0oIZKUq3ZtDNwJkAEi+TeJNk9wtQfJuse2/XacMkySjZf9tujLGWrWRf26NCPiVadsVK6whuNksARmhKftrkCaR+qZEs/oQXhBpyfBpCviB3jVxdiCTimwDVLmV6VhGAu23Dn3zkRmOEee44pOdMt9j+qdSUzhc6bAYgrMGS/jbutcJBkMHW9SOHzJTev3ThdZ0+8qbwpqwrwqijO76VTQWPNqAb11l2G3xOdeO8qZn+h7Z8HXkB7Dx0375Law==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DU2PR08MB10278.eurprd08.prod.outlook.com (2603:10a6:10:498::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 11:24:04 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 11:24:04 +0000
Message-ID: <15abbb9a-eeff-1468-c512-97497c682a67@virtuozzo.com>
Date: Fri, 8 Sep 2023 13:24:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PULL 12/13] qemu-nbd: Restore "qemu-nbd -v --fork" output
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
References: <20230908013535.990731-15-eblake@redhat.com>
 <20230908013535.990731-27-eblake@redhat.com>
 <CAJSP0QWYDPU-26Jt7-SN4s-hyL1jg4-_eXz+9huCfzO+nL8D=w@mail.gmail.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <CAJSP0QWYDPU-26Jt7-SN4s-hyL1jg4-_eXz+9huCfzO+nL8D=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::28) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DU2PR08MB10278:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1da0b6-6f39-418f-3870-08dbb05e1bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mB3J2hbwwCEjngYe87Nlvl2sVUO3rm0mh5Btk9A8K4JGnOc1ipHeYAzExWhwjqwEDs0xICH3sElvDJEla7h7lRmwTKJQmZJPuGV7PEJp86rZxl2y8elMZnNOy4Zwn4OBJ3jW+mbLwi33y3RIcibPH92XaTMVGqAmNsF68HXcScXFrzB9x1FdFPLaoCbm+mWM+zdmuO6KaLviScO7+qTIhiYzrbPJwhfU2n0y3VCdBXnmxpVHI7I5GuabZ+ezaAbIXbhPjQofDGmwjYB1c8dFtG3j/f67vntb8nEm2IiNn5d63COW5UGxalGaVwN9fa19VDOdAUF2rsh/lBau0zKL7FJjfvHanIDh0XJtiy+BsPF2nSvrGqN/LFHRTl7Gx0dLHjELSjjo9nHFyD2qAlnHeAqFM34JLoRlO6duk35cROL/FBsQTDQ4+4d6Ff9aOzw/qZLUZA1fqZ7c7PgyGR6/sBWZhnLYUW8yKSLqyrR5Pv/MJeJ1kqiNw6p5JCfqslTonHGAATgLls0r/CnEjRTiSNNAH3yqSqdUvzMqy+QbG4wZstllBzGidOPRi8x0mtRuyvzwWvqwMwZypYD/iffn7VR0MlpSvSzSoKeT+uGaQNvePqqVSvNlxGo/WEGu1cnsgr/8oLUCFbhIGXpmH2+Btg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(39850400004)(376002)(1800799009)(451199024)(186009)(83380400001)(2906002)(6486002)(66476007)(6506007)(316002)(66556008)(66946007)(5660300002)(966005)(110136005)(478600001)(41300700001)(8676002)(4326008)(6512007)(2616005)(26005)(54906003)(8936002)(53546011)(36756003)(86362001)(38100700002)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWpKcjAwcjQ5ZCtEeStqNzNYb1daVjhyUGp3R0NtNWx2YU1DZ05kek1TSEVC?=
 =?utf-8?B?blNGV3l0THFrRklkbDdrMXMvNDZoUjRrenlLNUtFMWZUQ0NiQTFkN1B1Y2sw?=
 =?utf-8?B?aFBiako4c0ZSdVJOVmhQVThsVklsWWZXTkRRUVJ2TkdrWVdtWEJMMmlPRW1K?=
 =?utf-8?B?MzZlUWU1QkRWRytEaUtuWStyQktJcFlUYnQvMW95UzhiZjZqTnVibzg2eE5P?=
 =?utf-8?B?Zk05OEZzSlVsNzgxcFd1aGpheWJrbk0rQW1kd3RKWGFxbnNIRVFyZ2R1anFy?=
 =?utf-8?B?M001bnJ0SXExTG1EMDdXVVg3Mk56OEZuQ1ZIZExaOEJ1NExvOWNpNGJLWHJp?=
 =?utf-8?B?SndsWEh6QlZEM0F4QjZPMHZPYU54NHFsNEk0UUQwUHdtNDJodHhzS0t5T0hU?=
 =?utf-8?B?cHUxMXlmRXQwdDlpNWt4Q1A3aGV5ZzkxNE5YY0xPSkxLUnBjQWE3WGpsMW1M?=
 =?utf-8?B?QUt1SnoxWWVrWU53Mkx4b1NUMzBUTGNENXpGN1FhdXd0eStmb1NaZDczV1F6?=
 =?utf-8?B?QmJ6SzZKcHVOUWh3K2hqVlRJdGNKNGdwTGsxeUFxaFhrdENwV0JLUXlRcGxJ?=
 =?utf-8?B?Wkx4cmVzMUJ6NndpOHpsYjlDbm5tcmF3V2pvNVViRStJZXFRVmhmSmtWVFNi?=
 =?utf-8?B?UUVBWXdIREJHNjkxeWJYYXhFWFhIS1JaMWxTL1dTeDBYTkYwQlN0b2xwcytP?=
 =?utf-8?B?WDE5bjhEM2xsK0M2OHhOZmRZTk1jM3I5ekZHYW5sKy9iYjZ4R3lkMzRDWTFD?=
 =?utf-8?B?Q2lEWlFTdkJlVHJIemdPb2tWOHBaSk9wbG9OZkVXdXJSblJXaU5zWGlLWGxz?=
 =?utf-8?B?d2lyMU8zQmFFL2hVckZDTkhQUFNnSU9lc0pNRFVqbXNPSFp3OTN2NjliZExz?=
 =?utf-8?B?aVFyUFV3UFBtRk9FdDBjUFA5UmUwem5rZWhmM3pieTJvdGMweGZzYW11Zm9D?=
 =?utf-8?B?NjVXdmhRN292SUxpVXJQNDFic1NIR0w0aCtNU09Hbk5nSlk2VTg4LzlFTnBF?=
 =?utf-8?B?L1hRZTAzZkZuMEVkbDg1QVg1RU9CMXI0cjlabStORnFINCtXaU5iU21JeWcy?=
 =?utf-8?B?OVV5STd6bWRTSnRlSThSaTE5SUxXQy9aTFBaQlJROWRXWGkzdXZvZm0xaUNM?=
 =?utf-8?B?YWlIckNac1pFdkhjSklaVTRwK0puR2tadzBwOVdlWE5TL3ZocFNHcUpWbWtH?=
 =?utf-8?B?VHcvVHJMMjduU1MxYm5wV1ZLTktnUkZWbUZ1QjZzY2JnQi9EY3FvV1dSNyt0?=
 =?utf-8?B?alF1RE8xaDNnNERHeFN3SFB6UTBuUkdNTi9lb1JxNGtnUE1VM1JVK0NUek4r?=
 =?utf-8?B?KytFbSt3aDdhMTNLRmNJV0tRdmc1MGFYbmV0OFZwYnBnR25xdUZsU2NLZUJ2?=
 =?utf-8?B?Y1F5UWttVVkvdmNQY3M5MEU3R1puL1Bzbkk1TXlLemZQdDFVZXUvTFpZYWJY?=
 =?utf-8?B?cmZleTBScDZjbHZlenJTSy9XcGZtSUgrRFFYaXAvSUtSL0IxWUVERFFQMFBO?=
 =?utf-8?B?QVgvdm1LYVZEZG1ESXIvZXVva0xkbVBiNWZkYkZMYkFidHNjTjAweFhQY2Vq?=
 =?utf-8?B?RmY3ajJxeFJpS0JWOTlDSCtjcktIWUJKQmVIakFUSjdNd2JxYWo2TmlyNEhH?=
 =?utf-8?B?TGlOYjNVUW5KYS9vZzVDSWNDMHZIdkYweXpmalI4bUNjNER6cEE5aVg3WWVO?=
 =?utf-8?B?azNYMFEyYnFqMWNKMkRqNWJSVnMvWUh2M1hZQUtqZmtCZ3VnQlFHTEVQODJ1?=
 =?utf-8?B?ejllbjJTNUh0a3JsT2hxNlJoVkdTSUowTEV6Q2RZN0ozUlBaSDJMbVo4YUMy?=
 =?utf-8?B?cEhNaElnSzQ0M0NqS1pBOThXTDI3a2ZraU45eUpuWkRZc0xRWlZSTTNiMEN2?=
 =?utf-8?B?anpub3hlZG9QZHF0SGtkc0Y5WkVGVkozQ09qREU0UktXZ2UzOXFFaUpiM2Jr?=
 =?utf-8?B?S2JGL1oxcEEzS3ZhOExJM1dON0l3RzB5Vm1sYjYyVlFITytiVWJoY2tVdllT?=
 =?utf-8?B?VnNxdFk3REt6MStHOGlPblpqaFg4NG1KdlBSU1FYelc0VjJLbjRzMncwdC9w?=
 =?utf-8?B?N0h6aVhWbFZqb2l6Y0dyR283RnRqb3EraEVONE5Qd3BRRnNSY3h5TGpvQm1H?=
 =?utf-8?Q?x9UYaYIDp2hhxTz+VvPDx1Vgm?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1da0b6-6f39-418f-3870-08dbb05e1bb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 11:24:04.2787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTzj64fu/is0HUH5K7M+KQDzShOKq9v5htF5bUtiw2lEMWfAWMZiKaSJDt9CtbLPRUFc/JPy58ThqQsGyZbNFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10278
Received-SPF: pass client-ip=2a01:111:f400:fe13::716;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

On 9/8/23 13:03, Stefan Hajnoczi wrote:
> Please resolve the following CI failure:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/5045998355
>
> ninja: job failed: cc -m64 -mcx16 -Iqemu-nbd.p -I. -I.. -Iqapi -Itrace
> -Iui -Iui/shader -I/usr/include/p11-kit-1 -I/usr/include/glib-2.0
> -I/usr/lib/glib-2.0/include -fdiagnostics-color=auto -Wall
> -Winvalid-pch -Werror -std=gnu11 -O2 -g -fstack-protector-strong
> -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -Wundef -Wwrite-strings
> -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls
> -Wold-style-declaration -Wold-style-definition -Wtype-limits
> -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
> -Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined
> -Wimplicit-fallthrough=2 -Wmissing-format-attribute
> -Wno-missing-include-dirs -Wno-shift-negative-value -Wno-psabi
> -isystem /builds/qemu-project/qemu/linux-headers -isystem
> linux-headers -iquote . -iquote /builds/qemu-project/qemu -iquote
> /builds/qemu-project/qemu/include -iquote
> /builds/qemu-project/qemu/host/include/x86_64 -iquote
> /builds/qemu-project/qemu/host/include/generic -iquote
> /builds/qemu-project/qemu/tcg/i386 -pthread -D_GNU_SOURCE
> -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
> -fno-common -fwrapv -fPIE -MD -MQ qemu-nbd.p/qemu-nbd.c.o -MF
> qemu-nbd.p/qemu-nbd.c.o.d -o qemu-nbd.p/qemu-nbd.c.o -c ../qemu-nbd.c
> In file included from /usr/include/fortify/stdio.h:23,
> from ../include/qemu/osdep.h:110,
> from ../qemu-nbd.c:19:
> ../qemu-nbd.c: In function 'nbd_client_thread':
> ../qemu-nbd.c:340:39: error: expected identifier before '(' token
> 340 | nbd_client_release_pipe(opts->stderr);
> | ^~~~~~
> ../qemu-nbd.c: In function 'main':
> ../qemu-nbd.c:605:10: error: expected identifier before '(' token
> 605 | .stderr = STDOUT_FILENO,
> | ^~~~~~
> ../qemu-nbd.c:962:22: error: expected identifier before '(' token
> 962 | opts.stderr = dup(STDERR_FILENO);
> | ^~~~~~
> ../qemu-nbd.c:963:26: error: expected identifier before '(' token
> 963 | if (opts.stderr < 0) {
> | ^~~~~~
> ../qemu-nbd.c:1200:38: error: expected identifier before '(' token
> 1200 | nbd_client_release_pipe(opts.stderr);
> | ^~~~~~

quite interesting and surprising. Tried to reproduce with

./configure 
--target-list=avr-softmmu,loongarch64-softmmu,mips64-softmmu,mipsel-softmmu 
--enable-werror --disable-docs --enable-fdt=system

locally but without success - the code is compiled fine.

Is there any way to get into the Jenkins environment?

Den

