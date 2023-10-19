Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407007D02F5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 22:03:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtZDT-00037D-5n; Thu, 19 Oct 2023 16:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtZDQ-00036z-JQ
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:01:56 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtZDP-0003Op-1A
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 16:01:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A0F421A5C;
 Thu, 19 Oct 2023 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697745713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Trnglk/tx8IsP1hLvQelYpgBop+kPf0dfrIOmNF0avE=;
 b=WLCuek4FuwT1WTCz8Z5G2KuZmLywwGvpa9vvmYHorsVDfq08u6ELUwpAQ1G6TDF/nQvhFu
 W1wxQyT5V6f/2rrP8WbVMALfJGSR+XcGlu7LHG0DXDY6iiizfuq7+zskqvyuRpUYtjT8Ya
 uM5w9sE6amcJJiftM9xoqMzH7u3yd80=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697745713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Trnglk/tx8IsP1hLvQelYpgBop+kPf0dfrIOmNF0avE=;
 b=KHMeLaqXWloS/Sc3ad6Zr7qLlrEHbafmBNokJe0UkLDshn62YCXbEc+yiQmDJsmSoDNp/d
 wHF8fqyMqHxDL0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D39D01357F;
 Thu, 19 Oct 2023 20:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rf6CJzCLMWV0JAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 20:01:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: Re: [PATCH 3/6] tests: Add migration dirty-limit capability test
In-Reply-To: <c7c45ef33d46e9594e935a03c54a0a6f42639e17.1697502089.git.yong.huang@smartx.com>
References: <cover.1697502089.git.yong.huang@smartx.com>
 <c7c45ef33d46e9594e935a03c54a0a6f42639e17.1697502089.git.yong.huang@smartx.com>
Date: Thu, 19 Oct 2023 17:01:50 -0300
Message-ID: <87r0lq5qkx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -5.99
X-Spamd-Result: default: False [-5.99 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-1.89)[94.36%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Hyman Huang <yong.huang@smartx.com> writes:

> Add migration dirty-limit capability test if kernel support
> dirty ring.
>
> Migration dirty-limit capability introduce dirty limit
> capability, two parameters: x-vcpu-dirty-limit-period and
> vcpu-dirty-limit are introduced to implement the live
> migration with dirty limit.
>
> The test case does the following things:
> 1. start src, dst vm and enable dirty-limit capability
> 2. start migrate and set cancel it to check if dirty limit
>    stop working.
> 3. restart dst vm
> 4. start migrate and enable dirty-limit capability
> 5. check if migration satisfy the convergence condition
>    during pre-switchover phase.
>
> Note that this test case involves many passes, so it runs
> in slow mode only.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> Acked-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Fabiano Rosas <farosas@suse.de>

