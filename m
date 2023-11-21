Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0EF7F24A3
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 04:31:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5HSW-0001Au-6M; Mon, 20 Nov 2023 22:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HSU-0001Ac-FP; Mon, 20 Nov 2023 22:29:54 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1r5HST-0002Hp-1k; Mon, 20 Nov 2023 22:29:54 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7ba8e3107c9so1371148241.1; 
 Mon, 20 Nov 2023 19:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700537391; x=1701142191; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zykVAOMXGJBHBT79yO+o54z1GyNT2rEbl1aSnQgP3J4=;
 b=kkr6vdGJFss3AyNePMNkjFU6LkcA7HUF5XU4dXGRTD5yVUqvmT6Y5OE3CbMP0KiXVa
 1zFiEk8E7IKXOAOikZgw3HG1P0K8OGLFPHhwwCB/FGYU21IlHu3qelGVi03RxV8iiJ/r
 rV8PCTa9rpHXVMr6zWrUqTu4xnBAY2w+sVN8yeSuNjmTgzq4oJw1/K0AvUe+82W+SHpm
 L/weCupMS03YWp4NtmRHxxP2RA7VztpPSg7kvq/yRLjeXqjQIXb3DbvGZqHT3CBUJOs8
 ogwI7k8vUaF0FIH/sdI7jcwBS4I7t9QAXOvi6JJnQdlJrIFbVAm/Tl60w43bPOy1drxj
 AOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700537391; x=1701142191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zykVAOMXGJBHBT79yO+o54z1GyNT2rEbl1aSnQgP3J4=;
 b=q7Bdj6BGKGDi2y7y5Kv35kZNFV21ihMbGJ23rQsP8348uHhh1+oybivwEa59F4ryXx
 mPffaS43uUJPggn4cpVxbHbZJ8hsQSZlVWPBgz4TXSCRabEigzAs8v52brIP7L9ayRYh
 Shg47FCu0XEQqhPnq6ml8LY8YeJ8O+rI+DZU48uU8MakJey1yNF1NNn530EU0ZNa4mmH
 /f4I79rcQMiNYc894fSNWmTjWjvfoEvq6OXTEDHRudqDOy7s1yM+lUh6TXGULRgLXqnE
 RDkOGefQhhU3LiIJr/qolKtwaKrFs+G8jQKm+nVh1fZMohtMZwcvVP3iMDlh9YqHRfsX
 pCYg==
X-Gm-Message-State: AOJu0YwRgIt9wTUIVxI06hkuonys3n0PQX9iJh6kvf6oy/SD1knlCHPY
 oQbwvALKMYlLsksQN7iixreHidBL9sHEkcI6QBus9RivHdvscg==
X-Google-Smtp-Source: AGHT+IGZo0g5rDhuYy8lxOVm3LSvnPUGVq68KCTWgsbknO/nE4IjQZ8BvJ86jRxJ2PdqoguuK2m5MHpeEeehdlatpUo=
X-Received: by 2002:a67:c089:0:b0:462:71bd:b244 with SMTP id
 x9-20020a67c089000000b0046271bdb244mr9105686vsi.18.1700537391380; Mon, 20 Nov
 2023 19:29:51 -0800 (PST)
MIME-Version: 1.0
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-18-mjt@tls.msk.ru>
In-Reply-To: <20231114165834.2949011-18-mjt@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 21 Nov 2023 13:29:24 +1000
Message-ID: <CAKmqyKN6Sj2G=CeMHR-JFfeR90RvgjujFf_tu=EJOG=P2=cpMg@mail.gmail.com>
Subject: Re: [PATCH trivial 17/21] target/riscv/cpu.h: spelling fix: separatly
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Nov 15, 2023 at 3:04=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> Fixes: 40336d5b1d4c "target/riscv: Add HS-mode virtual interrupt and IRQ =
filtering support."
> Cc: Rajnesh Kanwal <rkanwal@rivosinc.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index bf58b0f0b5..d74b361be6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -214,13 +214,13 @@ struct CPUArchState {
>
>      /*
>       * When mideleg[i]=3D0 and mvien[i]=3D1, sie[i] is no more
> -     * alias of mie[i] and needs to be maintained separatly.
> +     * alias of mie[i] and needs to be maintained separately.
>       */
>      uint64_t sie;
>
>      /*
>       * When hideleg[i]=3D0 and hvien[i]=3D1, vsie[i] is no more
> -     * alias of sie[i] (mie[i]) and needs to be maintained separatly.
> +     * alias of sie[i] (mie[i]) and needs to be maintained separately.
>       */
>      uint64_t vsie;
>
> --
> 2.39.2
>
>

