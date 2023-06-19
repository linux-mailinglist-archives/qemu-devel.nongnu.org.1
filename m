Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F01BB73508D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:40:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBBMP-0003YR-43; Mon, 19 Jun 2023 05:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBBMM-0003YG-IO
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:39:42 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBBML-0006i1-2I
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:39:42 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-519b771f23aso4462335a12.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687167578; x=1689759578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YRDsdftzZyZshVdLzcsOBJYbdqG3jtzn1cm3PkkrDyY=;
 b=jNCtFuafO9/Xhbb3so8xR7b+/Oz7sGIbduTlIr14ftIj+cyg0tXAltq/nHT0BrVSPi
 jZoqsf9vlNJLLrzZeKnZEkcNr8YJBEnRhvgLW/BqAJ+y8Z9QBti60FSVJ/xwRkliRi0m
 Cv/yepSAqTxOYg/CyE8Hy0/rMsbtVQZE+UkgypNOEblTnkSTkt1r+uopNp/ggD1zU4iG
 IhUD0mVFd4AzkiOP8HlMKkHgR4NrTXCtx5CbgwBXPsck21UslOphnSKo2O9rQrNpeCpJ
 uNbapoviN8fPvMHepgQEMz7c1BEzd3BEuXR0bUjmJ1umcQuRtC76j94yFXLLfs8vfd/4
 JG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687167578; x=1689759578;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YRDsdftzZyZshVdLzcsOBJYbdqG3jtzn1cm3PkkrDyY=;
 b=OZ0zT70J2gcJkjxG46o02hyBbhJ4pWL0Py7QYdgc5rFoGfeIR6S9/tY7TxGwbIRx8c
 Gl5t+IuC+xub/ATS2ZxHvmQmk1hiY9YwruAyrzU3vVVY52+4ws8wJpveCY1ID6f5wff/
 LVE6Tm8CSE3gEVIBa8QRANdq1Ac5BVdCgWxqNz4RxnnbnosNtBDlhhlSRykfSiswglQX
 uxtBX2zVJf5Rcp+zGGRvRTmQaycHW9olkXl62jGFCG7t5y6s1GiRAKd71pGFbxoLpdb+
 oHr64fd1vH73vqFM+50dfrQsbuiiISnJeY9Yl8z7pVKC7ePGb/r3z6PqXzt1mu8hTsX4
 4PBw==
X-Gm-Message-State: AC+VfDwdpKf6tWK510RgoUhB/GB06gVfGxc3q52r8qQYJS/+YbD6hMFG
 MPfjABFgYjQeN4rk7wbVAtT9fJeaRHkV2lEQnaptRg==
X-Google-Smtp-Source: ACHHUZ46SO6LL4g0QSVH5oPo7Xsk5LJwB5jLgqZRO1V27HG12VLSOhMoCFZVtA7UpS+bkEqi/3sr6+89y+DRgs+/YE8=
X-Received: by 2002:aa7:dcc6:0:b0:516:4098:66f4 with SMTP id
 w6-20020aa7dcc6000000b00516409866f4mr5749576edu.18.1687167578322; Mon, 19 Jun
 2023 02:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+V5jYVVhPubovF8An+6cuDbiv2mrxtRmWfUujbnEo3q63u0XA@mail.gmail.com>
In-Reply-To: <CA+V5jYVVhPubovF8An+6cuDbiv2mrxtRmWfUujbnEo3q63u0XA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 10:39:26 +0100
Message-ID: <CAFEAcA_RBMjZQ_iCK1ubL_RMXokcVtSpFex8hafZLfNhMe=3+g@mail.gmail.com>
Subject: Re: The real function of calling cpu_io_recompile in non-icount mode
To: GanDalf LeBron <lebrongandalf@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sat, 17 Jun 2023 at 15:53, GanDalf LeBron <lebrongandalf@gmail.com> wrote:
> As said in the comment, instructions doing device I/Os must be at the end of the TB in deterministic execution mode, icount mode or replay mode in other words.
>
> But cpu_io_recompile is still got called when I disable icount opt. The corresponding MemoryRegion is apic-msi with the access address fee000b0. Why is the cpu_io_recompile called in non-icount mode?

cpu_io_recompile() is only ever called if the CPU can_do_io
flag is false. This flag should only ever get set to 0 if
we are in icount mode. So if you are not using icount and
you end up in that function then there's a bug somewhere.

thanks
-- PMM

