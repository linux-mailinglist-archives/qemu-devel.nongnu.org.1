Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87176707D9F
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaZQ-0001dQ-QH; Thu, 18 May 2023 06:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzaZO-0001cL-7n
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:09:14 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzaZM-0002qt-Qn
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:09:13 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-510b6a249a8so3227290a12.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684404551; x=1686996551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IokzdUXiS0nUEEaa7/jQsGpUvXWQd2mOT/RBRCxrmjc=;
 b=k5V1IAZBU7AbAzZ8ix2k4JfdHJalOV3SMqCOq0AZOhEwN4X38pXv3AIATsLBSrRAPN
 astiW/p/oBbOBNnTCH9pBoSe0PaWRSD8ufpHR+0oDN4wjDUGdIBD8wC0eCyiFzneOM9Y
 sIFlr7vhrHKcDK+QzLSUiCedrD3CFT34+z9QDG+BwnAOkpy7rEMefQAlGNIAAnaXXEXL
 QwTD+AzjKPIvekNXrGLDC2q7lSWP6V1UK3YN4WwEkLpKF6pK6lbJLjDveu7zEQL/VxI2
 Po0aZRBQMYB5wMxYv7PQpj16KIJ1nQ9K/heYwnvWBbHVusJs8W5cFdNMvx5Qnz212+hD
 nE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684404551; x=1686996551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IokzdUXiS0nUEEaa7/jQsGpUvXWQd2mOT/RBRCxrmjc=;
 b=PF78eqDizYO7gNJ74Ma70EeeVR2zWLMUJ2TBqkofWAceqCo1Pj+wZNvOksww0vc8DV
 TS3/ii21RjiC7pfdp1JfkpHd1pRr47ju2zfpQWgLlujj+YtbqujpA5eOBtJrf+V0XPad
 IOh0RxbZIrI/fVJV5m0wIZpk6XkDH7b71izsyozUaVgF/m9w4MyOKeJSWTQBai9CyNEE
 HRS25avsQcB6LYYyEnihXd4oj1kD3cOmT09cg8XA1h2OhPmtEFozxdkQtddyz/5epEGY
 nQ9RwGkW2kosNt7ladylSm8lv5AvyJwQph8Tyu2ArHqM4jvzjKZGKYcYc15TiJDNVc7b
 wctw==
X-Gm-Message-State: AC+VfDxxdXnXmPzFZ8a5/rlVf/8wgwQon2uU/TyQoupV5mcKKngJFL5h
 UVj50L0VWRu7mieukOThorJdzMsgToPwE6jVe086kg==
X-Google-Smtp-Source: ACHHUZ6j2W5kWYuns6uJeM+5YsFxG/cMvE/tV76mS3ZtyqXVHIAKW6Lm5wPB5JDHqnEvpP+J0WtZx+QAqr49FiKvejc=
X-Received: by 2002:aa7:df84:0:b0:506:7385:9653 with SMTP id
 b4-20020aa7df84000000b0050673859653mr4224895edy.39.1684404551263; Thu, 18 May
 2023 03:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230428095533.21747-1-cohuck@redhat.com>
In-Reply-To: <20230428095533.21747-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 11:09:00 +0100
Message-ID: <CAFEAcA9W3SZe0r34N-17KmqS-Fi9bAtaSo2Hh0zwDnAVvTjU2g@mail.gmail.com>
Subject: Re: [PATCH v7 0/1] arm: enable MTE for QEMU + kvm
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, 
 kvm@vger.kernel.org, Eric Auger <eauger@redhat.com>, 
 Juan Quintela <quintela@redhat.com>, Gavin Shan <gshan@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Andrea Bolognani <abologna@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 28 Apr 2023 at 10:55, Cornelia Huck <cohuck@redhat.com> wrote:
>
> v7 takes a different approach to wiring up MTE, so I still include a cover
> letter where I can explain things better, even though it is now only a
> single patch :)

Applied to target-arm.next, thanks.

-- PMM

