Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 258BC7E66B5
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:26:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11Ig-0000be-IK; Thu, 09 Nov 2023 04:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11Ie-0000bQ-N7
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:26:08 -0500
Received: from mail-cwxgbr01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:261b::701]
 helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11Ic-0003nR-QY
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:26:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPhy9sE80LvMjqO2l2P+sWMeDy/oFbsaZuxwi8R9+o04Ke+Z4jgl6yXUgi3FmH5F6Qa56A9czccbbx6ods9XH+LZndMslbIUnGvNxwTMhj6/16+7n5MFRdOAfNg3hahPRSkZKsNdvHBy1FBeV3LWkig7JuYYALWXGU6GfRBCQnyoB6vXVe725crLhMZNIRBddXb5wdCYZradrgtHVCyiyU+VirqzisNAecRDvUo99dl+oOKe7epHcc9pHNiU5ttpNZGBOe00ayPblQT9WDW/3wU5av3XX6b7zw4ae8T/RzOcxQ24IrOY0nvh1geD2Y4hLhsWTU0W6BzgW4DUFDxUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8F4HecJL737nX7470s7xOi+MKu7ZPLT+LXsKt1cOIM=;
 b=DEYHnBjFfXaAFPXhDx0KRB/41JKbyFeDmu5eajr6xxu9oF+Fq7AJ7to0HwSAx88ynez2xKLTC2Bp2sYr37HLh8ddklz7TlLispAkPvYlwiMQRrCWas+yudfDqmeRQrUFk6A/W1+zvWIPjFNPw9X7AJq7twpbmoasT5pCyZdaZvLk9wlmT9hiJgijeSN1m2aF3SD2gsscooyya+QBe/Rvqnx5GQj/lXkU0aUWGsQFidG9k4ApyymIYkwbVLNCxwsKvRZMwBY1t60p23eS0HZ5wKL9b74SyT6ZGKGc51KxYyF09IZ81yhHnWwosXGrljh6undPZrmFLtDWe3Uq5L1K2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8F4HecJL737nX7470s7xOi+MKu7ZPLT+LXsKt1cOIM=;
 b=aHI2gYdMtMwHhOEqBjpEGBYGusEfly4+1rcYfkjWrqL0aMbiLjLqBT8liyIKoB2uGDss5gulHP/YuP35NUXqXdMHmxnyIrb6oxVU6uCPbSOGHpPg+BzR+QV96GYclNqyEzkE/GuJad+DSdCD/F0Dfonxdj2WJC2WhxsmJc9VUAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO4P123MB6881.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2f5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 09:26:00 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 09:26:00 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 0/1] plugins: Move the windows linking function to qemu
