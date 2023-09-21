Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1B97A9118
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9n2-0003sG-CS; Wed, 20 Sep 2023 22:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9n0-0003s4-HE; Wed, 20 Sep 2023 22:51:38 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9mx-0004IF-HZ; Wed, 20 Sep 2023 22:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695264695; x=1726800695;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XalnvuuMK6cflR57UDgMqPsABx2srkfI8fuMDcmvPSc=;
 b=nuMcFgLHl1f47/IBy1FIsWXyu0I9TmG90znh4FXNMtuAFXrZkOuM3Qg+
 Pyg/FIZjEDKcZw4+Iym0aTBDCd5KOxvw8iTSzyAlfPRdhPgfVr1fO9LRE
 vgcDwuwfpstwKlD3sz3kMXP3/DLhVjxFkB4InfLPccyYCP1gFVuTfLRqP
 SHrqUIySGmonnlMeQX/3FD5fli+d9o5LuMZMa1e29571zRsb+ve8+EyeD
 nKAJsiZoe8yFVRLJm961pOvw/DNfK1soBEiOxzcfdiHo+Brq6cyisSqWh
 tp0GsdtCAPL62xfmRBff3erx4QqmO4hBMc7vgWZn9g1TiHffRV+WnowWX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446872985"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="446872985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="812436336"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="812436336"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:51:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:51:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:51:29 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K3oxx1YEJ2DVndFoUnXrMUWiQM4D6xltkQqqDw6Y8+sdbU5c+N+LSs/3byfAI0nOLp7SHml3qM/9olWpEmHjkNQdM3OUKPaz3eccixK71Tkh51OXipFO3zD5aOyyh8Kelo32MrZTKrb9L2GIqVlsUpHrPj+UgvgSVajU7LHR6X54uWHRorPBW/2tNkOaO7zC9pnyoVw08vRdSBNWvndtKYmTSqI6/g8HRX73hgdQ/pY/7hqoiHlYDxidN95lWza7VwfJjf4c+D9cYi8b2ufoVvcVpGdohtn22d93eah5BnrnoJZtPdLpm3al5DbWTL0XRGV7YYDNQTXJ9WSdnq8cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XalnvuuMK6cflR57UDgMqPsABx2srkfI8fuMDcmvPSc=;
 b=CrbFpVetj/Mqkfmwkr29V3jBRQPCsQxzFRIIeo28phNUUsKpa5Kfr1cUDXmZ2SQzdv1/rXmRmQ2/zWjWKIjEbeZ9mU3ZlZ8M/3+4FxTvnMtgX53+CmSlHDrNU67FaPRa9gKpfg+AAXl4QdXeRtwYNBauTsQNg/r1jl4WONq3+Zd3cVzFq9rUiecTenFS579azgFGw3H73o7OHveD15NPcKz7pCBDns89y29rDlbSBXLq3xoeehInKEgKNnex9+DLpkcCDAJUzY5E/y7T4oggPpzZb18WU6wyowiZ9Sbpxioj1A9IvMWZQt6BAtJaY+bFDNULzLXlwpQIENrWOyPksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB8287.namprd11.prod.outlook.com (2603:10b6:510:1c7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 02:51:21 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:51:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>, "open list:sPAPR (pseries)"
 <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v1 13/22] vfio: Add base container
Thread-Topic: [PATCH v1 13/22] vfio: Add base container
Thread-Index: AQHZ2zBKcvHai3HTVU61uaTXJ4y/6rAihaoAgADiycCAAGU/AIAA5rYw
Date: Thu, 21 Sep 2023 02:51:21 +0000
Message-ID: <SJ0PR11MB674472521D9704B2D62F953992F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
 <SJ0PR11MB67449058E09E80EB7891381F92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <4df735b7-addb-cc02-05dc-360752d5ae35@redhat.com>
