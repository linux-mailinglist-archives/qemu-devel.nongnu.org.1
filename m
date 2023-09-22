Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A17AAD7F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcBJ-00061v-5N; Fri, 22 Sep 2023 05:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjcBH-000611-0R
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:10:35 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjcBF-0007Ce-4s
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695373833; x=1726909833;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QZ7ypwLMbsrY/C0dpeUccpDRuAzaL03XbxhZMaRVAt8=;
 b=lGLeWtW8DDCtG2dcaN3WFVx2v9Op7VPzU+IPyV4lMNfzwwXJ3NbzXIUc
 9OeMHuaOp88TaUsPMgUGNMyeZI/qdB0pRnQKO+lg72OSyIRtGBfCGmQN8
 E+YZ+rzwGH0agpKzRRK8ubOiOT3H7pp7B1qYPs80O2R58I41xHOhGEV8k
 vEsA9gZPth6qYLJENLtVscaRAAaGAsQC/3ymWqK3h6323uH2tTPkyhTuk
 gvGhPuKALukJrio7WA1NORC9X1sDAtw2lM/YkFD69DoTv5fSs2yptdpvQ
 /N2VW2uqxo+fRkQu/KOhpB+GtniV3xuPI2V2ktUjD27GgTl00w06B4xJM Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="95846024"
X-IronPort-AV: E=Sophos;i="6.03,167,1694703600"; d="scan'208";a="95846024"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2023 18:10:26 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7OsyolylUXGOXP+VmyD7rTAAoq3XEpcy8hJUJYzFcfg8+l1IFzj3OlhL14ZAn3/kKolSZI1ciho96O03RrhUZmfYzLBG058z5MBR2Aos9GH3WOoUI6tIuQgk+W2fYubWJZce+RqTWzAkvnbxcVI1X4oK/bGrQUcB5dSZuW4QfKRfFRJRJOWJeToHmPf8l+beZpvYLREdp3x9TyuSog+CGzNiH1St6Xf+FkG6VD4DGwS2LNON54gTPnTNzuu42W6yEYlfzc5W6Rlziq722j+ZBP4BKQA/xAY9ZWNokzNAhzyGbFS04adJhs5JF/qmy0DV2Q0Z2+AbKewYoo8Zpc8Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZ7ypwLMbsrY/C0dpeUccpDRuAzaL03XbxhZMaRVAt8=;
 b=YSczTeA0o1N/YH2TL7LYJJ0hyqkxp1zv40d6vdMTP4CYUYMvQsR9tKUANblpEjDPfxlu/fCK8TqUgxkjyDrSbzx5S2dw8gZPK0+MFJ4Icdgu2lCCJn+vJzN+1lhGTvBvWbzh1qRllTWxxP2HzBAQMowUAsIt/QMuEanQtg5PszlyAY4aJGj57/Wh+rNTrQE5BIfkCoisjd0R8VDYN1zuFia7oWKbcM7/c52z0HeoqvMo9hh/E5mux4DQrLrZ0wfzPX07Mst1OosDNXoQyD4kNOXza/hiN4959XIu2APRhzC9iDQHH4WPAxNbb/WSQTyV/fbwYtbC3muueaH90OmS2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB8585.jpnprd01.prod.outlook.com (2603:1096:604:19e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 09:10:22 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 09:10:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 18/52] migration/rdma: Fix qemu_rdma_broken_ipv6_kernel()
 to set error
Thread-Topic: [PATCH 18/52] migration/rdma: Fix qemu_rdma_broken_ipv6_kernel()
 to set error
