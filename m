Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A747C7FB0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:11:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD6c-0004kA-Gf; Fri, 13 Oct 2023 04:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD6Y-0004ZM-K8
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:01:06 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD6W-00088e-7J
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:01:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184065; x=1728720065;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=lScu/x8HNB0COfxUBqMFfnlrNR69nb0OkSsK2QcYNPk=;
 b=y1V4SlEwosW+RUvqQ2yKirg98bdjbVOI54qJzIp0kKad6cBOwYLzfJAn
 rqhNZqVU1XOVC27LspEGzQggwQX2lHrcmcT6ETVospeyWAYFaOsp6cFE+
 UniQcXX91yUr7sdNQ7uuo3eIqLOM4E43b0eDBbW2d2znklmnWR8oPcvcZ
 ibZy9HHQiQqKFNa2B7RTov+CPVOyVNSU5eiG7ghNnHRCrrmXVkO3ika1z
 rkiO819dR7yEt/KHppShNiPQg0JVX/DQ0XPLt7HGVyQhAEbi5y74x58H7
 cLl69hrSAjd4wzbzrqTJ19A7yFLfzJ0k7z5NFRI94XvyWSPZvG3jfhRm8 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="10078464"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="10078464"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:01:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2Pc0rWO48CF9GQpwg1SoVwRGb/32+GyNgCvJjSv7ZO1IVXhF9rfpkQ6yfVT/oj8oMRWtIKTMRVhiUL+M4VcgZifnshrAhECPKgwGma1t0dLo/3kbToCZ3Bn68G3g3/nfGmJ3U1Yo2xNmBGamLuZlA2LpMIMZCdCa+5tZUBf4u839heVns0sKJUT1i42A/ZHYM0GJB8d8mWMAADhOTDeFt49pe3UO22RtythqYgvTT8tRgfxdzkjAez0p0wze36xCHk3rzpIR/+cTtDdkkIn4R9zwZSvgik6w+3HYZGkDdiuPibADkYskOdgUk0a6Vmn3FaOrQJRtdlTH9B39SUx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lScu/x8HNB0COfxUBqMFfnlrNR69nb0OkSsK2QcYNPk=;
 b=iXSDFApLsUqnLMTYpQBPQ3MCdUcoDRBUS02YN5kriPyQyQwqc4ZReobaie0N5LRQpqHcBsMcUEcHwuVRrb1xOd+VkfHg/v2ncgzsnITrEcQnr+hYFoKyz6mWOz3WTjhlhuijV6QJ7k0WsR7XHKShu7q0YnKbRw6c3cfZgfen1rsfWiHjpwFj9oA05znt2/BsnE04HGV5EFCts/nRqEEEsvfXj5sbmNT1UbD2WvLKXgUHe55QYM5Y0nR6EFzUVoKqxR0/kTErOEFKPFdMwISpKaOCbj5yKjgcQDkXe42dHvCUu0+naE16BA/5/h90iUqa6U6yAn/ZoDQwQHXJoneApg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYTPR01MB11035.jpnprd01.prod.outlook.com (2603:1096:400:3a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:00:57 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:00:57 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 04/13] migration/rdma: Remove all uses of
 RAM_CONTROL_HOOK
Thread-Topic: [PATCH v3 04/13] migration/rdma: Remove all uses of
 RAM_CONTROL_HOOK
