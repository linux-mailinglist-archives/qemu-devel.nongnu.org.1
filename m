Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF68D73F0ED
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 04:47:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDyis-0001ol-JZ; Mon, 26 Jun 2023 22:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDyin-0001o8-Lo
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:46:29 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDyik-0000f8-UA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687833982; x=1719369982;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=M41XQx8O4pqCFLtwXgKzbagWSJiL2piFBvv63LcvumY=;
 b=aGZBGmCJCiy5K8IiPYYhsVn8KePZYbTd53wBSLVujzs2hcZU4z3/edb+
 fIdcMnx3W6i0vMHtL8UH1B1fNfHVzODAMLv+2iJN5r66fq0ueCqoLBZ4a
 +tWo35sgxTgFSLwsBSfvJ0MVhlsxhPue7VI6hcbUPqmO2u9s2u+kKIC5W
 0cL4355U8oIipclJXLKVkc4oTU1b8/ktlYKhVf7++KD6Py2AYtCLa6qvW
 ok9B+wLwW8AJlCKXPhJBY9+jlUblZnUrZ9coomGDhJqLLkXeN8ggXuZA7
 yMQkFOMooHQPaACy4ei/7P1cwW4Da/QWWjb9dfid2CC71QsnFjix3dHfM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="425119668"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="425119668"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 19:46:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="716371250"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="716371250"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga002.jf.intel.com with ESMTP; 26 Jun 2023 19:46:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 19:46:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 19:46:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 19:46:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 19:46:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z46FicLItSPp1X8jz5MS32HOgQzWnGIY5R9eSm8ElQ07PMvVVvhyCEY/6Cu5OhiO9BVgTlR0fWbjuE27kahWYaDOlhLH1hdK7ChyU3BWQq1PvaQ1/HgZzJ1qr7VaMC67AxckTWnkBJy4kLlScU8O2EFM7c0f7ucPHyxNyb9eSDWihGFSfT4q7bBenaValXEDR+yqOc4BXXY+Jrut1o8de+jqX1moD5hjK9uRaLP00MgBNcGDrQVTbHe6Ya2CpOergy9JlaLjFZXfUWmcSTlcax86oFHtk8kCHRITu8NqACDYyIlDZRr6oI6UOjy336uRhlNqZFLtXxQh6tBAfVxnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M41XQx8O4pqCFLtwXgKzbagWSJiL2piFBvv63LcvumY=;
 b=Q4ahKjRf6b4WNqzVKcjck/9dFzxtAz0xYrb8Bu43lUwV8ZgNzljdNieza1hQD+3Vvj50tHgOwFT2/d+9JqxWwaObMVX+tV5ChBSE2+HdTrj8usDdEf6jiPLmwRrq2UypNP1irL52enzLuVl6rCEO8ISjDxhUyMQju3Ihe7NUaxrDCfmiVSmUAcRqEKChAMv7e5I5Kt0UXPeKHKE9etclya+sg6Di9YAga1qP/nO6l1iYNDinORDmWu6WMUndjQ9aYBfE67pkrfYzucR6QRad5Ge3y9WNqulpgngkvkesQguK2pDUXK2QX90r5mCaQbUyuWYD6C6dvd+FOTgnkXq2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5237.namprd11.prod.outlook.com (2603:10b6:208:310::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 02:46:07 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 02:46:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Thread-Topic: [PATCH v3 3/3] vfio/migration: vfio/migration: Refactor and fix
 print of "Migration disabled"
Thread-Index: AQHZpBiDMAK8vCWoSUWN+eGvuOKtiq+c2rIAgAAWRUA=
Date: Tue, 27 Jun 2023 02:46:07 +0000
Message-ID: <SJ0PR11MB67447187172BF9485D86F78F9227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-4-zhenzhong.duan@intel.com>
 <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
In-Reply-To: <c8583433-9b9f-4380-8076-8ca623b66770@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5237:EE_
x-ms-office365-filtering-correlation-id: e2c4cf67-a08a-4749-6383-08db76b8a878
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RguaLZnCx6iL7VQlgiT8jiKTsv5eByjtL//CtsilyfDe8KTw/OR6h+krVMZt1EVUK5fFDsZSceSWLTp2DVy3zFsEyfFGos/1H51K3m5QhJ6A05nmDS7MshqR22PPjuVNruYkPhjP1/UIJqSbjTicx5vWXEQ6i5YZMIRXkIccF7kXC75OnLxqAEmSMOtu7I/cCT7nEQRyu2/pn5ZwtboDxl5FYzMeVYeR+Mm+zFOY7WVAerrzt/4AwbfD0yYHOhq+NNN3Mx9Bm9o4Qu2b/2pvAArg/nip8wPT2US2tNPZIBxaSqHQBVJE8gmPUDIEQvuh5d76qt/Crstk3Qo3upd76/3Z45c1Hf+GeiLAMVsOInOI3oiUiCh9gmbUi9bS6rw7P9szBeII0DrPMewwz7mm2yHGcoLBDXKqCiVQD1BZxAtUleW/ID+cHLr8A7SWpXA8/Rqxs7BB57hA4Mw1PWY/MKoHOPjlzdWF+KXwk3dOnQorAfSa3xLY+lemlBLzLqrdZTThbFDpXMTYbfPR5xK27t2RHH7rw5gfkdpRmUFShxaHtgpz/UR1mWk+uKV1ONY0w0bvQX1Dy8ziCb3a0xmnB5ChMIqdRqBN2/OEG6pPDQ90ixODD0RMnCMZzNT6c2A+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(136003)(366004)(376002)(396003)(451199021)(33656002)(38100700002)(52536014)(86362001)(41300700001)(5660300002)(66476007)(8936002)(64756008)(66446008)(38070700005)(66556008)(8676002)(66946007)(122000001)(316002)(4326008)(76116006)(55016003)(82960400001)(478600001)(107886003)(6506007)(2906002)(186003)(9686003)(71200400001)(26005)(7696005)(110136005)(83380400001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGlzNU85MTZRUHlYekVWNGVGTENDYW1YWFRseUtMeE93dlg3RnhxZjFIakJl?=
 =?utf-8?B?L3V6eDB1LzhkbDZHQWdPRG4xM2J4bGxvMVJhekUvck5IUHoxL3ZsbXJVSXI1?=
 =?utf-8?B?SHR5NzN3NkpZb3BqdDhEOTJZTmNQNVVEbXlTTU1TSWpEMUFnQ1VQMnNCZ3k2?=
 =?utf-8?B?RXJHVFZtRWFRVEg2dk5QaFVHQzUxS3VwSEs1V2RXK2JrZnZVc0xxQzNieUVj?=
 =?utf-8?B?SUFTalBBcU1tTWtDUTRpSVVIMzAzM0RiMERndGIxaVE0amRYUzNpanVzYXp4?=
 =?utf-8?B?VU1ENnVselVhZFJ3Q0JHYVRiOXJjaW9CK0ptRExLNkI0Q0tOMjYxbWRrMEth?=
 =?utf-8?B?NHlSYnovKy9JaFNCaWd0dzNmUkxYaG1FM25pZ040OFVtMkhld3RJejlPZE9K?=
 =?utf-8?B?Zzh6YmwxVzJJV0RMUmF3bTNaRjNlOE4zN2xld3QvWHVDVXJDTGRUYkY5cU5D?=
 =?utf-8?B?dWRqSjlGRWJEY1dnbjM1Qk1vZ2pwLzM3UEthVk0ydzFwdTJkS2tnOVRpUFlJ?=
 =?utf-8?B?S2VrZWtsWU01cjh5Rk9Kbnc4Tm1BR29LNGpPOWJkVVVnUWJmZEphUmdGS1N6?=
 =?utf-8?B?VndEamZiTkpCY2kvQ1pLYWJlRW1Rc0RXVUZ0YnQrVE1PbEFEYS9Eam93WDlT?=
 =?utf-8?B?cnR4U25JSFYwaExhMHVaQkNHbVFVL29VeWl3b0xFUi8rbDM4QktqVGdHdHo4?=
 =?utf-8?B?RVJGRVQwVWJ2cVl1SytVaVRqSmNvRGlyU2J6c2M5Yy9CNm5LTk5SSnUxOEJW?=
 =?utf-8?B?Z0tEMXd4Sk91YXdLU212MnQyenZGWFBDRlpGTjlqbm1obCtKY0xoTmFHc2dH?=
 =?utf-8?B?UlRRN1hiV3NaOE91ajRjYnBnVDNNeGZ4MndTaDRrZnVJdlNNRk9PQnYyanN4?=
 =?utf-8?B?SjFPMWxtTzlLZ0xOa0xWQzdSODJJK1U0WTNOUUM2RmR4UXV4YjJiMTZyMVNI?=
 =?utf-8?B?QUNWMndyVml5QXE2SzBYVzRwV0pHSzJtYWZ1Q09DeG5pRXZRTC9wM0g4RnVj?=
 =?utf-8?B?UTZjVW5ZM0s2Vnh6dzlOWk42Z1c4SnFqY05TSnlYT2Vod3cvNnhGT3FMYjhl?=
 =?utf-8?B?Q0JDaUdHalNsUnc1aDdpUzJnN1NGa1gxOU1ic0hXOUpoOVFzQ3hPVDMrS0Jj?=
 =?utf-8?B?NmxpUGJCMTEvNmFnTjNaeW1iL0ZlWUhud3RaZkE2bEZCLzdGSUNvL2lZa0Rk?=
 =?utf-8?B?b1U1Sjc5ZDJRVHNDMTdQRDlBR0Y4aXJrdXVsSmk2cGhCSXMzWXRtdTIzVkJ0?=
 =?utf-8?B?ZlFpRlhxcnJRNHBWWXQ2Mlk3WlE2QTVSanZSSVVpTCtCZmJKQVFpOVdjY1lo?=
 =?utf-8?B?UXdPQmFpSkVjL2dnbHEraklRNk1ORlpUMEZPQy9nR3hSR3kxdFRQekFGSnQr?=
 =?utf-8?B?ZU9aTkRSYkYvTHp5Skg1NlQrYVg1dnREanRmVXdUS2RiMWF5Wm5zQ2F1NjNP?=
 =?utf-8?B?OXZ4Z0hsclE1VDVzS0Jnc0RYWitCbWtGbHZuSGVQQnhGN3NaRmFFR3h5UnNo?=
 =?utf-8?B?RThZc0ZpTHFRSm9xbjdOM3BPeWMwZ1FrYU80R0J2ZjEzcE1oSHR2WldWRFN1?=
 =?utf-8?B?MmFSS09IU1BQbmNvVWlFWWRNOVlINHF5d2hKTm1UQzhJWERlV0NidzF6OTRT?=
 =?utf-8?B?MW9Na0pWejd1VGxVVXN5bCswVEhZL1MyQUkrVElnUTNyaGM1YmJvN3piWWFX?=
 =?utf-8?B?SndxUmJ2bGJwN1NOU0ppbXJoZXlESC9DOXZpTGhjSEN0NWlSekIveis0VXZT?=
 =?utf-8?B?aTRBY0k4TUNSTjJjRVFvd0ZPNFBGaCtRSzJSczNTem03U3JldW9QK0xETVJW?=
 =?utf-8?B?azNZUzdWSEJ1UE16SmVUY2VpNGVtUWdpWnN6a1BRZEFsNHlTcjFKdmdZWUlt?=
 =?utf-8?B?anhwS2o1MzRHN1RqdjJHeUlqekt0WW9vL09tdnR2SEh3Q1ZQWDdVVVk1ZkR6?=
 =?utf-8?B?OUFSVC9wdllZdXJRd2JIb1FPeStCQkordjluR3FZTU9lNWFPY3FnV2hyWXhl?=
 =?utf-8?B?L1dTQmFXU3RScGJSYUdac1RLdzVWVkdtZGpxNW1XTElaWFFFZ0RtNU9NL2dl?=
 =?utf-8?B?T3lJS09qMWh2V0Z3SHptWVU2cnFyTEx2QmpXYWZ5WlMrQ01FcFpnalBJVzVL?=
 =?utf-8?Q?vsguHXxo/jI2r4rCBl0JunIyz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c4cf67-a08a-4749-6383-08db76b8a878
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 02:46:07.5028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zcS+JQK+5gYz4RYzi01DMmAk0gQFqLVJi6mwtHYH001p9xKHD9zWaMhX2boqmpAoCYVZA+9IlHffi3oHZpAf/2/wwrhDI/K9jB+Lj3CORg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5237
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mga06.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEF2aWhhaSBIb3JvbiA8YXZp
aGFpaEBudmlkaWEuY29tPg0KPlNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyA1OjM1IFBNDQo+
VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgcWVtdS0NCj5k
ZXZlbEBub25nbnUub3JnDQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBjbGdAcmVk
aGF0LmNvbTsgTWFydGlucywgSm9hbw0KPjxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPjsgUGVu
ZywgQ2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2
MyAzLzNdIHZmaW8vbWlncmF0aW9uOiB2ZmlvL21pZ3JhdGlvbjogUmVmYWN0b3IgYW5kIGZpeA0K
PnByaW50IG9mICJNaWdyYXRpb24gZGlzYWJsZWQiDQo+DQo+DQo+T24gMjEvMDYvMjAyMyAxMTow
MiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPj4NCj4+DQo+PiBUaGlzIHBhdGNoIHJlZmFj
dG9ycyB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkgYW5kIGl0cyBkZXBlbmRlbmQgY29kZQ0KPj4g
YXMgZm9sbG93czoNCj4+DQo+PiAxLiBJdCdzIHJlZHVuZGFudCBpbiB2ZmlvX21pZ3JhdGlvbl9y
ZWFsaXplKCkgdG8gcmVnaXN0ZXJzIG11bHRpcGxlIGJsb2NrZXJzLA0KPj4gICAgIGUuZzogdklP
TU1VIGJsb2NrZXIgY2FuIGJlIHJlZmFjdG9yZWQgYXMgcGVyIGRldmljZSBibG9ja2VyLg0KPj4g
Mi4gQ2hhbmdlIHZmaW9fYmxvY2tfZ2lvbW11X21pZ3JhdGlvbigpIHRvIGJlIG9ubHkgYSBwZXIg
ZGV2aWNlIGNoZWNrZXIuDQo+PiAzLiBSZW1vdmUgZ2xvYmFsIHZJT01NVSBibG9ja2VyIHJlbGF0
ZWQgc3R1ZmYsIGUuZzoNCj4+ICAgICBnaW9tbXVfbWlncmF0aW9uX2Jsb2NrZXIsIHZmaW9fdW5i
bG9ja19naW9tbXVfbWlncmF0aW9uKCksDQo+PiAgICAgdmZpb192aW9tbXVfcHJlc2V0KCkgYW5k
IHZmaW9fbWlncmF0aW9uX2ZpbmFsaXplKCkgNC4gQ2hhbmdlDQo+PiB2ZmlvX21pZ3JhdGlvbl9y
ZWFsaXplKCkgYW5kIGRlcGVuZGVudCB2ZmlvX2Jsb2NrXypfbWlncmF0aW9uKCkgdG8NCj4+ICAg
ICByZXR1cm4gYm9vbCB0eXBlLg0KPj4gNS4gQ2hhbmdlIHRvIHByaW50ICJNaWdyYXRpb24gZGlz
YWJsZWQiIG9ubHkgYWZ0ZXIgYWRkaW5nIGJsb2NrZXIgc3VjY2VlZC4NCj4+IDYuIEFkZCBkZXZp
Y2UgbmFtZSB0byBlcnJwIHNvICJpbmZvIG1pZ3JhdGUiIGNvdWxkIGJlIG1vcmUgaW5mb3JtYXRp
dmUuDQo+Pg0KPj4gbWlncmF0ZV9hZGRfYmxvY2tlcigpIHJldHVybnMgMCB3aGVuIHN1Y2Nlc3Nm
dWxseSBhZGRpbmcgdGhlIG1pZ3JhdGlvbg0KPmJsb2NrZXIuDQo+PiBIb3dldmVyLCB0aGUgY2Fs
bGVyIG9mIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSBjb25zaWRlcnMgdGhhdA0KPj4gbWlncmF0
aW9uIHdhcyBibG9ja2VkIHdoZW4gdGhlIGxhdHRlciByZXR1cm5lZCBhbiBlcnJvci4gV2hhdCBt
YXR0ZXJzDQo+PiBmb3IgbWlncmF0aW9uIGlzIHRoYXQgdGhlIGJsb2NrZXIgaXMgYWRkZWQgaW4g
Y29yZSBtaWdyYXRpb24sIHNvIHRoaXMNCj4+IGNsZWFucyB1cCB1c2FiaWxpdHkgc3VjaCB0aGF0
IHVzZXIgc2VlcyAiTWlncmF0ZSBkaXNhYmxlZCIgd2hlbiBhbnkgb2YgdGhlDQo+dmZpbyBtaWdy
YXRpb24gYmxvY2tlcnMgYXJlIGFjdGl2ZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhv
bmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGh3L3ZmaW8v
Y29tbW9uLmMgICAgICAgICAgICAgIHwgNTQgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+ICAgaHcvdmZpby9taWdyYXRpb24uYyAgICAgICAgICAgfCAzNyArKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0NCj4+ICAgaHcvdmZpby9wY2kuYyAgICAgICAgICAgICAgICAgfCAgNCAr
LS0NCj4+ICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggfCAgNyArKy0tLQ0KPj4gICA0
IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDczIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIvaHcvdmZpby9jb21tb24uYyBpbmRleA0K
Pj4gZmE4ZmQ5NDliMWNmLi5jYzVmNGU4MDUzNDEgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2Nv
bW1vbi5jDQo+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBAQCAtMzYyLDggKzM2Miw2IEBA
IGJvb2wgdmZpb19taWdfYWN0aXZlKHZvaWQpDQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBFcnJv
ciAqbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb25fYmxvY2tlcjsNCj4+IC1zdGF0aWMgRXJyb3Ig
Kmdpb21tdV9taWdyYXRpb25fYmxvY2tlcjsNCj4+IC0NCj4+ICAgc3RhdGljIHVuc2lnbmVkIGlu
dCB2ZmlvX21pZ3JhdGFibGVfZGV2aWNlX251bSh2b2lkKQ0KPj4gICB7DQo+PiAgICAgICBWRklP
R3JvdXAgKmdyb3VwOw0KPj4gQEAgLTM4MSwxMyArMzc5LDEzIEBAIHN0YXRpYyB1bnNpZ25lZCBp
bnQNCj52ZmlvX21pZ3JhdGFibGVfZGV2aWNlX251bSh2b2lkKQ0KPj4gICAgICAgcmV0dXJuIGRl
dmljZV9udW07DQo+PiAgIH0NCj4+DQo+PiAtaW50IHZmaW9fYmxvY2tfbXVsdGlwbGVfZGV2aWNl
c19taWdyYXRpb24oRXJyb3IgKiplcnJwKQ0KPj4gK2Jvb2wgdmZpb19ibG9ja19tdWx0aXBsZV9k
ZXZpY2VzX21pZ3JhdGlvbihFcnJvciAqKmVycnApDQo+PiAgIHsNCj4+ICAgICAgIGludCByZXQ7
DQo+Pg0KPj4gICAgICAgaWYgKG11bHRpcGxlX2RldmljZXNfbWlncmF0aW9uX2Jsb2NrZXIgfHwN
Cj4+ICAgICAgICAgICB2ZmlvX21pZ3JhdGFibGVfZGV2aWNlX251bSgpIDw9IDEpIHsNCj4+IC0g
ICAgICAgIHJldHVybiAwOw0KPj4gKyAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAgICAgICB9DQo+
Pg0KPj4gICAgICAgZXJyb3Jfc2V0ZygmbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb25fYmxvY2tl
ciwNCj4+IEBAIC0zOTcsOSArMzk1LDExIEBAIGludCB2ZmlvX2Jsb2NrX211bHRpcGxlX2Rldmlj
ZXNfbWlncmF0aW9uKEVycm9yDQo+KiplcnJwKQ0KPj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4+
ICAgICAgICAgICBlcnJvcl9mcmVlKG11bHRpcGxlX2RldmljZXNfbWlncmF0aW9uX2Jsb2NrZXIp
Ow0KPj4gICAgICAgICAgIG11bHRpcGxlX2RldmljZXNfbWlncmF0aW9uX2Jsb2NrZXIgPSBOVUxM
Ow0KPj4gKyAgICB9IGVsc2Ugew0KPj4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJNaWdyYXRpb24g
ZGlzYWJsZWQsIG5vdCBzdXBwb3J0IG11bHRpcGxlIFZGSU8NCj4+ICsgZGV2aWNlcyIpOw0KPj4g
ICAgICAgfQ0KPj4NCj4+IC0gICAgcmV0dXJuIHJldDsNCj4+ICsgICAgcmV0dXJuICFyZXQ7DQo+
PiAgIH0NCj4+DQo+PiAgIHZvaWQgdmZpb191bmJsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0
aW9uKHZvaWQpDQo+PiBAQCAtNDE0LDQ5ICs0MTQsOSBAQCB2b2lkIHZmaW9fdW5ibG9ja19tdWx0
aXBsZV9kZXZpY2VzX21pZ3JhdGlvbih2b2lkKQ0KPj4gICAgICAgbXVsdGlwbGVfZGV2aWNlc19t
aWdyYXRpb25fYmxvY2tlciA9IE5VTEw7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGljIGJvb2wgdmZp
b192aW9tbXVfcHJlc2V0KHZvaWQpDQo+PiAtew0KPj4gLSAgICBWRklPQWRkcmVzc1NwYWNlICpz
cGFjZTsNCj4+IC0NCj4+IC0gICAgUUxJU1RfRk9SRUFDSChzcGFjZSwgJnZmaW9fYWRkcmVzc19z
cGFjZXMsIGxpc3QpIHsNCj4+IC0gICAgICAgIGlmIChzcGFjZS0+YXMgIT0gJmFkZHJlc3Nfc3Bh
Y2VfbWVtb3J5KSB7DQo+PiAtICAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+PiAtICAgICAgICB9
DQo+PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgcmV0dXJuIGZhbHNlOw0KPj4gLX0NCj4+IC0NCj4+
IC1pbnQgdmZpb19ibG9ja19naW9tbXVfbWlncmF0aW9uKEVycm9yICoqZXJycCkgLXsNCj4+IC0g
ICAgaW50IHJldDsNCj4+IC0NCj4+IC0gICAgaWYgKGdpb21tdV9taWdyYXRpb25fYmxvY2tlciB8
fA0KPj4gLSAgICAgICAgIXZmaW9fdmlvbW11X3ByZXNldCgpKSB7DQo+PiAtICAgICAgICByZXR1
cm4gMDsNCj4+IC0gICAgfQ0KPj4gLQ0KPj4gLSAgICBlcnJvcl9zZXRnKCZnaW9tbXVfbWlncmF0
aW9uX2Jsb2NrZXIsDQo+PiAtICAgICAgICAgICAgICAgIk1pZ3JhdGlvbiBpcyBjdXJyZW50bHkg
bm90IHN1cHBvcnRlZCB3aXRoIHZJT01NVSBlbmFibGVkIik7DQo+PiAtICAgIHJldCA9IG1pZ3Jh
dGVfYWRkX2Jsb2NrZXIoZ2lvbW11X21pZ3JhdGlvbl9ibG9ja2VyLCBlcnJwKTsNCj4+IC0gICAg
aWYgKHJldCA8IDApIHsNCj4+IC0gICAgICAgIGVycm9yX2ZyZWUoZ2lvbW11X21pZ3JhdGlvbl9i
bG9ja2VyKTsNCj4+IC0gICAgICAgIGdpb21tdV9taWdyYXRpb25fYmxvY2tlciA9IE5VTEw7DQo+
PiAtICAgIH0NCj4+IC0NCj4+IC0gICAgcmV0dXJuIHJldDsNCj4+IC19DQo+PiAtDQo+PiAtdm9p
ZCB2ZmlvX21pZ3JhdGlvbl9maW5hbGl6ZSh2b2lkKQ0KPj4gK2Jvb2wgdmZpb19ibG9ja19naW9t
bXVfbWlncmF0aW9uKFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4gICB7DQo+PiAtICAgIGlmICgh
Z2lvbW11X21pZ3JhdGlvbl9ibG9ja2VyIHx8DQo+PiAtICAgICAgICB2ZmlvX3Zpb21tdV9wcmVz
ZXQoKSkgew0KPj4gLSAgICAgICAgcmV0dXJuOw0KPj4gLSAgICB9DQo+PiAtDQo+PiAtICAgIG1p
Z3JhdGVfZGVsX2Jsb2NrZXIoZ2lvbW11X21pZ3JhdGlvbl9ibG9ja2VyKTsNCj4+IC0gICAgZXJy
b3JfZnJlZShnaW9tbXVfbWlncmF0aW9uX2Jsb2NrZXIpOw0KPj4gLSAgICBnaW9tbXVfbWlncmF0
aW9uX2Jsb2NrZXIgPSBOVUxMOw0KPj4gKyAgICByZXR1cm4gdmJhc2VkZXYtPmdyb3VwLT5jb250
YWluZXItPnNwYWNlLT5hcyAhPQ0KPj4gKyAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+PiAgIH0N
Cj4NCj5JIGd1ZXNzIHZmaW9fYmxvY2tfZ2lvbW11X21pZ3JhdGlvbiBjYW4gYmUgbW92ZWQgdG8g
bWlncmF0aW9uLmMgYW5kIG1hZGUNCj5zdGF0aWM/DQo+QWx0aG91Z2ggSm9hbydzIHZJT01NVSBz
ZXJpZXMgd2lsbCBwcm9iYWJseSBjaGFuZ2UgdGhhdCBiYWNrIGxhdGVyIGluIHNvbWUNCj53YXku
DQpHb29kIGlkZWEsIHdpbGwgZG8uDQoNCj4NCj4+DQo+PiAgIHN0YXRpYyB2b2lkIHZmaW9fc2V0
X21pZ3JhdGlvbl9lcnJvcihpbnQgZXJyKQ0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbWlncmF0
aW9uLmMgYi9ody92ZmlvL21pZ3JhdGlvbi5jDQo+PiBpbmRleCA2YjU4ZGRkYjg4NTkuLjc2MjEw
NzRmMTU2ZCAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+ICsrKyBiL2h3
L3ZmaW8vbWlncmF0aW9uLmMNCj4+IEBAIC02MzIsNDIgKzYzMiwzOSBAQCBpbnQ2NF90IHZmaW9f
bWlnX2J5dGVzX3RyYW5zZmVycmVkKHZvaWQpDQo+PiAgICAgICByZXR1cm4gYnl0ZXNfdHJhbnNm
ZXJyZWQ7DQo+PiAgIH0NCj4+DQo+PiAtaW50IHZmaW9fbWlncmF0aW9uX3JlYWxpemUoVkZJT0Rl
dmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+ICsvKiBSZXR1cm4gdHJ1ZSB3aGVuIGVp
dGhlciBtaWdyYXRpb24gaW5pdGlhbGl6ZWQgb3IgYmxvY2tlciByZWdpc3RlcmVkICovDQo+PiAr
Ym9vbCB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKFZGSU9EZXZpY2UgKnZiYXNlZGV2LCBFcnJvciAq
KmVycnApDQo+PiAgIHsNCj4+IC0gICAgaW50IHJldCA9IC1FTk9UU1VQOw0KPj4gKyAgICBpbnQg
cmV0Ow0KPj4NCj4+IC0gICAgaWYgKCF2YmFzZWRldi0+ZW5hYmxlX21pZ3JhdGlvbikgew0KPj4g
KyAgICBpZiAoIXZiYXNlZGV2LT5lbmFibGVfbWlncmF0aW9uIHx8IHZmaW9fbWlncmF0aW9uX2lu
aXQodmJhc2VkZXYpKSB7DQo+PiArICAgICAgICBlcnJvcl9zZXRnKCZ2YmFzZWRldi0+bWlncmF0
aW9uX2Jsb2NrZXIsDQo+PiArICAgICAgICAgICAgICAgICAgICJWRklPIGRldmljZSAlcyBkb2Vz
bid0IHN1cHBvcnQgbWlncmF0aW9uIiwgdmJhc2VkZXYtPm5hbWUpOw0KPj4gICAgICAgICAgIGdv
dG8gYWRkX2Jsb2NrZXI7DQo+PiAgICAgICB9DQo+Pg0KPj4gLSAgICByZXQgPSB2ZmlvX21pZ3Jh
dGlvbl9pbml0KHZiYXNlZGV2KTsNCj4+IC0gICAgaWYgKHJldCkgew0KPj4gLSAgICAgICAgZ290
byBhZGRfYmxvY2tlcjsNCj4+IC0gICAgfQ0KPj4gLQ0KPj4gLSAgICByZXQgPSB2ZmlvX2Jsb2Nr
X211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKGVycnApOw0KPj4gLSAgICBpZiAocmV0KSB7DQo+
PiAtICAgICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICBpZiAoIXZmaW9fYmxvY2tfbXVsdGlwbGVf
ZGV2aWNlc19taWdyYXRpb24oZXJycCkpIHsNCj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+
ICAgICAgIH0NCj4+DQo+PiAtICAgIHJldCA9IHZmaW9fYmxvY2tfZ2lvbW11X21pZ3JhdGlvbihl
cnJwKTsNCj4+IC0gICAgaWYgKHJldCkgew0KPj4gLSAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsg
ICAgaWYgKHZmaW9fYmxvY2tfZ2lvbW11X21pZ3JhdGlvbih2YmFzZWRldikpIHsNCj4+ICsgICAg
ICAgIGVycm9yX3NldGcoJnZiYXNlZGV2LT5taWdyYXRpb25fYmxvY2tlciwNCj4+ICsgICAgICAg
ICAgICAgICAgICAgIk1pZ3JhdGlvbiBpcyBjdXJyZW50bHkgbm90IHN1cHBvcnRlZCBvbiAlcyAi
DQo+PiArICAgICAgICAgICAgICAgICAgICJ3aXRoIHZJT01NVSBlbmFibGVkIiwgdmJhc2VkZXYt
Pm5hbWUpOw0KPj4gKyAgICAgICAgZ290byBhZGRfYmxvY2tlcjsNCj4+ICAgICAgIH0NCj4+DQo+
PiAtICAgIHRyYWNlX3ZmaW9fbWlncmF0aW9uX3Byb2JlKHZiYXNlZGV2LT5uYW1lKTsNCj4+IC0g
ICAgcmV0dXJuIDA7DQo+PiArICAgIHJldHVybiB0cnVlOw0KPj4NCj4+ICAgYWRkX2Jsb2NrZXI6
DQo+PiAtICAgIGVycm9yX3NldGcoJnZiYXNlZGV2LT5taWdyYXRpb25fYmxvY2tlciwNCj4+IC0g
ICAgICAgICAgICAgICAiVkZJTyBkZXZpY2UgZG9lc24ndCBzdXBwb3J0IG1pZ3JhdGlvbiIpOw0K
Pj4gLQ0KPj4gICAgICAgcmV0ID0gbWlncmF0ZV9hZGRfYmxvY2tlcih2YmFzZWRldi0+bWlncmF0
aW9uX2Jsb2NrZXIsIGVycnApOw0KPj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4+ICAgICAgICAg
ICBlcnJvcl9mcmVlKHZiYXNlZGV2LT5taWdyYXRpb25fYmxvY2tlcik7DQo+PiAgICAgICAgICAg
dmJhc2VkZXYtPm1pZ3JhdGlvbl9ibG9ja2VyID0gTlVMTDsNCj4+ICsgICAgfSBlbHNlIHsNCj4+
ICsgICAgICAgIGVycm9yX3JlcG9ydCgiJXM6IE1pZ3JhdGlvbiBkaXNhYmxlZCIsIHZiYXNlZGV2
LT5uYW1lKTsNCj4NCj5XaGVuIHgtZW5hYmxlLW1pZ3JhdGlvbj1vZmYsICJNaWdyYXRpb24gZGlz
YWJsZWQiIGVycm9yIHdpbGwgYmUgcHJpbnRlZCwNCj5idXQgdGhpcyBpcyB0aGUgZXhwZWN0ZWQg
YmVoYXZpb3IsIHNvIHdlIHNob3VsZCBub3QgcHJpbnQgaXQgaW4gdGhpcyBjYXNlLg0KTWFrZSBz
ZW5zZSwgd2lsbCBkby4NCg0KPg0KPj4gICAgICAgfQ0KPj4gLSAgICByZXR1cm4gcmV0Ow0KPj4g
KyAgICByZXR1cm4gIXJldDsNCj4+ICAgfQ0KPj4NCj4+ICAgdm9pZCB2ZmlvX21pZ3JhdGlvbl9l
eGl0KFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vcGNpLmMg
Yi9ody92ZmlvL3BjaS5jDQo+PiBpbmRleCA4MmM0Y2Y0Zjc2MDkuLjA2MWNhOTZjYmNlMiAxMDA2
NDQNCj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmMNCj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBA
IC0zMjA5LDcgKzMyMDksOCBAQCBzdGF0aWMgdm9pZCB2ZmlvX3JlYWxpemUoUENJRGV2aWNlICpw
ZGV2LCBFcnJvcg0KPioqZXJycCkNCj4+ICAgICAgIGlmICghcGRldi0+ZmFpbG92ZXJfcGFpcl9p
ZCkgew0KPj4gICAgICAgICAgIHJldCA9IHZmaW9fbWlncmF0aW9uX3JlYWxpemUodmJhc2VkZXYs
IGVycnApOw0KPj4gICAgICAgICAgIGlmIChyZXQpIHsNCj4+IC0gICAgICAgICAgICBlcnJvcl9y
ZXBvcnQoIiVzOiBNaWdyYXRpb24gZGlzYWJsZWQiLCB2YmFzZWRldi0+bmFtZSk7DQo+PiArICAg
ICAgICAgICAgdHJhY2VfdmZpb19taWdyYXRpb25fcHJvYmUodmJhc2VkZXYtPm5hbWUpOw0KPg0K
PldoaWxlIHdlIGFyZSBoZXJlLCBsZXQncyByZW5hbWUgdHJhY2VfdmZpb19taWdyYXRpb25fcHJv
YmUoKSB0bw0KPnRyYWNlX3ZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSAoSSBjYW4gZG8gaXQgdG9v
IGluIG15IHNlcmllcykuDQpHb29kIGZpbmRpbmcsIHdpbGwgZG8uDQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

