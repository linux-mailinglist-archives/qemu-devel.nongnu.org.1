Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3B7DF39D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 14:24:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyXea-0000F4-VF; Thu, 02 Nov 2023 09:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyXeV-0000EJ-GA
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:22:28 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyXeQ-0000OA-59
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 09:22:26 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53d9f001b35so1518288a12.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 06:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698931330; x=1699536130; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3LzL2SUEcCWnA7oEvwvUvGvIzPJ+8BZI5QRG0zzFwEo=;
 b=aI7YM10qpe3uVTijKvZzw/9WjsUYJ2/PGfd2BtS4zqruBGW+D+Eq4+UDQmJbwIvR4X
 uvgsspehYVXAYH8va4YhGX64T71Px7HhOs0otdVFfUwKDslRtgbwLiHr7sr1GaA/YLMv
 1PamR6WwueOMF+IM3FzbKGcOGjRj74pRLUnMpf7eXIFvmX2kV21CQ6DnYFDAMbc5Vpeo
 SeH5naVodZH01DeSUA/YAhnKYeI01GF9rmbuOWxHPvVed0NpLTiuaNFzyDxmHeWvEQUu
 mwfYkMWOXBs+6OmhSeYXArL1R/XK+aOXIVesq7qtoeQGvNGMbduFD2fXPZTdcBGJLmgf
 xzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698931330; x=1699536130;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3LzL2SUEcCWnA7oEvwvUvGvIzPJ+8BZI5QRG0zzFwEo=;
 b=OKuMmXmmAopyjCtuvIt24cHBhxlYjJfrE2EQDSLbt2aASW9XqEwqu2rppEHgwY89T/
 mIGs1j17PDcSEF2fGWRRoPV73W1Co3mZfPDaRgLY2Mxbe8aSsvriepa+XWeZR/G0N8dO
 EPcyqbqHQ14w3/OH8fP+clbWFcyt6l+DLtyrZOLI/QX1ccGtgu8BHaUUipeUqMOFhRCA
 52dVq3ITQEhFQhrHLHYXvOSr+Fl6q6eWoqsbiFaW379t0ZIOklmlwjhViflM9yCBEUvM
 0AEoxQx7iYxguDVKsy4mZD5zyAmfzLMToXxtAAjnr1Gb9WlBJ09ZurPV12vbL99ej8WO
 mY0A==
X-Gm-Message-State: AOJu0YxNf1J/s1OkskXiqe1Prm8z6ZA82X62Q5q01q7Hk1T07fJ2GuHi
 7uHsCPls6nMpyU//r12zOunD9CoZJSS12NuN0PnpKg==
X-Google-Smtp-Source: AGHT+IEZmBGH/5aIdq19+l7BkiCTYI7l5GE8V6Y2focswLVtNHT0grc/TJ4cQ6TGIAcogTHg6kHIeBTHa4f8GyiR2Qw=
X-Received: by 2002:a50:9b1d:0:b0:543:b9ae:a0d5 with SMTP id
 o29-20020a509b1d000000b00543b9aea0d5mr3380105edi.4.1698931330419; Thu, 02 Nov
 2023 06:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231031184611.3029156-1-tong.ho@amd.com>
In-Reply-To: <20231031184611.3029156-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 13:21:59 +0000
Message-ID: <CAFEAcA_c5PoxBEHvnc8WfKhy2pVQ8uBSH9TwaTyitWpJUCKOYA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] AMD/Xilinx Versal TRNG support
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, richard.henderson@linaro.org, 
 frasse.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 31 Oct 2023 at 18:46, Tong Ho <tong.ho@amd.com> wrote:
>
> This series adds support for the True Random Number Generator
> (TRNG) in the AMD/Xilinx Versal family of devices.
>
> The series starts by introducing a non-cryptographic grade model
> of the TRNG controller in the Versal family of devices, followed
> by instantiating the model in Xilinx Versal machine.
>
> The series ends with a q-test for sanity check of the TRNG model
> in the Xilinx Versal machine.

Applied to target-arm.next, thanks.

-- PMM

