Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 965377DC474
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 03:30:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxeWW-0002rD-Hl; Mon, 30 Oct 2023 22:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxeWU-0002qw-GW
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 22:30:30 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxeWS-0005NY-Jz
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 22:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698719428; x=1730255428;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Tw2lq5/H1hXvnkBFuyIJLQbHaf9hL2lYmDBDq1goA9Q=;
 b=WC1IYxm/N6E/qdHtYf25yppV2WOWBKAUJjGyPgIRbyFmLQJ+2StY+0Kg
 qdGYi3+Rb6pOO/3nsWyMqiHBZ8v/zjCnunsze+9fRuRcbNzXPWNG1l9a8
 YqhTYKAL4CoxbsgZvzLNe/XvUBk6ASyeOOsdwjr+Pap238jq96U+cGAuz
 LMJpS39ma1iCHIMJEblPUa8juLuvpk1fLW2ItdYvYcTvaRgSSNnOvDpSG
 JsHL3KDqfV1DA9QBpVunYTBlYJpjyDwxDxeCkTU773og887t6f7w6iNE8
 kBVFFIBjoAKsh/f2dYhmqIPpwXkZ2iG/bJat7RTjNoqMH5j5PzSRk/nsB w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="1077429"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; 
   d="scan'208";a="1077429"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2023 19:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="884066740"
