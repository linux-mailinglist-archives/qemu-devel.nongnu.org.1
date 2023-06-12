Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1772B52F
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 03:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Wbv-0007CR-Cz; Sun, 11 Jun 2023 21:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8Wbr-0007Bt-0G
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 21:44:44 -0400
Received: from mga02.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q8Wbo-0001qP-BG
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 21:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686534280; x=1718070280;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U6AUMwkywInFu0CLV+nYP+TyIOhB2/B3pSTbCoBTvCg=;
 b=YranXVVIb0/uTK9dW8HtqPrDEMDt0rAZRfarXJRIyyKKOwH2KbEVmh0r
 vBuG0patyLa9913p3FpI+lrD+sJwKbr/3Kmy1v02Bv34bF2WLW5kFx5hc
 82MkLzUqQfoNaXnDldTgwaDo3QjrDUX+pGiROO2hAGZcJVZ445a5TY5Dl
 Zf/IDE3YyG4tBeZDXUA/2NEtnd6mrazoffku4/JgAA0V3RVKSl3D8eTrX
 u0AUFNrO4k5wKeI32Azmx/KI+zGAo3d499kSSL9TdOr8evz9WWMW0eVRf
 fgouIkDkQCHe1xEjp6/Wl9MIqnlWnIycNi7bxkDyOWCoJE4cesG4nsApK g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="347568075"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; d="scan'208";a="347568075"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2023 18:44:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="780994239"
X-IronPort-AV: E=Sophos;i="6.00,235,1681196400"; d="scan'208";a="780994239"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga004.fm.intel.com with ESMTP; 11 Jun 2023 18:44:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 18:44:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 11 Jun 2023 18:44:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sun, 11 Jun 2023 18:44:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sun, 11 Jun 2023 18:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iItfOz7Zyev7bVT+QnUnotwQe+F5pmfJfmCh5q/LV40491Va/Ltnd+LnNFR6oFrP53HHELXvJW32puBIUpwHb00BE6yPE4xYYxQ3OSSOEjSKrkR0mB8orO1w/JU2b70NAo7tTrr2rJaKStisYVJvjvQsoBRrC5J70kgU59oMYzU0Lb1EKH18MeBVqFGq7jQQveBylPW/ygFwylttt7mnC6hj7IPsE/qW4MS6FX8r4cYUgZ4tVQsxRaAW/DtBUuxouDws5bFGdE0JBSbqGQSrfSWLeMOqEuNhMP3raPoeuHY7lkIdNBTkaK5DS4jjpzVCRfK1fs+ptVJSfZRMWW8Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0GMTLZMQuvNiKnsUaf+n/Oj3STvnkkCCIxh4UHjGIQ=;
 b=XoMv/9Hp6q+Ko7R+enZTg8ZJhlBqY/s/VkAqS8J3qwXrf0IqRgMS9NiatI/RGFwNlV3ly6dlH5C6e1OP29sNYFYq165d8uN+ZtRcEGIKSrUtlgDj2IhBVRy1/EQVlqBTWkxpKtTyh7GzcbAhLfPULnWK/3CfzKRsIGexR1uoDmNfuAtp32V9Nf3M+4baLnZ4hEVLamD5aYyUJHR/sQnJFS6uHt/SPVTHizMy95x81OxbANlBTY11T/lOjBPa37j6KH69SLKEEekF0OmqBta3p41I5EAOAy1nKB5kRmdVh1dlSBxXW/453eYBy3ZmtmQYWDMWNdWudtI4gm+woOP6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 01:44:27 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 01:44:27 +0000
Message-ID: <81e761e4-7776-b569-229f-f0bd8257145d@intel.com>
Date: Mon, 12 Jun 2023 09:44:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v15 07/10] tb-stats: Adding info [tb-list|tb] commands to
 HMP (WIP)
Content-Language: en-US
To: <richard.henderson@linaro.org>, <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>, Peter Maydell
 <peter.maydell@linaro.org>
