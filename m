Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B29749187
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 01:19:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHBl5-0003Ca-QT; Wed, 05 Jul 2023 19:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHBl2-0003CK-M0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 19:18:00 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qHBky-0002C7-U4
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 19:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688599076; x=1720135076;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V/1MQIP/kjAQS0vbkVzTWDOWaePEfopEeBE20u1lEH8=;
 b=ULZgDeSbznWvl1yZUEnzdhoZbQhyQ8MY4AypPTY5imQi5KVD0b8Woo1i
 FiYj6Z0wKhv2u5cUuIQYzK/TJrPrkfv0736hURWyK4WoOrcFL+xTXJdCt
 PDxql2DMhegI30FDpDp2sFMntwn6BdWSihUpZHcAC8vfKk1sU1nMSEV8Y
 6g4WqeZge8Mho9/48a8pXxr8Xpew0o/bGdg1fLVv7LRC3SCnyx9pLNYVm
 Ty5qFpGuy1gsC3WoNV9vtWFtsr/5KoIr3/I7A17PlMARvE7xYdW5C9w0j
 /5vGQ+SsGqjd/WgiIDY84EvyWgjCi8xrnvhFG+IKC3mJfJlOmaOJh6oHb g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="360936554"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="360936554"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 16:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="966000610"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; d="scan'208";a="966000610"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga006.fm.intel.com with ESMTP; 05 Jul 2023 16:17:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 16:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 16:17:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 16:17:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 16:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq1FfQuZXH0xlqHLqREAIrpo4n0ts41dLZZPHIRNQwugz597vqi7KZMXdYxIy0h/kmdGx5+W55UZUF5P5UT0DJ0lkXMut+PBuG7ddQ7gEVycxXeXFh5lB805XCimH1uUnpdAyRu4pFbhJWWFN01dP15IVUIzLDOexcKSYZ0O3uU3AK8OT55RS97Rs9lOq4zkoY2z6WkXrydzEAUq+fR1S9WxDHz2Kl4yHFvXCOkemTj+H4Gz+MF2wQJpPZvBHRtLnVw6t1ivNfGh43eQ6iogP1kUOsYhhgEYQqISjudukwoWeM6kI3iLMj5+zsZkMUC287/j1hDQVPgaUH0FTAE4oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T3qHYvtBUI0F3WmpFUwwhfj2nP6eAFlSgc2GsTSKew=;
 b=RmdcgZOQgTvLXQBbBqLX6nlaB4WQ6Y5DBrueERZVQiw46eqK14dySA9eE6W32u5l3T8AzUGb2QvOXrVuK67QxdVp3LmiSOcqqguWWhfF3w6lRJbtCHM0NcDvncDjn1XVZim6otRbBgCzzR4z9/LweYbUEI1Gk6KapYnekr1MQBoKqkOm1R8u6Gju998V5gUpiS2AmIwf6MWkIk6jh8JFKDFvWDYWTJgQVs9BQR+h02Q8nhlki6bFs5zMpBsOyAxVaCSW33RflmNwryjG2uNRox7e12Lgorhy/DzdXL9pNCdFH173Rf6/PoQfSqLJA+rBurqHjenkbHx/DzUEafmbew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.44; Wed, 5 Jul
 2023 23:17:50 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4%3]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 23:17:49 +0000
Message-ID: <8ed56f58-6497-3a9f-0194-eb11f750aaf0@intel.com>
Date: Wed, 5 Jul 2023 16:17:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ui/gtk: set the area of the scanout texture correctly
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Vivek
 Kasireddy" <vivek.kasireddy@intel.com>
