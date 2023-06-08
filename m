Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D872827B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:18:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GRi-0004lN-H0; Thu, 08 Jun 2023 10:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q7GRI-0004fk-19
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:16:37 -0400
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com
 ([40.107.93.72] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q7GR7-0001iG-0q
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:16:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibWKVeGXz3qX24E3pfBM9IOSyozXLt0ARNs1Zutw8dfTcFBi8WMBOLpzp+XUjgUj4AzR9LndVIqNVUhMoejyXpcAWsvFWLS0OU3xcUBx6ZCAKMB1Qd6MRYlNgu5ZhW5l4L4I8wi0YSTTpSneVjEK6gB2G1fb00UfckoW1kRVKSb5mWSlq39xa9WmurJrntNwuEP8HYgqVRWWCNI0Hy4fKYExiNI7oqPHyrvwwADFu2ZNqvKL2JUdrE8D+GnAWP6xknfJa2y5PaJKHArrK6S7+cwiCYELk9v/jOeiCHXug2WTVVeCQUWMHSxpTeWiplj+1j3S93EkxWXdMr9AUTmgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twARVS06t7ppdU0YhIQr5pd8KFhm/LhlDTjAMeNIBXM=;
 b=oNPBzU5RKQOe8Yxiqygs/MPA7DVn2kwcTt+dHGu3qIdQhJhNLUjPjUx1XKgIpOP6jN0RrYFpLfBS4+F6PcK5Y/ad0ESyph8uKFOj6IG0X+1I5wn5FBXqYXzvijkXNjOqTUvmZ1F+ItSNDe8hXzzLKh0rphT8l7tFIl0IL7EJ2HALdUZXAnEZ7rzZRq+DaMaxbC1QLZYwyiYAsh6r/iYP/y+MTm20PX0Jv9x+d8qt7WNMNUSss/7eCOj2M4SgzSZECmzteuBhRzla36Tcp/JxYWIdRXIfGUj697m5EL2RImeMCK3GerotDAdzmj8dd30MzfQtnaX6ADGe6dOHxVWy+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twARVS06t7ppdU0YhIQr5pd8KFhm/LhlDTjAMeNIBXM=;
 b=islcgBX3KJ7SlvXo8L9cnxQadra2SBYgUq5ZxYqIfnAlhy1LBQfRZHNZCAC4tfSCK7o/s9fDpRaaVc3tXJpAN+WgNCLrqRAdHKfyXcaP9AOc1jJypxeKifikxxzSNRYcZNSMA3OtG6/GvBwlT95WJaGEUKUDUEvk81RSaZT8Lu3qHSY/PPWKwC9kQL3RwCyqofomXnnWxbCUI2uzwToEqWZWRhk+kv8KZ5TwOTcz2KrQUUBm6ZENOk4VYc4Lm7ggPFqN9EG9iD1FVdzx+bcH8qiePx5JNXdqxK8L+98N3eqn1l3ye9tqnE2X9Zrv5PgcBQR0uoKwCUC28RtIwE9wpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 14:11:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 14:11:17 +0000
Date: Thu, 8 Jun 2023 11:11:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, alex.williamson@redhat.com,
 clg@redhat.com, david@redhat.com, philmd@linaro.org,
 kwankhede@nvidia.com, cjia@nvidia.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIHhgyUv7YmWsG3H@nvidia.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZIHgFFSaBJWFUNd7@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIHgFFSaBJWFUNd7@x1n>
X-ClientProxiedBy: SJ0PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f890db2-771a-4fb3-b2d2-08db682a3a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2PVmmEQXVvKN2FZvzoCcltyf3IbqbZN4a4fwKKRnjdov91FdhmsL+m17CQR7UplFkUZhOy48rI9/E5+dwzjL76ugERFwcguDlx9rU8bS0FF4p9dYlz6h0jVu6QZx51jeJC4kLCh/ypli+vko+xhnyu1m4SrGgznSNseXPYAk+KKiv7HnOihcTUne3f6tehZwl4ehy2nP49D3nQYiNKpXzjW6ZffS2Zq8pG3kFO4Qg6PVz4iQx5Y9h3ie7VllmuF4x4Kxspl4HPxUDMS4Ndsj5iSUFf0jKihxy0RNP1SQmdf8DzzuE7v2vl28HuVxAYDjlMhyf8xF9E7wscUUV8RUrqPsYRqULrZ38rjlbq/JwVQqEHrA2CZL32cNAK1qUrNA8WSkzz6hVuCaN214X2eF3DASYpELx4PyzE+HmqMupC6bF7pOTFAvNGSx0JuJGqBgE0kE35bqnmGjlwkLE0EDGOTM+MQ6s3bF2UW2McOvaNp9KVWI2ZRelITQOWIzs8Eb9rgTYXQKE1wZaeUtMA9uFA3fWuZ6+0mkbnOcTvXTAxstpCXw7T8mQslrnaPwocfV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(41300700001)(36756003)(8676002)(8936002)(5660300002)(7416002)(6916009)(66476007)(66556008)(66946007)(4326008)(316002)(478600001)(2906002)(38100700002)(6486002)(6506007)(26005)(6512007)(186003)(83380400001)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?txjcq/c8WQvRLgSBASVLJrXYNy29bVb+vPGd22y8qJHmFxUEpuaF0r5Yt5he?=
 =?us-ascii?Q?EBVavij75lSsYQNp0eUirHYapL/+nUYd7exG+f+CFBD7WoW36UsavxBEcJuZ?=
 =?us-ascii?Q?WnECh1eG0Flr34Uje7t1Hj6NL/5myFUHsFBqiMGaMfqfF1f1qAPu1fk5bc/9?=
 =?us-ascii?Q?KADeywF2Io92lcTjb0W9MsMea3SMv7LH+SMsuDBIkS5uYfrwQaBKZ3Jj6o5c?=
 =?us-ascii?Q?kTOodQDEf5IJwkjXAkN+tHARcwGW6WIpvtgeIpjGb1uze6st0owdxCcXKm2w?=
 =?us-ascii?Q?4JYtoFL1alFc7AK4fFfohRaWuu+R4+si+CTezWnBtMelO+K0cKwc2sm7neXZ?=
 =?us-ascii?Q?+YkDAJRNIT/KO7fVqi4k15Jq/4D3fYb4QNbnviiupDhIC2L2zffrREGKp9T6?=
 =?us-ascii?Q?kqst/RlDaPblwdJIJHq2xz8O4MDi9AnjnV/0w/j812ERsusT0pzjKOxAO40I?=
 =?us-ascii?Q?jtaRJfPEQht1PmjDFp0Ad6izLb/E56/VQOPltx030chwQd34ZCZB1JpbX178?=
 =?us-ascii?Q?/Wc3mStyCfpqOQgTR0bM6Y/FrbissAbmC1wOLTnuXfxo6EB6ilTzjaBvEmFG?=
 =?us-ascii?Q?aXR6Jo0IM0z3RdjeAdxyHtwrGplkiVOcRQ7KrO1APYNJKeP7J0xeTOsE0NLU?=
 =?us-ascii?Q?+XcT3s0kq0uaw6dTqPnCeT/3lxW/cfI5NoGUI8HVfiYk2rzTXa+UN5MWbSOP?=
 =?us-ascii?Q?ZAXhOSvG8nqx7hTCQViIG6Lte835oQ2z4OyprIhIfyNQlKz/KP29F1KKI7au?=
 =?us-ascii?Q?9Us+vNu1v5c6nZOKXh2MTQrva9Ee3//NtJq2NHWcr/nbDqNtnzFeGc0U6r5U?=
 =?us-ascii?Q?RiiDWTNPolESfQcu389I2Xi8w2uKqbAujevKXG13mvgruesFVzhsBL0xyj5z?=
 =?us-ascii?Q?EC5hGeV8pRLp6ZMG5eFdt5X+8Eiy60lV58VDzmJfduHZmzDxftThyxl3HNLC?=
 =?us-ascii?Q?40dHeJNvJ4CcytmYdK4M4kFevnPJtYkTsSt2sohlYVzHyP2S1TcO88g5Giwn?=
 =?us-ascii?Q?W6VF8UXpl3bSjzxhFvQ52QK++/mzWhuvOJvnRFWQMU6LriXj1AmEGvGNdt8A?=
 =?us-ascii?Q?vcO5I9ei8UdhCCDSEfJ81ErJkH4x5GYjNrkRGu2o3G6F03mYUpXulhIC0dUT?=
 =?us-ascii?Q?1XL0uaU8r0qTAjTFBAyldqPdnKIOSwaO/k1TSDIV+zSc79BVGZfWyh7cAa6E?=
 =?us-ascii?Q?AhAk1OGsDqEGlW0ckTbQHLd1vAVfh4Dv4XORRT8HiQ5pZqBWROuSd1tZcUWa?=
 =?us-ascii?Q?i6qTmGe/MDMAfVNlqrTSnb+Wl8t38Y4tLsae84IiRTyabhzkMWErFi5U2Rx9?=
 =?us-ascii?Q?t2vKPEjHRkMhHnTuLeKVs5i9R9H0vUok5X7ZnSlvqBDENJHe3MWbem+t5cpN?=
 =?us-ascii?Q?jot7Rzpr6lhKzJjhLDzoGUnJbZTuahRcZ3LtQ44goFlS+2RBxXkbj5o+G/fI?=
 =?us-ascii?Q?8+AXOEiGCc1UxG0WsByqC52u3bYH0gHTFXLS5/P2pEiNFXxAGOIEHZcnLz7M?=
 =?us-ascii?Q?mtv2lz9MPAzgyNqCRxlBTLG94fT5admsoMCy4YAQ2raHI1XDx4pJp/bQHOI2?=
 =?us-ascii?Q?NrNLM1LCqfLtjZyia9g=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f890db2-771a-4fb3-b2d2-08db682a3a0a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 14:11:17.6712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KmH6Ui32sOzGRhfmI3BCOg4E3xL9wrIV0XVV7OAUCcs0sljDqmoaANM95ZsinZyi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489
Received-SPF: softfail client-ip=40.107.93.72; envelope-from=jgg@nvidia.com;
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

On Thu, Jun 08, 2023 at 10:05:08AM -0400, Peter Xu wrote:

> IIUC what VFIO does here is it returns succeed if unmap over nothing rather
> than failing like iommufd.  Curious (like JasonW) on why that retval?  I'd
> assume for returning "how much unmapped" we can at least still return 0 for
> nothing.

In iommufd maps are objects, you can only map or unmap entire
objects. The ability to batch unmap objects by specifying an range
that spans many is something that was easy to do and that VFIO had,
but I'm not sure it is actually usefull..

So asking to unmap an object that is already known not to be mapped is
actually possibly racy, especially if you consider iommufd's support
for kernel-side IOVA allocation. It should not be done, or if it is
done, with user space locking to protect it.

For VFIO, long long ago, VFIO could unmap IOVA page at a time - ie it
wasn't objects. In this world it made some sense that the unmap would
'succeed' as the end result was unmapped.

> Are you probably suggesting that we can probably handle that in QEMU side
> on -ENOENT here for iommufd only (a question to Yi?).

Yes, this can be done, ENOENT is reliably returned and qemu doesn't
use the kernel-side IOVA allocator.

But if there is the proper locks to prevent a map/unmap race, then
there should also be the proper locks to check that there is no map in
the first place and avoid the kernel call..

Jason

