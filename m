Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C017EADD7
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:19:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qVe-0008Lc-Hr; Tue, 14 Nov 2023 05:19:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qVX-0008LJ-Tj
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:19:01 -0500
Received: from mgamail.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2qVV-0006MI-Tk
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:18:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699957137; x=1731493137;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rXRfFWEdOa1SlXtY8fRI2ejfFLzO61lIhsLQGRVbImY=;
 b=RTmTGGYUauEuof75jYn8/xUbLxyUGuuqs1WhTJxbmjm4151tcl3sudE9
 dPzxObMAvWl0AESqMbs9fDuphVIw+3IBnpvDa0iVZEySX0I9eLAXnUBv7
 QwWPazEYmRcFv84mw6i8IPkAw0zX6VoARlojRiDMdMj0UHtSfGqfK9i2s
 fgmZoouF2yFwJIuN0WuXDOMi3ZwG/E0uZFCQb+prifX8pMvj/OKiKtR0n
 8c+Cr2UomB8KDaqrWQkZ2oaQFFtDMMyfvIMQRfahESMsgdMLj8+vldpft
 eFTkiuX3LcRqi5PTmvprHhk83cdw2WkfHeoQnTWcuW5YtIS/Zo1HI/xMh g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421724662"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="421724662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2023 02:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="882010067"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="882010067"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 14 Nov 2023 02:18:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 02:18:47 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 02:18:47 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 02:18:47 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 02:18:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJygGG6YpCIbHscglFHdPSPz7550W6bm2WKmQwW4Dlb9s+7xi35IjAcY0GPWONio1vRk1hiwmI3m2ONgT4MY4E/Edtgo8aXQs0zfSDO0iEfvaoGUJb3Y5/bFmPJ1dE0keteeekcEDGAvdqj8lgiAaahUgit8WlnjJH4dudH5JnbBYybgSllzQl1FSV8nRHsnRNkOruf6hLd7W/chEfUGUnbH9TCuB4OTvCLviyPSNedB5HQyboHq0mX7X4sN9S1z/koWI017vOs3rQgYNIAn1Z/VrfwEId5RtHCPVhNg9RD6WCDhbGqW4q1HknGc1VpQBCrdCVUKnFBkF9E2cQnepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXRfFWEdOa1SlXtY8fRI2ejfFLzO61lIhsLQGRVbImY=;
 b=FZD9OrfQqeLgQBrwQnF4pWF/8Ik0+6NosWqk+r/fbUrbbe4YPSJSKgI9gbgMmC6+FEvld9q1U371aMPGySEUnXPIZMGAvn9A7or1Ea8KPBkBAxSKarM4iPsJ5rFGqi1C/0NOOOHpeYabNGk3qvXz/gAv2IMPDYR+82Y+vQgrFY7oneDYTYKbPC8vMNVoztI60tdM6DNuQRF0u3SCUJq/30nShTGoE/TUHCubJZfgPUwPWVmLVJHi6G4MUfyP0I5MQhVgiG5rjXhRb/0Rs+FeTPvBoGmop+kEJX5EDmyMLJfBR42LnRu5+4VaCBHl5Gt5aO83w00FyFN2WF7va4snNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7839.namprd11.prod.outlook.com (2603:10b6:208:408::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 10:18:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 10:18:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Markus Armbruster
 <armbru@redhat.com>
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
Thread-Index: AQHaDV55xw4BryR3ak233G0Yz5k1LbBu4yyAgAERJRWAAEaqgIAAB7I3gAA3N4CAAUNKsoABGFVAgAbNFwCAAAj78A==
Date: Tue, 14 Nov 2023 10:18:42 +0000
Message-ID: <SJ0PR11MB67443F174486760C0816FA2892B2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-27-zhenzhong.duan@intel.com>
 <da7de379-bd8c-47d1-b7bf-412be92a2756@redhat.com>
 <87r0l0dc9q.fsf@pond.sub.org>
 <d710b361-7078-456c-86bd-6b7f23d56584@redhat.com>
 <87zfzoa65e.fsf@pond.sub.org>
 <20de5dde-2a1a-4d20-bafc-b63a8015fae7@redhat.com>
 <871qcz70vg.fsf@pond.sub.org>
 <SJ0PR11MB674457AF8A2E6545B8CEAE6A92AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7d66d02e-46b3-41fd-9722-eb7f58514c8b@redhat.com>
In-Reply-To: <7d66d02e-46b3-41fd-9722-eb7f58514c8b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7839:EE_
x-ms-office365-filtering-correlation-id: b6679242-ba3f-4747-1ef5-08dbe4fb142e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f9TBb31kSBaPb52FacVYo3WrL4S8QbuGyHHJ9fO4YhN53uOpeFeXhIbRKj26FcB7NSrwhEQ4Ufr+GCn2vf2AQozmZdD/cZNmSsKe9XCCRN2Scz7m6egOir51WUWRDJcGGjtgLkjwOklBdlKRhWtjRLj8Lorr0AMXdxGkKPRKuCf0CoUTmWgiGF4e7Whq3BF8h2OVhWmCrH7tOQ6dNt3/e/YoM5r3g+Kod/F0GBspAMxo74bQckVCCWrsIepim2HWLfoo0O/GabBAqGPyCeEYqFA7j0E4N5iDUtqN20mzYKMcoiDbzPYymkVg7U8i/pXRHuA5Q5DzcIzztSfhA5drkkP7aqKGhc8jcV3ttkGbgaQf/2fg6NAQduEB5ViAtTQ4wYqlSLYfnX3CWojfYRyTo9u+HH4fzg6qr/K4P3rV9LD4InOn3v4cB3KPRvbrYpEokOGqF0oGlUf+TpFhJBAW55gXoFuvCPnsnrrCB428E4VtHJi51ZWMpnGJ4RUa8izZe+10RYWl03VZuctQJxL4+PuehfMqzUKqHyjbjkWuS0kb5vFIJW+ZKYBtxbrI5zaL1UPUP3cailiLC5c/hnGIT0utv6pDdLITdtKXITbxDHa+9pV/w3HKZnKo+ww0wFMY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(55016003)(54906003)(38100700002)(122000001)(66476007)(66946007)(76116006)(110136005)(66556008)(66446008)(33656002)(38070700009)(86362001)(64756008)(82960400001)(83380400001)(9686003)(66574015)(71200400001)(6506007)(7416002)(7696005)(2906002)(41300700001)(316002)(478600001)(5660300002)(8936002)(52536014)(4326008)(8676002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhsRmxzQXljcWJFYXhaejVzbHVWTlRuN1k3Unc4bERiL3AvYjNYV0hVOVZq?=
 =?utf-8?B?czBLbVpma1ZLclYycUpmQWlvMlYxSW4zUnVtZUs2Rkhuc2R0akJDZnQ0NlB2?=
 =?utf-8?B?VC9xRzlzOEdxNnNRREZrUndpN3BoaXNBeFFLTndSTVVpaTRCa3Boc1dwMGFx?=
 =?utf-8?B?YkE4eGQydTlhaHZYcEVuZWNvUlpucktpUzFRTStBc1NncDRhRU5nSFFxYU1Q?=
 =?utf-8?B?MTZERGRVdVk3M1VqdUdubVVuUmt3TmZSTTF1OEdQaG1ydnZDcldKRFFPREx5?=
 =?utf-8?B?bHlQRUFPeXJTUDFQckFvK2xBQnVwZndmYTRGUlFXSElWMXZxd0N1b1JtL3or?=
 =?utf-8?B?cWprOEVHemVPNm5sZU4zSWlmdkFBMnQ0N1dGbzk2RFRLNWQ4U3dRNGV1S2ZR?=
 =?utf-8?B?cnFJdU1XM2pxOUJZdjRiaW4zWm1rUWlTM1VFME5HK1pZd0ZES0hrNno3U0dX?=
 =?utf-8?B?aGg3bGdSQ1FRUnJmSFR2ZXlPdlZadXFGc1FTc25CdjBOcGlTbVhUTHlLTGhV?=
 =?utf-8?B?Q3VjYndkVElhY3NnTjZoYXdZNUhVVkViSFVqczUvUzFUbUJtVVZrN2t6ajYr?=
 =?utf-8?B?dmR3ei9lM0lhVjAzVmNJWnpWNU8zNytBL3dybmQxdldnRnd6OXNjNjk4NVR0?=
 =?utf-8?B?UHMxMFVNL2lSeEFsT29RQUowWUY0MWVYTGFGdVI4Sy9iSXBoUlN5Y0xYN0du?=
 =?utf-8?B?RExUUkFrLzd5RVJqSktFZUptZm96RWR1QmhpQitCQXBNWGhYOTBBdUlzaHF5?=
 =?utf-8?B?aUV3M2lzdUV6ZDBaeEc4ZGVUTHoxOU5OdnFJVG9FNHR0aVZKM0pFMG5aSnk5?=
 =?utf-8?B?alpHV0ppMmlLSEJ1QkQrdVBRUXUzZUU2K3ZoYnR5MGZDeEprSVdTQnlnbmtM?=
 =?utf-8?B?ZTBCWmdCK25PRDFnQXYrQS9BUm9VM2RyQ1l4S2tsK3FwdWpwbGJRdjljTCtu?=
 =?utf-8?B?ZlJlQ1E2RFhRV0wvbWcxamtGSU1hMkZtQTNOcFczVmpYN29PRm1VS29ZcU1E?=
 =?utf-8?B?V1pSWXpaQlJ1U3dpZTFsTTFobE1pT2V2K3JyamFLSUFzWmVCUmVITjlHRDhn?=
 =?utf-8?B?ZkxteHo2MUtxQmF6VEZ3dG9WL3R2UTJGTDQwRW5sRnpBSkRBbTBib000MVlw?=
 =?utf-8?B?VCtWTlZJLzRqeWUrbVhMSlRTM1Nzcjh1SFZNdld4eXpxcTNZT09HdkZzV0xo?=
 =?utf-8?B?ZUJhNDhKM2JPVXcrSm9Lbm5VSlBwcWV1WC9oZUgrMFNrd29lTDg2MjZzUC9M?=
 =?utf-8?B?UGR3ZGl3am0yRlIwZVBxd0RtNWhzM01iZ3MwSzI2RFQ0V01sdXhXa1J2aHhj?=
 =?utf-8?B?SUhTMUJIU1pFK2NOeUtJV1Zhb2JUbUFQakVQYnFoYUJSc3NQZCt5NEcrYlpK?=
 =?utf-8?B?MmRZbkZoejhhYVlVZ1V4ckJKdnR0VVZJQ3NhTDNvZTU2OHFwVXdGaWhXKzZJ?=
 =?utf-8?B?VTZNeGpCdEdqL2RsRm13cGMxbmNLdDJmQVFCTENrRTZLM0ZLN3BPS0NCdnJ1?=
 =?utf-8?B?VXM1a3c3MUJuOU5sNWF4aFpPY1lxWmtXNllDN0gwMVozNUU2aTJTdGRXVGdV?=
 =?utf-8?B?ak96RXY2Q0hVSnFHSWRhVCsvL21rZXQ1ZytLa1Y2bmI1aHNaNGU2MjZ4K0FK?=
 =?utf-8?B?dTRqQ0FlUHBUYkd1OVNaUTZMb0VvaENEb3NMZkNuQ09GNS96NXpBUnduK3Fx?=
 =?utf-8?B?cUs4OU5pV3ZFKzFuU05JckNPc04yelRycUZqNHBlMkhUS3lCOWR3dTd0bzVx?=
 =?utf-8?B?cUdKbFpTdkcvWVQvZEFXeTQ3N2VHd3FSYUNPLytNY2tqcDhmTnIyOGdJREdJ?=
 =?utf-8?B?TmVaMUF0NFg0a01vSTFXUHVrN2hxQjlWUGF3NlRvUHcrSlZ1OHYySlB3bjlv?=
 =?utf-8?B?Nmg2QWNsaE9nOEc4MXViUENsMWdpVWMyNU5HWjFBT1dJaGliakpIMmZhMEt1?=
 =?utf-8?B?QUJIV0ZLckw0Ny9NcnNXb3dmWlI3d1lYREd6WmdjcVBrNFNGMkh6NmJ1ZXBl?=
 =?utf-8?B?WVVobjlQeWRYZzRRaS95RGdTaitpSUFiQ21kdzlOL2t2b2htOTh1NlRid1NS?=
 =?utf-8?B?T0pGVUNwa0NZZ0tGUllBS0phaUxhMTA5Yk9DNktDMXlwRXdIL09VY2tNVFJK?=
 =?utf-8?Q?FEK+GM1tV1cWDZZMF91khy98H?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6679242-ba3f-4747-1ef5-08dbe4fb142e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 10:18:42.9331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZLseHvrT9bTmxnG9GHgwa9W+MuSHFDv0191MkNty9lXvYfzUAOCy3wxaKYCh5DnKHAqgIvJOiFH7s6D/pPoBN127P9H5zAvedL9ux6ZEn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7839
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNCwgMjAyMyA1OjQx
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAyNi80MV0gYmFja2VuZHMvaW9tbXVmZDogSW50
cm9kdWNlIHRoZSBpb21tdWZkIG9iamVjdA0KPg0KPg0KPj4+IFRoZSBvbmx5IHRvb2wgd2UgaGF2
ZSBmb3IgY29uZmlndXJpbmcgdGhlIHNjaGVtYSBpcyB0aGUgJ2lmJw0KPj4+IGNvbmRpdGlvbmFs
LiAgJ2lmJzogJ0NPTkZJR19JT01NVUZEJyBjb21waWxlcyB0byAjaWYNCj4+PiBkZWZpbmVkKENP
TkZJR19JT01NVUZEKSAuLi4gI2VuZGlmLiAgWW91ciB1c2Ugb2YgI2lmZGVmIENPTkZJR19JT01N
VUZEDQo+Pj4gYWJvdmUgc3VnZ2VzdHMgdGhpcyBpcyBmaW5lIGhlcmUuDQo+Pj4NCj4+PiBTeW1i
b2xzIHRoYXQgYXJlIG9ubHkgZGVmaW5lZCBpbiB0YXJnZXQtZGVwZW5kZW50IGNvbXBpbGVzIChz
ZWUNCj4+PiBleGVjL3BvaXNvbi5oKSBjYW4gb25seSBiZSB1c2VkIGluIHRhcmdldC1kZXBlbmRl
bnQgc2NoZW1hIG1vZHVsZXMsDQo+Pj4gaS5lLiB0aGUgKi10YXJnZXQuanNvbi4NCj4+DQo+PiBJ
J20gZnJlc2ggb24gS2NvbmZpZyAmIHFhcGksIGJ1dCBJIGhhdmUgYSB3ZWFrIGlkZWE6DQo+PiBS
ZW1vdmUgY29uZGl0aW9uYWwgY2hlY2sgZm9yIGJhY2tlbmRzL2lvbW11ZmQuYywgbGlrZToNCj4+
DQo+PiBzeXN0ZW1fc3MuYWRkKGZpbGVzKCdpb21tdWZkLmMnKSkNCj4+DQo+PiBUaGVuIGlvbW11
ZmQgb2JqZWN0IGlzIGNvbW1vbiBhbmQgYWx3YXlzIHN1cHBvcnRlZCwgd2Ugd2lsbCBub3Qgc2Vl
DQo+PiAiaW52YWxpZCBvYmplY3QgdHlwZTogaW9tbXVmZCIsIGV2ZW4gZm9yIHBsYXRmb3JtIG90
aGVyIHRoYW4gaTM4NixzMzkweCxhcm0uDQo+Pg0KPj4gT24gdGhvc2UgcGxhdGZvcm0gbm90IHN1
cHBvcnRpbmcgaW9tbXVmZCwgd2UgY2FuIGNyZWF0ZSBhbiBpb21tdWZkIG9iamVjdA0KPj4gd2hp
Y2ggaXMgZHVtbXksIGFzIG5vIG9uZSB3aWxsIGxpbmsgdG8gaXQgdG8gb3BlbiAvZGV2L2lvbW11
ZmQNCj4NCj5JbiB0aGF0IGNhc2UsIHRoZSBtYW5hZ2VtZW50IGxheWVyIHdvdWxkIGRlZmluZSBh
IGNyaXBwbGVkIHZmaW8tcGNpDQo+ZGV2aWNlLiBJJ2QgcmF0aGVyIGxldCB0aGUgZXJyb3Igb2Nj
dXIgb3IgZmluZCBhIHdheSB0byBtb3ZlIHRoZQ0KPiJpb21tdWZkIiBvYmplY3QgYW5kIHByb3Bl
cnRpZXMgdG8gYSB0YXJnZXQgZGVwZW5kZW50IGZpbGUuIEkgZG9uJ3QNCj5zZWUgaG93IHRoaXMg
Y291bGQgYmUgZG9uZSB0aG91Z2guDQoNCkkgc2VlLCBlcnJvciBvY2N1ciBpcyBiZXR0ZXIgdGhh
biBhIGNyaXBwbGVkIHZmaW8tcGNpIGRldmljZS4gT3IgZWxzZSB3ZQ0KbmVlZCB0byB0ZWFjaCBs
aWJ2aXJ0IHRvIGFsc28gY2hlY2sgL2Rldi9pb21tdSBleGlzdGVuY2UuDQoNClRoYW5rcw0KWmhl
bnpob25nDQoNCg==

