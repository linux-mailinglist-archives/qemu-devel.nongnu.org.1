Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 785BB796DBC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 01:49:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe2GL-0006Gb-Pi; Wed, 06 Sep 2023 19:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe2GG-0006G2-Fs; Wed, 06 Sep 2023 19:48:40 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qe2GE-0006dT-0z; Wed, 06 Sep 2023 19:48:40 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-56a8794b5adso303224a12.2; 
 Wed, 06 Sep 2023 16:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694044116; x=1694648916; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uNH8hi9ZOCW8qCPtgUzwLksIqyLRE+E19fIJR8F0Hjw=;
 b=Dm1GHXqsAAKaHjIs9slz5ku3GFX7/2EUfx1/he+Zjclr5tLe5QQ3+sub7QpC/+fj2+
 XNGCOSf5zpFpWnP1kurOAd1YoFAnSvy3TcAgRylKCno7K2xbTZrGKS8liZxhEWRi8vEu
 YeRZef6xULPD7ZLbEf8rRRGNvsIKgL+yxCQ5NVI9hhTJqcHdemDzYR92kdEXMalJt2QR
 /UFeZM3KNOohUmrIsyvHw+Qvjt6jk5e4r6jyTXikBlTjiMYqZewfnaXeMW6Zs2cPrprv
 UNdOEHjgJBnZrWhi6TGZzJvUOlMZHZJAUWVPJCLy8thzT6MlYXJSC0KbeWrC1ifDMiAL
 aAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694044116; x=1694648916;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uNH8hi9ZOCW8qCPtgUzwLksIqyLRE+E19fIJR8F0Hjw=;
 b=S34URvfp/f7mWMhle0B+8zV706A6voUsunE0FHwlkAGdtMLMhF715MdvQMXH5OAOSv
 9PUyyFglsEA6uapQJsyyBboeCG8ozGWoeUun/v+pM2J88nvvf40MPB1lfANyuyJ17w2X
 IeT79xN1/Qcx3EAn2Yfb33xWTP6ly3GlvtQhWrs3JYQDcIWyzqrBelfoQ2ehBrHnOn2O
 EFx9JcceilMKGEctiAZCJEnCs9rFbMxCaF490ousOAIv+dNwcjb7IXsrFN59MMuyzsaJ
 qZNNn7KkJEx6qx+5kHd5cBgv+vaNcpqiRrj2t+J0zPRh9V4wzh7upF76Uah2ipCPLDdb
 0+hQ==
X-Gm-Message-State: AOJu0Yy3ueJiBb2P9CyH52Kql7gOrSSsfO97hjM585nGm9oUCUTbGVGu
 WmAqUomNojEFUXcFBeyR+k4=
X-Google-Smtp-Source: AGHT+IH31s63XMLa4l4ZJma4Je9GYHti3oaUcWNVhcX31abaI+g60Scz3/Uwk0nbVmDB/hcdRMMfgQ==
X-Received: by 2002:a17:90a:8b91:b0:267:ffcf:e9e3 with SMTP id
 z17-20020a17090a8b9100b00267ffcfe9e3mr17242532pjn.46.1694044115585; 
 Wed, 06 Sep 2023 16:48:35 -0700 (PDT)
Received: from localhost (193-116-105-24.tpgi.com.au. [193.116.105.24])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a1a1700b00267b38f5e13sm352032pjk.2.2023.09.06.16.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 16:48:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Sep 2023 09:48:28 +1000
Message-Id: <CVC8IO1HGU4Y.1RDSLZSOCVFN9@wheely>
Cc: <qemu-devel@nongnu.org>, <mikey@neuling.org>, <vaibhav@linux.ibm.com>,
 <jniethe5@gmail.com>, <sbhat@linux.ibm.com>, <kconsul@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 01/15] ppc: spapr: Introduce Nested PAPR API
 related macros
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230906043333.448244-1-harshpb@linux.ibm.com>
 <20230906043333.448244-2-harshpb@linux.ibm.com>
In-Reply-To: <20230906043333.448244-2-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

On Wed Sep 6, 2023 at 2:33 PM AEST, Harsh Prateek Bora wrote:
> Adding new macros for the new hypercall op-codes, their return codes,
> Guest State Buffer (GSB) element IDs and few registers which shall be
> used in following patches to support Nested PAPR API.
>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  include/hw/ppc/spapr.h        |  23 ++++-
>  include/hw/ppc/spapr_nested.h | 186 ++++++++++++++++++++++++++++++++++
>  target/ppc/cpu.h              |   2 +
>  3 files changed, 209 insertions(+), 2 deletions(-)
>
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 538b2dfb89..3990fed1d9 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -367,6 +367,16 @@ struct SpaprMachineState {
>  #define H_NOOP            -63
>  #define H_UNSUPPORTED     -67
>  #define H_OVERLAP         -68
> +#define H_STATE           -75

[snip]

I didn't go through to make sure all the numbers are correct, but
generally looks okay. Are these just copied from KVM sources (or
vice versa)?

> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 25fac9577a..6f7f9b9d58 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1587,9 +1587,11 @@ void ppc_compat_add_property(Object *obj, const ch=
ar *name,
>  #define SPR_PSPB              (0x09F)
>  #define SPR_DPDES             (0x0B0)
>  #define SPR_DAWR0             (0x0B4)
> +#define SPR_DAWR1             (0x0B5)
>  #define SPR_RPR               (0x0BA)
>  #define SPR_CIABR             (0x0BB)
>  #define SPR_DAWRX0            (0x0BC)
> +#define SPR_DAWRX1            (0x0BD)
>  #define SPR_HFSCR             (0x0BE)
>  #define SPR_VRSAVE            (0x100)
>  #define SPR_USPRG0            (0x100)

Stray change? Should be in 2nd DAWR patch, presumably.

Thanks,
Nick

