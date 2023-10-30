Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4497DBB30
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:58:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSmQ-0007CS-Fg; Mon, 30 Oct 2023 09:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxSmO-00076K-44
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:58:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxSmL-0001ou-Tj
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:58:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9470F219A6;
 Mon, 30 Oct 2023 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698674283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlSKkxCSH7FfifS+puSzBcBhskASGvDEc/E4xTyilgo=;
 b=0cCAU0f7yD5edL85p04M//cVYHVsLzjKdiO4JZeTnd+BZ5hHurHNXb/KHl+N7HPrh+p+Xt
 uvdFmc2idlCKvBtlmOAnBiAR/9X84KwkMuGQzd+CAIsEdZO99VzaZTm7znVBuWs5VSFngT
 OaN0c1YlMhz1I07VmC2+fkwc1iLRKeE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698674283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NlSKkxCSH7FfifS+puSzBcBhskASGvDEc/E4xTyilgo=;
 b=dvGwHcG8F4uAajOZcx0WS45pvIWyouqRp/QgAvGPtzpafSRieEwGB6VNTE3RJlMoOcGubs
 9LTh6GOf6ULFW8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 281DC138F8;
 Mon, 30 Oct 2023 13:58:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xyNEOWq2P2UNLgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 30 Oct 2023 13:58:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: quintela@redhat.com, peterx@redhat.com, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Subject: Re: [External] Re: [PATCH 01/16] Cherry pick a set of patches that
 enables multifd zero page feature.
In-Reply-To: <CAAYibXh+E-ZJ7SKMJie=NG8x8_hP9B5AxYZMXxXY2cK9QuuPrw@mail.gmail.com>
References: <20231025193822.2813204-1-hao.xiang@bytedance.com>
 <20231025193822.2813204-2-hao.xiang@bytedance.com>
 <87zg041c42.fsf@suse.de>
 <CAAYibXh+E-ZJ7SKMJie=NG8x8_hP9B5AxYZMXxXY2cK9QuuPrw@mail.gmail.com>
Date: Mon, 30 Oct 2023 10:58:00 -0300
Message-ID: <87msw0nrfb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hao Xiang <hao.xiang@bytedance.com> writes:

> On Fri, Oct 27, 2023 at 5:30=E2=80=AFAM Fabiano Rosas <farosas@suse.de> w=
rote:
>>
>> Hao Xiang <hao.xiang@bytedance.com> writes:
>>
>> > Juan Quintela had a patchset enabling zero page checking in multifd
>> > threads.
>> >
>> > https://lore.kernel.org/all/20220802063907.18882-13-quintela@redhat.co=
m/
>>
>> Hmm, risky to base your series on code more than an year old. We should
>> bother Juan so he sends an updated version for review.
>>
>> I have concerns about that series. First is why are we doing payload
>> processing (i.e. zero page detection) in the multifd thread. And that
>> affects your series directly, because AFAICS we're now doing more
>> processing still.
>>
>
> I am pretty new to QEMU so my take could be wrong. We can wait for Juan
> to comment here. My understanding is that the migration main loop was ori=
ginally
> designed to handle single sender thread (before multifd feature). Zero
> page checking
> is a pretty CPU intensive operation. So in case of multifd, we scaled
> up the number
> of sender threads in order to saturate network traffic.

Right. That's all fine.

> Doing zero page checking in the
> main loop is not going to scale with this new design.

Yep. Moving work outside of the main loop is reasonable. Juan is
focusing on separating the migration code from the QEMUFile internals,
so moving zero page into multifd is a step in the right direction from
that perspective.

> In fact, we
> (Bytedance) has merged
> Juan's change into our internal QEMU and we have been using this
> feature since last
> year. I was told that it improved performance pretty significantly.
> Ideally, I would love to
> see zero page checking be done in a separate thread pool so we can
> scale it independently
> from the sender threads but doing it in the sender thread is an
> inexpensive way to scale.

Yep, you got the point. And I acknowledge that reusing the sender
threads is the natural next step. Even if we go that route, let's make
sure it still leaves us space to separate pre-processing from actual
sending.

