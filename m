Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C870507A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 16:21:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyvYD-0000he-QE; Tue, 16 May 2023 10:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyvY7-0000gd-LQ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:21:11 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyvY6-0001nh-A3
 for qemu-devel@nongnu.org; Tue, 16 May 2023 10:21:11 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-50bd37ca954so7787381a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684246868; x=1686838868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iSOa2hrFqtI0QFYCiTYsta1zuZEXCq/YlZkWbVdui+8=;
 b=Siv0im4LaScGxjKHHOEBuBEfMXr9PrEaKH0+SEr6r3prTJDjk9jRKYEmNCpSrbvDGj
 LxdkJ9/rGq9SmlwzMVPoaqOq5cBgEwEB4tOweA203974Mw0DyURfsipEOLBOSD7n/tUe
 QIHjk8Zi7TjhFm9zZvjlPOLN2AFJRJ5oeV1p27PfnXbs0ZzryTYUzz4RRTeLuQADDf/D
 1c+Ys48s2MoneNeGP2LvL71iX2BOZT5hdV4RNt+99SFQbv9n9ZTrr/IOSfCTHAKjJGbC
 WR0bkws9FOtu1bWrDYvxQXhql9S+wqQL8uJYjLFCrpJF+mieOtp01pUk/oL4y9zBZ65/
 t+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684246868; x=1686838868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iSOa2hrFqtI0QFYCiTYsta1zuZEXCq/YlZkWbVdui+8=;
 b=Axvzb+BpqHqQhaGtC3Sdw0nJ5oC44QRWt9BfXBQCyB4s5M5W9/zySFpz6CN1jL+YwG
 tfkl//yGIFrx0SZMSZ/UV1COmpeCoTqNW00dthDDNwW7ZiC6zCvj6EWLrmCXslF384a4
 fcx0jlcL0zCMUgjs7jSwHSwyZt2x44H2GemQb8BVrS54DrJvzHY6uomPa8BvK7ngR189
 ZGtV0npIkGn4TfGn5PvOenEhAuv6NqGC/Ej3437osIrbx2juVkDsND/AuSHV9GEVGX6l
 9yuutoj7f0ch5u8Mh58Fxt558ikLSI48Ci1dG3IV8X6rrmZYv+DNX4csL5JW2FlRIi29
 tJHg==
X-Gm-Message-State: AC+VfDwVUbatZbeOSYedq6AMlPgVIwTmQ1HAdj+RZNWf6LIfRRiWOqG1
 aEqy7vsYQrttzKsImZ70gwpO7c1TAdkhYcujoie97w==
X-Google-Smtp-Source: ACHHUZ4SHcr6j5UQtT1Mp1bkdecw8B6KA4yNA1l75hPHKnBa3jWfcp/kuQSAAvEFH6GESL1iL+nqerm2pQEa3Sg/Fcg=
X-Received: by 2002:a05:6402:5178:b0:50d:90db:fefb with SMTP id
 d24-20020a056402517800b0050d90dbfefbmr30500114ede.12.1684246868528; Tue, 16
 May 2023 07:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230515140036.383046-1-pbonzini@redhat.com>
In-Reply-To: <20230515140036.383046-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 15:20:57 +0100
Message-ID: <CAFEAcA8JncHJQnA--UciwPgi_X3EW4trvvMQ6OYBS_T3E4VfWA@mail.gmail.com>
Subject: Re: [PATCH] coverity: the definitive COMPONENTS.md update
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 15 May 2023 at 15:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The ordering here tries to be logical and matches the one in the
> website.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

