Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD997C8013
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:24:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD81-0007IC-OM; Fri, 13 Oct 2023 04:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD7k-00071E-Mv
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:02:20 -0400
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qrD7f-0008Km-S3
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1697184136; x=1728720136;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=OS/WMZttRfVv119pM8zPw7EDNJU0b6TtJAaxwh18BYg=;
 b=by5IDMdn439qze2bLCTvTI2xoA3qJ5K54SbIswvWgbSXAVlYs1M39Krm
 FXaXKWPNcaJ0ZIEnxvUCqqQ9a0HyLvRISezLiYDQuHPfzK9BsSKKwK6bn
 Ar6vf3oatvgnnBUM6nKdju1F2BGDux0/agfMFhR1OmSeelLks7ZdFTuPH
 2k6IzTsKYJkteF8tr3HFP/2e5/WZHaPZw8rbNIzgps0n2aCjcUMGbNBh5
 I72IXMXrav/PBI9u3GpdYScrf9K1QJM1ZgN5LowUyyWoX4P0JNKMjbK9x
 FSjyCYG9R5a1Q6/LVqY3jF75Ey7M7hNpWDeMhdw8WZLtyRse1oRos2nRm A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="99237248"
X-IronPort-AV: E=Sophos;i="6.03,221,1694703600"; d="scan'208";a="99237248"
Received: from mail-os0jpn01lp2104.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.104])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2023 17:02:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AmXlffS7Jke6ILYMhY5j230AfRrn+MGlv3OKZjbWjlVBuON98mxDXJlLslTJWe3vxzW8eKoCRzgQ+5haQNXVsRl0eYCO9VaFUktEHts8syo8cRFlxg/YgrEhioj8C+WI3/tk6yT+ZqkXDGjxflUgoTZI2AZ5QcZWQqmRxfPtSnWoQkS6Vdjdy1Fmbt6+CeijBwj80IO2b2FWlJt2O0qrLx3cHxnTrtC2sUlBCeIVLRrmYiO3yUX6dw89k65HQgVZ7IDzKjejxWoXRZvUIvpV66rfgoB1DQYW8F8v7BrbeFs/trR0iD7gItT9Frt/s7zUBG0rYpQo1+0bXgsoNVCznw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OS/WMZttRfVv119pM8zPw7EDNJU0b6TtJAaxwh18BYg=;
 b=TaWV++5RsbYI7dz3lzZHwsGTPhEJcVEaxFfyuwc/1Y4MzD7eD9Si1Ws4Lhq1sJWSnGtYdgg6oqHbz6hcYzm1Oti0aPFuq2ofsJiym7FmSpYZ2dCUAImnFp7wHhi19DXc6BMwegmgEEdxSNM4QA4R/x26xyktor9UjD2sc+6KSFQG90SwyYwve03X8o7+erv/QAUdJnQdpm/gv6O2R/RjKBE/EhpQCY9FituSgJKmB+f9bEHrPUIRUZaaofkglZa6oVtZPPf6xUsk0CDeB8q84WHl26RZeswWwZRflKIS+JWReQdQuxQj18TwZFx8c5OSYv4RA5Y22WpF/9jqbeUSwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by TYTPR01MB11035.jpnprd01.prod.outlook.com (2603:1096:400:3a1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 08:02:08 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 08:02:08 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Juan Quintela <quintela@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 05/13] migration/rdma: Unfold hook_ram_load()
Thread-Topic: [PATCH v3 05/13] migration/rdma: Unfold hook_ram_load()
Thread-Index: AQHZ/IKC89GwlJF4G0KBG8GKgi04frBHXhmA
Date: Fri, 13 Oct 2023 08:02:08 +0000
Message-ID: <49086bfb-7506-95fa-29b4-81ddd2752a0a@fujitsu.com>
References: <20231011203527.9061-1-quintela@redhat.com>
 <20231011203527.9061-6-quintela@redhat.com>
