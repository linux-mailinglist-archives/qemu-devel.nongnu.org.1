Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D79677C861F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHbN-00018R-IV; Fri, 13 Oct 2023 08:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeanniestevenson@protonmail.com>)
 id 1qrAMN-0007eJ-DV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:05:15 -0400
Received: from mail-40141.protonmail.ch ([185.70.40.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeanniestevenson@protonmail.com>)
 id 1qrAML-000602-07
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 01:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1697173503; x=1697432703;
 bh=UNHJ0s9/AB/ec899ZyDbovnKqbzxJjgzKr2hRpklGhQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=t0GPUUyqThGzEHGMCQ/t17TPjkGUj7crxi+UcPRzuusrjrS4jAOOrM8A3eTtb24gV
 9kp/XBBx5fhxuhZR0XPXhlbFvlPC8e+dNhb5zmlc0MdeG2DOdEmHeUIt30RwQ1PjUd
 weViJXM9NK6k2aZugv31u90dH7YI+o8D1gbCwGu83AxRdqSm6LxoJFKmuX0UJdq4BC
 xDeKjFryADTXFP9P52F/vEKXg0w6ywQTsezbtPvBz2w5bcTql9JrDxoy747OovsxEh
 Q1JzCzspALkKmhv/LM4CypQr2HhRyyQ8BM2O0J7OT5k3GPz70jqUqTPcaTrUpF5hju
 orkUOQ/qNvvgg==
Date: Fri, 13 Oct 2023 05:04:57 +0000
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: jeanniestevenson <jeanniestevenson@protonmail.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Subject: [PATCH] Increase console refresh rate to let GVT-g VMs run at beyond
 30 FPS
Message-ID: <rsRAqCJMX2IpQ229LdGkmEU6TqXsfhjWWZU7kMABQ0OFdGCT8rgO5lxpp8xSu3G6GI4of_5Xvry9uSrIPTAXIX9lN-jdW9QStA-nVNQNF2I=@protonmail.com>
Feedback-ID: 29602004:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.141;
 envelope-from=jeanniestevenson@protonmail.com; helo=mail-40141.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Oct 2023 08:48:51 -0400
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

Increase console refresh rate for guest operating systems using Intel GVT-g=
, corresponding to ~60fps. This increases the refresh rate of access to the=
 display of the GUI, creating a much smoother user experience.

I've looked into why it is 30 by default and it appears to have been added =
in commit 313aa567104a63fbe84d6ec2eeff5b5c81cb3524 2 decades ago when VGA e=
mulation was first added. This commit does not appear to break VGA emulatio=
n in my testing.

If there's enough interest (IE for 75 fps displays), this constant could be=
 replaced by a function that gets a command-line flag that could be set wit=
h a QEMU arg, but I'm currently not familiar enough with QEMU's codebase kn=
ow how to get the arguments for a VM to add such a charge.

Signed-off-by: Jeannie Stevenson <jeanniestevenson@protonmail.com>

diff --git a/include/ui/console.h b/include/ui/console.h
index acb61a7f15..f0c4e6ae4e 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -43,7 +43,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(QemuFixedTextConsole, QEMU_FIX=
ED_TEXT_CONSOLE)
 #define QEMU_CAPS_LOCK_LED   (1 << 2)
=20
 /* in ms */
-#define GUI_REFRESH_INTERVAL_DEFAULT    30
+#define GUI_REFRESH_INTERVAL_DEFAULT    16
 #define GUI_REFRESH_INTERVAL_IDLE     3000
=20
 /* Color number is match to standard vga palette */

