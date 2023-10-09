Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F63A7BE700
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 18:51:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qptTC-0006wS-5O; Mon, 09 Oct 2023 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qptSg-0006iB-Dk
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:50:41 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qptSU-00050l-FF
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 12:50:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 508E421885;
 Mon,  9 Oct 2023 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696870211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRZ2PsMNVS+CUwYEFGzSwichCql74f0vXhRTYueFjis=;
 b=Q8oBl/l2U/d8FzdC0bkXU2GZuW0PGfU0kbo6mRHgfQEx+d+bqGh/eeb/DxzWVlzFXOXG5X
 0ows3nootRYuQZ3nm91SURImV22e0Zs8vjWifeespXNrQH+SdIsunkKWz9IwLsUkhKrHia
 QT/GhLoo2STRKG3szCy3761NY6jzTKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696870211;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yRZ2PsMNVS+CUwYEFGzSwichCql74f0vXhRTYueFjis=;
 b=BrQ4ajFuKtRjrkJTGfik8lTEsOQRDBMDg6VQt1eNhMmKXuKLh/bM3d3cy057oaVohdCRTp
 oGzds1O/L7tKQoCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6D3F13905;
 Mon,  9 Oct 2023 16:50:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KSvmJ0IvJGVKXAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 16:50:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <87zg0wenkg.fsf@suse.de>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com> <87edi9fbh5.fsf@suse.de>
 <878r8hfavf.fsf@suse.de> <ZR8iwwOeXWI+x9YX@x1n> <875y3kg4hv.fsf@suse.de>
 <ZR8uMcN5WwA2kC9k@x1n> <87zg0wenkg.fsf@suse.de>
Date: Mon, 09 Oct 2023 13:50:08 -0300
Message-ID: <87wmvveo5b.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> On Thu, Oct 05, 2023 at 06:10:20PM -0300, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>> 
>>> > On Thu, Oct 05, 2023 at 10:37:56AM -0300, Fabiano Rosas wrote:
>>> >> >> +    /*
>>> >> >> +     * Make sure both QEMU instances will go into RECOVER stage, then test
>>> >> >> +     * kicking them out using migrate-pause.
>>> >> >> +     */
>>> >> >> +    wait_for_postcopy_status(from, "postcopy-recover");
>>> >> >> +    wait_for_postcopy_status(to, "postcopy-recover");
>>> >> >
>>> >> > Is this wait out of place? I think we're trying to resume too fast after
>>> >> > migrate_recover():
>>> >> >
>>> >> > # {
>>> >> > #     "error": {
>>> >> > #         "class": "GenericError",
>>> >> > #         "desc": "Cannot resume if there is no paused migration"
>>> >> > #     }
>>> >> > # }
>>> >> >
>>> >> 
>>> >> Ugh, sorry about the long lines:
>>> >> 
>>> >> {
>>> >>     "error": {
>>> >>         "class": "GenericError",
>>> >>         "desc": "Cannot resume if there is no paused migration"
>>> >>     }
>>> >> }
>>> >
>>> > Sorry I didn't get you here.  Could you elaborate your question?
>>> >
>>> 
>>> The test is sometimes failing with the above message.
>>> 
>>> But indeed my question doesn't make sense. I forgot migrate_recover
>>> happens on the destination. Nevermind.
>>> 
>>> The bug is still present nonetheless. We're going into migrate_prepare
>>> in some state other than POSTCOPY_PAUSED.
>>
>> Oh I see.  Interestingly I cannot reproduce on my host, just like last
>> time..
>>
>> What is your setup for running the test?  Anything special?  Here's my
>> cmdline:
>
> The crudest oneliner:
>
> for i in $(seq 1 9999); do echo "$i ============="; \
> QTEST_QEMU_BINARY=./qemu-system-x86_64 \
> ./tests/qtest/migration-test -r /x86_64/migration/postcopy/recovery || break ; done
>
> I suspect my system has something specific to it that affects the timing
> of the tests. But I have no idea what it could be.
>
> $ lscpu       
> Architecture:            x86_64      
>   CPU op-mode(s):        32-bit, 64-bit
>   Address sizes:         39 bits physical, 48 bits virtual
>   Byte Order:            Little Endian
> CPU(s):                  16
>   On-line CPU(s) list:   0-15
> Vendor ID:               GenuineIntel
>   Model name:            11th Gen Intel(R) Core(TM) i7-11850H @ 2.50GHz
>     CPU family:          6
>     Model:               141
>     Thread(s) per core:  2
>     Core(s) per socket:  8
>     Socket(s):           1
>     Stepping:            1
>     CPU max MHz:         4800.0000
>     CPU min MHz:         800.0000
>     BogoMIPS:            4992.00
>
>>
>> $ cat reproduce.sh 
>> index=$1
>> loop=0
>>
>> while :; do
>>         echo "Starting loop=$loop..."
>>         QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/postcopy/recovery/double-failures
>>         if [[ $? != 0 ]]; then
>>                 echo "index $index REPRODUCED (loop=$loop) !"
>>                 break
>>         fi
>>         loop=$(( loop + 1 ))
>> done
>>
>> Survives 200+ loops and kept going.
>>
>> However I think I saw what's wrong here, could you help try below fixup?
>>
>
> Sure. I won't get to it until tomorrow though.

It seems to have fixed the issue. 3500 iterations and still going.

