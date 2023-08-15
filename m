Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4B77D5DC
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:20:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2OG-0005YS-GE; Tue, 15 Aug 2023 18:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW2OE-0005Y2-Ou
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:19:50 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW2OC-0008Sg-Jw
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:19:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D7041F8C1;
 Tue, 15 Aug 2023 22:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692137986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yb45OuauGZ0fplukFV/zwt4fSRviDXpC7V8CXdyaGLQ=;
 b=aMq/6++MzfhJUtXTffRZMv5z/wjYD2MJyQqylWpJe69XNTNR8x8wVXF8+sMV+dCwrOaZ1x
 tn8Hv8K3eXpFotsv0CN8/dYOvDn//s9SQE6yOg969JO/UJZUwKterODTZ7QWZNSCNHhH4X
 dI5NwhZRF7RonwY4Yo7RzEPlXOTtRc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692137986;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yb45OuauGZ0fplukFV/zwt4fSRviDXpC7V8CXdyaGLQ=;
 b=LPxuZEvHzGmEV2Rd/j6dN5UeRGeB1u6407uPaVbaB4dFZFygFlq8tAUgpJ9DwGFOluVucP
 ypYK27ihHLe8SGCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF26313909;
 Tue, 15 Aug 2023 22:19:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AfwvLQH622QSKQAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 22:19:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v3 09/10] migration: Be consistent about shutdown of
 source shared files
In-Reply-To: <ZNv3Yx1qn84V2dYJ@x1n>
References: <20230811150836.2895-1-farosas@suse.de>
 <20230811150836.2895-10-farosas@suse.de> <ZNv3Yx1qn84V2dYJ@x1n>
Date: Tue, 15 Aug 2023 19:19:43 -0300
Message-ID: <878raclzi8.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Aug 11, 2023 at 12:08:35PM -0300, Fabiano Rosas wrote:
>> When doing cleanup, we currently close() some of the shared migration
>> files and shutdown() + close() others. Be consistent by always calling
>> shutdown() before close().
>> 
>> Do this only for the source files for now because the source runs
>> multiple threads which could cause races between the two calls. Having
>> them together allows us to move them to a centralized place under the
>> protection of a lock the next patch.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Logically I think we should only need shutdown() when we don't want to
> close immediately, or can't for some reason..  Maybe instead of adding
> shutdown()s, we can remove some?

Wouldn't shutdown() affect what the other end of the socket sees? I
thought we used shutdown() before close() as a way to end the connection
in a cleaner manner.