References: <20230621213150.29573-1-dongwon.kim@intel.com>
 <CAJ+F1CJ2cVDAOTY-j77QGj5W1d4wrphcQ2oEUqkw0R4hBX3q0w@mail.gmail.com>
 <6556daf6-a3a3-132d-df2c-2914c6bb2e47@intel.com>
 <CAJ+F1CJOPqXE-uuDOG7Ftz2-ju94hy49XqW9AszEiUtBKoCrRg@mail.gmail.com>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CJOPqXE-uuDOG7Ftz2-ju94hy49XqW9AszEiUtBKoCrRg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|MW6PR11MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: aca993d6-51f8-4132-33af-08db7dae0c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iHlo8+LpDDa5vx7LOGqd3lr+yDSFT3WKQ+zIkaf/wPlNzySoRdXn8bybJhWN+P+RG/iAvd7RGjnDrrOGxzW7UDwB4plI1FLLHWjPEQt0Ce6ZMrc+mrRKW3/16DBHX+P485S3ZuS/usT9hpeBFitjyEorJrzKWlh3AEOsmryRhzz1PW/6yPWxo4pwjzYhTZlnxk6MaEmKCPhw//tJUeiwa3PCaHfAZ1BRj2fC6zsTInIlFPcqbTCcVC896FGbs95K39mJ+oof5xZLsLE37+P5dz1A9rkIGXVBlmfhRTlVidouo4Mc5e+Ye9EyNgiD7pNFODPMwcVrCV+q8RqsHhDIB9CCoUjS0UwoSpvyPoaDjuyqdeT/bIBMVNQrb1P3LC30+okNSegPOS49s1n9knW0OUvlSSX5lkhv9/kpGyXI/F9FWWHC5Q/tzm/4F9tn9H2jVtbQE/MAsa31Is9z0PPV2Z6/wAR+9PHqBwtdGp8xrxPyD44512LKZcSEg3IOHQkZyCl859nVJThH3n8mBR9vd/1N2hmAuv+uWW/l1+YNs1XDbBnTPzdPEuZ/0z/+eNHyFxbiCX5zmCPKQ2JSBRK+KLyMDyqEHhFe1omi+Bs/OoQ/WDVf7p90y/m8tULz3CHvbWM9Be99q3YsqihppiFTfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199021)(31686004)(54906003)(966005)(6486002)(6666004)(478600001)(83380400001)(2616005)(86362001)(31696002)(36756003)(2906002)(53546011)(107886003)(186003)(26005)(6512007)(6506007)(4326008)(38100700002)(66946007)(316002)(66556008)(6916009)(41300700001)(66476007)(5660300002)(82960400001)(8936002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUNKUFpTbGNNRFA3ZndKc3ZZODdVYi9zc3FOYkhOR20yVlpLcWxDYTZvNmlv?=
 =?utf-8?B?SlRrMHR3L0prU21TQk45RXpRbEtTK1BjWmlDYWFFczQ3NER6cXJ0L29MeCtY?=
 =?utf-8?B?aDdyenQrSGJGN1RjZ1EwbjRLdTZURHEwT0ZwVVNvYlNJdnp2YldYbFZ2R3la?=
 =?utf-8?B?TjZ4VUkwRVVXcitzMStkcy80a0pFblRPWURIbUhab2Y3NkorK0U1UFROMy9s?=
 =?utf-8?B?Uk40MFJkMEpkYlNnUDhXRnJXLzJwenVqam1DQUNWcDlvTEtMblZYOUc3Wlpm?=
 =?utf-8?B?MW44cWhjcEhFU1d5YVBvdnIyV1g3eGpWNVBPSE5pbFBOOFYwUzFkd3c2MjA4?=
 =?utf-8?B?Wkgyd0FudXJ5clcwdmVGblE5WHZzTktrSU5aM2M5MUtVMis0ZE9rbnlQZFpk?=
 =?utf-8?B?L2RETXN6UjJ3REJ1Y3RNQUFLaGM1dmxBS291cmMwaVNUYnNWSkNsUjd0QXV3?=
 =?utf-8?B?TEsrVjRGYWhVYmJkWFdneVovWDRMMWhSaVJtUm5DZWVRTTArM1dGaERITytC?=
 =?utf-8?B?ZlJxNzFacDI4MGxtVXorckJmODRxMWJxQ2preHQ1U2pGSitjMFF2UnMzVGNi?=
 =?utf-8?B?bEllMHkrak0yb3JkaUZZK1cvYVprbjl3bWdrcDR0UFJhN2FyLzdha0szd2dV?=
 =?utf-8?B?cllMMHlQcG51VzdFZDY2eENMSk1YRzBLNmUrWk9kMVoyaERhSWVScTZHaU5H?=
 =?utf-8?B?dkppSzZSaGpTeWVBNjJqS0V5dGZseDVOalh0em52NUVZbVRhUHJMRFYyeHhh?=
 =?utf-8?B?OXVjVzExQVF1YWp0MHQ2elV1cDg2RS9MMjBqYVUweWlTWXAzZWVyM1FxVVpE?=
 =?utf-8?B?TUkxZW1vMUw4Q3FoMXV4ZnZMaVEydEsvdGVzUjJZSDUrNjdZMi8wUE14VVFJ?=
 =?utf-8?B?VzExK0NpSWFPTWh4RmRWMDJtZ0gwYmluS3orb29sVGdUOWpENDl2L1lsQldv?=
 =?utf-8?B?RVVlL1ZSK09TVnIvWTI2bGxSbTE0R2pJd2g0dmdXWjdkMXZadktNZkNnMHBC?=
 =?utf-8?B?U3ViWThSRGlaWW8veWhVYkxDaU13SVIvODBpYURzOTBuUG45Sm92aHRKcFRC?=
 =?utf-8?B?elU1UGRDZmZpY1M4bWZtM2FXODN3Wm5VeEVkT0NhWWVyMnZNVFA1eHZRenM1?=
 =?utf-8?B?NjZ3NEdlaUJTVk1uK2YyM0ZwTG5kaXI1U1NlcWNqdWhTQksybGk1M1FYSUZX?=
 =?utf-8?B?clFNN1NKcWdpZDRSOEY3cFZoWDM5NWthY2FwUFpjVHBqVEhPUmhRMnlSdjRK?=
 =?utf-8?B?dWVTSlJYRVB6M1hrdThoU3B1M0R1UG94VXF3YUxOZG1IZTZnRHBSOGdUWHQv?=
 =?utf-8?B?bnRkaGxpUHMxZDZQWVg4NWFPMjlEN0JrSGRKRU1FMm5IWjBFV2Mxa01PcHd2?=
 =?utf-8?B?SHliUURzT3lQUFJ6bWlidXd5VGJSNVZYWEErcDNDV0U2Y0dIQ2xmR2dESmZT?=
 =?utf-8?B?amRLKzh2N3FnUUVkWUdZbFkxOVBRcmk2WUxtak5tSnBVOWhuaTNsR2M3aEE3?=
 =?utf-8?B?Y0JOR1h5NERzMnY4MVZPbWFjRnlpMjlwZFBtMEp1VG5ZNENSTVZyZGl0RElF?=
 =?utf-8?B?N3VEZ3JkOTI3Q3BpSEJMSnlBWWMxYSs3UjVoRzF0S28vTTdET2dLSHZ5MC8x?=
 =?utf-8?B?d2JFQWNMZ2I0UndyRDBURVpCalNLeGJIQUJQODNjZEVNWDZPeEY3N1gvMjNN?=
 =?utf-8?B?dHVwTzhISHlGUDV6dXc3TkdRbzRrR3pmUEtUTWNCMXhib0FnMTdjNnlidS91?=
 =?utf-8?B?V3F4eEZzQ2tjSlcvdXVHR000ZXpjT2YrclllYmU0SnVhVlhlNzVDWlNnMGVl?=
 =?utf-8?B?dHVOOVRGeWwzaStsazVySzlIVjVlbGpuSjgwemM3YlRYVXpRTnVYdmpGSVpL?=
 =?utf-8?B?cHk1VmdyY2daSjVLKzN1MGdiaDlNd1A3cHB1bndSSlFYL2FCd3l4NExNUzBF?=
 =?utf-8?B?S1R0QXRQaHV5MkgvQjQxRmRNcWVkdmFzbUNSQUoyV1pwSjhTVVBRMjFHOXdJ?=
 =?utf-8?B?ckl0NkxjNkFBSnkrQmxKOU5EbTR2WEMzWGFVd3g2QUJzT0FPSytTQ2lPTXRI?=
 =?utf-8?B?K3NvM3dWYWl5emQ2SUlzY0E4U2EzdE5oK0E1VnhJNTlqQ3FtT2dPZU1YU0c4?=
 =?utf-8?Q?+PRHqV7lmfFjpCWOwjWaO4Nc/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aca993d6-51f8-4132-33af-08db7dae0c5f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 23:17:49.1151 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWbHRIvOaXqIf3WikG9BZGM864vc/+fvdlCFur2opy49RYlu7ohikcMANIfykJqYte0Vph/7xwey5iOYIrzK0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93; envelope-from=dongwon.kim@intel.com;
 helo=mga11.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 7/4/2023 9:07 AM, Marc-André Lureau wrote:
