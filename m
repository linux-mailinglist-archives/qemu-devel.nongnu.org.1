Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4720A77FA7A
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWegd-0004q2-SG; Thu, 17 Aug 2023 11:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qWegZ-0004pp-F1
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:13:19 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qWegW-0007GO-KV
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:13:19 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1c26bb27feeso4421448fac.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692285194; x=1692889994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zEgjsRU83KLIUB7ZO+vnmNhRKrXoop9/UvrE9hT6Rho=;
 b=mQisdvAx39dk96CoTRVwZeSXuuX8wn6GBLaacTwjBHkE+em0H3OYGzlZzSDGuZ2I5D
 q2mU6gpXFUF2vLa1MkGYPwuXNfUf7Nf+sJ+6Dd8/CFickHBspy1EZ4lXc4cT3YPJB9kb
 Wnt2Eox7Xxj+XYc9DKcIwqfruvT/ZeTP1w0BdpVcar+jpOg/0Tx1NFFq2iFOAplivc60
 Qyqbv7D7CuDCUgttb59yP+ri1KNf5g4rvbufU1s7Ht2Egw+Rw1lfHqNFDeSh7z9TlitI
 PeA8wkFb8sFDB21O/egIMCqZQzLd7mfDpK5n36guvV93J2adMvz4UnhfO8QEnum+R+xx
 pxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285194; x=1692889994;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEgjsRU83KLIUB7ZO+vnmNhRKrXoop9/UvrE9hT6Rho=;
 b=ha/V9jQzeKBpsSTuJTGz1CehKoku40KzHN/13bKRqGrCIzfekn6mcTqo5LY103ZrUo
 dHwpvMqQ9GSpVXpKZ6bL4Zrq/JAK5T8kkxaSYpiUGz+en1xb4h5cWPFarqHpqnn8+oDX
 8kPEuNH1TZbNgem5djyAC9xeXkY4rhetbQlGbV2DAuf5lfSEZr7a4DNVa3DCC1gRzQd1
 7IRUakzBg7TF1PqQc58xzS1LteZpe2ztORHnfTp3eUIO7ncwKKNKufD26s1gBcvVLNMO
 yxjNWUtiBRjZDfFulyDjdW/yS1uz6BgB/A2DRpvH/BSqd2/X0y1vojZzKLKkxMAKtcj9
 o00g==
X-Gm-Message-State: AOJu0YyVU6s7ptrB5DX5XxFGskiJZ9PycZPIyCG2IRRHbthPhQ0Get3y
 XUl/Vp/Fg/YYUtSFubmkX8gjZtV0lwwHNfczYqhL2O7X30Q=
X-Google-Smtp-Source: AGHT+IGKxqoeI8apjnN912Np6vwpexCGiEq00NT5zZPbLOuzbvSTbKePhqy4CvSG0i9AtNC+9ytG0p2zjDplxdwy3Rk=
X-Received: by 2002:a05:6870:e753:b0:1bb:b025:3e87 with SMTP id
 t19-20020a056870e75300b001bbb0253e87mr6245286oak.58.1692285194521; Thu, 17
 Aug 2023 08:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com>
 <ZNKtHVotkfgI1tb4@x1n> <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n> <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
In-Reply-To: <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 17 Aug 2023 11:13:02 -0400
Message-ID: <CAJSP0QVjxNQ=sMjzEFzbyhJ0e+O5bGBiXkHMgWiB2GOVw4NqHQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, 
 Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, 17 Aug 2023 at 05:08, David Hildenbrand <david@redhat.com> wrote:
>
> @Stefan, see below on a R/O NVDIMM question.
>
> We're discussing how to get MAPR_PRIVATE R/W mapping of a
> memory-backend-file running when using R/O files.
>
> >
> > This seems a good idea. I am good with the solution you proposed
> > here as well.
>
> I was just going to get started working on that, when I realized
> something important:
>
>
> "@readonly: if true, the backing file is opened read-only; if false,
>   it is opened read-write.  (default: false)"
>
> "@share: if false, the memory is private to QEMU; if true, it is
>   shared (default: false)"
>
> So readonly is *all* about the file access mode already ... the mmap()
> parameters are just a side-effect of that. Adding a new
> "file-access-mode" or similar would be wrong.
>
>
> Here are the combinations we have right now:
>
> -object memory-backend-file,share=on,readonly=on
>
>   -> Existing behavior: Open readonly, mmap readonly shared
>   -> Makes sense, mmap'ing readwrite would fail
>
> -object memory-backend-file,share=on,readonly=off
>
>   -> Existing behavior: Open readwrite, mmap readwrite shared
>   -> Mostly makes sense: why open a shared file R/W and not mmap it
>      R/W?
>
> -object memory-backend-file,share=off,readonly=off
>   -> Existing behavior: Open readwrite, mmap readwrite private
>   -> Mostly makes sense: why open a file R/W and not map it R/W (even if
>      private)?
>
> -object memory-backend-file,share=off,readonly=on
>   -> Existing behavior: Open readonly, mmap readonly private
>   -> That's the problematic one
>
>
> So for your use case (VM templating using a readonly file), you
> would actually want to use:
>
> -object memory-backend-file,share=off,readonly=on
>
> BUT, have the mmap be writable (instead of currently readonly).
>
> Assuming we would change the current behavior, what if someone would
> specify:
>
> -object memory-backend-file,readonly=on
>
> (because the default is share=off ...) and using it for a R/O NVDIMM,
> where we expect any write access to fail.
>
>
> But let's look at the commit that added the "readonly" parameter:
>
> commit 86635aa4e9d627d5142b81c57a33dd1f36627d07
> Author: Stefan Hajnoczi <stefanha@redhat.com>
> Date:   Mon Jan 4 17:13:19 2021 +0000
>
>      hostmem-file: add readonly=on|off option
>
>      Let -object memory-backend-file work on read-only files when the
>      readonly=on option is given. This can be used to share the contents of a
>      file between multiple guests while preventing them from consuming
>      Copy-on-Write memory if guests dirty the pages, for example.
>
> That was part of
>
> https://lore.kernel.org/all/20210104171320.575838-3-stefanha@redhat.com/T/#m712f995e6dcfdde433958bae5095b145dd0ee640
>
>  From what I understand, for NVDIMMs we always use
> "-object memory-backend-file,share=on", even when we want a
> readonly NVDIMM.
>
>
> So we have two options:
>
> 1) Change the current behavior of -object memory-backend-file,share=off,readonly=on:
>
> -> Open the file r/o but mmap it writable

Commit 86635aa4e9d627d5142b81c57a33dd1f36627d07 mentions that we don't
want guests to be able to dirty pages on the host. The change you're
proposing would not protect against guests that dirty the memory.

I don't know how important that requirement was (that commit was a
request from Kata Containers).

>
> 2) Add a new property to configure the mmap accessibility. Not a big fan of that.
>
>
> @Stefan, do you have any concern when we would do 1) ?
>
> As far as I can tell, we have to set the nvdimm to "unarmed=on" either way:
>
> +   "unarmed" controls the ACPI NFIT NVDIMM Region Mapping Structure "NVDIMM
> +   State Flags" Bit 3 indicating that the device is "unarmed" and cannot accept
> +   persistent writes. Linux guest drivers set the device to read-only when this
> +   bit is present. Set unarmed to on when the memdev has readonly=on.
>
> So changing the behavior would not really break the nvdimm use case.
>
> Further, we could warn in nvdimm code when we stumble over this configuration with
> unarmed=on.
>
> --
> Cheers,
>
> David / dhildenb
>
>

