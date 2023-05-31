Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF65717371
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 04:00:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4B7F-0002X6-CC; Tue, 30 May 2023 21:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q4B7E-0002Wy-64
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:59:08 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1q4B7C-0002OV-0l
 for qemu-devel@nongnu.org; Tue, 30 May 2023 21:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1685498346; x=1717034346;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TN9vYJoMVm661di4Q+TsbjkeVF98IxPQEQK0SPuD0qQ=;
 b=kcL8DYWD54+6WhSBCKrVA8e2/bR2EEAU9pPYJ/r/uDGA5Y2KpOJinXwU
 Wyv/LyxrXFHUnlSld9ndrZG3UB/Xy19M38wcIF6Pek9W4y0+Tqdw3ZWdy
 sWMERqszTaLimOa/qNWBK/GqrQ+tIuXqdE8sVODx56yrHgb9i5pJduOpj
 w3jV6Vc5bK5igZa67tkUEGgxFhQlsF50+uoN+SjkRamEmGY5xYPeQ/8sP
 FKz8eg23OVlkrUkVqtGnOa29NPpCZkdVHfNXOsYLcS2wt1AL4ZRZbjpxo
 8K+8C5KL1xw2p9ASo7YSIuP1pm0e8TeTefgRblrvdInFBbGzVmrFdJgHu w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="85895464"
X-IronPort-AV: E=Sophos;i="5.98,286,1673881200"; d="scan'208";a="85895464"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 May 2023 10:59:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGfnOC432kJ5krdsbYELy3TiT8cUMqZ9HrMwl68obp88uQzkRT8o8cKvyX4T8KfynMG0DA+CoXdkPtmN9bKjrVFE2iB7HxdKFO5C/fOCTII2RwGBK+PVx+pXBe81TY9zhyffV9M/FMwmTVeLtvm4fwSsg/AT7DEUROfsSeDIZMGNlOuu5Jzb8u7FFyMBB7V6nR5HTeCKsx8/6OR4xsjC3RuSR46oWp7+9KQLscrlOm7FPad/MkgVGt01LxvzaPb1yZIeY+T5Z3mQV+Qy0rOhSTZ0+ej2AaijuMaVlMCrHKpqYHNh7uP1Kz/UPBhN71M/L4kBY1AdoQjbUxxPG2QTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN9vYJoMVm661di4Q+TsbjkeVF98IxPQEQK0SPuD0qQ=;
 b=Zyt9hfqiaTmNddnU+QX0vDWo5PzXcKrtIna7FtJ3vMG2Tkc0LcEjbiGv+/kOidYJ0crv5QoDO0NAFXkcXMRujfCs6xkwvg83dpyE53ZYzib3En1pXomtzkbBaI1fdnhrrdZdUj6Vg81uAygMXQCwD7bsLsQNqgibszTZNxz6MQ/SmSz/YFOr6MXjQrbAQLGJVTYfzNSsDiQVoyynTxJOAAHPpYXjkOcYJQ43wjwBzXF3GabdWqprYCF5O+ZUHwdQdP73moTr8rsqNdS87ZpntmRCpfp5eX+vv2TNH27uIG9uz8/LUVvKGA9yLIW4BqIDtN9PLJilMz2bTlOgcXdIwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS0PR01MB5796.jpnprd01.prod.outlook.com (2603:1096:604:b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 01:58:57 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::687d:4884:ec0b:8835%7]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 01:58:57 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/clx: Fix CFMW config memory leak
Thread-Topic: [PATCH] hw/clx: Fix CFMW config memory leak
Thread-Index: AQHZkgNef34/0QiYL0ScLoqNQ/0Wca9y7soAgAC0GIA=
Date: Wed, 31 May 2023 01:58:56 +0000
Message-ID: <155db820-7e98-20b5-2498-a091bf39a683@fujitsu.com>
References: <20230529075956.2235870-1-lizhijian@cn.fujitsu.com>
 <20230530161420.00000784@Huawei.com>
