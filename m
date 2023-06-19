Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D44967359C1
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:37:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFzw-00064H-DG; Mon, 19 Jun 2023 10:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qBFzu-00063s-Jx
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:36:50 -0400
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com
 ([40.107.21.89] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qBFzs-0005AW-5a
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:36:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHbANZF4zG+jd+By/jlxL80L4WmMLvG3Q1o6XtknnpJrnPLKfws1YE7Qp+LWu7aJrG92KvrdTyGsWSityilc3XZsJMHqbhNgBkn5FzJ/b8bO7wWidm9yeY+wHH0AIq3yWWqwykAqcrmT2II6GLdH3cWiBgYiPhffF0MKTD5bVvdFMNlyaIDWbE3nlcrYp92zSwIPcXjJhkJxnnc/yULT1aMQq7xuGBotM0ZxyN4dABu2qwOAUrdyoL4QVPknnr3OXTUwvA53YsZ02hW3/kM8f7vfhuJh41dW9Wafl92DGOoB5lAd0fHb0vy/7+F6kanN0ewyriMszrMyYrgf4xFeTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAyUO4A6tvuPjioxm/MPI0uukUUMZUK8f/Z0vgH3bcA=;
 b=TYjjGbdEzlsFF/vqDvzJSgSyE+upSQYpk/vAfHJBlnAeOi7tzsOS2AVHT7F6Y4Cr3KnohXVlK3/in4JaAe/mnFl8PLgQ3+zvBRNzRY1Gq8fQNcddLVzZSW/jKYtsROnpTDeMsJGl528V/CupgjUMuru3SGiz/dx20gTBRlWTBxBsj9Y6zdDWqyOmU6AsPmlZm8j2tpyxCRl9O7SPWdM4WcroSAwJICgsrEKoprx0SqOOyhmEH8Y7Q40jr38tzGuAgOqNWtgf44HLXgMgPd6Hta3/Ur7WB4tUQ3qJ/hWN4Jbm6lBPkt0tNQVqZjPkubtou31/X9D6mvgeWoaMuf+q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAyUO4A6tvuPjioxm/MPI0uukUUMZUK8f/Z0vgH3bcA=;
 b=GrgsQ4HwJOfr/kZWfQqYIkZZmEEQBP12lGvQMNTofRvwPHNg0IA4Pq4bBMAlxjIOV51Qu+/woCWT5ChNBaIKknQH6u05QZ9o80tdYVBw3wVnviaMDDhQH8VucE+lzYK/Uy0YtgOzOufRO7UgcMv7XXnAlPaZGxpXDgUJmo7EADg=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 14:31:42 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b%4]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 14:31:42 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH qemu v2 2/2] tests/tcg/aarch64: Add testcases for IC IVAU
 and dual-mapped code
Thread-Topic: [PATCH qemu v2 2/2] tests/tcg/aarch64: Add testcases for IC IVAU
 and dual-mapped code
Thread-Index: AQHZnRIT+Q3bsSgiAEGp4LCUuTkqDq+SKQ0AgAASVYA=
Date: Mon, 19 Jun 2023 14:31:42 +0000
Message-ID: <185b0d737a18be5137e9443d317568359a0282ed.camel@ericsson.com>
References: <168656283612.26761.9869630057811681568-0@git.sr.ht>
 <168656283612.26761.9869630057811681568-2@git.sr.ht>
 <CAFEAcA-M=7DCRSONNFCdMGf_HjLV7V8-_NxL8_HnBXPOhSzuUw@mail.gmail.com>
