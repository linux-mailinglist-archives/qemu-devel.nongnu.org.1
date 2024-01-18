Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE583134C
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:44:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQN3W-0004sr-Tg; Thu, 18 Jan 2024 02:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQN3U-0004sd-Mm; Thu, 18 Jan 2024 02:43:16 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQN3S-0002Xi-FP; Thu, 18 Jan 2024 02:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705563794; x=1737099794;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=eH72y9bVPRoSxwthODW2NKPIrY+N6l7DjTmiJaEyJnc=;
 b=Xrfy7bl8AynR/OvYLSOUs3n7WNSMgPDmjVjqBFsqQMIngi/T38nmeE+k
 DlYL59OAQpW5CufV2KdkL3ENUxIXBW0Vytn8i+NlPBlHK9EL2fPtMA15y
 RVlBDNJ76Cw+9yrtIUG2oMLaYNs0CgeKu+VgexZ60T5JqDL05e8qdS2U5
 NupkRmyVjJsPN3f4XgfTZqPlUm79dVH8pEEPvoJ9L+y/O7wJFNlbEOau+
 F0pg1xrl2ekloJo7euwUUpxpKiCjoErwmgT9ZRv4/nUnZD7oxopAE9txO
 AjHhKlTHlSk3A5crRLzV5s20RBnkkIbJdSKj8hLLXa2kC393T4OlLCw8t w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7082574"
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="7082574"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jan 2024 23:43:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,201,1701158400"; 
   d="scan'208";a="214000"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Jan 2024 23:43:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Jan 2024 23:43:10 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Jan 2024 23:43:10 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Jan 2024 23:43:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXW7AuQLMJY4dpyIi9fw+ECggXzJ/ocbnoPRS76T+C8f3RhiYXiBKDon0FMeuZtzNdZ/EHBgtSaLVG9MvL3k3Jaj+oRz5+XxORrCLo/jKV3Jc6X7jbmV3Wq1Ai8hLmNT6Igmlq2YIy+Wokz/BiWoDhlOMtlf0vdUMdgjm87rTPQQ+WwFJbXZawvO9T3mQnlGdWSo+ZLf8vu5DqTn4fOEseTvglvA24w/2PZbqM3xWzU6ayM1CSRp3J5uPkjTBSVZkiZ+U6r3j7rfl9RlFASwREV9+chVV3Icm431GFLr2tm4CMJO27lhrAev/ZmNH+WgytFz035QAWFuk78u8A22xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6Yb9lJKys0A/9NtspqxRnd5MgBhjfBdtndVwXlBZUM=;
 b=cW9+XsILs8AMAo9KdGsJxBJBClR69CRtXz4inWEAw++2z4KjdqvSme2Jlj9fFKifN/8gUOrMWGfn7XE1sX2Sd/VOITxIHtw/8IqH7Dy30bZZkFAgnRvmX6W1/7c4NJpIO52NfHV/e+UVnnzxfEELjZfKjgPyuemTPgE86FFHQ386zeueXuN7HnXXXvfA2zTH41JzPzHr3RTS09I7lFvYjvqnxWMIdUhRgitVphQY0J7Z4m5bq9z/gtdGcoDukJGc9FMLgCDwQjCErvEOiF/Jj3YVCwyP+tZtTb+qPLgoJclGSXzmloIQMJXaO4l/26zcJyF16W5ZVzsi29ztsQfusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5642.namprd11.prod.outlook.com (2603:10b6:510:e5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 07:43:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7181.020; Thu, 18 Jan 2024
 07:43:08 +0000
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
Subject: RE: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Thread-Topic: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
 set_host_resv_regions
Thread-Index: AQHaSRvZODIWGRgczkWQzR/Sdm1iRrDfLnsw
Date: Thu, 18 Jan 2024 07:43:08 +0000
Message-ID: <SJ0PR11MB67443F1D15B5959A77B60E3F92712@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <20240117080414.316890-5-eric.auger@redhat.com>
In-Reply-To: <20240117080414.316890-5-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5642:EE_
x-ms-office365-filtering-correlation-id: 4ded0c3e-68e7-480c-5811-08dc17f91d1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STcImFCvbuW8jfdSQhA9SFewxnSa08O/bq74vDKcKy3cV3n5iIgduzIfxihUWKkpQ8gbRlvFXMsqFt8CypPIR637KFdjKMXqpHUKRJuZWW8t2ts/3BJoPSCd5hlrmBMhrhMhCbdzu5Sf85/euXe22MNrXPpUT26LeVU6xR8wYYLvG1w9Yjk7ZR/sm6nQnc4kfeNVSvokZsJ2HX0Pxen67wV06N0XdH/ZeQIhWmFvpq+xmuRiDx2K28DsO96hGFqFgSyptDhxqtovX5t51ZfyysXvDtdk+ZfUWNGqnpT2RWkqNAvEvdqhOwUSIbsnvEusSlkt0hAPqvV7dkwj1/RYPomIV/FcgXqNgxhnTmxKKvF+SPj3FOXVYjorKiSJz7aO9U2aF1dIUt/u5HH5VWSp2wn/8H5jhrnSGtvlNZsagq84drJKnQ+cZc/zo3VGb74yLxxOMYCHTjpWwjp8aelC/9UobvgZcB04R9i9Zfz9V/PPsT5hNB8XV/aynB3HSllWSGOGBfoI90930y0JEg+VUFE6wkHHoTkW/V7kAYcRAkOnjBOW1sIgebRKX0Ha5Xz5E1cUSpv6t9pvrR8aDnwoKtQ6VKlsZi+WXQqatfqCM3SSHFzPfNBnC0O3MB7pC7jLVABeUe2+lHEZjW0DklIx9LqoxJFzUJTRZI3q6GEWhGQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38070700009)(921011)(55016003)(71200400001)(83380400001)(8936002)(478600001)(52536014)(4326008)(7416002)(5660300002)(66556008)(316002)(76116006)(110136005)(8676002)(6506007)(64756008)(54906003)(66446008)(66476007)(66946007)(9686003)(26005)(2906002)(122000001)(38100700002)(82960400001)(7696005)(41300700001)(86362001)(33656002)(309714004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AoeC9wswhCPAAK4reU23azBUDVqETb0o++4HblzLGlkoiBH93q/NI7bAUxgV?=
 =?us-ascii?Q?xNpGQ1eHA/7EL6hFMsH6uf+sY3sL+h2jl4sXrQ9RKhAc3MKnayI62yvnf1OH?=
 =?us-ascii?Q?X4g1YDsbEO4oF03EJKkGcji3NObU/aeEXiigJ7AaRAGFLpidYZEYVLwDIvfx?=
 =?us-ascii?Q?UeWj/RgBZW+IrgYabuPdiv6o5JN9ukF+/evkCcxmnBKLsjSVVMlt1067Esbw?=
 =?us-ascii?Q?f2IyTkJU/rYGsdyFXLORpplszHh7tjGQZgAyl2EJbevnS9OfX8JQyPebeFrY?=
 =?us-ascii?Q?tYAw7YVX2B70szBoE1/wXVJLmt1leYXjOrb0pc02ZlECqjIXiCH6IWIVxbCH?=
 =?us-ascii?Q?12qSpx/p9wut9WU6fcsgZreb96f+BrnNoiuJ8FdGdvkd9N8dIO77KA1geIu3?=
 =?us-ascii?Q?BY1xTVBYncMQGS/RkSKS+3phGIsbY0XZrh2oEgidMNZFgyNlnUlzOK8QDEo/?=
 =?us-ascii?Q?VUFWgID7tv4rZmmvwwy9+4rd5om64rj3OYY9P8MlX7NipioNiccSGUGZclmX?=
 =?us-ascii?Q?vH9oJFaLFdg6Vs69VYtseEIWdSPbXpqzRaISS3KeG9p5IbOJ1PIeAJ5EjLQ/?=
 =?us-ascii?Q?R0ES8C44Cgyv5ic4dH63okumpMfa3PI3tiGjEyWX2Swm5Lyp96Vu5IS8UUlI?=
 =?us-ascii?Q?S0bB35IbSH6zl1rUE3DmN/8c63uY0n8zZFrDM0FCo+Cckdc9OiWoVU+8UGqU?=
 =?us-ascii?Q?sJ3eLBkEF6/z9z9mjSmhVwDF3TTuhTDk7bzH4hKtIIa0wVkhEeyItvAp0/it?=
 =?us-ascii?Q?LeY628iBd9VmLxTilQENJnsOQSGgMORQIfAlJ1gItJHMmCg2rfYqe4U7rsuk?=
 =?us-ascii?Q?tSjP1ZvFRF4bWQQZIJCRQOZjTeFsMlwkf7o9RBvpQLVWmbBOYxwyJ4Py8Nzb?=
 =?us-ascii?Q?/frlA0ZFlcmxkfRY6Ns3TCnUDJ67uwYQFzCRneT12a7xUr5J4cKpplUAvXWw?=
 =?us-ascii?Q?N/+IkPNg5f8Cu2bvvP7axvmwxzdxcjU3l40D2rhHJ1vY2ah3HFmaxjV7aMY1?=
 =?us-ascii?Q?fxS5M77jTa20VclCUXeIqpi70oHmfUC10pdQ8gmir33LEcrV02qCr4GgYU0x?=
 =?us-ascii?Q?g1GVMqlNTjl2Z0Bm00EYuQ2xP9CbwONxDwFMtx1aVAyw3/LwL2mT/TqxQEKn?=
 =?us-ascii?Q?NlJ3EYIhBm+yXd7WGsKHOl5dfkrcBZIhEDGalwyVRzfvfd9WWXVW8HogGyrQ?=
 =?us-ascii?Q?qkbuhlYJ5i4ab6NhrRmK/6uyHlgioQxLz+y++bsHVyhIBqf/n2f2u9VwLp06?=
 =?us-ascii?Q?2KcZQwptCvSTx0MnHKS30SWusiPBTwAjHgr1wYwHKbWsIIQ/5jTZMhhurIeG?=
 =?us-ascii?Q?xFE3DM0Vj7j0cptY9Tsom2+5SB5Pp5Wr5B7YzECZDsYae553fT3TqctLF/3J?=
 =?us-ascii?Q?ub4RD6mcyDEfJJ32GuEW+63/4qbF6wGw2n7shC23emegaWR/LlwHFvjb3CCO?=
 =?us-ascii?Q?qbPcpY6NO9D5CHfP1glEvAp7Wvss0kuiSq5PgSSiQP4k48I0NM6ruUrve3ZI?=
 =?us-ascii?Q?X5r0XryjuxlXW2E5Tgr5Y7kPL6bxvSESoZHRaXbdPSto9t71oBrNTXumtWeG?=
 =?us-ascii?Q?LqTHsUuAUSjCtV2kWlkyBgf5G3bNTFYgYbBf39Hj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ded0c3e-68e7-480c-5811-08dc17f91d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 07:43:08.2240 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pkI7BKMPundeQqeHJyGJJrO3couY6XG4MYcTk+t0AiTVOLxJSigMSLGDwod5gklJ+OnLgj91l3v2bxv8kVyxgfWYBw04hQ9Gq7rlqrS/xb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5642
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: [RFC 4/7] virtio-iommu: Implement PCIIOMMUOps
>set_host_resv_regions
>
>Reuse the implementation of virtio_iommu_set_iova_ranges() which
>will be removed in subsequent patches.
>
>Signed-off-by: Eric Auger <eric.auger@redhat.com>
>---
> hw/virtio/virtio-iommu.c | 134 +++++++++++++++++++++++++++++---------
>-
> 1 file changed, 101 insertions(+), 33 deletions(-)
>
>diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>index 8a4bd933c6..716a3fcfbf 100644
>--- a/hw/virtio/virtio-iommu.c
>+++ b/hw/virtio/virtio-iommu.c
>@@ -461,8 +461,109 @@ static AddressSpace
>*virtio_iommu_find_add_as(PCIBus *bus, void *opaque,
>     return &sdev->as;
> }
>
>+/**
>+ * rebuild_resv_regions: rebuild resv regions with both the
>+ * info of host resv ranges and property set resv ranges
>+ */
>+static int rebuild_resv_regions(IOMMUDevice *sdev)
>+{
>+    GList *l;
>+    int i =3D 0;
>+
>+    /* free the existing list and rebuild it from scratch */
>+    g_list_free_full(sdev->resv_regions, g_free);
>+    sdev->resv_regions =3D NULL;
>+
>+    /* First add host reserved regions if any, all tagged as RESERVED */
>+    for (l =3D sdev->host_resv_ranges; l; l =3D l->next) {
>+        ReservedRegion *reg =3D g_new0(ReservedRegion, 1);
>+        Range *r =3D (Range *)l->data;
>+
>+        reg->type =3D VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>+        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>+        sdev->resv_regions =3D resv_region_list_insert(sdev->resv_regions=
, reg);
>+        trace_virtio_iommu_host_resv_regions(sdev-
>>iommu_mr.parent_obj.name, i,
>+                                             range_lob(&reg->range),
>+                                             range_upb(&reg->range));
>+        i++;
>+    }
>+    /*
>+     * then add higher priority reserved regions set by the machine
>+     * through properties
>+     */
>+    add_prop_resv_regions(sdev);
>+    return 0;
>+}
>+
>+static int virtio_iommu_set_host_iova_ranges(PCIBus *bus, void *opaque,
>+                                             int devfn, GList *iova_range=
s,
>+                                             Error **errp)
>+{
>+    VirtIOIOMMU *s =3D opaque;
>+    IOMMUPciBus *sbus =3D g_hash_table_lookup(s->as_by_busptr, bus);
>+    IOMMUDevice *sdev;
>+    GList *current_ranges;
>+    GList *l, *tmp, *new_ranges =3D NULL;
>+    int ret =3D -EINVAL;
>+
>+    if (!sbus) {
>+        error_report("%s no sbus", __func__);
>+    }

Do we plan to support multiple devices in same iommu group?
as_by_busptr is hashed by bus which is an aliased bus of the device.
So sbus may be NULL if device's bus is different from aliased bus.

>+
>+    sdev =3D sbus->pbdev[devfn];
>+
>+    current_ranges =3D sdev->host_resv_ranges;
>+
>+    warn_report("%s: host_resv_regions=3D%d", __func__, !!sdev-
>>host_resv_ranges);
>+    /* check that each new resv region is included in an existing one */
>+    if (sdev->host_resv_ranges) {

May be we could just error out as vfio_realize should not call
set_host_iova_ranges() twice.

Thanks
Zhenzhong
>+        range_inverse_array(iova_ranges,
>+                            &new_ranges,
>+                            0, UINT64_MAX);
>+
>+        for (tmp =3D new_ranges; tmp; tmp =3D tmp->next) {
>+            Range *newr =3D (Range *)tmp->data;
>+            bool included =3D false;
>+
>+            for (l =3D current_ranges; l; l =3D l->next) {
>+                Range * r =3D (Range *)l->data;
>+
>+                if (range_contains_range(r, newr)) {
>+                    included =3D true;
>+                    break;
>+                }
>+            }
>+            if (!included) {
>+                goto error;
>+            }
>+        }
>+        /* all new reserved ranges are included in existing ones */
>+        ret =3D 0;
>+        goto out;
>+    }
>+
>+    if (sdev->probe_done) {
>+        warn_report("%s: Notified about new host reserved regions after
>probe",
>+                    __func__);
>+    }
>+
>+    range_inverse_array(iova_ranges,
>+                        &sdev->host_resv_ranges,
>+                        0, UINT64_MAX);
>+    rebuild_resv_regions(sdev);
>+
>+    return 0;
>+error:
>+    error_setg(errp, "%s Conflicting host reserved ranges set!",
>+               __func__);
>+out:
>+    g_list_free_full(new_ranges, g_free);
>+    return ret;
>+}
>+
> static const PCIIOMMUOps virtio_iommu_ops =3D {
>     .get_address_space =3D virtio_iommu_find_add_as,
>+    .set_host_iova_ranges =3D virtio_iommu_set_host_iova_ranges,
> };
>
> static int virtio_iommu_attach(VirtIOIOMMU *s,
>@@ -1158,39 +1259,6 @@ static int
>virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>     return 0;
> }
>
>-/**
>- * rebuild_resv_regions: rebuild resv regions with both the
>- * info of host resv ranges and property set resv ranges
>- */
>-static int rebuild_resv_regions(IOMMUDevice *sdev)
>-{
>-    GList *l;
>-    int i =3D 0;
>-
>-    /* free the existing list and rebuild it from scratch */
>-    g_list_free_full(sdev->resv_regions, g_free);
>-    sdev->resv_regions =3D NULL;
>-
>-    /* First add host reserved regions if any, all tagged as RESERVED */
>-    for (l =3D sdev->host_resv_ranges; l; l =3D l->next) {
>-        ReservedRegion *reg =3D g_new0(ReservedRegion, 1);
>-        Range *r =3D (Range *)l->data;
>-
>-        reg->type =3D VIRTIO_IOMMU_RESV_MEM_T_RESERVED;
>-        range_set_bounds(&reg->range, range_lob(r), range_upb(r));
>-        sdev->resv_regions =3D resv_region_list_insert(sdev->resv_regions=
, reg);
>-        trace_virtio_iommu_host_resv_regions(sdev-
>>iommu_mr.parent_obj.name, i,
>-                                             range_lob(&reg->range),
>-                                             range_upb(&reg->range));
>-        i++;
>-    }
>-    /*
>-     * then add higher priority reserved regions set by the machine
>-     * through properties
>-     */
>-    add_prop_resv_regions(sdev);
>-    return 0;
>-}
>
> /**
>  * virtio_iommu_set_iova_ranges: Conveys the usable IOVA ranges
>--
>2.41.0


