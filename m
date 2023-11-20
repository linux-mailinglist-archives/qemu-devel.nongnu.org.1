Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BB7F0FF5
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 11:10:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r51E2-0005vc-5K; Mon, 20 Nov 2023 05:09:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r51Dz-0005vF-EW
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:09:51 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r51Dw-00010N-LQ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700474988; x=1732010988;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1eKb7Z2AZVZb93n3zlvEU7/MjBYXMc0ZpV4opOAf9sQ=;
 b=n4ft0Ot3OhKYo0mEYneTrZYLWfB5/Khv3+httQyvpo0ETk1zr+SpzGOg
 acnPcUlgmcy2ZHJ7Hmzt6hPcBAq3DO/N+9bvtro1cavOsjbl0rTo3yUl/
 EdZSPqfDtlzESW4kb1OUiHhpz9Ys5y/P58Z4RPtBrQFpX64tmiTGc8xpS
 Prd82zWboJarE4JriqYrf+tUhz4Iy57iHp2/JxhnqKGVCW9nYu4PojNyr
 jNq60WrTTTKt1E2i+CUwHouBzyZlvjj2hsZlN4+GrSVpn0fBkYkzg4+IX
 6eHMPbDp1eezscYTnP5AWB3TTYlP6qo3EgJ447jhDwBZu3w0keukiWg9K Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13144088"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="13144088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 02:09:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="856944598"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="856944598"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Nov 2023 02:09:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:09:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 02:09:44 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 02:09:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPEwQDYfkpnxSAxFrdlABMaiO6ak15G7aP9W9MZKZweDVJPRJNayW7C5VJgvzpi1h3zUoY7/IJk9p0itVZRXF67yppu3N89o/AgQm/S/EyZr51vlVESFENM27wnH2eqzH2WvwyE3cq4pb+wSumdY3aqEt6alJOk3e6xhKs4UY6wLrk1tGpdgjaUv9+tzPUPI2FQo4xdBSkOcrFSrqdU9QPq/ifrRHqr4csW/n3Jz/GSrj9w/xx/fEhwWNSKg+pnYVKF9dTKudNbeetWzxnytl6qyCTTGIINCNVJROWpxH4YRIJS/QEJkH8eno7YQIQ1fMOeUV0uF/wVITQKYJ4izNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eKb7Z2AZVZb93n3zlvEU7/MjBYXMc0ZpV4opOAf9sQ=;
 b=IhH27dmXwCN75K7dp6uDRAeDDjmifi4oFs/xEfKRSj09OL5GzyPgNHbScxjwvt08wX5KvCTjGR5d9qQwSKIp1aLLZ9eFDyn5G6A/ysexc88pZpiHlZUA74puSrPB5SQeD894CPb6wdK7VoMAYDt+X0ydqOgbqeOpcmo6MmlKKc0gXutP7mNX6EObEphEIxomv5fKyIU6hZsFTo2ZxCGSar1n/a4fC2m6Nf4f1djZQNxHOscmOjqLo1bb62bi3AYQn2K1xKGR0n6H6plEHbnDGXORFO1S8OCYl6GxX4IgAXMYRq94XUAxD+/v9/+VvSTbYmI8lvjztZFEOgbYQgjUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 10:09:40 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 10:09:40 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v6 00/21] vfio: Adopt iommufd
