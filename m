Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968481A450
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 17:19:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFzGk-0007Li-JP; Wed, 20 Dec 2023 11:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rFzGh-0007LO-41
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:17:59 -0500
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com
 ([40.107.94.56] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1rFzGe-0001Td-JC
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 11:17:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgUEa+/rTnsh2ym4nDsvLC+4x//MLl9JQbV1lpLIE9a5+TQMYoBZT7inNv+RhsRbaHINsCUMOXiq6FLCqrGpSjYlkHm5tFpcZr96/H1PmsfAi7dw/tlcWNusbKbSbLz/v1ojaUPFRDRrMyDNtydz3TiL/mxHwktankd3jS8imUCh2OFuxl2AEKVerTkXH2ntkSs0DzX/szI+TiV1yP7QjevNFsCpdH7GJS83ZC4vAzElvqlgff1SViSoK73PCl/fMD9768X9gTONVT1qyvG+vGF3pTIG6OYIz8Ana3IQJqUsOF2g1Kj6d+5+a2XiJyP49HC0cnrmnuLWTINNDtk4ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=co6BbDL2uFhmZrdBW8sxDuJJ5YSmEI39+rmjHztoIhs=;
 b=hhrTyl4Hbz+AXOR0z7gXsNolN+/910qM/rkaISCEr6V/2X29M7fXPKKoiBfivIvxOiTw725gf5TPabRhhCFcxqCRJ6HJHJRxj9fGKoaHrPwS/kcUiWHnFsPA2NqoVCVnn+2eyCXiQexDXZeUoCLvO9VEBWLifwI8jC42avoAkvAK82OjE6ZQ0EqTcJRbTMlDFGUWmrMKHQopgDXyeXZ7q3yQd74gUMgKZt28+gemJdHcR0ifLDMkGYtYfYcd4+OZwlIA4PHazBQxLig7LB3o0BitDXlKYyDfNA7f7bnQAGO+eJws66vCx3s201cb3MP/XwsjSkOlM7Zw31oFEK9hjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co6BbDL2uFhmZrdBW8sxDuJJ5YSmEI39+rmjHztoIhs=;
 b=emEUhibAVWg/JbqO2D14yguKlQAaIkmnDvkzZjZx6e/dWcZR92lE0hc+mteC7sdvvosQAR1I7bH66G4jIO6IyxqKls/QhjSjiDHtIFs1sJWeOra3v8iAOdoG1RFS/vPjaFgv4v/CANe49p1lay3uKWrClXRFqXZ7YEJAMcRUtSo=
Received: from SN7PR18CA0013.namprd18.prod.outlook.com (2603:10b6:806:f3::31)
 by DM6PR12MB4879.namprd12.prod.outlook.com (2603:10b6:5:1b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:12:49 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:f3:cafe::56) by SN7PR18CA0013.outlook.office365.com
 (2603:10b6:806:f3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:12:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:12:49 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:12:42 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231220160237.843113-1-stefanha@redhat.com>
References: <20231220160237.843113-1-stefanha@redhat.com>
Subject: Re: [qemu-web PATCH] Add QEMU 8.2.0 release announcement
From: Michael Roth <michael.roth@amd.com>
CC: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, <qemu-devel@nongnu.org>
Date: Wed, 20 Dec 2023 10:11:42 -0600
Message-ID: <170308870249.47564.2031507210923112269@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM6PR12MB4879:EE_
X-MS-Office365-Filtering-Correlation-Id: d6218a4b-8ecb-46c3-9e4d-08dc017682f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ipiaAAI/Dsa+25bjbEu8h6stWPBtvOPYpj/k6Nr45Rvg/RBX0uU5Ruw/NUrcuIKt/XPil4KSrkCu4rPJ4mn4HrNI89+Mt3ib1yPMBMdlj7LOEdN5fvxhEy5nL/jxx/t8WI289KWiIo7QJWuY7DdcvkWNVxk4HOYNgyjREI59i1seIZ4AkPitJVMiHcrBSVb7vXVgDsUteFyL5jItDCGlu4i/u+iP0IfTJlWFEw7ahDW8tUXeHeZL9E4oNaFCs0lGfIpz/jzCNKgt/h4mQNS/mz8XuFIa4Zjh9DLEk+ePQ+nU9fMoPVNFZr4+sXE65B5Psx9Wp49VeggsuZnCHLoxpm1i7xD9YwU+8zfJt8itvdYIWd7w65/UuOh0WbnEsBVk2ounreIjJURsy6YJeEr7GWsMBIb5h3VyQvX1DfV0kv9I2vjv1YvLaSVt7R/n2Gs/ZVE7xD0NfeTT1kSvfQX5jTqZB8r4eRLap3YlR5tZFaeO/y1LteJTxKwEPOkbYTeXp7L7JOye4l8KzrPNHkj9DOLcB/zRmftTyu36xG+7nnQu5lUWAhr1T1dhrrb/MWyoxi+xR9hcgDsc4i0JM5uK5+Hvi+wG6IbHym7eUyhpssPpUDLMVWik2d76zqPPsKgT9TijAFI2/eeTS/qOjnPbFUjiSMRhhdSmnShMHFmQFkkoEIz9qiHTeTpLjNAWgB1Y827WClaU13jkvapqhjOoMq7IZpcpCECsk5FOYwmdJ9TKEUetFjDiaY3nnfGN24AA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(4001150100001)(5660300002)(2906002)(40460700003)(41300700001)(36756003)(356005)(81166007)(110136005)(86362001)(82740400003)(426003)(26005)(2616005)(16526019)(478600001)(47076005)(336012)(36860700001)(83380400001)(44832011)(4326008)(8936002)(8676002)(54906003)(70206006)(316002)(70586007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:12:49.4333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6218a4b-8ecb-46c3-9e4d-08dc017682f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4879
Received-SPF: softfail client-ip=40.107.94.56;
 envelope-from=Michael.Roth@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Quoting Stefan Hajnoczi (2023-12-20 10:02:37)
> Cc: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  _posts/2023-12-20-qemu-8-2-0.md | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 _posts/2023-12-20-qemu-8-2-0.md
>=20
> diff --git a/_posts/2023-12-20-qemu-8-2-0.md b/_posts/2023-12-20-qemu-8-2=
-0.md
> new file mode 100644
> index 0000000..c7cdd8b
> --- /dev/null
> +++ b/_posts/2023-12-20-qemu-8-2-0.md
> @@ -0,0 +1,29 @@
> +---
> +layout: post
> +title:  "QEMU version 8.3.0 released"

8.2? :)

> +date:   2023-12-20 10:00:00 -0600
> +categories: [releases, 'qemu 8.2']
> +---
> +We'd like to announce the availability of the QEMU 8.2.0 release. This r=
elease contains 3200+ commits from 231 authors.
> +
> +You can grab the tarball from our [download page](https://www.qemu.org/d=
ownload/#source). The full list of changes are available [in the changelog]=
(https://wiki.qemu.org/ChangeLog/8.2).
> +
> +Highlights include:
> +
> + * Arm: New CPU types cortex-a710 and neoverse-n2
> + * RISC-V: KVM AIA Support, Virtual IRQs and IRQ filtering support, and =
vector cryptographic instruction set support
> + * 68k: The Macintosh Quadra 800 (q800) emulation now can boot MacOS 7.1=
-8.1, A/UX 3.0.1, NetBSD 9.3, and Linux
> + * HPPA: New HP C3700 machine emulation and 64-bit PA-RISC 2.0 CPU emula=
tion
> + * LoongArch: New CPU type la132 (LoongArch32)
> + * Tricore: New CPU type TC37x (ISA v1.6.2)
> + * New virtio-sound device emulation
> + * New virtio-gpu rutabaga device emulation used by Android emulator
> + * New hv-balloon for dynamic memory protocol device for Hyper-V guests
> + * New Universal Flash Storage device emulation
> + * New Xen PV console and network device emulation
> + * Network Block Device (NBD) 64-bit offsets for improved performance
> + * dump-guest-memory now supports the standard kdump format
> + * and lots more...
> +
> +Thank you to everybody who contributed to this release, whether that was=
 by writing code, reporting bugs, improving documentation, testing, or prov=
iding the project with CI resources. We couldn't do these without you!

Thanks for writing this up. I ran out of time yesterday and am working
on the announcement email now. I'll plan to merge your summary into the
email and then push the resulting highlights to qemu-web if that sounds
okay to you.

-Mike

> +
> --=20
> 2.43.0
>

