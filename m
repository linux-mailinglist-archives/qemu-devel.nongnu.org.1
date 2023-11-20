Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B157F0B1D
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 04:42:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r4v9T-0001PX-5g; Sun, 19 Nov 2023 22:40:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r4v9Q-0001PA-Tu
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 22:40:44 -0500
Received: from mgamail.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r4v9N-0002WB-U3
 for qemu-devel@nongnu.org; Sun, 19 Nov 2023 22:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700451641; x=1731987641;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=CUSUKDQGVD/V0TYZMjz+oD1VemH8rouQXsW7VmbOKMs=;
 b=WZfF7jsYNSZfo+KZ7JYs09370mRoMA9xAR3a+iZxpFpICYOMSFxAOYcO
 bR2nMgDSB2VHOFEeNdxtrXkbj/uHJIZXXFOXQcWZHbWXShWc5U/6i7C5C
 9vJ3DRxPTqy5BhpamggXN8w7Yi1k378rp7mQ47ZJJYVZIFW+nieFt+LPh
 m39iXueyitguL06W2Pl+isey0ND7BAu7h6yU2jp42JV5b63jgWIHrKXWS
 LbGQCXqlFhmUM4L4vgErpmWfpx8M5j7ggjRH858Svo5hMnuwVs19byw1W
 uw7eC68j1CHQvmSwGZ/PNUw1FQE1Q15n2HlCg0uSwdPHhV5+xees37mRG g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="391325173"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; d="scan'208";a="391325173"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2023 19:40:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097632416"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; d="scan'208";a="1097632416"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 19 Nov 2023 19:40:36 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:40:36 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:40:35 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 19:40:35 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 19:40:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZiNdc8HG55LGQKviXO7fCoinm7U9rIwwaBohWq2GESlWEPOAk1dDU8FByo9IiCLcRJYa02npxjPJDvGRstHoleL1CzU+/HOVIuGHBLCJcE2CeMiAAnO5TEPCDn2EZcQKFokmsk2OeEas+KzJ7yldCEfkF3qROjw4QEJjUcezFyrigjbwbGawfnAfd3u6ziJa1dFSTEPM3pD0qjgkE5rohIoaCluYH8JMZWS02W3ZoJrlGR6k4IrKzgfAZ//Pjc+We34jICJEy13tGHwL/pbRv5hFREWOkawD8bneIgjdZqqdggsf+2T2F14ibajVDzjdDCR9MMWzchGTO0sTXhhAaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUSUKDQGVD/V0TYZMjz+oD1VemH8rouQXsW7VmbOKMs=;
 b=OLp+EtsY1IFQXwXXd9xyYSeMs5gSNg6qszfkLbttwFwJbAJXrjbvWYIx4HCLSyvOw3w+J1VgRJBKaF4hYEBuvoMsUVGdEbnGJ8ulgligfLY/dMwssf95+6hLTMFRB3IUka0TBR5Fd3SYjFxPjKXMVIKjqSHbBhQd9YYro14LY6D+13EMaA9JvX/mT5mNsrysbE/k7tUd51QXsY/KCMxAnF+Es/8D52FW5se80OYctZ6K7TC3f1AZh8KdlWaASDPRcq2t3psKZvrCY9fJtrKWkXWLtb0I6HmBkXW5LShIHl7uMPHvbG/uub49qvV5P4+bk0fjdNV/RF9mNxUxLZs3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Mon, 20 Nov
 2023 03:40:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 03:40:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH] docs/devel: Add VFIO iommufd backend documentation
Thread-Topic: [PATCH] docs/devel: Add VFIO iommufd backend documentation
Thread-Index: AQHaGTuUulTPb8NViUC1VW/CFvbRWLB+eSQAgAAZBwCABAHhwA==
Date: Mon, 20 Nov 2023 03:40:33 +0000
Message-ID: <SJ0PR11MB674485F4F2159B7193BB5EB592B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231117093512.1999666-1-zhenzhong.duan@intel.com>
 <9e2a138d-48b1-47d1-88f5-2794c3692854@redhat.com>
 <e159fae5-ad82-4dce-bef1-264f81b5bb49@redhat.com>
