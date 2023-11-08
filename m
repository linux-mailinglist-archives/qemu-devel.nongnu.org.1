Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A87E5D55
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 19:36:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0nPD-00022g-Mt; Wed, 08 Nov 2023 13:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1r0nPB-00022W-Rk
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:35:57 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kevin@koconnor.net>)
 id 1r0nP9-0003Sq-ND
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 13:35:57 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-779f2718accso503424185a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=koconnor.net; s=google; t=1699468554; x=1700073354; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CY9LNn8/fjSgCZBehBmQSILa1N/co1OH3DMcwnmIN8w=;
 b=hcvA4SkMf6CXboU09D4Rp1y9ZCakUGN09yxWVePEInjyauBd8BnpVyG5mnB5j6KfSG
 zfN9qCTY1Ezjhqf7A7Ev4OMBB5VBU1CXC0G18TWAUkb4+8C892BVMT4A2zU+xN40h/wD
 a2/hygBYothf+6BNyaI8oTuvwGWi3x014dhZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699468554; x=1700073354;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CY9LNn8/fjSgCZBehBmQSILa1N/co1OH3DMcwnmIN8w=;
 b=ISlOJnPk4TIBmyMxtZVk0JbzamOXk39enk1lc1AHGky13Fs6vWtyh4sIKiJgQmf/91
 NnhWesOgRrxaJ3v1EbSATogvdA3oDUF8oES0z/Bq/PoMKW0mseYYJb/9kW/bSikDMHQj
 /bnF4w3gNmn4IFozB4j/e0wJh2AQAc2RgmaFFzijHwhCgOIytFGQVmhBWGHmcRcWwnfm
 1SlS5p8Q2+Q40J7FnFLv4tNWPoPbCZFMRl6GM1RQTkEh0wnneUz5on97EmQPqDyOpu0j
 DEg8slcFsTz6oifMzwI7U47CFT67ABo+FNwKX9rvTCXqmTi/ImsiSbgDuoXnzQ45L/OF
 vWFg==
X-Gm-Message-State: AOJu0YxlGt+SoOISg1V7UP5egMPYwcYMf/dQOd749vaf5DwuZLg8vg/B
 U9kDx/7S6iWGBPhgBLac8CcZFd9/yHxsPDFuGEHREg==
X-Google-Smtp-Source: AGHT+IH2u34V8XotAmRmX1u8OSkz8Nv36Bcb9Aj3JSVrSxHdluGTbgxHjouGMX5Xn5qGhX33D1+ang==
X-Received: by 2002:a05:620a:468e:b0:773:a83f:4170 with SMTP id
 bq14-20020a05620a468e00b00773a83f4170mr2424450qkb.63.1699468554304; 
 Wed, 08 Nov 2023 10:35:54 -0800 (PST)
Received: from localhost ([64.18.11.71]) by smtp.gmail.com with ESMTPSA id
 t14-20020a05620a0b0e00b0076d6a08ac98sm1311726qkg.76.2023.11.08.10.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 10:35:52 -0800 (PST)
Date: Wed, 8 Nov 2023 13:35:52 -0500
From: Kevin O'Connor <kevin@koconnor.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios@seabios.org, qemu-devel@nongnu.org,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [SeaBIOS] [PATCH v5] limit physical address space size
Message-ID: <ZUvVCHWbU29+eDm7@morn>
References: <20231107130309.3257776-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107130309.3257776-1-kraxel@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=kevin@koconnor.net; helo=mail-qk1-x72a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 07, 2023 at 02:03:09PM +0100, Gerd Hoffmann wrote:
> For better compatibility with old linux kernels,
> see source code comment.
> 
> Related (same problem in ovmf):
> https://github.com/tianocore/edk2/commit/c1e853769046

Thanks.  I'll defer to your judgement on this.  It does seem a little
odd to alter the CPUPhysBits variable itself instead of adding
additional checking to the pciinit.c code that uses CPUPhysBits.
(That is, if there are old Linux kernels that can't handle a very high
PCI space, then a workaround in the PCI code might make it more clear
what is occurring.)

Cheers,
-Kevin


> 
> Cc: Claudio Fontana <cfontana@suse.de>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  src/fw/paravirt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
> index e5d4eca0cb5a..a2c9c64d5e78 100644
> --- a/src/fw/paravirt.c
> +++ b/src/fw/paravirt.c
> @@ -182,6 +182,14 @@ static void physbits(int qemu_quirk)
>              __func__, signature, pae ? "yes" : "no", CPULongMode ? "yes" : "no",
>              physbits, valid ? "yes" : "no");
>  
> +    if (valid && physbits > 46) {
> +        // Old linux kernels have trouble dealing with more than 46
> +        // phys-bits, so avoid that for now.  Seems to be a bug in the
> +        // virtio-pci driver.  Reported: centos-7, ubuntu-18.04
> +        dprintf(1, "%s: using phys-bits=46 (old linux kernel compatibility)\n", __func__);
> +        physbits = 46;
> +    }
> +
>      if (valid)
>          CPUPhysBits = physbits;
>  }
> -- 
> 2.41.0
> 
> _______________________________________________
> SeaBIOS mailing list -- seabios@seabios.org
> To unsubscribe send an email to seabios-leave@seabios.org

