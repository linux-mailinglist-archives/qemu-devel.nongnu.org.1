Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 042387D9057
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHZa-0007wf-EW; Fri, 27 Oct 2023 03:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYo-0007En-Af; Fri, 27 Oct 2023 03:47:22 -0400
Received: from mail-db5eur02on20728.outbound.protection.outlook.com
 ([2a01:111:f400:fe12::728]
 helo=EUR02-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1qwHYi-00041O-Pc; Fri, 27 Oct 2023 03:47:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCKsbWgXmvjjB1u2vzDUr0hdIc4nZPHwfgeQkO+0HxeR4yj18VUPcMJmI0rCYGB9WnI2W3LNA6H2rRLvWi/wcbQGFE++FnNrjuxHJBSoT967mO3R9VLqS+tNAGluXny+qpMXktRcuJffUEBdXKf39w/TlWer0gNvTf17Ninfl4BSqGECcfUHIAdcfLxlGOIY0Ri2iULhvl71Pq1CKK8FRVcHbUYdANjxtVbsLR4F0CHRHM5JVTR9G2yG2B4wK24vqobG19Lbx74/s7hAykNKsYKBNz/O0jH2F8tHOylVlUbgAASRF4976Qfpqlwhkd3nO4bqpNgy1Je7G+XvJK+s5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQY3VTqKbLWc1ugDai63v18GJcmUxZY7ZT4nVkMImmo=;
 b=BZyZf564U6jk0d5Jjf5a1N3iOfzy2JCI8x4zXWSheUnayPD6mkikNTlPVf2ODqHSDxe6NCqWVkR8bUfIHt6/KHd6F/rQ6haWEfXkT6w3dgnJLwCN9xl7F1TKjrRjx5ThQWlcsf3UIgnVuWCCmEaypfgtgwJ9OCYpsQ74EKb1sVDk/DhhZ44xyoQ7K0TAM8CxEo486Il+yeA1876gdUblux5AjOL7E/mRWoNKiRc5wjqESee9YQwncfgeQ2b12WCEpSVAj9YDEH/FJZXP4KZko6Yy+Jh77e4VwzZ3QywW2/iuFQFWbtqUQV3N8I5gd++aHsbTl7Doomr+62M7ERPtkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQY3VTqKbLWc1ugDai63v18GJcmUxZY7ZT4nVkMImmo=;
 b=pBmsMTcwZL51/g3f3RFf9DNMAF55r3jy6c7ocxBLvtvdTgRY3U3Ds/uPi7kpb6xbGr6K9j/PcFaCPxqJRrog6vTcw/mbdaBMRO6Ae1R75qHoZVu03c5ePGLZE5UBanyZH6eZd7HBqWO/ikfLq4ffqSIwSx5+TmHbFDYs0V+fmwgUVi7j6BT4LVXYJD4ZaN+4KP5aMm4RGvVFeZc+qAIsJDW8RdYT60XSYUf0h/RwqxLSZdTU2xEYXzM/QvYkMZNf7BlJXW0PEypDAvIl0KBoAF20/O3NwQvI1yAWk7i8M703AuuX+xbvvS9liy8FDzYiPC9RGAEy2pdApYfRyFX5eg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by GVXPR08MB10715.eurprd08.prod.outlook.com
 (2603:10a6:150:157::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 07:46:54 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::22f7:6498:de53:5371%4]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 07:46:54 +0000
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com, hreitz@redhat.com
Subject: [PATCH v3 21/21] tests: Add parallels format support to image-fleecing
Date: Fri, 27 Oct 2023 09:46:36 +0200
Message-Id: <20231027074636.430139-22-alexander.ivanov@virtuozzo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
References: <20231027074636.430139-1-alexander.ivanov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0101.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::30) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|GVXPR08MB10715:EE_
X-MS-Office365-Filtering-Correlation-Id: edfbee38-22b6-4273-ac7a-08dbd6c0e166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvmtKsBTdt+iw4KvQDRXWKaD2pXEf26PquvrePTH/PQJrA3mRPdaLNMawiiHkjQyJ+2f6eqgUTdN2nmv+ZvE4nGfGzLnQya5zOKlgqg4ZTvcjMCEZJgbs3w7tgLEC7A1muBdG6fxkcDknugm1TBhTnwVZuKTKoN91pcZk2nzuNdrMIzh7sNT0zJURFcMDvjs8yZClU7Vj+74s20gljBNGwNDwCkj5ejZmYvEmqOUT+rcMI1BwGb0stk91SM7RAn5BQpyyZwzygC9jXVcZeq8EsnXdYqZF0QLO85EByXCY93lGYe0f4GHYnmrnwyR22Jfxd3HmV4Qo9tPhORXp1OPZ/zK+kg3QY15ZJjFqaW59Ib4j+kg+/zkMNcBDOKmHaVZq6DwFjEHk8EnPBDVwrQTDXqKbdqcOkkQz1XcEEBUFc+8rZscGUxXljLX0E02teasYsMzpIOT4emKlaQ9uLw7vMF95UPmGmzZwXEVxBI3ENDNcIXJHc9rNL1qdGCP3I4XND0HKVLIJ7aDAfvgm9qzHvDy/aSYKCf8geYh99EtqIddUyE15XJ7Ku2RjZERGrDvfN0mxfcNufS3YM/MYCm2bYKbkFbQlEuvyJrpw5Ii+DzEAK8wJnOIG+nzLEteh4bx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(366004)(396003)(376002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(8676002)(4326008)(8936002)(83380400001)(26005)(38350700005)(5660300002)(38100700002)(86362001)(36756003)(2906002)(44832011)(41300700001)(6512007)(52116002)(478600001)(6486002)(6506007)(6666004)(66476007)(2616005)(66556008)(66946007)(6916009)(1076003)(316002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LfqLkrciTZnb2tu+cF8qjazJrfGJvu9vpEYQVJ0wkUmK2AWWgejaFaGXgUu9?=
 =?us-ascii?Q?2RQLKKeHPE61coevI+m7pa25GEYqI8b2z6qvqRxwwsRJKoO5m/z9sdA/nhLq?=
 =?us-ascii?Q?MdOve6gF/c+N7e+sRy7UUDeAt5KzRWnGbqjB/eNszqDIM4Nb5/B3503/1hoc?=
 =?us-ascii?Q?OD6XAHUoNM2422oUd8nmVejXMLVL3x6ZWTIeQvOtcxGrpXXeTp/M9ur50HoD?=
 =?us-ascii?Q?mjmINJQqvdAc0w9rYVG8kaeRlJuos+rM1R7SM5JHJdRlkPrkzlaymxChT/d5?=
 =?us-ascii?Q?zCk/4IWoKLpA4pFCXSt1yVmEb9P1wBDMdgac9Mx8ewXtmpTGme4/AX9bFNgN?=
 =?us-ascii?Q?c2/gb9Y6dpCOc+hYj1SNAH9A5GWhzaK4wEe+8NLSlgJws28pBWQKrs64bYWD?=
 =?us-ascii?Q?/SclXt1mYXvSP22iGl7kSQSeoLM4R40+Af1j1dPMuK1cOHhPREBJLcCFaZ4e?=
 =?us-ascii?Q?OB0g9Xc7Zgh6dPJ/GHCHW8XqNOv6PZqDc/iVaL02At+eKlKGDfzfeduG/Jk3?=
 =?us-ascii?Q?3JFtEP+TaaMTWzyVN2kOSEiPZ/vXVIHV34Fo49NBA/NNJWM3YmrYakntcsl9?=
 =?us-ascii?Q?nokjVqOiVJ8DpOBnJY67XlDCceHPQm2p4M3qgQQUFNS7t+lFkH+RHUpgEnnu?=
 =?us-ascii?Q?n0N6dSkYd8KUmlYXJwvH9hcNeVSw+Cqzp0QVlKpFfduQlFHOgkOqv5fxSaHv?=
 =?us-ascii?Q?K4Z7dfazZwmapQ1DQ33Z94414d/M1feetrItPGAS/6yZjsplZ+iIMCUTvaUU?=
 =?us-ascii?Q?J/MWDB1re9uk/8YC9KqUJaYjeW36CPApBeyCoDmt+5KJafYvQDx9IR0yw4zQ?=
 =?us-ascii?Q?kPWQmGyoi9h8Rp4ZSG7gZqJzNi5cJZ6J4/8lJy8jawK3S5IzRjRz2PKUgnYY?=
 =?us-ascii?Q?KrHJxpaycR6vSLAiyPi+TWij122nbz5RKF23/2F8tBF9Z10yvcxsSPhKjGnq?=
 =?us-ascii?Q?HuYoyyj4wFE/GORrdhY3BEmlIvCPjrMXdc0lQD4TcE0MLQD5KHOQCce8Ll4I?=
 =?us-ascii?Q?zwqGCkeNiRNRjrNKS+2hQUn7TDgIv2mxNdYqG8ndqWa1nHvLZIpa2+vT2jln?=
 =?us-ascii?Q?2cTJuVXGjAls7pe9M7/f6Bs6Bk2K7uOiYkN2XCuIejCi+FQgHwVgIfwLXiLy?=
 =?us-ascii?Q?r7RODAwRdv49fxZBc6nZv27Mb4Dx/Xm+eUGZlBxsyBDvzzM/Dd/WrBQTOf2R?=
 =?us-ascii?Q?85zeL5oAih6W/jFhLHaXjpHoU/Skx+C6uJAe6+ClWmGqNormSe/EuuO817L/?=
 =?us-ascii?Q?1KWZe7oSdiPlaT+xwTiW4drHmxbYmBmS466CccrOq/VdVtuO3bsykZsQENCd?=
 =?us-ascii?Q?3rDNtMr9WrE72qrODo+gkAcuCD//XXg86+IzKV702Qap+x/LsOO3qHrRRukC?=
 =?us-ascii?Q?Me5cGgzzX1e5vS2/KqSkD785AEUPK8r/3cU92zbOt/V3q8ii/2JYfGqu8XtJ?=
 =?us-ascii?Q?PwuX01fgrrx6biYBGipqUKywJdJkg17s7ML7NPkHpIBaifq8RDgWMjXjSbD7?=
 =?us-ascii?Q?ZqDvnJvVsxRJXAVXyFJ1Xjpt+pTf1XhMqekHVdoqRZyl+wASWBTDjGl2eOwm?=
 =?us-ascii?Q?kXEeLYK3Y9TvycEfvByeBg+aab22yxYdmQb/WkTuKf7Ub1bGI/iJ5C9m+62d?=
 =?us-ascii?Q?D7X90D8dyIiUOvQ9Btq2owA=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfbee38-22b6-4273-ac7a-08dbd6c0e166
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 07:46:50.8037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHNgg1BqnNIZYfN7XMDgXolhnZVznP/M+jUpFF+HPeU34E/GwCYBHVJTGaE4op4ciYjms0u4KXniBDpB6TmXqix/xXyC++Lc34gP8nOXSMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10715
Received-SPF: pass client-ip=2a01:111:f400:fe12::728;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR02-DB5-obe.outbound.protection.outlook.com
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

Use a different bitmap name for parallels images because their has own ID
format, and can't contain an arbitrary string.

Replace hardcoded 'qcow2' format to iotests.imgfmt.

Add 'parallels' to supported formats.

Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
---
 tests/qemu-iotests/tests/image-fleecing | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/tests/image-fleecing b/tests/qemu-iotests/tests/image-fleecing
index 5e3b2c7e46..dd940b7203 100755
--- a/tests/qemu-iotests/tests/image-fleecing
+++ b/tests/qemu-iotests/tests/image-fleecing
@@ -28,7 +28,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io
 
 iotests.script_initialize(
-    supported_fmts=['qcow2'],
+    supported_fmts=['qcow2', 'parallels'],
     supported_platforms=['linux'],
     required_fmts=['copy-before-write'],
     unsupported_imgopts=['compat']
@@ -61,12 +61,17 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
     if push_backup:
         assert use_cbw
 
+    if iotests.imgfmt == 'parallels':
+        bitmap_name = '00000000-0000-0000-0000-000000000000'
+    else:
+        bitmap_name = 'bitmap0'
+
     log('--- Setting up images ---')
     log('')
 
     qemu_img('create', '-f', iotests.imgfmt, base_img_path, '64M')
     if bitmap:
-        qemu_img('bitmap', '--add', base_img_path, 'bitmap0')
+        qemu_img('bitmap', '--add', base_img_path, bitmap_name)
 
     if use_snapshot_access_filter:
         assert use_cbw
@@ -75,7 +80,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         qemu_img('create', '-f', 'qcow2', fleece_img_path, '64M')
 
     if push_backup:
-        qemu_img('create', '-f', 'qcow2', target_img_path, '64M')
+        qemu_img('create', '-f', iotests.imgfmt, target_img_path, '64M')
 
     for p in patterns:
         qemu_io('-f', iotests.imgfmt,
@@ -130,7 +135,7 @@ def do_test(vm, use_cbw, use_snapshot_access_filter, base_img_path,
         }
 
         if bitmap:
-            fl_cbw['bitmap'] = {'node': src_node, 'name': 'bitmap0'}
+            fl_cbw['bitmap'] = {'node': src_node, 'name': bitmap_name}
 
         log(vm.qmp('blockdev-add', fl_cbw))
 
-- 
2.34.1


