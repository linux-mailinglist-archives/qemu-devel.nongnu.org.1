Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0F07DB242
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:21:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIpo-0007Si-UG; Sun, 29 Oct 2023 23:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIpk-0007NP-5t
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:20:57 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIph-0006ec-5R
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 23:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698636053; x=1730172053;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fu/iLmTvxfSzwqFpn7ONqmztagHEtujIxSjx6ymmqW8=;
 b=N0HrWlP4qXcgmo9M9fpuP+ETlUhEa6rRjF3Hpb6l5bni6xt98Ksl7iTK
 Qu6U4UEHypH1j6KKmHN8CiML7BydOYLKcSRIHz6+ne0wXGkAd1bmZUfbU
 +ZFtD2HezSuxUAU18G2+UFj3Oyw9KET2Y5dQBWsuzw25suVeerF0rOq/t
 76lrIxT9aQes/KtGvsMnmEHQ/hLTwd09tKqAiWcjB9ZJrQM0WRyxViQn3
 22b5nCOEH1p6Nev7kCPF3uVgea76ts7DNmfU0jNFJJZ8iRgekl259Silh
 7wBSqSwF2cVtbngA8bC9jVGxn5ERHP1qguojoTkUMagRFAAW5u2NW5W3W w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="386898234"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="386898234"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2023 20:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="876989709"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="876989709"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Oct 2023 20:20:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 20:20:45 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 20:20:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 20:20:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 20:20:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=is5WvMW67vWVwYxIKT5OQ/lgs6mdecmks1R24j3eD/WcSP6VZivudN0QBLWdmWsrccduvXETsYu9PolZbDtEILH4zBfE6NspI+rmW9rvFfh0iNFtKAv+X9XhU8b+PiMQamfDV9UfMvTkCruK6ogdBZetUZ8m1gVfUPZs9jxFX7RFHqGG/Cfe1D3h7B77IW7y8hpF3UFKPlAUAgMCPYbXGoiF4hQI/2CS98yt0jK2+WtwWnjXoaUS0ywU/LKg5SApkce5Umf46753T+bx5eCLfhxU8nlh+ysClh+7+K/vF9muw3qAQKV1+aoFO4iSbJyz+SUklsgIV/qcwUg+lKqn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu/iLmTvxfSzwqFpn7ONqmztagHEtujIxSjx6ymmqW8=;
 b=hEh09gG4xSffv7J5yJ3yZP0TCXyjHsctSPvS7vcbD/qQg+mJiJLvzThSFwl7BMIq+Wvrqo2e+gtZWzw2mIDy8iXOaU7vsDpbfMvxWCJwjFnVWcnGWqTYcRhd4wEOKxP6eX6RSFWG/drCjUCOUG9tk7winDmtWCZiEEuiss0CrO5TYJV/+qqHjHi04CCcLtNqmaBgsVXmOC1OsfMuh2ym6YVPoH7m6EZOoOvG+U8O2/BcfroAjSuDEqjwac9vw3ateEEAyPO6Dbx2l//hDxbiAURkslA72DhJueuoRfEbmC5qzjwoqXWP4jN+MO9dduUMvhTqtyvaiP8J17BiaDkj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 03:20:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 03:20:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v3 18/37] vfio/container: Implement attach/detach_device
Thread-Topic: [PATCH v3 18/37] vfio/container: Implement attach/detach_device
Thread-Index: AQHaB/nRVie2IHQuT0uECklMV+S4X7Bdz0SAgAPf2eA=
Date: Mon, 30 Oct 2023 03:20:41 +0000
Message-ID: <SJ0PR11MB6744580FADE467B653D454EE92A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-19-zhenzhong.duan@intel.com>
 <1edb9511-da25-4582-bf9f-b28aad5fc8cf@redhat.com>
