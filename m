Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ADF7A9152
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 05:38:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjAUI-0004Fc-Co; Wed, 20 Sep 2023 23:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjAUE-0004F5-P1; Wed, 20 Sep 2023 23:36:18 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjAUB-0006b4-LZ; Wed, 20 Sep 2023 23:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695267375; x=1726803375;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tuSJTB7gnr+0sb1TLFyj4txKvgMTT6suJwAiavtfKDk=;
 b=gpGp68wzgH/zRgYi1nt0YpnN4QFdWLTXLsRSnJIUKkGjGG1+Ov4BnGqy
 HheowFDV8iT3zI80fuvhwzyQbYaxjqdrzfxVbcStXS81L1tUo7VHQxJY2
 zv/2efExm1L/PYVsoQG663f+ATULbj9f7uQM+6MBC0sOiKT+RiugBVmRL
 PSzmJ/T0xcyp3ngoNy0tt2nIBg+XJLA0v85ZIbe7NsnFTXaQdpzIq3jpj
 v8NEgPFU0dtj8ucJ9mEkKQYXNsbkPWnePU03vHeXWyOY9ktzciDA3jGVC
 6eyiUm8xOzoDp5D49uRIUt4pAeLAeDv0rde79BQtg/Ug7nxsbbsY7yRuM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446878697"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="446878697"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 20:36:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="740457791"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="740457791"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 20:36:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 20:36:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 20:36:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 20:36:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvMvYUTd4cjK/WFmm7+p7hOj2wKa6XMIAFn291SjyExTJ55JO/hYWW3FP2Ex0pH5bYXGeTx4FcrStUGkviWGH3Bilet5ONFFjsbK8biPKMiAw04Yit1ORIggKScyqtd6xAazWkGFt5NqoR0GAZg3sgOyxFCI2MDIoexgKRkQwBiI2hn0WNO/L6VY6ow1qhELRBSclFaNmjficqaoBkpgsTGrRfFR4wNdnGWHE/Q36Nj4HeljCbR6eC+IOAgjTujMx89b/rro9PfwUrH30AqlUUEK/h/frtaqZU2HwPc64whWFmPUAII7fJLP7HH0p1Osjzve3135FywVvZ9R/K95mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuSJTB7gnr+0sb1TLFyj4txKvgMTT6suJwAiavtfKDk=;
 b=HHy0w7DlihucRBuus5C6zMwnudqKlXruorxwm0uglx+uAb8AylIwoxr1mpJlUiVOLBh0BOyx6RiO91qmnbOn9za1MzIERNc/AZwyFBpl0a609JHuwPBqPWtSEKQJ20zUpWvJhGmVvQyKB52/E285OE7ojHAddUr+E2KAxNNK7nFf64kISEmxH5I/5KFaW3oMHeM9fErz2ag7376nnzNH9b+6QTJxdltj8A/uq85geUAnQ0yIBluAVzxf9qSxBQF2uTJvuzcgbyxrani/lwfpjVF3OWVyD5O9DwSAw/IE7brifEtVX2WlMTuESg2KdCMYPXC7cPI/ekUvhYnZLi/thw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8072.namprd11.prod.outlook.com (2603:10b6:8:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 03:35:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 03:35:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, 
 Greg Kurz <groug@kaod.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>, "open
 list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v1 13/22] vfio: Add base container
Thread-Topic: [PATCH v1 13/22] vfio: Add base container
Thread-Index: AQHZ2zBKcvHai3HTVU61uaTXJ4y/6rAihaoAgAGUb4CAAKSZMA==
Date: Thu, 21 Sep 2023 03:35:57 +0000
Message-ID: <SJ0PR11MB6744CFAAC37534C158BE484192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
 <14853056-3742-8cfe-f8b7-cdb8ea05a846@redhat.com>
