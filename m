Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AB075F7FB
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:13:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvKL-00009o-Uv; Mon, 24 Jul 2023 09:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qNvJg-0008O0-F3; Mon, 24 Jul 2023 09:09:36 -0400
Received: from mail-am6eur05on2071e.outbound.protection.outlook.com
 ([2a01:111:f400:7e1b::71e]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qNvJE-00034f-Sa; Mon, 24 Jul 2023 09:09:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DalGw3oeXJI9DGQc2WisdE0s/JhFQ8h8GoZ2gvcEafTXul9dvZoenOZ+ss3bQw8wfECJVmbAcOw5XrPP9QVQbtdl5dGxHiCPNDnZZkaaki2S2fkYWNEF0eFQgdamTmKMTGxkSuC1n6hiSSzAonpCIBbaxV9aZmiWjtACSc7OCIBmtcJHOW6jLxFtBgWcxFyM3/IBRiHrQmW8UQlTnx//JBRtpMMA4ix7eugXq19SOUuKBimw5VTwJVzsPJZq37PS/uNEXJaYQ1Vwmn1IA+PYD7awZaYBfZ9YPN2ZMPEzZzSPTH8TN3bBRnggxVe8wy2h8/A0qZfgZ18foW7HKAJG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoyXh7jxX+PFivwc9ud1JwwOFrw8x8fUfqTDOG2Z6Lc=;
 b=hjRkqeawiGhHpn12YVWJKeL96Z5yTR3KlYd3oQohwQhiIy5eOZTpJRf3RPWUj/8gkFncHG3lZ9NZSq0XpUIqjZvzx0Te32vTKTYS/8XL9q17go2+bJEvMKI8ECd8EHVf/PEE18YpMcTzVgNBoSpg6FBz2dhrMgJ0yFMgFfLjREIpStRDfwIrKlW1qGqln/2qVEFowwahuJ97eiHyLKeRLlsUgk0XCYyMWpcZ5iKRU4ONOiwD+x9JH/d3mQFugJR8y71GtlxVqV4dC7hzKs3XK1Ns5gPdX0PyfMk6U1DkWGdenJS/Ug+I4Msr/hN8JV5TmIH1ROxIRE78rVNQ4b95ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoyXh7jxX+PFivwc9ud1JwwOFrw8x8fUfqTDOG2Z6Lc=;
 b=rwDlldAczrnoqbaMUdjygETgD4+eaJUv5wF7KsD/aT7vr1WRfyDF/7lL9il+WGmWjutQFIaEJvzCi3Mzl0TX40y0f8Vy3F1MUc/vRJmsWxOsFY83Vh6qdsww2X6eVPzqdgBUGe3udynxknCkuqTr/M0yA2OmJreVs/SbvyVI+DYio7ytY0tSbhGF9ZibRxzc5msNz4ajPtNJCt7sUtF0SnjPHXMR/rMWm53ldQVXJ3LmSO+Q+JdZLwCuqj68SM9I8Z+QWXsE96cdoHtAHPohuus8/UvC2Gm5jldipE7XIcEUw6uhtq73X5rBdwRaHM8jdmhRgHnJF7PnoPZgKyqRUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PR3PR08MB5660.eurprd08.prod.outlook.com (2603:10a6:102:8d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 13:09:01 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4a49:5a92:afb6:c681%4]) with mapi id 15.20.6609.025; Mon, 24 Jul 2023
 13:09:01 +0000
Message-ID: <8c0bc7da-175d-a367-3d7d-32f570953e7c@virtuozzo.com>
Date: Mon, 24 Jul 2023 16:10:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] qemu-img: map: implement support for compressed
 clusters
Content-Language: en-US
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 fam@euphon.net, eblake@redhat.com, vsementsov@yandex-team.ru,
 den@virtuozzo.com
