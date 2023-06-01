Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5121071F5AC
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 00:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4qUb-0005yz-A0; Thu, 01 Jun 2023 18:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4qUY-0005yQ-HU; Thu, 01 Jun 2023 18:09:58 -0400
Received: from mail-sn1nam02olkn20825.outbound.protection.outlook.com
 ([2a01:111:f400:7ea9::825]
 helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chaosdefinition@hotmail.com>)
 id 1q4qUW-0006PP-QI; Thu, 01 Jun 2023 18:09:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9zzKo4e7GO12Wfis07VbOU7ZBN166avqtkZ/qY7MtJR3cHakSKwJA6f5ri0gMdGvmcCNbjnUa+NMJPAN+BylrK+x+h/X5v+AHJ2jcRmIVUskTqrq1OjKi5IcsIc88VggAurTKEAztaaWLoFWEDZU/RyrcoMoOW8rGtEaGI2a2y6rCyzCq130fFBgglBVQYjUvNw1apEqrbd1CLy4tXZCMW8e+OB5EBXWTOUKyxlhSkjREEBU9qlQohJ/i2Yxn1qNxAn7uOXt14kyD1+1XfzOPbJ6UURv9JFhH6+MG+YP8Q132hT9KEhZ1p43Ml1M0RMrjrslysIFt0WLVrQBj3rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wdh7C33PkfQ8iCckr52XNo9VqThGdwM6gHu8w6bDRw=;
 b=DCAOKLjJu/nh2GDocodjZlIeLROHswliM6Ba6PoCkoHEFqOmpE2wL3Bh/mGEFcOmZJOHrP77vcjwpBx5hQT9A/AhFg0w6gIT1BLFre+R8L4JztIA4JiLIboysrevdhkkmaZlnOFRREhjaSWJwAbTUayZj0drntsvB/3sXtWNGhxxPznArj2IEamUxel5En5EHTr3rjj4CzA7B6bFGnV2j3Us5l1kzWpthiZCEzmaYVNcA6Q1K/6NlQUS7SitD5aSP4kIMQxtDE1xFKvPShgFmnFvnxc/SMWD5f0Cd4yX0TETKqhr6lc1HnBCfdIfowMQOiPWqh8mpmtgLXzOizHYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wdh7C33PkfQ8iCckr52XNo9VqThGdwM6gHu8w6bDRw=;
 b=ZEHtXhzlqjy5OXqPH353tBELsIYzdBJnQe/WZ5jY0654RW84cQZ7xVoKmYcVeon8/dDkipPgofV9fZf+K6QzKTewVt6mm2LNzkCmDcTbMoLGgwnUct9C9HkClluy3PA47a8sN/EJYvG0z0oTYU4QfMJAKEyrIZIOpi9GmOZnDgeYj6ilo9079WKHp6xc2h7xX5WWdlXhZ7acQZUFjMU7tWH/O1A2wIkHquEralzXrkIFyFBH8J/IfmrlUM8aNPQ6VE1XKYL4C3+B3nJHi+aQP+Cni6mL3s2esdL7LRuNyAsQ/nNf/D7zo/bouojgG6T14MQak595hZN1+gQHnBaVnw==
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Thu, 1 Jun
 2023 22:09:53 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::20b8:bc4d:e007:4fbf%2]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 22:09:53 +0000
