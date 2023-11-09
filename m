Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC967E744E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 23:19:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1DM8-00019N-0Q; Thu, 09 Nov 2023 17:18:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1DM4-00018n-SE; Thu, 09 Nov 2023 17:18:28 -0500
Received: from mail-westcentralusazolkn19011019.outbound.protection.outlook.com
 ([52.103.7.19] helo=CY4PR02CU007.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john_platts@hotmail.com>)
 id 1r1DM2-0003rY-MA; Thu, 09 Nov 2023 17:18:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNPcgFnD7eUqaoQ5cOnCoqZ9FWLKE0rEnCM9v8j0JGT0mtWjX7RxGyPBagAJetBpYa+PnjL4SP8sJ9jAI1HY5c3EMBkjPFxyYyD/azBa/5k6Wl+asyA9+MIMs4NNdPmeIXVxVcYLq+NQXp0UPkKfN2yZqbkhmQBRLERsq1ZecLZhwsxx0S00A/QkO0hzkUJapL8uobTX+4uJ5Wy4vYQE/F8nCRLT287SLdRuPUqY2XcRs6f+pwpaqAR+XuWZLNIeehdYc+fxn1odKjSJ7HipWqOl67ORdULvRM6KZIhQ250WZrRjzbtiKsQx6wdGomJRaMgyz/qniyQJvI6OLryu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjnJ0JgG8bvaJY1cvRGX5n+s+n2iCleyDsyyeHFbU7E=;
 b=ZzCfLmHAeEl7168CgSXQr8U2Ccd3K0xdxs5tUuNAJGVC1tklcH6sgQA4spEhQ5PUMQ4KvezV4OeahtOLEiLkgQkwcrvywz9b4mboOEcUDwNiQnTVRaS4aN86dkW67iGlxsXYI2U+fuuQplGUiVi0fksh74yTHdbxL5jJUtMHTpNc3JCmpZJc3l17FrSownXQcGBsT2vyFwjrYByOI1U1J5+4eG3r4mYo7Dnmw3I0uxfbBsuKVpmu2iAEfDWI8qw+3Lkmcs1AXWzpLSpAuYCWShmle18yfeNy0CPgod9T5jgZ7aq1Kfs2IzEQbP6CDnvWjoBLST7gWL/JECl9HyAcIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjnJ0JgG8bvaJY1cvRGX5n+s+n2iCleyDsyyeHFbU7E=;
 b=vGMmB2d0zKMc7ge0zIQk06GmlQIq/atRsQjhRMS3XrkvLVPJ78Tuze6KqEVbyLReU8td3gfvyrxm60Lp/ae3icEKYjjmFIeAgSUPi+rATB0ADRiU5b1N8q4qXgshCnx8n/WiWoNntlHXaQEqIMIpcbpTVj4uhYlO1TgGpzV6nq0bjGh7+uQjM+fyAiEe6/zimdcYqeJDg1UDoqnBNdsig2n7Q53Wa46jfddPuJ81NTR+NFYLcZu/eWLkSYxULf77akoROe+Ch1Fv7JmREGClp6rJQweMdMfSSpBdI0lO7ElmhDG+jK9jMn1R9eYphdXPOrfCeh2hyunx74sgQQwYtA==
Received: from SN6PR05MB5837.namprd05.prod.outlook.com (2603:10b6:805:f4::20)
 by BLAPR05MB7329.namprd05.prod.outlook.com (2603:10b6:208:29f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 22:18:09 +0000
Received: from SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e]) by SN6PR05MB5837.namprd05.prod.outlook.com
 ([fe80::c41:7e67:640d:c47e%4]) with mapi id 15.20.6954.028; Thu, 9 Nov 2023
 22:18:09 +0000
From: John Platts <john_platts@hotmail.com>
To: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>
CC: "npiggin@gmail.com" <npiggin@gmail.com>, "danielhb413@gmail.com"
 <danielhb413@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PING] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Topic: [PING] target/ppc: Fix bugs in VSX_CVT_FP_TO_INT and
 VSX_CVT_FP_TO_INT2 macros
