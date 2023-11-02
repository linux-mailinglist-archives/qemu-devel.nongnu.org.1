Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC627DF8A2
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:24:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybP5-0004dQ-NT; Thu, 02 Nov 2023 13:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP3-0004dE-OF
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:45 -0400
Received: from mail-lo2gbr01on0707.outbound.protection.outlook.com
 ([2a01:111:f400:fe15::707]
 helo=GBR01-LO2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1qybP1-0004ME-Co
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPp1txx61vZTeZLTSTX11YTLX3PWTZFhMg34Qf1Z0WnWDQOnCaLajVb3vUb7yVpgFZnYM4JZmm8cc1CuGXrKJ6ERnlMb3HZD7Etu05Ii00RKL9SWM25N1wSd+2wA1rAgfdwUr9AtqnWw8EZP4cScGHwQh1itVybQFZlm98WlxrjPACOi/L8hoK01TASD5Fg7fUuyqI887A2yUiOGvikqGwGAB3iNNIGEnVBBKJlHEJrr9w/TNyxiXrsTxkPed3GeHDqfaeHcbl/G70P44Fkt3vxm45erNizniK3XA8LdLqVINiiNtN+Xeyxw+vkE/zVDgVJrfrWVanwIhEzifF0Fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1W/y/ypHkIKI1hjgM1rmjBZ3ItQnsjjDX8kRgVWSYY=;
 b=bsaR286Vx+r3VBxaQLiUbGY3XvlLVt+WMyFBkHIN1vGE3iwejD9mzFygWSFOw5vG1ysxBpBH0srHFTw2GQteULKgW1Kt+eRmIenPGaZ1d8DRis1OnNNhzg98GL3b/+MZUn44OMA4g/sRJlamsidLhnMayEQNuC+jLEuT/k5E/TgN684LIfapbPA9SK0cEfo+xvTM9gIvw2Q0PVEljhWhODDPl1usz0KZSQuI1n91rLUcGVy3s8NNXoaoI+bryojdf69vSC+7k1c/kf/i/8chzF0+M1eFRuTkomvcL7Ws9gUUR3qsiETUFOdOuBBlEulnBnfYeHwqPc4IFQWO7IHzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1W/y/ypHkIKI1hjgM1rmjBZ3ItQnsjjDX8kRgVWSYY=;
 b=eKK8VrkrDNwALXB3xdX/D3DxAJPqrTiv1yVFa8TZEMKeTkZw2ruyZIL1k0QXhlGkmLqX7wEhY1okcL7MWi86KxjbYbVJ1/XgLF7zXcuVIXAJg56Uyc6o6VNJicxVionEMna+MYUX/cB9JvC/NJZzqqCZyRfvKssMj3N5wkrfGcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:19a::8)
 by CWXP123MB3365.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Thu, 2 Nov
 2023 17:22:36 +0000
