Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4474274A90F
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 04:36:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHbJN-0007jJ-QZ; Thu, 06 Jul 2023 22:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHbJL-0007j6-G3; Thu, 06 Jul 2023 22:35:07 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qHbJE-00069B-Ag; Thu, 06 Jul 2023 22:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688697300; x=1720233300;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WkemDw7GMCbZ3RcbwseqdnCo3JHjkRFPsHH6K8SymGQ=;
 b=LYkrNr/oDnOtsOqgpoxPULdCnDh9pSm4qbgMLP23rnBoanRP2NSOmsR2
 xWFtUPwojiNyqOHgJ2giojlLs1V8M0be7DkLCx8MFdfJzkkvkuPCT1TtG
 dwwAEZ2cQWp+4sldtDHhiYaO68xsgkb+W3N/EpH8GCYZYnPcvPRRbU1ck
 3YHtO/IIlFA61tqJBCcA+//mkWQGYU53nuOP1AvPAQwib/BfWBZtDb95Y
 K+tNSA63jYlU4LaIp6LlvFQv2w9vTk0M4hnZZTKSLIzkQKjXPcxk//nPS
 F3jaPht97eFqFP33dicJ0MWj5xn/wKuqdAt+oFdNfOT6dnfisV71bQZWx w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="361257168"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; d="scan'208";a="361257168"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2023 19:34:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="1050352177"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; d="scan'208";a="1050352177"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2023 19:34:51 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 19:34:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 19:34:51 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 19:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMw32JtxUczjk7SyHi/H/2pb20ZjR7foX0NjJf1Ra226uO8JJGqZgayVaVIagjqdEsZpTAWQOi7J/wB7mQ4rZ7qu9Dezmz4Z3XS53XNOO2Xgu/CX+GXFBYatbqeN5D9YGtCqlgmzPtbQm+kDpGJYclTgLq7+Mly0uIdj417WXsVq9y5KHRv2I7dRXV17Rp+Wp2ofA8n7y8jMilqPGZIMcmsm3RYnKorUpOFgXBoU+r0JZ1QLXL/IBtrH73cBo4pD8N45hQ5/S1dCRvqrAozmX0+D67ilQjMsPUmFBZAjIQahuZGm1YXu1UTgy9imSpUhlDedyl3OSmQCRDbcr6e/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AtGVN94T5vnxBh/B7ym2YbIMUUMcCyZ46UURgPfafKI=;
 b=b9dxWeqZfi0WGQWYEiD6Ph4aaA2vqCml3AFpiVkN6ERs907RArtZnsrp/buHlvq91zH/FP88GQS0VHEZvYcdL4Zgq1jNNV9Mghu6Z0U0D7BE5cu1Rl8eUOIPGjI9wAxbHfCL+CbqjynU7ueY9yoJ+O/4YDChj1OG9pT88kW/AR64jlb7ccl6SOJ3RLigVrPnMV0xvzigLozF2ZODqhyxryViLVDqbBHPpS1EVB5MynsVUbWI/+NaoNVsMTPxEcB/+eDuahVT2uyAUhuKJOyfNpEF1kl8cCcxlFlO3FSpcVHUi2D6hwzWLZc86NKtTuqYRQ2WjRC0RLXqXnceukJeJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5117.namprd11.prod.outlook.com (2603:10b6:a03:2d0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 02:34:49 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Fri, 7 Jul 2023
 02:34:48 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, Eric Auger
 <eric.auger@redhat.com>
CC: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhap.com"
 <clg@redhap.com>, "bharat.bhushan@nxp.com" <bharat.bhushan@nxp.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Subject: RE: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Thread-Topic: [PATCH 2/2] virtio-iommu: Rework the trace in
 virtio_iommu_set_page_size_mask()
Thread-Index: AQHZrmjmjixANg4+sU2QQB+pIVxfpK+qnCOwgAA38RCAAFTtgIABqGyAgADH2WA=
Date: Fri, 7 Jul 2023 02:34:47 +0000
Message-ID: <SJ0PR11MB67447BB4E421F13B49EDB2A2922DA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-3-eric.auger@redhat.com>
 <SJ0PR11MB6744FA4E41101F7EED607E9C922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744AEDC41BE576A59908A30922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a11b8c79-9efc-6686-6405-863abb8824ae@redhat.com>
 <20230706143535.GA2570588@myrica>
In-Reply-To: <20230706143535.GA2570588@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5117:EE_
x-ms-office365-filtering-correlation-id: b4d69d20-b512-4a11-bf84-08db7e92bb54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X3V0T69LK9aqAC6kL6lSfHqXcc/TV1evR5qkKkH8jDarrceFD2NPVTRhzsgc1rYbEH9K4H/2pGWXl1R3UyrjcdLGs0eVhrcMx7tW8tBxUchOb3nImdt+DcQsBewbryjBnUFcB8gsZ7hTZ2WvGlB2sEiCxC0E/SsfelpnXi4xvBZJEpiKW2r8fJkXXeDXwSDaO/IQZXb+IUX+b8NvZOCm68y2Ijz8Df5Iy+lvGwOD+rx78htoPkm09NZAzilCpojIBajzcDzBpIaumTICTuX7TGnaMT4UqIcZc+RSlV+ImYIIImfHojsJLXgKtueyzfTJq2MMbhO/vBKr+12EFFQ0blwyz1fsoahvprZsy1p6M5fWmsAfdJX63g2aiDQu/35i2g94nJNULDgGvxQ5SzckplprgnSfLyvL/PLVqxObQcK23YietwQkKYRwOIqDyfeuN+C4K1iDS+1Do2tCcBFoaWyAyTAbkMO30qpG2nQ49rjhBZmtbO1Knxosz6CQUph3xdql/LhgcivDu9FVL96vJ4tP1BzdFOg592tl+nGYfbs+NXbRs7Zf8F/1zoDdu2FG/Sp75v6mGrzrjs3Tmt+kiL7ltQdpZH9XuvRjHYY7o52Yt1DkJ4vj/1MHsTRD+qvJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(39860400002)(396003)(376002)(366004)(136003)(451199021)(5660300002)(7416002)(2906002)(33656002)(86362001)(38070700005)(52536014)(55016003)(186003)(83380400001)(38100700002)(26005)(9686003)(6506007)(4326008)(71200400001)(7696005)(122000001)(66446008)(110136005)(82960400001)(66946007)(66556008)(64756008)(54906003)(76116006)(41300700001)(478600001)(316002)(66476007)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Vlm43D+m+Zxn0fSvuWdYKYun8P7mG/hElfbPtJRvFD+AFGkOgNrQMvdWazI?=
 =?us-ascii?Q?e6LEhly1hX3qcJBUr3EqnJpkfS7njgATL2IfBAekMQ6fXemTbkrlP0fSwVDC?=
 =?us-ascii?Q?iCA1y5Eu9zqR6/LptsBzghoDvcQ4AFAzH6iQMGPuIiC6GNbWY0SyX5BCU6TM?=
 =?us-ascii?Q?Nrep8f78dao+5P3En9H4LL45EhcYNySXwcmeCs4tMmb9uNVmSp5Y645eX8KG?=
 =?us-ascii?Q?iHVG3c6EARjV5qtGuFMz4m4U5pxQMoLPdimhW7GKhcPvKGs3XDV+Tsxo/h01?=
 =?us-ascii?Q?x7BcurZTOzkRB6gYzH+hNs6qzStMBL1gNtkDm+hOHsHfLlVCmnqKkDb5BHLo?=
 =?us-ascii?Q?db81yyamuoH/p6xL+BBKmST6NO07EaQpD7SJXts18CKI9eTWwwBY9yWDktxL?=
 =?us-ascii?Q?tpgXb56B3VnhVFXl7vdU/AnlRFPxjaC/FeyADig5/tgzvItz/tSkCIAn9tfF?=
 =?us-ascii?Q?5JnvipaYwjon6uwkHx7nTYC1fqbCw5mYqsxYwdmxrTl/C4XJ8v1H2WglRB/8?=
 =?us-ascii?Q?6THfnc8nyX1Xts/f8CWBoEFIF2obmyATfXUuhIimN79e57tqWJ1X3RLKQvpX?=
 =?us-ascii?Q?/We/NBJ2jVfetOnzmAgD/gqbCHs2LMMFvMeuM4PrYdA0TUHg9E5LoTLeNyVu?=
 =?us-ascii?Q?NiDgTLHFNl/SFT8/eTfOseHGc3M/adU5PQ2UM+hhTbUx9habSQCks+u36Ygq?=
 =?us-ascii?Q?bnk49PhCNYeBwD4mYtfZT6EtZ3w9JQ0/zbKGWwxLsT9U6EgrZGP16l24MtU7?=
 =?us-ascii?Q?fS7vU0+mEK6yWmz9X5a/ZyHntmEJK7vABJUqo9ODyuwCXxTw76zV0eXnbqwD?=
 =?us-ascii?Q?cUGAR52jGzPVqeVIUszlDfFmJ7aLKeAxiCnsp0rMw4l0dk2vSOGmaaQ1+5NI?=
 =?us-ascii?Q?HPDR2afBQ9IbsZYW+DLS3XJiF5gYnN9bLMtwv742mCjFZaqJYv2v+LZMX4fR?=
 =?us-ascii?Q?i7tD/2mBvPcn4AGuWSUj91EN7v8bhmJz/6y7pCz4cmiBHCXGZTG1O6bpds9Y?=
 =?us-ascii?Q?urGO73iRrBBBH3ZO9H3gORM6SY009t75wdVIHOVL+PE/bJ0WVZYud9DEfg6z?=
 =?us-ascii?Q?WR9ptnGUk6RUjMOBV/9NSE84kF8E9AqYoTUtM7wJg1PEfYU1lKQ74yx/AOE9?=
 =?us-ascii?Q?y2l+3S3H2gRlIgJQbfbez14T0OIhrXbdYGyYBtVBppV5SN+D9o8BykcKhOc7?=
 =?us-ascii?Q?t+jubezAe2b3cW/eUiOLp6cMAs46Yl3EqE4IEH/mHXx8pUulR4+6CX0/BdtS?=
 =?us-ascii?Q?CflrVyrvrsRVWFMa+o28C/1gh2pjoMzihwfFvNYXM83ZPN/iT7HEOiBD7jpZ?=
 =?us-ascii?Q?uGnTfVTyW/xN36Lmran/XjoEIgRYh9NAf/n7wMQfR4pKbWiaTmysHV9GJruC?=
 =?us-ascii?Q?32S/tjO7UbKt/4zzgomtzTLEapJBkr2ekPmMuq7isiuw2vi7gb22ISJeALQD?=
 =?us-ascii?Q?5/MRu966cnLTsTDVR9mEWInOcNXyXUyxV72eXWUsaE3wx+aZzdx7IKpqEzHR?=
 =?us-ascii?Q?QvAJXPY6O0y24rV2Kx+7VLCc7yo73KyP77uCS1yZoyImpFdIVaFRjL1y9Eb7?=
 =?us-ascii?Q?shYwvKkDd7j0L2bGUrxA1kA0Cu7L6RN7nrizrWMp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d69d20-b512-4a11-bf84-08db7e92bb54
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 02:34:47.6139 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aD4QF4j4eYD3j+UqfRH/EpbDprcZK/gW2fsUvfaK4Sw9I5RmAbjDPs6cBh/85hOi7SWiV9z2EgAGSiCvwWuh8/PmJGqJxOmQz0NWckorU2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5117
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
>From: Jean-Philippe Brucker <jean-philippe@linaro.org>
>Sent: Thursday, July 6, 2023 10:36 PM
>Subject: Re: [PATCH 2/2] virtio-iommu: Rework the trace in
>virtio_iommu_set_page_size_mask()
>
>On Wed, Jul 05, 2023 at 03:16:31PM +0200, Eric Auger wrote:
>> >>> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
>> >>> index 1eaf81bab5..0d9f7196fe 100644
>> >>> --- a/hw/virtio/virtio-iommu.c
>> >>> +++ b/hw/virtio/virtio-iommu.c
>> >>> @@ -1101,29 +1101,24 @@ static int
>> >>> virtio_iommu_set_page_size_mask(IOMMUMemoryRegion *mr,
>> >>>                                           new_mask);
>> >>>
>> >>>     if ((cur_mask & new_mask) =3D=3D 0) {
>> >>> -        error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
>> >>> -                   " is incompatible with mask 0x%"PRIx64, cur_mask=
,
>new_mask);
>> >>> +        error_setg(errp, "virtio-iommu %s reports a page size mask
>0x%"PRIx64
>> >>> +                   " incompatible with currently supported mask 0x%=
"PRIx64,
>> >>> +                   mr->parent_obj.name, new_mask, cur_mask);
>> >>>         return -1;
>> >>>     }
>> >>>
>> >>>     /*
>> >>>      * Once the granule is frozen we can't change the mask anymore. =
If by
>> >>>      * chance the hotplugged device supports the same granule, we ca=
n
>still
>> >>> -     * accept it. Having a different masks is possible but the gues=
t will use
>> >>> -     * sub-optimal block sizes, so warn about it.
>> >>> +     * accept it.
>> >>>      */
>> >>>     if (s->granule_frozen) {
>> >>> -        int new_granule =3D ctz64(new_mask);
>> >>>         int cur_granule =3D ctz64(cur_mask);
>> >>>
>> >>> -        if (new_granule !=3D cur_granule) {
>> >>> -            error_setg(errp, "virtio-iommu page mask 0x%"PRIx64
>> >>> -                       " is incompatible with mask 0x%"PRIx64, cur_=
mask,
>> >>> -                       new_mask);
>> >>> +        if (!(BIT(cur_granule) & new_mask)) {
>> > Sorry, I read this piece code again and got a question, if new_mask
>> > has finer granularity than cur_granule, should we allow it to pass
>> > even though
>> > BIT(cur_granule) is not set?
>> I think this should work but this is not straightforward to test.
>> virtio-iommu would use the current granule for map/unmap. In
>map/unmap
>> notifiers, this is split into pow2 ranges and cascaded to VFIO through
>> vfio_dma_map/unmap. The iova and size are aligned with the smaller
>> supported granule.
>>
>> Jean, do you share this understanding or do I miss something.
>
>Yes, I also think that would work. The guest would only issue mappings wit=
h
>the larger granularity, which can be applied by VFIO with a finer granule.
>However I doubt we're going to encounter this case, because seeing a
>cur_granule larger than 4k here means that a VFIO device has already been
>assigned with a large granule like 64k, and we're trying to add a new devi=
ce
>with 4k. This indicates two HW IOMMUs supporting different granules in the
>same system, which seems unlikely.

Indeed. Another scenario I can think of is migration from src with 64k gran=
ule
to dest with 4k, then hotplug a new device with 4k. Not clear if it's allow=
ed
to migrate between host with different granule.

Thanks
Zhenzhong

