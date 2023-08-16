Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8403E77E155
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:20:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFUI-0003nh-Hf; Wed, 16 Aug 2023 08:18:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWFUG-0003gU-Gi
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:18:56 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWFUD-0004f6-Qu
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:18:56 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFB9A1F74C;
 Wed, 16 Aug 2023 12:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692188331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcGrgKCc/I/lDrXprRdT9A43u49O4+Ap6caNTilrPRE=;
 b=IeTu72bLopp3oj1E9DD2gbDdR/5ghYTJkG//FlkgkWUgN6LExLmf4YQeHDtXy7n/jJCqJB
 eI2vhZr2mguyJjYOHfaAWDNHnBBmxFFM0wNvq7sLEBnm+XMA9kne/3ysFywdvuD2bOnuGD
 gjUG+m4FfBT5ptMts7kydZVqrPvIuCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692188331;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lcGrgKCc/I/lDrXprRdT9A43u49O4+Ap6caNTilrPRE=;
 b=CpILh3YN3lUY79YShnr9sb7USRzktqs7yza3o+QKpHLeJYNbgvitTmgMaiAfErEQVK9KqY
 Z11Mp+orCx5jSdAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FE621353E;
 Wed, 16 Aug 2023 12:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id f/TmAqu+3GRHMgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 12:18:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Guoyi Tu <tugy@chinatelecom.cn>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return
 if qemu file got error
In-Reply-To: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
Date: Wed, 16 Aug 2023 09:18:48 -0300
Message-ID: <87ttszkwnr.fsf@suse.de>
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

Guoyi Tu <tugy@chinatelecom.cn> writes:

> When the migration process of a virtual machine using huge pages is 
> cancelled,
> QEMU will continue to complete the processing of the current huge page
> through the qemu file object got an error set. These processing, such as
> compression and encryption, will consume a lot of CPU resources which may
> affact the the performance of the other VMs.
>
> To terminate the migration process more quickly and minimize unnecessary
> resource occupancy, it's neccessary to add logic to check the error status
> of qemu file object in the beginning of ram_save_target_page_legacy 
> function,
> and make sure the function returns immediately if qemu file got an error.
>
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>

Ok, you're off the hook because the qemu_file_*_error situation is a
preexisting mess. We don't need to complicate this further.

Let's go with this patch as it is.

Reviewed-by: Fabiano Rosas <farosas@suse.de>

