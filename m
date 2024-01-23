Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3762838708
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 06:52:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rS9hU-0001F4-Rc; Tue, 23 Jan 2024 00:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rS9hS-0001Ei-IA
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:51:54 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rS9hP-0000cB-Pe
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 00:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705989112; x=1737525112;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OQoPnfgiWu1QXUS+3luToojUqlDVDojMbeb3pBwiZYU=;
 b=VMm4TAINHkmByiDDE2OHRnVfUxSPdeg6D0nOY9n3drAQtOp4PuCo5bOj
 mzSbB67hhO8/++nqLhaEjfiUW17gpfqHsW+24MBZb2MFeQH2kxX5bv6Gn
 hF7ViEdKy+F5V4LhW82mRsUzSDww6UrD5f69KGLFmYCCCYxrowRn3NfvM
 xhPlciNLBKsAnSeA/Lt9OXTTqdlXKrGUNGY8L5YPm/iN8JKkRZ/cyCUcy
 3SCqFFo07enJi+1x6ftWs9wlFHJBEya2waoPmmx4ujGeyoiDyBTSQ8Lk6
 ldg5i+uBfdE8yQy5bYS2+T2TDoIJj3fHlRn0xSmebk40edwvDUaSrI86x A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8534173"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="8534173"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2024 21:51:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1430564"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Jan 2024 21:51:41 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 21:51:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 21:51:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 21:51:40 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 21:51:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLQp0jBO8eaHaQS1FnveAk9g70XUSNPMfgu6pS+VdGPGtKXadsGxVEIwJrdO/XT90FkWkgFerAcWVsTcyvRXJx1YSCWDNoX8fqJlqxnWZ/4W7kLgYRiu1g5/FDZW8opZhHeyWY5MEdLY+GlsfqCOyNom+8WnIe4lfDtBwI5DbQK8yGRKaQxTcOF7bqOXklzs6Bo2sgDWbzzErkwT83luKfNMIHkTJQJW+gbSmjbi3iErLmfHrPiJekDAaj7esbS+slZkgD5/cpn4TQ4cirgchDiTVfiLh8+EBHvvnEzjQ75V6gABSGhTIT0qE5ESfr+g7vD1XvsNcHATzKnfVcFB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQoPnfgiWu1QXUS+3luToojUqlDVDojMbeb3pBwiZYU=;
 b=SHIYtDOFrlSkMkqzo0Z9GkBF7MM+SHe4LQEUA3yO/oeKxU/3N5IyOpvPejtWm/A9NBp1LHcrMD4ON9zKAi/uXOe2Kq8UHj+XnVz/9oyiF/rv2CRUR6s3U86hhtdwGNmNxIvR5vJIxNkc+R1UXFtT8U6W71ahJGY8kLSWJNpD+xiLRjkP9xy/apxKGwZ3dqnJNsu2TqBPjhFSKRBOopCA3/vmH1Qm4fcnoT+HH94dhlY5Q0mF574jpRo2GqgKXuP27wciKsh10bpYGLQ9iXxJ+eY/duVUZvhZ/a5rUi0kuGuCFt0GbiQIyY6yG7e5A6KkVrgE/RI8ul2QyM5W3MdEww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB6052.namprd11.prod.outlook.com (2603:10b6:208:394::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Tue, 23 Jan
 2024 05:51:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::d7ca:7979:6536:7ac3%4]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 05:51:32 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH rfcv1 1/6] backends/iommufd_device: introduce IOMMUFDDevice
Thread-Topic: [PATCH rfcv1 1/6] backends/iommufd_device: introduce
 IOMMUFDDevice
Thread-Index: AQHaR5vs9PoNqR9b3kO5arx2FhNKM7DfiG6AgAE6r8CABUzOAIAAokXg
Date: Tue, 23 Jan 2024 05:51:32 +0000
Message-ID: <SJ0PR11MB674455558AE3F61E2A1647D092742@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240115101313.131139-1-zhenzhong.duan@intel.com>
 <20240115101313.131139-2-zhenzhong.duan@intel.com>
 <180a39fb-aa2b-4dca-9f01-adb4f392b846@redhat.com>
 <SJ0PR11MB6744950843CB68DB485FF03792702@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <008d04c6-89b2-4b40-affa-cbfa14098308@redhat.com>
