Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D8E7AE540
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 07:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql0y0-00049b-6T; Tue, 26 Sep 2023 01:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0xx-00049L-TO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:50:37 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql0xv-0007Bt-6B
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 01:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695707435; x=1727243435;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=juCLlZfXpPJEE+u6E+N/uYOUNrMRPJ6n7xIDWg5OTr8=;
 b=A1mr71iCSVfl+VOeSMA2GFjY4YYvca4bcyDPeVN77YUpDFfglGHUvVlQ
 eS8K2fr4aMqQc3K4gDVQm2SqagpOX4ymVRAT3/9cLIzPHbIaqh7x+Vxio
 /sbuR+uYsPcF+S5bHgS0oGuj7ilyY3mGa+A7E4e+7hJg8uHzEpfDfIQuq
 sVd8Z80GbQ64M64VMDSmKVdgklAA49EErIXAx/I2mhefy4ehm8bGSgZeN
 d+MHE7bpOyUmBAPYvGmjlKxpX7GMF9QNq9coHtx10IF0bDREUnjAqhYGo
 X9rxna9wPO3ks88d4vNvi7E4y70GXbb9fxgOcDYsfW4mwZ49Bg09SepgX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96727092"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96727092"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 14:50:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAq0/E9c1pohm+6cEqZ4z7ay4No/0usVub50lMYFvjrelS1hlHz/0nlgc8SrpzfD1K13HHIw2u3Gg07GCs3ouY+oOHVLjwDPQiVb85rVmKgbTEcuxYoVbrydU+jGjmoGD6DspFQuppToaG+uzeemXvj/9lqAV0NTW3yhdI+O8VG2NlyNJgRUQBWdcVeUQKkL4WsonBco+fcirK4UmGmb2LwZ4y6171SdQfCH6Z1h2VnzQjwQV45wCvHaEK1ph916l+WeDmWTre6PNYQIcpD69StXeEP1TcXhEaIn5lFWAlforGotHCF6ms76G4H8BnSg9ekI8prMxAjq4qIXKGDMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juCLlZfXpPJEE+u6E+N/uYOUNrMRPJ6n7xIDWg5OTr8=;
 b=LHk4dbmtiElWK2oJ3gYAsJZHwzvS1N/2m4Mz5oxd+J5M+GtuwmgEq4RZ6+6rAhR+pXdvg13qTOSEitBzhCMCYOlVxRtHDtKTSq6q7WJo7khgu+3PpkJdhGk1cK7PUK/re8hzAoVbNJIYnk56AzwzjqeTum/tKo4jsDxBF9aRJqLv3X5I4wXLtfuEC1NfWfRVrpgCizIozHStU7MTODoS+ysgSkwI4yUL6gt6+8tSAU9mhsLZHiLrT9ba52yXHx8zv4d5GPldeR4STg51EeAy/xD59XsqFDX8NbhJLFAO9eE9AyhviT9EWxFSQhcfKH3EmEDjqoIO/4I/MuBY2Wk1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS0PR01MB5891.jpnprd01.prod.outlook.com (2603:1096:604:ba::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 05:50:28 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 05:50:28 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Topic: [PATCH 39/52] migration/rdma: Convert qemu_rdma_write_one() to
 Error
Thread-Index: AQHZ6j9fgex1HQn4skmnwwB9vRYjH7AspjSA
Date: Tue, 26 Sep 2023 05:50:28 +0000
Message-ID: <9e117d0c-cf2b-dd01-7fef-55d1c41d254c@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-40-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-40-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS0PR01MB5891:EE_
x-ms-office365-filtering-correlation-id: 59972ee3-ca8b-4626-6d08-08dbbe547d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ds9FLWJbpUQqe3RQU8LAjc4gnJlq8/qoq7SkXtnnP/oRwtWkpknb/mUV+eG8hCjlsliRKscOtghCRKNHG5RYfONzql+PZNw9wFEP8UPkp3BVzBjlOkLylpd8a8q8cAK4jW/vXZvI72tV8TfsYNych5xgVzwft0L+dgUWARJrnHUdjIyMZZLye1o3ccjzz4y/W+MfnKjXx+vS2sEihAhzjlzS29WMT+7DAstWlwqnklwJFyUEgxtk1JYTjCbXHlYFijaMtLjBE8dbLQ7s70fy9qH8s6IVFxtMmmdnKq+bM7IyJhQUGqgWdZtDT2K0h288gZ7mp2HXyXSC3rLdHyhdMSEmoKH/JV/+0ySElsSm9Qcvka5M+Aco9QyQ3CV8gnY+ICgjU+ViOk70m13Jy6nMNfvLNRbR+r+4D+pYpERxh0ZGIbus2TnuE37WvJdkkkySs5CHrz5bMSqQc31EtWNkYQYhFaBtrPxcb0y18pWi1gVcjwV2job0XWc77YWNTHCSmrmRnMvHBGGHIG3qdvVA8aWEEbpQ+ir9oA+Bol6oAc+z5jFMY5Va4+hu76fXS3UlXrpHgo5Cu/dhIKhXnDNl0bDC5MTmnzqzpn0/AVIicSYTk32m8cN52JjRONE38lm+lAjikJZd5loBdSC3EuFKMh3rMpxbNUsGfrSNcCBYQWizjLK6EK1rEsjFcv7plps8dd+yz4hobBYPSzBV9ru43g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(1590799021)(1800799009)(83380400001)(4326008)(5660300002)(1580799018)(6512007)(6506007)(31696002)(86362001)(85182001)(53546011)(6486002)(64756008)(2616005)(26005)(66556008)(66946007)(76116006)(66476007)(110136005)(36756003)(66446008)(91956017)(316002)(71200400001)(478600001)(54906003)(122000001)(82960400001)(38100700002)(38070700005)(8936002)(8676002)(41300700001)(2906002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlQ0TEt1N25rMzllN1YvTEk3NjhkVFJ6cVJ6R0dYbnYvclRLWUlUbzhzZmJi?=
 =?utf-8?B?UG5Qa0Q3QUVrS1FmbU1wK0JFeldvZWVKeW9FTTQ3WlJKOExsbGxRVTVSQUxX?=
 =?utf-8?B?UTh3Uy9EWXUrUmIwQ1hJeTZqTU8yTnFuVGJUaGM2QnpIeDRadUJsZE9sYWhZ?=
 =?utf-8?B?Qy9SUVgvUm9Jb2ZjbU81aFk0U3Q5Y3pLMSt0VUE5NVlPQitZN2o5QnJqWGk4?=
 =?utf-8?B?elZZS0ZRNTJBZjl5SVhtSFUvTktBdXpuSHp4T3dacXY2YzVSeGVnc1dVd0ti?=
 =?utf-8?B?ZlUwYTZLSG1hMy9FZW9majFnZk9BbGtvOWxlcmE2NmVJbHVlc0wrY3cxM3Ro?=
 =?utf-8?B?T1pHL3VhMkIzbW9KaWV4ajFWczYzRUtxSk96RkZRQTh4Zzk2Uk5sTGNOekdW?=
 =?utf-8?B?SGxjMVovQjZyWG1zWUwwQnpaa3F2cXU0aGZCd1FlSDVSVlZTWGVEOFRPaDV5?=
 =?utf-8?B?VXg1UVRtWkVTUENHRGRNbm9Xakg4bEFyWDk3VVg0NU1YU1ozZGRzTWpGZ05s?=
 =?utf-8?B?QXFxVzNHeUpiVzI0RTg1SG9ESU1XcldYOVdRbTJlM0hZbjVKdW9Db3FOZHVI?=
 =?utf-8?B?VGM1aXBWcDNaaCtvZlFpMmtvNkUyWFJkY0dtSEx4WFhPREpnQXRUVUt6eVF4?=
 =?utf-8?B?QXhPTnNJZ1V3b3lPYlpkYmpBZzJpa0V5QlFZTS8yUlJBUjIrMHBjRjF6M3Q5?=
 =?utf-8?B?QmZrdUg3Sks5ckFuajN6dlNmMk0zUEdCVjFaSFJJSGIzekI5LzFEOG9WNThN?=
 =?utf-8?B?QXhPbytJRDBRL2FxSGdieHVFRGNyU1J2TWRjL0FnRGVISENWRXdvWUdmYnN5?=
 =?utf-8?B?WUZ2WTR1ZjRHWXNZU1dYdVh5a1ZGWUNEUzFKZVRobEVkL1Y5YVFINkxwNGFL?=
 =?utf-8?B?MkFZNmtKUzVTaDB2VzF6NlAvQXkvZjZmRCt0amE0Nmc0T2t5dFNiRklNYjda?=
 =?utf-8?B?MFhtbjB0MFFOd3JXZURRSHZvdnVaMnN1dyt1UEFhWEMwYXFvOVlaMGhsSHd1?=
 =?utf-8?B?V3dJdzZnQTc3N0k0QUlMam03aktJMWlTdDY0dVZncE5yRkJsWjM0c3ZqNytz?=
 =?utf-8?B?U2JoVjQ3QXpvbUMxVTlEWVB2KzIzOXZrejV3N0lUbFNCbGFzMUQ5NGlHMlFj?=
 =?utf-8?B?ZHpJOGJmbjVkR3MvaHBGLzBqRU11ajg4NGdyT1Fzclgrdy9YOG1DQWFWUTkx?=
 =?utf-8?B?bGE2SXZvbFREcGFPWXdnanJ6U25RZEZZTEIrMmdudkRrb2M2ZWF6VXl2cHNi?=
 =?utf-8?B?RHB1c3BrVXg1dXdPbmwyOWpvanZ4eE40OUJPbGo5MmlyRVBBeXlQNVI3MjYr?=
 =?utf-8?B?OXUxZVRiUnhUaXRpbDN3ZHR0TWFRb204cTZnaWdSSDNqc2dOejh1UjlWNGVB?=
 =?utf-8?B?WWZpM2VEYVhudUZHYUlYRE9ZZnc1aUdDNzNoRHpGdnNnbXlzMG1JRVMvVWdp?=
 =?utf-8?B?bEdncjNMYVdjNmtTcEg4RzJyQnNPQVdjb1AvMmtaeEQ2eDg3Z2hXdndibGJa?=
 =?utf-8?B?WFkxVUk4R0h2eUxST0VUQ1RydEx5YXZXemNCZm1iV2JTUG1LdDBLbmlrUUd2?=
 =?utf-8?B?MG8wMHI3VGdpK3FEUllubzEwSENWNUFYd01sZXlqdGQ2bXJ1ayszcmpYL0tU?=
 =?utf-8?B?dGRXTWExVzlDaStKdnhZSjZxdW9yOEdiV1ZDUHE1eWZPZjRiMnBhQSt3SWcx?=
 =?utf-8?B?cWVlZWJsTDZGMGgvajFvaEpuVUpla2hVRmhBMmdZRXFIanI1ajhYS2k5Vk5N?=
 =?utf-8?B?Y3NVa0U4S0NmMFQ2MWZVRm1sU2tHSzJKSFdxNGhUK1kxSHN1bWxrZCt5cGVK?=
 =?utf-8?B?bmVKNSs3UVVZOCtaT2ZkV2pIQVUrc3lMRFVRRTFiQWxJVHl0MlF1MHlzclVB?=
 =?utf-8?B?YWhOMVFQUUlPT0FydTJZektFZ1k0YXpNMEJSUUtlZjF5YzRiS3Uwa1ZCQW1a?=
 =?utf-8?B?Q1dnQ2M3ZTJHTmdYeEdxQUlxMXRqT0J0UlRNNk1LTnZFY3dyRWhpMC82R1NJ?=
 =?utf-8?B?ZDJ4bytQS1d2bU8yQXVsZ3BpdzM5eERLcEpSN0dIZ1RSZkVnUzB0UnYwTFZB?=
 =?utf-8?B?MS9oOWtOejkrYWZMMUxWRUVqQ1pjakpUMVdHQ2xJdWYyUUJVNUN1c3lJMnpo?=
 =?utf-8?B?Mm5TVFl1TXlDWUduZVRmWUZROFZjUktYYjhyZ0pSZWxVQ290VnBxcDZqcTRS?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75C6B07D20798846884556E7EC60352F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DBo8DOFa4n/h7CMq+52ldAVvXRnkQg6qgmuHfVueXzfszSABioNVUBcqiqORVVyl9EcK4/4slI+Ud7bvy3cwK1khN9UkkSf9dKiC2A47hvNRGqwSw3rfJRYeuveid4Q/2i6pwtVGEh97EX9SArsIlJMvixG6FCKGX2kWBBBQDmuf0v5oR/bdNmnXAHLfu98swhrx+g92OnaD1xpdk20iBUJAtjpQjMzx8FS/A9GuvhUGw10q/A08Rxrvof48+GeHy+DzXDiSxCbW8QhAEBw7bUPmwA8kGxnXvcewip8S00JrsTsowF/l9eaRVLum3nw5JWF5Ig+csBpl1v4SLqnGDrQlKhBFCJwl3W1a9nkX/dQh1vV3bGZE8o7Bx/dajms34HJTi7rveokJRNldRX+I8bYRdGXTc5hELJ5hFYquI0/l1eEaINlogTBYLCVoz6hxSEgfcMeShV0DCVMi1oha9AHgNYTNxq/ixLFu7o4YfSO19P7SHd5zIeiCPfcAZpwR4zkh4x6E767X7ZGqPwIY0l1ICTloGFhmyhvgrT3IIIdxrDgF3AcwJifcR1X9K6JPrOAyGgJ0o9LVPZKkt50rGA+VrpSN0bWLvcg8vvvMivKT83B/0bMcNzgkQ5E3af93kD7jWtjeoDWU9+ymxqNksBnUPErGrp4sqaX2uXm/M87g99msoRXdMrSq5sY+WzuyksGDBxF4MKRfUf387CstLCOI6o+q7tAG/8KPVb+Qs9+akWubWTWsZac3bZ0Y762SkSWkvp5vCERcceuno4Mln+pZgY7ZH7etsQkE1Zvjaug=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59972ee3-ca8b-4626-6d08-08dbbe547d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 05:50:28.8135 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcIA97mA7WM+HJ+pWlrcy+5laEZvO+22ZDCBFnnrlBy8Pf3Iclb02iG6oOQe9Lv8RCzZGUTSypWotY0UverAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5891
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
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
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfd3JpdGVfZmx1c2go
KSB2aW9sYXRlcyB0aGlzIHByaW5jaXBsZTogaXQgY2FsbHMNCj4gZXJyb3JfcmVwb3J0KCkgdmlh
IHFlbXVfcmRtYV93cml0ZV9vbmUoKS4gIEkgZWxlY3RlZCBub3QgdG8NCj4gaW52ZXN0aWdhdGUg
aG93IGNhbGxlcnMgaGFuZGxlIHRoZSBlcnJvciwgaS5lLiBwcmVjaXNlIGltcGFjdCBpcyBub3QN
Cj4ga25vd24uDQo+IA0KPiBDbGVhbiB0aGlzIHVwIGJ5IGNvbnZlcnRpbmcgcWVtdV9yZG1hX3dy
aXRlX29uZSgpIHRvIEVycm9yLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFybWJydXN0
ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAyNSAr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1h
LmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IGMzYzMzZmUyNDIuLjliOGNiYWRmY2QgMTAw
NjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0K
PiBAQCAtMjAxOSw5ICsyMDE5LDggQEAgc3RhdGljIGludCBxZW11X3JkbWFfZXhjaGFuZ2VfcmVj
dihSRE1BQ29udGV4dCAqcmRtYSwgUkRNQUNvbnRyb2xIZWFkZXIgKmhlYWQsDQo+ICAgICovDQo+
ICAgc3RhdGljIGludCBxZW11X3JkbWFfd3JpdGVfb25lKFFFTVVGaWxlICpmLCBSRE1BQ29udGV4
dCAqcmRtYSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGN1cnJlbnRf
aW5kZXgsIHVpbnQ2NF90IGN1cnJlbnRfYWRkciwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCBsZW5ndGgpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdWludDY0X3QgbGVuZ3RoLCBFcnJvciAqKmVycnApDQo+ICAgew0KPiAtICAgIEVycm9yICpl
cnIgPSBOVUxMOw0KPiAgICAgICBzdHJ1Y3QgaWJ2X3NnZSBzZ2U7DQo+ICAgICAgIHN0cnVjdCBp
YnZfc2VuZF93ciBzZW5kX3dyID0geyAwIH07DQo+ICAgICAgIHN0cnVjdCBpYnZfc2VuZF93ciAq
YmFkX3dyOw0KDQpbLi4uXQ0KDQo+ICAgICAgICAgICB9DQo+IEBAIC0yMjE5LDcgKzIyMTYsNyBA
QCByZXRyeToNCj4gICAgICAgICAgIGdvdG8gcmV0cnk7DQo+ICAgDQo+ICAgICAgIH0gZWxzZSBp
ZiAocmV0ID4gMCkgew0KPiAtICAgICAgICBwZXJyb3IoInJkbWEgbWlncmF0aW9uOiBwb3N0IHJk
bWEgd3JpdGUgZmFpbGVkIik7DQo+ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgInJkbWEgbWln
cmF0aW9uOiBwb3N0IHJkbWEgd3JpdGUgZmFpbGVkIik7DQoNCkl0IHJlbWluZHMgdGhhdCBkbyB5
b3UgbWlzcyB0byB1c2UgZXJyb3Jfc2V0Z19lcnJubygpIGluc3RlYWQuDQoNCg0KDQoNCg0KPiAg
ICAgICAgICAgcmV0dXJuIC0xOw0KPiAgICAgICB9

