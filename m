Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB567DDE54
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 10:20:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy7OH-0008H6-0b; Wed, 01 Nov 2023 05:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7OD-0008G9-O5
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:19:53 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qy7OC-00024p-8d
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 05:19:53 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so74708901fa.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 02:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698830390; x=1699435190; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PvfGYQAf8rR+gkB7UGOsowdVVBIDkfG8GVzI7GEQYcw=;
 b=FmDAvb2Tx/JCZlL/ECjXZkcRQ2HU6P53i8SHVtBR4llep2A8cv4hJqIYjnpzE9cYlV
 7s3ZTmc/Bt3i4dRO6MJnCWDQeiVmags0Q4+vmXiX/5yfjPH0AH/VWxXz6xcrOgLUfNxh
 jiFMcpVnoWvD3N293DjFEFdEruixVHsJ5zCh/D/H3ifx2WR4xxiLHAB+GcRa9LqtkUUU
 mjyvld81rOsN9cFCPLgp3eMAeeYdF5TcPY8llIih7ql21Pges1lwIlZB5VIC/9/N2Uy4
 QNUhGXbmFNJ6PNdSWeBBCm2EkwBpUBuy4eknud/4MMHip067pSo854OdnzvjBe4Y4qIG
 CLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698830390; x=1699435190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PvfGYQAf8rR+gkB7UGOsowdVVBIDkfG8GVzI7GEQYcw=;
 b=GQNFyDS9ua7W8cu8Yt9Qhro1WFt2amtXjksxixebPAQmt33g3dvuCl3gvvbkS3NRyf
 h6WD1jQqqLJ1N77vKLduLcxnqsdAWg6Zx5qB6VHSfkbk4HM3kiX5sPko7WSQmrz0Ewm6
 HgMjLHYwEg0hAwqsFtfeFJiIfbNB91r4jddGAXItzUVKiOzacilYrC9rHkQ2wiI5+sa6
 d7gxfEW1Bf+kLJ9Loc3NFObRhPKc/7hfCIQ9QpgrkY12vgOKPxZqgqjj43KPFkKQUI9P
 tpSK1+0taGV/sh4Iij6IUfH1PH5UzscTFXQhU1m4+I2BYqe9xGqX1vMLJaWvAlo/qaNZ
 4CqQ==
X-Gm-Message-State: AOJu0YzyFcFt0pUxncsFxlBS7WaHgLN9JkH+m8lwMvWdsCxsuMgpLmNU
 MjZCtbm65F8j9GB+akFK6V+pkg==
X-Google-Smtp-Source: AGHT+IHIyIEhW0carXk8e0fOpyJtDG7aku4kSUBFTbORoP+bs6ReasJAb0B3a9wdTkyHN9Svwe69Tg==
X-Received: by 2002:a2e:9198:0:b0:2b9:412a:111d with SMTP id
 f24-20020a2e9198000000b002b9412a111dmr12667236ljg.42.1698830390023; 
 Wed, 01 Nov 2023 02:19:50 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 p14-20020adfcc8e000000b0032dbf32bd56sm3688282wrj.37.2023.11.01.02.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 02:19:49 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:19:48 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v7 01/16] target/riscv: create TYPE_RISCV_VENDOR_CPU
Message-ID: <20231101-2b306f5b57863cf8136f568a@orel>
References: <20231031203916.197332-1-dbarboza@ventanamicro.com>
 <20231031203916.197332-2-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031203916.197332-2-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=ajones@ventanamicro.com; helo=mail-lj1-x232.google.com
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

On Tue, Oct 31, 2023 at 05:39:01PM -0300, Daniel Henrique Barboza wrote:
> We want to add a new CPU type for bare CPUs that will inherit specific
> traits of the 2 existing types:
> 
> - it will allow for extensions to be enabled/disabled, like generic
>   CPUs;
> 
> - it will NOT inherit defaults, like vendor CPUs.
> 
> We can make this conditions met by adding an explicit type for the
> existing vendor CPUs and change the existing logic to not imply that
> "not generic" means vendor CPUs.
> 
> Let's add the "vendor" CPU type first.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 30 +++++++++++++++++++++---------
>  2 files changed, 22 insertions(+), 9 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

