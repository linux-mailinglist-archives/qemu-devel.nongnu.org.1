Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A92BB07724
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Jul 2025 15:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc2M9-0000zm-43; Wed, 16 Jul 2025 09:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uc2Iz-0006ZV-PU
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:36:17 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uc2It-0000wY-NC
 for qemu-devel@nongnu.org; Wed, 16 Jul 2025 09:36:17 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D35F2125C;
 Wed, 16 Jul 2025 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752672968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HmJ0cGccr5jgAgYBdxObUUw2V/ryJaziqRMkzCGklI=;
 b=LXUp/vKKQU15y8UQzcxP/tYSc0wD8r3Be3ZmlLHWtVzYgvo7ggVrrN2aNRwSCzyVRQVM4R
 63Y23uZkTQ/+xJN1t8iYW+9AKFkb4nGRhge1B3UUiJXm1bKAanQpzcWx+I1pGEG0bAdBEJ
 JwQ0RCJScHA/4DhcAfB7/Gw8lnJd/40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752672968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HmJ0cGccr5jgAgYBdxObUUw2V/ryJaziqRMkzCGklI=;
 b=SZClKESOm37Grvo6D3JT0XC5PAkKpbWx9HYTLbKyZfOepqphUSKYMZ7+cCuhpmJn+TxgJL
 EGPQIaqAnHOcW4Dw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="LXUp/vKK";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SZClKESO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1752672968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HmJ0cGccr5jgAgYBdxObUUw2V/ryJaziqRMkzCGklI=;
 b=LXUp/vKKQU15y8UQzcxP/tYSc0wD8r3Be3ZmlLHWtVzYgvo7ggVrrN2aNRwSCzyVRQVM4R
 63Y23uZkTQ/+xJN1t8iYW+9AKFkb4nGRhge1B3UUiJXm1bKAanQpzcWx+I1pGEG0bAdBEJ
 JwQ0RCJScHA/4DhcAfB7/Gw8lnJd/40=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1752672968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9HmJ0cGccr5jgAgYBdxObUUw2V/ryJaziqRMkzCGklI=;
 b=SZClKESOm37Grvo6D3JT0XC5PAkKpbWx9HYTLbKyZfOepqphUSKYMZ7+cCuhpmJn+TxgJL
 EGPQIaqAnHOcW4Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D80DD13AF6;
 Wed, 16 Jul 2025 13:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Vg/uJMeqd2gcewAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 16 Jul 2025 13:36:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] migration: Fix postcopy latency distribution
 formatting computation
In-Reply-To: <CAE8KmOzrFF79P4qUOxH4UtzuymGUWTcSLQan-ee=+EaVwv2dBQ@mail.gmail.com>
References: <20250715124552.28038-1-farosas@suse.de>
 <20250715124552.28038-2-farosas@suse.de>
 <CAE8KmOzrFF79P4qUOxH4UtzuymGUWTcSLQan-ee=+EaVwv2dBQ@mail.gmail.com>
Date: Wed, 16 Jul 2025 10:36:05 -0300
Message-ID: <8734awmf5m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 6D35F2125C
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Spam-Score: -4.51
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

Prasad Pandit <ppandit@redhat.com> writes:

> On Tue, 15 Jul 2025 at 18:49, Fabiano Rosas <farosas@suse.de> wrote:
>> @@ -57,11 +57,9 @@ static const gchar *format_time_str(uint64_t us)
>>      const char *units[] = {"us", "ms", "sec"};
>>      int index = 0;
>>
>> -    while (us > 1000) {
>> +    while (us > 1000 && index + 1 < ARRAY_SIZE(units)) {
>>          us /= 1000;
>> -        if (++index >= (sizeof(units) - 1)) {
>> -            break;
>> -        }
>> +        index++;
>>      }
>>
>>      return g_strdup_printf("%"PRIu64" %s", us, units[index]);
>
> * This loop is rather confusing.
>
> * Is the while loop converting microseconds (us) to seconds with:  us
> /= 1000 ?  ie. index shall mostly be 2 = "sec", except for the range =
> 1000000 - 1000999,  when us / 1000 => 1000 would break the while loop
> and it'd return string "1000 ms".

Good catch. The condition should be >=.

> ===
> #define MS  (1000)
> #define US  (MS * 1000)
> #define NS  (US * 1000)
>
>     if (n >= NS)
>         n /= NS;
>     else if (n >= US)
>         n /= US;
>     else if (n >= MS)
>         n /= MS;
>
>     return g_strdup_printf("%"PRIu64" sec", n);
> ===
>
> * Does the above simplification look right? It shall always return
> seconds as:  "<n> sec"
>

But then that's "0 sec" for 1000000 us.

>
> Thank you.
> ---
>   - Prasad

