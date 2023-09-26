Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E68ED7AEA1A
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:13:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql53z-00058k-Cy; Tue, 26 Sep 2023 06:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql53w-00054o-5Y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:13:04 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com ([68.232.159.247])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql53t-0005DJ-QJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 06:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695723181; x=1727259181;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=L55l0k7FHvY9hm2cHtPINmMYpViEadKgFTu53b7Uktw=;
 b=c3EFTtf1myx3xgaM/Dn/JD5EVirguaGXY68oO9kHZUkp/plEHqSSsaXP
 spfM9j9Xa0MWkVs9QNMPXZsXYt6/i0zeOVWeuD/GHaei9W2oQLV61fBvi
 1op9vY6W77FKDfvmhvu9JAljroUy9RIau2+N527pO0O1vapUJwXYG3cmg
 Otsw5bLiPsyjLQ5NCuwcjKDZPFF7+RZ18RLi8W5MdhhK8WT5V7GTKTblm
 V7zu7QMN3YwxOffRm2m58/xfW9tyiY1lysaMg++w6HytkwTbcnatoJNKs
 Q0DMTs+5JW9gt4WEYqHime2qRr/DGYJHSP2tKcWewIRUz4vL9GrMuJYFY w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96900628"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96900628"
Received: from mail-tycjpn01lp2175.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.175])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 19:12:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE08n5CsVrL88pDx0gEiJvM9Vwg12TQcvXG0xVmC145xEaSgj0VkCJqx/DCXiCcJAGdZSLSYDYLnxQTRZWPShmRXbuw9ieisuCNrKIvO7XwG30Xhbi+A+CK1l31azhZ7gy0QPPEww0HNJ3Kaq4nGFqbE6byglxXtVTnVvcG1Fs8Nc4ReESrD5pN/I5dXkx3+5dSUNI5FC15CD1oC7H+uxVyM15kesaX+1F/3+Kyfx2Wg36ASO23pR4ODKzhUtNpp/Sphxpa0Kdky3NZx/AZO6gLcc6ISNXCEMJTmI7qfdUPJVfBCB9rUwl+YKSre7+CxdU2oTwoXpamNc7DuaGmzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L55l0k7FHvY9hm2cHtPINmMYpViEadKgFTu53b7Uktw=;
 b=LfpXhtNJ7KJ+lc99G44JwmmbFoxIR1h1Xhi8CWLhEDoiWU/EEKlE5H6/InvUnvo2bv/H1nkhsIXBBgYbnuj6gCq+d06tTDQrI2z1G3qKPx9bzV1IBstV3YskMoJxmv2yBnwozuK8IdMSo1LVKOGXOw/GDDFRhelmRbQqQMS6AdVqNE1R4UxZcbsMfm4eX79x/uugicTEMrN285XDbOXPDoTHmTcd9X263uZhxRA62a3Z6ndjs+QJ3dbYbsXTtMHAjtRYDBQ6D/FIHAjCK+hWMzzgyWy2jJn0wyV9Y9Khzzkp+whx8PFUw1qEi+sb2q/NIB1iAfA42lk+2Hl3feiDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11576.jpnprd01.prod.outlook.com (2603:1096:400:379::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 10:12:51 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 10:12:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 50/52] migration/rdma: Silence qemu_rdma_cleanup()
