Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC680CA7C
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:06:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCfz1-0006YV-2C; Mon, 11 Dec 2023 08:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCfyo-0006U7-Q9
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:05:52 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1rCfym-0005Wf-S0
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:05:50 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ce32821a53so2343863b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702299946; x=1702904746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KyfnJnZMAUYH1TAl/u+BMIXqStDIALqJoTk2JnRmWBU=;
 b=GCVREMgj08sz0JuGb6WStAVnwwIdz+iz8zDHzRe2HDsZzZIGiGaY35voF1SeBQgX52
 cBcDC2cUjCNAz6b4yiTAViEE6N0q4EyzcO6NfkAGi9xOyYg8XpWDzo0i2AzF7eD5z1RO
 UAL3D+yLm73tDxawjRNPaPz4oaM0xr8er7yFbKpjkvnyYjaYslQ8lUpDsn913c+l9tu5
 R8FnX3GRewDNcU5sUtW/K4pM+t+BUDxh64n+8+4OvU8H7tNCxX1835JfHAgXyJiXUGL6
 P1koznbqWGS0wcB7eOB88oGT+KcHUa9Nu6Gjr3TUFj1oUt2J/P05T6y8pNzW+4tzgN8F
 wgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702299946; x=1702904746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KyfnJnZMAUYH1TAl/u+BMIXqStDIALqJoTk2JnRmWBU=;
 b=cCRUzVJHjzirhIVXHVC30WmrANVQQ47wNOIATMmP8mqpw2fhnbh87vRZCwCJW1tTl3
 iTdsbshm6mfJP/Pj5sl9tUTBRjV3ME9n2WyeOd1thzPNQuA3lsKQEKVY7wCpb5zkJwQi
 H5tNESJ6iF8/uinXL6FihPHwIlZiK7OItHzarPLP130qomxX3Yc85WXau4MoPtNmBR06
 nJAqkqbBkTxdl3M9yonsMuHW5nlkrXdzT4OG6HE14Jjon5Qx2ObybxM6hJt/6sURb28L
 7JMx6NsV3ilxI9D93uxHd53M3w+jvksDMHuqVd+NpsztXTuzdUELnF3vFzDYvw+WapIz
 i2gQ==
X-Gm-Message-State: AOJu0YwcSHfhEKKGBUC3x4cU/9Dyqb3DR/Ja7hh3VpeQru10QiVNGvSz
 yiSkNLuhil/vc+97BclBUEc=
X-Google-Smtp-Source: AGHT+IGqEELxA6/iRK8AufoBGk/+CTPC7OK4fyXHO9IKD6wbnvvmsnwtQrhewH/+FEy6MrWwbGTKCA==
X-Received: by 2002:a05:6a20:6a1f:b0:190:a85:c041 with SMTP id
 p31-20020a056a206a1f00b001900a85c041mr2074793pzk.61.1702299945966; 
 Mon, 11 Dec 2023 05:05:45 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t20-20020aa79394000000b006ce7e1c37dasm6130358pfe.80.2023.12.11.05.05.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:05:45 -0800 (PST)
