Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377E821790
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 07:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKXqR-0003hj-UZ; Tue, 02 Jan 2024 01:01:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rKXqQ-0003hY-4G
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 01:01:42 -0500
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com
 ([40.107.94.102] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wentao.jia@nephogine.com>)
 id 1rKXqO-0000oW-4r
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 01:01:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5A6hW5ZIMJePQQKVfOLWYBlGxGTkKLHh/G/uk8E9k4ILta2lm+nU0cNbbh9T32d9tnurjmjvJxuIEpSNEVft8RDyWAydGs6QeuCOE1HSbCm3puG2Dq0B4mJVtEvhJY/biqe5yVtYIm4iWiQ30aK29ojO7cFL119qOKWTcQY/HsjjlAGAssJQn5435TRJ7bVNSZMqEmLgSPEVcuwLGBTLCR7TIqdNjGJLGBioOcPQ6EbKKhF7awABkfw8+YcQ/2ZLl5zQOvvl3zP+8xKBWZwR27ydpp/Xx8bJhtw+X0pJqGW9n26hwV4BRIku30kdL0J9sCYy8Aj92RR8aQ61fOJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1f4suWV2UeMeIClS7Y/0xPjMsgxDAYOUABwYobhGX4=;
 b=HsxLURkNCRTvzuAdABXGoGvMc99uIEo6IItGIPlmnp/0q4ulBzx70rUq+AKRDfZtltFC6MSvrk5X0ZzgsW9X2BAWufbjrHMLEEbTjTylJnMzfjf+GBz8gKSvLyG7jBP3zkfndawz69XaO1I3BM1hcOxPQhRs+vXIZUN37sqH6CjyzBcBBLOJPEm8SMEVTvzECtgVdrvfntNpB7kC7JBZvfxmyHgoo86Wi7UVIbHP7AV065I7zAi5WtMWm4xw4qMgvnfs6lBVKQzEEQ2qLs2A3tYV5iwqTbvHzHDYQLoG+ofoMTIzJayEDu/sn2C7TUZnZ1TD1H7419SahQbgA1+dUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nephogine.com; dmarc=pass action=none
 header.from=nephogine.com; dkim=pass header.d=nephogine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nephogine.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1f4suWV2UeMeIClS7Y/0xPjMsgxDAYOUABwYobhGX4=;
 b=HZ1dQGy7gMBMR6Z3x/EMF5nRmVKYLS4zlnjKlkfjGbkZdP9thCS8y7EtueVc+cIC7guCpUOX2h6z3zZBAoGnu85kyoRFegGMyOVGAa7CUOTlBcQdFOq0Iqn0m1PRpCeBO735kuDoDrdrvxo4HYoDtZVo6iIW+MQiO7O5f1JXVarUrWjuOvo7ST7wgG5BmHX6eraUQ/ao2TI1E10TJ+vQENxiWEktTAFPls0Wm3bLVfzqelO0G0jVamIv45HJLFxbmuZvFSyzht8X4Xfx73Q5GG/keijUVlJ2F4qXMzOhBZ7w8WK1pcNoLa96+kOxVdEnvKADT2VbqRNclsmzDR2GPg==
