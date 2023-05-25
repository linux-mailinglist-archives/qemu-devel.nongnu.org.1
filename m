Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 587F5710ED9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:57:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2CNi-0001vu-3G; Thu, 25 May 2023 10:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CNf-0001uK-1n
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2CNd-0001Vl-8m
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685026552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OzVq+sm1mDT86ush46+bEsY7HvZS3p8H6nFf05nTE+0=;
 b=iKspxpWCdaBCNZHdyjQxWelJGEW/j1kNVOODG8dedb1v9uIft/crgZlcTj0xH5UuXEnL1j
 OEUZvyWJYFd8yYKkqZ7XPbDynTfZ/Z6i2IfgFVl5xININX1maDZd9odvR2Dw3Q6fEx8uMr
 bpkZ+NN/ejOZb/nF+IQYZ7ptMa4pJ7Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-257-CRUqxbfgMUuzjgvuUNmA8g-1; Thu, 25 May 2023 10:55:50 -0400
X-MC-Unique: CRUqxbfgMUuzjgvuUNmA8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A83421C0878E;
 Thu, 25 May 2023 14:55:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D0C87AF5;
 Thu, 25 May 2023 14:55:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A2C421E692E; Thu, 25 May 2023 16:55:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrei Gudkov <gudkov.andrei@huawei.com>
Cc: <qemu-devel@nongnu.org>,  <eduardo@habkost.net>,
 <marcel.apfelbaum@gmail.com>,  <philmd@linaro.org>,
 <wangyanan55@huawei.com>,  <eblake@redhat.com>
Subject: Re: [PATCH] [query-memory-size-summary] Report page size
References: <3200757e8218f65f873e79ab84a4b8382fbfa099.1684483058.git.gudkov.andrei@huawei.com>
Date: Thu, 25 May 2023 16:55:48 +0200
In-Reply-To: <3200757e8218f65f873e79ab84a4b8382fbfa099.1684483058.git.gudkov.andrei@huawei.com>
 (Andrei Gudkov's message of "Fri, 19 May 2023 11:10:30 +0300")
Message-ID: <87jzwwo3yj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Andrei Gudkov <gudkov.andrei@huawei.com> writes:

> Some commands (query-migrate and calc-dirty-rate) report values
> in units of pages. However, currently the only place where we can
> get page size is through query-migrate and only after migration
> has started. query-memory-size-summary seems like an appropritate
> place where it should be reported instead.
>
> Signed-off-by: Andrei Gudkov <gudkov.andrei@huawei.com>
> ---
>  qapi/machine.json          | 8 ++++++--
>  hw/core/machine-qmp-cmds.c | 3 +++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 37660d8f2a..10b2d686da 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1125,10 +1125,13 @@
   ##
   # @MemoryInfo:
   #
   # Actual memory information in bytes.
   #
   # @base-memory: size of "base" memory specified with command line
   #     option -m.
   #
   # @plugged-memory: size of memory that can be hot-unplugged.  This
>  #     field is omitted if target doesn't support memory hotplug (i.e.
>  #     CONFIG_MEM_DEVICE not defined at build time).
>  #
> +# @page-size: the number of bytes per target page (since 8.1)

Recommend "size of target page in bytes" for consistency with the other
two sizes.

Machines may have multiple page sizes.  Should we discuss that here?

> +#
>  # Since: 2.11
>  ##
>  { 'struct': 'MemoryInfo',
> -  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size' } }
> +  'data'  : { 'base-memory': 'size', '*plugged-memory': 'size',
> +              'page-size': 'size' } }
>  
>  ##
>  # @query-memory-size-summary:
> @@ -1139,7 +1142,8 @@
>  # Example:
>  #
>  # -> { "execute": "query-memory-size-summary" }
> -# <- { "return": { "base-memory": 4294967296, "plugged-memory": 0 } }
> +# <- { "return": { "page-size": 4096, "base-memory": 34359738368,
> +#      "plugged-memory": 0 } }
>  #
>  # Since: 2.11
>  ##
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3860a50c3b..b768ff372f 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -27,6 +27,7 @@
>  #include "sysemu/numa.h"
>  #include "sysemu/runstate.h"
>  #include "sysemu/sysemu.h"
> +#include "exec/target_page.h"
>  
>  /*
>   * fast means: we NEVER interrupt vCPU threads to retrieve
> @@ -289,6 +290,8 @@ MemoryInfo *qmp_query_memory_size_summary(Error **errp)
>      mem_info->has_plugged_memory =
>          mem_info->plugged_memory != (uint64_t)-1;
>  
> +    mem_info->page_size = qemu_target_page_size();
> +
>      return mem_info;
>  }


