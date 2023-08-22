Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6DC78404A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQ82-00005U-9W; Tue, 22 Aug 2023 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQ7t-000055-QC
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:04:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQ7r-0004AY-AY
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:04:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EDD522AEB;
 Tue, 22 Aug 2023 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692705885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNl/huXxOYu7qkBPOTzKNjAfe3JrqaHiDAcqQ9PMzpU=;
 b=JTvNARb9Q1IKtOJru5pA9cZyLWRJhMkrhFYJJV+fI/nYrsU/DcY3e6YcQqG4HnQ6GQvLpv
 CKyoYdmQaQHDar83VI1D4H1FikJclgs6AYWDWNC9IrUDF8YG4BFZFED2rfIPnSaNkCJ71a
 c7RchlzjX/Z/QosgsMgyqhHvO6qMtzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692705885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNl/huXxOYu7qkBPOTzKNjAfe3JrqaHiDAcqQ9PMzpU=;
 b=U7QAIS7q9rYN4ffz2u2mts7T4UHx5X6IjtcDLr20ftk8EquVbJ8RKoeMGx9VUgckgB2utX
 /45OlpJBRw4aLVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C84313919;
 Tue, 22 Aug 2023 12:04:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id d/MKFV2k5GQBWAAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 22 Aug 2023 12:04:45 +0000
Message-ID: <c03fb943-3280-0de9-c683-6f4329f1c8b8@suse.de>
Date: Tue, 22 Aug 2023 14:04:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v5 0/6] migration: Test the new "file:" migration
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230712190742.22294-1-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230712190742.22294-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.28; envelope-from=cfontana@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

Hello,

this series is all reviewed,

and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
when migrating to disk, can it be merged?

Thanks,

Claudio

On 7/12/23 21:07, Fabiano Rosas wrote:
> Based-on:
> [PATCH V4 0/2] migration file URI
> https://lore.kernel.org/r/1688135108-316997-1-git-send-email-steven.sistare@oracle.com
> 
> Since v4:
> 
> - Implemented a separate version of test_precopy_common to be used
>   with the file transport (patch 6).
> 
> v4:
> https://lore.kernel.org/r/20230706201927.15442-1-farosas@suse.de
> 
> v3:
> https://lore.kernel.org/r/20230630212902.19925-1-farosas@suse.de
> 
> v2:
> https://lore.kernel.org/r/20230628165542.17214-1-farosas@suse.de
> 
> v1:
> https://lore.kernel.org/r/20230626182210.8792-1-farosas@suse.de
> 
> Fabiano Rosas (6):
>   tests/qtest: migration: Expose migrate_set_capability
>   tests/qtest: migration: Add migrate_incoming_qmp helper
>   tests/qtest: migration: Use migrate_incoming_qmp where appropriate
>   migration: Set migration status early in incoming side
>   tests/qtest: migration: Add support for negative testing of
>     qmp_migrate
>   tests/qtest: migration-test: Add tests for file-based migration
> 
>  migration/migration.c             |   7 +-
>  tests/qtest/libqtest.c            |  33 ++++++
>  tests/qtest/libqtest.h            |  28 +++++
>  tests/qtest/meson.build           |   1 +
>  tests/qtest/migration-helpers.c   |  60 ++++++++++
>  tests/qtest/migration-helpers.h   |  10 ++
>  tests/qtest/migration-test.c      | 185 ++++++++++++++++++++++++++----
>  tests/qtest/virtio-net-failover.c |  77 ++-----------
>  8 files changed, 308 insertions(+), 93 deletions(-)
> 


