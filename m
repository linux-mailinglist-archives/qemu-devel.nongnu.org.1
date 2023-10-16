Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A937CA424
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:29:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJt8-0001JA-3a; Mon, 16 Oct 2023 05:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJt6-0001Iy-B0
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:27:48 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJt4-0008Tp-EF
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:27:48 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso3217229e87.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697448464; x=1698053264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DLJId8i8qkoghJv9vsCw6weLYGoh2+/Xy2QWN8oSiv0=;
 b=qiDkaDAc8391iCqZqjULyBy7TacWn0HNfJwH4gR3IBKe4UJwYu6XIeIwDXsSBH+gWe
 OH+Knab/w8szeGCQAj6zTWmhZEydDiBtAN/pmNmb2byGSuDIRWI3Ke8JkMZBzGnx70O/
 M823mvfWKgCLQlEK2cBWncMOfE1gm6b0F9usE8zMeyEglHOXpI5rc+9zvAAEGn3YWTfq
 Mr10yJYCF5VuGs70CcrRxKYryUIAOhGOZhSZTWXttw+Andp0NoVyDlgA8Owee0RuXVJ4
 4s7VxgWx9mv6Ih3la4AVGTFdCRk8ukPYgcx9lH6sFWVL/KIdYFfocjztWHAmzcXFjkie
 Aa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697448464; x=1698053264;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DLJId8i8qkoghJv9vsCw6weLYGoh2+/Xy2QWN8oSiv0=;
 b=WfAAAZN1/2+maRPiM4qHCsZGwG8/WP26uQ45hOrIHOCgqEraUtQvD13GCs9b/oMMz6
 wz+8Lud1tqsurke0580tYaQ1GpJMwQkoN5GA1FGagApoQ53HtIwCM1/J5Wy1j3eBrx9i
 MxQS0dv+s1L/A7ohIEcx/qMQqTZHyg3qhb4AtK9BMdfNvdd5LlJI00ZtXqu3Mid2JHQy
 R3UY2/5Dlih4ArFw1V28z9yO1Xtubh2YHKWgBrhNiX0pzgVRAszKBVO8Mt/cFE5THaFQ
 WneTUqh2Xz4yayhOVflq6b4CxrNst7HZhGKpXVLSGg9ig0hJiTKPS7LMB4g0Bdi6Ep6O
 YUZA==
X-Gm-Message-State: AOJu0Yzpbgzqk3YidAwpjCxVQgQhUFpu3YEaBJJeS4Rsl6Db0fDk5t49
 9Uv/jRbKK35lETQvprikcp1oU0o4f/An5QShpWM=
X-Google-Smtp-Source: AGHT+IHtQ5/cBJhgIrBrrhfwb3n1aGjmdZXkuvqMXHVbymoMOiaWMH3RCwD+9MFXMUpQ/dKniHNnCw==
X-Received: by 2002:a05:6512:238d:b0:502:a46e:257a with SMTP id
 c13-20020a056512238d00b00502a46e257amr33152487lfv.56.1697448464063; 
 Mon, 16 Oct 2023 02:27:44 -0700 (PDT)
Received: from meli.delivery (ppp-2-87-17-65.home.otenet.gr. [2.87.17.65])
 by smtp.gmail.com with ESMTPSA id
 v8-20020a05600c444800b00406725f27e1sm6618484wmn.42.2023.10.16.02.27.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:27:43 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:12:54 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH 08/17] configure, tests/tcg: simplify GDB conditionals
User-Agent: meli 0.8.2
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-9-pbonzini@redhat.com>
In-Reply-To: <20231016063127.161204-9-pbonzini@redhat.com>
Message-ID: <2m7m5.9b59l27xkn2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12c.google.com
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

On Mon, 16 Oct 2023 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>Unify HAVE_GDB_BIN (currently in config-host.mak) and
>HOST_GDB_SUPPORTS_ARCH into a single GDB variable in
>config-target.mak.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

