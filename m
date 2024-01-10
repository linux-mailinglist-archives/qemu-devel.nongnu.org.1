Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BD782993E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 12:39:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNWuG-0001mo-8a; Wed, 10 Jan 2024 06:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rNWty-0001is-7J
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:37:44 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rNWtv-0000Pk-16
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 06:37:40 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a277339dcf4so441517566b.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1704886657; x=1705491457; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g8nO7q6AHiDXyr+J6T3+jEQHQT+n8o3GUg61YRNARHU=;
 b=mbaDcbtkSxUaH+BScfqubg/Xzz1uLcKKaFPmvjZGlOJBztB0QTp8JRloyh/veQDbqZ
 lWCotYbZI3jetJgcqSrkYyesQIW2W50XA4mQjTQ8pD6fkzmkoAQRarscYOCpd1oNuk39
 wth2T1+sSHOP7Uh5KYAHeo8b0UanqCeQiYfBXhbq08c5RWxZeFCnO7dKS+Nb3RDy0ZMa
 n52CSF6wGonu0SaEu9kixQoNRVkIkBNTsf9FduhvNFniRXxFnAjCf4exdDVKm7iXVRCc
 6BhqdLZEcbINZhpqR3V42Wf4KO3DuM6SPGfOm61dd1KRcFM3COrbk9CpyANcHGXqfvqQ
 I6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704886657; x=1705491457;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g8nO7q6AHiDXyr+J6T3+jEQHQT+n8o3GUg61YRNARHU=;
 b=aTvM62ysUfh2qo1KOHgMOUpR4a43Ffk0mhQDAUnZhePSUhed9/vMlCQJp3XcL7ZYqc
 DVaF0SNJh/Sl3talED0YwTO/RCi88l5k/xtXZZK1BdKOEJ6a1mYCvrUeHXvQcTpWQ1K2
 ksi+H1af/+tC7itzIbzxsrPbNq+oOAXcHcOvDNH20/gvjy6NbbpcP+qWv9A09/sFfhgy
 YtjAiX5XhM/6GdQ8hX+T67+B3F/nDM6qgJDx1Wpn7T2K80nK40sRfZlAjdCU8uGTEXF7
 bOyGbaY7W694qG3n9/d75D9ilRFzSKTQwqapwNCRRvrLDvhsVvrZFMXtAj9762KGKM+T
 rUdA==
X-Gm-Message-State: AOJu0YwZCiHQn1cwvOmYvz46jywFLGxwoGWMsTyp0Hv8taB1SCk0DwoQ
 /QY51V4Ajg/nfNxjziJQ8OsJpj5oiRe2bA==
X-Google-Smtp-Source: AGHT+IFFBmzRowSBzGtRiMmyKCPkknsh/nssGt1ZeYHL/xLyJByeAufHH/vPJjRbVix3HlIWbJ/Owg==
X-Received: by 2002:a17:906:a3ca:b0:a28:b74b:27ec with SMTP id
 ca10-20020a170906a3ca00b00a28b74b27ecmr483515ejb.111.1704886656864; 
 Wed, 10 Jan 2024 03:37:36 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 v27-20020a170906181b00b00a2ae0aa9002sm2004436eje.40.2024.01.10.03.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 03:37:36 -0800 (PST)
Date: Wed, 10 Jan 2024 12:37:35 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] target/riscv: use misa_mxl_max to populate isa
 string rather than TARGET_LONG_BITS
Message-ID: <20240110-aa3945e12c7bb11eeb87edfc@orel>
References: <20240110-mold-renovate-256db1b5c70e@spud>
 <20240110-eastward-sulfide-f365c89681e0@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110-eastward-sulfide-f365c89681e0@spud>
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x62a.google.com
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

On Wed, Jan 10, 2024 at 10:25:36AM +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A cpu may not have the same xlen as the compile time target, and
> misa_mxl_max is the source of truth for what the hart supports.
> 
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Link: https://lore.kernel.org/qemu-riscv/20240108-efa3f83dcd3997dc0af458d7@orel/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Perhaps this misa_mxl_max -> width conversion should exist as a macro?
> There's now 3 individual conversions of this type - two I added and one
> in the gdb code.

A macro is a good idea. I had to go look at Table 3.1 of the priv spec to
understand the 16 shift stuff.

> ---
>  target/riscv/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781..5b5da970f2 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1860,7 +1860,9 @@ char *riscv_isa_string(RISCVCPU *cpu)
>      int i;
>      const size_t maxlen = sizeof("rv128") + sizeof(riscv_single_letter_exts);
>      char *isa_str = g_new(char, maxlen);
> -    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_BITS);
> +    int xlen = 16 << cpu->env.misa_mxl_max;
> +    char *p = isa_str + snprintf(isa_str, maxlen, "rv%d", xlen);
> +
>      for (i = 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
>          if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
>              *p++ = qemu_tolower(riscv_single_letter_exts[i]);
> -- 
> 2.39.2
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

