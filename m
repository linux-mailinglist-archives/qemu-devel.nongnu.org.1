Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6307DF0DA
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:07:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVWK-0002OI-Do; Thu, 02 Nov 2023 07:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qyVWI-0002No-Qo
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:05:50 -0400
Received: from mail-lo4gbr01on2116.outbound.protection.outlook.com
 ([40.107.122.116] helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qyVWG-0005vk-Lh
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:05:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StO2z2Rntpc4/qiYZANdyGqLfTV4odfB8j5s1i1IBXxTZyUIHt6Kymnr2lMRTkNyay/9p/qcFjLOE4+A8WdAT6WRKS9TH3jI/f1rVs0hxSUjQptyHPG7+97HuRVQIziGRNmQQkh1cI4tigKHPQ7EcKG22CUCdzHkF3CX8FSvMvO53eiNSt9VfWo9qzZoCuuwYZ7Q2p9p9SGc0lV4yelloLMC+49PBKLkBT+PLQoTEUp3DObXigeZRpSm3OSA0mOk8orFJlATn2GmTdFMlDMGw5TqHZYaPTi9owiv/8Oq1LYf6PQEQXSLgejaN234xI2w4KEEE9ZqJ0xTqHAyunXYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoSZszHY2qD6snocRbEKwEBotLRpHozlJU4utpDtmD4=;
 b=k6OYo8kVMPLhRNNHVs4SyXMpBfLo+hU8uNBaGZIWuyhVk46yHNs4SCjc1NdxmqMfOGnJefvj/6fFpt82V5cVsk36cvmNCa/7vLpPaypkqnaLz3mRn0QwZUWfE/AUk0CVOjAMxmCNWfUPUC1cE2GZy4HhlSacpDwSjXvnmOM+R5G7/mg7YQFppqVkYCpSZa/QRr+A+n5F7JNVJHEXXlDOQBzK9pUXUmTtTEODDUo4SgW1Y9DqpvtdXFfjRl/hlLxQD2vtQWhFRycOE7SeZXzuPxWdLUl27cCnFhzKNqhxrOCGelqrTfu59D++1+tl9baIqgcL5aZ7a7O8qAf57UTJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EoSZszHY2qD6snocRbEKwEBotLRpHozlJU4utpDtmD4=;
 b=YF6xAlWhddRsNkQZxrr4aWN7OCxz8+TuWDFmWhlhGbI5ebxYx+krdN9BwpxR8PICn1W54aLnc/XMGCF6J6ytwicMbtJ+eY10A9oOypfvDWppjdLB/Vb3oNgliNwO0L7LNDjKJFhXYoUJsZMRtn7uKBu9yqTi87dA17mHJXYdPRw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LOYP123MB2832.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.20; Thu, 2 Nov
 2023 11:00:43 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1e33:b4ba:d19a:8236]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1e33:b4ba:d19a:8236%6]) with mapi id 15.20.6954.020; Thu, 2 Nov 2023
 11:00:43 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH 0/1] Enable plugin support for windows
