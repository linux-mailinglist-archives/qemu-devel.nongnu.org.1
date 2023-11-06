Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C07E1BC6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 09:17:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzumJ-0000Xw-Ux; Mon, 06 Nov 2023 03:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzuly-0000MW-RJ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qzulv-0007xm-AH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 03:15:49 -0500
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue108
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MWAWq-1qtvZE38d0-00Xelf; Mon, 06
 Nov 2023 09:15:42 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 1/4] macfb: don't clear interrupts when writing to DAFB_RESET
Date: Mon,  6 Nov 2023 09:15:38 +0100
Message-ID: <20231106081541.53688-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106081541.53688-1-laurent@vivier.eu>
References: <20231106081541.53688-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jY6bVBOk79ivImRWbnv1qqFrw9o57WeR0I6nI3o6v9VJ0iZOQ3I
 3DqiQDOiJIp0tJv+QPkVqjFikH1EtT1ZusuxCtZZUatRi6xQdEP+fAm9SdUqHZIbs3SoUPE
 FsOu9x8YYixzqu3+2oyvsD6UoqqjiyU+B10ajZXCJUs5+JidUpY0wXdzIZ03bT6J0KO4Cnd
 X/4eQl3dQYZwIpz6quH8A==
UI-OutboundReport: notjunk:1;M01:P0:AXEzPozdl/U=;BkwhbyKCgpQvJtIk9cj2mzixyfa
 3cJCBlkmSwM8vDk/Tx/Pc2NqHCpyuvGob063eBxuJQb69m69IqDtw1CbPBxlXU/BvmpldV6zw
 6GaU1ov4ydxqueOdD4stvD1P930JO9382xMrfGg4t43Rr2bS1SW8HsggeuXGZjfKo5Mn2ay8L
 6X8RcCJsWFnxMqwusES0xn3Q2KUGSXXpCcjSly/Cx1JDfKV1JoM6H5+2Fv/NfGwpM/zn5jlZs
 Oes1Nl/XB4vlxNTO+BYTNevb6PfFGYunhHfgy3sfro1vcpN+NXghhfIGRDRvSix2cbAgGE98L
 rM8XgZXKum9ErF1x/+AMC+OYgCgmxSB0CiI7xqHpfeRAeQSFG7ABk+Utqvxj33sEqaWpjv3o8
 8GNBlrEVRl+0hmTg6iT5l+zVPXdbInPtRNHWUo6FZI8BBx6HkzDklR+Mr7Hu6gUZQfopfV1rG
 WtiXVVnyXcIhw2dkOZeMVf7afumS5bl5iQ4iwvYcjy4a9VA80NjKOVkvSXvHebT6VKUyakdcr
 hYbSQQUh9Ed9K8zuy0t+0a2uTDVMvbZ3ugh3GmqOjIoaj6elL+QS1csT0z3eHg6UH8wAVuX4N
 AjdUGOAtSGvgsvExTxMv/tGHTnhvVUF73nE0VxOGeRr66Fnv3yVDVL20zI+4Qc7rjhRBo86KM
 TwzeLZGwFhxGYjC5KPx3IH8PzQLQrIWp9F1g/LkyGXI3SM4mLxy2JriLR5A0VuV/yUrxYLyBa
 QikEdWI7zjp+f/Kuv2iepFyZBKsG6+dkM/dCaRSHKsASL0zaLU/dTATb7HXCix4bCLW/BIdmj
 3RtAoNiogjzOw4+McH7U6AqNHRbJ7W2d44LlJXuEtyWjw+nyEDPxqffW3/ZFyTwBP+LrqX2I6
 A9rdoLkT28ZyrSA==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Traces from A/UX suggest that this register is only used to reset the framebuffer
LUT (colour lookup table) and not any other device state.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20231026085650.917663-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/macfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 2f8e01656640..28db2e9f246a 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -585,8 +585,6 @@ static void macfb_ctrl_write(void *opaque,
         break;
     case DAFB_RESET:
         s->palette_current = 0;
-        s->regs[DAFB_INTR_STAT >> 2] &= ~DAFB_INTR_VBL;
-        macfb_update_irq(s);
         break;
     case DAFB_LUT:
         s->color_palette[s->palette_current] = val;
-- 
2.41.0


