Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 950EA7F0B54
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 05:17:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4vhV-0006GY-Oq; Sun, 19 Nov 2023 23:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r4vhR-0006GK-Kv
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:15:53 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r4vhO-0002DF-89
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 23:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700453750; x=1731989750;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HWbmBz5I74t+RxAU4ywMzrDt1xgd2SQL9nDuGirOThU=;
 b=WNs2jEM5DiGAQzYy/BionUPMJCyBu6HU0mKK+W/L93BsfseiUjkrlgxp
 NgSls9IheYpxofMW4J+6cNCQNqZhkZWJL4wIxK4zvsdRpzR6izhaqk7Sw
 WIHnPDarK7CLtYlXknpNQcy9suutda/E1tC7DUC8yXUkNTEfuirvnD5WY
 kdm/kg0try1fpRnq4Nfq+mriUYU4WfYhUi1Iud4Z0gYZho4aMNtz4m7iB
 H4/wK8OaNtQJFixqvpHa0GO+Ap8gI/v5YFnR3iNofrE5hUGsjriKKeLFB
 EHWPb71QigWpfCQbEpQgQtlfEcB6rJC48ywRpe6XLG141NM0+JtLwU8at g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394394034"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; d="scan'208";a="394394034"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2023 20:15:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="742609526"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; d="scan'208";a="742609526"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Nov 2023 20:15:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 20:15:33 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 20:15:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 20:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJriXABPxloX3CsArtjBVCWM20zKUT4RJRNhicnKUWdszqqzyiiJrDwMg83YEE0Pe/KheBHEJD3EXp3E4PPHi+WS4Lb+lCF87dYVs4kDZRamboeHJke7uZG6th/ZCFVHUD1R14wQBJXAhH5Noj7kBxOT1r22QaAwslUPcRdBM4t79HlzVeCcwjKArVmSvtWsWFbOdEL2EYzMRnZyZHgD0t9Sze/ZnkjJDS1NEgD4AgMwdSczApGIE2eF5ZqOlKPyxL/iISL+Cq5Qu1g7KCsG+JzljZmKRPPJWUQC/0SMuuFE/wZ/1j3lsg1Z4A5vGNfl8RGKbG6tQrgBsUqL0klAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWbmBz5I74t+RxAU4ywMzrDt1xgd2SQL9nDuGirOThU=;
 b=CfAkof2V/FkN0JIYutA9LHQFc0n83WOPLvL+nWKH7vR3u5Qhxkbl3ksrbz+RgllhbjUEP9lBEEA79PUEEHFdzWDyHRJ6T8dmdbrfMYP7nA/V8Sb81iQsT5k6M9hmnxdPYW8iOtBd+1o1bsUgOHjI7bQqoGIuvLGSg28/KsGuk4BjCvE+N+6gVufOTlRRgrZnXw5zxqQsGExoM1MShq2VKdeQjVAO1Mg8pdbGfQ4ybumd1TgyBRxxZrPf5cYBfS4y9nIaIcN8MRLCGQDMtPT79kG6iw7NrhNT0x1/9tHc1gkuE/rm0vXM6I9gKrlWGbci0ndB7Jj6F/DBPiNwiPJxOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 04:15:24 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 04:15:24 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 09/21] vfio/iommufd: Enable pci hot reset through
 iommufd cdev interface
Thread-Topic: [PATCH v6 09/21] vfio/iommufd: Enable pci hot reset through
 iommufd cdev interface
Thread-Index: AQHaFuT9CM6pB5JADUin3kcOeg8rS7B+jTIAgAQVJ5A=
Date: Mon, 20 Nov 2023 04:15:23 +0000
Message-ID: <SJ0PR11MB6744955F44EB29497380A5BA92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-10-zhenzhong.duan@intel.com>
 <cbc7ab3f-bffb-4626-bc64-3c258dc610ec@redhat.com>