Thread-Index: AQHaE1qe19iBxldti06QnynA/XxvGg==
Date: Thu, 9 Nov 2023 22:18:08 +0000
Message-ID: <SN6PR05MB583760D0AEB19A3516E216329DAFA@SN6PR05MB5837.namprd05.prod.outlook.com>
References: <SN6PR05MB583705596093E9D2EFC8E4029DDEA@SN6PR05MB5837.namprd05.prod.outlook.com>
 <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
In-Reply-To: <SN6PR05MB5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [TM5kZDq1D04RY2eyhb0RNZSsHle6aGQWTH/5i2jGtFrAWlV414PBrhTIUyGaaJgdvVXA6op7Nd0=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR05MB5837:EE_|BLAPR05MB7329:EE_
x-ms-office365-filtering-correlation-id: f784802c-26d8-4c3e-b1d3-08dbe171c101
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VK9uzVh/NV2Zwb9YaTX3lOgyjoFUPCtB12YwWMOBWcn7K2g2wl9jQiivLHVFnXoKPstTq0t8hgGgsky3DhgSDuQm62iyeYE1+hQuszTsUAdkm7rp0o7KKctb+Op7rO2dnzXOMhEVVYqJVDasM3ZmCDHvVY6nawMePTYdgOsiOCCKC/OZqoH6/NfMh2gZoLP2IHTUoxMSGI0Jr7dD9mR0EOOT8zLa5yA34Vi67Oq+TlqWS538MsmnlMV5cywUA4bX+vqrcEYxRY8LoSXyGz7vOijRTXloxvRRnPmm0CMIYiIiHiK3790s+xCEn2wZTBPZ0UaQVSSMR/pHb2BZm9wpQHu7am69o4xWKPILAgNscfCCGvgl3nrmcrcyrZ3yN2l9LVKImJ/DMhAO1s1w8maZ3ioyARvQQnUxbJtTGNcNGESJbD1NViUKYE/wasLaZ4QOeGJAPwX+rYUmxYshpicwmCLIz8jLZ/Kk1rUVSsyXP0z47DsnnoonLmoX6l3chKaUpLIxT4sTlTJIyTy5XxQW3S8u56tSLJeXoKRSroi88oqvtYedFd2MrUNXZMuMuPopJmHBS2MWFkAV0681fBZbVlquRmULXQIC6U+yfjl0ZOKwkhSBEj0F0+NmYsU9YgrNg77gRaLjuMeV9IWZDsVoRw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CVDxb9mGmjgBXvkPl1QvNdgjRTMHpsU+B6Ap+oJCSiFsqGwvw2gw/g6HTL?=
 =?iso-8859-1?Q?8HLZdp0s2sb8/fPxbU4ikxEbu0r5BOdqUtT2omTtS1qBxlka/cveuOJet/?=
 =?iso-8859-1?Q?nHs1u9urSIJ/v1uY58rQreanRx8+X/uL/4rGB3lCUr0GlSpTOl9B8NzuAY?=
 =?iso-8859-1?Q?e3khvTc9Gp7R+sAdLVZYPvLKMXNCNpW+4ynlD50FeHvRWnldvxzeEiYDfG?=
 =?iso-8859-1?Q?+0zrfy79YW+CkKlHjPqXS8BgyNy3bVeaNHHUeWl0+uTzV+3rpl+klmDyzz?=
 =?iso-8859-1?Q?x4Y8qcDlCZPoANv0DW9Nd2O2Z3YEl4XJXwRIFdvwsFjn5kMPuYrosCok54?=
 =?iso-8859-1?Q?aAyy4rDhNOvaQ7px5iR/4gF46pCfzE778cia25R0wqHngic2NFi1YHIG1A?=
 =?iso-8859-1?Q?wDFbslLV+tc1+LjWOnBp3O8DPX899szVle3i804JRz6PbnVQzJDLYpDUno?=
 =?iso-8859-1?Q?LpLQ/3RaXlvHrtmCHx6yqQpUV00ieMhRevDtJnKbGefjY3u8YmIQx+E+CZ?=
 =?iso-8859-1?Q?OCArdzfXsAXai2NwSad1Oek575HgRfLvcrPJ6xmWMkNh2BlRx86Eoh4jA4?=
 =?iso-8859-1?Q?pSZUrfQFs2nB2Ci7HkDYxOuXFXo+su9ILaVpVzZjJPpTNAhSO8kCjUQkHO?=
 =?iso-8859-1?Q?yY+OsmAcdZkldmoAATFLBymnjHVlMCPC1r8T9eKuGYD5gk7QURZl6ztTgX?=
 =?iso-8859-1?Q?DqmyaBKKC55/qrrDbalLJnFc0i8+Ljs2f1CjMOfEi+DmLHuw3RJMAN1BfJ?=
 =?iso-8859-1?Q?ULZgiMm7XZlsQiOXTbbL3/c7jXTsTc2tdmcZYnuLrD1N1v8aAK+foJM88h?=
 =?iso-8859-1?Q?Ecfn1BQ6NqINc3TppXitfhwlRp9888eGW2BvKrqZJsjz+DmCSnt0qioXIq?=
 =?iso-8859-1?Q?kESvsyyu0KtJH/78EU1J+5/lQmj7pIdtys2cITVT6V5e4Dml2UGQV3JZpI?=
 =?iso-8859-1?Q?q+oRStliSgHqNAzwn5zQVJ6sURu5vCiIVw7k+0fwLydbCL5AOXM8oN4RnE?=
 =?iso-8859-1?Q?c/qdAf5gm52CtGKCRrN+ORHohgA68cLFc7Xcx+uaKugop9yMRAVv+3MJcm?=
 =?iso-8859-1?Q?WH5QI9B+JRuE4tKWzxm+xxfnVSaCIu45ROdID9bmCk7QY+KHFvKQVTUHYE?=
 =?iso-8859-1?Q?CAixkSx4xrKlia/BpvDZt/8zvMuRguo6RiiNZktC9nXkhvb8KG46aT8Q29?=
 =?iso-8859-1?Q?Bapq3pO+jPUn2dcxlnHNE0v50GfQ1lsSpO+ddKsTZh5zwPMEXQbjqAx/Cb?=
 =?iso-8859-1?Q?AhXY3XbC+GgTOxq/e0mfeMpPqSlLtMKHDzdIgSdvem4ETk9Gz18yOsbOR/?=
 =?iso-8859-1?Q?ve4JASl61Aykm+aIFJcK8SYZLwtZJz8QeAhB7jHt/9WmhS4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4823-7-msonline-outlook-84f76.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR05MB5837.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f784802c-26d8-4c3e-b1d3-08dbe171c101
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 22:18:08.8551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR05MB7329
Received-SPF: pass client-ip=52.103.7.19; envelope-from=john_platts@hotmail.com;
 helo=CY4PR02CU007.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

What is the status of integrating the fixes to the VSX_CVT_FP_TO_INT and VS=
X_CVT_FP_TO_INT2 macros in target/ppc/fpu_helper.c?=0A=
=0A=
The bug that is currently there with the VSX_CVT_FP_TO_INT and VSX_CVT_FP_T=
O_INT2 macros is that float_invalid_cvt is incorrectly called if the curren=
t source value is a non-NaN value and a previous NaN source value from the =
same source vector was encountered.=0A=
=0A=
The link to a patch that fixes the above bug in the VSX_CVT_FP_TO_INT and V=
SX_CVT_FP_TO_INT2 macros can be found at https://patchew.org/QEMU/SN6PR05MB=
5837B5EF0D11E0A787EC30179DA5A@SN6PR05MB5837.namprd05.prod.outlook.com/.=0A=
=0A=
A description of this bug can be found at https://gitlab.com/qemu-project/q=
emu/-/issues/1941.=0A=
=0A=
Here is a link to a test program that will detect the bugs that are current=
ly there with the emulation of the xvcvspsxws, xvcvspuxws, xvcvspsxds, xvcv=
spuxds, xvcvdpsxws, xvcvdpuxws, xvcvdpsxds, and xvcvdpuxds instructions if =
the source vector contains at least one NaN value:=0A=
https://gitlab.com/qemu-project/qemu/uploads/fcbb97896ff2f4ab435affae94467f=
4d/vsx_f2i_nan_test_102523.c=

