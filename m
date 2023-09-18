Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CC97A5157
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiITv-0003yD-0N; Mon, 18 Sep 2023 13:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiITq-0003xu-Iu
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:56:18 -0400
Received: from mail-mw2nam04on2062c.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::62c]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qiITo-00022V-GU
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:56:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAUkhL6Rh1/RYUXXRpYADMQXWKOOJpAk2Du1Wf1ldu6UmSdfv8a+VSFtAsvsORUbXWYjrVOfhDuuBrwpugUJEuBK6dPkKwxFKVfes9pylIrS5MTvD57VWc5MN/P4tmkuEeNiNSQ9Ebt8Q7bXBQXay0/MHjYBQ4ym3YHXk0sdz4i4FZdYs8rADfSqeloADXGiC1W/n4tlen5VPFWprwv4oQBTaMhl1xq4VkEWfErPfVAM207fv2S5Q2Dp9gm4XL5xMp+ew3509/Flrfv5kAiyMO7iCH92nUn+tcGWRSy+T1XsPP8d//1qXeb99QgavOJUMChBP0bmRuqzPzhneSuPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVu+bo4RATQTHc/l7B6pBS/KwS9Qw2Af4wD4a5Qg5uY=;
 b=H19S2Cf4Cr4T6NATuiQJtUUSVApYj79lWiu1E19o1sCvd9qNEpPnAmWlaqjfqP+aUP+Jy/Q/FukepW1S8jMzSDRw/rKBNR1Eza/F1+jFK8Fr8RLg/wA4DWCmmiTtB/4gj+Iv0k+vrp6W0WY9CYSTRuz55KEtsAHFXOF15svtXfoVWNBl68UsfalghoE/KTQUsj5l3cyBm6tZam5LDkFB+gO1nYN+OdHUUjAD+3/w3S7dPV4PW4dDk6fu6lK/Y2vgbT0UlEOdsJX03ipZrGQI1F/VIKqMdR20ENHSrSuq5N+AijhmTNRIM+l48DMptE4fqakh9F6FBG3qojli9ZwZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVu+bo4RATQTHc/l7B6pBS/KwS9Qw2Af4wD4a5Qg5uY=;
 b=tOPDmLv82OELjZljbq9bSTprYXuI817P6l+ljHpgyrMxcvMyGIuPhpZSZGOv0nvn7zteIBHj9pWE7k/jKwCIX5nAM1BjDMoalhen8hG4ESu6IrHOlAgIDlzIfof/HbRqcjpuoOBxsN7WdZBQrt/AfFCwgesmVDAb7bxDiC+RJ08IcPnpG8e9l1LjVgyLj5F5q+8JiQ2JUyriE+pUOQHggP0adr8F+MRIbfP/EdG+q9cVBEVYWXovd5iFDuHGznyT1a5s7tiKKeq3xKZ/pbDmpAaUGpTFFx/LmjBQYwA+cej5GQgP7Qxd+X5w48FfECUdj3kt8vyvpNZbrIM+VA3irw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 17:56:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 17:56:12 +0000
Date: Mon, 18 Sep 2023 14:56:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 alex.williamson@redhat.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 yi.y.sun@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v1 00/22] vfio: Adopt iommufd
Message-ID: <20230918175611.GM13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <62367cc3-20e9-f533-5f74-2dc3cba702ce@redhat.com>
 <20230918115153.GA13733@nvidia.com>
 <23357353-2c20-e704-dc24-ccbac2c37f98@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23357353-2c20-e704-dc24-ccbac2c37f98@redhat.com>
