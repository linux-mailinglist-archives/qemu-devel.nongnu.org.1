Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA047C7FF4
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDDt-0000SV-0M; Fri, 13 Oct 2023 04:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDDj-0000IZ-CL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:08:31 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDDh-0001Ih-9L
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184509; x=1728720509;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yG8BhGPyPl9Foy+YMXO1X8X7BVqcML0k/y786apX7T0=;
 b=gRrPpLT/W5oi1eJh6y+HxuqZi/Pyno9cQLEf+O58ycomk5yg2mhX+LSa
 CC0LffznsiHbP9qc5V2J9Na9lw4vk0jRonChegoyTa1ZkHdVUuA/fqDPp
 iU8fdwdjDLDkGWQhBzHei9nKYA/iQp/lG0raCHqkWPzD1KVD1CBMu0BdK
 w0uyPxPeaOzG7wxmNR0ZWMVNueMtHk6ANTkSYUTlz0lrwThrpqwBfK0NH
 +AF7vmfx1QP8sX0Tz+LTb9ut9kyFd5nnkQpICvNPoounoi5tFMVi0TPwJ
 zAm+ihnCs8fqpx5pA5ESZ/2AAs+HtlMZK8XJ2Gl8o/9siAb0mi0l9K40p g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="98958130"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="98958130"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:08:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ+IL1BGlPTwgT6a++HlkQsAISZRW5s15kW8KDlqsJnHOE8MsdbtxMetji7BwM//tsWmMF4NcoIMASJIkg0AEtD1kPb7PPORv7VqK3uY/MFQAdSYYOjqTGabam/abeMEgn+7P1foF18VsHKIMqGqb1h9E+1L5wj6PIj2pxiKuTTYJdoOn+U/bq1qYn/YJmxoLzG8fZNo0F2b9SYqF/h2e7E76jaIvJazX/qGFE2CRRUGg5n1emzHDfqpqwLLmpam7zXMMgKrbxO0/vp2ZuPeMrcw16MO2O2P2d/cfzrOtnOUCP/qzDW5gymkREkCiOeyJSZ8+70sT6libwNE5OBUpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yG8BhGPyPl9Foy+YMXO1X8X7BVqcML0k/y786apX7T0=;
 b=S9sDZJ4HmUX4tktoJJkQkQiQUUxltG8AzZlJbYSgf8T8UQSfu7h19mNhgmJ4wqlP6E73sipuo3yanFg/0nZWfDdiU0tVQPbYPBA1lkhx8RVqmGwcNglhIiFQkSGjAueJjvCSMA43FXoMhKICYDWeynPkdktUnPkcEj4ZlJ0zA1TGIe8tJOsbxxDg8cgBXLnbo1YWH+iDxkI3ZJaFLiOkuDXUbccQzSh4APb6umi/cfKjGLsILCSVyh3h9IMNPEAeHl/rL7lhNCCFlwbqmaBIJdS5VttjWAspVjjq7IBln1iGT6jEcjOf/2k3oD6+bLaCXt5HSfzfw488ADeq/cPfuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TY3PR01MB9857.jpnprd01.prod.outlook.com (2603:1096:400:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:08:22 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:08:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 08/13] migration/rdma: Move rdma constants from
 qemu-file.h to rdma.h
Thread-Topic: [PATCH v3 08/13] migration/rdma: Move rdma constants from
 qemu-file.h to rdma.h
