Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B2AAEAB73
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Jun 2025 02:06:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUwad-0000f1-02; Thu, 26 Jun 2025 20:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUwaL-0000eh-Vl
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:04:54 -0400
Received: from mail-northeuropeazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c200::1] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1uUwaF-0007Jy-6z
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 20:04:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENCRxb4ZOtWX9MaiAh5WAx3h/P6fdh81CCErA4FqdAUcbh9Cq8UZCur8b3V3WWlKajwsCwyCa/qaPI8B+GWmLYOufctnM1v4dj2ECIZUgoWEp+Om+8FbrhqDg2kV2C32TS0Uw3U83+Q+QJu3C7Li9yfG0OLLG68GUfMQtgohGlXlEIhaXC8d77ucdZCqEOW0ZbUJd00fwnCz6bLOwn9b0sOQfCyTPyBDiI7nA5HmGqUBTcw4KqewxtntaUBp/uxgzvpG/bDQ0EvhaIAHlQ2OJmx1cwwR21pSuCwjzfjnFOoWUkIUYFUOm/7u+yCCbz45+u+Yx3p7/IvUfClls6iuSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xt9uRcqJaNKm2rado6Do/CoaRiqGrANrEhvDr5WFT7U=;
 b=ytiSksW0Ao/dUQae6hsoUmMKyG7Oy/BB9hSsiLITn9h4kn6OmH4kGDSFL/BjFNQpdbtrQEJAmcxatLG/YW7Kcm+XSNEvsHwG8VuPfZ3ISboCIJATJx2TmkvdigzniI57AxVrIHD0A9SFnmnFh5S3l6JGqBkhv/L+gh/tL/cQiTFF6m8IIV96SQ/q0/Fq6567h1mpvEdtAX3dT3w7qU4tpXIMu5MB5uSvRCY8K4PHjDrEgg+eZnEeXRtYfqnLiaR0BjguFz7amFcJl6QdkqYopcO3S0ePSfk6koJEBSwl07HcxSMgbQx+CTgF0BqwJ2+NRuhZwAetGEEty/FBw4mLbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xt9uRcqJaNKm2rado6Do/CoaRiqGrANrEhvDr5WFT7U=;
 b=uu76sD/2Cxlz0r1thBRW7RRC1yNDiAa2YurPyjyHByHiWTs0TPcTlQpoL+CySkDGG9ZrrOBkYAa1pvZSC4VbDoa41hB0+HQ+uRSHX02KVqIj5aFDz+GuHqZArMoeDM6vz7BWRutnsMdLnsKGa+4vM7JzLPKupQDCbVGhhtnvN3bugpPaCzhT0s+QThkES0davqjc24SB5tVJsjYp7vmvH4H550H1Aez5SpjnsIxl1xgsT+ED60RZRV4in8f9Kf1lx/1jzcR/8PmdPNJxNHQ3Tcy8yj+tC/YyPArAQAncTN++kPMAXu07zggCuPQAX3zHzlBSdyNkqIw4/sQvYn/Nzw==
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com (2603:10a6:102:ed::17)
 by VI0PR09MB6925.eurprd09.prod.outlook.com (2603:10a6:800:248::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 27 Jun
 2025 00:04:03 +0000
Received: from PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024]) by PA4PR09MB4864.eurprd09.prod.outlook.com
 ([fe80::a02b:9d5c:eca5:e024%4]) with mapi id 15.20.8857.026; Fri, 27 Jun 2025
 00:04:03 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "cfu@mips.com" <cfu@mips.com>, Djordje Todorovic
 <Djordje.Todorovic@htecgroup.com>, "philmd@linaro.org" <philmd@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "berrange@redhat.com"
 <berrange@redhat.com>
