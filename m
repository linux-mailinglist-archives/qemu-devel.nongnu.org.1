Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85BB7AE5A8
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1OC-0006GZ-Mw; Tue, 26 Sep 2023 02:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1OA-0006Fp-E1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:17:42 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1O8-0004Fi-O1
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695709060; x=1727245060;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=m5Ej31K4JyPBzFlLEOGtcDgqWb6x7dwTfmyIFrrLrFk=;
 b=XfF3igES3cqEdSMwUWwnBIOninhF8v2guEDOxijZcYvdh++hAcfuHFEf
 Oqjhiljq/hZ9V0+bxtgUH6WIf/A3Ff5af+DCfoOY7n852ThNEHgN6CuNL
 udBf9WM7CpyAUBqNZE2hHEIT5Pr+cPoBTJEusvK+5xwElST4dOJP05MUU
 VrJfIMjLpDQkI0rvdWp/oThG0grEZb6l1swPz+lk4rQ6X2AJxZuUEeYLx
 zNeGXv4iN3SP+cuFPeG4jm58KOAAii/pOwM+gNH4iR6pGf61SCueTleCB
 Ng27jl/7HOdwKUkhFGIFmsa792J6zPRN0+mZBJhsGvOJq6njrKfMlXSTT A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="96881424"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; d="scan'208";a="96881424"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO
 JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:17:36 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/urwZF8msJYMkagGA2WTkcUZGfiCXp7bzO9ihVyF2TPL+/oTXHZtWxagpJNdMF7uhyLmbTINiO54v2OL2XMf4dQUdeYUWgZLjQnj2dbtVER7O4kl5Z8hvaxNn1qHs7OBMgS0Tf4Q1YGOlF4+0Ar/jg1jm+KQiX1+uhKaqposYxt+ORQlXaGU8oOVLNV4t7DD5W5MqcrZH2Fo87fjXr8mso1vpBNFmkdIRQ4qxmD6KVpZyExPbQWH9eSETOr0kRLDUGr0zSNZx+GzaWrm/LBKAvEcEB3P8qO0ESVAeiMwIxx2IUQIeMjqYAxdBKgQVhvh2yVvFy2Y+3ESHd0aj37cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5Ej31K4JyPBzFlLEOGtcDgqWb6x7dwTfmyIFrrLrFk=;
 b=eRW22+kse1hPJkiwGboEzfxphpSWJD++WB1QS0OC056qXrUmgOdV12R8g3Pre+h5sqjnh+saKzopX6mbK1lKBz7O93vpxiW/YMW2FVPkBKETt8ogrqhANiuInbkaM4muaZqj/s6Hq7qzDZX4Mhaqi/iQ1sL4ic4SM6vfr936bEpiXAmPz5xYvjpxk+XjlYQI4NaXSoyVhtnuNpRMQHbKaW2b1kO/jU0FT9yiydiz0ElMubiyztp+eJ/2fQSRNMOOagprK/PN3ISSrgY7xFiB0Ro/QjQvghpgJ+SMYV8do9UFZo0Mzldj//zMXue6l6I1fK1gR8/ScIPTQRMGNVwc7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYYPR01MB7831.jpnprd01.prod.outlook.com (2603:1096:400:114::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:17:33 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:17:33 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 48/52] migration/rdma: Silence qemu_rdma_block_for_wrid()
