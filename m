Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F14297DBE9D
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 18:16:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVrU-0003pp-UW; Mon, 30 Oct 2023 13:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qxVW6-0005EG-DF
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:53:30 -0400
Received: from mail-cwxgbr01on2094.outbound.protection.outlook.com
 ([40.107.121.94] helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qxVW4-00072w-1d
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKlmKYP2g463SoIwP0ps9fHTqv87TOsTp5zFxtuUtOkFYkA2vhUUcqfu5OG0YB9F9kDGPQr3xVvWNkiLKT4N+dgn1MHH733oQboHfLqY4/mMf+p9ycYH33ebOc5zbgHvIyc8n5Qf+BqbaIiLvOLtu4SvKX67+P81M4AwZK5hWy0N/8A7FW+A9Xn7WcQTYwJoerXwXkxdD3wloNSK8wTyCfa5VIM5FfTn3PwHK+sWykNW8kbR5o93ZNQCfFkC535gMll2VLnmYBpQCubJdzyV90An5mP7R5hIlwjP+NI+oTROxBiNo4eHoG9+JgQoHnUns408Usiy706pn9qfQwDBDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3nxAnT+X/gD7gskqe3HJzQSaJIh6diERKQS4fI2bgRQ=;
 b=PTbBUQsu+e2NTUD/wmxD4Zi1JkOcERJaO9niJoswjfu85yYr0kJkpYhObYTOgygFMLq0FDn8VBQXP4gbMjKmubtRT2bfiQTR0BMyLvG+hsOr/snPR5hxZN2QF7Fh9xSbFwlyqp2zFqFQk1rdgESf9dE3CgNTajYMK0Y8osfq2ubIXoCBrcdjnv5VGzz1CvRQtw8NlWpTmsInaQAVu2F1m8qWHAlPNWdIsIFMSg+eZJQY1pEAnW3URSTmPbFWc39EbhdhZ78MeJGQ+QrNbRDfYDAlWPeAQ12KaM9/3KnJRaqLDfLXqJzy4kQnpAV/u4EJA/GTFM7pGCAxlKJNqyM7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nxAnT+X/gD7gskqe3HJzQSaJIh6diERKQS4fI2bgRQ=;
 b=SPdYjLrHgkQ6XznHBubLkANRSpbuwZFVv0lm3eABIFqRI63NxvuC2/bpBv8i5BOMOf2UcOmPwtVs7IjIU8e43Kec/sp1gXjtmOK1x7zJlBrW5zUJAB1nm59nqlqOGU0nPNBXi5j8gE28qGQ4vQ0NalQqgw8tzi0k7XeTxfaIDrw=
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO6P123MB6722.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25; Mon, 30 Oct
 2023 16:48:22 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1e33:b4ba:d19a:8236]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1e33:b4ba:d19a:8236%6]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 16:48:21 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "luoyonggang@gmail.com" <luoyonggang@gmail.com>
