Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDEF7DB21D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 03:44:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxIG9-0001zp-IY; Sun, 29 Oct 2023 22:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIG7-0001zS-OF
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:44:07 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qxIG6-0000th-3H
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 22:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698633846; x=1730169846;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YBDWaSDvQBOjZd9ObfSrPuSJO+zmxUjXHRhmbiH4RwI=;
 b=SJEjJ/6Z6UxUtsx7WnP1dI3RsBUJYdVnhXwTlBOYIlUiqMemwUdtGsfE
 JGb/WR1cFA0uwJJs67GeA6GLHtMWDSC1hPF6vZpLqUUCN5hp4UNjamjy1
 Lf0r9lVoaWXRhebfk31sLhZgebPP8+es2AX9w8yPj9bhx15EaRqEpiAdE
 sPZyqDvKo1Y0w8QFBZTebPLORL6mw1rZdH9igD6MJIQJdY+ibiNy7VjmI
 Lbg/LazlvH4upPjLExPqULBPlRzQ4V/N75uN2ifk/VhOTHS42xvbLQEV5
 DH568VpBoIfD4TM16jYztq72DhVxIK3WDHC5Liopmsd/CRcNFpaadMtCf w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="367346794"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="367346794"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2023 19:44:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="1091486615"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; d="scan'208";a="1091486615"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Oct 2023 19:44:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 29 Oct 2023 19:44:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 29 Oct 2023 19:44:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 29 Oct 2023 19:44:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFEgPEpJbRpviArsneP1AYMUw9HqtjVq9TGERlDqw7DNrm84+PfDOG//1qHPZ7IgToQs0EiMbDpLwNeLchrM907CSlTQeXTu54o+RIP3UJSmboxyBT03MUoRubMe7QHYmLZhF5fPMW05QZTfI5GWCOY0+i1FTuHqw1Ihp2+fDtspHPbmlImSqgCEPPhWgZ01p3Mj/j1TBpwHyW0KbTTpuDRvhDvagDxZMTJWhoJNors2fXSWrkgMbNIfak0jbxMNJXDPLcMlaWNcVDJh/3RJOqmZur14cuMa1coC+qLpxsP40x60vLqvNpIZLFAVTOu5nGbcQULJGzakR9zaSn2vFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBDWaSDvQBOjZd9ObfSrPuSJO+zmxUjXHRhmbiH4RwI=;
 b=buSkUgdf254MUwUpYte6/YpxWe7pi8R4R6rioRjilnW2MLpwUzAnsVWAtpm60uHuvIkuVjFs7r472vGQuk3xLsbTu23HOTZi92HKm2CHAfQdjQ4pJypNSWMHFeRl+bpaKxzoHVCf8VBv6IiRBgKstBN2bRlpVKY9HxNs/PKdTnYmZ9gD97bldM5sqKKDS4XBVycr85elywaeX8wQiNoPGb+AWQ7veAKbi8i7IIxBf5oTC1Nkg6MV0shNrYzQspz2JIPXgCciSglZz+UfR3/U7OpUUCHYErKcWXueXcPrH/3IMRtCUuErI8cLAB9DHVxYXmigTfymQzBboRo+WIS4Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7743.namprd11.prod.outlook.com (2603:10b6:208:401::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 02:44:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6933.024; Mon, 30 Oct 2023
 02:44:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 07/37] vfio/container: Introduce a empty VFIOIOMMUOps
Thread-Topic: [PATCH v3 07/37] vfio/container: Introduce a empty VFIOIOMMUOps
Thread-Index: AQHaB/m4kmBuOnHcakibtWfL9SHLiLBdsaKAgAPz61A=
Date: Mon, 30 Oct 2023 02:43:59 +0000
Message-ID: <SJ0PR11MB67446E8BAFECC739CDA9426292A1A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-8-zhenzhong.duan@intel.com>
 <c475bb0c-02be-48d6-8219-0822189c9f2d@redhat.com>
