Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D557E6C7D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:35:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r167S-0003kK-Ho; Thu, 09 Nov 2023 09:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r167I-0003iO-Q0
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:34:45 -0500
Received: from mail-co1nam11on20615.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::615]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r167F-0006HI-Sb
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:34:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGK3CpsH4Eb4646IGfNJyVX/vAxI/RZnC75W7UROd6F14o/yhYcSr8jf1KXfRy98mL1nJpyqK/TiE4IBZqdTYdsIwlvQbgYawNzYdhup1eF3rzmciBqFTD+Mi1L16xEKKT/PFyf9HC/MmpkkMKBUgornazIUkEe7xJ8qKftLcHMDJ2NfV7KTVx4To5cS56v7hWJr4QGYW3tRRQpqsKeB3wqqUp4bencxaXkv0nL7E8vrR4bD4stAh211BWR7aAJ0ZFd2uqCp6aDXYwg/QPltwa8VEWJfSY4vro1ZBxic0u3VwAbGdUf3H122GumDHDhieB9U+mfKx2qMtAWKkpAm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVkfwRzvKKxe5NsjMil93CISc01EDpgoKyqM8Pb9J5c=;
 b=gluEpfLNIkDVoSD2t2l3BJLkOsNYrGMmgon0FRLL7ULYCzYjy8MjW4vgpzZViXKYmPCTL8RN38scAqSqxKC1V6c6hHRUfFEmlx+FyD2tU3nqB87S3q5j8RK6cW4U+AEERm48+GlXi+RvcgWTnNb14SL6ULIRw/M55q8LIKaoxoYu3zNWNsa3cFStCKLv0fk1FU4Bw5FSYEoEGaVl+4lPLD1PY6d+0qSA2X7TZixRNu+oDNj9L7AOccDyog69+18bsM8GNV/DpsTrzY/bdsPi5YJxQYxrrNAkdvgUzCI2DlGXXozmw7QA5LhLdDlxNZNjowN3peMjW0hBTD+sxuHSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVkfwRzvKKxe5NsjMil93CISc01EDpgoKyqM8Pb9J5c=;
 b=rKQ2Qeiu3byHugLRnSIkWa99yNZ2t90+6VNpuBKIB1nzQQ5RPuOQXoR9eCuo4CqrVyzTMM9fke4OpjeMufALsDyVEzs4J18bGe9iIZzHVaYhmC7N1WfY1KQr5/qACRd11VsaUzNCydyr3aLiUyGZwCaLja1jai8CFdtTKvgC4Hu85BMq3wobBAA0LDII2RPLGjTo+umzCKm1r1v8ZlJ2PdjszAkGvOc2wxAXXFvQTFISqOMthl1VP7ueetDCBuwXGAJkA8WcYhrwgGs/crACoZ8q7amhhKf+KNKOHQYVbXWl6KjfKqbWA14pb4oTiFKyWEfAOjPbfcGFpjW+NNTPsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 14:34:36 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 14:34:36 +0000
Date: Thu, 9 Nov 2023 10:34:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Message-ID: <20231109143434.GI4488@nvidia.com>
References: <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
 <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
 <20231109130921.GC4488@nvidia.com>
 <c761227b-360e-47d5-868d-2cfb71080a46@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c761227b-360e-47d5-868d-2cfb71080a46@oracle.com>
