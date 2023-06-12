Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9986872C2C7
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 13:31:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8fkC-0003IY-5Q; Mon, 12 Jun 2023 07:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1q8fk9-0003IP-Sc
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:29:53 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <schwab@suse.de>) id 1q8fk8-0006Ej-FV
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 07:29:53 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EE2E42283D;
 Mon, 12 Jun 2023 11:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686569389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xigl1psyyOSxOweZR4/5p3xB0FbVmDtUpiAiWmdbGxY=;
 b=0VhEpJAmg3qalngqifICbSCzSSEF0yGYbsMOjy23GM1m2bdtG5vepRpDsKM471rAnXfM8W
 gpZWs4ZSyL3KvD9qGMWlJ5hOtwjsAeEDl531fZU4xL0NFBYv/Njn4djuENmjnte3hyMXk9
 EPeB82RpgCKV87o4cdoukU98g1W1WVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686569389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xigl1psyyOSxOweZR4/5p3xB0FbVmDtUpiAiWmdbGxY=;
 b=ct+whOHvphs+JQQ1oV4JtXThiDY8VMnCsI1tuGgg3aW1Ncwok8cPBMinGfsFYsdPxAm6oe
 mUqBq9LNaTK84RDw==
Received: from hawking.suse.de (unknown [10.168.4.11])
 by relay2.suse.de (Postfix) with ESMTP id B73C82C141;
 Mon, 12 Jun 2023 11:29:49 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
 id 60EEE4A0374; Mon, 12 Jun 2023 13:29:49 +0200 (CEST)
From: Andreas Schwab <schwab@suse.de>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Warner Losh <imp@bsdimp.com>,  Kyle Evans <kevans@freebsd.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3] linux-user, bsd-user: preserve incoming order of
 environment variables in the target
In-Reply-To: <mvmlejfsivd.fsf@suse.de> (Andreas Schwab's message of "Wed, 29
 Mar 2023 17:00:06 +0200")
References: <mvmlejfsivd.fsf@suse.de>
X-Yow: NOW, I'm supposed to SCRAMBLE two, and HOLD th' MAYO!!
Date: Mon, 12 Jun 2023 13:29:49 +0200
Message-ID: <mvmedmg6hqq.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=schwab@suse.de;
 helo=smtp-out1.suse.de
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

