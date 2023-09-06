Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2E793474
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 06:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdkN1-0008B5-Iw; Wed, 06 Sep 2023 00:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdkMz-0008Ag-5N
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 00:42:25 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdkMv-0004UQ-Gk
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 00:42:24 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977e0fbd742so461607566b.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 21:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693975340; x=1694580140; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Oqwc24ccP+oBUY1vMLfScj/oed8totdGzIYgf16jGSY=;
 b=PCgzy/nINsZpIMtRzpy/S4rN/cTdxjyP28k5BeDQ6L9nJfmnx90anbDi09JoFil6Te
 epK3sl6wsNlhFT4zPM0ul9w3udefeCsJ8xaUskn3Te3+12D8VMk1Lv4D0JK/vdMiObxG
 EYHOftmrvC9DuarEp3p0jfO3K9sVH+yLuCtBIo3m+QK+HFH0lvdNawFEcUWwWAlmui+z
 6VOXjYSigZE6doVxydHqKv73PvYoN8fkNi5z7I7FSpvt0eqS1PaBSCxSio4PMkrHUQ6h
 euyChJhC4mDEBTrVP6gN0ICdkvz7uf9nxjwal2Rp04MyJcjl9Z9P6t3jPaDvps79aCNy
 yJPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693975340; x=1694580140;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Oqwc24ccP+oBUY1vMLfScj/oed8totdGzIYgf16jGSY=;
 b=f5I8kCWAd4vUsgZnCQfsjClZN879b+DUXC+AscYMgvuLr0wNF/4zkMizw3+VmhQZI8
 OlS3fpsPeQkjvbsO5DCiqB3deRABf9u17L7RWvvQtEEMgtAXV6+ZRXWpKtFuvmG6q6t8
 SitIOuO+kB6/6cf5a8EDtAUQU8dfnN1f5r2oJNL3qtvhyc23B52QV7IxlxwwNcl9RuZm
 SSQhycUhAxe5Nxwj4vHzaDa1VfizNp8p/lQQ5x6zLfRm2ZdVmDcMoVI0CUBg6Z8RrAn9
 M+97XcSHvcCNbzdxrKhiQG7HH3ctsBHGewCWbDDdUhFj/62OoPMdYuv12L7TOoYDUasK
 mP0w==
X-Gm-Message-State: AOJu0YwClFoQiZH2sbAZmVS4/oVqosGM9pZxqBC0ROIxEjvjuYz0xtxh
 Yv5bIyWgRIftt9HLh+963e+X/g==
X-Google-Smtp-Source: AGHT+IE7PkJqtrtHYbz8yYIlhkHT1jEYuIgVKIFLZwCMC5v1Y9Uc70SpcejSmSWZhviQ1rgwkgh6Mw==
X-Received: by 2002:a17:906:73ce:b0:9a1:edb0:2a8c with SMTP id
 n14-20020a17090673ce00b009a1edb02a8cmr1167473ejl.39.1693975339791; 
 Tue, 05 Sep 2023 21:42:19 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 g3-20020a170906594300b0099cf44adf2csm8327024ejr.46.2023.09.05.21.42.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 21:42:19 -0700 (PDT)
Message-ID: <c5937e59-e267-519a-cf57-bf051b07304f@linaro.org>
Date: Wed, 6 Sep 2023 06:42:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v3 4/4] migration/qapi: Drop @MigrationParameter enum
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
 <20230905162335.235619-5-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230905162335.235619-5-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 5/9/23 18:23, Peter Xu wrote:
> Drop the enum in qapi because it is never used in QMP APIs.  Instead making
> it an internal definition for QEMU so that we can decouple it from QAPI,
> and also we can deduplicate the QAPI documentations.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   qapi/migration.json            | 179 ---------------------------------
>   migration/options.h            |  47 +++++++++
>   migration/migration-hmp-cmds.c |   3 +-
>   migration/options.c            |  51 ++++++++++
>   4 files changed, 100 insertions(+), 180 deletions(-)


