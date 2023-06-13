Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8A72D760
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 04:33:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8tpb-0003uX-DB; Mon, 12 Jun 2023 22:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q8tpX-0003uM-LJ
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 22:32:23 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q8tpU-00013G-Ud
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 22:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686623540; x=1718159540;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=x036a8v6lP4bjhhKmphyIrqRrrh5whivcHfP6+5seFw=;
 b=KZtw84VOfERUhaRg2UEMAqoFXjWzHQ3m2Ne9eYwyh3Ry/sK2Bz4GD+09
 Fl+zIqvAmwbGC5aaTfovmKPtPWonCAiYP1/PZI4KMO54dz9dpQhgVl1jN
 UMNbZ/noFmULUEWlmPudQt0Jupc7HT7iprF7y30xV8YYjYGR5J9UJlmDK
 gauKRDcHFzGf4CO9S42cdtBsb1J0ANAIanpBweBTV7RRHPDsZld9gx8n+
 78hdNxfE3iETQMxCHiEVA9wqvsMn5sZKBeVQQBsCmfc4grhyLXBifp4D/
 jPu/6zGOzI5MR7o2OLB/TeWMu0pSxurqN6AkQo1c+Wtkl1F48fa7+237u g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="342900982"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; d="scan'208";a="342900982"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 19:32:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="855913516"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; d="scan'208";a="855913516"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP; 12 Jun 2023 19:32:11 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 19:32:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 19:32:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 19:32:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5GGsmNfUsQlfFUJ1NqRNpz6kIUNEYXGxU7ii5nyLuoUwogBB9EHbDkz5WPql7Myj433yTMXpMnEf+dxhAFewK+vQOnOYhyjdhttjZX0IzbFF0jIAfA4ytOe5JAE5BJkjQR4hxlH1TCkc2wcpAvvL14lOqHfH047BA5eKqjEZWlFHwWM29d1vaKgL2j6jVZXXohYHfW0U6POWhM7OO7YK/MfqFTeqWQ11TkT/zyNlhgPhaMKnbdBjiCVL5iOcDWgGPNtgEGCuVSX0TU/szdpwDicAXY2Qj+uldl3hK++YM3msWpTO5UZEnqclWK2j0BHH5g5b+GSZZpRJ0EB7m8V6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x036a8v6lP4bjhhKmphyIrqRrrh5whivcHfP6+5seFw=;
 b=avnY/aci3p548QxBSPQhe9EJ/5p15jh8lsrz6cwWP/F34HKyrun3LBQDoJbeeSJGQzH+YiLpLHwKLMQtkAlKntrgO9ed4kwZxt3iOEyRBn6B+hG+l3KoR6GzhapKcq7i+ALcD1gjWOzlvGbetINrP/dofPJvUdFvqc3YvfjZ9N+pUDuEu26YtEUy/f5Nk/M5ryV0zNK5SYk4xpwplSFsgsdeZ/7risoaYKAj9xYStMhAMBTECKo9+xyrwJJxpGV9l5GcPcVl4hbi+PlHftTXZF6R5aJS/i+dGpLrJmxNHNM3VJrD2J7AvHHK4IUx57x6+/sMTDzGKSBHED5/MvQfUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW5PR11MB5908.namprd11.prod.outlook.com (2603:10b6:303:194::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 02:32:08 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 02:32:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Thread-Topic: [PATCH v3 4/5] intel_iommu: Fix address space unmap
Thread-Index: AQHZmfDJNompAIYbQUyvLWtPpjv+/K+A68sAgADmDmCAAKkZgIAFj4Ew
Date: Tue, 13 Jun 2023 02:32:08 +0000
Message-ID: <SJ0PR11MB6744098F19348C1C157F527F9255A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-5-zhenzhong.duan@intel.com> <ZIHcEMO2ZWp636t+@x1n>
 <SJ0PR11MB6744928AFD8CCB2C8C78D7959251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZIMq5d1zGnYD9jsu@x1n>
In-Reply-To: <ZIMq5d1zGnYD9jsu@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW5PR11MB5908:EE_
x-ms-office365-filtering-correlation-id: cefafe02-2017-4522-4433-08db6bb6628c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RY677iR3Qm7cAEcICTbGlDPqwT8553bLUES2czxUx7OoDDcic7VqvcXx3vAuZQqbpc2cY5OlqjQFDKAIS48i2QoaKYw7QnV+aYDxWBXkVvr3DVsNUOh8PGMD1vKjJjqi0VQTtTdli7rwYeoc1+oSUp7uJ/03V+JOiox9QgBryNHCnPaZXeUMSyIKhm/ZJoXFpGq0sek6v1DqrnIE2rLsuKt7WPqMjXOLwFdxdWp0SrX7TotlnLgO6gt6rJe6b0JTFGhj+LZNa06Y4Mi9qXN5hz/wQk9RZ74J2qzXO28Z9STNzZUSurQNLjpfvkr9YdhCVRAe6r5ruZs11BGAx1klwceeo+NSKCtsw3utNJMe22LNsJyvHGQ9ShObm3gQ7fw1ANyuzLEkjTnNJHvvxen2F62vMs8vSjinLVkxegb4Rir8sdq6BfWF14+KzEK7kT+jijdodohflWTCA0XM1PeKZTdMLBVU0HHuttwk5AJ5d+0UqukHOvnD4ZYY5N0eQ/+cbzhYWG/PQjIZovKEjDt2Lnm5My/IWqV8AdFh8pWr8pRTkPmoCwXCc1CHR0ToaEs6T4RjTWXpZUnKWDIf+mPxsp+k+5sXaJnBqB5FIwr5y2k8ZdkYXSWzGtDu7axh3XH3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(5660300002)(52536014)(7416002)(8936002)(8676002)(2906002)(76116006)(66946007)(66556008)(64756008)(66476007)(66446008)(4326008)(54906003)(7696005)(71200400001)(107886003)(9686003)(26005)(6506007)(316002)(41300700001)(6916009)(186003)(82960400001)(83380400001)(478600001)(33656002)(38070700005)(55016003)(38100700002)(122000001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlRVajlIT2s4VHNmMnFsSFhqRFhjcWZmZmdiY0U5RTRrQnVBWmRzaUliVVgr?=
 =?utf-8?B?VFF3SmZpZ2dSZ0dIaTRXcmFmT2tLaTFISXZQdVlJVlFCd3F2SUs2SEhqT0JK?=
 =?utf-8?B?WW53TGNWTC9DQ0ZvektKSHYvQ2NCUko4TzRETTlHMU0wbklqdGo2c0poWWNk?=
 =?utf-8?B?UnZDRENxNjFrUUlwMTZRNmJwQUVQd1JPajdIR3htNjl5YjRIUGdvMS82Ykd5?=
 =?utf-8?B?MDRjMEcwdlZpZEpCR01GY1NrS0VYYkRBVlBlSkQzbUxmZjlETThXaDZieG8x?=
 =?utf-8?B?d0NMT2FmZUR1Nlh1VXdZeFBTNEtkdFA5RlNvTmRiSCs0MHBjQ1k1b2FwS0FK?=
 =?utf-8?B?b0hBV25CMUJQK3A1WTdBZm1naC80VG9qeitsUFhUMlJxRzJDWkYwQnpYOXlI?=
 =?utf-8?B?dEJEWnlKUG5KUTU3ZWpJb0VPZFV4eHhBTTU5L3p2dURha21mcnFKUUpqSmpM?=
 =?utf-8?B?eTF3SDMvOGJkR3FWeDNyeHJWMjBTZXM0UHlyNHZXM2RhVVRPWWpPbHgrUlRq?=
 =?utf-8?B?Q0lHaFljUFZoYVF3T1lKbTl5Z0UwUDFXZzQ4TTFnVmFYYU54eE94WXNIWVBH?=
 =?utf-8?B?OEJNNXVlMndsZ0JrV2pwQ0F2d3BqNmtVRXNzdHdJWExFQy9lbDFZSS80OTMy?=
 =?utf-8?B?K1VYSE1tbzhmSVVIeWFtZ0pTNkkybHNjanR4Rkh5R3ZTZkVGaWN1QnprbDZW?=
 =?utf-8?B?TVRleHBnTTk3aVViMjFRMUFoMG1NRnlnakV3Mk10aWpaMytxWTFDejJuSW9z?=
 =?utf-8?B?dU1JNTdEREpubHF4N3lvNUpBUDlUZ0cwNzNLTUZqSFB6WmdrWmh3VlE5eW5z?=
 =?utf-8?B?di9YY3pGdmV2TW9UdEErcHJZWlVvYUdNMWZhZnRYYXVPZDFmRTVkRzR5NFgx?=
 =?utf-8?B?UXl2RGRRNGlKTU8waTVZazhkRnBzMHNLV29zaHo4M0NYNUZOdWRObi9McTY1?=
 =?utf-8?B?M3FDcGc2YU9RWUN6T0Nrb3lSNTkvWFBQNXF4b21kTUV3MWc4enc0bjNRLzdw?=
 =?utf-8?B?emNKaWN4Q3VoenNDOUNBSWtyRkVKUW5MVHkwU21McWlnU2tMcVRvdklGZUZp?=
 =?utf-8?B?TGYrdFZ4U2VmRmQ4b3R6bEl5UENZcU5Lc0VialF0cjUrZnEwWFlyMjJnblNv?=
 =?utf-8?B?c000N0hmSUJvbmlnTnlQdUlWQVpnRnhMaFJzYlZPWlFWRmdjVnZFblN2YUxn?=
 =?utf-8?B?UFVkeklYem5WaU5YSTZhcG5zbUV0OXBIUWR1dEVOeHpocnR1M0wyM0pxWnZn?=
 =?utf-8?B?cnF5NzFGa1RnQVkwSm03Yk5YU1MyL3d3UWZXL3VHSFEvRG5mUlh3dmRWNFp1?=
 =?utf-8?B?M1h4WGRyaStLSEhKNmEybFZhb2JxUTRkcWNFMnpnbjZDaWw4azJoazRKZ3U4?=
 =?utf-8?B?QUw2TFh6Z2VTK1ZCTmVkTjhQQzlseHRKd0Z3S3o5TWZxbmJMekFzWTRVODQ5?=
 =?utf-8?B?MzVPaStOSTdsMkwwR3dYczhNOUtneFNTYUVJN29mWnZWN3JEL0FZMXp5dkxI?=
 =?utf-8?B?Y1ZJcHlmR0p4QTZhbHVLMyt5SnBIOXlYa1Z0MEt0bUR3eGhvTXNQbFNvOGcy?=
 =?utf-8?B?TGFkSnExVzVCSkFSTjdmUnpwNHphZlB0czZBVzQydTRwVExCaExTMTI1MDh0?=
 =?utf-8?B?amx1YTdWMWNoUmdmWU5WZjFtS2MzMUxodWJGTTVpOEdBOWtSNERhcUkxWnpj?=
 =?utf-8?B?NlhaTlVZL2ZEdXBWcjdlcWExSHhyVFh2R3hYcTBTbzJ0aXA4cEhDN2pDdWNv?=
 =?utf-8?B?Wk5pQmtTYUJPMlhlam9QYWhZNkFPM1FlNy9BMGQ0MHZiZ3Fpc0gzZnJaQStT?=
 =?utf-8?B?cW5sYmZla1IzTWh3OXBYYUNZZVlrUXRBaStOYmg0emxQaVhDb3FOUDg1Mnhu?=
 =?utf-8?B?djBPWk9HdDhRc2k5ZXBHSm4yK1ZUS1hWTkMrcStWNW51Qkc4am0yQjhLZTVN?=
 =?utf-8?B?YmdtUTlpMEk2UG5lUFl1U0lRU2xRTWowbm5DcU1qY2JTdWR6S3VwMVM4RWdM?=
 =?utf-8?B?TlMvRG85QjhGNHk3NCtRZUk5bEdDWjdtb1ErUE1jZ0NHK2R1ZWVSdmF1eUU1?=
 =?utf-8?B?bGlISU8rV1ZNbFBtc0IvWHdtaUk1Z0pMbmNuQ1RHTWhYRzVNdjEzc3l5VVBk?=
 =?utf-8?Q?MTOENXjGuQPHAqqLW8tcjT30m?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefafe02-2017-4522-4433-08db6bb6628c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 02:32:08.4126 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4BqWTaUFwq6cVYUJ/byoUdTDPeeH7ncW8M7feKykFyxFpApoTCBiX76rJ139nQvRZR87EywbCUYgnkcGOqtYV66NHhuJL+zrVLCyEG8ZwVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5908
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIEp1bmUgOSwgMjAyMyA5OjM3IFBNDQo+VG86IER1
YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNjOiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPnBib256
aW5pQHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IGVkdWFyZG9AaGFi
a29zdC5uZXQ7DQo+bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb207IGFsZXgud2lsbGlhbXNvbkBy
ZWRoYXQuY29tOw0KPmNsZ0ByZWRoYXQuY29tOyBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGlu
YXJvLm9yZzsNCj5rd2Fua2hlZGVAbnZpZGlhLmNvbTsgY2ppYUBudmlkaWEuY29tOyBMaXUsIFlp
IEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsDQo+Q2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRl
bC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyA0LzVdIGludGVsX2lvbW11OiBGaXggYWRk
cmVzcyBzcGFjZSB1bm1hcA0KPg0KPk9uIEZyaSwgSnVuIDA5LCAyMDIzIGF0IDAzOjMxOjQ2QU0g
KzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+DQo+Pg0KPj4gPi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+PiA+RnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPj4g
PlNlbnQ6IFRodXJzZGF5LCBKdW5lIDgsIDIwMjMgOTo0OCBQTQ0KPj4gPlRvOiBEdWFuLCBaaGVu
emhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+ID5DYzogcWVtdS1kZXZlbEBub25n
bnUub3JnOyBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsNCj4+ID5wYm9uemlu
aUByZWRoYXQuY29tOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOw0KPj4gPmVkdWFyZG9A
aGFia29zdC5uZXQ7IG1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tOw0KPj4gPmFsZXgud2lsbGlh
bXNvbkByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgZGF2aWRAcmVkaGF0LmNvbTsNCj4+ID5w
aGlsbWRAbGluYXJvLm9yZzsga3dhbmtoZWRlQG52aWRpYS5jb207IGNqaWFAbnZpZGlhLmNvbTsg
TGl1LCBZaSBMDQo+PiA+PHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsIENoYW8gUCA8Y2hhby5w
LnBlbmdAaW50ZWwuY29tPg0KPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNC81XSBpbnRlbF9p
b21tdTogRml4IGFkZHJlc3Mgc3BhY2UgdW5tYXANCj4+ID4NCj4+ID5PbiBUaHUsIEp1biAwOCwg
MjAyMyBhdCAwNTo1MjozMFBNICswODAwLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+ID4+IER1
cmluZyBhZGRyZXNzIHNwYWNlIHVubWFwLCBjb3JyZXNwb25kaW5nIElPVkEgdHJlZSBlbnRyaWVz
IGFyZQ0KPj4gPj4gYWxzbyByZW1vdmVkLiBCdXQgRE1BTWFwIGlzIHNldCBiZXlvbmQgbm90aWZp
ZXIncyBzY29wZSBieSAxLCBzbyBpbg0KPj4gPj4gdGhlb3J5IHRoZXJlIGlzIHBvc3NpYmlsaXR5
IHRvIHJlbW92ZSBhIGNvbnRpbnVvdXMgZW50cnkgYWJvdmUgdGhlDQo+PiA+PiBub3RpZmllcidz
IHNjb3BlIGJ1dCBmYWxsaW5nIGluIGFkamFjZW50IG5vdGlmaWVyJ3Mgc2NvcGUuDQo+PiA+DQo+
PiA+VGhpcyBmdW5jdGlvbiBpcyBvbmx5IGNhbGxlZCBpbiAibG9vcCBvdmVyIGFsbCBub3RpZmll
cnMiIGNhc2UgKG9yDQo+PiA+cmVwbGF5KCkgdGhhdCBqdXN0IGdvdCByZW1vdmVkLCBidXQgZXZl
biBzbyB0aGVyZSdsbCBiZSBvbmx5IDENCj4+ID5ub3RpZmllciBub3JtYWxseSBpaXVjIGF0IGxl
YXN0IGZvciB2dC1kKSwgaG9wZWZ1bGx5IGl0IG1lYW5zIG5vIGJ1Zw0KPj4gPmV4aXN0IChubyBG
aXhlcyBuZWVkZWQsIG5vIGJhY2twb3J0IG5lZWRlZCBlaXRoZXIpLCBidXQgc3RpbGwgd29ydGgg
Zml4aW5nIGl0DQo+dXAuDQo+Pg0KPj4gTm90IHR3byBub3RpZmllcnMgYXMgdnRkLWlyIHNwbGl0
cyBmb3IgdnQtZD8NCj4NCj5UaGUgdHdvIG5vdGlmaWVycyB3aWxsIGFsbCBiZSBhdHRhY2hlZCB0
byB0aGUgc2FtZSBJT01NVSBtciwgc28NCj5JT01NVV9OT1RJRklFUl9GT1JFQUNIKCkgd2lsbCBs
b29wIG92ZXIgdGhlbSBhbGwgYWx3YXlzPw0KWWVzLg0KPg0KPkFuZCB0aGlzIGFjdHVhbGx5IHNo
b3VsZG4ndCBtYXR0ZXIsIElNSE8sIGFzIHRoZSBJUiBzcGxpdCBoYXMgdGhlIDB4ZmVlWFhYWFgN
Cj5ob2xlIG9ubHksIHNvIHdoZW4gbm90aWZ5aW5nIHdpdGggZW5kPTB4ZmVlMDAwMDAgKGNvbXBh
cmluZyB0bw0KPmVuZD0weGZlZGZmZmZmKSBpdCBzaG91bGRuJ3QgbWFrZSBhIGRpZmZlcmVuY2Ug
aWl1YyBiZWNhdXNlIHRoZXJlIHNob3VsZCBoYXZlDQo+bm8gaW92YSBlbnRyeSBhdCAweGZlZTAw
MDAwIGFueXdheSBpbiB0aGUgdHJlZS4NCkNsZWFyLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

