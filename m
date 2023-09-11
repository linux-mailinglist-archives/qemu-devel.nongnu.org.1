Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3720B79A9E4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:43:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfj4D-0007Jq-SN; Mon, 11 Sep 2023 11:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj4C-0007Jh-BQ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:43:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfj4A-0004As-0p
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:43:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5230a22cfd1so5911561a12.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694446988; x=1695051788; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R9FuuB5AJNAsLZKX6j6SZ7cS+C8udo5w9tt1mnLjovs=;
 b=Utd/TRm6IGaCwBBQ7j6G3AFbRcMpUoJ6CZp+sarFMND79/imCy4e0HlvzmE0/EEary
 vjkn7uUsa4ThWKlxZEmpAnl8SnqJq5LWEY/sjGI1d1ojlRR+pQVrDHN4qewqR57Wq0VN
 iOCYJMbjqnAPLFcanSAIj0Mi/8P/PTCK9/3V9feuQRM79g1oz8Z/jxv9sbRFo+RJfIhV
 3BWpHZNvFoW7EpwhdocdKR+jiNkkeDJ/bJfG5ou31cdAVZ8Axvvt9K7sIIp3z7fVy4OS
 kUJdQF3rNwBgajZiJ1U367ANNAUedwd4xXix5tkvWqboYdPYENn/nexEU6MwCW+0X87j
 RCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694446988; x=1695051788;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R9FuuB5AJNAsLZKX6j6SZ7cS+C8udo5w9tt1mnLjovs=;
 b=SbAElaobCp/KY9xR6w/X6UQVDEXdVvooDkMIN8GgRl4jUkqRhPtoBEjrpPenx9QnRJ
 gHNgxHEAN6H33DMpYLLKt3y6tKV8cZh6WuGe/VKnsh7wXCOKuBp0CU2QETkv2xaUIyHB
 hOygkYYMxnlfWny4KVDHr6NLjGxCcZtPN2CFWEI1D+mk3WE6m8hUQ07137pqWLWYBFKy
 E3P4oNZilejioAKXj9mzxM7QwJ3wKB+EhLzv/GuO4N5zuGnBH5/e7SCjXhoGuqvX54Gt
 YYeaaa0MsYuQBUMsN9w1kbqX5FR+q/TXQ3vmhbl5NMNgUbxFXlRXvZK7KHjwxtWVJ51A
 KdjA==
X-Gm-Message-State: AOJu0YxrjrFZYHyMsiT+EerXN1Rb8iPqQp64jL0nDtx9FjWekMDB+nBu
 M+HAaX0w0b1QDDHXTzfFnBsndrmdKJY8Ar7+5axgPA==
X-Google-Smtp-Source: AGHT+IGxjOhdflvCxgcDw71xK/WqVPhKVhuQ1qoOLeRS0eQ9l8BaYGIwdxRGCr0f3V9FqV2+ItaPYqbVV9VfqGrU3Bs=
X-Received: by 2002:a05:6402:28b1:b0:52f:3051:f7dd with SMTP id
 eg49-20020a05640228b100b0052f3051f7ddmr4683960edb.35.1694446988407; Mon, 11
 Sep 2023 08:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-3-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-3-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:42:57 +0100
Message-ID: <CAFEAcA9a15bhpG1Yj-b+3TC=UxDFdGJA4f1VrxnZsgVUR9O1dQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] hw/i386/pc: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  hw/i386/pc.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 54838c0c41..0e84e454cb 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -81,6 +81,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "qapi/qapi-visit-machine.h"
> +#include "qapi/qmp/qlist.h"
>  #include "qapi/visitor.h"
>  #include "hw/core/cpu.h"
>  #include "hw/usb.h"
> @@ -1508,9 +1509,10 @@ static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>          char *resv_prop_str = g_strdup_printf("0xfee00000:0xfeefffff:%d",
>                                                VIRTIO_IOMMU_RESV_MEM_T_MSI);
>
> -        object_property_set_uint(OBJECT(dev), "len-reserved-regions", 1, errp);
> -        object_property_set_str(OBJECT(dev), "reserved-regions[0]",
> -                                resv_prop_str, errp);
> +        QList *reserved_regions = qlist_new();
> +        qlist_append_str(reserved_regions, resv_prop_str);
> +        qdev_prop_set_array(dev, "reserved-regions", reserved_regions);
> +

The variable declaration should be at the top of the block;
otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

