Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BA27E6B03
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:11:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14mp-0005LN-MC; Thu, 09 Nov 2023 08:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r14mn-0005Kw-Nu
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:09:29 -0500
Received: from mail-dm6nam11on2062a.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::62a]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r14ml-0001NG-2Z
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:09:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1HyhMlE3KmLG0S3sGwS218RFVZFLw0Wvsx2yptKHo8ya53plqtKbuw7uPwYLTfeYel3K6xDrIO6w0iLfMkcpWDW6FlkhHPsWvA9ZJmvtJHdC6DcfR2QccmlrLszGqf66lwewa1ZbfmmU6Dp0GS9+wd+aivMHNQs28WuErzNnnDNJneqV+rg0KvylgDLo53GTV3mxHnipWEshJJQ/5lDEID5SjyyTi/C+3aPY3hstubZOzXIWtos/o/owAIWfhk70zVMwRY8ekbYPKsfJ4h2AMURWgt+Z+PHuqD7m3dgyXa7HPrIxpztFjZIF+dMqW67CEXBsnQPNBMaP5sJuVeDjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMpo+VI+dYAsBt55SPWnzXqoaHh2EMjOv8qEAxmumIo=;
 b=KViWPCgrvfLUaxTyC/eDWJyqZtrYOlGXgs4/iBevUC05SAShZlYYJLuSqPk9wiZ4DfNhdAiZNq1cXIf51SkQcxz8ZBxIqoYH6tmwTYDD8O9ZBaXL/QPtnHWBI9pjrk56Ad05iRcl7quxOBniL9LXJyqf5r0+tKV1xoE/H/gHv+xa6PVK712OSbgjbIZFtvY1KuahCV0QTc7exlR5SWLgIgNiyN5zPDmOJ8pAzLYfMJViW6begNBTrAKj9xY089EcVWcgO6ICkMEE9g0nwGP18+YjlxGzKnsYcpBxbrMCUSRg1kNuJl9vmvNaX1Hkh0YVLWXaaNq6kPqLDcV3cKvrLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMpo+VI+dYAsBt55SPWnzXqoaHh2EMjOv8qEAxmumIo=;
 b=Jub8DoG5wtkZFE9ZPS81upOBtQrbVyxApDiedus4MHxEjhBCJa4l64syaDpKBH3lDGT2FVjRoGmCNltii1bNn6zIE7CW7wkRvmZo8bVUxBe/utaGFU8ndY8L1QMOo/00GUxbC/7vwGwIt0WLmxXdE8CNh4md4i9U8QuEf6HXW98fA/mgJ7smvmDCQCEQMSOL7+2pTVYBhPqwHDDS9fLzZWABP6JWL2LLMtDc0iVUBo6Hc3RiJ4MBNdrmDjPd+iBLdkq9UgUFuQffPs8ZGrLo6e9XxmPiSQG81xhn4Y8JP1n8Ex2zIIs2w9m8l6I+QwsaSN8aGHUAIbfIK7zzgQMRMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 13:09:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 13:09:22 +0000
Date: Thu, 9 Nov 2023 09:09:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Message-ID: <20231109130921.GC4488@nvidia.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
 <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
