Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 759E8A09321
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 15:14:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWFmD-0004vT-I7; Fri, 10 Jan 2025 09:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1tWFm6-0004ow-3c
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:14:12 -0500
Received: from mail-bn7nam10on2062f.outbound.protection.outlook.com
 ([2a01:111:f403:2009::62f]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1tWFm2-0004KL-AN
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 09:14:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xht+bQVs1Mg/qoEdcoesnqV0NXWDMT/V6ju/PpG9gMbHwa1YHYmjbliTtXRGF9KBhHue5zJ1IgU07K6zqtee+E2cpJDq/gIQ6VrPRfykhsN1CxZ8Zc/gmmIl516RumjF/rR0VwpTVITuKzsT8qsYuANGe7W0MbgmwqzgrrMzyQrVNqixN+t7+BQSfEr7fPJjec+9PA2M6gpiCpJfBmFtnVn8/7+yCCpVEE7WnpcpsorfWt03bZXUiniC0vHIcDLl/Zr40963Q7K686+wros8irkQ5oZfJvZa4z1cqxiD05WC5oQ3QlSHuF+KkI5odzczxxuFKLsZczja5/gFLDoU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxI5X0N2kAWO7OeQyrdsBkL3s7Zz/wJeTQ7fjdoIMeM=;
 b=oOdxmqg3pqXkadiR1Lkr5J5H/CLzWMa+6UzriGTJvepNW3+tgHFErJyG/s4L6cgquqeORVRHB72uDJ9Xy6CYG57xN//z9qz2CZu4JPcdxmSdPVDlEdgx8QSgu4a0HohpcJ2Zean2TnfVXEJ3iw2BZXxXmss5n1JWp3HIwaqDb/OeRekhp5ZbOgVX+wfs4moggcbc4FMwPbtSjgmT+IVLzHoBee0i5AJOcba/LpJRiO7TPVsxpSjIl/XFyfU38kM8j/e0/oe2siZCFcPNZ1vtGGSUBwuQg6CIlPpNMql6LGjaPXolXOHoXv/DPuuCRiLU+kWrQR6JwrUJHa+6VZNKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxI5X0N2kAWO7OeQyrdsBkL3s7Zz/wJeTQ7fjdoIMeM=;
 b=e2sfixNSJDcmEwkko7STWmuns9yk+yGI8qEOQjhuia7QSTxhyqF4dUTynIYN9DZ9rxyLO9e/F7aW/T+yTwSHxal2cb+gm88FmUi6O4vCgk4ZjBmn0WImdHHiBQgJwPyAsm9+Sc7mu6hoXOR7sg7TjJNUJn9+UvXDI8PtC/QIlWWEKJBHfqvBVgkx6KUgAnkMW/KdrJquHVPbLR0aVU0VtsIxy3i7zGaloTo0vEz1Euix+K61mmcd2o+izA+jVu5Z0vq/RmaX+FidBOJqcRvqsDoFQXFL9gOxrB9WnQN/pMoOJSpQBfqlYBUfpOPAGCcwQpi3fcGaogZ8QUAWzgodAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6356.namprd12.prod.outlook.com (2603:10b6:208:3e0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 14:14:02 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8314.015; Fri, 10 Jan 2025
 14:14:02 +0000
Date: Fri, 10 Jan 2025 10:14:01 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>, Alexey Kardashevskiy <aik@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH 0/7] Enable shared device assignment
Message-ID: <20250110141401.GG5556@nvidia.com>
References: <8457e035-40b0-4268-866e-baa737b6be27@intel.com>
 <6ac5ddea-42d8-40f2-beec-be490f6f289c@amd.com>
 <8f953ffc-6408-4546-a439-d11354b26665@intel.com>
 <d4b57eb8-03f1-40f3-bc7a-23b24294e3d7@amd.com>
 <57a3869d-f3d1-4125-aaa5-e529fb659421@intel.com>
 <008bfbf2-3ea4-4e6c-ad0d-91655cdfc4e8@amd.com>
 <1361f0b4-ddf8-4a83-ba21-b68321d921da@intel.com>
 <c318c89b-967d-456e-ade1-3a8cacb21bd7@redhat.com>
 <20250110132021.GE5556@nvidia.com>
 <17db435a-8eca-4132-8481-34a6b0e986cb@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17db435a-8eca-4132-8481-34a6b0e986cb@redhat.com>
X-ClientProxiedBy: MN2PR12CA0018.namprd12.prod.outlook.com
 (2603:10b6:208:a8::31) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 00c7ba35-6198-4f97-978f-08dd31810878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3bCbUIBJQ7yaeC3nrRAGJRzkZFUh4YW3Xw5C+DaUrnmpvFj00IDG0/KjAF6H?=
 =?us-ascii?Q?fPmIpo+FetEMFYJQSdRHQaRigoDljcJX1QjAWtBRLcNPdFvcBaIBXTayrv4I?=
 =?us-ascii?Q?CFUF3a6IcJqvsxXWfBlGLZuAmPMACtoAcJeXBg2Vm0Y1mAzxEW6Y4RP/R2Sx?=
 =?us-ascii?Q?V5MqcRIzuJYhOUE8dMvnuiUsgPGcyw8F2efkOT7ZLlMDlANik3vf7LiSqA0q?=
 =?us-ascii?Q?bTWkbUOBpmaqFd5jJJ//NW67JcHbzaMKR1Kf/ulm3J3aLOeuLJYkMEfry3O8?=
 =?us-ascii?Q?44IW6IE8m5BwRf/ks7RPpdbAirLYnxXGU/0c13/OSQqjJ0GNhFBlqeP98KYu?=
 =?us-ascii?Q?ZPCvNTBpyHBW7sLlQX0r8xXmg2nWAtJ7T103C5yiRroMI0fCVzrk8TgtbS2F?=
 =?us-ascii?Q?/7j1rRzAhzBGNaq1pa/NjfE1y6bZjPiGcy/c+HR9hOHzb+uBFF4yLBngfxzr?=
 =?us-ascii?Q?FB7PPS/XxsbC/iZT61rxeZ9MOboF4qiArgAFCS9JlnBgShTCXWBjgTV3XQ0J?=
 =?us-ascii?Q?EQ7c+XSLYPR7Wk7L4kytbPXppb8OdeTAcEVlQRv8+BJ+s+fX7mMrNTbXibSq?=
 =?us-ascii?Q?fboOlBtvPPrldLKKGwaikOBPZMZy0Sxpca/k79yW8aukVr4FPFy80FI4t8Ra?=
 =?us-ascii?Q?jlsBQ1jGZUHduPemdsiP2NZDAZS9/YUBN/sTNuqf7PvJP5wGHV2RUwHknGKE?=
 =?us-ascii?Q?xBmqpA8GHXEv2U5IldyYWsUoWo2tUSDV6rCn9TbmGvxZ3v3Vcrq8xcu+xD7U?=
 =?us-ascii?Q?PRw3ZvddSMByB/ZBapK1gnWrm+ELLKCd6UGXTkzs8fcBZcllkYJQeyn2w97h?=
 =?us-ascii?Q?EDTr8z/X54SDpRouJpB5CtQrL8MKRYkH7Gw4nHEbcWrgV7mZBVyWL/5ATPSs?=
 =?us-ascii?Q?8vwUxakD/m/UbKYe8WkiBv1UFi9N37bq4+dfjG26vYYipsgXWedchWDdOLTG?=
 =?us-ascii?Q?lga1xrthjeD9aabt+kAtJ+HDNA7oIrAHkenr2gRipL340KEHRElG0j1o7K1o?=
 =?us-ascii?Q?3CWYfuXShYg481d1WAYNrLe5g4pBe239Ql1AKxuK23bSc+gLbYACmTzWc6Z7?=
 =?us-ascii?Q?kRP3SZphtrvV/mK6WWFXbB32ln8aJAJo58F88XadKQH739f97uX+9Wl9lZwc?=
 =?us-ascii?Q?UQR070rOHxis/G/mlQ4qgltrqN1+KxA8P/RiO7rQ85QGkeyukkqI9SsG0VFg?=
 =?us-ascii?Q?knjMtK3uVpVw8N7QoNlZK0c+tCypdTVL+HIiAE67C0lBf7jCrVL+eb0ARYyS?=
 =?us-ascii?Q?jV4SNigNPI2ERcY4SQbMYkyOxfanQav+GRFZ0YYrJOJeYxEpbeITAFI/6nUH?=
 =?us-ascii?Q?JvH6zXRnF4dak5hhM3VyPLBk4Z6FBfOkPxoAlYiiLfq+kc7tVRsDOIWxKpNk?=
 =?us-ascii?Q?smaLhqjpFTsTb0K8SgydATMVcgiB?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2SrHqbJVtTSQ3DYZ0lhk7/bPDJJZcPGZyxwcOf6pczu93MCfQWbJ/AmcEm9w?=
 =?us-ascii?Q?hriCr6sKzqIX/5HD0lRIHQCUNHo/y7YIR4GjwfZQ1bJwa3VGZLHkG8Qc1G8V?=
 =?us-ascii?Q?NSALCcDtfucndEmMsoBrDAhGD8SXUxfikSQyQmG7nr0FEJXtmlwMuuIitc2e?=
 =?us-ascii?Q?qXtY7vSDiQnAcR6ZolsGYuFY4GQlecbRzuwicTUxZnfszMam0FMpKWjcvd1A?=
 =?us-ascii?Q?eGvVFeG5gkDDIU/qWs98Iu8HfDjEkDu8RFlCNy+jMjEc2Fi5aUzcx7Yn5ihp?=
 =?us-ascii?Q?iJBzIlcHF8+Pku0GRvIh/3LABWCm4FC4WE48hjRG3p6YuQjJ5s9LbC+N3opX?=
 =?us-ascii?Q?4S4PqSUWEDDD8PAtWRjZsw1H9y9MDQ38gmM04ID/zwkXVPx+Ar9/tlNDF+y+?=
 =?us-ascii?Q?h3+GSPV+n886nvXYvI2Cvie1MB+e22LlK8BvrwuxFVE/adQ1mASnjgnsHA+p?=
 =?us-ascii?Q?OlyI6TWbdy1ELQedlKEU/sCgDqfy3brrBD7cLRQXaAdTlOIzj01kEa0Pqq8R?=
 =?us-ascii?Q?r2eTkN33OMgaobpKRxh2WqPh2EEMs2qlUw0DHI+FWql6BRw+bkedKe0wX7Ur?=
 =?us-ascii?Q?Of1AIx0d6V9331J71qxsQ2gAfIb8uNz4aWFogS+m4PA0RZ+flX5C2P3Ro8ZJ?=
 =?us-ascii?Q?W0PKTPOJq8LcLzd9/stZUf2Dzht7d4fPP0zly1hwZVZfkdu4xm9q4Ej9QtDO?=
 =?us-ascii?Q?qNIP3QAdWr6UBejQCTqRXoRhFttKYj/7eXBszvlV03cIK5qZrCD6j6xMOxv0?=
 =?us-ascii?Q?wUD0BXUfxBoBic52OAFoMin6hvoK9oG6tX8joKjeSnK6W3G4lSwvnP8L8kGY?=
 =?us-ascii?Q?P030+XHyROZ+RR131PW+YcbbgXz12d0/TNn9Nd6eokHFhZVV3tFyn5urjiqg?=
 =?us-ascii?Q?94y/Z8wZttrOepJvQFzz4t7NAjxzbvaoZ//Ycn5uu7/pHpYcSxrK9OFztWVQ?=
 =?us-ascii?Q?0V1I71Dy/IlixBV+X8ZYoLt691iGpAeu2Rd1fwJ1XaDYmddPmhFchwxBf4b3?=
 =?us-ascii?Q?DXb5cHex9YY2jC9yNwEhVz53/0MSCgubUsr/pMmDJrQBvyZbUNYIlxTxlB1B?=
 =?us-ascii?Q?tAFxWsG75af4cHaPxioxjyLfHI1FY2r9CkztALIU08Uy16twuvvBfA8718xR?=
 =?us-ascii?Q?jOxFjLr/24XPMUrD8x+w8/ERqYmCJvzxzpCKq9AuSeIU1Adinm15mQNUwfdQ?=
 =?us-ascii?Q?3AJIgqb1VmFNDEXEZWWovc79jyYMkQxSG5eODHgUqXlolRE2kq6f0N9Bivjy?=
 =?us-ascii?Q?DOWjYcyVgNFA5c90e3HRfOmmcqPaVZT/CD0eugF58KuNb/x8fAtZ3BM3PQd6?=
 =?us-ascii?Q?u21/Qwhba4+JEqzTE7C4gysZVqeLs3/M0MGNQCYtSoYcRUU3Kn0So6I0oiGA?=
 =?us-ascii?Q?/9/qVqSK9Snt8qDf8BYn/u5s6UNvWLr8B0UJ4rm0TIvad1xR0I+LE9meRzdN?=
 =?us-ascii?Q?HcyzFMY60O0Ji9rXl4ZgC1pyBeXxHtQMMs4NpxR1IbvHxdM9yCBl7rcKsQWe?=
 =?us-ascii?Q?JHZuAlOWjL1Ij5UEGPcdhIcyvXq0jSrmqdFsZQNQkFhzkiRto7kq4GvE+aMi?=
 =?us-ascii?Q?X5cxeaWmhtkxkMWCFVdWxvXDo7SnZo7hWe1p40DV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00c7ba35-6198-4f97-978f-08dd31810878
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 14:14:02.0580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WiOoQxdkN9c4NvL29KzWBGRjVApMg6p0R/8+fHzd1IqxEDWxOQNdVfpmZGm4eeId
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6356
Received-SPF: softfail client-ip=2a01:111:f403:2009::62f;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Fri, Jan 10, 2025 at 02:45:39PM +0100, David Hildenbrand wrote:
> 
> In your commit I read:
> 
> "Implement the cut operation to be hitless, changes to the page table
> during cutting must cause zero disruption to any ongoing DMA. This is the
> expectation of the VFIO type 1 uAPI. Hitless requires HW support, it is
> incompatible with HW requiring break-before-make."
> 
> So I guess that would mean that, depending on HW support, one could avoid
> disabling large pages to still allow for atomic cuts / partial unmaps that
> don't affect concurrent DMA.

Yes. Most x86 server HW will do this, though ARM support is a bit newish.

> What would be your suggestion here to avoid the "map each 4k page
> individually so we can unmap it individually" ? I didn't completely grasp
> that, sorry.

Map in large ranges in the VMM, lets say 1G of shared memory as a
single mapping (called an iommufd area)

When the guest makes a 2M chunk of it private you do a ioctl to
iommufd to split the area into three, leaving the 2M chunk as a
seperate area.

The new iommufd ioctl to split areas will go down into the iommu driver
and atomically cut the 1G PTEs into smaller PTEs as necessary so that
no PTE spans the edges of the 2M area.

Then userspace can unmap the 2M area and leave the remainder of the 1G
area mapped.

All of this would be fully hitless to ongoing DMA.

The iommufs code is there to do this assuming the areas are mapped at
4k, what is missing is the iommu driver side to atomically resize
large PTEs.

> From "IIRC you can only trigger split using the VFIO type 1 legacy API. We
> would need to formalize split as an IOMMUFD native ioctl.
> Nobody should use this stuf through the legacy type 1 API!!!!"
> 
> I assume you mean that we can only avoid the 4k map/unmap if we add proper
> support to IOMMUFD native ioctl, and not try making it fly somehow with the
> legacy type 1 API?

The thread was talking about the built-in support in iommufd to split
mappings. That built-in support is only accessible through legacy APIs
and should never be used in new qemu code. To use that built in
support in new code we need to build new APIs. The advantage of the
built-in support is qemu can map in large regions (which is more
efficient) and the kernel will break it down to 4k for the iommu
driver.

Mapping 4k at a time through the uAPI would be outrageously
inefficient.

Jason

