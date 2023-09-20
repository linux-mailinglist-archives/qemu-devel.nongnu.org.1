Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EC7A82EF
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 15:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiwvh-0007DF-Jj; Wed, 20 Sep 2023 09:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiwvf-0007Cr-Cn
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:07:43 -0400
Received: from mail-mw2nam10on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::608]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiwvZ-0008Lr-JF
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 09:07:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsIb8KGYw9yOAd3mny7vWZRyPeQ/bC+jJk/lvE5D9rwpTnCN/2WBnyq1JhRjWFjkZsPCPInbHNrDb+XlU6Si8mrUJGJKqKzvJibAo6BLOFhV1qgDohXTXAlC89YyyKvSlBXyURjvFc36VMH+tzwgYOyMetis2a7uOMagpN+YWakUDNcTpk65BnkVOMJC9WIIe1bXTdgjSUEYiAupGH/z0/hVjOMR9bMMfbN7UtZg7gqcn6Xcd+U0+/gm8Vkv0k5bLV0HxdaOpMAOiQY8JbAdxnFZIL16PfjPTl1bXyV3ZxI+lwN1pwHQDNrApYPzpevazDGMuYGPwMFDk+2HnX8qVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyYWhGm0LRNvGfGtApty0Vu+hfsDeti7f88ZWkTBRcs=;
 b=L1FGLl4iOS2k7+ws3TYgJpoTy03C51BNmfrQH+gkIo+iHgipXDFsIB2DOaB5VTihnDQ/zUmgcMhh302xz01AzCZZRJz8dFCSmsM/GYIsKY88XONF3rS0nBXjNSD+ly2COmPgd2s3hjOEWkXNmYAzAiqnVFoNEIhh8yAPD7NN0+WB4EH0Gpdcjei7VdbnEs2a/2OQ0GPydnVmHUh8DvMJ1LJilsTR99ydVtps7s5VqjkUmJctDMwh0R5fp5w9+lAL+An7K+IAlJ13aJ5+IytJEmMM9T0MEPzAyrgO1KJLd4GoiA1+hD8QmBpnimkaJ9uFH2v/K6nmzWAu69m6Jm1ILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyYWhGm0LRNvGfGtApty0Vu+hfsDeti7f88ZWkTBRcs=;
 b=lu5TXlp2xP3NCc0WwDg4+z+S044w5mk6jcguhFH1zzKi8hLcFobcE6irWjPSA9PZMHy5qjosVUc3CeyX0y6jd7va5BIzSV0KkJZD7Q5erLZbyUbD0Qx/bQ+sDhAmuGLWkOj51AcZexWPt6B2sNSht01Zz70WZFzyXO2PQG5Ta7ee3QXbjjj7igqPCqPpgCb74qjWbekVDRvILKyohY8HIaSnGppQVULLpD/C4HRc3ED+lNoE3TH2+XRfe4I/jiRfnO4TeTBbnWgb82Deb+we+iN7SGywHwpO392tnXQHlTwRLh2h6gmLBWGqYrpKjCeSXCHpJeKfHbALdJ9UNoGFoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Wed, 20 Sep
 2023 13:07:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 13:07:31 +0000
