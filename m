Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED08765204
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 13:13:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOyHo-0004ds-Fh; Thu, 27 Jul 2023 06:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOyHl-0004d3-Mb; Thu, 27 Jul 2023 06:31:57 -0400
Received: from mail-db3eur04on070d.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::70d]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qOyHi-0006IH-W3; Thu, 27 Jul 2023 06:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrpOHR2WsgYjLILk+Bv+2r5ABHfvI8iA5PSRh7FOUqDJ+mxzm/A4u094e+xfMdklrZCdte3gC6a0/3rRDL5gnckAPJBtnxQZtKgXoTZMl2HaK58YljdQtmgqKjr71/OI1hcKuqZFhPFCrmBjfe9EajbM36ce3lTmJHRNdtFbTu0rnQ2kLhW6JODqZlGLY/uiJZgovKLA3+4R2hum8bHdZABHTjhMdFjwCEdwhbInBZBrunvI4uKgkzFCwS6qati1mx+++FiCzmlVEszx3CtA9L5UYxMIx36IRCzTAmxG48fNnUt3VPUpwdeOytWq0d107u0ZgNzhSikxYu1KeDPnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnCPKAoi6n6Njg6unxSTzBOvFlwsrAVqttYOLC/5Cv0=;
 b=TY/tXXkZpt/IUMLXdfGle63o3fvZ6Sbrekn2KLDYj+CyK/BP7rRR7JV6AVH4tM+/KMgMERve61vvrU/XZEA32R9UAh4/IqSKg+UnM2PlKqiax9nygWY5ecnJ0rHcfHeti5PA3n2CNH2kPwnUqpcnBroOERbuqQtZYiIUR9iK2PW+c+dngaSxrk4d+Uv0qL5BfvLamt764vkoYwzetD61PFsSWX16qO5Zogs+XYPeKSJUpsBfde9Zh7VzXHM3Fv4p7PQajsfjmB78hK68a26vj8xH2CGvQf1GnmMt4Mtu+EAUlAcctrpBx+kT3v2IhRphzfrrgcxMa9ByGPikYPUEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnCPKAoi6n6Njg6unxSTzBOvFlwsrAVqttYOLC/5Cv0=;
 b=R5VEJjOS07hEwufTD3G0sw9Oh6qJlAdGx5bX0UBjm1OyXPx4pHe2ftCuh/9HAo+nqXoU69NGtFxOTMB5MYSFkbjnQO83g1zW65qmOVpxVbP9Lts83MF90VuxXtp9JOE134NyVF8jIv/h5T+nQiBNUxVXdGxg87iPtM++FY6Mc7YnKl2Fvjb4frCXaUA7gX0NDH0DiqHry+JxmUXlw6jJXU4UezinNYECjtzpKwoLpXaYPYybXsOyKPe1Qwi32FIvZKMRjaBUJRpu7bjHBsDkpscHqc6NKc+6jKF1JTC+wjpvZ6GavkFVt9/7bnoJOquApboiUWopERwFyDurTQRgzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB4PR08MB8055.eurprd08.prod.outlook.com (2603:10a6:10:388::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Thu, 27 Jul
 2023 10:31:48 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::d3bf:704:1220:86dd%5]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 10:31:48 +0000
