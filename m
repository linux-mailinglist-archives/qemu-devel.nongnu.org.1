Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6752F7AE64E
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1yt-000159-33; Tue, 26 Sep 2023 02:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1yo-00014m-T2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:55:35 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1yj-0003KR-HZ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695711329; x=1727247329;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=V74ButGECBCJ+n/iT2bt6r5xxm7bSBu+Z7bkTK0Nq0M=;
 b=TzZOCrZmQqHzdeMYMWIJvHVU1bwuaDZPZJg4mD0850qNrPo0eH5jhG0c
 ZNmAUePwNLyGBoxSm7lj+90FCr8S5Z+1wq9qigW5tj/5fBEpCb4UL9lsA
 LNCY6r9V3O2PMl8R6P3AjUFBPp0vjD0mgpjS96QlLrSRD9w8t5eSyQkWe
 VpjJt/MmE+PUZIMyTufuigXkUo9/ipgIPcRnKEczJ8SS40XMpi12Xqk/E
 oW/GCiAcq7gsldjo2POEUOECl+jdA5kPcyKmyNvNVlGw0bmFpCPWQ8XON
 j4iLPbSLfAap9i1gz51dc+bJ/bmc9XwtUMKIgkeNhszU38XfVF1IQfQkk w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96591017"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96591017"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:55:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMaoT2JNQmmZ281gmf+wof4lWIxIRV7JXQi0RlXSUJUgpnshaxbX75+P9PdjL8I59oXdqRGoVYLm3OLTve2BzotHOM7eTBXTJMtdIJIYdTN+QqIOsacz6GEL5UPFfZCFswsCEFI2LUDBlBRgFrhrdFXQC4rBkvJHhs8WWaI5+r3j4dFoEWRRtSC2q7FoeVUaL22gUuNpqVmF8GTz92Kn0EOOWzJVg7T2jIXEJGgz5ln9gmgNEmhQEWtyZACtWjlvyeVqVGXCirIHaJkZkO2i9cuHMjdNTGZzZMRsi/EPCF5/mG0Cpz1rarGroKFdHXHBR68UghtmGB/gjEY2LwYmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V74ButGECBCJ+n/iT2bt6r5xxm7bSBu+Z7bkTK0Nq0M=;
 b=Lx7QdQjLJ0TS1hFg23GtWKiqRlw9QmApn2T3Hvzm/+G1xfJlVjrjvjpAT8F+nhdX1lA94IbGUD6fTDmY2q0Pvdtg4ijmRI9evaxg1hihNEXceeZ9mgaF39KGaA+MBOE2KxScyk6auRmpXVaAkxYS79aQbGarbg6Fdfp4OuRjkumF4dgmasHrtxtUDZUChGjse4o3L1yYHg/bQmy6ryBdQBfo3wxx7gf5OU/+k6RP0bcEsJXXQFEqUGyHofi1B0UlD/j0wDCxSdJC4ZybOKnmc3AnJcYXFlEvEiL/9+AOHhLHrKae4BqXzJwU5crXTF6ITQcQJG8rghl3UtwB5vlbtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB10340.jpnprd01.prod.outlook.com (2603:1096:604:1f9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:55:21 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:55:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 43/52] migration/rdma: Convert qemu_rdma_alloc_pd_cq() to
 Error
Thread-Topic: [PATCH 43/52] migration/rdma: Convert qemu_rdma_alloc_pd_cq() to
 Error
Thread-Index: AQHZ6j86GNDeZBZ8u0iYK79fAIBnd7AspE0AgAAQZE6AAAOjgA==
Date: Tue, 26 Sep 2023 06:55:20 +0000
Message-ID: <6167a847-56b9-60d8-650b-c6f0ef1c4922@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-44-armbru@redhat.com>
 <209dd727-9e55-42d0-aac7-98509a4789b0@fujitsu.com>
 <87h6nhjv13.fsf@pond.sub.org>
