Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D177A50F3
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI1B-00056F-I5; Mon, 18 Sep 2023 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qiI19-00055q-DA
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:26:39 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1qiI16-0004D4-P5
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695057996; x=1726593996;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=G6BWcGKhGvSSpYKe5kVzT5r75O6ImyJyY0sQipMZdB8=;
 b=Al2uPzcEZYkA1sNkj8x0T/dh8BSXbM66nv35pI9/x8k8PLqDkxGV20u5
 lVkv93hs12A9J+wgV34oaXRTxW7FVDN0HSRg/PL4JSqjxAy5R63FRokeG
 yis5L1D8cyW1BrLrN5uxeY9dPs6WZX4aknTv8kTv3ELJch0OcyFWttMG9
 CPNgvq1VERUyBc/ZbZarIRM0o5B4hscWUc5SHkJKHstSDwqxJ7Szup1EB
 Ic6mFFvPTBKQYySRhB6ZdlxlIUneE+ZD/84kJKdZlWv51I/JRRIfDt2qH
 fUN3nfBidP8eR7MPTqWDjfeRZijLA3EztDN5VVlLyP0ChTMqvsYchmC/8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="359976099"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; d="scan'208";a="359976099"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 10:26:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="780983774"
X-IronPort-AV: E=Sophos;i="6.02,157,1688454000"; d="scan'208";a="780983774"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Sep 2023 10:26:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:26:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 10:26:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 10:26:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 10:26:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DabeaGGRBclzYdkr3hSdU/21gtvSe2y+SCSS0ZtFLHg3iTaB8Lg1GBXfdhCg8qvmHBsV1pLeQsBG0wb201/kaKehsHfLj6hi+rcmKUFbL4gIvjyIcWv3Gh4XScrQdR1ZAYyJJkskqIrhqYgf9UIcj8EYiOZNhI2ngxrcK5DkDlXvodmwEqfudmVjR0smEkhlVrsn6FBzdJxm52S35/X+/5Al8UTYxDgDmeN1gBxXy17QfDUxQihZaUwUnKLXhjTiRejiRXCXVjJyA7P922lTFE72Hbf9UKRc0rZzpbkff2HjRw/lg223bnzs3lBa7swVjJut4/Nt54B27KFmhUTwXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tylbnkxc5++am5jlUziUweQCOVJ/H+MXPQGO1gj+13c=;
 b=LE+aV2o8Ig3kmd+xHQahJCbn8Fx7jyPSoD85QTHuqoWtrNx/gZUiDkJudI3htxi2yD32lvFWgG5YkCRilwmwXV4naJxqSWKTP3cw+W5fZcQQe+U9fuLEIOr7Iw0a7nLSJU/OhkvNb7+Nh8PmQlWhfmxDPvyFv7iJBI/+KpaYq8aKE9AJeOcxUWO657+XIZk1pGwnBkm4uxtD9Zar6MI1nVXgYoF8zwXrE9cfPjEi1eKZUq25z4SzWETf3q4to9g7/cZNeGtgHMFJBgpkUbxR5huyduYiCL/BifxXDNth8EyCs8CZ1EyL3r3GTulL+qn2KrLxz0jGRm2ygCL98TZMRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 17:26:24 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6792.024; Mon, 18 Sep 2023
 17:26:23 +0000