Received: from LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9]) by LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 ([fe80::a33f:4559:b41e:cea9%4]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 17:22:36 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: qemu-devel@nongnu.org
Cc: luoyonggang@gmail.com, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Greg Manning <gmanning@rapitasystems.com>
Subject: [PATCH v2 1/4] plugins: add dllexport and dllimport to api funcs
Date: Thu,  2 Nov 2023 17:19:44 +0000
Message-ID: <20231102172053.17692-2-gmanning@rapitasystems.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231102172053.17692-1-gmanning@rapitasystems.com>
References: <20231102172053.17692-1-gmanning@rapitasystems.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0282.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::30) To LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:19a::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P123MB4352:EE_|CWXP123MB3365:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e9388f-820f-4aef-4d62-08dbdbc84e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: beVVGmmS5FOvd5eoi4YFrBX+DEgJ9nf+L2Rg9EDbcoVjKWx5N51nCZmdvf7kwExTG/eSa4sgyd4CEzK3Ux7NNjCqQdxPI0xE2QeuCyqIW+1PN4FJqiTs770k0gbTDito/hKfMWpEuBO0FjFkxIXUBfr5C0R4bulf6I2omkqDbM0O4WgjLDXQloeEfIO31YQATmevR366tCfzGGA2vdoqB2SNNh9H8sYLSLvFJHVgPTjICGopq82wkuL2cXrOM376p51uVwQPRlzEz6d14eEuQAI6xEb9Cr8zJebyKjDOgOhvd0xDBnQTrkD3dMxwHQNdnxEa9WIlg+HGlR26BOjtfx6etNoqeqKrHlnX0L0FwShaHirdQhtSwn7Fc4wd2sgTMTLLOUKBby8R7BPJVi8o9pibl+6SARj4VfEtK+Vq+ocyjpayGYx+rzMPqjt2vNontMXJ4qP27vQM+oMwjSuYMfFV1dVDh6na14UIgDWdAIhRerOc/X2bDrWoAy/jmBp2vJEiviktr7QwWIZMc7/9j0ZetQ67MPI2jJT00+MB0FQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39840400004)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(66556008)(54906003)(6916009)(66476007)(66946007)(316002)(6506007)(478600001)(1076003)(6666004)(107886003)(2616005)(4326008)(26005)(8936002)(83380400001)(8676002)(966005)(6486002)(6512007)(30864003)(5660300002)(36756003)(2906002)(38100700002)(66899024)(41300700001)(86362001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g+vjLU4xChNB5apGOU6i7BI02+uUoFlX2xxRxf6PbPIu+SBm2A2yW33mZSit?=
 =?us-ascii?Q?9zxHScYQ33gcP9F1PyY8wxDiWHjko+G3saTFJRqU4gEgwlWmu97VUdOhykgM?=
 =?us-ascii?Q?bShbSB5y2uvy/7r+RBQOsbQWsFKONPVkhEYuz/GIQbEIWJ4CwBG5eaVrnZSg?=
 =?us-ascii?Q?4GGTHxGqllnhsP52V7yP5siBHclGFNVyPc6oKKDbHa1tQ0D86r7GrHjkr0vz?=
 =?us-ascii?Q?1bu35EeTCebRr75cLjyJefS7aUAryhn/XdM/IIkQYS0zgCHcNSEjqwYt4y45?=
 =?us-ascii?Q?n8G0qyamBz+07h5/YwViE6I5kHiLNsc+6LgAfhZilFPPdRBCl7FJQqMPFwua?=
 =?us-ascii?Q?oqeEtyBwrVw1k0WkjWafarxWwVHJJI4obcPke19AyTjUzZ+3U2Of5ph0TdWu?=
 =?us-ascii?Q?Is2xRwLobwXMwaA42GYHNyz4eC3XAsGWdJAeTtaa7GaOsUYOPwfh6pF+igjl?=
 =?us-ascii?Q?VjehJrO0WQ8VAvky6ukBM5vaiBnw7pjFPb7zkOFl97gYgPeZyE0g5Xqdz5Mz?=
 =?us-ascii?Q?aSmxVwO/QgFF++hK35fdMdV5wnHxwBjogGdgUw3OWb6xESc5rKDoF1GmQDQV?=
 =?us-ascii?Q?e8JAcvltOGwj68Fk705/Y5R9RQBUE+hA8ZSKlMonhFJCENVP/tsmmLpIK/l6?=
 =?us-ascii?Q?lYEoj8eo89uDZtmRp9e464JtsUu1m2om3hK54rzlNqUEDvMmsHv00ooOCs1u?=
 =?us-ascii?Q?7gkzHIENeXj1MZToVFN/g0hpwSFKW5QGp5TNQJU6oWyVZCCbtlHXu+cqk3QI?=
 =?us-ascii?Q?ThCasZ50i/GNkcNZEwLGvUMMiLMiW//Ds81bmDimaVNFeBxmfvpMwTSgQ8Ar?=
 =?us-ascii?Q?VyKPefOmSpUj0hTEM2pgI7eokfcbW++MA9TSU1tI1CvY//UO5507HHIcoZbB?=
 =?us-ascii?Q?zKqTr0r/eDpTXnOGHPhi8itmbhxsGzU5cmOml+3OGO6HPgXlc1cWQrauLIH7?=
 =?us-ascii?Q?3A0NcTk7Yedg1cthIcMpDE152INIjGU9xsglbO2EccbgDotTsl2P+tEIZPzX?=
 =?us-ascii?Q?+WDrmkCOpTcmlp7LbzOWKYJ5W5MQi9/n/dzPbJFGf0T3qJWHlE0UKhxeSe0+?=
 =?us-ascii?Q?c3hvAf9rOKK0TqQwI+GDbK4u8oIHEvzrUIIJoX1898txTM1/1FCLjA+hJBtH?=
 =?us-ascii?Q?SNu8/0cwHX8vR7lcPmExXBE6hV6p11gDCuxHSEEzILIz5MuH0q+idqfQi/Xp?=
 =?us-ascii?Q?1dWjRb2lu3GyWynfAYftvtGuBG1a1NDdz4xnHUHKthx2LXy6oygR3b3LVmbd?=
 =?us-ascii?Q?iSGQRDxT4Va/45c7iBfjRYkwwiZR2GbDfe9LlRgfqeWvXn+cCiaZaMr0TPqj?=
 =?us-ascii?Q?YjrksdSAOjFLfWE0VXZ7uMCmOmDiTHHbyiICWEO3imnNMHMYK5K7/9j9mQLl?=
 =?us-ascii?Q?fxeWsfneW0iVbZNBryzlMYXoC0HS6NomVqmtHSnW1ozLzwyP6AmD66jeOk/x?=
 =?us-ascii?Q?N2UChE5BmzsI1gMy0WGxDTLVZh9YV5lDi+Ba9cqm0HGq6cBXCOZaI2FFAjw8?=
 =?us-ascii?Q?TqwOb7LH7SOEXA51uJvICeaw6Ku8gl18SGDSgynlZQh6Zatr6yXKTJZJLpA/?=
 =?us-ascii?Q?EelrHIFWU5BxbITjJjk0ebumC7eo3NsRAE8ViU2t3v/xksnIOo9JDC4yzi4D?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e9388f-820f-4aef-4d62-08dbdbc84e10
X-MS-Exchange-CrossTenant-AuthSource: LO2P123MB4352.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 17:22:36.1002 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 05UUVHX+sWjxinapp+4/qnxlDT+veqd1RjCrnpW7j2kqoEtvERjL4iotm8kBqI9yuYgqHM48qull61/rdhKWXyyyiI2P7i/MMLJT5yscblE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3365
Received-SPF: pass client-ip=2a01:111:f400:fe15::707;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO2-obe.outbound.protection.outlook.com
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

In qemu-plugin.h, mark all API functions as __declspec(dllexport) when
compiling the executables, and as __declspec(dllimport) when being used
to compile plugins against.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
---
 include/qemu/qemu-plugin.h | 50 +++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..4daab6efd2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -22,15 +22,18 @@
  *   https://gcc.gnu.org/wiki/Visibility
  */
 #if defined _WIN32 || defined __CYGWIN__
-  #ifdef BUILDING_DLL
-    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
-  #else
+  #ifdef CONFIG_PLUGIN
     #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
+    #define QEMU_PLUGIN_API __declspec(dllexport)
+  #else
+    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
+    #define QEMU_PLUGIN_API __declspec(dllimport)
   #endif
   #define QEMU_PLUGIN_LOCAL
 #else
   #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
   #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
+  #define QEMU_PLUGIN_API
 #endif
 
 /**
@@ -147,6 +150,7 @@ typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
  *
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
@@ -160,6 +164,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * Plugins are reset asynchronously, and therefore the given plugin receives
  * callbacks until @cb is called.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
@@ -171,6 +176,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  *
  * See also: qemu_plugin_register_vcpu_exit_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -183,6 +189,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -193,6 +200,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU idles.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -203,6 +211,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -253,6 +262,7 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
  * callbacks to be triggered when the block or individual instruction
  * executes.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb);
 
@@ -265,6 +275,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a translated unit executes.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
@@ -296,6 +307,7 @@ enum qemu_plugin_op {
  * Note: ops are not atomic so in multi-threaded/multi-smp situations
  * you will get inexact results.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
@@ -309,6 +321,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
  *
  * The @cb function is called every time an instruction is executed
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
@@ -324,6 +337,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
  * Insert an inline op to every time an instruction executes. Useful
  * if you just want to increment a single counter somewhere in memory.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
@@ -334,6 +348,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
  *
  * Returns: number of instructions in this block
  */
+QEMU_PLUGIN_API
 size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
 
 /**
@@ -342,6 +357,7 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
  *
  * Returns: virtual address of block start
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
 
 /**
@@ -355,6 +371,7 @@ uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
  *
  * Returns: opaque handle to instruction
  */
+QEMU_PLUGIN_API
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
 
@@ -368,6 +385,7 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
  * Returns: pointer to a stream of bytes containing the value of this
  * instructions opcode.
  */
+QEMU_PLUGIN_API
 const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
 
 /**
@@ -376,6 +394,7 @@ const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
  *
  * Returns: size of instruction in bytes
  */
+QEMU_PLUGIN_API
 size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
 
 /**
@@ -384,6 +403,7 @@ size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
  *
  * Returns: virtual address of instruction
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
 
 /**
@@ -392,6 +412,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
  *
  * Returns: hardware (physical) target address of instruction
  */
+QEMU_PLUGIN_API
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
 
 /**
@@ -410,6 +431,7 @@ struct qemu_plugin_hwaddr;
  *
  * Returns: size of access in ^2 (0=byte, 1=16bit, 2=32bit etc...)
  */
+QEMU_PLUGIN_API
 unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_sign_extended() - was the access sign extended
@@ -417,6 +439,7 @@ unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_big_endian() - was the access big endian
@@ -424,6 +447,7 @@ bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_store() - was the access a store
@@ -431,6 +455,7 @@ bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
 /**
@@ -446,6 +471,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
  * information about the handle should be recovered before the
  * callback returns.
  */
+QEMU_PLUGIN_API
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr);
 