Thread-Topic: [PATCH 50/52] migration/rdma: Silence qemu_rdma_cleanup()
Thread-Index: AQHZ6j6sSuBrAso4tEKEPj5/VVeqYbAs74OA
Date: Tue, 26 Sep 2023 10:12:50 +0000
Message-ID: <2f697774-aea3-6f09-e781-cc1634021933@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-51-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-51-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11576:EE_
x-ms-office365-filtering-correlation-id: 9118869f-4a19-4e08-b07e-08dbbe79240b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyYvDjntk/mVBObId1UIjyxYIe77sQFpYZkz5G6w0RB0u6WW6a2/O3PheEECqRbPSW8HHaI5BXKcQNYdzu2YpQvOgSQP4ezWd2fIP3SY2MbLKUeKYZYVbtnH3SYUS5rYrZBrEJqwDU0vMWgKcaeG2lMyM6J8qw6aXtWFTxPHxybYOKQE8ur+pLDUpHEeat/B9ov+khssNdXM3x9B6UCd+76NsMxterJgjjjBHWErNYnhLViIyxVpbostFYrD/oIhdLWpeiAVIQK4tRjjRY3JJkNCm+NusNirjtg1SiT+RT+tI+HfJk2tpxJa7VauQGFiqmJK4e6sHJjRU1jnLIUfxZEPIvW3/CAWG21Fl9OrA0X0+5srA2/3a5fcqcsVPcnnfXL1CQPCgEM4TtEOCYkRNa83qaaZ5vArLvjwG4cBBoqj/JpCrSUpqCHNjhAVIiQXLBC9K5uWHs1qoKEkbNeLz24us2kklRzGy/A/rEG29EYFv9wjxO85XEk1E3F4rw0sXyKg1Pd+w6lL0reYfKCWR055wkuY6IXfkyrbTyQzIehuAN0uNpBu6+HC3jzsMqKJc8JREB3L26fak46y+WIqraaWqyHeRJTczULwL79ETkqpYGVG77RzjQR38K1eq3bxy5uXHZeMCiVWkoRnL7Cx+F8q8G0qC+3JQ/Xmo2KlnrDVkXYabdz5jFm+HszxNtmuJRhrim7zvQfMffH6XkUxrg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(1590799021)(186009)(451199024)(1800799009)(38070700005)(36756003)(38100700002)(85182001)(82960400001)(31696002)(86362001)(31686004)(1580799018)(76116006)(5660300002)(53546011)(2906002)(66476007)(71200400001)(2616005)(478600001)(41300700001)(316002)(66556008)(110136005)(54906003)(64756008)(66446008)(91956017)(6486002)(66946007)(122000001)(6506007)(6512007)(83380400001)(4326008)(8676002)(8936002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R3lJc0hISGR3dktpZ1dvZ2hZQ3ZleXk0ZktzMDZkMW54MzVHUHFBUEg1a3FK?=
 =?utf-8?B?a1lmWXlWOCt1YmhsbFBxWWlaKzFyNXdURjNGQWJ0MEVIRi9Mb1ZZYlhWenR5?=
 =?utf-8?B?NW92QjZQWHErNExjeGxqZGhaT1B4ek45MWVIVjJKdUdMcVU2Y1lkS0svbHJM?=
 =?utf-8?B?OGVkR241UmpHNVRxRXo0dGd0NFgwSFFlQUszelBLUFVZVWhwWE1OQzZrS3I2?=
 =?utf-8?B?ZC9vS3FScUFlL0VvRWEyWWVSSlZnWXBYU0IzVlFNN2YrUVN6REkvYzMyTXlY?=
 =?utf-8?B?RVFzeDZGR0pEVTY2UDVqVVVNSktUYkZBS01jWDB0eExyR2pKNGluc2FtRzhp?=
 =?utf-8?B?ZE5LTkZyRzBObGQrLzl6Vk9SdnhkS1QzSDdsbHVyNEpNK0I3Snl1Y0JFWnNp?=
 =?utf-8?B?NVVhc2c1Y2lKdlE5ajlBcE9zd1VxTnFIRE5LN3cydnoxK3BBOEc0bVF3WHZh?=
 =?utf-8?B?K1NOaC9QeGU0R1Rkc3RhcFpkTTJRQ0ExNERSeU13ZS96VkttTWJEN05hOU51?=
 =?utf-8?B?dnp0SDMrMzN6dVlUcmJtRXlWdUt4QVRKWXlPWlN1dWtsekx4YVRBeGI5bFlK?=
 =?utf-8?B?bUhzazNCTzRHZFJTZVFlSk55cGN4VjM5eWpNeXllaTFRaDR5L3diNXNWZEla?=
 =?utf-8?B?OGswck5Ocit4WFhSZm5NVGdxWHdtMjBLbkJHSGg0ajFYNmZVdXZrNUF3RTRK?=
 =?utf-8?B?a25pL1F6RmROeG43MkZoREkzZG50d3F0RjhWY0hqbTRJWXozZTJUc2Q1THQ4?=
 =?utf-8?B?elpKcVlROFR5azZVcVJPZmZIUGl4OGR6ZzdTbGNWMmIwbjlOZ2c4WWorN0pB?=
 =?utf-8?B?N3dWYXdvcWNqYWJFSzB3YjdLNWFnM2gwaXBWbU1teWh4emtmQWFuSE9LbUtX?=
 =?utf-8?B?WGE0TXlxZFk5enpVVHBYVkVWNTc2RitvTVRWMFRzNGNTSmJTdFFYb1hybjhR?=
 =?utf-8?B?d1hHL1lsNGV2ZW10RkJzdnRKVmx0c0JvZm13RElZbWFERWRxY2tDeGw3dkFj?=
 =?utf-8?B?TG5tRk5Tb1NNdHB4NE5JK0FhOHhnT0N3ZUJGQWZoblpMcWZqZFlyTm1Jd3Yz?=
 =?utf-8?B?MGxWcElHRUJxVlJaUU5lcGVTeDhBaWFHUUtZTFBtYzJCM2RmOHhuTVVGZXgy?=
 =?utf-8?B?cnFBVEpqYXpxajZDVDZLOUtGdkJtUnJwQVRsQUZ2VHVNNHo0VnQyYVRReFJr?=
 =?utf-8?B?SDBEUDJUK1JvUE5BRUxCeU1qZlkvQXZnRU5WWVlMQlZhRmRrd2UyMFVHMlpH?=
 =?utf-8?B?TWFpbm5jYkJpZHo0TWtleXpONmhLdG1aYmhuUlRtZ0IrQmc0cFZYdU1JQUtp?=
 =?utf-8?B?OXZqSE5EZ05sY0ZXSE83cW5UdzlKT0ZwZzV5cjcvUExFWnVFZVJEc2NXQlpw?=
 =?utf-8?B?REkzOTdBSHIycU41aHJSWTU1VGlmeXhtSUlFMU5NY3lXWE93bHpuR3ZiT2Js?=
 =?utf-8?B?aGJyUS9lU3BtVUZVSzg3SUdWYi9ZbXVZUkhEaGlCL21LRHdxYUxsVzJWSzZl?=
 =?utf-8?B?RDBFaytBRCtmRjBINjlQKzJjbGtvdFRHWmJ5QXk0SVpYcU0zc3pEdUNld3A5?=
 =?utf-8?B?TlNZNjdnRU1pMWhCUkRYUnJXYkVVdDdvdmxvdklnTWx1MmZBelNJLzRoSkVw?=
 =?utf-8?B?aFR3Skk1UERPcDFYV0lucEpNcUlxZTV6THV3TlhFT1UzNE92UVo0TkVlb2FW?=
 =?utf-8?B?OHY0eHBhdlBDRlRKQzFSSmVEWXAva2JXQVowc2NGek9zSHNXK1VKbzVoVHhs?=
 =?utf-8?B?aURFTWRTS1pHczY3VWZZQ3lmNVpRQUFjSGUyRFNFZWVKV3dwN3hmR0J3eUQr?=
 =?utf-8?B?SlBaVGZNdmd0Zng2RXNYUU1qMm0wRUMram1RR2VCTzdBOWphRXVYSWRIOENF?=
 =?utf-8?B?U256ZG1aczVNYUhVM2JwQU84Y3pIUTJMaWR2OExjQkc1dWxSZUFVNWYxVHNC?=
 =?utf-8?B?QnpYZTFNcmJLVUtRZlByUnN6OXNrYlNjSmVaRjNWY1B0UWJsNDVsczlweFJO?=
 =?utf-8?B?MjM2bVR6THJkdHVqRkhyUi9aVXRmS1hiM2NQQ0MreTFYckIraW5LUC9rNU5s?=
 =?utf-8?B?TGxnbkdmRGZCZlZwU2piK0tDTGtLenI5WGxldzQyakdjR0g3MkZpVTc3TUto?=
 =?utf-8?B?S2lQV2J2RDd3WU9pT2ExNmlmWGxwTjdiVUp5cWlkMVU1dk5KWll5ZWdzdkYv?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A40FFA6045C1E41A9D0F3410E1EA07E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E7Rl71F+AQ43404iwXsBybOSzmfcPYx+hiWx0qOMfxlPa2mfMvb+3O6I1j1ufiPsJ2+M03bk7SvWJXm17MLN6SG95fA+sEH/uAb1hS8yhFK4zVdwOnxHtSKt+dJedTYPD/EKoCcdHlr9YeG1Yjl4b7D5vex2c8amhkJxqUqzsH+K/U1E8hIpwMhgDy/fEiAWhpdoyGDUlJ4uvxPgEwfxOYR7x8yKEgmuBG70ZT8qTGbWeNV+ZLTfvQ9+IrbwO4pijod4FG2T9+4Nx+6hHZP9Pe+jXXrJiiY+I1uTJQkuu7Tx1hOxaBo4Eq1HSZOyktNO3KzibhO4y6gyBP5ELH7PtmVnQwxw6vAhNNNItM2dxljM1ASrZLXBmXP0aKlO3vkG7vm9RlUoceReJhK0BDhQuLBLPmoGXJyH6aGuxabFXkZ5NwxS/r4bGACBACmhk4zsc93TAK4hr9YsSwTOcFmny60YvCZL8gHb1txEfv553BiLp22SVn/1exj+zC9A9UH++Nt1YTIpR6Isax/KlB670TH8ygpCbwUWUZ9j2LuP0y7E9uzx3cw+jH4EheydKsqXtoVFTBb6vLuI4bQtMXNixsg6fPzSC4Qj2Rbc24ungd6Ty681Y5hdsvWN7RE0ZfnVfBzpCGDpA3s/6/r7+SwSYMvPh/8wZaSOb8gtGAHAjHXVz70j7b/FnSQxV7h13TqrjDZd1ShbQ08SFjz6vS5KRzXuGt6YVDdrvk4RVqPLcs6YHfAGODpyUv12PslBvpplDtqFr8GT55YRoCgGecVbrzy1ED9/GcR9ZSo3s03z+tI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9118869f-4a19-4e08-b07e-08dbbe79240b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 10:12:50.7712 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vxC0QxUpsWAJ6Zk3ez+CqOvz4JO1sx58xze58qnSk8bu8I+GdYfBsJZUgKaCGbh8SRN3sMMCZPSH2ZyimKrnxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11576
Received-SPF: pass client-ip=68.232.159.247;
 envelope-from=lizhijian@fujitsu.com; helo=esa10.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfc291cmNlX2luaXQo
KSwgcWVtdV9yZG1hX2Nvbm5lY3QoKSwNCj4gcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24o
KSwgYW5kIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0aW9uKCkNCj4gdmlvbGF0ZSB0aGlzIHBy
aW5jaXBsZTogdGhleSBjYWxsIGVycm9yX3JlcG9ydCgpIHZpYQ0KPiBxZW11X3JkbWFfY2xlYW51
cCgpLg0KPiANCj4gTW9yZW92ZXIsIHFlbXVfcmRtYV9jbGVhbnVwKCkgY2FuJ3QgZmFpbC4gIEl0
IGlzIGNhbGxlZCBvbiBlcnJvcg0KPiBwYXRocywgYW5kIFFJT0NoYW5uZWwgY2xvc2UgYW5kIGZp
bmFsaXphdGlvbi4gIEFyZSB0aGUgY29uZGl0aW9ucyBpdA0KPiByZXBvcnRzIHJlYWxseSBlcnJv
cnM/ICBJIGRvdWJ0IGl0Lg0KDQpJJ20gbm90IHZlcnkgc3VyZSwgaXQncyBmaW5lIGlmIGl0J3Mg
Y2FsbCBmcm9tIHRoZSBlcnJvciBwYXRoLiBidXQgd2hlbg0KdGhlIGNhbGxlciBpcyBtaWdyYXRp
b25fY2FuY2xlIGZyb20gSE1QL1FNUCwgc2hhbGwgd2UgcmVwb3J0IHNvbWV0aGluZyBtb3JlDQp0
aG91Z2ggd2Uga25vdyBRRU1VIGNhbiByZWNvdmVyLg0KDQptYXliZSBjaGFuZ2UgdG8gd2Fybmlu
ZyBldGMuLi4NCg0KDQoNCg0KPiANCj4gQ2xlYW4gdGhpcyB1cDogc2lsZW5jZSBxZW11X3JkbWFf
Y2xlYW51cCgpLiAgSSBiZWxpZXZlIHRoYXQncyBmaW5lIGZvcg0KPiBhbGwgdGhlc2UgY2FsbGVy
cy4gIElmIGl0IGlzbid0LCB3ZSBuZWVkIHRvIGNvbnZlcnQgdG8gRXJyb3IgaW5zdGVhZC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4N
Cj4gLS0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyB8IDYgKy0tLS0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21p
Z3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IGQ5ZjgwZWYzOTAuLmJl
MmRiNzk0NmQgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0
aW9uL3JkbWEuYw0KPiBAQCAtMjMzMCw3ICsyMzMwLDYgQEAgc3RhdGljIGludCBxZW11X3JkbWFf
d3JpdGUoUUVNVUZpbGUgKmYsIFJETUFDb250ZXh0ICpyZG1hLA0KPiAgIA0KPiAgIHN0YXRpYyB2
b2lkIHFlbXVfcmRtYV9jbGVhbnVwKFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgIHsNCj4gLSAgICBF
cnJvciAqZXJyID0gTlVMTDsNCj4gICAgICAgaW50IGlkeDsNCj4gICANCj4gICAgICAgaWYgKHJk
bWEtPmNtX2lkICYmIHJkbWEtPmNvbm5lY3RlZCkgew0KPiBAQCAtMjM0MSwxMCArMjM0MCw3IEBA
IHN0YXRpYyB2b2lkIHFlbXVfcmRtYV9jbGVhbnVwKFJETUFDb250ZXh0ICpyZG1hKQ0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC50eXBlID0gUkRNQV9DT05UUk9M
X0VSUk9SLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5yZXBl
YXQgPSAxLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9Ow0KPiAt
ICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJFYXJseSBlcnJvci4gU2VuZGluZyBlcnJvci4iKTsN
Cj4gLSAgICAgICAgICAgIGlmIChxZW11X3JkbWFfcG9zdF9zZW5kX2NvbnRyb2wocmRtYSwgTlVM
TCwgJmhlYWQsICZlcnIpIDwgMCkgew0KPiAtICAgICAgICAgICAgICAgIGVycm9yX3JlcG9ydF9l
cnIoZXJyKTsNCj4gLSAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgIHFlbXVfcmRtYV9wb3N0
X3NlbmRfY29udHJvbChyZG1hLCBOVUxMLCAmaGVhZCwgTlVMTCk7DQo+ICAgICAgICAgICB9DQo+
ICAgDQo+ICAgICAgICAgICByZG1hX2Rpc2Nvbm5lY3QocmRtYS0+Y21faWQpOw==

