Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7E79D375
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4GE-0007UN-3o; Tue, 12 Sep 2023 10:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4G1-0007El-9S
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:20:49 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg4Fy-00033S-4e
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:20:48 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so5629841f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694528444; x=1695133244; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AX9kRtARvGVRVaVejvoBCBiu0Q3LHhNAnC0dAvhisyM=;
 b=XH0ty5EwmrFRjG14z14tSZbdlmcAP7Ef+i8SLTURROawgurDLENqGoXeJR6ltthVXw
 N0KO81GoZpdSYiFvFT2mGYVaNFcBIznNI9dAV1fpx5EQaqZhG6fkilk7NDTEGKEf57oK
 MI25yz6XK1i0cUrcAOtvjC2RDJIg/RQj2F1dwk8Rxm/66jv7tXQP53pDDm4sWXwXLzJI
 s6kM/WC6U150mfqZhLdBAf5uA6Z71ibYizImc/V77Y6Fnu/QvKhJwZjeJK7O4O+MeRDQ
 w6tuqiSCGln/wLCWiW3JM3gHrfT9PCma6mTxnL3db2kNk7TWd/j9jeUs5kyXS4wrEz3y
 8JEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694528444; x=1695133244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AX9kRtARvGVRVaVejvoBCBiu0Q3LHhNAnC0dAvhisyM=;
 b=CtofEjO7byDv2lirQVjt/FTs4S8NP1UR9ghICHQBPQI7qCuleh6hbZFM5vnm3Vaeqd
 2ZxYnACfLJCKvNc9KuWTfkjI5a9KJcMQ8a0u5tP1CM50bZyXMnlpNnL/KULHWaPz3FQN
 o6/pWW4AbDyhC3UFkwa6UopAubHZ7vFEjKok31XXZk026AyaisQbE5X3QThUWJCEmTQm
 VqKulaso74IB8yl8BkIa9a7PBqHuckTTGfTMJSoQpjdsSzMHdXCGWiemmH+gAAc4zvXW
 RXzIm1sgD7AtbNDW/95RagcIdC/6IkfhZgU6vP2VawkgkFn1fzrI+7xlrtcxx+Onw6Tf
 OPyQ==
X-Gm-Message-State: AOJu0YwA166UajNxGAXv8N049sUNTh2e/gyNyN/2zFtvkxHJm3GEx1Hr
 xzV+MfbZQD5ATbLv65FMBXWF0npm45kPTWQtTaw7HXuEYPEfz0hP
X-Google-Smtp-Source: AGHT+IFlEi+z0e9xFhTBZmmbONCqWnRnQNWThjMKQLFy0Ah8bOnQZ817t/xhme3/VDh+KKq7mt4KDO9inmQHuf4qbLQ=
X-Received: by 2002:a5d:5451:0:b0:317:70cb:4f58 with SMTP id
 w17-20020a5d5451000000b0031770cb4f58mr10945917wrv.63.1694528444323; Tue, 12
 Sep 2023 07:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
In-Reply-To: <20230824153224.2517486-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 15:20:33 +0100
Message-ID: <CAFEAcA9Btq5W4+WD3go6JLEL+0ZNu8hW5Q16GB5MLSXyNwJDOA@mail.gmail.com>
Subject: Re: [PATCH 0/4] net: avoid variable length arrays
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Hi, Jason. This patchset has been reviewed -- do you want to
pick it up via the net tree?

thanks
-- PMM

On Thu, 24 Aug 2023 at 16:32, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset removes the use of variable length arrays in a couple
> of network devices and the net/ core code.  In one case we can switch
> to a fixed-sized array on the stack; in the other three we have to
> use a heap allocation.
>
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
>
> Philippe had a go at these in  a patch in 2021:
> https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/20210505211047.1496765-16-philmd@redhat.com/
> but these are re-implementations, mostly.
>
> Usual disclaimer: I have tested these patches only with
> "make check" and "make check-avocado".
>
> thanks
> -- PMM
>
> Peter Maydell (4):
>   hw/net/fsl_etsec/rings.c: Avoid variable length array
>   hw/net/rocker: Avoid variable length array
>   net/dump: Avoid variable length array
>   net/tap: Avoid variable-length array
>
>  hw/net/fsl_etsec/rings.c      | 12 ++++++++++--
>  hw/net/rocker/rocker_of_dpa.c |  2 +-
>  net/dump.c                    |  2 +-
>  net/tap.c                     |  3 ++-
>  4 files changed, 14 insertions(+), 5 deletions(-)

