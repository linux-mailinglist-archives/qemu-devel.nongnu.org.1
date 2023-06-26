Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E59B73E03A
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:10:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlyP-0007X3-Os; Mon, 26 Jun 2023 09:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qDlyG-0007WT-7P
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qDlyE-0004DB-Fl
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:09:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687784968;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=levPISVeDaZE/bNF53g8xFDR4bbRtcBnU8SBu6Qwfi0=;
 b=RiAPPEEDTj0c/Lx4/E8vXSnYfELh7+/kGk7RtwHcFCWcbHu9wDQzYTuoA4Bd7/HmKsdyFA
 aMOza4YbHYGGmiVSe5SdMTOC9S5zYOoDDJWOWs8tr2QoFaoHkkiFG4NeW1gC2qq4x5RhwO
 ed1wvmHX/tpCyXS/39z2tEAeNnhajaY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-499-u49oA4ooOci3ZWZRsbsCtQ-1; Mon, 26 Jun 2023 09:09:26 -0400
X-MC-Unique: u49oA4ooOci3ZWZRsbsCtQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f97512901eso1933466e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687784965; x=1690376965;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=levPISVeDaZE/bNF53g8xFDR4bbRtcBnU8SBu6Qwfi0=;
 b=LX8U3CjHjC5x5IMLevEaB3SeWu1VSbgvG8UPuuQJt2eHSgg1xts61/FJzQX+ntI125
 WGLrs71x30/jLuwz0iIdlykkMJ9ZWeVb3pWhmr6ZhCeEuun1iHX0TMfeVZf098ZHhkB5
 UyKzAN+2LI7WsMpEZgYni8YAblFRqhLqa7deSYoCwE2qIy9ZfgdqivnffBZJJDNRXK3x
 rAEHGOshA0dFY4z5iSVeQuZjZ0YaeaAX3ETIn5XbsKsYa/pBNWAPM+KNNiUWaoCrRX0J
 kIw+kV3vMOI4iYoGJDusAPaS0p5eVTFRrm0pCUi1bxbzY1SP4eZnoYsGBeKWd+rEmXc+
 LtLw==
X-Gm-Message-State: AC+VfDzhYA/qKD+gg6e5LynSclr0ZHZnywXF0E3EgLO+eavW8GVSLLih
 MFJwADA2rH6xWCGpS46KBib/Fd2Zj5O7LDHLiVhTb/m+XS0Is72YA2ej7YNLdM4e+XVm+NjcsPf
 SIXyA0KMCpTz5o6g=
X-Received: by 2002:a19:6451:0:b0:4f8:752f:df48 with SMTP id
 b17-20020a196451000000b004f8752fdf48mr12037873lfj.29.1687784965092; 
 Mon, 26 Jun 2023 06:09:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6V9by5o1hPuYsTYX/Td2asHGQwvwB4jZ5OyvtguzeamVwPqwNiSiPbIkWpdp7O2gtnCWchFg==
X-Received: by 2002:a19:6451:0:b0:4f8:752f:df48 with SMTP id
 b17-20020a196451000000b004f8752fdf48mr12037848lfj.29.1687784964669; 
 Mon, 26 Jun 2023 06:09:24 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 z3-20020a5d4d03000000b0030aec5e020fsm7323318wrt.86.2023.06.26.06.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 06:09:23 -0700 (PDT)
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
Date: Mon, 26 Jun 2023 15:09:23 +0200
Message-ID: <87zg4mcqv0.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

I am looking at the whole series. I can't see a single function that is
new/change prototypes/etc that is changed on this series.

So is this problem related to CFI?  Or it is a migration problem that
somehow only happens when one use CFI?

Inquiring minds what to know.  Any clue?

Later, Juan.



>
> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764#L188
>
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
> Memory content inconsistency at 4f65000 first_byte =3D 30 last_byte =3D 2f
> current =3D 88 hit_edge =3D 1
> **
> ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion fai=
led: (bad =3D=3D 0)
>
> (test program exited with status code -6)
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95
>
>
> r~