> Hi
>
> On Mon, Jun 26, 2023 at 9:49 PM Kim, Dongwon <dongwon.kim@intel.com> 
> wrote:
>
>     Hi Marc-André Lureau,
>
>     On 6/26/2023 4:56 AM, Marc-André Lureau wrote:
>     > Hi
>     >
>     > On Wed, Jun 21, 2023 at 11:53 PM Dongwon Kim
>     <dongwon.kim@intel.com>
>     > wrote:
>     >
>     >     x and y offsets and width and height of the scanout texture
>     >     is not correctly configured in case guest scanout frame is
>     >     dmabuf.
>     >
>     >     Cc: Gerd Hoffmann <kraxel@redhat.com>
>     >     Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>     >     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>     >     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>     >
>     >
>     > I find this a bit confusing, and I don't know how to actually
>     test it.
>     >
>     > The only place where scanout_{width, height} are set is
>     > virtio_gpu_create_dmabuf() and there, they have the same values as
>     > width and height. it's too easy to get confused with the values
>     imho.
>
>     Yes, scanout_width/height are same as width/height as far as there is
>     only one guest display exist. But they will be different in case
>     there
>     multiple displays on the guest side, configured in extended mode
>     (when
>     the guest is running Xorg).
>
>     In this case, blob for the guest display is same for scanout 1 and
>     2 but
>     each scanout will have different offset and
>     scanout_width/scanout_height
>     to reference a sub region in the same blob(dmabuf).
>
>     I added x/y/scanout_width/scanout_height with a previous commit:
>
>     commit e86a93f55463c088aa0b5260e915ffbf9f86c62b
>     Author: Dongwon Kim <dongwon.kim@intel.com>
>     Date:   Wed Nov 3 23:51:52 2021 -0700
>
>          virtio-gpu: splitting one extended mode guest fb into n-scanouts
>
>     > I find the terminology we use for ScanoutTexture much clearer.
>     It uses
>     > backing_{width, height} instead, which indicates quite clearly that
>     > the usual x/y/w/h are for the sub-region to be shown.
>     yeah agreed. Then dmabuf->width/height should be changed to
>     dmabuf->backing_width/height and dmabuf->width/height will be
>     replacing
>     dmabuf->scanout_width/scanout_height. I guess this is what you
>     meant, right?
>
>
> right, can you send a new patch?
> thanks

