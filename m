Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8C580C134
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:15:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZZ4-0001Bz-Dg; Mon, 11 Dec 2023 01:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZZ2-0001Br-8w
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:14:48 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZZ0-0001C6-DQ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702275287; x=1733811287;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JeAanKI9xVqQph5myBZ6LYA0toS+3EGjNz5rLobO5P8=;
 b=FfKbnEWd9sdxVrEmJNodmGZ8HLKgwLckuWx2lwxLVJUG/3BmH7mJVtZJ
 lg48iTA7VsJ4wuL1pTwi34A1O/aWnamnc0PYnUZsJcw/hq7796G8ym1fh
 7nIpuLoFjbPda5Rh+D66e7Bx9xBTYr9YeZJCBW826cvNPnj+W0EQO8aLx
 1Eyzp7NvsZI8nrNVCpzvgUomIeslW0YiG7rZexU6bElfnXk37Ki3Qk45t
 bt0dg2Z3JJX29/woMT0GBvbrQlB2td4hiBSgg5CLvGz+nMilH8Zg5SbVA
 LDyU5WbbdrmLxM94BwIlb1Lg4hBUqnnSc68hymUM06rjtD9jRPdGpG3ua w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="1436596"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="1436596"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 22:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="807175101"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="807175101"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 22:14:42 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 22:14:42 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 22:14:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 22:14:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMpV0J9FAj1gR467pC2DaGYT1EzkGObAUI+GHHHzDvQrB/9D2GxVLiyKRi6XYp/7Y4OUQcmC4POdLgquR70IRNrBe8nXUq4p4cevtcpFUbd+cDK4GwQhpvUtvHavIllPhDVFd0ZAbqVmTmCJBYqW8OG+1RAu5cuBkR0sTbajASHUQqrd538Yhc8Z2vQ8wKUekOO91EwcpYrNZBbxZTwmGkN3Yfdcd6kwtuVR++VjBDDBlj2kKpcH4w+9Z2e18IzqXwQ49dHd6wOjzrD5CooWdu4AwZVNRq5Y+zc3h1TkU8GfmFR07RYc0TfgS+XuajzNc1mLL6C/yXs9obu+9PzJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeAanKI9xVqQph5myBZ6LYA0toS+3EGjNz5rLobO5P8=;
 b=cPoCUzlAn4YA26GySmBu/Kpw1uvGIwbOVX0YkFirYJXTUlzmkDIDBuPy0dF8m1MSw1JMUcEJCXvMYmpnrTJp/Q70LmTfxXgSyvdAtkLYB4RyXKCwFJBrwf0fRyZ2UG+KYv1AjkW/e53DFu2t8DOBZIPpp90DBaXwuMge/TXDic3rZCVYR/WeUetzRgkrSToUysIm8vRIFOQ3sfUuN6pM5JJjaPlhbgJN0/Br1UNcxbxkU1fC30/5o+mWmc/1fJrMokMqUEpWNnsyAp/bX1mmWwXK0pJaRaEHyQy3YZdaRQ1LU87Ux59clEBdj9cuO67J6BRDS6JYcms7tW+6SZQRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7557.namprd11.prod.outlook.com (2603:10b6:8:14d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 11 Dec
 2023 06:14:38 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 06:14:38 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 05/10] vfio/container: Introduce a VFIOIOMMU
 legacy QOM interface
Thread-Topic: [PATCH for-9.0 05/10] vfio/container: Introduce a VFIOIOMMU
 legacy QOM interface
