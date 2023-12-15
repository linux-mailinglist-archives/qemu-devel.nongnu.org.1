Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3B6814719
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 12:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE6XU-00055w-3V; Fri, 15 Dec 2023 06:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rE6XQ-00055j-SO
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:39:29 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rE6XP-0006VF-72
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 06:39:28 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3364b049467so441455f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702640365; x=1703245165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQc2nQaff3+nNgN8+arHKo5874O5b2KMs9FYFDq9HyU=;
 b=GpDZp4LM88wZS+2rsSlBF0Mz69aF+C7Ptw3nB6I86tmN2Pp8CsLBlOzHraRVtl8Rrm
 XQaxBIfkFqH2bSc+7s0Ky3vjE+ZopZfPQLAGSvqAX3XJKyWyJY7oERM5EF5pFu/zPCro
 edAjXNje61ToNsbNw7hRPNKambsYDf06SGxURyLgiqno8yFOJh6OJIIV/k3H/Mtt7j4i
 ql5e89lDHRYNO9TjKH/UG9ggwN7A9yDV4RtYRzEwcd2elHcEOuBsTK4LuyB6ousB2FFH
 svBkXXbdcq/mCfdTCzHOE6zjR8pVzIaxScFFuQD7EizHODOhQxZ1iWLu4FBGwVw/692Q
 XZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702640365; x=1703245165;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gQc2nQaff3+nNgN8+arHKo5874O5b2KMs9FYFDq9HyU=;
 b=aoUhXlxPotuvd62o57r5OuM7NcDmsNEen29EGiWgm7kw7t1ZbkkwOTPSBMZN4nFicZ
 3e8W64lKnniztWsP8x+Tk+sdTl0Fs7ZHGwweArHWmBsE6223moFjxDd5tJDL/hP+Kbg9
 unlsWMnFpwbxzTpBDd7O1QjkQ9J+Gbk364NH0oRM0aLbLEeu30vsL7IJfcd3mVPoLmB0
 lq/2/G9LgY/EU75OvsQGdHRJykJM4Iynh7mBgslQM33Xng44V6M7pPPY7QusfYthG2kA
 VPw3pRn65/AZnRHcfKh1JPK1WeBHPCwEru4gwO5qoLqisKsA4Zg8ZC2YaMSiM6gGWo7t
 pjAQ==
X-Gm-Message-State: AOJu0YyY+gIk+X8zDs/G9e0W96LmGb9U/bNsomnlMF1IBCL6XgqAOUIR
 05kTIQvOVirgVP3rQcNWKb432w==
X-Google-Smtp-Source: AGHT+IHbZOUQb7godLLSGsrGKzQyAsSz5ppz1mcai28WEbs9VT7O2a2MQg5i7IArMuvgrbQ7zUy/mw==
X-Received: by 2002:a05:600c:2147:b0:40b:5e1c:5c22 with SMTP id
 v7-20020a05600c214700b0040b5e1c5c22mr5847517wml.55.1702640364886; 
 Fri, 15 Dec 2023 03:39:24 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l39-20020a05600c1d2700b0040c2c5f5844sm28983268wms.21.2023.12.15.03.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 03:39:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3099C5F7D7;
 Fri, 15 Dec 2023 11:39:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH] accel/tcg: Expose translation block flags to plugins
In-Reply-To: <17a36db2c85e46b9bcb380eb6d1f4667@yadro.com> (Mikhail Tyutin's
 message of "Thu, 14 Dec 2023 10:37:22 +0000")
References: <20231122121655.20818-1-m.tyutin@yadro.com>
 <87edfrd2yw.fsf@draig.linaro.org>
 <17a36db2c85e46b9bcb380eb6d1f4667@yadro.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Fri, 15 Dec 2023 11:39:24 +0000
Message-ID: <87r0jn8zkj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Mikhail Tyutin <m.tyutin@yadro.com> writes:

> Hi Alex,
>
>> > Exposing appropriate translation block flag allows plugins to
>> > handle "memory only" blocks in appropriate way.
>>=20
>> We don't want to expose internal details to the plugin. It shouldn't
>> need to care.
>>=20
>> Do you have a test case where you missed counting the execution of the
>> instruction?
>
> To speedup plugin execution time we want to shift processing logic to
> block translation phase and keep execution callback light. Also moving
> instrumentation at block level as opposite to instruction level, helps
> to speedup up execution as well.

The trouble is we don't guarantee that any given block will fully
execute every instruction. To be sure you capture every instruction you
need to instrument each one although as you point out this is expensive.

We do have counters although currently they are not atomic so can only
give a gross overview. There are plans to add a vCPU indexed score board
to solve that which will be a fairly lightweight instrumentation.

> Given that, we prepare structures in translation callback. For example:
>
> void handleBlockTranslation(qemu_plugin_id_t, qemu_plugin_tb* tblock)
> {
>     BlockStats* s =3D new BlockStats();
>     s->init(tblock);
>     g_stats->append(s);

I guess this is a natural approach given we present a block translation
event but even without IO recompilation there will be multiple
translation blocks for any given set of addresses. We should make this
clearer in the documentation.

About the only thing you can be sure of is blocks won't cross page
boundaries (although I guess in future they may in linux-user).

>
>     /* Then, insert execution callbacks and pass BlockStats as
>        userdata for quick data lookup in run time at:
>         1) basic block prologue:
>            qemu_plugin_register_vcpu_tb_exec_cb(tblock, cb, flags, s);
>         2) memory load/store:
>            qemu_plugin_register_vcpu_mem_cb(tblock, cb, flags,
>                                             mem_flags, s);
>     */
> }
>
>
> Having artificial "mem only" block leads to allocation of new
> BlockStats and memory access will be attributed to that block instead
> of "original" one which is supposed to be executed. If we know that
> block is "mem only" on translation phase, then memory callback is
> implemented differently to find relevant BlockStats.

The alternative would be to have a page tracking structure based on the
qemu_plugin_insn_haddr of the instructions and aggregate your data
there.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