Message-ID: <7ac6daab-3369-bd99-155f-90fccef19e6b@virtuozzo.com>
Date: Thu, 27 Jul 2023 12:31:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] qemu-nbd: regression with arguments passing into
 nbd_client_thread()
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
References: <20230726145247.297454-1-den@openvz.org>
 <5arr3gmamjxaev6wgwyewnc6ij2wl3oddmju5r2n6lx4rgfcoz@wejhxbmrzyon>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <5arr3gmamjxaev6wgwyewnc6ij2wl3oddmju5r2n6lx4rgfcoz@wejhxbmrzyon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::25) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB4PR08MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: d8f10448-c198-494f-8b7c-08db8e8caee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z39P/KzSeBdKmh3pzOT8EapshMAWB1Lf270DT0EzID6f+A1hNrGG1GncGvoZ8jDUniid0m89Vnjtoqv6go41FCyWBwNUbxrJ3jkujV+Qmz8uRlfvdM4a5Z6iLEmYQMlH0MzuPPob27tkxAdLrYlqfxQnDWM+IoWrBgeUaSMWq7uLz9tnjF1Xe1fnG/fDlVWLSs58CVPvXQOJ+UcZaOnN3qAu1DiyAdrQPPbfswv3H56Yeg8Ten/fbTGVAfjOoCAmY72ikz8U1Js1kQE1UPhaU3DQ7q43ScPd6N+lQy5DQ2PQIndt7dFdTKCRkWupwwdiHrKA0gXLuLL0Rt8ye5JV5rPmb6sN3tHiWQAkJ+3XufWtLIVvqkFoOOMQ3/xAvjPbZD1voQGDNfLCJLKDhrnderar2MLRcrRbg5IktRHF5pdwf/Cv4tLAE+Eu6se4v/T1sc0A5SRVwSwq1kZY6i/rijRTATnQa8zla2U6hvaDp8x1+Kp+NqxOGMxS0Jyd9OiqIoBvbo69pAJiDkLkSz6+0bBRo/NAPWA3Fy5ppZrCT68w1BAfBQhqBeQd7E2OXOd9vzzzxyAHofKTdSCXphTPIB1E6hFYZ3RGb8bHpdjVbQMCOcDBCTafDGR9l+6d84YNtxAOIba+7zunhnIbNydaGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(39850400004)(396003)(136003)(451199021)(2906002)(41300700001)(316002)(5660300002)(8936002)(8676002)(36756003)(31696002)(86362001)(6512007)(53546011)(6506007)(26005)(478600001)(6486002)(83380400001)(186003)(2616005)(31686004)(38100700002)(6916009)(4326008)(66476007)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlhCbUJnTUg5TFpuN2FJaFJPRmpnR1cvZ1NobEdWY3RHSHdjYUZROVFpQ1ZO?=
 =?utf-8?B?ZHBEYmk4N3FlWDBxU0t4NVk5VUVsRmtWWTIvZ1pzM3A0VWI2MUZ3amVEbTZr?=
 =?utf-8?B?eGxaV25zR1F2eXZ1UXRjWW9XZitmaGZhZXpOUWI2ZkpaeFRMbWZMRW1FMmJ2?=
 =?utf-8?B?aHptR05NemNpUzJEcTRiS0EvRTFJN1gydGJUY01Pbkh1SFlLZjVFV0hPdGcv?=
 =?utf-8?B?SGdSQmxTUTRncVc0K3VqODRlRWY0WExHaEJvelBuRzB2aHNPbWNDNU5QTlRr?=
 =?utf-8?B?QzV3U25URFZzdzh4ZlBKMTNQamhCOEVYd2xPZDRFdVJ4RFptUjhwdnRHaEtK?=
 =?utf-8?B?NGk3cWdNNjUvUmZjaTJaOUgrc0pNZFhBSVczSzFTU3JXZDJhNncrTUhnaWNS?=
 =?utf-8?B?NzZzbVlwajNYdkxvZi83TExKekJKT2Noc09MdnhGRnhqYnFJNC8zMC9wY1h4?=
 =?utf-8?B?ZGVHZ0lsc21nTVBycXNCTlFpYmxHSWxCcUh6TEtZaVlMUWxtUnE3b05aaFk5?=
 =?utf-8?B?a2hON0tzSDBxTndsQWZVczlKQmZvNlhoMWtDR0lsMTRiUEYxNlJQWlJJck1E?=
 =?utf-8?B?eTBUWWQ2bVRLUHo1SGcxS3RRcmlJVWlBcXVFZy9Iam5mZkZsMkEyYTRjQjcv?=
 =?utf-8?B?cklPckFTd2lkRkdJbWlTY29ZbWlhWFdaRCtLTWMrb21ObWVScFFuWVRQcXhx?=
 =?utf-8?B?aHAvWHNlRVQzbkxWSjVCMmkxRlN0SEtiOVNCWitTWWwxM0gyV0o0NWtKZVVG?=
 =?utf-8?B?NFN0QVV0eFpoamp4eEtRTjUyTGF2QVV1M3pENzVQRFVXVEZsZEZOdHR2azZ3?=
 =?utf-8?B?ZTkxVnFyMVl2VHhmTzFIQ2s4ajB6a05ualR3RldMUTFZMUVqNGxqS0tnZU5u?=
 =?utf-8?B?bThRUXNIQmUwdXJrbDNzSU1vWldmL1pYVUVoV1MwbHBUZXRGVHZjWHJSc2p4?=
 =?utf-8?B?bms3ODFRblRpNmlZN1JrWWFhWTJFMnhKK1ZJNzFmOHYzSlRiOXFZeldUOExY?=
 =?utf-8?B?aDRheEdrbEFwMEs3a2NJV1JaamhCd3QxSmFhYllYdGVDT1phNUFKQjJMZWFj?=
 =?utf-8?B?ZURVRVdDNlg5cGUyNHpDenlheTMvRlI2d28vVlE0OGVGcHl3SkNoL1h5d3VG?=
 =?utf-8?B?TkhDL0dhL3BGdjlzdFgvM204VlFkellROFBYbC9WSGRSOHhOZlNiOEVTd2lH?=
 =?utf-8?B?ZERzUlpGSENYS2w3enhhdlpNY1ExRUdDL1FMMWZvbWdFbjMvM0tKVW5rVzFz?=
 =?utf-8?B?ZkJ3bnlxdlJRSXFOWnZoRjNiVDZwUnFvY1hBZHJGUVdKMGpZQlhSUXV2SHpC?=
 =?utf-8?B?SlJybk5aOS9vQTFleHVVT2JTZElGeWV5QlVyYjhJTVVKT0VKNjZyQnhDVjM4?=
 =?utf-8?B?Z1Z3VTRvditVU0NPWnk2ZXFyRTFibFA5elEzWkZHKzVKSVBqWWNUQisyekx4?=
 =?utf-8?B?MGltaVBqWFYwZ3JVOGdJZ2ltZnpwOTFJYXpZZmtBVmN4ZWUyWUt1YVRYaDBp?=
 =?utf-8?B?cjRic2dQUWxLTDZqWGtxVGlwZy9ZVVhOdjZzSzhtSXowMEFPeDJEd3o0MFgy?=
 =?utf-8?B?eFNJSVJLYjJOTFZwUS9MOXJFK09PSzk4RWU2bmdnaW1xWWFvTXdqbnJpWFhx?=
 =?utf-8?B?THdNcW5CeDdyWkxVekR4QmFUQjNnM2UrYXNUd09QbzZ1QWZVdHZCNjBxWnpT?=
 =?utf-8?B?QTZxZE1mdHRWSlhKVGJtaXdvMmdsL01PNDhMYXBKeDF2eE1VQnVUWmlTUytH?=
 =?utf-8?B?V3FTSzllc1hGRGRjc1MzSU16VHJxRlV3bDFHU3g1bW1rZDF3K1JNZ2pVZGwv?=
 =?utf-8?B?L1pBcURnV0pzSGtGRmhmL0RpQzNDU3VVSGoyTHdHUFRWZm1mVTdwRGFtMm9y?=
 =?utf-8?B?MXRqNDhIbi9iYW1OUmlMMzk3Z0JBTVZ6MFJYV2NrQmRvdVR4VWo2dCt5N0Rq?=
 =?utf-8?B?bXNGWEFaT00vRTFOU1J5NWlGT0VEZ016a0k2bXcxTXZxMG5SS0FnM29hWlVD?=
 =?utf-8?B?U3kvVE1OeVp4aVVSekN2ZFJmUjNJNTVzOU1sc05CSXlxQ0RMVTJmUlNpaW8z?=
 =?utf-8?B?YUR0bHhhL3FrTmlQWDUxUEtta1FnS0VEWXZwS1pKRytxcTFlMG5raUlOTms2?=
 =?utf-8?Q?sY6zHKhOtO0Bzm8RIyQFD2FqU?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f10448-c198-494f-8b7c-08db8e8caee1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2023 10:31:48.5247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSVGZDOEMI+H4Fsq0UJ3ZLi86C1xIeiCM2k9/YJqlPZd0ujIespOSKVXdikFhN2VFGiPUvZlsGehRa+oHStuBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8055