In-Reply-To: <4df735b7-addb-cc02-05dc-360752d5ae35@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB8287:EE_
x-ms-office365-filtering-correlation-id: 8acfdb4d-68e1-48e2-cd09-08dbba4da333
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s887iDpvUVSp2fyV2gOWSxaLrTIB0w58z7G0cmcJGJdw9gNSV6nQf3Wz/4V+OevhM2o2YQB7ZyMqcBOiAMJmgdF8MfGkNCK/fKchVrYSikI+CM2car3YKrYCQ0Eki3Pg1eTmkeLgLkl1XRIETjKIGErknDF7SOgtrH75MQDcmZWw3uYXFYQn00xjA2enNbyUG0En1jJYpRwNqJvsQBfJjRpwVcEnEjE8Nj4XoUJS72fYBDwXTYlemim7sgRharjp/yH+2TrlwwWFWWXnHxTpfEGg/g5KLLlw0OKskEyHxvpN4U+GDMT/NwLEvtPcAh4/k+5RPgwj6mdhx3j5TYgQIpwI7ns9nxWyxqXAPKzq60bE454WaR22LPIePJgwfKk6TjPcz++26y9e1vYHSW5ZGzhsIWNk+aQPIyVZoulL9GT7oRZOslsjQkOE/pliSjIRodW0GrU8OMX28oU/j1sbDCqH3GSRTZXGgVD4Oena1nR7NiQl6a+W2eZ9+jo8HIye/eWIMS6TVHO4I8OkfGpjeypAfxDqjwTPwNsH9ZaeFAe7fZWcEBGyO4ObbkjFDa4+yi/l1SH20VZqFHHGsEBrHyDwAFUWYXVpXsqsoKPYKLE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(6506007)(53546011)(7696005)(9686003)(966005)(478600001)(71200400001)(83380400001)(26005)(66574015)(2906002)(7416002)(54906003)(66446008)(66476007)(76116006)(66946007)(316002)(64756008)(66556008)(110136005)(5660300002)(52536014)(4326008)(8936002)(41300700001)(8676002)(33656002)(86362001)(82960400001)(122000001)(38100700002)(38070700005)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S29UdDlLbi91bk1NR2tIRnVab09NMW16WjVmSEJRSzNyZ0IvVGdHSHEwQ2VI?=
 =?utf-8?B?YnlKSjRsVnN3RFlMQUZoK09JQzlKNTVUaloxVDB3Z1U4cytmMjRUL1R6UC9P?=
 =?utf-8?B?RHM4bENlc0czdzdza1Z3L3pGcW04OVFmZzRoQitoK2t0bWJQUzBFMjFDRWZy?=
 =?utf-8?B?UTBYM1dCVHN2NG05UmZOUTh2aWdHL3NrRVdRakF4R2RtQVZwR2ZXUmZPWFY0?=
 =?utf-8?B?eUxVLzRUdUZYZ2ZyMDRvTTBiRUtoN01hSHUzOHZlU25pQnZwUk9LWjhUUDZz?=
 =?utf-8?B?UVBKakRBd2tUM3U3a2JJRXZhQ3FBcWlrbUtjTThRUUFFRmZwUDlsRWpMSGVv?=
 =?utf-8?B?TGxSbEp1cmhnZTFjT2d2emJkMW5TRjVKbHV6WksweHFOODN5QUY3RmNUclFx?=
 =?utf-8?B?Y29Xc2ZJVTRvMmMvV1lneHF0dUJmcklXRUV1MFd1Qm9zSDBwZHlxMW4ySFhU?=
 =?utf-8?B?RHplVVJZMk9ibU5yaTBORnY5WS9qbFlJTzhYUGg3VUd2SnpYdVptcG00ekYr?=
 =?utf-8?B?YnUvMkZVam5zM3hNamwwUEoxMzJtUmJuQ1hLbHBuWDdZYXczeTIwd3RROStw?=
 =?utf-8?B?MVMrUXh5bzRnMEgvamZIOU5CVkhoT2hvdjJnamVnNDFPMVZKaWxiOWViRU10?=
 =?utf-8?B?SzlBQVA1MXVhdkZzdG9xUU5oampoOUdPNi9GVVB2VGtjWkxERzdBK2c1WXRx?=
 =?utf-8?B?VDVoK3BJWWJ2ZjZkelJWS28xa3VScS95YWk2QnEvdWlvZlR6V0hVeExDT2R5?=
 =?utf-8?B?SEpEZENiQVBNQ2REbG9TblMzV0l2OGxpdFhHb0RuNVk4NDRHUDN2V3owQUY5?=
 =?utf-8?B?RUxjTy9EekNQZFgzVHdoTnBMMWwzZ0ZPblg2U3pPenpDRDlVS3Y0NVhYWVRK?=
 =?utf-8?B?UDhSRkY2WGI4ejg5LzRwd3FibmxIaFJubjd3SUFKeFlXTTZpRDhPRzVEVERU?=
 =?utf-8?B?TnVHdGhSLzlLVVM2Qmw1UmN1SkcwQXlFOUpCYTJhUGdmNldaajhLeUlic05l?=
 =?utf-8?B?MUZFVG9YUDRuNmlzQnFHeXptRHM4Zm1HZHFiVlZocDlXUmc1YnZ0eTNnbEJZ?=
 =?utf-8?B?QWpTWTRkVlI5dGxZVE1JUWVvUkVUejNZOUxLc2ZFTFVUTU00dHlpUFpJdGc5?=
 =?utf-8?B?dzR6RWVUbk95WjdhNzZwRkt2QjNhTHh0aklEbDJ2WWlManQ3SmR0VjlCT2N0?=
 =?utf-8?B?T0pCZm40YkQwNW9uUnI1Z3NsM1Y1V2kvREcxWlhRUkc5U3Zjc3dKSXNBMFFF?=
 =?utf-8?B?a3R5NjRlVWxBdzdwczkzbWxkUC9IaExURVQwc1RhdHdxakFBcW1UOVpUUXUz?=
 =?utf-8?B?MFlYL2RFMGlucWp1NlFJUWxuNDZML3dmMkkzeDdVckZTdnRkMW5EUUdjQ2ZD?=
 =?utf-8?B?UEVuUGxNS1BINExvdTlOVW9sencvcGlYQ295bGszZVNyU3orMjBzbUFNSlc0?=
 =?utf-8?B?MzVwd09GTHFvVWFtNGpiNEgwVzNrak5PUlRQOFM3NVZ5U21UbVp5NzJMQzBk?=
 =?utf-8?B?aDdvVFhxNzFXcDd6b1FIMWtxVmZVMHhJZUpZYWxEcXE0V1JMNGFIajR0TzNY?=
 =?utf-8?B?em9qVHpyS0N6RndUT3hqSmFSaHdXQzNPRlJzSTcxL2RoMHhrMFdoTGEvcWda?=
 =?utf-8?B?VjhBbnFjK0hGTDRsZXhtWmt3WVBYeU9qdGtoWGU0SmZ1QllBMDlsc0IxeHls?=
 =?utf-8?B?YzNHemgwR0M3aE9pZkFyZndHRkFKRUlVbDF1bWFGSk94Tm1mY1B0VVpIQ3RN?=
 =?utf-8?B?RzRFOHdQTmFaUEI0YlQvTVpKdGtBVVdiYkIyWUhTa3dYM1JxTDdzNjRyd1NP?=
 =?utf-8?B?SjFubWNFUkE1bEdrMEZOOGFTSnRqUUt6T3BjY084VEtZdTlwU1BqOTJsWGIy?=
 =?utf-8?B?ZmNVQnoyb0dmVDFkODZDdDZVaFNIaUtqVXNZZ0lWb3hhbHc4VURxbGkxayt6?=
 =?utf-8?B?NEJxMU9SNmdNanZ0dGxFbitrWU4xUDVMdHJTeTg1UHhaTjBaQy9YVjZmU0VX?=
 =?utf-8?B?bGZzZk5FdnRoQ3JXcmhISmhvamswYm5GQzB1bEZuWDV0K1FWY2VlZnpMeVdM?=
 =?utf-8?B?MTEzcTVBYXBYWG5GT25NUXlXeXgvaDRYMWc1RUtOUnpPaE45VHZRRWIxNjZR?=
 =?utf-8?Q?j2iv0cYQkfDLpaOSD9yAYsObZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acfdb4d-68e1-48e2-cd09-08dbba4da333
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:51:21.5914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aUmdutjPbUriBWmtOktyLh6uvX+5eLgW97V7meuOku0BkfaokFOARjIXHftF3g6c37D2yia+ilI8FvxCaXcKRVF0Fame19rZjP0upiVP+EU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8287
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA4
OjU4IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMy8yMl0gdmZpbzogQWRkIGJhc2UgY29u
dGFpbmVyDQo+DQo+T24gOS8yMC8yMyAxMDo0OCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4N
Cj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIg
MjAsIDIwMjMgMToyNCBBTQ0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTMvMjJdIHZmaW86
IEFkZCBiYXNlIGNvbnRhaW5lcg0KPj4+DQo+Pj4gT24gOC8zMC8yMyAxMjozNywgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+Pj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+
Pg0KPj4+PiBBYnN0cmFjdCB0aGUgVkZJT0NvbnRhaW5lciB0byBiZSBhIGJhc2Ugb2JqZWN0LiBJ
dCBpcyBzdXBwb3NlZCB0byBiZQ0KPj4+PiBlbWJlZGRlZCBieSBsZWdhY3kgVkZJTyBjb250YWlu
ZXIgYW5kIGxhdGVyIG9uLCBpbnRvIHRoZSBuZXcgaW9tbXVmZA0KPj4+PiBiYXNlZCBjb250YWlu
ZXIuDQo+Pj4+DQo+Pj4+IFRoZSBiYXNlIGNvbnRhaW5lciBpbXBsZW1lbnRzIGdlbmVyaWMgY29k
ZSBzdWNoIGFzIGNvZGUgcmVsYXRlZCB0bw0KPj4+PiBtZW1vcnlfbGlzdGVuZXIgYW5kIGFkZHJl
c3Mgc3BhY2UgbWFuYWdlbWVudC4gVGhlIFZGSU9Db250YWluZXJPcHMNCj4+Pj4gaW1wbGVtZW50
cyBjYWxsYmFja3MgdGhhdCBkZXBlbmQgb24gdGhlIGtlcm5lbCB1c2VyIHNwYWNlIGJlaW5nIHVz
ZWQuDQo+Pj4+DQo+Pj4+ICdjb21tb24uYycgYW5kIHZmaW8gZGV2aWNlIGNvZGUgb25seSBtYW5p
cHVsYXRlcyB0aGUgYmFzZSBjb250YWluZXIgd2l0aA0KPj4+PiB3cmFwcGVyIGZ1bmN0aW9ucyB0
aGF0IGNhbGxzIHRoZSBmdW5jdGlvbnMgZGVmaW5lZCBpbiBWRklPQ29udGFpbmVyT3BzQ2xhc3Mu
DQo+Pj4+IEV4aXN0aW5nICdjb250YWluZXIuYycgY29kZSBpcyBjb252ZXJ0ZWQgdG8gaW1wbGVt
ZW50IHRoZSBsZWdhY3kgY29udGFpbmVyDQo+Pj4+IG9wcyBmdW5jdGlvbnMuDQo+Pj4+DQo+Pj4+
IEJlbG93IGlzIHRoZSBiYXNlIGNvbnRhaW5lci4gSXQncyBuYW1lZCBhcyBWRklPQ29udGFpbmVy
LCBvbGQgVkZJT0NvbnRhaW5lcg0KPj4+PiBpcyByZXBsYWNlZCB3aXRoIFZGSU9MZWdhY3lDb250
YWluZXIuDQo+Pj4NCj4+PiBVc3VhbHksIHdlIGludHJvZHVjZSB0aGUgbmV3IGludGVyZmFjZSBz
b2xlbHksIHBvcnQgdGhlIGN1cnJlbnQgbW9kZWxzDQo+Pj4gb24gdG9wIG9mIHRoZSBuZXcgaW50
ZXJmYWNlLCB3aXJlIHRoZSBuZXcgbW9kZWxzIGluIHRoZSBjdXJyZW50DQo+Pj4gaW1wbGVtZW50
YXRpb24gYW5kIHJlbW92ZSB0aGUgb2xkIGltcGxlbWVudGF0aW9uLiBUaGVuLCB3ZSBjYW4gc3Rh
cnQNCj4+PiBhZGRpbmcgZXh0ZW5zaW9ucyB0byBzdXBwb3J0IG90aGVyIGltcGxlbWVudGF0aW9u
cy4NCj4+DQo+PiBOb3Qgc3VyZSBpZiBJIHVuZGVyc3RhbmQgeW91ciBwb2ludCBjb3JyZWN0bHku
IERvIHlvdSBtZWFuIHRvIGludHJvZHVjZQ0KPj4gYSBuZXcgdHlwZSBmb3IgdGhlIGJhc2UgY29u
dGFpbmVyIGFzIGJlbG93Og0KPj4NCj4+IHN0YXRpYyBjb25zdCBUeXBlSW5mbyB2ZmlvX2NvbnRh
aW5lcl9pbmZvID0gew0KPj4gICAgICAucGFyZW50ICAgICAgICAgICAgID0gVFlQRV9PQkpFQ1Qs
DQo+PiAgICAgIC5uYW1lICAgICAgICAgICAgICAgPSBUWVBFX1ZGSU9fQ09OVEFJTkVSLA0KPj4g
ICAgICAuY2xhc3Nfc2l6ZSAgICAgICAgID0gc2l6ZW9mKFZGSU9Db250YWluZXJDbGFzcyksDQo+
PiAgICAgIC5pbnN0YW5jZV9zaXplICAgICAgPSBzaXplb2YoVkZJT0NvbnRhaW5lciksDQo+PiAg
ICAgIC5hYnN0cmFjdCAgICAgICAgICAgPSB0cnVlLA0KPj4gICAgICAuaW50ZXJmYWNlcyA9IChJ
bnRlcmZhY2VJbmZvW10pIHsNCj4+ICAgICAgICAgIHsgVFlQRV9WRklPX0lPTU1VX0JBQ0tFTkRf
T1BTIH0sDQo+PiAgICAgICAgICB7IH0NCj4+ICAgICAgfQ0KPj4gfTsNCj4+DQo+PiBhbmQgYSBu
ZXcgaW50ZXJmYWNlIGFzIGJlbG93Og0KPj4NCj4+IHN0YXRpYyBjb25zdCBUeXBlSW5mbyBudnJh
bV9pbmZvID0gew0KPj4gICAgICAubmFtZSA9IFRZUEVfVkZJT19JT01NVV9CQUNLRU5EX09QUywN
Cj4+ICAgICAgLnBhcmVudCA9IFRZUEVfSU5URVJGQUNFLA0KPj4gICAgICAuY2xhc3Nfc2l6ZSA9
IHNpemVvZihWRklPSU9NTVVCYWNrZW5kT3BzQ2xhc3MpLA0KPj4gfTsNCj4+DQo+PiBzdHJ1Y3Qg
VkZJT0lPTU1VQmFja2VuZE9wc0NsYXNzIHsNCj4+ICAgICAgSW50ZXJmYWNlQ2xhc3MgcGFyZW50
Ow0KPj4gICAgICBWRklPRGV2aWNlICooKmRldl9pdGVyX25leHQpKFZGSU9Db250YWluZXIgKmNv
bnRhaW5lciwgVkZJT0RldmljZSAqY3Vycik7DQo+PiAgICAgIGludCAoKmRtYV9tYXApKFZGSU9D
b250YWluZXIgKmNvbnRhaW5lciwNCj4+ICAgICAgLi4uLi4uDQo+PiB9Ow0KPj4NCj4+IGFuZCBs
ZWdhY3kgY29udGFpbmVyIG9uIHRvcCBvZiBUWVBFX1ZGSU9fQ09OVEFJTkVSPw0KPj4NCj4+IHN0
YXRpYyBjb25zdCBUeXBlSW5mbyB2ZmlvX2xlZ2FjeV9jb250YWluZXJfaW5mbyA9IHsNCj4+ICAg
ICAgLnBhcmVudCA9IFRZUEVfVkZJT19DT05UQUlORVIsDQo+PiAgICAgIC5uYW1lID0gVFlQRV9W
RklPX0xFR0FDWV9DT05UQUlORVIsDQo+PiAgICAgIC5jbGFzc19pbml0ID0gdmZpb19sZWdhY3lf
Y29udGFpbmVyX2NsYXNzX2luaXQsDQo+PiB9Ow0KPj4NCj4+IFRoaXMgb2JqZWN0IHN0eWxlIGlz
IHJlamVjdGVkIGVhcmx5IGluIFJGQ3YxLg0KPj4gU2VlIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2t2bS8yMDIyMDQxNDEwNDcxMC4yODUzNC04LXlpLmwubGl1QGludGVsLmNvbS8NCj4NCj5vdWNo
LiB0aGlzIGlzIGxvbmcgYWdvIGFuZCBJIHdhcyBub3QgYXdhcmUgOi8gQmFyZSB3aXRoIG1lLCBJ
IHdpbGwNCj5wcm9iYWJseSBhc2sgdGhlIHNhbWUgcXVlc3Rpb25zLiBOZXZlcnRoZWxlc3MsIHdl
IGNvdWxkIGltcHJvdmUgdGhlDQo+Y292ZXIgYW5kIHRoZSBmbG93IG9mIGNoYW5nZXMgaW4gdGhl
IHBhdGNoc2V0IHRvIGhlbHAgdGhlIHJlYWRlci4NCg0KU3VyZS4NCg0KPg0KPj4+IHNwYXByIHNo
b3VsZCBiZSB0YWtlbiBjYXJlIG9mIHNlcGFyYXRseSBmb2xsb3dpbmcgdGhlIHByaW5jaXBsZSBh
Ym92ZS4NCj4+PiBXaXRoIG15IFBQQyBoYXQsIEkgd291bGQgbm90IGV2ZW4gcmVhZCBzdWNoIGEg
bWFzc2l2ZSBjaGFuZ2UsIHRvbyByaXNreQ0KPj4+IGZvciB0aGUgc3Vic3lzdGVtLiBUaGlzIHBh
dGggd2lsbCBuZWVkIChtdWNoKSBmdXJ0aGVyIHNwbGl0dGluZyB0byBiZQ0KPj4+IHVuZGVyc3Rh
bmRhYmxlIGFuZCBhY2NlcHRhYmxlLg0KPj4NCj4+IEknbGwgZGlnZ2luZyBpbnRvIHRoaXMgYW5k
IHRyeSB0byBzcGxpdCBpdC4NCj4NCj5JIGtub3cgSSBhbSBhc2tpbmcgZm9yIGEgbG90IG9mIHdv
cmsuIFRoYW5rcyBmb3IgdGhhdC4NCg0KTnAsIGFsbCBjb21tZW50cywgc3VnZ2VzdGlvbnMsIGV0
YyBhcmUgYXBwcmVjaWF0ZWQg8J+Yig0KDQo+DQo+PiBNZWFud2hpbGUsIHRoZXJlIGFyZSBtYW55
IGNoYW5nZXMNCj4+IGp1c3QgcmVuYW1pbmcgdGhlIHBhcmFtZXRlciBvciBmdW5jdGlvbiBuYW1l
IGZvciBjb2RlIHJlYWRhYmlsaXR5Lg0KPj4gRm9yIGV4YW1wbGU6DQo+Pg0KPj4gLWludCB2Zmlv
X2RtYV91bm1hcChWRklPQ29udGFpbmVyICpjb250YWluZXIsIGh3YWRkciBpb3ZhLA0KPj4gLSAg
ICAgICAgICAgICAgICAgICByYW1fYWRkcl90IHNpemUsIElPTU1VVExCRW50cnkgKmlvdGxiKQ0K
Pj4gK3N0YXRpYyBpbnQgdmZpb19sZWdhY3lfZG1hX3VubWFwKFZGSU9Db250YWluZXIgKmJjb250
YWluZXIsIGh3YWRkciBpb3ZhLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2Fk
ZHJfdCBzaXplLCBJT01NVVRMQkVudHJ5ICppb3RsYikNCj4+DQo+PiAtICAgICAgICByZXQgPSB2
ZmlvX2dldF9kaXJ0eV9iaXRtYXAoY29udGFpbmVyLCBpb3ZhLCBzaXplLA0KPj4gKyAgICAgICAg
cmV0ID0gdmZpb19nZXRfZGlydHlfYml0bWFwKGJjb250YWluZXIsIGlvdmEsIHNpemUsDQo+Pg0K
Pj4gTGV0IG1lIGtub3cgaWYgeW91IHRoaW5rIHN1Y2ggY2hhbmdlcyBhcmUgdW5uZWNlc3Nhcnkg
d2hpY2ggY291bGQgcmVkdWNlDQo+PiB0aGlzIHBhdGNoIGxhcmdlbHkuDQo+DQo+Q2xlYW51cHMs
IHJlbmFtZXMsIHNvbWUgY29kZSByZXNodWZmbGluZywgYW55dGhpbmcgcHJlcGFyaW5nIGdyb3Vu
ZCBmb3INCj50aGUgbmV3IGFic3RyYWN0aW9uIGlzIGdvb2QgdG8gaGF2ZSBmaXJzdCBhbmQgY2Fu
IGJlIG1lcmdlZCB2ZXJ5IHF1aWNrbHkNCj5pZiB0aGVyZSBhcmUgbm8gZnVuY3Rpb25hbCBjaGFu
Z2VzLiBJdCByZWR1Y2VzIHRoZSBvdmVyYWxsIHBhdGNoc2V0IGFuZA0KPmVhc2UgdGhlIGNvbWlu
ZyByZXZpZXdzLg0KPg0KPllvdSBjYW4gc2VuZCBzdWNoIHNlcmllcyBpbmRlcGVuZGVudGx5LiBU
aGF0J3MgZmluZS4NCg0KR290IGl0Lg0KDQo+DQo+Pg0KPj4+DQo+Pj4gQWxzbywgcGxlYXNlIGlu
Y2x1ZGUgdGhlIC5oIGZpbGUgZmlyc3QsIGl0IGhlbHBzIGluIHJlYWRpbmcuDQo+Pg0KPj4gRG8g
eW91IG1lYW4gdG8gcHV0IHN0cnVjdCBkZWNsYXJhdGlvbiBlYXJsaWVyIGluIHBhdGNoIGRlc2Ny
aXB0aW9uPw0KPg0KPkp1c3QgYWRkIHRvIHlvdXIgLmdpdGNvbmZpZyA6DQo+DQo+W2RpZmZdDQo+
CW9yZGVyRmlsZSA9IC9wYXRoL3RvL3FlbXUvc2NyaXB0cy9naXQub3JkZXJmaWxlDQo+DQo+SXQg
c2hvdWxkIGJlIGVub3VnaA0KDQpVbmRlcnN0b29kLg0KDQo+DQo+Pj4gSGF2ZSB5b3UgY29uc2lk
ZXJlZCB1c2luZyBhbiBJbnRlcmZhY2VDbGFzcyA/DQo+Pg0KPj4gU2VlIGFib3ZlLCB3aXRoIG9i
amVjdCBzdHlsZSByZWplY3RlZCwgaXQgbG9va3MgaGFyZCB0byB1c2UgSW50ZXJmYWNlQ2xhc3Mu
DQo+DQo+SSBhbSBub3QgY29udmluY2VkIGJ5IHRoZSBRT00gYXBwcm9hY2guIEkgd2lsbCBkaWcg
aW4gdGhlIHBhc3QgYXJndW1lbnRzDQo+YW5kIGxldCdzIHNlZSB3aGF0IHdlIGNvbWUgd2l0aC4N
Cg0KVGhhbmtzIGZvciB5b3VyIHRpbWUuDQoNCkJScy4NClpoZW56aG9uZw0KDQo=