Subject: [PATCH v7 1/1] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v7 1/1] Add support for emulation of CRC32 instructions
Thread-Index: AQHb5vb9v5TBiz7ZyESvSWpIvLaq7Q==
Date: Fri, 27 Jun 2025 00:04:03 +0000
Message-ID: <20250627000246.1811052-3-aleksandar.rakic@htecgroup.com>
References: <20250627000246.1811052-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250627000246.1811052-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR09MB4864:EE_|VI0PR09MB6925:EE_
x-ms-office365-filtering-correlation-id: 3e03d6c7-fdd9-4c78-bd17-08ddb50e2063
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?GvwGdIwayGAEInji1gqhDuf/3jzKOr7UxPn5mifOt8Ug6TdlgAlKnH6oBO?=
 =?iso-8859-1?Q?6C5FGETSRUQccU9z7Tqy6gHjiOt7///prJm2HDbbEjAhZ+wLmiERU5PBZY?=
 =?iso-8859-1?Q?GrpBDAYWuHasrC53SRy2ROK56g3aXmWFzNEE1XbIhdYeFfaLHwH10ok+pJ?=
 =?iso-8859-1?Q?tkBxU1yoNQ0VtidVm8qVSqIXEMcdgIIIR3T7JIX/cT0UvTfMAsq2wylvGl?=
 =?iso-8859-1?Q?N2tF2fJYbQLdymUHKQmRZkaJgTA3O2MEOM5PC1Ob6su3uBObBMvqnCvElk?=
 =?iso-8859-1?Q?xlcWCdHrRpXVCrDUhbK84FkCmtiOPWpUrTKVJDiKbiCoZOXwSDl4OLW/fw?=
 =?iso-8859-1?Q?SmjQfDV2avLQbczDDJAOizm+5bhuMSt6HCUfKHuyldHy+lN18M2rsBjFa0?=
 =?iso-8859-1?Q?czIYIQas3wokWqFBZlIu0vmrWt9HeO8e3uotgwl8T4ji4Ow+/gMazEllSj?=
 =?iso-8859-1?Q?J9exyOQuLTSf6IgJPr+FlFAa4vtdcNXhyU0fBbVftU2bpjQ/off/t07RGd?=
 =?iso-8859-1?Q?sEPfEn7r5bVkpVPH0QkXgcgui7IAgijRUvx2pKAcv+LZWZe42Ykd6f0mJy?=
 =?iso-8859-1?Q?vD5xjgz5Qoe7moqKOFCPWtRKbseckG4S82E0glmX6fpLQ9CjGHvjE35HR+?=
 =?iso-8859-1?Q?pB93bNvm45LGZU0pkpv+5sifloBdggVryCTymFpN4fJQboEJh6jByfihKP?=
 =?iso-8859-1?Q?dwtOxQHHnmWTkYTrQmV48jZlEZLjRpvgSS1NK37ZvJuQAhJ7TBqhVNZnwu?=
 =?iso-8859-1?Q?5hhTtATvhDFvuGaGqTFRFfdvNWihnXQWtojkC/DGmu9PXWXL0dUYCCrZje?=
 =?iso-8859-1?Q?L1CNyDG3eR/BJIW6IxjAHQTfhTYDkDbq8aNgeLED74MKk5oQp5USXvDgS3?=
 =?iso-8859-1?Q?+1BB8Xudn2lRUAU1nE3iR4FjyoIMY28cMxuHrWS99gcw+gz5oFYj01soaQ?=
 =?iso-8859-1?Q?yQYWBUOsvNicuZwEUx4WLE6CdR5U0Z/mRSlG6Twi26yrCXpbGXGTBbDr2m?=
 =?iso-8859-1?Q?qaejXSjVZhjxSDcPSmbFR2TGqZ9L5n2VG08ykM0jkByjn0vrPsPBru5syK?=
 =?iso-8859-1?Q?12oMs/geO+kO0Z4o/EMCi4fzSakyFwlaoV7AAS7iTWNxycSZEWM9fjSbzK?=
 =?iso-8859-1?Q?y85a3UNS75XyZ/DnBGrEfjeXaEJKPOZ2qod4wN2CNrFkIh4a9OHVeeQVdS?=
 =?iso-8859-1?Q?u0IbwWcSHnxel6U/YhI2UDgRZ0UWud4DzLPnuJ7nCTrYiz+A/PV9xEmfaD?=
 =?iso-8859-1?Q?fJR1Ex1xiCEKwDF7gncR5DbbeRtPHIgzcX/IYwQDp1Ik4xPF/J1gDzH3PB?=
 =?iso-8859-1?Q?0y7bkbjTRE3F5jYIFnQXniETnfbxqu0oAtv3umsPX+iUC5SScFSPESCrix?=
 =?iso-8859-1?Q?w+Edb+pOdk73hIOEZG/BS89LK55+DTo2RAUoCH7PP9Ol7u2ebRmJbI1KEL?=
 =?iso-8859-1?Q?Wq5KmJZHJRWQc3fsv/G5RYZtMNmHs+5sH4RN0yKDoDoeq8dOwWHzzaEbHk?=
 =?iso-8859-1?Q?HrN40yPiD8Ta2EJG6wjOftWcjP6llrfVWlTHgSIiBPhA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR09MB4864.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2zkVsAuuYHAP9LwXL9ZFcCoF1X/NYkM3c6I+A6vQHjOBNiE3DtyC/YlAWh?=
 =?iso-8859-1?Q?3HD2d7w37lVGdDT6ZDSoAEq1ZadCo3/+W3ur9isC0enUqXGIkCi8Gu/zFU?=
 =?iso-8859-1?Q?L+2xovpWCvFR42Wp4R7ZD5vU0raTtxl9afbTaT0NYkJ3+KrIEkS3kFz0q8?=
 =?iso-8859-1?Q?dY3BiLlxernpVS5lfHA5u6pbUFZtdjoodUxYLwPWD/8tEfOOCpWO26Q1dl?=
 =?iso-8859-1?Q?WSepKoqizhM5w1n8I/gT37QOMJ6Kbup2g+iP9Mr8mw98iLhhip1lknHpby?=
 =?iso-8859-1?Q?Q8+SfWAWMYGPA2wU0U4aUeVcapzwb4V1pXkdcf09nZH7yZYyQ7vzKkjU/9?=
 =?iso-8859-1?Q?S8LNFppIdBIVjs40VfTednfMMevKAZgep8yED8dlhugk+8ptkWO/wBwfwD?=
 =?iso-8859-1?Q?S45rhKGKW44o+NhLtmRZDkdrrFUJgHF0OaeSUyt29yytpjNyZopY9pcMLb?=
 =?iso-8859-1?Q?Sx3mMjDU/P7dll3cHtXDKoXdIDXPVF9VDqlXgRdGl+DNP3X4wbu1WJazG2?=
 =?iso-8859-1?Q?qgdi/CHOog8J0Z4wrwJS6ibQCNWGV33DCQN3tAHPU0exuDd8rD/CwvN42L?=
 =?iso-8859-1?Q?4Zq28z1PkW8SZjMWx76CvbWhZeS8sasA49hnPbdj9lB78ktgXkiAIf7e0N?=
 =?iso-8859-1?Q?DpMeeMvQNwuN7MdFr6IzYsrbS+5F0moJRLY8BaQb2Y5LBE7m+wFyegbujx?=
 =?iso-8859-1?Q?3SfFZNXn7U300jkaZ3AqtYhfoeLDOrA+R6ZpOzUWTPN3Pci95BDR8gHLIm?=
 =?iso-8859-1?Q?w4LYKWnHpPUxNUL+SO+k66eOJOfr6HQZtf5GbwX1Ne5dWLco8UmqQiCGAU?=
 =?iso-8859-1?Q?dDl/+fHXEzCYDswChUS5Wow9jKXz+NeNBQUbn8sjvH4Wl95k6fua1AslIY?=
 =?iso-8859-1?Q?Kn1I2LUxQdAbgQc+8H94wnHxIyyI7zwjwlgP9/uQ3kIeSQm859drEUUPen?=
 =?iso-8859-1?Q?hV3Wk7kpSnNtrQXEayiglnMzbZyiScQwxUQlN60FExd/Z0QHxTtn/gM4HE?=
 =?iso-8859-1?Q?uZem8lN2tFPXWZMwNtO0fDrWEfU+fx46glHpkqE0s1qZLzYjavpm55hEDE?=
 =?iso-8859-1?Q?BX44MRSABKfLueyoCk+0wNOososav9huPah/U95iTZhyKZAwbVG3nldAxK?=
 =?iso-8859-1?Q?vc9L/ObvG/CcC2xchoaAsCSM6gLLgg3CbXs+1YDxAbE7yqZE67/CqeyLcn?=
 =?iso-8859-1?Q?syUzOAfFk/ux9doPNwJGteMSjmvjKUpZSXfiF4vgc3WU2JXNA3fVZ/Yzrt?=
 =?iso-8859-1?Q?VC3AGhgNt9owlUD7NidZaAE2DUcuYs/sEiyS6zAHTVl4XG484/hKUUBVVG?=
 =?iso-8859-1?Q?TG+BBLelu6LOlUQ6dDiUMsHvCPSJfx+HGjVsgI7xrEl/GTYMs6pnNUvXkG?=
 =?iso-8859-1?Q?STLli9kbBmAY/1TyMG5kEAXrbfIc3ynB/jrLpzndIfTAptDihaaKlXDGTt?=
 =?iso-8859-1?Q?sEUFlrDwx+KQSfRn6FBUNyDNYSAcx5r7gFgm8SQG67PQSmMw7axaMGChbU?=
 =?iso-8859-1?Q?vh0P+vj8OwW/0a9Rs+kTrFbrHfAK1uD6hP/DIF1XTv36PxNbF//apQoa2y?=
 =?iso-8859-1?Q?Nwj3aKsn8VE4Ah/y9vSQyIs24qKBs9hrjV66D/+tUZmQ3AYak+Kea3UqQH?=
 =?iso-8859-1?Q?DfVFt4nCcLtnIES6uN13rqF5MmUZd2FKP0ffa8YcND1wjg5p4nylrvgnmd?=
 =?iso-8859-1?Q?kcDq1tg0zFm/k4gmUCA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR09MB4864.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e03d6c7-fdd9-4c78-bd17-08ddb50e2063
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 00:04:03.3589 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aQ9ssZnQ1/SSbjPSO8HgPNUasQTI2l7bWNJY7gJbQvN6olS/Rs7cePxwMyMoWeXN3oe7xqoNImamu7B02M9RF4KRod5qrdR/o2KHjKpy4h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR09MB6925
Received-SPF: pass client-ip=2a01:111:f403:c200::1;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>

