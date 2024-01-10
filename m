Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F3882A4EA
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 00:19:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhr7-0006fq-3a; Wed, 10 Jan 2024 18:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rNhr4-0006av-Ij; Wed, 10 Jan 2024 18:19:26 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rNhr1-0002vf-KF; Wed, 10 Jan 2024 18:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704928763; x=1736464763;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=21iPOqGaYY64vErOH1j0O4bxME1VWPYhZY+wnf6zlso=;
 b=VqzE8ObTEG5iuWdRfMxNN/yAJuiG6wnGYWueVq6VfTI9orSkRFc/VUck
 hGDW0qWVf3t5m5IMGpwOXdwDVowq4M//9UGGs16qB6rZrcMsjy2z+hqS3
 4NyaNbwQb3r1aAeSUxTYAcwtGogYljMr8+bITvin2r1l3eNxNCCrBInzI
 SV8y3P5YuaTyd48ShFhQTrgff5cmmZAi2mZ9yXsNQ5AtWa4W/RlwTTcEn
 l31tF7+Q1d09dM2hG8d7ebHVIyK49WsiK8IRZRhIdgplA4wQDcslNb+bj
 LihjOzTFWhPHFWJ9F8Fje97WyhOfjNM8qD0/leQIV8l4c1RyWW2KIjvcr g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="5451643"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5451643"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jan 2024 15:19:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="852740232"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="852740232"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jan 2024 15:19:14 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 15:19:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 15:19:13 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 15:19:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 15:19:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbIJWdZdeOBNgJ8WIYgRxEM2W+tENCANh75Xn8IngzpgiybWQPdKasarPOXgvF2ozPGy42jMyggr+N+mh4o1TDYvwWzuTAHqWyVFMvuYVD6D+vtJeW78B/tHDkkHsThgdNxNvChcww/Z5ZDOlpcRk7opVTOyQ/7I8LRmulOYq2anavTC0HddzZtd8zY8LvlgQYfGlbKig0kJbvS6eFsK6EnYtqp2V4cbrob2vWu/2pPyl8OzYwnotTw+OrHMWg5ktQsp8C/fiWqqnfEitmNOXD22LPnghwrl05Wns8ANVyBjdjNmY+emfAwMOWubUW1htQ8H1vSP5vg8GiVCcBNExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PhcizczpqULF9Ft4RIpGl6zH8fjAGlYr1WruhmpUwiM=;
 b=nYuRiNNzOxwDsU1LBw96oV7UWo8sNIRjz0OaiXkUwkYmqOJuNXHkzjOZAyVzjJP3qfvfo+sPj9IvHv+PBZsPk0U058KhQqmNoB2A6symUPD+AqNJXEACn7Jsqw4adUCkZ658jX0t40w1NWrmfu9i3Y4EcrvIRBCVp4OLgVzQX0g7UeJ2MBuNDVJSrjGd5Jj1TKWFNsAF235layy0uI9gfW/qBOOpS6MzNORPnkRz+c7JNPNiOD1MEd4javM9zYwwn1AwiueP0mHsSUH8Ebo9Ksm8sRj8SrTOsAufz35B9xaMLViTL0c8/JY+xJUfVQ6FOn2tFwjMcd3qqJ7tM2F3qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6974.namprd11.prod.outlook.com (2603:10b6:510:225::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 23:19:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Wed, 10 Jan 2024
 23:19:09 +0000
Date: Wed, 10 Jan 2024 15:19:05 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: David Hildenbrand <david@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alex Williamson <alex.williamson@redhat.com>
CC: Ankit Agrawal <ankita@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "clg@redhat.com" <clg@redhat.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "gshan@redhat.com"
 <gshan@redhat.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, "Andy
 Currid" <acurrid@nvidia.com>, Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke
 <udhoke@nvidia.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 1/2] qom: new object to associate device to numa node
Message-ID: <659f25e98bbb_5cee2945@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
 <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