In-Reply-To: <c475bb0c-02be-48d6-8219-0822189c9f2d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7743:EE_
x-ms-office365-filtering-correlation-id: 95a53fe8-c40a-4db7-91e4-08dbd8f2120c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZA9uVLv/XUX5g3svyLw7rtvf6r/xDwcK8fAM7rAEupyXJbGFeSM0/9JyRih0MEsxrTcb1UNL2ITLgU8TQTsDkHVt/kmubvrPKHvRoIe2tR+4Pvn1epSXl1otfIyp0i7aUKP/hPPw32i2vZkoYEgYxJWNJmjXlje/t5kJCl5edrP3zydhWBEUdqGXqM9a7q85jwRNDwuaUHWFDGAzxUGAS6GYbgC4winNRpQpq425lKxe1jBrfIKftZDA/eso2sHdzi06npnw0UtmePKizci+hCNg0LG/1F3U6CWk2UxHf3ufo3vSqnjgQ9MfujVnqCBnYbIjnAQjkcVXr7bcaUmR9d33Y+oTnPPoxnV+3VgWUf83gUurrVN3qHTT5DuqiTnQE3+2/gMy28lBqW2grj5+sqENv085VXOTVgMlIekdrC7/C6Q3dP6mahsspyt+szo8S6VoxTkc5vD2rP88c+Zokq6FS4wWIdm2HKPtYwPPeQKDVtv2raz3UlyqjTJPUbo5VxrVGi1ES48qPjCV5lDqPbd6Cpi2k41OE5ixKQFiudG8BmAou10lUrNEejlzWy3NyEoFoUVkkXazxZvwGhkInamOKSDdalhnZUvTNibIi/cYukgp/I7kbZO7Nu398N9jDu+WhFSQt3o9WOsStP6PLLIt8Atq6suCJ1znUtqXHAA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(186009)(1800799009)(451199024)(55016003)(9686003)(26005)(107886003)(478600001)(7696005)(71200400001)(6506007)(66574015)(2906002)(83380400001)(41300700001)(66556008)(110136005)(66946007)(5660300002)(76116006)(66476007)(8936002)(66446008)(52536014)(4326008)(8676002)(316002)(54906003)(64756008)(38070700009)(38100700002)(82960400001)(122000001)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZndETGpKbVFTUGdsMUJjOUpYMmw2WS84ajNlSExxZDlpOTJqMVlxa1h4UzZC?=
 =?utf-8?B?aU1RQS9weGxUSkFhLzJzelJRaUdaTlNHUmg4OHpVWWdnRXRucnNOUGlCVHV6?=
 =?utf-8?B?UjJYT0VxQk02THVCVnMyYUxHWi9OQnlLU0psQU5WS2NyR292YXUvYTZIMHlm?=
 =?utf-8?B?OGpDYUJPbHB2eCthZ3JMUGdEWW85ckZHVGFvenNwVEg2RFBBbDY3QkV1R3B3?=
 =?utf-8?B?SVFhd3krbERWci9OdVpDdVUzODRSZVZjRjgwc1cvSldjL25tcmF6M3RGcU12?=
 =?utf-8?B?V20zcnVpODFqNm9YWHpLYzdXMmJkbmJsT0hlbllSdjZ4Ry9CcWFJdVpEMGV4?=
 =?utf-8?B?a3Q5YmIxNXo4VU9GbGNwbm9taXdFQk5yUEFKaHQ5N1dXcjR6MTdMaWVKMmtP?=
 =?utf-8?B?ck94L3BhR1Fveis0L3d0a0RaRXlZUEcydlFpU3NBZTlUaEpwcld5Unp2ZVpW?=
 =?utf-8?B?OGxhcHN1RHI1WFI5QitTU3pFQUsvSXUzSkVUZEpsZ0hPWU5sa1NSVllmcDd1?=
 =?utf-8?B?VWFWVnNwQUFHcEtaTFJoUkE0ZHY1d1dxQzdwdjEzRGZ6cXlSV2hDL0svenJh?=
 =?utf-8?B?MnVXaVVUWGlWWmk1K3BML01MeStHN1Q4Q3UyZUtyZ09OZ29tditRR3NBMHpy?=
 =?utf-8?B?Ynk1WDhjWk5McS9Kekl3WEhPLzVFRlREVWNnK3dLZkY4NlBUL000TGN5ZlE5?=
 =?utf-8?B?SFY1OS9RdHRZdXRYZSsyR0JhbTJxejd3bDM3SFVDTzU4N0NJUUNrbmV1K2Zm?=
 =?utf-8?B?T2FMWDUzdW5iYnZnNkF3cEZsN3d3TW5VdkUxMlVYaGIyZ1lIWlQ0V1Zwa1Ey?=
 =?utf-8?B?aVlKTjFzRTFzK0NSeTZWaS9wL3R3cFFyYmo3clpDWHNtdXV3Z3hFV3pwd1g4?=
 =?utf-8?B?NW54S2RCaHZhdEcxS2xZdVI2WmFhaTlBVTdTTjFVT1EzUHRXckJqSW9WRkJa?=
 =?utf-8?B?NlAwZFV1QjRYeWhDN3dQUkFaTWs4TDdwNlp4bmdnODl0dlR4dWNIZjBtbGVJ?=
 =?utf-8?B?ZS85K0V5L0syWkNscFhsZ2NEYmMxdWJkUkpUTmNyakxmUi9LTExmRXVjRW9j?=
 =?utf-8?B?Wm9yQXlHeFpsWHlvS1JzK05tQzRoMVI1R01JN05qOVpGSUJ5c3NxNzBlTmlp?=
 =?utf-8?B?cDNXUFdsOFZvd0UwZG5MdUpPWU9Cck12L3BwV20rMVpSdlNQZVVFNmF4L0FU?=
 =?utf-8?B?enFwZHlTdGNsanNnaDFvWGNMV3c5V0tDY1R6V1Y4VTNlOG8rdzYvaGhqMXA1?=
 =?utf-8?B?UmpQRXlFMnFYMXhsaGFoeEFjOFpEUGdwd0pEVFU3cHBCYlAyNUdpMldWekZD?=
 =?utf-8?B?SFh2Q0E3a1pEOHVXQ0xNem0xMzRCbDE1M201YVpDdXdUdlQxVkNFVWlOMEsx?=
 =?utf-8?B?NStkcEV5Q2VSRW1lMXlyUERDaHBtYWZBWXdKUnVMS1BqbXF3c3FYcW9Ha3dk?=
 =?utf-8?B?czVZakNidndBdGVsTmNEanhKRmpsbHFWUFY2N1JtYk5wSGg3RGswUWxpa2tK?=
 =?utf-8?B?M0Zibks1a21qbUVITjJvelM2N25mWVRPQjJ5TGd4VG9UVFVPOEUwcE9pTi9J?=
 =?utf-8?B?SFBNWlpBb1IyVm5MaTRMbWFSSGY4Wm13R1Q5QlZmYTJUTlhLemxYOTBJVUI3?=
 =?utf-8?B?UFJQSGJCMjNjS09Ec2NSZFlTRTJxd0prQWE2c2tVdGFvaFZHV084R3FZc1Zx?=
 =?utf-8?B?N0dmOXpHRGxVWm1ha2ZselpHVUZOU0NVbDNOL0tHM1dTSGFQZ1BWZUQxMVRT?=
 =?utf-8?B?eVROMDR0VjloVzZTanhpN2ptdVhoamJITXhsT2ROOEFvM2xlTGJmOVVaQXhX?=
 =?utf-8?B?MzFUd3BuckRPK1dmNTMrV2pkcld0d3NSWWFXd3lhbkxVMncvdmlZbkZGNFpv?=
 =?utf-8?B?QUszWmtCMHRxdnliN1NZeWdtYWh2NFdkRmhZL2tzY0JRNlF5N3BQVUZKZ3pm?=
 =?utf-8?B?Zk05K0xnTUxieEI2dTN3K0VBcFY2RWRKUG5YckFjTU1pNlh1d1IzZjN3RGJz?=
 =?utf-8?B?a29MVW14Qmx4ZVVYa0RsQndleXF2ejlCa0VFWTNvanp2VFcvMmNuNjdOTWk5?=
 =?utf-8?B?b0xjRHUzQjdVRmRsbTNja3N4SkFtRGlTbkVyRm1xOW41alhYeEhrT1FmVTFF?=
 =?utf-8?Q?JV+6Z18exEaP8bgRnsDdBD5md?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a53fe8-c40a-4db7-91e4-08dbd8f2120c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 02:43:59.9197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PcFF60y/NVieTUYVGwkcwSUwfZRWcTwTNgXmoj1bb7rRTHc61rrGNi1cSFFJGWYTjRv8NOVuFrfGH17Wr4DPZhPvO32N1cudUJfhb0BKvBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7743
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIE9jdG9iZXIgMjcsIDIwMjMgMTA6MjEg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDA3LzM3XSB2ZmlvL2NvbnRhaW5lcjogSW50cm9k
dWNlIGEgZW1wdHkNCj5WRklPSU9NTVVPcHMNCj4NCj5PbiAxMC8yNi8yMyAxMjozMCwgWmhlbnpo
b25nIER1YW4gd3JvdGU6DQo+PiBUaGlzIGVtcHR5IFZGSU9JT01NVU9wcyBuYW1lZCB2ZmlvX2xl
Z2FjeV9vcHMgd2lsbCBob2xkIGFsbCBnZW5lcmFsDQo+PiBJT01NVSBvcHMgb2YgbGVnYWN5IGNv
bnRhaW5lci4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1v
bi5oIHwgMiArLQ0KPj4gICBody92ZmlvL2NvbnRhaW5lci5jICAgICAgICAgICB8IDUgKysrKysN
Cj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRl
L2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gaW5kZXggZDhmMjkzY2I1Ny4uOGRlZDVjZDhlNCAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9p
bmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTI1NSw3ICsyNTUsNyBAQCB0eXBl
ZGVmIFFMSVNUX0hFQUQoVkZJT0dyb3VwTGlzdCwgVkZJT0dyb3VwKQ0KPlZGSU9Hcm91cExpc3Q7
DQo+PiAgIHR5cGVkZWYgUUxJU1RfSEVBRChWRklPRGV2aWNlTGlzdCwgVkZJT0RldmljZSkgVkZJ
T0RldmljZUxpc3Q7DQo+PiAgIGV4dGVybiBWRklPR3JvdXBMaXN0IHZmaW9fZ3JvdXBfbGlzdDsN
Cj4+ICAgZXh0ZXJuIFZGSU9EZXZpY2VMaXN0IHZmaW9fZGV2aWNlX2xpc3Q7DQo+PiAtDQo+PiAr
ZXh0ZXJuIGNvbnN0IFZGSU9JT01NVU9wcyB2ZmlvX2xlZ2FjeV9vcHM7DQo+DQo+DQo+d2h5IGRv
ZXMgaXQgbmVlZCB0byBiZSBleHRlcm5hbCA/DQoNCkl0IGlzIHJlZmVyZW5jZWQgYnkgdmZpb19j
b25uZWN0X2NvbnRhaW5lcigpIGFuZCB2ZmlvX2F0dGFjaF9kZXZpY2UoKS4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