Thread-Index: AQHaKbMnjHmF4eF9MU2zFA7f+slNK7CjngqQ
Date: Mon, 11 Dec 2023 06:14:38 +0000
Message-ID: <SJ0PR11MB6744BFFFC1507716EF630EEB928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-6-clg@redhat.com>
In-Reply-To: <20231208084600.858964-6-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7557:EE_
x-ms-office365-filtering-correlation-id: 6d5dba61-e967-49b2-7513-08dbfa107498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O6nADjxQnpAuPOyyjBAwjX8ITVxvv/mwlcRRQN243XO+hziThwdZKf7s9TO1PH5s4x1yVdQQyI9F68lLwmXggr33MrlJJ9PvBsYlVgY4r6H9lwQPapu9jrXg8U20gwWdWuCm8DghyxHVZTu7bQlTQCHL7wWcn19S6N+df/BT4EiEje9puhSgfcLS6Hy4HvYe6XzCUEdxjaj0BPBVhbXRSyGJrPG98cQzumIZdXhSxEWiiwXOXrTYGyn66Jm6X9ySiWlklLlkYRw/R5taja65WjKHskutJfmfGshMBBKbFc5TsCntZ+A/1Bvac3YEjm2w+wstSfwufF7ojZl1s/nq74tA8gkn1PnjqV1nGq0NRWM619Q5ZW62Xs//KosqDduJ+4avucX835y1rKrXHcVdaZVVj9/QOvpOnQmIp1kPNVxfwuxoR0uN7oL4bepOyv+E689kCMLuZRH+qBsotiglTrpNu7kmzgnUsVsOMtQyLCq3iypzLyZVYf0dIkXOamKNNAN0N3vLl0z6ke9IzYlDKnFMnRKOr1zK49kgOTab90Z4Gn2Ikc1InU6VkMMXIENMGuRCtxtuV3zO/IOIblHB4y6cR0NwC+kv9jS5joXL6xE8Wftr3vy5RwYze6s+8Tez
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(366004)(396003)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(52536014)(8936002)(8676002)(9686003)(41300700001)(86362001)(26005)(83380400001)(316002)(54906003)(66946007)(76116006)(110136005)(7696005)(66446008)(64756008)(66556008)(4326008)(66476007)(38070700009)(71200400001)(6506007)(38100700002)(478600001)(82960400001)(33656002)(122000001)(2906002)(55016003)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFNxRXdmRXlxWjRuY0RJb1dxdVZCY2FRTlpnYzBmK1lNL2IwdUkxQUxlT2lY?=
 =?utf-8?B?TGEvd0dXNjNZSjJVTnU4eXU5TkpjK2xTcWNKc2NsSjVDM1NaQXBNK2FQa1Zp?=
 =?utf-8?B?ZWdnSmoxM2thN2lISnUvTE96V21yVjB1VzJlbk5lVUErQ1RKb0JiSVJENVYr?=
 =?utf-8?B?MjQrL3JQZFBTUWhQTXN5WWNWTjdaTEl0SHk2alpXUWNhSGdkM1BkQXNNaDY1?=
 =?utf-8?B?Y211aWRGY2gwM05UWjFyZjNNTXQrcWhucUpPbnUyd2t1Y0J5a2FNTzRZZ1gw?=
 =?utf-8?B?c0tud21OWEJneVJVeitBTS9wM3lJNm9KWVQyK1FOd09qQ1FGRkVXai9UWTI1?=
 =?utf-8?B?bGRuQzdSeTVyZmEwRk9NcUFBZ0hkTWxGUzhwcTNMdlM2MnRucHk5MndYdWZV?=
 =?utf-8?B?anZnTTN5SGNtckRETXhPNUtZMzY1SzRoYUhPQkFGb2lZQ0lrYWMxNmN1L2Nh?=
 =?utf-8?B?cWVlM1UvRDdlMmtLSXFORkRGUHNEd2E2dmhPdUZMeDVYVWFKdmpyRitHNmo5?=
 =?utf-8?B?bEtiQWhYa0tFSEIrQWoxajcxZnhTRERIeGc5RU5UTDFubThyTUFQNnoyOW84?=
 =?utf-8?B?bWRIU0RqOEZrWHJxajF1N01CRjF4cGgrRGp6cWJ0Sm5qQWRIUXVaNTEwNkNs?=
 =?utf-8?B?cnpsWFliaHYyTnRrNmNHYXUrRk5MUDFEMmJqOG8vMXFHRjZQZXZkNnZoaCtk?=
 =?utf-8?B?eStaK0p6VnU1czdCQzhpa2V4Q2VXdHBsMnNFdGxPYldPYzBEUzZ1SEpVcXVx?=
 =?utf-8?B?M2RTVGd5ZWVBeGNWcENoVUZJRmZueUF3T3pNUjZyVi9aVm1IL1l4S3dkMC9o?=
 =?utf-8?B?ZFR6TCtpaVF6ZGZJSDZoRkpCL3pFUlE0MVU3bGNKRnlEdGR6em9JcnRqWHJ6?=
 =?utf-8?B?NnlTOHBRMzJHb2lQcXdjcTQybHdsSDBZeHo1cWJBZEZKQko3ZHVrQ0wrRmxW?=
 =?utf-8?B?ZkRwdjhGRmxkWTFycDRSMXgrOXB5QW5rVldYdHM0WXhYdTROL0RVR1BLbFJF?=
 =?utf-8?B?UHZiSmFnbVZZZDltY1FsazNXN2RveWNzR0orbUdYWWxvYitvbXh6SStqeUgz?=
 =?utf-8?B?cmE5TlFKQ2hZTnczK0tUbkE5c0IwSG94VTFhU2ozaWo4SVJoN2NGOUFtcy9T?=
 =?utf-8?B?cGFNbFpKbnBPSC9pK3FDcTZvS1JxaUU0bCtGOFl6cG1SOGJNa2F1UFhBMC9F?=
 =?utf-8?B?d3N1dExzaXV2MXU3RkNhd3F4NnA1TFZHeWFNQ3FJUjN1QVA2NnFyelYrbDJ2?=
 =?utf-8?B?eFFpandpVCtYSnF6U3RoRWN5am9XemZGMmNCVjlLMC9UazFRMC9nYmQ1d1BF?=
 =?utf-8?B?a2hTRnVsZzlMdGFzNGF4Ujk4TzZza0QzU1kxL0FOVi9xdU5GTEVJWXlwRklP?=
 =?utf-8?B?aStEZXFvdTc4aEdaTGlNT09nL2RreFJnWS9GYjBqMS94REdGUWpGNUh1M21Q?=
 =?utf-8?B?WmttOFozemYxYnp0QWtrTm1JS1JHQ2g2MmU2aytVd3AyQWZnVFRpc24xVGFm?=
 =?utf-8?B?Tk9xNHhGY0dNUzQ3OXRIZFB4RzRnWDNONjVBdXZwY3VVTk5YZndHWkhPcDhI?=
 =?utf-8?B?bjliMjJ0YWJWQXhKUUJwalFhRUU0bFM5QnVGaEk0ZVJUSEJsL3MwRUZab0NS?=
 =?utf-8?B?YzBuVkJMNWZISmMyZzVqOVUxOVVJSWZtSWZnWjV3WXF3K2JUMzhQWExxNVR3?=
 =?utf-8?B?cTVoY1haajlrOVk4M2p3cU1YNmU4RGZnYXhKVHlMWmxBeXF2S2luNlhRcVo1?=
 =?utf-8?B?UFFwclVWeHNZcCtBMUNIZ04xMDQzOVRyQXFSRGxTSU5TVjFDbi9aZFcxY1Uv?=
 =?utf-8?B?dVo0SEJ0YkUwSTBZVlNMc3R4eWJaS0t0amlibmxMS1pzeG8zdGRIbXg2eHRu?=
 =?utf-8?B?UlNBbnljSW40Ymt1L1VDdHg3YjlMZHI3SXRFcFVFaXNxVGNoV3dONHNQUE45?=
 =?utf-8?B?WExqc0t5bHZubllaUjJOOFZYVU1qcGlVdko0V3lhYTRmc2Rhd3M4Tm52NmRn?=
 =?utf-8?B?Vzg5eHFPYTgxdGJUdFJhNzRnY245QW1GUklld1Jqbk5mVVdjNFRUSmtXUEEv?=
 =?utf-8?B?V3hKdVplSmg3OVp4Z1BOblJveWRZbHRLNVlMU3VPeDF5cmJGc0RHMGJtSi9M?=
 =?utf-8?Q?gq8849ZArQxqkaOWnyvMCcy21?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5dba61-e967-49b2-7513-08dbfa107498
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 06:14:38.5128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNa65ovK5014+BrXQWnY/OqLOeajaXeRoe48tfHfqWm5GSMPLQo3PvLa2WQtwBfHYQAg4BmV35vJdDriskE0dvzvBVJ8M9b7OCxvrF05BhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7557
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.11;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIERlY2VtYmVyIDgsIDIwMjMgNDo0NiBQ
TQ0KPlN1YmplY3Q6IFtQQVRDSCBmb3ItOS4wIDA1LzEwXSB2ZmlvL2NvbnRhaW5lcjogSW50cm9k
dWNlIGEgVkZJT0lPTU1VDQo+bGVnYWN5IFFPTSBpbnRlcmZhY2UNCj4NCj5Db252ZXJ0IHRoZSBs
ZWdhY3kgVkZJT0lPTU1VT3BzIHN0cnVjdCB0byB0aGUgbmV3IFZGSU9JT01NVSBRT00NCj5pbnRl
cmZhY2UuIFRoZSBzZXQgb2Ygb2Ygb3BlcmF0aW9ucyBmb3IgdGhpcyBiYWNrZW5kIGNhbiBiZSBy
ZWZlcmVuY2VkDQo+d2l0aCBhIGxpdGVyYWwgdHlwZW5hbWUgaW5zdGVhZCBvZiBhIEMgc3RydWN0
LiBUaGlzIHdpbGwgc2ltcGxpZnkNCj5zdXBwb3J0IG9mIG11bHRpcGxlIGJhY2tlbmRzLg0KPg0K
PlNpZ25lZC1vZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4tLS0N
Cj4gaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICAgICAgICB8ICAxIC0NCj4gaW5jbHVk
ZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8ICAxICsNCj4gaHcvdmZpby9jb21tb24u
YyAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrLQ0KPiBody92ZmlvL2NvbnRhaW5lci5jICAg
ICAgICAgICAgICAgICAgIHwgNTkgKysrKysrKysrKysrKysrKysrKysrKystLS0tDQo+IDQgZmls
ZXMgY2hhbmdlZCwgNTYgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAt
LWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92ZmlvL3Zm
aW8tDQo+Y29tbW9uLmgNCj5pbmRleA0KPmI4YWE4YTU0OTUzMjQ0MmEzMWM4ZTg1Y2UzODVjOTky
ZDg0ZjZiZDUuLjE0YzQ5N2I2YjBhNzk0NjZlOGY1Ng0KPjdhY2VlZDM4NGVjMmM3NWVhOTAgMTAw
NjQ0DQo+LS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4rKysgYi9pbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPkBAIC0yMTAsNyArMjEwLDYgQEAgdHlwZWRlZiBRTElT
VF9IRUFEKFZGSU9Hcm91cExpc3QsIFZGSU9Hcm91cCkNCj5WRklPR3JvdXBMaXN0Ow0KPiB0eXBl
ZGVmIFFMSVNUX0hFQUQoVkZJT0RldmljZUxpc3QsIFZGSU9EZXZpY2UpIFZGSU9EZXZpY2VMaXN0
Ow0KPiBleHRlcm4gVkZJT0dyb3VwTGlzdCB2ZmlvX2dyb3VwX2xpc3Q7DQo+IGV4dGVybiBWRklP
RGV2aWNlTGlzdCB2ZmlvX2RldmljZV9saXN0Ow0KPi1leHRlcm4gY29uc3QgVkZJT0lPTU1VT3Bz
IHZmaW9fbGVnYWN5X29wczsNCj4gZXh0ZXJuIGNvbnN0IFZGSU9JT01NVU9wcyB2ZmlvX2lvbW11
ZmRfb3BzOw0KPiBleHRlcm4gY29uc3QgTWVtb3J5TGlzdGVuZXIgdmZpb19tZW1vcnlfbGlzdGVu
ZXI7DQo+IGV4dGVybiBpbnQgdmZpb19rdm1fZGV2aWNlX2ZkOw0KPmRpZmYgLS1naXQgYS9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8t
DQo+Y29udGFpbmVyLWJhc2UuaA0KPmluZGV4DQo+ODFkNDlmZTU2MmQzODQwODU5MDk2ZGQ4YTYy
YWMzOGQ2MjMxNDkzOS4uYTMxZmQ5YzJlM2I5YTU3MTA4M2UNCj5hODk4N2FjMjdlOTFiMzMyYzE3
MCAxMDA2NDQNCj4tLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFzZS5oDQo+
KysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPkBAIC05NSw2ICs5
NSw3IEBAIHZvaWQgdmZpb19jb250YWluZXJfZGVzdHJveShWRklPQ29udGFpbmVyQmFzZQ0KPipi
Y29udGFpbmVyKTsNCj4gdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPTU1VIFZGSU9JT01NVTsNCj4NCj4g
I2RlZmluZSBUWVBFX1ZGSU9fSU9NTVUgInZmaW8taW9tbXUiDQo+KyNkZWZpbmUgVFlQRV9WRklP
X0lPTU1VX0xFR0FDWSBUWVBFX1ZGSU9fSU9NTVUgIi1sZWdhY3kiDQo+DQo+ICNkZWZpbmUgVkZJ
T19JT01NVShvYmopIElOVEVSRkFDRV9DSEVDSyhWRklPSU9NTVUsIChvYmopLA0KPlRZUEVfVkZJ
T19JT01NVSkNCj4gREVDTEFSRV9DTEFTU19DSEVDS0VSUyhWRklPSU9NTVVDbGFzcywgVkZJT19J
T01NVSwNCj5UWVBFX1ZGSU9fSU9NTVUpDQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMg
Yi9ody92ZmlvL2NvbW1vbi5jDQo+aW5kZXgNCj40OWRhYjQxNTY2ZjA3YmE3YmUxMTAwZmVkMTk3
M2UwMjhkMzQ0NjdjLi4yMzI5ZDBlZmM4YzFkNjE3ZjBiZmVlDQo+NTI4M2U4MmIyOTVkMmQ0Nzdk
IDEwMDY0NA0KPi0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4rKysgYi9ody92ZmlvL2NvbW1vbi5j
DQo+QEAgLTE1MDMsMTMgKzE1MDMsMTcgQEAgcmV0cnk6DQo+IGludCB2ZmlvX2F0dGFjaF9kZXZp
Y2UoY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgQWRkcmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKQ0KPiB7DQo+LSAgICBjb25zdCBW
RklPSU9NTVVDbGFzcyAqb3BzID0gJnZmaW9fbGVnYWN5X29wczsNCj4rICAgIGNvbnN0IFZGSU9J
T01NVUNsYXNzICpvcHMgPQ0KPisNCj5WRklPX0lPTU1VX0NMQVNTKG9iamVjdF9jbGFzc19ieV9u
YW1lKFRZUEVfVkZJT19JT01NVV9MRUdBQ1kpKTsNCj4NCj4gI2lmZGVmIENPTkZJR19JT01NVUZE
DQo+ICAgICBpZiAodmJhc2VkZXYtPmlvbW11ZmQpIHsNCj4gICAgICAgICBvcHMgPSAmdmZpb19p
b21tdWZkX29wczsNCj4gICAgIH0NCj4gI2VuZGlmDQo+Kw0KPisgICAgYXNzZXJ0KG9wcyk7DQo+
Kw0KPiAgICAgcmV0dXJuIG9wcy0+YXR0YWNoX2RldmljZShuYW1lLCB2YmFzZWRldiwgYXMsIGVy
cnApOw0KPiB9DQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29udGFpbmVyLmMgYi9ody92Zmlv
L2NvbnRhaW5lci5jDQo+aW5kZXgNCj5mNGEwNDM0YTUyMzliZmI2YTE3YjkxYzg4NzljYjk4ZTY4
NmFmY2NjLi5mZGY0ZTExNjU3MDAxMzczMmQ0ODA3DQo+MWE1MTIyZDI1YjAyZGE3MTVjIDEwMDY0
NA0KPi0tLSBhL2h3L3ZmaW8vY29udGFpbmVyLmMNCj4rKysgYi9ody92ZmlvL2NvbnRhaW5lci5j
DQo+QEAgLTM2OSwxMCArMzY5LDMwIEBAIHN0YXRpYyBpbnQgdmZpb19nZXRfaW9tbXVfdHlwZShW
RklPQ29udGFpbmVyDQo+KmNvbnRhaW5lciwNCj4gICAgIHJldHVybiAtRUlOVkFMOw0KPiB9DQo+
DQo+Ky8qDQo+KyAqIHZmaW9fZ2V0X2lvbW11X29wcyAtIGdldCBhIFZGSU9JT01NVUNsYXNzIGFz
c29jaWF0ZWQgd2l0aCBhIHR5cGUNCj4rICovDQo+K3N0YXRpYyBjb25zdCBWRklPSU9NTVVDbGFz
cyAqdmZpb19nZXRfaW9tbXVfY2xhc3MoaW50IGlvbW11X3R5cGUsDQo+RXJyb3IgKiplcnJwKQ0K
Pit7DQo+KyAgICBPYmplY3RDbGFzcyAqa2xhc3MgPSBOVUxMOw0KDQpObyBuZWVkIHRvIG51bGxp
Znk/DQo+Kw0KPisgICAgc3dpdGNoIChpb21tdV90eXBlKSB7DQo+KyAgICBjYXNlIFZGSU9fVFlQ
RTF2Ml9JT01NVToNCj4rICAgIGNhc2UgVkZJT19UWVBFMV9JT01NVToNCj4rICAgICAgICBrbGFz
cyA9IG9iamVjdF9jbGFzc19ieV9uYW1lKFRZUEVfVkZJT19JT01NVV9MRUdBQ1kpOw0KPisgICAg
ICAgIGJyZWFrOw0KPisgICAgZGVmYXVsdDoNCj4rICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpOw0KPisgICAgfTsNCj4rDQo+KyAgICByZXR1cm4gVkZJT19JT01NVV9DTEFTUyhrbGFzcyk7
DQo+K30NCj4rDQo+IHN0YXRpYyBpbnQgdmZpb19pbml0X2NvbnRhaW5lcihWRklPQ29udGFpbmVy
ICpjb250YWluZXIsIGludCBncm91cF9mZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNlLCBFcnJvciAqKmVycnApDQo+IHsNCj4gICAgIGlu
dCBpb21tdV90eXBlLCByZXQ7DQo+KyAgICBjb25zdCBWRklPSU9NTVVDbGFzcyAqdmlvYyA9IE5V
TEw7DQoNCk5vIG5lZWQgdG8gbnVsbGlmeT8NCg0KPg0KPiAgICAgaW9tbXVfdHlwZSA9IHZmaW9f
Z2V0X2lvbW11X3R5cGUoY29udGFpbmVyLCBlcnJwKTsNCj4gICAgIGlmIChpb21tdV90eXBlIDwg
MCkgew0KPkBAIC00MDEsNyArNDIxLDE0IEBAIHN0YXRpYyBpbnQgdmZpb19pbml0X2NvbnRhaW5l
cihWRklPQ29udGFpbmVyDQo+KmNvbnRhaW5lciwgaW50IGdyb3VwX2ZkLA0KPiAgICAgfQ0KPg0K
PiAgICAgY29udGFpbmVyLT5pb21tdV90eXBlID0gaW9tbXVfdHlwZTsNCj4tICAgIHZmaW9fY29u
dGFpbmVyX2luaXQoJmNvbnRhaW5lci0+YmNvbnRhaW5lciwgc3BhY2UsICZ2ZmlvX2xlZ2FjeV9v
cHMpOw0KPisNCj4rICAgIHZpb2MgPSB2ZmlvX2dldF9pb21tdV9jbGFzcyhpb21tdV90eXBlLCBl
cnJwKTsNCj4rICAgIGlmICghdmlvYykgew0KPisgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5v
IGF2YWlsYWJsZSBJT01NVSBtb2RlbHMiKTsNCj4rICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4r
ICAgIH0NCj4rDQo+KyAgICB2ZmlvX2NvbnRhaW5lcl9pbml0KCZjb250YWluZXItPmJjb250YWlu
ZXIsIHNwYWNlLCB2aW9jKTsNCj4gICAgIHJldHVybiAwOw0KPiB9DQo+DQo+QEAgLTEwOTgsMTIg
KzExMjUsMjYgQEAgb3V0X3NpbmdsZToNCj4gICAgIHJldHVybiByZXQ7DQo+IH0NCj4NCj4tY29u
c3QgVkZJT0lPTU1VT3BzIHZmaW9fbGVnYWN5X29wcyA9IHsNCj4tICAgIC5kbWFfbWFwID0gdmZp
b19sZWdhY3lfZG1hX21hcCwNCj4tICAgIC5kbWFfdW5tYXAgPSB2ZmlvX2xlZ2FjeV9kbWFfdW5t
YXAsDQo+LSAgICAuYXR0YWNoX2RldmljZSA9IHZmaW9fbGVnYWN5X2F0dGFjaF9kZXZpY2UsDQo+
LSAgICAuZGV0YWNoX2RldmljZSA9IHZmaW9fbGVnYWN5X2RldGFjaF9kZXZpY2UsDQo+LSAgICAu
c2V0X2RpcnR5X3BhZ2VfdHJhY2tpbmcgPSB2ZmlvX2xlZ2FjeV9zZXRfZGlydHlfcGFnZV90cmFj
a2luZywNCj4tICAgIC5xdWVyeV9kaXJ0eV9iaXRtYXAgPSB2ZmlvX2xlZ2FjeV9xdWVyeV9kaXJ0
eV9iaXRtYXAsDQo+LSAgICAucGNpX2hvdF9yZXNldCA9IHZmaW9fbGVnYWN5X3BjaV9ob3RfcmVz
ZXQsDQo+K3N0YXRpYyB2b2lkIHZmaW9faW9tbXVfbGVnYWN5X2NsYXNzX2luaXQoT2JqZWN0Q2xh
c3MgKmtsYXNzLCB2b2lkICpkYXRhKQ0KPit7DQo+KyAgICBWRklPSU9NTVVDbGFzcyAqdmlvYyA9
IFZGSU9fSU9NTVVfQ0xBU1Moa2xhc3MpOw0KPisNCj4rICAgIHZpb2MtPmRtYV9tYXAgPSB2Zmlv
X2xlZ2FjeV9kbWFfbWFwOw0KPisgICAgdmlvYy0+ZG1hX3VubWFwID0gdmZpb19sZWdhY3lfZG1h
X3VubWFwOw0KPisgICAgdmlvYy0+YXR0YWNoX2RldmljZSA9IHZmaW9fbGVnYWN5X2F0dGFjaF9k
ZXZpY2U7DQo+KyAgICB2aW9jLT5kZXRhY2hfZGV2aWNlID0gdmZpb19sZWdhY3lfZGV0YWNoX2Rl
dmljZTsNCj4rICAgIHZpb2MtPnNldF9kaXJ0eV9wYWdlX3RyYWNraW5nID0gdmZpb19sZWdhY3lf
c2V0X2RpcnR5X3BhZ2VfdHJhY2tpbmc7DQo+KyAgICB2aW9jLT5xdWVyeV9kaXJ0eV9iaXRtYXAg
PSB2ZmlvX2xlZ2FjeV9xdWVyeV9kaXJ0eV9iaXRtYXA7DQo+KyAgICB2aW9jLT5wY2lfaG90X3Jl
c2V0ID0gdmZpb19sZWdhY3lfcGNpX2hvdF9yZXNldDsNCj4gfTsNCj4rDQo+K3N0YXRpYyBjb25z
dCBUeXBlSW5mbyB0eXBlc1tdID0gew0KPisgICAgew0KPisgICAgICAgIC5uYW1lID0gVFlQRV9W
RklPX0lPTU1VX0xFR0FDWSwNCj4rICAgICAgICAucGFyZW50ID0gVFlQRV9WRklPX0lPTU1VLA0K
PisgICAgICAgIC5jbGFzc19pbml0ID0gdmZpb19pb21tdV9sZWdhY3lfY2xhc3NfaW5pdCwNCj4r
ICAgICAgICAuY2xhc3Nfc2l6ZSA9IHNpemVvZihWRklPSU9NTVVDbGFzcyksDQoNCkluaGVyaXQg
cGFyZW50IGNsYXNzX3NpemUgaXMgZW5vdWdoPyBPdGhlcndpc2UsDQoNClJldmlld2VkLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+KyAgICB9LA0KPit9Ow0KPisNCj4rREVGSU5FX1RZUEVTKHR5cGVzKQ0KPi0tDQo+
Mi40My4wDQoNCg==

