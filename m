Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C09867A91D1
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 08:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjDUC-0005Me-WC; Thu, 21 Sep 2023 02:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qjDUA-0005MA-K9
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:48:26 -0400
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qjDU8-0005Sc-Sm
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 02:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695278904; x=1726814904;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o5rP0cJT2c51UmHd9Se24ppN/uX+wz0b9EBuI3DpHDk=;
 b=Y3PvGfz0GnyhPgPZo4uw01rDeLeMjxYAj7HlE5zOmNo477DynvnMtzDh
 0HkfnwQFJx3TYjQq6K2VTughLIBwetDAAE6mqm3sZwb/w+/8HWBAQiOH8
 /5IfIkT7yTMZNSGXujsi8OggTmR3ZElK18HkPqlcfsT+nFk47WMYCQ6oF
 1CudGrrcRS9fVxsdCnhGTmoDtBANZdVvETZeBYMFvQsbEVeCxEqhU0W+X
 EUsveI8D3O84xtwU56Y12BX1M6t1CuzxHY0LLBiaUuyuzlMqHgJAASLJx
 iSq0RzYUiXXWwFciBJSXj1P+oNpHbOxZdK0xjL6lAGnJ/Io1h6zATXfyu A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="411386575"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="411386575"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 23:48:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="890250754"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="890250754"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 23:47:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:48:21 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 23:48:21 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 23:48:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 23:48:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJIs6ToWxqBFMUugqJH7SA9tuE1bImKj6kgF0JA3hUlBzYyJAeFwsei1izFokUFhkbirqd+UAyVgRLMfFtO/AvxItqZ1X17OhDRrSI4MU9uf96N96dxlDihk6bP2tQRaZ728iEGqO5jReUNlLDQMEBYz9Q44Bpd6isWUAK9Rlp2TWTdZPgJH5bO0BJEHB/R8qCEBefQSus8Nd+Tu/oMk9Ds0fo2bR0UGr++vZv8RLpjBvb9emiQRNrWaSXYFw0b510hjS4yFpkmHyLrcmyo8iP8jjIMwRV0nvK8RzCaO3kZmL8AoctfRuqa3Fqn8YHZu5mpJQpgEXdY6oHRduIcsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5rP0cJT2c51UmHd9Se24ppN/uX+wz0b9EBuI3DpHDk=;
 b=DxRTS/xFVbftNagurZlaj70VjhTROXURdPxdeVvA74os1h26YugLh9MMDaJ4LLDtvoTIIukCeCBY5ymSdklusdy1gsI2nFTurwwYxcxTH+2cFRpBiEjXDdWSIRQ6vLwMmfUhnp3n+p5qsuihy0aTCsx02tMq6l6qY9R5jzAD0luS+65u1XTRyqJKtivnU7JJUBvXWRvmY7EjTWaSBT5mvczW2sopoA/yHmhnnWFrJAhxHC4+F83PGdbFrDlcVVQMOrzYbJ/fxyduXzeOpRjtD3MN6GLjw6nqP5NEnfdJ9UkQx9vskMcFP3EJPKOsn5t6k61DYO+vRcrxa5jdcNDpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 BN9PR11MB5481.namprd11.prod.outlook.com (2603:10b6:408:102::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 06:48:19 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 06:48:19 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v2 4/4] vfio/pci: enable MSI-X in interrupt restoring on
 dynamic allocation
Thread-Topic: [PATCH v2 4/4] vfio/pci: enable MSI-X in interrupt restoring on
 dynamic allocation
Thread-Index: AQHZ6hTqoyUBVywWrkuX0F3oU2dGJbAiRauAgAKUvFA=
Date: Thu, 21 Sep 2023 06:48:18 +0000
Message-ID: <DS0PR11MB8114E45C81AA0E2C182388F0A9F8A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230918094507.409050-1-jing2.liu@intel.com>
 <20230918094507.409050-5-jing2.liu@intel.com>
 <51e23d99-3077-3884-b79e-fce5605d1ca2@redhat.com>