Thread-Topic: [PATCH 48/52] migration/rdma: Silence qemu_rdma_block_for_wrid()
Thread-Index: AQHZ6j9l8z9VSLqJuESxsNSuvoezn7AsrcUA
Date: Tue, 26 Sep 2023 06:17:33 +0000
Message-ID: <f66f8411-0466-d7a6-c711-a629528eb291@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-49-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-49-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYYPR01MB7831:EE_
x-ms-office365-filtering-correlation-id: 997d4c25-bb20-4264-12c3-08dbbe58453d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HVj+BWGUtqucHm4nxmXNrJLYNejw6zKsE0HDX6G83NULLXhW58YQcgaGCKtS1Zo9HJowPUTeLS2AIDFh0LCbCs8+kG2S7kddCNVFL7WjJTQ81inJj82O8i4odiRgf1Mb5votIRfXGvCgiA+b3TpNWXFRDPfBS9B+3rjcg/KNuvzo1G5t5lKbsIh7zW4SCS+S0RkKnR7MHxGELdJwQF6SUwDNQxIF40xXXIdVXSThJzBVRyr1nCtmSMzalMGwDou9f9ZgpxjoBSVX5ytTBNqo50LfqmHV7rxbCb9hMUPO5fyiE+gHlhPO48rENzjCkiS9LMeshZ5iSCFd080YkRSwXD8wOMJtyGMPL/UrO8Ev873eNN4Gqce4t1vPsf6jg8Vj7jT9U+I79JolxGIQ8jA5cdXtPQncwFgVhuOkbZuJmtfPdUTU1VmKwiiyOpDP4SGePSrg+039H7cbUyxm5OiHiHaJeWJA2bUOyIFRseqNxaF66vHahD5fKtZWgbO0zKzwouMrcKkvKpcssMydE+SgwlZED7Y/Ullms2NJYguq4gC6etTcfYqfsMp7PFAPBe/BGhkh9yyr/Ldh9mz/OqNgtE+5LoyrUzthkumNKx/BKKw8mjJw4R3zcD8C9IopdBwfvBKldm3ufoEddjTkMKwXfFivB74ikScTWE0oZxZeEeZbpRYlQZyRC5gZgVgJuOEeOnEqjnLbCwR+8hcX2PweoA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(38070700005)(36756003)(122000001)(38100700002)(82960400001)(85182001)(86362001)(31696002)(31686004)(1580799018)(76116006)(53546011)(6512007)(5660300002)(66476007)(2906002)(2616005)(478600001)(41300700001)(316002)(66556008)(66446008)(54906003)(64756008)(91956017)(110136005)(66946007)(83380400001)(6506007)(71200400001)(6486002)(8936002)(8676002)(4326008)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFQzQ3FscDVSai8ybUtaTWtmQTVQcEFjUHBUekp2eXVrSkh5cTVFVUVLM01N?=
 =?utf-8?B?Q1RTRTU0WXpRMHlPc1VLS1ordnNrRmxCaXRGQzdyWGZSTDE3NklsaVZmbnhJ?=
 =?utf-8?B?T3lGRGtnODMrWWJJNkJiak5GdG9mRy9ZVFNhWG94SXY0VXZDdENldFZ1OEYy?=
 =?utf-8?B?UERNVU4yeFhHeFptY3lJK3dBV0RsTnBHRzNQZWxicG9YZ3VEclJiSkgyNldT?=
 =?utf-8?B?eGdpZzZ2L0pYcFh6bzVBU04rRzNlazZZTmw0UWFHWUxxZEltZm13ZkNRdXQ1?=
 =?utf-8?B?SGZtTWtBL2w0Q2MyTi9iU01zL1kzblQxbHRxUHBtc1VLTGw5eDJQOHJaVmhz?=
 =?utf-8?B?eHdQblIzb0hSNnZYU1ZpdCtGcHBrT21aSHJMbkRhUCswNmplZU5rSk5ua1RJ?=
 =?utf-8?B?Q1Axc3ZpWDlCMVdnQUpYMjkyTSs5VHRqUVM3L21KS2FYNGVIaFdqSHpTU01G?=
 =?utf-8?B?SEFXWWVwenlsQXVjbWFCczdmdHBQMWppYVB2Rjk5VG9rakJZTTRNU1c1Tnp5?=
 =?utf-8?B?RFRIRndmeW0wR1JibzdoVjQvZ1cydlVJQ2tyWXdlMmc5U01rVU5wUVdvaEZK?=
 =?utf-8?B?Sk91SXJHVTU2QWlDNEwzcU92TGhSbnBldlRldVhETDU5NjRkQ3VaNXJqTnFj?=
 =?utf-8?B?YzdieTAwT3ZOVjhFdTAya0c5ZEdOc2M2VEt0UUJHYkJ5Q200SnFJWkNwWmY5?=
 =?utf-8?B?MzJFaVdJZ1hHczBmNGM4SHJpYm96YWtNR2VwckpFMHRkblhBTGZMc08zeHZt?=
 =?utf-8?B?c3p0c0dpdHJOeFVOSW5jOThRSEpqcnU3ZDRHTEVBMUZoa084RmRUa1lDNStB?=
 =?utf-8?B?Nk9tTlFOTmhRRkNwbEZOc0NjOXE2cis2K0ZVd09HeGZGbVRvQmtEVG1iL2E5?=
 =?utf-8?B?bEkrVmtaYUdhTEZ2aFdYeERNOXc1WTV3SlJPRXhrTlVJSXh4eTBBU2JaQ08y?=
 =?utf-8?B?WkNJaDJLMWdhK0hGUlE2THJRY29GbmY1U0V3cFdWMVluQnVyRjJyQlFyZENR?=
 =?utf-8?B?aWZvT01GemNsWjh6WTV2MVFxd2FoZnU1U1AxcXVONG9hNVU0SjV1Zjg4bFM5?=
 =?utf-8?B?MS9WazNFR3lTdmVhTnFsSk14M2RETWRNeFNhZFU2T21oRDloVzFld1VYalRO?=
 =?utf-8?B?Y1MxaXRac0ttNng4bFlWS2tOZ0l5WTNPWk5JODVqUldlVUxzckRZNjBibHZT?=
 =?utf-8?B?QjlKeDNqZ0RNQUZzcFdzVU8vTG5KQTNJSGRralE4N1hPUXNVK2F0aW55YUJ1?=
 =?utf-8?B?QjgySnFkSWlVWU1uODA2UmpicS9mV0tzVnRCNlAwZllDUXNzb2NDN2NlTkt1?=
 =?utf-8?B?ZnJpdkpkdEo2L0krdHVCeTBCTnB6LzFhZnFPM0hWM0Zhdk0rSkJ0S2o4dDBG?=
 =?utf-8?B?N3RCdVhIdTRJZDhNR2tiYS9RK0pOWkVONkNSWUEwNzdGZ2t2MVhqOU5oMWpo?=
 =?utf-8?B?WUFKNWF2cXMwazNaSXk4WXRtNFU2dDYwbExwTlVtenVPeU0xc0hTaWk2YWNR?=
 =?utf-8?B?alBtMld5SCtuYXdES1JpTmxPeHdLVjh0aldxSHRYejlPeHB2YWE4dmlCZ1lK?=
 =?utf-8?B?RDBNWkcraHltMzZNT2dqYVVYckdYQmw3c2I5YkpBeEw2c3dKVWgybkdUVmQ2?=
 =?utf-8?B?U0wrc3VQZkNuR25QRHVMSklYUzkrU08wRHk4THlRcTNGdWFLZzdDc0kwVVpF?=
 =?utf-8?B?QTV3ZVVTWEg2bVFiWkJDUUM1UE1VNXVFbWhEZlhMLzg2bHNCaG1lMlVnT3Nv?=
 =?utf-8?B?TEpwcjUvM3Bybm5XKzljOUJ4N1VyK3VORUppazdxR1hkUW5YTkgxWkxJdXVv?=
 =?utf-8?B?Yyt2MEJoOE8vbUxFdGxBM0hhYmVncUltRS9hekg2VFFBRnpmRWRjaS9JUWht?=
 =?utf-8?B?ODRuOHJLbTZvNEd5RFVITjFaaTJvdkhLSXJjSklxWnpWM0FJbkdIMFZ5cTJT?=
 =?utf-8?B?aXRpcHRzRytPRFZkWXowaUVkOXU2dGlCWHh0VCt1eFU2SllXQ09BT2F0TUVh?=
 =?utf-8?B?UEZrcVo5MFY4d1FKWDQwTE45b3U2b1o3aXF1bHFCZFY0a2hKYXd4Rk5aYlBm?=
 =?utf-8?B?YTRoN1F5R2d2cDMzeFpZdkZEckdOLzUrMWVBT2dwNlV6cjg0Y2F2WXVndDVu?=
 =?utf-8?B?STZkc2M3TmpvRjlvYVY4dnpBNWhsbWhjQWc0VkJxMnZMVGw5S1pPS3FrNEJo?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB6E12823E806949B798446E5900CC14@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +3qECMB2prFjfmjW51seDxPdKCt06RBz2k8H0dY2c1IO7klNgIbB+9QPWynTcAgbv5TTE6dLLpYFHbjdESWbYyxtPsqaAJSXHIKOJ6udzFYZUt5O5Kv6gfv2lHW2gDNdR5E0ep0k5hQQ2JYTwI7GBO0zTouT+2iQjA3JLPbtby04u1s0bgRvnYwItqFKdl9BzfC+QSaoSEBQFjAe3AY5Dncf8bBoLS7tHaY/yEgSxy7a5EbGDsJd0JUwchgrk0F8gUp4KYfKRp1nC5x3jT2h6PEpaHCp7Z6po08rpbS6U0/LfQclfsbI+49JNskQhlQfjkVpH/EVWE5pQPTNrJRkLSPAcZCvG3p/zhHk09NDXhJve9FoDurJX4zeonSPhKl6sOD+FfSzZsjSkayOXprC3WNYKZbHf6qJvSZA+DJ326oVn7U1EYXy0mllH3wVdvgwl/n7SQcF/moH+n4eZqGVNJ4uP6gyd1silQfPOZM2kIQRt1tXFhAzibOGchAi4piSL7QmBVFQw4dLepVefHBHWXNkfEIW08qRtjyu1vzSxTH+Cv5A0FsvF+Yp3U3vLjAN4xLKc4tx7sEP5hDdyyZ72OJQSKh9ppxFcmqexBts5trvW9/PQMiiYZcSvWJddTstyuwgLwL2pQ+LZnPHMoSJjsSG1fCZCjN2nc7s5C39IU5+yytkvrk/gh8kFFdd/4ecXqsV1bh6zLZIjnc6JAyTBwzjAVOYqZXevZb9KX+tLA85M6p8LciXRxFFJ8tpKHD7Kl3HVPYRv4hyCr614P1Yn2+V15mQtCNc94i0hnYE7r4=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 997d4c25-bb20-4264-12c3-08dbbe58453d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:17:33.0964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0oeeuYmNixFBSrN5gr5qfkZPIuI5RCvRq75rDI822GuZyoUuEIIe8cBJqbtO2YtrqLg8z9KNUGDasje2lhglvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7831
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBGdW5j
dGlvbnMgdGhhdCB1c2UgYW4gRXJyb3IgKiplcnJwIHBhcmFtZXRlciB0byByZXR1cm4gZXJyb3Jz
IHNob3VsZA0KPiBub3QgYWxzbyByZXBvcnQgdGhlbSB0byB0aGUgdXNlciwgYmVjYXVzZSByZXBv
cnRpbmcgaXMgdGhlIGNhbGxlcidzDQo+IGpvYi4gIFdoZW4gdGhlIGNhbGxlciBkb2VzLCB0aGUg
ZXJyb3IgaXMgcmVwb3J0ZWQgdHdpY2UuICBXaGVuIGl0DQo+IGRvZXNuJ3QgKGJlY2F1c2UgaXQg
cmVjb3ZlcmVkIGZyb20gdGhlIGVycm9yKSwgdGhlcmUgaXMgbm8gZXJyb3IgdG8NCj4gcmVwb3J0
LCBpLmUuIHRoZSByZXBvcnQgaXMgYm9ndXMuDQo+IA0KPiBxZW11X3JkbWFfcG9zdF9zZW5kX2Nv
bnRyb2woKSwgcWVtdV9yZG1hX2V4Y2hhbmdlX2dldF9yZXNwb25zZSgpLCBhbmQNCj4gcWVtdV9y
ZG1hX3dyaXRlX29uZSgpIHZpb2xhdGUgdGhpcyBwcmluY2lwbGU6IHRoZXkgY2FsbA0KPiBlcnJv
cl9yZXBvcnQoKSwgZnByaW50ZihzdGRlcnIsIC4uLiksIGFuZCBwZXJyb3IoKSB2aWENCj4gcWVt
dV9yZG1hX2Jsb2NrX2Zvcl93cmlkKCksIHFlbXVfcmRtYV9wb2xsKCksIGFuZA0KPiBxZW11X3Jk
bWFfd2FpdF9jb21wX2NoYW5uZWwoKS4gIEkgZWxlY3RlZCBub3QgdG8gaW52ZXN0aWdhdGUgaG93
DQo+IGNhbGxlcnMgaGFuZGxlIHRoZSBlcnJvciwgaS5lLiBwcmVjaXNlIGltcGFjdCBpcyBub3Qg
a25vd24uDQo+IA0KPiBDbGVhbiB0aGlzIHVwIGJ5IGRyb3BwaW5nIHRoZSBlcnJvciByZXBvcnRp
bmcgZnJvbSBxZW11X3JkbWFfcG9sbCgpLA0KPiBxZW11X3JkbWFfd2FpdF9jb21wX2NoYW5uZWwo
KSwgYW5kIHFlbXVfcmRtYV9ibG9ja19mb3Jfd3JpZCgpLiAgSQ0KPiBiZWxpZXZlIHRoZSBjYWxs
ZXJzJyBlcnJvciByZXBvcnRzIHN1ZmZpY2UuICBJZiB0aGV5IGRvbid0LCB3ZSBuZWVkIHRvDQo+
IGNvbnZlcnQgdG8gRXJyb3IgaW5zdGVhZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcmt1cyBB
cm1icnVzdGVyPGFybWJydUByZWRoYXQuY29tPg0KDQpSZXZpZXdlZC1ieTogTGkgWmhpamlhbiA8
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg==