In-Reply-To: <cbc7ab3f-bffb-4626-bc64-3c258dc610ec@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB6239:EE_
x-ms-office365-filtering-correlation-id: c8826493-8135-4172-c513-08dbe97f5166
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NEa6ID8be6b30+zrsag9TdGWCPbITJuQhy1jI49KM4wXKwSo01u5P5KFSBlfLqX4uuG8cFQ+DmuTHI9u6+kKKByL5pS0GjOf6iMb4P3PA4UXc1uAHhIiOFoKI5zw5DK7GgKzsTAoCMgoX4cDTL0m4QSw/+hX853AoGbAShY6Q+Ao776VbA+QHL34a+ZP6Gzb7YR8i6YRWsEACJ/+rlZSrB5QcqgR2VeCMOXjxNmv+GWIawNEdOPG5Jth46LjAeDkK1V241d7Ex2Jt8JQGhl+Nqy4UrCeGooRqkGnnw+HX+Yf3myeXI6KGmEpOelDu6lB0eCf0i78ijq+wcOplzIqpqoRDrYWOa0WOPhiG07dDLz0DYopib+VDvLVr7OYRJ1cXuIji/zbgQUspcd/RXvfTrSoVvlRpeWWvdt+9557ceo0siNdg7SYYMDX26QzGpUab9XYI2a0zXYReiBUvakJpZr3bGCk60eFS+PvwRxaeO5Y6/Ll1Xle812kFsgODsqha7Z/Gt4R//0FQjaOCtzSdoVrQJc4yoNf1ikdPPU+D5tgGMAFxpabBPLWbapGW0C01fttK/Uw9gXHDPZ24/6Fi6qeQf5M899KIwAHaRYDfVUZeS+2pyK7oFfFVPgwL9wL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82960400001)(86362001)(38100700002)(122000001)(38070700009)(33656002)(110136005)(316002)(54906003)(64756008)(76116006)(66946007)(66556008)(66476007)(66446008)(26005)(55016003)(107886003)(478600001)(9686003)(71200400001)(6506007)(7696005)(5660300002)(2906002)(4326008)(8676002)(41300700001)(8936002)(52536014)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnFFb2VvSXFDY1ZERDVFYkJJc2hPSXllV2VYZXVOcW5NQmpMSWFLYzdxN09O?=
 =?utf-8?B?ems0ZjVOVkFITlpvWkRGdXdoeHJJQlFScEVwRDVta3hVT0YvTGpldThLZ1hL?=
 =?utf-8?B?SGdSOFlQRm45ZWZJYysyclpZV3pydHVoNEpwM2czTjM3NzlmYlZtODVVZzBS?=
 =?utf-8?B?dGFzRnhnQlptSitxUGVqRmVtQkdSdFYwcFI3bFVHbkgrajY0TnlUWGo1cUpu?=
 =?utf-8?B?cjhrWWIvMWxUOUZwTFJDQmtTMnBWSlE3UWhYVXozdjlPazFoTlVaODRkN1pU?=
 =?utf-8?B?b1A3Y2FPRExZZHBRNmdhNWxXSVZBRnRUcnRZajNuVGhoZUN1clFRWkZxMklR?=
 =?utf-8?B?aHFMa0VoSXhLbGVxWVZKaVhCZ0lBWVhhQjllamxTRkNrZ0dHTDg2Q1RQVWlO?=
 =?utf-8?B?WG9jSUJiMTJ6eVJIQmFsR2ppeEtkZmNxY0xPSE8rT2lDanNITnlpa1ZWL2hS?=
 =?utf-8?B?ZHl4cjRCQXdCVHdEYUdYQnZHcHljZXcyLzdadEZEV0puY2d3Q2Jmb3dKbmlr?=
 =?utf-8?B?ekI5WFNUWU1kcU9ySEJlVmxCTkpIREIzM0xaZ0JCd00wR29rWi9KZ3QzTGlN?=
 =?utf-8?B?REpXV2J0dHFsTG54QzQ1VjRablkwTEg4ZXhWdVN4Z3JVOE5lWE5lS3hFY21v?=
 =?utf-8?B?VU56Z0NRcDFnNThCcTU0akdWbVFpMFdEem9DM203WmxoamxyN255T3pJa3Bz?=
 =?utf-8?B?dUNlenJvQVk2Q1R6NWhCRDhabjVCbW15Zk1XYk0vN3V0STdjN0RtTCtEa1Rv?=
 =?utf-8?B?V3RXNUs2TGVwOHBueHBMTFBJTnB3Sk5ad0xMTm5EdGFzbGFUeFVkTFU5NGVq?=
 =?utf-8?B?R3VmK1hhNUJ2ZFBXblM3WW5vQmlVOTJuOWd6YjA2RkZQWHVITHV6SkF3NG4y?=
 =?utf-8?B?KzEyT2JZbVBUSXVwOGdsVW9TakdPazc5Z29wQTgwS1cwTGpGZW52SzNPYUNq?=
 =?utf-8?B?WTRSeEtGRXYzdEVXMHJITmN3ZmJlWWRJRzVPVWo5amFkMHlTNTd0NVA3ZjB6?=
 =?utf-8?B?Q1JUL0FSWnlVYzJ2Y2U2cFdaVVdEU2FVVlloYWh6S0xlam1XRGFrdGlIaEJi?=
 =?utf-8?B?OVlkRlVjZkRTdVFlOWlTYjNZZTRSYm9LUmI1THY2Nm5WSzRqRTQzZWJYYzhw?=
 =?utf-8?B?VkdXWWRFUTZ5bDVqKzN3b21TcUMzV010dm9TdmxKVWNYWS9vTERaa1hETFgx?=
 =?utf-8?B?Yk9DZTN1WGo4STh2cUpZdjZaeEF0bjNTLzJiTkdMbmdsTkxpZzBlME9Zem9r?=
 =?utf-8?B?UzN5bmYwSFhmTFBjRTM1MGorZXB4a1NkTTZLcmg2UVBKLzRNYXg3N3hidEFw?=
 =?utf-8?B?NTVDTXAwUzQ2bXkrc2hjNjJONy9FekFLQVZvQ1ZFS1ZMV1kyN3ZBdTh5N1F3?=
 =?utf-8?B?c0RETkNWRXlBT0FBaHYzN3BLY1BVUlh5ZWNoMHJDcEY2akFmVHlEeXlwUVVz?=
 =?utf-8?B?MGR1Vno2cnE3czR5TUM2WTB2U0JVd0NveGRmSzVlNE0rZzJEaE4xcWFCKzF4?=
 =?utf-8?B?WkJTeGlPUXpJc0szYTkrYTUvUVJXMGFwMGJONVVSY3Q0aHlCV0l3U2dPcDkw?=
 =?utf-8?B?RkhjYmNTYzMrTVUzY2JPaDRndEo2NFEycklNL05rMUNkRkdnMDJva0N5bVVj?=
 =?utf-8?B?eFl0QWNBMWFGMEc4OVNtaTNMSHZuY2plVzFUUWVwMmFQZEFHanY1RVZFZzVw?=
 =?utf-8?B?WFJyTldwRS9sUS9wNUkzcVNPUmNJemxKZnYyRGlCdEcvem4rUERNV2VUNitK?=
 =?utf-8?B?ZTdQcG5lMGtZNFdDb2VNaDgrUXgzYkF0czlzRklqMjM0Qks2S0dJd1VxOHl1?=
 =?utf-8?B?ZFl1bGs2L0owTW1rRy9oQTRHQ01yTWVLbUNJakp3eTRvcFN6NGpNdDFxeWdq?=
 =?utf-8?B?Rks1L250clV4UnFsdnk1aU9kUGxkZkh6b1cyaXhaeTJuVnRlWGF0SU15dng2?=
 =?utf-8?B?bWM2a0p5RGdDL0xxb2dkSnNFKzVKZ1h3RHAzdmJPTVNvR0RmRnltOGNYZTJ3?=
 =?utf-8?B?enVTVnJTRnhuWU5XZE1oT01uWVlTS0hTNGZNNi9kTmxhdUxBUGNzNjEvdWJj?=
 =?utf-8?B?SHZVb1JPVzM1ZUd6cGk3ano3NlZNRS9YYnBzTHFjQk5HYXlwYTBmYTZneURt?=
 =?utf-8?Q?JwlM2sOjA6jtXJvoh3iqh9mlo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8826493-8135-4172-c513-08dbe97f5166
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 04:15:23.8404 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XG65+8770B0mwHsEMiJzwaSEipGzgUBzfNt3bUQgZKdk1o1ykvEqxQqRMbMz27cAdDu/gFMW6k2x+yrdwJVt3n52/QPxCGlP95XWvFdDYfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6239
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDE3LCAyMDIzIDk6NTQg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDA5LzIxXSB2ZmlvL2lvbW11ZmQ6IEVuYWJsZSBw
Y2kgaG90IHJlc2V0IHRocm91Z2gNCj5pb21tdWZkIGNkZXYgaW50ZXJmYWNlDQo+DQo+DQo+DQo+
T24gMTEvMTQvMjMgMTE6MDksIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gQWRkIGEgbmV3IGNh
bGxiYWNrIGlvbW11ZmRfY2Rldl9wY2lfaG90X3Jlc2V0IHRvIGRvIGlvbW11ZmQgc3BlY2lmaWMN
Cj4+IGNoZWNrIGFuZCByZXNldCBvcGVyYXRpb24uDQo+DQo+bml0OiBJbXBsZW1lbnQgdGhlIG5l
d2x5IGludHJvZHVjZWQgcGNpX2hvdF9yZXNldCBjYWxsYmFjaz8NCg0KWWVzDQoNCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gLS0tDQo+PiB2NjogcGNpX2hvdF9yZXNldCByZXR1cm4gLWVycm5vIGlmIGZhaWxzDQo+Pg0K
Pj4gIGh3L3ZmaW8vaW9tbXVmZC5jICAgIHwgMTQ1DQo+KysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4gIGh3L3ZmaW8vdHJhY2UtZXZlbnRzIHwgICAxICsNCj4+
ICAyIGZpbGVzIGNoYW5nZWQsIDE0NiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IGluZGV4IGU1YmY1Mjhl
ODkuLjNlZWM0MjgxNjIgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPj4gKysr
IGIvaHcvdmZpby9pb21tdWZkLmMNCj4+IEBAIC0yNCw2ICsyNCw3IEBADQo+PiAgI2luY2x1ZGUg
InN5c2VtdS9yZXNldC5oIg0KPj4gICNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPj4gICNpbmNs
dWRlICJxZW11L2NoYXJkZXZfb3Blbi5oIg0KPj4gKyNpbmNsdWRlICJwY2kuaCINCj4+DQo+PiAg
c3RhdGljIGludCBpb21tdWZkX2NkZXZfbWFwKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVy
LCBod2FkZHIgaW92YSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2FkZHJf
dCBzaXplLCB2b2lkICp2YWRkciwgYm9vbCByZWFkb25seSkNCj4+IEBAIC00NzMsOSArNDc0LDE1
MyBAQCBzdGF0aWMgdm9pZCBpb21tdWZkX2NkZXZfZGV0YWNoKFZGSU9EZXZpY2UNCj4qdmJhc2Vk
ZXYpDQo+PiAgICAgIGNsb3NlKHZiYXNlZGV2LT5mZCk7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0aWMg
VkZJT0RldmljZSAqaW9tbXVmZF9jZGV2X3BjaV9maW5kX2J5X2RldmlkKF9fdTMyIGRldmlkKQ0K
Pj4gK3sNCj4+ICsgICAgVkZJT0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+ICsNCj4+ICsgICAg
UUxJU1RfRk9SRUFDSCh2YmFzZWRldl9pdGVyLCAmdmZpb19kZXZpY2VfbGlzdCwgZ2xvYmFsX25l
eHQpIHsNCj4+ICsgICAgICAgIGlmICh2YmFzZWRldl9pdGVyLT5iY29udGFpbmVyLT5vcHMgIT0g
JnZmaW9faW9tbXVmZF9vcHMpIHsNCj4+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAg
ICAgIH0NCj4+ICsgICAgICAgIGlmIChkZXZpZCA9PSB2YmFzZWRldl9pdGVyLT5kZXZpZCkgew0K
Pj4gKyAgICAgICAgICAgIHJldHVybiB2YmFzZWRldl9pdGVyOw0KPj4gKyAgICAgICAgfQ0KPj4g
KyAgICB9DQo+PiArICAgIHJldHVybiBOVUxMOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50
IGlvbW11ZmRfY2Rldl9wY2lfaG90X3Jlc2V0KFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBib29sIHNp
bmdsZSkNCj4+ICt7DQo+PiArICAgIFZGSU9QQ0lEZXZpY2UgKnZkZXYgPSBjb250YWluZXJfb2Yo
dmJhc2VkZXYsIFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2KTsNCj4+ICsgICAgc3RydWN0IHZmaW9f
cGNpX2hvdF9yZXNldF9pbmZvICppbmZvID0gTlVMTDsNCj4+ICsgICAgc3RydWN0IHZmaW9fcGNp
X2RlcGVuZGVudF9kZXZpY2UgKmRldmljZXM7DQo+PiArICAgIHN0cnVjdCB2ZmlvX3BjaV9ob3Rf
cmVzZXQgKnJlc2V0Ow0KPj4gKyAgICBpbnQgcmV0LCBpOw0KPj4gKyAgICBib29sIG11bHRpID0g
ZmFsc2U7DQo+PiArDQo+PiArICAgIHRyYWNlX3ZmaW9fcGNpX2hvdF9yZXNldCh2ZGV2LT52YmFz
ZWRldi5uYW1lLCBzaW5nbGUgPyAib25lIiA6ICJtdWx0aSIpOw0KPj4gKw0KPj4gKyAgICBpZiAo
IXNpbmdsZSkgew0KPj4gKyAgICAgICAgdmZpb19wY2lfcHJlX3Jlc2V0KHZkZXYpOw0KPj4gKyAg
ICB9DQo+PiArICAgIHZkZXYtPnZiYXNlZGV2Lm5lZWRzX3Jlc2V0ID0gZmFsc2U7DQo+PiArDQo+
PiArICAgIHJldCA9IHZmaW9fcGNpX2dldF9wY2lfaG90X3Jlc2V0X2luZm8odmRldiwgJmluZm8p
Ow0KPj4gKw0KPj4gKyAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICBnb3RvIG91dF9zaW5nbGU7
DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgYXNzZXJ0KGluZm8tPmZsYWdzICYgVkZJT19QQ0lf
SE9UX1JFU0VUX0ZMQUdfREVWX0lEKTsNCj4+ICsNCj4+ICsgICAgZGV2aWNlcyA9ICZpbmZvLT5k
ZXZpY2VzWzBdOw0KPj4gKw0KPj4gKyAgICBpZiAoIShpbmZvLT5mbGFncyAmIFZGSU9fUENJX0hP
VF9SRVNFVF9GTEFHX0RFVl9JRF9PV05FRCkpIHsNCj4+ICsgICAgICAgIGlmICghdmRldi0+aGFz
X3BtX3Jlc2V0KSB7DQo+PiArICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGluZm8tPmNvdW50
OyBpKyspIHsNCj4+ICsgICAgICAgICAgICAgICAgaWYgKGRldmljZXNbaV0uZGV2aWQgPT0gVkZJ
T19QQ0lfREVWSURfTk9UX09XTkVEKSB7DQo+PiArICAgICAgICAgICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoInZmaW86IENhbm5vdCByZXNldCBkZXZpY2UgJXMsICINCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAiZGVwZW5kcyBvbiBkZXZpY2UgJTA0eDolMDJ4OiUwMnguJXgg
Ig0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ3aGljaCBpcyBub3Qgb3du
ZWQuIiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2ZGV2LT52YmFzZWRl
di5uYW1lLCBkZXZpY2VzW2ldLnNlZ21lbnQsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgZGV2aWNlc1tpXS5idXMsIFBDSV9TTE9UKGRldmljZXNbaV0uZGV2Zm4pLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBDSV9GVU5DKGRldmljZXNbaV0uZGV2
Zm4pKTsNCj4+ICsgICAgICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsgICAg
ICAgIH0NCj4+ICsgICAgICAgIHJldCA9IC1FUEVSTTsNCj4+ICsgICAgICAgIGdvdG8gb3V0X3Np
bmdsZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICB0cmFjZV92ZmlvX3BjaV9ob3RfcmVzZXRf
aGFzX2RlcF9kZXZpY2VzKHZkZXYtPnZiYXNlZGV2Lm5hbWUpOw0KPj4gKw0KPj4gKyAgICBmb3Ig
KGkgPSAwOyBpIDwgaW5mby0+Y291bnQ7IGkrKykgew0KPj4gKyAgICAgICAgVkZJT1BDSURldmlj
ZSAqdG1wOw0KPj4gKyAgICAgICAgVkZJT0RldmljZSAqdmJhc2VkZXZfaXRlcjsNCj4+ICsNCj4+
ICsgICAgICAgIHRyYWNlX2lvbW11ZmRfY2Rldl9wY2lfaG90X3Jlc2V0X2RlcF9kZXZpY2VzKGRl
dmljZXNbaV0uc2VnbWVudCwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGRldmljZXNbaV0uYnVzLA0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUENJX1NMT1QoZGV2aWNlc1tpXS5k
ZXZmbiksDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBQQ0lfRlVOQyhkZXZpY2VzW2ldLmRldmZuKSwNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldmljZXNbaV0uZGV2aWQpOw0K
Pj4gKw0KPj4gKyAgICAgICAgLyoNCj4+ICsgICAgICAgICAqIElmIGEgVkZJTyBjZGV2IGRldmlj
ZSBpcyByZXNldHRhYmxlLCBhbGwgdGhlIGRlcGVuZGVudCBkZXZpY2VzDQo+PiArICAgICAgICAg
KiBhcmUgZWl0aGVyIGJvdW5kIHRvIHNhbWUgaW9tbXVmZCBvciB3aXRoaW4gc2FtZSBpb21tdV9n
cm91cHMgYXMNCj4+ICsgICAgICAgICAqIG9uZSBvZiB0aGUgaW9tbXVmZCBib3VuZCBkZXZpY2Vz
Lg0KPj4gKyAgICAgICAgICovDQo+PiArICAgICAgICBhc3NlcnQoZGV2aWNlc1tpXS5kZXZpZCAh
PSBWRklPX1BDSV9ERVZJRF9OT1RfT1dORUQpOw0KPj4gKw0KPj4gKyAgICAgICAgaWYgKGRldmlj
ZXNbaV0uZGV2aWQgPT0gdmRldi0+dmJhc2VkZXYuZGV2aWQgfHwNCj4+ICsgICAgICAgICAgICBk
ZXZpY2VzW2ldLmRldmlkID09IFZGSU9fUENJX0RFVklEX09XTkVEKSB7DQo+PiArICAgICAgICAg
ICAgY29udGludWU7DQo+PiArICAgICAgICB9DQo+PiArDQo+PiArICAgICAgICB2YmFzZWRldl9p
dGVyID0gaW9tbXVmZF9jZGV2X3BjaV9maW5kX2J5X2RldmlkKGRldmljZXNbaV0uZGV2aWQpOw0K
Pj4gKyAgICAgICAgaWYgKCF2YmFzZWRldl9pdGVyIHx8ICF2YmFzZWRldl9pdGVyLT5kZXYtPnJl
YWxpemVkIHx8DQo+PiArICAgICAgICAgICAgdmJhc2VkZXZfaXRlci0+dHlwZSAhPSBWRklPX0RF
VklDRV9UWVBFX1BDSSkgew0KPj4gKyAgICAgICAgICAgIGNvbnRpbnVlOw0KPj4gKyAgICAgICAg
fQ0KPj4gKyAgICAgICAgdG1wID0gY29udGFpbmVyX29mKHZiYXNlZGV2X2l0ZXIsIFZGSU9QQ0lE
ZXZpY2UsIHZiYXNlZGV2KTsNCj4+ICsgICAgICAgIGlmIChzaW5nbGUpIHsNCj4+ICsgICAgICAg
ICAgICByZXQgPSAtRUlOVkFMOw0KPj4gKyAgICAgICAgICAgIGdvdG8gb3V0X3NpbmdsZTsNCj4+
ICsgICAgICAgIH0NCj4+ICsgICAgICAgIHZmaW9fcGNpX3ByZV9yZXNldCh0bXApOw0KPj4gKyAg
ICAgICAgdG1wLT52YmFzZWRldi5uZWVkc19yZXNldCA9IGZhbHNlOw0KPj4gKyAgICAgICAgbXVs
dGkgPSB0cnVlOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlmICghc2luZ2xlICYmICFtdWx0
aSkgew0KPj4gKyAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4+ICsgICAgICAgIGdvdG8gb3V0X3Np
bmdsZTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICAvKiBVc2UgemVybyBsZW5ndGggYXJyYXkg
Zm9yIGhvdCByZXNldCB3aXRoIGlvbW11ZmQgYmFja2VuZCAqLw0KPj4gKyAgICByZXNldCA9IGdf
bWFsbG9jMChzaXplb2YoKnJlc2V0KSk7DQo+PiArICAgIHJlc2V0LT5hcmdzeiA9IHNpemVvZigq
cmVzZXQpOw0KPj4gKw0KPj4gKyAgICAgLyogQnVzIHJlc2V0ISAqLw0KPj4gKyAgICByZXQgPSBp
b2N0bCh2ZGV2LT52YmFzZWRldi5mZCwgVkZJT19ERVZJQ0VfUENJX0hPVF9SRVNFVCwgcmVzZXQp
Ow0KPj4gKyAgICBnX2ZyZWUocmVzZXQpOw0KPj4gKyAgICBpZiAocmV0KSB7DQo+PiArICAgICAg
ICByZXQgPSAtZXJybm87DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgdHJhY2VfdmZpb19wY2lf
aG90X3Jlc2V0X3Jlc3VsdCh2ZGV2LT52YmFzZWRldi5uYW1lLA0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHJldCA/IHN0cmVycm9yKGVycm5vKSA6ICJTdWNjZXNzIik7
DQo+PiArDQo+PiArICAgIC8qIFJlLWVuYWJsZSBJTlR4IG9uIGFmZmVjdGVkIGRldmljZXMgKi8N
Cj4+ICsgICAgZm9yIChpID0gMDsgaSA8IGluZm8tPmNvdW50OyBpKyspIHsNCj4+ICsgICAgICAg
IFZGSU9QQ0lEZXZpY2UgKnRtcDsNCj4+ICsgICAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2X2l0
ZXI7DQo+PiArDQo+PiArICAgICAgICBpZiAoZGV2aWNlc1tpXS5kZXZpZCA9PSB2ZGV2LT52YmFz
ZWRldi5kZXZpZCB8fA0KPj4gKyAgICAgICAgICAgIGRldmljZXNbaV0uZGV2aWQgPT0gVkZJT19Q
Q0lfREVWSURfT1dORUQpIHsNCj4+ICsgICAgICAgICAgICBjb250aW51ZTsNCj4+ICsgICAgICAg
IH0NCj4+ICsNCj4+ICsgICAgICAgIHZiYXNlZGV2X2l0ZXIgPSBpb21tdWZkX2NkZXZfcGNpX2Zp
bmRfYnlfZGV2aWQoZGV2aWNlc1tpXS5kZXZpZCk7DQo+PiArICAgICAgICBpZiAoIXZiYXNlZGV2
X2l0ZXIgfHwgIXZiYXNlZGV2X2l0ZXItPmRldi0+cmVhbGl6ZWQgfHwNCj4+ICsgICAgICAgICAg
ICB2YmFzZWRldl9pdGVyLT50eXBlICE9IFZGSU9fREVWSUNFX1RZUEVfUENJKSB7DQo+PiArICAg
ICAgICAgICAgY29udGludWU7DQo+PiArICAgICAgICB9DQo+PiArICAgICAgICB0bXAgPSBjb250
YWluZXJfb2YodmJhc2VkZXZfaXRlciwgVkZJT1BDSURldmljZSwgdmJhc2VkZXYpOw0KPm5pdDog
SSBzZWUgdGhpcyBibG9jayBvZiBjb2RlIGFsc28gaXMgdXNlZCBhYm92ZSBmb3IgdGhlIHByZV9y
ZXNldC4gTWF5DQo+YmUgaW50ZXJlc3RpbmcgdG8gaW50cm9kdWNlIGFuIGhlbHBlcj8gQ291bGQg
YmUgZG9uZSBsYXRlciB0aG91Z2gNCg0KV2lsbCBkbyBpbiB2Ny4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg0KPj4gKyAgICAgICAgdmZpb19wY2lfcG9zdF9yZXNldCh0bXApOw0KPj4gKyAgICB9DQo+
PiArb3V0X3NpbmdsZToNCj4+ICsgICAgaWYgKCFzaW5nbGUpIHsNCj4+ICsgICAgICAgIHZmaW9f
cGNpX3Bvc3RfcmVzZXQodmRldik7DQo+PiArICAgIH0NCj4+ICsgICAgZ19mcmVlKGluZm8pOw0K
Pj4gKw0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPj4gK30NCj4+ICsNCj4+ICBjb25zdCBWRklPSU9N
TVVPcHMgdmZpb19pb21tdWZkX29wcyA9IHsNCj4+ICAgICAgLmRtYV9tYXAgPSBpb21tdWZkX2Nk
ZXZfbWFwLA0KPj4gICAgICAuZG1hX3VubWFwID0gaW9tbXVmZF9jZGV2X3VubWFwLA0KPj4gICAg
ICAuYXR0YWNoX2RldmljZSA9IGlvbW11ZmRfY2Rldl9hdHRhY2gsDQo+PiAgICAgIC5kZXRhY2hf
ZGV2aWNlID0gaW9tbXVmZF9jZGV2X2RldGFjaCwNCj4+ICsgICAgLnBjaV9ob3RfcmVzZXQgPSBp
b21tdWZkX2NkZXZfcGNpX2hvdF9yZXNldCwNCj4+ICB9Ow0KPj4gZGlmZiAtLWdpdCBhL2h3L3Zm
aW8vdHJhY2UtZXZlbnRzIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4+IGluZGV4IDVkM2U5ZThj
ZWUuLmQ4MzgyMzJkNWEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL3RyYWNlLWV2ZW50cw0KPj4g
KysrIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4+IEBAIC0xNzQsMyArMTc0LDQgQEAgaW9tbXVm
ZF9jZGV2X2RldGFjaF9pb2FzX2h3cHQoaW50IGlvbW11ZmQsIGNvbnN0DQo+Y2hhciAqbmFtZSwg
Y29uc3QgY2hhciAqc3RyLCBpbg0KPj4gIGlvbW11ZmRfY2Rldl9mYWlsX2F0dGFjaF9leGlzdGlu
Z19jb250YWluZXIoY29uc3QgY2hhciAqbXNnKSAiICVzIg0KPj4gIGlvbW11ZmRfY2Rldl9hbGxv
Y19pb2FzKGludCBpb21tdWZkLCBpbnQgaW9hc19pZCkgIiBbaW9tbXVmZD0lZF0gbmV3DQo+SU9N
TVVGRCBjb250YWluZXIgd2l0aCBpb2FzaWQ9JWQiDQo+PiAgaW9tbXVmZF9jZGV2X2RldmljZV9p
bmZvKGNoYXIgKm5hbWUsIGludCBkZXZmZCwgaW50IG51bV9pcnFzLCBpbnQNCj5udW1fcmVnaW9u
cywgaW50IGZsYWdzKSAiICVzICglZCkgbnVtX2lycXM9JWQgbnVtX3JlZ2lvbnM9JWQgZmxhZ3M9
JWQiDQo+PiAraW9tbXVmZF9jZGV2X3BjaV9ob3RfcmVzZXRfZGVwX2RldmljZXMoaW50IGRvbWFp
biwgaW50IGJ1cywgaW50IHNsb3QsIGludA0KPmZ1bmN0aW9uLCBpbnQgZGV2X2lkKSAiXHQlMDR4
OiUwMng6JTAyeC4leCBkZXZpZCAlZCINCj5PdGhlcndpc2UgbG9va3MgZ29vZCB0byBtZS4NCj4N
Cj5SZXZpZXdlZC1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPg0KPg0K
PkVyaWMNCj4NCj4NCg0K

