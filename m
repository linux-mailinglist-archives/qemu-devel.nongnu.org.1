Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32D81ACBC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 03:46:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG93a-0002Um-Iy; Wed, 20 Dec 2023 21:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rG93Y-0002Uc-7v
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 21:45:04 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rG93V-000183-8f
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 21:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703126701; x=1734662701;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ik/fvaurLOb+wdJgyZoy+aeeONqI2mK71NLz021y72U=;
 b=ALv0S1RHJTC++dwIt898BdSgp/aZARbemW/3D69Hyqs7i7jAVsRXxI9P
 ua4xHro6IzmERLtu5OEhBfJdaweVv63Sdkb/gUfB+aTyd7MLVQdln1yZW
 bWQvF07sfWBpBZCQemBd9O6165lVypgP+H1z0O6GHy+T6ClX46ZN5PQ4i
 ZMUBp4OlJDgr+oaIakS5MRH6d2HJtUjpUM0/yLpmxwHbayQc0OYdCaoiI
 6yThgt3e+yIzn/cGNz1QqgIjUrzP6H2KZM+agBpGNdcu/MJzrch9Fd707
 g/nw1F47I7DvlYWBC3x91atqg9nIaLPhyKHRtBduLrXIgwTPWNEUvlWCY w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="386336428"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; d="scan'208";a="386336428"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Dec 2023 18:44:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810820126"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; d="scan'208";a="810820126"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Dec 2023 18:44:52 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 18:44:51 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 18:44:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 18:44:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDtpMAerCjKVD/elRtWBrpWFXUjN7SVz7XLn6cGgJaZkRJ77eCtkpj3xjGS4C2mKQIQ42OZ4VKwF8yfX/7L3bY+CzIRQRDPJGW/ER3vwBhUgLBBnts9bql8BL4Wsseu7x8UkVhU5cCkuelbSsFa10Ccfp9udTbcFLk0zyBhG30H0AMwLmT+d7TYpQE9wIcNTlSEq8+0wYykXyFTc08LYEGfk7rb6orc697prt52OKpTtzkZJfxjLh/E4tXnlcpiWVTl4P2FZsaJwNBZmJfI8uRjktDAcmdZ+ExoO45x9ufXOS3If2OlLLmAAel3QxjVKjnmej9KkZwKNyawFf+nUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik/fvaurLOb+wdJgyZoy+aeeONqI2mK71NLz021y72U=;
 b=Ebchj58B1bR0VEgztQmcStAT9N4jIfomUfCuTlAw6qz2LpAUmgLNN+5tWOoQnlxoltVPmK2R3Hu8i4QSlICfKVoL8He3cAc9VtyYVtlYrbyqVwMk0LjaPXAh0Aiw7DvKynlh0TJ26KrGooOOhYE4phl2SuTZKm6NeqfFbCGIyRvJE+jcruwjD5VPIgj4Mn8my/5NNxK4Am7jtLXWLxwmu9ZC+gPEOoYPsC5s8sUl2JFdoxiC+dVfN+pjJjSGemyd8h0l6uf61OirxO2I8kRv9EOl+b7+tvNc4MYLhl31KxbF5QLLEb4J5NLvA5e0EOFSW4OHEW739AFzWbNLOMQO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 02:44:50 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 02:44:49 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Khem Raj <raj.khem@gmail.com>