Thread-Index: AQHZ/IKmDklgadHd4E2EDNxLeCYLkbBHXcOA
Date: Fri, 13 Oct 2023 08:00:57 +0000
Message-ID: <33924641-bec8-6ef6-bf93-c3edd790d93f@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-5-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-5-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYTPR01MB11035:EE_
x-ms-office365-filtering-correlation-id: 18e87e60-972e-4787-1761-08dbcbc2884a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lUVNvEQXejDozhv90JvWbVT7P7IJVCw/8qGCXA45N/q0OC9X4DnSoaIPf/6xl1tNy3T8blJJQJuZVHl2IX5t91FeCY//tpuRo9TEKhPZqEo3zEZ3KbBdsntfjMl0l+jCMlfBWdKlVWumIZpvQdwdp3TKX7fD3svnUj5AgrLLK4Wm1jLe1bjLZ26AYTUGo8XwedxL7j/12LU6MXdF4RlyEe7SYeRC2LQBd9Ta+D4+JWWSuX3ax87v3mGyHAci/Rl+tcm3dRd6I0QQp5whMS/4PojefyLd0ZeShxRJkXhecdqIdfiveIJlw3Lh3la+IV5ZiXZH2f/mXPVyXKIInut5Exyl7BJ/sx1cho1Gxclz82UJ9vK4iEKcpxo/KPF/jhtEE2od1VJCGvAeAX6JmC3NMIl/ZXgKVY0x2qBHamFigJrPdskPoq6lLNod68UKDru/iZEkEeMxBPOadAFqi4VgZW0oQIFri4U+OLb77Co3vctN3DzxZK63GjmMZ2NVQdGbqFJCm13ZtmYlpg+xfH1kPQILLgiUsMAwyzECnqA4J9bG1MIcoc2NEqsM3TKLAVqM5FmlEmleqUl0OVmx8YrfxQEaxRfcotMyN/1ANx4lu3duxmgNdC+zQV4sCnD1F4L682XwmQZ/KSUpQDXAuVxXfsjOlDkCq1LyW5VgzfQgf5gIC6PHIc+1KjHDybBpg41EPJbpXBgsKoeaWvtyV90CPQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1590799021)(451199024)(1800799009)(186009)(6486002)(41300700001)(110136005)(316002)(91956017)(66946007)(54906003)(66446008)(64756008)(66476007)(66556008)(76116006)(8936002)(478600001)(4326008)(8676002)(6512007)(31686004)(1580799018)(53546011)(6506007)(5660300002)(38100700002)(122000001)(86362001)(38070700005)(31696002)(82960400001)(2906002)(2616005)(26005)(85182001)(83380400001)(36756003)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmpUdUVCTzdoRXFoTExTMmZBWDhPY2l5Ukd1akYya3ZqbllnZWN2WUZ2MmJo?=
 =?utf-8?B?OFJwZG1MY3ViZmg0M2VpbWpPK29GdnU4TkJPOUx1YzdSajNrajZnMEJqVUlt?=
 =?utf-8?B?SUNYeTZkSkYvc1lmUlNpdG9za1hLS1pHbVR3WWpDWWdpRzZEd1JRcVVmTzhm?=
 =?utf-8?B?TXBlTC9XQk9Vc1N2eHhpVm5GYlozc3RJeVRyZncyRXoxbUUwQ29ycnpWNWNj?=
 =?utf-8?B?cVhCTkN0bkw4ZjNFV2JRa3hicnloUlpzb2lLMEh2QUx0Snd0Sk5IbHVZak5v?=
 =?utf-8?B?WTBTUGNOQ0lmZlh1KytCMEsxbXdGR1pjSXVHWG5OOXh2SXhXK0FrdkYxOEIr?=
 =?utf-8?B?VWdZSGs3ZkRUUUVXR0NPWWlDa1grdDg1OWdYejFCd1NyeVdGNDZNS1F1Rzd6?=
 =?utf-8?B?WExXOVZDdnlHRkppSHd4Mjk4ZDE1S2h4OWJDQnJHL0tlM0Z0Um8zZThpTnd3?=
 =?utf-8?B?TVZhQUxBOTFOUEY5MEpoOXl5Qk0rdFFJdFdwbXU3bTJmRlBORi82QndCNWRQ?=
 =?utf-8?B?WUxoa1NHL1ZEdGhTcjFiNlhlbnQ4b2tDb1o1N0c2UFJFWFVSN082Zm5qUnVO?=
 =?utf-8?B?R2FIdldmSG1XM2tiaXRjZDUvRE0yOG5QYWY4M2JhU0Q1NkplTm5rejBZRVRO?=
 =?utf-8?B?Q1JxSVVYbkZadTNUWURJMEIrQ291ai9WK2luQjVmMjVUcHNVbHFPNlN5K0Rn?=
 =?utf-8?B?RFpMbVlrUEc3b0ZvY2trUjlWVkZLbFZaNm1lRk1XY3hRaGV4VlQwbm1oaEw5?=
 =?utf-8?B?UzNUSVBDVW15dkdRWXRMU0RGdURlN29RZlRiL0JOMnM3M2FGdlJkUUlFNi9J?=
 =?utf-8?B?TTdGTEZ4dnZ0dUUzcHp5ZVpnVzN5Mmk1ZWNxYWp6VVcxc0hOWTdPSE5tRVht?=
 =?utf-8?B?NENqbDhFa3ZYYlJ2bXdCYVgxNVk2MVRhbE1xT2Y5a1ZRZVd5T0pWbHdpbFhN?=
 =?utf-8?B?cmdpT0NoRjF3NERBZ0Q0U29WdVFZUmVjY0Q3WWVHL2t6eStIb2RwK2M3TWkw?=
 =?utf-8?B?b1Q4RklnOWE1cUhQWTlGSlI5bjJ3MGZwUmN1T0JmeWtrTDVjSUpCd01GbTRp?=
 =?utf-8?B?aTRQWjltYkJYbDZQd3FxZ0JLL0NSLzAvaHJMazVQRVdpQ00wRXZKMENMbDJx?=
 =?utf-8?B?RTc4dVlENjdSb00zSmxHV2RTVjM2QlRwWVVWaVByK1psS0NpL2xnMkRUQmZJ?=
 =?utf-8?B?QjdyZEFjNXB1aytXRDl5L1gyZTEySElrSDRuUEl4SC9ETjhSWnVrWVJ0b240?=
 =?utf-8?B?cTVGT201cEFtQlVITDRhTVFiR3VzUUE3alhjY0hJaUErTXAzUHl1VEw3cXdw?=
 =?utf-8?B?eFJnaGM2L0xmeGlzTUtaT0pXZmpRNS9uaFVMbkJCSVNxdE5XdnpqZVBqemEy?=
 =?utf-8?B?aFJHNzVsbnJVTVBXTVF5NUxtZTRvcXV6MGlXS2ZGODRNNWJFWE9UL1pxNEZy?=
 =?utf-8?B?Tnl0WTkvQzJkVGhTUUJ0a1lsTnZIeFAvak1jRVByR0lNSHllRE9DVlRGeWEz?=
 =?utf-8?B?V1VuMzdYbno3UW5tVGx0K2wwVG45R3RiVHpHWHBmemhiUWNud2RMeFZGQ0R6?=
 =?utf-8?B?ejNxSmQ1L0ZmK09iUGtHcUpHL1ZkditPZzJPczVNRE1Dd05LdjRwd3Q3dlBD?=
 =?utf-8?B?NkR5V2IyM0VzUEs4YkljdU56dEZWSUp5R3FyRDdwaEhWa2IxWEpHNDhzZTZ1?=
 =?utf-8?B?aThjaU1JZnhmTkgzWjJxZ2ROTjVTaWExNmsveWd6bE04RjJKcFBhMGMveHdE?=
 =?utf-8?B?UjVqNWMyZkgrN2VBWHpKMFRucTlNc3dURVo2U0dwSEdtc2RMQnF2V0hlZ2hS?=
 =?utf-8?B?MWlzQmlQcWhJQnBlZWRFYjA1S0lDeG0wdXlFdGRZUS9LYXJJK0dvbGg4TThX?=
 =?utf-8?B?M3RENHBhaDc0dXQ0S0RqckkvWEVsL0tDM1dGRWFuaWp5NUlxcmI1dmJFdTdp?=
 =?utf-8?B?aVZkbjAyQmhrL1B1djFjbHJJbExTQUcxMVk2RDJGREtRa1FiZlM0bGlUMU9D?=
 =?utf-8?B?NHlNQlZVbENlWFdILzZvczdWNkdDd0NRclRvL0piTUpNU2craEJrZCtnc0ZI?=
 =?utf-8?B?MXpTMVZVVE1Ka3gwQW84TzlBRkVrVGlrWUxhVEJOaEN3ZUlwRGRncHdCc1Ar?=
 =?utf-8?B?RFFlMDFZektOOWFSNjNtd2VYREdJNVhhVThPaGNlMmFtWWlES3ptVVBNVmlp?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D1637ABC5AB104B9E29AD96D2E2EB7D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pwql5RqAvfGxyVh2mRqZhKeudMtubKGl5BPAEAGPX/sk75YDhm7J3YZaKv0NErXarcl/zL6ySNEMa0wjp/xbOP2/u61ZzXOLn/mKcPWDBcemviRXUFolaikEV+xVCUYk8OjrJoxHJjKWlMhQ6/OsQQhmweqLO0vJTcP1ySDBmiLRmkV7xJ7KF2usq5IekFfay9WFIPoJYwFHKt6XSOqcfrarO8BASmjyXJ5nZ7Sh9a7lpHBJrm2oO8jNZyvg9i/GKkxfii+hWBqWqi9jHxTEwp8GU/2rr752aLKwCVWxd1n5UVnulkYqLZ48bnnAw8S4JLAi5o3jno+qroOB6ozd4ERjhiFiAl+uq13qGSf240eTtqjaNdkuUbbJuXoXvOzs14ACCoGWHsNmws8CAEJ8lp/gwQ1OM+pBF7/hbG9SuE1e3/DBYBhcYTqefS8ub5Z/X0GP3jEJ4p+7QEf8XUCxb7hZlqjKq5c/2hcu3oSNbf3q1pLuokxqUpkA4HR6NTcE15Ha3Wy1BsutxLMchd8JYn2G7b2qcMEuqWgRIvY8o8hiRJLss4jwGprOzU9bbUkV3af3UiAPr9EoGfO+QcyuKo7Gq0jesXAgw2re+qM9/6+Th/8iWi0TFpgUpGKFecd6oCsw+N4W7TVqg8zZaD3gRxJbAPiy+E860Y5KqKDQQxqvzJ9RGnyu8Heyu7oJe1Wl+FRiRP2t8jbCudqN2TfSw6VvNdIiVERGNfte4l93PlDT6XrJXSdNOqu6DCV0EfMEBklcpljjvHVuZX1klOVKpNHCTcp/AcmLwvU3VM212klizTy7kEjQ4XTulUfRK+OP
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e87e60-972e-4787-1761-08dbcbc2884a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:00:57.3578 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKno1bwIGL957oZsPHr8UYgjqn0nD9RS0CC6UFqFmfA1wurpaWvdCGbyuxJuvAG0Qkwep/BtZecCKRa+z6IZUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11035
Received-SPF: pass client-ip=68.232.152.246;
 envelope-from=lizhijian@fujitsu.com; helo=esa2.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IEluc3RlYWQg
