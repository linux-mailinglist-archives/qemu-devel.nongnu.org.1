Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF12736BF7
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaXf-0003me-BW; Tue, 20 Jun 2023 08:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBaXb-0003lU-H8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:33:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBaXZ-0007Pd-RP
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:32:59 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f90a7325f6so33892015e9.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687264375; x=1689856375;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrHa4OsJdnxBW1ca89/U843dn5OqvgkdWl6vjQ6tfT8=;
 b=q+3c9lZ/3bgaSbbcEIvishik9UGjZ3zs2LezT3mUX+0Qn0YAJv+45y/xaWI8EmdE/d
 yF/CNointApkE+CdRqZKON7AWXNloedBpFyBxSSPAg3VflsXkLsMwRrk8B0VRExOCtZe
 iHX4ntaQSMI6xwh5o47uB4hnbb+iyX7HDok5tnI+QEvU2ZqXyOhi/lm48bsgUSg4SwXQ
 jrRmVrkg1DF4wJ/fN6vIdAykFlH3kNE0oqBZZxV7VhEgQZjbQfzJTO5pYTOvt1pfc3Lr
 n5/aKAAWlvruFSlxi8a1AYCdQwzSMNaiNeeCByKQzKq4Pw/syz4Iq6R4rZ0LcXuuNDgx
 oR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687264375; x=1689856375;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jrHa4OsJdnxBW1ca89/U843dn5OqvgkdWl6vjQ6tfT8=;
 b=OeNqKb+E0Vv7sINaWRo5SZorBJ692Jp0mlrPZMpBBUTR7/Zx1VBUX0WgZJKgo51n0Z
 8qKQXY8Py/A6NlQWA0CAYoHOXRGyDpgtv6ZzK2Dpn7MEFFLhrjdcUleYw1JdrGpQ9Kbk
 NreYSBSrd7b495iNvBvs3Dd+CRGlmHOn1sgqfVJKmGZ1pnpSyqXHXGc3lZPZ7HJg38YL
 WUe5ewrLo9A+8TWAvCJXTLt4hglm0P9VRToM1vlLPZtFX01cxJ72GojB9VhE1D5Oplcc
 udLJU3UK4wxei4r9OtkX0OCEf66h/ATCagO3QvgUtCKJ7Uv6t6chrI7A0U2IDApbOyJa
 WBPA==
X-Gm-Message-State: AC+VfDzx00o99r13kQ4I3jl+88z1Ap6T9QKaqOcckw/U2kB9CKPYOib5
 hizq/eMIEkcrJjmiJNsIuL3Clw==
X-Google-Smtp-Source: ACHHUZ4c8lQnoO911aM3ax6+IG+oSlq4CBi9Sin4xENek7Zdd9XD9oHsMft6nsmKLVm3s/OlwQ5J1w==
X-Received: by 2002:a1c:f317:0:b0:3f8:fc96:6bfd with SMTP id
 q23-20020a1cf317000000b003f8fc966bfdmr11236958wmq.17.1687264375620; 
 Tue, 20 Jun 2023 05:32:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a1c7403000000b003f8d80ecc5asm13350731wmc.12.2023.06.20.05.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 05:32:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0B4391FFBB;
 Tue, 20 Jun 2023 13:32:55 +0100 (BST)
References: <20230620083228.88796-1-philmd@linaro.org>
 <20230620083228.88796-2-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH 1/2] hw/i386: Remove unuseful kvmclock_create() stub
Date: Tue, 20 Jun 2023 13:32:50 +0100
In-reply-to: <20230620083228.88796-2-philmd@linaro.org>
Message-ID: <87jzvyiaa0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> We shouldn't call kvmclock_create() when KVM is not available
> or disabled:
>  - check for kvm_enabled() before calling it
>  - assert KVM is enabled once called
> Since the call is elided when KVM is not available, we can
> remove the stub (it is never compiled).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

