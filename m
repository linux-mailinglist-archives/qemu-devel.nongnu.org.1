Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 709EE7EBC8F
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 05:18:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r37Kg-0006g3-DQ; Tue, 14 Nov 2023 23:16:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r37Kd-0006fu-1d
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 23:16:51 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r37Ka-0001Tn-Nz
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 23:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700021808; x=1731557808;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Wa6Ait7lSQ8YXfiVImactRuRATXCyz9tjaKjFXW45To=;
 b=Gxk2ugML+CpeAr7iaF/niuOW3bMSW6+Yq1dZ00WKapeq78oCUNCw8gDP
 fGlifSf0Bmqgb/arB+eqzWmr4CTdGyM6amUPxN6Uwj3izUV1ZRsaPkOQm
 iXsKcaalZE6UiL7eR0tnTfEhl/9QFVzTYjk7cSkv2wCrNEGnaVfNIOmDX
 sTVk9ovKd+f+vqNx+js8Avzn5+y2VoLNslEnaFV3zLaLUyHjLzzQxgHCl
 xqZwAkZfbYx0gDvQPhNg+UY6Tvk05KA98htUp/TunZCgFJdLjtBEAlhfk
 BmrDJVw42rghDcBbKHF9uKeGIRzv1R/E/3BGRiqKBg6S//u8ewTDHyf3X A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="387971372"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; d="scan'208";a="387971372"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 20:16:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="758378555"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; d="scan'208";a="758378555"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Nov 2023 20:16:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 20:16:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 20:16:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 20:16:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 20:16:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBZ1amEPqCLw//HIv3hBTTL+jxNBsZ76+PKBwPlNzg29D8YQ/CbiME47faZ0n5SdAW/TEYmrUo2VhBhedcMmaY6cWbQYzscfWlEbJZy+H1b/HdkUMPQA7W0i8B53gqHIKKu93krmf1YAJfmYDIFnmpqtf0NYW/jayFaq3Gvu5OQmnUtapkm8ni8GdaNuWY5HSro2s5ZkHn+dXArtYiWDiDYcElKUzOFk5EE3iVwJj0e7ygYvF7e9OMTpigVafJmF6dma4sDuYgTwJmdLF54i7B1HBcRu+CtEInSe/nd9fUts/ouMY70gOjQ37OltwkGKr1GIFhf/cc6q1QJDaO3eqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa6Ait7lSQ8YXfiVImactRuRATXCyz9tjaKjFXW45To=;
 b=Qees7/ZvqEx7RgvEPUFyEePEZjfVBYqQtn3tV6sB6S/QAnId39P6bYFCbAoHppV6Ptb7Zpq+T3h1ctqwb7U8Zh6M+CRFeVJQuMyQcERo70kul5EnCE8UBAtlvXx1NLcNtl6Eu42LEKKPGmKsCLejTDO7Rqol7nbICSZEq1ffkFXkXBCMFJ0pWle7xdeAFL3JU+XMVhLMSPiPwsFmmc9ylGDi/e2R35qId6qj6sMUfAs80JxQnGudsD6G6/KGXDoI+WlubxU8KhMUcFbPkEK3YeUkxccazpe53NstlXNIOBT7J78Hxy+OOQGKJm43gO6sGP8S4udh2QPeAgn17LuWpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB8599.namprd11.prod.outlook.com (2603:10b6:510:2ff::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17; Wed, 15 Nov
 2023 04:16:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 04:16:36 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 00/21] vfio: Adopt iommufd
