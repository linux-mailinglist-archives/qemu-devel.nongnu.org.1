Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FE378D60D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:11:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbKxU-0001ME-6f; Wed, 30 Aug 2023 09:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qbKxR-0001Ln-K8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:10:05 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qbKxP-0000P0-27
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:10:05 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4BC8E1F45F;
 Wed, 30 Aug 2023 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693400997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avZcAc/KkOdXvapZZKqgTRvLBMkNUQrOw8aMPjikbP0=;
 b=K1bet8MNZ8nNy+U4AgAuuocgGKJh2XVbo7FQio2RYTh9Ntoqh98igSPeBSizW7z4IZCBu9
 xgChCG5MZ0OOT9OxIA5AH4TDIswjNJJ+JhqUQkW6KcWW97URFhgBhUc0C8aaV3bycBEDsa
 M7cHmiTWH2mYcr70yJG95FhC8K3TNgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693400997;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avZcAc/KkOdXvapZZKqgTRvLBMkNUQrOw8aMPjikbP0=;
 b=d8YGIMWYkTz+nOSXwwabX02PPxLXTN4cE8neGs2DrdWUSXlUByf6uSy1Bo0XwL84zN+OWm
 9bJE2Fx23gyXCuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F040613441;
 Wed, 30 Aug 2023 13:09:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bxYkOaQ/72SVXgAAMHmgww
 (envelope-from <cfontana@suse.de>); Wed, 30 Aug 2023 13:09:56 +0000
Message-ID: <2f5b9774-e089-3606-905a-8b991dcc5e87@suse.de>
Date: Wed, 30 Aug 2023 15:09:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V4 0/2] migration file URI
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1688135108-316997-1-git-send-email-steven.sistare@oracle.com>
 <dba1e07d-6ebf-9329-7be7-4702ff5dc16d@suse.de>
 <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <1290963e-9f63-fc70-6729-d355d247c2fd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/22/23 15:25, Philippe Mathieu-Daudé wrote:
> Hi Claudio,
> 
> On 22/8/23 14:00, Claudio Fontana wrote:
>> Hello,
>>
>> this series is all reviewed,
>>
>> and is needed as a precondition for further work to improve dramatically the performance of virsh save, virsh restore
>> when migrating to disk, can it be merged?
> 
> $ ./scripts/get_maintainer.pl -f migration/meson.build
> Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> qemu-devel@nongnu.org (open list:All patches CC here)
> 
> One maintainer, one single point of failure. When the
> maintainer is busy or offline (vacations?) then everybody
> is stuck.
> 
> This is usually solved by adding co-maintainers.
> 
> Juan, would you accept having co-maintainers helping you
> dealing with the merge process? I'm not volunteering, but
> this can be a good opportunity to make a formal request to
> the community.
> 
> Regards,
> 
> Phil.
> 

Thanks Philippe,

I would like to highlight to the QEMU community here how important this is for SUSE,

to see progress for all the series in the migration area that are currently still waiting and competing for attention.

The specific features and improvements we are developing or helping to review are a priority for us,
and we are concerned about the rate of progress with the existing governance processes.

Fabiano is investing a lot of his attention to this area, with features, bugfixes and reviews,
but of course it is up to the community as a whole to address the issue so that reviewed work is merged.

My attempt here is to make sure that it is recognized as a problem, so it can be hopefully be addressed by the community in a timely fashion,
and we can all benefit from the already developed and reviewed work that is pending.

Thanks!

CLaudio


