Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A057B7AE6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 10:58:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxVs-0007bH-T4; Wed, 04 Oct 2023 04:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxVV-0007Nk-3s
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxVQ-00029U-Ci
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409117;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=80AVLpgd7np/s/fo2OZHRCLCtgKBi8A08oNiAx5YZ5M=;
 b=J1wVe8kPTyxphHXx3BVfbBxcwKJtDmiqUsgzaWEQ6Yq9HYjW7MAosAz970Oo/xZOvhhJPh
 /63jExqjn4HMY32CLm5Yh+qIYkZFeZU73exaX61AXyDMxeKv4A/UzoJTEaRxwraGZR+/Gr
 s6S7f3qKAs7OHwhaVLr1GaPYtwcsaoY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-UDjERf5FO_iIJQKtPdYQMA-1; Wed, 04 Oct 2023 04:45:11 -0400
X-MC-Unique: UDjERf5FO_iIJQKtPdYQMA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5039413f4f9so1806365e87.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:45:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409109; x=1697013909;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80AVLpgd7np/s/fo2OZHRCLCtgKBi8A08oNiAx5YZ5M=;
 b=o3ChfkBZDqRwqbYSG0Eq3EGyM0a+r9HOzL/jcl4UAvWabHW+p3uM48Y1Y4fCumNjb7
 VwrV85CSUPPQgjD9i33Fqrl+N9k+b/lOEtms8ssSud04IVe0TTj0arOzzg27jZKuujVH
 RYgybLPbRCzEMauW14uv78e+QKfHjwXx4RJThudsbzNn8tlIY0ij736NW8gmp0tNIQi4
 P06QOLyFQXARmDR7hdI3XbMM0XgL5khACoa7V43giYF3Gbluu+XI7nObfwAfVP78n3ti
 P/QAbl5nFjrxIlawcTV4ktfzhhpcKKs4r9hCtmt30+FDfX3GgYLE05e4GwT7i4wugDxx
 BHJQ==
X-Gm-Message-State: AOJu0Yw/rnzAertOrE/L5PzjYOrQ+3+ZpW35jB4WblixiZ2m5QrLD7Wl
 0isUFp9cqAy9Q4hxh7S1LIMQQvFNwlj/ajvQJEvz3Y+Wd+vvqRwwFx6/pvSi5YR1RS1DVcv6Fon
 jVJE1J9lnF5/Dqxw=
X-Received: by 2002:a05:6512:ac8:b0:503:1aae:eca0 with SMTP id
 n8-20020a0565120ac800b005031aaeeca0mr1740271lfu.44.1696409108994; 
 Wed, 04 Oct 2023 01:45:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZvQI8J3ivi+2nefDHj96WgoN/Q8CyIfOua1SWo9FmmpOnkf7wnh5k6O7EoPE6Fb8NwBxwfg==
X-Received: by 2002:a05:6512:ac8:b0:503:1aae:eca0 with SMTP id
 n8-20020a0565120ac800b005031aaeeca0mr1740255lfu.44.1696409108641; 
 Wed, 04 Oct 2023 01:45:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c221400b003fee8793911sm934470wml.44.2023.10.04.01.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:45:08 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 1/1] qtest/migration: Support more than one QEMU binary
In-Reply-To: <874jj7u11d.fsf@suse.de> (Fabiano Rosas's message of "Tue, 03 Oct
 2023 13:24:30 -0300")
References: <20231003141932.2367-1-farosas@suse.de>
 <20231003141932.2367-2-farosas@suse.de>
 <3dd8e410-982b-3ea6-78aa-08c1ba26f8da@linaro.org>
 <ZRw5Myc/joWb6why@redhat.com> <874jj7u11d.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 10:45:07 +0200
Message-ID: <87wmw24vzg.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Tue, Oct 03, 2023 at 05:24:50PM +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
[...]

>> $ cat myqemu.dkr=20
>> FROM fedora:38
>>
>> RUN dnf -y install qemu-kvm
>>
>> $ podman build -f myqemu.dkr --tag myqemu .
>>
>> $ cat > myqemu <<EOF
>> #!/bin/sh
>> exec podman run --volume /tmp=3D/tmp --security-opt label=3Ddisable myqe=
mu qemu-system-x86_64 "$@"
>>
>> $ chmod +x myqemu
>>
>> $ QTEST_QEMU_BINARY=3D./myqemu.sh  ./build/tests/qtest/rtc-test
>
> I'm favor of this. I usually set that variable to something like 'gdb
> --args ...' and it works just fine.
>
>> Except we fail on the last step, because bind mounts don't make UNIX dom=
ain
>> sockets accessible. So we can see the /tmp/qtest-$PID.sock in the contai=
ner,
>> but it can't be used.
>>
>> UNIX domain sockets in the filesystem are tied to the mount namespace, a=
nd
>> podman/docker inherantly creates a new mount namespace making the UNIX
>> domani socket inaccessible.
>>
>> UNIX domain sockets in the abstract namespace, however, are tied to the
>> network namespace, so if you used podman --network host, they should be
>> accessible.
>>
>> libqtest could be changed to use abstract UNIX domain sockets on Linux
>> only, and likely unlock the use of podman for QEMU.

That is one idea, but why can't we convince a container to compile
_both_ qemus?

I am not familiar with containers, but:
- We already know how to compile a qemu inside a container
- We can teach it to compile $HEAD and v8.0.0 (or whatever)

And do the test inside, right?

On the other hand, your approach has the advantage that one can test
opensuse qemu against fedora qemu, and similar.  Not sure how useful is
that, though.

[lots of code to find common machine types]

I think that it is just easier to pass the machine type we want to test
to whatever script we have.  Specially where [sane] architectures like
arm don't have a default machine type (no, I haven't double checked if
that has changed lately).

>> IMHO, we should just create a new qtest_init_env variant, that is the
>> same as qtest_init, but accepts an environment variable name to use as
>> an override.
>>
>> eg
>>
>>    qtest_init_env("QTEST_QEMU_BINARY_SRC", extra_args)

That was going to be my suggestion.

>> it would look for $QTEST_QEMU_BINARY_SRC and if not found automatically
>> fallback to $QTEST_QEMU_BINARY.
>>
>
> This was initially intended to be an off-tree patch that I could use to
> test migration compatibility, so I avoided touching libqtest. Now that I
> learned this might be of interest we can make it less hackish.
>
>> I don't think there's any need to explicitly forbid setting both
>> QTEST_QEMU_BINARY_SRC and QTEST_QEMU_BINARY_DST at the same time.
>>
>
> This is a little biased on my usage of migration-test from the command
> line. Adding one of SRC|DST is easier when coming/going from a test that
> already uses QTEST_QEMU_BINARY. No big deal, of course.
>
> We'll just have to do something about qtest_get_machines(),
> qtest_has_device() and qtest_get_arch(), which expect QTEST_QEMU_BINARY
> to be present.

I think we can do the same trick here:

qtest_has_device_env("VARIABLE") and let qemu_has_device() just call it
with QTEST_QEMU_BINARY.  Same for the others.

It is more, if we can do it easy, we can do that qtest_init_env() checks
in the case that variable is not QTEST_QEMU_BINARY that this one is also
set, and assume in the rest of the code that options are compatible
between whatever we passed an QTEST_QEMU_BINARY, that way we don't need
to change anything else.  Well, just put a big warning in a comment
saying that using qtest_init_env() means that you know what you are
doing.

Later, Juan.


