Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6FB747816
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 19:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGkHj-0003i7-Pd; Tue, 04 Jul 2023 13:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGkHi-0003hg-1t
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 13:57:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGkHg-00035N-I1
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 13:57:53 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51d95aed33aso5667315a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688493471; x=1691085471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1I+xLxqpcwpQEj1PAi8T1l+y6v0OvsrHvpN+d3/7Ah8=;
 b=zEhlq1uOikgZZPpqfSX3RUp/JLFryJ5j12vPixlTa9VlCrBGZgWrvX3+NGHyYf0xy9
 ok17VW4ZSRvwogXoy7HZwGx1gEQHwGudp2NqNbbLIpZ6SRhlWjCWSnMjbwfJZeWeln9J
 drFJg7fuJmvBA5B9i8QHpO0oKzwtTuRPA3p8jGjid8tEsrcIILyS65UGhRemr8WayNML
 hMCRnEgkvtv+PEYQqiQxHmxwDC373pXS0XCJAxmrwn0AwMvV2H57nauIhR+hrZ7dU/+8
 /dbfQsQJq95GO6NDGZaNkDdVkMepJlDoltLKBs5AENv/t1moDYB0dr58jyMoOVGUgTKO
 AD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688493471; x=1691085471;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1I+xLxqpcwpQEj1PAi8T1l+y6v0OvsrHvpN+d3/7Ah8=;
 b=MGGlRQXjOQ+ear21PdToUlC5Sn9JVg3NQ4Pv/oBfsHEhTmyqpr1U0uOUa/DQf/s09D
 v3OOZbDXUpZfeSTA0wrI9TeCqqgSeDFMaPD/axKFfbAigaPIdVigAuxkDrMprAOETG7D
 5n5YssASM6fFWp0BBJ2SaIzuW+rX7CRValONRds49QWVo+RmPdjtW8TFLcl9d+bNguQt
 a57i97J6/SlTgaflOGDcSgSOfP51Vi5qon2F00kWJyYCt80xNM+9d0C6oPRZsx+Qe/Tv
 frYcZsoQ3DOiVIap/NHnoaXZVMQagQ7TzUjvq3L0LvjkLPY0zMvLdfwwZ/v7UP58DVLK
 w1AQ==
X-Gm-Message-State: ABy/qLZEFXJcgjakhGhKvcxj4CFtf6eZ5qTObreExJw0qTp8v9+jJabF
 C+dLnRUh6VTlBGw5pPi81TZXm8SGb/Wg3AM57DWlbw==
X-Google-Smtp-Source: APBJJlGcs7caUQUsTleNGcLmtaux9I042ZlS9fWvoL40hBRfqnl4dt2f/GMcXSQ3ze27JqjnGyfbPHY71TEney6NKtc=
X-Received: by 2002:a05:6402:1253:b0:51e:126a:403a with SMTP id
 l19-20020a056402125300b0051e126a403amr3572849edw.13.1688493470741; Tue, 04
 Jul 2023 10:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230704171819.42564-1-anthony.perard@citrix.com>
In-Reply-To: <20230704171819.42564-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 18:57:39 +0100
Message-ID: <CAFEAcA_okj_rH3RR_a7BrOsxxEWBQGa7bGDXK1OrwCD9izVaDg@mail.gmail.com>
Subject: Re: [PATCH] xen-block: Avoid leaks on new error path
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Paul Durrant <paul@xen.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 4 Jul 2023 at 18:19, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> From: Anthony PERARD <anthony.perard@citrix.com>
>
> Commit 189829399070 ("xen-block: Use specific blockdev driver")
> introduced a new error path, without taking care of allocated
> resources.
>
> So only allocate the qdicts after the error check, and free both
> `filename` and `driver` when we are about to return and thus taking
> care of both success and error path.
>
> Coverity only spotted the leak of qdicts (*_layer variables).
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: Coverity CID 1508722, 1398649
> Fixes: 189829399070 ("xen-block: Use specific blockdev driver")
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

