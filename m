Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9F6811B3B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:34:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDT6o-0004Sj-GR; Wed, 13 Dec 2023 12:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rDT6c-0004PW-7A
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:33:10 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rDT6Z-0007Tk-Me
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:33:09 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 83D2A225EA;
 Wed, 13 Dec 2023 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702488784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Q0kLNIDnPkwjbaOiaY6xGq8lpAbRakhyvP90TVdH7U=;
 b=FJ4gZnxSHgbdR9lhmZ2kLbNMCf9DzQOwyFd2P1/WS8NyDCk81Dj2spcgCyScrRqG9oDCEk
 xbkM7no5lwSJvWbfgg9ZuYz2PFylqxHKa7s3X3GJjKC5TjEvXLnYcJL/iAeXbzzmqPQIBK
 mU7Yt6fEcJbamhSMnNHX3Wr8c0q/aCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702488784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Q0kLNIDnPkwjbaOiaY6xGq8lpAbRakhyvP90TVdH7U=;
 b=/2jw35seEBA9fpQYGFZUPoaC4BTniNqC7pUFaYqdScjtn+2O2LAoGvB2f/hJ3bfVFrAlp8
 8kruBI4FwXF4NPAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702488784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Q0kLNIDnPkwjbaOiaY6xGq8lpAbRakhyvP90TVdH7U=;
 b=FJ4gZnxSHgbdR9lhmZ2kLbNMCf9DzQOwyFd2P1/WS8NyDCk81Dj2spcgCyScrRqG9oDCEk
 xbkM7no5lwSJvWbfgg9ZuYz2PFylqxHKa7s3X3GJjKC5TjEvXLnYcJL/iAeXbzzmqPQIBK
 mU7Yt6fEcJbamhSMnNHX3Wr8c0q/aCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702488784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8Q0kLNIDnPkwjbaOiaY6xGq8lpAbRakhyvP90TVdH7U=;
 b=/2jw35seEBA9fpQYGFZUPoaC4BTniNqC7pUFaYqdScjtn+2O2LAoGvB2f/hJ3bfVFrAlp8
 8kruBI4FwXF4NPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E1D41377F;
 Wed, 13 Dec 2023 17:33:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tJeJMc/qeWXGXwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Dec 2023 17:33:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, peter.maydell@linaro.org,
 quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v2 18/20] migration/multifd: Enable set packet size
 migration option.
In-Reply-To: <20231114054032.1192027-19-hao.xiang@bytedance.com>
References: <20231114054032.1192027-1-hao.xiang@bytedance.com>
 <20231114054032.1192027-19-hao.xiang@bytedance.com>
Date: Wed, 13 Dec 2023 14:33:01 -0300
Message-ID: <87o7eu80tu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -0.10
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[19.20%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> During live migration, if the latency between sender and receiver
> is high but bandwidth is high (a long and fat pipe), using a bigger
> packet size can help reduce migration total time. In addition, Intel
> DSA offloading performs better with a large batch task. Providing an
> option to set the packet size is useful for performance tuning.
>
> Set the option:
> migrate_set_parameter multifd-packet-size 512

This should continue being bytes, we just needed to have code enforcing
it to be a multiple of page size at migrate_params_check().


