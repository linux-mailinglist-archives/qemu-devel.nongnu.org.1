Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5687DB237
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 04:16:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIkP-0003wG-K4; Sun, 29 Oct 2023 23:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIkN-0003vp-Ij; Sun, 29 Oct 2023 23:15:23 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIkL-0005ac-UF; Sun, 29 Oct 2023 23:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698635721; x=1730171721;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K5Xjl0aOWhR2bFHKIWxNR7T1m+QykS1hDmgB5bnWhrk=;
 b=JANZtHji+TknzK9IC2QRVX9tvBIyti4w3wgDiXJw2lwkVyzcUbDIYmhA
 9bwK/Y0matMiYmbmB+zFYW/dpZFtFQJShU5hQw28hZTqu4dPEnCfbJZp4
 VG0R+Ih0YFn3L3WOCHU/DN7FlyoCUFr2e5jXZ298dotkbiFVfs0dwYghW
 Frf6Ip1c0+o6Mwo3pjwTaJl3TjlbMNSlrtPuGHcMnDFEErOp6sW7KTrbj
 SR5+SxTa891V0WCI1bOD9tQnWoneai+IIvZsVvkeRTvI45T19bGIVUozQ
 WsK/QLex5SLAssOWWG3vhu22G+uD/NwXarWfHyoA4yn49mH53bTljw3EF w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="386897810"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="386897810"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2023 20:15:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="825929366"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="825929366"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Oct 2023 20:15:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 20:15:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 20:15:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 20:15:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9xjtxlYX4CjR948fWFU+OZqkBz02iJvFWmbpXlCX/I21QEt9Dt+MOrwgVPiytljq/3ox6bBG6xlPe/3cspDkY+ILrScOa1BP+WiUAt1e6ZfBTToole7+opGBBkaWKI80TjBYY/YQgrv6VoI28DBf+ySc1J1RisMwnM3lDFMmpJzWGGrSaGltPotGWv4UhM5TSGWGNhcZbut7cu0Ww5HnXpq7tyycsBWNTL9iQj9KCMtQliZv5s3/IBTQo5nh64ElqvNpYWTGrG6wpTqU2oavgmLbCqWPmaA3O6xWWCQGKZ7kQgITgJjDn+YWM7i+zPSw+Sn9nQ1Z/VennAX76hgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5Xjl0aOWhR2bFHKIWxNR7T1m+QykS1hDmgB5bnWhrk=;
 b=npA2qEuekd7sgAjK5BDxtrEGn+CDCmzPjmiH0u83/LXrZAi3H7mRGIEmMbr+ddAq126FQwhUl5RPiKeSwHzh+oCXTYrvg3Xnnj61mNIl7bwZ8+QvhWUVFj4cRSd756vs9h5uTAeHSE3vVjLy1QyRBZaQnZySnEKiFr/fmrtgDwsCzusgzCSI00tf7DKLWrfmAZT9LkANO5TynjzSocm/wJ8hDRe/uWxdaQNMx0nT8ENOE0hOZxbXHFD49s4e8f/ZW2AjgYGfRQsnkMgHS+2Pkpm3aqoxFjP5IT7rX/UZvZIXCzMZckg9SpXS40+sVI4CFh/tG1vP6kFgitTYAt8qhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6679.namprd11.prod.outlook.com (2603:10b6:806:269::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 03:15:15 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 03:15:14 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@kaod.org>, David Gibson
 <david@gibson.dropbear.id.au>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v3 19/37] vfio/spapr: Introduce spapr backend and target
 interface
Thread-Topic: [PATCH v3 19/37] vfio/spapr: Introduce spapr backend and target
 interface
Thread-Index: AQHaB/nTkgQhpKyrsUujREQTtXtLg7BdzpoAgAPf1OA=
Date: Mon, 30 Oct 2023 03:15:14 +0000
Message-ID: <SJ0PR11MB6744C6BE59E41E59F56E0E5C92A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-20-zhenzhong.duan@intel.com>
 <87f13c36-f2e0-4719-ae08-47a03a808b1c@redhat.com>
