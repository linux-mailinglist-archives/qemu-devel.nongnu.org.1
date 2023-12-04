Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CF8803B16
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 18:04:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rACKN-00004v-By; Mon, 04 Dec 2023 12:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rACJr-0008O9-Rz
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:01:21 -0500
Received: from mail-vi1eur02on20723.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::723]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1rACJp-0001dR-N7
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 12:01:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuDr3bIzQq3xY9un6Xbea2MO8Z9iUJEFRYIDjJVAUkkkFRV/l76ig57hTRbhsS8NTzWR8+ezyerxQjeR+M8vSjlUzlLRg8v8EDd0V5JPOzndN3/C5RivdhK8SSSCgTk50x3FYj0yNJpcBnVQ7uI8N/qduiTocLkVi/gEQhHuAiwKQk5nkDsSd9aj1LY45AsZOW/rg3TcnG6Bpk9aW+0rdhXOzBwN3d5+LjyaXxv4w3Ari5PZmkDLk2SFm6NPw5tE+RGqpjZ1+B867a5feYllfTZT4yfqlpZ+ZYf2F60I6pyKdpy1tc430mX4/2czkSYoMy5DJkx70A8sG0JP/H0wnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzJluhwKFG16z+bjuPv88tLKV1Xi4GHyGYUtd7i/1Rc=;
 b=VFKTyvkbh0jiwfnmsqOnsIzYtCU8T35zVaWjuDk4yEmPLItTAmaZYTL/xJoy+wQdAhFvATXGgZmDuJFwd0/QfQXQuq4e+omGR4QxzLvmVYP3wfMvIlPlauzDl9KLRbmBr/f1HuaCDGoaelEmzsl8PLRKFnJyvgC/Pd9XJtIHG6UNn/QiY0KrxItFeVjn2uXDTlX3LPbqhAoud0LpPhx+YFU4MzQlrcnNab+YgE61HfL0h/reHngdIPwMpnhDM9pZYyovisaxTpkiOlx0ymQNMVUSZLUSYpX8ZB3CUS2prK5iIt20ewRSrMF/1YgA7DB/aC0wFuaLKjwRHderXWIxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzJluhwKFG16z+bjuPv88tLKV1Xi4GHyGYUtd7i/1Rc=;
 b=r+GGvBbaeVlLxogNcvtfjbufAi4+GogRkNt8JtMIKpOSLBVZICthSTfO8o6t/R5fMH5ZhtyliLDux5nPBrrFZbFuubIAP4sjhkkCQv31UvHcEs0tTKY2klctbUgu9hKQybLBEWnKBkE5kVBfxyFVl+OAWD9aKDiC191f+34iai4jCrpcKy8ttrGD5qB4r527Rb2h3qHw9En4661wHVrSYpSD4rSQEeJOWedgLC9QWTTT4/EPo+kZT3ZdVtRmKdQQ9mmUV+K2c5B3FX6Lbnc31Cd8kH+CXfaKg1XRCUZGFeyL7pZ66QmphTUpFSqro8ysq9i/UDv5r+8gNQ/FDhHkJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DB4PR08MB9238.eurprd08.prod.outlook.com
 (2603:10a6:10:3fa::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 17:01:08 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::597b:57ae:f418:2352%6]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 17:01:07 +0000
Message-ID: <d91b89b9-41bb-4968-ae46-438bae0b3952@virtuozzo.com>
Date: Mon, 4 Dec 2023 19:03:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "test/qga: use G_TEST_DIR to locate os-release
 test file"
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, kkostiuk@redhat.com, michael.roth@amd.com,
 den@virtuozzo.com
