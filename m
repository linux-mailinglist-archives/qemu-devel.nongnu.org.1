Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2724B78D377
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFCj-0006ef-MY; Wed, 30 Aug 2023 03:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbFCa-0006YY-LZ
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:01:21 -0400
Received: from mail-co1nam11on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::627]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1qbFCX-0003Ty-6R
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:01:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKv+jiqtarO4UHa3Dtqn0hY13tbYjui1xZx3qRmRXOlyUMg56FMEITB5DhtM3n9ndpEMWlQt991eSlcserqpozDhy7gGKMcI28Nq9AtIK3FveNsN77dua6BhxtTMqILMm7xYKYvI33v1sgy0BFGzSXDjp6NDGJ6Icb07+pmBAkz7n7htSJn7fvhTOdgGtgdojdprK1db6E1JZzkrm22EIf9lqzexsuiLZljJ42tdDlfxPa6C+czj6yZn/s+gOI3plY0xnfNJ0P8zdS9eewu0t6lFQ3d4lQE4uvVXYoGoP1kkKhTMnKucGtqItkl/D8Iw8O2Iuri5lWExbV2LjZjteQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsTszG9HqkHShyXjMGX11VbKUfBiXw2u9OOMXoplHnU=;
 b=Ww4ejM0bApmV6g//iAr0eos8ZuiVY/KdNCcMiSZoGhluHjwZyIWxXm1c4MEfGEOP6AeQ2WllIeqqY6xadLK/4gToWTG5xCMnoOmQUg+7NWjtFyIxxS3+awmlS3f8MZxI9bSeUfC98EmELF2Kq/zoq8xcw6KRDKGwRH5Sz25f7zDs7YoKByqB2z+Yf4y9VM9AFDiIguyJbyy1z/nFDmP4vO8G49wv1AKhxbEORb5KAyjnZ1T1d1kQX3GvlHgVIOgh//JO7JqHfP20oypPUml9xMrOZwI+fh38Gv5T5CRQ4ig8Z0HdEvzsvFQqqPVv6J6apB4Q+++xfgfu5Ww0JdRN7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsTszG9HqkHShyXjMGX11VbKUfBiXw2u9OOMXoplHnU=;
 b=XhwBhZiGNECwuyq2kw9xQEK2TXiLQTQXA+bzTOiy9145Tt4zGS5WoLsIbbC5CcBLwe1ZhxpEQx/Oc9BPQkFaPIO7AMv2OAosfBRHxQ6ufeiwhzEU1WM1KHoFGmGVGBWI0U2xbisaIcgZOMzSsAhfb9U6HqLOqHEa6z/W/uOxy3GqovPp/ku+R/PRwq0zfcvNndqYf7PgcU6RfbAU1teviPDBhE6sDpKqmr/OIEA5eBIuB41f2wXgJobRwQf0uiL5pWA9ZYcxorawbtwYd1zkRbtSIkOfmymWjgbwp63j1I0CKzmE93cEJLvzv9oeHvDEJNuHpUE07wX99zpQyLxuDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 07:01:11 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::42fd:b1c0:838c:5f96%4]) with mapi id 15.20.6699.035; Wed, 30 Aug 2023
 07:01:11 +0000
