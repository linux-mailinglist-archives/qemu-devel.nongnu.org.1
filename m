Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F17426BF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 14:55:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEr9c-000100-ME; Thu, 29 Jun 2023 08:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEr9Y-0000yQ-80
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:53:40 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qEr9U-00065Y-82
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 08:53:39 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 2C3B974633D;
 Thu, 29 Jun 2023 14:53:20 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F104F74632B; Thu, 29 Jun 2023 14:53:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EF459745720;
 Thu, 29 Jun 2023 14:53:19 +0200 (CEST)
Date: Thu, 29 Jun 2023 14:53:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Unused variables in dbus_call_update_gl
Message-ID: <156d2af2-5e64-39f1-fdbd-54f6c299515a@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-857542839-1688043199=:3256"
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-857542839-1688043199=:3256
Content-Type: text/plain; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

Hello,

After recent commits I'm now getting:

../ui/dbus-listener.c: In function ¡dbus_call_update_gl¢:
../ui/dbus-listener.c:210:26: error: unused variable ¡ddl¢ [-Werror=unused-variable]
   210 |     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
       |                          ^~~
At top level:
../ui/dbus-listener.c:180:13: error: ¡dbus_update_gl_cb¢ defined but not used [-Werror=unused-function]
   180 | static void dbus_update_gl_cb(GObject *source_object,
       |             ^~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

when compiling on Linux with gcc.

Regards,
BALATON Zoltan
--3866299591-857542839-1688043199=:3256--

