Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C8D712E6E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 22:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2eMF-000558-8p; Fri, 26 May 2023 16:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adhristozov@sei.cmu.edu>)
 id 1q2eMD-00054l-Fs
 for qemu-devel@nongnu.org; Fri, 26 May 2023 16:48:17 -0400
Received: from mail-cy1usg02on0703.outbound.protection.office365.us
 ([2001:489a:2202:d::703] helo=USG02-CY1-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adhristozov@sei.cmu.edu>)
 id 1q2eMB-0000cW-Mb
 for qemu-devel@nongnu.org; Fri, 26 May 2023 16:48:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=jQNxCil4iMhfDVzHYtKIX6Rqbnzo3ExKDr3+tDVq1dt7MyU7VQHKQ198EEzMOovtfCvdx/O2D2ZTSQxq4U6uNcMXvwuspTUAg4OUDMRQI38nWdKDF0Dq+lgY2lh3WDG+xPgyzdzGoHCI/YlwF9JOIqKkC6EtQm9av45kr1eoMT6gCaEygTnMfMGm/B9yH93I3zg+Jd12nZ/DopUYeb4yZiKx2jlBXAqCXVJuIlIT7HGwyo6Su8rjvHKAEsoOpdH2XEi2r8TWzup9lW8hmISBf3mPshcA5zGs/nPP4sXoTnmS0UFkXOb/88FU1A9qoGRs0SqJR8hDPfX7UV25sBpW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqletawH0vDrCQXVbbXjCsA9DknWhXpmeV5z4Y62t4I=;
 b=QbGglvXYxtmMSdyQYm4P/xl/137qDTMlJxmvFY9ypQpKrMV8VUgISajT/lCcYpR9RlEmG0oaW49a59D7vJlKGrx9nPmACBY92lChRNodtXHpByprh93/N9AG7GQbi/11BMEJtcxes9SHuqIkCvTsAy5YfTOPvsRoMFzZNEujWpj5UyAKt3uJXrLohVnUtr3YTiYUQX5qNsiuWKs67sdQgiHmdD03YLW+N9jPocDs0PaQHPLA/c4tKLsY05IQa5qRtOoge8X0puwn3k6llBaLnDvwhrnApcNzbFhqkN3Qh86xh76KWYK4QceHa0RP/Acwi03LzaLhFgejGeeohtUacg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sei.cmu.edu; dmarc=pass action=none header.from=sei.cmu.edu;
 dkim=pass header.d=sei.cmu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sei.cmu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqletawH0vDrCQXVbbXjCsA9DknWhXpmeV5z4Y62t4I=;
 b=Q5YmATSvZYhaLExBfELo3TUu6Q2f8C1emw4OKNdh0LzJ2y6L1q97ZHtiESwk5iNOBsbBQ2JQUR0E9Q2jA6v3quU3DIphfrCUD2T9iAlmHH0PlaNP4BdmG5yjNAkd5AnvbcjuT5PNwdUrd71GBZPQJv5XJ7fqZceCcPGh5Wo91xM=
Received: from BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17d::9)
 by BN2P110MB1367.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 20:48:09 +0000
