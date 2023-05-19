Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B49709C20
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 18:12:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02hk-0001Cj-Kr; Fri, 19 May 2023 12:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q02hi-0001BJ-Ql
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1q02hh-0005dd-9L
 for qemu-devel@nongnu.org; Fri, 19 May 2023 12:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684512700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kYmEvbwNYo4DjgLy+BIBNnAnbvYAmd61hZd2na3vlQo=;
 b=iXXHBLxhI/Lhk/R/V8YV9kyLnCKn7BtSrdzOuh7VHZvko02+DS7DVVJaP8pyG1ET2KYkKx
 jqGyKpAnLZusT9PO8W6XZVINpKzClZHCxK8lxpurrIdlP29/iQUIKvGXv7KLxYPqcvek/u
 BaYkt7MC5sy+07GCprcrBvdDqxHkqbE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-mafMnGx9M5OumIyWly6ALw-1; Fri, 19 May 2023 12:11:39 -0400
X-MC-Unique: mafMnGx9M5OumIyWly6ALw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2533b1e6e66so2181008a91.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 09:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684512698; x=1687104698;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYmEvbwNYo4DjgLy+BIBNnAnbvYAmd61hZd2na3vlQo=;
 b=Nvk762dz52gqoaDizMJaHUvIvb7RvK0cf/XNdf3rs93LgGgPZxH8Mul1PadzAO9XUx
 D22Gd7Ir+HTqa0GKk08OYTRjOwUA7PibZviideIH1jscHlEbm3UWmHjGSisVgzVP6kqK
 ALPlawHw73fEzQlFszv5Z9F44hQG4jpobP5ygfsoQ+rhDhf+fJeuXCDjZxL03FQBhxMl
 ko3UBuBW7EJM/+ipJrMDHMvxjmdZ21kmYe7PyHSAYqx2OL9p47Zd6yRE/gEvyi1Y5qba
 mrAj2rGP6oXZA4LHI84mgooiRzt9/GWh2MX6e9r/j/2hkfQBVjxr4SmJOeceBtzQBkN7
 8wfQ==
X-Gm-Message-State: AC+VfDy0XAlxWEiN8IjcCKNd+pVTyyh09hy/gAIjgF7FXhk8Np4wSNSN
 TzQA5m4cxt/wTFxd8lh5xeiRiHT7czje263r9lW+wvKHpYwXQAP5260Ein0QmFwcZliiZGht9XJ
 ngpDTqNlxwbbMZfcqcjHUEjmlxR1qR6ksmccT3Pc=
X-Received: by 2002:a17:90a:8c03:b0:24e:cb3:f7f8 with SMTP id
 a3-20020a17090a8c0300b0024e0cb3f7f8mr2721786pjo.46.1684512697931; 
 Fri, 19 May 2023 09:11:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5MahWyNM5C0x1fbg21vJHz6yjQHJKGTN1HKf8xR/+5LqYEkKglrO4UCus/RnjaFTTmihFcmNAy1Q68lBfkJ1o=
X-Received: by 2002:a17:90a:8c03:b0:24e:cb3:f7f8 with SMTP id
 a3-20020a17090a8c0300b0024e0cb3f7f8mr2721771pjo.46.1684512697686; Fri, 19 May
 2023 09:11:37 -0700 (PDT)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 19 May 2023 09:11:37 -0700
From: Andrea Bolognani <abologna@redhat.com>
References: <20230425102545.162888-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
In-Reply-To: <20230425102545.162888-1-sunilvl@ventanamicro.com>
Date: Fri, 19 May 2023 09:11:37 -0700
Message-ID: <CABJz62Og-9mVUfBKExMU1MG=UD7mnOKsdpeuEvXpoPTVn8TS7A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/riscv: virt: Assume M-mode FW in pflash0 only when
 "-bios none"
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Apr 25, 2023 at 03:55:45PM +0530, Sunil V L wrote:
> qemu-system-riscv64 -bios <opensbi_fw> \
> -drive file=<smode_fw_vars>,if=pflash,format=raw,unit=0 \
> -drive file=<smode_fw_code>,if=pflash,format=raw,unit=1,readonly=on  \
> -machine virt

I've noticed that edk2 for RISC-V, at least in the form it is
currently packaged for Fedora, doesn't seem to have separate CODE and
VARS files:

  $ ls /usr/share/edk2/riscv/* | cat
  /usr/share/edk2/riscv/RISCV_VIRT.fd
  /usr/share/edk2/riscv/RISCV_VIRT.raw

Is that something that needs to be addressed in upstream edk2? If so,
will you be looking into it?

-- 
Andrea Bolognani / Red Hat / Virtualization


