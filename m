Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6693830BFC
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 18:34:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ9n7-0002CV-Id; Wed, 17 Jan 2024 12:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQ9n5-0002CB-5D
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:33:27 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQ9n1-0004NF-U5
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 12:33:26 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-337c4f0f9daso598116f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705512802; x=1706117602; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7GpVjZPiwPlEl94ohrBHcTjcmC+o1JOMSH9Kk5nWDyQ=;
 b=gS0+CzQgeDMKKReNrKeWVVhvVdixkhS/FlUWpnELEguKy8HQUWem+C9A4duO0ZfAE8
 Rqg55ekWUAkFVl3HncA3ksmOXAnSxY87MYvvHhdEKlOJ1DBLGkZjlchXMwauuBRvcnX5
 uLxyuVOBDaesZ81S52foLeUpUgXJQwg16RjclO5FbSVl7A7Aws1QgWLmrMV6b10RrMUK
 M3hgC8FL+EZVILEoioXl8ZFf/wVGAC/cbSEb0IkFvISRTm5fahZtSeA7Hxus/0YwjzJh
 Yx7kSq84tXdPXPJsKu666+ulxhURWtNSqwgCD71Re4WWtiGq4Hj2QmOhV6kr0psoSmx1
 dMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705512802; x=1706117602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7GpVjZPiwPlEl94ohrBHcTjcmC+o1JOMSH9Kk5nWDyQ=;
 b=F9urIIh2Gp7xTEiSrjEMfXPKWSMgNUoJM2tvzhXh9EuzlBGV2AfoIXtf2YuWTpBI98
 tivhWYsuD+ZMTbxv34wV80v1jnJt6m1TCP9p/y4zIYA7pZCyFQT+wQ9pWehyA/ePm10K
 3XOOKQg35Qew+pdvprvkYr69I5inY4OHTZ7S7bb3UIzt1YrfajTRbZg2Wo+4toLqeBPB
 uapOmm1RhO9JOIYJytiRfZTnXmQ02Sv+B+2AJ8p6eowIAZ1YUkcAf1hOVNYyGKV5xG0V
 T8+tPJWWbTOZcqmOtTo9ntRIw7XXZUJ0wTHC9whop9qCdyWVZf0WaBb76QJN8vPoAlD9
 0vgw==
X-Gm-Message-State: AOJu0YxEn2POYyIQVoPDChLgH+iRFgcXdpqlIwRQ3/D15KXyAUkMm5MD
 OQ31Khsrt2R2IxuvB2tMp/mMdIVYASDCQLR9drEbMVKUWCZ3aQ==
X-Google-Smtp-Source: AGHT+IHiO3XurvEkjDyI+SFyfsyfxpSrYtWM9jCC1T2uTZvn5RrcjKtQ4NXbNlZcf3LiH7JYzqKc7gC7RU2ooQyox9c=
X-Received: by 2002:a5d:59af:0:b0:337:c4d0:a732 with SMTP id
 p15-20020a5d59af000000b00337c4d0a732mr675399wrr.3.1705512802423; Wed, 17 Jan
 2024 09:33:22 -0800 (PST)
MIME-Version: 1.0
References: <8b81d02.69e7.18d164d6764.Coremail.m_o_bz@163.com>
In-Reply-To: <8b81d02.69e7.18d164d6764.Coremail.m_o_bz@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2024 17:32:49 +0000
Message-ID: <CAFEAcA-XfEqMi9BO8X1xKrSs7H7kFJoNFe8H7f9xdz5X12U+Hw@mail.gmail.com>
Subject: Re: double free or corruption (out) in iscsi virtual machine
To: M_O_Bz <m_o_bz@163.com>
Cc: qemu-block@nongnu.org, deepa.srinivasan@oracle.com, qemu-devel@nongnu.org, 
 ronniesahlberg@gmail.com, pbonzini@redhat.com, pl@kamp.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

On Wed, 17 Jan 2024 at 07:24, M_O_Bz <m_o_bz@163.com> wrote:
>
> Basic Info:
> 1. Issue: I got a " double free or corruption (out)", head for attachment debug.log for details, the debug.log print the backtrace of one virtual machine
> 2. Reproduce: currently I cann't destribe how to reproduce this bug, because it's in my productive enviroment which include some special stuffs
> 3. qemu version:  I'm using is qemu-6.0.1

This QEMU version is now over two years old. Can you reproduce
the problem with the current head-of-git ?

thanks
-- PMM

