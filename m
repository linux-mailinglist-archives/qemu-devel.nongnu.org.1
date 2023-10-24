Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 949807D59B0
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:25:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvL8g-00017l-4G; Tue, 24 Oct 2023 13:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvL8d-00016z-46; Tue, 24 Oct 2023 13:24:19 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qvL8X-0000ln-1N; Tue, 24 Oct 2023 13:24:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E4A6218E6;
 Tue, 24 Oct 2023 17:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698168251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDq/IpA9fKQI4BibawQP3yNLkUORWRGAzpTNl71Zpw4=;
 b=XDmF0vx5kLRVydFWE5sdfQwEnITYr7JqKV7PgbsXruvB22zYVxOU4QmlCnuwCdpCqzyQB/
 n4Xo1pPu2rHaVkWsvAc2ftEcRLA3hvKxZ5dk695pA6mUkU5yoqndvRcX6u2epx7zn6ZgxJ
 bkbHIJo8QTbFGBz3awaOcQaKex4wzkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698168251;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDq/IpA9fKQI4BibawQP3yNLkUORWRGAzpTNl71Zpw4=;
 b=W1nuhS4zM5LykVHNEogULBb/1Q1D20RlFCttCawQmTfA3pIqEm/KwTeZtsZ1TjmUqwAgrd
 xBIIFodZNvT61hBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5BDD134F5;
 Tue, 24 Oct 2023 17:24:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RzswHLr9N2UEBwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 24 Oct 2023 17:24:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P?=
 =?utf-8?Q?_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Stefan Hajnoczi <stefanha@redhat.com>, Peter
 Xu <peterx@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 01/12] qemu-file: We only call qemu_file_transferred_*
 on the sending side
In-Reply-To: <20231024151042.90349-2-quintela@redhat.com>
References: <20231024151042.90349-1-quintela@redhat.com>
 <20231024151042.90349-2-quintela@redhat.com>
Date: Tue, 24 Oct 2023 14:24:08 -0300
Message-ID: <87a5s8szlz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -6.75
X-Spamd-Result: default: False [-6.75 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.65)[98.45%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[11];
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

Juan Quintela <quintela@redhat.com> writes:

> Remove the increase in qemu_file_fill_buffer() and add asserts to
> qemu_file_transferred* functions.

Patch looks ok, but I would rewrite the whole commit message like this:

Don't increment qemu_file_transferred at qemu_file_fill_buffer

We only call qemu_file_transferred_* on the sending side. Remove the
increment at qemu_file_fill_buffer() and add asserts to
qemu_file_transferred* functions.


