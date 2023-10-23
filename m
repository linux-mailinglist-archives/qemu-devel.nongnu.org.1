Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 938AA7D2C87
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 10:22:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quqBM-0002X6-Hc; Mon, 23 Oct 2023 04:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1quqBI-0002WW-Sg
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:21:00 -0400
Received: from esa11.fujitsucc.c3s2.iphmx.com ([216.71.156.121])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1quqBG-0000Zb-LF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 04:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1698049258; x=1729585258;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=t1vE6CaJhuOZQXJgdMGVexEYCkxVtGu8DnPoRZHT3e8=;
 b=HaIsihYnAIvnfpPzso4LJLC83KDAbW+9KMa2jqO98YOU2dtgMjyqg8uO
 JySfyuNoxn7GgoNVlw/EqIo+MDrQluJGR6Z32fCSnHFxE43nkXSzjXeWg
 vrl6cN6RiO/h1V8ilSi36Y6qAJjJji3jdjrX0CatB+BZR4vgYD5AtPxjh
 UyC9zxUPkw7vaQnJhrBjhncia76BMNSk0BOxkjaokvulqj+vlo7my+Fjm
 6uqIFBxlnvDjiEpP6fJKuFUG2uhFfEFyDE5U8m6QKQd+lYtSM6w5uMUR3
 CHR7+n9wUzpy1Uz42m/tFQ6VV1MUSL+h1PAbrqd7xfppK/cC2Ep2LMuNp Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="100798648"
X-IronPort-AV: E=Sophos;i="6.03,244,1694703600"; d="scan'208";a="100798648"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2023 17:20:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mflXijbeMfWiBGkajmG61s2Vxtp/dgCOQ96gYQPzRzCgi+/NkV1xZHcDq8zl/cJ+2czi3r6UEWUwG0xqTJekGZ2n7skn4oHQvO+Fo0hwbUMh3/uoEBJSVn3+CTwL462HHQKWTsqx+e4THzRDwfe/9h2ZR+5+qTy+5s7+M3M9M+iEiALw01p5lGRn+3E2P/UVgehU/5/mSeOPuKp3IfYXr8YLg7Chqbjtd0Xbr2Sp2BcDGuuVAytvYXJYP9RM1gwHa/Aq+EXzObFI4RCGiZObrlfkeXeO6aSIhB527mqQwr6Jg6LCP0bW8egqDWHNEtcpJzoVKoQrqhiyGNop6RD4uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1vE6CaJhuOZQXJgdMGVexEYCkxVtGu8DnPoRZHT3e8=;
 b=Ws29lS7jVWcXauYOZ91tWrIFfgRHPslWyN4cX2sp2uw32j4BCqxGT98ddTvnSxyl6Fe2buKl3PO+zkPJiZmBK7IU8umHc0CPpT8Z6bTgMPyRuAPJXRcYbxUHGgks78bmhbZK3cqnsJsy6VWj4d2AQUOwO2EG3U8uQHTAJYJbNQpvsT0m23Q1s+4ygh4DB7h3Pp/h5tcCIzQptBqgRpf0C6wpRM57M7hgSo3puQ4/cZg74bcYKikPO4HQwtvanka+cWAaMfwkKDNJ+TgJr7ZfueHFoC6f8sTT6eSZAqJUgFcHDhueSRsAQnwof2FRjJhj/bBRK89uYAKMV3IRl2Wqww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com (2603:1096:604:a6::10)
 by OS3PR01MB7753.jpnprd01.prod.outlook.com (2603:1096:604:17c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 08:20:49 +0000
Received: from OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610]) by OS0PR01MB5442.jpnprd01.prod.outlook.com
 ([fe80::858:c858:73ca:610%4]) with mapi id 15.20.6907.028; Mon, 23 Oct 2023
 08:20:49 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC: "fan.ni@samsung.com" <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "philmd@linaro.org" <philmd@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/cxl: Pass CXLComponentState to cache_mem_ops
Thread-Topic: [PATCH v2 1/2] hw/cxl: Pass CXLComponentState to cache_mem_ops
Thread-Index: AQHaAZyIY+k38qJSXkGW01OLKZtHNbBQ8PiAgAYfdgA=
Date: Mon, 23 Oct 2023 08:20:49 +0000
Message-ID: <5777a309-bb4a-4cbe-9b2b-c2708215bd85@fujitsu.com>
References: <20231018082408.888098-1-lizhijian@fujitsu.com>
 <20231019115039.0000743c@Huawei.com>
