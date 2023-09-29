Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F127B36D5
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 17:30:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmFRE-0000p8-Me; Fri, 29 Sep 2023 11:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmFR7-0000hZ-9i
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:29:49 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qmFR5-00047t-NP
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 11:29:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05CCA210EF;
 Fri, 29 Sep 2023 15:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696001386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPWypuUrgCmOcb5cWFYyXKKJOUNLztz4gxNPAD9s1KM=;
 b=P5u60B4VQGl5xcXRwgPj/h73Fm+e2yW7ssUZ1ZvFaWhM/OoX/e/lvYMY26sLhz/ANmhdC8
 OepydYfMtNvjNeNIQEEXMWc0JQMaUIwoclGZSruPbfzQCjXnQQI63QbGX3RmwCweEqcmCX
 pGao7Q1bHtBcAFzmbSH2wJ1V1hSZTQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696001386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPWypuUrgCmOcb5cWFYyXKKJOUNLztz4gxNPAD9s1KM=;
 b=yYlY701TftUxUFhIYI0uZCFu9gSqcv9G2b4mBWoFhbrB1LMLm8fUuCOvNO3Jpe9S4QYzzM
 RSH5c5HU5jdwZDAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8ECF813434;
 Fri, 29 Sep 2023 15:29:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aTKZFmntFmWcOQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 29 Sep 2023 15:29:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 lizhijian@fujitsu.com, eblake@redhat.com
Subject: Re: [PATCH v2 51/53] migration/rdma: Downgrade qemu_rdma_cleanup()
 errors to warnings
In-Reply-To: <20230928132019.2544702-52-armbru@redhat.com>
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-52-armbru@redhat.com>
Date: Fri, 29 Sep 2023 12:29:43 -0300
Message-ID: <87pm21yp3s.fsf@suse.de>
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

Markus Armbruster <armbru@redhat.com> writes:

> Functions that use an Error **errp parameter to return errors should
> not also report them to the user, because reporting is the caller's
> job.  When the caller does, the error is reported twice.  When it
> doesn't (because it recovered from the error), there is no error to
> report, i.e. the report is bogus.
>
> qemu_rdma_source_init(), qemu_rdma_connect(),
> rdma_start_incoming_migration(), and rdma_start_outgoing_migration()
> violate this principle: they call error_report() via
> qemu_rdma_cleanup().
>
> Moreover, qemu_rdma_cleanup() can't fail.  It is called on error
> paths, and QIOChannel close and finalization.  Are the conditions it
> reports really errors?  I doubt it.
>
> Downgrade qemu_rdma_cleanup()'s errors to warnings.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

