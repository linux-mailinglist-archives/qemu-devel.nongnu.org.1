Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5357E66AE
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:25:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11H4-0007lQ-4k; Thu, 09 Nov 2023 04:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11H2-0007lI-N3
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:24:28 -0500
Received: from mail-cwxgbr01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:261b::700]
 helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r11H1-0003HZ-0z
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:24:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV9vE8xVK2c5u6IkDFp0S3yrZRogmjmH0J8ZRuUbg7Y5VA+JZXddssmilsYzO4s/HDmKnBtG5m7mc8pmpG9dSeDXyK0IopXhqycvbjMN+EqD+R9arkMWvoEsIudH5k0byyrT+aJoFzL0ipFk+EmTUT03Idkcsy79BU8DWOTwhRLUqkX6zgsMlh/WtVNFq3AQmJTg55PfRC3XahtzwSZUCvWLMQwMNHTtUZRFOuHOHAt24auBqQX7JRb7vafW0b6Wgtt4ATgTPJNO5O1C25Tt/SQcrOpJS+VXRdC4vtvcc9A9ljJn/sJVSReTp999c/gkPJzvWkG9pPdiXCFhvil76w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrXJg9eSjdDpA0nSYPeC07AQS13PpVq36m2Sq3kCb8A=;
 b=P0z9ScidHhI+Hkecv4I6zjcoDqts3nQwW2emJltf7nKzulcYMIa/U+rjS2ltdu1X6Hcd0cbhajRqhnJKarM6lUdOERfVOkpMZd5UULwy6GvQm2BDIQxqdwCcA9T7YooTPH4W+trTDClx5au+VP+9XhaI9PTQNSzgb4q98/iUWvuNm1q2g3386O661xQ6Md4B5Lcs3+QpOFrojbZ8c5GGoa4VxbvHc9XWkjZZaUfPdLuwJdiqprN4aKoalvo5Jsb7NId/zm0YRKhMTsFtRY+fcGfq6NYFuE9kCKMQl0FvT/XLM2WZdQ+dYwq6yoS8+d+822ef96Rp3pHqp47RggRvCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrXJg9eSjdDpA0nSYPeC07AQS13PpVq36m2Sq3kCb8A=;
 b=MsfCuO9tn8vqqVaSe64kpXKoETCtMJiustgl9r9A+0EPTf7Wnm6e+PCBPMwZtwwyTNGk4m9FQsPxAnza4bMCmNOItdZQaHHm8XLJyBZRhyipuyoJlGuaYC4HaEPTPBST65t4EHmmWvdo+f4pHNmxJhO5pw67c7EnmucqAa+HDsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO0P123MB6654.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Thu, 9 Nov
 2023 09:24:24 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 09:24:23 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 0/1] plugins: fix win plugin tests on cross compile
