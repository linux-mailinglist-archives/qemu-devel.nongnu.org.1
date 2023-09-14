Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 186837A078A
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 16:41:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnWL-0000uQ-KG; Thu, 14 Sep 2023 10:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnWI-0000tn-VZ
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:40:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qgnWG-0000dE-WE
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 10:40:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-402c46c49f4so10926385e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694702434; x=1695307234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S1GDB0R+c9oAwqJttqwTtfkLtxH7usjq17smL1mLLK0=;
 b=o58YnuMViiPFFGQoWHWRwQRHEomo1ZYL1tNExv4DN2SK73o9Y0Y4jSjg5bUXuE/9GK
 zO6FDOylo1DppDrhtB/AVJU6uBk6jmxSezF/wmRuqNz4brZf7l1y6JrKfceY6sEAgjHO
 UpOuSHqQ2HEsXDC9WmVL2wx2N1Q6vHthC56+2Yx/z46fREbOWhqYNrmoFTZcYuWZGgBz
 XQTET+wenhe2RnK6R1NaRCblDtN3lRh48ttyIPkvhgkfEphlul7wj5KLu2PvjWFWOfhZ
 y/3vkMPhCsEhpCt9+Mftc8XwfrcDn3H0AE5gb57sCrVZrx1e+cZiRdiI7hwA5IDkTU9T
 Jghw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694702434; x=1695307234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S1GDB0R+c9oAwqJttqwTtfkLtxH7usjq17smL1mLLK0=;
 b=NkUeTDvxuXc31TzURK/CNX+Sj6M842AEainpoYfKK45OQFNb8TGtY4FHVwZ+aRKQ82
 9ndNOkLkyt1JixB4PW6EPiS3QF5ypsw3lFBTplqNsLmNmLhT4vOMvwy8w8x+T849UMkE
 V9lI7dLxmMOjlkgr5ImBxuyPy1c/yiDI62NEvuF+zEQKpFTl8aZJA5fMw4012fROQT1K
 y9cLSXx3+kVg6WTD2QASZsWpQR86WRINFbOATD2u67XzDeUVIq+Tc7V5C1EBGwuY8byp
 o0apKEiZmX3s5i+bWCVDL6k0DtTHz6y18wD2MfvJORqZQ7iU4ZCeZ/h9U3BfMIaQhAGY
 gATw==
X-Gm-Message-State: AOJu0Yzm2sUtNIsD77a+exofoEQ72iHGAv6bGevfHSozTe9241Jm+aYT
 GUAaEdigdkZYBZsMGoJY7s/sZ74FxcVjzxO3ApR/eA==
X-Google-Smtp-Source: AGHT+IE6QxikUJlaajSQ6g/Tf1IFkFLX9YIZl2XVNsJHaWp+UxH1Q7KaK9XrZZQCLg/TkUUM0o2kz9DQdJxWr0R8zvw=
X-Received: by 2002:a05:600c:1c9d:b0:403:af4:3178 with SMTP id
 k29-20020a05600c1c9d00b004030af43178mr5097409wms.1.1694702433950; Thu, 14 Sep
 2023 07:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-4-stefanha@redhat.com>
In-Reply-To: <20230907181628.1594401-4-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2023 15:40:13 +0100
Message-ID: <CAFEAcA8K=TxoqUV-XK+_5KvmKxc+ue7rZ28Sd_yY=V_TVxmMcw@mail.gmail.com>
Subject: Re: [PULL 3/5] hw/ufs: Support for Query Transfer Requests
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Hanna Reitz <hreitz@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

On Thu, 7 Sept 2023 at 19:17, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> This commit makes the UFS device support query
> and nop out transfer requests.
>
> The next patch would be support for UFS logical
> unit and scsi command transfer request.
>
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: ff7a5f0fd26761936a553ffb89d3df0ba62844e9.1693980783.git.jeuk20.kim@gmail.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/ufs/ufs.h        |  46 +++
>  hw/ufs/ufs.c        | 988 +++++++++++++++++++++++++++++++++++++++++++-
>  hw/ufs/trace-events |   1 +
>  3 files changed, 1033 insertions(+), 2 deletions(-)

Hi; Coverity isn't happy about the code in this function
(CID 1519050). The code isn't strictly wrong, but it's
probably possible to make it a bit more clearly correct.

> +static void ufs_process_db(UfsHc *u, uint32_t val)
> +{
> +    unsigned long doorbell;
> +    uint32_t slot;
> +    uint32_t nutrs = u->params.nutrs;
> +    UfsRequest *req;
> +
> +    val &= ~u->reg.utrldbr;
> +    if (!val) {
> +        return;
> +    }
> +
> +    doorbell = val;
> +    slot = find_first_bit(&doorbell, nutrs);

Here we pass the address of a single 'unsigned long' to
find_first_bit(). That function operates on arrays, so
unless nutrs is guaranteed to be less than 32 this might
walk off the end of memory.

There is a check on params.nutrs in ufs_check_constraints(),
which checks for "> UFS_MAX_NUTRS" and that value is 32,
so this won't actually overflow, but Coverity can't
see that check and in any case what it really doesn't
like here is the passing of the address of a 'long'
variable to a function that is prototyped as taking
an array of longs.

You can probably make Coverity happy by defining
doorbell here as a 1 element array, and asserting
that nutrs is 32 or less. Alternatively, we have
ctz32() for working through bits in a uint32_t, though
that is a bit lower-level than find_first_bit/find_next_bit.

> +
> +    while (slot < nutrs) {
> +        req = &u->req_list[slot];
> +        if (req->state == UFS_REQUEST_ERROR) {
> +            trace_ufs_err_utrl_slot_error(req->slot);
> +            return;
> +        }
> +
> +        if (req->state != UFS_REQUEST_IDLE) {
> +            trace_ufs_err_utrl_slot_busy(req->slot);
> +            return;
> +        }
> +
> +        trace_ufs_process_db(slot);
> +        req->state = UFS_REQUEST_READY;
> +        slot = find_next_bit(&doorbell, nutrs, slot + 1);
> +    }
> +
> +    qemu_bh_schedule(u->doorbell_bh);
> +}

thanks
-- PMM

