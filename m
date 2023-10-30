Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9FB7DBBFB
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:42:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTSV-0002wH-2q; Mon, 30 Oct 2023 10:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxTSK-0002Wj-M8
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:41:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxTSJ-00021Q-7L
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:41:28 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CDADE21CC1;
 Mon, 30 Oct 2023 14:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698676885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3EGv08xs8170bZ6xGB9B7lzvXE5XW0LNyiUxsQz86U=;
 b=SyzrytceDpMI7pwbNX1/TMYNdxG2riF+vHA/68FjT50saCLnnohLtmkj8CXudGaeu0+iaQ
 03V5jcQtHkpTT96uDXdve5pTAx816CuiaqkyoIWi6uqVWUGvyTvg87sbPR8Es9f9xCI11n
 g84JfJjot8KknS2/C+weuHcUD2PjsLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698676885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l3EGv08xs8170bZ6xGB9B7lzvXE5XW0LNyiUxsQz86U=;
 b=GZSdz+4tRjYWBq3JZ6HC+8T73k96l2aOBj75FFnDgHCBw3qw3EuEkTdPfig4SfeEz71nmK
 vdz56HjX8YqS7VAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 601E9138F8;
 Mon, 30 Oct 2023 14:41:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eNgXC5XAP2UITAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 30 Oct 2023 14:41:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>, quintela@redhat.com,
 peterx@redhat.com, marcandre.lureau@redhat.com, bryan.zhang@bytedance.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH 09/16] migration/multifd: Add new migration option for
 multifd DSA offloading.
In-Reply-To: <20231025193822.2813204-10-hao.xiang@bytedance.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-10-hao.xiang@bytedance.com>
Date: Mon, 30 Oct 2023 11:41:23 -0300
Message-ID: <87fs1snpf0.fsf@suse.de>
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> Intel DSA offloading is an optional feature that turns on if
> proper hardware and software stack is available. To turn on
> DSA offloading in multifd live migration:
>
> multifd-dsa-accel="[dsa_dev_path1] ] [dsa_dev_path2] ... [dsa_dev_pathX]"
>
> This feature is turned off by default.

This patch looks fine. However I wonder if wouldn't it be better to not
couple dsa with multifd in the capability name? I.e. we could add just a
dsa capability and have a check saying that it currently only works with
multifd.


