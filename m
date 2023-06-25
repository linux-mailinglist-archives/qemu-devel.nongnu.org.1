Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB3673D4FE
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 00:03:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDXo0-0002GR-7Z; Sun, 25 Jun 2023 18:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qDXnu-0002Fx-8f
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 18:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qDXnr-0004Yz-Rp
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 18:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687730509;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+5jGWwz65TeRrLIZBQ79Ksw62mg/mIcqsnGgCGhCrY=;
 b=gBYVk9pjJRqqgj62WzxIJ9Z8u24Qbf9QuaTSjKMB9Zvy7UuCJ1JO3e9J5e1MEWzpIJIWhX
 +SPV8BKnKViHV5vpt1EVpVdj8VW9HN2YUWwl3j5sGUKmWrX2VCocYKdTlnL0h6jE+pvR9A
 BJ5syuUhNTnWPI0W5ws/hrl3Ah7fGXw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-uw0m5dJCNLGSLX_tuhZ5aw-1; Sun, 25 Jun 2023 18:01:48 -0400
X-MC-Unique: uw0m5dJCNLGSLX_tuhZ5aw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso20474325e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 15:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687730507; x=1690322507;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p+5jGWwz65TeRrLIZBQ79Ksw62mg/mIcqsnGgCGhCrY=;
 b=jkMew+iNm3L4JJjriTKjukZGBlAwiE/qbcemjuaWmFc9JCSxOIFxNlqMrlWyVliXFB
 55O7CuKbuZYJhxo1nbO+3cRIZm3P7/rJLIA7WvQqR0FEUNuhIm4dXYbeKpkPA7T/73C2
 qos+yOgeDld9NgI9Wt81aX9DG0RBoifcW8XPCd1EJcSZpWbgbs40hpjMC7ybbFO9LQNt
 efF6PpCRzwIqZYLix3yQa6uMEheXPsmjoLVjkerMoNtX2fEx/y6P5hRimyC0YTvol4Dj
 t0QtsBy9+evKfOuDI3SMtAEsiCDMlo/JCT/Kj9z7pNs2qwUr5gZ6Dyx8vsvbRidowNl4
 +EVw==
X-Gm-Message-State: AC+VfDz7O49tJnXSsVFdr/y87xqksvhq8v8EaxU2y5wH4IadnRJtSZKT
 LxPFaiTCMiewW8LRzpHihhjj5ErXG5rtdgt9gKlk0PAuRv/93AF9gV9SfXLLNYOKWHzSCUqmVtS
 TLg9ZXFTyV/ISrEg=
X-Received: by 2002:a7b:cc15:0:b0:3f9:846:d892 with SMTP id
 f21-20020a7bcc15000000b003f90846d892mr20868451wmh.9.1687730506906; 
 Sun, 25 Jun 2023 15:01:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7vo6R4PcnjqoFLF2w3+Wtvqbeuh9bvyojHvHcN31Xj9n5fIG4YmPJ8ILGr9iNnd4tSRKo5xg==
X-Received: by 2002:a7b:cc15:0:b0:3f9:846:d892 with SMTP id
 f21-20020a7bcc15000000b003f90846d892mr20868436wmh.9.1687730506511; 
 Sun, 25 Jun 2023 15:01:46 -0700 (PDT)
Received: from redhat.com ([77.211.4.70]) by smtp.gmail.com with ESMTPSA id
 o1-20020a5d4741000000b0030af72bca98sm5452708wrs.103.2023.06.25.15.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 15:01:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Fam Zheng <fam@euphon.net>,  Leonardo Bras
 <leobras@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PULL 00/30] Next patches
In-Reply-To: <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org> (Richard
 Henderson's message of "Fri, 23 Jun 2023 07:45:43 +0200")
References: <20230622165527.2417-1-quintela@redhat.com>
 <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 26 Jun 2023 00:01:43 +0200
Message-ID: <87leg719rs.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> wrote:
> On 6/22/23 18:54, Juan Quintela wrote:
>> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a=
4cb:
>>    Merge tag 'q800-for-8.1-pull-request'
>> ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22
>> 10:18:32 +0200)
>> are available in the Git repository at:
>>    https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
>> for you to fetch changes up to
>> 23e4307eadc1497bd0a11ca91041768f15963b68:
>>    migration/rdma: Split qemu_fopen_rdma() into input/output
>> functions (2023-06-22 18:11:58 +0200)
>> ----------------------------------------------------------------
>> Migration Pull request (20230621) take 2
>> In this pull request the only change is fixing 32 bits complitaion
>> issue.
>> Please apply.
>> [take 1]
>> - fix for multifd thread creation (fabiano)
>> - dirtylimity (hyman)
>>    * migration-test will go on next PULL request, as it has failures.
>> - Improve error description (tejus)
>> - improve -incoming and set parameters before calling incoming (wei)
>> - migration atomic counters reviewed patches (quintela)
>> - migration-test refacttoring reviewed (quintela)
>
> New failure with check-cfi-x86_64:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764#L188

First of all, is there a way to get to the test log?  In particular, I
am interested in knowing at least what test has failed (yes,
migration-test don't tell you much more).

After a bit more wrestling, I have been able to get things compiling
with this command:

$ /mnt/code/qemu/full/configure --enable-cfi
--target-list=3Dx86_64-softmmu --enable-cfi-debug --cc=3Dclang --cxx=3Dclan=
g++
--disable-docs --enable-safe-stack --disable-slirp

It should basically be the one that check-cfi-x86_64 is using if I
understand the build recipes correctly (that is a BIG IF).

And it passes for me with flying colors.
Here I have Fedora38, builder has F37.

> /builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t
> 0  --num-processes 1 --print-errorlogs
>   1/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/qom-test
>   OK 6.55s   8 subtests passed
> =E2=96=B6   2/350 ERROR:../tests/qtest/migration-test.c:320:check_guests_=
ram:
> assertion failed: (bad =3D=3D 0) ERROR
>   2/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>   ERROR 151.99s   killed by signal 6 SIGABRT
>>>>
>     G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/tests/dbus-vmstate-dae=
mon.sh
>     MALLOC_PERTURB_=3D3 QTEST_QEMU_IMG=3D./qemu-img
>     QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daem=
on
>     QTEST_QEMU_BINARY=3D./qemu-system-x86_64
>     /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap
>    -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> qemu-system-x86_64: Unable to read from socket: Connection reset by peer

This is the interesting bit, why is the conection closed.

> Memory content inconsistency at 4f65000 first_byte =3D 30 last_byte =3D 2f
> current =3D 88 hit_edge =3D 1
> **
> ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion fai=
led: (bad =3D=3D 0)
>
> (test program exited with status code -6)

This makes zero sense, except if we haven't migrated all the guest
state, that it is what it has happened.

Is there a place on the web interface to see the full logs?  Or that is
the only thing that the CI system stores?

Later, Juan.