b2YgZ29pbmcgdHJob3VnaCByYW1fY29udHJvbF9sb2FkX2hvb2soKSwgY2FsbA0KPiBxZW11X3Jk
bWFfcmVnaXN0cmF0aW9uX2hhbmRsZSgpIGRpcmVjdGx5Lg0KPiANCg0Kcy90cmhvdWdoL3Rocm91
Z2gNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCg0K
DQo+IFJldmlld2VkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIG1p
Z3JhdGlvbi9xZW11LWZpbGUuaCB8ICAxIC0NCj4gICBtaWdyYXRpb24vcmRtYS5oICAgICAgfCAg
MyArKysNCj4gICBtaWdyYXRpb24vcmFtLmMgICAgICAgfCAgNSArKysrLQ0KPiAgIG1pZ3JhdGlv
bi9yZG1hLmMgICAgICB8IDEyICsrKysrKystLS0tLQ0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTQg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRp
b24vcWVtdS1maWxlLmggYi9taWdyYXRpb24vcWVtdS1maWxlLmgNCj4gaW5kZXggMzVlNjcxYTAx
ZS4uMTRmZjBkOWNjNCAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3FlbXUtZmlsZS5oDQo+ICsr
KyBiL21pZ3JhdGlvbi9xZW11LWZpbGUuaA0KPiBAQCAtNDEsNyArNDEsNiBAQCB0eXBlZGVmIGlu
dCAoUUVNVVJhbUhvb2tGdW5jKShRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRh
dGEpOw0KPiAgICAqLw0KPiAgICNkZWZpbmUgUkFNX0NPTlRST0xfU0VUVVAgICAgIDANCj4gICAj
ZGVmaW5lIFJBTV9DT05UUk9MX1JPVU5EICAgICAxDQo+IC0jZGVmaW5lIFJBTV9DT05UUk9MX0hP
T0sgICAgICAyDQo+ICAgI2RlZmluZSBSQU1fQ09OVFJPTF9GSU5JU0ggICAgMw0KPiAgICNkZWZp
bmUgUkFNX0NPTlRST0xfQkxPQ0tfUkVHIDQNCj4gICANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlv
bi9yZG1hLmggYi9taWdyYXRpb24vcmRtYS5oDQo+IGluZGV4IGMxM2I5NGM3ODIuLjhiZDI3N2Vm
YjkgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmgNCj4gKysrIGIvbWlncmF0aW9uL3Jk
bWEuaA0KPiBAQCAtMjQsMTAgKzI0LDEzIEBAIHZvaWQgcmRtYV9zdGFydF9pbmNvbWluZ19taWdy
YXRpb24oY29uc3QgY2hhciAqaG9zdF9wb3J0LCBFcnJvciAqKmVycnApOw0KPiAgIA0KPiAgIA0K
PiAgICNpZmRlZiBDT05GSUdfUkRNQQ0KPiAraW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25faGFu
ZGxlKFFFTVVGaWxlICpmKTsNCj4gICBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9zdGFydChR
RU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MpOw0KPiAgIGludCBxZW11X3JkbWFfcmVnaXN0cmF0
aW9uX3N0b3AoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKTsNCj4gICAjZWxzZQ0KPiAgIHN0
YXRpYyBpbmxpbmUNCj4gK2ludCBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX2hhbmRsZShRRU1VRmls
ZSAqZikgeyByZXR1cm4gMDsgfQ0KPiArc3RhdGljIGlubGluZQ0KPiAgIGludCBxZW11X3JkbWFf
cmVnaXN0cmF0aW9uX3N0YXJ0KFFFTVVGaWxlICpmLCB1aW50NjRfdCBmbGFncykgeyByZXR1cm4g
MDsgfQ0KPiAgIHN0YXRpYyBpbmxpbmUNCj4gICBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9z
dG9wKFFFTVVGaWxlICpmLCB1aW50NjRfdCBmbGFncykgeyByZXR1cm4gMDsgfQ0KPiBkaWZmIC0t
Z2l0IGEvbWlncmF0aW9uL3JhbS5jIGIvbWlncmF0aW9uL3JhbS5jDQo+IGluZGV4IDE1YmQ0YWQ2
OTcuLmVlOGJkY2RjODIgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yYW0uYw0KPiArKysgYi9t
aWdyYXRpb24vcmFtLmMNCj4gQEAgLTQwNzIsNyArNDA3MiwxMCBAQCBzdGF0aWMgaW50IHJhbV9s
b2FkX3ByZWNvcHkoUUVNVUZpbGUgKmYpDQo+ICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAg
ICAgIGJyZWFrOw0KPiAgICAgICAgICAgY2FzZSBSQU1fU0FWRV9GTEFHX0hPT0s6DQo+IC0gICAg
ICAgICAgICByYW1fY29udHJvbF9sb2FkX2hvb2soZiwgUkFNX0NPTlRST0xfSE9PSywgTlVMTCk7
DQo+ICsgICAgICAgICAgICByZXQgPSBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX2hhbmRsZShmKTsN
Cj4gKyAgICAgICAgICAgIGlmIChyZXQgPCAwKSB7DQo+ICsgICAgICAgICAgICAgICAgcWVtdV9m
aWxlX3NldF9lcnJvcihmLCByZXQpOw0KPiArICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAg
IGJyZWFrOw0KPiAgICAgICAgICAgZGVmYXVsdDoNCj4gICAgICAgICAgICAgICBlcnJvcl9yZXBv
cnQoIlVua25vd24gY29tYmluYXRpb24gb2YgbWlncmF0aW9uIGZsYWdzOiAweCV4IiwgZmxhZ3Mp
Ow0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMNCj4g
aW5kZXggOTljMDkxNGEyMy4uZTUzMzgxNDU5OSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3Jk
bWEuYw0KPiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0zNTIyLDcgKzM1MjIsNyBAQCBz
dGF0aWMgaW50IGRlc3RfcmFtX3NvcnRfZnVuYyhjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpi
KQ0KPiAgICAqDQo+ICAgICogS2VlcCBkb2luZyB0aGlzIHVudGlsIHRoZSBzb3VyY2UgdGVsbHMg
dXMgdG8gc3RvcC4NCj4gICAgKi8NCj4gLXN0YXRpYyBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlv
bl9oYW5kbGUoUUVNVUZpbGUgKmYpDQo+ICtpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9oYW5k
bGUoUUVNVUZpbGUgKmYpDQo+ICAgew0KPiAgICAgICBSRE1BQ29udHJvbEhlYWRlciByZWdfcmVz
cCA9IHsgLmxlbiA9IHNpemVvZihSRE1BUmVnaXN0ZXJSZXN1bHQpLA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAudHlwZSA9IFJETUFfQ09OVFJPTF9SRUdJU1RFUl9SRVNVTFQs
DQo+IEBAIC0zNTM0LDcgKzM1MzQsNyBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRp
b25faGFuZGxlKFFFTVVGaWxlICpmKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fTsNCj4gICAgICAgUkRNQUNvbnRyb2xIZWFkZXIgYmxvY2tzID0geyAudHlwZSA9IFJETUFfQ09O
VFJPTF9SQU1fQkxPQ0tTX1JFU1VMVCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAucmVwZWF0ID0gMSB9Ow0KPiAtICAgIFFJT0NoYW5uZWxSRE1BICpyaW9jID0gUUlPX0NI
QU5ORUxfUkRNQShxZW11X2ZpbGVfZ2V0X2lvYyhmKSk7DQo+ICsgICAgUUlPQ2hhbm5lbFJETUEg
KnJpb2M7DQo+ICAgICAgIEVycm9yICplcnIgPSBOVUxMOw0KPiAgICAgICBSRE1BQ29udGV4dCAq
cmRtYTsNCj4gICAgICAgUkRNQUxvY2FsQmxvY2tzICpsb2NhbDsNCj4gQEAgLTM1NTAsNyArMzU1
MCwxMiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25faGFuZGxlKFFFTVVGaWxl
ICpmKQ0KPiAgICAgICBpbnQgY291bnQgPSAwOw0KPiAgICAgICBpbnQgaSA9IDA7DQo+ICAgDQo+
ICsgICAgaWYgKCFtaWdyYXRlX3JkbWEoKSkgew0KPiArICAgICAgICByZXR1cm4gMDsNCj4gKyAg
ICB9DQo+ICsNCj4gICAgICAgUkNVX1JFQURfTE9DS19HVUFSRCgpOw0KPiArICAgIHJpb2MgPSBR
SU9fQ0hBTk5FTF9SRE1BKHFlbXVfZmlsZV9nZXRfaW9jKGYpKTsNCj4gICAgICAgcmRtYSA9IHFh
dG9taWNfcmN1X3JlYWQoJnJpb2MtPnJkbWFpbik7DQo+ICAgDQo+ICAgICAgIGlmICghcmRtYSkg
ew0KPiBAQCAtMzg0MSw5ICszODQ2LDYgQEAgc3RhdGljIGludCByZG1hX2xvYWRfaG9vayhRRU1V
RmlsZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIGNhc2UgUkFNX0NP
TlRST0xfQkxPQ0tfUkVHOg0KPiAgICAgICAgICAgcmV0dXJuIHJkbWFfYmxvY2tfbm90aWZpY2F0
aW9uX2hhbmRsZShmLCBkYXRhKTsNCj4gICANCj4gLSAgICBjYXNlIFJBTV9DT05UUk9MX0hPT0s6
DQo+IC0gICAgICAgIHJldHVybiBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX2hhbmRsZShmKTsNCj4g
LQ0KPiAgICAgICBkZWZhdWx0Og0KPiAgICAgICAgICAgLyogU2hvdWxkbid0IGJlIGNhbGxlZCB3
aXRoIGFueSBvdGhlciB2YWx1ZXMgKi8NCj4gICAgICAgICAgIGFib3J0KCk7

