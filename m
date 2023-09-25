Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA8D7AD1B4
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:33:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkg4z-0006Xa-JJ; Mon, 25 Sep 2023 03:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkg4v-0006XN-7Y
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:32:25 -0400
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qkg4s-0003oR-70
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 03:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695627141; x=1727163141;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0KFoWs6s5EGg4TBE16/Bjrd0am+CduXhtPjAmzx/kIw=;
 b=TrjtDlLEe756oZAoposV+zBIe7uHHcCTTwT3alLx8KWqPRcalARNdUkf
 pVoKhhmVoP9+jCUYv5kSonP+9YCKSs5PGwPnWyRUGJ/70VFx0dI2CwB3W
 sc97cQwiDDmLnL4FG1mYGehA/MoqTzXTZLouIuw/Pp34XPuLJErZ2gkxy
 CWefGaN7Ix5DZ++0XTMlwtufwPM5A8EGyppZBmYrFkamW9sLW5wW3/1A/
 yWSQ+qp2aUL5Z+6zO397dNB/U2AY5uF8Sr3DGW0UeXoa3nKiUrBcxUIms
 VdvLy+vrE+8Pn/kY9HrUOJ17+n6BulrDNkHxBQOmXjtycloCtxm80AH0F Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96588952"
X-IronPort-AV: E=Sophos;i="6.03,174,1694703600"; d="scan'208";a="96588952"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2023 16:32:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NY0tUAUbPvyY6qBqwC8O968J4oPtbPok0mGRFctt04ODAISbmPxFdqURN0Hj92tApuG8bP3FFr62KtrV4Yfwm5nJgeRvdt9rVpZF1uQlDxTsimUdKlprPP4CVvBCwO8v+uQdYbkE7pKglncVvmsCEkm0zCieJ19xxiksF9OgWVqd4YYujStM2EFm7BRWdBB4gSkubhdxf5LeNECI6Esr2u3vQhHD6d9VYht5z/wBd+Gg0FGw9sdDjBugXjw+LKPN7DLtBfkSdHms81vXCX3XKjtuRXZ9+Txn72nj7fiRck2s/SYFvPKvf5xcFjXT1mQ2Z9r+WnHqfve2AXyjjkm7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KFoWs6s5EGg4TBE16/Bjrd0am+CduXhtPjAmzx/kIw=;
 b=Z3Z4Uz3OgEUqvSVFejgsYndzavNfjM9hCUxtu95pVRijJ7PDDOwSA+5NCUvqtMEH8XhP65nniYfyj41BAUe4lt257d+oGI4T8iskf+h+rqoABfQZmfz+1/0QVA858rrKDmOhK0ZgZGrglMwUIB4cb5S99NU4euXUfersMKSOd1wwVZvmxjwK0Ts1fUhtgDG+pkdlhyyzjVipzIM105zeWrpVsECwx1PPzsYi+0B6DEY8OXN3knU/+ZJWuuLCvkgbZ3oQVPc5aw1RTjyV6vCLzU/XkJhg0TUMlUxsr4YA34Gx0hH/MVcC4orCnIdyJUreHBGGXUp8HMNbNClmCbeyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OS3PR01MB10171.jpnprd01.prod.outlook.com (2603:1096:604:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 07:32:12 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 07:32:12 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 32/52] migration/rdma: Fix error handling around
 rdma_getaddrinfo()
Thread-Topic: [PATCH 32/52] migration/rdma: Fix error handling around
 rdma_getaddrinfo()
