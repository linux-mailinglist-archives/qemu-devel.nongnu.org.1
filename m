Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1D57172C3
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 02:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4A6i-00088Y-Tq; Tue, 30 May 2023 20:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4A6g-00088J-GV
 for qemu-devel@nongnu.org; Tue, 30 May 2023 20:54:30 -0400
Received: from mga09.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4A6d-0000nG-VW
 for qemu-devel@nongnu.org; Tue, 30 May 2023 20:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685494468; x=1717030468;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FKFzZBJ601UxiA6spv80H6fSzNVifYJ96pUiLkPo3as=;
 b=EUuEw9lBzU62vuuQb/mbD5wnLu0KnORANX4ecWD9jpdmHAsJEg6T6pn8
 4ldWjSM1lsvzUpQC/fKAnnrENl3zBAh5BeoWefQuzqEssDBNQs4/ls9u/
 wKbuG1M/obzwl4PB/NDbuwS62+7Nuoaji0dakdy2X/KTl32RkR6zZjgNu
 3is5khe1nCtwJW+MUHxDmmyYHgOYXJHHIRlI3Jn5Gbh3qJ67YAqrF6Gcy
 pkedEm07o3sgEiLXFp5HLAYFCcc5uA6VgWIaldFaqGoRJbdgwMYnUocuD
 YJV8EzFtPUrgJ71o+LXcVR/UGc7kS7NAWeqX509Kwn3YF++jyWOc2VGhp g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="357477693"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="357477693"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2023 17:54:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="776556758"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; d="scan'208";a="776556758"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP; 30 May 2023 17:54:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 17:54:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 17:54:16 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 17:54:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMtbOktHleKzDRBb38PTiHiKsLAVJlRP6dj+uDPTW1j4uS9cllMXAxukLpjcSjnVIuNKT2yCyqRAl6Bhm+yQ5pcyCGH0AvKatlFMILAVX+sj6gW4iECC823A0ot+dS+sD6ThhwqdwNe4LSErvqP8HzTgMdENUk8OLuIUzrMZgO9gHk5nVH6FW+5SWUsSIvZaIi0M1C4Gg36dwucDO9SjYnvFeXXaZpKpKrhdlfJKbtyjuVy6JVLXYxzShWZj748mw/3l8tRqT9VS5eF3DEgQ+aP7MltCsWGOd5IxVtWNvjVvO+shaZX+SCUOzW7K/jERASwG5OsvLMm++9jBbmdBJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKoFfOCv3Lwh+PTOLP2HvYAIpOM3JslgrTn6dDg95pg=;
 b=TkKc95r7nWYnl73i72TPb8r0f/Hss5XBlBfcgJNFcE/W+6+9xrSvUURsRPro3I0DuMpt9uuEv5vVoZgdpSvXsJxJx7Z5QvhVKQAahYCcEkJEe9YOP7JiNnnPsS4s6UbX2KZ9O0cRoKhSvbH8M2gR7DaVcE3d1qGQXN+ZgQueiTsqq71HXQkZjrRd0qaUmZhuuo7D9ZAMAteFba1HtZ24HMA66uPZONQg6mITJD5mVor0KB1O2FleUuJHO+9Zu0WnBDszOVtreUNnvRH2dmvD1RcRRtTq2iQPL0X8NKAuyyFZd9/RPDllmMUAmvV4N3CH/1TCEq3F4JY6i76pIo/36A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by SJ1PR11MB6225.namprd11.prod.outlook.com (2603:10b6:a03:45c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 00:54:12 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::6660:3269:205:8c6%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 00:54:12 +0000
Message-ID: <aa860271-44c2-a737-06a6-12c556cb99a4@intel.com>
Date: Wed, 31 May 2023 08:54:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 04/10] accel/tcg: add jit stats and time to
 TBStatistics
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
CC: <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, "Vanderson M . do Rosario" <vandersonmr2@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Laurent
 Vivier" <lvivier@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-5-fei2.wu@intel.com> <87sfbeqhwb.fsf@pond.sub.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <87sfbeqhwb.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|SJ1PR11MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: a48b8847-2fe0-47b1-1676-08db61718c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W//ARaTK4QhjlhM6fzLHkGvJQ9aw+ZvdQTBp1YecYF9/PJ12tVdbxsWHeWLSjhjEapPw/OzkCPeZ8meiVM3vIHEih8TlCaZX/9iO/Ha2csqxPIUH0/HD+jZ3RzMm+eo6XmkkEo4vBOWKBZfymb6Rz0vgV6/5I5QurIAU7qkdYFCrvghwssfhzB+R4ap3VMz2zVOACDBjrNMyggkFcbZV4WJP90MbRQLwab2s/IdC6aVg/7jKOZwMapVlWiMnbFxtR4+K48Taa1gAUGZ9CgL3ZKteCWWJpDPq9/tuyuwHQJWd1FaxL+FfMNh3AyQ16RJFweOjfokuwImpCFmge5Go3ts7nbQ8NuGWn3vHOQ4nNo3FhLElwyJUT1XDPqf/sUrk1dfms5TO93oJvW0FtEmcVCdeUMXe2jnYVOP9bvyfqoK2yBMYJW+GC70zQvdcM9D8IahbLoOZg8MlTnf/B9JlvrRXrz5nQG3rpHIH9odcTts5fGeENCx5d8qP63haIlcIo9yCQGbgJiVKdgPVEDu4ySN9/lhgeRdB6cDbxp2JtDrw0gmub7zsDac+4rlLMlkXO7kV917l19Y1P54OQfzlFAD3+TkvHH7ctwvm3ZSR/4d0E2UMENYuNlwcKmRNQgXB2Q1WF4Yb3/TcevAz00Wd6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199021)(54906003)(478600001)(5660300002)(8676002)(8936002)(2906002)(36756003)(86362001)(31696002)(6916009)(4326008)(66476007)(66556008)(66946007)(316002)(82960400001)(38100700002)(41300700001)(186003)(53546011)(66574015)(26005)(6506007)(6512007)(6486002)(6666004)(83380400001)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2prSXdPUTZVNGorVExhOUk4UGxTc0s1TVJDcXFqMXU3OEs1LzZEeURMaVNQ?=
 =?utf-8?B?V3ROdWJGeFNoYjhHZTlycTF2R3dSMGx1NndqUE5pbGdNWlRlZEhBdFAyQTNO?=
 =?utf-8?B?UXNQYTlMaWRlTVRMMERjT0ZuYVEzRmlIeFNCbzZIOHFRNzFVNDNwdnMzbStN?=
 =?utf-8?B?ZkNtWjVPVkdBV3BvQ2lUVlFJK092U2gyOGlkQ04vWDYwaFV6K2VtOENIdnV6?=
 =?utf-8?B?a0FMKzNSMGpyQzNUanFDbzlyUlFFbEZCN3hzOUppdHYyejQzN1dBa2tUREh6?=
 =?utf-8?B?b2MvZGhSY0Zleko3eGVOVWxlRGx4dVl1aDVBNkpsWFlXTHRuSVRhbERsZWx5?=
 =?utf-8?B?eDNLck0xVlBLOWRJSjhKMU9XUE81Um9IQnppRlZFemNuMkhQNjIzUm1lS0Vx?=
 =?utf-8?B?bTM0c3daZUd0WU9HN1FndGJaZXdiYnN4akNjMTBOWjI4WDY0WFA2STVRTTg1?=
 =?utf-8?B?RlhpSjVjRzJvS1luOXdaU0puMHE3K0l0U2IwSzUyRUthdzVPZWJzeGJLdVA5?=
 =?utf-8?B?UXE3N0Z4azNWeVU3cnNyQ3VEWnpTa0NxTDZtaVF1MFphVGs0aDlNdFdmVTlS?=
 =?utf-8?B?Wndxc3NBcVpTWDlzNlhodUhjb2cyeDYyYkkrcjJGM1ZjTDFWdmZmQlZZT2FP?=
 =?utf-8?B?aERzMkdYd3V2NUIwTzBIcWdLZEdISnl6Tmk5QjZ1TmxqaDRjMHArNUtkbHgr?=
 =?utf-8?B?YkpRYzV2VkFiOU9RYVZxWkhLZDQrMGlxakF2NUtCZzJKYnhxWDNRU3hvY3N3?=
 =?utf-8?B?OTUvQm1veXZCelg4aVRaQ09SQlliZTVNcW9FeUM4RytvSUhxcG1TZldhcnpR?=
 =?utf-8?B?bjcrK2tDNXJDY2ljcTZDL2tPdy90dW5UQ0txLzJycU5DS0NwWjlWUmNJWGZS?=
 =?utf-8?B?a04raDhqZlo4MTdaZ3VEREVEVmZCZTJoY2hsUFVJYldTcUpETmtEVG5MSnp6?=
 =?utf-8?B?U0tBNGRxTVRzc0FzUUx4bWZSZXlHY0pwdGtnRDlYbXhtMFpMcEFnWWIxQ0Ev?=
 =?utf-8?B?dnB0em5Ya1JEVWZHVVNaWWFaejJkRCtFNlNMR2wzUXBCTTBabGJNTmJnbzE2?=
 =?utf-8?B?TnBzb1N5QWFUSlhoQ05jVTF2UE5lSEtrVnlYeXZGSlZDakVaWUdCWTRzYWVN?=
 =?utf-8?B?YjN6OXdsL3FZY3hMZEk3aXBpbmVWOG9QRFhNQkNEemNsam12dWNzRThwaEU3?=
 =?utf-8?B?YnpZSDV0SnIyYXRKbGpUMldSQ2RuVk9LQ1BQcTFJU2dOVExNSU82UFZiNVpY?=
 =?utf-8?B?OEZNTjFoRnhrZXNlbXg3bGhwZ3hYdFVpZHA0M0sxVzFPWkpsMENZdnlNSXRz?=
 =?utf-8?B?RE9tYmg3RWI1NkRUVmdUcXdkdlpxSUhkMlZ3UndycmI0emRwVkp2OFZ5VFgy?=
 =?utf-8?B?UlFaYzZ4aWRsMzJ4U3oxZ284R1IwSzFKelJ6ZjlRL20zR1drc0hzVm42NnEy?=
 =?utf-8?B?SklNRG5qbjBTSmEzSzM4Uy93bUw1N29Lb3BOd3FscGtwTE96K0tOUkdCdGVL?=
 =?utf-8?B?ZzVjSVRJOVdTV09NTUdvR2hidGZPNGZKUUFtZ2xTMjRmeURKcEYxcTFiNkJB?=
 =?utf-8?B?aGJuWXBubU1YdmVYOG5admxuRzY2cEpraTZDWHdlUzlnemhDaXVhU2wzN0RS?=
 =?utf-8?B?aWxNSlJ5b2tmSzBlODIvdXRrWEhNRC9LdXM3T09LWXRIRlA5cVdRYzEyOXN0?=
 =?utf-8?B?cDZzYWtpdzA0ZElyZEtUOFg3ZFk1WkJaMUVUYnhYbVZUcC9pS2dEczY2akZQ?=
 =?utf-8?B?dDUwcWxheUJEbkN4TzF6ZENNWmdGbmE2MW9BQ0FQNm5ZNEp5TGtKVGVFbHNB?=
 =?utf-8?B?YU04elJYVjZSM3VEVkJRMkdFYW1wYVIxUm43ekM1OUo0Q1dRdGtCZ1BiZVgy?=
 =?utf-8?B?akQvVWt0NWRKRlZQYVcwcGIvVDB1d2luU1loOHJzOXNmZzJ6TU5QazJOczE0?=
 =?utf-8?B?S3MvOWtIbGZGZjIxbE5lQ3Vqdkw0VDlyUDBDdGZuOHBPWWMySEFFSzRnaW5N?=
 =?utf-8?B?aTJCRWIzUTVqOERhSExYa2dodHNmNTFoOFp5bGpjSDJUdHRqWEpKWUxtMEht?=
 =?utf-8?B?bWxuT0syTmQzWE9PVnE1NTlYZHJGekwxaFNVMnBrSHBXcVYrMFB1eGQzNXVo?=
 =?utf-8?Q?9K7HhwADQkFnpRFIXVZxKo+ct?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a48b8847-2fe0-47b1-1676-08db61718c55
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 00:54:11.9514 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcXyaVrDK5o9UAYRqzll8iuGgzhOmUkZb9XtRAHtL/C3stBMFQI0DdOXGby9+dge6o8D/oKizpT8/4aZsWjgUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6225
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=fei2.wu@intel.com;
 helo=mga09.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/30/2023 5:37 PM, Markus Armbruster wrote:
