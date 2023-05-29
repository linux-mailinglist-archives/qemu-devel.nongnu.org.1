Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BB7149C1
	for <lists+qemu-devel@lfdr.de>; Mon, 29 May 2023 14:57:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3cPj-0005QN-AU; Mon, 29 May 2023 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3cPg-0005Pe-NM
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:55:52 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q3cPe-00014h-KF
 for qemu-devel@nongnu.org; Mon, 29 May 2023 08:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685364950; x=1716900950;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tPIPYGAICRFfCECwtSmi2Yk1B2BI1HeJlAHBu4l8+xA=;
 b=jKsxcLXhX/+sJIIKUczVl06UVH6N+e9ZQScQpId9MUrT8aT/CQI0Oeau
 OKksjQ2eo0wERlxZ8IaAojHOh9tybalWdiufNe0wXZDOs0SXZsQ3AFS42
 pYLTEc9sOEsXUFrTp5a8DSARzEHwRR2kVrIUfLHca0xwS4XmDLccdlikq
 RvPjt/C4kMA6CnVL/kdo5F/aqWB3adorzo57jWkf6ZDZQqkusE1iXAduo
 TNFXcYdgHAqqfNeK5mjFVSr1ie2UECwIwy6PJDRl1KseqN7W6+8isVX6x
 Dl/WdTrT0O5n496WB0ce/Aihyk+FVFgcUHm0o2uVvLOcsoFMuXeUAjqdy Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="357950119"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="357950119"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2023 05:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="771154470"
X-IronPort-AV: E=Sophos;i="6.00,201,1681196400"; d="scan'208";a="771154470"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga008.fm.intel.com with ESMTP; 29 May 2023 05:55:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 29 May 2023 05:55:34 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 29 May 2023 05:55:34 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 29 May 2023 05:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSIk9dcmJhJ8YyraViyDOMVgx9/c4koXntMWuyWlz1IkePE/klYajQ/GAz/SfZyyFacRDfKg9xG7KyOaOX2mA8Xg2aJ4LHo/oNKeyefJh43FMfXfsYlKO4uAUOeZ3HEOc8ShnTK0xlq4m6g31+rmaiB26w44JNwn58iL1LbpFSACwpyQMA20ailW0Tlx/lyZpWopOsyvY93qFKtiCDlhmQXPlGPVLxlbg6SQZtIr6CJAg4NkQa5PWvWX27ej1znq6BkhKaUmmpzYyby42Fr16rx9Qk1vkNfODXrNnLAKgrEjsB9u9UlDWX1aQYbYJzzzSRw+k/9ISGEUgJ3M+oQ/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPIPYGAICRFfCECwtSmi2Yk1B2BI1HeJlAHBu4l8+xA=;
 b=nTNYIfwD1k1HGrLmYptHC5x4lERcOH5cptx+Qk8ACQw9/DMv51n9AIGu8cISG6K6TUbiZQZS3tB9jvuHchRINYGKdIJd5zIaNkHotfJgsdBVYXn/w1L3Vh6ZZbMK5OODGH7SbxMJsJyb+jn4g8UIgDkmZ+3vNe9jrmiLsLc+WtYPSDZd4zWvo/nImJiqUwJVpvNKL0uq38EdikiURkQ6h/6gIJg173kbdK+LwjBcwVF7O1xsOQXv8kc+ppK0jhvCyedd1wC24le8JghleZk/8uuniAk+8JxlgKi4SwykyYZoaqp3zWqhr1L/jjhG2nVL5xwrOv/K+gR6gqYsxlXo8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Mon, 29 May 2023 12:55:30 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Mon, 29 May 2023
 12:55:30 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fix migrate_params_test_apply to set the
 dest param correctly
Thread-Topic: [PATCH v1] migration: fix migrate_params_test_apply to set the
 dest param correctly
Thread-Index: AQHZjhYa7hgK0hnt5Ey8I2oBcOKhkK9tG6+AgANx4kA=
Date: Mon, 29 May 2023 12:55:30 +0000
Message-ID: <DS0PR11MB6373304AA3B38CBB22D22BADDC4A9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230524080157.530968-1-wei.w.wang@intel.com>
 <ZHEpYQ01D7O3MQqM@x1n>
