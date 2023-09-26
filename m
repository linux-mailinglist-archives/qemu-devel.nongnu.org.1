Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5827AE57D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1Ds-0002d9-Oo; Tue, 26 Sep 2023 02:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1Dq-0002bq-CT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:07:03 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1Do-0002N5-Hm
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695708420; x=1727244420;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OkPxETOn+lis7VnwCTRyyk48+sP1HbvffBrH6ltEj0U=;
 b=alZbftgXcgdVmOwlI/L9+FwGsbFblbJuqfeUD6Pjgt0snvFjXMnrU9uI
 Ghb8xrPF/8LPQN0hfOAUgmSIda23ROl/WftOu2dBgce0Y/4sS/VPZlvSS
 CJD6Q6QeljtjwopzoVZXqyBdzqoXOuWp+4s7kNszrPTgIm9PwGb5ZNZj+
 AInlZWUKITrqiSuAX1UlBvdMqwC9oIjIjWqBfrQ1fV77pLM4Z2jfljLp3
 LKwDqj75osKr0PTqaaEyI0kjY5x73Ca1T3YSerA6n9qEaepi5ZhOzwUi6
 gSTg0nwbIkiGdU8xjtlF3RJWG01k3T4lAFDrCtG8t81dhtruVt1JDbxOf g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96728966"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96728966"
Received: from mail-tycjpn01lp2174.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.174])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:06:56 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxYszY7d4i1H9QaFeCpZfcWYSGjDXfoJmdObaZ+Hm+4/ZxFwfUVlpFqhAeP3eFw4NsC0DpJqDFzU+UCWbCIvGbuTiMhGso51QqUf33Jm5H2zZOXBs+Q2fEk88/fTXz5JOky/lsTLgXrtdNMBomSWt835k4QWLzHKsfbPGcPhV8TitIcJXzMCFMYLB7OosFM5yH31thKp1yfkgJzNXcwTLue3RSXLT+RtRW8Hfq0QJcL+NPFLquCnirxurscaWV1EmlvI5IVUy7KN15LLrpvEbOwSf5IwW0h/srTfkgBZqJdf2POb0wF1UvrmtquVmfcw5fvPs7jJ605sk67/6QoNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkPxETOn+lis7VnwCTRyyk48+sP1HbvffBrH6ltEj0U=;
 b=McW+l58TDrE9qMl2DqjK/v4X6+KUuh+CMwJquqPP6aPU1g8IhzXsCVAKBKUkQZ7jefy/I9pCQv8MWEf8Q+KkfCXCtifXDrav93PYp5gZPNDnxaA3nCrb8C3T40HCTjFv+i3ABJxaGcLxz3GC5Ekd0xLGHP7J1yEcIbCfp7sNdzxjbIghvccO6CETNdf2JAgxUVelurbmBzWWrxqgG0bb4cNuwQSt1K2JqTGCiIg+216QbLC/9SYCJm+lWST7pqkLMbXB57XNIHuX2CDu76XT42GnAW/gz7R1mErwjbQMXfPw58E/uEgxp3I+9W2L8KonQBVSqmRnULwHCSHXeNPtyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB8744.jpnprd01.prod.outlook.com (2603:1096:400:16e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:06:54 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:06:53 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 47/52] migration/rdma: Don't report received completion
 events as error
Thread-Topic: [PATCH 47/52] migration/rdma: Don't report received completion
 events as error