@@ -462,6 +488,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
  * Returns true if the handle's memory operation is to memory-mapped IO, or
  * false if it is to RAM
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
 
 /**
@@ -473,12 +500,14 @@ bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
  * Note that the returned physical address may not be unique if you are dealing
  * with multiple address spaces.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr);
 
 /*
  * Returns a string representing the device. The string is valid for
  * the lifetime of the plugin.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
 
 /**
@@ -513,6 +542,7 @@ typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int vcpu_index,
  * callback so the plugin is responsible for ensuring it doesn't get
  * confused by making appropriate use of locking if required.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
@@ -531,6 +561,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
  * instruction. This provides for a lightweight but not thread-safe
  * way of counting the number of operations done.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
@@ -544,6 +575,7 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
 
@@ -551,6 +583,7 @@ typedef void
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
                                      int64_t num, int64_t ret);
 
+QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
@@ -563,6 +596,7 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
  * Returns an allocated string containing the disassembly
  */
 
+QEMU_PLUGIN_API
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
 
 /**
@@ -572,6 +606,7 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
  * Return a static string referring to the symbol. This is dependent
  * on the binary QEMU is running having provided a symbol table.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
 
 /**
@@ -583,9 +618,11 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb);
 
+QEMU_PLUGIN_API
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb);
 
@@ -602,6 +639,7 @@ void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
  * In user-mode it is possible a few un-instrumented instructions from
  * child threads may run before the host kernel reaps the threads.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
@@ -615,6 +653,7 @@ int qemu_plugin_n_max_vcpus(void);
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
  */
+QEMU_PLUGIN_API
 void qemu_plugin_outs(const char *string);
 
 /**
@@ -628,6 +667,7 @@ void qemu_plugin_outs(const char *string);
  * returns true if the combination @name=@val parses correctly to a boolean
  * argument, and false otherwise
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);
 
 /**
@@ -638,6 +678,7 @@ bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);
  * return NULL. The user should g_free() the string once no longer
  * needed.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_path_to_binary(void);
 
 /**
@@ -646,6 +687,7 @@ const char *qemu_plugin_path_to_binary(void);
  * Returns the nominal start address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_start_code(void);
 
 /**
@@ -654,6 +696,7 @@ uint64_t qemu_plugin_start_code(void);
  * Returns the nominal end address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_end_code(void);
 
 /**
@@ -662,6 +705,7 @@ uint64_t qemu_plugin_end_code(void);
  * Returns the nominal entry address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_entry_code(void);
 
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.42.0