Add emulation of MIPS' CRC32 (Cyclic Redundancy Check) instructions.
Reuse zlib crc32() and Linux crc32c().

Enable CRC for mips64r6.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>
---
 target/mips/cpu-defs.c.inc                    |  10 +-
 target/mips/helper.h                          |   2 +
 target/mips/meson.build                       |   1 +
 target/mips/tcg/op_helper.c                   |  27 ++++
 target/mips/tcg/rel6.decode                   |   5 +
 target/mips/tcg/rel6_translate.c              |  13 ++
 target/mips/tcg/translate.c                   |  25 +++
 target/mips/tcg/translate.h                   |   2 +
 tests/tcg/mips/include/wrappers_mips64r6.h    |  35 +++++
 tests/tcg/mips/user/isa/mips64r6/crc/Makefile |  42 ++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32b.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cb.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cd.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32ch.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32cw.c  | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32d.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32h.c   | 142 ++++++++++++++++++
 .../isa/mips64r6/crc/test_mips64r6_crc32w.c   | 142 ++++++++++++++++++
 18 files changed, 1294 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/Makefile
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2b.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cb.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cd.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2ch.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2cw.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2d.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2h.c
 create mode 100644 tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc3=
2w.c

diff --git a/target/mips/cpu-defs.c.inc b/target/mips/cpu-defs.c.inc
index 922fc39138..d93b9d341a 100644
--- a/target/mips/cpu-defs.c.inc
+++ b/target/mips/cpu-defs.c.inc
@@ -756,8 +756,9 @@ const mips_def_t mips_defs[] =3D
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_V=
Int),
         .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) =
|
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP)=
 |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_G=
I),
+        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XN=
P) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MR=
P) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI)=
 |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask =3D 0,
@@ -796,8 +797,9 @@ const mips_def_t mips_defs[] =3D
                        (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_V=
Int),
         .CP0_Config4 =3D MIPS_CONFIG4 | (1U << CP0C4_M) | (3 << CP0C4_IE) =
|
                        (1 << CP0C4_AE) | (0xfc << CP0C4_KScrExist),
-        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_XNP) | (1 << CP0C5_VP)=
 |
-                       (1 << CP0C5_LLB) | (1 << CP0C5_MRP) | (3 << CP0C5_G=
I),
+        .CP0_Config5 =3D MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_XN=
P) |
+                       (1 << CP0C5_VP) | (1 << CP0C5_LLB) | (1 << CP0C5_MR=
P) |
+                       (3 << CP0C5_GI),
         .CP0_Config5_rw_bitmask =3D (1 << CP0C5_MSAEn) | (1 << CP0C5_SBRI)=
 |
                                   (1 << CP0C5_FRE) | (1 << CP0C5_UFE),
         .CP0_LLAddr_rw_bitmask =3D 0,
diff --git a/target/mips/helper.h b/target/mips/helper.h
index 7e40041828..b6cd53c853 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -21,6 +21,8 @@ DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(dbitswap, TCG_CALL_NO_RWG_SE, tl, tl)
 #endif
=20
+DEF_HELPER_3(crc32, tl, tl, tl, i32)
+DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
=20
 /* microMIPS functions */
diff --git a/target/mips/meson.build b/target/mips/meson.build
index 247979a2cf..abf0ce3e8b 100644
--- a/target/mips/meson.build
+++ b/target/mips/meson.build
@@ -7,6 +7,7 @@ mips_ss.add(files(
   'gdbstub.c',
   'msa.c',
 ))
+mips_ss.add(zlib)
=20
 if have_system
   subdir('system')
diff --git a/target/mips/tcg/op_helper.c b/target/mips/tcg/op_helper.c
index b906d10204..60897ad53e 100644
--- a/target/mips/tcg/op_helper.c
+++ b/target/mips/tcg/op_helper.c
@@ -24,6 +24,8 @@
 #include "exec/helper-proto.h"
 #include "exec/memop.h"
 #include "fpu_helper.h"
+#include "qemu/crc32c.h"
+#include <zlib.h>
=20
 static inline target_ulong bitswap(target_ulong v)
 {
@@ -142,6 +144,31 @@ target_ulong helper_rotx(target_ulong rs, uint32_t shi=
ft, uint32_t shiftx,
     return (int64_t)(int32_t)(uint32_t)tmp5;
 }
=20
+/* these crc32 functions are based on target/loongarch/tcg/op_helper.c */
+target_ulong helper_crc32(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &=3D mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32(val ^ 0xffffffff, buf, sz) ^ 0xffffffff);
+}
+
+target_ulong helper_crc32c(target_ulong val, target_ulong m, uint32_t sz)
+{
+    uint8_t buf[8];
+    target_ulong mask =3D ((sz * 8) =3D=3D 64) ?
+                        (target_ulong) -1ULL :
+                        ((1ULL << (sz * 8)) - 1);
+
+    m &=3D mask;
+    stq_le_p(buf, m);
+    return (int32_t) (crc32c(val, buf, sz) ^ 0xffffffff);
+}
+
 void helper_fork(target_ulong arg1, target_ulong arg2)
 {
     /*
diff --git a/target/mips/tcg/rel6.decode b/target/mips/tcg/rel6.decode
index d6989cf56e..7fbcb109b4 100644
--- a/target/mips/tcg/rel6.decode
+++ b/target/mips/tcg/rel6.decode
@@ -16,11 +16,16 @@
=20
 &r                  rs rt rd sa
=20
+&special3_crc       rs rt c sz
+
 @lsa                ...... rs:5 rt:5 rd:5 ... sa:2 ......   &r
+@crc32              ...... rs:5 rt:5 ..... c:3 sz:2 ......  &special3_crc
=20
 LSA                 000000 ..... ..... ..... 000 .. 000101  @lsa
 DLSA                000000 ..... ..... ..... 000 .. 010101  @lsa
=20
+CRC32               011111 ..... ..... 00000 ... .. 001111  @crc32
+
 REMOVED             010011 ----- ----- ----- ----- ------   # COP1X (COP3)
=20
 REMOVED             011100 ----- ----- ----- ----- ------   # SPECIAL2
diff --git a/target/mips/tcg/rel6_translate.c b/target/mips/tcg/rel6_transl=
ate.c
index 59f237ba3b..15ecccb159 100644
--- a/target/mips/tcg/rel6_translate.c
+++ b/target/mips/tcg/rel6_translate.c
@@ -33,3 +33,16 @@ static bool trans_DLSA(DisasContext *ctx, arg_r *a)
     }
     return gen_dlsa(ctx, a->rd, a->rt, a->rs, a->sa);
 }
+
+static bool
+trans_CRC32(DisasContext *ctx, arg_special3_crc *a)
+{
+    if (unlikely(!ctx->crcp)
+        || unlikely((a->sz =3D=3D 3) && (!(ctx->hflags & MIPS_HFLAG_64)))
+        || unlikely((a->c >=3D 2))) {
+        gen_reserved_instruction(ctx);
+        return true;
+    }
+    gen_crc32(ctx, a->rt, a->rs, a->rt, a->sz, a->c);
+    return true;
+}
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 8658315f93..9f4c11de46 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -13449,6 +13449,30 @@ static void decode_opc_special2_legacy(CPUMIPSStat=
e *env, DisasContext *ctx)
     }
 }
=20
+void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz,
+                      int crc32c)
+{
+    TCGv t0;
+    TCGv t1;
+    TCGv_i32 tsz =3D tcg_constant_i32(1 << sz);
+    if (rd =3D=3D 0) {
+        /* Treat as NOP. */
+        return;
+    }
+    t0 =3D tcg_temp_new();
+    t1 =3D tcg_temp_new();
+
+    gen_load_gpr(t0, rt);
+    gen_load_gpr(t1, rs);
+
+    if (crc32c) {
+        gen_helper_crc32c(cpu_gpr[rd], t0, t1, tsz);
+    } else {
+        gen_helper_crc32(cpu_gpr[rd], t0, t1, tsz);
+    }
+
+}
+
 static void decode_opc_special3_r6(CPUMIPSState *env, DisasContext *ctx)
 {
     int rs, rt, rd, sa;
@@ -15095,6 +15119,7 @@ static void mips_tr_init_disas_context(DisasContext=
Base *dcbase, CPUState *cs)
     ctx->abs2008 =3D (env->active_fpu.fcr31 >> FCR31_ABS2008) & 1;
     ctx->mi =3D (env->CP0_Config5 >> CP0C5_MI) & 1;
     ctx->gi =3D (env->CP0_Config5 >> CP0C5_GI) & 3;
+    ctx->crcp =3D (env->CP0_Config5 >> CP0C5_CRCP) & 1;
     restore_cpu_state(env, ctx);
 #ifdef CONFIG_USER_ONLY
         ctx->mem_idx =3D MIPS_HFLAG_UM;
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 1bf153d183..428b53a0da 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -51,6 +51,7 @@ typedef struct DisasContext {
     bool abs2008;
     bool mi;
     int gi;
+    bool crcp;
 } DisasContext;
=20
 #define DISAS_STOP       DISAS_TARGET_0
@@ -181,6 +182,7 @@ bool gen_lsa(DisasContext *ctx, int rd, int rt, int rs,=
 int sa);
 bool gen_dlsa(DisasContext *ctx, int rd, int rt, int rs, int sa);
=20
 void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel);
