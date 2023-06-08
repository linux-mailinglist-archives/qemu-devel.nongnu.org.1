Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E27284F0
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:28:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7IUb-0006Q2-FQ; Thu, 08 Jun 2023 12:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q7IUS-0006PM-Jt
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:28:00 -0400
Received: from mail-dm6nam10on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::630]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1q7IUQ-0006L3-75
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YErxbAHvRQRhF5NwmTjSf6Fpb3X1MgbBRYZ1MzE0x5vux+OUH2JO+wNUy/yHEh/GX+I3qYIjts0XYfupm9lW5mfXVTE4KpNCRb3w1e7JXZnDQXlEKyVp0C7HWdvnearpkcQ6JcoYqipMN7rGpmpHnXrQVPA4A0KIpDTbKJ2zpUwXilktsJNCo+jHkftscz7mv7G4d5m32ZUuL4Q1k3W53lEmPrwvrpJcz0jLstc9FY/6cIBIL2nwfWn6mshRTkJ3PofYXlNXyHe9O33yoLFFInZYgF4swKKyFHs07xYrcclA95jXLisemO0VAGF6YfYZqV0fpYQVQToYHFHD7RLbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qUnB9tATP1EeMw6XN3128zEnGLTaQ9SWsSRnQOZnBk=;
 b=oZLOQKpoA527mO87WwIfkr0+pG8Z27DYK8WE+s/tTgXZBLMQs2f2Fvrvk2SKk1Wg8yVqP0ErsWhVfiA6+YPpHqyJyVAOw9NsWcTjNH7Ap3d9WonGouq/m5VKGL1/KjxfpOrwRq9bPfnA1DoXtXL/AhSBXu7GBVtWmVKLVn5PWSB44mZPO3HB6POC0FEScpETsYGEQAFPX92oB+vFGxMFrnMeNF2L3Ii7ovwmd4y7OoEw5qr16unvZF85hLk0lYalUSIBpi3Rc6pUvSCMCAROI3vFSsN+8c7R4xdpEQG+YIRzKiKO4aEzev6hecl0zAzY/fWXU1u5wPoCu6mYu/DYuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qUnB9tATP1EeMw6XN3128zEnGLTaQ9SWsSRnQOZnBk=;
 b=p+TV+F4mJRyzOM/oN326k5bYhJvWPEzTEdu3oOD788y1HUfXALQQ2GkwayZsL2Eoxbyn3HV/wTNYTl0wyP+h0w7Aaey5dbHgEuRymI75mPpMpPtpQpZXVdpCbfqzxLiYqWyjZRVvSYa4a/qqy5g3JibPkA4Vd81OqVjt1exNNr+VrKAxi0eGSD/oa3CLF1XmK4RibfJrVZdkOEoNJAeJ0suNNUDzmtrrH+UupjR4B8D77wFLyMjTd9+wz+gANYFFFzAAmHOAGuLVNLwzynb5CLUrzjPoOVUSMzPc6olZ6mmgPM16PWOLPRN9fDjVRfFuRrQQC60il9H2JgWUwhdaBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 8 Jun
 2023 16:27:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 16:27:52 +0000
Date: Thu, 8 Jun 2023 13:27:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Xu <peterx@redhat.com>
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 chao.p.peng@intel.com
Subject: Re: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Message-ID: <ZIIBhmoT7H2/q0lb@nvidia.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com>
 <ZIHgFFSaBJWFUNd7@x1n> <ZIHhgyUv7YmWsG3H@nvidia.com>
 <ZIH2h7GAV6qirAgw@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIH2h7GAV6qirAgw@x1n>
