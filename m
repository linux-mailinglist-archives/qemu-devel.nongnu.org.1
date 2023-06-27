Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA173FFA9
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 17:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEAcY-0000RE-1M; Tue, 27 Jun 2023 11:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qEAcV-0000R0-Mw
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:28:43 -0400
Received: from mail-vi1eur05on2051.outbound.protection.outlook.com
 ([40.107.21.51] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qEAcT-00014T-O7
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 11:28:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQ0K5IGV3ysKJ2Y1H3EZG2TCdYtiMpsQp0pGt+D/yEYIPA4Os0rf1JQuhN8AvN+D46mURiaYqpzjImN/Tef5P1/xJt+IjSi93f8bBK93jR3qB/H7tJXjNrFXhO+IIUyNtO4AEOUr74q7tqppNqD115Vpxn77bbzgzJKCwz6oM6shEWVeHwatgZLAApd7xSBDPwsvZ1dCPvt08mlKz75ymbHl1nJkAXX0wIom9C5qVyRDL2Jx9gpZKqcABkDCn4+mwZ/g3da7+3I04uHk5yqbYS1kf0A2h+WQNQWO8ezn4fLzWxmfBskduJ4voP4SHRSejYKxz874bEppTITWvxUKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28Aq+DQRxPScEcjGpEOscVrzDZhuA8NDWCjy5tevxu0=;
 b=Fb76YBvjwigrZ6J5uH6nDUGz87sAxLvu8s1CjvTEg1AU+9jmaq7xGWzrd2g+IDFQBbssVRIIpwwQT3LEhVckU8M0bIlFUiACjOAIopnHJ+R/kT+Veu3DDlMyjwEobu9ogGogHL2RLTv+89/0huf5c4cAq/gC7cZLKmIcE8kTuRlShjbVprUphjUyZLzaxpalGvZt9iW41oXnIm5JS0mRC8wCgbcSto4WQUhimvLtinynD1dQumoq3EgoVxhAp7q4MJkmcn6MbD3FZndvxC2ZWgkuFnmfnJ3Lzud5x9AoFXVakoLsqahOs0nMehVuu3Lxxy5zlsUoDBywam1k43H9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28Aq+DQRxPScEcjGpEOscVrzDZhuA8NDWCjy5tevxu0=;
 b=iZqXGqUK/hM5lHA4+8ekMex35ZtGFsTvw82nMxInARe+graQsC435BxPXi0/Wv7yc6LDxFeZj2Tc2vO6sjYhaLr7VnhDFCIx6pOTc8pgBLIIozP9XmrDXqmxZ5oLdQ/6qS2L3SuQbl5wankoE9TyldfT0z201k/qUmnt9T9v65I=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by DBAPR07MB6679.eurprd07.prod.outlook.com (2603:10a6:10:180::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Tue, 27 Jun
 2023 15:23:36 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 15:23:36 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH qemu v4 0/2] target/arm: Improve user-mode compatibility
 with JITs
Thread-Topic: [PATCH qemu v4 0/2] target/arm: Improve user-mode compatibility
 with JITs
Thread-Index: AQHZqDi3oRwEmJFcwEKOOHlcaapj4q+ewG6AgAAFzoA=
Date: Tue, 27 Jun 2023 15:23:36 +0000
Message-ID: <4327533e56d6d03c2b04d9acf3eecb00dc4f44d0.camel@ericsson.com>
References: <168778890374.24232.3402138851538068785-0@git.sr.ht>
 <CAFEAcA9zpLBbTSnhvQ9+1o3n4FEnjkDAYm5ZF9NZ0JOJ05MDEw@mail.gmail.com>
In-Reply-To: <CAFEAcA9zpLBbTSnhvQ9+1o3n4FEnjkDAYm5ZF9NZ0JOJ05MDEw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|DBAPR07MB6679:EE_
x-ms-office365-filtering-correlation-id: 91c670d8-8260-46cc-ed9c-08db772279de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+268voF+Fcyt/ejG3SYs83nGrKbPvXCH6tEVUFcbEJSePMqyakW5nvafbx9G0yWbi5YUBGWPysuM1e1mBwtUSqrmidmZizBOU22mzFjukIgzfszCQ8Okw/MEWZCu3YdyuMYq24SHyMhyVbVKhuU9rkYLrgXs5odu9MW/nefKFnYNG6qBV4Lg/DGMI6XWCVcc3z5vFx0DvQdm2Xea6DEQs+DKWyJ31TXh4Tjg8JmY2XSFzVt3Xj9Pq2d82EUhyHF/fUR2K2gZTOyirVxiMUpMZl5idcScxq4l7SeAlE+ob9gYdU/ZYMnWR35m7nxfO17Pd4r2+sEx+ymG+9IZONi2HK924kqAqLGsbZys8qLDzVjsB3XcWs97WAvtCOHyeN5d+/8/agveGboDlGe6HkThR2u7gVc1vqBrV4H24n88XTk8VauQc3fIv/wxrIW32DZkjVMI/hgp2IV0J/gyaVS6LsAYPkVkyvb1SLdqnu0QmRC69Wy1oWWrNYye9R77sLO7Agro56cULlcETOGTnFGhZ9ltCTxU3xLg1C6q1+/P9RdQto5TD2eGzmbETXXBr9JC4UGmvc2pqDzc0tUod80LQ/zisWNuRd67R1e49dpf6J0AoN+A9bBuQEn3MOeSvr6sr3xN4ulSbOidZZ2b9AkDlYdXPDiLzJbHl3KeymH0N4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(26005)(85182001)(36756003)(85202003)(6486002)(478600001)(2906002)(2616005)(71200400001)(6512007)(186003)(6506007)(5660300002)(558084003)(76116006)(6916009)(316002)(82960400001)(122000001)(38100700002)(8676002)(91956017)(41300700001)(38070700005)(8936002)(66556008)(66946007)(4326008)(64756008)(66446008)(66476007)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qmt6Q2o2VDF5a3FTaUptbDMxdTk4cG5qbWVtMVNkUVNJNU1mNE9XY3JGbUo1?=
 =?utf-8?B?UnZZKzdDYlF0ODlVU1UvYWtUTTNmTVN4TTVvcVpSWHpsVWlmM2wyS1FVTFVO?=
 =?utf-8?B?YUtPaEQ3VlpObTg5bmlDSnYvYVJTY1V3UU1maDVHZlg3Wit5OUVEV3RUMHBH?=
 =?utf-8?B?MlVzcEZkTjQxVDYxZEtsZGdBVzczb0tPV3pDUFM0aTU1blVlaEhEWExmRi9Z?=
 =?utf-8?B?SHVDaGcyVTZSenI2UDJTak5TVXRMeGNsNS9iSXhrdFQ2ZUl2YVVxSUhscFcz?=
 =?utf-8?B?c2xUckdGcGl1RjIyMldoWVdxY2ZFclpvK1BQU0VrdzBENmZxSG52MlpqSDVy?=
 =?utf-8?B?QmJ5SkxBNTJtay8zMEVnd3RqclJDQUtlZ1pmZVRTbzhMSEN4TjZMbEtoVDFB?=
 =?utf-8?B?RDZkOEpKaGgyMURObDFPUHFaL01YQ2c1cFNQUHdDeWlWZGRBN1pPZWluR05V?=
 =?utf-8?B?dDk1UFloSVc3ak1NM1hxYytNMWNZMEMvUEZYQksrZG1JRklaeTk4bXVZQmhS?=
 =?utf-8?B?RzFaZnhLTXJpVExmN1ZpQm9wSDVwWVVBNGw4Mml6aUhxbnJSVm56S1hrR0RJ?=
 =?utf-8?B?M2QxcWFHMlRHYWFycjVoWHBsQzdodkNDd2I2T3NyS2t5MFo2UTR5bVYySmFr?=
 =?utf-8?B?Y2NQcFBkZHlIQmRsbWJDUlYyT0tNS3JwYlNjNGdpaC91WFljdUlMTFhNRnFD?=
 =?utf-8?B?UGdXbUdJeDdXcWxiN01WditocVo4cVpBSU5BcHlvc0dSOHVha3hIVVJPMjFu?=
 =?utf-8?B?V3hIRlVLelUvVE9ubnAyZVRISm5JVTN2VXQ3Q2xxcVNjSEU4N3VOeVRpSGpW?=
 =?utf-8?B?ekZnYmJqcEtmZlpGOThtRGFhQVRHd3dTM3lTNWsvWXpMSnYwL3ZwOEV1L0Na?=
 =?utf-8?B?aEkrdkFMMVhPQ1dMM0FyOUJQQWdpQThnWjZQalhlVlR3TmRKS000MExVMkJZ?=
 =?utf-8?B?Tzg0RFhqTGxXd0hzbmhyelRFOTBRby90YzRvRGZaTG15UW1sVmRsdHVObFkr?=
 =?utf-8?B?ZlhPVStZNUp2bHZiSzkxNEVGS0NjUk00a1g5c0pha3N3ZHF5S2RrNFUvOERH?=
 =?utf-8?B?VUxBQnZzRno5d1JFNjJpWmYwQXFCTW9TRnlJOGFTaTlZVkhqR0JkRzJjTnZp?=
 =?utf-8?B?SmhFSUYxb2d6My96REx4SFhnRTFES2NFeVpMTE55NkY4cGRoYi9kYy9RcWJq?=
 =?utf-8?B?N0xrZUNQNHhIUkgrUTF3YklGbm9ndUl1VDRxV1FDeStvRmNMVVltSVBwRnVQ?=
 =?utf-8?B?RldCNm55SE16L2Q3aGpDU1Viak9SdE1WMGdtenl4TEZlNnVER0UxSFN3UlhT?=
 =?utf-8?B?d0VMZU9VNU5qNnhKc1V4R1VVUFkrVHU0T2hVTkJ2bGN6V3BUUVFvVFI5aUZE?=
 =?utf-8?B?blpNNXpIZXRJclpMUkZCdkx5OE5mUDVmRFlQLzJnSFQreElYR2hiajRNckdU?=
 =?utf-8?B?alVUc3ZaVzhrYVNCYXZSclc2TTFFR2RJWktibzNqWlk3WEN3TU5pSzh3VERM?=
 =?utf-8?B?T0JxSGVOK2pIVEtkOHRqaUYwS2dZckVwdCsya015UjFxWjBTalFPTmNEdkoz?=
 =?utf-8?B?MkVHV0hMN255RDdFRVd4SXZEbVRaaW8rQkErbFVrbzkzNXdpWURIOTR2dUNV?=
 =?utf-8?B?QnJwTjl4cjFESUdlQzJPWGRTNUVZVG9tNytPTlhmZGZMcWdzdEVKVFlNb2NO?=
 =?utf-8?B?amkzVDVtYm5taFdtZ1BuMW5DeWJmSEJFQUVHaENYTEZVT0tOV0pEN3hvTTkz?=
 =?utf-8?B?ZFdwaFl2bHZxVmV0MFhBb01vMjlkM0xjZVVpWW5UTUVjOFBiVjNvNTlVUkpB?=
 =?utf-8?B?RGo1NzUzRjY5bjJ0cmxFV0VWVzBoR2xDQ0Y5TnR3MFZHY1U2amxJT0E5dk4y?=
 =?utf-8?B?eDcvOEpzc2F1V2ZZeTBsUnNrVkJmUWF3cE1yeDQ3RHF0QW9QYVdxbDBDaDVE?=
 =?utf-8?B?UC9YM1BkKy9Ma2s2WnQvaDFpanlMUHVvNWdmMDY5K29nQjVuLy9OVUpmRHBJ?=
 =?utf-8?B?OUN0Q2p3U0tZSlNxSlZyUU1ONndILzVsRjBwY2o3Tk1PZGFEbzRBUWU5cjNu?=
 =?utf-8?B?QU1senZXQVRna0xrTnNlc2FXWVBSRmwyU1g2NGFaeDZaNXZubW8vWDBsd3lh?=
 =?utf-8?B?MDZRaFBFdVhNK2x6TlZWcUo1N1B1ZWFpMndlY2M1MGUxbUMxOS94ZkIvNUtQ?=
 =?utf-8?B?TVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D39A085B430C64EBA4D659974102404@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91c670d8-8260-46cc-ed9c-08db772279de
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 15:23:36.0128 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnvDFV/bZP0nweYbpngM8MS68YeWBwzG5fkwM0wb83F2gyvBez+VEXlkltwz9R57b1bxWViQw37jcrizHJnEnuN8O8+4xbiSiiK91Zhku9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6679
Received-SPF: pass client-ip=40.107.21.51;
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

PiBTaW5jZSB0aGVyZSB3ZXJlIG9ubHkgYSBjb3VwbGUgb2YgbWlub3Igbml0cyBpbiB0aGlzIHZl
cnNpb24NCj4gb2YgdGhlIHBhdGNoc2V0IEknbSBnb2luZyB0byBhcHBseSBpdCB0byB0YXJnZXQt
YXJtLm5leHQNCj4gYW5kIG1ha2UgdGhvc2UgZml4dXBzIGluIG15IHRyZWUuIFRoYW5rcyBmb3Ig
dGhpcyBidWcgZml4IQ0KDQpHcmVhdCwgdGhhbmtzIGZvciByZXZpZXdpbmcgaXQgOi0pDQoNCi9K
b2huDQo=

