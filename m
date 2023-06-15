Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8E0730E74
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 06:59:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9f4k-0002xc-1R; Thu, 15 Jun 2023 00:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1q9f4h-0002xP-Oh
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 00:59:11 -0400
Received: from mail-bn7nam10on2048.outbound.protection.outlook.com
 ([40.107.92.48] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1q9f4f-0001ty-Ds
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 00:59:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FORZc2vqlHDoRGFPOm1FGiFviz5Rja1pVYmgrugoxDrngjadHCODRrrmW80Z+nxuk2DEOJ4kO2fQKakzVZRf2WV/30E/5bQGwjdj+1gaaFjZiwZIxRscNxZqf4i75lKlUNLfrXT35wFXg1gN64R6tszfAgcBYh0U8MzoL4JKpOA3Ec3sjyJ0oqawrcKJISUWMRz3w2dQoLnJYfyQa63Dvdj9YQDvvfeNW45sXdYhNoK64M7ufbJnspNeeLoOPbrcKeZBhfh4NdJoFVrb5/OcAcx3jlWIT2koYjr59Zj6gJlGmEDNkDai+IJavY//+njiCPW6DC/lHY9wxAmwPfEraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpzFdxYLzCqq9baTJu1xa7qkftBU3wC/Xy1DvrZqmyw=;
 b=Sp+KdO7DSbjfpDL+Avc+GVgjBk9pWTubQO1z+ATTXDORYEMp3bN9/VqY8Vo8BKy4M2W0fblbhgI9QM1zdOg2LhPkPnf7nyIePh/e76WviwgxIN9EZwwyuvxQLM+8hDtfaUFEHH5DKJxHrHFS/lSXVv/hl8zg4kXGJjKHfP0ZbA6opvRqi8MDAwIA+4SMvgX13RQ8CYHeKRZ7IjC3MHc/tYAj3xGksD2K8iJ6znZGNVLX+u9kjLz4WNI0XZGr+yhaIQBAdaXVf17vQMBO64ogBKdI2Cr+OFnbNPXUTXboQnmPq5FEC8RKIGZ/k3nL20FbESMpsoY1Y2dMKLU/St2K3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpzFdxYLzCqq9baTJu1xa7qkftBU3wC/Xy1DvrZqmyw=;
 b=Yo5RPV3TCLpCtzHHeVaHHi1Oror3sSUuTx+MphWslh+Ww3luJbkVVx90/o3qWMnrZfUkvDUXyR6WGKvWJigTSc8AHbjWYGDlLihIXAkhqi3jmuVlNQdsJNLEKNV6+Q+zXSBN5YsG4c8nTDj/fashyQqDRl22jwOHQuiqoMQvGLI=
Received: from BN9PR03CA0912.namprd03.prod.outlook.com (2603:10b6:408:107::17)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 04:54:04 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::e5) by BN9PR03CA0912.outlook.office365.com
 (2603:10b6:408:107::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37 via Frontend
 Transport; Thu, 15 Jun 2023 04:54:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.26 via Frontend Transport; Thu, 15 Jun 2023 04:54:04 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 23:53:58 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] docs/devel: Document the tarball publishing/release process
