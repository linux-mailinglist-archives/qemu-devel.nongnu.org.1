Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846A7378A1
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 03:18:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBmT4-00077e-ID; Tue, 20 Jun 2023 21:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBmSy-00077F-47
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:17:00 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBmSu-0008Ms-Pf
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 21:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687310216; x=1718846216;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=RM9bj1q/cgwXpd5tFU+0I66vvTT1fnZ4C/mtW2ECi8U=;
 b=CkdtwKUXbv5gkOLPaO2ePraym93xph2te7LPE/D6F9vyykMxOncGLl2g
 gA4KXjBC5aqE7nD+63D9PjJXbxy5MaS4g6ZZFLTI9y/EvtCpJM5X6vXjW
 KBUHJ8ppDvC+6Uh/CNPkvjILHWyXjfHpPyPHIz8xIh++/vlOK7TTP4H6z
 B9DjZ3ot+IlylZZ31F9wMsMt6LDq8HIQopE7znzY0N2sqgarauCSI/t3D
 ZxjnzatYyu6OUofglFXeJgUB590Z4S/KTl1kBJX09iO5Mgw5bO5Ne6r9U
 /hIqUNL7unT5AW6P3KBowEZN+YGFIn806rexwSjH7FMU6/we84bXcmSte Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389415763"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="389415763"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2023 18:16:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="827229513"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; d="scan'208";a="827229513"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga002.fm.intel.com with ESMTP; 20 Jun 2023 18:16:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 18:16:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 18:16:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 18:16:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obuj13dCVkiuFnjG6GHfQc98nA45efjLvbYhSP97riK1ZP6IGPKwxPp2ZDLHZOX2MNjhe5Z83IGa6tK4fkfzo9i3ErEiPoPJj9rNCgIIZl6JMQxIg/pq9B3oqfj0tzlYISVI4lEKj63//hqKu0DO7piq3Y0UgHI2LQJN+B+7S5rNt3zo/LC2S0L++2Mv2KfXq99EqQNnhY+awRjliYEia5eHtw+5h+4Pa1QyaFsMxWeKQDCnM2kYS2aJVuqvw4AlpqHt62xlE0oryH2U3PDuEBoDrQzDXRsmtvpH0jjfa8OF6kSciJ8AkD1CPARZAE1rj9mhwpOV3XSDq39MUclQqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RM9bj1q/cgwXpd5tFU+0I66vvTT1fnZ4C/mtW2ECi8U=;
 b=Jlxk77Zh5TQ4XljSNuaSzBDxcowQLrBYMXaBezXLle0/FSl4wB+hL/EWUn1kt04HdVYso0RytQPb1viuKXaaYF9QlZSE+XBhHh+4s1gWjwhSVRILpU9kWu6cN2rzc2FmqkCGZbj6dZovmq7rytVXS05iaHbCmefI6s7HJkfvuZ5R7en6/EhKuveXZHSgK7SgBlHYBVWt611XB36vSukbzALa8kT034/Cwj7rKSppPkUpUTmBnpJF/Pnj92wZhDofopJfpVa334anzdEO4Wr3pFVfk9gi9/8DZHYGv7AHlEOUUVqCEA42dgS+VdrSnlF8/CNU3FL+DfYwSGn0aw78Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Wed, 21 Jun
 2023 01:16:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 01:16:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, Avihai Horon
 <avihaih@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Thread-Topic: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Thread-Index: AQHZoowecKaj4XAnBEKc7Un5J/J7Ha+R+RWAgAEJD5CAAFm6gIAABcXggAAMZYCAAQhVoA==
Date: Wed, 21 Jun 2023 01:16:43 +0000
Message-ID: <SJ0PR11MB67442101A9A0798B0C45EAAF925DA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230619084446.399059-1-zhenzhong.duan@intel.com>
 <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
 <SJ0PR11MB67443F8A4A7AF037379355C5925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <a49cbb60-d2ac-6329-806a-260d602d3056@oracle.com>
 <SJ0PR11MB674447BF091C1EF4789B726B925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <bbe7b49f-41a8-9587-407e-2cac149fbff7@oracle.com>
