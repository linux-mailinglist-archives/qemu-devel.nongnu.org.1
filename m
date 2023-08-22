Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF1784037
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:01:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQ3z-000618-Cz; Tue, 22 Aug 2023 08:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQ3v-0005uA-Vc
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:00:43 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qYQ3t-0003Ok-OF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:00:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38D051F381;
 Tue, 22 Aug 2023 12:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692705639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISzfbG1SIQwoiw+JH76BLiP688InNw5dAVi360Cg75k=;
 b=DUxaJYE/d2pGxopod0Q+c/iZJC/HkgwHngtrhD7D4NAjM8wVHOOWr49Q1HZcGEssGnNRIc
 fx4Zl6e65o3hNMGtLXl/WACPF4cY6DSfLgArlP6guTaWhLMfXrsZgAsnGQIZ+xiU0hOcrl
 P1nTioVJ+iRGCeW98aUoNbKcOty674A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692705639;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISzfbG1SIQwoiw+JH76BLiP688InNw5dAVi360Cg75k=;
 b=j+b5Lp7h1sdC/cZwyZCvKaWCBaG6o3J0xrGN4Qf7vwnMsBe4PYHKOVhOlZ+VciBM1DXh0A
 OcSZAcUGrnddSLDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE62513919;
 Tue, 22 Aug 2023 12:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +i5hN2aj5GQKVgAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 22 Aug 2023 12:00:38 +0000
Message-ID: <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
Date: Tue, 22 Aug 2023 14:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V4 0/2] migration file URI
Content-Language: en-US
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
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

On 6/30/23 16:25, Steve Sistare wrote:
> Add the migration URI "file:filename[,offset=offset]".
> 
> Fabiano Rosas has submitted the unit tests in the series 
>   migration: Test the new "file:" migration
> 
> Steve Sistare (2):
>   migration: file URI
>   migration: file URI offset
> 
>  migration/file.c       | 103 +++++++++++++++++++++++++++++++++++++++++++++++++
>  migration/file.h       |  14 +++++++
>  migration/meson.build  |   1 +
>  migration/migration.c  |   5 +++
>  migration/trace-events |   4 ++
>  qemu-options.hx        |   7 +++-
>  6 files changed, 133 insertions(+), 1 deletion(-)
>  create mode 100644 migration/file.c
>  create mode 100644 migration/file.h
> 