Subject: RE: [PATCH] vfio/container: Replace basename with g_path_get_basename
Thread-Topic: [PATCH] vfio/container: Replace basename with g_path_get_basename
Thread-Index: AQHaM0vl/mvSOL+VNEGAa7e5VolYNbCzB3Vg
Date: Thu, 21 Dec 2023 02:44:48 +0000
Message-ID: <SJ0PR11MB6744593B51D575064BBDB0A89295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231220135302.932039-1-clg@redhat.com>
In-Reply-To: <20231220135302.932039-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6622:EE_
x-ms-office365-filtering-correlation-id: 843b1591-3e67-4881-6148-08dc01cecce2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ET9OoFAqfudj8H/kcRoZe/khiBJ2MJjSKe9YYh9mJEzbKigXcgXiucO4AbciHr8auZhqMmPQQY3bQdjtLazqTgKGbgo+Twi4rjC4t77S0fkuFTpSDPTT5SGY5W07sasJVVB2e1OtNbDY10AumnMW0DsjZj2xOg5ef3HJ1YO8vGrM2r25LioCdCbzkupyGVLXIAizuXP8kHz3RwQUEgLW+5UYjjozYs0zlAgvWwIUArIXEvad8B70WUHYs/vLhmte5qmKMIJ07Er8+hivht8/TDtXavLDn2A4LKGRoI2snjUcpi8GabDH0RhvCIDU6sZI4l8xoSjgJfX+Bz5d/gbEfaFem0p1ncYxAQHGWGbIDDrGfuSrlDlw/uImFOwz5F10DmXnSZQImD/Dhm8UWEN3GZwxlQsRtFM+0aHKCZ4q7W/l+RI37S0k9aoY0YiOSbEyq8Seh4r73rBDY/8SXehreS0jYzGWUr5jWmEEuCNwNzhYmoK1scL/kax+d3ViarM4Nbk+LxO5nos6wUiUPCcgmivw8d/tq8MFJLAmltHMmUcqVmY2gLx4XFxMG2DF2LCNdYMp2as8jEQUwWDyTg+VZNOLeOIxuaHjqyURJGpyEIc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(39860400002)(396003)(346002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(7696005)(6506007)(66476007)(54906003)(66446008)(66946007)(66556008)(64756008)(26005)(9686003)(478600001)(55016003)(4326008)(8936002)(8676002)(316002)(83380400001)(110136005)(71200400001)(76116006)(966005)(52536014)(2906002)(5660300002)(122000001)(38100700002)(38070700009)(41300700001)(82960400001)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V24rYk5kbzl3a0MvVHRQR1ZpaWVhYTdPVVVHTkZoSTQ1cDZiSC9IWTBIZUp6?=
 =?utf-8?B?M3Bzemk2VnFCUytlREtWdFVPNXlmTURSZmNvWWFZQjNaMzRkSVFFNDhYNU5H?=
 =?utf-8?B?OUhYT2VtTFdkMFNKQUZRQU56Zk00a2pPU3hBck9jTWUvN092TWJwSHVtVVY4?=
 =?utf-8?B?OWxleXlucDVUMkpDMGtWd3puSXdXZytWN0NqUTdGck83ZkNUazlLMVYxN29D?=
 =?utf-8?B?YTFrK3k5MUIvOTUxd0RuS1NQc2tlV0Zya3dLcFYreGRmcFlyVGZwcXlWdk1p?=
 =?utf-8?B?RHhFVCtHNFhmNVlHOVJXT1NCa2tjSHc3TEV4QTN0ZjA4RnJBenFEdXhMNnpF?=
 =?utf-8?B?R2pJcjhyRjUvS0VPcmpta1FTSVM1c0ExOXhFOU5FbVRMSkZ5V011Rzl4ZVpV?=
 =?utf-8?B?dVdNNU00aStKZ0dhbXgyeUlVVGJ0WmlsNjV4S3dHVUNZQ2I3OHpSRlVvNUhZ?=
 =?utf-8?B?WXN2R2tJaVV5SjA4akJtMWY4TnRsQ1RaTHVRTlgrbUJyQm93Z1VKZStMMlgr?=
 =?utf-8?B?NGZwK0ZEYmkwczJhNFpMYUxVWk1KNHhRVFVjajRzRXZ6dk1rckpxNWU1OUtU?=
 =?utf-8?B?QkRnZlZjVmkwdUpMVDltT09TZTUvaStLUG9HdnRvNmFJY0ZiSTJUUVlXV0hI?=
 =?utf-8?B?R0xXaFYvY1hPb1RQUlFBSjRJMVhCQzd3QzJhTWM4Tk9OSXdTaEgwTU5HR0Fy?=
 =?utf-8?B?QTJ5MWtyTjN6NE5qeGYxRGIyS3J6WW5saEhxcjFMOURSNkpha0RHMWNhdU5G?=
 =?utf-8?B?MzhraVlrY3BNSjZxVzlQV0pvYVFMNis5ckpWdG5VNXNtOTRXd0ZtdFdxeU4w?=
 =?utf-8?B?NmcwNUJ0L21SQU9WUlFaZ2pZTWlkaUFHTGliTFFLWDF2aXRXc0hJL2JvQWxl?=
 =?utf-8?B?TlRGT25scFNhNWJrcjc0djM4eGZxUG5zV1pkVDA1ZnpBRE5vNDRkTW1QeThT?=
 =?utf-8?B?dldHalMvTGVKRkNBTnVTVWVNSHlVT0JOMVI4clFvTDdYMWh5SVhwd1hmMEJS?=
 =?utf-8?B?S0RZOVA0V05kdUJERnlsbVlUckhNVWhxRFVXZ0x0S25wRXV3NnYyMStuMitU?=
 =?utf-8?B?UkRwRkVRcjhJd0xkdkZEdmp1MDY0TitzQXBFY1ZDdmxQcUdRcm9oUnJMejFn?=
 =?utf-8?B?WEtVcnp6cjdpVUNxWU5Vb3B4cGpQVVZlNktBKzBVOEJGOFVYcG05Y3JuZ3pH?=
 =?utf-8?B?Q21PWHJodmRoM3RVb25JdkswQ1NSOFRDa0ZwUUdva00yRHNyeUFsYlJLd2cz?=
 =?utf-8?B?Tm5mZUlXTWpSL2FGQTBLdThOODFteERvUXlHMVU5WFY5V2FGdnByWTVDcmo2?=
 =?utf-8?B?VEJxQi9pWXhvZjl3cFZEQnB2NFU5ZU9IZmRtNmkxUlZ1QWR3WVViYWFtQVRZ?=
 =?utf-8?B?RXJobTRBR2dGZStzUi80SG5KUVFoQ1MxdGFzcTNjajVRK2dPYUdDazE5Z2pq?=
 =?utf-8?B?YTRtYU1lVEUyUnM2Rm4xaUNPck4xZmhiUjloUlpXckgyN2xiK1NYL1ljSjFs?=
 =?utf-8?B?UXJwNUZqK1VaZ1grWm0yWXJFaUJMRDM0Y3pzWXlrbjc0QWRQSFlLcTF6TTdH?=
 =?utf-8?B?cUJOTWs5SVF1eEJEaGkzQUtVMXZpRWVLdlhzNlNiMWVJWUVrUDZJSi82b0NJ?=
 =?utf-8?B?a016Y1VtYmd4eFUrSUxrRTRyeTVYZU9iQVM2WWhXNXJHby9BQ0p4MXVXQlR2?=
 =?utf-8?B?V1RxQkxkV3ZoVlFoTGZrQkVXcm04RmFWNG1RalRjeGVoejN6K3k3Sm9tYjVw?=
 =?utf-8?B?aXg5RjltaXFzQ1N2RzQ3TkY3VjZIRUh5QnM5YnphZysxZ296amxDYUgzbkJr?=
 =?utf-8?B?SXJzWUoxY0tQeWdBL1N0VXp3Tm4vSkx5VjNKaHBSU3k3dFp0dlpPNjJTcHBp?=
 =?utf-8?B?WjZSUW9qajZYSTZMdkJSTTREY2xxZHg1OUhMMVMvRFBMSDlXQ0t5Q290NFZw?=
 =?utf-8?B?NFhZMkZkckRzZGE4RFdONTBzbElncXdQcE9IV2ZXdUxLUFFVbnJ1TnBZSnZx?=
 =?utf-8?B?S0syeVJLVzRUWDFpM2VtN2tuRUx3RzA2WkNoTDNEQ29QY3Y0RENJbm1zV3Qv?=
 =?utf-8?B?Q3luczE3UFk2Q3JBZUwzUVJLcUZ1NnltKzJRcnoxZW1ndXZUZ3V1VWdiM3h1?=
 =?utf-8?Q?YSYBDAttGbwLY4RlnVOjlKmma?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843b1591-3e67-4881-6148-08dc01cecce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 02:44:48.7542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CemI+iJ9XTSsMLCkqIc9u/4vwmlc8GTUTDPxjD34FfBEIOD/o9V3uAZzMa1/OwsK6EdCJKFSMjPGPKPWmRPrAya2raCmkWMR3oolDahzFwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6622
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0hdIHZmaW8vY29udGFpbmVyOiBSZXBs
YWNlIGJhc2VuYW1lIHdpdGgNCj5nX3BhdGhfZ2V0X2Jhc2VuYW1lDQo+DQo+Z19wYXRoX2dldF9i
YXNlbmFtZSgpIGlzIGEgcG9ydGFibGUgdXRpbGl0eSBmdW5jdGlvbiB0aGF0IGhhcyB0aGUNCj5h
ZHZhbnRhZ2Ugb2Ygbm90IG1vZGlmaW5nIHRoZSBzdHJpbmcgYXJndW1lbnQuIEl0IGFsc28gZml4
ZXMgYSBjb21waWxlDQo+YnJlYWthZ2Ugd2l0aCB0aGUgTXVzbCBDIGxpYnJhcnkgcmVwb3J0ZWQg
aW4gWzFdLg0KPg0KPlsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzEyMTIwMTAy
MjguMjcwMTU0NC0xLQ0KPnJhai5raGVtQGdtYWlsLmNvbS8NCj4NCj5SZXBvcnRlZC1ieTogS2hl
bSBSYWogPHJhai5raGVtQGdtYWlsLmNvbT4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdv
YXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0KPi0tLQ0KPiBody92
ZmlvL2NvbnRhaW5lci5jIHwgNSArKystLQ0KPiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci5j
IGIvaHcvdmZpby9jb250YWluZXIuYw0KPmluZGV4DQo+Njg4Y2YyM2JhYjg4Zjg1MjQ2Mzc4YmM1
YTdkYTNjNTFlYTZiNzlkOS4uOGQzMzRmNTJmMjQzOGQwNWY2MzI1MA0KPjJlMDdmZmQ0ZGMyZWM3
NmNiNSAxMDA2NDQNCj4tLS0gYS9ody92ZmlvL2NvbnRhaW5lci5jDQo+KysrIGIvaHcvdmZpby9j
b250YWluZXIuYw0KPkBAIC04NjksNyArODY5LDggQEAgc3RhdGljIHZvaWQgdmZpb19wdXRfYmFz
ZV9kZXZpY2UoVkZJT0RldmljZQ0KPip2YmFzZWRldikNCj4NCj4gc3RhdGljIGludCB2ZmlvX2Rl
dmljZV9ncm91cGlkKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+IHsNCj4t
ICAgIGNoYXIgKnRtcCwgZ3JvdXBfcGF0aFtQQVRIX01BWF0sICpncm91cF9uYW1lOw0KPisgICAg
Y2hhciAqdG1wLCBncm91cF9wYXRoW1BBVEhfTUFYXTsNCj4rICAgIGdfYXV0b2ZyZWUgY2hhciAq
Z3JvdXBfbmFtZSA9IE5VTEw7DQo+ICAgICBpbnQgcmV0LCBncm91cGlkOw0KPiAgICAgc3NpemVf
dCBsZW47DQo+DQo+QEAgLTg4NSw3ICs4ODYsNyBAQCBzdGF0aWMgaW50IHZmaW9fZGV2aWNlX2dy
b3VwaWQoVkZJT0RldmljZQ0KPip2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPg0KPiAgICAgZ3Jv
dXBfcGF0aFtsZW5dID0gMDsNCj4NCj4tICAgIGdyb3VwX25hbWUgPSBiYXNlbmFtZShncm91cF9w
YXRoKTsNCj4rICAgIGdyb3VwX25hbWUgPSBnX3BhdGhfZ2V0X2Jhc2VuYW1lKGdyb3VwX3BhdGgp
Ow0KPiAgICAgaWYgKHNzY2FuZihncm91cF9uYW1lLCAiJWQiLCAmZ3JvdXBpZCkgIT0gMSkgew0K
PiAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJybm8sICJmYWlsZWQgdG8gcmVhZCAl
cyIsIGdyb3VwX3BhdGgpOw0KPiAgICAgICAgIHJldHVybiAtZXJybm87DQo+LS0NCj4yLjQzLjAN
Cg0K

