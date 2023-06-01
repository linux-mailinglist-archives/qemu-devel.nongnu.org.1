Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C951A719142
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 05:20:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Yqt-0007c0-Hq; Wed, 31 May 2023 23:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4Yqr-0007Y6-1l
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:19:49 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4Yqo-0003Gc-8v
 for qemu-devel@nongnu.org; Wed, 31 May 2023 23:19:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685589586; x=1717125586;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tPqvh1WmSbPzTsGt60zWyjZaCrutIkktAmRG/ztdyps=;
 b=IgwpmUMPEPtlbcG68LDxthjKVsKc71TtH1FBCn+vXrAqGh0OEnrMmR8a
 HPQaxYIkWYsYD11xzZjH9kSLOpwa+qRVDbEeAkSWQqTemryET8G7SnY+q
 v33m1HOXIGlha24YhXk8G5othbgP8XBIv9kLoAV8I00XWLfSyuCJWEQSo
 hkrQnu/oN3Fly7wPn9wvHdbpmEmOYsd3SzaHmtC0TdcwrgZEZwji+D6Ph
 l7SyR043tBZEj5TIqUCy1L9jxZBuPgIfZemFB31IKz6MeZ5VrY2hBQmP1
 CvnyfztDRhXxACL9DGA6B7W8RMnqDhlCeeXOpMetfxb17RPaMQztdMIwA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="355446399"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="355446399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 20:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="881449922"
X-IronPort-AV: E=Sophos;i="6.00,207,1681196400"; d="scan'208";a="881449922"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga005.jf.intel.com with ESMTP; 31 May 2023 20:19:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 20:19:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 20:19:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 31 May 2023 20:19:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 31 May 2023 20:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RP1cPM4dtQ2wx4VK/n7R000o+R7GTlSu+TGZ8n0rYAe742B/Gsnc9evz1LojTBYKq+iXuC1/c4sQQ3/5m+teDduxK0PlcOhxmiK/fqg2M43wHm9qVW9thcGLnSeD9hrmyFEDn7v8smN4vo8lneOsDEnN5rUkns2PnCg21eLSgBCqxYPOEXME8iZaQRNygjRl3YwXKnDSGCxh3NN+LYK3ac8ODhWckI1bmvLUADDKZDo8VIO6JhazJxSwc0PLUOC5r0aPtu852t+uSxt8INph9shuymIQczZoMg4j+h8fdO8Jf7MZ/F80TU5gbpvY6JjAlc7zW0tiWgcBAQ9ydYDaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wffhImVYLocWnbWg/ur2+FNF2a36Y3gI31fjLNK7Qk8=;
 b=FIWFd9NNQtkdfGJnUF/GcDAEh4EgUIPD8I8T/M4An9E6c8/BiM8P6Mmit9fUEKl47tqDnUjd/GxxH6xzZVSXctB/39xcakwVaR1g7s4VX54r5CxyIAlZNbElBHstesUZKuiFIZwpC2H566uw4L507cOCxqUmkXZ0xlY1XXyREIwzcLzNwTAZjtsq3uC3fgf2z8AdOTByIcPrCrbF39qEJ/RBkwMRqeAIzgkiQN8xNLFyLry9ZZPAyL19ZsveLpwVEAOVy0FTZrvNkP6VMecm4XJe0bA+pvIgPM/3HtHFwHISi87G74j7pUJ/fyQR6ZVZ2t2kjzkUap+CxRgjl3KyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 03:19:34 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 03:19:34 +0000
Message-ID: <eb173080-68e6-df4b-f070-49315a09242c@intel.com>
Date: Thu, 1 Jun 2023 11:19:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 02/10] accel/tcg: introduce TBStatistics structure
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: "Vanderson M. do Rosario" <vandersonmr2@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-3-fei2.wu@intel.com>
 <b4859236-58eb-7709-235f-5096aeb9861f@linaro.org>
