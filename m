Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0CF757E45
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 15:55:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLl93-0005Om-8t; Tue, 18 Jul 2023 09:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qLl8q-0005MT-7G
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:53:32 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1qLl8o-0000Ni-5o
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:53:27 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D34391FDBF;
 Tue, 18 Jul 2023 13:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689688402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzZ5zRQIA9Gpph2kpnKrRMm+6Yf2oIWR63jQew7w/Dc=;
 b=c7+DGSzMCfMjJ/3Cz1T+yWIZoNEjm0Ry+mnuUe7K7TFavfMLkJee7pLTYWOIX9FgYbAjjp
 YA9n4QvUVZeiCW7X63vSIJlc37iWXNjsRf1uVN5BQB2U96mNMwDZ3ovLhKyLxlm0pMCAPZ
 G0G9VNr+u8zY1xKLVJFE9rKRBILoH8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689688402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tzZ5zRQIA9Gpph2kpnKrRMm+6Yf2oIWR63jQew7w/Dc=;
 b=qVvg/GkmzQdx59XapC+VjNuMBnmpqAiwWUNopNfbagxRELzW3zXbA5qYJMdDDbCYQZmREh
 /1uz6FiPVmU3OACg==
Received: from hawking.nue2.suse.org (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 538A52C142;
 Tue, 18 Jul 2023 13:53:22 +0000 (UTC)
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 42E6E4A09FF; Tue, 18 Jul 2023 15:53:22 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Helge Deller <deller@gmx.de>
Cc: Laurent Vivier <laurent@vivier.eu>,  qemu-devel@nongnu.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Richard Henderson
 <richard.henderson@linaro.org>,  "Markus F . X . J . Oberhumer"
 <notifications@github.com>
Subject: Re: [PATCH 1/6] Revert "linux-user: Make sure initial brk(0) is
 page-aligned"
In-Reply-To: <20230717213545.142598-2-deller@gmx.de> (Helge Deller's message
 of "Mon, 17 Jul 2023 23:35:40 +0200")
References: <20230717213545.142598-1-deller@gmx.de>
 <20230717213545.142598-2-deller@gmx.de>
X-Yow: Civilization is fun!  Anyway, it keeps me busy!!
Date: Tue, 18 Jul 2023 15:53:22 +0200
Message-ID: <mvmsf9lcoml.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=schwab@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Jul 17 2023, Helge Deller wrote:

> This reverts commit d28b3c90cfad1a7e211ae2bce36ecb9071086129.
>
> It just hides the real bug, and even the Linux kernel may
> return page-unaligned addresses.

The initial brk is always page aligned, see binfmt_elf.c:set_brk and the
various arch_randomize_brk implementations.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