Received: from SN4PR13MB5727.namprd13.prod.outlook.com (2603:10b6:806:213::12)
 by PH7PR13MB6392.namprd13.prod.outlook.com (2603:10b6:510:2e9::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 05:56:33 +0000
Received: from SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350]) by SN4PR13MB5727.namprd13.prod.outlook.com
 ([fe80::4ae0:9319:cd44:9350%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:56:32 +0000
From: Wentao Jia <wentao.jia@nephogine.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, Rick Zhong
 <zhaoyong.zhong@nephogine.com>, Jason Wang <jasowang@redhat.com>
Subject: RE: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Topic: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
Thread-Index: AdokPrZLsAJfb0btQhCy7EbMDce/EgY4mSYwAAJ9PgAABGqn8AAAz8yg
Date: Tue, 2 Jan 2024 05:56:32 +0000
Message-ID: <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
In-Reply-To: <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nephogine.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR13MB5727:EE_|PH7PR13MB6392:EE_
x-ms-office365-filtering-correlation-id: c2ffd10e-4693-4d37-b987-08dc0b57927f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ofZgUG8XcdMGji5qbKUBN9ovIzEmqTwKKSlqRLPFNne7q4vsWf+B1td4sJS2rUPhdRWkdEF1xn4KpJq/QNRv5JbnsynCNA6sM7fTQByGkF2aRJmg8GSG5qdvh+oILH3cL2zMvCOo2G2nlmeCmA7n7eqcsG4ZOy8P8dFScaM1s3lrvnk3GttosLIdSAlQ91AvQ8hDSn0mYA4HC/sqrUfcKcie0iVC2VIHbnqSwA9NPixnZ5J82/OnqnvdLHD2EI+tHharmsTQUXkNTiAsR3/VDafy2twqSNJd7akFBrr9HgrMlH1bcSN54KvkKQRaQCQMs9fponus8bQ6QOL/mUP1vELq9GKVoZ+2G21tdUmVwK39/uofUrRetsa0QgweMB1qD1ZT5V/FSXFNY82UTHELEDFFpKX/0F9lLocyU3nxQ350VQX8OUVwQ+P7g8237/58R+KO1dDZaBAaPoNcrg4l1M26rrYZuD/reNJA5EPQmkP0dxD8ohu1jasM16MB/An7AwEIqGx8mrJ0eW47BV0gfXX0WR8xsKhg03vCGvu3CSSTdr8KqeiqVYPWQBa/gcPYsWhHXKxtwnlE7wyLS5kDlILDSyQaVmdgptMXuijwBMrVJbKn0BoemuV6CK9mq1RQ3p9ZDy+0V6irwh08+99fwGN7ooYPviM35n+6vVUiTKs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR13MB5727.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(346002)(136003)(376002)(39830400003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(26005)(83380400001)(6506007)(71200400001)(2940100002)(7696005)(9686003)(53546011)(122000001)(44832011)(5660300002)(52536014)(4326008)(41300700001)(2906002)(478600001)(316002)(6916009)(54906003)(76116006)(66946007)(8676002)(8936002)(64756008)(66446008)(66476007)(66556008)(86362001)(33656002)(38100700002)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVZyRVZrNW9wNmduSW9NNlJhSGZZWGVHYjFtMDJsamtOd2Z1Y2JUWUxSakhu?=
 =?utf-8?B?WUZXcXhXSEVrd0RjejJnVG51eUZaaTcyaXNzVkpUYXdLV3RmYUpEdDZtaXp1?=
 =?utf-8?B?bEVuNVVSR2tTbmZ6SkJHMXJxL3Mra3M1UER1bFJ1eXVMQXFLMnJLdThYNXls?=
 =?utf-8?B?dGpGdmlsanhuYTVaOFAvaEdIV0JqVGI5aTI5YjNQVkJnajZqYUF3Uy9tZGpN?=
 =?utf-8?B?VGlTVWJaamZaZ0UzZjFldFpZdGJkUURBWVZERzhrUGFhZ0V3SEIwVk9uVmxj?=
 =?utf-8?B?MU5Ia0x3Q2NBUjFnbWFxY2VsdmRYTFV0Y0hOUC9oK0U2dEFTUFQzTE44WHVB?=
 =?utf-8?B?cmxBVENrWGtOam1kdEpvd1RBRERGajlnT21raHI0WDVvWHdMK0t0SktvNGc0?=
 =?utf-8?B?aktRYlRuK1JTbVZQZEltOXB5YUVFWVczVldGZlFrNEs3ZUxsQ3dBMUhtYlgw?=
 =?utf-8?B?Z1pMb0lTVG1BeUNxbzJLeVkwcVRZbS9BcjhvMU10dFRVSkh0dVViYzkxM2Zi?=
 =?utf-8?B?WnBneVZtbVR4VGg1VWxjVHpyRkNrQVVnd0IyQmIzMEg1L0VnYnk5NWNBeHQ0?=
 =?utf-8?B?MWhQaEppR2RiSGxYRmk1TTQ5bnpFeldiTjRBS1dZVExHUGZPZHZRa0kzS1F0?=
 =?utf-8?B?aHBkSFphbTFxOHByeHNJQXhMNGhONkp5VTF6OEFxbWNDMXVjRjB3MjQvT3Jk?=
 =?utf-8?B?ZlkvSXdMaE1Takp2UFZXQ1g0NEZVWkxoemh2RE96YWZZQ1hZdjBQY0lHdldo?=
 =?utf-8?B?MHlHNnJKTGhpOEhpVDNJT3hZM0MwVklDc3NBYnAxZTVvUTByQ1pjWWtvOGtm?=
 =?utf-8?B?REFSb2dHRkI3UzlMaVVaRDJtb09oSGpQR2Zna0pySWNCK1p4aE1aUTFBMDNq?=
 =?utf-8?B?WVVRLzVsVWl0NzdnV2tuU0srbmRsUURsc2xFeFJPMk5UMVpnQW9hS2FlY1JK?=
 =?utf-8?B?WSs3bERodkkzbTZ3dml6STFrYU40bHJsTmJNd1B5aVRmeXl0Z0oxUXFmczJP?=
 =?utf-8?B?cGFiRTRsb1R1ZFc0cStRakdwZitUSlRmNStYdGNrWk4yQWR0SkRmWXZZSVRG?=
 =?utf-8?B?c0xBRnMyaTdNSTFjMHpvYUUwTjVFUGlERjlGL1M4d0pSUTlmTS9MdHZPRXE3?=
 =?utf-8?B?RGNxeVU5MWY2REE5SmtyemExbGJSelc2NTFocmR6MyticzVTTWF0S0hVbTBU?=
 =?utf-8?B?cjN6aG9XRXJpR3VjdkFaQit4RThhK0VMNk5YNHBDQ2FsbERRSlEwbFpvVzhr?=
 =?utf-8?B?VkJHQlN3Skt5cU1EbFlqbkladHNzY1N6NjVwY0NwMm51M0FteGY3UG5iSisx?=
 =?utf-8?B?bDMxcHN3aVVsbGdpZEc5WS9OV2NiVGZzTjJwM3lDNzRBUndGSzcyRjZML1JB?=
 =?utf-8?B?dnhEYWthTmZrcGFKbjJzekQyajJuUk9ETDIrK2h4bFhFcVNVV2dOL0JmdURk?=
 =?utf-8?B?ejArYUNJcUNORVh6RDdoQzF1R29jN1A1bGJPQjFXQ293Q3VvTzhYSWxFeEdj?=
 =?utf-8?B?R3hLKzU5eHY4M2ljbElrMk5oMXBVYjd0K3ZaeFY2TTY2bXNHMkg2b3Z6V3VE?=
 =?utf-8?B?ZHVTSEdyTXE3dzJxZkVvSWVsd1VrR09Bd2JDZU1KL3Z2Uk5OdE5wNGlsbURI?=
 =?utf-8?B?ckVXcmtwOGdXU1hQY25jbXJxa1ZTVVMvSGxQbWZWM0JVZ095TVdDbUFtTFEv?=
 =?utf-8?B?ZFVLRktZNmtpVk5VWEE0TTV2dmhab3J3SkhCR1F5WlZsTVFERnFJM1JqSEJn?=
 =?utf-8?B?TFluUjkxV3FGakNQdlNYVmthMWdSWFRHdTB5ZG52N3dxYldLeW14aHhpdGov?=
 =?utf-8?B?b242eGZSN1FTc2prL2o1c29VWE5sKzhoSUtwbXFXVDZEK2NFT1NETlZ4U1NU?=
 =?utf-8?B?YnFnODlOR0lhQXBwQmRSTG1vcVJGVDBRYlFvSDdNb1dhbXY2NFVaQmxuZU0w?=
 =?utf-8?B?dFVjUXVSSWNUdXVuM0pCc0lQUndlU0xvSTZXaG9tc0Qzb2d2YTI1VExhS3VO?=
 =?utf-8?B?MnBSRUtNTTBxZyt4MXVBZXhaNnRXREtyTkw0Rm9EK01PbDFsdnJYeEtKUUpY?=
 =?utf-8?B?OFJ5dzJDZlR1clY3Y3VKalhHRTl2WlpSalA5VVBsdVJRVzVuMXlYSGpzWUo3?=
 =?utf-8?Q?QEYvGjnBqPuVAAfN/1aF3o/Qt?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nephogine.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR13MB5727.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2ffd10e-4693-4d37-b987-08dc0b57927f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:56:32.7215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7GnUy0+mh2Yd7xFXLgtvhFvCgfqhy5WIYFP8piEMKJSchEGi7O/4kM3Gt8fGPKCgxKCE/y8TKYautjZVCa4Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6392
Received-SPF: pass client-ip=40.107.94.102;
 envelope-from=wentao.jia@nephogine.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQotLS0NCiBody9uZXQvdmhvc3RfbmV0LmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvbmV0L3Zob3N0X25ldC5jIGIvaHcvbmV0L3Zo
b3N0X25ldC5jDQppbmRleCBlOGUxNjYxNjQ2Li4yMTFjYTg1OWE2IDEwMDY0NA0KLS0tIGEvaHcv
bmV0L3Zob3N0X25ldC5jDQorKysgYi9ody9uZXQvdmhvc3RfbmV0LmMNCkBAIC03Niw2ICs3Niw4
IEBAIHN0YXRpYyBjb25zdCBpbnQgdXNlcl9mZWF0dXJlX2JpdHNbXSA9IHsNCiAgICAgVklSVElP
X0ZfSU9NTVVfUExBVEZPUk0sDQogICAgIFZJUlRJT19GX1JJTkdfUEFDS0VELA0KICAgICBWSVJU
SU9fRl9SSU5HX1JFU0VULA0KKyAgICBWSVJUSU9fRl9JTl9PUkRFUiwNCisgICAgVklSVElPX0Zf
Tk9USUZJQ0FUSU9OX0RBVEEsDQogICAgIFZJUlRJT19ORVRfRl9SU1MsDQogICAgIFZJUlRJT19O
RVRfRl9IQVNIX1JFUE9SVCwNCiAgICAgVklSVElPX05FVF9GX0dVRVNUX1VTTzQsDQotLQ0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV2VudGFvIEppYSANClNlbnQ6IFR1ZXNk
YXksIEphbnVhcnkgMiwgMjAyNCAxOjM4IFBNDQpUbzogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4NCkNjOiBtc3RAcmVkaGF0LmNvbTsgUmljayBaaG9uZyA8emhhb3lvbmcuemhvbmdA
bmVwaG9naW5lLmNvbT4NClN1YmplY3Q6IFJFOiBGVzogW1BBVENIXSB2aG9zdC11c2VyOiBhZGQg
VklSVElPX0ZfSU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUN
Cg0KSGksIEphc29uDQoNCkl0IGlzIGdvb2QganVzdCBjaGFuZ2UgZmVhdHVyZSBiaXRzLCBJIHdp
bGwgY29tbWl0IGEgbmV3IHBhdGNoLCB0aGFua3MNCg0KV2VudGFvIEppYQ0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
DQpTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIsIDIwMjQgMTE6MjQgQU0NClRvOiBXZW50YW8gSmlh
IDx3ZW50YW8uamlhQG5lcGhvZ2luZS5jb20+DQpDYzogbXN0QHJlZGhhdC5jb207IFJpY2sgWmhv
bmcgPHpoYW95b25nLnpob25nQG5lcGhvZ2luZS5jb20+DQpTdWJqZWN0OiBSZTogRlc6IFtQQVRD
SF0gdmhvc3QtdXNlcjogYWRkIFZJUlRJT19GX0lOX09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklD
QVRJT05fREFUQSBmZWF0dXJlDQoNCk9uIFR1ZSwgSmFuIDIsIDIwMjQgYXQgMTA6MjbigK9BTSBX
ZW50YW8gSmlhIDx3ZW50YW8uamlhQG5lcGhvZ2luZS5jb20+IHdyb3RlOg0KPg0KPiBIaSwgTWlj
aGFlbCAgYW5kIEphc29uDQo+DQo+DQo+DQo+IHBsZWFzZSByZXZpZXcgdGhlIHBhdGNoIGF0IHlv
dXIgY29udmVuaWVuY2UsIHRoYW5rIHlvdQ0KPg0KPiB2aG9zdC11c2VyOiBhZGQgVklSVElPX0Zf
SU5fT1JERVIgYW5kIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBIGZlYXR1cmUgLSBQYXRjaHdv
cmsgKGtlcm5lbC5vcmcpDQo+DQo+DQo+DQo+IFdlbnRhbyBKaWENCj4NCj4NCj4NCj4gRnJvbTog
V2VudGFvIEppYQ0KPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDEsIDIwMjMgNjoxMSBQTQ0KPiBU
bzogcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gdmhvc3QtdXNlcjog
YWRkIFZJUlRJT19GX0lOX09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSBmZWF0
dXJlDQo+DQo+DQo+DQo+IFZJUlRJT19GX0lOX09SREVSIGFuZCBWSVJUSU9fRl9OT1RJRklDQVRJ
T05fREFUQSBmZWF0dXJlIGFyZSBpbXBvcnRhbnQgZmVhdHVyZQ0KPg0KPiBmb3IgZHBkayB2ZHBh
IHBhY2tldHMgdHJhbnNtaXR0aW5nIHBlcmZvcm1hbmNlLCBhZGQgdGhlIDIgZmVhdHVyZXMgYXQg
dmhvc3QtdXNlcg0KPg0KPiBmcm9udC1lbmQgdG8gbmVnb3RpYXRpb24gd2l0aCBiYWNrZW5kLg0K
Pg0KPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBLeWxlIFh1IHpoZW5iaW5nLnh1QGNvcmlnaW5lLmNv
bQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBXZW50YW8gSmlhIHdlbnRhby5qaWFAY29yaWdpbmUuY29t
DQo+DQo+IFJldmlld2VkLWJ5OiAgIFhpbnlpbmcgWXUgeGlueWluZy55dUBjb3JpZ2luZS5jb20N
Cj4NCj4gUmV2aWV3ZWQtYnk6ICAgU2h1amluZyBEb25nIHNodWppbmcuZG9uZ0Bjb3JpZ2luZS5j
b20NCj4NCj4gUmV2aWV3ZWQtYnk6ICAgUmljayBaaG9uZyB6aGFveW9uZy56aG9uZ0Bjb3JpZ2lu
ZS5jb20NCj4NCj4gLS0tDQo+DQo+IGh3L25ldC92aG9zdF9uZXQuYyAgICAgICAgIHwgMiArKw0K
Pg0KPiBpbmNsdWRlL2h3L3ZpcnRpby92aXJ0aW8uaCB8IDQgKysrKw0KPg0KPiAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPg0KPg0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3Zo
b3N0X25ldC5jIGIvaHcvbmV0L3Zob3N0X25ldC5jDQo+DQo+IGluZGV4IGU4ZTE2NjE2NDYuLjIx
MWNhODU5YTYgMTAwNjQ0DQo+DQo+IC0tLSBhL2h3L25ldC92aG9zdF9uZXQuYw0KPg0KPiArKysg
Yi9ody9uZXQvdmhvc3RfbmV0LmMNCj4NCj4gQEAgLTc2LDYgKzc2LDggQEAgc3RhdGljIGNvbnN0
IGludCB1c2VyX2ZlYXR1cmVfYml0c1tdID0gew0KPg0KPiAgICAgIFZJUlRJT19GX0lPTU1VX1BM
QVRGT1JNLA0KPg0KPiAgICAgIFZJUlRJT19GX1JJTkdfUEFDS0VELA0KPg0KPiAgICAgIFZJUlRJ
T19GX1JJTkdfUkVTRVQsDQo+DQo+ICsgICAgVklSVElPX0ZfSU5fT1JERVIsDQo+DQo+ICsgICAg
VklSVElPX0ZfTk9USUZJQ0FUSU9OX0RBVEEsDQo+DQo+ICAgICAgVklSVElPX05FVF9GX1JTUywN
Cj4NCj4gICAgICBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQsDQo+DQo+ICAgICAgVklSVElPX05F
VF9GX0dVRVNUX1VTTzQsDQo+DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZpcnRpby92aXJ0
aW8uaCBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oDQo+DQo+IGluZGV4IGM4ZjcyODUwYmMu
LjM4ODBiNjc2NGMgMTAwNjQ0DQo+DQo+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5o
DQo+DQo+ICsrKyBiL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby5oDQo+DQo+IEBAIC0zNjksNiAr
MzY5LDEwIEBAIHR5cGVkZWYgc3RydWN0IFZpcnRJT1JOR0NvbmYgVmlydElPUk5HQ29uZjsNCj4N
Cj4gICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fRl9SSU5HX1BBQ0tFRCwgZmFsc2UpLCBc
DQo+DQo+ICAgICAgREVGSU5FX1BST1BfQklUNjQoInF1ZXVlX3Jlc2V0IiwgX3N0YXRlLCBfZmll
bGQsIFwNCj4NCj4gICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fRl9SSU5HX1JFU0VULCB0
cnVlKQ0KPg0KPiArICAgIERFRklORV9QUk9QX0JJVDY0KCJub3RpZmljYXRpb25fZGF0YSIsIF9z
dGF0ZSwgX2ZpZWxkLCBcDQo+DQo+ICsgICAgICAgICAgICAgICAgICAgICAgVklSVElPX0ZfTk9U
SUZJQ0FUSU9OX0RBVEEsIHRydWUpLCBcDQo+DQo+ICsgICAgREVGSU5FX1BST1BfQklUNjQoImlu
X29yZGVyIiwgX3N0YXRlLCBfZmllbGQsIFwNCj4NCj4gKyAgICAgICAgICAgICAgICAgICAgICBW
SVJUSU9fRl9JTl9PUkRFUiwgdHJ1ZSkNCg0KRG8gd2Ugd2FudCBjb21wYXRpYmlsaXR5IHN1cHBv
cnQgZm9yIHRob3NlPw0KDQpUaGFua3MNCg0KPg0KPg0KPg0KPiBod2FkZHIgdmlydGlvX3F1ZXVl
X2dldF9kZXNjX2FkZHIoVmlydElPRGV2aWNlICp2ZGV2LCBpbnQgbik7DQo+DQo+IGJvb2wgdmly
dGlvX3F1ZXVlX2VuYWJsZWRfbGVnYWN5KFZpcnRJT0RldmljZSAqdmRldiwgaW50IG4pOw0KPg0K
PiAtLQ0KDQo=

