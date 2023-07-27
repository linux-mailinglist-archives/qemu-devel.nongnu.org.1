Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6F765716
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:11:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2TK-0004eW-MY; Thu, 27 Jul 2023 11:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qP2TI-0004eC-FM
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:00:08 -0400
Received: from [134.134.136.31] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1qP2TF-00077t-DY
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690470005; x=1722006005;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=YQdng/GnVIj/kI63q54teqtN1laXFrPSiYe9U69vnFA=;
 b=Akw/evC62uGis1YeXiOLb5ReSgO3JlQskjY7q9hQR/uE73ngLXMw/XHJ
 ri4QFSobyEbTcBs5L05B/BJp8DxCn+5ZRDPKauzcry8Was4DRVqdAMCRl
 36pImq6uke1chxl6lzbujpF8Bnj6KXqVJBa/UD+Swxf9ehC31dvgerXXG
 DZbSZugAjGlqQUVMCcSLC51850BANIwdDJHkvSzPngcclnRw7vnumvkN2
 YeQUfM1IzsZESO4IDQERYvgSSpZSmTQVtLxsCH+EA5gQDc9qTyzV4F5Vy
 u17iIwgyzWoTrx1uf+HaQptEs8tYyy+rwZbSgpD3agKTOA3NpKCAKjFWx g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="432141700"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; d="scan'208";a="432141700"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jul 2023 07:52:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817121339"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; d="scan'208";a="817121339"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 07:52:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 27 Jul 2023 07:52:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 27 Jul 2023 07:52:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 27 Jul 2023 07:52:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO80QyYGwQjzZqHm5fF0qqUpBG0TQ8aXLsclwQzcRq521rB0pPLd9gSTb7iAhC57bKuujsXNx5SJSVq/rqHHbcdPIET+Y5wQsPYyeaEo/0bAzt6+iL7CjLA4U58Yh+Denef+rWjwtQJvoHoeUxJaAtgg2BPQlCTLY4ZbVfuq7u+UoeAoctSWgcKg1zPnG1GWCBrLUQblxPBbGzyuSDcYW0JedvI3ernkjbrxa1LLsJEQVYAL8ewzKuS/cadmpGa8QdD3Y9pbed2GREOoVv/l/vSpVj/UVC3Bvu2K1TjwpGsKPGPqXwfGYo/B2vvkbCfMgsy+vkseiQTFHDSEXtEMTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQdng/GnVIj/kI63q54teqtN1laXFrPSiYe9U69vnFA=;
 b=gJxlCRtldoxXFadOfBjE+krJDvHclndIunGauWZtxYOJarFCNpDu5KROnnNhthiFYdF/alu9Jsih6jhaThDzYsBi41uVpQDdWw+XyzIq/y6sh+U62Al6hxDMSJiPwMmfvSJw/Nn6Ewr47//G20D+ochyje2WZ81Tp8iv+kBj4Z02bokLosU+ZTMW7GpJ2Zz0/O6+R6uQxPejHG0fX3RZtC9GWR5g+9utQa5TSdGMMiioSHjNJ0Snej0FA6gA6Ik9jrfkyNsw+YbN/1TPo/4uAhVJP9q2A2QCyf8p/LoruewbXVLASWL7Idi5zRGOckRukqk+IqJob/7LIpHERC280g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 IA1PR11MB6371.namprd11.prod.outlook.com (2603:10b6:208:3ad::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 14:52:44 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::ace1:c0df:7dd9:d94a]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::ace1:c0df:7dd9:d94a%4]) with mapi id 15.20.6609.032; Thu, 27 Jul 2023
 14:52:44 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: Isaku Yamahata <isaku.yamahata@gmail.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: refactor migration_completion