In-Reply-To: <ZHEpYQ01D7O3MQqM@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DM6PR11MB4737:EE_
x-ms-office365-filtering-correlation-id: 17dc0abe-96b2-4a9e-b4d2-08db6043fb99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFZ7rTAce9mi1RNEEaDJ2464kptxK4t0/spux8d8HdkxASj531xV3PbMq0mayV3rZLHL5WgkAJ/MGlZmyk6yJFjlS6sPyc1nn58Hx/caqXg8XHzPzalR2CeFQUsd5RtpsrDlc6m5J2x6AZhTR4UfSXyk7KLau/wLrmJGYA4i/vtNJnHHeuZhIb8c+SX4IsZtzyZ4z+/Jy/jxrnPjaJo+2hF/+whjLJnav3bA9jG+n0gRB4Rj1NLi/7LTVlO4+DUZD9e6cpjkfWZicnonOp5LJLW+22AZYlaPtNYQ5Zc3G0IzjB2Wax3KcjQ+AkCMh1R+zP99iPiAw7e6cmN0YnIOayNMycDIfwTJCmi/xdEHVpJrpgTSPsd5yjbzUpRTtOHLX6zfhTUeWpj6ncf1Mf88pJf6z7wAwCbfwZwWmYiO/xj2n+roTzjzxAJVV1hVq6LOx6vyMsFmzdpIbduGEukO/vIAOolzJ32JLdwjrAn8u7fClpkBUGC6Lc8XdLGwPcTP+7NRqHZ4u7iN34SuvZG7LncT2RAY6XWqspGf3mKKaZraBFXTb87HLWUaRk09gq4gi/ShBZXAKnuqXULZZ8ts1dqcQ+Qh2HxGGK1KDEcsmoa/K7JJsOTOx0KIYx8SeoQ6WIFSG+OLS8nxb+FyNxTJ0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199021)(86362001)(41300700001)(38070700005)(7696005)(55016003)(4326008)(71200400001)(316002)(33656002)(66446008)(66476007)(66556008)(64756008)(66946007)(76116006)(52536014)(5660300002)(186003)(2906002)(478600001)(53546011)(9686003)(6506007)(26005)(54906003)(122000001)(8676002)(8936002)(82960400001)(110136005)(38100700002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1F4b0FiME0ySWFld2pNN2tvS3V3ZjFNcGExOXRCb0NENUFMZTM2dmQ3d3F1?=
 =?utf-8?B?aVkybjVOeWNNZDlON3ZVQ0FSK0xUOFlQTENDWHJRR0JBV0s1Z2Rnb2p5Z2Jr?=
 =?utf-8?B?eDMvQU05NUk1NGl4VElIclhjYklNclV1VUU3djFUQUd6R1d1cElabjkyeGlX?=
 =?utf-8?B?bVh2eFJXYkUzTEtwL2xKV21mbmM0WDR6d3VjMEljQllzS2d0RVVpbThPWENZ?=
 =?utf-8?B?VFU0N2llQ3k2YVRRUXIzcTlYVVlhcGtZK0ZGQUhkRUFjQTdJbi8vQTc2TFBi?=
 =?utf-8?B?VUlCU1FsWW9hSVhZa0E0RXRXRE53QjBUbG1oWHF6V2ZjbGNMMjFkWXF3RTVM?=
 =?utf-8?B?OUlKT29zV0FUL1AwOVdrSG9yaU9wM1VIaEt3T0FjdXZJblQ4RUZQS0lEaGcy?=
 =?utf-8?B?MVRUN3JGTWlmTTBzM2luWFo4eTh2SE9Vc2NtNjQrUTV5L1E4RGYzaGVXd0c1?=
 =?utf-8?B?RFF5U3lOLzZFaDdNUEVPMjgzUlN4Vmc0Wjc3dnFyYjZhVGZCanhJTmZGaFYz?=
 =?utf-8?B?WUVoWGFEb3ZPekRuNGIzeFhmbEpvdEVxV2RvOG9ISFhzQy9VRkExejZvZEVa?=
 =?utf-8?B?TlVpTHByc0FCTi9haGY5Ylhjekc1Q0dGOEt1bnFDQlBvSVZacHJtNHMyY1Bq?=
 =?utf-8?B?ZXY1SUUxR1J4V3JuaXZ5VTBwczFQclNDUlAwWEloSGtBb3FpZ0VHek1mSnRY?=
 =?utf-8?B?bWJhWEprMEliVGsrRFdaeXN6ZlBFazJ1djY2cjVvdWRrMW1jR3VhVEtSZjBx?=
 =?utf-8?B?K1o3Vy93S2gwZ0tXRnEvT2JVVTZrTzRwMzlyV2dwQTIzbEFQMGROYSsxNmlo?=
 =?utf-8?B?aU5uVllNdy90WnlZc0tiYjRCc2ZqUjFtcUZIbzc5ZUo3OHBMRm4xMFdRY2NR?=
 =?utf-8?B?Q0h3bnJ1ekd4UE95MmtkMjh4eEVwVlpDakRuYnkrbk0wY3IrRnhEd1A3Z1dW?=
 =?utf-8?B?alk2YmJnR2R5ZklJSnlRKys5YmdsWGk5M0RCb2MrbnZoNWRLeDV2bVk4ZFJR?=
 =?utf-8?B?WDR0MjV1L2ZEVGlyTEVRSmxxZHh3TW8xZjdNZ2NIdVpDRFoxVDdYRnExYlBB?=
 =?utf-8?B?dFo4UlZLUXVvQWEyeHlUd0ZJSGhxZjk4SDFNUExYT3Zhb1dFZFlpcHdkVzIx?=
 =?utf-8?B?NytBeGNDR0kxaGNjRGdhV0lGRWo2a3lYSDd3Wml4QlpRL2xyNVJvWmNDb0RQ?=
 =?utf-8?B?REhDRGF2VHk2Q2dkaFZoM1pNS0l2Q243MDJramp0Wk5HOE95WXdTQzVYajk4?=
 =?utf-8?B?RnNMZ21ub3pnZzJ6NGp2L0p2ZzJSenRYdHI1TW0yakgvcm1EOHF0VGo3SVhu?=
 =?utf-8?B?MGRmZVlRTTFnM0ZJS0tCK2NVN3lwU044L2ppSnM3M2FjUDdrZnFPRUxYVGU1?=
 =?utf-8?B?cHE5eXZUd01xQ25uTWF5RDB0cUhteTRITWhoOHFLQmttNGFPb0dDWVpSc2VD?=
 =?utf-8?B?RnRISUtrRno1UmtJMWNmckRGTVRHVXB0SFByWkh0VU9zQitLeHc5S3dtZ0Ir?=
 =?utf-8?B?NXBPR2VDN200YjU1MFdlZTg2Z1dKanFVdHpZV3Z4VlFrWlR4ekhvWVJqVm1l?=
 =?utf-8?B?dUNhaHBoZEhDU1lUc1AwVC8yWFg1d0F6ZkwyeVBxUm9MbVJEWWlVYTkvZ0Mx?=
 =?utf-8?B?djYrVlQwUXNQVHY4VEw1SFJPUDRSOVZHNFBKZEFVbUR0S0VCRWhjSXo2SjFJ?=
 =?utf-8?B?aGZYbDl2cFhsL0wwVEY0YXBBVk1IYThxSUN2ejFtTWQvN2NWb3k5OG9NWk1P?=
 =?utf-8?B?T3NvcUk5aHpZUFpTTW5CL3BEVXg4ZHA1aVFGQ3h2ZEFXRWRRaStkallJcERZ?=
 =?utf-8?B?SDFDZFlnb1plQUhoQkh4a3E5TzdnbC9wcmkxcGI1U0hFQkM3Qi9nbmlMWjZp?=
 =?utf-8?B?UlhZVkptZzc2em1nRDJJUGpCbkhFeFBwNnV1MFhTSjB3bmZOTm5NS2ZIeHhY?=
 =?utf-8?B?WjZoenBZakRuRnAwSG51OHk2SHowbHhkemxtcEpNYmlHVWtXa2lmZzdmZkF2?=
 =?utf-8?B?WGlqMllmbksvTjZkSXpPZXpPblVNRTRhNmdGeWtzV0RvaUVDVmhVMXJiYUZi?=
 =?utf-8?B?aDRvSnpad2p2MFdYUnpJZFRmcURIaGtRRWZCTTRrcTAyRmJjcWNHbVFxRTFp?=
 =?utf-8?Q?NfvCTQgh9Gv8NHE5tCkrlQr1h?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17dc0abe-96b2-4a9e-b4d2-08db6043fb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 12:55:30.2709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Jd/UVAgli9h1+xyurrQ6zjlfN/GKsAVkMFDvh1bN41W3Up1fCIQFqTIJic1OEN3/5u3bKQREPVulK+tZEYQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=wei.w.wang@intel.com;
 helo=mga03.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.16,
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

T24gU2F0dXJkYXksIE1heSAyNywgMjAyMyA1OjQ5IEFNLCBQZXRlciBYdSB3cm90ZToNCj4gT24g
V2VkLCBNYXkgMjQsIDIwMjMgYXQgMDQ6MDE6NTdQTSArMDgwMCwgV2VpIFdhbmcgd3JvdGU6DQo+
ID4gcW1wX21pZ3JhdGVfc2V0X3BhcmFtZXRlcnMgZXhwZWN0cyB0byB1c2UgdG1wIGZvciBwYXJh
bWV0ZXJzIGNoZWNrLCBzbw0KPiA+IG1pZ3JhdGVfcGFyYW1zX3Rlc3RfYXBwbHkgaXMgZXhwZWN0
ZWQgdG8gY29weSB0aGUgcmVsYXRlZCBmaWVsZHMgZnJvbQ0KPiA+IHBhcmFtcyB0byB0bXAuIFNv
IGZpeCBtaWdyYXRlX3BhcmFtc190ZXN0X2FwcGx5IHRvIHVzZSB0aGUgZnVuY3Rpb24NCj4gPiBw
YXJhbWV0ZXIsICpkZXN0LCByYXRoZXIgdGhhbiB0aGUgZ2xvYmFsIG9uZS4gVGhlIGRlc3QtPmhh
c194eHggKHh4eA0KPiA+IGlzIHRoZSBmZWF0dXJlIG5hbWUpIHJlbGF0ZWQgZmllbGRzIG5lZWQg
dG8gYmUgc2V0LCBhcyB0aGV5IHdpbGwgYmUNCj4gPiBjaGVja2VkIGJ5IG1pZ3JhdGVfcGFyYW1z
X2NoZWNrLg0KPiANCj4gSSB0aGluayBpdCdzIGZpbmUgdG8gZG8gYXMgd2hhdCB5b3Ugc3VnZ2Vz
dGVkLCBidXQgSSBkb24ndCBzZWUgbXVjaCBiZW5lZml0DQo+IGVpdGhlci4uIHRoZSBvbGQgY29k
ZSBJSVVDIHdpbGwgY2hlY2sgYWxsIHBhcmFtcyBldmVuIGlmIDEgcGFyYW0gY2hhbmdlZCwNCj4g
d2hpbGUgYWZ0ZXIgeW91ciBjaGFuZ2UgaXQgb25seSBjaGVja3MgdGhlIG1vZGlmaWVkIG9uZXMu
DQo+IA0KPiBUaGVyZSdzIHNsaWdodCBiZW5lZml0cyBidXQgbm90IHNvIG11Y2gsIGVzcGVjaWFs
bHkgIjIyKywgMi0iIExPQ3MsIGJlY2F1c2UNCj4gd2UgZG9uJ3QgcmVhbGx5IGRvIHRoaXMgYSBs
b3Q7IHNvbWUgbW9yZSBzYW5pdHkgY2hlY2sgYWxzbyBtYWtlcyBzZW5zZSB0byBtZQ0KPiBldmVu
IGlmIGV2ZXJ5dGhpbmcgaXMgYWx3YXlzIGNoZWNrZWQsIHNvIHdlJ2xsIGhpdCBlcnJvcnMgaWYg
YW55dGhpbmcNCj4gYWNjaWRlbnRhbGx5IGdvZXMgd3JvbmcgdG9vLg0KPiANCj4gSXMgdGhlcmUg
YSByZWFsIGJ1ZyBzb21ld2hlcmU/DQoNClllcy4gUGxlYXNlIHNlZSBxbXBfbWlncmF0ZV9zZXRf
cGFyYW1ldGVyczoNCg0KIzEgICAgbWlncmF0ZV9wYXJhbXNfdGVzdF9hcHBseShwYXJhbXMsICZ0
bXApOw0KDQogIzIgICBpZiAoIW1pZ3JhdGVfcGFyYW1zX2NoZWNrKCZ0bXAsIGVycnApKSB7DQog
ICAgICAgIC8qIEludmFsaWQgcGFyYW1ldGVyICovDQogICAgICAgIHJldHVybjsNCiAgICB9DQog
IzMgIG1pZ3JhdGVfcGFyYW1zX2FwcGx5KHBhcmFtcywgZXJycCk7DQoNCiMyIHRyaWVzIHRvIGRv
IHBhcmFtcyBjaGVjayB1c2luZyB0bXAsIHdoaWNoIGlzIGV4cGVjdGVkIHRvIGJlIHNldCB1cA0K
YnkgIzEsIGJ1dCAjMSBkaWRuJ3QgdXNlICImdG1wIiwgc28gInRtcCIgZG9lc27igJl0IHNlZW0g
dG8gc3RvcmUgdGhlDQp2YWxpZCB2YWx1ZXMgYXMgZXhwZWN0ZWQgZm9yIHRoZSBjaGVjayAodGhh
dCBpcywgIzIgYWJvdmUgaXNu4oCZdCBlZmZlY3RpdmVseQ0KZG9pbmcgYW55IGNoZWNrIGZvciB0
aGUgdXNlciBpbnB1dCBwYXJhbXMpDQoNClRoZSBhbHRlcm5hdGl2ZSBmaXggd291bGQgYmUgdG8g
cmVtb3ZlIHRoZSBpbnRlcm1lZGlhdGUgInRtcCIgcGFyYW1zLA0KYnV0IHRoaXMgbWlnaHQgYnJl
YWsgdGhlIHVzYWdlIGZyb20gY29tbWl0IDFiZGE4YjNjNjk1MCwgc28gbmVlZCB0aG91Z2h0cw0K
ZnJvbSBNYXJrdXMgaWYgd2Ugd2FudCBnbyBmb3IgdGhpcyBhcHByb2FjaC4NCg==

