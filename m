Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB46B7CFBD1
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:57:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTWR-0001Qi-Fc; Thu, 19 Oct 2023 09:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtTWP-0001Oi-J9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:57:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtTWN-00055e-Um
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:57:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1B8C721899;
 Thu, 19 Oct 2023 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697723826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ItQB6qyG3KQo882AsOsn6Sb531yo+Grcjmos5PE2nZM=;
 b=zyDuOhvzzXEh7fgGI8cY5JP1MoPBm5M8jBSXs95cHVG08w1zEZKP8RU1l6Ell6aVqTeFC7
 I+c44Kmm6epBo8iHr0J3XI1be0R7cn0qXyC1C8BgDArZFyWVA9lK1rucSDvoNiOtsJdV49
 7GBvU7fNPlOilzBMd78IYMJNCZ2SyqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697723826;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ItQB6qyG3KQo882AsOsn6Sb531yo+Grcjmos5PE2nZM=;
 b=vlgTvwJjdsw6H4BLS2H/Z9yvj4gh2lmtemdaYp9VkXxL3nnzxhFSsiRxYCeE7xzbb+6O6G
 SVr3DNjg3R7xT3Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A46EA139C2;
 Thu, 19 Oct 2023 13:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d/Y2HLE1MWVhbwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 13:57:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Mikhail Tyutin
 <m.tyutin@yadro.com>, Aleksandr Anenkov <a.anenkov@yadro.com>,
 qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v5 1/6] gdbstub: Check if gdb_regs is NULL
In-Reply-To: <20231019101030.128431-2-akihiko.odaki@daynix.com>
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
 <20231019101030.128431-2-akihiko.odaki@daynix.com>
Date: Thu, 19 Oct 2023 10:57:03 -0300
Message-ID: <871qdqzpe8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.79
X-Spamd-Result: default: False [-6.79 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.69)[98.64%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> cpu->gdb_regs may be NULL if no coprocessor is registered.
>
> Fixes: 73c392c26b ("gdbstub: Replace gdb_regs with an array")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Tested-by: Fabiano Rosas <farosas@suse.de>

