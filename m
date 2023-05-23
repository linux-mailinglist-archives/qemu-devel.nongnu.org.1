Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B63E70DF4D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1T3X-00057P-F7; Tue, 23 May 2023 10:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1T3V-00057H-6d
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:32:05 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q1T3O-00057N-BZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 10:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684852318; x=1716388318;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=b7F1g22+/pRgw0cgmHmazFzYpBG3VfrPnu1aUFlwUV4=;
 b=aHhEPoLzw4+96sWk0ohbGbAph8jDV0HFTM7OfvaYfpD2yX7XCuuzg841
 HIKBUJz1PerDNzZ5hEqGSV6UkbNNlUDNZLvd1dKD0DMxR9xhpC/57O5Hr
 xlrTH+SexhNnvkL0bmjWk1g2li75VL6Zwb8APTWlwpHyzVWhkYwfPWuxc
 m7Cp/5Duf408ppt1shh/DkAS1q71ZErx9bP7cmWkzklDblc5nOYCDAc6Q
 NYDm3bSOhrUuJh/M1azQaoruV7+UaU3JWuseYWe8slW8eHEBF/azpb6Li
 dFHx4vRxyuan0fJf+Vr7qAWW0rkyTivQolgxZSaznw1DU5mA2yheLQX81 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="350762422"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; d="scan'208";a="350762422"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 07:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="950558105"