References: <20231204163257.1011556-1-andrey.drobyshev@virtuozzo.com>
 <CAJ+F1CKni6vzAfPDefU8c-kRuhPDbzOohpC0bZ40WGOxLGGtmQ@mail.gmail.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <CAJ+F1CKni6vzAfPDefU8c-kRuhPDbzOohpC0bZ40WGOxLGGtmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DB4PR08MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 21986052-8d34-4e3c-ac07-08dbf4ea9bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ay9M3xhASlCguU5po5P9zYrqzMYUEeh7HFZXAbmXIZ3p8+qEv+uYuc/JMuvQS0wR2bS0KS96wsk6ArxN8HdjgfTsGZYluL16EDSCK4x46EHXDJQlUm/8KE46YWSkcWlVhsJGIFk4OvIoUssfX61XxeymLsoxNFTQfsT6Tboix8Itno4STbqJayGdmZMjAL0HDZEz3IpAEqPLML2BB1uJGmXeZTkfvjn2KLEcqfeX0YO0Xhg1TdTSkLy/lAIDYUeIUxPA6y5kKkt9rfrHXxfkVn1/jxA4Yz7So4cqL0oCp6HNs2JMKhcGtwV3/nRSOcyyWzP4Gu4VA2fUS+r9cPufUH6RLyX9qVAkGCk/vKIA/Ny0gk1IjSSpptI/TeIZqpm+w4agg+fLp/pP5OSzsBgALWyiAjyNTBLRJCE3sqL/wPqMpKkVLQWhGXH4ZWDSWkhjWAyZplRVREdJY6XJfdnvyFr6UJs1l8qhKwKrnWSW//87vwcq0okhJKEOU6WKAUxRILWKQhLJoIGICTPUY9ekqZBjgRIKz/THKHe67M7PqRpbZ4o5UQ1mkcNCdJpSHp5egpVrPplhGQ1nNA07BN8Sr0KDtCqbjpXBvtBcZPfQiDmeNq1ie9CVknjR37qW/WMtvp6cxIMKuFSADUT1HZtQpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(136003)(366004)(346002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6916009)(316002)(66556008)(31696002)(4326008)(86362001)(8936002)(8676002)(66946007)(66476007)(44832011)(478600001)(6486002)(41300700001)(36756003)(2906002)(5660300002)(38100700002)(2616005)(26005)(107886003)(6506007)(6666004)(53546011)(83380400001)(6512007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1VFSmtzTGhxdVlrSk41Y0E4TzNUWFRIUzBsR09FcU95SHdRemRLOXp0TWFH?=
 =?utf-8?B?dCtySWxSbnZ0aWM2UGRxdTJ6ek56TlJXSGFHNkxYNHJvZ1p0YXNwb2NleUYw?=
 =?utf-8?B?Zlo5VWY0U09MQ1ZZTFdDbnJLaDBTWlhNbllMeWQxZlJsMjFvWEdrY2UyaG5H?=
 =?utf-8?B?VHM3TS8vK2lEeEFaTXRlNEw1U2lQRk1HdlM0NkkyQ1hlZEs4SDdWQlU4ZGhu?=
 =?utf-8?B?MG9acXFUZlV3dWVrWVlPZ2JHanVhTlQ2RXNXQ1piOWpXYzBqZnhIc2gyQzZF?=
 =?utf-8?B?V09VZVFoazhrWWpQSnBKNHZMVXN5WDFzQStLbGRGQnB4UkkwL1VpVFVOeG0v?=
 =?utf-8?B?WjRvaTI4QnVuSXdFNm0xeVRHSnBnNmRXNm9GYTBZZXIxV2tWL1dBYjBqaWpT?=
 =?utf-8?B?c2hBdFJYWUhuZS9xb0prS04xNFpuRHYzREdMS3Y4SC9oSHdKQ2Y4V09MYXNE?=
 =?utf-8?B?bVFtYTZOdjRBMWppVDFQT1d5Vit0bWFsV2h0SmkrVE9aT2hoMitVelA5VWVY?=
 =?utf-8?B?MUN4TjFzLzZSaGJoaFlHWGd1UmhQemQvemVXY3BJbkFtcDQwL3E0R1ptYVpY?=
 =?utf-8?B?V2h2TW9OeXhNZmJyZ250VzNCSklEL0hkR0lyTytBc1RGa21jdUowcmlMeXFO?=
 =?utf-8?B?blR5dzJ4cWVlaTBTM2V3Q3U3VFlBQmR3MmlUb1MvUk9EMHE4UitnMGp2ZHk0?=
 =?utf-8?B?MWl6M1JLUTlDdFhnNHBkZ05tS1dWVUkwNFltTno0RnUrUkFtSWdqUVRMd29U?=
 =?utf-8?B?WDFOVGJoQTNhdjFLYUVwZnpJN3ZzWkZHTHpOQk1rQlkrZXJqMHQ3L1YxdWdG?=
 =?utf-8?B?ME1kcVlBNHNCZ3BtVjMrZjNBem9XNDlvNU9heGFYejFXMlIzZ3l5WWhtYjN5?=
 =?utf-8?B?LzBlb1FkcjNSandoUXpyMkpmR1c2V1NRWUhCR0lDNlZSM3FaU3RaUmJHRFpq?=
 =?utf-8?B?K0lLMy92RmRRTnlKejE0ME1NK1VqMmlLVnJwL0RUK1hUaXV5RUtGcTBoeVl1?=
 =?utf-8?B?OWczRGhEWHorT3dGaHBqUmVTK3g4MFJiR3E2S2lGMld6RFBpckZsV3ZIbkh1?=
 =?utf-8?B?Rlp1RGZlNmRmNlFwaHRsMFBYVTVyaE9GYmcwRjBNS0RzNnhSMXE1NzV2ZkFP?=
 =?utf-8?B?eXJpa2FIU3pYbDkyZkc2T0ZZM0dYR1laZE0vUUpVU3RQWnNaa3FkUlFLWmpT?=
 =?utf-8?B?bEUwckZCVWpDVm5UbHEycTlsakZ0Q3VmYlNEcE5YUEJaVGJVTitlbjVGV3N5?=
 =?utf-8?B?cFJMcDlEUEkvZ0lENEVUaTY4dzJjcnZDbkF3QmM5SEhuYm42ZDFUbWFXZS81?=
 =?utf-8?B?QTJCNGljeXF2bGlUSjc0N0N1YjlkNkliMUJ3Y0xCdC9WMkd0MnF2eW45bno5?=
 =?utf-8?B?VmplMy92U1dwdVVWYm5HTEtuSE5ob1YxdzdTN0NwOHRCR1NYV1NXVC9sZG5Y?=
 =?utf-8?B?U3Z0Wm92MzJCRjhwSHFQSnZJNUpJNnhKOHJybVlGY01SaXc1MEJYVFVSV1Fx?=
 =?utf-8?B?OTRsdWlGMFRsSHBtRkpVWGdkbllvS2tIdm8vNDgyTnk1Y0lVdUNSR1B6aVEx?=
 =?utf-8?B?Um5EVzRPT0d5czJYLzZIek1Ha0FmaDV4eEFBOEJsR1dwSVBHYVRvelo0Nkp1?=
 =?utf-8?B?Ym1CdzJOc05DK1ROVnQ0VStFSUNHV0M5R25mNHN1LzVCb25pVldPWldOSHNP?=
 =?utf-8?B?YjV2cEFnMTdEeXJxdlFNbmQ3MzBpbTluWEljUGNYMVlMUVdQbWttRUlKUGt5?=
 =?utf-8?B?R1RJUG9HcFIzZ1NPalB6U3p1ZzhKaENzamx0aEZvQVRVSUJoYitkd3ZiRGJP?=
 =?utf-8?B?SWhsR2E1a1dVanI0RkRrS3BzNmxXZ3E1ZjgrSVhtcjhOR1ZoSkdZT01jTGln?=
 =?utf-8?B?a2g3SDJSdTJIUkozMnNCUDRrclJJMCtnWjR5RzdWVU5LMkg1WCttSjk2UDQz?=
 =?utf-8?B?OFJCRVg3NW5JMVVEeHc3OXJQZHJZaWdYTUlXMVdEbmszZk0ySFlXc3JIcVB0?=
 =?utf-8?B?a0JHTFppeHJrUmNHMDhnQXU1VGlyYmtUamM4MzcvK2IrUEdSZ08wZjBKdFZD?=
 =?utf-8?B?dTFCa0ZyMEVqbG0zZy8vbVJSWllhOFE4cUpCVTVNQm9yNW1wSGorNk1hekh4?=
 =?utf-8?B?L01oSlkzbkJIZXQ3MFBqU0llUmUyZWVob20yWlJjZjdXd2xaMjU1Tnk5WHlC?=
 =?utf-8?Q?F9I3CVbkTlsodoOCVzibORM=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21986052-8d34-4e3c-ac07-08dbf4ea9bca
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 17:01:07.7447 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GE9SWykvHr/b3OcF21FjISjygrFuC/CAEWQ4qvjmSplwB1cnKcNKclyTiLuEksH1LyUDViETabs7Z8QQwA2DdiVJcYFGL/A6h76Wc+Zg8xI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB9238
Received-SPF: pass client-ip=2a01:111:f400:fe16::723;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 12/4/23 18:51, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Dec 4, 2023 at 8:33 PM Andrey Drobyshev
> <andrey.drobyshev@virtuozzo.com> wrote:
>>
>> Since the commit a85d09269b QGA_OS_RELEASE variable points to the path
>> relative to the build dir.  Then on qemu-ga startup this path can't be
>> found as qemu-ga cwd is somewhere else, which leads to the test failure:
>>
>>   # ./tests/unit/test-qga -p /qga/guest-get-osinfo
>>   # random seed: R02S3a90c22d77ff1070fbd844f4959cf4a4
>>   # Start of qga tests
>>   **
>>   ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' should not be NULL
>>   Bail out! ERROR:../tests/unit/test-qga.c:906:test_qga_guest_get_osinfo: 'str' should not be NULL
>>
>> Let's obtain the absolute path again.
> 
> Can you detail how the build and the test is done?
> 