In-Reply-To: <20231019115039.0000743c@Huawei.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5442:EE_|OS3PR01MB7753:EE_
x-ms-office365-filtering-correlation-id: b56a3b67-cfd7-422e-db6f-08dbd3a0f6ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PXQMI6MI82jr286jsDJ7+TSWeB2U6lNFholhdZStSFpouuMYX1XSKUlm5TVFOty4xU5C5u7jhRRvx1bhkTa6KS3xP7IjKb6+j6vl/jjbqddKTeqtJXIkfR+1XITpMFo1ar6VmCECcMVUpvyPgFhRQRd1nlPm2/6GAn86LGSQgaoeJgwj2wArX0Y12M0gSDKxQ5sED8/LIn1Bfy2vez64gHIlOvfmkVIjvV8ONReBHWFGvha0Yq073TEqTscmLuIGmt5HNc5mrBksrux4XKP+QlNM8KUTtmK4nRUPwayQDxFAen1bmEEP0HP5xqDeMcQt+JjmX8/0LUy1gNAcqRaDxTKoNWjUEJOJJH2UZBIumVtgsEExNk7Qf5QEkUelp/HjQY5YPJW528gYvYxKZCvokFJIYKgh+qm9T90B9Qs+THKMQhO4d0FQlBahpU2A/h5TR5h7SxZPZFp1tpzaCWgr8GfgqJ9vt5+7OowwpU+cSd5rID/BpZOVIgoEV7blA2tMPA40yMJbc1KztMmT9yyYWFK9KhgxD+7tzok3yRNkkijALKB/RtGF9cor4LvLtaRY/RfFHcQexIoah5g3zPN0zfJDid8CaGMaHPL5jwBIMccWs4JaCBJLAWXdKrZK30qRJdFy5FIZkXduvXssl9lHE07psnvberSvt+ZvmjarWiIIauTus6vUr6W1o+pRskPdXC+ND+IV4PQDufwl05FX1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS0PR01MB5442.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1590799021)(186009)(1800799009)(64100799003)(451199024)(26005)(38070700009)(31686004)(1580799018)(38100700002)(2906002)(41300700001)(86362001)(31696002)(5660300002)(36756003)(85182001)(8676002)(8936002)(4326008)(2616005)(82960400001)(478600001)(6506007)(71200400001)(91956017)(66476007)(54906003)(64756008)(122000001)(76116006)(66556008)(66946007)(66446008)(316002)(6916009)(83380400001)(6486002)(53546011)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWtQaEd6Y3kxMzdQRUkxKzNXOGdDb0tubG41eDU4Q0p4ZUVsQ20vejZOY25j?=
 =?utf-8?B?QjFZMEtpdmQySTNnSzBYUVdFZ3VQVTQ0eENqZ2FGUjdPUjk3Q0lYQkFnZ2hJ?=
 =?utf-8?B?Sjhjei9RVE41bFdDU3A3cDB6SWEydHZLd2xycUJHeExGeFNCdG1QZHZ6cEpE?=
 =?utf-8?B?YzRWelVoREVwOEFpMVA3QXU5Tzc1QUZzams0bHZZQ3hyRFp1RysySVV6b2dE?=
 =?utf-8?B?eGlRQnF4L3V1MCttQVpNR0NsUnVmbEdaNEVaRU5DM24vOFpVZm05MUNVcjV0?=
 =?utf-8?B?alNhSm91US81dmMzaXFyWkRJdk5jQm91bFJqekVNMmNkbGY2RXhtME9Tdmlw?=
 =?utf-8?B?QWNTL0Z6alJXTyswWWZiMDdPcFRxdWZRNjZMSmdGRmJNK0hIeUdreEozYit5?=
 =?utf-8?B?SXdMWWZVK3pKTWNub01OVCtTMmM4SC9GdHNmZEc2bGtYRHhQaXRuQWMySklN?=
 =?utf-8?B?L1I3cm5wV2lCa2VtcE9jbm1Ub0R5cWxvMUI4bXVXNUhSb2ZHM2xMczZIZ3lX?=
 =?utf-8?B?STF0MVN6dEF4QXloVjBXcnRBT0x3RUxxbEFYZU50T1doMHJRRnQxWDVrbEhy?=
 =?utf-8?B?MXVWUTZ3aGhIUlpLM1MxbEJHUS9hN3JEOGFEQXRsS1V1NTFKSGpQSU9ORVZ3?=
 =?utf-8?B?emdIc3FZbDNRTy92Ni9GU2JTbzFkVmxYakdXU2NtaTRkUHRYeXd1K3ZoUVZR?=
 =?utf-8?B?TjRsTGZncndDTTU5YXFTclJoblpCSVkyTWRUREpHU1c5RGNMcHo0Nm9taVdQ?=
 =?utf-8?B?N2FQRkl4UDFGekhnTm03dnZ5cTRXZkJFbDQ3OStUcW9mT0pzN01BeDFtWE95?=
 =?utf-8?B?MFpWcU9KUC9NeTR6TDFJZkhNc1c4b2I5QmVOVGdNbkVaU1V6Tm4xSXZUcEJE?=
 =?utf-8?B?Rm1IQ2tWSWpEVjhrZThiMjNtWkVVNzZaOHpGdDBYRHV2c1VVTlN4VEZpZVNW?=
 =?utf-8?B?Tm9EVmZHWXV5ZnhVdnB0dVpZVW5DN2lleDJWVTZZUjVFdFRLWDFoY0tHOUtG?=
 =?utf-8?B?alJTTzNnU2RER3hEenI4YnZzQkRMbjlQV1R0OUJneWp3VXMzSTRxNG9OeGdU?=
 =?utf-8?B?N2gwVmU4Tk0wdlYxaFlVQkZ0RVlKQ0I1cHFoQkRZRTFsT2xXZ1lpNnJuRTRa?=
 =?utf-8?B?N0Iybm4ybFJhY3dBT2RrYmZGUU9JREJTdVMrc3Fya0ZvblFxR09IelBIMVR3?=
 =?utf-8?B?OExCK3JpTTUwc29tZkp5VGUrQVZ4SzBqMlRLajJEaUEyQmhFeEhrcVRsY0FX?=
 =?utf-8?B?eHNCa0ZqYVJDTkF1MnhSZ2o0a2FWOWV3MzZCSEVLL3N2eFdJOFRNeWIvd3M1?=
 =?utf-8?B?Z0Z5VXcvVjBOaVYzRXh2RFgySmNTSXl6bmY2bDF5akZua3NLYjJLZWhDNWVI?=
 =?utf-8?B?UkxYWnFLOVNVWUVESkkwOVhWK0orMUJkcjl1Zjd5d2t1Y0ZSZW1UVHRTSXR6?=
 =?utf-8?B?Skh1TmhWSnd5YkRYdjcvZzJIWGJkUTRLbWdmazRZbjNuQW5tcHB5b1EyM3NE?=
 =?utf-8?B?OUZKcnZBUnA5NFpFMkVLV1RFWi81MDY5UVNDd0w2ZzJ6dVFyN1JaZmN2SUpo?=
 =?utf-8?B?bENFeUxhT3JQS2E3RzYxYmw4WUdoY0k3M2dqTGxRMDZIN0dabHFVbDl1eGVO?=
 =?utf-8?B?aThva3Y5MVBoNFdKWmFmVlRTNDNib2VvTmdqM01wZjZURjM5dzY0aXFLZDRr?=
 =?utf-8?B?UFFTcHRORCtRY0d4dzJTQndxOTV0YWlSR29ndlh5eWxxMVZsNEkybDA2T0tt?=
 =?utf-8?B?anBtYkU2MkxDVzU1RFdlTGJKMDNMbVdEMkdDamFoa1NhR09iUEI0R1ZpWWRD?=
 =?utf-8?B?R25vWENTcSt2Z0RPc0ZvMHd3dkxZVU9UWkFiUWNXWmN1aDFTYVVQVSsyYm1E?=
 =?utf-8?B?Tyt0S3lRWklpMDRRcTBVM0dYNnV0WUhEWlNYUEl2U29pQVJNSlBVYXh3c2Iw?=
 =?utf-8?B?a2ZsL0JOdGNWOExIUk1SVWgrZjhKdUU0WVpQRDQ1M1BHUG5xWFpCYmJiNWUr?=
 =?utf-8?B?RjhFelRrR0ZZUHlxU2k5cXZZcWx4TERtZ2xyZUplTGZydkZpcEd2cm92TUxx?=
 =?utf-8?B?T1hZUGU2Uy9OazZWMWlhSUh5K0lsb2NsT2N0VUlobnJHMXErK2loK0VsUTdK?=
 =?utf-8?B?QzAyR25tTWNxYmwvSnAvdU84UjgzemMzUUFQSTFiRUhGT3FkeWhFQlhXaFdB?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B39C454EEE66944BD602AADDB124346@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Y378KN+oL1NrtEhirvrJstFpfaPIbrD6uTXn7SigM++/aBbkbKIRb4jihX5oJcO9QBFtI2Dn1m2F9BEAky3VwxYZBUtMjiX9UgqlZC6jYt1qg0N6oD3Rr3V8mP9feum/qLdqbZWiytpVOAnpsV+d3qzy0WTlti1wD+oPOXHYptKuXx7itPa2Y/plt0B+qjwDtgzQfIIJrJ/M9f1Dedmv629VlSkZUTf+6SYrqcGk/ZBPT4Fjc1A3fveBmajuViA56li+ePBNcUj5M/rsl7NJmMn4KkdfeA+zXd43ShRM4QFx31fiRhmSno/CVVFiwCwMmbQF+ao/RoBFWeGktWVQ8KQQXImhKuA221yFanggooGRk3p7dKTKkTK8T7+yxWGPxfTHZd1HJzWSLpQrWHjEwp5fnubdgzJyyQ9hyKdl8z/Em3ClGowQ0QMrm9Ho2uAILO7aCMox6/Rsq9r6NlYeLoXBPQpTIyFRg7wJ2eGI86vGV3OtxTjxULXNdjNC798oajN8Xjsdh1y+JDjI41h3QBN/cTtCYkPpM6pqjkeQ0KRfwxAnzxGvSaRdKoQfdBhe3yOzSL7nSscDFM4uSZfWMPaPcJeOUZDlvVSYsmx1GgnTru1V5XB/5SQm3OAEg3dZpYl9TjuJJKcQHh+cxSP5q+IlCXrL6SIx4pjQPFUQzdzIfa4vL+EDk3KzuAWiwoWc2gbC1+LjJADB6AxtRxcOT+0F4kBjG9aU/o0nx7CDKoxIWkj0J0Rd5jS7agGfahxg072a7O0omJVJk1AsR/WJDfoXLeLmN1BBgg5Tt8kJcFCIpKf/snAfL1ioOvVuHqtx6r4FTgkf0uPUu7V2zpdElij8rt/+L7UBbLpeXbDCWAnCFiOgaI3h/19n5Ll5F3rs
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5442.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b56a3b67-cfd7-422e-db6f-08dbd3a0f6ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 08:20:49.3995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+ZTRIVnkOAn5xcEQJNMF/lgh7mc2gEDI2JyAo+mJ9MjhriK8cF5Dy6gPF94KmO6HhnuN66cuAy5zzs8DMMAhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7753
Received-SPF: pass client-ip=216.71.156.121;
 envelope-from=lizhijian@fujitsu.com; helo=esa11.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCk9uIDE5LzEwLzIwMjMgMTg6NTAsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+IE9uIFdl
