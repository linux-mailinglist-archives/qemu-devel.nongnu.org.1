Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E102B7C7FEE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:20:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDIa-0006O1-CU; Fri, 13 Oct 2023 04:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDIM-0006Dy-RU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:13:20 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDIE-0002DI-VS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184790; x=1728720790;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OLq4x4IwnsgAEwW04qc25eQ0Mzjqct02EfUn68pgLSE=;
 b=CRsX+cudjZII1zYq5w0jT8hHChXCHVybMlof84tJfO8ZC/Mk8BJY+Cdq
 YAsHsPWac7JNIWhFJXaNLtfwyNAQMMqxaLZw89dell0KhlS6HNt6SI5Ub
 fvhDRP5xUQh+w/GuEXNWgzH3dlg1kCgIhIhYsjWed1F3rmDc/WnvG6N36
 SR0RlDCrkDL0zRW4BNb9SGi1JnvheSfN2ZQEKzMbKWQV9Bri1YJ2WtedA
 aDij92oKadOmpt1r0hGuq/QcE59DNbxnb1yyoAf7hsOWzCUgBuF0gkfLr
 rpPRWz4/NorFy/HZ2fLuMPgAQ8u9Bw9MTjBGISSPJo57CvlsxFqcRcd5L g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="12108675"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="12108675"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:13:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCmCip0xmwV7v9lyOWBla2JfQqotr1B9gw92ktMAsisMbsunqPAwkPU3rFR6GRf6UULCRXzxunPlDOvjp2ASq1VNQUkpCrgCT3QYLnK5ZVc6DaeXuHyc0W1BgW/1D2hY6iJsWZSvvTAcQHjg9+8/cp+4ES6cwIG3HOfzKjElLV1AXPMLIFpos1Kd3GxHmw0gKb6nKr+WezrOJkcjPIT5HFRrcel+DsVqZ6CH6i3IaCpj9AMmhzk9IMPE7aM9YCoLbBMUZa2S56r0dM9Frr7a9Pt60zeSHd/n/ZIkitDldI1wHrGtzmlimFHqBkNppfktoiwdnBGfHF06LQvJPhiogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLq4x4IwnsgAEwW04qc25eQ0Mzjqct02EfUn68pgLSE=;
 b=ZpJvX78tYIQvYgbfyQK9+8cJiZgJheepO9DRrEzozbtn8YFAGV6pW3WmwAT/22yeladlkD9JrJh8zMH2EdYZvmQPXWAxtcrsotyPspvAHcob2fvW5UIvBdCp9RtJ1ilA7llz35D+kXMoXw0eQ7YikGlkjMNeb5quOyMQ8W8QjlfcBWRrK9rQchgE31JgT8vr04t+/wCNkEtEcqy6etckAhtYTqZshuugAfqIhwjLXS4sPeojcdQAw34vgVRN3W8c2raPW5ixaCrDdj09ZXkywYdkYKNOW3sLUMVaTkOohWzLPx5P/ByZdbnmj0zLnkpZN645pi1P6Pyb2dPEBwBo0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:13:00 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:13:00 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 11/13] migration/rdma: Use i as for index instead of idx
Thread-Topic: [PATCH v3 11/13] migration/rdma: Use i as for index instead of
 idx
