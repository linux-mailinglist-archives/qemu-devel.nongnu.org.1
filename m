Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B2A7C7FBC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:16:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDHB-0003Tw-Ux; Fri, 13 Oct 2023 04:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDGv-00035L-0T
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:11:50 -0400
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrDGs-00023U-NL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184706; x=1728720706;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=SJaEMnR3L7aQbx4C8jXuNdPLEk38O3FKVojfCKFbJr0=;
 b=sM5qwn0x8cL3YPLrc4JdEx75DD43QrSEVwThdAtZhoWBGSs6qo7EwZpZ
 vOGRNEgryQ9STnQElUddC6U6og7nzb6gXY+EYwveaxIkYRzwP30FM00h9
 62a5p20q0quOZBQd/JJ6MReRp5RSwdueoPietWiIuIZbuXNUCCrrzEI1H
 hOmEAyRvpKUSPFv2pLjT6+aDa+j77s1OgOdR8itrjXp+j3v15OqjbNqfa
 EjFMNVbrLRHtikvZK6OFZYueRlKNvT41ulhTmt3uz5zUdEOcTrX7+kCSl
 t/xKG5FynTeptbvk+0Oj3nmDDFDc2ilgQZP3SFQR//9oZsOd8CQq3EplJ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="12108514"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="12108514"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:11:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYdGTnxTIQrdDErCFl9D6a/VSRHcE52mD10/dxNWkCnevH6qJoJcIRVGZI9psgCoPhj8bX0ILZ4WEECsdbhG0IrH7yWh0F3CvP1rN2r2K/vOv5RTFKhnpHHXWx3wswO4fFIPxAKsXUvO/7RwnzvPu/SNTKYCFQmbCvIiq6LYHTvVjjwtroDxS1KBQpLyHS3DP4OhDFFhtagsFZwnruKznC8TINDE1qFilTELKZj2WZONGcsKpXV60HsO5N5PqTOfvtYJddwFSRDRBQaCivTZ6H8M2+idtjY99vQ8lM0wZ9GrxCitVT++53e4lK2l+/0zayb345P7AeF9FNHEjubLqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJaEMnR3L7aQbx4C8jXuNdPLEk38O3FKVojfCKFbJr0=;
 b=PfKRSj1OmkSIAjVYVprgFgFYv04E6CsWk6JhUqdNCWPcexfXgTO/FmQles2TsQVsR+ZLrFfakx/sX5ndx6ijfVJ8U1FgdVG96ePg4cTud/drxxj3HdrR7rHPZ9heI04MaorDJmMuUcD1G5VkcJQ4lKZjUKBNbpsMYM245zakSFYnhVy5lwGjOxQL5bi3FAq0sRYtTRW8LTOf1cycG5slx+IxuwfGO0HarHXwdccyGZbHfWCOVFKOyBDRVwvSQD/k1Pu9hQfsZ+wz136Owv0CZm6ZiADoxou7urgIp39BFxkJad5UFPYazKMlb9hxKsSDXJdfTXMUpyYrvY76IqDZ4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYCPR01MB12093.jpnprd01.prod.outlook.com (2603:1096:400:448::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:11:38 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:11:38 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 10/13] migration/rdma: Check sooner if we are in
 postcopy for save_page()
Thread-Topic: [PATCH v3 10/13] migration/rdma: Check sooner if we are in
 postcopy for save_page()
