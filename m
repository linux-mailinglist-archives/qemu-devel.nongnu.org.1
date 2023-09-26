Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466687AE531
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:45:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0rT-0002Ku-1y; Tue, 26 Sep 2023 01:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0rP-0002Kl-MD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:43:51 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com ([216.71.158.62])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0rM-0005t7-3x
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695707028; x=1727243028;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=U9kN4GgiZVmtQC54897yG7xN8+m2B1RPxhQTcmVALKI=;
 b=accq/celbPPPWYkhRT9wvFKJRaG7yoxFFaK7BHh/TXaW4MMqWShcmWhl
 IRzgml2QPQt5m7dIDYhkCaYYG+x4RUqzMThKxxIiZZ6QHc7iZ6JQKh0vK
 nw3dU6tHugP+cdT4ZebFH2hsltCfJO5F08MR9Or1zAACO/Xnf6pXA/1A0
 VAjOgmky0tALZx/8/YQmG5Kp65LieLWnn0+FjqDoz/7oEnc9ZKy4PAC2W
 IqxphgnslV4/h/iOgbVhqPhtToN45aJV7XVE88qX5VlXriKZhD0gen2y2
 gAiA+/kxJ6m614OVU8yTvGl1k4+W4+Iqh1uwRLAk9zcsTKKpnyUkD36GU g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96237166"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96237166"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:43:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ydewr4GGEVgJkB6o71dr6Zksn4hHvxO15Uo5y5pW9yKTMQuYGZDuIY/HdgaFU+pMdJkyQdr+DRWlVMUAXpmQdGgtlGImj/XsdxaJ4B4N92KAe4wTWtvmAJiO02MUvRZIxgI4hqu/CliXFb1MbhPVJVEFn/T136M2vxWvDoD2vGHCTtARztF6/2kx/X+P4dFqEu2YF3RdCLk3A6G1SeNh2cx2kbUtK8O3v0krbzlzK1IWdLXAh4q2KSp8iHkCCft/NtfRYbK4uvmshf+GFBqD2dcDq8ZUcur6+3eD2le3e4vLoOgA/6S/qCqW5RxSh1uqhivQ5EFPh7w8bjT58PlReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9kN4GgiZVmtQC54897yG7xN8+m2B1RPxhQTcmVALKI=;
 b=RiTIhUeu83FjS+FpPGOJIKoyJ+8IDyGxySet1LnpNYjRwi81qU5YO+wI2toDQlVMhobmtFBrw/+SLfpPECniJPmd2DJNK6JFLRwbtBZgapOSBBp7ydhCRfH1SOZ3UXMNOu2xmug1i+zF+c+uI6MgaD1UgGrMReObF8JmWFf+GI+NCx+xZM/9/j/qr5+Ga0uQFUGx2pW5osIdNBsYZaoKm0kQjKcxxJp+qNw77GP9CUs8IBpWwpIIukpeCXPuGHaU6ncAQvGsB1sLTgjGa1pscTiMgbkrDnEwt7GQotQAr2camm4+m+ECUseiV+19jPT3YP1oFbUhBbqAMA+7OMRuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB10389.jpnprd01.prod.outlook.com (2603:1096:604:1fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:43:39 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:43:39 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 43/52] migration/rdma: Convert qemu_rdma_alloc_pd_cq() to
 Error
Thread-Topic: [PATCH 43/52] migration/rdma: Convert qemu_rdma_alloc_pd_cq() to
 Error
