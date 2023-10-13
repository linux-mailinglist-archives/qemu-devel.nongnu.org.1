Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C808D7C8043
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:31:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3u-00086f-10; Fri, 13 Oct 2023 03:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD3s-00080i-4S
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:20 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD3m-0006l1-Ql
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697183895; x=1728719895;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RGAbDc/GYKQSX+fmP/M/oWqowNN/mK4nol3QOKsY39I=;
 b=e9cMviOl3Q+llTCKI2p5eLVelAQ9jRa1Bo4cZlD/K7NQqdeLHIkqW4GA
 rsHc+AKAtuymqm6HhPopQpc6YPPEbBSU1yGXADg+ydwMMB/VzwVEeoJd6
 Thj/Kkje5oLiYukMPZspcylHPW0Hn/4SqHej/wS01qilQFZvS4h2WLM09
 A/K8GRV88nbuRYxhsUzG554XO1D18EvvAvmzo8NH5NyHlX3WmG8qGGux5
 X8fPN7a9Q2O6H0kizwFMMPo/Zo4QZ5E5fvdHYqTLXbbSwz0j+Vtedb0tv
 pFDvlTlN9Bo9LQVFqBn3Yg4zpm4Iqo53JZwDN3pkU4AUJ3yTrtkzuvJDb w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="10152546"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="10152546"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 16:58:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oD5wpvfZP50ohabfUGazXIoFPeNypX+OseI/h19uhs0GwELvv16V61QwGvjpVC1gbIRs6TTEKL3OeJju+pTaA6Cie5J26CfQ5FkXtKXx4U77yrsQdsRtOjAmQmLKF5JFZUHJB+C+P7HB7yW4FTit+XReraLR5AFwO0Xk44H97KAZ2jmOJXVRIb/z4JwyPGOmFETOeLI93LH72PWSdC0mcfhIFulUKsesCbWBNbXq0v75O3bh26Ks8q6ajtcs3OWawU8HelYoWqHP02GvekJwSxcPwZOhbjOsQFD5qMRq2cBgsiOD6rtLLDTXfFraGQkEIR7wQwIG2O76isIXLHpFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGAbDc/GYKQSX+fmP/M/oWqowNN/mK4nol3QOKsY39I=;
 b=WGtR4S9mdOo5fKDMXkQAs6rw55lhPo+Eyzp7uyvN1eyW+wcUX2Z2PqYgnZFD14Lw5uls6fd4Q24KfNEhmfuFnqrr1woxJwTkZlj4hNyO58HiTVBn3clJQoClaTmUavBw2Q9pwk7A59eDzrlq2mYGBOsGNuGuvMtdfld2I2oKG1XlN5vIsVRTzVLpNpSi9fsfeFD++d90Hi7eqfK6shOYxR1hGWoAiThSwmgczWgKikUrIrEYIhJoYVcZ9XRpzs+fP33MCDuY4kjsVxFHILilLnX1J7EWFwpirPNUAYPmYZg6fkR/Qkbb84WXn3sdJjM9Z3t8zKRVTX5Akwt9KX6d4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYTPR01MB11035.jpnprd01.prod.outlook.com (2603:1096:400:3a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 07:58:08 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 07:58:07 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 01/13] migration: Create migrate_rdma()