Thread-Index: AQHZ/IKHG/ALUX1tBku3gmRABZQ5BbBHYSEA
Date: Fri, 13 Oct 2023 08:13:00 +0000
Message-ID: <25e2bbc6-5d0e-da3e-fe71-eb6866909210@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-12-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-12-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB12093:EE_
x-ms-office365-filtering-correlation-id: da84c8d4-0244-4937-47d5-08dbcbc43738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hi7X0DOaa3Vg/o0RHvt8JA/p791W0NUO3d5Sa+hQ53J3R+hNbkO63ScXrKMe00xskSnoY3N6BLHW8tDbCM81WFAEDbRLgPZWklmw6TaUtTCG9pRpxZHun+6GD1uziW51sAHuvMddtAuanXZFasuzdVM6W+mnA/Jv6oFvCZAU5MUsjWo31Q8WEpyKlHWByRMT8+iytBNTcpU+jkIP/EkdHmGjtF0/pUN/DDuXzG9maLN2IO+BecHBiSqyTsvad5sSyjKlOykS7RNbp9BEy5hqB1WBrv1mJq3BsF6rJRtsxTJi9FKU/i2MTYM2+Yeu0Dq9v9ja2yvLamUzXmsgK4IssClvFGteas28gAebiadtUiiPYT/LwgMSOwj5x61384EJnroHoxC8ErxE0YNc5rSGeIn0RGocm3XnU4OpuHXz/aKrYKugT2bCnkiWvlQgtvH1zuyJutXxK61kxLMa7AbJVNDCOTvxhSKnXE+lgztuCKs6B5x1BC7Wbxxe8auLwLz/s8Tq3V7S08jDcBlZvMrKzClNNCm81ZpUhv288Rw2xNJw1RC+LQ6+1CTi/QxJmvf0YDJbLS/zKAkUW/LvE5LjvetE05SVS34jiLtvt/CuJOcnjtMCcUr163fofqEzjhi4c8I9Kfn/PCgzmmfy6wIsydffh7eCdhFnODvpoyrRC0hqK1t/Zk385cJYpBxt8kA7InSYuypXTeSXRssX4uuoQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(1590799021)(64100799003)(2906002)(1580799018)(2616005)(26005)(122000001)(478600001)(38070700005)(38100700002)(82960400001)(31696002)(86362001)(6486002)(6512007)(71200400001)(53546011)(6506007)(83380400001)(4326008)(41300700001)(8936002)(66446008)(64756008)(54906003)(66556008)(316002)(110136005)(91956017)(66946007)(76116006)(66476007)(36756003)(85182001)(5660300002)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXFwQlNwV0dxVmlaQm52amtFTHArQis1Szk0UlVXVFFka3lzWC95QytpZmtQ?=
 =?utf-8?B?NUlNQlVPazR3Y2dEZzRlaFJNSVhsUUd0c3RRTDZBM3NOc2Q0VnQ3NUtxY0pz?=
 =?utf-8?B?dlpVMVpGbk05Z3ZPZG5pNWh0VTFYODZzUXNtNTh0SEtzTFd0VDRyeEovZjdV?=
 =?utf-8?B?c2tINURPb2ZOUEZkUmpxVllFY2t1d0pRSjVoNyt4N3FBa2tiNmFRTVF0ZzVv?=
 =?utf-8?B?MnpiQlFBVDY1dEsrTVFScktzcDl1V09jb21WdFpYaDYrc2JNNnhPRGZpRTlv?=
 =?utf-8?B?T1QwQzk0VDlzS0FOL3dmVEFwSmNCQWMwbVBVU1pRVmVRZ0x4SVppRS9INzBv?=
 =?utf-8?B?TDgyUU1RanRWcTl4SExJWFJXV0pvR29nYkZzL3hUcmJWbUM2Z1lFbTVZNndQ?=
 =?utf-8?B?L0I0UnMxeG84dHd5UCtUVHdpQ0RCT3JSSU5ZNXhIV3F1OVphdzB5SHFiVks1?=
 =?utf-8?B?blRrZlQvSzRYTDV4TkhUWUVjUVpNV3VjNlB6VUVTN0Z0T3VNR2M1RE5RQ1li?=
 =?utf-8?B?SW9pTUkyVHI2c1VBTVpkQ1dZVWUzMzZhbElMQXFqMWNBbE5BQ0JOYVNxTFRV?=
 =?utf-8?B?alloWnM0M1FlSVB3V3pHdjd1Z0RrSWNjRnJZd0FSNlBybXdtT3dlMnIvekxq?=
 =?utf-8?B?UUJNZXRCcGxtSEFxVTFWT2t0QmVKSGhFK0hrZXB1MmdQVGV1SXg1S3QwclQw?=
 =?utf-8?B?VFFCbCtoRWE1Yldqd3B4eGpjSUt5SGRXeUJMa2F5ZjIvQVcyaHRYR1VIUGFj?=
 =?utf-8?B?ci8xL2lJVVpyTWJKNjQwdDlyOHorK3c0MVcrc3BRMENKQ0E1R0pSdTVwNE1o?=
 =?utf-8?B?RUtJbmhLR0VMNnpwQlIwc3ZlZHJUWVdtT0RHN0wxdUlpRzVTdGI4YW1MZFhm?=
 =?utf-8?B?YjBKako4Yk94STQxMk54ZHJuYVkwMXlFallaVmEyc1d0Q2xXVGM3NitSSThm?=
 =?utf-8?B?TVY1bFVMOGRxaE9ubllTR1g1VERMVDc1cTIrdUtvSXNWYWYyeXlHNlBEMGIr?=
 =?utf-8?B?YWRIZERLU09Sbm8zQW1SWTFTbXEzVE5xVG5xaE1rK2RpU3V1Y3ZCRURZeWZV?=
 =?utf-8?B?SkduMFhwVlpvTzh2d3pqSDlRTmZScDBYOURoaXQ3Y2VLMTkvaURFQjVPZUoz?=
 =?utf-8?B?Yk1NazdmMVpEeEdWVHJBNlN5OE5kbkN5cnR0T2tRY3FvbVNBSjVRN0NmRGZ3?=
 =?utf-8?B?WXQ2Zk9TOGU4WGZEc1JsRWkxY0pRbWg2N1RiS3g1TVo1dzgrUjlwRnpoUXla?=
 =?utf-8?B?QkdVR2pmZFdheFFyc2xiYzhaYWE4a1JlQXl5YUs4TllLZmYxajFmeHhjMDFZ?=
 =?utf-8?B?bng1QU9wTDc3eENnUkt0ZmxtUVROb3lOL3Y4OUlOUnlQQURHZlAwNFRJdnpq?=
 =?utf-8?B?VmRQQlRseEdDeXJEZUtNQ2pVbGlxSjNocE40WWM5c1cvbndia1lSdEl6OXdw?=
 =?utf-8?B?SGY1N3AzQ2x2Z1JCeXpXSE83Qmd5ZWd1M2ZmbTNzNmhGeERDRnhmaEs1bzN4?=
 =?utf-8?B?Z01HaUdtbU04a3dmdmhtSlBmNkg2NzhjWkNlbEdRdVBQN0ViVHpWWk5SWE83?=
 =?utf-8?B?L1BFekY1TzhqTFYyc1FhamxOb3FEbVBWc2kvTkp5WUI4b0J4eWVCY2FtNlNX?=
 =?utf-8?B?eG55elA5aCtUN2c3NDIrYnVlRkR0V2FxU1BrWlJhVlQ1Sk1GZkQ1UjBPYS9o?=
 =?utf-8?B?N3liUTFaRklYWktYdStFSkROY09LcGdTa09qZkhBZmF2dFNrSmNDUStmQWc2?=
 =?utf-8?B?eGs0MGpERm83djM1U1pVVFFVZXVHUlJXTXh3aHh4blZyQmNTVmV5V0lOTjRP?=
 =?utf-8?B?dHg0a3lZbVFvOE05dW5uUDNnSW5aZDFSTWc2UThSUm40bTZab3BaaVZNVHV4?=
 =?utf-8?B?cWo2YVVsSEcrVjc2WHZubWszeXJFalVSR1JneW5vMG5LZlYxd3lyUEoxSDJ6?=
 =?utf-8?B?Q3BiNVg0YzJjT3c0dHI3RVBMOFhod1d4UkI5OEVwWE1wbEt2cmhvOUtIQURr?=
 =?utf-8?B?S0RORW4xbURjVnRLS1J3KzVsQXRyYmdMR1FUaTFuejlrTmM3VVFERlB1Yy92?=
 =?utf-8?B?d1RoRkZjWU9FK2NlUlQ0OWlKN0l5M3lUUVpwWWdRQ0ppM0l3eEQ4bnJha0dM?=
 =?utf-8?B?aXViWkc2RmJ5ZzQxRTB6S0xDSmd1bGoxNktybDRhN3BlVUl4OXhRMHNLemFq?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <110DF1A8356D764C9880ED6369A0434A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1MUzd+LRtEwLDNM1SXNXbXuDgweGVPOnhrRPNzJFPmcQXeXjIVQVusToxUiS2SPeAHv234GKPqTN+gkP8QOyKN0qnJKy4wl1quVbh8TReveWhciUOmJB+ObwPKeEpnqwhJ2yZJEZ/9Mb52xSoqlwnzEpEVjkEtTXGlw/Y1S6kiJZpzOnakBX13CVuqmI1QzAObjn5dtr+3dGlWpDhL3aZRk5k4rrzl/Pihnkn3r2Yq6m1CRXEwBR8vMON8FA54XVUyj90tEGUx7C92KRYS97yN7QaxOlZ6OAuPgkD4TOqupkMwszrMV4GpU2xwPZX02JGAZQfzQzkjI0j5huKTQF/ly0j/gmIlrNyGYyIKDSZi7dOOgjf8J5lzUAG785ujLdtcWEByCL0uy0Aj2PNt/Skkeo+Dchjrqd0s176YzaaPavYthWg733KB9Wtf9vdGq4DE1N0aYPScQLOu1/x7hbSpQhab4mSl8knK9RPx6S7sWl/R0HnCI+kv8jt1GT7Bo85hrvXYmuCYVikrFNgts84x3+HcgUikWI5rWtNHujybaPJ1veNSTRi1hLFSFuE7TNQRptLtSGU4tfne68o0en5EpUphsgMqEuxhbuxH2FfARNWkSzZtZewfYuPrXAIasJYukCMcnyc7zqNdgYJD9viDBQLLf+Ke2evHan940Dz4uUO1E9cAEnx4b8TjwIA4LvFiLjHXGU4dyGmG5KRnzJq3QAmaQM5w3vz184Wcxnrsr9oaiLqDjwz1XUe9KmLAJCU9cBfGLwL2n9uW7YMa1U4Mg3GNL6jULG9VbXsET5ckc7q3LtuULwCAlWvIIpkfCl
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da84c8d4-0244-4937-47d5-08dbcbc43738
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:13:00.3081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E28H5ENzLyDdse5CX9LzAyMYHAYuYnYVywzIh5VTB1WYBcx2ViBLjrX8Ea91t3py6CQh0HaXLCS2lcQN0P0OCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12093
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -76
X-Spam_score: -7.7
X-Spam_bar: -------
X-Spam_report: (-7.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IE9uY2UgdGhl
cmUsIGFsbCB0aGUgdXNlcyBhcmUgbG9jYWwgdG8gdGhlIGZvciwgc28gZGVjbGFyZSB0aGUgdmFy
aWFibGUNCj4gaW5zaWRlIHRoZSBmb3Igc3RhdGVtZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
SnVhbiBRdWludGVsYSA8cXVpbnRlbGFAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpo
aWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRt
YS5jIHwgNDkgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+
IGluZGV4IDkzMmQ0ZWRhOWIuLmUyOWU1NTUxZDEgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9y
ZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMjM1NCw3ICsyMzU0LDYgQEAg
c3RhdGljIGludCBxZW11X3JkbWFfd3JpdGUoUkRNQUNvbnRleHQgKnJkbWEsDQo+ICAgc3RhdGlj
IHZvaWQgcWVtdV9yZG1hX2NsZWFudXAoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgew0KPiAgICAg
ICBFcnJvciAqZXJyID0gTlVMTDsNCj4gLSAgICBpbnQgaWR4Ow0KPiAgIA0KPiAgICAgICBpZiAo
cmRtYS0+Y21faWQgJiYgcmRtYS0+Y29ubmVjdGVkKSB7DQo+ICAgICAgICAgICBpZiAoKHJkbWEt
PmVycm9yZWQgfHwNCj4gQEAgLTIzODEsMTIgKzIzODAsMTIgQEAgc3RhdGljIHZvaWQgcWVtdV9y
ZG1hX2NsZWFudXAoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgICAgIGdfZnJlZShyZG1hLT5kZXN0
X2Jsb2Nrcyk7DQo+ICAgICAgIHJkbWEtPmRlc3RfYmxvY2tzID0gTlVMTDsNCj4gICANCj4gLSAg
ICBmb3IgKGlkeCA9IDA7IGlkeCA8IFJETUFfV1JJRF9NQVg7IGlkeCsrKSB7DQo+IC0gICAgICAg
IGlmIChyZG1hLT53cl9kYXRhW2lkeF0uY29udHJvbF9tcikgew0KPiArICAgIGZvciAoaW50IGkg
PSAwOyBpIDwgUkRNQV9XUklEX01BWDsgaSsrKSB7DQo+ICsgICAgICAgIGlmIChyZG1hLT53cl9k
YXRhW2ldLmNvbnRyb2xfbXIpIHsNCj4gICAgICAgICAgICAgICByZG1hLT50b3RhbF9yZWdpc3Ry
YXRpb25zLS07DQo+IC0gICAgICAgICAgICBpYnZfZGVyZWdfbXIocmRtYS0+d3JfZGF0YVtpZHhd
LmNvbnRyb2xfbXIpOw0KPiArICAgICAgICAgICAgaWJ2X2RlcmVnX21yKHJkbWEtPndyX2RhdGFb
aV0uY29udHJvbF9tcik7DQo+ICAgICAgICAgICB9DQo+IC0gICAgICAgIHJkbWEtPndyX2RhdGFb
aWR4XS5jb250cm9sX21yID0gTlVMTDsNCj4gKyAgICAgICAgcmRtYS0+d3JfZGF0YVtpXS5jb250
cm9sX21yID0gTlVMTDsNCj4gICAgICAgfQ0KPiAgIA0KPiAgICAgICBpZiAocmRtYS0+bG9jYWxf
cmFtX2Jsb2Nrcy5ibG9jaykgew0KPiBAQCAtMjQ1Miw3ICsyNDUxLDcgQEAgc3RhdGljIHZvaWQg
cWVtdV9yZG1hX2NsZWFudXAoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgDQo+ICAgc3RhdGljIGlu
dCBxZW11X3JkbWFfc291cmNlX2luaXQoUkRNQUNvbnRleHQgKnJkbWEsIGJvb2wgcGluX2FsbCwg
RXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gLSAgICBpbnQgcmV0LCBpZHg7DQo+ICsgICAgaW50IHJl
dDsNCj4gICANCj4gICAgICAgLyoNCj4gICAgICAgICogV2lsbCBiZSB2YWxpZGF0ZWQgYWdhaW5z
dCBkZXN0aW5hdGlvbidzIGFjdHVhbCBjYXBhYmlsaXRpZXMNCj4gQEAgLTI0ODAsMTggKzI0Nzks
MTcgQEAgc3RhdGljIGludCBxZW11X3JkbWFfc291cmNlX2luaXQoUkRNQUNvbnRleHQgKnJkbWEs
IGJvb2wgcGluX2FsbCwgRXJyb3IgKiplcnJwKQ0KPiAgIA0KPiAgICAgICAvKiBCdWlsZCB0aGUg
aGFzaCB0aGF0IG1hcHMgZnJvbSBvZmZzZXQgdG8gUkFNQmxvY2sgKi8NCj4gICAgICAgcmRtYS0+
YmxvY2ttYXAgPSBnX2hhc2hfdGFibGVfbmV3KGdfZGlyZWN0X2hhc2gsIGdfZGlyZWN0X2VxdWFs
KTsNCj4gLSAgICBmb3IgKGlkeCA9IDA7IGlkeCA8IHJkbWEtPmxvY2FsX3JhbV9ibG9ja3MubmJf
YmxvY2tzOyBpZHgrKykgew0KPiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgcmRtYS0+bG9jYWxf
cmFtX2Jsb2Nrcy5uYl9ibG9ja3M7IGkrKykgew0KPiAgICAgICAgICAgZ19oYXNoX3RhYmxlX2lu
c2VydChyZG1hLT5ibG9ja21hcCwNCj4gLSAgICAgICAgICAgICAgICAodm9pZCAqKSh1aW50cHRy
X3QpcmRtYS0+bG9jYWxfcmFtX2Jsb2Nrcy5ibG9ja1tpZHhdLm9mZnNldCwNCj4gLSAgICAgICAg
ICAgICAgICAmcmRtYS0+bG9jYWxfcmFtX2Jsb2Nrcy5ibG9ja1tpZHhdKTsNCj4gKyAgICAgICAg
ICAgICAgICAodm9pZCAqKSh1aW50cHRyX3QpcmRtYS0+bG9jYWxfcmFtX2Jsb2Nrcy5ibG9ja1tp
XS5vZmZzZXQsDQo+ICsgICAgICAgICAgICAgICAgJnJkbWEtPmxvY2FsX3JhbV9ibG9ja3MuYmxv
Y2tbaV0pOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgZm9yIChpZHggPSAwOyBpZHggPCBSRE1B
X1dSSURfTUFYOyBpZHgrKykgew0KPiAtICAgICAgICByZXQgPSBxZW11X3JkbWFfcmVnX2NvbnRy
b2wocmRtYSwgaWR4KTsNCj4gKyAgICBmb3IgKGludCBpID0gMDsgaSA8IFJETUFfV1JJRF9NQVg7
IGkrKykgew0KPiArICAgICAgICByZXQgPSBxZW11X3JkbWFfcmVnX2NvbnRyb2wocmRtYSwgaSk7
DQo+ICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiAtICAgICAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAiUkRNQSBFUlJPUjogcmRtYSBtaWdyYXRp
b246IGVycm9yIHJlZ2lzdGVyaW5nICVkIGNvbnRyb2whIiwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgaWR4KTsNCj4gKyAgICAgICAgICAgIGVycm9yX3NldGcoZXJycCwgIlJETUEgRVJST1I6
IHJkbWEgbWlncmF0aW9uOiBlcnJvciAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICJyZWdp
c3RlcmluZyAlZCBjb250cm9sISIsIGkpOw0KPiAgICAgICAgICAgICAgIGdvdG8gZXJyX3JkbWFf
c291cmNlX2luaXQ7DQo+ICAgICAgICAgICB9DQo+ICAgICAgIH0NCj4gQEAgLTI2MjUsMTYgKzI2
MjMsMTYgQEAgZXJyX3JkbWFfc291cmNlX2Nvbm5lY3Q6DQo+ICAgc3RhdGljIGludCBxZW11X3Jk
bWFfZGVzdF9pbml0KFJETUFDb250ZXh0ICpyZG1hLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAg
ICAgICBFcnJvciAqZXJyID0gTlVMTDsNCj4gLSAgICBpbnQgcmV0LCBpZHg7DQo+ICsgICAgaW50
IHJldDsNCj4gICAgICAgc3RydWN0IHJkbWFfY21faWQgKmxpc3Rlbl9pZDsNCj4gICAgICAgY2hh
ciBpcFs0MF0gPSAidW5rbm93biI7DQo+ICAgICAgIHN0cnVjdCByZG1hX2FkZHJpbmZvICpyZXMs
ICplOw0KPiAgICAgICBjaGFyIHBvcnRfc3RyWzE2XTsNCj4gICAgICAgaW50IHJldXNlID0gMTsN
Cj4gICANCj4gLSAgICBmb3IgKGlkeCA9IDA7IGlkeCA8IFJETUFfV1JJRF9NQVg7IGlkeCsrKSB7
DQo+IC0gICAgICAgIHJkbWEtPndyX2RhdGFbaWR4XS5jb250cm9sX2xlbiA9IDA7DQo+IC0gICAg
ICAgIHJkbWEtPndyX2RhdGFbaWR4XS5jb250cm9sX2N1cnIgPSBOVUxMOw0KPiArICAgIGZvciAo
aW50IGkgPSAwOyBpIDwgUkRNQV9XUklEX01BWDsgaSsrKSB7DQo+ICsgICAgICAgIHJkbWEtPndy
X2RhdGFbaV0uY29udHJvbF9sZW4gPSAwOw0KPiArICAgICAgICByZG1hLT53cl9kYXRhW2ldLmNv
bnRyb2xfY3VyciA9IE5VTEw7DQo+ICAgICAgIH0NCj4gICANCj4gICAgICAgaWYgKCFyZG1hLT5o
b3N0IHx8ICFyZG1hLT5ob3N0WzBdKSB7DQo+IEBAIC0yNzIzLDExICsyNzIxLDkgQEAgZXJyX2Rl
c3RfaW5pdF9jcmVhdGVfbGlzdGVuX2lkOg0KPiAgIHN0YXRpYyB2b2lkIHFlbXVfcmRtYV9yZXR1
cm5fcGF0aF9kZXN0X2luaXQoUkRNQUNvbnRleHQgKnJkbWFfcmV0dXJuX3BhdGgsDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRE1BQ29udGV4dCAqcmRt
YSkNCj4gICB7DQo+IC0gICAgaW50IGlkeDsNCj4gLQ0KPiAtICAgIGZvciAoaWR4ID0gMDsgaWR4
IDwgUkRNQV9XUklEX01BWDsgaWR4KyspIHsNCj4gLSAgICAgICAgcmRtYV9yZXR1cm5fcGF0aC0+
d3JfZGF0YVtpZHhdLmNvbnRyb2xfbGVuID0gMDsNCj4gLSAgICAgICAgcmRtYV9yZXR1cm5fcGF0
aC0+d3JfZGF0YVtpZHhdLmNvbnRyb2xfY3VyciA9IE5VTEw7DQo+ICsgICAgZm9yIChpbnQgaSA9
IDA7IGkgPCBSRE1BX1dSSURfTUFYOyBpKyspIHsNCj4gKyAgICAgICAgcmRtYV9yZXR1cm5fcGF0
aC0+d3JfZGF0YVtpXS5jb250cm9sX2xlbiA9IDA7DQo+ICsgICAgICAgIHJkbWFfcmV0dXJuX3Bh
dGgtPndyX2RhdGFbaV0uY29udHJvbF9jdXJyID0gTlVMTDsNCj4gICAgICAgfQ0KPiAgIA0KPiAg
ICAgICAvKnRoZSBDTSBjaGFubmVsIGFuZCBDTSBpZCBpcyBzaGFyZWQqLw0KPiBAQCAtMzM3Nyw3
ICszMzczLDYgQEAgc3RhdGljIGludCBxZW11X3JkbWFfYWNjZXB0KFJETUFDb250ZXh0ICpyZG1h
KQ0KPiAgICAgICBzdHJ1Y3QgcmRtYV9jbV9ldmVudCAqY21fZXZlbnQ7DQo+ICAgICAgIHN0cnVj
dCBpYnZfY29udGV4dCAqdmVyYnM7DQo+ICAgICAgIGludCByZXQ7DQo+IC0gICAgaW50IGlkeDsN
Cj4gICANCj4gICAgICAgcmV0ID0gcmRtYV9nZXRfY21fZXZlbnQocmRtYS0+Y2hhbm5lbCwgJmNt
X2V2ZW50KTsNCj4gICAgICAgaWYgKHJldCA8IDApIHsNCj4gQEAgLTM0NjMsMTAgKzM0NTgsMTAg
QEAgc3RhdGljIGludCBxZW11X3JkbWFfYWNjZXB0KFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgIA0K
PiAgICAgICBxZW11X3JkbWFfaW5pdF9yYW1fYmxvY2tzKHJkbWEpOw0KPiAgIA0KPiAtICAgIGZv
ciAoaWR4ID0gMDsgaWR4IDwgUkRNQV9XUklEX01BWDsgaWR4KyspIHsNCj4gLSAgICAgICAgcmV0
ID0gcWVtdV9yZG1hX3JlZ19jb250cm9sKHJkbWEsIGlkeCk7DQo+ICsgICAgZm9yIChpbnQgaSA9
IDA7IGkgPCBSRE1BX1dSSURfTUFYOyBpKyspIHsNCj4gKyAgICAgICAgcmV0ID0gcWVtdV9yZG1h
X3JlZ19jb250cm9sKHJkbWEsIGkpOw0KPiAgICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gLSAg
ICAgICAgICAgIGVycm9yX3JlcG9ydCgicmRtYTogZXJyb3IgcmVnaXN0ZXJpbmcgJWQgY29udHJv
bCIsIGlkeCk7DQo+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQoInJkbWE6IGVycm9yIHJlZ2lz
dGVyaW5nICVkIGNvbnRyb2wiLCBpKTsNCj4gICAgICAgICAgICAgICBnb3RvIGVycl9yZG1hX2Rl
c3Rfd2FpdDsNCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ==