In-Reply-To: <87f13c36-f2e0-4719-ae08-47a03a808b1c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6679:EE_
x-ms-office365-filtering-correlation-id: 1369af79-a45f-4251-e619-08dbd8f66f62
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ql9uQl8A+M+QsH23nz9zw5Ac8Rv1I3JrManwyev05qNWa0gHh/nwvxRf1i3IXcFGQlWjDPxiR9xlt30rIuUcE05bzfclAuwqLKc849oOVoQePOf1EGoZQRwoNXLwGv5l377Efsl3zifCab1/k0HPgBRjRUPFRcxp7TD5dAV7Bt8F7kfwIqzzqWzIonuKQVhOp2KSKE3HdoVZ4kQFEkgEbq7aRkeOF3zzW31JlD5ltuOYhiqiPq/cqFA9yDiNWaPvBHPWxEJUy4C/QzjI7to6Xue3e2xvNcSIfhoWHtedzqG7YQBt4sQgg56ZFLiwVch2ke7UQyrdru7porxFq0GbwbHDGIyPaRljchggjFAFPnRvE8WpMybtM8/Ex8fyyMmIOx9G3PJZcPE8ntfKx6luMaQqXJNy4hsHdgBq2+WgkdesqvZDHhtCrqehf8QOYXNdUGxBVSveIoqVw/62Vi8SuyU6/+SvCz7t1545JScklQI/JKpAJ3LpmPASOLty9ghAV5ml1Qu+ZGpIxc9biwf4ncZzvJvbkuGI9VywuKNLSYjb7TwUddzZa0EKmLNlBiYdXipcfaL58b6wjtdpjqG46Yhf1euZTWjPER9HhP0Yn2VM4NW1lHkLMTp9EyQPWkBS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(83380400001)(5660300002)(66574015)(7416002)(71200400001)(9686003)(6506007)(7696005)(52536014)(122000001)(82960400001)(8936002)(8676002)(33656002)(64756008)(66446008)(66556008)(66476007)(54906003)(316002)(41300700001)(38070700009)(66946007)(55016003)(86362001)(478600001)(76116006)(110136005)(38100700002)(2906002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anpVc01tdVI3OXZxNCtTUkc5OHhyMGFqYzNlRVJ3WG9GZmhVdGxJczVLNTFZ?=
 =?utf-8?B?TTRFeGJPblNxa213cW1UeDB0MkUyNUg4K3piNEpUVDVUWnhVeEhVak1QS3Mz?=
 =?utf-8?B?V0tvT1hGQng5WENtYWZ2TlBHT3JMQmc0WURLWkpLZ0F3M2dGckJoQ1g4OC95?=
 =?utf-8?B?bitTN2ljRTMrNTRTbnoxbTl2SkZFOC9yYVR4aUp5UTh2TTREaFNocjg5NGl5?=
 =?utf-8?B?STg3NHBMaVRrREkrNzdKbnNld2wzZytMUzdvVitOL0lsM3loR0ZBLzFINzlx?=
 =?utf-8?B?am5JUHBTaG1xQlVPOStKK0FOMjBzejkzQnJWT2gwMGFLUWJrbVpIVVBvM2lC?=
 =?utf-8?B?WGIyRHlDZ1lSemQwdnpxUnVWTml0dnlDL240SndURCtLTm10Zk9ORjBtaE9O?=
 =?utf-8?B?OFhxTnY5YWtMMkRjZjVzRVFRZWptNlFUMjY4cEZINzRCaXhTU0dHeWJuM3JE?=
 =?utf-8?B?L1NidmdnRHBHMGh6ZkdLRVkxdEZ3Qk1wVVUvRlBSSjZBL0NJUE84ZTUyYU80?=
 =?utf-8?B?Q21BTDd3NDVhYndiVnN6OUhoRGtwVnBMWnJ3Wk9LejNRNlc0VGFhTE8rclVN?=
 =?utf-8?B?UHorbHFoYkQzL0RuazJwK2c0Nkt5Ym82eEd3dkJDemlHSS9mNEZROWZpYnNG?=
 =?utf-8?B?ZFN4Z3hCOHNpYkRUYlhBNUlzSlkzN2lkWnFVa3FJdmVXdjZRVDVKcUpGY0xq?=
 =?utf-8?B?L014WmNTMWZqVlhydVBWUkRhRmNmcTU2YWk3Rkt6RTN2Q1RPb1owd0dxcjFN?=
 =?utf-8?B?UW8rWUZDTys1UGt3Z2UvSXVMK25BNGN2aUJpZHhiYWxuNGNaY0t3VUpxVHl1?=
 =?utf-8?B?SllEUFVlcmloUTFXNyt6UjRKQlVXMS81OGJYN0xUNWFkU0VnWXFqNFpjSzZo?=
 =?utf-8?B?c2VBYk80OUpqYWZiUlhWMkdRMm8wQ0w3NFJiMW96Yks1Q2VJZHZhZEdjbXV4?=
 =?utf-8?B?YmE3WUs1L0lhVnczSlJKY1lrSmJxdlBKSDJpdUY3V3R3TFJaVkI2YUpORU81?=
 =?utf-8?B?SkgvVmw0OFZ4K0FkWVArZXMzN2wzSm1xRUo3SjBNVldqRmdWaFYzeDZvTU5t?=
 =?utf-8?B?MDU4SzFQVmI4VDRqNGI5eHBmdnQ1QUxxUHRnU2FFc3prb25kV2xOTmxkRGpC?=
 =?utf-8?B?M2JkdDNiZms5MldQaGJScUJTUFRiT1ozNUdidVllQlhoVHVhdzFwODh1aEVN?=
 =?utf-8?B?aklQcWlrdTVZWTVxY1lGYmpJWlNveTIycDQ4azEwTWlvSHZTQU5vUVZ6d1hN?=
 =?utf-8?B?V1ZVNkg3bC9INXJUeGFCL2UydUtxbzVvREpnRUc5Ni82eWk2ZmZDMVlWWFpq?=
 =?utf-8?B?NmxNSkdHMFlMUVRKdHpndUtNRXBPdDRuUmd3OUJ0Q0N5eDF0SmFRa0ZYT0NJ?=
 =?utf-8?B?dlo5eVR3eUJkSkplT3E0YXFEMkl5M1dzcDhkWkkyYVdVVENsYnJQaWIrN0My?=
 =?utf-8?B?OUVLa2V4ZEp0bjRsaFVaNUlQWTBINlFBRVYzV1BiMHpYTS9wckRNVEZQQm9K?=
 =?utf-8?B?WFNBOFZJYjQvN1kwQTZMVkFEQzZLYzcyWWlzNVpEZStOYlhhb0xSd2xyNXdB?=
 =?utf-8?B?d0pqWEtTVmsvN0RVTG1sQk5Uc1R5V3NPT2NvcFVnOEZJMUMyc2JkMnJGTTVs?=
 =?utf-8?B?SDIraHYvdW1jTXdmN1Y5K253UFJrRmU4VUdoeCtBd1dlbDJMRzR6akZmNEla?=
 =?utf-8?B?VWV2QkFSRXVuUmFhekp0TWYvRkROWWFPNXZwZ0x6Tng0MjBFVHVZWXRYYkpR?=
 =?utf-8?B?emJqN29aaEJrbWcrVXdBZUt0WnpUR2k3RGVmT2dpY3N5SlVmZHRUVEFJTG1v?=
 =?utf-8?B?RG9GdUxzMWRCM0dPLzlLWXJZSUtLWXRSMU0xSGtTTmJUZHpocVpYN29lSUZh?=
 =?utf-8?B?U0llRXh1c0p6TVg2aGNZRjBwZWhYQnhjMnRPZERJa3dIOURxKzlDRVFTdS96?=
 =?utf-8?B?aENITThVcDQ0d2M3dzA5cFp5YWZzYWY0bWNDWFhSWnJWRlo2Y0tTQWdUWmdv?=
 =?utf-8?B?TEVEQ1BXVllkbTdsd1ptbVlYRzlQWVdPODlUY29sUkkzSmpMWDZFUDBFT3Uw?=
 =?utf-8?B?QUlUcDNSZCtDWXhzOHlwR0xqV2pwY1QzdTk5dkVHaEJndU1DcXBvdk1NMFlh?=
 =?utf-8?Q?h+HmEIUNBwpuLschOSTbqAkfH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1369af79-a45f-4251-e619-08dbd8f66f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 03:15:14.5038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JTQS8NEBvM5ROiw7S0c8BPMuSFNcwibQwfiEat1ViY7ZmF8dV2MDAc0U3sBsKHI+NKG2qSf9BQYDLIBPE6vs+JhLTQZpzOnSvGNCbXsdkOw=
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
NSBBTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMTkvMzddIHZmaW8vc3BhcHI6IEludHJvZHVj
ZSBzcGFwciBiYWNrZW5kIGFuZCB0YXJnZXQNCj5pbnRlcmZhY2UNCj4NCj5PbiAxMC8yNi8yMyAx
MjozMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbnRyb2R1Y2UgYW4gZW1wcnkgc3BhcHIg
YmFja2VuZCB3aGljaCB3aWxsIGhvbGQgc3BhcHIgc3BlY2lmaWMNCj4+IGNvbnRlbnQsIGN1cnJl
bnRseSBvbmx5IHByZXJlZ19saXN0ZW5lciBhbmQgaG9zdHdpbl9saXN0Lg0KPj4NCj4+IEFsc28g
aW50cm9kdWNlIGFuZCBpbnN0YW50aWF0ZSBhIHNwYXByIHNwZWNpZmljIHRhcmdldCBpbnRlcmZh
Y2UsDQo+PiBjdXJyZW50bHkgb25seSBoYXMgYWRkL2RlbF93aW5kb3cgY2FsbGJhY2tzLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQo+PiAtLS0NCj4+ICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggICAgICAgICB8
IDggKysrKysrKysNCj4+ICAgaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8
IDIgKysNCj4+ICAgaHcvdmZpby9zcGFwci5jICAgICAgICAgICAgICAgICAgICAgICB8IDggKysr
KysrKysNCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oIGIvaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29tbW9uLmgNCj4+IGluZGV4IDkzOGY3NWU3MGMuLmE3NGU2MGU2NzcgMTAwNjQ0DQo+
PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gKysrIGIvaW5jbHVkZS9o
dy92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+IEBAIC0xNjksNiArMTY5LDE0IEBAIFZGSU9BZGRyZXNz
U3BhY2UNCj4qdmZpb19nZXRfYWRkcmVzc19zcGFjZShBZGRyZXNzU3BhY2UgKmFzKTsNCj4+ICAg
dm9pZCB2ZmlvX3B1dF9hZGRyZXNzX3NwYWNlKFZGSU9BZGRyZXNzU3BhY2UgKnNwYWNlKTsNCj4+
DQo+PiAgIC8qIFNQQVBSIHNwZWNpZmljICovDQo+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0lPTU1V
U3BhcHJPcHMgew0KPj4gKyAgICBpbnQgKCphZGRfd2luZG93KShWRklPQ29udGFpbmVyQmFzZSAq
YmNvbnRhaW5lciwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uU2VjdGlv
biAqc2VjdGlvbiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+
ICsgICAgdm9pZCAoKmRlbF93aW5kb3cpKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgTWVtb3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlvbik7
DQo+PiArfSBWRklPSU9NTVVTcGFwck9wczsNCj4NCj5JIGRvbid0IHRoaW5rIHdlIG5lZWQgYSBu
ZXcgc3RydWN0dXJlIHR5cGUuDQo+DQo+SWYgcG9zc2libGUsIHRoZXNlIGNhbGxiYWNrcyBzaG91
bGQgYmUgdW5kZXIgVkZJT0lPTU1VT3BzIGFuZCBvbmx5DQo+ZGVmaW5lZCBpbiB0aGUgVkZJT0lP
TU1VT3BzIHN0cnVjdCBmb3Igc3BhcHIuIFRoaXMgc3RydWN0IHdvdWxkIGENCj5jb3B5IG9mIHZm
aW9fbGVnYWN5X29wcyBwbHVzIHRoZSB0d28gYWRkL2RlbF93aW5kb3cgIGhhbmRsZXJzLg0KDQpV
bmRlcnN0b29kLCB3aWxsIHVwZGF0ZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

