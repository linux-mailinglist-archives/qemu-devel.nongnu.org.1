Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4C57A9162
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 06:02:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjAsF-0000lg-MN; Thu, 21 Sep 2023 00:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjArp-0000kI-C8
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 00:00:41 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qjArk-0001uO-Bw
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 00:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695268836; x=1726804836;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jgzWQ46rTvVSXcQ1xQZm6srkxmp25ypsnLvqRAHl884=;
 b=m54kSF8G63KfVPYBeSDV/bkSgVYTdKjsAsTA/XekPSlE2JQMX/YmymN6
 PdmLnMs1dXtNxNTi9DAY/z0e4fY1DkQuiS8i3R0+CVfFfVjP85cZ2Yd5y
 AQ/R0XRelF70Bd2CZZrs1ZM3aBYayT1j9iBi7GyVlrLCl5XMeW+8NXRyG
 /lR8+cP+UCISwNp7gsbJu+XTbZ2k38uXH0fCM2ajeqT3zf+Uv297GSFWL
 xuZEsAncdAnXnryIYXp9RtPEWKOH6Ma1HD6uM84rBJZzhM77QENz8HuQe
 RPZLShTUo87wNtiSrR5UHvXsLG3ZdGIAn/kl3IdJM7t4kzSNm1hXtzP86 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="444513851"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="444513851"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 21:00:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="781976824"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="781976824"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 21:00:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 21:00:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 21:00:31 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 21:00:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcSJWm6St3A5Rm+NGegsRvF4nOehVdcrnQ7D8E4Gr/MPgF/ejzO9KnrJeCfE3V5o+0h6L4Sic2GaN9DVk8YgQK1+tBlOgX1pmv00Khzsngp9WTOc3HN/EM3c+X/yKCoNokK6Z5H9blbvLVWcC/Vw0ZnyVfOl3Lw6eopZ5iceQglqEMKGtpdGg1uhX/A1Y9C+R0Qz2vhGv3aN3yrub2XGGWOqCsUjgOjL1VErU0XJVe57e2tIsREzkTkFUNwaum1vaIlhpt5uuPcMwG0KD6rCob6pIfPjqxcrBvdjyOi00JuIcBKQCmVcuzyV2JGLaZU3J/vqPuzTLTiEsN63bGPomQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jgzWQ46rTvVSXcQ1xQZm6srkxmp25ypsnLvqRAHl884=;
 b=RKnp1L3J9Or4IDQAJrVnVmnbho2mW1UqcmF9RnaYqKqrLlGwYzBtSzv1Bn7QswG2eK8iE7mulH84RFpW6GuF06B4v2z4IxFxHsLeSh1TsPG11Jgo6Kp8dL5VpJu4E99BRznVzjoiE/Q/iqTuD4ZLA5ljNEkbkb2DRUsVq00RDikoYx3ZrRsbqFVzjq0L8JBeLpZFLIbYf+VBvaMDCdy2PUK5K3ZEPmYn9T5sMYm3QQPrCntHDIFw3qOSn7g0AyQ21HGA2+vvZ+pLyy7DDy9lEBdSHckYlCPnGZdvh5OIDva3b057MDvsGmYVEmtRanR3C/tWDqthvjDUcTwR4+O+9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 04:00:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 04:00:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, Thomas Huth
 <thuth@redhat.com>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>
Subject: RE: [PATCH v1 15/22] Add iommufd configure option
Thread-Topic: [PATCH v1 15/22] Add iommufd configure option
Thread-Index: AQHZ2zBBz9BBn8bZBkKAV/2bA/8zjLAigTGAgACtoLCAAJRFAIAACMOAgAADKICAAPevQA==
Date: Thu, 21 Sep 2023 04:00:11 +0000
Message-ID: <SJ0PR11MB6744DEEF136848DFA953259792F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
 <20230920125103.GS13733@nvidia.com>
 <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