Date: Wed, 14 Jun 2023 23:52:41 -0500
Message-ID: <20230615045241.5838-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: cb70c3c2-0e56-4adb-3152-08db6d5c8b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRVSGcwxqpkm/xSvBurPnJa+wvzhdRHs7d0ON0cUcQngri5fxqOe+bB1Btbw+K20GkvHdYR+WPfnvERvNMjQQLII+7IqkE5iqrZb5CwEApS64hjOHqxD0LQtajK/NDcZ1DP8aO9tncthmN2FheD2OIQg+9OGRlXrLVRsScG7Q25o7aByHv4DH1v3fNdqfNaVKKWcHUzH0oSr1wIKYJsw+sOr+FVpQiLhG4PJHT+9GmxzfEp5WRzNRk7DEv0dFUC9VulOTOQISBmNpyDL/1HIWFRWBi4W8HkVv9nH/GU3wY/GIAp/vhlhT3iLjXJGsfmmFPCdVRwUeCy3Me0hNvCj+jtS2J4b8uoJMAymSdMz76FXRn69zb8QcELNu0PX1H/ycN3furfX53SUKgkk0o4DgnoRCYy1pAsFDSkmRR3ElwGraX01jD7WVs0NkISi9qdQqSaWXQ31nESlvXAIrfEOut7DvFaxy/AQyzqSUyQtFxdNUuhdfXaOylyOmDWOC219fCqEWaM5Tg8/ekG4PwKUqQiioTUXozKUUlfHAkRemuzUrlW4SviIm8Ql1EWmCLd4UCa26HzEFmQAJN1h73drGnX7yQFpPUA0MZmRDjN9uvApJmd0Vc4IegXudTRKPHsSLlGPvBfP/kPpRjU86Ln9xVYHWbRMJwRergkN0/+oq+sn0CBNC7XyJaXBLw5BMICDxSHJ7t6U9rQZLJDWPHX+8z8EJnW3tZKh0Z34YW03Mb468AY2l3BsMuTIWeGMQ+oo8c0ROtHge6X0xL0tmPlCfAf93of7V+6hIP++O+bxrBY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(81166007)(86362001)(82740400003)(5660300002)(8676002)(356005)(82310400005)(316002)(44832011)(41300700001)(8936002)(6916009)(70206006)(70586007)(36860700001)(4326008)(54906003)(426003)(83380400001)(47076005)(336012)(2616005)(186003)(40460700003)(478600001)(16526019)(1076003)(26005)(36756003)(6666004)(2906002)(40480700001)(966005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 04:54:04.5450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb70c3c2-0e56-4adb-3152-08db6d5c8b64
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525
Received-SPF: softfail client-ip=40.107.92.48;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

This hopefully contains most of the information one would need to
generate/publish QEMU tarballs and make the related announcements. The
main goal is to quickly get others up to speed on the process so we can
have multiple people able to handle releases at any point in time.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 docs/devel/tarball-release-process.rst | 132 +++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100644 docs/devel/tarball-release-process.rst

diff --git a/docs/devel/tarball-release-process.rst b/docs/devel/tarball-release-process.rst
new file mode 100644
index 0000000000..5512dad5cf
--- /dev/null
+++ b/docs/devel/tarball-release-process.rst
@@ -0,0 +1,132 @@
+.. _tarball-release-process:
+
+QEMU source tarballs and the release management process
+=======================================================
+
+Overview
+--------
+
+Once an official release is tagged in the QEMU git tree by the current
+upstream maintainer (for major releases), or current stable maintainer
+(for stable releases), additional work is needed to generate/publish a
+source tarball for consumption by distros, vendors, and end-users who
+may not use git sources directly. A person involved in producing these
+tarballs is referred to herein as a "release maintainer" (not to be
+confused with the upstream/stable maintainers who are responsible for
+managing/tagging the git trees from which the tarballs are generated).
+
+This documents provides an overview of this release process and is
+mainly intended as a reference for current/prospective release maintainers
+and other individuals involved in the release management process, but it
+may also be useful to consumers of these source tarballs.
+
+Generating source tarballs
+--------------------------
+
+The following example describes the tarball creation process for a
+particular tagged commit in the QEMU source tree, in this case v8.0.0:
+
+  .. code::
+
+     # Check out the tagged commit
+     push ${qemu_git_dir}
+     git checkout v8.0.0
+     popd
+
+     # Generate the .bz2 tarball
+     mkdir ${qemu_build_dir}
+     cd ${qemu_build_dir}
+     ${qemu_git_dir}/configure
+     make qemu-8.0.0.tar.bz2
+
+     # Generate the .xz tarball
+     bzip2 -k -d qemu-8.0.0.tar.bz2
+     xz -9 -k qemu-8.0.0.tar
+
+     # Sign the resulting tarballs
+     gpg -b qemu-8.0.0.tar.bz2
+     gpg -b qemu-8.0.0.tar.xz
+
+Testing source tarballs
+-----------------------
+
+While releases tagged in the QEMU git tree will have undergone the full
+range of CI testing already, the scripts/process to generate the source
+tree contained in a tarball warrant some additional testing to guard
+against regressions being introduced at this stage in the process. At a
+minimum, an all-target build of QEMU using features commonly enabled by
+distros should be performed, e.g.:
+
+  .. code::
+
+     tar jxvf qemu-8.0.0.tar.bz2
+     mkdir qemu-8.0.0-build
+     cd qemu-8.0.0-build
+     ../qemu-8.0.0/configure --extra-cflags=-Wall \
+        --enable-gtk --enable-numa --enable-linux-aio --enable-usb-redir \
+        --enable-virtfs --enable-libusb
+     make
+     make check
+
+Publishing source tarballs
+--------------------------
+
+The publishing process generally involves the following steps:
+
+1) Upload the tarballs and their corresponding signatures to qemu.org's
+   file host. This process may change occasionally due to qemu.org's
+   changing bandwidth/infrastructure needs, so check with the QEMU team on
+   setting up access and getting details on the specific upload process. One
+   fairly constant requirement however is to upload all the required
+   components to the appropriate location, e.g.:
+
+  .. code::
+
+     qemu-8.0.0.tar.bz2
+     qemu-8.0.0.tar.bz2.sig
+     qemu-8.0.0.tar.xz
+     qemu-8.0.0.tar.xz.sig
+
+2) Update the links on the qemu.org download page. This is currently
+   handled automatically when pushing updates to the git repo used to
+   manage the content on qemu.org. An example of the commit
+   corresponding to publishing the QEMU 8.0.0 release can be seen here:
+
+   https://gitlab.com/qemu-project/qemu-web/-/commit/8a2082e67c1b39d41bd526bfa0435de34199d6d9
+
+   Prior to a final release there are usually a number of release
+   candidates tarballs which are also published on qemu.org. An example for
+   QEMU 8.0.0-rc4 can be seen here:
+
+   https://gitlab.com/qemu-project/qemu-web/-/commit/c976cbe248ca76eae9e938f718372a2dba1a21af
+
+3) Send an announcement to the QEMU mailing list. The format may differ
+   slightly for major releases, RCs, and stable stable releases. It may
+   also change a bit based on the preferences of the current release
+   maintainer or other factors.
+
+   For reference, an example announcement for the QEMU 8.0.0 major release
+   can be found here:
+
+   https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg02755.html
+
+   An example announcement for the QEMU 8.0.0-rc4 major release candidate
+   can be found here:
+
+   https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg02026.html
+
+   An example announcement for the QEMU 8.0.2 stable release can be found
+   here:
+
+   https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00221.html
+
+4) For major releases, add an accompanying blog entry to the git repo used
+   to manage qemu.org. It should generally follow the format of the
+   above-mentioned announcement sent to the QEMU mailing list. Generally
+   this is only done for final releases, and not for RCs, e.g.:
+
+   https://gitlab.com/qemu-project/qemu-web/-/commit/a5cb9e1a81e46b7e431ec3a0c130d0b4bf93d39a
+
+   For stable releases there generally isn't an associated blog entry, but
+   providing one may be worthwhile in some cases for bringing additional
+   attention to releases that address critical functional/security issues.
-- 
2.25.1


