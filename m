Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A079A9FA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:51:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjBm-0004GX-DD; Mon, 11 Sep 2023 11:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfjBi-0004EG-Ji
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:50:59 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfjBe-00064J-D1
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:50:56 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-52e5900cf77so5903352a12.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447452; x=1695052252; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dvXxjt03WmsBpsHSf1stcclYyIQGTivU/l4pD1XmPp8=;
 b=MZylZT3IeaTaLrxsE9IddNSvtuQtFRpnq7OQN+kGYDwaQnWqoPeTpb3lvL41OssNJK
 GE1cpZO/AuDg97oxRhazD2zxU3SlQ9K45Swm7eMwZErFVRlR0bwL4gn+X9g6rjJPYOaQ
 3XAxJg14DBDkWM/OIhCTquEXk6pWVoZeB2dDXqbbIZn4D1A4mC4xcDw/pRgtgS5KGYeE
 tI61sPhYpfObVH5JBCacyvp/DZNGGa8xmIbAzN39V5t4Z4P19VnIFRbvO0dn2LWKmnLs
 7kam1a7tgwAiEZPI8LJlGqIfqVm07sy+nRmJ8GMs//K6LVW6/hJ+OCgJehX70Zl49I+1
 1XyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447452; x=1695052252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dvXxjt03WmsBpsHSf1stcclYyIQGTivU/l4pD1XmPp8=;
 b=RG7oGSNhPXdWvk3Gn4g+KsYCwDofbU3yeO/UeSKXPeFACuxJ/XU0ghf6TomeUx58kB
 PR7m4ExPAgO+tDLtafQrEBEPJiNDSX0TmaWVY6Ge4FgjPodp2x1gKSZ5N4zBcGsVyXIg
 dw+A9agF9cLmhIKGwr/cHS/IBJ5ItFQdUixLUPgOv8NIZKGbzJZaRT3tctX5aqy6gByu
 Q6uNmTd8ATYEeJTiO3eLNARhzknWHAbboBlQ3IDY6IgfEVYIJVmV+ON9lFzrBxJ/qAbQ
 r/rurQABsiq0iSQ7C0Kwivblok5vLNtaIvTY8RaYFb1Nw3/kTmf8iJdgpx16wHmLnB2o
 n12w==
X-Gm-Message-State: AOJu0YwI3yJcSgj1pqB6Jsj2i2IhEfF3NjOenX0oGcmH45dlDBqfACtw
 msdSgWd0I3Tb6BWXUE8SqLgl9CB8KgOIg3GdwkpA6g==
X-Google-Smtp-Source: AGHT+IElx7WFIAhZsIcX8lhXnUpZYTC+ZZf6wXIo4XeSnOcP4TBlpleUTZTaevzc/Nbf1xPNcS/q0XDV99WARrt4VdU=
X-Received: by 2002:a50:fa88:0:b0:51e:5251:8f45 with SMTP id
 w8-20020a50fa88000000b0051e52518f45mr8731381edr.4.1694447452504; Mon, 11 Sep
 2023 08:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-10-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-10-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:50:41 +0100
Message-ID: <CAFEAcA_epaR9F6-7y=5VByXs=Hhvdu27hcSHbHGzHGOJ_J3oMw@mail.gmail.com>
Subject: Re: [PATCH 09/11] hw/rx/rx62n: Use qdev_prop_set_array()
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/rx/rx62n.c | 19 ++++++++++---------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

