Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48CA7B05D6
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 15:54:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlUz6-0001ge-3v; Wed, 27 Sep 2023 09:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qlUz4-0001fu-76; Wed, 27 Sep 2023 09:53:46 -0400
Received: from mail-bn8nam12on2062d.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62d]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>)
 id 1qlUz1-0005Xu-Ox; Wed, 27 Sep 2023 09:53:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTVXJh0S3xkuJ40n6GiybuR8St05oVI2NkyicP9qZ5b5VNnW4vr5L2gA1vWITiqvR1ydwxjSeolbATA0P9po3MnnyBFjWMG6//rjRKfjpCi3c94cW21faXOXRi9zYt1KLbtoi9DmY19rUcSOrFMNd7zAl/mmttsp7VDvF4TVi/IysAx76qyl3ijQqzXhGRp8AYOj4hONJZ8O9nw+/jkWZaHlAL19DQo5JsoHGvgSOkuzo7pUHny/qp8upd34qOFdAlaz1ty5ReKKq/n0bZjH3sKT1e/Yszhdsl6iTXExPIcYFuisnym9yReKfK+Rkmc6poaBoz4F1+totJ6xw4BfQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8gOED7TqiOHiKzdgD7DGM6nxoPG5KfcEDBY9OeyPu8=;
 b=V3d5dH+tFbZm/8JoPZ2zQQ0dZapNGB7bzxRLDelelDfhJEofxOZaprkZO+tLOfi6hnAUvjTbTc2V0uSHTE5AQsiMbAJ1tSJCPGqZNOe9JwJlOP/64jft1JI5v9OUiKDViMfMJiqcnfa6419v2KS0ybbQ5pK6/skXLc3SFS2XvYGx48Ru3zffu9j3icnyNlMCpXPx5SnEKLL7w+AOtI0MS1QEIgGtLQj9UWNCPSmmvWFaZfSErLcQKYoHKfx/oYYSxpy4Vo6iHxWGaLX2b6yFvaO5dED56QGMamhISN3xLgKAIploQ4ARQfr20ZF2J/2iPNrjcmDO/T8sI4mV+CZHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z8gOED7TqiOHiKzdgD7DGM6nxoPG5KfcEDBY9OeyPu8=;
 b=aK8zpK12tYqUQ5d7V8UV/UWmtrgpm38QfiFfXX8Nw3gHjxmaWcD+Z22x3J/f+t2Wb4L7IpepgdQih1Wzu9eGBLd6bTJA0/YyqdXMHwJGmklJnSy61drGuhGM4WygYJfH72LywEeU1gnOhfqfsKfkXGe/oQSNApS8dFsZSTMcHpdarTFG38hJYWAKvIwbvWBxr1tXIW6RfIhy3TyU/7L68UbsLRubDaQJjBcOU4dcQ8qg4WxgITzo4oyEd7uN+Hm1n7EQJXiiodNENi/q8X1IUdGDZ7dEx94iyWtD7cZqzpFYNm8qC7AVrvhiJbRumAICc9dkV//nn5JavbDDe0ZTFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 27 Sep
 2023 13:53:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 13:53:38 +0000
Date: Wed, 27 Sep 2023 10:53:36 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "ani@anisinha.ca" <ani@anisinha.ca>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gavin Shan <gshan@redhat.com>, ira.weiny@intel.com, navneet.singh@intel.com
Subject: Re: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Message-ID: <20230927135336.GA339126@nvidia.com>
References: <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
 <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
 <b67c18d1-a648-81bc-1144-33fb839f2aa3@redhat.com>
 <BY5PR12MB37636F9E84CF92020769D859B0C3A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <769b577a-65b0-dbfe-3e99-db57cea08529@redhat.com>
 <20230926131427.1e441670.alex.williamson@redhat.com>
 <BY5PR12MB37630E29E6E83BCD63FB3F2BB0C2A@BY5PR12MB3763.namprd12.prod.outlook.com>
 <20230927123318.00005aad@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927123318.00005aad@Huawei.com>
