Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972927CF6B9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:28:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRBf-0007c5-OA; Thu, 19 Oct 2023 07:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRBc-0007V7-Tm
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:27:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRBa-000378-IY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697714847;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/UKhXqbHobe0CtLZoqm46zlE8/XzwVYkVlVIh5zL3zk=;
 b=AHt2db6Ctl1vj86iiMlvOA/3p8Yi/TEzg2rJfkY9XqtdB1/Jbd4uGkGT2ticsksxILqUJf
 g8/KiRoHa/ABT604CxHyplmgWuF0NL1LOcoycc2Jqr54cVUM6e2XH3yxOUOiX6HEfmOxPb
 +HeK14VbUBrizSRJsfVcoiR1/39PjHI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-An_8UMf6O96H5_ZdQH5kAw-1; Thu, 19 Oct 2023 07:27:16 -0400
X-MC-Unique: An_8UMf6O96H5_ZdQH5kAw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3231fceb811so4542379f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697714833; x=1698319633;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/UKhXqbHobe0CtLZoqm46zlE8/XzwVYkVlVIh5zL3zk=;
 b=DU6nBmA/6yO4nD1YVoZ9bHLlnef4QZlUnx7Xv8rvfD9jafNc1ABevLLAqIV7x7FbC3
 h8BJSh40BLwBLgVkllOShCKFA3k4u7orfFhBmaWD5N+BP1L16q9om3HuioIT6isFDtWL
 dQsvhb2QPr1acPKrKtcJbJXAyoVnTauwDbklCYDq/pKlqKo0APkQQURFjsowxeLnufiB
 x1rIH7CkKNYAgawmudBcSyrQKL8Hvu9CufM4aBnRIxvWGlv4GT8elINl56ZY76sYD15c
 UbMh66ElMxGSRFzUL0f2YlkwZWsUk8WtoX/VPc4e3phxCwz8dXkdg3nuR/2SAcQtgqa+
 iklA==
X-Gm-Message-State: AOJu0Yw4tDRLXls5s+6CQ77XKY7RdF5juuPvbb9DcsWPO6iqhjQxPgLq
 2zlqPO1lox7RK7DURRvHjPmrfNPJLU5peg6N1xWtUH4x/m5xDFPzD/Z+4V54Vs/yqhy5RYyjBH1
 4/U9AUMqbhShB2XA=
X-Received: by 2002:a5d:5341:0:b0:320:1c7:fd30 with SMTP id
 t1-20020a5d5341000000b0032001c7fd30mr1301093wrv.17.1697714833663; 
 Thu, 19 Oct 2023 04:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlFQR5rFQ1j3gXy5rKIWGjvTkCuBtPFbLpXJFSU9iLe3wwbrZkAD2l+K1Auy5r3KCPWfgiMg==
X-Received: by 2002:a5d:5341:0:b0:320:1c7:fd30 with SMTP id
 t1-20020a5d5341000000b0032001c7fd30mr1301078wrv.17.1697714833356; 
 Thu, 19 Oct 2023 04:27:13 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f4-20020a056000128400b0031c5e9c2ed7sm4265828wrx.92.2023.10.19.04.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:27:12 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 4/5] migration iaa-compress: Add IAA initialization and
 deinitialization
In-Reply-To: <20231018221224.599065-5-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:23 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <20231018221224.599065-5-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:27:12 +0200
Message-ID: <87leby6een.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Yuan Liu <yuan1.liu@intel.com> wrote:
> This patch defines the structure for IAA jobs related to data
> compression and decompression, as well as the initialization and
> deinitialization processes for IAA.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

You should be using orderfile.

$ less .git/config
...
[diff]
        orderFile = scripts/git.orderfile

So .h and friends came first in patches.

> diff --git a/migration/ram-compress.c b/migration/ram-compress.c
> index 47357352f7..acc511ce57 100644
> --- a/migration/ram-compress.c
> +++ b/migration/ram-compress.c
> @@ -30,6 +30,9 @@
>  #include "qemu/cutils.h"
>  
>  #include "ram-compress.h"
> +#ifdef CONFIG_QPL
> +#include "iaa-ram-compress.h"
> +#endif
>  
>  #include "qemu/error-report.h"
>  #include "migration.h"
> @@ -484,10 +487,11 @@ int ram_compress_save_setup(void)
>      if (!migrate_compress()) {
>          return 0;
>      }
> +#ifdef CONFIG_QPL
>      if (migrate_compress_with_iaa()) {
> -        /* Implement in next patch */
> -        return 0;
> +        return iaa_compress_init(false);
>      }
> +#endif
>      return compress_threads_save_setup();
>  }
>  
> @@ -496,10 +500,12 @@ void ram_compress_save_cleanup(void)
>      if (!migrate_compress()) {
>          return;
>      }
> +#ifdef CONFIG_QPL
>      if (migrate_compress_with_iaa()) {
> -        /* Implement in next patch */
> +        iaa_compress_deinit();
>          return;
>      }
> +#endif
>      compress_threads_save_cleanup();
>  }
>  
> @@ -516,9 +522,11 @@ int ram_compress_load_setup(QEMUFile *f)
>      if (!migrate_compress()) {
>          return 0;
>      }
> +#ifdef CONFIG_QPL
>      if (migrate_compress_with_iaa()) {
> -        /* Implement in next patch */
> +        return iaa_compress_init(true);
>      }
> +#endif
>      return compress_threads_load_setup(f);
>  }
>  
> @@ -527,8 +535,11 @@ void ram_compress_load_cleanup(void)
>      if (!migrate_compress()) {
>          return;
>      }
> +#ifdef CONFIG_QPL
>      if (migrate_compress_with_iaa()) {
> -        /* Implement in next patch */
> +        iaa_compress_deinit();
> +        return;
>      }
> +#endif
>      compress_threads_load_cleanup();
>  }

I think it would be easier to understand and implement if you drop
patch3, and just add at each place that there is a:

compress_threads_load_cleanup()

a

iaa_load_cleanup()

And the same for everything else.

Later, Juan.