+void gen_crc32(DisasContext *ctx, int rd, int rs, int rt, int sz, int crc3=
2c);
=20
 extern TCGv cpu_gpr[32], cpu_PC;
 #if defined(TARGET_MIPS64)
diff --git a/tests/tcg/mips/include/wrappers_mips64r6.h b/tests/tcg/mips/in=
clude/wrappers_mips64r6.h
index d1e5edb632..31f8054d5e 100644
--- a/tests/tcg/mips/include/wrappers_mips64r6.h
+++ b/tests/tcg/mips/include/wrappers_mips64r6.h
@@ -23,6 +23,8 @@
 #ifndef WRAPPERS_MIPS64R6_H
 #define WRAPPERS_MIPS64R6_H
=20
+#include <string.h>
+
=20
 #define DO_MIPS64R6__RD__RS(suffix, mnemonic)                          \
 static inline void do_mips64r6_##suffix(const void *input,             \
@@ -80,4 +82,37 @@ DO_MIPS64R6__RD__RS_RT(DMULU, dmulu)
 DO_MIPS64R6__RD__RS_RT(DMUHU, dmuhu)
=20
=20
+#define DO_MIPS64R6__RT__RS_RT(suffix, mnemonic)                       \
+static inline void do_mips64r6_##suffix(const void *input1,            \
+                                        const void *input2,            \
+                                        void *output)                  \
+{                                                                      \
+    if (strncmp(#mnemonic, "crc32", 5) =3D=3D 0)                          =
 \
+        __asm__ volatile (                                             \
+           ".set crc\n\t"                                              \
+        );                                                             \
+                                                                       \
+   __asm__ volatile (                                                  \
+      "ld $t1, 0(%0)\n\t"                                              \
+      "ld $t2, 0(%1)\n\t"                                              \
+      #mnemonic " $t2, $t1, $t2\n\t"                                   \
+      "sd $t2, 0(%2)\n\t"                                              \
+      :                                                                \
+      : "r" (input1), "r" (input2), "r" (output)                       \
+      : "t0", "t1", "t2", "memory"                                     \
+   );                                                                  \
+}
+
+DO_MIPS64R6__RT__RS_RT(CRC32B, crc32b)
+DO_MIPS64R6__RT__RS_RT(CRC32H, crc32h)
+DO_MIPS64R6__RT__RS_RT(CRC32W, crc32w)
+DO_MIPS64R6__RT__RS_RT(CRC32D, crc32d)
+
+DO_MIPS64R6__RT__RS_RT(CRC32CB, crc32cb)
+DO_MIPS64R6__RT__RS_RT(CRC32CH, crc32ch)
+DO_MIPS64R6__RT__RS_RT(CRC32CW, crc32cw)
+DO_MIPS64R6__RT__RS_RT(CRC32CD, crc32cd)
+
+
+
 #endif
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/Makefile b/tests/tcg/mips=
/user/isa/mips64r6/crc/Makefile
new file mode 100644
index 0000000000..3601cb0cd0
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/Makefile
@@ -0,0 +1,42 @@
+#
+#  Test program for MIPS64R6 CRC32 instructions
+#
+#  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+#
+#  SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+ifndef PREFIX
+  $(error "PREFIX not set, please export GNU Toolchain install directory."=
)
+endif
+
+ifndef SYSROOT
+  $(error "SYSROOT not set, please export GNU Toolchain system root direct=
ory.")
+endif
+
+SIM =3D ../../../../../../../build/qemu-mips64
+SIM_FLAGS =3D -L $(SYSROOT)
+
+CC      =3D  $(PREFIX)/bin/mips64-r6-linux-gnu-gcc
+
+TESTCASES  =3D test_mips64r6_crc32b.tst
+TESTCASES +=3D test_mips64r6_crc32h.tst
+TESTCASES +=3D test_mips64r6_crc32w.tst
+TESTCASES +=3D test_mips64r6_crc32d.tst
+TESTCASES +=3D test_mips64r6_crc32cb.tst
+TESTCASES +=3D test_mips64r6_crc32ch.tst
+TESTCASES +=3D test_mips64r6_crc32cw.tst
+TESTCASES +=3D test_mips64r6_crc32cd.tst
+
+all: $(TESTCASES)
+	@for case in $(TESTCASES); do \
+            echo $(SIM) $(SIM_FLAGS) ./$$case; \
+            $(SIM) $(SIM_FLAGS) ./$$case; \
+            echo $(RM) -rf ./$$case; \
+            $(RM) -rf ./$$case; \
+	done
+
+%.tst: %.c
+	$(CC) $< -o $@
+
+
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
new file mode 100644
index 0000000000..bb1f3f6924
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32b.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32B
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32B";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000ffffffULL,                    /*   0  */
+        0x000000002d02ef8dULL,
+        0x000000001bab0fd1ULL,
+        0x0000000036561fa3ULL,
+        0xffffffffbf1caddaULL,
+        0xffffffff92e1bda8ULL,
+        0x00000000278c7949ULL,
+        0x000000000a71693bULL,
+        0x000000002dfd1072ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000036a9e05cULL,
+        0x000000001b54f02eULL,
+        0xffffffff921e4257ULL,
+        0xffffffffbfe35225ULL,
+        0x000000000a8e96c4ULL,
+        0x00000000277386b6ULL,
+        0x000000001bfe5a84ULL,                    /*  16  */
+        0x0000000036034af6ULL,
+        0x0000000000aaaaaaULL,
+        0x000000002d57bad8ULL,
+        0xffffffffa41d08a1ULL,
+        0xffffffff89e018d3ULL,
+        0x000000003c8ddc32ULL,
+        0x000000001170cc40ULL,
+        0x0000000036fcb509ULL,                    /*  24  */
+        0x000000001b01a57bULL,
+        0x000000002da84527ULL,
+        0x0000000000555555ULL,
+        0xffffffff891fe72cULL,
+        0xffffffffa4e2f75eULL,
+        0x00000000118f33bfULL,
+        0x000000003c7223cdULL,
+        0xffffffffbf2f9ee9ULL,                    /*  32  */
+        0xffffffff92d28e9bULL,
+        0xffffffffa47b6ec7ULL,
+        0xffffffff89867eb5ULL,
+        0x0000000000ccccccULL,
+        0x000000002d31dcbeULL,
+        0xffffffff985c185fULL,
+        0xffffffffb5a1082dULL,
+        0xffffffff922d7164ULL,                    /*  40  */
+        0xffffffffbfd06116ULL,
+        0xffffffff8979814aULL,
+        0xffffffffa4849138ULL,
+        0x000000002dce2341ULL,
+        0x0000000000333333ULL,
+        0xffffffffb55ef7d2ULL,
+        0xffffffff98a3e7a0ULL,
+        0x0000000027fdbe55ULL,                    /*  48  */
+        0x000000000a00ae27ULL,
+        0x000000003ca94e7bULL,
+        0x0000000011545e09ULL,
+        0xffffffff981eec70ULL,
+        0xffffffffb5e3fc02ULL,
+        0x00000000008e38e3ULL,
+        0x000000002d732891ULL,
+        0x000000000aff51d8ULL,                    /*  56  */
+        0x00000000270241aaULL,
+        0x0000000011aba1f6ULL,
+        0x000000003c56b184ULL,
+        0xffffffffb51c03fdULL,
+        0xffffffff98e1138fULL,
+        0x000000002d8cd76eULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0x00000000784a5a65ULL,
+        0xffffffff9bdd0d3bULL,
+        0xffffffffe7e61ce5ULL,
+        0x00000000782fabf7ULL,
+        0x00000000004d93c7ULL,
+        0xffffffffe3dac499ULL,
+        0xffffffff9fe1d547ULL,
+        0xffffffff9b4ca0e5ULL,                    /*  72  */
+        0xffffffffe32e98d5ULL,
+        0x0000000000b9cf8bULL,
+        0x000000007c82de55ULL,
+        0xffffffffe7904f52ULL,
+        0xffffffff9ff27762ULL,
+        0x000000007c65203cULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32B(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
new file mode 100644
index 0000000000..1439d44bf2
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cb.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CB
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CB";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000ffffffULL,                    /*   0  */
+        0xffffffffad7d5351ULL,
+        0x00000000647e6465ULL,
+        0xffffffffc9fcc8cbULL,
+        0x00000000237f7689ULL,
+        0xffffffff8efdda27ULL,
+        0xffffffff837defedULL,
+        0x000000002eff4343ULL,
+        0xffffffffad82acaeULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffffc9033734ULL,
+        0x0000000064819b9aULL,
+        0xffffffff8e0225d8ULL,
+        0x0000000023808976ULL,
+        0x000000002e00bcbcULL,
+        0xffffffff83821012ULL,
+        0x00000000642b3130ULL,                    /*  16  */
+        0xffffffffc9a99d9eULL,
+        0x0000000000aaaaaaULL,
+        0xffffffffad280604ULL,
+        0x0000000047abb846ULL,
+        0xffffffffea2914e8ULL,
+        0xffffffffe7a92122ULL,
+        0x000000004a2b8d8cULL,
+        0xffffffffc9566261ULL,                    /*  24  */
+        0x0000000064d4cecfULL,
+        0xffffffffadd7f9fbULL,
+        0x0000000000555555ULL,
+        0xffffffffead6eb17ULL,
+        0x00000000475447b9ULL,
+        0x000000004ad47273ULL,
+        0xffffffffe756deddULL,
+        0x00000000234c45baULL,                    /*  32  */
+        0xffffffff8ecee914ULL,
+        0x0000000047cdde20ULL,
+        0xffffffffea4f728eULL,
+        0x0000000000ccccccULL,
+        0xffffffffad4e6062ULL,
+        0xffffffffa0ce55a8ULL,
+        0x000000000d4cf906ULL,
+        0xffffffff8e3116ebULL,                    /*  40  */
+        0x0000000023b3ba45ULL,
+        0xffffffffeab08d71ULL,
+        0x00000000473221dfULL,
+        0xffffffffadb19f9dULL,
+        0x0000000000333333ULL,
+        0x000000000db306f9ULL,
+        0xffffffffa031aa57ULL,
+        0xffffffff830c28f1ULL,                    /*  48  */
+        0x000000002e8e845fULL,
+        0xffffffffe78db36bULL,
+        0x000000004a0f1fc5ULL,
+        0xffffffffa08ca187ULL,
+        0x000000000d0e0d29ULL,
+        0x00000000008e38e3ULL,
+        0xffffffffad0c944dULL,
+        0x000000002e717ba0ULL,                    /*  56  */
+        0xffffffff83f3d70eULL,
+        0x000000004af0e03aULL,
+        0xffffffffe7724c94ULL,
+        0x000000000df1f2d6ULL,
+        0xffffffffa0735e78ULL,
+        0xffffffffadf36bb2ULL,
+        0x000000000071c71cULL,
+        0x0000000000286255ULL,                    /*  64  */
+        0xffffffffcbefd6b4ULL,
+        0xffffffffc334e94fULL,
+        0xffffffffac268ec5ULL,
+        0xffffffffcb8a2726ULL,
+        0x00000000004d93c7ULL,
+        0x000000000896ac3cULL,
+        0x000000006784cbb6ULL,
+        0xffffffffc3a54491ULL,                    /*  72  */
+        0x000000000862f070ULL,
+        0x0000000000b9cf8bULL,
+        0x000000006faba801ULL,
+        0xffffffffac50dd72ULL,
+        0x0000000067976993ULL,
+        0x000000006f4c5668ULL,
+        0x00000000005e31e2ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CB(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
new file mode 100644
index 0000000000..bf258e0696
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cd.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CD
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CD";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0xffffffffb798b438ULL,                    /*   0  */
+        0xffffffffc44ff94dULL,
+        0xffffffff992a70ebULL,
+        0xffffffffeafd3d9eULL,
+        0x000000005152da26ULL,
+        0x0000000022859753ULL,
+        0x0000000015cb6d32ULL,
+        0x00000000661c2047ULL,
+        0x0000000073d74d75ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005d6589a6ULL,
+        0x000000002eb2c4d3ULL,
+        0xffffffff951d236bULL,
+        0xffffffffe6ca6e1eULL,
+        0xffffffffd184947fULL,
+        0xffffffffa253d90aULL,
+        0x0000000008f9ceacULL,                    /*  16  */
+        0x000000007b2e83d9ULL,
+        0x00000000264b0a7fULL,
+        0x00000000559c470aULL,
+        0xffffffffee33a0b2ULL,
+        0xffffffff9de4edc7ULL,
+        0xffffffffaaaa17a6ULL,
+        0xffffffffd97d5ad3ULL,
+        0xffffffffccb637e1ULL,                    /*  24  */
+        0xffffffffbf617a94ULL,
+        0xffffffffe204f332ULL,
+        0xffffffff91d3be47ULL,
+        0x000000002a7c59ffULL,
+        0x0000000059ab148aULL,
+        0x000000006ee5eeebULL,
+        0x000000001d32a39eULL,
+        0x0000000021e3b01bULL,                    /*  32  */
+        0x000000005234fd6eULL,
+        0x000000000f5174c8ULL,
+        0x000000007c8639bdULL,
+        0xffffffffc729de05ULL,
+        0xffffffffb4fe9370ULL,
+        0xffffffff83b06911ULL,
+        0xfffffffff0672464ULL,
+        0xffffffffe5ac4956ULL,                    /*  40  */
+        0xffffffff967b0423ULL,
+        0xffffffffcb1e8d85ULL,
+        0xffffffffb8c9c0f0ULL,
+        0x0000000003662748ULL,
+        0x0000000070b16a3dULL,
+        0x0000000047ff905cULL,
+        0x000000003428dd29ULL,
+        0xffffffffb89d59a6ULL,                    /*  48  */
+        0xffffffffcb4a14d3ULL,
+        0xffffffff962f9d75ULL,
+        0xffffffffe5f8d000ULL,
+        0x000000005e5737b8ULL,
+        0x000000002d807acdULL,
+        0x000000001ace80acULL,
+        0x000000006919cdd9ULL,
+        0x000000007cd2a0ebULL,                    /*  56  */
+        0x000000000f05ed9eULL,
+        0x0000000052606438ULL,
+        0x0000000021b7294dULL,
+        0xffffffff9a18cef5ULL,
+        0xffffffffe9cf8380ULL,
+        0xffffffffde8179e1ULL,
+        0xffffffffad563494ULL,
+        0x000000003a358bb3ULL,                    /*  64  */
+        0xffffffff975446ebULL,
+        0x0000000041d37ad6ULL,
+        0x000000004be84fe1ULL,
+        0xffffffff9671b1b3ULL,
+        0x000000003b107cebULL,
+        0xffffffffed9740d6ULL,
+        0xffffffffe7ac75e1ULL,
+        0xffffffffa1489696ULL,                    /*  72  */
+        0x000000000c295bceULL,
+        0xffffffffdaae67f3ULL,
+        0xffffffffd09552c4ULL,
+        0x0000000042bd7071ULL,
+        0xffffffffefdcbd29ULL,
+        0x00000000395b8114ULL,
+        0x000000003360b423ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CD(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
new file mode 100644
index 0000000000..0e7b67732e
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32ch.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CH
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CH";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x000000000000ffffULL,                    /*   0  */
+        0x000000000e9e77d2ULL,
+        0xfffffffff92eaa4bULL,
+        0xfffffffff7b02266ULL,
+        0x00000000571acc93ULL,
+        0x00000000598444beULL,
+        0xfffffffff1e6ca77ULL,
+        0xffffffffff78425aULL,
+        0x000000000e9e882dULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xfffffffff7b0dd99ULL,
+        0xfffffffff92e55b4ULL,
+        0x000000005984bb41ULL,
+        0x00000000571a336cULL,
+        0xffffffffff78bda5ULL,
+        0xfffffffff1e63588ULL,
+        0xfffffffff92eff1eULL,                    /*  16  */
+        0xfffffffff7b07733ULL,
+        0x000000000000aaaaULL,
+        0x000000000e9e2287ULL,
+        0xffffffffae34cc72ULL,
+        0xffffffffa0aa445fULL,
+        0x0000000008c8ca96ULL,
+        0x00000000065642bbULL,
+        0xfffffffff7b088ccULL,                    /*  24  */
+        0xfffffffff92e00e1ULL,
+        0x000000000e9edd78ULL,
+        0x0000000000005555ULL,
+        0xffffffffa0aabba0ULL,
+        0xffffffffae34338dULL,
+        0x000000000656bd44ULL,
+        0x0000000008c83569ULL,
+        0x00000000571affa0ULL,                    /*  32  */
+        0x000000005984778dULL,
+        0xffffffffae34aa14ULL,
+        0xffffffffa0aa2239ULL,
+        0x000000000000ccccULL,
+        0x000000000e9e44e1ULL,
+        0xffffffffa6fcca28ULL,
+        0xffffffffa8624205ULL,
+        0x0000000059848872ULL,                    /*  40  */
+        0x00000000571a005fULL,
+        0xffffffffa0aaddc6ULL,
+        0xffffffffae3455ebULL,
+        0x000000000e9ebb1eULL,
+        0x0000000000003333ULL,
+        0xffffffffa862bdfaULL,
+        0xffffffffa6fc35d7ULL,
+        0xfffffffff1e6bbb0ULL,                    /*  48  */
+        0xffffffffff78339dULL,
+        0x0000000008c8ee04ULL,
+        0x0000000006566629ULL,
+        0xffffffffa6fc88dcULL,
+        0xffffffffa86200f1ULL,
+        0x0000000000008e38ULL,
+        0x000000000e9e0615ULL,
+        0xffffffffff78cc62ULL,                    /*  56  */
+        0xfffffffff1e6444fULL,
+        0x00000000065699d6ULL,
+        0x0000000008c811fbULL,
+        0xffffffffa862ff0eULL,
+        0xffffffffa6fc7723ULL,
+        0x000000000e9ef9eaULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x000000001190c4cfULL,
+        0x000000007b7fdbbeULL,
+        0xffffffff9204da99ULL,
+        0x000000001190a13eULL,
+        0x0000000000004d93ULL,
+        0x000000006aef52e2ULL,
+        0xffffffff839453c5ULL,
+        0x000000007b7f4a13ULL,                    /*  72  */
+        0x000000006aefa6beULL,
+        0x000000000000b9cfULL,
+        0xffffffffe97bb8e8ULL,
+        0xffffffff9204accaULL,
+        0xffffffff83944067ULL,
+        0xffffffffe97b5f16ULL,
+        0x0000000000005e31ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CH(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c b=
/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
new file mode 100644
index 0000000000..f7110b3a0a
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32cw.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32CW
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0x82F63B78";
+    char *instruction_name =3D   "CRC32CW";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffb798b438ULL,
+        0xffffffff91d3be47ULL,
+        0x00000000264b0a7fULL,
+        0x0000000070b16a3dULL,
+        0xffffffffc729de05ULL,
+        0x0000000063c5950aULL,
+        0xffffffffd45d2132ULL,
+        0xffffffffb798b438ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x00000000264b0a7fULL,
+        0xffffffff91d3be47ULL,
+        0xffffffffc729de05ULL,
+        0x0000000070b16a3dULL,
+        0xffffffffd45d2132ULL,
+        0x0000000063c5950aULL,
+        0xffffffff91d3be47ULL,                    /*  16  */
+        0x00000000264b0a7fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x00000000264b0a7fULL,                    /*  24  */
+        0xffffffff91d3be47ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0x0000000070b16a3dULL,                    /*  32  */
+        0xffffffffc729de05ULL,
+        0xffffffffe162d47aULL,
+        0x0000000056fa6042ULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0xffffffffc729de05ULL,                    /*  40  */
+        0x0000000070b16a3dULL,
+        0x0000000056fa6042ULL,
+        0xffffffffe162d47aULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0x0000000063c5950aULL,                    /*  48  */
+        0xffffffffd45d2132ULL,
+        0xfffffffff2162b4dULL,
+        0x00000000458e9f75ULL,
+        0x000000001374ff37ULL,
+        0xffffffffa4ec4b0fULL,
+        0x0000000000000000ULL,
+        0xffffffffb798b438ULL,
+        0xffffffffd45d2132ULL,                    /*  56  */
+        0x0000000063c5950aULL,
+        0x00000000458e9f75ULL,
+        0xfffffffff2162b4dULL,
+        0xffffffffa4ec4b0fULL,
+        0x000000001374ff37ULL,
+        0xffffffffb798b438ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffffea0755b2ULL,
+        0x0000000008b188e6ULL,
+        0xffffffffff3cc8d9ULL,
+        0xffffffffea0755b2ULL,
+        0x0000000000000000ULL,
+        0xffffffffe2b6dd54ULL,
+        0x00000000153b9d6bULL,
+        0x0000000008b188e6ULL,                    /*  72  */
+        0xffffffffe2b6dd54ULL,
+        0x0000000000000000ULL,
+        0xfffffffff78d403fULL,
+        0xffffffffff3cc8d9ULL,
+        0x00000000153b9d6bULL,
+        0xfffffffff78d403fULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32CW(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
new file mode 100644
index 0000000000..e391be803f
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32d.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32D
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32D";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0xffffffffdebb20e3ULL,                    /*   0  */
+        0x0000000044660075ULL,
+        0x000000001e20c2aeULL,
+        0xffffffff84fde238ULL,
+        0x00000000281d7ce7ULL,
+        0xffffffffb2c05c71ULL,
+        0xffffffffd660a024ULL,
+        0x000000004cbd80b2ULL,
+        0xffffffff9add2096ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x000000005a46c2dbULL,
+        0xffffffffc09be24dULL,
+        0x000000006c7b7c92ULL,
+        0xfffffffff6a65c04ULL,
+        0xffffffff9206a051ULL,
+        0x0000000008db80c7ULL,
+        0x000000005449dd0fULL,                    /*  16  */
+        0xffffffffce94fd99ULL,
+        0xffffffff94d23f42ULL,
+        0x000000000e0f1fd4ULL,
+        0xffffffffa2ef810bULL,
+        0x000000003832a19dULL,
+        0x000000005c925dc8ULL,
+        0xffffffffc64f7d5eULL,
+        0x00000000102fdd7aULL,                    /*  24  */
+        0xffffffff8af2fdecULL,
+        0xffffffffd0b43f37ULL,
+        0x000000004a691fa1ULL,
+        0xffffffffe689817eULL,
+        0x000000007c54a1e8ULL,
+        0x0000000018f45dbdULL,
+        0xffffffff82297d2bULL,
+        0xffffffffa7157447ULL,                    /*  32  */
+        0x000000003dc854d1ULL,
+        0x00000000678e960aULL,
+        0xfffffffffd53b69cULL,
+        0x0000000051b32843ULL,
+        0xffffffffcb6e08d5ULL,
+        0xffffffffafcef480ULL,
+        0x000000003513d416ULL,
+        0xffffffffe3737432ULL,                    /*  40  */
+        0x0000000079ae54a4ULL,
+        0x0000000023e8967fULL,
+        0xffffffffb935b6e9ULL,
+        0x0000000015d52836ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffeba8f4f5ULL,
+        0x000000007175d463ULL,
+        0x000000007a6adc3eULL,                    /*  48  */
+        0xffffffffe0b7fca8ULL,
+        0xffffffffbaf13e73ULL,
+        0x00000000202c1ee5ULL,
+        0xffffffff8ccc803aULL,
+        0x000000001611a0acULL,
+        0x0000000072b15cf9ULL,
+        0xffffffffe86c7c6fULL,
+        0x000000003e0cdc4bULL,                    /*  56  */
+        0xffffffffa4d1fcddULL,
+        0xfffffffffe973e06ULL,
+        0x00000000644a1e90ULL,
+        0xffffffffc8aa804fULL,
+        0x000000005277a0d9ULL,
+        0x0000000036d75c8cULL,
+        0xffffffffac0a7c1aULL,
+        0xffffffffed857593ULL,                    /*  64  */
+        0xffffffffe0b6f95fULL,
+        0x00000000253b462cULL,
+        0xffffffffe15579b9ULL,
+        0x0000000074897c83ULL,
+        0x0000000079baf04fULL,
+        0xffffffffbc374f3cULL,
+        0x00000000785970a9ULL,
+        0xffffffffa6bae0a9ULL,                    /*  72  */
+        0xffffffffab896c65ULL,
+        0x000000006e04d316ULL,
+        0xffffffffaa6aec83ULL,
+        0x000000005ae171feULL,
+        0x0000000057d2fd32ULL,
+        0xffffffff925f4241ULL,
+        0x0000000056317dd4ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32D(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
new file mode 100644
index 0000000000..100f02c7dd
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32h.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32H
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32H";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x000000000000ffffULL,                    /*   0  */
+        0xffffffffbe2612ffULL,
+        0xffffffffdccda6c0ULL,
+        0x0000000062eb4bc0ULL,
+        0x000000004bbbc8eaULL,
+        0xfffffffff59d25eaULL,
+        0x0000000022259ac0ULL,
+        0xffffffff9c0377c0ULL,
+        0xffffffffbe26ed00ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0x0000000062ebb43fULL,
+        0xffffffffdccd593fULL,
+        0xfffffffff59dda15ULL,
+        0x000000004bbb3715ULL,
+        0xffffffff9c03883fULL,
+        0x000000002225653fULL,
+        0xffffffffdccdf395ULL,                    /*  16  */
+        0x0000000062eb1e95ULL,
+        0x000000000000aaaaULL,
+        0xffffffffbe2647aaULL,
+        0xffffffff9776c480ULL,
+        0x0000000029502980ULL,
+        0xfffffffffee896aaULL,
+        0x0000000040ce7baaULL,
+        0x0000000062ebe16aULL,                    /*  24  */
+        0xffffffffdccd0c6aULL,
+        0xffffffffbe26b855ULL,
+        0x0000000000005555ULL,
+        0x000000002950d67fULL,
+        0xffffffff97763b7fULL,
+        0x0000000040ce8455ULL,
+        0xfffffffffee86955ULL,
+        0x000000004bbbfbd9ULL,                    /*  32  */
+        0xfffffffff59d16d9ULL,
+        0xffffffff9776a2e6ULL,
+        0x0000000029504fe6ULL,
+        0x000000000000ccccULL,
+        0xffffffffbe2621ccULL,
+        0x00000000699e9ee6ULL,
+        0xffffffffd7b873e6ULL,
+        0xfffffffff59de926ULL,                    /*  40  */
+        0x000000004bbb0426ULL,
+        0x000000002950b019ULL,
+        0xffffffff97765d19ULL,
+        0xffffffffbe26de33ULL,
+        0x0000000000003333ULL,
+        0xffffffffd7b88c19ULL,
+        0x00000000699e6119ULL,
+        0x000000002225eb07ULL,                    /*  48  */
+        0xffffffff9c030607ULL,
+        0xfffffffffee8b238ULL,
+        0x0000000040ce5f38ULL,
+        0x00000000699edc12ULL,
+        0xffffffffd7b83112ULL,
+        0x0000000000008e38ULL,
+        0xffffffffbe266338ULL,
+        0xffffffff9c03f9f8ULL,                    /*  56  */
+        0x00000000222514f8ULL,
+        0x0000000040cea0c7ULL,
+        0xfffffffffee84dc7ULL,
+        0xffffffffd7b8ceedULL,
+        0x00000000699e23edULL,
+        0xffffffffbe269cc7ULL,
+        0x00000000000071c7ULL,
+        0x0000000000002862ULL,                    /*  64  */
+        0x0000000026a17af6ULL,
+        0xffffffffaa919152ULL,
+        0xffffffffcb865590ULL,
+        0x0000000026a11f07ULL,
+        0x0000000000004d93ULL,
+        0xffffffff8c30a637ULL,
+        0xffffffffed2762f5ULL,
+        0xffffffffaa9100ffULL,                    /*  72  */
+        0xffffffff8c30526bULL,
+        0x000000000000b9cfULL,
+        0x0000000061177d0dULL,
+        0xffffffffcb8623c3ULL,
+        0xffffffffed277157ULL,
+        0x0000000061179af3ULL,
+        0x0000000000005e31ULL
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32H(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
diff --git a/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c b/=
tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
new file mode 100644
index 0000000000..b4f5f4bbee
--- /dev/null
+++ b/tests/tcg/mips/user/isa/mips64r6/crc/test_mips64r6_crc32w.c
@@ -0,0 +1,142 @@
+/*
+ *  Test program for MIPS64R6 instruction CRC32W
+ *
+ *  Copyright (C) 2019  Wave Computing, Inc.
+ *  Copyright (C) 2019  Aleksandar Markovic <amarkovic@wavecomp.com>
+ *  Copyright (C) 2025  Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
+ *
+ *  SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <sys/time.h>
+#include <stdint.h>
+
+#include "../../../../include/wrappers_mips64r6.h"
+#include "../../../../include/test_inputs_64.h"
+#include "../../../../include/test_utils_64.h"
+
+#define TEST_COUNT_TOTAL (PATTERN_INPUTS_64_COUNT + RANDOM_INPUTS_64_COUNT=
)
+
+int32_t main(void)
+{
+    char *isa_ase_name =3D "mips64r6";
+    char *group_name =3D "CRC with reversed polynomial 0xEDB88320";
+    char *instruction_name =3D   "CRC32W";
+    int32_t ret;
+    uint32_t i, j;
+    struct timeval start, end;
+    double elapsed_time;
+
+    uint64_t b64_result[TEST_COUNT_TOTAL];
+    uint64_t b64_expect[TEST_COUNT_TOTAL] =3D {
+        0x0000000000000000ULL,                    /*   0  */
+        0xffffffffdebb20e3ULL,
+        0x000000004a691fa1ULL,
+        0xffffffff94d23f42ULL,
+        0xffffffff8f0808a0ULL,
+        0x0000000051b32843ULL,
+        0x0000000065069dceULL,
+        0xffffffffbbbdbd2dULL,
+        0xffffffffdebb20e3ULL,                    /*   8  */
+        0x0000000000000000ULL,
+        0xffffffff94d23f42ULL,
+        0x000000004a691fa1ULL,
+        0x0000000051b32843ULL,
+        0xffffffff8f0808a0ULL,
+        0xffffffffbbbdbd2dULL,
+        0x0000000065069dceULL,
+        0x000000004a691fa1ULL,                    /*  16  */
+        0xffffffff94d23f42ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffff94d23f42ULL,                    /*  24  */
+        0x000000004a691fa1ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0xffffffff8f0808a0ULL,                    /*  32  */
+        0x0000000051b32843ULL,
+        0xffffffffc5611701ULL,
+        0x000000001bda37e2ULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000051b32843ULL,                    /*  40  */
+        0xffffffff8f0808a0ULL,
+        0x000000001bda37e2ULL,
+        0xffffffffc5611701ULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0x0000000065069dceULL,                    /*  48  */
+        0xffffffffbbbdbd2dULL,
+        0x000000002f6f826fULL,
+        0xfffffffff1d4a28cULL,
+        0xffffffffea0e956eULL,
+        0x0000000034b5b58dULL,
+        0x0000000000000000ULL,
+        0xffffffffdebb20e3ULL,
+        0xffffffffbbbdbd2dULL,                    /*  56  */
+        0x0000000065069dceULL,
+        0xfffffffff1d4a28cULL,
+        0x000000002f6f826fULL,
+        0x0000000034b5b58dULL,
+        0xffffffffea0e956eULL,
+        0xffffffffdebb20e3ULL,
+        0x0000000000000000ULL,
+        0x0000000000000000ULL,                    /*  64  */
+        0xffffffff90485967ULL,
+        0x000000006dfb974aULL,
+        0x00000000083e4538ULL,
+        0xffffffff90485967ULL,
+        0x0000000000000000ULL,
+        0xfffffffffdb3ce2dULL,
+        0xffffffff98761c5fULL,
+        0x000000006dfb974aULL,                    /*  72  */
+        0xfffffffffdb3ce2dULL,
+        0x0000000000000000ULL,
+        0x0000000065c5d272ULL,
+        0x00000000083e4538ULL,
+        0xffffffff98761c5fULL,
+        0x0000000065c5d272ULL,
+        0x0000000000000000ULL,
+    };
+
+    gettimeofday(&start, NULL);
+
+    for (i =3D 0; i < PATTERN_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < PATTERN_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_pattern + i, b64_pattern + j,
+                b64_result + (PATTERN_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    for (i =3D 0; i < RANDOM_INPUTS_64_SHORT_COUNT; i++) {
+        for (j =3D 0; j < RANDOM_INPUTS_64_SHORT_COUNT; j++) {
+            do_mips64r6_CRC32W(b64_random + i, b64_random + j,
+                b64_result + (((PATTERN_INPUTS_64_SHORT_COUNT) *
+                               (PATTERN_INPUTS_64_SHORT_COUNT)) +
+                              RANDOM_INPUTS_64_SHORT_COUNT * i + j));
+        }
+    }
+
+    gettimeofday(&end, NULL);
+
+    elapsed_time =3D (end.tv_sec - start.tv_sec) * 1000.0;
+    elapsed_time +=3D (end.tv_usec - start.tv_usec) / 1000.0;
+
+    ret =3D check_results_64(isa_ase_name, group_name, instruction_name,
+                           TEST_COUNT_TOTAL, elapsed_time, b64_result,
+                           b64_expect);
+
+    return ret;
+}
--=20
2.34.1