In-Reply-To: <CAFEAcA-M=7DCRSONNFCdMGf_HjLV7V8-_NxL8_HnBXPOhSzuUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|DB9PR07MB7945:EE_
x-ms-office365-filtering-correlation-id: 8e828cc4-689d-4c4b-1a44-08db70d1e69e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tu3znD15MtH25ieJDrnJJWpIiOlxkMgUcnZi/JS/Dz7dZtmQcrHQn9yU0zXbSNqLzKug26bZqW1aVzIfdja34fKL3nhNliSnCkvImo6JcFJImc+3msjoeJwgSgvYa/PueOqk25EBJAIQqWZjGMCnLZpTm0h3uKBOFHVWSNU0qI1/9mUzcmJud3DsaQ9/YCce2A+3mLjxDaVtCxFoCrjHU4alfU5yvw7dDe4CQLTDNZaZ+/H/9xqdPfAQ2qtAQKdgWOfnS7jbvGohhZpN7zs9IgW4m/2JKNp4F3SXpuA+M/LU40aV0PbdKV9aR9C5ep492Hvc3qLsIjkcDP0ZQhTdx+6K7jcEtdYW5yDg5VoIWvUyqxtKwCwsl4BHYvgUgq7OxR2dM1SxdTGqeltXqx6eLbtvte5hqqwPe0hE8+WxNaM219q7WVvpO+x2Ppxf3hrtxFDl93xyGVwSHiMhCAGo5sMpo6zSajKALrqVlvTnwpmpOFT3FKvL2W8pvtQkecQ+GNb2s5RF+vJ41GyZ/v/8y4oDKe83VcWrwBEZlLGhfs52bGSnJ65DiiXMSPl5GxKdMEKGtikx/B4F8663GK6nLikqZVUoQAYyuDBxHNm92Dl/1Mb1b+yoWcPSG/1MxN3wQ+deqdqQzPkrIDguM8IkSTxPNM48UUJllKCJYm6Z6EA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(6506007)(85202003)(186003)(6512007)(2616005)(26005)(6486002)(36756003)(85182001)(71200400001)(83380400001)(478600001)(66574015)(82960400001)(122000001)(91956017)(76116006)(66446008)(4326008)(64756008)(66556008)(66946007)(66476007)(316002)(38100700002)(6916009)(41300700001)(8676002)(8936002)(5660300002)(38070700005)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bGVOQnJ3czRXR2tha0hJVUEybGh4L0N5d2hybXdYUXpHUENCYld0ejhON0c0?=
 =?utf-8?B?MjJJYTdpczlrdmUzRHhZTHE1dVlVSU90OTdndFU2cHU1SDQ4bUZlMTBvYkN5?=
 =?utf-8?B?cmNkM2x1YmZhS3BLK3RLSnlPWEFSY1ozQ21hK2JnM0l6N3lEMUUzZWFFbk1z?=
 =?utf-8?B?d1NFR2dlOXBDNWNFcUdMT3gvYjhJWDJxQTZmMlQ4ZDBJblBWb2tIekx0clV4?=
 =?utf-8?B?NW1wL0ZsZ29SMzgwWGw1cmdBd3ZseTZQWFpYZmZsTUFac1dHTndkQU1GTXRp?=
 =?utf-8?B?bkg1Z2dhNEdLSFYwTmFmUWlYbWRVZ0Zaa0ZFVHhXeUcxWmF5RGNIa3Z5SWVR?=
 =?utf-8?B?alJiK1JkYlA3V3hscHNUakxCVVFyem9xdmlOcllnaklZMkdJeGJkY29NQ1Qr?=
 =?utf-8?B?VFlMbzh1QnJtSDJzaWN2dGxOSlF0REVhTitjSEVyellQK1FBdFdaanhwYi9Q?=
 =?utf-8?B?emdlZU9zSGRKWUd1aHVXQkhzR1VwOFkzMng4Q3JhQ3Vzbmh0WWloTUZ3ZDBX?=
 =?utf-8?B?eXpJQVZHTGVsdTFSSnUrR1h3RXQ3aW0rYk1weS8raHFOaGhDcnM5WVNGdHFi?=
 =?utf-8?B?RFJlaDRiWUJGUUxETkJQUExFOWN1NlZlTGdDMGdONW5YeXloUFB5MlB3VkxT?=
 =?utf-8?B?MzZHRDJDSnJlNXdtWWNXV2JOdlBQYm9jZkk3b0gyNlQvbnJ2WjQ3KysvYmZK?=
 =?utf-8?B?QnZXUWlsVDBPOEdra0Y0YXZFWmYxZTlTbGl1K1VlbmVvdFBldnppdUxNejI3?=
 =?utf-8?B?T2VsaSswWStEQTdHVEtlS2NOT2hFNG5LdDFTUHlOSm8wa1ZLWnQwQWdKdEhJ?=
 =?utf-8?B?TXZPN0xmaUZNeitsRnE4ODBia3doMHlISE51cW8yeXJmSnlZdXAxQzlNc1JT?=
 =?utf-8?B?YUoxYlZ5YkNwVnExZVY0R3JySGUzRGVBZHZ1YzMya3FDM2ZyTjVqVUl1NjJC?=
 =?utf-8?B?UzNUWW1pMlZjTlFoMjNrWktoMUNZZW9zbHQzeTRHdFl2czVzVi9rMjBVZ0tz?=
 =?utf-8?B?TzBqREJkdmJtelBkdXc4UTZrYUtwUE9qekhBc3p3cDRNQXQzVnVCK256aUNI?=
 =?utf-8?B?VythMVlDOWFmYWlQTHlOQVgraC8renR3QW9MV1hWRFhFaGxXbFNjUjVHdXhH?=
 =?utf-8?B?Y0p1QlZSRnA3cjQ5VmNlNyt0VHF2L25FQkNNTUlWdVloYWxHN1FYSkFZLzVt?=
 =?utf-8?B?ZFdyUW5FNGd4VzNHeUNKVUlnWEU0cUo3UkM1alBzS1hjbS90TFl1ZTZvbnF6?=
 =?utf-8?B?Z0MyeDhPRjFXTEhYd1lSeTB6T3ROVGl0alRyZUJuWjFrOGs1U1FzYkhCVXhz?=
 =?utf-8?B?aEhDS1Q4QkNVejBxL3VUcWU1U1IyNGdWbWx2aHNXeGRIaE5IdDF0V0xmbjQw?=
 =?utf-8?B?Z0MyNi9tTFNPbW0veHBaZVQrK2I5Z0FrQVl4NE8xUVdPRk9YWkRFMk5WZFEw?=
 =?utf-8?B?Z1IrUVVheVYyRnBDMnhkL2o5bGR5dWpSNU4yR2R6QnhOaVRPbDZEaEtFS1Js?=
 =?utf-8?B?MXJrKzFCOFJLYXh4RkJWbjc2TVVUSHdTVjZYdk9LaG5iN3lSc3RGcUxlamNj?=
 =?utf-8?B?Q1RJbm1zZEtRLys0VGlsSGdrU0NyTEZQNG0vZDljUG80SlU2a0lObkVPeW85?=
 =?utf-8?B?SWtvS3RlVDZtQ3JLR2R6WDlkZmNzZ2ZlZ2RNWG1lRkhSMythTCt2UkpQZDdi?=
 =?utf-8?B?U1VIM0s4L1h4SElnWmdranhhdFg3c1ZnWE9wbDAzV085MDlBbElPT1dLeVBi?=
 =?utf-8?B?ak1uVGRCNzVDMlIyMDZVVnZZdGJlYTlVeXh2SlRVeEhhbXo1Mys5aHovVkJh?=
 =?utf-8?B?SktYNmxMR3VoRFdPVURWb0dLczF0RmR4cW5kWmc1Nm5zUTAxZVNpcHhyOEZ2?=
 =?utf-8?B?WTdxNk1LQVVxYkNiakNrQkZFOFI2bDhLU3ZZdFh5RHphdDB3NHhCby9kQjV1?=
 =?utf-8?B?TFc5c1pvK1lpUnhkNyt3N29TS0ZDNkhncVpRNU4xQ0FieUE2U1VHWXhRVXls?=
 =?utf-8?B?emEzbyt4aTdFcjAyR251bk03QjA4SkZ5bDduQmxmcEdsajdTZGExMmdPUmxh?=
 =?utf-8?B?enk4cGJWdG05RnpVc2ZYeHhmK29vZjFjb1NydUVxcTZaV1lkV0x1NVAzRnR4?=
 =?utf-8?B?dEFOS0wzcFpwSEdtM2pkYmdMY0N5RWFiSnh3SGpCRXFoamVhRTkzenF5L2g5?=
 =?utf-8?B?SUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4423181E75D8C48BEF8421303341002@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e828cc4-689d-4c4b-1a44-08db70d1e69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 14:31:42.2179 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1WcAUv4nsZiMx1oafsaYogLAF87rT36gcS9Wjtio6mTt/8kkaBGNmp1/x0jKIaouXIUmTkd031qpmSIL1GRyCsmr7X9cGdE3AdPEim7h8F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7945
