Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3897F34FB
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:33:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Ubn-0002Oc-Ic; Tue, 21 Nov 2023 12:32:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Ubf-0002M3-SP
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:32:15 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r5Ube-00082D-9q
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:32:15 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-50aaaf6e58fso4030597e87.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700587932; x=1701192732; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1Fq4aUI2UPAQQA4qxqkEeazAOiOA6d/fJR+XXjac0lM=;
 b=l2tThw2+cBIbS5ajJVppIwzTD3hn727i+/Snj1BsyvGeEiHG5EDDSr13/JJ2RkPo5d
 5OQ1CTmbtF5zDNJU+6cT1O3ACvPNgkkF8Ot70Q0bDApcNdXkZFJ2NKqtpNTg1zX+u9pQ
 4OnSx5n47FhHFsR3Bdw9zMNrmWBV+hlitlPgzZSvcXrXfgVJD8KLW7JSso0e7vKaol42
 gnkhM99stvJYJ0E2FbTtKalbTzCfFaGrEgUER8TnOnZva0ioVr5lCb3oF4RstIr0hEbT
 TOm4pQYNb5A6VEpEaysN8YoaWdOjdXlN1ARtQt6DqKgkawTPnZOVu33KgnuBXDENAjE9
 kXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700587932; x=1701192732;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Fq4aUI2UPAQQA4qxqkEeazAOiOA6d/fJR+XXjac0lM=;
 b=Yt1Po8fB37GNRMlbHbJDw9k10ZOU6sN1i/uI8ECuR88jOIArzz5sWfLbVhWQzWMdu+
 HuZGtVMVszlVW+8ecEuaWvS9nYe/h81NctUbfYO/v7qEIFLeo7GpM8s5o9M3p+/qxF5U
 4y4z92aAijqwva0XXBcfecbG50q6uNR9n2gizpMVKKERUUOiOk1ynUrEiHqjBvLLca3P
 XDQYnicj+0YhelD64mIS5iA2PnUUbHdGx1CJDM9JkhZ1SjuiWeDw45SR0/3BPe68eI5k
 dkgGBIttLMDbkMXCBdNS24ipZu0rtg+GdU/95HJkOVuZGqFraUUxJvFpxsg5BiSc9mwG
 ti0A==
X-Gm-Message-State: AOJu0YwphR3k4CG/2S0YPzfBDejWSmRN2pf9FC6Y8a2YKOekZ2mn+ZAY
 pm26gKRV1WDjLi+dwiyiPtrMQbxK/VdpWvYxQwqjKOSpLf5wF6dl
X-Google-Smtp-Source: AGHT+IHq/tbq5lHKLPaeRvoTdaEolqsJLJ7YbIv9ie9qQ/Td0JZHavKuu0ERCKioo5vy7kzUDMTRg1kVrZh0XOEAWh4=
X-Received: by 2002:a05:6512:3d91:b0:50a:a6d2:b5cd with SMTP id
 k17-20020a0565123d9100b0050aa6d2b5cdmr8694282lfv.53.1700587932084; Tue, 21
 Nov 2023 09:32:12 -0800 (PST)
MIME-Version: 1.0
References: <20231121170515.1171293-1-pbonzini@redhat.com>
In-Reply-To: <20231121170515.1171293-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2023 17:32:00 +0000
Message-ID: <CAFEAcA8Oe=Kv0PrwRpRZgKq7709298fzOgPSyhnC-J82ytEEmw@mail.gmail.com>
Subject: Re: [PATCH] scripts: adjust url to Coverity tools
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Tue, 21 Nov 2023 at 17:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The URL to the Coverity tools download has changed; the old one points
> to an obsolete version that is not supported anymore.  Adjust to point
> to the correct and supported tools.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scripts/coverity-scan/run-coverity-scan | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

