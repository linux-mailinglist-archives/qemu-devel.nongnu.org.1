Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDB07CC9D5
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:25:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsno6-0005Ce-J4; Tue, 17 Oct 2023 13:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qsno4-0005B1-Ic; Tue, 17 Oct 2023 13:24:36 -0400
Received: from mail-bn8nam12on2061f.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::61f]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qsno2-0005Rp-Fz; Tue, 17 Oct 2023 13:24:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U+tVArzMR2AouONb3B9AmSIVNiu3utyJXThl67p8GY7LYL4vrAIPsxSU8fgAsySaNryLmsZL8p0oiLim9cfHi1kpnF4DjqOMZNxbwt8y+N/hdiHG8AO8VSrURUqmFIj95NVZ5+9Izhkv9bJdTC+VktsRhZb0vzGFJkE9UiVljNp8XunIeeDm6moQA7jsYv8SYiOAo7zHb8VZuPyE9GGfPShikRQglBpcRjV7Oc+Bc81CYuXDV5p2QSnXLSEXyU8gQ60RtWuOThIrvlEjz9E7l1M4Q4L7zCdl7ygIXVyWCmi81t416Nc44PgbvUTynS90VdHyU1AV4G9X440FjP4ayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1i58QPvcSvNtgg2jJmmYRf4OmaIebdQUKrC9lSQZ20=;
 b=kA+4FCpoKWvFicM/fVB3tQ37A7isbZmcYYLNJjXuALRwgbh+OPdPlRdG89DHAXaqwhwoCA7ZKCKPZb/ftmMFks+V4hUMYDe2kx9s/10guyq81YN0sFQXUkXpE73YetniOsN6i3Pyb0VyffzlnvqaIUc2q/XUXf+ItGAyyec6VOIYfcm32oHzn6LI55lWtrb71fTcH8d5UYmILscUeJoJnoCuG4SezzidfjTWCwM+6LyCYyXYm+Z2zSGe3yvV3kjaxoaxU9QD0OjtSI62g4ez5dl8iFZPgusehN48VWBsWo/IMiyE5mTMDH2gNiBDYYxFpfFwBSf8mHCmT3aquq5xpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U1i58QPvcSvNtgg2jJmmYRf4OmaIebdQUKrC9lSQZ20=;
 b=Y484X4N4e3I4x1Y5REaNqwNKXx/ev0uTng6rCgwbXjcdBPlJVPlzS4U18tr4O83ErcXmaDeqLSEs1bydECLyKDAQmRTF5xJTJ+YJtldNMaWLnKQ9s3YPrGaD14hRyTNIrKswAttLzxJhfIqgagpyxIU9HYpAaUVznfKnNIfgQpkRTkUllmLO2i78e8oKD1rAhrSpq6ek2hrvr2JTfBcWogOOn+R9CFFQPsBCRhwIYL6jqLaqgRf+Jgj8hv/ix6U7Ar/+odzlu82m0AOj808GUclQ3RXq/v1bbBHP/WtJYT5x1tKzJfMAWJQgb3aNO8acCLepHRLy+2ukb0h0qXC58Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 17:24:28 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 17:24:28 +0000
Date: Tue, 17 Oct 2023 14:24:24 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "eduardo@habkost.net" <eduardo@habkost.net>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "david@redhat.com" <david@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 libvir-list@redhat.com, Laine Stump <laine@redhat.com>
Subject: Re: [PATCH v2 3/3] qom: Link multiple numa nodes to device using a
 new object
