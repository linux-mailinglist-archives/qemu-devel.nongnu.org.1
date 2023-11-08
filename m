Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D247E5891
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 15:21:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0jP1-0001DV-T7; Wed, 08 Nov 2023 09:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r0jOz-0001D0-Oc
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:19:29 -0500
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::61b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r0jOx-00038A-E5
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 09:19:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOa6vM1jJL01chMWW8PLIJGkNhCNLRuj7u0ahnRIB3oI5zElKVBRMVyTxFEGuOYamyiAIiBRWyetjutYHZ3Q11HvonSz6a32Ecrbe/KLpZv5NRSXh6N394j39CKQzmNcd2S1PzngLbxx/EWHOa1bV+eaV1fyjt+jylcvv8q+4gmbfTlpEH1HYsD+wQjaJMufX9aWh680pNBl43X9Z8x+pE38jekpxRCvQG8p7BvK6hjerD48HChDTKVVlrGNGWLSwrZcHgHXHfL5RsCunjhFx3TlBeyZmRNuA/2Uok5fBjGFJVM1u9zOnUAJ4o/Gd68HNW7jsUet+yx+ujbHlADcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9ktPkuPWyO5UhBdJJkNgxrPOFxgS83uLsw7nqMHIVM=;
 b=GNuLW7Dpnon7dv7EkgzFffF+exIYuPT0HjXYzIsH5GxYz25C/10o6RfKQmQqJddwtFlPK6OM/mbxzdnoyfMTb6zs3Swdd+BOtDqBQ+OzruErt3MfgyOdkj1JLUvkOdUWcMCiIaCxePJVOQPieM0paV43HHNZ2VS8n09mGL+tvJRdYzRq0DoOd7QH2SDu83D1HOjyOfluA0MBG0dlnd/UZLxgSyfKdQ8duwra1AUXOaLx0JZ2dREGAg9ylowVhZgI/H1QvrOSKHJzurK5KEQ75ed0nZSRDpK6QwYrBpZXJRuyXtwtQNGELt+TWG4/cPCpmyUrndeXwfNBVhogJiBy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9ktPkuPWyO5UhBdJJkNgxrPOFxgS83uLsw7nqMHIVM=;
 b=hPV4Z8R4hoDyqZEpGegC66LXuF6Kseh7WGmRQcYtqQW3Lk1zan9NjYJ8F95nL5B4RAS+rVuvbe1Cbz7X/1UyKAhQfwxAl05yaIrZxdXogHn5RhyLMNwvmHsQ8h2mcYOgmQTEuOqpu0H0pPNTAqlSPI9nqCHxhHlmcuAb1XgRIIxgdMMLxtT+pitGFLegIGm4eNFUos8b21VAN9uUjDMuoOALIajA2oyrrfpL7zJI0ipzCu3Oqu5iwtl67+jDMuT6y1+lN/+L0l72QlxTGdHGq0x9d4fd85ZDMFeSDQRQz5CKAuidaPIOrlsz5h/jNCjXAadGzeXMdHhUDrC6QDU3AA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 14:19:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 14:19:22 +0000