References: <20230607122411.3394702-1-fei2.wu@intel.com>
 <20230607122411.3394702-8-fei2.wu@intel.com>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <20230607122411.3394702-8-fei2.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: c1ed8771-191a-4df2-124a-08db6ae68e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sYLvEMEcZ1LzwfamrxNHOPXt2atL7A2Yj5XfSPFNea2M1GzgNOjl1u+Ox76c1JULN0Z3qC1ekXABuMR8EkGGXM3+idtk70R1MNvj+T7A04tMMUexSK3Yw7hNrSJf5UqhfvHkHPIKVt1h3bSv7A+CTGWtOqqAuNZCEfvC0pwOvRIQtGCx26D7YltIOnNFsJrfbMr3bO1qlyTuw0CtxRMa5zrjQD5g74W5o6XTGy9sHk91lnTBnT19c3TqDkg9fh6KCYllaZFV2yM/tUu4xRqQqJFdwluuRFRuHvwYyc965uUPEjtF4U3tZKqZLnLq3c4FHsCp6h4aQle/gv+veDA82TdOeR25+wFpTQESdnP15BL3S7TRWJVgUEqusxmSQYlyZfbs/4kkK1EzDrnxufdG1AHG5JTiZu+pYsVLV1zOd9dDmpsbCJ16cSfAj/dMRNxs3KIuNGaXfmlwpxHz+SNK0X5oO9iu1F01TdYkHrN/VKWNdvlgqk62tBvScBerAIDaIo2sXAtWy0ky+i8TTqJWZx+NXgBooYY0a0yzGatLEO1QyJXHUfBSwVJVBOpx3VsixAlAIJaN+q/QuMgCKSMhl3LLaLtu57LKjwqd3Y133JCGtHwPI70KSJCqQSVeyKa5GriQFPlXgmdtbVZb5QqxBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(5660300002)(8936002)(8676002)(2906002)(31686004)(66556008)(66946007)(66476007)(4326008)(54906003)(6666004)(6486002)(26005)(6506007)(6512007)(53546011)(316002)(41300700001)(186003)(82960400001)(83380400001)(2616005)(478600001)(36756003)(38100700002)(86362001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVFBOEFxS2IyV2dJdWZ3enFjaTB4dlI3ZHJLVjRXTGRhU3p0ZWtVeE44R3kw?=
 =?utf-8?B?OTRKakhqSmx3ME1ndHJoQkpVWVRtY3pBMGEzTU1uWGNmOVhpbXNWWVRyRjF6?=
 =?utf-8?B?SU1Kam1PSGZ2bk0vWTVWb29CSms2RENBTU04ZUR3S1g4WjhidThWaFEvTmZJ?=
 =?utf-8?B?dGtqbXhTZG1mVVh3NEFCOHIrMVVhRk1aQ25JM2dKMjVrTnMyY0tRajZXUis5?=
 =?utf-8?B?L3VtUzZ3eWw5UGxDRWhuZDYrY2tNNi80c29qS0ZTd2tQQ3d0U2kxMTBkaUl1?=
 =?utf-8?B?OEpqMWo2RFJzN25ELzhwS0RXK1ZhSUlPak43ZXdMdkhSMzA4Z0l6VU1qVWZO?=
 =?utf-8?B?R3g2Q1dtU1BjbS9uWFJyR3NsVWMwald1R2FOUTd3dUtyam8rY3dWZ2hDVXcv?=
 =?utf-8?B?ZzRCOEVpY0k4d0x4L2FKcTh0aXZyMHVGbWwwNFRaY3N6UFYyWG5HMUNpTGVK?=
 =?utf-8?B?QnNYVEdGTGo1QzV4YXFKaHlVZDRJSzlzdzRzOGZqdnhRSUlzakhwcVJqdGhS?=
 =?utf-8?B?cnFheE1FTjI5bk1IODVsQ1BIZlZqUFVQWGI5aVpqYVF6YVIxaCtxNGx0djcr?=
 =?utf-8?B?Ynd4WVhqRElJaUQ3S3dmME81WHVjZXU2M0pOSURvam1IUHFVdDllcTRIQXA3?=
 =?utf-8?B?UFd2M3ROYWRWNldrM014bE9yTkl1ekJ0Z3E1T2poN3ovU3VJdFR3RXBYajVj?=
 =?utf-8?B?UmdtZFBvTDZEdVl5aVozOW9qaVZ3WHNyNHA1RFYwSCtIczRKaFg0S1hqakRw?=
 =?utf-8?B?R2daeS9TR1o4azNFUFFpbS9hUEZYZFMzK2RLTlN1eDlKKzRXQkhNQjFqMDRK?=
 =?utf-8?B?Ly9UdmNiSEVPeDRsa2JaRWxvN3l1UW5MRHNoYzllSmRxVGwvUGwwZUUyNDJ3?=
 =?utf-8?B?WE1BdXI1UGNhZ1BDbHRlaWc5Y0RNbThqUjNXdG8rdzRqT1BJTlpqMmd5S3Fr?=
 =?utf-8?B?aWIwK2h4UnRGcGVnd1YvWlRMQk04RUt6ZWE5QTUyNGFZVHZqQlNKWElETHJJ?=
 =?utf-8?B?SWJNZjJYY1FuVnVaZmZERkxXbStWZHI0dGUzUUNiUmY3TVpIRjNHSTNoeWxw?=
 =?utf-8?B?czZRY2J2ajFRcGhxTkZBUDRBSDhjYVFzSS96ckE5SVN3ejVySHI0dC91R1Jm?=
 =?utf-8?B?L1lTdkgvZURSZnF2eGhEMkNsNU15S3hSYWYzSmJJWE9yYnpYM09kaDVYeUdK?=
 =?utf-8?B?S1loeTZ6eHFKbG1WYlVUQ1NkKzE0dUIvOXp5aDFjTTF3L2NNWTVOSFVhcksx?=
 =?utf-8?B?b0FOdDhrOFo3cFd2ZkZyTjV6YnFUZXBRSnI5TDZmTno0STBHbU9GQ290QklC?=
 =?utf-8?B?WnUwVGpDdFhXZ0dqakhHT2pJVFhEMzk1b1B1b0RtRm1BNWpkQ3d0YzNWaWxR?=
 =?utf-8?B?N2l5My80WGtsMENqNjZ6bFVNOVFKaEVVYkNhUCtGblNtSGlaL0dqaTc5NS8x?=
 =?utf-8?B?Qk5MRDlHQW4xaEVFemtDN00yeFFMVDRybllCYU1lT3dFL1JEY2V1UktzK1B5?=
 =?utf-8?B?RWxOY0VNcFIwVjlENWJTZ0lGZEVWNytJVU5scmpjcXBwalBGbEp4Zy9DT1RP?=
 =?utf-8?B?SHBnaTRUY1F1clE0QmdMS1VMWEozWVB4K1NBNWhPMC9MYnBKM2ttTlJGMUpD?=
 =?utf-8?B?QTJJdUNISHBYajBWdEZVUWVuUFlUYVpJZXlhcDRldW12TjdUUjJFU3UveWVP?=
 =?utf-8?B?OExEdWV3eG9YeEEzU3I5WWw1V1U2WXdmZFpYbGJQMStYeUo4eWU5d1V0UWFl?=
 =?utf-8?B?WmRFNW9iSUU3OXFob3I5NjFsZDk5WndrMDZzd09ZSVEyUTBuc1lEQ1M4OGdt?=
 =?utf-8?B?WEZDbWQ2N0hJVGlzd1NoQW1CclA0OWVzK2VLTlBqb0ZQVUZzd2ZkTHlqT3lW?=
 =?utf-8?B?MmdOYnVNNVlDWnpSZkxKQVpmbWNwNGVwM1dCQUt2Mktqbk8vY0hhbmo5WW5I?=
 =?utf-8?B?b2ZPaEpjQXhkaWxXanp3dkVXWVB2MzU5empHRVFrWnUveU55Vi9zdUNXR0d5?=
 =?utf-8?B?c0hDUmpHVWRDSitITnJXdGJLcnhJbWtoN3FoSWx6bXNnWHg2dmRzMlpNZy9o?=
 =?utf-8?B?Z1lqR2RVY2dzeWhKNERBaTNROThGT3phME9EK3BPbDFZZWo5VDBEMm00anBD?=
 =?utf-8?Q?fot3ZpP8n6tJTlgTUl4OrpC8M?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ed8771-191a-4df2-124a-08db6ae68e41
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 01:44:26.7474 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dVoMdYvoEuEuib8QTXOeSyAdTnU2pJ331MP1NdZIxKEPlHRDFIWSCkYRWHTCD5d0KKQjd9wVNoL1B4VN4sy/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20; envelope-from=fei2.wu@intel.com;
 helo=mga02.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/7/2023 8:24 PM, Fei Wu wrote:
> +void hmp_info_tb(Monitor *mon, const QDict *qdict)
> +{
> +    const int id = qdict_get_int(qdict, "id");
> +    g_autoptr(GString) buf = g_string_new("");
> +
> +    if (!tcg_enabled()) {
> +        monitor_printf(mon, "Only available with accel=tcg\n");
> +        return;
> +    }
> +
> +    TBStatistics *tbs = get_tbstats_by_id(id);
> +    if (tbs == NULL) {
> +        monitor_printf(mon, "TB %d information is not recorded\n", id);
> +        return;
> +    }
> +
> +    monitor_printf(mon, "\n------------------------------\n\n");
> +
> +    int valid_tb_num = dump_tb_info(buf, tbs, id);
> +    monitor_printf(mon, "%s", buf->str);
> +
> +    if (valid_tb_num > 0) {
> +        unsigned num_inst = tbs->code.num_guest_inst / tbs->translations.total;
> +
> +        monitor_printf(mon, "\n----------------n\n");
> +        // FIXME: cannot disas
> +        monitor_disas(mon, mon_get_cpu(mon), tbs->phys_pc, num_inst, true);
> +        monitor_printf(mon, "\n------------------------------\n\n");
> +    }
> +}
> +
So far the following methods are candidates for monitor_disas:

1. still use ram_addr_t for tbs->phys_pc, and extend monitor_disas to
support disassemble ram_addr_t by using qemu_map_ram_ptr(NULL, ram_addr)
to convert it to hva first

2. use gpa for tbs->phys_pc, there is no need to change monitor_disas,
but add another parameter for get_page_addr_code_hostp() to return extra
gpa, probe_access_internal() has already returned CPUTLBEntryFull, so
it's plain to get gpa here.

3. record gpa in another field of tbs, and keep tbs->phys_pc as it is,
this is just a variation of #2.

I'm inclined to use method #2. I think gpa carries more information for
debugging than ram_addr_t, guest can map gpa to the executable file
etc., but it has little knowledge of ram_addr_t.

What do you suggest?

Thanks,
Fei.


