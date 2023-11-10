Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A26B37E82B6
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 20:32:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1XDi-00050U-RA; Fri, 10 Nov 2023 14:31:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1XDg-0004zq-96; Fri, 10 Nov 2023 14:31:08 -0500
Received: from mail-eastusazolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d003::] helo=BL0PR02CU006.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1XDd-0007Ez-Nm; Fri, 10 Nov 2023 14:31:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btdCLSGrB66MX5973nOoH8Wx0bC4XCrMX05TOCO2xX2UWXJAdeEmAOV4s0TKQKKIQp1YJ6qU1kanU+5sW8A5NrXMiCBtNpbyf4y/GvSHvNH7mZuUUFLx3cBC+PPivNEKuvD5wzRpwi3YhroFbN46+dSTzmyyEC38o9IJNaRkxwcND4rIdifgfQ3vo5VpSpTlIWfPVpoEwl1jc7nwNlYynErGAhY2iItI2DPshM4f7JvO6Xh6ZQ1fgKrr/dFl7M8l1ShOr83l4za3GkS/ZJT/aMVtZ+swCOJJbaj1DBPwx2/NGoLH0pZsypQcT3ch7uc2yKuCz4nAFtvfjE5BRhhRew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5eOR2WBMYnjzsCQapK8INwdy7L7jE2KRsCS9q/aeYQ=;
 b=DBiekwDiwVJ97N0RhbGNMPdWuFOOfK3Jeb4ppkwUr4oPfZF3YltwZ86Pi/vV1PQ0+6gtRLpF00wwjP//5m586VEKAjS/dS9QyE8Kt3f6ZVq4CHPK7mSALqeaPndjJSD3RYQC7d2NVROzSSeygTbt3F73mUMINwqlUhjktADL2SwOQkXyrhUqnTTCZ9janxIL0+BN4avnkJn9+tsgmSJTpU2r5TPOIchHnhC4WKLw/TMW12xLnxL7iDxEPEk/DIRiUm1vA2FEl7IEqfRFwS4Ie7Jl1WcpXy0ZmZZ+A/gYGdh5923a/bx3mLJitMnKboGDItuaH4EfMZNSPpQa6bXBfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5eOR2WBMYnjzsCQapK8INwdy7L7jE2KRsCS9q/aeYQ=;
 b=XL1zIs7WBqIECF8jTjgZv+XAXe2fHtNppu95iKnMuAh6fz1LRcmGd2gyyIU0hIMyrui2bs623uHTWPRTHN43pgITZDWhZpBAQBaGIGTE7Mtmhvh+bLHhrgKkE3kK3tOM7iUI8ZuW/Zba33/Bjz9/5YHtB4E/fg9Km6vf/DzCbj/EBdbKs8i0FD9PuaxcDJRROFDS6oQSbxiXEiiSDK1LoG2GwjpQ50Ux+i6+kJNP9DwO7gtNJzo5NeDUHKYDGQtNqxxkvkMTYBSb3ZjnUAkQpidGeS63Kjilu5Uw5b4CKQyNGGAtt9bcCFreLwYMq65RpjxST3vLP56fFSNNTkJOZg==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by LV8PR05MB10328.namprd05.prod.outlook.com (2603:10b6:408:18e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Fri, 10 Nov
 2023 19:31:00 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.028; Fri, 10 Nov 2023
 19:31:00 +0000
From: John Platts <john_platts@hotmail.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, "qemu-ppc@nongnu.org"
 <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PATCH v5] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaE+t978RdhJF7Z0e5h5bd+vwZsbBzr0F5gAASj4CAAC6hEw==