Thread-Topic: [PATCH v6 00/21] vfio: Adopt iommufd
Thread-Index: AQHaFuTmNDpqSpZXBE69ql2uW35WS7B55nOAgADbwxA=
Date: Wed, 15 Nov 2023 04:16:36 +0000
Message-ID: <SJ0PR11MB6744D64803CD4F84570E8D0E92B1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <598a9514-e96d-48da-9447-c168882e0b75@redhat.com>
In-Reply-To: <598a9514-e96d-48da-9447-c168882e0b75@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB8599:EE_
x-ms-office365-filtering-correlation-id: a0818339-d367-4495-a930-08dbe591a869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNCPiGiO+ohnFMGf4up4oXqk7iyCP25yXk+I/zDnqcbe4Qe0bjfDA1zKk+Upluq3mx5Jnk+oDxZvB9wRPUI4+tmDb/24hLEwnxV+Il3suqzGGaU5Rs2ubD2xaeFD4hhwZvvm3sWolyil5rvLSLZizzHrCts3XgiHBfK08sf1DKp6wn/Z+mEN11WKS8LNKvFSt9EXjZE5kYR6y653g+6YOP0tLEu69RhMnfF7st8uo2LPTUqu0sVKrOAemnptZvSkYW85IFKThbLXPR0RKrAaUqPzw+4XbT8hLjjtqWbKsOzSIPq9APP2/TWr9DP3raS/Q58ul1IQjZ9O6XPYRs8+6KiUzKaf6SKMehodtEiD89XqSlkXC4Bqh8ebUk46mAUjz/PGrtB39Zi9y3jhRtz7vtC1bfi1JPSImkZ5tJ3kGJ5kLi2xTVL9/MQubxwBdMX7q+uXZHInCUN4yroLRD3GnmMBho6UVIr/5c2C4iEb8XM1FZL2XCI6rxU82rpVeqZ+O9tsBS9YnKohQDjUPGa9t3m3xe6diU1JJGaBBB7kcdpbB4dtPpcrENciOdoHRt1gvQa3GQfQPcoZBNq1FOMyyPWLP8+D9o5+xRiMBF9oqTvSxaUACJmUyblN8euZogQwig+styzTL82Pu0V8aVHCXQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(82960400001)(9686003)(66574015)(107886003)(26005)(966005)(478600001)(52536014)(86362001)(4326008)(8676002)(8936002)(5660300002)(41300700001)(33656002)(2906002)(76116006)(66476007)(38070700009)(54906003)(64756008)(66556008)(66946007)(66446008)(316002)(110136005)(6506007)(7696005)(71200400001)(55016003)(38100700002)(122000001)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE43YW1HVlJNTFAzYmFkcksyMzl3M2FJc3BQTFBEVTJuUjdRaEhmWjM4UTlR?=
 =?utf-8?B?Y2Z3WmFFaUIySkQ4akhpQWtVQkxiVHlxTERXS1dUa3k5LzRVbThnTzhvWWxl?=
 =?utf-8?B?NllYdUsxZzlNd3FLMWQzVWxEb2tBcS9HMlZWYXRET25QeUd1RmRBMlNsRlA1?=
 =?utf-8?B?VFdJdVFKdTFvRGlRS2VxSytTZno2WEtWOGlqS044a0d4QmswL0pVRDZ6LzFH?=
 =?utf-8?B?TnpUcTVSL2xRQUpPZ29jaERvSmNHOFIzOWJSK1pzdURBT1pOQUNYVEpBcUQr?=
 =?utf-8?B?eGR5b283SDVvUXNJQUZ0WHZHdjN5SmloSEpBSitRaE5OTVZSRmplUHJ6Wi9J?=
 =?utf-8?B?U1lpd0UreFJieXM2SHF6K3ByOHlTR3VIeThsaGpBQUVXYzFjMGNud2NwOUJr?=
 =?utf-8?B?WDlqd2hWSGRGaGQ3OVRlQkQvRXUvSklVOGpTWGxLbUFJR0hQcHlWaTlMendk?=
 =?utf-8?B?eWh2ZVhqMHVpbmIvcDNpNXF0WVhBSFRaOUlsVEJCbE9UMU9oT09IQlJlOVdm?=
 =?utf-8?B?YlJ3UWc5MVVJcHNLTnFyQTJXYUwyVUFkNnA3Y29oSWtmZDBPZUlhYnJ5a0or?=
 =?utf-8?B?OGRnQ1FoYzFjUW4vb0NrVzUrYzVpSCtseWFHeGYzby9HZW12cXQ3bWR0YzJm?=
 =?utf-8?B?Ti92a3krNmlSOEU3MHR1MUx1UFB2NXhHZ0E1aUZFakMzMm9PRlg4OGU3OHhQ?=
 =?utf-8?B?elBOVytqQ2JidGVDZE9IZEdzUEFlQU8xREh4VCtoMXlwcDNPb3hUalFpRWdj?=
 =?utf-8?B?Z2Y2TVM3eGg4S244SzRuM2Q1eHZWSmZ6dDdsZE9FT0lkYzd5MHVielBNRjFi?=
 =?utf-8?B?dGxWYVBjK2pQY0Z3OURSK3R2MWdIbXNpTy9ZMlNaRFMxNFFZWGxEOVdLdkNV?=
 =?utf-8?B?R1RxdjNPZE9tWGJoL2gzOHRlaEVyYTdRNFIzQ0h3RGJDSDNYNUU1YzF0N1Zi?=
 =?utf-8?B?NHVPSzU3aUo3eldKMXk3cVU3eXJ4eWRVRHhxTlI1NTJnd2lmc3VTMDN3L0t2?=
 =?utf-8?B?TGNzVytMQ1BxU1NjbDFydXBkVElnbWJXOUNwVFRweVNvdGdPWVZTTEwvRmxY?=
 =?utf-8?B?RUZHenhpb3JTWGpwcncwL3RnRlJpelNZNVFRYUcxZzZqUytwUlFEQVJPeS9h?=
 =?utf-8?B?cUZhRWRueXptTDdOM25xU2Nub2F1N2ZyaHRhZUhGb2pwWThqaWJQNW9tYk1a?=
 =?utf-8?B?WU9LY2c2QXlRNGFBdnNlTTVGNWdydHE3QVdPRkhuSG9jdWJsV2IvSVBWQlFj?=
 =?utf-8?B?UFhIa2NWTkRxK3lvc0Vqa1FzaG5PekMvN3MyMis3ZnpsR0VZOUNMejl6VzBa?=
 =?utf-8?B?NTlqZ052OG5ZcDhQcThFMi96TWp2NUo1YzlBanpHU0xMUXQ3alA4ZUxoZmFh?=
 =?utf-8?B?REhFK29reDgzQ01MVFdvUThMUHAwZWVmQ3dMUExxNnozZFFCd3dhVExYRWRk?=
 =?utf-8?B?VFF4cmxJWHg1aVgwSnI5dXYxTko0M0UzZmZ2RzdjNk96MGZ3b0IwQm5xaFds?=
 =?utf-8?B?NTZkTUxPN0lSNWNSTU5GelRDUDZLeGcvTnJralVPWUtIRnZ5OHpVeWdiMG52?=
 =?utf-8?B?d2NDeG51RDQ3YzdscmFnZ1lUTmNjZG5MV3hyTWF4NXhVOWtOczZsck5FV25B?=
 =?utf-8?B?cjR5cEJkVkRzV1llTjR0SmpreTJPK2JNbkR4WUNhSVF6cE9ERFlKVkxURjNU?=
 =?utf-8?B?b0VyQUxxdFJKNjBaSlFhbW5ETTI0TDFhSzE2ZVo0elYzUlNOWENjcWtDVkhw?=
 =?utf-8?B?NDdZbFV5M1gxU1BXUWpvczVkSXppWnVZQzdna3NFVnpPcWtOTWxrazFWRGw0?=
 =?utf-8?B?UUFtWkFVTUpiaytlYWRILzVMK0ZZM2RGVzZRVm1wazgwQ0F2L1dPdzFnejFP?=
 =?utf-8?B?YzJlYmFXTlVMUUV2dWxuYTIwUEVrb3doM3hMRUNiUmZ2ZGU3WmE3bC90UzJs?=
 =?utf-8?B?aFdjT2FlaGFyc2FJeTU2LzByU2cyYUErd0VUTWlpanRxR1dkRUx4cEVkem1U?=
 =?utf-8?B?UTRVUStBTDMrTDg0ZkNhUk90MExwcDVGODRTdjhhcnVEM2NXbi9NRTZJSFlj?=
 =?utf-8?B?bVdtcXROSEJ5VDRxOFJzQUZyU1YxS0NuU1ZadCtIK2lFSHlxdWFlVjRHMVc0?=
 =?utf-8?Q?sjjAdeYiJpG62Yn+hzaE4tZvh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0818339-d367-4495-a930-08dbe591a869
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 04:16:36.1155 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AJq7UBmtIlNf93nWoYE6w0wO6xFd35DB0gcG/v1LeR7SMwd/BeM0XfSurx0e/ekXkDvMyAMwSiLJkO0Mcj3rQQFnpnZ8rfyLtL+sPdyickQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8599
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE0
LCAyMDIzIDEwOjUyIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NiAwMC8yMV0gdmZpbzogQWRv
cHQgaW9tbXVmZA0KPg0KPkhlbGxvIFpoZW56aG9uZywNCj4NCj5PbiAxMS8xNC8yMyAxMTowOSwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBUaGFua3MgYWxsIGZvciBnaXZp
bmcgZ3VpZGVzIGFuZCBjb21tZW50cyBvbiBwcmV2aW91cyBzZXJpZXMsIHRoaXMgaXMNCj4+IHRo
ZSByZW1haW5pbmcgcGFydCBvZiB0aGUgaW9tbXVmZCBzdXBwb3J0Lg0KPj4NCj4+IEJhc2VkIG9u
IEPDqWRyaWMncyBzdWdnZXN0aW9uLCByZXBsYWNlIG9sZCBjb25maWcgbWV0aG9kIGZvciBJT01N
VUZEDQo+PiB3aXRoIEtjb25maWcuDQo+Pg0KPj4gQmFzZWQgb24gSmFzb24ncyBzdWdnZXN0aW9u
LCBkcm9wIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBtYW51YWxseQ0KPj4gYWxsb2NhdGluZyBod3B0
IGFuZCBzd2l0Y2ggdG8gSU9BUyBhdHRhY2gvZGV0YWNoLg0KPj4NCj4+IEJlc2lkZSBjdXJyZW50
IHRlc3QsIHdlIGFsc28gdGVzdGVkIG1kZXYgd2l0aCBtdHR5IGZvciBiZXR0ZXIgY292ZXIgcmFu
Z2UuDQo+Pg0KPj4gUEFUQ0ggMTogSW50cm9kdWNlIGlvbW11ZmQgb2JqZWN0DQo+PiBQQVRDSCAy
LTk6IGFkZCBJT01NVUZEIGNvbnRhaW5lciBhbmQgY2RldiBzdXBwb3J0DQo+PiBQQVRDSCAxMC0x
NzogZmQgcGFzc2luZyBmb3IgY2RldiBhbmQgbGlua2luZyB0byBJT01NVUZEDQo+PiBQQVRDSCAx
ODogbWFrZSBWRklPQ29udGFpbmVyQmFzZSBwYXJhbWV0ZXIgY29uc3QNCj4+IFBBVENIIDE5LTIx
OiBDb21waWxlIG91dCBmb3IgSU9NTVVGRCBmb3IgYXJtLCBzMzkweCBhbmQgeDg2DQo+Pg0KPj4N
Cj4+IFdlIGhhdmUgZG9uZSB3aWRlIHRlc3Qgd2l0aCBkaWZmZXJlbnQgY29tYmluYXRpb25zLCBl
Lmc6DQo+PiAtIFBDSSBkZXZpY2Ugd2VyZSB0ZXN0ZWQNCj4+IC0gRkQgcGFzc2luZyBhbmQgaG90
IHJlc2V0IHdpdGggc29tZSB0cmljay4NCj4+IC0gZGV2aWNlIGhvdHBsdWcgdGVzdCB3aXRoIGxl
Z2FjeSBhbmQgaW9tbXVmZCBiYWNrZW5kcw0KPj4gLSB3aXRoIG9yIHdpdGhvdXQgdklPTU1VIGZv
ciBsZWdhY3kgYW5kIGlvbW11ZmQgYmFja2VuZHMNCj4+IC0gZGl2aWNlcyBsaW5rZWQgdG8gZGlm
ZmVyZW50IGlvbW11ZmRzDQo+PiAtIFZGSU8gbWlncmF0aW9uIHdpdGggYSBFODAwIG5ldCBjYXJk
KG5vIGRpcnR5IHN5bmMgc3VwcG9ydCkgcGFzc3Rocm91Z2gNCj4+IC0gcGxhdGZvcm0sIGNjdyBh
bmQgYXAgd2VyZSBvbmx5IGNvbXBpbGUtdGVzdGVkIGR1ZSB0byBlbnZpcm9ubWVudCBsaW1pdA0K
Pj4gLSB0ZXN0IG1kZXYgcGFzcyB0aHJvdWdoIHdpdGggbXR0eSBhbmQgbWl4IHdpdGggcmVhbCBk
ZXZpY2UgYW5kIGRpZmZlcmVudCBCRQ0KPj4NCj4+IEdpdmVuIHNvbWUgaW9tbXVmZCBrZXJuZWwg
bGltaXRhdGlvbnMsIHRoZSBpb21tdWZkIGJhY2tlbmQgaXMNCj4+IG5vdCB5ZXQgZnVsbHkgb24g
cGFyIHdpdGggdGhlIGxlZ2FjeSBiYWNrZW5kIHcuci50LiBmZWF0dXJlcyBsaWtlOg0KPj4gLSBw
MnAgbWFwcGluZ3MgKHlvdSB3aWxsIHNlZSByZWxhdGVkIGVycm9yIHRyYWNlcykNCj4+IC0gZGly
dHkgcGFnZSBzeW5jDQo+PiAtIGFuZCBldGMuDQo+Pg0KPj4NCj4+IHFlbXUgY29kZToNCj5odHRw
czovL2dpdGh1Yi5jb20veWlsaXUxNzY1L3FlbXUvY29tbWl0cy96aGVuemhvbmcvaW9tbXVmZF9j
ZGV2X3Y2DQo+PiBCYXNlZCBvbiB2ZmlvLW5leHQsIGNvbW1pdCBpZDogMWEyMmZiOTM2ZQ0KPg0K
PkkganVzdCBoYWQgYSBmZXcgY29tbWVudHMgdGhhdCBJIGFkZHJlc3NlZCBteXNlbGYgaW4gOg0K
Pg0KPiAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sZWdvYXRlci9xZW11L2NvbW1pdHMvdmZpby04LjIN
Cj4NCj5QbGVhc2UgdGFrZSBhIGxvb2sgYW5kIEkgd2lsbCBwb3NzaWJseSBtZXJnZSB0aGUgbW9k
aWZpZWQgdjYgaW4gdmZpby1uZXh0DQo+YWZ0ZXIgYSBmZXcgZGF5cyBvciBuZXh0IHdlZWsgd2hl
biBwZW9wbGUgYXJlIGJhY2sgZnJvbSBMUEMuDQoNCkdvb2QgZm9yIG1lLCBvbmx5IGEgbWlub3Ig
c3VnZ2VzdGlvbiB0byB1c2UgT0JKRUNUX0RFQ0xBUkVfVFlQRS4NCg0KPg0KPkkgd291bGQgbGlr
ZSB0byBwcm9wb3NlIHRoaXMgc2VyaWVzIGZvciBhbiBlYXJseSBtZXJnZSBpbiBRRU1VIDkuMC4g
U28sIHdlDQo+aGF2ZSBhIGZldyB3ZWVrcyB0byBwb2xpc2ggYW5kIHRlc3QgYSBiaXQgbW9yZS4g
SSBkaWRuJ3QgZ2V0IGZlZWRiYWNrIGZyb20NCj5BUk0gZm9yIGluc3RhbmNlICh0aGF0J3MgYSBt
ZXNzYWdlIGluIGEgYm90dGxlIGZvciBFcmljIDopLg0KDQpHbGFkIHRvIGtub3csIHRoYW5rcyB2
ZXJ5IG11Y2ggZm9yIHlvdXIgYWN0aXZlIHJldmlldyBhbmQgZ3VpZGFuY2UNCnNpbmNlIG15IGZp
cnN0IHZlcnNpb27wn5iKDQpJJ2xsIGRvIG1vcmUgdGVzdCByZWNlbnQgZGF5cy4NCg0KPg0KPk15
IGxhc3QgcmVxdWVzdCB3b3VsZCBiZSB0byB0YWtlIHNvbWUgb2YgdGhlIGRvY3VtZW50YXRpb24s
IGJlbG93IGluIHRoaXMNCj5lbWFpbCwgYW5kIGluY2x1ZGUgaXQgaW4gUUVNVS4gSXQgY2FuIGJl
IGRvbmUgbGF0ZXIuDQoNClN1cmUsIHdpbGwgZG8uDQoNCkJScy4NClpoZW56aG9uZw0K

