Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD547AF7BB
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 03:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlJYt-0001rC-JH; Tue, 26 Sep 2023 21:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qlJYr-0001qx-E1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 21:41:57 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qlJYo-0006EM-M8
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 21:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695778915; x=1727314915;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=ZS7wxpzix5ZD5+EoMWh9sC7tbZmYorJge47kZW8Nsls=;
 b=HcR28c5KqPacpdyPoOCvs1iJ4+6DijRGfAu0H/HZ0ip/zhZ3rPDasxQr
 tgJughMn7mAz/BnMChcUUNoaKbs8vwYcjckDNQrPcM03ZiQieq4wOXJ4N
 TQKX+wmLELbCZpcAmmPXCiQ6x+5aVoOBneFX3wRNCTOseGMRVW9wiQLQK
 0JilEvv/KYTpH/xQ870WE7liqVjFqtQ/tmaQvK8PNNuk4SICccea2tG+h
 1Cz6jyss/S20SPU+suLWoN4YGdMbXzVrmR1uMRBxvpGQ7/zRBwQ2jjZo3
 V15y9dTJsAd4LdSysutz2cOfnnw3TJREPABfAm/JRPkFJ1QmfHl2U81ae w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="96962039"
X-IronPort-AV: E=Sophos;i="6.03,179,1694703600"; d="scan'208";a="96962039"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 10:41:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2leXBfqd9xYRkPQCIAq3OXPP6RcPXNb7VBopGfFvtLuaUySHevTxqpNW0v7B/8cBQRLcIkI/BWUhezxfcMcZmjpN0TI1xDqFsb88hNMT0N1Hnl13SsMOz6PH0iah/2JKS6rTKsIxM4TM+AKKzp4/ecxhBEXug9gPhllWMRjcn3/lSqaCoSQLPFd4m5cbiEsdgektt7msWzDtzA7EnsBoBScErYCHX7anEb6gRLF3VM8l7SXY1IUx4HzHylcufl5gEuDTMGmlO/bfcTATwvTRGGJJN67mw4puT5sv5nHW1DeXrFHf/CKWlbE3QB6S3pyuRZ6IOFm1QojyR6CbtAu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZS7wxpzix5ZD5+EoMWh9sC7tbZmYorJge47kZW8Nsls=;
 b=TCGQIbGu5ygygUMdgsB8FurGKcJ/6c8rKosBjTDZTbANjujIS72LDOxnCQXwq6ocUYlI1TtMS2bV3iEz/xGldeFUCDdBdBDciHW3WktZPxXbOBw9CkaproJ04aHdDqQEBkTwzBv+ho+QsatDMu2dDrGqkLFsyRKH5v2qVt5o104er+WPaWouVzOcKl1b/D5ecl+fQeXyUfz7QlVclKi6KoJbWMKJ6hLkexyEI00RTS/kxYdVF8wIn6AlqT8UN03TdR4a3zrtAQrWFz7FEoaoonW9rE6L/wAH37gDYHtwO/uME6FDqRcgE4Uef8puwXycBVKX46f50EzyeaPDBNplFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB8387.jpnprd01.prod.outlook.com (2603:1096:604:16d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.21; Wed, 27 Sep
 2023 01:41:45 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 01:41:45 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 50/52] migration/rdma: Silence qemu_rdma_cleanup()
Thread-Topic: [PATCH 50/52] migration/rdma: Silence qemu_rdma_cleanup()
Thread-Index: AQHZ6j6sSuBrAso4tEKEPj5/VVeqYbAs74OAgAAb8bCAAOeXgA==
Date: Wed, 27 Sep 2023 01:41:45 +0000
Message-ID: <31bc784d-48d5-9baa-75fb-371e73563383@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-51-armbru@redhat.com>
 <2f697774-aea3-6f09-e781-cc1634021933@fujitsu.com>
 <87y1gt40dy.fsf@pond.sub.org>