X-ClientProxiedBy: BLAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:32b::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cdfb6c0-ac81-4344-1116-08dbbf612627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fxVX5f7Pbb+4Oj2tMiQwLeDcE/ICFqx/rYwvSA43kv+0Nz+M20ThTOqFeFPfwRAIAfd6sHCRktBcGLkYK3Isr/6UywPnCE7rczOoffZHfQNoHlsVrTutbCIHN3fVRFzu2yZXWdZA8LAtzbmF/woYmfexYukyw8rLP+3RfrxAiOKeD99Ib4nIW/mo4k/fFf17gDmBmVUh6Pk3bX89e/QCfo/JW6cyc9KAwTJSQJ8H5xAJGENLhik2/iHuxikXONGqZEHWn44gCcbc5ywwLWD9rj/DTu1VJcvGs9Jq7HPtKd4C00kR9HK/lF6DLM3SRBPTb3YqfLuQmFrr5oJNrl1c7jDtFnk+vN+lQWvFqiiV4/7i1/FFku0lpTtBYVVEm4+xCnV/fyFoVNI5f5L+vz25Jfn6DiOThg3BUJsxHkMaMUW/RYhKqm/+zawxAw3nFm2V9KDu1PDUTqOnWSpjAC5FWDATevRPGr4oTGWXas7QGB1zLWDd+YbXkLfnV/X9F4O7PdCcO59cTpzQ6Guhge0BuJe8iqEmZr1Q0vF1ktksSFENQQW92KFaeJMdxgmM33EQi0hQOR5bIb8dcmtOyTTfxqbcI/Kb8s7oRBR8fl3I7XRCd3KvJti4XnjFZq6Xs5iL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(1800799009)(451199024)(186009)(2906002)(478600001)(6506007)(6486002)(38100700002)(2616005)(6512007)(33656002)(1076003)(86362001)(26005)(36756003)(7416002)(8676002)(41300700001)(4326008)(8936002)(54906003)(66476007)(66556008)(66946007)(5660300002)(316002)(6916009)(27376004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oNxGNTHhZUSQcfWkGbGEB5/m/Hj2atu9SjjGwleZgaK6R2YMnnJNTdlkrfWR?=
 =?us-ascii?Q?M7WtdCjoteMYjIaTJfcwusZH2oV2fB4/D9g8txZ5MjaiQFZtmCkjdUQ1GYLF?=
 =?us-ascii?Q?YqIlwUJQ9qEHRTDAFeIIK1QZ1Zw8hnJ03bORkT4+Svmlkr/4jcPpChtqVvmc?=
 =?us-ascii?Q?Brk5KwzwVd9j929z1DRY9Rb3rIJiOPZgzw/jEecLXtIhc/hR1dA26WK0HYfu?=
 =?us-ascii?Q?F1hylS4grgPspNjOk4ylBsNmuu0VIVeosY9WPhqR7Jg+tM3T1RJ7Ueo59Ji6?=
 =?us-ascii?Q?m1ra9Z8mSBGLNtf+TOfN3TdLCLfFIRR/MAeNOG+LMsPCXxIfxvavgWIdQjp5?=
 =?us-ascii?Q?kQXE1ot2NDg9XSANwMI885TMLmYU4nBBCN+gSx6t+8gZym/ez5E44cJ/vY80?=
 =?us-ascii?Q?xBC8LucWiOBl9H4AGXD1bUyo3NURUuplS5tJNUZi1jW/JHco3/YXkfXAgSGv?=
 =?us-ascii?Q?pyM9UfbqbAMW533fj/7IPmOecXWm3idDtoXVjqKKxL/V0gvArVV3A1WjafPB?=
 =?us-ascii?Q?+Mqun+OznbS2F1t9fmAnelfNZq0JdugMnmiFaLgOyEWZ7LYioGL/9WUEoJL6?=
 =?us-ascii?Q?b5ZrJvtKf1CKApupWrqTr4X8z5qnPHCT24MtHQQWLG3kQ+dXTLsmIO7Xnw2p?=
 =?us-ascii?Q?4XlmZkTk5/jFvo87rpFOftGESQPmIIN9YrH2KkoXLUu2vhuhUL+mBSm87MmN?=
 =?us-ascii?Q?7IfuQQYA+JyI5aRPSbn+vL2C0QnSnt1P2OlQA6Rtpge6pp9P2Rjwqke5smmn?=
 =?us-ascii?Q?DvQnkXHvIoUxd69VQU13awrpSU5k6DlSXNNZEUJTfCwXkyd8SYKmiqjiKURO?=
 =?us-ascii?Q?l+i2ZbdLZAdyHIsp79sk+W57llWcKumXRdxGqIoseto3BogyyqyFssEYRaFu?=
 =?us-ascii?Q?yRZC3xZrfyf59CdPxYTanbxGYWR0fit2VVbe6OXKPvIIh1n2Fo7Hfi59tBme?=
 =?us-ascii?Q?7DQqCVb/fRngrREHZq85cm3I2BDUc4bf1a8WukxelPLrDM7tb1lU3tJI5xo/?=
 =?us-ascii?Q?Y998elkh/qaWP6jb2AH61KA519EBdX3I/8AoMD4+lOlnx+w2+30uVft869eB?=
 =?us-ascii?Q?xrjkK0bNFvPLbUWSRZVbMXZF14odbmh1FMzIIw4s0dyUN5TiLWWvgRdfZgMh?=
 =?us-ascii?Q?WcNmw2BD2A/RF+imhbzNHEp2fTgMYZ1CeiMYCGNGsefRvLE1q8IwFFGrw2tZ?=
 =?us-ascii?Q?db7JD0M1aYIg2cr9EYd7oUOPFLKfUKy8otX+rCi+W+GMrMK2wcslmssBbh/G?=
 =?us-ascii?Q?O6dpaGvWlIrTs5m0z0fTlxr8+Bdv/SSbTCCLIwnLwliLHSYGeast2YujztbC?=
 =?us-ascii?Q?UoU6TQ0a+QOXfXb8as+rx5lIxAekoaLOzdPFcY/CQg56WAHjnOAqSj+hcMe4?=
 =?us-ascii?Q?5eAxFc00uBsmBxofMpG6CCJsxAkTKHyRig0yrEq+UGioL0XDEeybxbapMMXY?=
 =?us-ascii?Q?jCXUTFZcnBzGDgDFTrxM8kNGAn6E3+uhN76SX/xW55d0skrjQxsa82CUwKTx?=
 =?us-ascii?Q?vqT+LhGelwxUlmRKpNZncAKlyNXaCROuPqqLoDId68Juori1V0pEVXEoDgNu?=
 =?us-ascii?Q?DoaWWMSINx12ouu6SVhX8Vveuz40oRCC+vbnr7nj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cdfb6c0-ac81-4344-1116-08dbbf612627
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 13:53:38.1388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0tbmPzxH630szknHKATyY2G8Tdl/Qn7Cczc8XsGWRd1kTAq1ThwHW4bZGsGcwXF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::62d;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Wed, Sep 27, 2023 at 12:33:18PM +0100, Jonathan Cameron wrote:

> CXL accelerators / GPUs etc are a different question but who has one
> of those anyway? :)

That's exactly what I mean when I say CXL will need it too. I keep
describing this current Grace & Hopper as pre-CXL HW. You can easially
imagine draping CXL around it. CXL doesn't solve the problem that
motivates all this hackying - Linux can't dynamically create NUMA
nodes.

So even with CXL baremetal FW will have to create these nodes so Linux
can consume them. Hackity hack hack..

Broadly when you start to look at all of CXL, any device with coherent
memory and the ability to create SRIOV VF like things is going to have
a problem that Linux driver sofware will want a NUMA node for every
possible VF.

So we can view this as some generic NVIDIA hack, but really it is a
"coherent memory and SRIOV" hack that should be needed forany device
of this class.

I was hoping the CXL world would fix this stuff, but I was told they
also doubled down and are creating unnecessary ACPI subtly to avoid
needing dynamic NUMA nodes in Linux.. Sigh.

Jason