Message-ID: <46697e3b-3ec4-4635-97d5-39919068d709@gmail.com>
Date: Mon, 11 Dec 2023 22:05:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] ebpf: Added eBPF map update through mmap.
Content-Language: en-US
To: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: yuri.benditovich@daynix.com, yan@daynix.com
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-2-andrew@daynix.com>
From: Akihiko Odaki <akihiko.odaki@gmail.com>
In-Reply-To: <20230831065140.496485-2-andrew@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On 2023/08/31 15:51, Andrew Melnychenko wrote:
> Changed eBPF map updates through mmaped array.
> Mmaped arrays provide direct access to map data.
> It should omit using bpf_map_update_elem() call,
> which may require capabilities that are not present.
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   ebpf/ebpf_rss.c | 117 ++++++++++++++++++++++++++++++++++++++----------
>   ebpf/ebpf_rss.h |   5 +++
>   2 files changed, 99 insertions(+), 23 deletions(-)
> 
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index cee658c158..247f5eee1b 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -27,19 +27,83 @@ void ebpf_rss_init(struct EBPFRSSContext *ctx)
>   {
>       if (ctx != NULL) {
>           ctx->obj = NULL;
> +        ctx->program_fd = -1;
> +        ctx->map_configuration = -1;
> +        ctx->map_toeplitz_key = -1;
> +        ctx->map_indirections_table = -1;
> +
> +        ctx->mmap_configuration = NULL;
> +        ctx->mmap_toeplitz_key = NULL;
> +        ctx->mmap_indirections_table = NULL;
>       }
>   }
>   
>   bool ebpf_rss_is_loaded(struct EBPFRSSContext *ctx)
>   {
> -    return ctx != NULL && ctx->obj != NULL;
> +    return ctx != NULL && (ctx->obj != NULL || ctx->program_fd != -1);
> +}
> +
> +static bool ebpf_rss_mmap(struct EBPFRSSContext *ctx)
> +{
> +    if (!ebpf_rss_is_loaded(ctx)) {
> +        return false;
> +    }
> +
> +    ctx->mmap_configuration = mmap(NULL, qemu_real_host_page_size(),
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                   ctx->map_configuration, 0);
> +    if (ctx->mmap_configuration == MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF configuration array");
> +        return false;
> +    }
> +    ctx->mmap_toeplitz_key = mmap(NULL, qemu_real_host_page_size(),
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                   ctx->map_toeplitz_key, 0);
> +    if (ctx->mmap_toeplitz_key == MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF toeplitz key");
> +        goto toeplitz_fail;
> +    }
> +    ctx->mmap_indirections_table = mmap(NULL, qemu_real_host_page_size(),
> +                                   PROT_READ | PROT_WRITE, MAP_SHARED,
> +                                   ctx->map_indirections_table, 0);
> +    if (ctx->mmap_indirections_table == MAP_FAILED) {
> +        trace_ebpf_error("eBPF RSS", "can not mmap eBPF indirection table");
> +        goto indirection_fail;
> +    }
> +
> +    return true;
> +
> +indirection_fail:
> +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> +toeplitz_fail:
> +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> +
> +    ctx->mmap_configuration = NULL;
> +    ctx->mmap_toeplitz_key = NULL;
> +    ctx->mmap_indirections_table = NULL;

What about:

 > +indirection_fail:
 > +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
 > +    ctx->mmap_toeplitz_key = NULL;
 > +toeplitz_fail:
 > +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
 > +    ctx->mmap_configuration = NULL;

It will be clearer when the pointer becomes invalid this way.

> +    return false;
> +}
> +
> +static void ebpf_rss_munmap(struct EBPFRSSContext *ctx)
> +{
> +    if (!ebpf_rss_is_loaded(ctx)) {
> +        return;
> +    }
> +
> +    munmap(ctx->mmap_indirections_table, qemu_real_host_page_size());
> +    munmap(ctx->mmap_toeplitz_key, qemu_real_host_page_size());
> +    munmap(ctx->mmap_configuration, qemu_real_host_page_size());
> +
> +    ctx->mmap_configuration = NULL;
> +    ctx->mmap_toeplitz_key = NULL;
> +    ctx->mmap_indirections_table = NULL;
>   }
>   
>   bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>   {
>       struct rss_bpf *rss_bpf_ctx;
>   
> -    if (ctx == NULL) {
> +    if (ctx == NULL || ebpf_rss_is_loaded(ctx)) {
>           return false;
>       }

You can omit ctx == NULL just as you do for ebpf_rss_munmap().

>   
> @@ -66,10 +130,18 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>       ctx->map_toeplitz_key = bpf_map__fd(
>               rss_bpf_ctx->maps.tap_rss_map_toeplitz_key);
>   
> +    if (!ebpf_rss_mmap(ctx)) {
> +        goto error;
> +    }
> +
>       return true;
>   error:
>       rss_bpf__destroy(rss_bpf_ctx);
>       ctx->obj = NULL;
> +    ctx->program_fd = -1;
> +    ctx->map_configuration = -1;
> +    ctx->map_toeplitz_key = -1;
> +    ctx->map_indirections_table = -1;
>   
>       return false;
>   }
> @@ -77,15 +149,11 @@ error:
>   static bool ebpf_rss_set_config(struct EBPFRSSContext *ctx,
>                                   struct EBPFRSSConfig *config)
>   {
> -    uint32_t map_key = 0;
> -
>       if (!ebpf_rss_is_loaded(ctx)) {
>           return false;
>       }
> -    if (bpf_map_update_elem(ctx->map_configuration,
> -                            &map_key, config, 0) < 0) {
> -        return false;
> -    }
> +
> +    memcpy(ctx->mmap_configuration, config, sizeof(*config));
>       return true;
>   }
>   
> @@ -93,27 +161,19 @@ static bool ebpf_rss_set_indirections_table(struct EBPFRSSContext *ctx,
>                                               uint16_t *indirections_table,
>                                               size_t len)
>   {
> -    uint32_t i = 0;
> -
>       if (!ebpf_rss_is_loaded(ctx) || indirections_table == NULL ||
>          len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
>           return false;
>       }
>   
> -    for (; i < len; ++i) {
> -        if (bpf_map_update_elem(ctx->map_indirections_table, &i,
> -                                indirections_table + i, 0) < 0) {
> -            return false;
> -        }
> -    }
> +    memcpy(ctx->mmap_indirections_table, indirections_table,
> +            sizeof(*indirections_table) * len);

This line is not aligned with the parenthesis on the previous line.