Thread-Topic: [PATCH v1] migration: refactor migration_completion
Thread-Index: AQHZtlGE+Wh4fGObDECF1brZ49mxaq+/CS6AgAADl6CABBq+gIAAbEQQgAjHogCAAJMfcA==
Date: Thu, 27 Jul 2023 14:52:44 +0000
Message-ID: <DS0PR11MB6373C9E356889996575D8186DC01A@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230714124823.25142-1-wei.w.wang@intel.com>
 <20230718054425.GA1807130@ls.amr.corp.intel.com>
 <DS0PR11MB6373E417A60B2DEF9EFE3697DC38A@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZLmbKSqrDvg7Tx4A@x1n>
 <DS0PR11MB6373FA83BFCF6706F671B36ADC3FA@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZMFTbqL30O/Fw6iH@x1n>
In-Reply-To: <ZMFTbqL30O/Fw6iH@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|IA1PR11MB6371:EE_
x-ms-office365-filtering-correlation-id: 08b95b16-c69b-4ba1-3366-08db8eb12283
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ULkCbQz/mUuN+aocvIhPzS/M7xcKExCQammG0EA1T+htt5GwSATf3dNEMieviZHN6YwrYMpe+yGMdDz86f+dNFvBXoRjtBmy3H3gh5b3ErMiBWPrfMwugtFo8TZqt76fZRTkL9SKHQlhpH9uNsvkjCAP5ru6UTrR41AwuYr/jYbORhZDUuGrRhEoohsp4fqL6LckQfzK2G0SSuXZ82fKtx0Ehzx2vCuDmmcbzV9SJDjsT3z6b8wXf13FPBlHyMEfAgWc7RnLHjXxz1pn1P9Qpmi/i6LfawYJJztJoY9hC4f1xymSyeJ/mNiGj0Z3cNBlurvcZBgr7pUR7B57ZonYkgrGtcQ/xHkC+xGuuTibTmn6ozEO8Z6PcbbtlidXIfb6WCts7EVuCtJE/178yinaFGLTH7KsfDTZlYXO8/dxl8pjsK2he95ERsX8eTclZWmQQzELePq7DrjQtrmV6Iy2c+gBibGNLJJ/lXELM4tQNl4w4UnlJFC4hmFEpUKJBJnMfyvskKAZYVV/PpgisKRIYg1JdT/qihMtAuBROQmOu0Lrj4Tfd4+3pav5fUgJEP3XwhvES0iOUSRqz+FcA3XQ8rFFXyiECr1HOpDmZgjMCLrqRdQriX6IwrAxWOZU+M62ngBqp9GwV2S5sih0ucMFzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(86362001)(33656002)(38070700005)(2906002)(55016003)(83380400001)(186003)(53546011)(26005)(6506007)(38100700002)(122000001)(9686003)(478600001)(7696005)(71200400001)(54906003)(76116006)(66946007)(66446008)(64756008)(82960400001)(66556008)(4326008)(6916009)(8936002)(66476007)(41300700001)(5660300002)(316002)(52536014)(8676002)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzBKN1k1MFBrNUlwSjBuaHJYSWxKSVJydlE1VkltVW9yRVFaM1J3c1JGaXFS?=
 =?utf-8?B?MnJvWE92SUFDUmxzTldVVStFTjVVZGhFanhTMlF5S09NNjdpWVlZSWwwN1ZR?=
 =?utf-8?B?bGRGMVJmRGZCTFFWUC9mSTJWL2YwTUk4WldqdVJCM09HcHpJOTVucEE4WXNo?=
 =?utf-8?B?NlNwd1czVUprbzFYRjl1R01jajR6eVhlNS8zYWRKaG9tejVoMXRPK0Z1bC95?=
 =?utf-8?B?cndpNm9XUkNnZVhmSUVvZjFyMzFCTFZTd1J6TGFTT3FpbHc2Z3dWeURjVUFK?=
 =?utf-8?B?d2ZjcU5sWHZWeWxzVGJ0S3dTUHNVTWhPd0RMVzE3TTd2bzkzazFyMUsvd1RE?=
 =?utf-8?B?R1RLZWVZWTdiaEgvODVidTJURnVpeDVFZGxVSFQxQm5NdkpoMWNFbFVUNTRr?=
 =?utf-8?B?K1dxVHFtZEswcGFyU2pkekdNZmIxR21jY3NkM0hTcDZvM29TVFBBWFEwTzhz?=
 =?utf-8?B?T05jcitqS09EcW9ZN2hjTDUxZGpBQXd0ck9DTnQ3SFZYNnFIb3lFQXdhamcz?=
 =?utf-8?B?ZFdnVzdVOHdwVnVERzFQT3RYMEI2SWo4eFN3S2NOMnZlS3pMNXV1d0Ira0xs?=
 =?utf-8?B?WjhCMzFZWFB3ZEFheUxJYVBtTDNRMmZhYmI0MWR4dGJYRlZrOVpuNVlQM24z?=
 =?utf-8?B?NDBTa2pqVkNWeS9rUUc3UUVPck0wWmVPVkx1eW13Sms0b1pUeERKYUk5SXg2?=
 =?utf-8?B?VVpJd0JweGxCS0JvUzNJUzdmSjdVR25rQXR0L1VGejVtVS9WVnhpOW9JdWhj?=
 =?utf-8?B?S2hyK1BVb3U5MDhsQUVJRzJvQ2NOWXJhT00vc2tmTWFjMmJEajVrZFVGSVFD?=
 =?utf-8?B?RWRjN0FSaXpxWEdMNGduZGdYZ2R5bE15ZWNVaklEUitzZTFUdmlsME00eHlk?=
 =?utf-8?B?dFZ2WW83cGRWeGYrUlRFMU1pWW5Tb3JScnNhNVU1TU5DdWFHQlAxZW05M0sy?=
 =?utf-8?B?cEV4clA1RTVHcWtabE52MUJGZ3BWeEtwY01DMm1ablhRYlg1L20rWXJYem9H?=
 =?utf-8?B?QTNUdjU5S2dqWGlzUEJ0YWpkNjR3d3cwZ0RwdlpTTlMrT0FhMmdWSjI5Zngv?=
 =?utf-8?B?aldYcTI4cE5BVngyR0RUUExsSHhQbElXTkpJTHlZWUx4R29lUmJNQ1pUSGFS?=
 =?utf-8?B?bk9GeUx0NHV1dGdjTEJXekpDdEVyNStqZ2NmS2tEM3g2TkFiUFJoV1prRUxG?=
 =?utf-8?B?WkFZZWlxcmlLV1ltNEpxZmczWVY4OENtQkdZVUwrelh2alQyNndLL0NzdDd3?=
 =?utf-8?B?bXAranUwRnJsWTBsQU1rcGE2Q2liL1BuTTBTTzI0U3VuUjRoT3hOOWVGdndO?=
 =?utf-8?B?OGFrektxeUNMc2JVZDlrWTVQUkIvWTdlSVR6aU95azBhZVNjSkllZ2VpNHBF?=
 =?utf-8?B?OEFjdXlBSHpaMEZhOFdSTGxRTWRoK3NDN1JHTUQ1U1R2L0VVSm9wY25EN3lB?=
 =?utf-8?B?Z0lrMWlqNVV0SlhqMEJWOFhLU2UxcGZmcDBIWkd5NXZJVWRpWUJ4WE56c25H?=
 =?utf-8?B?T1FPTWUzbTVXL21nR0tzQ0duVkpWYW9aQUFVYU5TSm82UGh3L3FHU0ZxclVX?=
 =?utf-8?B?SWp3a2Zhd09wUUFtMWZGa1N1b2dFOVU4WnJLTXB2cEtIMlFHYXd3YTdYbEtz?=
 =?utf-8?B?TytaZnB0Vk92K0FoS0tZS2VIeStnNlZLSEl6ZE5CSk5PL1lDWURzUlI0Qks3?=
 =?utf-8?B?cWoxYm54VEtzV3poMmNCc3pyR2FZZGw5TEMwa3Q3cGhseWZyNi96R0d0UEtz?=
 =?utf-8?B?bjdhWmwvbDZURk5UdkVVNTE1YnpvUkp0V3dIUUhDTEZNSUNTZHM2eWYvMDN2?=
 =?utf-8?B?dXl1RnZnOHpveDlEK1RlZFpOeTlYSWpEcGZpd0hRN0U4MGo4ejVtQTU5YVRV?=
 =?utf-8?B?enZRdzFsMTFHN05KUFlCT2QxbVZoU0YyMjRIQ0JUR3FhQSsrM1krdElITFl4?=
 =?utf-8?B?WUYrTDRsVkFEWFdVWUJRU3RVRGNKK2VoTngxU2tMalloaVk5SC9YK2tLQ1FD?=
 =?utf-8?B?Nk81RWRIN2haMEt5ZUl1UGJ0MlFSZXdHZ2FlMzhNVlZ5d21KdWU2UHV4LzVF?=
 =?utf-8?B?YVJ3NkN6ZUVqUlQyM00xSjFLemtQbTVXa0h2OENTanR4QWl0cDRmMERmUGNC?=
 =?utf-8?Q?za4UqoWXUgqVYhLzMSQS+eRpm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b95b16-c69b-4ba1-3366-08db8eb12283
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 14:52:44.2065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QbyBpoaeEnnpSK7aBpDJBEEx6ofpTkli01KaV2dmGsKdnvOwEXWbzY7o+ShTjliIUYA8gl7KqJ4S7BZMI8wPBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6371
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 134.134.136.31 (failed)
Received-SPF: pass client-ip=134.134.136.31; envelope-from=wei.w.wang@intel.com;
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

