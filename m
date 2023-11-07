Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5559D7E33A6
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:12:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CSU-0007jK-66; Mon, 06 Nov 2023 22:08:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0CSI-0007fx-Ck
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:42 -0500
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0CSG-0001Wn-DX
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699326520; x=1730862520;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nApJqhg4/2wIRnwRCUVaSpJSpZYtpFLNnbe/Ma3yBkI=;
 b=TsaOki6+lV13g30c1fX7oFIgFTZy2VJuE1QvJfejCjY+rJDNI/1ol+KC
 aovVFbjznwLCdm68rJukGdR+lSSJVsCCs6gGvLLvo/2+7twSbsji7W5dM
 su47gAvtpcLleufGuko7YZD6IsKuOT8/Yl4N65LlJchyiV4Duc+D2X4bX
 EpAwY3TF2fP0EDBfNd3nC01aEPooZWo60vrmiKmmYCYhPOZX1CG6ZMLOn
 etcClKqV6IwzoHko67YOaZMq2/t+FOkcNaHx6T009Yy/gJXE7ZmHZTu7e
 ZvLTNdIYyD6E5CjWB5i6VeMAVSNRGpLQcgbJvLQeLyWGDfC9q2MGCXdQg A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="393309273"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; d="scan'208";a="393309273"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2023 19:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="766160229"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; d="scan'208";a="766160229"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Nov 2023 19:08:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 19:08:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 19:08:01 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 19:08:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4liRC2NvFzoSa9d0708StHBeA+rBCCTDKUW/iSqUCKtEZTbEcZgDac9lnd6DvMeZtdRp71+Gg7rrimZ/UpzXXtrN8Gt4ODo18fBsZErvmKgf2zWIDCR9R+G+E6S6L8y63MHkUJAsE5fvIBpSOTkvzxD1lLFTwwPqKdu70scpFftwrdM/f8RSp6dJkBlvRA9dMNRVhmZbVPw/Nv3NDQsyK1KrQXWBPzy3Cmz93/vGXQIQSofvHAY8WlYu+iGbf59GKqbfCGoyMfthR/0F3ioLCh2g0+F8hlLugG2h8oWTp7wpEPK6faVCxNec2vVPjKa5bnvapkZ6a5gKVRf56Yblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nApJqhg4/2wIRnwRCUVaSpJSpZYtpFLNnbe/Ma3yBkI=;
 b=fC02JeIyvawlqxYnSQr3VtzbAmyoe65jUKUuW1URrIWSHuhzXXLrnFXO7TqgqkEmtDEAkcg4Xh5Gq/jTA5Kl9+1o2ibA/EcEomS0eKkvQPEkAcKFP94ZrBgNbYU7UbFyqaw/wO6K5fL/OhynDw9+pGIZhw7wUo3QOdsvHIr0QPDFniYh9f6MqAmpffjA7Z4JJD71BpkDSWxHDbRtGf3NCb+n/CjJbeNYZ+eUxE41KYuPOJLnCefnvLpyV/RM64C14gKI82x/bXRjJjx9a6VgVM96LKdpB4ytqzOgopk9kQlAVrnqdYwdsY9YSWtSICZgZed6mpvpSZqViZGuR6c4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:07:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 03:07:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 30/41] vfio/iommufd: Add support for iova_ranges
Thread-Topic: [PATCH v4 30/41] vfio/iommufd: Add support for iova_ranges
Thread-Index: AQHaDV6AyGlFLZyPI0K+qUfg8jkDDLBtj/eAgACkNcA=
Date: Tue, 7 Nov 2023 03:07:58 +0000
Message-ID: <SJ0PR11MB6744E03C09001EBBD2F518EB92A9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-31-zhenzhong.duan@intel.com>
 <3d2c2c02-2101-40f0-a60e-34b90a43969e@redhat.com>