In-Reply-To: <20e40fb8-0ce3-eb79-7255-2fefd7a2f657@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6307:EE_
x-ms-office365-filtering-correlation-id: 10ca58cc-9dc3-4e04-0220-08dbba57409b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBQN7/W0IU8uiG22roFMlUXDOC5tpT5V90QzIQ1z7LN5Mvl2N0RgfOo6iRAfsYh04WbcSH4XsWJ40FpWkghpB2q6Tpvmwksv0ZPnNvFHh3Epkgvjh5SKFIrDOzgOlqC2GDA8YQmWgc1MY21/D7YDUSJG/ZLDxxL1S5yVXqz1sky++D66kC5eGTMP3h0rvRaPf8G7HRVPuWULpoRxjvPjCOa6W54G72ScAe+D0ahSrNGBRISv/QNwI8iDqAwJJ5ALbqlbYEXnPQXTGnSSWpdt8utD83dAlUjMbIKHidq6TCqxR6Ipgj/OKhkm0v5d+jeBvm7BiVewwMlOjl6ed4/UYxxFkvGigAKLumqHygHEolPsrimOzk3DanDyKyq8dYqDeRwCHPMvar/Gf86m2/ArbZGv2Q2iICbAG+FyYUsN29GObjsPQvoqLRHwaY/OakAL8XEZByffmRukBC7hmDUC/sFrcY7upY9TFJ1BkYrG5n22Zj8ATptT1ZmnbvlbonoDp+txE6V6dsRt8CLz8rjGDfxZ2gTnZvhGegIOQYeS1I9msG8itDNe8tctFn9GaxR6il9Dmxa4nHSnAsY/LBnDppCgiOXJhnX1XBBzENNdmwUg8sC6Yi7l8/V+pcnQJItH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(186009)(1800799009)(451199024)(38070700005)(478600001)(86362001)(38100700002)(2906002)(7416002)(33656002)(5660300002)(122000001)(83380400001)(52536014)(4326008)(8676002)(8936002)(41300700001)(26005)(71200400001)(66574015)(66946007)(66476007)(54906003)(64756008)(66446008)(66556008)(76116006)(110136005)(82960400001)(316002)(9686003)(7696005)(55016003)(53546011)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L2VmdFZiWG9yaXA4QTBEK0FWZ0pRUWttTHhqWTZsRjMxNktzOHBkbCtUemUv?=
 =?utf-8?B?cFdZdjRBMHB3WXVjZmhlWlg1N3FqWW50TlJadHZrQ0RKMjMzZ0I0WFdJMlhN?=
 =?utf-8?B?bHcyYk5Rd05oQUk5aUZoaDZVd1o4Y0owa0wwdk11cTNlT0JTWkdja2pzWW9B?=
 =?utf-8?B?cE4rUHI1eGphSnBtbkhZUEhGMTg4UFZKSW5rbzI1OUQyd1BNSDN4M3Z5d0lI?=
 =?utf-8?B?ZjFCZDNQdExWYjlzVzh6SGF6d3JSOGxDZER0RUdNNldaWit4QmhEYnZVck1a?=
 =?utf-8?B?SitSN3lwbUIwNkRDZWUyclN2b094eFhSRzFwNUJDKzRFZ2t6cldpbTErdFFi?=
 =?utf-8?B?aFhQWTZpVHNSZ3JiT1ZER085VldGSXBpVnhKUXVJRVhjN1VDY1p1cTVmdlRn?=
 =?utf-8?B?NWpVOU9ORFg4MTd2a212MDIyTkgwV2lobXl0ejk1bzRBT01DSzY3N1VLZk16?=
 =?utf-8?B?TXJYRU5SdytGTUx6ajZ5aEFLWlppU2dEeHFJWHFIQ1gzakt6NUFKR1FxeTFw?=
 =?utf-8?B?RFpvN05heHI0eE9mdmJKOGdSU2xGL08ya1hFTlZ6RGlBU3pkUzBodFRBTUVD?=
 =?utf-8?B?MElwWjZwUituWXRtR3VWSUlEelpoc25VdTkvR2cwUUtjT2RKaUZjVkhNTGlV?=
 =?utf-8?B?RjN0N3BzTzBlOXNyUXdWRVpKY1E5OGJxU1FoVng0aFdhdy9uY2Mrc0dycDla?=
 =?utf-8?B?cXBLZXZKUktMK1BlMnhkbEhDTDg2Q0hmSnYvODRlWmdYOHBwZzZJSlpxTE1r?=
 =?utf-8?B?K1FkSjB6cDVLMld3bzBCL0tjNVl1V1E1RG5ZeW9XSVdDMzMxY2hiNFNVQkhW?=
 =?utf-8?B?NTUyWjk5OGRBUXRieE5CMlZkMEY4SlB3QkFlSVE4Rm5ld0RIc05tekZuZXM1?=
 =?utf-8?B?QjdHS3RlMnE5Um9yZzk5VU1FbjF4Q09yYlhMWFhhUVVhaHFFb3JRd2NGQVBn?=
 =?utf-8?B?eHNPZGdRVHhOUms3ckgrVDBCVEt2cmVkSWJVcVZjN2RYdmtGeGFWem9CZHY0?=
 =?utf-8?B?Wnh5QVAvM3phamRHcFJiR1Y1MWJqclJCVUJ0TVc0K2gzRTlzRG1FVEFkdnJn?=
 =?utf-8?B?OExZSjdVZEszTFdyc3FuTFFqUW02OFBPV1pIWk1KNTIweWh3cWxsTTNINllT?=
 =?utf-8?B?NGYzUkFjQ3d2cGVGZGpIRVd5VVVyNDdCblpHTkRLb2w2bmNuYWc3Ym54Y1F3?=
 =?utf-8?B?Q09kbDZ5cktGelAxWlFUc0h6VnF5NWtQaEk5VTRLNmdEa0tNOFN4a3hjYWMx?=
 =?utf-8?B?UUN2ZXpjdkJONFAxVml6QmJSZkFkOGxCRGNQKzlQZ2Z3bzhVeFUwZ0JPcGRo?=
 =?utf-8?B?OW5MaWVIUncwd3JGbFB2TVltcnk0R3FxUWQyUjFnUEduVGRGbUFQZG5lYkNm?=
 =?utf-8?B?eHdNZ2NDdEY4TG9FdDdSaGVrYVdvQVdUSHVDMGVvRVZ4R2JxZXB6SmNSZ291?=
 =?utf-8?B?UStyV0FHMTV1VU0rSzBvZmVZVjlOc3dGcm5xRitmRDAzS1Z5YlczK2IrYkdW?=
 =?utf-8?B?M2VGMk9maUdPVzJFUjdlMm5aQzdjKytaZnJZYXRvc1NiOVNkUHRqOXpwNUMr?=
 =?utf-8?B?MmMrSE9KNHhLd21SaVVmVjc2ZEM1enk5NHJaYlozWEx0bnF4LzBhUnNxNGQ1?=
 =?utf-8?B?RmNGbm1FYlJLSXFBZVVaWUJXUFVTRFV2RkpkbTNhWGZ4ejFwdVdOMUlpaDls?=
 =?utf-8?B?YWFTK09nVjlSbzJ2SUloeDlJeU1qaXFtTnZLTWZQWDdmVjM2Zyswa01UY3pi?=
 =?utf-8?B?OElFRE44WTl4SmUyNmtqMCtCVmdhaFRtQTVFTmIzaWt4OXVFakM2ZnNvWkda?=
 =?utf-8?B?enBDeDVWcFBudDh0elpDT3BJaUlUMjhQV3JDY2VZR0d0R2FFWTM3TG1PTVRT?=
 =?utf-8?B?bXdIakxwV3dqN3FneW0wSDU5ZGFPVk1kMVJ1VGc5Y3dhaCtidS9YM1EyWmdC?=
 =?utf-8?B?bVMrakpDUy95NzlaOTRLUWlmOXZuQVFMcDM1Umw4YUNIYmVuaFozd2NQalJK?=
 =?utf-8?B?NWcvUkdqUWd3ZXh3YXMrcXp6Szl1STlJNHYyL3Zvd2IyRjZXMFJmRHFudURh?=
 =?utf-8?B?dGdVMUtzMmREYUtRbTV1dW5YdllTbEhyeTVsbnBYMUZhTHlUZUhPRFJLSFhD?=
 =?utf-8?B?RzlTR1B3SGJiUkVIVnRHL0Z4clZpbnIvemQrd2srQUNNbnpjNk5Kei8wdndo?=
 =?utf-8?B?M2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ca58cc-9dc3-4e04-0220-08dbba57409b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:00:11.1333 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LkxSB6YKwTQYp5ktDPro3m9RQCqzM8g4nX8t2K8wp7TO6+xs5VwnpG3/WUwLNa0t7MfF88iXllUmu6fpqsXumPmwdxYoQmDgtkXcsfu74tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA5
OjAyIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxNS8yMl0gQWRkIGlvbW11ZmQgY29uZmln
dXJlIG9wdGlvbg0KPg0KPk9uIDkvMjAvMjMgMTQ6NTEsIEphc29uIEd1bnRob3JwZSB3cm90ZToN
Cj4+IE9uIFdlZCwgU2VwIDIwLCAyMDIzIGF0IDAyOjE5OjQyUE0gKzAyMDAsIEPDqWRyaWMgTGUg
R29hdGVyIHdyb3RlOg0KPj4+IE9uIDkvMjAvMjMgMDU6NDIsIER1YW4sIFpoZW56aG9uZyB3cm90
ZToNCj4+Pj4NCj4+Pj4NCj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+PiBG
cm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4+PiBTZW50OiBXZWRu
ZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyAxOjA4IEFNDQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BB
VENIIHYxIDE1LzIyXSBBZGQgaW9tbXVmZCBjb25maWd1cmUgb3B0aW9uDQo+Pj4+Pg0KPj4+Pj4g
T24gOC8zMC8yMyAxMjozNywgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4+Pj4gVGhpcyBhZGRz
ICItLWVuYWJsZS1pb21tdWZkLy0tZGlzYWJsZS1pb21tdWZkIiB0byBlbmFibGUgb3IgZGlzYWJs
ZQ0KPj4+Pj4+IGlvbW11ZmQgc3VwcG9ydCwgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPj4+Pj4NCj4+
Pj4+IFdoeSB3b3VsZCBzb21lb25lIHdhbnQgdG8gZGlzYWJsZSBzdXBwb3J0IGF0IGNvbXBpbGUg
dGltZSA/IEl0IG1pZ2h0DQo+Pj4+DQo+Pj4+IEZvciB0aG9zZSB1c2VycyB3aG8gb25seSB3YW50
IHRvIHN1cHBvcnQgbGVnYWN5IGNvbnRhaW5lciBmZWF0dXJlPw0KPj4+PiBMZXQgbWUga25vdyBp
ZiB5b3Ugc3RpbGwgcHJlZmVyIHRvIGRyb3AgdGhpcyBwYXRjaCwgSSdtIGZpbmUgd2l0aCB0aGF0
Lg0KPj4+DQo+Pj4gSSB0aGluayBpdCBpcyB0b28gZWFybHkuDQo+Pj4NCj4+Pj4+IGhhdmUgYmVl
biB1c2VmdWwgZm9yIGRldiBidXQgbm93IFFFTVUgc2hvdWxkIHNlbGYtYWRqdXN0IGF0IHJ1bnRp
bWUNCj4+Pj4+IGRlcGVuZGluZyBvbmx5IG9uIHRoZSBob3N0IGNhcGFiaWxpdGllcyBBRkFJVUku
IEFtIEkgbWlzc2luZyBzb21ldGhpbmcgPw0KPj4+Pg0KPj4+PiBJT01NVUZEIGRvZXNuJ3Qgc3Vw
cG9ydCBhbGwgZmVhdHVyZXMgb2YgbGVnYWN5IGNvbnRhaW5lciwgc28gUUVNVQ0KPj4+PiBkb2Vz
bid0IHNlbGYtYWRqdXN0IGF0IHJ1bnRpbWUgYnkgY2hlY2tpbmcgaWYgaG9zdCBzdXBwb3J0cyBJ
T01NVUZELg0KPj4+PiBXZSBuZWVkIHRvIHNwZWNpZnkgaXQgZXhwbGljaXRseSB0byB1c2UgSU9N
TVVGRCBhcyBiZWxvdzoNCj4+Pj4NCj4+Pj4gICAgICAgLW9iamVjdCBpb21tdWZkLGlkPWlvbW11
ZmQwDQo+Pj4+ICAgICAgIC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAwOjAyOjAwLjAsaW9tbXVm
ZD1pb21tdWZkMA0KPj4+DQo+Pj4gT0suIEkgYW0gbm90IHN1cmUgdGhpcyBpcyB0aGUgY29ycmVj
dCBpbnRlcmZhY2UgeWV0LiBBdCBmaXJzdCBnbGFuY2UsDQo+Pj4gSSB3b3VsZG4ndCBpbnRyb2R1
Y2UgYSBuZXcgb2JqZWN0IGZvciBhIHNpbXBsZSBiYWNrZW5kIGRlcGVuZGluZyBvbiBhDQo+Pj4g
a2VybmVsIGludGVyZmFjZS4gSSB3b3VsZCB0ZW5kIHRvIHByZWZlciBhICJpb21tdS1zb21ldGhp
bmciIHByb3BlcnR5DQo+Pj4gb2YgdGhlIHZmaW8tcGNpIGRldmljZSB3aXRoIHN0cmluZyB2YWx1
ZXM6ICJsZWdhY3kiLCAiaW9tbXVmZCIsICJkZWZhdWx0Ig0KPj4+IGFuZCBkZWZpbmUgdGhlIHZh
cmlvdXMgaW50ZXJmYWNlcyAodGhlIG9wcyB5b3UgcHJvcG9zZWQpIGZvciBlYWNoDQo+Pj4gZGVw
ZW5kaW5nIG9uIHRoZSB1c2VyIHByZWZlcmVuY2UgYW5kIHRoZSBjYXBhYmlsaXRpZXMgb2YgdGhl
IGhvc3QgYW5kDQo+Pj4gcG9zc2libHkgdGhlIGRldmljZS4NCj4+DQo+PiBJIHRoaW5rIHRoZSBp
ZGVhIGNhbWUgZnJvbSBBbGV4PyBUaGUgbWFqb3IgcG9pbnQgaXMgdG8gYmUgYWJsZSB0byBoYXZl
DQo+PiBsaWJ2aXJ0IG9wZW4gL2Rldi9pb21tdWZkIGFuZCBGRCBwYXNzIGl0IGludG8gcWVtdQ0K
Pg0KPm9rLg0KPg0KPj4gYW5kIHRoZW4gc2hhcmUgdGhhdCBzaW5nbGUgRkQgYWNyb3NzIGFsbCBW
RklPcy4NCj4NCj5JIHdpbGwgYXNrIEFsZXggdG8gaGVscCBtZSBjYXRjaCB1cCBvbiB0aGUgdG9w
aWMuDQo+DQo+PiBxZW11IHdpbGwgdHlwaWNhbGx5IG5vdCBiZSBhYmxlIHRvDQo+PiBzZWxmLW9w
ZW4gL2Rldi9pb21tdWZkIGFzIGl0IGlzIHJvb3Qtb25seS4NCj4NCj5JIGRvbid0IHVuZGVyc3Rh
bmQsIHdlIG9wZW4gbXVsdGlwbGUgZmRzIHRvIEtWTSBkZXZpY2VzLiBUaGlzIGlzIHRoZSBzYW1l
Lg0KDQpUaGVyZSBhcmUgdHdvIHNsaWdodCBkaWZmZXJlbmNlczoNCg0KMS4gRGlmZmVyZW50IGdy
b3VwOg0KJCBsbCAvZGV2L2t2bQ0KY3J3LXJ3LS0tLSsgMSByb290IGt2bSAxMCwgMjMyICA55pyI
IDE4IDE0OjIzIC9kZXYva3ZtDQokIGxsIC9kZXYvaW9tbXUNCmNydy1ydy0tLS0gMSByb290IHJv
b3QgMTAsIDEyNCAgOeaciCAxMiAxNDoxNCAvZGV2L2lvbW11DQoNCjIuIERlZmF1bHQgY2dyb3Vw
IGRldmljZSBhbGxvd2VkIGxpc3Q6DQojY2dyb3VwX2RldmljZV9hY2wgPSBbDQojICAgICIvZGV2
L251bGwiLCAiL2Rldi9mdWxsIiwgIi9kZXYvemVybyIsDQojICAgICIvZGV2L3JhbmRvbSIsICIv
ZGV2L3VyYW5kb20iLA0KIyAgICAiL2Rldi9wdG14IiwgIi9kZXYva3ZtIg0KI10NCg0KQnkgZGVm
YXVsdCwgbGlidmlydCBjcmVhdGVzIHFlbXUgaW5zdGFuY2Ugd2l0aCB1c3IvZ3JvdXAgbGlidmly
dC1xZW11L2t2bQ0KU28gcWVtdSBoYXMgcGVybWlzc2lvbiB0byBvcGVuIC9kZXYva3ZtLCBidXQg
bm90IGZvciAvZGV2L2lvbW11Lg0KDQpXaGVuIGEgZ2VuZXJhbCB1c2VyIHdhbnRzIHRvIG9wZW4g
L2Rldi9rdm0sIGl0J3Mgbm90IHBlcm1pdHRlZDoNCg0KZHVhbkBkdWFuLXNlcnZlci1TMjYwMEJU
On4kIHFlbXUtc3lzdGVtLXg4Nl82NCAtYWNjZWwga3ZtDQpDb3VsZCBub3QgYWNjZXNzIEtWTSBr
ZXJuZWwgbW9kdWxlOiBQZXJtaXNzaW9uIGRlbmllZA0KcWVtdS1zeXN0ZW0teDg2XzY0OiAtYWNj
ZWwga3ZtOiBmYWlsZWQgdG8gaW5pdGlhbGl6ZSBrdm06IFBlcm1pc3Npb24gZGVuaWVkDQoNClRo
YW5rcw0KWmhlbnpob25nDQo=

