Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FEFBDE5F5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 14:01:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90A3-0007yo-I6; Wed, 15 Oct 2025 07:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v90A0-0007xV-7t; Wed, 15 Oct 2025 07:59:16 -0400
Received: from mail-westeuropeazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c201::3] helo=AS8PR04CU009.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Djordje.Todorovic@htecgroup.com>)
 id 1v909q-0007oZ-PL; Wed, 15 Oct 2025 07:59:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ4bPYdKLGcWSbEacFag0pHDmSlQHCB/4bAqEtmSfN+3Xwv76T5IpL082hEhJo46KT6T8XrvckG6cmKt4eqcuAqLq3wCcE7+itK7KLNogamH4mWxfoa459n59Dl4u24M+3xs5tf0wqDl5BrXQE7XVfdcVIaDqhyF4erWUKUB1cedmFmrlssFPff4OC4dBSIxlPeokaeJFVqdlFmM3xgzYUMWmah98MbTRis73k8iIbxfHU00ON5mD9XHHFdGGKLVKI1Eac93mnbO45gy2sctRL/VrFOzlWRRO9YvtNGh7R3rwXr7006mxci93BDQ5O8A6/wAMmpTVFciB6cMja37VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=daZDLOM0NPu2WXTJEd+3tHAgpoPAFJcLIWJybstNoawFz3brJjKjqphrcs6dmdKXWTBYCUz7GPXW5pyhwKBz8mM45tFsGAFmIOT7ag4jKGLtwEkhYFTOLRAUdTTKDJFXEU/+xwzz4VKBZPu14aedrMCSe65MQjctTt0Mocslj8sdydljxBkXELYFzvTGwe3t0o/QwruY/HhuRLYhm23RR4bbTJV1bbUP59kg0aHd6xfauCRDMFpb5u/NPG1BWTkb6ouwJAiwNIG1aIfkMlFLbBkiZPbXqMhA5TswmaT2JjeWX/vcZP+/wkpCq7D4DV/nzEVSTqJIYsiCS8gF5mf/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyW3Q7ZQ6oaIBLODAOp8zDllh3sILwEUmncfhjuRgAc=;
 b=oUOYfUbmApuC3hekjKzwKHx7QdDoOQuVsfHDmQ2Nn7sF2rFdYw/C0EoZ2s397CoUW5uIJjcJfjgLXO4zburlokJHQRXwfjGGiFnJWYfpov+OK8FxEgqglMaEI1lkHnKHFZhDbCFatgehigGiVcxuGWCUS3SwN6x5ynbl5pq6ulUEow0F8UqoUTBYvXRNlmwkgsac/laGVWS9/1opSzodEBHIMM3M32Nr+SGcv8x5yE78VjN5HQeL8X6m7uY7qaLvTcfDx5sBQu7Lwel3apkwkV+WaDBuQLWuEeRFznwWmjD/gagtP3kcGli0TlykK7tPSoRs6NVsrkpE1fh3zvbvgw==
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com (2603:10a6:20b:4fb::5)
 by AS1PR09MB5739.eurprd09.prod.outlook.com (2603:10a6:20b:477::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 11:58:19 +0000
Received: from AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a]) by AS4PR09MB6518.eurprd09.prod.outlook.com
 ([fe80::ad50:891a:847c:580a%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 11:58:19 +0000
From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com"
 <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH v11 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Topic: [PATCH v11 08/13] hw/misc: Add RISC-V CMGCR device implementation
Thread-Index: AQHcPcr+PJvWsY/XPEGOc3C6hQJ9RQ==
Date: Wed, 15 Oct 2025 11:58:17 +0000
Message-ID: <20251015115743.487361-9-djordje.todorovic@htecgroup.com>
References: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251015115743.487361-1-djordje.todorovic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR09MB6518:EE_|AS1PR09MB5739:EE_
x-ms-office365-filtering-correlation-id: 9c8c17f0-ce7c-401a-4482-08de0be22232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?/vK9iPHF0IgUbCLVWiyf4UkWpTlfNzF3VIh4iIglVBfXEHrOpS6m9TBlwa?=
 =?iso-8859-1?Q?VaC4Hi6Gdt3EtcPCKo3rv4/wGBQyACgexUPqPEG5C79m9jeBOGRD2SL/AV?=
 =?iso-8859-1?Q?HTwoczDbOXUGGNwmVGZL8cM/B3iV9VcJw10lqkCjudEUCk0xuXvpHcyZa0?=
 =?iso-8859-1?Q?Z9gLZvWJPoSjsQ2nOffUB2dhqg8C22IHz28z0TIenepXOWF+OkkIr0fd0q?=
 =?iso-8859-1?Q?00LND7MxFPgFMGKxXu9WZqexK7Ob/SQHtCpb619uyDWQ0SYHkGeNSAIgUf?=
 =?iso-8859-1?Q?W/sgTu+XulgZiP3tgWn/4WHklEZefGbdS93xUIio1VMEhfNkau52GkTLPt?=
 =?iso-8859-1?Q?sIj1GQRiDREb8mXzTDZr9QPzanHzWW07q+xPltOfBYlnLcC3hXj3oV0RT/?=
 =?iso-8859-1?Q?n6EOxSWsq2jYg9r2i56XCw5jNz7zosqX193N+Os/bAEmZ9MJsf/VBiXRiM?=
 =?iso-8859-1?Q?0nra9exrCn4gUv36qvaB3KyZbTa8J1E12Iv6YQvPR3cVNvHZS90K92PFU7?=
 =?iso-8859-1?Q?0n73+zCTVx1jdllbUP5v/xAWDDuV+vECa0+G7p/M2zLNZ9wpNFtjE12W7n?=
 =?iso-8859-1?Q?rJ0zt0Y+4w6IX8dxS7ZHQmbjQaW3CeZvfNWOLSYp8B9IIWef19VtJfmjgt?=
 =?iso-8859-1?Q?2k2wuEMfp6Ph5k0gDNbZdE71zWDtG1LCh0EAhQPyoAlJ4gQrDWkCYLebVj?=
 =?iso-8859-1?Q?+itjJKkrPsqx17BKBPv82g/fKy69jjNiTlr0Pr1slERL+x8niCdTXX4rrV?=
 =?iso-8859-1?Q?pNX1QTJWDuwlcnEid/wvID43Br+yHagU8d9+iAiIl/J5vZg+lJJ92nLEtI?=
 =?iso-8859-1?Q?k2fVcSR/OoxXBcVuGvkKW5vnMQfs5uc7KeRKX3qQ7glGvBikBpexNYlTgm?=
 =?iso-8859-1?Q?nYlddB88YiTmnkDpMhc01Z4/H8By2pj9KuaBjXGHy43/cIKG/30bJX3kXK?=
 =?iso-8859-1?Q?KfcCzEx8c2M6Lbk24s2yuyMdHlHPo/ylY9KSgaCQd7g5xaJGf2NFrXaXHh?=
 =?iso-8859-1?Q?yu0sAaaRmKytBLtW9YG4T3Rj7VSMaMpVKqIdWnWRUYpOMuFK2K7WviaKPK?=
 =?iso-8859-1?Q?RDBaTwrEoTnvoGMp7R7IZ7ILYFaMAJotG1wjJ/IL61sQpymAk/+T/GGfoj?=
 =?iso-8859-1?Q?tQ1AoUFAcG3lSEp2Tk8w4njd2DeEOBuY5EgYsm+93TiQpKqVDpOM8Fuyvf?=
 =?iso-8859-1?Q?zNDHosZhkAS/rIjttlFDAE0D7UnY7ZUrtdn8NkR7rBmOXAk4lytur4Qihj?=
 =?iso-8859-1?Q?tvTZCQDgw09LtzsQaGQRs1/uO9eUFvzrGiwtYrFTJ7/szMWqrYeM0R9dpK?=
 =?iso-8859-1?Q?UR3DHs5027XQn/H13t0M19ItliTAtd6ReZrQbR44tZQVRVbIbOYYvgShtk?=
 =?iso-8859-1?Q?PJMTL9iGm9jcVanYVM6NMC+EwM0mB4WBrVOB8ub8AHe7GpPT8hXF7C74KJ?=
 =?iso-8859-1?Q?BmPgsJppmXFm2RPPInBVJ03MGiKZQwzLRncySipxsF2WBemqYNg/h7XtBF?=
 =?iso-8859-1?Q?taGMNHIK+8dbptgW8OIG8qkx3cz3f+us0+c85d4RfY2FVdFRCAvFdli9uj?=
 =?iso-8859-1?Q?+GMD1F+lk8PFdUknYqefwLLCX/+8?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR09MB6518.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yOrLdu/ix6olxgYIaEwumSBxdw523+Co1NGn1Py7ZEdNk32wm84sA2SCU4?=
 =?iso-8859-1?Q?KS5cTbCp8jYANYWSLkG9ULgy2Zo/MN3xuxywRXBnJPt3ZyW3c3yby2rax2?=
 =?iso-8859-1?Q?e2YU0u8S9xUYBQ/Guia2UOuSAyEKvv8CNHTGk9lIFRAt7Ks1xCBhQyK824?=
 =?iso-8859-1?Q?gebQthS9TwUxx5UZfwpyJcoH4htTc+egWdMMarWMstZ3YiMcI63/OO5K7c?=
 =?iso-8859-1?Q?KvYep6wI6Yt0lkCZ/FisJqvL5kUFVL9VJw4XnMuKXPFK/EUclnLMaFijDr?=
 =?iso-8859-1?Q?MtS9HX2wQv6UJIkfs/lkpovvrsY/go3e5RkFZxr6xCd2ZYQrh0OmJQFbNF?=
 =?iso-8859-1?Q?/r4H/G/UpNl/Ksh/g7QH/rwbN8jnnRuLjzoknWxZ+yv48thMU4fLrgx1uL?=
 =?iso-8859-1?Q?owYxeHigMUK4GpRnYA3FoZ82bZ3VKfxwTUqHBr4l69Deag3OMI+bvfyv8n?=
 =?iso-8859-1?Q?4WJyWACQCackAzGBvnT0TVoRwYwQS609bjeXgX/ifestbW9lOwSWS1DPiB?=
 =?iso-8859-1?Q?/gog7tLkpJhFTFnvjKXi/uLxUCsFME7Ic9p6WrPNQ3n6v358ERXfSvyz0c?=
 =?iso-8859-1?Q?oH36pVmR9vzy1yfEXz99kIkgVgD5ScRnfz/gfgdwn9DQQSrrcjfcOLnfIa?=
 =?iso-8859-1?Q?nODr273eEOkEWZnw109yoRo/x4hypCx/bbAoVrGSBuTcvfNVNQJT3l8lpJ?=
 =?iso-8859-1?Q?7BlkR2kYMncEUMlT7mXHkGvY3MqsKJ2hYSChXqk+8GqfAt+HtVR2/4RaCg?=
 =?iso-8859-1?Q?bE3bXg1T/xTMY7B3STxDbf7QLk4YNJrUdb9hAH9h5a5XiJWaKCWdaa1sgU?=
 =?iso-8859-1?Q?qeAaj5KrxSw+XFkq2rAfsdpRdUeM78TiqQ7XmS7BNry4czHeJynsvcGvON?=
 =?iso-8859-1?Q?uY5ZLXV5FUiKJp3OMfVYA40rtR6jldpGxiBy8gz4TCo+C+fZoOnjin7wHZ?=
 =?iso-8859-1?Q?B6Ok/TT5FbrDc8riEYBusBjyhnXoD2lmlI1ladIVOhNFDibiR56TLMg3Uc?=
 =?iso-8859-1?Q?YovxLUHl/gLU/mI/nQRN9ioBH2TqKSREBahPuedc3J/PRASNM/nF+6zcBO?=
 =?iso-8859-1?Q?GJhZ+bOlhe43pAJDSDBUM2/Si2wki36ln9aNwmFenJ2N5crAunPfzyf0+0?=
 =?iso-8859-1?Q?sZ+4lAqf8yYKlYnfZ1fjm/SSr6uaXUbgZv0Eubado8bElFDlbnK2RABQpn?=
 =?iso-8859-1?Q?zfXo+QyiUFuyJkocMfmEVGWqzCRoX7VoDVydpQk1iG4FR6ciddSK6M9Kr4?=
 =?iso-8859-1?Q?JGkHL5IUKCENVXbSaEbA9vmRXgVw0JcJYxIukYx5WhzOhFrT7Q5oRxJSKw?=
 =?iso-8859-1?Q?bF0e8yn8ZbO2MpBYpiGV6WsUTrY3ehkgeC8GxpOlKeI8eWzlE8C4qI1oyi?=
 =?iso-8859-1?Q?gTSvz6NOWvepP4BmGfYaimlmwCGoYrjKUMWDqT4VbuP+AQqg1ledcxKl44?=
 =?iso-8859-1?Q?VktLP/mwyTvUc8rxmsgt7T9a62O12w3N6/aaALHppM8Ab6B7mOyXQTVWgp?=
 =?iso-8859-1?Q?b6c9EnMxvCIyjZwyoF9U7dnMOQ8f2IEKukrfuDXAuWI2JT6LzxrO2UIHkq?=
 =?iso-8859-1?Q?O/aulB7vypuqSnJluCLsAqG6YfIkSuYEGyhBPc/90gDsEOtaiqjEXoacli?=
 =?iso-8859-1?Q?ZN7PMxZ9HujGwrr1UT3NYU7WOBoJxy+ckuRQLNZod0uOMqMHW6ihahnOVX?=
 =?iso-8859-1?Q?SFxS5kQfayJkicdjIL4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR09MB6518.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c8c17f0-ce7c-401a-4482-08de0be22232
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 11:58:17.8115 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IxBJUgLaIZu7XrMLlq3QRmYuF5QbLmSSIsCBv31YUzb9AxPq61JPJvCnOF442N1zZWG1FtgH31uPF9YsFUEGbAPnJMGutTYCTIeXFxX0/Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR09MB5739
Received-SPF: pass client-ip=2a01:111:f403:c201::3;
 envelope-from=Djordje.Todorovic@htecgroup.com;
 helo=AS8PR04CU009.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Add RISC-V implementation of the Coherent Manager Global Control
Register (CMGCR) device. It is based on the existing MIPS CMGCR
implementation but adapted for RISC-V systems.

The CMGCR device provides global system control for multi-core
configurations in RISC-V systems.

This is needed for the MIPS BOSTON AIA board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/misc/Kconfig               |   9 ++
 hw/misc/meson.build           |   2 +
 hw/misc/riscv_cmgcr.c         | 248 ++++++++++++++++++++++++++++++++++
 include/hw/misc/riscv_cmgcr.h |  50 +++++++
 4 files changed, 309 insertions(+)
 create mode 100644 hw/misc/riscv_cmgcr.c
 create mode 100644 include/hw/misc/riscv_cmgcr.h

diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 4e35657468..222efb12fb 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -121,6 +121,15 @@ config MIPS_ITU
     bool
     depends on TCG
=20
+config RISCV_MIPS_CMGCR
+    bool
+
+config MIPS_BOSTON_AIA
+    bool
+    default y
+    depends on RISCV64
+    select RISCV_MIPS_CMGCR
+
 config MPS2_FPGAIO
     bool
     select LED
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index b1d8d8e5d2..489f0f3319 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -157,6 +157,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files(=
'mac_via.c'))
 specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'm=
ips_cpc.c'))
 specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
=20
+specific_ss.add(when: 'CONFIG_RISCV_MIPS_CMGCR', if_true: files('riscv_cmg=
cr.c'))
+
 system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
=20
 # HPPA devices
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
new file mode 100644
index 0000000000..8e7b86867a
--- /dev/null
+++ b/hw/misc/riscv_cmgcr.c
@@ -0,0 +1,248 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * Reference: MIPS P8700 documentation
+ *            (https://mips.com/products/hardware/p8700/)
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "migration/vmstate.h"
+#include "hw/misc/riscv_cmgcr.h"
+#include "hw/qdev-properties.h"
+
+#include "cpu.h"
+
+#define CM_RESET_VEC 0x1FC00000
+#define GCR_ADDRSPACE_SZ        0x8000
+
+/* Offsets to register blocks */
+#define RISCV_GCB_OFS        0x0000 /* Global Control Block */
+#define RISCV_CLCB_OFS       0x2000 /* Core Control Block */
+#define RISCV_CORE_REG_STRIDE 0x100 /* Stride between core-specific regist=
ers */
+
+/* Global Control Block Register Map */
+#define GCR_CONFIG_OFS      0x0000
+#define GCR_BASE_OFS        0x0008
+#define GCR_REV_OFS         0x0030
+#define GCR_CPC_STATUS_OFS  0x00F0
+#define GCR_L2_CONFIG_OFS   0x0130
+
+/* GCR_L2_CONFIG register fields */
+#define GCR_L2_CONFIG_BYPASS_SHF    20
+#define GCR_L2_CONFIG_BYPASS_MSK    ((0x1ULL) << GCR_L2_CONFIG_BYPASS_SHF)
+
+/* GCR_BASE register fields */
+#define GCR_BASE_GCRBASE_MSK     0xffffffff8000ULL
+
+/* GCR_CPC_BASE register fields */
+#define GCR_CPC_BASE_CPCEN_MSK   1
+#define GCR_CPC_BASE_CPCBASE_MSK 0xFFFFFFFF8000ULL
+#define GCR_CPC_BASE_MSK (GCR_CPC_BASE_CPCEN_MSK | GCR_CPC_BASE_CPCBASE_MS=
K)
+
+/* GCR_CL_RESETBASE_OFS register fields */
+#define GCR_CL_RESET_BASE_RESETBASE_MSK 0xFFFFFFFFFFFFF000U
+#define GCR_CL_RESET_BASE_MSK GCR_CL_RESET_BASE_RESETBASE_MSK
+
+static inline bool is_cpc_connected(RISCVGCRState *s)
+{
+    return s->cpc_mr !=3D NULL;
+}
+
+static inline void update_cpc_base(RISCVGCRState *gcr, uint64_t val)
+{
+    if (is_cpc_connected(gcr)) {
+        gcr->cpc_base =3D val & GCR_CPC_BASE_MSK;
+        memory_region_transaction_begin();
+        memory_region_set_address(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCBASE_MSK=
);
+        memory_region_set_enabled(gcr->cpc_mr,
+                                  gcr->cpc_base & GCR_CPC_BASE_CPCEN_MSK);
+        memory_region_transaction_commit();
+    }
+}
+
+static inline void update_gcr_base(RISCVGCRState *gcr, uint64_t val)
+{
+    gcr->gcr_base =3D val & GCR_BASE_GCRBASE_MSK;
+    memory_region_set_address(&gcr->iomem, gcr->gcr_base);
+
+    /*
+     * For boston-aia, cpc_base is set to gcr_base + 0x8001 to enable
+     * cpc automatically.
+     */
+    update_cpc_base(gcr, val + 0x8001);
+}
+
+/* Read GCR registers */
+static uint64_t gcr_read(void *opaque, hwaddr addr, unsigned size)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *) opaque;
+
+    switch (addr) {
+    /* Global Control Block Register */
+    case GCR_CONFIG_OFS:
+        /* Set PCORES to 0 */
+        return 0;
+    case GCR_BASE_OFS:
+        return gcr->gcr_base;
+    case GCR_REV_OFS:
+        return gcr->gcr_rev;
+    case GCR_CPC_STATUS_OFS:
+        return is_cpc_connected(gcr);
+    case GCR_L2_CONFIG_OFS:
+        /* L2 BYPASS */
+        return GCR_L2_CONFIG_BYPASS_MSK;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Read %d bytes at GCR offset 0x%" HWADDR_=
PRIx
+                      "\n", size, addr);
+    }
+    return 0;
+}
+
+static inline target_ulong get_exception_base(RISCVGCRVPState *vps)
+{
+    return vps->reset_base & GCR_CL_RESET_BASE_RESETBASE_MSK;
+}
+
+/* Write GCR registers */
+static void gcr_write(void *opaque, hwaddr addr, uint64_t data, unsigned s=
ize)
+{
+    RISCVGCRState *gcr =3D (RISCVGCRState *)opaque;
+    RISCVGCRVPState *current_vps;
+    int cpu_index, c, h;
+
+    for (c =3D 0; c < gcr->num_core; c++) {
+        for (h =3D 0; h < gcr->num_hart; h++) {
+            if (addr =3D=3D RISCV_CLCB_OFS + c * RISCV_CORE_REG_STRIDE + h=
 * 8) {
+                cpu_index =3D c * gcr->num_hart + h;
+                current_vps =3D &gcr->vps[cpu_index];
+                current_vps->reset_base =3D data & GCR_CL_RESET_BASE_MSK;
+                cpu_set_exception_base(cpu_index + gcr->cluster_id *
+                                       gcr->num_core * gcr->num_hart,
+                                       get_exception_base(current_vps));
+                return;
+            }
+        }
+    }
+
+    switch (addr) {
+    case GCR_BASE_OFS:
+        update_gcr_base(gcr, data);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "Write %d bytes at GCR offset 0x%" HWADDR=
_PRIx
+                      " 0x%" PRIx64 "\n", size, addr, data);
+        break;
+    }
+}
+
+static const MemoryRegionOps gcr_ops =3D {
+    .read =3D gcr_read,
+    .write =3D gcr_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .impl =3D {
+        .max_access_size =3D 8,
+    },
+};
+
+static void riscv_gcr_init(Object *obj)
+{
+    SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
+    RISCVGCRState *s =3D RISCV_GCR(obj);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &gcr_ops, s,
+                          "riscv-gcr", GCR_ADDRSPACE_SZ);
+    sysbus_init_mmio(sbd, &s->iomem);
+}
+
+static void riscv_gcr_reset(DeviceState *dev)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+    int i;
+
+    /* Update cpc_base to gcr_base + 0x8001 to enable cpc automatically. *=
/
+    update_cpc_base(s, s->gcr_base + 0x8001);
+
+    for (i =3D 0; i < s->num_vps; i++) {
+        s->vps[i].reset_base =3D CM_RESET_VEC & GCR_CL_RESET_BASE_MSK;
+        cpu_set_exception_base(i, get_exception_base(&s->vps[i]));
+    }
+}
+
+static const VMStateDescription vmstate_riscv_gcr =3D {
+    .name =3D "riscv-gcr",
+    .version_id =3D 0,
+    .minimum_version_id =3D 0,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT64(cpc_base, RISCVGCRState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static const Property riscv_gcr_properties[] =3D {
+    DEFINE_PROP_UINT32("cluster-id", RISCVGCRState, cluster_id, 0),
+    DEFINE_PROP_UINT32("num-vp", RISCVGCRState, num_vps, 1),
+    DEFINE_PROP_UINT32("num-hart", RISCVGCRState, num_hart, 1),
+    DEFINE_PROP_UINT32("num-core", RISCVGCRState, num_core, 1),
+    DEFINE_PROP_INT32("gcr-rev", RISCVGCRState, gcr_rev, 0xa00),
+    DEFINE_PROP_UINT64("gcr-base", RISCVGCRState, gcr_base, GCR_BASE_ADDR)=
,
+    DEFINE_PROP_LINK("cpc", RISCVGCRState, cpc_mr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+};
+
+static void riscv_gcr_realize(DeviceState *dev, Error **errp)
+{
+    RISCVGCRState *s =3D RISCV_GCR(dev);
+
+    /* Validate num_vps */
+    if (s->num_vps =3D=3D 0) {
+        error_setg(errp, "num-vp must be at least 1");
+        return;
+    }
+    if (s->num_vps > GCR_MAX_VPS) {
+        error_setg(errp, "num-vp cannot exceed %d", GCR_MAX_VPS);
+        return;
+    }
+
+    /* Create local set of registers for each VP */
+    s->vps =3D g_new(RISCVGCRVPState, s->num_vps);
+}
+
+static void riscv_gcr_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    device_class_set_props(dc, riscv_gcr_properties);
+    dc->vmsd =3D &vmstate_riscv_gcr;
+    device_class_set_legacy_reset(dc, riscv_gcr_reset);
+    dc->realize =3D riscv_gcr_realize;
+}
+
+static const TypeInfo riscv_gcr_info =3D {
+    .name          =3D TYPE_RISCV_GCR,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(RISCVGCRState),
+    .instance_init =3D riscv_gcr_init,
+    .class_init    =3D riscv_gcr_class_init,
+};
+
+static void riscv_gcr_register_types(void)
+{
+    type_register_static(&riscv_gcr_info);
+}
+
+type_init(riscv_gcr_register_types)
diff --git a/include/hw/misc/riscv_cmgcr.h b/include/hw/misc/riscv_cmgcr.h
new file mode 100644
index 0000000000..c57d4ada1c
--- /dev/null
+++ b/include/hw/misc/riscv_cmgcr.h
@@ -0,0 +1,50 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Pub=
lic
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2015 Imagination Technologies
+ *
+ * Copyright (C) 2025 MIPS
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ */
+
+#ifndef RISCV_CMGCR_H
+#define RISCV_CMGCR_H
+
+#include "hw/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_RISCV_GCR "riscv-gcr"
+OBJECT_DECLARE_SIMPLE_TYPE(RISCVGCRState, RISCV_GCR)
+
+#define GCR_BASE_ADDR           0x1fb80000ULL
+#define GCR_MAX_VPS             256
+
+typedef struct RISCVGCRVPState RISCVGCRVPState;
+struct RISCVGCRVPState {
+    uint64_t reset_base;
+};
+
+typedef struct RISCVGCRState RISCVGCRState;
+struct RISCVGCRState {
+    SysBusDevice parent_obj;
+
+    int32_t gcr_rev;
+    uint32_t cluster_id;
+    uint32_t num_vps;
+    uint32_t num_hart;
+    uint32_t num_core;
+    hwaddr gcr_base;
+    MemoryRegion iomem;
+    MemoryRegion *cpc_mr;
+
+    uint64_t cpc_base;
+
+    /* VP Local/Other Registers */
+    RISCVGCRVPState *vps;
+};
+
+#endif /* RISCV_CMGCR_H */
--=20
2.34.1

