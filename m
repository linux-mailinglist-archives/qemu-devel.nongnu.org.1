Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C89478BEEB
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 09:05:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaslw-0006Yt-MS; Tue, 29 Aug 2023 03:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qaslt-0006YS-NP; Tue, 29 Aug 2023 03:04:17 -0400
Received: from mail-vi1eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f400:fe16::713]
 helo=EUR02-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1qaslq-0004f2-Om; Tue, 29 Aug 2023 03:04:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BB3MWcuKJIOsCxfK+jM1ef2Wsg9u+VWd2gWeanTz7iTt9AnMgIJXWXX5wRjIa9A7+J8NPFjob+D6e0c4yeySXXg7+Zb6iKzw4ATJJL1EJjNfthnBBXnB4v42Xl9AqJ4RmeKMv5QN8H/hl+mthICVfJfSLOsuWX+2eyhGNygwx/tIqIBtmhowb2z5vOqJdwOvA6qQh0Ot4SkBSMN3HzNUT4U1u0nV/Nj/xXG1eO9QM2b9YPX9Yeoml4xjQ86NQbiQcl1YzMThV+3Pr3QiPmvMdNd39jtBVDO7njjczs02d48dxHIBV3TiYVZS5ZcNOPrQhQ6By/aZd8bJJGgfWVhduA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiABjSpIiiZFmyvVi8Id3MlTP+itn4BSeCfxs3SpbT8=;
 b=QzCO3WrNK5B1z0+c+itXR9lS94ePba6u000moa14Vc7APFOLc12D2g96Ypm57A1Z9TugHwvctulJluk6jSKbzNgPngXlbC3Yelmbuf8ihbaRHocNQTeWmZIXU8TsVP1+xbnekdf7T1Lkfebt6a2+0BiD28/0bVr6PPsGUpvxzUNpRUJTDkSu62Xc0XeCbVU/hjQYYj5HfRyzMdHUj6zvSZgn4VhIGTsp+ndNXiMIaY0H5NXPj9Nih+aHx8is71ydrpPrNpuBoGG46uEst837Zyxts5tnoskBYuJ86y/RUpzbG/GdxGeNsgq1i1L+aFXlWu3bBq/a05DnvvT3y+kb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiABjSpIiiZFmyvVi8Id3MlTP+itn4BSeCfxs3SpbT8=;
 b=oW/tz13CDDkfHauj0fuO+7XkaO5N+mvaPP0MgrnqcWub5xwcXZcbp4OiT/PLA9x8gCvjBKgvog9bUIan4oxAe9yCGT5UinB6AWk3SWTZ+HEly8j0hmA17zLtZj6C9QXikQU1izEda+ObEiJ0+wqjgCWjMsIdrD3HH4dJskOG6xH4X5c1kDsH0jH7TE/VD4djxQ3sKvnIpVVyga2BtWm68zEmwwQsdQpBF5oet51QkrXa/O7OPUxRKwQQYCPrK1sdHlZZkb3q8sylyH0MVE3Q05ASe3D4e0Tkxi3jXL3Nv49ROGhtSEykfLyZlb7tR8Bmc8zDddLmS1f0oZdBMFljvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com (2603:10a6:205:e::33)
 by DB4PR08MB8151.eurprd08.prod.outlook.com (2603:10a6:10:381::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Tue, 29 Aug
 2023 07:04:09 +0000
Received: from AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28]) by AM4PR08MB2932.eurprd08.prod.outlook.com
 ([fe80::4b14:4628:9a1c:b28%5]) with mapi id 15.20.6699.034; Tue, 29 Aug 2023
 07:04:09 +0000
Message-ID: <38eafe9c-e213-400c-8130-5b30539f5841@virtuozzo.com>
Date: Tue, 29 Aug 2023 10:06:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] qemu-img: rebase: use backing files' BlockBackend for
 buffer alignment
