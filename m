Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB59B7BC3EB
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 03:54:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qowVN-0002jn-Jw; Fri, 06 Oct 2023 21:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qowVH-0002jK-Vf
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 21:53:16 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1qowVF-0005XP-PZ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 21:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1696643594; x=1728179594;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=bPyBwD1GoG8dApZ7KATW1qcqP5D5WIyKUyvTcFj2YVQ=;
 b=LzoOGxS400inWHrnwaK/tefYLsz/Ydu+BZIhP4EU4rE6qbAQ2OPdOrir
 QyrhBV5PvF6t/6sTWR5euKXmUeg7rRvGoeFA0TbBsngdxBKoMYqh4GgYz
 FZfNuCsPE+5dmMHl539KY/kwpAnyQlEFeEfKOd4q/Rp9Fl0i5IySv7HZw
 nMOdOD5FuqOHr5L6lszlFftyotI7RNL6kRn07DQp+c1iDflv9udDmhqgc
 xpEVvrCGznpHj5Q6+wA4kUwcRkIIDQj05j1/dldYu7BDRBrYmkRfEoS4u
 HXLZklwW1c1uZ7gRa6Dnaj4DNo4xZ07MMG9GSPEdNaB+nEawgrF2ZGb81 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="98398013"
X-IronPort-AV: E=Sophos;i="6.03,204,1694703600"; d="scan'208";a="98398013"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO
 JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2023 10:53:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVeKpkIL+NduAjmIQWdTNYCf1XbvFYKMolFC/S5kzsZ2ogtdB3meOVDBjcm8gEs9N066UVb8NK2rf+WeDQ9p8lNiaXtOFSyNo9DxgIS9YGuFtqWoRuf7gFBDR3y8ZeKZKWb7//9yr0vF82s90EbW5nQmsBJv642gllf0lxlcZt/0YhX0uhRN1of6Mm2tYsgoO4ne9rk5qYKaNWg3f2kA5q804AjixUNHeD4qMO/9ZQNtHKmoofDTHWsUf2J0HTYZaiuWtrvM5OqM+a/XYlYeiDzUm0mOmM5XVPYSxKt88VVFzhVknGWy54XD5nAwKjNhnxygmZfpwpmu+athwjly3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPyBwD1GoG8dApZ7KATW1qcqP5D5WIyKUyvTcFj2YVQ=;
 b=S+v4jAxkkfFDeL+68j3wPkNgKgh6gZGHtmdlu2Xdmy2wUc2swujshck8d0EMkIIxvmKgwAQWexR1521FgBSqv4O390Gmxdzl5sbWFk/ybYop14ucpBa199W9/asu1OspMFbXiTNKjC1233qkd5uCWPjtqOOIJ+/x8SOVvqa1iWPG2lcrBjIv2Xrdlub/YA21S248Y6dvXTo3P9/2TvONSFABmK8KlU2KpHQzWamRENsQzjAzfs4S3LHQ4mHBhhHxX62EiDaW+RVaod0SGFTW0YJs7yvoHCJTliFR9y+/CueNd1Cdt+c5bs66jqVWnRvlg46+VqQcHc4Ysq+grUfADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com (2603:1096:604:247::6)
 by TYWPR01MB8361.jpnprd01.prod.outlook.com (2603:1096:400:162::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Sat, 7 Oct
 2023 01:53:02 +0000
Received: from OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe]) by OS7PR01MB11664.jpnprd01.prod.outlook.com
 ([fe80::87a4:7103:63be:64fe%4]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 01:53:02 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Markus Armbruster <armbru@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "quintela@redhat.com" <quintela@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "leobras@redhat.com" <leobras@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "eblake@redhat.com" <eblake@redhat.com>
Subject: Re: [PATCH v2 06/53] migration/rdma: Fix unwanted integer truncation
Thread-Topic: [PATCH v2 06/53] migration/rdma: Fix unwanted integer truncation
Thread-Index: AQHZ8g6OyaT1sbH2UkSbWMgFPbvo+LA9neKA
Date: Sat, 7 Oct 2023 01:53:01 +0000
Message-ID: <9225871b-e17a-5192-68e4-d74861ed8a6d@fujitsu.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-7-armbru@redhat.com>
In-Reply-To: <20230928132019.2544702-7-armbru@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS7PR01MB11664:EE_|TYWPR01MB8361:EE_
x-ms-office365-filtering-correlation-id: 004d9a45-e418-4525-0699-08dbc6d823d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mmM1wPPIittZkvZAj3onsHg0NLuEE9dBWoqr9k3ACzeMKn6/inyifQxXBjLGYzn9yaqpUVKYhquqmTzFLE1FziI/+MlZAQ/y9L0KmGG+RtbL7VUmQTRD7Xmd6C/xOC6nzA96V/2C5ikDWeazTVJO21HWPbgsbu540rS+sNYS3NQ1zzIVDRSvUplXumvduWGadQweGJ5+046x3bs7SUL386siTI/z2w6hS7/ucrt38LtD55pN7hE91knCy1b1yEnp9icslQtrfJ7ufsNsae6YNx4SG1o7ctgoA2g4NlS1CtTPYVy5doNt6moyHXAgYBKSJsF8MSDu1ypPHObkhVj2+l8nI9eOp7d2Faw7M+yNy2eTW38MyYem/igZDiLzTo3pSjsasjmd42iv9dwAnIaFHcAkE7b1Xu7cAAGh34lp6MdVUzTdTRe02KwhDwliemgFxmyVZHQXNj3EwJzU9e15wWtDi2ctiC8H5gXzjdefsJ3NvnToM8yTWniS4cRu1WQZiVvJMuzWm+umoWOfpDQJ8apuQzsxCUsjMGqeadXvAkR/iPiIqXTeVH1BDU2aEBeuNSReVDTECBWQnT1EaZG8zzxcIQl2D5qiEtm4LrNJvEdVC+d3MduaKv0kRXlxVfL26tLzmOTUdfWhh+nDy7Yl4/E1Iu+X/aGd+CHggyQk+5oZ8OwluLlnQMDbblPFmV0lYYhfSjRaHhxfzCOY8dBU9zL3l2g/jxjiXDrZfniUlu4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS7PR01MB11664.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(1590799021)(1800799009)(451199024)(64100799003)(1580799018)(8676002)(5660300002)(316002)(66446008)(54906003)(76116006)(66476007)(66556008)(41300700001)(64756008)(6486002)(66946007)(31696002)(38070700005)(478600001)(4744005)(91956017)(110136005)(2906002)(8936002)(4326008)(71200400001)(122000001)(53546011)(6512007)(86362001)(82960400001)(6506007)(38100700002)(85182001)(2616005)(26005)(36756003)(31686004)(26123001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStGSnBteTVvUlJXcldqYlA0SHpVbzBwM0Q2blZHTVRMS0NWRHhpZThMOU1z?=
 =?utf-8?B?ZmQ5SitvZDlXRTJ0ekNKL1NXSmJzY055cFQ4MkluV2tFY0lqMnVWYVNsYzVC?=
 =?utf-8?B?UkZENFFXamZzWW1ISk03clg1WjhOS0w4THZObUxGKzkzMEhLbUhPTXZNbkxt?=
 =?utf-8?B?OE1PNVJiZWc4V3dZSk1OYmNUSjlUK0RRR2o5eVVQVWJGQlV5QkdhQS9IUkhK?=
 =?utf-8?B?c011NHJxNTNoazNhTHk3UlVrQm9UL1VBdnl0OUN1bWQ2VXloWlZ6UnRpL1Zw?=
 =?utf-8?B?ZWsxYTl2ck1NWVQrQ1hkVGNvdnRlZVZrc3lTampBNlJtWXdiS2JsLzdwYkw2?=
 =?utf-8?B?Sm4ramRnamhid0VOVTN6ZlQ3ZTB5SWN4VWNscUxRbzhrT3FldCtvaVFXeGFV?=
 =?utf-8?B?Mm42VVZYK1FFVkR4ZEFWeDhqbzdKVXg3bFd6ckhMeHQyeXBUY2o4Mi9xdHlY?=
 =?utf-8?B?UWRhalE0Mmx1MDRRelhxR1RJRzVwVGhOeGhLc25IbU1FSlllK3NJVjJ1WWlL?=
 =?utf-8?B?ZFc4L3gzbnRCcDJiTTFqN0dtK1E4MjJhOUJBU1ZXdkk3a2xHblRmZjYzZ3Y0?=
 =?utf-8?B?UEdmazdoWnJuWWVmMVNIcXhncUloZXNsdkZrczVCK2l4TFgyTVlFMmYzSjBx?=
 =?utf-8?B?NkNGSU8wRVcxaldvZExnZmx6K3RmR1BUSWJvYlJ5aWhhTUxvSTdkdXY3ZlRG?=
 =?utf-8?B?UUJrSmN5OVlKMmJ3TUJjTENSUk5tWXIvS2N6WS93UFJ0clpOTk03ZUtnQ3Nj?=
 =?utf-8?B?UzdFREdqd0lSUDVOOHA4cjd2cy8rQU9rNDd4OHo5cWlEaXNqMlNGYlMyOWlE?=
 =?utf-8?B?U3BXaGtTM1ZITjZpMWpkWVhDU3J0dkVEdGQ2RStqak8vQXVIR0VlV2Y1dXVJ?=
 =?utf-8?B?U0xQcUtFQ1N6MElFajFCN2NnK0NyNFFNSFoyYUNiWG1lSkt1V1NSR3JkMita?=
 =?utf-8?B?aWRwRzRHRExQWjVRQnRVdUdhblFFS2JiTGx0NXdVamRBR2ZGYnljOFJpVWY5?=
 =?utf-8?B?REZrM210b0FyWFZiZjVhbERNQzdyZFVvclhPTVpvMzI5amV3ZVRmQTR4TCtS?=
 =?utf-8?B?OFR6M0EzYmZkNEwvK2lHTVc0S041eUE2anpMc3c2SVg0dlBGQlZYMjllYWU5?=
 =?utf-8?B?S0djclBibzExbDZVcFdKOU5tL3l2WWFwangzcm1ZY2I1TVlla3I4RVlRU0dr?=
 =?utf-8?B?eWl3cVUzM1lvNVJqaGZJRnZwOHVJdDE3Y2FWaEc0WEg1bFhjMnJPMkVvN2to?=
 =?utf-8?B?SmwzNmxlbTVQT09kTXArb3VKZVlVUWoxVjFzZXlrdy9hWElCWWZxQnE3VGxk?=
 =?utf-8?B?Qm9ZMm80MG4yNXZXYWo3dHpQQWNBV3lQWTdjdVJick1NRktlNjIwN1RYSWtn?=
 =?utf-8?B?ZW9aS3hPQldtV0ZleTlQWmxjd1E1b1RsbXBndmsvMzJsT0xFajdaR094blZy?=
 =?utf-8?B?VUQzS1dUUVk3R1Z2TWY4ME9FMlREV3FYMXEyWXJKemExcERyaW00RGdLTXFn?=
 =?utf-8?B?NUZyTEJUdWFTWXdadVpZaGZ0NWtZNVV1ajNpbk5oYkNDYzVDSjlPeFZIK0Rx?=
 =?utf-8?B?QkhMb3lJRUVaOEhaY1UxcXNXaFA0dmt5VnRybllJNGNuakpuQndGNW5mSXNK?=
 =?utf-8?B?eXp4RmxWbmR3Zjlqb0dSdWNpek9YdkZoY3FlbU1jdWVFczg2NWVnT0l1eWZw?=
 =?utf-8?B?NTR2dzZndXRRTjJ6RWxrbUxtUnhCSmdXL3ZsQXpNKzdPNitjSzZHMG5ERGVz?=
 =?utf-8?B?dzBFYXFFOG5yTzhpY1JYTmhRL1IzWGJjeWF4NTlMSHJQM21JcDRzMUNiaGZO?=
 =?utf-8?B?bGIwVU9aOTI2amN2QmQwaStoMDk3NXhGRGkwazY0MnRSNHBNcXp2Qml5TFBN?=
 =?utf-8?B?MDE4WVlVU2NXZUJWUHJ0c1loMkIrb0g3SGxLRTJKdlVUN0hjM280aTZLaFFw?=
 =?utf-8?B?dytyeTlVNktuUFRpVjhXYkVRUVlma3N3anNoYXkzODBRM3V4d1MrUGsveHVq?=
 =?utf-8?B?Q09ZL0RUTGI0YTZGTlFHZmY0YTRQbWxpcXY3MnBMRUlSa3YyZDB3S1o1Tk9W?=
 =?utf-8?B?K0NWZTd6by80Tmd5Vm13UTZnSWxkQ2E4WDJvczNnQy95MGFTL1IyYmRacTR2?=
 =?utf-8?B?KzdqY01kb1hSWFdGbGhORlhrS1pSU2xZdm9IRW1EZ2VDYXRieElVMWdXak5I?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24E4A1EAFA71B149A7CB458519209589@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mUywEEe416Vu8FwclzaS9i3sDnX2qan/+XqzT+Xcs6KoGHL4GoKLVfjHAt/V6/vXhrDJj3nm4G10jv2MlF2DaePdloXnluBm/ZjDfVHnosY79rUNTkwPg51/oHaS3D52Sid4c4F92qfgZJrqV12GMj6SuLUqBw78m1Mb1KL5DbhNIuGmSAUxD0qJxFK2TOdu0Zza15+emhamK45RPbbqfsedQgeI10DZownbll0YOBgX3Y1g9YT5oM5BNTOqlL/oDNrsa0zWw9xojxYjf2Lmm3QVWYbNDilzxq0F/m+sB+5YlrAmfaJ+AzhqMgGXlvzxxYGWOzrrPYwDVyVOqMzHZh4Kr2N3iYFYTAlTVpq/roRLdSjOFTdkTOMqFwHjZC17k1s8KW2BFiz/NKsxsd2NV4Xc3ud0TR4G3QNWKO+Lv13JoVy1FhwERkmmf/M9GXnuSD0XwsDmTXxj8YOiDqHUdss5U8g24IfzGuZqPxSoQ6fdaO7dB/oy/RHgLherfKjmwv+ae15use0Iy131NGP3KJpqlAKVoOtIpvgFVuKJrYT1cgXw7K2rzI++y/892RZQM74fdZ5YaNJB9fU5snLVNo/TtpVUR3wa4FTyhtAVnfxKuXUsuZHbGt97sskfpRypjeJ3hfM9zTpIKJmN6GEb3Jtjav8BoNjaARYndCy8Avu9tKdoCbcrpmUaVTnQduM4dPxONL90m96h1UwcWSGn0XUMeDgRSnrkapqyUwwI+MmDkScDWrlfQ2IEoL/ro/eeuZ7r7LUggZM4c1Yh0eafJo1vFz6hDDzaJrr7FuTwStpcVl3zvu1ZQU01V2vGLbYq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS7PR01MB11664.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 004d9a45-e418-4525-0699-08dbc6d823d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2023 01:53:01.8871 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gwn8ns7gYTbo5ZHhOvCudsaL9fsPr8/p43ASj1TrgWjtFOxOzd9oPCuiFCFnpn4ghfoSb002C8Hf800UgN8Ttg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8361
Received-SPF: pass client-ip=68.232.159.90; envelope-from=lizhijian@fujitsu.com;
 helo=esa9.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -71
X-Spam_score: -7.2
X-Spam_bar: -------
X-Spam_report: (-7.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.797,
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

DQoNCk9uIDI4LzA5LzIwMjMgMjE6MTksIE1hcmt1cyBBcm1icnVzdGVyIHdyb3RlOg0KPiBxaW9f
Y2hhbm5lbF9yZG1hX3JlYWR2KCkgYXNzaWducyB0aGUgc2l6ZV90IHZhbHVlIG9mIHFlbXVfcmRt
YV9maWxsKCkNCj4gdG8gYW4gaW50IHZhcmlhYmxlIGJlZm9yZSBpdCBhZGRzIGl0IHRvIEBkb25l
IC8gc3VidHJhY3RzIGl0IGZyb20NCj4gQHdhbnQsIGJvdGggc2l6ZV90LiAgVHJ1bmNhdGlvbiB3
aGVuIHFlbXVfcmRtYV9maWxsKCkgY29waWVzIG1vcmUgdGhhbg0KPiBJTlRfTUFYIGJ5dGVzLiAg
U2VlbXMgdmFuaXNoaW5nbHkgdW5saWtlbHksIGJ1dCBuZWVkcyBmaXhpbmcgYWxsIHRoZQ0KPiBz
YW1lLg0KPiANCj4gRml4ZXM6IDZkZGQyZDc2Y2E2ZiAobWlncmF0aW9uOiBjb252ZXJ0IFJETUEg
dG8gdXNlIFFJT0NoYW5uZWwgaW50ZXJmYWNlKQ0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJrdXMgQXJt
YnJ1c3Rlcjxhcm1icnVAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQtYnk6IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4=

