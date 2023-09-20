Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5395E7A8ADF
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 19:50:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1KR-00078t-C7; Wed, 20 Sep 2023 13:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qj1KP-00078l-1p
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:49:33 -0400
Received: from mail-dm6nam12on2061f.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::61f]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qj1KH-0003rw-RX
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 13:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnKiOk/jNJJWPbY9rOqGquINw9my+9CY/5gj/C+SJFeOZggNjfkg3HONCaKr+p/LnP2oqusA6yS2YxBMiW/UiCPeJlvupbmvjY3SYJVfyCl5lKCGfzelfy9/1R6RsG3XEkV/XFPUvTYycIIYWcNe6ql83wNGmNaFWjfbNInwQJskIKkLQSPBScWWc2UE6juuRQWL5kGKupUHuU6ngCNpPtEJ1KNNSokaECWXq1yVV+7magZxvUCaH/mbSuJpPlYEtl5IxkiKrRDZFqfEeA+5jpce2TLMHU94JH5SvC7p4ZCcq6YPppHJAHykFAkPQ7q3bCywLrhRORO9VfafRdC+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qz88lOqlRdPGol2mC8836nNVANMnB8KB05KmB7N7ugU=;
 b=fSKlD0+NRtA/5fKyb7E+vZSVhTxfGXJOecfgPEl30xU1CKLjqwP1MZ4IiJHrGAO/TmSh0vG9RfYm/w8JSCK//3hey85h4JKHfasKsDAFafIFSl4nByzO9r1soYCfq3ILvDbvzhJbOfrNhihcOhtEcyoKkpWCfnAmbV3+2i69gTckfop9rHBcYnuPrKQKvD9PFwrNS0d8p9T582jSbPBT1wsx2VcLGd2ThOYuXLeeS8lLRB+WwxJUP7bBzjtxf/4KR0pWdwsN2EpYLQSND0UYnr2AGK9k3dWGdAQ6AaIDTRxZyG8TLKqHu60H+t3OPkguc8HureiyGqdFRNVy+CKRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qz88lOqlRdPGol2mC8836nNVANMnB8KB05KmB7N7ugU=;
 b=LKtwLD67AE3DKNUM95FeEtu9bjeySPSUqgBFNLfRkc3k7ZWhHwj7whvcDmrfMnrjhfdvmpr+fPkhiQWRxh/IiE4JCN5YUWCC7Te9VUoRT47j+EbTdVRum/VC1gozGW9+odm3y4hLpMRkLSf9UcPr4rux/BuZjv98/QCVAfaOxoCCAVgaalnYeY/o8WUnF4GMF0IC4dsKlUG/V8bLDEVVrEoEZnSCiqwln+sgGAPGwwgxdKcnScH4FWsh6J8ba5Sznrp+8WmsHl39wCww+3pdCdFxJ0REZP5bihLs/AL47lZxWpQPnPZyvvfrgCcjZn3m9ZtuOaOFiIAqpHV5UEy43Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 17:49:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 17:49:21 +0000
Date: Wed, 20 Sep 2023 14:49:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920174919.GF13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
 <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f3fab2-069e-f286-aae8-25d5269e6e0c@redhat.com>
