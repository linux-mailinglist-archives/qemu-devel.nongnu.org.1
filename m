Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E247B18285
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 15:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhps8-0004HR-Hg; Fri, 01 Aug 2025 09:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhpiv-0007xI-Oo
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:23:03 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhpit-0006gh-RM
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:23:01 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71a27d982f1so16610017b3.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754054577; x=1754659377; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ad9oc528en/hJJDMwKIiVMd3S6Db/sq6Vub6RVo6SOA=;
 b=dTpxm0bO2LM1mMlv40CfF7Ep+/eI1/o6jjn1qs7JI7UX/8OkruS42GXo5AEvmTcnSY
 nL/V5Xrzl/G5lx+dkzp0RAskgsPcy9CjVbqVcQpjVBGH8V5bfgd6OYrYdym3rqsHBRk4
 wWN9WduZrk8e57RZ+Z636WDpusJ6vA++ELAEofE3ekAcyqDka+DXm6rqbQP9vgi+elxv
 aAVM4j5EjE4pnY5Gov1+cSerR86SzUdv6xprnidlMF4EOtoeIoEL2BSZ/UdyI/lkap9e
 vYIWuyhrxYI0cAUi/hJtkzIg3Qsv+7Fzl7A5fBL9RcWUPCvmd7ptqa3gfy/y96den+te
 /YJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754054577; x=1754659377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ad9oc528en/hJJDMwKIiVMd3S6Db/sq6Vub6RVo6SOA=;
 b=e6fUzF/BhdzMf/lyf1YDVzVMowXPyGONQVLRqO6pZWDibcvShh+kzUrsauIv9owJ0V
 n4C1ttUYPCXHC0bmDxR0mTr4mbIE2xz0wvRle+f8gGquvSrl+Ny/zywEVHDOCRemVMiX
 OIXbmzZeWRdd2G8u9Cm+fdH443vSk/zM7bGTwhSozTAJDSggN6HCoovfONc5qn3g/FNC
 /KvtWaAxI0/PLlcUzU6Vhu/puOPd9onZblmk1P2QqgtZ0A9ErSnnmKhIRhaQb3u5Jcza
 g31/ZrTy+T+aWQNa1u6xTDbe2Z8mbf4WVytuKo7ABK8bNKAEehdsGB53qMWjsxAji4h9
 vTqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKMQJ9TQiKVcLGMzNYot0zN19ieY1+feGYWq1ikADrWbZ3jRpcCWtbyntjTG3Yq+UOb6vx8Pp6X332@nongnu.org
X-Gm-Message-State: AOJu0Yx89E3YxV4u/F4aMltUqitj8a+4lbQO/YcXZTd4HIIxnuMgodSZ
 dNCkuJYxKbByhJf2+QtYdMOgaOTLC/qh6/iaEVcgKCVGIwt2o2Q5rEvfNEWE2Ns5N+SOJPaeye6
 O5+eT0oV5UBKvVIkGOMqPzOddlqG8z7/uykO9xbHjFA==
X-Gm-Gg: ASbGncstPUMmNGzvx7hqj6Ah74egVHQ3Lu3VZzMYcj+DPU1NuJBdY9tAXISAnYKap+w
 61pZzc6lN0RHfJJlTQTD6a8EgRMmesV8AoTErzsSBrQ6eIOTz3gNEOqdQpA046ZzMYeFNyL4Uw6
 aP8Rg+3fU3nPagOvV93YN7WfvLCC9JfZyVmKi8UpZDFQXgBqSJJyNsCAaxlUHLasP1xUXFRcnwR
 uE4TaY10+bgAUgbdgE=
X-Google-Smtp-Source: AGHT+IEYx46HUd+6ppEylqhY3C8HpLnyVhF8U8WlzntKsgyNtceN75sWnQcnt765ikAZn6lsPAT7chDiVkoxE6NDiq0=
X-Received: by 2002:a05:690c:7247:b0:71a:35e1:e1d5 with SMTP id
 00721157ae682-71a465a20dfmr161213277b3.17.1754054577126; Fri, 01 Aug 2025
 06:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-48-richard.henderson@linaro.org>
 <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
In-Reply-To: <b2e40787-6043-4d4c-9cbb-731d0e92e25c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 14:22:45 +0100
X-Gm-Features: Ac12FXxM7sHK_xN2Of-21PhZUdvC9butNBDF6caIVQw0rGNiDReGahOoLPT-HBQ
Message-ID: <CAFEAcA_9tkv1EoM33=G=zW6Pw0gBirvjs-SsDaC8ar8feyH_8g@mail.gmail.com>
Subject: Re: [PATCH 47/82] target/arm: Expand pstate to 64 bits
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 31 Jul 2025 at 21:34, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 7/27/25 1:02 AM, Richard Henderson wrote:
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 64ee9b3b56..3cef47281a 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -47,6 +47,7 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
> >       case 32:
> >           return gdb_get_reg64(mem_buf, env->pc);
> >       case 33:
> > +        /* pstate is now a 64-bit value; can we simply adjust the xml? */
> >           return gdb_get_reg32(mem_buf, pstate_read(env));
> >       }
>
> If I'm correct, we currently don't expose PSTATE through gdbstub, but
> only CPSR. This was a bit confusing for me, considering that CPSR is not
> even supposed to exist in Aarch64.
> Maybe it's a good opportunity to expose PSTATE instead, which could have
> a 64 bits size. This way, we don't break any workflow.

Architecturally, PSTATE is simply an abstract bundling together of
different information: it is not a particular format of a value,
whether 32 or 64 bit or otherwise. (This makes it different to
AArch32 CPSR, which really is a guest-visible register.)

The thing that *is* defined architecturally is the SPSR_ELx format, which
is where various bits of PSTATE get saved when reporting an exception up
to a higher exception level (and which is pretty much the AArch32 CPSR
format when the lower EL is AArch32). (Note that not *all* of PSTATE
appears in the SPSR_ELx: for example the SME SM and ZA bits are
considered part of PSTATE but they aren't saved into SPSR_ELx.)

For convenience, various pieces of software pass around information
in that SPSR_ELx format. Calling this either "CPSR" or "PSTATE"
is not really correct, but either is perhaps less confusing than
calling it SPSR when the context is that of the code running at the
lower EL rather than the higher.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/kgdb.h#n41
suggests that expanding the existing pstate to 64 bits is probably
likely to produce problems. Perhaps we should define a pstate_high
or something for the top 32 bits?

(I'll see if I can find out if anybody's already looked at this
for the native debug case.)

thanks
-- PMM