X-ClientProxiedBy: MW4PR04CA0360.namprd04.prod.outlook.com
 (2603:10b6:303:8a::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: f2217129-36b0-4b2d-2300-08dc12328c1d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +myjv1/8FEzZxcdLUp8QbNWqsUZOytwvtfH0Dzh62y+HxNFKnM6Hl4aR9/Pn6dIEjjNpT4E/cS5wXrlZCOa0nzT026euksWGfHzs0oDf6G1PrnbPrTNe1pJWPzOCDpudqCWTaVliHrDn2G9BcD/lClPn4Q6OSokDuZPejkTwXLnwmNv+1fWz5k+oLCCptl+NJg3KFvyWXx5wRJ6h5H/fcbfCBkEg0ayJaVh/c2jesQPlIiBq6W/qe0s+qeBF8S9Xs2YgFtF7AG2jNR9y3hd3CaKYoKaSyXy263MCw6Fbv9MethpWK7JbX8NVVJr9WfFVQqe9+wi6b+IVWfMig0lmf5lzdjuldx1ibWfci5SoLt9rMLvmZvPI1aWpQ2o2Ca3f2B7RIsZfu8refIvAMGfjTRhQZpobvBW6GrXV6OiHWPvU/ax4roKj8BM1249sNtodgXpPQnVZzuhmy1595Te2iJqJ48uLdivNk47SADPhsflaToJCly6nRfKdIuRGzDisoLp8EDJYctTh0fUV5Jv10hPrEoMM9/RufaGjzlBVE78q+d8/z1TycAVgP2TKN3x++4I2ygEnzLCURqRmpI29P0ah72QtcIrOj1YOqsEFues=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(86362001)(53546011)(6506007)(26005)(6666004)(6512007)(6486002)(9686003)(478600001)(83380400001)(5660300002)(41300700001)(66556008)(66476007)(110136005)(8936002)(4326008)(8676002)(66946007)(54906003)(316002)(2906002)(7416002)(38100700002)(82960400001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2hbdUz+UotF3Qzr07wyv3+H2OYBanxuEPu6TUxhGLBB0XByhOwrLgdECI+5/?=
 =?us-ascii?Q?jiD9otgKvyrxkFCj31QdlPgBoj+boEQLhjNr55+UOEObeEzh3ieT3s23DhDG?=
 =?us-ascii?Q?HHO6qIe0GBNnfawpdJEepURGF4i9JL9eIVhKlNUQf0fEUsAJu2cTKeHnQ1QU?=
 =?us-ascii?Q?GEz7OF9QbRsFr7erNEsoF6du8PUJBihNgMf1TNzpl39eDvmeWauyttBOAh0L?=
 =?us-ascii?Q?YpwJZDZ5Jtv/4+jdUFmtTYA0cyEpcUE0AxNdNHtlYM/rMP9xPEaLOg5bsekb?=
 =?us-ascii?Q?8ruD/ASf+4VZNmbmEyMl+rRlcbMf1rp1x0t4g6Zdd39MLDT7XBcpiEmh19lp?=
 =?us-ascii?Q?mfR5440nAp6WfVLDWapiaBnbm6hIsxYNJ9B1RyeuG7ml3td/ifCzAUKhS3jH?=
 =?us-ascii?Q?LEPjcKMnwJsg/ct8/B8M6+7X7CMb9RpPr4xehTUwTKNz2y+vDnVFvcYgz0ou?=
 =?us-ascii?Q?LTiKQSz4FZX34G2aO9A9MsXzWbwsOb79/6ekU9AQOtCWvLu+Tm9flxQP+oM/?=
 =?us-ascii?Q?V5XvJc+voq4aDxL0MBXpeCEkAjsrtUPn2OLcltittza/U0C8zed2UUJccXxV?=
 =?us-ascii?Q?ZYGEiQqLS2DdTDLC6Rs3TlBy4cC+v+xP3BzFnEhNZBAFXPrzDKdm2dE3FCxR?=
 =?us-ascii?Q?REB1GTPE6pex9p1LIzQsVx/UkTKgqVpVWW4vzXljMAZ8qozrJ9csvuP1ouml?=
 =?us-ascii?Q?JgCfMHT9UB8CwEBbz0tzJZp4Tg/Qpv4oVveARQ3yJpBSBvm7uwk2fvftUwE2?=
 =?us-ascii?Q?2UZOLWabkbBg7z23lh2DpUoWxrUEUbvFGkWk2pdb0/CJiw6BXsfzkU2RZgNm?=
 =?us-ascii?Q?svyxOj+a3syXbM1V+pMDtbsFQDJSr9SN1EMROoNLUQLC/ulwZP537isNCdAh?=
 =?us-ascii?Q?1DgcWAGIAz3Nhkw/WZiBKyMPQkQrwu6o1c6an6xAVvN2J8EZsZirpxjh8AOq?=
 =?us-ascii?Q?Z2q50HMjrnB2F6UVja//Gmn4hmTMBOy0rZRI97RrA+Yy63tmSrvsQSQN39O9?=
 =?us-ascii?Q?GSENNwW1tJFb91cIJF+Yb4qn1Lcg/9FF5s7CgoTP6qtDrhiaFLKChFL9VZFN?=
 =?us-ascii?Q?gXtSXBR03T6LaxgwtEARSS/AeH2seKY6E2ymGOC8RtSwmZhPMmWFRqYASZUz?=
 =?us-ascii?Q?1hWKZnNycnXhHIK8C8laJhRDEFL6+nsP8oSxgmkyTrXhruckeZA7hfjNmAHn?=
 =?us-ascii?Q?zsCQVT01IJAZgppMGFngtAzbj787TAX1cUHxpXiPtf2xtMHbIfpm3Jb8TZgZ?=
 =?us-ascii?Q?JnOMfGSTSrTrhVl5Z/xCylDbklIcMunmCHZvjHQnT946SHKlsBjsrEC5XlgQ?=
 =?us-ascii?Q?mhmccMdN6fIwUAwhUE7nESRc1hAw96TUskNND5n/QX6GLaCddZBKWtx9nVII?=
 =?us-ascii?Q?+a+qj4t63FGEyxahI8IB+EG7EWaUKtpsaJi30bvgFva9YsR5JVDcnDZKy2ou?=
 =?us-ascii?Q?Xky1jtIqIXfASX9iXFgKoJ1SZSwFxq9pGRyddPzIi8QV1Iu8MXDJXYDeWiTc?=
 =?us-ascii?Q?oYQXTDuKX9Wz77GeKeFgciOT6O5YEcUcBAj717Mdg75HUE13BV2x6vpfSdSC?=
 =?us-ascii?Q?d7k4PMIEhL0z40GiskbbHckRvj/1SIlZ9F2jCF/B5DlrYmcQqE0sgi18+voU?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2217129-36b0-4b2d-2300-08dc12328c1d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 23:19:09.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6A/pPXwLZlFMJPggxYXSgWCPTPHnR8AewA0xYmv7B4WT21yPq0DfMYG1HiCswaTLWsnOBZq/VAMKzhOW47rorHRYQGsj4eJ3olErUdA08A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6974
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

David Hildenbrand wrote:
> On 09.01.24 17:52, Jonathan Cameron wrote:
> > On Thu, 4 Jan 2024 10:39:41 -0700
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> > 
> >> On Thu, 4 Jan 2024 16:40:39 +0000
> >> Ankit Agrawal <ankita@nvidia.com> wrote:
> >>
> >>> Had a discussion with RH folks, summary follows:
> >>>
> >>> 1. To align with the current spec description pointed by Jonathan, we first do
> >>>       a separate object instance per GI node as suggested by Jonathan. i.e.
> >>>       a acpi-generic-initiator would only link one node to the device. To
> >>>       associate a set of nodes, those number of object instances should be
> >>>       created.
> >>> 2. In parallel, we work to get the spec updated. After the update, we switch
> >>>      to the current implementation to link a PCI device with a set of NUMA
> >>>      nodes.
> >>>
> >>> Alex/Jonathan, does this sound fine?
> >>>    
> >>
> >> Yes, as I understand Jonathan's comments, the acpi-generic-initiator
> >> object should currently define a single device:node relationship to
> >> match the ACPI definition.
> > 
> > Doesn't matter for this, but it's a many_device:single_node
> > relationship as currently defined. We should be able to support that
> > in any new interfaces for QEMU.
> > 
> >>   Separately a clarification of the spec
> >> could be pursued that could allow us to reinstate a node list option
> >> for the acpi-generic-initiator object.  In the interim, a user can
> >> define multiple 1:1 objects to create the 1:N relationship that's
> >> ultimately required here.  Thanks,
> > 
> > Yes, a spec clarification would work, probably needs some text
> > to say a GI might not be an initiator as well - my worry is
> > theoretical backwards compatibility with a (probably
> > nonexistent) OS that assumes the N:1 mapping. So you may be in
> > new SRAT entry territory.
> > 
> > Given that, an alternative proposal that I think would work
> > for you would be to add a 'placeholder' memory node definition
> > in SRAT (so allow 0 size explicitly - might need a new SRAT
> > entry to avoid backwards compat issues).
> 
> Putting all the PCI/GI/... complexity aside, I'll just raise again that 
> for virtio-mem something simple like that might be helpful as well, IIUC.
> 
> 	-numa node,nodeid=2 \
> 	...
> 	-device virtio-mem-pci,node=2,... \
> 
> All we need is the OS to prepare for an empty node that will get 
> populated with memory later.
> 
> So if that's what a "placeholder" node definition in srat could achieve 
> as well, even without all of the other acpi-generic-initiator stuff, 
> that would be great.

Please no "placeholder" definitions in SRAT. One of the main thrusts of
CXL is to move away from static ACPI tables describing vendor-specific
memory topology, towards an industry standard device enumeration.

Platform firmware enumerates the platform CXL "windows" (ACPI CEDT
CFMWS) and the relative performance of the CPU access a CXL port (ACPI
HMAT Generic Port), everything else is CXL standard enumeration.

It is strictly OS policy about how many NUMA nodes it imagines it wants
to define within that playground. The current OS policy is one node per
"window". If a solution believes Linux should be creating more than that
I submit that's a discussion with OS policy developers, not a trip to
the BIOS team to please sprinkle in more placeholders. Linux can fully
own the policy here. The painful bit is just that it never had to
before.

