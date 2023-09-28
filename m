Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 958517B1101
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 04:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlhBf-0003lP-M5; Wed, 27 Sep 2023 22:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlhBe-0003lD-Cr; Wed, 27 Sep 2023 22:55:34 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlhBb-0003Zy-EN; Wed, 27 Sep 2023 22:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695869731; x=1727405731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=w0BLmODTGaXKpfkUvDZFaatenfvFmxMtXlNmCcxlfZA=;
 b=IfW38Tx7d8+jg3+7ZrFBA1Gym4pA1JPVcv4zXJllPsXUBCxUlkminWh+
 Umsnt19AID/ltibvWAKm+ByWGMtsFiL8tIngUlVZPPBB3CfDLxztna4/m
 CZidPT30izhQ1cXFNKWZe+0f0N/aDc5qEJNstbpCmSqN9WzQzp+tFQpHF
 SH+ChR1GzR9nolhFtD5C9GrZTP75x0oMq+ruyfkLtcP2sDuZCZjFrktKR
 7HYkvJ88GpdRbJbRjVcCZOELnucSAAWm8PSeJGHEJaTCkUMKaGVStVtY1
 DMxNm9DS9NQKD0fag5I7pAbqDAABWNsLt3Fb61Zde5mg9aPa03fvQTySd A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361351021"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; d="scan'208";a="361351021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 19:55:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="778760560"
X-IronPort-AV: E=Sophos;i="6.03,182,1694761200"; d="scan'208";a="778760560"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 19:55:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 19:55:26 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 19:55:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 19:55:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkeKuvAD8YFu+BTn6bRnKEeOFRECvQ//fe+3dcdurKH3YE9F8UANmLfkwnqvaMuWz6kNhQz3S3vVIbufk2werZyGTK92PUnU0a/b6iACi+/P8VIjY+pql/6cXKfhjJKhS0OnSQnacuSEhfvVWC5k0NhQy0K1lCE0lxqrvqcOnuKpQOJkUEupRbMOXLsgyIowIiorYpd+5W77aCHCfaeEQE0iahH3pjLJZ+GkMic/EXgYykeCdLvhm0CtWYwS8oKCL3ZbdE5Gp4ZBLB4yoY6s2aPWvPgiXq4BGSQSCEqxo+53QHpS1vg3U7p8UIuBuxSbbuvbz4KR50GsN/4RUP0XQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w0BLmODTGaXKpfkUvDZFaatenfvFmxMtXlNmCcxlfZA=;
 b=kdnDaRJUg7+htEaEXVZ4wyf9txv0J6gQRvJsDYGVqD5cVyDSsB7cPtGOCMBRkNvbXQEVw54T4SKN1QxsIuD/Yj2wm/ZHogtVHIYQ2iYtLSThLksxeUf7RNGPwWe5wtmjaXSjq6x6GymZ/plsSB1OzB86tOJavFJfpI98k46JzlXIXfSv2wdeQU9/JVpoRUy0tg3dxCENWlu+H6oKiz6ibEfJdaZTFqc6zWRlvv0mdnNt1fVLodaboQZ+VVZgrDcYMO0aWLupfsK11Lw+I2iKr/q+9rMN8hEK8WFpEpuJWzRtnBzkGDlce161xVBSFeXIkz2S+rZ5C+kgOo7X8ckUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SA3PR11MB7413.namprd11.prod.outlook.com (2603:10b6:806:31a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.24; Thu, 28 Sep
 2023 02:55:21 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 02:55:21 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Eric Farman <farman@linux.ibm.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>, "open list:S390 general arch..." <qemu-s390x@nongnu.org>
Subject: RE: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 09/12] vfio/ccw: Use vfio_[attach/detach]_device
Thread-Index: AQHZ8G9WWlJp/Edszk2rCn9JZNDPz7AucfuAgAAgoECAABjPgIAA3fDg
Date: Thu, 28 Sep 2023 02:55:20 +0000
Message-ID: <PH7PR11MB67222DD282F98E03095FBA8A92C1A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-10-zhenzhong.duan@intel.com>
 <66548ae7-3cc4-94d8-de46-c15f2e402ed1@redhat.com>
 <PH7PR11MB6722C385397F66D040C8BE5D92C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
 <0c12d354-5600-6679-44b9-b5cbfbb4ca83@linux.ibm.com>