Date: Wed, 20 Sep 2023 10:07:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920130728.GX13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com> <ZQrtMxCnbcXvwLMc@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZQrtMxCnbcXvwLMc@redhat.com>
X-ClientProxiedBy: BYAPR05CA0092.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 7553cc6f-0329-4aba-0145-08dbb9da8c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IU2AE/s2D/K/hIJHJ3MXjzUc9PeEfZNzV38aCd2iS5kFIGKfRYEYMzeZw7XjK6DyFW+kFBhvoLcuriuXll9cc7jgczgVjOHb8sXN1rajV05Y7TBU8zgoC2LT/W8KNYSndT7QF6Mj7UomRLjpNshb2y5OS613qynXsBwm7H6HTR5YxYkIB08mZViBHgY+d8IZUz3KK3jaoy0Nap6gf8JjGSWKu14zTH/Ki1OKUjc9awyoR8NctB6PAdjM58mj6rnrAosq8ZEMSx9/IvX355UTMr+Eckelk/9Q6Or+23GfB1qG0ZsXoeoc8jheKtvQCkdgWh/FeorCSPTEajMejdTv7yM3GIk7wUKzsiuqvpCUNoNHq6wa2JEA0KHcaojU+JAaXUQDZ91Jeqqe7I8UMjK+DMRgoMIXuByrBhJJjgCusfGMIOPIpBOAFqRYODqdW4FW5XgIw5vpTg9IA4Rkln+84k4Jdj4ukKSOmW0aVetPtGgKjg2/HIi9A7gccMmQqtCLd7ZsN+HocB63ohkWV/K2T4Jk//DV1Gjk0+08NZrashs5daXqbTyY+M7eA1H0nPd8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(26005)(8936002)(2616005)(4326008)(1076003)(8676002)(7416002)(558084003)(33656002)(2906002)(36756003)(5660300002)(86362001)(6506007)(6512007)(6486002)(6666004)(6916009)(54906003)(66556008)(478600001)(41300700001)(38100700002)(66946007)(66476007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NpTE5QYnhDL2hqTW0vN3N0Q2NLQitpVjA1b2pMbko5bDZJU05GMEd6QzJC?=
 =?utf-8?B?L1JiSDlCb0dadTNUVlF3alhRZGhycThXemJaTlphM2RuTmEyRnRlRlJvaEs0?=
 =?utf-8?B?eDBSK0ZpaThxNE9ycEpFU3EweWJYL3pvRUVXejFWaEw4USs2czZZei9ZNUZn?=
 =?utf-8?B?R3hXUy9CdVA2SmNRdS93MndYdklFRCtzMDhyVFJ1ZUJhcmVEWlcyVlZtRnNK?=
 =?utf-8?B?UU5ZVWhteTBKTi8rcC81b1JBcHdzWkxwcGRvUC9jUmlmK2tOdE5TUFE2cXRW?=
 =?utf-8?B?c0Z3Y3JKQ3dQWWNnZ3kreTZoRkNXVWlkaXhQOW05b2M2amZTYnRTdzFMeXp3?=
 =?utf-8?B?a25uOU1sd2FHV3BmY1VaTmErZE9pWU5pa3BrWDFCZHVLTFJFdzJOVWYvN3Fx?=
 =?utf-8?B?S0VCazFjME9TbWl5QkVhbWlVK3F2bUR1MGZuR2cxeThmOERNc2ovbkk1d1c1?=
 =?utf-8?B?a0UwN3lKSnRiSXljNnZTVlBtUDlFTnlqZnUydTRPZ3pBMEszaG9TUXlzR3Nv?=
 =?utf-8?B?ek45OHoweHJZMDVSaE1GdjN0OExCcmJiMGNVb0NjcTloaldQdkRZeUxrSkxE?=
 =?utf-8?B?ZXBEVTVscWhNVWh6ZkFEU2VqRG5XTVdNbk5tU3h3aGdsQ2lhMUN5T3hWbnpl?=
 =?utf-8?B?NTNUeWxNQXRCNnpKVVNoWE1qZGRCSG5rcEdCWWl0SkU3cklNZlFhS010QWo0?=
 =?utf-8?B?STdyU1dQTStnY01XcjhXaTJHR0QrWHF5SU1VT0RxdWRxVk1UY0ZXYm8vNVFV?=
 =?utf-8?B?VXkwR3JJU0FaMC8wNWRVTGw3M1JvRUUwalIxTENXYUdvNDk4VVJKbEVBTWZa?=
 =?utf-8?B?VHRmcWwrVWxicFhQMkR1VmZVOWJMVWFVTFhXYlpLaHhnQ3ZUSnNYcHRhSk5s?=
 =?utf-8?B?NWppcDAxWEtTSk5NUm13SGVoTzdaVENBeGFmemF5d0M2T2NTMHdTZGsrRnF4?=
 =?utf-8?B?OXNnR1o1VG9jZ1QrbitCRFZpMXJHQVF4VTdqZ0NPcGQ2cVZmL1RRNmhCSTkz?=
 =?utf-8?B?UnJkS09VRDRTUUxWOVBwR21DSVlIZVM2Rk9lZ3BMOWl4TFRsT0JvSE9qSit1?=
 =?utf-8?B?b0xKOUk3MkxublJBOFRXUlh6WVhEeTRueG83MEtLb3VLMzhNcVg0TXYxakV4?=
 =?utf-8?B?eWRLeGpZOG80cEMrbmZxUTZoZ3lXUHZoY3h0NFBTOUpqdWNwUG1Hd041N0Fo?=
 =?utf-8?B?c3FJdjZmRzZRL3Y4bnRIcmJ5eHZRL01XckFJRjczV1BOdnpOT3JrcG9OYWs4?=
 =?utf-8?B?L3pnb0RoNk5VSDhOZlpqckRkOWxQYzQ3MjJjYk5LcmpFb1N2eVJ5NUhMTkFR?=
 =?utf-8?B?WEUyWWp0anlpNk9RV1BrRGt3Y1BoMWkzWEI1S3Rac1JEMWNreDYyNXN2cGpM?=
 =?utf-8?B?NXlJUXFwakpKeVkxMVl5MWdIMS9YSzFnamNZUkdEMWMwZGI3S2JtREJ2QlZq?=
 =?utf-8?B?S0FKd1RSekFPMkJ1cmY2Mkc0Z0tuOGZBVTE5b0N0SDBvRk1HVmNHai9wbjFn?=
 =?utf-8?B?OUcrRlNIcGphUm9Hekl0Qjl6VmFQQ0t1cGRkcHFjb3ExUEc3cUprcVJoWk1C?=
 =?utf-8?B?Q0M3eEZqZVpGN3JJNjY1THF3bnJlU1Rjbmh1VGFKK2FVczZSRG5QNDNMdUIw?=
 =?utf-8?B?SXl4TDdMbjA1d1AwanNSVnBNOFZvem5mdDJDNFRoLzF2TTROODRKNTJGcHVR?=
 =?utf-8?B?cU1FRmNTSGdQbkI4L2NLTWQxZEltcXZWYStZSEhLb3hkQVhIZG96ZWd4NFov?=
 =?utf-8?B?VnluL0h2NncvRTNTQWlTY2NxVk51Y0JHSDAxTmxaMmhnajZ6VmpWSnNLcWdX?=
 =?utf-8?B?bk5SRGRobHlQMlMyQ0VHaXNBVklCc3dQRHdlenZKTitLWHZQZkRuL2pIUzkz?=
 =?utf-8?B?M3EvbUUwTko3cVY4OGlJaFFhcmRVQ0ZLeDFOVlBEVVl1NDB3TWg1bktsY0NN?=
 =?utf-8?B?dk9zVnlaNU0wbmZRUlVlLzVkYzM4bXFKNGYrL2NhU3Npd1prdGZsQkJHNmJm?=
 =?utf-8?B?blM1Wm1MeW00cGRjZkJLbzJEbk1hY0RDTGRhTHY1a2F3SWE5RmkrTWxXdnAz?=
 =?utf-8?B?Tm9ubk5Ub0R4OFlQamk5WE1kd3lYa2toaEdyYjhLMUQydngwK2xDTUpTK0tO?=
 =?utf-8?Q?1hyK5dLE0YA93sFkaS/26pA/c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7553cc6f-0329-4aba-0145-08dbb9da8c4a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 13:07:31.1788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztQiUCbr74pvw87smVwAN3qxWL8HMgUymFl4xnq98W2GozC0UYk2YFFEzsRaq9qQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338
Received-SPF: softfail client-ip=2a01:111:f400:7e89::608;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 20, 2023 at 02:01:39PM +0100, Daniel P. Berrangé wrote:

> Assuming we must have the exact same FD used for all vfio-pci devices,
> then using -object iommufd is the least worst way to get that FD
> injected into QEMU from libvirt. 

Yes, same FD. It is a shared resource.

Jason

