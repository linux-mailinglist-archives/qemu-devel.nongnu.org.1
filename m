Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5234573E4ED
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:25:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDp1J-0006Ee-E1; Mon, 26 Jun 2023 12:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qDp1G-0006C3-GP
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:24:50 -0400
Received: from mail-mw2nam12on2078.outbound.protection.outlook.com
 ([40.107.244.78] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qDp1E-0005Lh-C4
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 12:24:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCxMdKKCbf2Jmcq9MWEdwOeDgJVjTWNM4Rrkv3fo5VLX0ZwREXNjyqsCK86oV7aFo1xxS5pkUdO3ojUestn+TnXjHfmLuGM/Oca45MfTtWZ9IXXTOZrAWrZDB46OG2QJDwV/MUBbnaCgg2AMdzPWkucuACdujXyXMfN4nhPlfYnc2LgyNywtj+GbMJ4UK4FJ1NrSuWtDHD8M6OXMRWpzM4eja3gEYl8uJr59j9qHv6OJrWGshJ0QuBfn+sesSGRzjBlSjLR2ZVSQLwsxdRj1jLbcAFTIkwgexHzxm295V5VSCXqzbMcQx0EAS4LwOwea1GCPnPphvmHuH5BHRqsXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDtRvRE2AigVk5At0ejVWaJljANGoOOTCYk38oz8P3o=;
 b=YPeI0SrHZbXHuRSd5vc2EZevM53R5WJqws9i8IAnVc/CpVPdtbQpngTZiCu+eqh1+tA9BWnUUGd+zBT9x4Jym//YahVGeI0RaXTfloDc+nFk/cBqAouTHaY59H8PCE+j5On3Lf6yc9nUQyX1rV7qz0B3PVa8w2v3a+B+NJLDoo8N0cB7acmeoKhqb7B4ymHK0r2EAbk0ah1ilyhva9kipGtU7kbjEGiHZmKmLYEsQV3x/l15bjLVwkPQepqcsGLZkwh5DPVr2xEUZpxQAo+s10j08xepPXZZnno1KEnJCpptJhCFokXFqR2Mj2sgNyqJ61FnWiazOIriB6i+xiKJRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDtRvRE2AigVk5At0ejVWaJljANGoOOTCYk38oz8P3o=;
 b=d1ruGdvMmQgpW+wWX5mhrZji2ejUpgvN903WdOLL5/Z34kwvf7GmSnrHj+lEHgui10fFgInKWNFTQByD9Q6gxoDtvBSFCoCx1YPPXb16HvzOoMuxwqWyikZYy2ovdK0qaRYif+qT9tx0C7kRRMvyCxNHvbJudN32F5/RNKtrKY5OaKw8RpQ8aZZxs3IxNNbnYoUH2iYIGVUO/JYbYwixgGt4TjjrRnJEOCB6O1YNtuidWfBIzhAk4GoemDqmke8ccFmghaID4NguqVLAGfHFyh3AoDA6gWYjQQrEA+fhVP/7uxnidL1CCbV6DxS88NaWZ7ss1tl7d4oBVx0pOG40PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5277.namprd12.prod.outlook.com (2603:10b6:5:390::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 16:19:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6521.024; Mon, 26 Jun 2023
 16:19:40 +0000
Date: Mon, 26 Jun 2023 13:19:38 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] vfio/migration: Make VFIO migration non-experimental
Message-ID: <ZJm6mqJeYS7qMAWR@nvidia.com>
References: <20230626082353.18535-1-avihaih@nvidia.com>
 <20230626082353.18535-4-avihaih@nvidia.com>
 <cd94caa3-cb16-f44e-6ffc-2e8fc37e9441@redhat.com>
 <62b1ce2a-8191-fc6b-c7b7-e4c787deacf5@oracle.com>
 <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78ef9a6d-25ac-e0ac-ca52-5a0673df661e@redhat.com>
X-ClientProxiedBy: BL1PR13CA0207.namprd13.prod.outlook.com
 (2603:10b6:208:2be::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5277:EE_
X-MS-Office365-Filtering-Correlation-Id: e91f30f5-b340-4797-8166-08db766124ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erbn/lYuB5fFgBezxEKTOQRlQuXfSVD7FkFLN0FhJz99uNL/fzhv2+Wkhyvz2qYCkDDmkoHqY3EkXYoeCK8v+Xoud7/tewmnjXf6W9AkRCO1IDcKmc0jwZrHSqXTc7QCSpUEehkR5VoajfQrG9KrdFHXxO+ktkYzVN+H5+Bu1VL7wqQ8unmKRQRjdF+8B+VKkdxWHAZE2QqNNPzUDyNN8VS+RRr2mdYYzqeRvmkpCNYXm10sGIvL1rWwZSLw+g/5r7S7pC7pDj1Lc2x5AKebYUoJw7x8EXbcoh5zC9RjDCbDWAZDMoIlLgXXckMXkPl/5C3iGBc+PC/ju/xLXqupYcvf8ChKr/5UV76FaNoGQO3iyX2uXT1rN1tDjgot84OfH+ARCiokVibx+nBKLNrU+97tJxglqFtOWbnwAdgKiSarl6Bl5iHQqVvQdIl7ofHf2y6e/jv4EVpYH2KxRscdVnD3+jzTod/lRgajQPtoTSWznfyXWJnWC8hMIdnWBYdsG6CuYUyffi/NM+2MWZCM+yh+IsoMMAxvUieIzuFApXZbBEWMhet7WJiIHMzNOstE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(6512007)(66556008)(6916009)(66946007)(66476007)(4326008)(316002)(478600001)(8936002)(36756003)(8676002)(5660300002)(2906002)(4744005)(86362001)(54906003)(41300700001)(6486002)(186003)(6506007)(26005)(38100700002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWhUNVZWMHNBL0hMR2ZKRzBpb0d4TU56Njk2SC8vWW9TeG9zSXk4VDlOU1FU?=
 =?utf-8?B?SU41TGs1bjBFbWN1VU9mUzhXaHdONG4ydUlsOWMyb29XMVIzM1FJU3R1cjZK?=
 =?utf-8?B?eEZpTUw5Y1JSWkVkOGwvKytiTHMrd3B1ZG5zU0pnR2I4dWx0eVVWNVRYSHJX?=
 =?utf-8?B?LzNidkxBUkExWmdNSnNldnFzTFhLQTNyWVgxblY1aGladUYwU3MrWkx0YUdj?=
 =?utf-8?B?NU5EUkVOZlBhL0ZjcWxsMk02MTE0WDd0V01lTE92WVM4N0lXZm96YzVTbmsy?=
 =?utf-8?B?ZzUyZ1JSRk5xS3VtRWRJU29CK0F0MmREMjBvanNqUHpzR2FYZm5XbnN5Yzls?=
 =?utf-8?B?UXJWcTBCc0VHVExJWW1WN1ZGcisrdHdXdlJLWkxPYTdSTVREaGlUb1E0MWdQ?=
 =?utf-8?B?bU1VRFZmTFpuUUM2d0JQaW5kTktKeDJOelk5M2twMnV2eTFBZVM0bWxlREJu?=
 =?utf-8?B?RnN1cDRURDVkSHpFZ05sSG9TV3RMbW1MQkhXd0h3TmZtU3RzeTN1TmdQVU5t?=
 =?utf-8?B?VVFFa04waDY1aDEvanRHVWtvVjlmSk9uVVhiVkUzVW9SSzNmSTI5elp2OUJG?=
 =?utf-8?B?dm5WdkIrV2w3U1ZmRmlYTFl5RlRCSjNXazJGQjZnWVNIbDZuZVlldERYY2tW?=
 =?utf-8?B?TEhyZUpjeTd6WURTWGtISldoN3daRGxseGQ5SlkxZ1B5dmtqWnV0MUhQSEFp?=
 =?utf-8?B?N2s5ZmpOSCtoUG4yVHZ5UjJWUzh3cWwvYUZrbkJ6amhXVGpyK05jcFNtWThU?=
 =?utf-8?B?bDNGOG05WE9aMmlyV1Q1MlVRYVFab2haanZzdGZwd3NBcjMvc05IWG43c0hI?=
 =?utf-8?B?SVNaajRkUWFxQmRJSUJjYURVM0JOT1ZuWmhhbFh2a2U1Zko3ai9zbXVRd2Zz?=
 =?utf-8?B?ZkxIaWV0cWkxSXFodlNxRlRkclFrVUZ4THBPYmtqZi91Qm8vd1lhUVhDUHJ3?=
 =?utf-8?B?WVZzcTkvV1hmSnZsbzh3ek1UQzRoYnJIQ3YwdVloQW14M3AwQWNTemFkdVU1?=
 =?utf-8?B?b2U1UTF6RnVhb3FWRHlvM3NXeGUzUk1Md2d0Q3JsY0IrVjlHV1dNVXIwVXFE?=
 =?utf-8?B?WEltOVVFZGpyNi9SbTJubzdiNTkrcnorc3FZenQ5QkxiTlJzb3R2bzJCZGRr?=
 =?utf-8?B?OFV0MTd4bDFJRTZ0eVRVQ0ZMckdWanJ5c3hsZmVPOGVrRjUrR0poNWZ2SHg3?=
 =?utf-8?B?ZmNEcWtGRyszQjA3d0o3a0MveUp3ME0rbUFKbkp2SlBPSnZ2VWFHMis1UldH?=
 =?utf-8?B?MXhTQkl2MHl1M1hObzhxd2dqL2d5RU5mOGdpQ2NQOWEvMThoZFprRUJEMkxt?=
 =?utf-8?B?RzEvUk1qQXpMUWY3TVNOQmpseU5LVjVIY0F3YzFYeWg3N3A0V2YvTThqZVox?=
 =?utf-8?B?OWt3UVFlMytVNjRnYTdOQ2xpbWV3RG8rZ2t5RytwUTZYeVozVEUzeEFFR2h1?=
 =?utf-8?B?ektPV2ZPaWxleVFZTUI0Ry92cVVOWjFoamV6RXo4T2VweVJ5YjFISStFbUJ6?=
 =?utf-8?B?TENkUnhVOHBJbVYwWXV4L1FucnV1dkpuVlNyQ29KMHo3VkJ4a3RWTGNBRXh5?=
 =?utf-8?B?ZWw4d1JWOUdHc1o1dGgvSm5yR1RqMTltTjNRd1NwYzhwQVoyUmhJRStKdTQ2?=
 =?utf-8?B?TjVnUm9XQmwrMkoxTnRzLzZpOFdRZmxZcU5Tb0gvd1krWmZyVVZOQ3B1T1lS?=
 =?utf-8?B?NEN1ZUVaUjd1N0N4VE9qU2JtMEZBNU5nNzk0MER6WisvcUZJMm9icHhHQ2ti?=
 =?utf-8?B?bWdkNGtJRFNNOVJUWS9xT1FIR1diSmFkU3dwS0dYK2NudksxSFRGZExrWTEr?=
 =?utf-8?B?S1hWZmJRMWFuODFqQWE2Q1lRNk00MlFtS0JDOEwvS0c2Y3k0bXovc0R3T1Nt?=
 =?utf-8?B?T0hoTm1QZEZDczQ1ZVA1Ny83UThGSW9JNGxIWjFEaWhvNEFLa0J5Sk8vbWJs?=
 =?utf-8?B?YmN5OTJ3VFVhL1B6eFdyRjJhUjBZd3QxdEtEb2dKRktoVHRQLzNRZTd2RjZv?=
 =?utf-8?B?SnVTdEliVzZ4RFE1T05weEtSblI2TnRzOEhieC9YSlBQaXJKeEZITHFKUGxr?=
 =?utf-8?B?SFlhdG9nYkxtZythWUdJR2xMRUxKaExIckw4eEpsWmRCaUFXOXk3THN6RWFY?=
 =?utf-8?Q?TIxhSNJQj4xEz68aVIiVkpHmY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e91f30f5-b340-4797-8166-08db766124ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 16:19:40.3436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L60UyXISseq+A8o3XmlIuZcnV3BxhYzYmCkGopTvMR8UiykaJTUDwiYOrUUWVrOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5277
Received-SPF: softfail client-ip=40.107.244.78; envelope-from=jgg@nvidia.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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

On Mon, Jun 26, 2023 at 05:26:42PM +0200, Cédric Le Goater wrote:

> Since dirty tracking is a must-have to implement migration support
> for any existing and future VFIO PCI variant driver, anything else
> would be experimental code and we are trying to remove the flag !
> Please correct me if I am wrong.

I don't think we should call it experimental - it is like other qemu
options where we can choose to run qemu in a suboptimal way.

Jason