Thread-Topic: [PATCH v6 00/21] vfio: Adopt iommufd
Thread-Index: AQHaFuTmNDpqSpZXBE69ql2uW35WS7CC9ksAgAAOo2A=
Date: Mon, 20 Nov 2023 10:09:40 +0000
Message-ID: <SJ0PR11MB6744FD09AC64D1C9B3609DF692B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <ab076809-9441-4933-a948-83fbb0855dd7@redhat.com>
In-Reply-To: <ab076809-9441-4933-a948-83fbb0855dd7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8183:EE_
x-ms-office365-filtering-correlation-id: 4c3bf07e-3f7a-40e5-2559-08dbe9b0cf3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JtBDv+qpQpZg61vGN7b6ps53YAHhMJD+bhe2UtMn1/fIrBZVG4+ut80H+ehquUXC+nzF2XZPRAlizt00Y5y8bYktVEyVJFgNVS/jslW2Dle/B3ohKoah+qUPAb0LpPlsuAyv/JAC791UdHSMa4nqEZynVz9gq3arD8sbWDgXT5nRA8Jx0Gu7MWqihwnobxzLFu3ywTy4HAjJybyh7A/GOgMiThTZfgzQlVfLMviQ+WDIws7+GM53VFn+ispBYjy/j9QVczQEeoyJ0XnfAPPIDsRC4TdK4fGxf2eOl/s6o+G6Y3rOM4QZXfwqtiGHIPKUvAEWo2f0c70rpMcuNFnAjPWrgQf03uW9KTqIHzvTXNZqz7MAWc4+GnGqp3gekS9G7OqaA0lkY0uiFjMa70oXJLPRRKmrHJnlV7WQxB7prsCp8fmb8/lT7gFfyMm9SMZWGzIZEigBKRxu7pOzSZAIwy+oHVWeMZVVQYAhviXDhuyINuH2pCctEOe6ZxSjD+ZxI4PBkQgkY2DnXcvXBl40kA9C3MaqppFSE+N6uWeBLNATMg/sP5p3vtTM4KjSaDKiGG+7rQRau4LHxfE/MQCaxxCWGKXGC3yKGUQgOJROIDWRI0BawlZdUz9O23WXQU8w
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(86362001)(52536014)(5660300002)(33656002)(2906002)(38070700009)(66574015)(9686003)(6506007)(478600001)(82960400001)(7696005)(71200400001)(83380400001)(107886003)(55016003)(26005)(38100700002)(76116006)(66946007)(110136005)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(122000001)(8936002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGNQcGUxMEpoUXNGT3JpL0Y0YjVaeitmKzV6N3NudDBFOGg3NEdTNFhRejlz?=
 =?utf-8?B?NnVWaU5idXFxS09WeG5oTm9vZDI0Z0pVRWFPVk1id1JFb1ZmakI2Vzc2SkFE?=
 =?utf-8?B?NTFxRWNVeWNXMTRQT1RsWWh4SHRmWFpkVkQ4anZ6bjJ6YzUybnpHNTlBaTBu?=
 =?utf-8?B?cEIzdkl2bVF1NEdFaUdtb0dQdk5iMENJeWJPWHcxb2ZuT2ZoZDVKeTlvcWJC?=
 =?utf-8?B?NUxNNGI1WlhUYnNiVHI3YVFUMDQwV2U4YmNvMW0wcytUcmt1bzl5Z3MvNlJB?=
 =?utf-8?B?TDAySzRwQ0FnSStiNzVQVC9saVZSYit5Z0JCOERweDdtK2FKNmZVQ3Y1dld3?=
 =?utf-8?B?NEN4engvakpORGRRRlFuRUNPSkJWbXQ5U2xqc1pJOUxsajlxaGc2V25DbWxB?=
 =?utf-8?B?REhNT2Nnc3FwVlhQTEpmZkdSeWRPSCt5UzdUWjhyeFlycFRaM3JTTXN0b2NK?=
 =?utf-8?B?R1hqNE9wNm9rYkw1eGZ1cjRRdkJDK1JiRVdnNjJZd0dhbVJlUk5aOW5EeW5x?=
 =?utf-8?B?UWpEZmptU29Dbm05ZDFxajNKaysyQWwzVGdwR1BqSEMxbmhKWG0wb2RoWGRK?=
 =?utf-8?B?TnAzQWloWDl0T3dDWjBnM3lOSHdaTmhDd0R0cGlXSGloMDZoMFJqeXdPdERK?=
 =?utf-8?B?dUlsZjR1ejMyOFdrR2ZFSEFVM0VUcFBrWjFueXVadG1Qb0N3Vm9ZT0J6Mm04?=
 =?utf-8?B?NGJ2YzcwV1ovZTUwNzhjalB3cFo1aGVCR2lDcEF5TFVUZzJ6bGVXZUlnSE8r?=
 =?utf-8?B?enNNL0FJQU1kRDJPWXdEMmNBY1czeTVCNFV3NWxHWWZIaThjanF2WU1mMkds?=
 =?utf-8?B?STVNZUNveHpjdlJmQXRzUjR0eVdaRFBqQlFuT2pOb1Nsa0Vzc3NPZXdUc3hU?=
 =?utf-8?B?N3VHcCtyUE9hNEFJNld0TWlnNFNFUlJxMFAwMzIrdnE4R1dSMHdjU282MVBl?=
 =?utf-8?B?b0FwSG5TaWhyUERHY2FQSSt0Y2pDU1FXcTJEOCtTUmRsMEdJUjQ3VzJqZlp3?=
 =?utf-8?B?ZVlFNHh1K1VZZCsxNG1PYUZYdTMrS3UyYkdJZHNISmVLcjR3WjhVeFFjVS8z?=
 =?utf-8?B?elE2OEhROGttK2RkVFN4aEJzcGVjSHNPRzlTbExROUFmdnNVNWgxSitwREZ6?=
 =?utf-8?B?Vkd2cjJYODNaZDVMMEVUT0JqMHBiZXFOeFNKelNMRk1TOHlOT0c5MjlzNUJK?=
 =?utf-8?B?YUtDUEJIcGtUUVd1UGpyb1NiaFJwOS9DTDVPTWYrbE5ZMS9sQ0lJZFFVN3Vu?=
 =?utf-8?B?RWlIMVJaZ0ZucWtxaXd4UFFBTVU4bWtJVEpObGJ0WU9VWGtFWXhhZEthNXBu?=
 =?utf-8?B?T3VBN1hSbks2YkE3VDllbG81VjgwdEgzazRqQ3Rudlppa1pTNUVhYWdXUUYr?=
 =?utf-8?B?cWh6Z2Qvb2g1R0NFbTdRWFJMZjZlalRIMk5VbUczcld2Mm5tNXJlMzFtV3E3?=
 =?utf-8?B?K0V0bGRFMXpZUmFpSk1sNThDTzM5akZBUitsbSsyRzdMa09yK2ljcTRXZ3Er?=
 =?utf-8?B?ZURlVFYzYllrcytXeU55TlVXRThyd2tOa0haN09yQUg4TTl2M2l6SERRZkcr?=
 =?utf-8?B?WGRFVXpLVk5taDFsY3NoVkFFd1RyNkcyYWwvdWRwTUJGeDJsdEprUVV3Nlpz?=
 =?utf-8?B?NFpISFJqODlpc0x2SEVJSk1mL1lWdVBxV2g4TnBobUU1Q3laNnpjakdCUTNs?=
 =?utf-8?B?d25uOG56YUxrUWhlZ1hhbzFGendqTEhWL0pWNnJETkhRb1l6TE1OZjNRRWs2?=
 =?utf-8?B?OVZFR21KZmtobmRMRHVWQ3ZwY1IvWXZHS01saTROTldaTTVkWEl6Rzh4T2Vw?=
 =?utf-8?B?T1dsZG84SVRBSkExWWNVekRkd3pBY0g0UVQ2TDVHU3JxUmVqaDljejVmVEli?=
 =?utf-8?B?czZKREIyR0tRVnROeXZyYW43bHZOMGY4L1lYS2ZjMHlvZzhvemUzVytCRlZi?=
 =?utf-8?B?QVA2YTR2eGZWU1dKL2s3ZnllY2c5VVNLWU51QXBtUjBvYTJ5N295ZWJFZW1m?=
 =?utf-8?B?NGpkUld3L3JJKzNzRXM2MVV5a2pRWG53OHdhRVpPQ0svc2dCamZ5cVlNNDQy?=
 =?utf-8?B?UThTRnpYdzVNcUt6WjlQTGtvT2xlT3N5OW9GYkU4bEhnaFYxeVBGdEZiNDJL?=
 =?utf-8?Q?mXZJBq9svCLpbYvoDTqC5Gi4p?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3bf07e-3f7a-40e5-2559-08dbe9b0cf3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 10:09:40.3321 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRVndqxrUPOKqUcYr34BW2McltcISgklra1hFGgCw9gsRNhMokqUsvkaEaFQtTAQoSlwgDCOU/ok69bR07If/Zs12HYmBRvRyl+lX4fP1bk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE5vdmVtYmVyIDIwLCAyMDIzIDU6MTUg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAwLzIxXSB2ZmlvOiBBZG9wdCBpb21tdWZkDQo+
DQo+SGkgWmhlbnpob25nLA0KPg0KPk9uIDExLzE0LzIzIDExOjA5LCBaaGVuemhvbmcgRHVhbiB3
cm90ZToNCj4+IEhpLA0KPj4NCj4+IFRoYW5rcyBhbGwgZm9yIGdpdmluZyBndWlkZXMgYW5kIGNv
bW1lbnRzIG9uIHByZXZpb3VzIHNlcmllcywgdGhpcyBpcw0KPj4gdGhlIHJlbWFpbmluZyBwYXJ0
IG9mIHRoZSBpb21tdWZkIHN1cHBvcnQuDQo+Pg0KPj4gQmFzZWQgb24gQ8OpZHJpYydzIHN1Z2dl
c3Rpb24sIHJlcGxhY2Ugb2xkIGNvbmZpZyBtZXRob2QgZm9yIElPTU1VRkQNCj4+IHdpdGggS2Nv
bmZpZy4NCj4+DQo+PiBCYXNlZCBvbiBKYXNvbidzIHN1Z2dlc3Rpb24sIGRyb3AgdGhlIGltcGxl
bWVudGF0aW9uIG9mIG1hbnVhbGx5DQo+PiBhbGxvY2F0aW5nIGh3cHQgYW5kIHN3aXRjaCB0byBJ
T0FTIGF0dGFjaC9kZXRhY2guDQo+Pg0KPj4gQmVzaWRlIGN1cnJlbnQgdGVzdCwgd2UgYWxzbyB0
ZXN0ZWQgbWRldiB3aXRoIG10dHkgZm9yIGJldHRlciBjb3ZlciByYW5nZS4NCj4+DQo+PiBQQVRD
SCAxOiBJbnRyb2R1Y2UgaW9tbXVmZCBvYmplY3QNCj4+IFBBVENIIDItOTogYWRkIElPTU1VRkQg
Y29udGFpbmVyIGFuZCBjZGV2IHN1cHBvcnQNCj4+IFBBVENIIDEwLTE3OiBmZCBwYXNzaW5nIGZv
ciBjZGV2IGFuZCBsaW5raW5nIHRvIElPTU1VRkQNCj4+IFBBVENIIDE4OiBtYWtlIFZGSU9Db250
YWluZXJCYXNlIHBhcmFtZXRlciBjb25zdA0KPj4gUEFUQ0ggMTktMjE6IENvbXBpbGUgb3V0IGZv
ciBJT01NVUZEIGZvciBhcm0sIHMzOTB4IGFuZCB4ODYNCj4+DQo+Pg0KPj4gV2UgaGF2ZSBkb25l
IHdpZGUgdGVzdCB3aXRoIGRpZmZlcmVudCBjb21iaW5hdGlvbnMsIGUuZzoNCj4+IC0gUENJIGRl
dmljZSB3ZXJlIHRlc3RlZA0KPj4gLSBGRCBwYXNzaW5nIGFuZCBob3QgcmVzZXQgd2l0aCBzb21l
IHRyaWNrLg0KPj4gLSBkZXZpY2UgaG90cGx1ZyB0ZXN0IHdpdGggbGVnYWN5IGFuZCBpb21tdWZk
IGJhY2tlbmRzDQo+PiAtIHdpdGggb3Igd2l0aG91dCB2SU9NTVUgZm9yIGxlZ2FjeSBhbmQgaW9t
bXVmZCBiYWNrZW5kcw0KPj4gLSBkaXZpY2VzIGxpbmtlZCB0byBkaWZmZXJlbnQgaW9tbXVmZHMN
Cj4+IC0gVkZJTyBtaWdyYXRpb24gd2l0aCBhIEU4MDAgbmV0IGNhcmQobm8gZGlydHkgc3luYyBz
dXBwb3J0KSBwYXNzdGhyb3VnaA0KPj4gLSBwbGF0Zm9ybSwgY2N3IGFuZCBhcCB3ZXJlIG9ubHkg
Y29tcGlsZS10ZXN0ZWQgZHVlIHRvIGVudmlyb25tZW50IGxpbWl0DQo+PiAtIHRlc3QgbWRldiBw
YXNzIHRocm91Z2ggd2l0aCBtdHR5IGFuZCBtaXggd2l0aCByZWFsIGRldmljZSBhbmQgZGlmZmVy
ZW50IEJFDQo+Pg0KPj4gR2l2ZW4gc29tZSBpb21tdWZkIGtlcm5lbCBsaW1pdGF0aW9ucywgdGhl
IGlvbW11ZmQgYmFja2VuZCBpcw0KPj4gbm90IHlldCBmdWxseSBvbiBwYXIgd2l0aCB0aGUgbGVn
YWN5IGJhY2tlbmQgdy5yLnQuIGZlYXR1cmVzIGxpa2U6DQo+PiAtIHAycCBtYXBwaW5ncyAoeW91
IHdpbGwgc2VlIHJlbGF0ZWQgZXJyb3IgdHJhY2VzKQ0KPj4gLSBkaXJ0eSBwYWdlIHN5bmMNCj4+
IC0gYW5kIGV0Yy4NCj4NCj5GZWVsIGZyZWUgdG8gYWRkIG15IFQtYjoNCj5UZXN0ZWQtYnk6IEVy
aWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIEVyaWMsIHlvdSBtZWFu
IGFsbCB0aGUgcGF0Y2hlcyBvciBhcm0gcGFydD8NCg0KQlJzLg0KWmhlbnpob25nDQo=

