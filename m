Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C99D5756F25
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 23:53:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLW86-0003tG-4h; Mon, 17 Jul 2023 17:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qLW83-0003sk-Up
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:51:39 -0400
Received: from mail-4018.proton.ch ([185.70.40.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chris@laplante.io>) id 1qLW80-0003SN-CL
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 17:51:39 -0400
Date: Mon, 17 Jul 2023 21:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=laplante.io;
 s=protonmail3; t=1689630685; x=1689889885;
 bh=EsbkskaRF0oJyPNKlajASN+khC26Zb34VB2Xi2lcYIo=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=JU79hzc1dXsBUAkhbTDjirFP+GfJ2JId1MGnph6UVQQW/moHDdxDZmdOAJ7HiQQkc
 cBF9lG8yXP6bTRHeTA2YdDovUb+bYBL41pEIasDxo9JKSpoKnixyjY+/WFvog8ZtGz
 XiqRiFJEBkmjZ4WPtT2U1CWFncHlqgWV0oNrzmDltWDHVHAKIPBFRnWjTOWiU6oKxj
 Tb0HBar99XUr4hVlryErVgNyakWuF+UzMTVIv2/Kt1OPScCqvG5CDfafSn8olNQ0vy
 KnBcVCrtgmfHQdGmtSelqvkKK0zCY0tG/IL5lnd6Zp1+fyqTbBs4JgWT4WUD5HBJ3G
 rWdU4AHmMtGOQ==
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>
From: Chris Laplante <chris@laplante.io>
Subject: Thoughts on implementing SEGGER RTT
Message-ID: <1mjgMzNMSQPXkdhRsPwsqABs5nbyxQA3jzrbzEPckVa1WhBvzGSP3L5ZRftans6RflTNGovEUJu5WtNCUJF0HFlFWbUC7qPyvQygPhEAU1U=@laplante.io>
Feedback-ID: 43500449:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.40.18; envelope-from=chris@laplante.io;
 helo=mail-4018.proton.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Hi all,

SEGGER RTT (https://wiki.segger.com/RTT) is a software debug mechanism whic=
h, among other things, exposes convenient virtual terminals. It is implemen=
ted as ring buffers in RAM. There is a control block with a fixed ID so it =
can be located by the RTT viewer (which runs on your PC, for example) at ru=
ntime.

I'm considering what it would take to implement an RTT viewer in qemu. Some=
 small parts would be easy:

- Add a '-rtt' command line option
- Use=C2=A0address_space_read or flatview_* stuff to locate the fixed ID in=
 the control block

But I don't yet know enough about QEMU to understand some bigger picture th=
ings:

- I assume the code for reading messages would need to live in a QemuThread=
?=20
- Where would I output virtual terminal messages to?
- In the case of bidirectional communication, how would a user input messag=
es to send to the emulated device?
- Is there a way to monitor memory ranges for changes, or would I need anot=
her way to detect when new messages are in the ring buffer?

Another possibility (which would avoid the last 3 issues, but of course cre=
ate more complexity in other areas) is to have QEMU emulate a SEGGER J-LINK=
 and provide a TCP/IP endpoint that a real RTT Viewer could connect to (htt=
ps://www.segger.com/products/debug-probes/j-link/tools/rtt-viewer/). I'm no=
t sure how feasible this is, though.

If anyone has any thoughts or guidance I'd appreciate it.

Thanks,
Chris

