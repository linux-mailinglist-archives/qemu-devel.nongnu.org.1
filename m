Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 943277C5587
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:34:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZKY-0006id-9Z; Wed, 11 Oct 2023 09:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asad.javed@basemark.com>)
 id 1qqVM7-0006WK-LQ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:18:16 -0400
Received: from mail-am6eur05on2132.outbound.protection.outlook.com
 ([40.107.22.132] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asad.javed@basemark.com>)
 id 1qqVM5-0003s4-6b
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 05:18:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmosCAM9gDT7RhdcEul5F3bahw/QPOv0BO+EniWjNfbRCSGavAHqpVYG252pIS4epF3O2CrnHx0xc7DGvCsSL2d0QHk3MjkQM4NDKTJi5F5VDIwxc7GpP5DfXfG9snLh85DV+SQOl7dWPqVjwY03lOvZZZ7yWOXx0J8N3IuxNtsXoiB3CYeaZ4icneG5SdECIl50G8aahWxg6VLQNINhfEB0cnjncN7JT/SbNy5IhQH+LjsZFkjyQTRX2i/DntBBQQKbopOLaRPPFt5P0G0PZ8saxPZs/N9YTX5uQCUxeJvNzMWzTNRqtGMp/LsZP8yzABgtVh/z1eCLk9+s1RESBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVc8aH0DLLxqcdvXTro4F3MsNUXN3MWYRJLBRNtwQBk=;
 b=kdHNck9OKD961a8s5VksKOmaFMQS+ZYge4MrUB88PXoJ5kqlXCQLy/auUS1HfP0PaYekW8k1GCGWT5QMndek4IAJAr5WoBlZmUTcOKGxo2SKvFYq1VKkAFCEaE2SNkeIln9g5WlrR3/fDZdw9QH2FGOB0JdqspAL+eb9ruqkhrk8jNLFtRtb3VgQhoF/+EB+8dehjTw3KVcaMo8PIzTAV5fao9AhVv8afD6Ss/+Ab9VR8+/VAPzUsMdNbFPjca50VcNrO8ZPZ6ssSE34U3k70xyT0G5huIA1xo8khR5JHU2shAR9PnvvNKM819yc3cxF73p/uiymzVpWyB5Z0E8hBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=basemark.com; dmarc=pass action=none header.from=basemark.com;
 dkim=pass header.d=basemark.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=basemark.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVc8aH0DLLxqcdvXTro4F3MsNUXN3MWYRJLBRNtwQBk=;
 b=E0YTAcddonxCHuvVs36m4YXgR6JPkhAG9QnVH84I5+NPoOYFQE0s3DHVSukfXEvX0a4biIcJINaM8urcVD1Om4t0Zc3TedQFu09rheDEuP4RRxJV2kztMhBa1dK75iICbbVxmfIJtvYWqlOhQ3NfF72mBHEjO471tUZz0dzJKt2suu/GmzpHSzwcgWTp6FJ/dVpQ4E280qCGVy7EWtjaSELgVdMB7VFPijbJvPUuJo9UlipHc1+qc/IINoMnj1Er8gBpTBABzdJ4fctHuXVbzdz1WrPzOn1FI6r58s+Hycb11IXmEvnvLK7z9CRgLNMr70dczn5R/w2oaIkJzEmEgg==
Received: from GV1P191MB2194.EURP191.PROD.OUTLOOK.COM (2603:10a6:150:9e::7) by
 DB9P191MB1913.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:24e::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.41; Wed, 11 Oct 2023 09:13:06 +0000
