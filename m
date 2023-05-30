Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 962B7716274
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:45:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zfM-00061L-IF; Tue, 30 May 2023 09:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3zf3-0005w0-Nm; Tue, 30 May 2023 09:45:17 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1q3zf2-00084y-44; Tue, 30 May 2023 09:45:17 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9F1CF21A3D;
 Tue, 30 May 2023 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1685454314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pCf1PEL4s+oq7IfbTYdRkfV3K3nbI9dcBJzFPvymOo=;
 b=pFOGHK3JLcSqsnHKlwzqdfjM+VmRj6RqFxn/zg3EPytwcxIQNkPbVF6NZOABX+suMVJtXv
 NKPxbio4pC5hMIVqw9wEELoSnbRl2RLWbTrDD74YwmLlAKjzvv/eWXKE+5DgxZUcsFqjk7
 svQ/9MopKHHil7ixH7KG8aWfEPoTHrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1685454314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9pCf1PEL4s+oq7IfbTYdRkfV3K3nbI9dcBJzFPvymOo=;
 b=PqqRELB+qE2vuWnZcnDPzTlVi7z+2UayFWLpzCg4prIMXtBodmy6KanH19IAnCl89wsa/y
 aF7EUaULaJnM2iCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D67A13597;
 Tue, 30 May 2023 13:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u8/tOen9dWQoSwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 30 May 2023 13:45:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>, Hailiang
 Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>, Fam Zheng
 <fam@euphon.net>, Juan Quintela <quintela@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>
Subject: Re: [PATCH 03/16] migration: Use qemu_file_transferred_noflush()
 for block migration.
In-Reply-To: <20230530122813.2674-4-quintela@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-4-quintela@redhat.com>
Date: Tue, 30 May 2023 10:45:11 -0300
Message-ID: <874jnuaq6w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Juan Quintela <quintela@redhat.com> writes:

> We only care about the amount of bytes transferred.  Flushing is done
> by the system somewhere else.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


