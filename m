Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D346731382
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9j8l-0001RQ-CD; Thu, 15 Jun 2023 05:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9j8i-0001Pm-CI
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:19:36 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9j8f-0001xU-V4
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 05:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686820773; x=1718356773;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wLPk5xMDtDY1AAKxJiDhnv2m53p0W8o6kfXiKCrc/fE=;
 b=YHrAZwiedd3eWUJ6Xrjyb6pWmb4yh9rIvp5i4AwxSCzCSnmQJTcxj3vU
 hW5x1STNSnp+5xT4+tJHbLZkeATiK67Z6QB17ImrMuwhUkluxsel2kt6L
 6xD7N3L/TmEor0hAWcRWHOWReKnNJ6Q23y+T48dupRZW0yuaPN1iUtszk
 lrAtAC/egMV1mCa4YohrgdFWPb4y7zqa4ByTt2wq1Ve/Rsdc74eTq5XZU
 Eq9fSubjwFQRJehs14a8Q9vyIVQMWSdANsz2z3+jVOQLeBrylE0eSKKmk
 ff2tZ7jhuHqQDqRViEihoyzYttyfICpM6yhZ9qWg33dxcQAIL+A8ZR4mH w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="356351130"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="356351130"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 02:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782457270"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; d="scan'208";a="782457270"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 02:19:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 02:19:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 02:19:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 02:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMfO6o0Iv8gYfTAzkSJjN/ENsPRk3zGUHQLlZz2FoRKZQEqCIvGXLDdkzNVUxrqmyhyi2bA7196qo8/GWlW/0vFYl/1ta2/9LxRP+ZPAQiABgBwgOKQ9D/tnJJQsyV82toJBl8OGsOOey2QnEvaWQYbhmYYgE8Q+w634AipwANTkGprojOpIiXFFMRnQg0qLEIkvD08fMzZEif9iz1y5A4xd1J1eZNZj7QfOLAbuoECL+UB+O13wImarVDW6OsVJxgxRW1RwxqgL91dHKc+5SPt5EJpL7DJYCIp7rcAcDsoW+dIA7478H1KO0dbwt1Z0MQ+QIrnu0qvrQ5jofE9EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wLPk5xMDtDY1AAKxJiDhnv2m53p0W8o6kfXiKCrc/fE=;
 b=lWQHn7qoOxOwN9Af1oOetwIh1927cTe4usRR72ieeZRuoLHOZwRpXa+FLAbtm17gke/JU1Xx9Y882Dv10CxMgPwMVGjxZTBRjs1b7adjTPxQEFjwKgFYWCwcGKbVdmxGftqJAS3KxU5emzxUButh6JIHS0GCpppcjyA7rXT9nKj+vIy6yF3L6KqeL0NIolzJrMgnIw7W3ZMcfXEslag4e+kA0KFmX5QkvfqutKZM8GhZHlPbPf8Qdkviuso4SCJ/HHAL8eF7PzKF7/VQUmZ2k+L8Ntyu93ydXJhDI5vwi1ywnJRBYfn3/flp2k06srGzSPoILG8WxKN9JFq4OCqzeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO1PR11MB5123.namprd11.prod.outlook.com (2603:10b6:303:94::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Thu, 15 Jun
 2023 09:19:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 09:19:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Thread-Topic: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Thread-Index: AQHZn2PPlNEvmdczhUGNGr4N1q3IM6+LjxGAgAAEy5A=
Date: Thu, 15 Jun 2023 09:19:26 +0000
Message-ID: <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
In-Reply-To: <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO1PR11MB5123:EE_
x-ms-office365-filtering-correlation-id: 693fce7c-7e1d-4a7a-9c0f-08db6d819da4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmGBa0mANh3BBEqz8mRx8bVi6Vmv87K20LXf+Nb/UjCLc7AO54TLBWVFG6Do/asA3oQFFebnNSQB3XZDLi837BzX49JtceaCsdQBe30hQF9ORiNWIW3OXFTDdSlOHsRC98PWPNLyZb3Y8VcPfWBVppfILyadBsMjzQAX66FE6V9rbiprbexT6aDYFja+fE4obDe5D/cD7LPkZPageWs5rAIUwI2jCaUJIJjUOe29d1W5MZepy8ihg8yywmunOSJlP7DPG5elS4Y5dGSWuwOHItwj47CrRrqo4WIAjykvHhOAXQMbqslnFq6KPlfegY+hv06gtx7zQDMiUqi65fp20aPrKi7rbZJ90rS+Dt3A2uCqta2vmk0xWWkKcWZm8VXJNCocUPmA1AJZpAUeFrBkvxHE4qXchafxBLZl4rGbXAhG2LB5zOeEQ7Ek3tNhFMfldIRbRkDrGLZ95HV+mw7lnhuqkxpoXsweXO4uFlq2Uu5JRXpbFsFNOEYrWi6ldOAiqBGEfitMGcZEBpssiOEfsBrBP1lCqPd4ykGjnjokFTn4zcJqDvXDpDJmACfn3dPCweBrmr6f3Ih7ZOlFxwsJ4QSfu17GcHIJAdhkM/cZoRTKRPqav+UDv07OO7n4VfrL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(376002)(39860400002)(136003)(346002)(451199021)(54906003)(8676002)(41300700001)(7696005)(86362001)(71200400001)(8936002)(66446008)(64756008)(66556008)(6916009)(66946007)(66476007)(316002)(33656002)(76116006)(4326008)(38070700005)(478600001)(107886003)(9686003)(55016003)(5660300002)(52536014)(6506007)(83380400001)(186003)(2906002)(38100700002)(82960400001)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFVwcnVobFN5bnltTnpUcXRWYittRnJ3N0ZhTGtuMXZpTVRlU0M2M0pBaWxp?=
 =?utf-8?B?VytWcnFIZjE5Y2Q3L1VuMFhhVWxyUjFaMUFkdHpaTGhRNElYaXhwa0hQL2FI?=
 =?utf-8?B?L1c1cnRab1QwMnNjd0hkZ3ZJOVB4UmdhWjQxMHlFcWdJYWZIcFE4UG1XYXEx?=
 =?utf-8?B?OXE0cGs2aHdNVCsxMy9XVTJlUzl3K3IwbzhuUlBXekc3ejNmNTlzeWZINzhk?=
 =?utf-8?B?VWJFVkUrM0VKMG9RaDNja3dSTnBTb2dHcjhIYzNUR0E5M014K3ROenVtSE5Y?=
 =?utf-8?B?d0dlUjRaT0dKMDg2UDREa3FESDBoMDQ3cDBHUU5zcEg3WDV1N0lGWThxT0pK?=
 =?utf-8?B?NmxCWmZzQUE3TWFneUxPTzZaYmJtL011SGE2cDB6R2drcDl5Mi9LYnI5dGNi?=
 =?utf-8?B?cDNsTnBIUDZZa1NzbUw5Z3hzRVBnQ0pYNVphdWlubWx0UGZNTWJYcFVWd1B3?=
 =?utf-8?B?TDhrK25HYWN1bldOYzFBM28rSUYreXVmdm9hZEJSQnFJQTA4NGduei96aUxJ?=
 =?utf-8?B?WWtabVMxWHp2a20vMm1IbWI3YW5nUElscmpJSWxKMlNTV0dxNGJmZVlqeHIz?=
 =?utf-8?B?UHgvMWJqVzNYdCtINklabjNhUi9mRkI5bG5LaTBtTzBvKzUwK3E0VXV0RkF4?=
 =?utf-8?B?NUhWVEhqakxSTnRka1pzbjBmc2NYYWJZUHRoS2czNktBckdMQjZlUXcvcmFD?=
 =?utf-8?B?eW05a2U5b1VBbXl1M05OYlFCTk02SnVVdHZETjBPR0hLYjNnSzFsTkVxa1Fr?=
 =?utf-8?B?cmlMRy9rbUFzSmdtakhid2FaNDdUR1dSbUNoTGhuVkdMUi9jRWhCbTBlWVZO?=
 =?utf-8?B?Y3QxeUV2QnhZTTBqbVpMcEpEQnRvVE4xYWh6TU1seFV5U0ZpekR3NDJlcHc1?=
 =?utf-8?B?TzhQZUU2UzZ6RDBmMUFNeWNUUkYxNGQ1blprRXpNTm40L0lCYXdrUkM0di9n?=
 =?utf-8?B?OGV4czY4bUFsOVNpdmZCenRNcWdMY1RQRnBRejI4NGJHVk5QVUVhbDZBREtv?=
 =?utf-8?B?bk02Y3k5LzFqVUF6bDgwZUdhOWFKOFUwaW52bExPK1hYYitkT1dtZmJIdzdV?=
 =?utf-8?B?UU9pd2dDRWVrTWdBNk5JRUJDMElzS2VqNUMwZFZoNHZ5N015NVZPSFBBd1Uz?=
 =?utf-8?B?aFZrWjRwenRZTm4vYlN5TlBFeGVOSjA4ck1sT3ovVllyYVBJY3hPRjhldnN2?=
 =?utf-8?B?b2lyVnJRNFlvbHRneVNpR0l5ejFReEVHeHQ1cnVaUUh3MDdQOEZHeEFMMkdp?=
 =?utf-8?B?VThWWXFrK3grbm5keGYwc1ZUSEx2cWpVT2x1S2lmYTR3UHEwR1FvS2ZZVGxZ?=
 =?utf-8?B?cFhwUXQ0M1FWK3VibFFGUHZMNnhXbDJyRVZ1TndjMkZ4eEZzd3BXWW10VUF2?=
 =?utf-8?B?dDQyODJUUU5TNUltWFVYTnI0TDRMQzQxTFhHcW5VczYwSHJtRldodGhsYW5D?=
 =?utf-8?B?aGcyTG9KcVRyUVZtbUMzaUYxeERINDk5VnpSQ1FNTk95NUdDR05CWUtsYytS?=
 =?utf-8?B?WWI1dncvL01XMS9ORThrUXZISnErK3VzMWpGa0FMRjB4NFAwWS9IQytPNCt0?=
 =?utf-8?B?VmNwN1U3VFNWZFQ4WVczSE1uTWJOSmVCMUJvemdYSXJIUFc2dEE3TnczM3ZI?=
 =?utf-8?B?cDJGMEM3QTljaEZIb1kwdWFaRTJpb0ZwSllPVW02U1FRbTNpRWhwZXRsVUp5?=
 =?utf-8?B?Nzd3ZWZxYUhGQ1lteHdWVDJ6cTYyeElZK3VTc3BnbWs3MWFPdk1NN0NjRWdU?=
 =?utf-8?B?K3VGdDVVMEpEbjVsWlMwTFhhVWxOMUpqbEdDeThCRFc1ZnFMZXJRVU15eW54?=
 =?utf-8?B?cGozdHFHWEFZdFc0VGVyaUtyanNLRFl5UmM2L3UzYnJ1QWNHUWJSZTdVU2RW?=
 =?utf-8?B?bEttaUNsKzVvSkZQTWd0QUo1eitTTTJZd1hCNG80Zmh5bXVLWlpPdXl6NXFk?=
 =?utf-8?B?aWxnUGhMbXJUVysxSmxoZFk4OEtXV0N3cTcyMUxDUFdNNmtFT09iMHFwdDBT?=
 =?utf-8?B?aDROMVpwalZJWnFHNTVkZjYxRXdNNmczNXc1NFBGSGNrMFBFTzNTeENaVWtO?=
 =?utf-8?B?ZGl4ZWovZzkxN3NqSkFvWGNvSEdpcGNvS3hlc1psamJZZlhCc2U2WVoyVjMv?=
 =?utf-8?Q?7pbU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 693fce7c-7e1d-4a7a-9c0f-08db6d819da4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 09:19:26.5548 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RT6M934vrwMwBQyjxIwxQlE8GuESxJcmveTtJi2AEIsED5Zv3+RLS5+bWB2PP2uJhgedjfZixlTRBIlBxV3+o/fVbT0XnZozyM2bMofZMbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5123
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSnVuZSAxNSwgMjAyMyA0
OjU0IFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
PkNjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IHFlbXUtZGV2
ZWxAbm9uZ251Lm9yZzsNCj5QZW5nLCBDaGFvIFAgPGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj5T
dWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvL21pZ3JhdGlvbjogRml4IHJldHVybiB2YWx1ZSBvZiB2
ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkNCj4NCj4NCj4NCj5PbiAxNS8wNi8yMDIzIDA5OjE4LCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdlIHNob3VsZCBwcmludCAiTWlncmF0aW9uIGRpc2Fi
bGVkIiB3aGVuIG1pZ3JhdGlvbiBpcyBibG9ja2VkIGluDQo+PiB2ZmlvX21pZ3JhdGlvbl9yZWFs
aXplKCkuDQo+Pg0KPj4gRml4IGl0IGJ5IHJldmVydGluZyByZXR1cm4gdmFsdWUgb2YgbWlncmF0
ZV9hZGRfYmxvY2tlcigpLCBtZWFud2hpbGUNCj4+IGVycm9yIG91dCBkaXJlY3RseSBvbmNlIG1p
Z3JhdGVfYWRkX2Jsb2NrZXIoKSBmYWlsZWQuDQo+Pg0KPg0KPkl0IHdhc24ndCBpbW1lZGlhdGVs
eSBvYnZpb3VzIGZyb20gY29tbWl0IG1lc3NhZ2UgdGhhdCB0aGlzIGlzIG1haW5seSBhYm91dA0K
Pmp1c3QgcHJpbnRpbmcgYW4gZXJyb3IgbWVzc2FnZSB3aGVuIGJsb2NrZXJzIGdldCBhZGRlZCBh
bmQgdGhhdCB3ZWxsDQo+bWlncmF0ZV9hZGRfYmxvY2tlcigpIHJldHVybnMgMCBvbiBzdWNjZXNz
IGFuZCBjYWxsZXIgb2YNCj52ZmlvX21pZ3JhdGlvbl9yZWFsaXplIGV4cGVjdHMgdGhlIG9wcG9z
aXRlIHdoZW4gYmxvY2tlcnMgYXJlIGFkZGVkLg0KPg0KPlBlcmhhcHMgYmV0dGVyIHdvcmRpbmcg
d291bGQgYmU6DQo+DQo+bWlncmF0ZV9hZGRfYmxvY2tlcigpIHJldHVybnMgMCB3aGVuIHN1Y2Nl
c3NmdWxseSBhZGRpbmcgdGhlIG1pZ3JhdGlvbg0KPmJsb2NrZXIuIEhvd2V2ZXIsIHRoZSBjYWxs
ZXIgb2YgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIGNvbnNpZGVycyB0aGF0DQo+bWlncmF0aW9u
IHdhcyBibG9ja2VkIHdoZW4gdGhlIGxhdHRlciByZXR1cm5lZCBhbiBlcnJvci4gRml4IGl0IGJ5
IG5lZ2F0aW5nIHRoZQ0KPnJldHVybiB2YWx1ZSBvYnRhaW5lZCBieSBtaWdyYXRlX2FkZF9ibG9j
a2VyKCkuIFdoYXQgbWF0dGVycyBmb3IgbWlncmF0aW9uDQo+aXMgdGhhdCB0aGUgYmxvY2tlciBp
cyBhZGRlZCBpbiBjb3JlIG1pZ3JhdGlvbiwgc28gdGhpcyBjbGVhbnMgdXAgdXNhYmlsaXR5IHN1
Y2gNCj50aGF0IHVzZXIgc2VlcyAiTWlncmF0ZSBkaXNhYmxlZCIgd2hlbiBhbnkgb2YgdGhlIHZm
aW8gbWlncmF0aW9uIGJsb2NrZXJzIGFyZQ0KPmFjdGl2ZS4NCg0KR3JlYXQsIEknbGwgdXNlIHlv
dXIgd29yZHMuDQoNCj4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICBody92ZmlvL2NvbW1vbi5jICAgIHwgNCAr
Ky0tDQo+PiAgaHcvdmZpby9taWdyYXRpb24uYyB8IDYgKysrLS0tDQo+PiAgMiBmaWxlcyBjaGFu
Z2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vY29tbW9uLmMgYi9ody92ZmlvL2NvbW1vbi5jIGluZGV4DQo+PiBmYThmZDk0OWIx
Y2YuLjg1MDUzODU3OThmMyAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4+ICsr
KyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4+IEBAIC0zOTksNyArMzk5LDcgQEAgaW50IHZmaW9fYmxv
Y2tfbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb24oRXJyb3INCj4qKmVycnApDQo+PiAgICAgICAg
ICBtdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlvbl9ibG9ja2VyID0gTlVMTDsNCj4+ICAgICAgfQ0K
Pj4NCj4+IC0gICAgcmV0dXJuIHJldDsNCj4+ICsgICAgcmV0dXJuICFyZXQ7DQo+PiAgfQ0KPj4N
Cj4+ICB2b2lkIHZmaW9fdW5ibG9ja19tdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlvbih2b2lkKQ0K
Pj4gQEAgLTQ0NCw3ICs0NDQsNyBAQCBpbnQgdmZpb19ibG9ja19naW9tbXVfbWlncmF0aW9uKEVy
cm9yICoqZXJycCkNCj4+ICAgICAgICAgIGdpb21tdV9taWdyYXRpb25fYmxvY2tlciA9IE5VTEw7
DQo+PiAgICAgIH0NCj4+DQo+PiAtICAgIHJldHVybiByZXQ7DQo+PiArICAgIHJldHVybiAhcmV0
Ow0KPj4gIH0NCj4+DQo+PiAgdm9pZCB2ZmlvX21pZ3JhdGlvbl9maW5hbGl6ZSh2b2lkKQ0KPj4g
ZGlmZiAtLWdpdCBhL2h3L3ZmaW8vbWlncmF0aW9uLmMgYi9ody92ZmlvL21pZ3JhdGlvbi5jIGlu
ZGV4DQo+PiA2YjU4ZGRkYjg4NTkuLjAxNDY1MjFkMTI5YSAxMDA2NDQNCj4+IC0tLSBhL2h3L3Zm
aW8vbWlncmF0aW9uLmMNCj4+ICsrKyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+IEBAIC02NDYs
MTIgKzY0NiwxMiBAQCBpbnQgdmZpb19taWdyYXRpb25fcmVhbGl6ZShWRklPRGV2aWNlICp2YmFz
ZWRldiwNCj5FcnJvciAqKmVycnApDQo+PiAgICAgIH0NCj4+DQo+PiAgICAgIHJldCA9IHZmaW9f
YmxvY2tfbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb24oZXJycCk7DQo+PiAtICAgIGlmIChyZXQp
IHsNCj4+ICsgICAgaWYgKHJldCB8fCAoZXJycCAmJiAqZXJycCkpIHsNCj4NCj5XaHkgZG8geW91
IG5lZWQgdGhpcyBleHRyYSBjbGF1c2U/DQoNCk5vdyB0aGF0IGVycm9yIGhhcHBlbnMsIG5vIG5l
ZWQgdG8gYWRkIG90aGVyIGJsb2NrZXJzIHdoaWNoIHdpbGwgZmFpbCBmb3INCnNhbWUgcmVhc29u
Lg0KDQo+DQo+PiAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICB9DQo+Pg0KPj4gICAgICBy
ZXQgPSB2ZmlvX2Jsb2NrX2dpb21tdV9taWdyYXRpb24oZXJycCk7DQo+PiAtICAgIGlmIChyZXQp
IHsNCj4+ICsgICAgaWYgKHJldCB8fCAoZXJycCAmJiAqZXJycCkpIHsNCj4NCj5TYW1lIGhlcmU/
DQoNClRvIGF2b2lkIGNhbGxpbmcgaW50byB0cmFjZV92ZmlvX21pZ3JhdGlvbl9wcm9iZSgpIHdo
aWNoIGhpbnRzIHZmaW8gbWlncmF0aW9uIHJlYWxpemUgc3VjY2VlZC4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg0KPg0KPj4gICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICAgICAgfQ0KPj4NCj4+IEBA
IC02NjcsNyArNjY3LDcgQEAgYWRkX2Jsb2NrZXI6DQo+PiAgICAgICAgICBlcnJvcl9mcmVlKHZi
YXNlZGV2LT5taWdyYXRpb25fYmxvY2tlcik7DQo+PiAgICAgICAgICB2YmFzZWRldi0+bWlncmF0
aW9uX2Jsb2NrZXIgPSBOVUxMOw0KPj4gICAgICB9DQo+PiAtICAgIHJldHVybiByZXQ7DQo+PiAr
ICAgIHJldHVybiAhcmV0Ow0KPj4gIH0NCj4+DQo+PiAgdm9pZCB2ZmlvX21pZ3JhdGlvbl9leGl0
KFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0K

