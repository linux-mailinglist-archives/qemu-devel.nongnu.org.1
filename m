Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF71B81909A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfbl-0001yP-K1; Tue, 19 Dec 2023 14:18:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@killthe.net>) id 1rFfbh-0001ew-RQ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:18:21 -0500
Received: from mail.killthe.net ([207.126.114.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dave@killthe.net>) id 1rFfbd-0002hk-HA
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:18:21 -0500
Received: from magic (unknown [166.199.184.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.killthe.net (Postfix) with ESMTPSA id 4027C120019
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 14:18:16 -0500 (EST)
Date: Tue, 19 Dec 2023 13:21:35 -0600
From: Dave Blanchard <dave@killthe.net>
To: qemu-devel@nongnu.org
Subject: Qemu resets terminal to crazy defaults
Message-Id: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=207.126.114.3; envelope-from=dave@killthe.net;
 helo=mail.killthe.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello all, can you please help me to understand what Qemu is doing here? 

When connecting to the guest for example using a serial/tcp/telnet link, some kind of code is being immediately transmitted over the link which screws up my Xterm terminal settings, including changing the text cursor shape and most notably, disabling wraparound of long lines, so that they get truncated at the edge of the window instead. 

Can this behavior be disabled by command line, and if not, what is the code doing exactly so I can know where to disable it? I tried disabling all calls to tcsetattr() but that had no effect.

Dave

