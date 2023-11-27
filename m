Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 373D57F9FAD
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 13:37:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7arR-0004NY-CR; Mon, 27 Nov 2023 07:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7arK-0004Mr-Ld
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:37:07 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7arD-0001S7-Kz
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 07:37:06 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50ba78c7ee2so2938837e87.3
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701088617; x=1701693417; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fBlMH/7hXY2ZBviGXyjj09bMAoEvI34GbO7oVLJqLQw=;
 b=pi4qgyjDINUvuVGX52EpvNncQNYNsqJ9dWSKGpsQdpE6mYNgNbKSxAYGe8WqBQd1CG
 ni9zb9LWFkJJg7UTT+kKckQngXU4dA4sbYnIz8LKCUlq8z4oaoLJ+A1cj/XcIHQQHnQP
 5JuZePI39F1e6vFEoIb/WhQnickJ8WW60ONlLykDzJa/0OmlOOiAFs13Q0gNUDav6WrA
 pUjPhVfXQQxnaEaZTkh9MDalUP86H7POHX2vjOYjMjfDTVZdsRG7R9x2te7pSiMqW5V5
 17seAfmd3wrky+2aGLs33YjOeiSEdPSJQ8bP0WNICthtDFCsXEETa14TgoUKUnje5R6P
 0qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701088617; x=1701693417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fBlMH/7hXY2ZBviGXyjj09bMAoEvI34GbO7oVLJqLQw=;
 b=dpGBdp6m4Lzyx5jAsVDigubGFsGQ9WvO8I3O1XlbGFLNpQGxi2D+kHmRkWb5LUkHm+
 h9rz4OYe0+h0zPy5FOqiNprWIdzI7LdNGrZ5xNLVvF/mxQxmQ0/GlA/L1wtZb242rg4f
 BzPHV/lOepZiDBqpnp9aGdcaviGM2TmweL1015vYfvm4GtSpKum6s4hVV//dYBv0UUPW
 USPHruf+bFBLx37VXI6JW0Sj18o3quVxwzWNQNpZuaA2M7FFbb6SgVh8dUre/7RcxTOY
 0QhoDFJlv1rV4UgWB2RgP8dln1605ru8TvR0aaYIgSA9P+9H5mLx3Nxt0sB+/xbmylI3
 kmVw==
X-Gm-Message-State: AOJu0YyoxhIjYk9vPYZOHfIq3gutcQzKoXb0mmM4ObrWwrfb40UklDYQ
 H5PGLCd1rbYFgdWf3uvLu8Lbb88Ws8vJnyWPUPPd0A==
X-Google-Smtp-Source: AGHT+IG/RCjhNMNdQpb/0xDnKw0+ssU6nOqI3PuzugS+9xi2AuYtHxvEpNf8V3DtlHR6ziXGeJFraWdPlhQF3ftPwFU=
X-Received: by 2002:a05:6512:2343:b0:50b:a697:33dd with SMTP id
 p3-20020a056512234300b0050ba69733ddmr6348235lfu.35.1701088617541; Mon, 27 Nov
 2023 04:36:57 -0800 (PST)
MIME-Version: 1.0
References: <392b2fb5-1747-0f73-826f-b410cdc84f07@redhat.com>
In-Reply-To: <392b2fb5-1747-0f73-826f-b410cdc84f07@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Nov 2023 12:36:46 +0000
Message-ID: <CAFEAcA_F9+XDA_5_oyqqpjS+iaeOx=J05WsZ0QMB0016rUzDfw@mail.gmail.com>
Subject: Re: hanging process with commit 69562648f9 ("vl: revert behaviour for
 -display none")
To: Sebastian Ott <sebott@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 27 Nov 2023 at 12:29, Sebastian Ott <sebott@redhat.com> wrote:
>
> Hej,
>
> qemu fails to start a guest using the following command (the process just
> hangs): qemu-system-aarch64 -machine virt -cpu host -smp 4 -m 8192
> -kernel /boot/vmlinuz-6.7.0-rc1 -initrd ~/basic.img -append "root=/dev/ram
> console=ttyAMA0" -enable-kvm -device virtio-gpu,hostmem=2G -display none
>
> ..which I've used to debug a potential virtio-gpu issue. Bisect points to
> 69562648f9 ("vl: revert behaviour for -display none")

Is it actually hanging, or is the guest starting up fine but
outputting to a serial port which you haven't directed anywhere?
The commandline is a bit odd because it doesn't set up any of:
 * a serial terminal
 * a graphical window/display
 * network forwarding that would allow ssh into the guest

If you add '-serial stdio' do you see the guest output?

thanks
-- PMM

