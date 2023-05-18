Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80520708468
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 16:58:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzf3x-0002QE-Hv; Thu, 18 May 2023 10:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1pzf3v-0002Py-Mp; Thu, 18 May 2023 10:57:03 -0400
Received: from mail-co1nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::630]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1pzf3m-000622-2e; Thu, 18 May 2023 10:57:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzvXmRUsH0G6r4VTiem2My07plryNKRo3Vmoywuns8jwtCIMJ/jePSKiegfMwie6xoayycFzNoMCg4QYLUgMblhys9BteopTdBoqEaRzIqGg4ABcVtaOg5cuOH/31bISHZpttVhBG6+BzTuQkZYQrgFERW6cUvTaPohRffsdCMS1aoXvXzLlPuCZPuE/WHfmHctOaHVyNV/TV9v8JbkkjSTNWcTIR+95+k72nkqMYakUZvteQL+ZGpIfdIFaTANvu6BpSS6naOQ0LSxjxSIa2MV7yzjXmvd9UZUskpDnpQJjykoXjbtvMY5VIqDRG3VNGOudK6JxqK6Yfp23aT4bXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hku/E1Jjh1JO2Grxep+aa56V1mvis3xphx+pUAFg5Y0=;
 b=nv9W6B3hnYrCoqeAluEJj3Jo2Qm8E/ULAzCNx3Kllf/FR0gY8/ogftsrfApci7QNfvrvuK/6W8a6zRg+zGxp7uAGOYGjbWwFKdese6FbkHLuqyfvHYWItyYw4HEgCO2OzRZ0NPBRFiZnw5RXCx9DH6JcWuw0KA9j6FzHkGhtZ7pJBrHNx80Nzor7tlfEQti/fGZ7ugzzDv3/wZDLAtHWCu8bwKLpXKgOjwr4XmyNspfK8NzTpPK1jNTc5UwciiXyztW0XGtE56nqx83SGjycYe+AAolBaor6JxnbCnIhUFs/looczOhC2RsAeXdo+pezlQJV2vBMNsbJDJVzDT/63A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hku/E1Jjh1JO2Grxep+aa56V1mvis3xphx+pUAFg5Y0=;
 b=JArrc9EJTs4UrpkuGLgxyWlviFrBCCPUb11Zx41U0GccedHxx6UuRDIpbjt4Z6em9ppsZsZwmiuhJ/rN2uiBy8FyBSAQ5BNuAffAmKdvxMOVxZqniLcCFBhc78ECHtxnxka8+9njQL4TSM0Ia5n26U47U8tfMXwsR8k+rgJtvtBz8BuJGJ6x+Cr9IhRdV3lg08wIYH90XStIG64H3zsbNrBHaxoMyehWuU5CFEYJ1OzbzeiSPDitF/K/RbjkBdkngYdjZqbXG9/jvSuBn4P2oniTYadT0IN5/i/VnI+uJDBVcmiP9qICc9cGa5sj+xpSoM4TnoZ6TiLfclxO0Xje8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 14:56:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 14:56:47 +0000
