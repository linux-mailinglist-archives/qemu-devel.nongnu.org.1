Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C173CEA1
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 08:02:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDIp2-0006d7-54; Sun, 25 Jun 2023 02:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDIoz-0006cv-Ok
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 02:02:01 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDIox-00074k-Gu
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 02:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687672919; x=1719208919;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1rcGHvesTXaWaqJE1F1154ruTJIwvfJIJeNrvkHDCSg=;
 b=gTbVhqFgVsNJqNCN/XrJUU5Yb1N8vVgL4CL2XcbzTMCsajTspkOjzkZc
 KO5kEmpPQRLsgw7GSO/peFgSbeZKv9VYzdyocxTo8eGUZepq4bBDweztN
 nUVOqEikn50O3bmXvYeNtmQe2+YexSjQni4o37IyfJdZPchwS77XfdhOT
 txS3FQx5YTT9sfPPuwupJXsR/hVCCvjVl/ZIWrqjGS1bnUpdzt0gdFH+b
 LIpDD0TmjSzVikIKy3zKog2rCWvANRDsPLeshjHAeoyQixEBgSEeXS5H4
 /siK/6/uB7cIeGVAV9/hm329tIQV2kOfHGpZ5et/22W1FzJlLx+cOaMFK w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="424706576"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; d="scan'208";a="424706576"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2023 23:01:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="781029350"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; d="scan'208";a="781029350"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2023 23:01:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 24 Jun 2023 23:01:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 24 Jun 2023 23:01:55 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Sat, 24 Jun 2023 23:01:55 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Sat, 24 Jun 2023 23:01:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=COiycJAgjb+34nVQQF3FvwhufqElypUavMXMRJm0DEAZBoqq9KD9mAhyzBaQ/m9KDDRgy7MZnItOI2I2+egakUuuTEvZRZcsTfdEjMtuNH7abFIQ6T9cGqrj48YqvDFMUv10FQiAH1IdoI0ouo/Wc+9VumvVQC3hV1spHxRAjW/DzRUlbxDiRLTD5FDu0gYFssdDrHCEhMLmRUjdxP4jCWKj7fLCv0xjp2KfSbmcxChgaJKUXH4MPVR7EG/QMQDE2It2yYda4kOp3YGaV2KIWsock2kbTwNuNZLVEOZL5wjo+TAMTUhmhAlYhv4a80ScjaT/vcenFAOu54gFd9RaoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rcGHvesTXaWaqJE1F1154ruTJIwvfJIJeNrvkHDCSg=;
 b=atuNMoe9DmyJynTxkh4eqHWBn5tkJJvHgKR0wnsXcEale4+aO0w4I7XyWh+wPjONUIj5AO4xuIjK9HfiVeXie9424Bj/AGnhxh8zsF++6YCh/OK9fOKzK+quI84KVyT0A9xq1ql/u0GnN+ODOcJOl+IrNrF4j8VCSzn8i64T8lNewpt2Gnq1PrpDLfeqkzPmtAh0/heZbQc1IyRUatIYhvYT0qZ1tdBvlYJB7uqVkNLtcWBL19Srp0jbj4mT4OlEVSb2PBss2jFjgGiFa6exLeXE/gCwoUutmXDvbTQUX0qOCecOx6m3S2eMkN0HrFz/riDxAm2Mbg2aRWGHm3yttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB5458.namprd11.prod.outlook.com (2603:10b6:610:d1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 06:01:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 06:01:52 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 2/3] vfio/pci: Fix a segfault in vfio_realize
Thread-Topic: [PATCH v3 2/3] vfio/pci: Fix a segfault in vfio_realize
Thread-Index: AQHZpBh8P8D/OrtS5EWKxfbUO8IzNa+VGTuAgAXOKUA=
Date: Sun, 25 Jun 2023 06:01:52 +0000
Message-ID: <SJ0PR11MB6744C00029419ED5B1E7CF4A9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-3-zhenzhong.duan@intel.com>
 <6a2dc503-34a2-a129-3932-ab9cd61cf5cf@oracle.com>
