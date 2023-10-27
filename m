Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6EC7D9842
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 14:32:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwLzQ-0001Pk-W6; Fri, 27 Oct 2023 08:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qwLzG-0001P0-II
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:30:50 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qwLz9-00031K-6t
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 08:30:47 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B8E31FEFB;
 Fri, 27 Oct 2023 12:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698409840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jx2S+2an/vkeUL6YZw3Q2sQa1vMecrjdwfeKqH/HV/4=;
 b=JPz4Ein1JBaKG1tzVzREAbMOgZZr5qYjIed7TmpBrm/zlWql7gF/lGb4ABKzLRQSQ2VQAT
 +VaOpHBWFoDvRHJDiK16A+vq5/0ooBzE2631krMV04Q3giK6F8C1k9UAXInz3afUWJvz9d
 +BPx8qTE8uVGmnKzqNT0wBnXQTxJJVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698409840;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jx2S+2an/vkeUL6YZw3Q2sQa1vMecrjdwfeKqH/HV/4=;
 b=BK8Eo5VZ0KJtTKNGsCShqgPBV34ZW7aAva1OqKb3vG1+PQ1/WcToRrNRxeDx0F2FNj2xdZ
 8wWKRfBbXntPWlCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1EE11358C;
 Fri, 27 Oct 2023 12:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oC8nI2+tO2VxPgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 27 Oct 2023 12:30:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 01/16] Cherry pick a set of patches that enables multifd
 zero page feature.
In-Reply-To: <20231025193822.2813204-2-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-2-hao.xiang@bytedance.com>
Date: Fri, 27 Oct 2023 09:30:37 -0300
Message-ID: <87zg041c42.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> Juan Quintela had a patchset enabling zero page checking in multifd
> threads.
>
> https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.com/

Hmm, risky to base your series on code more than an year old. We should
bother Juan so he sends an updated version for review.

I have concerns about that series. First is why are we doing payload
processing (i.e. zero page detection) in the multifd thread. And that
affects your series directly, because AFAICS we're now doing more
processing still.

Second is more abstract but the multifd packet header is becoming just
about small details about pages. We should probably take the time now
and split that into a multifd header and a payload specific header. With
some versioning stuck to them for migration compatibility.

Now, I don't want to block this series due to my idealistic views on the
code base, so I'll keep those aside while reviewing this, but I
definitely think we should look at the big picture before we get too
tangled up.


