Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D7673EB41
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 21:50:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDsDE-0007JX-JA; Mon, 26 Jun 2023 15:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qDsDB-0007IY-JH
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 15:49:21 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qDsD9-0003rt-1S
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 15:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687808959; x=1719344959;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iUPDQBgxSzLvunetIDScO6cMvaLUkvWUADuFK6mV+20=;
 b=SztVOvkJw6nGG1uq29ib+rowlr/4DJ63z5saqfder2B6WmUMEaoSWbFC
 wos5ham1fMMsNdUPIru/I8iaX+SKevFkZdccfdn1skOl8ahGkRIk/n/bf
 Y/YOOQztU0Z19aBDmVbBBFPc5pOG9/RwhlfWcywtW9ligK7ZVYwNWCRxf
 30AVQ3fMWOc8jOa4D/JajhF6tvqASXlVDzJfc08eEmhClhvlM4evpMdGU
 WUNXczkQU3GDEMVdtoVAMnJmm2GWcCWohTDj3s4lPvUQ4GXB+xTI3GV2h
 AOs4wJEbfwAsn9w4Cdhrl37Q46E8JKXh783yDuypwWhqHubwl7DF7eaFn g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="447754255"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; d="scan'208";a="447754255"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 12:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="786312252"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; d="scan'208";a="786312252"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2023 12:49:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 12:49:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 12:49:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 12:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRPawvgjoUS2V/NG5e1eKNis6pqG4IIq05MTZTBPICX2iD4v/l2j4/Ft2bJWIscHaEGB5dQKeuOcPAmZpwTlf6kczUCECOFBwUYzWAXXq/CX5mFMbXgFvVbKWLnra9mcOL14zOxw/us86Q2W12FIn6E/FSdRq+yBi8UPIydRLioJkr/WmaCk6cmlrSoV/SgXn9jPNZcPX+e8bFivQkfzeRd6Z8Szv9DB1O+pO/wNuGdPo47WSI5JQ+F+mU/7Pultz47VOYFdzumG1euk65ETU7rxpFJN7S8Mk69CAnhsIv6lZLXr8UqL5q3clGHN8tpo/0STc1Fx7BaWGaAxX65mRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z6e9TYRgCgjwDP6eBGDUvfLyywxOzwp9eWXwvmVkL0=;
 b=ANPJANBkmXn3HHR3RxbpYgB8sm3reyRKiC67ym/rrXeI3qlLoaUdjyVl081kj8fvwzay6MsLnCRm+xfI00FOoiO7KWm/ah90uUUHx4vwiR6TEFp2iHNu2YhrVSnqJq/2wFJ3zNfl25ffNK4sR+ACvVDVEg5a6Bluua7i9SrKxGFE4YYWwy54ffRzRqLTsdIDJOZYUFifCXJ+z73KricjrsCJEvUYvdGnBxfLobSHfXvVzpXEwzw2X0JMorKwr2QVeIgowH+RwCqCxlC8oB8g99T7pURDCGhoeuFoJzHusm27gQ1IH/swMlSohWz1MwExULTWOg6fEoRv5b/bRdX2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by CH0PR11MB5297.namprd11.prod.outlook.com (2603:10b6:610:bc::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 19:49:11 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b33c:de68:eacf:e9c4%3]) with mapi id 15.20.6500.036; Mon, 26 Jun 2023
 19:49:11 +0000
Message-ID: <6556daf6-a3a3-132d-df2c-2914c6bb2e47@intel.com>
Date: Mon, 26 Jun 2023 12:49:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ui/gtk: set the area of the scanout texture correctly
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
CC: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Vivek
 Kasireddy" <vivek.kasireddy@intel.com>