Message-ID: <adb00739-3074-dc16-bb24-1e42cbbdd50a@nvidia.com>
Date: Wed, 30 Aug 2023 10:01:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 5/6] vfio/migration: Block VFIO migration with postcopy
 migration
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
References: <20230828151842.11303-1-avihaih@nvidia.com>
 <20230828151842.11303-6-avihaih@nvidia.com> <ZO4GTnuqSORbvePL@x1n>
 <b54f3ca5-9236-84a8-1b1f-9365925fa458@nvidia.com> <ZO44klknC6hpd7mf@x1n>
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ZO44klknC6hpd7mf@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0306.eurprd07.prod.outlook.com
 (2603:10a6:800:130::34) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f38b7df-0c53-46de-aaf2-08dba926e463
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6yPfHAbpZifLSYJrFOQh1kYFKYcCMAIEE0ESp2AWT+37S1bkXgah2y9lyNOwuaXCI01zpL2FvKK+QB81PK+r96uBO7tMHue/Y0/BeaY4uj/gXHri4hknBwpoIWxh/tZNd+h8QNV+g/PG6lOMALydBWM8iYlurcz3sJjRnVibsja91GGtGFLoUXTXQfWQJhwAj8auePHIIFQ+f3TXQ2/85GFiXKFyStZjQrdoyeZY6l7vMLd80714LBQspQ5KBS8qgU5PyRax5Kn5GKRMrzM/7IyNNJ/XNJozAhS4FL+zJ93yZukzC9uIjANKOLQE+1oyltTmc6HIrx631vS65iG1fOS/qOQ6pIgDY070kao3YA5W92awSo9L37YdR87OtIuH7FR2b3MPMXAYqON6mGac8QeKXu3vRtEXoqk+yi4atYixoyoG5ianUPeY4Wn9GrTlxu1Iqa5CnNu/puKEjDAy0XV91z7DbznvAJUIjnOuujkWudcMtm9tIyW869AWYVBq/hsMICdPGAbbqyNy6vz3YHYcratAV3MPPYpmR2x0DBH38UGa9PdtPOPSfmpJ+Jh12fIyULyoQLI7qsvfo3tksDvymqUKecntJKE6jOI6GZsqgvSSIcfzQ8aXw0/VZ6U6w4zgCB1tP3DZG7ZJIsDZ1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(346002)(136003)(396003)(186009)(1800799009)(451199024)(6512007)(6666004)(6486002)(6506007)(53546011)(83380400001)(2906002)(478600001)(26005)(6916009)(2616005)(316002)(54906003)(8936002)(4326008)(66946007)(41300700001)(8676002)(5660300002)(66476007)(36756003)(86362001)(31696002)(38100700002)(66556008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWYvQ2Z4R2NMTGtQejFEQ0NpOGs4U1FSdUVZOXdqK3ZreFdGWXRaU2FnVTlD?=
 =?utf-8?B?NHFrVWZvVm55WXlVRlBqWmlHYkZpUEk2MDdsY0ErVG9mMjM3RWtQNHR4cWds?=
 =?utf-8?B?UVpiZTF2U0I3M3hqVG1OTC9WTUUzSSt6Uzc4L05KV3ZiMUZtQUx4djdldXFM?=
 =?utf-8?B?czlvQktVaHBTazMwbDg2WDVyN3A0R2g5ZUcwUVN6RGw2VmszSkh6WGZkcXJT?=
 =?utf-8?B?K1g0bERKUzM0YXd0YU1PRmZCcEVyOXdQU3RHbFgybXZsKzFGZ1lJTllXZ2d0?=
 =?utf-8?B?UlFiaVljcTBWalFHYmdPUXk0VjlNQytiTlBXZ3JiV2hEWWMrQmhyYThBUVhu?=
 =?utf-8?B?YThUbWpTRVFZRjJ2UFllSnZ5YVlLMHBqRzdIK09LQ040V280UTV3WnUrNTJO?=
 =?utf-8?B?MkVxWkMxdlE4RXdLN3I2cTZKb2F5ekFjVEM5OWZ0TkpXOVNIRmNQSi9pOHFu?=
 =?utf-8?B?S0NmNHgvVFl1Q1diOWZWaXBMZFZSVXp3b0lNcnlFODQyVTg3Ulc3WVdCVFRQ?=
 =?utf-8?B?Sy9nVXBMbFRwempqUGtXK0dXdVdFZUpSUVhleS96VkZvYkdkTzFVTmhNUVJR?=
 =?utf-8?B?QWYvblAySnZCOCtubnlHOTdKR1dhSkRJQnF2Z0NkUzBub3MySkxrTENBWkZN?=
 =?utf-8?B?S0hreEppUVlKSE9WcGhUL3grSHBBdHlZMGlLdDR1UkZzL0FIRzUvcGc3QVI3?=
 =?utf-8?B?Q1daeE1nNVArcGt4NlhMY2E5L3lTSytrbUFBV0FNZW1iOGd2RGErMC9EQjU1?=
 =?utf-8?B?bFZnd1BqdlVLWDJGWk1oZHk3Ujg3Y0syK1NUdU1Cb0hPYkg4TzgxYXpBWWsr?=
 =?utf-8?B?OUlvSFJMNXZnUDN3d2EzK3ViWWYyWW9JZm1UYjRNbHdWUzM1a09xTzBSWXQy?=
 =?utf-8?B?Ulc4S2lCcVJraVFYMDkwWitQbFdXdmpPUzNRTkphTzhpKytxMExOd3dTZUJY?=
 =?utf-8?B?NWFKa013UkJ1ZU1nakw3bHF1b1FUaHhRdzBwcjNxblVGelNQdnlWb2NxbVhO?=
 =?utf-8?B?UVZ5WitaWHRDanI0b1NtTFlibnFaN0lIOUFEYWJEc3FiUmdHOGlOZm5sVmJZ?=
 =?utf-8?B?R1JRbzV5cEFTTXJUeXJZbXhhUmIvVjFXa3lidkdkLzNBWEVqdHg0bnRRNzhl?=
 =?utf-8?B?NUxjUGhJYkViQnNXYWljaEkzR3lkbTlqTEJuR3JGTXdGV2tlWXlkKzIwN1U5?=
 =?utf-8?B?d2JyV0lFNGVCYzNncEJ6dmxOcUdwS1VuTUdPUzBIS3JiN2orMFFmTDc3VktK?=
 =?utf-8?B?MlRweHdsdzM0Q1R4cGE4bE10WHJ4REIrMGtjN09pQjZka3RPSXNnTTRlSjNj?=
 =?utf-8?B?UUwvV2NVSjlHOHFFQktUUlZ2dlluR2FpL09meGp5a202aHpYYkpJNmpFSk1P?=
 =?utf-8?B?SkVvOWRXRXV0YmsrRkVXR3NOV3R2U1ZDWkdlS2tPa0xJdk1UbzAwWWdRK0g2?=
 =?utf-8?B?ajZWVkdMVzNXNTZuVU4yRDNQTEJzcmJOM0FNM2QvWUVBZkRabm1PU3B1TlRJ?=
 =?utf-8?B?TXBJRGxOUTJTVnB6alRGMEllWGlJK00yOThZQ2JBNEJIMHk5OXdXTXUweFBa?=
 =?utf-8?B?akVKVVNhSVZTY3VtVk5Lb3c5K0pPQUd4NW5yZHpxU1R5ZEFONU4yT2dkRWEw?=
 =?utf-8?B?Ym9rdm9NTmxrZ1lDblZRRy9oeVlKY1FsMy9NN3lDY3NXczQvcTJxTk5JenJr?=
 =?utf-8?B?RFFCNlQ3am1CNElUeVVIb3BkTU9xalF5bW5GQTFTS1k2ak9OK2hZSkNZNzRs?=
 =?utf-8?B?R2JBcGhZQTAzSmVFZjZTUUlEU3RETU1VUmg4ek95eTYxd3k3RWxieGM3MFlq?=
 =?utf-8?B?RUJvTkd5cHR2blFiTGorNUJTTXFHMzNDWHNZemh5YWRKa2Fmdk1KaFBVTnhw?=
 =?utf-8?B?cnZWOGd3cnR1a1kyQW10K0FIMFJLb01aZkFwalhncENoODQ2aHg3NjVuZ0JL?=
 =?utf-8?B?WHFuSDEyb1hqdWV6MFZEb2IrVnpTL2U3TkhMbGMvakMxZjY4N29ES3pNWTZk?=
 =?utf-8?B?aTZ2SllId1BybjQ5K2ZtOGRoQklQQm9DYVFFMUt3dHE1SkgxcnpSVjZDeW8w?=
 =?utf-8?B?ZVh5S0tjTFdqSFI4cVBudmEwZmpGVzdLYnJWeThkTm9Zb0p3Sk42Zzdydm1P?=
 =?utf-8?Q?U5MaDQa1GdaJewa7xCoWsQlj9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f38b7df-0c53-46de-aaf2-08dba926e463
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 07:01:11.1368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iAxFm/ALXI/4K0ehaeAOE5y7tHFtLYXnA27OUshSKPdiqsPzG+vbikSqs6N2176JLM0GyVGUUBc7iOk1cHGHkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
Received-SPF: softfail client-ip=2a01:111:f400:7eab::627;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, SPF_HELO_PASS=-0.001,
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


On 29/08/2023 21:27, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Tue, Aug 29, 2023 at 07:20:47PM +0300, Avihai Horon wrote:
>> On 29/08/2023 17:53, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Mon, Aug 28, 2023 at 06:18:41PM +0300, Avihai Horon wrote:
>>>> diff --git a/migration/options.c b/migration/options.c
>>>> index 1d1e1321b0..e201053563 100644
>>>> --- a/migration/options.c
>>>> +++ b/migration/options.c
>>>> @@ -499,6 +499,11 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>>>>                error_setg(errp, "Postcopy is not yet compatible with multifd");
>>>>                return false;
>>>>            }
>>>> +
>>>> +        if (migration_vfio_mig_active()) {
>>>> +            error_setg(errp, "Postcopy is not compatible with VFIO migration");
>>>> +            return false;
>>>> +        }
>>> Hmm.. this will add yet another vfio hard-coded line into migration/..
>>>
>>> What will happen if the vfio device is hot plugged after enabling
>>> postcopy-ram here?
>> In that case a migration blocker will be added.
>>
>>> Is it possible to do it in a generic way?
>> What comes to my mind is to let devices register a handler for a "caps
>> change" notification and allow them to object.
>> But maybe that's a bit of an overkill.
> This one also sounds better than hard-codes to me.
>
>>> I was thinking the only unified place to do such check is when migration
>>> starts, as long as we switch to SETUP all caps are locked and doesn't allow
>>> any change until it finishes or fails.
>>>
>>> So, can we do this check inside vfio_save_setup(), allow vfio_save_setup()
>>> to fail the whole migration early?  For example, maybe we should have an
>>> Error** passed in, then if it fails it calls migrate_set_error, so
>>> reflected in query-migrate later too.
>> Yes, I think this could work and it will simplify things because we could
>> also drop the VFIO migration blockers code.
>> The downside is that the user will know migration is blocked only when he
>> tries to migrate, and migrate_caps_check() will not block setting postcopy
>> when a VFIO device is already attached.
>> I don't have a strong opinion here, so if it's fine by you and everyone
>> else, I could change that to what you suggested.
> Failing later would be fine in this case to me; my expectation is VFIO
> users should be advanced already anyway (as the whole solution is still
> pretty involved comparing to a generic VM migration) and shouldn't try to
> trigger that at all in real life.  IOW I'd expect this check will be there
> just for sanity, rather than being relied on to let people be aware of it
> by the error message.

Yes, I agree with you.

>
> Meanwhile the blocker + caps check is slightly complicated to me to guard
> both sides.  So I'd vote for failing at the QMP command.  But we can wait
> and see whether there's other votes.

Sure.
So I will do the checking in vfio_save_setup(), unless someone else has 
a better idea.

Thanks.