X-ClientProxiedBy: CH2PR18CA0013.namprd18.prod.outlook.com
 (2603:10b6:610:4f::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 1076614a-88df-4768-956b-08dbba01eba2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6D5/Oq6B4ohfF2uhDhLkX8X0d1REIE1UhE+w7FJv9+ZBEcsxPyVb3dgT6zfwujLdfC1b2kA5wUSzA6Wu42pMlthhscUo4dqy9PP50R9ZyJ8n/pr05Sh/4kXguE+06RCwWRiFrF4v7O0GE9Ob8pk7aNA7Mxu7OnH8/nvxDMxCMS/fi26mwKxQE10pr6/NNo3f35KVcM8zN/pkd26ZiS44zYmyetNJpJbSU5MLYbI1w11JJ0MCPPG/nN25Vo0W8jABojt2+a0W2q3FpFJXDa12LgM30VZbbJGMOe0/xe9+LTzdrqwoLgT4bLBAdGUWRR+Y1+e5Fls295ZOBk2BnPEycdfiEoRZuJNPXgV+RVvMZWZ9aK3oiL/BrXKvXkTWiYQkAQTw94va2Zoo2cojjwPHBBC7S8V28rda8VD4uB7YBQPdw53ZMA0Pg6wJryAwmF70y/8KLuUpo+ZJcP9Ltyb5D/8Zego06In9R9ufWuQc6MzBPJA635Gd1X/8HbtxxjoXDhTRmT7kA71jhZtXFIocPEcCQCZi5woi0l0qOBCxvAsq5ajJp3dC6tdCKukMKuS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199024)(1800799009)(186009)(8936002)(2906002)(6916009)(41300700001)(316002)(7416002)(26005)(1076003)(66476007)(8676002)(4326008)(4744005)(478600001)(66556008)(66946007)(54906003)(5660300002)(6486002)(6512007)(6506007)(2616005)(36756003)(86362001)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RG3iCC//DfZWh2uO7YbPjqBQkvIRDNT3MDZj3JMe3YEvUVHXXySnDbgWCgHE?=
 =?us-ascii?Q?d4Aor7Vo5zkm1B4aur9Tz+1gUc3KM3qINtln8WNKyiRYv7T1YqqY8i7vkGEB?=
 =?us-ascii?Q?uBYsFR4WDtj0fbPZQHBg8rQYEuEjsNwIi7QQeXJA7CJzeZa0BfCTzkjWkYf8?=
 =?us-ascii?Q?Jh3RMfBaNcSnUktYPOx6j591jTXKMidJCWMhACBF+tzOQNjb2EMOmZ6B27E7?=
 =?us-ascii?Q?qmxSrbQkDLfSmKiLXhHXHA7Rn8Hh/IsGg/ADFz+rRrfETtmmaZgSGSm9xktF?=
 =?us-ascii?Q?COOqHIBPXjjcQn4s+OX6RkIShBXIloLTJ3+XXO1hJPEpoDZx5G/OkHc738e/?=
 =?us-ascii?Q?vWoJaIppU1TO4qHVrl3rP3CtFzWh6Fsjnx/1tAuE4hE/uv89wk+SMrR90Tb6?=
 =?us-ascii?Q?T8SnN3P9CxW8hiw5d9NSYLQa98aIZBi1Zbv6NvoXU+dIe3AHGgIMAbGlVf1w?=
 =?us-ascii?Q?VBOD2AfkOncD1DSaxGxQ4S8zG5q63qI8rFngFbzo1OkJHcgoXUQy79ZTB91e?=
 =?us-ascii?Q?z83tcX721u7kpM+p+fQuHSr37SWBM2/QYwgYqAgNrxt2aSYt8k2lxUzbaDt+?=
 =?us-ascii?Q?zNlxmJxj/KvGtOQEwhNrTsdjO1vr30D+Lorrtu7I0NcEFDdoEAW4B1lNZBj/?=
 =?us-ascii?Q?Wyscrj6Wzz4i487Vd9rnh+4OkqiXjb2Nkt1lAT0+/orlGTAzvfwz11N6HjDb?=
 =?us-ascii?Q?sn/ebh9Y+lUEgJ8Jh3ZNF5LnPNj/X2BfJY9CMttocuIWeV5gCivdZukPUd5i?=
 =?us-ascii?Q?x+YPeBVsbTuDDi/h5vOw4oIhtY8JEXhRpAb5Mj9Hf3np5M8/4KBwgL30LBEI?=
 =?us-ascii?Q?rDTerZqpUn43o9GBi0mf0PHZj7v8zpX0/SvyM+p7/W2FN7FAeW9IjrN2M3pq?=
 =?us-ascii?Q?+Lsdsm51eerd7ErNqLChciogp+xEVjAg7LmOHHHxuzTnd5wNux8estUL3okB?=
 =?us-ascii?Q?K5gYQJe2TeyK3KC0wEvDWw+9P4oeNTQ5wjilA2mQtLqwBy+DpuIwEv1mTijM?=
 =?us-ascii?Q?6F4hfGY1BOJT6eXTPtUJetw3upbECPxJq3HfVvLo7yXUFgD9iAXtJdMBGrFF?=
 =?us-ascii?Q?KTIjTWrJu17lwlQY6tkeLvnxJPfvJ2Is7mD4IM1VoDTBeAIxe+PCJAALnmWw?=
 =?us-ascii?Q?9KXxVaSoljUTNsB/Uehj0w/5HysOJcXRfnfxDI9HTMtnzqmOqyZqApTuKoer?=
 =?us-ascii?Q?GRGJCX75aBNBS83/IScOVx3TSunEI+l86lWWS1y3kAXJGqDwyyJ7gEf5mlhg?=
 =?us-ascii?Q?UsmcCZe0nhsej8i/LC64vhXYETRYsxOs8nopwkJ2rIPB6zf/xkkrjgEKTF2z?=
 =?us-ascii?Q?gaMv1RD1OgZzgA7OVDtL3unQhMPnu17cFUONDh/2DknwFiMzhyLsDtv3uN5/?=
 =?us-ascii?Q?8d0/GuM1AlH/jPxwI44Up5GFBfRIC3QXc3yyavaRXiYs02v+MMD89QdO6mxD?=
 =?us-ascii?Q?2SOCpLeCjL24DkkjTN1OrI38FeIv7MHENneXJ9zVfguEPZlHCcpBX2BNZjoS?=
 =?us-ascii?Q?cwKdqqIyiDRzZWEGENNaj8KSMf7Bt0uXt9WElxwiWMT0xnV6JhRlRD3LY87w?=
 =?us-ascii?Q?afiud8PuB75OeNQw2m8YkGNYxwX3NqU07/WPrhCq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1076614a-88df-4768-956b-08dbba01eba2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 17:49:21.5549 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60f7Zv7Peqganu8t0TgGSymrdrDa+Arp8dNEdDEJgld958fMJtSuWyYaOEk+IAVe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
Received-SPF: softfail client-ip=2a01:111:f400:fe59::61f;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 20, 2023 at 07:37:53PM +0200, Eric Auger wrote:

> >> qemu will typically not be able to
> >> self-open /dev/iommufd as it is root-only.
> >
> > I don't understand, we open multiple fds to KVM devices. This is the
> > same.
> Actually qemu opens the /dev/iommu in case no fd is passed along with
> the iommufd object. This is done in
> [PATCH v1 16/22] backends/iommufd: Introduce the iommufd object, in
> 
> iommufd_backend_connect(). I don't understand either.

The char dev node is root only so this automatic behvaior is fine
but not useful if qmeu is running in a sandbox.

I'm not sure what "multiple fds to KVM devices" means, I don't know
anything about kvm devices..

The iommufd design requires one open of the /dev/iommu to be shared
across all the vfios.

Jason