Received: from BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c0b8:7aa4:335d:f290]) by BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c0b8:7aa4:335d:f290%6]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 20:48:08 +0000
From: Anton Dimov Hristozov <adhristozov@sei.cmu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Support for multiple UARTS on qemu for Arm64
Thread-Topic: Support for multiple UARTS on qemu for Arm64
Thread-Index: AQHZkBGQvxiLRpJHREaHEp0hKkNOnQ==
Date: Fri, 26 May 2023 20:48:08 +0000
Message-ID: <fe888a76728944b4b45d91742fd790f0@BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sei.cmu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1495:EE_|BN2P110MB1367:EE_
x-ms-office365-filtering-correlation-id: 90d96368-e403-4f07-421f-08db5e2a8341
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7yLzJ9yPq+H7KHtEHoEGGzCcIN3417gg+TJ9gHBEulwGtIE5fErLTApgSW0Ncvaladkm8e7YIejZhPmyXBBCw8JTo3jjAxC4XuOdOowFL4oUFzCIu0p/rsintBqKGIAxbaSo9t60bZ5ce19xurlylUI+ledkSfixtosN4BL5bslMfS8yAOl/D937RsG7EfDyDpqbtzeBOG1qlAGdc98VZHY6KzktFcHlR1SPel1kkJMEXkp3AzrwNdcypgwBcx8tNdpFrcIRlWrSuzfUk/PP/kFVHuyQ2pCm5FSo5bz3st+iI9ENUMrWpUY/Rs3a7CFxopeJmAh9DAjFzC9zMrqjCvoBQp1fZNWOOTHs96l7DrY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(39830400003)(136003)(366004)(451199021)(66476007)(76116006)(64756008)(66446008)(66556008)(66946007)(82960400001)(122000001)(6916009)(71200400001)(19627405001)(508600001)(24736004)(41300700001)(7696005)(75432002)(108616005)(55016003)(2906002)(186003)(86362001)(9686003)(6506007)(8676002)(41320700001)(4270600006)(38070700005)(26005)(8936002)(38100700002)(5660300002)(73894004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Gl4xBwAss8a1td+YhjJDfQN7hx2uPb1mxK7t9/2o9ejL7wufbJDkn4l+iZ?=
 =?iso-8859-1?Q?o3vzq/TOjYAU0pzhlY7puKbD+Bw7n6a+MfVXRZ+romNKHQCeX3W5GNOLc4?=
 =?iso-8859-1?Q?I+ZZPVwYjwVs+nQKOdXNwZdbvaAghpB7U7fG1DgC5snmOw3fPMv8YgMqji?=
 =?iso-8859-1?Q?n9qfLVmWo0fRVLOcx+FYsK/V1XiroovTKDdjZ+lCHoNeTmKbDg6qWtJ3rV?=
 =?iso-8859-1?Q?k75utknJ/2szoR/H5rh8eJmDGfceBcZnDmQez+GU85uqYCnUIc3c5VKHI4?=
 =?iso-8859-1?Q?Sj4C6E30wmAzVe3m5Xn//97/Uj1myneXGQjWyCr4D3reHcnVcnlp13ozIW?=
 =?iso-8859-1?Q?yuZcThKSulF+Ziw1zMU33Qv0vjlF2AsdgWjF0eeHvApcmAbYu2r3Ede0H0?=
 =?iso-8859-1?Q?yhAUt7u+TjNcK9edB/GW4Xrz+IO9d1F1NH+RyVyUDBd3HXwfpkx5EnE+S0?=
 =?iso-8859-1?Q?oQ5RhcnYJFzd+iRLInJ72cn5T7PBXpUxzOGanPVSxbszWnq3vDMk1b6Kbt?=
 =?iso-8859-1?Q?BYN+0lAw3ngEzdtsq3b9McRr0uH/T5t+8r9yTDwh9kgD5FxBvUca6j4wAR?=
 =?iso-8859-1?Q?Sf78RS0h+VocYCDuQGqxV0m5vZfKMkDJdHTS+x4vF5lQtTmsW10oeEu7cO?=
 =?iso-8859-1?Q?HYNTyS7Eom8aRAa5bTddnrORT9aRy2TrtLwQ0nFd/c0g4F1DBil+C1fZ4z?=
 =?iso-8859-1?Q?QRf+BGGMikpqFXVNF+sumyFV61gEpWs2wwx4M5Z0GE2KmG5AexVdDdj0jJ?=
 =?iso-8859-1?Q?YrJHwByRJoXc8rBlYtbkYLRJPzyVnRbzqh+BJh0I1TKT8wQEq10HsePyUv?=
 =?iso-8859-1?Q?4LO67+vYetT7AI7IylYc8EeJ4ET5EdLBTSG+s0WZCw15Aj2v9DjZfP8lgx?=
 =?iso-8859-1?Q?yFLgOK2mQXdQsqBs6kIKauc8Kl/y3b8s2IJJ6EZiEqfNz+NHK9BLbU1LMC?=
 =?iso-8859-1?Q?Hwl5OegsnmrOWoTDNTcPa03gyztxOu32Yf6qTU7jpXSvKjqOZzEv/tCwSd?=
 =?iso-8859-1?Q?aLJ0DnqRsviyX8S//xJvaP0LncwEXKpvSoH9pRoyD5wxuYkCDvwa7/ALfj?=
 =?iso-8859-1?Q?1hURlpSp9zJdwCVkrKxjW4T2TRGlg/LKgtq0JGGDfrQoXwG5BRYRVxbioi?=
 =?iso-8859-1?Q?nsJMF/jm03awiYFDk0S9t5vA3PGiTuhtE47xvu25WdrcsVgRKPDv3JdYLb?=
 =?iso-8859-1?Q?Xm3zQuatoYnCpG61+HEpq7kGWswmQ9HAFmpyZYMro9lmbJfpxRPPfl8XL1?=
 =?iso-8859-1?Q?0WgyOHCNp6pevr3NilmgPNePoyyPRjUX9BmP/aQF4s71tHmKUSzGGF+Mai?=
 =?iso-8859-1?Q?ROE4q/tJryV3IUBjr7V9nnXzXBK8RPRQRgIA6wEOo2LTuaPNG9NHFa7yRo?=
 =?iso-8859-1?Q?PtSfOydLjYbxCHC0O2oLrhXX/PRdVVf+YAlMtPMpXKuJ+jDsRzyyVAPZQd?=
 =?iso-8859-1?Q?vDk7F9+AtTEDp2k4/uHa6yxG9qoilLrxFmFkU2lSvL5x3VcbfSE2C0ulo9?=
 =?iso-8859-1?Q?IXrPuk3hCJo2jUeI088e1cXEoSp3kURXLTDffc13lkbIyv5bksOclWImIF?=
 =?iso-8859-1?Q?NsZ4yMY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_fe888a76728944b4b45d91742fd790f0BN2P110MB1495NAMP110PRO_"
MIME-Version: 1.0
X-OriginatorOrg: sei.cmu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 90d96368-e403-4f07-421f-08db5e2a8341
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 20:48:08.6607 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 95a9dce2-04f2-4043-995d-1ec3861911c6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1367
Received-SPF: pass client-ip=2001:489a:2202:d::703;
 envelope-from=adhristozov@sei.cmu.edu;
 helo=USG02-CY1-obe.outbound.protection.office365.us
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, EMPTY_MESSAGE=2.32, HTML_MESSAGE=0.001,
 MIME_HTML_MOSTLY=0.1, PYZOR_CHECK=1.392, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_fe888a76728944b4b45d91742fd790f0BN2P110MB1495NAMP110PRO_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



--_000_fe888a76728944b4b45d91742fd790f0BN2P110MB1495NAMP110PRO_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
</body>
</html>

--_000_fe888a76728944b4b45d91742fd790f0BN2P110MB1495NAMP110PRO_--

