Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2C279125E
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 09:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd4A1-0001Kb-09; Mon, 04 Sep 2023 03:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qd49z-0001KT-1f
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 03:38:11 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qd49t-0007nU-Ij
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 03:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693813085; x=1725349085;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5q7QQ3zzrYcLfqAt/VJe8Dd6Z7sS5JNOcv7jQgMY8c0=;
 b=Bz6kithMt9/kRADUTA3tZaB9QPY0Nrm4JpZFA24Ru8BxvLpskbhXUNF0
 HDO/UxmndCWitLUjHtDT5Inq4kIUz2OnOwoGy/pLcvauY5HRuTKVvD5M4
 NLOxOXgRPFVk1IISONDl60WE90cptxUFHCYamtfuk5jVHVgoy7kZIxh22
 3dpPDpeh7rMHSNG5Y1zOmTZSYWokE9MzeHKHP3ZTe3OxdmP4mkw2SoYJ2
 gpjhZWKz0sHtRR5QZPI/KV8fKgf68tudENNjwDH17TQWf11ji2lJxKz+r
 6SVvT8YNUcrMDdCZZLtKluQtl31k/x+xYhEqeOUd5bQru52B8FCnWjlSm Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="375433696"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; d="scan'208";a="375433696"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2023 00:38:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="734230068"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; d="scan'208";a="734230068"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 04 Sep 2023 00:37:59 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 00:37:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 4 Sep 2023 00:37:58 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 4 Sep 2023 00:37:58 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 4 Sep 2023 00:37:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJFZSGeMOUMHR2NVrFM18ARR5OdNiwwgksxAwtEcJ1CbliUwdzJ+T/7g9D7+23fLegFnus/aq5hfXfGZJa/AUkrOdhwrq1FnKHRtHHahmL6/Zn9/8DJaeig3jEFdnaCCl6D9ZO9vdlxABiNl4tivcIQILPDsWHZw85P0ra84mSDtjcK3UOBg+ru0EYtF4OhrUyxuEdi3snhHJta3SnEQ29GW9oiCQdnoY2hgQjF9nVVEKDzW8nwaEWv5KJXdnX+w9Y7juDXFbNMrpQ/u9KaWl7p/zYqL/ZLc+3bs35BGtprkhntlo7mBMaXLlW1xDcZs3bQPeP3OgpVuMe2G80a1cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q7QQ3zzrYcLfqAt/VJe8Dd6Z7sS5JNOcv7jQgMY8c0=;
 b=CTsb4abybuojde/+yhyaHt0eubpMaVRTh2xytfdgKKyDiK5wAVoF1m/Mi/bXUPcxXMWOEzEw05JgPzInNXVYq3gd0Rhuxy6TuxXYyiCEXNzE/fx7TvMH+wzQECBPLp/39XR9d/1P9sqXYbPLRj5AjpGqSTFvWVQT2em3S4G01GEZLeS2g3EU60H3yHJMGuy93Lb5elZM4/SxPSzJsQIfGi0yDtBM1wXzR2T0m0iY3nA2SvKljygfhMS9kGJEQHe0N/wj5ckV/vJ9DiMRIlOfQOQ4SV4spSMuBjbb9LDMtysspIj9PpN7TWlPZ3TeZOqRX/OQ67bVUELAQhZznC+KyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 07:37:54 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::c36f:d22:39a4:f1ce]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::c36f:d22:39a4:f1ce%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 07:37:54 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Chatre, Reinette"
 <reinette.chatre@intel.com>, "jing2.liu@linux.intel.com"
 <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Thread-Topic: [PATCH v1 3/4] vfio/pci: use an invalid fd to enable MSI-X
Thread-Index: AQHZ1Mp6BsZEzkFue0GKpsn+IxUI8bABWeOAgAFHOuCAABR0AIAHo8xA
Date: Mon, 4 Sep 2023 07:37:53 +0000
Message-ID: <DS0PR11MB81141941D388214C4B3E76AFA9E9A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <20230822072927.224803-4-jing2.liu@intel.com>
 <3716c573-fb2e-cc26-d77e-b930353f9b8d@redhat.com>
 <DS0PR11MB8114DF931C88CD84C0E1BBEFA9E6A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <20230830124856.60efa152@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230830124856.60efa152@imammedo.users.ipa.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|DS0PR11MB7264:EE_