Thread-Index: AQHZ6j9fIiyNvNhpzEe37/v4Kmxaj7AmlLqA
Date: Fri, 22 Sep 2023 09:10:22 +0000
Message-ID: <2231cc14-d69a-01b4-13b7-8f580c014f89@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-19-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-19-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB8585:EE_
x-ms-office365-filtering-correlation-id: 9f32bc36-7a80-4cd5-0503-08dbbb4bc03c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NIcpHUK69v8jtsVc45XzmwUo5KYTx3TQQp4vCz5mP3SqrGzFGwXgcHwOjdc37PrqNhC5tScCQDA+ahxNZssCsUXxr/fahzouwnd5ML9SYNjb3BrLPwdl+tj5y2OHOMmLS1HYZe+N8rsbZcVm6b8Rjjfv8U6KNFGYaWna2WhCiWnx9V3gW/QXWigkoY6BEAkoBy+ufGYCPelR+/X0DmaZqV2VbxL3v0s/o4Jp9SniaswG+BCafXQYwQ+UPqaYtcN0P5jReubYyGwiuMnne1rjFg3vBnv0TuMv9bbKEy7Y8zfQDrHzqjYMIT678elB/c1BO8ob+Bwlg2Stw1SitEWWYGC8Wnc+i0hP/yo1FjzY78XnHFVeZGTFLcpU7xFmnAobHdhP9/bsaELwwgOirWh87wcVIOEfrwRwenjdGxqQH/BjQPaDBqat8WLjQVZT0UXnI3ZVbAGlOZIHBmOwh8+M9VxmvW+GBdHSv1ebiHyZil8gfW21PPjsUhMrdYLAU6QlKgxT1YgMigNZqZL38obIpcCDvaA/Q1QbxEZo4k7AGyNOPo4YorzdaMUdgf1HTfepK1loi7a1mRwTypcfiOwPxwUmG7X+ANHCzUv6C3Fm6TO+kd8IutWQ8tiVLUWr3iHaPmTUlwpktxvYJMPKRQG/fN2YaeeLgid9MctFfc6Vw2dDXhdoXNgh1PozqpkLy6+JZ3+GxMHQhq9pq18bGyxy7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(1590799021)(1800799009)(186009)(451199024)(2906002)(4326008)(41300700001)(8936002)(91956017)(66946007)(110136005)(316002)(66476007)(66556008)(66446008)(54906003)(8676002)(64756008)(76116006)(5660300002)(1580799018)(31696002)(26005)(2616005)(53546011)(86362001)(31686004)(122000001)(38070700005)(38100700002)(36756003)(85182001)(6486002)(6512007)(6506007)(82960400001)(478600001)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amowYTRxRXNHdk5lQllka2VKV29HYkM0dWJTaHVCTnJmNzNNaHJ0Zm8xY2l0?=
 =?utf-8?B?UFA1NUJaaTJIYmVEVHlZQmFFNk5jUVlwMzIva0NETUMwTVV3NHlsR21qQWVs?=
 =?utf-8?B?alRYWC9uZ2FLZGgvTUlDWXE0VSsyVUpKK0pnelh3dzRwc3dOOU5NeUl5WlB3?=
 =?utf-8?B?blJsOWFDMXhlamc2UGFPUGhjbUVleEhUZGN0K2YyV2l1a0lFMkhVWjJIdjBn?=
 =?utf-8?B?Z0JvU1dESUY0eFZsMzJPYXNDT0VWVVF5cFhUQ0VvblB1cTA5MDFucHFqVkxL?=
 =?utf-8?B?eVNYbk1UNHpwV3ZhM0JVL3JHeDF3M3BFalM3NlU0NWZacTRMUS9xeGZ6WTNP?=
 =?utf-8?B?cGhseU10Y1IxQmhLMmUwd2xvZVp4S0ZNcmZBWHViU2VJdDEvaEtGRU5KcUYw?=
 =?utf-8?B?SVV3UFRNUVRaWUxJV2lzTDhrMkc1WGFmemJIQllsWm5LemRhWGh4MUNrMDh4?=
 =?utf-8?B?bTE4d2ZVa0FsL05wbjEwWm12UjE1cU1UYTMxOTZuTlVhVTczRTQyRlFCS3p2?=
 =?utf-8?B?Q1V2aDl1aHZCMUNPdWhwREJIQklNZ3FGT2dmbGdHMVhhb3BTMVd3ZmFxN1cz?=
 =?utf-8?B?Ky9TQUdFRnBJT290V2dXeG9GcFNtSXk2cVlpeDhMekhtNkpJSFJnV0R4UWNz?=
 =?utf-8?B?L0NkTnB5ZDc4c2d6MHpEcmpCdTFtdE5QNTlSbC9oVVBRTHozYVJQVTFSN1B5?=
 =?utf-8?B?R3lMZ3lOblNtQlhWMTcrVVRLWEEyUS9ZeXpEUU5Eb1M3djFkSmZLb1krWGNn?=
 =?utf-8?B?UWhjZ1drQ252dmluKzVnMUQxckFMajVFb25RMCtTTXdFYkJQUW44d0t3ME5s?=
 =?utf-8?B?OHppM0E2Z0JuV2JhMDNKNGEwZzhQemZOSmlibDZ1amM4ZTVmaUNMZ3N4aTdK?=
 =?utf-8?B?bnc3K24rYzFNTW5xeEZFZ1hTcUR1WkY5Zyt4Wjc5QU1BZ3pJM0YwMFA3bklX?=
 =?utf-8?B?UWxwbkdwTFZYaWxvV25sZzlBUk9HakZXSVdFT29qb2hMcGJQSzI4Ri95NWNs?=
 =?utf-8?B?SUFoM0Fkd0dlZGNvbUp3TVNSQXM5TmRsQXYvUmFEQkg3THdHdG4ycnl4Y1BO?=
 =?utf-8?B?R3B2eDB5elJlZVJvZEY5anZsTDh4cEFrV21sVnRBcFMwRVVmNlJRUGlrREtr?=
 =?utf-8?B?T2RLN3FLVm03cGhMV1BFYUcwZHU3Z3lsS0ZYVVdtc1BoN1gyNzdOTDdUZEky?=
 =?utf-8?B?TWlIT3V1cTVLVVE5YmVKUmVLNVUrSU1IOWY0Z21oQ1VTZ2NCMWpTdENDL3Nq?=
 =?utf-8?B?UGJhbGVHaG4yZ2xFNzdNN3JFWjhlbDBMdWxydEJ4MUgyM21NaGhJWnhMRHpN?=
 =?utf-8?B?bzhZRmN0RUFxUGZsUHRJOXFpWUxJZVhIY1dSNGZwK3BiREJRcHZOZW5iUWpB?=
 =?utf-8?B?REtuT1FEb1ErQUoxSkdqRUlvcnVXQndyOGY4S2tPR2RwcnVPMTlBQTFUYUkr?=
 =?utf-8?B?cTEyK2szdyszbnBFODJ5YTY2S3ptRS9JTmEvNEphTFNTZllFZjlVRnBXa1Jx?=
 =?utf-8?B?SG15V3htbHRmWUJUbXJ1WUFGT1FrZW0xWkdpdkpXdXdjNHhtUzd0a1RDNDY4?=
 =?utf-8?B?OU9Ib2dtczJHNXBzd3RXQ0tacE8raGY5Yk5vOGczMjR1QmtzcXgzelFKS2xD?=
 =?utf-8?B?Z01pemU0QnlmODc5YU5CRmF4ZTVhVi90U3FTVkNMYUdzMy8rN2pCZE9YeUtp?=
 =?utf-8?B?d0w4bHJKd29HUjhpT2dtSCtQMnlJb0dOcXpEdHVXNU9LOVgrUXFTZVNYNU82?=
 =?utf-8?B?Nmw3dHhMVzhsejhPdmdFMEpsMU1xK0dBWE9sbEhTeU5kdDUzSG01SVYyQnA4?=
 =?utf-8?B?WlJKN3FmNm9tdmcrSzE0eEEzWUtrbklSaDVJcm9McXRpQWNySzh4eDdrMVZu?=
 =?utf-8?B?MDhlVnYwYTRoajFIQWEyVm1EMnBuWTI3SGgxRitFWHFoSGExT05heE01VnBX?=
 =?utf-8?B?eThXQnlqK2VrTUVkdEd0YlRKeURzeG5EZCtxNmRBa0VLOW1MRlFXODFMQkVN?=
 =?utf-8?B?UDgwaVhWRjNocmordzFVVVZveFJoWER5MXZTcEVVNUQyVm1RK01xalZCU2kw?=
 =?utf-8?B?R0FQQXhlcGtQMDhMY1FMUmdxZmRkRFRodWJLODRZR1dZZGpzNVJHaE1HVUFB?=
 =?utf-8?B?cmdQWGg1WnJiWVdOajZXaEZsc2xLK3d5Ykh5aldteGFKa2YwdjFwU3QxV2ZU?=
 =?utf-8?B?VWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8272A8F8C4F8664ABA93EA468CEEFCCB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5W1hvAigsfkKslNscREvyvZkj/YPca2VxPU9i6LtHrWVg/l1dKFGs0j9n+bKmFeJYWcvssqua+W/bo/xzcKaf2jzs69O2oOrvHdR9lhm/PrtfnJUkjwbdciaI5xDfObSSUCRN19rmvUmRiIJnkLyJjFc+8WkAZcF+rtAkMuFiZkxzQkS8gev/jDeqWuiKk5YfvosNdfhP/YdBZ/Wvve/kiqCEDnkXMd74n0X8aPJd6Sd3clpxtqPr8XUkjh4clfGUGqghKEF+mkpAwb1OjLmoXqKNXFtFR3vh9DOGEioPBooLdk5cEIyq2JQ9Xdm/N7/vI6cSRYyh78ppKQz5lzscvfBUW9YHp7lOGYELFb+hY+9CMkU9fAVjH4zBLs+DV7EKgkaDSVlBUsFjdIWaiAVzTcGZSMogatSz0Lxcg5k3ba+QxYduwy72/SWA3+M481zo4tJKDkiYSXXjHwmunKM99scd4AOOcKFUVOboqH1/7N2PnO6bNQYsVNY2yFDwsNRL40x5Rhl4Cfaj2BMIGezbBFZZZlHOhQGeur9nHDqJ3l0VbLUN9ASziuC7hn3uGRFQuNZf7ZChzdM10g3gRVu6zGMVYBnU8zN+4gz7ozKYMD3GQlmsEKsPWzcQY7MGXCMJ78C2T69V1FaddDEf8b1p3pB073M0j7kRNxKFEhSox/eRZ8mXluwQgZ8aK0ll3g+DVSMBalE/8ffhyH5/zHjw5BGoPylxVsnzc+BgXUNK0DxirHRo6MvQEXCVoBWuvIKkXVS88Z39ff3qWwj6Z00GWQUgh9K6trNkTO6ALfMX/8=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f32bc36-7a80-4cd5-0503-08dbbb4bc03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 09:10:22.4774 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 007g6rUwRGOIz8QaWK+2XMNPWsZlYkqLF5Ufh0ZZqNMBixjPi2u8zbks9hfRi2+hfPf6HqyMF2ssrXeIdECpMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8585
