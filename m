Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA0F74B017
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgu-000287-IJ; Fri, 07 Jul 2023 07:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHjgr-000251-1A; Fri, 07 Jul 2023 07:31:57 -0400
Received: from mail-db3eur04on0719.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::719]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qHjgo-0006ZM-Pr; Fri, 07 Jul 2023 07:31:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3m4h8d266OHNDlonSy9Ftl7CAek6sAnpZ7OFyL026Dxk3KMRYkCd5flZlHyHY2yeYBarbrADTDLt20GqrcyFrL4tiORFs7Hw/8ZD/Qm5zKBEykG7sQMKaK7gGjWRFNy6WO1ESk3m54s1R4dFMDhd0aIN6O8v733T8igEO1PShV4g90rSX8pOIorPqTYi02bcWeP0Jr9csBMY//FNNKbyJaljQsCVlrRG31zCZ0qOEVkis///L61ZoWO3QrSTKfZa1JxRs+yJtnNhox0ktZVPU7T5ZvNfdu6orM2BMVH5drupoPx61vAPM4rLL0a1acKkhVuc1D3kJSxsA9molB32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2A781UCuanO1PYHMPVf755fY2PmRLs8YYXDjwvqbA2Y=;
 b=lQeDd1+kVnGblRoywiOjhOCwVXXNh5J0w/avnRfsbw5faPLzi51o0jAmb1I399tZzqjU5AgK6L7jbbbIT37p+qUkuVUCEh7LMSdtttInX2YdEZxlSrhsFhh+jHYn/AbmCebqvz6IKLP/hz1ZBc3caxAAx9VIuubtaQM8mO9meGKkgUF8hylvIKkOwpAI25vZ7hGFfSPoufjNf8mzo/KDyRJgAgcIe3ak4pBJYtS1bECeARk+Y6w6Ua/OISaHhnSo2bIEvLtfZqs7xnij5z9LHZ9xYtYaSZ1g4FhjK0O2soX7+wsn+arvMrar/DlUkfqnKCG17RSJACsFBKDc8iuKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2A781UCuanO1PYHMPVf755fY2PmRLs8YYXDjwvqbA2Y=;
 b=lPVa8awJ7NMON4ang07bcCafoghqcus6XioHH5P3rk04fbV4wlCFf6j/v2EHyiKf/pDr15kX1meZZgWEHEeap5rfHQQqHbK2vCFmWYO30LSQajpCv6XF071s9mxAVVt4QiRwRWiTUYbbPoZnwN1HpAmldc8PlxMVGPHeB930JZEuR7UgFVAtrUDlBZU+6CYsWmbGmFg8Y3rQmSdokoq9+uJanLt2sn+S7R2CH2Yx4nOQgv/iRGs+xqa4vPqLbPGcjS/+DLJJUVpo+/K8aJawlv307KyayYFip1mKyAyYOCz4bBxC0txw9DgQ0RNSQqJX6ii7UNIM9lqpNyQ6livHIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by PAWPR08MB9966.eurprd08.prod.outlook.com (2603:10a6:102:35e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 11:31:49 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::c9c4:b136:a31a:bc35%4]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 11:31:49 +0000
