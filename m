Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F8B7F3C75
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 04:33:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5dz0-0001OG-6i; Tue, 21 Nov 2023 22:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5dyy-0001Nr-TU
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 22:32:56 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5dyx-0000Ki-5p
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 22:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700623975; x=1732159975;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=l++puP1SsYkXQWyDe0HYNAw0SCD3Z40YvDgHzQDpxBQ=;
 b=YwYJYdFsneNqr7IlRCHE/4I/pjquBRiAfVlI/rxmFaIJTbEbSnaS31FC
 kNA+WHzaklwYT5kap0dK1xg/DM/o+JWj1xep3KDznVlES6VUVWheAcSY+
 my0AP4AeJqROJImA7lmgju151YXVfq+e6PxyEJkatn52p9+CfrNvU/vuB
 uB4ZTg75Z1wsPODolVzO0M9ovoRMcgFTZOfiQcWLTNEfAJVfoju+PKZt3
 PiGO6uX9gnxXFyBWkK/nB7hWO5J7ZEh5oBcW6VAx3DuCTuykM7FrCgfh/
 YbS8/5jlHoaOlq/MudBIzjkDRf1JKH6feZx1/wBa9pXVsfNchi7tn90Py A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="382370262"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="382370262"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 19:32:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="801763247"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="801763247"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Nov 2023 19:32:52 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 19:32:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 19:32:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 19:32:51 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 19:32:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUuaLUvAhkDR83muUVq4OmJ1XVZfJ5tdTmthpGJvrKiwv0QNErIlQAHy7bPQDT8PpilAuoLu+UdA0V5aADun2sV+VxYQZM7RZSwQ0fkQ7e6TyeGYCXbfYhIhX2lcVQZdQsrnHwN4zk0QeApYF5TDKZyQhDyU37irOIcGfVGqBskglfzRE+aqFUTzGyrjlB1nOti5m0yd/+hZPChY+49+zvTJ8Tha7yFPnZNpVxju+L0TkBxni0J3hRG+DOPi1BdCBGBFFB4thFeyVWXCBQeN+DMjGDCANkkZvWIrStp/VOC/0ji0ljDAoYaWC/y2AFodd1+/gsWExIjiSQiC/9rxWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l++puP1SsYkXQWyDe0HYNAw0SCD3Z40YvDgHzQDpxBQ=;
 b=KraKkyq1ups0KMSIvtlzT0CmS9PgbSXBmGCC8J0p4Cwg0TmlJ86MpqqXJoH6Mgi51MmnKi5B7DXPJ7Y5caDnMS6D4gc+LQmZsMRZ2sWPS5QgXshlpBUenpIECtHVYzNNFjEYNJO2+hWBibs1Z2AOw8rgtm6KvXvtA3QhIcymdylYQrj/F+nDTN/MppYhp0RmfkacbfA9eV2hGsQL07puAnE5xX5kgI2NDaU/EnKryRtYPy9P0l8KvHqGu0amfjrkgVpvC1jLG+tUfP5fEW1KwZsvVwabaNkBYQVj5t6bCYd1LKfaNlq+hLntOXfkd9E2CsuxjvpaUyKMdap4yk4vqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA1PR11MB6758.namprd11.prod.outlook.com (2603:10b6:806:25d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:32:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 03:32:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 00/27] vfio: Adopt iommufd
Thread-Topic: [PATCH v7 00/27] vfio: Adopt iommufd
Thread-Index: AQHaHFc0W4LZl8jDnE6rBmZPePSx2LCFYx4AgABNMeA=
Date: Wed, 22 Nov 2023 03:32:49 +0000
Message-ID: <SJ0PR11MB67443A57E31C377E91E2F0F692BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
 <ZV01gh9I0QgcU+uk@Asurada-Nvidia>