Received-SPF: pass client-ip=68.232.156.96; envelope-from=lizhijian@fujitsu.com;
 helo=esa13.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfcmVzb2x2ZV9ob3N0KCkgYW5kIHFlbXVfcmRtYV9kZXN0X2luaXQoKSB0cnkgYWRkcmVz
c2VzIHVudGlsDQo+IHRoZXkgZmluZCBvbiB0aGF0IHdvcmtzLiAgSWYgbm9uZSB3b3JrcywgdGhl
eSByZXR1cm4gdGhlIGZpcnN0IEVycm9yDQo+IHNldCBieSBxZW11X3JkbWFfYnJva2VuX2lwdjZf
a2VybmVsKCksIG9yIGVsc2UgcmV0dXJuIGEgZ2VuZXJpYyBvbmUuDQo+IA0KPiBxZW11X3JkbWFf
YnJva2VuX2lwdjZfa2VybmVsKCkgbmVnbGVjdHMgdG8gc2V0IGFuIEVycm9yIHdoZW4NCj4gaWJ2
X29wZW5fZGV2aWNlKCkgZmFpbHMuICBJZiBhIGxhdGVyIGFkZHJlc3MgZmFpbHMgZGlmZmVyZW50
bHksIHdlIHVzZQ0KPiB0aGF0IEVycm9yIGluc3RlYWQsIG9yIGVsc2UgdGhlIGdlbmVyaWMgb25l
LiAgSGFybWxlc3MgZW5vdWdoLCBidXQNCj4gbmVlZHMgZml4aW5nIGFsbCB0aGUgc2FtZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4N
Cg0KV293Li4uIElQVjYgKyBSRE1BLCBpIGhhdmUgbmV2ZXIgdXNlZCBpdCwgdGhvdWdoDQoNClJl
dmlld2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KDQo+IC0t
LQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRp
b24vcmRtYS5jDQo+IGluZGV4IGJlNjZmNTM0ODkuLjA4Y2QxODYzODUgMTAwNjQ0DQo+IC0tLSBh
L21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtODU1LDYg
Kzg1NSw4IEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX2Jyb2tlbl9pcHY2X2tlcm5lbChzdHJ1Y3Qg
aWJ2X2NvbnRleHQgKnZlcmJzLCBFcnJvciAqKmVycnApDQo+ICAgICAgICAgICAgICAgICAgIGlm
IChlcnJubyA9PSBFUEVSTSkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+
ICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgICAgICAgIGVycm9y
X3NldGdfZXJybm8oZXJycCwgZXJybm8sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgImNvdWxkIG5vdCBvcGVuIFJETUEgZGV2aWNlIGNvbnRleHQiKTsNCj4gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPiAgICAgICAgICAgICAgICAgICB9DQo+
ICAgICAgICAgICAgICAgfQ==