Received-SPF: pass client-ip=40.107.21.89;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

VGhhbmtzIGZvciB0aGUgcmV2aWV3ISA6KQ0KDQo+IEFsbCBuZXcgc291cmNlIGZpbGVzIG11c3Qg
c3RhcnQgd2l0aCBhIGxpY2Vuc2UtYW5kLWNvcHlyaWdodA0KY29tbWVudC4NCj4gLi4uIHNuaXAg
Li4uDQo+IEdlbmVyYWxseSBpbiBRRU1VIHdlIHByZWZlciB0byB0eXBlZGVmIHRoZSBmdW5jdGlv
biB0eXBlLA0Kbm90IHRoZSBwb2ludGVyLXRvLWZ1bmN0aW9uIHR5cGUuDQo+IC4uLiBzbmlwIC4u
Lg0KPiBZb3Ugc2hvdWxkIHByb2JhYmx5IG1hcmsgYWxsIHRoZXNlIGFzbSBzdGF0ZW1lbnRzIGFz
ICd2b2xhdGlsZScNCj4gdG8gZW5zdXJlIHRoYXQgdGhlIGNvbXBpbGVyIGRvZXNuJ3QgZGVjaWRl
IGl0IGNhbiBoZWxwZnVsbHkNCj4gcmVvcmRlciBvciByZW1vdmUgdGhlbS4NCg0KR290IGl0LCBJ
J2xsIGZpeCB0aG9zZS4NCg0KPiBZb3VyIGFzbSBjb2RlIG1heSBiZSBwb3NpdGlvbi1pbmRlcGVu
ZGVudCwgYnV0IHlvdSdyZSBjb3B5aW5nIHRoZQ0KPiBlbnRpcmUgZnVuY3Rpb24gaGVyZSBpbmNs
dWRpbmcgdGhlIHByZWFtYmxlIGFuZCBwb3N0YW1ibGUgdGhhdCB0aGUNCj4gY29tcGlsZXIgZW1p
dHMgZm9yIGl0LCBhbmQgeW91IGRvbid0IGRvIGFueXRoaW5nIGluIHRoZSBtYWtlZmlsZQ0KPiB0
byBlbnN1cmUgdGhhdCBpdCdzIGdvaW5nIHRvIGJlIHBvc2l0aW9uLWluZGVwZW5kZW50Lg0KPiAu
Li4gc25pcCAuLi4NCj4gV2h5IHVzZSBhbiBleHBsaWNpdCByZWdpc3RlciB2YXJpYWJsZSBmb3Ig
dGhpcyByYXRoZXIgdGhhbg0KPiBoYXZpbmcgdGhlIF9fYXNtX18gcmV0dXJuIGl0cyByZXN1bHQg
dmlhIGFuIG91dHB1dCA/DQoNCkdvb2QgcG9pbnQsIEknbGwgcmV3cml0ZSB0aGlzIHBhcnQgdG8g
YXZvaWQgdGhlc2UgaXNzdWVzLg0KDQo+IFRoaXMgaXMgYSBRRU1VIHRlc3QgY2FzZSwgdGhvdWdo
LCBhbmQgUUVNVSBkb2Vzbid0IGNhcmUgYWJvdXQNCj4gY2FjaGUgbGluZXMgYmVjYXVzZSB3ZSBk
b24ndCBtb2RlbCB0aGUgY2FjaGUuIFNvIHdoeSBkb2VzIGl0DQo+IG1hdHRlciA/DQoNCldlJ3Jl
IHRyeWluZyB0byBjYXRjaCBjb2RlIG1vZGlmaWNhdGlvbiB0aHJvdWdoIHRoZSB1c2Ugb2YgaW5z
dHJ1Y3Rpb25zDQp0aGF0IGludmFsaWRhdGUgY2FjaGUgbGluZXMuIEkgd2FudGVkIHRoZSB0ZXN0
IHRvIGNvdmVyIGludmFsaWRhdGlvbiBvZg0KdGhlIGNvZGUgdGhhdCBkb2VzIHRoZSBpbnZhbGlk
YXRpb24gaXRzZWxmIHRvbyBhcyAid2hhdCBoYXBwZW5zIGlmIHdlDQppbnZhbGlkYXRlIHRoZSBj
dXJyZW50IFRCIGFuZCByZXR1cm4iIGNhbWUgdXAgaW4gdGhlIGRpc2N1c3Npb24gb24gdGhlDQpi
dWcgdHJhY2tlciwgYnV0IEkgY2FuIGNlcnRhaW5seSBjdXQgdGhpcyBvciBleHBhbmQgb24gaXQg
aW4gYSBjb21tZW50DQppZiB5b3Ugd2lzaC4NCg0KPiBUaGVyZSdzIG5vIGd1YXJhbnRlZSBvbiBh
Y3R1YWwgaGFyZHdhcmUgdGhhdCBvbWl0dGluZyB0aGlzDQo+IGZsdXNoIHdpbGwgY2F1c2UgdGhl
IHRlc3QgdG8gZmFpbC4gVGhlIGhhcmR3YXJlIGltcGxlbWVudGF0aW9uDQo+IGlzIHBlcm1pdHRl
ZCB0byBkcm9wIHN0dWZmIGZyb20gdGhlIGNhY2hlIGFueSB0aW1lIGl0IGZlZWxzDQo+IGxpa2Ug
aXQsIGFuZCBpdCBtaWdodCBjaG9vc2UgdG8gZG8gdGhhdCByaWdodCBhdCB0aGlzIHBvaW50Lg0K
PiBTbyBhbnkgYXR0ZW1wdCB0byB0ZXN0ICJmYWlscyBpZiB3ZSBkb24ndCBmbHVzaCB0aGUgaWNh
Y2hlIg0KPiB3b3VsZCBiZSBhIGZsYWt5IHRlc3QuIEl0IHdvdWxkIGFsc28gZmFpbCBvbiBhIGhh
cmR3YXJlDQo+IGltcGxlbWVudGF0aW9uIHdoZXJlIHRoZSBpY2FjaGUgYW5kIGRjYWNoZSBhcmUg
dHJhbnNwYXJlbnRseQ0KPiBjb2hlcmVudCAod2hpY2ggaXMgYSBwZXJtaXR0ZWQgaW1wbGVtZW50
YXRpb247IHRoZSBDVFJfRUwwDQo+IERJQyBhbmQgSURDIGJpdHMgZXhpc3QgdG8gdGVsbCBzb2Z0
d2FyZSBpdCBjYW4gaGFwcGlseQ0KPiBza2lwIHRoZSBjYWNoZSBvcHMpLg0KPg0KPiBTeXN0ZW0g
bW9kZSBRRU1VIHdvcmtzIGJlY2F1c2Ugd2UgbW9kZWwgYW4gaW1wbGVtZW50YXRpb24NCj4gd2l0
aCBubyBjYWNoZXMgKHdoaWNoIGlzIGFsc28gcGVybWl0dGVkIGFyY2hpdGVjdHVyYWxseSkuDQoN
ClRydWUsIGRvIHlvdSB3YW50IG1lIHRvIGNoYW5nZSB0aGUgY29tbWVudCB0byB0aGlzIGVmZmVj
dCBvciBjdXQgdGhlDQpjb21tZW50IGFsdG9nZXRoZXI/DQoNCj4gSSBkb24ndCB1bmRlcnN0YW5k
IHRoZSBwdXJwb3NlIG9mIGFsbCB0aGVzZSBmdW5jdGlvbnMuDQo+IEkgd2FzIGV4cGVjdGluZyB0
aGUgdGVzdCB0byBiZSBzb21ldGhpbmcgbGlrZQ0KPiAgKiB3cml0ZSBpbml0aWFsIGNvZGUNCj4g
ICogZXhlY3V0ZSBpdA0KPiAgKiBtb2RpZnkgaXQNCj4gICogZXhlY3V0ZSBhZ2FpbiBhbmQgY2hl
Y2sgd2UgZ290IHRoZSBjaGFuZ2VkIHZlcnNpb24NCj4NCj4gSSBkb24ndCBzZWUgd2h5IHdlIG5l
ZWQgZm91ciAiY29tcGFyZSIgZnVuY3Rpb25zIHRvIGRvIHRoYXQuDQoNClN1cmUsIHRoZSBzZWxm
LW1vZGlmaWNhdGlvbiB0ZXN0IGFsb25lIHNob3VsZCBzdWZmaWNlLg0KDQpUaGFua3MgYWdhaW4g
OikNCg0KUmVnYXJkcywNCkpvaG4gSMO2Z2JlcmcNCg==