Received-SPF: pass client-ip=2a01:111:f400:fe0c::70d;
 envelope-from=den@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/26/23 19:57, Eric Blake wrote:
> On Wed, Jul 26, 2023 at 04:52:47PM +0200, Denis V. Lunev wrote:
>> Unfortunately
>>      commit 03b67621445d601c9cdc7dfe25812e9f19b81488
>>      Author: Denis V. Lunev <den@openvz.org>
>>      Date:   Mon Jul 17 16:55:40 2023 +0200
>>      qemu-nbd: pass structure into nbd_client_thread instead of plain char*
>> has introduced a regression. struct NbdClientOpts resides on stack inside
>> 'if' block. This specifically means that this stack space could be reused
>> once the execution will leave that block of the code.
>>
>> This means that parameters passed into nbd_client_thread could be
>> overwritten at any moment.
>>
>> The patch moves the data to the namespace of main() function effectively
>> preserving it for the whole process lifetime.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Eric Blake <eblake@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> CC: <qemu-stable@nongnu.org>
>> ---
>>   qemu-nbd.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-nbd.c b/qemu-nbd.c
>> index 5b2757920c..7a15085ade 100644
>> --- a/qemu-nbd.c
>> +++ b/qemu-nbd.c
>> @@ -589,6 +589,7 @@ int main(int argc, char **argv)
>>       const char *pid_file_name = NULL;
>>       const char *selinux_label = NULL;
>>       BlockExportOptions *export_opts;
>> +    struct NbdClientOpts opts;
>>   
>>   #ifdef CONFIG_POSIX
>>       os_setup_early_signal_handling();
>> @@ -1145,7 +1146,7 @@ int main(int argc, char **argv)
>>       if (device) {
>>   #if HAVE_NBD_DEVICE
>>           int ret;
>> -        struct NbdClientOpts opts = {
>> +        opts = (struct NbdClientOpts) {
> Does this case a compiler warning for an unused variable when
> HAVE_NBD_DEVICE is not set?  If so, the solution is to also wrap the
> declaration in the same #if.  I'll see if I can figure out the CI
> enough to prove (or disprove) my theory on a BSD machine which likely
> lacks HAVE_NBD_DEVICE.
>
> With that addressed, I'm fine with:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> and I will queue it through my NBD tree in time for 8.1-rc2.
>
Double checked. We will have an error there as 'struct NbdClientOps'
is defined under HAVE_NBD_DEVICE only.

../qemu-nbd.c: In function ‘main’:
../qemu-nbd.c:592:26: error: storage size of ‘opts’ isn’t known
   592 |     struct NbdClientOpts opts;
       |                          ^~~~
../qemu-nbd.c:592:26: warning: unused variable ‘opts’ [-Wunused-variable]

Checked with simple
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -52,7 +52,7 @@
  #endif

  #ifdef __linux__
-#define HAVE_NBD_DEVICE 1
+#define HAVE_NBD_DEVICE 0
  #else
  #define HAVE_NBD_DEVICE 0
  #endif

Den

