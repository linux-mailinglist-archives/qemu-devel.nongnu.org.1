Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 280CA708710
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhc6-0006NB-DO; Thu, 18 May 2023 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1pzhby-0006Me-PW; Thu, 18 May 2023 13:40:22 -0400
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::601]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1pzhbw-0007GI-HM; Thu, 18 May 2023 13:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnC5eoAE5yRFgaWpn432i9oJIF70o2pBPEcapkpBjINCbGGF+yjEQPB9oYvVV9RWLff9nyQMtD7/EISDq5xjPiItdzxw8D2o35WtGaiWfptc9qo23YZoUn8OaTQzAbgX6ArysZO1w/PCK4NNbO+gRHDVSgoILdVyqQp0/bFkE3ZjL94xJwIQZbuEwE+lWT0V5pPvwSI0CLMcNpsz5HR6enaIUXSNhbZwKj9bDYpXy+LtPolXCrkRbXPIt+0AUI6vUUbIlr3GEL5Od13cBkXTqmNBAV1g6aDOGH0/LqWE1EfyQqLBdksrKg66xJ20k+OnAuqvpm8zzhWOpmdbd31QJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROrDJD9nCk9kIObkxnkOrmoxMHLmPPVD3cDd6zhZF00=;
 b=oXG9tvxVuYIEQoxfJJAXgm/PQfEjHKtgl/W1SNCc1NREVhJBbE2/wVQe0mK7+VFYojLf06zuFsEBOb3Dn8ASOMtw7hgElafPiyYseuFzrHn3yZm41q4lfsmjEY5bRL1MFVNhiPMgNZ3cK+TYlDIwxPyNLJ5MywQO0Z/Ey9FHb6/IGf/nhflC5H7Du2QjMRorFInfp0pBc9GgWBBCMm0Yz4AAq2Zfje+km27lJBFINxMntY+oc1xU1dS2p/utXJdd5N01KgFTPSF8woidGYWboDslLoEa/rN1Z/CEqjlBtkM7dc8wvg/587o3CTzNiIr/Y5yDxJeW/NNZGehzHLcwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROrDJD9nCk9kIObkxnkOrmoxMHLmPPVD3cDd6zhZF00=;
 b=OVyjL4SQQjCVeAqcvmcf3H3+Eb+6ahFn8ImP+pmvGYbR1op+7j89/VPWHePHm7pMZfycZ951qvD7Emmfh2LZaZTDZgf+GUKklHyiigyBROyeg6ZqAeP8Wt7GEqzEoWD9b9eqawqU+MBWPF9KskrscQf1J4lw0xkBoztWmmnu5mITUs+5z0LS7H4OrZwhsgcrXww1G4XW+nEjaJuECYwQ/gcdh7nU77q2wWnLGlDgmPn2Ao/f6cX3I03pkmRs/6rCJvqKFsaAPsIvOxSySF3hYpRUOWgP8xhEhhDX2H+Gyyd0XU1bnBng5SvJtIS7MppzdPOEBa+K4cc2GBpSLkEi3g==
