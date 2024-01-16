Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98882F085
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 15:24:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPkMY-0004wA-Jw; Tue, 16 Jan 2024 09:24:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkMV-0004vr-HR; Tue, 16 Jan 2024 09:24:19 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPkMS-00060A-IW; Tue, 16 Jan 2024 09:24:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzAOS+YVN2KX38vTky28m/Nfu1PXMgauZnZEqylos7IPXJ3lUo1vW9SE+Ear2LTPDTn+/D1HnFUcYm8w5HOXQn1jehQPrVWNvXrOhWypaVSYOyCiO/3sr+nYss0w9woqvrPIOmq534wnLzDmSpJxMbn1G0DfuKtGAV2YynGLTn/6ey9Rk4dOrmOXPQ+meY6pDIIPvuAjSHb3REy2doaKhrVl/EFWya39vriOuqIO3IvDUZ9ibCgHeo04mMmZu9PYewLEFFBe8P/tZJ5l+dl6TwOSQuyP7BlJooydwdVyQJ6kAn+Fqv9BCV7DOwX067CprBbbyBzPFqOuC49TIB213g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gug+CjGV6R9kYWEBXTFIpq4VmU6brbSR/0kmyG/KGP0=;
 b=KsaXJgEOvc1UQqkk7wenbwONgOLYp00Y1Al+TIR08h+Lqtl0ZxfHX69jbpbW+2DMh39zAfzaJpVU0CRNGa89Sdvxva0OyFF4Iyf4ln74qURVvRdMVfFt4ekH3r9359qxX9zQ8rvCBDjt+WdmjmR1r2u0eniQa25ax6SmjzHEOe3q2V/Ra3CnuWwaFqVRA4XuwJI6e0ThlQtYXz++63PYLOhcIDYIWNVGk5E5+Y6sTmBm+OoZaNcXdKRtD4hgCkm2Ur/gfDHO95Ql4OZZB6DDL/W7VvOMkubIj3zcBh3K2AcEV2OhWNyvqcJkpy8p2XuCQ03pWlgaEe9N3khoABoZxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gug+CjGV6R9kYWEBXTFIpq4VmU6brbSR/0kmyG/KGP0=;
 b=D+hiE/ZyPhVWaY/vLyc2+UZAI1yhT817QKP2+/uK8NSV2i2i57YuKENb2fH1jt3nn9R0Ew1q8/JCHhlfHAaw+lqVZW0SGavjfwr21iss7pHhWeteSGogIhE3bwKxOFZHDOjGl1T84LDpEVtjT7qcgF6AeDPR3ecgrQbK0sm4QgmlgGX5yvHLmE8Z/NvnzZ6jM56nQM02Qy2Icuap4novgLPiFZDvbMYJAFtPk/jh7o8BU5nXWH6ngjxxfT6BwfOawB7tef+juQilSS60QM8uWVCPvvSxdh2szUDBXzhWxUx/GvVzIEVzghZueZHON/NCNND7FToIl0F+mvDCpacpyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB8PR08MB5499.eurprd08.prod.outlook.com (2603:10a6:10:fa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 14:24:12 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:24:12 +0000
Message-ID: <cf28e067-e415-45f2-bd5a-7bdfa36df117@virtuozzo.com>
Date: Tue, 16 Jan 2024 15:24:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/21] parallels: Recreate used bitmap in
 parallels_check_leak()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-9-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-9-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB8PR08MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: c1aa4bc7-2a15-4527-cd19-08dc169ecf72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REi4bYtFODH+dtSiAnPQV+AUaEuVhOojnxEYVMYmB+s4XDXUT2pqLqcEdOKfIjz9rJ1sAt43ZCJR7NtnTdoaDIbZHPzKgXr9UqKYjwFMdiXwaiL4Seu+N7ll5zJsoSxA6nHs46k0x1vMlTimWqdHr6I/34/IGSdDhTEjaT4rgsRMWzTqTXRW9NMoQ+ri0sA7XXj1gRtrX84Nr+XwGAdrnR6sv7l1E1ePu4d6bm1evDS7EPFDBVlmmOnbKmJbn2wlKs9TzIGpmLL2oDueJ73DXXn3+zjKdIvQgJa1TlzXeb1F/rZCcbPm2IlX4S1uTSytW798jX0BVJGqmZ4qdSADc/M7180nbOiwmAziR4EPmxapk4V5grqgCQmEXFrIlU9CmgoMxwnL/7o4XPwPzGtqEuv3mZEvGFAM1xM8YoFtklUOVWit28UgCBW4nCRh4KIhtpjMIZvFVFPta0HWfQvMzQs+NaHbB5trb8vc3jjarm1kyWxeDgIHiFjjbEBFB4rrUImb0t+qIrjCzNpOYkAIzT+uDhB+p2NY19FiSEUV5//L0wi148vD31DNvWoPEDO2ZF3Zoo5HdNX+GM1Qiq/UyPCFgabhjH2fF5gymwqA8dpahakcwOMuTt3ulnaJCovI1y08r8+FXCQlIaA/t0FF7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39840400004)(396003)(366004)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(2906002)(4744005)(5660300002)(4326008)(316002)(66946007)(41300700001)(6506007)(8676002)(66476007)(66556008)(8936002)(36756003)(6486002)(86362001)(31696002)(478600001)(53546011)(83380400001)(6512007)(26005)(2616005)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d3VoYW5rbnlLVDRSa2FNZ1liL2YzM2ZpajY2RmNaRlNzWXNlcGRFZGRnWjRu?=
 =?utf-8?B?OHd1dmxOL0lHOVpTeFpBR091bGYrdFZ3WEhYRVZ1OHhnZHU2Qm42MG5DMGl3?=
 =?utf-8?B?L3RlR2d0WlFrZFJnR0NlYkNIM1hJdHcvMHdDWWRRdDE1SmsweUsvT0lEV0dR?=
 =?utf-8?B?U2w2cGMvWkdsZFZKcTl1cVZQMm9ZekQ2cVQzLzBONlZmV01Ua001TTVaN1pj?=
 =?utf-8?B?NDhHSHQ2QUdMS2NlLzBpcDRROXIwYWgwVXhURmtSQjRCaEdjZzdUWExJS01k?=
 =?utf-8?B?bjd0VHlEUmp0aFZHQW1XUDMwY2FCSUVibDhicURiUStYakxUMTMrVlZZdHAr?=
 =?utf-8?B?a0hjS0VqN05ONUVQWGNrTHpTSzBwYXptT0tWd01vRGlFZlBUYjdrcTdPdHVo?=
 =?utf-8?B?SGdTVFZQR0RIVW5YbmJaS2tINE1KajA5dkJ6czZMcFg5WWhTVGIzRjFOeFk3?=
 =?utf-8?B?TXdNblJNYTFuUzhKTk50WDdCY1RBN3VqR0xWbWRDZmJyQUdMakxZTDBwcjA2?=
 =?utf-8?B?Smo2M0VkTG1PckFJMFg3bTV1QU9rR1VyNGhpaGVoVHVPK2hFR25ZclJYUWlT?=
 =?utf-8?B?Nm1BbzhraTh0T09LWDRnK2I3Y3pmaUZtNFBDekUxSG1UcE1aTWU5ejhncDB1?=
 =?utf-8?B?SUI4aThzYlhid1A1aXNNMEZGTE5wU1NrL0o0YU9JcVd4SE1JTWJ5WWN6Tjls?=
 =?utf-8?B?TWNsd0lYK2hWRGpoNTYyRkZmMExqVmZBOWJ0RTdtQ3RDNEVjdUV6dFpOMWNP?=
 =?utf-8?B?OGNpb1ZJME1xNmNtelhjWCtnaUwxUjl1N3JiYTRTNTA4TUlGam9LeEJSTEho?=
 =?utf-8?B?dEN0Q3p3VXQxRkphM3Y5MHFSeXVJNjRTQXpqaGJPdUJhSkJ1elg0N25HRlFi?=
 =?utf-8?B?ZGJsZml0LzJUeGNLNHNCT2tiOHlsVk9UREV6SkszSjJacHNpaG1keXpybWdj?=
 =?utf-8?B?QUZua2VjckFxQ3BJeE56bnAvTndpaVU2aTZMY2NYWURxbjZybHJHTW5FTm8w?=
 =?utf-8?B?SmJOTVpJNGo5V1lSVnpTaE1NYjdheVlrYU14NXB1VjEyMTZDeGltU1hwWUlG?=
 =?utf-8?B?SHc0WWlPa2FwbWNDTWdPcGRwVWFwN0FGeklkUlBUSzlpcjJNOEwyU0k1NDEw?=
 =?utf-8?B?MUswa2hHNGRWd2cwZUZ3MmF4dGV5UnpjSlJ0a0NvU3ZqaFl3YUNtZUQ5NmpP?=
 =?utf-8?B?Wm9XZERSbVNua3VVTTlKZUJWMlZkRDBHSmZkNW52c2tYOWR2eVBYRTFleFdZ?=
 =?utf-8?B?aS85TjA4cS9VaFQzUDExQXBxNUw1N3VCRmFsK3dQTk85dTdjb1V4WHFZdXhC?=
 =?utf-8?B?UkNlVUJ2Y292eE4xcVFwd3ZNUitBMkdQVUFabzgzOC9BRzcvVGhZdEZmNFp4?=
 =?utf-8?B?NHBsS2RWVmFZNXdwY08zVnYzc2QyOVd1Yk94blIzQWEvaEM1bXFFUm5BY2F0?=
 =?utf-8?B?cWlBU29sSU56aXRJdFpRMmJJTnFQLy9nQ0tCOXo5Z0JYYVRDWW16eEZkK3JN?=
 =?utf-8?B?bWtYSm9GdVJtNnZRZ2RudmFGMzVRczcxVmhPUnRLQUtMWmZhSXluUENnYVBr?=
 =?utf-8?B?MEk3T1hXcFFlMWZwZTA0NEV2dWpGM2lIa2wzR2h5aDZrcWNwT09vdEtJVUpV?=
 =?utf-8?B?dSttZk1PV3AwdjRHalpZam4xWnYvUmFHbnRpcnBNTnYrb1dCK0RPd25DVlRP?=
 =?utf-8?B?Z2ZVemJVNEo5OHg1cERORU1wV0J4bDZ3MGhwYllwT0RleEVWeC9IMTRJSS9w?=
 =?utf-8?B?TENlYm1wNnE5TEFSbG1KQ0xtb01xTFd1MjFrc1lrdDBwcGlkeUVZSG96SVRk?=
 =?utf-8?B?ZkJVYlhEUTh1YnRPa2dMazhHT2c1VTR6NjEvekxhVUhOVjhpWmREVlVVUDVB?=
 =?utf-8?B?WkpmZVdpcmtiNDQ2QnM4czQrYzZHOTVRTHJOQVlNVjMwU3lwWlVhVENScUpL?=
 =?utf-8?B?S1pVcG91blFPZFlMWFZMekg3ZHMxWkNMS0xXM21oZHBHZm1zZTloVTRUb09R?=
 =?utf-8?B?V2JMeVZXTlpFQVhNZGk1Q3gyak8xanVKU3E5bFFwZ0FHQzRvZStrNkQ3MGta?=
 =?utf-8?B?MDZhblRvYnZacU9hUnEzTUVjL2pxVWswWDh2U205Qkp4VmZ0M3dZUC9heERp?=
 =?utf-8?Q?j8wmNnZe7TaElvwcX7fnUvtAN?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aa4bc7-2a15-4527-cd19-08dc169ecf72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:24:12.2076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2oEbCtC9LmEQaBMg56jCmQPg3+8C3WIX8Sx0yfiMccKhFM1+WJcMcM2+baz4nYWMoF8/lOPfeFTNCCcuX6PNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5499
Received-SPF: pass client-ip=2a01:111:f403:2612::701;
 envelope-from=den@virtuozzo.com;
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

On 12/28/23 11:12, Alexander Ivanov wrote:
> In parallels_check_leak() file can be truncated. In this case the used
> bitmap would not comply to the file. Recreate the bitmap after file
> truncation.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index 8a6e2ba7ee..04c114f696 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -807,6 +807,14 @@ parallels_check_leak(BlockDriverState *bs, BdrvCheckResult *res,
>                   return ret;
>               }
>               s->data_end = res->image_end_offset >> BDRV_SECTOR_BITS;
> +
> +            parallels_free_used_bitmap(bs);
> +            ret = parallels_fill_used_bitmap(bs);
> +            if (ret == -ENOMEM) {
> +                res->check_errors++;
> +                return ret;
> +            }
> +
>               if (explicit) {
>                   res->leaks_fixed += count;
>               }
Reviewed-by: Denis V. Lunev <den@openvz.org>

