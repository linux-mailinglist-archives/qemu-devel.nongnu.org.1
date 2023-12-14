Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E4E812A97
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 09:45:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDhKX-00020g-74; Thu, 14 Dec 2023 03:44:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rDhKV-00020H-8c
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 03:44:27 -0500
Received: from mail-dm6nam10on20604.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::604]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1rDhKS-0000HW-Bh
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 03:44:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHhmB/G4W+GfJ7LWtZDysA1fDfeUAuTHL+ZSaQ1da2izQIHWZ/hM8yKxjbSv/BlcR9RTZtWG93QvBFGKkATMC7nFJ53RS7MebF/N4227Kxdu43nkKYaIWcVpGiWUjOnqZ529NYOQ/OLErUrx7h5fSH/wea6ChIkQAVhog7mpopxxaHkNYj+w1Zl0fcRu+s/EckDvg9iLYspQaOklqwILs00Pg20fHrQwpiPiguZzzxv83rcqHXQGn0guOIbQ0Bx/dYO3flV8EqP2dwmRBPCKNdzd9JXaHBdo7p9SYTXIMjVQdXeuRJ1idg5YJvuCMtKJuRXZ3lygrZH5tfFN/nBVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jmlnahQ3isr9pgh+IND68GVBsqZO7v6Gpv0emgHxR4E=;
 b=Y95EH7V4S3dJFmN7HfHCRaGQAhktOgOx9korOkJTvu+x/qAWJeagqxKiTBN2lZk4gfoNOuJJpSaZWZKW9UhvCP9kh34sa37//CqsoQxI5DGa8Yu1nNW9urAGPFRr0IRGeUTdJzs65n4QV254VNFmjnFfyk/Uz/GlVlgK2xsqJ/mu7F4vnnlgrbow/f/jgRJMzJ1O7GwkaKgOJdNyTaCiqSC7GVr1NTk2F0cQEtExJYLAxwRS98mBaHRPMaKynCxdoinREzPjuPFoTTtx9/pbwUUI5ofD8hO5EV14I0MzvK7akfC6CnmX+x1lszYhToONFXGggnwmZVESgFpZ8Bq7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linaro.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jmlnahQ3isr9pgh+IND68GVBsqZO7v6Gpv0emgHxR4E=;
 b=NrIRkDoFSQpsr9aRr6ec2vkCN80/mKQduwLR+6D3pPkyy22h3NAkLSgitRUGCjhP66TJzIxOaFwoS/bE3hqUjFyYPstr2UuRzVJh9L7ZV5JkGPrjzC3XGRquxBo7vsdb2uwUYMAFJ7sgS8GEjr4R5MP/2KRv4Yb6bPgJRgqD9DQ=
