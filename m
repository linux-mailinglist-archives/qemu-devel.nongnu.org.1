Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E49798262
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUyx-0005EK-1U; Fri, 08 Sep 2023 02:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qeUyt-0005Dx-Cl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:28:39 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qeUyq-0005H2-7Z
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694154516; x=1725690516;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vmMjNtmaKtVf1u8laaDBa5yJieEc4pfFhaTxe7h9TAU=;
 b=IYYWPB9X088HHmax1T30ImF3nSvG+/KseAuXVRszeYglVV2LA2VFbdEw
 j4MVLMtA2LWadIV47bwZDxgbEENXpcpV+W3RLA3MkvL0NbbStBm2HdX5q
 bgcbCmT8/crcTexRnqdTPTJ4w/Fm53SD1K5vOALo+/ZGCejZuaYfJoExT
 wtGH1lO+wOZQx3HNlqKMVwYSMajFk3YhR3QWc54yU6V6a/E4m+OBMauSo
 wHVkRgC8pikU5Ep00b1jjXFAm7w78SPJxP9/rs5XfIOBs0h6Nl1RkHBuN
 XnBBZQVOErxmHsGLKv6quUF+sbQt1LjkSRhtFOjMrLfQErSJX+e/WIJD7 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="441592595"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; d="scan'208";a="441592595"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2023 23:28:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="719044319"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; d="scan'208";a="719044319"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Sep 2023 23:28:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 7 Sep 2023 23:28:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 7 Sep 2023 23:28:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 7 Sep 2023 23:28:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrKhTiv4O+ME2PhUuR7ke8Tn33wU2RIPkV4PkFTVRlEbXk0RihUNZhpnNAxlnUkYpDTZxCXIJ6T8/OV0XGtdCpuf0VQ9A5eRG0YdTkcwOBec6vl2eLT538MN5VZ6YHqA7/vzTJ6Pfsea8qPwnW8VKloCC8ZyhJCjf8/7yOuHSq3gqNe/i9Cdjf1rjL02URKAcqGtXah+Ur3fMXG970X3Lo8+XL9nazxJNAMlmNzqxr6RBKJTpR11SbZvKpmtD1Ixd9ChX8Lv0Bdanq/DpZYBfdY+MXStoylWl4UaIdjC88U59sGwnLxKVK6uRWqb3NKOR4ullK3dCXbf+HMY80Qycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRdtn3ldERySq6Z+WEiiutR7zK1rJDIGjOiJuhZEVF4=;
 b=hKn8Z187n/+khuJfwOSYCICyR0leNTl8RnRt5sZMwUM0/jXC42oLbHIP7KyqKK3L3POxGxUEKG4WNmA1wAB5ybFDs+ZG8IiaoP24BYj0+uLcpz6g4UokSMlUNhzAhJ2h2yIAw6HXkjb1E8WPWbAZmvsab8iycbUk6AouNuyuWpn2ADpb47qrU3jSg6W8riX02IPpvnBWXDUF25voubmS9bkHji+N4nLmoAf5HJ9Ke+2c5FVfBHKG7xOVKMGJGTSmrH5RJI/44BAQTFehUCANdpTeVG6MpqmMH4Ok9Dz9XYSB9bIfdAnlP1lIqY785kvzHXuADRxVwYWeAnmL0Cc1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 06:28:16 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Fri, 8 Sep 2023
 06:28:15 +0000
