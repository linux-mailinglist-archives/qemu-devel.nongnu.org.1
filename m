Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BCE7AE63C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 08:50:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql1tW-0007PR-M7; Tue, 26 Sep 2023 02:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1tV-0007PG-85
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:50:05 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1ql1tT-0001vz-2U
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 02:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1695711002; x=1727247002;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TasNues28L5zaidTFyp3Amtvb069IPiUeBTwx4SePVs=;
 b=Fz43WrK5uEngwqVmUACMN759ZhPphAll3KyIR63lQuLEZ0ow60v3nUvF
 umLUPOQH5mb2r9Q3gj9/Yff3ld5DfUYUu39BkxsMxi1lULCRCva2k/Onl
 z3TaHzZgf9V+CryB21XaYJyDS7WuPvltj4/v9WBzbwnqWiplDwTvTWoXT
 6pei8V7C82aiZqQbD+ZruM5W4EAWKYvjzoVQo9HjwKQM4n7/3e5TJdCaG
 Bc3onPyOjmOSLqq5shcXpLNEwdsWxrUaGNEoVz9SklG7Oz8R5qdy2XnGq
 wUpRDZDkjbCMv0GmxUuv8665ycMYx8vH3lJrf/lPaHfOTIGbpG21eD/IE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="7816551"
X-IronPort-AV: E=Sophos;i="6.03,177,1694703600"; 
   d="scan'208";a="7816551"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Sep 2023 15:49:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DimzSqdSJ9hJGVTy2bJ5U4h0ysjhYrploO0ziEIZNNfzWG/7lCd7mzuXCyPIyAdhewi69Pqm7x9g67qO3OOeWjTRQOdw8ZGinHgxCZoeFyIeA8YS+7EYLUFUqOGd5aaL4LhjitN3lxQ0766Wgss2u3P9nl6QeYDls74bOoJupW4tz7uQ29qbte8mCeZUvT+ppEpIFHxQzBsIgE0uuVj6mNUvBf1u91xDC8vp0ePKuxUfTMQIg4b4bqSiOnsMHzsyVVBoE1dm8qBHUJ5TgBA95ZgRsTKPy7PwiCiPffxUHVKYcMx6f030iqCqg3d5/mkdXSlccXPEyLlB+2xwBE6MiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TasNues28L5zaidTFyp3Amtvb069IPiUeBTwx4SePVs=;
 b=cabZ4l0IrcEmQkNUB2Xht/fwVaUqaerUIa1HADEWDKHAv+lxbio40lv2ZtaLXQmpl1BI5QoXd96+KjIdq3RLDkjgy3peci5UAMMWvY8lYcQJMnVr3q54uvhCblw7yLjsS/2t66ms2a3uXQa1zKGFjtjl+LoMIra2UKI7Ut6Yzuj1EEPEeYkCe36fsmIcYaAt3FhgPm+xTBD/uu5iNnxtEGSHlqDpfNaezeBbEvPuAfBA3gu1xnseNck0pSdh3kolG8I8JSM8x8j6JUaQeOPbsjk47krLAU43krmOnfvLEukf/IWXnG52aXZEbX1IyTtyX8UyPMd9j5eEwXYGk7/1ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by OSZPR01MB9518.jpnprd01.prod.outlook.com (2603:1096:604:1d4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 06:49:55 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 06:49:55 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 52/52] migration/rdma: Fix how we show device details on
 open
Thread-Topic: [PATCH 52/52] migration/rdma: Fix how we show device details on
 open
