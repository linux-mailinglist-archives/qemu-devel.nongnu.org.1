Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E87377F550
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:33:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWbEa-0001j8-0e; Thu, 17 Aug 2023 07:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qWbEX-0001iR-4w
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:32:09 -0400
Received: from smtpnm6-02.21cn.com ([182.42.154.78] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qWbEU-00050K-AE
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:32:08 -0400
HMM_SOURCE_IP: 192.168.139.44:35588.1307217768
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.139.44])
 by chinatelecom.cn (HERMES) with SMTP id 8ECD81237AACE;
 Thu, 17 Aug 2023 19:23:58 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-56d86dc765-g96c8 with ESMTP id
 46fcf7d4aab64eefa376bab31fea8c4e for kraxel@redhat.com; 
 Thu, 17 Aug 2023 19:24:03 CST
X-Transaction-ID: 46fcf7d4aab64eefa376bab31fea8c4e
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
From: tugy@chinatelecom.cn
To: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,
	tugy@chinatelecom.cn,
	dengpc12@chinatelecom.cn
Subject: [PATCH 0/2] ui/vdagent: Fix two bugs about disconnect event handling
Date: Thu, 17 Aug 2023 19:23:54 +0800
Message-Id: <cover.1692268800.git.tugy@chinatelecom.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.154.78; envelope-from=tugy@chinatelecom.cn;
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

 ui/vdagent.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.27.0


