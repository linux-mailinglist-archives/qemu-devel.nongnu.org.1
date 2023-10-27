Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3045D7D8E94
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 08:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwGA7-0002WF-Fv; Fri, 27 Oct 2023 02:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwGA3-0002V8-5x
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:17:35 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwG9y-0003Gk-Lj
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 02:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698387450; x=1729923450;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=XUYZNiVtXJ2ZDI+/LRhZyMZnHrCD9C9aadSrQwMKCYA=;
 b=E9mhmEnXEmbuHTkT95lBzBKNVJB4t3cZBjG1FogXcBmQvLU8w2CZh8Yf
 yG7E0b5uYxBrF4VzRugKBPy42ZStlct7eTdqnAKkvX2eJGEmNE8IUG728
 8vGCFFi59OVllD9Y/QYlQ3CYpT+r84s87v+/xiHEY0z1bLiZ5sZjBCl5L
 XkeGjnE75IJG08pZ6M+cGh+hy3UwkDM7pjy27HwplSyrXZcHVWicKivlz
 cm86rsTDhH5QFuY7ybO8/HOBq52KGBqlj2pO3gMpOhlNMliVADqqVNfif
 BH19+xSqAixJnatXM4bJhiyFYYOYD2uG1qFIasK1QSPGfMuYM4+rXHbh6 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="386604032"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="386604032"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2023 23:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="883097847"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="883097847"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Oct 2023 23:17:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 23:17:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 23:17:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 23:17:16 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 26 Oct 2023 23:17:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVse7cymnIEsCgh3hYu413F78lJ5aCkVIzDwiNTnqDcuAEZP/QZ4fpx/wTmwby5A31LJedpz6QMIipscyMqrllAMfDjE5d41JWDuErdCCsaoId16msUzyTDuya0gc4gluGGnpDU1xHusjvpOrjr4Vk2pZfBUO0SdbQ73T3BjNtd8MTL4BgsbdVmJvFT+WcSyOEdbsOVcdrzmjLNPO5vhhGsWG2eY5ixPJiU78RN4rNWkIi9hw5neYf/XyxKfxfDMnzymSSsaGSYyviJniLSqf0keRCOUAcyuZF85lVohx3AnXAz1NK63Qv9h1rFcTabsakwFXOs7mT1fwyC9DLr+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUYZNiVtXJ2ZDI+/LRhZyMZnHrCD9C9aadSrQwMKCYA=;
 b=gLOjwkeRwZD6Zv4/dqx3YnYauYQDaMmr0xv4WUWJZqsDEcBBTb17ez5mZnBWlXcc9JLzRsndO3yo9WKHuJ9eyTHhu3WnGLS7rh2dCz1QmuX/1chiFpsoxwAYvLTEAf4rbkiPGo7qLNZ0nR7/Sw53BXYhmTxrhP+B3E6Y0lXMJF0mpJF/G4Dx/XO3BKJ7sXr2wH6a4Onv3hKg9X3+jRA2XixdCjbax8jfLSnsC4fg3wUxWwDiAfSQ0uJz0bEBqf6NhMyv+srq291Wi34rKMW0fU/Etmw15k6sC+wN5WfbCVUn0cLWdoNKNUtpm79TBPxXKjsPR7f9tx3yC29frh6Wbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 06:17:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::bb35:72a8:1513:c13f]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::bb35:72a8:1513:c13f%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 06:17:10 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 00/37] vfio: Adopt iommufd
