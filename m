Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3768A7B043D
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 14:33:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlTir-0004Ys-CF; Wed, 27 Sep 2023 08:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTio-0004YM-Av
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:32:54 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlTil-0007Ss-Ty
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 08:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695817972; x=1727353972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0PdQFxyogZVuTjO115I41cdPalzE6qvmStkvrN1jSeE=;
 b=d3BMcXqr9nMFd+LfJoj3S6od8pgMhNBGk3sqUYIxb6aZ4IN74+cJLGn5
 +xNQGlYmWVPN6aD300vGK4+EM3xE6w5l0dR8QV05OSuuljInDqjKt+jng
 i+LcfdlnOeefYyQ9dVOP0c2dZQNT3ZQ4JtXlHpHCqPTBJ26Mzbp67uyxA
 Ipxceb6frWwaUm9ao3PWjtGwkM7Sl/4eVSx5AEUuW7gu8CLoFG3RUZQCV
 TXcxza5P1AxNozPnKRWXIQ/+sTOGX/+U6mIAvE1ym4jVlJVfNWiSaTBcu
 ad+28mlgrsCf7pbOY1txQGGtdCRpLqNhJquSRQjSQCwsm72ZYpi7onJXu g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="409262"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="409262"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 05:32:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="996132158"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; d="scan'208";a="996132158"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 05:32:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 05:32:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 05:32:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 05:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/8kEqFp9tUCQ4AYfKslaXW48t//9GlQVzipHsRqccZ2H3QANc1NSCo5HL2kfwbY1JhebRbcJ22tiqcK2VValLuF5DzbZDaDqEX2fp8BDdod/jgizg90KqcZMeXcv4/6ipM+Qas/ZLWVEH+W6mK+GLJF33rOTv7oYOwFoOHZO8AXtf49VIELfoiX8IsWaIaKzZrnbGLZOTfd3X2re8JN9JCpe+90bSW2wMdlQB2vtZC7bBPHCSs+R8pqV5rHdtWTdUhK/ke4HNyzRwXSHbfIIT/jgfpxiRHkzGVnTKCWkvAYRV/HJ7xy6Vvu5tDx044xeGM1dBCzqcBuF8A2stvk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PdQFxyogZVuTjO115I41cdPalzE6qvmStkvrN1jSeE=;
 b=Ne1DPoVM1CYnO0JU+4Bn1WrTaFfO2A44xfQKj/m2Qu4d+bs1X9hKq1ETqJAjCJRau3RalHVQCVtUZn9Bo5YR3QlLw3Xmk0qTe+bOye6BRvz5+r9x6/3l+rYd5tCNViyEgYdaLGl8BVdN6aTUzLLcWyMK5UpAs0UMaGgSwrIFmYESllw63YnE0T35Dnsx4Fl0WABKURKkTBQlnLGk9SQGYoOfkIRxUB8s9a2hKh1Ww/Xm+HDjwSTkY7KDW00jDVTxeABugioAYhugWHJqe5cip5fI7GobaLZ/3hd8uE8W/1L0EFZnmXgM3pTzeAcSRnZuq7zcLVMDslu6ZXOX8MgMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SJ0PR11MB6789.namprd11.prod.outlook.com (2603:10b6:a03:47f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30; Wed, 27 Sep
 2023 12:32:32 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 12:32:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 06/12] vfio/pci: Introduce vfio_[attach/detach]_device
Thread-Index: AQHZ8G9MBK3w/OsZY02YQxt5EZwDgrAuYYwAgAAQeKCAACfAgIAAAhqA
Date: Wed, 27 Sep 2023 12:32:32 +0000
Message-ID: <PH7PR11MB6722BC6A9DD797DB8BA9631E92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-7-zhenzhong.duan@intel.com>
 <b1012c96-e76e-10eb-2080-af7d8ff606ee@redhat.com>
 <PH7PR11MB6722E62822B43C65DE5187C492C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <b4118ef6-e44f-785c-c99d-c4d8224b88ed@redhat.com>