Thread-Index: AQHZ6j9m16/H1BLO50aaUqaiSTqbRLAsttAA
Date: Tue, 26 Sep 2023 06:49:55 +0000
Message-ID: <33c6b098-dc29-535f-5b17-e6e606049e59@fujitsu.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-53-armbru@redhat.com>
In-Reply-To: <20230918144206.560120-53-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|OSZPR01MB9518:EE_
x-ms-office365-filtering-correlation-id: c62d5afa-1a27-4248-80a8-08dbbe5ccb25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E1BI8Mg0ZM3IGjYasI1eGTndEDSvyuUGutItFGs9ju4ODv4O2qBz74gdO+rQXjI6dZzfJkCxO9gINSf5+pLNcEP0NVqyepHUqc+tQnbZesXXu+i14N/VYdjheTTq+uLTsdF9sjlKbGDRanfPW9cDxJPlBLvwCVbtbvyOINZ7pgUCAynDPdv86AmRnD2IkgBWPFh4ih1zTrtIrixgH68dAUl73apgNj5O2Q5iqgxcABhrR1ylhGyjMxi0DkR8g87w5QFAoIqObczdJtImTtJ56RdIScNM+0jpqceCO77xXocDfYC/YH+Jsm8b7VwuP4zpxsXx4MKGTof94+ZnyJZGTMT3fHzp0EDki9c2L4MfDOJhZwSlee0vD/Iv573LCMa2+s01U8S4P8mtqaSE8mYNnymKBpPOX5RRjWCxCGw7DL5rcmqh/EpirSKwGzmsY+Y9q5oF+BqXruoIEHjn27M6WAFT13ZSIIDajZa0nqJWrGYaunFI9YXI7lHouZqCTdeVQb9UCpcxrAukBv7DO0bcM0V2tJZOIjZzfIIAauH4T6fMILVqOYwOfaKpXqnSbf9UC79nm0sx33/hFTKLaeMym6OkmBNcuOr5hrRmhDxeM6e/DBeegH7jUfe9yhJ3FbFfjoBejPN7d+0vhnCqKGZ07vpiqptp8aJ8fzk2ibL1G+gZzKHMiIVUTFWjL4xfPyiqYFTa89Qu5RT7FNrvJ94w2Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1590799021)(186009)(1800799009)(451199024)(36756003)(122000001)(38100700002)(38070700005)(82960400001)(86362001)(85182001)(31696002)(31686004)(1580799018)(53546011)(2906002)(2616005)(478600001)(41300700001)(316002)(66476007)(6486002)(76116006)(66446008)(66946007)(54906003)(64756008)(91956017)(110136005)(6506007)(71200400001)(6512007)(66556008)(83380400001)(5660300002)(4326008)(8676002)(8936002)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YmNFd3RobjlHUUNKU001L3pKUk1mVll2UWY4dER0RzVmL2ZRdlZDbFM2RlVW?=
 =?utf-8?B?S3c1RGg0eFlhN1VSbWUvQXBON2RuaUNKQzI4UUN0QXBRV3VkQXNEWGVwV1Nx?=
 =?utf-8?B?bUFEQk00WEd1SC9ncGVlWk9pVVBUVWRqUytvM3JrNHlBWG1YUFRYLzRGaFhh?=
 =?utf-8?B?L3F3SHpMZzZtMFExOTd0REdDS2NBYTRMLzJBSS9nczVSYzFla1huSElGeGpw?=
 =?utf-8?B?cCtYYkI5Mk9jd2FLcFViUWFPQkJ2OWV2MmRoT2RvRWJJNTk3Z1g0TjROSjRn?=
 =?utf-8?B?MjFaVVJ5dUZiRjF2OU1jeTZhSUVKdDV0anVQSDg4MjFUbTE5SHpLTEROdldl?=
 =?utf-8?B?VVNhb1h2TnlMK3R6bjlTRnFabVJoZXFhUy9zQnVmcjBBRDZaRU1sdURZUFZC?=
 =?utf-8?B?ZXYzeG1EVG45MGNJeWgzMDFTS1h6NGJhQXB6cXJWemRZSWlHcisrNk5SZTcv?=
 =?utf-8?B?SEJhdzFsUDl1d0pJWXpYMkRNUFF0L3cvNFJGSDR1N2ZHZHEyR3dRSjZyTkJt?=
 =?utf-8?B?Q2Z3WnZxVmJhU0IwVkVMT0Iyb0thNy8zc0FMb3QwdFZPNy8yd2VQaE5HT3Jr?=
 =?utf-8?B?VTZ4cWhjRlZiWTNQdjI3TTZUUVlvcVU5Qi9CTXFidDI2YmEydzJXNXpzWTZx?=
 =?utf-8?B?MmxWb3EyM2NtSE1FRWhsQXRZNFQzVTIzaXNtL3NNcXEyTGphcTVEVlY3Nllr?=
 =?utf-8?B?cTFvTlp5d1gvdkFFRGdmbGJBNHBMNDdwbTVtZGp2RzJOWDdtWGxnc0R1M0Ez?=
 =?utf-8?B?bGt1QVFGRFg5ZlBlNWxQdm9mRm1pUGVFb2RyVi8yZk54WGFqWnZjbkY1YWVG?=
 =?utf-8?B?ODVZMlcrYjk0NDIvc20rdjFQNnFXQXZnc0dyOHNUM05vMDN0S0JDT1dtQ2Fk?=
 =?utf-8?B?SG1LTGt4emV1clR3dnF1azRVSzNFYW94NTlqTXhnNkFBQzlYSXBOWUdaUGo4?=
 =?utf-8?B?cnlpblZUSk9kdTBEc3NlVldmZ2tzcXNJWEtuMXVPUUVnUEpXUFZvcC9UdjQx?=
 =?utf-8?B?amVnTjRUaUR1SklPNU5LL1NRY2R1d3BMNXU2L2s1V284bVRrTjFsenMxaG94?=
 =?utf-8?B?VTIvbU9GMlVvdEdxRUpVVjFINjFFU25hOGp0U21IYnhhNmdzMFZHTExZaXJv?=
 =?utf-8?B?YmFUTkthSEpYUHc1elBPcnZsbjVSdkhpNUFES3lhS2tMZTRiUzlBcG5ocUNo?=
 =?utf-8?B?RWtKQ0VCdVg2WjR5bitmQTYydXNGSjRqK1Y1WWhHcFUrTk1TSUhDOTZjUHhn?=
 =?utf-8?B?b3E3Um5wdkhPQnNUbkVKbmVycU8xU3EvRFVXVFc2eFFLSm9nZmJYaU1ZYnkw?=
 =?utf-8?B?MWlobTZUK3dwL1hQL3RFcEtGK3pQNGxiYkoxaEpLSFl4SkZnanlQUW15TVp1?=
 =?utf-8?B?RzVSYm1PcldTUlNsZVZ2eFVvNlJtaXZpc2RGRnVOOGFMTFJRS1h3bStUcDdT?=
 =?utf-8?B?ekppV1FIdGU1c0JrbWNaYUZ1RURibERFZ3JHaUdUcnpqanExc3BOaFgzV0sv?=
 =?utf-8?B?c2F3YmFVbkNjY05WUjNmMTZpOERyK1duNHlXZ2pkblBieGRWbkljdUdpQTgz?=
 =?utf-8?B?THRFdXMvU1M1NE1pa0k5Q0FFZ0RmZ1FkbDVKYVBhZEhUdEg1b0p1LzNYNXo1?=
 =?utf-8?B?b0xwWEJyMzNabW5JUThWNWcyckFBakdVRzRrViswYkNEWmhEbUNYdTM1RWhB?=
 =?utf-8?B?bDlSVkhoT09tVno3b2xIUWtmUGE1MEFnNENwK2FMeFMwV2s1MHlGTXRFay8w?=
 =?utf-8?B?dEF3WDR4bGtUbzFLYStQNDJoUmpIUFpqOERtTUZQcXJsd1FBZVQ2TXpjNXpp?=
 =?utf-8?B?ZWlkOE1Ib3loUk82cFlza0ZCZFZDbDR2NDlIMjJPcWkzazZWOEZVUGVRSHIx?=
 =?utf-8?B?NnU2eFlXTXc2OU5jczBiN0RCRmcxejRPK1VRT1A4aW1mNDRjeVY4SFN5U2hu?=
 =?utf-8?B?UkhCNGJJeWs2SWo1cUNORWtWYVBoUlFnZGVBWm0rVXpiZzl0eDBpK1dVSjV3?=
 =?utf-8?B?QkE0NkZ2b09SY3FNVlNMQ3dRcU5maVFEMXJOZ01oQnltM2ZXeVI4SzJha1dQ?=
 =?utf-8?B?ZFJ6MVJoaDFUWlZWSW1RZENoTHdZUmR5d2VTUDBsbWlMSXNiM0srM3E5d1FU?=
 =?utf-8?B?OTd6b1IzUEhVaDljeTJqM1cxcnFLV0FmV2pad0IzSjBEdWJtTEgyYVE4V2FQ?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <554E304890E5A74EB2FFC4086D5794EC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wYNG1EACqPxsK2Lr0nNgJvlO6c//pT1GKihzaPXzgrgEWrrS8Re3pbCAL86+sSMQf/wR5ogO/XgOl4nwOYtaCJ+9MEsoEFe7mSN+BaG8rxqZn763V5Y3j1XLtuNxfhTWMSTjoGOxPo5H/s2W8cXrLRul2qqrn54ExiZ3FhhbARxB3rGDpEIv931lx1fPYxXNpj21ZiSOb5fc0puPhUh8bHFoFnRg1BlhF75NGderb9J+SThdZcwQaR+Bn0k5aRs1IpEy6EJPfnY4dBLi8+mHHzn+ARomJ84b4mZo79wopvAN/yqLc9UdYT4y9oOcnnfBSpl2jPOqXyvz61jjetwoSFM/Wzy+4v/yp9PTrfLrZdWWKIBEFxTBcxeE7i0BWFGXTdxlcL5+EwPDtTfKXGKzAcrxDKH9ONR1apvUhWrcmGuF7k0kHJRR3yupWmcDIIM8xGiHW/YXVPq28lLGtcXxRL6NI74SdWkQb7gxt/OFNgHRCpdoztC+/DF6bYY3DY13wfS9jepxUfzy47pODpmDnM3TQ5ADmjijPzH3Q0Uqr9VE3NBmV8zULwOirZ32wEBJZ5AIaAuS8kq/s32wfw01hZORfbo1s9FD6aExDXM4zShkMklIY2+ZHAZsOCDHGqx2qJlbTBL513rV7vHOR3e1S6IXOIoLXqEz6cea0PKxTF+9H22d4rkJVTn5chPuIi0aQ9DU+JxXZXK95tl/eyf4UIvuSX8UGJ2Ovt2MNUd/LV9SJxPey93ZS4ytbC2NUomncF1MKGX3aEME7K0FSDA5nDWhY9gYqnEjsfBVzOYSkOs=
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62d5afa-1a27-4248-80a8-08dbbe5ccb25
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 06:49:55.7387 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ik+q63L/rj0H7yASfQxDmKknQBxJRQ5i3cBNoCQ1aNyEntH2QTZ06bl+ViLpYN1HfVDsOhenMds+ip3ryJsLMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9518
Received-SPF: pass client-ip=68.232.151.212;
 envelope-from=lizhijian@fujitsu.com; helo=esa3.fujitsucc.c3s2.iphmx.com
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