X-ClientProxiedBy: DM6PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:5:74::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB7426:EE_
X-MS-Office365-Filtering-Correlation-Id: ff6b3644-5196-4b0f-ea73-08dbe130ff3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxC3jzwM8XVSrC+QJux+HX6t755zKMRVuQdVAYNMm1HcOR6ny9s50u/Z9qDgSA/s0RT5VKB0Mac9jXg42VHw+hnx4zxuYTq8Y+DRnWqj8p31f8apcrSLUMJvdD6cpIO3hBas5MWeIG8Zh6hfpRWZbEunMJQr8RRtuBvulTSv+AhFetm1bJh21iAPf8tQkAL45P4ll+PO7xVMuUwO3lYB3wm01zoI0rLIm5RXQmQSsje/15C2lFP708XKOzfmykxsgq5A1eWY6OpZuL609DZt8fcgiX9Fc9WqPwtKgI0di8rLyMr8sojl+CQh9kN1r2fMLJWPAOBaJmujlWTpWxfVbMzeZNbSfyaP4Xa5Y+CSH5l9pt1MjbEffRhcP2539bfJfv9vQIElmPMxQDzqh0YBC3yRUnUCFepyWch9eb7F/DTyO5tP5Y5vBQnGADYt8BdU2Qn9yXBRfQgDeqDi8icpO4DThQwEUMHsWwnWFPNiTbE0FJtDdR5JNQQjTvcn6Ad0u2hQefoPMmrihkk/1LuYjuLYfuhKR8XtHHsimAVYAoGPxLlmddAmGyTRhvL9iuCa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(4326008)(8936002)(86362001)(41300700001)(8676002)(33656002)(36756003)(316002)(2906002)(54906003)(6486002)(1076003)(6506007)(53546011)(6916009)(478600001)(7416002)(66556008)(5660300002)(38100700002)(66946007)(2616005)(6512007)(26005)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MTbj8UpOT6/h2Baf1wyVB29bMdFpLnp5z9IoCk7HdXO+S8hE3Rif2wq2xQGk?=
 =?us-ascii?Q?uhCJ+J4rXSpmqFPciyBVvA0pxKgJEAJag4JEKdcLLkE8QRH9wxw0dfvMn3ae?=
 =?us-ascii?Q?Hdx/phP0sJdibPCpLjvjgKCRyg0sI5LiA4SNoGOrQ/KyU1THQwvwomV0u1W1?=
 =?us-ascii?Q?0htKxVN435eilsFcrovSzlYGs9H/ej7d4czK3gd/bg8Rsou1uBgj7MazK6O5?=
 =?us-ascii?Q?3IW2WvMSTsiL3jcMNOFydnObOJ4ABrGNAFSaB5ek3X/uIXt6rgpfKnVb0mZ/?=
 =?us-ascii?Q?brSEeSme2fkn/MnzkjVCix7hDoG+z8CM+MIaJvaXDquFG4dZ5AT0JqMpmHY0?=
 =?us-ascii?Q?TILYLJwF4ZOhebZJyCzw09VYdQHOhWZz+lSkt0Jj1KRPA+q8nYd8vE7wDzK8?=
 =?us-ascii?Q?7AcGYp4W7AaSytBOdYKeV4SIqRH8oV2FMJSF+TDGyQCICxMwfyHfRWj7FjkY?=
 =?us-ascii?Q?pnDiAsZxT0S+npWeBz0kV73xKBoaB7rx0MAn/+7zML8GOp8I1IXPo82/pW3j?=
 =?us-ascii?Q?2DNZpZ4MPNOGE76ItB1YxuFMG01XJqd9kwTpD+J83noW6OcNqPbAUKwCOVTs?=
 =?us-ascii?Q?sfPdQ/APqfBK1Ep47DzHTTiZP4XDxQ5fClZfccNljIg/nNO7Lu9+94KQ3Gtc?=
 =?us-ascii?Q?+jHAuQG9j6i8hLjumXcXo1boTz96Acd/aN5KKLXv/kbR/zFcC+M/FtiOHgnz?=
 =?us-ascii?Q?O2zYKv5905XsWQt/v15G0B7/UaK0Q1md5ljZnY6iPnONHNZpGgU/lWkVOF9u?=
 =?us-ascii?Q?i20ZR2N8BQ1LDKqXddjTHmmB9dARVbwkXny6kM88ypDhBkoVi5UENQoDVGiL?=
 =?us-ascii?Q?OEi0SpaOxr3rKFnEHon5h9u5CGoVAYOGQEIOSAj5mUC1UDSZlRSjQX6iHIpM?=
 =?us-ascii?Q?+pINj/BP9vhSdlVo4uR/vIcDN/jxOERAP/5Gv+Eu8t98q2rLDC/kPncqktN5?=
 =?us-ascii?Q?CO+9ZDYovoKrfrEx9eQU1jM/eiihBdsGFcHMYLhSfo/9ttJFwraPmwdPbkbX?=
 =?us-ascii?Q?PCpCzEtiZlXi697nN1j06lCQNWABF4tWHVXsdo2O7qzZWxhhPB79Ft4OgxMV?=
 =?us-ascii?Q?ShUxYb/x08ZWD4HmmYE87EGvIudXNqPIEixZcksvi7CfSP7Cre0VUI0r6ZOE?=
 =?us-ascii?Q?UutiSphPS2AkUjjwXcwkM/v9qLaQ889ZQd3rsNnLxuzXGGrFKbmnJf9FZKQh?=
 =?us-ascii?Q?aJiny3i13vJU+pCn+V8SD9fIrWeMvI6ejBGHhFyIo2XpEmlbKDzVHLvb8GS/?=
 =?us-ascii?Q?ocIry9ILPFzzoNzaunWYImJFFH8FKV+fsqsQMLNjiWj1hLMDoX5f/u4w9tsX?=
 =?us-ascii?Q?C9t2v4n7vWPZidnszRQuCA4xc+p0eN/xV9WwGvQrUFl6GUPR5ABcvaA9ZkIO?=
 =?us-ascii?Q?XjJFNcN9iEVjImsQceSXxcpkDSBdiz2gs0iR913o6PzsfE56X0r771ioVEIE?=
 =?us-ascii?Q?oCrZlV0L7kVZTceMjYPfHvhcFvbs9OoQlVVKjhQBs8TXYdCwjlza8fxxTxoe?=
 =?us-ascii?Q?E52Z6bYCls7628yiNV0LAKMgaMzwyK1AfNjKC8Udhw8HKbRDzfaVIo/PuzWi?=
 =?us-ascii?Q?fvcCaxLkltvIG+Eczol0zdwENkMdIz9PJ1iG7PIo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6b3644-5196-4b0f-ea73-08dbe130ff3f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 14:34:36.1918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8At41g0It9nZbyBBxJxG7iHnAiYXCm7AcoC3F1woA3NDYkv+xdoIJaIuLbN4JdGO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7426
