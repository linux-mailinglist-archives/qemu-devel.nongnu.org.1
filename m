Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C47A444B
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9PO-00062G-KJ; Mon, 18 Sep 2023 04:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9PM-00061o-IG; Mon, 18 Sep 2023 04:15:04 -0400
Received: from mail-am6eur05on2072b.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::72b]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qi9PH-000175-7Y; Mon, 18 Sep 2023 04:15:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijkgsvYnF5InlqS7XPu9n228FTI4ZX8/viZtVqdsppabBrGTL+0HV8GgSmYZTSkFDkaLDMMok83JPy6gCfCWo3vjBrgkilM7QvlUywMRcPZjoTVBoi5/uAzTnitPKr+ag21uFUc8rRV/hQtT8KGxOLyuXUDQKDicOI63djY8vpG6+TY+d6DHnAlnoPdzqGwEU0tDKB2K8OltT4CGO+VsSYO8dqxOdIiOBJojW116ENv9dOGal3W87z4NM1XfWM4jvkURthba3B17eGlyJlNQT8dw3xAfGvzYYpo8ig5dInpBwuw9Id+7m7/txo4cZ8dJ8+b06m6utUq2P8666MIYlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHBR2zdErMLQsO19bb1NZNYBUmgXa59kfLVZGgEuY+o=;
 b=cqr+77hG56KguQFSu2VErK5GFo3KuAt5C5yTIayTfmYJGvZMLENWlX4Kk3ZPBCksyyksxsp/BUJW1Gd4O/j11NhyP4jeSDMb2ojWg43F3aMdCrbuDixP+pRZ0X8Pah7WIkF7PbRSJRpRYw1NSOymjGtMaLLYu7tsbMKMlAzjqBMh/Ed2cLGQdvHqqXqK/ISolNYL8OUIbXqSDlPZUCus0VaaclPZHvoMvvCTiJhkWgc0LdO7FQLdPpB72odX7rr7DiRGIyi4tprrer0rBD4Pm18QsI+EonTwzmBop+Pz4IFI9m5yDCVHJAwKmD5qeB2Mqt11cgWMm2VSZWQslttsag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHBR2zdErMLQsO19bb1NZNYBUmgXa59kfLVZGgEuY+o=;
 b=upZ5dZ+bUGkRxkfn8h7I7ydbqj6fm4KniReHsVUdN/kdsaR34njh8lHQs0S4Naq5tmu/QUyvxxUrrMETUJ0sJxJhTfS40v+wdMQISDwj3WiD0IZhlurURLnhIZdoSmOXGkOUdiwwmv21nsg/IhrYvDG26wt/muMugzBzj/eQ1PHjG/gZBjbR67lChKGywTjxqFgYt/+4SH/WA8x+G4ebPVSiX++kc47saJfoYgTfj+cVfs1AZDukRTzZ5IwsvB65b0uKQ8ntOPbObrHx0lWQISrFgUFTb1e4QYe3JSDmD5otj4ZKcpXPLybs8cxF5R+4KWpgrTk02bdj7p2gFY0V9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by AS8PR08MB6136.eurprd08.prod.outlook.com (2603:10a6:20b:292::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 08:14:54 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 08:14:54 +0000
Message-ID: <6e54ed39-bc33-887e-9585-d7fe04a1bbf2@virtuozzo.com>
Date: Mon, 18 Sep 2023 10:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 04/21] parallels: return earler in fail_format branch in
 parallels_open()
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-6-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-6-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::15) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|AS8PR08MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: a2a536f9-cac2-46d4-6932-08dbb81f56ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xr1TvA4awzj4KxyWeQOZ5bZ2SLZAW3kVwyof4W2kTVWjwe2Ji7C9fqNR0xmLFzHERWlehyyee1d8bAIw6WHMVw3MxUugqb/M3n0kRU8XynmBXTrcW7p/PYUNPzCSuOyGKuZAqsi1k5eP61OvwHeIgCzLiwNnfTzv6HuHk+JqQmRFjRJPbW/u59fbtsqlU/8gZUCs4EAk/2pZCR5TS7jD04BBr850PGYxAy/h9USi03OMtWWflnCLpwSKAYFWbWuR129a1pjoNHv5mDiPOpg7tmGgbQ+Re8M05gfzijXx+biPpBqfXxh+kPmf9Sr1b4DplFk+Kk9SY5tk8sjHUlN1t0UqOrQNTWN/xzsS5xXeL9fY9X7/qWuJ+Sh+36aylXhJrN/Wgir/oMVnJgCXAqLXjLnWa6Q4tnzHFz1Al4jXH93psz7AhHBvfUIND7e0s9bWF75LCh53D+XFAF9wZimbIqVIfAd8ozJBBXT/zWne2wutxJqRNOw3gs6lG3/WCIInvtheES9XL+zgFsJ3E78gc7OLWSDIT0Ehpy/fpm7OwdjB9oRG+wjSBpXaC9z03/lxg/7mdG3earYb95imFjc+vhgfr35qQerXqQdZXL/viJh6RND1rlgmEp69qv3eUZXf6YWhui9IyOYodtoplsb6+vEa6q+Dhhto6Fb+PCBOm8LOcuc5oCLr5+/XLCQ5pUGb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(39850400004)(136003)(366004)(451199024)(186009)(1800799009)(6512007)(53546011)(52116002)(66899024)(6486002)(6506007)(6666004)(83380400001)(86362001)(31696002)(38100700002)(36756003)(2616005)(38350700002)(26005)(66556008)(66946007)(66476007)(4744005)(41300700001)(316002)(2906002)(5660300002)(44832011)(4326008)(8676002)(8936002)(31686004)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJVckFENzNBTTdVaE16Wlk0OXpOdTREaHZ4eUU5aC9kM2hIczdSUFdNblpD?=
 =?utf-8?B?UnZHVkVyRjQ5ZjYwdmZRWDRnL1RmcmxvWXJhRmE2M0E3QWpRUnFaSHQrREpS?=
 =?utf-8?B?bndrSWtSaVB0RkZxdmlrbWg2M3JnRDE1dGJ1RTJKK0U4TWQvTDN1OEZTTUxn?=
 =?utf-8?B?dmUydlF3bDdnenNTT2lSZlo1S1ZwWkcwZGRVeS83NVZVS2NtNVFidUVWcFh4?=
 =?utf-8?B?eUFyOEM4RndDVHBxT29wTGFScmZTc3ZMN21mbndHL20vSHU3STdlMktEdy84?=
 =?utf-8?B?T1BxZ0NoK0tESTNNK0F3TjFwYUdGeVQvOHVsdnljS0Z5YVZYWmhPbm1wZkpZ?=
 =?utf-8?B?dXNTTE5oZDFLaUU3eU1WMjdSYnY1OVlkdVNENUE4TEI4Z050Wk81dzVoMzlW?=
 =?utf-8?B?WkxKNFpIMWcxUkZjYmpkdXhkMVg4RXdBV0FnUFZDakFlbkNaUGtpY2NsV1Z3?=
 =?utf-8?B?UVdCRjNSVm5uMytqTTNXQ29Vb2piRmV0VFNYZmo4OFNtQmt6NC9kM0JOTVpD?=
 =?utf-8?B?NU9ibVNQZTdxcUk5dFhsS0ptRmlxZkM5SWk0NDEwVDJqaUdFeHZEcVpLMGda?=
 =?utf-8?B?YWhud29ObGdtdnFHRjBrUWtnWTZWMGVjNzMwYW1KUEhBY0RzbForeXdnaXlh?=
 =?utf-8?B?K0Q5SzJ5REdaTCs4T0hVRGVqZ0hiaWpNZkZZK3dBQ0YxYXd3TW1CdjZoaDNO?=
 =?utf-8?B?U2pyTlQxa2sxb0ZBRFVIY3VRR0MyNzltdG1jUW9xTHR1NEZrQ1hURzUraTVi?=
 =?utf-8?B?WmI3VmlycWRrZmU2T1NUeWgzRXpZVVVrem42MzBFV2w2bnBzWXpRc0Z3ajVo?=
 =?utf-8?B?M2NnY2JBYUtvRm9YQkxRQk45MHVTSDRVRnEyUngwUC9tWjR2aTE1QUFwOElz?=
 =?utf-8?B?ZFc0YStOMityb3B6UmErS3FLZ0hocFlYWVprNEpYQm5NYVl5b2hQVG9HRVRz?=
 =?utf-8?B?eW1INTliSTNoc09XOHp5QlRicmpGeHRNcVYvQ0RzMFNFQ21xQVp5NEFRMG85?=
 =?utf-8?B?b0tFQzNQNHhUaDljbjJMV3NEeUI5SFpWV1o0U2tnSXYrdHZiZDFaV0w0Q2NT?=
 =?utf-8?B?Ty9YUzFscWdHeW0zMk9yQXExaXE4NWNvcHNBYTQxRytYaE9iYW5pNEJ2NUwv?=
 =?utf-8?B?YjI4MXVTcjQzL250Z0QrS2VUL2tNSWRDM1Ezam9xbGlSeWMzdlR6aldEbHN0?=
 =?utf-8?B?ZjFaSS9IaWhFcFdVY3ZRN0hsa0syVnEzMnBZd2hpNFJOdFoxRnFwMkx0N0hE?=
 =?utf-8?B?Q0JxYkdqeWsybml0NFhGR0JEbkpoYS9lc0F1NlBpU2FXYTI0SGh3dHNIOEhL?=
 =?utf-8?B?cmpnaEdtcXpGak1XbGdVUE9SUlF2ZUdWYjJqM2IzUy9FVjlsdytucmE3bzZT?=
 =?utf-8?B?TGkwVGNOMXhGbW1wUEhjK2x6SmQ5RXBqQ1dyaEE0eEUwWDJUYmFtTGFUVFds?=
 =?utf-8?B?eFJOc2VKeFJQTzBvaDR4MXpjWjU5T2l1SHI0MytxU09IUU51TUtNUFgxbVlq?=
 =?utf-8?B?b2pId05RK240ai94R3VYMUp1R0x6eU4rTEZYRG5JLzl4cXNoaHdiZXVoUnp2?=
 =?utf-8?B?WDMyK2tlTHEwTnZGajVPQ0dMcWdNNUpnNEQxWDMyNWd3aFJEb0NhSSsxc0VP?=
 =?utf-8?B?QU9maktlME1lWlFsd0hoWWpVVStkWU5lamUzVzdUQ2VWWVBpeitvRnh3MDJK?=
 =?utf-8?B?YkpROFROQlgxSmFGVU5EOU10MXpseE4wSmRBMjhNY3lZRDNaMUNBT3JZdis4?=
 =?utf-8?B?N3VjbEFMd1JRN1FBUW5JNnNKWHZUVXV5RlNHS2xTc05LYjZ0OHkxVEJqMy9P?=
 =?utf-8?B?RGpVZlFkYTE4NFF6Q3cwaU14UWhuYnllTzhUc0lNWEhQV2NyR3ozQ1d0UjFy?=
 =?utf-8?B?NUY2d3BJVDA4VVVZRHFvWmhjdm5ydk83N3N4WGZuZUx6T2M1Z1pETWgxYjVX?=
 =?utf-8?B?NkJLZ2dkT2N1ekJUUHE5SURwOW9icncvRm8zVjJjTVN3eTdKd3M1MDJKcWtH?=
 =?utf-8?B?bTJaQjcyRXZGU1dMQkdHQk54LzZid1ErK2oyQ1lhdll0RG44MFg2OHh3d2pX?=
 =?utf-8?B?Uy9TcFpDbVBuVWNOa1pVVTk4VUk4NmFDam9PRUZIQi9TdGdzNzBwem5hLzV0?=
 =?utf-8?B?cm9CK0huMHh0cVE0d0ZUSFFlemxRbzd6NWp6cm1hSUwrU0c2SkhNTkxnQ1BV?=
 =?utf-8?Q?E7t03AmJsG4x8tw6hkw/qqo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a536f9-cac2-46d4-6932-08dbb81f56ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 08:14:54.5882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEE9jL/ZqV9XUkPF5uqtopie4wXJCZM1/IWYD09M4HAWeHOFl801TxfKdeICttVwKZMmSju6lOBuUv0t3FyTkhWGSbgSVKuwtPrKN+3XYpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6136
Received-SPF: pass client-ip=2a01:111:f400:7e1b::72b;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

This is not the case with this patch, but it seems that the 5 first 
"goto fail;" could be
replaced by returns. The first allocation, freeing at the "fail" label, 
is at 1127 line.
The next error handling and all the previous ones can make return 
instead goto fail.

On 9/15/23 20:41, Denis V. Lunev wrote:
> We do not need to perform any deallocation/cleanup if wrong format is
> detected.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 1d5409f2ba..0f127427bf 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -1226,7 +1226,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>   
>   fail_format:
>       error_setg(errp, "Image not in Parallels format");
> -    ret = -EINVAL;
> +    return -EINVAL;
> +
>   fail:
>       /*
>        * "s" object was allocated by g_malloc0 so we can safely

-- 
Best regards,
Alexander Ivanov