Thread-Index: AQHZ6j6FwFWX+JMt8UOQk7XF2zb9ZrAsqsuA
Date: Tue, 26 Sep 2023 06:06:52 +0000
Message-ID: <5fcfb8b6-8d74-3142-ed52-801da5a20437@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-48-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-48-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB8744:EE_
x-ms-office365-filtering-correlation-id: 01e14997-3b3c-4202-41c1-08dbbe56c7a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vdDz/B5UUr8LEDf7YjkJkZosAHLGz+uwsD136YRzdOYSgycaxh7WNrO4LfH4ns7jxW5bYLB7ev9IH7N24iZDNLlZWFAO2vZPrj/yATdPdOlDa9wDwB/TMQA43Qe0j/ANuLIwsfPI4mpHrTsfmwIDb6lZLcqOvAwZpFGsstj5b5BFL+HIGhPyy8bFtROcbNELMNkMwOrQDqEj1nBSF7cg75g55ne5RLaH5fjl5la6c05REtLWHprQtnT8qTh929TRPgB8V6PX/FJI5ol1vEIflVxdJz3Ge0hutNq6cHBpLYRyV39Vdj8fC/Ti59Sn6MVu3MxI2mBvzY9Ro3dPFXsglOwZLTo4gsBGst6Ly1kOy/mLODcCvG6aJa4bSLISh2LY6qPer7PgQSqlKk4oOZzlyWvECkgbeTS1tc2oap+r1a5xd93LtQ5CZs0LkmoyEiQEm+GIIWcPwakvgdfzz1Eeftx+OQBPazFPOiVGLzEsLI9PGOu6qa91XT5PKgSpETzEWiyXh5D7bgBWYRKy9wbtM66cYqd6fUrszBzOEAOC3WbK2f7q42N9vgsvDwtH4LYGNkjXwiFTxRmul16Vh67nECk2EgLALv+R5APwFBZNrCqeiCtgZONTRpV0bfexirqSwoOlex6F9zCHpJK99Ae7CGABJc3185pZJKqJSZmax2TbpXOrYkSa12KLH3COWSFV4hw8CKOl/CScJGhRe0tCkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(1800799009)(1590799021)(186009)(31686004)(1580799018)(5660300002)(54906003)(83380400001)(2906002)(316002)(41300700001)(8936002)(8676002)(36756003)(4326008)(2616005)(85182001)(64756008)(76116006)(66476007)(66556008)(66946007)(66446008)(31696002)(53546011)(6486002)(91956017)(110136005)(6512007)(6506007)(82960400001)(86362001)(71200400001)(26005)(122000001)(38100700002)(478600001)(38070700005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHc5UStFUm1YTTJZRElSL3NIVEs0MXVoQzd2U21kQmViOEFpUGFvYlBuMjhj?=
 =?utf-8?B?K3FjUG5tWG9Gbk5XTHlYTXZPSk5BYUtuMUVTSlMvRTUvb0U4NnFaekNTSlhu?=
 =?utf-8?B?NjJSaEJHd3ZxWlREVGUxL0xBNVBic2l4TnRpenNCM0drT3l1Y0hwMWhtOVRt?=
 =?utf-8?B?OGdTSGNVRWRqOUJBZjZaNVh6NnZ6MForeXNncjJoSlpmckU1SjR0dGR6a2dC?=
 =?utf-8?B?V2VCUXZteHlrUEgzQ21wQkRWSzNnQlFGUms4WTBPOWFNeGhyUEUva0R4QmZr?=
 =?utf-8?B?ZHppVDVaeFgvT1NRVVNjeDh6QTRiTHpOeCtBYndMYVN4S3NnTGlacDhuTitp?=
 =?utf-8?B?bEFQcHJiU04wU2JWOFZJYXJ4Ulh0V0VydisrbXhRbkljaTE2WkJEOTBIRCtC?=
 =?utf-8?B?bU5HYjBJNnh6cm9ocGwwMEl6WWVRK3BkWGo0N3pSTUFuMmJzNXAvZmxhVGR2?=
 =?utf-8?B?d2t4dEV4T0JWMmhrNTJZS1FXS2RpZnJkenB2d05IWXNHMCtST2R1a3B5Rkcw?=
 =?utf-8?B?bUs0VnNjS1llQUZ4YXBINGNGRVljU3BNQy9EMXlIVjl5c2h0S2hZYm9FUTVO?=
 =?utf-8?B?ME5KcWFCNzZiKzgxS2xoVHZ2T0xCQ214bDh6MzhudTU5ZnNRL2g5Qjk0QlFx?=
 =?utf-8?B?ZUszUC9RVFZUVE5meW9MUzZZWHZ3aU11SitaOHFBZDY5cnhJK2t0N3ptNHVT?=
 =?utf-8?B?R3o4VEJiSEo5WEVZL1BJYmtVdC9mN00xSVNsNGhpVy9YRDNiaDBFY1VkRngw?=
 =?utf-8?B?azZmcXNZWEl1NEsyUnNzVFVaMTV2RThJbnlyLzBnRHhHWWhLZzhDVVNWWEhH?=
 =?utf-8?B?eGVpMXB3amFGNkRYL3pPUWN1SHBIZXdJRi9SMEs3SWhZbldXQzNiN1FBV2ls?=
 =?utf-8?B?TlNaT0RmSm16WjVQZG81blV2NndyZjd3ajFrcVJROVVwU3NiSGE1S1BOdmM0?=
 =?utf-8?B?bTZUeUhCZG45bDBIaElHcHBsQmZtZmVNSGZxMGxuL2c2c1B6UW82cE1PVFQ0?=
 =?utf-8?B?OU0rSXN5ZmFwR2w3dUZIY0lSMDloZlByR2FNNmRTbXhUUkdpZ21kVm94aFh6?=
 =?utf-8?B?SDZGUkQvNWI5UjJjdzFRNFUvMTVaYzk1YjBINC81QzE0VVZYbFZydmx1N2N5?=
 =?utf-8?B?YlNyZzhmb0V6OERLSzNZK2F0cVZEVFRrckRtTmF3c2IwTDBhRVBLcjBjY2Ux?=
 =?utf-8?B?RklVbmlaNnVjZnJJS2Z3NHd5VE94aTNxUnVlSHBzQS9OTGVBbmRlWG01ZXdV?=
 =?utf-8?B?Z3hZNjZIUXFLVzBzRHYzZXpBWjFKQ1dGZkswME84ZFNkL0JKV2swYzFOVlBq?=
 =?utf-8?B?MFU2Y1BGV1k3NTEvaXB2L0dmQlVTY05YQ3MySFZReHFhS1JKbTl1dklGdXIr?=
 =?utf-8?B?dTVjQk1PdTFORUowTlNFOHpWYS9qc3dDTnZwVHZyem01d1lMRmJTdUowNy9x?=
 =?utf-8?B?V09NSm5LMU5MVzBXZ2lteDRXZFIyWVRSdzRvZ2ZoTXUxYTRZMjd3WXZickhv?=
 =?utf-8?B?MklSMFRsUXVKQ1JLUU0vYzE3UGZWOHVPREwvOFlkZFNDbkRmM3pxQjZ4NVpK?=
 =?utf-8?B?ZlljSnJ1YUM5WDUzc1VQNGphdVg1NTZ3c3dpT2ZGcmpoUmRQMVE4ajNBWE44?=
 =?utf-8?B?Q3A3aUhmam1iY0lIOGhqZnpGNEV5OUtXQklTVlViK2hjbjJVdWFsQjRVVEFq?=
 =?utf-8?B?TzhOQ09aREdxeUZRTHYzRW1XZkkwZVIvY1pObDU5c3FTS05ZdzNseitHajkx?=
 =?utf-8?B?cklNdXJPRVg4RGVKZGh2OVhBKzZDc3BJd1dTSlVZVDV2d2pEWEdEd3pGVU9T?=
 =?utf-8?B?WEdub2EydmJJRC93TTJ3T0ZvUlR1NnNiT0JkV3pLbmFDcml1c0Q4SVJESEVY?=
 =?utf-8?B?Q0MvOE9Wbi9rcTZPUXRoeFVPR3lRV01HNjlsUFhVaStZUThBN1RrSFFGN0JK?=
 =?utf-8?B?K21ucFhBMkRDd2VtT0lsdHF6Rk5jTlNXV1JkaE1IVG1FVjc1V3VSRDV3MVRC?=
 =?utf-8?B?cnVsMXFiYTB2a1YwTjVWL2lINzloY3FJc3NBL2FwL2VvbkdGZ0hDQXNrTzg1?=
 =?utf-8?B?NWRZUzhFNDVseTdzeC9xYkg1UHBoRzFEejVsYVgxV3dWL3E2SVZ6ZzE4d05y?=
 =?utf-8?B?anY1U0NCbTBMZDVGZkRmSE1NdWlrckdOVlFDTCt2Umd6QW4xSWovYjZHSmFu?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7554C2D586791644A7EB505C81385DA3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: A1jrIDDn5bE5t10xG6LFwRzqBsrYfOaODUdKKeJpaHVwxsl01vmJu4R56NNwb0MYuW2Qq+VzMNiG6bNgtjvlcXtj5wefK9wZucLqs0MskPIw4QFjtNT2Nt6Z1YvfTgdhWnfDqNx+1Cw05BTETUdCCzJFzGzQCedjxWd9gaJr4lJZ1bG0eTarmKlWddnGO+QvJnksIyYUQ4ZGw7WdUko/Y4MAdX2QS5XkRja3ylhCSAPl1dYCiHjSuIYkbCipYVw/q3I/JsTw/pOaC0n5QrVzXPKqIyIqk8953mMxiXrmw0MgeZCZksoI4ucV3H8mM+GjQ9E3coj0kQjs7G1G+RNJoSMInVJwPRH8MykHnN/3hVedBkF9YTsPdc6eC0dqUCCDRFiv4u6PQsiWEw0ugwvwolnd3i5h7lGdUhrWZKnw8Bjb6ffZYH4gsBZrtZh/IWiCtDZQlDW3qRrAX5o83aF3MCPQNMiyTYoozuZm2PpKKhvcjoig+WwCcFh8ydq6Ezqflm+M7bggixMQQ7+dvaYiV7mXEb9GigCOuXBa081olzkaK0gotMbsQskC7QTMsMD7ptS4n65GuOR7bGSodWLnMKnEaYlhQBGgHjQFeIFp4BzRcffkUZ+Rq3qxhdauaO4GZA6gp5sQ/Fm4n9kN+bYQPYIohHAzT/UI8fyRCRxUVl0BTjFxnP63Lkt6EgCokxLvUtj8BSLGSq63IGy5EbmJoKx6dg/CVnKqgk3XotUC5xHTP9ToOXhdh8vqROy71uPv10MZ78f3D0bFHBLEaCteV6ju1Dk7Q+EcGJd7R1/K0cI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e14997-3b3c-4202-41c1-08dbbe56c7a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:06:52.8952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m3TZXzwlfYcthqoJfpBTaqtvKFFO4K0HxLfv/e/q3D34eraZf6jrBdXLy+IgHmNhd9KjhCh6+KuSF5iIUwsfCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8744
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBXaGVu
IHFlbXVfcmRtYV93YWl0X2NvbXBfY2hhbm5lbCgpIHJlY2VpdmVzIGFuIGV2ZW50IGZyb20gdGhl
DQo+IGNvbXBsZXRpb24gY2hhbm5lbCwgaXQgcmVwb3J0cyBhbiBlcnJvciAicmVjZWl2ZSBjbSBl
dmVudCB3aGlsZSB3YWl0DQo+IGNvbXAgY2hhbm5lbCxjbSBldmVudCBpcyBUIiwgd2hlcmUgVCBp
cyB0aGUgbnVtZXJpYyBldmVudCB0eXBlLg0KPiBIb3dldmVyLCB0aGUgZnVuY3Rpb24gZmFpbHMg
b25seSB3aGVuIFQgaXMgYSBkaXNjb25uZWN0IG9yIGRldmljZQ0KPiByZW1vdmFsLiAgRXZlbnRz
IG90aGVyIHRoYW4gdGhlc2UgdHdvIGFyZSBub3QgYWN0dWFsbHkgYW4gZXJyb3IsIGFuZA0KPiBy
ZXBvcnRpbmcgdGhlbSBhcyBhbiBlcnJvciBpcyB3cm9uZy4gIElmIHdlIG5lZWQgdG8gcmVwb3J0
IHRoZW0gdG8gdGhlDQo+IHVzZXIsIHdlIHNob3VsZCB1c2Ugc29tZXRoaW5nIGVsc2UsIGFuZCB3
aGF0IHRvIHVzZSBkZXBlbmRzIG9uIHdoeSB3ZQ0KPiBuZWVkIHRvIHJlcG9ydCB0aGVtIHRvIHRo
ZSB1c2VyLg0KPiANCj4gRm9yIG5vdywgcmVwb3J0IHRoaXMgZXJyb3Igb25seSB3aGVuIHRoZSBm
dW5jdGlvbiBhY3R1YWxseSBmYWlscy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1i
cnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCg0KDQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCA0
ICsrLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5j
DQo+IGluZGV4IDI5YWQ4YWU4MzIuLmNiZjVlNmI5YTggMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlv
bi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtMTU2NiwxMSArMTU2Niwx
MSBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV93YWl0X2NvbXBfY2hhbm5lbChSRE1BQ29udGV4dCAq
cmRtYSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gLTE7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICB9DQo+ICAgDQo+IC0gICAgICAgICAgICAgICAgICAgIGVycm9yX3JlcG9y
dCgicmVjZWl2ZSBjbSBldmVudCB3aGlsZSB3YWl0IGNvbXAgY2hhbm5lbCwiDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAiY20gZXZlbnQgaXMgJWQiLCBjbV9ldmVudC0+ZXZl
bnQpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgaWYgKGNtX2V2ZW50LT5ldmVudCA9PSBSRE1B
X0NNX0VWRU5UX0RJU0NPTk5FQ1RFRCB8fA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGNt
X2V2ZW50LT5ldmVudCA9PSBSRE1BX0NNX0VWRU5UX0RFVklDRV9SRU1PVkFMKSB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmRtYV9hY2tfY21fZXZlbnQoY21fZXZlbnQpOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJyZWNlaXZlIGNtIGV2ZW50IHdoaWxl
IHdhaXQgY29tcCBjaGFubmVsLCINCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAiY20gZXZlbnQgaXMgJWQiLCBjbV9ldmVudC0+ZXZlbnQpOw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAg
ICAgICAgICAgICAgICAgICAgIHJkbWFfYWNrX2NtX2V2ZW50KGNtX2V2ZW50KTs=

