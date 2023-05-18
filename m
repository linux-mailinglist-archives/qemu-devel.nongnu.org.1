Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D1970786E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 05:24:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzUEU-00089f-8Q; Wed, 17 May 2023 23:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1pzUES-00089T-GF; Wed, 17 May 2023 23:23:12 -0400
Received: from mail-mw2nam10on20628.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::628]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1pzUEP-0008Bh-SU; Wed, 17 May 2023 23:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auaNTS/IIbQN8mukF9aQK9BPin9+2lpQFp0ujmDup2KBm/mf67YQUdTPhntr4Hgy56aKpZyx/oSRLt4mtitVGHTLgjBpRGmkJSMWAe5xgYQDTAYcgASdrN9aXHhdHUIue32GNa7L27KQZcwurtJGjyIJa1VIsXzYV//9Df78H7K9QwdeGmlXNoEvLadpVPttPev0ynI+mtS7eZdaC18g097yng+45ZVb8RvYrB4jWLhcPjARm5Ow+TnrLGQT1lCCCD7igQmMM7jN1BuRIStnrKuFrF3mh3RaEWgjOaumk3YywyokmI159KkCAyp0IpBFrJz7JdknUVA26cadGTI9Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SQ685UVM78OjMIz7m9s69w/wsipZvSBbwqQQa18gfw=;
 b=BMC01HapPMZurbnGtN/JOedwkuZ8YDsW3RywEJLcKghwV7E9/1EOioyojTcy8Oc2s88zxyBHwEawtZPHPvUJmcmlzEzS1VpYL9SyPIoFIa1c7q5H4oaoz0MKV4XCwN2YRVGEeErSRMN8BcaKmo1fkmm45Uy/uuixd5twzmv6RyMVp3hcbuth+orZy4Hlse0Uc3L03qr/R7xVOUzl0WKzNk+WialC/ickWdTXWLu11Bei9R818/M9uJgYzKsTUPcSX0HaTb9vMflzzafFzpX1QGCYq8UlW2+Y9L/ktgNLPvxShXMnCDBcApf01fnjx8ZRudII0N72wkMyhuDcExKNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SQ685UVM78OjMIz7m9s69w/wsipZvSBbwqQQa18gfw=;
 b=KCE9a4mdni4EswBgKxJm/3qot0pSKB3JmhqXDixUfJjarpjJ5prKF8BL7OP4Qn7NP3clrd+fp5HsjQN4EGUf4bAxjBaSRoZLUypNVCUB+cPxQXzo+Q0rsORuz8MN0Gxm/iV3ivDZj+o+U3FJZIc+CjofyDZqHWLJAzonBvRPNZ8JSU6xe9m/WlqqtNc9ZqSOAKkHns56bSqerikolNMEMqCBI78WC3p/o8dpRU5e5JTsLFsEV8vHltuWdZ6DpKkaETwZg59/tv/atJ9SxOaxfQ4ApV6rMsjgoCp8MkIAZ8oR90Vqehp3MMUIp3T2XtAaXQwWGycszNnWxa8iXXq3Jg==
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 03:23:03 +0000
Received: from BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::5b) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 03:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT102.mail.protection.outlook.com (10.13.177.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 03:23:03 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 17 May 2023
 20:22:51 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 17 May
 2023 20:22:50 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 17 May 2023 20:22:50 -0700
Date: Wed, 17 May 2023 20:22:48 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <jgg@nvidia.com>, <yi.l.liu@intel.com>, <kevin.tian@intel.com>
Subject: Re: Multiple vIOMMU instance support in QEMU?
Message-ID: <ZGWaCKQqK5hVqbvM@Asurada-Nvidia>
References: <ZEcT/7erkhHDaNvD@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZEcT/7erkhHDaNvD@Asurada-Nvidia>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT102:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fd44e3-7bf4-4680-a298-08db574f30d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VPKksNaUBgqeRGB+WfFhH0UBuFcYVqgLqxPacwGW2HFdf694hbPKr1wWa6jRiONv9N9Y9k+8svKkRDhPlk8g2UKxHPqWRNg6rOlL7atEL2h1F1+fWoJ701XCSxJDkgv/QIF3fg6dPF3G6Gmd3Vxw2EtWGz0pdIctUW+DyTiyoDpq0wi9B/mik2IsZ5R/V7A2CxPv6sSctFl73KjRDaJ+ZGJxv3s4Rh7JE2nuCBeBQEE6SUuslQCnCC6SFp03NGVT0gczup+xZDKv+xrYDJUgQMtevHHIAfXKIrMX7MzCOARmigIR2JT3pbO1cANqI1YrqF/J6j/vbl4q6OLl+BJEMzg/xU5Jk4RqzBMKMKobyw1vyV0IvoSHFT511bAwCcgug44Rpy3noXkCZ01eY0T0YugHU8VThucwG67GP8MlFp/ZvobEO8ur4MM/Hv5J8juGQwm0p8qzRX+PZFL5MWgt22vCodzuShNs4XWy4wzQRowW7GzVWWBBHN6/zEfjxT4+XkvFjIMP+WsO66s43DFXt2GSywxraK9ISBnybWZg1ftaWADcn7NWGZbRUex9kX9DRMBQLrHl5t4JaR4BFOqc8/eghc4LT7sjE9ne4rST/0vqB4R1FA+CwKkWCFnQVA+8AywOLPLaNuRhCitueLr5eKsuugAWqdIrFgW7enlliYTVk6NRihH3GmWUY7DV+JzgiIm/LAif/Ne9SLqLBOjGbaLe9sw8IV3T2ybqMCNWz1EGAESCllXBYcVYq8TEcHYP
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199021)(46966006)(36840700001)(40470700004)(5660300002)(40460700003)(41300700001)(47076005)(336012)(426003)(36860700001)(2906002)(356005)(86362001)(7636003)(82310400005)(33716001)(82740400003)(186003)(9686003)(55016003)(8936002)(26005)(8676002)(40480700001)(70586007)(70206006)(54906003)(110136005)(478600001)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 03:23:03.4416 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fd44e3-7bf4-4680-a298-08db574f30d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
Received-SPF: softfail client-ip=2a01:111:f400:7e89::628;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