In-Reply-To: <87y1gt40dy.fsf@pond.sub.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB8387:EE_
x-ms-office365-filtering-correlation-id: 30fc102c-247b-42e0-f783-08dbbefae86a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H1PLUI5ZokYU3ogfErpks0SnvMoae58FXzjnjrRmBOiWQripLgiOFqQLiXiRJJOvvbq9w7tWaZgmlo4+IHm714BvA7hdf8BTqmjmOGkjBvj7P9RZy4MDxOllrK0wOB/PbKUnAPVbLKuM765N6V1XZmVSRrbn+K5hxJpq//5PLDWyb246y3fbc6WUO+5GgsAYh63bYWdcoWJxOXGneWjLTAX2UbM2hWFLuFZEcx0jB4s7zhAKQqyQ5yOhEZfmGJeETsIuqPmditPMzUa/M8D6Y12o259AQ7mdSwuSQYOQ0Zs3b9KnryU2WVzwaprj2UVkUHwZ4mOrlLnTu0bxH374PdhZL2egy+QYnghe61MOqwz7Onux3iKZAEaOUbRr4+1sbQzYhMm/rDqz7ODktbdRYeROdO5JPk88HVGw59bRceFmHBS7+BgAWExJtfc4NIdM1y74QDb3EmzhIKaQnrMf0ZR9Ecxcdf6M2XNgJG70+zMvc0Qw6/LeKSv/rvazX9cZpeaQ0b+1vZ4YeW/UL/5R/i90xDXVe/pkzImO+jn7icki9jgA+z8plqSCzqVaJ9YcJxDSU4XSTIKFOUe8gyXuDjv87InV8NWVcS1b04Pj7mf6If8NbY3C38uHNQXU5Tt17nBimM396apskfZKUfZxJuqq97DCYUSSVWeU/Z1lLgXEP9ELtMeVqACZ+suX2/F6M+2zIbxT9s2oN9HODi0A7Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(186009)(1800799009)(1590799021)(451199024)(2616005)(26005)(1580799018)(53546011)(6506007)(6512007)(38070700005)(31696002)(86362001)(122000001)(36756003)(82960400001)(85182001)(38100700002)(83380400001)(76116006)(91956017)(31686004)(2906002)(54906003)(64756008)(6916009)(316002)(66946007)(66476007)(66446008)(8936002)(41300700001)(4326008)(8676002)(66556008)(5660300002)(71200400001)(6486002)(478600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUMvZVZFYkphTnJLNjhLb21zMzk5TlFKaDJndTdmSE5HU1pPODIxMWF3QjVO?=
 =?utf-8?B?NThFRitWT0hVelFMbVR5bHl3a1NsZUhUVjJxRG5ISGpGQkxQUmUvbCtVYnpH?=
 =?utf-8?B?TEU0L09CdEdXNnJkdE96NEZiRFdVZC9kS3VqV3VXT3UyVE5ITEtTVHZhMDlt?=
 =?utf-8?B?THpmVFNzS0t6K0tqejQ1SzlUVHdIcjRNSjhoVlhLVU54VEpFb0JFbktwQXBM?=
 =?utf-8?B?anhWaVRzMlBwRG8yTnVPR0l4eDlsSENDU1B6Z25uRlJSRzN3ODIyRUp4MElX?=
 =?utf-8?B?N096VHcxK1E5REhhVkMvWk1Rb1RjTWtzUE1FZkRnUUREWW52OGJpUVRWVmZh?=
 =?utf-8?B?ZFRRa0RGelJGbWhNRU56OUFhRytOWXBwWWJQWDh2MHd0ODIzb25CNmhIc1RL?=
 =?utf-8?B?MWNMTnQ3MWpwWGJSUDJ2cm5tL3UxZTFTN0xJVjRsVEkrSys1NUMwMGRZQ3Zi?=
 =?utf-8?B?ZGdUSHFaczJNSksvdUdMNkNIZVRXRllvZ0tMeGlZT3g4VCswc3FBSzZUQmw3?=
 =?utf-8?B?QXhQWlk1WC8zYXlZZWRtYnkreGRSZDFqanNsUmNmbWhyck9NZDlZcS9od3ND?=
 =?utf-8?B?U3JvWjhCUjc3UW83NHIySUZpeTc0Yy9XQ1hCZjJXYVkwNzh2ZnRhUjlLM0Zy?=
 =?utf-8?B?ZHcweG1jSnMvSTdIamt5bUUzWDVaSVd3SEpNUXU1cFdETFhGdnpGckw3T3U3?=
 =?utf-8?B?TTJEVEFjNDdJbTVzZ2hnTGhBUXpSZW42a2VIWXpxTmxlY0VRNWp6SkR0a2Nw?=
 =?utf-8?B?UVpOY1h0OVBFRUxFQ3NYaGtPcHd1OUZmMHRqWGV2K0dCZ1pKd0VxY0RxVWxj?=
 =?utf-8?B?U1IwcmxXRUFySXZjUE9OMDJpN1NreXFKUmVUOWQ4cGFVbUpmMkZFbW5DSHlO?=
 =?utf-8?B?TkduOFFXTVEzbFNOQmRvVFRrZm1teVZib29wRlBiUlhuMEoxbEdOU3JzT3gr?=
 =?utf-8?B?eW5tS3B0eDNFODlOcFlJNmNsOXBQRG5hN0dPekpRQ3FwWGZxQ1IvNURVeU1I?=
 =?utf-8?B?QXF4WU1HMWdoZHkyL1Rxa2RZVGthRmFkcTcrU2xmUUlIN2w4ZFV6MmtjK0Ux?=
 =?utf-8?B?RHYzcmhRTTF2MTN3d0RoLzhId3RyVTdoUGNIZXdEd3VhQkFFeXdQb2FLcGVB?=
 =?utf-8?B?TVdQTEgyNzBDVDdibVZrQlFDMHV1elpRR2xEcjU3V05HYmQ3YXB1emZzZ2tn?=
 =?utf-8?B?VDNzY2NKdlRaZTlJNkJlWTNRczhkaHN0R3lMbjBkQjF5SU03ZG82K1lMSWc5?=
 =?utf-8?B?QTJnTnRKVHdCeEs3bXhQK3grK2lLbHZNY09GdFRYUmxmVks2cVJzbFFwODg5?=
 =?utf-8?B?bmlSRDlLR2tyS1ZHY2wrSURzYzR4NWN1cG9pZlU2WTJrTlBMd1dUM1pGSTJn?=
 =?utf-8?B?R2F5M1hCbU9yK3RJd3lya2hCNU5EYWtFamhwSEF5UlJsZnMvSjQrWHlSN0JT?=
 =?utf-8?B?a01DcXZzWHZpK0dXSGxTclpLWFEwekVESDhibC9UWnFRU0xKMFd0MHRSSFBk?=
 =?utf-8?B?VUdGR0dBazcxU3JHY2Y3NEZ3Q0VOYlVOWGtnZjFPZWtudjY3R3EraW80dXZr?=
 =?utf-8?B?Tzc1NmNpT2xWT2NPQUI4N3NEcFcxcVN5ZzF2TThYS1NhZkV0RkJ2dUhieVhv?=
 =?utf-8?B?UktxY0JBTUk4d2g3aWRhY05tR05XdGFvT3dEQTdLZkhqcm9NeHY5SEhVc2Zs?=
 =?utf-8?B?QUxsSW5ENUlKWUd5S0M1bno3RTNHYU9OcDRXMzE1M3h2dmxMOU4vZFJJbmh0?=
 =?utf-8?B?UnkzS2tJMU93UzFnZmVSUTdRZDZWMGxNeXNTbU1LSHlDQi9zdm1mdkdGZWNB?=
 =?utf-8?B?RU9vcFVjUC9vVVAycXBybUkvOUJsM282clAwcjloWkJGdExuNTZRMjNJbSsr?=
 =?utf-8?B?dG1ZRHY1VUREbDViUi9oMGNEa3BJSHVhU0lITmF6Zjd2M0JrNUdIWm84WFpN?=
 =?utf-8?B?QjJhMWQ0ZFpMWVpYRXR1emtRZlZZcU9La1M5TjE2eG5tMW44VjFGMEYvOGVl?=
 =?utf-8?B?L2FGUzdQSmxHeWJ1S1JZV3lSR2llMHFLdXorVWNianpzV1V0b2xwbUswRm9C?=
 =?utf-8?B?Kzg5SHZFd0JHRDVQQW56K2lDTERyQjJ1WG5vRG44UFhhVUpvU2QrU2tnYVor?=
 =?utf-8?B?WUtPZU5scWFBNGJnTkpZaVFsVDE5QVNtbS96bDhlRVFzOWdVOFBPNDU2RjlJ?=
 =?utf-8?B?YUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C539863CEFEF447916C4D1901B9B557@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZtK2dWQnuDLXKnyPpXT2CiTc7YViU3o0xQafR3+EqKLcdKVfaSQUqsScd60xLPLQvscATOhOBOfSfRX8cLHSKvtzO9MvCxJzhfDTtNHDPNdKBRbLxqrGGvsj2SYGv+p3KWVBM/DF0d2U6bkioCcL63Scvle0/Gmuzpnrv3bk8IOjZlxbyMPmgx8twUkEYzHwSzzX+3bBBv596JnS3UVQJzsiHto67q9xYZoL9lBdezjiOI+6/BPJwXQWVF5Nso5k1mhF8sdeEfYkSTfDvCrpnCJKHPengeimYznRp2HKmbiKvYUWuzjURpcbvUgb5ZNi5vK7sPSZoo60dzCmH4wGa+W9tnUjG/GoN1fXAjiV1gum8vw66jM2dsuzutthjFYqVYhka/+fZSCQUe17Bh7JmLAAs3C+VCiybgceDWgfQqKAz8lJec3bZVDFaGNXjNIoNV49pVWGe13sbwNm1pRvgpOypQtaojplG21PHqgGKT+7ZgpoH9e/0NyE0Q/z5QvQBKc5SbG2AaP+qsL+97ifJNLAnOmdQJKdTk4bnUBwPEnGKOaqMpktW6Ci+95FqRt3lHLnu92j+GGjlCv5YUJCP1/4viI4eo7/3L+I4ZS2a4mvtPbLzNNb4rRv+waZY4frBz6pY2U0/rjt/gJp4eOBo70SZMOhJuhrEwchgl3WhkMcWeLaa27mPLkr5F0Jfr60NYJrz0YWvIayPVGneRnYdZ7zbpN7l/535l29qZHsJnuchQwLjJqzf9uuqXYs2Q/CaoOLKFX0LZ7IiC6HffdtOWwmAHJLY6fKsyw9ZkthCfk=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fc102c-247b-42e0-f783-08dbbefae86a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 01:41:45.3073 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unzpxyAVTCydMWmeamD9pS+poswxG5FpceyuHZbeRtpcFNDgY/yU7IPGd4/6FcArk5m0XXlvsLajvUHY1i9soA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8387
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDI2LzA5LzIwMjMgMTk6NTIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiAiWmhp
amlhbiBMaSAoRnVqaXRzdSkiIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+IHdyaXRlczoNCj4gDQo+
PiBPbiAxOC8wOS8yMDIzIDIyOjQyLCBNYXJrdXMgQXJtYnJ1c3RlciB3cm90ZToNCj4+PiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPj4+IG5vdCBhbHNvIHJlcG9ydCB0aGVtIHRvIHRoZSB1c2VyLCBiZWNhdXNlIHJl
cG9ydGluZyBpcyB0aGUgY2FsbGVyJ3MNCj4+PiBqb2IuICBXaGVuIHRoZSBjYWxsZXIgZG9lcywg
dGhlIGVycm9yIGlzIHJlcG9ydGVkIHR3aWNlLiAgV2hlbiBpdA0KPj4+IGRvZXNuJ3QgKGJlY2F1
c2UgaXQgcmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4+
PiByZXBvcnQsIGkuZS4gdGhlIHJlcG9ydCBpcyBib2d1cy4NCj4+Pg0KPj4+IHFlbXVfcmRtYV9z
b3VyY2VfaW5pdCgpLCBxZW11X3JkbWFfY29ubmVjdCgpLA0KPj4+IHJkbWFfc3RhcnRfaW5jb21p
bmdfbWlncmF0aW9uKCksIGFuZCByZG1hX3N0YXJ0X291dGdvaW5nX21pZ3JhdGlvbigpDQo+Pj4g
dmlvbGF0ZSB0aGlzIHByaW5jaXBsZTogdGhleSBjYWxsIGVycm9yX3JlcG9ydCgpIHZpYQ0KPj4+
IHFlbXVfcmRtYV9jbGVhbnVwKCkuDQo+Pj4NCj4+PiBNb3Jlb3ZlciwgcWVtdV9yZG1hX2NsZWFu
dXAoKSBjYW4ndCBmYWlsLiAgSXQgaXMgY2FsbGVkIG9uIGVycm9yDQo+Pj4gcGF0aHMsIGFuZCBR
SU9DaGFubmVsIGNsb3NlIGFuZCBmaW5hbGl6YXRpb24uICBBcmUgdGhlIGNvbmRpdGlvbnMgaXQN
Cj4+PiByZXBvcnRzIHJlYWxseSBlcnJvcnM/ICBJIGRvdWJ0IGl0Lg0KPj4NCj4+IEknbSBub3Qg
dmVyeSBzdXJlLCBpdCdzIGZpbmUgaWYgaXQncyBjYWxsIGZyb20gdGhlIGVycm9yIHBhdGguIGJ1
dCB3aGVuDQo+PiB0aGUgY2FsbGVyIGlzIG1pZ3JhdGlvbl9jYW5jbGUgZnJvbSBITVAvUU1QLCBz
aGFsbCB3ZSByZXBvcnQgc29tZXRoaW5nIG1vcmUNCj4+IHRob3VnaCB3ZSBrbm93IFFFTVUgY2Fu
IHJlY292ZXIuDQo+Pg0KPj4gbWF5YmUgY2hhbmdlIHRvIHdhcm5pbmcgZXRjLi4uDQo+IA0KPiBU
aGUgcGFydCBJJ20gc3VyZSBhYm91dCBpcyB0aGF0IHJlcG9ydGluZyBhbiBlcnJvciB0byB0aGUg
dXNlciBpcyB3cm9uZw0KPiB3aGVuIHdlIGFjdHVhbGx5IHJlY292ZXIgZnJvbSB0aGUgZXJyb3Iu
ICBXaGljaCBxZW11X3JkbWFfY2xlYW51cCgpDQo+IGRvZXMuDQoNClllcywgaSBoYXZlIG5vIGRv
dWJ0IGFib3V0IHRoaXMuDQoNCg0KPiANCj4gSSdtIG5vdCBzdXJlIHdoZXRoZXIgdGhlIChjb21w
bGljYXRlZCEpIGNvbmRpdGlvbiB0aGF0IHRyaWdnZXJzDQo+IHFlbXVfcmRtYV9jbGVhbnVwKCkn
cyBpbGwtYWR2aXNlZCBlcnJvciByZXBvcnQgbmVlZHMgdG8gYmUgcmVwb3J0ZWQgaW4NCj4gc29t
ZSBvdGhlciBmb3JtLiAgVGhlIHJlbWFpbmRlciBvZiB0aGUgZnVuY3Rpb24gaWdub3JlcyBmYWls
dXJlLi4uDQo+IA0KPiBJZiB5b3UgdGhpbmsgd2Ugc2hvdWxkIHRvIGRvd25ncmFkZSB0aGUgZXJy
b3IgdG8gYSB3YXJuaW5nLCBhbmQgbm8NCj4gbWFpbnRhaW5lciBkaXNhZ3JlZXMsIHRoZW4gSSds
bCBkb3duZ3JhZGUuICBEbyB5b3U/DQoNClllcywgSSdkIGxpa2UgZG93bmdyYWRlIGVycm9yIHRv
IGEgd2FybmluZy4NCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiANCj4+PiBDbGVhbiB0aGlzIHVw
OiBzaWxlbmNlIHFlbXVfcmRtYV9jbGVhbnVwKCkuICBJIGJlbGlldmUgdGhhdCdzIGZpbmUgZm9y
DQo+Pj4gYWxsIHRoZXNlIGNhbGxlcnMuICBJZiBpdCBpc24ndCwgd2UgbmVlZCB0byBjb252ZXJ0
IHRvIEVycm9yIGluc3RlYWQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJtYnJ1
c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgbWlncmF0aW9uL3JkbWEu
YyB8IDYgKy0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRl
bGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdy
YXRpb24vcmRtYS5jDQo+Pj4gaW5kZXggZDlmODBlZjM5MC4uYmUyZGI3OTQ2ZCAxMDA2NDQNCj4+
PiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+Pj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPj4+
IEBAIC0yMzMwLDcgKzIzMzAsNiBAQCBzdGF0aWMgaW50IHFlbXVfcmRtYV93cml0ZShRRU1VRmls
ZSAqZiwgUkRNQUNvbnRleHQgKnJkbWEsDQo+Pj4gICAgDQo+Pj4gICAgc3RhdGljIHZvaWQgcWVt
dV9yZG1hX2NsZWFudXAoUkRNQUNvbnRleHQgKnJkbWEpDQo+Pj4gICAgew0KPj4+IC0gICAgRXJy
b3IgKmVyciA9IE5VTEw7DQo+Pj4gICAgICAgIGludCBpZHg7DQo+Pj4gICAgDQo+Pj4gICAgICAg
IGlmIChyZG1hLT5jbV9pZCAmJiByZG1hLT5jb25uZWN0ZWQpIHsNCj4+PiBAQCAtMjM0MSwxMCAr
MjM0MCw3IEBAIHN0YXRpYyB2b2lkIHFlbXVfcmRtYV9jbGVhbnVwKFJETUFDb250ZXh0ICpyZG1h
KQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC50eXBlID0g
UkRNQV9DT05UUk9MX0VSUk9SLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIC5yZXBlYXQgPSAxLA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB9Ow0KPj4+IC0gICAgICAgICAgICBlcnJvcl9yZXBvcnQoIkVhcmx5IGVycm9y
LiBTZW5kaW5nIGVycm9yLiIpOw0KPj4+IC0gICAgICAgICAgICBpZiAocWVtdV9yZG1hX3Bvc3Rf
c2VuZF9jb250cm9sKHJkbWEsIE5VTEwsICZoZWFkLCAmZXJyKSA8IDApIHsNCj4+PiAtICAgICAg
ICAgICAgICAgIGVycm9yX3JlcG9ydF9lcnIoZXJyKTsNCj4+PiAtICAgICAgICAgICAgfQ0KPj4+
ICsgICAgICAgICAgICBxZW11X3JkbWFfcG9zdF9zZW5kX2NvbnRyb2wocmRtYSwgTlVMTCwgJmhl
YWQsIE5VTEwpOw0KPj4+ICAgICAgICAgICAgfQ0KPj4+ICAgIA0KPj4+ICAgICAgICAgICAgcmRt
YV9kaXNjb25uZWN0KHJkbWEtPmNtX2lkKTsNCj4g

