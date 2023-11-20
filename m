Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8297E7F0AC9
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 04:07:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4ucD-0000q6-9t; Sun, 19 Nov 2023 22:06:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r4ucA-0000pd-Me
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 22:06:22 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r4uc7-0006Fm-NP
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 22:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700449579; x=1731985579;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nO+AV8QSvvFKwLpAZ86EkT2KTM3rwo9i5THIhpVVLys=;
 b=j7NPFcG4Yz/JAlDhooy8/sMGf8Iqkm8o3JhFHQWIDJw+idpnkq5xyJ+1
 JIian2c3KigwV2mahjmexr0+6dy/lCz38cNw3vJXd1pm+ztltxgXIoP86
 g/NL8zMo/rduLFON/wTliVkYOYNhlMeEgxtblkQPN83m4MqgZS9NOfso7
 hoSY4VkzEB5NiaY8WYZ2e0/+vkrpbyMh4MTL7XygrGpTT0X7+Ufd/MzDd
 l1xMDBG2yfSnJgCt61CHnoJxzXu2in0/LsWbtMyruHGUu+ejk0kVN8aDm
 zuP/MPe4b8GgklZcXhWJNh5Llu4NyL5WNp1xFBMVyv+Sr5PZOgFELP1y6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="390400319"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; d="scan'208";a="390400319"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2023 19:06:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="7421950"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Nov 2023 19:06:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:06:14 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 19:06:14 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 19:06:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am4ZMexwEXwTZtaY3FE3DAfRfZxoH8wnxTKpRnmpLIQQlnPaABybwLOqGEnuUUej56ccdfaZJc/R+pZDJ7r/e55J/InYkYfdaq6I/Qs6XAFRKhkYExANRa9iFL5HFLIW9qPv2ZSxnJpNXlBHIraAXOoA0jKUbN/fINjC1X7yXDKNTdsejjHgabvpKtPmy0/0ibSd/H5Mcx8QuCsbs77x43AHynYALHl7NorahzQU+BNkMCcu5Hnkwg9LN7JQvFF8YB+KHZsmb53qNC4xvPaAit1v2l5lzTOKqI+1kUF0DGrzsDV03ziIsm3nrGSQoa9+r2pmcvBkAlqzgtO0IR0ypg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nO+AV8QSvvFKwLpAZ86EkT2KTM3rwo9i5THIhpVVLys=;
 b=TC1xcztt3h0joEH+tjg/4jYkrn72l++7HFFw7HQoLG8xiO+YACHC3MU20m5Qw09GcDmI2OY54l6S9OKHXHMlnmjItv8LVazJD/coX4BGm8Pf6+hy9EBO+0bDcS7pNo5LLwMHoblZBCR+b73WCIA4ixKLtEd/Sxv7Tb64UQr9Kx4M1y1KVM+NQo41Qi5hjoyvMBDQ1PMN78KMvMWZDF8sXS1Ub8VGlSHh4R0FkrmOns6luu97kskkqGUlabhaNjuT5T9TOiD0c9hnyMcVDfkpAkvDfBDDD2PZaTBUY5zuPoZbKFCwCmZCKzoJgPTZrSgOwgRPpMbCG2C6tsZ6dBuL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7963.namprd11.prod.outlook.com (2603:10b6:510:246::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 03:06:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 03:06:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann
 <kraxel@redhat.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Subject: RE: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaFuTq+kqpFvBx/0+jXWJho7L/CbB+X2AAgAAFFfCAACIGAIAAB2wAgAQAf1A=
Date: Mon, 20 Nov 2023 03:06:11 +0000
Message-ID: <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
In-Reply-To: <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7963:EE_
x-ms-office365-filtering-correlation-id: 8c890951-ce43-4cb8-87e2-08dbe975a63e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZNBq5GfUDBms8aG+NCO2NGPMok9lf6pcx2Ce5PxeXCm2DbCF/oL93JNzLPorMgLGNOp+aZqIMqSJW1Y/ML5qKvqgMzqMzkroMqz9rJ3X79zvf+T+G7Ns8Qr7Xg8hnNdTdzHA9PQZP45AcdRG9nuV9N85qFUiiSat47yRnrhXYlWNj2oIKrtw0DzRE0DR0uAeQKarIwH4F1ykRqVEwrPcJqZpPsrUvWhICaqkWgKX73UcQhXrdeuq4dw6AY79Lqz+MYrumXygTl3mmxnDFYEsQVOJWiFk2ECwUv91NM3y7ZSq2hsK4dAqeZ5OrhDnJDU7cgyCdjLZOhZUTaJz03pqUnHc/Cg8xRsczxVN3eONnfQ9X5a8cTBKIYNGohu5rQ1BzziGXxQF28hz/Yx8gDEtA4IK72eA9swNn51ylwXP+OtItSShEAkfFCXuDlx/uB+vG0dv1/NY0cRT68vUP/c1uX4wzsIu47RUD8WFe3mGDzkFuhxflNmsegNc1stAZUQMF9vNxAzOFdYaNYmT8ICKqirbZBI9aXguSWqelXZ5MRPlab6SxfGTDrNhESC9m1HrAVI0oBVLJZH8b9gcKNwovbMJ/JUoqUvvNBNWC1sN+6Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(7416002)(122000001)(966005)(82960400001)(38100700002)(53546011)(38070700009)(86362001)(33656002)(66574015)(83380400001)(9686003)(6506007)(26005)(7696005)(478600001)(71200400001)(41300700001)(8676002)(8936002)(52536014)(4326008)(66556008)(76116006)(66946007)(110136005)(316002)(64756008)(66446008)(66476007)(54906003)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWtqSDExK1h6WjJjTE9ZczZoYUs3UTBPQ0M5MTdRQWI5aXhrVURjdytmZ2o5?=
 =?utf-8?B?T2puQi9SNVo2WFFHb09EWW9OZ3NHaWEwekJFRTZ4NkVrN2RuYVNSejcrbnlQ?=
 =?utf-8?B?MWY2REVaMDg3Zy8rWDdSVThTd0htbkxrb0RzU3lOMnJockhuNXI2MEg5bXVM?=
 =?utf-8?B?ODdXT3pFLzF2N2pkK0pBU1hRbGdZMUM4YVZseU0xWHl5RU9UQk95SExmelV4?=
 =?utf-8?B?QVp2YlhHN2drWml2RXRNUktjMzVlR0NUZVN5Z3FjZm1rUC9BYjZqTGJ1ZWxr?=
 =?utf-8?B?U2Rkem0zYjZuRXd4cEFRamRoaEhOQjl5L1dhL0pXWlNOODJwWkdXZVZHZkxG?=
 =?utf-8?B?OVZLT3lHUDBKUHlCSVI5ZWJ5dU9yY3ZEczlRM01HcnpWU3JWYUJQMW1jV1Yr?=
 =?utf-8?B?OTRmaHkycm90RGZ6UnoxdE9OUGp5dGI1TEZsV1ptQUVwOWkrM0wvbk9OTFpW?=
 =?utf-8?B?RXREUXJMcHB6ZzRyQ2ZNSEhyWVgzTUlqaU5Za0YvZytpSUl2OXJjdW5WQ0dF?=
 =?utf-8?B?WHNDQUQ0QS9xemduekFHREVML1ltUnluL1JvbVZBVVFOSXM4cnhPQVdvZTZr?=
 =?utf-8?B?TElWcTVFeitNanJiZVlNcWxIZUlzU1NYbVNZeDcxYmxTVEUvSnhLczBVbVRx?=
 =?utf-8?B?SlRPbWdESzVxbWJGbUkwRFZ2VzB0ZXlvTzI2bWZLOGtON0FBUThRbDhpTlNF?=
 =?utf-8?B?TXVyd0dzQmE1UGdwNEkwUDZ0V3JSaXY2VHVuamdnMVdaZlFOREhhejY2dTNS?=
 =?utf-8?B?cUxiWksrdHFKVS9tckIyblZ3WjFSRHQ4VE9IVnRKOENGeFhLeVZyR0UxRHhs?=
 =?utf-8?B?eXNncTZsMmloaWZ4ZTlpVFgrb3lBdm5UMGlVUWVISVdzcUtXdTMxZkQxdGxV?=
 =?utf-8?B?d2kzMnlJMzZyL0dlTDMraUozQXdpcHNEZ2JOZEtjcDFEeDVHVVR6UlFvTzVU?=
 =?utf-8?B?clpQTHV0RjRpVDdwV3VWSnBWbFNhMnVFMUJHVDVXMGlkSUVRVS9YTytVMHlK?=
 =?utf-8?B?bStxaEdHTHVCbGFlbi9YYU9KdFdyU1I5UXhsSnNZdldOSzZ4MW92OE1wdnZN?=
 =?utf-8?B?UlRoMWU1MFVLbDdJSnBDYlRQRlJUQzJzUW14ZnJISzQ5ZFN4R3YwRkR0c0Nr?=
 =?utf-8?B?S2lRajhuTE5LNnlkREhBY0crd0lqNDRxWDh6ZjE1dVNlMVU2bVR2Q1R3eENn?=
 =?utf-8?B?bm9tK0V1UEV2bGlGWm4zU29YTFdNMmRuRk1nSlVKM1A0WUcvYktlWi9wQng3?=
 =?utf-8?B?dU9SdkY3YlovSWtXcXhRWTRUcFQvaG4ra0ZRYXNoTGlhVlhURmV1WW5yajJh?=
 =?utf-8?B?TXV1VmNOTlFTU1JHMXZWcHhoemNFbTBlOHVVb2hWVjdTeUNUS1ZXODZDdncr?=
 =?utf-8?B?NHV1My9CbW45T1NhZE9sZHhCZjRYOHBINVdGOGNYVWtjaFdVZU9oK2xoa2JB?=
 =?utf-8?B?eGl2eHpOU09MSkdpenVCQndJa2l0K1hIR1VxdmMycWd4THA0NWttQVZKSHhl?=
 =?utf-8?B?cnVKelBqMlBWTVMrK3R0MVgxN2lta0pQWkNIZ1JSTVQ0c3ZIZDRTeXhpYSt4?=
 =?utf-8?B?aVBFellHWVVzMmpITnd1T2hGU3lkVER0LzBEYURQNFJrNk9XWm9QbGFiNWNX?=
 =?utf-8?B?V1U4Q05rT1JpUHAzTzdvelBwR3hEN2pmaCtnaEh0ZkJPa1NCaEMybkNDSnZB?=
 =?utf-8?B?bk9RcUJZNVgwdHR3UENZYzBRZGxCREJ0bEpSUVdBU3RubjdVRmpJNTdZUlhI?=
 =?utf-8?B?NGVzdWxYTk1VUXBxS1ZneVVFWEVqb0JLSUhaNXFTV3J2RTJPMVgyM0pkcDli?=
 =?utf-8?B?RHBVSjIrR2R1MTBuZE8wOHVOYUFtVXhuSlQ3Sk44QThIQUVEUTVtRThqYkpV?=
 =?utf-8?B?cmJFSlZxaUIyMXhrRFlXS2FNeU5vOXZmT0MxbnFGSkZVUkJDUnBiY3Q0a3ZI?=
 =?utf-8?B?N0t0R0t6MW1zWmF1Z3JJQ0pHWXQ4T3ZyR2pZeHJZblhBdUlha2tqOFIxK05l?=
 =?utf-8?B?ZUc2UEJ0TXFLR3NQRU1iUkEyWUVESEFDR2Rlc1FFREZHem5zajVXK2FoMHBt?=
 =?utf-8?B?M1EwLzRRdUFUVkRWNkRUUEdqM2t2ZzQ1SGsxVGNyaXNYVm5oUUZIeHJyMjFv?=
 =?utf-8?Q?MOqhEdHVG6jvxUKIS60sJ8h78?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c890951-ce43-4cb8-87e2-08dbe975a63e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 03:06:11.2069 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iCRexXIWwht0jiPz6WsGL1ZEG6DXpnnn3teKDabG21SHBzvLddZsrDtRqMnJ9l8FADj8zLj51xZS0wU/5INDuhEBYt6zAglxywLHuI5Amo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7963
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDE3LCAyMDIzIDk6NTYg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAxLzIxXSBiYWNrZW5kcy9pb21tdWZkOiBJbnRy
b2R1Y2UgdGhlIGlvbW11ZmQgb2JqZWN0DQo+DQo+T24gMTEvMTcvMjMgMTQ6MjksIEVyaWMgQXVn
ZXIgd3JvdGU6DQo+PiBIaSBDw6lkcmljLA0KPj4NCj4+IE9uIDExLzE3LzIzIDEyOjM5LCBEdWFu
LCBaaGVuemhvbmcgd3JvdGU6DQo+Pj4gSGkgQ8OpZHJpYywNCj4+Pg0KPj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+DQo+Pj4+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMTcsIDIwMjMgNzoxMCBQTQ0KPj4+
PiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDAxLzIxXSBiYWNrZW5kcy9pb21tdWZkOiBJbnRyb2R1
Y2UgdGhlIGlvbW11ZmQNCj5vYmplY3QNCj4+Pj4NCj4+Pj4gSGVsbG8sDQo+Pj4+DQo+Pj4+PiAr
aW50IGlvbW11ZmRfYmFja2VuZF9tYXBfZG1hKElPTU1VRkRCYWNrZW5kICpiZSwgdWludDMyX3Qg
aW9hc19pZCwNCj4+Pj4gaHdhZGRyIGlvdmEsDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHJhbV9hZGRyX3Qgc2l6ZSwgdm9pZCAqdmFkZHIsIGJvb2wgcmVhZG9ubHkpDQo+Pj4+
PiArew0KPj4+Pj4gKyAgICBpbnQgcmV0LCBmZCA9IGJlLT5mZDsNCj4+Pj4+ICsgICAgc3RydWN0
IGlvbW11X2lvYXNfbWFwIG1hcCA9IHsNCj4+Pj4+ICsgICAgICAgIC5zaXplID0gc2l6ZW9mKG1h
cCksDQo+Pj4+PiArICAgICAgICAuZmxhZ3MgPSBJT01NVV9JT0FTX01BUF9SRUFEQUJMRSB8DQo+
Pj4+PiArICAgICAgICAgICAgICAgICBJT01NVV9JT0FTX01BUF9GSVhFRF9JT1ZBLA0KPj4+Pj4g
KyAgICAgICAgLmlvYXNfaWQgPSBpb2FzX2lkLA0KPj4+Pj4gKyAgICAgICAgLl9fcmVzZXJ2ZWQg
PSAwLA0KPj4+Pj4gKyAgICAgICAgLnVzZXJfdmEgPSAodWludHB0cl90KXZhZGRyLA0KPj4+Pj4g
KyAgICAgICAgLmlvdmEgPSBpb3ZhLA0KPj4+Pj4gKyAgICAgICAgLmxlbmd0aCA9IHNpemUsDQo+
Pj4+PiArICAgIH07DQo+Pj4+PiArDQo+Pj4+PiArICAgIGlmICghcmVhZG9ubHkpIHsNCj4+Pj4+
ICsgICAgICAgIG1hcC5mbGFncyB8PSBJT01NVV9JT0FTX01BUF9XUklURUFCTEU7DQo+Pj4+PiAr
ICAgIH0NCj4+Pj4+ICsNCj4+Pj4+ICsgICAgcmV0ID0gaW9jdGwoZmQsIElPTU1VX0lPQVNfTUFQ
LCAmbWFwKTsNCj4+Pj4+ICsgICAgdHJhY2VfaW9tbXVmZF9iYWNrZW5kX21hcF9kbWEoZmQsIGlv
YXNfaWQsIGlvdmEsIHNpemUsDQo+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZhZGRyLCByZWFkb25seSwgcmV0KTsNCj4+Pj4+ICsgICAgaWYgKHJldCkgew0KPj4+Pj4g
KyAgICAgICAgcmV0ID0gLWVycm5vOw0KPj4+Pj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJJT01N
VV9JT0FTX01BUCBmYWlsZWQ6ICVtIik7DQo+Pj4+PiArICAgIH0NCj4+Pj4+ICsgICAgcmV0dXJu
IHJldDsNCj4+Pj4+ICt9DQo+Pj4+IFdoZW4gdXNpbmcgYSBVRUZJIGd1ZXN0LCBRRU1VIHJlcG9y
dHMgZXJyb3JzIHdoZW4gbWFwcGluZyByZWdpb25zDQo+Pj4+IGluIHRoZSB0b3AgUENJIHNwYWNl
IDoNCj4+Pj4NCj4+Pj4gICAgaW9tbXVmZF9iYWNrZW5kX21hcF9kbWEgIGlvbW11ZmQ9MTAgaW9h
cz0yIGlvdmE9MHgzODAwMDAwMDEwMDANCj4+Pj4gc2l6ZT0weDMwMDAgYWRkcj0weDdmY2UyYzI4
YjAwMCByZWFkb25seT0wICgtMSkNCj4+Pj4gICAgcWVtdS1zeXN0ZW0teDg2XzY0OiBJT01NVV9J
T0FTX01BUCBmYWlsZWQ6IEludmFsaWQgYXJndW1lbnQNCj4+Pj4gICAgcWVtdS1zeXN0ZW0teDg2
XzY0OiB2ZmlvX2NvbnRhaW5lcl9kbWFfbWFwKDB4NTVhMjFiMDNhMTUwLA0KPj4+PiAweDM4MDAw
MDAwMTAwMCwgMHgzMDAwLCAweDdmY2UyYzI4YjAwMCkgPSAtMjIgKEludmFsaWQgYXJndW1lbnQp
DQo+Pj4+DQo+Pj4+ICAgIGlvbW11ZmRfYmFja2VuZF9tYXBfZG1hICBpb21tdWZkPTEwIGlvYXM9
MiBpb3ZhPTB4MzgwMDAwMDA0MDAwDQo+Pj4+IHNpemU9MHg0MDAwIGFkZHI9MHg3ZmNlMmM5ODAw
MDAgcmVhZG9ubHk9MCAoLTEpDQo+Pj4+ICAgIHFlbXUtc3lzdGVtLXg4Nl82NDogSU9NTVVfSU9B
U19NQVAgZmFpbGVkOiBJbnZhbGlkIGFyZ3VtZW50DQo+Pj4+ICAgIHFlbXUtc3lzdGVtLXg4Nl82
NDogdmZpb19jb250YWluZXJfZG1hX21hcCgweDU1YTIxYjAzYTE1MCwNCj4+Pj4gMHgzODAwMDAw
MDQwMDAsIDB4NDAwMCwgMHg3ZmNlMmM5ODAwMDApID0gLTIyIChJbnZhbGlkIGFyZ3VtZW50KQ0K
Pj4+Pg0KPj4+PiBUaGlzIGlzIGJlY2F1c2UgSU9NTVVGRCByZXNlcnZlZCBJT1ZBcyBhcmVhcyBh
cmUgOg0KPj4+Pg0KPj4+PiAgIFsgZmVlMDAwMDAgLSBmZWVmZmZmZiBdDQo+Pj4+ICAgWyA4MDAw
MDAwMDAwIC0gZmZmZmZmZmZmZmZmZmZmZiBdICgzOSBiaXRzIGFkZHJlc3Mgc3BhY2UpDQo+Pj4+
DQo+Pj4+IHdoaWNoIHdlcmUgYWxsb2NhdGVkIHdoZW4gdGhlIGRldmljZSB3YXMgaW5pdGlhbGx5
IGF0dGFjaGVkLg0KPj4+PiBUaGUgdG9wb2xvZ3kgaXMgYmFzaWMuIFNvbWV0aGluZyBpcyB3cm9u
Zy4NCj4+Pg0KPj4+IFRoYW5rcyBmb3IgeW91ciByZXBvcnQuIFRoaXMgbG9va3MgYSBoYXJkd2Fy
ZSBsaW1pdCBvZg0KPj4+IGhvc3QgSU9NTVUgYWRkcmVzcyB3aWR0aCgzOSkgPCBndWVzdCBwaHlz
aWNhbCBhZGRyZXNzIHdpZHRoLg0KPj4+DQo+Pj4gQSBzaW1pbGFyIGlzc3VlIHdpdGggYSBmaXgg
c3VibWl0dGVkIGJlbG93LCBjY2luZyByZWxhdGVkIHBlb3BsZS4NCj4+PiBodHRwczovL2xpc3Rz
LmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0xMS9tc2cwMjkzNy5odG1sDQo+
Pj4gSXQgbG9va3MgdGhlIGZpeCB3aWxsIG5vdCB3b3JrIGZvciBob3RwbHVnLg0KPj4+DQo+Pj4g
T3IgYmVsb3cgcWVtdSBjbWRsaW5lIG1heSBoZWxwOg0KPj4+ICItY3B1IGhvc3QsaG9zdC1waHlz
LWJpdHMtbGltaXQ9MzkiDQo+Pg0KPj4gZG9uJ3QgeW91IGhhdmUgdGhlIHNhbWUgaXNzdWUgd2l0
aCBsZWdhY3kgVkZJTyBjb2RlLCB5b3Ugc2hvdWxkPw0KPg0KPkkgdGVuZCB0byBiZSBsYXp5IGFu
ZCB1c2Ugc2VhYmlvcyBmb3IgZ3Vlc3RzIG9uIHRoZSBjb21tYW5kIGxpbmUuDQo+SSBkbyBzZWUg
dGhlIGVycm9yIHdpdGggbGVnYWN5IFZGSU8gYW5kIHVlZmkuDQo+DQo+SG93ZXZlciwgd2l0aCB0
aGUgYWRkcmVzcyBzcGFjZSBzaXplIHdvcmstYXJvdW5kIGFuZCBpb21tdWZkLCB0aGUNCj5lcnJv
ciBpcyBkaWZmZXJlbnQsIGFuIEVGQVVMVCBub3cuIFNvbWUgcGFnZSBwaW5uaW5nIGlzc3VlIGl0
IHNlZW1zLg0KDQpZZXMsIHRoaXMgcmVtaW5kcyBtZSBvZiBpb21tdWZkIG5vdCBzdXBwb3J0aW5n
IHAycCBtYXBwaW5nIHlldC4NClNvIEVGQVVMVCBpcyBleHBlY3RlZC4gTWF5YmUgSSBzaG91bGQg
YWRkIGEgY29tbWVudCBpbiBkb2NzL2RldmVsL3ZmaW8taW9tbXVmZC5yc3QNCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

