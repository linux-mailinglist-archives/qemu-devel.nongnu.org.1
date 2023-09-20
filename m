Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AD67A8B5A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:13:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1hH-0007QQ-7R; Wed, 20 Sep 2023 14:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qj1hF-0007QF-1j
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:13:09 -0400
Received: from mail-mw2nam10on20627.outbound.protection.outlook.com
 ([2a01:111:f400:7e89::627]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@nvidia.com>) id 1qj1hC-0008OG-IT
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:13:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A99gOmbJTXQz9e8D4CYm03culidLQFrTC4IztGuXxXSsGUq7fED9mzglXx8xwUDn8uegueXVKEk8C71CXk0nkdfLahfDrEWH2PJdRjaqUscEFy1VgVWrn3+LmuFV29ynirwk9Yx++3S3wesS2ItXXLVN1GaCz+jMdM+6TD2KA8Bh9dMtutbkjaaQdATCh3uFavwFeq0sthogWAwFYZ6AqbXfLBiw5d9giw2XEU5wk6Q1pB9OKGWDjzBT+XYiXwX//okVgwU+MC4sBLbBdHw1hcNTRYoNGvEDxrWJ1r7vRva61kG7ai5wCjCougwS/JhTg25IM0ZBBM6pscM9LBmPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1vEoUnyjOOZIT4NzrYOBRyhC3twEHmQbPrpwHhbFdU=;
 b=K0X0EjzuxtjU+3JqgVIVXFpxbBA3fCXTh+B19piYqVxOyld3OPIXHQQvuez5EMEXefGMETD0p+WHgn3YPt+pnpnMXmn3uBLHRVemjdt6wUAdEg/3j1jlB2X+vHReRFUnCJ7Ct4y30rr8pW/5aF+D7LoACho426zBqNKVm9jp4JGgrdOt+CJ015NPQGk7blKBAPaVa+/f7lUCzr0BoC/Pmi7Kk8p2RbpxyHpOnTrbTrlkjjQejApoMi3kwYlmb3ZvsOlKXGnK+Ff/vGmc6QuYCwEA2zsiD1M0VMkyTuAEzlykQUuEYGVefulCc5jaeWLjE8JNKX0M3i0cFqA6ZUoHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1vEoUnyjOOZIT4NzrYOBRyhC3twEHmQbPrpwHhbFdU=;
 b=uHy2kBT1TPDLLjJ+DLuVsSoEl4rck2nhVznCbu3fLZDBYnCzE1TLvyKWH8gMeJzXcy8rjo4ENvxWKsoP47FZpcrqLM9ZUbeqHbDwwDFD2AnFBdsmTsESydQIJSFXtuJxYAYNYVMxPYvN1+0r774swd6VecAwTqlA9nEFWACvaNU6Wf/MnO/kj0zCuCZ7YsjlC09/4XLsXlQcVxX/CZ9aJKhKH3YhsBqlqrfSZ89CbEOrIajz8g6KjEW870zi/KhHeBfezYrd8EE4QFzlzq/uHlRFZaiptWqVZYFw4Q6qjNfTMfW/f5Dbum0yDDlenDWQW8etmzOcLcDMz0aDIDJNxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM8PR12MB5414.namprd12.prod.outlook.com (2603:10b6:8:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 18:13:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 18:13:01 +0000
Date: Wed, 20 Sep 2023 15:12:59 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laine Stump <laine@redhat.com>
Subject: Re: [PATCH v1 15/22] Add iommufd configure option
Message-ID: <20230920181259.GH13733@nvidia.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20230920120142.1a517d0c.alex.williamson@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920120142.1a517d0c.alex.williamson@redhat.com>
X-ClientProxiedBy: YT4PR01CA0339.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM8PR12MB5414:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a443a8d-51d1-4f04-33a1-08dbba0539a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UZH/iXRV9h7pdmdnXGO34bkYJVH1+R9qJhLY392ncaDbXknu8wcWq4HccJnpGc7c6n6BVa+Roa2Y8A+c+xy/DgDGCEL77tZPt/PApP9lw/jkDF6U/RR/lvS08GYcQZzrNwrFG53IL8JwhhLVe2aaHJaDH6tOciD+O23zlNPnh57nihUqd+MwaDjlKEU21xCZyizYUzn5XlFW2TcrokhlQ3gNV53AdtPZ/ZhKq5k7hIoM2kzAIMPunEfFkCXcrpuTu0HNAyxYCgl+hpj8TZuEMYN/mmA47KfGz9ss/hRrLv+nMlKiYVq7DJ3HCTQ+a4tpKsvMST0uIlP0IC2TWqRIqemfsRNpmJOjp/uFh99NpV7JeqzCO5kOUPHOmnn3CHxYxBo2yQXxWuUiu8ZdXAgamLANuq4efeMGHrYuPCLQp9uVgja1g8RWUKWBPFvO9eRT80gZokfghfSL+EXjYVHnVqkFV1NHA22YDMFH4Ewy18fgSPnf0guyOs9z+YQxxevgIO8IaUNnMoiz1hge6mSpKXjlfFoXk84gaGEeT/dYk5tvppojK6awkkIx6fCqclW7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR12MB5869.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(366004)(39860400002)(136003)(186009)(451199024)(1800799009)(83380400001)(66899024)(66946007)(38100700002)(66476007)(316002)(66556008)(54906003)(6916009)(478600001)(2906002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(86362001)(66574015)(6512007)(2616005)(7416002)(26005)(6506007)(6486002)(1076003)(36756003)(33656002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG9jbGtBZktwU2xBZW1hYlM5OVBqSXo5V2J5dUU5VFRlK1psV3RLZkxwSUZY?=
 =?utf-8?B?V2FzdGowdGUyc2FOVmZQSm12RTgwZUlLV1JmaUZYaGVVaHI3MENsNlhpS3NZ?=
 =?utf-8?B?aDZ2ekNNUzVhMTZYd1RoWEplSi85VjhCMFpPaVdWMk1XT1V0VEdINXh0MWlY?=
 =?utf-8?B?RGNvd0FIalAyeG5HRzB3WUF5bWpKN0NxQW1YZVlUWnV0akRzRFB3S3VqYloy?=
 =?utf-8?B?ZWZUcmJIUU4rS21lNktEc1UxRGZsNWsrN0Nzb2dWSFhlTmppZ2lHVnpTdnhC?=
 =?utf-8?B?Y2tSNnpTdUhIeUpHZ3VOOGRRN1FhWXpDQ2JDZDFpeElIek8zQmpTYW41NWVy?=
 =?utf-8?B?N0NMTW9haTZadytCVXdvejJWdDhObzE0VWltM1RpZmpiQ3JiL21CTGt4Q1VE?=
 =?utf-8?B?NEVvUzQwUjJrd0RURXQ0SEQ3bE00blNwZ3NTdll4S2dIMGpkSjBENXFhM1la?=
 =?utf-8?B?Z05ZMms4OFJOL0RmUHVGc3EzVjVteWhlSldxaCtqYm5VcXlZZmtlemU0dERw?=
 =?utf-8?B?eHFlM1VhWXZCcUp0RTVXaGM3bm44MTJuKzg1anRtYzFmQkc0V2xsSzBXR3lE?=
 =?utf-8?B?akRWNURoZlRaVVJZcU5Mc1cyYmRpNGU2K1NvTE5xQjc3Qk1pK3NBbExLcHlF?=
 =?utf-8?B?UFRXQlBFNStrOEFpbmc3emZKcWpsUjkxMEhJbVZlUGZPQ1JzTGhQWDQ4dkdo?=
 =?utf-8?B?QXUxbURaZlRtQU5kOVpmTzUwbmlrSWZkZHErZW1xeHFBWDhENGNUaEV3WGhV?=
 =?utf-8?B?eGlQcklQNnlnQ2RnaE5JY2c3emV1ZXlIV0tjUTljdVNaVE9ocVZFeG1UdjZI?=
 =?utf-8?B?N08wRWxxdkVNZDZySS9oaVoyOTZQVnBPWmdBYTQxeTlPaC9aQUVBQW9Yb1VW?=
 =?utf-8?B?eWxsbjFRNXA2czRTZlNHd3laZ2FHOVBqRzZuWmJvaEVFNGkvRTcySlMvOFM3?=
 =?utf-8?B?MkRxcVl4MVRkZGkxdUpzOHFNUWFISTZua3BOYzVrbGhDZFIrbWo4V2piWlho?=
 =?utf-8?B?TzlURmhIc0JMOWhoL3JwNkVzeU5wemdLNFBQZGdKL3oydDRuSWgyTFROZyt6?=
 =?utf-8?B?WSs5dk4zRkx6ck5XdFVJMFM3TWRlWWJ3R0ppdHIvak10Z2lRejFyb0thMnI3?=
 =?utf-8?B?TkZpeVhiZzRCOUE3MUEzamRxWHU5aG9NTkQ1UzBjT1pQaFRyeHdGNFJib29n?=
 =?utf-8?B?WDlmYmR5S0Jpa1JRTHllQ0FuS01USFZnS3UzUU8zRG9ETHo4Sm9ZS2dqNzJw?=
 =?utf-8?B?VWhyOGk5cUJ4T0NkYTFsa0NrcndVSHdvM2s1cENQNDcyeDc1UStuQ3dUWkpU?=
 =?utf-8?B?Q09aZy9EZEdSSVEyQnpUSnQvN2tZV0I2WjhiV0NMUkl3RXB2WUlyQ1VydXRY?=
 =?utf-8?B?WWRRSXRtTk02SUh6OWFhVVZrenBqaDhMczhuSVBSN1hud1pWVC9nMjNUcnZ5?=
 =?utf-8?B?aGQ4VzZhMDVUa1g5UmYwL09ocXpzd0s1bm1PM3FiL3lvZitHbXZmR21OOTJR?=
 =?utf-8?B?L2tnTFhNMERGL2ZHOWhqN1kzR2p3WjF4a2JpZ0RkOUVlTUhGZ1FzWnd6UEtU?=
 =?utf-8?B?bENDRTFscmUrakIvTDBwVHgwTFpkN016emxKN1lRMEpPeGI4aUEvUW5aRFRm?=
 =?utf-8?B?aTJ5V0tLTmYvK0FDWlR6SGR4ZUp4Y3NoSHB1OE5IcmxSQnQxUHpEVy91eEQ1?=
 =?utf-8?B?OWhWVlZySUEzR3pXcUZIMUdFRzJCT0ZrbDAxeVc4UFIyZ1lMVEZUNjI4YWVS?=
 =?utf-8?B?U2hLYzE5Um9iNG9wMHpnNE1ZVlJCdEYzSzFlVEJsUFYwaDBodUVGYWcwRWNo?=
 =?utf-8?B?UHVTYlpIMjFNZkxYdFQ3TGhIMGZKa1J3bkJkcVROY1NGM25QMG9QREpjWE9Z?=
 =?utf-8?B?eGsvMUtvVmd0dHZJNHplL0dPTzhCUGtTb1k3T1IybHVDMnBuUnlsNDcyRDQy?=
 =?utf-8?B?MVY1citJRW5GZyttTW9BazRHaGlqZHV4aHZhbWhFcEluanR1dnhRdWx6OGd0?=
 =?utf-8?B?L0R0YzBDeVNOMjZIMy9jUW9UMTM3WkFmcGNIMmFyTzFzSWN4Q2pzNitma2tk?=
 =?utf-8?B?SXhOOWMxNDNJdHJZRmwzY0ExeDh2dVpBS1U0b1M5YVBHeHMvOFh6ZFkxYjBh?=
 =?utf-8?Q?tVXNBoZ5jfU2G6IC0q8vc5xPc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a443a8d-51d1-4f04-33a1-08dbba0539a3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 18:13:01.1642 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePz8ual9N7kGajPkEQiMX3elAyYyCuylWgIwum+blNOqINDKLbqqPrh63Pe++p0x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5414
Received-SPF: softfail client-ip=2a01:111:f400:7e89::627;
 envelope-from=jgg@nvidia.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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

On Wed, Sep 20, 2023 at 12:01:42PM -0600, Alex Williamson wrote:
> On Wed, 20 Sep 2023 03:42:20 +0000
> "Duan, Zhenzhong" <zhenzhong.duan@intel.com> wrote:
> 
> > >-----Original Message-----
> > >From: Cédric Le Goater <clg@redhat.com>
> > >Sent: Wednesday, September 20, 2023 1:08 AM
> > >Subject: Re: [PATCH v1 15/22] Add iommufd configure option
> > >
> > >On 8/30/23 12:37, Zhenzhong Duan wrote:  
> > >> This adds "--enable-iommufd/--disable-iommufd" to enable or disable
> > >> iommufd support, enabled by default.  
> > >
> > >Why would someone want to disable support at compile time ? It might  
> > 
> > For those users who only want to support legacy container feature?
> > Let me know if you still prefer to drop this patch, I'm fine with that.
> > 
> > >have been useful for dev but now QEMU should self-adjust at runtime
> > >depending only on the host capabilities AFAIUI. Am I missing something ?  
> > 
> > IOMMUFD doesn't support all features of legacy container, so QEMU
> > doesn't self-adjust at runtime by checking if host supports IOMMUFD.
> > We need to specify it explicitly to use IOMMUFD as below:
> > 
> >     -object iommufd,id=iommufd0
> >     -device vfio-pci,host=0000:02:00.0,iommufd=iommufd0
> 
> There's an important point here that maybe we've let slip for too long.
> Laine had asked in an internal forum whether the switch to IOMMUFD was
> visible to the guest.  I replied that it wasn't, but this note about
> IOMMUFD vs container features jogged my memory that I think we still
> lack p2p support with IOMMUFD, ie. IOMMU mapping of device MMIO.  It
> seemed like there was something else too, but I don't recall without
> some research.

I think p2p is the only guest visible one.

I still expect to solve it :\

> Ideally we'd have feature parity and libvirt could simply use the
> native IOMMUFD interface whenever both the kernel and QEMU support it.
> 
> Without that parity, when does libvirt decide to use IOMMUFD?
> 
> How would libvirt know if some future IOMMUFD does have parity?

At this point I think it is reasonable that iommufd is explicitly
opted into.

The next step would be automatic for single PCI device VMs (p2p is not
relavent)

The final step would be automatic if kernel supports P2P. I expect
libvirt will be able to detect this from an open'd /dev/iommu.

Jason