In-Reply-To: <bbe7b49f-41a8-9587-407e-2cac149fbff7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6554:EE_
x-ms-office365-filtering-correlation-id: f36093f2-5edc-47dd-56ac-08db71f52d02
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hNE6OnFTmU2iWMowpAISh0H+9OggG+47HRlRgltboSv3ZmeRpslYoD4YwV6MqSuQ2s2Q5j6+4Wy8xqNIlpOiG7+9z+TIeohd8TpMEDT0qZoVRmhGUB5V7NwVrgZBgR7IFYQV2I4cZtL+Tz4u8saD4J539mKA/WC2GkzOOwlfCDckr1tVbKdNk9Xqk2hRu0rwgEgfDFvh2ZZRoWOjgvY3Tl75YBLxPvUyNBeaVmQRBL5UzYFsddGKPNfF/r+bl3AnHEIE8YSkqNKF+m0oHuHCwlIJknW03BGnmcfqMjzpNYtceUBfJj5mY8e/BBypUzhIKBiXgGhyn6ogLUVdanIQ8y7VbRMUIZ1wZCJlqTXv8WxT3Oynl8CeTwTmlSg/riFGaK6w0E1w9U8P7pRhrwIB3iFRUFYH/8f/wYcz87j1itnNx7AC7S2mrn361+yVBiA+sVKfYLXx8MMSTW90BOwcPLY8T/lN+HU26T6Xvr3vI/AKdC2RtphZy2iL2EHcPP2MjM+rlfCl4d7eqIZMVLVjYOLZ7yG9K2d4LAD0WBBctnl04rpx0EIe5VqtaCR3CKFGd4sbSEuZHM4I6Y0ab0AuK6VyKO931cLjwgwqalSdhid3qIMvGMo5SSR62sQqNUMF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(52536014)(5660300002)(2906002)(55016003)(8676002)(8936002)(83380400001)(66476007)(38070700005)(86362001)(33656002)(122000001)(38100700002)(82960400001)(64756008)(7696005)(66946007)(66446008)(71200400001)(4326008)(478600001)(66556008)(110136005)(54906003)(41300700001)(186003)(9686003)(26005)(316002)(76116006)(107886003)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VllId0Rnak9xVjhvMGorMUkrQnNGSHpwbkNNT0d4cFd1S2JJRzhLeE42WFFi?=
 =?utf-8?B?UGVZMithYTg4VkhjSVFIL28zZ2k5bzVkK0VCbFo3ek9Rek1MRU9qcE1EU1lw?=
 =?utf-8?B?WmFUTUxETU81a2N2cGlTOTNiTW5vK01GUDJjRlJ2KzhnOCtld0FEM0xZbVAv?=
 =?utf-8?B?QkI0a1dQRGFNS1FwR0dnbDU3aDUwOGRPcXJ6Sm8vMkNLQnNZNGFGRXhXMzBG?=
 =?utf-8?B?RjY3VlpEZ1k1UjQ5QXlGQkI5Z0p3WG9zTXlOSHlSay9jNDZWbVNRMENtckt4?=
 =?utf-8?B?ZU83dzdOWjZtRUJsNk9MMXk3VkJlUnhCNVBreWRuQnBnNGdBZml2S2lvZDd5?=
 =?utf-8?B?T2VQT1c1bm5sdk5xMk5MVjNUbk9tbGdpL2FvNHQ4dDlMNUNWS1c1VHZaVmtJ?=
 =?utf-8?B?N056Q0lEaTQ3cFRjbDUxOWdsajZRdDRkU1VuMHZQejJrcXV4V2RFUWlDLzVI?=
 =?utf-8?B?U3dVY1d1RkJRb0pRZkNZM0I2WEI3RWVjY2dOZEg2YjA3Y25ka1hBcldBc0oy?=
 =?utf-8?B?NWM2ZHFOekQ3U1gzdm4rREJJMW84d3hVQk9LS25DYUg0S0ZrUkFJK2lCc0Jr?=
 =?utf-8?B?a0lxYm5mclFlbHgveFBTeFcraVl1bkVRa2haOFltbThES0ZWVE5ST2gvZjhX?=
 =?utf-8?B?SHhFZTlnaXg4RHRkZjdoencxZkVyWjk1QXdxcEV2Q1g3VmFOU1ZENG80WHNS?=
 =?utf-8?B?YjRQa1BkaVdDb0dFdXZMY0NiNURtZzZVeVYxNWNtOGdSa2U1TWEyTjNwbXdL?=
 =?utf-8?B?SHJ5SDg2UXV4cHBCYTM4eDlTdm00d1Z3NExnN3ViMDkwM1Fka0VyRlNaS2RN?=
 =?utf-8?B?QmxXciswcG96NGVCVDhBeHRsRnNHUHEvUVVFTWNiNytoY2g5SDdzaUJ1eGNU?=
 =?utf-8?B?ZGtJd2pJSDBnMDZlSHdHV0N6REllcjl4M2w5ZlNiT0FJLzVOa1hHaFFLOER5?=
 =?utf-8?B?YUU2dmhjTGNZbTNPM0hiVCtwNWpNREZhOVIvdGlSbGZqZXJTYkZOcncxSHNz?=
 =?utf-8?B?L2pTNUtTcWdQMnNYelB6d2Jmck83LzdmUEh0ajZMRzY3bHFLWTQ0ZnEyYlVS?=
 =?utf-8?B?QTljTHRRWk4yT2VwUWUvYkcxdEVtZU9OdmV6d3RRVmc4YXN1SjkydFlEMnNL?=
 =?utf-8?B?NnBFMUNnaHhaMUFNT2NPRjMyWTFrMXlRMWZaVDllclBDRnJmVlg3MVJRMUJO?=
 =?utf-8?B?TVk2NWF3SWRBSlhVa1NpZFdJQzZ6bHhJL0tsWVRHNVhuZzVCMEQ1TkZ2UmpY?=
 =?utf-8?B?VytKR0w1R1ZLdTJkMm5kZ0EyUHI3amYwMCtLc2pNeFl6YzhPenVQekVSamF2?=
 =?utf-8?B?NS96amNpYklYMGJzTU0xaVJtT1BnWTlFMWxaYVZ5dXVDNHlpcEZTTmlUYStj?=
 =?utf-8?B?c1I1YUh1U0VUc3NEa2R5cVp0RTBhRHQra3NjZTh4ZFlERVpCaER0ZW5MaWY1?=
 =?utf-8?B?TjJXZC9lT1RhdVB1eGNFUElsYWNOQ2NnOWdVd1ZqTDY3MFF6QlF4bUlBZzBh?=
 =?utf-8?B?UFRHQ21PNlY4b0NEakQxdjY3ZFl3aVpucmZvVDM5RC9UNzhVVllOYnRGMExt?=
 =?utf-8?B?a0MwWE03MmRSblZRU0FBbHlaOElmdGsySE1nUEp1ZXBSbnl4MTdXOC8rRE1n?=
 =?utf-8?B?UThVelFab000TWFTaGNTeC9UbUs4L05BL1hpZE5lcFBYdHVzQmc5TXNQQkh0?=
 =?utf-8?B?RlUvTU5VdmpzeXdxRUNuQmJyeHp0Z28zZ1l5ek4va0VWS0Fxdmg2OVNyVnZ3?=
 =?utf-8?B?L0xyZzZpMUtOZEhkcFpnNzZPdURQako2RUR5SGNqT01kQk16bTFuTXlLYyt5?=
 =?utf-8?B?Y2FaRXJpcmVmNWdnL0FwellCeWVPdmJ6NFRWL0o5WGZTOHRRcFpSQysrVHdO?=
 =?utf-8?B?VDdhVlM5TStBN2JTMjc4SlFrYWRQYmgvNVAxcTZ0dURqTWd4QUtaM29WdXVX?=
 =?utf-8?B?UEdyS3JVbDBjVkhKR0ZVa2o4blJLZFYyQUtWWE80TGloTzZxczlXd2hkbTE3?=
 =?utf-8?B?S1RucU5UcXhadktVMlNVQVdNZTFOMHlsclBnckNEWWNGWmNKamF0bVpuL2Mr?=
 =?utf-8?B?enNZNkR0elBHbnZkejRUa3dBUlhyeXRYcmhqWURJNnQ2TzZGZG9KbzNVSTVk?=
 =?utf-8?Q?v8YGhxu76JbymkPJrbE6k3rxe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36093f2-5edc-47dd-56ac-08db71f52d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 01:16:43.8878 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGQBuIGOKK5QC9mQs0mfhQVnryfH3qnb5B0/ak64seY/Ov4jQFp2A0op1rViXXAtE5YwIa0k/uANcctCgh3aAn2WvHXH4YVqwdvdwQhx52U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBKdW5lIDIwLCAyMDIzIDU6
MjggUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBB
dmloYWkgSG9yb24NCj48YXZpaGFpaEBudmlkaWEuY29tPjsgcWVtdS1kZXZlbEBub25nbnUub3Jn
DQo+Q2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgUGVuZywg
Q2hhbyBQDQo+PGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYy
XSB2ZmlvL21pZ3JhdGlvbjogUmVmYWN0b3IgYW5kIGZpeCBwcmludCBvZiAiTWlncmF0aW9uDQo+
ZGlzYWJsZWQiDQo+DQo+T24gMjAvMDYvMjAyMyAwOTo1NSwgRHVhbiwgWmhlbnpob25nIHdyb3Rl
Og0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogSm9hbyBNYXJ0aW5z
IDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4+IFNlbnQ6IFR1ZXNkYXksIEp1bmUgMjAs
IDIwMjMgNDoyMyBQTQ0KPj4+IFRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT47IEF2aWhhaSBIb3Jvbg0KPj4+IDxhdmloYWloQG52aWRpYS5jb20+OyBxZW11LWRl
dmVsQG5vbmdudS5vcmcNCj4+PiBDYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNsZ0By
ZWRoYXQuY29tOyBQZW5nLCBDaGFvIFANCj4+PiA8Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIHZmaW8vbWlncmF0aW9uOiBSZWZhY3RvciBhbmQgZml4
IHByaW50IG9mDQo+Pj4gIk1pZ3JhdGlvbiBkaXNhYmxlZCINCj4+Pg0KPj4+IE9uIDIwLzA2LzIw
MjMgMDQ6MDQsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+Pj4+PiBGcm9tOiBBdmloYWkgSG9yb24gPGF2aWhhaWhAbnZpZGlhLmNvbT4N
Cj4+Pj4+IFNlbnQ6IE1vbmRheSwgSnVuZSAxOSwgMjAyMyA3OjE0IFBNDQo+Pj4+IC4uLg0KPj4+
Pj4+IGEvaHcvdmZpby9taWdyYXRpb24uYyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMgaW5kZXgNCj4+
Pj4+PiA2YjU4ZGRkYjg4NTkuLmJjNTFhYTc2NWNiOCAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9ody92
ZmlvL21pZ3JhdGlvbi5jDQo+Pj4+Pj4gKysrIGIvaHcvdmZpby9taWdyYXRpb24uYw0KPj4+Pj4+
IEBAIC02MzIsNDIgKzYzMiw0MSBAQCBpbnQ2NF90IHZmaW9fbWlnX2J5dGVzX3RyYW5zZmVycmVk
KHZvaWQpDQo+Pj4+Pj4gICAgICAgcmV0dXJuIGJ5dGVzX3RyYW5zZmVycmVkOw0KPj4+Pj4+ICAg
fQ0KPj4+Pj4+DQo+Pj4+Pj4gLWludCB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKFZGSU9EZXZpY2Ug
KnZiYXNlZGV2LCBFcnJvciAqKmVycnApDQo+Pj4+Pj4gK2Jvb2wgdmZpb19taWdyYXRpb25fcmVh
bGl6ZShWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4+Pj4+ICAgew0KPj4+
Pj4+IC0gICAgaW50IHJldCA9IC1FTk9UU1VQOw0KPj4+Pj4+ICsgICAgaW50IHJldDsNCj4+Pj4+
Pg0KPj4+Pj4+IC0gICAgaWYgKCF2YmFzZWRldi0+ZW5hYmxlX21pZ3JhdGlvbikgew0KPj4+Pj4+
ICsgICAgaWYgKCF2YmFzZWRldi0+ZW5hYmxlX21pZ3JhdGlvbiB8fCB2ZmlvX21pZ3JhdGlvbl9p
bml0KHZiYXNlZGV2KSkgew0KPj4+Pj4+ICsgICAgICAgIGVycm9yX3NldGcoJnZiYXNlZGV2LT5t
aWdyYXRpb25fYmxvY2tlciwNCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICJWRklPIGRldmlj
ZSBkb2Vzbid0IHN1cHBvcnQgbWlncmF0aW9uIik7DQo+Pj4+Pj4gICAgICAgICAgIGdvdG8gYWRk
X2Jsb2NrZXI7DQo+Pj4+Pj4gICAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gLSAgICByZXQgPSB2Zmlv
X21pZ3JhdGlvbl9pbml0KHZiYXNlZGV2KTsNCj4+Pj4+PiAtICAgIGlmIChyZXQpIHsNCj4+Pj4+
PiArICAgIGlmICh2ZmlvX2Jsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKGVycnApKSB7
DQo+Pj4+Pj4gKyAgICAgICAgZXJyb3Jfc2V0ZygmdmJhc2VkZXYtPm1pZ3JhdGlvbl9ibG9ja2Vy
LA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgIk1pZ3JhdGlvbiBpcyBjdXJyZW50bHkgbm90
IHN1cHBvcnRlZCB3aXRoIG11bHRpcGxlICINCj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICJW
RklPIGRldmljZXMiKTsNCj4+Pj4+PiAgICAgICAgICAgZ290byBhZGRfYmxvY2tlcjsNCj4+Pj4+
PiAgICAgICB9DQo+Pj4+Pg0KPj4+Pj4gSGVyZSB5b3UgYXJlIHR5aW5nIHRoZSBtdWx0aXBsZSBk
ZXZpY2VzIGJsb2NrZXIgdG8gYSBzcGVjaWZpYyBkZXZpY2UuDQo+Pj4+PiBUaGlzIGNvdWxkIGJl
IHByb2JsZW1hdGljOg0KPj4+Pj4gSWYgeW91IGFkZCB2ZmlvIGRldmljZSAjMSBhbmQgdGhlbiBk
ZXZpY2UgIzIgdGhlbiB0aGUgYmxvY2tlciB3aWxsDQo+Pj4+PiBiZSBhZGRlZCB0byBkZXZpY2Ug
IzIuIElmIHlvdSB0aGVuIHJlbW92ZSBkZXZpY2UgIzEsIG1pZ3JhdGlvbiB3aWxsDQo+Pj4+PiBz
dGlsbCBiZSBibG9ja2VkIGFsdGhvdWdoIGl0IHNob3VsZG4ndC4NCj4+Pj4+DQo+Pj4+PiBJIHRo
aW5rIHdlIHNob3VsZCBrZWVwIGl0IGFzIGEgZ2xvYmFsIGJsb2NrZXIgYW5kIG5vdCBhIHBlci1k
ZXZpY2UgYmxvY2tlci4NCj4+Pj4NCj4+Pj4gVGhhbmtzIGZvciBwb2ludCBvdXQsIHlvdSBhcmUg
cmlnaHQsIHNlZW1zIEkgbmVlZCB0byByZXN0b3JlIHRoZQ0KPj4+PiBtdWx0aXBsZQ0KPj4+IGRl
dmljZXMgcGFydCBjb2RlLg0KPj4+DQo+Pj4gSXQncyB0aGUgc2FtZSBmb3IgdklPTU1VIG1pZ3Jh
dGlvbiBibG9ja2VyLiBZb3UgY291bGQgaGF2ZSBhIG1hY2hpbmUNCj4+PiB3aXRoIGRlZmF1bHRf
YnVzX2J5cGFzc19pb21tdT1vbiBhbmQgYWRkIGRldmljZSAjMSB3aXRoDQo+Pj4gYnlwYXNzX2lv
bW11PW9mZiBhdHRyaWJ1dGUgaW4gcHhiIFBDSSBwb3J0LCBhbmQgdGhlbiBhZGQgZGV2aWNlICMy
DQo+Pj4gd2l0aCBieXBhc3NfaW9tbXU9b24uIFRoZSBibG9ja2VyIGlzIGFkZGVkIGJlY2F1c2Ug
b2YgZGV2aWNlICMxIGJ1dA0KPj4+IHRoZW4gaXQgd2lsbCByZW1haW4gYmxvY2tlZCBpZiB5b3Ug
cmVtb3ZlIGl0Lg0KPj4NCj4+IFJpZ2h0LCB0aGFua3MgZm9yIHBvaW50IG91dCwgSSdtIHRoaW5r
aW5nIGFib3V0IGNoYW5naW5nDQo+PiB2ZmlvX3Zpb21tdV9wcmVzZXQoKSB0byBjaGVjayBjb3Jy
ZXNwb25kaW5nIGRldmljZSdzIGFkZHJlc3Mgc3BhY2UgcmF0aGVyDQo+dGhhbiBhbGwgdmZpbyBk
ZXZpY2VzJy4NCj4+DQo+PiBMZXQgbWUga25vdyBpZiB5b3UgcHJlZmVyIHRvIHJlc3RvcmUgdklP
TU1VIGJsb2NrZXIgYXMgZ2xvYmFsIHRvbywNCj4+IHRoZW4gSSdsbCBub3QgdHJ5IHdpdGggbXkg
aWRlYSBmdXJ0aGVybHkuDQo+DQo+VGhlIHZJT01NVSBtaWdyYXRpb24gYmxvY2tlciBkb2Vzbid0
IG5lZWQgdG8gYmUgZ2xvYmFsLCB0cnVlLCBhcyBpdCBkb2Vzbid0DQo+Y2FyZSBhYm91dCBvdGhl
cnMgYWRkcmVzcyBzcGFjZSAtLSBpZiBlYWNoIGRldmljZSBoYXMgYSBibG9ja2VyIGFzIGxvbmcg
YXMgdGhlDQo+b25lIGRldmljZSBibG9ja2VyIGlzIHJlbW92ZWQgaXQgc2hvdWxkIGJlY29tZSBt
YWtlIFZNIG1pZ3JhdGFibGUgYWdhaW4NCj4oYnV0IGF0bSB3ZSB3aWxsIGJlIGJsb2NrZWQgYnkg
dGhlIG11bHRpIGRldmljZSBibG9ja2VyIGFueXdheSkuIFRoaXMgc2hvdWxkDQo+Y29uc29saWRh
dGUgdGhpbmdzIGludG8gYSBzaW5nbGUgbWlncmF0aW9uIGJsb2NrZXIgYW5kIGF2b2lkIHRoZSBz
cGVjaWFsIHBhdGguIEkNCj5hbSBub3QgZW50ZXJpbHkgc3VyZSBpZiB0aGUgcmVmYWN0b3Igd2ls
bCBnaXZlICp0aGF0KiBtdWNoIGdhaW4gYnV0IHRoYXQncw0KPnByb2JhYmx5IGJlY2F1c2UgSSBo
YXZlbid0IHNlZW4gdGhlIGZpbmFsIHJlc3VsdC4NCg0KT0ssIGxldCBtZSB3cml0ZSBvbmUgZm9y
IGRpc2N1c3MsIGhhdmluZyBwZXIgZGV2aWNlIHZJT01NVSBibG9ja2VyLCBnbG9iYWwgbXVsdGlw
bGUgZGV2aWNlcyBibG9ja2VyLCBldGMuDQo+DQo+SUlVQyB0aGUgcHJvYmxlbSB3aXRoIHRoaXMg
cGF0Y2ggaXMgdGhhdCB5b3UgcmVtb3ZlIHdoYXQgdW5ibG9ja3MgdGhlDQo+bWlncmF0aW9uLCBh
bmQgSSBndWVzcyB0aGF0IG5lZWQgdG8gc3RheSB0aGVyZSBmb3IgdGhlIGdsb2JhbCBjYXNlLg0K
WWVzLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