Date: Thu,  2 Nov 2023 10:59:41 +0000
Message-ID: <20231102110016.9494-1-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0099.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::14) To CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:d8::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB4341:EE_|LOYP123MB2832:EE_
X-MS-Office365-Filtering-Correlation-Id: 4257b5a0-8593-4020-f395-08dbdb92f565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uC1eWkvwpv0qAWHvt4rAfuxXqI2VkVcUxHLBboRS3HPvbOZ6HF1zbq/X1ia6DaazuWFpak6wZIemistWvmvUmaoioLp1IwhBfp2rMX27PR+YfxwgArPYctKUM0GWrOjsufe+8na8oiJun1e0De6yKcwF6oBRF6Chkli1Bgsvs5ghqpaDdnFPSKSYahuHOj7LevWqyEb9irF+uOgqryX0FQprt0+RZKMh8uWwsOq5OIIg8Ffoq/9rzvNMe+GhNEZewxeBXzCgRi2nCVEfGMTtinQBFkqwbjbsI7UBCHbXZuvnIdTcYC5l0kqdqMsM2zrQ3LWUofDDaIYW4xJMMww855l1D9jhgMDHmV42UmRAEQd+E/nF41vxp8z2AaWHL5VIgKAjCSetMeUknu8Ax52zWSeQKa0pPgTgmu8sxYEn10lMhTjZzQhBK8aZxzDxXHmnKq3XPct1tuJ8xQNgjeWtC7ab3fyfE5bk6pUgFN+AfNT70fvxqIs4KKRe9XjybNAwvleCTa8sdHyLSCtuoQTMsCItqogyUbHr8T67JLKKR/FlqLRrHfjhwS+H29pBOGtaQaeLbbvs/3uUOG9JOWuULj5z4Hl8IrNfXeIqj2g/gfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(346002)(39840400004)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(66946007)(66556008)(66476007)(316002)(6916009)(6506007)(2616005)(6512007)(36756003)(26005)(107886003)(1076003)(45080400002)(38100700002)(86362001)(83380400001)(6486002)(478600001)(5660300002)(41300700001)(2906002)(8936002)(8676002)(4326008)(460985005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K15x6YvIgR+szs9f09ZVNMXgHBJbijRmXznOf3AOXtM7MW+a9xetEI+ihlQv?=
 =?us-ascii?Q?+/3H4RBBpbAXqGjMQIzHnYp0a8OJZvdQb9Wakx/Orxe2btJS6PKOSc19LCuC?=
 =?us-ascii?Q?ltzsIm6UPmtxG1bj273I0Y+xy69Y7aZ2B61uHrprMQZkAnhPvhsvF5yHW5EJ?=
 =?us-ascii?Q?C/bhA7vF2xTWUpvDXZ27fjrD9MqEmT54cjzT5YEvkYEpNCHA+1QqESqUs76K?=
 =?us-ascii?Q?1nfVFlmMzm3+JID7J4rtHv5lvV/J0r3gDmVhUWCrET7Zg3SE3IM1jct+euil?=
 =?us-ascii?Q?frbjCQvpPNI0wuZCB/Q/fHAyPfPnTMEbGSM6E1UjeN7xKMyyeDUdVx7xMct7?=
 =?us-ascii?Q?NfdzJQwBGZrgziamSVFfzty7sg6vn71QFcu9G4ftKxheRl2DZH8eFDId2GN1?=
 =?us-ascii?Q?pvFpFn/cmmvlwq/f1spHj2inVPd0WS9XDCHdHsPHWy3FeWtWfVEjJExyvsP9?=
 =?us-ascii?Q?Exd7a1jJwfNsHa7wM9RTeNn7rK9ar9V44gew3CuxnlIIxQfuTzb+R+63H2W6?=
 =?us-ascii?Q?llQNVNhUsFsQYhSWriUyx96hAk8NpjGquZpSIhXW9lTehFVIGNi9zuPs4MYe?=
 =?us-ascii?Q?MzP+c7lvI308xACMUfv6ycOaW+/JhM9pnuRry6zVu+W85BCR7jtQwZI2okFB?=
 =?us-ascii?Q?V+Gi0xMkmVD5Oqyp88Y2NkHbDEwoOwayo0yhrbV4oyw7zNHOfT6RHEkLzWyc?=
 =?us-ascii?Q?UzIk7nhVFxgC9xNSc48GrNkPYAwOGRjLcQvWTnBKKygWBBKT30AYlnU9Qxq5?=
 =?us-ascii?Q?xIE3P7Y7pXc+CaY4Pu7rl4EDrDqbYFlnhv0I0tt9ZdaWid7bTcV66EhCw1V3?=
 =?us-ascii?Q?GSHkCerxWlhexVsjzMpraUCEtmLm0VMFAoGeUF9Nd1VQcu04lEUsBC4F0TDq?=
 =?us-ascii?Q?HjusROOmqG5gaU8qKP0aS8WT3yOQ0g6lQO7WR/PPa/DC5Dk6xIErbL3fvigo?=
 =?us-ascii?Q?K2+g8UWMVTQW+YS9Q/tpZkGl/TU89wr0iUxokvPqPeCn0IVyAvQfAnmuTbUE?=
 =?us-ascii?Q?Wvxh66fmL/CCdejjF+uK7ZLlM1GopTsGdXuHxtAaA2+ZH/1XLQNnmoz7eu6c?=
 =?us-ascii?Q?O5xqe4DDzc1dfNV6rnWHOWhBqzTWmk1qPtZZ1+IgtPAW0ZT8KIITnoqJdqb2?=
 =?us-ascii?Q?OVRHkatlJmEFf2aDujgkutpopedcLZuuegNyFdfHS1cr9DQb1DLHTJEWvpqv?=
 =?us-ascii?Q?3jxp+yDkeJljzTrHSw+WC/TI6rWFHeXZ4YuRmR/d7uKC2omU6jUJcymHK7Kw?=
 =?us-ascii?Q?4IkY3i3VkBHHqHVo4maqQ2bSAriOPefzLt9tuwkA27VGWb5yhcrW0H9viyDp?=
 =?us-ascii?Q?7CKoNu3gGL06O9y151DYC8Z+8IrUme704Dr8gAMQfjEvI++s3lY2DjFjiEpv?=
 =?us-ascii?Q?m5xDU0eg1d/LP5jWUd6QWVIiRM/ZKnMM5bQWeqz8fflcKtZbVsoFrYN7w/z9?=
 =?us-ascii?Q?DnnwvCIo2Bg/hFjeRqwepNjztY+2Czm3Iy4te/fgLFIp11u4zyFU7ZeZmiVH?=
 =?us-ascii?Q?AzDwnMgTMGHvASRgtBju8is3RLzsx9Q20tyX0m94W9kXv3hos+O5leSnClh4?=
 =?us-ascii?Q?0FSMQ4bnYl7aBE87GeMPIgR8SiI4MLdBgZt/r7usSxNPBmHyUVSM4g7pHGnc?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4257b5a0-8593-4020-f395-08dbdb92f565
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 11:00:43.4798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h62EP5yiX8OKAPJp7IqqOOYSTpzx0afhq+8tPrenHdHubyGwaMmTZWC5ESdm4/n5AjmsRaxA0zfHi/K03P/acSawaMKnzsQRms58jOXsvXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2832
Received-SPF: pass client-ip=40.107.122.116;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

This patch enables plugin support on windows.

qemu plugins on windows now correctly load/link the qemu_plugin_*
symbols when they are loaded[1]. This works by creating a delay-loaded
.lib file with dlltool[2], then linking the plugins against that to get
them compiled. No messing around with function pointers required.

The .lib file is created with "qemu.exe" as the name of the DLL.
The only input to the creation of the .lib file is a list of
qemu_plugin_* api symbol names.

When the DLL is being loaded, it will fail to find qemu.exe[3], but
the windows linker has a 'dll loading failed' hook you can put in the
plugin.

I've implemented this hook to check if the file that's failed to load is
'qemu.exe', and if so, substitute in a handle to the top-level
executable. Symbol linking then continues in the normal way.

As such, windows plugins work for me, and with minimal change to actual
qemu code.

[1]: Except lockstep, which uses unix sockets. It could be changed to
     use another communication mechanism, but that felt outside what I'm
     trying to achieve here.

[2]: This would be the first use of dlltool in qemu. Is that OK? do we
     need anything in meson to check it exists?

[3]: If qemu moved to a single executable model, and we got the name
     right when creating the .lib, then the dll hook would not be
     needed at all.

Limitations/things I'm worried about

* There is some amount of meson/Makefile tweaking going on here, and
  while what I've got works for me, I'm not very familiar with meson,
  and might not be doing things The Right Way.

* plugin/FFI bindings authors would have to copy this hook themselves,
  or implement something equivalent. Also they need the
  qemu_plugin_api.lib file, which I think I've added to the set of
  installed files.

* License for win32_linker.c - I'm happy to put this under whatever
  license seems most convenient. Given qemu-plugin.h is already GPL,
  all plugins will be GPL anyway.

Greg Manning (1):
  plugins: enable plugins for windows

 configure                      |  9 ++----
 contrib/plugins/Makefile       | 27 ++++++++++++++++--
 contrib/plugins/win32_linker.c | 34 +++++++++++++++++++++++
 include/qemu/qemu-plugin.h     | 50 ++++++++++++++++++++++++++++++++--
 meson.build                    |  5 ++++
 plugins/meson.build            | 17 ++++++++++++
 tests/plugin/meson.build       | 14 ++++++++--
 7 files changed, 141 insertions(+), 15 deletions(-)
 create mode 100644 contrib/plugins/win32_linker.c

--
2.42.0

--

Follow Rapita Systems on LinkedIn<https://www.linkedin.com/company/rapita-s=
ystems?utm_source=3Drs_email_sig>

