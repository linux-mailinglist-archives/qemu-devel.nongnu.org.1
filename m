Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D56E79A9F8
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjA6-0002Y7-Qr; Mon, 11 Sep 2023 11:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj9v-0002WV-UD
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:49:08 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj9t-0005TS-QN
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:49:07 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52bcb8b199aso5908362a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447344; x=1695052144; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hoFPvm7ENUMvg/jfjVDE7kHdaZueoQSy41Sb2Xs/ReI=;
 b=uZEUSD3gTQiCTANIkSzOR4uyd/Zf1L9nrj51rmqEAqFpq6F9+CnN0NGr6DtUZ/uN4q
 xe/VlsJC/+6o8M8E86w/B41Au/5C5nsYzKZAiMqzp67+QB4vwaesOKuRHtqliwf7V1oP
 MO96RYMSCLZ2R9/XhNW3NNjvJLNBSqF0CLTHRkvfhEMe7nZdeV+ePAjBYFBLUCmLGbIy
 JvexFyLYG+u2D7GiYgAzmyndZKb8feuwcUOL3drxcQK6Iq+j8lZz+NPNz1vJYgmU8/fx
 I5cO61GpvtewbfuDkq6mBxw+RIGPMjlcJ3JsSjImy388xzEd0SQhH9Zy5jWZYWnQa8/g
 r2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447344; x=1695052144;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hoFPvm7ENUMvg/jfjVDE7kHdaZueoQSy41Sb2Xs/ReI=;
 b=xLcZBmoY+5bah0e5K+tnKRPIUZrRXi2wXp+pFEzfGlnooUlxUrk9l6ZMII4/PJQ6VH
 3/s6pXUC/d4TSrInFPzpKXDoLI5A0dEHOM0zBmF4xDeH3hPObr9YuwupQFGtjtJ1HwYh
 ohLS4CvyKSJh1/8e/Xu55XOT9nzgBWNETNcmYjgG3tWeUlXarzQvJ8RZTyZdIDXDsk8i
 53UOOdTrG7tuJv2dnW2XIexXKyTTqi0ox29XQJ97bBdnjLwZvjHVzdYCNkG1tJ1k6KKc
 8YUqafzTnNCCk5vQb1805VGCc/QQ4bpaoT1GCAaiCowmhqMzriAQWpgfDNKjcI9+kLw1
 7gbg==
X-Gm-Message-State: AOJu0YzDLnEtqOA9HdJsFSj08ieqh8WpZSa/Kz+o+HflE1tK7RFiI8WM
 Ejb4SkdV6Nz7iBaonvTG0R7aYpPCz4IwZvsmUmIskoJxCVLlqw1y
X-Google-Smtp-Source: AGHT+IH2TqMHHplwHKZ8OSo0WVohGo1avarM+rSL+OzOp7cW/Lb4dsmWsw1btF2ny2+0BkI20D+ECPsT8DZLx8nsqTM=
X-Received: by 2002:aa7:d512:0:b0:523:1400:2d7c with SMTP id
 y18-20020aa7d512000000b0052314002d7cmr7497552edq.35.1694447344425; Mon, 11
 Sep 2023 08:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-8-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-8-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:48:53 +0100
Message-ID: <CAFEAcA_ngkDmNVzWePgXwvVgrffmeDP0egb4fANJHD_ywBNMuw@mail.gmail.com>
Subject: Re: [PATCH 07/11] hw/arm/virt: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Fri, 8 Sept 2023 at 15:39, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

