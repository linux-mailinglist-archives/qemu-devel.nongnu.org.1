Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45715719415
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 09:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4ceJ-0007cE-Us; Thu, 01 Jun 2023 03:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4ceH-0007bw-Eo
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:23:05 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fei2.wu@intel.com>) id 1q4ceD-0005QX-9a
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 03:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685604181; x=1717140181;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1tzXb3MX7NJIj/cuN9Ebb7WYx8wbA+HBuBv12BVPg1o=;
 b=aQOZ28X6AfzTQb2aRmgICpyCRZutIy3Tv4dNVEGfmoHIthOZjHN8iOin
 gOi6dS5/cG5kMIvdjqS2sIPLXw0c7nJLKuQkG5nlK1SyLoMfWIPxzDRQL
 7Hss0lu5ARr+EOXlfJ0MKLOH8fLNlWcRmAay7UGeppcKWTHK0gIdUfQQs
 AxagA7D8dxNxY0LU1q7V9ZBEdHhZ4HuCle81w43bI802EaVcQP0UvuovO
 zIptztAYCdwM6+rAqHxmx2yJRMSskijUgeYwC9kq/f2VoQqTAZJ4lfKTQ
 gmyPpXpgxeDYqhx6jYkQnUv679o4NL5p3TY51EJNvR1L5OmpiE02/Z67e A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="335099355"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="335099355"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 00:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="777048871"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="777048871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP; 01 Jun 2023 00:22:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 00:22:57 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 00:22:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 00:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLo9g69r9+vUNMrOln564fUYMzv8SiAnnOoFgCd0WYXiHuaw8q3hbs81yVboFBgSUdH8Ry7G6Aq8Vb1RTHrvy15/1q7TRUP+PynyA7XEDJW9jh+eG0zJTiTwS3LBSTnWbyA0qcbMJxv/EJd7scXE0kkrMlpaQrWmNd8qwcxZuS4uspwB9vUmuZ4jlH33UcM/xTQFKizdfrgZ2+iaCDunb5k3U8tVSPA/Fc6NJvWP+pdMb8MsrXwdqDfRZ6lLZeYFxfBu9PtjDpbO/hU4/p/950jep25fN6Y0s3GAadl5vgGA7x8PbTxYVhRZGIjexEq3pF10i4SkMQH9C4l3Ngx7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMQlIvwS83JDqdU8sTug+F66ZouQzSgluRgI3zRTWzc=;
 b=NN2yVNqw1+rDDZHu2+53pUyiG3Sgp+JD68H6OKlm3Ii6oFMtSoGN3ek5OrvE63aD/prvVS4DHwJvDRRpmJb5EcxSy15o+AKuh+XIOIR9oKSzkqfxRcO4sf4Vl67tuNGTI/WxhEYVmh3ENCXDkwwoTYqgGLh1popt6pt6grxPV0j0ZFZx6onBWGfLZ+okn/3v+j6zEnJGCVnNdWNg2LxzL3e2XDIipbNmhKzsX1sobhYdkse0f+7io0EnS70Ti55Iqpe6BgH/gLfK8H0ae583SLwKoYPK6OAOVF9JH8iIfynPnJL8y5j+uN6yhXjos4RH9g1Nquepb1FwUE5ekxBmgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4500.namprd11.prod.outlook.com (2603:10b6:a03:1c3::24)
 by CH3PR11MB8187.namprd11.prod.outlook.com (2603:10b6:610:160::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 07:22:53 +0000
Received: from BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602]) by BY5PR11MB4500.namprd11.prod.outlook.com
 ([fe80::db38:4ad3:bc43:5602%4]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 07:22:53 +0000
Message-ID: <569ba5df-8181-af66-08af-ae07b1099dab@intel.com>
Date: Thu, 1 Jun 2023 15:22:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 07/10] tb-stats: reset the tracked TBs on a tb_flush
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 <alex.bennee@linaro.org>, <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
References: <20230530083526.2174430-1-fei2.wu@intel.com>
 <20230530083526.2174430-8-fei2.wu@intel.com>
 <cd066ad3-d6b1-4c23-e0b5-42b45d222c8b@linaro.org>
