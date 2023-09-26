Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3367AE56D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:00:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql17K-0007S4-1D; Tue, 26 Sep 2023 02:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql17H-0007Rp-Sq
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:00:16 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql17F-0000yt-0m
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695708013; x=1727244013;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=MPZX35D4qrNc7wkcHFK05HK337zf/CCCz7p8cB7OQhY=;
 b=c1zs35sjBliUf/wgHpkcWh32C9gcKsS6DZaVnccpK64eqMW5z4qN89Ls
 yJg7W+Ac6E4MvF9jMZ8qOl89qQxiukh/7qDIOcCMihDrX4hjGWH5Q0yim
 TNib8s6RpSQUg3yjZbb2Pw9VOlqZTNG9ySODJc6lNKWwQLMeaPoabxDV6
 9p2sDyrxpSX+zDelNnNSJGe6XE4gPuSAklXas/1bXthmcuHIK61ioUz5J
 VE0TNhdTWrQ/lMejop5oN5VpN6PqhmhfiC4RL/C5BBiaH0Ef0KaNd4wuy
 kdOfgEoHxxjM+cC5uvGRp0Uzy/RPDfsXN5xAofH7hyrJ/XV7SykmFA22+ w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="7738481"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; 
   d="scan'208";a="7738481"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:00:09 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LksDGPQkzn13ZbLjrTGulWJzLXRlswGFuVZhitB9pPgHACYrTLaf3Wy9AbZzfx86xQkUDIUt/G9dPhj58D6kdaf9LJUtcuwZxCExbne/VyWowTGHL0LuVDKKSxY1NchqXlcC/ifUjPPFxDX+RuyAS5+oOrQL/JdoAqgav7G9fYGUJ0i0s9HoCBgHDjX/jEWVS/znnt3RzRbype3Hxhs1gCtL5uhnAfJD0JWpls5Q5OjslbTxEeZwY43c1gNeDUFmXc0aFSXtl+RKkFMRn3mqWyYrh3WrFyXtlJDyXZsy/+TXa/1uhwGwq6IXOiDCFSJ8c5onrXWqIpa/qXl07A+rnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPZX35D4qrNc7wkcHFK05HK337zf/CCCz7p8cB7OQhY=;
 b=SvjdBgyScc7SkxA/unYjs3ExmtPcOjHwkBGwdtROB/qVLCyf8XbiB9Kc9qQd4i3aBwf4WfScqJUu/RXJtFt3567RrSpEBxf4tirlv1GFRxvCpHTeo8dGGy+ZfkKCUdHZ5043rRRUJZHYFLfalew4eVi7P2Om4wAQqP2dKzjjxWKSNDIJ7uBHCN64i3ivXNoYaSQmOvTzRagQQMv1Ee40ZkyTkqQDxve0oxpbpqAoqNazkmlK24pWDn+DZMOZSl4L/ycxXRbcZCaYa7ZC7wX+oFz8v8RDNwMnYWMrOd2tE+wict0P4TRDxzGQG5i5jie2oiMNIj7I3dxO7Ia3g4fNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB9728.jpnprd01.prod.outlook.com (2603:1096:400:22a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:00:05 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:00:05 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 45/52] migration/rdma: Silence qemu_rdma_connect()
