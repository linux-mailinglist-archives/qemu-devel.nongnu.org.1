Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E057A17EE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh3oD-0005Da-Gl; Fri, 15 Sep 2023 04:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qh3oA-0005B7-C9
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:04:10 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qh3o7-0005lB-0c
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694765047; x=1726301047;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B9TydtdouVjmtsMYv5JhYQrnvxUPd1qWyoOd8AlFy2c=;
 b=gg+EJHzjjmRsikJN5/23dsnpMLxvXwWkUUoQiWqxWBaDAyD85tfh1Csx
 sjeGOkn45JUbxZi4RVS7uevpVFyzSw4BWsW/a6ZrokhkUu3mIWSEGrOPg
 Pd8+AP3gD567+Tt5V85tAKWCuBRyDZ8B5X74eHOU2PqvfMv1h830IMkuO
 PsWJwgz7jw1EEG+bKTD8u4po2aFTlPcoeYpN61ghI7KvqhEHmnHG8AaDD
 ZyvCGmx6O20X/uER5Lms1FFAv4WEhOp/PIuZUwCSc9HaixrO5dPbfXxAQ
 muYX/Pn5LyM7EJGHQywvYb0kmRsYCi61x/0xRlfDzKY9BEC12wZOwMN+1 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="358605992"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="358605992"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 01:04:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694638413"
X-IronPort-AV: E=Sophos;i="6.02,148,1688454000"; d="scan'208";a="694638413"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Sep 2023 01:04:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:04:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 15 Sep 2023 01:04:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 15 Sep 2023 01:04:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 15 Sep 2023 01:03:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZD0SZtlsVVp1DtuuB5QYaFprJRbudQzqXrxpVjgsRo8ENT1Bykcz7SZfVD/Pqd9wImeNH2EPxjejdI3u1TaSO8/ECi8R75iltggGgjOjSbW88cfwivPBvxqU9sab7crGZv7BwtArwEDHourfnrmW5T9cy4uCWEF6PcoReGGUqIhgvEnJpA2Jo/sLBfUpn44VN5a2I5yhRrHOCNH6y9rVv7XF8OWlPo6YunTPvRDpm/NM83XYgIrU3RSlwk9AIKw6z+drDil7qTxf31VrrRfDPbhaMcI0rhXLUKuoNbWVgJa6J1rjUw6IvyMBdnQTXdmlUKrxW3dQXfdZL+ygbXrdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9TydtdouVjmtsMYv5JhYQrnvxUPd1qWyoOd8AlFy2c=;
 b=fjfeBHasqb59WUT9PvgsHDSwnM4BzDrOtUPc53vuBtWdzwntiv9xTRE/9Gn/nW6Bh0YrGOokP61d6OPxH2igKUQOB+kwsWJciPePgYb+YmGU8SVtBgUpvnK4VzyGi1+YF7RFN6HG/HGESni4cJXo7Eme9VXyDw4qELVUSQCTDKqj8vnfHnntVQ7wkPJI7Nl8Bnga9Eu43nSU9kfuob13Rj7vowbY8DSJpwT9KJVOpctM5ViSC3N0NR16fqqAfy/BM86kitQebJtsuaB1hp3LABC3D4qsJdpaHMPumJibSKOyNZ6RlRrGSg7J2btZxaTFkzWi8ibe9JMFXiPQOJgkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 SJ1PR11MB6082.namprd11.prod.outlook.com (2603:10b6:a03:48b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.34; Fri, 15 Sep 2023 08:03:42 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::2d97:91c5:e989:bf4d%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:03:42 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v1 0/4] Support dynamic MSI-X allocation
