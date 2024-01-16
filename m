Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE7082F009
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 14:54:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPjrt-0005yG-U8; Tue, 16 Jan 2024 08:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPjrr-0005xy-QB; Tue, 16 Jan 2024 08:52:39 -0500
Received: from mail-am6eur05on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2612::701]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1rPjrq-0001Bb-18; Tue, 16 Jan 2024 08:52:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpGJGW8qhd8LmJ5QJVECVjk9LIbPKWS8svhLHqiE8iqGejQl/rC8FyY1Lj00CZxJQwKon5kwYIEdIfgN0gASJ2ZfWbMh7TLc3g776A/AnckEIuFQ/s79fB1V6ylH7b6tKCmNld7nYNBdwYEXLAuoQ7ARaWk9N59AHhzuaaOrorZdxGcwFOglnwSolGVFFLvzDsfDym815quEM8YFXxlxE0y9xjFSm7W3HCCObbS1Xd1npZrP2GFBDOy6w6VgGyaZC2P1WXvK28av2O4foGlQd6EEyrvne7vWGIjeu4oXM7t7KGE+4m5y21zDw6k3Qy8+1msYjPFu+YiM04Jx2RTdbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZGVRkUOxgqTS6rvhj/oH1gK33vb1ojtusI8Rz3GtYk=;
 b=RTqRfzsplH7AlcLBL+KKfGER9DFkFTbtHIZZmdbJikmdsElVjJkkGvpEnFvDL5Ir849ICEcP6CE3icKc+jIVn/1NlA5hH5ZYBGIT4nII9+fkiukFQlqdqO52WPTzqM/Su+kjS6bis9lE4hdZR2aOHpggOV/e38PJE05UMhT5wqhzYF7v+J33ciinPRfMjuJH8/IiDVNlK+P/g3ulqbuZF7V7dyMIKaTMbPPtctbFI/IZ1+SzuXEOQF4d3ihDcXArC3MlMq06b5z6H7h4vLXRDgqrFF6ClFDyuN+ioYYiMRHDQUQOlaz4lEP4Zao+42sJjQFLBBb3OEAhVX0coiQeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZGVRkUOxgqTS6rvhj/oH1gK33vb1ojtusI8Rz3GtYk=;
 b=HgiHJvfsPd9VLi0eAF12o10KGGg/+xkMUp3W2SNu3b+J8VqYIRN6gogTV0zW43zCE39pkR37T55+mbS5W6wIwC/CwpA4CBuX4RfkDkaYx4YdrOE6gwqhpteo7Ob9wj5CG7S/rR+HCEsm9bFV9HBP6O8vsb/rQuzuUzsuPNx9CQ75FyQoo44wDy1GbnWQoG5elPL2QxyI4T5PO0VOkGkstilROus/KGETEFaMBkux8tw81koY2HDTU/UjOZxKPwjsuYjlXJzIV56CJJluuWfH37crKkRemNccSnSGQ0qCP4cm6921yu+Dc4ZLmKP4X7EdKgGvXfED8cAQ59KApY8qvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB5PR08MB10235.eurprd08.prod.outlook.com (2603:10a6:10:4a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 13:52:31 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::305c:3923:7c79:ddfa%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 13:52:31 +0000
Message-ID: <c09e29eb-2787-4fac-a6aa-c74f831e794d@virtuozzo.com>
Date: Tue, 16 Jan 2024 14:52:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/21] parallels: Limit search in parallels_mark_used
 to the last marked claster
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com
References: <20231228101232.372142-1-alexander.ivanov@virtuozzo.com>
 <20231228101232.372142-5-alexander.ivanov@virtuozzo.com>
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20231228101232.372142-5-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::18) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB5PR08MB10235:EE_
X-MS-Office365-Filtering-Correlation-Id: e44eb441-6772-4812-fe64-08dc169a623d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YuTXR9kgv1Wlkz6ux9AwtZFLMgiHLTRG2gJvYJ2mqnrXjTw0gYXS3zmieq9oSjvQ5Vzb2yArpckobCTQMx16Z6kVn17FP3I+9WdsjutzhKP3MZowtVeEzldLNlpBIr1kD+fPiWTSnXoiNAiiVmm4X2qIli+gVFy4W5TfSe3nsH/8qBJYwbsYSWQNZ0HpN17D2ld2XefzyCKD1TEO7vsAC9S+pabSRVmVUnWQRGs4D/vcRY3aGYC/8wM5SIsSQA927P/SRlX7b/ctw0ABYn6hoeAkaeoF6Aenh5GCcEA4Tamr+R9UTj/Bxo/4sb04lEHTA56fe/JR7I0FbpI0uSYtjxG3LGUaJ80GoGGJ4z/5L9OO8pcXmZsE2MhQ7jk7WUZn6W/iSL/ThFnEPM8gxPWN2f4oUQnNYs60ctGYDU+q91eMf39/MHyhlNFM/QWkaT3vyRWg4pf92GpwBDKNjlPkjpAI9ZsM28A0lYzSSYEwOiSgQOeH8aRmHv4uQC93j5DckAS1RLRkmBYRlF0Lshl1E2FZ9l5dTpkXgTX0V0Qx5j3LUV/FKIhJDspXnaly9fKvdCcmt9NZtvCO+0BFdFNaXwKJuyneHx+9n4+brs70EeDYQwmOVPNXC+YoPUr5BJ87nikh6BvGzN+eFoBDI7bHPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39840400004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(5660300002)(2906002)(66476007)(66556008)(66946007)(316002)(41300700001)(8936002)(4326008)(8676002)(6486002)(31696002)(86362001)(53546011)(478600001)(6512007)(6506007)(36756003)(2616005)(26005)(38100700002)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEppdzNCNFEweG5BenpQcnZ0U2gxZUxlWG5na3J1azZDUUlLSU4rS3U0TVAz?=
 =?utf-8?B?ZTFWeFByZEV0aW1pNzJ4ZGxuRUVpMjZPTGFWVWtqczJ4cUF6N3VlMkZkWHFm?=
 =?utf-8?B?U3BwTnJJWlBObVdhRWFtOFpxOC9nWFh1clJIdTFLeExUeWZ4YzhWVmRwbXg3?=
 =?utf-8?B?aDZoZy8wbTQ2NHZ1U2xmK0R0L3FlSjQ3WnZkSlZKdVlQNzVUVXBIZWhTbDRD?=
 =?utf-8?B?aWZtb0NVWDdSOGpwYjBtS2x3U3NJRTM2UUMyN3dTc3lvVklLaTYvVUhtZmJh?=
 =?utf-8?B?UGo5bEhncmdOVWdTSzdTZGlKOTFTQU9DZlF4cVBxdm1zWHU5WjFmODE1Q3ZK?=
 =?utf-8?B?Tkhtc3JSUTlKR1JwZ3dYVWtHaTZiREN6RUREWHFiM3RNa0lRdlpuOWQ5Zk94?=
 =?utf-8?B?WE1YcEY1QkF2eFd3cVZETmxIcmRRTzVKMzhWd3ltQXdlcVR2T2NGOEdOV01U?=
 =?utf-8?B?bC9PKy9oSUgxaGU2bDNMTWRFQkR5a3lJcE5wQlJoRXYreWQ5VXBvMXZwRzMz?=
 =?utf-8?B?azBzVFlXekN1VFVTOUZvTlMzUGdmYXhvVkNYWHZNL0MzRUd5allEcFJnUGlD?=
 =?utf-8?B?VlJlSlJpNGZXaktJejNyY2VmclhHUlBTRFM2UFBIYkZSY3BYRXErd0R4UjFU?=
 =?utf-8?B?bWk4RDRmcDdCR2tQWkV5K2hiWDhLLzFlYitwRXJFOVJFM2JOK3M1VzZDcUVs?=
 =?utf-8?B?bklKOFNUQm9va3htUVBDMmdNZGF1ZEViNEJoZW0vYXpJY2RNUERrbHJYUUta?=
 =?utf-8?B?WWp1T00yWDlOZTJ1aHd2bDZmRU55NXdmS3dobVcyYWFWbGNLRW95bWQvOUFM?=
 =?utf-8?B?Z2tBUlV1VGlpcElNTzh0cEhGOVpQOEtmeVVVc2FLOW5GTm1uM1hLc0VYcUFv?=
 =?utf-8?B?WTFiTldxVGZ1cE9vRmwvQ1JJYS9RUWZ1ZXQzOGNoQWF0M3VPTGZxNFhEWmNL?=
 =?utf-8?B?ajAvTVdJVjhWZndqWStIZVpwWjhON05zSk1TaU1xMHhZMFVxc1c0SmFNWStL?=
 =?utf-8?B?QWhqQ1BOY015a0RVc1J0bzRTbGdQZDgzalpmNDhsU3lYY3dmbjQyNHcrQldI?=
 =?utf-8?B?VHNYSjVRWC84VXUxZmtXUlhGRlp5alkveVJiMm1ZWk8rM3pnbmErcjVSYjVS?=
 =?utf-8?B?NVFzRkR0WDgwVHkwSFZrd2hwQ0JMK3pXY1NwcmhMSHBQU0Y1dzZFZ1IrekJw?=
 =?utf-8?B?czVHYVhLWWpNYkxiQ2VXVEhHMG5RS0dzQ3h2UExqRlczZkNySW5icXdYY2Fv?=
 =?utf-8?B?cUlQaUVwMEVEOFk1elBzQkV3cFhTVGZJaW9BVi84YTJMU1kzMUJST0hZUlRT?=
 =?utf-8?B?ekM3cnY5eEt3Z3dZd0F2TmIrdHg3L3Bya29nOFZaNkVVbVZ6eFpSVndLZ2FP?=
 =?utf-8?B?TktzaU40WDd5a1dLVUZraVNwNGdpV2NBUExwVmV3UGVWMERxQlN4Q0xYTWtO?=
 =?utf-8?B?VjdqcTBtbCsxZzY1RDIvbW9WUXhUcWsvVXFZMVY2bEY2ZVN1S0xNQ09FUERL?=
 =?utf-8?B?SnVRRGY5M2J1cUk3QjRhZEg2RGsyV2xOMGIvNU9HUGRXb2UyNEdyWkN2U2lU?=
 =?utf-8?B?SmVORWpIZnVNTS9tQ1BCV0lZSmtnalNjUFUxWFZhbzNQSTZEZjJ0VEh3RlJJ?=
 =?utf-8?B?VUx4YlJIWDdlWnBWdDJzUWNkS0JrMzZNUXVManZ5ZjQyUDYwRk1wNk9Rakti?=
 =?utf-8?B?RFdwdW5VSkQwMHVHTXJVY0JJU2I0Y1hSZlZYNThjOWMvQzY3K2lCaVc3T1Ja?=
 =?utf-8?B?VGs5a05RQmx2R0N6RjNXRUU4Y3RrQzNOeFRwNXJDMkxMUVRLZWh4SmFmT0tm?=
 =?utf-8?B?aWpFK2piQXB2d2lkRTViblc4cVEzZkYrN3VEV3R4OGI5UGwrYTh4OTArN2to?=
 =?utf-8?B?Z0VwZ2VKNDZMTWF0b1hJZ2VCNVVkN0RIREFCVGdsRTVWKzlYYmNXQi9OUy9o?=
 =?utf-8?B?YTFZekRsaklpNm84OUR2TmNnelFEN1JGV3hBYWx5cDVtZ3g3b3J1VkU4S1Zh?=
 =?utf-8?B?U0U0STNVSVFMcFllRnMzWGY3cWxaSEhmclhiOGpVSk9yVDRlQ2QwVTFVQmVJ?=
 =?utf-8?B?VExpYWFaNDlqdVRxb2lMc05Tc0ZCT0tOZVUyRitMd0JjQkNKNXAvZFkzNHdN?=
 =?utf-8?Q?wI4gtNgyvdLDsR8LuiVjV6joS?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e44eb441-6772-4812-fe64-08dc169a623d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 13:52:31.0324 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sAXoyw4KRmo1pjLAJQIKu2aqcfvQBuQAGn0A/1GImFJuB36FIjqJlz/3Dyl/NzHuZqxQbGYMcwrMThN73f0Y1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR08MB10235
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
> There is no necessity to search to the end of the bitmap. Limit the search
> area as cluster_index + count.
>
> Add cluster_end variable to avoid its calculation in a few places.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index ae524f1820..4470519656 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -182,13 +182,14 @@ int parallels_mark_used(BlockDriverState *bs, unsigned long *bitmap,
>                           uint32_t bitmap_size, int64_t off, uint32_t count)
>   {
>       BDRVParallelsState *s = bs->opaque;
> -    uint32_t cluster_index = host_cluster_index(s, off);
> +    uint32_t cluster_end, cluster_index = host_cluster_index(s, off);
>       unsigned long next_used;
> -    if (cluster_index + count > bitmap_size) {
> +    cluster_end = cluster_index + count;
> +    if (cluster_end > bitmap_size) {
>           return -E2BIG;
>       }
> -    next_used = find_next_bit(bitmap, bitmap_size, cluster_index);
> -    if (next_used < cluster_index + count) {
> +    next_used = find_next_bit(bitmap, cluster_end, cluster_index);
> +    if (next_used < cluster_end) {
>           return -EBUSY;
>       }
>       bitmap_set(bitmap, cluster_index, count);
Reviewed-by: Denis V. Lunev <den@openvz.org>

