Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FA270BE61
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:30:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14g8-0007qq-5f; Mon, 22 May 2023 08:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1q14g5-0007qJ-8V
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:30:17 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1q14g3-0007g7-RE
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:30:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 37BA81FEE0;
 Mon, 22 May 2023 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684758613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xigl1psyyOSxOweZR4/5p3xB0FbVmDtUpiAiWmdbGxY=;
 b=U6S0fSw9zqxthBhpx8Ggv10PL18ymAo889fhgaFI7baH1PKbQw68sP/f4HbV+8WiJXeX9E
 uf/8znLPmZuwSRKCxOfFMFO7DpUXcHGSc1kQdRQ5Pgu+xTkKHodVjOhfeTRWVzTxXe51QB
 yJuBWnksexGJpeCjo6cqk27OMF4XSrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684758613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xigl1psyyOSxOweZR4/5p3xB0FbVmDtUpiAiWmdbGxY=;
 b=9ZA+xHinvkttk4Q/l3wz75NGv5khV+bajypaGI7oUPT9o+4IqELCje70ZVEH582m7e03KM
 dUpXsHmWF0MWwFAQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id 167F32C15D;
 Mon, 22 May 2023 12:30:12 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
 id B09C34A03A7; Mon, 22 May 2023 14:30:12 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Warner Losh <imp@bsdimp.com>,  Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] linux-user, bsd-user: preserve incoming order of
 environment variables in the target
In-Reply-To: <mvmlejfsivd.fsf@suse.de> (Andreas Schwab's message of "Wed, 29
 Mar 2023 17:00:06 +0200")
References: <mvmlejfsivd.fsf@suse.de>
X-Yow: My EARS are GONE!!
Date: Mon, 22 May 2023 14:30:12 +0200
Message-ID: <mvmv8gkft0r.fsf@suse.de>
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

Ping?

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."