Thread-Topic: [PATCH 45/52] migration/rdma: Silence qemu_rdma_connect()
Thread-Index: AQHZ6j9btQ6hO5kmEkqglPlOynJDibAsqOQA
Date: Tue, 26 Sep 2023 06:00:05 +0000
Message-ID: <954ebf5f-ac6b-bed0-ec46-c686717ff373@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-46-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-46-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB9728:EE_
x-ms-office365-filtering-correlation-id: b22dd11e-703c-427d-69e8-08dbbe55d4e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijTirehd6Ij7KhZyc+lvyFP39G+gLuzDu3wqmo+BtT2KTVB+gzWW89kUUoSlEahwmpGch5Y2+L2cjeSwC5zQigU0MX7pwoV1G/Hzuew4j3ZtNV1NTxsCEuhL4zErgFGKaGv5ogaikzmq85wkNQi2wIQnkBqp1lqsb7clnAUQidTOYW8HN++05IIecpBfwQ+uEaDEZ1aljjYsDJHZ36RFbuOOCBOwbrmlvvvK6N8f6UXLiNKZp4a+0Wt7Zk5qgcE6c9XB0fzSXC1LlnDpbq9nFtuOJxfJOSCSkJ5wkYHgdhOYtmPN3gvEzqLLiqfGu48OmpR5MZE105EXODImo9k/aIVyOD1eqxVHjPNQRNqhcEGv7NsLH/15d/70X0HTtgCfjXWn5xQqhhGh8E73hvHkrFyaSgWLOIK66JFaB+XH2eE/0+BWJ64TmsSVL/pRnkBoa/H+jsKFBTeD5Jtk00KkIya1W4G95QWhelonXh1CItZPj9qIE8F3ZJJ2DMlVKBvFofdbzEQQjPGzrR76fuAEcVNSkSXJ2uk20JPhvMgX8tyum91g6zK5m27xfGGaU38+Dn1oowF/4KWGQJkZzeahPj9iRHpZj6GmphXIMPg/W3ByqR0WWNc7FNrVlPU0mXCujs2N+MraM/LNa9FwYGOuYpcsNG8gtr2s7Z4loI0WVtIisxCaTwTaA8i0gBmhPKs1SPCNPznuFcYNnKjb9UC1Fw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(36756003)(122000001)(38100700002)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(76116006)(53546011)(6512007)(5660300002)(66476007)(2906002)(2616005)(4744005)(478600001)(41300700001)(316002)(66556008)(66446008)(54906003)(64756008)(91956017)(110136005)(66946007)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dElhMEErNFRiL0dEdkh3ODF1SnZWTTAzZ3EzVG1XV0hLanFWNWtqeXR2Unhh?=
 =?utf-8?B?ejB4cXE0eU5Ob0tJZTl1VEVhblpxVnJDWG5MRUo0bHFET1FFV1hNODNmNDJ6?=
 =?utf-8?B?NExXcWE5ZWM4L3F6YVRwSnlRVmN4ZlJEZnlPZUZtazYwVHFDM0JZTEgvOS9W?=
 =?utf-8?B?bGRoWGxFZERpYUJTRFVSbTZ5STdvS2F5aE5YZmxlT2VsVVVsYmNGQjVsMjJX?=
 =?utf-8?B?MlhJcGRFckJjRUMvdTdtNHl0YzhHNENWMnRabWlyWUU2WGttWHppaUowTytt?=
 =?utf-8?B?UUptanNabTBuZE9KeGxRR1d6dkhSVjIxYnFFRU9ub1lSOXNDVWc2Ynh4QlBC?=
 =?utf-8?B?TWFjZzRYdklFZEcwYWFWU0FyRXpKTGdxWG9oV2pvUHdoOWJ3b2g1bnhNRXJl?=
 =?utf-8?B?cXFqYlZ5Zm43ZldTMldTYlgwQjhwcVNPL1BkWktsQ0huYVZibldOTWV4L1lp?=
 =?utf-8?B?bDVyQTdLNGxqZisvdW5ncmtTaVZhNlo2eTUzelo0Yi9Xa0UxOHdmVjBCeGdk?=
 =?utf-8?B?eFRYemhLVGJRVkd5dy9iSzlXc3NvdTNoTmkvOXBueFhRTnRRMkcyczh1bmNx?=
 =?utf-8?B?eVVTSjJEME9vaGJiZ0pqMUViRU5pWU5rWGVxN05IUDhaZHBGbUpFMHJubFpF?=
 =?utf-8?B?RzZwL3BWeW5aYWwrb2duZHJQUnJJZ2VGdlVsc29la2UwVSs4N1dUeHh4T0NS?=
 =?utf-8?B?ZU45ZEJjck12UUxTM3ZqZW1zTjQydWVxZWEzOXExSTZNaFMwbjJBMi8yNFcw?=
 =?utf-8?B?c1FGekJINkkrb0l6WGF1RWZPMENhWlhqTUJlVnQ0bHRYS0FoSGg1OUU4RXYz?=
 =?utf-8?B?bUtBbU9BbnVtWXJiK2JqT0RES1hTZis3S0F3Z1V4VWwvYncvVnJJU3ZVeE1n?=
 =?utf-8?B?MFJhU1JBbTFkWEZ1TVJKMUN6UGJhMUtzTy9CVmxtcDhVUnlZeEtPM2Jwb1hO?=
 =?utf-8?B?OFk3ZmdqU29BUTZCYjNmcW5XMjRPT05oNGVQWWt5bGsxZXM3WGFmQzN0b1Jn?=
 =?utf-8?B?WlFzcmpPak9IUm1rUmUvdFNXMGdUSVlLazY3TjhNYTVzTnYvcWVSYUpxT3A3?=
 =?utf-8?B?S3Ywa09oTnpLSmU5dFNVY2hFZXRMem1lZm0yQVEwM1VGSTl3ekNtK054aGFD?=
 =?utf-8?B?cmtEV3hmcnFNM0pPRVV2VjZWd2lqdkRSUWNFUGlsejdmR1RXcmR2N1J2K09T?=
 =?utf-8?B?UFBXcjM4anJUOHVpY1czZUJIVFlNOEIzSkQyblpSREJGRE96ZG9peDBWQUZi?=
 =?utf-8?B?aW5ReWR5UktaTEFmZzFKS3AzZzloaFFobDhLbjM5YjZ5VTFjeStBamd4TmJ2?=
 =?utf-8?B?bzdWOXJubkJQeit1ODQ5NU5TS3MvTlAzQ2tqVlVPVmhXNzJZQmp3T0FWZXY1?=
 =?utf-8?B?T24wcUx2ekJUWXZmcXQ1Q05nb25VMWNGTDBhVnJxd3dMaHI0YTYwT0I4b0to?=
 =?utf-8?B?b2tDbXpxMFBGVzVMSCt5UXNYdXhBeURJNkFRZ0FraUFMMzlTbWdQWmJYTUFk?=
 =?utf-8?B?Q0dnOUhabGlJbVJ6cytseXY1MFFaeVdSQk9ManJ6ZDAvUnUzekxjczVPYnBV?=
 =?utf-8?B?L1RpOVp4UkNFQThVaEs0MUt6b1JFYUNIeFlEUjNaYm5lOU0zeTI2bkYvdHAy?=
 =?utf-8?B?Z3AvYmxxMGpHL2FGK05MYkxiL0wzRE16TjN3MlRoOG1ERWY2Z2ZCdzhCelJR?=
 =?utf-8?B?aUZOamtUWWJPcjB0U0h1dHVOcmVWNzQzMHlhSG84enNtUE12cTU1cU01Ylhy?=
 =?utf-8?B?YzduTXZwSG1ieXdjOXhqdEFIdVZrSmdVVkx1M2pzRklJd1FOa1h6enJuMEFo?=
 =?utf-8?B?dC82VzVJT042YmVvc0MvZVdTYStMU01FNnRabEFTWFI0NXZhdi9pUUpLY3dN?=
 =?utf-8?B?ays3UVV3NkZydEJoTmJlQjVJdW5qYjBHemhWbWxFUnRianE2NTdGUlpEL3FW?=
 =?utf-8?B?V3FzbHU5WUU3eVJKK0RzSW14WVlTWjB0b1JmVHdoVG9hZXp6T0U3eWtTSStn?=
 =?utf-8?B?emhxM3htZGJGMG1VMTBLTUJETkpuVG5WenAzNzQ4Z3kxVlBjSjZuZzFXYUFE?=
 =?utf-8?B?ejhPMEVKc3g5eHcvOE05TGU2WUNwbDBGNEhoMXBqWmJUc21lUC94Tnl4d2Uw?=
 =?utf-8?B?MmlZVXpTNkxsVjB0Yk1jMjdXRVpyWEdPUnpiZFJwblJ4QkRYZTBQWGZhOG1P?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AA87472E4BF4E4293741FBC3CAFCDFA@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: GnClXmTYA/9wQ5/Y1iMpBhOKVVgwFJac+WNRWf1vGdrVT2uhOIF2rjjzMf15ie+zd7cXNmUkmVeK+tn3nhN2/UHcsr/7/gogTRT/88u0/Q8ixzAZUFRACqWOdK9prnSjkVFsIveh+WrsTjWIXhMxU8BWQT51gOu5Ij/O7dffeI8qhKTbBvUhpEFvGkUmJxg12WlI+SrXs0ToCq3WQ1GPT3JRIHx36rxqlez+pnl0sWWmyCk/YMtZkoU+Y1PD9uHVgdT80x3HiOwO2+GGmgOuZkLvDeYPa2sbSSx93+R4Mkpztfevw8Aakr+S2WvnIDmypMa+u/Gfjm/PVQczO4BvQX2F2X4QhJp43Qk8+l5Vi4xjAPvDikiFyI1L1IK5dYCQU54S0jWzVjeXxCWOy5b++az9L3oHPzaZ3D8tIdc4VEVCA/ryIJKmYY4mr/1jPzta2MqupQuMhK5JbBDWbhBOjPIKN1HASmWMv9amQYnSh6F4mDJUQux8sslNxb/vy3QiIqRbZ9OBNXvXCW48qYoLRNzcyB2q1VTSbm+EjYaIsv7zNXIi4RuppwH3Rzw6S63tyXRUP8gcNQKK11k1iLAvkpF/GKWUyhaCU+V56dHfl3IwxGl/Wej5rEIUxac6qiS3zCu59+4EHNnsKPuMY68QgjR4a66bm+3iHPWDkLlmeY2aUqzmy6hQugc56dL4HtP/L6Dxj0mfAZ7jChe7LeHwY7JF/5vR4N20ojRpoSNweL0RYq+vSkMMd3P1SRQaDQS+kfM0XbAyDJdxCsiApn+OzeSkn7pJ3hY7OTyksHP9uBM=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b22dd11e-703c-427d-69e8-08dbbe55d4e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:00:05.6170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qyZIrrtdY/tC5Q/S6fb99z0pOpDtSdg7M056mm/LUkl3pa8VVNMZa/pW4Dqv8IsVX0vFyUJHW/YxgvRDB1SbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9728
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
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
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfY29ubmVjdCgpIHZp
b2xhdGVzIHRoaXMgcHJpbmNpcGxlOiBpdCBjYWxscyBlcnJvcl9yZXBvcnQoKQ0KPiBhbmQgcGVy
cm9yKCkuICBJIGVsZWN0ZWQgbm90IHRvIGludmVzdGlnYXRlIGhvdyBjYWxsZXJzIGhhbmRsZSB0
aGUNCj4gZXJyb3IsIGkuZS4gcHJlY2lzZSBpbXBhY3QgaXMgbm90IGtub3duLg0KPiANCj4gQ2xl
YW4gdGhpcyB1cDogcmVwbGFjZSBwZXJyb3IoKSBieSBjaGFuZ2luZyBlcnJvcl9zZXRnKCkgdG8N
Cj4gZXJyb3Jfc2V0Z19lcnJubygpLCBhbmQgZHJvcCBlcnJvcl9yZXBvcnQoKS4gIEkgYmVsaWV2
ZSB0aGUgY2FsbGVycycNCj4gZXJyb3IgcmVwb3J0cyBzdWZmaWNlIHRoZW4uICBJZiB0aGV5IGRv
bid0LCB3ZSBuZWVkIHRvIGNvbnZlcnQgdG8NCj4gRXJyb3IgaW5zdGVhZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdl
ZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

