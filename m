Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB87AA71F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 04:53:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjWHb-0004lG-7n; Thu, 21 Sep 2023 22:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjWHa-0004l4-23; Thu, 21 Sep 2023 22:52:42 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjWHW-0007ay-TK; Thu, 21 Sep 2023 22:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695351158; x=1726887158;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=y8Fmib7EVCwIfngn2oxnDZa7unJtv7IZmR9f6Z8cnGs=;
 b=k7GFxAKPfZRnrK9YqKzKQ9HKhW6tgYa1L2dYnFEYYzc2WG/q3iBkxzsD
 W8FUnm3he8qz7kmU7k3C4QmSkV9gxw8MiPevWixqgxHkGBuHJ5rBtEOD0
 aXbNxqQi1kQtZBv2puwu5jEdfAs/aNEhAOkWtT8qjmY/ACTaS077dwtMT
 ehXgGvGaASH2KfkUvwmMgHMetnpl5X1jPjm/CD9XOZFU44SIgRAn5T4zY
 447CK4Shds727BfsZofCSiAYF+m9OM+XFZCgdcTA/lHuZlkuaomVlQgZ3
 wcwnAcr9HZOdICXwqRcaNIfFR9m/18R53h+YPzGSn66wmnhzsuvmVe9NY g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444830007"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="444830007"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 19:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="890637982"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; d="scan'208";a="890637982"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Sep 2023 19:51:41 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 19:52:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 19:52:34 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 19:52:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fYpZOp+tOd3dkEZ8KA6pyioqJEFnjfPeW6/jKyxaifhwAdBJz+rhGPMLdMyJMGPXiKSY2FG/gZeRx+/miZ8S0DjefgJbfroYuhBODjR6mZYOoE/TH27wYFYSPKdIehEs0OCFD0iMBjIlFmYRwl268zMvFuGqjNvZiiv+U1iGydUA1DnqHan8P9pTPYf8zUYPl3jVQLPbIGwomIz7mL5TfE2MnC1GrsbGiuBF4T+z2HRILEQVvKeDSH8Crzro0lZuQfUe2ZqgaFt2+sa8CWzpjzsSyTIIamm1iSp/o/LKBFYWvMnhmOXQ9J1vvPSk2HgxcQYaMndcfKPwCWZSwBbX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8Fmib7EVCwIfngn2oxnDZa7unJtv7IZmR9f6Z8cnGs=;
 b=OPitJRZL4HtlxraL5h+QvIz+93mXHL7aaWNzgWxDsQ7+U+ywOz9daJDlXrz2tB2KCrrxMeL5qZQwzhatwkg6GZ6E4tipFbjy4iIwPA3pnWk9aMXee9t3b6JfJtI+Vo4HIfm9ec09B3sGQ4DUYNKVCNt7lZP0iJzaBM0+mqQNZdmW+1t9eCw8v/WxSsHEv9idFfeQdmQfPjEeeQZQnX5HHYmdydgf9mjMii/NrliSsYjI4YA9h3NsH5oGLWJSHJpV7+Alb7spzMyQ7DGX0gMEO+WmgY6tW9CnwHS7MEaFCkQfrUWARH+YLxlz0tFfu7QokB7CWXIehMXV4c/noMs/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN2PR11MB4662.namprd11.prod.outlook.com (2603:10b6:208:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 02:52:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 02:52:26 +0000
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
Thread-Index: AQHZ2zBKcvHai3HTVU61uaTXJ4y/6rAihaoAgAGUb4CAAKSZMIAA6rWAgACfBMA=
Date: Fri, 22 Sep 2023 02:52:26 +0000
Message-ID: <SJ0PR11MB674460D61EAEE236949A308E92FFA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-14-zhenzhong.duan@intel.com>
 <eb3c51e0-d1ba-1452-6f85-786f7c36411a@redhat.com>
 <14853056-3742-8cfe-f8b7-cdb8ea05a846@redhat.com>
 <SJ0PR11MB6744CFAAC37534C158BE484192F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0904e417-6201-a994-6507-60c44ba8efcd@redhat.com>
In-Reply-To: <0904e417-6201-a994-6507-60c44ba8efcd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN2PR11MB4662:EE_
x-ms-office365-filtering-correlation-id: 22eed8ef-afce-4a08-049d-08dbbb16f41e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pf402OO0WPkqpE1R374RKaei+ZBuahuHVAOFMhp3rR4z8jEkWkiy/vQN8n1jLUa1KVCBDfyGlCugTDX21fuZJQOOTrlykQvcr5nG35MMBREtuWS4Gl8ldtTZnHgqhMfsLL2fuFY/F5kTLiiNRrMjRO+sTRdB6dh/TyeCS8Ooz5w3XgfCv5In1xtwrmm2mZNWkSO1zWoheoKh/Af+tfEzYjTLwsGj7vubU2xkikbNUaETsv7SHUlukVGZGz+9MNfoB3hcicehO+NFm+T3C/SgfLdlj/NItOSsi4lQqFGZ7wAN1LKk/DxygR8U36vV3oqEt2xnrDct/iDP3zVFtLk+CzLFFiH3EpaxqE2XBNLGmDiJXJB+W0lxOIYHZY0+jaLoZuy1LWWTauWUfvrSol5GTwUQ6IWCHcC+S+0Q7Ues3sAZ6t09VkaltfYWbUEsigl3yqYucZcQRRJ24tngsbYxJHz66dmZ8v008DozUKf07DAlX07MyTUO1eOxN8Eg0abfzSFCVUhyy5mG1hJub4wGKzY7/E+3m1A1CbsW2TE/dx7bu64piZgqD/3PVWbllmMS7zArZ3tV0Mt5wCqjO0HW/dVhq31vZlKU/E2VsvTy8q0L5dfDau7Nlwet3TlvaLQsh9cMioPiiD9IS5xJlocX6Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(1800799009)(451199024)(186009)(83380400001)(6506007)(7696005)(9686003)(53546011)(5660300002)(4326008)(52536014)(82960400001)(2906002)(33656002)(54906003)(7416002)(8676002)(316002)(8936002)(64756008)(41300700001)(55016003)(478600001)(26005)(71200400001)(76116006)(38070700005)(110136005)(66946007)(86362001)(122000001)(38100700002)(66446008)(66556008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFRnWE1BQ3NUTWtmVFI1NWtHaFk5VW40WndnaWMzL1lvQkNHeHZHTFZCQWFl?=
 =?utf-8?B?U1hIZS9tc1ZXVEtJR09EcWhHWXBuYi9UbEVvN0g3bFRZR05Semh1UFdGRzdu?=
 =?utf-8?B?bHB4R3FzV2t5VEtjeUVmcnBzUjUvbGJKZTYvVk01K1VmNDRlbDgyaU5MRVNK?=
 =?utf-8?B?b04zSU9OQUgwZXZHOTlRdEtoVHZpMkFrWElUdU9aWHZXeEM3a09GbWFCblVD?=
 =?utf-8?B?MHJFb3dpVnpmeGhTeFhLRU5taldScHpUcVg4WTNqNTVDbFpGWXBnSk83TUFq?=
 =?utf-8?B?V1NZem9RMTIyUDBkSlVTckZuMkVzVnRFcS9LbWgyVFVIQlRSQ2RBYnkvRGNL?=
 =?utf-8?B?S3lFWXNoaUVXMFJzWGtIR1R1bm13eGdGbjhHTU5oUnJ0Q0RtWTIxWS80Y3ZV?=
 =?utf-8?B?SnZWcXNxQnNDSjNNVXMzTGZCTzQvUCt4MnlPQy9KOHNMYkw2bXowbWdxRnpl?=
 =?utf-8?B?SVp0UlZFbUp3aXVGRkdHVFBPTGFRWmN0U0l4amhiTkFPMFJReWNrdjJkNFhq?=
 =?utf-8?B?V1lIL3RtdlMxMWlJNG43cUsyN3cwVnRzUkJpNWNPV2RvaXV4b2o1dHVLR0J3?=
 =?utf-8?B?a3FvY1ArYWkyNXh3N3dVa0JzT3BWYmQvclVvUkU3b0hrYUM4VWdFVmFBemRC?=
 =?utf-8?B?cG5TVnc2bzk0MG9FWkR2TUNOYW5yS3Y4VlpDVHRVM2pFUExiNUMrYUlHeHlG?=
 =?utf-8?B?UTNVdGhBSTc3WW5Yckt5SjF4RTBBM003VjU3VklselJtSmVjNUhSMVRtVHlH?=
 =?utf-8?B?UVhvTjlrdWs3Q0Ira3FMakQ4SlZyL1lQVWRoelBFZG9GK21kelJRL2FrckpN?=
 =?utf-8?B?NE5vYzQ2K29POVNIUEZKcEE4UjFFbjhueU5rSGduc3pQN0JKVE1hajRyVWw3?=
 =?utf-8?B?dWtHRWM5OUQwdm5GR1E4V2ZTRDVrajVHK0E1WmdEVnZOVk1nZmN5Z0tXNWd0?=
 =?utf-8?B?Rk1sUUQ5RjlPN0VOSG5ZQWYvMzJpS2cvaFVETE14M3FyUkxiZkpYYnd2ZUVI?=
 =?utf-8?B?YnJTeFZYWXBMOFdCQWhydTdoZVU4S0NmTEVwU1hkRGxaODIyOTJSYk1MSHJ1?=
 =?utf-8?B?VFpuRWxBY3licTY0QUt4ekFmaVo0ZjZlQWR2QXc2R0g4MG84Y3d0MmZ0T1dS?=
 =?utf-8?B?MHBrdHkyU1gyZ1o0V3dGUTJhT0FGTlliejZ5ZC9wc3YzSjNZdkxYdzJhUHRJ?=
 =?utf-8?B?QTZFN2dDV3RPbk1LRU5iZEhDU0Jvck1EY2I5WXJ3cG5XVDZJV0NSQ1lpN3VJ?=
 =?utf-8?B?TmdHYzFFU2lLVU9MczdlcEZESVIyQ05CYzJyY25wVXgyV1Vram0yYzdsV1FH?=
 =?utf-8?B?QkhaWUtsdU15S3JEOEVJSXRXdjdHT3RVTEt3MFB4RXVXYk0vcnl5ZzJjemxn?=
 =?utf-8?B?cFZZWjdXLzVaMm9RQlBKSlFnOVZJSXdBbldsbUljdDVrYnpwSnlHSHR4dTA0?=
 =?utf-8?B?WlNLc1pLY0Rxb2tpWExkQmRsTXpxa1Fvc0lYaEhPZHZ0SzlhdFMzM2pmcm4w?=
 =?utf-8?B?WGZGZzN1Zi9qWWhmZVZxTGZxMW0zTFB6K3pLZlFBSlNNTS96YWM3QUUxQVdv?=
 =?utf-8?B?L0U5VHRoeW5KYzNiYWc1WWEyTjNsYlVZR3hGeCtxcXR6ZG9XdDhtWnJZZ3g3?=
 =?utf-8?B?WnVsM2RBa3hBVStKdXRzajVWMjMzaEJuZ1hpSjZDWnF4MVdidWFOTWxsYUtv?=
 =?utf-8?B?RnQ5MUpJQ0VXeTlVb3lKZVJBWUhiMXgrRWpBSHFJS3dYVEhIRHE1MER1ZmJx?=
 =?utf-8?B?SzJXb2NRcERSNXR4eENoSnl1YkhsbmVEV085R0VpVjByT296UFpTTHdtSUxz?=
 =?utf-8?B?Z2JBYjRBcTRIbGtmSE1nK2lqL1JkRlNTNFlBd1FGaGRkQ1Bmb3AybW1zQWJX?=
 =?utf-8?B?ZVZTODVpanlySnczVWt0YlJtSitVUStuSnQ0ajl1anZMRUFyVVRjR2FyYnU3?=
 =?utf-8?B?bW5ycnhFREZrQWVtenA2L0psSUhpMU9JdEtpMTF4bm9kUFhXcnNTMGplaTBU?=
 =?utf-8?B?THBiamFoVlJDUTdTYy9kMW5QOGcvOTZRRC94V2xNcmZ4SlkwTmRFUzd6UjdW?=
 =?utf-8?B?MmVnOEJjUkFiUVd2d1JtbUViTGFBVXZGYWV1WWdUMnd2UDgvbDBITHZhRUpJ?=
 =?utf-8?Q?0Kff1CqzNodTunL8mRE20zuiq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22eed8ef-afce-4a08-049d-08dbbb16f41e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 02:52:26.2229 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJEQOcqyklo0+hGF+xkqJRbwdjAcnKiMfZmfcGVXkodjAHdA58+N7Q45mDVdRs6foeXDHvSAqUOfO2j2YKBhND12AnFmsZxUBkl5WPBOb4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4662
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIFNlcHRlbWJlciAyMiwgMjAyMyAxOjIw
IEFNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxMy8yMl0gdmZpbzogQWRkIGJhc2UgY29udGFp
bmVyDQo+DQo+SGkgWmhlbnpob25nLA0KPk9uIDkvMjEvMjMgMDU6MzUsIER1YW4sIFpoZW56aG9u
ZyB3cm90ZToNCj4+IEhpIEVyaWMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+IFNlbnQ6
IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjMgMTozMSBBTQ0KPj4+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEgMTMvMjJdIHZmaW86IEFkZCBiYXNlIGNvbnRhaW5lcg0KPj4+DQo+Pj4gSGkgWmhl
bnpob25nLA0KPj4+DQo+Pj4gT24gOS8xOS8yMyAxOToyMywgQ8OpZHJpYyBMZSBHb2F0ZXIgd3Jv
dGU6DQo+Pj4+IE9uIDgvMzAvMjMgMTI6MzcsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+Pj4g
RnJvbTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pg0KPj4+Pj4gQWJzdHJhY3Qg
dGhlIFZGSU9Db250YWluZXIgdG8gYmUgYSBiYXNlIG9iamVjdC4gSXQgaXMgc3VwcG9zZWQgdG8g
YmUNCj4+Pj4+IGVtYmVkZGVkIGJ5IGxlZ2FjeSBWRklPIGNvbnRhaW5lciBhbmQgbGF0ZXIgb24s
IGludG8gdGhlIG5ldyBpb21tdWZkDQo+Pj4+PiBiYXNlZCBjb250YWluZXIuDQo+Pj4+Pg0KPj4+
Pj4gVGhlIGJhc2UgY29udGFpbmVyIGltcGxlbWVudHMgZ2VuZXJpYyBjb2RlIHN1Y2ggYXMgY29k
ZSByZWxhdGVkIHRvDQo+Pj4+PiBtZW1vcnlfbGlzdGVuZXIgYW5kIGFkZHJlc3Mgc3BhY2UgbWFu
YWdlbWVudC4gVGhlIFZGSU9Db250YWluZXJPcHMNCj4+Pj4+IGltcGxlbWVudHMgY2FsbGJhY2tz
IHRoYXQgZGVwZW5kIG9uIHRoZSBrZXJuZWwgdXNlciBzcGFjZSBiZWluZyB1c2VkLg0KPj4+Pj4N
Cj4+Pj4+ICdjb21tb24uYycgYW5kIHZmaW8gZGV2aWNlIGNvZGUgb25seSBtYW5pcHVsYXRlcyB0
aGUgYmFzZSBjb250YWluZXIgd2l0aA0KPj4+Pj4gd3JhcHBlciBmdW5jdGlvbnMgdGhhdCBjYWxs
cyB0aGUgZnVuY3Rpb25zIGRlZmluZWQgaW4NCj4+Pj4+IFZGSU9Db250YWluZXJPcHNDbGFzcy4N
Cj4+Pj4+IEV4aXN0aW5nICdjb250YWluZXIuYycgY29kZSBpcyBjb252ZXJ0ZWQgdG8gaW1wbGVt
ZW50IHRoZSBsZWdhY3kNCj4+Pj4+IGNvbnRhaW5lcg0KPj4+Pj4gb3BzIGZ1bmN0aW9ucy4NCj4+
Pj4+DQo+Pj4+PiBCZWxvdyBpcyB0aGUgYmFzZSBjb250YWluZXIuIEl0J3MgbmFtZWQgYXMgVkZJ
T0NvbnRhaW5lciwgb2xkDQo+Pj4+PiBWRklPQ29udGFpbmVyDQo+Pj4+PiBpcyByZXBsYWNlZCB3
aXRoIFZGSU9MZWdhY3lDb250YWluZXIuDQo+Pj4+IFVzdWFseSwgd2UgaW50cm9kdWNlIHRoZSBu
ZXcgaW50ZXJmYWNlIHNvbGVseSwgcG9ydCB0aGUgY3VycmVudCBtb2RlbHMNCj4+Pj4gb24gdG9w
IG9mIHRoZSBuZXcgaW50ZXJmYWNlLCB3aXJlIHRoZSBuZXcgbW9kZWxzIGluIHRoZSBjdXJyZW50
DQo+Pj4+IGltcGxlbWVudGF0aW9uIGFuZCByZW1vdmUgdGhlIG9sZCBpbXBsZW1lbnRhdGlvbi4g
VGhlbiwgd2UgY2FuIHN0YXJ0DQo+Pj4+IGFkZGluZyBleHRlbnNpb25zIHRvIHN1cHBvcnQgb3Ro
ZXIgaW1wbGVtZW50YXRpb25zLg0KPj4+Pg0KPj4+PiBzcGFwciBzaG91bGQgYmUgdGFrZW4gY2Fy
ZSBvZiBzZXBhcmF0bHkgZm9sbG93aW5nIHRoZSBwcmluY2lwbGUgYWJvdmUuDQo+Pj4+IFdpdGgg
bXkgUFBDIGhhdCwgSSB3b3VsZCBub3QgZXZlbiByZWFkIHN1Y2ggYSBtYXNzaXZlIGNoYW5nZSwg
dG9vIHJpc2t5DQo+Pj4+IGZvciB0aGUgc3Vic3lzdGVtLiBUaGlzIHBhdGggd2lsbCBuZWVkICht
dWNoKSBmdXJ0aGVyIHNwbGl0dGluZyB0byBiZQ0KPj4+PiB1bmRlcnN0YW5kYWJsZSBhbmQgYWNj
ZXB0YWJsZS4NCj4+PiBXZSBtaWdodCBzcGxpdCB0aGlzIHBhdGNoIGJ5DQo+Pj4gMSkgaW50cm9k
dWNpbmcgVkZJT0xlZ2FjeUNvbnRhaW5lciBlbmNhcHN1bGF0aW5nIHRoZSBiYXNlIFZGSU9Db250
YWluZXIsDQo+Pj4gd2l0aG91dCB1c2luZyB0aGUgb3BzIGluIGEgZmlyc3QgcGxhY2U6DQo+Pj4g
wqBjb21tb24uYyB3b3VsZCBjYWxsIHZmaW9fY29udGFpbmVyXyogd2l0aCBoYXJjb2RlZCBsZWdh
Y3kNCj4+PiBpbXBsZW1lbnRhdGlvbiwgaWUuIHJldHJpZXZpbmcgdGhlIGxlZ2FjeSBjb250YWlu
ZXIgd2l0aCBjb250YWluZXJfb2YuDQo+Pj4gMikgd2Ugd291bGQgaW50cm9kdWNlIHRoZSBCRSBp
bnRlcmZhY2Ugd2l0aG91dCB1c2luZyBpdC4NCj4+PiAzKSB3ZSB3b3VsZCB1c2UgdGhlIG5ldyBC
RSBpbnRlcmZhY2UNCj4+Pg0KPj4+IE9idmlvdXNseSB0aGlzIG5lZWRzIHRvIGJlIGZ1cnRoZXIg
dHJpZWQgb3V0LiBJZiB5b3Ugd2lzaCBJIGNhbiB0cnkgdG8NCj4+PiBzcGxpdCBpdCB0aGF0IHdh
eSAuLi4gUGxlYXNlIGxldCBtZSBrbm93DQo+PiBTdXJlLCB0aGFua3MgZm9yIHlvdXIgaGVscCwg
Z2xhZCB0aGF0IEkgY2FuIGNvb3BlcmF0ZSB3aXRoIHlvdSB0byBtb3ZlDQo+PiB0aGlzIHNlcmll
cyBmb3J3YXJkLg0KPj4gSSBqdXN0IHVwZGF0ZWQgdGhlIGJyYW5jaCB3aGljaCByZWJhc2VkIHRv
IG5ld2VzdCB1cHN0cmVhbSBmb3IgeW91IHRvIHBpY2sgYXQNCj5odHRwczovL2dpdGh1Yi5jb20v
eWlsaXUxNzY1L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9jZGV2X3YxX3JlYmFzZWQNCj4N
Cj5JIGhhdmUgc3BlbnQgbW9zdCBvZiBteSBkYXkgcmVzaHVmZmxpbmcgdGhpcyBzaW5nbGUgcGF0
Y2ggaW50byBudW1lcm91cw0KPm9uZXMgKDE2ISkuIFRoaXMgc2hvdWxkIGhlbHAgdGhlIHJldmll
dy4NCj5JIHdhcyBzaG9ydCBvZiB0aW1lLiBUaGlzIGNvbXBpbGVzLCB0aGUgZW5kIGNvZGUgc2hv
dWxkIGJlIGlkZW50aWNhbCB0bw0KPnRoZSBvcmlnaW5hbCBvbmUuIEJlc2lkZXMgdGhpcyBkZXNl
cnZlcyBzb21lIGFkZGl0aW9uYWwgcmV2aWV3IG9uIHlvdXINCj5lbmQsIGNvbW1pdCBtc2cgdHVu
aW5nLCAuLi4NCj4NCj5CdXQgYXQgbGVhc3QgaXQgaXMgYSBtb3ZlIGZvcndhcmQuIEZlZWwgZnJl
ZSB0byBpbmNvcnBvcmF0ZSB0aGF0IGluIHlvdXINCj5uZXh0IHJlc3Bpbi4NCj4NCj5QbGVhc2Ug
ZmluZCB0aGF0IHdvcmsgb24gdGhlIGZvbGxvd2luZyBicmFuY2gNCj4NCj5odHRwczovL2dpdGh1
Yi5jb20vZWF1Z2VyL3FlbXUvdHJlZS9pb21tdWZkX2NkZXZfdjFfcmViYXNlZF9zcGxpdA0KDQpU
aGFua3MgRXJpYywgeW91IGhhdmUgZG9uZSBhIHNvIHF1aWNrIGFuZCBhd2Vzb21lIHdvcmsuIExl
dCBtZSBsZWFybg0KeW91ciBjaGFuZ2UgYW5kIGludGVncmF0ZSB3aXRoIG15IG90aGVyIGNoYW5n
ZXMuIFdpbGwgZ2V0IGJhY2sgdG8geW91DQp0aGVuLg0KDQpCUnMuDQpaaGVuemhvbmcNCg==

