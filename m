Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70227E568D
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 13:53:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0i3l-0008Lj-Cz; Wed, 08 Nov 2023 07:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r0i3i-0008Lb-T6
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 07:53:27 -0500
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com
 ([40.107.237.50] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r0i3g-00020Z-JV
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 07:53:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuNIYwx2lQmVN58mrA/QT1BAyqOypfZzba3lmkC8O5lFEMuUtZZXTfVoDOT+BBeuCWvZxHpeG0nOmJHj1OvmWewIA6fy83KFiE/XaQ1pe5MYpW5La77ROHsXMMsGjMfNPJCh5qgRQod5Df5q7snw2f8HWRZ9K+GndaxIE5Zug4zOfSRL54YeAKVP6oGIg6dBJX0MD1pk29IgY4t1UfQ0f01vG8nGFLllVKJFSR9ansoeXdCAfB71ej4o392I+66tfpcdrUN0WKuVsT+0ICJtD58KCcJDMxnYqoCZPioBycmeaJ3utVCSUaj7da3RaV0U7PFipDUAWaWl2Tky2aIl4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2yMLy+T2/ShxxNRa4s0eBsQpuGEkX92zmUfnTLerSk=;
 b=B8dU5wCOiEi7dCi7tO8nexl8Qfgeq43QqoLEbmgKuB/+wj47oR7ZDZnXV80X7bi9ugYayJaWNADvvo8vDq6seEFVSgtWvJN5BVGd4blekwdAq3ZPPRnkTEUL92Gf7QJ+IcfdjYDDkYd7xh2eP7Auj9gaFZEQqKHCUllxUNBxs19o86f6SqmuWTHImzbB6RQOg1FrTR3nLZkhuMlLbKnj5mt9sHyqxLldpW7QaCIVb+azU1zVRVLyUG9Upho9f4KifxIMtGa/SGd4mBzMiXSbnqQS9F+tc4fhkVc4WfkUlf1IYAwkcg3LDXhEbUmm69j4t5ZM6XmhPwZ5ct7CK1E24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2yMLy+T2/ShxxNRa4s0eBsQpuGEkX92zmUfnTLerSk=;
 b=iHDWdj0ZnNUHzh0dF4LNFL4BP57C9Lc9G8vz2InPwlokk+QLvwcRHDEnbuEvlCcPSfqD6UotZS/PP9oXGpgn3h8fiI8jOcjbhRKwmuGeT8APS2wv+v/uaGd0I5Ia5JPcmFsHx2lPPV2In8BNQ8/veKoZ5c1OunmYzYcvEXnBeeyV20nic+Knl9ty4j+omDTlDJ9kmJEYqM+pdiL31THmwhG3W3BRlQurppTqMubDrsMOOrjGnyGSkbyeLI/XktRMNdr4wDxLReigCuvV1VBug7eG4od4SLHr1ml0QGmf/kJdZGlJdCvdV8OuIaBdUGA0pOO+/FSFU1rSDNzUiO+Vkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Wed, 8 Nov
 2023 12:48:19 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 12:48:19 +0000
Date: Wed, 8 Nov 2023 08:48:17 -0400
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
Message-ID: <20231108124817.GS4488@nvidia.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
X-ClientProxiedBy: DS7PR05CA0053.namprd05.prod.outlook.com
 (2603:10b6:8:2f::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d4fa84-d629-4966-4575-08dbe058fc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2d2MBk9m/nW4zQT9GMdcLiE/f6VoxpWfIp1y8xjs/X9VIoiqY5kG9WW8buKuT90lQDtIvLIv/9/5s/4jtMhRVUVb8IJZ5Q1xmHrPxp2nnb+MMoKs35xc1qHk5gdBhm8onzjmt0jaSAYy+OSZwsv1Eky7pzJbdCGLO4USzKmEkZ+Roq9Sm81XlaxgzKV7XwtV092/tqfj0vbGkOz1XGpjv4cZpKSYWFeyAtSpVxa9LNNhULrB0HCp8+7L9LRK/mXXDWW9MutUMhXkANWG+EsItlX8yPWGJwSddnYS0Ek3KQ1MRLGfT6WSsKrX7oVRf3A8bu/1nzqxcxD4ROvUvPaYgS05d+QVXcnnoy3Y/UYuXwQG/XwuluJZaeOM/qbUMgkksDHDmH9huW7Yto9TdTJDMNgpQ7GA31xgtKwCy5bZltMgExQ5XwwNbQFVqKXvZuGy98q+URLLSSQdnR4CYPOgx1023f4J3Pd/2O2jjDaHd4A+sohrmIE8lFxUoD5hYlqKgmF88JNNazU/E3a21uoxG38zNbyXPg+qtiAbhQj3N7+SdmnSwKnDzj83ELzWZJH6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(7416002)(6486002)(2906002)(478600001)(5660300002)(26005)(41300700001)(38100700002)(86362001)(36756003)(6512007)(6916009)(316002)(2616005)(1076003)(33656002)(54906003)(8676002)(8936002)(4326008)(83380400001)(6506007)(66476007)(66946007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1AcqIUB2WeDF8jnP+tVcxLYs+NqgvxNUwTLyUayYSKVFNUL/5ZRgObl55j9c?=
 =?us-ascii?Q?aD795uL92OiUEfi86fHgYZI93NaR0ja/1BwglDsym2Ncs3BTIjI8X4qGF6je?=
 =?us-ascii?Q?zwg9KpMju3dubAqu3JI62QTHYNJNB75CkMNi1u6PNOGa9PWLdw9Weds+CpUZ?=
 =?us-ascii?Q?KVBIV5zKFX0WVhak6sHCAG9KBAgFcCpsdjdQCL7YJtdYGDU3Bgz7Ibsj6kk2?=
 =?us-ascii?Q?xx3OzR+s8F9zu7cq03FPWNyxQleUDe9bcb9BJBz0/FH0sDAXuAm2O03dEXwV?=
 =?us-ascii?Q?V+1+wvvfFLHpCfp+LIbgZgvpuxT5ilvhBkPZ7QxTulFRxzgPcYp2sv/n+Lvr?=
 =?us-ascii?Q?xzVnJ6Yce/PxIB4Jt2ETwY874Mmy5IAg78CLDOR6ARLdOdsV68+aiFJvgQ/b?=
 =?us-ascii?Q?/Tp2uJiu3Wi+qNzM38Xeng07PdSnuzmvDnvEfS9xEsLPGFPFgFafyec0aiTh?=
 =?us-ascii?Q?554tz5bkmmISxLNr48uGDnUZWD6kLP1fWcxAQY3MGM+wBKG5O7cEAhkEDnlK?=
 =?us-ascii?Q?fjd2TFoUykqocqyWZIHn+PdjUBtUm+i4S4u4u++SdWdFrF0BKaNLdA21nu6f?=
 =?us-ascii?Q?45cwJj8Fe5TAxApdzx7EYZbD8tHV/eihCbZzVBEVKBXNxZUQFO2ohRoLwUQ1?=
 =?us-ascii?Q?vaOs1O0+NNLq8+0qsV9jQzVoZ0DJoXTZ+ENTNfke5VVbn1wk1au7NglCEupl?=
 =?us-ascii?Q?aHL06xlaZvshG8pQnDqlKZVHhGVtdvEsX8AyQW8MGyZwg895X2C2rY97TWVt?=
 =?us-ascii?Q?CnFZBRJWsYCbo3wCG3Sw3QxysmaRF+4xOf/jB9Nqi0eecO19BK8kNbHWqEZU?=
 =?us-ascii?Q?ntOPg3pNNbQON0pf2vn+vqwwiKh+O2lxEouACwUoVrkVRguYJdCx+BMQXz5W?=
 =?us-ascii?Q?qpiy2joPr3ldqPzgJr/oTOGIamNWhaWe0UcuNmF3iPRqddS9IfUJM+kaR3za?=
 =?us-ascii?Q?O8K6zPRmg60JuQifFbR2qhZ+9JxrobXT+xh9nJHy/FMgVaZOlqiz+fjNCMln?=
 =?us-ascii?Q?Z2mlQRc6pEgCJQaI8MX31CpngvjX4+zXn4npl0I10bjIQzeCaxPUecsoKUfX?=
 =?us-ascii?Q?qkppaJz3W3/2QMsho1k2HSqv7RVblCAKf4PFbgfazjfsseDiD+Gs/4J5Brc+?=
 =?us-ascii?Q?kqGwphQAxfPi36Hl55va9ohIOh3uhxZGhVnCoWaq2JHIRCuipMLLITa1PTHm?=
 =?us-ascii?Q?KaKdoZmTW0ORb/0q1lEpqpA75Xft1B6Y0EBkqnCiv4CwyFzHDrKgu8Bx8NHa?=
 =?us-ascii?Q?405FIYL7lk0+eTV/61EF7xBZ0MrVFSl39q5axqJe8JkchhWBN22nkrJgatf7?=
 =?us-ascii?Q?sN5RvJziSjC5duuigegWE657Wge5ruJdLFhUlvFPXFjls14K1sY5n7Qqpv+j?=
 =?us-ascii?Q?6rqxopKOAD/xWnJr+7nz7Rl+cDVrhjgiVGBkr9PCYUt1Jl4YHxWwQNV9nw2H?=
 =?us-ascii?Q?fHuulTX8c9fGS84ko6auNfTcrAD8qNt3COfd9TWx2ZHcZHLGaWMitPpK8RYZ?=
 =?us-ascii?Q?d/sA5gxVM8gmFfy73l4bmlXy29GnP6sOOFZBQ3O0y/LK4vwF1Z6r057t6kt1?=
 =?us-ascii?Q?ALN/f2tPIEd9fjEEqxw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d4fa84-d629-4966-4575-08dbe058fc12
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 12:48:19.5728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UK23lBE8yEqfBUpU/KkHxavd+SelKjT1jUS7hTtIEr0HRK7De8KrZKSTDHzeTlHd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
Received-SPF: softfail client-ip=40.107.237.50; envelope-from=jgg@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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

On Wed, Nov 08, 2023 at 07:16:52AM +0000, Duan, Zhenzhong wrote:

> >> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
> >> +                                     container->ioas_id, &hwpt_id);
> >> +
> >> +    if (ret) {
> >> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
> >> +        return ret;
> >> +    }
> >
> >The above alloc_hwpt fails for mdevs (at least, it fails for me attempting to use
> >iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is failing in the
> >kernel because it can't find an IOMMUFD_OBJ_DEVICE.
> >
> >AFAIU that's because the mdevs are meant to instead use kernel access via
> >vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave when
> >looking at the kernel vfio compat container.
> >
> >As a test, I was able to get vfio-ccw and vfio-ap working using the iommufd
> >backend by just skipping this alloc_hwpt above and instead passing container-
> >>ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the
> >vfio_iommufd_emulated_attach_ioas call in the kernel.
> 
> Thanks for help test and investigation.
> I was only focusing on real device and missed the mdev particularity, sorry.
> You are right, there is no hwpt support for mdev, not even an emulated hwpt.
> I'll digging into this and see how to distinguish mdev with real device in
> this low level function.

I was expecting that hwpt manipulation would be done exclusively
inside the device-specific vIOMMU userspace driver. Generic code paths
that don't have that knowledge should use the IOAS for everything

Jason

