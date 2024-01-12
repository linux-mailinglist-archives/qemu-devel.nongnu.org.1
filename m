Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483C82C388
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:23:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOKJg-0008B0-5J; Fri, 12 Jan 2024 11:23:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKJc-0008A2-QU
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:23:30 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOKJZ-0007F3-OF
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:23:27 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-557ad92cabbso6268205a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 08:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705076604; x=1705681404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1ed7GOJ8BqjMbAoMnrvYO0PosUKOVrE4CFq/nFSNvpo=;
 b=quU6A1AFyvKWtu6GhEUWaYfYepu0wOxf3xFmzp9UkstSwDX3gqBuSGrvaZCDud8AVm
 XQ6o9aR1Y+uqRz56ATQJWCbzEJvO4/3SCxgxkFOZUMbhnEfixbeMb6FJkemN3VU9HDQ8
 Rsa2fFjcA/wqLaAqGuY/kkwmjDfGe5pZrlcwI+itImK1h8Nk8gpGeIF5rsphFRgtzcoy
 FOF4qiYGdnxEBGwBxk3rqVp6RAkiCnFf0v/E4HdH0yPPq0ALro2JsYig/tnpH8Zexxpv
 WADzVeF+eeXCjWBH9ACrtWqIzWpCSMoF0vIE45iYY8PodoYZtWuZgpUucLzjN8JiU8yZ
 HRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705076604; x=1705681404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1ed7GOJ8BqjMbAoMnrvYO0PosUKOVrE4CFq/nFSNvpo=;
 b=jBGCqQmq48IhKHRkxPWSiFjT80u9Z1P0T8j5U/p3WgxvPuqOg87VVa5ogsrN6hkv8m
 tR5uRQXXnF+jJNIpY85aHzi2aqLfdwOxxycC4n2ibUl8xBSybS5tgpPLH3yJ8SkqWXTw
 kSO/G0zeXa7IV+rA19WYHMzS9EG25yy2FN7yYEYzFc2nZ1/xujoOIL71LA/8DwMHgTRE
 wU1dNYQZWTuGVg6CRWiKEbDjHkvw1i+j0QwD4WPAOL6wOFy6sVV1THgY1C9mtRpRTss4
 4sE1YlEc36JoOKtYATcxOUHPe6LYcPQejtU9+vvXf3OH3sXZPp2FIGCqbW+Sb1p5Ro1U
 y/+A==
X-Gm-Message-State: AOJu0YzW5AJ2o7X3xD/nrp0EIeusgrzOlZ/3htM3ct4IYaWyShNQiY71
 NR5wkFheQKViO3YfZv/UDs9W7DE0CF2y/liQQhyxI5P4bWZiKXucSYiLlHgr
X-Google-Smtp-Source: AGHT+IEPIc3wzYdVw/ZKh3laGgIb+KV7npWqBJIOxOWrRc6g/KgSesO2j4BOxEttVc5wyppmafPc3vk+Kv3G8+KUrGw=
X-Received: by 2002:aa7:c64c:0:b0:557:6f45:ae21 with SMTP id
 z12-20020aa7c64c000000b005576f45ae21mr426910edr.148.1705076604112; Fri, 12
 Jan 2024 08:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20231212162313.1742462-1-peter.maydell@linaro.org>
In-Reply-To: <20231212162313.1742462-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 16:23:13 +0000
Message-ID: <CAFEAcA9x1fX43oNhB-yO+PeExdn15GsQZ7FyNc8gkCBrWo4Ngw@mail.gmail.com>
Subject: Re: [PATCH for-9.0] docs/devel/docs: Document .hx file syntax
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw@amazon.co.uk>
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

On Tue, 12 Dec 2023 at 16:23, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> We don't currently document the syntax of .hx files anywhere
> except in a few comments at the top of individual .hx files.
> We don't even have somewhere in the developer docs where we
> could do this.
>
> Add a new files docs/devel/docs.rst which can be a place to
> document how our docs build process works. For the moment,
> put in only a brief introductory paragraph and the documentation
> of the .hx files. We could later add to this file by for
> example describing how the QAPI-schema-to-docs process works,
> or anything else that developers might need to know about
> how to add documentation.
>
> Make the .hx files refer to this doc file, and clean
> up their header comments to be more accurate for the
> usage in each file and less cut-n-pasted.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> My motivation here is that we're about to add support for
> extending the SRST directive to specify a label so we
> can hyperlink to a documentation fragment; this gives us
> somewhere we can document the syntax for that.
> ---

I'll take this via the target-arm tree.

thanks
-- PMM

