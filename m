Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9904C712C10
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 19:51:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ba6-0000AR-TK; Fri, 26 May 2023 13:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adhristozov@sei.cmu.edu>)
 id 1q2ba1-00009s-2y
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:50:22 -0400
Received: from mail-cy1usg02on0731.outbound.protection.office365.us
 ([2001:489a:2202:d::731] helo=USG02-CY1-obe.outbound.protection.office365.us)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adhristozov@sei.cmu.edu>)
 id 1q2bZu-0003rR-6q
 for qemu-devel@nongnu.org; Fri, 26 May 2023 13:50:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector5401; d=microsoft.com; cv=none;
 b=xy71GtQJMNhNzWwQE9bXTz8TM+84IBRmLN5Rn9oVmOFuO0OlvUVLx/7JeFPXPnMfiaeItsZjX9JpAGg9S2znxt+tY9js2vbKLtfG+CqtdfKkPXwf4vQmZYfeLg58Xq8UQct6WGx8JVvL32+ZLA83atQ5ByGtHQ5Mp5pKWJvFYkrXfX3aJnMZKFrF4m3HUc5oXWumBFti2/ExiPXW5QbYTBGWCe5lrMSRNT/uHZyXuAVplQiEiknVXBkk3AyxNpzUwJ5lGP8a5y327EMK6OhLoVUFhpaik35uXty4XdDrCEFNEXKUgar+6OJi+vKE17qAWDa59BQwNIc/pLiEHt7WAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector5401;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/aRxmD6qZCiROAGC3DEyal5Zk9kAd0FIzeC1ayOTLk=;
 b=SQhB3li2LwQkPMeRw6LT/3OlyG22VJuhaVCvCGnGbX8W+t6rOUvFbVxnrkatt0WQSirjkpr+GITes00niVBbflHzyL6HUSQ1UrzVZY8ng5tum3yL9q3C+Hwu4ZqTCJ2XzchGKu6Pi57LMCS6ctOIR523tmXedqjL1Xtp+w/QUO2Hv3PZsJIUUKxacBT9TlRhU3Ydrcfy5YfoH43y0CN4n1/biANjcjfmNwtyb5lx0sA06TAM8asCTn1PA2NjdjUT6CqyW7D/j4uxGqVpdbWaD+KHwCvJdbADL385hlvcz30MOsvldTNXZIHmbd4lywHRAiyFEYaqCsO+4uYWd6tj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sei.cmu.edu; dmarc=pass action=none header.from=sei.cmu.edu;
 dkim=pass header.d=sei.cmu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sei.cmu.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/aRxmD6qZCiROAGC3DEyal5Zk9kAd0FIzeC1ayOTLk=;
 b=ORVer9QoaYin0KsNzS242MOe4t4p4Ar/YG8bicSscyoZbcysIGzy3po6SWHwRwiMTYyNxenLGnneELgiAAfKYabDn7rYLj2hjtR/zdSb7ltSlPQ6oNB8OLq+MUPwUApPXqr2/wfcdoDbxxzv2bVXorVj5FI4va+8e3MVqF2sMto=
Received: from BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17d::9)
 by BN2P110MB1511.NAMP110.PROD.OUTLOOK.COM (2001:489a:200:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 17:30:56 +0000
Received: from BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c0b8:7aa4:335d:f290]) by BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM
 ([fe80::c0b8:7aa4:335d:f290%6]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 17:30:56 +0000
From: Anton Dimov Hristozov <adhristozov@sei.cmu.edu>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Multiple UART for virt platform on qemu
Thread-Topic: Multiple UART for virt platform on qemu
Thread-Index: AQHZj/V1RKNBKTyyMUGVtkOrGnfbCQ==
Date: Fri, 26 May 2023 17:30:56 +0000
Message-ID: <f5c84fc8804f48fc81826e6930fd7ced@BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sei.cmu.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN2P110MB1495:EE_|BN2P110MB1511:EE_
x-ms-office365-filtering-correlation-id: 79b25070-4e84-4003-1427-08db5e0ef6c0
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9Ff8igzy/rP5UWad8x2diepMDrHNeUkA2LdGrWTCQazxPRUioHMXYiqO1LXDwO/tTnX/wr8WUorPeVU7HTsfnNCv8NY6NoAYJwasjAF89hXj8AffePC3nV/9etNlnQohqH4JqOe/GkjnsNDfjaZ6GktymXQtUMj0Qph5DVu/a2gJxo05frze4/pxdFaHDDglnoxhuA5yYlSb0wRtvwfv1N6W0GZl2Sk2UA1ZwZB1Ad/4uq+FUSBG+4P0WwFhBOoBc4eKbAb4d2OjNeNJmqb8IttVlOA/PCMHaVZ0cyMZetMUoqtNyROV6Wz19jUmWxXGBOSlXvdsekLq1LuTqp6Rwi+Mz3IUIV73Xd/lS6JU9A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230028)(39830400003)(366004)(136003)(396003)(451199021)(38070700005)(73894004)(186003)(86362001)(19627405001)(64756008)(6916009)(66556008)(4270600006)(2906002)(76116006)(66476007)(66446008)(66946007)(82960400001)(6506007)(9686003)(26005)(8936002)(8676002)(38100700002)(41300700001)(5660300002)(75432002)(55016003)(41320700001)(108616005)(24736004)(7696005)(122000001)(71200400001)(508600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: OQ330gDhHSF6A2xqUGX/o815O+X1Jf5hJLYobUms9gQvr2XYV0qgabO8qR+IegIAHkQuO2KsfCv7i37S5gHZi1G4Njo1bMaG8LKj3yHheFDINoeTZ9BPE2m6zTDhonoubcPQ+xGuCVZhY8ADxJvCJq97ojlS91fH4zOO0lfbNLFtqaJPJPSe8LzaliNB0tkqz0IQO3jJr0OQ2Kjylc5sqOHDEkr3KKXBxoYU6GM/uDH75qmVpNtzELcSR3ZaOLH//xVJAifc3RvYf+zo1BzlNC+F2Q0hir43KBIx/5D1qTB9q243+RlOYZU0swN+0wR+57c8pGOfLjp9HgUInIZm4Ei0uPcsk5p3vB7Z93LCxCus1jhvTJD7SLmiC2NLVIqs/Gf0QJmOijjXUmEfZhyp8D7/cJlBQPzXxR9k7bxp9wo=
Content-Type: multipart/alternative;
 boundary="_000_f5c84fc8804f48fc81826e6930fd7cedBN2P110MB1495NAMP110PRO_"
MIME-Version: 1.0
X-OriginatorOrg: sei.cmu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN2P110MB1495.NAMP110.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b25070-4e84-4003-1427-08db5e0ef6c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 17:30:56.5319 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 95a9dce2-04f2-4043-995d-1ec3861911c6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN2P110MB1511
Received-SPF: pass client-ip=2001:489a:2202:d::731;
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

--_000_f5c84fc8804f48fc81826e6930fd7cedBN2P110MB1495NAMP110PRO_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



--_000_f5c84fc8804f48fc81826e6930fd7cedBN2P110MB1495NAMP110PRO_
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

--_000_f5c84fc8804f48fc81826e6930fd7cedBN2P110MB1495NAMP110PRO_--

