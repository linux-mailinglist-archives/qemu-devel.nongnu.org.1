Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A1E72BBCF
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:13:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8daY-0005L1-Sx; Mon, 12 Jun 2023 05:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8daW-0005Kh-3R
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:11:48 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8daT-0003qt-Ew
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686561105; x=1718097105;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1FhNqEdk/T5nPjTrk/PK/ksQiwtofiesueWxlbQ/M1U=;
 b=haYf7R6p8/q/ZYfGA5Kkfut3Agac49huh6cj0h4R+H8Kqsnxj/nITljB
 aCE6ZmEgUpKO/vedobMbm6Zos7BYyIhzJtVkUApNrNXYfAhPAhAsPHQ1R
 JFmDsasgx61rykNuncmkJRYx8nfaL7c4ItxQonub2zOO1Vrs2V0lopy5v
 ugYLxIP0Wi8N3NlJGwgRAiliWgrPk1Sbb22nEkcM4pxYqm9vNsVDQmitI
 /8Ow0p6fRxoJPQtQiRHlkyf8KsgmopoohfI0AFldwR/Dre6ys6J2/uoVG
 HCO7UnmzPbVEozTKS+yCr5MLI7qYWbNbE2cSninjLJJDnhUP3aR1cNdd9 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="342675669"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="342675669"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 02:11:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="661518745"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="661518745"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 02:11:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 02:11:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 02:11:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 02:11:34 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 02:11:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a45knApon9ICda7uw+Pb7x+t5cZblTWpge4h8emg0cFtfYCnooFM0GhX1C3pRp1GyHxFoLJZpdxf/QeCIa/cs26XwND096Q1BkM0KAYwCWuHmaxJISVi246uZ8oHWDzd8g5yGKjQ+DUeHziHN8jttJ08VRAXPSb7cvGKZBeq+C2XDHrZyFcE2rGzUHyQmO65pFta1n30ymW4hRL7/YLDjFYQDBq+6DOkRIPRJK7w0aCPClFlh0geRZnGvfrRtWxGYehZZYEOq4hUnmChm3oV815ErR7Lq1XlRpS1qrtFBL99EU67UjOqIyq/Xg5UavrhugcjtCaQd0IH8CEIxuBSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hd8+v9Qr+JAl7RI/BAGkdSyZxOEaWN43Pxz43pvdCTs=;
 b=ed/IrWWcFLCX8w/TK39tf8Vi/iIAW8GibiZ4ijbPsu/YMg8OB9hbVvm8KSXcPNIjcOFna/rWKqEFp8OwdIBgAUrdCOyom5HMBtFPhDJAIa6dY4g+v5emn509LDjGkYcHA1PvuqmT6paW6otl6jE8xzDX32xGQZkqnGGa6z4YpOFxwyKpAwxut8r4PJ1nZQpuf5lUWi+QVf9up++sCIZ3p2CGF9z/8ei5gldKSYUem8Z7OB6dnXRHVe5+xIHFRJAjlY341Bvs1rCrbRZt4MH10E+zLacH3gUB4xxZmi/tDskrYDpqexsT7F4WSvURswpvL9C5aCSimiw6O/zLTWVSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 09:11:31 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 09:11:31 +0000