In-Reply-To: <20230530161420.00000784@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS0PR01MB5796:EE_
x-ms-office365-filtering-correlation-id: e7ad2352-27b1-4ddf-5923-08db617a982f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NeCHdQmMoEOnhdWqwPo1YL0Quic/UopPRAyMkWUbawekmPHqYF157YB/oiBhmoVg/3w/a5HxVsrPfOGF/sO1RTcnyJyQv4JgWXzZNWQsdSL/cJVbCGfmcEl4+XI3sKNF9iQcC3LNV7m4SMUOFGR0fzksitzj42bauDWnJxq+Ie74O5KYyhvSUnJdnvt3UlTcH09q3hnWEHwFmJ0piGY7dmfYIrTot0VubiW9rKiRt+cGzexvc0Ur/cd5ltLyruQG0VTvhrryed8vr+g1orVuIFmK7zzozzHcyAtncZ/MHBkRPUi2KaMpcVubnnNx7TPtfIqXmx/jo0wwL9OlqDGozDnZTsCXXN7uPS5Wiy3/PIvNN9/bO5KWSepp7Skj9L27ZrxLA2t0ve54xvj5bq2HNRo17ndCtCeIrJ9IyvRCCcBjhMxv2MbRey/83sONvnH4LbdjXDvAearNQtzWnuy+nrCCR4vjXHz9+wiYUrS/BD2Anr3adIqbQQz4u6objrIbhe0YeE0FkHbwiS08VIdgTq4I65jmobvdNOy7cSSG0VnEER4nxb2ITdwZ7Yh/rrZK2RtqF+QV4o36FYue7c5xU8NhybZzfYL3HD9kemcGkOFwg68MX0SqDcAbTEsbLfxDdvqKNMtTSK8XbsFt8caqzaN7UB4A5zBchzymUYSa0pnLBQ/J54M3bpCuze/Uerle9/ddlrZaxwpturjPfJy84g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(451199021)(1590799018)(66946007)(91956017)(478600001)(4326008)(83380400001)(66556008)(76116006)(38100700002)(31686004)(66476007)(41300700001)(64756008)(66446008)(38070700005)(71200400001)(2616005)(110136005)(122000001)(82960400001)(54906003)(316002)(8936002)(8676002)(5660300002)(1580799015)(26005)(6512007)(53546011)(6506007)(86362001)(2906002)(186003)(31696002)(85182001)(36756003)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0MrUmk3SSs1d0llSVlrVmhxN0FsVkg2NUpuSUVSbCtGM2VwVml2QXRRbzh4?=
 =?utf-8?B?aGx4WlBmZERMME5QeHk1bWhGaXI5NmptckI3b211NFVHaHFSeENnL0kyK0dy?=
 =?utf-8?B?cU1KMGx5aGFBelAyL1JiWE5PeTJEMDNxbkRGSmZZWjcyYVZ1cTNGQVFxZnNQ?=
 =?utf-8?B?QkxlL09Tc1E1N213bzNrMVo1b0N5M0h3ZVNEczY3MWpNdFU0cmVqeGJBTnhD?=
 =?utf-8?B?UVRWWUJQWndESmo3S1Y2YVlLODNhQVlBb2ZGcDlOL0ErV2VuZWZkd1NDWDdK?=
 =?utf-8?B?dUFHMUtpanFDOFpvejB2c0VPTFFlTzBGdHAzTy9lWEZzTVQvdHJ5bThqc2h4?=
 =?utf-8?B?cWRqNE5PSUdMSFhDd2IweEpXRXZUYi9rQVlxb1NpZjFYOG5DY2FwaXhoUkxZ?=
 =?utf-8?B?M250cE9VZ3FNenl5YlpEQ1JKWXEzRVZuR0hYcEt6WmJGc2JDK3BkcnlnQ1pR?=
 =?utf-8?B?Q3k0OEptRmpIaWdLVlVWdkh6TlNjUENWS2tiQTBRMG5RcnN1bVMxR1FRY2Nw?=
 =?utf-8?B?RUhJRklRejludlc3TFBnYTFxRndsRVVCd0ZWWmsrVVoxVXVtV0t0bUUyb1Za?=
 =?utf-8?B?dE1KbkpMdDkvdXpuY2hFemlUR3V3ZmN4K0xnWFExSEp2Q1lmRGFLaE5wc1N5?=
 =?utf-8?B?Rm44RHpiOXY5N2NpekkrSlNYNDB6Y3hzV2JJNUVFREE1aW9Za0sxRzdOYjRh?=
 =?utf-8?B?OWQ2M01hRTFRYXQwYzZSVG5YMXFnRERjelFJcGR2TWl4bEhscyt3VkRFbCtn?=
 =?utf-8?B?WTVKNFFOMG82aXVnSXZ3SkhOOHZlN2Z3SGg5RVF4YmlsUUtCc21iZ2hCQmsw?=
 =?utf-8?B?SVZSTUdmcno5NHFjNkpRcFJpNFhCMll6S2Rtd1B2RHBnaVdNdVFIZjRXNDBD?=
 =?utf-8?B?TUhqNFJ0b2hCZ2N0YVk0a3BiUWxOeTYySUNWZTZQdC9Wc2dMcVM4L1I4RThH?=
 =?utf-8?B?R2xGdGhSSXdRNVYxN3AxZGhGS2prNWpveWtNRkJ0Z3pCNzhRNnkvbGNGYUFH?=
 =?utf-8?B?QS9DWVdvYktCbnR3aEJoMWRFdEhRVnc1bnl6eTdiWWpVSVJlMnNNbHFKakhl?=
 =?utf-8?B?Z05oaXkwZWRvNnBDMkdzazlUSGtGeFBLQzdzOXJrV1B4d2JHcFc0UGU5Sld5?=
 =?utf-8?B?QWVqQ3RLT0RKbExSSmtMR3loSXNaNzd6VmNEZ2dRKzBHT25HZHdjVGxoenBp?=
 =?utf-8?B?ZjNMWTFtV0VKN04vUm00VzZyM2hKT3hZOWp0YkRTaXdLOGY3TWdWbWJObjF0?=
 =?utf-8?B?UkRRSDlFTzJLRXk0anp5OVNuWUN4czJJRzF6SUZoaktLRUVTTWE5RTNRUGl0?=
 =?utf-8?B?a3B0RkZWQXl6MDdqTHpET3ZKNzdKQlVTdGlNcjJ0THZNNFRDMTFoY0MwZGJp?=
 =?utf-8?B?SGxlR1FNL0Q5cjlIYUlLcFV5bTVyamhmVXJERmNsVUJpdmI2RUhxRmp1RW9p?=
 =?utf-8?B?NUVTVXEwL21pL1hzMjdZTjJ1OWUxaTRaZUlIcW5rSGpEdDNKYmFsbXc3aG1n?=
 =?utf-8?B?aGxhVUFRTzRBb0ZNaGlMS3J1cWVwQ1VxRWFnRzgxT1F6MjZiYjYyRmV1MWxu?=
 =?utf-8?B?ZWhEQ0pYaFRoVWE2YjExSGZZMzZ0bXNLT2NGaGZpMDJyNyt0NVAxaUY3ZHp5?=
 =?utf-8?B?aE9vTG9mYk5CZVhRMFdhUzFXT0tYeGFKc1Z1aXYzSXYyQWFXclBMcUdYZWJM?=
 =?utf-8?B?dTZKQWs3RHpqUGttWWc1allrS1hzYndIb3pTbTdJR0tydG1HcjkycDJ4b0M2?=
 =?utf-8?B?c3N1aU1abmVpTVBiWndSeE9aMCsrQlNOYm9FUmU4UUcrVjkrdkx5cXRKeGNX?=
 =?utf-8?B?cll5dUdxMGRIYlZUVk1OcWNFMzhmNEdzeTRYWHhVWkxrbkdpSjJXaHNPQ0s2?=
 =?utf-8?B?WHJ3VFJ4NXBaSVIwbmVtYUJHUXg0UytFbWtzeHpzd3MxeGJQZVRuSXc5Z1Z4?=
 =?utf-8?B?L0k5bjZSQzIxeVVsZzlOcW9QMUtxY3ZvbmhtaEVrRzNuL3NUcGpDTXB2ZXBr?=
 =?utf-8?B?T2xYRTBwK04vOVh5OFltYW5uV2M1M2JvWTlDYXIzSzR0SHVPcVd3VytYdEwv?=
 =?utf-8?B?ZmQ3K1VhRTB5Rjdka1BGSXBaT2RpNUFGeHR5TWFkL3p1YWdOUTFNVG9lTnd5?=
 =?utf-8?B?QUJoRVcxSDFxTDFIRm0xQnY1RzdBUjlvLy9wTXZJMHZUbW9HRmdvdUNURW9U?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F44C51A62968A94CB5FF76877C19D0DF@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zStquxyp7NjS0aX6jPOjLlRgCqmz2SfdhM7UTH8SbNhL0fddsIIaEGxAtTqT1+NJAqJmgqVZRIQ4i00gvNjNEnLsRaU8CYWC6eTzqd73VEdNldXOsS+hw3GddDvl2Oc2oz4jpaew1g0SjLdQtDPhH7mR/TKgqFHcDZUjgO+rH+tQJzbKm9yMbYNtFtWYRAnxMVf5UJIQ3zhTsj4Fy5edQI/PUeWnTRoNadIXmckLtxJpEVn4ono+u/XNtdGLebNVsoNUbaZZvolsoWAA/dbDTxQEvFRFGiKLbwMLcXj2Y2gOdrDiUKmOsZVQsrTxwDU3rDsAlZggtfbou1rGfqI0q2snkp7D0TPIm6X/allJ/Cqb38ksNEC/ory3wELiAZMRIY8XbamIzZud+iGeGwlxd5ou/VhhcPxOBQVvFNzk/fwVokj9DcfGH1rWki5fsrA3TwQCqzXOVJ4MXUy+oDx5er2/M0l8Nu2BnFSTN0CrwNnPhEv9Bnanckw4NxRdLh6+0zBOwjBvDnVD1DH+EtpmQFdbpOrotb+dXhgpHqXUzNb2ps6Dhl8Lvsolxxi/ewG2SEjr1IGXOOpMBll9iJ7GdtLD/o9fTVVdFGYHDNdH3EpUZBcJ3wQ98Nl33P6SCENUbJDjij3gZw9axP1hlNRDmWUuq7QAnEaTMtexOkphL62NQIONYTXRnrocpQshSTspAwINcpTGYz3RFIk02Fp+QY5ROC85NWGSKon/eGKTI8lzUC+zf3TAjPveRJt7Mt4wSsFkkQayk07mSvv7d2s8r0Rzc7UbO0NiyirLVfa1edMfPc8HC4KjOHtKEXtME78X
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ad2352-27b1-4ddf-5923-08db617a982f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2023 01:58:56.9701 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IMaQs380YninatfC1OrNekiDTLVFbtIvz++A65p7h1I6s7S0jD/F/EqKa4gpqjPryE7CAzbQxn2bSUGIrIMg3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5796
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