References: <20230621213150.29573-1-dongwon.kim@intel.com>
 <CAJ+F1CJ2cVDAOTY-j77QGj5W1d4wrphcQ2oEUqkw0R4hBX3q0w@mail.gmail.com>
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <CAJ+F1CJ2cVDAOTY-j77QGj5W1d4wrphcQ2oEUqkw0R4hBX3q0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0100.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::15) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|CH0PR11MB5297:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f1e842-f698-46ef-1401-08db767e69a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VsefqqBNr0rF2XLUI3EKz40yr5cJPJN60RTfp7LhRP5vnUt55r3hD9JyqQs1urdzOVDyiGRsg0kOJE7kPA4/pgB0NpfD/TZUFublxtrtJN8Q110vh93/BkPt1jmNCZspQsxTIHNPtS4HT/j1w4iWNk2GWv37X5fJ6KIkjcxTAMSC1F7vxaSD4FQY7i7OlpVJ/VN06Cg8P5SHrZL8N/YI5ovJY/isQsFVaXxWmvfHW8JcxzmRXhfoB21G7QXl4pe8J7u6NaCnR/jqCzOrm14uvOeTJNT43mjR0u3Wy02QHIQPuy42xVWzWJfoQQ6NkqPymBWtsrv4EgeZv5xDNKJKiAMH//5HNXb6mT6PHdoQpM+AFSPqQoFbR1/jnx4n6xGzLpw8kkKPXWvjIxLtsoH2YeVPWp1+OXcybUQhOKRDVi+M2bGYfV1aChmU/z6P3a1kEOwHb8H+hHhsSKbM5JDNMk57oOp02h80VkymE1PTSYQGFIcMMVlTwB7/zSiZySiz3+Uh3YkpXhAVKn4h92bt7lt+xtpPi9eSX/lk9ECHQZr4FITlJZecgNDM43cwwnoA9xoQcjmmh0N3AkiiRFjOeTR+b7jEy8I7Ks/tBw5uqkXaZ643bJEGaWZftG/WqwL4NJenefsj5PvVtv4RFkQ7TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(6512007)(31686004)(66556008)(66946007)(66476007)(316002)(6916009)(4326008)(478600001)(8936002)(36756003)(8676002)(5660300002)(2906002)(31696002)(86362001)(54906003)(41300700001)(6486002)(6666004)(53546011)(186003)(6506007)(26005)(38100700002)(82960400001)(83380400001)(2616005)(107886003)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2VjaEpTMGRZYlpCOWRvUXB0QXIwM3NkZ1ZQY3pYN3hjb1c2UFJHS0djcnF6?=
 =?utf-8?B?eXp4VUx5dThOQjVIaDEwWjM2ZkV2alF5cEwreHZTdUU3VUltZUZTaCt1OEN2?=
 =?utf-8?B?U0dibVl2clFHTWY5bjBNdlhWNVRvUGh1Zm9HL1lOYmdCWXBEeUhTaDQxSXlY?=
 =?utf-8?B?M2swdkZKWlZmUVhtQjlPaExWS2VIUVR3WGx4U21XQkZDNDlPZEpsK2tmKy9s?=
 =?utf-8?B?T2JWelVLenZ1d1RqbTU3VVArUnF0Vi9yVXJjZWloSVpKVUZUUHhMaldLYStI?=
 =?utf-8?B?VDEyd1lCL2hZRStiUmIvUUkwUGpIWkIwdEU2clgrQUJzS1JWbUJlN2I3eUlT?=
 =?utf-8?B?Y1BGTTVhN0RnSUd6bm15b1FOZUhnMGprb1lhRm5FT2xReGNIbFBGYXBRQWYz?=
 =?utf-8?B?T0wrOC9OSFR5Y0FWT1BwK0RqaTc1QXJKN2Frem1xcTMwM2QvZnFMODV4SUhI?=
 =?utf-8?B?LzZBcHZtdHNqS1JGZURTc2dTWlY4dW9yS2w3aFhXZEU5cENhdUlSL2tzNGtC?=
 =?utf-8?B?WnYvU0t4WkVnNXo2WTJMYXZ0U1NHU0cwbTJ3K0RRZkdBQkV3bGc3NzNZenpn?=
 =?utf-8?B?ejFHbFoySGt2R0JRb0JsZkt2ZUFNWVZRZlhXOWJLUkFJOHlFUzhYTjNzcnBQ?=
 =?utf-8?B?ZTNTdG9JSSt3bWJBQmgybkM0L3IvQjVQZloyWTAxV2VMN3ZrOXdUbHdqdHkr?=
 =?utf-8?B?SmNYVGU5czRmWWwwdmVOZllHckNPblNWUzFyYmJEcURUY0tQOWJlbWJPbEdM?=
 =?utf-8?B?YVZXL0RmVUx5TU1YRzNDcTV1QUZxMkxKa3JtbUQ1d1ZmWVJ2bFhnbGFPVFRN?=
 =?utf-8?B?bXpHS3VNeHRhek9QSVMvamJ2dnFKaDBVR3FoeFoxM3BmL3FxZ3ZJVWs2RHlQ?=
 =?utf-8?B?RXMrNkNXaHNjT3pjRnJxQ3NCclNDdzIwYVg3bGFuUXdaVnFLTlZQTWc4R28x?=
 =?utf-8?B?L1djcjROeVN3eGpRNStZWENLMzUxa20wdFZiMCtDOEtoUmRTZUZzOWY2UC9X?=
 =?utf-8?B?SGQzc1A4S0Frd1dka1dydnR3c0cxQVpPUEV0RjZMejh4OHd5cUc0Z0w2cTBK?=
 =?utf-8?B?aXJxNDc4cXpUakt4VFNlOVViTVJ5bTd2QnlicURkcnRwMmFKTjRmY2hoSlJH?=
 =?utf-8?B?S1FvZ05KUmRNNitKMVZuYWZ2WURqc2hlZjU0b1BlQWdQVVRTSTlBakM4Rkho?=
 =?utf-8?B?MjZlV1ozQW5UMDI3c3dHckgySjQxeFRxc3cybStuOHF3cHNZWUQvN2U4NUhI?=
 =?utf-8?B?SmVxbm8wZ0lpdWxtaW8wNVF2RHI3UERSblQxVFBLYzdBMWZlOU5BT1VFRjVk?=
 =?utf-8?B?U1IzaTE4ZmpwSSt4RnRjcDBtV2ttWUUrOHVGWGpzNmRYQUh4eWFFQkpIT1Nm?=
 =?utf-8?B?SURlY3A1T0pZZXRzWVVXaUMzMVNPdUt4UW1PVmFCOHdHU1lsdUZTc3hERS80?=
 =?utf-8?B?VG5vQWF2SVdhRkZZZVdaTnkxdXp0cnFtemlnK1YycVhBaWxoWjc3OWN3c2RN?=
 =?utf-8?B?QmFETTBrZ1F0eUMxRWMyVTkwcW1Xc21nYU1vdDVjTXBKYis4MzFiTE1SakZx?=
 =?utf-8?B?ZGUzTGtrQndWekdxTnRzcXNubDIrUS9MdkJKZU5GTzlJUDFKWnVkaUNRdzY2?=
 =?utf-8?B?Y0tZTjlOMDd0R052KzZReitzcS9Yd1pwaHlTMXlIbFdJQnZpaTFIMVZNL1Q0?=
 =?utf-8?B?SnhoWXEzblMxRndRN3BnSEtsRkNqNWxocDcyM1ZTSnU1b3NJalg4UVB1bmR1?=
 =?utf-8?B?OHdTS0NweXJvYThieW01aEdpUmJwVnI3RzlhZGZ6d1FvUTZGRUlsbnBOeGFl?=
 =?utf-8?B?R050dUpCRWhHazJNY0FxdFNtR1JsZ2hHTU44SW14YUI1UnhYcmV2aUdaT01j?=
 =?utf-8?B?NXR2Ym1SRmt4VS9nSFBQNENGeGI2NjZJb2o5enhDNUFuTzB3QzBnWVora1dX?=
 =?utf-8?B?NktHN1dOYmhENjJRMjhWd2REWnBXRGpXYzg4N2tQVVBvOE1aeXE2bXJ2Titx?=
 =?utf-8?B?ZWZKZytUdXYxdkcxakQ4TGVpaUJjOG9ySjdlaHdmL0xreHRDRFU5Z2pITnJp?=
 =?utf-8?B?WlYrOXgwTktOWGFuYlZ4SnJyNUE2bVZHUDhMN2YxVURYL3JDb3NzdkRnL1NC?=
 =?utf-8?Q?W7s00HTg2tvrqHCZLio0tSeXf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f1e842-f698-46ef-1401-08db767e69a6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 19:49:11.4903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jkrcXMJOV+c5/co8uMmRlLyTwMJIZOVE8MtaCK7zNjH5OYgs2Zj2sFsCsRCZnUXfgCgmpm7reT2wYv9xj9b+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5297
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43; envelope-from=dongwon.kim@intel.com;
 helo=mga05.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hi Marc-André Lureau,