Date: Fri, 10 Nov 2023 19:31:00 +0000
Message-ID: <SN6PR05MB583711DA6B6B4F5583117C649DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB58378D2FFC111C3C8482CA3A9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB58370F778E36797C833A020E9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837CB36DC040A4222172C949DAEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <b732ff28-a9f8-47d1-b9c1-259fc7f68774@kaod.org>
In-Reply-To: <b732ff28-a9f8-47d1-b9c1-259fc7f68774@kaod.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [W+L2NzZ3sILHLhHGhkmnE0OHMu2jRfOsylb006inF22mWQpKcnbY05M+3ZoLI6Hf7sINIs2kS1E=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|LV8PR05MB10328:EE_
x-ms-office365-filtering-correlation-id: 31e95e30-82a9-4371-096e-08dbe223920e
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GtkddOsdQhh7LC9RjcbqaSrvC/MRmjYdNtM6dAaw/JKv+ZuIE7lzoDABaxebnBM8ch4zKfuZFwOv1Frji+gvhkfor1AUxRgEx9bLXD4V9VlbtqHt13RBjJbMVxAJbYddr+DK1tPthy9YXLTIszCy94rJr4J6bpWB+ug3lC18fJ5jyzo/Cy1vFqBPm42ZbObF021/324C52bGGQSNkOx1bLE4TbOeCd6R7i7fCXYq8MbW/x4dF2SfLYqTo/jE5Bo9eGRoRTa+tjYtVdJ+JZ5B75KqRQFaBR8eZCWmECbToiX/abS6I+jquipKilgCIQB9gRM4fVW6GvZ2jrLw+7Ya+lqEu0nXnWQnD8zmg+qhEjIIDh2dKPOoRTS1ggSTDJHTb/vPXr2M9GmaexwsfhIv2xV5uPmrKTrixlV+TQhzs4jHvAoTOIsXwVTvd7HQZEPUxOkhkS1pMc25Q0qDoFGa8UvjknICSlNUP5y0vpzNWO36B+UhsJg8aERHvmXn9z+6ZoMmdymToHJeGgMjVsH4JtasYnr18IJvgy+KOEFk3VA=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ISe7txZcn9s1Ctx02YU2ohknw0UH7qWIcWKVUS8CB7nPJRJQqf4TBu7fNt?=
 =?iso-8859-1?Q?9fkVmaO3QmF/0xoKWbnoIz286aKy1qEh2G8Q36WewXM8Jb+r7Hgg0BQ/Lj?=
 =?iso-8859-1?Q?rlZM7F8yFU+P7njZwI7lyuinQs5TTTNoLAMWF67OTkWPN70jI3OOYzyWjn?=
 =?iso-8859-1?Q?T8dnSZRFeFPzB9qmecmFAPbui8yiiUfexBLl5QvsRClDAXnua7W6IvV6zS?=
 =?iso-8859-1?Q?F5XrSUhrNfPS3Nh61Y2TYw4d0wTPIJWyjsoFd9rL7an2Hdp1eOGyv5c3BE?=
 =?iso-8859-1?Q?UA8/RcPt2WWW1rJniGu1WT7wllCIk5Keqz1koK4iDVJuI3SC7B/dbF/Af0?=
 =?iso-8859-1?Q?7RinJ8IJ0JvPre6DNt4eVuU8o5nwxWT7YOpozyYSbEDJj5lRelw7xxLviP?=
 =?iso-8859-1?Q?odAefdSs+Ps/dybsySIykQDbBpsvRcGr0u5QsKtA5OIQ089NvbYB1L31Ea?=
 =?iso-8859-1?Q?mRee89ebGEWYY1QA4Ux5Eg45kxwJZktI7PQF2JZyx7HvbGJKwkbI1ebn76?=
 =?iso-8859-1?Q?Gpw5TfCDYUfh5uOZ9+hS9wM07ijxP/h+/bEuU3a/R2ab0O46W3bm98D5qg?=
 =?iso-8859-1?Q?kfXG3EMvTMk2KLEB+MTFzwPA/LH6deEqewnD4Z74vSYajBVzRzD8mCYDDN?=
 =?iso-8859-1?Q?09mkVECBsh9wn5Hs/Ijp5WC4jLm/UqxtuqTdqUrzgLYRhBR1GY/CAP9aLB?=
 =?iso-8859-1?Q?C2aPCikiKhjeI0y/2yU5uWf80ijocc01UBpNkOma6i2W1UgGXYYSe+OanS?=
 =?iso-8859-1?Q?++yIFdaqHm8kog1DNq/KjJ8tgabLaJ/dSjDT12epcEPRqDWKWxdbpD58TD?=
 =?iso-8859-1?Q?HMetE3M1K2lOaPEhDAEB+Ga6Vu2LOJ73BMj2GXBvP/o05n250QmJ18pQOM?=
 =?iso-8859-1?Q?7+hd0DiMMpxp/gIgpLhsZmA3VtuScz1WJuSgRo7v9SipAT8ODXuuX0bVh7?=
 =?iso-8859-1?Q?gmHOBP8a9rkoG7znjan7ovEUK9LC33rEs/4ydLlTyq/aIDkRFcDKYkjbVp?=
 =?iso-8859-1?Q?4bJQrBSnNCdkpBMmYr+c/szrlyiCO0eWcg1uHBQLucJv28+rYZ93+ncrxJ?=
 =?iso-8859-1?Q?+Q/WLW8yjcHQ/T4VdFhGupOA/2rZN/b4o6Zg9CfT5Sykt6bgCkT/pxvKxn?=
 =?iso-8859-1?Q?X92OUt1j/6QTmbCq5WDInJHPiRHE7/1Jw3qOy7lj7Lvevs9PW9ZKPeSwnM?=
 =?iso-8859-1?Q?5i0RQK894HP6DCP61B4yce4zLMS1BS3MG/lT97gjApJL2FVvmvyWYDzGuJ?=
 =?iso-8859-1?Q?VVGgJg1JpZ6igodOz7JLOBN47v2GDdZoa6agF6ds2e0DTC0GZmZAkchE4Q?=
 =?iso-8859-1?Q?ZlPjBa84z79x0bg9n4Qui//aTFaCYWAl7CYGZq8qeY4PHyc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e95e30-82a9-4371-096e-08dbe223920e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 19:31:00.4747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR05MB10328
Received-SPF: pass client-ip=2a01:111:f403:d003::;
 envelope-from=john_platts@hotmail.com;
 helo=BL0PR02CU006.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

C=E9dric,=0A=
=0A=
I have sent an updated version of the patch that fixes the vsx_f2i_nan.c co=
mpilation errors and ./script/checkpatch.pl errors, and the updated version=
 of the patch can be found at https://patchew.org/QEMU/SN6PR05MB5837524077F=
6C8A2A482B41A9DAEA@SN6PR05MB5837.namprd05.prod.outlook.com/.=0A=
=0A=
Thanks,=0A=
John Platts=0A=