References: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230706163047.128999-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PR3PR08MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: f49009a7-a663-433b-b666-08db8c472604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JlSXdJ7cb1/8p/utPkvfupyuLl6WcCOYye06+8KOxjdr8BczaN756MAo1wpaz40HSrGZjTDU1MUfA/xGHoXjap3DodDM9CSNVaWAnPwSOO54RMLKBNcjcYY6jsvWqtImYez+TJsL9NalJUDUnaE9xbxfci+ce4LBJGAcJcxdoB3+eJw7cX7kK2IRwQpSHRxm3YZRbBoFqCC/WvFfErdejyC4+s1Ld3BxMLcW17hhzuGIC5lM+A8oz+nDe5M/ygxIvq5eMt5caCYK8zg/C7gdiEY4+LM60BHZbzebV9EyAFJ3wul6gFeaaMz4RJQwNJIrs7c5sz6pzrChH9XmEjG2LuIiwZG3kklHbn/lC0DQ2x2Ukbifpw9wdkg194DjFjyoBjIFnyudGvnkEeBu+7FKp18Xdk9tTg0o8Xe93biJ7dOGCve/fYv8ii8cCGQ4Do3qnmjW3JmwW4ajFEBVK5MeNkyrGqgDDcf5bbf01qf/MMbL9hVlI+xFonq+VDQl/pKV7BzNQF4yCcdKTjm+kR2eiCZZy7P7LB1gts0FQQ+pgn3KxactnZE/mUIa0ua1/3CXSt6MMPIsPZjA1wkD346Z9bOix+VLFU1QG0LHvYyThZzF1dTcpYS1nEw8iCLrfgrZUMaZCFVshu0iQ9w5ckghdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(39850400004)(396003)(451199021)(38100700002)(36756003)(53546011)(2616005)(107886003)(83380400001)(8676002)(8936002)(5660300002)(44832011)(478600001)(6916009)(4326008)(66556008)(66476007)(316002)(66946007)(41300700001)(26005)(186003)(6506007)(966005)(6512007)(6486002)(6666004)(4744005)(2906002)(31696002)(31686004)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZXVnpuVzl4Z1gzTFBLMGVlYkNXVVFyS0hYVFJxcEp2NUVGWk1xMllMSEx0?=
 =?utf-8?B?MEthNUFTUUtlaTl4YkZVVFZ2YXZSdnRYcDJTbU5id2xmNTFWTmdCMmRxU3J1?=
 =?utf-8?B?VmpFVlFaSThXTnFQUXpYZS9nYkRyUU5abWlBU3QvSlZzU2xpSnVyVE1PYmFX?=
 =?utf-8?B?SHdURmYxL2dkT1d4eVJhQ3laMjVsNjNxRHIvMFVxeVYybXV6QzJMNW1DNHlQ?=
 =?utf-8?B?QUxCM0hPRzB6WFdrNGNqZHJyRzlvR3VOaUk3RlNpaXl5WHZxR2o2VzBQSSti?=
 =?utf-8?B?TzhmZWxwaDRQTjBML2dDMDJ3eXBnejRSeVIzR1NrY0NnNXhrUlhZQXlwZXhD?=
 =?utf-8?B?S2lwYlZ2NWFoaFVraW1xZ3lLbDNKUS9kZGh4T0VMSjZySU9DTGx3dHMyUW12?=
 =?utf-8?B?d1VBSk5HNENqdkEwR2FZbEZsMVk0Sk5JTzNSQlJmc1BHdStsbTFhTlBFQlVY?=
 =?utf-8?B?S2hjY2VPQ2FkTmFkN1ZNaGNGWHBjWDB3ZnhCbXI2NVVyeU1VVnovNGd0ZDlz?=
 =?utf-8?B?Q3Z6dHhKRC9BMVZLOVB0UHlhTHpDMndTL0pGZUJ5Njd5OGEwb2RXazhyRFFq?=
 =?utf-8?B?QVc5QnAwVEhmZU1yeE1jUVZaUUdFdGNSWmRHTy9pRTdMUERUMkM2S3F6MGd3?=
 =?utf-8?B?cmRzdTFiM1BQSzllUnN3MmgydHF4OFFWLzZ6eFJNZ2FibUl0T1lINWh6VVhl?=
 =?utf-8?B?OGQ0QlNNdmFhY2RPWWd3VFNrRlNJRUFLWCtBUjZhRVJnV3RXdmJ2Ykc2MjAw?=
 =?utf-8?B?c2t1MmxhVDU1cVdXbUZiTEJBVU5lQnJFNU1uelVtYUovTUlXQVE5MDg0M2k1?=
 =?utf-8?B?ZzZDVTdwR3JXUWltNXZEdzRYQUM4V0lTNGZ6RFFydFBRQVBTZ2VhUU01YXhW?=
 =?utf-8?B?N1kvek1JNDZEaUQ3TmJRNHROd3dOTFc4alhDdGJ4UmlPMGYvS2t1d1pGSVgr?=
 =?utf-8?B?Y09kRWFDenJXWjJFcnJ0ZURUNmNvZzhvbXpoOHFLWUJUOUc3QS9XYUtzL2wx?=
 =?utf-8?B?T1ZZNndwa3JQS1dhRVk2cnhYV21BMEpRVkE5MTUwRFR0bVc2YTVlZElZeStM?=
 =?utf-8?B?aXZTVFdwalBKeTlkRGdLU0lITTRrR0p4MUp0Z2dMcmVvZld4RHBPZFdpbm1k?=
 =?utf-8?B?bTBwQ0ROSyt3eUVod0hXYUVTNUhkd1R6c05ETEFRS21BNW5VSFRzQ1ErYVp4?=
 =?utf-8?B?eUdnZ2pLZWFpd2xyWDNIRFdic1FwcmJ3SXp1L2lzMFlGL3VHVlRQSUtyaUNE?=
 =?utf-8?B?WTNoLzMxUm1VcXQyc3VNQzJ3UTB2UEI0TGNqL0M1dFRDam5zY2t4b0FUbFFq?=
 =?utf-8?B?aG1OejlubXJ5cVVnbnplYTRabkJZNGJDa2szV1RqMSt6VENFelVJY0NlSVJ4?=
 =?utf-8?B?Q0U2enE5NGRHNmZMMnJwM05tdUxDR1M0emdqazFsYWlsUGRrTWNxbXdSakNY?=
 =?utf-8?B?TjJXYzRaNlFLT0p0d1cxaDlqV1ZtUXNrQ0ZpazNjeVlNNEhqTGNoSFJXWWU4?=
 =?utf-8?B?OUFiN0N5dVQrNVNsZW1tSk9ubFNRV1JrZTdXUzBvc0dGcjdwMndsKzhsSjd0?=
 =?utf-8?B?VHVKRFdQUWhkWlo3akY4b1VWTkNvbUQwVUJHSmdWYjh5L0hCUVIzVVhRTHk5?=
 =?utf-8?B?MU1kakQ5dVlicjVTZ2cwbldIUVRSYzVIb2pRTkluMVBnSVZKaTJPOU5yODRX?=
 =?utf-8?B?VVZPZ2ZNMktqTVpwbWZsQzFCT0tBcjBkOXh3YVRuaXVPK29hT1NGNnhtRWMx?=
 =?utf-8?B?RE13QUhJOWp4SUhPOWZsRHEzdnNIczlhSGVrK0VZUVpzMDl3TzJZeVkvYUFy?=
 =?utf-8?B?NERuU1p6Wk1KSjRtUjk5NjZHMk1HczROSnEwbk1CMlJZWGVCZSs3bjVodTNz?=
 =?utf-8?B?eWFsS2s1bERlaTZ2R1RPVnBZZGRaS1pOd3JzM3I4anhUSmoySlI4OFpEcHUr?=
 =?utf-8?B?ZUNDL0Zod0ZoTGdaNTROaVRQN1U5cjNaK0F2cVFiSUZUZGNZVHJLS1NJdEtj?=
 =?utf-8?B?UkwxWks4NHJIcUlZczdja1pSZ1VGMmhEdVhOM2h0R0Y4QjBON1JzcXRmY2Vq?=
 =?utf-8?B?RHVyTnY1d3FjWXRQLzhDZVpWMHFkcXF3WEZ4Q1M2QUdERG95ZS9tV05YdkFR?=
 =?utf-8?B?STQwS2pHVkpGTHNPcnVIQTFCSkxnZHBYcEZtZEd5Um93U0wwclFJZnQzaWhO?=
 =?utf-8?Q?WjsXk+AKYroGFo9Ihszvt9g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49009a7-a663-433b-b666-08db8c472604
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 13:09:01.3386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Afmb0WDZPBLpcahBTarC+IvH73ysrU/u1YKaTxEBOK9C84vyOgtCKrWVVqTaPpA67R0DcAt2/sP84g8DybQVG0MTfo1PlObC1fmPXWTKvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5660
Received-SPF: pass client-ip=2a01:111:f400:7e1b::71e;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
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

