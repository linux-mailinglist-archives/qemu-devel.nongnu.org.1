Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2D7D90F5
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwI1T-0003fV-Lr; Fri, 27 Oct 2023 04:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwI1Q-0003fB-BI
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:16:48 -0400
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwI1M-0000bK-KD
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 04:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698394604; x=1729930604;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=IHZDfgGcPNu0PgJAyCAk8x1xxM0yJZVHZR9im9itwbM=;
 b=H8HRvGTTxOMbnHV9VpJegHtvyk46EoFOYgIq2qwdL7mbHbQJslTuxlSe
 7Kr+FmZP5tYwcrxKzNIheM46uvbkYUdWEtEDLLjxlLVuwzdiNoGcOWS9Q
 h0DuCKqfUBtzqv9aqUaxcLblr3XIkr4qOugjSXxf3Vg+98uvFAm1aokXA
 S0z30Qo/XcT5bygAn/Zeo39RtlCB6iC5c5yxdxHnGY5n6Lw21DKxIQHh9
 7L3P6Sh+ds/KQ6XdBU4ODYpeM6HdH0z4aYp4KUlRcJFXGBGEtDjWAhU7b
 HfUFygBMY4gmOdJPhem7sPlzPnavdp9Fwk60Kb0xaXlUdUQRmooJ+ipoM A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="451971208"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="451971208"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 01:16:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="788765605"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="788765605"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Oct 2023 01:16:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 01:16:41 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 01:16:40 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 01:16:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 01:16:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2hD7wXudbWxjPewiTeQcapZDPV10518oR7d9ihkAvHse3AYKZdGGdnl/BDmkl7NlY5e7nrWJ7wgNZYM7i1hfQfVALGCZMBd7sSSOcLjTdHW/fWJRqwnWt2xjI8W4xx3zJjAgC9cdJzZ46TIDCByzdxFhHTFsxqM4zl/n3+78D1iV4k2BJ9VXQXdYSFHFxPy1KcGa3vUrRNFyqjg/u8a4yRsKppQorv9Fb4/9Aye4gilGPkPKMjeCuwdtwX4+wZ9ks1qum97KMax5B+D2zjSGKr9P7SW5oYDNxE5KLDUFfrKoDbhLSujQ1Aw6fhn7FW8juKtLUjfb/X0CGMAFcUr5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHZDfgGcPNu0PgJAyCAk8x1xxM0yJZVHZR9im9itwbM=;
 b=Gg15oAQ2CA6gy81UrCu8tv4dvYhIxaEVLrSuYAYd/qdJGs8QCn4LBFKmDFdsesn5X/oXugMjgfWCKNAIbXCZeLtQxAvA6zCpra22Roj2C7J8J3ydPD9Fr8duUTno845s3Kad1QmNVuxHtVqyrTUQSzKNsguJOh6fGq2lHA/q6IVXMLAct5ItLF5aymzbHa/UNt6uR5zEgWoIUclpwi4EWCY1F/6cxIo28bXcetVp34bFOh/c39oH2eCEqqyYkP1dnRIgZ84Z0/V1Kl0snTHEYoGGuluO8yYki41koFZzFj8xPgVwwN3cpSiMmLC0bynNPahXwPY1EccD3ZZMpi/A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB7986.namprd11.prod.outlook.com (2603:10b6:510:241::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 08:16:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::bb35:72a8:1513:c13f]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::bb35:72a8:1513:c13f%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 08:16:36 +0000
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
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 00/37] vfio: Adopt iommufd
Thread-Topic: [PATCH v3 00/37] vfio: Adopt iommufd
Thread-Index: AQHaB/mk3OZfME1nkEqcJ7AgvbMva7BcEGj2gAEYzMCAABn/AIAAA1ag
Date: Fri, 27 Oct 2023 08:16:36 +0000
Message-ID: <SJ0PR11MB6744E698D21BFECA2A5B427B92DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <87o7gla508.fsf@pond.sub.org>
 <SJ0PR11MB67444B3A1BE0FAE6934ABAD592DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <d4e5771e-08e4-46b5-97d4-570b4883e4f7@redhat.com>
