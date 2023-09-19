Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC67A5976
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 07:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiTSC-0007G7-Ab; Tue, 19 Sep 2023 01:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qiTSA-0007Fa-Lb
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:39:18 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qiTS7-0007ao-VC
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 01:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695101956; x=1726637956;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=n1kLOWl+K/OpO2+BSsu1WX1PHqavW/bX4dmTldouBz0=;
 b=v4qcSDO8sPNh3ACRg27uQSq/YbnHvjbHosH9/+FAQ/aKsm8GRMwzfrH8
 q/TD1nM0DXL0XHvbTLg9d5YQEt0G5YeSA6dGnFWMKEEvdhht9nslSS1ae
 NPrLvhJCh9//XzmAjOYkO7Ioj7MDiLcA/nivI7VTXJXvp82qAQVhYAoU8
 LngWUFUQQdoID4IocE7BuKbCDNPx2gu6e8Uy1AM36K74KPspnHdl9oXaW
 Ogn0PElA5qcEAzkRuETbJaDa3XXQYUONHW1cTDj3Zj0c9eJyIcOzTCmCV
 lBD/Rgr/DZAv5WsYPQ3vYzSDRpxRWkRsVyD5udf0fHYhOTr9qpog8XOH5 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="95775941"
X-IronPort-AV: E=Sophos;i="6.02,158,1688396400"; d="scan'208";a="95775941"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 14:39:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJ6McUuHWkS/T3UdYJKbYi+To2+IMTh/75IC1bulwbgUdfx79K5H9w/EmwPzRIG7bBW1WA8L8hMbol2OlPYTVVeXC9h7cI5KDLMyD9db31tJb0Qd0EZdmUoKnLPtJbzjjvaTgIS3++O5Lbv8348fJLfDKy7nrYT5cdkAcBTE/+dG5VwWsavlPhYFMX1TcL/XfYN+dPNnrMRM5CYJD6YxhRXFvnHVc/OLWwNarbknJTu2tCmrxboG2K2lVgqgmC29wZS6M69oEkizswya5mDx3VLV3pYDenOXSRGreEKL+3yToN7ZZ84TBiBLaIQh2DHwoTy0M5Y7a5vZ9LvsAfIoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1kLOWl+K/OpO2+BSsu1WX1PHqavW/bX4dmTldouBz0=;
 b=Re2AqlMiirR3AMjO+YDLG5aPg7b2wtypbXK6yIdzTGDMWTxEn3DXxBLepOJm2SvPE57Qc1eEsRNPlZ9HMuIKcnbKufoTZT0DrJNPe7FOpERWfQZaKVrXxEAtzQlK6mcxdElOcGNVkEqGuLOAC2qiiEJ5OXJJaEEe2fFTBuAUlJrFkZPLwNt2b/zOqmegeGkQT/UHkoSG1xsgb8Z6t0w7AsAH8ZcgyvdXKQkjU9WrHOw92XEMf9OIRxmf9vj1BOZr7SWWChLmWwSMQJXrPpHxYvJQZW3Jh+TkyW8KD/qLdA07f63STiCtC//eGoMPaRKmrNdbeeS2A/1fnMQ581UfTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYCPR01MB11401.jpnprd01.prod.outlook.com (2603:1096:400:38d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 05:39:06 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 05:39:05 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 05/52] migration/rdma: Consistently use uint64_t for work
 request IDs
Thread-Topic: [PATCH 05/52] migration/rdma: Consistently use uint64_t for work
 request IDs