Content-Language: en-US
To: Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-4-andrey.drobyshev@virtuozzo.com>
 <c348e12f-4667-3459-ef2c-86b514456132@redhat.com>
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <c348e12f-4667-3459-ef2c-86b514456132@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM4PR08MB2932.eurprd08.prod.outlook.com
 (2603:10a6:205:e::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PR08MB2932:EE_|DB4PR08MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: ac619ec2-9697-455f-1039-08dba85e2471
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2m7mloqZqd24H6l8HnDkcrhkCF4G5GQSW75iXa8c2MDDQTndV5X9USFxH1aMEUte+CTKwlDTeZVqMNHQnlLu8T2Si4hlrNSPUcmibyrJk6UVsCoIANJU+kjVAxmu2bGir77NoiNocRdasMBedwuMs2uhNv8v0Cy6a2GdBc3Jjx/zrNmvy5vEw0y49RQONJ04zyBoN8qihn6a75MUzYt8QFEerFRgwafzXFYZhAg36AYMk2aHWYFPiVFN2tgOjoze63OIsTasPpJwao/GmHachE/pdbOv7nrfDEnjBIzh8eBrKtjjOQ0wiwHBFnRpgXOz868Yy4jMizJDIIsQO4M6AbJxbCAw+1Rd0+IKY9objNoS9GoLpDOyTS5eaGPg+XhqufWW4vUMGBcRAxpCpTSHib3UqfsZjl2qzk07LXurMKfQ7uhU/dFwzGXjJG14hT8ZmZitP11WF/QckZkE5XoV7KzmBtXMrKjaC56XH5DvTw0axZj2AnUphgDfwNIuhLFyuJO3wvEAnXu6ez7TjDBDCzOEw6O2wqWkbynGou+WjCL+nl+/+KWcr1ZRU0ryq/MwZWpGSrlp15rUlFJOa/DTtXiYJkXBcQg59ppvi+6OVa/T5sNhZ3alFz85GWPsPY3nZJpbfcygy/lQuz2oD9R4qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM4PR08MB2932.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39850400004)(451199024)(1800799009)(186009)(8936002)(6666004)(53546011)(31686004)(478600001)(66946007)(6506007)(66476007)(66556008)(6486002)(316002)(38100700002)(41300700001)(6512007)(36756003)(26005)(44832011)(8676002)(5660300002)(83380400001)(31696002)(2906002)(107886003)(2616005)(86362001)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d21tTnhtQzA4V2lpcS83SHl2NXo4L1Q1a2R1dFBjQk9ocmQ0WmxZYXdvTC9y?=
 =?utf-8?B?QlorbGlvZEhXSjl1b0NjOFU3ZENseFJndkM1VXQ5RFp1TFFoTGdiMXlzS1pa?=
 =?utf-8?B?cGF1RnlpM1daZEFRUmhSS2VhT2xjTEJOU2VhMkdtaHFtRHZUNkliVER3cnZU?=
 =?utf-8?B?cDVRZnV4M3JoZEEvdTNuUWdoQWFPVFAvNFFWU3NxSVJjUis4RmZOdUZOU3RW?=
 =?utf-8?B?Wnp3VXhDVm5BT3F6TWtFUURBODVvcXZLbGhKanpwRHNJcUlKWXA5VVEvNWxa?=
 =?utf-8?B?Q1VCMVVscHhpay9vT2w2N0RUdFhwTVRnTE82eW43eENYWU1IV0lYcGQ5eDg1?=
 =?utf-8?B?QisyMEN3dnJpcUt3K1YwNnVtamtoL01zRG5OUkdhMHBTeGhSZlNTMVY5Rk1X?=
 =?utf-8?B?alVES1dFMDRJUE9ENG9vWHJPRncxK2VCQUtDMGRHNnJUMDBjVVJKVjlyaTJV?=
 =?utf-8?B?dkVBa3VSVUhnV2tVRVVqRXQ4QkFEUjAyNS9GMUU5V3J5UVl5c0Rjb00xaXdO?=
 =?utf-8?B?VnczeFZlRVpZK0szNmNhNnM2WEtHMGR5Zm1iSXVDSkdOSjlHOWRPZHZuTnBL?=
 =?utf-8?B?R3d5SzZxbjlhYUZGRXFqd0dvNGF3aVdFcTkwSTlPS01PZWF1cUpSM1NrSVln?=
 =?utf-8?B?Mmw2R08vbmdNd3NHTTl3QWdtaUIrUm10d1hkSnZuQnhuaUxSZDlETVZ2UThD?=
 =?utf-8?B?S3BqYWJIZjZsWnF1WVQ2VHJQMkdKa3BOWTFkaDY3U0J3eEZyVWpIV2pHeURM?=
 =?utf-8?B?bTZibDBoUXVpUWVGQkZRN0JiNlcyVXF2bnpsSFZWNWVxVlY4T2lxSEU5UFFV?=
 =?utf-8?B?TlRsUStHZDRpVUl6bjJTZWpFMitjUXJXSmt5Zm4vMzRrU3VkMWdRTXgrcFc4?=
 =?utf-8?B?aDJpaXV5TjdJcnJrYnVqeDJoaHNGeFNuaU51MDdMUktoRUNQeDhReiszaURv?=
 =?utf-8?B?QzA3algrK0l6V2ZiMnphcmlGWmVaZVBHVFJMZnJtVkVBaXlKdUY4RmRPdWZN?=
 =?utf-8?B?SjdpYnVuMWN4cHpFMVQ2Tzd2WkVPdGpKT3Y2T28yZXgzRitST0ZLTlJLS2c4?=
 =?utf-8?B?OHVjRWtkakFsZzJGUGxCTjA5QkhKQVBqTklmWTdsZW9FbUZMUTJvUGdiejB2?=
 =?utf-8?B?eGYrZjRLbmxzbDJ6UlR1cDBtdGRpUHVxRG1oc3RLUG1majV2Ky9TVXJIRFBH?=
 =?utf-8?B?MW41ZWJncnhSaXBud0tGMkdlVjNid2lmdGJTV3JscUt4SVEwNE1SNGloZXlN?=
 =?utf-8?B?VndRbWtlR0Vmdk8reE0xaHJORXpXZTQ3M0c3aG4vbm5EQzdaSzk5ZFJlTjkz?=
 =?utf-8?B?OVNxcVZhazdrQmozMXVEZ0R1VzhvcU9qcXhYMGlQT01VcDdqRHpXME1pd0hq?=
 =?utf-8?B?ZTJyQ3kwbHZYMzcySXhHV2tTcTVqVE9XVmZYVlpFRjRNVE41S25SS3REaStC?=
 =?utf-8?B?Wm9aQ3ZpZzd1c2IwNXFnUEt2YTlpOHFBd082V1RaLy95eGZVUU80VVNNUk5n?=
 =?utf-8?B?clg3K1JReitaejBQNDdPTmRLczFDOThuenpXYytVRXdjaE1yL1c2b2xEalU0?=
 =?utf-8?B?eUNPM0hIbysrZ2tmdkNkU1Q2M0RwZ1JpTVFoRDVTOVFpQUNqS2d4eVNkQmdl?=
 =?utf-8?B?aU9lN2VFRW5ka3RSL2tCRGtsWHM2bTVoOWh4SUk3TGsweGQ2WjMxUmU1Tm5M?=
 =?utf-8?B?Yi9JK2FaK1JEdjE3QkgrZGRPZ3FnN25mK0pCcUxBc1R0Z1c1M3RSeUFsV2pU?=
 =?utf-8?B?Y1VoMDl3Nnh5MzFhRzBnMXhaSzROQ2daNzd1YVp0bEpIYjl3K1ZlY01PRytY?=
 =?utf-8?B?QkZDcHBJRXh5OVhSY2J1ZkNvcThONXNBQUFVSHBhajMzWFIzL3k1bytUZGF0?=
 =?utf-8?B?bDVIcHZHUk5pa3VTWEZOT0FaZ0Q4Q3U1OTFMUUF0MkFQMU5rdXJkY1p4THBS?=
 =?utf-8?B?QzE3dE9PTTQyeDdBSzJ5T3hDS3ZaZHdLUmt5OXlGVVNmMkpJNGg3SVlZb2pU?=
 =?utf-8?B?UTBNZXhjL0FWaWRpQml2aU50ZGZhdVRLTUZNQnZvTDVGdk0xSEhMRFVsQlF2?=
 =?utf-8?B?b2lGN1dhSTVYRjhwa1p2Q2RrYXI4L2ZhdmhiR21yNTltMitQOVZUUG5lUkNT?=
 =?utf-8?B?N0N2SFBHU0JSSzRLa2E2cVppMmh6MkpzazBGREoxbENxYXNqa3RwVTh2aTFT?=
 =?utf-8?Q?vqgU+tYIoa4L16NstVD7r4g=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac619ec2-9697-455f-1039-08dba85e2471
