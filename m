Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B0478FE0F1
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 10:28:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF8TV-0006lb-4h; Thu, 06 Jun 2024 04:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sF8TR-0006kW-87
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:27:53 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1sF8TP-0002kb-BM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 04:27:52 -0400
Received: from hawking.nue2.suse.org (unknown
 [IPv6:2a07:de40:a101:3:10:168:4:11])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9F37421AA7;
 Thu,  6 Jun 2024 08:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717662468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsdpgkOKLwjPc+GIgrNiSb+wt5Z1ns/Nwl4DyZmXQ4g=;
 b=jCkwsxqQfnOfcFs+a89WTA/yykgOGbB9F65G7+8+A0SFtAqQg5ah24l142apmUtrl4KniW
 6XnWre1DiLvaHQGy1YVcrr9yPWGD8A3W7NNV5ezDMJu8r/Sb8X2i4W1/axZrfYmF4bzRdY
 cZXeh+827MDxhuVgNQQv08zMcBZtzGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717662468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsdpgkOKLwjPc+GIgrNiSb+wt5Z1ns/Nwl4DyZmXQ4g=;
 b=+rJj4aZgwfwaBAWjA/gmgCsEklRenXsxMmLyzlPDIP0MHUL7uqYKu94AtMDLdW1PvVwLEk
 3cgqqqlgghxq80CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z3q5wM0E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=38p3q8NO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717662466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsdpgkOKLwjPc+GIgrNiSb+wt5Z1ns/Nwl4DyZmXQ4g=;
 b=Z3q5wM0E7lMrvX+1MmXqcFGq27prCiPh96LEMWbjogQlIi5W6T2D9I66x+Q3gvj4Hc0scI
 GZbH08uR1B/wnAATNVn0QNnerTNEDdiGwqHZR9y4ID69ge+Qsr83QvWDBnsgkFKBocQ9yZ
 XJuYC5HZjfM6ZRcfJydxRm19Ls59RD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717662466;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsdpgkOKLwjPc+GIgrNiSb+wt5Z1ns/Nwl4DyZmXQ4g=;
 b=38p3q8NOTNFYO6WojHxcr+soDD6Q2URKtOPJ73yWSfBQGQx0Eb9xf0WVSvz1VUykqc72Jt
 8K+9qspSqv+u6WAQ==
Received: by hawking.nue2.suse.org (Postfix, from userid 17005)
 id 63BEA4A0552; Thu,  6 Jun 2024 10:27:46 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: linux-user emulation hangs during fork
In-Reply-To: <a0e9ee6b-fbe6-48af-a122-fbf5d31aa476@linaro.org> (Richard
 Henderson's message of "Wed, 5 Jun 2024 16:14:56 -0700")
References: <mvm5xunu4ye.fsf@suse.de>
 <a0e9ee6b-fbe6-48af-a122-fbf5d31aa476@linaro.org>
X-Yow: NATHAN...  your PARENTS were in a CARCRASH!!
 They're VOIDED - They COLLAPSED
 They had no CHAINSAWS...  They had no MONEY MACHINES...
 They did PILLS in SKIMPY GRASS SKIRTS...
 Nathan, I EMULATED them...  but they were OFF-KEY...
Date: Thu, 06 Jun 2024 10:27:46 +0200
Message-ID: <mvmv82mscfx.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.62 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 HFILTER_HOSTNAME_UNKNOWN(2.50)[]; ONCE_RECEIVED(1.20)[];
 RDNS_NONE(1.00)[];
 HFILTER_HELO_IP_A(1.00)[hawking.nue2.suse.org];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 HFILTER_HELO_NORES_A_OR_MX(0.30)[hawking.nue2.suse.org];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.896]; RCVD_NO_TLS_LAST(0.10)[];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DIRECT_TO_MX(0.00)[Gnus/5.13 (Gnus v5.13)];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:a101:3:10:168:4:11:from];
 SPAMHAUS_XBL(0.00)[2a07:de40:a101:3:10:168:4:11:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:10:168:4:11:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_ONE(0.00)[1]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 hawking.nue2.suse.org:helo]
X-Spam-Score: 1.62
X-Rspamd-Queue-Id: 9F37421AA7
X-Spamd-Bar: +
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=schwab@suse.de; helo=smtp-out1.suse.de
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

Which ruby?

$ ruby --version
ruby 3.3.1 (2024-04-23 revision c56cd86388) [x86_64-linux-gnu]

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

