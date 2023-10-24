Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A57D4DF7
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:35:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEkb-0008Gz-4Z; Tue, 24 Oct 2023 06:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qvEkY-0008GW-1W; Tue, 24 Oct 2023 06:35:02 -0400
Received: from mail-vi1eur04on2092.outbound.protection.outlook.com
 ([40.107.8.92] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qvEkS-0005ht-P4; Tue, 24 Oct 2023 06:35:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3dPZRhYEiDBJtqlPfbEGUD5BEDd5YRvCpVDQIz+6sHVV/A7/9/+Ni8V/x24e7M7CjmNWgX+/x6r258M8XPS/pJhGjbMArtp2ZlGEphpjA1Flj/VJzfqnaw/G+riTpqCxLggP4ugKR12npJc569Sq16cbMQsugQYFtZkyFpc3zoU2Dpmx9SlmO2ySvSRKnkaNppyWSzeWN3awgtJPXMZLhscMqOYsxbKFuDKc9woRNO+7x4QYtG/yY3LYYs5gbHJQLjitiVJny5cTMmsYFiJjYC3KPTgdQ9zn4zEEH239AyEOK5KXfu6A0VutSXCFj9coTF6mdS/IMJVKBoMYQI/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1LAwFk2EnVy2S9ieTIAgB6axdapw1VNIAsQufiqH7I=;
 b=NVBW6Zkgfx8qijF9tnLqRFFMmaeAV0ZWujdyfvlsk6BM+/l4UE4RS9RthDTkSXCq2lhRglPQKAVKgGwUKT61JrQrZiGK0nu3JLNhDWaWllAFe47SUyPn/9sE/U9vg6p3c2gNgfB3xmCqKYTDirkjYAApGyLFyrZWFVGGhVfLfEfdgkJqhJN7U8XMawxBb+5uuqnwYK6ICUzKwLCQGpjIkG94V5EoepIvx5+e/Z8CxdUP4JZcaTcMkfWgrExP0Fp7PXxatjSwX6S/AnK4T6nypNYZ141y5qwmDI7WmdQpkRUbIWqTBJZLbDdWiY0su+mwdVlH6skco5iQy5MarxhrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1LAwFk2EnVy2S9ieTIAgB6axdapw1VNIAsQufiqH7I=;
 b=y2MAnD6FWRu8n1YNddbKwnk7eaEnlzD8DGc2/YDh13S1LA0MGhlNp/6IibopdNpDRb0fuMemT4W2LuOkt+YXuhFNZLYylZRTpfd68N4t/ETjR6PwYO8dj6JRCjCn/+HM0mUOgaqKlnYeLX6sgvjOjE5BuXtbEhLTLDC1nWMlhEKfIyG7/Kgp9ZWkNc0Tp0ARxORHGh60D998NkfFYPsVDk7ZWasvTOtcWfQ165Q3mdB4U/LJfHZN/QThNk9d2C1XI3EHbTBzFSlU0KP/J9MwjbaHjdlRG4fv0xv7w8AnHWw0/jDmC+ADhptd/a/x/WJHT8eXC2LN9oJjKdwXtionZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by PAVPR08MB9883.eurprd08.prod.outlook.com
 (2603:10a6:102:327::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 10:29:49 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Tue, 24 Oct 2023
 10:29:49 +0000
Message-ID: <c2f90041-c02a-4bd9-9c17-7da374946659@virtuozzo.com>
Date: Tue, 24 Oct 2023 12:29:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/20] parallels: Set s->used_bmap to NULL in
 parallels_free_used_bitmap()
Content-Language: en-US
To: Mike Maslenkin <mike.maslenkin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, den@virtuozzo.com,
 stefanha@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20231019125854.390385-1-alexander.ivanov@virtuozzo.com>
 <20231019125854.390385-2-alexander.ivanov@virtuozzo.com>
 <CAL77WPC79j7LUJNTYpf5uyH3JFViDKsMMRktzfgtoZKHUVhEWA@mail.gmail.com>
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <CAL77WPC79j7LUJNTYpf5uyH3JFViDKsMMRktzfgtoZKHUVhEWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR08CA0221.eurprd08.prod.outlook.com
 (2603:10a6:802:15::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|PAVPR08MB9883:EE_
X-MS-Office365-Filtering-Correlation-Id: 078bc141-1f8d-486f-7fd1-08dbd47c269e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QcbVgnKkGKkJLMp+BFNvq9efEN+7RGxioT7AfrtSsM8a5CoGPo8/utcGop1P+Dv7HOhJ4kYxubWwXjLyuKzfb+RbneQC5IGySJWc9HN/Wd4chNJqhL9JUeuB4PxZK32+2KO2ZdYI8Zs4oKTRnm1iywcYa0xbqe1XMkfTiPrdPzYYDhc16G9fLniVjk7WhoyceI9WWGp4LTsIi1SnKSyl/GyEPuyFQLfseYM6S1id5aE0zavJ02o8yCdJRMEmN2rkk756oEVG7y3zMplYC97Z4suRXqdvpI4O0PqbESHlC2XOKcbLo6z+++GwsamuNxmyCFDOTMQDY4hkDiJKRRUlZUqSjqkRdqiTuMvnorMKE3OFIzdWYZX926PRmVfPHcgbhpt9aUpzS9XarPIssFlsmzTTLJOQ83bm07jbVzRR0KLOLGgO8DBX16Oc983QHn1rHrzlRgaPiL7Kpk1BO0Y+H2rPpQYERynzm9y2UrreyO+kodjUiJv/h7BGFeEXpu817MYSxUIApqux4t6dtXeNhkOyS0o8ruLSAdFZkB4PUVdvEPnb6LZuYO3CTCKyKsAQP8eJBzCP9G/ItyW/OMmfklsuAywcTUFUQvmNFy0JT+/LAQ4Z1i3/LAkTFv++N/me7eElO+LrffY3Uvh8hpfaoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39850400004)(376002)(346002)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(4744005)(2906002)(44832011)(41300700001)(38100700002)(66946007)(66556008)(6916009)(66476007)(316002)(6666004)(6506007)(2616005)(478600001)(6486002)(53546011)(6512007)(83380400001)(31696002)(86362001)(5660300002)(36756003)(4326008)(8936002)(8676002)(26005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWVHemM2OVFGQ2lLeTlMSWJNNXRwOTJjc3MxZDEzNU5qSU9hQ3VUekpPZU5x?=
 =?utf-8?B?aGtvRFJvK0NHcFFLZ2FtbWU3UTI5TkZaYTdCRFdGbm1PekllVTZjNUs3UDhi?=
 =?utf-8?B?S2cyTTNLWlYwM2x4SVJoUVNOTmtjNHRLeUNXMkZZU2xLZ05GeDFIMG4rRjZN?=
 =?utf-8?B?ZE0rNkdXZVRVOC9MSTNocUpKL3JLeWFSSHZtTDZraDhLK2xKWUxjSHhZbDRj?=
 =?utf-8?B?b1dIclJ5dGg0aUE1T2t4ODBuYncvMHg4eXlRcjdsNmVzTVZxYlhCdDdRTEpi?=
 =?utf-8?B?VTVGMktpS3l0Ukd2M3R3cFozV05pU3RRZjk5b1VmSlRJN2pIakpqa0Z3K0xQ?=
 =?utf-8?B?TDAwVVB4ZXhTME1TdG5RSDlzdUdrVCtkNFVBSzRPWmZWRlF2VFlXMklCWFFL?=
 =?utf-8?B?UXM3YnZTQ1YzWHg4bGN5S1p3UkNjWjhFaWxSRU9jZjdIRVNHMmFQSmRJbFQ3?=
 =?utf-8?B?OVpVUVhRUTE2azZQVUg0c3NWVmgraVJrY0VsZ2lsN3UvUlJxazZDbTl0TFNZ?=
 =?utf-8?B?OXEyV2hmbFd6M0g3a2NNaWJjLzU1d21CSW9oTXVNMDliMFU3Nm52T2hDVkdr?=
 =?utf-8?B?MUR0WU1vamtKL252SEFTTkRXQzJBT3UwdlZsRWFRYVM2WVpBeWRQMzF4aWFV?=
 =?utf-8?B?WnRHNzB4TUo3YUx4SDZRZTdqWTdLWEdCWEx3Rk41MVcrYWMxRk1nTGczMURV?=
 =?utf-8?B?OEJodmxuWGNTdFZlYkpnUDlseHFRODA3MGM0ekFLSDV0YUZBbHphRDhFYmpz?=
 =?utf-8?B?c3F2UjVhZU5KVkNJMmhmelNLYWJEWDh5ejkybXhxcVpYTjA5b21Yc0N4WGNE?=
 =?utf-8?B?WStIMFc0aUNaa1Z3ZDVrYmVkNC8vUG8zd2VOQlh5R0JmVjZNbHdjUkdaSGo4?=
 =?utf-8?B?TGtPMUR6TkVqQ3g2MFRhekpLcHEzMENkVXhad2cwL0FJcnA5RjYzZWpSM3dR?=
 =?utf-8?B?MGt4NDNOQ1VaZ3V3d1pkdGNjcXFGNkppY0VMcE1iZ1hWa29TdUUwaEwvUXBS?=
 =?utf-8?B?c1B6RFJ2cHg5S2JBQWQxZVkyU3lSd2NweXFzMlpmQUR2Qyt6a0xNL1FjRldo?=
 =?utf-8?B?TUxkcVZsdHgrWUZuelNoV2NGcUNwMnR6OGF2Zy9SZk04RFJlZDdaRUZMNDh0?=
 =?utf-8?B?eWZ5R0xJTDV6eE9OWWdZdUc2bTVxRjlBNXduZHFMT0xIclpqdXZ5M3VON3hC?=
 =?utf-8?B?VkFXN0RNMzVvQlB2MUZZcXN5WmRQcFN0WFhzMS9QNzNiMVpEWmc1Wjd2cGs4?=
 =?utf-8?B?Q1JyNG16emYyM0RpUzRRTVQ4WCtoN2JTUnd6NWg2TmpMOWMraE00MlM1aWpi?=
 =?utf-8?B?NklQY01odUdNaTRGb1FnaTR3MThiOU1RTExqeTAzTDBZRWx4ZkRNbzJWMDYv?=
 =?utf-8?B?dEVRWFhpQ2N2Um8wZm44UVlzdDN0Nm5STk1sUTRGSWVZN3VpcFhkZXVSeE5m?=
 =?utf-8?B?MGtUaTRLdU5xbFNNd2Fhb25GN1g0dG9rV1ZDNkhyWFhtWWRsNnpWWFJNdmdS?=
 =?utf-8?B?aWlKcDNQS3g4Qk1CTmNVYkNTR05mSGdTc0V4a3RWRGRXYkJtellySUFCY2Uw?=
 =?utf-8?B?alkrczJvL3hCclBDQ1RVUndLWW9YREtES2d3SDJReHBXZFRHOEkzemNGL2gz?=
 =?utf-8?B?ckorWEh0T3VoMFpOR2ZXYWlYcjhxcjRIVnV0cGtPcTNUcmFuaXBWNER6VnpF?=
 =?utf-8?B?WHVSNENtekRQU1JrRVNrTE4yWGRKejZ4eDZPZkgxTDhnTmpEVENmZnFPREtN?=
 =?utf-8?B?c0V1Q0ZMaDJWZDBsU2o0TnBQVW1uYXFRdnMvWUpJdXdtVVVUVXFEdW9WdHIz?=
 =?utf-8?B?bE1CTGl0cGQ1ZXdMZTFxbUZyREFDdWpkbDg1cTR0RXQrQ1FYM1F5NnJUR0Iy?=
 =?utf-8?B?VkY1NGpuSEFWa2ROemxmc3YxNTduQWJiYWc4RnBoTi9na3IrU050aHBpT2RP?=
 =?utf-8?B?dml6REJ4OFJzZlNIR1lFbnpSZmZuRkx6RUFvMURaalZlMzNtZWw3ZXh0b0Rt?=
 =?utf-8?B?cHFLdTJlRG5DVnZaTmpzYXBXelM2ejFqN3A2SCtTMVJYK0d4MG95T2Iydllx?=
 =?utf-8?B?ZmowTkJKekRlbXU3SmQ3UXFFa3BSNktHZ0JSNm5hQVd0NUdoSTQyTUhjbTVi?=
 =?utf-8?B?QXl5UTRKc0kwMkp4dFBYTncyendFbzNsbVppMHAzb1VsZFRCT0gvUlcrNjd1?=
 =?utf-8?Q?wOBrVncsiu2I52uKldT2Szs=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078bc141-1f8d-486f-7fd1-08dbd47c269e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 10:29:49.3542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKk+8OqTq6oTQcPxk0x8GI7ZCYJnHuD8jbh4E5oQp8JxStnGiwBZF8PyAP2ZOlzyobK+mG8LZYLOsxcFMKGYbrS3wrcAh7QUKEg6wFajLpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9883
Received-SPF: pass client-ip=40.107.8.92;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
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



On 10/21/23 12:40, Mike Maslenkin wrote:
> On Thu, Oct 19, 2023 at 4:06 PM Alexander Ivanov
> <alexander.ivanov@virtuozzo.com> wrote:
>> After used bitmap freeng s->used_bmap points to the freed memory. If we try
>> to free used bitmap one more time it leads to double free error.
>>
>> Set s->used_bmap to NULL to exclude double free error.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   block/parallels.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 6b46623241..ba1fdde259 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -244,6 +244,7 @@ static void parallels_free_used_bitmap(BlockDriverState *bs)
>>   {
>>       BDRVParallelsState *s = bs->opaque;
>>       s->used_bmap_size = 0;
>> +    s->used_bmap = NULL;
>>       g_free(s->used_bmap);
>>   }
> Shouldn't it be added after g_free() call?
OMG, of course.
>
> Regards,
> Mike.

-- 
Best regards,
Alexander Ivanov


