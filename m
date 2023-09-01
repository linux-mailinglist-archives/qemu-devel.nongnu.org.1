Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C11D979020C
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 20:31:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc8uI-0003VF-B1; Fri, 01 Sep 2023 14:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qc8uG-0003Ud-Lq
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:30:09 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qc8u3-0005Nm-Pr
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 14:30:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 505D91F45E;
 Fri,  1 Sep 2023 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693592994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjeODI2itHhguZDPIAe/KtIu6Wj2Vi0GInu9PZvylf4=;
 b=yxePB7OdzXVhPs89RHjSORpMUBRfFiice+mV/9MIWzryN+eogoxfAriJIKpmTACn42oiS4
 HmxaaNoUXBM1bwdaJdtqigk4kRH8AKPn3YFKxEecDH0s/YRCARme1FREmBN9DYuJ++TexE
 YGXf4zjIZpowxUt377VdITvIG5yATnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693592994;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LjeODI2itHhguZDPIAe/KtIu6Wj2Vi0GInu9PZvylf4=;
 b=U13JVFYNEmn+DeNfGoj0pNbF7Nzy0Vr0tHBpIOmkSzqr31k5OfaS7TFjFnHojU8DEhnTZh
 3dqIh3Km5XI8haBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6BC413582;
 Fri,  1 Sep 2023 18:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZqTrJ6Et8mQrUAAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 01 Sep 2023 18:29:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Wei Wang
 <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>, Lukas Straub
 <lukasstraub2@web.de>
Subject: Re: [PATCH v5 8/8] migration: Add a wrapper to cleanup migration files
In-Reply-To: <ZPILtYXBVVCKDlWX@x1n>
References: <20230831183916.13203-1-farosas@suse.de>
 <20230831183916.13203-9-farosas@suse.de> <ZPILtYXBVVCKDlWX@x1n>
Date: Fri, 01 Sep 2023 15:29:51 -0300
Message-ID: <878r9pagrk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

> On Thu, Aug 31, 2023 at 03:39:16PM -0300, Fabiano Rosas wrote:
>> @@ -1166,16 +1183,9 @@ static void migrate_fd_cleanup(MigrationState *s)
>>          qemu_mutex_lock_iothread();
>>  
>>          multifd_save_cleanup();
>> -        qemu_mutex_lock(&s->qemu_file_lock);
>> -        tmp = s->to_dst_file;
>> -        s->to_dst_file = NULL;
>> -        qemu_mutex_unlock(&s->qemu_file_lock);
>> -        /*
>> -         * Close the file handle without the lock to make sure the
>> -         * critical section won't block for long.
>> -         */
>> -        migration_ioc_unregister_yank_from_file(tmp);
>> -        qemu_fclose(tmp);
>> +
>> +        migration_ioc_unregister_yank_from_file(s->to_dst_file);
>
> I think you suggested that we should always take the file lock when
> operating on them, so this is slightly going backwards to not hold any lock
> when doing it. But doing so in migrate_fd_cleanup() is probably fine (as it
> serializes with bql on all the rest qmp commands, neither should migration
> thread exist at this point).  Your call; it's still much cleaner.

I think I was mistaken. We need the lock on the thread that clears the
pointer so that we can safely dereference it on another thread under the
lock.

Here we're accessing it from the same thread that later does the
clearing. So that's a slightly different problem.

