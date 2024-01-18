Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41274831336
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:40:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMzm-0003JH-KU; Thu, 18 Jan 2024 02:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rQMzc-0003GZ-Ud
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:39:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rQMzZ-0001hX-Qn
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:39:15 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3366ddd1eddso9769988f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705563551; x=1706168351; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HQc1JgjmwW2nvU6fX8yQTDb5C9wcHSqwhU58JJej6JI=;
 b=Dm+qfj90Q3TiMK0UVL+c2nrtkoOpcUBIxpmhaemFRidzZHKPIRBtar9sJKwdM8WcBw
 lxteP7whdoOw13nto49rx1sKP7gng6FkHFKjtrVs7h/dGVfHklSsVR1ESrnU0QfQngk/
 VBTH3bFUXMC2PUR1MoQU5+jqqg3JaXd9Chqc6IatE+VbS6Osz6kqTNdtujGOZ6wA7jJ7
 wxPM2A/GjTWETcH8btrsjQsPjFFy3yLdMoa2guj9AP0QNwp+gsprE+8YnE3Gbu95o66U
 oSjepmLPo0z12Ksht4HlCcd2CPpf3EHxpuj4ZiCQEYLWx++6uFnUF2TnnfKItvq+Z3JG
 PiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705563551; x=1706168351;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HQc1JgjmwW2nvU6fX8yQTDb5C9wcHSqwhU58JJej6JI=;
 b=Bh2ExmZ69mFVWizVYXt4b02bGjHEQ1F6pOgUkhV/qh3JcjZiW964OGicFiFmJQAN3b
 6w7fumOeMyMLlTxh1/QutDKiSnBk+ng0p2Ps+x+B+LrPS/UCn3y7meEjIrt+Z85kj5qX
 Wo30UAB1aKsVN5J97dC4BQgrSifh4ZTfnFQ4EZULgNexDf6diz/WLR6bN5OsPpMfgyfj
 7nVxGjmlckS2VqRriWgeQWlB8Y1wT8SbIM97jHgODRkDH3o3cTV0XccaLyb+elkwyo9U
 bXC7aBkrv8IQKL+CM5UQUG7ZgGgIjXOgjLa+B4k5TAz0RL9Qs7xVrp8oSIllUmTrERHx
 o7fg==
X-Gm-Message-State: AOJu0YyPC1Qbz/W2oP/oOZ+gXMtMSAJIwpkrYqJq1ywY36emWex+y5OU
 Npk2yohalPdjVcSMkC2crx+VHun6aG7wCSPTjErgwD4ftMK9hROdNFF27fVXniHv0HHfdbU7AWh
 9
X-Google-Smtp-Source: AGHT+IG6zDir0jIA74J/8wcjiU93Essuo83/hY0+iZeU/c6fIRHnV9mI+UBExWBnrZjSRG2wi1p7tQ==
X-Received: by 2002:adf:e541:0:b0:337:c4d8:a570 with SMTP id
 z1-20020adfe541000000b00337c4d8a570mr101140wrm.11.1705563551148; 
 Wed, 17 Jan 2024 23:39:11 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 e6-20020a5d5006000000b0033671314440sm3357347wrt.3.2024.01.17.23.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 23:39:10 -0800 (PST)
Date: Thu, 18 Jan 2024 08:39:10 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Himanshu Chauhan <hchauhan@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 2/2] target/riscv: Export sdtrig in ISA string
Message-ID: <20240118-b5bb665fdfccb624dc52a5aa@orel>
References: <20240117142412.1615505-1-hchauhan@ventanamicro.com>
 <20240117142412.1615505-3-hchauhan@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117142412.1615505-3-hchauhan@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x430.google.com
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

On Wed, Jan 17, 2024 at 07:54:12PM +0530, Himanshu Chauhan wrote:
> This patch adds "x-sdtrig" in the ISA string when sdtrig extension is enabled.
> The sdtrig extension may or may not be implemented in a system. Therefore, the
>             -cpu rv64,x-sdtrig=<true/false>
> option can be used to dynamically turn sdtrig extension on or off.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index c770a7e506..860e520730 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -153,6 +153,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(x-sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> -- 
> 2.34.1
> 
>

We don't want the 'x-' part to show up in the ISA string. isa_edata_arr[]
should get an entry without x-, and the x- property should be added to
riscv_cpu_experimental_exts[].

Thanks,
drew

