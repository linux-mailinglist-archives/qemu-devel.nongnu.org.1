Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B587AAD0D
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 10:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjbnA-0001E6-JZ; Fri, 22 Sep 2023 04:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjbn7-0001Dl-EZ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:45:37 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjbn0-0002Bj-Q5
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 04:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695372331; x=1726908331;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GP8djEk82wECip2nioXv6+mM13WIKDwD8hFl8p9vCzA=;
 b=DFVFTGIByGdPHby07Vo97g+3ihBP8o+b+UK8F5UAZDiKSyAHt6cN1AeG
 VmkeMaIj3VYqpOYXPu+gbTtuAFMzLiVbiAM/mgiEfmXbS5vrUMuLvRefI
 /YNO4kSvSmDerh5USLk/KUP3kLF0cTVc4hc+ruv9yAxbW1KUrrno/aQju
 ecUd+fz+AUK6UB/kGXnGMZHAYaK3u1dJX5A+N1MwgIQgLe2O+mvlO+KRF
 lCciv6TO26kxybU9ht3kfucYFgvMvabxf0KpGhgSqgvNCQUJjZ0VsnqE5
 e6B+175BRG6O9yJDhfYGXyjOsgkauMuk6DVh4IDh2hJyv2lA+GF9axBY4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="96387760"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="96387760"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 17:44:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dViNdBXYZxPFp36oisLk1Yp/PzllDT5C1KS9or5++uTKe0vVa2djTaUNDtk1EjYD1E3NHQp0N2a2KZ56NNlwWyo54uvr9BtZjM1yLhBwq0cSnWooMmUoYHK6YkWFIZkkNIg3xkUk8dprhGyYGcvszPFfUfPwD1oFcevwznemM1A7z+71GnrXEC1TgYqMQeEe+5KsCzhy7SgwpvJrfxqmLYSiqZEf5N1zREAcsFTVs/8YivUNjCbZJOjGb8KglSeEJs030AayUZdSJOzn2ilZS0ycZjXUeFk9Tv0lDfRSChVfcouz9d71H9NWcfN0FslACnSG5M5pp+cKgEC5WpfQyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GP8djEk82wECip2nioXv6+mM13WIKDwD8hFl8p9vCzA=;
 b=YDSLi1Vsnyk5Nh1EjXLfkxLkuKURGalwX4NTniCNAO6IoVysUl0JA9gE5Mozb0UtVJkskARt7QF4R7imT5VxaXYq551//t6FsJWEuiF/NJZ577mL5zcXICsp2z7Q5my73+H+E2lvN2Pa49nH0zNc4ZAfknrX1lSAC6mEnp+xlzKZperxOcBY3VB96GrTv18QbW+Rb1OnKDBdaa/401+kZdZ8dD3FWE7iNlB7I3CFB4mXsQNyGCMWuoMgQ2btnNaDFvZ9OsL53p+Nr1Bw06+d0d7IWQk4EIV7H6/Vwop1Ic0Ra9P7ZN0Oj57/eMgZW2qK7kLpCw19ISulKQfa8jWdZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8750.jpnprd01.prod.outlook.com (2603:1096:604:15f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 08:44:09 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 08:44:09 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 15/52] migration/rdma: Ditch useless numeric error codes
 in error messages
Thread-Topic: [PATCH 15/52] migration/rdma: Ditch useless numeric error codes
 in error messages
