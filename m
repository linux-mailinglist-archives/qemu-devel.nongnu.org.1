Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF572357A
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 04:50:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Mka-0005f6-7W; Mon, 05 Jun 2023 22:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q6MkY-0005en-1m
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 22:48:46 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q6MkW-0006PD-1C
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 22:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686019724; x=1717555724;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AAoHN7+SSEO328+2xG5oA9NGboRLzAka1q+KglICRd4=;
 b=PEaXdB96H0JHCtXuvloD3j+LzgEpeKlWVsW3ewyNhuT14WNtX7dsjW2H
 tUaFwVH6XXhRmTj+GyFiLGRqZvZLj370/NJ3cxciTZcWUipzulqrpjSi6
 HlOcC/7g/rdQ3lPU9kZ1rFbVLg09t3TH0jYH58UQGiStxdPINQLSLZcVP
 Tg9KcAA4fUn5jJAbhVeGtsiGxr5YCgPKjOOoNiZhNnE0Nbi8xyPXqqUtg
 lbN48aP6A3hPkk6/2uCI1jgPZwHK30MbmvYy7LUlEVOa8Ci5aFVRPZTye
 mVDvXTKqO8/zQtMSNkUwIuM0Uxqx/j3Dihpi+turE1clv47ibJnZEkWUL g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336167565"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; d="scan'208";a="336167565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 19:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="741963336"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; d="scan'208";a="741963336"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga001.jf.intel.com with ESMTP; 05 Jun 2023 19:48:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:48:38 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:48:37 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 19:48:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 19:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqg4TsOnmd7lG73dG/uxwpfP6k0JxUvLylfxQly/kYRd9SUHWaIsQHh0X9L4oR4r+Gv/NslqII4HU/KwrMSg9NY2/45PIkuaGF9BVJMxIPB3uKExLOk5ct4fjq+ECX7wMs9+dtLlFN18KY0rtyC+/pioeaEnh7lCq0n0SPOBDqzG72fYIuyjmDR0vF4R8502xAyexH2ZmaYVIvXMFIUTK9FmW+iOwxweLBm/ApNIQMzCov7UlCsY5LsAAejl15n6iLUT/mAYhblWGZXVor77KV1vjqPSuAoqEntqm9WQgaYeh3ebHQuKOdSxLQodWH7JshL5RiEGspZ/sLll8tHzgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAoHN7+SSEO328+2xG5oA9NGboRLzAka1q+KglICRd4=;
 b=ifKFhcLGejUVI+E49o4Z48ymVbRLjvDaKpulw2kxz+Izb9te8XmIL6qSikzXgLv+A7JFKrJxRkfKs0hTnvBaP3LN7/9UUy0MCNTvj4FurJiSNJKF/9GDVCwGgbKk3tr4k30Gifj0I413fWUiLwGFeoqo1LrHOoFfh2bRQ0F5OU0lSne/3NHhm56JyHn1bcGovh4TPaTjwpmYVr4TU1FVV2/3vsmZOM2z5TR20vOfLcEb3+3d64JqEFnEPtiX0HVEY1mnWpg0SjbNDIqgUb7uyeR1ac9AKj2hywVKt/PoHOtIWIRjynDo2mffLArCTVJYqS+Zr95GnJ7jBTQB+aXl7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 02:48:36 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 02:48:36 +0000
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
Subject: RE: [PATCH v2 3/4] memory: Document update on replay()
Thread-Topic: [PATCH v2 3/4] memory: Document update on replay()
Thread-Index: AQHZlFTPa2fkIa9/bkar+ZmG5huzwq98kiwAgACHRWA=
Date: Tue, 6 Jun 2023 02:48:36 +0000
Message-ID: <SJ0PR11MB6744A795722E36DD81C890949252A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-4-zhenzhong.duan@intel.com> <ZH4seudPfm2Dhhsg@x1n>
In-Reply-To: <ZH4seudPfm2Dhhsg@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7012:EE_
x-ms-office365-filtering-correlation-id: d108dc32-94f2-4767-8e24-08db6638867e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4B86BOvEtTAP3N9coE11qm/7UzLT6J3Agmr/hLFtNP2G2nql1GAa8baMTMiFbfnuBdTsABVnTCJ6B70jLr5Tm5KwO24XNydhTk4K9l8bPHLZi5vndx2axv+34vnH2xRI6lEShLXiKlE4PicEppqUAJiv13clRROolBIleAxWdxZxP3Hs72qvBDS3RtWzFFqgOAj+bf0PqFD6u1bMzjy4o/uOFYFi6ZPfv8p+Xh6yDAkcbyiE7mGQVoWHkTESROMpkvEfFt9ETqgkp3OLIdyf+m8rJpJNIjBo9NzAMhxe6VnuLwC3FdHzzSyET3V2EzOUBxgAFCZ5BRf284nUuXMT+xH2M/jUlrToyox9Au9ruGsosXYit7TI2Tj+c+1ug6wbETVzM/3v2j37UKh4a4+pTPjr9iQjVrh/Or3anaHwo3dRTO+V3Wits/1cwyfYl5BzkGciPL0/BPr+sW8bIXak3cEOps46Ben3+VhVO1LQSelT7nC+NRm43mgbF359dEMObDTewxHEQ0YBYiZ/oAdogHL5v533YuDCT1TE4BX1jNLkugYL79bVcF5bGgRRR/QhciszBQw4fkStC8Yy3y8PU/WiFLvZIN+MFp1v7SHGD4LQOWNCkCg4TtEHGC4E4zQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(71200400001)(7696005)(66446008)(82960400001)(2906002)(66556008)(76116006)(122000001)(64756008)(66476007)(66946007)(54906003)(8936002)(8676002)(5660300002)(38070700005)(86362001)(7416002)(38100700002)(52536014)(41300700001)(4326008)(6916009)(15650500001)(316002)(33656002)(55016003)(478600001)(6506007)(26005)(9686003)(107886003)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGtFMmRtalpEZWdXWEZ4eXJ1K0xtNER5WmVpT2c2bzhNRTNJdGprclFsdlk1?=
 =?utf-8?B?OXRpTExNMXFwOGJ4d0JDeFJSYzY2cG9MNnZNeitEMTYvd2NiaVBkMjhGb0li?=
 =?utf-8?B?K2h1a1B3NytLa3Z3WFZkVE9QU1M1RUsyUnFWVE4vU1lzTVpBaVR2QXhTeVRK?=
 =?utf-8?B?SzNkd2Ryei9FVUJwQ25xVndxbHNjY1dYTlF6RUJweXNRZ3I0RmZYNTFVOThz?=
 =?utf-8?B?dzFsQjhvTGYxcVVzTExSbWtBTmZLUXh4ZXFOMHFhbnlQbDhydzJnZWhqY25N?=
 =?utf-8?B?SHlnVjNNWVkrck5BM1ZtQW5Odi9Xd1h2aHhyQVVIanlLMnZWQjVYelRtYW5h?=
 =?utf-8?B?UkVmbzhsUjVYNWlMTGxqWEsza1N4eFFEdmRzNTZVdm5QOHdSc1NhT2o4RkZZ?=
 =?utf-8?B?Vllhb09YSXVyakJBM0xYbjlWY2xQdFhIdHN3cW1jb2FwL1cwTThlT1MySnpM?=
 =?utf-8?B?NmZ2YjZ4a1dsWXFydmVvZVI0Uko2TG96NkJyaFpSaUNuS3V2VVRPQ1k3TjNP?=
 =?utf-8?B?Y2IvWFNCSkNWZGdVUFVEdENyZEpYVjUyTkh4c3F5NndGUC9adnlFenExcnNs?=
 =?utf-8?B?N2lvVGw5a0orSmJVYVNkRi9nTUJGREhIdGtPNVVvdFQxWTBRek1OcWtIYVcz?=
 =?utf-8?B?WE1BT0VCNFN6ZWE5SjNtUzExRlBpek5jdHNtYUtyOUdseHJTNXZwMU5vZzlz?=
 =?utf-8?B?MGdxSVVVYlVxdTliNGRrWFVwcGV3VmxtOFhDaDlwSjBLeVdyYkQ2aHdiQlA3?=
 =?utf-8?B?YWVGQmtuL2w3Qms5NmRvRmh2UjkwVXlqYklKNFRWeTVkUjNmbmFXZ3huK1ZB?=
 =?utf-8?B?V2o1N295ZUxqUDg5b0RZY2kvVzNKOCtqaWVqYXhlblA3dFo3ck02M2dvV1lK?=
 =?utf-8?B?Y2t6aDY0dlBTcEVzWW5oSXo2dTU1OXRsUjZzS3pIRXhzNGhua1N4OUk1cmJa?=
 =?utf-8?B?dFJDK1JObmRVOHUwUlIvK1dtZFJSUDFwMmw2ejJwaHNrY2VMOUMzVGxML1p4?=
 =?utf-8?B?U21vSWxMUWxaZDFPcHhPMjRLRDVQdkFlS1M5TG8vKzZoV21NbXZMS2JRSVZV?=
 =?utf-8?B?cCtlTXVVWnJzU25RUDR1clA2cTBLeUY5Qm1RTEZoS1QrdGt2WVdBeFhpMDZT?=
 =?utf-8?B?MWlQcmFodTVxT1hOdGlmNzhDWDF1VkE1T0NyR2tjUnNFTmVpYW94dlVwMFdY?=
 =?utf-8?B?d3JVVWROMHFSZzhibzNxNWFLbU1ZM1c4QzNZRUE4VVRjM2lGUEFuMUJscUhn?=
 =?utf-8?B?RjA1OEJXMEJOTkdkR2UrdTNEWGNLcXV4Ukh2TXdYdjlsOHdld0szend3L05P?=
 =?utf-8?B?TGNpbVRvRk1SdVcwcnVDUDlkNklSdE5DeFpCQ2w3MStDZEZOdlBOcncrRFRv?=
 =?utf-8?B?Q3ArMmppamVJQ2VrengzMXE4Z3FOZGFMVDF2aExSbzBGNTBibURaaTlXTDNh?=
 =?utf-8?B?cE5zbXl6clVFcmFjVVAxTThYQ2dZTnN6b0tPOEFLRm5jYmhTZ01KMFh0V2hK?=
 =?utf-8?B?M2EyZE5XdjB6dWFxY3V3bjl5TmFxMnFvZVZ5VGl1VmpYd3pyRSs1T0IvZ1pE?=
 =?utf-8?B?VytKMlM5Q0dYSjk1cm4zQXFmVExLcitjeTQ3VXVRRlJhcDlNeXZSK2hycXJJ?=
 =?utf-8?B?T3dmTEZKejhXL0IyK3JabnVQbW9rSThESUc4Y1pZNkdtM0hlY1N1WGJhYVZ5?=
 =?utf-8?B?RUQ3N1EwSHpTQlYzNmk4RHpxQ3lsRGQ2MllPaWVKczZkTGp2aE95Tno5TEF2?=
 =?utf-8?B?VjBBMjlDMmVSM0V4ZnhMWCsrcHZhaWlhNG5DQUwya1lNTDZMeERxa1R2RUlI?=
 =?utf-8?B?a21MVENOWVhwTEtvdlRxOFFXVmRZOGV4UmRweUJhNzFQcWdjSGdOVGpzZFBD?=
 =?utf-8?B?MGZFcDRmS0praGVoN3MxNVBidHNWQUs2akRNSHVlRmpOU2RlUndROWpoczl6?=
 =?utf-8?B?UVBlazFuSjVRbklqMkFsSjUraGhyaGNmMXlwUzUwb1J5WHZkeWJYRjY3NC9v?=
 =?utf-8?B?WUdFSlMvNzYxaUk4dkc4NFZOT2Y0a1YzMWRHUll2ZWRpaUdNSFFtNHhDK1U1?=
 =?utf-8?B?MFBqb1NkRUhZU2hTOFlhWUVSNTA2L0xKT3djcTR4bUFKQk1DTDBDVy9RUVEx?=
 =?utf-8?Q?+fwSLoY48GJvK7t3hOK3b5TAf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d108dc32-94f2-4767-8e24-08db6638867e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 02:48:36.3577 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6uXavgtwHRPJB8HZnu97x06Psyw0NHw6HIxV59YsroQGBt3kFzqXGMA07Wi710x24nUpx+tyTHsdOvsQCRhgxhVJ9TdnArbDDeOlpdtSC6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7012
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
YXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEp1bmUgNiwgMjAyMyAyOjQyIEFNDQo+VG86IER1YW4s
IFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNjOiBxZW11LWRldmVsQG5v
bmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPnBib256aW5p
QHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IGVkdWFyZG9AaGFia29z
dC5uZXQ7DQo+bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb207IGFsZXgud2lsbGlhbXNvbkByZWRo
YXQuY29tOw0KPmNsZ0ByZWRoYXQuY29tOyBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGluYXJv
Lm9yZzsNCj5rd2Fua2hlZGVAbnZpZGlhLmNvbTsgY2ppYUBudmlkaWEuY29tOyBMaXUsIFlpIEwg
PHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsDQo+Q2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRlbC5j
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAzLzRdIG1lbW9yeTogRG9jdW1lbnQgdXBkYXRl
IG9uIHJlcGxheSgpDQo+DQo+T24gVGh1LCBKdW4gMDEsIDIwMjMgYXQgMDI6MzM6MTlQTSArMDgw
MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL21l
bW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oIGluZGV4DQo+PiBlZWNjM2VlYzY3MDIuLjlh
NTIzZWY2MmE5NCAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPj4gKysr
IGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiBAQCAtNDQxLDkgKzQ0MSw5IEBAIHN0cnVjdCBJ
T01NVU1lbW9yeVJlZ2lvbkNsYXNzIHsNCj4+ICAgICAgICogY2FsbCB0aGUgSU9NTVUgdHJhbnNs
YXRlIG1ldGhvZCBmb3IgZXZlcnkgcGFnZSBpbiB0aGUgYWRkcmVzcyBzcGFjZQ0KPj4gICAgICAg
KiB3aXRoIGZsYWcgPT0gSU9NTVVfTk9ORSBhbmQgdGhlbiBjYWxsIHRoZSBub3RpZmllciBpZiB0
cmFuc2xhdGUNCj4+ICAgICAgICogcmV0dXJucyBhIHZhbGlkIG1hcHBpbmcuIElmIHRoaXMgbWV0
aG9kIGlzIGltcGxlbWVudGVkIHRoZW4gaXQNCj4+IC0gICAgICogb3ZlcnJpZGVzIHRoZSBkZWZh
dWx0IGJlaGF2aW91ciwgYW5kIG11c3QgcHJvdmlkZSB0aGUgZnVsbCBzZW1hbnRpY3MNCj4+IC0g
ICAgICogb2YgbWVtb3J5X3JlZ2lvbl9pb21tdV9yZXBsYXkoKSwgYnkgY2FsbGluZyBAbm90aWZp
ZXIgZm9yIGV2ZXJ5DQo+PiAtICAgICAqIHRyYW5zbGF0aW9uIHByZXNlbnQgaW4gdGhlIElPTU1V
Lg0KPj4gKyAgICAgKiBvdmVycmlkZXMgdGhlIGRlZmF1bHQgYmVoYXZpb3IsIGFuZCBtdXN0IHBy
b3ZpZGUgY29ycmVzcG9uZGluZw0KPj4gKyAgICAgKiBzZW1hbnRpY3MgZGVwZW5kaW5nIG9uIG5v
dGlmaWVyJ3MgdHlwZSwgZS5nLiBJT01NVV9OT1RJRklFUl9NQVAsDQo+PiArICAgICAqIG5vdGlm
eSBjaGFuZ2VkIGVudHJpZXM7IElPTU1VX05PVElGSUVSX0ZVTExfTUFQLCBub3RpZnkgZnVsbA0K
PmVudHJpZXMuDQo+DQo+SUlVQyBpdCB3YXMgYWx3YXlzIHRyeWluZyB0byBub3RpZnkgYWxsIGV4
aXN0aW5nIGVudHJpZXMgb25seSwgcmF0aGVyIHRoYW4gY2hhbmdlZA0KPmVudHJpZXMuICBWVC1k
IHVzZWQgdG8gdW5tYXAgYWxsIHNvIGl0IHdhcyBhbHNvIHRydWUuDQoNClRoYW5rcyBmb3IgcG9p
bnQgb3V0LCBJIGNvbmZ1c2VkIHdpdGggaW52YWxpZGF0aW9uIHBhdGgsIEknbGwgZHJvcCBpdC4N
Cg0KWmhlbnpob25nIA0K

