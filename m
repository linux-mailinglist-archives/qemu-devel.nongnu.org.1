Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8927A92F2
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:08:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFfJ-0005UP-3R; Thu, 21 Sep 2023 05:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFfH-0005Tl-2Q
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:08:03 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFfF-0007uE-6b
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695287281; x=1726823281;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=k5gZKZXFFi+mZSiXjV6Yespxxc5xOrxveiITlFUV8Vk=;
 b=yYLYmW0rWus7jAx+1iRce1l0VskuwyfWurhSLZQu0KNGHWJeo0+fpCiM
 Z5btyIWE6Tzgtnr1EKp3HKFcrkJfRb+pYWiVPKi3NZcw8PeuPFdwA6VFG
 1p8uw1d52Sp5Uuq3A6tb6iekD/xI6CyB3B1C5bwZ+M9+iVdWrk+IemMMj
 9Hs4uQVxZTSRx+oKYx84XmfI5QFsWfbuBeneYEmNxbt8lurCOZE0Xz6OD
 Yi8sYY6YH3luzgxU5UfQx53VSQagrpYPhlfpsxZQJC5yuR8F+CDvU9El1
 r828nLsIBz/nfhEvqFKlq/S/xvLcx32bBRyw8dhuPnZyyNCE4sPojmZPY A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="7072052"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; 
   d="scan'208";a="7072052"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 18:07:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IP/xdLfzw5D2W7q9SlHyyU83yli+pktnonI7IbmV3Pgd8END2pVV1wojzGhDhv6j5s29WjGm4PAmrexFknFIurLMsbUdqI/RqR0MByNzkKlrQQkAfM4IUeD2bvtoA+fpJTjYgis4itzVJ8AVbmHvWc7bZibfwwr0VUssTbKfeSP6cNjY/f3joYTqS+QR2cW9Rt3xJfaOfHSUA0u7nVGMU/Rj5p5cNyIYr/uGGJPfDdBVwmq1k7JdlJCuN/pokitmMEy7dL+4PVRfljQtPFZZ6CKYrKAv6uzM3KVlF6IWoBB9bfhW4YmUyhM+HdL5qRvq/ZLXGJvsMYA+xVfosbXrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5gZKZXFFi+mZSiXjV6Yespxxc5xOrxveiITlFUV8Vk=;
 b=E9OXZ9HcjkXVeU0NnSg48Q8x2YyjJy7pT8Qxz2yNGu4fVI773ya3TMMECmZq66vfPZdQMlsw/QRA6VopAMiIb7lItE7D42vfDzY2nNv82+e/IsSbi7DkmGX8Em0WONfHT2mMMn+4gq3CAD04EfpMdhwuhxzjS9rg+KmvBk3z5wQqVTITxiv3jDkz+rn3nOQ+8s86Jk/HUyZDRdJuw8IoYQ7wqVaqyGu2/wzYe3FN7FTuL4yK5UfL+rSVUc6Ao1WlqXKa5ktw9KhVbLb3NeH8ulmVQnvxI2KWJE8UY52tvVzms27KdsVrXHYncUZig6rvsbf5TbKEZthtImlFBoZ36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB9830.jpnprd01.prod.outlook.com (2603:1096:400:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:07:50 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 09:07:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 08/52] migration/rdma: Fix qemu_rdma_accept() to return
 failure on errors
Thread-Topic: [PATCH 08/52] migration/rdma: Fix qemu_rdma_accept() to return
 failure on errors