Thread-Index: AQHZ6j6mDM3RzmWfW0eAUtKoXcUfvrAhorUA
Date: Tue, 19 Sep 2023 05:39:05 +0000
Message-ID: <a96ebaee-328f-6733-27f4-6af150d94ca8@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-6-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-6-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYCPR01MB11401:EE_
x-ms-office365-filtering-correlation-id: 08c4fa8e-13d6-4d3d-7a8e-08dbb8d2bd1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xo/152Wp+ZojN7heCGd0T29puL3A2dRG0oHwBNlPdJfz5Hp33qAinXTb/piClxeHp6WIBEiZScYukWKiE7CNK2J0k6JTXyS92nUEa6BmTYyugodCjlAxmYTxw0y91VAGiqw7DvxX9YDVC7u9vdNsrxxw1TwaVhpB1pYh3c15o8s3JTpIOr+kG4NDm69L7WmC8eORTyMhYLv6a09UV2re9zsbjPl4hdD+SemBuRfn9MTazg5ewygOjSL1zs3JC8kYBD8hsd9owyjPpaztpz6qGOoZ93uysbX/wvKoEUSCY6hX7WzIwPnIt8dayNAxzzKKl5zS3pX/cp14jNlwE7uChFi19lSXElKgIKHkDFglniHx6TrcLK4moEu81IVD7KabH9y8iaijGfx+iq2SsBgkTB5b49XSChqydxMQNPWsKCeA/khWSl4wb87btwRRKkXCpv2CRRhel1yfMjsXLWh/B8TygL+kfYOuOFZXBI05o5p6w7aSD28in+IUxdtMHKeQ+SSlZK9DUsTQbml/SiAxYRVzIM3hxLsQ5//3VqRG/DnaBL0TZZGHcPe0ITXFLMN/btWNDC/vRQEuFQspXHTp01BaXNhbUbz9vOzuKsSdMeS+Ocn//i8ELv1mdPJMEXmP9luTHJaH4LJifJk3Q3SH1XTix0MVToXTYenI1KMtKYtSN32snQUYxYuU3ZanZIzMn4H4Umr75CP3bWKEwnkoIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(1590799021)(38100700002)(38070700005)(31686004)(6486002)(6506007)(53546011)(1580799018)(86362001)(31696002)(36756003)(82960400001)(122000001)(85182001)(2616005)(26005)(2906002)(6512007)(83380400001)(478600001)(71200400001)(5660300002)(8676002)(4326008)(110136005)(91956017)(8936002)(41300700001)(316002)(66556008)(66476007)(66446008)(66946007)(64756008)(54906003)(76116006)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUd5VjFsM2lHMmJDSHFzcmo5SSsrTHBIRFQwMlUxY2FVL2FvVUc2c3BJcUF2?=
 =?utf-8?B?S0tTWlBQeElSNnpaK0czZmgxalVnNENtTWFYcGpSM2hMYkxnMFlZVEFhbUho?=
 =?utf-8?B?NmlzNzdlR0RtU2NmNnYzVHJIUnJzTUVYd3JLWjJ1cnNaU0RwVnpYdmxORVB1?=
 =?utf-8?B?bXJQelprMnJnZk1mb3F6SzFucGI4NlpIMGpvRHNUTVMyV1dTVG1aTHUvKzdN?=
 =?utf-8?B?ckEwUFhTNFVkZ0RUWTdra01uTmoxclc5MVJxTnk0MmVYd2ZNVldvTWFPcWRw?=
 =?utf-8?B?WU9Gam1DK05oOWFOalNSbFVkY2lueURORlA0b3B3K1d2VytEVFBlS3RlU1ps?=
 =?utf-8?B?OFVMNkRSUU5GVFpLbkRJemxUcUFVd0wrZFBzYjl0TWlob2dlTGlMKzAvMGJ6?=
 =?utf-8?B?U01iNXlhZVNqNWZFbC9tQ1hnQllrNlVGamVnY3FnY1pCKytjZEtqdXZTbmFt?=
 =?utf-8?B?VzNIaFR5WWUxZG8yVENpR3NpTWpLRWpSVEZ1OHBNcEZPa2hLZHBIQ3NwbUdW?=
 =?utf-8?B?M0RjbDA3T1JZNC8weFIvU1JMTEVtekFUV1NxK1oraUdiSlpzSUZQd1hZLzZR?=
 =?utf-8?B?WUEyeC8zcFJiLytrdFBwVitnR0dzSzZneVpGV3ZSWEdZNU1vcmFpUCtVVHRs?=
 =?utf-8?B?SWljWGswVUZXSmFaYWZqRWFuQ3hNZ2cyVjc4bDlGSDNpK2tXQnRIdDA3NFRH?=
 =?utf-8?B?NnJjWmVZaXV1cWJkOFF6akJBVC9IYjdqc2F0dDF6OWs5c085SGFPVytwNkRa?=
 =?utf-8?B?Wk5OQnBmNWhzNUFpTTJZWnE5d2VjZVA1OUNaS01nbjUxRmZMcmQzYW9icFBP?=
 =?utf-8?B?cndNcm8ydFpDOGNGZFRIUzdqOHdSUWZ1MmIwdm1WVFE3UjIvb2VUK1dZaEJT?=
 =?utf-8?B?OUY5aENBT0VUeUVhZ1EwMndibWVtTVFETU1IeWRSRWdsc0pXRW9tcWtXRmxP?=
 =?utf-8?B?OVlpcStkNzdiVDZVbW1Va01odk1HdnFuYUlzUUdZQlFIR0JTY1c2K3phV3J6?=
 =?utf-8?B?NVp4dVl6VXdNZTRVQWpnRWpzMXBwUG4yWFhSN3VjUFFydjNJc0JtcnY3UmVO?=
 =?utf-8?B?VktIaDM4VWliTGY2Z3BzVFZWTFppWnlhOC81cVcvZGFXRS92aS9GV2JadXBE?=
 =?utf-8?B?UVNFZjUrVDBRWVBWMXFOclN0a3VKUkxkbGVqSjNRV01lbDI1YlFpZHRNWjhw?=
 =?utf-8?B?Qm15UERzUVo2cHdCbzQ0TnZ4cGVpeXFUOXo0dTJkV082Zjh3WjQvODJRZWIw?=
 =?utf-8?B?UDBZclBXWFpEaDJFSm9aQnhFRnFnK2ZIekJobUdPdG9OZEhXbVFVc1ZINXBr?=
 =?utf-8?B?cU1qMDIrcFgxajBJUGltenFQcnpLOXR4aXUvUXJtdDkyWFVNeFNLUFR6YklW?=
 =?utf-8?B?MTZ0UnRXK3Y3MEw0MitzSFh2NzUxNWQ1Y0hhVTVlK3c3b1lUeEdHT0VtYjg2?=
 =?utf-8?B?MEt0YXJCZlNvYmUvTTNSMVdvZVpHSmQ3bFNXelpoaFZiaStBTXZOSVBleHhF?=
 =?utf-8?B?UElqVEhPS2JzdHNXRmVDY1RPUEFjRzd5UlZtNXJFd2lNQktjbXJhYnl1UEhS?=
 =?utf-8?B?R2gvWWhxSlE0SG1mNDI0a2d0Z01LWnhZSnZCaG1PTlhtd1RicCtxY0ZKMys3?=
 =?utf-8?B?ZEZ3aEhOVDhhMGdYak0wQ3ZlQjBRWTVqcEU0UUFiN21UcmJYZHhZTEJWd3ZQ?=
 =?utf-8?B?L1QzejR5WVJITWpWMm9iMWs5N3pUR0dXQWM2OHdyWXNkZit4aFZsZmpCcjFi?=
 =?utf-8?B?UnN4UHl6TURwbW9Xd0ptdVB4UDdNdWY3bW5nVWZoZTdvbWsrRkpKOE0wVkxj?=
 =?utf-8?B?MzJKQjh3QWVqSUQyT3h6TkVoS2tGdVU0a0dDajd0ZiswYk5TWjB4OVNRQ1lG?=
 =?utf-8?B?YlBFamU1TnlYbXFmNUV1NTlnN3hhV0JvOE9ocC9IVVlJbkg4UWtYWStBV1R5?=
 =?utf-8?B?TDZkODYxd1hncXJycHdDNkRvS1I1cTlkS3N6WXZQNXZnUGlSTmhDRHIwaGZa?=
 =?utf-8?B?ZllvTTRJTEVaaEZsQnM0K1R3c1J4MlhZYXpCZXB1MENXRU1jem9YdHNYSzBx?=
 =?utf-8?B?TnRZZ0pSTUpZMzhPL3QyemJsVTF2NlZuV24wSThISDVzK2FQMUd5bEZEcml0?=
 =?utf-8?B?eUVkWDFXc1RxUnBnL3Fxb3ZKYkxCeWplVjRFVmpoLzJOMXR0U3BpVVN1Smh4?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B0090C3B1EC8C41871065314AD6F60D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2R47jMUw44XO+vC3VvTI9yg3c3+d1nt44BwhCnuf0Y3LhpGtTaZYcyJhPPHhfAEPekcQ7jAjNLhf80LvCNgRRQTFifceQputrS050S/FeghDdCHHB0SXbUn9DtowAQsPsiX9LNtWkn9f6Z2VrxoXWWDraXd8Qdp7mqNSbunmjEv44kQn9NKpiZe9XDNWhMMvMYjqY3Y48IKtrhnojabRcj+k81f7aStNS+AdpcQz1Iba0Q4ap173soOvqRjs8AS+WjyNYPHJHCZzft8lX5nQ6rEcNh5EV7oC/CzUPISmA0RDBp+Fau/0Vat3fIMwbVR2cQyUKdwnalAo0ox77QDrJti5WwUu/Gaj0LorYz8fVgn/rwUSJkoXVnoLB6svZPs7X1qKYe/lgkGaHVqomkSJo5Faa4ud1VXcpVEwcmBye4QpwcUtH+qXb6ZgTUXsob6Im/4zjEn90YAHnMV9jaSOPvS4WfqEbilY53NyUHLiKwnVnHVCxP+MBod+/sKkZOlSVEFFBo4StviXKe0x6NFSwNjWpCXM9VRMThFSFMGI9oBxEFfB2G0QBIkiD3wbG0dDm3PDBmxiau0LYxccDivTnIu2lx5TOvNNE/F1s+S+KgA0u2wt5B8iwhGvPBBvTJRGa2i5GYJd5U/3tkpt0IigQ5g7K3taXyuLVuhshLWzcyyYO0HwOW78FzCAToym06HZMtn3TaOybBN+IlKq3iuMIvZ9HXClkNf1U3yeDNRqC7LgjEIDK0NbIC3gCEQXeegj4EBz4H86b8GtJZelWj7wh1YbNvUoGsX0IhKFPU7esaA=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c4fa8e-13d6-4d3d-7a8e-08dbb8d2bd1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 05:39:05.8157 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PEsyKx+PrvBKNJqobkq48jSj9J/9LFY/TglUrB0Q+ecO3tiIlh9FGp1qxT9LvKvGznQDyXZyD07cbenz3sy7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11401
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDEsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBXZSB1
c2UgaW50IGluc3RlYWQgb2YgdWludDY0X3QgaW4gYSBmZXcgcGxhY2VzLiAgQ2hhbmdlIHRoZW0g
dG8NCj4gdWludDY0X3QuDQo+IA0KPiBUaGlzIGNsZWFucyB1cCBhIGNvbXBhcmlzb24gb2Ygc2ln
bmVkIHFlbXVfcmRtYV9ibG9ja19mb3Jfd3JpZCgpDQo+IHBhcmFtZXRlciBAd3JpZF9yZXF1ZXN0
ZWQgd2l0aCB1bnNpZ25lZCBAd3JfaWQuICBIYXJtbGVzcywgYmVjYXVzZSB0aGUNCj4gYWN0dWFs
IGFyZ3VtZW50cyBhcmUgbm9uLW5lZ2F0aXZlIGVudW1lcmF0aW9uIGNvbnN0YW50cy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNvbT4NCg0K
DQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KDQpUaGFu
a3MNCg0KDQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgICAgICAgfCA3ICsrKystLS0NCj4g
ICBtaWdyYXRpb24vdHJhY2UtZXZlbnRzIHwgOCArKysrLS0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21p
Z3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IGNkYTIyYmUzZjcuLjQz
Mjg2MTBhNGMgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0
aW9uL3JkbWEuYw0KPiBAQCAtMTU5OSwxMyArMTU5OSwxMyBAQCBzdGF0aWMgaW50IHFlbXVfcmRt
YV93YWl0X2NvbXBfY2hhbm5lbChSRE1BQ29udGV4dCAqcmRtYSwNCj4gICAgICAgcmV0dXJuIHJk
bWEtPmVycm9yX3N0YXRlOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBzdHJ1Y3QgaWJ2X2NvbXBf
Y2hhbm5lbCAqdG9fY2hhbm5lbChSRE1BQ29udGV4dCAqcmRtYSwgaW50IHdyaWQpDQo+ICtzdGF0
aWMgc3RydWN0IGlidl9jb21wX2NoYW5uZWwgKnRvX2NoYW5uZWwoUkRNQUNvbnRleHQgKnJkbWEs
IHVpbnQ2NF90IHdyaWQpDQo+ICAgew0KPiAgICAgICByZXR1cm4gd3JpZCA8IFJETUFfV1JJRF9S
RUNWX0NPTlRST0wgPyByZG1hLT5zZW5kX2NvbXBfY2hhbm5lbCA6DQo+ICAgICAgICAgICAgICBy
ZG1hLT5yZWN2X2NvbXBfY2hhbm5lbDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgc3RydWN0IGli
dl9jcSAqdG9fY3EoUkRNQUNvbnRleHQgKnJkbWEsIGludCB3cmlkKQ0KPiArc3RhdGljIHN0cnVj
dCBpYnZfY3EgKnRvX2NxKFJETUFDb250ZXh0ICpyZG1hLCB1aW50NjRfdCB3cmlkKQ0KPiAgIHsN
Cj4gICAgICAgcmV0dXJuIHdyaWQgPCBSRE1BX1dSSURfUkVDVl9DT05UUk9MID8gcmRtYS0+c2Vu
ZF9jcSA6IHJkbWEtPnJlY3ZfY3E7DQo+ICAgfQ0KPiBAQCAtMTYyMyw3ICsxNjIzLDggQEAgc3Rh
dGljIHN0cnVjdCBpYnZfY3EgKnRvX2NxKFJETUFDb250ZXh0ICpyZG1hLCBpbnQgd3JpZCkNCj4g
ICAgKiBjb21wbGV0aW9ucyBvbmx5IG5lZWQgdG8gYmUgcmVjb3JkZWQsIGJ1dCBkbyBub3QgYWN0
dWFsbHkNCj4gICAgKiBuZWVkIGZ1cnRoZXIgcHJvY2Vzc2luZy4NCj4gICAgKi8NCj4gLXN0YXRp
YyBpbnQgcWVtdV9yZG1hX2Jsb2NrX2Zvcl93cmlkKFJETUFDb250ZXh0ICpyZG1hLCBpbnQgd3Jp
ZF9yZXF1ZXN0ZWQsDQo+ICtzdGF0aWMgaW50IHFlbXVfcmRtYV9ibG9ja19mb3Jfd3JpZChSRE1B
Q29udGV4dCAqcmRtYSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVp
bnQ2NF90IHdyaWRfcmVxdWVzdGVkLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90ICpieXRlX2xlbikNCj4gICB7DQo+ICAgICAgIGludCBudW1fY3FfZXZl
bnRzID0gMCwgcmV0ID0gMDsNCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi90cmFjZS1ldmVudHMg
Yi9taWdyYXRpb24vdHJhY2UtZXZlbnRzDQo+IGluZGV4IGI3ODgwOGYyOGIuLmQ3MzMxMDdlYzYg
MTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi90cmFjZS1ldmVudHMNCj4gKysrIGIvbWlncmF0aW9u
L3RyYWNlLWV2ZW50cw0KPiBAQCAtMjA3LDcgKzIwNyw3IEBAIHFlbXVfcmRtYV9hY2NlcHRfaW5j
b21pbmdfbWlncmF0aW9uKHZvaWQpICIiDQo+ICAgcWVtdV9yZG1hX2FjY2VwdF9pbmNvbWluZ19t
aWdyYXRpb25fYWNjZXB0ZWQodm9pZCkgIiINCj4gICBxZW11X3JkbWFfYWNjZXB0X3Bpbl9zdGF0
ZShib29sIHBpbikgIiVkIg0KPiAgIHFlbXVfcmRtYV9hY2NlcHRfcGluX3ZlcmJzYyh2b2lkICp2
ZXJicykgIlZlcmJzIGNvbnRleHQgYWZ0ZXIgbGlzdGVuOiAlcCINCj4gLXFlbXVfcmRtYV9ibG9j
a19mb3Jfd3JpZF9taXNzKGludCB3Y29tcCwgdWludDY0X3QgcmVxKSAiQSBXYW50ZWQgd3JpZCAl
ZCBidXQgZ290ICUiIFBSSXU2NA0KPiArcWVtdV9yZG1hX2Jsb2NrX2Zvcl93cmlkX21pc3ModWlu
dDY0X3Qgd2NvbXAsIHVpbnQ2NF90IHJlcSkgIkEgV2FudGVkIHdyaWQgJSIgUFJJdTY0ICIgYnV0
IGdvdCAlIiBQUkl1NjQNCj4gICBxZW11X3JkbWFfY2xlYW51cF9kaXNjb25uZWN0KHZvaWQpICIi
DQo+ICAgcWVtdV9yZG1hX2Nsb3NlKHZvaWQpICIiDQo+ICAgcWVtdV9yZG1hX2Nvbm5lY3RfcGlu
X2FsbF9yZXF1ZXN0ZWQodm9pZCkgIiINCj4gQEAgLTIyMSw5ICsyMjEsOSBAQCBxZW11X3JkbWFf
ZXhjaGFuZ2Vfc2VuZF93YWl0aW5nKGNvbnN0IGNoYXIgKmRlc2MpICJXYWl0aW5nIGZvciByZXNw
b25zZSAlcyINCj4gICBxZW11X3JkbWFfZXhjaGFuZ2Vfc2VuZF9yZWNlaXZlZChjb25zdCBjaGFy
ICpkZXNjKSAiUmVzcG9uc2UgJXMgcmVjZWl2ZWQuIg0KPiAgIHFlbXVfcmRtYV9maWxsKHNpemVf
dCBjb250cm9sX2xlbiwgc2l6ZV90IHNpemUpICJSRE1BICV6ZCBvZiAlemQgYnl0ZXMgYWxyZWFk
eSBpbiBidWZmZXIiDQo+ICAgcWVtdV9yZG1hX2luaXRfcmFtX2Jsb2NrcyhpbnQgYmxvY2tzKSAi
QWxsb2NhdGVkICVkIGxvY2FsIHJhbSBibG9jayBzdHJ1Y3R1cmVzIg0KPiAtcWVtdV9yZG1hX3Bv
bGxfcmVjdihpbnQ2NF90IGNvbXAsIGludDY0X3QgaWQsIGludCBzZW50KSAiY29tcGxldGlvbiAl
IiBQUklkNjQgIiByZWNlaXZlZCAoJSIgUFJJZDY0ICIpIGxlZnQgJWQiDQo+IC1xZW11X3JkbWFf
cG9sbF93cml0ZShpbnQ2NF90IGNvbXAsIGludCBsZWZ0LCB1aW50NjRfdCBibG9jaywgdWludDY0
X3QgY2h1bmssIHZvaWQgKmxvY2FsLCB2b2lkICpyZW1vdGUpICJjb21wbGV0aW9ucyAlIiBQUklk
NjQgIiBsZWZ0ICVkLCBibG9jayAlIiBQUkl1NjQgIiwgY2h1bms6ICUiIFBSSXU2NCAiICVwICVw
Ig0KPiAtcWVtdV9yZG1hX3BvbGxfb3RoZXIoaW50NjRfdCBjb21wLCBpbnQgbGVmdCkgIm90aGVy
IGNvbXBsZXRpb24gJSIgUFJJZDY0ICIgcmVjZWl2ZWQgbGVmdCAlZCINCj4gK3FlbXVfcmRtYV9w
b2xsX3JlY3YodWludDY0X3QgY29tcCwgaW50NjRfdCBpZCwgaW50IHNlbnQpICJjb21wbGV0aW9u
ICUiIFBSSXU2NCAiIHJlY2VpdmVkICglIiBQUklkNjQgIikgbGVmdCAlZCINCj4gK3FlbXVfcmRt
YV9wb2xsX3dyaXRlKHVpbnQ2NF90IGNvbXAsIGludCBsZWZ0LCB1aW50NjRfdCBibG9jaywgdWlu
dDY0X3QgY2h1bmssIHZvaWQgKmxvY2FsLCB2b2lkICpyZW1vdGUpICJjb21wbGV0aW9ucyAlIiBQ
Ukl1NjQgIiBsZWZ0ICVkLCBibG9jayAlIiBQUkl1NjQgIiwgY2h1bms6ICUiIFBSSXU2NCAiICVw
ICVwIg0KPiArcWVtdV9yZG1hX3BvbGxfb3RoZXIodWludDY0X3QgY29tcCwgaW50IGxlZnQpICJv
dGhlciBjb21wbGV0aW9uICUiIFBSSXU2NCAiIHJlY2VpdmVkIGxlZnQgJWQiDQo+ICAgcWVtdV9y
ZG1hX3Bvc3Rfc2VuZF9jb250cm9sKGNvbnN0IGNoYXIgKmRlc2MpICJDT05UUk9MOiBzZW5kaW5n
ICVzLi4iDQo+ICAgcWVtdV9yZG1hX3JlZ2lzdGVyX2FuZF9nZXRfa2V5cyh1aW50NjRfdCBsZW4s
IHZvaWQgKnN0YXJ0KSAiUmVnaXN0ZXJpbmcgJSIgUFJJdTY0ICIgYnl0ZXMgQCAlcCINCj4gICBx
ZW11X3JkbWFfcmVnaXN0ZXJfb2RwX21yKGNvbnN0IGNoYXIgKm5hbWUpICJUcnkgdG8gcmVnaXN0
ZXIgT24tRGVtYW5kIFBhZ2luZyBtZW1vcnkgcmVnaW9uOiAlcyI=