X-ClientProxiedBy: SA1P222CA0171.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bddce44-62ca-4869-9bd5-08dbe125172c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Jpsjt2YZcNuGkGzNfanWraGZwL4QmSEda+wHuSRC04SxObeIXwxgtCVpNT5A2k9a8Szsb6hSGa0QZR31AviBX2eRLKgFW2gg4AJokJkOh/3kffrGxAC+jZRAWLzZ45onKUrhgPygqqMLMHVtP8y+jDJtNfESQHuN1uURcAJDcMy/8csu5zfxCy5SOGkU+D1j0k31a5RTdKuAlphoSPEQBxRlh0J2+RKWPz5Ldtmbx4ytHKyGllj4pgRRjCsO091GIVi+H5a9UkvP0T3gLYanrFnxynRDyVeGBxSS8Q3kRLzQYRLOJBoMkuS1zu3mLbvzbJkCbFu5jLWxczdTlqTo0pTXaUXVdwJl7bvWEZgqhvPw8H98FQYRoYnHVf6aGOgVlxMmqc9by4f/mzQnOImeP72oFGkN/RpIdht5Sm3SA4m8qemFyMFcQy53gyZRaOrzVjxR8XvFRlpzf7CMNv+pdZWCZLw91h0ci9jfikA8z3uODNg5oVSqglfPu2mev2qIv+qMBFCAuyvJ9P5UYCjUvLc1Liy54X4UkK4Grm6fqf31yzXyrWfLnDC+s4qg88e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(4744005)(38100700002)(2906002)(6486002)(478600001)(41300700001)(6506007)(54906003)(66476007)(66556008)(316002)(6916009)(66946007)(4326008)(8676002)(8936002)(5660300002)(7416002)(6512007)(26005)(2616005)(1076003)(33656002)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H/QujPLRfxasdSMFBUqfgZ++CcS/+7ZRVOj6+drQZMrF/wJFhzEJizkTqaBr?=
 =?us-ascii?Q?IgiPWVRrmZeziQM4LxYaYRA62JwNvAKIijR4llmVPLLLDOW13Ifd+Zx6tEjw?=
 =?us-ascii?Q?0OE+5w1/HIW0lspZg/WB82qQDGz3iOyF4qHIAwQrBp1ACUUj86r/XmwXhcWp?=
 =?us-ascii?Q?d5n75Wq+dt7g+lhzrLWdqj5DWwzBkUf6fwAWMKK9MbPZZYtmcIDyJJSD/ekY?=
 =?us-ascii?Q?XKEUk2SEJVAMi1bhlF1dS9gfuj+sE1tDwuxNkFH3IK8ZbN9c9L5199+WyHLM?=
 =?us-ascii?Q?HtYPICKANCT4mb7hjnxxJei9Tk8INrlg+pRihAqprPHh/UU6DPARLkaC7X9g?=
 =?us-ascii?Q?++dkHrToymSadVFBxPdTt/N0IBGPLNxbHkwHw4jWUJBnoILJ1TiEXii/Gt3b?=
 =?us-ascii?Q?DMWJF+L/PfPYS74LiLfJXWvr35OMnB/sFCmPIJl2qG5T4wORDcGs5R1iHV1Y?=
 =?us-ascii?Q?+YoEiE6IIBuXYpBmVMibd43PdLEgC1KySzjyPAypqHMcFpiIou1G7GuvIUT2?=
 =?us-ascii?Q?INiCWGKnhm6WC1RtGisbdhAh+j8OAIJxjQMYL1TNue5G/xk6uytaTGI/ZszW?=
 =?us-ascii?Q?KvRcvCyy4vmYHf4LUAlseVDJE2Mu4/ZK5MWUooIUsz0wHSOhTrUat4pUul1H?=
 =?us-ascii?Q?i9WvfFcjqhf7MSUF7W5kMjBzZW0oQqN6pybdNyQ/97wdPE6bvy18RFP8bwrC?=
 =?us-ascii?Q?PwNJDRIcsXDtRkrWYkM0YcBZ4l5WLxR5Em428SnUH+0PC/u7+LjZ61gW4N/G?=
 =?us-ascii?Q?LhUMP/uAIbiVZ4mmAZaCGkeBiXlQyQk4XkV9/WlcOsPd/oz6zPbgd+6QJX9e?=
 =?us-ascii?Q?oy758BasW4EJaJpMSXRgl5KgEqabsQRjOoutoTH2O6Earyzxc73rxYUeBPag?=
 =?us-ascii?Q?QH0uZLyegvDHQGEURSjTKa0fKl93htzARhN7/NTs7Wwz6LIKU4WWiWvbYnb7?=
 =?us-ascii?Q?AT3DoX3K6igreXy4rGDRPKbYXqeSUkfJZ9Qp9IEScfkgdz4EsH/J/7qh8wbH?=
 =?us-ascii?Q?XZQwSqhh9Bpp3FEWF+flhGPeU/Nbvn6Z7buVL9H3XpMN38p4cRrxaVnMxaj+?=
 =?us-ascii?Q?td03M/n4KFHECjP5kCB8GVBQjeywd+8p+sxCworR2u7EwgW0W/oDoURCaNx2?=
 =?us-ascii?Q?F9XPxG0+k4LXetXisajCRnczE32nOKD4h+AfC0/5KQSbFOe7WDykdwXL9Hoq?=
 =?us-ascii?Q?atUJYogwh89Dw3EIJ0be1eorb0AxN0kI73ouz8oXS95Sws33yF7A999KvbL4?=
 =?us-ascii?Q?KvoHsZl//3ibLOhDvm1ifFUnqgd+1Xz+0nylnWFRHptZiwQK9Aapzlc76ovj?=
 =?us-ascii?Q?dF1c2v4Op8Y7UtibXOya4kY0g2hu/7zHtaQ0OGAmp/KjPwn0qjM8O6LHrqrS?=
 =?us-ascii?Q?R2sZKMKSwCCHjw/4hisMIcgNnJoeGWoRGKhVlPWhILWFNTQi/oxEgyNSzfQw?=
 =?us-ascii?Q?XSu4pEaabXlE4mxPzwdyL2rSjE4IC9NPO8S856nbBNNl3zr+xya463mPWq+2?=
 =?us-ascii?Q?7ebC7tD9OXeqX9OT9ty0q1HkFwA6gicFCNbnP9YO6rKAScfLQ2zbhPf13uDi?=
 =?us-ascii?Q?7vVvDY7cOirOubQmXNMC06lMinh6ys5MhVg+eAqr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bddce44-62ca-4869-9bd5-08dbe125172c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:09:22.3190 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fYayYGfi0ffnO7qGbVjRmhakO5pcUxfyZTIa33/qR4YptYzzQnA0frujd7EZ04N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::62a;
 envelope-from=jgg@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

On Thu, Nov 09, 2023 at 01:03:02PM +0000, Joao Martins wrote:

> > I am not talking about mdevs; but rather the regular (non mdev) case not being
> > able to use dirty tracking with autodomains hwpt allocation.
> 
> ... without any vIOMMU.

Ah, well, that is troublesome isn't it..

So do we teach autodomains to be more featured in the kernel or do we
teach the generic qemu code to effectively implement autodomains in
userspace?

Jason