Thread-Topic: [PATCH v3 01/13] migration: Create migrate_rdma()
Thread-Index: AQHZ/IKEGzSpQRMYOEa0VMlf/1g/MbBHXPmA
Date: Fri, 13 Oct 2023 07:58:07 +0000
Message-ID: <cddb87a3-52ef-bc29-4fa4-370d4e7a4449@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-2-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-2-quintela@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|TYTPR01MB11035:EE_
x-ms-office365-filtering-correlation-id: 18a179dd-a10a-4981-901f-08dbcbc22316
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rd5Yw2WfMe2Hg/oQWZcduIAqsSyeuBmFBImPG5xGZTbb1pNyBiTOG7kxWhEZ1x/cDVfvM9i8cjWeTcxo3bbWutZC7QA9HRWrpIRzgexZrDn4mS4c4c82Qg0Hhn3yF9J1AlUsul1ik0ijPly5WtCN77MiY2HPhlLbkKVJuQec9xTNzrMqj752CMIJI6L4rACxpv465gZLcT4VGRbY2Hy6zC/h2pmTtEBHo4e1hGalxRuRn3UC40FpIAhF+BDnngJlqWU44WUt0X0gFK1RMPf3bmQGysL8aga6TH8ryB/OPFqdMQIjmd1vEsSURkBqC+NjQvjKP781raLoNUwSzbY6AzyVHx38Hyh03SaoDpDnqoBWoLnTKY4lIHaosAmE6ZOh39RTCV5ZuKIt0XGvabCIwd6WQwoB+HABvScrWix2stHlsnulnM3EM2pfDlSsX3T14s3B7gHQKMgKLMrXQ1/q502G+zuOJikJEgI6o8O6Z4sVIsfQBdNUoadrPIfDuReQ3N2HGYvHhPCeznI/+Rf5rIGMli0QkRW+wCQdRIlbbrKsNq2NpicDAIeRPoenDCJykPKUHrDOZBh+UTTxqfmQ64BaLNfmigqGyKhJOByBos32dxWsrSNgahrlY4mGtRg5vI7xYoQ+KlgE6Hj3itkTKiy5jxJ5OVKSYdKcrSipxLabDegh4KZhTMOWe4J5jNoDNenewgFLsTeyVusQYQZNzQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1590799021)(451199024)(1800799009)(186009)(6486002)(41300700001)(110136005)(316002)(91956017)(66946007)(54906003)(66446008)(64756008)(66476007)(66556008)(76116006)(8936002)(478600001)(4326008)(8676002)(6512007)(31686004)(1580799018)(53546011)(6506007)(5660300002)(38100700002)(122000001)(86362001)(38070700005)(31696002)(82960400001)(2906002)(2616005)(26005)(85182001)(83380400001)(36756003)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0NFOGh2bmR3cWswbVViclB1N2xlOGl2a2U4cFROdEFKZjFuRVg1MFhzUHVw?=
 =?utf-8?B?bVlQb0pONXJWUlFKbUVMb3FlOThEUEFWZlZOVXo2V3RBRisvbjFwVHlpdlpO?=
 =?utf-8?B?VW1IbzY1THlLK0ZvaHdtb1pJRnFhRDQ4bHgyRDE2VW55RHlDd0tPVUxJSXNt?=
 =?utf-8?B?MVFIL1pReW15SDBNcU1yREg0RzRjM0xITEJwWkJyV0ZveVFEN0FlcXpCR1Y2?=
 =?utf-8?B?QUxDM0JzM2VXTEFsNFdyVmhWa0tVeHNpbzJEcXp3TGlLcnJHY2YvM3JDYWov?=
 =?utf-8?B?UE5mblZWdUN1RnRxZlpwd3FIcldlZUVLaUNlSEFkZDBTVDFEWmJBZmR4d29k?=
 =?utf-8?B?TWdPTWMyYlR2RUZwWGFRa1p2UWxRL1BTYTNBR1ppNjd5TnBxcmlzSDFOYmlZ?=
 =?utf-8?B?aWZSZWlscm9ZODNPaElJbitibmVMckVXTGlrY053c3dDYlNNR3E5T0M0T0M3?=
 =?utf-8?B?bndsYzhmWEZNT1djVEQxT1Y5RllnMk1odFNZbDZwTXlPdVNEWkY5OEpYQnhj?=
 =?utf-8?B?YUVIc21XVGhYSk1Ra3puSCtoeWR3T0VLN0FVODMzd3Z0TC9rOGdCT0ovUUNi?=
 =?utf-8?B?MUt2Tk5LVTd6VlAyalE0TFg3bWorR2JSMTVOdVgvTFUyTzNOcXJEUWw2L05C?=
 =?utf-8?B?M1JBYWQ1S1I2UmY1WUUvWkVJcVlvWHI2d3hDUTcvRGE5VXlmMzZScmdaQ0VB?=
 =?utf-8?B?R0pqUS9GaUkrdDRMZXRUZ0JTUGZRZE55Rzl3VDVxaVNhVHBsVzIyOVBDSytI?=
 =?utf-8?B?Ym5Jc0cwd2tKeEQ0RTNrS2RQTFpvYnQwd0l4aDNmdkF6REF1UDFXWmFnbUNw?=
 =?utf-8?B?TFFFU0tlRUZsRFJlOG1HRlUzOC9MVDJzU3dEK2FrQnhrbUM1Nnhrc2taZ2NC?=
 =?utf-8?B?T0pDMFpReFY1OVRrVjJRUzNwa2hrQVhnNmhhMGVZK3hOay93aGxiN2I1clhm?=
 =?utf-8?B?cWo2LzlacC90emRLeG1LYlQybjN0N1FSOXllcGRLRS9XSkF6amlvOTd2SFVW?=
 =?utf-8?B?QUZTNjdoT3ptZHBQNUh6bkY4VTVGbGhFUjdacHRmcDRLU0xaNTdnSUdjWEMr?=
 =?utf-8?B?aFZad1E3RU43MkVlWXA0dDF0MUM4eXdxOVpEUU9QTUd4aXd4NFBGQUxTNmFv?=
 =?utf-8?B?SVRqcE9SNjFjaG84bm5zd0hacFNEVGszbXIxelQ0ZDJDaC81NndQbFlURjV2?=
 =?utf-8?B?UTNTZkdaNDg0MWlkUnlDcXpCdEUyamVsWjd3d2xXWThsNlV4Z1BsRExhaHFY?=
 =?utf-8?B?UHZhSXJhcjVVVFd5SHF6TGdCVG5IaEw0VWFvakI0MUVMYlk1dDBKRVo1WFpE?=
 =?utf-8?B?cmEvbjN0em5DZmhFNEJSTWhPaExVWjVYTUtSLzk1VmZ1UVBUNTZhSlF4OEVp?=
 =?utf-8?B?VVowZndkaXJTZ2F5cXZjSjJsdUFobCsrZndBMXh1UjJSekdDci84T3cyREtH?=
 =?utf-8?B?N0NqaXo5bFRBMTczb1VOaHlSTG5ZcHVpNFhjanhSWnY0WGJzV0hwUXJVcWZP?=
 =?utf-8?B?RlFCeDVzeFkwM2pXU3R6cC9qZzZkMXZSYkk5TEJOZm52clcvR3dwZjBXOThw?=
 =?utf-8?B?ZnEzK0ZGYmxIUllnTFVMblEvNUFXN3FTcUFZOHFWbzFtK2Q3bWVsT05BbmRx?=
 =?utf-8?B?OGJlRWJWZ1N2R0NLUHhiNVhRNkRIMWEzMG9UcnVwUyswSmVRNHk4OGxLdWpU?=
 =?utf-8?B?RW5FM1pMY2Iva0ZWVndnZWNDSnNRV21CcGJ6OVNJNU9VbGZoeXJmZzZ3eGE0?=
 =?utf-8?B?cVdQWUFVREd2M2N3eTl3SVIyenIvd0ZEZlZLVTNjeXN0anB2cGJVK2daSGxF?=
 =?utf-8?B?VXEybTM3WGcyWVBQdTEyc25JU2lwc0F0bWNVQlFDeEVpd29tRTBOaGc1RlBn?=
 =?utf-8?B?QnNvcGFFdDExVkwzTUJ0S2tDVUtTM0NhMGYrTlZrQkdtc01ENmVqRlMwb29D?=
 =?utf-8?B?TVcxdHh2azRGbEU2MHZNYVUyazF5OVdCQmVxQ0J0V0JtdmtPOWZRdHRxSzNv?=
 =?utf-8?B?ZHZDeGRYamhQY1VIZWtvSFNQNlJtVk5wNSt5di9MdFlxcTdIaFFWZW4zQWNZ?=
 =?utf-8?B?R1UxMXdnVWpnRDYrNmJFNFk2azJuYUVFQjIxWHAyT3MyRitmZkRrQTVnV3hM?=
 =?utf-8?B?a0tQUm55L1E3b05mMWdYTHJtbFA0ak50ek5iZ1UxREhRc2pKbDI3bHNKKzk0?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45DF3C004CA361499B3872F4F876A46F@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PaTiIc5yDUPd8w96gMM426uZWDZq+9TZZc3+ZQeyG2Kq9oWy9YkI4y2FmUzX+brssmoZBtdwuqJjmRb8qYBcs3OKAhHIoaN+8jNVksla+vt+9/Z1te0T14xnyrbt/CSVjMqVnvS10xGOtuVKlmuomSQlwM6Aji2wI7txxMjP8iCzHg0+KURAbbNabB8Ja1NvyX52GCqhM/14iC1PztfJC2Udy7vFDkej9NvZS8kFHwhexQSDtObEABD5jkGhkGzXDvJbZKXCf/TZwFwmVXznMQh0q0o1FYle5UBi05dQg9QyCmYV9vMov9jIH7CP1mQyVvMHD6G3u4mFZ5C8/+lGjn/ae2vzMOEVcXVUQPuiCxuE/EK4PAu5xLWSmfrygISHjOHy8pAAFEWXOxNEol7B+5fA7SuI0aR9cNiGpxLUY5TB0G+eUf7mYx9VKf25mxVtI447fDVShRqYktD1JTBRPJdtZuuUZWi+hTefBeX9E9fxaOrEKxp+lEGhv1bNqf0klmzKIjLjI8oC7URhXwUShcyAmXnKpCVVoJPK8m8GwuUQ+qWnuMBnkcnyxJFNihz9Ody8cQQ6aHz6LU1NxOuGEfJfryZdr8EyexC8FUq9G2GR4bC6oke4XgdzxbSJls2+WtHA79D8bBntcTZf8xkam6PMQqK5GJtxpb//9QL50vIROv18OOOjD8jfRo7+xBDACbcE0H+eCgkJPZGqDXgFHeORITbW+3q8GcKBZlWkhHGR2cOl2CQmZxHr9sDgDND7+9bRB2yvMveqIhBrXiLD1xBqB3WPC++Yb6ar8USj1TeFH3h1E9cEwuG7VqpyJbAZ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a179dd-a10a-4981-901f-08dbcbc22316
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 07:58:07.5751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JH6EoTrTzbIjuN7qvUR3b5ArFz6Z9BsORe1LK+3QxMO3wK8DJB65GjJyspB70tfpIMxnWQsfPJxmWXfXOm+Elg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11035
Received-SPF: pass client-ip=68.232.152.245;
 envelope-from=lizhijian@fujitsu.com; helo=esa1.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IEhlbHBlciB0
