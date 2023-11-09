Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DCE7E6AE5
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14g2-0001ll-Gy; Thu, 09 Nov 2023 08:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r14fl-0001i1-Mb
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:02:14 -0500
Received: from mail-mw2nam10on2049.outbound.protection.outlook.com
 ([40.107.94.49] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1r14fg-0007xj-Lk
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 08:02:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pxdlb4timQ/GwJ37uhO6lTSe8A0mehu7JY6xZTQWXOn08aW3ZxJUCSCkQuNC7aJRNfQj9iLpVYyIclS8kDU590QiTGmrXwMcBQ7O+t65WNl09dVdhIrH6y5xEPQZ/gCMM6Nc3RJw9neBXbHtevifjCwTLnOgYecjxnqf9siRm2D0C2dIGAJuV2O0U5fwkd3gzAoA5ybPNxYnk3Xa29Y1HHS6LxtDz1Ngnbbx2uID5asOck+kg3DPbtJ5OHQnHpGNzCFE/UW5B8x+gijd1o7gFNptRqM2Cwfq2H9nFw0+taQMuOV99KIBFzO8S9s9h8YurwY/BuQewfdDu6JdJmt8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLkaJn1ITTvwp9EAGo+qeatde6TOKI/GqNBQwQu6GHw=;
 b=cQpvEW707CRlzpf35UubQSAbLFMn81D72QRcFc+AAaMFkHRrA2JVIy70TGtt02IlySKVmwoKEfKjXl37UzE+Gh8wpqkz5hpE0AlVvm1yKgGlk+meskPcxtjHqtWU3ukZroR3uWJIwr0rAb5ze/0ABFc7/XghE/AVCY+I2KyyrQ75aWwDb2gyDXG9cShqGfJ4ywzaRuZU6Llvzfwu8kK0C+5cCl8HRpI0eWRtqZ2h1stD+krdgq2q81/Ez0S8whNVs9T90EEBH6v1Rnc2LFBR7YfycNQ4AdCj9fRqvWxnSHbIVfa9jy6/I3qWbuSceXWAT+oRq9EsMSApRykLz/w65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLkaJn1ITTvwp9EAGo+qeatde6TOKI/GqNBQwQu6GHw=;
 b=PKwqt2Vx0jlVxEmknDDgr3ok/V63MqAE47TkhLM5QmKMjqPYVAnDHdOPsSQkndCyWlppN/jEAOagmovRwTXkSpPVwyS/3TB/Ce45GzEfpm4alQnTpG1XLQKPvW7/gbNa3qNSIwzO0ME8FRBaEMKCeed3exmytv6fC4dlFm0GxFE944Bdd3lqxA/ll0q6JSyO7u68xF2xpchAm2di03m5vR5JG8qGNUyjfWYQFt+5SS9jngX4C1uKrHVJj+Myapn71Xm2lAdKXKBdaz/6xCQF0TMDVWF6AnyHn8fVsWL+Qusu6IyLD3xgjRV72GyE3DMyXLI8ZitOq51EaU4TwuacuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8058.namprd12.prod.outlook.com (2603:10b6:806:348::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 12:57:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 12:57:02 +0000
Date: Thu, 9 Nov 2023 08:57:00 -0400
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
Message-ID: <20231109125700.GZ4488@nvidia.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8058:EE_
X-MS-Office365-Filtering-Correlation-Id: 948e8f81-e7ff-4124-ef41-08dbe1235e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlJst1iLYbfBPXiiFixBK4k8IQRSmgv0CQ5QlKLm3Hyx0tq+H+CW8fCdnZZqLqkwiRDDcgdNhfDWUn9wi1oRTEqhUP9vznHXRWfQnIu2bcwD9bpP4M8C6M5EyRypq6O6kkksgQA4snmP8gJMx7UYp4VGnP6qaFl0Svmt37jmQrR6Y27zi2bYf8pwPaRxt2BIJTagI6uxWbNu3R7RVJaUbEX5OnY1Hu0wj9A9b9Lry1phVZzDNttTDx5oSrtrUGKX/b8UEcFVFIRs0OEkEDbGYAc5N2+OAH21BLUSmYnCfX5rBu9672axLSMUCd2gdMOYr6ieQfBOaNdwVAoq7kvCMZ/a3JZILzU5PINHkPDaTWXPo2UgSo04iyAGzDLxNwZqm7Ht13VQNsyZrjhs8vzdWXS12TvbHq0DRxTKIRcVewZKZZE/nfvpB1EAxIDCc/m5KByhEhgv/eD1RSfmDfiISV63/If4R02JofNjYyYZZCx1JcWvxsZ5wdsQh4YkgsbLNdaERhM+0dGVFtzDzEYJe5toFsaAOCb/ZQnRmrwNPgtDAgYdwALxxrrp93lztJ2e
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6512007)(478600001)(6506007)(2616005)(6486002)(53546011)(83380400001)(26005)(2906002)(1076003)(41300700001)(7416002)(66946007)(66556008)(66476007)(54906003)(6916009)(8936002)(4326008)(8676002)(316002)(38100700002)(36756003)(33656002)(86362001)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zfAvtYjvPxfpxcvXmm37/cWh05hdlbaHg//1CiVOg/KQ91IU50yfPKuZXjaz?=
 =?us-ascii?Q?iSbhBmSfoo/kAe0si2B9GW/DySR3T5agAgEoQ3/SDml2A1hXAYGPeonw379e?=
 =?us-ascii?Q?3A8g5SaGu8o8T7yNNgW0i4g8MfmERnZGJhz4ThIiLp2fQPObugL14HcCxoqm?=
 =?us-ascii?Q?/TIXehJwHXH9aHrTHCnRMOf5CIThASpRVEjUuNZJKmvj+1vRgjgh0GSby31t?=
 =?us-ascii?Q?iaI72WWdi5JtwxTGdhj50pA8l8UEjpS//hXvL75la5+DsvUreq+gIZy/W3cu?=
 =?us-ascii?Q?sWnulldKOuG23vNmud0ULQr6yIW2AMVbg1wkJbxOg21CvpaaaIoWpGCa2RF4?=
 =?us-ascii?Q?4pNMAdk/kaVHtD8/mLDmngj4asRlzHUAvyHZosnewXVewlhgKl065mnGfza9?=
 =?us-ascii?Q?xWLmZM6iJID5R9XX+6kRuzS3bMeEmwjyT3WMfFtp67nDEfyyaa1rDsVt2Ecv?=
 =?us-ascii?Q?EY8LnA707ChnlkYkjgdbOpLLyoPaOSSe/1L2/5k/TJSY9mtYmheh1EBE4bjW?=
 =?us-ascii?Q?mVxnqhKyWARzbSm4aLb+Yqa/kKI3imtL7iz6CGbtv2TpGO0liOR34gW59xvZ?=
 =?us-ascii?Q?Uq66PbjIK0YDj9HJovNbeZ5aR3cwu6ozIB+FufmfxYTGZfG2C6jg38B6NrIx?=
 =?us-ascii?Q?2dzFzIYzhkc+ve7uqvmDIAIcH+qklVsYljkIPT+y3+pyo0989zkIw26NMnSH?=
 =?us-ascii?Q?xAEfFJuHT544xyI3+stOEskKO+U6UYFxvy0P4UHFj3OhKfluGoNTg8J1TbsB?=
 =?us-ascii?Q?ywnyeRpTl+iwAAQUwWp+CqlnI9UCF799otdthrySpnBbfKMf4V56pHV6KRtv?=
 =?us-ascii?Q?t4RwNmZzxJ2RjUQIFcsXDK/m2P0ZvaUcIOsL4B2EgfyalYeoBNIvqPCFY/TN?=
 =?us-ascii?Q?FPls/Jt4zHERzzVEMUScQ6FXtif6IWtu0v32P5+ofyUHxoP+zTlmQ9Ynp+3C?=
 =?us-ascii?Q?PmkkC3LQBaSQeWOij3uHGGFH59R0j9vsIfcw4p3Ifgos3jF+n7yAlPvkkvSx?=
 =?us-ascii?Q?DXXc4yGaf8dhO0IgMn06cwCHfkBraBzQnyCCf6zYUSEwgoIkahojmyzZ/YBB?=
 =?us-ascii?Q?1uk9aQRbfIhl3keNxTYk3E3K3rh0/lFjMs4IfJvIBSQtvd/YNZRDTRClPYec?=
 =?us-ascii?Q?Ylr6TKjwtVP2bf1Qkg1C3Sw+9+WBSPgxE6cbXsH7mr+GJ+OFb0pdBD4hEnaU?=
 =?us-ascii?Q?UoE8DdrVmHQ3oo/fz5o+pE8cLdpn6hYfvD88tYFA22U1AMqvAtz2AH9iSjv0?=
 =?us-ascii?Q?BGHHoTMNQCwNWxoJh9kotziV1PowfUCmCHdFaP6FLfiIZStBXnJm8GUE4dvy?=
 =?us-ascii?Q?8ys4Ta/wVAZoqQ4PcLXxlryUgrXi7fGPUbj/0H7Q18RPn68XuF1Nh+x1QO41?=
 =?us-ascii?Q?SlTltSesk0awd5KObPfRxNMBYF7mqw1Wx7p+0ob4mnCuzeA14Akk5D3Te10N?=
 =?us-ascii?Q?Mxb0UVN6qxps4akiWwMxUviDxCFJIzp1+I3hTDa6I4xcQHDcBUOwzP8x12KS?=
 =?us-ascii?Q?43Qg1QLegId9R4vAGLA13laNR3dXDuRdhBwGamTEZ6big1TQaF5/uE69UcLy?=
 =?us-ascii?Q?+YBhRsCd10eATZyY369QinE9tsvPDcC2XGi92u3b?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e8f81-e7ff-4124-ef41-08dbe1235e26
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:57:02.3827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkno0za4otIbEDQFCVeYMLG/SgPWfmw8pVKJWlaH9qXL/iz5HIgLQRxr3c3+RCWg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8058
Received-SPF: softfail client-ip=40.107.94.49; envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Thu, Nov 09, 2023 at 12:17:35PM +0000, Joao Martins wrote:
> 
> 
> On 08/11/2023 12:48, Jason Gunthorpe wrote:
> > On Wed, Nov 08, 2023 at 07:16:52AM +0000, Duan, Zhenzhong wrote:
> > 
> >>>> +    ret = iommufd_backend_alloc_hwpt(iommufd, vbasedev->devid,
> >>>> +                                     container->ioas_id, &hwpt_id);
> >>>> +
> >>>> +    if (ret) {
> >>>> +        error_setg_errno(errp, errno, "error alloc shadow hwpt");
> >>>> +        return ret;
> >>>> +    }
> >>>
> >>> The above alloc_hwpt fails for mdevs (at least, it fails for me attempting to use
> >>> iommufd backend with vfio-ccw and vfio-ap on s390).  The ioctl is failing in the
> >>> kernel because it can't find an IOMMUFD_OBJ_DEVICE.
> >>>
> >>> AFAIU that's because the mdevs are meant to instead use kernel access via
> >>> vfio_iommufd_emulated_attach_ioas, not hwpt.  That's how mdevs behave when
> >>> looking at the kernel vfio compat container.
> >>>
> >>> As a test, I was able to get vfio-ccw and vfio-ap working using the iommufd
> >>> backend by just skipping this alloc_hwpt above and instead passing container-
> >>>> ioas_id into the iommufd_cdev_attach_hwpt below.  That triggers the
> >>> vfio_iommufd_emulated_attach_ioas call in the kernel.
> >>
> >> Thanks for help test and investigation.
> >> I was only focusing on real device and missed the mdev particularity, sorry.
> >> You are right, there is no hwpt support for mdev, not even an emulated hwpt.
> >> I'll digging into this and see how to distinguish mdev with real device in
> >> this low level function.
> > 
> > I was expecting that hwpt manipulation would be done exclusively
> > inside the device-specific vIOMMU userspace driver. Generic code paths
> > that don't have that knowledge should use the IOAS for everything
> 
> I am probably late into noticing this given Zhenzhong v5; but arent' we
> forgetting the enforcing of dirty tracking in HWPT is done /via/
> ALLOC_HWPT ?

The underlying viommu driver supporting mdev cannot support dirty
tracking via the hwpt flag, so it doesn't matter.

The entire point is that a mdev doesn't have a hwpt or any of the hwpt
linked features including dirty tracking.

Jason

