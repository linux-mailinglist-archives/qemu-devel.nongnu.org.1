Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F34638C3BF5
	for <lists+qemu-devel@lfdr.de>; Mon, 13 May 2024 09:25:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Q3p-0005bN-H2; Mon, 13 May 2024 03:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6Q38-0005Pb-NO
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s6Q35-0005sr-Oa
 for qemu-devel@nongnu.org; Mon, 13 May 2024 03:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715585078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=64xZp2Beiw954oiR1PPaKPvxX6aMBVUGofDpucnkWX4=;
 b=Yxcl70LeIADYfu8qBHOTHseLyV5Ft1FhJAVv+tLOlKmrLgTZy4CDfqZUYIpHF559BYCioz
 rhDG57q3x1oH7xX+VsuG9Cv5c0AJjF+KHoBkuyJMjtpNc9YOb/CMWg2T1nO7WLvhtjDXV9
 MQ5YGBis7SUw1gTg5mjfDDv/BOBK+jw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-0OEG1Z6SOoKK-1iKdvPreA-1; Mon, 13 May 2024 03:24:37 -0400
X-MC-Unique: 0OEG1Z6SOoKK-1iKdvPreA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D565680027F;
 Mon, 13 May 2024 07:24:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6693C15BB1;
 Mon, 13 May 2024 07:24:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B5E6F21E66E5; Mon, 13 May 2024 09:24:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: inspireMeNow <inspiremenow@murena.io>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] fix: correct typo in ext_zvkb configuration variable
 Signed-off-by: Kaiyao Duan <inspiremenow@murena.io>
In-Reply-To: <20240510034747.116408-1-inspiremenow@murena.io>
 (inspiremenow@murena.io's message of "Fri, 10 May 2024 11:47:42
 +0800")
References: <20240510034747.116408-1-inspiremenow@murena.io>
Date: Mon, 13 May 2024 09:24:35 +0200
Message-ID: <87pltqb2do.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

inspireMeNow <inspiremenow@murena.io> writes:

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index eb1a2e7d6d..13cd34adbd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1535,7 +1535,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>      /* Vector cryptography extensions */
>      MULTI_EXT_CFG_BOOL("zvbb", ext_zvbb, false),
>      MULTI_EXT_CFG_BOOL("zvbc", ext_zvbc, false),
> -    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkg, false),
> +    MULTI_EXT_CFG_BOOL("zvkb", ext_zvkb, false),
>      MULTI_EXT_CFG_BOOL("zvkg", ext_zvkg, false),
>      MULTI_EXT_CFG_BOOL("zvkned", ext_zvkned, false),
>      MULTI_EXT_CFG_BOOL("zvknha", ext_zvknha, false),

Commit message should be like

    target/riscv: Correct definition of extension "zvkb"

    Extension "zvkb" accidentally controls "zvkg" instead.  [Brief
    description of the bug's impact]

    Fixes: ea61ef7097d0 (target/riscv: Move vector crypto extensions to riscv_cpu_extensions)
    Signed-off-by: Kaiyao Duan <inspiremenow@murena.io>

Thanks!


