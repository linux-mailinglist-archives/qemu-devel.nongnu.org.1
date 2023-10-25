Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF497D6228
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:11:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvY2e-0007zw-Sk; Wed, 25 Oct 2023 03:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qvY2Z-0007s5-VI; Wed, 25 Oct 2023 03:10:56 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qvY2X-0001av-D1; Wed, 25 Oct 2023 03:10:54 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27d1aee5aa1so457196a91.0; 
 Wed, 25 Oct 2023 00:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698217848; x=1698822648; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSWpiYqXIyRFwGgtbj+SWweuZIqRB/KkumLR9wLNRzo=;
 b=ixhko4t25raGxwVO/wqCgQXFHX8fCNP4lEJ0k5M2/1ykQ4ry1bICKiK1I/QPIr38dB
 5doQEqGGIer8c4kukd5ciPMXl/pKXstIxAuNZ977YjhXoWy1jA4siEG3Dp1+D29Yn+/8
 CxPWe6RXc8AcLo5WOgC000ulNt+UwdVAg61Bhhv+WEs80SiXAHKxOcV1ehfJntdw5eWt
 4Z6eI0SRErKJwHpYx+r0xGv7DhHVNwVCXuEGEFIH1wjSxQm2jZhPZbr/XZ2IqtjX1W25
 qPVpBNNB2Uw8Gpx6WWfrZEGokCBK0KjwT+LKdjvP7LQQUF9Wyslc5LiVRDhC7viOqOw6
 dg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698217848; x=1698822648;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xSWpiYqXIyRFwGgtbj+SWweuZIqRB/KkumLR9wLNRzo=;
 b=CBqQmhOkVQ6P8mzNEYVbZ8jmbAOXr+yCSTuGXTwasIjrzsEP1NrQePiiQbuB/G/OJX
 dJn0ffmeRnUQiCLN1+BJuWq5THfQMpJnOpm39KWUKw8Jyj4wpbC4oA34D22n/pZnLEbm
 WCbEzkjCETJPRMBPhxhnTUkgcJ23OHmTYZBSbAXfZxaoFurps0/R9O4mLTIUaOZXmdA1
 qhUVOzjZIHr4U4K0eBTfy6xTFhbS9mR12yDRMvoqXbvdR5ZAgAt7q6wdES/TByMpZmH+
 WsrX0OEP8Gdy7Ef3dFNWMz3lsJS5P5NBrFaXxpNBuSBP51kbDIZqia/0YZ1KL7AiF8b+
 DWvg==
X-Gm-Message-State: AOJu0Yw4HDzcVpEP6085QdxagGijrIXBPPbI/VFin3qDY6a3ckr6z2Qv
 OOKymbuj0+zNETd1zb4moPc=
X-Google-Smtp-Source: AGHT+IHrrVvtUxFO1WU4tSKmRdpCdbCpu+f6cxn7vn6jhS04lbhzqP+ziy884b+ycyNCfEu40d8wLA==
X-Received: by 2002:a17:90b:1c07:b0:276:6be8:8bfe with SMTP id
 oc7-20020a17090b1c0700b002766be88bfemr19558927pjb.23.1698217847671; 
 Wed, 25 Oct 2023 00:10:47 -0700 (PDT)
Received: from localhost (193-116-88-234.tpgi.com.au. [193.116.88.234])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a17090ab94600b002749a99318csm7986817pjw.26.2023.10.25.00.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 00:10:46 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Oct 2023 17:10:41 +1000
Message-Id: <CWHBZE6QEORT.7WO8UKHHMZ63@wheely>
Subject: Re: [PATCH v2 5/9] target/ppc: Use tcg_gen_extract_i32
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
Cc: "Richard Henderson" <richard.henderson@linaro.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20231024165903.40861-1-philmd@linaro.org>
 <20231024165903.40861-6-philmd@linaro.org>
In-Reply-To: <20231024165903.40861-6-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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

On Wed Oct 25, 2023 at 2:58 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Inspired-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/translate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 329da4d518..c696fedbcc 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4802,16 +4802,14 @@ static void gen_mtcrf(DisasContext *ctx)
>              TCGv_i32 temp =3D tcg_temp_new_i32();
>              crn =3D ctz32(crm);
>              tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
> -            tcg_gen_shri_i32(temp, temp, crn * 4);
> -            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
> +            tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
>          }
>      } else {
>          TCGv_i32 temp =3D tcg_temp_new_i32();
>          tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
>          for (crn =3D 0 ; crn < 8 ; crn++) {
>              if (crm & (1 << crn)) {
> -                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
> -                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn],=
 0xf);
> +                tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
>              }
>          }
>      }


