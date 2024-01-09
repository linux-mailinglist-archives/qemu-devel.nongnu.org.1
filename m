Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7189828D83
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 20:37:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNHtr-0004RC-W7; Tue, 09 Jan 2024 14:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rNHtc-0004QT-9U; Tue, 09 Jan 2024 14:36:20 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1rNHta-0001Up-6J; Tue, 09 Jan 2024 14:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704828978; x=1736364978;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=+duKtoOArticCnYrgElMQQwyqMmLvc3J9tW7+ZquuFg=;
 b=GmD7zR88jlTc+TjqbnVcEZto7MT2PkxANhJPG2QmlzzLC8nVOOxT2Nrf
 BgqPIj6vNQJjA8VzVXvGfvxM8gMrh4bbHj2Ucb+LUBowWPvTyUJa0ypag
 1/WEaIV8+yb+VmbhsLnVRRpK/hBj6g7QsXl0frW37iubvDAN6uqUaDs/R
 g6BXNi0j/WlyYgp5RMhURRp2BDhcNG/ZG2MHhfEDQgZ46BqaALl0K85Ao
 lmoTBGMfJbIJwJmQlqSh+tCb5C/GgX3rDtz5GG12uZo9mZC7AIV9vMouY
 waS1DgGsMyM0kbeKThIyFq4oovDm5du41N86dfRGITobt3G5nflvFtC95 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5664338"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="5664338"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 11:36:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="774967991"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; d="scan'208";a="774967991"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jan 2024 11:36:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 11:36:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 11:36:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 11:36:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzOLDZVd4lo5mWuu7qJVwZ/xISvfXNTX/o6z1JO3u3aSA/jaHCAeQ7v2Y7WkyrfkcncCivTEEgdH1zerPyNGxK2e6+OSIc0L0ZvQyK0+tehvBMzISrnEkjzpPdODW4QLrwec5LvVrGPJoFlKDlvqN3AtBLCbqAKq8tKZlq1TRQikrnajBYCKUDnKCfnVA+us+CZS1QIGLHnHdliuZhSDyZyOxZmKu3gZaTSlBNUem8Ykpc6iEB0uxVuSQkg9wfgyPPwvvcXxdCWN1bVqGfXZC1tvu5hHWM/UMrTfntAV9Lqa2+R/0/FBjDl0X7Ma/4tw+iQmARPudcviQu1Sac+HPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk+sBhGEZOQXttWy5Tevj2tWS7Yv274EomyKvG+24Sk=;
 b=Cil5+trXWGjbArrjErEOV6UiGy00gUU3sq85bvDOH1Mp7w0toYUtyunjiH4dfrEaPH7uNvm2boEBndpkrBax8bho5VZ7f9C5cAlpvllW0c4ULBbbbsmS+dzobHlapHYRkxJK2AricTTZ+l723jqixz/HYCWZHjj6XFOawCLH5CLbmCMFzEovAUb/cbd9MOQzRHuvd9F4c+fbr0/+GE2IG31pwjGD0Zx0juSiYwnB1HZK9t0v9ZmSYjSqsI5ZvHuhsuW4v+g76BhUFCjEzqoCcpataTvgz/mWVw1t8JQ2l/YhQGHORbHIkYwdmn1Re+2fQsZdlfEvQk4ODKv79qvFcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7945.namprd11.prod.outlook.com (2603:10b6:930:7b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 19:36:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Tue, 9 Jan 2024
 19:36:07 +0000
Date: Tue, 9 Jan 2024 11:36:03 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, David Hildenbrand <david@redhat.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Alex Williamson
 <alex.williamson@redhat.com>, Ankit Agrawal <ankita@nvidia.com>,
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
Message-ID: <659da02316cab_24a829418@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231225045603.7654-1-ankita@nvidia.com>
 <20231225045603.7654-2-ankita@nvidia.com>
 <20240102125821.00001aa0@Huawei.com>
 <SA1PR12MB7199DF47EDDA9419E22FD79FB067A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <SA1PR12MB719917E2C9D98C04AE9058C4B0672@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20240104103941.019f9b54.alex.williamson@redhat.com>
 <20240109165221.00003b8b@Huawei.com>
 <16d54fd2-9bab-46cd-a1b7-9742674453d6@redhat.com>
 <20240109171030.GE439767@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240109171030.GE439767@nvidia.com>
X-ClientProxiedBy: MW4PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:303:6b::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: 63678b21-9601-4545-4be5-08dc114a39a5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iEh7+p7+jwqwnSpsm8D7VEr56mb3QZ40n9bEFTeC+XkzenQLBrSl47wFK1rPS+R5xD10j0J+hMU0dLZYSHBg/AqpahQT36QjMX7C4EN+L3R9hWZLHFmLUzm9owVzX44EUxEaQIntiQOxsV64HzcrWwmruKKFdnyidIwouvpTo17sL8iRIbVcMIgtScgCxCvjxhXLJlPQRhxDSocHQVv5dyGCK2r93T/1n8kxWYYobAlsTyu65A0eTzwWSY8uW6Qr3pUySdluRPOFe/imFZ9PfURx96Rd6OFAdAYbrnwDZ4ORanQs57nTHYCzs9h1cA0JtLfTHIgOOQ/v3hyHqCZaSQcMVyovgou++9Go+Y9ZJFEeJ02g+yxw/2+dvpXzgmCq9FrGGa4/SDQSOiZtha1upH/MGJoLf635pkqv71bCGDsUxMDOonfbBnAcS51GJaZhkEBuBf9pcVhkqbUNFXL4VX4CQhFgfzm5FFg/asHTmD/e8k2XujMH6bPYYlmAeH66P8QU//KO9Y65+hRkL2QJnuAB8hXuESjZlLmJsRn1J6gMU6UcKXpFwsjyG2t/hVf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(9686003)(38100700002)(478600001)(6486002)(6512007)(6506007)(26005)(6666004)(86362001)(82960400001)(2906002)(5660300002)(7416002)(41300700001)(83380400001)(66946007)(54906003)(66556008)(8936002)(66476007)(110136005)(8676002)(316002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8nEKhfs8XY0mMNsg+4d3e5gSjaf6SJrfC9KFrgv4/b5nQbFGN6Irb+Xfzwyk?=
 =?us-ascii?Q?UoLktBjNuDmk8Qqx77eTRcuufR+dUHAYgDb8UyXMTZwcvRf78s+tqw2NKlSf?=
 =?us-ascii?Q?RNCkd0do7xtyYr3yEQuNIvjKzJpjZ8z5ZB4X/RhB8KIlZfEKH0M7k76PWt/n?=
 =?us-ascii?Q?va9ZQ/6sgckVvrLtNYakxxudL5HuIRTS4QnlLlE0M0rkvMg+g2+HlRt/qIzd?=
 =?us-ascii?Q?xuyrsS1TgLImlYAw0zzlf3TyFusIU+A97Z3H4KHZ3vkLY5IeaUTtrxYD+6cL?=
 =?us-ascii?Q?raBsBHWlJb1vXq40Cdv+4EBk2PzSG0Abnu3RS6zcQ4wnLAs8cy2I3TWSGdSI?=
 =?us-ascii?Q?38cmjt3SO6nUOlH1OuRXdAGHzYcxf+Htn39Wz+ZvciF45q4UpaNn3KIFzqak?=
 =?us-ascii?Q?wgpeh9K9YCRZRsn60x3yqSPxicRiQW8tHOb2uepCAuWg6cIyoARzNsCIYDj6?=
 =?us-ascii?Q?Sar4IlvM6S024ce9CemENdUMu39AiHVokWbGbbrBdNpw2oFekaua7av1C608?=
 =?us-ascii?Q?MU/0dwaxIXeJjJ9ea9QejQZGEZoEu5oHNqIDGNAIS+AIBhTAVNQN/ZpDUeEK?=
 =?us-ascii?Q?yPFi+UC6r4mhDoOpM2SIz4PDyhdR4NrXQYXfkKxXRuYO6RWZxsy6mcwLXlL+?=
 =?us-ascii?Q?262CMimSSII/seKwM3aHElK5F+LQl3VimyHk5AWcjP/ukw59Y3bBAksF1GXG?=
 =?us-ascii?Q?MyG+chSaLCtWzJ5ktcscwLIBhAN+LU5dedF9i9jH54LsL3bcSqyR9worxQDC?=
 =?us-ascii?Q?2Tztpu3JeaHyGZIeKlDIJAcym6S39GjWdWCfAotO4+nBQe10VC3bpYiSpfTY?=
 =?us-ascii?Q?AsamSNWZenP0VnKX1A2gsS2S91N7ZEagbzJmiR6B1h37dEvnK84muskwFGTQ?=
 =?us-ascii?Q?s+JXag/RmmMak77Gt9icZ8Op5sJlm52r0J/Kx2T0g2W+zxO/CsFI/WkBj7s0?=
 =?us-ascii?Q?YOvYHAa+M8DLGxNqq/h+oCyazrkA/+GXNl1mQxTVpPyY2+EDoUvfP34nA/vJ?=
 =?us-ascii?Q?QeaH4bDuzufM/vN7t7XlFM6UpeAltSVsaoLrkvbM6lvaLRNXkJTsqG0NI26o?=
 =?us-ascii?Q?wyNWSNRyxCjTr4Us/ifAa5HgZJIx39b3zWpzjGJ/Ge0+nvCpNu/kUvGInNXQ?=
 =?us-ascii?Q?hyDsX9JLIjTNKx++5IPT5X5dgPnU4pcDneWKqGZVOW79QsX1phOCbb4Waw9G?=
 =?us-ascii?Q?HL+zUbI1Dqw1cfR5hazveAwWd/H2dRsMj9c6bx4P1cYE6dDmHnf65vRjnU8r?=
 =?us-ascii?Q?irSk62JZMBnRFJtv73gIjnvs+rCZAexWiOcnI+gnTyYSKzMawHIjDtztU1eY?=
 =?us-ascii?Q?TpHLrL+dD6jFMbkQQ/xwzmE6D6OGBeBGm+ZpnjPs9B3Fkscc/iC4WvBqgsOV?=
 =?us-ascii?Q?LZvEH7tBbYrvCe7oK19MmGwuCpqmsctFOyge2XJtzDYTnFDkTli23rM0GXG+?=
 =?us-ascii?Q?nKbVvnmZFnQUpO5GYyelxmCMt9TIYvNOf4j7BSUQZo/YqvpPFbb+qIIrayxQ?=
 =?us-ascii?Q?X93ZkAxhTBhYorEG6wS5B4/GR7WqXs1swvfYzCG2zc8sD/EVFSNjxTYYlbav?=
 =?us-ascii?Q?2kL4K5YOAHLaottiQaQHcZ3MSKB6YwSTTCmSPOD3oMM1tc637tCBbz8fmaPV?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63678b21-9601-4545-4be5-08dc114a39a5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 19:36:07.4651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DuBw/oZ+50YaL2A4S7FfUMZ8rBNwKhXAWMOSdEXg6EsucOO5I8muzoeAxpGhiXKRW+r3WVhJMbEx+aW2nuAUhBxVSWu5Y03ErHymk4rv5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7945
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

Jason Gunthorpe wrote:
> On Tue, Jan 09, 2024 at 06:02:03PM +0100, David Hildenbrand wrote:
> > > Given that, an alternative proposal that I think would work
> > > for you would be to add a 'placeholder' memory node definition
> > > in SRAT (so allow 0 size explicitly - might need a new SRAT
> > > entry to avoid backwards compat issues).
> > 
> > Putting all the PCI/GI/... complexity aside, I'll just raise again that for
> > virtio-mem something simple like that might be helpful as well, IIUC.
> > 
> > 	-numa node,nodeid=2 \
> > 	...
> > 	-device virtio-mem-pci,node=2,... \
> > 
> > All we need is the OS to prepare for an empty node that will get populated
> > with memory later.
> 
> That is all this is doing too, the NUMA relationship of the actual
> memory is desribed already by the PCI device since it is a BAR on the
> device.
> 
> The only purpose is to get the empty nodes into Linux :(
> 
> > So if that's what a "placeholder" node definition in srat could achieve as
> > well, even without all of the other acpi-generic-initiator stuff, that would
> > be great.
> 
> Seems like there are two use quite similar cases.. virtio-mem is going
> to be calling the same family of kernel API I suspect :)

It seems sad that we, as an industry, went through all of this trouble
to define a dynamically enumerable CXL device model only to turn around
and require static ACPI tables to tell us how to enumerate it.

A similar problem exists on the memory target side and the approach
taken there was to have Linux statically reserve at least enough numa
node numbers for all the platform CXL memory ranges (defined in the
ACPI.CEDT.CFMWS), but with the promise to come back and broach the
dynamic node creation problem "if the need arises".

This initiator-node enumeration case seems like that occasion where the
need has arisen to get Linux out of the mode of needing to declare all
possible numa nodes early in boot. Allow for nodes to be discoverable
post NUMA-init.

One strawman scheme that comes to mind is instead of "add nodes early" in
boot, "delete unused nodes late" in boot after the device topology has
been enumerated. Otherwise, requiring static ACPI tables to further
enumerate an industry-standard dynamically enumerated bus seems to be
going in the wrong direction.

