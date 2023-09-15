Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9466C7A143C
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 05:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgzHB-0006bP-Kn; Thu, 14 Sep 2023 23:13:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qgzH9-0006bD-24
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 23:13:47 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qgzH6-0007PM-IN
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 23:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1694747624; x=1726283624;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=pdAu6a5AVRFGHAQLwiP39PrD8lvc0WuuLLpgssjY0pI=;
 b=YhVyIawFQXoWDq8R+LOOBypGgKvKV42WSTfeUazeUSgSRqqP9amgNdSI
 0QxADowyUSKPCzXqAgJxUVnqx+RkQ12MCBaxgkgP+YH4KbOEXKgSRoQPk
 3jOJak5G+Tn+doIUq7rkF7xcGojv/AkgkDB+Pja9OI7/Jtf2OGXZnnYL1
 Gi43iPegCA5joZ3Zljp3yVI5RTSs4XVIH0CxrfKOLR3tUbIDZBzth5qcj
 /THJbqtheLhnA6aaqgo+ayG2XyAG6RcV4AGMh6ZWQhDP25EMHLkuIZsf9
 9k4N1NPgGusO/L2T1mTYY2ncvHdiJK3h9F/l64CbL9ANtjxCnejdYMMAB Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="6463959"
X-IronPort-AV: E=Sophos;i="6.02,147,1688396400"; 
   d="scan'208";a="6463959"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2023 12:13:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8EkkonaPQnTkUyKhHWTCQ2iaNpJvnhBjZdIQjbIGArNEJIqQ+GlT7qWMb2tI7+1JJVd1ohpthD5CiuHDOJMweMAn/gr0cNds6i/QvbTEwSn+9Ihv98wx/DWZAAPx5NDHOLhH1U3Oo8KB34CqM4EehKauzCe7w+mqxTpL1hZg7sV3IAk5raXGJph2OXg4MaUB1KnDmD1UZxaH7DYrTfoCbYVRwTrRTPyNIjTd4gHlOYsjYlrW8hPAFiPT9zmOq97FJXWlQ5PoV8r/xuGuZ5AJWiYR4xfmbx/8ZJBCES3rlOlm6RufVXGzVmQY1ArS0Jjf4vGvLDbkWOix2HUn1VzzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdAu6a5AVRFGHAQLwiP39PrD8lvc0WuuLLpgssjY0pI=;
 b=PeqDy2IsUpq2adYn/Tfjd9ox3zJiWYulN1R1MJ2h4BKW/ts9L6i2uO+QoXNobaKT0DvdiKjDLY5fwgoufW+rvXvY1Pi7k7bDRCyPHBRP4KnLWwUK6sY/0A73JHy2+N14osENW7wTemIxkxpRRHREDn7YGP67YOXXD/JDOFz88VCPQcGwQINwFjWIJ6rBq2HvokMACXJ3LdLpyKTzt60ofnuhgg7G3kYu6GzTwkynXy8PqIXPFGAWkyZBEreBC9AFLaGIXup4Zl6xIbzMCGbT2d7LTrBswafZAMIZl2Go6JlMGJ2WHWDcG52kTRPVc/eQWKV0KnuuazSmFT5tbZRh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSRPR01MB11596.jpnprd01.prod.outlook.com (2603:1096:604:22d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:13:22 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 03:13:21 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: =?utf-8?B?4oCcV2lsbGlhbSBSb2NoZQ==?= <william.roche@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "peterx@redhat.com"
 <peterx@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Thread-Topic: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Thread-Index: AQHZ50kkGtrj55L5RUGhi5iQm46XLbAbNpUA
Date: Fri, 15 Sep 2023 03:13:21 +0000
Message-ID: <60d3efa1-d2eb-8e11-8909-eb1ef33204c5@fujitsu.com>
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
 <20230914202054.3551250-2-william.roche@oracle.com>
In-Reply-To: <20230914202054.3551250-2-william.roche@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSRPR01MB11596:EE_
x-ms-office365-filtering-correlation-id: 0b550d7a-b664-465a-4da9-08dbb599b7ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsQg6j5RcsNbVPFdBePj+zNqMlHuj/7vGIqxlF0I0pkXj+hyliHUjb4a20LpOrNw0v96Y8UZQ9UrmbeHBknHE0hiy0LNHpDXjMoSZyrRBTzEH11asbxkuAOBrWPn69ZmxF3NkrcyK7XIeYkweLbvSgRbvIrLUqkrWy4BSf+WLy/gqKEQ1LsmY+AEy7axcAufkd6+8xQkVXVkMAzDjLd8wK6dI4hGT1mkpocFCv2OsiRb/rrd5ahLTNeCgEfzfaX+EtHLFEN+1t+HvOtOkD83jE7+1IKICBgRpe1n/kLZEJWFU+L6GfVroIZxm/DtDiZwXQfzBKr+7VbGLza78dIh2tED3hoqvkhKL48YK62Ae6W8IWAC1AZFEOGuJlYeaMuCGWSL2OtNwBM2OHScSgnGzo5bFeQdDg1SupuKtSCwSiP6iemAa8HO8kEtnHBJBAWNqJdmQixhXfB8lT9EHu1+7rgcXTA7KwoZth4tljwDRKQWngSzNej/qO+qF1sY1s7YQf/QSnyY1tU8cPbjBdzO2f0tOk+3bXn3fftXf1C81q5dNEz/IVNEfYiHw2dTaDFQ6PcdkPYiR2qdUg2wwOHaUzxm0UbfQxdrReLRpF2yRMyIBstsBQ3M0zGuRn9ypgA5+x10EJCjJGri+345XtNYL3drppbxk584RArrJo2b+BnBWwCMoEAZRGN4wWShqXn9yAQWCoUy0D7/YhmQBR5m5g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(366004)(346002)(396003)(1800799009)(1590799021)(186009)(451199024)(1580799018)(31696002)(2906002)(86362001)(6512007)(53546011)(2616005)(26005)(36756003)(478600001)(85182001)(6486002)(71200400001)(6506007)(82960400001)(38070700005)(83380400001)(38100700002)(122000001)(41300700001)(66446008)(5660300002)(31686004)(4326008)(8676002)(8936002)(316002)(91956017)(54906003)(64756008)(66476007)(66556008)(66946007)(76116006)(110136005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkxmdXBEZHlaOFRsOHZhdGVNWHNPY2tiYTFBeVFHcVh6ZzZpbHhFT1p5SmZ6?=
 =?utf-8?B?NXlhMmxyYWEzTm9Hc1crTGR4Wk0wRVJQS1JTKzlka09Gc2x1NUV0ZmpkU3JU?=
 =?utf-8?B?aElkQ2NJUVg3VnE4dGNnZWNsUThhcGFBaFBDanNrNkM4dVdCRkNhczVuZDJy?=
 =?utf-8?B?QnNFSU0zaFoxamdwVTF0TzN5djFwam1OZlVSVjVIaW5TVjUxRnk4UyticHYw?=
 =?utf-8?B?WDZhSldJNGhFbUU4L1FTelk2VVZhRG1ib3JKeGpHN09VeFJ0UnJBaWt5MG8x?=
 =?utf-8?B?ejFxcEkvdjdTb1hzSUFocDVOUkJVZlNuY1BiczRNVzRGbEpZeTYySVd6UVlF?=
 =?utf-8?B?cUJ1dGtFa3Z3aDNoTWFOdFQ4QTRsK01IbnN0L1VVNmF2VGZneWV0bGtzcHkz?=
 =?utf-8?B?dDRmS2FUSnc4bkp4SGZqU0VORzdLWXBxamVBUDgwdFZRc3NrbzE3V0RrVGQ3?=
 =?utf-8?B?eXh0VTg4RDI4b214ZGF1WWEvUUZYOWtmR0gvNkNPNjVReDdtYmZ6QkFrTm5Y?=
 =?utf-8?B?aUNVVzJYTWFyUk51eDcvRi9Td3hHWFhaelFrb3FoRE00RWZTVWJlNzBISXZB?=
 =?utf-8?B?VW9lVzhiRUdPK3dBV3hKQU1sZHJ3cndBdGcvWDU5MDlLVC9sQmZyZExIcmtV?=
 =?utf-8?B?dXpKRUVITS9lSlpBa3AvanRoQnoxQVJxR3JpMU1nUVd1ckRXRnJrT25CcG80?=
 =?utf-8?B?QlUrMU9LQUZDRWJOd2JyVVpjdXFVdXNjWEtsWkx1RjI2b2d0dVFCNGo1Vk0y?=
 =?utf-8?B?eWpFUzZZcUpBUUNwOUlhYmVqejJwUmVHcWRGeHFnK3pjSTgzUE1EZ1dEV3JC?=
 =?utf-8?B?QUpXWXdqSWwzY1UrMmxQSk9odXp6WENmdDFqT0ZkMXc2R2tSVU5aTEYxbWIx?=
 =?utf-8?B?eVNLUnNQMTF2amxZY2pTcEl3R2t5VHlkWEZlbU1hWUJmSkR2NGJoc1V4Q09J?=
 =?utf-8?B?QkR4WDNxbXhaN0o3cUdKQThaZU9kNEF1V0g4azVwRlg3eldOQUhlb2l3QjN5?=
 =?utf-8?B?THRZb1ZVK3l6bWJmelJ1bVBvSjNYdlpiQlVlNGlRVk9kd0F6a21pbFM4TGFy?=
 =?utf-8?B?THlsa2Y4MlA3cTdRZVBTckV1djJEb1dxcjNpZE5WSGpodlBNWE9UcTVIYzc3?=
 =?utf-8?B?NXBTcmdlYWVENXN3alYra3o4NkdtV05BNkVoT01TMmE2TS8ydUJZaStiekZz?=
 =?utf-8?B?OEFmMmhpZXh1SDY5ZkVPN201Wm83UGhnbjA0Z1p5ZmJCNWhaYTd2Ymtjcm5j?=
 =?utf-8?B?UmJmSERCK085L2tMNWxQWVY2UmNWNVVqK2dFLzhHZlBzYWNXUDFsMEhBbVlX?=
 =?utf-8?B?Mm9tT0dzOVBrQ2FSMVhrRXlVV2t1YjB3ZjJiV3N0eEY4TUpCVVRCUis4dWg1?=
 =?utf-8?B?aE8rWGVTemYyQ21ncXRick8xS1dTR2hGN012NzZsb2xBMWNrOUo4aXppc1ow?=
 =?utf-8?B?MEVUNnNVL2dBRWU3ZXMwcWpsOUVzWmdDUmc1YW1tVGpiM1BIb2lzbnVESGRi?=
 =?utf-8?B?bGgvV3RuVFdQVWp5azNMcGUrZFVpcGlOOTNnVVhCOEx2ZGJ4Q1BGUTNyb1o5?=
 =?utf-8?B?M0FsN2t1U3BRcEVLSkdpNWtNOUFrbW05T1ZVTU5PVEd4TDNWQkY2VCtWVUtp?=
 =?utf-8?B?eWQxSmoxWGhtaERXZWJLYjAyUERqTWZLRXFJSWlaSTRyTC9FVkNUY2ZxV3NX?=
 =?utf-8?B?THJHcVIrSDBmVWJ5SFBNTlVHalN0a21hTUlnOWI5dUk2em1OMkJHNDJLNUdm?=
 =?utf-8?B?UDVWRlJzZnVVRGhvbkxrSHRUMGV6SGJGRko4ZjBENlhmSnpZMFMrdGNhSWor?=
 =?utf-8?B?K3ZoOURzUVUwbVFzZUJVaGNyeFZSY3BWeUR5Yk9lSk9aS29CN1RVRjU1YllD?=
 =?utf-8?B?ZXRLenRSQTVFRFBpSlA4MUc3Tnl4aVYyS0lPWS9QOVNqRENDalFsY2ptNWJk?=
 =?utf-8?B?M0RpazlLdm96S3VEYkZxMGtKTlUvRTljRUYrLy9FK0haN0FqWjVJQ3RDNWo0?=
 =?utf-8?B?Mng0S2tMZjd5NS9jdmFxbWpGM2xBeWdERmhGRGwzQXNETGJKUzdRekh3NTB3?=
 =?utf-8?B?K1M0TEt3akNoL1BVMlptTTJDRGVBM2xUQXJaQ1RjK2FvSDFEYmNUMWZZc0RD?=
 =?utf-8?B?alRjb0Via29pZHZCTjkzTjZMSkhQR3JaZGR5Vjl4Q0xPYS93YkxxM2ozKytk?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <224E4DE315B0C54586F6B15672C9011B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ASjvrkhSmYeEbDQmZqsScENV4jGcoRsAA5gKkV029s5mOHHryhhNZqW0ZES2tTColSS6XMbwh/MApJr2CBEKC4QLJPNCQ82Fo4SwKpCYuc6+QVerQkkBtqU3/9xNdJIi2uCcR5th+I/8CQUBmrHCUV1nfbKeq73bhXnKMWVhBCwoY09jWoJhdTbUAWJ4Nw7QQkgjtQ+qdVTWDOiM0fXzuUENMXu+VmTF5iPz+Gyi3iu5XG3dykSQVJORyyX4IQbi3hk/OLJrjpzyyw3tq2icleqPEIlGH6ax6iWB8vqdOjmY/7Ykb1fCUyX5nFVO7wcuJTrTMXyllS1SnIV6xqp0AwcM4MdJphqiHW9P+4265bc0xMoiPbk97+3m3SYhWTdyM+urfzqDSBS26ziZUUvZMCk4L6P73VcqwA6jt4MP0YVfrUN9Y+n3l6Q/k4U3YGYmxK5JfI9N3awMP/IcruF6Y0OUxVkMVoJbkMGTcRi0GdHmwrb0WqEns4f7b8Obky/XcriTaOCuHepRKE5mZhCZRiucIbhSRFmiJdI1JRdTYmEqXYj8xs8tFdU7qsajokqByj4pw8GvBOfDDyRwm4tEvrwPRvSlZibg0WD+4oeOw24+fAGy1NGF2LqB++xCLPJ2iHftFlFWCY6uOM3dYOhufT6pHojCQ8LeJl+38I/sgVdDUAq+t0Fgaxo35jqTx9TJHUSNk1kcRsw4O5c1LchaWzUP0AaKoUi0gSZVjeKNiyORviNVuG/O+PCehkUJAsEbt2NAmX9gF4wTY69AM/MW/2+Xf3/Y2pWfnaQRWVUAflCoqUCiQ6duqZYCuOHrhOMo
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b550d7a-b664-465a-4da9-08dbb599b7ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 03:13:21.8935 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyPaoykasTD/9XNxC0yJpttLVF+5xLqEqghVXG4Svw7HKb3EeCCmw4R8gqx9q0//gzXN+0Ke9RGmoEqd7iInig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11596
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=lizhijian@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE1LzA5LzIwMjMgMDQ6MjAsIOKAnFdpbGxpYW0gUm9jaGUgd3JvdGU6DQo+IEZyb206
IFdpbGxpYW0gUm9jaGUgPHdpbGxpYW0ucm9jaGVAb3JhY2xlLmNvbT4NCj4gDQo+IEEgbWVtb3J5
IHBhZ2UgcG9pc29uZWQgZnJvbSB0aGUgaHlwZXJ2aXNvciBsZXZlbCBpcyBubyBsb25nZXIgcmVh
ZGFibGUuDQo+IFRodXMsIGl0IGlzIG5vdyB0cmVhdGVkIGFzIGEgemVyby1wYWdlIGZvciB0aGUg
cmFtIHNhdmluZyBtaWdyYXRpb24gcGhhc2UuDQo+IA0KPiBUaGUgbWlncmF0aW9uIG9mIGEgVk0g
d2lsbCBjcmFzaCBRZW11IHdoZW4gaXQgdHJpZXMgdG8gcmVhZCB0aGUNCj4gbWVtb3J5IGFkZHJl
c3Mgc3BhY2UgYW5kIHN0dW1ibGVzIG9uIHRoZSBwb2lzb25lZCBwYWdlIHdpdGggYSBzaW1pbGFy
DQo+IHN0YWNrIHRyYWNlOg0KPiANCj4gUHJvZ3JhbSB0ZXJtaW5hdGVkIHdpdGggc2lnbmFsIFNJ
R0JVUywgQnVzIGVycm9yLg0KPiAjMCAgX21tMjU2X2xvYWR1X3NpMjU2DQo+ICMxICBidWZmZXJf
emVyb19hdngyDQo+ICMyICBzZWxlY3RfYWNjZWxfZm4NCj4gIzMgIGJ1ZmZlcl9pc196ZXJvDQo+
ICM0ICBzYXZlX3plcm9fcGFnZV90b19maWxlDQo+ICM1ICBzYXZlX3plcm9fcGFnZQ0KPiAjNiAg
cmFtX3NhdmVfdGFyZ2V0X3BhZ2VfbGVnYWN5DQo+ICM3ICByYW1fc2F2ZV9ob3N0X3BhZ2UNCj4g
IzggIHJhbV9maW5kX2FuZF9zYXZlX2Jsb2NrDQo+ICM5ICByYW1fc2F2ZV9pdGVyYXRlDQo+ICMx
MCBxZW11X3NhdmV2bV9zdGF0ZV9pdGVyYXRlDQo+ICMxMSBtaWdyYXRpb25faXRlcmF0aW9uX3J1
bg0KPiAjMTIgbWlncmF0aW9uX3RocmVhZA0KPiAjMTMgcWVtdV90aHJlYWRfc3RhcnQNCj4gDQo+
IEZpeCBpdCBieSBjb25zaWRlcmluZyBwb2lzb25lZCBwYWdlcyBhcyBpZiB0aGV5IHdlcmUgemVy
by1wYWdlcyBmb3INCj4gdGhlIG1pZ3JhdGlvbiBjb3B5LiBUaGlzIGZpeCBhbHNvIHdvcmtzIHdp
dGggdW5kZXJseWluZyBsYXJnZSBwYWdlcywNCj4gdGFraW5nIGludG8gYWNjb3VudCB0aGUgUkFN
QmxvY2sgc2VnbWVudCAicGFnZS1zaXplIi4NCj4gDQo+IFN0YW5kYXJkIG1pZ3JhdGlvbiBhbmQg
Y29tcHJlc3NlZCB0cmFuc2ZlcnMgYXJlIGhhbmRsZWQgYnkgdGhpcyBjb2RlLg0KPiBSRE1BIHRy
YW5zZmVyIGlzbid0IHRvdWNoZWQuDQo+IA0KDQoNCkknbSBva2F5IHdpdGggIlJETUEgaXNuJ3Qg
dG91Y2hlZCIuDQpCVFcsIGNvdWxkIHlvdSBzaGFyZSB5b3VyIHJlcHJvZHVjaW5nIHByb2dyYW0v
aGFja2luZyB0byBwb2lzb24gdGhlIHBhZ2UsIHNvIHRoYXQNCmkgYW0gYWJsZSB0byB0YWtlIGEg
bG9vayB0aGUgUkRNQSBwYXJ0IGxhdGVyIHdoZW4gaSdtIGZyZWUuDQoNCk5vdCBzdXJlIGl0J3Mg
c3VpdGFibGUgdG8gYWNrbm93bGVkZ2UgYSBub3QgdG91Y2hlZCBwYXJ0LiBBbnl3YXkNCkFja2Vk
LWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+ICMgUkRNQQ0KDQoNCj4gU2ln
bmVkLW9mZi1ieTogV2lsbGlhbSBSb2NoZSA8d2lsbGlhbS5yb2NoZUBvcmFjbGUuY29tPg0KPiAt
LS0NCj4gICBhY2NlbC9rdm0va3ZtLWFsbC5jICAgICAgfCAxNCArKysrKysrKysrKysrKw0KPiAg
IGFjY2VsL3N0dWJzL2t2bS1zdHViLmMgICB8ICA1ICsrKysrDQo+ICAgaW5jbHVkZS9zeXNlbXUv
a3ZtLmggICAgIHwgMTAgKysrKysrKysrKw0KPiAgIG1pZ3JhdGlvbi9yYW0tY29tcHJlc3MuYyB8
ICAzICsrLQ0KPiAgIG1pZ3JhdGlvbi9yYW0uYyAgICAgICAgICB8IDIzICsrKysrKysrKysrKysr
KysrKysrKy0tDQo+ICAgbWlncmF0aW9uL3JhbS5oICAgICAgICAgIHwgIDIgKysNCj4gICA2IGZp
bGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYWNjZWwva3ZtL2t2bS1hbGwuYyBiL2FjY2VsL2t2bS9rdm0tYWxsLmMNCj4gaW5k
ZXggZmYxNTc4YmIzMi4uN2ZiMTNjOGE1NiAxMDA2NDQNCj4gLS0tIGEvYWNjZWwva3ZtL2t2bS1h
bGwuYw0KPiArKysgYi9hY2NlbC9rdm0va3ZtLWFsbC5jDQo+IEBAIC0xMTUyLDYgKzExNTIsMjAg
QEAgc3RhdGljIHZvaWQga3ZtX3VucG9pc29uX2FsbCh2b2lkICpwYXJhbSkNCj4gICAgICAgfQ0K
PiAgIH0NCj4gICANCj4gK2Jvb2wga3ZtX2h3cG9pc29uZWRfcGFnZShSQU1CbG9jayAqYmxvY2ss
IHZvaWQgKm9mZnNldCkNCj4gK3sNCj4gKyAgICBIV1BvaXNvblBhZ2UgKnBnOw0KPiArICAgIHJh
bV9hZGRyX3QgcmFtX2FkZHIgPSAocmFtX2FkZHJfdCkgb2Zmc2V0Ow0KPiArDQo+ICsgICAgUUxJ
U1RfRk9SRUFDSChwZywgJmh3cG9pc29uX3BhZ2VfbGlzdCwgbGlzdCkgew0KPiArICAgICAgICBp
ZiAoKHJhbV9hZGRyID49IHBnLT5yYW1fYWRkcikgJiYNCj4gKyAgICAgICAgICAgIChyYW1fYWRk
ciAtIHBnLT5yYW1fYWRkciA8IGJsb2NrLT5wYWdlX3NpemUpKSB7DQo+ICsgICAgICAgICAgICBy
ZXR1cm4gdHJ1ZTsNCj4gKyAgICAgICAgfQ0KPiArICAgIH0NCj4gKyAgICByZXR1cm4gZmFsc2U7
DQo+ICt9DQo+ICsNCj4gICB2b2lkIGt2bV9od3BvaXNvbl9wYWdlX2FkZChyYW1fYWRkcl90IHJh
bV9hZGRyKQ0KPiAgIHsNCj4gICAgICAgSFdQb2lzb25QYWdlICpwYWdlOw0KPiBkaWZmIC0tZ2l0
IGEvYWNjZWwvc3R1YnMva3ZtLXN0dWIuYyBiL2FjY2VsL3N0dWJzL2t2bS1zdHViLmMNCj4gaW5k
ZXggMjM1ZGM2NjFiYy4uYzBhMzE2MTFkZiAxMDA2NDQNCj4gLS0tIGEvYWNjZWwvc3R1YnMva3Zt
LXN0dWIuYw0KPiArKysgYi9hY2NlbC9zdHVicy9rdm0tc3R1Yi5jDQo+IEBAIC0xMzMsMyArMTMz
LDggQEAgdWludDMyX3Qga3ZtX2RpcnR5X3Jpbmdfc2l6ZSh2b2lkKQ0KPiAgIHsNCj4gICAgICAg
cmV0dXJuIDA7DQo+ICAgfQ0KPiArDQo+ICtib29sIGt2bV9od3BvaXNvbmVkX3BhZ2UoUkFNQmxv
Y2sgKmJsb2NrLCB2b2lkICpyYW1fYWRkcikNCj4gK3sNCj4gKyAgICByZXR1cm4gZmFsc2U7DQo+
ICt9DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9rdm0uaCBiL2luY2x1ZGUvc3lzZW11
L2t2bS5oDQo+IGluZGV4IGVlOTAyNWY4ZTkuLjg1ODY4ODIyN2EgMTAwNjQ0DQo+IC0tLSBhL2lu
Y2x1ZGUvc3lzZW11L2t2bS5oDQo+ICsrKyBiL2luY2x1ZGUvc3lzZW11L2t2bS5oDQo+IEBAIC01
NzAsNCArNTcwLDE0IEBAIGJvb2wga3ZtX2FyY2hfY3B1X2NoZWNrX2FyZV9yZXNldHRhYmxlKHZv
aWQpOw0KPiAgIGJvb2wga3ZtX2RpcnR5X3JpbmdfZW5hYmxlZCh2b2lkKTsNCj4gICANCj4gICB1
aW50MzJfdCBrdm1fZGlydHlfcmluZ19zaXplKHZvaWQpOw0KPiArDQo+ICsvKioNCj4gKyAqIGt2
bV9od3BvaXNvbmVkX3BhZ2UgLSBpbmRpY2F0ZSBpZiB0aGUgZ2l2ZW4gcGFnZSBpcyBwb2lzb25l
ZA0KPiArICogQGJsb2NrOiBtZW1vcnkgYmxvY2sgb2YgdGhlIGdpdmVuIHBhZ2UNCj4gKyAqIEBy
YW1fYWRkcjogb2Zmc2V0IG9mIHRoZSBwYWdlDQo+ICsgKg0KPiArICogUmV0dXJuczogdHJ1ZTog
cGFnZSBpcyBwb2lzb25lZA0KPiArICogICAgICAgICAgZmFsc2U6IHBhZ2Ugbm90IHlldCBwb2lz
b25lZA0KPiArICovDQo+ICtib29sIGt2bV9od3BvaXNvbmVkX3BhZ2UoUkFNQmxvY2sgKmJsb2Nr
LCB2b2lkICpyYW1fYWRkcik7DQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24v
cmFtLWNvbXByZXNzLmMgYi9taWdyYXRpb24vcmFtLWNvbXByZXNzLmMNCj4gaW5kZXggMDYyNTRk
OGM2OS4uMTkxNmNlNzA5ZCAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JhbS1jb21wcmVzcy5j
DQo+ICsrKyBiL21pZ3JhdGlvbi9yYW0tY29tcHJlc3MuYw0KPiBAQCAtMzQsNiArMzQsNyBAQA0K
PiAgICNpbmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiAgICNpbmNsdWRlICJtaWdyYXRp
b24uaCINCj4gICAjaW5jbHVkZSAib3B0aW9ucy5oIg0KPiArI2luY2x1ZGUgInJhbS5oIg0KPiAg
ICNpbmNsdWRlICJpby9jaGFubmVsLW51bGwuaCINCj4gICAjaW5jbHVkZSAiZXhlYy90YXJnZXRf
cGFnZS5oIg0KPiAgICNpbmNsdWRlICJleGVjL3JhbWJsb2NrLmgiDQo+IEBAIC0xOTgsNyArMTk5
LDcgQEAgc3RhdGljIENvbXByZXNzUmVzdWx0IGRvX2NvbXByZXNzX3JhbV9wYWdlKFFFTVVGaWxl
ICpmLCB6X3N0cmVhbSAqc3RyZWFtLA0KPiAgIA0KPiAgICAgICBhc3NlcnQocWVtdV9maWxlX2J1
ZmZlcl9lbXB0eShmKSk7DQo+ICAgDQo+IC0gICAgaWYgKGJ1ZmZlcl9pc196ZXJvKHAsIHBhZ2Vf
c2l6ZSkpIHsNCj4gKyAgICBpZiAobWlncmF0aW9uX2J1ZmZlcl9pc196ZXJvKGJsb2NrLCBvZmZz
ZXQsIHBhZ2Vfc2l6ZSkpIHsNCj4gICAgICAgICAgIHJldHVybiBSRVNfWkVST1BBR0U7DQo+ICAg
ICAgIH0NCj4gICANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9y
YW0uYw0KPiBpbmRleCA5MDQwZDY2ZTYxLi5mZDMzN2Y3ZTY1IDEwMDY0NA0KPiAtLS0gYS9taWdy
YXRpb24vcmFtLmMNCj4gKysrIGIvbWlncmF0aW9uL3JhbS5jDQo+IEBAIC0xMTI5LDYgKzExMjks
MjYgQEAgdm9pZCByYW1fcmVsZWFzZV9wYWdlKGNvbnN0IGNoYXIgKnJibmFtZSwgdWludDY0X3Qg
b2Zmc2V0KQ0KPiAgICAgICByYW1fZGlzY2FyZF9yYW5nZShyYm5hbWUsIG9mZnNldCwgVEFSR0VU
X1BBR0VfU0laRSk7DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiBtaWdyYXRpb25fYnVmZmVy
X2lzX3plcm86IGluZGljYXRlIGlmIHRoZSBwYWdlIGF0IHRoZSBnaXZlbg0KPiArICogbG9jYXRp
b24gaXMgZW50aXJlbHkgZmlsbGVkIHdpdGggemVybywgb3IgaXMgYSBwb2lzb25lZCBwYWdlLg0K
PiArICoNCj4gKyAqIEBibG9jazogYmxvY2sgdGhhdCBjb250YWlucyB0aGUgcGFnZQ0KPiArICog
QG9mZnNldDogb2Zmc2V0IGluc2lkZSB0aGUgYmxvY2sgZm9yIHRoZSBwYWdlDQo+ICsgKiBAbGVu
OiBzaXplIHRvIGNvbnNpZGVyDQo+ICsgKi8NCj4gK2Jvb2wgbWlncmF0aW9uX2J1ZmZlcl9pc196
ZXJvKFJBTUJsb2NrICpibG9jaywgcmFtX2FkZHJfdCBvZmZzZXQsDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGxlbikNCj4gK3sNCj4gKyAgICB1aW50OF90
ICpwID0gYmxvY2stPmhvc3QgKyBvZmZzZXQ7DQo+ICsNCj4gKyAgICBpZiAoa3ZtX2VuYWJsZWQo
KSAmJiBrdm1faHdwb2lzb25lZF9wYWdlKGJsb2NrLCAodm9pZCAqKW9mZnNldCkpIHsNCj4gKyAg
ICAgICAgcmV0dXJuIHRydWU7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIGJ1ZmZlcl9p
c196ZXJvKHAsIGxlbik7DQo+ICt9DQo+ICsNCj4gICAvKioNCj4gICAgKiBzYXZlX3plcm9fcGFn
ZV90b19maWxlOiBzZW5kIHRoZSB6ZXJvIHBhZ2UgdG8gdGhlIGZpbGUNCj4gICAgKg0KPiBAQCAt
MTE0MiwxMCArMTE2Miw5IEBAIHZvaWQgcmFtX3JlbGVhc2VfcGFnZShjb25zdCBjaGFyICpyYm5h
bWUsIHVpbnQ2NF90IG9mZnNldCkNCj4gICBzdGF0aWMgaW50IHNhdmVfemVyb19wYWdlX3RvX2Zp
bGUoUGFnZVNlYXJjaFN0YXR1cyAqcHNzLCBRRU1VRmlsZSAqZmlsZSwNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgUkFNQmxvY2sgKmJsb2NrLCByYW1fYWRkcl90IG9mZnNl
dCkNCj4gICB7DQo+IC0gICAgdWludDhfdCAqcCA9IGJsb2NrLT5ob3N0ICsgb2Zmc2V0Ow0KPiAg
ICAgICBpbnQgbGVuID0gMDsNCj4gICANCj4gLSAgICBpZiAoYnVmZmVyX2lzX3plcm8ocCwgVEFS
R0VUX1BBR0VfU0laRSkpIHsNCj4gKyAgICBpZiAobWlncmF0aW9uX2J1ZmZlcl9pc196ZXJvKGJs
b2NrLCBvZmZzZXQsIFRBUkdFVF9QQUdFX1NJWkUpKSB7DQo+ICAgICAgICAgICBsZW4gKz0gc2F2
ZV9wYWdlX2hlYWRlcihwc3MsIGZpbGUsIGJsb2NrLCBvZmZzZXQgfCBSQU1fU0FWRV9GTEFHX1pF
Uk8pOw0KPiAgICAgICAgICAgcWVtdV9wdXRfYnl0ZShmaWxlLCAwKTsNCj4gICAgICAgICAgIGxl
biArPSAxOw0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JhbS5oIGIvbWlncmF0aW9uL3JhbS5o
DQo+IGluZGV4IDE0NWM5MTVjYTcuLjgwNWVhMmEyMTEgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlv
bi9yYW0uaA0KPiArKysgYi9taWdyYXRpb24vcmFtLmgNCj4gQEAgLTY1LDYgKzY1LDggQEAgdm9p
ZCByYW1faGFuZGxlX2NvbXByZXNzZWQodm9pZCAqaG9zdCwgdWludDhfdCBjaCwgdWludDY0X3Qg
c2l6ZSk7DQo+ICAgdm9pZCByYW1fdHJhbnNmZXJyZWRfYWRkKHVpbnQ2NF90IGJ5dGVzKTsNCj4g
ICB2b2lkIHJhbV9yZWxlYXNlX3BhZ2UoY29uc3QgY2hhciAqcmJuYW1lLCB1aW50NjRfdCBvZmZz
ZXQpOw0KPiAgIA0KPiArYm9vbCBtaWdyYXRpb25fYnVmZmVyX2lzX3plcm8oUkFNQmxvY2sgKmJs
b2NrLCByYW1fYWRkcl90IG9mZnNldCwgc2l6ZV90IGxlbik7DQo+ICsNCj4gICBpbnQgcmFtYmxv
Y2tfcmVjdl9iaXRtYXBfdGVzdChSQU1CbG9jayAqcmIsIHZvaWQgKmhvc3RfYWRkcik7DQo+ICAg
Ym9vbCByYW1ibG9ja19yZWN2X2JpdG1hcF90ZXN0X2J5dGVfb2Zmc2V0KFJBTUJsb2NrICpyYiwg
dWludDY0X3QgYnl0ZV9vZmZzZXQpOw0KPiAgIHZvaWQgcmFtYmxvY2tfcmVjdl9iaXRtYXBfc2V0
KFJBTUJsb2NrICpyYiwgdm9pZCAqaG9zdF9hZGRyKTs=