X-ClientProxiedBy: YT3PR01CA0020.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6396:EE_
X-MS-Office365-Filtering-Correlation-Id: c3c64c99-f9e7-456f-f83f-08db683d4e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZoVGhaKANMvXy2Kj3AN4PCcmDwLqR/rFnHT7mlI0WMU++/I1ToSusSf2JdPoi1io2Vfol5IPIYXpl/OjHHdU4FrpxUZLC/+sC/8gX7Nnex2jNOfQzwQXlvuhax0DpVh3YdB72wwe4KF3krQPTgOTVn8Efb7+K2YJp6CK9BLWMivx7M8JQdiroQ4K51sKZyFVYbBVwW1nN0liPeFxKo5fVVyBx/L5Cna7P2sLgR8OxYceg6+dGqx7Fd0C+ihG5nRdcT42tXYDHLtUF7xS5647QXS5hxpPsusrxmiNBQrTZskbt6IlZ+LDhb+ft6LfdyzE5v9v9oBwrOSe0/2NJ3AfsFl3cy98RK8BYUbitG19H2RAnQXsnsLMLKv3rIHH0GipQVyKxsSFbEa6suH8qEE4tfZRHQiSblyF1y14p0fj2Ne/jNLHIf6LIUcSQDN+B84X+5TZA9ekLzSMuqGqi2nrOCYB7HTyd+0yJDq3kmQRNNFG5VRZFrIFZsREtExSF3essdDtOp8aeBsNwoJxLeiDJ1jkJv1hkEgMWeC37YlvQc9L27A8EVH7Cz1JeceNuUP9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(66476007)(8676002)(66946007)(66556008)(2906002)(7416002)(5660300002)(6916009)(4326008)(316002)(41300700001)(8936002)(54906003)(6486002)(478600001)(83380400001)(26005)(36756003)(2616005)(86362001)(186003)(6512007)(38100700002)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tS5CB5iHxHBMoUmGynrR10VzlC0qvwpjsjV3wq+h0QGQUZz/LHUYDRDE4bPL?=
 =?us-ascii?Q?QaAEaNEvQBtijJZQty0FhZSSo6Y9jznbuta15VC21YzFuJZRFkUmcw0vWrAG?=
 =?us-ascii?Q?M5FQD9Gzp/x4pR00TF4xMe5573V0WHPvKqfnyWtWhzKjG5bjVYzw0yhrsOMK?=
 =?us-ascii?Q?AOM9bY02fnGqOt2I3n2QsbkE9n0LytU4/i1RKXsrfS4MSJKUoepx0Q2gRwpa?=
 =?us-ascii?Q?6YDQSI729Ls/Zmqrktx3yA5muA58p1IQR2LVRR6bry3nWcJeqxE8pMiJgABA?=
 =?us-ascii?Q?MuamhCw87yPpyyPncZ8x9h+9CooQyc4g82xxIp1kgC5ErxG4iCHtj+ndOGbZ?=
 =?us-ascii?Q?jJYtw0kZpgxxMQ9SaX/FaqpXBw+2hTYowmn37n+e2ASWnfheGvAWn4lW2M6C?=
 =?us-ascii?Q?fVpMrTweeTdlm6Nvl+nZZvqCLkSriLl4m+o2M8qgCbeazn7DcNd9tLl/YUJm?=
 =?us-ascii?Q?26fZrevxXk4AFo7TVTyFZwjy9ZG68vvOuJPncnratMZGGqZl1OjBDIGhovOF?=
 =?us-ascii?Q?M83Cj50KrLo6usoZlHhAqCBw9FmnRFF1bM1/1Ur98D9QrDEPCEeAIMcH0Ea7?=
 =?us-ascii?Q?teLv+XJDA6v0/V59D995sm/fpS3ARvfCPJVRHe2vqYPQ69QAK6LRenDVzup3?=
 =?us-ascii?Q?jTQpnko/4SaDMxp97g6Odqtl+pKReDKgXmwFyor4ZraHfdU7bh4HwUJRdZq0?=
 =?us-ascii?Q?VXFHdnh81RWAewDmeurBv2IcJ3yVo1zpK2IOUirQ9/EU1Gbmx/1Xyn2dPe/c?=
 =?us-ascii?Q?tFj8nidctqVJvbQONx/3kZSEjru/tiX5tAXuiDMqHKKuytb3HjjcUXlbLTRd?=
 =?us-ascii?Q?fkagbU59cVpKk3Kw/OpgGOKW4fbZ2zTmgupd6P0ikx4kaFSCbNNny0pHvE/Y?=
 =?us-ascii?Q?Gb5dOiZBLiVfuLgReyquQuNdEu9iNkStXC+isOhV33seyccQOEoH9C3MpW3o?=
 =?us-ascii?Q?IPOt1SQqXhrVxXML9hdkeEsbP5YZoX5bdFSnAoHxBufYCwEV4cdUNRECYcxx?=
 =?us-ascii?Q?1fRM/Bqpb2ANXd76gSVjEC0IyjeXX7uFImyzjgIdBa5udmpCdXmMX5Al82qZ?=
 =?us-ascii?Q?eAZ9VcMUbvswCh+mtm0zJrT65AQByjTKNjWT/DK/y6ZU/i3HATI5DYQg7qzj?=
 =?us-ascii?Q?gZ1g50K49/M0CuPbU5PP4MWLp2PhFkIP+Y8qQYqJTZFrzD8f10mry3dZClI/?=
 =?us-ascii?Q?zCTuKWSoo5V2a+gCpTJex5RgZKjkK1BV3l6Y3V69qub1b+XW3pP3kheL9lr8?=
 =?us-ascii?Q?67C5PoYLBbue0fsc0Zux/mauNjScAwSwInCJZ3J7nFWhOnWH1SqeEb+jf2rU?=
 =?us-ascii?Q?Vi5HHGorTiQLiP3zihfSCLxzZ6Bz0F0AHNdanhW9Jni9zSbLOXSgDme39ODp?=
 =?us-ascii?Q?/0j+V1wNDt57t96ipEZBAENxo8tPy1vRLgdhmpPAB47ySrA6A/vPEU7pnzUp?=
 =?us-ascii?Q?x4uc+gQbW+Y+JQxkY0uIBW9JCfb/C4SoKjWD4/cnKDQH5KAoilzNXpfVjN+F?=
 =?us-ascii?Q?d7fun6MCZUEsa9C3wxnWR14eFynbskWVCKbLGehiABY/nwt2ig1EVxoVOY31?=
 =?us-ascii?Q?JnXBAmyDENV1NrHmURQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3c64c99-f9e7-456f-f83f-08db683d4e44
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 16:27:52.0513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtqth0VwR6hHXsRMAPQvSPMYzn1VHgSvIN10d1PXH32rCGjbSYB4mrBv4xFqgPON
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
Received-SPF: softfail client-ip=2a01:111:f400:7e88::630;
 envelope-from=jgg@nvidia.com;
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

On Thu, Jun 08, 2023 at 11:40:55AM -0400, Peter Xu wrote:

> > But if there is the proper locks to prevent a map/unmap race, then
> > there should also be the proper locks to check that there is no map in
> > the first place and avoid the kernel call..
> 
> The problem is IIRC guest iommu driver can do smart things like batching
> invalidations, it means when QEMU gets it from the guest OS it may already
> not matching one mapped objects.

qemu has to fix it. The kernel API is object based, not paged
based. You cannot unmap partions of a prior mapping.

I assume for this kind of emulation it is doing 4k objects because
it has no idea what size of mapping the client will use?

> We can definitely lookup every single object and explicitly unmap, but it
> loses partial of the point of batching that guest OS does.  

You don't need every single object, but it would be faster to check
where things are mapped and then call the kernel correctly instead of
trying to iterate with the unmapped reults.

Jason

