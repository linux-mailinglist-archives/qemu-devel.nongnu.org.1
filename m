Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC87D836FFD
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:31:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRz3S-0001Z2-9N; Mon, 22 Jan 2024 13:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRz3Q-0001YX-9T
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:29:52 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRz3O-0004bq-IM
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:29:52 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cd1232a2c7so46302291fa.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 10:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705948188; x=1706552988; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ELF7naRY2E9qFqrE7be5wdMU++Y0R2jBLEV0x+ctfoE=;
 b=jLaRowuOuHRf/nKNKqye/ErkV5mnsgml94Uo9+q1+C1lkQfinMzlv4nfrwg3WCuA3Z
 tCEW0R/hLAgBNdh3MVUPU3L1ce7lPaUvlBmnUZjkPN4SARsNBQ4e3tEWtJXx1wpbwkn4
 44n+wJsTEvu4WcKoDgMiySnsV2wX1YJXsM/Yt79t4s4IBTEO4NxIdafOqVYwrLzj9Ylr
 gx3YZW5Nb6lVwiJy9u7kfadAQ8mgNn+mlzdt0yFxZqYzjusEe++aahAQqWuzkU0B4bfV
 OabKsij7EqPqkSdfe0eVpso3y5Ceuo6WX4V0KLqE+kCS2eQBw2onv+yFxxkEHNezu3uB
 /l/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705948188; x=1706552988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ELF7naRY2E9qFqrE7be5wdMU++Y0R2jBLEV0x+ctfoE=;
 b=Bq6Vt/lVqeADs3NUzvAvQYkMlC+vUHDHqXdbiuDiHsm55WHTAapmC38cVzwrZVPGUd
 pQ8aUYCUxjZh7QlyGkGV2kMHj4xVCantK1FI8sFsQj993l8AhqPxmZnLqEptjXp0pim5
 yFIjq6VXVWExXokbHn390ODZExyG1GSSOk/pCJzJI0dgQsC48Q08MCbLYJVzwJlK53N0
 87uMf5eQe1rTOC+DXBfQMg0CVKq7Hch4LtXgDwhPLkffg1Lkrm6Z8Sv/xmh6e8JXTTER
 G3jZg/kIEkUOgXBZ/o/R5jKCqaStLqBvVpkHrSksbSLf/XGdMAoT+tR9S2sAR/9Vx0qW
 b4Mg==
X-Gm-Message-State: AOJu0YzZ5LQQlAOcl0DSxAblU90y2dmtPayEPpvTF4s1r7WToaOaXnAq
 e45pl3KF7CWL4tch/PwNiaOgmYU0PksuSOgdX3XNC1fFvG/9e5dBat64IMPJ9WRmmx4c1XTimD7
 cLTAIeD+oOsz914LyWQ6G8m2hYJnZevwwpLLm+A==
X-Google-Smtp-Source: AGHT+IH/q+uNhkjt7LPH70+UvuV5kTIe4kGqLDjJFwIDWaOraJjOt+gDCuPbhH/6VumgbZZl+9qLWPNcL0U/0gEPyvI=
X-Received: by 2002:a2e:bd02:0:b0:2ce:865:83a5 with SMTP id
 n2-20020a2ebd02000000b002ce086583a5mr2323636ljq.45.1705948188519; Mon, 22 Jan
 2024 10:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
 <20240119204608.779541-2-jcmvbkbc@gmail.com>
In-Reply-To: <20240119204608.779541-2-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 18:29:37 +0000
Message-ID: <CAFEAcA-dSxaseY+w_z-U1pa8XkJ9XTyBWekXvH0q0XkrZJ+jNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/xtensa: wrap MMU and MPU state into structures
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 19 Jan 2024 at 20:47, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Make separation of alternative xtensa memory management options state
> explicit.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/cpu.h        | 18 +++++++++++++----
>  target/xtensa/mmu_helper.c | 40 +++++++++++++++++++-------------------
>  2 files changed, 34 insertions(+), 24 deletions(-)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 8a423706d8c0..497325466397 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -326,11 +326,21 @@ typedef struct xtensa_tlb {
>      unsigned nrefillentries;
>  } xtensa_tlb;
>
> +typedef struct XtensaMMU {
> +    xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
> +    xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
> +    unsigned autorefill_idx;
> +} XtensaMMU;
> +
>  typedef struct xtensa_mpu_entry {
>      uint32_t vaddr;
>      uint32_t attr;
>  } xtensa_mpu_entry;
>
> +typedef struct XtensaMPU {
> +    xtensa_mpu_entry fg[MAX_MPU_FOREGROUND_SEGMENTS];
> +} XtensaMPU;
> +
>  typedef struct XtensaGdbReg {
>      int targno;
>      unsigned flags;
> @@ -526,10 +536,10 @@ struct CPUArchState {
>      uint32_t exclusive_val;
>
>  #ifndef CONFIG_USER_ONLY
> -    xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
> -    xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
> -    xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
> -    unsigned autorefill_idx;
> +    union {
> +        XtensaMMU mmu;
> +        XtensaMPU mpu;
> +    };

Is it really worth having this be a union ? I suspect it will
make adding migration/savevm support later more awkward.

>      bool runstall;
>      AddressSpace *address_space_er;
>      MemoryRegion *system_er;

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

