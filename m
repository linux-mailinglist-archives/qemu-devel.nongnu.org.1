Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F80D7A9332
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 11:40:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGAG-0002B8-Ad; Thu, 21 Sep 2023 05:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjGAD-0002AH-Pq
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:40:01 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com ([216.71.158.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjGAB-000601-E5
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 05:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695289199; x=1726825199;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=GvD76EC0paoQOhhC4QhOPoE0ddnv5dsbzlysj8No49s=;
 b=Ovb16RK92jjy2kI1TjTQdSLubdci6F5QzXN1xKhj1X7ydjKp7VOn6dU0
 xCeMK7FlB9wa6vmIGINYYX89MKTjG2WkGk5EO/ABTdWxm9p6IOqdRkfjg
 yR5FJABXnVURh6AHMNLqCbf0/23WuMGDOJ5PSAFuApgqf59XXNbMpiIHW
 UOdUzmUXI6QTGSUhp3uMfMsbdQcm5T94e2xJ+lED4wITxy28j3Vf7FswC
 r3JQOBmAv7QM7UP4aJSonHBP2tgRAkCi3prbJnxN6PsLcoNrI/IcTihce
 uL1eNr+VVfiJ79CLWnnFVuJkp/+VScNCeNsFERo7mKkMdYli1in29zhtR A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="95939917"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="95939917"
Received: from mail-os0jpn01lp2113.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.113])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 18:39:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0kdU/KuQPonsyfJU3/BhqjsAW1T+iqeLls8qUxlBH02KwSuBzHAfhY8y1bS+zXpEjog9jG5DYViXkGi9LGVfRgE59N3DP1TWGK65+vHcAFLy4gRPNONR/QghTydhPd2oV7BAbOJA8Q9x6jxc2TJFQjUfH5Ai/u5CD4swGBWGTML4N0MRmZqKBggIWPEpU/V0kAYlhfxqUP9szUDhiWg0RsgeGtzJcY2iajPVuZD4F8jpCmy6JXLH93i+WE3BtoLQvyARsq9AzilE3Uuu3QUHndVRrwmGR9+4uhHEJtyQZloC0zvAIu18EpZ5u1FG9H0hRepQgMKlQnLEzT11BE9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvD76EC0paoQOhhC4QhOPoE0ddnv5dsbzlysj8No49s=;
 b=T57ew+kW94o+RTXtv2rQ7InhfJycqnF9Tf3jKIAZxX9yEaB1n2Mw/Nb4BfXQd+ZO0LsmHiH5eM5RCMbGfpwa6WFQL6rYc7SYDNTr5iw087q0UW3cK8pyQHvYqzd5h235OkTUE1B8/hq6SDNjc9frGSVR8H3F0lSq9d90CgGi8igSupvkZNrl4//RTtX8lpk0YuVJcZ/V4HvD+sIlGCO3VcrnBPF/qCRl0omrNl7HQcFUwtG7REOvYMVlI4vYWkc++0r4DpmZlZFiLKir1jhkuNPZ+NEMlMBgOnKZuPBofy3hxssip7WRnZf8xO2nZL47UruxKWk0XkQa2sQ0TfzPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB11513.jpnprd01.prod.outlook.com (2603:1096:400:374::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 09:39:51 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 09:39:51 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 11/52] migration/rdma: Drop rdma_add_block() error handling
Thread-Topic: [PATCH 11/52] migration/rdma: Drop rdma_add_block() error
 handling