https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg01081.html

Thanks!

>
>     > I think we should have a preliminary commit that renames
>     > scanout_{width, height}.
>     >
>     > Please give some help/hints on how to actually test this code too.
>
>     So this patch is just to make things look consistent in the code
>     level.
>     Having offset (0,0) in this function call for all different scanouts
>     didn't look right to me. This code change won't make anything done
>     differently though. So no test is applicable.
>
>     >
>     > Thanks!
>     >
>     >
>     >     ---
>     >      ui/gtk-egl.c     | 3 ++-
>     >      ui/gtk-gl-area.c | 3 ++-
>     >      2 files changed, 4 insertions(+), 2 deletions(-)
>     >
>     >     diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>     >     index 19130041bc..e99e3b0d8c 100644
>     >     --- a/ui/gtk-egl.c
>     >     +++ b/ui/gtk-egl.c
>     >     @@ -257,7 +257,8 @@ void
>     >     gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>     >
>     >          gd_egl_scanout_texture(dcl, dmabuf->texture,
>     >                                 dmabuf->y0_top, dmabuf->width,
>     >     dmabuf->height,
>     >     -                           0, 0, dmabuf->width,
>     dmabuf->height);
>     >     +                           dmabuf->x, dmabuf->y,
>     >     dmabuf->scanout_width,
>     >     +  dmabuf->scanout_height);
>     >
>     >          if (dmabuf->allow_fences) {
>     >              vc->gfx.guest_fb.dmabuf = dmabuf;
>     >     diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>     >     index c384a1516b..1605818bd1 100644
>     >     --- a/ui/gtk-gl-area.c
>     >     +++ b/ui/gtk-gl-area.c
>     >     @@ -299,7 +299,8 @@ void
>     >     gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>     >
>     >          gd_gl_area_scanout_texture(dcl, dmabuf->texture,
>     >                                     dmabuf->y0_top, dmabuf->width,
>     >     dmabuf->height,
>     >     -                               0, 0, dmabuf->width,
>     dmabuf->height);
>     >     +                               dmabuf->x, dmabuf->y,
>     >     dmabuf->scanout_width,
>     >     +  dmabuf->scanout_height);
>     >
>     >          if (dmabuf->allow_fences) {
>     >              vc->gfx.guest_fb.dmabuf = dmabuf;
>     >     --
>     >     2.34.1
>     >
>     >
>     >
>     >
>     > --
>     > Marc-André Lureau
>
>
>
> -- 
> Marc-André Lureau