In-Reply-To: <e159fae5-ad82-4dce-bef1-264f81b5bb49@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH8PR11MB8107:EE_
x-ms-office365-filtering-correlation-id: 272b4989-16f0-483a-5dbc-08dbe97a7336
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPDZAx18RFrjfTgsi44nxe0I/ajNMclgBKqsE+5bYhUzcm9FxfM7Ua8kqtC/dL3aVhoScNYunWu5z/+AN/BaOue7W38ce1WF0IdxlRSh8hXwnoG/TcakGTexzii9GOBgQBe2KzWtdQ7zccmjtFx9jlrQxVXm4UuluD6VkgEdHlObfD4bXyQx86E7KesB2WOW1AVyl399pcILiaUi5Wyc4PuD2gMthzT73h/7b5kZRQUqCUdIl/6W2G/fMoIZwIWtuPtYWnlFSbQqWpvzDA/ICmVRpXhUDJkbwaxE8Q6eZV9Zo8bC7/hQY2p1jheaqwWqtcfl51m+Yo1BspOyBqjijwTw6uoVJZ+uOc/G554QABD9fG9W+lo8sYwS3XI4fN3u+OXzmyj/EgDn9XCXAQkAkwfd3r+vvLepJWMgRgX3WJbOaXDW2iq5M6kHL9iQboDRXEMibnLj8Grq4Z6yyPFDYxQJGkJd5o1E8fNDfTAOGCepxEgDarCCCd34NEXYJ6x2pQTFDs5zY3Levmq65T7AmXu4xxlvglrBEx7H8vwcBWTh/xnmdiP04BuF+0IyJxIVARYL3ZdFHBcYa4Mc4g1Q/FFgiUtDww6LdGrSXbFvky1BodzYouPRL+Grh481lmBo
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(38070700009)(26005)(82960400001)(71200400001)(478600001)(83380400001)(9686003)(53546011)(7696005)(6506007)(55016003)(5660300002)(41300700001)(52536014)(4326008)(110136005)(86362001)(8936002)(4744005)(8676002)(2906002)(33656002)(66476007)(66946007)(66446008)(76116006)(54906003)(64756008)(316002)(38100700002)(122000001)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1JwOFpHdHRLQWtDSXJCeml6TzNmR0h3QjB5clZjWGoxZnZ3c2xQcnVEdXJJ?=
 =?utf-8?B?RE03TWtTY09CdTl2aUp1S3c4NFR4VUtZdnpjY2dneFlnbTN1Vm93YnhOQkRQ?=
 =?utf-8?B?a3lNcElZS0ZsSnQzbkkvZ3dOcFQrK3VkM3o3WjZ5ZE84Q2cra01WdnNWWUdy?=
 =?utf-8?B?enJ2Y0h1d2lLL3huUFBPL2p1bllKSjJZV1hoM3A2UFErQ2d5WW9PZXEzUUIv?=
 =?utf-8?B?RlJZRkVNenRXbkxPM280dDIwWXNsUlpmNE16bHlqQU5UWWtOR09YcHZSb3Fp?=
 =?utf-8?B?VnZnVUtQTFVsQllwOFRvTkJwOXkyWURVTjhJY0Vic2tNRVlRS01ZWXJXbWxN?=
 =?utf-8?B?aExwQkRXdnhjZXJsRFRlZ3laYkFIc3hkeVJhOXE4cTJOaUtScG1lTnFHMVlW?=
 =?utf-8?B?aWRlRllEN0RVdTFadjI0K1c1RThPUHlGWWpOZXM1d1lCNGhSc3EzL29DZWc1?=
 =?utf-8?B?NHIvSWVIa09rWWdtcVQzL2l4b1BCcGtLUmpsRVNXN2w5UXlXTGpXeDJoUDRO?=
 =?utf-8?B?MEEwdWk5ZmpINVBrZm1IMUU0b0dIS2RWZHhMTkUrd0RvaXBqNDBqMEl2bW9T?=
 =?utf-8?B?YndaZkNXY3NZRHpIWWM1d2JqN1c2TkVwZ1FqMVMzQnovRVF0b3lxRXoxTkRQ?=
 =?utf-8?B?OERMUjNIWnphVHVDVU5VMnAvUjZTTzc2cngrVzhXVllLVktYcGdYUDhZdWZz?=
 =?utf-8?B?RWw4aG9XaTZ3aDFiaDI3VldtRWo0NnVKMjZPK3BiS0syaDJKQmFRUkZQMWcy?=
 =?utf-8?B?V2NuSGxCdDM4SHlrZmUxMkJnMXkvS0NhK29jZ1N6U2daMTFyTDQvNUNCdnpJ?=
 =?utf-8?B?TGRrNUpyVjg1L3cvemd0WXVtb1Nyd3Y1VlZPWEoyZW9YWEVzQzNkeVc1MWlT?=
 =?utf-8?B?R1ErNVFjTXdYeGlSWWlma2ZwSHhMaTVzWXBCTW5BK1Y0TWhKV0M1MS8wVStD?=
 =?utf-8?B?dFRHUkx2dnFVRHI5b0Yxdk9LYlNZQ2JRQ2hZRUpsNlpSUVY5NVlQYnJVd0VQ?=
 =?utf-8?B?UzlGSG9tTGlVOXVPeTdiWXRtb0RVOUtQTlo4YVA1YUFKMnMxelZJNlZUanI1?=
 =?utf-8?B?cWtSbzVFY2lSbFRDcXZGOXU2UkdaSlVLVFlDbk1lSnZvRnJ2MGwyRVR4aWVk?=
 =?utf-8?B?cnZQVWpvNXVJOEsxaXV3WTdKOURBejRyNkNVOWFvNlM3NVRUMU1KL1E3M0NE?=
 =?utf-8?B?eTI2aGFYdWc5cC9RRDRhUS92OWtVVHdVZUxBZnBVL2plYVYwandsZWtqbXFP?=
 =?utf-8?B?MU00c0p4QURJNlpGMmFMV0t4WVlWcDhJZ3JDWnMvaXZQd0ZYS2pvVXc1QmpJ?=
 =?utf-8?B?c2EzTkxVS1B2bHZ0d0RZNm9xVFRRZzZzNnpPU29qbTZxbFRUcUNoQW04VUNJ?=
 =?utf-8?B?aEtoNWJSZEhpaGlKS2NUMzh6VHBUVHl1bjFuZXhnTjNTZnphYkpIUjJ0UVA2?=
 =?utf-8?B?QjJlMmVvcEpCNTE3dDB0UldlUDhKaU1SUDdVcU9ta3pRN1dZdk8xWElvVkFu?=
 =?utf-8?B?OVczc0VsUFhKOXR3czEvUjd1MnB1ZXZROHVyZWY1MlpOSTRpMVBXc1V2Z1BM?=
 =?utf-8?B?WTR4cFJiVFZLS1l0cjdnK3RnTmpuZStsUXhuTk9PZkFkakpDcG93MExyM0VX?=
 =?utf-8?B?d1FxZm9FSnBUUVY4dUhSZXVUUEh2NFB5TW9CYmp6aGd5OHN4SkxIUWFab1Rn?=
 =?utf-8?B?Q3RxTTl2M1JGRHMydkdiNmdPc0NkMXE1eHFwKzVaQm8yZU9DNEJUTGZCekJF?=
 =?utf-8?B?UnU2aUc3SDc5RWhQRGl4d3FnUHJEb0dod2ZxUmpnNnpDTWVFT25mMUN3SXhG?=
 =?utf-8?B?WVErdTRtZzk2bTBqRHc3THArK0Z2VG1uMXBNK3dsck1tRWc4Wmo1ZFMvcHBP?=
 =?utf-8?B?SkozL2o1VEJOd1hrN05KalJFcHZLSkdLb25ZTVFrSk8xY1h2RkZNdVpGeUpk?=
 =?utf-8?B?L28yMStiOGlMeEZBQkVJZnk0enUvRWVZZzdKYUdFdHJhNzBFbldsdU1xYVkz?=
 =?utf-8?B?Y28veGo0M0RoQzc5ZWdWNTdYbEl0bU1ZbGxUUjIzeUlUZUVOcmpnMVJwdmM5?=
 =?utf-8?B?NkpPSlNnRDVmenAvV2tZcVlDc2hOdGErUGkwZHkrMGJ0K3RRemR4SHk3WVZF?=
 =?utf-8?Q?KJrHKJsvddehr8YDg/mUcEvXo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272b4989-16f0-483a-5dbc-08dbe97a7336
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 03:40:33.0765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S1lNX7IxquqIqCouGXXCj7EqsSxjJ2wKm76D7mNPeETJC0XuUcC8cpyMhRAEPVWn3BBKH9OzcnXKnXT4+hUbSv0+KAdjgxeeJGbdutQxufQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8107
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDE3LCAyMDIzIDEwOjI4
IFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgcWVt
dS1kZXZlbEBub25nbnUub3JnDQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBqZ2dA
bnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsNCj5qb2FvLm0ubWFydGluc0BvcmFjbGUu
Y29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207IHBldGVyeEByZWRoYXQuY29tOw0KPmphc293YW5n
QHJlZGhhdC5jb207IFRpYW4sIEtldmluIDxrZXZpbi50aWFuQGludGVsLmNvbT47IExpdSwgWWkg
TA0KPjx5aS5sLmxpdUBpbnRlbC5jb20+OyBTdW4sIFlpIFkgPHlpLnkuc3VuQGludGVsLmNvbT47
IFBlbmcsIENoYW8gUA0KPjxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSF0gZG9jcy9kZXZlbDogQWRkIFZGSU8gaW9tbXVmZCBiYWNrZW5kIGRvY3VtZW50YXRpb24N
Cj4NCj5PbiAxMS8xNy8yMyAxMzo1OCwgQ8OpZHJpYyBMZSBHb2F0ZXIgd3JvdGU6DQo+PiBPbiAx
MS8xNy8yMyAxMDozNSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4gU3VnZ2VzdGVkLWJ5OiBD
w6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWmhl
bnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+DQo+PiBUaGUgY29udGVu
dCBsb29rcyBnb29kIGJ1dCBpdCBsYWNrcyBmb3JtYXR0aW5nLiBQbGVhc2UgdHJ5IHRvIGdlbmVy
YXRlDQo+PiB0aGUgZG9jcy4NCj4NCj5QbGVhc2UgY2hlY2sgbXkgdmZpby04LjIgYnJhbmNoLg0K
DQpHb3QgaXQsIHRoYW5rcyBmb3IgaGVscC4NCg0KQlJzLg0KWmhlbnpob25nDQo=

