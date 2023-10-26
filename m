Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74A7D89D9
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:52:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw7JN-0002FA-4a; Thu, 26 Oct 2023 16:50:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qw7JE-0002Ex-VH
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:50:29 -0400
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1qw7JC-0007VL-7R
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1698353419; bh=1FIsEx1PZ/gqeG/838CEPnOEq8w3zTelwB+WJXMD37g=;
 h=Date:From:To:Subject:From;
 b=IBB+kMTGxBy9CzfH8bf4Siw3odakZxlhUicNc6+fjQWVPa/L4rmCOwDagg4o7aysw
 89GtIRIfGqb+5gPw3mcVvmoyRzTUVlkzi6ytVsak8szEC2Z7xDTmd3gI80K6U5Q+Iy
 WrXiwJ5D3t8NAQRT9gNluAOjPDJHo4x3JWsQR1dY=
Date: Thu, 26 Oct 2023 20:50:17 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: qemu-devel@nongnu.org, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Subject: [RFC] pvpanic notifications for non-panic reboot events
Message-ID: <984794aa-4af0-4c68-a74e-7420ec3151a5@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Hi everybody,

the mechanism for a (Linux) guest to signal a regular shutdown event to
QEMU seems fairly architecture specific and dependent on kernel
configuration.

The existing pvpanic protocol [0] could be extended fairly easily to
also cover these events.

Any thoughts?

Thanks,
Thomas

[0] https://github.com/qemu/qemu/blob/master/docs/specs/pvpanic.txt