ZCwgMTggT2N0IDIwMjMgMTY6MjQ6MDcgKzA4MDANCj4gTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1
aml0c3UuY29tPiB3cm90ZToNCj4gDQo+PiBjYWNoZV9tZW1fb3BzLntyZWFkLHdyaXRlfSgpIGlu
dGVycHJldHMgb3BhcXVlIGFzDQo+PiBDWExDb21wb25lbnRTdGF0ZShjeGxfY3N0YXRlKSBpbnN0
ZWFkIG9mIENvbXBvbmVudFJlZ2lzdGVycyhjcmVncykuDQo+Pg0KPj4gRm9ydHVuYXRlbHksIGNy
ZWdzIGlzIHRoZSBmaXJzdCBtZW1iZXIgb2YgY3hsX2NzdGF0ZSwgc28gdGhlaXIgdmFsdWVzIGFy
ZQ0KPj4gdGhlIHNhbWUuDQo+Pg0KPj4gRml4ZXM6IDllNThmNTJkM2Y4ICgiaHcvY3hsL2NvbXBv
bmVudDogSW50cm9kdWNlIENYTCBjb21wb25lbnRzICg4LjEueCwgOC4yLjUpIikNCj4+IFNpZ25l
ZC1vZmYtYnk6IExpIFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4NCj4gDQo+IEJvdGgg
dGhlc2UgbGd0bS4gIEknbGwgY2FycnkgdGhlbSBvbiBteSBDWEwgdHJlZSBhbmQgYWRkIHRoZW0g
dG8gdGhlIG5leHQNCj4gc2VyaWVzIEkgc2VuZCBvdXQgZm9yIGdlbmVyYWwgY2xlYXVwIGV0Yywg
DQoNCldlbGwsIEknbSBmaW5lIHdpdGggdGhpcy4NCg0KDQpidXQgaWYgeW91IHNlbmQgdGhlbSBh
Z2Fpbg0KPiBjYyBNaWNoYWVsIFRzaXJraW4gc28gaGUgaGFzIHRoZSBvcHRpb24gdG8gcGljayB0
aGVtIHVwIGRpcmVjdGx5IGlmIGhlIHdpc2hlcw0KPiAoYWxsIENYTCBjaGFuZ2VzIGdvdCB0aHJv
dWdoIE1pY2hhZWwgY3VycmVudGx5KS4NCg0KR29vZCB0byBrbm93IHRoaXMNCg0KVGhhbmtzDQpa
aGlqaWFuDQo+IA0KPj4gLS0tDQo+PiBWMjogY2hhbmdlIHRoZSBzb3VyY2Ugc2lkZSBzaW5jZSBj
YWNoZV9tZW1fb3BzLntyZWFkLHdyaXRlfSgpIHdpbGwgdXNlDQo+PiBjeGxfY3N0YXRlLg0KPj4g
LS0tDQo+PiAgIGh3L2N4bC9jeGwtY29tcG9uZW50LXV0aWxzLmMgfCAyICstDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1n
aXQgYS9ody9jeGwvY3hsLWNvbXBvbmVudC11dGlscy5jIGIvaHcvY3hsL2N4bC1jb21wb25lbnQt
dXRpbHMuYw0KPj4gaW5kZXggZjNiYmYwZmQxMzEuLjYyMTRkY2RjYzEyIDEwMDY0NA0KPj4gLS0t
IGEvaHcvY3hsL2N4bC1jb21wb25lbnQtdXRpbHMuYw0KPj4gKysrIGIvaHcvY3hsL2N4bC1jb21w
b25lbnQtdXRpbHMuYw0KPj4gQEAgLTE3OSw3ICsxNzksNyBAQCB2b2lkIGN4bF9jb21wb25lbnRf
cmVnaXN0ZXJfYmxvY2tfaW5pdChPYmplY3QgKm9iaiwNCj4+ICAgICAgIC8qIGlvIHJlZ2lzdGVy
cyBjb250cm9scyBsaW5rIHdoaWNoIHdlIGRvbid0IGNhcmUgYWJvdXQgaW4gUUVNVSAqLw0KPj4g
ICAgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZjcmVncy0+aW8sIG9iaiwgTlVMTCwgY3JlZ3Ms
ICIuaW8iLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIENYTDJfQ09NUE9ORU5UX0lP
X1JFR0lPTl9TSVpFKTsNCj4+IC0gICAgbWVtb3J5X3JlZ2lvbl9pbml0X2lvKCZjcmVncy0+Y2Fj
aGVfbWVtLCBvYmosICZjYWNoZV9tZW1fb3BzLCBjcmVncywNCj4+ICsgICAgbWVtb3J5X3JlZ2lv
bl9pbml0X2lvKCZjcmVncy0+Y2FjaGVfbWVtLCBvYmosICZjYWNoZV9tZW1fb3BzLCBjeGxfY3N0
YXRlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICIuY2FjaGVfbWVtIiwgQ1hMMl9D
T01QT05FTlRfQ01fUkVHSU9OX1NJWkUpOw0KPj4gICANCj4+ICAgICAgIG1lbW9yeV9yZWdpb25f
YWRkX3N1YnJlZ2lvbigmY3JlZ3MtPmNvbXBvbmVudF9yZWdpc3RlcnMsIDAsICZjcmVncy0+aW8p
Ow0KPiA=