X-MS-Exchange-CrossTenant-AuthSource: AM4PR08MB2932.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 07:04:09.6343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rz2GWuNQzF0o7gr9pt+7rNA9ALhq1IQMz9krVjw+la3Yj8j2ln6b5AEBJ37bIXbUxGy7QL0uHlEZkk5NzkUGGD74ohIqvuw9Hv7Q0X61QoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8151
Received-SPF: pass client-ip=2a01:111:f400:fe16::713;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR02-VI1-obe.outbound.protection.outlook.com
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

On 8/25/23 17:29, Hanna Czenczek wrote:
> On 01.06.23 21:28, Andrey Drobyshev via wrote:
>> Since commit bb1c05973cf ("qemu-img: Use qemu_blockalign"), buffers for
>> the data read from the old and new backing files are aligned using
>> BlockDriverState (or BlockBackend later on) referring to the target
>> image.
>> However, this isn't quite right, because target image is only being
>> written to and has nothing to do with those buffers.  Let's fix that.
> 
> I don’t understand.  The write to the target image does use one of those
> buffers (buf_old, specifically).
> 
> This change is correct for buf_new/blk_new_backing, but for buf_old, in
> theory, we need a buffer that fulfills both the alignment requirements
> of blk and blk_old_backing.  (Not that this patch really makes the
> situation worse for buf_old.)
> 
> Hanna
> 

Hmm, you're right.  In which case the right thing to do would probably
be smth like:

>          float local_progress = 0;
>  
> -        buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> -        buf_new = blk_blockalign(blk, IO_BUF_SIZE);
> +        if (bdrv_opt_mem_align(blk_bs(blk)) >
> +            bdrv_opt_mem_align(blk_bs(blk_old_backing))) {
> +            buf_old = blk_blockalign(blk, IO_BUF_SIZE);
> +        } else {
> +            buf_old = blk_blockalign(blk_old_backing, IO_BUF_SIZE);
> +        }
> +        buf_new = blk_blockalign(blk_new_backing, IO_BUF_SIZE);
>  
>          size = blk_getlength(blk);

I'll include this in v2 if you don't have any objections.