Thread-Index: AQHZ/IKOrLAlWqwK7kWJ6huIMkqB77BHYMGA
Date: Fri, 13 Oct 2023 08:11:38 +0000
Message-ID: <7dc1c030-19b3-83ac-7030-1db221184c9d@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-11-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-11-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYCPR01MB12093:EE_
x-ms-office365-filtering-correlation-id: b4c2bdae-4774-49d8-cc88-08dbcbc4067d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YyxwcKNe6uspKHATUqduczN6wxFsMrKBrCjB+odlxZ+fWtaLb1+rINTkpg19M6oLpqz2SkXNi7iXKzo7YrwIuPgbw+Zn5iAE33HyCdDP0qxejVyAaJzHS3N1uM5R30NVPsDnlAPVBwEKUN2QYOopYlp2uu+UYETxo7cNulFr7PC7JNbdhaEHxTu6Kz3brEwxNui/cdJRk3g0lLEr76KVI7wLQQ5a6rfvGwIYgqIBjo4cfJgQAdjuGsoPRXrv/2bQNQChpn/uTx72H8TAtoVZ0UsKDxATwIB5mIR3cmiVM8Y+5S8sZNccBCr5gsauj8rY8HpUb8WuMg0ZeTqbCPzSutWOMP9QjLutL6PSTrfWa0NO5vYe+VoJJSV6WQ/VtsAF7kM5h+uRHLg3QHaggGJBqo9XfXX1Mcq5arQb7jhcWUPtG7v6NjYD3MNTi8sHyoHkhr2SdlesZd0btSuuz9LLAnyktlM7wHJPvaClot2IFxV45/C4AbpXuzKxlZrykjxwZxLYoDQii6cC6HLvZkMnV9JHVZU9Vw0TJcDYRP+RQaS5W7LsvJ/7RDJQsJU0HT8/YzgsItrD5X7QgIfQEoupS98hR4DxasK5V7IJfYyDkF54NvtIIVRr1CCAKxpD/oMLK+SejNmuk8frZwAbJkBMwO8e+Yxlb+DNNeuUBKtCn71i1zj70Cf18vbGZgglx1cI30b50vz/xETIK0m6oia0Xg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(1590799021)(64100799003)(2906002)(1580799018)(4744005)(2616005)(26005)(122000001)(478600001)(38070700005)(38100700002)(82960400001)(31696002)(86362001)(6486002)(6512007)(71200400001)(53546011)(6506007)(83380400001)(4326008)(41300700001)(8936002)(66446008)(64756008)(54906003)(66556008)(316002)(110136005)(91956017)(66946007)(76116006)(66476007)(36756003)(85182001)(5660300002)(8676002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGJacjFWTEJZTGJVM21aais5a1laRHhlQm1GbktML3ZMaGxuV2MrN3o2SEpn?=
 =?utf-8?B?ZHo0SFBxKzljNDduWitNMnZCb2NOampNbmY2MjdoNzlEMDZyaXliM2pOeTE2?=
 =?utf-8?B?czZzTmxKc3V0TnNnc2JpK2RZMjYrTHFZSlVqL3Q3WmcxczVRL2dmV05JNlMv?=
 =?utf-8?B?cFdFd1JYcXZEUTFlSnV4Z0FmL2MvRE9GUnZ6WkVEL1lLQkZhYWxLU0xYZlI1?=
 =?utf-8?B?Rnd1Qi8rUUgySVk5eWZYZStIc21JSDRlUFNYQkEzaW15Q3J1TVpkM0dVTWV4?=
 =?utf-8?B?S2ROU3ZtV1dZQ1VIWnNVc2k2VG9IQVE5NmhWZ3VNNW5FdzYzNnJwdXE5OE1C?=
 =?utf-8?B?MWlGNngrQ1JMKzZ0QnVSUE8ycmZnQU9DZVRsMDAxYU9qMUg2VVQ4NjF1c2Ny?=
 =?utf-8?B?U09nbHlURmNGckw1Mldva21STmQrcTE0S0IxUXlWVTZoaUpSRnVZdGY4em0r?=
 =?utf-8?B?QkhMYXBmWnVRQzlEQ1lZdVdzVWlPdm1hUmVYR2JSRlFCZXhYOEhxbmx0ZVpE?=
 =?utf-8?B?UFRneFdjNHJFK0Nwb1daNkhNM3E0cHhOb0tZcDV0ZmNyT0pZT3VCeDFob2dn?=
 =?utf-8?B?Q1k4bHYrR0VzYlp0alVpaU1OalZVWDVmV0RudUllZGk1K2N4VGdUcDBrQmdo?=
 =?utf-8?B?ZkNzNkRWRlU1RVZ2c0VoYXJjOUhiK3V2aTlydXlQRkZvdUFNWExXTFRUZ0F1?=
 =?utf-8?B?M1p2ZXkwRUpOUHpGa2U3WkN4ZU1Wei84ZHdNNCtkSDR3TXF3UUZadG5XMGQv?=
 =?utf-8?B?dVNkOXdMTVFobER0djhvNVdjRGx0SGs1VE5nWVBzWk55TCsxbjF6QmxSYUpH?=
 =?utf-8?B?RmhSMXNuR01WQ081RmdNSnl6VVB0N1B1M1dTdnNXUFNJRW0xdWM5WFZtcWdP?=
 =?utf-8?B?bGZrYnJsZUtBb1Y1UDNZeU9XMHN5UTVyMk5qdkdrR2czbUJHcHlpRGVQUS82?=
 =?utf-8?B?RFUzNXBqajNZMGlPN2NlZXhUcFlKVFV4a0d6QnFTdUY2NGNNL2tMcFE1c1lM?=
 =?utf-8?B?QlFMcnBYdzFFdy9MZ0lWMWI5NjZhOTVrY3IrZVNTNjYyUHI5T3R3M2VtWHg4?=
 =?utf-8?B?YzM4aGZ1RUpqdVduTW5CTHJEdWJlM1VNVlZLekk4RE1BR3ZmNDFETllPUVFQ?=
 =?utf-8?B?c3R1aUFDdkR1WjdpeWlmblRWZlFkQUlSelkrcU9lUWtMVFdjSUxURnNOUlJ0?=
 =?utf-8?B?dWpieDVRelRzczU4RWdCNTMxajRVaWtDR2cvZi9QOWh4RFE3dXNGTnE3MVA0?=
 =?utf-8?B?ZkZGVHZ5ZnJIbjVNUVhxWE5PK21La0xnVVVXbFg0QXVSdmhHMStBTHhRWW01?=
 =?utf-8?B?WEFrR0EzRzdrWlVTRzFIVkxnVGNBNngzUGQ2bXd4UlFkamVTNEVkTGxZRUcv?=
 =?utf-8?B?aVRqNzNKak52aDBQbzhqZFdCQWtRNU9SQXZrL1lQN282NGY1dUcxLzVPTmh1?=
 =?utf-8?B?VEFhemhKbGhIc2dWdTRVMnhSa3ZUSWpodDhxTW5hc21TQzlEVW14U1dkRUNU?=
 =?utf-8?B?aEtzQ3RuMnFlL2F1K3Z1KzhMeEhrWElEVTZjTGJid3ByTVBTVmRPZVFWVlRZ?=
 =?utf-8?B?MmtKMWU4Y2xxSklmamVtSEVtTHNKTDJqUmg1NTZBcE5qamo0Mysxcm1YaTFa?=
 =?utf-8?B?S05uc3luUFNkZ0ZzdUhXZ3ZXTEpwZCs2RGhNL1U2emMzWlA3TlR2WktXUDF5?=
 =?utf-8?B?RUdzbGFndC9rSzlyb1hTTnBRRzZlQ09EamlsNFJYakZMQnpGWjd4WVkwYzF5?=
 =?utf-8?B?enhNdU1qb1pGZVk5T1h2d1pkQm0wcmh6UUI0TkFNQkJrZ2szbGwvYUV5VWpr?=
 =?utf-8?B?eDJ4clZXL1U0QXFteVM2cC90akNVaVNRSkNLMVZwUTRuSVQ5UGdmekpQUVgw?=
 =?utf-8?B?S09DM2JQaml2enZEMGp3YzRlclpwQVdaeWNWNEtUd2Q5b1Zwd3FHZEJ2Zi9u?=
 =?utf-8?B?Y1RscHhSTHo4VFR0Qk85RVNyVG1ydkd0RTQyNjNGVElnZkE3bDhzRXBXZHAx?=
 =?utf-8?B?cGYreFFDZktLaEEveHo4ampZTHIxNm9wK3BlUFE5d3VtQWZZZFpFYjZTZDhI?=
 =?utf-8?B?VW9PRDdvczlUd3VENHZnMGRGS1M4ajZ0WjhJM0FmQm5JV2QzVEJHZ1UyYTYz?=
 =?utf-8?B?aXVSaFZWRHpvbkFkdlA5U3RPOFpQVjVxV2lpWVY2ZmhYTEhxL1BvNTBjMmE3?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4D57E8F7C7B124D877A29476E1DD100@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1ydZGntPITXnVTRxd9wQJbpp4FXGCtlePcaw9FrrbLAVYOljHCSJ1LcrbkN9/lS9SYQHfMoZkbLwJPT3fScqH423jdOOD9CQz6NmXP/CNH5kwEO8Mj8xrpNuTZGtjHquwuYH5iliriUR0AMNZK2hjoH8ElBSGK81vxYTnim7wI5I+3aX1PoFaZqXX+cTrGNnwapgyXXlD8G34Ll5C9nTsV18xz9pLj4XMvehcXcUrlyFn+0vfvmKIdK8PuEurffe2GQhG2jtjujy5cDnDVmZqasCrUJIfm9JGjfmQhStf2Ioy8hk4B7U2szW28XQsIz0c4ljXe74PAAZIG09Htaohwv5FvxDBzz4f03IeIOQSRwb+oLEK3g0CI3vbRNvr8vHVj3c58oiKRoyAzp8r7e7xSYpfoQIyYFhAA8v70DKwslzHz/AkJnhD1NZTPQ988w07omig1HxxYkZWUTEJgoqilF7WtUy6LBbvSbOXK1kyt8BX/UaZye5y8BINbgMBOKKKMMgPePQhdGPas8OS4aTzC9yb1Wda8jhBl0dCTBWCiJcSshkoa6m/VcNUSlpJLF0yhk9Or/+3FCH/17/BrKmUfM0JMLUEaUaddOHpUOaHb4IcMJG3wPzP0i9W1X99yh42odHGj5APcg2VFCzRrWtbmEeDHzKiZfdQvrUJIi2DbkUC7axQqZTzUu1eATPInmANHH6x8mgB18Igh19pW6glBnsRD2OP2+F53lx7e2Bbd8Iv1t67jOG3r7an2951LiSkgH6425MVw/71PEHurJTrriCsiaJF+xiDsQJuUfjAgXegGN1Vzi2fyIRMisvKn1/
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4c2bdae-4774-49d8-cc88-08dbcbc4067d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:11:38.5540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 67owl4KcTjS0KZIcVKnWnk3srEKaytf99So0Aw6MfXEZTSq0zEkRze41VDakS6YmNsAFYvHUNdVkFR0YxcmXjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12093
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
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
IDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KPiAtLS0NCj4gICBtaWdyYXRpb24vcmRtYS5j
IHwgNiArLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9y
ZG1hLmMNCj4gaW5kZXggZDNiYmEwNTI2Mi4uOTMyZDRlZGE5YiAxMDA2NDQNCj4gLS0tIGEvbWln
cmF0aW9uL3JkbWEuYw0KPiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0zMjQwLDEwICsz
MjQwLDYgQEAgc3RhdGljIGludCBxZW11X3JkbWFfc2F2ZV9wYWdlKFFFTVVGaWxlICpmLCByYW1f
YWRkcl90IGJsb2NrX29mZnNldCwNCj4gICAgICAgUkRNQUNvbnRleHQgKnJkbWE7DQo+ICAgICAg
IGludCByZXQ7DQo+ICAgDQo+IC0gICAgaWYgKG1pZ3JhdGlvbl9pbl9wb3N0Y29weSgpKSB7DQo+
IC0gICAgICAgIHJldHVybiBSQU1fU0FWRV9DT05UUk9MX05PVF9TVVBQOw0KPiAtICAgIH0NCj4g
LQ0KPiAgICAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7DQo+ICAgICAgIHJkbWEgPSBxYXRvbWlj
X3JjdV9yZWFkKCZyaW9jLT5yZG1hb3V0KTsNCj4gICANCj4gQEAgLTMzMTcsNyArMzMxMyw3IEBA
IGVycjoNCj4gICBpbnQgcmRtYV9jb250cm9sX3NhdmVfcGFnZShRRU1VRmlsZSAqZiwgcmFtX2Fk
ZHJfdCBibG9ja19vZmZzZXQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFtX2Fk
ZHJfdCBvZmZzZXQsIHNpemVfdCBzaXplKQ0KPiAgIHsNCj4gLSAgICBpZiAoIW1pZ3JhdGVfcmRt
YSgpKSB7DQo+ICsgICAgaWYgKCFtaWdyYXRlX3JkbWEoKSB8fCBtaWdyYXRpb25faW5fcG9zdGNv
cHkoKSkgew0KPiAgICAgICAgICAgcmV0dXJuIFJBTV9TQVZFX0NPTlRST0xfTk9UX1NVUFA7DQo+
ICAgICAgIH0NCj4gICA=

