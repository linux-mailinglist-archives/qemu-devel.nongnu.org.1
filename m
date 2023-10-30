Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C57DB8FB
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 12:31:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxQTR-0006xb-Fw; Mon, 30 Oct 2023 07:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQT9-0006uc-QD
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:30:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxQT7-0003Mp-IN
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 07:30:07 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so7412547a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 04:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698665403; x=1699270203; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XH0mjIurC2/2e2Gv3gQhDz3KLzRzuGJTtRt6Fcrm2JM=;
 b=K+/i7NClvK4S7azNXKMI11m9pHQDZq4E+tETrU0aOSKt0dp7c0CsTDSLjXxDMI5W1J
 A3bLBWu+7F+I1zo7x1RaKgCUxPtRwcaB0SJTLVQpv6FADY2+zjvH54Hc2tJTWC4a+/oI
 xJIUhaYX56BVoTdrog6gLoRG+2SI8tiGaCmcgvu7uZlbHoYvpGlU89hAGEDstMSrm7+Z
 6Zr9UrSnrM+yUCBHjqNNuIoiQ8b8ir6yflpnvytlDg8XUKUx3Ue/ZBF8qMIljnWarU2k
 X1+6jOxVHtz6ipFBSqDRXV3DAdKsv1BWuVUYqQzCF3FdkyDhYT800eIhbmq2NhOKyVP4
 offg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698665403; x=1699270203;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XH0mjIurC2/2e2Gv3gQhDz3KLzRzuGJTtRt6Fcrm2JM=;
 b=NWbb1nm2dIrjSF3elYSc7bPXMAcOrP7JEfP46Fvo9cd09zE5hF6FFRlrM5EItmqFC7
 twHhFPDK94OqAa/FGXQ9IchLHkKE9OPPn4YxJ9FTV/mQBNsED2K90E/aVKVLGrGzV9l4
 xi7jbuPAsxhgqtc21xp9qApjuYSS9O47EymVbPVjXCru9GMLRUc9leUbXoChzXx81x9L
 L50AT8kmvfbDqIF6FoAv1sUpVFUQwH1nZlklCDknvEcF3tIoMu13CtK2GQI9k964i/DH
 9tD0F5ZfrM2QfFlhJQG1HUt/jOsRodDhMU4yLfKRh0BExEMSnc687Krsi4Lr0w2SG3vd
 p1Gg==
X-Gm-Message-State: AOJu0Ywo4oXU/6Pt6bZdcn45Z9+qL4kiSO8DodSAISfdmqEZNnJkMVXJ
 fe51Vv8E1ZyAQX4A1Bv3sa7NwePFBrQE4aSa0sAmnA==
X-Google-Smtp-Source: AGHT+IHP05wP33YTIcXNI5AhWWLHrz/jB1Eh7daUQ6D6TRtB0OUSc7o4D31I87XXG/GZbj/puVdJ5A+6I5/W2/Por3A=
X-Received: by 2002:aa7:d806:0:b0:522:38cb:d8cb with SMTP id
 v6-20020aa7d806000000b0052238cbd8cbmr7772761edq.20.1698665403686; Mon, 30 Oct
 2023 04:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231017122302.1692902-1-peter.maydell@linaro.org>
 <f9bdd29e-208c-3df1-d377-ce2619655d68@linaro.org>
In-Reply-To: <f9bdd29e-208c-3df1-d377-ce2619655d68@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2023 11:29:52 +0000
Message-ID: <CAFEAcA8bt310iLHT_A2zKLc7+mJ=uHwYQR9Fn7r3ZEX+bPW3Hg@mail.gmail.com>
Subject: Re: [PATCH 0/6] arm/stellaris: convert gamepad input device to qdev
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 30 Oct 2023 at 10:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 17/10/23 14:22, Peter Maydell wrote:
> > (I had this all ready to go before I went off on holiday two
> > weeks ago, except I forgot to actually *send* the emails...)
> >
> > This patchseries converts the stellaris board's gamepad input device
> > to qdev. This isn't a very important bit of conversion (I was just
> > looking for a small tail-end-of-the-week task), but it does reduce by
> > one the number of users of a couple of legacy APIs: vmstate_register()
> > and qemu_add_kbd_event_handler().
> >
> > I've included Kevin's qdev_prop_set_array() patch here, because I
> > wanted an array property and it doesn't seem sensible to write it the
> > old way and have another thing that needs converting. I'm assuming
> > that by the time this patchset gets reviewed and committed that
> > one will already be upstream.
> >
> > thanks
> > -- PMM
> >
> > Kevin Wolf (1):
> >    qdev: Add qdev_prop_set_array()
> >
> > Peter Maydell (5):
> >    hw/input/stellaris_input: Rename to stellaris_gamepad
> >    hw/input/stellaris_gamepad: Rename structs to our usual convention
> >    hw/input/stellaris_gamepad: Remove StellarisGamepadButton struct
> >    hw/input/stellaris_input: Convert to qdev
> >    hw/input/stellaris_gamepad: Convert to qemu_input_handler_register()
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Thanks. I actually have a v2 of this ready but am waiting on a decision
about whether the qdev_prop_set_array() API is OK before I send it.

-- PMM

