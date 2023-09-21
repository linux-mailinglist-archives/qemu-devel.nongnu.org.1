Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1B07A92DB
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFRK-0004O2-E3; Thu, 21 Sep 2023 04:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFRD-0004Dg-Ur
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:53:33 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qjFRB-0004k1-DW
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695286409; x=1726822409;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yjiMqvv30f/WJ7CjxBQDj3QD7lSoiZHqRXZ8Kr1mXaM=;
 b=y1MLSb5olOp0uO2erSSipwhXQ/vPY5H2iJLcTkJLYMUyHCVXgNkA4P2K
 75fXjhOXC6FKtipurl6KxnMwniYMyNRDP0k3buFQ9j5RMqEBcloyjANFV
 DMSqq4k4YxUZeBNYCLAW5afQRDdhG2A/6x/2l7vtT0U1omUKvyfFf+eO0
 zOboqyyCkZsD5D6sjWywHSiqlALioQtFS0/TMTXbiPLJ4s+z3HIJ5VwOR
 XlEMEfNeCjT9AG4+VItCkYLGRa4JJeDbvptdYEC74nS+7eGbNc+BqO6xU
 +9R9aev2uCI7A5pJ+Ft9Yt9kleiIkODL7q8T9MExq9IX8Iv3xrlxuCWbw g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="96562277"
X-IronPort-AV: E=Sophos;i="6.03,165,1694703600"; d="scan'208";a="96562277"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2023 17:53:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXcf+5Cue1jKpBzUVyIbTDQ9L9fkL0DztnKGR934vNUbUD5+AS+PJRGNWLdwTptknD7TVkPsiDerHHStSfUfFzMXazhTQvRmzbHWDCRjynsFKM5hBTa0fgSiV1p8QIod7zSEMRaKkub+JMtkNVZfauu4FFQ65RKtWAI1oGYZHHf9zNGYF6Cw7wLvEn+aRRIzLR5Ec+TQtxpgdTH/YabcAUQ+NwPXJ/zo3IFhLBAqfIz1FAGZQ1c2tGmSvv9tnPwa4h+l/6Noq3vTDt1AJVbbdkuizqhZyq1UBHSAXlPvVsUf0QHlYtAjxURV0M48NQL+lKntbcQo7TqpFdsLykj0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjiMqvv30f/WJ7CjxBQDj3QD7lSoiZHqRXZ8Kr1mXaM=;
 b=RtgSpNU5iu7c+bVy6uRyjM/S9oTn3v6tNJIWDz88J4808MLwP1SU7u/XMvagO4ILQAiwTybxmtotH97Sq6XbpPiFMVovG8YvpUn1GryJgFk4M4dWBSjOrZcs8U3huhEkyyFkBVrhuehlAktybvI1GYM5ckOdQHZNjvBBVPYBhtt2BeHCCBXDtuVDbHShzrA7IzxrN/7nFCrS3SeG7EhGI3O12qkOzLyp1DDjFSNVF5A4ilJ2wMjQfgDbXr7SBbeKy4HrXK0uES45eAjsuhBsMW4Xz4juJ6JYSnr8sU65FCsGUpBr7qt3frzhsSMoop9pnB1Me6rqXlbuNdXRflsrSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TY3PR01MB10580.jpnprd01.prod.outlook.com (2603:1096:400:315::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 08:53:22 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::1a61:2227:a0de:2c53%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 08:53:22 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 03/52] migration/rdma: Clean up rdma_delete_block()'s
 return type
Thread-Topic: [PATCH 03/52] migration/rdma: Clean up rdma_delete_block()'s
 return type