Content-Language: en-US
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <b4859236-58eb-7709-235f-5096aeb9861f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0131.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::35) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: eb421add-b347-41e8-1636-08db624f058a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHeQwFhzCir0AcnRfqxGkolZ1h9yL0z9YEpNn2nzpRiG09vsG2Zy2l0dwiZ0+hL8fN73207pzc+fb4ILUf7XKbr21lwOwwwumNxdTYYP3Fs8remDNpJknIVX4n+zvbgGMHtnHISAi+Ica6s3UQZrcuwZ7YCiN/wMQjuPQs9gEUbBNMYIZv2i8/FATOmjGvLnNeuK5eETG+AQtOxLBtQqdn159SSbh6ZRCtkOkHHnMuVsMktV3CUXdU45NbHskAHNAFi5TViFOeSEHZhlyjEa0X1YdTCWOestfzzgnMpULlbis7jKfGoKM0uxG5ea0sqdqJ6sRdfXyA51Dx/ruf6Zkqq2wNYBfTVy6s5/iIqDgvX4rSl175a2qQdV4rAkX8zbaxy0olYNhKUsj4m0N3Sp/ocAXmoUbk0YFRSw1HI2g95Z3DFCvHVVUUHvij5jlnPM8sV83W6m23mMPUMJ2HQ5GHzGM2Rd2STWzjqbCsMadcxLIczZ++DcqGPTBIWZk4yHJ4pKewus8xN7Dlr85gQzw5+PxMCDgI/rrIfH4X7UJRisoFXBADLi+IdUs2BtnT+UnngxFzUq7vfomNwM8Tni/UUbtj+l1sbGgUo3hkxGTANaDP+9cV9HxUYjKUqlLajPEXLGySAEXKRhctuVpThJ5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(86362001)(31696002)(36756003)(82960400001)(38100700002)(6666004)(478600001)(54906003)(6486002)(5660300002)(8936002)(4744005)(2906002)(66476007)(31686004)(4326008)(66946007)(66556008)(316002)(41300700001)(8676002)(6506007)(2616005)(53546011)(186003)(6512007)(83380400001)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emwwZS9QNVZKYUpZTkh1TWdwdE85cVNLR05Xd1c2bzB5Z1YyVjdSckZwb1Jw?=
 =?utf-8?B?ME5sZzhkaExYYk1sMjJyT1R4QmFpS2EvbnQwb05vNi9SMG1MbkQ3bFZtNVRG?=
 =?utf-8?B?R1RiSmswSW42WVc0cmlWb3h4bXA0TE9PUE1ZbEdzTS9SUXRBbzI3Q0IvbUtF?=
 =?utf-8?B?YXo3blY1anhUODhYODQzVTZYcW5aRU9lTGx5QkQycHNob3BPcE1xc1pvN29j?=
 =?utf-8?B?OWxEdk9MWVJ0bkFXbmFTTC9tQjhRaGprekpjOTFsYXM4WWZHczlzckpIUEVh?=
 =?utf-8?B?Ky80OGt6UVhWdmFIUXIvM29Ta2l6OWNpVXdUK3hlbUhZa2lPdWJMSVd4VFBC?=
 =?utf-8?B?WW90YVN1VittQS9NbGRXZWpVZyswTzVWZnRaaGk4OWdyL2g3ZVNlR2IrWHpY?=
 =?utf-8?B?ODFzemRLOTdORzlMbk5lWHR1RFZVS0p6bjR3Y0xRd24xTThKTE0xakVEZi8x?=
 =?utf-8?B?NTRTUGxGZFBndnJNVjJVaklSSXRFNzdlRVRQV2F2eC9QLzBXVnVvelJFMXlo?=
 =?utf-8?B?bm14UzFTMGp4S1Z0a1E3dU5CT3hSamJnZ3JtWmx0aEtVeUhVcy9GQXpjOW9K?=
 =?utf-8?B?OEJFTG9reVZPYkJwUmJxZXdTSlJib3dyYnRackdGVzgva3dJbllTSjB1TXBJ?=
 =?utf-8?B?S1VrZ0pjM2Q5aVRSTk5BN3pQYnF2OHBHMU5GWVNCNjB4UEt2UnZ4SVlGb3Y3?=
 =?utf-8?B?NlhyamFxN3l6T21MZW9XY053cFFjZUdQWmtvcEUwR0RTLzBVQThndCtNOFMz?=
 =?utf-8?B?ZzFDVVdodStjclUxbnZwVFNDQmVjM1ZVb3k5YmNlVFpVMVNjU3RwNVhaajBB?=
 =?utf-8?B?eEczMmdnRlk3VndJNHRvaHkxeVlmM00zT0xGUnFxeUhLUHVWT2JTV094cGd5?=
 =?utf-8?B?OEhHK3hTMVNZbGx5bGZnTlRsbWZacXF6WTY5eFJYaHBmT2hsSlFmTFR3UEM3?=
 =?utf-8?B?Y29ZaFRxeU9OTFJObkpITWltNkZtckkzS1Z2K0pzblZ3eCtWL2VjZDRCZE9S?=
 =?utf-8?B?cjV6U2Fsb2JHZmJHQlBlWGx5NGg2UGxBZVcvdUlPWExYUWtiaHM4TUFYa0Zl?=
 =?utf-8?B?Rlp4VW9rYU9waG1aakRrY1RMT2lPTDYwbFJ5NUJYaUNRNGsvb3E4ZkV2eHMv?=
 =?utf-8?B?WG9ZWEhkWGFyQzluVHhYMlA2a0RCemJnUW9nTU9rQlJBOXhOd1g3aWI1QnBP?=
 =?utf-8?B?Nm1DRkdWTG85UjIvTWE5MENtdkVhUlRTVS9Vajg1NmxNZnFLRDUyUE80VDIx?=
 =?utf-8?B?ZVVjcmVGdDFlZ0hwUldXUHlTOVpkVDcyTFhZNEh2NTIvRzVxVmExT2svcWFl?=
 =?utf-8?B?K3Zlc0dCa2pQbFNpMWlUSzRzQkNQcUc5Y1lQVEpYRGVvbFZ0MmJQaWQ0d1lL?=
 =?utf-8?B?WFdhMm5aR2doNk96aG1wbHNWNnloYmpUM0cyYUszS0t0U3cvZ1lzWkx5eFls?=
 =?utf-8?B?UkxHcWF5RHUycVRNS3Y1ckQrT2UxUWF4ZUdhSk1WMjFtelJobXcyQzZzeXFY?=
 =?utf-8?B?dDZOUzkrSkhidGJ6RUQxa002WjlpazRXVVMvNDFXSEZxT3dPdnRlVVIzYkZ6?=
 =?utf-8?B?d0w5MTBTeHZST1dja1VhTmJOYXBPeFBLZVhqOGFrU0VZR2NHOXZOK0pidksw?=
 =?utf-8?B?THNaS3psRlVQMmJVWDR1N3JiOFNadjVhYjNSR0w5ZW1QS1VKWFk2ejZ5K3ZY?=
 =?utf-8?B?bUM5YVllblJ3Y1JaekZVQ0VHazRHY0RsbUlQWnFyc1FMaTZ5K2srK0ZndzRr?=
 =?utf-8?B?RHhuRzl2ZnN1Sjg4UVIrR2lhWVZtQ29hWk1zL2hLRm1WNTlaTWRyN2x6WDEz?=
 =?utf-8?B?WFhvVmpVNXo2a0IySWFyYmptRGh0Z1B2YS94SlB4bGlzcGhCemk4V2NWR1Zs?=
 =?utf-8?B?RmxxNFhYWXorTnRNTnZYVGRpQzBuWTJNQjV6a3NjYlZZU0ova1cxcE1zRlFU?=
 =?utf-8?B?cXRqdWxqaitHanZRdHRGR0JVTzQwQ1FJV1IvQmtpT3pISCswU2UrdndTUG5F?=
 =?utf-8?B?cGNNSTcvM0pIS3VtWjhXSEYra2lOWnV4QnBmRTZPaWNtNTVIVVR0elZ1SnVP?=
 =?utf-8?B?RVdtWFl1L2s2L2VwVmxaNmVac00wdVU3UHhuRDlxcFFWNi9sM0IrYzVZWHNs?=
 =?utf-8?Q?PK5nl4GXuxYgeoapO7exrW4Vi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb421add-b347-41e8-1636-08db624f058a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 03:19:34.2251 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZBlJ8U5rN+W6xpAOn6WYtEKn960Q+jGwIhmjvVB18dnjiWVVQvv9wEKCQ1bwsvgdVZSIb7ERoqscaMzVkjWbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=fei2.wu@intel.com;
 helo=mga14.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 6/1/2023 8:01 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> +/* TBStatistic collection controls */
>> +enum TBStatsStatus {
>> +    TB_STATS_DISABLED = 0,
>> +    TB_STATS_RUNNING,
>> +    TB_STATS_PAUSED,
>> +    TB_STATS_STOPPED
>> +};
> 
> I don't see what PAUSED or STOPPED actually do.
> As far as I can see, stats are either being collected or not: a boolean.
> 
If STOPPED, clean_tbstats() gets called, all the tbstats history is
destroyed, but it's not for PAUSED.

Thanks,
Fei.

> 
> r~