Thread-Topic: [PATCH v1 0/4] Support dynamic MSI-X allocation
Thread-Index: AQHZ1Mps+u6FzGlF50KgAeqXrHgz2rAbozDwgAADegCAAATcMA==
Date: Fri, 15 Sep 2023 08:03:42 +0000
Message-ID: <DS0PR11MB8114E3F8B8EA93F6653C5B91A9F6A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <DS0PR11MB811432F3818402828796CC65A9F6A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <022a5065-c1b3-2a02-0f49-67ef886e61a4@redhat.com>
In-Reply-To: <022a5065-c1b3-2a02-0f49-67ef886e61a4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|SJ1PR11MB6082:EE_
x-ms-office365-filtering-correlation-id: c6824d74-bb72-4d61-2bf7-08dbb5c246e5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WVtwrC/NV53uqivr7xYiscpR4bOGQQD3teXTh4PzXrom3Sg3QM+STuZVu9hF+3Pk9g55E/yqXpknuuXCu5vV1/TfNZqJLhKYsz/b15q39i2rDeW/zb64aqtvYvvlqI1cWfcpZsqnPfXbfsHAbY7MygyRYDb+ViukDvthrJm5jOVoEx4PzmP1rQsAMtndc7MoyZiY/r9vcpAGKrmtroKxeDMgfdhaxEFLmPlK1da33oJ5iuN/ND0937uh3x2EgpxHVmubO5s7/Lf4qdrfEEDDmxkvReUqGm+7RVW8E9ClqnggYsRqef6X6Mrtuxrwn69xMfgwKxLcOVYpFCgi6DcvbMOO/C+tJ0j2xvQeXXsi5VJAGzmfNdcMBofgi+v6YUWZlzc8+zWPGyHAdpnCREGtI8EXsH9/IzvcDmmxQTjQCYOh6hbueD5Qj2Kb/2Y1ZzzDRgDgGMVEdQGdvyxnHxTtp2bYtax/7rX5CnzQ8nN5DG25fjsXZqhmpu74hzOuMeVUmrtdfdSUMA9Piky9F4XVb6YZWYdomZKtPojPpnaMsQmVnpHgzRSAfRuuVSM/I3I+T5KBtKGXz/mBOBSmASDEos3uGtm5J/vqldonio6BSg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(366004)(39860400002)(376002)(1800799009)(186009)(451199024)(5660300002)(52536014)(6506007)(71200400001)(7696005)(478600001)(966005)(66476007)(9686003)(2906002)(4326008)(66946007)(66574015)(316002)(41300700001)(83380400001)(66556008)(66446008)(64756008)(76116006)(8676002)(8936002)(54906003)(110136005)(26005)(38100700002)(53546011)(38070700005)(86362001)(55016003)(33656002)(122000001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXZzdjN2cXZiV252T0Z5UFRsNUdQOWQ5aEo2VkxqQnRsSG5zMDlmeS9pMGVN?=
 =?utf-8?B?dEVBazhKU1htdkJWM3luYmJKakdrZU96TzRGUzZtQ25OZDdMTmR5OUw2M0Jr?=
 =?utf-8?B?OFlLWFdNZFFacDMrWjcwZ3JQMDk1NTBtaVprV2xtK29VU3JzSHJsUGl6dGJx?=
 =?utf-8?B?S09NVkU3RmZXUXZhWXQ1RitnQWtDN1UxMmRUL0dXQjlIZzN4RVkyWE8xams1?=
 =?utf-8?B?UzdmVmtQMTAra0NnQ3RlenBDN1lqQzhvLzhUMm0rM1lLam5VY3d3ZUVubE96?=
 =?utf-8?B?R2EycmpCYjBHNnhZU2czSVNVUnozWldKVHQwTDlHcGJwc1FtbE1QZTlNdy9V?=
 =?utf-8?B?R2RTdUlRcU9hRll1L1U0aU83SzNSN1hDRkVCRGxtYU1vaEo3WG1HTVBnbXpZ?=
 =?utf-8?B?azcyRk90WDZWUisrOUE3d0RMamtNdjdvU1JiL2VXKzVqRnFEdS9KUGR3OGNo?=
 =?utf-8?B?K3A4Zm1rTVdmQ1k2azd0VlY4cll6ZjJqL2NkQ0hvbmFnWUFTOWpmRDZtS09V?=
 =?utf-8?B?L1NZK1ZwVTVzRnltRnd3ODVzSkdGQU5wU1QvR1FSL0ZWZER1cUluTTdkMTdk?=
 =?utf-8?B?TUtKYkY1SHFlYTNKVGdiR3M5QU1SNTUvcjRRUWJXM2ZtRmx4WFdURmdERmdO?=
 =?utf-8?B?dUlReUllcGk2TG5WY2MxRm04M0xOS2dDVGhRclJwYjR6L0psalRYbDU3d2xa?=
 =?utf-8?B?TTJmdnA2eGFhYlJGM1ZBYzNkOXFKRnZTaUg4MFNGMmRva2VyaGVpQWRrUms5?=
 =?utf-8?B?blhkTTNLWUI1SUJsaFVvOXlNSG54RzkxT0RJUTNuN3dvcVB3TjRteEFNc2x5?=
 =?utf-8?B?SmdhcjJlc3FaNjEwbGRXNzhEaDA2WFhSS0huQTdiMlJmRkxCVkpIMENvb3Jj?=
 =?utf-8?B?WDBteWhoa2pQU1hHR2p4eFZhZGkzd0M0SXlmcjF3anRPaThIN1FCUjVheXZN?=
 =?utf-8?B?dzV2ak15b3gwUFZ2RzlNZ2NkRk85eWNWNXREc2paSS8zREh3MXV0S0IxYndh?=
 =?utf-8?B?L1Vobzh3NUxad1RyOE02QXg5dGVQTklhdk5waWNqcjJGUndvZXhnZHR0ZUV3?=
 =?utf-8?B?b3ZZV1lEKzQwVlFrRCtyZUlLM1pINVFKQWZrSklKbk92aVcxbTRGMGwrMDBt?=
 =?utf-8?B?VVVhNkZxeVFMemVRTXRzOHl0VTZNdWZ1cldFQlNYRVVmQ1htTHVYaFZmNTZp?=
 =?utf-8?B?Y2Q1dFJqZFJlalNERE5iY1NFOWNPZGpzeWlRS2djYTNxWThVdnAwM1RDT29C?=
 =?utf-8?B?aG1OOU5MV2RjNVFhcS9kamZJZVROaHF2aWszNFNPd05uZlBNWEpXZXRZYWtK?=
 =?utf-8?B?RnZoazBpUngyaVNTZVg2QWdOVFZDbFNBMStNUFBWVGM3OW9qL0xSbm4yNkFv?=
 =?utf-8?B?d3ZEYXArM2JkemM0KzFvb2ViRFQ2b3VjR1YyTG5QQVEwdzlUcnpYTmtpSXhG?=
 =?utf-8?B?ZXpUV0FhQmg3ZDVFUTIxTlJsbGNOZGV0T1BOSVlVdm4wU3A1bE10YStaUDBv?=
 =?utf-8?B?T3N6d3VmcDg5M29SRTl4L3gwZEttd3ZtWVpkRWY5ektNM29DMmw0R2tDeEVy?=
 =?utf-8?B?Z3ZKUlRWWjdJc2FDMGl1UGkveVhpc3ZkQmtUdDh1SGdSRUVWOCtWbzRtQWxt?=
 =?utf-8?B?SUtqaG9XR1N2bEs1Zm80NFl5SHBhTlN3dWM2MFJYU1ZDeGgrZCtyamxLSTFh?=
 =?utf-8?B?SzkwMFJUV0ZMODkxNUlwYkFXT04rYU5iaVJDSTJwanROVUVGTkxhYkJkQUtW?=
 =?utf-8?B?R3BxQ2REMXlwaW9WWGc2VlZsYUtNckhyOGY4RFNHSkRmY2pGQjFHdUpBRmdp?=
 =?utf-8?B?SW1QMDRIS1B2ZGRyVFZiN3VQSUJmTU5ybk5sTXVCa3dhbTZWajVHMkthM0pm?=
 =?utf-8?B?bDg5dVNTYkRsTGJXS1RkN2YyME56bkRvZkFTNDF2TUJhcklhRE41ajhrZUE1?=
 =?utf-8?B?OTNHQmpkeWZGcEJrOTNaL0V0MkUvNXNHSFlsVUluRjhaeDYzdldJL0NDdDlH?=
 =?utf-8?B?TWY4cjYrSFVZRFBTdnZ0WUtnZ2NxMVpIazdBN2FISmQrNzBsWU00QWV1UVdt?=
 =?utf-8?B?MHdxRTlOeEgrQllJaW5JcWFlYmlSRXhVZkxoZjlIVWxQRWhWT3l5T0J4amE5?=
 =?utf-8?Q?lw2ULufKjgqmagsKjlNebg9FY?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6824d74-bb72-4d61-2bf7-08dbb5c246e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:03:42.0338 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZVCwFSp6TUDHeIsfennWIXgGpH4WOrQEiTqBhAFJIsxzhaD+AxV7aPURC1V8/mLG8VQJOJrTpHFBBxKyWAdMgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
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

SGkgQ8OpZHJpYywNClRoYW5rcyBmb3IgdGhpcyBpbmZvcm1hdGlvbi4gSSdsbCBzZW5kIHYyIGxh
dGVyLg0KDQpKaW5nDQoNCj4gT24gOS8xNS8yMDIzIDM6NDIgUE0sIEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBPbiA5LzE1LzIzIDA5OjQwLCBMaXUsIEpp
bmcyIHdyb3RlOg0KPiA+IEZyaWVuZGx5IHBpbmcgdG8gaGF2ZSB5b3VyIHZhbHVhYmxlIGlucHV0
cyBhbmQgY29tbWVudHMuDQo+ID4gVGhhbmtzIHZlcnkgbXVjaC4NCj4gDQo+IEkgdGhpbmsgdGhh
dCB3YXMgZG9uZS4gV2UgYXJlIHdhaXRpbmcgZm9yIHRoZSB2Mi4NCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEMuDQo+IA0KPiANCj4gPg0KPiA+IEJScywNCj4gPiBKaW5nDQo+ID4NCj4gPj4gT24gOC8y
Mi8yMDIzIDM6MjkgUE0sIEppbmcgTGl1IHdyb3RlOg0KPiA+PiBDaGFuZ2VzIHNpbmNlIFJGQyB2
MToNCj4gPj4gLSBSRkMgdjE6IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vcWVtdS0NCj4g
Pj4gZGV2ZWxAbm9uZ251Lm9yZy9tc2c5Nzg2MzcuaHRtbA0KPiA+PiAtIFJldmlzZSB0aGUgY29t
bWVudHMuIChBbGV4KQ0KPiA+PiAtIFJlcG9ydCBlcnJvciBvZiBnZXR0aW5nIGlycSBpbmZvIGFu
ZCByZW1vdmUgdGhlIHRyYWNlIG9mIGZhaWx1cmUNCj4gPj4gICAgY2FzZS4gKEFsZXgsIEPDqWRy
aWMpDQo+ID4+IC0gT25seSBzdG9yZSBkeW5hbWljIGFsbG9jYXRpb24gZmxhZyBhcyBhIGJvb2wg
dHlwZSBhbmQgdGVzdA0KPiA+PiAgICBhY2NvcmRpbmdseS4gKEFsZXgpDQo+ID4+IC0gTW92ZSBk
eW5hbWljIGFsbG9jYXRpb24gZGV0ZWN0aW9uIHRvIHZmaW9fbXNpeF9lYXJseV9zZXR1cCgpLg0K
PiA+PiAoQWxleCkNCj4gPj4gLSBDaGFuZ2UgdGhlIGNvbmRpdGlvbiBsb2dpYyBpbiB2ZmlvX21z
aXhfdmVjdG9yX2RvX3VzZSgpIHRoYXQgbW92aW5nDQo+ID4+ICAgIHRoZSBkZWZlcl9rdm1faXJx
X3JvdXRpbmcgdGVzdCBvdXQgYW5kIGNyZWF0ZSBhIGNvbW1vbiBwbGFjZSB0byB1cGRhdGUNCj4g
Pj4gICAgbnJfdmVjdG9ycy4gKEFsZXgpDQo+ID4+IC0gQ29uc29saWRhdGUgdGhlIHdheSBvZiBN
U0ktWCBlbmFibGluZyBkdXJpbmcgZGV2aWNlIGluaXRpYWxpemF0aW9uIGFuZA0KPiA+PiAgICBp
bnRlcnJ1cHQgcmVzdG9yaW5nIHRoYXQgdXNlcyBmZCA9IC0xIHRyaWNrLiBDcmVhdGUgYSBmdW5j
dGlvbiBkb2luZw0KPiA+PiAgICB0aGF0LiAoQWxleCkNCj4gPj4NCj4gPj4gQmVmb3JlIGtlcm5l
bCB2Ni41LCBkeW5hbWljIGFsbG9jYXRpb24gb2YgTVNJLVggaW50ZXJydXB0cyB3YXMgbm90IHN1
cHBvcnRlZC4NCj4gPj4gUWVtdSB0aGVyZWZvcmUgd2hlbiBhbGxvY2F0aW5nIGEgbmV3IGludGVy
cnVwdCwgc2hvdWxkIGZpcnN0IHJlbGVhc2UNCj4gPj4gYWxsIHByZXZpb3VzbHkgYWxsb2NhdGVk
IGludGVycnVwdHMgKGluY2x1ZGluZyBkaXNhYmxlIG9mIE1TSS1YKSBhbmQNCj4gPj4gcmUtYWxs
b2NhdGUgYWxsIGludGVycnVwdHMgdGhhdCBpbmNsdWRlcyB0aGUgbmV3IG9uZS4NCj4gPj4NCj4g
Pj4gVGhlIGtlcm5lbCBzZXJpZXMgWzFdIGFkZHMgdGhlIHN1cHBvcnQgb2YgZHluYW1pYyBNU0kt
WCBhbGxvY2F0aW9uIHRvDQo+ID4+IHZmaW8tcGNpIGFuZCB1c2VzIHRoZSBleGlzdGluZyBmbGFn
IFZGSU9fSVJRX0lORk9fTk9SRVNJWkUgdG8gZ3VpZGUNCj4gPj4gdXNlciBzcGFjZSwgdGhhdCB3
aGVuIGR5bmFtaWMgTVNJLVggaXMgc3VwcG9ydGVkIHRoZSBmbGFnIGlzIGNsZWFyZWQuDQo+ID4+
DQo+ID4+IFRoaXMgc2VyaWVzIG1ha2VzIHRoZSBiZWhhdmlvciBmb3IgVkZJTyBQQ0kgZGV2aWNl
cyB3aGVuIGR5bmFtaWMNCj4gPj4gTVNJLVggYWxsb2NhdGlvbiBpcyBzdXBwb3J0ZWQuIFdoZW4g
Z3Vlc3QgdW5tYXNrcyBhbiBpbnRlcnJ1cHQsIFFlbXUNCj4gPj4gY2FuIGRpcmVjdGx5IGFsbG9j
YXRlIGFuIGludGVycnVwdCBvbiBob3N0IGZvciB0aGlzIGFuZCBoYXMgbm90aGluZw0KPiA+PiB0
byBkbyB3aXRoIHRoZSBwcmV2aW91c2x5IGFsbG9jYXRlZCBvbmVzLiBUaGVyZWZvcmUsIGhvc3Qg
b25seQ0KPiA+PiBhbGxvY2F0ZXMgaW50ZXJydXB0cyBmb3IgdGhvc2UgdW5tYXNrZWQNCj4gPj4g
KGVuYWJsZWQpIGludGVycnVwdHMgaW5zaWRlIGd1ZXN0IHdoZW4gZHluYW1pYyBNU0ktWCBhbGxv
Y2F0aW9uIGlzDQo+ID4+IHN1cHBvcnRlZCBieSBkZXZpY2UuDQo+ID4+DQo+ID4+IFdoZW4gZ3Vl
c3RzIGVuYWJsZSBNU0ktWCB3aXRoIGFsbCBvZiB0aGUgdmVjdG9ycyBtYXNrZWQsIFFlbXUgbmVl
ZA0KPiA+PiBtYXRjaCB0aGUgc3RhdGUgdG8gZW5hYmxlIE1TSS1YIHdpdGggbm8gdmVjdG9yIGVu
YWJsZWQuIER1cmluZw0KPiA+PiBtaWdyYXRpb24gcmVzdG9yZSwgUWVtdSBhbHNvIG5lZWQgZW5h
YmxlIE1TSS1YIGZpcnN0IGluIGR5bmFtaWMNCj4gPj4gYWxsb2NhdGlvbiBtb2RlLCB0byBhdm9p
ZCB0aGUgZ3Vlc3QgdW51c2VkIHZlY3RvcnMgYmVpbmcgYWxsb2NhdGVkIG9uDQo+ID4+IGhvc3Qu
IFRvIGNvbnNvbGlkYXRlIHRoZW0sIHdlIHVzZSB2ZWN0b3IgMCB3aXRoIGFuIGludmFsaWQgZmQg
dG8gZ2V0IE1TSS1YDQo+IGVuYWJsZWQgYW5kIGNyZWF0ZSBhIGNvbW1vbiBmdW5jdGlvbiBmb3Ig
dGhpcy4NCj4gPj4gVGhpcyBpcyBjbGVhbmVyIHRoYW4gc2V0dGluZyB1c2Vyc3BhY2UgdHJpZ2dl
cmluZyBhbmQgaW1tZWRpYXRlbHkgcmVsZWFzZS4NCj4gPj4NCj4gPj4gQW55IGZlZWRiYWNrIGlz
IGFwcHJlY2lhdGVkLg0KPiA+Pg0KPiA+PiBKaW5nDQo+ID4+DQo+ID4+IFsxXSBodHRwczovL2x3
bi5uZXQvQXJ0aWNsZXMvOTMxNjc5Lw0KPiA+Pg0KPiA+PiBKaW5nIExpdSAoNCk6DQo+ID4+ICAg
IHZmaW8vcGNpOiBkZXRlY3QgdGhlIHN1cHBvcnQgb2YgZHluYW1pYyBNU0ktWCBhbGxvY2F0aW9u
DQo+ID4+ICAgIHZmaW8vcGNpOiBlbmFibGUgdmVjdG9yIG9uIGR5bmFtaWMgTVNJLVggYWxsb2Nh
dGlvbg0KPiA+PiAgICB2ZmlvL3BjaTogdXNlIGFuIGludmFsaWQgZmQgdG8gZW5hYmxlIE1TSS1Y
DQo+ID4+ICAgIHZmaW8vcGNpOiBlbmFibGUgTVNJLVggaW4gaW50ZXJydXB0IHJlc3RvcmluZyBv
biBkeW5hbWljDQo+ID4+IGFsbG9jYXRpb24NCj4gPj4NCj4gPj4gICBody92ZmlvL3BjaS5jICAg
ICAgICB8IDEyNiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+
ID4+ICAgaHcvdmZpby9wY2kuaCAgICAgICAgfCAgIDEgKw0KPiA+PiAgIGh3L3ZmaW8vdHJhY2Ut
ZXZlbnRzIHwgICAyICstDQo+ID4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMDEgaW5zZXJ0aW9ucygr
KSwgMjggZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMjcuMA0KPiA+DQoNCg==