Thread-Index: AQHZ6j+ZsQrW35mZlk+XBRQ7ObMT7bAk/aQA
Date: Thu, 21 Sep 2023 08:53:22 +0000
Message-ID: <16d91048-6477-31ae-7e27-6562d6217f2c@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-4-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-4-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TY3PR01MB10580:EE_
x-ms-office365-filtering-correlation-id: c6ce15c5-8daa-4d29-c155-08dbba80360f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V4diWrbTkcPXXDHlNmB33BUNhOv4JUByCNsWF5IommC/AKmBI7cedoYpxQ3f0Va2cUR0Bk2RQiq7mXMX13yWvbeybu3rl/nMASC0/pp+XdvOmR7tXZ1KaB1J1La9MZq1Dl37QJybTsgtQj2KL5cGl7Li2ge/IM/uQ/OI60g0zjRaebOvI9FRpJex6s4Ee/X/bvrmOBSTSKaHZGt6TpsVEltwlZRNDzUBgiifFRbDCQyfHgjij//KzWIGpazx+UzpqabscXKgKRW+PkhjCZ+6Ense1VLuX42nvzoahHnGigGGOFvzG808IGDPPD2KR8MG4UYQm7AlR2XLYEHGQnTehMbZM3aklh6OMm4bhPbDSaDSm8u/9v9tm78Aaa5hOHXklMWe93QV0RRGpQCiq/P4vTPJqdzpPf0zHPpQox2MNKIkcxBUivDSEAuMpMTTkW04OWs/9Tokwl41dwZeSAuW/sS/EP6fZy5xLEqzhLlXubeyDlfvzWGZBDIqwDYvY+yTk5kkWm6aEaxZhwwMEDngvE/sY+dRp3EJa0jzrdmh8GC81kfWc95JMGipu4MECP57KGZ1Bo+DHEng5ghyxosspjn2RxyMPxzcTnWkfInb5vi+YOiluT858lMBVP0toYaRAo/KCqfVhvxgWt5e8IRoSlbaqE2zu59jQwGu4kuWxpJIo9sUvozUx6X2InFEIlFOvbYCFaDCOR3RDC804SHnNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(1800799009)(1590799021)(186009)(451199024)(1580799018)(76116006)(316002)(41300700001)(66946007)(66446008)(26005)(64756008)(66556008)(4326008)(8676002)(54906003)(8936002)(122000001)(6486002)(53546011)(478600001)(6512007)(6506007)(71200400001)(83380400001)(91956017)(110136005)(2616005)(31696002)(2906002)(558084003)(82960400001)(38070700005)(5660300002)(86362001)(38100700002)(36756003)(85182001)(66476007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjcrRWpacGozTTFFbWpHcDI2VFIvaDVadFpDTXZYMHErQVJqRVBZa1djeDR2?=
 =?utf-8?B?SzJQOGpJZzYrVHl1OHdzdzRzR3NEeS9ONzdTSWxBcCsxSGk0TTlMOFN1dUlz?=
 =?utf-8?B?ZkdUVVkvbEJVRjlZaG5taEt6MkZVSTF4aXhkblF4TnpYTFI2Yng2czdnaTZC?=
 =?utf-8?B?TWUvRjJtWnlKc0xjdVh6QlM3ejMvN2daK2RNeGdXV3kwM2JKdDB1N1RUVSs4?=
 =?utf-8?B?UFEvdkVnQXBobDhMN29SRjFyRzZrNTdUL21aM0pXMGk3QnN4VlQyYW1HdFli?=
 =?utf-8?B?Z3Rwb0tuZytaeGF3amljZVdZaUV6dDJXdld0b1hGcDNyaXhtQTByMEowTUhT?=
 =?utf-8?B?a0hTaGY4NkxjZGNpcVJtQWhDZnFQbWh1U0ZkVzRnTkl2OStiazlnRUVXZita?=
 =?utf-8?B?MXZoemtoMTdac3RTUVdEVUpkSGtQbVhsMVE3dWFiKzlxL0FYVFBUdUgzeG1X?=
 =?utf-8?B?Q21aMWtCVTRqVVNGeEtTeFdJWGZOdkJ3R2M3S1A4YThkSVcyOVl5dHFBdTFv?=
 =?utf-8?B?M0xBWmpoTnc2TzVzeFM4Q0dWVVJpbUxteEpUWDc4eTFCYUphZWhtaUNYN2tm?=
 =?utf-8?B?RU5HSmtROEpUSkF5NHB3NFJReVFOSnFuVHg0R2d6dnV4cWFOdEVVbC9wRXY4?=
 =?utf-8?B?a1dWK1U1TWpyS0JSemNodVpFN3VhMDd1Z29zckI0OUtNeGhKUXlFOXh3NW9Q?=
 =?utf-8?B?Q28vOGwrQkYzbkhucTREUmVNd3JwWVdZb3lkUktqcktIZXdnWUgzNXdaYjFK?=
 =?utf-8?B?YStXOGtmVHhqQUl0ZnNYK3lrZUd5NnRpbWdjMHlnNkloQ0RnWEZlSU9BSmtr?=
 =?utf-8?B?YlpiaTNZY2lHRzE1V3NjaVBvQXkyaStWRFRTd09DdzNTdWhwOFdkWnFvWlZx?=
 =?utf-8?B?SzlvdGZZdUQzdHJXNzBSNnRjQlhVeWIzRUxzK0s2RStOWWlFeE0zK2RJZkgz?=
 =?utf-8?B?SEJ1Z0VHcG44RDBiL2kybXZFRzhzYjFwczFabE90QmpSV3FqcCtZc2Q2VWM2?=
 =?utf-8?B?Q2ZPeGx2U3VMbjhGd3dYb1pBMjlSUVFhZEVUWHo2QnFCOEJ0Qm8wZ0FVOW9w?=
 =?utf-8?B?VDNzOHBndVBOTFlZMnp3VktBTnQ4ODJxR3RLdTBGd1I1S3hCV3hJd3g1V2JL?=
 =?utf-8?B?ZlJ1Rmd1Z2RQNnhiUlVDZWRiRGJ1akVtNWlEMDZ3VWhqOC9IcG8vcGF5cURO?=
 =?utf-8?B?TTUrWk5abzQvYXV6bUxROW5iV1dPZnNpdmJ4RjJNOVU2NlRDQ0FuZmk2WU5C?=
 =?utf-8?B?S3llWTVzZmNzOGpTWERPSEFEUlBvZks0aW1NT0dVNjU2YkhYd1VHc0dzVmpT?=
 =?utf-8?B?M2FJREhjY0UzY0t1NFZkNjNySkRjZWd2aFRtMHZHbGkyWGFKbm4vd0tzSkUy?=
 =?utf-8?B?SWx3Y0szcWdGR2FhaUVZckFoa1J2RTZpZnd4b1lyNU9oeUJVY2hpWnVlVjBC?=
 =?utf-8?B?N2hVUENDbTA3U2hERmx4ejVJaGVLMURkWk9jSEw3YkNJcUZZekV0RHBZdEpp?=
 =?utf-8?B?bHZGZ0IrZU9Wd250cDQ3YVVqZXU2R3o5WDY2MzBPL054RHdZd2hrRXZDOHhT?=
 =?utf-8?B?WFJPMytBbnpjUHZITGwrTmVpMzVJaE81aU1ucmZOazk0S3hlWVBLa1RjL1Uz?=
 =?utf-8?B?U1pjd3FaMWVNdWpCQ2pSbnU3OVN0WFg2UFRqY0RDRXY3MDU1cG5ZTDE1YWVa?=
 =?utf-8?B?ZEF3cXpqaEp6VXVtYk5GZ0xtRFJrM0l4Sms5b0VFT2d1am4veFNwMXpKRFp1?=
 =?utf-8?B?dm1kSUUwYzFSQURrNmVGVXdWR2tuSjJFTjFsaUhMM2JmdzIvVWNpeHBMbUE1?=
 =?utf-8?B?UEROeGtpREVlM1ZtRis1eUYrbmVVWGVvek50OHpTKzlrUFhZbWMxSzV6aERu?=
 =?utf-8?B?VXJMak5YaHJZdDdhRG5UWmpQOWJkeHhpNEdyczJyRzM3SHpwMXdWdFZHN254?=
 =?utf-8?B?RjhXTE5NeE5FTG5SSWt0UEI2Y1o0aDYyaTVPNzZGNmd6UDJJNTVMdGE3Mk1E?=
 =?utf-8?B?dE40YnJlZzFueWZUUXRhczU2K2x2am45OUZyWGhxTm1TWEtoTmJBNnNFT0dU?=
 =?utf-8?B?SlNRa3E0dVpxNERhTU0xTnl5aG5ER0NZWHM4N2RDQ2o4VlBBUXpSbGQ3NTVJ?=
 =?utf-8?B?UzBibGNESE42VzBpMWZmdkIrV1hNT3JMbE1JS3QvbGpkZGMvdEdJdzd2K3Jj?=
 =?utf-8?B?bUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52A9E03D5F4C99489B827DC1C8894BB6@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wW+1sS/sNgCn2nrwz1aC9/hW3ROtuTVNt4c9Bfzlxq535sffk055HX9yE/wiKUV6BWPsRkzm2c6dufxxjMNvLCINGol+8MT907/bcs1LcAYovbLaMXTvFfHrDB1pQgOBf4WsD9HTY6C9pzIE4++pDK4ItwLUfMoekCWmZzZLVDifi1T/tqy6lIAnEQK78m2oqneZCk757u69J9/wvBHeydb6Ek+CXEwECAQV7a2TLuQ5Nk2QfqrLD1Fp20E3/dUXv1thNVUxGEIxEUhcJmzMEQnspN34p3L5LVXbjv3lv0+4BKXrdkEzI//jGF23zS4jMxaKwW/7S0cLH8oUxR+SI806qYvewEFCcXwPrJffrQrZkf9RNRfuwnaYCkp9od0gUJs7WDpbc/3HBNgXWM8B7T6NxJmXDfAAj5+c1GGi7uvJ4NL3EvREcu51DQs4YOzWsF9AXoLTSjeF0sAgffc5gFJtRk/hN7aLpDexnGAd24jl1u+aU8APpzarn8dJSUwCzRMDn7P8WufTBPaqPHVL0XxbiToTli24Gag40tjmfmLlMApPdC7Lb+NA4dr5NZ3MfIhXXT4+FOw4WGMcYQ4Rl+ekcf+vG0wE8Kh22C7PC2AqfUgnK4B4eZ855vgDt8SKGUdHGj8DEU7czXaXd0BukM0OcgxE88Z2Xaa05Ti+vQVPyqYTbza0QQOtIFFAIuTNq5WwcZPo7g6YcoveTjyMKPtfm7VJyK4M8SE0O8zB0rFdsEMB9YcMC1ijcMrqKevNcBFsNvKdA2R4wNy4/L0M0BWNqx3A43n3BYI4CbbOpBI=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ce15c5-8daa-4d29-c155-08dbba80360f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 08:53:22.8128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+Ff9T1+qTFu17LS5ker/C8bQYgYgxxll/fovKk5sA2BYUkjCni99+kEqjjjybVo6k66aqV3oHyJMjuwXlpkrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10580
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
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
X2RlbGV0ZV9ibG9jaygpIGFsd2F5cyByZXR1cm5zIDAsIHdoaWNoIGl0cyBvbmx5IGNhbGxlciBp
Z25vcmVzLg0KPiBSZXR1cm4gdm9pZCBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWFy
a3VzIEFybWJydXN0ZXI8YXJtYnJ1QHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+