In-Reply-To: <b4118ef6-e44f-785c-c99d-c4d8224b88ed@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SJ0PR11MB6789:EE_
x-ms-office365-filtering-correlation-id: b7e4471d-4573-4fb9-9005-08dbbf55d251
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqI00yvKmAF8jb69lQdYjMierDaYugYM221cN2fJPKo1soikH/6XshNuwVXVFKuYyoQMEb9zZ2DPBPNX9uG8+0MtpYkeo0cQRuDxY2UL2TBCb6MAY3LFwO9JUwwSh22Ry5kKNQHtuNhPOpjZm66P84nc/ng8yRp/QFb9mk7xgqDs4soACXxFJzN77aL6jidn4zPcDjid/JGz7MqS2N/fqhBOyA6UBzAqpxbB+K3SqTDgGxcFbKNIQPrkrK/rfqcJrB8RnQLVPzJ/Ux6mhC635Lbx6M5do/PhwqHZPwLGTM+9VWDSQ5AtZVU8x3nz3kKkkPsZVUNkUHm9kY5JO7NLYRzguR2J4JDW/n+WyowC4iaj1vWJii63my9mMY9XmuRxiSs0eq9dG3FJlbR6AyplU31czR2KD0cd7r7XznWLYQHz+nGV1/Cq9JRvdP13Pk9ae8ngXTzr2lmUiaQikFUVZqcuID6U3WqGTehz+TNcJLgPk/td8XirOu1Wk/jrLCLapOmCFmJrTwSkN+Fbc8L6pycIH+ARb+PGC+ShZbxaXEHxJ+qGQAcUuyvPt7hEf/bzVb9D5bKYc9W50K4X+KLIstdeTCue4FYP7HjQ4HLbxI73f300JtjLVOkF+UyBLjf+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(396003)(39860400002)(366004)(230922051799003)(451199024)(1800799009)(186009)(33656002)(83380400001)(55016003)(86362001)(316002)(54906003)(64756008)(66476007)(66556008)(66446008)(66946007)(110136005)(7696005)(76116006)(41300700001)(478600001)(5660300002)(52536014)(107886003)(8676002)(4326008)(8936002)(6506007)(122000001)(53546011)(82960400001)(9686003)(38100700002)(38070700005)(71200400001)(2906002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2VCYUNRZkxyeU45MG5FMDhpNG5oV25tZjRFVzRYME40QmNpYWRqZ0RvZXhO?=
 =?utf-8?B?ZFN1TjJaOCtPWTROaVY4RDJFZm5jK0Q0TXJqNnROWHlNRXZrcGIzLzFXMGxX?=
 =?utf-8?B?bzUxTmcxYVBoZzQ2TjFteTFwTFN4Ukg0SitTSXpYZVQrQlRlbjhOcXNFL241?=
 =?utf-8?B?MkJvVVBqQ3RUTXZxMVFLVC9hekx4TEpnQU42UEU2Y280V3BSc290d3huS0VY?=
 =?utf-8?B?azJGQk5rWDZtV21vNmFOd0o3YW04R2YxUm5iYUQxZnVOQUh4Rjl4dmJNL1pG?=
 =?utf-8?B?em1jK3hRZktqN0pXK2xXams4ZW1ZQmxsZnFsOWhhSFlxMktHZno5SkdKSGRZ?=
 =?utf-8?B?UzZERFpBSlFQWVRPNmZlMXdhTlkvNkZIQUVhbjRQRERsWjhPWFZjcmduMEE3?=
 =?utf-8?B?QzBaMUxPWkVxNjZPVGVLM3Fyb0V6ck43eDBTRG5tOFQ2VTFjQ1FIVU80Mkpy?=
 =?utf-8?B?WEE0b0pkSlBPZ3hMN2JOOFJ0L1luRXAwUWNGZzN5Ykg1QTFtZkwyb0c2ZHJq?=
 =?utf-8?B?ZjM5ODgrNGpmOVIraEtWSGZXSHFUNEc5K0FWS3pobjJtcGFNZklKS29WN2R3?=
 =?utf-8?B?L0hpK1hCNENuL3BRQkFQbGlhbWZGcGRQRUVuVW16ZHhkTUVWUi9PbUJuRjB1?=
 =?utf-8?B?ZGcyMmdRWlNHQmpEVWJIc20ySXZvN1dxRTRmMWkzWDU0Y21WVmtkekd4UG1V?=
 =?utf-8?B?cVBSRlZ3OXpKR29mbHZ5UnhsdDlRMFJabEl5SFlDK2ZNTmxoYzlZbVRtbkVX?=
 =?utf-8?B?d2oxa2s5SURmMWxIbTlYY2p5bFFNUWJob2NiMWhJWFVIampodDZPaVBuUTNV?=
 =?utf-8?B?TFltRGdCRmNaRjJLSzVveUpDeUFtbnViT3Rvdkt2b2UzalJxQis1bzVsY2Jy?=
 =?utf-8?B?eEVKb01wVXl6MGdSU05DTENNS0hwbUxUN1V5em5MUEg3NXJDY25NNENxMWh1?=
 =?utf-8?B?ZnlrL1FlU0IwZndUOTZXTEQ2ZkNLUlBRaWJvMDJpQmhqa01qa2dRZXlMMmRV?=
 =?utf-8?B?ZHVxWGNudWw5Tzh6MjRxUXVUMmtxVXVmMGt5ZzZpNE0wcFhjYXRPVHQyVU9I?=
 =?utf-8?B?c1dRRVBRTS8rSnpPMm9ZdUIrV3hjR1cyS25OME1venRXZHFad0F4cGdMNW1w?=
 =?utf-8?B?MTdTSGpkd2NsYmNoNUpnUzlPR1h4c1B6RHBvNmVoNHhONW1Ub3JFVm5vQ3J3?=
 =?utf-8?B?ZG05ODJueURQcGJJNmFlZmgvaFVRbmN5NHdYcHl3bW9SNXJIVVVTdFJOemow?=
 =?utf-8?B?dnBHUTNxaE45b25qcWJXREIvUTg1MW1HQ2J0Ui9wa2hFNjBYUStoOGhoeU1U?=
 =?utf-8?B?YTc2L1E2RXMrT01kV1lZL2M5U3RaaHJlOTNVMEhzZnJ4TlAyS1hNd0J0V2xC?=
 =?utf-8?B?ZURLVU5ibWx0amNydHl6SmQzYzk0Z3dkWmxGeEdtd2srVlkvck1BRHBObjht?=
 =?utf-8?B?Z3lzM3dLWnNNREtZZFNUVG1WMGlEVnhsNGhDRWh2U3pGR3FIZHJJSDF3WE0x?=
 =?utf-8?B?VUJ4KytybXlRelZFSDBzSWxDUWFNV1BkckdtVXFkUXh3cytoakU3NkI1NVhG?=
 =?utf-8?B?Rk56MXgraTFscEpDcmd5dDVLODFVU0xURXdVbWZaREE3NG01Wmk0ZjRZOEVE?=
 =?utf-8?B?bnFNUnNyaVcyTXlzMFFHazZwZjF3V2wzZTBLT21kWDV0SDNQY3Q1K05sOFRQ?=
 =?utf-8?B?eHBodFRpSXZHSGVvYnl2NTEzNlpvL1ZVMzdyekQ4ZTZud1VMRlpSblRTOG9v?=
 =?utf-8?B?aGY1WU03QjdnRkFPMnNXMnUrQnRyUDVGWDlrc1RhSkk5OTdIZVpEMFdnenBm?=
 =?utf-8?B?a0lkT2N1M1JUbWVOd0E4TitNbHIrU242a2hmT3hWSHR0TUxFc3dnTmFNZElU?=
 =?utf-8?B?eVVpS1Fwckh6cTNBRS9IMG91anN3MGxZQWJBVkN2MTRMUml4elhkbldaWmd4?=
 =?utf-8?B?cDJLR3ZsZ2FnZ3pNL0ppbnIrYW9ZWGwybnFFeWliVTZOV0NWbWVWVy9NZUha?=
 =?utf-8?B?QlZhQWY5M2pwY09UN2NMLzhOTDVsSmVNVGFwUUZvK1ZscHR2TVNQSDJmTklh?=
 =?utf-8?B?YTl1UEhpVHZnc2lwS2o3ajhVNk8zdUF3NnVjNisyempyZG4rTTZyaUN3QTNn?=
 =?utf-8?Q?uIVTwbmN4OPhHPSlIMneVnTvw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e4471d-4573-4fb9-9005-08dbbf55d251
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 12:32:32.4521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cBJ6i5n24pLfcESErSLm6bwd7Rf1+S1K9CzP1RSb16/B1YG1GTHDkduTnqX/UENQwBcJjrfSbpadMRgsDcG8NPi4OE/3JhAxdLik+kvyk6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6789
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA4
OjIzIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNi8xMl0gdmZpby9wY2k6IEludHJvZHVj
ZSB2ZmlvX1thdHRhY2gvZGV0YWNoXV9kZXZpY2UNCj4NCj4NCj4NCj5PbiA5LzI3LzIzIDEyOjA3
LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaSBFcmljLA0KPj4NCj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA1OjAyIFBNDQo+
Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNi8xMl0gdmZpby9wY2k6IEludHJvZHVjZSB2Zmlv
X1thdHRhY2gvZGV0YWNoXV9kZXZpY2UNCj4+Pg0KPj4+IEhpIFpoZW56aG9uZywNCj4+Pg0KPj4+
IE9uIDkvMjYvMjMgMTM6MzIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+PiBGcm9tOiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+DQo+Pj4+IFdlIHdhbnQgdGhlIFZG
SU8gZGV2aWNlcyB0byBiZSBhYmxlIHRvIHVzZSB0d28gZGlmZmVyZW50DQo+Pj4+IElPTU1VIGJh
Y2tlbmRzLCB0aGUgbGVnYWN5IFZGSU8gb25lIGFuZCB0aGUgbmV3IGlvbW11ZmQgb25lLg0KPj4+
Pg0KPj4+PiBJbnRyb2R1Y2UgdmZpb19bYXR0YWNoL2RldGFjaF1fZGV2aWNlIHdoaWNoIGFpbSBh
dCBoaWRpbmcgdGhlDQo+Pj4+IHVuZGVybHlpbmcgSU9NTVUgYmFja2VuZCAoSU9DVExzLCBkYXRh
dHlwZXMsIC4uLikuDQo+Pj4+DQo+Pj4+IE9uY2UgdmZpb19hdHRhY2hfZGV2aWNlIGNvbXBsZXRl
cywgdGhlIGRldmljZSBpcyBhdHRhY2hlZA0KPj4+PiB0byBhIHNlY3VyaXR5IGNvbnRleHQgYW5k
IGl0cyBmZCBjYW4gYmUgdXNlZC4gQ29udmVyc2VseQ0KPj4+PiBXaGVuIHZmaW9fZGV0YWNoX2Rl
dmljZSBjb21wbGV0ZXMsIHRoZSBkZXZpY2UgaGFzIGJlZW4NCj4+Pj4gZGV0YWNoZWQgZnJvbSB0
aGUgc2VjdXJpdHkgY29udGV4dC4NCj4+Pj4NCj4+Pj4gQXQgdGhlIG1vbWVudCBvbmx5IHRoZSBp
bXBsZW1lbnRhdGlvbiBiYXNlZCBvbiB0aGUgbGVnYWN5DQo+Pj4+IGNvbnRhaW5lci9ncm91cCBl
eGlzdHMuIExldCdzIHVzZSBpdCBmcm9tIHRoZSB2ZmlvLXBjaSBkZXZpY2UuDQo+Pj4+IFN1YnNl
cXVlbnQgcGF0Y2hlcyB3aWxsIGhhbmRsZSBvdGhlciBkZXZpY2VzLg0KPj4+Pg0KPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+
Pj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIHwgIDMgKysNCj4+Pj4gIGh3L3ZmaW8v
Y29tbW9uLmMgICAgICAgICAgICAgIHwgNjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+Pj4gIGh3L3ZmaW8vcGNpLmMgICAgICAgICAgICAgICAgIHwgNTAgKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4gIGh3L3ZmaW8vdHJhY2UtZXZlbnRzICAgICAgICAgIHwg
IDIgKy0NCj4+Pj4gIDQgZmlsZXMgY2hhbmdlZCwgNzcgaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRp
b25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21t
b24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbW1vbi5oDQo+Pj4+IGluZGV4IGM0ZTdj
M2I0YTcuLjEyZmJmYmMzN2QgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92Zmlv
LWNvbW1vbi5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+Pj4+
IEBAIC0yMjUsNiArMjI1LDkgQEAgdm9pZCB2ZmlvX3B1dF9ncm91cChWRklPR3JvdXAgKmdyb3Vw
KTsNCj4+Pj4gIHN0cnVjdCB2ZmlvX2RldmljZV9pbmZvICp2ZmlvX2dldF9kZXZpY2VfaW5mbyhp
bnQgZmQpOw0KPj4+PiAgaW50IHZmaW9fZ2V0X2RldmljZShWRklPR3JvdXAgKmdyb3VwLCBjb25z
dCBjaGFyICpuYW1lLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICBWRklPRGV2aWNlICp2YmFz
ZWRldiwgRXJyb3IgKiplcnJwKTsNCj4+Pj4gK2ludCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAq
bmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCk7DQo+Pj4+ICt2b2lkIHZmaW9fZGV0YWNo
X2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+Pj4+DQo+Pj4+ICBpbnQgdmZpb19rdm1f
ZGV2aWNlX2FkZF9mZChpbnQgZmQsIEVycm9yICoqZXJycCk7DQo+Pj4+ICBpbnQgdmZpb19rdm1f
ZGV2aWNlX2RlbF9mZChpbnQgZmQsIEVycm9yICoqZXJycCk7DQo+Pj4+IGRpZmYgLS1naXQgYS9o
dy92ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9jb21tb24uYw0KPj4+PiBpbmRleCA5NTliMTM2MmJi
Li43ZjM3OThiMTUyIDEwMDY0NA0KPj4+PiAtLS0gYS9ody92ZmlvL2NvbW1vbi5jDQo+Pj4+ICsr
KyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4+Pj4gQEAgLTI2MTEsMyArMjYxMSw3MSBAQCBpbnQgdmZp
b19lZWhfYXNfb3AoQWRkcmVzc1NwYWNlICphcywgdWludDMyX3QNCj5vcCkNCj4+Pj4gICAgICB9
DQo+Pj4+ICAgICAgcmV0dXJuIHZmaW9fZWVoX2NvbnRhaW5lcl9vcChjb250YWluZXIsIG9wKTsN
Cj4+Pj4gIH0NCj4+Pj4gKw0KPj4+PiArc3RhdGljIGludCB2ZmlvX2RldmljZV9ncm91cGlkKFZG
SU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+Pj4+ICt7DQo+Pj4+ICsgICAgY2hh
ciAqdG1wLCBncm91cF9wYXRoW1BBVEhfTUFYXSwgKmdyb3VwX25hbWU7DQo+Pj4+ICsgICAgaW50
IHJldCwgZ3JvdXBpZDsNCj4+Pj4gKyAgICBzc2l6ZV90IGxlbjsNCj4+Pj4gKw0KPj4+PiArICAg
IHRtcCA9IGdfc3RyZHVwX3ByaW50ZigiJXMvaW9tbXVfZ3JvdXAiLCB2YmFzZWRldi0+c3lzZnNk
ZXYpOw0KPj4+PiArICAgIGxlbiA9IHJlYWRsaW5rKHRtcCwgZ3JvdXBfcGF0aCwgc2l6ZW9mKGdy
b3VwX3BhdGgpKTsNCj4+Pj4gKyAgICBnX2ZyZWUodG1wKTsNCj4+Pj4gKw0KPj4+PiArICAgIGlm
IChsZW4gPD0gMCB8fCBsZW4gPj0gc2l6ZW9mKGdyb3VwX3BhdGgpKSB7DQo+Pj4+ICsgICAgICAg
IHJldCA9IGxlbiA8IDAgPyAtZXJybm8gOiAtRU5BTUVUT09MT05HOw0KPj4+PiArICAgICAgICBl
cnJvcl9zZXRnX2Vycm5vKGVycnAsIC1yZXQsICJubyBpb21tdV9ncm91cCBmb3VuZCIpOw0KPj4+
PiArICAgICAgICByZXR1cm4gcmV0Ow0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIGdy
b3VwX3BhdGhbbGVuXSA9IDA7DQo+Pj4+ICsNCj4+Pj4gKyAgICBncm91cF9uYW1lID0gYmFzZW5h
bWUoZ3JvdXBfcGF0aCk7DQo+Pj4+ICsgICAgaWYgKHNzY2FuZihncm91cF9uYW1lLCAiJWQiLCAm
Z3JvdXBpZCkgIT0gMSkgew0KPj4+PiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIGVy
cm5vLCAiZmFpbGVkIHRvIHJlYWQgJXMiLCBncm91cF9wYXRoKTsNCj4+Pj4gKyAgICAgICAgcmV0
dXJuIC1lcnJubzsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsgICAgcmV0dXJuIGdyb3VwaWQ7DQo+Pj4+
ICt9DQo+Pj4+ICsNCj4+Pj4gK2ludCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJ
T0RldmljZSAqdmJhc2VkZXYsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgIEFkZHJlc3NT
cGFjZSAqYXMsIEVycm9yICoqZXJycCkNCj4+Pj4gK3sNCj4+Pj4gKyAgICBpbnQgZ3JvdXBpZCA9
IHZmaW9fZGV2aWNlX2dyb3VwaWQodmJhc2VkZXYsIGVycnApOw0KPj4+PiArICAgIFZGSU9EZXZp
Y2UgKnZiYXNlZGV2X2l0ZXI7DQo+Pj4+ICsgICAgVkZJT0dyb3VwICpncm91cDsNCj4+Pj4gKyAg
ICBpbnQgcmV0Ow0KPj4+PiArDQo+Pj4+ICsgICAgaWYgKGdyb3VwaWQgPCAwKSB7DQo+Pj4+ICsg
ICAgICAgIHJldHVybiBncm91cGlkOw0KPj4+PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIHRy
YWNlX3ZmaW9fYXR0YWNoX2RldmljZSh2YmFzZWRldi0+bmFtZSwgZ3JvdXBpZCk7DQo+Pj4+ICsN
Cj4+Pj4gKyAgICBncm91cCA9IHZmaW9fZ2V0X2dyb3VwKGdyb3VwaWQsIGFzLCBlcnJwKTsNCj4+
Pj4gKyAgICBpZiAoIWdyb3VwKSB7DQo+Pj4+ICsgICAgICAgIHJldHVybiAtRU5PRU5UOw0KPj4+
PiArICAgIH0NCj4+Pj4gKw0KPj4+PiArICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXZfaXRlciwg
Jmdyb3VwLT5kZXZpY2VfbGlzdCwgbmV4dCkgew0KPj4+PiArICAgICAgICBpZiAoc3RyY21wKHZi
YXNlZGV2X2l0ZXItPm5hbWUsIHZiYXNlZGV2LT5uYW1lKSA9PSAwKSB7DQo+Pj4+ICsgICAgICAg
ICAgICBlcnJvcl9zZXRnKGVycnAsICJkZXZpY2UgaXMgYWxyZWFkeSBhdHRhY2hlZCIpOw0KPj4+
PiArICAgICAgICAgICAgdmZpb19wdXRfZ3JvdXAoZ3JvdXApOw0KPj4+PiArICAgICAgICAgICAg
cmV0dXJuIC1FQlVTWTsNCj4+Pj4gKyAgICAgICAgfQ0KPj4+PiArICAgIH0NCj4+Pj4gKyAgICBy
ZXQgPSB2ZmlvX2dldF9kZXZpY2UoZ3JvdXAsIG5hbWUsIHZiYXNlZGV2LCBlcnJwKTsNCj4+Pj4g
KyAgICBpZiAocmV0KSB7DQo+Pj4+ICsgICAgICAgIHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsNCj4+
Pj4gKyAgICB9DQo+Pj4+ICsNCj4+Pj4gKyAgICByZXR1cm4gcmV0Ow0KPj4+PiArfQ0KPj4+PiAr
DQo+Pj4+ICt2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+
Pj4gK3sNCj4+Pj4gKyAgICBWRklPR3JvdXAgKmdyb3VwID0gdmJhc2VkZXYtPmdyb3VwOw0KPj4+
PiArDQo+Pj4+ICsgICAgdmZpb19wdXRfYmFzZV9kZXZpY2UodmJhc2VkZXYpOw0KPj4+PiArICAg
IHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsNCj4+Pj4gK30NCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3Zm
aW8vcGNpLmMgYi9ody92ZmlvL3BjaS5jDQo+Pj4+IGluZGV4IDNiMmNhM2MyNGMuLmZlNTY3ODk4
OTMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+Pj4gKysrIGIvaHcvdmZpby9w
Y2kuYw0KPj4+PiBAQCAtMjgyOCwxMCArMjgyOCwxMCBAQCBzdGF0aWMgdm9pZCB2ZmlvX3BvcHVs
YXRlX2RldmljZShWRklPUENJRGV2aWNlDQo+Pj4gKnZkZXYsIEVycm9yICoqZXJycCkNCj4+Pj4g
IHN0YXRpYyB2b2lkIHZmaW9fcHV0X2RldmljZShWRklPUENJRGV2aWNlICp2ZGV2KQ0KPj4+PiAg
ew0KPj4+PiArICAgIHZmaW9fZGV0YWNoX2RldmljZSgmdmRldi0+dmJhc2VkZXYpOw0KPj4+PiAr
DQo+Pj4+ICAgICAgZ19mcmVlKHZkZXYtPnZiYXNlZGV2Lm5hbWUpOw0KPj4+PiAgICAgIGdfZnJl
ZSh2ZGV2LT5tc2l4KTsNCj4+Pj4gLQ0KPj4+PiAtICAgIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKCZ2
ZGV2LT52YmFzZWRldik7DQo+Pj4+ICB9DQo+Pj4+DQo+Pj4+ICBzdGF0aWMgdm9pZCB2ZmlvX2Vy
cl9ub3RpZmllcl9oYW5kbGVyKHZvaWQgKm9wYXF1ZSkNCj4+Pj4gQEAgLTI5NzgsMTMgKzI5Nzgs
OSBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvcg0KPj4+
ICoqZXJycCkNCj4+Pj4gIHsNCj4+Pj4gICAgICBWRklPUENJRGV2aWNlICp2ZGV2ID0gVkZJT19Q
Q0kocGRldik7DQo+Pj4+ICAgICAgVkZJT0RldmljZSAqdmJhc2VkZXYgPSAmdmRldi0+dmJhc2Vk
ZXY7DQo+Pj4+IC0gICAgVkZJT0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+Pj4gLSAgICBWRklP
R3JvdXAgKmdyb3VwOw0KPj4+PiAtICAgIGNoYXIgKnRtcCwgKnN1YnN5cywgZ3JvdXBfcGF0aFtQ
QVRIX01BWF0sICpncm91cF9uYW1lOw0KPj4+PiArICAgIGNoYXIgKnRtcCwgKnN1YnN5czsNCj4+
Pj4gICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4+Pj4gLSAgICBzc2l6ZV90IGxlbjsNCj4+Pj4g
ICAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4+Pj4gLSAgICBpbnQgZ3JvdXBpZDsNCj4+Pj4gICAgICBp
bnQgaSwgcmV0Ow0KPj4+PiAgICAgIGJvb2wgaXNfbWRldjsNCj4+Pj4gICAgICBjaGFyIHV1aWRb
VVVJRF9GTVRfTEVOXTsNCj4+Pj4gQEAgLTMwMTUsMzkgKzMwMTEsNiBAQCBzdGF0aWMgdm9pZCB2
ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBFcnJvcg0KPj4+ICoqZXJycCkNCj4+Pj4gICAg
ICB2YmFzZWRldi0+dHlwZSA9IFZGSU9fREVWSUNFX1RZUEVfUENJOw0KPj4+PiAgICAgIHZiYXNl
ZGV2LT5kZXYgPSBERVZJQ0UodmRldik7DQo+Pj4+DQo+Pj4+IC0gICAgdG1wID0gZ19zdHJkdXBf
cHJpbnRmKCIlcy9pb21tdV9ncm91cCIsIHZiYXNlZGV2LT5zeXNmc2Rldik7DQo+Pj4+IC0gICAg
bGVuID0gcmVhZGxpbmsodG1wLCBncm91cF9wYXRoLCBzaXplb2YoZ3JvdXBfcGF0aCkpOw0KPj4+
PiAtICAgIGdfZnJlZSh0bXApOw0KPj4+PiAtDQo+Pj4+IC0gICAgaWYgKGxlbiA8PSAwIHx8IGxl
biA+PSBzaXplb2YoZ3JvdXBfcGF0aCkpIHsNCj4+Pj4gLSAgICAgICAgZXJyb3Jfc2V0Z19lcnJu
byhlcnJwLCBsZW4gPCAwID8gZXJybm8gOiBFTkFNRVRPT0xPTkcsDQo+Pj4+IC0gICAgICAgICAg
ICAgICAgICAgICAgICAgIm5vIGlvbW11X2dyb3VwIGZvdW5kIik7DQo+Pj4+IC0gICAgICAgIGdv
dG8gZXJyb3I7DQo+Pj4+IC0gICAgfQ0KPj4+PiAtDQo+Pj4+IC0gICAgZ3JvdXBfcGF0aFtsZW5d
ID0gMDsNCj4+Pj4gLQ0KPj4+PiAtICAgIGdyb3VwX25hbWUgPSBiYXNlbmFtZShncm91cF9wYXRo
KTsNCj4+Pj4gLSAgICBpZiAoc3NjYW5mKGdyb3VwX25hbWUsICIlZCIsICZncm91cGlkKSAhPSAx
KSB7DQo+Pj4+IC0gICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJmYWlsZWQg
dG8gcmVhZCAlcyIsIGdyb3VwX3BhdGgpOw0KPj4+PiAtICAgICAgICBnb3RvIGVycm9yOw0KPj4+
PiAtICAgIH0NCj4+Pj4gLQ0KPj4+PiAtICAgIHRyYWNlX3ZmaW9fcmVhbGl6ZSh2YmFzZWRldi0+
bmFtZSwgZ3JvdXBpZCk7DQo+Pj4+IC0NCj4+Pj4gLSAgICBncm91cCA9IHZmaW9fZ2V0X2dyb3Vw
KGdyb3VwaWQsIHBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShwZGV2KSwNCj4+PiBlcnJw
KTsNCj4+Pj4gLSAgICBpZiAoIWdyb3VwKSB7DQo+Pj4+IC0gICAgICAgIGdvdG8gZXJyb3I7DQo+
Pj4+IC0gICAgfQ0KPj4+PiAtDQo+Pj4+IC0gICAgUUxJU1RfRk9SRUFDSCh2YmFzZWRldl9pdGVy
LCAmZ3JvdXAtPmRldmljZV9saXN0LCBuZXh0KSB7DQo+Pj4+IC0gICAgICAgIGlmIChzdHJjbXAo
dmJhc2VkZXZfaXRlci0+bmFtZSwgdmJhc2VkZXYtPm5hbWUpID09IDApIHsNCj4+Pj4gLSAgICAg
ICAgICAgIGVycm9yX3NldGcoZXJycCwgImRldmljZSBpcyBhbHJlYWR5IGF0dGFjaGVkIik7DQo+
Pj4+IC0gICAgICAgICAgICB2ZmlvX3B1dF9ncm91cChncm91cCk7DQo+Pj4+IC0gICAgICAgICAg
ICBnb3RvIGVycm9yOw0KPj4+PiAtICAgICAgICB9DQo+Pj4+IC0gICAgfQ0KPj4+PiAtDQo+Pj4+
ICAgICAgLyoNCj4+Pj4gICAgICAgKiBNZWRpYXRlZCBkZXZpY2VzICptaWdodCogb3BlcmF0ZSBj
b21wYXRpYmx5IHdpdGggZGlzY2FyZGluZyBvZiBSQU0sDQo+YnV0DQo+Pj4+ICAgICAgICogd2Ug
Y2Fubm90IGtub3cgZm9yIGNlcnRhaW4sIGl0IGRlcGVuZHMgb24gd2hldGhlciB0aGUgbWRldiB2
ZW5kb3INCj4+PiBkcml2ZXINCj4+Pj4gQEAgLTMwNjUsNyArMzAyOCw2IEBAIHN0YXRpYyB2b2lk
IHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsIEVycm9yDQo+KiplcnJwKQ0KPj4+PiAgICAg
IGlmICh2YmFzZWRldi0+cmFtX2Jsb2NrX2Rpc2NhcmRfYWxsb3dlZCAmJiAhaXNfbWRldikgew0K
Pj4+PiAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJ4LWJhbGxvb24tYWxsb3dlZCBvbmx5IHBv
dGVudGlhbGx5IGNvbXBhdGlibGUgIg0KPj4+PiAgICAgICAgICAgICAgICAgICAgICJ3aXRoIG1k
ZXYgZGV2aWNlcyIpOw0KPj4+PiAtICAgICAgICB2ZmlvX3B1dF9ncm91cChncm91cCk7DQo+Pj4+
ICAgICAgICAgIGdvdG8gZXJyb3I7DQo+Pj4+ICAgICAgfQ0KPj4+Pg0KPj4+PiBAQCAtMzA3Niwx
MCArMzAzOCwxMCBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpwZGV2LCBF
cnJvcg0KPj4+ICoqZXJycCkNCj4+Pj4gICAgICAgICAgbmFtZSA9IGdfc3RyZHVwKHZiYXNlZGV2
LT5uYW1lKTsNCj4+Pj4gICAgICB9DQo+Pj4+DQo+Pj4+IC0gICAgcmV0ID0gdmZpb19nZXRfZGV2
aWNlKGdyb3VwLCBuYW1lLCB2YmFzZWRldiwgZXJycCk7DQo+Pj4+ICsgICAgcmV0ID0gdmZpb19h
dHRhY2hfZGV2aWNlKG5hbWUsIHZiYXNlZGV2LA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwY2lfZGV2aWNlX2lvbW11X2FkZHJlc3Nfc3BhY2UocGRldiksIGVycnApOw0KPj4+
PiAgICAgIGdfZnJlZShuYW1lKTsNCj4+Pj4gICAgICBpZiAocmV0KSB7DQo+Pj4+IC0gICAgICAg
IHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsNCj4+PiBpbmRlcGVuZGVudGx5IG9uIHRoaXMgcGF0Y2gs
IEkgdGhpbmsgaW4gY2FzZSBvZiBlcnJvciB3ZSBsZWFrDQo+Pj4gdmJhc2VkZXYtPm5hbWUuIFBs
ZWFzZSBoYXZlIGEgbG9vayBhbmQgaWYgY29uZmlybWVkIHlvdSBjYW4gc2VuZCBhDQo+Pj4gc2Vw
YXJhdGUgcGF0Y2guDQo+PiBJbiBjYXNlIG9mIGVycm9yLCB2YmFzZWRldi0+bmFtZSBpcyBmcmVl
ZCBpbiB2ZmlvX3B1dF9kZXZpY2UoKS4NCj5jYWxsZWQgaW4gdmZpb19pbnN0YW5jZV9maW5hbGl6
ZSBvbmx5LiBTZWUgY29tbWVudCBiZWxvdw0KPj4NCj4+PiBBbHNvIEkgdGhpbmsgaWYgYW55IHN1
YnNlcXVlbnQgYWN0aW9uIGZhaWwgd2Ugc2hvdWRsIHByb3Blcmx5IGRldGFjaCB0aGUNCj4+PiBk
ZXRhY2ggdGhlIGRldmljZSBzbyBpbnRyb2R1Y2UgYW4gZXh0cmEgZXJyb3IgZ290byBsYWJlbCwg
bXkgYmFkIHNvcnJ5Lg0KPj4gdmZpb19kZXRhY2hfZGV2aWNlIGlzIGNhbGxlZCBpbiB2ZmlvX2lu
c3RhbmNlX2ZpbmFsaXplKCksIHRoaXMgaXMganVzdCB0byBmb2xsb3cNCj4+IHRoZSBvbGQgY29k
ZSwgZ3JvdXAgYW5kIGNvbnRhaW5lciByZXNvdXJjZSBhbGxvY2F0ZWQgaW4gdmZpb19yZWFsaXpl
KCkgYXJlDQo+PiBmcmVlZCBpbiB2ZmlvX2luc3RhbmNlX2ZpbmFsaXplKCkuDQo+Pg0KPj4gSSBh
Z3JlZSB0aGlzIGlzIHN0cmFuZ2UsIGJ1dCBJIGd1ZXNzIHRoZXJlIG1heSBiZSBzb21lIHJlYXNv
biBJJ20gdW5jbGVhci4NCj5ZZWFoIGJ1dCBpZiB2ZmlvX3JlYWxpemUgZG9lcyBmYWlsLCBJIGFt
IG5vdCBzdXJlIHRoZQ0KPnZmaW9faW5zdGFuY2VfZmluYWxpemUgZ2V0cyBjYWxsZWQNCg0KSWYg
dmZpb19yZWFsaXplIGZhaWxzLCBmaW9fZXhpdGZuKCkgd2lsbCBub3QgYmUgY2FsbGVkIGJ1dCB2
ZmlvX2luc3RhbmNlX2ZpbmFsaXplIHdpbGwuDQpOb3RlIHZmaW9faW5zdGFuY2VfZmluYWxpemUo
KSBpcyBjYWxsZWQgYnkgb2JqZWN0X3VucmVmKCkuDQoNClRoYW5rcw0KWmhlbnpob25nDQoNCg==