In-Reply-To: <14853056-3742-8cfe-f8b7-cdb8ea05a846@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8072:EE_
x-ms-office365-filtering-correlation-id: 3948a51b-533a-4570-0628-08dbba53de39
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fqn7DHH6A85fJwmeUVP8/iFCYALgsP5kP3SxEh3w0UGekc99EO8AD4LcIXGUHlPqRqqI9fmJzdqME7k8RHMRgNla1PKHgGKBXJ6M5CEOqi+m9upgcWUwtT45p00oEqvWzv0BwnMu9VUs8n5/EwpuWY4nSQhk0yVYdhPBPEWwT+mJB3Izv07wxU9Y9Qn7+H/uhP15+/lzRhH8q6zVxtgJ7G/6q06iSPP5QgIQigzHlcxvaKUPFXQk8BitDsHXXBviwamu2hNwKDidyt62yRy35Mr/mUUdpO1mUINit0WJPycrZsVDYkLBeZxNZAy2RDXHjpvYc4QITpQbW+ZOUCmV3J0rqG3HEygifbUUkJ6GXo2p/XcxG82VUrmsLqQchM/LcOAuAr/iPZgUFi6kklfLg5r2g5h/Rby7l4JQMxO1UM9uPkfkhh94K3IiF0KoKLVZMRuZemQ60uB/ehGZ8u5x2j/upggUu5+6FGofWcN0vqqBHfKKQhh2UX4M8lRxsoSIzV9wKG4bKyLYMzSJD8zIPdvI7Yrhx6bXgEavCTuz/2bh7/bT+po594ME6yit/s12qVXTm5xT601Ka70AzHbqX2iULqSNVUo76//u1jOR7AM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(396003)(39860400002)(376002)(136003)(1800799009)(186009)(451199024)(55016003)(316002)(66446008)(110136005)(66556008)(41300700001)(66476007)(66946007)(64756008)(54906003)(76116006)(71200400001)(122000001)(38070700005)(7416002)(38100700002)(33656002)(478600001)(86362001)(2906002)(966005)(4326008)(5660300002)(52536014)(8936002)(82960400001)(8676002)(26005)(83380400001)(6506007)(7696005)(53546011)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Slpybk5ySjR5bDRyRkx4bzlrZkRGVGZkVkRXNWE4N3hTYzBIcEthaHh4Yjho?=
 =?utf-8?B?RUpYWDJ6NFA1cngwQ3ZBamZyMzFGcmM2SnRqcGUvWjJJRFdzaWlVL1FtNHdH?=
 =?utf-8?B?YUVzbXFyQVdlSWpvUjE4dkhieUlkYVFhQURvWmc2eTIxL0NyZmtrRFpOSnZE?=
 =?utf-8?B?Y2dFYjBVVXk2T1AwczRWK1FVNm82K3FiYmExYWJKanJpRi9PWkxhYmxvL05k?=
 =?utf-8?B?Nlg2VWVoUnhWckpaZ0srdlJBVXFCZjc4SHQ1OTQxVTNyV0c3Q0Y5YkVwSW9p?=
 =?utf-8?B?dkxKOGEwR29UV3NVZTRRK1hlemNOeVpkWExNZE1GSWhSQVNSSS9uVElkQnB4?=
 =?utf-8?B?Q2NTL013a2laOEFUL0N3TzZWMDdKdzVpeVlPYzBaZ0lmQTN6S3JrRnp6KzBs?=
 =?utf-8?B?VTEvd1hOcmc2OVV3NEtObU9yL3p5eXlvalFLNzVhcTRsaDlxdVc2dDJvMHRM?=
 =?utf-8?B?YlJxNmdhM3UvVTU5S2FYa3p1S3gwNXV6c1VDeXFKRUlTTjg5ZllFNWc5dVZ5?=
 =?utf-8?B?Z1lOdkxsNGhQYW8vaHdybEF2NnljVVdRM1pSV3NCQm44bGJ5WnREemVpNEl3?=
 =?utf-8?B?bWRUd2ZUQk9VeTlmMlhvZ1VhQU10RTQ5ZVI5bXRTRlJBRmlWem5jeG0vODg1?=
 =?utf-8?B?QVBpWElDekxBQmxwNDU2bHpjZ0lSVTE2NlVOYUZLcjFOTXd2a1RDSktML1p5?=
 =?utf-8?B?SCtJbW4zWUNGZ2lqd0lFbUJ0VWE4SDBzeldRdWN3Mi93L1VDV3AwQVM2NzNQ?=
 =?utf-8?B?S0dMV1lxWVdJTE9KWGYyR1ZtUXVja0VtaE1KYnN0R0k2Vm45ZEVsNHNoUWtC?=
 =?utf-8?B?NXA4Mzh3R2F1S1FUWDJ3VG9PTzY3NERSeUdLMGE2czZoY1NpZWd1cVV5b1Qr?=
 =?utf-8?B?RWJJbDJ4Um52RzZaMjdoNnQ5cHFvbTdDQVZ4S3lHbXZxTkVlQ2dqUm1NaVY0?=
 =?utf-8?B?S0FTQXp1aEtjUitxUmtvRElTbEI3M3gvd0Q0ZnFTMlM0TDVnZlFBdFVmV3dH?=
 =?utf-8?B?UVFpekpiS2hrbXFJYVpXS25ONTgyK2lTalBheTlBUWhGK0hpWFB3MFBVVC93?=
 =?utf-8?B?VEpsOXpIT1RnNHluMmRXKzc1dk11RjhOb2lXZDR2dkEzeTljZmNET3h3UTc5?=
 =?utf-8?B?a2N5NFJVSE5KK0JrVkwvb0Z5dG9iSzgvaTJnMHM2M3VZS0hGNEUxUkJSYU1r?=
 =?utf-8?B?RE1tNmlDRVBjZUVIVWJLS3ZWL0RieTFHSTlzUkwxaWw4dzMyaVBvV3E0MlRt?=
 =?utf-8?B?WGViMDd5b1RyMENUWXpvNExheVI2ZW5Rb3JIQzRwMlRmc1lnWFdRWXlTR1VC?=
 =?utf-8?B?U2JkWjN2L0ZZT1pIWDBLV3hYT2RZekV1VW8zMXdMNlNNNkFrOGZHcW41SG5q?=
 =?utf-8?B?SC9tYkRvZncvQ2JGS3hnaHo5R25sWkcvMCtvRFZnVnlnMWt3b3BUVzdkSU1T?=
 =?utf-8?B?STArbjBTTHh1M2IxYzhBU3pQa1kxOTJBWVdBd2ZGbzlqWEtaYkhOZlphdzBO?=
 =?utf-8?B?dVZ2dllka2Q2UG9DYloxblVNQzdrckY0dkRDYjJ5c1hkcDVLaHQvQ1I4OG83?=
 =?utf-8?B?S21YQyt6NHkzNTVmNzJxT1ArTk1pMVRaZ1pNemtGTG5yai83cFJjR3BUNVFU?=
 =?utf-8?B?c2xZZnhZakdDMFM5MVNNYmFsNThGbWFuZE9YY1UyaVpyRWpVd1ErRExOYWJW?=
 =?utf-8?B?d0xlWUpsTDd1M0oreGN3MFFlWGxxeWFVSzlkNERuc2RZT1JsM2RYcXpUeWIv?=
 =?utf-8?B?ck5jM0cwbDZFaVVNSUNKUWlENUd3SUFBN0svSGtLUUZwbTFPK2ZUVEtlV0Z0?=
 =?utf-8?B?MzF4WlY0Q2pMeTRYZVBnbEF3cnFiQWZGTGh6K2pzbHVTNFhtckxsbmcyaUNY?=
 =?utf-8?B?cURNSHVlWUsxeEk4Tkg5ZzRkeUhUYU1wVDZXZHE0NHYzM1BJMWtFTGV2ellQ?=
 =?utf-8?B?V2hiMXVSQXU4NWFjWkIza3l3Wmk0UytDOGd0OTdlcExFUFhrNVV4ZTZIMTU0?=
 =?utf-8?B?UmZZejNiRnVnK1hKM1ZMK052aWhrN2E3bE9UZVZ0Vkk2K0cvYVF3bTRFNUk3?=
 =?utf-8?B?d3hQbXNpR1BGOVBHMi9HMmV3Y2tpVktJaEhtcEJHVWRRMVBlT3o1Mjg5OEZ3?=
 =?utf-8?B?N21qamRZWExua1k5dVVBVk1VM0xpZDRySXFmcmcvMENOZEI5WUVkSG9jK1NH?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3948a51b-533a-4570-0628-08dbba53de39
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 03:35:57.5670 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLCZi0KJEOWTTvdkQMLG7GgKLUKTV7RV0Zk+8GpZCSjyHXnnGqLkb7CtMHwqJDlrYV0Fe47Sig+9cqphnMC+uODO52H7HYccKK+SGmWr1Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8072
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjEs
IDIwMjMgMTozMSBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMTMvMjJdIHZmaW86IEFkZCBi
YXNlIGNvbnRhaW5lcg0KPg0KPkhpIFpoZW56aG9uZywNCj4NCj5PbiA5LzE5LzIzIDE5OjIzLCBD
w6lkcmljIExlIEdvYXRlciB3cm90ZToNCj4+IE9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4+IEZyb206IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+DQo+
Pj4gQWJzdHJhY3QgdGhlIFZGSU9Db250YWluZXIgdG8gYmUgYSBiYXNlIG9iamVjdC4gSXQgaXMg
c3VwcG9zZWQgdG8gYmUNCj4+PiBlbWJlZGRlZCBieSBsZWdhY3kgVkZJTyBjb250YWluZXIgYW5k
IGxhdGVyIG9uLCBpbnRvIHRoZSBuZXcgaW9tbXVmZA0KPj4+IGJhc2VkIGNvbnRhaW5lci4NCj4+
Pg0KPj4+IFRoZSBiYXNlIGNvbnRhaW5lciBpbXBsZW1lbnRzIGdlbmVyaWMgY29kZSBzdWNoIGFz
IGNvZGUgcmVsYXRlZCB0bw0KPj4+IG1lbW9yeV9saXN0ZW5lciBhbmQgYWRkcmVzcyBzcGFjZSBt
YW5hZ2VtZW50LiBUaGUgVkZJT0NvbnRhaW5lck9wcw0KPj4+IGltcGxlbWVudHMgY2FsbGJhY2tz
IHRoYXQgZGVwZW5kIG9uIHRoZSBrZXJuZWwgdXNlciBzcGFjZSBiZWluZyB1c2VkLg0KPj4+DQo+
Pj4gJ2NvbW1vbi5jJyBhbmQgdmZpbyBkZXZpY2UgY29kZSBvbmx5IG1hbmlwdWxhdGVzIHRoZSBi
YXNlIGNvbnRhaW5lciB3aXRoDQo+Pj4gd3JhcHBlciBmdW5jdGlvbnMgdGhhdCBjYWxscyB0aGUg
ZnVuY3Rpb25zIGRlZmluZWQgaW4NCj4+PiBWRklPQ29udGFpbmVyT3BzQ2xhc3MuDQo+Pj4gRXhp
c3RpbmcgJ2NvbnRhaW5lci5jJyBjb2RlIGlzIGNvbnZlcnRlZCB0byBpbXBsZW1lbnQgdGhlIGxl
Z2FjeQ0KPj4+IGNvbnRhaW5lcg0KPj4+IG9wcyBmdW5jdGlvbnMuDQo+Pj4NCj4+PiBCZWxvdyBp
cyB0aGUgYmFzZSBjb250YWluZXIuIEl0J3MgbmFtZWQgYXMgVkZJT0NvbnRhaW5lciwgb2xkDQo+
Pj4gVkZJT0NvbnRhaW5lcg0KPj4+IGlzIHJlcGxhY2VkIHdpdGggVkZJT0xlZ2FjeUNvbnRhaW5l
ci4NCj4+DQo+PiBVc3VhbHksIHdlIGludHJvZHVjZSB0aGUgbmV3IGludGVyZmFjZSBzb2xlbHks
IHBvcnQgdGhlIGN1cnJlbnQgbW9kZWxzDQo+PiBvbiB0b3Agb2YgdGhlIG5ldyBpbnRlcmZhY2Us
IHdpcmUgdGhlIG5ldyBtb2RlbHMgaW4gdGhlIGN1cnJlbnQNCj4+IGltcGxlbWVudGF0aW9uIGFu
ZCByZW1vdmUgdGhlIG9sZCBpbXBsZW1lbnRhdGlvbi4gVGhlbiwgd2UgY2FuIHN0YXJ0DQo+PiBh
ZGRpbmcgZXh0ZW5zaW9ucyB0byBzdXBwb3J0IG90aGVyIGltcGxlbWVudGF0aW9ucy4NCj4+DQo+
PiBzcGFwciBzaG91bGQgYmUgdGFrZW4gY2FyZSBvZiBzZXBhcmF0bHkgZm9sbG93aW5nIHRoZSBw
cmluY2lwbGUgYWJvdmUuDQo+PiBXaXRoIG15IFBQQyBoYXQsIEkgd291bGQgbm90IGV2ZW4gcmVh
ZCBzdWNoIGEgbWFzc2l2ZSBjaGFuZ2UsIHRvbyByaXNreQ0KPj4gZm9yIHRoZSBzdWJzeXN0ZW0u
IFRoaXMgcGF0aCB3aWxsIG5lZWQgKG11Y2gpIGZ1cnRoZXIgc3BsaXR0aW5nIHRvIGJlDQo+PiB1
bmRlcnN0YW5kYWJsZSBhbmQgYWNjZXB0YWJsZS4NCj5XZSBtaWdodCBzcGxpdCB0aGlzIHBhdGNo
IGJ5DQo+MSkgaW50cm9kdWNpbmcgVkZJT0xlZ2FjeUNvbnRhaW5lciBlbmNhcHN1bGF0aW5nIHRo
ZSBiYXNlIFZGSU9Db250YWluZXIsDQo+d2l0aG91dCB1c2luZyB0aGUgb3BzIGluIGEgZmlyc3Qg
cGxhY2U6DQo+wqBjb21tb24uYyB3b3VsZCBjYWxsIHZmaW9fY29udGFpbmVyXyogd2l0aCBoYXJj
b2RlZCBsZWdhY3kNCj5pbXBsZW1lbnRhdGlvbiwgaWUuIHJldHJpZXZpbmcgdGhlIGxlZ2FjeSBj
b250YWluZXIgd2l0aCBjb250YWluZXJfb2YuDQo+Mikgd2Ugd291bGQgaW50cm9kdWNlIHRoZSBC
RSBpbnRlcmZhY2Ugd2l0aG91dCB1c2luZyBpdC4NCj4zKSB3ZSB3b3VsZCB1c2UgdGhlIG5ldyBC
RSBpbnRlcmZhY2UNCj4NCj5PYnZpb3VzbHkgdGhpcyBuZWVkcyB0byBiZSBmdXJ0aGVyIHRyaWVk
IG91dC4gSWYgeW91IHdpc2ggSSBjYW4gdHJ5IHRvDQo+c3BsaXQgaXQgdGhhdCB3YXkgLi4uIFBs
ZWFzZSBsZXQgbWUga25vdw0KDQpTdXJlLCB0aGFua3MgZm9yIHlvdXIgaGVscCwgZ2xhZCB0aGF0
IEkgY2FuIGNvb3BlcmF0ZSB3aXRoIHlvdSB0byBtb3ZlDQp0aGlzIHNlcmllcyBmb3J3YXJkLg0K
SSBqdXN0IHVwZGF0ZWQgdGhlIGJyYW5jaCB3aGljaCByZWJhc2VkIHRvIG5ld2VzdCB1cHN0cmVh
bSBmb3IgeW91IHRvIHBpY2sgYXQgaHR0cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3Ry
ZWUvemhlbnpob25nL2lvbW11ZmRfY2Rldl92MV9yZWJhc2VkIA0KDQpUaGFua3MNClpoZW56aG9u
Zw0K

