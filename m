Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 000917703A5
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 16:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRwCN-0006xD-HV; Fri, 04 Aug 2023 10:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwCL-0006vm-EF
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:54:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRwCJ-00017d-VJ
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 10:54:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5231410ab27so1726879a12.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691160874; x=1691765674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jPHfZt3MN46WF3a6MB/7JD/PHP6kpkxjqgn7p5QL9HE=;
 b=dqVu0wIo1jjKDwR/VzPPdPo8dSRq9bPEIegiy6DFXb3Wqr1PZzNNQT4Md+ylrR3DA+
 7+6RdaPWAmyf0ZJyjnfBj4kq2MskHvCmyk9M1hQASW/kOAf2YmQHlB5Lo22TKuCFTN7t
 XsKk83YlyJsIGYgvFXnqP6+xlUJTN0dGqz/bJJ0e1nj9XUw/lxOH8o05awjPvYgCzzTz
 r67ez0nzG1qwXwmTxppcqQgLcir5/u8V5QeyIgk+JUyH0V6nDMTaIOjXSMSdQspQZGBA
 CO4pgRlAyIGoQoEizsr96pXnwwK5JbNGj1Hf55wO8axyQcZupSN5Z06xz3eYD8Dndw1G
 y8ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691160874; x=1691765674;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jPHfZt3MN46WF3a6MB/7JD/PHP6kpkxjqgn7p5QL9HE=;
 b=VVh1BiDzfaBqyKpD4jHY4TH51U79gq9zbNFtjlfZ43LoN9Kf12Ou3UMyxri1g/7FvV
 IJ77aSkd/sghAMKVjlb6bz0l9AAV9+99NaVGcOEjDcAUCQzI7jq5l8yc8uBaL441M8zO
 4rXxdxiWwS/yx5zgLXQ+W4TRqo8MLru7namFZGFRooNnUuUCHTfhbb1H+Tq3dqU2zlJ2
 BK5CXOmmi6QjWcpYfdQ92CkbneaIYsDXHDOMkT61RjDTug3rnLs2os1gwkrAXACvlt0I
 kdBz1VuXb3lGhbz3RYTDIdpkXbpTtrf2O+JkqXfXa7zKkTEY1BSRqxQuK7l80Y439AYO
 4h8Q==
X-Gm-Message-State: AOJu0YxEZGYdTYsSNK4AQQWSd8CdWNG45Q4B/brwctXrrypjM9WgLZvb
 n+90NMXoDweq3AgYBLSu8T/Y1Ke5rE7JRV9TVAzY1KUIB1eAERDP
X-Google-Smtp-Source: AGHT+IFVbA1/pHTzQA+x+K9uS0Wbwl7us5oj5c3diIJashGZ2bOq4i7pmhvamwfAnzMU2peGv+tv2wfGbhFd5daWozk=
X-Received: by 2002:aa7:c446:0:b0:523:102f:3cdd with SMTP id
 n6-20020aa7c446000000b00523102f3cddmr1862242edr.19.1691160874445; Fri, 04 Aug
 2023 07:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
 <20230726132512.149618-35-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-35-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 15:54:23 +0100
Message-ID: <CAFEAcA9zx6wPwWNMedj_R4=aMfm=uYMg4JSd_h95tZ-qRiJVtg@mail.gmail.com>
Subject: Re: [PATCH 34/44] Add Rpi4b boot tests
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Wed, 26 Jul 2023 at 15:23, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  tests/avocado/boot_linux_console.py | 92 +++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

