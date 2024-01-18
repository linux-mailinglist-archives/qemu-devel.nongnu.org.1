Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6F7831321
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:33:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMtT-000876-KB; Thu, 18 Jan 2024 02:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQMtP-00085n-UL; Thu, 18 Jan 2024 02:32:53 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQMtM-0003xW-FZ; Thu, 18 Jan 2024 02:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705563168; x=1737099168;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XZJbrOS+TGG0rgtZCf6mwppvJzk/OoGpkLv4oWiQd+Y=;
 b=bFdiVJIyIPLLKcCVJCvVMT3hkRNbIqfClBdSl7WRPEq8/CUFE+hHMqSp
 raO4VJRyZOZjpMKWGid6PO/7SuOSmAOcjXo8WSjzJqIGnmdt+cE1th2GM
 vA6ycpNPVS5YoDmGCumg8DcWBvBbhNGFa8PikDM3GEvQI5weou7CAZeY0
 x3hgCeHMJu3L7JOuE+Dm12NyqkPGjN9VnVQS9mFHMet4uNOg0e55f8A5S
 BAS3ebUQhDq8jVD/n3hNQoM7AVm8lIzoHFfubO/mu6+DgWgRDjxsoQIYF
 +CjgKsj9yIXdxJqtJFPxhLdSm4l4HdteUcAG++aeEt0pnxpROmKXsvRFI Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7466217"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7466217"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2024 23:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1115889584"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; d="scan'208";a="1115889584"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2024 23:32:44 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 23:32:43 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 23:32:42 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 23:32:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 23:32:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwv2VLj0lEmdQ3UVFMF7pSLugf8nnP4ntdnYT9tE0z6B7JZz1uI2vE68Ub3DtjgNTzI5N5kIJUi6A0rCh+nBO4oeUMjfKq344pMAuMoORR8EXNgGSFuud2w/7YGqMBQ8lEAQ8+oNUZhraQh0dnjxQibyvcEosZW5Ni7tLWWtav4HAQXjdomB31lc0dEHRFq5sJtlNaM41iHc0ZmMyMziUomiDS/p+0Sl+8jJzoeqy132WQ7HmDb5xUv3iCjU1rqmEWRcNQ+grc3y+KpDtguWE4VS9xC2pe0QcWeQiSZPVgvmYF6HwFEAHvJ0QZtvmhwdyYBjCagZxN4BDxbvDRS4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ay9knUFl+M1gMjvv4GCoUrBgK6rK9LTYFkjWT0W1l/0=;
 b=JnDaVzYcz6EURW5LxadA/O/5CJi9V403dSHYEnJAcTB39zqb7EFapiKnp3L+6VXt+mAi1j4pkB/ByeRkOMviciazUcKQO2CvCopSFcNx3fhcO/vyRLz8WYv7jOyN63e9+ZcBTI2p/qzrxuy9aWblbdltobRE8eiPUm1dgj4DyJEKbe4b4HZM34Eb0V0FqBJ2FSfMXIiqEXcHdNeFPTN88jtf3+n6b+nTd0cOmGeXuuPjz1jqK1jXYq8jQ1syZ+pHbu93go44MWptSKHSGxRBixijjP9x3B0PFCEZTyrTJgTifDZIVqJxDeNwbUqCpWgz/Zg+gE/9nzK8tK0Y0Ka3sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5023.namprd11.prod.outlook.com (2603:10b6:a03:2de::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:32:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 07:32:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "jean-philippe@linaro.org"
 <jean-philippe@linaro.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "peterx@redhat.com" <peterx@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
Subject: RE: [RFC 2/7] hw/pci: Introduce pci_device_iommu_bus
Thread-Topic: [RFC 2/7] hw/pci: Introduce pci_device_iommu_bus
Thread-Index: AQHaSRvX0S/PDwJ87EKoqW7HGqD/IrDfLprw
Date: Thu, 18 Jan 2024 07:32:40 +0000
Message-ID: <SJ0PR11MB67443DF78924B8E2D8BF470192712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <20240117080414.316890-3-eric.auger@redhat.com>
In-Reply-To: <20240117080414.316890-3-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5023:EE_
x-ms-office365-filtering-correlation-id: cb75c921-b9f1-4465-69f8-08dc17f7a711
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DVD9FaiPDkfboxnGRWNUw5Y2VveveuqR7cHiwFaO/0xrocr4JGQoHMWXGIvbtG+BbjrUyGq6TL6M8q+ZvheJIb5S3YnZu4TfIxPMHyu7AR/TV+2iS5DDXav23fqYcicAVdiWfOY5a7GiBb+dMfZ53ADu3QPulMdKCUcEZ+LCPwvbc5zoDvl8JRVn2U2EuBPnR7321KNqgaev5fJwuE42IzR5EbxtJz7is7eP07JHkoqe4NHAUWI+ApStlitJPBxuWaFLrBT9zOBCJU6UPwVLNejJOM7js3VIu+xpgQx+ywPP5tFWpUWXNG/BH2AkrQIE9xl/LkzrEnPASnfqxfVJD5Hoe8Wo2LicoOlv5T0G4sSeEpKseBOyLdszwiOcW7GD1EKDr5g3HTcOXZRpxRuynBDNlqvbnnef6o1qCrj/ampkYwppAYjVLCdVBeKjyZcQSKJuOzx8Tj9gNgn8Zjsa/FioxVvpM/BJVszajQjcoLXI4Q37UH3T//7cSRCT1ss7vh7aQm3jYA8GK4hCfCMUlU2fVD196olL2Qh1BqZRWdA2jQ/Tko4siKGXApYZzpComfsBvKWNRK2n4abqfGBRyKm826H3/697b6PfAtN1B0PwzfJboN18/+homosBfUWcthet+dVVILI0ZICkIdRf4w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66556008)(66476007)(66446008)(54906003)(76116006)(66946007)(64756008)(316002)(55016003)(6506007)(7696005)(9686003)(71200400001)(110136005)(82960400001)(26005)(52536014)(122000001)(83380400001)(478600001)(4326008)(8936002)(8676002)(5660300002)(7416002)(2906002)(86362001)(33656002)(41300700001)(921011)(38100700002)(38070700009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UB+UYmKAba+5sjEdEi0KsnbqNIQH3HGmgMk8rJ/VJARgZ7IJa/dUXVZz2lRH?=
 =?us-ascii?Q?ZLddpjXYovFA8FOMBx18P9JMzYm1ZzmssMRsEXsxXXord9VBUmZkKSujQNAS?=
 =?us-ascii?Q?LaRU6dpNq+JGon65CrbYgM7QH229pdm2dq8QuiEaYYPTyA5YNx6n/kZCTa7S?=
 =?us-ascii?Q?LLLylV/Jx1RZZz0ruzK1IUTTWvNIPLEtRuvZ6p8M2sbW0ui3uDaV3f5u/kA+?=
 =?us-ascii?Q?7etgbDu/5pVUyn3cgL/ASpdr28GR/6B4+g7/XqawCvBv+Kpn5GkkzUiXJsfU?=
 =?us-ascii?Q?vkZjdxf/xCRvFmeIghnbNEHLsG19t+/ftfdtwJL69Dy9h6Xwubcbi6aZqcor?=
 =?us-ascii?Q?8hqG/+ZbVM9aH8gfIMfDdDWAJIwelDwKjG9qECH+RKWaj7d4gAUs/qrTf8EJ?=
 =?us-ascii?Q?4FAfy45DuYJFugo/2EOOE1DcVnFMDnV6ezfFIx09E6hIfwN1xwiOMG8IbArQ?=
 =?us-ascii?Q?S1lUCj7vtHuIdwwbsmAQsTDMeqXTyO/GDDaarogCBpNz6TCSInSC0+9/gcHH?=
 =?us-ascii?Q?Zmn3Ljm0l0E+WwdBDqJsSTmb78AyLB6jjjyDqvtEyjGK4ZcWYhsCwsI0Ij+G?=
 =?us-ascii?Q?r9F0QGnLxuQSXXkt+pghVLWLTnbzCFWF7UCa9LMyRGESjC46AbAeKhwmZntR?=
 =?us-ascii?Q?9A0Dry+m7PdOhePRn77zl++cYURgxDMJUTnO9I2fjRuVaQ4VKyPXbKCkbJsS?=
 =?us-ascii?Q?CRukd3bsztRLLsMfgsoL7o7izIR5V/PyeS/ptxxoyVud9kWYY2vJ2g65G10m?=
 =?us-ascii?Q?EXAMN0d/ACwuDEW/2g3NOu/traZC/WhkNn8wrfGgoyd+5oIOk3zURLEnVo43?=
 =?us-ascii?Q?4itLU8wgpT5Ic3BEdfigRkcI4pJCHo5KnYDKPCdoAZjArooGzitJSu+90SMY?=
 =?us-ascii?Q?xVx2l+Bg/9PLbCrzLxnw9szuvVOJrziFX8WLGxvpsU5q7sEPdBmlUxJYODSk?=
 =?us-ascii?Q?mqT2j4Ya1+6jDWhtHvE6fIYwz4AFpwesVf5Kg7jRQgP9m+/8danF69yMeG92?=
 =?us-ascii?Q?ZkzMRh539DXmeMb/uC+nxFI3Yr/+0vTMhPn0PWGPEaHOqNUUSgdUNfCst43+?=
 =?us-ascii?Q?yqMSLQwG4h8ipSxBUbcb6i/v9OW0TTrtV4WrhXoFot/5xk1zx5B1IsQXRK1J?=
 =?us-ascii?Q?MqjtoNR6XZSIWClijwGh3PLAADUM2yjTM0tB0lDyBmidRzHuD4o/pYeLgYjv?=
 =?us-ascii?Q?XdLw01RYcgHWNCaAbCSOSUYYcL92JNlgiNcj+0sKlx8OQQ1owH0f+s9RvTNz?=
 =?us-ascii?Q?gtP0X7mpiPtGAlSh4mOpn9D2sMnuLkwlv6viGVzbtG/bpLw78VoXMdn1+w65?=
 =?us-ascii?Q?vohZmefO5mSAPwU9NXLPm/b4AFemUHFu83J/HJfeiiHQsuCTODSnZgRnN9U2?=
 =?us-ascii?Q?oRaRonJ5BlNLYvdcbiQOaODA2kivt2pInbHqnwRPM6mr4mqzpRcmkfLzN+Qv?=
 =?us-ascii?Q?3vYhmHwyqCK4gIXVhtHWocU/GvY3uud1vJF6IsLmQiWVIpjNeLKu3IKc1Kfs?=
 =?us-ascii?Q?ctwswL53YRhrPsmtbMWiV6MxMxA6up7QDmRXRkBAl9GXRBq6K7+2/l1wWz7l?=
 =?us-ascii?Q?tyaRPkCyuxtEBarM/oVC99Uth/NgvBZYFCVlx/my?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb75c921-b9f1-4465-69f8-08dc17f7a711
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 07:32:40.6681 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iXrY+ybF4a+jntAPNFpoYzdTTLWpVNeZKk0LvSCpnqcTaJ+b8Pd8Glunb70EVUkXwTPX6DY5q8e42zA7m/12GVBtEZ86RboizgP8TbtLS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5023
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC 2/7] hw/pci: Introduce pci_device_iommu_bus
>
>This helper will allow subsequent patches to retrieve the IOMMU bus
>and call its associated PCIIOMMUOps callbacks.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> include/hw/pci/pci.h |  1 +
> hw/pci/pci.c         | 16 ++++++++++++++++
> 2 files changed, 17 insertions(+)
>
>diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
>index 63c018b35a..649b327f9f 100644
>--- a/include/hw/pci/pci.h
>+++ b/include/hw/pci/pci.h
>@@ -403,6 +403,7 @@ typedef struct PCIIOMMUOps {
> } PCIIOMMUOps;
>
> AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
>+PCIBus *pci_device_iommu_bus(PCIDevice *dev);
>
> /**
>  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
>diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>index 76080af580..5bf07662fe 100644
>--- a/hw/pci/pci.c
>+++ b/hw/pci/pci.c
>@@ -2672,6 +2672,22 @@ static void
>pci_device_class_base_init(ObjectClass *klass, void *data)
>     }
> }
>
>+PCIBus *pci_device_iommu_bus(PCIDevice *dev)
>+{
>+    PCIBus *bus =3D pci_get_bus(dev);
>+    PCIBus *iommu_bus =3D bus;
>+
>+    while (iommu_bus && !iommu_bus->iommu_ops && iommu_bus-
>>parent_dev) {
>+        PCIBus *parent_bus =3D pci_get_bus(iommu_bus->parent_dev);
>+
>+        iommu_bus =3D parent_bus;

Variable parent_bus can be removed.

>+    }
>+    if (pci_bus_bypass_iommu(bus)) {
>+        return NULL;
>+    }
>+    return iommu_bus;
>+}
>+
> AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
> {
>     PCIBus *bus =3D pci_get_bus(dev);
>--
>2.41.0