Subject: Getting qemu plugins working on windows
Thread-Topic: Getting qemu plugins working on windows
Thread-Index: AQHaC00i3al4gZ694UuboYHCvVK6ng==
Date: Mon, 30 Oct 2023 16:48:20 +0000
Message-ID: <CWXP123MB43418A508D8E101ABC58A523D7A1A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP123MB4341:EE_|LO6P123MB6722:EE_
x-ms-office365-filtering-correlation-id: c975ae38-921f-4191-c0c8-08dbd9680662
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+94DfORR2HGMAVd4VCu1p9d5VYjy/961Kdv/NMCYAAFxkLz/rF1v6EUR9Od4+C6WYuv3HOBhhEKQc3cVj/bY6nH5kSItd9U7DSKZGuswsknRccO0o4BFYrVaoSNsl3NhK2Q3pplPqW0EmU2HDOUPU0mBNcRV5BbYVoIlv4AsksCqpJ2SMITv1VTF9swyDaoGICGde1usyZlgjXNyv05uloMSplNZtnd1sPcg0OigN14/ScgB1TkFRt65EZVSeJkj3zavGbwr7Q2N2Fkb3yQ+eG4Wd5WSMmVCMKLjJpkz4zB8U6kwLUhcW7Pr4HObhLDkwpiNk2xCMLzDc+C9bnQs6qYdM598PFS25NfyjWZDMpn6Wi89OOkikL+7vH4iGVrXcwMKrw63t9osyDN+7be6uJderxGl4Oc/22UYRlxGr9IyeuL+kxTaLl4m6Q7qqkrnaGDYj0SU86LqAkGNw0wsx/jXjdv6vbcmj7r/q8tOhbazS7o5UYRS+0qN0/paKeKpBieIyrggfC8wINI12W54NUk7SY79JKLBuvYLZESbJlvJJP6T+JniSBVg3vceA0ggjx6Zu+TNkJeT5KWXZrTfm3PRqCXuHk5C4pmn3ZHRAE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(39840400004)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(9686003)(26005)(45080400002)(478600001)(71200400001)(7696005)(6506007)(2906002)(83380400001)(91956017)(66556008)(66946007)(966005)(41300700001)(5660300002)(76116006)(66446008)(8936002)(8676002)(66476007)(4326008)(52536014)(64756008)(6916009)(316002)(38070700009)(38100700002)(122000001)(86362001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A3oTVOoE0hyrLp803Q51xzGEkJYOguZXU52Nfgw+Ne/C9b1hLNP/DHPeCz?=
 =?iso-8859-1?Q?ORdwAVECnttcG47OT02HVy7QrVhtvxjY234aj6Qj0uiQEC5Yj9P6DZu558?=
 =?iso-8859-1?Q?TNJcQFv75ByqSLL8YDQAmbzQ57NlpD5vH3hhKGgHmMkrkkJwuhcPfdKUc8?=
 =?iso-8859-1?Q?FBqTqUxgDzmVm5o5pNe7HH/WSZdZCjVCJIGxahIYTNsbqpQAiu1CBGKdYR?=
 =?iso-8859-1?Q?9QLUmBHR+gaEE4bAnmlPN89+AsLxNIsU9PRVs6RJnHFmNekcLIwrbT37tc?=
 =?iso-8859-1?Q?T/zLKj1OUvQyomHAKTRmaZRaK62uqxLrpTr8OgDZ8Ws0gfzy3GsN/IqHM6?=
 =?iso-8859-1?Q?Jzis/5L7oNlh8D+QzndwVO8xijergRvWlNuOVYJcbdKfjSLaC9LByl+DWL?=
 =?iso-8859-1?Q?jyU6VH7/cIQvIQd9u2MrtbSNRX8biO7YBgS8L2vO16A+38Fcja+gv8wpBQ?=
 =?iso-8859-1?Q?aRn/81vPbd55mO1+HKS2GjqwFO9iAQBINP1OWCqUQtdv9yfEIb2CVfxKb9?=
 =?iso-8859-1?Q?3wZqkOtRfYp9TRRFgYZNhO9lHqiUFXRGCfYth9qSmkgx8fuM+aZcQVDYEq?=
 =?iso-8859-1?Q?H7DjgtRu/NBQgS9KWzkAOKCnRHWqeywiNxasT0p+SLXCEqUtXeHAk1HEDo?=
 =?iso-8859-1?Q?lTyge+8XfxfEe2nAQtDQ/ggPWoU/WzL2zrrJwTn/+m00CUWR3QWf/WlKDC?=
 =?iso-8859-1?Q?nWUFGofYVF4d2q0Jm8N702h4uCrtf4HiEkbyyTVkyVmrUhLMgNuikU5iSN?=
 =?iso-8859-1?Q?8w07BZmTh6EkN1bnZdcMGK2ekJeG6rtsrOy0mqdpnjjhGyOFiFBr00/XWs?=
 =?iso-8859-1?Q?8rgLlNon5trXhRF+JSZgmdCgS3TfRVeqZdoclda2RiGhulB+pLdkqM9aos?=
 =?iso-8859-1?Q?u870axlymow8xFVHxfKchNSA9xzIV8/740dr8wboTJmQ1GIL6JQiTK0R3J?=
 =?iso-8859-1?Q?fiHp7eACJmhwpEXAZLGKw6PK7NjsSnIeg6C9OK2UahcvzJgZzZzzNS3KTK?=
 =?iso-8859-1?Q?NKe13Vz72yWA/MP8wGdprdN6l3I0uOKDj2yRVFNwcY98iwOPn7opxZCRwZ?=
 =?iso-8859-1?Q?HCAAw6rUtk5M2kfJlxIAsfS+rnEweIbE2KzgRPLKfgUUwZgykttYpxiunt?=
 =?iso-8859-1?Q?+UVI8FEYUrI6usRoQQc9fE3EbvvgxKZmjOGZHIfJG9/lZKvaEonqc1Da7E?=
 =?iso-8859-1?Q?ESt9T1v7Lz33QMHZK0fLPu6tgEeHoBXY+a5tMOohqf90nnfio8lmZmFcYF?=
 =?iso-8859-1?Q?ayIdB/9p1LwZ6PyfqprzPwgNrQSWffkVc4oaAn6P+jz/OXxz8R6MgApu4I?=
 =?iso-8859-1?Q?2p/ST6sjmtMp/mf1R2pxn7wbYwJvGQP6bAlD3Lcl2fnYxdxkAfw6DdIxf1?=
 =?iso-8859-1?Q?5Y50G7Oq4xkoiUCmHoyttQratX4afi3K+4sd6E5r3sedyzYf5X99+1Tec0?=
 =?iso-8859-1?Q?sM7UgNbE88EJIGoU2xpC0U95P3oS7KTeIx6DMVosHIrthQ3ls9mYKjiXmi?=
 =?iso-8859-1?Q?OF3qe8dqvrn9MtfMDMTBXzSewMdDyy34lSvAhL4QyuRfww16ebjhD8alT2?=
 =?iso-8859-1?Q?TRBK2H32V2rK5oWVxs+yyP8Qw+d3gw96JNsG/RuarhbsVfQE4lmlrUddYA?=
 =?iso-8859-1?Q?trHd5oE4SNUhWy4Ac01sCbadNPRrts9Duw?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c975ae38-921f-4191-c0c8-08dbd9680662
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 16:48:20.9518 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BfE7yN/G7NF8NZWivXliab3eqv3YGpjhH3het30bu5RWcPqSJaaVUYwIHb/rYTzgOtTf0v7UWFU09uTZRZbWMiYORRvB+EMg2954OKuDcmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6722
Received-SPF: pass client-ip=40.107.121.94;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-CWX-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 30 Oct 2023 13:15:30 -0400
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

Hello,

Currently, qemu plugin support only works in Linux and I would like to get =
qemu plugins working on
Windows. I have had some success experimenting with this locally (based on =
some previous work by
Yonggang Luo, see below), but would like to gauge opinion before I commit t=
o suggesting a solution.

The overall structure of how plugins work is this:

1. qemu executable loads plugin.so.
2. plugin.so defines a function qemu_plugin_install, which qemu looks up, a=
nd calls.
during that function call plugin.so might call some of the qemu_plugin_* fu=
nctions that the host
executable has implementations of. plugin.so is compiled with unresolved re=
ferences to these functions,
and they get linked up at dll load time.

Windows doesn't let you do such on-the-fly load time linking. You need a dl=
l import library, which is
specific to a particular host executable. The qemu project, however, has ma=
ny executables, any
of which might want to load a given plugin.

Possible ways to get things working on Windows:

1. Make the dll import library. Possibly refactor the qemu plugin code into=
 a single qemu_plugin.{so,dll},
   and then make the import library for that. I don't fully understand this=
 system, and I'm still concerned
   it would be fragile (if qemu is recompiled, do I need to recompile all m=
y plugins against the new
   version of the import library?)
2. Change the way plugins can access the available host API. We could defin=
e a typedef struct full
   of function pointers and have one of those passed to the plugin in qemu_=
plugin_install. The plugin
   can use this to populate some global variable, and use it to call the ne=
cessary functions.
3. Have windows plugins export a bunch of qemu_plugin_* function pointers, =
and have the plugin loader
   code find all the pointers and point them at real functions. This has th=
e benefit (in some
   simple cases) of not needing any code changes on the plugin side. Howeve=
r, it means qemu-plugin.h
   declares new symbols on the plugin side, and you have to be careful to o=
nly declare them once in
   the plugin.

   Having real functions on linux and function pointers on windows is a nea=
t trick in C, but might
   cause subtle differences for systems that automatically generate binding=
s for other languages -
   functions will always be set, but function pointers might be behind some=
 nullable type wrapper.

I'm inclined toward the second option as being the neatest, but it does inv=
olve the most API churn
(though both styles could be maintained for some time, just only the newer =
style would work on
windows).

Previously, some work was done to try and get windows plugins working in 20=
20: [1], [2].
This work was never merged in. I have emailed the original author to try to=
 find out what happened
(and CCed them here). This work took the 3rd option from above - defining a=
 set of function pointers
in place of the linked up function declarations.

Does anyone have strong feelings about how to solve this?

[1]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg744980.html
[2]: https://www.mail-archive.com/qemu-devel@nongnu.org/msg749982.html

Regards,

Greg Manning





--

Follow Rapita Systems on LinkedIn<https://www.linkedin.com/company/rapita-s=
ystems?utm_source=3Drs_email_sig>

