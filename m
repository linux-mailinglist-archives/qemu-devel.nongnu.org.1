Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE77E6AC5
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:45:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14OT-000435-09; Thu, 09 Nov 2023 07:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r14OB-00042K-6B
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:44:05 -0500
Received: from mail-lo4gbr01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:261a::701]
 helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r14O9-0003dc-Ei
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:44:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6jREP4f49Txg8JchLQMYEra4Es1TCoCEMslqdgaAEb9vVV6QmTy3hXwa2gIVXDbJf9P3PsBTzRW3fVZrp5T5lPn/kDXbI4nKnFfz2XJGXN5DE9wjA5k4gVGHHWI+Qm371APDhP6/LuDXDZRFcrHbIi5XJC2WuH1MSf8UNwe53dLw/7PzPO2dgBMIqjv3pOwm17Hrk347ERjMIrAIwWXR8NfKfdkA/v3zujx7+e6zhzY6UvPZJnJvt8NcNS8xkFlvpAYb5E/s4Sp4fABTCpYSYeU6Lm2jS1wVT19q5vSzU1qhQ6kW4LL3PtC2tiqC83dOtMQ8b8zD4xqDHR7TMrPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fPxkQERjqo/ctCHmjoiHbRnRw2PGkZXZJ3KmKO9Ij4Q=;
 b=aKRCkIbmzSpuEe5DLC3OXOu/IoEVdeLImZZ7fqP5aBoXu8JheizMQmRNtvS0m67Tx256yhvK4JAAuajartD2CLsHy3QUE+iwBWXmBqTyEtNO4g0A93BAEnhPCAZOarRS9cvtSBG1GjJq4Xk9OjjTTydfY5o4HMdXmx9vDiVAPDJrGtilxBTfhdJfQsIcGusNbHJd/h5iWjKYJ4UJhvR0F+h84YvhJIQG4h2wmxcMV4M8Ocec5+4mhpTL+KlKSVKFsMkxpDDLvSe1toS5c1EhBQtSkYGMiiTb77EqhvCo++OFtPo2WXVtWJ3zs6U2atT7bVHuVZFEEQCaRR6KfTQJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fPxkQERjqo/ctCHmjoiHbRnRw2PGkZXZJ3KmKO9Ij4Q=;
 b=LQ4XdpxRPQS1oyq340mpdMcE/Dv8+ugMSMgTJVmooOnivA5zhumG0kZAHiWa4i64mnikRUvUN2Kj5DIiI0zIXH7PzJP4HBkJrq8YxVEZ4xLwHE3ng5tZZykMna63H6W7mCUHDol2LIOCQWXZz4MriQ9d73BOOfVv3DrG0L43W4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO4P123MB6562.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:27c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 12:43:57 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 12:43:57 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v3 0/1] plugins: fix win plugin tests on cross compile
