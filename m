Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D4725256
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 05:14:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6jcu-0007jJ-Fv; Tue, 06 Jun 2023 23:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q6jcr-0007iY-IN
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 23:14:21 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q6jcn-0006Ly-0d
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 23:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686107656; x=1717643656;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AcRJ+mmXRrs0aFGgnwtvfU7/K0fjgP4lVK6VW+7BHE4=;
 b=Q7NmbXUQ+QaznaRpMmspNL6U8yDs49p/U+QsxV+VorHVqOJTfygKHUbw
 U5rqcAePxl4qaRlYIY8rIfZrg2kR0lVPNXiPN+E0ozUCOrgW51S99uf19
 mLZ8sNc3+UhNCY/pttNzoqFoITh4doxaAjGkRbC1DD9bp5nVrh9IgPFb7
 ek/yJQEMm/HiS073o6RaGmkkbcz/o6P4V/X/DmIcw0CNhdb8cOA8KoqYx
 lc3w1cFzgt/mXs1iihqEtpKu0ns2wl0ZcH+btZvLKUIFECceEy9axiTMt
 7QvVecqYqGfk0ZfPWPc0PZtvIjYAJOV6aOuCyBykgwOcmJLG/a+4jwNNl g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="356874816"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; d="scan'208";a="356874816"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2023 20:14:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="833485127"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; d="scan'208";a="833485127"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga004.jf.intel.com with ESMTP; 06 Jun 2023 20:14:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 20:14:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 20:14:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 20:14:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMAAawNoLBPJHWEMa2UYjdc1FPIbw9x0mzpBYIb/Jvm7T9ojFs12rX6JepKPlKzH5gDD9AltsfCVwQX/stU67MUldSH67O+wsPxk0ZV572W5JwtHcHzZsyvM6kxeGRuuu5m6SlZHA/LKAHJGnNvbyO5QCquhsaJ5ZH3jy5T90VUKH5Jsm14UYnLQhIw0YwSEzqlLWVK8C6eJfxyKFO0QipW0ijiC0g251olnrxM2fx72njkSpBnLT+3a2WlYwZC74FFcL1bFHCk6Xwx51nszKWg69iCODUapANWUnLyWX9QtSri4IjRLNdo/Eq74Ua+UT1qSrNxVVWNhAeMEIL6Jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcRJ+mmXRrs0aFGgnwtvfU7/K0fjgP4lVK6VW+7BHE4=;
 b=mEz6/g35kyYGNX7/ChTtiTkon/KZLxk3eG2FykDW9Tmxp60z+iJqtiOkQ8IN6non8YIsMkqK4kvmwiITH8L0+5QhTZ2wp4RkoHIXHz0fmbO8Uy1Qerf1Y7AJIyAQO//AJABk8IICi5joS9fJi2thNsmt5+sYhtTTkXOWek0HKf+Ad4bFLUFZZVurmfg35+WWHRsK7jdkq6IbxDGbuaMQCPejLSI/etiDt2MUPlx/roN+BZVQ6bfoQaVZ9b5Ir4FMUUglFYFumUqvkD4jgdnMsgO9yx757aMOacEwIiM5aXPx+b8Add0j/sxxmj4HqaHpxSj1oqwxU0iENKFRbDIHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6657.namprd11.prod.outlook.com (2603:10b6:510:1c0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 03:14:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 03:14:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Thread-Topic: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Thread-Index: AQHZlFTN28S+6rYgn0KeXmgiZMA5mq98kW8AgAB2ESCAAOqdgIAAvvxA
Date: Wed, 7 Jun 2023 03:14:07 +0000
Message-ID: <SJ0PR11MB6744F1C210BFDB46BD9269389253A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-3-zhenzhong.duan@intel.com> <ZH4r3FCIU8uOiV8h@x1n>
 <SJ0PR11MB674438D23927056A81F447DC9252A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZH9TtfQ/iSChuPSj@x1n>