Date: Thu, 18 May 2023 11:56:46 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, yi.l.liu@intel.com, kevin.tian@intel.com
Subject: Re: Multiple vIOMMU instance support in QEMU?
Message-ID: <ZGY8rj9hRxGLpFdH@nvidia.com>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
 <ZGYzOEhdTA6sWKjP@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGYzOEhdTA6sWKjP@x1n>
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a32f8d-f094-45dc-f318-08db57b01a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: scTpMpNgxvJWfSX+WyhrHjI6iFbxITMazup26rWShvgSjYDEQF57PtDC4Umbe+vqxDYfK1QwTyxxRKNziriN9Gzass4InDhjZuEqe769BwZJdPAvqfXiI0EEK6gRB37YGO7op1Og0eCDu1Rk1yJ10ynBZyfgOODOChyG/TOLluB56zCLGRd1KAnXLFAM7enQLBxJgb1eYI3zkTKGb17ap4McGiB4gP8dPbKq3VihhnQONS6js0a1HwQNlSOUhdPQ5xQFKjaJYODIakmtOP7hpJ5e4+n0cJjc4WdLOT/CpUoXOTHGNWEHobgW4UjmmXMsXaD52YPVX9PCu95uE4zdg4mB6zu3nYXcUsgaKorpgIwpWjOKojX+cJJ2n0fyHfnTn/cvSp7GuArMx4mL1hNbdoNBd1dYlYV1V1tEXSXWhm9mfBHAnGMe989bjOw1Hp2+MKx8SIWeQ5wPeYfpM3ih0yAdpci4/XkaRoi1XufnkhEU0JxTZnnaPEHS2RQVD5mop8gDYFcO/gVhWIb1znqDJNL7c2I+jlw874UIjAFgEfYYmr652AXJF5IiotDRQYe+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(186003)(26005)(6506007)(6486002)(36756003)(83380400001)(2616005)(38100700002)(86362001)(478600001)(4326008)(54906003)(5660300002)(6916009)(316002)(41300700001)(8936002)(66946007)(8676002)(66476007)(66556008)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q/LV61O91kuysONY8UCsuNkCBwKExacH0LRcGn3tfkG/XnCBTEUAdGbA7W53?=
 =?us-ascii?Q?3HCbEoHKd5wjqKa/fK4YTbYJyizu8EGDFIkmcyIEiTB9wY+Y8ck2PEFXYBNk?=
 =?us-ascii?Q?Zvk3rskPgpmWHuPW7lgmleINc/IWJcXAu0C/EXYtlQ0G+GZjOpb7lsuZXW+P?=
 =?us-ascii?Q?zMgYZSFvUJjZVM9EVoFHHkTMv//8eVB3PFMYSUAtEyWWt17f6tWfGyQNomCX?=
 =?us-ascii?Q?EhMhm0lcH5B8VrOO/bFLG7BZni96zQcn9RcNmyJobF16y1kJvL5wmteaY+AA?=
 =?us-ascii?Q?ISni5uFkU+x2ljI1Fg8jQdq3fqRv0Nl3mjvp+9JGM92mHJc2L/tfM+lWHIWd?=
 =?us-ascii?Q?3zW0MGlhYLebbfJAoeeKQo43ENBickJeOKUxIxFDfJaRLHcIhNvbh5Hcjuvz?=
 =?us-ascii?Q?uI0jlQVNx63Tfl2qH67hcGvKM6iQD8gFQzHYFN05QH84VIZERnHctlIVgmcl?=
 =?us-ascii?Q?ckOzIwYjnbk3/CJ1Sbib9SsmU51uaUJplvyYWOvpvAIzh3kn7uCOVWkmDluF?=
 =?us-ascii?Q?q6nUoawYY3XRzSflPFxHPNdRuGZONGOrfxk7Eo5yF4EjQb9a0nTE0MS32HsZ?=
 =?us-ascii?Q?L9zrDVnB6iY+zmi7c6/61ejuEW0/335EV/ZkZWuDJAn9ee6eazoLBgcV7FKr?=
 =?us-ascii?Q?jfVY9G5hqKS61rTze2I3/J1vpz+C54x5b4snNeTwGplXh71aAxhv0X0/voZr?=
 =?us-ascii?Q?iqQRMznAoj1jLKMngqVuqzZ/jI7QOw3cazXJ3g2c90z8yCWKRqfjgLbYRXDF?=
 =?us-ascii?Q?gT6vvSZOGuJqcWTHN3i2JUYIhtPycbqqBsONwRSYiQwKTkFbPD01VhpKrQP2?=
 =?us-ascii?Q?76xF76VZP7N0I0Euf5s8fJdwtw4MtkobOk4E2+VTuhncH4zpH8lMf1MN6XtT?=
 =?us-ascii?Q?onQu8NnUP2aYHHagb0jC+F0b8EVKZteBlAAGQ3dbf5UkL/4orR6Vr9Qe8S2h?=
 =?us-ascii?Q?xtgnBlv5xuRYJ4l56ICn+tuChnVXPYhXivJxhSX/DS+9inXxD6TLSTOFfaYz?=
 =?us-ascii?Q?Uz7eFRr/0fbVR3rtDc4eb+IkOixrLWtoqYXz+EW7g4ImhtXF/hito59aLJA/?=
 =?us-ascii?Q?ExVF1tPH1JrL3G2ClSVoS5+ug8FTpbU40nHEvEN4NF2RRuTlS3UZqcgTAhJm?=
 =?us-ascii?Q?7QOErXRwwHQcN8/2Wta+UYnaIr9nqRpqPJN82eKO4KcbSSImVOiAMvG3Q/G2?=
 =?us-ascii?Q?BvfXuVmhZ/mnS44y5DfLY5rUJ9Zp9nS/yE7+R/GUXbCfneecGcOY+zJAlycL?=
 =?us-ascii?Q?2VxVsf/m4EONNz/6vg33yUmAytyC9YTwZYG2rlekUQcJ5/Ow4cQpOYh4sOHO?=
 =?us-ascii?Q?WU9Muj/X3DAmo65ANcZtBjFxaB9O8JrizjxJjcmU+nJGTmbhHj4npdPsR8Ii?=
 =?us-ascii?Q?G7iYjKWvug64rlegn023VqCEMHWnXnKVIj0RKa1AcI+RodRQ7LSaWOm2BwwN?=
 =?us-ascii?Q?Yya/jgDsjOnw8jdWWrW7g1WhNp3oOxfZlhiOEhhjmniET8T6824agKNJxnrn?=
 =?us-ascii?Q?Ut6izc0i/Mi7BRbOQjhcUCPz6wiuGyD01P0T17bW8rYCpCCfNHSFXZ5ggtlg?=
 =?us-ascii?Q?IMe/1Q9ViM1O1uphuEn6YgdzXYv53KRlXNV9S3Nv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a32f8d-f094-45dc-f318-08db57b01a5b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 14:56:47.2733 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i5Btc0dBTLDt6UpfkvFXSpLvmibfPBqw4G2xBB3MH7UDvd/LWvxXwk4yb3dvOHIy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
