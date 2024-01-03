Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A32822837
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 07:05:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKuMR-0007E8-B7; Wed, 03 Jan 2024 01:04:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rKuMO-00079h-1t
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 01:04:12 -0500
Received: from mail-mw2nam12on20606.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::606]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Ray.Huang@amd.com>) id 1rKuMJ-0002KK-0M
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 01:04:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2A8HZCxZTFrJ6e3+CkxMHYb/AinLS3YUa8yfIVsz0RtyHKlmIv9LN9cxFFwUj85XZSeTZqkh6YZvrrgoebGM7ATdB0BryUsSJncv6MMKmEKvn7uwb8RkqFuH+QTaTqdAzUEUTQhCfJ6y4oyA+sBF+t2bQyTE5QbNjHZ2hDDUSZEe4Ot3b6GtyPQA5R4chAMzyTKkFzJ1Z7vogIoAd9JJaEWy2B//tkA1KUO5yAdCQChdOHz1QpnWDpaZN5Gyk+VU/SQGtrgJTGYO4Td668OFZKYnvhT5tLHt3XzAH5MStZ24zL2E3uoPeju0/MekgXqPWvCq0l3N8TpQoLugGFF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAORpwd4Qt+iAovmqjXfno/ufuH52c3GzEWiKJ85OdE=;
 b=n5DelmL4IYWcdnwfCLKy+uZp0N9+yuKiN7ub/YoWW52Nwkiji9bBvrFXltYynTxGPiD2RQYuls4tpdh4lsUCOU44vx4o06JKl0p454dVoIDuMALh/dp+cIY0yB3vtFezcAvJEdKI4PhK9XFS9VkrKco6ctFHn74SE/+kHcXR3qJ15cLlV+VsDEzi0ZNBRu+WHFUgBagGanPyAma7z1cBytQCpmPxMpB/EcB20J7Hpm0QOeEa7s9wrZa8U7ohPkLOImkCAh3IpcADvx3oGC28lf1Yl8xTj4Xox8RVPQg9QGgicZMJnq/4uJLekoftbvurDfXh4ZuPc//jIAFXXiPYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XAORpwd4Qt+iAovmqjXfno/ufuH52c3GzEWiKJ85OdE=;
 b=GysBy70jJk3wulT5f0PldUHljJDITAPzMu0uEaPLCFjsOEzRg5YMdeoiln2AIiDRT4B1s6mjqv7Ee+0iW7go5k30WQTXTmHtEm2zXEcuPiubj/UW7ylDubv+hjYYvHcX3dmGxWwar3yfOa5hXNWUElQBmbY+djE56DlZqJ5I91A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 by SA1PR12MB8985.namprd12.prod.outlook.com (2603:10b6:806:377::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:04:02 +0000
Received: from SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::9b8e:816d:20b9:9845]) by SJ2PR12MB8690.namprd12.prod.outlook.com
 ([fe80::9b8e:816d:20b9:9845%5]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:04:02 +0000
Date: Wed, 3 Jan 2024 14:03:35 +0800
From: Huang Rui <ray.huang@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [PATCH v6 01/11] linux-headers: Update to kernel headers to add
 venus capset
Message-ID: <ZZT4t6+VkVrn8nvd@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-2-ray.huang@amd.com>
 <6adff6d2-7c58-4c78-93a5-5a4594a60d27@daynix.com>
 <ZYGe4GcFPt0k5PTM@amd.com>
 <CAFEAcA_=iedJw4BbNHrDALC4mL4g3ZEihsDbLkEzsy-1zAWFWw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=iedJw4BbNHrDALC4mL4g3ZEihsDbLkEzsy-1zAWFWw@mail.gmail.com>
X-ClientProxiedBy: SG2PR02CA0109.apcprd02.prod.outlook.com
 (2603:1096:4:92::25) To SJ2PR12MB8690.namprd12.prod.outlook.com
 (2603:10b6:a03:540::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8690:EE_|SA1PR12MB8985:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc094f5-7ac4-4e28-06ad-08dc0c21c88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypB9wWckwpvZsUZWKlM1EhCaDGfgC9DSy7x9wvrEqcwTt8qJGpkUoqBKwYzGE8L9ZgKuVZo8nJ6ukE1a8BFjttibNYg4PRnZ1zEBL6sG/Tg0gR5FJ7AW1fLTlahMerfU5wM0+/V5Xr9tg6Tej3SwHEd7jr0tTLTGYtDg1xwf23kXHgCDXMri0U1Td8Sf/aj8luSIFRAK9BQowdUsbWB5F6iuJg5nWp81yEdrw6lOtF6AzaqrTpvEIXFexx4As9jP5fn+seec7y4IngfZBe+OsB0Tlo7nQ7qdWN8lx6BypDLqg8uI0AOMlWc6Yg9OXwyA6uvTmtjM7Gsva+KLGxFi/FYQRTg+LE8fWG/OCiEDOdy5WzWKDGVPPGpQx9MRoUCaQJeCFbMcBONcza6PJxo/0xizewmg+LRHzEtAtT5HIUAChOIcbsWllmsILN93FT0yf7zLIE++58VKcMC0rm9OIjS7VoOQmdLKjyL8xn2t6/Izpun6JyFF9nUOBuRObehE9g93S7ekx/GrFRhXnkkkkod0sGin49izKT5HZMJBfOAOltNW+hzH5vHg245zmwMeOm2IjpjdWhvUEuztJ/l/dDNJeliTa9kmfUbS9M2difo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8690.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(396003)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(38100700002)(54906003)(8936002)(8676002)(5660300002)(316002)(2906002)(4326008)(41300700001)(6666004)(7416002)(6916009)(966005)(83380400001)(15650500001)(6486002)(66946007)(6512007)(478600001)(66556008)(6506007)(86362001)(53546011)(66476007)(36756003)(67856001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oHvGHGkaAUQT/68GX7Ht0QrEueosQ4cKzoSce0HplL7GKc2FLeFORzbjRCPS?=
 =?us-ascii?Q?gK6wXsTGvbhLkLSNu8QMc94e4ViR6DJBdD/XVRmCwLvfh8R3iSR0251x+wJx?=
 =?us-ascii?Q?8IT8mrPCUCrRedO3WcSZqvW+EG+ILPx1/Eb0OwbCsKDSEaAwlWyEaQdjT/YX?=
 =?us-ascii?Q?B4oZK0ud2D9fkuPiAMlUtLECW+PpZbHM16GzTMFJi6+K+RzmBPlEzoJcdY7b?=
 =?us-ascii?Q?olr817BAEWetyVyTq28VtTCQmo+Crg1nIscc4IZvmhWHGKQG1rSfe4/Afhgs?=
 =?us-ascii?Q?Hk1UTTFcylUobxvWRINMUgzMF2klgKOde4apEIk4TBISASmvA7i5JMVs9QWm?=
 =?us-ascii?Q?fFYezAU72zbBFU6/03kyF8iiUFq91UBZp+tiNrDuHchNQ7zaRnzMgagQ6wZS?=
 =?us-ascii?Q?/IJQmDl+QxgsSsQGkSYLw1qL/w18TSP2Xx3ZuYZfHYv2oX9ugt04+J+xJMbl?=
 =?us-ascii?Q?O6yX1akOukV2SVcnBkAOHlAPG2UsHJ5W5Q+Y6km/NCMH3JjN9VUgLcdKRD82?=
 =?us-ascii?Q?9baUvbABLUUhUoK3N9v58KNOw9yX2dePPVDBu+4tcmUY355HYYMQ5oSq+oGw?=
 =?us-ascii?Q?MgQ3EzEvG29sISktlZs5prm2TGn12AkplkPQv82/BUFu+ZXbTtCe7d4kercd?=
 =?us-ascii?Q?MMs9KxhABE+vUAWf+g3Iyv37/IUPq07oJYiwkLqkHpHuawoiQ+5vcieNeE4o?=
 =?us-ascii?Q?DPrSWIbLgI7HjxUMDrmYnCPs4CbR10Dj7Xwtybh7W4e1HTvWToLlQIFyuYw2?=
 =?us-ascii?Q?neagtXNQKwrfHG0RNyoakpjTmd10ngpjy1BQOk9YyVyeiufzv1Rp1vlM2kOJ?=
 =?us-ascii?Q?3i6z9OJZnFwBkftwfD8sBtpmb1AICi8NtjcbjqzzAWtrMU6tn/UAKbyOSvio?=
 =?us-ascii?Q?CWWQHw6Dr5d+vGzusB1Z8fYwwZa+EWVSIo8Ela7Kb6BmCvYMVC1sJRumZdu9?=
 =?us-ascii?Q?BMV17nfWXEvaNZuZh2CBrueRtQktQOx6mfZyw14K+A9P29yqabgYtNih7jsh?=
 =?us-ascii?Q?X0+gcfhuXnYC620AfuNR3G1aVMDmgwqT5TIocrUmRfj2+aX4fqyULJxi6dp8?=
 =?us-ascii?Q?kTO6inND8AfNWgLB2z7JJ/iaomul45x+XqFMhqDWlJkX/8bZukbO7pDxafxE?=
 =?us-ascii?Q?2ddBt4k9q8Mgv+yeWeHjfoqlOFKl3wXOmgxaTA1hP2EwZQtMxfhwlub7yhbz?=
 =?us-ascii?Q?UNdOopW2decJb1Zanbva56sve5kb5SsP4viZiHLhRA767GstL04F4pqeQxmV?=
 =?us-ascii?Q?+gUN+zoQPE/LBhOU8uzYfWbkJAC/SbcVhI2rtObypxx0Y8GelB5HuwmvrMJ3?=
 =?us-ascii?Q?FPIOpKRrJGebDY1dtHP4OTYA+9r5CvwWZGcLeycVoeGTw7vyybtvceYda9xO?=
 =?us-ascii?Q?9Xyp1B/jQMad6UUVFdZyyDbe4+AOuLnNAYMens4/zhNif6Ib5MbYcgWrE0Qk?=
 =?us-ascii?Q?1OOE4vAzAOhRZsNxYNco2WTvlEimyZ4QMHsc8olwriEmSqmrUtrVSDdBI7BM?=
 =?us-ascii?Q?niAYeLAjIcxIFNoDm9cgrmxMVHjf4L5+vWai5hbsp0ThUAO3UnUEAwpnGmI3?=
 =?us-ascii?Q?YmNQisOCc7pUdP7d4mRnBSCKIJlqKj8w6KPNdBR0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc094f5-7ac4-4e28-06ad-08dc0c21c88c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8690.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:04:01.9493 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9nNy5piJRK7UcpmVhmjfxjvsV/HBM/hiEGZBOCkPp08EY9Pfxx+o3dLlJuzggF10ZzmYBUwQf0waFu9DJhTFYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8985
Received-SPF: softfail client-ip=2a01:111:f400:fe5a::606;
 envelope-from=Ray.Huang@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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

On Tue, Dec 19, 2023 at 10:14:28PM +0800, Peter Maydell wrote:
> On Tue, 19 Dec 2023 at 13:49, Huang Rui <ray.huang@amd.com> wrote:
> >
> > On Tue, Dec 19, 2023 at 08:20:22PM +0800, Akihiko Odaki wrote:
> > > On 2023/12/19 16:53, Huang Rui wrote:
> > > > Sync up kernel headers to update venus macro till they are merged into
> > > > mainline.
> > >
> > > Thanks for sorting things out with the kernel and spec.
> > >
> > > >
> > > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > > ---
> > > >
> > > > Changes in v6:
> > > > - Venus capset is applied in kernel, so update it in qemu for future use.
> > > >
> > > > https://lore.kernel.org/lkml/b79dcf75-c9e8-490e-644f-3b97d95f7397@collabora.com/
> > > > https://cgit.freedesktop.org/drm-misc/commit/?id=216d86b9a430f3280e5b631c51e6fd1a7774cfa0
> > > Please include the link to the upstream commit in the commit message.
> >
> > So far, it's in drm maintainers' branch not in kernel mainline yet. Do I
> > need to wait it to be merged into kernel mainline?
> 
> For an RFC patchset, no. For patches to be merged into QEMU
> the headers change must be in the kernel mainline, and the
> QEMU commit that updates our copy of the headers must be a
> full-sync done with scripts/update-linux-headers.sh, not a
> manual edit.
> 

Yes, according to the comment in previous series, I am using
update-linux-headers.sh to generate the patch. But here, the patch is not
merged in mainline yet.

Thanks,
Ray

