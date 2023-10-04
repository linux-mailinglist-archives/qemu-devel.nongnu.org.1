Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80357B7BDC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:24:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny60-0007Db-6L; Wed, 04 Oct 2023 05:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qny5v-0007Ct-1Y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:23:03 -0400
Received: from esa1.hc2706-39.iphmx.com ([68.232.153.39])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qny5r-0005aU-Sj
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:23:01 -0400
X-CSE-ConnectionGUID: pHdA5IPcSA6mxfgnp7doMA==
X-CSE-MsgGUID: zH//dmAsTemaY7LJYMTzEg==
X-IronPort-RemoteIP: 209.85.166.71
X-IronPort-MID: 311521297
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:wU8g166ysTSBnfr4Nn++cAxRtIXFchMFZxGqfqrLsTDasY5as4F+v
 mEfDDzXOfyKNmrxfogjYYqypk8Gu8CGztJhQQBv/C5hEysa+MHIO4+lIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48D8kk/nOH+KgYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMsMpvlDs15K6p4WtA4gRkDRx2lAS2e0c9Xcp3yZ6ZciOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNy+uTnuUiG9Y+DCDX4pZkc/HKbitq/0Te5p0G2M80Mi+7vdkoc+dZk
 72hvbToIesg0zaldO41CnG0GAknVUFKFSOuzdFSfqV/wmWfG0YAzcmCA2kuHYExp8dPClpnq
 /kIJj8Ldk+PgMeflefTpulE3qzPLeHuNYIb/3BnlHTXUq9gTpfETKHHo9Rf2V/chOgURaeYN
 5dfMGQxKkuZC/FMEg5/5JYWleO4gHXlWzdF7l+ZuMLb5kCIlVUsiuG3YYW9ltqiV+US2Uqdj
 3n68mHwM04+Fu269Sio/Sf57gPItWahMG4IL5Wh+/t3xVGe2GEXIBsRU1S9vL++kEHWZj5EA
 0kd+y5rrK9rsUL0F5/yWBq3pHPCtRkZMzZNL9AHBMi24vK8y26k6qIsF1attPROWBcKeAEX
IronPort-HdrOrdr: A9a23:jn+s36BQXFBshvLlHelg55DYdb4zR+YMi2TDGXoBLiC9Vvbo6v
 xG+85rqSMc6QxhIk3I/OrrBEDuewK/yXcY2/h1AV7mZniYhILKFvAY0WKB+UyYJ8SWzIc0vt
 YCT0E9MqyJMbETt6bHCWKDYrAdKbe8gcSVrNab5VtWCS9RV4FcwzFQNju7e3cGOjWuxqBUKH
 Nf3Kd6TvabF0j/p/7VZ0U4Yw==
X-Talos-CUID: 9a23:R//XVG0UwuVCp0STYi5LB7xfAuApWyD89HzrChG9GWhmTqXKRVi10fYx
X-Talos-MUID: =?us-ascii?q?9a23=3AM85iOw8CgSX3Panw8XV8UUSQf9VIpOOiDWkWrZg?=
 =?us-ascii?q?DsvjbEQ5BHguPoTviFw=3D=3D?=
Received: from mail-io1-f71.google.com ([209.85.166.71])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Oct 2023 05:22:55 -0400
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7a253f0bc9eso121336139f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1696411374; x=1697016174; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BV+C949xhkFKZqvVI3hGe8/xW89n4x3Df+hRb88uucQ=;
 b=LjnRecA4j0J2V9fEEMiEIjkKftfu/jDXrnTwYVUprrntfy0UyW8tLkgcUlajIUtq4C
 i5S7ytYYOXQ+so2YyFOISyrad2n2g5Ir65C/uitvR6jaJDh5lQUv4ckQGcU8bXXLQuZs
 Eps64bkCvzpddtEWoR62VC/WDK6U6dfqFgx+5gVlhheSjtdHgWHcHB60xqvw2h+rAxzT
 +SJciZ8hFS/Z+2qD6imJXBgwSKZYzpHhY1XPt4U2EqG2svW4IUu8uEaYTjN15LKKLc2r
 O3nB92X6TPVY4UySjoGTAuEjOlfm/taLOWdUmwHAjJ1OxSetHEkp6RokvuET8p/t/l8H
 6iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411374; x=1697016174;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BV+C949xhkFKZqvVI3hGe8/xW89n4x3Df+hRb88uucQ=;
 b=B/YDOm1hYaZAbMhOU8ZqWnLfwN+e2XfQtZumW4wAwn5F1YrtGoXBCyKGRbr4opxjIz
 iBkXdVt9/hwMIjq+SFC2J4J9XeuA8gLc/7z+3cxlYV5XlLVsVtUjWWmlJpCzBmh0N39a
 LEX0ihAVXMCL/zW6caIqyf7qRNL5Wymrd8ndoEOPD69IOKSS9Wo/sVFeTrCJwWVdyDAA
 Tsu5Lfcd4BVzgnRnHjHPBF0Oqz2AezKOr1A9bVYqpbbZK+YQum+8sSSq5UA9zOw+s+Yy
 +xNG9MxdTHuChg4QEEyfDbHGjfpcoAcGdsdG5G/l9CQRLL/iwF/USHeiTaaRUMHoV1nb
 RO2Q==
