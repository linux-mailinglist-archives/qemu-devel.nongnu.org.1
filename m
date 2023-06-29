Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3117426E0
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 15:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qErHd-0004mR-OH; Thu, 29 Jun 2023 09:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rma.ma@jaguarmicro.com>)
 id 1qEldS-0005Nx-6w
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:00:10 -0400
Received: from mail-tyzapc01on2055.outbound.protection.outlook.com
 ([40.107.117.55] helo=APC01-TYZ-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rma.ma@jaguarmicro.com>)
 id 1qEldN-000099-Tl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:00:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsAfCX1TCoP6BlMIo6LM3V8lkVk9H1PIwd+PUcdps9fEkG41/hWHFGBXCwgY8QXMfNbh+u8FNYFeTfnZ3Axa4lw0BwF6XMnOC5aHDHXlAjS+egFpCXkM4RViGJ/tztTmZHaNq0R0Xwy15SwWBKfSAyA+D+NEqi8Ynxwvahz5+ZLKnNklI3IqbuYdPsD+dGOPczQHJ2A/BlkX793jEw5YOtiqZO3mq/a2oOISWonn78xz0JXOOvUS2DeuGiRic1Es+Jr0YpcZvKLfzOlWr+WcG6VpQcIdZ0Va1mncsBt/wjBN8h79fdZ3unrevEBgNRKWSfzSKqP6E+RfY/Vg2l4GLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWh+04QVFHsibNmGGJzY9lNvad0hSlEXveaYdLU7Lwk=;
 b=N9iBYfPKoFHNEKeDjYXRzTGGZxk02rIChjxzQ3XR7UXVVOuduHXW3nLfv78ThWSgkBbeaBplk1YGjDZkBsPhtXzTGiDENlu2GLVvvN1iiItISOFDq4PRbY6WHgmQe4QDLkbximc+jp7Q7Vf2aS/Eg83RrrDZ+mZO3ONAMdHmLPJIJiF7Paie5S692ACWgPxlmKIwROwnRf2LoMWwnzmc+4RedST5sXfbmdS3gopCMy5RbtODAvH3L2ejA+4G7qxoEgRU9cJL9c0he6C6Q4YWp3B+rsSh5HDuvmlJ99RYjrZLdsgc+VV1tsvmAuR8VcSNZzJrJC3W9vVt2vXQNuMvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWh+04QVFHsibNmGGJzY9lNvad0hSlEXveaYdLU7Lwk=;
 b=aay5AvuoTcD8hEeL45av4yD1dUOjWxgi1/+waFD2NEP7Hs4dtcsgACD+xJtyQ1pAKdaG6TKnombULq0cyqNFt2+KQXU95Yd5q5o3rP2nquanjdhGJF3FK3UbKzafgPPFCvuLGn4g0GMK3G2jf60sTvxcOyiWzvni6oXy2iXuYsPjvNOz6tPuXu4XGvkwbH2Lf+wdoIcsbTtvXuAXgibOmJjMYCszVRGKKIf5VurP9s4OHUReLBXrLgpX2ouUG/HrjSnqnJNFMMRbaHuhMgaXMxAjViKSMPtqQlmX/T+MJ1L25eEqV8tQVhe0hBsx/G9lPpgiUBQXh/mA+SCJwmb/ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4752.apcprd06.prod.outlook.com (2603:1096:4:14c::14)
 by TYUPR06MB6269.apcprd06.prod.outlook.com (2603:1096:400:351::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 29 Jun
 2023 06:54:57 +0000
Received: from SI2PR06MB4752.apcprd06.prod.outlook.com
 ([fe80::25f2:1ee4:9de:7b00]) by SI2PR06MB4752.apcprd06.prod.outlook.com
 ([fe80::25f2:1ee4:9de:7b00%3]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 06:54:56 +0000
From: Rma Ma <rma.ma@jaguarmicro.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Rma Ma <rma.ma@jaguarmicro.com>
Subject: [PATCH] vhost-user: use new thread to loop backend channel.
Date: Thu, 29 Jun 2023 14:54:15 +0800
Message-Id: <20230629065415.8211-1-rma.ma@jaguarmicro.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To KL1PR0601MB4753.apcprd06.prod.outlook.com
 (2603:1096:820:92::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4752:EE_|TYUPR06MB6269:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cfd355-dc8a-4241-c6be-08db786dbf34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r1dcAKcC/7Tjq1CQPwGqUYj4fcYU/bHOMYmjfXq52Wb7n9E4CLgXRdZJRD2y/Xq4FyjGg+eQr6/6jtMHKwXdh2jXCJvnvcTVqfqr3eZ75TJzPEfAjLwlRgutrjNJYkRIDRbeA1IR8M7RDcxncTLAblXNy2UYP+3vHaxjPU9jjYBFoSKIWrq10pVDzP9xwOAr5BAjWYSV6Z4NFnfepJtvD9uSug1F5FovypKii1hm5sLTb953Ff6RwHL5TriK+DJbtdt4L/xQ20EsSKdB8qESAj5li8xxPaCiMhx1CwzHkAOwXPKm8oze041Qb94im5D5N4iIvvrgfFqUXpGb+mZ0HdPr/dDhrazDVec7geqIkNzkiOxWj/V26chdTtajJqsGS6kQbALgTQQHlX76BJBEtUMZCCQM2pT+Yk6Dlc1I3YraHkytz47MHRvZXLvxOAQFNo2Hvv/EHdHLEOO49s5OEJzIMr+0aUxM86bNBpiulKoYmBIEdcwtpo46k7+moiy2wJ929TBXggGub9wqaodvBkQHKg4qZvTZWznkzkO7694aY0JCSI6fM8SWK+WhLC/i7p7a3FoYp9QeTWy1KjHewJuh4fwfq/UqnCym2MRgzE+BtU1uW8L3RTqJF7zg2kfb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4752.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(136003)(396003)(39830400003)(376002)(346002)(451199021)(6512007)(26005)(36756003)(66946007)(44832011)(41300700001)(86362001)(6916009)(38350700002)(66556008)(4326008)(8676002)(8936002)(66476007)(38100700002)(316002)(107886003)(6506007)(5660300002)(6486002)(2906002)(186003)(6666004)(83380400001)(54906003)(1076003)(478600001)(2616005)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6M1nS2+WeFAqDs2u6aXlAtVbQ7+Yr9zOknoKrEyAgKlbT6hRTsKVlvglQLk7?=
 =?us-ascii?Q?nitGU/wo9RD2i7PgMo0yqDIuL2kPYiE/n639EDwU/x5icImJP+NKVd0x3V5q?=
 =?us-ascii?Q?ntHXtbP73FrJETk7XeLgy2+Q16hZNdCFqbx7uHWuBPdW7cxDIURSRTox+V+Y?=
 =?us-ascii?Q?3//sSjPIm8nWGQIlBud9r16RwEtZzM9h9d2CdC8yVut21mghfSk80KMSHhfx?=
 =?us-ascii?Q?WdgofkMO6zs9tc7oZ8W2b7hVr43Xxsuc7e5c4q+sJxkFHKSYJbjU9VkKyDgG?=
 =?us-ascii?Q?7nWTLGBZjLkk5uJt3jr8RLAKq5gspdrooSJVuKsG7re9RGFbzN2tXp9Eq0hK?=
 =?us-ascii?Q?z+n+tR6eYdjenqyhNcvlmVq4Uc1X8JlKdpV57fOEvRCqBQfhw7aESd1fwGIr?=
 =?us-ascii?Q?ifLPFmifx7JSS/2Ml/mm+0U9Be7WPPhO9k9JVreTdqN6oUveMB5fMH8lJj2z?=
 =?us-ascii?Q?OmEOj5J1V1O9PoIzW8MfbBXuUJtEMeRPZoztxFHOxoLiYvk9Zdh9fB6Pt5r2?=
 =?us-ascii?Q?RU4RhJ92rt5rlPVKGnLJZVZfNpskyEAdVWtxOtf6lRNMCX9bdk60Yn6ViLdg?=
 =?us-ascii?Q?IJEJqRW9sEHnSHgqBCo8r24Cdk1EmwIYRx7P7arQGXp0qZA/Yy+trGO0OQgm?=
 =?us-ascii?Q?rIcOild7QGCQDDZcuX18SOm0WEhkRXCfak3P4DKLNbepFPM0pVwHOQM/cFnv?=
 =?us-ascii?Q?rCn55naH9L6PwLe6V0pa70w79La9XMTUr6WzLJ8FWpdzitxNpx8Y1yDEIMtH?=
 =?us-ascii?Q?BiyzttCCUxXCCYmIWKA0rCRoeT02iTKNFcry5QNOBUZKLDyTn3l7c1VNpkC1?=
 =?us-ascii?Q?hH00wTp2L/9E33C+Auk+SgegpgUZ16AnfDEtS6rIBwUPUKxga2hSfxNoaOuo?=
 =?us-ascii?Q?Dm/11DVzoOXGPP7u6jRr9ynM2vvaak7p73dauNygqgDNZJWLD+bRYjhcWuAx?=
 =?us-ascii?Q?KZCPy/lp0pfsCmGtDh3/HCGbZz8UyKOIwnNrruog6MJn5zoVIVFnHEc3rKK8?=
 =?us-ascii?Q?qNpmg9BFO0G7obvmwJE1NgtRozFJWozXzZznuWO0UuP5GdhP6EpfKrDAdWYm?=
 =?us-ascii?Q?Wep2a1ICBlt38uDXa00jV0AAcZPoWd8DwlgYouTDJHafzdGVRtnMdr/zRUb9?=
 =?us-ascii?Q?T6MI5vg0YEFljp+9mRxXJ3B+bwtuWPof9qgi+WUqAetrwZJTH7wfL1ktynf3?=
 =?us-ascii?Q?dcxhSEsmfEa3UxnyKy0BmFbi5oQW292YV5eCSjWOQ3f1evkZqFUgmwvtHvNt?=
 =?us-ascii?Q?eLMN8BXGSzLt46NMYkb8QiDARziiG+85hpZNtfNxw/LlGyiDi3OAiEhlqRGY?=
 =?us-ascii?Q?/ElVMVrLDhAH179RajFsy1lGLLNmjZOAvwWQ7z6MoRqbs/P7CSDXM6k7E2rk?=
 =?us-ascii?Q?h3R3eI6CXFdRbubLf0d9UXdKpSWqAthj0MH9mSJqtKJaOI1z/5JhcqEZWbv+?=
 =?us-ascii?Q?I2hKdBL1ay7Ft8XIvGrQ72YlCsWlMDLytj/rwVEXqsfM6pN4LCCMhYbOtl4a?=
 =?us-ascii?Q?DXL9a056TmLaiwMVF/Z2PrgRvekagFf5zbsqlpCnQKfszsXJ3kp29tzMETFb?=
 =?us-ascii?Q?ZMgtYsbDWQJ3rnFY+3RkOoxS+SekSuS9CXImpkYG?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cfd355-dc8a-4241-c6be-08db786dbf34
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4753.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 06:54:56.6764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4KgH8r1IM+7CJrZRNLAmCm4TPIB2ttJx2yf6hQ31kKBPi90MyoNJuJvLhFEj9J2cUz/Voym6nf/TnULzWG5ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6269
Received-SPF: pass client-ip=40.107.117.55;
 envelope-from=rma.ma@jaguarmicro.com;
 helo=APC01-TYZ-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Jun 2023 09:01:55 -0400
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

fix: QEMU deadlock with dpdk-vdpa

QEMU start vhost-user with modern net and blk, backend use dpdk-vdpa process,
after live migration, dest QEMU deadlock with dpdk-vdpa

- QEMU sends VHOST_USER_SET_VRING_KICK to dpdk-vdpa net
- QEMU does not need to wait for a response to this message
- QEMU then sends VHOST_USER_SET_MEM_TABLE to dpdk-vdpa blk
- QEMU needs to wait reply in this message
- when dpdk-vdpa recv VHOST_USER_SET_VRING_KICK, it will send VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG to QEMU
- dpdk-vdpa needs to wait for a response to this message
- since QEMU vhost_user_read and backend channel are synchronous in the same thread
- QEMU will deadlock with dpdk-vdpa

Signed-off-by: Rma Ma <rma.ma@jaguarmicro.com>
---
 hw/virtio/vhost-user.c | 67 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c 
index c4e0cbd702..1f6b3a5a63 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -274,6 +274,17 @@ struct scrub_regions {
     int fd_idx;
 };
 
+struct backend_thread {
+    QemuThread thread;
+    QemuSemaphore init_done_sem;
+    int thread_id;
+    GMainContext *ctxt;
+    GMainLoop *loop;
+};
+
+static struct backend_thread *backend_th;
+static bool backend_thread_run;
+
 static bool ioeventfd_enabled(void)
 {
     return !kvm_enabled() || kvm_eventfds_enabled();
@@ -1696,7 +1707,8 @@ fdcleanup:
     return rc;
 }
 
-static int vhost_setup_backend_channel(struct vhost_dev *dev)
+static int vhost_setup_backend_channel(struct vhost_dev *dev,
+                                       GMainContext *ctxt)
 {
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_BACKEND_REQ_FD,
@@ -1728,7 +1740,7 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
     u->backend_ioc = ioc;
     u->backend_src = qio_channel_add_watch_source(u->backend_ioc,
                                                 G_IO_IN | G_IO_HUP,
-                                                backend_read, dev, NULL, NULL);
+                                                backend_read, dev, NULL, ctxt);
 
     if (reply_supported) {
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
@@ -1981,6 +1993,42 @@ static int vhost_user_postcopy_notifier(NotifierWithReturn *notifier,
     return 0;
 }
 
+static void *vhost_backend_channel_worker(void *opaque)
+{
+    struct backend_thread *backend_th = opaque;
+
+    rcu_register_thread();
+
+    backend_th->ctxt = g_main_context_new();
+    backend_th->loop = g_main_loop_new(backend_th->ctxt, false);
+    backend_th->thread_id = qemu_get_thread_id();
+
+    qemu_sem_post(&backend_th->init_done_sem);
+
+    g_main_loop_run(backend_th->loop);
+
+    g_main_loop_unref(backend_th->loop);
+    g_main_context_unref(backend_th->ctxt);
+    g_free(backend_th);
+    rcu_unregister_thread();
+    return NULL;
+}
+
+static void vhost_backend_thread_init(void)
+{
+    backend_th = g_malloc0(sizeof(struct backend_thread));
+    backend_th->thread_id = -1;
+    qemu_sem_init(&backend_th->init_done_sem, 0);
+
+    qemu_thread_create(&backend_th->thread, "backend-channel-worker",
+                       vhost_backend_channel_worker, backend_th,
+                       QEMU_THREAD_DETACHED);
+
+    while (backend_th->thread_id == -1) {
+        qemu_sem_wait(&backend_th->init_done_sem);
+    }
+}
+
 static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
                                    Error **errp)
 {
@@ -2108,10 +2156,17 @@ static int vhost_user_backend_init(struct vhost_dev *dev, void *opaque,
     }
 
     if (dev->vq_index == 0) {
-        err = vhost_setup_backend_channel(dev);
-        if (err < 0) {
-            error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
-            return -EPROTO;
+        if (!backend_thread_run) {
+            vhost_backend_thread_init();
+            backend_thread_run = true;
+        }
+
+        if (backend_thread_run && backend_th) {
+            err = vhost_setup_backend_channel(dev, backend_th->ctxt);
+            if (err < 0) {
+                error_setg_errno(errp, EPROTO, "vhost_backend_init failed");
+                return -EPROTO;
+            }
         }
     }
 
-- 
2.17.1


