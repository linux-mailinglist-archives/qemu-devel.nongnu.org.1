Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA65278FD63
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 14:38:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc3Oj-0000Ub-5Z; Fri, 01 Sep 2023 08:37:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc3Oh-0000U7-1G
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:37:11 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qc3Oe-0002CD-HX
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 08:37:10 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4ff8cf11b90so3550521e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693571826; x=1694176626; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jqPBSktY+h3+PVVMWVySJ5BiK+kCaxaXqMZawPApyNQ=;
 b=LI88z5FlFr/LB+yFA8stOwXqqJqGz+qfKW9PC/4dRyiDIRLdbzcJ7Wd6fBh1Hvevsf
 Tcr/2Q0kWL/mH+g32E1XJk06fvgYAHZEupxw2tZZMVgncKp37hL7GdML40bOApiz5cDi
 4DXv0Ymmw+HB5RnuLNb1KcEaxqW6e4J92MIlAhYsXNOhIWeipduaSufZNxpYRgGjHjjw
 PMAtEXGKbBxy+E3VXbvoKVPCVTzBsqPSe1OMbSwFwHP31YV1M6rIkuo+j1VcQdZIPNCZ
 LYe5laDVgODcksJcmrZNTmMDo6k4jbCYHPZUdJk5x0+gjqwf7RBGPqQvbJzNhqbc/87b
 p7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693571826; x=1694176626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jqPBSktY+h3+PVVMWVySJ5BiK+kCaxaXqMZawPApyNQ=;
 b=kbhVls1vtdrjGz8sCkAtm4cruBVuWB2e5AbSQajXApxwRanSc2a9oMWS8kRio6KVtN
 RMgFx09N6ZJi7S0dVQVbSdZ9DcGbx6k5Ik9dzknJInGGZVBQQLeWjAXwaMmDG60CsTv9
 M/thToyazuxD7LICVAjECa5cgTjCiHsqclM7i7Khwz04+TycjQYySeNTLFSp0udfz+u+
 VdBCQCXMfsWDSUz4ar5zBRREPu4Mzqy5c1oHdOqrHYytVczzY8WcmOxshv3rWowyeAyM
 PvfF08LykYSQeKYMPpD0UGwL5aWRzEmZvjGnr6pjEITSJdwYwk7Dx/1NFcpi1URcnYJr
 m4Sg==
X-Gm-Message-State: AOJu0Yy6TNmUB2UUCYSs5jDIhrOjnyHIyfxQz/n+eQb06v0ED2wwORmF
 ZH8n6qa1UzZRaNbnxTgZrY10uN6mzVqldH0+I9KjfQ==
X-Google-Smtp-Source: AGHT+IGBce6yqFRW6Z148BRde7uMJD/F1JVJhSQmaKIQtBGxmVwf8kqS9Kv6RBJiGYdj7ppJckq9UmacL3isv1HG9UA=
X-Received: by 2002:a05:6512:522:b0:500:977d:a4e1 with SMTP id
 o2-20020a056512052200b00500977da4e1mr1223724lfc.40.1693571826499; Fri, 01 Sep
 2023 05:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162621.445400-1-richard.henderson@linaro.org>
 <CAFEAcA_wYBSiBRy6HQaRh7k=UFrnQ=EwSQQ2e=7PJUzfyVp-ng@mail.gmail.com>
 <97884811-7b78-286e-fcec-248430a877b1@linaro.org>
In-Reply-To: <97884811-7b78-286e-fcec-248430a877b1@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Sep 2023 13:36:55 +0100
Message-ID: <CAFEAcA-7GkP-BeqF6tr6GEzkpmz_o1F3QSm2n_bR6KP9M2o7-g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Do not use gen_mte_checkN in trans_STGP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Thu, 3 Aug 2023 at 15:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/3/23 06:10, Peter Maydell wrote:
> > On Thu, 27 Jul 2023 at 17:33, Richard Henderson
> >> -    mop = MO_128;
> >> -    if (s->align_mem) {
> >> -        mop |= MO_ALIGN_8;
> >> -    }
> >> -    mop = finalize_memop_pair(s, mop);
> >> +    mop = MO_128 | MO_ALIGN | MO_ATOM_IFALIGN_PAIR;
> >
> > So here we're implicitly assuming TAG_GRANULE is 16 and
> > then relying on the codegen for a MO_128 | MO_ALIGN
> > operation to give us the alignment fault if the guest
> > address isn't aligned to the tag granule, right ?
>
> Yes.
>
> >
> > Previously we also put s->be_data into the MemOp
> > (via finalize_memop_pair() calling finalize_memop_atom()).
> > Don't we still need to do that ?
>
> Whoops, yes.

I think you still need to respin this one, right?

(I re-found it because I remembered this "writes tags,
doesn't check them" thing and that it ought to apply to
the FEAT_MOPS SETG block-tag-set that I'm writing also.)

thanks
-- PMM

