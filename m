Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 871327C54BE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:04:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqYsj-0005qH-Cp; Wed, 11 Oct 2023 09:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqYsh-0005kt-EF
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:04:07 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqYsf-0008JN-Gf
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:04:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B5631FE94;
 Wed, 11 Oct 2023 13:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697029444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DUhgCiWA7DVzUq/KLQypu793hFkP3+9y6S0tUTWDr4=;
 b=R/0mPs2+2Rsr52J3sqv/4eLfIjUvhpsl83ntfYTQaUoJmpuyKzzOvfUcN94fwVNTSkWoEz
 bSxXwcwlFPvNhx3E1CQlTfYhVulNvDal5XTI0soSxBx2D76cbV8mx3shDw8A8OzUBWJqV3
 7WsEGUUJJEXHO2+f7urWt3T5eMx5Ktw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697029444;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DUhgCiWA7DVzUq/KLQypu793hFkP3+9y6S0tUTWDr4=;
 b=5ovRUneax2R0mG6JS1d/tn6/OJB3x8QZiNTjIT1mxYo++UVtH8OLT9tvo8+ZonGzdJDspA
 T1DesrnKW817UnAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1651138EF;
 Wed, 11 Oct 2023 13:04:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Om8nH0OdJmXnPgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 13:04:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan
 Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Leonardo Bras <leobras@redhat.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PULL 06/65] tests/qtest: migration: Add support for negative
 testing of qmp_migrate
In-Reply-To: <20231011092203.1266-7-quintela@redhat.com>
References: <20231011092203.1266-1-quintela@redhat.com>
 <20231011092203.1266-7-quintela@redhat.com>
Date: Wed, 11 Oct 2023 10:04:01 -0300
Message-ID: <87wmvt1fb2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

> From: Fabiano Rosas <farosas@suse.de>
>
> There is currently no way to write a test for errors that happened in
> qmp_migrate before the migration has started.
>
> Add a version of qmp_migrate that ensures an error happens. To make
> use of it a test needs to set MigrateCommon.result as
> MIG_TEST_QMP_ERROR.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <20230712190742.22294-6-farosas@suse.de>
> ---

Hi Juan,

What's the plan for the last patch in that series? The one that adds the
actual test:
[PATCH v5 6/6] tests/qtest: migration-test: Add tests for file-based migration
https://lore.kernel.org/r/20230712190742.22294-7-farosas@suse.de

I'm trying to keep track of what's merged and what's not because I have
more patches on top of it to send.

Thanks!

