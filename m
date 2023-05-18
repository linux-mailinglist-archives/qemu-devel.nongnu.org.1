Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27407708964
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 22:22:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzk7j-0006w3-1a; Thu, 18 May 2023 16:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1pzk5y-0006Pk-Qr; Thu, 18 May 2023 16:19:37 -0400
Received: from mail-bn8nam04on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8d::60c]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1pzk5v-0000Ou-MG; Thu, 18 May 2023 16:19:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I941IIa+qNBjfSilxbaP3nbPVInWLX2S0QZpb0FFdXQ63bJ2uiEx4udx3bQk0yx2QKTxXDGvoPUgp4z+mUVl2Ac++wWTuw1c3PdM2uu11UypeLxpvhi/rlu9Yyv8ze8f0TW465qxv6mfgfMdQtblvkU3DRbziVH2Qg1C3DuEEHGjNcjjxRFsiJypievWRcdhPpH56pVpRjdeBvMm7qKRVTNmtefgXnoQG3CVPU+QFAG3cMj37X9TsvwGNsSKybScgBeGKEYQGqwl8JXMqnZYChrKou/I4az6mK/oyhGp7TCpNa9fF73QsskMJ61z9LaCV8LbVkyXugRiMW+MXf7Esw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fz2MfLW412onc28NV6+GoJc4TOt34NMF8NvF4FGymeE=;
 b=VDe2BRwKHTUQ5S8rfE/Wu/QNdKrSLlQK6IDjkB6XHTPWK/0UB9JrY4OFBgYO5nCRLRb3oa1iwg2YdD44NR3h0VjcxQXAn3JFTeq5XyO2IzgrMKgFeKy6SHyP8hkYS4miOIhTwOnA2d52SknURjozxHkYLAK3aIBqfFIffsTXzVvxdPNhjiLL7YqHR8SHSg27uHezVkQNK0clJ/40IZPjymOjUv19uk8rf5BqYwP+ur5gw5viOJSJykyU5IGRDhSOi7Kk3nQjmyi8FPSPddlk7TyuEoHbFTFVvuNiCuf1OAeV3kyhd9BlHaEQwwN491i+7lE1m9ez/Z/WKs+zmpv05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fz2MfLW412onc28NV6+GoJc4TOt34NMF8NvF4FGymeE=;
 b=hFv8OVccWt0rqsgBAHHZHMjc+7NJfrYNuCFD94AdJlRxeWiXkb5DoL7CXZeiMhO7rUx9wV/525u/cePO18n2AaUtJ+ytPaxM8560muY1UFkBZ/GhIg/DFL2uYsAvbLob71I/S/YyuxMhVjbd6ka25J1Cn6CjJjoOpWe+IxPPv1eroZsWN32c/TfLQeW11BnErqqKCTqg/4S6oCtVUkLHA9A5mzqprP5Enha10hsO60xNLHP4XvXKUixjxIHnHTqO2mrjdEk8trm3G0yNNuMnLptsq2ysvY6h7HE9FN0NKL3bv/P3gYr1rdf3uJXmPqGTtU1zyCFnKl2j9CLffadPuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 20:19:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 20:19:21 +0000
Date: Thu, 18 May 2023 17:19:20 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, yi.l.liu@intel.com, kevin.tian@intel.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: Multiple vIOMMU instance support in QEMU?
Message-ID: <ZGaISJUBFdMu+nxo@nvidia.com>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
 <ZGYzOEhdTA6sWKjP@x1n> <ZGY8rj9hRxGLpFdH@nvidia.com>
 <ZGaAVAI9u4K4vy1/@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGaAVAI9u4K4vy1/@x1n>
