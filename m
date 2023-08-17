Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B5877F031
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 07:31:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWVb4-0006gM-MY; Thu, 17 Aug 2023 01:31:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1qWVb2-0006e8-Kp
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 01:31:00 -0400
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com
 ([40.107.244.57] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1qWVaz-0003oE-2f
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 01:31:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8EzF7ReZuqw0u27S6KFTetQGGhv3WfaxcrZs7VtncE2F3Kq+lbv2+9r1BwCPJJhVvUEeG0pjeH++U4aWDcoi0XvSIE41Ih/+xDCuz2hsAHOLfV27OAGpcJGrxM9Rwxbsm7Qkv+EHgiDd1Y8dO4gpSPHBwlDmirFMK8CMof9UF/5TAm6aEm6eqz6MWBngpvllY25yKXg+Y/JKUfih9x7qpmVJeMRbmU+5LWpAEQP1jWKDb6Xigrn5fmnzsCDqpfb2iNtIg9g2a2vL1WnuVE9u4/6r0dtY9kqz1hAQemj63+WO+ovCmWt5cCuM+ayGEUyl1AddIknkwMvHFASdvh4ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ft8PoYVm4OFxZocRkM+o4aSeCd/4Wh6pukl4zJTP6e4=;
 b=U4deMLYslFOfSMqFOl3cF83Ss6kOCyi/43SReNW4P7IGAXR1dnsbXGRXJDDEC9s/BgC//wzljEj99AhsirXl/Sv4tpAcAdOl2SJczCoQMuKUwt3ji8BrOnqIp1DigWUZtn4iQDSCqq+Y1ndg35DksncUaMuqkw6NyZRkjJIwKq5NIBQd5Qwi+EFmzR6vdHXOqsJ98QJZlSWMjZeqayqNYL7g/iAFrkVKbhoVbnu9BmT543LEJaafRLbBFYmVHV6GLQX0Lb/hCAB0PRCZVzkYGU7OpTqD9rkpa/3tP1pHLuF342sruL+snuIqi86oTL6GmUefWp5hAbyiL/7abCsiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft8PoYVm4OFxZocRkM+o4aSeCd/4Wh6pukl4zJTP6e4=;
 b=IE8w/zTwiFutovJlraETSJJkNd11cNG/mfURK7+yot0MOxVokeVmaf0CNKDF/1WtuidxIemsU/qOWCGKQ/HNRORb7jPhLk5AvoMDuxJPfsu4vU315zTqE8TFTpicuJhcJDUr/LNYWNDjso+okMg8uDDO6pQ4Bhc3Vw3GGKGh7WGd1KHCKLXgGgbD/ani4140qMY0WNdOWGV9OzTDmNtz4H8Et82rVaZ+qdz14x4OgZ4gT4sH0dRcPSARhhSwg5kpcjz4MCeLx7dW1BfcOkRF7WAy4LuvQVAUGtaj3NbTqei83FEdlWEYASBEXwMNsSuioKU/X5OVvFHBi60seW3Hog==
Received: from CH0PR03CA0294.namprd03.prod.outlook.com (2603:10b6:610:e6::29)
 by SA3PR12MB9228.namprd12.prod.outlook.com (2603:10b6:806:39c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 05:25:49 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::dd) by CH0PR03CA0294.outlook.office365.com
 (2603:10b6:610:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Thu, 17 Aug 2023 05:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Thu, 17 Aug 2023 05:25:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 22:25:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 16 Aug 2023 22:25:34 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Wed, 16 Aug 2023 22:25:34 -0700
Date: Wed, 16 Aug 2023 22:25:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <jgg@nvidia.com>, <eric.auger@redhat.com>, <peterx@redhat.com>,
 <jasonwang@redhat.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
 <yi.y.sun@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [RFC PATCH v4 22/24] vfio/pci: Adapt vfio pci hot reset support
 with iommufd BE
Message-ID: <ZN2vTISmC+S/p6hO@Asurada-Nvidia>
References: <20230712072528.275577-1-zhenzhong.duan@intel.com>
 <20230712072528.275577-23-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230712072528.275577-23-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|SA3PR12MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ddb86e9-9df1-486c-ce3c-08db9ee26a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVmgLUeUkDjF8IU3BYnc7NW+w/bllHXDWz21nSMOEXjWbhbAPSmsOLB6EbH1qHuVIP311AgfSU7wIm2sQV04QEMKYSDy/oGS1X+JeqJiH2u7tjZhKIHa90M7WW9Twqx9YssyGE971qIwJKsRjxe0cqBQI+iJ71x0HiwY2KGd2xqERDeBu/vstXrX5loFWQOH+ZfT4u7Z80Ay5uzVwNYBF6bbBV0hTSBk5MG8CpRqMhp3J8dYHDUiOvmdMSNqkeQvrkfFL4bby3XreOXnBZUAhlM8B+cdBq5EKEXo+cor4hmVZa1chWn7c6xHzcyaiaDQEHF+YNgL0Yrn1gYSKloujsZABiUFRBqcgoQJMzZq56WN1dDwT6pjjEhvd2pfSvkmZpesY7uuI9GEBMKreIX3yiXSPDh/Di4P3cxLax9CxRpJYZtCm5n4lLWrWSwItI+yS5hWnz/I2TVEjEA2yFjV/8Ww1sVWRrrqOaX0ziOsfpmHs6Ussu2nXy6dhwhaDpM2ELBue/Vx24MDDHrpGGtR3mNnqQBg1AV664pGW031KLlL8vx6fQyFX3wweyQly9cyrsx7S9k9KcxnO7lzzV2Zy5bk1l1wnmIgucv6lsftDOuydHPWcccT9i6noaBw0BlatBDeiwqWn9HkJgZrfqgiDee2BxPzAU87ouizNA0+F7DJdc+Y4GfW8SSXaPh3UzZl+2ywR87kuiHccqnhhuFTeA/Q4g9bmLcKLRqYuWbybJJakGHNnYEN8oixQOA9k8Jf
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(82310400011)(1800799009)(186009)(451199024)(46966006)(40470700004)(36840700001)(55016003)(40480700001)(40460700003)(47076005)(7416002)(426003)(2906002)(336012)(36860700001)(478600001)(70586007)(70206006)(54906003)(6916009)(316002)(5660300002)(26005)(9686003)(41300700001)(4326008)(8936002)(8676002)(86362001)(82740400003)(33716001)(7636003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 05:25:48.4942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddb86e9-9df1-486c-ce3c-08db9ee26a46
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9228
Received-SPF: softfail client-ip=40.107.244.57;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 12, 2023 at 03:25:26PM +0800, Zhenzhong Duan wrote:
 
> +#ifdef CONFIG_IOMMUFD
> +static VFIODevice *vfio_pci_iommufd_binded(__u32 devid)
> +{
> +    VFIOAddressSpace *space;
> +    VFIOContainer *bcontainer;
> +    VFIOIOMMUFDContainer *container;
> +    VFIOIOASHwpt *hwpt;
> +    VFIODevice *vbasedev_iter;
> +    VFIOIOMMUBackendOpsClass *ops = VFIO_IOMMU_BACKEND_OPS_CLASS(
> +        object_class_by_name(TYPE_VFIO_IOMMU_BACKEND_IOMMUFD_OPS));
> +
> +     QLIST_FOREACH(space, &vfio_address_spaces, list) {

Indentation here doesn't seem to be aligned with the lines above. 

> +        QLIST_FOREACH(bcontainer, &space->containers, next) {
> +            if (bcontainer->ops != ops) {
> +                continue;
> +            }
> +            container = container_of(bcontainer, VFIOIOMMUFDContainer,
> +                                     bcontainer);
> +            QLIST_FOREACH(hwpt, &container->hwpt_list, next) {
> +                QLIST_FOREACH(vbasedev_iter, &hwpt->device_list, next) {
> +                    if (devid == vbasedev_iter->devid) {
> +                        return vbasedev_iter;
> +                    }
> +                }
> +            }
> +        }
> +    }
> +    return NULL;
> +}

By a quick look, the "binded" sounds a bit odd to me. And this
function could be vfio_pci_find_by_iommufd_devid()?

Thanks
Nicolin