In-Reply-To: <008d04c6-89b2-4b40-affa-cbfa14098308@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB6052:EE_
x-ms-office365-filtering-correlation-id: d2ec3eab-d1f5-4d28-4ad5-08dc1bd75a0a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dr8lIHbrk6+ITQE9+pl67gjddtOxOf7gzDrfbCiYcLAtizpFRD5JPnmpQZd6SD+rJ03jYEswKfuByAXAQ612JzPZwWDCaV1+VPBP2uBqQ7Rrn6iNP7N3M34M5TQEFFd6wSepFTcR0qTyp/JigM7V2EWPaVyUqLRP5wqJkHIWbUu9HTIhzk/2S//2Rcva5MUPFHuM+2XIz8Ly7UkB6Xdmu6eP55ppUhS30cc6TsZF6sHnnJ3T2b12gVrtHkAhT+JHq+q2HKv0TrfoGiTZotK2BgHIPeuWyPF3/f/1WF6vvA9xY1o2+ON1v5IjPb6VMGGSf/cx5UO0+azsy5SMAEAYjwttsOtOUSns/hqy0eoCH54mPIair8dcntSbFERmZ29NU7poGBOtds1yg78rTSId2eZBpVpBLzknmaIc2Ibr9+vbK3/UZCIgK7kaBM+7og+6dF271XlZcCl7jv1cWa2ZZielDTvBs06plwkgsxgNA4Z+OzRtm5k3Jj/TKa6I+VbVLlfmf3Q4zsuHAMKWhRPKI03xKjBrT5HEU5wXmLh9ne/yJy4ImVHaRpWH5eWsajLZTpm7Zc73TE9lr5NxdIKSHuPbBi44UzQxOjQR5TaX0tQuufDv912Saocg2xrt6nBFnL5UazBlCjPFL51TzdzWnQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(39860400002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(9686003)(7696005)(26005)(53546011)(71200400001)(6506007)(122000001)(83380400001)(54906003)(8936002)(7416002)(5660300002)(52536014)(2906002)(4326008)(110136005)(76116006)(66446008)(66556008)(64756008)(66476007)(66946007)(316002)(41300700001)(8676002)(478600001)(33656002)(82960400001)(38070700009)(38100700002)(86362001)(55016003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T00vV3huRm5qUkdXRzVrV0hvVy9tZm1Lek5sMWNnZzcyZ3kxTFdGUHphYXdj?=
 =?utf-8?B?OFZZRVI0YldsM2hpNlZEREJmYVpKREZ6dDZ5bHBGLzJxWUxrdFo4STJwOXlv?=
 =?utf-8?B?aXoxTFZZeVhIUUhrTXhFNkVmblVDcDMxQ3hsMm1VNGJ6alAzc2F0ZEpRVnB2?=
 =?utf-8?B?UzVtcjk2L2MzdUNMZk4wUWhXd25ZMjJBSGhadlJCYzJ6WWI2RWp5OGF2MUM0?=
 =?utf-8?B?VmtIK2w2SWt4Ly9yV3UxUHNjcDV1MzZ4aVFMTzZGTlh1US9xeWUyd25YV1Mz?=
 =?utf-8?B?ampMclBKSTNjTHFMZTlyV29MUlNmTTdnc1pzUGRoUW5oeWJrQnk2clh1Wk5u?=
 =?utf-8?B?ajUvWHlkUjVlN0hlbHFvV2xVek1ZeHBVOEIzQldYU3JQVktFQ1hZUnRXb292?=
 =?utf-8?B?TlY0dE1Tc1g3Mm94UjJFcWphcFNEeUtKbjdBVzVZMnRNbVUwY29kMU5QOGJ4?=
 =?utf-8?B?ZjNSUS9SRUhqRkVSR28xT2dwK2hBcE11NElYWW1VK0VLeGJRUmp1WnZHYy82?=
 =?utf-8?B?NFU4akJERkwyTjZsUy9hRkc1b1NkTXlvR0lGZHpqTVBHVXVVZlhaLzdwWkpO?=
 =?utf-8?B?bVQyTTh1dkFaK0wvVGFGdmR0WkJoVnFPL0dDRTFwaFlDcUI5aDhiVDBVaVVv?=
 =?utf-8?B?QXpRTVRrMU5pcVVWVnh0VjlpVlc4V2NJL1hLTzZUejhJWFV6dXdyNUZMbmNO?=
 =?utf-8?B?TkR1d0NOUmNzbHZKZmU3MytYOWpYQTBrblg4RDJaVXh1VVZrSzZkTFZ3L1pX?=
 =?utf-8?B?STd2aEduL1lRR3dCMDMvWE1ZaU5sL2pzSE1YcjNIdFdzVUxHYU9WdmRjWENF?=
 =?utf-8?B?T2l1em1nT0FvQ3dhMUhjQ0I4TDIyL2VEaC9ydjE3VkU0c2xFZ2hsS1J3cUNU?=
 =?utf-8?B?UkRpZG05RnJZcDkyTnpkVlhlUXV3KzI2YXlwT2RLYzk1ejJTMXcvSk9RTkEv?=
 =?utf-8?B?d2VuZ2VVWDdFMENYMjZmL1Z4NWs1YVRlSWJLQVZtUmpxcGpFQ3FxRWRjcmNK?=
 =?utf-8?B?L21TSkd6alJkbkRDdHBwSUtycm9qQVlPc1ErOUZzblVIOWF0T1lTTnU1TmFF?=
 =?utf-8?B?dEhGeTJjcVBhbUtqR3B0T1dhdkZMUUdnNG42c09HZnIxamRCQ25MOVFHOHpT?=
 =?utf-8?B?N3g0c0c4S216VWtuUDFYVTZVY3Y2c2pYQW83cDFrTzMrbVNOUEhGanZaZldK?=
 =?utf-8?B?WFlJT3J4TTZFc0t0bUpvTE1RbEQxYjFWTVBSZXRDRnRBMFFOVjNuZnJtbFph?=
 =?utf-8?B?UUFSN3BSZ0ZncHZpZklFdFk2UE1NMVh3VzBFbDA3RXpLVVdrN2MrK0IxT3R1?=
 =?utf-8?B?N2VUQithdElDNDBVTTZVM2cxUndjL21FRmxyKzdSazcyMmpNUGRoeEhMMTk4?=
 =?utf-8?B?VWVZb09jUlIxeHFJVHZmV0pnZHpvKzNITU1RZ0F0KzhSMEN6QmxOUmJnK3No?=
 =?utf-8?B?MlJRRWRLdzNZeTJnUGxQN1VIMy9rWFlsVWphb2xCbUNaTzFmRFBUMjZ2QlRr?=
 =?utf-8?B?QTBEOWV5L3NEVUdkMFoySUUwVmQxcnZWYU1ZOWVvOTRqcHJ2bzUxNlVXUm1r?=
 =?utf-8?B?QmVoU2xCN0Z6WUV0SDcvM2pXTW9xb1hCbm9Bd2tVRVVHdHdwdWk5NjBYNzRl?=
 =?utf-8?B?bTU3T1ZpMU9IZG4rSlprM1pDVDgxeHJGd1JpbmVUbWVWbTZOcVVXWFJhRkVJ?=
 =?utf-8?B?NWY3R0U4dCtPbVdLd0Voejl2c2RJOGZjVy9lMlZUWVgyQXZ2dUQwQ3JhdkRm?=
 =?utf-8?B?RlJvNXpyVkdLM1VlKzZiZzV5RGJRaEJEdkdzWXNQVWhHNFkwR0JuVVEyZjhG?=
 =?utf-8?B?cll5QzZFR1BVQUJTcTdIajlmWkQweTFaQU9CcDE0MHdtVUY3R2ZkUGFxT3Vv?=
 =?utf-8?B?ajMxUTV5NHVoT2RYeWoycE1hd3hvcERobWplN0JtallZdEJoc1g5QzVaYklP?=
 =?utf-8?B?UklRTms5SGkvaUFRbEtqYkJwd1N1TERzS2UxK05KcmpMclJYYVY5NVkzL0Vx?=
 =?utf-8?B?cXJrM1gyeDArbXkwQ2VIZzZaUVNqck1aZXJrTjNObDBtZ1F6OVlTTHRNaGYw?=
 =?utf-8?B?MnA2a2l3RHBrU2xMYVRBZWwzclJlVUoyQ05hTVhtaVlWK04zdHpSUDIwcEVI?=
 =?utf-8?Q?kTqHRbgkOMl98yTiAj7LvHDot?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ec3eab-d1f5-4d28-4ad5-08dc1bd75a0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 05:51:32.2257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnKyw/LVlEaP9BZ0Wy7AuNQe4t5y5hpWhCqLrtQUyAYj1qxLWU0CE/gIkHwjqdzhPOEXyTVEdOStljP9n8dZF7Q1xRsU/QMVQhYEhCNITZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6052
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.289,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDEvNl0gYmFja2Vu
ZHMvaW9tbXVmZF9kZXZpY2U6IGludHJvZHVjZQ0KPklPTU1VRkREZXZpY2UNCj4NCj5PbiAxLzE5
LzI0IDA4OjMxLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+Pg0KPj4NCj4+PiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0
LmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHJmY3YxIDEvNl0gYmFja2VuZHMvaW9tbXVm
ZF9kZXZpY2U6IGludHJvZHVjZQ0KPj4+IElPTU1VRkREZXZpY2UNCj4+Pg0KPj4+DQo+Pj4NCj4+
PiBPbiAxLzE1LzI0IDExOjEzLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gSU9NTVVGRERl
dmljZSByZXByZXNlbnRzIGEgZGV2aWNlIGluIGlvbW11ZmQgYW5kIGNhbiBiZSB1c2VkIGFzDQo+
Pj4+IGEgY29tbXVuaWNhdGlvbiBpbnRlcmZhY2UgYmV0d2VlbiBkZXZpY2VzIChpLmUuLCBWRklP
LCBWRFBBKSBhbmQNCj4+Pj4gdklPTU1VLg0KPj4+Pg0KPj4+PiBDdXJyZW50bHkgaXQgaW5jbHVk
ZXMgaW9tbXVmZCBoYW5kbGVyIGFuZCBkZXZpY2UgaWQgaW5mb3JtYXRpb24NCj4+Pj4gd2hpY2gg
Y291bGQgYmUgdXNlZCBieSB2SU9NTVUgdG8gZ2V0IGh3IElPTU1VIGluZm9ybWF0aW9uLg0KPj4+
Pg0KPj4+PiBJbiBmdXR1cmUgbmVzdGVkIHRyYW5zbGF0aW9uIHN1cHBvcnQsIHZJT01NVSBpcyBn
b2luZyB0byBoYXZlDQo+Pj4+IG1vcmUgaW9tbXVmZCByZWxhdGVkIG9wZXJhdGlvbnMgbGlrZSBh
bGxvY2F0ZSBod3B0IGZvciBhIGRldmljZSwNCj4+Pj4gYXR0YWNoL2RldGFjaCBod3B0LCBldGMu
IFNvIElPTU1VRkREZXZpY2Ugd2lsbCBiZSBmdXJ0aGVyIGV4cGFuZGVkLg0KPj4+Pg0KPj4+PiBJ
T01NVUZERGV2aWNlIGlzIHdpbGxpbmdseSBub3QgYSBRT00gb2JqZWN0IGJlY2F1c2Ugd2UgZG9u
J3Qgd2FudA0KPj4+PiBpdCB0byBiZSB2aXNpYmxlIGZyb20gdGhlIHVzZXIgaW50ZXJmYWNlLg0K
Pj4+Pg0KPj4+PiBJbnRyb2R1Y2UgYSBoZWxwZXIgaW9tbXVmZF9kZXZpY2VfaW5pdCB0byBpbml0
aWFsaXplIElPTU1VRkREZXZpY2UuDQo+Pj4+DQo+Pj4+IE9yaWdpbmFsbHktYnk6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3Vu
QGxpbnV4LmludGVsLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICB8ICA0ICstLQ0KPj4+PiAgIGluY2x1ZGUvc3lzZW11L2lvbW11ZmRf
ZGV2aWNlLmggfCAzMSArKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgIGJhY2tlbmRzL2lvbW11
ZmRfZGV2aWNlLmMgICAgICAgfCA1MA0KPj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPj4+IE1heWJlIGl0IGlzIHN0aWxsIHRpbWUgdG8gbW92ZSB0aGUgaW9tbXVmZCBmaWxl
cyBpbiBhIHNlcGF0ZSBkaXIsIHVuZGVyDQo+Pj4gaHcgYXQgdGhlIHNhbWUgbGV2ZWwgYXMgdmZp
by4NCj4+Pg0KPj4+IFRob3VnaHRzPw0KPj4NCj4+IEFueSByZWFzb24gZm9yIHRoZSBtb3ZlbWVu
dD8gSHcgZGlyIGNvbnRhaW5zIGVudHJpZXMgdG8gZW11bGF0ZQ0KPmRpZmZlcmVudA0KPj4gRGV2
aWNlcy4gSW9tbXVmZCBpcyBub3QgYSByZWFsIGRldmljZS4gSXQncyBtb3JlIGEgYmFja2VuZC4N
Cj4NCj5JIHdvdWxkIGluY2x1ZGUgdGhlIG5ldyBzZXJ2aWNlcyBpbiB0aGUgZXhpc3RpbmcgaW9t
bXVmZCAuW2NoXSBmaWxlcy4NCj5ObyBuZWVkIGZvciBhIG5ldyBmaWxlIHNpbmNlIHRoZSBjaGFu
Z2VzIGFyZSBhbGwgcmVsYXRlZCB0byB0aGUgSU9NTVVGRA0KPmRldmljZSB1c2FnZS4NCg0KTWFr
ZSBzZW5zZSwgd2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

