Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01473873C
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 16:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qByxU-0003PS-7d; Wed, 21 Jun 2023 10:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qByxP-0003Oa-3b; Wed, 21 Jun 2023 10:37:15 -0400
Received: from mail-db8eur05on20709.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::709]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1qByxM-0006v8-Ie; Wed, 21 Jun 2023 10:37:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8Sk/zXsITLOnNZ6KPo5YyRa79Jl14l85p1Sovx3zlPZtuQPwVWPLH3upbcPL6vdOyCiw9LjudO6W1BZFPzvg0t1rDguUpnXcg987VO23WTBLBq1q1/xut1vEY8vik7cf8+dnSTmWhhNeERNM+trV/WbWEZW3T9e35k7n3krB2ZE7KdgkyelyQ737CNVdScn6ZMUmpUelnP7xhnKeOL4ypJpbHuktvO/mgr4YFIb5CZ4hFKW0/q3zAFy/FoeOV4hB9gYpsg929yPrW9IEwKOVmZkLSXumKlXlXTfue8R+BiKqozMiInekFcYH8nAoldszs/v1TzQ+KwR8jGu5WPnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzDBHZl1DWycmUltds6kokAHsvxrjyrUoZQggWdtSno=;
 b=NWNz/2zto7XdNztMXEqQePWRrlVxAXPqLMW5u1XECXr4ZSW0mrD/cFMt5DL7cyywTwNgEDegDQwyIGq+L+s4ZKrAji1E4R2BJ59H+5hXYAbT9CwVKVnwoIVl0YICi67TO9VN46eYm+1BFOOXu92j2bzabSpnm+q0kZXiYKmUe4Sqva/ORNb4GGBArawge2D6kKwHvOVDw/PWUs88mCiG7f3wIhdTCxHdXuDx+PJVftupcUmd402UPjMdqFzML2mQ4SjqV5XYnTgWaWXS3GS/L+GROpRxONDJ3i3M2JhyMiJ180w58GeLDwOwbXL581LEyUZmg6ZW2WdAbJy4VDY1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzDBHZl1DWycmUltds6kokAHsvxrjyrUoZQggWdtSno=;
 b=ELIS02c54G4gZR4jTTlvcUieYyekY7vv0N3X7GcK06nAgXuC4x0rfc5CymJgCbIvxZHGjVJOXmU4BzHU60FXuJCGPdCc8c/07co4xmzopONPXvK4YgPyMbMVVM7iXRaISTXHdXTNKdQm45znMYD4P+7tK7h//2iSIqVJMkbBBSadD7uk55e5/JAQvWa4VeQglDI0E3bOzqMbrKYUBGZhGffTav216UpEdJdH0GOQdWZOZlrfNOm06seu8IfSCnmUnpm5b4prSnCK/zdgl9Nf6Iq2UkSGP53OcpGMIbF1sa25Ze5dYEBblsEzP6I5XWch/P1XwdTvyDtelfkuDmH7rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS8PR08MB8062.eurprd08.prod.outlook.com (2603:10a6:20b:54b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 14:37:07 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::1e66:7c11:641a:2c7%4]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 14:37:06 +0000