Thread-Index: AQHZ/IKMDxo8mqemzEGD2YdNBu0ofbBHX9eA
Date: Fri, 13 Oct 2023 08:08:21 +0000
Message-ID: <c91c2024-ae6a-0152-f518-a63bbf237e60@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-9-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-9-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TY3PR01MB9857:EE_
x-ms-office365-filtering-correlation-id: a582848c-8ab2-4980-d953-08dbcbc3915a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2nkFi1OwG/N0SOhVqGqCPVPzbW4SPU576m4wFm9N676SIGe7no/Oz4oGFtZh9rGGBkKnRSYTK7iQBrIhRq5KFYKRB/SqETTtV/vSjhreQMzbFkrojzQ4UaL3uDa8vwpoO5ksYfVuSuqtG4foEZC4NibPQJBfguL3SleU2kb/97Gop/WEc9C1Y7JNDQ3OMnuo7AJMx9I+dz00qftuikzWKauDHDf6Tmksgu37Tyqf0RYNUcTcOfKH/g4BDeWfza/8oioRMshpe4wI1LJcOlx3XdaoMMZ6L/zFaR8uF15EhizXjrSPiDNiMC6CerYT1PziI2vwxhwx/G17sHTrkhfw/kxMYHDwb0barRtTmymf8bJlcjFh7Er4k0Suq7JC2uBsGEOY8OPbr0GI8QLvapcfXdjFM6rJ+Af3QVJhEa3/cS1SB00FBPxldSytK6le1HrGcRD1tWYruzThcn+3XCDjgp61KOxHSdc2ylyp/kRQU3BzoLFCrivABhQJ3rESutcN413I46W6NwtZACjR73pFU6KUWHtZ/rtxhXfMIDBDkyqTq+AwRqD8jlMKeLIOAkbR8kmKTp8KkoumrdI91CQkFlNeFu7wpdv9wbzD5I6FHgyum4NGY+WKOWim+mRRcy7csu3H+x4n2UTV8QAEGIJ4FWtZNG5BstDgO8xdejOWOvWPX60hO+zqo8EBlfF1pFPq8tYJzxSqEpH74ArSk105A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(186009)(1800799009)(64100799003)(1590799021)(451199024)(85182001)(36756003)(86362001)(31696002)(31686004)(1580799018)(91956017)(110136005)(66476007)(64756008)(54906003)(316002)(76116006)(66446008)(38070700005)(82960400001)(38100700002)(66946007)(122000001)(66556008)(53546011)(71200400001)(83380400001)(26005)(2616005)(41300700001)(5660300002)(6512007)(6506007)(8676002)(478600001)(8936002)(6486002)(2906002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjJCdmhzd095YmxpLzR5TnlROG94UEFzMmlGTTdERDU2d3IwTWh5NkhVTndR?=
 =?utf-8?B?OHVWSXRuaE5RWFRpNFNUVndiTDVMRWVTYUQxRUw1SFltSXhaV3hETUxrRDNS?=
 =?utf-8?B?R1pCSHlLMSswc3NzNzFZakdPYjRpYnJ5RnBwV2VGT1FZcTRUQ01GNndJMWcv?=
 =?utf-8?B?YnB1QkVXN2t6Z2pBMnhnNDE0UXlNUk5DaWtDeFkzOTFWclFFNVA1OXdLZFNn?=
 =?utf-8?B?MW9vQkhTcjF0UnhFNnZVMmVtaU9WM3hCejlwZ1hscHZJMTJSM3NYTkp1Rmto?=
 =?utf-8?B?MTM5K05wd0pUUjhGMU9jWmRMZmJNVktLYWxlcjhOL3BIZ2dqbWsxMTVxTlFt?=
 =?utf-8?B?WWhEZnZPcUxDUmMxa1dzayt4Q0VYSlBpQ2lnSThnSjM4NGZQeXZYM2dKWlNL?=
 =?utf-8?B?QTQ2QWxLSUhRUW9DTktOUEpyODhPdUQ5ak0xMkFxUytPSU9tTXBuQXFFNDM3?=
 =?utf-8?B?YW1SWUM5eUJNdVJIT3NBLzdjZzNlMXlISkkvSThKaGpWeENPTTdxcm1XSkRC?=
 =?utf-8?B?SE12TFZJZThwSWFVbVZCZXFGd0pyZFJ1TENOTktQQ2p1bU1WeHZuemV0NGVM?=
 =?utf-8?B?Vk1qeDFRQlEvcmVVdTdRNVlwMGpWRlJxS0tKL05kR1NLck9OTTRMUVBJTlFD?=
 =?utf-8?B?V2Fldzc2VHRBNXBNQTJSWEFVTC9Cdm9EK285eUp1eFlIaW5EaGtGMTd4UEJX?=
 =?utf-8?B?NlVyRnpZY0duTEpSSFRvV3FmRnJqVTk3OUFCb0s1TFBJcHVQZGJOZW5zaEth?=
 =?utf-8?B?UURvN2pTemJ1VisvYkw3enpuRXBHM015NXdnZ09uRTZMRzdIcjJ1YWl2Y0gv?=
 =?utf-8?B?WEEwRmVkb3dNeUYzN0FlSEQvU1dwZ2VEb1dPR0VBTWdETWlqcEVvd2tiSEEz?=
 =?utf-8?B?NFlUMTJoWndWOHlSMUJTMzFEc2NyMHJnc2o0VHJaN3dwS0puZTJrYm8xdVRw?=
 =?utf-8?B?U0VvRWxYWU1ub3l1aFgrRXdTb2h3MUMzVzRQMzlSWjFWZGFNeTg4a1pmYkph?=
 =?utf-8?B?WGpwdFBDSExBaUIrdFlRMHlUeFdaTDJOK1YzOXVKTUJLdXlqemVzc004UDVp?=
 =?utf-8?B?ZG5GOHdKNWJxKzg0T2F4bHF4andzUGJoSXZNdzRpSXNTZ0NXZTllRDh2cTdh?=
 =?utf-8?B?ZytJVWlFb3Zpa3B2YVVoYkhXLy9DU1laL3NQK2p2dEcxNnVObmJ2UTlTdmxn?=
 =?utf-8?B?Q1EvWlpyZzBKWmZubjMvbVh2WjNEL1FnekJXbTRlZEtIaGtpbjdmSFRIeFJY?=
 =?utf-8?B?Q25UQ05Jc3p5NGt6bzFMQVVPMDNHazV5eG9Yem5XS1pLeTFRUEdFeG1KN1NU?=
 =?utf-8?B?RnBHUTRkNXYrYXBGZzlJd25NMllscktkYzE2aU8zbm80TUxIbFlCMldxVWNE?=
 =?utf-8?B?Ly9YbGM4aFVuQThuQkZVUTBOSm5uUnZsSktnVnd5VUNOeG1Udk1nVW50c29j?=
 =?utf-8?B?UUJ5SlkzZ24zNGtzOEVhWXdHMDZkNGV4MDNzRUxTMmNYWVB4VmdrMTl4Nllr?=
 =?utf-8?B?ZC9qcUNYeEJ5aUlKWW5tT1dyR3VvczE0czh0QXVJeDRqalRYYm95SnRtdHd5?=
 =?utf-8?B?OUFobnRuSW82WkFXVGxFV2ppemhsam9nV0tMY3NWWGF6WUZBYWhhZWJHa1RF?=
 =?utf-8?B?MVNwSHpwdk4yVmpHTVZZV29GbDc0TENSOUVRR0xxM0k2VHpnOExYUWZpNU82?=
 =?utf-8?B?RWRwS2h4eHp6KzJjdzZPNlFBRzFKRkRYZHhyMkdTMGhzRXdQb3pTaFpnQ0dF?=
 =?utf-8?B?clU3YmFjWlV5NXdsR0t1M1o2QkRkS2cva1lWY1VtYVdYZUhDbU1vRXUzaHY2?=
 =?utf-8?B?NVBpbitBdURMT1ZXdXUzblFmOFA0bUZJcjFlZXZDVXFCdzdlUHdKdG9KMWMr?=
 =?utf-8?B?cHk3ZEErM09uNVhmUEFHamh3ZEtCcnM3Q24xMkhyeXRzWXIxYnU5bEl3MFJR?=
 =?utf-8?B?STd3QzJObWhpY1ZxMG11OFh1RDgyRG9CMnZCOTZIbnowNXB4UituVDlveHpr?=
 =?utf-8?B?TmZCNHBEcGJwMU5pbFJWNFlpY000OE5XZVhGbW9qVHVWMC9aQnNEZ01lQWpj?=
 =?utf-8?B?VjFFOWRCa0hOT3didE1NdXF2SVhCczM0bTBNSENmK3I3bmpFdzRTRWFXNlQ5?=
 =?utf-8?B?UEFWSElqdXBQc3ljY1BYM3k0UWd5WEdlSTU0bFl6WmpBTG5OQkY5N2FaYjJH?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C425E22FB6C384D9DC27C77E2AB08CC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qa193u5Kim2dZPsLmjr4KDxMiJRjhUQZOhySJyQCHorrJXFufMUT3MSK8DcKLmCMgL0ykgXrkYwCBa40QRIi7vFrhanzIFroY6yCWNpcnve7vEfD9Tcs/08V2Zzd70Nb9rG2ahKTyKNDXD+bKIPevZVexHaJhG+3IFIY8msxb3WjNcrgUZm0eaKx7bk2SCo3kv3tgweK4A0eA5fy/Q/PJGRby4CtYxat8UCi23u9hW8Ma3lQldNZrmVL3YlovmhGYNFPUphJWa+lk96BcGXHLSxRNaFfUWCJdKx2B1vyra5lcG56PiPUb993s8NhW/z7rA/98Ypc0nxvhsUvcNgfSuTG5h5eVMdxu1PYlpz6zcr3FnljPEAj0IUcWflF5W9ipjkMJ4SOH2jTdQ+vO7cXfAN1YnAddST6W+zJKn5NQlW5Hlu5+Uq8vgJoSar8cSiNc/gfGovBZjpsn86rZbKKGLB0aNyej/vvQYYVOieh7xw8S7FymsaQKJvzRGU1JKwYLB8PgURLhRO/frzg+BNfDDK8NU6Ra+0Q3OaxWbyN53trRBKQbCqR2fVNUeUebdgESTNXEqlPxMFNJ/tXzkix1BmqzZAZBWXQbgZaKtYWeYQd3YoR5IST8CZl1uCFQLUeDTl9FKcecvyygTlIJFKIAtPDaEW0ssvWeLYyxf9mcHB4Orwi0bb2fea8leMioUCTD0rUNDYOc/axBh3m8rixSeIHEQ5mJbq10H/NuEFQhOliEhBdx8cnaVLPJ6cBp8cgmTuF+iqN4hSjhrC1GX2KWjtLQyxMVmV2ob6YfR5N4RSfteZDH6GTdfOpOWIOiKld
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a582848c-8ab2-4980-d953-08dbcbc3915a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:08:22.0215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qfHhHsPx7tZqUG8vVvZQnFQJv8XNumwSvayfa9ZhmEGDWJ5+cGlSVhjJLzRvgjV5Srq8P26F+MDRCDkSn3RLHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9857
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IFJldmlld2Vk
LWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1YW4g
UXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlqaWFu
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcWVtdS1m
aWxlLmggfCAxNyAtLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmggICAgICB8
IDE2ICsrKysrKysrKysrKysrKysNCj4gICBtaWdyYXRpb24vcmFtLmMgICAgICAgfCAgMiArLQ0K
PiAgIDMgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3FlbXUtZmlsZS5oIGIvbWlncmF0aW9uL3FlbXUt
ZmlsZS5oDQo+IGluZGV4IDBiMjJkODMzNWYuLmEyOWMzN2IwZDAgMTAwNjQ0DQo+IC0tLSBhL21p
Z3JhdGlvbi9xZW11LWZpbGUuaA0KPiArKysgYi9taWdyYXRpb24vcWVtdS1maWxlLmgNCj4gQEAg
LTI5LDEzICsyOSw2IEBADQo+ICAgI2luY2x1ZGUgImV4ZWMvY3B1LWNvbW1vbi5oIg0KPiAgICNp
bmNsdWRlICJpby9jaGFubmVsLmgiDQo+ICAgDQo+IC0vKg0KPiAtICogQ29uc3RhbnRzIHVzZWQg
YnkgcmFtX2NvbnRyb2xfKiBob29rcw0KPiAtICovDQo+IC0jZGVmaW5lIFJBTV9DT05UUk9MX1NF
VFVQICAgICAwDQo+IC0jZGVmaW5lIFJBTV9DT05UUk9MX1JPVU5EICAgICAxDQo+IC0jZGVmaW5l
IFJBTV9DT05UUk9MX0ZJTklTSCAgICAzDQo+IC0NCj4gICBRRU1VRmlsZSAqcWVtdV9maWxlX25l
d19pbnB1dChRSU9DaGFubmVsICppb2MpOw0KPiAgIFFFTVVGaWxlICpxZW11X2ZpbGVfbmV3X291
dHB1dChRSU9DaGFubmVsICppb2MpOw0KPiAgIGludCBxZW11X2ZjbG9zZShRRU1VRmlsZSAqZik7
DQo+IEBAIC0xMDEsMTYgKzk0LDYgQEAgdm9pZCBxZW11X2ZmbHVzaChRRU1VRmlsZSAqZik7DQo+
ICAgdm9pZCBxZW11X2ZpbGVfc2V0X2Jsb2NraW5nKFFFTVVGaWxlICpmLCBib29sIGJsb2NrKTsN
Cj4gICBpbnQgcWVtdV9maWxlX2dldF90b19mZChRRU1VRmlsZSAqZiwgaW50IGZkLCBzaXplX3Qg
c2l6ZSk7DQo+ICAgDQo+IC0vKiBXaGVuZXZlciB0aGlzIGlzIGZvdW5kIGluIHRoZSBkYXRhIHN0
cmVhbSwgdGhlIGZsYWdzDQo+IC0gKiB3aWxsIGJlIHBhc3NlZCB0byByYW1fY29udHJvbF9sb2Fk
X2hvb2sgaW4gdGhlIGluY29taW5nLW1pZ3JhdGlvbg0KPiAtICogc2lkZS4gVGhpcyBsZXRzIGJl
Zm9yZV9yYW1faXRlcmF0ZS9hZnRlcl9yYW1faXRlcmF0ZSBhZGQNCj4gLSAqIHRyYW5zcG9ydC1z
cGVjaWZpYyBzZWN0aW9ucyB0byB0aGUgUkFNIG1pZ3JhdGlvbiBkYXRhLg0KPiAtICovDQo+IC0j
ZGVmaW5lIFJBTV9TQVZFX0ZMQUdfSE9PSyAgICAgMHg4MA0KPiAtDQo+IC0jZGVmaW5lIFJBTV9T
QVZFX0NPTlRST0xfTk9UX1NVUFAgLTEwMDANCj4gLSNkZWZpbmUgUkFNX1NBVkVfQ09OVFJPTF9E
RUxBWUVEICAtMjAwMA0KPiAtDQo+ICAgUUlPQ2hhbm5lbCAqcWVtdV9maWxlX2dldF9pb2MoUUVN
VUZpbGUgKmZpbGUpOw0KPiAgIA0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9u
L3JkbWEuaCBiL21pZ3JhdGlvbi9yZG1hLmgNCj4gaW5kZXggMDlhMTZjMWUzYy4uMWZmMzcxOGE3
NiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3JkbWEuaA0KPiArKysgYi9taWdyYXRpb24vcmRt
YS5oDQo+IEBAIC0yNCw2ICsyNCwyMiBAQCB2b2lkIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWlncmF0
aW9uKHZvaWQgKm9wYXF1ZSwgY29uc3QgY2hhciAqaG9zdF9wb3J0LA0KPiAgIA0KPiAgIHZvaWQg
cmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24oY29uc3QgY2hhciAqaG9zdF9wb3J0LCBFcnJv
ciAqKmVycnApOw0KPiAgIA0KPiArLyoNCj4gKyAqIENvbnN0YW50cyB1c2VkIGJ5IHJkbWEgcmV0
dXJuIGNvZGVzDQo+ICsgKi8NCj4gKyNkZWZpbmUgUkFNX0NPTlRST0xfU0VUVVAgICAgIDANCj4g
KyNkZWZpbmUgUkFNX0NPTlRST0xfUk9VTkQgICAgIDENCj4gKyNkZWZpbmUgUkFNX0NPTlRST0xf
RklOSVNIICAgIDMNCj4gKw0KPiArLyoNCj4gKyAqIFdoZW5ldmVyIHRoaXMgaXMgZm91bmQgaW4g
dGhlIGRhdGEgc3RyZWFtLCB0aGUgZmxhZ3MNCj4gKyAqIHdpbGwgYmUgcGFzc2VkIHRvIHJkbWEg
ZnVuY3Rpb25zIGluIHRoZSBpbmNvbWluZy1taWdyYXRpb24NCj4gKyAqIHNpZGUuDQo+ICsgKi8N
Cj4gKyNkZWZpbmUgUkFNX1NBVkVfRkxBR19IT09LICAgICAweDgwDQo+ICsNCj4gKyNkZWZpbmUg
UkFNX1NBVkVfQ09OVFJPTF9OT1RfU1VQUCAtMTAwMA0KPiArI2RlZmluZSBSQU1fU0FWRV9DT05U
Uk9MX0RFTEFZRUQgIC0yMDAwDQo+ICAgDQo+ICAgI2lmZGVmIENPTkZJR19SRE1BDQo+ICAgaW50
IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25faGFuZGxlKFFFTVVGaWxlICpmKTsNCj4gZGlmZiAtLWdp
dCBhL21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYw0KPiBpbmRleCBmZDVjNjFjNzM5
Li5mOWJiZDE3MDI4IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4gKysrIGIvbWln
cmF0aW9uL3JhbS5jDQo+IEBAIC04OSw3ICs4OSw3IEBADQo+ICAgI2RlZmluZSBSQU1fU0FWRV9G
TEFHX0VPUyAgICAgIDB4MTANCj4gICAjZGVmaW5lIFJBTV9TQVZFX0ZMQUdfQ09OVElOVUUgMHgy
MA0KPiAgICNkZWZpbmUgUkFNX1NBVkVfRkxBR19YQlpSTEUgICAweDQwDQo+IC0vKiAweDgwIGlz
IHJlc2VydmVkIGluIHFlbXUtZmlsZS5oIGZvciBSQU1fU0FWRV9GTEFHX0hPT0sgKi8NCj4gKy8q
IDB4ODAgaXMgcmVzZXJ2ZWQgaW4gcmRtYS5oIGZvciBSQU1fU0FWRV9GTEFHX0hPT0sgKi8NCj4g
ICAjZGVmaW5lIFJBTV9TQVZFX0ZMQUdfQ09NUFJFU1NfUEFHRSAgICAweDEwMA0KPiAgICNkZWZp
bmUgUkFNX1NBVkVfRkxBR19NVUxUSUZEX0ZMVVNIICAgIDB4MjAwDQo+ICAgLyogV2UgY2FuJ3Qg
dXNlIGFueSBmbGFnIHRoYXQgaXMgYmlnZ2VyIHRoYW4gMHgyMDAgKi8=

