Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C285A832D6F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:45:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQrz3-00013M-0P; Fri, 19 Jan 2024 11:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQrz1-00012o-2L
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:44:43 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQryy-0002Zx-Ge
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:44:42 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-55a02948940so1198595a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705682679; x=1706287479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eXuN9e1ZQ2uqJ3hGcaovuoOhEo/LMkXlhHGSYQHwpzk=;
 b=b5W/0Wp2gTpn2EDZcScAnHnjlCWY+hseFjBl8a1NaUZhXoAwXzCIvWw/ETP3yWmZxq
 jt5vI4YREo4Ik/0lyDavkIqPtSac2DgU+p1Nat66GpiOWjY5P8CtRuL7rIORzjVP3BUV
 LKtgJGh3aKvNN3ACOHd5fo6CaD7+TqzcWlEz7mc9tntoiicuTJLYB+tmivAoTbhqUJOP
 bG/1AShDN1AflPRJNB7Bc+9vQs/oHBnUKBhDbN9y4eLLEQytrqBWIyExLhsaPd6yKqLh
 91mSiBkEBKyjOhEAXElytQTiASe5kvZchkSBvBSlSgihY7DpFqhBUFoFq1MbQ14LC/XG
 uh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705682679; x=1706287479;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eXuN9e1ZQ2uqJ3hGcaovuoOhEo/LMkXlhHGSYQHwpzk=;
 b=a8dDQK0+ObJRD4o8KTLc3D2u7nZF2Kd8fE1B/qgLC4y9ftZs5KfayjvkiT/3+/YvaW
 lSVEld06145jlfvSBVOaKmzfX8gXbJrdZvx0TjNMeObJMQgtgEmaEvAzcqYmbVhTAPT7
 ve7HiLI37VfCDL9K1nm+71PYt/gNehEYXb5fOtdPLnSNsn/xeKR5VTu/yw+sTXcbc94Z
 tndM/DNfDJWL1F4uKT1XhvcAKX1Du6eCyGMCMYH+750iNScDKeRPpLpITB3eicH1GsDy
 o7sue1vLtDordzP6yHGRMQmvC+nkQ/DUsErBertGa9UO6tjzC+RB8Ug6w3nhPH+kuGoN
 quXQ==
X-Gm-Message-State: AOJu0Yz4g6YfP45w4Ttf/u3hrJBREnCVvhL4/JOdHulsstI9F/Xuf3hX
 babgmyLZBxyUzI3bXcA5cIi5799YzhTKOD+hJumkCbnsbu8TZMZEckw2jEP15VjwJxYKrpxvhIF
 CGv3WZeq+DxvVapQYEcA9QDGPFEDLCqlSK0rXmA==
X-Google-Smtp-Source: AGHT+IH9AO6kqvfHg88Tk77iluDE8U4ikkd92tJeJRX0IRhgRFVuAfPUndu2no3Xcxanb6de6mohXtiXDS+ecQcKHtg=
X-Received: by 2002:aa7:c556:0:b0:557:9018:9980 with SMTP id
 s22-20020aa7c556000000b0055790189980mr17465edr.52.1705682678904; Fri, 19 Jan
 2024 08:44:38 -0800 (PST)
MIME-Version: 1.0
References: <20231215120307.545381-1-jcmvbkbc@gmail.com>
 <26c8ddf0-fff3-4a56-a9e2-f6aba20b773e@tls.msk.ru>
In-Reply-To: <26c8ddf0-fff3-4a56-a9e2-f6aba20b773e@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:44:28 +0000
Message-ID: <CAFEAcA_We2b=FSDrpRjRRBgjmoDOPJdCuCgCfExt73n8UzsiYQ@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: fix OOB TLB entry access
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 18 Jan 2024 at 08:01, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 15.12.2023 15:03, Max Filippov :
> > r[id]tlb[01], [iw][id]tlb opcodes use TLB way index passed in a register
> > by the guest. The host uses 3 bits of the index for ITLB indexing and 4
> > bits for DTLB, but there's only 7 entries in the ITLB array and 10 in
> > the DTLB array, so a malicious guest may trigger out-of-bound access to
> > these arrays.
> >
> > Change split_tlb_entry_spec return type to bool to indicate whether TLB
> > way passed to it is valid. Change get_tlb_entry to return NULL in case
> > invalid TLB way is requested. Add assertion to xtensa_tlb_get_entry that
> > requested TLB way and entry indices are valid. Add checks to the
> > [rwi]tlb helpers that requested TLB way is valid and return 0 or do
> > nothing when it's not.
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: b67ea0cd7441 ("target-xtensa: implement memory protection options")
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
>
> Ping?
> Can we get this to master before Jan-27? :)

I can take it via target-arm.next, I guess.

-- PMM

