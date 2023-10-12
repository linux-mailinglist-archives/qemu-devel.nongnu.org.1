Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6F97C7116
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 17:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqxLc-0006L1-Ic; Thu, 12 Oct 2023 11:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLP-0006H9-6s
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:24 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1qqxLN-0003g2-7O
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 11:11:22 -0400
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 39CDOLxQ011099; Thu, 12 Oct 2023 08:11:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :content-transfer-encoding:content-type:mime-version; s=
 proofpoint20171006; bh=9S6jgyH7sF9VL48X2Ox3XD8ScF5jvsMp0OYD5G1x9
 eQ=; b=ai5zth2mvYoFX01pW+5MBLscS+7c3tfXM778EWUQ52Mni8QtyUcGVczh/
 2LQJqhFUB6yUv3g9veOsFJAeolMS/xDd4pg+aNI83Ph7UYSuup6XYZ5WLOt3PX2d
 fb8P0pmi201jui7jmm5aYGP1DB0ieAsFSHmXGxJo+ZAezHYkNSihmlTkRUAHKOJR
 vkr1fe8kzfg1HQMK9+fvr/PWa5b8DTpqGuUg65DT0jxWwZ+prPfTB8OkPMnVcTzw
 BJckvy0ZO2f4RqV2GWQntTwQ4YmLebboZKg12F1keeA7pUH+6m9V7jef+goTzMOt
 E4tGBYHK1haP5mV82K9xyL3fH/3JQ==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3tkhxt7uc8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 12 Oct 2023 08:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdKG++Hb1cfPh07x2uhxrkH7y3aLLSKNaxqqyryIucGZhf1heS52Tgdmymag+dfZLl1H/0gdgqtfA+u0CccFykjgdvAsAquk3lTDbsscUJbmD5Nz6nNq3L8bo76x/t0YSCQmmK5TqFabUFQn5WUduTTt8LoylTQ0rAZiU4ZfN489DoTG7Rmg4gDkGuY7X/VcwmnitghfRLQy0HqFBPVBEPKO0mASugyvCXyhYXKxukz7GRljIp1fNVRRRMMn20ouvFSmkYj5nPMNzmmP1VIJNAkNJFWOgdgClhjIVy8XFXa4GSMlHUF0Nn4LO0+fD6w94DGLKrCqshWUwPyv2DRbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S6jgyH7sF9VL48X2Ox3XD8ScF5jvsMp0OYD5G1x9eQ=;
 b=V+u9VSAJRLh2VHDbVTsFa+nyIIF1JzhjJHLZWJ/Yu3K+zrrWgpGimbx7bH97aiJsWuw6VBduYAU3phRRtxZhlQZ3KlLppHo6dYMXEIsSgx+OQJEFtEyx/6CESKontWDwD4uBsOXleRW3DK/H7dhaoFo5IVM+kbKJBpgmJ/N6haPjkdHwt5GhetvRc/XE6DWRpL9afm9PGGWqAkTtXjYtosvXEmbnUPasC5b4Vwi4aKdJNkWF+sP1mtpI6MIqeTMM+T/J8GR1MuNHw0QwYbTwzNeSwVLwWowNF5YneyzlRy2apvokGaxBvd76zHlt4LlK5gQNmRWr30VGxPOEh8594Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S6jgyH7sF9VL48X2Ox3XD8ScF5jvsMp0OYD5G1x9eQ=;
 b=MzXGy2KzTgcMbGDFeUFcplguiaxPnZa/03n2WOu2w4vKpElvqtsFX29Yxv5CGskpPiMTCILoQPS4CaD30HgXb5gmN9mb25jkqYDkVr66P5UcxIaoLw5xlGZHLQGyICTzobzVz5C5hA1CwuRkhwgLRZyvheZn99FYzQmko171xE7ceMqqBwAj16tcd0qaSkehNOGZblzAMq3+E/yMdi2H5ts6Gh9RFFzgfux9xhoiwicbG/Jgp96AqScXeGg4UCCJbhNDLtQkeXx+MNjwIivXNiMemSDRJnVvmcnbEm0OGLtjO6AkT499m1Y+u3flWMVzul0HQuN16L4fGUBbUy+1Ug==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by IA0PR02MB9510.namprd02.prod.outlook.com (2603:10b6:208:403::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:11:16 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::f13d:ea:118b:b4ae%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:11:16 +0000
From: Het Gala <het.gala@nutanix.com>
To: qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, farosas@suse.de, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com, Het Gala <het.gala@nutanix.com>
Subject: [PATCH v13 05/10] migration: convert exec backend to accept
 MigrateAddress.
Date: Thu, 12 Oct 2023 15:10:47 +0000
Message-Id: <20231012151052.154106-6-het.gala@nutanix.com>
X-Mailer: git-send-email 2.22.3
In-Reply-To: <20231012151052.154106-1-het.gala@nutanix.com>
References: <20231012151052.154106-1-het.gala@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:208:a8::17) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|IA0PR02MB9510:EE_
X-MS-Office365-Filtering-Correlation-Id: a955295c-675a-43ab-58a2-08dbcb357b51
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zSM4PBKGZV75sfl3qE+vLqskTVd6EJMRCCl02TByobnVaXglfcbHBmmyj4tazdCwpUs04CNIemmhI+qcvcLmogghT0ds2fnA7OHwodCSQ28bfNICCvAMM6/hxK5WZKM5OpFULROn+xL2tJroycTLAb5pitykEf6dbiDvm88d4K/NjNmi3Id0ofzw84Ji0u9ZlwDTCuERtUXtaYyiFG/9rBSJkZdkdDXghuq3GmKRV0hAkztKwk3SyUpHQ/CX4p/42lIhxOqyW0GVB5/Z4Wyff+aos93RSISKKfPhOaLjNrAAUNqE3SxLPCqGddrJUn3+FOuLIIEwZs9jLy7K356sHbSwM0lb+zUdhGqY0SY7b6I19EaX+RT+y3NK1/c/f+7mAhFzhhovR+XHcgtHPb2BixCK0vjxTts8K/JGXesyUPotujkKuJuvW0YWXg8WS9SNar8coLz0GCUZD8PUmcwCBZo0M5Pcy2cdafJ4W0n90MFpy3yxfkghbNzSt1bdraD6HSUfdhwNN6qr/zHoPT/g2VeA0oTmBK3SJMoznYvNCIsCv8Kn1AVLKO/wZSEWcsnLINFSV8io6n42Zjw9DsuinHsw6bJNM3lfzIlxK04AbkxmkfRABJfhlm+7UYLK31KhxRxfoLYKErEQq8zKjP7JbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6512007)(38350700002)(38100700002)(26005)(2616005)(1076003)(107886003)(478600001)(6486002)(44832011)(5660300002)(8936002)(4326008)(8676002)(86362001)(2906002)(6916009)(316002)(66476007)(36756003)(41300700001)(66556008)(66946007)(6666004)(52116002)(6506007)(83380400001)(218753002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+o6x7TYCqmBhvMusnRlOJV3rtkswbjZ6KU2vKHw4G2CDOGHnndnJVaH181G+?=
 =?us-ascii?Q?AX/AbM8QRmUhe1T5tO9jgG5HY5zhaPQ64FFufm0884o9Za6lDXH8vLjVE0W9?=
 =?us-ascii?Q?sW+/4zpmZOkM9TCz0sFt80CSipVoQBM+wtLQYSdYFVY4utR21wO+e7ANoDTF?=
 =?us-ascii?Q?vzaDaM3TjwScpHVlMb19TGiBsbzsQlQpyKeJu2fvMuUf5dfEOYbvgOB6L1Ld?=
 =?us-ascii?Q?POtLZDTsrU3uAA0exo8ssIRHgeVwLETQs9RV0IoRmh0D+mHzMrFOLnL2Z8BK?=
 =?us-ascii?Q?mzm6+kjQ82fstIAUUeC63ReImxyWh+aOq772TO4cZD7LW2DzsAT58rSA2d9N?=
 =?us-ascii?Q?wRS8afeL6kmpO3frG15bCDH6FlxHXT+XHP9xWhSEJbGTxpOo25+p3FbNoziz?=
 =?us-ascii?Q?SodTXqU2A9XFQCWQLqnSdCbO9iHDGsfSmjqOEHW/B785rzNEYG3uHd3bMs+7?=
 =?us-ascii?Q?UQKdG3dzyyZl8OBCQJ9Kmp3spSnv5LSNelY72sYIXpuKhUZ/Iy2631lA6W0Z?=
 =?us-ascii?Q?XHo6Udvi83LtYHxOdpVHcKCvcs6BWHsoxfA8GWZhWaksV1EuhZQUbxCFA9YT?=
 =?us-ascii?Q?O+7ZlSLxYB7lf2pyTg5SNnJEB0CjT0/WDMbz1iXv7XgGPJC8L5s0XbxcecmV?=
 =?us-ascii?Q?BhD37PZVDB7/MG+ULEyWd8G82ei6z0qPwK32iIRh5yv4wEgUM6PDQKzRLjwt?=
 =?us-ascii?Q?BT7hP4XHSZQp5BBrqsQGOxIB8Yv3C8n6bwpFcOIoCOPtvvd+V3Z0KF0XWRdD?=
 =?us-ascii?Q?FBhKkU1Q6hSBYdy260EbVTeO37n6RTjBQopPDfMr2vaB2sfPmmVyXru5Kp2a?=
 =?us-ascii?Q?bkSbXFjgQJYe+MsLvLisLckMLr20kX0FWPyG4c8SCG1R2M/q+WV57p0GMHTF?=
 =?us-ascii?Q?BUcZR3m/mpIYukL2QKs+eXnte6zaCXhwcQ1yibXF8HfL8wqXsHZ+086xzqLn?=
 =?us-ascii?Q?GbCWj0iF+qgWN3TsZpbre3NxmDNktheVKLdCaN036bikN5dQomp15UFmmXh9?=
 =?us-ascii?Q?GctQvWE7onMnoTt967VJHFoyVR2EwFB6lvwwUf2FR2KBr5FO74P+G4JSVTNy?=
 =?us-ascii?Q?/oj18kj5ePjCA4aw0WTFdlt+ISoe+e1oaz+L9qsMAaMso72Dbp5gwA8uu6MC?=
 =?us-ascii?Q?q3ZmfRu7+zcopDf9RVf2vSOhPzm7KO1jjfCjg3MfeNPkEPow0i5sG/q8lkpC?=
 =?us-ascii?Q?PzU/OgrO41WMpiggl1RsqkiL30u6ohogeI9CaoKoiCZYEAT93Kmek7PC/KxW?=
 =?us-ascii?Q?A1u31mLiVhZhcrWqU5HPqaU5oxoc8vvlZoEGBG2GJw/sCvroI4HBJbfWKw/B?=
 =?us-ascii?Q?VAUOSK/SmJnz4qR//ByfALUzjcXNM/3CcMy761+u4hfaT3Zc1ys3WNkv9eQR?=
 =?us-ascii?Q?oKtfJgR+WW0PNKCuqtgUnZq/jMniCEEkgqHx6Bu8kSiT4qZR+nyZMvYVKoOB?=
 =?us-ascii?Q?apVKe+aHMsqwAtvp0l1JIDLV8Qc1SJUwarT4yWZHvIUSI7dfl5kucw3n2dCq?=
 =?us-ascii?Q?brQLIe1fBqlnqjVNBO9kHCvCfieT1vCvpuGwqKLMilY2q0uzi2oj2OmxWeBt?=
 =?us-ascii?Q?pCJWnmHaq4pRTLYizv9CSac7x8vxO0wW3+V10icd?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a955295c-675a-43ab-58a2-08dbcb357b51
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:11:16.8177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe0MRBIMwYJUCojyxh7iVyRXPK383JPYgMi1WAGp3HllXTGRdyKEu6gpAVixVYYp5BPHjpMO5QGq87LZYgepFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9510
X-Proofpoint-GUID: OXr1ksd37axGWfp2UPG7kkuvoV0b3xgF
X-Proofpoint-ORIG-GUID: OXr1ksd37axGWfp2UPG7kkuvoV0b3xgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=het.gala@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Exec transport backend for 'migrate'/'migrate-incoming' QAPIs accept
new wire protocol of MigrateAddress struct.

It is achived by parsing 'uri' string and storing migration parameters
required for exec connection into strList struct.

Suggested-by: Aravind Retnakaran <aravind.retnakaran@nutanix.com>
Signed-off-by: Het Gala <het.gala@nutanix.com>
---
 migration/exec.c      | 73 +++++++++++++++++++++++++++++++------------
 migration/exec.h      |  4 +--
 migration/migration.c |  8 ++---
 3 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 32f5143dfd..47d2f3b8fb 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -39,20 +39,51 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-void exec_start_outgoing_migration(MigrationState *s, const char *command, Error **errp)
+/* provides the length of strList */
+static int
+str_list_length(strList *list)
+{
+    int len = 0;
+    strList *elem;
+
+    for (elem = list; elem != NULL; elem = elem->next) {
+        len++;
+    }
+
+    return len;
+}
+
+static void
+init_exec_array(strList *command, char **argv, Error **errp)
+{
+    int i = 0;
+    strList *lst;
+
+    for (lst = command; lst; lst = lst->next) {
+        argv[i++] = lst->value;
+    }
+
+    argv[i] = NULL;
+    return;
+}
+
+void exec_start_outgoing_migration(MigrationState *s, strList *command,
+                                   Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
 
-    trace_migration_exec_outgoing(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
+
+    trace_migration_exec_outgoing(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn(
+                            (const char * const *) g_steal_pointer(&argv),
+                            O_RDWR,
+                            errp));
     if (!ioc) {
         return;
     }
@@ -71,20 +102,22 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
     return G_SOURCE_REMOVE;
 }
 
-void exec_start_incoming_migration(const char *command, Error **errp)
+void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
 
-#ifdef WIN32
-    const char *argv[] = { exec_get_cmd_path(), "/c", command, NULL };
-#else
-    const char *argv[] = { "/bin/sh", "-c", command, NULL };
-#endif
+    int length = str_list_length(command);
+    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
+
+    init_exec_array(command, argv, errp);
+    g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
-    trace_migration_exec_incoming(command);
-    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(argv,
-                                                    O_RDWR,
-                                                    errp));
+    trace_migration_exec_incoming(new_command);
+    ioc = QIO_CHANNEL(
+        qio_channel_command_new_spawn(
+                            (const char * const *) g_steal_pointer(&argv),
+                            O_RDWR,
+                            errp));
     if (!ioc) {
         return;
     }
diff --git a/migration/exec.h b/migration/exec.h
index 736cd71028..3107f205e3 100644
--- a/migration/exec.h
+++ b/migration/exec.h
@@ -23,8 +23,8 @@
 #ifdef WIN32
 const char *exec_get_cmd_path(void);
 #endif
-void exec_start_incoming_migration(const char *host_port, Error **errp);
+void exec_start_incoming_migration(strList *host_port, Error **errp);
 
-void exec_start_outgoing_migration(MigrationState *s, const char *host_port,
+void exec_start_outgoing_migration(MigrationState *s, strList *host_port,
                                    Error **errp);
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 03b6deb45a..10b2c4f318 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -505,8 +505,8 @@ static void qemu_start_incoming_migration(const char *uri, Error **errp)
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_incoming_migration(&channel->u.rdma, errp);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_incoming_migration(p, errp);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_incoming_migration(channel->u.exec.args, errp);
     } else if (strstart(uri, "file:", &p)) {
         file_start_incoming_migration(p, errp);
     } else {
@@ -1777,8 +1777,8 @@ void qmp_migrate(const char *uri, bool has_blk, bool blk,
     } else if (channel->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
         rdma_start_outgoing_migration(s, &channel->u.rdma, &local_err);
 #endif
-    } else if (strstart(uri, "exec:", &p)) {
-        exec_start_outgoing_migration(s, p, &local_err);
+    } else if (channel->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
+        exec_start_outgoing_migration(s, channel->u.exec.args, &local_err);
     } else if (strstart(uri, "file:", &p)) {
         file_start_outgoing_migration(s, p, &local_err);
     } else {
-- 
2.22.3


