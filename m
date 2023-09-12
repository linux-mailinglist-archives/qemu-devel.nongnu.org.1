Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6379C128
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 02:33:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfrLK-0000Yg-RJ; Mon, 11 Sep 2023 20:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfrLI-0000GB-23
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:33:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfrLF-0004Sa-UF
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 20:33:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 910CB2185A;
 Tue, 12 Sep 2023 00:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694478799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQN+RIgvOznpcyhW6SKmS3BsoNO5okh361nhL17mHBE=;
 b=VLt2+wgj6ll5Ye+8n0glHevLtuRdHBEf7Exe3ZSFqXUdNHWMfav3BeKviVsB0/uzwhSU9/
 wBtUOHYBRjQbWPuRGNsLNUI5q5A0D881P9rPuoVYCtaoPit4BBxtK+aaVYm+8TVJ+fjH0v
 cUMWQzX4O8RO5KixVfbos96lLVQwrbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694478799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQN+RIgvOznpcyhW6SKmS3BsoNO5okh361nhL17mHBE=;
 b=S3WIqr5WM5uw9peKHDvSJLTkWDsOJe3qf4qZJFsfbeWCsU+O9CiwJ+Q0yda6B6DusNS7hd
 epCLXBtydXTm5AAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A899D13780;
 Tue, 12 Sep 2023 00:33:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NiAZM82x/2Q2VgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 12 Sep 2023 00:33:17 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 7/9] migration: Remember num of ramblocks to sync during
 recovery
In-Reply-To: <20230829214235.69309-8-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-8-peterx@redhat.com>
Date: Mon, 11 Sep 2023 21:33:13 -0300
Message-ID: <871qf4mdrq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
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

Peter Xu <peterx@redhat.com> writes:

> Instead of only relying on the count of rp_sem, make the counter be part of
> RAMState so it can be used in both threads to synchronize on the process.
>
> rp_sem will be further reused as a way to kick the main thread, e.g., on
> recovery failures.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

