Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B14F810F17
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 11:58:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDMw0-0001dA-NJ; Wed, 13 Dec 2023 05:57:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDMvx-0001cJ-Kt
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:57:45 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDMvu-0007S8-5F
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 05:57:45 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40c317723a8so57903455e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702465060; x=1703069860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QVloZFLwfAyLJKWcMbhXYiZ6kSjb+dVKbmPceDRhKv4=;
 b=k3fmdveYY0P1U4+tiIl27sl5a8F+0UWo/YgVL26vnTdkC1wJDqOaTqWsDZk+OXiFCL
 v/eVxzcO4eD/YfBPHS1q0ouIGfOGKdOwUt70njTfqBZUYV8j38C58nGGk8HzyzotyPCu
 uWpvRm7yElgPM8T/Da+kTtdHL09cmSlnmbr4jU3CvhlijwjOsdglwap2zL3Oaf2rXeBq
 62lv4ZVvNIO17cQXcQ7y2ST1jOJra3GCVTaSSXQyVAIZEbzIyt0OVnhtMyyIYZu0uafk
 xwkXtQgU1IGn/SUV9uXV93F7UZHG1LgTNd5SwRCuLHL0c2aN8bEZu7IWFjKbpZ8bkkAM
 JOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702465060; x=1703069860;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QVloZFLwfAyLJKWcMbhXYiZ6kSjb+dVKbmPceDRhKv4=;
 b=WlKtZeVrwKEirVolleZ/R/XF0tmitm8bzn8vPe1y2lAmeP7ssWpLp4hqKR4zZznRN+
 eBKNgHAFM/onoBgec/+JjNW1B9CsCkcPlHHnK16UqDNOaipE+Yc9oMa7G4sJVefT0enW
 UqWf3haIPUmAabEkv5FKowldblGGmnUW9FWmiH8rJLw7Qj126qdR1e7f2OPxd85EFQZ9
 CiGSBz9xp2dH76mvrTV6YG0ZudG3qs3TNOl0bkHUGcHvLxLN6nCBwocoiGrGAQfpS/Co
 9XQiod9q8PQwIkOjS9lzc2TqeHVVCNOZN3UcLze/9GfClZqf+OdbYoeCtun9tIIPMayn
 bKYA==
X-Gm-Message-State: AOJu0Yy7reQjHEqaCOPXZGIV6VxQcGib7Txwh+UE++EDVC81BID0NYLK
 gvnhL2zStSE5QXNl9OwhUQ2/Fw==
X-Google-Smtp-Source: AGHT+IHPBPgDGo/UXpvEZG9rc2qrTufCUzTVxlVkxmR+YIOgvt1NOfhcxz0jin0GkvD4VYlAsEdFSA==
X-Received: by 2002:a05:600c:c3:b0:40c:591:59e1 with SMTP id
 u3-20020a05600c00c300b0040c059159e1mr3954301wmm.153.1702465060402; 
 Wed, 13 Dec 2023 02:57:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j17-20020a05600c1c1100b0040b48690c49sm20045399wms.6.2023.12.13.02.57.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 02:57:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A8B735F7B1;
 Wed, 13 Dec 2023 10:57:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>
Subject: Re: [PATCH v2 00/16] record/replay fixes: attempting to get avocado
 green
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 11 Dec 2023 09:13:29 +0000")
References: <20231211091346.14616-1-alex.bennee@linaro.org>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 13 Dec 2023 10:57:39 +0000
Message-ID: <87msue9xp8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> As I'm a glutton for punishment I thought I'd have a go at fixing the
> slowly growing number of record/replay bugs. The two fixes are:
>
>  replay: stop us hanging in rr_wait_io_event
>  chardev: force write all when recording replay logs
>
> I think we are beyond 8.2 material but it would be nice to get this
> functionality stable again. We have a growing number of bugs under the
> icount label on gitlab:
>
>   https://gitlab.com/qemu-project/qemu/-/issues/?label_name%5B%5D=3Dicount
>
> Changes
> -------
>
> v2
>
> Apart from addressing tidy ups and tags I've been investigating the
> failures in replay_linux.py which are the more exhaustive tests which
> boot the kernel and user-space. The "fix":
>
>   replay: report sync error when no exception in log (!DEBUG INVESTIGATIO=
N)
>
> triggers around the time of the hang in the logs and despite the
> rather hairy EXCP->INT transitions around cpu_exec_loop() I think
> points to a genuine problem. I added the tracing to cputlb to verify
> the page tables are the same and started detecting divergence between
> record and replay a lot earlier on that when the replay_sync_error()
> catches things. I see patterns like this:
>
>    1878 tlb_fill 0x4770c000/1 1 2                                       t=
lb_fill 0x4770c000/1 1 2
>    1879 tlb_fill 0x4770d000/1 1 2                                       t=
lb_fill 0x4770d000/1 1 2
>    1880 tlb_fill 0x59000/1 0 2                                          t=
lb_fill 0x59000/1 0 2
>    1881                                                               > t=
lb_fill 0x476dd116/1 0 2
>    1882 tlb_fill 0x4770e000/1 1 2                                       t=
lb_fill 0x4770e000/1 1 2
>    1883 tlb_fill 0x476dd527/1 0 2                                     | t=
lb_fill 0x476dfb17/1 0 2
>    1884                                                               > t=
lb_fill 0x476de0fd/1 0 2
>    1885                                                               > t=
lb_fill 0x476dce2e/1 0 2
>    1886 tlb_fill 0x4770f000/1 1 2                                       t=
lb_fill 0x4770f000/1 1 2
>    1887 tlb_fill 0x476df939/1 0 2                                     <
>    1888 tlb_fill 0x47710000/1 1 2                                       t=
lb_fill 0x47710000/1 1 2
>    1889 tlb_fill 0x47711000/1 1 2                                       t=
lb_fill 0x47711000/1 1 2
>
> These don't seem to affect the overall program flow but are concerning
> because the memory access patterns should be the same. My
> investigations with rr seem to indicate the difference is due to
> behaviour of the victim_tlb_cache which again AFAICT should be
> deterministic.
>
> Anyway I can't spend any time debugging it this week so I thought I'd
> post the current state in case anyone is curious enough to want to go
> diving into record/replay.

