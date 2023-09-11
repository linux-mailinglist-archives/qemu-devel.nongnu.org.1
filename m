Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF78979A517
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 09:54:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfbkb-0005M2-9Y; Mon, 11 Sep 2023 03:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfbkZ-0005Ld-QS
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:54:27 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1qfbkX-0000Sz-LH
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 03:54:27 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso46942265e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694418864; x=1695023664; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Pgcf+qoRGes7PKbTxJpWLTzrDuRYQcg6IeURFzE8QkM=;
 b=PDmJc5mrP38YNZ8fEvqbXt176Awo3DD/i3IN/PbQN9BGC+mMb5cAOm4NoqklOtd4Lb
 EMKXW/9V4TyXHgOwv2sYCPA2181IhVB/lZpx33le2CX1JrG2V6VV0GX00eUsebw+hEs+
 PUYCNJAL+fQsrjpFkVJwsDB8Q4JOviwhhWubEOOrPplnqa4s3RTmawJRXEckLK92JKz9
 otLdNEx0ZxeTJrjWcLmmOO0MELGeFMbU6rgO9TkBxC0Sc+sCarYs0R55t6emos/fJ/Zh
 gh70cTMT6c3MZLuzK5A7NA0FZJhUaHqNrSwWw60nGraS36cZc2A04AsuxYkC34lrhZx9
 /MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694418864; x=1695023664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pgcf+qoRGes7PKbTxJpWLTzrDuRYQcg6IeURFzE8QkM=;
 b=gsrG6vo/O6FHgz2f1+l4GP+Xi7pbHZlv1zdwIT0sAiAOG0uqwdHa0p2eYHZCj5mmOi
 6/a0y8Zy2lsaZn8BMW5h1tuD/XYh5ST5ofSb2cHcn5BQs5moi12COSDM1kdGkjXlpeCC
 1Xh4U6I/rEWgzZExZGEjpZgTggJNg5l3FWll4u5qbcEJAi9voCxhw4RKspe9aWNbkpIQ
 WWfGdK0DTIBYqSgOSH2vo3PDGLnaC2htqUPN3XxL6U1+aHVlCahz34NkEQvuCsRxIVNx
 6Ept+M4RdRD8Y8LlGq/phABSAxUPPtKjZ9jsAeTIG5GWjRfK06YOSSs0kl8fpWcC1d+q
 I5+A==
X-Gm-Message-State: AOJu0Yyn8pcUDxZR+FSxvAd9X/yhDn/qy+yBu1mljhT8suZA+xmwNhZV
 FuRie+lep8YSph5m/c1CEloAuQ==
X-Google-Smtp-Source: AGHT+IHg8jNSQr7OsqipJ+9nLA62mN9DiJYfs3OnKw0Uj3Dy83eB5QVzJLx7jXk5pO/UhjdACzNwpA==
X-Received: by 2002:a1c:4b03:0:b0:401:264b:5df7 with SMTP id
 y3-20020a1c4b03000000b00401264b5df7mr7916780wma.35.1694418864012; 
 Mon, 11 Sep 2023 00:54:24 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a05600c3b8c00b00402f713c56esm9245532wms.2.2023.09.11.00.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 00:54:23 -0700 (PDT)
Date: Mon, 11 Sep 2023 09:54:23 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, philmd@linaro.org
Subject: Re: [PATCH v2 14/19] target/riscv/cpu.c: export set_misa()
Message-ID: <20230911-a6753d3b31585cb170161702@orel>
References: <20230906091647.1667171-1-dbarboza@ventanamicro.com>
 <20230906091647.1667171-15-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906091647.1667171-15-dbarboza@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Sep 06, 2023 at 06:16:41AM -0300, Daniel Henrique Barboza wrote:
> We'll move riscv_init_max_cpu_extensions() to tcg-cpu.c in the next
> patch and set_misa() needs to be usable from there.
> 
> Rename it to riscv_cpu_set_misa() and make it public.
> 
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu.c | 34 ++++++++++++++++++----------------
>  target/riscv/cpu.h |  1 +
>  2 files changed, 19 insertions(+), 16 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