Thread-Index: AQHZ6j8/mwbv2hAb1UKMdC2ceUh7T7ArMEYA
Date: Mon, 25 Sep 2023 07:32:12 +0000
Message-ID: <0881512d-05d3-24f5-26bc-34cb01c0c8af@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-33-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-33-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OS3PR01MB10171:EE_
x-ms-office365-filtering-correlation-id: c2ae82e7-4991-4cc3-c14a-08dbbd9988eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 10AipkK8Sgh37AjH3J7AKa9yY13t9Gk63uYMdwoeMHZd645y+p1vcQ4cP++GptIj9ybZoWYZF25rEX5sxYa/wbGZun2bpVpzXSErfIWavKxo26Ebb2NwajmlSk5T/bK4LHxwj5iCG+fW+3o/D4X9CJVDcicfA2PHAynQ3TI2dHomwN3tIswXKJZRfRBelAttm0DeVHFn7spqeUDP3KNnraXy2HvwutczKjUUteZ6vvQSpVIW4glFIZQFrPh6wYGgflz4zQMdBEO5+lYw29WTNDAa+5ki1wPHyoo+Eljvl4Lao7pA8MwLKyQBm6EQ5khLWCdG2w6T8CuKQI4ixWNSc5z6fVPmW+QrF36nCT5Ingyt8N09VfLrgSYj3Wkj61vYiHO0wyC7HzLs4lTPp2S1hvIHrxz8s6fsMcKzAucjtxpXKFXVodw+ehkQJ6ei4hiTQlNTiEvIJU0LquFv9PiNbQJ4nuFdIc8Elg/DVcPZ+U80NFHxwHmUqoH7nee2FvPO6l/DELmULuYSO1spRDSUmTilUDuUqsQXyvGKA1qWgE23mNVlclpua0BuzTue/S1OPRPVypNJFKs/6ZOgSMkLlnZSGUvWNyGEdicMBIT2U+VaQNkTviAy7WYxGTF3BPRYoRd1hA7jylaT/Yod7TQJv7ITp9C8XLKLa81JI6cFp96ODimofxvD+PmDuDGU+SazWqVxDErcE92q1kjzUXK9xw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(1590799021)(31686004)(1580799018)(54906003)(83380400001)(2906002)(5660300002)(316002)(41300700001)(8676002)(8936002)(36756003)(4326008)(85182001)(2616005)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(86362001)(31696002)(110136005)(91956017)(6486002)(53546011)(6512007)(6506007)(26005)(71200400001)(82960400001)(122000001)(38070700005)(38100700002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NWhWNmlqVXZmMUdsbS9JT2ZjUWFTT1M3QVNHaTRhQkVZSHRqZDRhZU5LWE5w?=
 =?utf-8?B?Qk16ckVHNkR2VDhXSHVIUHcvZGl1TWZYYnN2RTNmNlljNGtBcmRPbFpQTnZn?=
 =?utf-8?B?V0U0ODVqK2tkeEs1RllqbHV5WDdhaUJMUnVwdVdWTkFYazNieUNZb21tQ0dr?=
 =?utf-8?B?S21oRVMwU1BudWdqb08xeFF6U2RTU1M5S216TWQ0WmtuMFVHM2kwQ3pFYzJS?=
 =?utf-8?B?K2o2djhLQnVibXdZMnBCTjQrekpXYUsvdXNTTGwxR0kyNTgvWW5iaDdyOHIr?=
 =?utf-8?B?ZWRJL3F2QzRyNldTVEdQMlMvWmxHaHBhZmcyNTdlcDdrdHBUYk5ha21sWHM0?=
 =?utf-8?B?bVFzbjYycTQ0NWFEb0RzUG80N1Q2d1FXQ2xyWU91c1BpQ0tBT3daZkd5bVVr?=
 =?utf-8?B?Sys4eUpyc0R0dVJzdmNBc2tIUzg3dFBVeXpkRkFETmpaWXJjd0lyUzhnS3py?=
 =?utf-8?B?bGZaV3FlZ25KWWFvL2IvUVppSFlrbC80RGI3MVZjQ3ovVXM1S3dLc0lNcHFj?=
 =?utf-8?B?VERMNk95dFROL3NraVRLZGV1NlVZRHY5dG1jYTRiejN4MDlqd0pBNnlGZEJo?=
 =?utf-8?B?MzZCcWJKb04zeCt0blNVR1ZHNWRxZENXT3hvOTRWK2JEZSsvNHcwNFl3R1Vl?=
 =?utf-8?B?amc0WmdySDVhV096NlpoN2JWcStscVAxVjJyQ2RVL3RRQThSNk5rZGpQVVIr?=
 =?utf-8?B?aFE2emdBL0JoMXpPZDViZ1pMQnd3b0hQTHJVZGlUNTBXRHN0dVBmZ1h0bnVk?=
 =?utf-8?B?N0x2Zm40T290dSt1QVhXaWd3Q1ZxQVhhWS9MVG82VHZENFhtUlkybEdib0FQ?=
 =?utf-8?B?MzJYUDNyb1FJbG0xMnFTSWxMUmtkZmppdEQwN3dENXg2SnFBN2RzdmZNNHRT?=
 =?utf-8?B?Zzd5eDhici9oWjg3WkJlZWpCS09JQ1dmQ2xuWnZKdWlEZnpXNC9LTXNHUk1t?=
 =?utf-8?B?bDZBMmlqYzdMTi9XcFlyVmxxdmZpaDZjMlNZU3M4YUx5cGJrMmdYa1FtUTA0?=
 =?utf-8?B?RGhMTjJYbEhXbjRnb2tZQVNmdEJPYW10c1hXbVVRdytHNkUxclFsWTVsZUJl?=
 =?utf-8?B?SG42ZTg2RldzSVZLMElnc0RrUDJlRkZTUGxlRFNacXF6OGxhR1N2VnFKenBZ?=
 =?utf-8?B?Q3B5T0Nud1dWMEpPcS9ONU9jQStyMlJrbEluQmlCKzhRaG1pSExkaFRsczM2?=
 =?utf-8?B?bXF3Uk1TWkFuWGdYN21VajQvRjFUOUdWcFE0TEw3TlhrenB3d0lyNi9wcnBs?=
 =?utf-8?B?RTRZSHcrMytFaEhpNjhKMTZpVFZCenVibEgzVUZJNDJ1Mm5UdkxveVAvRkdN?=
 =?utf-8?B?cWtrWU0vK0FJOHlIRzNMWkhzZWVIYnBsR2hlVVM1NENxdTR4UStYRG1wWUdR?=
 =?utf-8?B?cWRibTRkdGJDK1ZHenFYSGhreFl6Z0tQd2xEem9PbzVRRVhDZ0dDdDRmV2Rx?=
 =?utf-8?B?M0c5RmNwQlFtMFVhbENlcnNiSThha3FLUFlveEJEUTZwM2Rsek03Uk9YV0k2?=
 =?utf-8?B?eTFLSS9YVVlhc2ZjbVUyQko1K2RlbFk3NUc0Nm1RNlZlMHVsZSs0Y09xeXZk?=
 =?utf-8?B?K0s4b3d3dS9rVzVTU2VsTlRUbEQxVXlhd2F4L2JRUFVaUVhBTlJ3U1puWTdZ?=
 =?utf-8?B?UjFYK3pNWTljZU5PRHdRNTJMTVBwS2o2ejFJbEFhaWt1UVoxTzcvTGNrT1ps?=
 =?utf-8?B?SnBlcEoycW1TdzdONHR5SXNzVi9rWUxQSDdSeU5acG1OYnE4Tnd2bW56UXBx?=
 =?utf-8?B?bHpCTzcyRXNveFFJV200VnNlQXVCNzUwLzJHd09CTmltRlhzL2wwd3JhSVRx?=
 =?utf-8?B?VjUyU3B5aXRSZER6bXkvd0xBcjVsamREaitwZ25CbWRLMlIvRmE0eGU2S2JE?=
 =?utf-8?B?UGxxLzN2SHNuRDQyaDRHaERub081T21WZ0hPUkJQSHlhckVaQ3BsMlNyMWE2?=
 =?utf-8?B?bHEvM2ZURzMxRXlFWkpkUjI4dGVtWWt3Z1BQUkxWOXZ5U3NJN0xKVGV4Z0ZJ?=
 =?utf-8?B?OWVVTEExOExUNjdjSnlrcFhmNGJ1eWdCeTlkNW5BaGt6clBvY2dqR0FXOFdP?=
 =?utf-8?B?Z2I1cEIrL3dKdjlWNXVpODhaUXBVRzlhUTVRc1dBSlIzMmFuUjBzUFFWZW9G?=
 =?utf-8?B?U1c5N1JlUDJsOUVTVlFXRVUzcC9CZGt2R2g2cWg0YUVtRE5MU3JKUDhDWThB?=
 =?utf-8?B?Q0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4AEEA28073BFDE4CA18D9ACCF4D13543@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b03h7mreGrK4DFhpAJKGBlbiCKKnxgIX8hKvlHzLP1Zodc0cUCGvWVIu0Y6eersMz/ZzZLnOZwar40jgqiqtHYZY/Gh14KTUGY5T6giuxX3HXZBwAfQ+Z7SIyhG4t0RR0OreseWBwRbTWjd0nvkL2vQUjqGIRdnp39gP+5XJMx0VffLrn2/9HOBUCupwkXknvWnzOEsrsRlJo1ZBGXiGxk6YcTr0R3JHx+pxKW8YbGBaytKh1B8kjhj7YX5dQ/aDr4tN9dRxLG6TEjHT7roBTtgtEe5Wz8rV2EN+Oraq+VHjjsgtOoX8wZV70YUWJ198reBVHTpXnxs/PKlMmBt3tiMoFb0H6xUf9/ItlG3iyp2v/pdONrey74gWotzstfEbFAJPJnNUNWdEbYSa1L0thJ/IuACPvZRhu/gmzeMkqQBoolT7Zqam7IZD+7OvgWq7YUVEPhtMkyK870CpOwJP453wt2zO+EUNg8WcFvfwR7dgtalFvf9dl+UfiwT5TFAoSLGMiQszuEoCVhtYE3HRLUaUqCfAb8xkZWWSiE+R95k+IUuWIv6jfud8VKS3MsnMx5Qa64JVqRxbNxn2f1KsttBhUtjUOjbc70hiqa7MAA+26Am+33pBLrEb7Q65M/BJy4WvSjPS029sfsXnTOwsqqPzwrXYi4TPtWEf1FVGM2kVGw82+q8xnH/G0ZKu2sxna+B0LpMAMq+Nd7pKi7Bz+aoNdUb09IceBUmiGlG0qUb+JXMbbJ/8soYOxmVCzFTCUsTzjJBN4M+KNChRORe/j855ifKlv4g0FKzm/B4yiik=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ae82e7-4991-4cc3-c14a-08dbbd9988eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 07:32:12.7374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98+AUkR5NKpJoLB3OEQTpbCxV49qOTc7zZ9C6VpVSvJgYeeJmMCoMnrS/p06g30U3RWgy18sTqtNjzLIILSZsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10171
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfcmVzb2x2ZV9ob3N0KCkgYW5kIHFlbXVfcmRtYV9kZXN0X2luaXQoKSBpdGVyYXRlIG92
ZXINCj4gYWRkcmVzc2VzIHRvIGZpbmQgb25lIHRoYXQgd29ya3MsIGhvbGRpbmcgb250byB0aGUg
Zmlyc3QgRXJyb3IgZnJvbQ0KPiBxZW11X3JkbWFfYnJva2VuX2lwdjZfa2VybmVsKCkgZm9yIHVz
ZSB3aGVuIG5vIGFkZHJlc3Mgd29ya3MuICBJc3N1ZXM6DQo+IA0KPiAxLiBJZiBAZXJycCB3YXMg
JmVycm9yX2Fib3J0IG9yICZlcnJvcl9mYXRhbCwgd2UnZCB0ZXJtaW5hdGUgaW5zdGVhZA0KPiAg
ICAgb2YgdHJ5aW5nIHRoZSBuZXh0IGFkZHJlc3MuICBDYW4ndCBhY3R1YWxseSBoYXBwZW4sIHNp
bmNlIG5vIGNhbGxlcg0KPiAgICAgcGFzc2VzIHRoZXNlIGFyZ3VtZW50cy4NCj4gDQo+IDIuIFdo
ZW4gQGVycnAgaXMgYSBwb2ludGVyIHRvIGEgdmFyaWFibGUgY29udGFpbmluZyBOVUxMLCBhbmQN
Cj4gICAgIHFlbXVfcmRtYV9icm9rZW5faXB2Nl9rZXJuZWwoKSBmYWlscywgdGhlIHZhcmlhYmxl
IG5vIGxvbmdlcg0KPiAgICAgY29udGFpbnMgTlVMTC4gIFN1YnNlcXVlbnQgaXRlcmF0aW9ucyBw
YXNzIGl0IGFnYWluLCB2aW9sYXRpbmcNCj4gICAgIEVycm9yIHVzYWdlIHJ1bGVzLiAgRGFuZ2Vy
b3VzLCBhcyBzZXR0aW5nIGFuIGVycm9yIHdvdWxkIHRoZW4gdHJpcA0KPiAgICAgZXJyb3Jfc2V0
digpJ3MgYXNzZXJ0aW9uLiAgV29ya3Mgb25seSBiZWNhdXNlDQo+ICAgICBxZW11X3JkbWFfYnJv
a2VuX2lwdjZfa2VybmVsKCkgYW5kIHRoZSBjb2RlIGZvbGxvd2luZyB0aGUgbG9vcHMNCj4gICAg
IGNhcmVmdWxseSBhdm9pZHMgc2V0dGluZyBhIHNlY29uZCBlcnJvci4NCj4gDQo+IDMuIElmIHFl
bXVfcmRtYV9icm9rZW5faXB2Nl9rZXJuZWwoKSBmYWlscywgYW5kIHRoZW4gYSBsYXRlciBpdGVy
YXRpb24NCj4gICAgIGZpbmRzIGEgd29ya2luZyBhZGRyZXNzLCBAZXJycCBzdGlsbCBob2xkcyB0
aGUgZmlyc3QgZXJyb3IgZnJvbQ0KPiAgICAgcWVtdV9yZG1hX2Jyb2tlbl9pcHY2X2tlcm5lbCgp
LiAgSWYgd2UgdGhlbiBydW4gaW50byBhbm90aGVyIGVycm9yLA0KPiAgICAgd2UgcmVwb3J0IHRo
ZSBxZW11X3JkbWFfYnJva2VuX2lwdjZfa2VybmVsKCkgZmFpbHVyZSBpbnN0ZWFkLg0KPiANCj4g
NC4gSWYgd2UgZG9uJ3QgcnVuIGludG8gYW5vdGhlciBlcnJvciwgd2UgbGVhayB0aGUgRXJyb3Ig
b2JqZWN0Lg0KPiANCj4gVXNlIGEgbG9jYWwgZXJyb3IgdmFyaWFibGUsIGFuZCBwcm9wYWdhdGUg
dG8gQGVycnAuICBUaGlzIGZpeGVzIDMuIGFuZA0KPiBhbHNvIGNsZWFucyB1cCAxIGFuZCBwYXJ0
bHkgMi4NCj4gDQo+IEZyZWUgdGhpcyBlcnJvciB3aGVuIHdlIGhhdmUgYSB3b3JraW5nIGFkZHJl
c3MuICBUaGlzIGZpeGVzIDQuDQo+IA0KPiBQYXNzIHRoZSBsb2NhbCBlcnJvciB2YXJpYWJsZSB0
byBxZW11X3JkbWFfYnJva2VuX2lwdjZfa2VybmVsKCkgb25seQ0KPiB1bnRpbCBpdCBmYWlscy4g
IFBhc3MgbnVsbCBvbiBhbnkgbGF0ZXIgaXRlcmF0aW9ucy4gIFRoaXMgY2xlYW5zIHVwDQo+IHRo
ZSByZW1haW5kZXIgb2YgMi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4NCg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0K