Received: from DM6PR13CA0049.namprd13.prod.outlook.com (2603:10b6:5:134::26)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 08:44:17 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:134:cafe::a7) by DM6PR13CA0049.outlook.office365.com
 (2603:10b6:5:134::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.8 via Frontend
 Transport; Thu, 14 Dec 2023 08:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 08:44:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 02:44:16 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 02:44:15 -0600
Received: from luc-work-vm (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 14 Dec 2023 02:44:15 -0600
Date: Thu, 14 Dec 2023 09:44:08 +0100
From: Luc Michel <luc.michel@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-devel@nongnu.org>, David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH for-9.0] docs/devel/docs: Document .hx file syntax
Message-ID: <ZXrAWJ0R5WLnaFKc@luc-work-vm>
References: <20231212162313.1742462-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231212162313.1742462-1-peter.maydell@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: f4bdc41d-13a4-4dc4-ee60-08dbfc80db40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2zjO5iXmPMqcWZ27849fDJtB+9C7Jsmh1Zn+CGK3t/SZYowRS0u4NRZ0BOCjBrF42bs6GY+aEwObz3lNp68/t8tlqX4kw9TchqNb083EMpeXH/BnC/X+MEnUPHoJlnm5jP/qDyUcEm4t/in/1dHoetbddbmBY2d8CvgDI2PfDdrf6N91YZE2y477NqFV3qpkKNJzCaSbQk3l/OZkKSj01sIouDnxoVGdmPet58R7YtJeZjWWBoJvJNfap9Kbho/RN1rEFJg+a57xAgHkqVvCtCL25ZC7ElinLuL8df8RiZjq8Zvo1VckiQILgRtFdQ5hFSrt3K77M7Rf1XV+/ixD//5KQVIfEeXqxG3NwhXOHgIA2nkPmwfjDNLzwxB48ImPv0fjsUZR7F9Q+kCTKAc7kBuU5v7WfZu/mjEP1bbFCCR3YI8Df0M9KMEMexxA6jmHhS0vS0adnEdKey+ciStow+hTL0/1FCGRa2PUoTHNvveaCXDjhvNnUxYN8YhTJdF0kFGyyosTAABJO5/4XqICn3Q7iOUxFGlwDzsYlbvNIanSS/XjEJMvjdvzDd8HbXsDAnG9voLpOs7QgEeuBSbyXQg5i/GI5Hn2139v7yf+YBjcrKZMcwJu/XPOYInZXN5Rs7JQ+3OVUw1fZcNMElTn8LjxICeA5lmXUFiYNpqkQyzmUIpGar4mvN0Hz83xK/3j/Pw2j3RKHSjONDFGGxK9XyQSxjlEmwQpbJssQXvQvTE3z90QFgBNKT/BYLnJ9Ub+gUc3gMEKzVxYn/gTMevvSq0Ah2qx9CqJPpzvTPT5Gw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(41300700001)(83380400001)(336012)(426003)(36860700001)(47076005)(33716001)(5660300002)(40480700001)(44832011)(55016003)(478600001)(9686003)(82740400003)(356005)(6666004)(2906002)(6916009)(54906003)(316002)(70586007)(4326008)(8676002)(8936002)(70206006)(81166007)(40460700003)(86362001)(26005)(142923001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:44:16.6598 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4bdc41d-13a4-4dc4-ee60-08dbfc80db40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
Received-SPF: softfail client-ip=2a01:111:f400:7e88::604;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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

On 16:23 Tue 12 Dec     , Peter Maydell wrote:
> We don't currently document the syntax of .hx files anywhere
> except in a few comments at the top of individual .hx files.
> We don't even have somewhere in the developer docs where we
> could do this.
> 
> Add a new files docs/devel/docs.rst which can be a place to
> document how our docs build process works. For the moment,
> put in only a brief introductory paragraph and the documentation
> of the .hx files. We could later add to this file by for
> example describing how the QAPI-schema-to-docs process works,
> or anything else that developers might need to know about
> how to add documentation.
> 
> Make the .hx files refer to this doc file, and clean
> up their header comments to be more accurate for the
> usage in each file and less cut-n-pasted.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@amd.com>

> ---
> My motivation here is that we're about to add support for
> extending the SRST directive to specify a label so we
> can hyperlink to a documentation fragment; this gives us
> somewhere we can document the syntax for that.
> ---
>  MAINTAINERS                |  1 +
>  docs/devel/docs.rst        | 60 ++++++++++++++++++++++++++++++++++++++
>  docs/devel/index-build.rst |  1 +
>  hmp-commands-info.hx       | 10 +++----
>  hmp-commands.hx            | 10 +++----
>  qemu-img-cmds.hx           |  2 ++
>  qemu-options.hx            |  2 ++
>  7 files changed, 76 insertions(+), 10 deletions(-)
>  create mode 100644 docs/devel/docs.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 695e0bd34fb..49b8ca9d1a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4149,6 +4149,7 @@ F: docs/conf.py
>  F: docs/*/conf.py
>  F: docs/sphinx/
>  F: docs/_templates/
> +F: docs/devel/docs.rst
> 
>  Miscellaneous
>  -------------
> diff --git a/docs/devel/docs.rst b/docs/devel/docs.rst
> new file mode 100644
> index 00000000000..7da067905b8
> --- /dev/null
> +++ b/docs/devel/docs.rst
> @@ -0,0 +1,60 @@
> +
> +==================
> +QEMU Documentation
> +==================
> +
> +QEMU's documentation is written in reStructuredText format and
> +built using the Sphinx documentation generator. We generate both
> +the HTML manual and the manpages from the some documentation sources.
> +
> +hxtool and .hx files
> +--------------------
> +
> +The documentation for QEMU command line options and Human Monitor Protocol
> +(HMP) commands is written in files with the ``.hx`` suffix. These
> +are processed in two ways:
> +
> + * ``scripts/hxtool`` creates C header files from them, which are included
> +   in QEMU to do things like handle the ``--help`` option output
> + * a Sphinx extension in ``docs/sphinx/hxtool.py`` generates rST output
> +   to be included in the HTML or manpage documentation
> +
> +The syntax of these ``.hx`` files is simple. It is broadly an
> +alternation of C code put into the C output and rST format text
> +put into the documention. A few special directives are recognised;
> +these are all-caps and must be at the beginning of the line.
> +
> +``HXCOMM`` is the comment marker. The line, including any arbitrary
> +text after the marker, is discarded and appears neither in the C output
> +nor the documentation output.
> +
> +``SRST`` starts a reStructuredText section. Following lines
> +are put into the documentation verbatim, and discarded from the C output.
> +
> +``ERST`` ends the documentation section started with ``SRST``,
> +and switches back to a C code section.
> +
> +``DEFHEADING()`` defines a heading that should appear in both the
> +``--help`` output and in the documentation. This directive should
> +be in the C code block. If there is a string inside the brackets,
> +this is the heading to use. If this string is empty, it produces
> +a blank line in the ``--help`` output and is ignored for the rST
> +output.
> +
> +``ARCHHEADING()`` is a variant of ``DEFHEADING()`` which produces
> +the heading only if the specified guest architecture was compiled
> +into QEMU. This should be avoided in new documentation.
> +
> +Within C code sections, you should check the comments at the top
> +of the file to see what the expected usage is, because this
> +varies between files. For instance in ``qemu-options.hx`` we use
> +the ``DEF()`` macro to define each option and specify its ``--help``
> +text, but in ``hmp-commands.hx`` the C code sections are elements
> +of an array of structs of type ``HMPCommand`` which define the
> +name, behaviour and help text for each monitor command.
> +
> +In the file ``qemu-options.hx``, do not try to define a
> +reStructuredText label within a documentation section. This file
> +is included into two separate Sphinx documents, and some
> +versions of Sphinx will complain about the duplicate label
> +that results.
> diff --git a/docs/devel/index-build.rst b/docs/devel/index-build.rst
> index 57e8d39d985..90b406ca0ed 100644
> --- a/docs/devel/index-build.rst
> +++ b/docs/devel/index-build.rst
> @@ -10,6 +10,7 @@ the basics if you are adding new files and targets to the build.
> 
>     build-system
>     kconfig
> +   docs
>     testing
>     acpi-bits
>     qtest
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index f5b37eb74ab..da120f82a32 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -1,8 +1,8 @@
> -HXCOMM Use DEFHEADING() to define headings in both help text and rST.
> -HXCOMM Text between SRST and ERST is copied to the rST version and
> -HXCOMM discarded from C version.
> -HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
> -HXCOMM monitor info commands
> +HXCOMM See docs/devel/docs.rst for the format of this file.
> +HXCOMM
> +HXCOMM This file defines the contents of an array of HMPCommand structs
> +HXCOMM which specify the name, behaviour and help text for HMP commands.
> +HXCOMM Text between SRST and ERST is rST format documentation.
>  HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
>  HXCOMM
>  HXCOMM In this file, generally SRST fragments should have two extra
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 765349ed149..2db5701d49c 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1,8 +1,8 @@
> -HXCOMM Use DEFHEADING() to define headings in both help text and rST.
> -HXCOMM Text between SRST and ERST is copied to the rST version and
> -HXCOMM discarded from C version.
> -HXCOMM DEF(command, args, callback, arg_string, help) is used to construct
> -HXCOMM monitor commands
> +HXCOMM See docs/devel/docs.rst for the format of this file.
> +HXCOMM
> +HXCOMM This file defines the contents of an array of HMPCommand structs
> +HXCOMM which specify the name, behaviour and help text for HMP commands.
> +HXCOMM Text between SRST and ERST is rST format documentation.
>  HXCOMM HXCOMM can be used for comments, discarded from both rST and C.
> 
> 
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 068692d13eb..c9dd70a8920 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -1,3 +1,5 @@
> +HXCOMM See docs/devel/docs.rst for the format of this file.
> +HXCOMM
>  HXCOMM Keep the list of subcommands sorted by name.
>  HXCOMM Use DEFHEADING() to define headings in both help text and rST
>  HXCOMM Text between SRST and ERST are copied to rST version and
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 42fd09e4de9..d3e31e65c25 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -1,3 +1,5 @@
> +HXCOMM See docs/devel/docs.rst for the format of this file.
> +HXCOMM
>  HXCOMM Use DEFHEADING() to define headings in both help text and rST.
>  HXCOMM Text between SRST and ERST is copied to the rST version and
>  HXCOMM discarded from C version.
> --
> 2.34.1
> 
> 

-- 

