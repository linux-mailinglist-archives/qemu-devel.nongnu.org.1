Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CE77B6B08
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qng2m-0008NH-IB; Tue, 03 Oct 2023 10:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=633394582=Niklas.Cassel@wdc.com>)
 id 1qng2k-0008N4-PL; Tue, 03 Oct 2023 10:06:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=633394582=Niklas.Cassel@wdc.com>)
 id 1qng2h-0002UI-HF; Tue, 03 Oct 2023 10:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1696341991; x=1727877991;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=H6o9luz24quWNZnAYnCKGmKRJDiwT3jE+22lZVdHhcs=;
 b=O0In/i+PeWr6GbNS3UXb8PJC9G1pu9gOCgTTHZ7ACsHN6ZXZrTvhQhdF
 R3ZNsobIYGLDQAQvuEVSayypmRoPrdgPl2tX0RGlYTp4sjCPsZ/IArtLT
 bZmuwgVyZRVPpUwp33RQ9A72rV2uoAHq1sOlKDqrH60KVBI6q8rVGdLr3
 eQjuvNahDw5xII3/uml0mIhtYbbVmsQ1+qlqSbmPCbKaAov+LIhOqP/dr
 G7/NdBPE2DuMvbGlLqGP8k0ydvOdiRDmwhZp4bAiicxEpjy5/SsUIQe+v
 Ctdo+GqmZsiYL5HTpMC9l8LbxHRXHedXNJPWVTsgw0gma5Q539D6ofVjm A==;