In-Reply-To: <0c12d354-5600-6679-44b9-b5cbfbb4ca83@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SA3PR11MB7413:EE_
x-ms-office365-filtering-correlation-id: b82735d8-02eb-47bb-687d-08dbbfce5a8d
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXeMKr/Eg7/NfRXi9Nqxce4CX4FKs1ahD3hXT6t0s0R6Z59GJ5JXorybu+izYd8m2GqoEuOejGUq7dqSumhplt2bHtnZsnWZ0bIN85q1bB55SDckb4EnSU1a7QPfo6cvV9QfOmRiwCJ6Xy5LXKGZHP3etQPcTrj+ME5STEjJU4YI4dm+otA4RqwpFDjhs9Fi48gn6PnBkDL9JIMJMgeb7sP11DNIu5LR7md1VvkXPHCbFsWjFY3JJ5SFC+5WufMNzhZbi2NWckOGg1yvf2Tn8k4MDV/atZQNW5ddCkzJqs5jlekn1OL8m3vtKltQEqzoZ0yDv1SteSoyZuvQjR8/NGJ+nlaVTMYfXpZN1pbWDqda6Y2VSlFBsktO8TpUoktcS9kdGfk4P8hRLqryKWf1tRmqyQP43/9PMtFpj0PNUVlqWSwnI6PkJnz/Kk8CtnZyGsqOun2AtvMcTPQ2Iz3wRZlq/OSSdULNiP5bG8+2yPYBh/pCO0hm6Nu8cGIqSZ04zBGAkpMYqlhQPYhOxKsYAy6oaFDJ80q2sU1pzhsq0yI+sTRyFThKVuJL4J+pNh3nbvC4W8V8rSuXcREhSMfW7FCVWBb98zqTFRVcJFcYYlDeiP+KT7eH1KhCQapiZvVs
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(52536014)(41300700001)(316002)(8676002)(8936002)(7416002)(5660300002)(55016003)(66946007)(66446008)(66476007)(66556008)(54906003)(110136005)(33656002)(64756008)(478600001)(86362001)(76116006)(71200400001)(7696005)(6506007)(53546011)(9686003)(38070700005)(38100700002)(26005)(122000001)(82960400001)(83380400001)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MGtYeW00Mnc0SzFJUDg5Vy9hY0dFR2lWVVFPUzF0TjY4SHdjYmVyci9HUDBJ?=
 =?utf-8?B?NVBURkFTc3J6ZEt0NWl6SitKUG1vMkdwVDQ2MGVlem1qdzFDUnFKRW9UalFS?=
 =?utf-8?B?UmVrWWc3VDlLQ1JHamM5dzBmOXVsWVhoa3ZXZmxuQXErQlU2ekRTb1lzUG5M?=
 =?utf-8?B?WGNEdEpqWEhCaEFoOCthK2gxVXRHZHJLbG9MMkQwdWJFTXhzRW5sbmxWcnh0?=
 =?utf-8?B?eGVhWEQxU0xCZUgzY3FPd21QK25XcDNJNHN5TUd5VW5MZE1OWGVTMlRCRW9Z?=
 =?utf-8?B?NVNuSFM2SnlSbHZkYmlnSGRLZHExcmtLZkQ3RHJnSVVKWmZNcW5nYklmUVpl?=
 =?utf-8?B?M3FkeGpidFBjdnVuQXcwd1BPYXA3N1lqQ3lneFdNRXRxTzM2RW1uRUhzN2or?=
 =?utf-8?B?WFl6a21DRjY0Y0NZQ2hRcEwrVGRKTnF6WEJsWGdCb1hjMHpGQjNwZS95UFVm?=
 =?utf-8?B?NlR2c2l5NXUvYlVXMDRwUmZsNHdwUXhuWVB3ZWdLckk5S3FabGorR3I0amVF?=
 =?utf-8?B?R0FOa2pLc0Vkdkd0UEt1SXQvV1JGbDVMTlVtZXJGd2pKYkQzS0R4Z2hHdndr?=
 =?utf-8?B?OCtvb042dGx5N3J6em9JNFVOdXVGOUIvRE5LS2R4c0RGOER4eG5KUzZqSU5p?=
 =?utf-8?B?NWVQb0VlMU9vMkFlTkhyRFpsRGF4QTlBTTlmRjU2WjZLOWxBY0RJaFZPNjgw?=
 =?utf-8?B?RTVxVXNsYTZkRVZwWkZWajc0dlZKaTlkS0R6bWhoazN5ckJwZ1Z1OHFlVHdm?=
 =?utf-8?B?UWtJZ2ljTU1JM1V2cHo3aWUzekNrcjBGWGovNHhqeEZPWGJuakZkbGNReXVl?=
 =?utf-8?B?aDN1SWU1Q0RadGRUcXFKWFB2UHF6eEpPT1ViWlhvcWpVb25tbmdlcFRqVGRv?=
 =?utf-8?B?c1VnVmtoejBHc3R2dnV4dEpHMDQrS2ZqeVRMTXY0Q3lRUUxZOGdQVW1Eb20x?=
 =?utf-8?B?ZGFMRE41c3NjRXc4UFAwMklRdmRLQnBMU084Y1gxWjVtaE1xbEhoc25YYzhV?=
 =?utf-8?B?ajZ3SWVWZUJCelU4aUNZaDJFa3FLZEtlczVRSzEvZ1BjS0xyRkUxOVl4d0hh?=
 =?utf-8?B?VXV1MER0WnNsTitqSmRydzJsKzdOVDhRQ1p0OFRvNDdFK3JqNmtYcWg1Z3NI?=
 =?utf-8?B?NXZyblhwWHFZVnRWODdDalZwa3U5K0l3M2lrQjVPZ2xWelErb3VNMjZFK3Bo?=
 =?utf-8?B?SnFjbkNyMmxhZ0RLeFA2ZmkxenlQWSt3b3p5KzRRcHBkb0lycXNpbkQzc05m?=
 =?utf-8?B?MGtEU0pJMmVXdnNnblN5QThUVzJkUklicU1ZTHV1S3Mzdk5XaHl5ZnI0RmFk?=
 =?utf-8?B?aVdHZWsvdm9VeHZvUHFGY1FGSWdtWFREZXpDeCtrR2NZOFdwaktRcGIxaGRr?=
 =?utf-8?B?N1F1eUlaUklDKzYwUmYwK1lZdlBLaTZ3M1JZb0VMdUQxZ0txTVhEdkkzdHlC?=
 =?utf-8?B?QXpsZFFvbTZQQW10MUx1cEZ6MFBWMnRPVStTci91NkNSYzdsRXZJN2VXdGFS?=
 =?utf-8?B?c3grajdEdmY5MDkrU1pjV0w2ZzhCb29UWitGNVg5blVMVEdodzNUSS9MS21o?=
 =?utf-8?B?b0t1Zm5YRU5PclZNb3pyRXFKSmd0TElsdEF1REpDS0pWRWd3SHAyVmo3SlRw?=
 =?utf-8?B?cGVSbnpjK2RraGsyUEc4bytReC9UcHFmOEJ5UE8wRWNEZUlvZkUrUmZpYXRC?=
 =?utf-8?B?RW5CTG5aL2ZmT3NySWZHQnFvWFF0eE96d0ZTVjNUMnpMMjlnYkNMNGhFRk5l?=
 =?utf-8?B?Z21rNTE0NmQ0Ykc0WERkVVphVlFuclphQWlRbTBtR25tWUNFQXNnOVRYSTZ1?=
 =?utf-8?B?QzNMdFFnWUptSDgwdXkrNHpxbU5ZYUhnUmVYYjdqUHpZUHUxcjRZRmRCU21a?=
 =?utf-8?B?clM2Z3lzU0V3VkxIR29BdE4zYlRYV3ZhbTBCL2RBZHlPQUVJMWV1bHpTQ3Zm?=
 =?utf-8?B?RzlLOHU0NkM3TG9tdUFBbTNrYWlQNnJvV1UwTXhRN3hXdjM0NndOdzlPZ2Jh?=
 =?utf-8?B?cVZqYi8vcElHMnNhZ1dYR0FVV1FqUFh3NVBReXljY0V1allpRC9OU0RhQkUy?=
 =?utf-8?B?Mm5CY2hoSlA2VnZqRGIrRy91dVpYdnB2VFBDQytqcC9BT2N0WjhUZkYzbmYw?=
 =?utf-8?Q?Cz4HVLWQGW6iycypVYKYn6jc1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b82735d8-02eb-47bb-687d-08dbbfce5a8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 02:55:20.5869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlmwwmjWFvjE2V/X3GJ1Gw7eQb1wtYkyDm4upHIIfK6Bq0s8tRpHB0RIIwUivym+7GIJtcTqCF/U3Flq3Ir/G6JZKjEBz/Xe/8fU6yDMyZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7413
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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

