Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B8770712
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:28:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRyaj-0008GO-0G; Fri, 04 Aug 2023 13:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyab-00084v-Ia
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:27:50 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRyaZ-0004Tf-Sm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:27:49 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so4069252e87.2
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170065; x=1691774865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eGH739+21kK5T9cM0wXgX92MjcA/CsrPMd8UJ5iOhUA=;
 b=s/PWlVoIICkGKGfZ5NJYfPVRfwSjfJ+EEXIAKpkn109enBZgeYu3VzbfMEqWHLpXaz
 0zBw0nixNCvXuNH/7VUPPxZfdPHBiKnG54lRg3SgELKXkaEreTrr3o1gLC/mJPLsh+FH
 XK7RpbZfVt5yOByXNTDWMkaZxNHN2BQHTFjI9nywDR3FXaEwiq4IGY9isV0T0cMc7h//
 /KPOs/lLnaIZvj+mCXMx3juG1CDPPWPYEVH9LMjnEiwtj5V3TeMYzQJ7pX81Z6UBLXuc
 MquvnYcYOsDEwgAJInIHHtu83j9s/yqgwI1bTcjxtMG2d6cgrlx36P6s6CUz6shU32Hr
 zMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170065; x=1691774865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eGH739+21kK5T9cM0wXgX92MjcA/CsrPMd8UJ5iOhUA=;
 b=DKbSNiLmV4iCMnHD1iGzMUz9cWQcXdvSCUT3pzaqah7oBsA+YRtO0gVU/NUxJudrns
 oXeSmXj4PRgo47HeDKI00vWIqpgl7zzzBdEwfe//8QIT0Falk794C+pWhaV4O3sGyc9r
 ZU4Bkvu5zuANYrZKbwdG3NQf0coxcP1gFKbAceNes+DCyZCMsi235Mkdh+OLqerwg2qe
 95dP3jtrX/7NRCvBbVYFQsL6loiO6wOyfYY1W5jyDWUdTp/wUL+ewmLVrKtMrCEtLwJu
 07zzOyUVrJmv8mjVzte9V+Py/gSm54Hf9EuinCMz0BeWOCjcaWbvcKRFCgNLalKdePDT
 JjMg==
X-Gm-Message-State: AOJu0YwNHm7QZfsj8vKRG2lxMFaukBzwfj4/T6KFu9x613oqe3YxyOgk
 a9ZMqE7VWa+yxODNHfWvjdvsjUAxlrW1gtNgGJ9eDQ==
X-Google-Smtp-Source: AGHT+IHrt+YjfdNJEvDjOHWsAMq4eEiYzCLSTLcDO79rbvst91rSeEv27MZrEyXfE1RblzzaUJSOOgNUWJVnD+1YsBA=
X-Received: by 2002:a19:5e1e:0:b0:4f8:587e:cbe0 with SMTP id
 s30-20020a195e1e000000b004f8587ecbe0mr1651446lfb.52.1691170064899; Fri, 04
 Aug 2023 10:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-4-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-4-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:27:34 +0100
Message-ID: <CAFEAcA8xUepaabxAq6sRKkCLecNkMVqZo3g+fOs0FuakRFa1Qg@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] mips: Report an error when KVM_VM_MIPS_VZ is
 unavailable
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On MIPS, QEMU requires KVM_VM_MIPS_VZ type for KVM. Report an error in
> such a case as other architectures do when an error occurred during KVM
> type decision.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/mips/kvm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/mips/kvm.c b/target/mips/kvm.c
> index e98aad01bd..e22e24ed97 100644
> --- a/target/mips/kvm.c
> +++ b/target/mips/kvm.c
> @@ -1278,6 +1278,7 @@ int kvm_arch_get_default_type(MachineState *machine)
>      }
>  #endif
>
> +    error_report("KVM_VM_MIPS_VZ type is not available");
>      return -1;
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