Thread-Index: AQHZ6j+Z0j4Zu2AGtU+Fxw11xPoyWbAlCqGA
Date: Thu, 21 Sep 2023 09:39:51 +0000
Message-ID: <94601877-3170-8d7d-d161-3b72041d9551@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-12-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-12-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB11513:EE_
x-ms-office365-filtering-correlation-id: 0246cc3c-ef09-4892-221d-08dbba86b459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dIY0fIwGBn7B4I09dv0+8kAGdyyWHj79YWBNm1CMZdUeOfXVbWS5+rUJP2JNKWD1YJKIreomi9AFXlWdLOfWatzpgGWlt6uEyrKpyipB/LuBhQiRsK5qyE+LHrfrqMifLzNN3B0AKVXXSHcaq0HBVwlcUIQIUHrNxebmOclo1ZjzE8vtV8GZbfRcy8jnThujyWGZiHiNSWsuuydjWIkhITevtgHXsWMC70pzlGPtzAi/zJdlbLxJ70Rh6IpTdmWvmpPJPRCmTMNhrovF4TmzeNDmRkjBmbFcOd6mSuD91K35xCoABocsf/z+6UvXJ6vVkgImT3GDIkDs4tlggceYmViL6Kg3s+IJ4bX/p5luXagRPWzju90Ajb6d/M4O3A+vRCoiDdzUdMVHWsXfbB9vFAW56jpIWheNumpg9Z3vhJuIfjEieEdpx4veJJJg+I54oc3ZylF37MmZGN8l+HWFX+bQH2Ip+sbVTrNySlCqp1M2itnbuT612o4M2oyOeY7WcUwmkcOGUQWzB71kT1ShQoZNOx9PWBYE3BCt4PeAdGMOSK0UX6Nbt65p5eJpnTC43t/DRo7KezpT017I14u4ZSgCy5CRqVwsWefREyIpG1Gnnp9RkD/MzBQJJtYPyyFPN7Rx1sCREGI7ePxPJWwIj/g2YDwkmcHyqV0uSbRXKKigCkSWTUiHpVgCbH4v1okpjFbq0wu0s4aRu/AP3gQPGA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(186009)(451199024)(1800799009)(1590799021)(41300700001)(2616005)(85182001)(1580799018)(5660300002)(26005)(2906002)(122000001)(38070700005)(82960400001)(86362001)(31696002)(36756003)(4326008)(38100700002)(8936002)(8676002)(83380400001)(478600001)(53546011)(6486002)(6506007)(6512007)(76116006)(110136005)(91956017)(316002)(66556008)(31686004)(66476007)(66946007)(64756008)(66446008)(54906003)(71200400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VjkvcEpybXkwVmladlJBWURRd3RwU1ltbVhUbHd3Z0c4dWsvZFpoZUluNnNO?=
 =?utf-8?B?L0xndXBzNUx3Z3JwLzVkaEl3ejVBS0dZMDFYYXhUd0ZTZGZHMnVaMDFFOWVM?=
 =?utf-8?B?c0Z1a2JpVW83RUZCS240WTRsSWcrdGpoUXcrLzdKUU42QjFtS3g2ZEkvYkdv?=
 =?utf-8?B?WWdDZElFcy9oMTZHanNzTG9tY3lHbTZTb09pUXNQR0JaZTZna2QxZ1gzZm96?=
 =?utf-8?B?aXEzcEYwa05DVFY3aXdRVjR4TnZOS3RGS3RNNU9GcDA1QnN3QVpIZmdJM0Rn?=
 =?utf-8?B?U2tPK2UyblZEeW05b3dsUXR2QWsyZVhIMlk0aFlSOHFxbzZuRWUxVjRGdU45?=
 =?utf-8?B?TlRzc3FOMC9abjRDazBmRmZYeTRleGZnOWlIYmdxNENCK3E3QUpHYUpwUWpO?=
 =?utf-8?B?UUExNFE4cHljUGY2eUpEUEJyMTZwb2JZcjNNQmxkVXNmN3hBTlZuU3kzRy9p?=
 =?utf-8?B?RWRWdnhveWR4UWFtdTBNMWpiQk5hRFRldVBwOGo5Sm5YQlFHbDlDZERSUVVw?=
 =?utf-8?B?cFdvU0RHSUZPQTVTRVo3dWFHUFErWHByaGpBYkIvZjRiNHlreGtqVzlWTUor?=
 =?utf-8?B?bDl6REVYTEFlS0R6ZkhFbEwvbjJ6WWpmOWxUQ2piQWxYVWF6YkRSV2pJdzgy?=
 =?utf-8?B?U28yMmYzMW9tRTBBS0RBM2tPSUdTelp6QU44OUVBYkJwc1JNaWRvU2t2OC92?=
 =?utf-8?B?QkVyVU9mZkh4T1Yxc1g2Ny9sOEdhS050djFvT0V3WVk5QXdRamlFcVdyK05u?=
 =?utf-8?B?ZEF6WTFFL1JuWk8xVzBRVzY4MGdsQjZXMTQ4U3A3NHdnRlN1Q0NvVk9IQ1kx?=
 =?utf-8?B?bUlqR3ZDUDNnbURObExnTVJiVjR6eWZ6R3pyNGpMRHdqUFUzbG0za3hqZFhi?=
 =?utf-8?B?bUVCRFBYeDhtenpiRExGa3IwV1o3RjhMTnpVT0pGVGJSTU8xKzExcjF4WTlM?=
 =?utf-8?B?b2d1UWJ6a0ZKZmJSZk0yeURXTktyd2wvMU92bkFQSkszQWdBRExUWlZSRWV6?=
 =?utf-8?B?YXMwOGsxRklCQlhzQ3M2cjlCMDY3RldHRnpza3RFOWpkZWh4cFpPNHFmNlF3?=
 =?utf-8?B?L29QdDcveGEyWlFEVVVTcGZxbllCeFU1OE5VMkE0SjV0WDlMQjdSSUpMSit2?=
 =?utf-8?B?VFRucTU3aXBUb0ZpZklZd0dOdXdiTDFISGRRMkt1ZTBFeTdEWXRuL254R3NK?=
 =?utf-8?B?OU5WNlA5WWZxdGc3Zi9VWld2TlhsUjE3ck9ZUmlNZnR2NTF1T1h1WWxrMlRY?=
 =?utf-8?B?QWVGZUZqZVVOUGxGUDU3MEd3dm9GMm10dXFBK1k0dFdyVUJUcUJJbkdnVHY4?=
 =?utf-8?B?QnQrakZhWWJUQTExTVdlZFdRRmlsZTlubk5QMVJPVW5yTERnWGFBUUJueEZE?=
 =?utf-8?B?eDF3TlBjMzFONXpMWWc2Yzdoam4vajI0akhwbUZvbnFWbDF2MEM5V05hN1FI?=
 =?utf-8?B?aFZQUlo3STFMWllwdzZnVi9BeXJKcU43eXROWThrYzIzcmtVWDVHRitxOW5y?=
 =?utf-8?B?REgremh2S1NjRWdzemU4U3V4YkhKZXdQb3BidkwzejhGaHBrazM1UmgyTXph?=
 =?utf-8?B?Ri9TaXFYcjBGTVZEYm1NOUNzaEFoUERIRnN2eEdYYUdIdUNNVmZ5SGROZU0v?=
 =?utf-8?B?eXIveUxKQUhQMGVqVlFvR3F3dXNhcWwwRks3S1FmaXNBRU5vd3pmYUtiU0l0?=
 =?utf-8?B?UUFTSlRleURTTXV3SFdOVWVFSkFHS2ltanNwSldnVnlCTnQ0ckxnTWdtUzdu?=
 =?utf-8?B?U3FxM01OSHkzWEpncHdIaW1wczNGOHNyMFZtb25aVmlnTzd3OXlGU21wMTVr?=
 =?utf-8?B?QWwwUkZ6eEFxNUpvQzVvMFNkcWs3QytwTXN4MmZ5RG90SUNScGUzYjNwY3E4?=
 =?utf-8?B?a2RzN1c2MVRRTzQxb251VmRQOFo2Q0VPSm5LWVlmOWRrRHpVTmJPQlJtbGtT?=
 =?utf-8?B?Z2h2Q0dUaHpsUnpZdlpoVVlEUytpd2JNVFBvTVRUbjBia3pNcW1ZcStjSjZz?=
 =?utf-8?B?aHRkelFjVStHY1ZXZ09pSjlOMHBINTNqREVGQmx2SlA4TXhOQ3hESzFoM0kz?=
 =?utf-8?B?WEE4RkpmVFNvVVhHYnRLc2ZheVpyWVVwN2VENnRacW1pQkdsejlKU092aWo1?=
 =?utf-8?B?dzlISkJURUlpTEJ4Ukw3c2hvODNTWk53ZEhSRlNJYlZNOThTVG51MEc1WldH?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6AE9EBD5D7D77344BE1E8A354AF1A746@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cod1f65PcABpLdeRWAHW6Ka8/KiJI4txrsXd76HGeoA/vYx9fw1Lnhib9xZDxCu3QdUZjK6BOfrMwrMNqxZYUAncxCabGz/cdyy2jBsPsetAqMZEVAuKG93DIrHP3AV3zzwBzOWLhXh4VgycsfF1JLjUg1r9CskPIaIJwbcYcJPSbmVcnEdF9FXttlBj4pkJXbbFkxHjJmi7hb6Du500id967a6CmQK6I4ZSULL/PLvAdwKygzUt3IfThTsF5rJfO1MQEdwrh+gq3tO4Zh921awO9ec+N9JjKXcJEnhbvJV6nN2+a8nOIi/CFgVMv8SbriZKNT/qjn98+doRqyCh9iazyvIo3+okO1RwelLWMUGUrHHBf7NdemBI2WhgdqzVrfrVyg+ff9ZHU8XGW8oTmGW3jqAQsskGIWPL4uRbfi1pjMAiXpFm6PjNLKrh8Cyf1rcKsMrCv7IlBlaRqs81hM6k62opjlI5O7fN11iwd+BDD5LD3jpt9L9V9eStbX8EFUcX1eNQ6eEB8L8kEbWHQr+uZUBIVVK3v5Ee0hp9+DtZwnN3ZV9dVcgb04br1uKElUPNTMVpgIaoj1HfR4bRg+Q1cS3viIy6cJcp/Nb7OOF0w2+zm5Dgrz01q/R3482nbfqGDXggzRtv2GxyVcsflRNH/Gm15ZuG/b/2mrBxBBb4iKoi0NlztUvurWcBxmO3KyPxaktmLVoxdQpeswlACdGLysZfYDnsw8RqdQnKdOGl0sN//Z94OmmdtEWEI4S2QAECCCeSFAt0Xs/jIOnfX5DEiv7Z08xww3ockOtGoxw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0246cc3c-ef09-4892-221d-08dbba86b459
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:39:51.7091 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFJV3tVGmNMz88F4SdDZ8eA+XXNiVFceQJKmU86lH8Ch7BKMIndva6ssrKrSkKShSna/otb+aZKp+B+6Hb45gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11513
Received-SPF: pass client-ip=216.71.158.65; envelope-from=lizhijian@fujitsu.com;
 helo=esa20.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiByZG1h
X2FkZF9ibG9jaygpIGNhbid0IGZhaWwuICBSZXR1cm4gdm9pZCwgYW5kIGRyb3AgdGhlIHVucmVh
Y2hhYmxlDQo+IGVycm9yIGhhbmRsaW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFya3VzIEFy
bWJydXN0ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMg
fCAzMCArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4gDQoNClsuLi5dDQoNCj4gICAgKiBk
dXJpbmcgZHluYW1pYyBwYWdlIHJlZ2lzdHJhdGlvbi4NCj4gICAgKi8NCj4gLXN0YXRpYyBpbnQg
cWVtdV9yZG1hX2luaXRfcmFtX2Jsb2NrcyhSRE1BQ29udGV4dCAqcmRtYSkNCj4gK3N0YXRpYyB2
b2lkIHFlbXVfcmRtYV9pbml0X3JhbV9ibG9ja3MoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgew0K
PiAgICAgICBSRE1BTG9jYWxCbG9ja3MgKmxvY2FsID0gJnJkbWEtPmxvY2FsX3JhbV9ibG9ja3M7
DQo+ICAgICAgIGludCByZXQ7DQo+IEBAIC02NDYsMTQgKzY0NSwxMSBAQCBzdGF0aWMgaW50IHFl
bXVfcmRtYV9pbml0X3JhbV9ibG9ja3MoUkRNQUNvbnRleHQgKnJkbWEpDQo+ICAgICAgIGFzc2Vy
dChyZG1hLT5ibG9ja21hcCA9PSBOVUxMKTsNCj4gICAgICAgbWVtc2V0KGxvY2FsLCAwLCBzaXpl
b2YgKmxvY2FsKTsNCj4gICAgICAgcmV0ID0gZm9yZWFjaF9ub3RfaWdub3JlZF9ibG9jayhxZW11
X3JkbWFfaW5pdF9vbmVfYmxvY2ssIHJkbWEpOw0KPiAtICAgIGlmIChyZXQpIHsNCj4gLSAgICAg
ICAgcmV0dXJuIHJldDsNCj4gLSAgICB9DQo+ICsgICAgYXNzZXJ0KCFyZXQpOw0KDQpXaHkgd2Ug
c3RpbGwgbmVlZCBhIG5ldyBhc3NlcnQoKSwgY2FuIHdlIHJlbW92ZSB0aGUgcmV0IHRvZ2V0aGVy
Lg0KDQogICAgIGZvcmVhY2hfbm90X2lnbm9yZWRfYmxvY2socWVtdV9yZG1hX2luaXRfb25lX2Js
b2NrLCByZG1hKTsNCiAgICAgdHJhY2VfcWVtdV9yZG1hX2luaXRfcmFtX2Jsb2Nrcyhsb2NhbC0+
bmJfYmxvY2tzKTsNCg0KDQpUaGFua3MNClpoaWppYW4NCg0KPiAgICAgICB0cmFjZV9xZW11X3Jk
bWFfaW5pdF9yYW1fYmxvY2tzKGxvY2FsLT5uYl9ibG9ja3MpOw==

