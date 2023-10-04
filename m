Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0607B8466
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:01:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4IM-0000qC-2e; Wed, 04 Oct 2023 12:00:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo4I2-0000og-FX
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:00:00 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qo4Hy-0003Fi-2w
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:59:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3039C21847;
 Wed,  4 Oct 2023 15:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696435192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4eTiVYNc8iTHVLUJRwz9wghlB+/3v6PMNh74prsOl4=;
 b=iSOnSRWFAGZzYSKM07UuZUArNQzsuTOgLUqr2j6M+ayveOyeYoI9arwLhVleSFpoluTQP9
 n4gM0ic7zwXsNtDEoJ8BhwZ5ZHyRGUUXb5dpbJX+6hfQfFENyvEUikumoSYimrs1XW9F7h
 GaY+L/lxLlfVvJhMyr2itTp48emgOw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696435192;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V4eTiVYNc8iTHVLUJRwz9wghlB+/3v6PMNh74prsOl4=;
 b=sli0snFIm77tEtBEGbv1qX0i9o4WxHf05X+hV1vpmOn2wpUMiPyryM3NccaUFgXq/mEoz5
 O5Qnax7J+bV+5YBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF25A139F9;
 Wed,  4 Oct 2023 15:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z82SHfeLHWUTLgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 04 Oct 2023 15:59:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, qemu-devel@nongnu.org,
 Peter Xu
 <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
In-Reply-To: <87wmw24vzg.fsf@secure.mitica>
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
 <ZRw5Myc/joWb6why@redhat.com> <874jj7u11d.fsf@suse.de>
 <87wmw24vzg.fsf@secure.mitica>
Date: Wed, 04 Oct 2023 12:59:49 -0300
Message-ID: <8734yqpedm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>
>>> On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> [...]
>
>>> $ cat myqemu.dkr=20
>>> FROM fedora:38
>>>
>>> RUN dnf -y install qemu-kvm
>>>
>>> $ podman build -f myqemu.dkr --tag myqemu .
>>>
>>> $ cat > myqemu <<EOF
>>> #!/bin/sh
>>> exec podman run --volume /tmp=3D/tmp --security-opt label=3Ddisable myq=
emu qemu-system-x86_64 "$@"
>>>
>>> $ chmod +x myqemu
>>>
>>> $ QTEST_QEMU_BINARY=3D./myqemu.sh  ./build/tests/qtest/rtc-test
>>
>> I'm favor of this. I usually set that variable to something like 'gdb
>> --args ...' and it works just fine.
>>
>>> Except we fail on the last step, because bind mounts don't make UNIX do=
main
>>> sockets accessible. So we can see the /tmp/qtest-$PID.sock in the conta=
iner,
>>> but it can't be used.
>>>
>>> UNIX domain sockets in the filesystem are tied to the mount namespace, =
and
>>> podman/docker inherantly creates a new mount namespace making the UNIX
>>> domani socket inaccessible.
>>>
>>> UNIX domain sockets in the abstract namespace, however, are tied to the
>>> network namespace, so if you used podman --network host, they should be
>>> accessible.
>>>
>>> libqtest could be changed to use abstract UNIX domain sockets on Linux
>>> only, and likely unlock the use of podman for QEMU.
>
> That is one idea, but why can't we convince a container to compile
> _both_ qemus?
>
> I am not familiar with containers, but:
> - We already know how to compile a qemu inside a container
> - We can teach it to compile $HEAD and v8.0.0 (or whatever)
>
> And do the test inside, right?
>
> On the other hand, your approach has the advantage that one can test
> opensuse qemu against fedora qemu, and similar.  Not sure how useful is
> that, though.
>
> [lots of code to find common machine types]

I'm working on a cleanup of this patch to make it more integrated with
libqtest. If we teach qtest_get_machines() to sometimes refresh the list
of machines then it becomes way less code.

> I think that it is just easier to pass the machine type we want to test
> to whatever script we have.  Specially where [sane] architectures like
> arm don't have a default machine type (no, I haven't double checked if
> that has changed lately).

We still need to enforce the same machine type for both binaries and a
sane range of QEMU versions. I think our docs state that we only support
migration from QEMU n->n+1 and vice versa? If the test will know what
combinations are allowed, it could just go ahead and use those.

>>> IMHO, we should just create a new qtest_init_env variant, that is the
>>> same as qtest_init, but accepts an environment variable name to use as
>>> an override.
>>>
>>> eg
>>>
>>>    qtest_init_env("QTEST_QEMU_BINARY_SRC", extra_args)
>
> That was going to be my suggestion.
>
>>> it would look for $QTEST_QEMU_BINARY_SRC and if not found automatically
>>> fallback to $QTEST_QEMU_BINARY.
>>>
>>
>> This was initially intended to be an off-tree patch that I could use to
>> test migration compatibility, so I avoided touching libqtest. Now that I
>> learned this might be of interest we can make it less hackish.
>>
>>> I don't think there's any need to explicitly forbid setting both
>>> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST at the same time.
>>>
>>
>> This is a little biased on my usage of migration-test from the command
>> line. Adding one of SRC|DST is easier when coming/going from a test that
>> already uses QTEST_QEMU_BINARY. No big deal, of course.
>>
>> We'll just have to do something about qtest_get_machines(),
>> qtest_has_device() and qtest_get_arch(), which expect QTEST_QEMU_BINARY
>> to be present.
>
> I think we can do the same trick here:
>
> qtest_has_device_env("VARIABLE") and let qemu_has_device() just call it
> with QTEST_QEMU_BINARY.  Same for the others.
>
> It is more, if we can do it easy, we can do that qtest_init_env() checks
> in the case that variable is not QTEST_QEMU_BINARY that this one is also
> set, and assume in the rest of the code that options are compatible
> between whatever we passed an QTEST_QEMU_BINARY, that way we don't need
> to change anything else.  Well, just put a big warning in a comment
> saying that using qtest_init_env() means that you know what you are
> doing.
>
> Later, Juan.

