Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89463803BE3
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 18:43:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACy5-0004xF-Sz; Mon, 04 Dec 2023 12:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rACy3-0004sR-Le
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:42:51 -0500
Received: from mail-he1eur04on0729.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::729]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rACy1-0003PQ-84
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:42:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPOPqGDgxpzhyFtT/1CIvotf8xgSAmpGlltEofnHZ0KKeOpvYC66udHhYmn1h4zcuhJNs6b7FAMHThs+AozWuFa7Dppgigk5iFLH6uxvXEA1Qz39s62N46x5HMbeKeXyHgnlyNrmasOzMhJUPxbysNHYPkQSKRoCqHWkLVLQWLy4C+xm6bgX5SH2csBpFE4RbwJZLSGHyIYsH4CLfZjABUpqoFA5H2CiNA3TlYzMzbczumd6q4j24NjWQDo1FkM9fwmLTDmLOascGKYIE4CZhP510lfd9ae6GwaodiSK278uZditk5EZBeFg+gt7hhqsU52hd1cnLSsrHlN4oG0TFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3R9A1GMlL7KwBj+x/TaiT0hhMaEG1MKnPu/mbp7HXM=;
 b=OkZwtCQbhzrzDVEhXQ5RY2/HsYKcNW49sA+Ufvi3ydN0dDYXA4okRyZLBwy4QbxPMLuzVIZ6ofGEim4igBRaRQaH/bfeUwzczeNwKP9EzcfI7uP8ouTPNYjSyl2l/5kpeGtyajqCcIrHSmbiYqxzlA5iI3Fh+xp+s2IviOtv4+BnrL2inJm3K4CriMqH/A2lbOQFZwM0RiGsTRVTyC36VAn353BYtiqY9mgNSLkS73vk5syxROKGpgVp2lH/EEu7bWJ+7h8o3Jd0vpPMVkUyBWOAdEfE2BgchvYiNRsCto1TwpOWvwNZxrPPhrKjRgetQZqs8fsXycFvi1sap/b5LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3R9A1GMlL7KwBj+x/TaiT0hhMaEG1MKnPu/mbp7HXM=;
 b=xR/7M++9tNMvlkCCOG/Hpc5qzX3/xpfDhhWwKjpF5PCrcChdHO9EE7j6AscMhBZk86CUc4gREv2mER44NrzF0euaYmysk2J/xCYxBfS9TKGkgvGOquL+em7LrhxrevDWnvngN//Ol+As1btKGZb3eKXzWlRkhfTc+1ybfzlv0Gm+F1e8B+K3SLTxcR34LQG/zM/odVnQkeuMMoRDgF1TPIJBiC2BGRTUTQzA3JN1Gx1RPDCF2/pbAOEBpEodFDgPMrZ1fyRBstqtXca6G3WIgCNlEb4b85pNXrbTXwDs42CMeN92JUUxGFaSzi5BVAfnlW7oG+LpgfyCf1SiKDZZxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB3PR08MB8794.eurprd08.prod.outlook.com
 (2603:10a6:10:435::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 17:42:45 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 17:42:45 +0000
Message-ID: <5a02261b-aee1-4c2e-bfc1-33f5d3d24788@virtuozzo.com>
Date: Mon, 4 Dec 2023 19:45:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "test/qga: use G_TEST_DIR to locate os-release
 test file"
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 den@virtuozzo.com
References: <20231204163257.1011556-1-andrey.drobyshev@virtuozzo.com>
 <CAJ+F1CKni6vzAfPDefU8c-kRuhPDbzOohpC0bZ40WGOxLGGtmQ@mail.gmail.com>
 <d91b89b9-41bb-4968-ae46-438bae0b3952@virtuozzo.com>
 <CAJ+F1CLLp3z85KScYw07a21HKx2qjhtS7bzZ45x8e7xo--iLcQ@mail.gmail.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <CAJ+F1CLLp3z85KScYw07a21HKx2qjhtS7bzZ45x8e7xo--iLcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0266.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::11) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB3PR08MB8794:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c37feb-5f62-4d3a-b58c-08dbf4f06c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XprVIu3v3qr0PaMWGnosknkLQbrGek04eWVbe3LU3bslVjPuGdfFQl7KaXCEcCcpY06UoPmoI7H5Ffnnj8mwXsNnoYl+68IgKSwdsg0mRXmHewofOE1nkGjodFAqKtOUkjbKgBe3Wvr8hwsYKohoFHM/Bi5IqyWInmticKFyN1AJ3xI8j+leuifOn4rCKEU04HfT2TEPbVxQ1+6PhXb9Qpu7p0JkUN6mQ5ERxBTOTEr5AgTVCYx/DrAFXI60thc7R3HbNGJmJ8G5a2L5CF08sI2qpduYBnc2Ipt/y1qTHBzAHazVXkoeTF0VbSgY/BT9fur2XWSE+pTfcQZdepmdxR1P1vzNocFCg5CousszB9kmCov7xAq35AvRFJFKuABM+osPGXrK9nI6XYAOEk4tC8zvnIsIWI4qvNhtwuGoGsrzgG5CIUVMw6wmU4bGoZkIwXn/O/lp9BYxiKYNWuvuv4QTGXPh5cF+cu2CS+nqmBqRP7Tc/WEDVKnQ1GjVgJzJZTS8lA3yKs4bgk7obHfkw1GXfxQVZuMQt1qhb6N9m6Fre/v3Xl5CxnyLMxRx6ZifqwOUBnuPnClUyavYIwDnDMjduYfgrj+s/xS1qVoFsl0CpgxGjwxGaYQyDz8M3Kz0SOeUDHWqywUDafiSGvBqTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(376002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(6506007)(2906002)(6666004)(478600001)(6486002)(4326008)(8676002)(8936002)(86362001)(44832011)(5660300002)(31696002)(316002)(66476007)(66556008)(6916009)(66946007)(83380400001)(36756003)(26005)(31686004)(38100700002)(2616005)(6512007)(107886003)(53546011)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGJLMGozOTV4MDVHL0V3YmtRUnlGbnZuaUJWd2RpVDhqTWIxNEFiL0Z5Ky9j?=
 =?utf-8?B?NHovbWx2cEJUK1VVa2MyL3FwemYwNEFWY1lpL21adndiQ05sNFA5eXhudk9u?=
 =?utf-8?B?WSs2b1NXME9GZ093SDc1YjdLY0NKcGYzZWhoZmN5S3BDNWh5blpBek1lZWQ1?=
 =?utf-8?B?RWZRZDZuTE05T1VYY3NiQ01FVDAvdGlybVhnZnFNZ1BOeGFQMGlsSVJuWVh1?=
 =?utf-8?B?SlF4ejZJNS9acm85SSt6STYvTStyYUhFTnBGemdkOHNnTUNsQWQ5L01SS3VU?=
 =?utf-8?B?cnRMQ1RyOVlTRzYwaDEzM2NpOTdYV1RDQk53Z0Fab3QwN0NkQVZ1TkRjc3Rw?=
 =?utf-8?B?RXJoeTFsaUdTQkhlMnVVYXhmaithaWtLQmtBS3d1TE1pdWNsbDhHVEJhdFRx?=
 =?utf-8?B?Nkhqemt6SE5hTDhQaE9wNnB0N3gzaWVtSHBzaVZMZlcrUEV4VmxkKytvK3Mx?=
 =?utf-8?B?SkFoNHVHQUNDeTlBc0dCQWpOZlVKcXIrLzJmWDkxelJDNGJJcUtuWnllSW93?=
 =?utf-8?B?NHFVM3lMcG8ySmN3SU8ybS9hUDY0STljankvWXJXdkIvY25RdTJLdjZ1dmll?=
 =?utf-8?B?TUI2NDQ3Z0d1MkFSVU9HTnpqcUhtbURHbVU4WTMyQjk0ZitteU04aURFcElp?=
 =?utf-8?B?RHB1UnJudUIzZGFzWkZNVUd1SmNuMjVlemM3NUtUS1ZoNkhrSTY4U3JmOHpp?=
 =?utf-8?B?SjlkOEZ3Vm9tWXRjcmdBS2gzTHMxSmlvSVMwZUoreS9LR0NuVEEvQmZLalFX?=
 =?utf-8?B?enMxTThPdDcyR2hxQVhRdmF1ZjBMdk03bWNJSHloVnZsaEJDL1IzakhOUzdI?=
 =?utf-8?B?dUNFcEIyeWVVOVorbGhGTGpxT3lNV2pGSnhMR1N0WlhzdXQzTG9rN1NqTGoy?=
 =?utf-8?B?U1dxaFZTbXIyWldmSUFqa01nNW8zYmsxblFjb3dqSW5HUXpKZVFKWDRlblhY?=
 =?utf-8?B?WFoyeDBFcEZpT1V3RHRIZFNFTVUrZllIVmlWK2t3MTMzZ0p5WDQxaFZ3VW5j?=
 =?utf-8?B?dnBnOUlJTnI5MHpEYmdac0FLb0NKaEI2SmtUbG15MGV4K1R4MjJ2dkQzN3B5?=
 =?utf-8?B?TTFTSWhETkwvTzdvaThDcHg0SEo1MlZjSnFzQ2o0YW0zaG9NbjlSdzdXa1hh?=
 =?utf-8?B?TGthTEdzWEpUeTNRclNIQWJEdjZMdFZlNWNDa0U1TlB0UVltdm9UUUsrSmc1?=
 =?utf-8?B?YTUxc1pBV3krS0RwVVoxWTNqbWg3RUdkY1BBTDVjeGxZcXpsa0xNWDdydkxE?=
 =?utf-8?B?a2tBaGZJZFk2QzB2UDFDRGNBdnJGdlR5cHpWZjIzd1hyZ2lTSy9qNEgwN2Jz?=
 =?utf-8?B?OGdiZFIzUk9xUUI5TW5jNHFqTS9vbWZCVXhBaGQrTytmaCtCMzIzRlJMejgv?=
 =?utf-8?B?UGdaR1FFd2xJSTh2MjQ5S2ordENnNVplT2dFLytvWUdRdE9saHk3LzFMUmd3?=
 =?utf-8?B?Zk1VRDVBK2c2WjNRdjlOWGhpSGdleXZ6c1R0bkwxRSt0cVBXTlhsUmpFOHRD?=
 =?utf-8?B?UVdUNFhBZ2IweWJWSFRZQi9pU0VWS1gwUWZES3pkcENra3lTMUxka1pPWERi?=
 =?utf-8?B?TEVXZlVSN2lHd3B3UC9WV0MzWmNaWjljSkk0cnNFZXF1ajVpQXpGUWR0S2pl?=
 =?utf-8?B?WkZmM1JVRDBwVnAzaDM3UjVaSHFkWXN3aDI1NXJzZXhieEhISDV1TmZadjA2?=
 =?utf-8?B?NWVkUVZYUzlnVlNycDk3VkNSaHJlSUhOM1pOQVJWMHgyckl0c3dVSm5XUUVm?=
 =?utf-8?B?Q2lTR0NudVp6a1VaN0o3eTlUTEhiTCtTRHJrbGxOMFp1MUFJLzhQa0RRaTlX?=
 =?utf-8?B?YTEyZmUxUWtLRlVWTTMrT2dzYVc3cUp3WExaaElad0ljTTdtK2NXOE9iYWN6?=
 =?utf-8?B?ejFOcS81eER0UWxCSWdDTU5vQVBycmxPTytPekphUllFWThxTG9vYTJ6UGk0?=
 =?utf-8?B?c2Q0KzkwVTRtMHFpMERLbG5wVDVtN094SGQxaWJYeFJQaGZENHZpd2V0SEs2?=
 =?utf-8?B?L2VOSHJNUGppcmh2eTZmck12TWZSdFVRQzhlbDVwOVpyWTNubk14d2FPYlJ2?=
 =?utf-8?B?T2tOQ2VTSFJ1SlhaK1JGenFxb0RuUmRZeGU2YitUQVFLVStjUzlOM0pDb29O?=
 =?utf-8?B?UTA4bjhpQzQwMURrRkh3QnNwckwzTmJzYTRYY0VrVXhqbTZMWGFENVVkOGow?=
 =?utf-8?Q?f2HFWMMomqB3NFHsLSfZ8VA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c37feb-5f62-4d3a-b58c-08dbf4f06c63
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 17:42:45.2160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K2KpcmyujIK2le8kPFNFlEiVAt2bdZ7aTg8gZy4u9XbkBbBGjhprFYUIDOYvSHzxrIq4iFndkCBgaCnbH/1onr83kjSVWjNHuh0te+6Hp40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8794
Received-SPF: pass client-ip=2a01:111:f400:fe0d::729;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12/4/23 19:09, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Dec 4, 2023 at 9:01 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com> wrote:
>>
>> On 12/4/23 18:51, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Mon, Dec 4, 2023 at 8:33 PM Andrey Drobyshev
>>> <andrey.drobyshev@virtuozzo.com> wrote:
>>>>
>>>> Since the commit a85d09269b QGA_OS_RELEASE variable points to the path
>>>> relative to the build dir.  Then on qemu-ga startup this path can't be
>>>> found as qemu-ga cwd is somewhere else, which leads to the test failure:
>>>>
>>>>   # ./tests/unit/test-qga -p /qga/guest-get-osinfo
>>>>   # random seed: R02S3a90c22d77ff1070fbd844f4959cf4a4
>>>>   # Start of qga tests
>>>>   **
>>>>   ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' should not be NULL
>>>>   Bail out! ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' should not be NULL
>>>>
>>>> Let's obtain the absolute path again.
>>>
>>> Can you detail how the build and the test is done?
>>>
>>
>> Simple as:
>>
>>> ./configure --cc=gcc --target-list=x86_64-softmmu --enable-guest-agent && make -j16
>>> cd build; tests/unit/test-qga -p /qga/guest-get-osinfo
>>
>>
>>> If I recall correctly, this change was done in order to move qga to a
>>> subproject(), but isn't strictly required at this point. Although I
>>> believe it is more correct to lookup test data relative to
>>> G_TEST_DIST.
>>>
>>
>> Then we'd have to change cwd of qemu-ga at startup to ensure relative
>> paths work.  Right now (with the initial change) it appears broken.
> 
> By reverting the patch, it is _still_ broken if you run the test
> manually from a different directory (say from tests/unit for example)
>
> With G_TEST_DIST, and proper testing environment, it works from any directory.
> 

No, it seems to be failing as well, only earlier.  Before the revert:
> cd build/tests/unit; ./test-qga 
> # random seed: R02S450ef942c699b5af6dff48f9c5b73b33
> **
> ERROR:../tests/unit/test-qga.c:79:fixture_setup: assertion failed (error == NULL): Failed to execute child process “$SRC/build/tests/unit/qga/qemu-ga” (No such file or directory) (g-exec-error-quark, 8)
> Bail out! ERROR:../tests/unit/test-qga.c:79:fixture_setup: assertion failed (error == NULL): Failed to execute child process “$SRC/build/tests/unit/qga/qemu-ga” (No such file or directory) (g-exec-error-quark, 8)

But maybe my testing environment isn't proper?

> Tests are not meant to be run manually, you should run them through
> the test runner: meson test -v test-qga
> 

That's a good point, but I just found it suspicious that this is
literally the *only* case of the *only* unit test which fails (when run
directly from ./build).  Could we fix the direct execution as well then?

Btw test runner also cannot be run from just any directory, otherwise it
complains:
> meson test -v test-qga         
> 
> ERROR: No such build data file as '$SRC/build/tests/unit/meson-private/build.dat'.


>>
>>>>
>>>> This reverts commit a85d09269bb1a7071d3ce0f2957e3ca9dba7c047.
>>>>
>>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>>> ---
>>>>  tests/unit/test-qga.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
>>>> index 671e83cb86..47cf5e30ec 100644
>>>> --- a/tests/unit/test-qga.c
>>>> +++ b/tests/unit/test-qga.c
>>>> @@ -1034,10 +1034,12 @@ static void test_qga_guest_get_osinfo(gconstpointer data)
>>>>      g_autoptr(QDict) ret = NULL;
>>>>      char *env[2];
>>>>      QDict *val;
>>>> +    g_autofree gchar *cwd = NULL;
>>>>
>>>> +    cwd = g_get_current_dir();
>>>>      env[0] = g_strdup_printf(
>>>> -        "QGA_OS_RELEASE=%s%c..%cdata%ctest-qga-os-release",
>>>> -        g_test_get_dir(G_TEST_DIST), G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
>>>> +        "QGA_OS_RELEASE=%s%ctests%cdata%ctest-qga-os-release",
>>>> +        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
>>>>      env[1] = NULL;
>>>>      fixture_setup(&fixture, NULL, env);
>>>>
>>>> --
>>>> 2.39.3
>>>>
>>>>
>>>
>>>
>>
> 
> 


