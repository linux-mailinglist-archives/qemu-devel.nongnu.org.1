Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE997D6CE0
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:16:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvdin-0000QN-8a; Wed, 25 Oct 2023 09:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvdiT-0000JP-P8; Wed, 25 Oct 2023 09:14:34 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvdiR-0004PQ-5y; Wed, 25 Oct 2023 09:14:33 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32D101FF5F;
 Wed, 25 Oct 2023 13:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698239669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLz8795O0e0KeXdEILyXs2ReTqQ8LytuEM5bwbCZj/8=;
 b=Sjk8GxLX6J8rgMMGGZtOQzxFwamIab/LmpIcBfVKC6FOQGmRsg6kixzFR0WMLk3LRVdvWV
 /Y1SqtuqpUZvTAscpVYQAYg+dUF/xRZOGfP1laxCII+L6AUAVrw0glbyWwu4ZXBSpbgX12
 h91UY37mKvAgubsye5+THOc+J9BHJoc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698239669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mLz8795O0e0KeXdEILyXs2ReTqQ8LytuEM5bwbCZj/8=;
 b=3vJop4rH56e9yX+aMuasbTwmkEsjEFg/WpnRkPN5gt/EJxF/tx4o1TEodhleMAEnQ3iJUP
 cD8UW3d1E7l/kzBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9E5713524;
 Wed, 25 Oct 2023 13:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MK4dIbQUOWVscwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 25 Oct 2023 13:14:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, Peter
 Xu <peterx@redhat.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Li
 Zhijian <lizhijian@fujitsu.com>, qemu-block@nongnu.org, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v2 01/12] qemu-file: Don't increment
 qemu_file_transferred at qemu_file_fill_buffer
In-Reply-To: <20231025091117.6342-2-quintela@redhat.com>
References: <20231025091117.6342-1-quintela@redhat.com>
 <20231025091117.6342-2-quintela@redhat.com>
Date: Wed, 25 Oct 2023 10:14:26 -0300
Message-ID: <87a5s6g7yl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Juan Quintela <quintela@redhat.com> writes:

> We only call qemu_file_transferred_* on the sending side. Remove the
> increment at qemu_file_fill_buffer() and add asserts to
> qemu_file_transferred* functions.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