Hi Peter,

Eric previously mentioned that you might not like the idea.
Before we start this big effort, would it possible for you
to comment a word or two on this topic?

Thanks!

On Mon, Apr 24, 2023 at 04:42:57PM -0700, Nicolin Chen wrote:
> Hi all,
> 
> (Please feel free to include related folks into this thread.)
> 
> In light of an ongoing nested-IOMMU support effort via IOMMUFD, we
> would likely have a need of a multi-vIOMMU support in QEMU, or more
> specificly a multi-vSMMU support for an underlying HW that has multi
> physical SMMUs. This would be used in the following use cases.
>  1) Multiple physical SMMUs with different feature bits so that one
>     vSMMU enabling a nesting configuration cannot reflect properly.
>  2) NVIDIA Grace CPU has a VCMDQ HW extension for SMMU CMDQ. Every
>     VCMDQ HW has an MMIO region (CONS and PROD indexes) that should
>     be exposed to a VM, so that a hypervisor can avoid trappings by
>     using this HW accelerator for performance. However, one single
>     vSMMU cannot mmap multiple MMIO regions from multiple pSMMUs.
>  3) With the latest iommufd design, a single vIOMMU model shares the
>     same stage-2 HW pagetable across all physical SMMUs with a shared
>     VMID. Then a stage-1 pagetable invalidation (for one device) at
>     the vSMMU would have to be broadcasted to all the SMMU instances,
>     which would hurt the overall performance.
> 
> I previously discussed with Eric this topic in a private email. Eric
> felt the difficulty of implementing this in the current QEMU system,
> as it would touch different subsystems like IORT and platform device,
> since the passthrough devices would be attached to different vIOMMUs.
> 
> Yet, given the situations above, it's likely the best by duplicating
> the vIOMMU instance corresponding to the number of the physical SMMU
> instances.
> 
> So, I am sending this email to collect opinions on this and see what
> would be a potential TODO list if we decide to go on this path.
> 
> Thanks
> Nicolin