SGkgRXJpYywgTWF0dGhldywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTog
TWF0dGhldyBSb3NhdG8gPG1qcm9zYXRvQGxpbnV4LmlibS5jb20+DQo+U2VudDogV2VkbmVzZGF5
LCBTZXB0ZW1iZXIgMjcsIDIwMjMgOToyNiBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMDkv
MTJdIHZmaW8vY2N3OiBVc2UgdmZpb19bYXR0YWNoL2RldGFjaF1fZGV2aWNlDQo+DQo+T24gOS8y
Ny8yMyA4OjA5IEFNLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4+PiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA2OjAwIFBN
DQo+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAwOS8xMl0gdmZpby9jY3c6IFVzZSB2ZmlvX1th
dHRhY2gvZGV0YWNoXV9kZXZpY2UNCj4+Pg0KPj4+DQo+Pj4NCj4+PiBPbiA5LzI2LzIzIDEzOjMy
LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPg0KPj4+Pg0KPj4+PiBMZXQgdGhlIHZmaW8tY2N3IGRldmljZSB1c2UgdmZp
b19hdHRhY2hfZGV2aWNlKCkgYW5kDQo+Pj4+IHZmaW9fZGV0YWNoX2RldmljZSgpLCBoZW5jZSBo
aWRpbmcgdGhlIGRldGFpbHMgb2YgdGhlIHVzZWQNCj4+Pj4gSU9NTVUgYmFja2VuZC4NCj4+Pj4N
Cj4+Pj4gQWxzbyBub3cgYWxsIHRoZSBkZXZpY2VzIGhhdmUgYmVlbiBtaWdyYXRlZCB0byB1c2Ug
dGhlIG5ldw0KPj4+PiB2ZmlvX2F0dGFjaF9kZXZpY2UvdmZpb19kZXRhY2hfZGV2aWNlIEFQSSwg
bGV0J3MgdHVybiB0aGUNCj4+Pj4gbGVnYWN5IGZ1bmN0aW9ucyBpbnRvIHN0YXRpYyBmdW5jdGlv
bnMsIGxvY2FsIHRvIGNvbnRhaW5lci5jLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBFcmlj
IEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIExp
dSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVh
biA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIGluY2x1ZGUvaHcv
dmZpby92ZmlvLWNvbW1vbi5oIHwgICA1IC0tDQo+Pj4+ICBody92ZmlvL2Njdy5jICAgICAgICAg
ICAgICAgICB8IDExNSArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+ICBo
dy92ZmlvL2NvbW1vbi5jICAgICAgICAgICAgICB8ICAxMCArLS0NCj4+Pj4gIDMgZmlsZXMgY2hh
bmdlZCwgMzAgaW5zZXJ0aW9ucygrKSwgMTAwIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8v
dmZpby0NCj5jb21tb24uaA0KPj4+PiBpbmRleCAxMmZiZmJjMzdkLi5jNDg2YmRlZjJhIDEwMDY0
NA0KPj4+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+PiArKysgYi9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4+PiBAQCAtMjAyLDcgKzIwMiw2IEBAIHR5
cGVkZWYgc3RydWN0IHsNCj4+Pj4gICAgICBod2FkZHIgcGFnZXM7DQo+Pj4+ICB9IFZGSU9CaXRt
YXA7DQo+Pj4+DQo+Pj4+IC12b2lkIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKFZGSU9EZXZpY2UgKnZi
YXNlZGV2KTsNCj4+Pj4gIHZvaWQgdmZpb19kaXNhYmxlX2lycWluZGV4KFZGSU9EZXZpY2UgKnZi
YXNlZGV2LCBpbnQgaW5kZXgpOw0KPj4+PiAgdm9pZCB2ZmlvX3VubWFza19zaW5nbGVfaXJxaW5k
ZXgoVkZJT0RldmljZSAqdmJhc2VkZXYsIGludCBpbmRleCk7DQo+Pj4+ICB2b2lkIHZmaW9fbWFz
a19zaW5nbGVfaXJxaW5kZXgoVkZJT0RldmljZSAqdmJhc2VkZXYsIGludCBpbmRleCk7DQo+Pj4+
IEBAIC0yMjAsMTEgKzIxOSw3IEBAIHZvaWQgdmZpb19yZWdpb25fdW5tYXAoVkZJT1JlZ2lvbiAq
cmVnaW9uKTsNCj4+Pj4gIHZvaWQgdmZpb19yZWdpb25fZXhpdChWRklPUmVnaW9uICpyZWdpb24p
Ow0KPj4+PiAgdm9pZCB2ZmlvX3JlZ2lvbl9maW5hbGl6ZShWRklPUmVnaW9uICpyZWdpb24pOw0K
Pj4+PiAgdm9pZCB2ZmlvX3Jlc2V0X2hhbmRsZXIodm9pZCAqb3BhcXVlKTsNCj4+Pj4gLVZGSU9H
cm91cCAqdmZpb19nZXRfZ3JvdXAoaW50IGdyb3VwaWQsIEFkZHJlc3NTcGFjZSAqYXMsIEVycm9y
ICoqZXJycCk7DQo+Pj4+IC12b2lkIHZmaW9fcHV0X2dyb3VwKFZGSU9Hcm91cCAqZ3JvdXApOw0K
Pj4+PiAgc3RydWN0IHZmaW9fZGV2aWNlX2luZm8gKnZmaW9fZ2V0X2RldmljZV9pbmZvKGludCBm
ZCk7DQo+Pj4+IC1pbnQgdmZpb19nZXRfZGV2aWNlKFZGSU9Hcm91cCAqZ3JvdXAsIGNvbnN0IGNo
YXIgKm5hbWUsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2
LCBFcnJvciAqKmVycnApOw0KPj4+PiAgaW50IHZmaW9fYXR0YWNoX2RldmljZShjaGFyICpuYW1l
LCBWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgQWRk
cmVzc1NwYWNlICphcywgRXJyb3IgKiplcnJwKTsNCj4+Pj4gIHZvaWQgdmZpb19kZXRhY2hfZGV2
aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY2N3
LmMgYi9ody92ZmlvL2Njdy5jDQo+Pj4+IGluZGV4IDFlMmZjZTgzYjAuLjY4OTNhMzBhYjEgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2h3L3ZmaW8vY2N3LmMNCj4+Pj4gKysrIGIvaHcvdmZpby9jY3cuYw0K
Pj4+PiBAQCAtNTcyLDg4ICs1NzIsMTQgQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfcHV0X3JlZ2lv
bihWRklPQ0NXRGV2aWNlDQo+Pj4gKnZjZGV2KQ0KPj4+PiAgICAgIGdfZnJlZSh2Y2Rldi0+aW9f
cmVnaW9uKTsNCj4+Pj4gIH0NCj4+Pj4NCj4+Pj4gLXN0YXRpYyB2b2lkIHZmaW9fY2N3X3B1dF9k
ZXZpY2UoVkZJT0NDV0RldmljZSAqdmNkZXYpDQo+Pj4+IC17DQo+Pj4+IC0gICAgZ19mcmVlKHZj
ZGV2LT52ZGV2Lm5hbWUpOw0KPj4+PiAtICAgIHZmaW9fcHV0X2Jhc2VfZGV2aWNlKCZ2Y2Rldi0+
dmRldik7DQo+Pj4+IC19DQo+Pj4+IC0NCj4+Pj4gLXN0YXRpYyB2b2lkIHZmaW9fY2N3X2dldF9k
ZXZpY2UoVkZJT0dyb3VwICpncm91cCwgVkZJT0NDV0RldmljZSAqdmNkZXYsDQo+Pj4+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+Pj4gLXsNCj4+Pj4g
LSAgICBTMzkwQ0NXRGV2aWNlICpjZGV2ID0gUzM5MF9DQ1dfREVWSUNFKHZjZGV2KTsNCj4+Pj4g
LSAgICBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIleC4leC4lMDR4IiwgY2Rldi0+aG9z
dGlkLmNzc2lkLA0KPj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2Rldi0+
aG9zdGlkLnNzaWQsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjZGV2
LT5ob3N0aWQuZGV2aWQpOw0KPj4+IERpZ2dpbmcgaW50byB0aGF0IGZldyBtb250aHMgbGF0ZXIs
DQo+Pj4NCj4+PiBuZXcgdmZpb19kZXZpY2VfZ3JvdXBpZCB1c2VzDQo+Pj4NCj4+PiArICAgIHRt
cCA9IGdfc3RyZHVwX3ByaW50ZigiJXMvaW9tbXVfZ3JvdXAiLCB2YmFzZWRldi0+c3lzZnNkZXYp
Ow0KPj4+DQo+Pj4gd2hpY2ggaXMgc2V0IGFzIGEgcHJvcCBoZXJlDQo+Pj4gICAgREVGSU5FX1BS
T1BfU1RSSU5HKCJzeXNmc2RldiIsIFZGSU9DQ1dEZXZpY2UsIHZkZXYuc3lzZnNkZXYpLA0KPj4+
IHdlIG5lZWQgdG8gZG91YmxlIGNoZWNrIGlmIHRoaXMgbWF0Y2hlcywgdGhpcyBpcyBub3Qgb2J2
aW91cyBhdCBmaXJzdCBzaWdodC4gQXQNCj5sZWFzdA0KPj4+IGlmIHRoaXMgaXMgdHJ1ZSB0aGlz
IG5lZWRzIHRvIGJlIGRvY3VtZW50ZWQgaW4gdGhlIGNvbW1pdCBtc2cNCj4+DQo+PiBHb29kIGZp
bmRpbmcuIEluZGVlZCwgdGhlcmUgaXMgYSBnYXAgaGVyZSBpZiB3ZSB1c2UgYSBzeW1ib2wgbGlu
ayBhcyBzeXNmc2Rldi4NCj4+IFNlZSBzMzkwX2Njd19nZXRfZGV2X2luZm8oKSBmb3IgZGV0YWls
cy4gQnV0IGlmIGl0J3Mgbm90IGEgc3ltYm9sIGxpbmssIEkgdGhpbmsNCj4+IHRoZXkgYXJlIHNh
bWUuDQoNCkRpZ2dlZCB0aGlzIGZ1cnRoZXIuIEkgdGhpbmsgaXQncyBvayBldmVuIGlmIGEgc21i
b2wgbGluayBpcyBwcm92aWRlZCB0byB2YmFzZWRldi0+c3lzZnNkZXYuDQpCZWNhdXNlIHdlIGp1
c3Qgd2FudCB0byBnZXQgaW9tbXUgZ3JvdXAgbnVtYmVyLg0KDQp2ZmlvX2RldmljZV9ncm91cGlk
KCkgY2FuIHN1cnZpdmUgZXZlbiB3aXRoIGEgc3ltYm9sIGxpbmsgc3VjaCBhczoNCg0KL3N5cy9i
dXMvbWRldi9kZXZpY2VzLzdlMjcwYTI1LWUxNjMtNDkyMi1hZjYwLTc1N2ZjOGVkNDhjNi9pb21t
dV9ncm91cA0KDQo+Pg0KPj4+DQo+Pj4gdGhlbiB0aGUgc3ViY2hhbm5lbCBuYW1lIGlzDQo+Pj4g
ICAgY2hhciAqbmFtZSA9IGdfc3RyZHVwX3ByaW50ZigiJXguJXguJTA0eCIsIGNkZXYtPmhvc3Rp
ZC5jc3NpZCwNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNkZXYtPmhvc3Rp
ZC5zc2lkLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY2Rldi0+aG9zdGlk
LmRldmlkKTsNCj4+PiAgICBRTElTVF9GT1JFQUNIKHZiYXNlZGV2LCAmZ3JvdXAtPmRldmljZV9s
aXN0LCBuZXh0KSB7DQo+Pj4gICAgICAgIGlmIChzdHJjbXAodmJhc2VkZXYtPm5hbWUsIG5hbWUp
ID09IDApIHsNCj4+PiAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgInZmaW86IHN1YmNoYW5u
ZWwgJXMgaGFzIGFscmVhZHkgYmVlbiBhdHRhY2hlZCIsDQo+Pj4gICAgICAgICAgICAgICAgICAg
ICAgIG5hbWUpOw0KPj4+ICAgICAgICAgICAgZ290byBvdXRfZXJyOw0KPj4+ICAgICAgICB9DQo+
Pj4gICAgfQ0KPj4+DQo+Pj4gd2hpbGUgbmV3IGNvZGUgdXNlDQo+Pj4gKyAgICBRTElTVF9GT1JF
QUNIKHZiYXNlZGV2X2l0ZXIsICZncm91cC0+ZGV2aWNlX2xpc3QsIG5leHQpIHsNCj4+PiArICAg
ICAgICBpZiAoc3RyY21wKHZiYXNlZGV2X2l0ZXItPm5hbWUsIHZiYXNlZGV2LT5uYW1lKSA9PSAw
KSB7DQo+Pj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgImRldmljZSBpcyBhbHJlYWR5
IGF0dGFjaGVkIik7DQo+Pj4gKyAgICAgICAgICAgIHZmaW9fcHV0X2dyb3VwKGdyb3VwKTsNCj4+
PiArICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsNCj4+PiArICAgICAgICB9DQo+Pj4gKyAgICB9
DQo+Pj4NCj4+PiBXZSByZWFsbHkgbmVlZCB0byBkb3VibGUgY2hlY2sgdGhlIG5hbWVzLCBpZS4N
Cj4+PiBuYW1lLCB2YmFzZWRldi0+bmFtZS4gVGhhdCdzIGEgbWVzcyBhbmQgdGhhdCdzIG15IGJh
ZC4NCj4+DQo+PiBUaGFua3MgZm9yIGNhdGNoaW5nLCBJIHRoaW5rIGJlbG93IGNoYW5nZSB3aWxs
IG1ha2UgaXQgc2FtZSBhcyBvcmlnaW5hbCBjb2RlOg0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL2Njdy5jIGIvaHcvdmZpby9jY3cuYw0KPj4gaW5kZXggNjg5M2EzMGFiMS4uYThlYTBhNmZh
OCAxMDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vY2N3LmMNCj4+ICsrKyBiL2h3L3ZmaW8vY2N3LmMN
Cj4+IEBAIC01ODAsNiArNTgwLDkgQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvcg0KPioqZXJycCkNCj4+ICAgICAgVkZJT0RldmljZSAqdmJhc2Vk
ZXYgPSAmdmNkZXYtPnZkZXY7DQo+PiAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KPj4gICAgICBp
bnQgcmV0Ow0KPj4gKyAgICBjaGFyICpuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIleC4leC4lMDR4
IiwgY2Rldi0+aG9zdGlkLmNzc2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNkZXYtPmhvc3RpZC5zc2lkLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNkZXYtPmhvc3RpZC5kZXZpZCk7DQo+Pg0KPj4gICAgICAvKiBDYWxsIHRoZSBjbGFzcyBp
bml0IGZ1bmN0aW9uIGZvciBzdWJjaGFubmVsLiAqLw0KPj4gICAgICBpZiAoY2RjLT5yZWFsaXpl
KSB7DQo+PiBAQCAtNTkxLDcgKzU5NCw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fY2N3X3JlYWxpemUo
RGV2aWNlU3RhdGUgKmRldiwgRXJyb3INCj4qKmVycnApDQo+Pg0KPj4gICAgICB2YmFzZWRldi0+
b3BzID0gJnZmaW9fY2N3X29wczsNCj4+ICAgICAgdmJhc2VkZXYtPnR5cGUgPSBWRklPX0RFVklD
RV9UWVBFX0NDVzsNCj4+IC0gICAgdmJhc2VkZXYtPm5hbWUgPSBnX3N0cmR1cChjZGV2LT5tZGV2
aWQpOw0KPj4gKyAgICB2YmFzZWRldi0+bmFtZSA9IG5hbWU7DQo+PiAgICAgIHZiYXNlZGV2LT5k
ZXYgPSAmdmNkZXYtPmNkZXYucGFyZW50X29iai5wYXJlbnRfb2JqOw0KPj4NCj4+ICAgICAgLyoN
Cj4+IEBAIC02MDQsNyArNjA3LDcgQEAgc3RhdGljIHZvaWQgdmZpb19jY3dfcmVhbGl6ZShEZXZp
Y2VTdGF0ZSAqZGV2LCBFcnJvcg0KPioqZXJycCkNCj4+ICAgICAgICovDQo+PiAgICAgIHZiYXNl
ZGV2LT5yYW1fYmxvY2tfZGlzY2FyZF9hbGxvd2VkID0gdHJ1ZTsNCj4+DQo+PiAtICAgIHJldCA9
IHZmaW9fYXR0YWNoX2RldmljZSh2YmFzZWRldi0+bmFtZSwgdmJhc2VkZXYsDQo+PiArICAgIHJl
dCA9IHZmaW9fYXR0YWNoX2RldmljZShjZGV2LT5tZGV2aWQsIHZiYXNlZGV2LA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBlcnJwKTsNCj4+
ICAgICAgaWYgKHJldCkgew0KPj4gICAgICAgICAgZ290byBvdXRfYXR0YWNoX2Rldl9lcnI7DQo+
Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCj4NCj5JIGhhdmVuJ3QgdHJpZWQgdGhpcyBwYXJ0
aWN1bGFyIHZlcnNpb24gb2YgdGhlIHBhdGNoZXMgeWV0IChlaXRoZXIgRXJpYyBGLiBvciBJIHdp
bGwpLCBidXQNCj5pdCBsb29rcyBsaWtlIHRoaXMgY2hhbmdlIHdvdWxkIHJlLWludHJvZHVjZSBh
dCBsZWFzdCBwYXJ0IG9mIHRoZSBicmVha2FnZSBJDQo+cmVwb3J0ZWQgZHVyaW5nIHRoZSBSRkM/
DQo+DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC82ZTA0YWI4Zi1kYzg0LWU5
YzItZGVlYS0NCj4yYjZiMzE2NzhiNTNAbGludXguaWJtLmNvbS8NCg0KWW91IGFyZSByaWdodCwg
bXkgbWlzdGFrZS4gSSBqdXN0IHJlbWVtYmVyZWQgSSBoYXZlIGluY2x1ZGVkIHlvdXIgc3VnZ2Vz
dGVkIGNoYW5nZQ0KaW4gYWJvdmUgbGluayB0byB0aGlzIHBhdGNoLiBTbyBubyBuZWVkIHRvIGFk
ZCBtb3JlIGNoYW5nZSBoZXJlLg0KDQpJdCBsb29rcyBsaWtlIHlvdXIgY2hhbmdlIGFsc28gZml4
ZWQgYSB2YmFzZWRldi0+bmFtZSBpc3N1ZSwgZnJvbSAiY3NzaWQuc3NpZC5kZXZpZCINCnRvICJt
ZGV2aWQiLg0KDQpMb29rIGZvcndhcmQgdG8geW91ciB0ZXN0IHJlc3VsdAl3aXRoIHRoaXMgc2Vy
aWVzLCB0aGFua3MhDQoNCkJScy4NClpoZW56aG9uZw0K