Message-ID: <f8673f20-1acb-34b3-98f7-cda8766ceb5c@intel.com>
Date: Mon, 12 Jun 2023 17:11:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH v15 07/10] tb-stats: Adding info [tb-list|tb] commands to
 HMP (WIP)
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
 <20230607122411.3394702-8-fei2.wu@intel.com>
 <81e761e4-7776-b569-229f-f0bd8257145d@intel.com>
 <63354939-ae21-dbbd-c788-1acacc64abae@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <63354939-ae21-dbbd-c788-1acacc64abae@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0015.apcprd06.prod.outlook.com
 (2603:1096:4:186::7) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|PH8PR11MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: aad2dd22-5b93-46c8-683a-08db6b250308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pm2+JZHd7G2KgRk+K4qrD3Jf6u4h+lAcou/12XQikBvMvxTm7KKwrL523Xfe0zBNNAjoy/ubOxwq/KHu1DtF0b8qCWJBlNMenNEAKwUlxNqkJiqXnMKNy4bpoyp6E6utj5k/PddOQukN3ZUDdCkdOJpvU6ewKeLD/We1PLdCCALZ8XyQM632XmnCtbSbwZ2veKkeFACbpYdvwqugaoSgteYQYOPyutZjc3UJApwHs5/4BdomMUyXu5E1t10RteDfurur4cSNbWXJRbQAWqX71GoNPR8xEYyiOA+tPAMNt0S1dOIlzlaIoyCoad9i+6kK9J2W0q5kfOetk0QLoEDn1vDrR7vMqkb6O4gKM4UC6GNO0GoxRtnJJgQjfmEvcRg0s1mM0/W6p28ZRwmnEpUzb1t6Ab5CkIBiynnDddnouMttivV1DL57AGHjrzUNXPjn3LQ1JtRXILloTgDoCzlsJJ22HgcQLO0X4cCzmZfkRtvE2KUSASsUOwU8Plu0GJvxx3gdpjIYA9Rpr/XWavUHgtzOSbvxysGHLFNrMNkkwxZjXI4//vw5BkkQwwiGp4hgOoV3VgIGTrzvvL+DOVBnZltTatE5b5ESgUqb4WWx1765IFNU8ZCV2FAK1JCvjSauYFy1IhtwHz10UTehpbN/iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199021)(31686004)(66946007)(4326008)(66476007)(66556008)(36756003)(186003)(478600001)(2616005)(2906002)(54906003)(8676002)(316002)(41300700001)(31696002)(86362001)(6486002)(6666004)(6506007)(53546011)(8936002)(82960400001)(83380400001)(5660300002)(26005)(38100700002)(6512007)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nkw4WHpjVEFVaWxUY2p5UlI5YWk3eWhyVzc5ZzdRTWNlUzh2Tm5WVW10UWZF?=
 =?utf-8?B?T0lMS2JBVjJTZklHSUI5UHFTQ1NQU0JCbXVIUThHYjJwV2F0ZlAxcEVrN1lT?=
 =?utf-8?B?c2pTTVZ4TUFTZDNYUTk0b3FzTUFabnYyU3lxYWZETlNUM3pxdVhjM3BQam5x?=
 =?utf-8?B?SkdZb2MxQjNCMXVMcnB6U0RQWlNYeXFkQ01URXYvOUhqWE5QK1VDVFVxNjht?=
 =?utf-8?B?L1JiTXM1MkZNa2E2MGdIQzdzanlqQStsV1NTMHVscytRLzYvMkF5RkljNTFq?=
 =?utf-8?B?bjJOc28wbEg3QmxYWjhUam5iYk9Hc1hmN002L0lJdmtncEVET25Nbjc0NEZE?=
 =?utf-8?B?M0Ivblk0aVBncDBUWGpTV1Jua003cUZ3N2tlR1hsUnFyTHA1TWh1OEpDaGJQ?=
 =?utf-8?B?KzhhSHpuSk9hbHdCNFlzckZYRlgxelQ2dDgxWk83V1EzRVVFbXhjdERzTTU1?=
 =?utf-8?B?dy9iYUFDUXNya1E0Z1QxbnNHc2Y2dkdTeEVUZmkrdjkxNFJtbFhlblpWbjIv?=
 =?utf-8?B?dGpaOFhDS0U3U0FTNEJFYlgrVHluQXowcHNaTmc2SmNVWFlXQkhPYUFJeXBG?=
 =?utf-8?B?dHkzaDFjQ28vWkFwNGJ3MlZsSzhTMjdYcU9HMHlOSklEYVVvRXFMRERmZWdq?=
 =?utf-8?B?MmNkdUcxWlRCQmtSTzlXd3ZIQXlFZmNuclgwU0cwbEFmK09BUWpwdkw4Y3Ay?=
 =?utf-8?B?M0l2WGdBdVdYOHdXc0w4amU3dEpKQWwrUTVKOC9lTHBDaWFUYjUweGhWVWtl?=
 =?utf-8?B?QXFvQjRlYlV2WUhSeE1kV0ljdisrM0YwU24rbXVUV0E0R2lMWUtwbjJUaW1o?=
 =?utf-8?B?N3V2SXhMRjZ3T3EwNmpjUmRBeHA3VHYzOTBnU1BoNkJ1RWFta0JpWVdLdzJB?=
 =?utf-8?B?Y3R1bGpFNFJGRW5sdjJwNDlQUXVUTlhXclpvdGtPdXJxT24yNmNaWnM4ZkNQ?=
 =?utf-8?B?Sm5hNVNCRy94dzExdStWemo0YUhpMnc1SEwrbnFLUnlaQ0pKdDNuQTZwSWtu?=
 =?utf-8?B?bXVzMHZHU0w4ZzhsUjIrd2hMcVp3eDJZaE1xNGVVcWR2d0JKTVRzZ0ZEMXdH?=
 =?utf-8?B?SkdWVHZweXhHMlppSTR6OWg3N0g1cnorc0lGWDRUbEJkRzJWQ1RpK0xyVmNL?=
 =?utf-8?B?dkRRQmhoWXdOMHFZQlpNVlFxN0dBV0grSnAzRFhnc2Z2MWx5eWRrV1BXL2RL?=
 =?utf-8?B?bmNkQlBVdHJ5Z1ZJZlA5M090Tm9EMkZMQWg2SEczQWpMcjBiRnlJVUVFRklT?=
 =?utf-8?B?dW01RzVZY2lad0piSUFkN3ZmVVJqOS8zSDNkL01UVkxJNjRVSXdpWGxueG05?=
 =?utf-8?B?SWhHREhXNmhjcGNKSTduQ2JMaVBsaEtLZlBWdU5zZDZNRzdsZWdkMlRWYzUv?=
 =?utf-8?B?MnM2VmRnSFBTeUdaK0k4b203bUVHM2NvZ00xWHFFQUlBOW5Mb1dJckZqK29V?=
 =?utf-8?B?NXQyQlFmWTRKY1ZhVUNwbFBNbE9Bck5xeEoreTBoL2NpN3RLeXFOUDlTTDdo?=
 =?utf-8?B?bE5vaFczTnFJUUpjS3ZKQTNqUTZkYTBEWlRoM0NOMHBLMjVLMnlKVEZXazZS?=
 =?utf-8?B?VUdjdWdURmQ3anNzbVR2MmRpcC9ZTUNyWjZsc0RNdlhwY3hEQW1mZE5kY29T?=
 =?utf-8?B?K1dvV1U4NlJtU29Fa3ZQYWFENGU1d29zUFp0M29TYnh6TWl1N2ExWnRteExs?=
 =?utf-8?B?UTZmMDhEMXZFUTZhMzM4Qk9zdlk2Wk4ycmhrTEtZcVJFMC94SkpleEp3L24x?=
 =?utf-8?B?TVhkeFhLUWwyUDRZS0t0RE5MWWx0YVZ6bExSSHZHUFFPRU92U095ZVJoMU92?=
 =?utf-8?B?a2ZobStTWDArT2lzOFZEWG5TWXdKOVZBM090Y0IxR3hEODk3YWpjakh3dlIy?=
 =?utf-8?B?ZDN6aEl6eXhwSTVTUlREUkhraVMxbXdLM3FXTFdJemZlWlZobkQvVHllSDA4?=
 =?utf-8?B?VWFNK25PK3crWG1TRDIyTVg2YTh3cE9nTERUbDR0M0oyRUV0NkRqRHhBQlFD?=
 =?utf-8?B?YjBHdjFWVkpSd1pRS0dmVWZoajlNdThVUStsNTZKTjUzVExKWS94VHhkWnpT?=
 =?utf-8?B?a1lXdlZwVFdSN1hlVm5SU05sTHJuRGlXelord3dmMWJPVEdEZlAxaHRkamM0?=
 =?utf-8?Q?RJRRof0KazOTYKfnndOqMgl7m?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aad2dd22-5b93-46c8-683a-08db6b250308
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 09:11:31.4663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iWZxyYfnNh/x8RAFMrF7WaFUM9ppzIsQCfxCLCaiJzEUyf//Gbd8IYrM4IoUwte5Z/E7i894gfAWWe8jjfkdJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126; envelope-from=fei2.wu@intel.com;
 helo=mga18.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/12/2023 3:17 PM, Richard Henderson wrote:
