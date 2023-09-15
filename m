Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E64817A2729
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 21:27:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhERo-0004x5-Bi; Fri, 15 Sep 2023 15:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhERm-0004wg-Pf; Fri, 15 Sep 2023 15:25:46 -0400
Received: from mail-db3eur04on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe0c::707]
 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qhERk-0004GC-7Y; Fri, 15 Sep 2023 15:25:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMRAKMjM4MnZwzInqTTP/0InDXT86dxo/kiwy5UWTjz/HJcsmD1RGcEW5o5gXfNe7MkNV2wvmyoY8iIsFCEOJkzM98jQLaRaZpDAvsYfjq2aM31myA0mo/4rKTWq3CzSa0FweKSmEAF7BYdtKIn2HkYyATOB8MR7SNbrSO5ncriYCPXlulEnswmHfXuuDVJzWztMMrwYznYbyoZ6VMma72yoRLcbzE2DmhGMRhIpUWPy2dH1Q6Sx2MCXnci/7kYNANH9IpePYUVrqPqSYLj1Z/Cj8Dwu44uu+gUeYo0reY5ZqpnywnxsdjOG0ToM1UiR7fyJF8ZT9A89Z5F3JRbCFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdvL8+GIV1sXAyFnUUeD8e3SfHGHSy3xqHheHBDfGVw=;
 b=Uut7Y2GF2FE54e6eCRbpseGWRV/OK2Bx0MMB30aBF7rBcLV6pMy4OHeQ2bcwXHnl+8kO8a2H6UpJCVxUuWa6X/+eJl+M6HqhNdcBnujmslMbpsmSi9AYRIwazxRQV9Wr62zuhYEw6BUkWJfRjET3wvmrLew8Sq2msizwS4B2PsFudSPG+gfRdKZzOoJksEBnqOEykp/sl21LhCMS5NNH5jrmMaRLcJb7/5q5SkDPSiAtVgUiKs/7zJIvlfEJ9PbBueduMRk2FZN+8iJf5zoCPXTFk2FIe709YM0V5FGvxvrZddcFGkPQvL2NCvl/0dgR3/1y1KoQVFTIYQ8pmUaa+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdvL8+GIV1sXAyFnUUeD8e3SfHGHSy3xqHheHBDfGVw=;
 b=ly5BmQQnPjK3Thpz26mjn7TkJnAkmRlGfA5b5wgdKSk0+LijZIAWPv5VbSFGfbqB455hiuTR8ai2+SdTJ9b+HUwGJt5MFQ4QzJIgdsdo40iaMI26Qq6nWdeJ+tWMoEESJBN2ip9kRhN0wetJOX/punkrwiWjfvjPj0YgV9YlyCC+r0sS3J/H7qR/MIBwRs/Z8OcC8ScOoDo5UEAHnTcgdsOYSTL2QWGCUSwcbtYtppOqT5Q1Xe7+lWWZhY3+bHpWekd8X5CFKEkUJRO8e17F4ZsgcqFE70ECBlYbHyGicfItb+D5VTdY+pVBLkuvujRRif+r2MMfBpONhmb/QtJYxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR0802MB2336.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::16) by AS8PR08MB6469.eurprd08.prod.outlook.com
 (2603:10a6:20b:33c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 19:25:39 +0000
Received: from VI1PR0802MB2336.eurprd08.prod.outlook.com
 ([fe80::397d:67de:8ecc:6815]) by VI1PR0802MB2336.eurprd08.prod.outlook.com
 ([fe80::397d:67de:8ecc:6815%7]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 19:25:38 +0000
Message-ID: <3265acc5-79c7-4c22-8a23-90731c4cd174@virtuozzo.com>
Date: Fri, 15 Sep 2023 22:27:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] qemu-img: rebase: use backing files' BlockBackend
 for buffer alignment
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, den@virtuozzo.com
References: <20230915162016.141771-1-andrey.drobyshev@virtuozzo.com>
 <20230915162016.141771-4-andrey.drobyshev@virtuozzo.com>
 <k4e2luy4l5vlsfim36ocspcjcy7rltnqlmgigffpxb4azo522h@7v3xxctdx5lk>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <k4e2luy4l5vlsfim36ocspcjcy7rltnqlmgigffpxb4azo522h@7v3xxctdx5lk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::17) To VI1PR0802MB2336.eurprd08.prod.outlook.com
 (2603:10a6:800:9c::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2336:EE_|AS8PR08MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: d92c5ab1-d8c8-4502-8c53-08dbb6218ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI/PndnXTEXrOnqkGYHYBcQzGrxgp9epmoiyHKu36N4JXPAdGj3iH8Ei0lFSHGjAHqbnwZYjUBFivdQhSfrkYKskzqB8bcyEH0AtS99jGWymp8J6U7CL8LhkFerE8GXx6CtYw2XrFNemHNtWZzh8GutfS+rl1x0gvW5mFLwl+4cXijXX5vFtOQTUGH9BB1ICF40EJeXhR6x4i3PtiDp/sBLGOQNRBtmlmuPOgibEFwl9Y8KW3jNCNQjwcsoska/Jbe/weW3iurCvXLuKjL04SolIU3mMisvzb+2O4xKTo7cLzpSl+llE7Ebbpoi0JI5NtV7zbD5lG/rNmZyw2WnMvmRL0Vp69uj/wAbu9qrzd97KffpBS0CLx6/L96z0QR5qAfag+QgLMcTKQ8QbsdEfY6632Z6+owP4SgwERk6FnCiADTHSOAl30hQZjqG6b9RMMdZXIc6W+LfuBcCPV2s9wXrAcqamS6wCObFAPZMsMQS5ULZKcgSQAbue1AwbQjd09daZl00gervW3pICWJ3F0JiCRdjmI1Z/lS4qfEIUwxV7KAneb1aPIZ+cIS7xmmy8SCwkvAkE+XbG1OIZWfOZqUunYYJt4rFdpBx1kwieCCS4vHjB0kaFeagCO8I5mhBXuNvEn8XP2YmF3JZ/ewiF7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR0802MB2336.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(346002)(366004)(376002)(136003)(186009)(1800799009)(451199024)(6666004)(107886003)(2906002)(2616005)(31686004)(8676002)(6916009)(316002)(26005)(8936002)(6512007)(6506007)(44832011)(83380400001)(53546011)(6486002)(5660300002)(478600001)(31696002)(38100700002)(66556008)(66476007)(36756003)(66946007)(4326008)(86362001)(41300700001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vnh0dFpCaWxJdjhWc1ZpcDVtbGNQVkZ0T1ZFRWNxWFgzanE1OFIyZXpobi9I?=
 =?utf-8?B?Zno0dDAwTXowSlpDMVp4dUEzZjV2dWcwMVZnNlNBS0RlUzEzRm10Ump5bFZt?=
 =?utf-8?B?RHo4ckNYTGV0YVQrd3BNV0RUUkdZRjRhRU9wQzlCUjZUZVlVeVhia1BBdmFJ?=
 =?utf-8?B?andzd3RuZzBDVU83RTFseVN1eFVpQ0paOTZ1VXRESS9HczJxT2V2elNjYkhy?=
 =?utf-8?B?dnFpYnVGNlhCUy9tcHExbzZLaWlxQnFtVjJLNlZ0Z3hZbi9LY0dxek91cjBW?=
 =?utf-8?B?UTcxMXV5UVFoNHg0elJDcFlRK2tRYXVrdE1Cdk1kRXBzcUNjZ0h1VndyTlRp?=
 =?utf-8?B?dW8wTjJPYlRWVFY5enIrNnNkbkNyKzA4cVRpamQ2NkxubUxJMmF3SjdLaGtm?=
 =?utf-8?B?cDkvcDBpL1dpNFZtYVlNOXRGSVArNXRKKzdFQktYSEs0YzhYNWdhTE9YVDRW?=
 =?utf-8?B?alNCYXpzbzZtMDFFQTlGb2szM3FNQm45UlB5NGlKZy8wdVltU0I3S2lpdml5?=
 =?utf-8?B?L1RIa3pMUlREOWdZR2JFUGRTb091aHB3ZXZreERDM2tOL01XU3dBZm94UUFy?=
 =?utf-8?B?QTEzaDZPRXZsSXZncU1nL2RTR1VCc0IwMjB1Q3YvM1FFV0Y2OGFjSTM0SUl0?=
 =?utf-8?B?encxRm0zNHpnY1RIdU5veXEySlc5VkU0UDZkTCtOdm05bHNwOTRsQ2NTVVlz?=
 =?utf-8?B?L1RwY3R0czZqU29sbjM2RndvVkk5TjJmUzVqa29aVjhxazdYSjE0NFdOd0FP?=
 =?utf-8?B?eWxCVkZ3SzUxMFZZMDdOOGZPSURvYjk2eVNnSnJaeUlyTUtMNktsd3BSempO?=
 =?utf-8?B?b25OWkNjZlQvQlVuTllwSVFZTlB2cjJENWRhek85Ylg3UWZSdVBBbVBhOWRQ?=
 =?utf-8?B?L3kyZGpjVTlid3NhWDBxOGZjSit1TEw3d2tYWjJVZVlKSGc2VjVjMXh5cG12?=
 =?utf-8?B?RDh3OTVVSmh0WThxQ1NkU2hsT3NvUUgzbXZRWkJSOUFJYWorM1pFQ0tzZUtr?=
 =?utf-8?B?T0VmWTJXckV1WmY5OWw3RXR2VDlEV1BWOG91YjQ0V0NLRDhXZERudFVEZDVo?=
 =?utf-8?B?VW0yTVg0WFlKRkhNNVFJSlQ0TVJFMFZKQ3kvUjk3OUFPUGRUSzRlVmMvWXdW?=
 =?utf-8?B?eVR6b2QxYWowMnR6WldBUVpESDQrWlFHSVRqb3IxclBOZjV3Rjc0ZUp3bFo5?=
 =?utf-8?B?dUFyS0NtblpaTHFNM1M4THVCLzdMYWdrOEp0MjVrMDFlSjRGeEZ4VDhKN09O?=
 =?utf-8?B?cWsxRHNveG1UdU5hbHdaeWlSN1NYMW51VzVxaGhQRnR2dHU0MkxIVllnRmlp?=
 =?utf-8?B?aEhvRHpoR1pvdGR4NVlwOGs3N2hGVmcwMWdQYWFUenFTUDZ6ZUZRdDBIcDZS?=
 =?utf-8?B?a3YxMHJWWEJ1cXc5NjZveUJxVXhoRlpnS2I2OXhhVW9FbmRaaWFvRndUSkMw?=
 =?utf-8?B?YjNkY0xjcGNacGpCa1pSa0ozYUdQbmpPQk9ZN1pwQUV5aFY5eUhSNHRwMmc2?=
 =?utf-8?B?bjlmdFZFbmpmVFVHZEZZWm0rODQxeWI2WitPV21Kbi9BZTA4R2NrbTNTWFlZ?=
 =?utf-8?B?TXVyWXBvVmU1M3puUzk4dXQyOVFMVWRybDI5Y25iQ3dLbkx1NDdlc1hndk1J?=
 =?utf-8?B?MkVTTmRwNS9VbGNSaEVFbHRWYXVPbmhCZVNKNHpMbkZsS1V0c29sUGtwVHFh?=
 =?utf-8?B?NW0vR1FONzBJRzQxTnZCRGthMmVnWEFwUllUeG1rYzdoMlNXMXoxcG93YnZH?=
 =?utf-8?B?MEVESUR1Q1RxaDA5YzJSUTNFalNjYjhIUGVnMUZQeHZVVGVKSWpjYXJ5TVVF?=
 =?utf-8?B?NVZHTDBzaW90cm8rWTZEWkRHcHlVSDNtOUNoUEh4MkZ1VjRDWlZ3VTgyOFVy?=
 =?utf-8?B?QWF5Q3JoSUowdklKT1R4ai9ob2xPTDJxYWNKbUF3RExWMzB0OW5hdG92Mmd3?=
 =?utf-8?B?NjZaVTluc3grWjBoRVR2TmUzbk5scldVTXlDTXF0dkdVL1ZVT1M1SHJQb2tL?=
 =?utf-8?B?dmdxU3g2cEd3b2NIVmVKQnJuNWdING9lT2o1SkpnSWZrWmlMbkg0dU5KeWtl?=
 =?utf-8?B?dlN3SWlHbG90eHRXSEtWZVc4Z0RPVFNLMUlKNlNIbnJ1MW9KRUhZWWFvZlR5?=
 =?utf-8?B?TFJiUVp1eFFocllnaktEa1lzRnRPanY3VXE5UU5naCs5Y3RtNFZQWkp0N2RB?=
 =?utf-8?Q?ZGEh9fWs1WQjDGh84Sa2658=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92c5ab1-d8c8-4502-8c53-08dbb6218ac2
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0802MB2336.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 19:25:38.3643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2BJkiyz/oCxlFd/XLwTzNkrrQoHYkynDVS3zUMArdmZDPFTSIPxZHRDZkuV6471eFJImEzsrvKxQkmsFXdX52ippV9iJmZaVddhNf7+tmY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6469
Received-SPF: pass client-ip=2a01:111:f400:fe0c::707;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On 9/15/23 21:39, Eric Blake wrote:
> On Fri, Sep 15, 2023 at 07:20:11PM +0300, Andrey Drobyshev wrote:
>> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
>> the data read from the old and new backing files are aligned using
>> BlockDriverState (or BlockBackend later on) referring to the target image.
>> However, this isn't quite right, because buf_new is only being used for
>> reading from the new backing, while buf_old is being used for both reading
>> from the old backing and writing to the target.  Let's take that into account
>> and use more appropriate values as alignments.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>  qemu-img.c | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 50660ba920..d12e4a4753 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -3750,8 +3750,13 @@ static int img_rebase(int argc, char **argv)
>>          int64_t n;
>>          float local_progress = 0;
>>  
>> -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
>> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
>> +        if (blk_old_backing && bdrv_opt_mem_align(blk_bs(blk)) >
>> +            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
>> +            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
>> +        } else {
>> +            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
>> +        }
> 
> Since bdrv_opt_mem_align(NULL) is safe, could we just simplify this to:
> 
> buf_old = qemu_memalign(MAX(bdrv_opt_mem_align(blk_old_backing),
>                             bdrv_opt_mem_align(blk)), IO_BUF_SIZE);
> 
> instead of going through an if statement?  Or is the problem that
> bdrv_opt_mem_align(NULL) can return the host page size (perhaps 64k),
> which may be larger than technically needed in some scenarios?
>

Although bdrv_opt_mem_align(NULL) is safe, blk_bs(NULL) is not.  And
bdrv_opt_mem_align() takes BlockDriverState* not BlockBackend*, so we
would have to perform the same check and there would be no simplification.

>> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>>  
>>          size = blk_getlength(blk);
>>          if (size < 0) {
>> -- 
>> 2.39.3
> 
> At any rate, aligning the buffers by how they will be used makes sense
> (if the destination blk has looser requirements than the source
> blk_old_backing, then accesses into blk_old are suspect).
> 
> Reviewed-by: Eric Blake <eblake@redhat.com.
> 