x-ms-office365-filtering-correlation-id: 05d51950-e5be-43b4-9bd4-08dbad19d9a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wCpxCtN+HEIJ/f+PHqcF+gfJ2F/Xt8dpP60jWIMLaqtQKDqrGhfRlonEth8g0PpXgLDSlOori/shu9yFfCG3etYHxUeS1qott9pBLvjdTf26fEt/0uOjFPZBCVeVPZwlCc02+usovw1Lepumn68YXItAgzixD5PTm3/d6rGUhDt2Jy8ze+IWKRdbLhDDSTI0f37PVl35YOrcBNrLLrliEdh4nxjpgX7rihtG0LysWcTwbHphn9E1s4Jq/fC+IyGnZ0kaXQ6lFaNW9keIEN+7/9CNaWog8Q+58bpH78P3W+A+aLPxD2+EuPyN00Kno3i0MlwYuzYBNgcvIEDaRiMNP5ZELCUVzCRXt/6j/VODwygZ2TWFM5LwjgglYcA6siHiWXv/QDVsqbMZBcBTB8Z66PPDAibB1spOLjlm06uz9JAungh7WR2GVFZ5JtoFWHjoDlEhdNf3N4J89/kvohw5mcua0z02e+PgAt7SlPudrJzM/lV/G2hBYWdZ2Vkt3p4M6mQ0pPILE2mQH5VoyV0IrSkcgedeZZT9ANdRPals6jAJfjoyrXU0MQdc6BmSkrUhjkVTEldglobC4QsNwxUpraFn64S8V4IHGIMBR0Oxy30=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(41300700001)(66899024)(71200400001)(6506007)(7696005)(53546011)(478600001)(966005)(122000001)(82960400001)(38070700005)(38100700002)(83380400001)(26005)(9686003)(55016003)(76116006)(54906003)(66946007)(64756008)(2906002)(66556008)(316002)(66476007)(66446008)(6916009)(33656002)(86362001)(5660300002)(52536014)(8936002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dndsMEM2N29pYURHQTVWTjNkQ0swRDBuRFh4OEcySURRN1JPd0Y5QmtRVXZz?=
 =?utf-8?B?L0YzYk9rWVc1OXBCRU5GTjRVYWVEcHEwSmdRdy9jNXBmQkdQSXV4R21BQUUv?=
 =?utf-8?B?QTJNTDhYeGV0MGl2alNncFBibjRCeFN4NVhzeUJodDdKcjZRb0xPT1E0QTZM?=
 =?utf-8?B?U01YT2VrQlYvN2ZTNVRUTXErS1dncXkrM1NuNVZ5SW9GUUYvOVZGSG5wdUhr?=
 =?utf-8?B?U3hqTVZYcUJCSGJWNEJNYXRITm1pYitzR3oxdTVpYzRiNyt3Y3NRcnVtUHYw?=
 =?utf-8?B?ais1czdoTmJWc2J1bUVaWVkzaWRZL1lNbUtweDhlY04xeWdKMnB4Ti93dXJF?=
 =?utf-8?B?RmFjTDQ3VlpaWTZwcGsxM1c3WnJMYWlVVktlbDE1OU15RjRDQXNwQVA5WXVq?=
 =?utf-8?B?V2Z1U1V3NEtjU2dsUkdWRk0valFmNWdITzY2SXp2VGlrK3d3RDVzUnlnSDdj?=
 =?utf-8?B?MGtrVkQ5aTRsckhMam0vUkJNb3dLZTh6Y2M3dTErV2Z5WUtJS2phY2Fsd1JU?=
 =?utf-8?B?eFdJRW5IcHAxSlcvckhRS0tZNmdmMEJodkNYQlJrR2FJR2gvQjZ5YWV3UXBR?=
 =?utf-8?B?Y0w3eU1EbkVXWnZzVk1Oa0NEZ3VUTDkyQWpJUGI1cWZDUzNNeisrMDJ4dzg3?=
 =?utf-8?B?Wk90TVU0bkdiM2huK1k4NUdtMW1BcFdXUEN1UDRnZWZwTWwyOFJOaUpMYmxr?=
 =?utf-8?B?enFGRG9KWUc4VTNMZ1NzT3ova0thYnJXRHFac3ZNSVZ0dVBsaFhTNFQ0R1lh?=
 =?utf-8?B?eG9qTnpENHpIZFpVVnF2Ujl6NEVyTGdwN2llSFltZXlkbzdObjYyRXFOSGJv?=
 =?utf-8?B?NVBHVGw3VEs2SUpyMm5yRlZsZVpxMkNBV2dteTJ0TGwyeEd0ZlFQTTdvMlZh?=
 =?utf-8?B?MnhtYzdxemVDTmU3V1FndjA0cVRuRmxwbFJON2VJTVVmbkhuaTNmR0pQYnBG?=
 =?utf-8?B?bFlEcTBHK0t2MTVsSTMyeUtDSC96cVk2ZzNkRFBkbXpiMGRyaElndWl0dXRT?=
 =?utf-8?B?NTFabmQ0VkxVaVY4Lzc0bG5xNGg5bGp0cVBzN1lkQUlDZ0lheXVseVppUUdw?=
 =?utf-8?B?aWpwbFNDUXFmZ3REYlM1NTJoUzNLRlBhbjVnUVhHVGd6TGJoRDJodklwWEhT?=
 =?utf-8?B?YWRQWk9MTjlEUS9JUGpXdGlDc3NPRndnOW1nQzJVQjZoYXprMXZjSDRuTDkz?=
 =?utf-8?B?UlVPaUlyOWwzY3JTRXNSQVI4WVpubXc2eUZsMmdzTjV4eXJWbk1paERCaGpr?=
 =?utf-8?B?MzRYUjd5akFxcmtLV0dMYWJRRHRvcDUxTk9CTTYvYzBXa2ZnaGV2R2ZUak02?=
 =?utf-8?B?dlIzbTVwOWlVdTlVTGVOYUNBL3JYZzY5N2NCd0U0ejRpM0c0Z3FkdmFzMG5p?=
 =?utf-8?B?ZDcwTjJvbW40RzVFUlVlM3lFbHUxOGduVFNyNkhSa2Nnck9mYmN4UnBkM3FN?=
 =?utf-8?B?V2JzaVlNcDE4anpPYXZqa1V2STYxNlJseHQrVG1xNXRtZThFS05OUFhyS1FI?=
 =?utf-8?B?b1YreWp4VHJHQkp3RFQ2TGxVMlJ1NTcrNjF2YUJQR2t5aDJvMENIQnB5dDk3?=
 =?utf-8?B?UmgwRUxSRWtGM3hCRUVPT3BCd2xEaFdVakJNY21udzIvaTJVL1VFN3VSeUpu?=
 =?utf-8?B?UkthQVRVUkNSWkZtbmI4NUg3a2l0QXFBU05sV2JCQk4zRVFrZXVxMlNvZ014?=
 =?utf-8?B?VDJORC9DZnpHZ2FGUERwV0h6NVZqMWcyTDhkczkwK0ZLdXdCcmhhTHRtZUVZ?=
 =?utf-8?B?cGI0WCt5UDFPekRzOURqRUM3Q2U5eXZOU1FTWFlzQkwyRGc0RUU3OHhTaHY3?=
 =?utf-8?B?Qjkwc2ZnNHpicmFUTVR3L2t3cTdzR3VtVUFYWVJEUTM2SSs2blpCMUQwV1RG?=
 =?utf-8?B?Si85ckppdkl2LzlLTkt1SmY4SThPMk0xejFQWnVCczE0U2VCeXphMHJPWGdy?=
 =?utf-8?B?ZGZZZldsRW9NYTRSY0Q4N25ob2FOU2J0ci9xMTdmT2xzU0F3WTZkV21lVmNj?=
 =?utf-8?B?RHVjRVlrRkhMcWFJdHJTb3hUdjQwdWFkZGJBems0Z01CWmdSNmZnWks5NkRu?=
 =?utf-8?B?VmhIWHhaa20xU2JyS20wdjNSZ3dZcnhDSFhDQ3FnaWdvL25EVEd4a1Y4MFhX?=
 =?utf-8?Q?0618I26dV+Gkw32yJpTmOL8Ab?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d51950-e5be-43b4-9bd4-08dbad19d9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 07:37:54.0064 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DHEM+fa5oZlMEEGOA3xW6uuAyjvyjCj3QuqR6CnUSIGO/wXnGC+SXFnJdVrtEtOh5zWBMLJHQiM1sJAYs9g0ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

SGkgSWdvciwNCg0KT24gV2VkLCBBdWd1c3QgMzAsIDIwMjMgNjo0OSBQTSwgSWdvciBNYW1tZWRv
diAgd3JvdGU6DQo+IA0KPiBPbiBXZWQsIDMwIEF1ZyAyMDIzIDEwOjAzOjMzICswMDAwDQo+ICJM
aXUsIEppbmcyIiA8amluZzIubGl1QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KLi4uDQo+ID4gPiA+
ICsvKg0KPiA+ID4gPiArICogR2V0IE1TSS1YIGVuYWJsZWQsIGJ1dCBubyB2ZWN0b3IgZW5hYmxl
ZCwgYnkgc2V0dGluZyB2ZWN0b3IgMA0KPiA+ID4gPiArd2l0aCBhbiBpbnZhbGlkDQo+ID4gPiA+
ICsgKiBmZCB0byBrZXJuZWwuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK3N0YXRpYyBpbnQgdmZp
b19lbmFibGVfbXNpeF9ub192ZWMoVkZJT1BDSURldmljZSAqdmRldik+ICt7DQo+ID4gPiA+ICsg
ICAgc3RydWN0IHZmaW9faXJxX3NldCAqaXJxX3NldDsNCj4gPiA+DQo+ID4gPiBUaGlzIGNvdWxk
IGJlIGEgJ2dfYXV0b2ZyZWUnIHZhcmlhYmxlLg0KPiA+DQo+ID4gVGhhbmtzIGZvciBwb2ludGlu
ZyB0aGlzIHRvIG1lLiBJIGp1c3QgcmVhbGl6ZWQgUUVNVSBkb2MgcmVjb21tZW5kcw0KPiA+IGdf
YXV0b2ZyZWUvZ19hdXRvcHRyIHRvIGRvIGF1dG9tYXRpYyBtZW1vcnkgZGVhbGxvY2F0aW9uLg0K
PiA+DQo+ID4gSSB3aWxsIHJlcGxhY2UgdG8gZ19hdXRvZnJlZSBzdHlsZSBpbiBuZXh0IHZlcnNp
b24uDQo+ID4NCj4gPiBJIGhhdmUgYSBxdWVzdGlvbiBmb3IgYSBzcGVjaWZpYyBleGFtcGxlIChu
b3QgcmVsYXRlZCB0byB0aGlzIHBhdGNoKSwNCj4gPiBhbmQgSSBmYWlsZWQgdG8gZmluZCBhbiBl
eGFtcGxlIGluIGN1cnJlbnQgUUVNVSBjb2RlIHRvIHVuZGVyc3RhbmQgaXQuDQo+ID4gSWYgb25l
IGdfYXV0b2ZyZWUgc3RydWN0dXJlIGluY2x1ZGVzIGEgcG9pbnRlciB0aGF0IHdlIGFsc28gYWxs
b2NhdGUNCj4gPiBzcGFjZSBmb3IgdGhlIGluc2lkZSBwb2ludGVyLCBjb3VsZCBnX2F1dG9mcmVl
IHJlbGVhc2UgdGhlIGluc2lkZSBzcGFjZT8NCj4gDQo+IGl0IG1pZ2h0IGJlIHRvbyBjdW1iZXJz
b21lIGZvciAxLW9mZiB1c2Ugc2VlIGZvbGxvd2luZyBmb3IgaG93ICdhdXRvJyB3b3Jrcw0KPiBo
dHRwczovL2RvY3MuZ3RrLm9yZy9nbGliL2F1dG8tY2xlYW51cC5odG1sDQoNClRoYW5rIHlvdSBm
b3IgdGhlIGd1aWRlLiBJdCdzIG5vdyBjbGVhciB0byBtZSB0aGF0IGZvciBzdWNoIHR5cGUsIHRo
ZXJlIG5lZWQgZGVmaW5lIA0Kc3BlY2lmaWMgZnJlZSBmdW5jdGlvbiBieSBtYWNyb3MgYW5kIGdf
YXV0byBjYW4gaGVscCBjYWxsIGl0IGF1dG9tYXRpY2FsbHkuIA0KDQpKaW5nDQoNCj4gDQo+ID4g
c3RydWN0IGR1bW15MSB7DQo+ID4gICAgIGludCBkYXRhOw0KPiA+ICAgICBzdHJ1Y3QgKnA7DQo+
ID4gfQ0KPiA+IHN0cnVjdCBwIHsNCj4gPiAgICAgY2hhciBtZW1iZXJbXTsNCj4gPiB9DQo+ID4g
dm9pZCBmdW5jKCkgew0KPiA+ICAgICBnX2F1dG9mcmVlIHN0cnVjdCAqZHVtbXkxID0gTlVMTDsN
Cj4gPg0KPiA+ICAgICBkdW1teTEgPSBnX21hbGxvYygpOw0KPiA+ICAgICBkdW1teTEtPnAgPSBn
X21hbGxvYygpOw0KPiA+ICAgICAuLi4NCj4gPiAgICAgcmV0dXJuOwkvLyBpcyB0aGlzIGNvcnJl
Y3Qgb3IgbmVlZCBnX2ZyZWUocCk/DQo+ID4gfQ0KPiA+DQo+ID4gPg0KPiA+ID4gPiArICAgIGlu
dCByZXQgPSAwLCBhcmdzejsNCj4gPiA+ID4gKyAgICBpbnQzMl90ICpmZDsNCj4gPiA+ID4gKw0K
PiA+ID4gPiArICAgIGFyZ3N6ID0gc2l6ZW9mKCppcnFfc2V0KSArIHNpemVvZigqZmQpOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICsgICAgaXJxX3NldCA9IGdfbWFsbG9jMChhcmdzeik7DQo+ID4gPiA+
ICsgICAgaXJxX3NldC0+YXJnc3ogPSBhcmdzejsNCj4gPiA+ID4gKyAgICBpcnFfc2V0LT5mbGFn
cyA9IFZGSU9fSVJRX1NFVF9EQVRBX0VWRU5URkQgfA0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgVkZJT19JUlFfU0VUX0FDVElPTl9UUklHR0VSOw0KPiA+ID4gPiArICAgIGlycV9zZXQt
PmluZGV4ID0gVkZJT19QQ0lfTVNJWF9JUlFfSU5ERVg7DQo+ID4gPiA+ICsgICAgaXJxX3NldC0+
c3RhcnQgPSAwOw0KPiA+ID4gPiArICAgIGlycV9zZXQtPmNvdW50ID0gMTsNCj4gPiA+ID4gKyAg
ICBmZCA9IChpbnQzMl90ICopJmlycV9zZXQtPmRhdGE7DQo+ID4gPiA+ICsgICAgKmZkID0gLTE7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICByZXQgPSBpb2N0bCh2ZGV2LT52YmFzZWRldi5mZCwg
VkZJT19ERVZJQ0VfU0VUX0lSUVMsIGlycV9zZXQpOw0KPiA+ID4gPiArICAgIGlmIChyZXQpIHsN
Cj4gPiA+ID4gKyAgICAgICAgZXJyb3JfcmVwb3J0KCJ2ZmlvOiBmYWlsZWQgdG8gZW5hYmxlIE1T
SS1YIHdpdGggdmVjdG9yIDAgdHJpY2ssICVkIiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAg
ICAgIHJldCk7DQo+ID4gPg0KPiA+ID4gVGhlIGFib3ZlIG1lc3NhZ2Ugc2VlbXMgcmVkdW5kYW50
LiBJIHdvdWxkIHNpbXBseSByZXR1cm4gJ3JldCcgYW5kDQo+ID4gPiBsZXQgdGhlIGNhbGxlciBy
ZXBvcnQgdGhlIGVycm9yLiBTYW1lIGFzIHZmaW9fZW5hYmxlX3ZlY3RvcnMoKS4NCj4gPg0KPiA+
IFVuZGVyc3Rvb2QuIFdpbGwgY2hhbmdlLg0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEppbmcNCj4g
Pg0KPiA+ID4gVGhhbmtzLA0KPiA+ID4NCj4gPiA+IEMuDQoNCg==

