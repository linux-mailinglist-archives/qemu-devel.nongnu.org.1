Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B007F7A92DE
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:55:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFSm-00065h-6R; Thu, 21 Sep 2023 04:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFSj-00064m-0X
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:55:05 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFSZ-00059J-SF
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695286495; x=1726822495;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=FBWryWSghijw3cY+rwchB3fe197uXUmSizbLYqz7HhY=;
 b=FMHYkwUKmu0vucqiQpC2RLucJORCss9sbYEd4z9bm5OMMBtDekrPRnxt
 ngBtk/uLxdJE45GUZcIfEt7yBmQRonWQLB/qV9JXOC5+13g/UfJJpHUR5
 sw+GKLoLsfmF0tKCOtbsSexDVUBTsg+8iX6ffF1woutQUF7kLxR/vXH5J
 q4v/Xz50QGwQLNzXNPT3AkchVnVL3wUoYUPgS7iEpR5HP6UN44u7lSnJe
 KXEemQJ/W50XpPQU8u2TnlSPTvZUaJRghzK53HhITiz3SOFmVrMmriJcp
 OCho0Xves2zpxdEtmdm7zeWuMclAEmXqNH2Mk0rMaFx5hmnTN45fj8MLp w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="96562446"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="96562446"
Received: from mail-tycjpn01lp2172.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.172])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:54:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxlYdWaEec362RnEtrTotCAxRxaL0lHkekkIpQ1Ix/2hU+v57btgtw2dsGNuBbo/v8RCfDpRq64K+LqioG3nAJH0lrqKvMDoJm+SpzSM9h+VMg4EFSogpc3khXoeV+c6nyZ0eK4JOrzkwozyB1siR8BKFNRWiZJg9nRSfZoU31uiFmmTjiQPIGKpeTVxGZWkXqwVmfgsBNZVEyT11cpaALfJn7QIIPMgAiM41GkMAiGdVGarnJxN98fSbYO02NeIIteW7lQPekLH6PauSgYDZKwS9+7w9oxbuJYmtDnJgRrmRMCyifCi/oE6+GUl89Y+qSfA/6VBOXyg4TN4FJniuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBWryWSghijw3cY+rwchB3fe197uXUmSizbLYqz7HhY=;
 b=OOlkeib/JzKSW6wfY1kzDrH2I51QMx4b6qMedOiNcD9VWsfVOO02mYIVyssIIpK84p4GHXyauS7DIgi/BAZP0dZ+Fjz61/wgRhIBOAFDpJAwdLiPNfHWi9WdKRMrZuzr7b3+SfbsW1ua+Xl4//eO6JCSHj0oHAQPC0Yg48pYN9fpKBpCxxokjIgU/2XQQewU8oPlSOHoxLeLZ/th/iLE099cZMgPcwWWcFJPnXDvHCarVDuBeHMpPVCxHu0eAtvT6z9CjCDyJU5qSmXCokn51S73H6Jn1hTguAubyv8tQpKFF6DPK+fCR1YS2psPLsLubScQkkm/1TGakcc0SQi4Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS7PR01MB11978.jpnprd01.prod.outlook.com (2603:1096:604:23f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:54:50 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 08:54:50 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 04/52] migration/rdma: Drop fragile wr_id formatting
