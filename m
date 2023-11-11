Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 250797E8BFD
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 18:54:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1sA2-0004Ha-4f; Sat, 11 Nov 2023 12:52:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1r1s9z-0004HB-E6
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 12:52:43 -0500
Received: from mail-dm6nam11on2062.outbound.protection.outlook.com
 ([40.107.223.62] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1r1s9w-000676-E6
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 12:52:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaufHP72gP5+IXKOzRaIRXsNkQdwDF7i54v3pGjQDYGxxN+02vNfWZKHveHVM5Y4NvLjGDYxp1i7bCAigVvo2UlUMIKuWRT4+XDyaBIyDnG/4xZ/5pN1jsWDSDMYvm0JwArHd+cQ9q1nNI0x9zmLUX2cJGV2fiTEf8pMKY3+hEV6OUnQuRHj50oseXBuqwTfDWsBTyt2XmKtg7U59XMhSZVno6gStLLRqfNiYKNGJkb83tax5EkfV/CC34rAZx3CJUZc1JEg6kIvvr9Ib5N06WOpAhf3yKl2RnGdas45pztCd6ZiptfoJn6R3uITy5UGBR0mKDHVjukrbH38WxrtrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Rm9MaO+DG142wLptdiXafvyHWuYrvQJ5dYUngOLAbs=;
 b=T9jlTCrmgjYRoYnRtMDZN7BAdbKtylUXVdaOXMCRe6r8WD4dy6ykcwaHtArv85GVtI3YIvcjXgTRbtVti8kOHwaV8ebOQk+BUe6kI3HE8O3ZYYVu7egWwn7AY5Bg2zasbqkIjuBraka3TPs4iEW1CW5yipyW95LDqTll1d/W4BPlEtVwnE258RQ/6A2bEAdEbbl+bJHqwxXdUIMQQGLxkwbDtQWs3U2+lV2uCO14bLImaBaQPKARh2x1OXj53PTUjSiBGmNuxrNIfC4IfqON8y4rYy8X0PMvk7QG8mWhJ+ipOJ5OSZFxSAsBI+nGijL0MvgpgzLK6RFbWUyl3HSb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Rm9MaO+DG142wLptdiXafvyHWuYrvQJ5dYUngOLAbs=;
 b=qd9rT1FmyWasGpVic82yeJUxFuVGsxnNy9246HNlumUe2plY1qbIC9xZ+Ll0NFEMZWDulcvPdxx/HycU5sTqV3dYiCZbfFVx0/LnPtMerSZtri22/TmY72BPmIrKD2TaRMgavNWofnHFfYLmucJHzBPScrUt4xWFzKddJv5z5q2wbVCsublFc8bofKEpb6lVt5wD0xvL8fXiSPl8KgclKvR5tvpxwnmnJLsESvv1n/0TcIh2eT2v57MmWORvKr6JkYlCfzCBFPp5OwPxoIFnJ5TOtB3Bg9n1Qu5NQ9yRogPkl5fEqSqvhgP0I89BukhSCXeotJ+DH0fSWVEGmZGFPg==
Received: from DM6PR13CA0072.namprd13.prod.outlook.com (2603:10b6:5:134::49)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Sat, 11 Nov
 2023 17:47:30 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::37) by DM6PR13CA0072.outlook.office365.com
 (2603:10b6:5:134::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.12 via Frontend
 Transport; Sat, 11 Nov 2023 17:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.13 via Frontend Transport; Sat, 11 Nov 2023 17:47:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 11 Nov
 2023 09:47:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 11 Nov
 2023 09:47:20 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Sat, 11 Nov 2023 09:47:19 -0800
Date: Sat, 11 Nov 2023 09:47:17 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <jgg@nvidia.com>, <joao.m.martins@oracle.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>, <jasowang@redhat.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <yi.y.sun@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v5 03/20] vfio/iommufd: Implement the iommufd backend
Message-ID: <ZU++JT3FBbGhJIKH@Asurada-Nvidia>
References: <20231109114529.1904193-1-zhenzhong.duan@intel.com>
 <20231109114529.1904193-4-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231109114529.1904193-4-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|CH0PR12MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: bc2663b7-82b2-47de-20c6-08dbe2de4706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MWVqj72Rx99jBObUTbAN4rTCQpwIs5CnJjjiBOfT1Vren++39LfTryWfBLlWuKvSXMbTow7ZDeEX5uxGcTb/YX7ndCNQ5SrasIzNDJkyOui4WfnSOAzrIjAgUbkui/GFhIgEoaBJnyhsOg6kmruSC8Y0uxGccRxBuwivUsWEW4SQ1fBOk5S6XANvmsf6BrwG0FFPU/00QC7PEULoLmBNIQNVAprL4lZObHuhH329nkx84j7OuG0phtiZa1SEs+GYUI7Hhb+rPYpg00e2m3JhA5XBsUh9/r5innRlOSwsMS/G8yB6gDZVksIME1Bno+5trf8/SZ7BXIls3q3igE5udmYjeNEqbeVy8U7qvxstwRH9hSZt8x0UXz4/XUdrCwx93OzztFWpE2+8oj9xImC5hN0ddck4Hrmo8jLOh7sFersdqbRFuJhUZPRWBKaZWunMXb0/c4GHV+Atd2Xc1et4VimhP0wLfpMUJ8n9bXKPgNkckmSkhs7XOX6/4+c+cil9/lELJJ1rJx4RD1ARdr7AZV5EXJOAsGVbyXigC+H6dWjhTwYzQQy5NTEhTLlC7D5wT7ApLsIzBhPSQuhocz564T75rVS4AAtu8BmD+EFJN5BtRxe9JYSR//XV7A5rO6/xver8R5StlkhjSZRruoFIwrxgOvJPpKpgl4Ek8RYnWDsYoBi2dpaJ8faP8KJCeiFilt4DtIAF9fUHpi6b5Oo83j7rnGCeLisis0yQS0Gtnw=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(82310400011)(186009)(451199024)(46966006)(40470700004)(36840700001)(4326008)(40480700001)(55016003)(8676002)(8936002)(40460700003)(2906002)(41300700001)(7416002)(5660300002)(336012)(426003)(70586007)(70206006)(54906003)(6916009)(86362001)(316002)(478600001)(33716001)(47076005)(82740400003)(9686003)(36860700001)(356005)(26005)(7636003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 17:47:30.3695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2663b7-82b2-47de-20c6-08dbe2de4706
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
Received-SPF: softfail client-ip=40.107.223.62;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Nov 09, 2023 at 07:45:12PM +0800, Zhenzhong Duan wrote:

> +static int iommufd_cdev_attach_ioas_hwpt(VFIODevice *vbasedev, bool is_ioas,
> +                                         uint32_t id, Error **errp)
> +{
> +    int ret, iommufd = vbasedev->iommufd->fd;
> +    struct vfio_device_attach_iommufd_pt attach_data = {
> +        .argsz = sizeof(attach_data),
> +        .flags = 0,
> +        .pt_id = id,
> +    };
> +    const char *str = is_ioas ? "ioas" : "hwpt";
> +
> +    /* Attach device to an IOAS or hwpt within iommufd */
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach_data);
> +    if (ret) {
> +        error_setg_errno(errp, errno,
> +                         "[iommufd=%d] error attach %s (%d) to %s_id=%d",
> +                         iommufd, vbasedev->name, vbasedev->fd, str, id);
> +    } else {
> +        trace_iommufd_cdev_attach_ioas_hwpt(iommufd, vbasedev->name,
> +                                            vbasedev->fd, str, id);
> +    }
> +    return ret;
> +}
> +
> +static int iommufd_cdev_detach_ioas_hwpt(VFIODevice *vbasedev, bool is_ioas,
> +                                         uint32_t id, Error **errp)
> +{
> +    int ret, iommufd = vbasedev->iommufd->fd;
> +    struct vfio_device_detach_iommufd_pt detach_data = {
> +        .argsz = sizeof(detach_data),
> +        .flags = 0,
> +    };
> +    const char *str = is_ioas ? "ioas" : "hwpt";
> +
> +    ret = ioctl(vbasedev->fd, VFIO_DEVICE_DETACH_IOMMUFD_PT, &detach_data);
> +    if (ret) {
> +        error_setg_errno(errp, errno, "detach %s from %s failed",
> +                         vbasedev->name, str);
> +    } else {
> +        trace_iommufd_cdev_detach_ioas_hwpt(iommufd, vbasedev->name, str, id);
> +    }
> +    return ret;
> +}

Being a bit late to the game, I might have missed some review
history here, yet any reason why we changed the attach/detach
APIs to specify is_ioas? The attach kernel uAPI generically
handles this without requiring an is_ioas input, and it could
be interpreted to attaching both ioas and hwpt (auto). On the
hand, the detach uAPI doesn't even care about id. So, I don't
see a value of the is_ioas except the trace logs..

If we have such a hard requirement somewhere, shall we create
an IOMMUFDPtObject structure that holds the type (ioas/hwpt)?

Thanks
Nic

