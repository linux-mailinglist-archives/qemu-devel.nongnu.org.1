Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4295E777EB0
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 18:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU8zR-0001em-B1; Thu, 10 Aug 2023 12:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8zQ-0001eG-Ce
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:58:24 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU8zN-0004WZ-Ta
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 12:58:24 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fe4762173bso1773456e87.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 09:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691686700; x=1692291500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F0EpfFwz2Z7kcnGFjrsdZJ6XyL+iIeDh+uooFFhmqWw=;
 b=en3v9RaXVIhRG2iL56ZBL/ltnZrA86ztYFFywJE4O983aUBfa3yWlAVt6FWL2SVzop
 FnSgAwy4bkzPYE3dGYb+V3QN8zJ8p4n05KXveNilf6ZdOR9msN2K+W858gVw7tiJEWgW
 QnA0kC8MdlA6EHYmLm2ShH+hRwnK9eUEsesRx6pT3mM6jHhruD2tfwP6ZCexRDTJ7sdm
 kifDpyyDUTJ01pRKr+j0j0XWhQhUXFA4ii2znZqRDCRVz+QSoWf3bZnjSxis3S9KGEcd
 YT+fEqLg6E0B1vcd2TFpBo5h8Un6hKmMKATKjizb0VpQm5NgDRXAZV+ola3VSc8Andbw
 oMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691686700; x=1692291500;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0EpfFwz2Z7kcnGFjrsdZJ6XyL+iIeDh+uooFFhmqWw=;
 b=iW9oZtncLhr1Js38Yqwm3JaFAhuLCu5CV2xarY97UTXytTlwk1L4CY7uI8nxsgal7v
 3WOhE+UNQrOgIU48tJ+oArZ391V1marnyMm5Enob6n2kYECIMtYxM1YDd+h+2ra/LDNp
 X+PnZbbjdv8zhkElkI1zhlka+BeD4pFb2S4LgeUKI+5C5ocRU/qsUG+Lfiaug1WabsSt
 wNS7iVsU2i7tsipgZ8grFR2FtqpcDUsqHnzcgJpb8+akGb+ueB4KsQhl6kVtmpEdUwmr
 YJvt+rLEoCd2p0vrFY0iHFtDdy5bWeHwTcQY65DYgXwcFHkAC7v7Ejp1GX89Zb6xSOvF
 /6fg==
X-Gm-Message-State: AOJu0YyQHaG0LpBIrVTHe9fuZ69sraiEUnION/oBhNZNSA8/dMww6Yz5
 Pcwp/WAfiFzhDq+GXd99anfP87SOgyGdHox7O5V4zc9wY2WG0/Pi
X-Google-Smtp-Source: AGHT+IFwX6F+wsOahFNKIj6yJXtqQU2evxyTCYAGZ5wo1eLzSTONn3wqU6O8VHT+4zZh1xXiL+rKTVVlzhj0nbKSk3k=
X-Received: by 2002:ac2:5936:0:b0:4fe:a2c:24b0 with SMTP id
 v22-20020ac25936000000b004fe0a2c24b0mr2149244lfi.26.1691686699766; Thu, 10
 Aug 2023 09:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-13-richard.henderson@linaro.org>
 <CAFEAcA9dqnaqGrLz804UB8zHSnbCEWwhv1nzvdt_j0CS3=mCSg@mail.gmail.com>
 <6dbafe59-f7ce-12f6-e8c7-eefc7665f598@linaro.org>
In-Reply-To: <6dbafe59-f7ce-12f6-e8c7-eefc7665f598@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 17:58:08 +0100
Message-ID: <CAFEAcA8j=AejoxGSO7wKQH9uM68jpL59KrgfSCQj78-sY3yxjw@mail.gmail.com>
Subject: Re: [PATCH 12/24] tcg/aarch64: Implement negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Thu, 10 Aug 2023 at 17:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/10/23 09:39, Peter Maydell wrote:
> >> +    case INDEX_op_negsetcond_i32:
> >> +        a2 = (int32_t)a2;
> >> +        /* FALLTHRU */
> >
> > I see this is what we already do for setcond and movcond,
> > but how does it work when the 2nd input is a register?
> > Or is reg-reg guaranteed to always use the _i64 op?
>
> For reg-reg, a2 < 31, so the sign-extend does nothing.

OK. Do we document somewhere what a TCGArg is?

Anyway,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