X-ClientProxiedBy: MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31)
 To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: 08059e32-3499-4efe-1ecb-08db57dd2a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXS0PTx+/7XFQYkUwj3wgLQHdtS69cwHp3wql2SNseUiKFuJjYzOTd1vRZJXrHPlTgjKoREQUgCd8PBXsJgQOO9CMysdM/zk41AKkpSeI2YzVF3ZdHNi9/CljvQhNwkx5faHxaWKszxQHhz8OJc5szHCTGZENpbO7wlEqM63xq8DgIZplT22dOZsZH8DeNux/vTK06HGp1qmS1wQlYt3PEccuTvlVpYU04+CmEuESUztkJsV8igZlIKbCNB4+B9MQpif+Ouvp9gQUzEdixg0qbUh88Qvx+3V5z97q+8h0Saf23HhmtJ0y2N1sYi2KOK96PB6kTi1H29TgxK8es0LCcOM7q7GSUCqE0HRsdGgT8EIpEntf3DQhBejfdPDxrduQ48JmVud3bCMddTT13zLFGNRf5i0mUEw+YuL6H0uDqLKZOIwgID6QfXtIvg7E1onP2YJy0gGbi1usapAht6qu5JfUq8F+U3glSosaH9v+cyFm4wlp6U4tYaf9BZx0ZgRPDk5cnKofs7KyMFbSOwf20WWEtUF7lwBXKu5paJmsbz1taHgry1mI8OUhShyJ9xr32X0WHgOzAEgJhDUIE2dKubFaxsurecNbkSGCvnsDvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(451199021)(478600001)(36756003)(86362001)(66556008)(316002)(54906003)(6916009)(66946007)(66476007)(4326008)(8936002)(2906002)(6486002)(5660300002)(8676002)(41300700001)(38100700002)(6512007)(2616005)(6506007)(83380400001)(186003)(26005)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HZXZXZe05YVqsQ7d8p+xPKY+gWOnm3DTyabH68ELfjvtPGTjaEdOzuLZ2dJK?=
 =?us-ascii?Q?zOU1Jb6j27w3WGcO01bh7BZdr72dkNLTpf2wT1ek/xUdjaSJXf3NkJinYhDg?=
 =?us-ascii?Q?y+AnPkyaN0dRi5WwlTpYh7T4EdOGmoPYLhRyqzs1QXoOhvYmVfID1Bt1CL0V?=
 =?us-ascii?Q?oMqm169JGs9nS/4FML7SRc8+Wvzn0HM//dX4GBo0xHSPAd73DQ9i7mja7TNt?=
 =?us-ascii?Q?KfDhPvEhHvztoC5Iu6zMSiN6XJfwBhz2gZgbqh4S0D01gPvFYkAmnFNgvPxJ?=
 =?us-ascii?Q?rxbqfiQLFS2TsJTxTH1uWE64wA+QQkF8jtHFty6WhlxbdpiwZBlE4JNHsxkl?=
 =?us-ascii?Q?qiwN2kt+b4gf+MdkOhRkFPZE1s3jmzUMT+t8c4T0yW3hZJPeURFBrH0B2Qz1?=
 =?us-ascii?Q?WvWuRk2+Ag+BQr4SCK29tgx1fbXkewDKy8ArqD8pQMvvLp8yyOgNiiUvjDMX?=
 =?us-ascii?Q?LQ0MhzgYTT5Z+1iXCieT38+ib+CtbJuSsXdfJZPt/nWzJgR3l4cJIO8cT3zN?=
 =?us-ascii?Q?kJgx3BZ483WC/BDa8MauV78BlAkBn5BwJnsgq8YSe2CIJuNIELEmihbOYFtl?=
 =?us-ascii?Q?JSAZ7HylzDJkr4UtKvxb+FWfecd0NcnCoyHi1jg0x2ue2GM76wSN8xNsRCpK?=
 =?us-ascii?Q?1IdT2TTKD82X8hNxHZRvjhoc8nlufUJYifXCM2srkLfgBp/X1xECTR3E7eom?=
 =?us-ascii?Q?ICYf6iNht7VtR3VrRq9iXHAZ7434/xUT+oGullaT+LM1M0LJ1dYVlP4EYJmD?=
 =?us-ascii?Q?+Oa/FySosbbfzLbnb3N/7g8z4tVTohdFL375JKmcQxuhrKB7vlCJKT8n45nd?=
 =?us-ascii?Q?gxThht/fS8vvCS/AVftdAMu1DkPa1pliSfw1ftw+lEihOpKwH74ULxLaWLds?=
 =?us-ascii?Q?88KU9pIRY9/HpfZI7AHuQKU1QB8g6bSUfr6vc81PA2GKwC6GqAvOJrKJot83?=
 =?us-ascii?Q?2jVZ35LLvRKIQXGAiwIanXhDOR3EJUMiLO/KGPy0/fGzeyoh0MEoGfT7AQvY?=
 =?us-ascii?Q?dH+Nh03Wdo3sccqWYqmPWWHkxql5s4SyGtRXBIVJ/EzJIODtsVpjD2zI7NcS?=
 =?us-ascii?Q?tjPYTi7+ObzhKQXlQJpHvLlF3rumimiS9O+AXnxHjtRNHlWc7gAVAnd7OJv2?=
 =?us-ascii?Q?45unmFaZ2GZwDophSpttsfqZYkldGxo5DbWy0oNs/rLRaIm3sB0sao3hBpFk?=
 =?us-ascii?Q?zoVdI7LS6AgiZC+K24PcR/DqDmRq0s5tOtdiHoKUHYuwvcNX0hPXzQqc2+Sq?=
 =?us-ascii?Q?D9FeWhP4krm2RDLHZeWfOGDcNxnNDOcwUDgNzdKc/0caJQw8XrlXS3pX2cM2?=
 =?us-ascii?Q?2q3b2MbuxLt82yxs3VG3hYlOxe05MckErgUkQ972b7o3xA6KrGwo21l6VDZG?=
 =?us-ascii?Q?2B/4zRbrPiMQGWPRhc/s9G6FUvVlkm1xj4WzDGQESrifjEYrbrS1tmi0SbQ8?=
 =?us-ascii?Q?qVKXQ1jgvvjbOyUx4+vcuS/CoNNbUGw2P6ksh2CRktTrdvYoJDcP2bElmUrE?=
 =?us-ascii?Q?JCrneL07WlbnFLrUCnHhPnlFlHa/XhXmu0lriWIhIMB6qC11uWUItLA6Oxzp?=
 =?us-ascii?Q?+je3PzteoGaaq25eZ3a/nLIO01HhRvWnSxaTWa8/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08059e32-3499-4efe-1ecb-08db57dd2a49
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 20:19:21.3472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgVZ7VV4aMz76g5IjNHsOhpohrpSwEzDRBIM1x6li0XegRKY5WvJ2loI1Txjt/fu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
Received-SPF: softfail client-ip=2a01:111:f400:7e8d::60c;
 envelope-from=jgg@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Thu, May 18, 2023 at 03:45:24PM -0400, Peter Xu wrote:
> On Thu, May 18, 2023 at 11:56:46AM -0300, Jason Gunthorpe wrote:
> > On Thu, May 18, 2023 at 10:16:24AM -0400, Peter Xu wrote:
> > 
> > > What you mentioned above makes sense to me from the POV that 1 vIOMMU may
> > > not suffice, but that's at least totally new area to me because I never
> > > used >1 IOMMUs even bare metal (excluding the case where I'm aware that
> > > e.g. a GPU could have its own IOMMU-like dma translator).
> > 
> > Even x86 systems are multi-iommu, one iommu per physical CPU socket.
> 
> I tried to look at a 2-node system on hand and I indeed got two dmars:
> 
> [    4.444788] DMAR: dmar0: reg_base_addr fbffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
> [    4.459673] DMAR: dmar1: reg_base_addr c7ffc000 ver 1:0 cap 8d2078c106f0466 ecap f020df
> 
> Though they do not seem to be all parallel on attaching devices.  E.g.,
> most of the devices on this host are attached to dmar1, while there're only
> two devices attached to dmar0:

Yeah, I expect it has to do with physical topology. PCIe devices
physically connected to each socket should use the socket local iommu
and the socket local caches.

ie it would be foolish to take an IO in socket A and the forward it to
socket B to perform IOMMU translation then forward it back to socket A
to land in memory.

> > I'm not sure how they model this though - Kevin do you know? Do we get
> > multiple iommu instances in Linux or is all the broadcasting of
> > invalidates and sharing of tables hidden?
> > 
> > > What's the system layout of your multi-vIOMMU world?  Is there still a
> > > centric vIOMMU, or multi-vIOMMUs can run fully in parallel, so that e.g. we
> > > can have DEV1,DEV2 under vIOMMU1 and DEV3,DEV4 under vIOMMU2?
> > 
> > Just like physical, each viommu is parallel and independent. Each has
> > its own caches, ASIDs, DIDs/etc and thus invalidation domains.
> > 
> > The seperated caches is the motivating reason to do this as something
> > like vCMDQ is a direct command channel for invalidations to only the
> > caches of a single IOMMU block.
> 
> From cache invalidation pov, shouldn't the best be per-device granule (like
> dev-iotlb in VT-d? No idea for ARM)?

There are many caches and different cache tag schemes in an iommu. All
of them are local to the IOMMU block.

Consider where we might have a single vDID but the devices using that
DID are spread across two physical IOMMUs. When the VM asks to
invalidate the vDID the system has to generate two physical pDID
invalidations.

This can't be done without a software mediation layer in the VMM.

The better solution is to make the pDID and vDID 1:1 so the VM itself
replicates the invalidations. The VM has better knowledge of when
replication is needed so it is overall more efficient.

> I see that Intel is already copied here (at least Yi and Kevin) so I assume
> there're already some kind of synchronizations on multi-vIOMMU vs recent
> works on Intel side, which is definitely nice and can avoid work conflicts.

I actually don't know that.. Intel sees multiple DMAR blocks in SW and
they have kernel level replication of invalidation.. Intel doesn't
have a HW fast path yet so they can rely on mediation to fix it. Thus
I expect there is no HW replication of invalidations here. Kevin?

Remember the VFIO API hides all of this, when you change the VFIO
container it automatically generates all requires invalidations in the
kernel.

I also heard AMD has a HW fast and also multi-iommu but I don't really
know the details.

Jason