Thread-Index: AQHZ6j/Go+eKdcM+TkqdSWI+XCEPzbAlAa4A
Date: Thu, 21 Sep 2023 09:07:50 +0000
Message-ID: <3ff28a57-4aa7-2541-23ca-28d2acb36cc4@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-9-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-9-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB9830:EE_
x-ms-office365-filtering-correlation-id: e835c15a-ae70-45b3-4ff6-08dbba823af4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOeTPjeQQQ1tXEsGGDC0K8ugRDZ8dF+5tHVMHM6nM/KtogUMUEsqGzu96z1w2i/neWOyVZlC67QoZk2AHyQUaLp43KqEvBTcdWm1eVF+h87/1UXmfLR7YO8Fd1vZAa9liIA/yliIoCzqwK3jeuDDueujxrGkvffU3qOnPj88m6gG71J/RqHN1MHZNuVokqEitlrc/7ve4p3VQ+wLmXriH3pBCgX4ulsyDrBLUMHiYDtAkQu+nLlRWV/bUpPgqDT4olUXToLmSkBbyU/WgqwOlRVvkX+2Q3vtyGifXA3u7FRW6TtSmCtlX5bbi+3zbLmUNxEwwkyyhjKxTy62ekb+L85wIofRRTqOZ8oqPbfRjLlUEA2fPhAhpa++7i51nD7Ex7YhOOEoofDVRGLVmMWhaWP2nRCtgMHf3L3qRh5+y6vAGPRuedXtdqe2in4xMvhw6peEAWzO5KIp/UFftFuQJZ3twA13fQLps+/zrI8ipkL0mTwm55Gozj9cuxauED3wlq4CO3nw188eiAeyCKsAod2GuZ+4F2wYRJXZQ9cJLownJXVd0gpQlYDeOcj33CBkHzBHZ87TugIbtzs7ptHUZL+JwmWKQ0GT8CerWRxLxpOyo/13Ln7Rk/OjUKVRirKDDPu9b+chGVxNw5898IA43xbdzQP1Au1DEdWeSiWiboqbOQNE3ddzkbjQuKVGCWsqhOh5iqoY576y297qSFj01g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199024)(1590799021)(1800799009)(186009)(2906002)(5660300002)(26005)(66556008)(66946007)(41300700001)(66446008)(64756008)(54906003)(316002)(91956017)(110136005)(76116006)(4744005)(66476007)(8936002)(8676002)(4326008)(31686004)(478600001)(71200400001)(6486002)(6506007)(53546011)(6512007)(1580799018)(2616005)(36756003)(85182001)(38070700005)(38100700002)(122000001)(86362001)(31696002)(82960400001)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHhvcm1VRlZhMDdadXkzeW5OVjE1SHU0d2srVFpuRzUyZGd1bG83VXMwblBs?=
 =?utf-8?B?RHdZbTVsRFd5NUZTaTZLeXc3Vzg2VDByeDB0NkhkUHFRR1cwalRIVnM0NDJT?=
 =?utf-8?B?VmgxZW40MWVETGU0M3lha1ZjWkwza2QvVXFqZ3lPM0tCYnRpd3NnS2Q0c3lv?=
 =?utf-8?B?MWxsNExpVzJPS0F3UC9WVUppWGlrSDBoZVk5dk1XZldrdkVZSjJaTmM0ekxs?=
 =?utf-8?B?dXNqMTNOMnlqVGQ2TlZsNm9BYW91ZEFkMnIyb2lWUEFOVHMxVHhDSnhFUUx4?=
 =?utf-8?B?QlMvTXdMaXJXYUtIOUtNMS9UTUprWWU4RVQvaTk4QndJQ21PdjBOV2tRM1Qz?=
 =?utf-8?B?b3ZBVlppWWJtSW5WQ3p4V2JyMHhJZHlWT2xvdXNHcEJRbXlqODF1QmV2cTFX?=
 =?utf-8?B?WVp5Y25PRUg3VmJkeXZremx3ZE1hTU1zR2prSmE4ZGtaTnJxejMzT3k0OENs?=
 =?utf-8?B?Ty9CWnlLWDlGalREU2lCQS8xZ0tVQkEvU1FSdGtIZG5PVksrL1JidnRPRG5s?=
 =?utf-8?B?Z0czekFKN0txemZLT3h1OVpWNHJERzBOaW5JWnNWeThhelhITXg5c0I5RGxZ?=
 =?utf-8?B?WGkvU1ZuRWxudUx1VjJIUFQwNUg1QlhTRDRTcjViNlJpcVNlWnd4VmI0aWhH?=
 =?utf-8?B?M3ExRm8zTzZhQ3hFalc3d3dCbTl4UTdlTC9ISHdNRm5Sa1R3V1VWWXBVcE5I?=
 =?utf-8?B?M3ZEVHBZZTVkRWR1RytrQU51b3pvUk9kMytWUVBkd0ozaFBpaFIzeHlKcEhR?=
 =?utf-8?B?KzViaVlnRG92bDBqS0JPV29KRXFnOFc1UnNCckZoaUdURzVYalpSQVVaV3VS?=
 =?utf-8?B?OU5CY09BdUtrWlRKVlI3ZE42S1czc0luOVhFSUhCUnZZa3J0aXhscjBIcFNY?=
 =?utf-8?B?WUE0RzZmMlU1NVlONzRzZGJjWVYxbjZCemR4V2hid3RoYTU2MGFOZlRlVmlD?=
 =?utf-8?B?Q1huOVdHeFQ5MDc3MHZOZy8rdjE2cmMrMGlGUGJYSUZaejhKL3FDN3EzYmNL?=
 =?utf-8?B?SjZZU29lRTFOMktsMTBLUCtiVlgrVGtkRkRrUGxIWGo1dkpLN0EzVHpETkxB?=
 =?utf-8?B?bXZ5SFpsbzJ1QStueHFvTXZGSktMZm1tYUlFSU9zNlkwUEdPUStUYm1nTUdL?=
 =?utf-8?B?VWVGMlQ0TUd2cjEwamhhYjExT0xtanJlUzNMVFovU0NZTU41N3RvWmgvaHBM?=
 =?utf-8?B?MXNDVHhUcGNFWUZYalNqL3lRaXFpQWdMdmI1b3hJeVhBL1REOHQyKy9UV3Rv?=
 =?utf-8?B?RlJMcGZ1T0l1TWg2cTg3Rys4ajF6YmVYbHVQV09PME03ZktlMXU5WnJGdXBm?=
 =?utf-8?B?QSswWmVmNG94QnpFNnJOYVltUCtHUEUrbkpSVFJHUy9BNzdxUzBvYnN1QWVv?=
 =?utf-8?B?dkNxSEE1c1RKeDl0S2dqa0xLT25wTHRVc1NVbGxxQWlNeWUrd3JiZ01td25C?=
 =?utf-8?B?VEFsVCszM3dPYkNNUWttRFE0Zk9iUWZwelg4TDhHT1hnakRjOG9VMXNZbG1W?=
 =?utf-8?B?cjlTZzJvZlN3K05zWVhPU3U0c2ltRDJuN3hpOHIrc1hpWlI4WXlOQm5mdVRa?=
 =?utf-8?B?MjdNQmRabnYvY0lxT3dYZTQ4TkJHbTN4bHZrbjNWNS9rQis4TmlzVE9laTN4?=
 =?utf-8?B?cmw2T1Y1RDRyajNFZkNDUWh1NGxacy9EaFZheElDaHc2a3NtYUQzN2hRbUp4?=
 =?utf-8?B?clZ5THRzdnV1TC9iUTNuWGxZRzIxUGJZbFh5cnlmaHVhTk9jdWhPYjMrT0o1?=
 =?utf-8?B?d1UwTjVkdnJ3NUhkY2JVM3RZdUJadm5KZ2dpWDZaaSszdFo4c1BSa3orNDl5?=
 =?utf-8?B?UFhBRVpDYjR2NXhGSlA2ZEtmcVB0eSs3aWQ5dmlKUGhOTkZiQUdTT2orWHl0?=
 =?utf-8?B?bzRGazF3UjltbHB0dmlnb0YyR1IzcndzNWJyRFRFZTZGMUxvTENidDBVNlFN?=
 =?utf-8?B?dEFiemJPV0JLWTJUUU5rKzRZWWhqeVY4cE9ZSUY3ODhHNytyLzhlYlpaU0ZV?=
 =?utf-8?B?bU9BdG1lR2Q5b1l6SGN5NzlMUElJVStnL2M1bkRjOGdaQk9DMS8zM1k0SWlS?=
 =?utf-8?B?dDZYZ1VYT25uMnUvMkM3VGRQV21UdlVEaFhPT0g4S1hGc2FZNzBWK2thOVRJ?=
 =?utf-8?B?UFd2L1FrWkFkR28rUkd6b29sQ3U5YXhlZFpNVUhMdGtKTyt5MDUzS0ZTODhL?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3FD84E506D9A064A8A2532A1DB62D144@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bOzfjueMYw7MWp974rpZrwPPjd8KhyVR84h1Td8eCu95jMPMFFK3VCmQy0Y/FQQhALnJ6C6fZTALgpJi9LOhnmKRU09/SiCOXacB3IhgYLPywdpX3TbG+gk055B0FyjGts2GVg6P7U8NOuJ3hREpwBG8+gvjdjAqcQejmHJNLZXiTi67VO2B6BHRRcxaoLpqmWw1fC3oaWX8YbRgEiN5n2cGf0FLgbjyk+Z6mLt4mh8zHYPFviMGhDDtrCix2i/dEjJ0ShZzGCKbTOCFLgPoepELrUxZe3xiLb03GIEadjspPDDuLTXppJgxiBFoi/TqvMuQliq8lyqVQREwDZdJxSg+JjcL9PsAjg+Xs//w91Vfr/az8vEmbCsPcYfdtlEUdKdMhsyLcpGNuMoSfa01DGdUMXkG9M8rLfg7jCXkZqizNNA762Wxnm9Y5iMCFm3GAm4U9j17IEu4c5vD9W/oISKn9FD4mFPTs71ZQvxj4IVNqWoSKDCnPTX7pj2/okORtNaQa+vTFOG58KbKNwnwKab+9r4gidwWiRGVMxe8cK7NA9qU9c2QgLJbYdmeHw0Cozyh8upVPMt0WsLgtQFsPLhIJzZBHgcMeD3w9yyIH0UBrf8hyOOi0mJVkXjGQN4UOq9gw6LtrDCBg26WcsB2TeT3M7s2L1GfPLbxUyFNP69BdqybsZwnhiWHdyFrxK0d9FvfbXq1LyHbof8X/Zild0Fn2k6Y6mTj+nwk4+rZg8lxPgi7TGthr/EqscJMnBH+gBO0bBkBe3X80XYyMtBFIDBMjmBX9YAdZenv1b6B804=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e835c15a-ae70-45b3-4ff6-08dbba823af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:07:50.0542 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7CSYaAazR9lsx/70KnyZkDsw87zSqeBp0Stq9WBzmfJ6U2YFJG/MO2FeC/Z0SMSTq+UGcgZicPFhX/BkXJJoMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9830
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=lizhijian@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
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
X3JkbWFfYWNjZXB0KCkgcmV0dXJucyAwIGluIHNvbWUgY2FzZXMgZXZlbiB3aGVuIGl0IGRpZG4n
dA0KPiBjb21wbGV0ZSBpdHMgam9iIGR1ZSB0byBlcnJvcnMuICBJbXBhY3QgaXMgbm90IG9idmlv
dXMuICBJIGZpZ3VyZSB0aGUNCj4gY2FsbGVyIHdpbGwgc29vbiBmYWlsIGFnYWluIHdpdGggYSBt
aXNsZWFkaW5nIGVycm9yIG1lc3NhZ2UuDQo+IA0KPiBGaXggaXQgdG8gcmV0dXJuIC0xIG9uIGFu
eSBmYWlsdXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJy
dUByZWRoYXQuY29tPg0KDQpJIG5vdGljZWQgdGhhdCByZXQgaW5pdGlhbGl6YXRpb24gaXMgYWxz
byBtZWFuaW5nbGVzcyBpbiBxZW11X3JkbWFfYWNjZXB0KCkNCg0KMzM1NCBzdGF0aWMgaW50IHFl
bXVfcmRtYV9hY2NlcHQoUkRNQUNvbnRleHQgKnJkbWEpDQozMzU1IHsNCjMzNTYgICAgIFJETUFD
YXBhYmlsaXRpZXMgY2FwOw0KMzM1NyAgICAgc3RydWN0IHJkbWFfY29ubl9wYXJhbSBjb25uX3Bh
cmFtID0gew0KMzM1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC5yZXNwb25kZXJfcmVzb3VyY2VzID0gMiwNCjMzNTkgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAucHJpdmF0ZV9kYXRhID0gJmNhcCwNCjMzNjAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAucHJpdmF0ZV9kYXRhX2xlbiA9IHNp
emVvZihjYXApLA0KMzM2MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IH07DQozMzYyICAgICBSRE1BQ29udGV4dCAqcmRtYV9yZXR1cm5fcGF0aCA9IE5VTEw7DQozMzYz
ICAgICBzdHJ1Y3QgcmRtYV9jbV9ldmVudCAqY21fZXZlbnQ7DQozMzY0ICAgICBzdHJ1Y3QgaWJ2
X2NvbnRleHQgKnZlcmJzOw0KMzM2NSAgICAgaW50IHJldCA9IC1FSU5WQUw7ICAgICA8PDw8PCBk
cm9wIGl0ID8NCjMzNjYgICAgIGludCBpZHg7DQoNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4g
PGxpemhpamlhbkBmdWppdHN1LmNvbT4=

