Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9C771FE32
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 11:46:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q51LG-0004VE-R4; Fri, 02 Jun 2023 05:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q51LC-0004Uz-GA
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:45:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q51LA-00029Y-Li
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 05:45:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6e68cc738so17847555e9.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685699099; x=1688291099;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v9Fmeskjd8My9ulf4PrEVJeJh8p34sKN80rfH53l5u8=;
 b=tuyj8MPfPHGh0c0eLy9GZ5X0THgWuKdJbyVMTxxaQgpYgmmGxtUwIJnHWN7buo09xe
 uo/l7EvF4YQJ4wPmMqEOG07+CGF3kOPprs+994VEmz5QDRiWSvUeEtE8lqmHOp/oONJR
 Zcy0RUsyfMbFsIxZYNRxC5jOna7w5nwBM5PW8oCrs8aurhHdasPZj/i1pcQQ4Ex4V4T5
 k9AgxPX5YiR65DbWfrCuat9+WYZdHh/9HMruJ4TIoMEzB1wbsuYtlnmTBd72Mx0/o2CA
 hMdenUS4fM4H9Ngc53/CGB1hLEC3H/lrf7KAAj4jwEzwC15MHlvakJIRQGQeam0DmccT
 qYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685699099; x=1688291099;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v9Fmeskjd8My9ulf4PrEVJeJh8p34sKN80rfH53l5u8=;
 b=Z1lEkMoPKJ3+SQ9c1h6jYH135wlg0aR+gleeTNj4+vrjYMkDDkL+qM84iuFkcOZAFB
 uwSLq4eSx0+Lbrm9PHnsd+0ddqmPR4+PsIOzVFb0Gou93w6++KlJYp/bYiK/zLI3n6LG
 BvsEmlPFzUpgyLAlaxhIfwbrZ5mW0BdJHQXFptDHcOZO15e0+CMkxrlOId9riKYrne3S
 Bs71nebQEujRDi0E86iCm51CWSpZVeMY5kg0zyzmyDS/XtjpGexO0ePi+NJfPcaeW2aS
 zTyISqWPvPJQaNHYRwUTJEDtyJLOetAn36zAeCu6wGYFgceo/+FihxcPwIRI2XdrlsWe
 vU0w==
X-Gm-Message-State: AC+VfDw+t01dxVspPtKicuSGTNCPOraHafJ5D+3egQLCl7pCH+Px+NHs
 jfXQ8jnLfy4wCpK98/b2ixuDsw==
X-Google-Smtp-Source: ACHHUZ5e69hBrZlQM9Ekgsqo7q5a8VsHwhv5LH7jGi9pRo9cs0QQVjIx+J+Rjoxw0KPzktVf9CnNVA==
X-Received: by 2002:a05:600c:289:b0:3f6:3bb:5135 with SMTP id
 9-20020a05600c028900b003f603bb5135mr1490900wmk.14.1685699098987; 
 Fri, 02 Jun 2023 02:44:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a5d5649000000b0030b5d203e7esm1121477wrw.97.2023.06.02.02.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 02:44:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0D4821FFBB;
 Fri,  2 Jun 2023 10:44:58 +0100 (BST)
References: <87y1l2rixp.fsf@secure.mitica> <ZHmyA40nIiUBceX0@redhat.com>
 <CAFEAcA_1FF6tBt7C=zfLcSiFPNzSecZkRMtppYbUBjwZPVfbmg@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org
Subject: Re: Big TCG slowdown when using zstd with aarch64
Date: Fri, 02 Jun 2023 10:42:26 +0100
In-reply-to: <CAFEAcA_1FF6tBt7C=zfLcSiFPNzSecZkRMtppYbUBjwZPVfbmg@mail.gmail.com>
Message-ID: <877csmb3l2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 2 Jun 2023 at 10:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>> I suspect that the zstd logic takes a little bit longer in setup,
>> which allows often allows the guest dirty workload to get ahead of
>> it, resulting in a huge amount of data to transfer. Every now and
>> then the compression code gets ahead of the workload and thus most
>> data is zeros and skipped.
>>
>> IMHO this feels like just another example of compression being largely
>> useless. The CPU overhead of compression can't keep up with the guest
>> dirty workload, making the supposedly network bandwidth saving irrelevan=
t.
>
> It seems a bit surprising if compression can't keep up with
> a TCG guest workload, though...

Actual running code doesn't see much of a look in on the perf data:

   4.17%  CPU 0/TCG        qemu-system-aarch64      [.] tlb_set_dirty
   3.55%  CPU 0/TCG        qemu-system-aarch64      [.] helper_ldub_mmu
   1.58%  live_migration   qemu-system-aarch64      [.] buffer_zero_avx2
   1.35%  CPU 0/TCG        qemu-system-aarch64      [.] tlb_set_page_full
   1.11%  multifdsend_2    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.07%  multifdsend_13   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.07%  multifdsend_6    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.07%  multifdsend_8    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.06%  multifdsend_10   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.06%  multifdsend_3    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.05%  multifdsend_7    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.04%  multifdsend_11   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.04%  multifdsend_15   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.04%  multifdsend_9    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.03%  multifdsend_1    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.03%  multifdsend_0    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.02%  multifdsend_4    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.02%  multifdsend_14   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.02%  multifdsend_12   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   1.01%  multifdsend_5    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.96%  multifdrecv_3    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.94%  multifdrecv_13   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.94%  multifdrecv_2    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.93%  multifdrecv_15   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.93%  multifdrecv_10   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.93%  multifdrecv_12   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.92%  multifdrecv_0    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.92%  multifdrecv_1    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.92%  multifdrecv_8    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.91%  multifdrecv_6    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.91%  multifdrecv_7    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.91%  multifdrecv_4    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.91%  multifdrecv_11   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.90%  multifdrecv_14   libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.90%  multifdrecv_5    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.89%  multifdrecv_9    libc.so.6                [.] __memmove_avx_unali=
gned_erms
   0.77%  CPU 0/TCG        qemu-system-aarch64      [.] cpu_physical_memory=
_get_dirty.constprop.0
   0.59%  migration-test   [kernel.vmlinux]         [k] syscall_exit_to_use=
r_mode
   0.55%  multifdrecv_12   libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.54%  multifdrecv_4    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.51%  multifdrecv_5    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.51%  multifdrecv_14   libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.49%  multifdrecv_2    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.45%  multifdrecv_1    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.45%  multifdrecv_9    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.42%  multifdrecv_10   libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.40%  multifdrecv_6    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.40%  multifdrecv_3    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.40%  multifdrecv_8    libzstd.so.1.5.4         [.] 0x000000000008ec20
   0.39%  multifdrecv_7    libzstd.so.1.5.4         [.] 0x000000000008ec20

>
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

