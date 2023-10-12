Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E97C62CF
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 04:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqlWp-0004qU-JT; Wed, 11 Oct 2023 22:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qqlWm-0004pz-VR
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 22:34:21 -0400
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qqlWk-0006va-Ip
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 22:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697078058; x=1728614058;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=hENfTvFhUeYWLl6p6ahZ+MPW5AsS5Z4sebD7zxpGEIs=;
 b=biH9QGfHUSUW0ocm/09zE9ddLBvqGvHEh7N/3TdyYR9136M+RuzUg8F3
 v21xPthI2IbdQxNtfiPeOfIRUW8c8cA8DCKqxiD+iTDQvrdAO++vtdMmB
 ZrgT+83MJbdJOza+Yrz8eaQ/4OaUYv3OYpai0cGxveANIuNGc9q1DjvRf
 Lj6vVJBc2/D64h3Zto1w7IkuBEOos8FhiVXny89FFjdEM/2ZyFlL2wKEA
 rFOK8QrJ17RJTC2OkKgFdLR3eu8az6s/uapnQRS1NeZUDVLbi1HLl5ZG/
 URRiWQZSqq7BTxbI/4shXabtVpOl74/VrNSW3/rwDx5+OsgyHH9fTCCeO A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="365089667"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; d="scan'208";a="365089667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2023 19:34:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="927801580"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; d="scan'208";a="927801580"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Oct 2023 19:34:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 19:34:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 19:34:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 19:34:10 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 19:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJi6hTqvzidf+u0bSFYtxFe9N4dS+QsMPa62ROqFGdEAccm/xquN7IG6K8AkcayaAacllsrm2+OLXO5OeHoWlxcCmzAgnMtnac9GRvGa656k1jAcp0LW4Z2wbhZcFzxGP/83aDUriULBo5gkerVU3sI+XX0hBPyYKb6xWnZ/3ic9at0wjmzlEsdoJG5Cf8V85ETjH1LC2oBmz37lnEAkYngW+HwtFEWGUYU2nl7ICQA+zJvFpOuBBpM2eqjFnZqTDGvaobHgDXYH+f4EOkh7Yve22/QZqAbNLTnc3Hztb0yQeClCuO24H2kw7QD/W9lLpn7feMmWenWbbKeCf6MMlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hENfTvFhUeYWLl6p6ahZ+MPW5AsS5Z4sebD7zxpGEIs=;
 b=hMbWrx8+S4t3g2WsrkIBSKtO4TYpYx/FVVyLwV8F0X08Qci/XYbMoPfzg+wOlXjI/DLrIOUhIFhpzvp3sil95AMejTcY/NFejZChqK4obkWOr3LDkB0FDajNEl6sqIycu1q0UWs2/o6S7KiqZXXhfVM5Pih+JVyUAOmMV/DGy6LnSM39bkM31qysjKTC23hkZiF0ThB2N5rqKgh0enb6/VZQSLhOBG6VYQ0t+AkMuR1Ra7m0ziozrmEFO1U2J1GCVXlXgyySRtrw5YruPHiGJfSYdEtHo05zBe2I6p2Hi3ei0oNfgPS8mtrTJFKeWMnxFba4adPJ9gvSVU27sng5SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Thu, 12 Oct
 2023 02:34:08 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 02:34:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "yanghliu@redhat.com"
 <yanghliu@redhat.com>
Subject: RE: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize
 error path
Thread-Topic: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize
 error path