X-IronPort-AV: E=Sophos;i="6.03,264,1694761200"; d="scan'208";a="884066740"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 30 Oct 2023 19:30:25 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:30:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 19:30:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 19:30:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 19:30:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icB1PfFumN4JzHsoZP2yLEGMDPCMzmwo/cLdL7vjuJJAKaHiltoedshKsJwNO9opKf88J/xLKAVrsui/vbh8X1rNtx09fpKG1JNw3yAka4Bl1Xzs/agLHLbROKK5bOkGBx7Noti8rOOLybFIT86HalWTfhU8bVALzI/JZKYKc0NsMcFtwbAebI5Awth5lLBuiXhuChWb7ubSXwCWVg+Csr6Bk0dVBZmeYjQl9nD+Wfwm6MzJfifTQRTknKPdP3iz05YfL8XCAUJeTnYKEdbmTf56yCxDJ8bwRAYgQ9JVLO8O9rpdl21qesyDSTXJMe5Q729TjisoY1LaujiLGMbK8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw2lq5/H1hXvnkBFuyIJLQbHaf9hL2lYmDBDq1goA9Q=;
 b=SNlAd3ay6aVnFusvN9wWxMWuRqH8objZuNROv+oQdXxAu1hOJZSgbL2Cl7wLRdNKTGwK/X0HJzgZrh+erWDfMBr2iB2z6bwmHm7fVb8SWQOQRHELW6FmyJUKhlj9yukhBWZygyiYuUplEnvNfUe2LCIWeqaZWpGMLJFW8e0pAzsRFOLpQ17lrRPofId/Pd2KGwwPESiYVi7SSY8EQT+UmGrzSJK2JDHU10HpsBCH6DBCdTTlbJGjaVt1lYt02wWux9+O0Dm1N3lF8zBzLL0oNL17Hb3fCqhqkl3X9WRZxhPwjdwYhwsoGTH2be40QK0SIS/3dWIclXiaDvHl2DdD1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB6611.namprd11.prod.outlook.com (2603:10b6:510:1ce::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 02:30:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.028; Tue, 31 Oct 2023
 02:30:10 +0000
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
Subject: RE: [PATCH v3 30/37] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Thread-Topic: [PATCH v3 30/37] vfio/pci: Extract out a helper
 vfio_pci_get_pci_hot_reset_info
Thread-Index: AQHaB/nvMJOIJJdj5Emq07dHY/MFfLBiYr+AgADQ+rA=
Date: Tue, 31 Oct 2023 02:30:10 +0000
Message-ID: <SJ0PR11MB674463ED2E9AE9BB2BCCD96092A0A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-31-zhenzhong.duan@intel.com>
 <8127aa87-c946-4db1-b4ae-cdfced09d157@redhat.com>
In-Reply-To: <8127aa87-c946-4db1-b4ae-cdfced09d157@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB6611:EE_
x-ms-office365-filtering-correlation-id: 2d509ef8-7820-4b3d-7122-08dbd9b94e55
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BBkMcZVaGAy4xV9UYF9ByY25OBjFKdi6nggT9RhSzsPr4zn5L+QYX41eMvZpflH2PN2z1y2mxyXCJ8F+kSC5O/4o8eIFkhQyJ9rsSVsOfFxpVcHSS7Pfa6VImJ7LPqoEfHrBqX9wETS6qd98hiNHWp5jYGZk9wGeDY7w5O6egbfNTvKefvr0+6NnAcUp+gsOeeQnk2EpQE+c4gTbPkyWTNm7C6D5qKDKTtbR4mvDIvKNmy+y84GurlZpeicP9UX21MbMqZKSfWrpPfBMqOg/kwliz1Irn0smPOjkXU4PyV2j/8nVrthO1K9zvFWrkLhiMZykTCqrUWtqQXE4UWPEpGgA+cFtW/W9YHrCIoxT4zlDozGVzURXjJazM6FpOhRPqMa+91XWwiOWpSYlIXCl11EzGe2E8KlHifC2bsJkVFPPfHIFL0rJISWH5FDkxwyCS5WhgID2avTtd4WRbkZsW8QypEoOoN/5mtzOrC2IeHwUSIj38gIOQ6FJS2OAkx6xUzAgy/7hUxbbSNA91JGxXyazD9IFTHZH2d+UClYcQFRgaxKYcfamzrQoPdkP2wAu2HtwHiu1d9qkyGgZiSMNNFRRPWCooBxpG5rXoDZp2rZ+7weD9ofU4v1opKk3OTyeSXHtiUXD1QMSZWgLJhDHaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(122000001)(9686003)(71200400001)(7696005)(6506007)(82960400001)(110136005)(33656002)(26005)(66556008)(316002)(66476007)(54906003)(64756008)(478600001)(66446008)(55016003)(66946007)(83380400001)(107886003)(66574015)(38100700002)(76116006)(86362001)(8936002)(38070700009)(41300700001)(2906002)(8676002)(4326008)(4744005)(52536014)(5660300002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azhkQk11TDhHTDZmWjlsYnQvZ01nV2IrRVpCTzdLK0RHaGZDakZ5V2RxaDFJ?=
 =?utf-8?B?bXYyWnVWWFJDUmRWK2lpdTlPV0tUVXZkNFRBb3NKVXliRnVUcVQ4Nkp2SVFV?=
 =?utf-8?B?ZEJXeGlsK204OGxFWWJXZm1PNGRKYThvNlVPRDB1QUFIS2N4ZzJMTU8yaS9Q?=
 =?utf-8?B?ZkU3bnFEcHRvbEtNN3RQdGdKN3BuVktqR0ZEYmppNVpBdUs2ZU4rL0NRSXNG?=
 =?utf-8?B?T1phRDVuYVhnN1dTVFoyOTlRL2czTC9IRFcxYm9sQzBDTmdubWFZZDh0TGJy?=
 =?utf-8?B?VGlqWXN1VjNwZGlxcmlxdWM2cTlZVGhrMXVyV2tvYnpCaWV2TzZyVlk5QVBw?=
 =?utf-8?B?YXdkb0swVGpRdmtndCsrQmlRTEI0eGpCSERBbTN5TERncmlFcU5vTWxKRVBl?=
 =?utf-8?B?OGk1STNVTitWWEZncStYdk1NQ0Nsd3JRWWRhMHgvbVpEZGZUSjNJMFRnQitF?=
 =?utf-8?B?TFlNbVNNZWlJeU8yUmUrSWJ1U1hFc3lJWEpMRjhXdWdpQ3F2OWtoOUdza0Jn?=
 =?utf-8?B?VUVDV216SXZOdlhJei9ZcVpXNEpLdmdHWjRCSFFITFdFaXhIbm5BYThnZi9t?=
 =?utf-8?B?MlcwbHNLTmVTcFdrQ0dnbEZ0N0dGbHlUUWV6aTR2TVBsU1ZISGQ4TkI1dEVS?=
 =?utf-8?B?VXNmdE53M3c2andJMitPdkx6TWQrNFZBZkM4Q1drREdFd2JaQ2Q0UmowTTdo?=
 =?utf-8?B?QmZjUk9XYUdZR1FvRUUwVkJhRkx6QUM4VW9vUDRNa2tUK0dQVW0rVDlveWJr?=
 =?utf-8?B?ck85Z0p6a1RScHRmbC9lNkRHMlhNTFVMSm55Qm81dk1zR1liK2VEdFZ2cENm?=
 =?utf-8?B?c3h5NU90T2xtZjJyOElpU3RIN0dUanZaQlJsY21xYjIyOEU3UGJudkRPM25x?=
 =?utf-8?B?TUZoWXo2Z200VG9hUEJrRURrK2tMUnhldXN3cUFaNEpyZTZ0OEtTaDBZZ1BQ?=
 =?utf-8?B?QVdnanQ2Tnp3bGRTQUUzWXdFY1hRekd2NGs4Z1duMmF4T0h5UzR5TWU5NEla?=
 =?utf-8?B?WUZhZmdOZXptb2JDQlZ1bm4veW9BeUF4ZGd1MHBGK1BiekRFTDZsbDJYbXdP?=
 =?utf-8?B?Unl6NXVUSER0QjRZR0c0cUN1YkY5L1lncmhMMWJEQVVzcjM0N2VLMmljcENF?=
 =?utf-8?B?V3V6a1IxU2U1cXJFN1FCVXhYYnp4eDVleHZhZWV4WUxmeGY4ckEwZXNpa3Vj?=
 =?utf-8?B?dkZkOU91K2pYM21Qd1p2YjZTZ2FsSTdTRkhobCtlSmthT0tZT0Q5UFA0R3lo?=
 =?utf-8?B?WngxSkZOaWpTTTlIMytwRVkyVEdHWFQ4em4xSjExWHNmVUdVRG9wRWJ6M2x4?=
 =?utf-8?B?dFoyRFZHYjlXQWp5OVJkQVUvOVhLUityUWhXbXV6MjZGM2Fid3ErMEJsWUly?=
 =?utf-8?B?V0RyMkFEdUszdENndHI2cWpjdWMwZnFaTk5CWmpCVXFUalU1YUVCVzkrRU85?=
 =?utf-8?B?eUpDdVN1M0Q0MCtwa2txZnB4eks4UUhaVHhjN2FwelA3bFhEQVI2RlJFRmcy?=
 =?utf-8?B?MExBTGF5Q3lWWTNHejMzcXVINEdhY3JTTjFVOTJhQlI5MHpKQzl4aTdqL05s?=
 =?utf-8?B?enNXWVk5VEliOXduUWtTVHRJTXFYNE1lSTRPeFBORmUvTHhGdllhK2xBYlBw?=
 =?utf-8?B?TkwvTFE2c3JLTnJFTVRlS1NGQU9vaTVCVnkvMm5JQTc3UE9oSFhIOVgxZURE?=
 =?utf-8?B?VFVOVmIrSW1TZmR4RFdqZ2hwaWNURm5idFQvNW9YOUp2ZVRsQlJYUUxEUHdJ?=
 =?utf-8?B?cStLYit3M3dpdmhYZlJPQlZiTW90cFdZMVJGRC8rVXAza2VIR21qVTNZMis0?=
 =?utf-8?B?cUViZ0dWa2xRRG5iQURIVjl1VklBNUo1VzRqUTVzSHNWUWRiOXhkSG1SV2Zm?=
 =?utf-8?B?djc1Mm9QM05nanFIaytva1JNU0FzdHM5dWcvN0FqODRUbE9ydCtadVZ5ZE5R?=
 =?utf-8?B?bm1sZHhyMVU5WElkNUhFVXpUUU9zeW15TDMrWm9URFpFZXlaY1YvcjJGT0Uz?=
 =?utf-8?B?bE5iZVFMNHFNOVQwR2dXNTFCK0lRVTQ0enNqUExFY0hJOGtBbm1CMEJJWE1O?=
 =?utf-8?B?MzY5YTFxOTVLWjR0aGJNT2tHTmhzOHg4VFR1VFo0VTV1Zm9obVYvVlZxV2RS?=
 =?utf-8?Q?e0cF0bwQhejY/lX9zUqwLCybF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d509ef8-7820-4b3d-7122-08dbd9b94e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 02:30:10.9454 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeMpdBv9aTVCpJf2DNBAiPnAh8nkwcoII9ZT8oKwI8BxOVj7L8U1chNdg9Nye5FhwvQzQQKWpo8pSyYKrFNYNlKuHyyiagpG0aVaFYWfkYY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6611
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgMzAsIDIwMjMgMTA6MDAg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDMwLzM3XSB2ZmlvL3BjaTogRXh0cmFjdCBvdXQg
YSBoZWxwZXINCj52ZmlvX3BjaV9nZXRfcGNpX2hvdF9yZXNldF9pbmZvDQo+DQo+T24gMTAvMjYv
MjMgMTI6MzAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gVGhpcyBoZWxwZXIgd2lsbCBiZSB1
c2VkIGJ5IGJvdGggbGVnYWN5IGFuZCBpb21tdWZkIGJhY2tlbmRzLg0KPj4NCj4+IE5vIGZ1bmN0
aW9uYWwgY2hhbmdlcyBpbnRlbmRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcg
RHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPg0KPkkgdGhpbmsgd2UgY2FuIG1lcmdl
IHRoaXMgY2hhbmdlIGJlZm9yZSBoYW5kLg0KDQpZZXMsIGJhc2VkIG9uIHlvdXIgc3VnZ2VzdGlv
biBpbiBwYXRjaDMxLCBJIHdpbGwgbW92ZSB0aGUgaGVscGVyIGZ1bmMNCmludG8gaHcvdmZpby9o
ZWxwZXJzLmMgYW5kIHRoZW4geW91IGNhbiBwaWNrIGl0IGluIHY0Lg0KDQpUaGFua3MNClpoZW56
aG9uZw0K

