Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41A682C359
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 17:09:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOK55-0006Ao-HV; Fri, 12 Jan 2024 11:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rOK52-0006AP-Hh
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:08:24 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rOK50-0008J5-Tw
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 11:08:24 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e5f746ac4so23426065e9.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 08:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705075701; x=1705680501; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0ubLTfhMk+fXyP+oLOBo+/OmNpqbk1EAgBy6DmTrsik=;
 b=eN60fSSVuO5qk0l8OpzAtUeOCeQW5gtb2GOwgtlqm7DVixAttIj2X6lksfQa1oAI8w
 AGCSXkrmT+Tz/9XEqKLGZr4tRIW7BZRoRnj0n1Dy7GVWHeouLnHx+Cu8wNFqADOOZGEY
 YlyVbIvUmMstx/djFhrafvfviK0q/hP+ET1t8XBC+yhWPsyNt1/JQjdm+4NuQ05DZ+th
 S0JQOYv36cDUZfZQVFCd59xBO30cTFN2KUjv3rf7yHv6aXIH/MEukfo759ODT3G8tZlF
 NYtAWxOrsTCHmKqQO+OLfHTypQR3xj9f2WX7uD4DxzSNPMNhf/JD5abxZj1PMlPnY6sw
 Kmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705075701; x=1705680501;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0ubLTfhMk+fXyP+oLOBo+/OmNpqbk1EAgBy6DmTrsik=;
 b=AV+o+UGtB85Frn9JB4KSXpE7DmMshVOrV3XNFz8m6uDhV0hEFYoJee7djQ5nA2M4uC
 D/2G5A5Lj5mgTs45api5MQlx4IJGKaeAk66wA8BCYBz4YpLrxxdBGg4un2f5A0T3PUvX
 8m5ato6TOuXjlOTd47Zrw5qSadbHgyekG4CyScD9tjK1AQdUa/z5GjMlPn9tkOpA0c5g
 egOZ0R5g55CaUKLTJLEuzK0E8xi+ocN1yEk16l8Z/9ixM+dyWlnfbeKfEq1Z6Y19g0Xk
 IsrDNw0KZ3jcCV4YLpY5NkMrFPsCIR3bKUMd7bz5yksMT1DHe+JxcsePvGLneM7JB3El
 asLA==
X-Gm-Message-State: AOJu0YyNM2hSsCsgYEeDtXxDdS8SVMDd/vd+doKkX+sjwEeEssMRnsCF
 W6ae8GpjsvpOeR6fwvpzKYrfUp0bODjkfA==
X-Google-Smtp-Source: AGHT+IGUeaoLpyvd7j4yBL2GzkFGNHSeJmDa6qeA4DpiLst4sW+V8kZt9knavYkTeqlUGZj2Qa3PXw==
X-Received: by 2002:a05:600c:4991:b0:40e:60c0:d94 with SMTP id
 h17-20020a05600c499100b0040e60c00d94mr940092wmp.78.1705075700648; 
 Fri, 12 Jan 2024 08:08:20 -0800 (PST)
Received: from localhost (cst-prg-14-187.cust.vodafone.cz. [46.135.14.187])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a056000110f00b00336751cd4ebsm4284769wrw.72.2024.01.12.08.08.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 08:08:20 -0800 (PST)
Date: Fri, 12 Jan 2024 17:08:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, atishp@rivosinc.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 ved@rivosinc.com
Subject: Re: Re: Re: [PATCH 1/3] target/riscv: Add infrastructure for 'B'
 MISA extension
Message-ID: <20240112-d9e3cc215a7a68c5189908bf@orel>
References: <20240109171848.32237-1-rbradford@rivosinc.com>
 <20240109171848.32237-2-rbradford@rivosinc.com>
 <20240111-585fe1291fcaa1e0432674e3@orel>
 <20240111-df7a6acf3109b630469591a1@orel>
 <3dbd3fa1cbad80948175f98dcc0c76b886e2376e.camel@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dbd3fa1cbad80948175f98dcc0c76b886e2376e.camel@rivosinc.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x32c.google.com
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

On Thu, Jan 11, 2024 at 03:17:25PM +0000, Rob Bradford wrote:
> + Ved
> 
> On Thu, 2024-01-11 at 14:14 +0100, Andrew Jones wrote:
> > On Thu, Jan 11, 2024 at 02:07:34PM +0100, Andrew Jones wrote:
> > > On Tue, Jan 09, 2024 at 05:07:35PM +0000, Rob Bradford wrote:
> > > > Add the infrastructure for the 'B' extension which is the union
> > > > of the
> > > > Zba, Zbb and Zbs instructions.
> > > > 
> > > > Signed-off-by: Rob Bradford <rbradford@rivosinc.com>
> > > > ---
> > > > �target/riscv/cpu.c�������� | 5 +++--
> > > > �target/riscv/cpu.h�������� | 1 +
> > > > �target/riscv/tcg/tcg-cpu.c | 1 +
> > > > �3 files changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> > > > index b07a76ef6b..22f8e527ff 100644
> > > > --- a/target/riscv/cpu.c
> > > > +++ b/target/riscv/cpu.c
> > > > @@ -38,9 +38,9 @@
> > > > �#include "tcg/tcg.h"
> > > > �
> > > > �/* RISC-V CPU definitions */
> > > > -static const char riscv_single_letter_exts[] = "IEMAFDQCPVH";
> > > > +static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
> > > 
> > > Is there a corresponding proposed change to table 29.1 of the
> > > nonpriv spec
> > > which states B comes after C and before P? If so, can you provide a
> > > link
> > > to it? Otherwise, how do we know that?
> > 
> > Oh, I see. The unpriv spec B chapter comes after the C chapter (and
> > before
> > J, P, ...). I still wonder if we'll have a 29.1 table update with the
> > ratification of this extension though.
> > 
> > 
> 
> I agree it's a bit confusing - but the order is established by the
> table in the unprivileged spec and the table explanation also makes
> this clear.
> 
> """
> Table 27.1: Standard ISA extension names. The table also defines the
> canonical order in which
> extension names must appear in the name string, with top-to-bottom in
> table indicating first-to-last
> in the name string, e.g., RV32IMACV is legal, whereas RV32IMAVC is not.
> """

Yes, this is the table I was referring to when I referenced "table 29.1 of
the nonpriv spec". Since there's a chance I was looking at too old a spec
I've now gone straight to the source,

https://github.com/riscv/riscv-isa-manual/blob/main/src/naming.adoc

but I still don't see B there. Do you see B in the table you're looking
at?

> 
> The proposed B specification does not make any remarks about the
> ordering in the ISA definition string. [1] I would worry there would be
> a lot of software churn if this ordering were to be changed.

The ordering shouldn't change, but I can't see where it's documented
(beyond the B chapter coming after the C chapter).

Thanks,
drew

