Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9B17E4FBD
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 05:32:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0aDy-0000PG-S3; Tue, 07 Nov 2023 23:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0aDx-0000Oy-Bm
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 23:31:29 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0aDv-000161-Ql
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 23:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699417887; x=1730953887;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7kxj+HbmBcDMeA5uO/wLIBeL3tRr+qAzhGL/9jkk6Bs=;
 b=Z1v1H3ruZcVtDQfsfWNj7SYASDjr2DQV5p4jc7vFOupt8yuY9imwgi7O
 LtGDO5rc9snVwmO8HqT7KMU01ziG7qFG+DvTYJuicrSvubo6AnojSiM0R
 hqpzHSQg+ZSYwNisMLoUDf2/sagefXijcUe+/j3j/y0d3/urJhuX3637v
 yHnr/Yh1ztvlNx88lDRWaOcd1z1cCYlrCzBppiAltUL6Yf692VVx+Wy2g
 xaQ4f44iwFEX7U0npBmpMI+rrWu4hNkVgwQqboY8cTd+tEtCcwyXukSeB
 CzE5Nc9k82Ay6OkJ3xRM0UCDzafzWJlMQ+TAWYyvsRdT2Fl6sTXVoXUyV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369021452"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="369021452"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 20:31:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="906653562"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="906653562"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2023 20:31:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 20:31:25 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 20:31:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 20:31:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnISP2UfDu9RmXO8VzaLVwYy6YAQVwTB5aogWgcqQpGXhFo4s8CiBD4qbPRK3fVkNTk09tRgEumyiFfoGFnURuF4yzycriD8vQ/Zkcnpo0rzxmUCagxpTdMM/06Vh7IpiizFJqtIlnWvZzdtiKXwcChO96PGZqdarjpi7BzTesDDL2RHvs+C3QhRXBa5ny60AF2HIUlhCoLdkVj60sneRUNhlMemfr9oj0jmv9XJjs9GmL0eCxvkWmdamqcg6xfiOqGYEfbWKNucbvn/tGGhWbOcyOePFaJrzXw/eoS7qrSbw80FcEMOA0/a985nPzDAs5CvEUxRKu4X17WWdRClaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kxj+HbmBcDMeA5uO/wLIBeL3tRr+qAzhGL/9jkk6Bs=;
 b=VPbl6zLquzSIhYIQP54iI6ra2ByQFJrp4oZ18o87elKvk7RTY4qZnJvwnQxYXoHjsWF4qr1gHWTzaJ/t2jLO7fXQgWHZe+l9zJdVIYzE2yASjqjhFPWoN4+53tkh+sUn78rnW68X86RNqjlMv0JUsuZm8W+SRGF3VoFL+bqvHlWndRIjkp2IMOOFU1rWnKDYXbB+NC8pSUgqSnp3TXWWS31Pkwq8PgnxGN2q4IxUs4z0k6BO5nUX4DytF1uwTpVeq6gbQ3w6W3VEr4xr0c1pk1n2xW3zzJs5VfOm3fi3PpHkh8HeKx8fyGRcc08BPcznZo02xQsGkJvS9z+HX5VGbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 04:31:17 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 04:31:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>
Subject: RE: [PATCH v4 41/41] vfio: Compile out iommufd for PPC target
Thread-Topic: [PATCH v4 41/41] vfio: Compile out iommufd for PPC target
Thread-Index: AQHaDV6bFz8GUpjYN0OzuGSniWC6p7Bu5jEAgAD3nFA=
Date: Wed, 8 Nov 2023 04:31:17 +0000
Message-ID: <SJ0PR11MB6744D5ACEC53BCD692D0688C92A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-42-zhenzhong.duan@intel.com>
 <0c363b88-5e69-4fd7-a80b-bf9b7821263d@redhat.com>
