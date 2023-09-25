Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 635EA7AD9B0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:05:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmC3-0000ms-TL; Mon, 25 Sep 2023 10:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qkmBq-0000e9-5d; Mon, 25 Sep 2023 10:04:03 -0400
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::601]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qkmBk-0008K4-PS; Mon, 25 Sep 2023 10:03:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqX8hW4FJYOahg/g6s2yk7H9YXgHPQw6b0f5OQE4kqypyc/ncpO6O0QqfH1L3bfpWmRsGeTcgLyldh1wtPXVpGCIj+qmKh0ktSN/ezlOk7rVRsdpTw6DACheg31sAGyLPRnnaFrGkH8DlO1e/b9F8uRAWaDuVmYN7Lmp/9RNKfpcJbnVyt7XxS0DySdROzQwcguq7831P4iEDvY5dvd6/MEjsTy+/S1BaqkIRWGOH9CV6LQe2YEzAS3pLBjmJOxmm6B1XCRBPP3PyW9q/Q5OjxJVQKaTA2IL2qNcuQOOWH1MKM33hAH51gWXAp2LQHr71nP6LIFq6P9wm+QRFYPWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s38u0PH/46G9VkAuMXpMmP8ApDmkMSLLgWjATUrC/WU=;
 b=MIEuUpXw8ZSmdj2gzfrbhtd9RMqqvVZIIVh63Tbzm0g0AbnIzSglBATvE0MUXLjoZSk0uXd0dl+fJbSn5NmeES0lgvveFyov/KfoY/P8XqlPQBkAXlXIbBKno8JEIrqt60+gClB1qWAobyr9W/0oJgtyPL+VyoKIUZkYPVHUlZ9t4hK9+x1n9NZlw3A/78Fh/g5lJXBFHrRoKo71H2TgGysE/6LvuWPMPOLRoVYwnkPhYVxi5adF5lxHoMgpPb01NKK4g/RnsTzVyLtQa2HyhDfvbS9g91ueV+N9yNHeLZ+5CJ9NANYObcCJEkT2nuuLj5X4ARcyoHgI0hvBaj9S+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s38u0PH/46G9VkAuMXpMmP8ApDmkMSLLgWjATUrC/WU=;
 b=DO5hK5ZNs5MG6X+g97sCn/hnLsxhLmToXErf0W/2XqjcBnIXErPVQgx5vKyjEbWius/bDK63NSzk670S099EQhENf5ssI24ZOyXaZ5uhghChSqbCODtcgj1lOzi5IQSg6ZbD1xyUH58AD17rypPY1VN0dbS4r0671otC4j7z508sxHA8QbzIxWmCF61lGCRBFiYGbgjKWsdXbXeGYj9FP9RAjCnGw/9hPq0RI8pbAcMuyVQNivFc+AEUeKgcCQHF/JX0pUwZsbSsotC8EJc3RKePEf5FXhKivFfcmpLdqdbsCVQYJ9k03twRS+x14G3huTXzN78M0BDCqevAXPjmRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 14:03:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 14:03:29 +0000
Date: Mon, 25 Sep 2023 11:03:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ankit Agrawal <ankita@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 3/4] hw/arm/virt-acpi-build: patch guest SRAT for NUMA
 nodes
