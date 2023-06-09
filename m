Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBB8728E9A
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 05:33:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7SsC-0004gQ-6H; Thu, 08 Jun 2023 23:33:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7Ss9-0004gE-Ee
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:33:09 -0400
Received: from mga03.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7Ss7-0003Ac-9M
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 23:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686281587; x=1717817587;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5JU/e6G6CGdeAaLXZTRfSmxMD42Iil8jf+EMmK8u27E=;
 b=QZrUWbniQqRbGM8uPG5kVrPkUvYUf0ZpQm19IOiG+xQXnTJlmHFgMbI6
 1y/BQkqce5u8X6AR9d3/EY7EvMyYgxq9rh8T90TgB4zYY9JTyV0XiDrOR
 SyIpMgIi/fbV2hvrhnrrpZr8kTLa9QpWfOB7vOkyyszNucDWvx5NxSddg
 5AGf269jw1+ZURpzXMkLTULK1MWZLLXcYALSd4Ygweu0r6coVeqvmVLcw
 Di5ZVlAhCQfoHJi2LAc8VjJQBNDDIzm5PvqDCiRpCXcyVlZ0joff2NS/P
 aROuBdlep1GZSNYtRp4QT2iyuHXJg3AKEPMXq/qyQuoGOJ3UCdlIfnV2V Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="360858653"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="360858653"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 20:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="1040351249"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="1040351249"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2023 20:32:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 20:32:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 20:32:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 20:32:53 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 20:32:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hr20Bb+hKmIxzMwgTW4g6uNeXLnqOOFHijM9x4y1lI9BOnMtXnCklS5hLHag0JaQ+xGlgmwJaCYUhoYonDzEndd+kG2Bgu04awHZSEROxtqhpfIkjmwv5PhFcbcsKi7T7X7h33wmFap3r4sR9f1/jlkA3wn83rKDo6PGgJ6gG1BbPmjcacqJE12n5OC3meueLd2bc35OyI6lThMfrCyaF7DAQ5VzgnRYrvq4PEG9uZVqW6fezoLYjOv+c3O6gSMTYaKKzI88T/UuaDZeeaTi0/yOhF+xnK/BYK01JxfYACtPKKzvFbAC5jCChCBTqgwrZDtKtgmomLmBGyfL/9VLAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JU/e6G6CGdeAaLXZTRfSmxMD42Iil8jf+EMmK8u27E=;
 b=VrBw+AP1uxRRM8KqrAjaGUxyMTkZuh1tsLTsO86rJnAI3pF6m6uv4XV8WwqxnDRG6n+XBDEUcVHFcf9XkL3cLezkn756oYEar5mHIs1jj0KFZOx6Hxa66UsBd6H8PRHuiBKLmLf1c4n4cEGR6EDut5W1qxhVT6Rjnmz5/TwAWySeFExlCNMQNrm7xK98XUgSlsJh1ocGe4Zh4cZK9kW5EGf4uO04yWNDF6StSqWvbPLnTk5UScfMFvIVgJHbnh8Pxk5OrwDgDNjazv2AZzd6ROe55xPZwj/n3m2njblH8LPKFzb8I+I+uBHE6O0iLp/3d1UQklQhaw/Z1lE9tYcdJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 03:32:47 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 03:32:47 +0000
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
Subject: RE: [PATCH v3 0/5] Optimize UNMAP call and bug fix
Thread-Topic: [PATCH v3 0/5] Optimize UNMAP call and bug fix
Thread-Index: AQHZmfDGIl2t5hh4W0KBFpXcHdLUSK+BDt4AgADDNaA=
Date: Fri, 9 Jun 2023 03:32:47 +0000
Message-ID: <SJ0PR11MB67440A3D74A12E896D571D5B9251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <ZIH5fF7OZlud2JPJ@x1n>
In-Reply-To: <ZIH5fF7OZlud2JPJ@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS7PR11MB7783:EE_
x-ms-office365-filtering-correlation-id: 55dc8ef2-c5fe-4fd3-cc59-08db689a31b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sVw1uhGk0ZbqD1bDN4DkYm2juCZKPbr/WOzxYY6scLaljkEfdbTL3BHoWO74XSNPRKW1b8hjAnjmTvyW6ftwDz6VtP+xZ3Q8JKsC2EhgScLtdP1gmz4AuedvR4sISUzsbKJEkMe4wCA7c8C+bmL/DRPFGoN4wQn2TLMETvXVAUuMyGdsG8TFwn1LOt8kHTVdj0rUxemL8ERHe3oCKOvEJQ/SzJyFckFVaeSZVcwnv+lm6UwXuJJw27O8p0cEaNd5WjofC3KfJjMyY1NsW4hFfCEwRsdxfEWyJ+ZqkpgTFWu4G3bQM0RqNBj39fWN6J36BaIKPbOs3keAsnZPzwUGMRara3NoOdxFpel2waKr9gPKgrn0dvFN6N438WUlnTdxK8HS0NSjYk6yEJACxVYv/90WxJM7WNnHGDjSTF6wMbM+nKjJ+O4JLLODFmb7HqbF6M+99Dcl21E96QnOPrYegK3qpgcAuKnbiLoGDoSsp3ZqB3g4gSDEAIGjLmqnKtK9BKC8zBtNoRPzgSIQgrEB52mLIn+G7yfgaKlbLy+6M/pmcr6sSDQfU8Pe5grfdj+4Z6iQTvaU4nFpzqNP2XilWwkPB13vNsqhycMpvVgn7LHAn0NkqaT6uo7zFuMI2RDW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(26005)(55016003)(107886003)(186003)(5660300002)(6506007)(41300700001)(52536014)(9686003)(33656002)(7416002)(76116006)(4326008)(71200400001)(66446008)(66946007)(64756008)(7696005)(66556008)(66476007)(8936002)(8676002)(478600001)(83380400001)(54906003)(316002)(2906002)(86362001)(6916009)(4744005)(122000001)(38070700005)(82960400001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUFyNHUyNDlYOGJaY3pQY2dCeUtWempFK1BoSVZTNGQvRTRzUUVOdGpFVnQr?=
 =?utf-8?B?a0d5RUVyWHNGQkFmSVZNTzExMUpMMXg1Y2VmVjhpYUdKNTdCbStxTFNYbGpK?=
 =?utf-8?B?a3hMNzVmb1ZVZU9QclN2MWpPWEp3UWJGbzA4cGRlN1pOZWlyeXZ3aHA2d2Nm?=
 =?utf-8?B?clZNVmc3RVZJZ1U0Q3REQndabjdkOTJ5dkF4Uy90RDRkeXdJZkFBeEVYM2th?=
 =?utf-8?B?cGg4RmhsQUJjUmNSRDgwT3VZOE80R1gzZjRvdDM1NVNUWjJmdzQvTnVVeHR4?=
 =?utf-8?B?UnhTZnV5NU1jZU8vUTgvN1dTTnF1WnV1VEViR2s4RGV3WVFnMzBINUIvUlIz?=
 =?utf-8?B?Vzc5RXBCTHdMcHlyamJ5OWtoZ1VNV3k0RVY0ay9ia3J0RXQrZXdJTzdFdDR4?=
 =?utf-8?B?M2FwMFlKREs0d2xOanp1R1JzOHJjMTdMbzV5Ym8zd3M3NHFaWnBVMlp5K3hK?=
 =?utf-8?B?RUxaOVh5eCtwWkhqRnFTTWN1VXhxeEhWTzF5QVhoMHVUQThMNEVUNk90Ykx2?=
 =?utf-8?B?WXVYeWQ5MTJyLyt1VXIrb2pMTjVEWk1KSUl4Ymc3MlZJNEFha2lXMHNpcTZr?=
 =?utf-8?B?L1pRcUZVeXJONzVvZExmSDM4OXRWUUhKSU1ycVBSOTMrdjU5OFlVb2xHR0ZK?=
 =?utf-8?B?UVluWTdkSFRKY3hRN0xIL2tDMDg4UDhWOEJERnIyMC9TeGI4ZXRGcVFCWWRI?=
 =?utf-8?B?emZXK1lVdXlmWmhIZEFNYmtsV2ZpS2dxbC9FUm1xMUFNT21pcGVCV1kvR25B?=
 =?utf-8?B?QmFGRGdLM0lIZUhxTXlwYktqRjFod3BUR2FzTStSVm5vdGhrWHZESlI3SldI?=
 =?utf-8?B?b0E1bFBseGRaamR6SGxnSDRmZ0poOURTUURRcmQ2TkNJNjBBaG1YTjB5ZVg3?=
 =?utf-8?B?ZzBiMGtqM1B0bENOV3pUdlBzZ1BjTlRBanJwT01GZ3lzRlFqblV4QTJUQW45?=
 =?utf-8?B?ODFHZi9aUzlkNDFiRUF0RFlRM0dpUTR5RDgxdDJjQXMrM1ZQMmxyc1lMNWZs?=
 =?utf-8?B?UjZHVjRxa1Vsay9STXdISlNYRmpWN3FJaGwrSC9jc2xHZW5rdUhtTmhxN243?=
 =?utf-8?B?a0VYL3QxSjJ3d0dPRWpVZXJpWi9vZVZVWmxQUHJvOUpOenc5MEpoZ21MMFdt?=
 =?utf-8?B?REIzWVlzcW16VitqVTlPVlRqbnJPQXVLbjdHRFAwTENUOUtGYnFraU5iT01S?=
 =?utf-8?B?dm05MUJlSGhWSEVFc3ZldnpWbWJuOFVQYTV6SlQxWTNzUTRVNlhXdGxoek9m?=
 =?utf-8?B?Y0hEUkM0RkhaT29TSkQ3MStaVDRnYWxXS0VqYmdQRHI0N3hqZFFaRGNNVXlN?=
 =?utf-8?B?UFNMdU1Rd3k1MS91Vis0cm4xR24yK2d5S2V6VHV1bVdDdTFJUk1PMkE0eE81?=
 =?utf-8?B?NzFnOTFqTTROR2p1ZUk5Y1BXRDVHYXhNOU9NbUU1WkwwTm94Mm1vTUpva0ZE?=
 =?utf-8?B?KzlKUnRTT3daanhMc25CbnR2dGVoMWd1Yncwc0czYUltZVNseVFONUtxMkY3?=
 =?utf-8?B?VGF3QWVrVzdLdFY5ZlVBMndyUUxqOVB2RXBCNXBVNnVaRnhwdWNJSjk0OWIy?=
 =?utf-8?B?eEp5K3UvWmlPSHNqK2VUSmhza1NPMWNmRHdRZWhGMWJtMmdVWTZBQVN2c20w?=
 =?utf-8?B?dFNIbnI2U0JFMlpvY2d4bG1Ndnl4dTZxMHpWMlBwWDhMSkkxTjlpbTB6eHNY?=
 =?utf-8?B?ei9Ic010MWdzYzRzeWZzUXZJN1hOelg2RlNMYlQwbEZtbHh0Vk5VWExEeGg1?=
 =?utf-8?B?Qjl6ZDg4Q0FydXNGWjk4aVptY3RSWno5WjVFTjZkcWlPR3RrR25aRWxuTEVO?=
 =?utf-8?B?eEQvbFVhcXovejJGUXVvOVBQdncrZk9vaUY1RjFiZElsQnBUQ2tyUDB0Y3hS?=
 =?utf-8?B?cXYzUGJ3WU04bWh6MlRYbGZ4STJZZ1BhdEwwZndteEFUWEZqM2Yzb2xWU1Y4?=
 =?utf-8?B?bFVLMjJKazIwRWtGK1c0SlRWSmh6WnVXWTRsWDBuVVBSckdrWWw1VzBQTHQ4?=
 =?utf-8?B?M0hWbkYveDcvNmU5b09mY1M3TzZDTXJra1hwSlVrcUtvaDN4VDhDSHNhamlG?=
 =?utf-8?B?WDlTTXovOGF0dWZSdWZtWExYdXNhTE5wc2pweUtjZjBpdFFIVU0wQzd4TXBF?=
 =?utf-8?Q?29YzaEDFxU23ymzlnR8yqHGep?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55dc8ef2-c5fe-4fd3-cc59-08db689a31b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 03:32:47.1100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4gxUSOXygzCf+ZgWZ6dikB9JUjmMEoOFNVq3Q4HQhKov63Bu6zfzB4uGXwEcdDoRirEi0QA8oWrZqSQUxzfLQHzZ5Zslzs1wsi7LRHWoqdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mga03.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBKdW5lIDgsIDIwMjMgMTE6NTQgUE0NCj5UbzogRHVh
biwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Q2M6IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb207IGphc293YW5nQHJlZGhhdC5jb207DQo+cGJvbnpp
bmlAcmVkaGF0LmNvbTsgcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZzsgZWR1YXJkb0BoYWJr
b3N0Lm5ldDsNCj5tYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbTsgYWxleC53aWxsaWFtc29uQHJl
ZGhhdC5jb207DQo+Y2xnQHJlZGhhdC5jb207IGRhdmlkQHJlZGhhdC5jb207IHBoaWxtZEBsaW5h
cm8ub3JnOw0KPmt3YW5raGVkZUBudmlkaWEuY29tOyBjamlhQG52aWRpYS5jb207IExpdSwgWWkg
TCA8eWkubC5saXVAaW50ZWwuY29tPjsgUGVuZywNCj5DaGFvIFAgPGNoYW8ucC5wZW5nQGludGVs
LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNV0gT3B0aW1pemUgVU5NQVAgY2FsbCBh
bmQgYnVnIGZpeA0KPg0KPk9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDA1OjUyOjI2UE0gKzA4MDAs
IFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gSGkgQWxsLA0KPj4NCj4+IFRoaXMgcGF0Y2hzZXQg
aW5jbHVkZXMgc29tZSBmaXhlcyBvbiBWRklPIGRpcnR5IHN5bmMgYW5kIHZJT01NVS4NCj4+IFBB
VENIMSBpc24ndCBuZWVkZWQgbm93IGFzIGRlcGVuZGVudCBjaGFuZ2VzIGluIFBBVENIMiBpcyBy
ZW1vdmVkLCBidXQNCj4+IGFzIFBldGVyIGhhcyBnaXZlbiBSZXZpZXdlZC1ieSwgbGVhdmUgaXQg
dG8gbWFpbnRhaW5lciB0byBkZWNpZGUgaWYNCj4+IHBpY2sgb3Igbm90Lg0KPg0KPkxldCdzIGRy
b3AgcGF0Y2ggMSB1bnRpbCBpdCdzIHJlYWxseSB1c2VkLiAgVGhhbmtzLA0KDQpXaWxsIGRyb3Ag
aXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

