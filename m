Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C7F7C7B91
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 04:23:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr7oA-0001Vq-8D; Thu, 12 Oct 2023 22:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1qr7o6-0001VO-Pw
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 22:21:42 -0400
Received: from mx2.zhaoxin.com ([203.110.167.99])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1qr7o3-0006EM-TE
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 22:21:42 -0400
X-ASG-Debug-ID: 1697163673-1eb14e7511561a0001-jgbH7p
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by
 mx2.zhaoxin.com with ESMTP id JNyiZCaVetOnJnL2 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 13 Oct 2023 10:21:13 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:21:12 +0800
Received: from ewan-server.zhaoxin.com (10.28.66.55) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:21:11 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
From: EwanHai <ewanhai-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <ewanhai-oc@zhaoxin.com>
CC: <kvm@vger.kernel.org>, <mtosatti@redhat.com>, <pbonzini@redhat.com>,
 <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>, <qemu-devel@nongnu.org>
Subject: [PATCH] target/i386/kvm: Refine VMX controls setting for backward 
Date: Thu, 12 Oct 2023 22:21:11 -0400
X-ASG-Orig-Subj: [PATCH] target/i386/kvm: Refine VMX controls setting for
 backward 
Message-ID: <20231013022111.224467-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925071453.14908-1-ewanhai-oc@zhaoxin.com>
References: <20230925071453.14908-1-ewanhai-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.66.55]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1697163673
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 775
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No,
 SCORE=-1.52 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=BSF_SC0_SA_TO_FROM_ADDR_MATCH
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.115324
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.50 BSF_SC0_SA_TO_FROM_ADDR_MATCH Sender Address Matches Recipient
 Address
Received-SPF: pass client-ip=203.110.167.99;
 envelope-from=EwanHai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello Pbonzini and QEMU community,

I submitted a patch titled "target/i386/kvm: Refine VMX controls setting for 
backward compatibility" on the 25th of September 2023. I noticed that it 
hasn't received any replies yet. Here's a link to the patch on lore.kernel.org: 
https://lore.kernel.org/all/20230925071453.14908-1-ewanhai-oc@zhaoxin.com/.

I've double-checked to ensure I CC'd the relevant maintainers and addressed 
previous review comments, if any. I understand that everyone is busy and some 
patches might get overlooked, especially in less-maintained areas.

I kindly request feedback or a review for my submission. If there are any 
issues or changes needed, please let me know.

Thank you for your time and consideration.

Best regards,
Ewan


