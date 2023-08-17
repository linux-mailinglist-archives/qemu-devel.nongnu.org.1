Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 843CC77F04F
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 07:49:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWVsd-0005sI-UK; Thu, 17 Aug 2023 01:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1qWVsT-0005rt-JU
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 01:49:02 -0400
Received: from mail-dm6nam04on20620.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::620]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1qWVsQ-0003mU-J1
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 01:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOaNRIclqLul1O03aNoTsfCxFI0jb1H4+A0g4A9RYrqfAZmQZGq3pin+TIME+kYS/IZGPCfTmoEAUMhJd2bgtVtdS9UXAD8IpP+TnaNafmYSN3KXtN2sW14gRuwclmG7EtOTrbqAOe7mu0cRF0+lnQ3jt7aQiqeKjjyZfaXNW8tIvikwlx46u7xSUSmx8k20n86K4OS8Isybgp6GTHN1WT+pWjK9FAHzPOY31/YGfqVS3LjGO1b36WazzEyw/jUdgrTZcukhdSlRpd766D42rhnCYGONEVR331Gu52qqdPd/pe2/Pyjmeb4TLSBXvrqPtcWIrBe7R0bgpdtyGWHs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAN/I9O/FCnzUptJgvfhhE5RjZ1n8nngw8zMs7z3np8=;
 b=bWN2yEyHmAvRbauMHtlMGCdxAL150F7fjZZ4dDRS2LrOGgaFWItm5/hfyzq0l/Jwe7HCpeXLij8XVXZ3q2eRvKzBlCJnkZnMtGzly/Y5F0vayize6QDEi8MZtO+PoZLj+w9EpBNrNCvoAK4MXlNpojV1cOrn1YwECHadnTfKdRwrvi3Rim13ngh1uALFbsFUeU+8Na6KCq+v6EsHQec0CHs5hDtivtlJdN11qcGEtE/4CDhRM8s72wL6XStz7C/WTWQF4m388boJbA+r2PCuVwSZ7CnkRbw0kxUxXaX7GFFSMrfzNv/Z7FdLsSYKwpKnqbSW1KISCg04R77e22uLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAN/I9O/FCnzUptJgvfhhE5RjZ1n8nngw8zMs7z3np8=;
 b=UbYULPsRx2ISKCjgyM0LRod4MZaHrZ4TAELY3RKep9wrUV09YP4eEvQAgX7tUdFBNLv60ywWS7H2XM/4RMu40YhYYFspfVtka8ekSZtfk72bM+32MGBoe94KwV1JkO0TQkhyy6jPC+xMp9u01Pof1bvUaS//zlybbxMRcmOAxSihAGVB+NBtCX68hC0fKbINbin+CtRDjcfeyi/sH4BMpoAMBdi40BI4hvlqittITs14HyZFp6XrCqCmu5iWjOi8N3l4g5FdTnp6TEylE/8oUQi+hBFGy8V3LhUeqvVkIiKEl4qG85Gh9yjxHqKvSGSZMrMjf62R8DVYL391uD6z5A==
Received: from CH0PR03CA0316.namprd03.prod.outlook.com (2603:10b6:610:118::23)
 by IA0PR12MB7577.namprd12.prod.outlook.com (2603:10b6:208:43e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 05:48:54 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::a4) by CH0PR03CA0316.outlook.office365.com
 (2603:10b6:610:118::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 05:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 05:48:53 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 22:48:35 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 22:48:35 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 22:48:34 -0700
Date: Wed, 16 Aug 2023 22:48:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <jgg@nvidia.com>, <eric.auger@redhat.com>, <peterx@redhat.com>,
 <jasonwang@redhat.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
 <yi.y.sun@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [RFC PATCH v4 21/24] vfio/as: Add vfio device iterator callback
 for iommufd
Message-ID: <ZN20sOmGkTQtGso8@Asurada-Nvidia>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-22-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230712072528.275577-22-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|IA0PR12MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b477d79-d4b1-4926-1706-08db9ee5a3e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2tf8yxeZe7WLsm+g1p88+wywa7IOKIN25cnJcfQc0zUwFoYrzQgQMkZjRX3bMUS/HbTYHkzII6mj+oSce138CdIt8oFFks2l4hoizorWa0WGSklHq5bIXfgCscVlib296DlkpnSODZJJIBI0gaIxihXzqype/P9hzaWnSQ5GOlm1bKdQvTp5Zg9O3TRKnHspDEh4PpCYF3G1Y4Rvtn3KKcE2um83Ogo7bibbOciiVV4ZTsIqaTkLEEcQyNUsafliXVZr8Q2QLWGBMGEv224GyEYpazcq1Ip3OaOs/IrKhmQ+h1Nv/XPwfZBHgj0h45gu3WVO9lsJSu4US0mOrckC9p9fIi0xAhzPfrVqJNAuMq/whw+wp684G1eyeH21X+t9Atkc4sfgEfiBUcHNNjUsun4uZdHeJWcqcUAybHpw4DcQJXYbGDc+FaC2oRloaDYk3xriHboFx63FX0vTLrO8hpJLlqC7HajEv9Oaqyk6WBYyMjrGlaGoP1Nkc157MMYI+WzeN6UGsf6W7bHQ4nllZSTODEhcRZStb12GI8ZbV1GyKaC11/bF1hiv0QEPUGMxHsVLpvH1iFiq/j0aCl0TVcWbboaiWf0neYl3frqXxzYc2EfQGFk6HqZgc9AIQ5y3Mqnp4/GGZrMGpb3NqeBrXJP7KEpDOHOVqeuqZfnqOtvD/ABFfX0/XZH8JrFiA/hhqM7PZmgdomVlfxx3FawSV7/NjsIoDHqHtAGgPRRMAQ09KBWaEgR18PkdLV+U8CcbO8m448La6Q+iNRsC1PdjrsY61WqcOcH7IM2RVbWcTM=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(1800799009)(451199024)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(2906002)(83380400001)(4744005)(26005)(7416002)(86362001)(40480700001)(426003)(336012)(478600001)(9686003)(55016003)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(7636003)(316002)(70586007)(70206006)(6916009)(4326008)(8676002)(8936002)(33716001)(47076005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 05:48:53.5762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b477d79-d4b1-4926-1706-08db9ee5a3e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7577
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::620;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

On Wed, Jul 12, 2023 at 03:25:25PM +0800, Zhenzhong Duan wrote:

> The way to get vfio device pointer is different between legacy
> container and iommufd container, with iommufd backend support
> added, it's time to add the iterator support for iommufd.
> 
> In order to implement it, a pointer to hwpt is added in vbasedev.
[...]
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 6434a442fd..d596e802b0 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -133,6 +133,7 @@ typedef struct VFIODevice {
>  #ifdef CONFIG_IOMMUFD
>      int devid;
>      IOMMUFDBackend *iommufd;
> +    VFIOIOASHwpt *hwpt;

I don't feel quite confident about this, since a patch prior just
added the following function:

+static VFIOIOASHwpt *vfio_find_hwpt_for_dev(VFIOIOMMUFDContainer *container,
+                                            VFIODevice *vbasedev)

This feels a bit of conflict in the same series. Mind elaborating?

Thanks
Nicolin

