Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BE27DBE13
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:38:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVGq-000880-8k; Mon, 30 Oct 2023 12:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qxVGo-00087l-7T
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:37:42 -0400
Received: from mail-he1eur04on2121.outbound.protection.outlook.com
 ([40.107.7.121] helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qxVGi-0003NH-Q9
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:37:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrhaQH5OHRzpuWaWhTF8k0pF5h1BG+M9hNvAWC2brrGqps/jfeN56xZQ4e7qs/dGCqESeoNpUOibjo6c/6pROulVvzRCU5y77a8tMEZYl8Tcw5MLd+oSlLJn3orjhrbHksF0/LGKLvVTDSlqjHbTBgqzrNB3mFdwlWLmqJ28JMyL5Ay6Lc8G4usWou09pnfaKLy7SbhJuy6FS1uyyX32IMYP9Gj6kYvb3F8kjgej2qDHvthnbLMVbTQ/TDg50Qi+UhfD6IWqkeNX4hOYjQ0BuPT31v0CSbrB8lBMHehjp/U80qexdnxk8XoVr/DfiUr5S2HO/J5BYnfbS8nln8X/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1UhRuvqRh+CfbuNNeoq/z2wsjh6Mf2Z+8rcoNKqwCc=;
 b=eCsFQb7Hqzygfac3HCCO899U4tVYB9GbyiLQuhjqyNCtdjjtzuGkv8Z2OxkmEcH/TEdTgDMN9gezgSLmEEZLLrW/BMiCWQW2ZoVIVua0BIGYJ6/B1K6DcN1SpjvcNqJFw1bJg2I5wOeUAgdMjl6hF0xKFftEHulCuNZJWAPuJAiw7V/uqi97lka2idnFz26dg1zyCEk1C0j4F0443At+YmsQn9rbja17sUeIKZsALXoaf4G12CsOVMveQOgOtl3z8k632j8KNU6kjTSB4b2VvXj7EQVFVYo6Qe1SE9B+cpCWmNdNUFPOzaMtunD0xyfkosD7np5xhz4iptsos9AYgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1UhRuvqRh+CfbuNNeoq/z2wsjh6Mf2Z+8rcoNKqwCc=;
 b=Itm7GU5eDn2eemyst0Vn+iQ6u2kvBQw92BFX3c+PPVIorSAs63+a7FCn5kYI9WgohxVTcX31tuSyjmWTU4wLisvSCDBl3OMnYewTk+7k9Yg7w/yFzh+nt16/SiYN6ZX9ex3KVy7wkY0eR3XJQbWD74CRhsqIHC/riC8/ENJ+9Rp/NQYniveJgDmVbF/46RQZSWrHpJ4WmXImTKhI5U9dB7TsWOaYtz7oJ/e1yvh/MHjlR49UlrdoQQaBiSUp5iFuvjyLvAGLzsDyJzUFHgGyKM7AOPI94rivfZDUb7eA+v/FvvsMsBXUkKJjj2h0Y6w7uRkCcJQ8oEDL0rXK4MocTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB9PR08MB6348.eurprd08.prod.outlook.com
 (2603:10a6:10:263::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Mon, 30 Oct
 2023 16:32:29 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 16:32:29 +0000
Message-ID: <72a77154-a8b5-4b22-af7b-6be36fcbe033@virtuozzo.com>
Date: Mon, 30 Oct 2023 17:32:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] qga: Add timeout for fsfreeze
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, michael.roth@amd.com,
 marcandre.lureau@gmail.com
References: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
 <20231025140058.113376-6-alexander.ivanov@virtuozzo.com>
 <CAPMcbCp9696yH+u6bSX9ku7uLaaSxyNdC0RKAoQmjd00m8zAGg@mail.gmail.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAPMcbCp9696yH+u6bSX9ku7uLaaSxyNdC0RKAoQmjd00m8zAGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR0502CA0016.eurprd05.prod.outlook.com
 (2603:10a6:803:1::29) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB9PR08MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c351d0-0e3f-4468-50a1-08dbd965cf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FpKeli2NNW1f4k0SETp+v2gMmeyirObnsIaoczwHnJfNGmV6YQIMA+CtINsfFqoxmofMHA2SaqHA3lh3C015o8k4ga0tzMnrkNTGl91k02kEcUIxwakTZyaC5d2+GhiAZoFmpQvUiEvWwH4vI4MnpWFX2Yf4Mkz1MV8ir0vt+Q7H4aJfxPLHt31YZi7RxPlYKILmWsSHECttRMZkSmXCpTIG/2Fk72nLW6ii+TDobpHAFhuQSVENGB4HBSE9PEeYWBXu/3TMPmEtTBhgLrwQTB5lXnvRmvB3oks/l9b/FgoFzRLWVnyANTqGP9BV+FnEWGBDvHGO6RtAbEnyON560/cRNKx+I4LpsyvYpPpV18p0zLJCX2US7YT61Ge7HHFGWcZHYorwb7l00sv2lYlbv6hlw5IpSJ3j97QWhCIjRj2RHKUMMqVBmwk0gkQy2RzmV+D3Al3+04bVySzSmdOzRFLSrAIhCN9p8w7pV7JE4+lpL7/IUpA6Xnin3qOlWkYrGaq8ScTZm/pKYaIA3eihpf6eZh5vyz11Dr9nC3mAKkDI7JIjoDMFLj8b4IEqbfqxJKowQTFk1TVf7CkkMtOWPDYnE58owPyQQ4N0W9Epd+gGOVRcZDaIHUwL+DRrwl4mOOb1beSUiEzdiMBVzuJOxAsbjFU1jzUbylIPWKpV8kqZ4H6axS2cFdpG7fXoHSfM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39850400004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38100700002)(53546011)(6512007)(6506007)(6666004)(83380400001)(66476007)(66556008)(36756003)(66946007)(86362001)(316002)(31696002)(6916009)(5660300002)(8936002)(44832011)(8676002)(4326008)(41300700001)(31686004)(478600001)(2616005)(26005)(2906002)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dis1OVNkRlk0cXRyaXJiTUdUZk5nTWpkY1lVaGpYVmZobStqYi9FNmxEU0k3?=
 =?utf-8?B?NTlYaU9tM0ExUENLT1ZBS0Z6aU0yNGYxdkZObWNaMlREcmZqREROQ20vMXh6?=
 =?utf-8?B?TVRnV003a00xRXhaMDczVFpGM2R1NDlZeWpHTVBVTnRGcnBlWmhsZEt0dmVx?=
 =?utf-8?B?aWgycm5jU3pWbVpIYmd4QXBZdTUyV0Y4V3R4M2ZtTDVjdkVHMG52Rm9yaCt1?=
 =?utf-8?B?OTUyQU9iUWlRNlZZSnl4UGFpNWIxcXQ5TVI0RWxUODlBeUozY0JldlR2OVdz?=
 =?utf-8?B?S3dGRWNoOCtWU2xHNVl5cGxNY1ZURHZvY3RUNjVBZDRRc2ZmOVlObTM4cDBQ?=
 =?utf-8?B?WC9jcVRic2ZmaTUzOHltczNsTDh1aUFQUDg0VGZGbG55WUtZNkM5MXB4bC8w?=
 =?utf-8?B?eTIvemtVYi91ZzVXWjUvY0tkYTJNOUlHYmZnUWtiNmsvcWo0SHN4TThWbmRw?=
 =?utf-8?B?Tm5qWitJamlObXBZcWpPbUV2S0M4WVh3bkljZml1RmxuQVBIY25HZS9lTVRl?=
 =?utf-8?B?bWcxcHY4MUsxWEcwNDRDaTFhZUlvdXJJRkJveWtKb2xSQWRmSnVwallTSHcw?=
 =?utf-8?B?Y283aCtoQWZMNHl5cTJ4QnEzQWduOWYwK0twdnpLQmZrdkYrU0JEbkRVd0hW?=
 =?utf-8?B?S2NiOTl0cDlZVHNudm8vY0I4a0U1UU4rSFF3aTZMK2ZIV2c2eHlVaVJkV25l?=
 =?utf-8?B?c0JqeDNhMXcwN2RlYlpkWTdHTVUwNnI2UGtESkdiTVhJcWJVVUgwcDIrYkdL?=
 =?utf-8?B?Q3U0Rk5Xa2ZMbHVnUFpvOXQ2SkZPQ3hINVhyNTE3NW5SN1BKalpvdkZMUFlW?=
 =?utf-8?B?RjhBQ3dPb1pnOVJFQU8xYVJLTDNwT3BvOGoyb1AvaTFCU0dSWksraGlCU3U4?=
 =?utf-8?B?Z3IySEcrZ0pVN09DNnllNURtd3BZd3R0dFdVZGFQZlh2dGRUeHFjMmF5SVZU?=
 =?utf-8?B?VVVtV2R4L3hsSEloekxkY01POUVzaFJEdkhxMGJSeEMrdDk1L2I1aWl1azBx?=
 =?utf-8?B?bU1wNFd1dnVEL1FjelU0MjFMaEVWWjdFNU1GME9pQXVGNmhjTVdiMVZQVUdR?=
 =?utf-8?B?YnVoaWN6dUltZW5LQmVCemdTTUxhRnpSTkw0MjJETCtpcjRIK25kWk94M3RK?=
 =?utf-8?B?UzN5b0Y1SkZScHp4ak9XNzJ4RmZ1U2dGbVk5bUsya2NmRXhSQ1J6b2dYZzhE?=
 =?utf-8?B?T09tU0RadnlucXNGSzlDRlVrNFJhaG1SQkc3U3dHNlJBUjQ1aHh3RnlXbXR5?=
 =?utf-8?B?Zk9TNXZKWGhnZjZ3aGNmWmgzQkpib29IUUpaelVkODR2NDBBVTUwVElMTDdC?=
 =?utf-8?B?UXQweUVvN0FYUnFlUWxvM1hMcDlXMW8rbEluYmpwVmd0T1ZrUWxyUU9hd3hS?=
 =?utf-8?B?VFd1QzNJOTVaNjdzRzFVTHJPWHE4SUtmWkl6eHlSV092MTlrcnVLK2lMdS95?=
 =?utf-8?B?SGs1SmFDZW5zMC8vYzEwQlZKcWZQS2tTNUVGMitXVFRHcXA2Y1lCM3kxSC9x?=
 =?utf-8?B?TVFvdEtIVWdtUzJ4RTl0VGR4cGJCK1E4M3owdVZwamx6REgrWlkvdlo3VXd5?=
 =?utf-8?B?RmxMUi9HcWxhc1cwQW1uSDV0SWtUNU5wRWZaZnRwdTN0dWt1R2UyUUw0L0tP?=
 =?utf-8?B?Y1VqMFlkRkRodER3SkVaaXc1dHUxTVl4M2RGOGxrMWRRdEQ3bTQranFmTTdo?=
 =?utf-8?B?VktJWEYvaVVnRWh6Yks5cDJEd0cyMEEzWWtqWWdnRzJSejdUSElTRmFRenJQ?=
 =?utf-8?B?N1JSb2YxUkYrRXhjckVTNTNwNmw4MEtCMHAwekFUbmJXUVl2Z0pJUGFDOWtj?=
 =?utf-8?B?eTlDcXZZaDZxdWsvMURoLy9ZenFXOFczMXJYdmtkNGo3UFR2Mld5bktqUTJm?=
 =?utf-8?B?eEkwZnhRdlBjYWZXY05sa0RORjBlVHUvUDRFbTdpQklxMFk2dmZlV1IrQ2x1?=
 =?utf-8?B?K09wNG5Qc21BbzNMV1RFdjQvdTRxUXA5citIaTVsYWVtVFRTRGF2eEY0NnR3?=
 =?utf-8?B?cUdpZ3pVNkxPaXFqcHh0eTQveGRydjBXRkFkL2VMOFBmb25rSHFmZlBjQzlL?=
 =?utf-8?B?OVdrWVJWMEJlTmlPSmh4aXhxekJROGY0aUNjQmtSTkxrekZYNjB6UFRrMS9w?=
 =?utf-8?B?Rnl2MHR3NVA1TWFCQjBuQVcrWWxoanB0U3NpM3ZBZ2NMdWE1bitnZmV6Wkxp?=
 =?utf-8?Q?RPsCv2w184dFQFehn9wtFT8=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c351d0-0e3f-4468-50a1-08dbd965cf34
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 16:32:29.5532 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgXh0NzaqH5SjPwYMpdoGlEqNP4M9J7A9VSmt27+et2rHxBfi602ElgzrSf0zhjGSmkpODhhvd6x4wodavMnF4vxEQOrLGG/VmBgl43gCcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6348
Received-SPF: pass client-ip=40.107.7.121;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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