Thread-Index: AQHZ/H7oEI2+uvPk0kipuVCJo+KZ7bBFb7Ig
Date: Thu, 12 Oct 2023 02:34:08 +0000
Message-ID: <PH7PR11MB6722D7A0E5D47F6E9A5B191C92D3A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231011200934.549735-1-eric.auger@redhat.com>
In-Reply-To: <20231011200934.549735-1-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|MW3PR11MB4748:EE_
x-ms-office365-filtering-correlation-id: 175c5fe3-e9a0-4814-2201-08dbcacbb619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s4CZMrp7YtmYIfw8NACa4xEsDMeoLvTH8kKsOGrGrUSpCsCzLK99QhsmgicIeNQbd6Z3WDJjOZGgycSOmjb6gp+6rBnLFhSHFpAvLFwRI5XqkSR8c9hl9ZLPN0dnqE0SQZN5QrUF4w1EeQi/sgN1dNDe/xiQ0PJZzFDbfzgIAKO4EHsVs3OBIpNLkDqhVTge0i2YfZNEJHGt4UFmhVKBejOQ/xh/ZOtcjfNeE9yeN6lR4LPvkgnXuZc7uJ3ZFnI1gi29FV7MzxY32A+zSmQWLO1OOpLsKGqtTWQlgACmzCkLnAonVyTBDkCZYo+dlju17z+RIWrCa14q7vdPuW8Q2JWZ7zR1c4YWWvCVRgBohUXB86xsyRpVh+TtX07hT32DyPVHCfJLimVUxVO/YWzcPKsxW1Uf46gXijp9SHT2nAWzA80wMXkPXu5aIGTOOSp6IHROq45TpiKzbqO1UTEj/9LUD0OR12L9FlD/o5C/rcgAMeakTXxsty5bH/P3N8swqcqyOtFpa5Qbgy8W6tO09gP2UKDLqtIE07yGGSvbfbCSzFVTvl9QecGkFs7L1Dp5UGZKhZqWw8+yGfJ8H1v4RJhq3sXOdFSEIjDarge+ZhU2u0xVJDAvOiu8Y6h6tYIteVM+cPITj71mGiwlpwr3MQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(9686003)(478600001)(86362001)(6506007)(7696005)(33656002)(38070700005)(8936002)(8676002)(71200400001)(38100700002)(110136005)(5660300002)(82960400001)(66446008)(316002)(64756008)(66476007)(66556008)(4744005)(76116006)(66946007)(2906002)(41300700001)(122000001)(52536014)(26005)(83380400001)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KjwH2dFu5TjpCIq2SWgU71P+d996tf2qkn/gsn6/IMwpP85yfkPYTDRunhAM?=
 =?us-ascii?Q?yt1536jNXYiq7acS+lOgd3FUJOC1LremH8riSkxJU1Qy+o7iEI7QD4gOt8NI?=
 =?us-ascii?Q?1FHrtptyfVjJ73eOe3Z65KjQrAOW+m1UK70bhfKNgFVCA6ethSxOoajcZpv3?=
 =?us-ascii?Q?VCM6CKmJkurVxZIAfvsaGRuznn8GkLSly87hefifmRd+jUc8xTXKCYEfIAcN?=
 =?us-ascii?Q?UQCr2gsJxCFrsj5GM88tjnk7BA3JycoWXVNp7XN3ZhgaEF0S7V/RNjSn908i?=
 =?us-ascii?Q?PE5W+1VEDgSLzxaQZZhBBHZAL4NyQBp9daGPXs6tKgaS3VrD+lAaQGjuhNSJ?=
 =?us-ascii?Q?1secf+O/LwX9A6lBiKddoHGvqulYfBlFt6DqUTJEmiR+pLJeBedqnH2wBw+P?=
 =?us-ascii?Q?FjM2wuaT+69jWkKP1YQDNd+swNhhnvdOh8lq2SCYoNha7WBoI5K2n8zoQ0VJ?=
 =?us-ascii?Q?qmgM6Ww0Cd5Z3cE7inHJeeeOymPSoklf2P1WumL/3Gc65cb6gqfGtqxd7SFf?=
 =?us-ascii?Q?NDRyoh9vN2Hy2TER5weh+3HavqPXYvIV6nqtOyf/iKWsQC0TGBKZigOyYOGI?=
 =?us-ascii?Q?q39sBMca7jvd0U2sORu7246sxfR8QkE7BI5xsMfO8HdFX6zKlLEill60MefY?=
 =?us-ascii?Q?/dAVLEEDqF7B4so+X3XUTfTDe2GxaCwicokhcQxLGxNiHbux77YQb6jBOIY1?=
 =?us-ascii?Q?i02oZS0DsHWUnAhdfb8eQBg5M6z/3s6DEWIBuiNthxZmQo45v1yI6zB0NfkT?=
 =?us-ascii?Q?SDnwkCQu9ZJU+tixvKH6GOpm7rnSUWvnrZWrzcSkI9KEzDASvaej6WjQD7Oq?=
 =?us-ascii?Q?i0CzD//1uFRz+JG8ItQ7IDtX7eZ0NhKvCWmoblI7v9PKLSoisd4Tm7eoaSrz?=
 =?us-ascii?Q?6ModVBTuDaWNS4P5n+dCAigEbkOtSjsgJ+45Wji3RMrasybu8+TS6TAJJZTj?=
 =?us-ascii?Q?VUdTDnLMy15cQSXSWUpsR2l5wbduyE8uTK3ZdG4Xndi9FrgMjjofLeFWggih?=
 =?us-ascii?Q?+t8FROpndJWOXNMbNf9E1Ch7duYEdGxhaJHXtfjkpfG4EzAFVU0NTTPOYufT?=
 =?us-ascii?Q?dG8s1OfWftYCpbp/6G7H3DT0mkJSpV1V0FhVXUieWXCtkNkgPA3U4Ouk2UbA?=
 =?us-ascii?Q?jACvgQo3wHo0uvMhdbH7tiMfcxKnizilymKfD+t3VT0ye/APltMRrUzSGJbm?=
 =?us-ascii?Q?krnmvrBBbLQhqnTWy54E8lU9JCC6YzldO9sV+x5j81OX0h04l3ZCekqTvDJ5?=
 =?us-ascii?Q?9sEMJAHQmNFIwp1Xfx19uZxQ7MGpteYcHTd0hlM4wW+HETJ5U4nsUnVptao9?=
 =?us-ascii?Q?6sxEjVvOWaQT27l4q46tMAaTacP0ixPqFlAybc/yHhAjc4xqootSGcpo9XMO?=
 =?us-ascii?Q?B1r8CT7reRyQXyZPfzZ/Cu+EqkJHr2lFiGMGVhnN77f2HnX8hnz8L0OkBsAQ?=
 =?us-ascii?Q?q60KYUtlXbJ5q4OkMC6rA8oR+l0lYjyPkuRiORHawcKViLHjF6dO9mT8++Ea?=
 =?us-ascii?Q?U8q/mi3EJQZ2KfSHYW81wcz+0QRsOh+RB++AiLi5+HDQ0oOdpti2xslijjYC?=
 =?us-ascii?Q?6/KQlXFVXDpj4opGJNRPcHiJcyCc11zPUkR5bmf+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175c5fe3-e9a0-4814-2201-08dbcacbb619
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:34:08.4903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MpyiC+MT1vn+KtPwql4/rq+zrjy08Jf4wvJZhEGs5SZWD2F3Cx/IkDuqZ4GcKHvOgso8y2NsPbxq/iij2UQzrvjFUTFcjD0b6/IVtUjtjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4748
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>From: Eric Auger <eric.auger@redhat.com>
>Sent: Thursday, October 12, 2023 4:10 AM
>To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com; Duan,
>Zhenzhong <zhenzhong.duan@intel.com>; Liu, Yi L <yi.l.liu@intel.com>;
>yanghliu@redhat.com
>Subject: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize err=
or
>path
>
>In vfio_realize, on the error path, we currently call
>vfio_detach_device() after a successful vfio_attach_device.
>While this looks natural, vfio_instance_finalize also induces
>a vfio_detach_device(), and it seems to be the right place
>instead as other resources are released there which happen
>to be a prerequisite to a successful UNSET_CONTAINER.
>
>So let's rely on the finalize vfio_detach_device call to free
>all the relevant resources.
>
>Fixes: a28e06621170 ("vfio/pci: Introduce vfio_[attach/detach]_device")
>Reported-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Tested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

