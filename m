Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 380C2749861
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 11:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLFY-0004y5-4G; Thu, 06 Jul 2023 05:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHLFV-0004vj-HE; Thu, 06 Jul 2023 05:26:05 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHLFT-00019z-Ev; Thu, 06 Jul 2023 05:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688635563; x=1720171563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6lB3WViSclDuFYvQ9ZfRPuTv6Q/YyhJ7GSJT+Eu9kv8=;
 b=nedql9LlR7JUiLokAHsy6O+E+3rmeBh2kwzmrW8YEtbOIX9VEjD6E076
 tDmXLTQlHKj6GPJLAT2cBbQ7HEnwF3Jjgd1HwzOTPufJWWEbC5quW0OZO
 cmVRvkIk/83Dv7WkSwK2LUvpo+qX0QP1S2xq87vUQXpqCRT1xmUXyr19S
 PqL7sv90BSUmuW4hbRplCm1LRxzleLwvC3p19cHKa6vnRwtmwo4DweiBN
 ASYfToPdN+7ECrjgI4MXrmgo8iAFWwsPSCVFa9GklKLoJ2XGhexEOReJ2
 v+u9dLdZnOx1CV0ab1To7ET9Z6oVn+KA0CA+/gJOoJ8KxTVQUZUz/39P7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343146127"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="343146127"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 02:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="864035121"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; d="scan'208";a="864035121"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2023 02:25:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 02:25:57 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 02:25:57 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 02:25:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtrO8vOgTzNWcQxGBTeENoHHsE5+o+b0M1jbYQflXa2E+AkiChdkYvnbBuGiczfyxKDYPdujzFzvbrmXgAXmrJg7ER/FsNKPXe9jBqDP1wfIhAu3SZDZzb1kh+uhO1JFODDM35ucq5XeFCHXzzCJxstKX80/mQ4cg555NdmnfTuPtUnOhoLRgUD1s06iSiMNmqShfSMC/sepZfJp9zpwK3Vfwu3+t6HXdXP479hwttBnBZby0E0Vc/jCN5DMTvso8J1FmQVasDzbMrvgEpJan/Kvb+eEo/fU5LJuAQA8c3Yfc0pCJ3aseyP+72XTYpxL31xwHyM+eTXnAI+9A+ZacA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lB3WViSclDuFYvQ9ZfRPuTv6Q/YyhJ7GSJT+Eu9kv8=;
 b=c9UfPKzKx9XO5ej56vduVqzvusA0hVlwZAxhU3iTVU7NdpYo7aBcSr93P03bwHilaR6of5gw2pFDMiX1k8NXe2GIyrlVTw1AMAU21LQYHcDrKlUQLuVbVAHiPVPFSzXlnX7IBQMKSjdvzRpFkPnBff+XPa5SDdKnfccw7l3AkDjOCyJ6gw5WWS8s9PzXmexaUVL2H7V5n93SzR2fMucSgz3YE4hkJ9ZZhvPtWPfAdvkymU6nW9GcMaKztHaJM+F/7e7BJZPJXt+BqjSM8UjkY72hA/+ELr0uZyesmZn7W04IIEhe6H9ifbvwZxcQvj6kqrC6CKf5jhO3bPA8w/Xevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 09:25:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 09:25:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "bharat.bhushan@nxp.com"
 <bharat.bhushan@nxp.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH v2 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Topic: [PATCH v2 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Index: AQHZr2D/ebGLqglCxEWVs32GM2EXvK+seJ+Q
Date: Thu, 6 Jul 2023 09:25:48 +0000
Message-ID: <SJ0PR11MB6744FA1C40BC4CDFA9C56EB0922CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230705165118.28194-1-eric.auger@redhat.com>
 <20230705165118.28194-2-eric.auger@redhat.com>
In-Reply-To: <20230705165118.28194-2-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6334:EE_
x-ms-office365-filtering-correlation-id: c5f818d5-5f34-4d2e-77df-08db7e02fc3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JEYSv2jI/cIUF/s1Ak0/2WtoQZ0+o3JauvPVnW6a/LIZ6h+b9dRjb98tlcYw8ZixBbjM+XeK9GT8vfC9E+HbQSOMn1wV36xT7GMpM0yxgv7xPGNKH1lLvsG+AnJdE9J0OJBzwqUbRTLc9Ez2NzhtsxViUMNmYgq/pQYmaEPbJUbCnIplD8bbMlPG1sXAT4MHS9idW+apQxSQhKTG1wRrrdNW1YCCUiapCjzatnmlh9mzoqLEVdR6oMPlaq9G4JlVzkXMfJGwKeETOl1lsb3mJ/DQpdJAgJCTYY0yU/r3nALvEuWtakDzPUD+KyN9B39oCQdzBOy5VlTT76wy0pUdNbNqZ9KnzldpIKf+H6y7ulb/dV842K2u6fvc6ZJ0tjBmmnGgd14utzWvdkU+yTDkPQ8qRxOqR3X2IFFi7YDEwgB694WId3ySF9R9r36SQ0LfcRoqZ9DHZgaYBHPT4enbhYtzu7PN0RCWkIw23QxFICSzgfZDrFzrurqiRRpMKKIYEt2JhdltinQ+Lipz4ufXYgWoSSVWI4q2Dj1RI0mmNa/z/Ude/RigW6nJ0pQokAO8p+EqbsB+KRWj1OnRUWVd1iw+vVajTTXG0UOBb9I+oZQ/aQ7KuNsmz6RrJR7nJ7fY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(82960400001)(478600001)(186003)(6506007)(9686003)(26005)(86362001)(71200400001)(316002)(110136005)(83380400001)(38100700002)(54906003)(7696005)(66556008)(76116006)(122000001)(4326008)(64756008)(66446008)(66946007)(66476007)(7416002)(5660300002)(38070700005)(8676002)(8936002)(41300700001)(2906002)(52536014)(33656002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sMpIz5YPJouVLV1/+0uu1V+1fd1EqHGh/5v9YYfdF7xqPOA1gXmGJk0PEPlk?=
 =?us-ascii?Q?yrzm5ntAOr42Iw6yII9TK0utxAPg1JA1xuw/AblBb+n6IAGjlNP4qR/8aNll?=
 =?us-ascii?Q?JmVVEcsqAgagvLgQdDpbBf1v93EdhHcJBHwHEQp//e/AONjp732jhWvnTQDV?=
 =?us-ascii?Q?2x56RbzA25uwB/bHAhepLRuAQOiswvZEsDTWZdhn9BfoliHd7EIkYe6IZKrg?=
 =?us-ascii?Q?PSKj5EJcSDZcn11unh41gdYQC2UD7soIH66FMYaWA/xV9LTxKjkD8yeHhwvO?=
 =?us-ascii?Q?30p4/rwVbTV9wMyeZjQgNCte6sDFSTMVyPI1n8uQCwBPoq8tKvSw/DdfQ8bb?=
 =?us-ascii?Q?BupSEITIDSa04T9c8heJGlA4OjcO1eHxqiUJt18pmsu98MPdVZnKIejJSZPs?=
 =?us-ascii?Q?m6tju0AReq5Ts7AhepNYjWEnrc9KUQbUJ+qXdHDU2+9yjlNeRIasrHsBm1ti?=
 =?us-ascii?Q?xXovb4gl5VobRC77SKv9i1zWvq0eSVlfmb+ORjashRFiJg0MVhDOLpe/Bf6A?=
 =?us-ascii?Q?JxoNpXmYpv1U7uvPibjqC2mc/fmxveJR5fjUjkSEwucbYhTWo5QyPnZ3WNAM?=
 =?us-ascii?Q?4h/ajgmL675ZY45MhMFcQaVPOGN2RE3h2SHwG3TnIDtY8i3KF3B6vHj6PSjM?=
 =?us-ascii?Q?rxDVHYMJ1EMtkfh2xub+06Hwc9lVDfeYSBNt6lC+tQzvsyQpqorURMsoUkaK?=
 =?us-ascii?Q?A/PU9lfmGBZ0Ap3ROn+ZXANzTOkgG3Rd0v8kt62w0KsEKWvzHgAtJpjJxtGE?=
 =?us-ascii?Q?eRVhYJmD4rDfMcE7Zw4umLxcJA+4xpahkcDG9GSXzz/6LPIuIOPcDbx115eD?=
 =?us-ascii?Q?GdX7qvLcnCbuz+29+RJz6YonSMT4HsvA/l5lGvJkf8PAKPY0g1ShxG1FIszg?=
 =?us-ascii?Q?prjaNZDxf0bo/gwL8kXdirPl+Sr5q9cn6Z/XMiYc2AhPhU9CshReR+Koh9+G?=
 =?us-ascii?Q?DxGvHpwTGyywKCNu54DTKDVphbm+r4eBp7FAcQEggz13xfXSZJFhq3TvE7i3?=
 =?us-ascii?Q?AWBLAjdnj8+9N4M0XavLfiurnz46IS+LRJe8cGcXJyc1kFuj55mGSFJCL0Rt?=
 =?us-ascii?Q?ePoxDhYOgT3UeQVOqVh1mOCGsyZadwVavq8RF4l2AJznK6mGoTXhizCC4ibo?=
 =?us-ascii?Q?bHpwkb4VnUKuDxOCq5l7qzipPXhW+EMYkg4nRgCif74Ijm3bxYEyNdnxHF2Q?=
 =?us-ascii?Q?vO9+A7ifrcV29z++SzNPgNth7bXTrPyz7vQxV0BzadCeiINw/LF3rpb7E+dF?=
 =?us-ascii?Q?XeWb3qc0MRbTTNC/oWyhslFAPLGdEXnvWImBP3ueuyUfqljcmbVXNfa7Ifc4?=
 =?us-ascii?Q?Y/w3aR+vsZPQIOaCulk0yXFflr9huSu10JwPapN0uZ5UhB4RIe1JkS90dd6I?=
 =?us-ascii?Q?piTMKLFKEVT5eNihWhLze4I+kU/JySgMH2TJRzKgo42ETI9pLTDZHzOuRrXl?=
 =?us-ascii?Q?nlcNJ2udF1p0MPwfLd/GCI9s1E64wxvLBkAb5OPy0vsLNVFjY4hXCj9dlEZG?=
 =?us-ascii?Q?4HQSllEG6sbj8EsrNSoS0bNbh5KGN9VLRYDvyeI9btY1hwa1MWELjZU4xzhm?=
 =?us-ascii?Q?gRZSfIy+GVmopH8GgDNt6vrNVC7T1ab7+gY6ux1v?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f818d5-5f34-4d2e-77df-08db7e02fc3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 09:25:48.9776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sf3m0/AJpNLJFhw1qSMZ6sqZLCBKE03D58+VYyYEsVDx47tm5VTULcqBNHTFQUzZ9W7pyttcOi1zKsu0ucbOCzWugYqfonNOF+qnoVjxhIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
>From: Eric Auger <eric.auger@redhat.com>
>Sent: Thursday, July 6, 2023 12:51 AM
>Subject: [PATCH v2 1/2] virtio-iommu: Fix 64kB host page size VFIO device
>assignment
>
>When running on a 64kB page size host and protecting a VFIO device with th=
e
>virtio-iommu, qemu crashes with this kind of message:
>
>qemu-kvm: virtio-iommu page mask 0xfffffffffffff000 is incompatible with
>mask 0x20010000
>qemu: hardware error: vfio: DMA mapping failed, unable to continue
>
>This is due to the fact the IOMMU MR corresponding to the VFIO device is
>enabled very late on domain attach, after the machine init.
>The device reports a minimal 64kB page size but it is too late to be appli=
ed.
>virtio_iommu_set_page_size_mask() fails and this causes
>vfio_listener_region_add() to end up with hw_error();
>
>To work around this issue, we transiently enable the IOMMU MR on machine
>init to collect the page size requirements and then restore the bypass sta=
te.
>
>Fixes: 90519b9053 ("virtio-iommu: Add bypass mode support to assigned
>device")
>Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong


