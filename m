Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BA67D6E68
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 16:07:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveX6-0001LV-Tu; Wed, 25 Oct 2023 10:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveWj-0001Da-Gs
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:06:29 -0400
Received: from mail-vi1eur04on2121.outbound.protection.outlook.com
 ([40.107.8.121] helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qveWe-0006ng-DT
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 10:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kis/+J1xL+Oou/sspJygQlikk/z/KcDeHpVV0KIS5gBseezNZc48S3OgTXS4toCjCpu0Rtt1AoPoJkrellX74L6TrLE7OSGHuaWCjGphY5KuB7ywf/5Ya/v0V7QUYI6xeZXVEAsDOqJuoG7QkYZRqI9D+ViCGMjkUJEnQ6CTYHnff96OYcD1xRtY1TKPrWWFivbd2e5ZKLf0opVVOC1sQznaG5+F1CHuLyW2IqtZWhuH7fVyQ93xqKjTHed5HkRZShRrOTQKUrwKh/MtFQZblSp2oe7u6JgU9+1pxtaGAtY0ZSCOwdvxF1Wgp1xFvMiPFByn2m6tHmKk6CIzCOtLjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngqP6VMVn9mvrDpqgrVUEmgEmKo6vGAaMxRi2vPw4gk=;
 b=BQMtUIW0G0DaTi6beVFW7XiGi5N/NcacAbZ1yaVdO3/RH1VVoxoodZ+Y4GSaqJPIEwoO78g0p17TjBz6CWW9tpuyH4xQY8U+uGJ8ohDhzPMQd8XdZVVVQ4LexnryBWETwBNvedAQRjYYSYh6IGUmhPDjEmKY41EhZdHvapNVt9NN8STm4drv+PWdDfBKFiLgFYzQEd+lZ2Zv59uyF6HUn1vnbsxOSyoLfTfDgOp6N1ka7bLKiIGIUkXsCGL3DZ1BDiUFizzDlQVb1qEWRylqQD2nngrBkSBAFBiVaQDWqMz3gv1yYJIH16DDq74iYYMYRaN6F+jq1yPnMqnt0qPt/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngqP6VMVn9mvrDpqgrVUEmgEmKo6vGAaMxRi2vPw4gk=;
 b=WMhAP/lvGRCY/6ey3ZXwiXt9eNs7NoSMBJ2ReEhS21rhMrSIUEk8PL4+vVkRn+pEySay2oInjFa1SbgJsny11/v9sEwlGNg3UWOGhrMxrOEOxmpKcKUfxw5y1ahfHNrkOzMe4yKyqecShjjlHmj0kIUJ3Zvh6WRMMhoXdFEAaMT+ihD6bRSRTXyeIYRlpAq5UtbeoR08W+7gVWiupHl93sQ+/pl5kLZIyMu6tR+tl4NDJFdi5InTSOaFad2jg/mu8+yU2U71qjDXnV7Mrn5eTc8Yl9mhYj/sCmO404Vw3A7ywi4TmT6C3PUKI0FsWsczlxEm7eYSc3oEkwTGOzCnsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB10363.eurprd08.prod.outlook.com
 (2603:10a6:20b:56b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 25 Oct
 2023 14:01:07 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6863.043; Wed, 25 Oct 2023
 14:01:07 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
Subject: [PATCH 0/6]  qga: Assorted patches, let us discuss
Date: Wed, 25 Oct 2023 16:00:52 +0200
Message-Id: <20231025140058.113376-1-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0167.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::24) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB10363:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f933702-0f41-4075-4fb8-08dbd562d5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U672UwxWx1S4sT9QKjQ6IzakgsdYHi2iUWN6kLfF6hgttSwprQ8yUTraEbexkR7GBXJDem2k4pF/KRzrsNt0sS2IfgPeaR60s9rS6u7P8J/UlEHOvBj8f2gfZojPfS/fY4vryJIopYHAMUXnWoyVXoCDeBYXtbSFEBPfKqb6Mb5hAngb3TYdDQoCkccy5dkgTFIqOwH4M5nwVr0+YTHD104VT0PYWy1y3pfQFvAajRasdiPohsU70dvFg2YnyfR/tY0YEmVAz6FPsZI48aobMNyj3aFhugwvf+6+MTAkDpXLkCJS3b7Ng/TCkq1mFinokupgIajNPQ8lIO92OWgWfnbBuQaexxgq4xDvq8z1fze3v4/bVk4ZEhtjH6BA45xj6kJYPWJXr67Wd2q3jNY/aIgHPY5pzV9WXcyyfWwBLjxyAA1c5YtlWHuEe1+YzkAaL9SmekiwPRMvOIfsSYAgjgoy/BGRZQ93Tc7ChSnTi6vPqUD+G8MynSOLeUq3F89EJT3DRhqSK1N3Nv1ag3JWpPjz7LXBjbY6qiN0WzYX228APlX1vy7kQBplq2D1nsApv/LORtGmXYB5quBRSztNQ+k3mqQOXXPuNssfN7e4qm1mD4wdRY5BrjC1R0fiueVg
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(346002)(39850400004)(366004)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4744005)(2906002)(38100700002)(66946007)(2616005)(66476007)(316002)(66556008)(6916009)(6666004)(6506007)(478600001)(1076003)(6486002)(6512007)(52116002)(83380400001)(36756003)(44832011)(5660300002)(86362001)(4326008)(8676002)(41300700001)(8936002)(26005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?haUMA9ILLKtENJQY6cFiPdQAx80ZIxvhZIBWZoJHTn1mkkW3U4rKUde3rytE?=
 =?us-ascii?Q?e1mO/jnfzxiGN/JTLCyIokIAhwK+DiekaGyWa31UI4e3kzKhE1QmSthRVWNh?=
 =?us-ascii?Q?WKJNZgfTqAodsqQqjEcmft3h1W+oyF3Jdyeiu5MxWJWZSo77BUtXkkQovmVY?=
 =?us-ascii?Q?N+7YuD58JPob3sTNbrj2eW2bBoG2MSkPf+2bVR0FqYd86vGmICzbTpOD8Hkw?=
 =?us-ascii?Q?haym/Zow1XrEeSSuYwBmMNfsywfnlaILEgRyaYUoii4no5ghNXZXgROTjlwI?=
 =?us-ascii?Q?mHEV4TLohyuKIm2dgAhcc7LfXVhXTZM0GZNC+UeO1t9CEfJgquSp1cw47S4A?=
 =?us-ascii?Q?hoimLkQk0LGFJ76yo3Uk8UCMUVBZWq/5oeTB+vOClxfBBkPvJXUjTcmj57H1?=
 =?us-ascii?Q?yBaxVA53zotQJmr5hN/i8Rw8M0DOTzY5ahDo/MZiScF88yvZga3VFSULiT8m?=
 =?us-ascii?Q?ajIIGwKAUfJfvCt99PR0XGLrItwjFA74Xz9VrjObdVQVHKR85OAA+w1MCmHB?=
 =?us-ascii?Q?P4htaoUNqFo40CJmDNa/Afqy5cqbV3wjygZS0kEEpIo+ndmMHB6FkJPyuRbm?=
 =?us-ascii?Q?+VbRO9A7bx3LDs1tW2w0PVYm2XcZa5GW6nTSckcdiktDMKSglSpyKZRI+m78?=
 =?us-ascii?Q?Q52Om/ENXNrfjjW6IxzAmz5cxr8PmLbbAPrcq+K/er5lLrqZ92spnczRtEFF?=
 =?us-ascii?Q?o0YixakinrgA9BaCSykKHFeCRcsNcx/skmDVXZuiON2q9Lkd5vdgsL4C8aHC?=
 =?us-ascii?Q?jr8gtM4hacnzx4Q+fr/6hz0FKuBdLvtx7Oxwign6MUKNJ+HZTrKnV4KbeEHO?=
 =?us-ascii?Q?x4LsI0MElcajfF9N4RsiXtu6UP9nyt8eLgfc3jH7g0ZYhge/js+5L0reXwFg?=
 =?us-ascii?Q?FENl6I2qljs7A2EMvPccXkhSYdtU+9lpYHNyZiO3RrD7ZTBcvAUfHzgV7cik?=
 =?us-ascii?Q?9AucPQWRYUu/h7ialdZv7HI6pBw9VH6Ur6k73c0U5k3fJ9ymgDQoS4D4w4C9?=
 =?us-ascii?Q?yGIF8ixoyeet3hJwDABRyTWPorC+TDwejMoVVaiRGDH1MoVrgivgk2CT9sh+?=
 =?us-ascii?Q?hWsu/JPKokpOeFocDRkfyFyq8bmqQH3GU47UnxwVlkYOAClMz59aVc55PA2c?=
 =?us-ascii?Q?FwLZ9rTIro8zBsC16wd7j0i1b1CdbUuuKDu+eyFlNhzsI3P27KOK0oqoU3iV?=
 =?us-ascii?Q?+cetETplZm0xNf3RossB+LcpVauFeAD8ilR98W2CMQEJSllyHZkTDmurJGnK?=
 =?us-ascii?Q?kZlEevDieV+B4yxahuTriiea+SIusR7amM1nsO/80Vk7RMIHoM75r7FCnVFM?=
 =?us-ascii?Q?hhQreb/YdWOX6Vu86Bsw+TZ6K33nZQPggPZJqRxbDqQLfE6KJX9y22/T2VUX?=
 =?us-ascii?Q?MczRLPsR3qHLB0BpManJbgZAqp82oad0p8JoaD7u2d0ezXKPjpM9LV3AuMoS?=
 =?us-ascii?Q?ciymeCgK7241wFFxh4w8edvQjuMSuRrN4NMmNsKRzI1eOqkuDkuxh2V7UIHA?=
 =?us-ascii?Q?DdOSiforCTPEY5GdbZq4sR9mK7RK/P55VyxGUYHe5oab96hCVYL9Iwa/JTbT?=
 =?us-ascii?Q?nXuZ44iJTMbFSoVojogE5C2sQ/RXT38o3QuHDh1e7exS+qNNTQmA8C9TOIU/?=
 =?us-ascii?Q?5rSY4cXWVEAqFo9VEsXoUmA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f933702-0f41-4075-4fb8-08dbd562d5bf
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:01:07.4513 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2IoVCnshXTtAG5MIi3uoqr/7S7JRjIcvtCfC6dVwyoGqJiKK5+P5mRQibi//BECK4hXki+nn3yJi3nFR2LMDuAOeaSO+Ww6zISO/Xv7BShE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10363
Received-SPF: pass client-ip=40.107.8.121;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

* Add a command to terminate processes executed with guest-exec command.
* Add an optional argumnet to guest-set-user-password for user creation.
* Add an optional argument to guest-fsfreeze-freeze-list to thaw a freezed
  filesystem by timeout
* Fix a freeze after a backup abort.

Alexander Ivanov (6):
  qga: Add process termination functionality
  qga: Move command execution code to a separate function
  qga: Let run_command() work without input data
  qga: Add user creation functionality
  qga: Add timeout for fsfreeze
  qga: Cancel async snapshot before abort

 qga/commands-common.h       |   2 +
 qga/commands-posix.c        | 184 +++++++++++++++++++++++-------------
 qga/commands-win32.c        | 102 +++++++++++++++++++-
 qga/commands.c              |  34 +++++++
 qga/guest-agent-core.h      |   3 +-
 qga/main.c                  |  19 +++-
 qga/qapi-schema.json        |  27 +++++-
 qga/vss-win32/requester.cpp |   1 +
 8 files changed, 298 insertions(+), 74 deletions(-)

-- 
2.34.1


