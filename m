Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC127E7702
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 03:05:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1GsK-0003Vm-IU; Thu, 09 Nov 2023 21:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1GsH-0003TO-NQ
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 21:03:58 -0500
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r1GsB-0003mf-Qd
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 21:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699581831; x=1731117831;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p7IYfjUjPBsMEtQMggNqAd+ZwKBdJLmNBNKk7rb0gZM=;
 b=DjRzS8mvCfka23Q+O8CSpcTCTjs49dHgSLO00i0F4V/g2pf0FZvcqfyU
 SiLLSKv2vpjE19atA5qe++GyVgU4qAXShL4ACmyLi1jWHS5Qo7AfNZPwr
 ORRwjWYsMNKbBy9uL05SwkLHbjQ1smm1AsP9dvtCYz1XodEqMGj7NSkzD
 o2FMy7Dt+EYwIfI0KQ+GYb1BpcOJcmoxrkZ28Ygmmto/3zO+3AEp2UK/q
 CDUJel4pCsmEGx/pY7iSFqzPW6tY/D1MS2KY8RjqRpDqFO+V4+1n1AsEI
 gBpe7IQtIVf9lcm2wHvvEVwmyPBduc8FoESpuIO9GjcU9545JGz9FdawQ Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="456613540"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="456613540"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 18:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="829507804"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="829507804"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Nov 2023 18:03:47 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 18:03:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 9 Nov 2023 18:03:47 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 9 Nov 2023 18:03:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGicTR/7XuqtMemvX8oak0G+K1kPZTlAdBeKaaoo+vnBow34uCMJVPLo77UORelR4OOU/zpsPKmUkuWiFj01pBrZ7/bzUQpO8eglqfcmRhg3yGErNAYgVhsqKeH+FmSxJLeFS4xk92r4pmVopkbMY4C47dfQSn3izMI8G55FJNJFQcJCbX9jpx8JNZq6rl2Fd2+1Pcy9ifGMYa36uWFf83UrWC/NtlUgwTFjChyb4ABYyf9OJwNDsrw6dr2SQJYKw9mV0SAywhQx27FhF1wGRqTYTu8O5v53Uz2XJCQg/b0yGuh8NNWT45WQ5gC70b4AxV8xIiKA2ItHuTftjTAUUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7IYfjUjPBsMEtQMggNqAd+ZwKBdJLmNBNKk7rb0gZM=;
 b=KHRNpf7JpCPGGcjRUv3NIHHGqGKyi0Z8gDUliX0sFTQ5eByKYIzSOlxWoiug1gHjwkAHobCB4uqA0izUEVXatBZpFhobHxkjgnHvNO9nhjvYYNzPDybpvvGNbPcD2r/Mt5aC0AGh/gw7jBliJz0GxrlgzXv8dqOvshvy/beghvlO6Kml8ItcsvPG/bNrDBrBiwlOmMyd69SRbJxNDrCDP4Hrh/dbTD27HKneqNZVGy/PwdkyQniBDvvGe35utfQ05sYOv255J2VtAxXHSubyNV2uxKGx9qxoE0vyuh/Wcct8mXzCBJLiYTiCjNPtfsjjbyPDry8p422ApRb6ABKawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM4PR11MB7352.namprd11.prod.outlook.com (2603:10b6:8:103::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 02:03:44 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 02:03:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins,
 Joao" <joao.m.martins@oracle.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v4 26/41] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaDV55xw4BryR3ak233G0Yz5k1LbBu4yyAgAERJRWAAEaqgIAAB7I3gAA3N4CAAUNKsoABGFVA
Date: Fri, 10 Nov 2023 02:03:43 +0000
Message-ID: <SJ0PR11MB674457AF8A2E6545B8CEAE6A92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <87r0l0dc9q.fsf@pond.sub.org>
 <d710b361-7078-456c-86bd-6b7f23d56584@redhat.com>
 <87zfzoa65e.fsf@pond.sub.org>
 <20de5dde-2a1a-4d20-bafc-b63a8015fae7@redhat.com>
 <871qcz70vg.fsf@pond.sub.org>
In-Reply-To: <871qcz70vg.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM4PR11MB7352:EE_
x-ms-office365-filtering-correlation-id: 5c65a526-bbde-4676-a7d1-08dbe1914486
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NjBupPELxkqRwbZ4XxtLM7UjBEzIbFUA+rgwW4fxp28TrnYrSFJixKzTd/Ksqtqcfcv2MLkUFBAUcaUbZXDUHUK0dQKWw32Xv6emd3ibxLZ2aR/3qidLwcUu8ejUJB0ECu2e4DsUhAVzSHEFDIhMKs9sgImAImywPil2aLS0TSvPLCaJ7B5p3GMoVbZXibiHFpegNv8qz78xoMKwRn+FnZFWUeAnUAUg/lnd8Ss5gnGIs0CuIvaJh4+WvUpbtJL3KMvcR1B+1U3izwRLx5dWZmpvZQ1YxWCPdCLJz2IiOrDPX8r4yzoaLsP9FH16HjYPoP+rS0EgiNnIqdOuoZM423B5Y40jT06RrHwZN7FLwXPC91vkFe3EtUt1kyAVz545rt5fgAT/rCHG8U9RxP2Fz//AnRGK+kl2ojRkfRqX1+4iu8Fn5oAecQ1yMLUYjK4uYcU15lryTfNQ9pjzWrvMoiItO8QvyaG32vI1ftEXvJHLK4VmnUrL+AqyVcNk7bpGe4yqUnqKkRKlxGgsyX68QxIMEfNDR8aAvh6CPKdlQgxk/PUXcVnfVFMr4Qy95n0ZVYjf26uBfXGOJr1PIYbmIUKGC5cyRk7kNzFgzDEkhv6QH6NyXmhFRC218Qm6xBMc5ikMyVCQFKM1XGxcrpvMU6X8QdOhbDnsUhFKC060SCE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(376002)(366004)(346002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(8936002)(4326008)(110136005)(8676002)(2906002)(41300700001)(55016003)(38100700002)(5660300002)(53546011)(66556008)(9686003)(86362001)(33656002)(316002)(66476007)(64756008)(7416002)(52536014)(54906003)(66446008)(66946007)(83380400001)(26005)(82960400001)(76116006)(122000001)(38070700009)(66574015)(71200400001)(478600001)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS80VjAwL0hpU21TS1lpendIdjI2NDBMMkVoVEZLS1E0ejI1dlF2VUN2UlVE?=
 =?utf-8?B?NW52aGUwZithSE9QbW5yTEFxL0tGTE5lRktXZWU1NlhpZnAxOTBhMzBDbWFv?=
 =?utf-8?B?M2ZobUR3bE1VNUk2R1V5elo4c2ZZanA3YlRSZk9VbTQyUm5NWXpEK3gvTDlG?=
 =?utf-8?B?VGZFcUtBdkhRUGZUZGlERnlvejF5UlRodUJLbUt6QWUrUEcveWVxUXlBQWtn?=
 =?utf-8?B?a05rR0N2aCs2d1RQRVN6dU12NTVka2Nxc20zUUpNbWZDbWtLS1gwSmJYWHhY?=
 =?utf-8?B?bXpkc2JybjFnTDl1R2JUcnB2cVJQbHNzeE9RMi9YUFB4MUxMeDRIaENiRU0w?=
 =?utf-8?B?eXpVd1RoQWoxaW9GTEVucVdWNUsyY0w3VXJ6RWRHM095aXo3TlpPaklQL05E?=
 =?utf-8?B?aFZSclV1ZlI5cDg1QzdJL1Y2MVZBNm1yYTBDR0tWZWtFQThueVdlZXRiTU5J?=
 =?utf-8?B?UTBZdEtJblNubk9VczRpN1pOZlVRNTJhMVp4OUNBczIycWhBRTNNcndLckRH?=
 =?utf-8?B?SG94Qk0wYVBSTktZNUJIQ0hMTldCWW0zRnA2aTlVaytxQjF4TDJURVBGdHg1?=
 =?utf-8?B?Y2ovWHJlOGZZOFEzbXlWYnV0UEpsdUM2cDRWY0V2NmNDekM4VDZUMWp5TW5O?=
 =?utf-8?B?WDd4dk9BbkxnZkpIeHJOcmRPRFliTjZHVFlNYjh0SU8zcHU3QnYzUVk4clo1?=
 =?utf-8?B?ZzZzVyt4ZnRta1VQTXpDN3I2YWhsWk9IWXJESGJobVdFMFFKT2xKMHVGbk55?=
 =?utf-8?B?WHM1bGs3NjRvUDg4a0lnZS9GdENjWnZENFVHYWVVZE9yTEQ2ZDVjdnI3d25t?=
 =?utf-8?B?MExOQmY4Q20yN1VnZmJlTlBPZkY2dlBMNGovYmZTa3dIaEJ1S2M5MklObzUx?=
 =?utf-8?B?ODFhdkhlOGp5VUxkSXdrOTFxeitlWW00bEtYZ2lyaHNQZXZkc0VTaHYzM2t5?=
 =?utf-8?B?L3h0TS9vOUFlcEJDcm5HYUQvT2NCdlRXWnJBSlQ0dURKUVBnNC9VWjY3Vnpn?=
 =?utf-8?B?SEk2b3FBZ1JsU294ZlVWRkUrYUlhME4rSmNOanZzc1VFTUpvVlM3M1piWXph?=
 =?utf-8?B?TnlreDlPdWxOcElWOXpaK2Z0S0xmR2xpWnltalNrbjRuNDE2bDJMS2F0dlEw?=
 =?utf-8?B?NnZCQWtEVVI1cWpCdWJqYXYrMXFIRE04TGFidlhYcnpEY2RsbFRzVGJNN3li?=
 =?utf-8?B?Qk9oZElBN2dzQy83WFVUdG5PZGVSWGpDcFBsQlNPTFl3Y3Y4ekVGbERONjVC?=
 =?utf-8?B?S1ljVW9Rby8wbUdUNHVYMW04d2x5WUx2SFpKNE1FVmJqR09rK3ByS1FYNUwr?=
 =?utf-8?B?M1JQNW4yUUJ3UXFHcVZDS2VEQ1dJUm5RN29PS094RVhvUHJmMDVjYmFCSUgx?=
 =?utf-8?B?MGlzbVh3c1Fsb1U1MDZxVjFGZk5RTlF4UEM1bXZJZEM4VUhrVTY3dFZUNGlo?=
 =?utf-8?B?KzBXNmlKQytOMVBlWnBXbHgyTVZuUG1NLy9reEdkT0grNmtjTFhlV0VOM0lW?=
 =?utf-8?B?Z20yangvU05yWDhoZ2xsWUdST2ZDWTNEMktOc1pFb2xKTHlrYm5JeVhMcnlx?=
 =?utf-8?B?azFIYWEyb0hJRzNCSm9kUWlwV1RiNExqMEJKUDhSaEhoVEJTSExybzJZSk9m?=
 =?utf-8?B?bjNTMjdQUnFzaTNwVXpaUXlsbWlTTVlHUm4wUlpEeVowSmFmbk1WY3NTbTNj?=
 =?utf-8?B?THdKSWducWxLWWZVRTUxanMvamZHWlhIOG5tUENSenRiNVYvbjNudkh2MWRJ?=
 =?utf-8?B?UUhidi9hUW1pcitjbGhsWVUrTWJ0YTRmL09GdGtxWWN1OENyQUgzRVF3RndF?=
 =?utf-8?B?SHQwWUN6bzhxMXBuWnBDdjRQa0l5ODVCZ2QvZmRwMGdGY0pldm5kOTRCRldp?=
 =?utf-8?B?WlJ4a0NxVURFTmhiUStWVlpWWVpVQTVYd2JKSmZsTHNCekZrTml0SmxxZUQ1?=
 =?utf-8?B?NTRjUlliazB2WXdVVlRZSDFwUXB2a3ZOc2YzalVKdjVkZUhMVXRsSFRWNzFF?=
 =?utf-8?B?bUlvM21oU0dMVytjU0dLS2VkaEpldXFUYUxVU1E0djhsRWRLU2puVU1jOGx2?=
 =?utf-8?B?QzNLS2dIeWFhT1NNTmZ4R3c1bjhJNnJIaXd5dWh2UzM5VmZJek5zVHdjdlI1?=
 =?utf-8?Q?w9W3x+I3OiB+2rrG/mu7RRMGx?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c65a526-bbde-4676-a7d1-08dbe1914486
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 02:03:43.8724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkgdjG0OiLjtGA+8N5/94xnMjGHD5eOYXa0iBng+6/9nmIdY11rVApJretE/ZphQjTCFDLXJyps9gAcvan3RCgFH6bhaMCezSHzRHBy60jo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7352
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNYXJrdXMgQXJtYnJ1c3RlciA8
YXJtYnJ1QHJlZGhhdC5jb20+DQo+U2VudDogVGh1cnNkYXksIE5vdmVtYmVyIDksIDIwMjMgNTow
NSBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjYvNDFdIGJhY2tlbmRzL2lvbW11ZmQ6IElu
dHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj5Dw6lkcmljIExlIEdvYXRlciA8Y2xnQHJl
ZGhhdC5jb20+IHdyaXRlczoNCj4NCj4+IE9uIDExLzgvMjMgMTE6MzAsIE1hcmt1cyBBcm1icnVz
dGVyIHdyb3RlOg0KPj4+IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4gd3JpdGVz
Og0KPj4+DQo+Pj4+IEhlbGxvIE1hcmt1cywNCj4+Pj4NCj4+Pj4gT24gMTEvOC8yMyAwNjo1MCwg
TWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+Pj4+PiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJl
ZGhhdC5jb20+IHdyaXRlczoNCj4+Pj4+DQo+Pj4+Pj4gT24gMTEvMi8yMyAwODoxMiwgWmhlbnpo
b25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVk
aGF0LmNvbT4NCj4+Pj4+Pj4gSW50cm9kdWNlIGFuIGlvbW11ZmQgb2JqZWN0IHdoaWNoIGFsbG93
cyB0aGUgaW50ZXJhY3Rpb24NCj4+Pj4+Pj4gd2l0aCB0aGUgaG9zdCAvZGV2L2lvbW11IGRldmlj
ZS4NCj4+Pj4+Pj4gVGhlIC9kZXYvaW9tbXUgY2FuIGhhdmUgYmVlbiBhbHJlYWR5IHByZS1vcGVu
ZWQgb3V0c2lkZSBvZiBxZW11LA0KPj4+Pj4+PiBpbiB3aGljaCBjYXNlIHRoZSBmZCBjYW4gYmUg
cGFzc2VkIGRpcmVjdGx5IGFsb25nIHdpdGggdGhlDQo+Pj4+Pj4+IGlvbW11ZmQgb2JqZWN0Og0K
Pj4+Pj4+PiBUaGlzIGFsbG93cyB0aGUgaW9tbXVmZCBvYmplY3QgdG8gYmUgc2hhcmVkIGFjY3Jv
c3Mgc2V2ZXJhbA0KPj4+Pj4+PiBzdWJzeXN0ZW1zIChWRklPLCBWRFBBLCAuLi4pLiBGb3IgZXhh
bXBsZSwgbGlidmlydCB3b3VsZCBvcGVuDQo+Pj4+Pj4+IHRoZSAvZGV2L2lvbW11IG9uY2UuDQo+
Pj4+Pj4+IElmIG5vIGZkIGlzIHBhc3NlZCBhbG9uZyB3aXRoIHRoZSBpb21tdWZkIG9iamVjdCwg
dGhlIC9kZXYvaW9tbXUNCj4+Pj4+Pj4gaXMgb3BlbmVkIGJ5IHRoZSBxZW11IGNvZGUuDQo+Pj4+
Pj4+IFRoZSBDT05GSUdfSU9NTVVGRCBvcHRpb24gbXVzdCBiZSBzZXQgdG8gY29tcGlsZSB0aGlz
IG5ldyBvYmplY3QuDQo+Pj4+Pj4+IFN1Z2dlc3RlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUg
PHlpLmwubGl1QGludGVsLmNvbT4NCj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1
YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4+Pj4gLS0tDQo+Pj4+Pj4+IHY0OiBh
ZGQgQ09ORklHX0lPTU1VRkQgY2hlY2ssIGRvY3VtZW50IGRlZmF1bHQgY2FzZQ0KPj4+Pj4+PiAg
ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgIHwgICA3ICsrDQo+Pj4+Pj4+ICAgICBxYXBpL3Fv
bS5qc29uICAgICAgICAgICAgfCAgMjIgKysrKw0KPj4+Pj4+PiAgICAgaW5jbHVkZS9zeXNlbXUv
aW9tbXVmZC5oIHwgIDQ2ICsrKysrKysNCj4+Pj4+Pj4gICAgIGJhY2tlbmRzL2lvbW11ZmQtc3R1
Yi5jICB8ICA1OSArKysrKysrKysNCj4+Pj4+Pj4gICAgIGJhY2tlbmRzL2lvbW11ZmQuYyAgICAg
ICB8IDI1Nw0KPisrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+Pj4+
PiAgICAgYmFja2VuZHMvS2NvbmZpZyAgICAgICAgIHwgICA0ICsNCj4+Pj4+Pj4gICAgIGJhY2tl
bmRzL21lc29uLmJ1aWxkICAgICB8ICAgNSArDQo+Pj4+Pj4+ICAgICBiYWNrZW5kcy90cmFjZS1l
dmVudHMgICAgfCAgMTIgKysNCj4+Pj4+Pj4gICAgIHFlbXUtb3B0aW9ucy5oeCAgICAgICAgICB8
ICAxMyArKw0KPj4+Pj4+PiAgICAgOSBmaWxlcyBjaGFuZ2VkLCA0MjUgaW5zZXJ0aW9ucygrKQ0K
Pj4+Pj4+PiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaA0K
Pj4+Pj4+PiAgICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJhY2tlbmRzL2lvbW11ZmQtc3R1Yi5jDQo+
Pj4+Pj4+ICAgICBjcmVhdGUgbW9kZSAxMDA2NDQgYmFja2VuZHMvaW9tbXVmZC5jDQo+Pj4+Pj4+
IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+Pj4+Pj4+IGluZGV4IGNk
OGQ2YjE0MGYuLjZmMzUxNTkyNTUgMTAwNjQ0DQo+Pj4+Pj4+IC0tLSBhL01BSU5UQUlORVJTDQo+
Pj4+Pj4+ICsrKyBiL01BSU5UQUlORVJTDQo+Pj4+Pj4+IEBAIC0yMTM1LDYgKzIxMzUsMTMgQEAg
RjogaHcvdmZpby9hcC5jDQo+Pj4+Pj4+ICAgICBGOiBkb2NzL3N5c3RlbS9zMzkweC92ZmlvLWFw
LnJzdA0KPj4+Pj4+PiAgICAgTDogcWVtdS1zMzkweEBub25nbnUub3JnDQo+Pj4+Pj4+ICAgICAr
aW9tbXVmZA0KPj4+Pj4+PiArTTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+Pj4+Pj4+
ICtNOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4+Pj4+ICtTOiBTdXBw
b3J0ZWQNCj4+Pj4+Pj4gK0Y6IGJhY2tlbmRzL2lvbW11ZmQuYw0KPj4+Pj4+PiArRjogaW5jbHVk
ZS9zeXNlbXUvaW9tbXVmZC5oDQo+Pj4+Pj4+ICsNCj4+Pj4+Pj4gICAgIHZob3N0DQo+Pj4+Pj4+
ICAgICBNOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPj4+Pj4+PiAgICAg
UzogU3VwcG9ydGVkDQo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9xYXBpL3FvbS5qc29uIGIvcWFwaS9x
b20uanNvbg0KPj4+Pj4+PiBpbmRleCBjNTNlZjk3OGZmLi4yNzMwMGFkZDQ4IDEwMDY0NA0KPj4+
Pj4+PiAtLS0gYS9xYXBpL3FvbS5qc29uDQo+Pj4+Pj4+ICsrKyBiL3FhcGkvcW9tLmpzb24NCj4+
Pj4+Pj4gQEAgLTc5NCw2ICs3OTQsMjQgQEANCj4+Pj4+Pj4gICAgIHsgJ3N0cnVjdCc6ICdWZmlv
VXNlclNlcnZlclByb3BlcnRpZXMnLA0KPj4+Pj4+PiAgICAgICAnZGF0YSc6IHsgJ3NvY2tldCc6
ICdTb2NrZXRBZGRyZXNzJywgJ2RldmljZSc6ICdzdHInIH0gfQ0KPj4+Pj4+PiArIyMNCj4+Pj4+
Pj4gKyMgQElPTU1VRkRQcm9wZXJ0aWVzOg0KPj4+Pj4+PiArIw0KPj4+Pj4+PiArIyBQcm9wZXJ0
aWVzIGZvciBpb21tdWZkIG9iamVjdHMuDQo+Pj4+Pj4+ICsjDQo+Pj4+Pj4+ICsjIEBmZDogZmls
ZSBkZXNjcmlwdG9yIG5hbWUgcHJldmlvdXNseSBwYXNzZWQgdmlhICdnZXRmZCcgY29tbWFuZCwN
Cj4+Pj4+Pj4gKyMgICAgIHdoaWNoIHJlcHJlc2VudHMgYSBwcmUtb3BlbmVkIC9kZXYvaW9tbXUu
ICBUaGlzIGFsbG93cyB0aGUNCj4+Pj4+Pj4gKyMgICAgIGlvbW11ZmQgb2JqZWN0IHRvIGJlIHNo
YXJlZCBhY2Nyb3NzIHNldmVyYWwgc3Vic3lzdGVtcw0KPj4+Pj4+PiArIyAgICAgKFZGSU8sIFZE
UEEsIC4uLiksIGFuZCB0aGUgZmlsZSBkZXNjcmlwdG9yIHRvIGJlIHNoYXJlZA0KPj4+Pj4+PiAr
IyAgICAgd2l0aCBvdGhlciBwcm9jZXNzLCBlLmcuIERQREsuICAoZGVmYXVsdDogUUVNVSBvcGVu
cw0KPj4+Pj4+PiArIyAgICAgL2Rldi9pb21tdSBieSBpdHNlbGYpDQo+Pj4+Pj4+ICsjDQo+Pj4+
Pj4+ICsjIFNpbmNlOiA4LjINCj4+Pj4+Pj4gKyMjDQo+Pj4+Pj4+ICt7ICdzdHJ1Y3QnOiAnSU9N
TVVGRFByb3BlcnRpZXMnLA0KPj4+Pj4+PiArICAnZGF0YSc6IHsgJypmZCc6ICdzdHInIH0sDQo+
Pj4+Pj4+ICsgICdpZic6ICdDT05GSUdfSU9NTVVGRCcgfQ0KPj4+Pj4+DQo+Pj4+Pj4NCj4+Pj4+
PiBBY3RpdmF0aW5nIG9yIG5vdCBJT01NVUZEIG9uIGEgcGxhdGZvcm0gaXMgYSBjb25maWd1cmF0
aW9uIGNob2ljZQ0KPj4+Pj4+IGFuZCBpdCBpcyBub3QgYSBkZXBlbmRlbmN5IG9uIGFuIGV4dGVy
bmFsIHJlc291cmNlLiBJIHdvdWxkIG1ha2UNCj4+Pj4+PiB0aGluZ3Mgc2ltcGxlciBhbmQgZHJv
cCBhbGwgdGhlICNpZmRlZiBpbiB0aGUgZG9jdW1lbnRhdGlvbiBmaWxlcy4NCj4+Pj4+DQo+Pj4+
PiBXaGF0IGV4YWN0bHkgYXJlIHlvdSBwcm9wb3Npbmc/DQo+Pj4+DQo+Pj4+IEkgd291bGQgbGlr
ZSB0byBzaW1wbGlmeSB0aGUgY29uZmlndXJhdGlvbiBwYXJ0IG9mIHRoaXMgbmV3IElPTU1VRkQN
Cj4+Pj4gZmVhdHVyZSBhbmQgYXZvaWQgYSAuL2NvbmZpZ3VyZSBvcHRpb24gdG8gZW5hYmxlL2Rp
c2FibGUgdGhlIGZlYXR1cmUNCj4+Pj4gc2luY2UgaXQgaGFzIG5vIGV4dGVybmFsIGRlcGVuZGVu
Y2llcyBhbmQgY2FuIGJlIGNvbXBpbGVkIG9uIGFsbA0KPj4+PiBwbGF0Zm9ybXMuDQo+Pj4+DQo+
Pj4+IEhvd2V2ZXIsIHdlIGtub3cgdGhhdCBpdCBvbmx5IG1ha2VzIHNlbnNlIHRvIGhhdmUgdGhl
IElPTU1VRkQgYmFja2VuZA0KPj4+PiBvbiBwbGF0Zm9ybXMgczM5MHgsIGFhcmNoNjQsIHg4Nl82
NC4gU28gSSBhbSBwcm9wb3NpbmcgYXMgYW4gaW1wcm92ZW1lbnQNCj4+Pj4gdG8gZW5hYmxlIElP
TU1VRkQgb25seSBvbiB0aGVzZSBwbGF0Zm9ybXMgd2l0aCB0aGlzIGFkZGl0aW9uIDoNCj4+Pj4N
Cj4+Pj4gICAgaW1wbHkgSU9NTVVGRA0KPj4+Pg0KPj4+PiB0byBody97aTM4NixzMzkweCxhcm19
L0tjb25maWcgZmlsZXMuDQo+Pj4+DQo+Pj4+IFRoaXMgZ2l2ZXMgdXMgdGhlIHBvc3NpYmlsaXR5
IHRvIGNvbXBpbGUgb3V0IHRoZSBmZWF0dXJlIGRvd25zdHJlYW0NCj4+Pj4gaWYgc29tZXRoaW5n
IGdvZXMgd3JvbmcsIHVzaW5nIHRoZSBmaWxlcyB1bmRlciA6IGNvbmZpZ3MvZGV2aWNlcy8uDQo+
Pj4NCj4+PiBTaG91bGRuJ3Qgd2UgdGhlbiBjb21waWxlIG91dCB0aGUgcmVsZXZhbnQgcGFydHMg
b2YgdGhlIFFBUEkgc2NoZW1hLA0KPj4+IHRvbz8NCj4+DQo+PiBJcyBpdCBwb3NzaWJsZSB3aXRo
IEtjb25maWcgb3B0aW9ucyA/DQo+DQo+U2VlIGJlbG93Lg0KPg0KPj4+PiBHaXZlbiB0aGF0IHRo
ZSBJT01NVUZEIGZlYXR1cmUgZG9lc24ndCBoYXZlIGFueSBleHRlcm5hbCBkZXBlbmRlbmNpZXMN
Cj4+Pj4gYW5kIHRoYXQgdGhlIElPTU1VRkQgYmFja2VuZCBvYmplY3QgaXMgY29tbW9uIHRvIGFs
bCBwbGF0Zm9ybXMsIEkgYW0NCj4+Pj4gYWxzbyBwcm9wb3NpbmcgdG8gcmVtb3ZlIGFsbCB0aGUg
Q09ORklHX0lPTU1VRkQgZGVmaW5lIHVzYWdlIGluIHRoZQ0KPj4+PiBkb2N1bWVudGF0aW9uIGZp
bGUgInFlbXUtb3B0aW9ucy5oeCIgYW5kIHRoZSBzY2hlbWEgZmlsZSAicWFwaS9xb20uanNvbiIu
DQo+Pj4NCj4+PiBBbnkgQ09ORklHX0lPTU1VRkQgbGVmdCBlbHNld2hlcmU/DQo+Pg0KPj4gVGhl
cmUgYXJlLiBUbyBleHBvc2Ugb3Igbm90IHZmaW8gcHJvcGVydGllcy4gU3R1ZmYgbGlrZSA6DQo+
Pg0KPj4gaWZkZWYgQ09ORklHX0lPTU1VRkQNCj4+ICAgICAgREVGSU5FX1BST1BfTElOSygiaW9t
bXVmZCIsIFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2LmlvbW11ZmQsDQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgVFlQRV9JT01NVUZEX0JBQ0tFTkQsIElPTU1VRkRCYWNrZW5kICopLA0KPj4gI2Vu
ZGlmDQo+PiAgICAgIERFRklORV9QUk9QX0VORF9PRl9MSVNUKCksDQo+Pg0KPj4gYW5kDQo+Pg0K
Pj4gI2lmZGVmIENPTkZJR19JT01NVUZEDQo+PiAgICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9h
ZGRfc3RyKGtsYXNzLCAiZmQiLCBOVUxMLCB2ZmlvX3BjaV9zZXRfZmQpOw0KPj4gI2VuZGlmDQo+
Pg0KPj4NCj4+Pj4+IFRoZSB1c2Ugb2YgJ2lmJzogJ0NPTkZJR19JT01NVUZEJyBpbiB0aGUgUUFQ
SSBzY2hlbWEgZW5hYmxlcw0KPj4+Pj4gaW50cm9zcGVjdGlvbiB3aXRoIHF1ZXJ5LXFtcC1zY2hl
bWE6IHdoZW4gT2JqZWN0VHlwZSBAaW9tbXVmZCBleGlzdHMsDQo+Pj4+PiBRRU1VIHN1cHBvcnRz
IGNyZWF0aW5nIHRoZSBvYmplY3QuICBPciBhbSBJIGNvbmZ1c2VkPw0KPj4+Pg0KPj4+PiBPYmpl
Y3QgaW9tbXVmZCBzaG91bGQgYWx3YXlzIGV4aXN0IHNpbmNlIGl0IGlzIGNvbW1vbiB0byBhbGwu
DQo+Pj4+DQo+Pj4+IElzIHRoYXQgYWNjZXB0YWJsZSA/DQo+Pj4NCj4+PiBQZXJoYXBzIHRoZSBx
dWVzdGlvbiB0byBhc2sgaXMgd2hldGhlciBhIG1hbmFnZW1lbnQgYXBwbGljYXRpb24gbmVlZHMg
dG8NCj4+PiBrbm93IHdoZXRoZXIgdGhpcyB2ZXJzaW9uIG9mIFFFTVUgc3VwcG9ydHMgaW9tbXVm
ZCBvYmplY3RzLiAgSWYgeWVzLA0KPj4+IHRoZW4gcXVlcnktcW1wLXNjaGVtYSBpcyBhbiBvYnZp
b3VzIHdheSB0byBmaW5kIG91dC4NCj4+DQo+PiBUaGFua3MgZm9yIHJlbWluZGluZyBtZSBvZiB0
aGlzIHBvc3NpYmlsaXR5LiBJbiB0aGF0IGNhc2UsIHdlIHNob3VsZA0KPj4gaW5kZWVkIGF2b2lk
IHJldHVybmluZyBpb21tdWZkIHN1cHBvcnQgd2hlbiAhQ09ORklHX0lPTU1VRkQuDQo+Pg0KPj4g
Q2FuIGl0IGJlIGltcGxlbWVudGVkIGluIHFhcGkvcW9tLmpzb24gd2l0aCBLY29uZmlnIG9wdGlv
bnMgPw0KPg0KPlRoZSBvbmx5IHRvb2wgd2UgaGF2ZSBmb3IgY29uZmlndXJpbmcgdGhlIHNjaGVt
YSBpcyB0aGUgJ2lmJw0KPmNvbmRpdGlvbmFsLiAgJ2lmJzogJ0NPTkZJR19JT01NVUZEJyBjb21w
aWxlcyB0byAjaWYNCj5kZWZpbmVkKENPTkZJR19JT01NVUZEKSAuLi4gI2VuZGlmLiAgWW91ciB1
c2Ugb2YgI2lmZGVmIENPTkZJR19JT01NVUZEDQo+YWJvdmUgc3VnZ2VzdHMgdGhpcyBpcyBmaW5l
IGhlcmUuDQo+DQo+U3ltYm9scyB0aGF0IGFyZSBvbmx5IGRlZmluZWQgaW4gdGFyZ2V0LWRlcGVu
ZGVudCBjb21waWxlcyAoc2VlDQo+ZXhlYy9wb2lzb24uaCkgY2FuIG9ubHkgYmUgdXNlZCBpbiB0
YXJnZXQtZGVwZW5kZW50IHNjaGVtYSBtb2R1bGVzLA0KPmkuZS4gdGhlICotdGFyZ2V0Lmpzb24u
DQoNCkknbSBmcmVzaCBvbiBLY29uZmlnICYgcWFwaSwgYnV0IEkgaGF2ZSBhIHdlYWsgaWRlYToN
ClJlbW92ZSBjb25kaXRpb25hbCBjaGVjayBmb3IgYmFja2VuZHMvaW9tbXVmZC5jLCBsaWtlOg0K
DQpzeXN0ZW1fc3MuYWRkKGZpbGVzKCdpb21tdWZkLmMnKSkNCg0KVGhlbiBpb21tdWZkIG9iamVj
dCBpcyBjb21tb24gYW5kIGFsd2F5cyBzdXBwb3J0ZWQsIHdlIHdpbGwgbm90IHNlZQ0KImludmFs
aWQgb2JqZWN0IHR5cGU6IGlvbW11ZmQiLCBldmVuIGZvciBwbGF0Zm9ybSBvdGhlciB0aGFuIGkz
ODYsczM5MHgsYXJtLg0KDQpPbiB0aG9zZSBwbGF0Zm9ybSBub3Qgc3VwcG9ydGluZyBpb21tdWZk
LCB3ZSBjYW4gY3JlYXRlIGFuIGlvbW11ZmQgb2JqZWN0DQp3aGljaCBpcyBkdW1teSwgYXMgbm8g
b25lIHdpbGwgbGluayB0byBpdCB0byBvcGVuIC9kZXYvaW9tbXVmZA0KDQpUaGFua3MNClpoZW56
aG9uZw0KDQo+DQo+Pj4gV2hhdCBjb3VsZCBnbw0KPj4+IHdyb25nIHdoZW4gdGhpcyByZXR1cm5z
ICJzdXBwb3J0ZWQiIHdoZW4gaXQgYWN0dWFsbHkgaXNuJ3Q/DQo+Pg0KPj4gVGhlIG1hbmFnZW1l
bnQgbGF5ZXIgd291bGQgYnVpbGQgYW4gaW52YWxpZCBRRU1VIGNvbW1hbmQgbGluZSBhbmQNCj4+
IFFFTVUgd291bGQgcmV0dXJuICJpbnZhbGlkIG9iamVjdCB0eXBlOiBpb21tdWZkIg0KPj4NCj4+
IFRoYW5rcywNCj4+DQo+PiBDLg0KDQo=

