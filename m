Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C3A7CD268
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 04:42:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qswUm-0008Nx-A0; Tue, 17 Oct 2023 22:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qswUg-0008NT-Ra
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 22:41:11 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qswUe-0006c5-9H
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 22:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697596868; x=1729132868;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Olmmg/qTWKpqI1BCpqgg2N7D82kpxX81QBrdqrCA3uE=;
 b=RiWqrGyirrdhoR2eNdIM5sieGcP6URDjRLFhzqgCmiT0tVJVrz4CZQqQ
 H3Qs5U8p8WSDvZEO/19EIGSGaAqXujfxAmz19zeAY8sf9kyD+w1d7E0rH
 W6s9jP5IQLHqznK6Lg1mC7SRFqQWE8yG+wZboxuUU34+hWXSWfBUcMcFn
 36LrB205cyEwEjOBjFsHZuq/w0bkxNeYmSSMoYpyy36YTbIsOYWk41O48
 FB2tYwSclJ4bVdH+cpUmwKcxsB2f3YYfoiGV77krkpt0QKNFhdE0D/Kyy
 H6KwU2GByz364MnVhtVrYRc3ygVvhzJp7rF99F5+Se3h6QWOSv7PWV7wO g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="370984731"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; d="scan'208";a="370984731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 19:41:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1087727397"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; d="scan'208";a="1087727397"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Oct 2023 19:41:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 19:41:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 19:41:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 19:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUqIdjhm7vsBqkS3CQpmSoif+W+5SuFkT32BAjOOdXa86gS7o3dOXZIQBVRv0ztmI1hCBsClL4xChVpTdifp2eLoOwaTXBkviw9GPv7cYAnqD93fiRfuSuOTVIlNjSTJfDyTmOWHQJ3Qh0dvs2V5X8JHiCF90SMLZwzZq1/oluwZ4e5MYQejgZuZeSWmdxhpudle6hBFxutPQwxgMt+Zsl3J9RrUjINhUoXSqkkQJqvz+bE8o5LqIs70GRBBxJzU0+84hrMwUh5t2QmOsUfypb3DcJk7N36xD4/w0fSDgwz1q0dZUGDExlU2zSrg4yRD/Mvii1MgaFLCrUDEoYHgeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Olmmg/qTWKpqI1BCpqgg2N7D82kpxX81QBrdqrCA3uE=;
 b=hDl/vM+JG3r109LeVQ130N3zfR5yHwlD1BwD/6alDfgLEQ2A9Y2W/+dIoy/QTNtl3Z2KAhdXpCBjI65ld7/qJ45tUZLxSEcePohM3jeC61b49359ZtbC8aB9STMkjZVsRnb22/Y51BYheZhRMzEJH6MN3BlIlgDtjbFpPAdf5FXBxS0JBQc34r0rxTzUKBKXd2B/7CyHUrAVUlQ+gw+NiG7wmO6BgSgHUWqW91/QbgY8QPpNRnjVqYun2wFyto4B2DKajip8PR7Ntv4EKYvFUY3GRm1qan0EXrfQT+V39X5BSmrq6bnRsye284CxtlbRSAZ2VOiY1/xHBe89Xon/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by PH8PR11MB6928.namprd11.prod.outlook.com (2603:10b6:510:224::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Wed, 18 Oct
 2023 02:41:01 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.043; Wed, 18 Oct 2023
 02:41:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
Subject: RE: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Topic: [PATCH v2 02/27] vfio: Introduce base object for VFIOContainer
 and targetted interface
Thread-Index: AQHaAA1niboIxiaoHk+mLfxtQdCD+rBOI2WAgACzxLA=
Date: Wed, 18 Oct 2023 02:41:01 +0000
Message-ID: <PH7PR11MB6722FF23DC574EB09300075292D5A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231016083223.1519410-1-zhenzhong.duan@intel.com>
 <20231016083223.1519410-3-zhenzhong.duan@intel.com>
 <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
In-Reply-To: <f8089865-20cf-4f11-981a-e593a103a387@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|PH8PR11MB6928:EE_
x-ms-office365-filtering-correlation-id: 3f9f275d-8c04-45de-3594-08dbcf83aa81
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X2J638c9SHiLBLFfuaFrur8NNAu3UnxAiMxkt01csZThAIK6I8Od2E3FPJ8uATVOo40nELIlIjW7quzuK66eYJdgl+j73NAR45KaW2g0cAKs43tEjYqPeOwM/aB2a55mrKHo8azV3cpL5ZpOn2RgN4u67B5uQOc6rV5qXf5nTwK7c28g4MQ3sUJ+Z2Y28ukleA62no3kCI7qlBLaGlBmxy6Ow5vf+P0LVw/xbuaoQyikNmRLMorkeU6E1CHFt1ivmvYSSknoUpndQQO8HBYWsLwD/tM5Ipykfw/tcXTAgJIYJPaBBdtlIFv08tg81oZ9XPhDuV2ixsokVsq+nSXot5d9Sb/UvbZu1aFrsOjJxcXBd2RicQg8JgcqsjSd9dRdNZKMKEifFiS1qXSumo0OCZzmBf1JUe+KV8njXLnf2y7fCmvXPC+Z5/IsXk/X/sOtEdJ8fnH1LQi2Q2Eej34KS5kfYOMQhzQdzjTQUKzbwSzPVhCh+hNlS1pDfBa6TFNljNbiJMl0pbl2ribpKjZVqO9i4mj5rJGGmoUA5gq8tHySUEbAqCrvfetsadpT16ZmZXI34j+SPlF9dObrQYfI49AVxEZ2SIi/BUjNNcKH6yg4G5fggnZnCb0kscFuhKl5+gcTXxi/67pPGHr8iTTQE9JkIVpfEqQgx0ehJS7EemQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(55016003)(38100700002)(7416002)(9686003)(38070700005)(26005)(66574015)(478600001)(316002)(122000001)(966005)(52536014)(86362001)(2906002)(82960400001)(33656002)(5660300002)(66446008)(64756008)(76116006)(4326008)(66476007)(54906003)(66556008)(41300700001)(8676002)(66946007)(8936002)(110136005)(71200400001)(7696005)(6506007)(83380400001)(2004002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1piSEdERFAvL2wzVXlmRFlkb3JjWFNJaFJ4VU1lZGtoWmxiR2RkK1hXSk51?=
 =?utf-8?B?eENEQ01CYy9oYXNLVC9hM3NPYUU3UTZtVEttOFp3NVdpeENTS25yMEJiaGtz?=
 =?utf-8?B?RVlpSURYTDd0UmtEL0FqQ1huSVZCSGQwZEZJLzYrbm5qN1FiZjBFRW5ON0NP?=
 =?utf-8?B?Q3E4aW53ZnVRVzdHeUtmd3RLUkEwSEdBZkYxVlFmNm0xSU90ZlJpQTJCWkpj?=
 =?utf-8?B?cUN1OHcrREtaUC9jdFpCTXJFRDBqR2xCSUIyU0JBWkIrcW56UzVCcDFCcThY?=
 =?utf-8?B?WW0xemprcDg0cmcvcHFhbTlwMnBKT2txcnV3U3lRYS9MeUlvSjJ1aXZualA0?=
 =?utf-8?B?eHVEYzV3ckEraVpQNEJkRTVGZlpVSGMwQTY3WXZCRnJFRnBaZ0ZYR24vQTMv?=
 =?utf-8?B?R2VWL1dqRVZFa1FvUEJhUy9kMFVGVXNtWjVFbmZ2QnRJanltdHkyRThLeXAy?=
 =?utf-8?B?a0JQYlEzL29YSUhubStVcDZyaWlMb0thVks3b1FLbTl6R1VjSFlWQWpNZ2Q1?=
 =?utf-8?B?ZmZReldhUDErR0VwRFhEYXVhNkZRREtBQjYzVDRyYXdYcTgzUGtMRXBIMkZL?=
 =?utf-8?B?L0xUWTVsREdoWmV4QU9JZUtCY0tVVlJnT0ZZVVBNVFczUXhKLzczcnFpVmdT?=
 =?utf-8?B?QUQrSTVuSHgxWmY2WEhrRkQ0Q2VSbU55b3lhWHI2dE1UeGNEL3pMOVN5U3Zo?=
 =?utf-8?B?NTg4L3JNTXRJcDdBcHA0eVFKTXhIWmpvYy9NNThQUW9IRmFHNEdWbWdxUTFs?=
 =?utf-8?B?SDFGcWVLWEVPTlY0TktTb0tCTWkwcGdaMFg3VEN4VUZwRVdMc0hoNnMvVDFu?=
 =?utf-8?B?SHptVk9qajZCTlk4amNMbmFUZzZ1K1MzZldibFBUUlZpT0RXWkltNUhSQnhV?=
 =?utf-8?B?eDZWQ3NTelNTV2ozQ0dYcjNtVlJ5a2lydFpDZW1RSDE5alg4SlZLZ1lhTkVK?=
 =?utf-8?B?NTFmUFZJZDBMc21YaE94VGV6VzA5Vml3MEQ2TXVjMlZGZTNsSGVBOFA3a3M3?=
 =?utf-8?B?b09HWmtPcmx6OFo2ZnRxTEtYQXplL1JDSzB1elFtSmxZSnV0Z1o5eEVHYzND?=
 =?utf-8?B?eTFjNnQzc2JiU2dGWnVvYS9iS2xsV1hzdHJxOVN2dmNSSlMrWXNwL0hJVGFx?=
 =?utf-8?B?RURYZHNZajl4Y0lvVVFPWkRFRGFHZVFLU0JWcExaU0IzWjM3RHZ4eEdsVmdI?=
 =?utf-8?B?aVp1Sy9BQ1phS1hXQ0VJU3NWQWdoczdYLzdaZGlORnJvd3R1eTloZjlhenFN?=
 =?utf-8?B?bVE3dS80ak1USW9CMUxMenhJMUx6RlhtZU54SW5uRVlwUzNKRzR0NnRDZjRO?=
 =?utf-8?B?UEJJK0pNV0dCVmpkcFNqTXA3Z0kxMTg3eWNlMGNiTHg3TEJHVnpWZ0FNMG03?=
 =?utf-8?B?SCt5TGZ1NEE0VklReGFOS2oxdTd2TjNUNEROUmI1MWh6a1ZONjdKam9WSW83?=
 =?utf-8?B?YzVyV0VCYjJEQkJhdDdsbnN3RWVhZkc1NFV5TUR1RUZ1WmtjeWY5ZDVseVoz?=
 =?utf-8?B?UWVQQ0dRQjFHQ0tyV2grOTk0Q2xZcEdLeXdsRVlDUExLNThEb05hZDlBelVh?=
 =?utf-8?B?d2JORUwrM3U0a1hvenVYV3BZVFhweUpadVlSaDNFZEVCOEFqaXJKZFVYRjJJ?=
 =?utf-8?B?eFNHWkNTY0RWcGN6NEVzeXh1SUxHRm1lRTgralFCUnNEaiswc0RtamkvM2tY?=
 =?utf-8?B?Wm9OUUZWVjlRNGF6RzcrYnliZWpQNkx0VkovUTJPb0FLbVBnbUs4ZmtvWXNa?=
 =?utf-8?B?VTVuckJINnc5VE94QWNpT1FtL3Z2elhRRHhUc1JhQWRMRzZVVkFYRXptc2pJ?=
 =?utf-8?B?TkdoTkNvM2hGc25ub0FzK3hyK1BlWitCNDhoWFQ5cGwvQlJiVWE5QzdqNFdQ?=
 =?utf-8?B?Y0FQTHdrNjVYL2hzNWtuU3Uremc3R1F5eFVyYThyVjNjUFZVazZKVDU0OFBN?=
 =?utf-8?B?RWxFVk82d1VYOUVnMGhpQVI1dXZRcmlNNnZBeS9sZ1RyaVVUbGZwUm41WXhI?=
 =?utf-8?B?MnlleTFDMzhqcU96VSswbzJhS0RGQklyNUNZajdhZzRNaUlVaXhxVHFrSUxm?=
 =?utf-8?B?YkZaVGs0d2JyRHFSdkhMb3NGMlptTmtkSTdsTGw4STZTVUY1ZkpFQ0JZQlBr?=
 =?utf-8?Q?ylNbr0pIqilS6of5fjBt6hzE1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9f275d-8c04-45de-3594-08dbcf83aa81
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 02:41:01.0754 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AlhH4BGnz+s8n/8s1L8VvuFJG5nfelTcUgiAha3c4dCVV2omQW8sOC+YdsL3/G7aYAnksOzDrjvDRQNWfgEfbRBDHCDmAGFJW0Ktm48ToUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6928
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMTcs
IDIwMjMgMTE6NTEgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYyIDAyLzI3XSB2ZmlvOiBJbnRy
b2R1Y2UgYmFzZSBvYmplY3QgZm9yIFZGSU9Db250YWluZXIgYW5kDQo+dGFyZ2V0dGVkIGludGVy
ZmFjZQ0KPg0KPk9uIDEwLzE2LzIzIDEwOjMxLCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IEZy
b206IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+DQo+PiBJbnRyb2R1Y2Ug
YSBkdW1iIFZGSU9Db250YWluZXIgYmFzZSBvYmplY3QgYW5kIGl0cyB0YXJnZXR0ZWQgaW50ZXJm
YWNlLg0KPj4gVGhpcyBpcyB3aWxsaW5nbHkgbm90IGEgUU9NIG9iamVjdCBiZWNhdXNlIHdlIGRv
bid0IHdhbnQgaXQgdG8gYmUNCj4+IHZpc2libGUgZnJvbSB0aGUgdXNlciBpbnRlcmZhY2UuICBU
aGUgVkZJT0NvbnRhaW5lciB3aWxsIGJlIHNtb290aGx5DQo+PiBwb3B1bGF0ZWQgaW4gc3Vic2Vx
dWVudCBwYXRjaGVzIGFzIHdlbGwgYXMgaW50ZXJmYWNlcy4NCj4+DQo+PiBObyBmdWNudGlvbmFs
IGNoYW5nZSBpbnRlbmRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmlj
LmF1Z2VyQHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGlu
dGVsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwu
Y29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCAgICAg
ICAgIHwgIDggKy0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgg
fCA4MiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA4
NCBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4NCj4+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaCBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNv
bW1vbi5oDQo+PiBpbmRleCAzNDY0OGU1MThlLi45NjUxY2Y5MjFjIDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92
ZmlvLWNvbW1vbi5oDQo+PiBAQCAtMzAsNiArMzAsNyBAQA0KPj4gICAjaW5jbHVkZSA8bGludXgv
dmZpby5oPg0KPj4gICAjZW5kaWYNCj4+ICAgI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCINCj4+
ICsjaW5jbHVkZSAiaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmgiDQo+Pg0KPj4gICAjZGVm
aW5lIFZGSU9fTVNHX1BSRUZJWCAidmZpbyAlczogIg0KPj4NCj4+IEBAIC04MSw2ICs4Miw3IEBA
IHR5cGVkZWYgc3RydWN0IFZGSU9BZGRyZXNzU3BhY2Ugew0KPj4gICBzdHJ1Y3QgVkZJT0dyb3Vw
Ow0KPj4NCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0xlZ2FjeUNvbnRhaW5lciB7DQo+PiArICAg
IFZGSU9Db250YWluZXIgYmNvbnRhaW5lcjsNCj4NCj5UaGF0J3MgdGhlIHBhcmVudCBjbGFzcywg
cmlnaHQgPw0KDQpSaWdodC4NCg0KPg0KPj4gICAgICAgVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2U7
DQo+PiAgICAgICBpbnQgZmQ7IC8qIC9kZXYvdmZpby92ZmlvLCBlbXBvd2VyZWQgYnkgdGhlIGF0
dGFjaGVkIGdyb3VwcyAqLw0KPj4gICAgICAgTWVtb3J5TGlzdGVuZXIgbGlzdGVuZXI7DQo+PiBA
QCAtMjAwLDEyICsyMDIsNiBAQCB0eXBlZGVmIHN0cnVjdCBWRklPRGlzcGxheSB7DQo+PiAgICAg
ICB9IGRtYWJ1ZjsNCj4+ICAgfSBWRklPRGlzcGxheTsNCj4+DQo+PiAtdHlwZWRlZiBzdHJ1Y3Qg
ew0KPj4gLSAgICB1bnNpZ25lZCBsb25nICpiaXRtYXA7DQo+PiAtICAgIGh3YWRkciBzaXplOw0K
Pj4gLSAgICBod2FkZHIgcGFnZXM7DQo+PiAtfSBWRklPQml0bWFwOw0KPj4gLQ0KPj4gICB2b2lk
IHZmaW9faG9zdF93aW5fYWRkKFZGSU9MZWdhY3lDb250YWluZXIgKmNvbnRhaW5lciwNCj4+ICAg
ICAgICAgICAgICAgICAgICAgICAgICBod2FkZHIgbWluX2lvdmEsIGh3YWRkciBtYXhfaW92YSwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50NjRfdCBpb3ZhX3Bnc2l6ZXMpOw0KPj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggYi9pbmNs
dWRlL2h3L3ZmaW8vdmZpby0NCj5jb250YWluZXItYmFzZS5oDQo+PiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMC4uYWZjODU0M2QyMg0KPj4gLS0tIC9kZXYvbnVsbA0K
Pj4gKysrIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4gQEAgLTAs
MCArMSw4MiBAQA0KPj4gKy8qDQo+PiArICogVkZJTyBCQVNFIENPTlRBSU5FUg0KPj4gKyAqDQo+
PiArICogQ29weXJpZ2h0IChDKSAyMDIzIEludGVsIENvcnBvcmF0aW9uLg0KPj4gKyAqIENvcHly
aWdodCBSZWQgSGF0LCBJbmMuIDIwMjMNCj4+ICsgKg0KPj4gKyAqIEF1dGhvcnM6IFlpIExpdSA8
eWkubC5saXVAaW50ZWwuY29tPg0KPj4gKyAqICAgICAgICAgIEVyaWMgQXVnZXIgPGVyaWMuYXVn
ZXJAcmVkaGF0LmNvbT4NCj4+ICsgKg0KPj4gKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQo+PiArICogaXQgdW5k
ZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNo
ZWQgYnkNCj4+ICsgKiB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lv
biAyIG9mIHRoZSBMaWNlbnNlLCBvcg0KPj4gKyAqIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVy
IHZlcnNpb24uDQo+PiArDQo+PiArICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRo
ZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwsDQo+PiArICogYnV0IFdJVEhPVVQgQU5ZIFdB
UlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YNCj4+ICsgKiBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
DQo+PiArICogR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4NCj4+
ICsNCj4+ICsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZw0KPj4gKyAqIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBu
b3QsIHNlZSA8aHR0cDovL3d3dy5nbnUub3JnL2xpY2Vuc2VzLz4uDQo+PiArICovDQo+PiArDQo+
PiArI2lmbmRlZiBIV19WRklPX1ZGSU9fQkFTRV9DT05UQUlORVJfSA0KPj4gKyNkZWZpbmUgSFdf
VkZJT19WRklPX0JBU0VfQ09OVEFJTkVSX0gNCj4+ICsNCj4+ICsjaW5jbHVkZSAiZXhlYy9tZW1v
cnkuaCINCj4+ICsjaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4+ICsjaW5jbHVkZSAiZXhlYy9o
d2FkZHIuaCINCj4+ICsjZW5kaWYNCj4+ICsNCj4+ICt0eXBlZGVmIHN0cnVjdCBWRklPQ29udGFp
bmVyIFZGSU9Db250YWluZXI7DQo+PiArdHlwZWRlZiBzdHJ1Y3QgVkZJT0RldmljZSBWRklPRGV2
aWNlOw0KPj4gK3R5cGVkZWYgc3RydWN0IFZGSU9JT01NVUJhY2tlbmRPcHNDbGFzcyBWRklPSU9N
TVVCYWNrZW5kT3BzQ2xhc3M7DQo+PiArDQo+PiArdHlwZWRlZiBzdHJ1Y3Qgew0KPj4gKyAgICB1
bnNpZ25lZCBsb25nICpiaXRtYXA7DQo+PiArICAgIGh3YWRkciBzaXplOw0KPj4gKyAgICBod2Fk
ZHIgcGFnZXM7DQo+PiArfSBWRklPQml0bWFwOw0KPj4gKw0KPj4gKy8qDQo+PiArICogVGhpcyBp
cyB0aGUgYmFzZSBvYmplY3QgZm9yIHZmaW8gY29udGFpbmVyIGJhY2tlbmRzDQo+PiArICovDQo+
PiArc3RydWN0IFZGSU9Db250YWluZXIgew0KPj4gKyAgICBWRklPSU9NTVVCYWNrZW5kT3BzQ2xh
c3MgKm9wczsNCj4NCj5UaGlzIGlzIHVuZXhwZWN0ZWQuDQo+DQo+SSB0aG91Z2h0IHRoYXQgYW4g
YWJzdHJhY3QgUU9NIG1vZGVsIGZvciBWRklPQ29udGFpbmVyIHdhcyBnb2luZw0KPnRvIGJlIGlu
dHJvZHVjZWQgd2l0aCBhIFZGSU9Db250YWluZXJDbGFzcyB3aXRoIHRoZSBvcHMgYmVsb3cNCj4o
VkZJT0lPTU1VQmFja2VuZE9wc0NsYXNzKS4NCj4NCj5UaGVuLCB3ZSB3b3VsZCBjYWxsIDoNCj4N
Cj4gICAgVkZJT0NvbnRhaW5lckNsYXNzICp2Y2MgPSBWRklPX0NPTlRBSU5FUl9HRVRfQ0xBU1Mo
Y29udGFpbmVyKTsNCj4NCj50byBnZXQgdGhlIHNwZWNpZmljIGltcGxlbWVudGF0aW9uIGZvciB0
aGUgY3VycmVudCBjb250YWluZXIuDQo+DQo+SSBkb24ndCB1bmRlcnN0YW5kIHRoZSBWRklPSU9N
TVVCYWNrZW5kT3BzQ2xhc3MgcG9pbnRlciBhbmQNCj5UWVBFX1ZGSU9fSU9NTVVfQkFDS0VORF9P
UFMuIEl0IHNlZW1zIHJlZHVuZGFudC4NCg0KVGhlIG9yaWdpbmFsIGltcGxlbWVudGF0aW9uIHdh
cyBhYnN0cmFjdCBRT00gbW9kZWwuIEJ1dCBpdCB3YXNuJ3QgYWNjZXB0ZWQsDQpzZWUgaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1ltdUZ2MnM1VFB1dzdLJTJGdUB5ZWtrby8gZm9yIGRldGFp
bHMuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

