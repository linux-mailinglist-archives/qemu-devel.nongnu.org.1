Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F7770749
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRynl-0008Qk-T2; Fri, 04 Aug 2023 13:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyni-0008QT-NF
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:41:23 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRynh-0008Br-5L
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:41:22 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5230ac6dbc5so2855701a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170879; x=1691775679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I8DSE+JTnwjzGTqhdGV+2N88MKsz3oqj5aY2BVsl1Lk=;
 b=yDu0lAlRP9QhH6w7lpEZy0Z/JoK1YN+Hu8QtFuf8oZYei9IvlPEKk7Ui/swbqmVCat
 jVEUfLn9xTPCuAlOfC0s4Xp5v6zAkKACZXhYtuRx1RaQNCjUri+r/iu2s9lMXoqiU6Li
 JPosLjVjzaTMcEUZN61NkPP2x4FXyi0T8IHwyf+lW13yfRS6y7cklIjwMNbYtumyK9A3
 ZPw3c1Gv3mztlK5OvD4KQ3pjPfF8SVf9xYQzKZZlr7hAIOlNqSncVe4Hf0ebnU8phs8x
 AIiPRb0nn8REDlRX+WxZu0iVorJUnUjYZg7ITAuCF1Ch8RUAABZVg9ZThewZPXV259NP
 pHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170879; x=1691775679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I8DSE+JTnwjzGTqhdGV+2N88MKsz3oqj5aY2BVsl1Lk=;
 b=N4D8bF2sYkiM/kKZI7iRSKuMNVm+Pz3C6eMaYtZie+oaqPovKnI3SctSLzg2Ku8yVF
 s+vZGMPnVF7xC+Okrq0KSQblUAWXnYeKdQ/89NsBNK7ahUg93lUhIdSeedMPoobQc8ug
 2YL1pComG0GaA1q6xPiUN/gyqkcb745PGJ5oPVJsIv2j42SN2koWRs7XWsWuC2FHxzA6
 xU+lzIZwWk8HmAOYmnt+HYa5sv25c0L1O8MrIQMa8Mr+vZkBf5Rk1356kWeAS+UA0uJa
 p9NSP0hyg47bhaeX6kQZ9p8zKgt8Dxip6kn9U4u9MppX4sjYVMcnq3c+pqchPCqygBFz
 m0Ug==
X-Gm-Message-State: AOJu0YwOeCm+ODxtcmcg18toOmBIT1KGs60ZMqXTwqlkoKkxeg/RRM1V
 0jTsqZBsN24g/qc30jwRZg7PbG+3Js7EY47QwQtAqg==
X-Google-Smtp-Source: AGHT+IHC2MKSbOxwi5TuC+vEBtMxRnkWBp9vGKZkjj6ZMbWmWAp4fsDj6YL80ZkvT8F3E2qzu/HuV9Ck7hUurH6FKkU=
X-Received: by 2002:aa7:d79a:0:b0:522:3aae:c69b with SMTP id
 s26-20020aa7d79a000000b005223aaec69bmr2076403edq.20.1691170878931; Fri, 04
 Aug 2023 10:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-1-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:41:07 +0100
Message-ID: <CAFEAcA9zGqkWL2zf_z-CuWEnrGxCHmO_i=_9CY347b8zCC2AuA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] accel/kvm: Specify default IPA size for arm64
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
>
> Some Arm systems such as Apple Silicon Macs have IPA size smaller than th=
e
> default used by KVM. Introduce our own default IPA size that fits on such=
 a
> system.
>
> When reviewing this series, Philippe Mathieu-Daud=C3=A9 found the error h=
andling
> around KVM type decision logic is flawed so I added a few patches for fix=
ing
> the error handling path.
>
> V4 -> V5: Fixed KVM type error handling
> V3 -> V4: Removed an inclusion of kvm_mips.h that is no longer needed.
> V2 -> V3: Changed to use the maximum IPA size as the default.
> V1 -> V2: Introduced an arch hook

Applied to target-arm-for-8.2 with an extra doc comment in patch 1;
thanks.

-- PMM

