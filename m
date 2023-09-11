Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 534FE79A796
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:19:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfewR-0000gN-A3; Mon, 11 Sep 2023 07:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfewC-0000dc-O1
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:18:42 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfew6-0005jB-N3
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694431114; x=1725967114;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=W++iiJacH7RWfOlQlEfg07cxK9VbhDgr84VTJCA5DoY=;
 b=lCHrpIw0T09eOIvBXKW+9PAFE2eTH47zhUURr47bffwQwiFBcC9Y7X/f
 OQUfH9xm8sRa1lXbwKUoWirKcZ67GJQXaRLw1BitmhOQvigZkD9XeXL2I
 ChEzUeUvzRj0oHqinUtHede9f8YFWR+3VBvLKsAaR8D84M0+m9R4LfPM+
 P1Kv/ZLR/hwxAT3aT+1+hQ7mxpW5q8aihpaiPrURYdkm0SVkIXoshXF27
 +p9e4HHFinNgQkp3j7CSCXwr6CYw5H2C5n850EobN4FVSK4B96j5v/zzZ
 DCLM2lU2vGweDopPpl5/o8rRth6/UlyUENF9LRnnKUBI2KTRTl3CHP63G w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="381854381"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="381854381"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 04:18:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="833465179"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="833465179"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Sep 2023 04:18:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 04:18:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 04:18:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 04:18:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOgifIOfenAsNMtYVKormAVEd2Yu5ZWjSKtWgkjjIaWqXujENETmfPFbOPgTuFF+S9p7S0eJLJHJV7L3FqkqP8gzt+n9OxyvHwUYu5Qy10X+Ktp/ZrWMKwPZtAPd+XsIlwvWfZBb9M1JVWKyRps/BqcFedBy1hEdGC4fuHpxU5jH6T028LHvDjn4BIBzI2YLhvsr2yMps9+LI6GbiRh2ynm7eZmEFhVOZVA/KysHqFHFsIV3wgpPh5K1GmQhJf0MQ70yTfc2tkIfJpH++H58pe6BznIMEiRWD9smcKc+pb5sGsBpDfUtTrr6qAZkeOQMIf3tR61POZmwJpwYdaEbyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W++iiJacH7RWfOlQlEfg07cxK9VbhDgr84VTJCA5DoY=;
 b=XVkkoafokoOsSA52ON+CG8oR3WUf4XRkpPjMac4G0himHVkobcjaD5Mj6RcEtBiD1ERogOGwkxJUFp4wuxhz7jAG4OltIqxNU/GxvxhuGsdlf1eNYQw3Ic/OqFMA61TRujn1p6WBeuZ8a9oeTp0pMCFJd7rTQbuoC4TFBG4ieYBE16POX0PoJUkq5xRx0TLTREPZmMKw6R4Mdk2qgdPO+Jylsi7XXpuZjS9pQb7QoHJL/OIXmZzcxAlMPvsf28xoqwsIcKJ1ADz/WaqvkgHn57yV0BCC4czmDP8vDZTQfr0bF6zsFykXxlmsb2uecWWPMkM5mqukQS8CgVQ0YkWh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7035.namprd11.prod.outlook.com (2603:10b6:930:51::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 11:18:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 11:18:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann
 <kraxel@redhat.com>
Subject: RE: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Topic: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Index: AQHZ4tZ5L57QHMgEL06JAtdqYWcKlbAVVWmwgAADeQCAAAcVkIAADWeAgAAMbOA=
Date: Mon, 11 Sep 2023 11:18:26 +0000
Message-ID: <SJ0PR11MB674437C048816AD0CD10108192F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
 <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <83d2de3c-7a3d-4943-d4b5-1f4a86030512@oracle.com>
 <SJ0PR11MB6744CC7FE6F48E7D17ABC3CC92F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <fe912dcb-4080-8ab5-71f5-ce2ed2fae782@oracle.com>
In-Reply-To: <fe912dcb-4080-8ab5-71f5-ce2ed2fae782@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7035:EE_
x-ms-office365-filtering-correlation-id: 99430fff-360b-428e-0a4f-08dbb2b8d1f5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2xskWBj3tY9vF9FOE66OeQ4HUxxNcTHTm6AUHPEZxHI8VLkSVF00fevdwrBl/wqRS7I2/r5xMMobh4aVNV4sDXbBJiKOXhOln68yS7H1lK0/8itvsa53wDk/MHAYIpGnHTy4q+8KfLlRhOmJD1D6DQNIwXLy14Ir2oSUwcscx+3ZgmEPKEaYs6x3rWPhpEW45k196rNu/1H6hJy8JwnANNrr5IeiE+LVOF37Fv3Rtzx9hP+/gDjqD50H4BwESReFG6aTiKQFL6fKS/qzIhTgmVstdvFCVGaSl+kVvwaFW/98yA4siP+9r7H8UOxYZHeVJd5qDh5plY4UvFbVZcIs7iBDMQRfjt32XwMFShLxRnhCJ0Kz0mo1uilalc57WxgOADR7ni18tE2VLRfMxE68+caWO+LFvac0bG/uSvbIpMqDPEoo6WcuzKaRsvkvxQaZ+y/RHIH8pjVyt8ZaEsPC6gtItp90dayWhGcpcG/WtmPKCOQ0FxGIiqTRt4rUnxfGbAD6GC31GK05jLk4G/h2w7WH+COPrUPK3b/ugOdQ/Aw7UefOmNMhkemha+1krbOf8+mNVOEcQ4AhWsozmEjtlF3C6l1N9uiLofCjO/5lr/nrVfil6ukfPYM0AlJKwt6r
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(39860400002)(376002)(396003)(136003)(186009)(1800799009)(451199024)(122000001)(82960400001)(38070700005)(38100700002)(55016003)(86362001)(33656002)(478600001)(2906002)(9686003)(110136005)(71200400001)(316002)(5660300002)(6506007)(4326008)(8936002)(7696005)(8676002)(52536014)(76116006)(66476007)(66556008)(54906003)(66446008)(41300700001)(66946007)(64756008)(83380400001)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG4xMWYxZWw1c0hQUERNekNTOGc3eSsyeVJVUng2TGJrbmZtZEhnSWV1eWpw?=
 =?utf-8?B?aSt3cURsT0xXTmduS3MrcWZwZWlYbmlSd1AvOU5NTjREa040MEM5aDIrakc0?=
 =?utf-8?B?eG9LUjBmUGRZL2I5b2hCYzZTSGRaeTMydXBBY3oxcElneWRqK203SHZGL1E5?=
 =?utf-8?B?VFhEQzZsSllwRkNXRnhDZ21PaEh6Wlo4Z01kYjlVbDRmRGc1cDBqUlR4VEJ6?=
 =?utf-8?B?czFTYUsrZG00YTRlcFFrSmpCNG02YXFWb0FjUWZmUGwwUjg5QXJQQ0wwN1ZV?=
 =?utf-8?B?aGZ3S2lwcWJUOG90QUVNZ2c3YVpPcFhhRVlFaVhxM2tZeHp1T1NQMU9iQldP?=
 =?utf-8?B?cTNEdFJ5SEY3dklNV3BDcjJqMmRGY2V2KzZFZ3ZmV1ZmcnNFM3hoSHoyb0ly?=
 =?utf-8?B?ZUZGYWdoV0J5V0duV0tTdWswN0VuSWVUUWphOUlIUW51b0ZXYWwzSGFWeWZy?=
 =?utf-8?B?T05tbXlKeml6cDJ0U1RXamJnYmNYRGd4Q21vaUZqZTh4c0daU1VHRXV4RkI5?=
 =?utf-8?B?ZHgwZllpRWxrc3REYzFFLzhtd04ybDVZWkZOYUNESzZkT1EvYjdlOU96bzdE?=
 =?utf-8?B?UlNxZ25sYVYzYzFRbGdrT0REK05sVHVaV0JQMmdNVHE5TkduNG4rdFZhRHBV?=
 =?utf-8?B?V1lxeWJaK2FadmN2SkRpS294ZDV0TWJPaVVYam1GMmYwRE9yMzNrYUgyR25P?=
 =?utf-8?B?cEhEbndtSS9TTWQzc0xSaTV1MU1hd3R5R2RCQ0hnOHhvWnhYdHdHWWtZZ1BP?=
 =?utf-8?B?Z1ZDOENYT2hjRzVPUzd0V3Raak96SjBIZmFGVklnUTZsendlL3gyQjhpTmhE?=
 =?utf-8?B?UGp6NEhhRnJ0ZWE0UVVLdmtadThVQXc2WExqWTJMcENRbzVDVVlFSDdTSnp5?=
 =?utf-8?B?LzhkU1BvU3JQajRKMEZFd0s1bnVneGdpRDhHOWlpL0RGblhJeUZpWlpEYlVL?=
 =?utf-8?B?bHcveXJVM2V4US9FVjRhSWdoWS9BRDZuMWZmMmNNNG9oK2tFRjd3SDdLU0c4?=
 =?utf-8?B?T2trSkFXQnk2amhIeUZmcm80MzNnRjZSY1BTVy9tRnAzK0dCblZ1a1Zsc08y?=
 =?utf-8?B?SGxKVkpXOVB1enpsTUxXYm10YlByNTR5bXBaK2tMWDdUMk5MTG9XbDBGYmZv?=
 =?utf-8?B?czBDY0RTclo2ZFlnQ0sxdDl1WFJGK3R0dWxjeTJOZUFvTW50ZHk2T3pES3hw?=
 =?utf-8?B?cjNjRmZuOWJ2U3RyNldrSGtoQ1Z6cjYycXUwRVROQXoyUTc5WGszdmFiNldk?=
 =?utf-8?B?R0FhWk1tTGNhWU5MZEFMVjJmNmFEcE1EVUZBbXdGNElLQ1dHSVJQZnRmUUVq?=
 =?utf-8?B?VnAySkdyaHZJeGF1ZlRvYnBTUEFsd1RLaGsvaU9oTGNyS0owZVZrS2FRY2N1?=
 =?utf-8?B?Q1hGejRMaGQrc2JDNll3Yk5TQmZTNm5VOTVkKzJYdVFnUGJSS3VDNEhPL0F3?=
 =?utf-8?B?Y2NLU0V2Qk41ajdVbjNSRS8xMHFxUDZQNExaa0w5YVhvclNYVUpucWxKM0ow?=
 =?utf-8?B?Yzh4K3ovZlhxRDE5VXVpLzBBR1BZOGhGZDlROUlTWXNRdkRudTZDOTVSR00w?=
 =?utf-8?B?TzE4S203NlJ4b3YzZXhUZFp4S3gzVlhrSG5wbVhEdnBpUndqemwrWUVpYUc5?=
 =?utf-8?B?bGlxK3VYK3RzejZrNFU5Q0JTa0NKdlJyY3h2WTBqUm5CNFJJeXAyUnNuVXFx?=
 =?utf-8?B?bVo3VEYzUHkxallXOUZiZ2dEOEFxZFBwMVZKZ0ZZd2xLM1h6V3VybDkrV1Bk?=
 =?utf-8?B?cEdIc3BSVzFocHB4U0NnRHF1RXA3MHBvOWZ1UW1KMHBxRWV5NlFYTVUwbTFS?=
 =?utf-8?B?Q1E4Y0VlWER6YWVQc2VyQ3hSekpJM3NkY2haNXVyS3ljT0VIZGtYZi9GYjY4?=
 =?utf-8?B?dFo0QlFMWE5CZXZzTkRpUldwRFVyTm55c3VTZnBNWUdEc1lzV0h2ckxjb21R?=
 =?utf-8?B?cUNGcFBjeDVYd0J0bFNpL093NVVTVVd3SVllbENEMjVrTmRWd0dLK05BYlRa?=
 =?utf-8?B?SUxYemI4Y3d0S0Zta1J6VllYdFpIbEZ3NWRlYnZuWlFHUXZBMTZENFBaK2cy?=
 =?utf-8?B?NDdHM2FMZHBrZXBkZlRxT2VDRTFtck9objZyL016Q1ZQRnVqRFRqMDRBNk9s?=
 =?utf-8?Q?I4oUgTEzXPDc3ZK6ngBQyJ3Nu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99430fff-360b-428e-0a4f-08dbb2b8d1f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 11:18:26.9223 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NraUKexGn9gNAq2YRW6LHqj5RKO/V7rSn4svc97oN2QwIRzB9OALrubSYkHsykjA6Tbk70T499oUP7fxoma6fYvVrgn5eXys7AgvsKuHclE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7035
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDExLCAyMDIzIDY6
MjAgUE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBx
ZW11LWRldmVsQG5vbmdudS5vcmcNCj5DYzogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1z
b25AcmVkaGF0LmNvbT47IENlZHJpYyBMZSBHb2F0ZXINCj48Y2xnQHJlZGhhdC5jb20+OyBBdmlo
YWkgSG9yb24gPGF2aWhhaWhAbnZpZGlhLmNvbT47IEdlcmQgSG9mZm1hbm4NCj48a3JheGVsQHJl
ZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MV0gdmZpby9jb21tb246IFNlcGFyYXRl
IHZmaW8tcGNpIHJhbmdlcw0KPg0KPk9uIDExLzA5LzIwMjMgMTA6NDgsIER1YW4sIFpoZW56aG9u
ZyB3cm90ZToNCj4+Pj4+ICtzdGF0aWMgYm9vbCB2ZmlvX3NlY3Rpb25faXNfdmZpb19wY2koTWVt
b3J5UmVnaW9uU2VjdGlvbiAqc2VjdGlvbiwNCj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVkZJT0NvbnRhaW5lciAqY29udGFpbmVyKQ0KPj4+Pj4gK3sNCj4+Pj4+
ICsgICAgVkZJT1BDSURldmljZSAqcGNpZGV2Ow0KPj4+Pj4gKyAgICBWRklPRGV2aWNlICp2YmFz
ZWRldjsNCj4+Pj4+ICsgICAgVkZJT0dyb3VwICpncm91cDsNCj4+Pj4+ICsgICAgT2JqZWN0ICpv
d25lcjsNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgb3duZXIgPSBtZW1vcnlfcmVnaW9uX293bmVyKHNl
Y3Rpb24tPm1yKTsNCj4+Pj4+ICsNCj4+Pj4+ICsgICAgUUxJU1RfRk9SRUFDSChncm91cCwgJmNv
bnRhaW5lci0+Z3JvdXBfbGlzdCwgY29udGFpbmVyX25leHQpIHsNCj4+Pj4+ICsgICAgICAgIFFM
SVNUX0ZPUkVBQ0godmJhc2VkZXYsICZncm91cC0+ZGV2aWNlX2xpc3QsIG5leHQpIHsNCj4+Pj4+
ICsgICAgICAgICAgICBpZiAodmJhc2VkZXYtPnR5cGUgIT0gVkZJT19ERVZJQ0VfVFlQRV9QQ0kp
IHsNCj4+Pj4+ICsgICAgICAgICAgICAgICAgY29udGludWU7DQo+Pj4+PiArICAgICAgICAgICAg
fQ0KPj4+Pj4gKyAgICAgICAgICAgIHBjaWRldiA9IGNvbnRhaW5lcl9vZih2YmFzZWRldiwgVkZJ
T1BDSURldmljZSwgdmJhc2VkZXYpOw0KPj4+Pj4gKyAgICAgICAgICAgIGlmIChPQkpFQ1QocGNp
ZGV2KSA9PSBvd25lcikgew0KPj4+Pj4gKyAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4+
Pj4+ICsgICAgICAgICAgICB9DQo+Pj4+PiArICAgICAgICB9DQo+Pj4+PiArICAgIH0NCj4+Pj4+
ICsNCj4+Pj4+ICsgICAgcmV0dXJuIGZhbHNlOw0KPj4+Pj4gK30NCj4+Pj4NCj4+Pj4gV2hhdCBh
Ym91dCBzaW1wbGlmeSBpdCB3aXRoIG1lbW9yeV9yZWdpb25faXNfcmFtX2RldmljZSgpPw0KPj4+
PiBUaGlzIHdheSB2ZHBhIGRldmljZSBjb3VsZCBhbHNvIGJlIGluY2x1ZGVkLg0KPj4+Pg0KPj4+
DQo+Pj4gTm90ZSB0aGF0IHRoZSBjaGVjayBpcyBub3QgaW50ZXJlc3RlZCBpbiBSQU0gKG9yIGFu
eSBvdGhlciBraW5kYSBvZiBtZW1vcnkNCj5saWtlDQo+Pj4gVkdBKS4gVGhhdCdzIGNvdmVyZWQg
aW4gdGhlIDMyLTY0IHJhbmdlcy4gQnV0IHJhdGhlciBpbiBhbnkgUENJIGRldmljZSBSQU0NCj50
aGF0DQo+Pj4gd291bGQgZmFsbCBpbiB0aGUgNjQtYml0IFBDSSBob2xlLiBXb3VsZCBtZW1vcnlf
cmVnaW9uX2lzX3JhbV9kZXZpY2UoKSByZWFsbHkNCj4+PiBjb3ZlciBpdD8gSWYgc28sIEkgYW0g
YWxsIGZvciB0aGUgc2ltcGxpZmljYXRpb24uDQo+Pg0KPj4gUmFtIGRldmljZSBpcyB1c2VkIG5v
dCBvbmx5IGJ5IHZmaW8gcGNpIGJhcnMgYnV0IGFsc28gaG9zdCBub3RpZmllciBvZiB2ZHBhIGFu
ZA0KPnZob3N0LXVzZXIuDQo+DQo+TXkgb25seSBjb25jZXJuIGlzIHdoZXRoZXIgdGhpcyBpcyBh
bGwgcGFydCBvZiB0aGUgcGNpLWhvbGU2NCBvciBub3QgZS5nLiBpZiB3ZQ0KPmV4cGFuZCB0byBn
ZW5lcmFsIG1lbW9yeV9yZWdpb25faXNfcmFtX2RldmljZSgpIHdvdWxkIHdlIGdvIGJhY2sgdG8g
dGhlDQo+aW5pdGlhbCBidWcgd2hlcmUgd2UgY3JlYXRlIGFuIGVub3VybW91cyByYW5nZS4NCg0K
T2ssIEkgaGF2ZSBubyBpZGVhIGlmIG1lbW9yeV9yZWdpb25faXNfcmFtX2RldmljZSgpIHdpbGwg
YmUgZXhwYW5kZWQgZm9yIG90aGVyDQp1c2FnZSBpbiB0aGUgZnV0dXJlLiBBbnl3YXkgbG9va3Mg
YmV0dGVyIHRvIGtlZXAgeW91ciBjb2RlIGZvciBzZWN1cmUuDQoNCj4gVGhlIGxhdHRlciB0aGF0
IHlvdSBtZW50aW9uZWQgc2hvdWxkIGJlDQo+bWFpbmx5IHZpcnRpby1uZXQgZGV2aWNlcyBhcyBw
cmVzZW50ZWQgdG8gdGhlIGd1ZXN0IChyZWdhcmRsZXNzIG9mIGJhY2tlbmQgaXMNCj52ZHBhLCBv
ciB2aG9zdC11c2VyKSBhbmQgcGVyaGFwcyB0aGV5IGFyZSBhbGwgaW4gdGhlIGhvbGUzMiBQQ0kg
aG9sZT8NCkFncmVlLCB0aGF0J3MgcG9zc2libGUuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