X-CSE-ConnectionGUID: DfUeElawRse4FBwnD3RTng==
X-CSE-MsgGUID: Q/5P2oNtQ2Ga/w5iPCIrjQ==
X-IronPort-AV: E=Sophos;i="6.03,197,1694707200"; d="scan'208";a="245542129"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 03 Oct 2023 22:06:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1L+J/IEKMT/u2Kzu/89rPWCqxrZB4RTHpzRM/6n1N5JMEN9KTXyIe0UMNJFwPRj8YzSDF5oWXN3Kt/um2+V58PwFUC3PKy/es3foVPGPPMZfvQEWgo1VvS6s2x439GrJNR1hT+ZPH2o18L1TEhzfGfeptdYpT7pvYLfnHsZBlA5tbWaZUW+WGBYMBjZ5BwnLsMZTU1Wu1ZY7YU7gajWC+Hz+Dd1w2yLHDmmiiD4/cBqRUcV6+Gbl+Ute4nE61uFSnimAq8YUwncMajQKb4yyt6ExyMYdOHJdRCfpx3PP1LMsZdn8D3fHobNb+U5MTHgk4s6/zlLeIfbFRWwR9RVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6o9luz24quWNZnAYnCKGmKRJDiwT3jE+22lZVdHhcs=;
 b=K67n8d27u8VgNcaevlikIG5lulg/udJUdwf3OxQIEa55MUfmmKzv0FQ6Fy82Moqpj3vAeIl/x74qk+Zf1mO99DA3c/VKBjWvM9amuBAfPfatI2bT3uCH50gz6a2e/XmM8oUkJ2N+shtZuwekeI77dfjV/CGOAFPbgXcfh4NHtAeUG4ND6dT8K/HwMJa3gRoELAtRHiy6/6KtdhojORso7j6hN8rX12psNeGdLi6L/DfWPZ+0ebxSKgn3+EHa+dkpcZkqo8l7EhDJIKHz+vTvZl2g96Hp3OzX1XUrqGnzmuYBUSjg8kRE61cKrGE5HgnobGx2PE6649WLLm6kkGee9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6o9luz24quWNZnAYnCKGmKRJDiwT3jE+22lZVdHhcs=;
 b=jOeky9gy4zPlQKgBDr5ysDn5ZFxZjIVEJdmAh5eVyVwHzdPXTfN5ZEa07g3K63egYw9ICxkcNdFwwLmgUI0wEhJskPUKSTCI7Tv3N3tVPvyBzGMAMIW1m7+lB4T+HmuMmQqksmMz0Xc8iFrfbIXOajCDcOY9meXfd86v3EEcHg4=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6582.namprd04.prod.outlook.com (2603:10b6:a03:1dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19; Tue, 3 Oct
 2023 14:06:24 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 14:06:23 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: John Snow <jsnow@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "f.ebner@proxmox.com" <f.ebner@proxmox.com>, Simon
 Rowe <simon.rowe@nutanix.com>, Felipe Franciosi <felipe@nutanix.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Topic: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
Thread-Index: AQHZ7+n99Oplvih8skSKfeZdFst1LbA4Jb8A
Date: Tue, 3 Oct 2023 14:06:23 +0000
Message-ID: <ZRwf3rInMRkzD/sq@x1-carbon>
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
In-Reply-To: <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6582:EE_
x-ms-office365-filtering-correlation-id: ea821345-a2d6-4dbc-ed71-08dbc419ed57
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ft8vmhqM8snVL73QgR8eXjXAHetXgPxnNU7G4DOaLaYYRJR4phx1d8VHNTh58PXGG7mt1Bp1b9oAvR+kNNzgudIromVDjSatFLK/vLA+1hdqSlV0rDymj4ujcRGsKBLHAGMSmhEZQKwURIuqXPbr8ZbYJpijzhXzEJ2BQoIK1Q6jX4kTsdL41bFk2y2hff2dtmqYzHQiRCg6SpXRi91cb7Q5eK97Yx53hlC+WhwCrA4dsRXIJaIL8MSCMv59eHmlwmbIzFgS4AyafKm+yqjuI9M0PYGwOZ6thmf4JaCxvImMg30qi7v0D1uRz8csPQCyCV/FWt9hT7K94xvlaCBLNuszi6InucOttLDRP/a7GJX5yYyxzg3alfslAoLoSYV0nfAbrZbG+rJVbvqZEh1Re7POA6qWvgkT7Jke0XfkDSoDAo3zv/HVWWhM6T6nUfZk5I/xcW/J1cJT9+DXTANXsO+vWxz0r6LERs0TVdgrhLmQfU1o76QK9Si//8+oYtPNkMUKoDPN/QJ7rQ2+BgrMvwqsBgmThqW/074dYq53T624kWiWVcL+IaXaslbdIz/ZO1rAY348UuXiFVOuFY5vT5YSVEGOU20IPknDraOe2p4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR04MB6272.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7916004)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(122000001)(66899024)(6512007)(9686003)(82960400001)(53546011)(6506007)(6486002)(26005)(8936002)(86362001)(8676002)(5660300002)(33716001)(2906002)(66556008)(6916009)(64756008)(54906003)(91956017)(66946007)(66476007)(76116006)(41300700001)(316002)(66446008)(4326008)(38070700005)(71200400001)(966005)(478600001)(83380400001)(38100700002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWJPQWF0cVV2ZWsvS3lJZVJicDMvUWdsaTI2VzNkenNMU2VCT05Xd2ZUS0NN?=
 =?utf-8?B?cFpRQ250ZzBlUjl4czM4OEZzd3VrNFpnL2tabTY1WWVIYjcyRGM4MnlxUE9D?=
 =?utf-8?B?UUpzcHVQSWFXcHdqdTB2ZUtnTnNWYXhCZnBGcEJWc1laZDZCMnFBay85WWxX?=
 =?utf-8?B?VHVzdG5kWVZTZElFOFpqblZhNSs5M0w0YnRSR09VV25ZdDZibjhMMXVFVHli?=
 =?utf-8?B?all2RnJtdVZMd3J0by9PejRaajM2NkdHdDJqOGRBYXNUaWdJWUlhaEFTaE1T?=
 =?utf-8?B?cTgxZTU5b0F3bUxmTlhLT2plMEs2RmwzTys2VjRSKzYzU0psTG5Yb1Mycmdt?=
 =?utf-8?B?TGs2OGw0TjJPY214YWxHRm11MElnSEpjT29OUzBmQTUzaWdzYlFZOTBzMFBl?=
 =?utf-8?B?ckZ3QVkvQWFUcncrYkZHcHBaTEgyOEE0M0NGTVBNZWZlL3NTY1pJcDltRFkr?=
 =?utf-8?B?bDM5SFgwSi9kS1NRQ3EwU0h6UGRwT2JMR0tPb3l5OFNwWWRNYkNxY3ZXWXpw?=
 =?utf-8?B?ZGVKaGFHMG83emNtK0FzWGVhdXBmTzlTZk9CUnRyT0w4a0MzQy9aSGNDVjN2?=
 =?utf-8?B?dklyUGxTeWJZTkFqeXp3K29ReEFqSGRDVkIvVVlsaUtFTHNnSHRzNHFNbW91?=
 =?utf-8?B?ODBXMnVMKy9Pd0tNVVZNc21QMDZkT1Zxa1UzeDVlNEZ3Mjd6bWp3czVqSDMv?=
 =?utf-8?B?aVQyRFc0RFJzR1R0ZC82Y0FYK1NIUTJVSGtEMUxDZmV3d0M5OFFHNC9pYklt?=
 =?utf-8?B?aGN3U2x0eTFZWTZzbzFBQ29XMEhKblI5dTJsT0dRMUVDcll0OVVwMXZ1R0dH?=
 =?utf-8?B?V3pXbWJRbzNRTGk4bk4wajBySnRjTXlZK0ZFM1BMNThhUTVVTGJVVUFNeHZC?=
 =?utf-8?B?RzY4SWRDWjQyanVrckx6NEZ1SzJEVytNZUNoZzNiTDV4WFRIQVU3VXhzM1dH?=
 =?utf-8?B?UVRKbXFnTVNuWUtpSWxCNW5sZ2l1TG9pZFBNL3FMeFJGOVpIYVh4Mm56eis1?=
 =?utf-8?B?c1VobVFZTnVJTmsvaUxHWG1BZ2crRWh3SDY5RDExZFJIODJwQjFwYTJ1KzRX?=
 =?utf-8?B?MGl1bVdQZ2RtcGx4Tm9DbzhYUjlhLzRtL0R2c3lBa2t6ZHVpM1RTYmxEdzEw?=
 =?utf-8?B?dFJQQlpPeURSQlQzNkNaR2phVTViTi9oYzR6S2JLSFQwUThpeDBGcTM0Wm9M?=
 =?utf-8?B?Y1dFQXhKdmJBMnB2bmtzUDVoazV5dUd5clY0eDVkY2VyekthUHg3N2ljYWR4?=
 =?utf-8?B?OTgreVozVFZEWXhvN3kxY05tVWhxT2RMVzdKczYxV3F5cFVkRzVrU21EN1k0?=
 =?utf-8?B?ME04TWh4czVwdXluSVZWNFp2amJFZ2QrRk0raW1hSCtSbTltUDFMN1JBa2N1?=
 =?utf-8?B?YVZXa2VnSjc5UXZGeXlIemFSYUwxTUF1L0t4QUFjc05mN3d3SGpSWGg4VUpN?=
 =?utf-8?B?KzFLZ1MwR0NhTi9HM05BeS9JQUlIMDYxdFZ4eG5YZW0xRER6eFNXVDdLY0Qx?=
 =?utf-8?B?S2wzZ09EV1l2TDR6WWF0WTNUUHViaFlOZW0zWGhYb25IMUdUWXVuZGlSeHlS?=
 =?utf-8?B?MCtGNEZ2U3lUUGtIcDQ0UUlJZ3ZzK1hwbXpNOTkxbGp2VldLWHlMN29xUWY5?=
 =?utf-8?B?Nm1oMUlqZmpTd1BqZlFIYnFTRW93NWg0NXVXczI1QTh5NjlVYi92Sld1TFZR?=
 =?utf-8?B?b24zbnA4TE9PT0JqRzJ2dyttZk1LYVBManp6b28rUW9OY0RzZ3FvYjhzU0Vr?=
 =?utf-8?B?eTNIUmhrc0J3eHVUYjhxUWhqc2wwdUZrbGtGaklHYUwyeFk1TDJRYzJmTEI2?=
 =?utf-8?B?QTQ1MC9jeFVvRGJicEV0WTI4b1FBNkZFRmxWdWV0ZWJCeHI3dVhsbFFYN0cv?=
 =?utf-8?B?RzU4SHpuV1VMaWhhRUNzRmlWM01haUJPeHlDRlpzWTRlYk1ldStqdmtxcGJp?=
 =?utf-8?B?RUdZekk3UE9TUTBMR0dXZGNIWGUwUDV6MHVnZlZoMXNNb1dRL1pmRzJTVUt1?=
 =?utf-8?B?WDZDcVE2ZHA5QnREMjRKaHJKeHNGK2tSYkVVRXpzN0kxenZpY3FJNEZPeEUw?=
 =?utf-8?B?azZ2ZGFhMlFiZEFtb2ZhM1Npd0dLd2swb0R6L1ZXeUtXd2RCZW9teFhNa1k0?=
 =?utf-8?B?STVQSUFmOWFseW01b1R3bGZ4QWdFemxCaGJLQTRmZHVjQWpRZUpHOUtTbEZS?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C2777E0EA32A647A2305EEF1A8A886C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zdokTgSO9p+0WChiokm42RYVT7B0EAioiKwbf3kjTjuXU3+Zb3ZfUT+xVg7u0UnggMivB53M7e6vm8y+5bd1b5DD8rly6AwZp7KR0Egyv+G/glyY62xxWL0DmgKR3Ely4thetJ18F9tUoKZCP/xYVSDWDI8DYvTpz8x5dW2v05ah3UKN7WG/ikca9UBVJvXSqBNBvzyr+DtTAiZLKbyn39GkwFOd/W+QrXGdkQvhw+YbbJBReP4mduVpYUNV0qCPfhc6reZUE1y4cK30UTnwQuY7goeYO41x2ucExBJJtYs8lWBrG897oLKw85gaWfvQ5sEpjSjwBUMfwL68cHCfuBERn9lp3Vy3rdGoxstXSow2WkVk8GbpBqS+P9KPv6BeGHDuPt4E8XW+s7bP8DPlDpXKLGO/5OFP1E1gjKKmVy0u8VchLD5GIxfvseJgNYio8xOY/JPatD3YfdDZuIdeKvYlIjw0CopJI7ebFGH6MW5v/uUkWHgPI4LsfDL1/pUAZ1TpeCJZiHRnTI7LxX6GVtWXFMjnwy+GezddAUa8FJh7vwPkwpPGLyrD4LUd4dezIjfhM7Cz7C5/NpfA0BbMRbqn9tWy0FyNbxbAYqKjH/y6HVTLXH5Dl9dreMUuaC68Qy+3wYfH+CzETR1GKRtKtV6k7rpq7v8NZp+GQDpk2ClSdeAKGMuetewfQ0ex4Tso9WU1tS0kCg8HPFQwmEzyObMS2guoaNb+hGL7Y5aHiHQf9zaCoeC1YTggE+j6DMdgGyxb26WbR05VQzvfX8cWid1OPwMcoFgTqV0djNpNnji6peatH56xdU6AxAxy7Muc4cnyJ6wLY+kbMnbkNkkREtZ0tdHAR7Y+T8t+efhbpj4=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea821345-a2d6-4dbc-ed71-08dbc419ed57
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 14:06:23.7773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22EWyjLAkRX7uaHx9+WZEiOyakHZrFFr19ILcLCaO3eqETAhEr8jf4syp9kxnE4UFszOmcZhHVB6dkLrz/tI7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6582
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=633394582=Niklas.Cassel@wdc.com; helo=esa5.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgMDM6NTM6MjNQTSAtMDQwMCwgSm9obiBTbm93IHdyb3Rl
Og0KPiBOaWtsYXMsIEknbSBzb3JyeSB0byBsZWFuIG9uIHlvdSBoZXJlIGEgbGl0dGxlIGJpdCAt
IFlvdSd2ZSBiZWVuDQo+IHdvcmtpbmcgb24gdGhlIFNBVEEgc2lkZSBvZiB0aGlzIGEgYml0IG1v
cmUgb2Z0ZW4sIGNhbiB5b3UgbGV0IG1lIGtub3cNCj4gaWYgeW91IHRoaW5rIHRoaXMgcGF0Y2gg
aXMgc2FmZT8NCg0KRldJVywgSSBwcmVmZXIgRmlvbmEncyBwYXRjaCBzZXJpZXMgd2hpY2ggY2Fs
bHMgYmxrX2Fpb19jYW5jZWwoKSBiZWZvcmUNCmNhbGxpbmcgaWRlX3Jlc2V0KCk6DQpodHRwczov
L2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjMwOTA2MTMwOTIyLjE0Mjg0NS0xLWYuZWJu
ZXJAcHJveG1veC5jb20vVC8jdQ0KDQpQYXRjaCAyLzIgYWxzbyBhZGRzIGEgcXRlc3Qgd2hpY2gg
ZmFpbHMgYmVmb3JlIHBhdGNoIDEvMiwgYW5kIHBhc3NlcyBhZnRlcg0KcGF0Y2ggMS8yLg0KDQoN
Cj4gDQo+IEknbSBub3QgaW1tZWRpYXRlbHkgc3VyZSB3aGF0IHRoZSBpbXBhY3Qgb2YgYXBwbHlp
bmcgaXQgaXMsIGJ1dCBJIGhhdmUNCj4gc29tZSBxdWVzdGlvbnMgYWJvdXQgaXQ6DQo+IA0KPiAo
MSkgV2hlbiBkb2VzIGlkZV9kbWFfY2IgZ2V0IGludm9rZWQgd2hlbiBEUlFfU1RBVCBpcyBzZXQg
YnV0IHRoZQ0KPiByZXR1cm4gY29kZSB3ZSB3ZXJlIHBhc3NlZCBpcyBub3QgPCAwLCBhbmQNCj4g
DQo+ICgyKSB3aGF0J3MgdGhlIGltcGFjdCBvZiBqdXN0ICpub3QqIGV4ZWN1dGluZyB0aGUgZW5k
LW9mLXRyYW5zZmVyDQo+IGJsb2NrIGhlcmU7IHdoYXQgaGFwcGVucyB0byB0aGUgc3RhdGUgbWFj
aGluZT8NCj4gDQo+IE9uIFRodSwgU2VwIDIxLCAyMDIzIGF0IDEyOjA34oCvUE0gU2ltb24gUm93
ZSA8c2ltb24ucm93ZUBudXRhbml4LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBXaGVuIGFuIElERSBj
b250cm9sbGVyIGlzIHJlc2V0LCBpdHMgaW50ZXJuYWwgc3RhdGUgaXMgYmVpbmcgY2xlYXJlZA0K
PiA+IGJlZm9yZSBhbnkgb3V0c3RhbmRpbmcgSS9PIGlzIGNhbmNlbGxlZC4gSWYgYSByZXNwb25z
ZSB0byBETUEgaXMNCj4gPiByZWNlaXZlZCBpbiB0aGlzIHdpbmRvdywgdGhlIGFpbyBjYWxsYmFj
ayB3aWxsIGluY29ycmVjdGx5IGNvbnRpbnVlDQo+ID4gd2l0aCB0aGUgbmV4dCBwYXJ0IG9mIHRo
ZSB0cmFuc2ZlciAobm93IHVzaW5nIHNlY3RvciAwIGZyb20NCj4gPiB0aGUgY2xlYXJlZCBjb250
cm9sbGVyIHN0YXRlKS4NCj4gDQo+IEV1Z2gsIHlpa2VzLiBJdCBmZWVscyBsaWtlIHdlIHNob3Vs
ZCBmaXggdGhlIGNhbmNlbGxhdGlvbiAuLi4gSSdtDQo+IHdvcnJpZWQgdGhhdCBpZiB3ZSd2ZSBy
ZXNldCB0aGUgc3RhdGUgbWFjaGluZSBhbmQgd2UgbmVlZCB0byBiYWlsIG9uIGENCj4gRE1BIGNh
bGxiYWNrIHRoYXQgdGhlIGhldXJpc3RpY3Mgd2UgdXNlIGZvciB0aGF0IHdpbGwgZXZlbnR1YWxs
eSBiZQ0KPiB3cm9uZywgdW5sZXNzIEkgYW0gbWlzdGFrZW4gYW5kIHRoaXMgaXMgdG90YWxseSBz
YWZlIGFuZCByZWxpYWJsZSBmb3INCj4gYSByZWFzb24gSSBkb24ndCBpbnR1aXRpdmVseSBzZWUg
cmlnaHQgYXdheS4NCj4gDQo+IFRob3VnaHRzPw0KDQpTaW5jZSBTaW1vbiBoYXMgYSByZWxpYWJs
ZSByZXByb2R1Y2VyLCBhbmQgaGFzIG9mZmVyZWQgdG8gdGVzdCBGaW9uYSdzIHBhdGNoLA0KcGVy
aGFwcyB3ZSBzaG91bGQgc2ltcGx5IHRha2UgaGltIHVwIG9uIHRoYXQgb2ZmZXIgOikNCg0KDQpL
aW5kIHJlZ2FyZHMsDQpOaWtsYXM=

