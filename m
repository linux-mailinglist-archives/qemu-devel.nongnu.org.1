Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F07747F20
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 10:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGxbj-0001ge-BY; Wed, 05 Jul 2023 04:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGxbZ-0001ei-EB; Wed, 05 Jul 2023 04:11:19 -0400
Received: from mga05.intel.com ([192.55.52.43])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGxbU-0006Sq-Mw; Wed, 05 Jul 2023 04:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688544672; x=1720080672;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=T0SELyfkTw3N6Y4uFaon1gb4xnz3uiHCHCfT2tRUkc8=;
 b=SBvEn6JExWNHVku+UB1I7VI0NzudQ0uWR77OXUbEvbGDjTbDbpWagoQg
 EDuB/SPaTNfuUzNjEaTwAGuCaHNGxdnEpxOXKqmd+/d8VG8kjcx/PoXno
 WltHvBEzmwzCLfMfJD4NPXinzj4CwxU4jb1C+eytL5ed2g6rrHRib86S2
 hb59bjL+7ofkv9KGrBW12FUbt2fY8TfGvZ/VyZ0/GqHB5ehtq/rV4SGWH
 r+L/ewCiEuiLxB0R3mu7JizmiVdH+OF4x3yQlZCG/bsD21vrPfbn5sf9S
 Zco1ahr8U2XXj3eDX8iB2sicOshrtbGz1n29iiW2db46bBuu3AhnUBybn g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="449647633"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="449647633"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2023 01:11:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10761"; a="713111563"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; d="scan'208";a="713111563"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP; 05 Jul 2023 01:11:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 01:11:04 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 01:11:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 01:11:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 01:11:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLX+/Pzy3hn8OZlzU3jN9sMURA4OdYnYHbBCEK8QbwpeXrhkEpR8orIoCstI9umurIJ2EtqEpQdzc/E12nC9yiPpdc1mgI+ABoAIZP28Gp3ZGJJDjlgPBQhjSDuSmTTTyrMQIe/pJOiaPrJCztjVCsm+T8NgZFDjls4L++s1zowAc5M6g5TidbeIogS9UdUlx3Y6vniE+1H0S99DpU6ytujhHIKBZaC5fKEfSAxwy5hWlpYnqPw9s0O+08Z0qQC7GA6MFJ6wuBrwE8wdpa2+2lheqh5dzvOOP4wS7TgWfSiJXU14rvT1X2cwx8tHHv1zq2aNQ5hzyRodcoNoo+3Mpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T0SELyfkTw3N6Y4uFaon1gb4xnz3uiHCHCfT2tRUkc8=;
 b=fQTRCL8pDEYIBRoK9Touhik0LChdxmJhMOAEHclD6QAPuHi53Yl5hV7MenWfphoXqADoABX31uGWAJVl/twI7uFycABecliB/xJvXOw4aoPJ2wpqPS/JG2urisOskCqHSz0fFR+IIvzglNKc3tHiUNmduTcXokVlonz5nV8r+9oIC+raU5o9wHyscsuG4x5SW7sjvAil0L2hoiMjTzUg/Us0Njolifa3PwhV96bcqEOWSxgrIftcgUiNq9rkM9meb01jKUCWMRqo1ezzmxQbAte5hnr4TAXglGEyWWONPWreh+Fp6FQ4zIvrhkRU8CMegShqVHfWMXCQw/rp6AXqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM6PR11MB4577.namprd11.prod.outlook.com (2603:10b6:5:2a1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:11:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 08:11:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhap.com" <clg@redhap.com>, "bharat.bhushan@nxp.com"
 <bharat.bhushan@nxp.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>
Subject: RE: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Topic: [PATCH 1/2] virtio-iommu: Fix 64kB host page size VFIO device
 assignment
Thread-Index: AQHZrmjiQzWi8iDMQE285Hu7NzFLv6+qlagQgAAe+YCAABtrUA==
Date: Wed, 5 Jul 2023 08:11:01 +0000
Message-ID: <SJ0PR11MB6744EB5BA14D2F57170E5F6D922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230704111527.3424992-1-eric.auger@redhat.com>
 <20230704111527.3424992-2-eric.auger@redhat.com>
 <SJ0PR11MB674435F2BA42A8925ABA336F922FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <1e6ae4e2-cd7c-16c4-440f-119399d0f551@redhat.com>
In-Reply-To: <1e6ae4e2-cd7c-16c4-440f-119399d0f551@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM6PR11MB4577:EE_
x-ms-office365-filtering-correlation-id: ef1ab9af-97c4-496c-59fe-08db7d2f5ed5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iDL5bkL8qmr7cz7mNUmHNCW3VBr+rVTT5VDAhHIodRGMNHtSg2+16jGEFCJNAdCszo4RmOjb1yyBYtaAwl4i+5gA8vhi3uO8vq0jOTlUwMTu5AQBHIKQulCD3qBXhSdxqDCqtnrJGPKkHVfQhnDEiLgrfA8IfOu71eET21b9RWYpIMn3x/09yDA8SOWcMSDj4Yt1xWOa1gYKdmG5nEz+WrhI0+7O+3n1mswHCtBLgyjhlZHXX3Sh5RypR51NAcemd7aI0XCXdkSBeflNP7Kpfqeizy5HmnZu1KNOU8r/W0/ittJ2f2x7KhoEX8xIXQdCWqOfuQevPMrnWmqZhySlAE/FKL2xCF+Qo5j2o1ViSiGR8yDf3OfSeDlS8g7UbrNEhVGR1JdjczyRtCKFl7BJgNkm/HBF4awELNYaNTh9UshnfdIGP+vcHq9rnzyShCZvBiXNBVxqG1tbyoD742vPWPOBnONnNbn673vCICOBv5vqpLU0q6NZ0vca2i6wV/H65m4Sp6NGyPdauGHzc2qLRTGMSoCoQUvb12JRp1+WQFV+6FAn8wAwc7hy5Tb6C7/MEL2Fh+63CaKmWWq4uj4x/Ok7mFY6CMDGBsH04uQZE3P5XYRwgUp2ucBcGASjjhM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(41300700001)(52536014)(8936002)(7416002)(8676002)(110136005)(7696005)(54906003)(55016003)(316002)(5660300002)(71200400001)(2906002)(66476007)(4326008)(66446008)(66556008)(76116006)(64756008)(478600001)(33656002)(38100700002)(82960400001)(186003)(86362001)(38070700005)(66946007)(122000001)(83380400001)(9686003)(26005)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0s1M09iRUtjZXl4UGtkN2o4OHZGSHdtVnY0U1RNcUdtcjFCQXZTaXpmQmtP?=
 =?utf-8?B?VDBRT2lVU25QbXRHamkvV0NVem51alh4ZXJXZHpwZ3VRczhTT0M0UGxDTVo0?=
 =?utf-8?B?YU9lSXdLQnk1WDhHNmJyb09DdEwwUWZndklvdVBRZGVKaWRCc0wwdVdrRG1n?=
 =?utf-8?B?eXlCbGp0SVZvdFJvTmtaRVZZSUVoNlQ4M24wRXZwZ3h6U2RHU21jL0kzTnZt?=
 =?utf-8?B?R0lqWGJkOGU1Y2dVWEVwTVlDZG16SVZncy8wU3Jpa2dhZEVzZTA5Vm5obHlh?=
 =?utf-8?B?OXVwaTRKQTlvczlOcHhwSVo1eWV1UXkwaTZGOUpGWVFSQVhqTGZ4NXJxeWV4?=
 =?utf-8?B?Q0JySkpzcDhNU1BLVm5NZlkvWEdOaDZPbHZoNGJzS01maUpTVFQvbFRzdVll?=
 =?utf-8?B?ZDVhOWs5aVZtaFZIR3BlQ3BNcktpOXErbEZEcVd0bU9vblFNUFdnbHIwOS9Z?=
 =?utf-8?B?cXBEMkRRRE5qU25meHF3ZzNFMTZIV0h4VkhsVlh6d1kvNVdscVR1RVcrL1Bm?=
 =?utf-8?B?RHZ4eTBmYkVUbUZ4NjNGaTBXMUNaNVY1QmNOMUpERUQyMThpamFxMFpESkty?=
 =?utf-8?B?VHNvcllLMmEyTWovU3QrSEtQbndnU2FqYXdZK0tQM0tJUjNhNTA5bGNRRHg2?=
 =?utf-8?B?WmRRMVpQQ25zS0dqY1YrZ3lZdlNxSy84MWw0aVBKb0pNTHNzSUI4OVl0L0ZP?=
 =?utf-8?B?cWdtQkYxM3VzUnowYm5Zb3h0WGMrK240RlU1RzAwN3M3YlJCbVB5TENRM2E3?=
 =?utf-8?B?TThZSlBXV0FLUkZ0Vm5ISDRvaHgvWkFlK3k4SytxRmVPc2drNkx6aWRGSi9v?=
 =?utf-8?B?SERJS21zdXJGVG85VVZzaHJRK1kyYVNhZW9WbklUWm4vV2x0c1R0Uk0vNDZH?=
 =?utf-8?B?eEZTL1ZHajFxRUxLMXNMaEFmRDYwcE9IWTNwTVZRakhFSU1ZMVN6eU1UZFVP?=
 =?utf-8?B?TTRaeTJEMDhOeUZHekZnZjFZYnBzSTlrMlMya25uZWhOMjhtMTJiSlZtWEJh?=
 =?utf-8?B?Qk1XaUF0RjF5Z0FTZmt4UUgrR1dOeUVTZFAwT3hhU1lyVHA3TVJvMHRBV2sy?=
 =?utf-8?B?TXc2ZG8xelUwOGxLRWVQWTlSYVQxcUNVVEtwYlBjNVVEL2VlcVFnallJUG1I?=
 =?utf-8?B?T1krOE9lMHA4NkZ0REFQWXZWWGQ1dHMxUjR6c2JLV1k3cmE0WHJvRzdIRFd5?=
 =?utf-8?B?KzJTRTRRc3IvT0hsaEFJZDI1bXFBRmJBMTVEQ1RYbUltNnkrL0U0M241cnZD?=
 =?utf-8?B?d1hseDJ2SVA3a0gwby9uTlRjVVhndGpPc29lU0prYTFKQUJTaVByV3pKQ2ta?=
 =?utf-8?B?MDM3aitGRXRmSXRWRXVOb1pxbGRzeWMwdStYVmh3V0RoTXh1K2dIdWh0eXNP?=
 =?utf-8?B?V0Z4N2VHOVVqZS9CS1lFQ3dLZHJhTTI1VlUxU21FTER6SWJtWFFUNUdrYmk3?=
 =?utf-8?B?ZW1qbFIra2cyWlZ1YU9Vc0s4M1hVOXFYZFplK3d5SjdlY1RxTVNlUkhlN2JO?=
 =?utf-8?B?ekwySmxFYnc3WWtRVFVCYWZLSTJSbUxLRFo0L2F5UUVxZVlMMnpnRUxMQk8v?=
 =?utf-8?B?Vm04Zm9XUEtNOWM0Y2pNL2R4SklTQ1lvUTZQWUd3THJsZDFzRjRsb3BOQmpu?=
 =?utf-8?B?dHM2OHVLOFUxdjRsd3JEMVIrTHRsUTdBcU10cENxTHROYkloclJuOThSancw?=
 =?utf-8?B?K052UCtiejgzUHp2VnZLVnBGUlJYWUFzR3VCYVRpeU5iQW1RK2dFWXVKajdt?=
 =?utf-8?B?bEREbXJxQmFWTGJtZmZFNldRUDZxblllQlladW12SmhMbkV6VUJEeGJhZEVy?=
 =?utf-8?B?MDVVc01IZmVscmJMb2NFeDM2NWhUOXh5L05CYTlxeGNvM0JPWWF4MWhjSFIx?=
 =?utf-8?B?RTNkN2d6ei9vNklEMFFBZWR2UnN1K1d6NlAwN09BZHg3Z003OFk1TURpdWhV?=
 =?utf-8?B?U0FGaDBTdjJRVU1iUnppY3RrRzdndDdSWWhOZkQ0YXNYL2Vsb0kwMGJJcjJT?=
 =?utf-8?B?UW4wMGdXRTNvclUva3kyNWR6MElNRFZiN3A2dmVORnRwSndUZCsvMUpad0d2?=
 =?utf-8?B?K3dBRExlRDh0L3pBRUgyY2hkdTN6dXhYT0I5ckRtUzVhZVdGT1BwSDlqalp0?=
 =?utf-8?Q?+Ui12fc4XAiHunuPRvP7azgcv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1ab9af-97c4-496c-59fe-08db7d2f5ed5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 08:11:01.0612 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLBZ0dBZHK5f565AcefamJVQWny9g5cpwdwTk5ZSG0VxhhetiXzO9R971Bhs+02eAGwjzkczK6/7aRQTB/yMOndUSQQYiWn+33AibpzpeQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4577
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.43;
 envelope-from=zhenzhong.duan@intel.com; helo=mga05.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVseSA1LCAyMDIzIDI6MjAgUE0NCj5T
dWJqZWN0OiBSZTogW1BBVENIIDEvMl0gdmlydGlvLWlvbW11OiBGaXggNjRrQiBob3N0IHBhZ2Ug
c2l6ZSBWRklPIGRldmljZQ0KPmFzc2lnbm1lbnQNCj4NCj5IaSBaaGVuemhvbmcsDQo+T24gNy81
LzIzIDA2OjUyLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiBIaSBFcmljLA0KPj4NCj4+PiAt
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+PiBTZW50OiBUdWVzZGF5LCBKdWx5IDQsIDIwMjMgNzoxNSBQTQ0K
Pj4+IFN1YmplY3Q6IFtQQVRDSCAxLzJdIHZpcnRpby1pb21tdTogRml4IDY0a0IgaG9zdCBwYWdl
IHNpemUgVkZJTyBkZXZpY2UNCj4+PiBhc3NpZ25tZW50DQo+Pj4NCj4+PiBXaGVuIHJ1bm5pbmcg
b24gYSA2NGtCIHBhZ2Ugc2l6ZSBob3N0IGFuZCBwcm90ZWN0aW5nIGEgVkZJTyBkZXZpY2UNCj4+
PiB3aXRoIHRoZSB2aXJ0aW8taW9tbXUsIHFlbXUgY3Jhc2hlcyB3aXRoIHRoaXMga2luZCBvZiBt
ZXNzYWdlOg0KPj4+DQo+Pj4gcWVtdS1rdm06IHZpcnRpby1pb21tdSBwYWdlIG1hc2sgMHhmZmZm
ZmZmZmZmZmZmMDAwIGlzIGluY29tcGF0aWJsZQ0KPj4+IHdpdGggbWFzayAweDIwMDEwMDAwDQo+
PiBEb2VzIDB4MjAwMTAwMDAgbWVhbiBvbmx5ICA1MTJNQiBhbmQgNjRLQiBzdXBlciBwYWdlIG1h
cHBpbmcgaXMNCj4+IHN1cHBvcnRlZCBmb3IgaG9zdCBpb21tdSBodz8gNEtCIG1hcHBpbmcgbm90
IHN1cHBvcnRlZD8NCj5ZZXMgdGhhdCdzIGNvcnJlY3QuIEluIHRoYXQgY2FzZSB0aGUgaG9zdCBo
YXMgNjRrQiBwYWdlIGFuZCA0a0IgaXMgbm90DQo+c3VwcG9ydGVkLg0KPj4NCj4+IFRoZXJlIGlz
IGEgY2hlY2sgaW4gZ3Vlc3Qga2VybmVsIHNpZGUgaGludCBvbmx5IDRLQiBpcyBzdXBwb3J0ZWQs
IHdpdGgNCj4+IHRoaXMgcGF0Y2ggd2UgZm9yY2UgdmlvbW11LT5wZ3NpemVfYml0bWFwIHRvIDB4
MjAwMTAwMDANCj4+IGFuZCBmYWlsIGJlbG93IGNoZWNrPyBEb2VzIHRoaXMgZGV2aWNlIHdvcmsg
aW4gZ3Vlc3Q/DQo+PiBQbGVhc2UgY29ycmVjdCBtZSBpZiBJIHVuZGVyc3RhbmQgd3JvbmcuDQo+
bXkgZ3Vlc3QgYWxzbyBoYXMgNjRrQiBzbyB0aGUgY2hlY2sgaGVyZWFmdGVyIHN1Y2NlZWRzLiBl
ZmZlY3RpdmVseSBpbg0KPmNhc2UgeW91ciBob3N0IGhhcyBhIGxhcmdlciBwYWdlIHNpemUgdGhh
biB5b3VyIGd1ZXN0IGl0IGZhaWxzIHdpdGgNCj5bwqDCoMKgIDIuMTQ3MDMxXSB2aXJ0aW8tcGNp
IDAwMDA6MDA6MDEuMDogZ3JhbnVsZSAweDEwMDAwIGxhcmdlciB0aGFuDQo+c3lzdGVtIHBhZ2Ug
c2l6ZSAweDEwMDANCj5bwqDCoMKgIDcuMjMxMTI4XSBpeGdiZXZmIDAwMDA6MDA6MDIuMDogZ3Jh
bnVsZSAweDEwMDAwIGxhcmdlciB0aGFuIHN5c3RlbQ0KPnBhZ2Ugc2l6ZSAweDEwMDANCg0KT2gs
IEkgc2VlLCBJIHRvb2sgUEFHRV9TSVpFIGFzIDRLQiBmb3IgZ3JhbnRlZC4NCg0KPg0KPj4NCj4+
IHN0YXRpYyBpbnQgdmlvbW11X2RvbWFpbl9maW5hbGlzZShzdHJ1Y3QgdmlvbW11X2VuZHBvaW50
ICp2ZGV2LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpb21t
dV9kb21haW4gKmRvbWFpbikNCj4+IHsNCj4+IC4uLg0KPj4gICAgICAgICB2aW9tbXVfcGFnZV9z
aXplID0gMVVMIDw8IF9fZmZzKHZpb21tdS0+cGdzaXplX2JpdG1hcCk7DQo+PiAgICAgICAgIGlm
ICh2aW9tbXVfcGFnZV9zaXplID4gUEFHRV9TSVpFKSB7DQo+PiAgICAgICAgICAgICAgICAgZGV2
X2Vycih2ZGV2LT5kZXYsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAiZ3JhbnVsZSAweCVs
eCBsYXJnZXIgdGhhbiBzeXN0ZW0gcGFnZSBzaXplIDB4JWx4XG4iLA0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICAgdmlvbW11X3BhZ2Vfc2l6ZSwgUEFHRV9TSVpFKTsNCj4+ICAgICAgICAgICAg
ICAgICByZXR1cm4gLUVOT0RFVjsNCj4+ICAgICAgICAgfQ0KPj4NCj4+IEFub3RoZXIgcXVlc3Rp
b24gaXM6IFByZXN1bWUgMHgyMDAxMDAwMCBkb2VzIG1lYW4gb25seSA1MTJNQiBhbmQgNjRLQg0K
Pj4gaXMgc3VwcG9ydGVkLiBJcyBob3N0IGh2YS0+aHBhIG1hcHBpbmcgZW5zdXJlZCB0byBiZSBj
b21wYXRpYmxlIHdpdGggYXQNCj5sZWFzdA0KPj4gNjRLQiBtYXBwaW5nPyBJZiBob3N0IG1tdSBv
bmx5IHN1cHBvcnQgNEtCIG1hcHBpbmcgb3Igb3RoZXIgbm9uLQ0KPmNvbXBhdGlibGUNCj4+IHdp
dGggMHgyMDAxMDAwMCwgd2lsbCB2ZmlvX2RtYV9tYXAoKSBmYWlsPw0KPnRoZSBwYWdlIHNpemUg
bWFzayBpcyByZXRyaWV2ZWQgd2l0aCBWRklPX0lPTU1VX0dFVF9JTkZPIHVhcGkNCj53aGljaCBy
ZXR1cm5zIGhvc3QgdmZpb19pb21tdV90eXBlMSB2ZmlvX2lvbW11LT5wZ3NpemVfYml0bWFwLiBU
aGlzDQo+bGF0dGVyIGlzIGluaXRpYWxpemVkIHRvIGhvc3QgUEFHRV9NQVNLIGFuZCBsYXRlciBy
ZXN0cmljdGVkIG9uDQo+dmZpb19pb21tdV90eXBlMV9hdHRhY2hfZ3JvdXAgdGhvdWdoIHRoZSB2
ZmlvX3VwZGF0ZV9wZ3NpemVfYml0bWFwKCkNCj5jYWxscw0KDQpVbmRlcnN0b29kLCB0aGFua3Mg
Zm9yIHlvdXIgYW5hbHlzaXMuDQoNCj4NCj5zbyB5ZXMgYm90aCBJT01NVSBhbmQgQ1BVIHBhZ2Ug
c2l6ZSBhcmUgZ2FyYW50ZWVkIHRvIGJlIGNvbXBhdGlibGUuDQo+DQo+Pg0KPj4+IHFlbXU6IGhh
cmR3YXJlIGVycm9yOiB2ZmlvOiBETUEgbWFwcGluZyBmYWlsZWQsIHVuYWJsZSB0byBjb250aW51
ZQ0KPj4+DQo+Pj4gVGhpcyBpcyBkdWUgdG8gdGhlIGZhY3QgdGhlIElPTU1VIE1SIGNvcnJlc3Bv
bmRpbmcgdG8gdGhlIFZGSU8gZGV2aWNlDQo+Pj4gaXMgZW5hYmxlZCB2ZXJ5IGxhdGUgb24gZG9t
YWluIGF0dGFjaCwgYWZ0ZXIgdGhlIG1hY2hpbmUgaW5pdC4NCj4+PiBUaGUgZGV2aWNlIHJlcG9y
dHMgYSBtaW5pbWFsIDY0a0IgcGFnZSBzaXplIGJ1dCBpdCBpcyB0b28gbGF0ZSB0byBiZQ0KPj4+
IGFwcGxpZWQuIHZpcnRpb19pb21tdV9zZXRfcGFnZV9zaXplX21hc2soKSBmYWlscyBhbmQgdGhp
cyBjYXVzZXMNCj4+PiB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9hZGQoKSB0byBlbmQgdXAgd2l0aCBo
d19lcnJvcigpOw0KPj4+DQo+Pj4gVG8gd29yayBhcm91bmQgdGhpcyBpc3N1ZSwgd2UgdHJhbnNp
ZW50bHkgZW5hYmxlIHRoZSBJT01NVSBNUiBvbg0KPj4+IG1hY2hpbmUgaW5pdCB0byBjb2xsZWN0
IHRoZSBwYWdlIHNpemUgcmVxdWlyZW1lbnRzIGFuZCB0aGVuIHJlc3RvcmUNCj4+PiB0aGUgYnlw
YXNzIHN0YXRlLg0KPj4+DQo+Pj4gRml4ZXM6IDkwNTE5YjkwNTMgKCJ2aXJ0aW8taW9tbXU6IEFk
ZCBieXBhc3MgbW9kZSBzdXBwb3J0IHRvIGFzc2lnbmVkDQo+Pj4gZGV2aWNlIikNCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+
Pj4gaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmggfCAgMiArKw0KPj4+IGh3L3ZpcnRp
by92aXJ0aW8taW9tbXUuYyAgICAgICAgIHwgMzAgKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tDQo+Pj4gaHcvdmlydGlvL3RyYWNlLWV2ZW50cyAgICAgICAgICAgfCAgMSArDQo+Pj4gMyBm
aWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5oIGIvaW5jbHVkZS9o
dy92aXJ0aW8vdmlydGlvLQ0KPj4+IGlvbW11LmgNCj4+PiBpbmRleCAyYWQ1ZWUzMjBiLi5hOTNm
YzUzODNlIDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5o
DQo+Pj4gKysrIGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLWlvbW11LmgNCj4+PiBAQCAtNjEs
NiArNjEsOCBAQCBzdHJ1Y3QgVmlydElPSU9NTVUgew0KPj4+ICAgICBRZW11UmVjTXV0ZXggbXV0
ZXg7DQo+Pj4gICAgIEdUcmVlICplbmRwb2ludHM7DQo+Pj4gICAgIGJvb2wgYm9vdF9ieXBhc3M7
DQo+Pj4gKyAgICBOb3RpZmllciBtYWNoaW5lX2RvbmU7DQo+Pj4gKyAgICBib29sIGdyYW51bGVf
ZnJvemVuOw0KPj4+IH07DQo+Pj4NCj4+PiAjZW5kaWYNCj4+PiBkaWZmIC0tZ2l0IGEvaHcvdmly
dGlvL3ZpcnRpby1pb21tdS5jIGIvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Pj4gaW5kZXgg
MWNkMjU4MTM1ZC4uMWVhZjgxYmFiNSAxMDA2NDQNCj4+PiAtLS0gYS9ody92aXJ0aW8vdmlydGlv
LWlvbW11LmMNCj4+PiArKysgYi9ody92aXJ0aW8vdmlydGlvLWlvbW11LmMNCj4+PiBAQCAtMjQs
NiArMjQsNyBAQA0KPj4+ICNpbmNsdWRlICJody92aXJ0aW8vdmlydGlvLmgiDQo+Pj4gI2luY2x1
ZGUgInN5c2VtdS9rdm0uaCINCj4+PiAjaW5jbHVkZSAic3lzZW11L3Jlc2V0LmgiDQo+Pj4gKyNp
bmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+Pj4gI2luY2x1ZGUgInFhcGkvZXJyb3IuaCINCj4+
PiAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4+PiAjaW5jbHVkZSAidHJhY2UuaCIN
Cj4+PiBAQCAtMTEwNiwxMiArMTEwNywxMiBAQCBzdGF0aWMgaW50DQo+Pj4gdmlydGlvX2lvbW11
X3NldF9wYWdlX3NpemVfbWFzayhJT01NVU1lbW9yeVJlZ2lvbiAqbXIsDQo+Pj4gICAgIH0NCj4+
Pg0KPj4+ICAgICAvKg0KPj4+IC0gICAgICogQWZ0ZXIgdGhlIG1hY2hpbmUgaXMgZmluYWxpemVk
LCB3ZSBjYW4ndCBjaGFuZ2UgdGhlIG1hc2sgYW55bW9yZS4gSWYNCj5ieQ0KPj4+ICsgICAgICog
T25jZSB0aGUgZ3JhbnVsZSBpcyBmcm96ZW4gd2UgY2FuJ3QgY2hhbmdlIHRoZSBtYXNrIGFueW1v
cmUuIElmIGJ5DQo+Pj4gICAgICAqIGNoYW5jZSB0aGUgaG90cGx1Z2dlZCBkZXZpY2Ugc3VwcG9y
dHMgdGhlIHNhbWUgZ3JhbnVsZSwgd2UgY2FuIHN0aWxsDQo+Pj4gICAgICAqIGFjY2VwdCBpdC4g
SGF2aW5nIGEgZGlmZmVyZW50IG1hc2tzIGlzIHBvc3NpYmxlIGJ1dCB0aGUgZ3Vlc3Qgd2lsbCB1
c2UNCj4+PiAgICAgICogc3ViLW9wdGltYWwgYmxvY2sgc2l6ZXMsIHNvIHdhcm4gYWJvdXQgaXQu
DQo+Pj4gICAgICAqLw0KPj4+IC0gICAgaWYgKHBoYXNlX2NoZWNrKFBIQVNFX01BQ0hJTkVfUkVB
RFkpKSB7DQo+Pj4gKyAgICBpZiAocy0+Z3JhbnVsZV9mcm96ZW4pIHsNCj4+PiAgICAgICAgIGlu
dCBuZXdfZ3JhbnVsZSA9IGN0ejY0KG5ld19tYXNrKTsNCj4+PiAgICAgICAgIGludCBjdXJfZ3Jh
bnVsZSA9IGN0ejY0KGN1cl9tYXNrKTsNCj4+Pg0KPj4+IEBAIC0xMTQ2LDYgKzExNDcsMjcgQEAg
c3RhdGljIHZvaWQgdmlydGlvX2lvbW11X3N5c3RlbV9yZXNldCh2b2lkDQo+Pj4gKm9wYXF1ZSkN
Cj4+Pg0KPj4+IH0NCj4+Pg0KPj4+ICtzdGF0aWMgdm9pZCB2aXJ0aW9faW9tbXVfZnJlZXplX2dy
YW51bGUoTm90aWZpZXIgKm5vdGlmaWVyLCB2b2lkICpkYXRhKQ0KPj4+ICt7DQo+Pj4gKyAgICBW
aXJ0SU9JT01NVSAqcyA9IGNvbnRhaW5lcl9vZihub3RpZmllciwgVmlydElPSU9NTVUsIG1hY2hp
bmVfZG9uZSk7DQo+Pj4gKyAgICBib29sIGJvb3RfYnlwYXNzID0gcy0+Y29uZmlnLmJ5cGFzczsN
Cj4+PiArICAgIGludCBncmFudWxlOw0KPj4+ICsNCj4+PiArICAgIC8qDQo+Pj4gKyAgICAgKiBU
cmFuc2llbnQgSU9NTVUgTVIgZW5hYmxlIHRvIGNvbGxlY3QgcGFnZV9zaXplX21hc2sgcmVxdWly
ZW1lbnQNCj4+PiArICAgICAqIHRocm91Z2ggbWVtb3J5X3JlZ2lvbl9pb21tdV9zZXRfcGFnZV9z
aXplX21hc2soKSBjYWxsZWQgYnkNCj4+PiArICAgICAqIFZGSU8gcmVnaW9uX2FkZCgpIGNhbGxi
YWNrDQo+Pj4gKyAgICAgKi8NCj4+PiArICAgIHMtPmNvbmZpZy5ieXBhc3MgPSAwOw0KPj4+ICsg
ICAgdmlydGlvX2lvbW11X3N3aXRjaF9hZGRyZXNzX3NwYWNlX2FsbChzKTsNCj4+PiArICAgIC8q
IHJlc3RvcmUgZGVmYXVsdCAqLw0KPj4+ICsgICAgcy0+Y29uZmlnLmJ5cGFzcyA9IGJvb3RfYnlw
YXNzOw0KPj4+ICsgICAgdmlydGlvX2lvbW11X3N3aXRjaF9hZGRyZXNzX3NwYWNlX2FsbChzKTsN
Cj4+PiArICAgIHMtPmdyYW51bGVfZnJvemVuID0gdHJ1ZTsNCj4+PiArICAgIGdyYW51bGUgPSBj
dHo2NChzLT5jb25maWcucGFnZV9zaXplX21hc2spOw0KPj4+ICsgICAgdHJhY2VfdmlydGlvX2lv
bW11X2ZyZWV6ZV9ncmFudWxlKEJJVChncmFudWxlKSk7DQo+Pj4gK30NCj4+IEl0IGxvb2tzIGEg
Yml0IGhlYXZ5IGhlcmUganVzdCBpbiBvcmRlciB0byBnZXQgcGFnZV9zaXplX21hc2sgZnJvbSBo
b3N0IHNpZGUuDQo+PiBCdXQgbWF5YmUgdGhpcyBpcyB0aGUgb25seSB3YXkgd2l0aCBjdXJyZW50
IGludGVyZmFjZS4NCj4NCj50aGUgcHJvYmxlbSBjb21lcyBmcm9tIHRoZSBmYWN0IHRoZSByZWdp
b25zIGFyZSBhbGlhc2VkIGR1ZSB0byB0aGUNCj5ieXBhc3MgYW5kIHZmaW9fbGlzdGVuZXJfcmVn
aW9uX2FkZCgpIGRvZXMgbm90IGdldCBhIGNoYW5jZSB0byBiZSBjYWxsZWQNCj51bnRpbCB0aGUg
YWN0dWFsIGRvbWFpbiBhdHRhY2guIFNvIEkgZG8gbm90IHNlZSBhbnkgb3RoZXIgd2F5IHRvDQo+
dHJhbnNpZW50bHkgZW5hYmxlIHRoZSByZWdpb24uDQpBZ3JlZS4NCg0KPg0KPkF0IGxlYXN0IEkg
Y291bGQgY2hlY2sgaWYgYm9vdCBieXBhc3MgaXMgc2V0IGJlZm9yZSBkb2luZyB0aGF0IGRhbmNl
LiBJDQo+d2lsbCByZXNwaW4gd2l0aCB0aGF0Lg0KTWFrZSBzZW5zZS4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