X-ClientProxiedBy: BL6PEPF00016410.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 2586e5f4-1a5c-4f0a-55d1-08dbb8708ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMn77fWxxs8GhEffZZko50PlzFaVZSDgrbnL+84T+1pZxqtIM+kIIzYqGofyfZiw8+8b9sfEkrlkKlhFtxcvXaR6splXs4mkZz8nUyKQljwHmqPEmiljSSrZeztUosg4NAEvhJ9AhFuMP4DPWjvvdeuxctRTLd+LMqFXDuKq8im367ZSrR+VXblH1wmZiWJZcajahGliiB7pTdzqV6R4nrtKdAgw1eG+z4i5MtkyRSBmml41dzCgdJFlsjYuYvUG6EM2hI+faWN11JNMIR+W0agV+P02LmFNYvICGJHgYAphiiu7PxnQ8G+E3DwXtdsqGlBsj7ruR9An085zz1ZcO7vhK2uVvAZUkuwUtcTVTBdypa3306xxXt6HBcjbnXIpDh/ze1+Q9MHBlRrtUFCuGidalFZ/nfH0Fa/M/lL/gyXhOP6LmkMoH2PFZV0csNOEEM8la8YpU0vI//yMaUPIuqkOLxSWu7dlRK3xCPp961TtIxlKUGJoGWHD201E67Dozuc5lbY5x+GR1pM3v7S+1bo6+Fre68uLfJBqYsAUDFcUv57QQ0d0cEqVkOyRt9++WNMaqVVJxa3LgymxeQZKSjWfKHGE6AB6H2oEGHi8G+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(478600001)(6486002)(53546011)(6506007)(6512007)(83380400001)(66574015)(1076003)(26005)(2616005)(2906002)(7416002)(66476007)(66946007)(66556008)(6916009)(316002)(5660300002)(8676002)(4326008)(41300700001)(8936002)(86362001)(33656002)(36756003)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzFzdzNFa1l2MDNvTEw4YUd4NjF5REJwZ1FLQlhBL2RPdFFsQzIvS3BoWVJh?=
 =?utf-8?B?Mlc0Z04zbFk3Nkt5OGZkTEFGdVhVN2lvZ0RPNHFrT2tWTkpJa045aTFnSk12?=
 =?utf-8?B?Vzc2QzlBeVpITk1kOXZ3MURFTnVWYTNyUUIzOEVISy90VzNuVk93RDVxdVpL?=
 =?utf-8?B?OHowdjRKU3Z3OHVKcnZCbTE0aU15Y0VZTm9wU1BRM3MvRVdRR284REdCaDJU?=
 =?utf-8?B?M2NrWU9qb0c1SGVjTUVERStwZFUvaFpXaU5aQWp1WEFKSThsWWlaaGx6aGRL?=
 =?utf-8?B?YncyTmFDZXVtYTRlTHZOeEZTMDJhSjlmbE9zMUVpekhBYjZWaGVtY1dWeWpr?=
 =?utf-8?B?Nk5xZEE0andwbWxQY243WDBqWHVqY0pVZTVQTkZTU3c5Vlpaeit1QithQkNS?=
 =?utf-8?B?TkNQZHR5ZVRaS0RNb1hLMGNFcE5xOUh1WCtPN3h2SFlHdlFsbDhvelRwWDc0?=
 =?utf-8?B?WkltK2FnSnc5WVR0WVdjYkZqb1I1TThRSEZJUHltTmpFTHZlYTdKZDUyWWhO?=
 =?utf-8?B?OXdwT3oxSFB6LzNaMW5Mb205d3U5Z29EQ1lMODFFTU5OUlBIYU5ZN1RKS3lu?=
 =?utf-8?B?NngwMGI4eG02cmRzQ0tueTRGdFZraGI2UXQxNDlOT1ZFdGl6QlFzNXRCazBO?=
 =?utf-8?B?bWVFOUx2Y2dESjZQd09KSWZrZUJmVTQwNGhQdFVRN2NPdnpwZjhZUmlpTVVD?=
 =?utf-8?B?MnpocjVqZWNlYzNFa1FMVEhXeENFcVZjWWJoY2tNTE1aQ1dOcmxoYVMwZTZo?=
 =?utf-8?B?aERVSDhCMzlQZnpPRnhocUVRSVphS3BmT3g0dy9ZSUNrbXFPbSsxOHJFbXow?=
 =?utf-8?B?OVBBNk9TWStuanhPTEF2bkk1ZTMvNThLUkpHUUFUT3pkNDNuZmxhUkRBTFhQ?=
 =?utf-8?B?Mkd2R2VXNEpydU5rZWRJemk2MzRzR1pMY0R0dkpMclFJWWp2UnpoOW94L2dZ?=
 =?utf-8?B?MjZnejFnT3JkNlViWWVBTGxMbU40SFRHNUtZYnVmckk4blhaWElHeTdSY3I1?=
 =?utf-8?B?UzlIZmV4aVZpZXhDSzVIOVUyMXBDOFZmS3RMOWE2a0dVT3NtYVpuU3Yvemc2?=
 =?utf-8?B?Rm44cFhlSWNTSzhCeVhYeFhnTlRNQ1RWQ0JFNnBLbjdMTk44eVVndlpBU1FN?=
 =?utf-8?B?YVBINDRkYkVyRzNoaXh1VE9VRDVmMkhMd0tad0M3VDE5N0Q4TTBuelRlVHNI?=
 =?utf-8?B?bGE5dWpjbi80L3dNSWJzOHFPZkdoK2FKWk5Hc2M4U25UdFVIN3BTeC9RWUR1?=
 =?utf-8?B?emowcXR1QjVSMFlJK3FBVFpFVXl0UGlaSTU1NkxtY1duTEdESDFMMzF4bzdy?=
 =?utf-8?B?ck5mQ0RIMzdhdVZqYkhzUG0renpoK3NlSklkMVd0dW12T3N1c3BKMlNFdjhv?=
 =?utf-8?B?Y1JxVXhpcmJTN0prZXdubUozM0QwVkNGM0RlUzJPQkQ3THk0K1FSUjVQL3Rv?=
 =?utf-8?B?YitXbGJEUnRlb1EySVpSeUpoNEg0OVNGSGhoWHFTeFRoTWh2QmdmRUQrYUFl?=
 =?utf-8?B?MFUwb3N2dDRhOEJnT1JtZ1NuZGVsczY2T3cyTDF3WHZDNEwydjBWV1NGY0M4?=
 =?utf-8?B?cGh6QTJWTUpWaEhnWk5zZGRTQU91MXRJMFVtZEduNTN4RFVyd3lxM2syTVpu?=
 =?utf-8?B?MjZMWWRzV0Z2L1FJUGVIOVdaWlprcnJ0ZzBBMGh5Qjl1cU9BS3Q4alNHeHJy?=
 =?utf-8?B?NkpCUThBTGZpRy9jaU5xK1RCb2hlOGZEU3N3T0hCb0JCc2UzT3JSekZYcDRH?=
 =?utf-8?B?MHhZUXpjU3M5L3IxVDExQ0dYU2FDa2pzTWFSS2lrSWZuejNFZmQ5YVd4ZHJk?=
 =?utf-8?B?cnhlYVhnaW53UWIwSjBnVTlINm9JSzA1SThiVzI5Z1djSHkwc2x5ZmQxTVFu?=
 =?utf-8?B?WWU0QUVEcXBJOXhDR1ljY29ZZHRGT0YrTEFvbmlBY1dvNVhpL2xkUlhEV1hs?=
 =?utf-8?B?R2ZJY3dCVXdSVlVDdmhIdFE4WHdabDFYNHhNV2cybDVxOW5HellQQVBsY3BM?=
 =?utf-8?B?a0QrdTJXM21IR3dERkhDS0ZhOEVNYTVnejZCL1lscXRlbFNLd1ZCQXVqcjdQ?=
 =?utf-8?B?R2QyK1ZUNzRINjNTOHoyYU52YXdqUXFGSVYzN3NEKzF5U2NnUWxFRUV3aG1R?=
 =?utf-8?Q?wJQAeCc7Nv++hcP+bitavohAR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2586e5f4-1a5c-4f0a-55d1-08dbb8708ba0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 17:56:12.2959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogCAgDuDROBt/NwxRy+Dh0hkOCrpdvaKdnhILI+sttCC0lxUH+Xmig39psyk/qXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