Date: Wed, 8 Nov 2023 10:19:20 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
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
Message-ID: <20231108141920.GT4488@nvidia.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <SJ0PR11MB674482451CB0D2A7BB4DC20292A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB674482451CB0D2A7BB4DC20292A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA9PR13CA0065.namprd13.prod.outlook.com
 (2603:10b6:806:23::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 68303495-b52e-4f01-aedf-08dbe065b409
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1dVqsxYeo9iRO1KrkZsuaO0SWFWbVRR4IPgdoOBFotpYU3s3XV+/pZUJo0jwfyOuDITeHKEeLQEmi5rOPRSnlO/ms378hcklFI82sH6BvTxJ/fQ9tmj6c4yqAdU0KGhaceKkoMqlqvsRQZqL98UXyCGVQZR5P+eI5acEfGeb7ncsIdZhfDor8y1+T0e40almwtVxgT1oWKV1oJ9Je9qHZsErPbKNK6uUXu1Gx3qsJHnaLHaLYwt293hKCML4DR+i7wVfL7+9ay2PcXv+jZ58qT1IGo4ybd02mapBCx4QEi00fIIZ2vhSSrhq8HzI/n/5WrhszCs3QUIV8qkz8yIzSSmZBVRZuvgYcW2W7fMeIJCcFb9/HEFK2K5N0I/NQO6TkmWa513Tpt4bSTp3ZcoOShNKuUrGUkDos9Ee/2PVStl+JMu1h+dnvbEj3j3z52zXeHdkmRo4Mdxdf2u+QUREwYjlmcwitDr1w/6YyiqviljmUUr2uwGqQfRNXv+GUMAcmCwcBv3FM38IBjn3YIaRmpJxIKKCiyNL89HGxSq+BxQyj+oZ3BAYebtBij5DnMV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(136003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6506007)(2616005)(6512007)(6486002)(478600001)(83380400001)(4744005)(1076003)(26005)(2906002)(54906003)(5660300002)(66946007)(66556008)(7416002)(41300700001)(66476007)(8676002)(4326008)(6916009)(8936002)(316002)(38100700002)(33656002)(36756003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HV9yGtcyBnWiOIPh5oyqsg1C6ihRIglnnbyFqIeDu/MPdhojrnkDOuh3p6MQ?=
 =?us-ascii?Q?I4UZ04vqjWc6/4AJ4knkHg6dyxij0+bd3iaUqMTEqE4oCdi1fVr060tg3cJj?=
 =?us-ascii?Q?3oKMXr8lE8jZj+u40evMwmlEW/IMomouUdneQz2OnLngV4cyI5zq92XsjX9Q?=
 =?us-ascii?Q?R/r5di0IDtqckjKxTboCwMi+LQ4ZBkNFnCmNHwBTtvxBRL8cfFq9L7VzWeni?=
 =?us-ascii?Q?zJUMPppowOCtp6UvVloxPj5b2OUtfkCNKUMwr9iV5VMd/ElnM74ecF9pDTs0?=
 =?us-ascii?Q?yEhxwo5wfrz5qW+oFelOHqSjjB/y5RAIK8uZ3hUTRiz3Ga15F0D7qNWgsI2x?=
 =?us-ascii?Q?Xmtj8n8S4WD2wOgGM5vpByl2Wuv2RHPisHGETRssIjks96ZO8afHFrOONbxO?=
 =?us-ascii?Q?q93STsBFTALL2VU9dqTZZLPgWSoS4MMetiblK7m3ELM6jyFxSA5LB583CUfx?=
 =?us-ascii?Q?54uKKg6oLWOWOl+SgP/o6BxyC2pjsOt6YRVADnBv17fx+35Pkp4pM4WOQJUT?=
 =?us-ascii?Q?wpU1eXmANbop1kKRy0dW1+5+3hc/tHrBpWv0AJzzVOY3AbR8pIkB9RVD/7po?=
 =?us-ascii?Q?B2INhFqFV4UhC9ns1FU29KUbn4FEJ3aBymV2wXrcglVzIET53ee5j36Q7tv5?=
 =?us-ascii?Q?PB2TXiFMr7Y0dNPnj/snG1ZTNSFgGOjjPZ9MHRLafqhAR4EceyEjWsBseg+Q?=
 =?us-ascii?Q?edPSdo6pHcmqo9ArtJErrCXZK0/KTcphu04thmtgdxum6BTre3WTzW3QA9xa?=
 =?us-ascii?Q?nAL1AJXFCgEHatAeEDIin9SbTJFQNcqUyggVI7j+QVM+3hkDSDUOfe1eg8dc?=
 =?us-ascii?Q?UACgCcZLtpdRCdw39WhWxEhdDuE7FQhsb5ePZSL8/7sLw3M4VX8oZbvvgbWX?=
 =?us-ascii?Q?JPvRlAaA1LAt+N8cIh9Lv1MCnH+VuEQst8fBBVuh9xaTQ2beOJNAhlNUR8Eg?=
 =?us-ascii?Q?iej2ibuRuyzHRDB0PuKFONo2RBbK28DcUYokukybL4xA+VXJcVVnj/cV/eU7?=
 =?us-ascii?Q?6dpCsIIFk/P6Q4oqkMdpeZaitFnTE4A2r1f/UtsG7B+ydZHJUAcKB34T4F98?=
 =?us-ascii?Q?BwBe6IRH8cr9Fq0SB+c6eXxOjJeNLtkyLbQFkZX/koeqMx8dkGZA2gIuqo2b?=
 =?us-ascii?Q?zUZOoSzZr6BC3zhAAE6ZaOMl8IK+2Q85hVnf+lpHWgYYe+Vfudj7Qhdo3jNZ?=
 =?us-ascii?Q?uHJSvUZ0Arf3Hcl51xuQg9zPvS5Y/QwY3hd1uiBkBOx9PDuzEP8vf3W1Hilm?=
 =?us-ascii?Q?QFLwtrJFEp1YGG7LDFDww8NWeOVTTKvtCsnhM35HHXFMTfhz4kXOchpG1Nh+?=
 =?us-ascii?Q?bvJNAzuaxPxM572sDli+ScnMgthB301P6L1lc29oV0EFub5o20xZt5DHNbzt?=
 =?us-ascii?Q?zzIAY6rUFIxv5n99Uh3u3uZo75Lvu8HQ/kLLGcQQrCS47KXreeHbSZofh4vG?=
 =?us-ascii?Q?6rC4aLQPbLcu9S+dc65lH//q0UTkRlLeCwIZRjHoBaY6fhnvI3JVHuauOJds?=
 =?us-ascii?Q?xC9BdPIZVhJ8xteec3pIvSYzW+8SqZpeFAkl4AEhVcw2a4Od5MTdpYR2tVeW?=
 =?us-ascii?Q?pMdtrnidMHU3tDNuppY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68303495-b52e-4f01-aedf-08dbe065b409
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 14:19:22.1398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rrSWZTuOtJltO8kzr6uiVtaLX5i6WxXITHHD2J0Ukq+7kFnXnn7jrNQNsP125C6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::61b;
 envelope-from=jgg@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Wed, Nov 08, 2023 at 01:25:34PM +0000, Duan, Zhenzhong wrote:

> >I was expecting that hwpt manipulation would be done exclusively
> >inside the device-specific vIOMMU userspace driver. Generic code paths
> >that don't have that knowledge should use the IOAS for everything
> 
> Yes, this way we don't need to distinguish between mdev and real device,
> just attach to IOAS. But lose the benefit that same hwpt could be passed
> into vIOMMU to be used as S2 hwpt in nesting.

If you have a nesting capable vIOMMU driver then it should be
creating the HWPTs and managing them in its layer. Maybe the core code
provides some helpers.

Obviously you can't link a mdev to a nesting vIOMMU driver in the
first place. Mdev should be connected to a different IOMMU driver that
doesn't use HWPT at all.

I think it will make alot of trouble to put the hwpt in the wrong
layer as there shouldn't really be much generic code touching it.

Jason