Message-ID: <20230925140328.GF13733@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230925145440.00005072@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925145440.00005072@Huawei.com>
X-ClientProxiedBy: BL0PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:207:3c::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: cce00c33-9fa8-4e20-9fa5-08dbbdd031e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXTGiBBxG8iC863u6FNNTV2bp2nSFTUOSWD+wJj7DnafMO6WRVeEzdAVgB96gktYkUviE/5HJ6XSdMwkpXMSI6Y11SMACNJnfepsjeHVXH1Y8A6XezkV+RMAjz1hER+ohy9e/Wwlle7BQEGcAcFrh1PHAXeTGvC9tZu8s1mSotC3XESCvECvqevHwWFgTSKicrNErDwf6v09vQJ5FNIG2ru1BJwtUILFOR1MFgtkmD1tT1HPBvERvp3y8D8jIIom2IKYMbUqUmEHfNe7mCmXnkRkc8l0JD3o8BWVTOKx/LvRNC9iAWlAWRvlg3CQ/vGiWCRSLNswiEURhG053qLa8aSfoFvaEb/5ELk56/s9rKT0BIye+LAj8O1Xk+bxu2Mn9sBbSVCfNfv4wApR5Bbj0zyIacSUO9OE1BD+L/xy07UFi0ad3zH9vMpH2dHtTJSfv4Fu6+p8Yf0iXbdp0oMApJOcQOWeaGKHfQRt8TGwTOfAhS1HPDYjSXjYelxgCINzkl3Ds+bWL8YDOLRcMAL+KLlRhmJ2psMV2iNepPpiK2TKMAGioBItRj4J9dLzopfZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799009)(186009)(451199024)(1076003)(2616005)(38100700002)(26005)(6506007)(6486002)(6512007)(478600001)(4326008)(5660300002)(6916009)(33656002)(36756003)(66946007)(8936002)(316002)(66476007)(66556008)(54906003)(8676002)(41300700001)(86362001)(4744005)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TPxUmkwuNj5vhWq/PjRZzMJr4XgWMhurJ5eMlt6Wxn9J6kxGa5vWwbxHrskC?=
 =?us-ascii?Q?Qm8H9YnPlp4NuZr/aLoXBMJi/pVP0cdnn7nmc/ksZSvt1Qk6+0WRK4qaHvhY?=
 =?us-ascii?Q?9m/6EWZn982GcpWAEtuopUV3Q/ffbzFTQ6BipmsZoEmMocSI6vImT6nfd/qn?=
 =?us-ascii?Q?nfN62U00X6eG0WAJhNJpPo86DRvWPVbQOgKXst8b0rHpp1QRvaMRoPAMlhNh?=
 =?us-ascii?Q?2dFVwtVc1QC4LtI2BDt59RBLszk/zGTfxjdydynXaI4AMaOQwPWY3CAapWM5?=
 =?us-ascii?Q?ZGO6rRbP6003KNvefZvGNNcWpx8HxGDkLsqu8POQVDZjo7lGXjvylMhQ8YjI?=
 =?us-ascii?Q?uS4ouTYPdKFs9latMBlayxIf+UT0RawUpu3N8t6PEoLGX8sAhCoh7rJO2+aX?=
 =?us-ascii?Q?GilQy+S9mvfp0NjShdMWdLkrq1JrAeaAgE2Q27SGrvW+e9QAiz8T2IR1HhSR?=
 =?us-ascii?Q?1YfNZ0oPN1ItqQHWXQGvJ2KzFyHdBilEi570LcGasRIJQ0Mm0YAF6PDcF64E?=
 =?us-ascii?Q?4FI0ircP9lvjlnQIISY3yFzwNP1+BysveHF2Hji1fiTgbLlT8xI04suNLRIo?=
 =?us-ascii?Q?M2LE/GXzNqYOlvQ2gCFMMDTioJeQbmnmOvm+jXRm4Y7o0FMspOQAQ3cW+Of2?=
 =?us-ascii?Q?VCuK3gwcCjsN153ZAAHNmMDzLRk+fVZOrL8Nw+N6nqWghXniGaPlLiEoxjjH?=
 =?us-ascii?Q?UstwTneAE975EXMcxs3uZSfS0ECZjE/z6HRbiJ8ysc2MRuqxbyiZ2stN2n1m?=
 =?us-ascii?Q?52/nqtJ+vuLEgZVkD/jmBPNqakJuswLI/wiI3R3HsobMVXAa3uzu1PvIxlvV?=
 =?us-ascii?Q?RCqpP8QXG4cWqRdtRpKOxGZ/3+Ny8FooqjAtNm8FKDDd3eM2Mble2WLM66cG?=
 =?us-ascii?Q?DARot99Jpd/eyx9lvVa9cmlIZDVs11AUCY2Bem1eKoPillQrsoCDwUl1Pufu?=
 =?us-ascii?Q?BTZ63aZd6QOSNu9PRw8uS4hthVJU2xSPVFJmieEqgmaelYptBF7XQX+lqTM5?=
 =?us-ascii?Q?3i27F1pB6sAK/4npwn/GQ/Z5wsEENwNMStv6DFBSd8P1Kb7dBHd3Jz8PEPw7?=
 =?us-ascii?Q?MvfWHRAjoifr/3eShXqwgm3mXtSi+ThxjYh/4xeHHgVXngeh7yUJNfqqcuGW?=
 =?us-ascii?Q?3eS2i5Sb3k+oJ6DKaDbo4CH8rT9Js09sU11S1WM1/wqk5hOsHcUjYnb9OPWU?=
 =?us-ascii?Q?3lgsZaeQHr4iv1knAn2n0raORIJVsMXPFsBF/NZ2QLXnDsyZN8yLi2bcleAZ?=
 =?us-ascii?Q?TvTdAXO/vebOjMIWNGJbOSEmp6EFsfBFUgSC4Rdcuh9K9W9Tty64CI8bqaZ4?=
 =?us-ascii?Q?Z0pNcDwOsbMi3pizNRD0dZ0uL98Ugqjd39NUA5cRRy9C/WwSFE0+l9T002cy?=
 =?us-ascii?Q?d6MXOPGN0eivolB1u1UEFb7rWRQTe/Frqwg69N4akTpfpDEgBaZxJvqdSSFO?=
 =?us-ascii?Q?tWm4RtwS8g0WtXobWg4NOTmYpXgVChN6yVN4BFwWZ6BgRNJBqOjEVW+7JqLb?=
 =?us-ascii?Q?Q2RfZmZVv16lu0gztHmbfPhicvUN9CzoyALq0kxD0j9UwD8EKCBkMPVh2GKp?=
 =?us-ascii?Q?SdHMySlQpU/79NDREGSXrxH5LUrH7W76bRTyo8rs?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce00c33-9fa8-4e20-9fa5-08dbbdd031e6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:03:29.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHWFDBCcmxCzkHlrYIbLG5l7xwWp5D62EzG8QlRgLFcM1FjoOmIb4JmI7W6fA6Yg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::601;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Mon, Sep 25, 2023 at 02:54:40PM +0100, Jonathan Cameron wrote:

> Possible the ASWG folk would say this is fine and I'm reading too much into
> the spec, but I'd definitely suggest asking them via the appropriate path,
> or throwing in a code first proposal for a comment on this special case and
> see what response you get - my guess is it will be 'fix Linux' :(

The goal here is for qemu to emulate what the bare metal environment
is doing.

There may be a legitimate question if what the bare metal FW has done
is legitimate (though let's face it, there are lots of creative ACPI
things around), but I don't quite see how this is a qemu question?

Unless you are taking the position that qemu should not emulate this
HW?

Jason