DQoNCk9uIDE4LzA5LzIwMjMgMjI6NDIsIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxZW11
X3JkbWFfZHVtcF9pZCgpIGR1bXBzIFJETUEgZGV2aWNlIGRldGFpbHMgdG8gc3Rkb3V0Lg0KPiAN
Cj4gcmRtYV9zdGFydF9vdXRnb2luZ19taWdyYXRpb24oKSBjYWxscyBpdCB2aWEgcWVtdV9yZG1h
X3NvdXJjZV9pbml0KCkNCj4gYW5kIHFlbXVfcmRtYV9yZXNvbHZlX2hvc3QoKSB0byBzaG93IHNv
dXJjZSBkZXZpY2UgZGV0YWlscy4NCj4gcmRtYV9zdGFydF9pbmNvbWluZ19taWdyYXRpb24oKSBh
cnJhbmdlcyBpdHMgY2FsbCB2aWENCj4gcmRtYV9hY2NlcHRfaW5jb21pbmdfbWlncmF0aW9uKCkg
YW5kIHFlbXVfcmRtYV9hY2NlcHQoKSB0byBzaG93DQo+IGRlc3RpbmF0aW9uIGRldmljZSBkZXRh
aWxzLg0KPiANCj4gVHdvIGlzc3VlczoNCj4gDQo+IDEuIHJkbWFfc3RhcnRfb3V0Z29pbmdfbWln
cmF0aW9uKCkgY2FuIHJ1biBpbiBITVAgY29udGV4dC4gIFRoZQ0KPiAgICAgaW5mb3JtYXRpb24g
c2hvdWxkIGFyZ3VhYmx5IGdvIHRoZSBtb25pdG9yLCBub3Qgc3Rkb3V0Lg0KPiANCj4gMi4gaWJ2
X3F1ZXJ5X3BvcnQoKSBmYWlsdXJlIGlzIHJlcG9ydGVkIGFzIGVycm9yLiAgSXRzIGNhbGxlcnMg
cmVtYWluDQo+ICAgICB1bmF3YXJlIG9mIHRoaXMgZmFpbHVyZSAocWVtdV9yZG1hX2R1bXBfaWQo
KSBjYW4ndCBmYWlsKSwgc28NCj4gICAgIHJlcG9ydGluZyB0aGlzIHRvIHRoZSB1c2VyIGFzIGFu
IGVycm9yIGlzIHByb2JsZW1hdGljLg0KPiANCj4gVXNlIHFlbXVfcHJpbnRmKCkgaW5zdGVhZCBv
ZiBwcmludGYoKSBhbmQgZXJyb3JfcmVwb3J0KCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJr
dXMgQXJtYnJ1c3RlciA8YXJtYnJ1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9y
ZG1hLmMgfCAyMCArKysrKysrKysrKy0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBp
bnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21pZ3JhdGlv
bi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IDllOTkwNDk4NGUuLjhjODRmYmFi
N2EgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWlncmF0aW9uL3Jk
bWEuYw0KPiBAQCAtMzAsNiArMzAsNyBAQA0KPiAgICNpbmNsdWRlICJxZW11L3NvY2tldHMuaCIN
Cj4gICAjaW5jbHVkZSAicWVtdS9iaXRtYXAuaCINCj4gICAjaW5jbHVkZSAicWVtdS9jb3JvdXRp
bmUuaCINCj4gKyNpbmNsdWRlICJxZW11L3FlbXUtcHJpbnQuaCINCj4gICAjaW5jbHVkZSAiZXhl
Yy9tZW1vcnkuaCINCj4gICAjaW5jbHVkZSA8c3lzL3NvY2tldC5oPg0KPiAgICNpbmNsdWRlIDxu
ZXRkYi5oPg0KPiBAQCAtNzQyLDI0ICs3NDMsMjUgQEAgc3RhdGljIHZvaWQgcWVtdV9yZG1hX2R1
bXBfaWQoY29uc3QgY2hhciAqd2hvLCBzdHJ1Y3QgaWJ2X2NvbnRleHQgKnZlcmJzKQ0KPiAgICAg
ICBzdHJ1Y3QgaWJ2X3BvcnRfYXR0ciBwb3J0Ow0KPiAgIA0KPiAgICAgICBpZiAoaWJ2X3F1ZXJ5
X3BvcnQodmVyYnMsIDEsICZwb3J0KSkgew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnQoIkZhaWxl
ZCB0byBxdWVyeSBwb3J0IGluZm9ybWF0aW9uIik7DQo+ICsgICAgICAgIHFlbXVfcHJpbnRmKCIl
cyBSRE1BIERldmljZSBvcGVuZWQsIGJ1dCBjYW4ndCBxdWVyeSBwb3J0IGluZm9ybWF0aW9uIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgd2hvKTsNCg0KDQonXG4nIG5ld2xpbmUgaXMgbWlzc2lu
ZyA/DQoNCg0KPiAgICAgICAgICAgcmV0dXJuOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgcHJp
bnRmKCIlcyBSRE1BIERldmljZSBvcGVuZWQ6IGtlcm5lbCBuYW1lICVzICINCj4gLSAgICAgICAg
ICAgInV2ZXJicyBkZXZpY2UgbmFtZSAlcywgIg0KPiAtICAgICAgICAgICAiaW5maW5pYmFuZF92
ZXJicyBjbGFzcyBkZXZpY2UgcGF0aCAlcywgIg0KPiAtICAgICAgICAgICAiaW5maW5pYmFuZCBj
bGFzcyBkZXZpY2UgcGF0aCAlcywgIg0KPiAtICAgICAgICAgICAidHJhbnNwb3J0OiAoJWQpICVz
XG4iLA0KPiArICAgIHFlbXVfcHJpbnRmKCIlcyBSRE1BIERldmljZSBvcGVuZWQ6IGtlcm5lbCBu
YW1lICVzICINCj4gKyAgICAgICAgICAgICAgICAidXZlcmJzIGRldmljZSBuYW1lICVzLCAiDQo+
ICsgICAgICAgICAgICAgICAgImluZmluaWJhbmRfdmVyYnMgY2xhc3MgZGV2aWNlIHBhdGggJXMs
ICINCj4gKyAgICAgICAgICAgICAgICAiaW5maW5pYmFuZCBjbGFzcyBkZXZpY2UgcGF0aCAlcywg
Ig0KPiArICAgICAgICAgICAgICAgICJ0cmFuc3BvcnQ6ICglZCkgJXNcbiIsDQo+ICAgICAgICAg
ICAgICAgICAgIHdobywNCj4gICAgICAgICAgICAgICAgICAgdmVyYnMtPmRldmljZS0+bmFtZSwN
Cj4gICAgICAgICAgICAgICAgICAgdmVyYnMtPmRldmljZS0+ZGV2X25hbWUsDQo+ICAgICAgICAg
ICAgICAgICAgIHZlcmJzLT5kZXZpY2UtPmRldl9wYXRoLA0KPiAgICAgICAgICAgICAgICAgICB2
ZXJicy0+ZGV2aWNlLT5pYmRldl9wYXRoLA0KPiAgICAgICAgICAgICAgICAgICBwb3J0Lmxpbmtf
bGF5ZXIsDQo+IC0gICAgICAgICAgICAgICAgKHBvcnQubGlua19sYXllciA9PSBJQlZfTElOS19M
QVlFUl9JTkZJTklCQU5EKSA/ICJJbmZpbmliYW5kIiA6DQo+IC0gICAgICAgICAgICAgICAgICgo
cG9ydC5saW5rX2xheWVyID09IElCVl9MSU5LX0xBWUVSX0VUSEVSTkVUKQ0KPiAtICAgICAgICAg
ICAgICAgICAgICA/ICJFdGhlcm5ldCIgOiAiVW5rbm93biIpKTsNCj4gKyAgICAgICAgICAgICAg
ICBwb3J0LmxpbmtfbGF5ZXIgPT0gSUJWX0xJTktfTEFZRVJfSU5GSU5JQkFORCA/ICJJbmZpbmli
YW5kIg0KPiArICAgICAgICAgICAgICAgIDogcG9ydC5saW5rX2xheWVyID09IElCVl9MSU5LX0xB
WUVSX0VUSEVSTkVUID8gIkV0aGVybmV0Ig0KPiArICAgICAgICAgICAgICAgIDogIlVua25vd24i
KTsNCg0KDQpNb3N0IG9mIHRoZSB0aW1lLCB0aGVzZSBtZXNzYWdlcyBhcmUgbm90IG5lZWRlZCwg
c28gaSB3b3VsZCBwcmVmZXIgdG8gcHV0IGl0IHRvIHRoZSB0cmFjZSBpbnN0ZWFkLg0KDQoNCg0K
PiAgIH0NCj4gICANCj4gICAvKg==