> On 6/12/23 03:44, Wu, Fei wrote:
>> On 6/7/2023 8:24 PM, Fei Wu wrote:
>>> +void hmp_info_tb(Monitor *mon, const QDict *qdict)
>>> +{
>>> +    const int id = qdict_get_int(qdict, "id");
>>> +    g_autoptr(GString) buf = g_string_new("");
>>> +
>>> +    if (!tcg_enabled()) {
>>> +        monitor_printf(mon, "Only available with accel=tcg\n");
>>> +        return;
>>> +    }
>>> +
>>> +    TBStatistics *tbs = get_tbstats_by_id(id);
>>> +    if (tbs == NULL) {
>>> +        monitor_printf(mon, "TB %d information is not recorded\n", id);
>>> +        return;
>>> +    }
>>> +
>>> +    monitor_printf(mon, "\n------------------------------\n\n");
>>> +
>>> +    int valid_tb_num = dump_tb_info(buf, tbs, id);
>>> +    monitor_printf(mon, "%s", buf->str);
>>> +
>>> +    if (valid_tb_num > 0) {
>>> +        unsigned num_inst = tbs->code.num_guest_inst /
>>> tbs->translations.total;
>>> +
>>> +        monitor_printf(mon, "\n----------------n\n");
>>> +        // FIXME: cannot disas
>>> +        monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst,
>>> true);
>>> +        monitor_printf(mon, "\n------------------------------\n\n");
>>> +    }
>>> +}
>>> +
>> So far the following methods are candidates for monitor_disas:
>>
>> 1. still use ram_addr_t for tbs->phys_pc, and extend monitor_disas to
>> support disassemble ram_addr_t by using qemu_map_ram_ptr(NULL, ram_addr)
>> to convert it to hva first
>>
>> 2. use gpa for tbs->phys_pc, there is no need to change monitor_disas,
>> but add another parameter for get_page_addr_code_hostp() to return extra
>> gpa, probe_access_internal() has already returned CPUTLBEntryFull, so
>> it's plain to get gpa here.
> 
> No, we need the ram_addr_t for dirty-page handling in order to detect
> self-modifying code.  Leave tb->phys_pc alone.
> 
I mean return both ram_addr_t and gpa from get_page_addr_code_hostp(),
tb->phys_pc will not be changed, I'm not going to change tbs->phys_pc
either (like #3), the extra gpa will be saved in tbs for 'info tb' purpose.

In short, no change on phys_pc, but add gpa to tbs, sounds good?

Thanks,
Fei.

> 
> r~
> 
>>
>> 3. record gpa in another field of tbs, and keep tbs->phys_pc as it is,
>> this is just a variation of #2.
>>
>> I'm inclined to use method #2. I think gpa carries more information for
>> debugging than ram_addr_t, guest can map gpa to the executable file
>> etc., but it has little knowledge of ram_addr_t.
>>
>> What do you suggest?
>>
>> Thanks,
>> Fei.
>>
> 


