Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B65C7ADC95
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qko19-0000xO-1m; Mon, 25 Sep 2023 12:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qko10-0000sU-7a; Mon, 25 Sep 2023 12:00:54 -0400
Received: from mail-dm6nam11on20622.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::622]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qko0x-0006Pk-Qm; Mon, 25 Sep 2023 12:00:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+nAshmRwI8WZlFhvfQ4yFinDkmEF+K6ZNtuJu6HvnAd3abkfKbtDvScr3Mx4Cq4E408ehuw33uDGDBSC58rRB56gbJ64LvFc+quKakDza6ztXn6Mvf6aKYzVbegwpVvdHZaD7gsf5Af8O1Dug3ObjDT7OuiiTunyiG4Wrq1xlvCHhm3I3whBov90POMlh4PMPtCu5RO154DEMfuynLPJx4oTQiJQ0tGI5yBcmHaISX+cNJL9eKk4PKop9zGw9X9ZHHTjJuc3IPGvfbEEOz973lWK7WsnEKw2HQUxnJsCNZ8S0vSkcjE77PVblJIi0CgcWHGtkWvUbPy5BeB+8Ko+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVACCClV87x/e71nePMbDOz5hjbOp9R2MJn1X+mwhqo=;
 b=FUCwg7axoRQIUMhtzLiD9OX7RgfOgbPpbKR4wZweZwcLAEsaa+aV3MWabth5pEIJz7kSpaSC5f50xED6v7dbmO9DSalORFnHWC6Dsr8RK353+j3KQ2MsyxN9XNqih04iI/K4yvMeYLdimolbYpgd2os9PE/tRPPsduPbvVuMbmX4IhSqPABLOdmB/cIBTNM4dEn2Aot1YncUHrJMs6W2o6WKGY+rMzbFwcQPO80pBEeCGCaN230ptKLo4RwezBUnti5ggDhU/U6fJNvu/5cBRT2bH2K7a0CwmC6m4Mcn+/BI79iC4Yh5eKH874FDX3QiQagVazSfXiU2pKIpkTnb4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVACCClV87x/e71nePMbDOz5hjbOp9R2MJn1X+mwhqo=;
 b=rH1vZ2tpehZQb66eZXpvKftv9c677KLEgktaTqa5suIbeCXpt3CfOxggC+3ijWFeGDH1UidRFfyZOnhVORGcQnQ/Um+tmQL5HXZKSb6x8S1JKWLWoF3yo1ZtV5btB2sPXo9PFsHxk8/yP9UI2DdkAwNPKEDQUvR63uw6A68ZFFreBWfoIvHxJPTvBRkt0OIZFn/QqR0Uo3KIkJjsoa7gujRhz6MW5YbiUlkQK7gRqcWjhwFL765xCeW9Prp5+mL7j/mG6RN/6R0a8MHSNkWKhtG5ntvWkNhkKFCm8iGGYeC0wza3oC2mmGMOP2DqL4kQY1mrKrtNuk3ixFxIJh0UQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6243.namprd12.prod.outlook.com (2603:10b6:a03:456::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 25 Sep
 2023 16:00:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 16:00:45 +0000
Date: Mon, 25 Sep 2023 13:00:43 -0300
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
Message-ID: <20230925160043.GH13733@nvidia.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <20230915024559.6565-4-ankita@nvidia.com>
 <20230915153740.00006185@Huawei.com>
 <BY5PR12MB3763BC1EB9402223B020ABF8B0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230925145440.00005072@Huawei.com>
 <20230925140328.GF13733@nvidia.com>
 <20230925155351.00000638@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925155351.00000638@Huawei.com>
X-ClientProxiedBy: MN2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:208:23c::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 17c5fe3e-f6fd-4422-06b7-08dbbde093ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UueqVtGV5l/lQot3bPV4iCllaNd4QwYzBhr5sTEXGlhHZklEYIpWmiMtd7nWKk9Kr98ucbxjvUwTNX/tVvWaM27gynkAjPTDtYr17LRkgk33mc0A6HvoTbr20wJ5CGDJstJQ956vKsKeVxFRS68DUtbBAAKuNp+8+EJSt19JXo7A5at3k7ejqNOzSgziJVDRCOLBHJxuUT4Vt6fzR7a3PDas3BrKgmEljsIZo1d8qnbnqry5H/QxM2qaawSyrNQjVK49cynCxLYy6oU20Jf3v6uQMlaB2aKfuRqpYMXo3EIk7Z2aQsiXSrGZ6pLjTk7zTahvY5G0bG2jGSOxgQS4j8gTLP5Mci7MotkssMIG1I7mVJLgbYIHAWZyGZi+i3sjdBki20VGJZ20SJe4zTm4zl6iurCEttfdvzOsUIiTiOLDJJddJqYiuGdMf4DfK96+6LVDKy1c6TIIdehqffEigEF53wH5JS/Lt/LEgGcnqlNQ2fpArVvYOoTA/wql1AUmj8aW0i+QlXY957U80e0LB07zrvKTOt0Pq28TnL/51EJBzOqBz1BlHyH192kXsJCe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(36756003)(38100700002)(66899024)(33656002)(86362001)(66476007)(2906002)(478600001)(66946007)(54906003)(66556008)(4326008)(6512007)(6916009)(6486002)(6506007)(8936002)(5660300002)(41300700001)(316002)(8676002)(1076003)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?apsP8r9be8F7m/jc/24bDXoNeMifPlBIqcwAYNJNT4L2K9g8PezunNSFZve3?=
 =?us-ascii?Q?hVEUHs/U7UDAIrWYgMUcH4THX8Ux/NFjeVctaGJCAlUdp90u0SjWo4WtviJI?=
 =?us-ascii?Q?+IPf3b8TNbbrqE6qZvFBVew0dVZyz3Y7EkFOaOb0C44UKLf5GeMxQ8084AoR?=
 =?us-ascii?Q?n6MypHDqCuGh2zR13Ila3q45Mdpb+Pk14/Es2X0CJMR8xS6NEA9G51E64KsQ?=
 =?us-ascii?Q?JaiRcCR3BpIhy2SxoeuouRMA4hLf/n1b119slpDCr1IhK5HgQZTs/86dXi/S?=
 =?us-ascii?Q?D319G/YMfytBC1KYa5tiAXbMOiWEKVlor+o8Q+E4hQ7Hw3iEc3Hs/fY0TO0b?=
 =?us-ascii?Q?WVR+jummplEYYUfZ+YIf9rB21Cr666ZLZw0A0fjCHM9qe47VCb9Tl9fLlle4?=
 =?us-ascii?Q?/WZnynL3r/biMwPph1EhXY0kJxTQEv5KwJjEEcy5ChqCaWVWjKbG8vENQpLl?=
 =?us-ascii?Q?xyyQ/kt+qreDDj6jXbRD0B8UhBp9dGEGB91ZAZGWOeVtF+ruG78yULXlM9iT?=
 =?us-ascii?Q?GXeoFa86mi5g0fRF8YHvdaQVe6ByHyMgbXDoonSxNPgSOXlLAhJ/fMBI5PP0?=
 =?us-ascii?Q?QNRQtQ4/KTQ+ZqWnf1cAu+hkPClddQ7lc/dYjBP4YWPIAZDBb0pyTX/LxdJJ?=
 =?us-ascii?Q?mqabJFgjIIa+6VMj9QtGez5VLZPv2FrCl2JkWz+74YnNN35y3rY9ScJBsYz5?=
 =?us-ascii?Q?duI75V0ooc9fMosxknsO60Gq11BPXjggyhWGGUyPwVY5c1e2FnA88JoK4p7f?=
 =?us-ascii?Q?1+ApP6DGLXRQJ5tMRTjyajrywIZuyr7MD7gn5ZZxI+Vc4dByUvf8txkFvv0o?=
 =?us-ascii?Q?0BwO8w9yesym8UJRt9xVWgtX7xXKA6vwfL+ZR1iAsYeFMzeTtvveGFXd1WpC?=
 =?us-ascii?Q?8dlLIX1VkFf0dqFDwag4zGfXm/OUyGqkPjCCyqkbFNxesbJKH2AVYfVAAqpN?=
 =?us-ascii?Q?lF52m1yPCf98YJsXFw9F9JwifM/jiL3K8OYG3YORLFr0JfuX63+us6mjpRHD?=
 =?us-ascii?Q?kjlPxYNfqlTL+Nsi1RcGZVfDJs3UgLK6E1DuBLjawRCBz7MCRRVwJTgyAyTE?=
 =?us-ascii?Q?43yOH4kgm/nuFAdYG7fgMPjXDogZqSsMuyHSCj4zL6mc7KpPBpzRTJVRp4RT?=
 =?us-ascii?Q?hQu7WANJDaBoKXSVvFVAP2VnK6e83mQ0wJbgbMXbF8bAqF6/bFXI00O+kcLL?=
 =?us-ascii?Q?e+FO14jVk8Hpu6S921vxxvLS26INNPjFyOKwMSy5CdlrVB24P8tZ6u+n0Wo5?=
 =?us-ascii?Q?2EWf8iYqrr+RcH9evX/lO/Mc68Q24kNhc/1pd1J/5V3AB+Zs4JIoc/c3cwXj?=
 =?us-ascii?Q?VGjKHadZllIcR/eHcYOhvv2MBkT+LrBNKebTtoXfZcDqN+hVd09q3cLCnE8O?=
 =?us-ascii?Q?dS7a23eqC6Wfv+pcYiUh1Or/YP9wr6wFKB87TjNHnVbOD2cibgd6t2VZVqwT?=
 =?us-ascii?Q?MBrQ+pbmnyyFYIGjBLLN8QlqyiDB7CAJj1iorISxtU/WMWRL/YthioHKsPXV?=
 =?us-ascii?Q?vkq+8NHNvQsn6UewIteIemK1llIub61ijZd80IvzhlNMoX0i/3IO3ufMT//4?=
 =?us-ascii?Q?YMaeh5YwWF7N7CUj3/fbmUWLvR2uegBy6JVG543+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17c5fe3e-f6fd-4422-06b7-08dbbde093ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 16:00:45.2701 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8mjezpL6rK7cK7TAlqk2duyYl3k6pE4SpyZjic25+67sqSCbz0kkfsDvBQnloUU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6243
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::622;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Mon, Sep 25, 2023 at 03:53:51PM +0100, Jonathan Cameron wrote:
> On Mon, 25 Sep 2023 11:03:28 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Mon, Sep 25, 2023 at 02:54:40PM +0100, Jonathan Cameron wrote:
> > 
> > > Possible the ASWG folk would say this is fine and I'm reading too much into
> > > the spec, but I'd definitely suggest asking them via the appropriate path,
> > > or throwing in a code first proposal for a comment on this special case and
> > > see what response you get - my guess is it will be 'fix Linux' :(  
> > 
> > The goal here is for qemu to emulate what the bare metal environment
> > is doing.
> > 
> > There may be a legitimate question if what the bare metal FW has done
> > is legitimate (though let's face it, there are lots of creative ACPI
> > things around), but I don't quite see how this is a qemu question?
> > 
> > Unless you are taking the position that qemu should not emulate this
> > HW?
> 
> Ok. I'd failed to register that the bare metal code was doing this though
> with hindsight I guess that is obvious. Though without more info or
> a bare metal example being given its also possible the BIOS was doing
> enumeration etc (like CXL does for all < 2.0 devices) and hence was
> building SRAT with the necessary memory ranges in place - even if the
> driver then does the hot add dance later.

Ankit, maybe you can share some relavent ACPI dumps from the physical
hardware and explain how this compares?

> That's dubious and likely to break at some point unless the spec
> comprehends this use case, but meh, so are lots of other things and
> the hardware vendor gets to pick up the pieces and deal with grumpy
> customers.

Yes.

> I don't currently see this as a safe solution for the proposed other
> use cases however that are virtualization only.

So, how should that translate into a command line experiance? Sounds
like the broad concept is general but this actual specific HW is not?

Thanks,
Jason

