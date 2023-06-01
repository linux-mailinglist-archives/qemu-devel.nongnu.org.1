Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E03171A12F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 16:57:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4jjW-0002bR-Qd; Thu, 01 Jun 2023 10:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4jjP-0002ar-9w
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:56:52 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q4jjN-0005z5-Ah
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 10:56:50 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f3a99b9177so1240362e87.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 07:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685631407; x=1688223407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=31mTTWecvOhhqTFYrsU1u1Mnk0gYogF8LlK5F5gIZdQ=;
 b=gE2bD2R+iGV5Kai7V7uFug5pQIvge4rnm34oBh9ZG6HBawYt976WlTRcFY6j8W7EqC
 uNVQ9PY+9r1e3gVDkuj3/ej+hN2SYu/gf4o38sfLjO+rl1w5fIVT7w3QV+Ut5NaDaLBs
 5dDGP1DZAnyaBuMw/ef1jfjjmvGFgLLwu9myMLL6r4hBFCa5yVXnCuPgM4f+igtAOxck
 WDQ/3I4ca/POpPyxzuacea1GjgP/+I+y7Yu4+bSxha9wixXDtKQ3TAycs43bqOnCsldL
 cY19QdJinVH0IE0fpRDBgUqirtHZzP6NTEI6VgCAAMZurnTvPcWxhjDZIISo6umWcqYD
 qDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685631407; x=1688223407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=31mTTWecvOhhqTFYrsU1u1Mnk0gYogF8LlK5F5gIZdQ=;
 b=cKy+9bDvspqcKqidtijJ45zZWP6B+GyKZnnSmQO4pbluN8NbT+/Mw8ynPKnMmO3+Em
 yG6Uo50S8wA434gq0Xsg3ub9PcSi+CjGzVwbruDAGVoRitaxIvxDzdPog6dU1fiLjKiF
 n739RkqraF7YPIL/hNxaD+gyNMJxWk9xOM6Z5f+qTGgXCNFJkgKVneGmfyJSeoo3PMvG
 oXq8U85aqTBkxH4PjCq4gQ0iGdBHwHZFvJde/NFL+gXEnOidu3BnJPYeoMc7kvWvK+Ms
 m+R5pj3QFhi7fS55N3r4SZxwlQVizGG/v4QN+Dy8yGsXALYh61KcpH2UQmdAg5c8/EUS
 x16A==
X-Gm-Message-State: AC+VfDxe65LCvDo0HCoHRpRducz5F7ojRPsoZle9GNnY3Da3WRLz6KoH
 L6La+knTUbkh6Y5xdrV8MgOd2lIN20fMhkHGvCkVEQ==
X-Google-Smtp-Source: ACHHUZ4mx8F8ocazTtvvog2yu43jiu9Lm4PtXrewE5NVuFevjdgaCjIwGN1bD6j5kv2+elDb3vzETeizQiuo6p2EDJo=
X-Received: by 2002:ac2:4215:0:b0:4f5:a181:97bf with SMTP id
 y21-20020ac24215000000b004f5a18197bfmr72395lfh.58.1685631407522; Thu, 01 Jun
 2023 07:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230601142704.68768-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230601142704.68768-1-quic_acaggian@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Jun 2023 15:56:36 +0100
Message-ID: <CAFEAcA_-hCO9CfLjPFRNM-RqJ=EejDuqnrZo8f8n85yJyLk5FA@mail.gmail.com>
Subject: Re: [PATCH] hvf: Report HV_DENIED error
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <r.bolshakov@yadro.com>
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

On Thu, 1 Jun 2023 at 15:27, Antonio Caggiano <quic_acaggian@quicinc.com> wrote:
>
> In case the resulting binary is not signed with the proper entitlement,
> handle and report the HV_DENIED error.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
>  accel/hvf/hvf-all.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 0043f4d308..679907a147 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -38,6 +38,9 @@ void assert_hvf_ok(hv_return_t ret)
>      case HV_UNSUPPORTED:
>          error_report("Error: HV_UNSUPPORTED");
>          break;
> +    case HV_DENIED:
> +        error_report("Error: HV_DENIED");
> +        break;
>      default:
>          error_report("Unknown Error");
>      }

HV_DENIED only appeared in macos 11, so this will break
the build on Catalina (10.15). Catalina isn't in our official
list of supported versions any more (too old) so we don't
strictly have to support it, but is it easy to add some
kind of ifdef so we don't break it just yet ?

thanks
-- PMM

