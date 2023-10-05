Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD587BAE90
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 00:03:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoWPn-0001vg-Il; Thu, 05 Oct 2023 18:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoWPP-0001vF-TL
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 18:01:30 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qoWPM-00034n-Jj
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 18:01:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 42FE21F853;
 Thu,  5 Oct 2023 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696543282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ucNrq8ADqJf2q7fVXEC54h5/25ThUZw01stDgnPRIuY=;
 b=Qsr2wTQDBj4VH+00jsb8w6NVZTj0zu8mW1Tkjnx9sr8VqA6cIj8CPrNc9J30aYxVUGJXcV
 0/P7PHRIY5owtVwlcP3vF9PTGUCGLi5M8lCPZBwYx/Xrvw27f1UvHguTFw10CWCafCU6ed
 TWkZqhbyIr+hKE/vp5zRhksXy1q6UmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696543282;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ucNrq8ADqJf2q7fVXEC54h5/25ThUZw01stDgnPRIuY=;
 b=OlDHSLzgE1xxs9xHXWoZ0lankg/osjDj2X2OmSq9ol7FYh+B1PhpZMfjtUB7CWu3QTj0NP
 5aYa3B3MgKSf+6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9DC213438;
 Thu,  5 Oct 2023 22:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1UQeJTEyH2UaCwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 05 Oct 2023 22:01:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v3 10/10] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <ZR8uMcN5WwA2kC9k@x1n>
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-11-peterx@redhat.com> <87edi9fbh5.fsf@suse.de>
 <878r8hfavf.fsf@suse.de> <ZR8iwwOeXWI+x9YX@x1n> <875y3kg4hv.fsf@suse.de>
 <ZR8uMcN5WwA2kC9k@x1n>
Date: Thu, 05 Oct 2023 19:01:19 -0300
Message-ID: <87zg0wenkg.fsf@suse.de>
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Oct 05, 2023 at 06:10:20PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Oct 05, 2023 at 10:37:56AM -0300, Fabiano Rosas wrote:
>> >> >> +    /*
>> >> >> +     * Make sure both QEMU instances will go into RECOVER stage, then test
>> >> >> +     * kicking them out using migrate-pause.
>> >> >> +     */
>> >> >> +    wait_for_postcopy_status(from, "postcopy-recover");
>> >> >> +    wait_for_postcopy_status(to, "postcopy-recover");
>> >> >
>> >> > Is this wait out of place? I think we're trying to resume too fast after
>> >> > migrate_recover():
>> >> >
>> >> > # {
>> >> > #     "error": {
>> >> > #         "class": "GenericError",
>> >> > #         "desc": "Cannot resume if there is no paused migration"
>> >> > #     }
>> >> > # }
>> >> >
>> >> 
>> >> Ugh, sorry about the long lines:
>> >> 
>> >> {
>> >>     "error": {
>> >>         "class": "GenericError",
>> >>         "desc": "Cannot resume if there is no paused migration"
>> >>     }
>> >> }
>> >
>> > Sorry I didn't get you here.  Could you elaborate your question?
>> >
>> 
>> The test is sometimes failing with the above message.
>> 
>> But indeed my question doesn't make sense. I forgot migrate_recover
>> happens on the destination. Nevermind.
>> 
>> The bug is still present nonetheless. We're going into migrate_prepare
>> in some state other than POSTCOPY_PAUSED.
>
> Oh I see.  Interestingly I cannot reproduce on my host, just like last
> time..
>
> What is your setup for running the test?  Anything special?  Here's my
> cmdline:

The crudest oneliner:

for i in $(seq 1 9999); do echo "$i ============="; \
QTEST_QEMU_BINARY=./qemu-system-x86_64 \
./tests/qtest/migration-test -r /x86_64/migration/postcopy/recovery || break ; done

I suspect my system has something specific to it that affects the timing
of the tests. But I have no idea what it could be.

$ lscpu       
Architecture:            x86_64      
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         39 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  16
  On-line CPU(s) list:   0-15
Vendor ID:               GenuineIntel
  Model name:            11th Gen Intel(R) Core(TM) i7-11850H @ 2.50GHz
    CPU family:          6
    Model:               141
    Thread(s) per core:  2
    Core(s) per socket:  8
    Socket(s):           1
    Stepping:            1
    CPU max MHz:         4800.0000
    CPU min MHz:         800.0000
    BogoMIPS:            4992.00

>
> $ cat reproduce.sh 
> index=$1
> loop=0
>
> while :; do
>         echo "Starting loop=$loop..."
>         QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/postcopy/recovery/double-failures
>         if [[ $? != 0 ]]; then
>                 echo "index $index REPRODUCED (loop=$loop) !"
>                 break
>         fi
>         loop=$(( loop + 1 ))
> done
>
> Survives 200+ loops and kept going.
>
> However I think I saw what's wrong here, could you help try below fixup?
>

Sure. I won't get to it until tomorrow though.