X-Gm-Message-State: AOJu0YxlyAkc1Pn2zoKli+WiJhW1TX4G+6xlRYE9ooTV7t7HSKxBixpq
 MGuRxNOMktu4cztXE8INS6C4YeMuxdu+eszECmoe0zU6OzEXJUogOdgZE037mtP/aYyPz1PdpmK
 AuskNJxnkB86+2H/Wv9hzMEx9JJg3cg==
X-Received: by 2002:a05:6e02:13d0:b0:351:526a:4ac with SMTP id
 v16-20020a056e0213d000b00351526a04acmr1696817ilj.2.1696411374764; 
 Wed, 04 Oct 2023 02:22:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsq6wbxMsmgt516UTp/VPMAzJSnUNAq5mXSN6YN7sSwBcbUH5/lsYS9MVQq9zofugs44phHw==
X-Received: by 2002:a05:6e02:13d0:b0:351:526a:4ac with SMTP id
 v16-20020a056e0213d000b00351526a04acmr1696803ilj.2.1696411374492; 
 Wed, 04 Oct 2023 02:22:54 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a92cbca000000b003514e467230sm874100ilq.19.2023.10.04.02.22.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 02:22:54 -0700 (PDT)
Date: Wed, 4 Oct 2023 05:22:48 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 04/13] fuzz: Correct invalid mentions of 'softmmu' by
 'system'
Message-ID: <20231004092238.twpzrp4iwvhx7mp4@mozz.bu.edu>
References: <20231004090629.37473-1-philmd@linaro.org>
 <20231004090629.37473-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231004090629.37473-5-philmd@linaro.org>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=68.232.153.39; envelope-from=alxndr@bu.edu;
 helo=esa1.hc2706-39.iphmx.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Thank you

On 231004 1106, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/qtest/fuzz/fuzz.h | 4 ++--
>  softmmu/memory.c        | 2 +-
>  tests/qtest/fuzz/fuzz.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
> index 21d1362d65..7da0bc3d7e 100644
> --- a/tests/qtest/fuzz/fuzz.h
> +++ b/tests/qtest/fuzz/fuzz.h
> @@ -49,13 +49,13 @@ typedef struct FuzzTarget {
>  
>  
>      /*
> -     * Returns the arguments that are passed to qemu/softmmu init(). Freed by
> +     * Returns the arguments that are passed to qemu/system init(). Freed by
>       * the caller.
>       */
>      GString *(*get_init_cmdline)(struct FuzzTarget *);
>  
>      /*
> -     * will run once, prior to running qemu/softmmu init.
> +     * will run once, prior to running qemu/system init.
>       * eg: set up shared-memory for communication with the child-process
>       * Can be NULL
>       */
> diff --git a/softmmu/memory.c b/softmmu/memory.c
> index 234bd7b116..fa1c99f9ba 100644
> --- a/softmmu/memory.c
> +++ b/softmmu/memory.c
> @@ -3638,7 +3638,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
>  }
>  
>  /*
> - * Support softmmu builds with CONFIG_FUZZ using a weak symbol and a stub for
> + * Support system builds with CONFIG_FUZZ using a weak symbol and a stub for
>   * the fuzz_dma_read_cb callback
>   */
>  #ifdef CONFIG_FUZZ
> diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
> index 3bedb81b32..9b9c9f9c36 100644
> --- a/tests/qtest/fuzz/fuzz.c
> +++ b/tests/qtest/fuzz/fuzz.c
> @@ -207,7 +207,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
>          fuzz_target->pre_vm_init();
>      }
>  
> -    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
> +    /* Run QEMU's system main with the fuzz-target dependent arguments */
>      cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
>      g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
>                             getenv("QTEST_LOG") ? "" : "-qtest-log none");
> -- 
> 2.41.0
> 

