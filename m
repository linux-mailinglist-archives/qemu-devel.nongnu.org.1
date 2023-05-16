Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BF17051C2
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:14:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywMx-0005Zz-VR; Tue, 16 May 2023 11:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1pywMt-0005Zg-B4
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:13:39 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1pywMr-0004Gk-Ob
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:13:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E8391FF5E;
 Tue, 16 May 2023 15:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1684250014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrNWFt99dXBB4SOQOjaYFirhHHYEebrbMRguni+V0p8=;
 b=hR/Rgoeh0GDGGPloT5/x78GS8llyhpOXaHQr3fWimKXeBpA0psuZUu6LlfuT5R7PHvmUXW
 9W4Ez010SO4m5MzPgAm7E7izj1k92U2zZeqjankO8vhZTwacO8yYKG6zdMu6VRlif50urC
 nfSjWk02AoGPyX8Ac1AUDdMHyTsG0sE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1684250014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lrNWFt99dXBB4SOQOjaYFirhHHYEebrbMRguni+V0p8=;
 b=5TLZBB8cyQK+QqyWX28OMPh7+Srsk3w3TO+SrUUIByNX31K9iXc1vZ3RURdM+LDBh5RvBR
 +sjUJYYgFnPlCgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8767D138F9;
 Tue, 16 May 2023 15:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xzz5Gp6dY2RqfwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 16 May 2023 15:13:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eesposit@redhat.com,
 vsementsov@yandex-team.ru
Subject: Re: Question about QMP and BQL
In-Reply-To: <ZGIxOOucbBsS1jwi@redhat.com>
References: <87h6sh2zug.fsf@suse.de> <ZGIxOOucbBsS1jwi@redhat.com>
Date: Tue, 16 May 2023 12:13:33 -0300
Message-ID: <87r0rg71ia.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 12.05.2023 um 20:01 hat Fabiano Rosas geschrieben:
>> Is there a way to execute a long-standing QMP command outside of the
>> BQL?
>> 
>> The situation we're seeing is a slow query-block due to a slow system
>> call (fstat over NFS) causing the main thread to spend too long
>> holding the global mutex and locking up the vcpu thread when it goes
>> out of the guest for MMIO.
>> 
>> The call chain for QMP is:
>> 
>> qmp_query_block
>> bdrv_query_info
>> bdrv_block_device_info
>> bdrv_query_image_info
>> bdrv_do_query_node_info
>> bdrv_get_allocated_file_size
>> bdrv_poll_co <- Waiting with qemu_global_mutex locked
>> 
>> [coroutine] bdrv_co_get_allocated_file_size_entry
>> bdrv_co_get_allocated_file_size
>> raw_co_get_allocated_file_size
>> fstat <- SLOW!
>
> The first part of the right solution there should be moving fstat() to a
> worker thread like we do for other requests where we care about not
> blocking. See existing raw_thread_pool_submit() callers for examples.
>
> Note that this isn't the full solution yet. QMP still has to wait for
> bdrv_get_allocated_file_size() to return. bdrv_poll_co() runs a nested
> event loop, but it doesn't unlock the BQL.
>
> So the second part would be converting the block-block QMP handler to
> a coroutine so that it can actually yield to the main loop, which will
> then drop the BQL while waiting. We would have to be careful there to
> make sure that we don't break anything because the sets of things
> allowed inside and outside coroutines are different.
>
> Kevin

Hi Kevin,

Thank you, this is what I was looking for. I was missing the
raw_thread_pool_submit right there under my nose!

I'll put together an RFC so we can discuss the details.