Message-ID: <1b1911cd-86e8-f349-c05a-0f7592621356@virtuozzo.com>
Date: Wed, 21 Jun 2023 16:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 2/5] parallels: Check if data_end greater than the file
 size
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20230621082010.139195-1-alexander.ivanov@virtuozzo.com>
 <20230621082010.139195-3-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20230621082010.139195-3-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0005.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::17) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS8PR08MB8062:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7c8b34-7831-4b8d-bce1-08db7264fcce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dFLXMcIOi9jtCXmntyeVWp7SDSLVZuXWG1DDmMQ9u7cArR0xJ+oCFdOCFG5N8spgUe6pow7noeqJ1PM2zIJeYcAzxZuUUrK2hvdulTn5ptQLF5NHc6iebduIMcTB17nvwJktytrlQbI3f0IOOZwjnWgXrxB+nO+fmKdTo8kHLbnxg8pu+I1IjGoVs8fE6KsrGnyAzG925Os8B99E/f20wmIwAjkdzZXrXzJVjF1GJC97In6pQUMjK29lOqepJ39BuLZtEWDCLZyIaGMb+HRwCiENJJup6PUSYf3x46QASGTRhul1Aw3GQ6iPYKBbxCikMIv8VaE0/OYeGjWJR2kpJdCvN5ft3ubhVFM6VBd4SXtjGZSfRvI32VFEo2Cuaf6e03EfgJCPo5K2MdePXtUD0+O+wjQ9JXzgROF1YArAMamK0MmB/mu5nodY0d32Inh//xJrQ4tPj7Ivka65mvMKHPQZu3HvWFBUCEeMGiWwBSg/3faMEqV4d8FYMySFqXgyET3w7sg6jNmeNTM67YonVXzbakCtvFfNOXi4lo5gDkhdTBIkm+0bEYsI256VD3rbhBvbW+crF/rr645Kamo9JJTNgO8oq8pQgyZSuGIelUDNTwfFK+WCOPf8E+MsI3qdoH1/Oc51JxnnpmlZEtBrwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39850400004)(366004)(451199021)(41300700001)(66476007)(66946007)(66556008)(4326008)(2616005)(186003)(38100700002)(31696002)(86362001)(26005)(6506007)(6512007)(53546011)(6486002)(83380400001)(478600001)(36756003)(2906002)(5660300002)(31686004)(8936002)(8676002)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUI3aHFYUys1RFVmL0NHZ0VHMVZENXF5aWQ0R2U3bm5BbWovVjZWN1BUdDNn?=
 =?utf-8?B?S01VN0hSdVhEQjN4SjZoN000YVpPTml1SEpHU3NyZWd1SmJUOFNaODBxUXBo?=
 =?utf-8?B?b3dLSnhyMkV0QUdlOEV0Q0FRZlduVmlPMGo2c0xPU2dTY3hCNHA2b2cvSXFn?=
 =?utf-8?B?UnV2d2hNTXVmN2hRU0Z1elZPdE90WWdIcDZZdm04VTFnU1djK003Ly9VZXBy?=
 =?utf-8?B?NC9va2laaDU1c1hjTndla1c3cFZINHJXRU1iRUtqT1BhanRPRFhodU9INGJJ?=
 =?utf-8?B?NUExeWJhMlAvZEdaWDZsaTlwYmJGM2NUN1IwV3V3YU5IZ0dZNVpOYWtlellu?=
 =?utf-8?B?STZPZkxqNENYbEQ4UnhWWU8wdDhCcVZrZCtjRFkydS9XQS9ReWVJWEtNTmtM?=
 =?utf-8?B?K0tvUjc0S2dPNzY4OWdndFhvSWxYaTJCSFIyVHZFamZ0OUZKOFZJQ2prc2I2?=
 =?utf-8?B?Y2tDWVJLWUx5MnFiSWdpTmx4dDE1TFU0SCtIOUdJbEMwZzhJWnlpeEdlcFhm?=
 =?utf-8?B?YlMrd2plbmMvaXNXcUtzenlrcGducUtURWszZ1BBWHE1V3ExbllSQW1MSS9N?=
 =?utf-8?B?RzF6UkZOUEE2TUhOVEhZdk5aY0w3ZytKM29iRk5oVHZSclEzc1Ixd0cwZFAy?=
 =?utf-8?B?VXRscmhzY1d6ZTAvdXN2YXhHQ3JnTnYrSU5JNnVYNklmT2xSRkdmWVRiYmVm?=
 =?utf-8?B?VWJ2MDdsK3lCMFk2R1ZPcVdLeWQ2clo2MlJCWWUyNjYyd0lFTHJBV05MOHRq?=
 =?utf-8?B?MUJOaEJMY3d3RERBeVQ5QnZrd3gxZVBCSWhrREsyQ1VvZkp1WjhoamQvZXRV?=
 =?utf-8?B?SHUzUUF2WG5Xb2lQMGNHQlVHdHZ0c1ZiTDRzSjJ3MkxJQXhoa3BuRGhpM0ln?=
 =?utf-8?B?dG5qZDJvRVh3N2NrUEJUaXI5T1hUR1F0UHlYci9VaENqdEVtaytHTk5yWWs1?=
 =?utf-8?B?Sm1TQ3pFcDE5RVhabThjbVpoL2xGQmNGRVFXdFdKRm9YWVBzSlEzdkFlTldn?=
 =?utf-8?B?YTFFdXZpMUFMbWhPVjNRMkczb3h5UWNNZHFoZjA4VW13Z2Q5VDVObGs1dnh3?=
 =?utf-8?B?akhReWU3N0lIZTl4ZXgycUdpa09kWUhnakFZelZaVlMvR2dJeGRhRUxiMGll?=
 =?utf-8?B?TVNKQ2dSeVBiVTdUR0lGSXlrYVZVKy9BeHNTbnZVT2o0ajFLeTM5WWhJQnNG?=
 =?utf-8?B?eDU5Y3Fnb2pmTWNLSVl5OWV1aHpxN2ZzRTlWbUVnNEpyZzFDYW5FMlRFVVhV?=
 =?utf-8?B?a0E3aUN4T2lXV1lCVjgvMk5DTDU3RWZvSUNBelNKMURpTTBpZHhKTmZDMFQx?=
 =?utf-8?B?cEdHVjQ4WjlGUWVhV3M3MFh6UG9BZjVyeHNYQ1BLQ29EUWJQVHV3Rkt3R0k3?=
 =?utf-8?B?Qno0eEQvRnZvYXRTbXQ2RGdtY2cxNnRHR3A5OFNwS2RHc1RpTDdzMnozT1hD?=
 =?utf-8?B?NGxDbFZFSFpXMzVqMjJYWHdPR1E2eDY0c0VURlZoTEx6WE1xSFZNRVoxeWdy?=
 =?utf-8?B?WHc5Y2FBWkJrK3kwZitzYjJQY2NydytqWktXbGg5NzRkUVY2eGE5MGJSWmNt?=
 =?utf-8?B?NmZITnhBbjNSbEoxaWNFOGNvbVNRY3Z5TmlyZ3ZLSjRkQ0xsbG9UZUlQbTFE?=
 =?utf-8?B?NUtkK1NQMytTOWJmbTZOQVExUDBiWnhIOEI5N1dqeVgvUkErd3lZYTZ5NjFo?=
 =?utf-8?B?ZDhZVXVYWU9PV2dmVkNkeGhUVGwwZnRLaXVmRlRZUjJQTG8xRG5uUHpmUFhv?=
 =?utf-8?B?dDN0RytuTmlIV3pRWWhKMVJVMGRsSmxKNjh1L0FnR0QvV0xJZjdweEp6SnZ0?=
 =?utf-8?B?ZnFxT0dGV1Z4N2hweG12eTMxS25rTVN0UkdjMWFSUTdua1RQZENKYXhvUEJ5?=
 =?utf-8?B?MFU4QjN6WWF0b0V4S0VxYmZzN01PdlNCdkVUSStRTnlHWVk3Q1R0MysvUWdh?=
 =?utf-8?B?Nzl4S3BCMjk1VW03NFVTOUNkUVF4TXFBdjYwbk0rMGtTWWxiUzI1ZGJBR2ZI?=
 =?utf-8?B?S0JGL2ZCNGgzc1B0bVpNY29PdDFYREp3R1M0NElFeWpUT3VoTXpoT2F4MGV6?=
 =?utf-8?B?cEhLUGFxZzUvcndlbnJsUUlHWUVHQ3Jub2NHNEwyUzhvcXJoSzhqN0VHYWR4?=
 =?utf-8?Q?ECq3vKO0g04sHHC+CLQEIzHE5?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7c8b34-7831-4b8d-bce1-08db7264fcce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 14:37:06.8393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81GSI+SaidN34KEe5fNIjgw4GsxGJlGX4wDm5ci77Iadsdjax4ArGiTtpNPM9U0+5aJQE3HmyOGyeIJY3LCvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8062
Received-SPF: pass client-ip=2a01:111:f400:7e1a::709;
 envelope-from=den@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 6/21/23 10:20, Alexander Ivanov wrote:
> Initially data_end is set to the data_off image header field and must not be
> greater than the file size.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 1ec98c722b..4b7eafba1e 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -868,6 +868,11 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>              and actual data. We can't avoid read-modify-write... */
>           s->header_size = size;
>       }
> +    if (s->data_end > file_nb_sectors) {
> +        error_setg(errp, "Invalid image: incorrect data_off field");
> +        ret = -EINVAL;
> +        goto fail;
> +    }
>   
>       ret = bdrv_pread(bs->file, 0, s->header_size, s->header, 0);
>       if (ret < 0) {
for me this seems incorrect. In this case we would not be able to EVER
open such image, even for a check purpose.

This place should have a clause like

             if (!(flags & BDRV_O_CHECK)) {
                 goto fail
             }

This error is not fatal from the check point of view.

Den

