Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5B7A3FC9
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 05:49:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi5FA-0005zG-1o; Sun, 17 Sep 2023 23:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qi5F7-0005z3-Kw
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 23:48:13 -0400
Received: from esa13.fujitsucc.c3s2.iphmx.com ([68.232.156.96])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qi5F4-00062D-GD
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 23:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695008890; x=1726544890;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0LtEoKERpNzNyLy5C9w0IDpgAVZXn0WzFsIjwHivZ6k=;
 b=HbFHPUJ2sI0SP2vqJwIWaRe5Qc2H+T/F2l5NT3pv3zq+OAhuNq+9zGY/
 eIpT8Ad8EuHjNBVwtolg7BKKv399lI7cPoim/8laER/ge8/NwAXXaWAMj
 tQK+3ZNAK2tasYq63eesSefnLpaY0b/ZmvpB6oEYmg2Y4akABv4DNz4zb
 +00Y2R9b2pEjC3D+1Vn3ZMw08SiTx2ef0MCzdyEKT8QL9qcQDyUUhDcPj
 YD/ljdP9E6PtIydlEEan5K78WgIUJJW05bss3auX75aA8xAy677Yu6+FH
 2GCqg+/R/JndzZUvIfTo+2nUfJshAmkkB6dmYij/WiSok+tLAeDsYEjAS g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="95218203"