Message-ID: <a55a6ee2-0229-cf83-013b-d9bb5fb855ba@virtuozzo.com>
Date: Fri, 7 Jul 2023 14:33:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/3] block: align CoR requests to subclusters
Content-Language: en-US
To: qemu-block@nongnu.org, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 vsementsov@yandex-team.ru, eblake@redhat.com, den@virtuozzo.com
References: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20230626160834.696680-1-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::19) To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|PAWPR08MB9966:EE_
X-MS-Office365-Filtering-Correlation-Id: fb00af51-3cd5-48a5-dd51-08db7eddc11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WgMozGCUrVu5ei09MjqmRX0QTVjlYxenfDZK1yWB2lEL6euipQJYiqiOrju8mQ3IGOOy28N62nvLrdXpSa676F9nCqdKH82jFiYS83lizA7MdPCGuJvv/JjJh4trIPl9dXL/dNLyssCg5nASh5Wqa7JObPKEyqf48vXBOyIsLpakBRgybCxX0gkgAovRNr3YOJRbxWReXTXjSOs1omNfNIlpedW9JesOsj8GoS8uoW0uk73GttR34abmJHSPP6fUgdEfjDhbo3pqQ56T0zTVlMYDSzZrP9aumquDgTV3hyPnuM8c4jn/t+5hAZV63ySrDnQWEAIL8WK81Z1+7f5oKaLflrYmqpFjhhFkDOjsZ4yjvTR82avQzrUbaQq2bd09u+Auw7UtJAxdvV8HHS8A2rM4MTGWqTir6f+qBYTPzlS7kDG8w7egkqM3UJNqSlpiKM8i+V++8FMBDzI19AmlJ/tt/3f/wtZiAcd5m8GzcQSuLqY9o2hbGtxLPcsIXc5UbyvfuDhjKVZE8hSJpNFHsoZOL/uu9jcKnxucQqN+fAZyo9OYKlhndWY2rZgwsL7y9lcFI6XCYHN8qPghnbHVVUTHnNmFol5Qrepc6Xhrout/4r795UL3Xogi6vWGULTsbFRVK51HVsliviNZv4zRIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39850400004)(346002)(376002)(366004)(396003)(451199021)(38100700002)(36756003)(31696002)(86362001)(6512007)(6666004)(6486002)(107886003)(186003)(6506007)(53546011)(26005)(8936002)(8676002)(316002)(44832011)(5660300002)(31686004)(66946007)(66476007)(41300700001)(4326008)(2906002)(66556008)(478600001)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDU2MXB5OHBINldxREJBRW02d1N1UlZ5dE9oQ0J4NDN1d2hqMDNDeVhBM0tL?=
 =?utf-8?B?bnJ5SGZtTEVzV0trOTRQUU1zQUJxSnRzaitTOUlCekszd2l4Wk5tc1ZvTTBR?=
 =?utf-8?B?RzQyS2pzMVZVUUhKdjdaQnYyZkgxeTYxcEZuUEEvOG4vd0VPS01aa1p0SUc0?=
 =?utf-8?B?TUFDK200WkJOcms3STNrYkFqSGZuMmJJa0RkMFRYalp3WWdiZlJFTklORlBZ?=
 =?utf-8?B?NndmOUU3UFJKNlMyTldaSjFIbGlQNGh1OXVucG5QVXhEN0I3amFDclJWSnN2?=
 =?utf-8?B?QnluOE82ZStqMStPNCsvdHFPVjZDVW1XYUE2SzhMa09DRXRPbjlzN3lJY3lB?=
 =?utf-8?B?bXYvd1dJWWJhcVFHLzhoQVJUa1Jmd2RFQWNLOTJ0alIwcFpkTFFwblBCVlhW?=
 =?utf-8?B?S3h3bUhubENQemcxMWpuNkNISDJqNlIyaDQ2eng4QkFLSmhvYlhNQ0FOclZj?=
 =?utf-8?B?Y0gxeHk3RnB5dlZkQjVvSWRYdG1VRmVKY2RBRm1QUmN3b1lTS2hEdDJKZlJo?=
 =?utf-8?B?aVZVN21VOGxVUlNCd1E0bjFjQ3lIeE8vb0R0WkZ4eUxzL0trU1FlSHRibkh1?=
 =?utf-8?B?QkY5UnlsRjU3cENxRmFVeEtxeTQ3eGJNbUxzT254d3FWcEdEWU1qeXNXdjEv?=
 =?utf-8?B?VVFuTnc2elBLbzNkTE8yZzRTWm1NZityZDVqSzRVYWtsV2xDZWRvSWROUzU4?=
 =?utf-8?B?WVR3WjBsSHdId2hSVURaS2hoNWFzazZibkNyMS91V1d6Rk5UVEJzTXh0ZjBL?=
 =?utf-8?B?MXdyRlFPNXF1b0FGSlc4OEJyRUpmekM4VkJ0NEFvRWY0azVZRFFaRFZMdHE3?=
 =?utf-8?B?MlM5Nmt3TmFOblN5VFRkMUZxdWoxblRCMUNUekhxVFJWT29SbExHaGxCMjdh?=
 =?utf-8?B?OXlMOTVZZFpaancvemVjemNmVlR1N0swV0RUYWZhdUxNTEsxZ1NHSVNFT0ZJ?=
 =?utf-8?B?NWtxcVVmZ1BPRHc0eko4SWMyVi9MNkY1UzR3L0FTVnpsWjNWUGZDamlySDYr?=
 =?utf-8?B?cDVCRnFPZ1VMd3lEQml6SkNWb1JRK0xKdU9nS01xREljOVhkeTY4TCtGUUxL?=
 =?utf-8?B?MXZNVXVtNlo0SGlPV0o0M21pZXF3cmo1ajdoOVFBZnlpMktmcXhZblE2VDVQ?=
 =?utf-8?B?YzRiK2FXMkR3RVVETmsrTVBRVENiUWNnaUEybUhvVVlkK3FUTjY5cm5JOENn?=
 =?utf-8?B?MTlybjlYLzlxUlV1UFdZSlRtN2lKUVRlQ0J3SXRvb0JteWZZUEd5dWZPNlow?=
 =?utf-8?B?TTdIUW1US2hMZS8xSm5nbzdsayt4dGp5aUpqNFVhRkc4ajRiL05YdDBHMXV3?=
 =?utf-8?B?OEpoaFJubWhrNjh1c2YrZ3RWUEVWTElrK2xPTEM4UHNHK2RxdWVFOXd4TXlX?=
 =?utf-8?B?ZFFrQVJQSGp4eDh3K2xKNCtUc1NMWEhzRmxpcHAreGliVEt1N1hrSjN3bjh0?=
 =?utf-8?B?YzVvT005bjV4ODdMdnRiQWJRWjlHTlFVcnlWVzBoSXljNWI4dXF1cFpERHNp?=
 =?utf-8?B?ZzVZemVXQWxYMUR2TldQcFhxNzg0dFRJSEZwMDVSYlgxVVhUVWkxZFBXOVVM?=
 =?utf-8?B?TXBXbWJKYXg3RTg1N3VTRWQ3ckRSNXhYQU4zVVJ0T0N0aSt4R2lzbDFmQ3NZ?=
 =?utf-8?B?enRmUEx5WFFsWEtqRUh3SjZpTXFPejBvOGQzOTZkeGpCSlB5bXJtcWhuLzhH?=
 =?utf-8?B?NlMxVnppUGhpWnVtdjU1eUZmWG92K1ZEeFJsdyt5WXZFSENVRGtjY2ViSkVW?=
 =?utf-8?B?SVhJNEdqamxudFZ3VjEvZkdwc1dxZ2RzNEREZHk1Y3dzclBFMUVpbzdHY1pB?=
 =?utf-8?B?ZHA1ZnF6eEVPdXVwM2Y2VDhHWE1MV2J6ZFNwK3RWZitkY09xd1pkMFJqd3Qz?=
 =?utf-8?B?YmNpMmZ5SUxHZ3ZPU1EwRW1qMEM1VklCOHZXc1FmVTBoMmJ1bkNTeDltL2Mv?=
 =?utf-8?B?S01pU1RzOXRIRk5hby9vR2xGTHFmd3dRSUpaTmpjemcrNUJtZkdWSkwxZmhk?=
 =?utf-8?B?VFMxc2dzc0tjY3Q4Z0U3L2hjWlorVGczWHBGTTBuWjUzR0pVZUhDYmpZTFN2?=
 =?utf-8?B?QnZ1VFVwNExRWjd4bjBUK21YeTVXWWF0dWdCbTZ5ajJSemxzRHlaVm01UVZz?=
 =?utf-8?B?SjFqNCt4Q3p4aFRKR3o0RlVQOGpjQzZhV3pETy9xQ0kvdk9rK1dpN2h6cldo?=
 =?utf-8?Q?3TmZFvGlvWRVsHLRBU2NHbY=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb00af51-3cd5-48a5-dd51-08db7eddc11e
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 11:31:49.7555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fzAruC1L/YsZl9S5Zbrneh/ma6P3PckLUZUNns47V+ydWOajoC8U+S6WrneW06BJ9/jYCU6SU+U5DAah+WZLPshR0xnfuya0fBhYl8sFYgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9966
Received-SPF: pass client-ip=2a01:111:f400:fe0c::719;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 6/26/23 19:08, Andrey Drobyshev wrote:
> This series makes IO requests performed with copy-on-read to be aligned
> to subclusters rather than clusters.  It also affects mirror job requests
> alignment.
> 
> The initial reason for that change is the following crash discovered:
> 
> qemu-img create -f qcow2 base.qcow2 64K
> qemu-img create -f qcow2 -o extended_l2=on,backing_file=base.qcow2,backing_fmt=qcow2 img.qcow2 64K
> qemu-io -c "write -P 0xaa 0 2K" img.qcow2
> qemu-io -C -c "read -P 0x00 2K 62K" img.qcow2
> 
> qemu-io: ../block/io.c:1236: bdrv_co_do_copy_on_readv: Assertion `skip_bytes < pnum' failed.
> 
> This change in alignment fixes the crash and adds test case covering it.
> 
> Andrey Drobyshev (3):
>   block: add subcluster_size field to BlockDriverInfo
>   block/io: align requests to subcluster_size
>   tests/qemu-iotests/197: add testcase for CoR with subclusters
> 
>  block.c                      |  6 +++++
>  block/io.c                   | 50 ++++++++++++++++++------------------
>  block/mirror.c               |  8 +++---
>  block/qcow2.c                |  1 +
>  include/block/block-common.h |  4 +++
>  include/block/block-io.h     |  2 +-
>  tests/qemu-iotests/197       | 29 +++++++++++++++++++++
>  tests/qemu-iotests/197.out   | 24 +++++++++++++++++
>  8 files changed, 94 insertions(+), 30 deletions(-)
> 

Ping

