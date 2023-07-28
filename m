Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76352766791
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 10:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPIvU-00089p-BF; Fri, 28 Jul 2023 04:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qPIvS-00089h-Ee
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:34:18 -0400
Received: from [192.55.52.136] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qPIvP-0000Tv-LB
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 04:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690533255; x=1722069255;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=edMIntR8LFU6zIbgCzTzc++eHREbW4TlePZfeczaK38=;
 b=MYCh9tONYAbycU7wK1qu9Y1tgN6sBpzkumM+oUqyOv7fCh09l3GA8j7F
 QXhzUPJn8DFuRXpxkQ9yz33Xx1haygEiWTQKfvfagGpHLyKMwrgEqZjsj
 wdqsa5pRO3jnRXmZakv5K+zRecWMVfpcjr+aU4lP0iccmlhNObKg3bEyK
 vn44b6msUPOq550SeaRq3L3vqQFkWlOOsgFcMoXDKVsEV5M17meBDjWkD
 M/wBAexXRvQTIxRPm/5E2PaSl9mvjsSoq9ZQxwlTijHpCG5q48xgYILP8
 7xVaNllwqWnWHNmRYs9PcAb8LON1rdqgwjmbc1mw0KHfnKbvxbqWQop6O w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348143319"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; d="scan'208";a="348143319"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2023 01:34:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="901143982"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; d="scan'208";a="901143982"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga005.jf.intel.com with ESMTP; 28 Jul 2023 01:34:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 01:34:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 01:34:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 01:34:11 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 01:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFMCKAHI8ysP+f593wEL4pEeaTUzuNHuVzPfPrluHkj9oDvRmitP4Y9JWMmK+7N0IJtryhQvYVnUmYVTdeiFS8/hKzZSo8xCnczk2nC0+vCQkDOsJ+7Tm6yk6wafMYa23w2aszjniG0App1T93HOXb33Kyfbc6M2aJi+TKt28A2AtzJ6tRSUzJ3tip8/M2qQcCpcE+Fr4d49dXIrr0pqZjskkLeETFjvfjKj9ISAPTrFpdC0LEJLM5czp3Dz2HvceAFdk/gR24K1iu41jcWg4ljn6MFUHR6SqJjen2kNMj5IrU2De8ptUK/TFrT0L+YRL1TD8GD2Qy5F+8akf3QHeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edMIntR8LFU6zIbgCzTzc++eHREbW4TlePZfeczaK38=;
 b=MJyKHs0U5S1Ml8+PAgNyzkGrkLk4uCyjrFlBHT3U74Ou2UvsFj8yHAtMRgWVqUoHySE1Pb20SfvbRcGEyF/cvK0Q7PCHzB+WccRCc29nkuBsgkZ2acE6HHU4CCCLWdi5kqCXkfUxNjLURcKai5h18XkFc9PK9bFaPHf8RTNQ2YmLnTI68jR+D3uBYMiiV0mU6jIKv/yHzLVMBkzJ77TfkVUs48Je365L6tYh8dvE6IQucO0cZKpBnH21NlrchzcFim7sDyr6yemWvyJK6gEY1LdtAdn4jOQksPfDwSQL7Yc2Uf1mJOu4FbjgQi6S5HSVq5diomCu8m/HOOmpx4sI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 LV8PR11MB8679.namprd11.prod.outlook.com (2603:10b6:408:1f9::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 08:34:09 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:34:08 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Liu, 
 Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Topic: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Index: AQHZwFtnD/lhplXI/0is72NhiwHcDa/N1lcAgAD+laA=
Date: Fri, 28 Jul 2023 08:34:08 +0000
Message-ID: <DS0PR11MB8114B633ED8814B272673415A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
In-Reply-To: <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|LV8PR11MB8679:EE_
x-ms-office365-filtering-correlation-id: 66ca0c55-1d0a-4060-d7ec-08db8f45696c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSccPMVbSfXwtiGhKWp4sPfGZkZErq64pI+UDle3ipxtYmkKbhRmFvg0BLfnexrYVOg5zMSiMHVWLUoqnSs2SntmgqYb7Io0E5VEwNDWSFjzF/DRgv8EAV9boZBoiLXrGxy9lrdtGgI7NJl4CTtKVO6UyxW1lxhsEp3sv/VeBDiE4OPdqIA6PSSTJPYJmhesDJj5Q0lKTlXv/m+4lHya+2345EQPK/k25+1khSJmpvCpcgR2qjtLFyHtWG31UxEQL1i+J/w8z1afdq/UJrLkVHTxXVTioosgr5BOdZNVam1OKOL1e6ZMjKIXZqFhIdWq7PM3V0PmyQHFG2pZYNsiyxciAkhb223xEr8H81X4g+Ivp1iOKBxbeYq0ZYkUZd4dye71rVUJc/v6zDeTU8v5LxKRTSmpCgtULyRmB9mFMIm4HBM9AkfNHpMd1cwOlK4r8fzCS2Mm30ssPkxfN2EBjUeXWi0Icg1eoVBcEl6eSVmRRG3qnQ4kGl7Dk9SheGuSYp6/kTxohhjloy0qvoaqST9lrqQi8uyJGQF1rD3WiPDlDEG0y4RmeDGrT9bIZX4t4Sy1rF0NbP9GmEjJ9FZhmxRSWYKZrq9ZDntjaoRg63DNniGsubzEMdMFSeKERht0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199021)(83380400001)(38070700005)(2906002)(66574015)(86362001)(33656002)(55016003)(38100700002)(122000001)(82960400001)(41300700001)(316002)(4326008)(9686003)(26005)(107886003)(8676002)(8936002)(54906003)(110136005)(7696005)(478600001)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(5660300002)(52536014)(6506007)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTl1NHFrdlVzZHpBeDloaWlUY1lQYW9keHFTVUJweUNaVUloVUc4akZsUytw?=
 =?utf-8?B?NmhpTXdQTFRkSjY3SHNWd1UzMU9jU3Y1bDJtdUF1bytKRHN3Z2dMeGxqcHdq?=
 =?utf-8?B?bFBESi9haGZpZzlKL1ZaZGhWbXBiTFNYdWpzcVZmMC9qOHQrb2VRQ3JvcXBO?=
 =?utf-8?B?bmFqcGROSjBoSGFmS2NHRXRDTGVURVBzbE4yVjdZTk51VTNNM3BDaEU0ZjJM?=
 =?utf-8?B?UkthMTBYc0x4azc1OHh0WWorZ1lyUkxaeXNEdWdlOHhBK0tXanZPd3VYVXF4?=
 =?utf-8?B?YXBuM0lOd3U1cUFGcXJJUW82Wms3ODBqL3hOOFArTmkzaVdHeWNhUXZCS0ZX?=
 =?utf-8?B?SkIyYnpmeDVDOHhQVGdha2pnZzRveitMaXFzdTJZQ08yTzRva1NPdWV3OTRz?=
 =?utf-8?B?NkRTUEdqNWwrclgwU0dyVzJ6eFg1bFQzNnNhQmJjRUpzR0tsSWhlRnFTOWpj?=
 =?utf-8?B?a3VpSGtuSU40TStyMkhkYU5ZbHgxUmVoSTVFbEFEOGFiRjhJQ25RTlhtSC8w?=
 =?utf-8?B?bzZCdHY2Mkg2SVhJMFJKeHo4S3p0dVRIVmJTa3BGUFJQS2kzalp6TGZoLzlw?=
 =?utf-8?B?a3N4U3pqTTgyWktFMzVwb1NhdHo2NVNOSGxZREZCTmVzaHBkQnQ2ZExhWjVn?=
 =?utf-8?B?TGxieTExd0RMU2N3SzQ4ZFl2d0wyMk9sQ0JmOEVmVnNZVnR2K28rZmFyVXpL?=
 =?utf-8?B?MjhrZjZLb3JTQ0R2T3Q5eW1jUjFIK3NoRjRWTStJemtCbHZTMk5hNkowM2ZR?=
 =?utf-8?B?OUxXZWpoa0gyYXR0REd5ZytSNEtmcEhaZnQzeFR0OFhFUzdCeERGOVpLWFpJ?=
 =?utf-8?B?NUxXSlA4U1ZCTGhNTytwMnREUnUyS1I4V1FNQWtacExXQ0J0UFIwOXhjOTZn?=
 =?utf-8?B?eTUzUnVNRi81c1NnWUdkZmplK1NZR1YweDJQcWN6c3pXTXpZSG51aHhCYVI4?=
 =?utf-8?B?eGZaWUhjbUNmUXlKSnRVM3EwenBUUmVLc1pEZG9NUzQ0cllhMnVBcy9tdFph?=
 =?utf-8?B?UzJGZHZwaW1BVjdQSmc1aUc2U1dReWIvTzdFRjI1ckxLUm1acHJNcU1UMXkw?=
 =?utf-8?B?NFBOcXNDUzFHeHQ2UjhhVWpFZE5PNCszYmNjMGlIWWFMaWsrOWV3RTJnVmo0?=
 =?utf-8?B?L2U4ZVphYXBXRkNjUVArYjF4YUc4N2VtMzN6enJWVkhqTXRkd2xSRjdYU1dW?=
 =?utf-8?B?UEY5cVl0dnlZWDlhUGVZOGMzdEJibDZ0Qlc5T0tpYzd6eXZobHpjSmhWVUdJ?=
 =?utf-8?B?SXZqQjVzZVM4WVM5UFZhelNlVzZPNjNBNmFuZE1vN1NKNnZXT2Q3TDhFY3I5?=
 =?utf-8?B?L0VySnFzaEY5eHZjQ1M4VWE1bzQvWFhncVZONkNxaWQwVEF2Sk90T1pFdWg5?=
 =?utf-8?B?SnZXMTg4ODV1SUl1WnBOSml0TitnQWRBZmpJbUltUFdERWpxTTFDR2hJUGxB?=
 =?utf-8?B?aWh0NlRMTlJtdFk0bzNXY1hRT3dqYkEzcEdOdlNjWmtQRGlPQVVaVVYzeVhx?=
 =?utf-8?B?Z3pBdnNiaXZTNTdNbUVZN3p6Zld6NEUvY3pmRVNnaks1N0hPM3RIMEdGZVAr?=
 =?utf-8?B?VDU2eFBqOEdPalo4eGc2cHBadkxjbmsxdjYyazV3UVkrWWl4TGxxcXREVWlN?=
 =?utf-8?B?WDYwKzZ3U0xJNTh1b0pWRTdPSG1YLzlJMTIrOWo2T1RGYzZ5dWVPOEQxaG5u?=
 =?utf-8?B?cVkra1hQTGJLYisxcjl1VUxRWWNpRlZMQkJkenFEZFhzb1drMlBEUVFZcW5L?=
 =?utf-8?B?YWxuUmhxNnMramx5UkFPUHE4b0MxSG56K290VFNBY0NuQnlEazFXbEQvNUha?=
 =?utf-8?B?UERJbHFHQUxmSHZIaVJXOWZOQTg1YUNHQm54a21tZVl3RmJiZzFYNG15Y3dO?=
 =?utf-8?B?NDhsMS9kelV2d1hOUFB4RzhqMmZZaThkTVVGRUp0cTBIamI0c3JqcHBZMVNP?=
 =?utf-8?B?cm1mcjdpZEl0NXErZ0xqVDg5YVFBaVF2SWR5NHdZVCtmZHh4Zm9jRFUxMjZZ?=
 =?utf-8?B?TjBzRlpodlVoc0w0OG8xVjFiWHp5Sk9BeXIwVkdOVWdyRXd5RXFQLzVQYkFi?=
 =?utf-8?B?WXNxMGVWTjYzTmNHb05KOFBKclpELzlrVGJPWnFjQW56ZjJiY1dVTm9nY0wx?=
 =?utf-8?Q?sDB57Uq57UnpGYykegeX+nYqd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ca0c55-1d0a-4060-d7ec-08db8f45696c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:34:08.7138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfjfMvnpYkSVnClcHrE5briQlkQJh1KUBBvoDK+KXdyrh15KoH4gBoDHHHkve49ua6px9IfMiWTTdh7Dku2TJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8679
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.136 (failed)
Received-SPF: pass client-ip=192.55.52.136; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgQy4sDQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHJldmlld2luZyB0aGUgcGF0Y2hlcy4NCg0K
PiBPbiBKdWx5IDI4LCAyMDIzIDEyOjU4IEFNLCBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhh
dC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8gSmluZywNCj4gDQo+IE9uIDcvMjcvMjMgMDk6MjQs
IEppbmcgTGl1IHdyb3RlOg0KPiA+IEZyb206IFJlaW5ldHRlIENoYXRyZSA8cmVpbmV0dGUuY2hh
dHJlQGludGVsLmNvbT4NCj4gPg0KPiA+IEtlcm5lbCBwcm92aWRlcyB0aGUgZ3VpZGFuY2Ugb2Yg
ZHluYW1pYyBNU0ktWCBhbGxvY2F0aW9uIHN1cHBvcnQgb2YNCj4gPiBwYXNzdGhyb3VnaCBkZXZp
Y2UsIGJ5IGNsZWFyaW5nIHRoZSBWRklPX0lSUV9JTkZPX05PUkVTSVpFIGZsYWcgdG8NCj4gPiBn
dWlkZSB1c2VyIHNwYWNlLg0KPiA+DQo+ID4gRmV0Y2ggYW5kIHN0b3JlIHRoZSBmbGFncyBmcm9t
IGhvc3QgZm9yIGxhdGVyIHVzZSB0byBkZXRlcm1pbmUgaWYNCj4gPiBzcGVjaWZpYyBmbGFncyBh
cmUgc2V0Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmVpbmV0dGUgQ2hhdHJlIDxyZWluZXR0
ZS5jaGF0cmVAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEppbmcgTGl1IDxqaW5nMi5s
aXVAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgaHcvdmZpby9wY2kuYyAgICAgICAgfCAxMiAr
KysrKysrKysrKysNCj4gPiAgIGh3L3ZmaW8vcGNpLmggICAgICAgIHwgIDEgKw0KPiA+ICAgaHcv
dmZpby90cmFjZS1ldmVudHMgfCAgMiArKw0KPiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8v
cGNpLmMgaW5kZXgNCj4gPiBhMjA1YzZiMTEzMGYuLjBjNGFjMDg3M2Q0MCAxMDA2NDQNCj4gPiAt
LS0gYS9ody92ZmlvL3BjaS5jDQo+ID4gKysrIGIvaHcvdmZpby9wY2kuYw0KPiA+IEBAIC0xNTcy
LDYgKzE1NzIsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX21zaXhfZWFybHlfc2V0dXAoVkZJT1BDSURl
dmljZQ0KPiA+ICp2ZGV2LCBFcnJvciAqKmVycnApDQo+ID4NCj4gPiAgIHN0YXRpYyBpbnQgdmZp
b19tc2l4X3NldHVwKFZGSU9QQ0lEZXZpY2UgKnZkZXYsIGludCBwb3MsIEVycm9yICoqZXJycCkN
Cj4gPiAgIHsNCj4gPiArICAgIHN0cnVjdCB2ZmlvX2lycV9pbmZvIGlycV9pbmZvID0geyAuYXJn
c3ogPSBzaXplb2YoaXJxX2luZm8pIH07DQo+ID4gICAgICAgaW50IHJldDsNCj4gPiAgICAgICBF
cnJvciAqZXJyID0gTlVMTDsNCj4gPg0KPiA+IEBAIC0xNjI0LDYgKzE2MjUsMTcgQEAgc3RhdGlj
IGludCB2ZmlvX21zaXhfc2V0dXAoVkZJT1BDSURldmljZSAqdmRldiwgaW50DQo+IHBvcywgRXJy
b3IgKiplcnJwKQ0KPiA+ICAgICAgICAgICBtZW1vcnlfcmVnaW9uX3NldF9lbmFibGVkKCZ2ZGV2
LT5wZGV2Lm1zaXhfdGFibGVfbW1pbywgZmFsc2UpOw0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICsg
ICAgaXJxX2luZm8uaW5kZXggPSBWRklPX1BDSV9NU0lYX0lSUV9JTkRFWDsNCj4gPiArICAgIHJl
dCA9IGlvY3RsKHZkZXYtPnZiYXNlZGV2LmZkLCBWRklPX0RFVklDRV9HRVRfSVJRX0lORk8sICZp
cnFfaW5mbyk7DQo+ID4gKyAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAgLyogVGhpcyBjYW4g
ZmFpbCBmb3IgYW4gb2xkIGtlcm5lbCBvciBsZWdhY3kgUENJIGRldiAqLw0KPiA+ICsgICAgICAg
IHRyYWNlX3ZmaW9fbXNpeF9zZXR1cF9nZXRfaXJxX2luZm9fZmFpbHVyZShzdHJlcnJvcihlcnJu
bykpOw0KPiANCj4gSXMgaXQgcG9zc2libGUgdG8gZGV0ZWN0IHRoZSBlcnJvciByZXBvcnRlZCBi
eSBhIGtlcm5lbCAoPCA2LjQpIHdoZW4gZHluYW1pYyBNU0ktWA0KPiBhcmUgbm90IHN1cHBvcnRl
ZC4gDQoNCkkganVzdCByZWFsaXplZCB0aGF0IGlvY3RsKFZGSU9fREVWSUNFX0dFVF9JUlFfSU5G
Tykgd2l0aCBWRklPX1BDSV9NU0lYX0lSUV9JTkRFWA0Kc2hvdWxkIGFsd2F5cyBleGlzdHMgYW5k
IHdvdWxkIG5vdCBjYXVzZSBmYWlsdXJlIGZvciBvbGRlciBrZXJuZWwgcmVhc29uLCBhZnRlciBy
ZWFkaW5nDQpBbGV4J3MgY29tbWVudCBvbiB0aGlzIHBhdGNoLiAoSWYgbXkgdW5kZXJzdGFuZGlu
ZyBpcyBjb3JyZWN0KQ0KDQpTbyB0aGUgcG9zc2libGUgZmFpbHVyZSBtaWdodCBiZSBvdGhlciBy
ZWFzb24gZXhjZXB0IG9sZCBrZXJuZWwgb3IgbGVnYWN5IFBDSSBkZXYuDQoNCkxvb2tpbmcgYXQg
dmZpb19wY2lfaW9jdGxfZ2V0X2lycV9pbmZvKCkgaW4gdGhlIGtlcm5lbCwgY291bGQNCj4gaW5m
by5mbGFncyBiZSB0ZXN0ZWQgYWdhaW5zdCBWRklPX0lSUV9JTkZPX05PUkVTSVpFID8NCj4gDQpT
b3JyeSBJIGRpZG4ndCBxdWl0ZSB1bmRlcnN0YW5kICJpbmZvLmZsYWdzIGJlIHRlc3RlZCBhZ2Fp
bnN0IFZGSU9fSVJRX0lORk9fTk9SRVNJWkUiLg0KSSBzYXcga2VybmVsIDwgNi40IHNpbXBseSBh
ZGRlZCBOT1JFU0laRSB0byBpbmZvLmZsYWdzIGFuZCBsYXRlc3Qga2VybmVsIGFkZHMgaWYgaGFz
X2R5bl9tc2l4Lg0KV291bGQgeW91IHBsZWFzZSBraW5kbHkgZGVzY3JpYmUgbW9yZSBvbiB5b3Vy
IHBvaW50Pw0KDQo+IEluIHRoYXQgY2FzZSwgUUVNVSBzaG91bGQgcmVwb3J0IGFuIGVycm9yIGFu
ZCB0aGUgdHJhY2UgZXZlbnQgaXMgbm90IG5lZWRlZC4NCg0KSSByZXBsaWVkIGFuIGVtYWlsIHdp
dGggbmV3IGVycm9yIGhhbmRsaW5nIGRyYWZ0IGNvZGUgYmFzZWQgb24gbXkgdW5kZXJzdGFuZGlu
Zywgd2hpY2ggDQpyZXBvcnRzIHRoZSBlcnJvciBhbmQgbmVlZCBubyB0cmFjZS4gQ291bGQgeW91
IHBsZWFzZSBoZWxwIHJldmlldyBpZiB0aGF0IGlzIHdoYXQgd2Ugd2FudD8NCg0KVGhhbmtzLA0K
SmluZw0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gPiArICAgIH0gZWxzZSB7DQo+
ID4gKyAgICAgICAgdmRldi0+bXNpeC0+aXJxX2luZm9fZmxhZ3MgPSBpcnFfaW5mby5mbGFnczsN
Cj4gPiArICAgIH0NCj4gPiArICAgIHRyYWNlX3ZmaW9fbXNpeF9zZXR1cF9pcnFfaW5mb19mbGFn
cyh2ZGV2LT52YmFzZWRldi5uYW1lLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZkZXYtPm1zaXgtPmlycV9pbmZvX2ZsYWdzKTsNCj4gPiArDQo+ID4gICAg
ICAgcmV0dXJuIDA7DQo+ID4gICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2ku
aCBiL2h3L3ZmaW8vcGNpLmggaW5kZXgNCj4gPiBhMjc3MWI5ZmYzY2MuLmFkMzRlYzU2ZDBhZSAx
MDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3BjaS5oDQo+ID4gKysrIGIvaHcvdmZpby9wY2kuaA0K
PiA+IEBAIC0xMTMsNiArMTEzLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVkZJT01TSVhJbmZvIHsNCj4g
PiAgICAgICB1aW50MzJfdCB0YWJsZV9vZmZzZXQ7DQo+ID4gICAgICAgdWludDMyX3QgcGJhX29m
ZnNldDsNCj4gPiAgICAgICB1bnNpZ25lZCBsb25nICpwZW5kaW5nOw0KPiA+ICsgICAgdWludDMy
X3QgaXJxX2luZm9fZmxhZ3M7DQo+ID4gICB9IFZGSU9NU0lYSW5mbzsNCj4gPg0KPiA+ICAgI2Rl
ZmluZSBUWVBFX1ZGSU9fUENJICJ2ZmlvLXBjaSINCj4gPiBkaWZmIC0tZ2l0IGEvaHcvdmZpby90
cmFjZS1ldmVudHMgYi9ody92ZmlvL3RyYWNlLWV2ZW50cyBpbmRleA0KPiA+IGVlNzUwOWU2OGU0
Zi4uN2Q0YTM5OGYwNDRkIDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+
ID4gKysrIGIvaHcvdmZpby90cmFjZS1ldmVudHMNCj4gPiBAQCAtMjgsNiArMjgsOCBAQCB2Zmlv
X3BjaV9yZWFkX2NvbmZpZyhjb25zdCBjaGFyICpuYW1lLCBpbnQgYWRkciwgaW50IGxlbiwNCj4g
aW50IHZhbCkgIiAoJXMsIEAweCV4LA0KPiA+ICAgdmZpb19wY2lfd3JpdGVfY29uZmlnKGNvbnN0
IGNoYXIgKm5hbWUsIGludCBhZGRyLCBpbnQgdmFsLCBpbnQgbGVuKSAiICglcywNCj4gQDB4JXgs
IDB4JXgsIGxlbj0weCV4KSINCj4gPiAgIHZmaW9fbXNpX3NldHVwKGNvbnN0IGNoYXIgKm5hbWUs
IGludCBwb3MpICIlcyBQQ0kgTVNJIENBUCBAMHgleCINCj4gPiAgIHZmaW9fbXNpeF9lYXJseV9z
ZXR1cChjb25zdCBjaGFyICpuYW1lLCBpbnQgcG9zLCBpbnQgdGFibGVfYmFyLCBpbnQgb2Zmc2V0
LCBpbnQNCj4gZW50cmllcykgIiVzIFBDSSBNU0ktWCBDQVAgQDB4JXgsIEJBUiAlZCwgb2Zmc2V0
IDB4JXgsIGVudHJpZXMgJWQiDQo+ID4gK3ZmaW9fbXNpeF9zZXR1cF9nZXRfaXJxX2luZm9fZmFp
bHVyZShjb25zdCBjaGFyICplcnJzdHIpDQo+ICJWRklPX0RFVklDRV9HRVRfSVJRX0lORk8gZmFp
bHVyZTogJXMiDQo+ID4gK3ZmaW9fbXNpeF9zZXR1cF9pcnFfaW5mb19mbGFncyhjb25zdCBjaGFy
ICpuYW1lLCB1aW50MzJfdCBmbGFncykgIiAoJXMpIE1TSS1YDQo+IGlycSBpbmZvIGZsYWdzIDB4
JXgiDQo+ID4gICB2ZmlvX2NoZWNrX3BjaWVfZmxyKGNvbnN0IGNoYXIgKm5hbWUpICIlcyBTdXBw
b3J0cyBGTFIgdmlhIFBDSWUgY2FwIg0KPiA+ICAgdmZpb19jaGVja19wbV9yZXNldChjb25zdCBj
aGFyICpuYW1lKSAiJXMgU3VwcG9ydHMgUE0gcmVzZXQiDQo+ID4gICB2ZmlvX2NoZWNrX2FmX2Zs
cihjb25zdCBjaGFyICpuYW1lKSAiJXMgU3VwcG9ydHMgRkxSIHZpYSBBRiBjYXAiDQoNCg==