Date: Thu,  9 Nov 2023 12:43:18 +0000
Message-ID: <20231109124326.21106-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0099.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::15) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO4P123MB6562:EE_
X-MS-Office365-Filtering-Correlation-Id: 382e3932-192f-4ff0-5e85-08dbe1218a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSemmuqSdziB0ERv4GXYaSB7v7/sKQl3YROCMuG/EDqUU1snP8A0LQbAAqcWWBBBJqUHV03fOGaiSNcPPUXZkLcUbWa2df6BtG2RmVlsOp0MJ6D9Pa8XF5SVlEyK6Bwb9toP0R2LLpQn7agLxkc2Nu0QfpsQTCKxZLhZ8jiJv4noZv66gNLVbS2S0lFeO8XSYAypCgu0DqAlzZ33wZZwDEdtI8Fnws3FoytU3Y9ujp/WOcnaqtEI+pqC/jREyPAd4MVQ1cMa8sLI7zgcVZVRf8a2lj3C1wwXafCTP4cyYKB+EYdDM20DuzxlxZcfuNifC6E+fwtblByYRPOBioDUi6q7qYwv51K5Fhioy24jHSN66LS00+aOUpWwnKv2K2Vyxb+8/EtXaL41cqI1oAb1DcC97yUTQxnXyRlonoU99FXTGUGbrQF7cu4i4uHr7QZ99cocda79QWivrq/qj2lZTBwBpkAo8SLWTINeuiwyDuUcHyGeTZWrTAa2Ht2PMUjOjjtOO2MeyedpUrUHbUnACMSnD5OE+MBnWjTodTzpC2Rt6MnyeP5GPSZuAVRkuMao
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(366004)(346002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(478600001)(86362001)(1076003)(2616005)(83380400001)(36756003)(38100700002)(66946007)(316002)(6512007)(54906003)(66476007)(107886003)(6916009)(6506007)(6666004)(66556008)(4744005)(5660300002)(26005)(2906002)(41300700001)(8676002)(8936002)(4326008);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+PTRWN6ShsMYOfCgiGR3u5X40DDb7Fn+x/Mn0HbzG/agLLD9cjI/0iMdEifq?=
 =?us-ascii?Q?l8mQPd0bVYS8AGJU5D46uKcNJUJSLMa04ku14YeYzHBa7/kG0nl3o26VQbFC?=
 =?us-ascii?Q?/htMY4cwNwhw43eZQqJLCs0hbC1BG5V9vZLi0dPXIBEVQvOVrxCa+IRj9CPq?=
 =?us-ascii?Q?YrkVZ4eOojC+NdwBa/s6tMyj0oaDQVSoG4cIH3FC+VFfEJf811LCs4SMs5sb?=
 =?us-ascii?Q?vvkEFZypFo3NP4LvDxaakuTD/hrNljU8Ch7HKR15z3ntFIzct6ZUvfDo/jRf?=
 =?us-ascii?Q?2g4eSElUUm59G4AUnyv1EqZ5GSoa3I/Yo3CowNEHpJ4VLcohY7zGoJ6AOhey?=
 =?us-ascii?Q?Hp4TUynxc3yL2mIlCt8M4VZfCtfUsa6W7nfsjOR4uB8NGWFBAcqko/hkoI/2?=
 =?us-ascii?Q?/FT/I0+jRK8UKj738nFAw3uIcDgrN7ZlobuCvBfeuEvxC9PGhnVfRgQrt75d?=
 =?us-ascii?Q?WB2CNZVDanDoMmUzrhV6aCczDUknPECyTYZi9YggUbC+yb3VDD6EvaqzinFB?=
 =?us-ascii?Q?yxt82TwM9fDCiqrogAgpp5l/RPI7Q+bNFZlXeaJGxc+WYm1TFmZuprp9Sd4x?=
 =?us-ascii?Q?nd4WBCJTFdu8AlyRVwfx6ZEkUdkt2BNwIIzuFIy6mOmHszipFfQjuR8ZAPLL?=
 =?us-ascii?Q?DSqW1TauqE+4aXIOm3ysM4EfDu7IBhEeo9Fl0TW9+O6f1H2igNAfwxgv+tpS?=
 =?us-ascii?Q?/ip4tMmvjcghlPAlPXjtve/pw1Q8sVpxrpfRKJId8adKqgQXRDyvx6HBGPhj?=
 =?us-ascii?Q?+8j9sv/kEKJuGqJPLJqiGjK8dhbbcVMo4SZJfaWuWSZmpgPwJRPgH9fLxX/U?=
 =?us-ascii?Q?GQK69PKBiLyKnmsoWjEon5rZ7qq4TOgK93Idp1qZaJ5gFQOw6YbMXC6Uyp5e?=
 =?us-ascii?Q?i/tgChWksbr4BApEPWG/TXTmO1XQCS38Ie5vGqMJPxhyRDwIn+22frRA+8/n?=
 =?us-ascii?Q?LX8ccjBgIz1NK/AH9qbkPFK8GKVH7jFU/8D8uvQRwHEmDnpqPrAPk8mooNWX?=
 =?us-ascii?Q?rKCCd3IlzotKWye2Wz9SZEaT8FVeI0QCqigW4jO/DamwsaWGfvrJ+X2XTnBb?=
 =?us-ascii?Q?mKHUNKoCrkDtdgh/oAsxSGjNgQ8AwsdOqGco3a+MIjJwxqRtPIImNTIoFgUH?=
 =?us-ascii?Q?j2WWj9bz1iG+c85ARroiYQi9iUbCtQ6D9Zvl9UQ461XQ2oBoW97UqJ+pel/z?=
 =?us-ascii?Q?HgsvF4Kqi7ZmjXBrkT3RVUNFilrRwKNJ2IktmhyrwoWdZ+wHnHzYVeAAjOSx?=
 =?us-ascii?Q?+hSw2sxe7ejDg5NisZTW+yGNbO+J3I7vX/ZI5vzBhhCtbGqWxkMM2UP1vbZ5?=
 =?us-ascii?Q?DvvgtyeBZMRiXKAQ28mFFyvNC1m58qVyxxEakT8pTbvcz/YTy3Uq8AGvipgn?=
 =?us-ascii?Q?vaSrXArz3wiht2K29PcWzrsaObTP8eP5ZpGtWHmCUbaP3EQ8Eubk9ljqu8m7?=
 =?us-ascii?Q?fcE3/90OY7Zwviv2yMKeSZEizbWksxvExSjIsSLv+UKDvzFfREkx4YVTilSL?=
 =?us-ascii?Q?kXARFFVfZ4qjij1x8TvlrjJ47fxaBTYicJeXXuRVCo7A+uXBZCdKXTVSY9wH?=
 =?us-ascii?Q?AauEldUzAI2k1/jHnE0B4PhKIJPDW+8K6SB2I6AZ+PQm/ivyn3Le6y/uPw+a?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 382e3932-192f-4ff0-5e85-08dbe1218a3c
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 12:43:57.6905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NNt6cbVe3MT1cUzAAKlT6k9R8mInTKIFx8OjoY5RwDR4WRrRCH3sGwid8OdJN7nApeYp/L9oLCof1JYTHX0uq6dWxpSgOU891aUT+mzwMZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6562
Received-SPF: pass client-ip=2a01:111:f403:261a::701;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
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

v1-v2: Added the signed-off-by line.
v2-v3: Fixed the issue reference.

Greg Manning (1):
  plugins: fix win plugin tests on cross compile

 .gitlab-ci.d/crossbuilds.yml | 2 +-
 contrib/plugins/Makefile     | 2 +-
 plugins/meson.build          | 2 +-
 tests/plugin/meson.build     | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.42.0