In-Reply-To: <0c363b88-5e69-4fd7-a80b-bf9b7821263d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8081:EE_
x-ms-office365-filtering-correlation-id: ac9d3492-d820-465c-d3e6-08dbe0138d05
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNaV1gDrS0YWvPGdTE16o3Q0nuumAd3wRGIxRLHTYUtWN/FEBVaSiRSOG8elKvWeRt1M7lt6GxJm+l98tZnU7SrH3CSfr7PC2NR8Puttrszp0MOoN7EDPmEo6YBiYgB9cHBwrzy+gxwcsyOxC+yjHqyoMrey8bVlHsiWq+jsXV7TvHEWZiWHwQtYQ0BfU0Pa8MzrNSg9Wn9f8f4+pWQSFNKwMd7lFPZk4BNB9iZPg1aIxVJhRw3qHSp8tsujRMHs8aTMDzAf4oJ7Pzed5OuQ1QGM5OpYbhVllMf7dixe0l2FLcl+Igs9OYqWAT39xL9+QasF2sh32cyBXWS0K1u8wxPHcooi1qpG/6QdseiF+A98puBLKmmbRZtS58CpPlGHDOEyzao0uHdCM2a9LuJfLCVVtqYT/Yf4LjkXHOMrqvsE+5eyqx7TmHGTM1rTZLdXi3zNhsrQNGS4OnQONlpA1P975/kiq/HiD6zks6V93LwBA6dD2OX3mK3umya2WUSVktIGAThOi/qryLnkNnZkZ34XNXQewuB2sQah6C3rzFQ7TEO/Sd0b3hz5vy8bzQY2PYJzDwJieehTRx4SUKPSa3tRVhYrWiy5gqmgD3BGGEZdw50PJwi2QhpCTdpdd8CQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(122000001)(9686003)(52536014)(82960400001)(26005)(478600001)(110136005)(66446008)(64756008)(66476007)(54906003)(66556008)(76116006)(66946007)(316002)(7696005)(6506007)(38070700009)(71200400001)(8936002)(4326008)(8676002)(55016003)(2906002)(38100700002)(4744005)(41300700001)(33656002)(5660300002)(86362001)(7416002)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkFpSHNlZkFneHZvZUNzOWhySXlBQnkrMG1FdUVVelZmYUltVUVqOWNNMDcv?=
 =?utf-8?B?T0hqOEQ3a0ozMHhwMnJ6KzRDZFBWNU1rcDVidlpFTVZiNFNWVDNScldManVv?=
 =?utf-8?B?OWtJRTZ3TldWOXlTTDlxSFJlVzNyUzE3ejRzRE1xSjhBTFZxRFh2YXFpV2xZ?=
 =?utf-8?B?OUdFL01jNFd6ZGlZTDA0clB5NExhdThtbGRCalg3ZDloN0pZeXVyS2ZtTlZG?=
 =?utf-8?B?ZEJSRks5alJIazhSRFZKdjBVZWFhRm53Wi9KTy9ualVraTM2Y044ZS9lZUV4?=
 =?utf-8?B?UWZDWmlHK0UxQlRDNStCYTN5NjhrM3BMK3d4MkNqMUFUT3VHaTBVQ0VaalRQ?=
 =?utf-8?B?dldSME00NEM0djRJSmF1R284L0NJbGlRTk83a3RXUWM0UUhHSTBhdjQ5VWIr?=
 =?utf-8?B?NTNRZzdtVzhUbHlPcUFJTGlEYVBMT0NWS21VbUlTbWgwZVA1SlM3b1RRNTgv?=
 =?utf-8?B?bVpHWFJVZkkzVzV0alBRZGh4dFhoM2o1ZlBlOXVxTnZJcmVMUFFnUEN5U0xY?=
 =?utf-8?B?NUdKZkFCUjBCanBDeWIwRi8yb0YvK2ptaWNKa0l0NXBrbVpXbDNXa0F2THJT?=
 =?utf-8?B?VzJSTkVrTmRmbGNoQklDekkveFdUQUdBNHhDMzlQWmhEQUpra2lLUlVMYy9h?=
 =?utf-8?B?RjE1bTlKdGhwankxdTV6MmZIU0I0Vi9pTzBJSXVsNURuMEhGc083S240eXlB?=
 =?utf-8?B?QkxRakd5TnAxTndzZ0lzaGZZWlVYWmJVNzMyK3ZPOE81a3VXUDNHdG9vVUZI?=
 =?utf-8?B?Y3NHclRGQXFOTkY1ampuVGZGcjBmcHZXUTN0cW5BRGliSDZ0cnloNEswWmcr?=
 =?utf-8?B?ZEV3T1kwTzdDREEySi9Wb0tTZGNVdWUxU0QyWlhkZkkrbjVGdUZ1by82VWdM?=
 =?utf-8?B?Y2xWdm9mV1FTUW1mSnhJUWQ4UE9HTG5kVDcxeFI1M05RYVlZcVVRamk2TFk4?=
 =?utf-8?B?bVZmSzdLMHlLOXY3TE9HRzRRR21yQmRoTzJLVlVobzFKOVNVSjFyTlZaTisr?=
 =?utf-8?B?c2Q0WVlMckpTd1BFL1JiU2FBam9HcndxM2E3QlBqNVloQ08rTXBublc4endK?=
 =?utf-8?B?dDYvQ1BObVpIc0VYbE1WRFdZb0Eydyt5QUc3QURXYXVtblZWT2hzelJSTGNX?=
 =?utf-8?B?OW03eTFOY0twUFRta01LSmRrczJJc2lYS1Z2ZGZ5RHFrYXBLRHhnaVRZS2hD?=
 =?utf-8?B?ejBMNVprN29aeVdiWkdjanBraEF5ckYwYzg1QzRtKzJGbnhYWlEweG5XWElN?=
 =?utf-8?B?T2JycEFXWDl3aUVUYVZvRWVNVGs0aGZ0b0pSMzlUNVN6cjU0czI0cXhGQWFs?=
 =?utf-8?B?b1Y2cE5rMS9FcTlvblF0enkzVTJKK2h6b3QwUjlOb2pmcjkxR045QXZmUmRz?=
 =?utf-8?B?ZHRsRjlqdDFaK05zc0YyY3RIc2g0QVV2b3FEUjhmdFRFcHFSSjdCdWVnc0tn?=
 =?utf-8?B?Y2MwY2k4UnN3Q0xBSExkd0RrUndIdXozZnhURDN5d1lpYU40dTROZzIyNmQz?=
 =?utf-8?B?R3M2aXR5cmc4UVhwZDlDUlF1WHdoUkJWTVBWM0hiNVZXNDFabTB4U1NaZ3Fy?=
 =?utf-8?B?WGdVZms5SFRncWR1d2ZHQm1zMXJsQ2pHNFZ6OFBNVGRaT3VnVHEzL01HeWxO?=
 =?utf-8?B?VXdXaCtLSEZDWXFjR29pT2RYRVVwMDk1V05wQlFQaitjUEplUlRWc3ZrQXB0?=
 =?utf-8?B?Ym9EUkN5N3pnMDB3SWpkM09xS1dHcFkyalpmMGFrb3JQL0phTGxGazE5eUdV?=
 =?utf-8?B?ejdDdnNqaVQ0Nk5SOHNYUFdidWc0cXBMN2U4TkxJandQWXVTaVpFbGJ2b3Q2?=
 =?utf-8?B?S1p2RElRUHRvV252MjFpZTQxZE1weGEydWlVbXgva2Q4VUR4dmtjT1Zoaitk?=
 =?utf-8?B?ODVxSGt4YjlJV1NYYzRZdHdwVlRldzY0WVRuViticjNvUTdpSnB6ZXBVTktY?=
 =?utf-8?B?MElRZ3haRzFlMnlzWUcxZjRnNGhoNnozOVFJT0JtSWt0TC9EYzNiYU1wQ2lz?=
 =?utf-8?B?SWJRWng2Mk5PdTVOYnczWERVRlBIcmEyYjBRejdnVVRwVjQrMk1rcHgzYWJz?=
 =?utf-8?B?eVhVckhxZXdid0lWTlV4T0N5RzgzUFMzVmJDV2xjakd2Nnh5WlU5bWtGc1VY?=
 =?utf-8?Q?CO040pVbKizY67zyuPzisaGHQ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac9d3492-d820-465c-d3e6-08dbe0138d05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 04:31:17.7675 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrRJV/PwM05D0+2e+L7jIrrgs3JabsczCHmGuoj01tJW/JaF+L5YaLHlTT/Inm/yFaEUHkNiz0sKgAjH0j2qvg0x/MlGGZqeTtHcgHcqqU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA3LCAyMDIzIDk6NDQg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDQxLzQxXSB2ZmlvOiBDb21waWxlIG91dCBpb21t
dWZkIGZvciBQUEMgdGFyZ2V0DQo+DQo+T24gMTEvMi8yMyAwODoxMywgWmhlbnpob25nIER1YW4g
d3JvdGU6DQo+PiBTaW5jZSBQUEMgZG9lc24ndCBzdXBwb3J0IElPTU1VRkQsIG1ha2UgaW9tbXVm
ZCByZWxhdGVkIGNvZGUNCj4+IGNvbXBpbGVkIG91dC4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEPD
qWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56
aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+UGxlYXNlIGRyb3AgdGhpcyBw
YXRjaC4NCj4NCj5JbnN0ZWFkLCBhZGQNCj4NCj4gICAgIGltcGx5IElPTU1VRkQNCj4NCj5pbiBo
dy97aTM4NixzMzkweCxhcm19L0tjb25maWcgZm9yIHBsYXRmb3JtcyBzdXBwb3J0aW5nIElPTU1V
RkQuDQoNCkdvb2Qgc3VnZ2VzdGlvbnMsIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