In-Reply-To: <51e23d99-3077-3884-b79e-fce5605d1ca2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|BN9PR11MB5481:EE_
x-ms-office365-filtering-correlation-id: 89bf42f0-e9f0-4c9c-a56e-08dbba6ebd34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YSx+BG5OWuIexysQv0wy0Rw0PYaK8FpSYVL7o0YVJeG46Omwr/70eJGiLS99Q2VaSQSt0aXmKlzV1KwaGDxp0MsHIcJCG/EfZGfN/OOexnqkIwQ9PHwaS0CmpAeyGNjlEo+utCgeeunnoNZ4a5DBCb4r2LuRwhSRrxIYYVkoYlRl9IkkjzWDGM7aWWpaA+CXJQoWNY4bsVVkAFNRcOsIxx1EP28Kant+v9STAxtlmCdoZEWI0n/BIuLzp41ZvK6QckGkqyNMVgCGg9McfL3Uz3HD/tFWRgqGl/+Fy+tHd/UZ1nMBxTcYM4gRRp2eSWTdL0xLsDUkJVnF9l2klqjRt50Vl5RhWErZmGKKR0an4bguivKhYHrypH6KWzbATIRUcxS0AYsw0ZvEaPaYgEA8ymH++08lf9WvX0MPw8o8kEv+SGi5Dlp3+FpkZC5/JCO9WJ+LAna8M1mys9mMsj7l9CAO/f20nR+NTOjJUNw+vnPm9lRr/7mRlKBZqH3GIwMp54rJZQVNp0HGFNZxDiFmk9ZL7eU1YuMrpWqDZUg+1eT8zVWusKZRDU4ksfK5GV7Tw2PFVZyUycfaN/XnKdIPsBOh2Bh0RCXC2VWbWQDQaV96Gfr4BIQZEqiU+wXoFLWFaZbmv8ccaGCe3Z8b9w3u2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(186009)(1800799009)(451199024)(6506007)(71200400001)(53546011)(478600001)(4326008)(7696005)(82960400001)(38070700005)(38100700002)(122000001)(55016003)(33656002)(86362001)(8676002)(2906002)(66574015)(9686003)(83380400001)(76116006)(26005)(8936002)(41300700001)(110136005)(52536014)(5660300002)(66446008)(66476007)(64756008)(66556008)(66946007)(54906003)(316002)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUczRXVMeUdrVW5sT29yVzlSN0grK3BFOFpwN1VBZkxETkk0aEZRT1dXOVNO?=
 =?utf-8?B?ZEc5MkJmTTVHZTRPRlpoQjFMNFlmWEFxUm5laHdKQTBuSFcyZlNON2wyQmhL?=
 =?utf-8?B?MXFoTENhM0JnZlpLNTNTV05WOFN5Ti9oa1E5ZDUwZjkvdjNtOExPbThsQ3Nj?=
 =?utf-8?B?ZndzNkZzNWlxZHE3eklwYWhVN1JJOVN4SXpweDgyNGR1b1VTdkJBeXpHTC82?=
 =?utf-8?B?MVNFZnFmdEU4L3NxOEM1S1dOdnlETFNPZUkrVytsTVdtSnFnbDF3V1h5Z0I0?=
 =?utf-8?B?STRWckJoMlU5cWQ4cmcvQ3FxMzQwYVVCZFBXcjlhMVM2WVBWRFZoZnZaTm5z?=
 =?utf-8?B?M05kMGVvOHdaSkx4UzBSeVQzam9TWThHWEc2Y2ZIUExTWmYySTA3Syt0Q3Rt?=
 =?utf-8?B?Zm1MQk81S0EvVWVDK0I4d21ESkZrdVZZVlVmbFVBLzc1N21LN1lJd2RaSUgx?=
 =?utf-8?B?Z0lQK1lwTkZtbTAzWVhRVFFTUU9PWXpLSnBuWnA0RWRGZ2VBR1N0VUF0QmpN?=
 =?utf-8?B?amlOa095WmZwc2Q5VzI0OTFIS0xPVEdtdldiTkZlMUVHUElmWTJkY090RUhi?=
 =?utf-8?B?M0k2aUJNamNLbEtra1F1Ymw2QzRyZjN3RjJYSzJoSGtKVGVlclN4eEVRemdx?=
 =?utf-8?B?dUdzdUc3cjdwMTIzUkpTOW50bFpjV0NtOWdPc2xtVWFUay9OMzE2ek44TmtD?=
 =?utf-8?B?WFlyY2Rwdld0dmgyWEQ3aVcyN1ZPR2tnUjFLbm9EdzAzdFZiOVV0NXgvQ0pi?=
 =?utf-8?B?aVhZSURVMU8zMzY1SmJ0N2crNVExNk5YS2V0R0JYOHRmTVh0SUgxMnJjYVNS?=
 =?utf-8?B?NXVhbWNwZXNKSWlQM2RvaDd4eHI3NVZFbnNTR3UzUEZJZXdqVy9WNlZmWTkx?=
 =?utf-8?B?ZHZ3ckpKUFRjcXA3dXNXTHU2UnA0TWkxMXFtZVpPRU5IMERtTWlNczNMdzFE?=
 =?utf-8?B?cWxzOHNYeHZPNUpERzliZ1Ricm1Zdkk1Y3NrK0RQRHJDOXJTRHB1MmZYdnQ2?=
 =?utf-8?B?RGIxZDZLaCt6TUdJRFRDMU9SKzV6dEZqVGRKUUlxN3JESEpxOE5kNndKR0g2?=
 =?utf-8?B?UU9aSS9XSC9PL1F0SlN3eWF5L1Y0MDNXZE9LQU54N0J0UDRsaUY4NnF4U0FJ?=
 =?utf-8?B?ZHE2RHF4QkxkakFGeHQ5MGZGc0NWTjRmMDVoSjJTd1YzOExGYzBkeWpKSmNR?=
 =?utf-8?B?VG9NN29IVUt0ZTl6L1dmWmRwamQ4bUhEem1uZEJhWDFFbXUrZlVMeDlWdC9j?=
 =?utf-8?B?dUxyM2owSWZiN1dVWk1TMkNiNkJIRm5qdlFGaWc2Ky80cmt2aHJvOHl1NGlj?=
 =?utf-8?B?cTlUWmVweHpIcVhFQVZPdzFKV3RVMjNndXI3WjdhZnE3NDhGVE9rbFJURzBs?=
 =?utf-8?B?NDBHSDJCazN0bVN6dlFSYlJBQTk1QTZiSnlSenJGNjJkRDNzRitrN3V2Y3Zo?=
 =?utf-8?B?QXh6YUlERlk3SmNydWhVUnBKVVcva2grcXltT2lZaGRFT3NpUTFpV3lIQlpQ?=
 =?utf-8?B?Y2FVOWk1UWYzWTdLN1ZTN2ZHQ1BvVXB4UGp1QzJmNVlucUFMR3loanRDWm14?=
 =?utf-8?B?K25wMHduMGFMd3F6bFpwUXZQY0o2aWo0U1dld0laWFA5SHcrMmFKN3dSaFUr?=
 =?utf-8?B?N0d5OG4rb0gyR0FTemQ5Ri9WR2NUODB0SVh1bjhiUVdWbE1pT2pGMWJsd2lD?=
 =?utf-8?B?SExaN05TQVdGbVNOaW5saTQxMjc4U1g2WWlFc096OXpOM3NTNjhZVytxeHk3?=
 =?utf-8?B?aVFBdmRIUlNPOThKOFEwbE0rRXJCUjNERU5mRy9JMW53TzBpcHVCL2NYd1BJ?=
 =?utf-8?B?akNUUEJuTS91ajdHZWpiOE5rbUdqNnRLa2lnMUJDTllpclFySUlXNWdrMTdJ?=
 =?utf-8?B?cHV4OGk1ODZFUzFJTmpHWk5wdEhQSzBtTGdKWHd2WHNHUzJkQ0w2bnNrcDRU?=
 =?utf-8?B?RTA1L2ZCUTRZSWNOeXRlbmNBckV3WGZTY1F2Uy96SHBJaHZ0WFdGSk9lVnFo?=
 =?utf-8?B?a0dCMlk0VjVDWTFDS0twV2dxR3VqNlZXYm5nV216bXdTWWNFb2Z4VlRIalEr?=
 =?utf-8?B?aUxVZWU3SzhQWlA3dmllWVpZbjRPQmRwR3Q2MmQ1RUtvRmtuYm1DaGwzaUF0?=
 =?utf-8?Q?5Qq1cGB1XzNcgqnptxlCuHG77?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bf42f0-e9f0-4c9c-a56e-08dbba6ebd34
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 06:48:18.6085 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFgIaQQL1cXW0t7O+Z99ijiheDIC0hyfG4zab2Opn19YKQv7V7/AoUQkAeU4ZNmCJcZ7uWZaHh0vLFbMUu6Asg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5481
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