byBzYXkgaWYgd2UgYXJlIGRvaW5nIGEgbWlncmF0aW9uIG92ZXIgcmRtYS4NCj4gDQo+IFJldmll
d2VkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1
YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBMaSBaaGlq
aWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCj4gLS0tDQo+ICAgbWlncmF0aW9uL21pZ3Jh
dGlvbi5oIHwgMiArKw0KPiAgIG1pZ3JhdGlvbi9vcHRpb25zLmggICB8IDEgKw0KPiAgIG1pZ3Jh
dGlvbi9taWdyYXRpb24uYyB8IDEgKw0KPiAgIG1pZ3JhdGlvbi9vcHRpb25zLmMgICB8IDcgKysr
KysrKw0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgICAgICB8IDQgKysrLQ0KPiAgIDUgZmlsZXMgY2hh
bmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9taWdyYXRpb24uaCBiL21pZ3JhdGlvbi9taWdyYXRpb24uaA0KPiBpbmRleCBj
ZDU1MzQzMzdjLi45NjI2MDEzOGQxIDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vbWlncmF0aW9u
LmgNCj4gKysrIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5oDQo+IEBAIC00NjksNiArNDY5LDggQEAg
c3RydWN0IE1pZ3JhdGlvblN0YXRlIHsNCj4gICAgICAgICogc3dpdGNob3ZlciBoYXMgYmVlbiBy
ZWNlaXZlZC4NCj4gICAgICAgICovDQo+ICAgICAgIGJvb2wgc3dpdGNob3Zlcl9hY2tlZDsNCj4g
KyAgICAvKiBJcyB0aGlzIGEgcmRtYSBtaWdyYXRpb24gKi8NCj4gKyAgICBib29sIHJkbWFfbWln
cmF0aW9uOw0KPiAgIH07DQo+ICAgDQo+ICAgdm9pZCBtaWdyYXRlX3NldF9zdGF0ZShpbnQgKnN0
YXRlLCBpbnQgb2xkX3N0YXRlLCBpbnQgbmV3X3N0YXRlKTsNCj4gZGlmZiAtLWdpdCBhL21pZ3Jh
dGlvbi9vcHRpb25zLmggYi9taWdyYXRpb24vb3B0aW9ucy5oDQo+IGluZGV4IDA0NWUyYTQxYTIu
LmEyNmZkMTY4MGIgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9vcHRpb25zLmgNCj4gKysrIGIv
bWlncmF0aW9uL29wdGlvbnMuaA0KPiBAQCAtNTYsNiArNTYsNyBAQCBib29sIG1pZ3JhdGVfemVy
b19jb3B5X3NlbmQodm9pZCk7DQo+ICAgDQo+ICAgYm9vbCBtaWdyYXRlX211bHRpZmRfZmx1c2hf
YWZ0ZXJfZWFjaF9zZWN0aW9uKHZvaWQpOw0KPiAgIGJvb2wgbWlncmF0ZV9wb3N0Y29weSh2b2lk
KTsNCj4gK2Jvb2wgbWlncmF0ZV9yZG1hKHZvaWQpOw0KPiAgIGJvb2wgbWlncmF0ZV90bHModm9p
ZCk7DQo+ICAgDQo+ICAgLyogY2FwYWJpbGl0aWVzIGhlbHBlcnMgKi8NCj4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9taWdyYXRpb24uYyBiL21pZ3JhdGlvbi9taWdyYXRpb24uYw0KPiBpbmRleCAx
YzZjODFhZDQ5Li40MjEzYzY0NWM2IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vbWlncmF0aW9u
LmMNCj4gKysrIGIvbWlncmF0aW9uL21pZ3JhdGlvbi5jDQo+IEBAIC0xNDUxLDYgKzE0NTEsNyBA
QCBpbnQgbWlncmF0ZV9pbml0KE1pZ3JhdGlvblN0YXRlICpzLCBFcnJvciAqKmVycnApDQo+ICAg
ICAgIHMtPml0ZXJhdGlvbl9pbml0aWFsX2J5dGVzID0gMDsNCj4gICAgICAgcy0+dGhyZXNob2xk
X3NpemUgPSAwOw0KPiAgICAgICBzLT5zd2l0Y2hvdmVyX2Fja2VkID0gZmFsc2U7DQo+ICsgICAg
cy0+cmRtYV9taWdyYXRpb24gPSBmYWxzZTsNCj4gICAgICAgLyoNCj4gICAgICAgICogc2V0IG1p
Z19zdGF0cyBjb21wcmVzc2lvbl9jb3VudGVycyBtZW1vcnkgdG8gemVybyBmb3IgYQ0KPiAgICAg
ICAgKiBuZXcgbWlncmF0aW9uDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vb3B0aW9ucy5jIGIv
bWlncmF0aW9uL29wdGlvbnMuYw0KPiBpbmRleCA2YmJmZDQ4NTNkLi5kYTM3OWU3ZjdhIDEwMDY0
NA0KPiAtLS0gYS9taWdyYXRpb24vb3B0aW9ucy5jDQo+ICsrKyBiL21pZ3JhdGlvbi9vcHRpb25z
LmMNCj4gQEAgLTM3Niw2ICszNzYsMTMgQEAgYm9vbCBtaWdyYXRlX3Bvc3Rjb3B5KHZvaWQpDQo+
ICAgICAgIHJldHVybiBtaWdyYXRlX3Bvc3Rjb3B5X3JhbSgpIHx8IG1pZ3JhdGVfZGlydHlfYml0
bWFwcygpOw0KPiAgIH0NCj4gICANCj4gK2Jvb2wgbWlncmF0ZV9yZG1hKHZvaWQpDQo+ICt7DQo+
ICsgICAgTWlncmF0aW9uU3RhdGUgKnMgPSBtaWdyYXRlX2dldF9jdXJyZW50KCk7DQo+ICsNCj4g
KyAgICByZXR1cm4gcy0+cmRtYV9taWdyYXRpb247DQo+ICt9DQo+ICsNCj4gICBib29sIG1pZ3Jh
dGVfdGxzKHZvaWQpDQo+ICAgew0KPiAgICAgICBNaWdyYXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVf
Z2V0X2N1cnJlbnQoKTsNCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRp
b24vcmRtYS5jDQo+IGluZGV4IGY2ZmMyMjZjOWIuLmYxNTVmM2UxYzggMTAwNjQ0DQo+IC0tLSBh
L21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBAQCAtNDExMyw2
ICs0MTEzLDcgQEAgc3RhdGljIHZvaWQgcmRtYV9hY2NlcHRfaW5jb21pbmdfbWlncmF0aW9uKHZv
aWQgKm9wYXF1ZSkNCj4gICANCj4gICB2b2lkIHJkbWFfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9u
KGNvbnN0IGNoYXIgKmhvc3RfcG9ydCwgRXJyb3IgKiplcnJwKQ0KPiAgIHsNCj4gKyAgICBNaWdy
YXRpb25TdGF0ZSAqcyA9IG1pZ3JhdGVfZ2V0X2N1cnJlbnQoKTsNCj4gICAgICAgaW50IHJldDsN
Cj4gICAgICAgUkRNQUNvbnRleHQgKnJkbWE7DQo+ICAgDQo+IEBAIC00MTQ0LDcgKzQxNDUsNyBA
QCB2b2lkIHJkbWFfc3RhcnRfaW5jb21pbmdfbWlncmF0aW9uKGNvbnN0IGNoYXIgKmhvc3RfcG9y
dCwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICB9DQo+ICAgDQo+ICAgICAgIHRyYWNlX3JkbWFfc3Rh
cnRfaW5jb21pbmdfbWlncmF0aW9uX2FmdGVyX3JkbWFfbGlzdGVuKCk7DQo+IC0NCj4gKyAgICBz
LT5yZG1hX21pZ3JhdGlvbiA9IHRydWU7DQo+ICAgICAgIHFlbXVfc2V0X2ZkX2hhbmRsZXIocmRt
YS0+Y2hhbm5lbC0+ZmQsIHJkbWFfYWNjZXB0X2luY29taW5nX21pZ3JhdGlvbiwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBOVUxMLCAodm9pZCAqKShpbnRwdHJfdClyZG1hKTsNCj4gICAg
ICAgcmV0dXJuOw0KPiBAQCAtNDIyMCw2ICs0MjIxLDcgQEAgdm9pZCByZG1hX3N0YXJ0X291dGdv
aW5nX21pZ3JhdGlvbih2b2lkICpvcGFxdWUsDQo+ICAgICAgIHRyYWNlX3JkbWFfc3RhcnRfb3V0
Z29pbmdfbWlncmF0aW9uX2FmdGVyX3JkbWFfY29ubmVjdCgpOw0KPiAgIA0KPiAgICAgICBzLT50
b19kc3RfZmlsZSA9IHJkbWFfbmV3X291dHB1dChyZG1hKTsNCj4gKyAgICBzLT5yZG1hX21pZ3Jh
dGlvbiA9IHRydWU7DQo+ICAgICAgIG1pZ3JhdGVfZmRfY29ubmVjdChzLCBOVUxMKTsNCj4gICAg
ICAgcmV0dXJuOw0KPiAgIHJldHVybl9wYXRoX2Vycjo=