Message-ID: <5083ba81-f74d-3698-6418-72d288917df5@intel.com>
Date: Mon, 18 Sep 2023 10:26:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 2/3] hw/mem/cxl_type3: Add missing copyright and license
 notice
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>
CC: Michael Tokarev <mjt@tls.msk.ru>, <qemu-devel@nongnu.org>, Michael Tsirkin
 <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 <linuxarm@huawei.com>, Yuquan Wang <wangyuquan1236@phytium.com.cn>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
 <dan.j.williams@intel.com>
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-3-Jonathan.Cameron@huawei.com>
 <CAFEAcA_7-uq8LJO6-myGU1+qjErxZAWE+CMjqyJBph6Du9K0iA@mail.gmail.com>
 <20230918180013.000035cf@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230918180013.000035cf@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0055.namprd11.prod.outlook.com
 (2603:10b6:a03:80::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MN6PR11MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: c6af19f5-fae9-4355-0eb4-08dbb86c618c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JJfYWzGH0opXx/5gWDTJbchDqQFQG5yNRxeAYLl9dmcyMaHBi+bsSYsDFeYXzXTCHqw2cy3OUokUT0uuzNY6/H89cRNWLpeXioMvfbkL4gomUxMpteeUxtO1mbA9r+gR/7pqsN1LjzqVCyEHLHryks6HxyghAfJE1Qa/wICx7Xw6hSxAjMC7ewmrEIKiLIohBambVvVi4CGr0i60/SjO7PU+ZxdfK77+9BSHPKqf8ETpY7bx9W/CCYy6FM9c+9IgxlAUs8hEeMcfN7ObUlZGReFVmQ+JlLjVBk44oEFja5sRls8NsCR5mLLz4oi437mJ55MJg1FNoNEfqSiYhZ0SxLKnNcUbD7djLs57oM4QhjJgBRi5zSh5hnoI0MJPq2+ATeTZF3QnFtsu8Hmrujo6P1J9CDCAQjLfXoZO/MTYKwL0WmcnVtyBLMURO2dBszprCgMG4XMMHS+W8qM159zCf7yx1o7ev83Br5QAqNpGvrF8yn5zTfquxEk42QJKNYPWtFAs2JN4v11hhFCwbeJzwsSeVDq7PWkT8ZLqSC/HcHzib7yDlJGYwNtqTQKBqgZ/RGZCMnOKw2F9PMEZgHxUUIxvGdc4um3psWRlw6SW/ER43v00PBnxYCjoCXHrPiTUZU/TiENQ7sMq1p3X2eQQug==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5984.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(186009)(1800799009)(451199024)(316002)(66899024)(8936002)(4326008)(8676002)(41300700001)(107886003)(26005)(2616005)(6512007)(478600001)(53546011)(36756003)(6486002)(6506007)(6666004)(82960400001)(31696002)(86362001)(38100700002)(110136005)(66556008)(66946007)(66476007)(54906003)(2906002)(31686004)(5660300002)(44832011)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3ZOS01CTk1DeHh0dy9uMFkvM0V2ZEUvREM5MTMrYzlUcEIreGZLNlh6aEdU?=
 =?utf-8?B?elBzS1o1TGxaekV4WElDRnpxWncyZ0VVWEFzQ1p0d1ZiYmJ4THk1amRkNDdQ?=
 =?utf-8?B?OGc5eEJxbUVhVzRieDVhcEFGaDc5SGhBc0xSMkdVb2xLeW9XWHlkMDlVL3do?=
 =?utf-8?B?WHBTM09UQ2l4SEFsNW5KYjdNOTJpdmpkcmg1bUZHcm1EL055dDhITVBHdGUr?=
 =?utf-8?B?TmlYV3BnRVdWOEJxekdSQnRYZG9VWGtIM0N0bFFJeDdQUGJybW1yaTJXa2Fo?=
 =?utf-8?B?dnUrTVFVZUNGaUZ4TGhPVEVzODlodkN1eWpRVGNVS2labVRuL1RnZjhTUWlm?=
 =?utf-8?B?MGNZK2ZvQlNUVEpxTVZyNm9tellIMllSREhMd1h1NFdkcWtXcHQ3Qjd6d010?=
 =?utf-8?B?UFloYVdVNExjYUFOUmhjbVZ0bHpwVVhWZVZxN1dOMFZ5Wis5VWVSOUFidnhq?=
 =?utf-8?B?MVErcUJld2dIbXZ1aXFEd0tMNVptcitoRDFXc0tMQXg0L1MzOWl0TEo4Z3Ux?=
 =?utf-8?B?QVQzWk15OGpFSzFvTldiYUNLOFdQeFZBZ2E4dktEZ3hLdHVWNjB5ekR4MUtL?=
 =?utf-8?B?WXdBa3MwUHBsR2ZvR0x4djJZNndMNHRuZll0SlE1a2hXQXBSY0d2cFRCOHVo?=
 =?utf-8?B?NE9kT1ppL3BIS21kMElkZTlyNnNlTnQzbU5ORnIvdlNtTkcwbEdWMG92S25U?=
 =?utf-8?B?VnZBZUtnYnB0YXNmekUyK2x5alIyUWVHbTNnYXJaNEpRVnU1cXdlWVBFN0NE?=
 =?utf-8?B?empPWDc4MGJEbHdPanl4L1ZCR20zaTJiRjRGN0JFMFh3cmE0YWZibUpOQ2xi?=
 =?utf-8?B?RExlNWpvdDQvckNOK2IwTDIwaWRDclk5UWVvc1Y2eTFUMzJ0bFg2aHR6bkxa?=
 =?utf-8?B?OHZLR0NDdmdvcXpQa3Q5QWhHUDVIMldGY09mYW5uRDZ5ZytlNGN1L3JOcGRF?=
 =?utf-8?B?N1ZQcHcxUzM2SEdDUWFGejdvSHpBR3JCRmdSS0tRL3E3aEpxTS8zOWNrdmJJ?=
 =?utf-8?B?d3Q3VVR0dU1JRncvMnU5SWtHcU1YRWJwOVZZenU1UFAxeWlBK3hvdWdyeFky?=
 =?utf-8?B?VzhQc3pIQzBDdCt2UVhaVElCU2xzeFdkSm9NWUo5TS9lM2Q5M1VoNWxyaDhQ?=
 =?utf-8?B?ZWlyYmhUR0xmWnBmS3NkMlZTZmg1endrWWpzQnc0VXhlcTNkalhSc2dQRWRJ?=
 =?utf-8?B?WVVGNUhzZ1RldHhtWHdkWS8wWk5SbXlmZ0E2QkN1cFdRNzB3UC9KZnFqcW5q?=
 =?utf-8?B?RzZTUTBNUHV6WUFoUnFUSXdmTVovSEZoaCszNVRwaEJXdEFSZnFDZ1RDQTJi?=
 =?utf-8?B?SHhOTXlYV1FkQVVCa3JxYXlwdkpKdDVZRW8zUWdvYVR4MXlQaGJ6VHY4a2Z0?=
 =?utf-8?B?RDVZVGZEOGh3U3hoOFlOU0lLS004cHQwdXlnVTZYZUhIQjU3KzNRL2M1b3BW?=
 =?utf-8?B?Q1dBRWdtOG1xUHJOYTl3R1NPWUtHMTBNN2tGaDZtYmVyOC9zOUw5OXE1aXN3?=
 =?utf-8?B?SzFSNnlwSXhIS1haV2FZWjBrelk3NW9NbTVUZm5SbDYzcXdIVTNEUW45am81?=
 =?utf-8?B?UVpObnU1d3psU2l4SHhJb1pwNUl5VTZNZEk3dUFoUzZPSlZxN3l2RldoN3pi?=
 =?utf-8?B?anl0NDZBV2VOeE1oVjJxV1ZDckdKbHVtVUEvZWlucjNsNGI1Z3U2ZERHM0ph?=
 =?utf-8?B?T3l3Qnd3OW1MN0NWbldjRDZabktEUisvZ1ZrQmRBaTQwUGxVZWZVS2FTZnRR?=
 =?utf-8?B?bk9GVnF3a1l1bnNMN2xiWC9aZE5xYStLY0JISUE5QWxsWU14RzZ2QzA5eDJS?=
 =?utf-8?B?Vmg3U0RuRExZZXY0VExyd01Fcm9tV3I1U3doVXhRUHVRMkF1ajVYZWVWWC9j?=
 =?utf-8?B?YVE0a2grdlZHZnBscHBmdWc4OW5tTHF0bm1PcERkTWpDYnU1OFQ4SzMxKzZ2?=
 =?utf-8?B?M2VJVENaWEtmaFJhcGZneWo0THFyd2hrNnpzMVNXaVFKYWpyOU5lSVo2Zm1r?=
 =?utf-8?B?cGpsb3poM1pwVXhvczY5RjNjN0tLZW8yNE5nU0xnMmp0YWpLQ2RiendrM25i?=
 =?utf-8?B?NThOWTQwcmdpVzhVZVI0OEwwWmV2eU4reFRIUFFoQ1V6U0phTG5RajhvSk9F?=
 =?utf-8?Q?B5en9gAYC8kiQA1YlOMJ3BB57?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6af19f5-fae9-4355-0eb4-08dbb86c618c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:26:23.7608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pO0ivURkt6SV+SCZDjF7SIsUGUD8llgp8LED9PndyfZPTcUAOdOkZvNl/nuD7etPB2NqNzaXThzWL8KADuldBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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



On 9/18/23 10:00, Jonathan Cameron wrote:
> On Mon, 18 Sep 2023 17:31:38 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
> 
>> On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>>
>>> This has been missing from the start. Assume it should match
>>> with cxl/cxl-component-utils.c as both were part of early
>>> postings from Ben.  
>>
>> Sounds plausible -- is there an Intel person who could give us
>> an acked-by for this?
>>
>> (Ideally we wouldn't have let more gpl-2-only code into the
>> codebase without a rationale...)
>>
> 
> I've +CC'd the kernel CXL maintainers from Intel a few of whom
> have also contributed some of the QEMU CXL code.
> Hopefully someone can ack.

I see that nvdimm.c from Intel is under LGPL 2.1. What is the typical license this should be applied for QEMU?

> 
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>>  hw/mem/cxl_type3.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
>>> index c5855d4e7d..ad3f0f6a9d 100644
>>> --- a/hw/mem/cxl_type3.c
>>> +++ b/hw/mem/cxl_type3.c
>>> @@ -1,3 +1,12 @@
>>> +/*
>>> + * CXL Type 3 (memory expander) device
>>> + *
>>> + * Copyright(C) 2020 Intel Corporation.
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2. See the
>>> + * COPYING file in the top-level directory.
>>> + */
>>> +
>>>  #include "qemu/osdep.h"
>>>  #include "qemu/units.h"
>>>  #include "qemu/error-report.h"  
>>
>> -- PMM
>>
> 

