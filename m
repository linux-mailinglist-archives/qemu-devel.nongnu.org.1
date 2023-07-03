Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBB74554C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 08:08:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGCiY-0007zJ-Gq; Mon, 03 Jul 2023 02:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGCiK-0007yj-HY
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:07:09 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qGCiI-0006ix-0W
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 02:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688364425; x=1719900425;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wgE2ou83KmN+4kaNCsDZ++7j3WA+lmKUvb+C7KxUrjg=;
 b=WHtlhp1fYmjCjTMVPISIzEzj82phcOEEjw0WjtIMYlTc/xDw1zlI2xaq
 Z7ZvGp/K6Sql/ngwsAdCnmWw1nq0AtJJTYydrhbhLCyY8XJ5aznNIC3PY
 3qxd6E+efHdq4+X266tLkG2RJ+XWAW9uBohWuaLFHcKkIJVTTiWOsE2/Y
 ymOpFLdxtxlnacOxz4qrScQ/gdPyO4mQ/JWkcIoXcDlsI2YfvnlvhYAKD
 BDGel4oTSQyyimh00+cBfBOQoscKsOgDpkNShQORNevkzLpdg1X0+R9Lf
 T9QDQXOSsIzdaeppAingm2R0REIyMD1isN272PxA7d54031XBQhB/VYmo g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="342391810"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="342391810"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2023 23:06:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="712441733"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; d="scan'208";a="712441733"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga007.jf.intel.com with ESMTP; 02 Jul 2023 23:06:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 2 Jul 2023 23:06:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 2 Jul 2023 23:06:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 2 Jul 2023 23:06:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoZQXzPbNnnvPvNzN2k5D8+6jhB0WFEU5bQvdX4aWNUxF/aKHTSAGgIDujJ9L+AdKj8jM55uobYAN5wb2xci9Ou5QWq6qTF3IXEcxLggB7uPq9eCeuevQBwUd5sxIHNjZTAi7HF7LnTgozW3MPQ7S687U05BA0ejTJ+s/ZZ2+Og4+8jKTjmYX5tDsrkpuBghi8HmYwlWQ4CcTShOM91yFb+WIRXqpzSF1uBOg3QUN8H/SyTP9brkO7BgVAzKAL2aInwygtvaUohAG1KARGX4keQOyOgj8nsxjWCdCxfw7Q4Zn9vIlskhCku7KR5qySypQQZh13H451gMy0cLXTxsLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgE2ou83KmN+4kaNCsDZ++7j3WA+lmKUvb+C7KxUrjg=;
 b=jqA4RoZnlosNzCGBOaaBx8WfnbNgNBneeIVCPYYN8YpAYLYNxQKWAPo9/OGU4bL33sDuxTZBTx7nVZUSv8uJrrREUdzQdmBD0cexWdSL7tcA7C0GdPOYYd3D663tpIFxJtTHf7yhREoOf3Mdb9UxMZEkPcbhzVqbhXf0HUgCvgsW9xj8IfUmpvWpamKszaqybmQ/6Rd6ZuXJjq1RkjJl/8tlQUr/CopXKo/BslvEqgoSQXSd9aRXlGCtIINxM0qiH5Urv8EuTJSLUD1lSz59ayxZVo2bWnHue8Qe/pByH+/2em0VQNJh5VCN+JprCl+dLkHfROYwonAA6MZWOEeHMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW3PR11MB4524.namprd11.prod.outlook.com (2603:10b6:303:2c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 06:06:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::f580:d6a6:47a1:95f0%6]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 06:06:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, 
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 5/7] vfio/migration: Change vIOMMU blocker from global
 to per device
Thread-Topic: [PATCH v5 5/7] vfio/migration: Change vIOMMU blocker from global
 to per device
Thread-Index: AQHZqyd+mNzTtI+Nj0eCS+ym2XRPS6+jMnmAgARgFNA=
Date: Mon, 3 Jul 2023 06:06:52 +0000
Message-ID: <SJ0PR11MB674407593800C8A4DAE29D459229A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230630073637.124234-1-zhenzhong.duan@intel.com>
 <20230630073637.124234-4-zhenzhong.duan@intel.com>
 <f203dcf3-5af5-07ff-a1d1-59c70a31a8a7@oracle.com>
