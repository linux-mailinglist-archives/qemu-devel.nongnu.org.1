Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 173587A527F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 21:00:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiJTv-0001I6-7v; Mon, 18 Sep 2023 15:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiJTr-0001HK-Tf
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 15:00:23 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiJTq-0007fe-Df
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 15:00:23 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05FF3200DC;
 Mon, 18 Sep 2023 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695063620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XL5otRJjUf1Otyze+7C+TP+aqrsYaUOQfMNz4yCAO4U=;
 b=HbwFZvpqhNrbbyHLWy1t2sUux6fWcLUdEokhHPRg8ldOCZTmzYVctQwrnnSdZw9Mrt7uev
 OVvIvnV+Zb0IBDhlM5pSoH3iMIcLYAmuZH1ckL3ptRkg4ifqikJlcGVfdh364GQTkmpWf9
 Z12pTtqHK8K2v087lrwGm5esz3cnepA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695063620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XL5otRJjUf1Otyze+7C+TP+aqrsYaUOQfMNz4yCAO4U=;
 b=MOCIxOCC1MU21UA4vLqQLocKbd1Hicod/TZWbPWe1U+jSVAxa6LkDdMp6WpR8PSToFzzZl
 +6O2mclpHBtnT1Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D0ED13480;
 Mon, 18 Sep 2023 19:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LVz6FUOeCGWXPwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 19:00:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 18/52] migration/rdma: Fix
 qemu_rdma_broken_ipv6_kernel() to set error
In-Reply-To: <20230918144206.560120-19-armbru@redhat.com>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-19-armbru@redhat.com>
Date: Mon, 18 Sep 2023 16:00:17 -0300
Message-ID: <87r0mvxq66.fsf@suse.de>
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

Markus Armbruster <armbru@redhat.com> writes:

> qemu_rdma_resolve_host() and qemu_rdma_dest_init() try addresses until
> they find on that works.  If none works, they return the first Error
> set by qemu_rdma_broken_ipv6_kernel(), or else return a generic one.
>
> qemu_rdma_broken_ipv6_kernel() neglects to set an Error when
> ibv_open_device() fails.  If a later address fails differently, we use
> that Error instead, or else the generic one.  Harmless enough, but
> needs fixing all the same.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>