Just for the actual failure report, on replay:

  [  144.918551] audit: type=3D1130 audit(1702415469.960:45): pid=3D1 uid=
=3D0 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:system_r:init_t:s0 =
msg=3D'unit=3Dsystemd-tmpfiles-setup comm=3D"
  systemd" exe=3D"/usr/lib/systemd/systemd" hostname=3D? addr=3D? terminal=
=3D? res=3Dsuccess'
  [  145.579135] audit: type=3D1305 audit(1702415470.620:46): op=3Dset audi=
t_enabled=3D1 old=3D1 auid=3D4294967295 ses=3D4294967295 subj=3Dsystem_u:sy=
stem_r:auditd_t:s0 res=3D1
  qemu-system-aarch64: Exception not in log (insn total 30592471098/1463 le=
ft, event 2848747 is EVENT_INSTRUCTION)
  fish: Job 1, './qemu-system-aarch64 -display =E2=80=A6' terminated by sig=
nal SIGABRT (Abort)

I've made some more fixes to the replay_dump script and the next event
expected is a CLOCK_WARP followed by some more instructions before an
exception. However there are a lot of exceptions/interrupts firing off
in the stream:

  2848736:EVENT_EXCEPTION(2) no data
  2848737:EVENT_INSTRUCTION(0) + 835 -> 30592463170
  2848738:EVENT_EXCEPTION(2) no data
  2848739:EVENT_INSTRUCTION(0) + 1133 -> 30592464303
  2848740:EVENT_EXCEPTION(2) no data
  2848741:EVENT_INSTRUCTION(0) + 4739 -> 30592469042
  2848742:EVENT_EXCEPTION(2) no data
  2848743:EVENT_INSTRUCTION(0) + 865 -> 30592469907
  2848744:EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
  2848745:EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
  2848746:EVENT_INTERRUPT(1)
  2848747:EVENT_INSTRUCTION(0) + 2654 -> 30592472561

  we are here...

  2848748:EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
  2848749:EVENT_INSTRUCTION(0) + 184 -> 30592472745
  2848750:EVENT_EXCEPTION(2) no data
  2848751:EVENT_INSTRUCTION(0) + 832 -> 30592473577
  2848752:EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
  2848753:EVENT_INSTRUCTION(0) + 6 -> 30592473583
  2848754:EVENT_CP_CLOCK_WARP_ACCOUNT(31) no additional data
  2848755:EVENT_INSTRUCTION(0) + 2960 -> 30592476543
  2848756:EVENT_EXCEPTION(2) no data
  2848757:EVENT_INSTRUCTION(0) + 1565 -> 30592478108
  2848758:EVENT_EXCEPTION(2) no data
  2848759:EVENT_INSTRUCTION(0) + 2996 -> 30592481104
  2848760:EVENT_EXCEPTION(2) no data
  2848761:EVENT_INSTRUCTION(0) + 832 -> 30592481936
  2848762:EVENT_ASYNC(9)
    REPLAY_ASYNC_EVENT_NET(6) id 0 flags 0 305 bytes

That said given the complexity of the exception/interrupt processing
back and forth I can see there is potential for things getting confused.
Of course I still haven't explained why there is a divergence in the tlb
processing so early on despite seemingly having no effect on the replay
until this very late stage.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

