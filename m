Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0832710975
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 12:07:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q27qn-0007vq-MN; Thu, 25 May 2023 06:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27qj-0007tt-Ax
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:05:37 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q27qh-0003v8-Ld
 for qemu-devel@nongnu.org; Thu, 25 May 2023 06:05:37 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-50bcb00a4c2so3515029a12.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685009134; x=1687601134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=N5Vp1FQA5Pj3pdinX5mQO1qAqFA2PIXogTWP4Vq7diw=;
 b=QdNQmncRtZWbe9SCnt4CIOj56oGTAOLZvG6LecPDWpVbfTOorisArxYE9Bq8xO10Z1
 rVA1BrEAFW20AEmP/cQaUI71Nw2cOETPTAvDxZjh/9yiIcsLcWr6tEJLc/f4ZQFYnIOA
 UAbAYqOT0zhFhPOvRvKAxokUAP3UU+uqnRXasXkeA1A6CzAsbJTRi3Y0mS7DwXiPB42M
 X5PeSV9hBYXX2MbTlk/0eykcgGQz7aP0oBSmFK1NJQyATiLexOUAWlJb5nXlsx8942HK
 x6fuutjS/d0V/SV6C2fdCis2B+r7tHwEsWg7mEl2C3M+H6Dwc25SCtqihEaZ8xlCYYZG
 szKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685009134; x=1687601134;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N5Vp1FQA5Pj3pdinX5mQO1qAqFA2PIXogTWP4Vq7diw=;
 b=VnsNyTg2FHr/1DUq4q7gpTZSxgj7I1L7cC8Ca8XchlY8eL8EUXBHUKky9VaFsEkrwD
 Mju72xWxon1oeF1JUiIKSxJYD67wrASw5+zfCI3cteTO0dE25lEELCefBAOnq4e7N/Pi
 bxIdrKF0gdMmoWj9RpzsvXKQm5rkAuoYHN3b3istN09SVgGOGR1ikGHqcuDZkSgVso/Z
 oHCm09Pdj5eGK1eKp75v1AmZ6DhMvSTIhVNDlRHFLE1uzSoZaZAd7y4mzvWXVGKbydAF
 pHaOWzblSEB8+aDQPV7rNz7Evz5JO2PVg96Nx7WM/mPLQ6V4L8IG2m33rM6Q2Mi1C60M
 NdsQ==
X-Gm-Message-State: AC+VfDx1SDWoxAoyVTpuZJdnLXENUAw4WS+uMXBVEHNbMxOEeB1HSiIK
 BqHJOpFPC7CgSlkxnfUqUORHnW961QkgcbqwLr7yqg==
X-Google-Smtp-Source: ACHHUZ5CDdNzkLaCGhG+2QsHKx7JGXJcvH0xxWIpz3Q3fpqYzzhT9qd1QTZNTkoizHCZR9yPWOildo/r9YUOFNix7Ts=
X-Received: by 2002:a17:907:da3:b0:967:21:5887 with SMTP id
 go35-20020a1709070da300b0096700215887mr1062135ejc.40.1685009133930; Thu, 25
 May 2023 03:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
 <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
 <4101dedc-91d7-1735-4655-81082931b79d@linaro.org>
 <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
In-Reply-To: <49fa8502-70f9-cdc4-1058-9d4202400db6@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 May 2023 11:05:23 +0100
Message-ID: <CAFEAcA8OUP9vnJwRxcT7AUWPD5ANhc17ETgePYPe2=-N_ZvCsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
To: Thomas Huth <thuth@redhat.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 23 May 2023 at 19:41, Thomas Huth <thuth@redhat.com> wrote:
>
> On 23/05/2023 19.30, Marcin Juszkiewicz wrote:
> ...
> >> (is there a reason why it can't be disabled with "-vga none" or
> >> "-nodefaults"?)
> >
> > That's something I need to check how it should be done.
>
> Other boards set mc->default_display in their ...class_init
> function and then use pci_vga_init() (or vga_interface_type)
> to instantiate their default display adapter ... however, that
> does not seem to support the bochs adapter yet (see
> vga_interfaces[] in softmmu/vl.c).
>
> Not sure whether it's worth the effort to extend vga_interfaces[]
> in vl.c

Isn't that a legacy-command-line-option thing? I feel like
the recommended way to select a different graphics card
these days would be to use -device my-pci-vga-card ...

thanks
-- PMM

