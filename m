Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F7B7A92F3
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:09:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFg7-000659-4x; Thu, 21 Sep 2023 05:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFg4-00064a-6h
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:08:52 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFfz-00084H-Gx
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695287328; x=1726823328;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=8AoMS8u1By6RLZzuamfTd/6rpR3sUYalBxS7wBFkXhI=;
 b=E0zfM6An33wgfNTAgvEektZWm896Lsk00idwBoMsVbocq7Hl0aQ0n2Ql
 9ASorEjjDyunnC753mx/+TnZYG5UoFPXQsCs5nnkxS5kisXz3FcDvM7TJ
 amh6AiV1CRTim4WBY7UzSxeFKDovQ+c03W6e+ZQje5RRi1FiJ9II/3OUM
 2+4fS51BhrtDeytcLECu7mfyfNLtI2xokhur26+MtXeQt9ccJ1Ze2xw3G
 QgV52gNaHAeYLOAZmPh5djP6zZ9wQd2DufuSpYWTpyI0Ih+yOtQX+07OI
 OwqhZl3iA6fGJDdQmt17qEjdTv3OKUn72X7Oee40ZteuAiBTThTlbKBwM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="96226744"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="96226744"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 18:08:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3zbwUaNoBqIqp5US0lTua6CHTabgmoIe4i7QI84OZkOXTYThN0mx9MZSihilQCM8ibMrmD1Ls9H5uTJJgwKnk44ETGekVTU3EBgfKPfEXRRNeza14kWmt4UoMWdrkFZ3s5kH6BaBs9BURR7TbagZisBWFRbLQNNPR6r/1S/yodZuW1XzHMk3Ni9/XTzX828mKj1F+VeOiO3QVWdZMaQT9t3dnc9qKdGASNHZfvOIjHO4oBJ9Zb4jpmtlmywncRNoLmBda0L6jHZIdV424fFP4opD9Q52rVHL71PKyqaLcU/4IdEHATa5mqU5vv4SVJejHfSeIsIZjRsbsScEYd7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AoMS8u1By6RLZzuamfTd/6rpR3sUYalBxS7wBFkXhI=;
 b=V8i5PU8ODJgDob1rZ12olNU+u4OZEasKPA6FRkTh9jn4coNqG5Tv8yopMZvmBThV57+0DStj49SNekoQuPQZmsY0vpjzcbiIA+jGKnSCy39ej4A4NqvtQrEfqyAS+1E096PQBO6K6Ofstw2ldfPlpIGM7jtDwoKbZU23p2Pr19c16bURdv9QY+SnR3JcKYH3EGZwVisor+1Gr57XG7ttmU8zl0XRXpaB/fhAkLCTWPAL87q9qrHjhzEM8VPSmihxvOQ/f6KSIUjQ/TzFVV36EeUkW2Qm1IvHCu/s5xKb+43yyvllCAcriwDHEgRtFF3eEWE7G063Db0SU5wcfsHwOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8848.jpnprd01.prod.outlook.com (2603:1096:604:15d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:08:40 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 09:08:40 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 09/52] migration/rdma: Put @errp parameter last