Date: Thu,  9 Nov 2023 09:25:46 +0000
Message-ID: <20231109092554.1253-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0140.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::13) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO4P123MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: a0035fc6-6710-40a1-c2a7-08dbe105e30f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gci6Zik0CvE9WHamUdshnWZmQABN0SDu2KRU30Z/aCci5BBXPwJsT8kwO/QGxNW8tXwk5/o4JveZQa6g24JxyCo0wHb5xG9OwbtrRHyZJzo0JWYQATOxmpXGyhk45FZdGkwnDQEwZyB4YJGB0OMiZREPG+K32XVP7k+OTpOe9Usla1PPumQ0Z1Yy/vO+yOh+azP8HuZIQyoRtnR+3epNPBhgp9M9as+VS0weTnTuKX3Cg0N32ydjYH+QuGPjc0K7FRgaFYaNAcx8Kqa+Zxp/yQt19sLhnmkaO0JZQPYF7aBJRqnQvdmzEquFm82j8ipZnQKxHhdM6uSldCAqKi1hrZA2liEL+pfZSTZtFchUqEEbib+CTDHplwaxJ5/xDcgSHFigTuyD5QeyjOSoJn1as9ypCXmT4iI6ALs+OiuM+KLNHmDSpRVZCEGGUEvWjlCNep55JbTZt2HymQdawnSoM9jxCDAv7Dq6hcuL/UMgIncxbI0hqz7hWU2KUTos2BPhT8zgWap8dHJhs3FO2m7/9Zu2tcirvuQwLqoUhUGZjZ9h5n5C2CDUBR/vQUhlkmNN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(136003)(346002)(396003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(26005)(6916009)(478600001)(66946007)(66556008)(54906003)(66476007)(83380400001)(316002)(6486002)(41300700001)(4326008)(8936002)(8676002)(2616005)(6666004)(2906002)(1076003)(86362001)(107886003)(4744005)(6506007)(5660300002)(6512007)(36756003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KP+yj6SpQHOv+/fThO8GEixXzfhMnHtFhkiAf2NslFrJieV1O6PP6jZsJUZ?=
 =?us-ascii?Q?2Bn91cxVudtVTowspB7DTHGfdRpvyVTW4KevidrpX43jK00nE2jxlp4J9MvR?=
 =?us-ascii?Q?Ktrxv9DjTFIl/6ZB759ADbeaxSwBUfBAUHLhKRHie0pmSH45wRVid1VtMMTI?=
 =?us-ascii?Q?CFhhfmNYf/f8mOs2RCwrCMNrKid9BLwqep+SiGshyaqyYcN2lSFysJy6Yj5m?=
 =?us-ascii?Q?aiUBWiwwzZGAEBNUISVGt6Ya5NItsn7RIEE5X0m89kQe059HpWu+akvELYpu?=
 =?us-ascii?Q?O8Cwt06doa90ssDm84GeXP/AuJtQWqBEAtwCZUsfirMJ3t+0zigQgCpSbRjb?=
 =?us-ascii?Q?1FgW1PRD9ZDJv+E/Qw46Jn3HE6kR6pJVVUD9vfxbuugWxanT6ltz7/gFGxjy?=
 =?us-ascii?Q?/xTwcuSIx4BJ1yTmZFicSZoOpC4Q7mJDQs7ofd8ubOaeYtxOU0iCxJ9iVq3k?=
 =?us-ascii?Q?oDd9sCP4QkpuS/w3XhX79BHaz+5F+0mpveQhLuIgwJfFyBCfv5tlcVuFBLRh?=
 =?us-ascii?Q?nn0GETKaygxJKX1oDJ1xkJWveDVP8m8yC6RGEeRSW+nS0Rkl2m85ST0xxK8o?=
 =?us-ascii?Q?sV11M3/vsu2dKIlo5xgeuwDBm9uaKzGCLWoP7y20bdZ3mKJclgFJh7lcmnmI?=
 =?us-ascii?Q?QLiByeLAZ1DwZD64jPTvUlamjsxigskV6KdM0Xtsnoq7kWPSjrPahv6qNRio?=
 =?us-ascii?Q?BYD2eNHGK12mwKQhy7UhUTj3vavF3J4fte/2hqopIFUKK8VV2fkOnLHWZat4?=
 =?us-ascii?Q?vRN3YX2LhyVVGq0imGifFHzBQ6bpBbYtfnSD7EkUrx7Jn2nfx4S1Gt+quLvP?=
 =?us-ascii?Q?gcVljAtoB7P4hNR974Yb+5KkGZ0A5QnJ7iwHdCFVz+rcboJds4GvD17ISqeZ?=
 =?us-ascii?Q?y3ZooJ/705Es8yBs15A3OpnQj/nZNrZ2octr9RO8/pp06pVqcbaRbjwD0Ra7?=
 =?us-ascii?Q?/uxQWNMDHN1+2Xc5f80zc3xYyCwsLAaiemzQGStjpA8ET23bMcUgbkRe7G7a?=
 =?us-ascii?Q?69eSfvT6cQcQ6C4wKUlKeMdW6PleWdwgskjSqyoAyUtu1yGKLPxGMSwu5W3v?=
 =?us-ascii?Q?3gYO7EVwE5dctVkKXS+yW42HjK/rS4h3qrnU9nOXVlVCOQ0cqDyOGwpu59PC?=
 =?us-ascii?Q?vd19O6PQSsnlKaas9iDMyDiamx1Pf+BDwOnyZFde2F28V/NBd/1xnQwG6FkF?=
 =?us-ascii?Q?r5I1A9vnqHGno4jPubfJNg0QnrorTR0BeZTbJPrAQSd7vuSfrl2WV+6z14VQ?=
 =?us-ascii?Q?YtdWa5UPEChmBW1WbUa/lYEJmUmDw64Wi2MBwrQpGIUowZ6GV6gMx1WGsJME?=
 =?us-ascii?Q?HnvP1HRqC5BWZLHaTt2B0EJVbmxBie/qEaCmZFWNEV/BFUhRsPa6nrQwL5nX?=
 =?us-ascii?Q?RrGdbh3eiyApzEoObhT9KgJdkelU3lG6IpbK4ZbEZ/dQMd5mopzJTpAVw6/7?=
 =?us-ascii?Q?RdT/vub6Gi+jmPi6WoMsUdGX0AFjxVRuVBfHLN3zRHCAhE2LghN4ycgDgppm?=
 =?us-ascii?Q?DIAwf2XyRQsBGd+CpEmyuSwUyP0iMWYxWod3sDwm2CEwNXm00JQ/DsF4wO/O?=
 =?us-ascii?Q?egx1Ne+TxXMUH7t4wzJZK9KbrUaGwFSNQipTAej6g9ZjFsxfIO959WsX8zRA?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0035fc6-6710-40a1-c2a7-08dbe105e30f
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:26:00.5620 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ4TZLjkBKbRKqZcv+1jpTl3M0Oqqr6LO2l12q3u9SzoiFAmc8Wr39IKJlxLHb1Lf1dbQXd+DxgLfNlc7jxaxmAaNPB/2+215Cam5MoqLK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6881
Received-SPF: pass client-ip=2a01:111:f403:261b::701;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-CWX-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

v1-v2: Added signed-off-by line.

Greg Manning (1):
  plugins: Move the windows linking function to qemu

 contrib/plugins/win32_linker.c | 23 +++--------------------
 include/sysemu/os-win32.h      | 25 +++++++++++++++++++++++++
 os-win32.c                     | 33 +++++++++++++++++++++++++++++++++
 plugins/loader.c               |  3 +++
 4 files changed, 64 insertions(+), 20 deletions(-)

-- 
2.42.0.windows.1


