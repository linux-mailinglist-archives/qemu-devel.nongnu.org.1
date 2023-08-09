Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD44775C0D
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 13:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qThGp-0007E8-Un; Wed, 09 Aug 2023 07:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qThGk-0007Dm-R0; Wed, 09 Aug 2023 07:22:26 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qThGb-0002OW-KR; Wed, 09 Aug 2023 07:22:26 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bba54f7eefso5716975ad.1; 
 Wed, 09 Aug 2023 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691580122; x=1692184922;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LfXWr4a88ZK7CzyVYwzU146Xz+2/v1Q7AUDoy9HG2gg=;
 b=kdvAhHgYlYn8ZjSMHnnClVGV32cqAYnUID3XINkAr+l0xb+nqEgJYdvn09d/DVPZbg
 HZ6n/ugAQaEpdFFD3HovDCCtETBMxiVa6D1XwW93rg3jxhSGJbvy97KY0t/F6BpSSt4r
 MJHQfSBrYEGD+J75XDkozN+gv4v316vqRSASsNoOwZOK5z9v1FMXzP1H7RDckrce6M2k
 OdHwad6P8v4PedHBOBaqoOSd90HyeqscWSKzbWl6arfTkHh+lu9vSYt3j5UfTJe96Y/E
 DtkCbiwFIjr2Ld/c+4m5BLS9d+1HJ86UgL4iSFS/Xy/p5a2N6oPvGughdlckRVbeKr+R
 q5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691580122; x=1692184922;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LfXWr4a88ZK7CzyVYwzU146Xz+2/v1Q7AUDoy9HG2gg=;
 b=RNS4AHH3Ug5TIEB4+Aj8Lu1ThexMe/dVhwHCy/EM1sI3dRiYEIYuG4vzFxSNUaRbaN
 4PXJ/Iz5FGpUAjlUiLQNsRIuN2AoYCkDir+4J7j82gDrLu+IifD2QFnyIGD4hFgUWYlt
 JZhW3Fsrhh+tPGWgmm6lPQy8fMU4uDGKDY7FGeV6GLx+fsY1417cmgYzdykuBFHDwKeY
 X+6hiiZ6x3toWhECwwAqopFO1WGXFC/NERW8CFjPEDcSbDl407/p0+HsCVfjiM+T9Ro7
 L9JQ6sP6WMHRvt05MViEe4FejFg+jxMIwFc74RO+652nSvd0/HYqvAdBhJD4wLX9jLvT
 W0Gw==
X-Gm-Message-State: AOJu0YzUdFIKoeYZG/gwM+jLoYw2SUbfZP8CUrGb0yXjsIu9ZBoq8uLn
 +QsL3u3aq4fPoe0tBQY4N/c=
X-Google-Smtp-Source: AGHT+IGK5PXkEjZdbgs5Ku3En5+6HL8k6sCVssBBFVH3Diq9xbT3gznm1x/WSUOKSmmTss68rjZwIg==
X-Received: by 2002:a17:902:c781:b0:1b9:c61c:4c01 with SMTP id
 w1-20020a170902c78100b001b9c61c4c01mr12974494pla.9.1691580121884; 
 Wed, 09 Aug 2023 04:22:01 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 iy15-20020a170903130f00b001bbb1eec92esm10907406plb.281.2023.08.09.04.21.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 04:22:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Aug 2023 21:21:53 +1000
Message-Id: <CUNZ3S3QUQ4V.OQZZMUYGOQO8@wheely>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 6/7] tcg/ppc: Disable USE_REG_TB for Power v3.1
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230808030250.50602-1-richard.henderson@linaro.org>
 <20230808030250.50602-7-richard.henderson@linaro.org>
In-Reply-To: <20230808030250.50602-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Tue Aug 8, 2023 at 1:02 PM AEST, Richard Henderson wrote:
> With Power v3.1, we have pc-relative addressing and so
> do not require a register holding the current TB.
>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/ppc/tcg-target.c.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
> index 01ca5c9f39..63fe4ef995 100644
> --- a/tcg/ppc/tcg-target.c.inc
> +++ b/tcg/ppc/tcg-target.c.inc
> @@ -83,7 +83,7 @@
>  #define TCG_VEC_TMP2    TCG_REG_V1
> =20
>  #define TCG_REG_TB     TCG_REG_R31
> -#define USE_REG_TB     (TCG_TARGET_REG_BITS =3D=3D 64)
> +#define USE_REG_TB     (TCG_TARGET_REG_BITS =3D=3D 64 && !have_isa_3_10)
> =20
>  /* Shorthand for size of a pointer.  Avoid promotion to unsigned.  */
>  #define SZP  ((int)sizeof(void *))