In-Reply-To: <ZV01gh9I0QgcU+uk@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA1PR11MB6758:EE_
x-ms-office365-filtering-correlation-id: 6fbdfacd-8d91-4df9-5da7-08dbeb0bb36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FlhzA/u8Eu4G4QYmq5eHJF6rYRXMHPGwEor4+BaTjNpNWx++RbGHmZvVgXIiANKO6ILUB0QWVMLQ6G4YS3Of0bIOhXNfoPzOdZ4Tfo921TewqknjAsYmFlrhOK3lddjRt2a+MOTN9gsEKAYafMu2zbg2+yD4+qbcXJLcateVJjdjwdNiUKXZmdkKQss+bAyhtCp4rKx1g953NCnIUDgjFqVqHrc5Ha1McIHBFbXJsXFPUTisoND9o8nHq8cDNgO/ox27Z2WO7xE24RrwK89oUZlzQCVBRavRn/RPrRqCYeG54t8XgpxM6F9XhBcZZAiCGZKnDC8EtUoCcmZWhOq0WpoYcIPV9fJsBpRqBOrxi2/GvptCE64X+WxDeljsvwFq5CQ36O2gboWO1KAG7b9dHZ2SAHaRL44+/gk4VB5R399fhlhxZB9dHB1NaXehD/tjXQkkFA8NBSvstaCI8bED1ik8iJQMUGjeAHL0yVuMrtwhXrktCGOPq+zevzazIEfvbkJjk9Bjc1paq+ekp8Psgo7dTdaiFxWYwxSiJNddkh+75jtouf/glT8f8Bzw4HfzvFTiqe4KemeFERtiGu7AbCUoAImaCxNaS40Cl9zz3abt2rqhLNgI7sLhatqpPjr53ZL4cHsJt2vI3IG/itUiZA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(4744005)(5660300002)(2906002)(52536014)(8936002)(4326008)(41300700001)(66556008)(54906003)(66946007)(76116006)(64756008)(66446008)(316002)(8676002)(66476007)(55016003)(6916009)(71200400001)(6506007)(7696005)(478600001)(26005)(9686003)(107886003)(83380400001)(38100700002)(38070700009)(122000001)(82960400001)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4ggWgHZcbhOHyxtzQrQQBqaM9+t/zqSwvJMf6bSIu2npuum9wwRXcswy5zPA?=
 =?us-ascii?Q?ucnyxoBHpPG7pejJvfUbxSDzUbJXZiWOgiaJPMXbx0WWNzrENdoliTRw/gOm?=
 =?us-ascii?Q?tG7+voA0fcEjAV45/yhAyroRPEZa98kQnwK5QlVo9v9RKdkzwnvSdKqMuxF2?=
 =?us-ascii?Q?zuPC8JlPtfuXsmLBxvCD749Sgdhggiw6aB2mxwGJ8S3baKaWZ7EqHVCTl/fv?=
 =?us-ascii?Q?dk+VBrZPpAlnH7CgQkuhCWweQ6s2NdcE8rzn+ken8B7cTyvrfeJxexLca8iO?=
 =?us-ascii?Q?BvLXMpQk/A7h96uDvUVY/Z1nJUQyuegWQw+qi9WLaPCzGyVxNmKAbzRVTzfn?=
 =?us-ascii?Q?V3D6yRJNBH86VTEIHWmYEFC6vbRP01BoymMl5K5W0PiOo7Fk4iVsk69BdF6F?=
 =?us-ascii?Q?Qm7z+sbG4jJbq820AYo3KyDppPl7X8a9TDedQ/RB704YhVvkUrHeRiZ9u4wf?=
 =?us-ascii?Q?HWQBwmuDfkjzOChehJ+tbK6xASXwSbledmHJNzrTZcGk3boGO+PLw/SBpBqu?=
 =?us-ascii?Q?x77ZtIZODTEg5tqaF//hOVJKPwROF8C6t3H5Txqc02Hs+bnDYEHl6dRkxnN1?=
 =?us-ascii?Q?AC32GDzRcMRheatnIjfm5IZ+w0BkZ9UhzUVoKta/ZQCoT5mSrB8r+u1AzmcU?=
 =?us-ascii?Q?anqEzvYx7KX+E+8LN8bIEm9gY2fHZ2dFSK1/+OU69v8dMETwCl4JsP+kThM7?=
 =?us-ascii?Q?ASBlPLI4/5VFPOB0t06fjvnRa8CtlQfVeZQmI1wVxOOZ0ht+RiDoEb3LJJQ9?=
 =?us-ascii?Q?tRPjHKo83BjudCJ995PGaM5/j3bIdzgGl0nTXkMqarLvOoaPkzkb7XV95wU4?=
 =?us-ascii?Q?Zlog6Vy/CGe4y3BvfvW/iskqZ0vTwo96WJlmBmiZdVp+VIE+tpj8VnFW6BFD?=
 =?us-ascii?Q?e8c/Y6znytWPEGD8Sx6Lk5zOSH0ejtdXfESz73VT5iy9dAoOoKw9MRljIuW7?=
 =?us-ascii?Q?GKaFXs730wURIMaF/GwYnv7zPXIk+egs9dp2X+p9KbgKezfTe7ydaiEnlfL6?=
 =?us-ascii?Q?6Vo/+zmaPrQtGXTKaKPjPe1i72N3xwDjD2bYT3lHYFClyzpNNIKVXxuhASls?=
 =?us-ascii?Q?Sg4agw4QulwEqnLsR/r075xp640gH9asRwd7bmCmSMalds32Dv/spCUqWADK?=
 =?us-ascii?Q?LqHJblVkmfuOsDwpGthhmAN7IZZyCUSPZ9+8Nx6Ww63mQ4ujmB9aQE+HiK45?=
 =?us-ascii?Q?Q5FqDCWpx4MO2AuGIP9qMdQJ0D6frpsrBxnMcqzd/3NSTGaJWWInwXiLMtnY?=
 =?us-ascii?Q?3BYI3OL23ey7txCCO8BbhNj6kTX5mRHSPol7new2vy94emHvZmFDG9T9g2iv?=
 =?us-ascii?Q?qizRPxkAkmG6AVKmeunR+2Spk0Jgl+XwdkHXq4v5TVy5mWtDAAJ8QRrXS8b/?=
 =?us-ascii?Q?lHoLUNJ4rjQqZM7y9bFi6JJLeqSOq8JrolxMwJljLqc+rWyWmL4QgFtcNISY?=
 =?us-ascii?Q?qmxZLkq2jDwI8hvzIcJL8Ad+LjZVpcSx+IBRzfFBdeFvn/NJdZTFxDTTlzwl?=
 =?us-ascii?Q?bh9VbpqDO2qctS8RMZUQb1CTjVX2KEejKWh65xXqH3/glNVulhP9Qkc9Mjun?=
 =?us-ascii?Q?4PNALlLNylgWEp11XZHDQG/xlfKeSmuYfLMKCB5W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbdfacd-8d91-4df9-5da7-08dbeb0bb36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 03:32:49.0164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q99zXppjCHnWk/WMhajMIFgF16nBh1FhuULJTanNl673DpNynqvtltWr5pkgOFFPgct0/UvNr8oA+nubaJa2HKqm20oBhvJ5B9pjbq0esrg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6758
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Sent: Wednesday, November 22, 2023 6:56 AM
>Subject: Re: [PATCH v7 00/27] vfio: Adopt iommufd
>
>On Tue, Nov 21, 2023 at 04:43:59PM +0800, Zhenzhong Duan wrote:
>
>> qemu code:
>https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_cdev_v7
>> Based on vfio-next, commit id: c487fb8a50
>
>I've tested with an aarch64-softmmu build using both legacy VFIO
>passthrough and IOMMUFD+cdev, although this might be similar to
>what Eric tested.
>
>Also, tried rebasing our nesting changes on top and ran some
>2-stage translation sanity using this branch:
>https://github.com/nicolinc/qemu/tree/wip/iommufd_nesting-11212023-cdev-v7
>(Note that the nesting branch is WIP with no stability guarantee)
>
>I'll do more tests with vSVA cases in the next days, yet FWIW:
>
>Tested-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks Nicolin.

BRs.
Zhenzhong

