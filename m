Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE447942F2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 20:17:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdx4V-0005IN-71; Wed, 06 Sep 2023 14:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qdx4G-0005Ha-Jf
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:15:58 -0400
Received: from mail-dm6nam10on2041.outbound.protection.outlook.com
 ([40.107.93.41] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qdx4C-0006Ik-Nx
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 14:15:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zbmzfp97qfJIHwzb56NGgeoKNKPeiDilU3ryAFnnbcenRUJ34x8uKYvJqh52k4yVdZXw0znEjUBTVWz5sA+kQJVpuSDkoTpBtEIHa6XCr0I01dT7egsBjYnq+HxkTIXdPIi2A+QOR4Ku5GuwXwx1IUAc+OqdInxkBnZXH54vEMKGmHiiHv7ysueeF7wdUlrjCPZhquFd6VvV68Nah7Iazo4eQdv6WMq3M1rwG2ldZizodrG4rd2aX5Gs8xUVoH62P2V7d5dL1Vbm7MbIY/2d7sLGelgCgnbkva0gC4+lf7IXSWgWUMipT7g/hshN7P0XE+JMsPF+wXDeZSnjjvueLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3PANnBkhWyvKmmO7LuAh+J4lulZ6ibBHyxaAksN+to=;
 b=BPSxp+Yp65aHgyISC0mk/S4sw/0nSRMl7iIjvo/IClxV6HuhQWzTxSj7FpcTG6pntACO/xIEh25bTfveX65u94U+QN/RXNh6yPNYUQZpCiCp/BcrnJD12Hku0nX8/c05wmw1CehvIVa74ghcyi9KkuxmwCk9H9MpX2b1JxvFmq+2Qj60q1sAGPAcHK4We9BSg/vF6NKgoqLdRd6IMApcMKca3dqWq1LA80fFVWDm/iN5egLbErsVT1l+sJSyRynw7yuVXuoZBgN8z+vaRHjE6iomBebCoU7ztQWgsacWXw43pR8P9JL4snCTaXBwdFxxz8KWsJClIwhLGI9xUBlnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3PANnBkhWyvKmmO7LuAh+J4lulZ6ibBHyxaAksN+to=;
 b=UDifI4BOc8JPdYbM7+/65Md6exJrZDmClfK3BM7N5j+Sv7ZxE+ObGy609NVFeFv+sgIATkxG21It90Keel5pCawPv1pLSISejpx9uuxsSVNMJU1hm5X+quOdrmWmPNY7JkYe4dN+hOtxJncLCms+JuHAkSGtXgUCixcJscC01CG9IgB0QIkE019cgSh9+nxob3derzLVTO27+pqWveQV6PMDfHKZ+EfP8qNX6qGn9uu585pzjhUDxqSWZeMJOGx0JHC/jocF97A7PH6PRh8cF4envbblggSi5U31iMVu/XvQXmInW1Sdx835DMin9KCKiE0Btp81UR3oJpE4ul7HZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6298.namprd12.prod.outlook.com (2603:10b6:930:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 18:10:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.035; Wed, 6 Sep 2023
 18:10:40 +0000
Date: Wed, 6 Sep 2023 15:10:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 eric.auger@redhat.com, peterx@redhat.com, jasowang@redhat.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v1 21/22] vfio/pci: Allow the selection of a given iommu
 backend
Message-ID: <ZPjAn1Asi5ZE9yzB@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-22-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830103754.36461-22-zhenzhong.duan@intel.com>
X-ClientProxiedBy: BLAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:208:36e::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6298:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bcd270c-9224-4f9c-8080-08dbaf049438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQBAEBx/73YvX967P0UoT5ZRxv98bANyd2pdMSD5zCrPr/xgRMKsViHrKnnJKCqqZfZrRVMnvgdqDAYbnqTIP4UD5swo2oJH0PqV4WzW3oHJa1iWfqig+p0lmfA0BbfrqhdvvJujbTaDXTlJL5CeKi6qqZEhmSGM6mOc2+/yZo8imT9/+68mULEcyXm189tM0KKCB8gtnT79kXn3le39lbe7fBJEJ1/DbdnYST4HaQa6gmgH1scDlR7RjfElpdvEjV1VwWL3C5xYC6srEXpPJ85ClZFrcRbNVrz7Nf7+gttPkV9MDJg0/hmbqWvzFAZ60YQhWXWn72EqNo0gCITdDf8OtSrYuteFPuzx7+w9d3+4xYUvUuO8mTHBWeK1hmdQdTBalkXUd2qK2hz6vWhrGHmt7ypVjHI1D1GYNllLYNLt5U5n1FWAu1kEbdfD47h1Q8u8iYOK6OL+XPTyWGZRRqd9+OU3+tmzL1I0jkU8+xPB1o/5tDFS+4UPeN8nHT9/CeekafXeV975p6C/oMZetTHEkQesRhW/jq7m+NlnIMAdbGZ8+Gy/edvVf/lHuVJ4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(186009)(1800799009)(451199024)(8676002)(2616005)(4326008)(41300700001)(26005)(5660300002)(8936002)(7416002)(2906002)(4744005)(478600001)(6916009)(316002)(6512007)(6506007)(6486002)(66476007)(66556008)(66946007)(36756003)(86362001)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Cu8Bep27Pgndsfq4ZZtBZE9SO1/2mh76lLc0z7JBtwtdD26R/h2QyR6XZZb7?=
 =?us-ascii?Q?V091KYlbAjHtpwSCAQG8ZfzelfXoQCsqkA/dPRUzvpCOmYc/B1zPve5xzUyO?=
 =?us-ascii?Q?yrZ1iyZ4DolMWpMvPsiC/Lilhpu+5RjZZZ9ltRH/KXsOnZn0Rr1e/gWkaW9r?=
 =?us-ascii?Q?ZIye5JM6K1gVTNmiLv+NyzDO/GanLJ7INq9CUlibYSLKdLB3hJnkYi2tvKWn?=
 =?us-ascii?Q?uWSOMm9WmHPXMaa4grTtcoi4qXd0/9hPpD6n+FV9Sv8NHondg06+Jy8zuz3q?=
 =?us-ascii?Q?51MWr9OkEgI/dg/tlNBopkQIsUfJbBToG2cf6iWTBo3VWNMjebC9DIK8+qzx?=
 =?us-ascii?Q?8+Cp8ilIrhpU9kDR+8JCr0d0xvecM2ugm31m09Y4RWhvf2k2rhY5LA5C0pH3?=
 =?us-ascii?Q?SN0Exh94OZxVW2zLzAIqDC2+SLOaD4sFLu65QWZAur9izsK0JQ+4je0B0tno?=
 =?us-ascii?Q?G/tExKFEX+lIibVbktJWiD7679K0+nSITUWQTq4/qK6c4sA4gDYuJbRekmP5?=
 =?us-ascii?Q?9sGrETQwSV1fdwgmFU9Chql5fRjnPGxZgb4fmmqbQ4R1nWCp+9FEcLs2Bpqq?=
 =?us-ascii?Q?KUYtLfT+8IjLdSDZEL+eXC2lMb9Qc1Ytyoy//Z5qgrzFcZIetxGegvXJXo1r?=
 =?us-ascii?Q?Gs9/697dLjZJW73wmRJbnwiZK+LXp5hTrnZx736Pcxu0T/XtdsuVPCu+p5SB?=
 =?us-ascii?Q?mkRJxl5GwcPjMIuyoqtMym9ABwHxpqQY3CqT3g+OGa5J6OEzQH8WWmbFKYwd?=
 =?us-ascii?Q?j37zE5jgoqmDGAijOX/De1lJ2si8fTs/6i4vo9GLi3ozZ5fYOTpMDrhcp+vW?=
 =?us-ascii?Q?41p/Dkz19Gipu5P2h8KrcbUOxlSA3CxXjP5YQ+QRorVuYftLEaOiSKzTuXJL?=
 =?us-ascii?Q?SPvOUF+PQBp630+ufEgHOm5srPHF6sLC3ZcpHxOPlQLi683UY//HYpanhJep?=
 =?us-ascii?Q?jUidUg+OEqTls+NfcEKjdFTpUd/r4QRwQSxm7KkganuvH2SJ8aCxBSPYK4n6?=
 =?us-ascii?Q?nYIcwPSjXpRFoW5+eNkEYMsK6bzbaDsVJFveWL4pJ8k6vMl3fQ0zNuaiGNd5?=
 =?us-ascii?Q?7z/eWPIUsKCKJplVUeRFgTnhN4hylNCod0QHkBMovGaRTLrNG+re6DBXtYLZ?=
 =?us-ascii?Q?Qzl7BlLj4jSxBfJV5D5U2fb8BZxQAmxJSX2O7fOJyvAtgj/Fdzmv9lEwzaWd?=
 =?us-ascii?Q?zvN4NPOCRBeF6Sxr3DHDnhxF9AzKcWnmEZlzN7P0vNb7d0Ey6IMGTUjWJSHH?=
 =?us-ascii?Q?aUQTDLhBS/vVY0GycNcX/M0qcE0Jdt5q34JgEm7OLb/oKztIEVcmIjJPDWRt?=
 =?us-ascii?Q?2QxyVdIfkvpQ9WDYC7r/8ndmlpwTOvM1G1In3jYCmFT7zgNudIZ1iatSah9c?=
 =?us-ascii?Q?ymRq3w1mPN9gciHwHY1i9usOeUIn66VRR9dvPZ4eLR9UrFAdEh3fkf/JZoC5?=
 =?us-ascii?Q?C71u+eXS+KfyD9LS+rbyHUOkSfXpk0OJ+inSBKaTSP0YytBhdWxtjtvzxGBh?=
 =?us-ascii?Q?aNBtIpkr2DgioCvLVM/PT+mwVmpR7rz1tlSF5rRwfs8RLyFZw4O5vae4WAEC?=
 =?us-ascii?Q?i+Sikc/+bowSyqDPqxEK0kvmulf/XxoDUoWxYEcH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bcd270c-9224-4f9c-8080-08dbaf049438
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 18:10:40.6334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yQXFNd+j8kUqOl/9t4czC4dQ3TWjoiD/u/HCna3htcbSxspvPcZtvarijNoeH2+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6298
Received-SPF: softfail client-ip=40.107.93.41; envelope-from=jgg@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Wed, Aug 30, 2023 at 06:37:53PM +0800, Zhenzhong Duan wrote:
> Note the /dev/iommu device may have been pre-opened by a
> management tool such as libvirt. This mode is no more considered
> for the legacy backend. So let's remove the "TODO" comment.

Can you show an example of that syntax too?

Also, the vfio device should be openable externally as well

Jason