Thread-Topic: [PATCH 04/52] migration/rdma: Drop fragile wr_id formatting
Thread-Index: AQHZ6j862r6BU+AJWUun1WgxPGhaZbAk/g+A
Date: Thu, 21 Sep 2023 08:54:50 +0000
Message-ID: <ef436b66-793e-c546-9f30-9d28e17bd012@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-5-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-5-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS7PR01MB11978:EE_
x-ms-office365-filtering-correlation-id: a686ec85-3262-4d01-abc8-08dbba806a36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUSAj0SJ6QtcK8JGbx1sirO3fPDTZ5wtck4t7gg84PFLgKRaHQuoPLKry3uLH1Z9vZsGhK1Ksr6nxnz6Keur8Yf4jmVKmwU5UH/ANE2vbgx2GG3FdiYAHmN4TnT/93k+ndqpV4XT/y6TpBpq6N9yNNexP1ujLxoINGtKbDoplisyEkt7VsrIVrA02cvUVmdyzZ9jzABz+/gaHQ4Cz9ePphALf9ZImMOct4nKtoCCRT3OZf09Sj0nJ7ojZnOAZh/MQd3EAt0vwlOq/1Umj8cpDY3xNzIEn6IEiBKwjj/7arCuAtie6PfcLfWiss9cNLVxSzT1II1AK0/OXHhxRUKA1IGEfhdF+PUVPlkfZsai8lEP1h00/Bf/PD3G8k2zjWWcZceHzYxt2+BKAKCzPGf0XF3aUiNhd/W0Ain8atrkZkerqKy+CcxMUozD5cbV5HkZ/iPFhFhmHzyiBctxWwP4pxX89sDCzaidTWXIQaTEjsTb8JwkgbhEnOvMy8BVCFqo87uZM6XPFQ/TvcsrgAMqoY/7A5xufgXrjy8aiIYvLGb/sqM7TDaWUhwA5YWNEmbOHwOi1nEmfKppqfTPyyPwAVerzi2J8ls+TP6s0/1P9sJLJjQH6wdP80wpeECLIwSXo14cwd/gy/7yWq5cnMdyaj1qCaiFbwLhtoCkwAuPtsi+okuMARDvQ7UMx9mOoLB+zVeaCVfnd5QlNstSc2Adgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(451199024)(1800799009)(1590799021)(186009)(4744005)(5660300002)(2906002)(38100700002)(38070700005)(41300700001)(8676002)(4326008)(8936002)(76116006)(110136005)(316002)(82960400001)(66446008)(66476007)(66556008)(91956017)(54906003)(64756008)(31696002)(86362001)(36756003)(85182001)(66946007)(26005)(83380400001)(6512007)(2616005)(1580799018)(31686004)(6486002)(6506007)(53546011)(71200400001)(478600001)(122000001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nlh3Q3lXdHk4Ump4ZlNFelAzanlYZ1VBbDVNZ3VOUFFDTVZFemhaMjNwYkR6?=
 =?utf-8?B?K09McUlUMTYxRUpFYnZRYkdsLyt2dlk1TUJOK2ZFa3dxQWhJQTBkM1NjZ1pt?=
 =?utf-8?B?dFYzTGNCMEk2N2s4aThXak9jZlBOa3ozOTQ2VHo5aXQzVjlDQzB5ajJVWVR0?=
 =?utf-8?B?bDZrekpPWk00OUVPSmp3SG0vRTNBemd0MEh4QitWOERab3QvNlhTUEJ5S2hM?=
 =?utf-8?B?OCtBVXVVaVRrM3podi9ucWUzbnFXUjZUMGFYV0pmNStlYmtMaU1sbUIreHhh?=
 =?utf-8?B?TW9LUlNzYWg2SHhhRW1DbnIySlNKWUE2RkJaYzZzb2F2M3c0SnJKWHVHVFB5?=
 =?utf-8?B?dHZaT1h0Tms2dGpGTnovdzNRUTY3QTJKNWxYL1ljNnRua3pyYTYxdXFnSTZJ?=
 =?utf-8?B?WDgwVkRhV1FGRDBsSk9rdlc0alUxYjRkSVB4enV1WmpXS3BmM2dDVGlrQW95?=
 =?utf-8?B?QXZnM0RMUDZ5VzZjR2VOcXNxa0owZlFwWWw4eGt4NWdwRU1qenkwRERUY3NI?=
 =?utf-8?B?QmtaTXVad1dMK1BsRUk0UmFPdlNycmdsV3JkOEpzMVM3aUFlaFpQVjVlYVNq?=
 =?utf-8?B?RlB4WDMxSUQvem83V0ZoY2I4YkZBaGd1UjVPQ1ZIY3VuTDJCUzZoeWdwM2wz?=
 =?utf-8?B?ZjNyMmZkbEpnMUpMcjJqdTFsRkhGSkt5NW15bVZlSHhwSUZQRjRHWDRESGxU?=
 =?utf-8?B?RVkyYVc1MjRSNUlTM3IrM3gzaHRjWjRiL0N0RkNzdzIwNlU3S0ZGbUpvQWJ4?=
 =?utf-8?B?Nll3dGJmR2c3N1VTWVJ2ZG5mRWJnTHlDNE1VUkJwZmRiY0JaYlhTRE1VUkpG?=
 =?utf-8?B?MDIwWEI4ZWgvdm5lTHluSWhWUG94cnAwWi9IVnVJK1R0Qk1EWENhNWFQWm9U?=
 =?utf-8?B?dC9ZUGFmNXRZYk9NYnFvbEgxb1NpVEFOUFRDbkk5cU1JMHJlZ2N0dDlkcWND?=
 =?utf-8?B?emhsbEJudXJtWkdDU0t6M2FCUXJBR2FRV3R6eEx0UURzUnZDSmd3TWZhVTMw?=
 =?utf-8?B?eWlCdGs2NUwrNzVZcnk4bWF1cXB3VWxUdXVCeVQyNUk0cDJIbW05UlVJaDlV?=
 =?utf-8?B?SDdhdVorMGNpbFh5VVk3dTBIYkhYL3U5S1kwOVZKUTl0SlBDZ0lLRXNwTitX?=
 =?utf-8?B?M1d2aE5pS2NQMEdmZXVkZWF3Tlc4WmZFZEthSG8xc1NWQnA2UjBIa0o3VC9n?=
 =?utf-8?B?QXZ2cVZ2RjZVN2N0dG1ocUdLTzY5cXRJZTlENnY3MjEvVVRScTNzdEdKZmRS?=
 =?utf-8?B?RDlyTEdIUUlxRmVxdjlrOXF1LzJsQmpzRW9VaEcxYklPMUl4WE5ra3owbHdv?=
 =?utf-8?B?L2d1aWZEYjlKc0RoYjgzd3hFNm9WVkxaNEY3K2QrdkZadnlwdDFPSFRxclhP?=
 =?utf-8?B?aFM4MG9QbXRMYk9uSkZJbnRpOGJzRS9TUUJSSU1uYTBzLzh6a3A3c3IrNlhH?=
 =?utf-8?B?N0tNelN5UHc5SDhGdHprLy96YzE3VXA1eEN5Y2dXcTBZVlljUDNLSXNyWk5i?=
 =?utf-8?B?K09kT0t3ZSsybHF2cWdLaHBpWm9xMHVVK2NyZFpzdlVNR2JScHY4eXUzOCtH?=
 =?utf-8?B?VFZML2dHNzhIUXR4QWtYdm5KdmNYZm5SSkM1SVdWTEZCaTBGdGorYktmS2pr?=
 =?utf-8?B?bmxyanRTNjdLNGV5N3NQdTdXS240dVprZ1RQS2tOTE1nT2hiaFRWcmVrUGkv?=
 =?utf-8?B?Z2w4aEN6U3Q2MWVXeW5vODkyL09ZeDlhMFdQQ3pEM2d2K3B0M0ZGaHh6eTVX?=
 =?utf-8?B?VTc4R1FNQTM0c29WaHY5RjU1MndMNkVpUHpyUlN4ek10SjB4eDBwNDJkVGJh?=
 =?utf-8?B?c2o2REExUkhwaGFuMVpuZE5KaFdEL2Z5MHZ6alZmQnZhdlBydDBqZldvQ2dH?=
 =?utf-8?B?L3k3cFZ5Rk9oRFBLcHhtSGRwMHhmTWlzdzFXYm1JamlOQ2x3UC9vK3BHZ0ZP?=
 =?utf-8?B?TVN5UWRCU3U3NGNITUV4MkdDSFErRzVJVEtQTFBWTG1nZ3kya1JRRkZmWGNr?=
 =?utf-8?B?d2RlNnZlQ1RpaWo1VFlJM1U3c3A2L3RGcTNEdDZmS0xoejYwenlGQ3JGcWhG?=
 =?utf-8?B?Z2oxdjMxeHlXaWR3dVFhYW0rVlduT0l1ejRGNmN6SUxUS0RSSEM4VUh1T1dM?=
 =?utf-8?B?cEFMejcwMXFiYWlKME9yaEJIK01CMi83eWJ5TnlIZnJ6U1hJUG1wQTc2cHRN?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD495263E2AB744DB8E021852CE0DCC3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WMrpE3RIm9bV5BxwDpgyCCeGVrffu7fqvVCGZhB9sOxC3LPfsSF/RKP/JbG64yiZ/LjMUV91H7CK8R86GTD/UvRxA1szFiqxBccgp3U1H7UdPiPSiQ6G+XreXY5ANe5X1JnUYden1yn09BRx3UyFVGhZU5hRtAvDR9YBHBBnZNU3FYxSz4MDeLSWgDumdPQDozWO3lPegKMfSrwdF4aqzv9zQNralt1vaHfx/7tSFn2turXSIKmk6iS7UG9NDgRgskovKMTbFfkA+leB7YMwbvt3Js67cWWbh1ymiMVRz7tmCzW0Yh8JnwZ5Zq9GgR2xREAdmGbVH4ZsGAJZsEXgQpRMqd+jTCxr1VYTu+ZJxutuXJZ939WZK9eoHsbRA9LQ1+Qu6kj1htnkSr/R1itixaB8anHRE/Gnirui+MzzQMqBI1KMjbFpA1g22EBsLk2yImc3D3fuZnYgy88My0BhCQZfrz1FxvAYXo85k4O/SNHc8XjO2KvNa4wG+yXtr/etcpz5e5XqeiigpOVg2lVWAZ+xodEN3AugstA3HwXfsP5XBhLNhw19tduRdMa9jKktgXCH+/JybUB/S62XIHzh5Rj1HBS0wd9nQtMXIqp4v/K6Sf8jXUYrnBhH9B0NNmU04XODqlrH9Rz/LSX16zFURaplsaqwQTq7fVQJ2v9sY4h1X+3iqseh+adcmnYdPaYTJ/xWuLwc0f6iFsE90zGR+JAhuZ7SRRLX0yos5cETRKyu5nagAWSSE31WN93NndeapM7Sl+eIoMkKr3rw0pHZDfH4C/WSbptP2of7tH8J6ro=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a686ec85-3262-4d01-abc8-08dbba806a36
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 08:54:50.3062 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYap+QUE36nTLHsqtkK8Jj1NwyWQJWW99yWDmqTnuhzAp1i1meN7+75kQ0+0zR6D6SNPMnPNKh9szcF37XV3Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11978
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiB3cmlk
X2Rlc2NbXSB1c2VzIDQwMDEgcG9pbnRlcnMgdG8gbWFwIGZvdXIgaW50ZWdlciB2YWx1ZXMgdG8g
c3RyaW5ncy4NCj4gDQo+IHByaW50X3dyaWQoKSBhY2Nlc3NlcyB3cmlkX2Rlc2NbXSBvdXQgb2Yg
Ym91bmRzIHdoZW4gcGFzc2VkIGEgbmVnYXRpdmUNCj4gYXJndW1lbnQuICBJdCByZXR1cm5zIG51
bGwgZm9yIHZhbHVlcyAyLi4xOTk5IGFuZCAyMDAxLi4zOTk5Lg0KPiANCj4gcWVtdV9yZG1hX3Bv
bGwoKSBhbmQgcWVtdV9yZG1hX2Jsb2NrX2Zvcl93cmlkKCkgcHJpbnQgd3JpZF9kZXNjW3dyX2lk
XQ0KPiBhbmQgcGFzc2VzIHByaW50X3dyaWQod3JfaWQpIHRvIHRyYWNlcG9pbnRzLiAgQ291bGQg
Y29uY2VpdmFibHkgY3Jhc2gNCj4gdHJ5aW5nIHRvIGZvcm1hdCBhIG51bGwgc3RyaW5nLiAgSSBi
ZWxpZXZlIGFjY2VzcyBvdXQgb2YgYm91bmRzIGlzIG5vdA0KPiBwb3NzaWJsZS4NCj4gDQo+IE5v
dCB3b3J0aCBjbGVhbmluZyB1cC4gIER1bWIgZG93biB0byBzaG93IGp1c3QgbnVtZXJpYyB3cl9p
ZC4NCg0KWWVhaCwgYSBudW1lcmljIHdyX2lkIGlzIGVub3VnaA0KDQoNCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1i
eTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