Received-SPF: softfail client-ip=2a01:111:f400:7eab::615;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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

On Thu, Nov 09, 2023 at 01:21:59PM +0000, Joao Martins wrote:
> On 09/11/2023 13:09, Jason Gunthorpe wrote:
> > On Thu, Nov 09, 2023 at 01:03:02PM +0000, Joao Martins wrote:
> > 
> >>> I am not talking about mdevs; but rather the regular (non mdev) case not being
> >>> able to use dirty tracking with autodomains hwpt allocation.
> >>
> >> ... without any vIOMMU.
> > 
> > Ah, well, that is troublesome isn't it..
> > 
> > So do we teach autodomains to be more featured in the kernel or do we
> > teach the generic qemu code to effectively implement autodomains in
> > userspace?
> 
> The latter is actually what we have been doing. Well I wouldn't call autodomains
> in qemu, but rather just allocate a hwpt, instead of attaching the IOAS
> directly. But well mdevs don't have domains and we overlooked that. I would turn
> the exception into an exception rather than making the norm, doesn't look to be
> much complexity added?

Autodomains are complex because of things like mdev and iommu
non-uniformity's. Qemu can't just allocate a single HWPT, it needs to
be annoyingly managed.

> What I last re-collect is that autodomains represents the 'simple users' that
> don't care much beyond the basics of IOMMU features (I recall the example was
> DPDK apps and the like). You could say that for current needs IOMMU autodomains
> suffices for qemu.

Yes, that was my intention. Aside from that it primarily exists to
support vfio compatibility

> Connecting autodomains to this enforcing on the hwpt is relatively simple btw,
> it just needs to connect the dirty tracking flag with same semantic of
> hwpt-alloc equivalent and pass the hwpt flags into the domain allocation.

Yes

> It's more of what of a question should be the expectations to the user when
> using ATTACH_HWPT with an IOAS_ID versus direct manipulation of HWPT. I am
> wondering if dirty tracking is alone here or whether there's more features that
> start to mud the simplicity of autodomains that would approximate of hwpt-alloc.

This is why I had been thinking of a pure HWPT based scheme

So it seems we cannot have a simple model where the generic qmeu layer
just works in IOAS :( It might as well always work in HWPT and
understand all the auto domains complexity itself.

Jason