> diff --git a/migration/options.h b/migration/options.h
> index 124a5d450f..4591545c62 100644
> --- a/migration/options.h
> +++ b/migration/options.h
> @@ -66,6 +66,53 @@ bool migrate_cap_set(int cap, bool value, Error **errp);
>   
>   /* parameters */
>   
> +typedef enum {
> +    MIGRATION_PARAMETER_ANNOUNCE_INITIAL,
> +    MIGRATION_PARAMETER_ANNOUNCE_MAX,
> +    MIGRATION_PARAMETER_ANNOUNCE_ROUNDS,
> +    MIGRATION_PARAMETER_ANNOUNCE_STEP,
> +    MIGRATION_PARAMETER_COMPRESS_LEVEL,
> +    MIGRATION_PARAMETER_COMPRESS_THREADS,
> +    MIGRATION_PARAMETER_DECOMPRESS_THREADS,
> +    MIGRATION_PARAMETER_COMPRESS_WAIT_THREAD,
> +    MIGRATION_PARAMETER_THROTTLE_TRIGGER_THRESHOLD,
> +    MIGRATION_PARAMETER_CPU_THROTTLE_INITIAL,
> +    MIGRATION_PARAMETER_CPU_THROTTLE_INCREMENT,
> +    MIGRATION_PARAMETER_CPU_THROTTLE_TAILSLOW,
> +    MIGRATION_PARAMETER_TLS_CREDS,
> +    MIGRATION_PARAMETER_TLS_HOSTNAME,
> +    MIGRATION_PARAMETER_TLS_AUTHZ,
> +    MIGRATION_PARAMETER_MAX_BANDWIDTH,
> +    MIGRATION_PARAMETER_DOWNTIME_LIMIT,
> +    MIGRATION_PARAMETER_X_CHECKPOINT_DELAY,
> +    MIGRATION_PARAMETER_BLOCK_INCREMENTAL,
> +    MIGRATION_PARAMETER_MULTIFD_CHANNELS,
> +    MIGRATION_PARAMETER_XBZRLE_CACHE_SIZE,
> +    MIGRATION_PARAMETER_MAX_POSTCOPY_BANDWIDTH,
> +    MIGRATION_PARAMETER_MAX_CPU_THROTTLE,
> +    MIGRATION_PARAMETER_MULTIFD_COMPRESSION,
> +    MIGRATION_PARAMETER_MULTIFD_ZLIB_LEVEL,
> +    MIGRATION_PARAMETER_MULTIFD_ZSTD_LEVEL,
> +    MIGRATION_PARAMETER_BLOCK_BITMAP_MAPPING,
> +    MIGRATION_PARAMETER_X_VCPU_DIRTY_LIMIT_PERIOD,
> +    MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT,
> +    MIGRATION_PARAMETER__MAX,

MIGRATION_PARAMETER__MAX is not part of the enum, so:

    #define MIGRATION_PARAMETER__MAX \
        (MIGRATION_PARAMETER_VCPU_DIRTY_LIMIT + 1)

> +} MigrationParameter;
> +
> +extern const char *MigrationParameter_string[MIGRATION_PARAMETER__MAX];
> +#define  MigrationParameter_str(p)  MigrationParameter_string[p]

Hmm this is only used once by HMP. Following our style I suggest here:

  const char *const MigrationParameter_string(enum MigrationParameter 
param);

And in options.c:

  static const char *const 
MigrationParameter_str[MIGRATION_PARAMETER__MAX] = {
     ...
  };

  const char *const MigrationParameter_string(enum MigrationParameter param)
  {
      return MigrationParameter_str[param];
  }

> +
> +/**
> + * @MigrationParameter_from_str(): Parse string into a MigrationParameter
> + *
> + * @param: input string
> + * @errp: error message if failed to parse the string
> + *
> + * Returns MigrationParameter enum (>=0) if succeed, or negative otherwise
> + * which will always setup @errp.
> + */
> +int MigrationParameter_from_str(const char *param, Error **errp);
> +
>   const BitmapMigrationNodeAliasList *migrate_block_bitmap_mapping(void);
>   bool migrate_has_block_bitmap_mapping(void);

With the changes:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