Received: from BY5PR17CA0072.namprd17.prod.outlook.com (2603:10b6:a03:167::49)
 by MN2PR12MB4206.namprd12.prod.outlook.com (2603:10b6:208:1d5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 17:40:15 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:167:cafe::d3) by BY5PR17CA0072.outlook.office365.com
 (2603:10b6:a03:167::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 17:40:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.11 via Frontend Transport; Thu, 18 May 2023 17:40:14 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 18 May 2023
 10:40:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 18 May
 2023 10:40:00 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 18 May 2023 10:39:59 -0700
Date: Thu, 18 May 2023 10:39:58 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
CC: <peter.maydell@linaro.org>, <qemu-devel@nongnu.org>,
 <qemu-arm@nongnu.org>, <jgg@nvidia.com>, <yi.l.liu@intel.com>,
 <kevin.tian@intel.com>, Peter Xu <peterx@redhat.com>
Subject: Re: Multiple vIOMMU instance support in QEMU?
Message-ID: <ZGZi7jsM7cwjqo97@Asurada-Nvidia>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia> <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
 <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0defbf3f-a8be-7f1b-3683-e3e3ece295fc@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN2PR12MB4206:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d0b75a-dff5-4ed5-ccee-08db57c6efed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ad4Tpn+IyTZvL4XQHeUcLXR/JLtCRbnqiIlftQrZAcwEDBKLbAiRwbObV+Grg5KqFHsv0c36tS9cTdldNVMadvEJD0JsGiH52+DxjunVWe5v6CAcpmEzeiXF4fNukf5Bs5qedkon/5DQzWT+dOq3A5YCx8Xr1rbFWsWwiZXiIqot70ZB6H4sAWL41zfZZQE+RZgkw9+tKtKv55zmmgS4/p4o1fCQUzWs84URpiMz0bk6bXp5C2BKdXoT/MWWlyN0aQM5HJrKu0gt+mIyt6GmLqrB0cF0Eg2REowl4Ef0rYdbZMvAqiGrBAkc+M2X7XbZQabNrmnKjqrmJKhgDUKEartDgdQhqyKj/wghLkAbBRM8h43Io9LVKvSNKxaIdo157czxTz6iAkN3fIlLkvk5ibftfdNNJfV2+g6wMEIse4dXenmLi8ppAHFrZeOVHeiwIJFxAY9IogKSTLwSF5maLl/sp+oImUILLB+u5GmPROYEwkQmgyrdJpaMaQOKfmK73pGJD3dJ9wXhN1VLaUyn5ktiK8KtbJNa1lxfKGnO20g9aY3GVNXCzz5L1AO0Z3VlP0ewC+wb7sjdhqr/RRUbTuRaPglT8gqnUPUp+v/9/rIO+My0o1y1EuIUCYEpBSTZoxJOheQgbvlUSn4oxOPPzzF9AKQCXd0N4g7jOZNCFNKoJcK8rCPdDGX1r7vVH1g5IuDaZdrpCsw0nq/ErKvKJEahzgkxiy0hTt8/SwZ+r1pzyaSh9y2qqcjERZWGhItE
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(6916009)(316002)(54906003)(478600001)(70206006)(70586007)(4326008)(40460700003)(186003)(26005)(9686003)(426003)(336012)(47076005)(36860700001)(40480700001)(8676002)(33716001)(82310400005)(55016003)(2906002)(8936002)(41300700001)(7636003)(86362001)(356005)(82740400003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 17:40:14.2599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d0b75a-dff5-4ed5-ccee-08db57c6efed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4206
Received-SPF: softfail client-ip=2a01:111:f400:7eae::601;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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

Hi Eric,

On Thu, May 18, 2023 at 11:06:50AM +0200, Eric Auger wrote:
> > On Mon, Apr 24, 2023 at 04:42:57PM -0700, Nicolin Chen wrote:
> >> Hi all,
> >>
> >> (Please feel free to include related folks into this thread.)
> >>
> >> In light of an ongoing nested-IOMMU support effort via IOMMUFD, we
> >> would likely have a need of a multi-vIOMMU support in QEMU, or more
> >> specificly a multi-vSMMU support for an underlying HW that has multi
> >> physical SMMUs. This would be used in the following use cases.
> >>  1) Multiple physical SMMUs with different feature bits so that one
> >>     vSMMU enabling a nesting configuration cannot reflect properly.
> >>  2) NVIDIA Grace CPU has a VCMDQ HW extension for SMMU CMDQ. Every
> >>     VCMDQ HW has an MMIO region (CONS and PROD indexes) that should
> >>     be exposed to a VM, so that a hypervisor can avoid trappings by
> >>     using this HW accelerator for performance. However, one single
> >>     vSMMU cannot mmap multiple MMIO regions from multiple pSMMUs.
> >>  3) With the latest iommufd design, a single vIOMMU model shares the
> >>     same stage-2 HW pagetable across all physical SMMUs with a shared
> >>     VMID. Then a stage-1 pagetable invalidation (for one device) at
> >>     the vSMMU would have to be broadcasted to all the SMMU instances,
> >>     which would hurt the overall performance.

> Well if there is a real production use case behind the requirement of
> having mutliple vSMMUs (and more generally vIOMMUs) sure you can go
> ahead. I just wanted to warn you that as far as I know multiple vIOMMUS
> are not supported even on Intel iommu and virtio-iommu. Let's add Peter
> Xu in CC. I foresee added complexicity with regard to how you define the
> RID scope of each vIOMMU, ACPI table generation, impact on arm-virt
> machine options, how you pass the feature associated to each instance,
> notifier propagation impact? And I don't evoke the VCMDQ feat addition.

Yea. A solution could be having multi PCI buses/bridges that
are behind multi vSMMUs and taking different IORT ID mappings.
This will touch a few parts as you foresee here.

W.r.t. the arm-virt machine options, I am thinking of a simple
flag, let's say "iommu=nested-smmuv3", for QEMU to add multiple
vSMMU instances automatically (and enabling nesting mode too),
depending on the hw_info ioctl return values at passthrough-ed
devices. If there is only one passthrough device, or if all of
the passthrough devices are behind the same pSMMU, there would
be no need to add multiple vSMMU instances.

> We are still far from having a singleton QEMU nested stage SMMU
> implementation at the moment but I understand you may want to feed the
> pipeline to pave the way for enhanced use cases.

Yea. It's for the planning -- I wanted to gather some opinion
before doing anything complicated, as you warned here :) And
this would also impact a bit how we add nested SMMU in QEMU.

Thanks
Nicolin

