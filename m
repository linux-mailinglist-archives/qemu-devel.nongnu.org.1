Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA63E7AB8EF
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 20:15:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjkey-0008B0-H3; Fri, 22 Sep 2023 14:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjkev-0008Ak-Ap
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:13:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjket-0007V1-Rl
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 14:13:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A66661FDC2;
 Fri, 22 Sep 2023 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695406421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3JKryKBNrwrG2ic4HDLU47bw3FEW4VWyzasUDKAx6y8=;
 b=HOn4HHkYs3QTfwEewsR5cAeMCqytSyCEzqczIoFl1Qu1mT7hzwtP4rb6ZeE6ntuJGeQgsd
 uNMs2ojd6mKcUSSHR0Q8psxSlxrvho/7jFfRdHQWoQvco2NLbc0011e9AtkkDwU4U5ot7Y
 /T+H72GSd58bxgUMIEkMLxkXu1laVKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695406421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3JKryKBNrwrG2ic4HDLU47bw3FEW4VWyzasUDKAx6y8=;
 b=erF7CA0eQviIk2ppGAdkm/r2SZEhbfoqVzs5nozj8XJbDp6yt1p0jCxh/7A35nj0ecn+bT
 /kNyUo/Rppzh79BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3970E13597;
 Fri, 22 Sep 2023 18:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vRe2AVXZDWXYagAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 22 Sep 2023 18:13:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>, quintela@redhat.com,
 peterx@redhat.com, leobras@redhat.com
Cc: elena.ufimtseva@oracle.com, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] multifd: fix counters in multifd_send_thread
In-Reply-To: <20230922065625.21848-4-elena.ufimtseva@oracle.com>
References: <20230922065625.21848-1-elena.ufimtseva@oracle.com>
 <20230922065625.21848-4-elena.ufimtseva@oracle.com>
Date: Fri, 22 Sep 2023 15:13:38 -0300
Message-ID: <874jjmm5yl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> writes:

> Previous commit cbec7eb76879d419e7dbf531ee2506ec0722e825
> "migration/multifd: Compute transferred bytes correctly"
> removed accounting for packet_len in non-rdma
> case, but the next_packet_size only accounts for pages, not for
> the header packet (normal_pages * PAGE_SIZE) that is being sent
> as iov[0]. The packet_len part should be added to account for
> the size of MultiFDPacket and the array of the offsets.
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>

I don't really understand the purpose of next_packet_size, but the
accounting and explanation seem correct.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