Thread-Topic: [PATCH 09/52] migration/rdma: Put @errp parameter last
Thread-Index: AQHZ6j6cxiBisQf77UipAWMxx5uOCbAlAe6A
Date: Thu, 21 Sep 2023 09:08:40 +0000
Message-ID: <c1260d7e-a093-806e-6674-5052216f78f0@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-10-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-10-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8848:EE_
x-ms-office365-filtering-correlation-id: 738b7209-e310-46b2-016d-08dbba82592e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YupK6ml8ebwiYXdD3jifDo00z3gn0fo2WVEHQWsMcsEEUpYZHGeGoSF1joLjDSZxAamnCZcJV0HqbSdLBkA1ALhYnhnBE7VpRXPJWWmhfkIyQ0XkvneDs6OFqlalnJvHYTlhram+cT2p9QRXU03FEZTAON0d37DDbDzQK/Hz0fdqnz4sdOmm1T+HcH0QsRcz0TWOrOI3F8n0bXvrdaKHmxuPEGkU2weFoCNsdP+iAIDeZAvpOUXWItQAcmqgZC/MP8e+LfAG+biC5wI3P/WsU68/0JUwtAu7QZ0m1aogGPzOuCsg7QOhtiRK0lEomtbz72IGt2QLE78BbROB4FVtdltYhMrOknjwIW7u9yinMwAkafEn0bz1czOz2om145jp3SjoJCane67lH8ivNZ240dMLN4MCzfQAmAjnVa4O35ml9ukA8otni8f0T5nE7JF4DDU8kVvEqZ6MPD+99e51tcOxA5tWtpwJ63A69z3oyPYdQK86xigvc/f5Zdw7IkfKlSkG998IwGqpO7mDg1eNw+91Eryn+1NygE15H6tTT7RYoNQwgkusKmmgpssLVpqX9M1m/x39eKTbQ835uvwn40/D6g0Kscb49lSQeFRC/wlRdXj9u7HprPUGhSdEkZ0UD6/5TAF69VSGskO8rgIhQZBd8m5SeSe0lEuo3WJqwhJruSGhaA/LPnMquOKi5mNzZq+Faaoa0Umh3xScK3WGMA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(136003)(366004)(376002)(186009)(1590799021)(451199024)(1800799009)(2616005)(6512007)(1580799018)(26005)(122000001)(478600001)(53546011)(31686004)(71200400001)(6486002)(6506007)(41300700001)(38070700005)(38100700002)(110136005)(91956017)(76116006)(66556008)(66946007)(66476007)(66446008)(316002)(82960400001)(8676002)(8936002)(4744005)(2906002)(5660300002)(4326008)(31696002)(36756003)(85182001)(86362001)(64756008)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VC90RFR4VVhtL2plRTNzaWlZVWNLS0xLMVdSM0pFNE5jZFVSdHFSVzNJMnlS?=
 =?utf-8?B?eEl4Y0l1eUE4NGRCNXU3ZXorYm1KRXNpdmNqM2Q3UTBpZGlnZC94VEpXSWxY?=
 =?utf-8?B?dFBsOW5Id0IwK0srVFh1VEhWMW5vUnRoZWN3UnN4VXJ0c3h2NFl3Ym1jYnZj?=
 =?utf-8?B?NHI4WnlWNkxRYTNwRUorVnJGeVpVTWozVUVuSUpocE9iMFhTU1Z0TTBZcXhj?=
 =?utf-8?B?UWFiZHkvckx6ellYdE1ocDJMcEZFc3BiTFpYYzRJYmc4RlQ3aFo2d1Fob3RE?=
 =?utf-8?B?RHF3ajV6a0NpVFBacHVoS2NuU28wZmpEdTRGdUNpeUR6WXZHM3hxQXlYbWZ3?=
 =?utf-8?B?WHd6TjVsTnVtYkVGNm10NU13dXovRnpCeEdCLzdia2VrMkY1WEw5RHFEMW9I?=
 =?utf-8?B?WkVDNVNaUnVBM2lEMWREM1lsOXpiQythSVpEQ1Y4YmFPck9URURtUmYwa01G?=
 =?utf-8?B?dlFxaWpyWjZaRlRtTDhwTmpJSHRUT2tEbW9FQmY0cUNUL1Z5b081eGNRYnV5?=
 =?utf-8?B?N25IcCtJN0trM3hpZGVYMC9LaSs5TUk2Q0ZpMGdiQmE4VFhLcnZjclpDTVYx?=
 =?utf-8?B?ZEE3dmZiRmNFSTZYU3NEeHBjcWlMcXlOVWQ4UUs2UWZwVmswQ0V2OEllckNU?=
 =?utf-8?B?VHRWekorK1EweUhwM25RVW40REtpcWxkV3J2c09ldzhRazdSai9aZEZTSVZE?=
 =?utf-8?B?bFd5OGh1QW9sOVNiS3ZpUVM3eE1YUCtnOVRXS0JvL0FJS1BDTzdja3lLVjNP?=
 =?utf-8?B?SzZnTDJJZElOYmZKRjJaei83Q1lzTC9VUzdHaFVJTG1aejJwcDNSdmFvQ09L?=
 =?utf-8?B?QmptREtOV045Q24vTmpYc3Q0L25VSHowMHBCQlkvRUlKWWh5N20wdFdYdE1F?=
 =?utf-8?B?dHR3c2JPcGtHN3JibG5qclM0d0U2a0RBaFJRWUhPRlpzcnNoczlseDFvYm5E?=
 =?utf-8?B?Y3kvRU5nVWI5aU4ydlcyNDAzQndpendEcnBNNFh5b2RoS01xMlhOWUxkczEv?=
 =?utf-8?B?ODF4YWlJc0ovd09zaElQVU93NGE3ZDNIR2poUE1DdXNJRzRHZ3ZjSy9OQUtN?=
 =?utf-8?B?ZEZmMmFySkJheUdNZTY3UDVOQjRRcE0xdVl1TUhTWjBSU3ZDempGdTZ2ZzFq?=
 =?utf-8?B?U013Y2hnZ002am1qVmN2aFF2Y2hpRmFuNU0yRHdmcmxRRG1Ea2pTSGlTclh2?=
 =?utf-8?B?OURueDFNT0VyYXVINnhhRUxVUlBxSUdOcm1TWW1YWXh5YUt4ZTRGZnRkS1BF?=
 =?utf-8?B?M0JKclZISWJrRGI4QUlqYVlKSWY5S2xtRWFsbTQ2SVh5RHovaUlaNzNaeCtr?=
 =?utf-8?B?bkdBcmxwQmJ5c2hHVXZDTVcyL21yMGFzcU1ZblV2dUpycmJYejBCMjIxeUUw?=
 =?utf-8?B?THBndUM4bGc1ZjRqcVVMLzJ6bG8vaWVjeFhNUU9sVysrRTVvcjlNa3VNTDdB?=
 =?utf-8?B?L1NESFZjVUFmdE1nUEdNZC9Nc0VMcWxxMGNZL3hxakd3d3U3UXBVZVdEczlH?=
 =?utf-8?B?T3diODZ0TTY2REp4ZC9TekJXWlBpejJqcDF1Z0FKeHFYS1phei92Y1hrQk9L?=
 =?utf-8?B?andZQUZxS3FjbnIwRU9pSGcwYnNITE9CUmt2aXBSbUE0dHl3ZzVWa1BiTktC?=
 =?utf-8?B?VGtxb1hzOU85UmMzekRQcmFtY2h2TVZEdTVVSHR6Q0ZaMU1wY2kraGpZY015?=
 =?utf-8?B?Sk9NVlFXc1NZQ3lDWjV4d0kvU0hiU0E4b3pTZUlVdzJaT2lkenJ5YllhNTlm?=
 =?utf-8?B?bWRDcWp1cU5uWlA2V2hGeTdPeVVjM213Q3JRa1luSUJhWVVBTmxXeFhvV012?=
 =?utf-8?B?SGd4NEU0QUJUalZ6aGVrQ09iRU5xTC9qMVNoc2c0c1l4dWkvTTBXYjNWZ2tD?=
 =?utf-8?B?QzYwaVExREJvTUNSMUt5Y3BCOGpOY2UvMlVPcVFxOFUrM0U0ay9NV1ovZlJD?=
 =?utf-8?B?c01HajF1QU5seWZubk5iWXh0Y2FmVDJoK3JwNmZ0Y0QxOFVpY0J2ZjJreWZB?=
 =?utf-8?B?Y20xMmpBUnI0NkZ3UTZiOHh1QlNJamtQMTJERTcvT29sY1JETFVSYWdWeHJV?=
 =?utf-8?B?U1BnU0ZmUVNUQWRnem9qbDY3MTNROUJCTTVLbG9sNCtGbU5zWnJXU1lNbjEw?=
 =?utf-8?B?WUFiL3lja0dQYTl3cGl0b0JMektyTGRiQmxYbjNRSGZlekp1STJudTRqT1Z2?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F7200A736DE1546B9C2AA2680C765EB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fQTfrOJ/IjI8hQ54OLzN/fBdnE4VkJWa9XyawCgrNr0OwB98pkZ8USK3RSlnvlBGowphzKPaqbeSDWxkiCQkKrU/+NkncVBQa2B87dbpx4fyriJk3dPqhjjl9fHD3/G2p6qKj/i1Ru07qvRzxk9Iyd6Z4Y5lVFg/QXQpua6HFEWkgZrMxfua3li76H2/HiadAz0bX+l7kBrCIN8fEHAsFgTCNIE9fh0SIikvGG2ZxLNdfDmrbnlUATFol2x1NgOMrTIR/sF6wb9cD8bDS4GHGTjhvrLH76FHTtmOQqdS7ewhUOn1jnhoyogJr9LB8pMbf7K4ueca3zBubPKRLGuifo9GX3NqcuO3Wf4cCmQnAk7bwGW6FOoEPnqXpVaO/ZuQUItKPK16PpqSukhwah36Y9sXmAVdwn7i+szH8LMi82lwFXMmhOM+N23Ljeu1qCEoSngLMvrja83Gn2hwtdINt39ptkZICnu2Q8WNYnCzU+entP0HB1M5irlciFhvnYC6ndkl/bU9XxOgB9zgE9sxgSbTQzodLQzI7qrg899OPQ7ZNKkKNgMPUeTA1LxqaANzzqgiHi8aWMUAVscdNGEv3p54Ow+klrq2Ca3CUV2hV3Upfm7e9kPmFGpxIc6hXYuh8iGZtmUZFCHp7RkSko0UlIiZYEW3WibpkIt5sofktigIdcsxAxOTHC1vWZSWLWtPPZgRGNyY4lyM4LP3qtqrYn+1L4VHBCoeyvz3w3PKMp9w2vnXwGH30lLqfQeA9P4RKyHxS5YqAASpr6Fhq94RwOpVA9RLZu730tsd1bHhZkw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738b7209-e310-46b2-016d-08dbba82592e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:08:40.7510 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp5YZw/WuA4yS7DNrtl5UfpyYfsgdwOfh/8/su85zi9dpH1wGdbNuM/vCSKjFF2np5ijpFjAziqSuXesJSvvrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8848
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBpbmNs
dWRlL3FhcGkvZXJyb3IuaCBkZW1hbmRzOg0KPiANCj4gICAqIC0gRnVuY3Rpb25zIHRoYXQgdXNl
IEVycm9yIHRvIHJlcG9ydCBlcnJvcnMgaGF2ZSBhbiBFcnJvciAqKmVycnANCj4gICAqICAgcGFy
YW1ldGVyLiAgSXQgc2hvdWxkIGJlIHRoZSBsYXN0IHBhcmFtZXRlciwgZXhjZXB0IGZvciBmdW5j
dGlvbnMNCj4gICAqICAgdGFraW5nIHZhcmlhYmxlIGFyZ3VtZW50cy4NCj4gDQo+IHFlbXVfcmRt
YV9jb25uZWN0KCkgZG9lcyBub3QgY29uZm9ybS4gIENsZWFuIGl0IHVwLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdl
ZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

