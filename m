Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6757AAAE1
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 09:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjb01-000291-HT; Fri, 22 Sep 2023 03:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjazy-00028o-QU
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:54:50 -0400
Received: from esa5.fujitsucc.c3s2.iphmx.com ([68.232.159.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjazw-000150-GE
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 03:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695369288; x=1726905288;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=Hg6uBAPCt2NcQUg18576xU+NJ4OEiBIX7XYYXPbxu4s=;
 b=I7FW8qqUf4t6k0ma8eSvWcdZKjw/KAy55+L2AAO5UGRK9ZC1VDqXXgtI
 DNLBtR1NH8MOiXkOAFqEfJyLflRcNwnsPP8hO5rBAGik+DIjjJYkU7/HH
 E8xAXP9H/Zpv4fhDASPKBz4QbNl+xhg0exl/vCt7AHcDL6FpW/4j/g+iv
 VwXQ482rr3jZWB6AJYfaLdr+jCkLoYAGM3sqgck9DLmM0s9gmRROh5QcJ
 mum/dF4w9dGbLGHK3gGcB4KNaukZA/X+zxSwK1Qh7E8fuAveHMl0BYSA3
 ZPyJ/DM94Dtt+8e9Z7CbY6sbXuFAGyT5GmJAbgN9SdiFS9JGghi7eEtg+ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="96524780"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="96524780"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 16:54:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSZERzsIKWUmEzpeCtL5tqEHwO3MrUWjQR8E2Mh0BXush1C7kxkoIITm747B84M4dlZEc/aJ4UvrV0NlzfO9phn9eRPxIwOVnzGedQ9Xqk82npILHy5SYQFHSEp9w0Vm4xx1dr80YGXQwil1qDQduycS5tNhZ3lvQf3SVQgeFQKs7eDP7bVXw5x9TRk8qtqXS3QZ5BSRjpbqxQXmvArBK2ne79oWPl9Owa/mxcWd2GOOi9kg8f6m3KvUJLNWhB3JHwoYDb9fAnLhRiUr/29UbyXHmKlVtuwSqJymJEX2WzhYnEMHVXEUSvc326xuTCvD+rS1hBUJ3XT7Gz2AQvNxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hg6uBAPCt2NcQUg18576xU+NJ4OEiBIX7XYYXPbxu4s=;
 b=SP3ChTq1agqbLWhzZjo6f9+WxPVBeIPgpYw3vR++MAFzbKfEem6iWsolNZb0NDOM4jgP5xVLgjac9ObcS+ynxvuFB5ktPP1VaBXxfwWzYtHLAkHSpNCdX6H6SwXzszHNNBUBnmMD1xTCzoqc0XRM2p46VcWEIH8q/FzoqK19lsYLmykFq50BZDgMZY/5bWsBh61W7xVxKU43iaTL0yo2T9z0/D/ByA7zSYKXQQhbi5jpptpkKMXt7ew5t74TtA+iHmPwvFVOo9/WlSwfeYINejIvDd9FK84+nysbYtBJMngbQ7SLskgqUNlgmE+bI/jWQwiTEkHXzrZ2pjP8L0Z3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB7988.jpnprd01.prod.outlook.com (2603:1096:604:1bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 07:54:37 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 07:54:37 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 14/52] migration/rdma: Use bool for two RDMAContext flags
Thread-Topic: [PATCH 14/52] migration/rdma: Use bool for two RDMAContext flags
Thread-Index: AQHZ6j6LxreklYxaokW7d/ySKTweeLAmf5GA
Date: Fri, 22 Sep 2023 07:54:37 +0000
Message-ID: <a02ec590-6236-c023-89aa-b31508c8bed0@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-15-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-15-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB7988:EE_
x-ms-office365-filtering-correlation-id: 1d4c3867-f200-4ee0-3b31-08dbbb412b21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74HzAd5vzkgh8JYlvc7Pq7qO+nos5KWoEocKDT1gWKEljr0lZw+dHFbpp1A67tr31V80nzptb0AOv1fUQIouOkt8kFBqerhVkJ2yuRuyE0g8C9Y5eUWXmXeQxbduMaPuU0ua4Rlb9xnTpBUBo5Zozl98corqjIAyBZdFMHp5OU2ZoutiufhX9FTR2SSdRsg1ukZJtqRz+mEjMsARuNydlM3nrXxHjI7MB8LBZj/KpV26giE7eL6J496ygOYvAp2z2dpxGzO2Vvikz9cb1u9g40EA1Cas2eYFDqjdfbIug9ylcX98NCb1g2geUkabmXVKCfPBuKXHdnjhDOaa9wv+S320fICpsbtXoaDDz+ukv7OPs/RjSjsk7j/T6Wzw50tMRDmuD7lbOkEDBGGMfLbqDVy7p3s40jA563EjNJL/6oRwlwExWly+pp+E0Q4CM7eqC3ECaYCNMUWSS1dbeh4NVumsyS3pmSFE80GZ4tOLRT6YO4MHe1GH26OMQR6GXAVm3AoqWt9JFT30TOxmYcxlroEacS6b+N180pZy3kT08dIbakxe9mYR3Kc9SulHrGtSUIPzyPE2vYx3cPNXYMwK208PEWE6MTV4GsvamZ3S1nctDQoj2DzOaT2PbjEWrzQtocDI0qVe/0bb7pYt5y64klarR3iHoF6+4JSZfOt+Mj79BynyGnNGUZIb5dKO04xPwsrV54cQQMnWsKFg1eZNqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(186009)(1800799009)(1590799021)(31686004)(38070700005)(6486002)(53546011)(6506007)(1580799018)(31696002)(36756003)(82960400001)(122000001)(85182001)(2616005)(38100700002)(86362001)(54906003)(2906002)(8676002)(71200400001)(6512007)(83380400001)(478600001)(5660300002)(66946007)(8936002)(91956017)(4326008)(66556008)(41300700001)(26005)(110136005)(66476007)(66446008)(76116006)(64756008)(316002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUIrQ05JV3p2OUsweC9SbUhQbm81TW85TFpibUtzb1pQYU5uRlBuYlR6a1k0?=
 =?utf-8?B?YTV6NnliQ2JhbXdhRHpaaEVBY043OFgveXR6RHRzWDVaWlY3a01rR29SOXVP?=
 =?utf-8?B?K2VicE9tTndmZUc3WENwdTRiYUlJNXljYmN4OXBoZVE0bnE5dU1ISjBMdEh5?=
 =?utf-8?B?KytyR1dvL3FGUmxvbEQ2UFplUnBPdnhLRUlZcG9hcXNsTTkwbGNnVUE2ZjhT?=
 =?utf-8?B?Z2JwWGlxdzhTcURqcVZRcXRMeWRGa0xEL0xsVEsrM0hiU0V6ZS9KZmg4MDNt?=
 =?utf-8?B?QWc4dXZEZHBBYWlXVCtIbVNDd2tMSVY4WTNsc2dPcndYL1JndHVnZlBSSWxk?=
 =?utf-8?B?SlBwRWdiQ0hQS3YwbmVONUFhaFhiR09HaVBmL3ZFTFh4aDBCd1lKYlVBMDE1?=
 =?utf-8?B?UjdZL0hYTXVycnI0NHZBM0lzNklTRVVKT2FwNGxYMWFTTGg0LzdSc1k2Rkt5?=
 =?utf-8?B?NkhCWnBpUDVteEF4N2tQQ3BUaFI3aE1sSERpWEhXQlNVcW9yNktlRWZPTlNP?=
 =?utf-8?B?NHdMK0VudXRlYnR1YXNXOXR2ckVxS3R6djJla1ZHc01kZ1JFUHU4eWYyYlNJ?=
 =?utf-8?B?NW1aRVRsaEhmWEU0em01MllpRmttUDdiN2VUNXQ0YlFpNUsxaG84N3N2a2Zs?=
 =?utf-8?B?K3NpeWt0VWJiNzdheEhaVUtRbnFSZFVacFMrL01rU21pT2tWSmhWTC9hSEg1?=
 =?utf-8?B?UnRJVkoyTDFyQkw1NUdiWUl2TnpQZ1h0VUtENExKTE02aHQvNVZyT29xNTBi?=
 =?utf-8?B?VkdjY0plSUsxbzhLd2dydnQ5d1NKUll2QU5BQ1RUVzJ6bFl0Vnh1bENRTElI?=
 =?utf-8?B?ZW8xTUxTY2JYcU5JbExFUm1zVzFOM2c3QllrMDBmQzV1YkwxSVhTcjF1ajZa?=
 =?utf-8?B?WjVPeFNtMUFiNjBSVTB2d0hURm5ZY290RmFPUTA1dGJaSzUvNi93NXFlSUNQ?=
 =?utf-8?B?cFpJMGFRcW9qTERDRFlrbFQ2WnRBeUNpOTZWcW95VjNERWZFTzYxREZUN3du?=
 =?utf-8?B?L0RiU0RQTXE4OG5UaHVrYlpoYUFSRnozZVN0YTRYYnVDemVFY05sak1xVGJW?=
 =?utf-8?B?dFZIZnIzaFA3Zmh5Y1IzMmMzc1FzSEtrZjhvOWRrQUppMmdJMVNjZEZycWFv?=
 =?utf-8?B?cTU3N1dkUXpaS3Jua2RPbjhBZGhaL3IwOTlOK2RzUnlmQ04xbCs4TWJTY09Q?=
 =?utf-8?B?VUwyN1dXSWppL0hhajVrK2JwblVwOGUwaGFVQjdEa0NGa1RWdTlhTGF3cisx?=
 =?utf-8?B?NnR1enllS0dYYzlSRFBTRGdZZDdzVXM4dDI1RGRNMW9UOTB6dGUwbEdSaUlP?=
 =?utf-8?B?TjdSMEtJL2JtS2wzRHlCTU5yZktuUWZiOTJDWGU4SnBtNmRQUlNoQ0Q1WUZS?=
 =?utf-8?B?Y1QraDdIRUZwTkpqVHlqUWpmU3RPTHVPL3VTSGkwNXZKblNqVENNZ2t2VG1J?=
 =?utf-8?B?d1pjTXliWFAwWDVaSEFaSlRzUDVUQkpqWnlHOEIxZi9CbytEdzdMVXhSUDJ0?=
 =?utf-8?B?Q1VZdGRUVW1TVWVHbXlwRGxtcVFjeEhaTHArMmI4S25STmVObzFpeDNmVklR?=
 =?utf-8?B?eGtOWFdMVUh3d1h5eWNGYlB6MGloN3pRZWJSR0IvNU1ZakNOM1hyZ1JEdGJL?=
 =?utf-8?B?QjdoQjJwK05XTC9FUkdyTXF0S1hmbjRwVGlyOTZKRng5WE00ZFIvZEp5Z2Ux?=
 =?utf-8?B?c2FxY0hPK1liMksvNXlNaituS05TUUd1VEZNVDFWdEw4cHhkSU5qNFA0Z2pW?=
 =?utf-8?B?OWpDV05oL0JXSUhsMzlpR1pUanE1MitWaVd1dGl0eGxZcFlCQmIyMUx3d2FL?=
 =?utf-8?B?bG5TOXQvZjlRWU1VZnhzYXd3MWVteFpubDBiNmMrdFltMmhkSVVjWVJQM3o4?=
 =?utf-8?B?Q0pWWC83bDNMdmVGVkNISHptZ1ZUOXhiMnpqZkMvckNaQlVsQjRtSTVFRlVG?=
 =?utf-8?B?T3d2a2JxRHZwdGJtNDMwVXc5VXp0SG90TExoekNNelRaOEUzNzdPNnkvbmRn?=
 =?utf-8?B?OGFxbVJKM2luYm9tVk5hVCtMdlFid2ZZaCthYVJuNDgxN1hldWFyTnh1RFFu?=
 =?utf-8?B?cTR5RTRiUkF4Q09iVmcwY0dsQlpiWTA1RWJDek5XandiYkRQeGJwMCsrTElR?=
 =?utf-8?B?clQ4cEliL1gxS3RSQjEzVWMwNldLQjkvTnlmdDd0bmFYQjZFUDRJaGtWZHhV?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A548679EAE081644BD695C2485225A10@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /qpHDjSQ2YgXHtbOVNLirY0uLnk5hGS63EasIEO00Sm6eT6Q/hiyiHsIqRi3b+GKW18KRoaVoQDjtHnQhglJSG/rj+sym5z3lH2u4n9WSefdwW+nm85WdUtmk3lEQrsxP5DlPp+zhgFW/tOD1Gl3cBpZB0H61pLmydrngjTZp53tkBX48VaglFR0I1duXeKPkPGyxdz1ltYHy3t4u1fH9vnUqSLIeIiQoIe/KijdCg9gdTiX2h5qHcovw5fbTHRGqODkfVlF16rNWpLExIJNKlC51h8KFyG88Mx9o9P0BhlRml8MQw6iEN1wLXFtzXeHJhrE6+4uV+yxgD+0JN3S1hFhbW1BXQBqrQNlI6S9YIq2etXzBNU34d2nihQE7kROqRCikakzszVB8lrR6mcpHpyI6sPZrCnW4FS2s1YkfMA7TfoPq8XmTkN5oG+vgbl3HxScYA8c6j4w9iOJoOpPyqYY3CL95HYxxUQ9NUcKPYZg8jccNLJOydb3uAULfciY5CdX0saQ8kzpVLgNYaGWVrGXhT7/NqE9c3U3NHektWYCfl0mUgpzUmUp08X+nNG34e0bSsdLAPTz+8RpESN08qY+yALGzahmlCP8tisfLfiHf1vdahTrQr53m8TesTX+3pl/PKXCJ8FLZeOXMaNjc5j9JdABrldjD7OLxioUsWt3U6Up5P9cuV5DAtBi9+fiRvSX8upJ+AuImflcd2D3Nase36Q9Fr1WAVCL8c98ur08IQMizJOn8itnzVbSECnjQ/0TkeSwxUQF4fVkG0lKmSQy9kyJeUAfX0ycKebzE+A=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4c3867-f200-4ee0-3b31-08dbbb412b21
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 07:54:37.3436 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yG9ibZ1zNRH0bovWIc8JF8BO5dL+puAFhN6qBTXfzthexuSMTM/AiNkrxAz5+lXLE7yLv+RoTNW+qTACGz16gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7988
Received-SPF: pass client-ip=68.232.159.76; envelope-from=lizhijian@fujitsu.com;
 helo=esa5.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBAZXJy
b3JfcmVwb3J0ZWQgYW5kIEByZWNlaXZlZF9lcnJvciBhcmUgZmxhZ3MuICBUaGUgbGF0dGVyIGlz
IGV2ZW4NCj4gYXNzaWduZWQgYm9vbCB0cnVlLiAgQ2hhbmdlIHRoZW0gZnJvbSBpbnQgdG8gYm9v
bC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0
LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4N
Cg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5jIHwgNiArKystLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IDk3NzE1ZGJkNzgu
LmMwMmExYzgzYjIgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWln
cmF0aW9uL3JkbWEuYw0KPiBAQCAtOTEsNyArOTEsNyBAQCBzdGF0aWMgdWludDMyX3Qga25vd25f
Y2FwYWJpbGl0aWVzID0gUkRNQV9DQVBBQklMSVRZX1BJTl9BTEw7DQo+ICAgICAgICAgICAgICAg
aWYgKCFyZG1hLT5lcnJvcl9yZXBvcnRlZCkgeyBcDQo+ICAgICAgICAgICAgICAgICAgIGVycm9y
X3JlcG9ydCgiUkRNQSBpcyBpbiBhbiBlcnJvciBzdGF0ZSB3YWl0aW5nIG1pZ3JhdGlvbiIgXA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiB0byBhYm9ydCEiKTsgXA0KPiAt
ICAgICAgICAgICAgICAgIHJkbWEtPmVycm9yX3JlcG9ydGVkID0gMTsgXA0KPiArICAgICAgICAg
ICAgICAgIHJkbWEtPmVycm9yX3JlcG9ydGVkID0gdHJ1ZTsgXA0KPiAgICAgICAgICAgICAgIH0g
XA0KPiAgICAgICAgICAgICAgIHJldHVybiByZG1hLT5lcnJvcl9zdGF0ZTsgXA0KPiAgICAgICAg
ICAgfSBcDQo+IEBAIC0zNjUsOCArMzY1LDggQEAgdHlwZWRlZiBzdHJ1Y3QgUkRNQUNvbnRleHQg
ew0KPiAgICAgICAgKiBhbmQgcmVtZW1iZXIgdGhlIGVycm9yIHN0YXRlLg0KPiAgICAgICAgKi8N
Cj4gICAgICAgaW50IGVycm9yX3N0YXRlOw0KPiAtICAgIGludCBlcnJvcl9yZXBvcnRlZDsNCj4g
LSAgICBpbnQgcmVjZWl2ZWRfZXJyb3I7DQo+ICsgICAgYm9vbCBlcnJvcl9yZXBvcnRlZDsNCj4g
KyAgICBib29sIHJlY2VpdmVkX2Vycm9yOw0KPiAgIA0KPiAgICAgICAvKg0KPiAgICAgICAgKiBE
ZXNjcmlwdGlvbiBvZiByYW0gYmxvY2tzIHVzZWQgdGhyb3VnaG91dCB0aGUgY29kZS4=