SGkgQ8OpZHJpYywNCj4gT24gOS8xOS8yMDIzIDExOjIxIFBNLCBDw6lkcmljIExlIEdvYXRlciB3
cm90ZToNCj4gDQo+IE9uIDkvMTgvMjMgMTE6NDUsIEppbmcgTGl1IHdyb3RlOg0KPiA+IER1cmlu
ZyBtaWdyYXRpb24gcmVzdG9yaW5nLCB2ZmlvX2VuYWJsZV92ZWN0b3JzKCkgaXMgY2FsbGVkIHRv
IHJlc3RvcmUNCj4gPiBlbmFibGluZyBNU0ktWCBpbnRlcnJ1cHRzIGZvciBhc3NpZ25lZCBkZXZp
Y2VzLiBJdCBzZXRzIHRoZSByYW5nZSBmcm9tDQo+ID4gMCB0byBucl92ZWN0b3JzIHRvIGtlcm5l
bCB0byBlbmFibGUgTVNJLVggYW5kIHRoZSB2ZWN0b3JzIHVubWFza2VkIGluDQo+ID4gZ3Vlc3Qu
IER1cmluZyB0aGUgTVNJLVggZW5hYmxpbmcsIGFsbCB0aGUgdmVjdG9ycyB3aXRoaW4gdGhlIHJh
bmdlIGFyZQ0KPiA+IGFsbG9jYXRlZCBhY2NvcmRpbmcgdG8gdGhlIFZGSU9fREVWSUNFX1NFVF9J
UlFTIGlvY3RsLg0KPiA+DQo+ID4gV2hlbiBkeW5hbWljIE1TSS1YIGFsbG9jYXRpb24gaXMgc3Vw
cG9ydGVkLCB3ZSBvbmx5IHdhbnQgdGhlIGd1ZXN0DQo+ID4gdW5tYXNrZWQgdmVjdG9ycyBiZWlu
ZyBhbGxvY2F0ZWQgYW5kIGVuYWJsZWQuIFVzZSB2ZWN0b3IgMCB3aXRoIGFuDQo+ID4gaW52YWxp
ZCBmZCB0byBnZXQgTVNJLVggZW5hYmxlZCwgYWZ0ZXIgdGhhdCwgYWxsIHRoZSB2ZWN0b3JzIGNh
biBiZQ0KPiA+IGFsbG9jYXRlZCBpbiBuZWVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlu
ZyBMaXUgPGppbmcyLmxpdUBpbnRlbC5jb20+DQo+IA0KPiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCg0KVGhhbmtzIHZlcnkgbXVjaCBmb3IgeW91
ciBmZWVkYmFjay4NCg0KSmluZw0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+
ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gPiAtIE5vIGNoYW5nZS4NCj4gPg0KPiA+
IENoYW5nZXMgc2luY2UgUkZDIHYxOg0KPiA+IC0gUmV2aXNlIHRoZSBjb21tZW50cy4gKEFsZXgp
DQo+ID4gLSBDYWxsIHRoZSBuZXcgaGVscGVyIGZ1bmN0aW9uIGluIHByZXZpb3VzIHBhdGNoIHRv
IGVuYWJsZSBNU0ktWC4NCj4gPiAoQWxleCkNCj4gPiAtLS0NCj4gPiAgIGh3L3ZmaW8vcGNpLmMg
fCAxNyArKysrKysrKysrKysrKysrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2ku
YyBpbmRleA0KPiA+IDAxMTdmMjMwZTkzNC4uZjVmODkxZGMwNzkyIDEwMDY0NA0KPiA+IC0tLSBh
L2h3L3ZmaW8vcGNpLmMNCj4gPiArKysgYi9ody92ZmlvL3BjaS5jDQo+ID4gQEAgLTQwMiw2ICs0
MDIsMjMgQEAgc3RhdGljIGludCB2ZmlvX2VuYWJsZV92ZWN0b3JzKFZGSU9QQ0lEZXZpY2UgKnZk
ZXYsDQo+IGJvb2wgbXNpeCkNCj4gPiAgICAgICBpbnQgcmV0ID0gMCwgaSwgYXJnc3o7DQo+ID4g
ICAgICAgaW50MzJfdCAqZmRzOw0KPiA+DQo+ID4gKyAgICAvKg0KPiA+ICsgICAgICogSWYgZHlu
YW1pYyBNU0ktWCBhbGxvY2F0aW9uIGlzIHN1cHBvcnRlZCwgdGhlIHZlY3RvcnMgdG8gYmUgYWxs
b2NhdGVkDQo+ID4gKyAgICAgKiBhbmQgZW5hYmxlZCBjYW4gYmUgc2NhdHRlcmVkLiBCZWZvcmUg
a2VybmVsIGVuYWJsaW5nIE1TSS1YLCBzZXR0aW5nDQo+ID4gKyAgICAgKiBucl92ZWN0b3JzIGNh
dXNlcyBhbGwgdGhlc2UgdmVjdG9ycyB0byBiZSBhbGxvY2F0ZWQgb24gaG9zdC4NCj4gPiArICAg
ICAqDQo+ID4gKyAgICAgKiBUbyBrZWVwIGFsbG9jYXRpb24gYXMgbmVlZGVkLCB1c2UgdmVjdG9y
IDAgd2l0aCBhbiBpbnZhbGlkIGZkIHRvIGdldA0KPiA+ICsgICAgICogTVNJLVggZW5hYmxlZCBm
aXJzdCwgdGhlbiBzZXQgdmVjdG9ycyB3aXRoIGEgcG90ZW50aWFsbHkgc3BhcnNlIHNldCBvZg0K
PiA+ICsgICAgICogZXZlbnRmZHMgdG8gZW5hYmxlIGludGVycnVwdHMgb25seSB3aGVuIGVuYWJs
ZWQgaW4gZ3Vlc3QuDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGlmIChtc2l4ICYmICF2ZGV2LT5t
c2l4LT5ub3Jlc2l6ZSkgew0KPiA+ICsgICAgICAgIHJldCA9IHZmaW9fZW5hYmxlX21zaXhfbm9f
dmVjKHZkZXYpOw0KPiA+ICsNCj4gPiArICAgICAgICBpZiAocmV0KSB7DQo+ID4gKyAgICAgICAg
ICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiAg
ICAgICBhcmdzeiA9IHNpemVvZigqaXJxX3NldCkgKyAodmRldi0+bnJfdmVjdG9ycyAqIHNpemVv
ZigqZmRzKSk7DQo+ID4NCj4gPiAgICAgICBpcnFfc2V0ID0gZ19tYWxsb2MwKGFyZ3N6KTsNCg0K