Message-ID: <20231017172424.GN3952@nvidia.com>
References: <20231007201740.30335-1-ankita@nvidia.com>
 <20231007201740.30335-4-ankita@nvidia.com>
 <20231009151611.02175567.alex.williamson@redhat.com>
 <BY5PR12MB3763CA80432643CE144C7A23B0D6A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20231017092116.09ad2737.alex.williamson@redhat.com>
 <20231017152830.GC3952@nvidia.com>
 <20231017105419.1469e5c9.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017105419.1469e5c9.alex.williamson@redhat.com>
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: cb12fa9c-b6d0-41f3-1360-08dbcf35eabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wYfg7X+vky8FUrWUpEdz1TDdlDW8+8lWT0XLHaujL/jhEvGEvN9bzksWleu0vYOcLiGdifNY01CbqfmSvqx9mUgIJl5EzkxHK7DfPrtJo50BUjci6WfFoY/kSyZJLSfGfkzXiH/ctGNQt9mlbi8Mb60T3/P3tTLLjjP0JG6rKcaIa+wLc+etz7USUNBQ3CgHTWODKZFQbnvqK2QGlIvYIRzRP+4rZAInpk3zfCicXyT3gZSlDyBh7MsMIGgnAfIQ3YPRowF+E8Wex039bETelrZQTLup0ZoGUl+gS/GxqWN4p5HFwCAypL6uFAoV8fmL59XD9JY8+N0cjAIwMFUi2TiZL+djiQnjR25PG4npxkDfIwjpNOISLOTPLsnj46nNd0K/y0zeflF2iRUU9e9Q77405hWXpmE/RcRbqkupXmgTSsC4VNbm8GwbRk2gZuYbTwmKnlBWhu3EK8Rj9CfQ6rFfrOccA3A8+5316l3MLEMBX+rkCK4a1qhSB2w3Z3mwHWeB6e7Zmeh19MTvxVIxbhP2zZD8dLkhuaCtdFEOTpaZXy2LwPvoyqdfhcxpt6nu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66946007)(7416002)(2906002)(6486002)(86362001)(41300700001)(478600001)(54906003)(36756003)(66476007)(66556008)(6916009)(316002)(6666004)(6512007)(6506007)(8676002)(26005)(2616005)(1076003)(83380400001)(33656002)(4326008)(8936002)(5660300002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioCQVjJBCIbEL8JlEmg5dUfic2H0gal7p7cuRVr23jxgoDInSQDACxA6PNTy?=
 =?us-ascii?Q?xdtf6XxWwVOHLT3uWGv04gGrl/ILDGKQqMOseWVFbdSFYX7md4pdJYug0q0w?=
 =?us-ascii?Q?bkZL0q9umZHI6/Mr4YpEZIOWHVKGZnvMUQDUj9M6KNJz/r2ZldLsd8UKnHWE?=
 =?us-ascii?Q?/91Hb5n7YQ2tTvrHGEBpxoZCRaR3owc4qcFiBamPENPGjoeRQ4LS0sTt6Y59?=
 =?us-ascii?Q?JsXOBikAV/Ky+yPUoe0fQGGk9WnfrddVYEGWdKGM0hBuFkhbK80DS/mWpd7r?=
 =?us-ascii?Q?ibABuFxGH2jB91FZsuNrTOjCrQ15kE7Uol+2zTvEQeO7t5UvyoDzP5hB4yXM?=
 =?us-ascii?Q?JTB4HY4KXnzKWyj9E3Jgb/psS2s7qCsQvFotsL0wLnVdoGJja/2BBC6JXFB2?=
 =?us-ascii?Q?o+q/LSIDr4p7V45towIWUtO4VHgsqk9i/ZlayNMvC77V7o0e36x3z8aRsc3l?=
 =?us-ascii?Q?Vi/VD074BscIDZUFe9wSff3pBoOIyyU/ytAipGy2SiJHuiUP9lUFUBpWrP9P?=
 =?us-ascii?Q?Nl5dSLlyoyanwM1GljBGPUvIONyA3Fcd5R6N1vIruw83rQaZj9ouQPtQWwg/?=
 =?us-ascii?Q?oiEdKe+zzOl+vlgMf0BbQ6gUF2jx9sHxcDhbD6I3E2vxZ0TWiTGt5guvqerX?=
 =?us-ascii?Q?hxdRa5FI/YTFoU1x/ddvUUP5KkEbpFKyXcob0SXMQ+lUtcApmltGWBqmmG3q?=
 =?us-ascii?Q?OGuipgjxSHRzhsM2i7pfv5wF7wYPgQWjirK6CYSKYAxHkASH6bbkkdZakonQ?=
 =?us-ascii?Q?oXdEHXAgACRygygHVzRnhzxdn6t47sRFCsvTyciqEaVM2drWHpY3/HkacJtl?=
 =?us-ascii?Q?SKwWqG6umyX4ywh33/KzqIW1SD1wBwofzSlmYdudUQ868FGTDhyo6zR1ggCg?=
 =?us-ascii?Q?RnbXobvuKaqVkb37bMJ1lXWU45oZWxPe4XmCu7iYaj+BTnHwS44krYHBnRZh?=
 =?us-ascii?Q?ltbN9ndkyGRbAvCurZ9IfGemmpS1zZw49aQXSBFQorAgp6CVok3DuTrnNkFE?=
 =?us-ascii?Q?gDlQPci1a9zfCuxKnEz+PrRkDNoMiPDToAJNsmBW+KQYGrunWvcFLHBMTegO?=
 =?us-ascii?Q?O4qKOK6lY0t1QDW43Xioc8VTPU8nLDy69eFQxmD68zRWSafAgHUV4ZNtSdQq?=
 =?us-ascii?Q?vh6zv6z/tVIkxRCJIyQr/CHar+CVlWqOGpwnJGxny/8mgrbP8P6hk8/Zu+4p?=
 =?us-ascii?Q?pLrnbINwjjvjxX6SsqxzoN5JZTb7HNnRigU0JDwE4OsjeTWrf+QPlFIdwf5h?=
 =?us-ascii?Q?HrV/yLwMajfj9CzJOCbU8ztXOoMendtpS/n9cIOeXxfQjoquK5hFnJ1YA1AS?=
 =?us-ascii?Q?Vu0MxL2VbG3m9Zv3Y3nBEb8NyqqxvKk5YMqAhbS+qhliE+jV0TwaUp5PKwNJ?=
 =?us-ascii?Q?7uHAuhChCtI47pFu0h+wPUvxB5UVnk10aXGuyJPFyZ8mNEi4Wft28BhqvFyA?=
 =?us-ascii?Q?zhzf30GiUIDHmL0KpCHoKUDb/Sh2XSDGXdnc5b8GxlPXVWzTqMe4orEJH1L8?=
 =?us-ascii?Q?zx+MU2a1x5qcb2xIsYnyf9+1vibSPbd4gZ50oXq03duQR2cTBw2rdxCzZoja?=
 =?us-ascii?Q?ioaXp5wb0eJmXqVpYAo1+cyBRrc5zviP6mo9/mt8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb12fa9c-b6d0-41f3-1360-08dbcf35eabc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:24:28.3038 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxV69sAtyoKIT0OHd4X/JZVd9puvAR9ndgy8w9qedCDju7E0F94+EMhQyOz8+vX4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::61f;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Tue, Oct 17, 2023 at 10:54:19AM -0600, Alex Williamson wrote:
> On Tue, 17 Oct 2023 12:28:30 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Tue, Oct 17, 2023 at 09:21:16AM -0600, Alex Williamson wrote:
> > 
> > > Do we therefore need some programatic means for the kernel driver to
> > > expose the node configuration to userspace?  What interfaces would
> > > libvirt like to see here?  Is there an opportunity that this could
> > > begin to define flavors or profiles for variant devices like we have
> > > types for mdev devices where the node configuration would be
> > > encompassed in a device profile?   
> > 
> > I don't think we should shift this mess into the kernel..
> > 
> > We have a wide range of things now that the orchestration must do in
> > order to prepare that are fairly device specific. I understand in K8S
> > configurations the preference is using operators (aka user space
> > drivers) to trigger these things.
> > 
> > Supplying a few extra qemu command line options seems minor compared
> > to all the profile and provisioning work that has to happen for other
> > device types.
> 
> This seems to be a growing problem for things like mlx5-vfio-pci where
> there's non-trivial device configuration necessary to enable migration
> support.  It's not super clear to me how those devices are actually
> expected to be used in practice with that configuration burden.

Yes, it is the nature of the situation. There is lots and lots of
stuff in the background here. We can nibble at some things, but I
don't see a way to be completely free of a userspace driver providing
the orchestration piece for every device type.

Maybe someone who knows more about the k8s stuff works can explain
more?

> Are we simply saying here that it's implicit knowledge that the
> orchestration must posses that when assigning devices exactly matching
> 10de:2342 or 10de:2345 when bound to the nvgrace-gpu-vfio-pci driver
> that 8 additional NUMA nodes should be added to the VM and an ACPI
> generic initiator object created linking those additional nodes to the
> assigned GPU?

What I'm trying to say is that orchestration should try to pull in a
userspace driver to provide the non-generic pieces.

But, it isn't clear to me what that driver is generically. Something
like this case is pretty stand alone, but mlx5 needs to interact with
the networking control plane to fully provision the PCI
function. Storage needs a different control plane. Few PCI devices are
so stand alone they can be provisioned without complicated help. 

Even things like IDXD need orchestration to sort of uniquely
understand how to spawn their SIOV functions.

I'm not sure I see a clear vision here from libvirt side how all these
parts interact in the libvirt world, or if the answer is "use
openshift and the operators".

Jason