X-IronPort-AV: E=Sophos;i="6.00,186,1681196400"; d="scan'208";a="950558105"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga006.fm.intel.com with ESMTP; 23 May 2023 07:30:28 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:30:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 23 May 2023 07:30:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 23 May 2023 07:30:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 23 May 2023 07:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gdxhzTWz8/blTltdwCjvrIxqLqDMxVrnrnII1ZZupNlYbmnHVb6yW8TAVTFUNn11klrKKKg7vtUT0fm+OF4nNux3LSXz+29cK5T2poXYBWbnQInc8kdDPKNXhM0EoiBvoorlvWg1xeLGM9/6Gc32v4pJq06Lmi5TjzUwVyYA7UJRReItfMAmTbAFIE3zZTfZYgqpilH/DtJHqvhnavtn97wD3waCoLuykyuPhpMTr+KABV/jEsWeHWtNYLnIRYQVKX65VPrLRqjmEE9CC2nD78RYyyqxRsikFKRaOnRPfazdvgA2EKjIfi4LFkRKH7yl80qRlomzWMfxMDSucAkqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7F1g22+/pRgw0cgmHmazFzYpBG3VfrPnu1aUFlwUV4=;
 b=MDPjgi/f/43y/HSBdB/fsswcKAReFMTlviLl+8FqGuV56EB2jJTdIzyQqp7z2oOwDc8ahIgU8Xl2EiLFaAAExTyMQjbK0IkfLd1EfObKB90KkEsch9dpRuKcs4YvfDygwaG9CMIyPhR1udiwTH1S2Zl7UaQC17ftQWQtNYhR4VcjtAL8/YMgqVC0UGh5TJHiybZRXCqOjD9SMPmrYHNWZnD5prXxjKam5xCvleWrJsNJWJQNx2MZws8fXKVIwEY69zVY9BamqOqMlMVdwENmMWQq8s5h14QqEVaCBvosoZxkGUzOEzGDJ80tdkyjF97FJzyWbdFnozDl3tLyeRhvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MW3PR11MB4618.namprd11.prod.outlook.com (2603:10b6:303:5f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 14:30:25 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Tue, 23 May 2023
 14:30:25 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Topic: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Index: AQHZiaHrpdDskbcmfUmdUetnWYWQW69gaDgAgABj4tCAAO5TgIAAAOyAgACb1xCABKHrgIAAHRqAgADO5ACAAAiF8A==
Date: Tue, 23 May 2023 14:30:25 +0000
Message-ID: <DS0PR11MB637381609AFD7DA4998AB201DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
 <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGv8adigFYpLD89k@x1n>
 <DS0PR11MB63737B09D72A735EC21F3C41DC409@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGzCYMRWa7sW9xAv@x1n>
In-Reply-To: <ZGzCYMRWa7sW9xAv@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MW3PR11MB4618:EE_
x-ms-office365-filtering-correlation-id: 4106ee4c-4443-4272-d439-08db5b9a3fc3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F0Lr+HemMD9ziXsBQ9qEHZIlc7WCl4XQgU2gqmsBkX6UB5p0gdf7f7mI32G+DNQvMPVcxe3d1L7re9TBO/hy58IYROaC1avWB+wS/zc0G9zdcyHdJsnyS6JsMPPKj6ShgXGJHUcFD2BreuOpQbs1xLiGBhklOfbk/35MzorxsVmJSKZHVro2FsIjNo8RogTDZIl8WC7qTKQj5DIw+3cHTgyOshs121mgtdA7sKtd63C1z0pbSKcSO1q2vp82GrvzZhhFM/qJWJwb63i6MHC5euwY3f8VgA8GtDS8e6kvvB3Qr8X0dZRSkHN4wn5RTgvZZLCsZhwFKroKmsxxRxxFpun8C9w/npXtOLGvFcvWqwJyko7vnc9BJEf8vm+wF8Up6PnjiqFYWeRvjqOuAYVrHRRyqFlVgvklHftyMLq2czvpoklcnfF7FDrHxmzWQY79PJ+DUx+cxDVzsN5mjpafGWmpnD89dRy6/IelUFZqqNpMkPpqOgGrwgv7FiMxrf6ZhkMvd2fTkOkyqAO0EgAKSxjHyXFFVUlHUTALQ4jq9hzFbXHo4rDCM4lvrwusCfQzcj/DUBHtcLmYlv1nqigrV25VMp9VCvcGuOwzUhyjla9jIbwvOpHRSrfzqUb7eU504SPxNSyGCQZz15QqHoRXxA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(26005)(122000001)(186003)(53546011)(33656002)(9686003)(6506007)(82960400001)(38100700002)(83380400001)(2906002)(55016003)(41300700001)(7696005)(316002)(71200400001)(54906003)(478600001)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(6916009)(4326008)(38070700005)(86362001)(8936002)(8676002)(5660300002)(52536014)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDhlZy9HalFETDVUS0ljTjdOWTArK2dVaWtpQXZoMmM0OGNsdGVPZm9ySmxs?=
 =?utf-8?B?Ui9ZSHRwTTJjSjlxZUlRaGJjVWR2U0pxZ3FkamZoSGRKWWM1aTUwMFNKT25T?=
 =?utf-8?B?bGs2N1V4aTVBUlNRU1h4N1JodlAvcHpLVHMySUhZdk8wZjVmK1ZERWtqT3VO?=
 =?utf-8?B?SVV0bHRDa2pWalBXYzFVRVRIa2JxaDR1aVhhZTBKbEVFZzBrR1lNZGUyWHBs?=
 =?utf-8?B?NVlqeVovOHlBVU9hS2k0UGpRMDNzWFlWZ1NwM2JsdWg2bjlvQ3NNaHdpcHBs?=
 =?utf-8?B?ZUxSMktkckNsaDlpQWFldndUNmtEVUJzWFRJZk5nWkF2aVBldDQrSjFKVjdL?=
 =?utf-8?B?eVE5T1l6OW1VSFFpUC9uMXlpMTBOVGFic0V0K3h0bjVzclU1TW1HNVVkRHI5?=
 =?utf-8?B?MU84eEFacHkwV3poQ29mOHdyVjZmRm53dlkwTWpQM2JCK0kwcDVNR3ptc2gw?=
 =?utf-8?B?SlFtTHBrNXZEa01udTNqUnljV2o1QzVhaU5idTZqaWZzd3p3ak9JNERmVzdO?=
 =?utf-8?B?TU5VSERDazVmeFRDQUl6NElGWU9QSXo5NDYvVUtBRzZrQlJIZzhyMDhjajFw?=
 =?utf-8?B?WEtMZFI0WnByRWc5a21BZVlxMUpuWFBab2xSNmgvVElmVHBGQ1IyOE5WWXhZ?=
 =?utf-8?B?VjNLbjV1OWQycE5EcnltbjNqakxSZFBWUWVIa3ZCSzNBMXdRSjBFZm1sQlpl?=
 =?utf-8?B?RnJWempzdW90MGdUSDc5L0tpRzV0Tk5rc0RlZG52anVFbEFXbzRvTTJueTVy?=
 =?utf-8?B?OTlUY3NuYkl2Q0ZZMTJDN0FBNlBkQUU3eVRYVXZPQWVFZFFZc1JXWXhpMWph?=
 =?utf-8?B?dnpDWmphdzI2ckZGQ1FzL1VwazY0TERyYkZwcnJ6RXErRFZDK2dYMnBzakZx?=
 =?utf-8?B?WGRYQ3lGMFQ3UmlibCtnbUo1Rkd6VjJBcjdrcWtlTGkrYWVWZjZyTWVIRG5t?=
 =?utf-8?B?SFVHVzZEWnBkVk9qWXRDbjZNcC9mZjFTOXl6V1BsL0czQUdwRnUyMThOSGJj?=
 =?utf-8?B?dnZ6TnhJb2ZGdWh4WnhCbnp6MkhaUkc5UHloSjBidjJXSHVuTDhZMm9GZU1z?=
 =?utf-8?B?bXFabm83RXpPZjE4QVV5Q1FOSXcrODR0T2p4TkVXYUxNRzJWcDVqRDZGcVAz?=
 =?utf-8?B?WGpPbVcxakV1N3ArTFNjLzkzU1lHM3dnbm50Tk1ZWDNmdjBUMmtCR1hON0tO?=
 =?utf-8?B?M0hGRkRza0ppUmp5NCtkL1c4bVF5cHNPMFliUExOSTNjTVE2T2h2WHdJYjRq?=
 =?utf-8?B?L2pRbUlhSGMzWkJ0bHlHaVhyeFVpVEZ0ci9RQ1Q4bWJLTmVocW40akJZTDlG?=
 =?utf-8?B?MUEwUXNOWnlXNFh3a3NpY0JQWFpsQUVhd25tT3drVFEzSm1Vd0ZobUd6L1RH?=
 =?utf-8?B?K0IrSXBMVTBCNEFKQ09OVnkwdkluZkdSQ0prL2NGMFpBK21Tb0RjT3hLTzhk?=
 =?utf-8?B?RFIvSTcva215V1dSb2JtbUJ2QnB4SXdKZ05DRGdxdUE0WGI0aVJqcGxmemRL?=
 =?utf-8?B?MHJzeXlTSGNuVEcyNkpIN0N2VXd4RmFqdk5jcVc0SUdHbUFJR2ZnUXlSVlBX?=
 =?utf-8?B?RTZ0SGtRVHJ3Q0FEeTlRdTZDMEhHcFMrOUlBVWpRKzdaSmJVVUQ0NGMwK3F3?=
 =?utf-8?B?WjkwejVhbENlZThuMzhMdlUxb0FYcytiUVpMZTAvL1BVWHVVY0VLTUh3b0hN?=
 =?utf-8?B?UnNVUGVaUTFId0diMWVGSzd5ak5TbWVJNXBORXg0bnN5YXFQRXUrMHhDV2pY?=
 =?utf-8?B?b2ZNWnFwT2lxcnlZS05lemZ5M3gvTlN3dExDVUdMNmRhSUdGem5ER2srVmZm?=
 =?utf-8?B?OEZRdzZSamVUL1VDRk5GcFhjQ3ZmeHY2bjhLRW1qMzd6K0FNSmRoa0g5SUpt?=
 =?utf-8?B?MGdDcS9OZmNpWmdFUlpjbDNtZ0YxZ0NRekVRU29iRmR6ME5hMmo4MW1PWkpP?=
 =?utf-8?B?TTdiZitBNUdBWThlMGFCSjE0RFRuV3NwVVFvZU1BTzFLZC8wZ2R6bk5DMG1n?=
 =?utf-8?B?WDlIYVhVRkp6WC9rQ3ArVkNtaDlQYWdRTDR1VmlQZmpHSU5aSDVsQWI3MGlF?=
 =?utf-8?B?aElRVjlmZXNJY01qemdtSTB1L0ZoMU1aVmR3NnpqcVFyY05LSDVlN0tzUjRG?=
 =?utf-8?Q?LPSlpslYOSIpssHQkaeFX9QnY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4106ee4c-4443-4272-d439-08db5b9a3fc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 14:30:25.5791 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McVlwMpi5g4PUu48lNbXSM3efnQO6Yo33Y+N8XFPz5UCGhxmXUokTfFh0mLumQi5tngUfG4jlAUzjsmZxuNPRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4618
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93; envelope-from=wei.w.wang@intel.com;
 helo=mga11.intel.com
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

DQpPbiBUdWVzZGF5LCBNYXkgMjMsIDIwMjMgOTo0MSBQTSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9u
IFR1ZSwgTWF5IDIzLCAyMDIzIGF0IDAxOjQ0OjAzQU0gKzAwMDAsIFdhbmcsIFdlaSBXIHdyb3Rl
Og0KPiA+IE9uIFR1ZXNkYXksIE1heSAyMywgMjAyMyA3OjM2IEFNLCBQZXRlciBYdSB3cm90ZToN
Cj4gPiA+ID4gPiBXZSBtYXkgYWxzbyB3YW50IHRvIHRyYXAgdGhlIGNoYW5uZWwgc2V0dXBzIG9u
IG51bToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IG1pZ3JhdGVfcGFyYW1zX3Rlc3RfYXBwbHkoKToN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgICBpZiAocGFyYW1zLT5oYXNfbXVsdGlmZF9jaGFubmVs
cykgew0KPiA+ID4gPiA+ICAgICAgICAgZGVzdC0+bXVsdGlmZF9jaGFubmVscyA9IHBhcmFtcy0+
bXVsdGlmZF9jaGFubmVsczsNCj4gPiA+ID4gPiAgICAgfQ0KPiA+ID4gPg0KPiA+ID4gPiBEaWRu
4oCZdCBnZXQgdGhpcyBvbmUuIFdoYXQgZG8geW91IHdhbnQgdG8gYWRkIHRvIGFib3ZlPw0KPiA+
ID4NCj4gPiA+IEkgbWVhbnQgYWZ0ZXIgbGlzdGVuKCkgaXMgY2FsbGVkIHdpdGggYW4gZXhwbGlj
aXQgbnVtYmVyIGluIHRoaXMNCj4gPiA+IGNhc2UsIHNob3VsZCB3ZSBkaXNhbGxvdyBjaGFuZ2lu
ZyBvZiBtdWx0aWZkIG51bWJlciBvZiBjaGFubmVscz8NCj4gPg0KPiA+IEdvdCB5b3UsIHRoYW5r
cy4gVGhhdCBzZWVtcyB1bm5lY2Vzc2FyeSB0byBtZSwgYXMgdGhlIGNhcCBzZXR0aW5nIGlzDQo+
ID4gcmVxdWlyZWQgZm9yIHRoZSB1c2Ugb2YgbXVsdGlmZCBhbmQgcGF0Y2hpbmcgdGhlcmUgYWxy
ZWFkeSBhY2hpZXZlcyBiZWxvdw0KPiB3aGF0IHdlIHdhbnQ6DQo+ID4gLSB1c2VycyBnZXQgdGhl
IGVycm9yIG1lc3NhZ2Ugd2hlbiBkZWZlcnJlZCAtaW5jb21pbmcgaXNu4oCZdCB1c2VkOw0KPiA+
IC0gZmFpbCB0aGUgY2FwIHNldHRpbmcgZm9yIG11bHRpZmQsIG1lYW5pbmcgdGhhdCBtdWx0aWZk
IHdvbid0IGJlIHVzZWQgKGkuZS4NCj4gPiBubyBwbGFjZSB0aGF0IHdpbGwgY2FyZSBhYm91dCBt
dWx0aWZkX2NoYW5uZWxzKS4NCj4gDQo+IEl0J3MgYWJvdXQgd2hldGhlciB3ZSB3YW50IHRvIHBy
b3RlY3QgZS5nLiBiZWxvdyBzdGVwczoNCj4gDQo+IDEuIHN0YXJ0IGRlc3QgcWVtdSB3aXRoIC1p
bmNvbWluZyBkZWZlcg0KPiAyLiAibWlncmF0ZS1zZXQtY2FwYWJpbGl0aWVzIiB0byBlbmFibGUg
bXVsdGlmZCAzLiAibWlncmF0ZS1pbmNvbWluZyB4eHgiIHRvDQo+IHNldHVwIHRoZSBzb2NrZXRz
DQo+IDQuICJtaWdyYXRlLXNldC1wYXJhbWV0ZXJzIiB0byBzZXR1cCB0aGUgbnVtIG9mIG11bHRp
ZmQgICA8LS0tIHdpbGwgYmUgaW52YWxpZA0KPiBoZXJlDQoNClllcywgc3RlcCA0IGlzIGludmFs
aWQsIGJ1dCBJIHRoaW5rIG5vYm9keSBjYXJlcyBhYm91dCB0aGF0IChpLmUuIG5vIHBsYWNlIHVz
ZXMgdGhlDQppbnZhbGlkIHZhbHVlKSBhcyBzdGVwMiBhbHJlYWR5IGZhaWxzIHRoZSBjYXAgc2V0
dGluZyAod2l0aCBlcnJvciBtZXNzYWdlcykuDQoNCj4gDQo+IFdvdWxkIHRoYXQgc3RpbGwgYmUg
YSBwcm9ibGVtIHRoYXQgZmFsbHMgaW50byB0aGUgc2FtZSBjYXRlZ29yeSBvZiB3aGF0IHRoaXMN
Cj4gcGF0Y2ggd2FudHMgdG8gcHJvdGVjdCBxZW11IGZyb20/DQoNCk15IGludGVuc2lvbiB3YXMg
dG8gbm90aWNlIHRoZSB1c2VyIGV4cGxpY2l0bHkgdGhhdCB0aGUgZGVmZXJyZWQgLWluY29taW5n
IG11c3QNCmJlIHVzZWQgZm9yIG11bHRpZmQgKGlmIG5vdCB0aGUgY2FzZSwgc3RvcCB0aGUgdXNl
IG9mIG11bHRpZmQpLiBJIHRoaW5rIHRoZSBwYXRjaA0KYWxyZWFkeSBhY2hpZXZlcyB0aGlzLg0K
QWRkaW5nIHN1Y2ggY2hlY2sgdG8gbWlncmF0ZS1zZXQtcGFyYW1ldGVycyBkb2VzbuKAmXQgY2F1
c2UgcHJvYmxlbXMsDQpidXQgc2VlbXMgYSBiaXQgcmVkdW5kYW50IHRvIG1lLiBOb3Qgc3VyZSBp
ZiBvdGhlcnMgd291bGQgYWxzbyBoYXZlIHN0cm9uZw0KcHJlZmVyZW5jZXMgdG8gZG8gc28gZm9y
IGFueSByZWFzb24uDQoNClRoYW5rcywNCldlaQ0K