X-IronPort-AV: E=Sophos;i="6.02,155,1688396400"; d="scan'208";a="95218203"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2023 12:48:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oe3aixKuqIX4Nbh2cxhMaJDSiQ6xX5EBQ4JY1zgveeEgsEo5T6lCxIrOwRqPDMQqRx+/hfEPwss0AY2pNdh/xqqAH5tf1eXdVyvFXX5DCqxeviRNeV+dC3b9opLt7yzO/+/GNdwq4UJS/J23eNn7EISNFA7Jf3RPmBJ+cl1gEVadOc9K20bqYrUOpWg/5OdeRSgweD9Lk4jXU9m0i93WF6YCKw9ufXSjOWIJx/aEBbJarPUmDG3I8gO30POOS0AlTu6gfgoC4TpP6rBT02QjrjA8ceog2/GlldCf6NolFPspAwQl6p9e6ZcPV9GGy0iE5Z+hPIzjpPK0KEnMlSSF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LtEoKERpNzNyLy5C9w0IDpgAVZXn0WzFsIjwHivZ6k=;
 b=E6PZ3mcYnXx8EKoOZwZYXNIfnzloaxV1WOwqcAkrm0+dXr/e2sY1S9lDcKMn/glQO8yw0rlXHiHc+wZ8eM3OLxvPByJdrRfC9pTckNZrFLT13anHZ9pQlUpg9BNzL+JVqIwrHn6JopewI3SMBcZcbO2mxnlA9+D0sg3Nrr1LuE4kBgNMjASHxXqTya+5z0JXz5mYFWIc3BeFofv4MGKDon3tms2n73EBBQCaO/n8tiqnWwCLJpyIUIA6wLhNec5ElrHx7yLZGCo+cnwVoDHaiH9x/1jVhLUuvkdllIfkicZPS726EpyJgSW1X0SANeG+NRObT3KkdV0fx42Pr9GPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY1PR01MB10624.jpnprd01.prod.outlook.com (2603:1096:400:320::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 03:47:59 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 03:47:59 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: William Roche <william.roche@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "peterx@redhat.com" <peterx@redhat.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "lidongchen@tencent.com" <lidongchen@tencent.com>
Subject: Re: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Thread-Topic: [PATCH v2 1/1] migration: skip poisoned memory pages on "ram
 saving" phase
Thread-Index: AQHZ50kkGtrj55L5RUGhi5iQm46XLbAbNpUAgACLToCABDVdgA==
Date: Mon, 18 Sep 2023 03:47:58 +0000
Message-ID: <5b5f3f0f-cb45-b360-bf54-ed971f6b3284@fujitsu.com>
References: <ZQCxg+M2IpecRT8w@x1n>
 <20230914202054.3551250-1-william.roche@oracle.com>
 <20230914202054.3551250-2-william.roche@oracle.com>
 <60d3efa1-d2eb-8e11-8909-eb1ef33204c5@fujitsu.com>
 <e8b7b4d2-7185-9ba6-6122-4fa780a08427@oracle.com>
In-Reply-To: <e8b7b4d2-7185-9ba6-6122-4fa780a08427@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY1PR01MB10624:EE_
x-ms-office365-filtering-correlation-id: 59386829-86cb-4369-009f-08dbb7fa0cec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GoiC7/7IvzblMeievPx+F9MxRfiaSLKLktpQNGp7+jr44453hAOQ+Xo8jIKrpdQWtmica/anvqDkZ4+7MAihzCPO9No7g6Lw3tARnZD8djSVCL6wSwUdhDd/135A3T6mqH6wH292HK01aRWZlSD963yjGEb+6aelmzNTe1RsEG6Xp7iir3tvpZZOGScQB9mAYos2sbvbESq/YPVa3VuLflL9CEQ/Lz94GydExsgIpwhKBuC/73uFoxixdEZ6xWTO8BFizUidqMNJhG3QFKhfuyxUrukO6zfpkQG25t1rDjPTXnNtUEmQ5pGUVVNMmZFzT6A6wcVf24TdfLWBeYvjIz3ZCG5Q6b+HlSmNhKwAGVRd1tVRe2n6Uk9jgukqw0IGkGjuyAVMYHMyIC7lRckWbZ0dnVGZ8dCG0AxQKJ890OcoK68zNTdmp3pbWm4O80wmY+S/s6LSfrt6Iu5OYA6m48BmLCtujP2jJTXgJ/EkyoR3gA5VpKVLkosshFaoiNE0NVpkgbbY9naDKiqqShx9ehcMs4bGJtl0ykgopynCa2blCH/Ad1pXYhM3ot3EzJevqhcY8Glt21bBMNltmLiahZkggHTvCcEqIAOg2dIYH0omwbuwquLYpZQSIFUsKmRHc2dvENvJuSgcBBm92nrHLYJbLkR9WqrSCfurr9q4YPBDzW+F1V+jrX5NKDKgqlE2v7y22MX+9Q+VsyJ9/IP0eQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(1590799021)(1800799009)(451199024)(186009)(1580799018)(54906003)(66476007)(66446008)(64756008)(66946007)(76116006)(41300700001)(122000001)(316002)(8676002)(4326008)(8936002)(53546011)(6506007)(6486002)(6512007)(478600001)(71200400001)(110136005)(91956017)(83380400001)(26005)(2616005)(31696002)(86362001)(2906002)(82960400001)(38100700002)(38070700005)(5660300002)(66556008)(36756003)(85182001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YndNSGRCVUE3bG1UUEdvYXdlSTNJY0drajFGNThQV1piV2s4cmJURWQ0ZlNO?=
 =?utf-8?B?eFdEa3dPRC9LNy8xb0xNbE9RMGdicmErTm1GbERKbDNEL3FKayt6TFpvZmlp?=
 =?utf-8?B?aDBocWFUQjQ2bmx0OGhKa0JBUm9kYjE5a1RYK3lUbjRKZlo5TFg1REN4U2xB?=
 =?utf-8?B?YVppM1BVcEVvckw5bkh5d3NNTWJHMmRKZmNKL2M4RmFxaisxa0hVZlJOZUds?=
 =?utf-8?B?NWZHWGQrdThJb1FDNU0yNGRzSGpjMnJsOGE0azhDWHFnSTNxWGFDL1c5c05w?=
 =?utf-8?B?dFVFRFJwYkRTSEw1ZTVWRUFqb21SK1NtQW5BSHpUQlNiT05SMUI2R0FCTmEv?=
 =?utf-8?B?R3h4RldoMjk4ZlhOZ2hIZlYvWlJiaG9pYlJ6QlBLb0FmMitRYjVLcHlmRzM2?=
 =?utf-8?B?cFUxRlBHR3lyWUdKN3pONmpVTVZmUU5BRmQxdi9samRHbmpSUEUzbUhKRVRa?=
 =?utf-8?B?WEhtS2tSQ3V5MmtaaG9zUGxTcWRRYkl0YTQwdXl0ajJobkwrTzZraXZCRkN1?=
 =?utf-8?B?SXV2TC9xYjN0dW9vR3h2bnBDdFowMmVrTk9FTmsxcG9lcDdxeGZXODZaaVpX?=
 =?utf-8?B?VDZjYzQrMndRc1ZzeGFPRnJUUEtxdUF4OGhRN2l6N3ZnN244Ui9xMm9EWmQ0?=
 =?utf-8?B?dGZQa1UxdnVRUHlqY2dwWEhQUHVDNUMvT0ppQlpOcWJhK0pBVnVTeUZYd21Y?=
 =?utf-8?B?N2U0MFNhbFFrV0JWYmdBMGRBQ0lvK3hHSnczaG1xaHorcWxzYmJKT1hlaEZr?=
 =?utf-8?B?ZCswTVRrb1BjZU1WZXRKS3V5SGNoVkZDT3Q5S1lkcGZ6ZlpFYUYzWVNkM0lo?=
 =?utf-8?B?bndyQUxKVzNQQXllc1c4WkpKeFZtNWRRMU1jbnRoWTJJSU52Vzh3eGpJNVF2?=
 =?utf-8?B?TnBqTU5EWlc3R1YwS0JSL1k2QzN2d3lKVjJ6SDVTZFI5T0hIUmJ2SjRUN2tm?=
 =?utf-8?B?WFRzY2owa1RIQ2ZmY2J4M3dGOG1iWnFhYzFVaUZyQmZHTm8wYVYxOEcwNnl6?=
 =?utf-8?B?UXZvWGh6VkdoSkpUeW16U2xXU1IwOEpHZVlhSTBtcGlOUnlYL0E1ZTBteWQ0?=
 =?utf-8?B?dkQ2V3ZBWWk1T3U1b3pJL0wrSS8zUTVBLzU4NWMvMnRKYmZaYkZaZENiVVpT?=
 =?utf-8?B?R2tNS2hzaDB6RGM2aVhRNXZ6TDhzVC9FbFdVVjBjUGxnOHRWZkhXMDhvQlhO?=
 =?utf-8?B?V2ZmM2ZVaUpKRzNmZDBZdzdiYW1haUFONnRXQ0VpWDJVUHVVNWVZeVlRVFk4?=
 =?utf-8?B?QkZJSUI0RHc2ZFhHNnlFUzJlU1EraVlLUEVDMG9zcWRiWkd3SUJlejdkbDVj?=
 =?utf-8?B?TkRldFZPUnQwcm9NRGZmZ3RiczlTUXpXVHE0aHFEb3pZZ09kOGttaDJvTnVP?=
 =?utf-8?B?RlJjdFFNMlZEWHBsVGFsQTNVUHl6ZE1yamQ3MVA0Q3dUUnJYRmVqYjd5UjRO?=
 =?utf-8?B?WVpyWG9ZT3MrZnppNGtoOHFCWG5aVFdvMEo1NGQxT3BiTkxPaXlqRitVdUli?=
 =?utf-8?B?aXhyVjVTR3N0SCthK01iNGFHeHpyc28yZW15NmMyN1dTUDl5d0NYeERMeHpn?=
 =?utf-8?B?OTd3YzdNRDJ6KzcxaDIxOFFQOG1IRXJYWnVvdzQxT0g2OFJWdFB2MEI2eHAw?=
 =?utf-8?B?U090RFVRSFZDaVRKeGl1NHRBQnBHdU1PVzNoajFQN2d5dko0S0V2d1BhNktw?=
 =?utf-8?B?d2Qvb1hVazNoMzdrY3Y2aVNmN2dPUVBKc0ZvRDBrUG55czdXMU1RRFRFdnND?=
 =?utf-8?B?WCtnVUIveldvOGl2dWRNVDJ3OUdHVGNuSTFiU2tvZUJhSXJIZmRzY0Z0aXBT?=
 =?utf-8?B?U0J6RE9tOWswMEttcjVVYVpTVlJFcmFDMlM3a2luQ2k2eUw3bkZ1K0tLcDh2?=
 =?utf-8?B?Qmh6OUFINU55b3dKRXRBVFFrQ003bGZZbTJzcnlqL2c5YllsWDdLYkYvVkN3?=
 =?utf-8?B?THVRSklBQTZXa3JHdHcxZEZZWDg5RHVjUS9nUmRxNHFUNzdkNTU3YVhud2lS?=
 =?utf-8?B?cnpmV1BoZEdseTMxWmtwQTZsRmovL1M1N3pCOEdrSWdaaGJTaG44SDF0S3Za?=
 =?utf-8?B?cEVBaEJpd2lmeUFmMmk1amZYVEsrSktFbXk2dTNpcGxBOW1nK0IzMTh0VThi?=
 =?utf-8?B?UkJSKzFBam42c2pzallVNHN6MmhSVjZyLzJEenVDLzFSdDNMMGU3QWV0NWx5?=
 =?utf-8?B?S2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ED5ADC97A63FA49BBD457D3D3862515@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bqJ/AbkvZmowOrTunU1NOYTfQmYx1OKdd+5oI+c2oKepqxvpS8dnzVCpJU4vHk+cgG9xx5fDyvMSk6AK6rHaFDRcwcDOCusWs5Qvdn+TajtD/rDZg8sEiN7yrfQs+p0kE2LCOuQ1H/KmQCauDJGs7LIVretoT27TxJorNK860+OseoU0jrdQsfbpEmmGJ6unABkqJ4I+nTyC8uDuVEvf85XdqlwBTBX6vp6UJ44kK6OoLosogV6KIP4LuNPlwdTQbU3PUHvR0Hvemwczw+dGlrXTNFIVv8Aw2wdzaKiWew/YAlD9510gWeQLLhgmaBx3winYzvbsMWJKiABb0pT6qaC/N9ukuo0ri6K8koggZ3JwRIX9tr6moQ74Kr3YHcvqLr1A9eYEb9+JUotLtyE0f8L+rbMTzEPSXaLtQehSd/GL4BuxwKWkEXd5+qXeGBlqMstml8e1XKRWJJsJmDQvG67Kd37z75C9O342QnDHz+1uP3fBy3UVn5Hjn0b3KBs9WDsBcICkY5a61g8A6ugkxTpFoQ8e019DAQPBwAAVYkJFbhMYtDxoEVDMAjESs5/yhAapn/sSxFVQ1NTkCkojeLdO/9GBvFgwsw9E0SuN0OXoL5ibCAzX25VoL9juhjA9+CRxf56/qKdz80XZ5fcIy5fD+++tRzPw9jKjextzSAiyUPT/RO+zcaxLm1JhQBGbapP0SWWZ2lBuN/tZ2b7y2eu1HIRiWrdKuOH0MxcRZFw62/WuKkkudJPDtSCTqx98GymKeSABnVGXM9AV1DFOOitDoncISd0PcUtnlKt+Opn4w4wLpbybQrB9TV4/j80daZ0TyBfZ6n3fCipZbHLhDgymKv8h/swv1SSb9yBnaEw=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59386829-86cb-4369-009f-08dbb7fa0cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 03:47:58.9376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fb+XA9JjFH2wUPBT9Gf1QzNF5kaOFHGwNhLR/1CpmtD51Vjx74yg1L7zla7MEJY8hpz0UKcYchY09CpQ0gCe8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10624
Received-SPF: pass client-ip=68.232.156.96; envelope-from=lizhijian@fujitsu.com;
 helo=esa13.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE1LzA5LzIwMjMgMTk6MzEsIFdpbGxpYW0gUm9jaGUgd3JvdGU6DQo+IE9uIDkvMTUv
MjMgMDU6MTMsIFpoaWppYW4gTGkgKEZ1aml0c3UpIHdyb3RlOg0KPj4NCj4+DQo+PiBJJ20gb2th
eSB3aXRoICJSRE1BIGlzbid0IHRvdWNoZWQiLg0KPj4gQlRXLCBjb3VsZCB5b3Ugc2hhcmUgeW91
ciByZXByb2R1Y2luZyBwcm9ncmFtL2hhY2tpbmcgdG8gcG9pc29uIHRoZSBwYWdlLCBzbyB0aGF0
DQo+PiBpIGFtIGFibGUgdG8gdGFrZSBhIGxvb2sgdGhlIFJETUEgcGFydCBsYXRlciB3aGVuIGkn
bSBmcmVlLg0KPj4NCj4+IE5vdCBzdXJlIGl0J3Mgc3VpdGFibGUgdG8gYWNrbm93bGVkZ2UgYSBu
b3QgdG91Y2hlZCBwYXJ0LiBBbnl3YXkNCj4+IEFja2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+ICMgUkRNQQ0KPj4NCj4gDQo+IFRoYW5rcy4NCj4gQXMgeW91IGFza2Vk
IGZvciBhIHByb2NlZHVyZSB0byBpbmplY3QgbWVtb3J5IGVycm9ycyBpbnRvIGEgcnVubmluZyBW
TSwNCj4gSSd2ZSBhdHRhY2hlZCB0byB0aGlzIGVtYWlsIHRoZSBzb3VyY2UgY29kZSAobWNlX3By
b2Nlc3NfcmVhY3QuYykgb2YgYQ0KPiBwcm9ncmFtIHRoYXQgd2lsbCBoZWxwIHRvIHRhcmdldCB0
aGUgZXJyb3IgaW5qZWN0aW9uIGluIHRoZSBWTS4NCj4gDQoNCg0KVmVyeSB2ZXJ5IHRoYW5rcyBm
b3IgeW91ciBkZXRhaWxzLCBNYXJrIGl0IDopDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCg0KPiAo
QmUgY2FyZWZ1bCB0aGF0IGVycm9yIGluamVjdGlvbiBpcyBjdXJyZW50bHkgbm9yIHdvcmtpbmcg
b24gQU1EDQo+IHBsYXRmb3JtcyAtLSB0aGlzIGlzIGEgd29yayBpbiBwcm9ncmVzcyBpcyBhIHNl
cGFyYXRlIHFlbXUgdGhyZWFkKQ0KPiANCj4gDQo+IFRoZSBnZW5lcmFsIGlkZWE6DQo+IFdlIGFy
ZSBnb2luZyB0byB0YXJnZXQgYSBwcm9jZXNzIG1lbW9yeSBwYWdlIHJ1bm5pbmcgaW5zaWRlIGEg
Vk0gdG8gc2VlDQo+IHdoYXQgaGFwcGVucyB3aGVuIHdlIGluamVjdCBhbiBlcnJvciBvbiB0aGUg
dW5kZXJseWluZyBwaHlzaWNhbCBwYWdlIGF0DQo+IHRoZSBwbGF0Zm9ybSAoaHlwZXJ2aXNvcikg
bGV2ZWwuDQo+IFRvIGhhdmUgYSBiZXR0ZXIgdmlldyBvZiB3aGF0J3MgZ29pbmcgb24sIHdlJ2xs
IHVzZSBhIHByb2Nlc3MgbWFkZSBmb3INCj4gdGhpczogSXQncyBnb2FsIGlzIHRvIGFsbG9jYXRl
IGEgbWVtb3J5IHBhZ2UsIGFuZCBjcmVhdGUgYSBTSUdCVVMNCj4gaGFuZGxlciB0byBpbmZvcm0g
d2hlbiBpdCByZWNlaXZlcyB0aGlzIHNpZ25hbC4gSXQgd2lsbCBhbHNvIHdhaXQgYmVmb3JlDQo+
IHRvdWNoaW5nIHRoaXMgcGFnZSB0byBzZWUgd2hhdCBoYXBwZW5zIG5leHQuDQo+IA0KPiAgwqDC
oMKgIENvbXBpbGluZyB0aGlzIHRvb2w6DQo+ICDCoMKgwqAgJCBnY2MgLW8gbWNlX3Byb2Nlc3Nf
cmVhY3RfeDg2IG1jZV9wcm9jZXNzX3JlYWN0LmMNCj4gDQo+IA0KPiBMZXQncyB0cnkgdGhhdDoN
Cj4gVGhpcyBwcm9jZWR1cmUgc2hvd3MgdGhlIGJlc3QgY2FzZSBzY2VuYXJpbywgd2hlcmUgYW4g
ZXJyb3IgaW5qZWN0ZWQgYXQNCj4gdGhlIHBsYXRmb3JtIGxldmVsIGlzIHJlcG9ydGVkIHVwIHRv
IHRoZSBndWVzdCBwcm9jZXNzIHVzaW5nIGl0Lg0KPiBOb3RlIHRoYXQgcWVtdSBzaG91bGQgYmUg
c3RhcnRlZCB3aXRoIHJvb3QgcHJpdmlsZWdlLg0KPiANCj4gIMKgwqDCoCAxLiBDaG9vc2UgYSBw
cm9jZXNzIHJ1bm5pbmcgaW4gdGhlIFZNIChhbmQgaWRlbnRpZnkgYSBtZW1vcnkgcGFnZQ0KPiB5
b3Ugd2FudCB0byB0YXJnZXQsIGFuZCBnZXQgaXRzIHBoeXNpY2FsIGFkZHJlc3Mg4oCTIGNyYXNo
KDgpIHZ0b3AgY2FuDQo+IGhlbHAgd2l0aCB0aGF0KSBvciBydW4gdGhlIGF0dGFjaGVkIG1jZV9w
cm9jZXNzX3JlYWN0IGV4YW1wbGUgKGNvbXBpbGVkDQo+IGZvciB5b3VyIHBsYXRmb3JtIG1jZV9w
cm9jZXNzX3JlYWN0X1t4ODZ8YXJtXSkgd2l0aCBhbiBvcHRpb24gdG8gYmUNCj4gZWFybHkgaW5m
b3JtZWQgb2YgX0FPIGVycm9yICgtZSkgYW5kIHdhaXQgRU5URVIgdG8gY29udGludWUgd2l0aCBy
ZWFkaW5nDQo+IHRoZSBhbGxvY2F0ZWQgcGFnZSAoLXcgMCk6DQo+IA0KPiBbcm9vdEBWTSBdIyAu
L21jZV9wcm9jZXNzX3JlYWN0X3g4NiAtZSAtdyAwDQo+IFNldHRpbmcgRWFybHkga2lsbC4uLiBP
aw0KPiANCj4gRGF0YSBwYWdlcyBhdCAweDdmYTBmOWIyNTAwMMKgIHBoeXNpY2FsbHkgMHgyMDBm
MmZhMDAwDQo+IA0KPiBQcmVzcyBFTlRFUiB0byBjb250aW51ZSB3aXRoIHBhZ2UgcmVhZGluZw0K
PiANCj4gDQo+ICDCoMKgwqAgMi4gR28gaW50byB0aGUgVk0gbW9uaXRvciB0byBnZXQgdGhlIHRy
YW5zbGF0aW9uIGZyb20gIkd1ZXN0DQo+IFBoeXNpY2FsIEFkZHJlc3MgdG8gSG9zdCBQaHlzaWNh
bCBBZGRyZXNzIiBvciAiSG9zdCBWaXJ0dWFsIEFkZHJlc3MiOg0KPiANCj4gIMKgKHFlbXUpIGdw
YTJocGEgMHgyMDBmMmZhMDAwJw0KPiBIb3N0IHBoeXNpY2FsIGFkZHJlc3MgZm9yIDB4MjAwZjJm
YTAwMCAocmFtLW5vZGUxKSBpcyAweDQ2ZjEyZmEwMDANCj4gDQo+IA0KPiAgwqDCoMKgIDMuIEJl
Zm9yZSB3ZSBpbmplY3QgdGhlIGVycm9yLCB3ZSB3YW50IHRvIGtlZXAgdHJhY2sgb2YgdGhlIFZN
DQo+IGNvbnNvbGUgb3V0cHV0IChpbiBhIHNlcGFyYXRlIHdpbmRvdykuDQo+IElmIHlvdSBhcmUg
dXNpbmcgbGlidmlydDogIyB2aXJzaCBjb25zb2xlIG15dm0NCj4gDQo+IA0KPiAgwqDCoMKgIDQu
IFdlIG5vdyBwcmVwYXJlIGZvciB0aGUgZXJyb3IgaW5qZWN0aW9uIGF0IHRoZSBwbGF0Zm9ybSBs
ZXZlbCB0bw0KPiB0aGUgYWRkcmVzcyB3ZSBmb3VuZC7CoCBUbyBkbyBzbywgd2UnbGwgbmVlZCB0
byB1c2UgdGhlIGh3cG9pc29uLWluamVjdA0KPiBtb2R1bGUgKHg4NikNCj4gQmUgY2FyZWZ1bCwg
YXMgaHdwb2lzb24gdGFrZXMgUGFnZSBGcmFtZSBOdW1iZXJzIGFuZCB0aGlzIFBGTiBpcyBub3Qg
dGhlDQo+IHBoeXNpY2FsIGFkZHJlc3Mg4oCTIHlvdSBuZWVkIHRvIHJlbW92ZSB0aGUgbGFzdCAx
MiBiaXRzICh0aGUgbGFzdCAzIHplcm9zDQo+IG9mIHRoZSBhYm92ZSBhZGRyZXNzKSAhDQo+IA0K
PiBbcm9vdEBodiBdIyBtb2Rwcm9iZSBod3BvaXNvbi1pbmplY3QNCj4gW3Jvb3RAaHYgXSMgZWNo
byAweDQ2ZjEyZmEgPiAvc3lzL2tlcm5lbC9kZWJ1Zy9od3BvaXNvbi9jb3JydXB0LXBmbg0KPiAN
Cj4gIMKgwqDCoMKgwqDCoCBJZiB5b3Ugc2VlICJPcGVyYXRpb24gbm90IHBlcm1pdHRlZCIgZXJy
b3Igd2hlbiB3cml0aW5nIGFzIHJvb3QNCj4gb24gY29ycnVwdC1wZm4sIHlvdSBtYXkgYmUgZmFj
aW5nIGEgImtlcm5lbF9sb2NrZG93big3KSIgd2hpY2ggaXMNCj4gZW5hYmxlZCBvbiBTZWN1cmVC
b290IHN5c3RlbXMgKGNhbiBiZSB2ZXJpZmllZCB3aXRoDQo+ICJtb2t1dGlsIC0tc2Itc3RhdGUi
KS4gSW4gdGhpcyBjYXNlLCB0dXJuIFNlY3VyZUJvb3Qgb2ZmwqAgKGF0IHRoZSBVRUZJDQo+IGxl
dmVsIGZvciBleGFtcGxlKQ0KPiANCj4gIMKgwqDCoCA1LiBMb29rIGF0IHRoZSBxZW11IG91dHB1
dCAoZWl0aGVyIG9uIHRoZSB0ZXJtaW5hbCB3aGVyZSBxZW11IHdhcw0KPiBzdGFydGVkIG9ywqAg
aWYgeW91IGFyZSB1c2luZyBsaWJ2aXJ0OsKgIHRhaWwgL3Zhci9sb2cvbGlidmlydC9xZW11L215
dm0NCj4gDQo+IDIwMjItMDgtMzFUMTM6NTI6MjUuNjQ1Mzk4WiBxZW11LXN5c3RlbS14ODZfNjQ6
IHdhcm5pbmc6IEd1ZXN0IE1DRSBNZW1vcnkgRXJyb3IgYXQgUUVNVSBhZGRyIDB4N2VlZWFjZTAw
MDAwIGFuZCBHVUVTVCBhZGRyIDB4MjAwZjIwMCBvZiB0eXBlIEJVU19NQ0VFUlJfQU8gaW5qZWN0
ZWQNCj4gDQo+ICDCoMKgwqAgNi4gT24gdGhlIGd1ZXN0IGNvbnNvbGU6DQo+IFdlJ2xsIHNlZSB0
aGUgVk0gcmVhY3Rpb24gdG8gdGhlIGluamVjdGVkIGVycm9yOg0KPiANCj4gW8KgIDE1NS44MDUx
NDldIERpc2FibGluZyBsb2NrIGRlYnVnZ2luZyBkdWUgdG8ga2VybmVsIHRhaW50DQo+IFvCoCAx
NTUuODA2MTc0XSBtY2U6IFtIYXJkd2FyZSBFcnJvcl06IE1hY2hpbmUgY2hlY2sgZXZlbnRzIGxv
Z2dlZA0KPiBbwqAgMTU1LjgwNzEyMF0gTWVtb3J5IGZhaWx1cmU6IDB4MjAwZjIwMDogS2lsbGlu
ZyBtY2VfcHJvY2Vzc19yZWE6MzU0OCBkdWUgdG8gaGFyZHdhcmUgbWVtb3J5IGNvcnJ1cHRpb24N
Cj4gW8KgIDE1NS44MDg4NzddIE1lbW9yeSBmYWlsdXJlOiAweDIwMGYyMDA6IHJlY292ZXJ5IGFj
dGlvbiBmb3IgZGlydHkgTFJVIHBhZ2U6IFJlY292ZXJlZA0KPiANCj4gIMKgwqDCoCA3LiBUaGUg
R3Vlc3QgcHJvY2VzcyB0aGF0IHdlIHN0YXJ0ZWQgYXQgdGhlIGZpcnN0IHN0ZXAgZ2l2ZXM6DQo+
IA0KPiBTaWduYWwgNyByZWNlaXZlZA0KPiBCVVNfTUNFRVJSX0FPIG9uIHZhZGRyOiAweDdmYTBm
OWIyNTAwMA0KPiANCj4gQXQgdGhpcyBzdGFnZSwgdGhlIFZNIGhhcyBhIHBvaXNvbmVkIHBhZ2Us
IGFuZCBhIG1pZ3JhdGlvbiBvZiB0aGlzIFZNDQo+IG5lZWRzIHRvIGJlIGZpeGVkIGluIG9yZGVy
IHRvIGF2b2lkIGFjY2Vzc2luZyB0aGUgcG9pc29uZWQgcGFnZS4NCj4gDQo+ICDCoMKgwqAgOC4g
VGhlIHByb2Nlc3MgY29udGludWVzIHRvIHJ1biAoYXMgaXQgaGFuZGxlZCB0aGUgU0lHQlVTKS4N
Cj4gTm93IGlmIHlvdSBwcmVzcyBFTlRFUiBvbiB0aGlzIHByb2Nlc3MgdGVybWluYWwsIGl0IHdp
bGwgdHJ5IHRvIHJlYWQgdGhlDQo+IHBhZ2Ugd2hpY2ggd2lsbCBnZW5lcmF0ZSBhIG5ldyBNQ0Ug
KGEgc3luY2hyb25vdXMgb25lKSBhdCBWTSBsZXZlbCB3aGljaA0KPiB3aWxsIGJlIHNlbnQgdG8g
dGhpcyBwcm9jZXNzOg0KPiANCj4gU2lnbmFsIDcgcmVjZWl2ZWQNCj4gQlVTX01DRUVSUl9BUiBv
biB2YWRkcjogMHg3ZmEwZjliMjUwMDANCj4gRXhpdCBmcm9tIHRoZSBzaWduYWwgaGFuZGxlciBv
biBCVVNfTUNFRVJSX0FSDQo+IA0KPiAgwqDCoMKgIDkuIFRoZSBWTSBjb25zb2xlIHNob3dzOg0K
PiBbIDI1MjAuODk1MjYzXSBNQ0U6IEtpbGxpbmcgbWNlX3Byb2Nlc3NfcmVhOjM1NDggZHVlIHRv
IGhhcmR3YXJlIG1lbW9yeSBjb3JydXB0aW9uIGZhdWx0IGF0IDdmNDVlNTI2NTAwMA0KPiANCj4g
IMKgwqDCoCAxMC4gVGhlIFZNIGNvbnRpbnVlcyB0byBydW4uLi4NCj4gV2l0aCBhIHBvaXNvbmVk
IHBhZ2UgaW4gaXRzIGFkZHJlc3Mgc3BhY2UNCj4gDQo+IEhUSCwNCj4gV2lsbGlhbS4=

