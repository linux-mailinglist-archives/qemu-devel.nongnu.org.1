Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E87CAF27
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:27:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQQV-00018D-R7; Mon, 16 Oct 2023 12:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQQU-00017m-9s
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:26:42 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQQS-0000Al-Oq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:26:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso9797038a12.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697473599; x=1698078399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3KXegPJz+GGOTIta3r6kQb9Lp4pQ77rh9DVgDUgNd+I=;
 b=IWbuOqwjcvxf5uHVa4v/xwBmaceMNtLHZfAR8tjWXlF7o2dh5V8pnNj9Q3JQMLKIoo
 OKV7Y6bvRhnB9VfTF7ngzROruB9hddFeihTnpVYj0Fdc8no3HDDCTdFKSAd7BWVZ+65o
 46uqz+uLcIpcqJBIBoWWKRP5f3/tH0Z19CPU2mPiTHbwpFWB8QZAMB2UJUFtGOYs/axF
 GAiQbRTD4+kL/F/HgWfwBVA9fNJtiXrnINbNVHnmmSQyLdfKgwN7HueQS9v1tq3Frl6i
 fDP8ozx6s5EmfVDwsz2JYPFJtmNxSePw8XRA04ZRm+WKwcPlTxkGBHIA3G7m38dzZ62q
 GLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473599; x=1698078399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3KXegPJz+GGOTIta3r6kQb9Lp4pQ77rh9DVgDUgNd+I=;
 b=Wra/0Q1rjYbWITrJrGLeIce6zUPDACDbjvvbC7hE9qH72aGKS9PHsGneJ5RBk0MyR9
 44+nBFGBrPfdk19wvEcAxgcIve6vzirvTxQRBK/S+EM4BoIEKhmlAQjjOYbSaP3Lc5m7
 5rbLt/j9wDl80wwFsToislg53cemBQ/6hKeY/WhWTYCmm0aDWsHoPUBJOMuKaoKnK9PI
 PvVceBSAr39/fMpiZqCKL6WzPGugOw3YkUM3nedSLrIJV77ns74NPsi7yYrEtgkkgPy7
 knPeAzLRO26UwlPczxuZLLXzQpv0vFFoPWvjCNVxxFJ230Xfkn4TCCekO55E6rxrjEJh
 8S4Q==
X-Gm-Message-State: AOJu0YxMSo99fsFI25gdDKsK8ULlK6VDADJf4BueK7eYNhjK2ur3JGoh
 ++BJ6BhbOyvmPvKBrpnBlvnRI1JfVkQqm3hsebpT4A==
X-Google-Smtp-Source: AGHT+IEcZyeF/QfkMhPOY6TPOOJP+ZymI5DcvWJ0JoIhJ7+VxUDNI+eeWvpcSXkMSw3omOYPXHvdFfZRXxi67nwnoQY=
X-Received: by 2002:a50:c8ca:0:b0:530:ec02:babd with SMTP id
 k10-20020a50c8ca000000b00530ec02babdmr6868429edh.9.1697473599226; Mon, 16 Oct
 2023 09:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231012073458.860187-1-thuth@redhat.com>
In-Reply-To: <20231012073458.860187-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:26:28 +0100
Message-ID: <CAFEAcA8Kg_nAQPwvb800UbRcHB1qQ6DYogbm62SuSy=0tZC22Q@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Move raspberrypi-fw-defs.h to the include/hw/arm/
 folder
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 12 Oct 2023 at 08:35, Thomas Huth <thuth@redhat.com> wrote:
>
> The file is obviously related to the raspberrypi machine, so
> it should reside in hw/arm/ instead of hw/misc/. And while we're
> at it, also adjust the wildcard in MAINTAINERS so that it covers
> this file, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>



Applied to target-arm.next, thanks.

-- PMM