On 6/26/2023 4:56 AM, Marc-André Lureau wrote:
> Hi
>
> On Wed, Jun 21, 2023 at 11:53 PM Dongwon Kim <dongwon.kim@intel.com> 
> wrote:
>
>     x and y offsets and width and height of the scanout texture
>     is not correctly configured in case guest scanout frame is
>     dmabuf.
>
>     Cc: Gerd Hoffmann <kraxel@redhat.com>
>     Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>     Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
>     Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>
>
> I find this a bit confusing, and I don't know how to actually test it.
>
> The only place where scanout_{width, height} are set is 
> virtio_gpu_create_dmabuf() and there, they have the same values as 
> width and height. it's too easy to get confused with the values imho.

Yes, scanout_width/height are same as width/height as far as there is 
only one guest display exist. But they will be different in case there 
multiple displays on the guest side, configured in extended mode (when 
the guest is running Xorg).

In this case, blob for the guest display is same for scanout 1 and 2 but 
each scanout will have different offset and scanout_width/scanout_height 
to reference a sub region in the same blob(dmabuf).

I added x/y/scanout_width/scanout_height with a previous commit:

commit e86a93f55463c088aa0b5260e915ffbf9f86c62b
Author: Dongwon Kim <dongwon.kim@intel.com>
Date:   Wed Nov 3 23:51:52 2021 -0700

     virtio-gpu: splitting one extended mode guest fb into n-scanouts