Thread-Index: AQHZ6j86GNDeZBZ8u0iYK79fAIBnd7AspE0A
Date: Tue, 26 Sep 2023 05:43:39 +0000
Message-ID: <209dd727-9e55-42d0-aac7-98509a4789b0@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-44-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-44-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB10389:EE_
x-ms-office365-filtering-correlation-id: caf61f43-9df1-487d-ae77-08dbbe538927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NCFYYXKO5N4LFqWlo9CQqDCNFLSp5IR295qrqLUFw4qy162nVK/zsvBt/4udt11gD7YvBhgT5x2nJP3HDm9DcTjUdK5Pm5eP2qD0WG1zTQnwBp+pvOfbTgi3uzfnW5hTvehx6pM/SIESfMwfj0lb/Dd+YbpaNrfHuJkt5bUMsZfg8tuwSrsUNTi7IMoi6PpmqA1/e54gOv4jaC7QVMJLL9iUoj8wAAUNRamPIWFVH/9e20NxMwKrIdrFs2YQWFDzFWOG0GLLf9oYQThljmTugD7ZF3i3i3d2F1OT/EFaazOBzvvq96xzEcP0Tf4i+dB7S1v1V19l7RjldDaa5HGlKBDkZ2HIkuelfwybxQ91/u59QoLYNNz99Ym1w65s91olHeG/hDsli23TGQiZS6bfYaaWVq0yT5Ds1mbIs0k7SDMy2+XzznMxSimQjxF/dGFVeeOqsz6RjCFgdePuU7QpEJX1xJ6xpKc0YmZJhvhmOteo6NDwojpcNYWuRt/0/EYeyr6Zik+/zoPKj9uFL+bQ88gehS1Aj+YVc3rSes6x+ddmE9bS15R6Lg5wo+eJhjSiRE8DzKKkmJuf4dlRJg1nO00rhdBJDzSAIP2lZcYg891Ykw1oJLZzgrh9mCKbNp0HGu1zON2tPGpuGCwkAkF92RWOqo0sJO+xrZfJZtCVmLmHgyKo8nxzrkBIOhsH0FhdWcdSQLojwd/xhJL35XqNgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(346002)(396003)(376002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(36756003)(38100700002)(122000001)(38070700005)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(53546011)(5660300002)(2906002)(83380400001)(66476007)(2616005)(478600001)(41300700001)(76116006)(316002)(66556008)(54906003)(66446008)(6512007)(91956017)(110136005)(64756008)(66946007)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzVuK3p2VnJQa0lmaWhYUk9sc3VzakFMQ0ZMWDJZYlFuTkdmWDVnRUttZHQ5?=
 =?utf-8?B?eGl3L0ZqUHZxQnBaUHJxbzdJa0xhZ01BUE5qY0VRT1lPSzdETmZLUVFBU1Zn?=
 =?utf-8?B?TW0wTGVyV3hESFZDakpOOHNKT3hPRWg2bjdzZGI3OTErblNjYTE1OURqZ2tu?=
 =?utf-8?B?Mm55ZXVMMlV1R09oM1hJbGg0MDdYZjJhektZemREeTE3RHVnKy9EMWVpT3Fm?=
 =?utf-8?B?WktWS2VyYUNGT1J6UzdmUmdmZUVpNGxCcU5DajVnN2MrVVpDL0Zhb1hXZGZ5?=
 =?utf-8?B?R2ZSYzBJSHU2WmtpRkVVdkNZZSthV3crZlB1MmJuZ3ErcmVKdXVYOU96MHg1?=
 =?utf-8?B?dnFEUWV6T0JwVUplN21wVk5hQ2F3eFlFbkJiZ2kyWjNqZ2dWRjlxZlowU3Zz?=
 =?utf-8?B?eXp0UWx2RlpwZVZyRldjSXVheWJ2SlYyYnJOdmF2c2crTVhCaU5ERFo2YTFs?=
 =?utf-8?B?RFJOT1ZNcExYTEdEcHkyM3dFaFNXbXEzc3p5elA5c3Z4RmtwMDBKS1J2VERa?=
 =?utf-8?B?K3JlV2oxVGE2Q3dhTUlXRHN3cmNyZC9VNmd3TzJOSFFWeElPTzIzQmo3NDEw?=
 =?utf-8?B?ZjlKY2o3L1hsVTZhbldLV3pwdjk1OGlMOFI1L2doS2NIZEYyenRJT1RLclha?=
 =?utf-8?B?SThZamI4RDFPM0tROEFlL0o4Slg0OWt6YTRubUFER0liYllsbjI5WmJ5ZzEy?=
 =?utf-8?B?TXhFTlhvK2pKU0NQUXFIa0VFNFRtOTIybG11VEVzSHpTRDBPdFFjajVtTllB?=
 =?utf-8?B?UVFPa3c3bTNwd3VpeERuYlY0M1RXNEhidVhRUkdKbkNRYjJobmdBMWNraU1w?=
 =?utf-8?B?R3lndXJYaDRxdHd6cUpZOUZTVklWZ0lnMGlkUGxVZ293UTBmZTFTa2VwUS9N?=
 =?utf-8?B?N1g2MkpjN2tTR1BjZkN6d05uY09NMG44UlpTUXJNQkllU1dzQTdlcUFmOXJE?=
 =?utf-8?B?Wm05ZU5HUEVxZDBRSFNVQVpKMlpWZU1pNFVuMUlQUUhyRk1GY3huT2VCL2xU?=
 =?utf-8?B?c3BadEFwTHo2Qmcxd1V4N1dJN21aRTIwaHBPblQyQ003TXViUDh6bnRjMkpE?=
 =?utf-8?B?Sk1iaGxEUy9Udi9GTW9oUHliUjV1T0hpVG9mVE1VZUN4bllNV25Wd0Q0VWFG?=
 =?utf-8?B?aXg0anAzMWhZWUk2ZnlpamZoTHVZUGtJZTRXU2V6QnU3cHM0cHpJK2JoYVgr?=
 =?utf-8?B?aWFvZFhvNExvMmpMaDV0K2t5a1Bnb0IrN1c5SnhDSGNUYkJtQVlHb1VOS0Q4?=
 =?utf-8?B?VzJVMkM4UGZUc29SWUEvSU9aMzFENk9sZWU2dEc3UWsvdXVtUDBod0E4OTdt?=
 =?utf-8?B?VTI1dWN5VlJCWXUxcnFHekoyQy9EU1JOVDZlQ1ZHekkwc1J4M1JTamJmV0Z5?=
 =?utf-8?B?S3NXRE1XKzU3UDkrSUtWNXpQU3RKZHlZZmJNL3pnTXZFbEN2eXdoNlhLUVpF?=
 =?utf-8?B?bWJ3WE9NRGl5Ni9vQzFiaTRkLzRMY0pSSU5oSmdIK1JyL2FpZWhERnJmcTh5?=
 =?utf-8?B?UWJXc3BIeXdPQzhWVGFGUE8wOXpMS2hZcGFXUEtHUGxwWEpNUVYzUnBydmdG?=
 =?utf-8?B?SFlQRTdtZnorQ010S2xZT1hWWFBxWHMrS09QcGhBdndJdXk2VUdzSWZMK0gr?=
 =?utf-8?B?eWQva1ZvWm5XYVZkcytJVUd6N3NnaGNwQThLQkhkRTA2LzNaelQyWjN5dkN1?=
 =?utf-8?B?bVN0NTZKN3FDR2ZPM3lnaThuTlRvQmlWeS82WWwxd2d2eVAvR2w2dEt6a0xa?=
 =?utf-8?B?VHhVcXJ2VGhuejdaVVRLdy83QnUyY1YrNytwd3hUdEJMMXMrT2NySUk4NmxR?=
 =?utf-8?B?NGdraGkrODBqekVSOGNJNXZMSC9GT2ZpSFZtWTdDWGxDL3lHbTdFaHpGWThk?=
 =?utf-8?B?ZEFxUFh3em9KVG5IR0N4RkRPVGc5N0h5UVU2c1V2cjEyWjlFOGpZaHBWcnFo?=
 =?utf-8?B?VndYVUZGVGlVZzhsclRKcS8xRjVNaEkra3lSUWxIVGdJL1gxL3lHL1lYSXpF?=
 =?utf-8?B?N2d5b0d1RjBiZzk0Qks1T2RDTWRWbXVSSXRrck5xOHdBc2h2bEtkVjdXaVpz?=
 =?utf-8?B?SUhVbEVaMjczUXhMZVE4OExCa3VWb0M5WUt5Z2F3Q1NTU3Vza3pwTFNOeHl3?=
 =?utf-8?B?ZWdBNkhpMjVtWGNxVHdpaUV0bU9HdkNjMWh6UVRCb20wSm9VUU9GYlJVL0U5?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBF48ECBC11E86438AF1F706849E63B6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8dCRNmMj0S1BLGFkHEDPRErB4YG9lC9UGJtNrN1jEMvirhe6qTjQjfo2MuzsrEj2QFUi7cA5ILHqPAXNepW0BxoC4+XqqOvhnyub4nlcgDqQzmdD8x/RmyrGA6MQuED8OJbHjEeJYO20cIxuw0zRek+cvfmQvu3OWeH48jjq+K1puUrlN+UUaBFksXlLHH5xqaRSacpsphq93c/eJ+yhe8OJ50WshCiJ+iAagcPynfp9O2KQuKf/aQ5bv9ahKuKEz19wPkINswEYpz5VPZGNyvCemSBGJCb1DLMTGABAL3vUVNGyy5CN7LCtrxeeVlTdch2mozwREPmlUCKkau7W1KKdCb+WKUNq7UiPNqN+w8xuLIe6JIQWYfuPQizmt9WZTagCsJCsFTsJgQNRgdB4/LNHL56Xi8ptQhvKt8+/Wss7ONGwQLFgN59f2h+5CWa05E1+Q29Ph7JUEf7lNmGlqGSDZghYzVDYEqEXhqMnzQMTW2njdbtF/i5mW6iOH8qQfAtqoc6v8X/qoEmCpKkrvghZQbgSwvBlpzdPYzTvMKI007v47cI375/QtAm2+WaUxUz1ZfJX6CbU8GORiVLvjfrOrRHWJ0TC+EdajzhDUu4z4pwchxTUK0faAqU98n9GK2AaH1/mpBz/bfKnsI+N2KjmbZ5n1qkZhJtvTuRmCZt8x2Jm6yetsLZItrKlugfEnT7SRclZH2ZUCnw23jCuNsvtP7/+yeNlX2U264/+ZlB2ztdP2o80R/XySBPG3694861OlT1pDJmKmR4Lqq3FTjCu3u8Egh7tzn0DpDJmFtg=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf61f43-9df1-487d-ae77-08dbbe538927
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:43:39.5518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OinZrFG+IUUAdHzDG1qSvnPEeLRJeXQuWimC3W3YO6F3QqPms/rJ67SnqkG9byKdkwxEvWJwyRCUwwj0ZXCCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10389
Received-SPF: pass client-ip=216.71.158.62; envelope-from=lizhijian@fujitsu.com;
 helo=esa19.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfc291cmNlX2luaXQo
KSB2aW9sYXRlcyB0aGlzIHByaW5jaXBsZTogaXQgY2FsbHMNCj4gZXJyb3JfcmVwb3J0KCkgdmlh
IHFlbXVfcmRtYV9hbGxvY19wZF9jcSgpLiAgSSBlbGVjdGVkIG5vdCB0bw0KPiBpbnZlc3RpZ2F0
ZSBob3cgY2FsbGVycyBoYW5kbGUgdGhlIGVycm9yLCBpLmUuIHByZWNpc2UgaW1wYWN0IGlzIG5v
dA0KPiBrbm93bi4NCj4gDQo+IENsZWFuIHRoaXMgdXAgYnkgY29udmVydGluZyBxZW11X3JkbWFf
YWxsb2NfcGRfY3EoKSB0byBFcnJvci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1i
cnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5jIHwg
MjcgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KDQpbLi4uXQ0KDQoNCj4gQEAgLTI0NTEsNiAr
MjQ1MSw3IEBAIHN0YXRpYyB2b2lkIHFlbXVfcmRtYV9jbGVhbnVwKFJETUFDb250ZXh0ICpyZG1h
KQ0KPiAgIA0KPiAgIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3NvdXJjZV9pbml0KFJETUFDb250ZXh0
ICpyZG1hLCBib29sIHBpbl9hbGwsIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICsgICAgRVJSUF9H
VUFSRCgpOw0KPiAgICAgICBpbnQgcmV0LCBpZHg7DQo+ICAgDQo+ICAgICAgIC8qDQo+IEBAIC0y
NDY0LDEyICsyNDY1LDEyIEBAIHN0YXRpYyBpbnQgcWVtdV9yZG1hX3NvdXJjZV9pbml0KFJETUFD
b250ZXh0ICpyZG1hLCBib29sIHBpbl9hbGwsIEVycm9yICoqZXJycCkNCj4gICAgICAgICAgIGdv
dG8gZXJyX3JkbWFfc291cmNlX2luaXQ7DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICByZXQgPSBx
ZW11X3JkbWFfYWxsb2NfcGRfY3EocmRtYSk7DQo+ICsgICAgcmV0ID0gcWVtdV9yZG1hX2FsbG9j
X3BkX2NxKHJkbWEsIGVycnApOw0KPiAgICAgICBpZiAocmV0IDwgMCkgew0KPiAtICAgICAgICBl
cnJvcl9zZXRnKGVycnAsICJSRE1BIEVSUk9SOiAiDQo+IC0gICAgICAgICAgICAgICAgICAgInJk
bWEgbWlncmF0aW9uOiBlcnJvciBhbGxvY2F0aW5nIHBkIGFuZCBjcSEgWW91ciBtbG9jaygpIg0K
PiAtICAgICAgICAgICAgICAgICAgICIgbGltaXRzIG1heSBiZSB0b28gbG93LiBQbGVhc2UgY2hl
Y2sgJCB1bGltaXQgLWEgIyBhbmQgIg0KPiAtICAgICAgICAgICAgICAgICAgICJzZWFyY2ggZm9y
ICd1bGltaXQgLWwnIGluIHRoZSBvdXRwdXQiKTsNCj4gKyAgICAgICAgZXJyb3JfYXBwZW5kX2hp
bnQoZXJycCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIllvdXIgbWxvY2soKSBsaW1p
dHMgbWF5IGJlIHRvbyBsb3cuICINCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIlBsZWFz
ZSBjaGVjayAkIHVsaW1pdCAtYSAjIGFuZCAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICJzZWFyY2ggZm9yICd1bGltaXQgLWwnIGluIHRoZSBvdXRwdXRcbiIpOw0KDQoNCkkgdGhpbmsg
d2UgY291bGQgZnJlZWx5IHJlbW92ZSB0aGlzIGVycm9yIG1lc3NhZ2UgYXMgd2VsbCwgaXQgbWF5
IG5laXRoZXIgYSBleGFjdCByZXNvbHV0aW9uDQpub3Igc29tZSBvbmUgd2lsbCB0YWtlIGNhcmUu
IEp1c3QgcmVwb3J0IHRoZSBlcnJvciBxZW11X3JkbWFfYWxsb2NfcGRfY3EoKSB0ZWxsIHVzLg0K
DQpBbnl3YXkNCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNv
bT4NCg0KDQo+ICAgICAgICAgICBnb3RvIGVycl9yZG1hX3NvdXJjZV9pbml0Ow0KPiAgICAgICB9