From: Zhuojia Shen <chaosdefinition@hotmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Zhuojia Shen <chaosdefinition@hotmail.com>
Subject: [PATCH v4 0/2] target/arm: allow DC CVA[D]P in user mode emulation
Date: Thu,  1 Jun 2023 14:53:38 -0700
Message-ID: <DS7PR12MB6309FD700EF00EF1EB541CA7AC49A@DS7PR12MB6309.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [cIsFpNHng84ldKWPDXugJu6+D7HcQDnM]
X-ClientProxiedBy: BYAPR06CA0023.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::36) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
X-Microsoft-Original-Message-ID: <20230601215338.48600-1-chaosdefinition@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: ec954702-d0f4-4820-fe6e-08db62eced10
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9Xmo7HDJh1DrTtBBfugGKTjxKNzyt/Mu7Cb4cfrz9glysO5RUfA6om+STjZoXBJd3W6sTOj2ExmkGVuSbKdP3i0rWXEOnrHxvQJdtpSwaYLwSJ6Nc2nXaiMs880fZPv59RNXpXubjj/k2I0rzcUlgx42L0Y5JToSPhc4ws7wEZCSR6DmXt52USMDNa/xXIxXkNyE0m9J4momUn1PzGfdfyU+K4gglwOrASrotGkmXjg0balVcgPzR42vwviGgLo01J+kWalfBOo3GFdgJU48iP/zW0Qy43wX+/NPw9hbDUCftCy127bU7RAUdlUGXaX0Fz2I3c8Ehxo0E3ia8tPcfT39D8NdT89yV62kqVhAANTmXv2PQb1STFiKfxCVgtpy33JwJBkesPiJvMPslHnkvgNJ5jfTXkmfdiYlop7EIGnAmMNrzL2sLMjb1fp2llDTF3eCo8ZsfrdwirkgB0Xox9A83Rrhw2i0Ohbmvp+72i6YBv7LhlgnvQKQOQFZiMpgDAwN0rT6Vq6ArE73HGdIhlCbNZLCqXWbaW1ajE2YxqnF6uqeRAMMVEDvvJVmlt4kFdCyJvmQXfkUCFoOMck05X+a5KtSuyWVqJar3RBmL2pD1qSwdeTuY6aqfFJZozI/pUw40qPZXlkXM0EF+4spinVQmqUowX/7ddtbFAbPRIoHzOOwPmIUktYwz00ns3wfGzQjHF2CD+krfugzluEMBG6e2FF+Np1rQXUR9TIv7VDzSYJW6HDEPYD0WRsUvcGTjbnA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xFHHGkz7mTYtF8wsgBdHva+1mN5smb/oJNSXM/+xbTaG7+gjFKgMFffTD2BdQH+yEXA7F02nPtjNgjBCQpczIokvA5Ipe+7ax3uS0PkhtQBfqM8NcfpWvxswwJa9XsvmTKi62yUwD500SlIIuXpdzQrVXKckXWuPiguoQcHFIdK8eWWTVLVkZEd7EcmcuDv6MvmPdmAbedV3vAf98bqFRAPKfVXEk0dPoTndghEumAe1hWVtQsAv7s5MQr0TWfA3UhxAM6ehdz5lo97LHkEjvZn/GFwCvZzeK8vO66pZ8soKJBI3x7JMxFY/xmI0UDU+pQjbcZjnFQdcELvT/J1dOUetYGw03M8Dj98O/IphqEsOR/RCK59WL6KiglXrwDd54luOwdT8K7tz3+WMN7s6mdORJ6Tl8ZVRCQQjcmrgKhZph8iJ+9vjq3R5at8D6JnheEXrSnaKD5EwBKmfITN2zJ41XAypEApuC1HW3ysLkbnCp8QDiR/uZt1CeO0xU2eRlUEuLXHZTdUgdnHnlmid3fFoOOV8onF8/E5qcQ7stofsZ3a6yW/eFvABWEAVIgKEjK9bNTtKvPQsa1ls2xvTZX6gWY3JbxpPoBCpv9cS7JI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8jFXbLezLe2/dT5YaT0Yi2JQFD78pxcggbhMCXeXyxvOecjRQ1dJ299UUpJM?=
 =?us-ascii?Q?5iT//6PBwyrsqh83fAdYwqiuWN0WiWI2eNDYeutBTKj9JOnTb1Q8oJE24R0z?=
 =?us-ascii?Q?1daVrIiVPAHOd7CdQnVhcyW5x9ng+ycZEIEM2feyOUYxz9RgqS2X5Xaq1zlE?=
 =?us-ascii?Q?4Mr00w2L3h9B2G/J+QUhvtnc2yD2fSkMsVoTOl1qoWiJrDzUF5PyylyLXTse?=
 =?us-ascii?Q?0ZGg1aBR6krDSgRnrsf72Azi0XnFrPvwxhchCz5QSvYxTAWrchbIRdzbACpR?=
 =?us-ascii?Q?/ksnjBrPKFRk+6oWasOOb1TSnc3rPOwf/zF/GuojTEiZIFEDnhiIrknL8TPq?=
 =?us-ascii?Q?WHmq2L1pFz3XxBMkfpoMzyFx8zWl9i33vWOIKOipd7TV3RIBn8NfCX6hy5Cs?=
 =?us-ascii?Q?ktbvJiCx4q0eXKDA6s48OKlrN6PSgeUX2SyitCX6wu8XIYzPwUBXLGmRkGoF?=
 =?us-ascii?Q?9vc6Rmqbg5ydRkv5GWTEQC+crfmTb5lAy7nyR1R+Ft7WNAXhd5X/rcdMkyQJ?=
 =?us-ascii?Q?wn9PocZSRJjKv5s4Tvqdn6UpWeO7QxrsZZWXn0N7SDXvrca25PGGbG+mMsyG?=
 =?us-ascii?Q?ze+de5ZKBcJBJb7G/KRyS7dEdean7MgA4x7alJzy/jHOMbBkLhnJfmLBKl4W?=
 =?us-ascii?Q?LvHMVz432pvOb80mw3WBADwOr1vGAcK73uNDi9blSV0rxkUveRyIYFYDoVda?=
 =?us-ascii?Q?ofnx7HKWnBm7I148QJJrVa8IPjdJaO9y0JuFbiTy49ViSHv6X4/JFE9z7Smh?=
 =?us-ascii?Q?f9dN0hrX/OzBBEyZfKcuzCN3UI6qbg8kfuRo2dd+I45DhpgIU2JTGbeE0JTw?=
 =?us-ascii?Q?cXXDLnoCnzNuuPLchVdqojcpWmd8O6+jIFwv64CNfJ9mviQRDeko5vKVAyAW?=
 =?us-ascii?Q?f49/rS9ydY9CrQQMeVrf5vwEkPVuNsM87OnGOK5DNj+gkp+O5Iu34axrATPQ?=
 =?us-ascii?Q?7S9T3rFYF/ezB8eM+bueJcOeHKtiPuGMQjZAxiHAo66NiWH5UuNckwIhj9WL?=
 =?us-ascii?Q?nL7yieEUtp1h1sIJR5ZR50PcTh3O5c0aIUEcNJNwA/7SMGqZNV0KlX4ZE1e4?=
 =?us-ascii?Q?+YKkehB4rt45CCtYQjMuuCMtQbSqjzaQFq7uINjYwCw3h2uYFbHJIK7KVljF?=
 =?us-ascii?Q?YNSuLfYc1siTRYoGf6dPCTxCibCPcZmxLOnGVHmmgayUdUb0shRX9rhSLSxg?=
 =?us-ascii?Q?FvfreUYSa0uGsLQ732U+uI3Gy7U86lRcKK3zi+fRDNcxRWoVbOm/ofP4VMg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-71ea3.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ec954702-d0f4-4820-fe6e-08db62eced10
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 22:09:53.6887 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
Received-SPF: pass client-ip=2a01:111:f400:7ea9::825;
 envelope-from=chaosdefinition@hotmail.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
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

This patch series enables executing DC CVAP and DC CVADP instructions in
AArch64 Linux user mode emulation and adds proper TCG tests.

Changes in v4:
- Add copyright and license header in new files

Changes in v3:
- Fix typo of HWCAP2_DCPODP
- Split tests into a separate patch
- Remove unnecessary handling of SIGILL in tests
- Merge 4 tests into 2

Changes in v2:
- Fix code to deal with unmapped address
- Add tests for DC'ing unmapped address

Zhuojia Shen (2):
  target/arm: allow DC CVA[D]P in user mode emulation
  tests/tcg/aarch64: add DC CVA[D]P tests

 target/arm/helper.c               |  6 +--
 tests/tcg/aarch64/Makefile.target | 11 ++++++
 tests/tcg/aarch64/dcpodp.c        | 63 +++++++++++++++++++++++++++++++
 tests/tcg/aarch64/dcpop.c         | 63 +++++++++++++++++++++++++++++++
 4 files changed, 139 insertions(+), 4 deletions(-)
 create mode 100644 tests/tcg/aarch64/dcpodp.c
 create mode 100644 tests/tcg/aarch64/dcpop.c

-- 
2.40.1