In-Reply-To: <f203dcf3-5af5-07ff-a1d1-59c70a31a8a7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW3PR11MB4524:EE_
x-ms-office365-filtering-correlation-id: f38ee25f-020c-41c3-ab7e-08db7b8bb299
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQyJ4/8XzXxR+SIGSl92yU4rdefAEdOgoGMigApWb/R3H6AnJdWZNjb3aBc6bZ8ANiLZNF5GKFn9RcmkULEmt0/eoBIsYwELbPJQCj20Az2x3GRKOkREhgE8wXAWd2o8UMiojU/m3A2iCjhhbsCHOOnCa3+2ZglSN1xGXQM37J4PTHNcsT0lGS8Mf3hepJYgkpx8HfRFUjsI5k4IitmKMlELwM+kV8AzY5zs6gI/WExMJrI0dhjDrsNaXr6wkEYcU5x7QUDXmK3LLGq6JX1QB0BzXWDayXTMk4Za16ajoKj0T8Awtkv8G8IOksCpTl1Kk0Lo1ToZAL1/uOch9Sb48UDmrrRjWk/QvCi+la/z0JnOzp4kJMT2O8lcQzdUpIHNVoX9pnQsjVTu+mJp9a1r+S77OpVjzMPLr8UmPZamMsH5zuzcPOxvC0v1RwrIK1e9lHctAZ5yR5iBnwu0XCy0XkaxrZ2E49xFORj9qaZvTT8aIflgkMw7HYQXmLBOW7WfLzQyw8R/Em1hs0AN64VzkRtymc3+N3mk+OVD+ApiwUq6lj1jNlEBrES8Hr1QouUanwkkC738pcvjJx77Z18nALpBiSRZUCdfXLklPJI4GciK15KDzNbgf/pfKxMZB3Dp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(122000001)(71200400001)(478600001)(54906003)(82960400001)(110136005)(52536014)(5660300002)(8676002)(8936002)(2906002)(38070700005)(33656002)(86362001)(38100700002)(76116006)(55016003)(66446008)(66556008)(66946007)(64756008)(66476007)(4326008)(316002)(41300700001)(107886003)(83380400001)(6506007)(26005)(9686003)(186003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGp1bUZ4M2x4NGUzWGFLdkIyc3E1allWSEhVZjk0K3FrVXJBK2lUTVFucXJa?=
 =?utf-8?B?WmtFRUMrV1hPWFZsalZxVDV1ZjFGRytVUnZvQ2d5OEpoS0VUY3RUamsvcEJu?=
 =?utf-8?B?dGJxWGF3cnBRMEZPQU9nUnRTWEFuQmdqcGJzRDBFd3E5YzJRUzNiTE1wcFhl?=
 =?utf-8?B?d1NTaU83aHhoeldDckJuOGtEbmoxUjlKTU1JLy9QZmphU3l3ZzlIMHhJc01R?=
 =?utf-8?B?dHpkQU9PUzQyWjNvL2lCNmFQZUFMem56aFJuN3RDSmJxdWh6dE1sTXZJTUJz?=
 =?utf-8?B?NTdyUXZiMlRyazlZdmxNaXA5NnJBcVdiUm0vQ2lSZCt2K2FlRWwyYkp1Y24w?=
 =?utf-8?B?T0NsTExOTW10MTZSYjRXdGlRZHlBR0ZuQ2tNYmFPYzhSd2xmTzJyaVpHL2lS?=
 =?utf-8?B?N3FlYnU1UlVOcTZtWUM0RERPa3lsQ2kvQzJLQ3FPcTBtZFZsYWpqa2xYbWlK?=
 =?utf-8?B?VEkwRWo4QzNTdmRVNGNSV0g1anpDdlNsbFF6UEtRY2hKN21lMVZXcG5RaWxR?=
 =?utf-8?B?c1BHeFhQRXV1dUNuMGp4dUh3bHZoUmYrWnVSeE1VeE9HSllDSVhCQlY3THhX?=
 =?utf-8?B?UExDS3M4dURoZlB2YklGWnRib1JrS21hOFRITVM1bzZJVG9ZMW9BTmVVelp2?=
 =?utf-8?B?M3BJRjc5eVA5NW5oKzlzbldjWjBKWkJySUFwMGJMUU1jY2hZUGF0TzlKMUdZ?=
 =?utf-8?B?bllGRVlhd0ZzbkJwYUJoZW5XZ2NjSE05VU1Lb0xrb0YwOUR2Z0t2WjBmVGg3?=
 =?utf-8?B?a2xGN2t6cEZsQnNKbUlNTFZSd3IzWjYzV2dpcUF0eERWR2dEazVJdHR3WDRu?=
 =?utf-8?B?YnA4UFRrVHlva3F1ZVN2WHc4VzFiTEJxZnpNWmZ1NEhrVXZQdkdsUU5VcmdU?=
 =?utf-8?B?bzBOakdYYS9jcmNCQSs2cFdVMnlSRHVLMk1hNjZQVXB2dWJUbENldkJDM21z?=
 =?utf-8?B?clZRSEJpUDhxaFZpRHYwT3JiMG1PWXVPdlY5WXZ0dW93ZjlYcUN4TmYvVmZr?=
 =?utf-8?B?SXI0Z2dTVlUvREgySEtqcG5qWU1NbmFnQW04N1FoaTZzeHFVcEtzMFpTSWZQ?=
 =?utf-8?B?WDhLMXMxWFhvd0U1RnQrTmtPM0NEcmdFenpBZWZrRUZTOElmekxCRHdSVEJH?=
 =?utf-8?B?eVMxM1VmRnJ0cEVCL0gvejVUd1hZdjJhczhBcVFMVlhGall6MFpSZDA0NWVK?=
 =?utf-8?B?WW55V0ZVeFdvRDB2S2ZFeVozeGQ0R29kM2Z2SXVHeG40QW5odWxzdUg5NlZw?=
 =?utf-8?B?N3VKK0dwdzI5d2FLM1R2cHFJa3FvU05XTVlEWVp4UUlRZ1hjSFpHZmtxeCta?=
 =?utf-8?B?eDRHTDRINms5UG1NblRoNmo1dVZlT1hZUUhEZE1HV1p3U2N5U0lyT1dPNzBL?=
 =?utf-8?B?cEM2YitVWDNWelIrNHJTQUs1aDhxK3Bkem5pU0hVSWpxRmlkNnlBSVl6MUh0?=
 =?utf-8?B?T3kvVEI3WmVWb1J3ZS9KOC9xYk5vSWFUQTRPNDIxUFVrcEtpVkFmcVROMWNz?=
 =?utf-8?B?WTh5dUV6dlI0NGxVdStuVDd6WitJR3BJSmc5Zms3TGxEU2VpQTNCMjdaUEw0?=
 =?utf-8?B?US9yRzVkSTdSL2gvaEE2WENpSkI5UllQN0l6VzF6L1htRFFHci82MkpNTnRL?=
 =?utf-8?B?bkMrZ1hud3B4WGpyWHQ4cXFkZzU0S1VpKzJmUG5ZU3MyWFE0eVpxNHF2WkhB?=
 =?utf-8?B?L3MvNTBaaWd6ckUzUGIvTXgra0FkbDhOM2JvbG50ZUN1OXlXNlVyQXVEZ053?=
 =?utf-8?B?ZGJqUDZhSDEzTkl3Y2xUYzNGZVR2WFFVTUhVaURGdUZTMmJJL0txRWZaelB1?=
 =?utf-8?B?Y1JjU1lMUEJHOGs0SnhxK05pMWV0WW5wUFY3N2dRU0NDRThIa2VEV0ZkenBz?=
 =?utf-8?B?Zkp6bEczS0JJOE1yWDBQWkFielBXUEpaVXZDZkc3eFdJKzBxSFJQUGh4MEhM?=
 =?utf-8?B?dHJvcUg3UmNYZHRFWHJHQjV0ZXhWNGR0VnltNFRETEd4aWJocTVtVFRENkp2?=
 =?utf-8?B?a3ZCQXNXcnZiOXBzOWcrOWZBUUFoazNWZVA5UzlRMjVrZnl2cGQ0S0hURWF4?=
 =?utf-8?B?T3orL3R1bnc1QkRpcGk3d3pvSEVwWURyT3BmMGhQYUxsWks4c0pPY1RrRzBa?=
 =?utf-8?Q?TZ4xSPhmyZp1dZWQ7WbTGJWRq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f38ee25f-020c-41c3-ab7e-08db7b8bb299
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 06:06:52.9894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZZSyx/jnr3GXjce+7Wt6bYAbr742GUSPbEZKSPzxb1TzIqQB2QFoHui0T8aMIJ9Ofm3Yv4r0oB/xMH+EEWnMR09O3VFlX2yVcpB3Rw4Mm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4524
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IEZyaWRheSwgSnVuZSAzMCwgMjAyMyA3OjE3IFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzddIHZmaW8vbWlncmF0aW9uOiBDaGFuZ2UgdklP
TU1VIGJsb2NrZXIgZnJvbQ0KPmdsb2JhbCB0byBwZXIgZGV2aWNlDQo+DQo+T24gMzAvMDYvMjAy
MyAwODozNiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiB2SU9NTVUgbWlncmF0aW9uIGJsb2Nr
ZXIgY2FuIGJlIGNvbnNvbGlkYXRlZCB0byBwZXIgZGV2aWNlIGRlZmF1bHQNCj4+IGJsb2NrZXIs
IHRoZW4gc29tZSB2SU9NTVUgZ2xvYmFsIGJsb2NrZXIgcmVsYXRlZCBmdW5jdGlvbnMgYW5kIGRh
dGENCj4+IGNvdWxkIGJlIHJlbW92ZWQuDQo+Pg0KPlBlcmhhcHMgZXhwYW5kIHRvIHNvbWV0aGlu
ZyBsaWtlIGJlbG93IG9uIHRoZSB3aHkgaXQganVzdGlmaWVzIHRoZQ0KPmNvbnNvbGlkYXRpb246
DQo+DQo+Q29udHJhcnkgdG8gbXVsdGlwbGUgZGV2aWNlIGJsb2NrZXIgd2hpY2ggbmVlZHMgdG8g
Y29uc2lkZXIgYWxyZWFkeS1hdHRhY2hlZA0KPmRldmljZXMgdG8gdW5ibG9jay9ibG9jayBkeW5h
bWljYWxseSwgdGhlIHZJT01NVSBtaWdyYXRpb24gYmxvY2tlciBpcyBhDQo+ZGV2aWNlDQo+c3Bl
Y2lmaWMgY29uZmlnLiBNZWFuaW5nIGl0IG9ubHkgbmVlZHMgdG8ga25vdyB3aGV0aGVyIHRoZSBk
ZXZpY2UgaXMgYnlwYXNzaW5nDQo+b3Igbm90IHRoZSB2SU9NTVUgKHZpYSBtYWNoaW5lIHByb3Bl
cnR5LCBvciBwZXIgcHhiLXBjaWU6OmJ5cGFzc19pb21tdSksDQo+YW5kDQo+ZG9lcyBub3QgbmVl
ZCB0aGUgc3RhdGUgb2YgY3VycmVudGx5IHByZXNlbnQgZGV2aWNlcy4gRm9yIHRoaXMgcmVhc29u
LCB0aGUNCj52SU9NTVUgZ2xvYmFsIG1pZ3JhdGlvbiBibG9ja2VyIGNhbiBiZSBjb25zb2xpZGF0
ZWQgaW50byB0aGUgcGVyLWRldmljZQ0KPm1pZ3JhdGlvbiBibG9ja2VyLCBhbGxvd2luZyB1cyB0
byByZW1vdmUgc29tZSB1bm5lY2Vzc2FyeSBjb2RlLg0KR3JlYXQsIHdpbGwgdXNlIHRoaXMgd29y
ZHMuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

