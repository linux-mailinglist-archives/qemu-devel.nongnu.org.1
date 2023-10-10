Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52B7BFBA1
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:37:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqByu-0000zu-1I; Tue, 10 Oct 2023 08:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqByr-0000zG-PS
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:36:57 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqByp-0000hc-Rt
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 08:36:57 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-536b39daec1so9475041a12.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696941414; x=1697546214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d14YGOEtU9lfuVPByezkenYbM1XtV0/Ipw3v3EV0Uls=;
 b=qrn7W+27s1bQ9ZZczrbGS3JTw2mrKGceOaQ0qO5SnYAUP2lKxThSUpllXJbx1os6Dq
 aksrRh+HEZ/zOszp7ImyuQluR79fV7378R9rPF0HXd6gpGaalqlKfT8dw1enGAjTzVMu
 4GG0x1EO54FxgCd7xMiy8qmT+un4+ojfcsYeMkC62MyQB82YDqYlH5iK6fsHDRHGdI5+
 KHaZ9nuNGzKND5yrnsxLNTFHDVt7lhkYYh5tqTfkFltK9RNQrSOxCGjI1qV13nOKCQRf
 bqBazub3TD/AKFr4j6p5mlQeDfhr/XeOvOZ5J2K/zGdSl7jRjxMnCKqaBQUhdTQeNS0H
 k27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696941414; x=1697546214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d14YGOEtU9lfuVPByezkenYbM1XtV0/Ipw3v3EV0Uls=;
 b=wdWNYJUiTV+pR0+o0REjTaodpLEgwUjC/nqluPihQ96NhivF1cLOvZqbVWZo5/OHNY
 PtQIUyj2QRdzCnw91/7n26wNHo5M5fo+YInWd2ZmVCmVil9FSLK4/Z4Qvbkk6lHXYCHJ
 2lpkD7vQcNdTluE1IJZU9ckRCalMzNg8kyAZ6FkZLZcwunAhYvdrjztr9AFKloscHi5J
 Gcp8G+tTei5GGQXQDGhsQenwQ9K2prRgEaB8kd2yy7j6LTCYj7cejsbQWm00LrtYTVRE
 UMONkccAXDvvZplTPfoGVQ/cO05Y+WLKXehAcp51iIe+B8Rxs0TCXM6QzeZGrz9p1TaR
 SgEQ==
X-Gm-Message-State: AOJu0YxyDvBiNSRmBPC8PKtqVBjTEDrxgWpLt6GREUauKXHHiE92PfjV
 5bxy/fK5Ipca3L9VWHtHOGj21qBtcmt5IxPJD2Y6Zw==
X-Google-Smtp-Source: AGHT+IFIGqx/KeCKmCocs5V26IgT1zD3vHOgnigSpdxzN44F2uVVSQ0SVRZ0klzn54vqFSWDK51qAA==
X-Received: by 2002:aa7:ca46:0:b0:533:87c9:4a7d with SMTP id
 j6-20020aa7ca46000000b0053387c94a7dmr16532433edt.35.1696941414127; 
 Tue, 10 Oct 2023 05:36:54 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a50ee9a000000b0052e1783ab25sm7646478edr.70.2023.10.10.05.36.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 05:36:53 -0700 (PDT)
Message-ID: <b8911ed0-9eae-a0d0-1b32-61876d4ee55a@linaro.org>
Date: Tue, 10 Oct 2023 14:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v17 16/16] accel/tcg: Dump hot TBs at the end of the
 execution
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: fei2.wu@intel.com
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231003183058.1639121-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 3/10/23 20:30, Richard Henderson wrote:
> From: Fei Wu <fei2.wu@intel.com>
> 
> Dump the hottest TBs if -d tb_stats:{all,jit,exec}[:dump_num_at_exit]
> 
> Signed-off-by: Fei Wu <fei2.wu@intel.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/bsd-proc.h    |  2 ++
>   include/tcg/tb-stats.h | 10 +++++++++-
>   accel/tcg/monitor.c    |  8 +++++---
>   accel/tcg/tb-stats.c   | 27 ++++++++++++++++++++++++++-
>   linux-user/exit.c      | 10 ++++++----
>   softmmu/runstate.c     |  2 ++
>   stubs/tb-stats.c       |  6 +++++-
>   util/log.c             | 20 ++++++++++++++++----
>   8 files changed, 71 insertions(+), 14 deletions(-)


> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index 1652ed0439..2c6fb9bff1 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -59,6 +59,7 @@
>   #include "sysemu/runstate-action.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/tpm.h"
> +#include "tcg/tb-stats.h"
>   #include "trace.h"
>   
>   static NotifierList exit_notifiers =
> @@ -846,6 +847,7 @@ void qemu_cleanup(void)
>       /* No more vcpu or device emulation activity beyond this point */
>       vm_shutdown();
>       replay_finish();
> +    tb_stats_dump_atexit();
>   
>       /*
>        * We must cancel all block jobs while the block layer is drained,
> diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
> index ceaa1622ce..f9e4ef5d04 100644
> --- a/stubs/tb-stats.c
> +++ b/stubs/tb-stats.c
> @@ -11,6 +11,10 @@
>   #include "qemu/osdep.h"
>   #include "tcg/tb-stats.h"
>   
> -void tb_stats_init(uint32_t flags)
> +void tb_stats_init(uint32_t flags, uint32_t atexit)
> +{
> +}
> +
> +void tb_stats_dump_atexit(void)
>   {
>   }

The stub isn't needed using:

-- >8 --
diff --git a/softmmu/runstate.c b/softmmu/runstate.c
index 2c6fb9bff1..d05e2b8e1c 100644
--- a/softmmu/runstate.c
+++ b/softmmu/runstate.c
@@ -52,6 +52,7 @@
  #include "qom/object.h"
  #include "qom/object_interfaces.h"
  #include "sysemu/cpus.h"
+#include "sysemu/tcg.h"
  #include "sysemu/qtest.h"
  #include "sysemu/replay.h"
  #include "sysemu/reset.h"
@@ -847,7 +848,9 @@ void qemu_cleanup(void)
      /* No more vcpu or device emulation activity beyond this point */
      vm_shutdown();
      replay_finish();
-    tb_stats_dump_atexit();
+    if (tcg_enabled()) {
+        tb_stats_dump_atexit();
+    }

      /*
       * We must cancel all block jobs while the block layer is drained,
---