Thread-Topic: [PATCH v3 00/37] vfio: Adopt iommufd
Thread-Index: AQHaB/mk3OZfME1nkEqcJ7AgvbMva7BcEGj2gAEYzMA=
Date: Fri, 27 Oct 2023 06:17:10 +0000
Message-ID: <SJ0PR11MB67444B3A1BE0FAE6934ABAD592DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <87o7gla508.fsf@pond.sub.org>
In-Reply-To: <87o7gla508.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6201:EE_
x-ms-office365-filtering-correlation-id: da143596-af3c-454e-d101-08dbd6b45a95
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KAmfIsZqPtJQkXzpYjfGTgoo4XF9IJTjd5egzAgU/eZqNaE8rlomaCupv92z7dFB8Ea4KmBcz8K/9/eyMDDxJhNhYNZdAUh5GRnREL3US7e5o1BGtfhNDS7RtQ20UlzRZN6A/0zxJrZd80WdHzkbuuOGo/eHgHeuf4veOr/TkCr82Kvsw9euFW7QO+nE9VXeQpbfKJaQ+tb1KIxTLwWQ3GQENBlVlk8fp2HMq43A7jlmq4m5GnAsZyEN3dUV5ITqKE55BoByvxxUcyzK1NOQTa0aPF3jcUXsJlTvbAgDBOwV24WhocrKcL1Q1s4wOJfxuA4om9BKFXd03VRKMKnxsKSO1ifHcrT2MZ/wIKLbHLWRUUdopkofeVWbZXZARQ/+JnFlJ1EdIJtACf+KwgVlMKIJmJ6yf0hLM07/14DoYd9LuTGEg4wqyz1/ARxfFcsu1+PjW4WQLACdPGNyhOZnioChGx2tbaysvIqb7k9MfLOXnKCsItbwUT70A0S6YY2MzgfbhtwcOlKupaqY31IJlRmbB4i0cQcm/caX5RJwQ+rsKT2C3S8MLQNeADcZuvFKXSKThCFIhOKVYvjRancZixZ016XLlUIWs4AvrDR1/qsKoV3Vm0PsdRPM0du5ry4hwLVKmuA6gphgWLjheZMBXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(64756008)(316002)(6506007)(7696005)(52536014)(54906003)(66946007)(66556008)(66476007)(66446008)(478600001)(6916009)(5660300002)(76116006)(4326008)(71200400001)(9686003)(8936002)(8676002)(55016003)(7416002)(41300700001)(66574015)(107886003)(38070700009)(2906002)(86362001)(82960400001)(83380400001)(38100700002)(26005)(122000001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDRueFIvdkxibFM5dUVkY3hiQ0tDdVBJSXJiU2xmWnc1aDVNUW9uZEtZVGpt?=
 =?utf-8?B?Q2YyWHFrNzNneDZOWTRhS3owdzlNQS9zRW5DSUhMY0VTWFJVM3dmQXdlOW5r?=
 =?utf-8?B?QjFEaWlxbTVOS3dkK25GMTBaYlNJT3V2UTQ5OXFQOFR3SHozVUI5MTZram1U?=
 =?utf-8?B?TXp5QjB2WjFRYzlTN3dJVVRneTdEMDFXTGs2R3RDOHh0TlZJWmFLYmJGNnVX?=
 =?utf-8?B?em83OXptaDR4alc4c25CZXQveGRvSGRiTUJ5ajl0b2p3TGg5KzJQQ3VTSy95?=
 =?utf-8?B?TXhMVlVLaVlhSW1lamd2T29SRmkrb1hRZWsrUzFXbXlCcDZXOEUwcWtuR1dh?=
 =?utf-8?B?RDIxM1NiUERMMVlkVk9hMjB3YWF3dmJyT1oyQmo2MURIcFNSYzNmYzVXU1U1?=
 =?utf-8?B?WHdKZkFIUEFPNHFtQXFyWThWU1NTR2xrK0IxcnF6OGZJZjFac1ViSlBNNXNS?=
 =?utf-8?B?d3kwYXBTRG5wVlU5MS8rZFowZEo4TlRKaXcxZlkyemVMOUlDeGlkSzdrWlZw?=
 =?utf-8?B?RlVjYldMOU44SEdiUGcyakwvcFNUamZNcXFhY0hDdTk4U2JjTDlIZmkwM2Qy?=
 =?utf-8?B?b1lRMkp2RGtwTWNjV1BJeWNIT1RYOUFYTHQvT3BRYmxvRnY2eDdzUnI2T2h6?=
 =?utf-8?B?LzZ0L1dMQ1dpcDhPcmtqTUo5UlFKUThGaEp0QkhlaVNrWGFueGRHa0NCN0Vo?=
 =?utf-8?B?T3V1M2tEZWRQU3RJUEplVDFIL0QrS0pBNVE5bkdjMzlySVFlVG1Ic3V2ZFI0?=
 =?utf-8?B?TjIrMkM0NU1GVjNDRFd0U21UUnBkeEYxOUljazdKd1lIWGVwOU1IUGJhL2hE?=
 =?utf-8?B?RTZ6OFdpL3ZtdWdWNXJGQklOU0h3TVZ1YlRkbU9DSlZxTHRsU0RmbHBrSUt5?=
 =?utf-8?B?d3QrZkZIOVFLQmNYbElTOVI4TDRWUnN6ODFGZ2J0aWwyUWw3Uy9PWFN3Z2dD?=
 =?utf-8?B?bG9UWXhiYU5raXpxeW5UYmNUa212NTdCdnhOMEk2VjJZM3ZpV2RXaFAveUFH?=
 =?utf-8?B?SVRmQjAzeS9yVkt5K3RzeFBRSFdRSzdHYXFGYUxMMEhiR0hkWmd6UXYrTjFV?=
 =?utf-8?B?eXhlWTdLT2pRQkJNSWNvM0VZZ0g3RFc1bVBJY2dkNHVBUEVzYTc1RU8wQjVJ?=
 =?utf-8?B?NysraUd4b2k4cTJUYnVZRzE3UTZwUmJYcC82VkVMUzlYNWZpUmRDNTFlSTg0?=
 =?utf-8?B?QkV0ZE5wdGRwMysxTWxxZUtMc1VCWC92cXBrTUgyMUN5NmlZeDBnYWtHZTFZ?=
 =?utf-8?B?cU9DWi8rZWxaVFd5czdhVUZ6QnFLelFqdUJhQTdhODdRUHQvZ0R4WXVaN0M2?=
 =?utf-8?B?Q3hwS1hjOVhCS2I2ZFJacHVTK3o2UktJYmpKcVB4QjR1WEhrY0Z0blNNUURL?=
 =?utf-8?B?dXkwQVF4cDMvelJReHZtaUN4M3NQUjNPS3NnMXQ2TTc5cHkvTlFsTHJSTjZi?=
 =?utf-8?B?WUYyVXNwRVZBVTZ4ZGtiN3ZiWjZpQkhHYXJKa2UwYzZnVTBYK04zUXdhRWVB?=
 =?utf-8?B?RFlJcWl2OGJuM0QvRm9sRzJhajNTaDdnbE9FVjVLR0ZQdWc1SU9uNWNnaXNK?=
 =?utf-8?B?cDl2MGhBSDZVK3BzQWlYUkVNWmRNcVVEaU1zdDVzeWsxU1Jaems4Qk9qTU14?=
 =?utf-8?B?RnYwMHB1ZDJ2b2RndFdDNFpKdGxXd2NWQW1SRjRTNTdnT0xxVmxuVkUzdyt3?=
 =?utf-8?B?c2xhRklRWlIvUTdQS0w4RE9DMDZUNG9pTDVQZzJLRHl4ZnFrK3lkQ0ViS01x?=
 =?utf-8?B?OCsxK0ppRk5qNktRbG12aWxCWVo3L1F2TG5jRXJSSEo0NjAwMTBpK1BSL2E5?=
 =?utf-8?B?Wk1BSkVCUjdURFBaa2FwbC83dEQ2NkFaclMzVXV6MHh2WHllTEM4eDNESGNp?=
 =?utf-8?B?anR2TXJjUmxWMDdTMllVbE1hNkpTaHVrVTZvTDFmdzExUWJwZlRNUHlrYXFv?=
 =?utf-8?B?L3JINVdUTEZJNHM1c0I2SjdzQTdtTVU3S2lIbkowU0YvbjVWc1dKUU9XSnAy?=
 =?utf-8?B?QjlHeTMxTUQ5bnNIcjQreTYvS01uVzJlU3NuV0l3dWwwSHU3LytIbEJTVkor?=
 =?utf-8?B?TzJXWExKaE1waHVpVGpFNDREMnY5TjkrcVZ4MnpZUEdta3dLQXRrbXZxQ2pZ?=
 =?utf-8?Q?TfQcEFIzy6DVIFwSj6sUXEG+x?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da143596-af3c-454e-d101-08dbd6b45a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 06:17:10.5001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iaLEAjcQ2jPGGSwYQjpLCTqBnuE2eP88AY7bcodsPDeuV/6zu10Jo5jp7pfcOSoWj5j/YNrFucY6/o4YKSwDloMdybRuOZj7/wQ6Ajo0e74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgTWFya3VzLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNYXJrdXMg
QXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXksIE9jdG9iZXIg
MjYsIDIwMjMgOToyNyBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDAvMzddIHZmaW86IEFk
b3B0IGlvbW11ZmQNCj4NCj5aaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
PiB3cml0ZXM6DQo+DQo+PiBIaSwNCj4+DQo+PiBUaGFua3MgYWxsIGZvciBnaXZpbmcgZ3VpZGVz
IGFuZCBjb21tZW50cyBvbiBwcmV2aW91cyBzZXJpZXMsIGhlcmUgaXMNCj4+IHRoZSB2MyBvZiBw
dXJlIGlvbW11ZmQgc3VwcG9ydCBwYXJ0Lg0KPj4NCj4+IEJhc2VkIG9uIEPDqWRyaWMncyBzdWdn
ZXN0aW9uLCB0aGlzIHNlcmllcyBpbmNsdWRlcyBhbiBlZmZvcnQgdG8gcmVtb3ZlDQo+PiBzcGFw
ciBjb2RlIGZyb20gY29udGFpbmVyLmMsIG5vdyBhbGwgc3BhcHIgZnVuY3Rpb25zIGFyZSBtb3Zl
ZCB0byBzcGFwci5jDQo+PiBvciBzcGFwcl9wY2lfdmZpby5jLCBidXQgdGhlcmUgYXJlIHN0aWxs
IGEgZmV3IHRyaXZhbCBjaGVjayBvbg0KPj4gVkZJT19TUEFQUl9UQ0VfKl9JT01NVSB3aGljaCBJ
IGFtIG5vdCBzdXJlIGlmIGRlc2VydmVkIHRvIGludHJvZHVjZSBtYW55DQo+PiBjYWxsYmFja3Mg
YW5kIGR1cGxpY2F0ZSBjb2RlIGp1c3QgdG8gcmVtb3ZlIHRoZW0uIFNvbWUgZnVuY3Rpb25zIGFy
ZSBtb3ZlZA0KPj4gdG8gc3BhcHIuYyBpbnN0ZWFkIG9mIHNwYXByX3BjaV92ZmlvLmMgdG8gYXZv
aWQgY29tcGlsZSBpc3N1ZSBiZWNhdXNlDQo+PiBzcGFwcl9wY2lfdmZpby5jIGlzIGFyY2ggc3Bl
Y2lmaWMsIG9yIGVsc2Ugd2UgbmVlZCB0byBpbnRyb2R1Y2Ugc3R1Yg0KPj4gZnVuY3Rpb25zIHRv
IHRob3NlIHNwYXByIGZ1bmN0aW9ucyBtb3ZlZC4NCj4NCj5bLi4uXQ0KPg0KPj4gcWVtdSBjb2Rl
Og0KPmh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56aG9uZy9p
b21tdWZkX2NkZXZfdjMNCj4+IEJhc2VkIG9uIHZmaW8tbmV4dCwgY29tbWl0IGlkOiBmZDBlMWM4
YmMxDQo+DQo+SSBmZXRjaGVkIHRoaXMsIGFuZCBnZXQgc2V2ZXJhbCBjb21waWxlIGVycm9ycyB3
aXRoIENsYW5nIChidXQgbm90IHdpdGgNCj5HQ0MpOg0KPg0KPiAgICBGQUlMRUQ6IGxpYnFlbXUt
eDg2XzY0LXNvZnRtbXUuZmEucC9od192ZmlvX2NvbW1vbi5jLm8NCj4gICAgY2xhbmcgLW02NCAt
bWN4MTYgLUlsaWJxZW11LXg4Nl82NC1zb2Z0bW11LmZhLnAgLUkuIC1JLi4gLUl0YXJnZXQvaTM4
NiAtDQo+SS4uL3RhcmdldC9pMzg2IC1JcWFwaSAtSXRyYWNlIC1JdWkgLUl1aS9zaGFkZXIgLUkv
dXNyL2luY2x1ZGUvcGl4bWFuLTEgLQ0KPkkvdXNyL2luY2x1ZGUvY2Fwc3RvbmUgLUkvdXNyL2lu
Y2x1ZGUvc3BpY2Utc2VydmVyIC1JL3Vzci9pbmNsdWRlL3NwaWNlLTEgLQ0KPkkvdXNyL2luY2x1
ZGUvY2FjYXJkIC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1JL3Vzci9saWI2NC9nbGliLTIuMC9p
bmNsdWRlIC0NCj5JL3Vzci9pbmNsdWRlL3N5c3Byb2YtNCAtSS91c3IvaW5jbHVkZS9uc3MzIC1J
L3Vzci9pbmNsdWRlL25zcHI0IC0NCj5JL3Vzci9pbmNsdWRlL1BDU0MgLWZjb2xvci1kaWFnbm9z
dGljcyAtV2FsbCAtV2ludmFsaWQtcGNoIC1XZXJyb3IgLXN0ZD1nbnUxMSAtDQo+TzIgLWcgLWZz
dGFjay1wcm90ZWN0b3Itc3Ryb25nIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1XbWlzc2luZy1w
cm90b3R5cGVzIC0NCj5Xc3RyaWN0LXByb3RvdHlwZXMgLVdyZWR1bmRhbnQtZGVjbHMgLVdvbGQt
c3R5bGUtZGVmaW5pdGlvbiAtV3R5cGUtbGltaXRzIC0NCj5XZm9ybWF0LXNlY3VyaXR5IC1XZm9y
bWF0LXkyayAtV2luaXQtc2VsZiAtV2lnbm9yZWQtcXVhbGlmaWVycyAtV2VtcHR5LWJvZHkNCj4t
V25lc3RlZC1leHRlcm5zIC1XZW5kaWYtbGFiZWxzIC1XZXhwYW5zaW9uLXRvLWRlZmluZWQgLVdt
aXNzaW5nLWZvcm1hdC0NCj5hdHRyaWJ1dGUgLVduby1pbml0aWFsaXplci1vdmVycmlkZXMgLVdu
by1taXNzaW5nLWluY2x1ZGUtZGlycyAtV25vLXNoaWZ0LQ0KPm5lZ2F0aXZlLXZhbHVlIC1Xbm8t
c3RyaW5nLXBsdXMtaW50IC1Xbm8tdHlwZWRlZi1yZWRlZmluaXRpb24gLVduby0NCj50YXV0b2xv
Z2ljYWwtdHlwZS1saW1pdC1jb21wYXJlIC1Xbm8tcHNhYmkgLVduby1nbnUtdmFyaWFibGUtc2l6
ZWQtdHlwZS1ub3QtDQo+YXQtZW5kIC1XdGhyZWFkLXNhZmV0eSAtaXN5c3RlbSAvd29yay9hcm1i
cnUvcWVtdS9saW51eC1oZWFkZXJzIC1pc3lzdGVtDQo+bGludXgtaGVhZGVycyAtaXF1b3RlIC4g
LWlxdW90ZSAvd29yay9hcm1icnUvcWVtdSAtaXF1b3RlDQo+L3dvcmsvYXJtYnJ1L3FlbXUvaW5j
bHVkZSAtaXF1b3RlIC93b3JrL2FybWJydS9xZW11L2hvc3QvaW5jbHVkZS94ODZfNjQgLQ0KPmlx
dW90ZSAvd29yay9hcm1icnUvcWVtdS9ob3N0L2luY2x1ZGUvZ2VuZXJpYyAtaXF1b3RlDQo+L3dv
cmsvYXJtYnJ1L3FlbXUvdGNnL2kzODYgLXB0aHJlYWQgLURfR05VX1NPVVJDRSAtDQo+RF9GSUxF
X09GRlNFVF9CSVRTPTY0IC1EX0xBUkdFRklMRV9TT1VSQ0UgLWZuby1zdHJpY3QtYWxpYXNpbmcg
LWZuby0NCj5jb21tb24gLWZ3cmFwdiAtZnNhbml0aXplLWNvdmVyYWdlLWFsbG93bGlzdD1pbnN0
cnVtZW50YXRpb24tZmlsdGVyIC0NCj5mc2FuaXRpemU9ZnV6emVyLW5vLWxpbmsgLWZQSUUgLWlz
eXN0ZW0uLi9saW51eC1oZWFkZXJzIC1pc3lzdGVtbGludXgtaGVhZGVycyAtDQo+RE5FRURfQ1BV
X0ggJy1EQ09ORklHX1RBUkdFVD0ieDg2XzY0LXNvZnRtbXUtY29uZmlnLXRhcmdldC5oIicgJy0N
Cj5EQ09ORklHX0RFVklDRVM9Ing4Nl82NC1zb2Z0bW11LWNvbmZpZy1kZXZpY2VzLmgiJyAtTUQg
LU1RIGxpYnFlbXUtDQo+eDg2XzY0LXNvZnRtbXUuZmEucC9od192ZmlvX2NvbW1vbi5jLm8gLU1G
IGxpYnFlbXUteDg2XzY0LQ0KPnNvZnRtbXUuZmEucC9od192ZmlvX2NvbW1vbi5jLm8uZCAtbyBs
aWJxZW11LXg4Nl82NC0NCj5zb2Z0bW11LmZhLnAvaHdfdmZpb19jb21tb24uYy5vIC1jIC4uL2h3
L3ZmaW8vY29tbW9uLmMNCj4gICAgLi4vaHcvdmZpby9jb21tb24uYzo2ODI6NDA6IGVycm9yOiB2
YXJpYWJsZSAnaG9zdHdpbicgaXMgdW5pbml0aWFsaXplZCB3aGVuDQo+dXNlZCBoZXJlIFstV2Vy
cm9yLC1XdW5pbml0aWFsaXplZF0NCj4gICAgICAgICAgICBod2FkZHIgcGdtYXNrID0gKDFVTEwg
PDwgY3R6NjQoaG9zdHdpbi0+aW92YV9wZ3NpemVzKSkgLSAxOw0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo+ICAgIC4uL2h3L3ZmaW8vY29tbW9u
LmM6NTc4OjMxOiBub3RlOiBpbml0aWFsaXplIHRoZSB2YXJpYWJsZSAnaG9zdHdpbicgdG8gc2ls
ZW5jZQ0KPnRoaXMgd2FybmluZw0KPiAgICAgICAgVkZJT0hvc3RETUFXaW5kb3cgKmhvc3R3aW47
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgID0gTlVMTA0KPiAgICAuLi9ody92ZmlvL2NvbW1vbi5jOjc4NToz
MzogZXJyb3I6IHZhcmlhYmxlICdob3N0d2luJyBpcyB1bmluaXRpYWxpemVkIHdoZW4NCj51c2Vk
IGhlcmUgWy1XZXJyb3IsLVd1bmluaXRpYWxpemVkXQ0KPiAgICAgICAgICAgIHBnbWFzayA9ICgx
VUxMIDw8IGN0ejY0KGhvc3R3aW4tPmlvdmFfcGdzaXplcykpIC0gMTsNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+DQo+ICAgIC4uL2h3L3ZmaW8vY29tbW9uLmM6
NzgzOjM1OiBub3RlOiBpbml0aWFsaXplIHRoZSB2YXJpYWJsZSAnaG9zdHdpbicgdG8gc2lsZW5j
ZQ0KPnRoaXMgd2FybmluZw0KPiAgICAgICAgICAgIFZGSU9Ib3N0RE1BV2luZG93ICpob3N0d2lu
Ow0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gTlVMTA0KPiAgICAyIGVycm9ycyBnZW5lcmF0
ZWQuDQo+ICAgIEZBSUxFRDogdGVzdHMvdW5pdC90ZXN0LXJlc3YtbWVtLnAvdGVzdC1yZXN2LW1l
bS5jLm8NCj4gICAgY2xhbmcgLW02NCAtbWN4MTYgLUl0ZXN0cy91bml0L3Rlc3QtcmVzdi1tZW0u
cCAtSXRlc3RzL3VuaXQgLUkuLi90ZXN0cy91bml0IC1JLiAtDQo+SXFhcGkgLUl0cmFjZSAtSXVp
IC1JdWkvc2hhZGVyIC1JL3Vzci9pbmNsdWRlL2dsaWItMi4wIC1JL3Vzci9saWI2NC9nbGliLTIu
MC9pbmNsdWRlIC0NCj5JL3Vzci9pbmNsdWRlL3N5c3Byb2YtNCAtZmNvbG9yLWRpYWdub3N0aWNz
IC1XYWxsIC1XaW52YWxpZC1wY2ggLVdlcnJvciAtDQo+c3RkPWdudTExIC1PMiAtZyAtZnN0YWNr
LXByb3RlY3Rvci1zdHJvbmcgLVd1bmRlZiAtV3dyaXRlLXN0cmluZ3MgLVdtaXNzaW5nLQ0KPnBy
b3RvdHlwZXMgLVdzdHJpY3QtcHJvdG90eXBlcyAtV3JlZHVuZGFudC1kZWNscyAtV29sZC1zdHls
ZS1kZWZpbml0aW9uIC0NCj5XdHlwZS1saW1pdHMgLVdmb3JtYXQtc2VjdXJpdHkgLVdmb3JtYXQt
eTJrIC1XaW5pdC1zZWxmIC1XaWdub3JlZC1xdWFsaWZpZXJzIC0NCj5XZW1wdHktYm9keSAtV25l
c3RlZC1leHRlcm5zIC1XZW5kaWYtbGFiZWxzIC1XZXhwYW5zaW9uLXRvLWRlZmluZWQgLQ0KPldt
aXNzaW5nLWZvcm1hdC1hdHRyaWJ1dGUgLVduby1pbml0aWFsaXplci1vdmVycmlkZXMgLVduby1t
aXNzaW5nLWluY2x1ZGUtZGlycyAtDQo+V25vLXNoaWZ0LW5lZ2F0aXZlLXZhbHVlIC1Xbm8tc3Ry
aW5nLXBsdXMtaW50IC1Xbm8tdHlwZWRlZi1yZWRlZmluaXRpb24gLVduby0NCj50YXV0b2xvZ2lj
YWwtdHlwZS1saW1pdC1jb21wYXJlIC1Xbm8tcHNhYmkgLVduby1nbnUtdmFyaWFibGUtc2l6ZWQt
dHlwZS1ub3QtDQo+YXQtZW5kIC1XdGhyZWFkLXNhZmV0eSAtaXN5c3RlbSAvd29yay9hcm1icnUv
cWVtdS9saW51eC1oZWFkZXJzIC1pc3lzdGVtDQo+bGludXgtaGVhZGVycyAtaXF1b3RlIC4gLWlx
dW90ZSAvd29yay9hcm1icnUvcWVtdSAtaXF1b3RlDQo+L3dvcmsvYXJtYnJ1L3FlbXUvaW5jbHVk
ZSAtaXF1b3RlIC93b3JrL2FybWJydS9xZW11L2hvc3QvaW5jbHVkZS94ODZfNjQgLQ0KPmlxdW90
ZSAvd29yay9hcm1icnUvcWVtdS9ob3N0L2luY2x1ZGUvZ2VuZXJpYyAtaXF1b3RlDQo+L3dvcmsv
YXJtYnJ1L3FlbXUvdGNnL2kzODYgLXB0aHJlYWQgLURfR05VX1NPVVJDRSAtDQo+RF9GSUxFX09G
RlNFVF9CSVRTPTY0IC1EX0xBUkdFRklMRV9TT1VSQ0UgLWZuby1zdHJpY3QtYWxpYXNpbmcgLWZu
by0NCj5jb21tb24gLWZ3cmFwdiAtZnNhbml0aXplLWNvdmVyYWdlLWFsbG93bGlzdD1pbnN0cnVt
ZW50YXRpb24tZmlsdGVyIC0NCj5mc2FuaXRpemU9ZnV6emVyLW5vLWxpbmsgLWZQSUUgLU1EIC1N
USB0ZXN0cy91bml0L3Rlc3QtcmVzdi1tZW0ucC90ZXN0LXJlc3YtDQo+bWVtLmMubyAtTUYgdGVz
dHMvdW5pdC90ZXN0LXJlc3YtbWVtLnAvdGVzdC1yZXN2LW1lbS5jLm8uZCAtbyB0ZXN0cy91bml0
L3Rlc3QtDQo+cmVzdi1tZW0ucC90ZXN0LXJlc3YtbWVtLmMubyAtYyAuLi90ZXN0cy91bml0L3Rl
c3QtcmVzdi1tZW0uYw0KPiAgICAuLi90ZXN0cy91bml0L3Rlc3QtcmVzdi1tZW0uYzo0Mjo5OiBl
cnJvcjogdmFyaWFibGUgJ2knIHNldCBidXQgbm90IHVzZWQgWy0NCj5XZXJyb3IsLVd1bnVzZWQt
YnV0LXNldC12YXJpYWJsZV0NCj4gICAgICAgIGludCBpID0gMDsNCj4gICAgICAgICAgICBeDQo+
ICAgIDEgZXJyb3IgZ2VuZXJhdGVkLg0KPg0KPkRlbGV0ZSBAaSwgcGxlYXNlLg0KDQpUaGFua3Mg
Zm9yIHlvdXIgcmVwb3J0LCBJJ2xsIGZpeCBpdCBhbmQgYnVpbGQgd2l0aCBib3RoIGNvbXBpbGVy
cyBuZXh0IHRpbWUuDQpBYm91dCBzZWNvbmQgZXJyb3IsIEknbGwgc2VuZCBhIHNlcGFyYXRlIHBh
dGNoIGFzIGl0J3MgdW5yZWxhdGVkIHRvIHRoaXMgc2VyaWVzLg0KDQpCUnMuDQpaaGVuemhvbmcN
Cg==