T24gVGh1cnNkYXksIEp1bHkgMjcsIDIwMjMgMToxMCBBTSwgUGV0ZXIgWHUgd3JvdGU6DQo+IE9u
IEZyaSwgSnVsIDIxLCAyMDIzIGF0IDExOjE0OjU1QU0gKzAwMDAsIFdhbmcsIFdlaSBXIHdyb3Rl
Og0KPiA+IE9uIEZyaWRheSwgSnVseSAyMSwgMjAyMyA0OjM4IEFNLCBQZXRlciBYdSB3cm90ZToN
Cj4gPiA+IExvb2tzIGdvb2QgdG8gbWUsIGFmdGVyIGFkZHJlc3NpbmcgSXNha3UncyBjb21tZW50
cy4NCj4gPiA+DQo+ID4gPiBUaGUgY3VycmVudF9hY3RpdmVfc3RhdGUgaXMgdmVyeSB1bmZvcnR1
bmF0ZSwgYWxvbmcgd2l0aCBtb3N0IG9mIHRoZQ0KPiA+ID4gY2FsbHMgdG8NCj4gPiA+IG1pZ3Jh
dGVfc2V0X3N0YXRlKCkgLSBJIGJldCBtb3N0IG9mIHRoZSBjb2RlIHdpbGwgZGVmaW5pdGVseSBn
bw0KPiA+ID4gd3JvbmcgaWYgdGhhdCBjbXB4Y2hnIGRpZG4ndCBzdWNjZWVkIGluc2lkZSBvZiBt
aWdyYXRlX3NldF9zdGF0ZSgpLA0KPiA+ID4gSU9XIGluIG1vc3QgY2FzZXMgd2Ugc2ltcGx5IGFs
d2F5cyB3YW50Og0KPiA+DQo+ID4gQ2FuIHlvdSBzaGFyZSBleGFtcGxlcyB3aGVyZSBpdCBjb3Vs
ZCBiZSB3cm9uZz8NCj4gPiAoSWYgaXQgaGFzIGJ1Z3MsIHdlIG5lZWQgdG8gZml4KQ0KPiANCj4g
Tm9wLiAgV2hhdCBJIG1lYW50IGlzIG1vc3Qgb2YgdGhlIGNhc2VzIHdlIHdhbnQgdG8gc2V0IHRo
ZSBzdGF0ZSB3aXRob3V0DQo+IGNhcmluZyBtdWNoIGFib3V0IHRoZSBvbGQgc3RhdGUsIHNvIGF0
IGxlYXN0IHdlIGNhbiBoYXZlIGEgaGVscGVyIGxpa2UgYmVsb3cNCj4gYW5kIHNpbXBseSBjYWxs
IG1pZ3JhdGVfc2V0X3N0YXRlKHMsIFNUQVRFKSB3aGVyZSB3ZSBkb24ndCBjYXJlIG9sZCBzdGF0
ZS4NCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiAgIG1pZ3JhdGVfc2V0X3N0YXRlKCZzLT5zdGF0ZSwg
cy0+c3RhdGUsIFhYWCk7DQo+ID4gPg0KPiA+ID4gTm90IHN1cmUgd2hldGhlciBvbmUgcHJlLXJl
cXVpc2l0ZSBwYXRjaCBpcyBnb29kIHRvIGhhdmUgc28gd2UgY2FuDQo+ID4gPiByZW5hbWUNCj4g
PiA+IG1pZ3JhdGVfc2V0X3N0YXRlKCkgdG8gc29tZXRoaW5nIGxpa2UgX19taWdyYXRlX3NldF9z
dGF0ZSgpLCB0aGVuOg0KPiA+ID4NCj4gPiA+ICAgbWlncmF0ZV9zZXRfc3RhdGUocywgWFhYKSB7
DQo+ID4gPiAgICAgX19taWdyYXRlX3NldF9zdGF0ZSgmcy0+c3RhdGUsIHMtPnN0YXRlLCBYWFgp
Ow0KPiA+ID4gICB9DQo+ID4gPg0KPiA+ID4gSSBkb24ndCBldmVuIGtub3cgd2hldGhlciB0aGVy
ZSdzIGFueSBjYWxsIHNpdGUgdGhhdCB3aWxsIG5lZWQNCj4gPiA+IF9fbWlncmF0ZV9zZXRfc3Rh
dGUoKSBmb3IgcmVhbC4uDQo+ID4gPg0KPiA+DQo+ID4gU2VlbXMgdGhpcyB3b3VsZCBicmVhayB0
aGUgdXNlIG9mICJNSUdSQVRJT05fU1RBVFVTX0NBTkNFTExJTkciLg0KPiA+IEZvciBleGFtcGxl
LA0KPiA+IC0gSW4gbWlncmF0aW9uX21heWJlX3BhdXNlOg0KPiA+IG1pZ3JhdGVfc2V0X3N0YXRl
KCZzLT5zdGF0ZSwgTUlHUkFUSU9OX1NUQVRVU19QUkVfU1dJVENIT1ZFUiwNCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXdfc3RhdGUpOyBJZiB0aGUgY3VycmVudA0K
PiA+IHMtPnN0YXRlIGlzbid0IE1JR1JBVElPTl9TVEFUVVNfUFJFX1NXSVRDSE9WRVIgKGNvdWxk
IGJlDQo+ID4gTUlHUkFUSU9OX1NUQVRVU19DQU5DRUxMSU5HKSwgIHRoZW4gcy0+c3RhdGUgd29u
4oCZdCBiZSB1cGRhdGVkIHRvDQo+ID4gbmV3X3N0YXRlLg0KPiA+IC0gVGhlbiwgaW4gbWlncmF0
aW9uX2NvbXBsZXRpb24sIHRoZSBmb2xsb3dpbmcgdXBkYXRlIHRvIHMtPnN0YXRlIHdvbid0DQo+
IHN1Y2NlZWQ6DQo+ID4gICAgbWlncmF0ZV9zZXRfc3RhdGUoJnMtPnN0YXRlLCBjdXJyZW50X2Fj
dGl2ZV9zdGF0ZSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgIE1JR1JBVElPTl9TVEFU
VVNfQ09NUExFVEVEKTsNCj4gPg0KPiA+IC0gRmluYWxseSwgd2hlbiByZWFjaGluZyBtaWdyYXRp
b25faXRlcmF0aW9uX2ZpbmlzaCgpLCBzLT5zdGF0ZSBpcw0KPiA+IE1JR1JBVElPTl9TVEFUVVNf
Q0FOQ0VMTElORywgaW5zdGVhZCBvZg0KPiBNSUdSQVRJT05fU1RBVFVTX0NPTVBMRVRFRC4NCj4g
DQo+IFRoZSB3aG9sZSBzdGF0ZSBjaGFuZ2VzIGFyZSBqdXN0IGZsYWt5IHRvIG1lIGluIGdlbmVy
YWwsIGV2ZW4gd2l0aCB0aGUgaGVscCBvZg0KPiBvbGRfc3RhdGUgY21weGNoZy4NCg0KWWVzLCB0
aGUgZGVzaWduL2ltcGxlbWVudGF0aW9uIG9mIHRoZSBtaWdyYXRpb24gc3RhdGUgdHJhbnNpdGlv
biBjYW4gYmUNCmltcHJvdmVkIChpdCBsb29rcyBmcmFnaWxlIHRvIG1lKS4gSSB0aGluayB0aGlz
IHNob3VsZCBiZSBkb25lIGluIGEgc2VwYXJhdGUNCnBhdGNoc2V0LCB0aG91Z2guIEZvciB0aGlz
IHBhdGNoLCB3ZSBjb3VsZCBrZWVwIGl0IG5vIGZ1bmN0aW9uYWwgY2hhbmdlLg0KDQo+IA0KPiBF
LmcuLCBJJ20gd29uZGVyaW5nIHdoZXRoZXIgYmVsb3cgcmFjZSBjYW4gaGFwcGVuLCBhc3N1bWlu
ZyB3ZSdyZSBzdGFydGluZw0KPiB3aXRoIEFDVElWRSBzdGF0ZSBhbmQganVzdCBhYm91dCB0byBj
b21wbGV0ZSBtaWdyYXRpb246DQo+IA0KPiAgICAgICAgICAgbWFpbiB0aHJlYWQgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbWlncmF0aW9uIHRocmVhZA0KPiAgICAgICAgICAgLS0tLS0tLS0t
LS0gICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLQ0KPiANCj4gbWln
cmF0aW9uX21heWJlX3BhdXNlKGN1cnJlbnRfYWN0aXZlX3N0YXRlPT1BQ1RJVkUpDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmIChzLT5zdGF0ZSAhPSBN
SUdSQVRJT05fU1RBVFVTX0NBTkNFTExJTkcpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgLS0+IHRydWUsIGtlZXAgc2V0dGluZyBzdGF0ZQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFlbXVfbXV0ZXhfdW5s
b2NrX2lvdGhyZWFkKCk7DQo+ICAgICBxZW11X211dGV4X2xvY2tfaW90aHJlYWQoKTsNCj4gICAg
IG1pZ3JhdGVfZmRfY2FuY2VsKCkNCj4gICAgICAgaWYgKG9sZF9zdGF0ZSA9PSBNSUdSQVRJT05f
U1RBVFVTX1BSRV9TV0lUQ0hPVkVSKQ0KPiAgICAgICAgIC0tPiBmYWxzZSwgbm90IHBvc3Rpbmcg
dG8gcGF1c2Vfc2VtDQo+ICAgICAgIHNldCBzdGF0ZSB0byBNSUdSQVRJT05fU1RBVFVTX0NBTkNF
TExJTkcNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1p
Z3JhdGVfc2V0X3N0YXRlKCZzLT5zdGF0ZSwgKmN1cnJlbnRfYWN0aXZlX3N0YXRlLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgTUlHUkFUSU9OX1NUQVRVU19QUkVfU1dJVENIT1ZFUik7DQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0tPiBmYWxzZSwgY21weGNoZyBmYWlsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBxZW11X3NlbV93
YWl0KCZzLT5wYXVzZV9zZW0pOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAtLT4gaGFuZyBkZWF0aD8NCg0KU3RpbGwgbmVlZCAibWlncmF0ZSBjb250
aW51ZSIgdG8gdW5ibG9jayB0aGUgbWlncmF0aW9uIHRocmVhZC4NClByb2JhYmx5IHdlIHNob3Vs
ZCBkb2N1bWVudCB0aGF0IFBBVVNFX0JFRk9SRV9TV0lUQ0hPVkVSIGFsd2F5cyByZXF1aXJlcyBh
bg0KZXhwbGljaXQgIm1pZ3JhdGUgY29udGludWUiIHRvIGJlIGlzc3VlZCBmcm9tIHVzZXIgKGV2
ZW4gYWZ0ZXIgbWlncmF0aW9uIGlzIGNhbmNlbGxlZCkuDQo=