In-Reply-To: <d4e5771e-08e4-46b5-97d4-570b4883e4f7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB7986:EE_
x-ms-office365-filtering-correlation-id: f3f3c88e-96d9-4d62-f5f0-08dbd6c509a6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwhAdm8P+kYOq2rG0rU7K5h1JtnTvrUoj9yn5U+So37JYi5WIplt7K9oKAxGudPWzNAQ5tYbAuxmsEg+V5465qRs02EfXRiaItUxV7bjGeegudiwn6MfsJDdqQAIsf0GA0poGbxks42X1zPyBRzjsVCoXUsfrEpYGPislgIs9u8sKcOkXU4fN2hCvotNAa9b1smm8DOM7JTFJG0IhoU222Da2b/6En1birMMFPIbp0Hz686zO/aa/q9qx93u+Uqd4AJ384JQrTwBkDdCpFzRsl99+NX4Pkr//Xx742B63Bws27VnVE3TlYc2ng27rnkHlbqGZkCTVKf/jWMEwqOeuQcSX12ai5uKWlrPQbpMjDnL7kSVcbmk7tXpsTyvY5gBhfr1mbw+LhLtzQ13rTTFxXuvt1OtKk7E9PfI1JlzcznDjKC/bHk1WB+ULO8R5VhGRjhqo+8EwOfPAsRB44OLTI5Yq6NOjdEIAibucwgfhd6QUa5k976srYlOAxFWl2uuiCdzgywcmOfSMGcFqKyJPckB3acUqc3/IYlm93vRIPfZ6qITFwVXqHfqU8K8ckgQo0uh1ML/BqjLJXquQYZ7bLbIa4aO0jZqEg7bfcmcap5fRQNiWTtUhSlnZbhyMsyttaTYQ6iy8Qyu5vCH5hPOVQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(451199024)(1800799009)(38070700009)(26005)(38100700002)(5660300002)(2906002)(55016003)(41300700001)(52536014)(86362001)(316002)(82960400001)(8936002)(7416002)(33656002)(8676002)(4326008)(122000001)(7696005)(6506007)(107886003)(76116006)(53546011)(478600001)(71200400001)(66446008)(66476007)(110136005)(54906003)(66556008)(64756008)(66946007)(83380400001)(66574015)(966005)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFNwY3hORm5sZ2JWODlHN1YxSzhsWmo1UnR3dmdNTTNMcHo3TTJSUFduZlJu?=
 =?utf-8?B?VEJIOEFtMUkwTFdncnRQSW9vMjYvVXdwWFo4U0Nmdy9UN0lMQmd0NjlqWTVx?=
 =?utf-8?B?T0pDdzcrd0lTT0g2MXhnWmRXNTk0cmtJVFhQSWpUM2ZFK2kwOUU3RGF1elRZ?=
 =?utf-8?B?RlhQL1pkSkJVTDUwaStWNHoyemRKbFdyVWdGWnlYMHh6VW1uWXc4QVB5YTRw?=
 =?utf-8?B?VnhlL2hxdE1QSVBCV3FPTWU3RE5IaVFZL1ZrSnRud0NQSUtqczBKajRMS1g1?=
 =?utf-8?B?RmllYWV3WVRzZyt5elFYbEJnUXFHUk9JR3UvVEg1bUJiNk9Fb2FiVzFLaHk2?=
 =?utf-8?B?QjZGaVFGTEdGU1lheUFXQWUxUmJ4UUdZWitobWs1dGZnZ2d0S3RxdVorUkk4?=
 =?utf-8?B?Q2pRVklmVE5zSGNIV1NTcHI5Nk9hMnVmZCtMc3p0ZGtTRzUwNkNzUjAzYWc4?=
 =?utf-8?B?dzBWVHhHQWJnUkNOeXV6T3BDeHRacFpITFdhZkY0bXk0TWxnam05NDB5aUV5?=
 =?utf-8?B?RnVuaTBDUGg5ZDhYemFxN25zaUF1NnBhTlgvV1JuREF4NWw5bnBsNFYzNUl0?=
 =?utf-8?B?U0g4Q2xNMDNwL0tLdkNRNkdUV2ZlWmZmWlpNWG9BclA4Z3NnTWlJQVZwRUVa?=
 =?utf-8?B?b2Y2d1BFbWdoK2txY0UwTUZyN213SHUxU0RYcUNTT1ZXS09oVEdvcXpjYjZN?=
 =?utf-8?B?QzBRNGlOeGpPR3lhaGt1Q3pCTFdncmoxL2tseFNSdHNWS014NkRpc2htTllk?=
 =?utf-8?B?ODVzTEtJcnc5aWpUMmo3OE5GcnlTYlJkUFRZNlhCOTVoQ3BWckZVK014NzJS?=
 =?utf-8?B?ZzF6SkQvM0JQNUdOZUZobUc4TnNvdVJxR2t5dmhWT3JNTFJvREhOR3lNcTIz?=
 =?utf-8?B?NUJvSFcxMDZ0UzBPQlFUaTFLQ2gzdk1jbkduaGVub3RVUGlKSVlLRGEzSy95?=
 =?utf-8?B?MEczby9MR0pkY3BMUlRBMWJEMm1qWnBpNmdTR1hxcFdicCtuNC9MUE0yc3Fl?=
 =?utf-8?B?Zk14dmZNOWcvSlIxM1luRG8vUVY0bVZablBWYjBYSjc2bnN6TGU4Z3lyN3hZ?=
 =?utf-8?B?UzR1Qk4wSXd1N1R0ZS9MZzhZNUFIcEtSa3ZnL1V5WTBBYkJVTHJKVWhuNXIw?=
 =?utf-8?B?a2VVNWhROHZ6anY0bjRMUDdYaExXSThMSFpmd3pZb08vQ2ZLMk55Q3JTbVpK?=
 =?utf-8?B?akx1b0UrbFZJSlVHUXpXaThlQWZaNTNSdUVSb2pBY0VGOUxvMzkrRHhjZGsv?=
 =?utf-8?B?dVJhUUFDL0lSVG1IYXoyQXAyQnI1WkRzd1J5c2F2anovelhBWVZ1aVZhZTJ1?=
 =?utf-8?B?THpKcTRNQ1hHN24xcnR0TkIwdXQ5amxHMXBGM1kxSDFkYlRuWmlpc0dRTjRt?=
 =?utf-8?B?cXBDdUc3bjBKc0dDK1BzcmowNkRvR24wYm9GSVordTVzc2I4MnJVdjc1WCt5?=
 =?utf-8?B?WjIvekFCR3cwbHVYNlRsTDhuaFBTajJacmJxLzArL0NzT2R0OVE1ZWtvVXJ1?=
 =?utf-8?B?aGpkQjJ4VnF3cEFoVjJPU2FDdmVadHVkblZWYnVMN25kK1RqSUhIdDlkaFVI?=
 =?utf-8?B?R2IxdVdLUjI0dFd0a042WUQ4TXJHc1hza3ZNOURRRGVxVGY3RXpnTWhSMjhM?=
 =?utf-8?B?WHptQS9ZU0NOSTBuVnp4WFZQUVdUdkFKbHV5Uy9kdEhOWVdmeXdvTFRjQjJD?=
 =?utf-8?B?cnNQamNqaTNDRkdxWERGSDNNVGU2SjhYZlZ6bXRGaGc1YVlQaytaU1Z1ZjRl?=
 =?utf-8?B?MERwUUFuaWF4ZWNnSTFKYXBVeEoyd25IdFRiOGFaWURxRGtVekkzbHJ2QjZU?=
 =?utf-8?B?Q0UwL2pIWmtGeGkvVDFmbVg5YTBJaFYxVlJORmhZWjd5OHhOd3dKYlhjYUNG?=
 =?utf-8?B?U3N5eGw5bW0waGhsaCtJT3hlbWN0M3UxZUlId2pQRVAzYjVKS3Q4ZndXdk5m?=
 =?utf-8?B?WlhqRGpkL0hIRHIwYWI2TXFrYTRSVHB3WWoxMXlkendsQ3h4WXlvV2pUeCtr?=
 =?utf-8?B?RlBaS2kvZ3hENWpVangyeWI0NnozNUJsZ0UyUzAxMHNOUU5GTjZsYld1UUFZ?=
 =?utf-8?B?cjVxNXJoS2RrUzZIcHBsY0J3NGJ2WkJPQzc3ZzVmWTFSUE0rV2MxYmVkWnJN?=
 =?utf-8?Q?HZknkNnTr2RtjBN034YPul1+y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f3c88e-96d9-4d62-f5f0-08dbd6c509a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 08:16:36.1806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5HjAuJ/6T9zy4IFFByfpvAUbs/TUaVgCa2BlFnktL+zwYzjboJB9k7bGol48yaTQsB9OzbaPrFg+JymxBzK2viIW4kZh3S2XenJflnxb9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7986
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAyNywg
MjAyMyAzOjQ2IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAwMC8zN10gdmZpbzogQWRvcHQg
aW9tbXVmZA0KPg0KPk9uIDEwLzI3LzIzIDA4OjE3LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+
PiBIaSBNYXJrdXMsDQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJv
bTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KPj4+IFNlbnQ6IFRodXJz
ZGF5LCBPY3RvYmVyIDI2LCAyMDIzIDk6MjcgUE0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYz
IDAwLzM3XSB2ZmlvOiBBZG9wdCBpb21tdWZkDQo+Pj4NCj4+PiBaaGVuemhvbmcgRHVhbiA8emhl
bnpob25nLmR1YW5AaW50ZWwuY29tPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gSGksDQo+Pj4+DQo+Pj4+
IFRoYW5rcyBhbGwgZm9yIGdpdmluZyBndWlkZXMgYW5kIGNvbW1lbnRzIG9uIHByZXZpb3VzIHNl
cmllcywgaGVyZSBpcw0KPj4+PiB0aGUgdjMgb2YgcHVyZSBpb21tdWZkIHN1cHBvcnQgcGFydC4N
Cj4+Pj4NCj4+Pj4gQmFzZWQgb24gQ8OpZHJpYydzIHN1Z2dlc3Rpb24sIHRoaXMgc2VyaWVzIGlu
Y2x1ZGVzIGFuIGVmZm9ydCB0byByZW1vdmUNCj4+Pj4gc3BhcHIgY29kZSBmcm9tIGNvbnRhaW5l
ci5jLCBub3cgYWxsIHNwYXByIGZ1bmN0aW9ucyBhcmUgbW92ZWQgdG8gc3BhcHIuYw0KPj4+PiBv
ciBzcGFwcl9wY2lfdmZpby5jLCBidXQgdGhlcmUgYXJlIHN0aWxsIGEgZmV3IHRyaXZhbCBjaGVj
ayBvbg0KPj4+PiBWRklPX1NQQVBSX1RDRV8qX0lPTU1VIHdoaWNoIEkgYW0gbm90IHN1cmUgaWYg
ZGVzZXJ2ZWQgdG8gaW50cm9kdWNlDQo+bWFueQ0KPj4+PiBjYWxsYmFja3MgYW5kIGR1cGxpY2F0
ZSBjb2RlIGp1c3QgdG8gcmVtb3ZlIHRoZW0uIFNvbWUgZnVuY3Rpb25zIGFyZSBtb3ZlZA0KPj4+
PiB0byBzcGFwci5jIGluc3RlYWQgb2Ygc3BhcHJfcGNpX3ZmaW8uYyB0byBhdm9pZCBjb21waWxl
IGlzc3VlIGJlY2F1c2UNCj4+Pj4gc3BhcHJfcGNpX3ZmaW8uYyBpcyBhcmNoIHNwZWNpZmljLCBv
ciBlbHNlIHdlIG5lZWQgdG8gaW50cm9kdWNlIHN0dWINCj4+Pj4gZnVuY3Rpb25zIHRvIHRob3Nl
IHNwYXByIGZ1bmN0aW9ucyBtb3ZlZC4NCj4+Pg0KPj4+IFsuLi5dDQo+Pj4NCj4+Pj4gcWVtdSBj
b2RlOg0KPj4+IGh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56
aG9uZy9pb21tdWZkX2NkZXZfdjMNCj4+Pj4gQmFzZWQgb24gdmZpby1uZXh0LCBjb21taXQgaWQ6
IGZkMGUxYzhiYzENCj4+Pg0KPj4+IEkgZmV0Y2hlZCB0aGlzLCBhbmQgZ2V0IHNldmVyYWwgY29t
cGlsZSBlcnJvcnMgd2l0aCBDbGFuZyAoYnV0IG5vdCB3aXRoDQo+Pj4gR0NDKToNCj4+Pg0KPj4+
ICAgICBGQUlMRUQ6IGxpYnFlbXUteDg2XzY0LXNvZnRtbXUuZmEucC9od192ZmlvX2NvbW1vbi5j
Lm8NCj4+PiAgICAgY2xhbmcgLW02NCAtbWN4MTYgLUlsaWJxZW11LXg4Nl82NC1zb2Z0bW11LmZh
LnAgLUkuIC1JLi4gLUl0YXJnZXQvaTM4NiAtDQo+Pj4gSS4uL3RhcmdldC9pMzg2IC1JcWFwaSAt
SXRyYWNlIC1JdWkgLUl1aS9zaGFkZXIgLUkvdXNyL2luY2x1ZGUvcGl4bWFuLTEgLQ0KPj4+IEkv
dXNyL2luY2x1ZGUvY2Fwc3RvbmUgLUkvdXNyL2luY2x1ZGUvc3BpY2Utc2VydmVyIC1JL3Vzci9p
bmNsdWRlL3NwaWNlLTEgLQ0KPj4+IEkvdXNyL2luY2x1ZGUvY2FjYXJkIC1JL3Vzci9pbmNsdWRl
L2dsaWItMi4wIC1JL3Vzci9saWI2NC9nbGliLTIuMC9pbmNsdWRlIC0NCj4+PiBJL3Vzci9pbmNs
dWRlL3N5c3Byb2YtNCAtSS91c3IvaW5jbHVkZS9uc3MzIC1JL3Vzci9pbmNsdWRlL25zcHI0IC0N
Cj4+PiBJL3Vzci9pbmNsdWRlL1BDU0MgLWZjb2xvci1kaWFnbm9zdGljcyAtV2FsbCAtV2ludmFs
aWQtcGNoIC1XZXJyb3IgLQ0KPnN0ZD1nbnUxMSAtDQo+Pj4gTzIgLWcgLWZzdGFjay1wcm90ZWN0
b3Itc3Ryb25nIC1XdW5kZWYgLVd3cml0ZS1zdHJpbmdzIC1XbWlzc2luZy0NCj5wcm90b3R5cGVz
IC0NCj4+PiBXc3RyaWN0LXByb3RvdHlwZXMgLVdyZWR1bmRhbnQtZGVjbHMgLVdvbGQtc3R5bGUt
ZGVmaW5pdGlvbiAtV3R5cGUtbGltaXRzIC0NCj4+PiBXZm9ybWF0LXNlY3VyaXR5IC1XZm9ybWF0
LXkyayAtV2luaXQtc2VsZiAtV2lnbm9yZWQtcXVhbGlmaWVycyAtV2VtcHR5LQ0KPmJvZHkNCj4+
PiAtV25lc3RlZC1leHRlcm5zIC1XZW5kaWYtbGFiZWxzIC1XZXhwYW5zaW9uLXRvLWRlZmluZWQg
LVdtaXNzaW5nLWZvcm1hdC0NCj4+PiBhdHRyaWJ1dGUgLVduby1pbml0aWFsaXplci1vdmVycmlk
ZXMgLVduby1taXNzaW5nLWluY2x1ZGUtZGlycyAtV25vLXNoaWZ0LQ0KPj4+IG5lZ2F0aXZlLXZh
bHVlIC1Xbm8tc3RyaW5nLXBsdXMtaW50IC1Xbm8tdHlwZWRlZi1yZWRlZmluaXRpb24gLVduby0N
Cj4+PiB0YXV0b2xvZ2ljYWwtdHlwZS1saW1pdC1jb21wYXJlIC1Xbm8tcHNhYmkgLVduby1nbnUt
dmFyaWFibGUtc2l6ZWQtdHlwZS0NCj5ub3QtDQo+Pj4gYXQtZW5kIC1XdGhyZWFkLXNhZmV0eSAt
aXN5c3RlbSAvd29yay9hcm1icnUvcWVtdS9saW51eC1oZWFkZXJzIC1pc3lzdGVtDQo+Pj4gbGlu
dXgtaGVhZGVycyAtaXF1b3RlIC4gLWlxdW90ZSAvd29yay9hcm1icnUvcWVtdSAtaXF1b3RlDQo+
Pj4gL3dvcmsvYXJtYnJ1L3FlbXUvaW5jbHVkZSAtaXF1b3RlDQo+L3dvcmsvYXJtYnJ1L3FlbXUv
aG9zdC9pbmNsdWRlL3g4Nl82NCAtDQo+Pj4gaXF1b3RlIC93b3JrL2FybWJydS9xZW11L2hvc3Qv
aW5jbHVkZS9nZW5lcmljIC1pcXVvdGUNCj4+PiAvd29yay9hcm1icnUvcWVtdS90Y2cvaTM4NiAt
cHRocmVhZCAtRF9HTlVfU09VUkNFIC0NCj4+PiBEX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLURfTEFS
R0VGSUxFX1NPVVJDRSAtZm5vLXN0cmljdC1hbGlhc2luZyAtZm5vLQ0KPj4+IGNvbW1vbiAtZndy
YXB2IC1mc2FuaXRpemUtY292ZXJhZ2UtYWxsb3dsaXN0PWluc3RydW1lbnRhdGlvbi1maWx0ZXIg
LQ0KPj4+IGZzYW5pdGl6ZT1mdXp6ZXItbm8tbGluayAtZlBJRSAtaXN5c3RlbS4uL2xpbnV4LWhl
YWRlcnMgLWlzeXN0ZW1saW51eC1oZWFkZXJzIC0NCj4+PiBETkVFRF9DUFVfSCAnLURDT05GSUdf
VEFSR0VUPSJ4ODZfNjQtc29mdG1tdS1jb25maWctdGFyZ2V0LmgiJyAnLQ0KPj4+IERDT05GSUdf
REVWSUNFUz0ieDg2XzY0LXNvZnRtbXUtY29uZmlnLWRldmljZXMuaCInIC1NRCAtTVEgbGlicWVt
dS0NCj4+PiB4ODZfNjQtc29mdG1tdS5mYS5wL2h3X3ZmaW9fY29tbW9uLmMubyAtTUYgbGlicWVt
dS14ODZfNjQtDQo+Pj4gc29mdG1tdS5mYS5wL2h3X3ZmaW9fY29tbW9uLmMuby5kIC1vIGxpYnFl
bXUteDg2XzY0LQ0KPj4+IHNvZnRtbXUuZmEucC9od192ZmlvX2NvbW1vbi5jLm8gLWMgLi4vaHcv
dmZpby9jb21tb24uYw0KPj4+ICAgICAuLi9ody92ZmlvL2NvbW1vbi5jOjY4Mjo0MDogZXJyb3I6
IHZhcmlhYmxlICdob3N0d2luJyBpcyB1bmluaXRpYWxpemVkIHdoZW4NCj4+PiB1c2VkIGhlcmUg
Wy1XZXJyb3IsLVd1bmluaXRpYWxpemVkXQ0KPj4+ICAgICAgICAgICAgIGh3YWRkciBwZ21hc2sg
PSAoMVVMTCA8PCBjdHo2NChob3N0d2luLT5pb3ZhX3Bnc2l6ZXMpKSAtIDE7DQo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn4NCj4+PiAgICAgLi4v
aHcvdmZpby9jb21tb24uYzo1Nzg6MzE6IG5vdGU6IGluaXRpYWxpemUgdGhlIHZhcmlhYmxlICdo
b3N0d2luJyB0bw0KPnNpbGVuY2UNCj4+PiB0aGlzIHdhcm5pbmcNCj4+PiAgICAgICAgIFZGSU9I
b3N0RE1BV2luZG93ICpob3N0d2luOw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA9IE5VTEwNCj4+
PiAgICAgLi4vaHcvdmZpby9jb21tb24uYzo3ODU6MzM6IGVycm9yOiB2YXJpYWJsZSAnaG9zdHdp
bicgaXMgdW5pbml0aWFsaXplZCB3aGVuDQo+Pj4gdXNlZCBoZXJlIFstV2Vycm9yLC1XdW5pbml0
aWFsaXplZF0NCj4+PiAgICAgICAgICAgICBwZ21hc2sgPSAoMVVMTCA8PCBjdHo2NChob3N0d2lu
LT5pb3ZhX3Bnc2l6ZXMpKSAtIDE7DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgXn5+fn5+fg0KPj4+ICAgICAuLi9ody92ZmlvL2NvbW1vbi5jOjc4MzozNTogbm90ZTog
aW5pdGlhbGl6ZSB0aGUgdmFyaWFibGUgJ2hvc3R3aW4nIHRvDQo+c2lsZW5jZQ0KPj4+IHRoaXMg
d2FybmluZw0KPj4+ICAgICAgICAgICAgIFZGSU9Ib3N0RE1BV2luZG93ICpob3N0d2luOw0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgID0gTlVMTA0KPj4+ICAgICAyIGVycm9ycyBnZW5l
cmF0ZWQuDQo+Pj4gICAgIEZBSUxFRDogdGVzdHMvdW5pdC90ZXN0LXJlc3YtbWVtLnAvdGVzdC1y
ZXN2LW1lbS5jLm8NCj4+PiAgICAgY2xhbmcgLW02NCAtbWN4MTYgLUl0ZXN0cy91bml0L3Rlc3Qt
cmVzdi1tZW0ucCAtSXRlc3RzL3VuaXQgLUkuLi90ZXN0cy91bml0IC1JLg0KPi0NCj4+PiBJcWFw
aSAtSXRyYWNlIC1JdWkgLUl1aS9zaGFkZXIgLUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNy
L2xpYjY0L2dsaWItMi4wL2luY2x1ZGUNCj4tDQo+Pj4gSS91c3IvaW5jbHVkZS9zeXNwcm9mLTQg
LWZjb2xvci1kaWFnbm9zdGljcyAtV2FsbCAtV2ludmFsaWQtcGNoIC1XZXJyb3IgLQ0KPj4+IHN0
ZD1nbnUxMSAtTzIgLWcgLWZzdGFjay1wcm90ZWN0b3Itc3Ryb25nIC1XdW5kZWYgLVd3cml0ZS1z
dHJpbmdzIC0NCj5XbWlzc2luZy0NCj4+PiBwcm90b3R5cGVzIC1Xc3RyaWN0LXByb3RvdHlwZXMg
LVdyZWR1bmRhbnQtZGVjbHMgLVdvbGQtc3R5bGUtZGVmaW5pdGlvbiAtDQo+Pj4gV3R5cGUtbGlt
aXRzIC1XZm9ybWF0LXNlY3VyaXR5IC1XZm9ybWF0LXkyayAtV2luaXQtc2VsZiAtV2lnbm9yZWQt
DQo+cXVhbGlmaWVycyAtDQo+Pj4gV2VtcHR5LWJvZHkgLVduZXN0ZWQtZXh0ZXJucyAtV2VuZGlm
LWxhYmVscyAtV2V4cGFuc2lvbi10by1kZWZpbmVkIC0NCj4+PiBXbWlzc2luZy1mb3JtYXQtYXR0
cmlidXRlIC1Xbm8taW5pdGlhbGl6ZXItb3ZlcnJpZGVzIC1Xbm8tbWlzc2luZy1pbmNsdWRlLQ0K
PmRpcnMgLQ0KPj4+IFduby1zaGlmdC1uZWdhdGl2ZS12YWx1ZSAtV25vLXN0cmluZy1wbHVzLWlu
dCAtV25vLXR5cGVkZWYtcmVkZWZpbml0aW9uIC0NCj5Xbm8tDQo+Pj4gdGF1dG9sb2dpY2FsLXR5
cGUtbGltaXQtY29tcGFyZSAtV25vLXBzYWJpIC1Xbm8tZ251LXZhcmlhYmxlLXNpemVkLXR5cGUt
DQo+bm90LQ0KPj4+IGF0LWVuZCAtV3RocmVhZC1zYWZldHkgLWlzeXN0ZW0gL3dvcmsvYXJtYnJ1
L3FlbXUvbGludXgtaGVhZGVycyAtaXN5c3RlbQ0KPj4+IGxpbnV4LWhlYWRlcnMgLWlxdW90ZSAu
IC1pcXVvdGUgL3dvcmsvYXJtYnJ1L3FlbXUgLWlxdW90ZQ0KPj4+IC93b3JrL2FybWJydS9xZW11
L2luY2x1ZGUgLWlxdW90ZQ0KPi93b3JrL2FybWJydS9xZW11L2hvc3QvaW5jbHVkZS94ODZfNjQg
LQ0KPj4+IGlxdW90ZSAvd29yay9hcm1icnUvcWVtdS9ob3N0L2luY2x1ZGUvZ2VuZXJpYyAtaXF1
b3RlDQo+Pj4gL3dvcmsvYXJtYnJ1L3FlbXUvdGNnL2kzODYgLXB0aHJlYWQgLURfR05VX1NPVVJD
RSAtDQo+Pj4gRF9GSUxFX09GRlNFVF9CSVRTPTY0IC1EX0xBUkdFRklMRV9TT1VSQ0UgLWZuby1z
dHJpY3QtYWxpYXNpbmcgLWZuby0NCj4+PiBjb21tb24gLWZ3cmFwdiAtZnNhbml0aXplLWNvdmVy
YWdlLWFsbG93bGlzdD1pbnN0cnVtZW50YXRpb24tZmlsdGVyIC0NCj4+PiBmc2FuaXRpemU9ZnV6
emVyLW5vLWxpbmsgLWZQSUUgLU1EIC1NUSB0ZXN0cy91bml0L3Rlc3QtcmVzdi1tZW0ucC90ZXN0
LXJlc3YtDQo+Pj4gbWVtLmMubyAtTUYgdGVzdHMvdW5pdC90ZXN0LXJlc3YtbWVtLnAvdGVzdC1y
ZXN2LW1lbS5jLm8uZCAtbw0KPnRlc3RzL3VuaXQvdGVzdC0NCj4+PiByZXN2LW1lbS5wL3Rlc3Qt
cmVzdi1tZW0uYy5vIC1jIC4uL3Rlc3RzL3VuaXQvdGVzdC1yZXN2LW1lbS5jDQo+Pj4gICAgIC4u
L3Rlc3RzL3VuaXQvdGVzdC1yZXN2LW1lbS5jOjQyOjk6IGVycm9yOiB2YXJpYWJsZSAnaScgc2V0
IGJ1dCBub3QgdXNlZCBbLQ0KPj4+IFdlcnJvciwtV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0K
Pj4+ICAgICAgICAgaW50IGkgPSAwOw0KPj4+ICAgICAgICAgICAgIF4NCj4+PiAgICAgMSBlcnJv
ciBnZW5lcmF0ZWQuDQo+Pj4NCj4+PiBEZWxldGUgQGksIHBsZWFzZS4NCj4+DQo+PiBUaGFua3Mg
Zm9yIHlvdXIgcmVwb3J0LCBJJ2xsIGZpeCBpdCBhbmQgYnVpbGQgd2l0aCBib3RoIGNvbXBpbGVy
cyBuZXh0IHRpbWUuDQo+DQo+YSBjb21waWxlIG9uIGEgZmVkb3JhIHJhd2hpZGUgYWxzbyByZXBv
cnRzIDoNCj4NCj4uLi9ody92ZmlvL2lvbW11ZmQuYzogSW4gZnVuY3Rpb24g4oCYdmZpb19nZXRf
aW5mb19pb3ZhX3Jhbmdl4oCZOg0KPi4uL2h3L3ZmaW8vaW9tbXVmZC5jOjM3MDoyNzogZXJyb3I6
IGNhc3QgZnJvbSBwb2ludGVyIHRvIGludGVnZXIgb2YgZGlmZmVyZW50IHNpemUNCj5bLVdlcnJv
cj1wb2ludGVyLXRvLWludC1jYXN0XQ0KPiAgIDM3MCB8ICAgICBpbmZvLT5hbGxvd2VkX2lvdmFz
ID0gKHVpbnQ2NF90KShpbmZvICsgMSk7DQo+ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICBeDQo+Li4vaHcvdmZpby9pb21tdWZkLmM6Mzc3OjE5OiBlcnJvcjogY2FzdCB0byBwb2lu
dGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZQ0KPlstV2Vycm9yPWludC10by1wb2lu
dGVyLWNhc3RdDQo+ICAgMzc3IHwgICAgIGlvdmFfcmFuZ2VzID0gKHN0cnVjdCBpb21tdV9pb3Zh
X3JhbmdlICopaW5mby0+YWxsb3dlZF9pb3ZhczsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAg
ICBeDQo+Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCg0KSSBmYWls
ZWQgdG8gdW5kZXJzdGFuZCB0aGlzIHdhcm5pbmcsIGlzIHlvdXIgZW52IGEgMzJiaXQgZmVkb3Jh
Pw0KDQo+DQo+DQo+PiBBYm91dCBzZWNvbmQgZXJyb3IsIEknbGwgc2VuZCBhIHNlcGFyYXRlIHBh
dGNoIGFzIGl0J3MgdW5yZWxhdGVkIHRvIHRoaXMgc2VyaWVzLg0KPg0KPg0KPlNpbmNlIHRoaXMg
aXMgYSBiaWcgc2VyaWVzLCBJIHN1Z2dlc3QgdGhhdCB5b3UgdGFrZSB0aGlzIHBhdGNoIGluIHlv
dXIgYnVpbGQNCj5lbnZpcm9ubWVudCwNCg0KR290IGl0LCB3aWxsIGRvLCB0aGFua3MgZm9yIHlv
dXIgc3VnZ2VzdGlvbnMuDQoNCkJScy4NClpoZW56aG9uZw0KDQo+DQo+DQo+ZGlmZiAtLWdpdCBh
L21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQNCj5pbmRleA0KPjcyYTU3Mjg4YTAyNjMyNWQ1ZmY3
NTMxMzFjMDM3ZTk5ZjZmMzVjMWEuLmM5NDZjYmVmNWIyOWUyMzQ3NWRjNGNmMzQ1Ng0KPjU1ZTA0
NjZjYmZhZGUgMTAwNjQ0DQo+LS0tIGEvbWVzb24uYnVpbGQNCj4rKysgYi9tZXNvbi5idWlsZA0K
PkBAIC00NjIsNiArNDYyLDkgQEAgd2Fybl9mbGFncyA9IFsNCj4gICAgJy1Xbm8tdGF1dG9sb2dp
Y2FsLXR5cGUtbGltaXQtY29tcGFyZScsDQo+ICAgICctV25vLXBzYWJpJywNCj4gICAgJy1Xbm8t
Z251LXZhcmlhYmxlLXNpemVkLXR5cGUtbm90LWF0LWVuZCcsDQo+KyAgJy1Xc2hhZG93PWxvY2Fs
JywNCj4rICAnLVduby1lcnJvcj1zaGFkb3c9bG9jYWwnLA0KPisgICctV25vLWVycm9yPXNoYWRv
dz1jb21wYXRpYmxlLWxvY2FsJywNCj4gIF0NCj4NCj4gIGlmIHRhcmdldG9zICE9ICdkYXJ3aW4n
DQo+DQo+DQo+VGhhbmtzLA0KPg0KPkMuDQoNCg==