Received-SPF: softfail client-ip=2a01:111:f400:7eab::630;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, May 18, 2023 at 10:16:24AM -0400, Peter Xu wrote:

> What you mentioned above makes sense to me from the POV that 1 vIOMMU may
> not suffice, but that's at least totally new area to me because I never
> used >1 IOMMUs even bare metal (excluding the case where I'm aware that
> e.g. a GPU could have its own IOMMU-like dma translator).

Even x86 systems are multi-iommu, one iommu per physical CPU socket.

I'm not sure how they model this though - Kevin do you know? Do we get
multiple iommu instances in Linux or is all the broadcasting of
invalidates and sharing of tables hidden?

> What's the system layout of your multi-vIOMMU world?  Is there still a
> centric vIOMMU, or multi-vIOMMUs can run fully in parallel, so that e.g. we
> can have DEV1,DEV2 under vIOMMU1 and DEV3,DEV4 under vIOMMU2?

Just like physical, each viommu is parallel and independent. Each has
its own caches, ASIDs, DIDs/etc and thus invalidation domains.

The seperated caches is the motivating reason to do this as something
like vCMDQ is a direct command channel for invalidations to only the
caches of a single IOMMU block.

> Is it a common hardware layout or nVidia specific?

I think it is pretty normal, you have multiple copies of the IOMMU and
its caches for physical reasons.

The only choice is if the platform HW somehow routes invalidations to
all IOMMUs or requires SW to route/replicate invalidates.

ARM's IP seems to be designed toward the latter so I expect it is
going to be common on ARM.

Jason