From: "Wu, Fei" <fei2.wu@intel.com>
In-Reply-To: <cd066ad3-d6b1-4c23-e0b5-42b45d222c8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1P15301CA0028.APCP153.PROD.OUTLOOK.COM
 (2603:1096:820:6::16) To BY5PR11MB4500.namprd11.prod.outlook.com
 (2603:10b6:a03:1c3::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4500:EE_|CH3PR11MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: c64ef12d-e632-413e-cbd1-08db6271035d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZgirJbSN/ayVYjFio82lq1sNW8MD/uFMsJH70evWe2Mrc6rXMQMG2gFC0itW80kokOHuMufAvZwPA2z4y3RQp0OsA33rN8NGnXBjSmXyyWPnsEDr8sDjIoyCotNkAlq4qeOYg7XFlCAF2n0JFLZ22jumgCnmOY5fLr67BqeVlWsPcu+1+nqvub/qAHj8LA3ihWypYIlVL4QMT+dhPAoc7Rwuofim3+dKrLFMJDpHDZisUR7MH53WxySpO97hR5w6W3VX9QRWR2LXgBD2gr2/6SvX31+F+g2H4osZZdVjLUXoLHgTiz9lc8+OYXrQvL6tr2oIL6gXfmOO/CmS9WSK7lZS/OgoS/SjeXDWpETiNbWrwGOPrmmCMunb101/zBpK39FelXKK3BEGaS+YlFZ4Rx1HwnBtrn8HLVm9TmY75HyCe757Qv+aJ8ltX+qibS9gF9GXO2CexvqUKillZg+Qff6VnT6BkR0lmJeVJzSUoV8K/r2CXDNa+yAPcy8q7dnTIqHn9j0NbuiGM5OxXICqFX3oFPGZVAZvtw4SmbaBbwfkfoB+mbCLrtdDqUKDTxyROOajIq41zpybXQN4bBqRdiz4u0gRi3491l1fBOFGexs30Yy+8VvcQOPjRkcZcujXvb+P/YczJZWheJ5JiG1fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB4500.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(478600001)(8676002)(5660300002)(31696002)(2906002)(86362001)(36756003)(4744005)(8936002)(66476007)(66556008)(82960400001)(66946007)(316002)(4326008)(41300700001)(2616005)(38100700002)(186003)(26005)(53546011)(6486002)(6666004)(6506007)(31686004)(6512007)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJBQW0zcFZMZ3g4aWc4SDZCUXNZQ09iWE1ZdmFxbTdUU1FSQ1pSWXUwcWZL?=
 =?utf-8?B?czRIQmNvb2RBbVovVGQxTEwzTUhDVmcyQ2JRZDFCRE5BOHpZem1mOWtMbDJu?=
 =?utf-8?B?NlluSWIzNDhaNGFobVUrL0UxeWY1SzBwODVHajNKYXRvUzBxbTdSSGQxM2V5?=
 =?utf-8?B?L0k3aHpvRWkrMFp1YWcvU3NnaVhMa0QzK090T2c2MzBLLzc2UDNOR0piSVBv?=
 =?utf-8?B?eFErMGg3MEdOaHdMUG1lNU85VXQrNXkwRFBsOFJnVVlkWGkrSVM3NzRjRXJW?=
 =?utf-8?B?MkRrZFIwcEg5YVZtUU8wUzlGSngrTHlmNzQ1ZE5vT2x5ZmZUMk9PcUIxcS9Z?=
 =?utf-8?B?MkxaYTVNTDBVdG1lOHpWalFORkxmNWxhckdaWUxNT29kN1ppZC9OR0VCZjJL?=
 =?utf-8?B?cjRabU1tUWRFTEdHOWtaME1vMENBaE9oWTNud1VaSTZOMU5SS1NhSHA3blBv?=
 =?utf-8?B?RUwrNDhFUTJYMm4wNWRiaWFXRSt1L2V6aVVVVTZ2bllDUFdmMDRrN2REZ3hT?=
 =?utf-8?B?ZDZ5NEJWbEs1ZjNOVXp5MW9wektTR0Foak4xL2twR2JDQ2RGZnR1OXJKOUJY?=
 =?utf-8?B?Zk04QVk4c3BmVzdVMzJwYis0cFp2cjBmVWVFWDk0RG5pa0cweTVPQVRzZEFi?=
 =?utf-8?B?R1hZbjR2c29KejNHNjFGakNpZUEvaU9QcTd4Um5GcEZtczhQNEJLYWlJTEsw?=
 =?utf-8?B?aUZvaVlkVGhrdjRXdHk3ajJPYnFBMzNNSElvYkVCcDBkMnloVmE1WXZiTmp1?=
 =?utf-8?B?ZDkwalVIa0hLWDA5cFBkQU9CMTRLelV5ekYwSFNyZVR2VG5EUk5rRVpHd09a?=
 =?utf-8?B?SFZ5eTN0WjVuQ3ZyR3I3Zzk2S3paTWVERFJGWUJDR2dyZjFjaTNjYVd3ZVZq?=
 =?utf-8?B?U1hvSmlneHoyTjFuZE8vbysrSjduOXpQVnRyR1R1TFBoQkpCMEJjTE80dXVa?=
 =?utf-8?B?ZmEvYy9uNUUwdXl2dzIxK0RxVTgwOURMLzlGVnMrdmhEUGp3VDc1Wm5qckFI?=
 =?utf-8?B?QzFCRXNocnJKWmQ2ZU9DbWxUZkVCNzBlM1RhREJDVitBbkphMDAwZXYzVkZq?=
 =?utf-8?B?bFIvRFE1eUpmbjBJVFJIOUdjNUVxWk9jT3AwVFI4eTRuOG5OTk5UNGFGd2Q1?=
 =?utf-8?B?WWJNcmcxbVZ1WThWUnN6aFg0eDJEeHRoRjFjQkpMa3Uwdi83L0dSc0Q3aXNx?=
 =?utf-8?B?NmpKZnVjV1VFYWtraVVWWkNmd3NSd3dPa3RRa0I0clIrckRKQWtsR05FVTBk?=
 =?utf-8?B?aHpJcS8vQUZqUFRWVlVTbWRGbmpmRHZTL1hxVGN1MVFETU1iOXVJYWhGekRL?=
 =?utf-8?B?MmErUDNYcGh3dTU5MG1pVllERXRvaTZVdGNyK0hCVW5YYkJGZEpiT0xOQ3lt?=
 =?utf-8?B?Q09KUkRhOGFudXNZZUhxN3IwcnNETWE3OXo3cFV0NHJhSTljOG10TURHYWRR?=
 =?utf-8?B?STFaNVRWT00zVXhMNmFqK2UvTU1TejhYZlpJSjNDYnhpcDdiWUtVN3g0dHF0?=
 =?utf-8?B?L3FyY3hDTFpSMFdZTDRWQk9RNFBBalZ2MzczSnlycXpnVW5qQkNKVHdNSkQ1?=
 =?utf-8?B?UVhTdG53N2pWL0JLSXBHUGdjQk1LOUYxaVhFWHE5ZjJBdDhkcTF1R1pUb2hq?=
 =?utf-8?B?Y3V6Qk95V0Z3UUNxYjQwQ3JhbnpaZ25wK0VOZVZIR3VhRXVTRi9uUm1naTdT?=
 =?utf-8?B?S1lLRHVtSXVYNXZaNDlyRjdDQkQ2cm1veHRQcERzMEhUODFJSEM2dVNWaE5W?=
 =?utf-8?B?MEc5eEhpeVBVR2hKVHdvaTBmZ3FZaCtFcXpKc2MxQ1Y2b3NYd0xYSFZkWW5T?=
 =?utf-8?B?Tzk1eG5SMzRKa0owT1ZuaFcrT2dKWDI4OC94QlFYdk1WZzU5LzYyeGFTL3Uz?=
 =?utf-8?B?cEJrWmpqYXplSmZzQ3dNQTIrblV0VVN6ZXhnV2xRM2gxa2d2dmZGT21oR2xt?=
 =?utf-8?B?YWpaREZGK09pQ21HYThBVGFKRklNamZlUjByaTgxaCsxTVJyaXFYMkhmaDVN?=
 =?utf-8?B?bkJHSFNIL3F1eWp0MGJrY1JlczhDRUVCYjMxLzd2WlcwaU9HSFFxT0k1em83?=
 =?utf-8?B?cVlUd3JzaEZtQnVEQ2VINW5BOXhKL1oyalplQ01nc0R6bXNJeTNPSlU0eG9v?=
 =?utf-8?Q?tmTog0JIMbYjJoYwDmLEEg81v?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c64ef12d-e632-413e-cbd1-08db6271035d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4500.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:22:53.4481 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzV6WGlNOC6FU6jXIRihI4KWN3Ox0/KNfouZaj0w3K8Yq+PXFsPvhJszqVtdlo3bmyIgxSUBq5x4mw3VW8Uytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8187
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=fei2.wu@intel.com;
 helo=mga12.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 6/1/2023 9:30 AM, Richard Henderson wrote:
> On 5/30/23 01:35, Fei Wu wrote:
>> diff --git a/accel/tcg/tb-stats.c b/accel/tcg/tb-stats.c
>> index 805e1fc74d..139f049ffc 100644
>> --- a/accel/tcg/tb-stats.c
>> +++ b/accel/tcg/tb-stats.c
>> @@ -267,6 +267,25 @@ void do_hmp_tbstats_safe(CPUState *cpu,
>> run_on_cpu_data icmd)
>>       g_free(cmdinfo);
>>   }
>>   +/*
>> + * We have to reset the tbs array on a tb_flush as those
>> + * TranslationBlocks no longer exist and we no loner know if the
>> + * current mapping is still valid.
>> + */
> 
> The "and we no longer..." part is irrelevant: that's what phys_pc checks.
> But the TranslationBlocks no longer exist, so that is sufficient.
> 
Will remove this part from comment.

Thanks,
Fei.

> 
> r~