Simple as:

> ./configure --cc=gcc --target-list=x86_64-softmmu --enable-guest-agent && make -j16
> cd build; tests/unit/test-qga -p /qga/guest-get-osinfo


> If I recall correctly, this change was done in order to move qga to a
> subproject(), but isn't strictly required at this point. Although I
> believe it is more correct to lookup test data relative to
> G_TEST_DIST.
> 

Then we'd have to change cwd of qemu-ga at startup to ensure relative
paths work.  Right now (with the initial change) it appears broken.

>>
>> This reverts commit a85d09269bb1a7071d3ce0f2957e3ca9dba7c047.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  tests/unit/test-qga.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/unit/test-qga.c b/tests/unit/test-qga.c
>> index 671e83cb86..47cf5e30ec 100644
>> --- a/tests/unit/test-qga.c
>> +++ b/tests/unit/test-qga.c
>> @@ -1034,10 +1034,12 @@ static void test_qga_guest_get_osinfo(gconstpointer data)
>>      g_autoptr(QDict) ret = NULL;
>>      char *env[2];
>>      QDict *val;
>> +    g_autofree gchar *cwd = NULL;
>>
>> +    cwd = g_get_current_dir();
>>      env[0] = g_strdup_printf(
>> -        "QGA_OS_RELEASE=%s%c..%cdata%ctest-qga-os-release",
>> -        g_test_get_dir(G_TEST_DIST), G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
>> +        "QGA_OS_RELEASE=%s%ctests%cdata%ctest-qga-os-release",
>> +        cwd, G_DIR_SEPARATOR, G_DIR_SEPARATOR, G_DIR_SEPARATOR);
>>      env[1] = NULL;
>>      fixture_setup(&fixture, NULL, env);
>>
>> --
>> 2.39.3
>>
>>
> 
> 