Received: from GV1P191MB2194.EURP191.PROD.OUTLOOK.COM
 ([fe80::f898:964c:2f65:f9f7]) by GV1P191MB2194.EURP191.PROD.OUTLOOK.COM
 ([fe80::f898:964c:2f65:f9f7%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 09:13:06 +0000
From: Asad Javed <asad.javed@basemark.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Running cross-compiled binary using QEMU results in segmentation
 fault error
Thread-Topic: Running cross-compiled binary using QEMU results in segmentation
 fault error
Thread-Index: AQHZ/CFwHpzifbYdsEmq6NKrRrgr1Q==
Date: Wed, 11 Oct 2023 09:13:06 +0000
Message-ID: <GV1P191MB21946E51ECBE3A5CADE0B208F0CCA@GV1P191MB2194.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=basemark.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P191MB2194:EE_|DB9P191MB1913:EE_
x-ms-office365-filtering-correlation-id: a1b41a7f-4454-4be1-22ca-08dbca3a47bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2lzHl3EzlHPr/bqYyvROUu7IrxrsyPLOOIF7Yts3wcC2qqpYxHwakR6a6tFWRFvsx9pkpo0COpx/jGyyrkl0GbE3yKj5n0d7QfWbt5iyh7Zs59jEoZICSwL3Zrprp77werdowE7lZNfwsnDMuAi4ZuKOaIScGrAgsQQ7726RjTVFeUpGKGrKgPNAb5GafdBpy3Jufh2Kc+AEbffFaiafNbY5qVaXBSKxEZkm+ORLXUzn/Lr/Vm/86105pszD5zf/wANyOXOFNSrwbBiTwg52yQILNefM6ZmQi8SRHlDNPFrxMqsXm6JhGuyDAAj4KIhbJiKI+W+uQj221LaVLApwNBjIaE8E5p2a5+y1xpfHiNbTBqnHmMfpg35lKW/X/T5v99WWwm5G1mS7a/eDQcqjIe8dVbrUS4juT1Hn8Nz9dN9fbq/V8XKPUgnN9QfYD2EoWV5jUMJv9uh1jObHJLBRBob9a7OpoSm1eOeO3uXR3iGxx2CDybibDZe3nxXVb/ZQRD8ZiO3hLyfK1jNY2cz90cr09HnTDyboji8a7TWXvEFmlSlkNzsMDrxLoi5g/6GjowCdqxpPSPINDV8HGqh7cVvaImMB6RNJyIMGzLZeleI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1P191MB2194.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39840400004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(26005)(19627405001)(71200400001)(33656002)(38100700002)(478600001)(166002)(38070700005)(6506007)(1015004)(122000001)(7696005)(9686003)(64756008)(66946007)(76116006)(66556008)(66446008)(41300700001)(8936002)(8676002)(6916009)(316002)(2906002)(86362001)(55016003)(66476007)(5660300002)(52536014)(44832011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eNKvpU9fmcydKfVQyG2DDJTYqea8mRVv/56rZSMDNeuInIi+KNjSmbaWCV?=
 =?iso-8859-1?Q?maHbp3KfFuIHtC6HworIluMsK+WSTzYOCWLuYQGUgoxzNUQ8a/VyViLNjn?=
 =?iso-8859-1?Q?ZDS8rqZIcizENEDFtaCtPpBOJx0LY9G4SeYuL/s0QPTa19WgCkeFnu4KJV?=
 =?iso-8859-1?Q?mm6r1NIvZgQjCZLbmts/1mquX1m89W0FhIxwq1Jw79SJPvTX0uKwdeYa14?=
 =?iso-8859-1?Q?ra6OOVRsbx9yt9+CNM9PPq308fYWPnW3ooEUJVd91ML9HKnFbW3hEB6aY2?=
 =?iso-8859-1?Q?T4ZuP2/z2aLQ3t/JvnbiWqxjyaimFsyDYMr6l6WAsMDzg9IootVXm4+BKm?=
 =?iso-8859-1?Q?c1f6c+u1pTF2PYvofiO03xxM3zp9LFt3ql6TVB9cXwz1I9qG4tnd81i/E6?=
 =?iso-8859-1?Q?7zwdULrrx3jQ5hvpZ4wR6iDV0QXBII2Hx7mZj2T1VeZGvUBWbUgM8RH0KR?=
 =?iso-8859-1?Q?e9q2nT+AOzpTiDXQh8Oe5hG3UWQ55kDGc1ts5NosBBOpc3/EmjijPalHm3?=
 =?iso-8859-1?Q?TG/jo4VHlEpVCBEdh4wX7BrY4I/mcbHXUHZElGpx8wH9GqMKMWDDker/FE?=
 =?iso-8859-1?Q?g6uj5JOhN/g5KlzrQT/kqvYziaOXJR8RYWEcqjiykCW47QLQQqmG8RhLi/?=
 =?iso-8859-1?Q?BA0iRGYPVWUCBCQ/4gaC9NDSivE5MZDNFmi0ODFU5jKx8Ff/peZgTbo4Fy?=
 =?iso-8859-1?Q?Aad+y39OnlVxZhMOy9amn82UG170XnstbwmDB59F6Pi4mpRtC7bgZbatCb?=
 =?iso-8859-1?Q?mSJB3Og1wiIZNnA7JHX8/JSq6VlB+eKfKrfsGVGIEYX7f8hbK7UW4hqZiM?=
 =?iso-8859-1?Q?jlwvvNALa7nekbyFa+ocNHs0uYIsOVubOyChPp0Ru2oLSrZG+bb/7A6h2h?=
 =?iso-8859-1?Q?HRx/V+6xg0/pT0nJolqD1/FttshvBLOv6dNFka1yGlzZwLk6JIBmmpF5MS?=
 =?iso-8859-1?Q?F/cm/aBaEf+onhRqJfEMH00672WO/wENnweKmzDOFjBId3Rr5b2b146DGr?=
 =?iso-8859-1?Q?OOVfmvdS84381SUUEPuuNmRBbILR1gPq0Tcwfs+aMjAqOFiV5Y0yTSaXEZ?=
 =?iso-8859-1?Q?ROTRoIWHbZkvb+2BdtVArG3IaGFfj3e8vY3lCNR4FKlk5+me/QA+EKV5sl?=
 =?iso-8859-1?Q?KLgWBDyT9BMCYL3vfkYLTNjnfS8sMoO4QtQp1jMf/PzkgIUBDEravPXQXr?=
 =?iso-8859-1?Q?eZ/0PdEvTLB18p2gomT5N8YBxYuWqeNCrqto2qAk7joMop+SKZ+VHMJCSa?=
 =?iso-8859-1?Q?8BsCuJM64/d0byRxtXW3NBLwXxJu0p3QQBGT0KFs1T3QxAMdoTM/BsEeZf?=
 =?iso-8859-1?Q?rlOPWyctugJam79gGXSRP5BE9dhUaYs82pa3IA0dQj/T1eyqd6MGYbxiAH?=
 =?iso-8859-1?Q?IyMVaOCtwN0Chi6dz9s1/ab6jIwS1twZZIhA3AM/HvmhbAmyommW3Ti2+n?=
 =?iso-8859-1?Q?a07rGi5aSKIgQAej7qrxV3Uh3vJQxEJt50ueoanQM1D57f9fVCpFSnBPnP?=
 =?iso-8859-1?Q?gxYsnLd+b2wGm3xJCAdoyosRnDQ+t7pa55xBeMXtYiAGHWhdC9XKlCWfnF?=
 =?iso-8859-1?Q?bUAFSicndFw9xs+wLwDusvAAnn/CwggbwvCFly82VGMA9vpJV98oKbCSCH?=
 =?iso-8859-1?Q?wFjOHXyvr3SIpLXmpBeXbOHzs39EUPYpHD?=
Content-Type: multipart/alternative;
 boundary="_000_GV1P191MB21946E51ECBE3A5CADE0B208F0CCAGV1P191MB2194EURP_"
MIME-Version: 1.0
X-OriginatorOrg: basemark.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P191MB2194.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b41a7f-4454-4be1-22ca-08dbca3a47bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2023 09:13:06.3251 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 71a22576-0d7e-4b8e-8d91-85cbf1ed0a6d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyQaypNpVShFTFu7pNZ8OHJadc3ls16EWqlkoPLELmzfN60fZFqsrFCPY5yW4sS9NQ6NFvTBCnPgjWDBvO8UpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P191MB1913
Received-SPF: pass client-ip=40.107.22.132;
 envelope-from=asad.javed@basemark.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 11 Oct 2023 09:32:11 -0400
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

--_000_GV1P191MB21946E51ECBE3A5CADE0B208F0CCAGV1P191MB2194EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

We have cross compiled a simple hello world program for QNX SDP 7.1.0 on Ub=
untu Focal x86_64. Running the binary using qemu-aarch64 results in segment=
ation fault error. The qemu-aarch64 version is 5.2.0.

Steps:

1. Source QNX SDP to set some environment variables.

     source ./qnx710/qnxsdp-env.sh

2. The hello-world.c file:

     #include <stdio.h>

     int main(void) {
         return printf("Hello World!");
     }

3. Compiled using the QNX compiler.

      $ qcc -Vgcc_ntoaarch64le -o hello-world hello-world.c

4. Running the binary as it is results to:

      $ ./hello-world
      aarch64-binfmt-P: Could not open '/usr/lib/ldqnx-64.so.2': No such fi=
le or directory

5. Running using QEMU emulator results to segmentation fault.

     $ qemu-aarch64 -L /home/vsts/qnx710/target/qnx7/aarch64le ./hello-worl=
d
     qemu: uncaught target signal 11 (Segmentation fault) - core dumped
     Segmentation fault (core dumped)


We also tried Ubuntu Jammy which has qemu-aarch64 v6.2.0 but got the same e=
rror.
Can you tell us how we can emulate the binary that is built for QNX on x86_=
64 platform using QEMU emulator? Any help would be much appreciated. Thanks


Thanks & Regards,
-------------------------
Asad Javed

DevOps Engineer
Basemark Oy
Helsinki, Finland
Tel: +358 50 3518175
www.basemark.com<http://www.basemark.com>

--_000_GV1P191MB21946E51ECBE3A5CADE0B208F0CCAGV1P191MB2194EURP_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We have cross compiled a simple hello world program for QNX SDP 7.1.0 on Ub=
untu Focal x86_64. Running the binary using qemu-aarch64 results in segment=
ation fault error. The qemu-aarch64 version is 5.2.0.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Steps:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
1. Source QNX SDP to set some environment variables.<br>
<br>
&nbsp; &nbsp; &nbsp;source ./qnx710/qnxsdp-env.sh</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
2. The hello-world.c file:<br>
<br>
&nbsp; &nbsp; &nbsp;#include &lt;stdio.h&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;int main(void) {</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return printf(&quot;Hello World!&quot;);<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp;}</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
3. Compiled using the QNX compiler.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&nbsp; &nbsp; &nbsp; $ qcc -Vgcc_ntoaarch64le -o <span style=3D"letter-spac=
ing: normal; font-size: 16px; font-weight: 400; background-color: rgb(255, =
255, 255);">
hello-world</span>&nbsp;<span style=3D"letter-spacing: normal; font-size: 1=
6px; font-weight: 400; background-color: rgb(255, 255, 255);">hello-world.c=
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal; font-weight: 400;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal; font-weight: 400;">4. </span><span s=
tyle=3D"letter-spacing: normal;">Running the binary as it is results to:</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;">&nbsp; &nbsp; &nbsp; $ ./</span><sp=
an style=3D"letter-spacing: normal; font-size: 16px; font-weight: 400; back=
ground-color: rgb(255, 255, 255);">hello-world</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;">&nbsp; &nbsp; &nbsp; aarch64-binfmt=
-P: Could not open '/usr/lib/ldqnx-64.so.2': No such file or directory</spa=
n></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal; font-weight: 400;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal; font-weight: 400;">5. </span><span s=
tyle=3D"letter-spacing: normal;">Running using QEMU emulator results to seg=
mentation fault.</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;">&nbsp; &nbsp; &nbsp;$ qemu-aarch64 =
-L /home/vsts/qnx710/target/qnx7/aarch64le ./</span><span style=3D"letter-s=
pacing: normal; font-size: 16px; font-weight: 400; background-color: rgb(25=
5, 255, 255);">hello-world</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;">&nbsp; &nbsp; &nbsp;qemu: uncaught =
target signal 11 (Segmentation fault) - core dumped&nbsp;&nbsp;</span></div=
>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal;">&nbsp; &nbsp; &nbsp;Segmentation fa=
ult (core dumped)</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal; font-weight: 400;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<span style=3D"letter-spacing: normal; font-weight: 400;"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We also tried Ubuntu Jammy which has qemu-aarch64 v6.2.0 but got the same e=
rror.<br>
Can you tell us how we can emulate the binary that is built for QNX on x86_=
64 platform using QEMU emulator? Any help would be much appreciated. Thanks=
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks &amp; Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
-------------------------</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>Asad Javed</b></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt; color: rgb(102, 102, 102);"><i>DevOps Engin=
eer</i></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt; color: rgb(102, 102, 102);"><i>Basemark Oy<=
/i></span><i><br>
</i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt; color: rgb(102, 102, 102);"><i>Helsinki, Fi=
nland</i></span><i><br>
</i></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt; color: rgb(102, 102, 102);"><i>Tel: +358 50=
 3518175</i></span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-size: 11pt; color: rgb(102, 102, 102);"><a href=3D"http=
://www.basemark.com" id=3D"OWAfb6090d9-8ee9-8633-c73d-5a3a7b27a363" class=
=3D"OWAAutoLink" title=3D"www.basemark.com">www.basemark.com</a></span><br>
</div>
</div>
</body>
</html>

--_000_GV1P191MB21946E51ECBE3A5CADE0B208F0CCAGV1P191MB2194EURP_--

