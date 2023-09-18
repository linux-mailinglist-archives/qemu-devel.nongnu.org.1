Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B897A4593
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 11:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiAI9-0007wC-5Q; Mon, 18 Sep 2023 05:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiAI5-0007hd-8l; Mon, 18 Sep 2023 05:11:37 -0400
Received: from mail-dbaeur03on2071e.outbound.protection.outlook.com
 ([2a01:111:f400:fe1a::71e]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qiAI2-00037N-4y; Mon, 18 Sep 2023 05:11:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz/jaHp4UNw1vkA0mBbqh63Kgx6+B1PcBpDJzZ5gmKeYNX24ws2K8myetue71J8229euT2F0/f/CDLRTBNqJkcg5etH3XzwG6kPA7b9Y+skxXdnbShn/JaJLqgq11KMsqZTIWxtGUx/wymG1RN7rpU8cLncdmX0tmIJKLwhAYoPYlY5Azvhz+68hd7l/Ed6HhQF2FVN++yJ4gX517yFKG11c2fT5szellvgg/kUPE3dbI5Kk8V98im7amvhjIXenmgDaN/eVb3I3745HEMC77pe9G1fQY6jsUH+qYQN7PV68HgUIsR0RSoVmrPS5vGPSWouONhWp4L1rVbhcdz/0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzgYlC5xNQkVkGYPny+0Pup2telp0wKeOMW9hgL5eiI=;
 b=eBVdxRDcJKcFTEZWmGgjOnQWH/DRhg6zidYhWN9CIob/u/dz2zLkSryPa1Gv4wFMeq2AWJ4yn/lXa8K3NbasRtVgsUUrd09YhVXFgPmlbu8c+xMEmY6ApT5xkkaghuBWIEhadj+ga3jnY3MPZocl6+iNj2XeGQpRm1cXIwk/oT5DbxHexY9C8SNy576IRH6oC9JNZmkuQVdHkpj1MXy/1Tu35ejytD6YUpCuNQQVBd9UKgUqw/ntLqazs9EQok3CO3Zyb+uGJv2KBPagj5lSKqeAJi6P2BDEGrLVtv1VvEyH1tWZUhkF7M7z8YQnLu0qQyzeA0o1EfLbMq37kFTXVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzgYlC5xNQkVkGYPny+0Pup2telp0wKeOMW9hgL5eiI=;
 b=OECje8xjopBHdltG4Pe+x/Y+ela8JNyL5R+zZY30uoz7dALqBPIlD+bIhQqNi0mfeiW/OF4plMCXzP/F3hxcIrrZHXw50fFWju9e+enunJ4TBIUgkTXgNJ46B/2dtXW0f0YNZKZxUkakhQdOJBdeRJTwGqaRan3GomL049FFvJ7JseusdZjL3NYoGwkpUBzKZvuq+LXMy4P73EhMIW96IRY/zyhZGsBnuDTOkvCuMAfPrydLyVfwq8UZ5Kej/Wn+l7tl2DcVQMXcjTrS53gRSJ6H/3AzLEe2GPnB8egDHsxQPvSjrGAZ6MxN8eES8jGrGJz0k1BC/NsoIp7T+td75w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com (2603:10a6:20b:402::11)
 by GV2PR08MB9159.eurprd08.prod.outlook.com (2603:10a6:150:db::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 09:11:27 +0000
Received: from AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b]) by AS8PR08MB7095.eurprd08.prod.outlook.com
 ([fe80::182f:4e2b:f999:1d9b%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 09:11:27 +0000
Message-ID: <9b2ba342-b2ac-c30e-464c-fa603a95c38b@virtuozzo.com>
Date: Mon, 18 Sep 2023 11:11:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 09/21] parallels: fix broken parallels_check_data_off()
Content-Language: en-US
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, mike.maslenkin@gmail.com
References: <20230915184130.403366-1-den@openvz.org>
 <20230915184130.403366-11-den@openvz.org>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20230915184130.403366-11-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:803:64::39) To AS8PR08MB7095.eurprd08.prod.outlook.com
 (2603:10a6:20b:402::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR08MB7095:EE_|GV2PR08MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: 796e2140-6205-4b06-5467-08dbb8273d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIOkGWlb7RcC3zmNlskSngtfDgGFcnr2RqEEsu+a3NZF55P0xceM+mvW19uGFMsukioXqjgQ/LHuTErKoJL/9N16jv+5R/91hdwB7qCEqUyMdgvzxSmm1T82e0aBqo2Vr17snVWvWDlj8wOmrgmib/I/YZ0cO5D+u6qE5ipkMwomn4qvcQjaN97XFk0y+a9MGcpJhfFeLdhiSCxtfkuW4RkVsx0yX+LQi2vPquZFOUQ1TfKZXGkjSL+FggiS4RBx0t4PxwOLU+72SE8BT0oVoEQf8madFJ30AKvMPGUPYp1cV6nafD9j3UjycCuFZ+XJDegwh2J75Od+cE9H/lyvbzTnUQ/iKIFEDweunlYgmFHufGRYEA2PHqGPxaH0d3mhDAUQxmw+I7o4BPlIK46sR+EQ/ZfMna9GltX+4AA3Ay9sZIc55cINaMCUz66gPZP+bzgMtz5zoSsSDAKf9aTIE+MR/FfJcYXscmx3pCMufOGxz5Gku2Hn8IvltWUmUc2Psf58FFrZQPn/F5UtD8WetkE4Oj77LK08R7qeu3EbJ4fw8yVuJQu6hqccEl0Oa1XWonlEdqiY0Vr7NxXzwKxIG2pyEAKBIpspEwZQrHxwb1/JNwTZ0i2S6TEZIqg0qFuj+Bh0aSBDlRoiQfJk/lO428kjmpfzZyqzAxVrY/D/B/h1Halg/IVQuUzKK4nd3vzN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR08MB7095.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(39850400004)(136003)(376002)(1800799009)(186009)(451199024)(66476007)(478600001)(316002)(66946007)(26005)(53546011)(6486002)(2616005)(6512007)(66556008)(6506007)(6666004)(52116002)(41300700001)(8936002)(8676002)(44832011)(5660300002)(4326008)(4744005)(38100700002)(38350700002)(2906002)(86362001)(31696002)(83380400001)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhLNW9mY2ZoM0JLZWhwK1ZOUlp0Vi9qSzQzNW1rdGo0NDFobXF2Z0Zia0JX?=
 =?utf-8?B?a0w0cndLdlE0VnQraXRHekNmMEZOV0tTMm0wZjdoZkh5ZWNmSEFDRUF0VzZF?=
 =?utf-8?B?a2FIeUFmaHBwRElKZnpQeDJlNUdoTmNpU1JESGpsOWFKSFlibDgvbnI4dnp6?=
 =?utf-8?B?d2RWMXErQUxsb3RrZHh6RnppYWFFZ3k0VEt2TGNJcVdZc1FOYVNicFBlaElG?=
 =?utf-8?B?K0ZVWlVHNmJOZEtXazY1T0gyTzVxbk90bWIvdStydkk1TUw5bXhCa3RGaHE0?=
 =?utf-8?B?QzhFR1J6YmhEZ3kwa1RycEVkem5wNGhVNmx3bG53ckJIQnd5UzhTcWxwditD?=
 =?utf-8?B?QkpUZGdxUzl0eHNCYkVZTE5LZ2RST3V6NXo0QUVzclFpUUQwbjUxMTFTRW5l?=
 =?utf-8?B?KzgxUGZ6YmZvT2dtUGM5S2tiRHdIYzZlVmF0dmZEMGNVK0NJK0x2NVM5R3Zo?=
 =?utf-8?B?aHg0YjNPVTdTMFp3N2lUNEVwQ3FnUmp6WGpacUNuUmEwdUpaeWt3SVplS0Qv?=
 =?utf-8?B?UmliMUVTR3ZaWkxXYTJPQ002akIxYjY2MmI2VUdmNkNzWWNRdEZmaW4rbEZw?=
 =?utf-8?B?RHU0Z3hVbDEycWRtWmhoSHkwci9wRnFPQVFQS083WEJBdXJlVm9Bb2plb0Yw?=
 =?utf-8?B?Vi9OcjYzMXA1Q1VTT3hEaTNYeVFGTXFmZklaOE82ZUQvK0QyUGMyUTZOenJ6?=
 =?utf-8?B?dE5XU2lXSkxJb0FKL3l1aUNOSDI0TXEraW1HdExQaDR1MTF6eDlqRzFiU3ow?=
 =?utf-8?B?Tm1Qb2dWbHo5VHhxOXNCQ0lSSjBjM2hHMGRKSDE2UnNUSlZ0RkNsNDVUNnlS?=
 =?utf-8?B?UzRxZXAxcDZZWkhMK0xrcmY3OXlneCtDR29BazhFZzdZbVVwbmNxTHFZUFAw?=
 =?utf-8?B?SG9OYkJpMFJQZ25wbWloY2hRWk16OFcyOXFxTFh1NTV1dXo0ZCt5aHJPVmVB?=
 =?utf-8?B?OXdYelp4MFZSUHc0WHlvZGF3a0puSEMzTC9lMlVJYUx6cE1SZDdRbnR2OVRO?=
 =?utf-8?B?TlplT3V3OUo5SDRTdHFhb014R3B4ZDNyTlV1NWdUNFRqd3k5R2hpRzlHUDNk?=
 =?utf-8?B?ak5IOUcvOU8vNi9rVGNHV2liQUFjbFAxc2k0MlV2bmtvaTVzeFoxNm9pc3JD?=
 =?utf-8?B?THpxRUhJamNNdXlFVFBFVmNISlB6V1EvWk8zSUZpdW4vejhoby8rUUlSd3ds?=
 =?utf-8?B?b1Z4c1kwWDRaT2ZvSEZuNG96RzVoQlpuQ2RxdldYSURxQlYzL2prb0I5Mndi?=
 =?utf-8?B?MjdKajVoTFc4ZGx6eFFTbXl2MWFWaG9tM2tjcmhTK1BGVVV3WkVCRmVhbW1t?=
 =?utf-8?B?aFRQVGxyMmhIYmtrcVNubW1BSXJjZUtjeW5LelJjNzRrd0w0d0g5cFM1eVQ1?=
 =?utf-8?B?clk0dGtTcUdtM25qQ295VjNzaHNsRmRLUzBwVnVmR1VBYWNaWDk5bFFHWk8x?=
 =?utf-8?B?bExtWW5XaWVEakJldXdPeHd2MXdwZGNWT2xQYjRYZEt4VmRXS2p5eC9oUGRJ?=
 =?utf-8?B?S1ViS3FVYkVEbW5YUkFPZkxWQlZwREVnb29OazhRWUoxeXNuU2Zya0JtTkww?=
 =?utf-8?B?cFdlWVdGY3JtUlp4TUZGa21wK1MvQk4ycDAvVjFhUUFyVnhVbjdwL1NUU2xv?=
 =?utf-8?B?VURHRWhCSUJuak80VEdPc1BqWlhBa2pRVk53eGJnczJHWGtrSDRzbGxFeWd1?=
 =?utf-8?B?SjAzUlZ5dFpKU1Y0R3Z2UVJFVGVOMTNWUlBoVW5FbXhiSWQvTGhQMUFMRWtU?=
 =?utf-8?B?Q012aXJTampzMDV6VGpDeFRqRHhGSjU1NlNMbC9BK3JMU3JqaGN6K2FDQWl3?=
 =?utf-8?B?R05BbWUzaHdrRGxVVmUrRlpTZDk1aVUya1F0czhMVG9QNHdFVlk1UlpiTytu?=
 =?utf-8?B?SjdPNFNOemswdHNUZWpjVVIrbU91bmVQZXpsRDgwWm9hVDMxdW1iS3dZMG5Q?=
 =?utf-8?B?Ky8zN2xBaG5Kak5qQ21CbFhQTUc2TlhVK3B6bXRVNzlidEtjTGlrb1RZR2VK?=
 =?utf-8?B?bHNNYXhQeTBrSDBaa3pzZ2EwRjJGVmdncWNCQVpPelRwUUFLNitvRm5JYXRI?=
 =?utf-8?B?bGRYVzN6YUhnV0x3cjF6U1gvbXBSM1FVbGFoNlY5MEFXeit3WjdONXdQYzdk?=
 =?utf-8?B?Z1kwSTJCRytXWVkyRzA3Z3lIaXdRSUN1aXJmczNyT1lxSWVJTXVTTEJvZ3Mw?=
 =?utf-8?Q?n+4SlECKUgF9ZOJhuGQ1hiA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 796e2140-6205-4b06-5467-08dbb8273d09
X-MS-Exchange-CrossTenant-AuthSource: AS8PR08MB7095.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 09:11:27.1272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmgjazDJ9/iBLWfQLwLYwIAM3ZkZn7cQcGk6mVcV8cp9AME0ovBj0m8skbk2yzIF2zPQ0RxONUSO71aCGh1SwclbTlgnA9D5dWQcB8JC0Cg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9159
Received-SPF: pass client-ip=2a01:111:f400:fe1a::71e;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/15/23 20:41, Denis V. Lunev wrote:
> Once we have repaired data_off field in the header we should update
> s->data_start which is calculated on the base of it.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>   block/parallels.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 60ad41b49b..bdc4dd081b 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -531,6 +531,7 @@ parallels_check_data_off(BlockDriverState *bs, BdrvCheckResult *res,
>       res->corruptions++;
>       if (fix & BDRV_FIX_ERRORS) {
>           s->header->data_off = cpu_to_le32(data_off);
> +        s->data_start = data_off;
>           res->corruptions_fixed++;
>       }
>   

Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