In-Reply-To: <ZH9TtfQ/iSChuPSj@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6657:EE_
x-ms-office365-filtering-correlation-id: e19b57f9-a83e-4fbc-7c43-08db6705418f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zyx2ACLUfmKB0Pi4eA+kzOToWBPoHwFr99Ln1vPNVysQUfM6sVT3b0I4IwTahoOgQpTLBE6qa+q/8GqDSFuykxMHY+FWCU+Ar/+3YUxISoHztZ+teh32yHh1dmSLYxZnL9VpZ1v+KPSL+N4vNRogZ3aqP1MzrFesW9TCMhbGfu5EjMqRB1qm1irW/syoHawAhQzHkDPGgIuaS2v11cnSXt8kQOuAcYDMb3b5XuYLfF7m8H0H6dnHRoAVWJmHVFnY2J+g2sq0/ty4sHUvXUU39ZDwdDxWzZOLiE3+atRXx2ISjGa9j54ZE/XFWOkdLdX2BBcJud/iKyiqtWk89m0fyFzxML3d9UVbVDReccDpLvGv0Uj+pFH+lT0wVXMxiCDuJ3/VnUU+EqPj03GM6zszGPfeFWXdSogBqYd5QGU4EZ/hSiL5y/MSraYouhikQIcGhDZ9D54ygZCop6AyMx7nt0af5N5rrBGgGEkCdkZVKU69rBEG2+IFq3mI7SD6vys8BAZRzBk0X3wqU9eC9k79XpTDKLNEyJg3NKdyT67qC/qzjem1rrNVBro6+CCKCAnD4rxzhtsmzg76t90rvWkDWs26Q+pjN9kDWkntmVskWJcAkob9bIoFh/GEZWnp4gPSWKthaFcWsumVLpt0NYXUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(39860400002)(396003)(376002)(451199021)(2906002)(33656002)(55016003)(122000001)(82960400001)(38100700002)(86362001)(186003)(54906003)(7696005)(66556008)(478600001)(71200400001)(8936002)(7416002)(52536014)(6916009)(66476007)(316002)(64756008)(66946007)(41300700001)(4326008)(8676002)(66446008)(83380400001)(38070700005)(76116006)(5660300002)(107886003)(6506007)(9686003)(26005)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlNIMHhpSFlaWHJNcHZzTVMrN2kvdllrc2hVajNXTDU4RUhGL215d3UrZGdt?=
 =?utf-8?B?OUlBRmJKV0thdGpJV0loOWpVTU5SRFh0RnY3RFRGdFpyTG55aGV6R2ttcVBB?=
 =?utf-8?B?dXV6VHAvZ3J0MGNoYURMWUpPWXdZekNMNHdTQytvQnY4dGw3TGNiNUZjK01o?=
 =?utf-8?B?Q0U4RUZrbHpDRFQ2eWdaVzFOS09MNVg0TzFpL2krREp3K0Y4enpJclU4ajh0?=
 =?utf-8?B?MXZuNTVURmNGS284TE1JVkl5Vm9aWHcvcmorV1dVU0VxTXY4NEZVc0E5enhJ?=
 =?utf-8?B?bElkb1ZmSjgyNjNXd0x3MzlheTh0OUdNKytsRmJncC85SFUzWWFQOFUvVGVM?=
 =?utf-8?B?U25KTHVOUGRITEZUQnA1OW5jYWVzR2ZoOGU5eElrN1JmUHNOcHZ0dUlIaVFv?=
 =?utf-8?B?THRZbGFLanlNYVY4LzBOd1huYWYwVWNrRnBObWFzQStIYVBmdHJ1VEhxUmNO?=
 =?utf-8?B?SFFhWmVrNlpnR1JwOHJyRldaT1JiZjQ2RHZwdXdZWlVQYk1yZllmZCtQeDNJ?=
 =?utf-8?B?aGRLaDRzbEhsSVR0d0NLdENmblE3NDJsNjBvUnJqdDA3Wm90b1ZHNzJiakw1?=
 =?utf-8?B?YUI2dWtxQTRvbVdaTTBiSFAzYmkwajBOU1pFTGxKRGkyREJNSlpGenA5QWc4?=
 =?utf-8?B?SzZjajNJbkUzbDZocFVXTzF1UlhDRnl6c2UyMFZiWXN1NzZxMDBEMDFYZEpQ?=
 =?utf-8?B?M1BrZVpNblJJVUN3Nng5dzNZY2RXdnR5NStFTnF6OHB4NTllVTBXQjdtb1pV?=
 =?utf-8?B?MU5zMDNNSkhNQUUvaE1iN01wYWt0SEJIaGxxTTBqTTFMaFZBSGRLU21GYlNS?=
 =?utf-8?B?YWZrUlg4aHg5aDgvbndqeWt2Yjh3UGsxK2lGTUJ3dTROSFlWWDRTTjQrMWpS?=
 =?utf-8?B?ZThaVDFQaU9qd0NJcDFNdlN2c1dBampySUdPVEJkOEdzckVpTmROSmR6eFpX?=
 =?utf-8?B?VFpadDhVcGJPaWM2V1A2VGJ0bDdITFJudDRMSCt6U2FiU2VCbS9xZ1pJMGZW?=
 =?utf-8?B?SXh3TjU4RGFuQi9Sc3p5WlJFUm9EZ0Y1MjVHMjR1NzlsUzd2RVllVzB4Zkpi?=
 =?utf-8?B?MXpLODJaZ0ZHVXJ4alE3VHJEOWdxNk5qbzE5SGlXRFRWSzB0eEZLdUovaTg4?=
 =?utf-8?B?NU5KaVZOK01oMkpRazRaNFNrT3NaS1laekh4aTlZWG5CbkZhbldqTUVCcTUz?=
 =?utf-8?B?STZiYUJJOEpBVnNCdUdyS2prcFRSelI1NGlmckJ4YnJ4S3Z0Q3p5QUYwcmNr?=
 =?utf-8?B?SXQ3VUdmTytibzJ1VHQ1Z293aEkvMzdMYjJIbHRmT1V2Si9iRjJUMml4amFV?=
 =?utf-8?B?ZzVsK241SU00MS8ybG93Z1JqMlJQNnh0Zm95b2hqUVZKR3dGeEZwWXJkNUlJ?=
 =?utf-8?B?clk1ZzJ3R2E5NkRZWktST1lPam41MVM1K29mZjZVN1I3N1R2anJsNUZzSXpW?=
 =?utf-8?B?KzgydTdFS1MyOHQxVk52VHFVRVlQaGhaTlAydklnRHh1QjI2dWYwWWJMSWZw?=
 =?utf-8?B?M1hIaFJBV0ZHa0loc1Q3Z1ozZEJuMFJkbHVpU1VrbFYwQWhabXFPbm9ZbnBL?=
 =?utf-8?B?WjlZMXNqZi9penI0UThvb3BCeW1iZkRNZlkwcmJrNk5OTGdrR25icWhIRStM?=
 =?utf-8?B?bzBnZ1VqZERHMmMrQjJvVURkWlZsSHQ3OGkrdGVTMk1BOWIzZEliWmVmaXQw?=
 =?utf-8?B?NC9TMzFObXVqR3o3RHZsczNZVGh5bVRSeU9KZFpBT3lob2FTNmNiYUk0YUZS?=
 =?utf-8?B?b1FXOStSSGkxTW1LcHkyWDFuVGY0NE5Dd29XT1REZUxkRVdDM2w3K1RGU1ZZ?=
 =?utf-8?B?enlYNEtTNTdIV0lEWnluY1M1L1lCLzdHNi9HRER5RDliU1NxdzVSUW50aDV4?=
 =?utf-8?B?VUt3dXFLWUJzWU5icXdPdkF6ZTBXT0RXZGZ2VHpJRUFPOVJlaWJBTys4OHRY?=
 =?utf-8?B?ZTRCNmNnT2Uybml5blB6Z0FVTlBtbHkzNm4vL2NCUUEyUUsrSUJyWkNaRlNE?=
 =?utf-8?B?d2kvelBUUm5hZEw3UE1nQnI4RFU1aUJHTFo1V3JMZTluWnhPZ3JYL0VlMll4?=
 =?utf-8?B?RFNoejl3cko4c2lOTFFIS3VaQ1laT1hNR2xWcWViUHlXTUZUSDJOWVR1cDBG?=
 =?utf-8?Q?O6PWNecnP2CXFRDvW4ly+vkC2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b57f9-a83e-4fbc-7c43-08db6705418f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 03:14:07.5304 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Nc/RfV4LqoIFFZJTexQDUecx/x2yw1ZpcO9QxWCJQZVg25Vrn1enrIzWgtvR94kTiF3jP2sOt85lmMGSeVtsmPT6HGMtob5VtCWT85l12Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6657
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mga14.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDYsIDIwMjMgMTE6NDIgUE0NCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDIvNF0gaW50ZWxfaW9tbXU6IEZpeCBhIHBvdGVudGlhbCBpc3N1
ZSBpbiBWRklPIGRpcnR5DQo+cGFnZSBzeW5jDQo+DQouLi4NCj4+ID4+IGEvaW5jbHVkZS9leGVj
L21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oIGluZGV4DQo+PiA+PiBjMzY2MWIyMjc2
YzcuLmVlY2MzZWVjNjcwMiAxMDA2NDQNCj4+ID4+IC0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnku
aA0KPj4gPj4gKysrIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiA+PiBAQCAtMTQyLDYgKzE0
MiwxMCBAQCBzdHJ1Y3QgSU9NTVVUTEJFbnRyeSB7DQo+PiA+PiAgICogICAgICAgZXZlbnRzIChl
LmcuIFZGSU8pLiBCb3RoIG5vdGlmaWNhdGlvbnMgbXVzdCBiZSBhY2N1cmF0ZSBzbyB0aGF0DQo+
PiA+PiAgICogICAgICAgdGhlIHNoYWRvdyBwYWdlIHRhYmxlIGlzIGZ1bGx5IGluIHN5bmMgd2l0
aCB0aGUgZ3Vlc3Qgdmlldy4NCj4+ID4+ICAgKg0KPj4gPj4gKyAqICAgICAgIEJlc2lkZXMgTUFQ
LCB0aGVyZSBpcyBhIHNwZWNpYWwgdXNlIGNhc2UgY2FsbGVkIEZVTExfTUFQIHdoaWNoDQo+PiA+
PiArICogICAgICAgcmVxdWVzdHMgbm90aWZpY2F0aW9uIGZvciBhbGwgdGhlIGV4aXN0ZW50IG1h
cHBpbmdzIChlLmcuIFZGSU8NCj4+ID4+ICsgKiAgICAgICBkaXJ0eSBwYWdlIHN5bmMpLg0KPj4g
Pg0KPj4gPldoeSBkbyB3ZSBuZWVkIEZVTExfTUFQPyAgQ2FuIHdlIHNpbXBseSByZWltcGwgTUFQ
Pw0KPj4NCj4+IFNvcnJ5LCBJIGp1c3QgcmVhbGl6ZWQgSU9NTVVfTk9USUZJRVJfRlVMTF9NQVAg
aXMgY29uZnVzaW5nLg0KPj4gTWF5YmUgSU9NTVVfTk9USUZJRVJfTUFQX0ZBU1RfUEFUSCBjb3Vs
ZCBiZSBhIGJpdCBtb3JlIGFjY3VyYXRlLg0KPj4NCj4+IElJVUMsIGN1cnJlbnRseSByZXBsYXko
KSBpcyBjYWxsZWQgZnJvbSB0d28gcGF0aHMsIG9uZSBpcyBWRklPIGRldmljZQ0KPj4gYWRkcmVz
cyBzcGFjZSBzd2l0Y2ggd2hpY2ggd2Fsa3Mgb3ZlciB0aGUgSU9NTVUgcGFnZSB0YWJsZSB0byBz
ZXR1cA0KPj4gaW5pdGlhbCBtYXBwaW5nIGFuZCBjYWNoZSBpdCBpbiBJT1ZBIHRyZWUuIFRoZSBv
dGhlciBpcyBWRklPIGRpcnR5DQo+PiBzeW5jIHdoaWNoIHdhbGtzIG92ZXIgdGhlIElPTU1VIHBh
Z2UgdGFibGUgdG8gbm90aWZ5IHRoZSBtYXBwaW5nLA0KPj4gYmVjYXVzZSB3ZSBhbHJlYWR5IGNh
Y2hlIHRoZSBtYXBwaW5nIGluIElPVkEgdHJlZSBhbmQgVkZJTyBkaXJ0eSBzeW5jDQo+PiBpcyBw
cm90ZWN0ZWQgYnkgQlFMLCBzbyBJIHRoaW5rIGl0J3MgZmluZSB0byBwaWNrIG1hcHBpbmcgZnJv
bSBJT1ZBDQo+PiB0cmVlIGRpcmVjdGx5IGluc3RlYWQgb2Ygd2Fsa2luZyBvdmVyIElPTU1VIHBh
Z2UgdGFibGUuIFRoYXQncyB0aGUNCj4+IHJlYXNvbiBvZiBGVUxMX01BUCAoSU9NTVVfTk9USUZJ
RVJfTUFQX0ZBU1RfUEFUSCBiZXR0ZXIpLg0KPj4NCj4+IEFib3V0ICJyZWltcGwgTUFQIiwgZG8g
eW91IG1lYW4gdG8gd2FsayBvdmVyIElPTU1VIHBhZ2UgdGFibGUgdG8NCj4+IG5vdGlmeSBhbGwg
ZXhpc3RpbmcgTUFQIGV2ZW50cyB3aXRob3V0IGNoZWNraW5nIHdpdGggdGhlIElPVkEgdHJlZSBm
b3INCj4+IGRpZmZlcmVuY2U/IElmIHlvdSBwcmVmZXIsIEknbGwgcmV3cml0ZSBhbiBpbXBsZW1l
bnRhdGlvbiB0aGlzIHdheS4NCj4NCj5XZSBzdGlsbCBuZWVkIHRvIG1haW50YWluIGlvdmEgdHJl
ZS4gSUlVQyB0aGF0J3MgdGhlIG1ham9yIGNvbXBsZXhpdHkgb2YgdnQtZA0KPmVtdWxhdGlvbiwg
YmVjYXVzZSB3ZSBoYXZlIHRoYXQgZXh0cmEgY2FjaGUgbGF5ZXIgdG8gc3luYyB3aXRoIHRoZSBy
ZWFsIGd1ZXN0DQo+aW9tbXUgcGd0YWJsZXMuDQoNCkNhbid0IGFncmVlIG1vcmUsIGxvb2tzIG9u
bHkgaW50ZWwtaW9tbXUgYW5kIHZpcnRpby1pb21tdSBpbXBsZW1lbnRlZCBzdWNoDQpvcHRpbWl6
YXRpb24gZm9yIG5vdy4NCg0KPg0KPkJ1dCBJIHRoaW5rIHdlIHdlcmUganVzdCB3cm9uZyB0byBh
bHNvIG5vdGlmeSBpbiB0aGUgdW5tYXBfYWxsKCkgcHJvY2VkdXJlLg0KPg0KPklJVUMgdGhlIHJp
Z2h0IHRoaW5nIHRvIGRvIChrZWVwaW5nIHJlcGxheSgpIHRoZSBpbnRlcmZhY2UgYXMtaXMsIHBl
ciBpdCB1c2VkIHRvIGJlDQo+ZGVmaW5lZCkgaXMgd2Ugc2hvdWxkIHJlcGxhY2UgdGhlIHVubWFw
X2FsbCgpIHRvIG9ubHkgZXZhY3VhdGUgdGhlIGlvdmEgdHJlZQ0KPihrZWVwaW5nIGFsbCBob3N0
IG1hcHBpbmdzIHVudG91Y2hlZCwgSU9XLCBkb24ndCBub3RpZnkgVU5NQVApLCBhbmQgZG8gYQ0K
PmZ1bGwgcmVzeW5jIHRoZXJlLCB3aGljaCB3aWxsIG5vdGlmeSBhbGwgZXhpc3RpbmcgbWFwcGlu
Z3MgYXMgTUFQLiAgVGhlbiB3ZQ0KPmRvbid0IGludGVycnVwdCB3aXRoIGFueSBleGlzdGluZyBt
YXBwaW5nIGlmIHRoZXJlIGlzIChlLmcuIGZvciB0aGUgZGlydHkgc3luYw0KPmNhc2UpLCBtZWFu
d2hpbGUgd2Uga2VlcCBzeW5jIHRvbyB0byBsYXRlc3QgKGZvciBtb3ZpbmcgYSB2ZmlvIGRldmlj
ZSBpbnRvIGFuDQo+ZXhpc3RpbmcgaW9tbXUgZ3JvdXApLg0KPg0KPkRvIHlvdSB0aGluayB0aGF0
J2xsIHdvcmsgZm9yIHVzPw0KDQpZZXMsIEkgdGhpbmsgSSBnZXQgeW91ciBwb2ludC4NCkJlbG93
IHNpbXBsZSBjaGFuZ2Ugd2lsbCB3b3JrIGluIHlvdXIgc3VnZ2VzdGVkIHdheSwgZG8geW91IGFn
cmVlPw0KDQpAQCAtMzgyNSwxMyArMzgzMywxMCBAQCBzdGF0aWMgdm9pZCB2dGRfaW9tbXVfcmVw
bGF5KElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmllciAqbikNCiAgICAg
SW50ZWxJT01NVVN0YXRlICpzID0gdnRkX2FzLT5pb21tdV9zdGF0ZTsNCiAgICAgdWludDhfdCBi
dXNfbiA9IHBjaV9idXNfbnVtKHZ0ZF9hcy0+YnVzKTsNCiAgICAgVlREQ29udGV4dEVudHJ5IGNl
Ow0KKyAgICBETUFNYXAgbWFwID0geyAuaW92YSA9IDAsIC5zaXplID0gSFdBRERSX01BWCB9DQoN
Ci0gICAgLyoNCi0gICAgICogVGhlIHJlcGxheSBjYW4gYmUgdHJpZ2dlcmVkIGJ5IGVpdGhlciBh
IGludmFsaWRhdGlvbiBvciBhIG5ld2x5DQotICAgICAqIGNyZWF0ZWQgZW50cnkuIE5vIG1hdHRl
ciB3aGF0LCB3ZSByZWxlYXNlIGV4aXN0aW5nIG1hcHBpbmdzDQotICAgICAqIChpdCBtZWFucyBm
bHVzaGluZyBjYWNoZXMgZm9yIFVOTUFQLW9ubHkgcmVnaXN0ZXJzKS4NCi0gICAgICovDQotICAg
IHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKHZ0ZF9hcywgbik7DQorICAgIC8qIHJlcGxheSBpcyBw
cm90ZWN0ZWQgYnkgQlFMLCBwYWdlIHdhbGsgd2lsbCByZS1zZXR1cCBJT1ZBIHRyZWUgc2FmZWx5
ICovDQorICAgIGlvdmFfdHJlZV9yZW1vdmUoYXMtPmlvdmFfdHJlZSwgbWFwKTsNCg0KICAgICBp
ZiAodnRkX2Rldl90b19jb250ZXh0X2VudHJ5KHMsIGJ1c19uLCB2dGRfYXMtPmRldmZuLCAmY2Up
ID09IDApIHsNCiAgICAgICAgIHRyYWNlX3Z0ZF9yZXBsYXlfY2VfdmFsaWQocy0+cm9vdF9zY2Fs
YWJsZSA/ICJzY2FsYWJsZSBtb2RlIiA6DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

