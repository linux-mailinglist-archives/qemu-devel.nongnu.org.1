Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC9B77F8C5
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 16:23:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWdtg-0003tT-Hv; Thu, 17 Aug 2023 10:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWdtd-0003sn-7f
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:22:45 -0400
Received: from smtpnm6-06.21cn.com ([182.42.144.170] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWdta-0004kA-Kx
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 10:22:44 -0400
HMM_SOURCE_IP: 192.168.138.117:19873.1524632281
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-182.148.58.152 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id 880E5E821B;
 Thu, 17 Aug 2023 22:13:56 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([182.148.58.152])
 by gateway-ssl-dep-56d86dc765-7s8sf with ESMTP id
 f048de2fb7d744e08057fe9528ef4190 for kraxel@redhat.com; 
 Thu, 17 Aug 2023 22:13:58 CST
X-Transaction-ID: f048de2fb7d744e08057fe9528ef4190
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 182.148.58.152
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn,
	dengpc12@chinatelecom.cn
Subject: [PATCH v1 0/2] ui/vdagent: Fix two bugs about disconnect event
 handling
Date: Thu, 17 Aug 2023 22:12:51 +0800
Message-Id: <cover.1692281173.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.144.170; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

From: Guoyi Tu <tugy@chinatelecom.cn>

and resource leak

Guoyi Tu (2):
  ui/vdagent: call vdagent_disconnect() when agent connection is lost
  ui/vdagent: Unregister input handler of mouse during finalization

 ui/vdagent.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.27.0


