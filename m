Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 870788193BF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 23:43:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFimZ-0007Me-0r; Tue, 19 Dec 2023 17:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@killthe.net>) id 1rFimW-0007MA-0o
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 17:41:44 -0500
Received: from mail.killthe.net ([207.126.114.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dave@killthe.net>) id 1rFimQ-00056U-GL
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 17:41:42 -0500
Received: from magic (unknown [166.199.184.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.killthe.net (Postfix) with ESMTPSA id 41B0C120019
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 17:41:33 -0500 (EST)
Date: Tue, 19 Dec 2023 16:44:43 -0600
From: Dave Blanchard <dave@killthe.net>
To: qemu-devel@nongnu.org
Subject: TCP/telnet serial port not working in QEMU 8.1.3
Message-Id: <20231219164443.a644c86555f55e694563dbaa@killthe.net>
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

I just "upgraded" from QEMU 6.1.0 to 8.1.3 only to find that the -serial telnet/tcp option is no longer working. The following message is printed, and there's a 'connection refused' with the telnet program. Nmap shows no ports open.

qemu-system-x86_64: -serial telnet:127.0.0.1:1800,server=on: 
info: QEMU waiting for connection on: disconnected:telnet:127.0.0.1:1800,server=on

What gives?

