Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF37E4838
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 19:26:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0QlN-00062J-W7; Tue, 07 Nov 2023 13:25:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0QlL-00061j-Mh
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:25:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r0QlI-0005s1-Rc
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 13:25:19 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5437d60fb7aso10127216a12.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 10:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699381515; x=1699986315; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HP3LfV3Unk5clU5phjkLVWMut+VHaw1iYB0TuJ9WkK8=;
 b=KEcVc77mu509U5pF7xAq0t/dhmnKOgob/p2k/KzrMQpYP+dQyyua6RM03YFi9cTMOv
 B6H9jlYcFJsIbnJ3X2KfzS68UmGAI1FTAM60DL5Y3CedlETZpxeuT/0MPRwGMar9aORr
 X6KWzibhbu1LU9R/Gj94sPccKAUKPKKbzJj1/jwS0heI1Zl/z91ReVcQmcxeu2tOW3gy
 QsmmghCoVcgUUcN9G7WBm3zkuHbrWXjcWQTDm4YrwWyXH17N5k8OXHpZ+f0xSOVa9jbX
 mJAbV8lv7UtxcwG63/+pR8XL88/efJrwmZHKn50DYKo0mvJ3KPXpUOU8BAFeo/cb2rh2
 jA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699381515; x=1699986315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HP3LfV3Unk5clU5phjkLVWMut+VHaw1iYB0TuJ9WkK8=;
 b=AX2P6NMOIYAww/vDSDBrsLLzuyiwxavvug9LCeNapPXPipJgw9pIA+w970jTZYb0ik
 SUMztbKuDqGVgp1ylbhQtZEIY28aQ3hn9m6u1w9yKU19YJcv8VyQ2SmCcuXPorSQE2pJ
 LvDl15mHjxqfmFBgjhz9G7ONJKoUc/DkgCKF5GnS3QF+P6+DJvDhZ9UnhS4+6ctZ8bfX
 j17HRYmoqbzNSP2XZ0hhxxYg0yAg6ePRbHFb+HFIRaasFwIsiAePv1+141ZSp75cPAIS
 Pu+lxgH1Onilo0Uwrq0PtmWRa3i2B63NlwVDvocsxUjMBOlDjcKzY7e/wQGCtGWcaDGa
 UtJw==
X-Gm-Message-State: AOJu0YyaEB3zsPmA1ooDBwhdP90D8FAYpSv27sT/5e2pWObs12obkaFg
 5O59ACJva+76MBrivFwBHB+jg9MLDY4XczXFX6J7sA==
X-Google-Smtp-Source: AGHT+IEhLztCNiZOi6yJy16J5DFmx8goTzZcczEQ5jSDe3G4oY4H4YSn1F4M8nrISuZepblAaD05GlUCIxcIpP8GPg4=
X-Received: by 2002:a50:935d:0:b0:543:9670:7ee8 with SMTP id
 n29-20020a50935d000000b0054396707ee8mr16118839eda.14.1699381515275; Tue, 07
 Nov 2023 10:25:15 -0800 (PST)
MIME-Version: 1.0
References: <9917e6e80f9fdab079d06130403aebc5a8544316.1698406922.git.balaton@eik.bme.hu>
 <63e5ae9ef7c919e7294bc656a009e5310e10d632.1699380861.git.balaton@eik.bme.hu>
In-Reply-To: <63e5ae9ef7c919e7294bc656a009e5310e10d632.1699380861.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2023 18:25:04 +0000
Message-ID: <CAFEAcA_fcfTcD_bbtgK8W2V65ks9wgChA0gnT=cHjb0fZ48HLQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] hw/ppc: Add emulation of AmigaOne XE board
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, clg@kaod.org, 
 philmd@linaro.org, Bernhard Beschow <shentey@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Rene Engel <ReneEngel80@emailn.de>, vr_qemu@t-online.de
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 7 Nov 2023 at 18:21, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> The AmigaOne is a rebranded MAI Teron board that uses U-Boot firmware
> with patches to support AmigaOS and is very similar to pegasos2 so can
> be easily emulated sharing most code with pegasos2. The reason to
> emulate it is that AmigaOS comes in different versions for AmigaOne
> and PegasosII which only have drivers for one machine and firmware so
> these only run on the specific machine. Adding this board allows
> another AmigaOS version to be used reusing already existing peagasos2
> emulation. (The AmigaOne was the first of these boards so likely most
> widespread which then inspired Pegasos that was later replaced with
> PegasosII due to problems with Articia S, so these have a lot of
> similarity. Pegasos mainly ran MorphOS while the PegasosII version of
> AmigaOS was added later and therefore less common than the AmigaOne
> version.)
> +    filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, fwname);
> +    if (!filename) {
> +        error_report("Could not find firmware '%s'", fwname);
> +        /* qtest/test-hmp expects to be able to run the machine without -bios */
> +        if (!qtest_enabled()) {
> +            exit(1);
> +        }

You should put the error_report() line inside the if() as well,
to stop the error line turning up in the logfiles/stdout. This
is what we do for the various MIPS boards that ordinarily
need a BIOS blob.

thanks
-- PMM