On 7/6/23 19:30, Andrey Drobyshev wrote:
> v1 --> v2:
>   * Add vmdk format to the 1st commit.  Tweak commit message accordingly;
>   * Make "compressed" field in MapEntry optional.
> 
> v1: https://lists.nongnu.org/archive/html/qemu-block/2023-06/msg00184.html
> 
> Andrey Drobyshev (3):
>   block: add BDRV_BLOCK_COMPRESSED flag for bdrv_block_status()
>   qemu-img: map: report compressed data blocks
>   qemu-iotests: update expected tests output to contain "compressed"
>     field
> 
>  block/qcow.c                                  |   5 +-
>  block/qcow2.c                                 |   3 +
>  block/vmdk.c                                  |   2 +
>  include/block/block-common.h                  |   3 +
>  qapi/block-core.json                          |   7 +-
>  qemu-img.c                                    |  16 +-
>  tests/qemu-iotests/122.out                    |  84 ++++----
>  tests/qemu-iotests/154.out                    | 194 +++++++++---------
>  tests/qemu-iotests/179.out                    | 178 ++++++++--------
>  tests/qemu-iotests/244.out                    |  24 +--
>  tests/qemu-iotests/252.out                    |  10 +-
>  tests/qemu-iotests/274.out                    |  48 ++---
>  .../tests/nbd-qemu-allocation.out             |   6 +-
>  13 files changed, 302 insertions(+), 278 deletions(-)
> 

Ping

