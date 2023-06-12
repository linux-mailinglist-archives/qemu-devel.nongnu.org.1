Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D4C72BF75
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 12:44:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8f0h-0001Pa-WE; Mon, 12 Jun 2023 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1q8f0d-0001PC-Fu
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 06:42:51 -0400
Received: from forward500c.mail.yandex.net ([178.154.239.208])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1q8f0b-0004jz-AJ
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 06:42:51 -0400
Received: from mail-nwsmtp-mxback-production-main-28.myt.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-28.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:1110:0:640:4f89:0])
 by forward500c.mail.yandex.net (Yandex) with ESMTP id 3E65E5E59A;
 Mon, 12 Jun 2023 13:42:42 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c12:1e1b:0:640:f562:0
 [2a02:6b8:c12:1e1b:0:640:f562:0])
 by mail-nwsmtp-mxback-production-main-28.myt.yp-c.yandex.net (mxback/Yandex)
 with HTTP id cgW3Uo2W5Sw0-2IQ0x7aZ; Mon, 12 Jun 2023 13:42:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phystech.edu; s=mail;
 t=1686566561; bh=6SB0nyEz1XKqrbh5HN4LOKTHz+/mlOiyU4u639biT8s=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=ght8Y0Ha3NciFgsYjlPai7YPv8CaovHzMXUGne7qN3O3ynssh6usXo1ViAvWRaQdT
 xuGtKnHggP6CcBsYURPDoSseRqhI7ZD3gHUbH6SACxBF17p75oFh+xeuRWgApZaQ9w
 n7KBoUZ56THEtqKZjDGS3MxDzIEQLPm8jlTgX8TQ=
Authentication-Results: mail-nwsmtp-mxback-production-main-28.myt.yp-c.yandex.net;
 dkim=pass header.i=@phystech.edu
Received: by lduixalyeduyxu6q.myt.yp-c.yandex.net with HTTP;
 Mon, 12 Jun 2023 13:42:41 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
	Viktor Prutyanov <viktor@daynix.com>
In-Reply-To: <20230611033434.14659-1-akihiko.odaki@daynix.com>
References: <20230611033434.14659-1-akihiko.odaki@daynix.com>
Subject: Re: [PATCH] elf2dmp: Don't abandon when Prcb is set to 0
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 12 Jun 2023 13:42:41 +0300
Message-Id: <260451686566561@lduixalyeduyxu6q.myt.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Received-SPF: pass client-ip=178.154.239.208;
 envelope-from=viktor.prutyanov@phystech.edu; helo=forward500c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> Prcb may be set to 0 for some CPUs if the dump was taken before they
> start. The dump may still contain valuable information for started CPUs
> so don't abandon conversion in such a case.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> contrib/elf2dmp/main.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index d77b8f98f7..91c58e4424 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -312,6 +312,11 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
> return 1;
> }
> 
> + if (!Prcb) {
> + eprintf("Context for CPU #%d is missing\n", i);
> + continue;
> + }
> +
> if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext, 
> &Context, sizeof(Context), 0)) {
> eprintf("Failed to read CPU #%d ContextFrame location\n", i);
> 
> --
> 2.40.1

Hi Akihiko,

How this fix can be tested?

NumberProcessors field is still set to qemu_elf.state_nr, how does WinDbg react to this?

Viktor

