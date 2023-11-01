Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D95EC7DE5E7
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 19:16:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyFjl-0007F4-0c; Wed, 01 Nov 2023 14:14:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyFji-0007Ec-DF
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 14:14:38 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qyFjg-0002r1-Ot
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 14:14:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 385BB21850;
 Wed,  1 Nov 2023 18:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698862475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvycZSImFG44hzrOzYRIctNFtPAQEvLG8sGfLh3lPlE=;
 b=T+qaPMQAiyTPKcmBiykka2Vm0Cu1ebuMRVkMcCenG0P49R1Ax2TCI+SwMXoBB3twYuReQ6
 v/XCykfAcCUNkTc+QPwzh2+3dBar5KGHzN1OTNGSA6FX0SZ21u6u8+21+KIb99kAA944bf
 TWuW6tJHcTORX7mmutOGvmqX4IJqPWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698862475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvycZSImFG44hzrOzYRIctNFtPAQEvLG8sGfLh3lPlE=;
 b=std3L6tNwpFfnwScomSK0KLa03nIK6eTox12Y/ksixDqWv5kokZOn8LILSA3mHlxJR0hfM
 gx8OFBvrGbN/LtBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE1A613460;
 Wed,  1 Nov 2023 18:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zuotIoqVQmWybwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 01 Nov 2023 18:14:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Juan
 Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v2 21/29] migration/multifd: Add pages to the receiving
 side
In-Reply-To: <ZUKMSQEcYlXRej01@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-22-farosas@suse.de> <ZUF7VG+CWvuOEbqD@x1n>
 <87il6mcrf5.fsf@suse.de> <ZUJ01lcAJS1PaAIw@x1n> <87msvxfl0f.fsf@suse.de>
 <ZUKMSQEcYlXRej01@x1n>
Date: Wed, 01 Nov 2023 15:14:32 -0300
Message-ID: <87il6lfiif.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Nov 01, 2023 at 02:20:32PM -0300, Fabiano Rosas wrote:
>> I wonder if adapting multifd to use a QIOTask for the channels would
>> make sense as an intermediary step. Seems simpler and would force us to
>> format multifd in more generic terms.
>
> Isn't QIOTask event based, too?
>
> From my previous experience, making it not gcontext based, if we already
> have threads, are easier.  But maybe I didn't really get what you meant.

Sorry, I wasn't thinking about the context aspect. I agree it's easier
without it.

I was talking about having standardized dispatch and completion code for
multifd without being a whole thread pool. So just something that takes
a function and a pointer to data, runs that in a thread with some
locking and returns in a sane way. Every thread we create in the
migration code has a different mechanism to return after an error and a
different way to do cleanup. The QIOTask seemed to fit that at a high
level.

I would be happy with just the return + cleanup part really. We've been
doing work around those areas for a while. If we could reuse generic
code for that it would be nice.

