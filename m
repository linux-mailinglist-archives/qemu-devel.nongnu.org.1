Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1566A80CE83
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 15:37:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rChOu-0006yd-2R; Mon, 11 Dec 2023 09:36:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rChOp-0006yF-S5
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:36:47 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rChOn-0006T4-K2
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 09:36:47 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54f49c10c37so6448666a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 06:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702305404; x=1702910204; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnlDRuUqfo4QrqddI/qWEwk9SWh3sjr/XXfcP2vUeRg=;
 b=tnHfye8BhdoI+mH7Vx/NYWi9ig3GIFYCmZ5NaNEG5O+aQNrwSDFa1RdnG5n/iOV2TY
 R8J135uMt2B3RbxF8G03AvpYwvflcdTZMPlBd69lMGJrGpGM9FnZhaH0609syDjCtxsE
 hrjHWwfJ8wjBahDI0CrAJ4rutyd+Uogs0beQLolYkSVY+ngYhNNjGXrTR2kg4pVgZEJl
 DyspN39bFknxQNz6b1E0PWx2bk0/cKcCUfkR66tgk+6ZLkPP1lB3sYufGQD8NZJ2E/0J
 nhhf2Y5p5wv/aBZuoZvQZ+rfVjB0qfoRdpXyGF9xSQSNBjraGkkOOxdG6v3xLNgzXfyO
 3TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702305404; x=1702910204;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hnlDRuUqfo4QrqddI/qWEwk9SWh3sjr/XXfcP2vUeRg=;
 b=mD8viX5tmy0qieb/6H9DLzbawB+IcdmCbbOLXTFPhLl9H4RxMzGlu2xrfw6m+QAE10
 9AwUtIM5S9r8DP6UQ7c32DJ4h7xuNxJDx7ZOMS2esc3Vly0yRhU0BOy9qFLBwdtBbGwX
 +ipPXDTiodtLVweyrnCBGsNPNuww9ONbiPCvLjlPOq8jZ1Yl2A9t1ZZWeBlWt7ntKIFO
 IMBDKuo6Z5Kqx4/dIo/4nUO4qup/zrG4SPkVbA4GAbMUuK1J8ULkWQVz9sH6qNeQ9xmS
 1ujCMxJLtKP+YbIO8fJo+MBEke27QTGhpb57qfWaAkOlqFOq2YVu+xu/xQiBp3fj8m88
 fKhQ==
X-Gm-Message-State: AOJu0Yw1J2+5utg96szeBMMKDMYy2nu/klWOpT8m5rZ/BGIprTpLD4dC
 g3VXYwG2BMq0e8pIFCQTyR/iSFUwQ4a0JZVF5WZLCe2sPrgEs88I
X-Google-Smtp-Source: AGHT+IHPVGkHY5T66mLFfrATbBqb9h4CV21aGKeNWVd4/WzZsB76YC8N8NW8EyeJHL66q2Xoxoz1hmp/Ltsje7hwOjo=
X-Received: by 2002:a50:ef17:0:b0:54b:38f:7263 with SMTP id
 m23-20020a50ef17000000b0054b038f7263mr5484022eds.8.1702305403990; Mon, 11 Dec
 2023 06:36:43 -0800 (PST)
MIME-Version: 1.0
References: <20231123183518.64569-1-philmd@linaro.org>
In-Reply-To: <20231123183518.64569-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2023 14:36:33 +0000
Message-ID: <CAFEAcA8S7Ug8uFpvDO9FarLpLhTr_236H8gOK=dEOWQZe-3zgg@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 00/16] target/arm/kvm: Unify kvm_arm_FOO() API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 23 Nov 2023 at 18:35, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Half of the API takes CPUState, the other ARMCPU...
>
> $ git grep -F 'CPUState *' target/arm/kvm_arm.h | wc -l
>       16
> $ git grep -F 'ARMCPU *' target/arm/kvm_arm.h | wc -l
>       14
>
> Since this is ARM specific, have it always take ARMCPU, and
> call the generic KVM API casting with the CPU() macro.



Applied to target-arm.next for 9.0, thanks.

-- PMM