In-Reply-To: <3d2c2c02-2101-40f0-a60e-34b90a43969e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7851:EE_
x-ms-office365-filtering-correlation-id: 6468b02c-744f-4fe2-0bd4-08dbdf3ebef1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VVyCXDFCcqgz3QuFHvdkeLnTfN27OZ6vuTst0hEfsookAk+7Vo0dNW7SbiQS2p+Rc9hgdKjK46Auo4DafgUa/qL1fsh3SboEYGyTE7+LPqUV+0QhXBA8rEi63vpaXFE88VJhJVTr+KwSZfWyhCBR7yQ3iW6r/4MPiRctQCfxewKALWFmxJSE1jf1Mydr3sGbEVgPRRWvjHT7f97WR00esnnCghlvXWCmEJVQe7mIN2puA4vaoYeFn3h4VRccOborzP6tN2EOS8WC13YLx7cJmis8O1WBKg6XXvkuwXlkbj+hdeh2uLu1eBwt9UgtGrcB5Z3h2jALBv+zFLpgW+akTUgohT4bNDJy/rQoQoIePFIAy/PXqiTF2XPnWZxQblaW609Kpw9d0km8cfh6LQwi/y3Uo2oRgCHfNR4A4hU09M3NAUp0F7GBRI5gczopOsfT4ZUtNC0f67NcZ3qLBa/f88pS7KXduws9f+ZsstFnfR5a5PW98vtGWyK8vgpaqpJ/gIIlXwu8kD6fP2HaGxmRFMrEIRZdKuFSmmfg4EpmaMQX5KSuhiY0QLP+qun5xoZggoeo4Rm6r2raKsyLvNV1soVECiwJcfeuqWBInZ3lw7oTODzbElJzKVbdsyeo0j6+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(5660300002)(41300700001)(2906002)(86362001)(38070700009)(33656002)(122000001)(82960400001)(478600001)(7696005)(83380400001)(9686003)(66946007)(76116006)(110136005)(26005)(107886003)(316002)(66476007)(54906003)(64756008)(66446008)(66556008)(71200400001)(55016003)(6506007)(8936002)(8676002)(4326008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnQwMHg3emtHSEhvN2wzb2xWVWIxTXJmMEl0Y3ZKbDI1Nms1c0dhN3MxbUxK?=
 =?utf-8?B?ZHZ6dSsxS3RvWXNvbFpLR0NQZG5pQ3pPQ2ZUNkFLTUxscFNuQnE4RDUvRFZR?=
 =?utf-8?B?Z2J4aVp3aHBkTmduQjNmdTQ0aStrTDFNUm4rVjJONkY4aCtDNlRmSlNnMUVr?=
 =?utf-8?B?RHVNZDVWRXFmQ0ZIaHJjTFJTa0s2azViRTFCN0ZiZk5adnF3REZOQWdOVHkv?=
 =?utf-8?B?SnpLYUpBQUI5dDkwZ21uVTByUWphbUNibGNBMk95eTdndEtkRWpxZDYvTXgw?=
 =?utf-8?B?ZHMxTm9nNFJyb0l3cEk2ZS9DZDBVaHV0WmFjSDk3dld3ejJTTUs3Qmp1R042?=
 =?utf-8?B?QkJnVlA4WGphYXVCVHprQ1U1L2Q1amZ1SG1aWXZaZVJvRkM0TG9rSk1iWHh4?=
 =?utf-8?B?MFliTWpMR2YrV0oyUldESHFyVThWRUl2Ny9CcFhHekRqRkpET0IxaEhoaXo5?=
 =?utf-8?B?Z25sMmYvL1lUcVJwWE82cllFZThmN0FnbnV5NmVwaGp2aVdkTGxYSzBQcnYy?=
 =?utf-8?B?ZXEySzk3U3hjbFNrdFFhTlNEeDFxSG1NalpWTUxFSlE1S3UvSXdLVUh3aWcz?=
 =?utf-8?B?eGpMZFhOZ0N4MHJzOERzTWVRMmVJc3cxNTZ6L1l2ZGJsNXc0ZDJDTGRKSE0x?=
 =?utf-8?B?ZGFCaWd5azdzZThreERRSE5TRkVZd0RLZW1wQngwV1gyM3ZIaHRJa3VjZU4v?=
 =?utf-8?B?MTJCaC9KNWd1S1czRWJEZ0wraHVRNE83NWVhbEFXazlpUVF4NEtoZkowVWpx?=
 =?utf-8?B?TDd2bE4wSHJjbDBubUZzejRtaDFzN0tGUStBdXZRek5SWFdQbnJtRnlBR0gx?=
 =?utf-8?B?amhaVG9NMTU2UE9TRW95NFBNM0VQdTlrOGloU3RIUlJkOTAxczJmeTh3cGdj?=
 =?utf-8?B?TjZ2cUNFSVN3MVQ1RDd6MzM2TkVwSG9mUloweUwyeWhhWHN4eU9JMHVtN0I3?=
 =?utf-8?B?VkdZYTRIczhSaDhIMmlzR0xGdHJ5SFRaa0xQd09FL01TNkZKNHhMWUoyaDNz?=
 =?utf-8?B?Q0R2WklyQ0Q0RWtMR09oN3BVdXlKU2lpTXpiKy85cW1pYnlDSkxsUU5iaHAw?=
 =?utf-8?B?aHBxK2FyTkYwMmx0bVhvVUJ4azkvQlRzcWRSakpwNFMrZHBRejU1ZTlaOG5N?=
 =?utf-8?B?b093eGdqdFJSNUlXcXhKdkxQbndWRnVtd0dMazZGbnhZY0g0bFlTNDk5cW1s?=
 =?utf-8?B?Y0VXOWRZWHIyOWhldkpWeWtTL255VlRiMy9OTWNWR2JGd05lanVnZXpaYS9k?=
 =?utf-8?B?WWtoNktLdWRWd1BFOFdsM0F5N2IrSUtBczNyaDZoWXhpTmVvQi9ocllaTGRq?=
 =?utf-8?B?aW1UYmVPVXJZdy9pSkRFR2VjUG41K0UxMXhaMGtTM1pOOVJ1eHB3VWZyNENr?=
 =?utf-8?B?TEVzVHhSK2ZpYng5ZlY3dU04K21ZSnJvdDRwZmdZSE1mSThhaGl6ZkVCa1VV?=
 =?utf-8?B?c1RPQnkzTXBsYjNLSHgyY25YeWlvSlZxeWtSaFFuaWduMXR3K1ExbjhoUHMy?=
 =?utf-8?B?elFWQ2srM2Y3emI3cDA5SUFMcEtuOE8rZ0VsbjhuanAyNjFNMWNxK0Z1SFNr?=
 =?utf-8?B?YW1WRUxlMGJlSVZucFhlMTIvSEZ1Qlp6REQvNW43Q2V6Vyt5WmgrYnRjTyto?=
 =?utf-8?B?NG41MS8xMVU3SWdhcFE5Z1NmQWo2TkFpblIzdXE1dklmaXd5TUdBWHBIMHJW?=
 =?utf-8?B?c1V6NTlFZzgvWTBXU2VuY2RBejkzelViMFRWdE5NeDVFSTlqd0VYZUM1Q1Jr?=
 =?utf-8?B?eGRLODBPTzQwa2pDQnQ4UUZrVEVrVHYvOUFsSkdJSnlxbnRNRDJPbWZUUWNI?=
 =?utf-8?B?bjhLekY2U1FBYzRpbWJib0dNeDFyRVpmMlhMTkw3MVQzR1lqNzZ6R3E2dTM4?=
 =?utf-8?B?dzBQd2ZKbmRORGxla1dEdFdkU3hkcXZDNStWQ3lTcmkzd3dnUjJsUWJSbU1a?=
 =?utf-8?B?ZUFNcm11bGFJaU9naTZhVFRhNFluTUZ6U01pbjFldzdha2F4Ri94SFMxbDBx?=
 =?utf-8?B?SE9lTHEzS0xSVzJ1L2pFQzIvc2oxYnI1RlVFcDQ0ZFVwQVpOeWt4bU5nN2Rs?=
 =?utf-8?B?bWJCdzBmSXZTZWc4Zy9rY3gvaVI1cS9LUHdyZm5mVS94Q3ZublNqamJRV0Qy?=
 =?utf-8?Q?fIMlXY7Xc+OdHMI0cyx6ATnM5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6468b02c-744f-4fe2-0bd4-08dbdf3ebef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 03:07:58.7105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6i/P6MUReqJ/GrtK4CAXcBtQ/X43rjnJ6fhmmev0MYahvTizTpcZTS3GET5QqaoSRTusaMJexqcw7Y4s7dlsfV+/772cNw+Zp6qD2AXzGNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA3LCAyMDIzIDE6MTkg
QU0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDMwLzQxXSB2ZmlvL2lvbW11ZmQ6IEFkZCBzdXBw
b3J0IGZvciBpb3ZhX3Jhbmdlcw0KPg0KPk9uIDExLzIvMjMgMDg6MTIsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPj4gU29tZSB2SU9NTVUgc3VjaCBhcyB2aXJ0aW8taW9tbXUgdXNlIGlvdmEgcmFu
Z2VzIGZyb20gaG9zdCBzaWRlIHRvDQo+PiBzZXR1cCByZXNlcnZlZCByYW5nZXMgZm9yIHBhc3N0
aHJvdWdoIGRldmljZSwgc28gdGhhdCBndWVzdCB3aWxsIG5vdA0KPj4gdXNlIGFuIGlvdmEgcmFu
Z2UgYmV5b25kIGhvc3Qgc3VwcG9ydC4NCj4+DQo+PiBVc2UgYW4gdUFQSSBvZiBJT01NVUZEIHRv
IGdldCBpb3ZhIHJhbmdlcyBvZiBob3N0IHNpZGUgYW5kIHBhc3MgdG8NCj4+IHZJT01NVSBqdXN0
IGxpa2UgdGhlIGxlZ2FjeSBiYWNrZW5kLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+IHY0OiBmaXggYnVp
bGQgZXJyb3IgaW4gMzJiaXQgZmVkb3JhDQo+Pg0KPj4gICBody92ZmlvL2lvbW11ZmQuYyB8IDQ3
DQo+KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAg
MSBmaWxlIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcv
dmZpby9pb21tdWZkLmMgYi9ody92ZmlvL2lvbW11ZmQuYw0KPj4gaW5kZXggMWJiNTVjYTJjNC4u
MjJmMDJmOTJhOSAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vaW9tbXVmZC5jDQo+PiArKysgYi9o
dy92ZmlvL2lvbW11ZmQuYw0KPj4gQEAgLTM0MSw2ICszNDEsNTIgQEAgc3RhdGljIGludCBpb21t
dWZkX3JhbV9ibG9ja19kaXNjYXJkX2Rpc2FibGUoYm9vbA0KPnN0YXRlKQ0KPj4gICAgICAgcmV0
dXJuIHJhbV9ibG9ja191bmNvb3JkaW5hdGVkX2Rpc2NhcmRfZGlzYWJsZShzdGF0ZSk7DQo+PiAg
IH0NCj4+DQo+PiArc3RhdGljIGludCB2ZmlvX2dldF9pbmZvX2lvdmFfcmFuZ2UoVkZJT0lPTU1V
RkRDb250YWluZXIgKmNvbnRhaW5lciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50MzJfdCBpb2FzX2lkKQ0KPj4gK3sNCj4+ICsgICAgVkZJT0NvbnRhaW5lckJh
c2UgKmJjb250YWluZXIgPSAmY29udGFpbmVyLT5iY29udGFpbmVyOw0KPj4gKyAgICBzdHJ1Y3Qg
aW9tbXVfaW9hc19pb3ZhX3JhbmdlcyAqaW5mbzsNCj4+ICsgICAgc3RydWN0IGlvbW11X2lvdmFf
cmFuZ2UgKmlvdmFfcmFuZ2VzOw0KPj4gKyAgICBpbnQgcmV0LCBzeiwgZmQgPSBjb250YWluZXIt
PmJlLT5mZDsNCj4+ICsNCj4+ICsgICAgaW5mbyA9IGdfbWFsbG9jMChzaXplb2YoKmluZm8pKTsN
Cj4+ICsgICAgaW5mby0+c2l6ZSA9IHNpemVvZigqaW5mbyk7DQo+PiArICAgIGluZm8tPmlvYXNf
aWQgPSBpb2FzX2lkOw0KPj4gKw0KPj4gKyAgICByZXQgPSBpb2N0bChmZCwgSU9NTVVfSU9BU19J
T1ZBX1JBTkdFUywgaW5mbyk7DQo+PiArICAgIGlmIChyZXQgJiYgZXJybm8gIT0gRU1TR1NJWkUp
IHsNCj4+ICsgICAgICAgIGdvdG8gZXJyb3I7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgc3og
PSBpbmZvLT5udW1faW92YXMgKiBzaXplb2Yoc3RydWN0IGlvbW11X2lvdmFfcmFuZ2UpOw0KPj4g
KyAgICBpbmZvID0gZ19yZWFsbG9jKGluZm8sIHNpemVvZigqaW5mbykgKyBzeik7DQo+PiArICAg
IGluZm8tPmFsbG93ZWRfaW92YXMgPSAodWludHB0cl90KShpbmZvICsgMSk7DQo+PiArDQo+PiAr
ICAgIHJldCA9IGlvY3RsKGZkLCBJT01NVV9JT0FTX0lPVkFfUkFOR0VTLCBpbmZvKTsNCj4+ICsg
ICAgaWYgKHJldCkgew0KPj4gKyAgICAgICAgZ290byBlcnJvcjsNCj4+ICsgICAgfQ0KPj4gKw0K
Pj4gKyAgICBpb3ZhX3JhbmdlcyA9IChzdHJ1Y3QgaW9tbXVfaW92YV9yYW5nZSAqKWluZm8tPmFs
bG93ZWRfaW92YXM7DQo+DQo+aW92YV9yYW5nZXMgPSAoc3RydWN0IGlvbW11X2lvdmFfcmFuZ2Ug
KikodWludHB0cl90KWluZm8tPmFsbG93ZWRfaW92YXM7DQoNCldpbGwgZml4LCB0aGFua3MgZm9y
IHBvaW50IG91dC4NCg0KQlJzLg0KWmhlbnpob25nDQo=