In-Reply-To: <87h6nhjv13.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB10340:EE_
x-ms-office365-filtering-correlation-id: 4bda552d-1f7b-43e7-af1f-08dbbe5d8d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yBhHBcf+/+4m9a5vwvQ1HmJU49t2bRK3Y2UcuWFmciIUO7LobfcEnTfLT3R1EbU/CsWj4fbnVvb4hi3Xr4fZB/4tafCTnsNaWxWcGiqv+nVg4sOpdBvgOov4/lX9Fh5ItUXUC/xOaskHt0GBDLiLeV8g9IqRDocno3bnQI2sqWQrRWA5WzLgCtgIrDhyDbx4BK7NDeLKZ5ZDjJDeUr30+nkOYkIBpLXVp1Zomsopw9S13SxKSa5s0IiB23dRtCpqBclxQ9onPLn1R4JlkGcTSg/3heLubjmU42V5sTz4iK7nJz+IWRvXgGMcFrvIBkr9UmWgTMNcxFcK5gXsx5KaU4bS+yydPGuLI1PtEiA284JB3MqE7Ayd+exmmmBP+SXXThg2fZPMs8JN6ZkhH6cH61S47hRnuXj236Zje2OB9CtxTJ6TmNHbEu40Svx42Qvsqupwzrh1LLJ+Cqe5kdnFL1r+wUXB2q3JyR/nTlujpH6aS8PqsFh/cD0fTFDWuQ8wwyHBsM8OFB6x6n/VY8NuR8R2Kmg/YBjkTtOPyE3JSOe4hVklEeo40NQ8/CA2JvSXWecfxIZ6WB94EiTT6s4Qzo44bx+XYQX42HU1JuEbvWyt+7bMzeo+plPlyPqnm3YtbMjHAxqQ/Rs9pWarS4067I9COkQnYADvhXfQKLGBnMdDOnIEfVyKUAWshg/MJuyZtLZN1H92lIEvqd1vcvRKig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(1590799021)(186009)(451199024)(2906002)(1580799018)(6506007)(53546011)(6512007)(6486002)(71200400001)(26005)(31696002)(86362001)(76116006)(66946007)(2616005)(82960400001)(91956017)(66556008)(478600001)(38070700005)(38100700002)(122000001)(83380400001)(54906003)(5660300002)(64756008)(8676002)(6916009)(8936002)(66476007)(36756003)(66446008)(85182001)(4326008)(41300700001)(316002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjRIbWIya21iNUZCbDBWM0M1OGpkK2tSMFhDeFMzT1IrdG9lZmFWMjZPREV4?=
 =?utf-8?B?K3dCdTROMVdVMU5NQnRaSXhER1RHWktraWpxM0x4WEMxcEtaL3M1NkkxRk40?=
 =?utf-8?B?U1dzNWt6eVYwU0xwK0pTa1VBT2RYRDhhRHMwNUI0MGRhelR6ckZMQndTdFZE?=
 =?utf-8?B?MUVQQ1dvUTFMTkt0b1JlT2JDd0hKcVVuVXErRWo2bU1NSzUranNTa3FhbmIr?=
 =?utf-8?B?TnMrR2xLczJvZ21xcTVpNDRYbUNsRHI2WlBYTmRXRE4yR2VpSWJSdmRCUWk0?=
 =?utf-8?B?VHkxQ3lSazArKy94T1FQSmtXZTljYTJoaEU4dmxNcCt3alpSSEVicWxKb3dH?=
 =?utf-8?B?WXVLZkN1c1RKSFVCb1dGR01iSTJSRUxYcFpLa0FZWjFVWnh6VlhjL1UwV2Ix?=
 =?utf-8?B?OTgzSVdlSXUyNFptT0xVcTRFZG0xN0xPMGVsOTRmMnZlM3BwNmp6bzhLMENs?=
 =?utf-8?B?QkV2SUR6Y2JyVS96Uzh2eVdyL2grVFl3V0VUN21QL0VJS3lIeEFtTURvUCtR?=
 =?utf-8?B?VTA3cWJ0MEU4d3p4M2xxZ24wK0NkU3N6b2RvcGlHNG9TcWpDa3p3eTcwaCsz?=
 =?utf-8?B?NTNEdU1hRmdZeVFwb3E0TnMyYjRWanY5cWRBZExFOU9BOXQvZXVDUGpOenFG?=
 =?utf-8?B?L2ZxR3Bzc3IxUHBCdFNkUk9OWUlHVkF4ZmZNUmwrSXFmeEVPZTFxWmc1dHBp?=
 =?utf-8?B?SFRYMkhPNU9BQUJKQUdCT2hTVGx0cmlRNTlaVFFUWGJxV2RpSVpJRGlVakkw?=
 =?utf-8?B?c3Q5NGRZVDd0S2JCQ0VlTWFQT21CT0pQUllQaGU5d2QrSlMrYlUybVpGTVUr?=
 =?utf-8?B?dHdGMkhNVEVGZTNUR0t3Q20wUHN4OHZBa0NMNytoeGxObHBQMGMyUU5qSysz?=
 =?utf-8?B?ODVKVFB4cElYTnZMSmZVbnQ0QnhuUGdmT2Q4RVF5cFo0cEYraE5HcjBST2RZ?=
 =?utf-8?B?azE5SFlLY1IrdkN3cGx4aFpmQTNVcEJnMUozQmlyeTNSb2VSamt6eSs1NmZL?=
 =?utf-8?B?MVdsRllYRTRZQ2lmYW5VV052UTVHbGtEbXRVQUY3ZUlvdDljU1dDYmViN2VU?=
 =?utf-8?B?aWE5bkJJcHBCeXZza0RIQy92QnU4RWZZN3RDSGJDWkxOeVVNc3kvTGdSRUor?=
 =?utf-8?B?MGpPQXhEdzFZM1p3TENWcVZyQ09FTStmZnpibmhNT0o5bnlUWG5YUlN6Q2xW?=
 =?utf-8?B?QWVwMEpEZ2oxVTViaVgwZnEwcFNBQmdCZHZaUVBOZ3BLOGMyLytNazRWcWF3?=
 =?utf-8?B?eTZUYmthRUgzVmhxN0IwWFU5Z1RoWFNNYXhscGp6NDQvUml6MTRRZWhEUXBC?=
 =?utf-8?B?U1phR2h6UFZ6bk94ZEJRcmowNHp5c0d4ano2T1YreG1XOUZaVUp3UFIzRUUw?=
 =?utf-8?B?RkNYYTN1V3VvSWgyQllmNk83QkJ4TWs0YURrVzlQWTg4YUg5ZWRsamNhbXRS?=
 =?utf-8?B?dklXalVtYmE2aG12VUJwSHU5dTBCSU5WcitoTm5uUmtpSWdOTktxQ3ltT3J0?=
 =?utf-8?B?VElmRnl6WjRtWkJkempSRFR0cENzekJTWnFVd1FEWFRZRjdBdEhJdG5DaE8x?=
 =?utf-8?B?REUrcDg5bUo2c3NCMmt2TlVFa1g2bXNzZEZLNnlyWXpoVHFCbElKNThTSi9N?=
 =?utf-8?B?Vm1SOGVzOHUxN0FPSUUwSXVvT2E3cVkwV3pmRlQ2WWtJRHhFc0U0VXR2TXNy?=
 =?utf-8?B?WTVpTkJ3dVZVNnI1WkM1a3Mva3lrRHk2aGh2TU9qS2VQQzVKbGZCcmppTk1a?=
 =?utf-8?B?ODdwNzUxVnpjTE1GSU5MUVFoMkU0SHNHc21zNmpYNnJQMXVjc1ZQQXc3RFhB?=
 =?utf-8?B?b2NwNEtENWpVV0lqOUhueHh2d1BraFFXVDVnQVhEakJzcThTWkVwWUtKYWF4?=
 =?utf-8?B?dVZ1eFRTSXFNZG1VTHUyUS9LbDZiME96c0x4M3hpemJKL2Fiam4xNmxNZUJr?=
 =?utf-8?B?UGpZZ3RnaCtQK0tBclBORTQyWXpWRyszTVVGRmdwZmtLNUVVVVBUZ1FzT2dB?=
 =?utf-8?B?SUw1dkg1NkpiTGcxMTNWV1YvaFpseEtSRng0MFFEb2QrU1BXMkVLUWlnZ2J6?=
 =?utf-8?B?WDJhS3VOelpPTTRiTWpLcm5LeUVjVTdZK21WL1k4TlcyTmxmSFB5Um81ck41?=
 =?utf-8?B?dVJ3cEF0M1RkYStYWG95aTFZYVIrTE1OM2JjQ2N1aEM1d2srUnpOU1U0SC9J?=
 =?utf-8?B?VGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <717038018C6E934C8BF0CE6117CDE9C9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VH/2hTLQxXp7RwXQBbbWMKV8A1lzr7L7Cd/1WeT2Stl5zoEDMYVvuSTwUOii+HQdYSl9X8NEL2LviJFUQqVVlwQzhjFwQvWKPuA8YwBuAjEth1370Fpwn+NSuPMCHkm5n039Uu2YRhuFyGcxJi4i70j/Y2s1HpOGLsRF9CgjH0p7BxzuZy79nxOawG8IEX4BIz1RsU0hRSMrjbqE4TziQY5d/ohhbwynSAepkStXmfKnVsod4YKlUf2oE2lUEIW2KuVtbF7YqRQYjXVL6lEebjGQe/b+74Sio336sziBcmE1gbJ9C09f+VreI7AE44cb3/FWmX3t6CtZl1OB6yLPSpvSuimaetPbFq7/cNz77jcD5RIhGQZOXf1/jPjkpSZhzgwHJfGHbvt+XKZFYjU/vSrsnGK3Y+7s5M8u4/jyH+4pi7qF0cQt6eR0e4SwNdTeU2t9yCeGoFcCcYGrAVMvvJfLhI+ZxYxN9EbPfF3GHpKxJzH8i1FUT7sB0mMPcK9Ajdgm1z5vyu9d7L37XE0yHSwf0oC+YkU0yc2FKVC1nZI9ThWmB8lHK9OlyaVc35UPPcsEgq2dBo1zdaEmbzx1+L2wzNdQjm42VNPBJ+Bwk1e6mI+KRKk7qHRfrRMoanYe/rMV45VOX4A8rcR8huDIqn8+Cw6C7DgNFqgE+Q4BVPiEGdhKxFPhrDKj/SW0a+swfoKKmjeTHVw1+kolTx+zK9PsLQ3U+LUt9SmMSDpLdISjA8b6SX0/dIrQOdV51HRCqbPAopy0hYzkqyYO9eKF4CVNHkq/Vv+8kfCcuOtbksY=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bda552d-1f7b-43e7-af1f-08dbbe5d8d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:55:21.3094 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvfRJd7PyefVpiUt/hhUgfgq629jdjj+kgqbDXTOZCkDn+mgJoFEBOxiAEB8ElKRuG6KvTsDWOJIKCHYWbNRbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10340
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI2LzA5LzIwMjMgMTQ6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAiWmhp
amlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBPbiAxOC8wOS8yMDIzIDIyOjQxLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPj4+IG5vdCBhbHNvIHJlcG9ydCB0aGVtIHRvIHRoZSB1c2VyLCBiZWNhdXNlIHJl
cG9ydGluZyBpcyB0aGUgY2FsbGVyJ3MNCj4+PiBqb2IuICBXaGVuIHRoZSBjYWxsZXIgZG9lcywg
dGhlIGVycm9yIGlzIHJlcG9ydGVkIHR3aWNlLiAgV2hlbiBpdA0KPj4+IGRvZXNuJ3QgKGJlY2F1
c2UgaXQgcmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4+
PiByZXBvcnQsIGkuZS4gdGhlIHJlcG9ydCBpcyBib2d1cy4NCj4+Pg0KPj4+IHFlbXVfcmRtYV9z
b3VyY2VfaW5pdCgpIHZpb2xhdGVzIHRoaXMgcHJpbmNpcGxlOiBpdCBjYWxscw0KPj4+IGVycm9y
X3JlcG9ydCgpIHZpYSBxZW11X3JkbWFfYWxsb2NfcGRfY3EoKS4gIEkgZWxlY3RlZCBub3QgdG8N
Cj4+PiBpbnZlc3RpZ2F0ZSBob3cgY2FsbGVycyBoYW5kbGUgdGhlIGVycm9yLCBpLmUuIHByZWNp
c2UgaW1wYWN0IGlzIG5vdA0KPj4+IGtub3duLg0KPj4+DQo+Pj4gQ2xlYW4gdGhpcyB1cCBieSBj
b252ZXJ0aW5nIHFlbXVfcmRtYV9hbGxvY19wZF9jcSgpIHRvIEVycm9yLg0KPj4+DQo+Pj4gU2ln
bmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQo+Pj4gLS0t
DQo+Pj4gICAgbWlncmF0aW9uL3JkbWEuYyB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMo
LSkNCj4+DQo+PiBbLi4uXQ0KPj4NCj4+DQo+Pj4gQEAgLTI0NTEsNiArMjQ1MSw3IEBAIHN0YXRp
YyB2b2lkIHFlbXVfcmRtYV9jbGVhbnVwKFJETUFDb250ZXh0ICpyZG1hKQ0KPj4+ICAgIA0KPj4+
ICAgIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3NvdXJjZV9pbml0KFJETUFDb250ZXh0ICpyZG1hLCBi
b29sIHBpbl9hbGwsIEVycm9yICoqZXJycCkNCj4+PiAgICB7DQo+Pj4gKyAgICBFUlJQX0dVQVJE
KCk7DQo+Pj4gICAgICAgIGludCByZXQsIGlkeDsNCj4+PiAgICANCj4+PiAgICAgICAgLyoNCj4+
PiBAQCAtMjQ2NCwxMiArMjQ2NSwxMiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9zb3VyY2VfaW5p
dChSRE1BQ29udGV4dCAqcmRtYSwgYm9vbCBwaW5fYWxsLCBFcnJvciAqKmVycnApDQo+Pj4gICAg
ICAgICAgICBnb3RvIGVycl9yZG1hX3NvdXJjZV9pbml0Ow0KPj4+ICAgICAgICB9DQo+Pj4gICAg
DQo+Pj4gLSAgICByZXQgPSBxZW11X3JkbWFfYWxsb2NfcGRfY3EocmRtYSk7DQo+Pj4gKyAgICBy
ZXQgPSBxZW11X3JkbWFfYWxsb2NfcGRfY3EocmRtYSwgZXJycCk7DQo+Pj4gICAgICAgIGlmIChy
ZXQgPCAwKSB7DQo+Pj4gLSAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiUkRNQSBFUlJPUjogIg0K
Pj4+IC0gICAgICAgICAgICAgICAgICAgInJkbWEgbWlncmF0aW9uOiBlcnJvciBhbGxvY2F0aW5n
IHBkIGFuZCBjcSEgWW91ciBtbG9jaygpIg0KPj4+IC0gICAgICAgICAgICAgICAgICAgIiBsaW1p
dHMgbWF5IGJlIHRvbyBsb3cuIFBsZWFzZSBjaGVjayAkIHVsaW1pdCAtYSAjIGFuZCAiDQo+Pj4g
LSAgICAgICAgICAgICAgICAgICAic2VhcmNoIGZvciAndWxpbWl0IC1sJyBpbiB0aGUgb3V0cHV0
Iik7DQo+Pj4gKyAgICAgICAgZXJyb3JfYXBwZW5kX2hpbnQoZXJycCwNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAiWW91ciBtbG9jaygpIGxpbWl0cyBtYXkgYmUgdG9vIGxvdy4gIg0K
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJQbGVhc2UgY2hlY2sgJCB1bGltaXQgLWEg
IyBhbmQgIg0KPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICJzZWFyY2ggZm9yICd1bGlt
aXQgLWwnIGluIHRoZSBvdXRwdXRcbiIpOw0KPj4NCj4+DQo+PiBJIHRoaW5rIHdlIGNvdWxkIGZy
ZWVseSByZW1vdmUgdGhpcyBlcnJvciBtZXNzYWdlIGFzIHdlbGwsIGl0IG1heSBuZWl0aGVyIGEg
ZXhhY3QgcmVzb2x1dGlvbg0KPj4gbm9yIHNvbWUgb25lIHdpbGwgdGFrZSBjYXJlLiBKdXN0IHJl
cG9ydCB0aGUgZXJyb3IgcWVtdV9yZG1hX2FsbG9jX3BkX2NxKCkgdGVsbCB1cy4NCj4gDQo+IERv
dWJsZS1jaGVja2luZzogeW91IHJlY29tbWVuZCB0byBkcm9wIGVycm9yX2FwcGVuZF9oaW50KCk/
DQoNCg0KWWVzDQoNCg0KDQoNCg0KPiANCj4+IEFueXdheQ0KPj4NCj4+IFJldmlld2VkLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+Pg0KPj4NCj4+PiAgICAgICAgICAg
IGdvdG8gZXJyX3JkbWFfc291cmNlX2luaXQ7DQo+Pj4gICAgICAgIH0NCj4gDQo+IFRoYW5rcyEN
Cj4g

