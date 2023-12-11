Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2698E80D425
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:39:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkFW-0004oG-7q; Mon, 11 Dec 2023 12:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkFH-0004am-UT
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:39:09 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCkFF-0006YZ-VG
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:39:07 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d331f12f45so861855ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702316343; x=1702921143; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+IRGE2vb+MUMHJoj2yqYmZwS+dppCVu+JyfGw4/sUU=;
 b=HHI8q0qcgUL6nx0qf+fBRDnCOBxlpSrcqb3MhQjbW2kulgmm2YznC5PJthXwe3vGTN
 cK8eTQWmqP52IGSdeW8yerO2SDe2wB/7EHbjndVIUdyCFU31pGDQD/XkbMDDeu/ty3wl
 SPHrraesaD2cSs4avxAFW/Nz7mTl+GsL3nq7Ns1Qp1tPWJuS03biRy2mWn+9Q1n90aGR
 w8D7IVk31HXZFfJY/z2rjI305WuZb6OfzccgmEbgV+2lwy+Pp1bdXS+xyXDDux0bG3td
 a6OqY9EsO1Gx7/MDUCavkEYSig76wguf3UXkmvdu6yscQMjqRvpVez+Il1vbW6eE2FTs
 o+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702316343; x=1702921143;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+IRGE2vb+MUMHJoj2yqYmZwS+dppCVu+JyfGw4/sUU=;
 b=HIav1yBCjTIJhJ1lEDt8zv5OTwV90ry7s1YH4I+wHzwgcB6kHk1VScx+DWUAOQDBRT
 Xe8z34zggj62Hn07SMIuxALeEl8WVDcXVIv1it61QEyI01p8xivTHzKHeKt8M5UIGpRN
 wUxqt8PPR3PUlDK/v/hmS6UXYXAjNTGLXMueR+W8lsRtsr+1/ruPKcbAz5k3p+iR/mkB
 0u+G/9j6Nv1IowgQqXltpYzaAaSL2XrOceJ8UNt7kiPR3UuRRvA58tzPsnxpacGuBwRr
 S7sP7ReHjz3SnyvBqeRBpXdu+hVNtao2zIOX+nlWrdFvMTrMvr+HUmkGoHcaeMSgqLlF
 Fw6Q==
X-Gm-Message-State: AOJu0YyEr7BOZKlWHTuWIFuTUpmiXBvabNmqHOuow8mUqs7zduHyiO2H
 0seFS8CL3a03fT2A1+SBlTNAGQ==
X-Google-Smtp-Source: AGHT+IFCvh1V1KsMrkgplqfDlXajURPBCY8w0PO4FQMiVCFaQUYLlFKbFqoXh1r6t25rRozsRUvASA==
X-Received: by 2002:a17:902:ba86:b0:1d0:c345:c19b with SMTP id
 k6-20020a170902ba8600b001d0c345c19bmr2278885pls.30.1702316343504; 
 Mon, 11 Dec 2023 09:39:03 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 g13-20020a170902d5cd00b001d1d6f6b67dsm6926698plh.147.2023.12.11.09.39.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 09:39:03 -0800 (PST)
Message-ID: <fe6de301-2d5e-4af8-bced-def74bc0e47f@linaro.org>
Date: Mon, 11 Dec 2023 09:39:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] replay: stop us hanging in rr_wait_io_event
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
 <20231211091346.14616-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211091346.14616-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/11/23 01:13, Alex Bennée wrote:
> A lot of the hang I see are when we end up spinning in
> rr_wait_io_event for an event that will never come in playback. As a
> new check functions which can see if we are in PLAY mode and kick us
> us the wait function so the event can be processed.
> 
> This fixes most of the failures in replay_kernel.py
> 
> Fixes:https://gitlab.com/qemu-project/qemu/-/issues/2013
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk<pavel.dovgaluk@ispras.ru>
> 
> ---
> v2
>    - report failure with replay_sync_error
> ---
>   include/sysemu/replay.h      |  5 +++++
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   replay/replay.c              | 21 +++++++++++++++++++++
>   3 files changed, 27 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