Date: Thu,  9 Nov 2023 09:24:05 +0000
Message-ID: <20231109092418.84-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LO0P123MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 2693c8f9-0eb9-4c34-b6aa-08dbe105a97e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pz/BZv3AA8wsYAUXpIicvt2OJSGfU9ylkRvVjae9FoI1EGuCIdUmNloz5Yt+48/9L92nV/wq/8S4I78IEqh70dK+TtyHB4lRZpjN2BJQ6J6ScZNBFYEjw0BGnxyWGzm6C6YIinQUHjuo7+JA5sJdk+mwGc66+u7yFVILiJu4WG3s75KW26YvgEKbE7c2J6b8WaG9z2UupxQcNhWoQ22SoMNDqCpVhHxlT6gRIEgYyhuUdOFgDkuw5csKtRdfHrXqosV4NcgaQdWtv+jI957UxHGr0zoGmiUbBtKRIBt9Fd7SAhnOuW4iGhJj1L+ZIQnuR+IcudvTRX7XFUq8bOM8Rv4lHCbMZPhWvXOrM8JbwWnz/hdA410eM3CTElbzWUDQZnC/V8/io3rjA07EknKo3b5xkTJkHWlp7KZCAwUWOsw8BFaH3P602cnVHb3aRe+roPkY3dtrZJpCzHXU8EHhxpiZiq9UJkXwjd0/p35GV5hMWbJIMn1gy3iP16ADtGkm7HY29Er2MYL+lTHHT7GFCeRuoIdxRL+9DHu001ZbKJYcX5NIfnwU30B1RVqrhkQS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(396003)(376002)(346002)(366004)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(478600001)(6486002)(2616005)(107886003)(6666004)(6512007)(6506007)(36756003)(38100700002)(558084003)(86362001)(41300700001)(5660300002)(66556008)(6916009)(54906003)(316002)(66946007)(66476007)(83380400001)(26005)(2906002)(1076003)(4326008)(8936002)(8676002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oshqtRijJAdVGCzwETArV9TVaqUf7TXwESUDF7iF9fFqIXpqB6xw4/UfyauK?=
 =?us-ascii?Q?PbFoehh+ZDSaYgEmNBLSwRqNh8gJBe14cbKlYdWvcXFeD5SoKSKpdACYpck8?=
 =?us-ascii?Q?HEvixK4oz0lKhYaR8oRLUB5KYhnhvCBl+7XWQ3188/EwqGoXc3+5HPzN22oz?=
 =?us-ascii?Q?zHnQsLansSkjMLX8aTvH0M3wi+Yuu4R+ozckt6cpVN8AX7w106teXpG6I6Mg?=
 =?us-ascii?Q?lP8XQz0+vZKKOYATRk+0S6oXwWOqki2dhgoYNdynqvXsp+mhNZ+II9VvbMCM?=
 =?us-ascii?Q?uI+PX4vXyLrzC/BYJkRBn1LoyAxFYLbyyPDL2mxIkTCvMLocTWPAnIrP+4tI?=
 =?us-ascii?Q?OsMMwIoAzLV8qJa3UCzDD+EqCcOqE/kFId7n7dVO7OkmHtd36G3ydacd8DVm?=
 =?us-ascii?Q?j+eI5AuIHiu+HzOdVgqVZvam5pGho9moD7o+7qi3M8fYqEur9aIY9+cNU0L4?=
 =?us-ascii?Q?4RLFh6g+q6G+dVsDgt7xNGGsyUwXBGvhhdN82IBjqnwdu2Emt+b6LQj5rPtY?=
 =?us-ascii?Q?dsBYFpNXvn5dD5wN6sd97cye4zKuNpaluoWE7X6ds9XDyN0ZFzTl3H6ttjBN?=
 =?us-ascii?Q?oiF0WGqV87xnEhRgDJeuHh6ZpAgkGjJGUJCGy+uZ1nZEzppyHy7JziM36vUn?=
 =?us-ascii?Q?T+k1MFWONyhoTlRj65FnrtiC2w/WRdvZ9MElfiz7izxkGfqh/KRHg7wQ9rH3?=
 =?us-ascii?Q?86yXvn3FBSsj/uh7nj8KlHQWSqmjpA7OIOrewA7tAV5+S7SxMqwCQrOOckIU?=
 =?us-ascii?Q?he9LB6yJqMrowxO8KeGeYX+ZyY8e3ADg5U3oVC68M1P4Yz+mm8IXql5qq86x?=
 =?us-ascii?Q?fiLOwURgZtThYrwLqMeiAP8dA4okiVgWiuWAx864QieKZdQ4/Z7eSq4OocVu?=
 =?us-ascii?Q?/ELpPdijwUXXipnxMx/KsNsaqECRxHy035qjRIjUCJgc/VmQXebLDfIkgh+a?=
 =?us-ascii?Q?+7J7otKtGzdQHdwT33BLPDK2ICjiKcz4tCwDqdxJhxLUbC1/husyQax3BAWE?=
 =?us-ascii?Q?MeuyasWUCtFOGQ4mLxXYU+6qmaHsHOaTsxH728kWNVOp0omDot3MseeJT2Ff?=
 =?us-ascii?Q?rIEky/37zzzGZqVW1dCLMoherf+tjEvvFozcs2ntj3BN9Ygn3roXS0QXwrpZ?=
 =?us-ascii?Q?iAnhb12yxcH71M+n+7RqMg4dXlEm0G9LgwoauaMYvZc5i/vmtBhLByiVKumH?=
 =?us-ascii?Q?LujLXqKl/rwMZr7DaCsXX8HcXTFLONioWY1sYeHpGDRi09G6KJnwbT3b7gB2?=
 =?us-ascii?Q?uSvyGi7q66sUrXiIWPnHpLql8RT4BxtT8iG2byOHH5p91ZjJWi1OxrLrX5P7?=
 =?us-ascii?Q?VvBr89H8eMG3wSIYuEKgsaZH3RwBST5dVqJ4CTRt73nIgS6a3fMM4MQl7csj?=
 =?us-ascii?Q?zum8SMb80mkXAWowAWY6Yf/YVp1G13AkyzgLO04u3VSSRywsqzumdTu+mGMT?=
 =?us-ascii?Q?2TsUZWVLiIsqMz6kS5NzxxT7NYwJRyRKwfjzPFnMCOQbHGYmAjj/7GOnARnd?=
 =?us-ascii?Q?Wo24goaIEUMEFjq2I0T8ef1RuHxIgypTltFMv+ltROIYDl+1Iu9MOS/S7DKG?=
 =?us-ascii?Q?axTQrWuqfz2mINMRvXtXuIY32wzoKsqAW8bZQMlnPvq1Aal0/bTAnyXFf2Su?=
 =?us-ascii?Q?2w=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2693c8f9-0eb9-4c34-b6aa-08dbe105a97e
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 09:24:23.8932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUDhon4X1dYsEHb6E/dp/SUmj45nhJIg/B4E7C1iMM7VVo7qMkhcu3Mzu46iHuQjr7ghLhPAm1n+R/KOMoQ+p9vMOkY+zHHoWoZ+g+cUGrE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P123MB6654
Received-SPF: pass client-ip=2a01:111:f403:261b::700;
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

v1-v2: Added the signed-off-by line.

Greg Manning (1):
  plugins: fix win plugin tests on cross compile

 .gitlab-ci.d/crossbuilds.yml | 2 +-
 contrib/plugins/Makefile     | 2 +-
 plugins/meson.build          | 2 +-
 tests/plugin/meson.build     | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.42.0.windows.1


