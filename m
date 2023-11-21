Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A7F7F3A03
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 00:03:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5ZkH-0003TT-CK; Tue, 21 Nov 2023 18:01:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1r5ZkD-0003St-Rt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 18:01:26 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com
 ([40.107.93.50] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nicolinc@nvidia.com>)
 id 1r5ZkB-0002kh-J5
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 18:01:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWhzEF/VX9uiPYQ6Dgwh/njPzVjEbaAsvIkVpLXmDzfPZd0pvy+6jY0TXlKMDkaw8NXLAd/pR1XuTdg5fSNA7KetOn9TAp0PspNeSvSgS0IRxS6oDebFeuA9KFQL9zC6pH3IiNyw5L2KI7HoW1vJxdBV/laXTFxiofagW+XseRZZWak1Nk2RaHSd7kj1nR9Zdp8y0mdESQNs7FVSKcE3MTHbIXmrCN2tqalfv2s1fKrCDaSOxoP+5OivcPF5VLSVjang7B8cuFSjwUPE3f8NrSJytFV78fyYeQ4D/Dwcd+UBljikDWaQm8ViJMNqIzi64c21JEB+L6cS8YimtXP8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UNSYyk05Fw89pKDq/JJ+98yK1HwkV5g80MwHOb6E3E=;
 b=enGlBE8o+SpZ9aUu7wMMhATXUDH+Qgz2iPHCHNubfKcxYSrc4eGAJlJv7dYsWNySxp7AOO7Y6f78oIIA5+B8vTYmstt9pCs4jX03ftWRMNxDpSOTbky+zfESz/5zaCqNurYbHaUTAVNsUhczm1cSbnIB6vMhBhEu0mTzgWvh8RnDHf7iFWgsnivOq0xXMAxgGAr39EOztBTlthAKsyGJf3Glj5M4B82V/QGueId3FnVZ3q4Z9T3kn+W2qDPAkmZAjR6NXvmF1JWWFzN0sdNC3ULkryMuhrqm8pITmomXApNIP7i5GJbLfKeHbfNiIv4Xx9lYpO5OIwXpsA4x47w0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UNSYyk05Fw89pKDq/JJ+98yK1HwkV5g80MwHOb6E3E=;
 b=s8894rPTllio5UlpQ39uDp5aG1PHWmE6UeMgHsgoX9Rj6bCwhnJJXNFty8j0pkdnlJE2LjLIZZ4PBIrjn1ls5qxGr61jXVgjkoDK2aP5lkTMGTy4KO+DGf7RNdsU3dJqCpt0wRbXmMaLTy7r9rD5TAtJpwq56LgQsXkWuIP0ODmAUhCu++39TY9txudfDdnrg7tS6AxZpZ5IaSQ5UFxZaPLafkbjNgap/RC4UA8hdRVjNcOqXdzqhgMmQVhOQ66fFJqRA1rQefxsK3FYgPRweUH1zEY63yeoafhgdjBso3fyVWriO9wJUfCmopgWdmk+bLITwZG645p/zmL/x/cdRQ==
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by SJ1PR12MB6100.namprd12.prod.outlook.com (2603:10b6:a03:45d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Tue, 21 Nov
 2023 22:56:15 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::b0) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Tue, 21 Nov 2023 22:56:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 22:56:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Nov
 2023 14:56:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 21 Nov 2023 14:56:04 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 21 Nov 2023 14:56:03 -0800
Date: Tue, 21 Nov 2023 14:56:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
CC: <qemu-devel@nongnu.org>, <alex.williamson@redhat.com>, <clg@redhat.com>,
 <jgg@nvidia.com>, <joao.m.martins@oracle.com>, <eric.auger@redhat.com>,
 <peterx@redhat.com>, <jasowang@redhat.com>, <kevin.tian@intel.com>,
 <yi.l.liu@intel.com>, <yi.y.sun@intel.com>, <chao.p.peng@intel.com>
Subject: Re: [PATCH v7 00/27] vfio: Adopt iommufd
Message-ID: <ZV01gh9I0QgcU+uk@Asurada-Nvidia>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SJ1PR12MB6100:EE_
X-MS-Office365-Filtering-Correlation-Id: b10f01af-0721-4f51-dca7-08dbeae510c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YgFBC71Wrw6OjFEA77BgWOJ2IAPrndKHCc/Yocqn1vDDJzm7b1GWwu2A+D46yaS2UZcJNglPw2iZh/5DaAnu9Qd0MLmEf8nE7PK+YhEZBThPzOk/0+LMrWdN+GliB5I8fxGLPXXmTPSi7kMUPHDPYKimixsPivHe6JxS0RPGVltf9vu8SdJSX0wL+O41nIGRDcYXyukCTTvpX3+rLM+w/12TLVhAin5aIVLl8fthNLX+tk6YCE6k3HKkq6dGm+izpgNLWA9fLseA/4iiwzhmj4SneTV9MqOoCXDtRy54TmWtU+teUXJuSBvazr+IKS3+zW7g3hfyE31elVxrwW3TOG1l3++RO4gHb7tDJCSkSVS3YfSl7rFPm4Xf/6Nw1sd5VHnmzmWP8JwTjxyEbcJXUrredEH8jmB/n/DazE+m6pZs94az4H2IXslXopA5Iss4Aab9+N2ZFWozqtiK4fsXQnX5DD3lI23zgT3eLJCtsM2dOrxPlBaeSHHPhj4cHdJdt5zToHwDc1Z0xuvHL5rVrBopDEWgL1TblPBo2Gu8ZReckgbENb+PjhQ7p58vsvVmDOaiooLjG3Y3Okb6hsi+daeYwD6XXC8GkX3lUuFWXM9/OmOdahoOh1wdLLUuDD2e8WquXgcnZgcH+iq5t3NsRHwd4qiW8rEey5YRT8bjPpiRJRcIJK1wcEHxP4J+uuzDqOsDNFlQqslwD0x6IyXIbc9MOEUF84lmQvq7UlmCp5WY3JyxWTKwYuxPk1UZf2LF6jvNFFDxBwv4hYhVRFCemmLA5PBQZ0HLr7KKpfMzx5PqO/rDs04Fewsa2VHJGjd7Xh3BvgeIb4rfcWyrljGxbxMsDqolK9U3R24f3z4jrA=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(426003)(336012)(33716001)(82740400003)(356005)(47076005)(86362001)(7636003)(36860700001)(6916009)(70586007)(54906003)(316002)(8676002)(8936002)(41300700001)(4326008)(55016003)(7416002)(5660300002)(4744005)(2906002)(70206006)(9686003)(26005)(40480700001)(966005)(478600001)(67856001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 22:56:15.1594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b10f01af-0721-4f51-dca7-08dbeae510c7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6100
Received-SPF: softfail client-ip=40.107.93.50;
 envelope-from=nicolinc@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On Tue, Nov 21, 2023 at 04:43:59PM +0800, Zhenzhong Duan wrote:
 
> qemu code: https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v7
> Based on vfio-next, commit id: c487fb8a50

I've tested with an aarch64-softmmu build using both legacy VFIO
passthrough and IOMMUFD+cdev, although this might be similar to
what Eric tested.

Also, tried rebasing our nesting changes on top and ran some
2-stage translation sanity using this branch:
https://github.com/nicolinc/qemu/tree/wip/iommufd_nesting-11212023-cdev-v7
(Note that the nesting branch is WIP with no stability guarantee)

I'll do more tests with vSVA cases in the next days, yet FWIW:

Tested-by: Nicolin Chen <nicolinc@nvidia.com>