Thread-Index: AQHZ6j+ac8AOF8D2qUq53wg2I+ZunLAmjWaA
Date: Fri, 22 Sep 2023 08:44:09 +0000
Message-ID: <f797e410-1be1-75fd-d091-0da8974cc986@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-16-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-16-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8750:EE_
x-ms-office365-filtering-correlation-id: cc46ede7-0bd1-4397-e104-08dbbb481688
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ETRsC8hm37/ro5x3QneYlGYVM0FBEP9CIKjdGJuz5nfbhtOoxBlRcC4B8gg5hRy0tDCFdNld/zgsnzrQrDAiroqN9zPAstTB6spIrR47mVWgd6TR0UyNkoFgx6TsWfT/Wvy/gVDqQ6SsEO3egusAD83hlz66hTh8WUWNcyk6//g8RbNqeffZ0kkeLtYgYhd1T4qce+uxO52FpSB1c22ZIE8hIYRKTQjMVNli7daS+i3FXHBv6DsmM8J0yvdbnIFNh6bapICmxmR9YpeJhs3ZiA6uspL0d+DCqEpaVeefpv8y6jojvh4hs1/cXxyflnk/I4yvXeHjR2ZZcwwdpYJSx2b5UUgMfmv/7RAPJ4XTLiBz80i01BGdD7WrxaIBexQThdsnNqAqRAgfT3wNaD+MJnfl87lkfbF/8ouILin9OBpbnb7Swaq3x7qIMk8K4f6uBsPKBvztLCKfkYxQud2Pylha26pezH+7KiaZdUq1VOjAb3rSWwTDQfMGq/qeeFTX2u3cOaVp6xyiCa24x0fCjWoE1W8oeUTaLiMW/759eOZFtuTnphwIA4jTxS/1XQqqixfe5tg8ZaRe6NRq05T+6MuiP8hXT37S/O6ha0jCTwVa6xUwJEkxfJRTkQyigZ0JmyFhyLhEfHWhonabRyZDhFcp/j6AiRvHSmYUiKKJm7MRTELYTLO64HR3bROXJubQABEFK07SM1TCU0Z/gZMTqA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(1800799009)(451199024)(1590799021)(186009)(2906002)(15650500001)(82960400001)(122000001)(38070700005)(38100700002)(53546011)(86362001)(31696002)(6506007)(6486002)(71200400001)(41300700001)(66946007)(91956017)(110136005)(64756008)(76116006)(66446008)(54906003)(36756003)(85182001)(478600001)(6512007)(66556008)(66476007)(2616005)(1580799018)(5660300002)(26005)(83380400001)(31686004)(8936002)(4326008)(316002)(8676002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVdQejVwN25GYjBpWDhCcFZ4dytESVJGQkkrODZaSm03VFAwOGYxZ25pRjdr?=
 =?utf-8?B?TzNEaW9vZnl5aGFoSTlRZ1R1cllwelMwdndqMUp5WnpiNGRWb3lHVHYrR0ZV?=
 =?utf-8?B?N3l4VTFyYnpKZ2ZyeTh2d0hDZWZxUTdXSDhreHh3TXp4MXZzcU5TL1dxLzAr?=
 =?utf-8?B?dzFhK2ZHOW1DVVFvUzNSWW5PcUdTSHV4MFdtYkczUzVGeTV0b0Y4VnNaUUEv?=
 =?utf-8?B?alJIeVFLUXZOeXl2S1ZjZEZaU1RteS9YYXVFdjgxdGE1R2FnZ3czdFlkcTFo?=
 =?utf-8?B?Q3RwZ3VBclcxa0tSOTBBRU5vZE9yVVVTMTdXVUdNdVl2SEdwc0Fmd0xsRUNG?=
 =?utf-8?B?aXRYa01CRFh2cDhQQ0NWTU16a1FqdWw1R0k4OWhlTFFSYWI5M3BjSEMrVWZZ?=
 =?utf-8?B?R1kyNFBOSU1KWllwOEY2bi9pektMRURpaEwvZWZZOXpVQnN5aTc3RnJkSG1Y?=
 =?utf-8?B?alNPWUhWaGR1c3ZjQmY0VlBOOGNkNTM3Wi80cWdLSWRBS25aSjRtYWRyNEww?=
 =?utf-8?B?OERtTEJUSjFPNHN6QWUzSFlQcEo1MzQxVE9pZG9Qc0daNWVua05acTFmNnYw?=
 =?utf-8?B?NUFMVi9MSkpETUVMcXpKYUNTZWxRTDJCLyswY0VDM2xyY3J5VWlUc2NPQnVW?=
 =?utf-8?B?MGhuakU3cFJHbHJsMitKNkRUaEV3Y3JWN1dJbS9yOEJ0aFdpOHd5c1grMVFk?=
 =?utf-8?B?dThaSHJ3WVZOUzlvamVTd2p1cU5YTnB3NmdYdDhvSUdNb055Sm5pc3czYXBS?=
 =?utf-8?B?eWxPOTI0djdMZHhQZ1FDcEZRZlU4Rld4SlZRVkNyWVUwNHg4YVFOdFRqZTlq?=
 =?utf-8?B?Y3dyUHpSUWdPQnN3elFxVVVTNnhYTXNwMGMxaS9XTEhWVHN1d0s3cUg2K1Fs?=
 =?utf-8?B?S0NKOHpYRHhqbDF1bXdlbktBc2ZxdVg2UUxrYURsUjdhZUhyRDhQZlBGZjRL?=
 =?utf-8?B?eW1qcVF4VzNlekhrUjlaRVh4Rk9kK0ZrK0F0cEppYlM5VnZqbmc4aFZ6RHRz?=
 =?utf-8?B?ekJhaXlDazR5SnZNbW1tcTVheEl4VFByRnhpNExLemZJNnAxUEordzYyKzVU?=
 =?utf-8?B?VnRIU25ZK0pZaUg5Z0EyaUIwSGt2dGRyeWMrMFR0L1hsdXFSQ0tHVGUyREdv?=
 =?utf-8?B?L09UU3huUTZjNW53aVRJZ25mb3g5THl0RG1ZYW95M0tQTVVpZ0FHYUlOaW1Q?=
 =?utf-8?B?NTJHWlBVZGpMQXZQTGxrWDQ1Sy9CM2pRK0dkMElzeGFadlZ2VDRqb3NwMnVi?=
 =?utf-8?B?K2F1TlEyTVM1V291UUNFRzVzYlZKM0pENWRMSC8xaG1XODhJT3JiWFVFYVdI?=
 =?utf-8?B?cE41UmRwNEFQZGZISUVPZnBxQ1BKSklvM09nOWJ5RituZmNxMXk0Tzc1K3o5?=
 =?utf-8?B?cW0zMmhiMUZHTzZXUzZiS2ljeG9la0hXZG5MUDRXQW4vY3ZGcittbzBSQ1JS?=
 =?utf-8?B?bTdrV0pxa05LMTVYOFVxTm5NbnhSZnhBQUhGUlFQU2pzMDdOcFV2cGh3cE8w?=
 =?utf-8?B?ck5EdFRJUGpwR1FhUEtvZG5rbFpkWDRoQUpoSWJaOThGNmpmYVlPNFpZVHA2?=
 =?utf-8?B?NGpxNDQyLzkvek1ETlZSQWFjZWdzMG9KcXZVNUk3ZXZVSFlEc0JySmxyelBD?=
 =?utf-8?B?akVJSG9QeG5lbmphSEM5bXJHaU1LZkw1elUwbmo5d0xKV0Z5UXBaNnZveWxF?=
 =?utf-8?B?VXA3WklyNUpLcTNyWEFUN054c1RNNVlxZng1cWRydlgwNFBMWStIUUVuMlhG?=
 =?utf-8?B?WVVDWk9rdU9FMHhTNWlXcndMVHY2bk5aQTJ4UzAzdE0rOFNQNDk1V1l2dFRE?=
 =?utf-8?B?UkxGWGMzL3VnekwyWTQ5UkhudzE4MHh1eFFhaVZON1QzNEZMT3BuSHQ0TUds?=
 =?utf-8?B?RFd5MnU0WHdxTFNXQlozb2hGYUtMczN2cDY5TytPNVJnUXYyWmhZYnYwTVZp?=
 =?utf-8?B?SkZXTTQ4bUhRTkl1eHZ4dENtYnZ2NHpuWDhuTzI3RjlhOEtNZHhxR0NhVlN4?=
 =?utf-8?B?ZUc1Y00yYXhJeGFTTjFOMjNUSURRSjFwQkRFeGRUbWJmbnhhajZjY1pMMHNT?=
 =?utf-8?B?U0ltTmdUY2huY0RDMFdrMUl6VTlXQ090blAxZHJOSmo5YTk5REpXTUFDUysz?=
 =?utf-8?B?bnliYWt3QmVaNkpubGcwamYxNWpoenh2Q2kzekNTMEVXN25pQjNJQlMzdmFJ?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <446529DAF3B2AD46A655A925C120F291@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PH2vl/GbswLPd+OdF2aKr7qpmbaaBx5seS9MGCqPauiSzVwPZf5WSSIm6Q3kh3Vkd37h/sVFwcvXG44MBeQ87PaWywjpyYFd05fJtn75C12tjKdLTqB/bGty5BmDCuU0g9dqZlsTDFGMr03lt1CoQht5OUd99faa5SSaG472TMUmmDjs09LXPg3XU+INtqKZ+0tjy+1bESkeGrXujd+piUAzU7pSTV7iUOKS9NfdZ9EcKaSTix6hqeiNdVHzusaMPF7STMILvvLFLeYsCoyGncVZwccpvw1x4+6jEYCQMlUmftZYqdCdqFyYppSXoYasbKCE4pJQx0ivQQERwXIp99Fs3L0W31bnH8UEOk75Jel1VT4xrVCM8/EMkYdNvD2DUO/2mmck2kWmyJdwuSejE30AG4zoyGt7WsRT0W+a0A4JhRoKqqd+tA0QZEm3GAFvzqcaCZsmr5wfszphYrafXsGmzHaEg1Aae/rf8hla9Od70Q9dRgg1bz0cvZ0i7KFVm/2ATmRugrD5oEPCRjg/OVtE+PJRYTZ4NCqU/5HOtIZbYX/0d54H1HpcEOz1SDdciFXWHtR25+4ksS3emR5PvhAHXYxA9hkHnlxXluP6rLzcTCoFztgd1/Te9dTDZIT3R1LT1HFTY/fo+QCJ1CuF6QHc9W+Xf/FVCXhLDjreYTh/b98PvNgCp0kizl8KV3Di5oGDcD/cOGds4CC5GKqMTVb03nlko34/g/H0btlKBwOecA2bmp3NaSJFvcJWjzIb0b2vsSbZU37NarXdpS5RGt7xwbMW1ilccUD5pIcogiw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc46ede7-0bd1-4397-e104-08dbbb481688
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 08:44:09.2937 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NLbSzsZl3ToXpfL16c+9suuscI69F9/8gvWrull11IV1scKREUoc+wvVegqSaGAopGNeflHSXxoV9RUvG4b7gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8750
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBTZXZl
cmFsIGVycm9yIG1lc3NhZ2VzIGluY2x1ZGUgbnVtZXJpYyBlcnJvciBjb2RlcyByZXR1cm5lZCBi
eSBmYWlsZWQNCj4gZnVuY3Rpb25zOg0KPiANCj4gKiBpYnZfcG9sbF9jcSgpIHJldHVybnMgYW4g
dW5zcGVjaWZpZWQgbmVnYXRpdmUgdmFsdWUuICBVc2VsZXNzLg0KPiANCj4gKiByZG1hX2FjY2Vw
dCBhbmQgcm1kYV9nZXRfY21fZXZlbnQoKSByZXR1cm4gLTEuICBVc2VsZXNzLg0KDQoNCnMvcm1k
YV9nZXRfY21fZXZlbnQvcmRtYV9nZXRfY21fZXZlbnQNCg0KT3RoZXJ3aXNlLA0KUmV2aWV3ZWQt
Ynk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IA0KPiAqIHFlbXVf
cmRtYV9wb2xsKCkgcmV0dXJucyBlaXRoZXIgLTEgb3IgYW4gdW5zcGVjaWZpZWQgbmVnYXRpdmUN
Cj4gICAgdmFsdWUuICBVc2VsZXNzLg0KPiANCj4gKiBxZW11X3JkbWFfYmxvY2tfZm9yX3dyaWQo
KSwgcWVtdV9yZG1hX3dyaXRlX2ZsdXNoKCksDQo+ICAgIHFlbXVfcmRtYV9leGNoYW5nZV9zZW5k
KCksIHFlbXVfcmRtYV9leGNoYW5nZV9yZWN2KCksDQo+ICAgIHFlbXVfcmRtYV93cml0ZSgpIHJl
dHVybiBhIG5lZ2F0aXZlIHZhbHVlIHRoYXQgbWF5IG9yIG1heSBub3QgYmUgYW4NCj4gICAgZXJy
bm8gdmFsdWUuICBXaGlsZSByZXBvcnRpbmcgaHVtYW4tcmVhZGFibGUgZXJybm8NCj4gICAgaW5m
b3JtYXRpb24gKHdoaWNoIGEgbnVtYmVyIGlzIG5vdCkgY2FuIGJlIHVzZWZ1bCwgcmVwb3J0aW5n
IGFuDQo+ICAgIGVycm9yIGNvZGUgdGhhdCBtYXkgb3IgbWF5IG5vdCBiZSBhbiBlcnJubyB2YWx1
ZSBpcyB1c2VsZXNzLg0KPiANCj4gRHJvcCB0aGVzZSBlcnJvciBjb2RlcyBmcm9tIHRoZSBlcnJv
ciBtZXNzYWdlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1i
cnVAcmVkaGF0LmNvbT4NCj4gLS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDIwICsrKysrKysr
KystLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRp
b24vcmRtYS5jDQo+IGluZGV4IGMwMmExYzgzYjIuLjIxNzNjYjA3NmYgMTAwNjQ0DQo+IC0tLSBh
L21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMTQ2MCw3
ICsxNDYwLDcgQEAgc3RhdGljIGludCBxZW11X3JkbWFfcG9sbChSRE1BQ29udGV4dCAqcmRtYSwg
c3RydWN0IGlidl9jcSAqY3EsDQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgaWYgKHJldCA8IDAp
IHsNCj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJpYnZfcG9sbF9jcSByZXR1cm4gJWQiLCByZXQp
Ow0KPiArICAgICAgICBlcnJvcl9yZXBvcnQoImlidl9wb2xsX2NxIGZhaWxlZCIpOw0KPiAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gICAgICAgfQ0KPiAgIA0KPiBAQCAtMjE5NCw3ICsyMTk0LDcg
QEAgcmV0cnk6DQo+ICAgICAgICAgICByZXQgPSBxZW11X3JkbWFfYmxvY2tfZm9yX3dyaWQocmRt
YSwgUkRNQV9XUklEX1JETUFfV1JJVEUsIE5VTEwpOw0KPiAgICAgICAgICAgaWYgKHJldCA8IDAp
IHsNCj4gICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoInJkbWEgbWlncmF0aW9uOiBmYWlsZWQg
dG8gbWFrZSAiDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgInJvb20gaW4gZnVsbCBzZW5k
IHF1ZXVlISAlZCIsIHJldCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgInJvb20gaW4g
ZnVsbCBzZW5kIHF1ZXVlISIpOw0KPiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICAgICAg
ICAgICB9DQo+ICAgDQo+IEBAIC0yNzcwLDcgKzI3NzAsNyBAQCBzdGF0aWMgc3NpemVfdCBxaW9f
Y2hhbm5lbF9yZG1hX3dyaXRldihRSU9DaGFubmVsICppb2MsDQo+ICAgICAgIHJldCA9IHFlbXVf
cmRtYV93cml0ZV9mbHVzaChmLCByZG1hKTsNCj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gICAg
ICAgICAgIHJkbWEtPmVycm9yX3N0YXRlID0gcmV0Ow0KPiAtICAgICAgICBlcnJvcl9zZXRnKGVy
cnAsICJxZW11X3JkbWFfd3JpdGVfZmx1c2ggcmV0dXJuZWQgJWQiLCByZXQpOw0KPiArICAgICAg
ICBlcnJvcl9zZXRnKGVycnAsICJxZW11X3JkbWFfd3JpdGVfZmx1c2ggZmFpbGVkIik7DQo+ICAg
ICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAgIH0NCj4gICANCj4gQEAgLTI3OTAsNyArMjc5MCw3
IEBAIHN0YXRpYyBzc2l6ZV90IHFpb19jaGFubmVsX3JkbWFfd3JpdGV2KFFJT0NoYW5uZWwgKmlv
YywNCj4gICANCj4gICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiAgICAgICAgICAgICAg
ICAgICByZG1hLT5lcnJvcl9zdGF0ZSA9IHJldDsNCj4gLSAgICAgICAgICAgICAgICBlcnJvcl9z
ZXRnKGVycnAsICJxZW11X3JkbWFfZXhjaGFuZ2Vfc2VuZCByZXR1cm5lZCAlZCIsIHJldCk7DQo+
ICsgICAgICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAicWVtdV9yZG1hX2V4Y2hhbmdlX3Nl
bmQgZmFpbGVkIik7DQo+ICAgICAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgICAg
ICAgICB9DQo+ICAgDQo+IEBAIC0yODgwLDcgKzI4ODAsNyBAQCBzdGF0aWMgc3NpemVfdCBxaW9f
Y2hhbm5lbF9yZG1hX3JlYWR2KFFJT0NoYW5uZWwgKmlvYywNCj4gICANCj4gICAgICAgICAgIGlm
IChyZXQgPCAwKSB7DQo+ICAgICAgICAgICAgICAgcmRtYS0+ZXJyb3Jfc3RhdGUgPSByZXQ7DQo+
IC0gICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdiBy
ZXR1cm5lZCAlZCIsIHJldCk7DQo+ICsgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJxZW11
X3JkbWFfZXhjaGFuZ2VfcmVjdiBmYWlsZWQiKTsNCj4gICAgICAgICAgICAgICByZXR1cm4gLTE7
DQo+ICAgICAgICAgICB9DQo+ICAgDQo+IEBAIC0zMjIyLDcgKzMyMjIsNyBAQCBzdGF0aWMgc2l6
ZV90IHFlbXVfcmRtYV9zYXZlX3BhZ2UoUUVNVUZpbGUgKmYsDQo+ICAgICAgICAqLw0KPiAgICAg
ICByZXQgPSBxZW11X3JkbWFfd3JpdGUoZiwgcmRtYSwgYmxvY2tfb2Zmc2V0LCBvZmZzZXQsIHNp
emUpOw0KPiAgICAgICBpZiAocmV0IDwgMCkgew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnQoInJk
bWEgbWlncmF0aW9uOiB3cml0ZSBlcnJvciEgJWQiLCByZXQpOw0KPiArICAgICAgICBlcnJvcl9y
ZXBvcnQoInJkbWEgbWlncmF0aW9uOiB3cml0ZSBlcnJvciIpOw0KPiAgICAgICAgICAgZ290byBl
cnI7DQo+ICAgICAgIH0NCj4gICANCj4gQEAgLTMyNDksNyArMzI0OSw3IEBAIHN0YXRpYyBzaXpl
X3QgcWVtdV9yZG1hX3NhdmVfcGFnZShRRU1VRmlsZSAqZiwNCj4gICAgICAgICAgIHVpbnQ2NF90
IHdyX2lkLCB3cl9pZF9pbjsNCj4gICAgICAgICAgIGludCByZXQgPSBxZW11X3JkbWFfcG9sbChy
ZG1hLCByZG1hLT5yZWN2X2NxLCAmd3JfaWRfaW4sIE5VTEwpOw0KPiAgICAgICAgICAgaWYgKHJl
dCA8IDApIHsNCj4gLSAgICAgICAgICAgIGVycm9yX3JlcG9ydCgicmRtYSBtaWdyYXRpb246IHBv
bGxpbmcgZXJyb3IhICVkIiwgcmV0KTsNCj4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgicmRt
YSBtaWdyYXRpb246IHBvbGxpbmcgZXJyb3IiKTsNCj4gICAgICAgICAgICAgICBnb3RvIGVycjsN
Cj4gICAgICAgICAgIH0NCj4gICANCj4gQEAgLTMyNjQsNyArMzI2NCw3IEBAIHN0YXRpYyBzaXpl
X3QgcWVtdV9yZG1hX3NhdmVfcGFnZShRRU1VRmlsZSAqZiwNCj4gICAgICAgICAgIHVpbnQ2NF90
IHdyX2lkLCB3cl9pZF9pbjsNCj4gICAgICAgICAgIGludCByZXQgPSBxZW11X3JkbWFfcG9sbChy
ZG1hLCByZG1hLT5zZW5kX2NxLCAmd3JfaWRfaW4sIE5VTEwpOw0KPiAgICAgICAgICAgaWYgKHJl
dCA8IDApIHsNCj4gLSAgICAgICAgICAgIGVycm9yX3JlcG9ydCgicmRtYSBtaWdyYXRpb246IHBv
bGxpbmcgZXJyb3IhICVkIiwgcmV0KTsNCj4gKyAgICAgICAgICAgIGVycm9yX3JlcG9ydCgicmRt
YSBtaWdyYXRpb246IHBvbGxpbmcgZXJyb3IiKTsNCj4gICAgICAgICAgICAgICBnb3RvIGVycjsN
Cj4gICAgICAgICAgIH0NCj4gICANCj4gQEAgLTM0MzksMTMgKzM0MzksMTMgQEAgc3RhdGljIGlu
dCBxZW11X3JkbWFfYWNjZXB0KFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgIA0KPiAgICAgICByZXQg
PSByZG1hX2FjY2VwdChyZG1hLT5jbV9pZCwgJmNvbm5fcGFyYW0pOw0KPiAgICAgICBpZiAocmV0
KSB7DQo+IC0gICAgICAgIGVycm9yX3JlcG9ydCgicmRtYV9hY2NlcHQgcmV0dXJucyAlZCIsIHJl
dCk7DQo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgicmRtYV9hY2NlcHQgZmFpbGVkIik7DQo+ICAg
ICAgICAgICBnb3RvIGVycl9yZG1hX2Rlc3Rfd2FpdDsNCj4gICAgICAgfQ0KPiAgIA0KPiAgICAg
ICByZXQgPSByZG1hX2dldF9jbV9ldmVudChyZG1hLT5jaGFubmVsLCAmY21fZXZlbnQpOw0KPiAg
ICAgICBpZiAocmV0KSB7DQo+IC0gICAgICAgIGVycm9yX3JlcG9ydCgicmRtYV9hY2NlcHQgZ2V0
X2NtX2V2ZW50IGZhaWxlZCAlZCIsIHJldCk7DQo+ICsgICAgICAgIGVycm9yX3JlcG9ydCgicmRt
YV9hY2NlcHQgZ2V0X2NtX2V2ZW50IGZhaWxlZCIpOw0KPiAgICAgICAgICAgZ290byBlcnJfcmRt
YV9kZXN0X3dhaXQ7DQo+ICAgICAgIH0NCj4gICA=