In-Reply-To: <1edb9511-da25-4582-bf9f-b28aad5fc8cf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6679:EE_
x-ms-office365-filtering-correlation-id: 69f9e1b3-e702-4be4-f554-08dbd8f73263
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WQWB24BbGeJjhWLwXbPFTcUeC1O4EJayiZZmd221tGtxl0dPJjG9k/UZmcV354oxB8x65W2yDKHUyD8xA8qe/Pzp63wAm1k2Ve71Ii3n1W/PQkRCmJukBaoSx/tiKHO0rwE5R2yWty4pec4O6A9D1IZ70oE+TDsxxrL+0WnJnJAshLfl9/KkZM5b+BdvnL1Btd2/6pshRxLHFCEg9ECcHd4mNHBw17pHrt8PvKpfaDt4/NTJuJATn7fv9vHrHCHI8FPlWQdAVMeO7NkmQhliSRwOR4FWGKB7NjXEjspTDWDI42Jwx4ecQMXb/pnwiyIGN/lCRUjq+r0RGiHpQvnaYiWxKe/m5r99JwzJZA/UABs2/KPWDzWMrpaHLGHzd01muAUQI6VquASSan+mIgwxTEYdpKSU7GY2ZFHXJadyk71Tpx0V70Gdvi86D91TdlEZBtT13I8g8Dx9W3SJXLUbrka//xYbJ88jq513NuVFBe6OtpaSNj+IawPSvk6mphHrC7ZOsTOHvfBVZOqEBdTAqL2ipfjm39TJ0UUJ/ezzkNyAS/vmzV7Ete/KBUqdgS//CzvWu0hTwqcEVwo39wpvBu9PK1fHFVqf5f92mxxQllbZZz14ov8sxC2dSFEjMpx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(66476007)(66556008)(66446008)(64756008)(316002)(54906003)(33656002)(41300700001)(38070700009)(122000001)(82960400001)(8676002)(8936002)(86362001)(38100700002)(110136005)(2906002)(4326008)(478600001)(76116006)(66946007)(55016003)(83380400001)(7416002)(5660300002)(26005)(9686003)(71200400001)(52536014)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WjNxSmExOEljakoxd211emw3Si94eUlEQjdyZWcxcHI5aGp4ZDdHQ2QvalJ6?=
 =?utf-8?B?MWhWU04rVEFuOW04eG14bm16R0I3cXQ1bkZuTEpkS3REUWRrbHU0QVVTSnl0?=
 =?utf-8?B?S3I2ZTNVWlQ3L0E1NExFQm5GYy9SMGRkc2RqT2xCQklPbmpsTURpcFc5MmVS?=
 =?utf-8?B?WjhrbXdUd1BhY0F5WTVRNlJ4UlhSQkVCY3hJeENtR2ZZeVJFSFRYM0hsNjFS?=
 =?utf-8?B?VTdJZjVpRzZEbEo2ZTlqVWVMM3ZWdmlRRmlSSytORFB4QTRGMmlvWnlwaHoy?=
 =?utf-8?B?dFpFU3pvNHhFQXdmbTFzdlZiWFVSaTJhOFBoNWhPSzVhRHpGM1B0ZERaNWVs?=
 =?utf-8?B?bGd6MUQwcnMybklLTS95MGRkQUVCVTBOcnM5YVE4VVBIS0VtRXNyRVVkYnpW?=
 =?utf-8?B?TE9aWDREZnhOeStHaGN1Q2wxQUVDUk9NMjlLVFUzbExlcm03NVo4N3E1NUNw?=
 =?utf-8?B?MnRLbGNxaUNhelRicEtROUZTQndRN3hoYmk3WG9ncUEydWFqT1lqeGMxam8w?=
 =?utf-8?B?QzZxZFdIbHlGUDFDZUZOMnNQQjlZbmxwSWN0cmdKcWlLaVNUWjZDTWMyaEdj?=
 =?utf-8?B?OWFpYW5qVTdQUUtIRDYxdnRJSU9KSTN1elJvOHFNb3V1V0ZVTlFoVmdsSzhB?=
 =?utf-8?B?TUhMK2k2czVVNDhwMjBxaWdJeEtXbEJxSFdhdHRSNHJqWXY2ME51TlhOcHZH?=
 =?utf-8?B?S3JOYi9SZWRiYUh2NUQwUUFrQ1BSdE9JZFVmcURXWkhJTEZ4blN4anh2a0gw?=
 =?utf-8?B?UmE5eFNybndzSGNmVThwZzBvOUpqZ1pJaGNYbjVoTDZ0bXJoY0p1VnllQTVH?=
 =?utf-8?B?SGhobndmOXRaQnhOc0xzTThmSmZnRm9ER2VzYU5XMjUxQ2kxWU9JY1pta3Fi?=
 =?utf-8?B?ZEZhcFVmeG9RZFU0dTlGK3lZSFp3aU90YWdwWkZObTVER1llSWdhVG5iWG1q?=
 =?utf-8?B?aEZIdFZFZndVQjIrMitiWFEyNm55S20ySXE0SUMzUkRRMkx5ZGcyQmJ2M3NK?=
 =?utf-8?B?MnZtM0RnT1Z4T3hmMFJiVHc5b0xIZHh5b0dUeDk0eDZGQTFBMHNoWnpqTEFa?=
 =?utf-8?B?WDB3NmZ6M0lQR01mL3ljZU9XT1UyM20xc0pSV1FrbWlya1FnaTFWZGNmbmxW?=
 =?utf-8?B?eUFzREZqWFQrWnlxZzFydmFtMHJINDZ3WVpIZzV3STlqZ0VvWC9vd1d5d0NL?=
 =?utf-8?B?bUYwYjV3czVLVllMTFJ2YXEzODhGZmR0dHdkTmZsSVZtNlZoUXhsOWZkR1po?=
 =?utf-8?B?S0F3aXJoMWxPdnBBOHNicXVBY1RDWExNc0YyUDVpQjdkOWxjZG9sY28yVkc1?=
 =?utf-8?B?NjBzbDNpUkFJRkNjZU9ZTUIyaWlQTFphd3JkSk9laHpZNUttVW5KUGhld2Rx?=
 =?utf-8?B?NHRhQURXZVl6MHJkeFZpZVBOR3JGd1BqSmRBVkpnemgreTBKRGVUaWw2TVdq?=
 =?utf-8?B?cWFHU09iRlRGSnpHS2k0RHg1SG1sMFBmOStLU3lWcnJCT20ra3dmQkYweUFK?=
 =?utf-8?B?eGJkVXhlRGYwVHlqQ1NYbE1mUm5hMFBSRVp1OXk5TG1venl4REl0cGNVQ0pK?=
 =?utf-8?B?L2QweWt5L1d4RXMrS0pIT2wySVFnZE8wWkU0YTU0NXBiREx5RHNwaDFrZDl4?=
 =?utf-8?B?aGI1Z0pUOHFMS1l0RjVSUENXOXFaR3JCZXVqdWp1MG0veVlMYzhPdWU2dGRL?=
 =?utf-8?B?Y0tla0JpVElqd2c1ZlkxWlNNbVE4bDFxRkp6cEpoRmtldFoyRFFQTmFobDU3?=
 =?utf-8?B?dDlwQnNib212bGhuUHFQY01JdmFDMlBiYlF5dnFMdUk3TVlHb2VIQlZrZGI0?=
 =?utf-8?B?UU9aOGE4VXp2MHh4RTJIakQvM1ZSRm5BZGNNNzRnL2dIY2wvVUlaLzViL0VJ?=
 =?utf-8?B?d2JTZ3RZNUhHUGpFVHNYTUtOZno1dWNyR0hMTFhRVHQwMjdnYmxjT1RBa255?=
 =?utf-8?B?RG4rRkRUMHR6dGE5MHdVd2thZ3VDM3d5eUlYb1dZZjM3UnprWjc1a0k4WWI4?=
 =?utf-8?B?bzNycGtDSmtJdUZwdFFQR1hYVWJENWVzN29Yc0VaWW1Va1FMVmlXMUMyUXZ0?=
 =?utf-8?B?RHBEYXRUa3hVa2lvdWkwVThYdjAvMVE1WXpKV2E1ZGM3UGsvR2dwdFhEcmVa?=
 =?utf-8?Q?xxOKQ+27rrWToTa334xPI2aE5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f9e1b3-e702-4be4-f554-08dbd8f73263
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 03:20:41.6897 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y7dbst5XCwTDIPvWVSvb0DUJwXbTs0L7s82k33k6e38QQYdRDuE20oB97BwgjcRoqbfrh0RXSruWTR9CRV38qQMQG9Ei+xK/d3nU4xDWHVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6679
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBTYXR1cmRheSwgT2N0b2JlciAyOCwgMjAyMyAxMjow
NyBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTgvMzddIHZmaW8vY29udGFpbmVyOiBJbXBs
ZW1lbnQgYXR0YWNoL2RldGFjaF9kZXZpY2UNCj4NCj5Tb3JyeSwgcHJldmlvdXMgZW1haWwgd2Fz
IGVtcHR5LiBGcmlkYXkgZWZmZWN0ICENCj4NCj5PbiAxMC8yNi8yMyAxMjozMCwgWmhlbnpob25n
IER1YW4gd3JvdGU6DQo+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+
DQo+Pg0KPj4gTm8gZnVjbnRpb25hbCBjaGFuZ2UgaW50ZW5kZWQuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogRXJpYyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1i
eTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4g
PHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBE
dWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmlj
IExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmZpby9jb21tb24u
YyAgICB8IDE2ICsrKysrKysrKysrKysrKysNCj4+ICAgaHcvdmZpby9jb250YWluZXIuYyB8IDEy
ICsrKysrLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92
ZmlvL2NvbW1vbi5jDQo+PiBpbmRleCBkNjJjODE1ZDdmLi42NDU2NWI0YWU5IDEwMDY0NA0KPj4g
LS0tIGEvaHcvdmZpby9jb21tb24uYw0KPj4gKysrIGIvaHcvdmZpby9jb21tb24uYw0KPj4gQEAg
LTE1MDAsMyArMTUwMCwxOSBAQCByZXRyeToNCj4+DQo+PiAgICAgICByZXR1cm4gaW5mbzsNCj4+
ICAgfQ0KPj4gKw0KPj4gK2ludCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJT0Rl
dmljZSAqdmJhc2VkZXYsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2Ug
KmFzLCBFcnJvciAqKmVycnApDQo+PiArew0KPj4gKyAgICBjb25zdCBWRklPSU9NTVVPcHMgKm9w
cyA9ICZ2ZmlvX2xlZ2FjeV9vcHM7DQo+DQo+aG1tLCB0aGlzIGxvb2tzIHdyb25nLiBwbGVhc2Ug
ZXhwbGFpbi4NCg0KVGhlIGZpbmFsIHNoYXBlIHdpbGwgYmU6DQoNCmludCB2ZmlvX2F0dGFjaF9k
ZXZpY2UoY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQogICAgICAgICAgICAgICAg
ICAgICAgIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9yICoqZXJycCkNCnsNCiAgICBjb25zdCBWRklP
SU9NTVVPcHMgKm9wczsNCg0KI2lmZGVmIENPTkZJR19JT01NVUZEDQogICAgaWYgKHZiYXNlZGV2
LT5pb21tdWZkKSB7DQogICAgICAgIG9wcyA9ICZ2ZmlvX2lvbW11ZmRfb3BzOw0KICAgIH0gZWxz
ZQ0KI2VuZGlmDQogICAgew0KICAgICAgICBvcHMgPSAmdmZpb19sZWdhY3lfb3BzOw0KICAgIH0N
CiAgICByZXR1cm4gb3BzLT5hdHRhY2hfZGV2aWNlKG5hbWUsIHZiYXNlZGV2LCBhcywgZXJycCk7
DQp9DQoNCkRlcGVuZGluZyBvbiBpZiBpb21tdWZkIGlzIHNlbGVjdGVkLCBkaWZmZXJlbnQgb3Bz
IHdpbGwgYmUgY2hvc2VuLg0KVGhlbiBjb3JyZXNwb25kaW5nIGF0dGFjaF9kZXZpY2UgY2FsbGJh
Y2sgaXMgY2FsbGVkIHRvIGF0dGFjaCB0bw0KaW9tbXVmZCBvciBsZWdhY3kgY29udGFpbmVyLg0K
DQpUaGFua3MNClpoZW56aG9uZw0KDQoNCg==