> Fei Wu <fei2.wu@intel.com> writes:
> 
>> This collects all the statistics for TBStatistics, not only for the
>> whole emulation but for each TB.
>>
>> Signed-off-by: Vanderson M. do Rosario <vandersonmr2@gmail.com>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> ---
>>  accel/tcg/monitor.c           |  20 ++++-
>>  accel/tcg/tb-stats.c          | 146 ++++++++++++++++++++++++++++++++++
>>  accel/tcg/tcg-accel-ops.c     |   7 ++
>>  accel/tcg/translate-all.c     |  70 +++++++++++++++-
>>  accel/tcg/translator.c        |   7 +-
>>  include/exec/tb-stats-flags.h |   2 +
>>  include/exec/tb-stats.h       |  46 +++++++++++
>>  include/qemu/timer.h          |   6 ++
>>  include/tcg/tcg.h             |  28 ++++++-
>>  softmmu/runstate.c            |   9 +++
>>  tcg/tcg.c                     |  88 ++++++++++++++++++--
>>  tests/qtest/qmp-cmd-test.c    |   3 +
>>  12 files changed, 417 insertions(+), 15 deletions(-)
>>
>> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
>> index e903dd1d2e..2bc87f2642 100644
>> --- a/accel/tcg/monitor.c
>> +++ b/accel/tcg/monitor.c
>> @@ -15,6 +15,7 @@
>>  #include "sysemu/cpus.h"
>>  #include "sysemu/cpu-timers.h"
>>  #include "sysemu/tcg.h"
>> +#include "exec/tb-stats.h"
>>  #include "internal.h"
>>  
>>  
>> @@ -69,6 +70,11 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
>>  {
>>      g_autoptr(GString) buf = g_string_new("");
>>  
>> +    if (!tb_stats_collection_enabled()) {
>> +        error_setg(errp, "TB information not being recorded.");
> 
> From error_setg()'s contract in include/qapi/error.h:
> 
>      * The resulting message should be a single phrase, with no newline or
>      * trailing punctuation.
> 
> Please drop the period.  Same elsewhere, not flagging it again there.
> 
Got it, will do.

>> +        return NULL;
>> +    }
>> +
>>      if (!tcg_enabled()) {
>>          error_setg(errp,
>>                     "Opcode count information is only available with accel=tcg");
>> @@ -80,11 +86,23 @@ HumanReadableText *qmp_x_query_opcount(Error **errp)
>>      return human_readable_text_from_str(buf);
>>  }
>>  
>> +#ifdef CONFIG_TCG
>> +HumanReadableText *qmp_x_query_profile(Error **errp)
>> +{
>> +    g_autoptr(GString) buf = g_string_new("");
>> +
>> +    dump_jit_exec_time_info(dev_time, buf);
>> +    dev_time = 0;
>> +
>> +    return human_readable_text_from_str(buf);
>> +}
>> +#else
>>  HumanReadableText *qmp_x_query_profile(Error **errp)
>>  {
>> -    error_setg(errp, "Internal profiler not compiled");
>> +    error_setg(errp, "TCG should be enabled!");
>>      return NULL;
>>  }
>> +#endif
> 
> machine.json has
> 
>    ##
>    # @x-query-profile:
>    #
>    # Query TCG profiling information
>    #
>    # Features:
>    #
>    # @unstable: This command is meant for debugging.
>    #
>    # Returns: profile information
>    #
>    # Since: 6.2
>    ##
>    { 'command': 'x-query-profile',
>      'returns': 'HumanReadableText',
>      'if': 'CONFIG_TCG',
>      'features': [ 'unstable' ] }
> 
> Not changed in this series.
> 
> Note the command is conditional on CONFIG_TCG, i.e. code generated for
> it is #if defined(CONFIG_TCG).
> 
> The only other use is in hmp-commands-info.hx, and it is also guarded by
> CONFIG_TCG.
> 
> Therefore, your #else is unreachable.  You can delete it along with...
> 
OK, so qmp_x_query_profile won't get called #ifndef CONFIG_TCG, I will
remove it.

Thanks,
Fei.

>>  
>>  static void hmp_tcg_register(void)
>>  {
> 
> [...]
> 
>> diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
>> index 73a670e8fa..749aafe4da 100644
>> --- a/tests/qtest/qmp-cmd-test.c
>> +++ b/tests/qtest/qmp-cmd-test.c
>> @@ -46,6 +46,9 @@ static int query_error_class(const char *cmd)
>>          { "query-balloon", ERROR_CLASS_DEVICE_NOT_ACTIVE },
>>          { "query-hotpluggable-cpus", ERROR_CLASS_GENERIC_ERROR },
>>          { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
>> +#ifndef CONFIG_TCG
>> +        { "x-query-profile", ERROR_CLASS_GENERIC_ERROR },
>> +#endif
> 
> ... this entry.
> 
>>          /* Only valid with a USB bus added */
>>          { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
>>          /* Only valid with accel=tcg */
> 


