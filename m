Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973C74A224
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 18:23:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHRkC-00045I-ES; Thu, 06 Jul 2023 12:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHRk9-00044L-FN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:22:10 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHRk7-0001JH-Cs
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 12:22:08 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e2a6a3768so1227098a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688660525; x=1691252525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=60VnKutnwUJ/tJULxRdIf7si6nQAVpGcUbqvFWN9TWU=;
 b=jnCc4yoG4CMuRhBayiVVH7FeCkWLzZQqPFV7V4RtCGIXwcx4DXQlojE/uR+0etI9zV
 r9qC5u3XCKdVgqsCid9g8Jt3E8TrlAaVMmdVAasE16BhkUnM0MDNmkpup56vh3SDzYOG
 gPpmysyTqqogwts/722rR8GTXhB6MCzGvkP7AOmwFcMmnNn5EOmd/SfkpphSbMD+nVMA
 S856hSDTgHzuFbdw5i8oQrzUvvqUGnKl2PMp2MV8ez0iEeUAsz7CymAkpxFAF9qo7UZB
 5Sz5NFqKhYRAjOAs/ZKxHYmxJ+e5p3gV6v+qohzW6l5VDnVOAo3Om/s9/WpIjZ8lwGlM
 K5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688660525; x=1691252525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=60VnKutnwUJ/tJULxRdIf7si6nQAVpGcUbqvFWN9TWU=;
 b=fKJrW6ek88+6kLirWMKbTuBtIh+0bLkA+buySGPKHuaoCM3nRB2emRWYvQ5pW2F6FF
 VEG/8BenOV7Upye8hKfDiAS1Yh7Ck6CaOhva6cwHCZlKfyD3cpEecg6m1S+tlbbxF3fw
 OuOaOthee2MRwJTKNL/99cnqwVtfceevWpEEKgseqghkbh76cbl1bq4yD0NkYw0W21zI
 mReKVA+NZuSTgOgbxMkomlr/jvT5zmVFwZ1hfSN+xfQ2xBMtSm6AbCJq1CeMsaEF6yxc
 a+v9gTkubx1CUlZ6KO30X9CdK21sby2+ahdXQVSIX5KDAXftdUjxXc6ZUMYiE67/+asu
 UyKA==
X-Gm-Message-State: ABy/qLb8BnIVUoGY2qJpGze9lN4oBo5e8+6Rbrkra6zHMT2EH5yPEgG6
 Vd7KXzFe0pUXuw3NUYYGLgPisYG5Wb/To4a1ThAQPA==
X-Google-Smtp-Source: APBJJlEqCs7E1BfO8IW9J96ryUreT9qWBl1ztvRVRvN7fiKhS+cWMWoXCuIYhhae5k8Z5MhjGzapdDWeXZrqzTuV9Ss=
X-Received: by 2002:aa7:cd6a:0:b0:51e:1643:5ad0 with SMTP id
 ca10-20020aa7cd6a000000b0051e16435ad0mr1732423edb.8.1688660525474; Thu, 06
 Jul 2023 09:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230706140850.3007762-2-jean-philippe@linaro.org>
 <CAFEAcA8h-VXZkD0SBrjOYg-FFVk5AW0RrAs4AL4w6RXWZzWUsQ@mail.gmail.com>
 <20230706152543.GB2570588@myrica>
 <CAFEAcA8crpS3SBoCsmxaj4isMcGYrExOTDU=m5u8-gOkrrjERA@mail.gmail.com>
 <20230706161016.GC2570588@myrica>
In-Reply-To: <20230706161016.GC2570588@myrica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 17:21:54 +0100
Message-ID: <CAFEAcA9VsCfa4_PY+HLkER02jzwEEhX20rVCtVXTp4SgDLeHSQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix ptw parameters in S1_ptw_translate() for
 debug contexts
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 6 Jul 2023 at 17:10, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Thu, Jul 06, 2023 at 04:42:02PM +0100, Peter Maydell wrote:
> > > > Do you have a repro case for this bug? Did it work
> > > > before commit fe4a5472ccd6 ?
> > >
> > > Yes I bisected to fe4a5472ccd6 by trying to run TF-A, following
> > > instructions here:
> > > https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/plat/qemu.rst
> > >
> > > Building TF-A (HEAD 8e31faa05):
> > > make -j CROSS_COMPILE=aarch64-linux-gnu- BL33=edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd PLAT=qemu DEBUG=1 LOG_LEVEL=40 all fip
> > >
> > > Installing it to QEMU runtime dir:
> > > ln -sf tf-a/build/qemu/debug/bl1.bin build/qemu-cca/run/
> > > ln -sf tf-a/build/qemu/debug/bl2.bin build/qemu-cca/run/
> > > ln -sf tf-a/build/qemu/debug/bl31.bin build/qemu-cca/run/
> > > ln -sf edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd build/qemu-cca/run/bl33.bin
> >
> > Could you put the necessary binary blobs up somewhere, to save
> > me trying to rebuild TF-A ?
>
> Uploaded to:
> https://jpbrucker.net/tmp/2023-07-06-repro-qemu-tfa.tar.gz

Thanks, I've got that and can repro the failure. I probably won't
be able to get a patch sorted before Monday, I'm afraid.

-- PMM