DQoNCk9uIDMwLzA1LzIwMjMgMjM6MTQsIEpvbmF0aGFuIENhbWVyb24gdmlhIHdyb3RlOg0KPiBP
biBNb24sIDI5IE1heSAyMDIzIDE1OjU5OjU2ICswODAwDQo+IExpIFpoaWppYW4gPGxpemhpamlh
bkBjbi5mdWppdHN1LmNvbT4gd3JvdGU6DQo+IA0KPj4gT25seSAnZncnIHBvaW50ZXIgaXMgbWFy
a2VkIGFzIGdfYXV0b2ZyZWUsIHNvIHdlIHNob3VkIGZyZWUgb3RoZXINCj4+IHJlc291cmNlIG1h
bnVhbGx5IGluIGVycm9yIHBhdGguDQo+Pg0KPiBHb29kIHNwb3QuDQo+IA0KPiBQYXRjaCB0aXRs
ZSB0eXBvDQo+IGh3L2N4bDo+IA0KDQpPTUcsIGl0IHdhcyB0aGUgMm5kIHRpbWUgaSBoYXZlIHRo
aXMgdHlwby4gaSBoYXRlIG15IHN0dXBpZCBmaW5nZXIuDQoNCg0KDQo+IEl0J3MgYSBiaXQgYW5u
b3lpbmcgd2UgY2FuJ3QgaGFuZGxlIHRoaXMgd2l0aCBtb3JlIGF1dG9mcmVlIG1hZ2ljLg0KPiBU
aGF0IHdvdWxkIHdvcmsgZm9yIGZ3LT50YXJnZXRzIGJ1dCBub3QgZm9yIHRoZSBzdHJpbmcgZHVw
bGljYXRlcy4NCj4gDQo+IE9uZSBvdGhlciBjb21tZW50IGlubGluZSwNCj4gDQo+IFRoYW5rcywN
Cj4gDQo+IEpvbmF0aGFuDQo+IA0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBjbi5mdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBody9jeGwvY3hsLWhvc3QuYyB8
IDEwICsrKysrKysrLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvY3hsL2N4bC1ob3N0LmMgYi9ody9j
eGwvY3hsLWhvc3QuYw0KPj4gaW5kZXggMDM0Yzc4MDViM2UuLmRkMWE3YzgzZjcxIDEwMDY0NA0K
Pj4gLS0tIGEvaHcvY3hsL2N4bC1ob3N0LmMNCj4+ICsrKyBiL2h3L2N4bC9jeGwtaG9zdC5jDQo+
PiBAQCAtNDgsNyArNDgsNyBAQCBzdGF0aWMgdm9pZCBjeGxfZml4ZWRfbWVtb3J5X3dpbmRvd19j
b25maWcoQ1hMU3RhdGUgKmN4bF9zdGF0ZSwNCj4+ICAgICAgIGlmIChvYmplY3QtPnNpemUgJSAo
MjU2ICogTWlCKSkgew0KPj4gICAgICAgICAgIGVycm9yX3NldGcoZXJycCwNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICJTaXplIG9mIGEgQ1hMIGZpeGVkIG1lbW9yeSB3aW5kb3cgbXVzdCBiZSBh
IG11bHRpcGxlIG9mIDI1Nk1pQiIpOw0KPj4gLSAgICAgICAgcmV0dXJuOw0KPj4gKyAgICAgICAg
Z290byBlcnJfZnJlZTsNCj4gDQo+IA0KPj4gICAgICAgfQ0KPj4gICAgICAgZnctPnNpemUgPSBv
YmplY3QtPnNpemU7DQo+PiAgIA0KPj4gQEAgLTU3LDcgKzU3LDcgQEAgc3RhdGljIHZvaWQgY3hs
X2ZpeGVkX21lbW9yeV93aW5kb3dfY29uZmlnKENYTFN0YXRlICpjeGxfc3RhdGUsDQo+PiAgICAg
ICAgICAgICAgIGN4bF9pbnRlcmxlYXZlX2dyYW51bGFyaXR5X2VuYyhvYmplY3QtPmludGVybGVh
dmVfZ3JhbnVsYXJpdHksDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlcnJwKTsNCj4+ICAgICAgICAgICBpZiAoKmVycnApIHsNCj4+IC0gICAgICAgICAg
ICByZXR1cm47DQo+PiArICAgICAgICAgICAgZ290byBlcnJfZnJlZTsNCj4+ICAgICAgICAgICB9
DQo+PiAgICAgICB9IGVsc2Ugew0KPj4gICAgICAgICAgIC8qIERlZmF1bHQgdG8gMjU2IGJ5dGUg
aW50ZXJsZWF2ZSAqLw0KPj4gQEAgLTY4LDYgKzY4LDEyIEBAIHN0YXRpYyB2b2lkIGN4bF9maXhl
ZF9tZW1vcnlfd2luZG93X2NvbmZpZyhDWExTdGF0ZSAqY3hsX3N0YXRlLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnX3N0ZWFsX3BvaW50ZXIoJmZ3
KSk7DQo+PiAgIA0KPj4gICAgICAgcmV0dXJuOw0KPj4gKw0KPj4gK2Vycl9mcmVlOg0KPj4gKyAg
ICBmb3IgKGkgPSAwOyBpIDwgZnctPm51bV90YXJnZXRzICYmIGZ3LT50YXJnZXRzW2ldOyBpKysp
IHsNCj4gDQo+IE5vIG5lZWQgdG8gY2hlY2sgZnctPnRhcmdldHNbaV0NCg0KDQpJIGtuZXcgaXQn
cyBzYWZlIHRvIGZyZWUgYSBOVUxMIHBvaW50ZXIuIFRoZSBpbml0aWFsIGlkZWEgd2FzIGp1c3Qg
dG8gbWFrZSB0aGUNCmxvb3AgZW5kIGFzIHNvb24gYXMgcG9zc2libGUgOikNCg0KT2YgY291cnNl
LCBJIHdvdWxkIGFsc28gYmUgaGFwcHkgdG8gZGVsZXRlIHRoaXMuDQoNCg0KVGhhbmtzDQpaaGlq
aWFuDQoNCj4gDQo+PiArICAgICAgICBnX2ZyZWUoZnctPnRhcmdldHNbaV0pOw0KPj4gKyAgICB9
DQo+PiArICAgIGdfZnJlZShmdy0+dGFyZ2V0cyk7DQo+PiAgIH0NCj4+ICAgDQo+PiAgIHZvaWQg
Y3hsX2Ztd3NfbGlua190YXJnZXRzKENYTFN0YXRlICpjeGxfc3RhdGUsIEVycm9yICoqZXJycCkN
Cj4gDQo+IA==

