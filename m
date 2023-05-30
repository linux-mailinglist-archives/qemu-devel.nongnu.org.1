Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7F7166EE
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q41Dr-00022l-HL; Tue, 30 May 2023 11:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41Dl-000213-7g
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:25:13 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q41Dj-0000WB-HH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:25:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5148ebc4b89so6711856a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685460309; x=1688052309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j4QbYHmZ9uJKn683nbgPSuxd9jGSqiNvJwcu5+e9Eto=;
 b=Cwwi3V0XJZUKzDnb73e9d0pU26ckIf05du+8hL28N5c4a4LghBjpMsxG8VL+3uAjVc
 aW2pkI9PmnDyuitLCpmhiDxB8JppEG5O/6GnbGrTn9Wm7iZXRv2hop2uzYsPfoUOKhWz
 Lbw7nQv/nsqzSKQaBqIaWLEbqfYWYZ9F2ydAD8SKtqc1+PoRvMKiGNZTmDHTUNOYnL1x
 /q6mR40hUoS7Chy63n+P07hRyYMtY07FtW/i5T1IwH65p6A0MXr6rnr0gjviVcAmR+MS
 H1r8Eo/9Z8l0Eky6c7noMZECp4MQpzkslsBlLklAB3QQiJq0Qlc97lu3lwbHVQpA7OM6
 OYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685460309; x=1688052309;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j4QbYHmZ9uJKn683nbgPSuxd9jGSqiNvJwcu5+e9Eto=;
 b=Jdsn8Wa03+KQPcGBkhHVFcP8CviPhC9GWMMpSCnZcLNj8qg5FuE4GASzXLujlfqPhZ
 +sYG5Q8o0/cAILuaB1eflZdgT+oPKx/jwCUzIC9tlSg5j9vnfJjhc8l4hamtfKLD2Z1h
 u4N5JQnxwgkFBiJWMumnEZ43ftBnaVqSYVsLEUxXRWizQUvBnmdWno+rnuBwBUFyPU26
 QR0ZqLSY116nLycT664eWoGpL5CN3rsVJHHNsXVn9PQpKblEwMdeyLv5QJyjDwjDXHQr
 nAqUkf04+chngK4TepmfaksfklFDxuCtIbm+LAg1pmt/uRRtYr8d4PmZH6KcI4RX+eOL
 MF9A==
X-Gm-Message-State: AC+VfDyNUW52CvS17KlRpQEAiaw1VUtmVZhikK3g3La6NaI/ZJ7ORsGR
 ZQ6CmoZlMjWvmC55TYUQ2Iweh3yEDaasiRP9j8/wrburFePlDSBj
X-Google-Smtp-Source: ACHHUZ77B29siQDjZZLdtz2qDbta7J3bIVQ5GxgxRFIeNpffBx5tYAfEcL9PKYUeev+GTStz9O/xqrGkVIG5vXzTV9g=
X-Received: by 2002:a05:6402:6d9:b0:50b:fb85:8608 with SMTP id
 n25-20020a05640206d900b0050bfb858608mr2013380edy.25.1685460309268; Tue, 30
 May 2023 08:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
 <20230525232558.1758967-4-richard.henderson@linaro.org>
In-Reply-To: <20230525232558.1758967-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 16:24:58 +0100
Message-ID: <CAFEAcA9iW4V747qTFNBBUZ4yQAGbBFo=MhrpRQbC-BXXGZ8HiA@mail.gmail.com>
Subject: Re: [PATCH v2 03/20] target/arm: Introduce finalize_memop_{atom, pair}
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, 26 May 2023 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Let finalize_memop_atom be the new basic function, with
> finalize_memop and finalize_memop_pair testing FEAT_LSE2
> to apply the appropriate atomicity.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