> I find the terminology we use for ScanoutTexture much clearer. It uses 
> backing_{width, height} instead, which indicates quite clearly that 
> the usual x/y/w/h are for the sub-region to be shown.
yeah agreed. Then dmabuf->width/height should be changed to 
dmabuf->backing_width/height and dmabuf->width/height will be replacing 
dmabuf->scanout_width/scanout_height. I guess this is what you meant, right?
> I think we should have a preliminary commit that renames 
> scanout_{width, height}.
>
> Please give some help/hints on how to actually test this code too.

So this patch is just to make things look consistent in the code level. 
Having offset (0,0) in this function call for all different scanouts 
didn't look right to me. This code change won't make anything done 
differently though. So no test is applicable.

>
> Thanks!
>
>
>     ---
>      ui/gtk-egl.c     | 3 ++-
>      ui/gtk-gl-area.c | 3 ++-
>      2 files changed, 4 insertions(+), 2 deletions(-)
>
>     diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>     index 19130041bc..e99e3b0d8c 100644
>     --- a/ui/gtk-egl.c
>     +++ b/ui/gtk-egl.c
>     @@ -257,7 +257,8 @@ void
>     gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>
>          gd_egl_scanout_texture(dcl, dmabuf->texture,
>                                 dmabuf->y0_top, dmabuf->width,
>     dmabuf->height,
>     -                           0, 0, dmabuf->width, dmabuf->height);
>     +                           dmabuf->x, dmabuf->y,
>     dmabuf->scanout_width,
>     +                           dmabuf->scanout_height);
>
>          if (dmabuf->allow_fences) {
>              vc->gfx.guest_fb.dmabuf = dmabuf;
>     diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>     index c384a1516b..1605818bd1 100644
>     --- a/ui/gtk-gl-area.c
>     +++ b/ui/gtk-gl-area.c
>     @@ -299,7 +299,8 @@ void
>     gd_gl_area_scanout_dmabuf(DisplayChangeListener *dcl,
>
>          gd_gl_area_scanout_texture(dcl, dmabuf->texture,
>                                     dmabuf->y0_top, dmabuf->width,
>     dmabuf->height,
>     -                               0, 0, dmabuf->width, dmabuf->height);
>     +                               dmabuf->x, dmabuf->y,
>     dmabuf->scanout_width,
>     +                               dmabuf->scanout_height);
>
>          if (dmabuf->allow_fences) {
>              vc->gfx.guest_fb.dmabuf = dmabuf;
>     -- 
>     2.34.1
>
>
>
>
> -- 
> Marc-André Lureau

