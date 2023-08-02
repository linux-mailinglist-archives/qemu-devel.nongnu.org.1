Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294A176C2D6
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 04:23:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qR1V9-0008U9-Ss; Tue, 01 Aug 2023 22:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qR1V7-0008Tw-Gb
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 22:22:13 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qR1V5-0007ka-1Z
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 22:22:13 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99bf8e5ab39so636911866b.2
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 19:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1690942929; x=1691547729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EjJymWC91tmi3WCSof0u8uXd+rHE3hj/zMDbZSmGmG4=;
 b=dpBHJ3au+HJXihi8pePGQF2rMawVYCbq6hnRoxOV1N0dHXGySuiDuF6kiuAVHoG2WM
 FNNxi7P1MzpZuDqIJNX6LxOnjk0a7lvClYYnErG/e5h7JG1uQVd+KDKN+k4HU3UlYSO7
 KgL7WelOUeW+rZySg7ChW0bELGOc66R6SjByo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690942929; x=1691547729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EjJymWC91tmi3WCSof0u8uXd+rHE3hj/zMDbZSmGmG4=;
 b=kJjNFmGi6t78nE5Y8RQ5bTWeY5YIKtnGKKEt1CfIb6ZS07Tbc2ntdMYCXmzyxqjToa
 8DJjfmJafg/40aR97UTJlXOnnGGnO7TPK4Q/ohJf5rQNzU4ZoQ2IgwErxsfZ6GngfE+M
 YfrB+flNmyCzjX/xbLKy3lQM+joa0akkTy+/ahU3dnG5rYmwECQYpEk0h86deSZoGqxh
 Ei7HO8MVL9EUWbZr25XXTyQ6s2UO56ZMwNlubzj9kAuUIisLf9wibpJkfZkBi7kQhVuT
 9z57K8yCPtXU20U329y66UnnsV9E8vY5qZzHcrsQHHD5MLyh5TDWhg2lSvJ83mHs3CxN
 e1UA==
X-Gm-Message-State: ABy/qLa6BP4Z/VLeWXIcRqK2wspklipOuPJdxEJ20MoW3536sJwpogb5
 H8uRlFeNgxWYctirfsbkgCHKeLWrXH/qP4ygVi0=
X-Google-Smtp-Source: APBJJlHHl9UN30WCw15q4fqlnSbPUkwza4maWqordlYBIFwKzjryKP7v2Gcok+NSOInGm7SrX8SmiuxPbRdhJYSQaEY=
X-Received: by 2002:a17:906:5308:b0:99b:fdbb:3203 with SMTP id
 h8-20020a170906530800b0099bfdbb3203mr3755965ejo.3.1690942928908; Tue, 01 Aug
 2023 19:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230801232745.4125-1-deller@gmx.de>
In-Reply-To: <20230801232745.4125-1-deller@gmx.de>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 2 Aug 2023 02:21:56 +0000
Message-ID: <CACPK8XfGNcDEPEsJkcfPjfhCx76ioYr4uOmXK6ziwb9iRwBaaA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] linux-user: brk fixes
To: Helge Deller <deller@gmx.de>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 1 Aug 2023 at 23:28, Helge Deller <deller@gmx.de> wrote:
>
> This patch series is a fix-up for some current problems
> regarding heap memory / brk handling in qemu which happens
> on some 32-bit platforms, e.g. problems loading static
> binaries.
>
> This series includes the 5 patches from Akihiko Odaki
> with some additional fixes and cleanups by me.

This has the same segfault as the branch that I previously tested,
when running on a ppc64le host..

As a reminder, the ppc64le machine (normally, and does in this case)
uses a 64K page size. I think this is a detail that is missing from
your chroot testing.


>
> Akihiko Odaki (5):
>   linux-user: Unset MAP_FIXED_NOREPLACE for host
>   linux-user: Do not call get_errno() in do_brk()
>   linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
>   linux-user: Do nothing if too small brk is specified
>   linux-user: Do not align brk with host page size
>
> Helge Deller (3):
>   linux-user: Show heap address in /proc/pid/maps
>   linux-user: Optimize memory layout for static and dynamic executables
>   linux-user: Load pie executables at upper memory
>
>  include/exec/cpu_ldst.h |  4 +--
>  linux-user/elfload.c    | 59 ++++++++++--------------------
>  linux-user/loader.h     | 12 +++++++
>  linux-user/main.c       |  2 ++
>  linux-user/mmap.c       | 35 ++++++++++--------
>  linux-user/qemu.h       |  4 +--
>  linux-user/syscall.c    | 80 ++++++++++++-----------------------------
>  7 files changed, 79 insertions(+), 117 deletions(-)
>
> --
> 2.41.0
>