In-Reply-To: <6a2dc503-34a2-a129-3932-ab9cd61cf5cf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB5458:EE_
x-ms-office365-filtering-correlation-id: 6f6f4773-d4e7-4d4c-0bb5-08db7541abfa
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qzaVs7d5KVErD105VU+JAdv6P5YS0XlgN4+t1Y+9x5EeNcUY6QeIm3AoQ5YIl4VtN/esJuD4/i74bI8UMfsrtGLY3vK9BOARXnRvk929JECCqixO4bfJ8VGR9lzqvsDAvowEfZ3OWwwGFmoZxcY0TkSnS89Msn3ily2StWuOIxHahWnGARQBneOnWxlGbYDTYOD2lQWRV4v9KkTTpuJJbKQYJ4fx0UOOE2SnKrQTkZypPnCLDIIrSO2+kTs5bb4QjpYovzcwDA21FAJgeHO6mVX5QxQTQSZecfn6VSQEvRF6Be+UQs6AeWukEdLnQPiR95BvyJxIUGCFT/Wa5mQiHU+jZa+rcXA1i7ubfYcu8WFmvZyBMTBbMCrRgmwNrhG6sY2xZmcTnJ+1VdoH1YxLOTmX3uZDaQDp5fMVxYuf5RiB0lSUnbmbeJsDU/Fkbq+uoDPI1NXK8E6dI15Amx0Y+jpyyv/9/UwXibZ2o1ChvlEk8nDabTcXOy+XJoIwYo3/L2lXjVp2Fp3EntG1ckidzSfkkhpFnX3Iqxr1C8uICUb0p0pEIznl4TUGY5NU7m4i8n2yjbnqlw4DqZcMlKFbc8wU0Wc8E+Us+S7cdaYajou6432GcjJNG/pqMhb0sJ1W
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199021)(38070700005)(82960400001)(122000001)(38100700002)(55016003)(86362001)(316002)(6916009)(66446008)(66556008)(66476007)(8936002)(41300700001)(64756008)(76116006)(8676002)(66946007)(4326008)(33656002)(5660300002)(52536014)(83380400001)(107886003)(478600001)(71200400001)(54906003)(7696005)(6506007)(9686003)(186003)(2906002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?elZISWNnNy9QTTZyWjlycG1SLys4MnZmYkdQbWlsQ3I5TnEzTEk0elBFK3FZ?=
 =?utf-8?B?MG91TXlrL3JxdXFYM25STGNzWjZIUUgzR000Tm1IczdUZndjaTFGYTlIVkFv?=
 =?utf-8?B?TlNNTzZqLzRYV1pqNnhVTmtPaWhwajA0L0hPU2ptZ3YvVU1zUHg2TjVRSUNF?=
 =?utf-8?B?dTkwQ01JYmdEbmx1RVlSeU1oSWRRTTZoY1N3NEttdVJiUjNhTlp3QmpTSHdw?=
 =?utf-8?B?d0NWbXQwSTY5QjFLWDh3cFhqeXROaXlKbnQ1M0ErNnRZWlVFeGpUb29DUEk3?=
 =?utf-8?B?bnZISUZzbnJvOXFkTDRiWWo2WHlpWkxkbHlIbTlxYU0vSEwxVTFRUzhXOTdK?=
 =?utf-8?B?eHM5NXJKMnorL3NTR1d5blRRV1cyRklocUtlTHBtblp2d1o1N3ZKUis0RGxp?=
 =?utf-8?B?WDFWclIxUENJMitGZ2RvQmJpeHF4UjBqdERMMHBnWjVuY0JxcThUOHBqZ2cv?=
 =?utf-8?B?WkJHR1FjWGhkWmt1RThQaDRpNnRhZm5LSHlzS01UajF6U0VZL2ozejBNSFNY?=
 =?utf-8?B?YmNRMFp3amZnRTZwU1NQb1BlNW5xNWVOOFFyTmtaTHhZczc0a3NSRzlnVldr?=
 =?utf-8?B?UXAwcEJGblhLQVZqTDRvTVdYWlZ0aGpOczYvakNtcVZ2dXgrc2dmS3BaRzVx?=
 =?utf-8?B?TFBPSTZyaTdQZXBYWmN2WWZFMXJDUTRwVzUxSzZMYkhBZGszTW11VVpjdWxI?=
 =?utf-8?B?OGZFc0FHRG0xWUR2Y0N5eHArNitJWC9udDh4UWFlVGZ0a1NrUEE5VFYxRjBD?=
 =?utf-8?B?K3FVS0lPWnFWL2tXeTJXcGF6OWdkeHQvaktJaGZDYnR0a1BlMFNseGJ4MXph?=
 =?utf-8?B?VDUwWTFSaGVxZWQ1cTM3SzVodmFVWmhkTjBBZkh5V0VxUjhGN0lGTm5OWVRO?=
 =?utf-8?B?dUErSEt6SmJoaGtSRnpoZlM4ZzZFSDJ2emhRakl3dDF1MXVkMDRsRlNBYTlE?=
 =?utf-8?B?L0NsRkh6bklVV090WTN2a2Z6TzI1NWhkWG92K1JVcWVXdnFKSkk0eFVzaDIv?=
 =?utf-8?B?dmhySE5KVHQvZE1mQTVIaWl4QUR4dkxrekI1QlF6bFArMklvSlJKbEpsS0Y5?=
 =?utf-8?B?NDkvZjAwczdwYTdmRmtuK2tJVTgwZjZSUXhYMXcvS2JlZ1V3ZnJUeHJkbURj?=
 =?utf-8?B?bFd4OHd0cUFlOWNsSTU5WHlheU8ycm83aHJmcnB5bFZYL0RQUHZqMmoyZThJ?=
 =?utf-8?B?NWpmMWUrVERZa2t1NHdSazVmSzIrK3QyaVJpRzhsQzJ3OW4xdkJOSmxsSHU3?=
 =?utf-8?B?TFpYNkh1ckIrd0Y0dkRjUW1lYzdJTGFOSE4reU9GSUd5YWpGVUJTWTlKZGNR?=
 =?utf-8?B?b0xYRXArL25ucmMzb1Q2ZjYwUlpoTTBXaFl4QzYxZnppeDBLV1BGWHJXSlUr?=
 =?utf-8?B?VkZmTlBIeGZqQk1sVDZoSldNZUI2SzB6RnZpM3JRclBmSkFEUGFJR01zOE94?=
 =?utf-8?B?bTNZc1lXanlwV29RY3MwNW0wd3B2RFg0dldiTTJnQlJEOFZWTGw4VnVlc3BK?=
 =?utf-8?B?emZnWHZXQ01vV0ZDRk5ISENvT3hGSm9vc3FSV1V6c1gySW8xNzV4QzhjTjZm?=
 =?utf-8?B?OHV4MVJQc3JLZitnaGo2YzdkMWs4QTMvS2tCNTc0MFFTRHhFam5nTDZnVFQ1?=
 =?utf-8?B?RkhaUFFLMlZ0YlZma2RNbVhuWnFHUjRnMnUwQThPTHhac2YzallNN2VSdi9Z?=
 =?utf-8?B?VUdaUnF6L1ljUVdodDBKMjA4VVZ5dWcvS1BWNlE2TG9BbkNNWTZHeXI3eGZ4?=
 =?utf-8?B?ZVFmZjl1eVEySmZYUHNNSGRlOElJQUszbW1BQVNsQjB5UE90WlVSdkNMVHNT?=
 =?utf-8?B?VzV3bzU4b2lRMWtON2FJQ3NsL1NsZVNJZ2ZQZlJpdmUvMzI4a1JqUEQ4WHlP?=
 =?utf-8?B?K0t2S2FrK0J0YzNqczY1WFVKNW9oa3p3clhQaUJEMlpqRnFTc0dDWmJQcFZN?=
 =?utf-8?B?bHMwU1FteVRWcDFOT3BCV3pCYi94b0U0RUZPTURhY2M4UndBMk1XRFFZa3ZU?=
 =?utf-8?B?NDU0a3N2b2VpcnhsZUI5NDZjc3ZDVkFqUk05Y04xcmNWdE5NS2UxU0QrVUxv?=
 =?utf-8?B?MXFwNWRINEhENDU3NUkvUHIvMGJrbzd5VXc2MTNKN0ZNQjUzaU9uTmlrRFVP?=
 =?utf-8?Q?3RUlHazGj2r6B+dQ3EOT+xEi4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6f4773-d4e7-4d4c-0bb5-08db7541abfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2023 06:01:52.1339 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qqvT+PZpRmLppI/7OqwT/8N6Bbfen9HGCaBsIbvROPCUFQpzR+AYjOENDYSkeBhLNL2pRmRJI+Tp0kOUqtcHCNkHgvRsj6FpGjkT9shjqzk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5458
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mga06.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgSnVuZSAyMSwgMjAyMyA3OjA5
IFBNDQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNj
OiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsNCj5hdmloYWloQG52aWRpYS5jb207IFBlbmcsIENoYW8gUCA8Y2hhby5wLnBl
bmdAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8zXSB2ZmlvL3BjaTogRml4
IGEgc2VnZmF1bHQgaW4gdmZpb19yZWFsaXplDQo+DQo+DQo+DQo+T24gMjEvMDYvMjAyMyAwOTow
MiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBJbiBjYXNlIGlycWNoaXBfY2hhbmdlX25vdGlm
aWVyIGlzbid0IGFkZGVkLCByZW1vdmluZyBpdCB0cmlnZ2VycyBzZWdmYXVsdC4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0K
Pj4gLS0tDQo+PiAgaHcvdmZpby9wY2kuYyB8IDQgKysrLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZp
by9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMgaW5kZXgNCj4+IGM3MWIwOTU1ZDgxYy4uODJjNGNmNGY3
NjA5IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9wY2kuYw0KPj4gKysrIGIvaHcvdmZpby9wY2ku
Yw0KPj4gQEAgLTMyMjIsNyArMzIyMiw5IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lE
ZXZpY2UgKnBkZXYsIEVycm9yDQo+PiAqKmVycnApDQo+Pg0KPj4gIG91dF9kZXJlZ2lzdGVyOg0K
Pj4gICAgICBwY2lfZGV2aWNlX3NldF9pbnR4X3JvdXRpbmdfbm90aWZpZXIoJnZkZXYtPnBkZXYs
IE5VTEwpOw0KPj4gLSAgICBrdm1faXJxY2hpcF9yZW1vdmVfY2hhbmdlX25vdGlmaWVyKCZ2ZGV2
LT5pcnFjaGlwX2NoYW5nZV9ub3RpZmllcik7DQo+PiArICAgIGlmICh2ZGV2LT5pcnFjaGlwX2No
YW5nZV9ub3RpZmllci5ub3RpZnkpIHsNCj4+ICsgICAgICAgIGt2bV9pcnFjaGlwX3JlbW92ZV9j
aGFuZ2Vfbm90aWZpZXIoJnZkZXYtDQo+PmlycWNoaXBfY2hhbmdlX25vdGlmaWVyKTsNCj4+ICsg
ICAgfQ0KPg0KPklmIHRoZSBmaXJzdCBwYXRjaCBlbmRzIHVwIGJlaW5nIHB1cnN1ZWQgKHdoaWNo
IEkgYW0gbm90IHF1aXRlIHN1cmUpIGl0IHNob3VsZA0KPmJlIGZvbGRlZCBpbiB0aGUgcHJldmlv
dXMgcGF0Y2gsIGFzIHRoZSBvdXRfZGVyZWdpc3RlciBpcyB1c2VkIHN0YXJ0aW5nIHlvdXINCj5w
YXRjaCAxLg0KU29ycnkgZm9yIGxhdGUgcmVzcG9uc2UsIGp1c3QgYmFjayBmcm9tIHZhY2F0aW9u
Lg0KDQpvdXRfZGVyZWdpc3RlciBpc24ndCBvbmx5IGZvciB2ZmlvIG1pZ3JhdGlvbiwgdGhlcmUg
YXJlIHNvbWUgb3RoZXIganVtcCBzaXRlcyB0byBvdXRfZGVyZWdpc3RlciBpbiB2ZmlvX3JlYWxp
emUuIFRha2UgYmVsb3cgY29kZSBmb3IgZXhhbXBsZToNCg0KICAgIGlmICh2ZGV2LT5kaXNwbGF5
X3hyZXMgfHwgdmRldi0+ZGlzcGxheV95cmVzKSB7DQogICAgICAgIGlmICh2ZGV2LT5kcHkgPT0g
TlVMTCkgew0KICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAieHJlcyBhbmQgeXJlcyBwcm9w
ZXJ0aWVzIHJlcXVpcmUgZGlzcGxheT1vbiIpOw0KICAgICAgICAgICAgZ290byBvdXRfZGVyZWdp
c3RlcjsNCiAgICAgICAgfQ0KDQpJIGNhbiByZXByb2R1Y2UgYSBzZWdtZW50YXRpb24gZmF1bHQg
d2hlbiBob3RwbHVnIGEgdmZpbyBkZXZpY2UgdXNpbmcgYmVsb3cgY21kOg0KKHFlbXUpIGRldmlj
ZV9hZGQgdmZpby1wY2ksaG9zdD04MToxMS4xLGlkPXZmaW8xLGJ1cz1yb290MSx4cmVzPTEgQ29u
bmVjdGlvbiBjbG9zZWQgYnkgZm9yZWlnbiBob3N0Lg0KDQpBZnRlciBmaXg6DQoocWVtdSkgZGV2
aWNlX2FkZCB2ZmlvLXBjaSxob3N0PTgxOjExLjEsaWQ9dmZpbzEsYnVzPXJvb3QxLHhyZXM9MQ0K
RXJyb3I6IHZmaW8gMDAwMDo4MToxMS4xOiB4cmVzIGFuZCB5cmVzIHByb3BlcnRpZXMgcmVxdWly
ZSBkaXNwbGF5PW9uDQoocWVtdSkNCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KDQo=

