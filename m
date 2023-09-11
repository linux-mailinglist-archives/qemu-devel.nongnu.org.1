Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30779A6FC
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 11:49:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfdXb-0006Ei-Pt; Mon, 11 Sep 2023 05:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfdXX-000646-RA
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:49:08 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfdXU-0005FI-Bl
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 05:49:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694425744; x=1725961744;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vasMd+4NseQnKlBZ2ksQdw2iqh9JXGt3FXsXSkSecUQ=;
 b=gd72MUqJXTcTQhAfU6dfli9C22grgEJvvvYDUcNlgQ4yk3QaRAb6RiiX
 lEPcs9GxqjOvaNPyi3i/qJBLD30oj/+RLfIFpjupayu9eYLvAIbUUZUnB
 kUS53SrOOOy1NtoQTS+yMFXAh3ygwWrGTqxi1WAfa1zVM2ZeG8l+GJVr8
 BT2B65poOm5fYH4c+9fVA3WA96edRiU6S0BjPckVXiVauhGbLDB2Y6+Vy
 sYlEQlyBBRStFw27b5kcQ8nK+LHeUFM8iKGUwfG2iOCzS1goSVvmri5mn
 zY1dEhYQ873GuSfDIELy4dtkMTAttiwJdqlHYTMX1FOLzUTfVX8I+V3Sc A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368281429"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="368281429"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 02:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="813303989"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="813303989"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Sep 2023 02:49:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 02:49:00 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 02:49:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 02:49:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e15YtlX1DiOz0MEniZ/8YzUpkBg893kJRY/2TM1I4kXThHmI7iJjQoARtx3BtYFhVKZeSuYkrLf5Ale2ndcKAUBXf4YT+cTCCSB7GoIlcPCspSBpuqNZrivwgtp6wXlI9msiALM6LVuYkn3k/RVxOBnVsquS6mVeONb1W91XZwoUwIg8rE0AmVbjT9FQhW4/6HYNtMiaIrbLPLGBSc7l11VDlhERHsjnWbaj8ee/2wQ/+N2bbnRj7+pHOFUOwKw+uGFqUAEfnldzXHkJqOe1T3nBj5c68W+wTKAHz+oQhYbuz+1lM/eveJb4/C8IjD+PGxnL+AH2ytmqlDM8Cb1SCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vasMd+4NseQnKlBZ2ksQdw2iqh9JXGt3FXsXSkSecUQ=;
 b=fKldqWfN9ULlyKSYR8tTt2qyCSb7cwWcJYk06xWrPsuGqV/DNW7sbEHtzqfRV+LtQvKTB28HzqCLut5Z83OdXt4gdd9690fTJzri1YMqrLvU231/vO7S1W1x5Yy/1Z2vZaRtjqUGXOHiPKyFskOyE3OAHW6LKFOOLDvONUh209O0hT/3/nrSF8hPySqlIYyZysUI0aY2ZRjPAz7wepmWzYHj5AbBJGQVFDHCfaWCOeaJWSuwLzHLioUogSqNmQE3OaJz7oDAkt29y5HSVnc28BFGwaTr1sIJ8AQg6jYqIqrYLu8AUD8iQ4oDizt/5X/pCyUNDeSxhuqio5T6qpCNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6473.namprd11.prod.outlook.com (2603:10b6:510:1f3::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36; Mon, 11 Sep
 2023 09:48:58 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 09:48:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Subject: RE: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Topic: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Index: AQHZ4tZ5L57QHMgEL06JAtdqYWcKlbAVVWmwgAADeQCAAAcVkA==
Date: Mon, 11 Sep 2023 09:48:58 +0000
Message-ID: <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
In-Reply-To: <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6473:EE_
x-ms-office365-filtering-correlation-id: 49c4f06e-5487-4b2e-b712-08dbb2ac5220
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WNc6A7Ztkns5OFWb4QaKXnhAUtoUw1O+oyDBmLGz4SeqUEyyD3Smc0a/LHOsGoMzqHCxXZcNbYiZ+J2+f2Fn4fAbgmVO9hgz1k1haUwrNvsyCDL9OEHq2eW2aEgwDyt4R4/D48MavBSr7PGHT0e/Zbb6cWHm4FMxe+dCT1IcZDl+qbVtehGFyw5gwhJbJCt9jghLcdnrVj5qLZ8lVZso8EAGIkiEnaqUpZ1/OIQ3/jqDv0C3an+rIc/kj4crWAt9F1SQSBNW0QsZaWzxHbvQKuxhw98SyKByqJWWIEB5ugt2H6wnOPBk3NsC4wvc8NEtG/v4HcrOdmklzRhsSR3EP0Fjok6KkqbUCOLdv5vRrXHTz5lvyQEc1UE9kA5UKCh912nk8ORaeoaUyhJ/5bJXEn6ig3Gk+f/osk42TZ/hJHW74ran1Q7NMq1Etxx3J1R7Kso842PZ5e9EfFlUkkWrM+oSukpf4U9yyr6RQr7elCsvv0TrYbLWMKAdUKNjJH3Pobef/FnZ5UQO+4yaGUMN4TXIeon6ktKUQjkKUe9wgl2sElI0PoPkkzsXcx/kdSLnGIKZsWBGsifYMQSBiM6H+Att48cHLh4XMHpNGnoqLql3v9PYnMRbNMHMtW/y6ZeQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(451199024)(186009)(71200400001)(53546011)(6506007)(7696005)(478600001)(9686003)(83380400001)(66574015)(26005)(2906002)(66946007)(66446008)(66556008)(316002)(64756008)(54906003)(5660300002)(4326008)(41300700001)(52536014)(8676002)(66476007)(8936002)(38070700005)(33656002)(55016003)(86362001)(38100700002)(110136005)(76116006)(122000001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0RGUGVvL09MdGhaWW5vVXJDOExybHBSdHRCQzlZNVRWMlNnUll3UnVCWm5C?=
 =?utf-8?B?RHlqVlo4emUwcVdpRXEzSE5scjVZT2JKSEhQQzNJaCtZVEZMUkE5TXNFaU9H?=
 =?utf-8?B?cHQ1RVRIK20zZ0NPcng0b1d3VVg4aHlhQWc2TzBkU2hjL3ZlUzAwaENiSWc5?=
 =?utf-8?B?dldEVkQzbnR5UTdPTWxPaHlqbXdFcXN1ZVBGbTRZRUhEN3F1cWJXQ0VWdURM?=
 =?utf-8?B?QXl3MUVkR2R2b0wvMWdkUVc0UGFxVEJEU200UDZtQmhRcDZ0UkNVSjNSbkxu?=
 =?utf-8?B?VVZvVGVidFBTVUtKTytBaG9sUDM1bzBncjFZU1VGYXM4TGhrSUQva0FodXFQ?=
 =?utf-8?B?WlRNOCtteERrRzM2SmFWSEtKdFdrbGVhd1BiOUlJR3BaUkRSZVFlQlloSjJk?=
 =?utf-8?B?RnE5aTRvaitRWkRpVE5LRFhyY3NSdHV4K0tpdVJlVVFTc2ZMRkpsbDA5T0p3?=
 =?utf-8?B?NkJvRlNIVVdjRGZ1M2JnREhHZmdweUZVNTVMeGdja2hrZ2pMa0ZGSXhWRm1C?=
 =?utf-8?B?akFhQzExdnQ3UXN6K3VvMUtrdjBaUTFpeVRKME1ub21XMG8rc1hYT3huSFNQ?=
 =?utf-8?B?bzNvMm5Fc3N1a2xMbjg0SzBzNWxKajRBcHpTaC92ZEJsS3kraWtrNHI2YUVN?=
 =?utf-8?B?eWFob0ZBb3hxRUVadUg3R1g4SFgyN01idHlTcHRPNmpkK3BxRHRZMCtvc0dv?=
 =?utf-8?B?YytPQldkbno5eGhoUEpiQWR4djF4elg5TlVhWG1vN3RkYXBGd3BKVVYwRmJY?=
 =?utf-8?B?eEdEMDlCWjNwblZld2NjVUFQU1lTSGRJWmVtQ2tVdFJndHhhLzkzRFVvcnlQ?=
 =?utf-8?B?NGtYQ05TcUJNbFVyRG5sLzdhTUk1bmg3ZU53OVMwNnh5RElCYmRCay9PMnpE?=
 =?utf-8?B?NEJGMlNic0F1blJ2cFJjRGd6ckhyWUcxUW4zcGR6WU4zZ3hHbFY3NnplTUtB?=
 =?utf-8?B?dmpWYzArY2VYNTBzOVJRekhuWVYvOG1IY0Q4KzA5b0FudERaNVk4cGFtOEZL?=
 =?utf-8?B?RHNZbldNbHU3TW03dVlnV0hPejhwM0RvdHpvR2t4WVp2QmRQYUFkZnVXM3pm?=
 =?utf-8?B?Vjk4L0dDclIyNzVXUTMwUjdHWWdpdGhlNWtsblRKQjVSWGdJZ3JJc2Jkdi9t?=
 =?utf-8?B?RnRhV1ptZXkvL01KSjJkZEtxWmQ3WFFLUUNPYklVYXhJamNsQStwWDRyY0lO?=
 =?utf-8?B?MXFwdlEyK25vTS9xa0llOEh0b0cyS1h2bkFOdDBWdHM1NlFYdmhwK1lmQXN5?=
 =?utf-8?B?clNlYjJ5NStsUjF2SDBDMzMvcUg2MjV1M3pkcVdEMGlUZnoyQWNCdEdVUlIx?=
 =?utf-8?B?VzVaN0FpVTVZRnZjVHhHam5obTkxL0JXd1M4Vnh5QmFpS1VrQnFPMTY3c01F?=
 =?utf-8?B?MjNlc0JzVGRJMHg2TmcvWFREbkwwMnorUjZvVWZNMmt5V0d2akVRUi9IT1dl?=
 =?utf-8?B?TEFZSjBNZ2lzbm0rUmk5U1BvdGt4enhMSUI4emVPWVo5aXRGbitlV2gyWXNv?=
 =?utf-8?B?bUJ4RTZobmJrTytJQXR5Tjc1YXVLcWYwRDF0K2QzaGhFeWlqSnlXTFU4a0V0?=
 =?utf-8?B?RE4rVW5YRFRySVl5blBtd2NFb1RWU2FLZ2NQZEVWTnhvWW9vQlUyTGJoWHcy?=
 =?utf-8?B?UmxSV2U1dEQ1MVVaYkRIWUtUemhQb25OSTdWeUMrQjNRamczWWdQTXZwUkZQ?=
 =?utf-8?B?OWpyZDErcTBmcmVqM2FJRWR4YVR2Y3grNkhLb1Ntc3hZbXdrV0JBR1BaNG13?=
 =?utf-8?B?RlN5OEZkQnhFdTVPVDhSeGJDOFFwcUlmemZVTVNSQXNJQkdKYlhCMnZvVmNl?=
 =?utf-8?B?TUZHenlkZ1BEeEFhNkJnZ29YMWJ5YzdUVThhb1oxUndpV1l1Wk1pWVNCVk92?=
 =?utf-8?B?VlUweGdmV2VwMUN6c21EZzhRTEY0YXdrSEpRcmJGbytJaG9HNnJja1ZRMGYx?=
 =?utf-8?B?dHU0bEtnWE9RN3lJTVVFVEVhQXVzK1FaOEdZN2laNUNkOUlWb04zWmt6VFNW?=
 =?utf-8?B?ZGN1K3FDUTVHazAxZms1TjJWWjhmRHd0VWtwT21pSWhYejU0cTZ4bTh2NEs5?=
 =?utf-8?B?RjhnMHQyTlNPcWMrVlI1Skp3bGJUd0VHclN5aUdGTzM1Rkk0d2RVK1ZEM3hC?=
 =?utf-8?Q?tAXmm0NB+j1YcIYbD0wT+K4Vk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49c4f06e-5487-4b2e-b712-08dbb2ac5220
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 09:48:58.4948 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i7ZhgApHkJ+OyoSxbDKWhp4rWYeo8X5zlFMAckbeC6CZ5jaxxv56bgvwUO3H3TejOnU3tDwtaBkKlmYY8jIzMnrJuJkMmLLImj9rGVtXp3s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6473
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBNb25kYXksIFNlcHRlbWJlciAxMSwgMjAy
MyA1OjA3IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MV0gdmZpby9jb21tb246IFNlcGFyYXRl
IHZmaW8tcGNpIHJhbmdlcw0KPg0KPk9uIDExLzA5LzIwMjMgMDk6NTcsIER1YW4sIFpoZW56aG9u
ZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IHFlbXUt
ZGV2ZWwtYm91bmNlcyt6aGVuemhvbmcuZHVhbj1pbnRlbC5jb21Abm9uZ251Lm9yZyA8cWVtdS0N
Cj4+PiBkZXZlbC1ib3VuY2VzK3poZW56aG9uZy5kdWFuPWludGVsLmNvbUBub25nbnUub3JnPiBP
biBCZWhhbGYgT2YgSm9hbw0KPj4+IE1hcnRpbnMNCj4+PiBTZW50OiBGcmlkYXksIFNlcHRlbWJl
ciA4LCAyMDIzIDU6MzAgUE0NCj4+PiBTdWJqZWN0OiBbUEFUQ0ggdjFdIHZmaW8vY29tbW9uOiBT
ZXBhcmF0ZSB2ZmlvLXBjaSByYW5nZXMNCj4+Pg0KPj4+IFFFTVUgY29tcHV0ZXMgdGhlIERNQSBs
b2dnaW5nIHJhbmdlcyBmb3IgdHdvIHByZWRlZmluZWQgcmFuZ2VzOiAzMi1iaXQNCj4+PiBhbmQg
NjQtYml0LiBJbiB0aGUgT1ZNRiBjYXNlLCB3aGVuIHRoZSBkeW5hbWljIE1NSU8gd2luZG93IGlz
IGVuYWJsZWQsDQo+Pj4gUUVNVSBpbmNsdWRlcyBpbiB0aGUgNjQtYml0IHJhbmdlIHRoZSBSQU0g
cmVnaW9ucyBhdCB0aGUgbG93ZXIgcGFydA0KPj4+IGFuZCB2ZmlvLXBjaSBkZXZpY2UgUkFNIHJl
Z2lvbnMgd2hpY2ggYXJlIGF0IHRoZSB0b3Agb2YgdGhlIGFkZHJlc3MNCj4+PiBzcGFjZS4gVGhp
cyByYW5nZSBjb250YWlucyBhIGxhcmdlIGdhcCBhbmQgdGhlIHNpemUgY2FuIGJlIGJpZ2dlciB0
aGFuDQo+Pj4gdGhlIGRpcnR5IHRyYWNraW5nIEhXIGxpbWl0cyBvZiBzb21lIGRldmljZXMgKE1M
WDUgaGFzIGEgMl40MiBsaW1pdCkuDQo+Pj4NCj4+PiBUbyBhdm9pZCBzdWNoIGxhcmdlIHJhbmdl
cywgaW50cm9kdWNlIGEgbmV3IFBDSSByYW5nZSBjb3ZlcmluZyB0aGUNCj4+PiB2ZmlvLXBjaSBk
ZXZpY2UgUkFNIHJlZ2lvbnMsIHRoaXMgb25seSBpZiB0aGUgYWRkcmVzc2VzIGFyZSBhYm92ZSA0
R0INCj4+PiB0byBhdm9pZCBicmVha2luZyBwb3RlbnRpYWwgU2VhQklPUyBndWVzdHMuDQo+Pj4N
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5j
b20+DQo+Pj4gWyBjbGc6IC0gd3JvdGUgY29tbWl0IGxvZw0KPj4+ICAgICAgIC0gZml4ZWQgb3Zl
cmxhcHBpbmcgMzItYml0IGFuZCBQQ0kgcmFuZ2VzIHdoZW4gdXNpbmcgU2VhQklPUyBdDQo+Pj4g
U2lnbmVkLW9mZi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IC0t
LQ0KPj4+IHYyOg0KPj4+ICogcy9taW5wY2kvbWlucGNpNjQvDQo+Pj4gKiBzL21heHBjaS9tYXhw
Y2k2NC8NCj4+PiAqIEV4cGFuZCBjb21tZW50IHRvIGNvdmVyIHRoZSBwY2ktaG9sZTY0IGFuZCB3
aHkgd2UgZG9uJ3QgZG8gc3BlY2lhbA0KPj4+ICBoYW5kbGluZyBvZiBwY2ktaG9sZTMyLg0KPj4+
IC0tLQ0KPj4+IGh3L3ZmaW8vY29tbW9uLmMgICAgIHwgNzEgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLS0NCj4+PiBody92ZmlvL3RyYWNlLWV2ZW50cyB8ICAyICst
DQo+Pj4gMiBmaWxlcyBjaGFuZ2VkLCA2MSBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkN
Cj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9jb21tb24u
Yw0KPj4+IGluZGV4IDIzNzEwMWQwMzg0NC4uMTM0NjQ5MjI2ZDQzIDEwMDY0NA0KPj4+IC0tLSBh
L2h3L3ZmaW8vY29tbW9uLmMNCj4+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+Pj4gQEAgLTI3
LDYgKzI3LDcgQEANCj4+Pg0KPj4+ICNpbmNsdWRlICJody92ZmlvL3ZmaW8tY29tbW9uLmgiDQo+
Pj4gI2luY2x1ZGUgImh3L3ZmaW8vdmZpby5oIg0KPj4+ICsjaW5jbHVkZSAiaHcvdmZpby9wY2ku
aCINCj4+PiAjaW5jbHVkZSAiZXhlYy9hZGRyZXNzLXNwYWNlcy5oIg0KPj4+ICNpbmNsdWRlICJl
eGVjL21lbW9yeS5oIg0KPj4+ICNpbmNsdWRlICJleGVjL3JhbV9hZGRyLmgiDQo+Pj4gQEAgLTE0
MDAsNiArMTQwMSw4IEBAIHR5cGVkZWYgc3RydWN0IFZGSU9EaXJ0eVJhbmdlcyB7DQo+Pj4gICAg
IGh3YWRkciBtYXgzMjsNCj4+PiAgICAgaHdhZGRyIG1pbjY0Ow0KPj4+ICAgICBod2FkZHIgbWF4
NjQ7DQo+Pj4gKyAgICBod2FkZHIgbWlucGNpNjQ7DQo+Pj4gKyAgICBod2FkZHIgbWF4cGNpNjQ7
DQo+Pj4gfSBWRklPRGlydHlSYW5nZXM7DQo+Pj4NCj4+PiB0eXBlZGVmIHN0cnVjdCBWRklPRGly
dHlSYW5nZXNMaXN0ZW5lciB7DQo+Pj4gQEAgLTE0MDgsNiArMTQxMSwzMSBAQCB0eXBlZGVmIHN0
cnVjdCBWRklPRGlydHlSYW5nZXNMaXN0ZW5lciB7DQo+Pj4gICAgIE1lbW9yeUxpc3RlbmVyIGxp
c3RlbmVyOw0KPj4+IH0gVkZJT0RpcnR5UmFuZ2VzTGlzdGVuZXI7DQo+Pj4NCj4+PiArc3RhdGlj
IGJvb2wgdmZpb19zZWN0aW9uX2lzX3ZmaW9fcGNpKE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rp
b24sDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWRklPQ29udGFp
bmVyICpjb250YWluZXIpDQo+Pj4gK3sNCj4+PiArICAgIFZGSU9QQ0lEZXZpY2UgKnBjaWRldjsN
Cj4+PiArICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2Ow0KPj4+ICsgICAgVkZJT0dyb3VwICpncm91
cDsNCj4+PiArICAgIE9iamVjdCAqb3duZXI7DQo+Pj4gKw0KPj4+ICsgICAgb3duZXIgPSBtZW1v
cnlfcmVnaW9uX293bmVyKHNlY3Rpb24tPm1yKTsNCj4+PiArDQo+Pj4gKyAgICBRTElTVF9GT1JF
QUNIKGdyb3VwLCAmY29udGFpbmVyLT5ncm91cF9saXN0LCBjb250YWluZXJfbmV4dCkgew0KPj4+
ICsgICAgICAgIFFMSVNUX0ZPUkVBQ0godmJhc2VkZXYsICZncm91cC0+ZGV2aWNlX2xpc3QsIG5l
eHQpIHsNCj4+PiArICAgICAgICAgICAgaWYgKHZiYXNlZGV2LT50eXBlICE9IFZGSU9fREVWSUNF
X1RZUEVfUENJKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsNCj4+PiArICAgICAg
ICAgICAgfQ0KPj4+ICsgICAgICAgICAgICBwY2lkZXYgPSBjb250YWluZXJfb2YodmJhc2VkZXYs
IFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2KTsNCj4+PiArICAgICAgICAgICAgaWYgKE9CSkVDVChw
Y2lkZXYpID09IG93bmVyKSB7DQo+Pj4gKyAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+
PiArICAgICAgICAgICAgfQ0KPj4+ICsgICAgICAgIH0NCj4+PiArICAgIH0NCj4+PiArDQo+Pj4g
KyAgICByZXR1cm4gZmFsc2U7DQo+Pj4gK30NCj4+DQo+PiBXaGF0IGFib3V0IHNpbXBsaWZ5IGl0
IHdpdGggbWVtb3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKCk/DQo+PiBUaGlzIHdheSB2ZHBhIGRl
dmljZSBjb3VsZCBhbHNvIGJlIGluY2x1ZGVkLg0KPj4NCj4NCj5Ob3RlIHRoYXQgdGhlIGNoZWNr
IGlzIG5vdCBpbnRlcmVzdGVkIGluIFJBTSAob3IgYW55IG90aGVyIGtpbmRhIG9mIG1lbW9yeSBs
aWtlDQo+VkdBKS4gVGhhdCdzIGNvdmVyZWQgaW4gdGhlIDMyLTY0IHJhbmdlcy4gQnV0IHJhdGhl
ciBpbiBhbnkgUENJIGRldmljZSBSQU0gdGhhdA0KPndvdWxkIGZhbGwgaW4gdGhlIDY0LWJpdCBQ
Q0kgaG9sZS4gV291bGQgbWVtb3J5X3JlZ2lvbl9pc19yYW1fZGV2aWNlKCkgcmVhbGx5DQo+Y292
ZXIgaXQ/IElmIHNvLCBJIGFtIGFsbCBmb3IgdGhlIHNpbXBsaWZpY2F0aW9uLg0KDQpSYW0gZGV2
aWNlIGlzIHVzZWQgbm90IG9ubHkgYnkgdmZpbyBwY2kgYmFycyBidXQgYWxzbyBob3N0IG5vdGlm
aWVyIG9mIHZkcGEgYW5kIHZob3N0LXVzZXIuDQoNCkkgaGF2ZSBhbm90aGVyIHF1ZXN0aW9uLCBw
cmV2aW91c2x5IEkgdGhpbmsgdmZpbyBwY2kgYmFycyBhcmUgZGV2aWNlIHN0YXRlcyBhbmQNCnNh
dmUvcmVzdG9yZWQgdGhyb3VnaCBWRklPIG1pZ3JhdGlvbiBwcm90b2NvbCwgc28gd2UgZG9uJ3Qg
bmVlZCB0byBkaXJ0eQ0KdHJhY2tpbmcgdGhlbS4gRG8gSSB1bmRlcnN0YW5kIHdyb25nPw0KDQpU
aGFua3MNClpoZW56aG9uZw0K