Message-ID: <4ab1868b-730f-ea9e-1c06-00d94090e550@intel.com>
Date: Fri, 8 Sep 2023 14:28:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 15/15] vfio/common: Block migration with vIOMMUs
 without address width limits
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu
 <peterx@redhat.com>, David Hildenbrand <david@redhat.com>, "Philippe
 Mathieu-Daude" <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
 <20230622214845.3980-16-joao.m.martins@oracle.com>
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
In-Reply-To: <20230622214845.3980-16-joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To SJ0PR11MB6744.namprd11.prod.outlook.com
 (2603:10b6:a03:47d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB6744:EE_|CH3PR11MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 899d7b84-3190-4996-233d-08dbb034c892
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMETt8BXC6YFPY4bvtUD5sA5CjwLiOqOk4wcLgkCPt0bj14dBWo4h1z85KS+eDIFOXuWArfgd893WtNAI50m8Re317aXftSZNaYegVQyvx0wYicChhrHgt73d613FfUUHIoxdyZXfnavtGjHQ0jlocFLjOqxeVjIHpYcmAnMeGkuogMlT0ybECqp7XDq5IdzvqJ1G3chZDMszEepQdB3kp9UVbe1jXU+SZvCqN+8rnLADEeYvKllb4+p+VVOBmmThEvr2+vkkJJ+qZ0tsI927U12ckM9mKfgkxmGUI4KkDNnlfIhXtJS+tkYnPvu/6azGVgQzPXUuTODF6c6Mklk9wLpFagW2sJB+kl6nkxLcy5S1sJz9CAn0HriqnHVdBb+YNDDCTfSEtwlq+z+Z28P4CIondChwxumg8s6E5Toqps5myjM3uAyz/y2x/jEJY/BhvFdTkEOTBgnluxXftQXn0B+TIJQxnia7E8oLTLoLXf7x7Dah17VSzEumIW6aBtKlRzupUGGLZdP57RP2tXFVdaxInIJG97EW7EAX0l3HeFmbKrxJeoEVr7/XdctVlWSpCUN69HtwYvMfRFROmpyLAwZucAgD/4z58H86IE+lHh2G+R2E5+KF8DSOJrAf5eNQMC8oLwzRl1uFSs6NOGYZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(346002)(136003)(376002)(186009)(451199024)(1800799009)(83380400001)(6512007)(2616005)(26005)(31686004)(5660300002)(4326008)(53546011)(6486002)(6506007)(8676002)(8936002)(38100700002)(82960400001)(6666004)(478600001)(54906003)(7416002)(86362001)(31696002)(41300700001)(2906002)(36756003)(316002)(66476007)(66946007)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWY5VndUcU5uZENNeUsydlFFeWg0ck1sUnpTRUl4RnRoblN4NUVFWTBVdmRS?=
 =?utf-8?B?QVpOTFhrbTZtd1RSSXh5VVk5ZVhZS3FRaE1jeVFTc1pBNGtJakZ5TmFhbWJH?=
 =?utf-8?B?dStRaFFuZTdrVmdPQ0ZValNqUjJ1NklCZVVTRkI3SStEODZHbUlETEhiVHpx?=
 =?utf-8?B?VXhYZmVVYlRRbFhmMFE1QS9UM01oZktzTDNveTJ0Zm9OWVI3M3R6TEVsd29m?=
 =?utf-8?B?dis0WWVBZU5aZ1dXRXNsd2w0NEdxT3JOUWs4VlVIY0ZLQ1ZSM3laNVhhMVYv?=
 =?utf-8?B?emdTTTNLQW9sRWt5M0JzK291N3ZpMWljT3hma3ppRzZUblVqUHp5MUc0Sy9Y?=
 =?utf-8?B?cDltREFkSExOc1Z0alJWZElHNTljeU0vWkNmVEw5eWlaZjVXdlY0S3g4azJZ?=
 =?utf-8?B?emV5Nkc2UUVHWSszUTdBcUE3Q1JxdnhQNTZVMUtmU0FzaTdFKzd1QUlURGxh?=
 =?utf-8?B?SXBUK1VUKy9JYnQ0cTZCc3pqeG1yQlUwTkVpWmh0WWwwdWhQcVNEYjViNVVQ?=
 =?utf-8?B?MEp3cXR4QTk4VXNhcGo5blI3dkNGZk1RLzNIUXJBUUJ0RmsrK1NYMnprbHdy?=
 =?utf-8?B?UWFXclVodG9zSmUvbjl2ZHhPMXJXbmlhV3JmeFRyanJiemxlZEFZbUthM1Vm?=
 =?utf-8?B?d2YzVVFPT1ZZWWVJVk9iK2EvT2lWSVBsMUovdGZlSWtTM0JRa1FnVDl1Q2tr?=
 =?utf-8?B?dm1YWWlRNmN6eTRQVWZ1Mm5oa2Y4RWgyenVmZndueVN5dTJ0UndnWks2Vnlu?=
 =?utf-8?B?bjE1Qmt2cC9GU3kxZ1RpNmZqRTRnd3RiWUVpdHY0MTloUXVURi9wTXUvclBa?=
 =?utf-8?B?ZUdDSnd4TFkxWXV3RjhHd1VHWDhuZ0VWWTRjRGhWSGZ0aXA5V0dreVdrSG9i?=
 =?utf-8?B?UTcrRTFOSTFsYzdwRTNpdTN3c05HRjlPRnR1eHZxNmxLc20zc2FaNWIydSt2?=
 =?utf-8?B?SGxjSFE0dy9RRWdXME5ha1VUWk1hTTNJU3ZRL2JJakdsY1FnMVNucGo5dlVT?=
 =?utf-8?B?WnZnRStkSU5LVFR4ajRtcUloWnNDNE1kd3JaOGRWcGFBS2VYOUtaZFpmQWJR?=
 =?utf-8?B?cXVXNHdaRHJlQWtEb2w0cTYwZE1qajJKb1Q0cTViKzEwdjlqaUVZd0IyT2NJ?=
 =?utf-8?B?YSt4elV2RWN2OVo3SkE1STc2ZDJWV1YvYjVBeU1qMHY0alRVUXlVbGkzTXEy?=
 =?utf-8?B?NUpkanRqTGZmOWxVVFNpbmU4QlZVb2h5K29na3FSaThWT0NRR2Z1V0x1M2xI?=
 =?utf-8?B?VUZ2REVnYm1RSkRPTmZ5b0Yya0I0RTdidUlxQzY2dmVnblBQdy9CalM5OXd0?=
 =?utf-8?B?aWlacDZZOFp6RzBUVGt0SHBJeTdLaVNRQUtwVmUvT25ucklZRW9rMFJkQUFQ?=
 =?utf-8?B?Y1lyS2hYL2pEcUk1Nmc0aWpLTk8wNXFTNVcrRjBKWkxWcVQ1T1JRakZBeDQr?=
 =?utf-8?B?K1RpcDBLQ1lwc0gySzVXMTM4VU5CWUVYdXo5RmRLRE81VkRXYTVrdUVBRFRS?=
 =?utf-8?B?TEkrNTByT1d0MGovcHRZMmxKWGNPYXMyZjl5cFNCbVFTVG1rbmJyTGFsQXZ1?=
 =?utf-8?B?emcxZzdFc1RyU2paVll4VEp0Yy8vWkhlVENFY2tJcGFZcjdMUlBUOTVJR1pw?=
 =?utf-8?B?cUVYazBVWmxyT3RtSmdoRGxGaE11OTNkc0MwYzdYNDgvRXdUZVdRVXNNZWNl?=
 =?utf-8?B?K1hVaG9Tb2pVZ0EzcHkzeSthblBEcGRYdEs3bk9SeVdsYlllMWZhZXhOS1FJ?=
 =?utf-8?B?S3ZNcUR2SGhOVEhnbTF2ZnI5SnhOWnA1ejlraExuZFpmZzh3anQ1Rk5MVzNk?=
 =?utf-8?B?ekVZckVyaTk5UDkzVmFnMlpjMWd3QkpYWDA1cDBzWitSSStsQ2VyZHc0VTEw?=
 =?utf-8?B?ZjEvK1BZRSt0K0lrMkJqVTZyYUo4YnovK3k4QUVqdDJ6bTcrazQvVW9OcTFO?=
 =?utf-8?B?MDA5LyttMm1OTE1JNlBkZkFaeUpQbHhXa09peTFML1p1VXhzZEVJcG1xVDM1?=
 =?utf-8?B?WXQwSTdzcFlnWE9UZXFnU2grWCsrejNsR1h3bHA0YzNRNEhwN2p0MVhQaC9Q?=
 =?utf-8?B?UU5sN3FEZW00ZUd2REpFMnhhamJQUis0YTZ6d0RSODJ4Smh2ODNuQ3lYUzc4?=
 =?utf-8?B?ak50NUdXSTJ3Q3BLaGJKait0RnZ0RHJwZDlvT2tFYVlsZmpnQ0tUOXozbEJ4?=
 =?utf-8?B?WFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 899d7b84-3190-4996-233d-08dbb034c892
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 06:28:15.5794 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9F5+1VgXGGWWpIL787nmBAxiTYqnfkQmU4Loehg1IErUYlVXENbbpG2J3UdWLhQLei0ZyvmSffsUEV9NODy3X4/hsJne5p46znt37pGLBSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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


On 6/23/2023 5:48 AM, Joao Martins wrote:
> Only block the case when the underlying vIOMMU model does not report any
> address space limits, in addition to DMA translation being off or no
> vIOMMU present. The limits are needed such that can define the IOVA limits
> that arm the device dirty tracker.
>
> Additionally, reword the migration blocker error message to clarify that
> we the configured vIOMMU does not support migration, as opposed to
> implying that just being there blocks migration.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>   hw/vfio/common.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 62f91e8e102d..c3cc0dd47044 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -449,15 +449,18 @@ static int vfio_viommu_get_max_iova(hwaddr *max_iova)
>   
>   int vfio_block_giommu_migration(Error **errp)
>   {
> +    hwaddr max;
>       int ret;
>   
>       if (giommu_migration_blocker ||
> -        !vfio_viommu_preset()) {
> +        !vfio_viommu_preset() ||
> +        (vfio_viommu_preset() && !vfio_viommu_get_max_iova(&max))) {

Could be simplified as below:

+        !vfio_viommu_preset() || !vfio_viommu_get_max_iova(&max))) {

Thanks
Zhenzhong