In-Reply-To: <20231011203527.9061-6-quintela@redhat.com>
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
x-ms-office365-filtering-correlation-id: 20f04c9c-2a6e-487d-f9dc-08dbcbc2b2d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VY0IVXTr6delDXl6ChsJBn9r8El4SK92OSaIaT885bk8pRcW3yagRxmgXvCM8cRYC4l504of93whd52yLVqrIixMMDPy+zNQZnmelSXcWFZwuEIGEpjACH8W1Nn5uW79555v3NiApLlDQLJRsBUH87phmQ1742QViPdprYrMDGplcAe9ULCx5iOv9vR/WwlWa0VrV0PqnJUVwbzYaUCoC609V2J8C9VMzP3vrRdFeBeXNRVZ3K5oosaS4+5GwaD/wMw4DqNswnDugqyujY0XqE7cpqtKJeJZT59Y35wQRUnSOpWZQcFu/rYF4+QcPlFGxXwDa2kWAvxw6GvFO8FSz4ETz8HkqpWK9fkfM9OVDkliYYj75lGzWXDommFz5C3h5RIxW76HnqMVibm+Aw4scSHs5x3ExgfTnxpAiFsbJkfZN9mkNhGV1sI44jmQAr0qUIRn/qvmahz+Ucht0JABLHxDTs9QzWCx7vcCzzT+NcQte7sAzRZqtles5Lw436NdT18TdqmJx0/FvAz6Q6IDFKuWkZBaKXlZXlRLIS6B1WWO7+TAYsQzl5uo2fkl7KVSrqCj9Xup7phVv+lZytoqMhArxLN4E0o5L+Zot+BE9wBlzuXXYFVQobzJ6esHsofzXXZkj3R2h79MLXFpXohkzL6Vdi6ndy+LSo/7eojc/6D3+wDDZcR6u2UemUl3fAUx9BrzVk2Q4HoVvRsDIOEIgw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(1590799021)(451199024)(1800799009)(186009)(6486002)(41300700001)(110136005)(316002)(91956017)(66946007)(54906003)(66446008)(64756008)(66476007)(66556008)(76116006)(8936002)(478600001)(4326008)(8676002)(6512007)(31686004)(1580799018)(53546011)(6506007)(5660300002)(38100700002)(122000001)(86362001)(38070700005)(31696002)(82960400001)(2906002)(2616005)(26005)(85182001)(83380400001)(36756003)(71200400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHdheE5GQzhQdElkTTYyVXhFcFczbFJGR0ZMWG93YTlmOEU0ZWJsdVRUeU5h?=
 =?utf-8?B?UXVZTVhzbVdUNXcvUTAzZ2ZmNzMrWkFPNHlwZ0FCL0JTMEw4akRXbFAvdzNR?=
 =?utf-8?B?Y09uamNSb1FWS0ZOaTNjWGF3WnlrNk9NVFVxTCs3MlpSdWFuamdGc0hlVVhZ?=
 =?utf-8?B?QTE1ZkJHTi9MTnlwd05OcklKZlFXSFY0OS9CTWtNazFraEZKQnpRTy9NZDlE?=
 =?utf-8?B?M3pIdkIrbk5EemQvNzJLOTc0S1dGbDRjZDNGdm1nNk1VbXQ2UW5QbTNhd0s1?=
 =?utf-8?B?ZEdCcjRzYVRvZEwvSUkvaW5WdEZKaUt3bTZpd1JVaHlXdyt2MEhubmpiUXhy?=
 =?utf-8?B?Y0pOaTFkSDVBVmFoVWkwdjJ2cVdQYnpydlB4UjZMc0YvRnJ3Y3RQM1E2TDNs?=
 =?utf-8?B?bTdHQlkzd0N1UlFrakIyQmZwUUlvelNSV3RicE5kOXVwVlVDSlRYMVkrcXZZ?=
 =?utf-8?B?dkIzNXdGZ1c4dUlJS3ZUaUJTU29UTm1iRzNhUkRjdkJiYWY2Tld1d0wwT2Vq?=
 =?utf-8?B?WEhjY3F0cExpZ0YvelUxWXhQdlYvdzNBQ2xwQ285ZmZ6OURhTkpZbEtWbmxL?=
 =?utf-8?B?WUNORTVBQlI2ZllodmZBRkhPWUdBQ0lRdEdtUU9uSEo4bnNqMnJZVTl5UDdL?=
 =?utf-8?B?QmZ1Uk1jQzhYOC9wZkZKSDRHaXpQRi9iTkRGdFphMjBFQTcxU3J6WHNNM3V5?=
 =?utf-8?B?LzRYbmNJaTNDZHhWQ3hnQXNIekNoekdmVUs2UUFUeURaNVZjNHZzWGxrc3Ix?=
 =?utf-8?B?aGg5NGVVVE9XUllaNHdoenErUk4rQk5hOXFvOTVjQnJtZFBvcm5na0FyYmMw?=
 =?utf-8?B?OHdpZUM2K1QvT1hQUExwQ3NBdU9qbm15UWMybjlkUWZhV210bHVlVDAyOXc0?=
 =?utf-8?B?dGlVd2x3ZjBNNVA5dW1FM1F3T0U0VmtOTStNZ292K28zVkNRcmNqbnQzVWRH?=
 =?utf-8?B?cFlJc3JiSGsraEVycWJIUFU1QVZPRnNXS29tUXJINVIzZ0F3R0dsTEV5UUJU?=
 =?utf-8?B?NktFSS9GQjJwYXJJY3B3Kzc3RWcrelVpUjc0ZUMrSnFGcFc3WVpNelF1ZjdE?=
 =?utf-8?B?UzhwMXhZQ1dhaVRveTJRY1U5SFRreDc3cGlLZWJxZ3kxOW11czdGc2E3OEl0?=
 =?utf-8?B?UGRocVBlU0FxaGh2WHdUMnU2MEU5cWFKTU9JR1FXQ0ZqeHRjUU5nUTRSbkIx?=
 =?utf-8?B?M0UreXkrczBDb2NkSWYwalFRVUEyZEdTeFRjd2FZQlV3Y3NOWHNLdDh3UzlV?=
 =?utf-8?B?d2RvRDFKN3EzUm9VYjFUamdiTTM0M1o2UCtqOHlJZk9VdVUyNm1ZZEtVUnZq?=
 =?utf-8?B?S3hjSVloMEtlSWZxRTZIYXF4bHZoSWZCczdWeWoxRCtsVVloWXpWYStDWlcx?=
 =?utf-8?B?dTdDK2Y2Q0hKMzhuckcxQyt3d2F5bkI1c04rTXVCdVFYSklXY2VJVlNmUnF6?=
 =?utf-8?B?ZU5ZMGNaSDNZNERDWEVHM2xQVCt1ajNkWndVZ29LellRMEtzK1RxWmZnTzJG?=
 =?utf-8?B?WHdJWUl2KzBJTU9ZNGZtMUExMm85S0tyZVZSMTVLbzFwVDlCczBMVms0TklR?=
 =?utf-8?B?MTU2cUs3N2tDN0s4OThqV2hMbEs0VloxRi9pQjRFNUtFTWgzd3RiZkVLT1BZ?=
 =?utf-8?B?ODFXUG9Rc0VkdDZ0REFjZ243UlBZMUI5T1F0bVhaUm5hd1o1eXp5U3Joc0J5?=
 =?utf-8?B?MU9XZVRmdi9QMkdzcm1YY2NPWkJLOXpUc29DRXk1c3lhTkFvQjhWTy96Rkp5?=
 =?utf-8?B?MElrSTVSd3ZCekpnVnJpQU9EY0ErTTBueTc1VzhKOEIrQWV3Mms0L2N3RTVZ?=
 =?utf-8?B?ayszSndtL0ZRcThGUUR3b0szOGo3WmlyLzVoRElVWE1sVFRXL0d1OFBrUC8r?=
 =?utf-8?B?dVN5R1VOOXpJZnUzakhwWFNsNTZLYWcwWEFzdGsyUkpVMkNlQkg2M25qRnRJ?=
 =?utf-8?B?MVN3bEppWTUrZkZSdGJ0c1lKd1ZYL2lSOTdULzB3Q1BhbDQ4Q0ltYi9pZnpK?=
 =?utf-8?B?WTdBVEJGYzdyaDVlQzNSMkNQMm1BeWF6QWFYNEZqQkF6WXhCTWRpRjRSRkNW?=
 =?utf-8?B?TDRpMVNpbXZXSHkrOVBYM3NZNksxZzZ6TldKZisySXVqNlJoSzZjbHVFUC9a?=
 =?utf-8?B?WFFFWUVZVzRFcG5DT1pPUEVxdmhPY1ZGUjRoWW5maHRlb1FpSmwvSU9tbmVK?=
 =?utf-8?B?YVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4879226DE0424FB8B7F4CF374AA3BE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4M993pOYmGKALVXn5XgGLIBOk7OPYyFcULcb04YjWQIZr3kod7GHa0A7S2Ou9tEp7ShIdzbRPppIGCsqDOMZ8Aks2boJtsv4fgLMatjWPsaSqQScaELY95Nhs1vGWRY5/1+B03KIS/dLYtvhOUTG1IfQgHi4tQTgZGlcDLrJg+81uYddnE4jZ/wkwpLHPZha5wA5Q40rqRqzmvtzc4T6ESPlu5MRiS/Syqvo8TnPRikjNldsgBQ8EM7Fc/fq9ZrfRrw8llQnzaCR3NNnB+0XKes2xQqL8oJXLjT8s9UGJceTykJmfcEKb9U60/zuwGbOM/9vY9XjbP7aqv51HFVVlgfVplnl0wXQgADzcXFKuZDVPjE1CR97gH5wRJvTDWQWsRvhLNT3Tm3lI2+Me5tH47b0sqvzU5oU6hGoPgeMJU0fXlLnsn1LukpVhz4eb/yOFnOl0GostDjXIVzep6V5QrIqRbWqKkelDoxAXtoxE7PP7HkhRl56JQhSKFcvyc/q+4kUWocyX6q/ykZ1QoKXvNX9L/3tE5VUwuEE4xJ7Hi+5UUp+KHD3O+xEzgRogw7SEnfQDhZXvdQWwsRby+G85ERaqbq7CBa3CbLCcFpqiXYXRx05axCO0muCOAVHgJXOuuzY2nPwb0nqdVZnu8jYqIlqtOFElm/6DmuInNhCl9qjDdX+qUa8CT37Z4tyR490hV+6R447Q8qhH4I2SCmSTUPKehztGuyS2J6oTXBD1k9cxBrgHfAR2bCx1K8OZVsKZaAw94+2RYFe2mLbS0Y4nR7YyMyxgQHcr7uN07jjCVYfZsu+9BoaF211KnEUItwQ
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f04c9c-2a6e-487d-f9dc-08dbcbc2b2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2023 08:02:08.7307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5UwaRrbnfsNK96M9rpRm/O0Q8Bjbz5pExNPpyEDtkEOj/KzBkqB7Hn6mf33qwKepl8e8nHZ/xuI085b2zrJXSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11035
Received-SPF: pass client-ip=216.71.156.125;
 envelope-from=lizhijian@fujitsu.com; helo=esa12.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDEyLzEwLzIwMjMgMDQ6MzUsIEp1YW4gUXVpbnRlbGEgd3JvdGU6DQo+IFRoZXJlIGlz
IG9ubHkgb25lIGZsYWcgY2FsbGVkIHdpdGg6IFJBTV9DT05UUk9MX0JMT0NLX1JFRy4NCj4gDQo+
IFJldmlld2VkLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+IFNpZ25lZC1vZmYt
Ynk6IEp1YW4gUXVpbnRlbGEgPHF1aW50ZWxhQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBM
aSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCj4gLS0tDQo+ICAgbWlncmF0aW9u
L3FlbXUtZmlsZS5oIHwgMTEgLS0tLS0tLS0tLS0NCj4gICBtaWdyYXRpb24vcmRtYS5oICAgICAg
fCAgMyArKysNCj4gICBtaWdyYXRpb24vcWVtdS1maWxlLmMgfCAxMCAtLS0tLS0tLS0tDQo+ICAg
bWlncmF0aW9uL3JhbS5jICAgICAgIHwgIDYgKysrKy0tDQo+ICAgbWlncmF0aW9uL3JkbWEuYyAg
ICAgIHwgMzQgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDUgZmlsZXMg
Y2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgNDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWlncmF0aW9uL3FlbXUtZmlsZS5oIGIvbWlncmF0aW9uL3FlbXUtZmlsZS5oDQo+IGlu
ZGV4IDE0ZmYwZDljYzQuLjgwYzMwNjMxZGMgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9xZW11
LWZpbGUuaA0KPiArKysgYi9taWdyYXRpb24vcWVtdS1maWxlLmgNCj4gQEAgLTI5LDIwICsyOSwx
MiBAQA0KPiAgICNpbmNsdWRlICJleGVjL2NwdS1jb21tb24uaCINCj4gICAjaW5jbHVkZSAiaW8v
Y2hhbm5lbC5oIg0KPiAgIA0KPiAtLyoNCj4gLSAqIFRoaXMgZnVuY3Rpb24gcHJvdmlkZXMgaG9v
a3MgYXJvdW5kIGRpZmZlcmVudA0KPiAtICogc3RhZ2VzIG9mIFJBTSBtaWdyYXRpb24uDQo+IC0g
KiAnZGF0YScgaXMgY2FsbCBzcGVjaWZpYyBkYXRhIGFzc29jaWF0ZWQgd2l0aCB0aGUgJ2ZsYWdz
JyB2YWx1ZQ0KPiAtICovDQo+IC10eXBlZGVmIGludCAoUUVNVVJhbUhvb2tGdW5jKShRRU1VRmls
ZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRhdGEpOw0KPiAtDQo+ICAgLyoNCj4gICAgKiBD
b25zdGFudHMgdXNlZCBieSByYW1fY29udHJvbF8qIGhvb2tzDQo+ICAgICovDQo+ICAgI2RlZmlu
ZSBSQU1fQ09OVFJPTF9TRVRVUCAgICAgMA0KPiAgICNkZWZpbmUgUkFNX0NPTlRST0xfUk9VTkQg
ICAgIDENCj4gICAjZGVmaW5lIFJBTV9DT05UUk9MX0ZJTklTSCAgICAzDQo+IC0jZGVmaW5lIFJB
TV9DT05UUk9MX0JMT0NLX1JFRyA0DQo+ICAgDQo+ICAgLyoNCj4gICAgKiBUaGlzIGZ1bmN0aW9u
IGFsbG93cyBvdmVycmlkZSBvZiB3aGVyZSB0aGUgUkFNIHBhZ2UNCj4gQEAgLTU0LDcgKzQ2LDYg
QEAgdHlwZWRlZiBpbnQgKFFFTVVSYW1TYXZlRnVuYykoUUVNVUZpbGUgKmYsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IHNpemUpOw0KPiAgIA0KPiAgIHR5cGVkZWYg
c3RydWN0IFFFTVVGaWxlSG9va3Mgew0KPiAtICAgIFFFTVVSYW1Ib29rRnVuYyAqaG9va19yYW1f
bG9hZDsNCj4gICAgICAgUUVNVVJhbVNhdmVGdW5jICpzYXZlX3BhZ2U7DQo+ICAgfSBRRU1VRmls
ZUhvb2tzOw0KPiAgIA0KPiBAQCAtMTI0LDggKzExNSw2IEBAIHZvaWQgcWVtdV9mZmx1c2goUUVN
VUZpbGUgKmYpOw0KPiAgIHZvaWQgcWVtdV9maWxlX3NldF9ibG9ja2luZyhRRU1VRmlsZSAqZiwg
Ym9vbCBibG9jayk7DQo+ICAgaW50IHFlbXVfZmlsZV9nZXRfdG9fZmQoUUVNVUZpbGUgKmYsIGlu
dCBmZCwgc2l6ZV90IHNpemUpOw0KPiAgIA0KPiAtdm9pZCByYW1fY29udHJvbF9sb2FkX2hvb2so
UUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzLCB2b2lkICpkYXRhKTsNCj4gLQ0KPiAgIC8qIFdo
ZW5ldmVyIHRoaXMgaXMgZm91bmQgaW4gdGhlIGRhdGEgc3RyZWFtLCB0aGUgZmxhZ3MNCj4gICAg
KiB3aWxsIGJlIHBhc3NlZCB0byByYW1fY29udHJvbF9sb2FkX2hvb2sgaW4gdGhlIGluY29taW5n
LW1pZ3JhdGlvbg0KPiAgICAqIHNpZGUuIFRoaXMgbGV0cyBiZWZvcmVfcmFtX2l0ZXJhdGUvYWZ0
ZXJfcmFtX2l0ZXJhdGUgYWRkDQo+IGRpZmYgLS1naXQgYS9taWdyYXRpb24vcmRtYS5oIGIvbWln
cmF0aW9uL3JkbWEuaA0KPiBpbmRleCA4YmQyNzdlZmI5Li44ZGY4YjQwODlhIDEwMDY0NA0KPiAt
LS0gYS9taWdyYXRpb24vcmRtYS5oDQo+ICsrKyBiL21pZ3JhdGlvbi9yZG1hLmgNCj4gQEAgLTI3
LDYgKzI3LDcgQEAgdm9pZCByZG1hX3N0YXJ0X2luY29taW5nX21pZ3JhdGlvbihjb25zdCBjaGFy
ICpob3N0X3BvcnQsIEVycm9yICoqZXJycCk7DQo+ICAgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRp
b25faGFuZGxlKFFFTVVGaWxlICpmKTsNCj4gICBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9z
dGFydChRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MpOw0KPiAgIGludCBxZW11X3JkbWFfcmVn
aXN0cmF0aW9uX3N0b3AoUUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKTsNCj4gK2ludCByZG1h
X2Jsb2NrX25vdGlmaWNhdGlvbl9oYW5kbGUoUUVNVUZpbGUgKmYsIGNvbnN0IGNoYXIgKm5hbWUp
Ow0KPiAgICNlbHNlDQo+ICAgc3RhdGljIGlubGluZQ0KPiAgIGludCBxZW11X3JkbWFfcmVnaXN0
cmF0aW9uX2hhbmRsZShRRU1VRmlsZSAqZikgeyByZXR1cm4gMDsgfQ0KPiBAQCAtMzQsNSArMzUs
NyBAQCBzdGF0aWMgaW5saW5lDQo+ICAgaW50IHFlbXVfcmRtYV9yZWdpc3RyYXRpb25fc3RhcnQo
UUVNVUZpbGUgKmYsIHVpbnQ2NF90IGZsYWdzKSB7IHJldHVybiAwOyB9DQo+ICAgc3RhdGljIGlu
bGluZQ0KPiAgIGludCBxZW11X3JkbWFfcmVnaXN0cmF0aW9uX3N0b3AoUUVNVUZpbGUgKmYsIHVp
bnQ2NF90IGZsYWdzKSB7IHJldHVybiAwOyB9DQo+ICtzdGF0aWMgaW5saW5lDQo+ICtpbnQgcmRt
YV9ibG9ja19ub3RpZmljYXRpb25faGFuZGxlKFFFTVVGaWxlICpmLCBjb25zdCBjaGFyICpuYW1l
KSB7IHJldHVybiAwOyB9DQo+ICAgI2VuZGlmDQo+ICAgI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9t
aWdyYXRpb24vcWVtdS1maWxlLmMgYi9taWdyYXRpb24vcWVtdS1maWxlLmMNCj4gaW5kZXggZTdk
YmEyYTg0OS4uNGE0MTRiODk3NiAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9uL3FlbXUtZmlsZS5j
DQo+ICsrKyBiL21pZ3JhdGlvbi9xZW11LWZpbGUuYw0KPiBAQCAtMjk4LDE2ICsyOTgsNiBAQCB2
b2lkIHFlbXVfZmZsdXNoKFFFTVVGaWxlICpmKQ0KPiAgICAgICBmLT5pb3ZjbnQgPSAwOw0KPiAg
IH0NCj4gICANCj4gLXZvaWQgcmFtX2NvbnRyb2xfbG9hZF9ob29rKFFFTVVGaWxlICpmLCB1aW50
NjRfdCBmbGFncywgdm9pZCAqZGF0YSkNCj4gLXsNCj4gLSAgICBpZiAoZi0+aG9va3MgJiYgZi0+
aG9va3MtPmhvb2tfcmFtX2xvYWQpIHsNCj4gLSAgICAgICAgaW50IHJldCA9IGYtPmhvb2tzLT5o
b29rX3JhbV9sb2FkKGYsIGZsYWdzLCBkYXRhKTsNCj4gLSAgICAgICAgaWYgKHJldCA8IDApIHsN
Cj4gLSAgICAgICAgICAgIHFlbXVfZmlsZV9zZXRfZXJyb3IoZiwgcmV0KTsNCj4gLSAgICAgICAg
fQ0KPiAtICAgIH0NCj4gLX0NCj4gLQ0KPiAgIGludCByYW1fY29udHJvbF9zYXZlX3BhZ2UoUUVN
VUZpbGUgKmYsIHJhbV9hZGRyX3QgYmxvY2tfb2Zmc2V0LA0KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgcmFtX2FkZHJfdCBvZmZzZXQsIHNpemVfdCBzaXplKQ0KPiAgIHsNCj4gZGlmZiAt
LWdpdCBhL21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYw0KPiBpbmRleCBlZThiZGNk
YzgyLi5kNmE5ZjkwYjk0IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4gKysrIGIv
bWlncmF0aW9uL3JhbS5jDQo+IEBAIC00MDIzLDggKzQwMjMsMTAgQEAgc3RhdGljIGludCByYW1f
bG9hZF9wcmVjb3B5KFFFTVVGaWxlICpmKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSAtRUlOVkFMOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAg
ICAgICAgICAgICAgICAgIH0NCj4gLSAgICAgICAgICAgICAgICAgICAgcmFtX2NvbnRyb2xfbG9h
ZF9ob29rKGYsIFJBTV9DT05UUk9MX0JMT0NLX1JFRywNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJsb2NrLT5pZHN0cik7DQo+ICsgICAgICAgICAgICAgICAg
ICAgIHJldCA9IHJkbWFfYmxvY2tfbm90aWZpY2F0aW9uX2hhbmRsZShmLCBibG9jay0+aWRzdHIp
Ow0KPiArICAgICAgICAgICAgICAgICAgICBpZiAocmV0IDwgMCkgew0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgcWVtdV9maWxlX3NldF9lcnJvcihmLCByZXQpOw0KPiArICAgICAgICAgICAg
ICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICAgICAgICAgICAgICAg
ICAgICAgICBlcnJvcl9yZXBvcnQoIlVua25vd24gcmFtYmxvY2sgXCIlc1wiLCBjYW5ub3QgIg0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJhY2NlcHQgbWlncmF0aW9uIiwg
aWQpOw0KPiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3JkbWEuYyBiL21pZ3JhdGlvbi9yZG1hLmMN
Cj4gaW5kZXggZTUzMzgxNDU5OS4uNmJjYTllOGYxOSAxMDA2NDQNCj4gLS0tIGEvbWlncmF0aW9u
L3JkbWEuYw0KPiArKysgYi9taWdyYXRpb24vcmRtYS5jDQo+IEBAIC0zNzk5LDIyICszNzk5LDIz
IEBAIGVycjoNCj4gICB9DQo+ICAgDQo+ICAgLyogRGVzdGluYXRpb246DQo+IC0gKiBDYWxsZWQg
dmlhIGEgcmFtX2NvbnRyb2xfbG9hZF9ob29rIGR1cmluZyB0aGUgaW5pdGlhbCBSQU0gbG9hZCBz
ZWN0aW9uIHdoaWNoDQo+IC0gKiBsaXN0cyB0aGUgUkFNQmxvY2tzIGJ5IG5hbWUuICBUaGlzIGxl
dHMgdXMga25vdyB0aGUgb3JkZXIgb2YgdGhlIFJBTUJsb2Nrcw0KPiAtICogb24gdGhlIHNvdXJj
ZS4NCj4gLSAqIFdlJ3ZlIGFscmVhZHkgYnVpbHQgb3VyIGxvY2FsIFJBTUJsb2NrIGxpc3QsIGJ1
dCBub3QgeWV0IHNlbnQgdGhlIGxpc3QgdG8NCj4gLSAqIHRoZSBzb3VyY2UuDQo+ICsgKiBDYWxs
ZWQgZHVyaW5nIHRoZSBpbml0aWFsIFJBTSBsb2FkIHNlY3Rpb24gd2hpY2ggbGlzdHMgdGhlDQo+
ICsgKiBSQU1CbG9ja3MgYnkgbmFtZS4gIFRoaXMgbGV0cyB1cyBrbm93IHRoZSBvcmRlciBvZiB0
aGUgUkFNQmxvY2tzIG9uDQo+ICsgKiB0aGUgc291cmNlLiAgV2UndmUgYWxyZWFkeSBidWlsdCBv
dXIgbG9jYWwgUkFNQmxvY2sgbGlzdCwgYnV0IG5vdA0KPiArICogeWV0IHNlbnQgdGhlIGxpc3Qg
dG8gdGhlIHNvdXJjZS4NCj4gICAgKi8NCj4gLXN0YXRpYyBpbnQNCj4gLXJkbWFfYmxvY2tfbm90
aWZpY2F0aW9uX2hhbmRsZShRRU1VRmlsZSAqZiwgY29uc3QgY2hhciAqbmFtZSkNCj4gK2ludCBy
ZG1hX2Jsb2NrX25vdGlmaWNhdGlvbl9oYW5kbGUoUUVNVUZpbGUgKmYsIGNvbnN0IGNoYXIgKm5h
bWUpDQo+ICAgew0KPiAtICAgIFJETUFDb250ZXh0ICpyZG1hOw0KPiAtICAgIFFJT0NoYW5uZWxS
RE1BICpyaW9jID0gUUlPX0NIQU5ORUxfUkRNQShxZW11X2ZpbGVfZ2V0X2lvYyhmKSk7DQo+ICAg
ICAgIGludCBjdXJyOw0KPiAgICAgICBpbnQgZm91bmQgPSAtMTsNCj4gICANCj4gKyAgICBpZiAo
IW1pZ3JhdGVfcmRtYSgpKSB7DQo+ICsgICAgICAgIHJldHVybiAwOw0KPiArICAgIH0NCj4gKw0K
PiAgICAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7DQo+IC0gICAgcmRtYSA9IHFhdG9taWNfcmN1
X3JlYWQoJnJpb2MtPnJkbWFpbik7DQo+ICsgICAgUUlPQ2hhbm5lbFJETUEgKnJpb2MgPSBRSU9f
Q0hBTk5FTF9SRE1BKHFlbXVfZmlsZV9nZXRfaW9jKGYpKTsNCj4gKyAgICBSRE1BQ29udGV4dCAq
cmRtYSA9IHFhdG9taWNfcmN1X3JlYWQoJnJpb2MtPnJkbWFpbik7DQo+ICAgDQo+ICAgICAgIGlm
ICghcmRtYSkgew0KPiAgICAgICAgICAgcmV0dXJuIC0xOw0KPiBAQCAtMzg0MCwxOCArMzg0MSw2
IEBAIHJkbWFfYmxvY2tfbm90aWZpY2F0aW9uX2hhbmRsZShRRU1VRmlsZSAqZiwgY29uc3QgY2hh
ciAqbmFtZSkNCj4gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGludCBy
ZG1hX2xvYWRfaG9vayhRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MsIHZvaWQgKmRhdGEpDQo+
IC17DQo+IC0gICAgc3dpdGNoIChmbGFncykgew0KPiAtICAgIGNhc2UgUkFNX0NPTlRST0xfQkxP
Q0tfUkVHOg0KPiAtICAgICAgICByZXR1cm4gcmRtYV9ibG9ja19ub3RpZmljYXRpb25faGFuZGxl
KGYsIGRhdGEpOw0KPiAtDQo+IC0gICAgZGVmYXVsdDoNCj4gLSAgICAgICAgLyogU2hvdWxkbid0
IGJlIGNhbGxlZCB3aXRoIGFueSBvdGhlciB2YWx1ZXMgKi8NCj4gLSAgICAgICAgYWJvcnQoKTsN
Cj4gLSAgICB9DQo+IC19DQo+IC0NCj4gICBpbnQgcWVtdV9yZG1hX3JlZ2lzdHJhdGlvbl9zdGFy
dChRRU1VRmlsZSAqZiwgdWludDY0X3QgZmxhZ3MpDQo+ICAgew0KPiAgICAgICBpZiAoIW1pZ3Jh
dGVfcmRtYSAoKSB8fCBtaWdyYXRpb25faW5fcG9zdGNvcHkoKSkgew0KPiBAQCAtMzk5Nyw3ICsz
OTg2LDYgQEAgZXJyOg0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgY29uc3QgUUVNVUZpbGVIb29r
cyByZG1hX3JlYWRfaG9va3MgPSB7DQo+IC0gICAgLmhvb2tfcmFtX2xvYWQgPSByZG1hX2xvYWRf
aG9vaywNCj4gICB9Ow0KPiAgIA0KPiAgIHN0YXRpYyBjb25zdCBRRU1VRmlsZUhvb2tzIHJkbWFf
d3JpdGVfaG9va3MgPSB7