On 10/26/23 11:16, Konstantin Kostiuk wrote:
>
> I think it is better to check that timeout <= 10 sec in the case of 
> Windows.
> Anyway this is a VSS limitation and FS will be unfrozen earlier if 
> timeout > 10 sec,
> this can cause some misunderstanding from a user.
Thank you, will pay attention.
>
> timeout option sounds good in the guest-fsfreeze-freeze command.
> In guest-fsfreeze-freeze-list, it looks strange to me. Command returns
> list but takes timeout option. Can you explain timeout usage in this 
> command?
The second command doesn't return a list, it takes a list of mountpoints.
Both of the commands freeze local guest filesystems. The first one 
freezes all the FS,
the second one freeze only FS from the given list.
>
> On Wed, Oct 25, 2023 at 5:01 PM Alexander Ivanov 
> <alexander.ivanov@virtuozzo.com> wrote:
>
>     In some cases it would be useful to thaw a filesystem by timeout after
>     freezing this filesystem by guest-fsfreeze-freeze-list. Add an
>     optional
>     argument "timeout" to the command.
>
>     Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>     ---
>      qga/commands-posix.c   | 21 ++++++++++++++++++---
>      qga/commands-win32.c   | 16 ++++++++++++++--
>      qga/guest-agent-core.h |  3 ++-
>      qga/main.c             | 19 ++++++++++++++++++-
>      qga/qapi-schema.json   |  9 ++++++++-
>      5 files changed, 60 insertions(+), 8 deletions(-)
>
>     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
>     index 26711a1a72..e8a79e0a41 100644
>     --- a/qga/commands-posix.c
>     +++ b/qga/commands-posix.c
>     @@ -707,13 +707,17 @@ GuestFsfreezeStatus
>     qmp_guest_fsfreeze_status(Error **errp)
>          return GUEST_FSFREEZE_STATUS_THAWED;
>      }
>
>     -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>     +int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,
>     +                                  Error **errp)
>      {
>     -    return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
>     +    return qmp_guest_fsfreeze_freeze_list(false, NULL,
>     has_timeout, timeout,
>     +                                          errp);
>      }
>
>      int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>                                             strList *mountpoints,
>     +                                       bool has_timeout,
>     +                                       int64_t timeout,
>                                             Error **errp)
>      {
>          int ret;
>     @@ -734,8 +738,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
>     has_mountpoints,
>              return -1;
>          }
>
>     +    if (!has_timeout || timeout < 0) {
>     +        timeout = 0;
>     +    }
>          /* cannot risk guest agent blocking itself on a write in this
>     state */
>     -    ga_set_frozen(ga_state);
>     +    ga_set_frozen(ga_state, timeout);
>
>          ret = qmp_guest_fsfreeze_do_freeze_list(has_mountpoints,
>     mountpoints,
>                                                  mounts, errp);
>     @@ -780,6 +787,12 @@ static void guest_fsfreeze_cleanup(void)
>              }
>          }
>      }
>     +
>     +gboolean ga_frozen_timeout_cb(gpointer data)
>     +{
>     +    guest_fsfreeze_cleanup();
>     +    return G_SOURCE_REMOVE;
>     +}
>      #endif
>
>      /* linux-specific implementations. avoid this if at all possible. */
>     @@ -3119,6 +3132,8 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>
>      int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>                                             strList *mountpoints,
>     +                                       bool has_timeout,
>     +                                       int64_t timeout,
>                                             Error **errp)
>      {
>          error_setg(errp, QERR_UNSUPPORTED);
>     diff --git a/qga/commands-win32.c b/qga/commands-win32.c
>     index 618d862c00..51fd6dcd58 100644
>     --- a/qga/commands-win32.c
>     +++ b/qga/commands-win32.c
>     @@ -1221,13 +1221,16 @@ GuestFsfreezeStatus
>     qmp_guest_fsfreeze_status(Error **errp)
>       * Freeze local file systems using Volume Shadow-copy Service.
>       * The frozen state is limited for up to 10 seconds by VSS.
>       */
>     -int64_t qmp_guest_fsfreeze_freeze(Error **errp)
>     +int64_t qmp_guest_fsfreeze_freeze(bool has_timeout, int64_t timeout,
>     +                                  Error **errp)
>      {
>          return qmp_guest_fsfreeze_freeze_list(false, NULL, errp);
>      }
>
>      int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
>                                             strList *mountpoints,
>     +                                       bool has_timeout,
>     +                                       int64_t timeout,
>                                             Error **errp)
>      {
>          int i;
>     @@ -1240,8 +1243,11 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool
>     has_mountpoints,
>
>          slog("guest-fsfreeze called");
>
>     +    if (!has_timeout || timeout < 0) {
>     +        timeout = 0;
>     +    }
>          /* cannot risk guest agent blocking itself on a write in this
>     state */
>     -    ga_set_frozen(ga_state);
>     +    ga_set_frozen(ga_state, timeout);
>
>          qga_vss_fsfreeze(&i, true, mountpoints, &local_err);
>          if (local_err) {
>     @@ -1299,6 +1305,12 @@ static void guest_fsfreeze_cleanup(void)
>          vss_deinit(true);
>      }
>
>     +gboolean ga_frozen_timeout_cb(gpointer data)
>     +{
>     +    guest_fsfreeze_cleanup();
>     +    return G_SOURCE_REMOVE;
>     +}
>     +
>      /*
>       * Walk list of mounted file systems in the guest, and discard unused
>       * areas.
>     diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
>     index b4e7c52c61..d8d1bb9505 100644
>     --- a/qga/guest-agent-core.h
>     +++ b/qga/guest-agent-core.h
>     @@ -39,8 +39,9 @@ void ga_enable_logging(GAState *s);
>      void G_GNUC_PRINTF(1, 2) slog(const gchar *fmt, ...);
>      void ga_set_response_delimited(GAState *s);
>      bool ga_is_frozen(GAState *s);
>     -void ga_set_frozen(GAState *s);
>     +void ga_set_frozen(GAState *s, int64_t timeout);
>      void ga_unset_frozen(GAState *s);
>     +gboolean ga_frozen_timeout_cb(gpointer data);
>      const char *ga_fsfreeze_hook(GAState *s);
>      int64_t ga_get_fd_handle(GAState *s, Error **errp);
>      int ga_parse_whence(GuestFileWhence *whence, Error **errp);
>     diff --git a/qga/main.c b/qga/main.c
>     index 8668b9f3d3..6c7c7d68d8 100644
>     --- a/qga/main.c
>     +++ b/qga/main.c
>     @@ -94,6 +94,7 @@ struct GAState {
>              const char *pid_filepath;
>          } deferred_options;
>      #ifdef CONFIG_FSFREEZE
>     +    guint frozen_timeout_id;
>          const char *fsfreeze_hook;
>      #endif
>          gchar *pstate_filepath;
>     @@ -478,7 +479,7 @@ bool ga_is_frozen(GAState *s)
>          return s->frozen;
>      }
>
>     -void ga_set_frozen(GAState *s)
>     +void ga_set_frozen(GAState *s, int64_t timeout)
>      {
>          if (ga_is_frozen(s)) {
>              return;
>     @@ -492,6 +493,15 @@ void ga_set_frozen(GAState *s)
>              g_warning("unable to create %s, fsfreeze may not function
>     properly",
>                        s->state_filepath_isfrozen);
>          }
>     +#ifdef CONFIG_FSFREEZE
>     +    if (timeout) {
>     +        s->frozen_timeout_id = g_timeout_add_seconds(timeout,
>     +  ga_frozen_timeout_cb,
>     +                                                     NULL);
>     +    } else {
>     +        s->frozen_timeout_id = 0;
>     +    }
>     +#endif
>      }
>
>      void ga_unset_frozen(GAState *s)
>     @@ -500,6 +510,13 @@ void ga_unset_frozen(GAState *s)
>              return;
>          }
>
>     +#ifdef CONFIG_FSFREEZE
>     +    /* remove timeout callback */
>     +    if (s->frozen_timeout_id) {
>     +        g_source_remove(s->frozen_timeout_id);
>     +    }
>     +#endif
>     +
>          /* if we delayed creation/opening of pid/log files due to being
>           * in a frozen state at start up, do it now
>           */
>     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
>     index e96d463639..29ad342f0a 100644
>     --- a/qga/qapi-schema.json
>     +++ b/qga/qapi-schema.json
>     @@ -440,6 +440,9 @@
>      # command succeeded, you may call @guest-fsfreeze-thaw later to
>      # unfreeze.
>      #
>     +# @timeout: after this period in seconds filesystems will be thawed
>     +#     (since 8.2)
>     +#
>      # Note: On Windows, the command is implemented with the help of a
>      #     Volume Shadow-copy Service DLL helper.  The frozen state is
>      #     limited for up to 10 seconds by VSS.
>     @@ -452,6 +455,7 @@
>      # Since: 0.15.0
>      ##
>      { 'command': 'guest-fsfreeze-freeze',
>     +  'data':    { '*timeout': 'int' },
>        'returns': 'int' }
>
>      ##
>     @@ -464,13 +468,16 @@
>      #     If omitted, every mounted filesystem is frozen. Invalid mount
>      #     points are ignored.
>      #
>     +# @timeout: after this period in seconds filesystems will be thawed
>     +#     (since 8.2)
>     +#
>      # Returns: Number of file systems currently frozen.  On error, all
>      #     filesystems will be thawed.
>      #
>      # Since: 2.2
>      ##
>      { 'command': 'guest-fsfreeze-freeze-list',
>     -  'data':    { '*mountpoints': ['str'] },
>     +  'data':    { '*mountpoints': ['str'], '*timeout': 'int' },
>        'returns': 'int' }
>
>      ##
>     -- 
>     2.34.1
>

-- 
Best regards,
Alexander Ivanov