Received-SPF: softfail client-ip=2a01:111:f400:7e8c::62c;
 envelope-from=jgg@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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

On Mon, Sep 18, 2023 at 02:23:48PM +0200, Cédric Le Goater wrote:
> On 9/18/23 13:51, Jason Gunthorpe wrote:
> > On Fri, Sep 15, 2023 at 02:42:48PM +0200, Cédric Le Goater wrote:
> > > On 8/30/23 12:37, Zhenzhong Duan wrote:
> > > > Hi All,
> > > > 
> > > > As the kernel side iommufd cdev and hot reset feature have been queued,
> > > > also hwpt alloc has been added in Jason's for_next branch [1], I'd like
> > > > to update a new version matching kernel side update and with rfc flag
> > > > removed. Qemu code can be found at [2], look forward more comments!
> > > 
> > > FYI, I have started cleaning up the VFIO support in QEMU PPC. First
> > > is the removal of nvlink2, which was dropped from the kernel 2.5 years
> > > ago. Next is probably removal of all the PPC bits in VFIO. Code is
> > > bitrotting and AFAICT VFIO has been broken on these platforms since
> > > 5.18 or so.
> > 
> > It was fixed since then - at least one company (not IBM) still cares
> > about vfio on ppc, though I think it is for a DPDK use case not VFIO.
> 
> Indeed.
> I just checked on a POWER9 box running a debian sid (6.4) and device
> assignment of a simple NIC (e1000e) in a ubuntu 23.04 guest worked
> correctly. Using a 6.6-rc1 on the host worked also. One improvement
> would be to reflect in the Kconfig files that CONFIG_IOMMUFD is not
> supported on PPC so that it can not be selected.

When we did this I thought there were other iommu drivers on Power
that did work with VFIO (fsl_pamu specifically), but it turns out that
ppc iommu driver doesn't support VFIO and the VFIO FSL stuff is for
ARM only.

So it could be done...

These days I believe we have the capacity to do the PPC stuff without
making it so special - it would be alot of work but the road is pretty
clear. At least if qemu wants to remove PPC VFIO support I would not
object.

Jason

