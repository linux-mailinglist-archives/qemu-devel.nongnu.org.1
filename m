Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E380CA83
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 14:07:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCg0a-0007q0-8x; Mon, 11 Dec 2023 08:07:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCg0Y-0007pJ-G7
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:07:38 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rCg0W-0005lB-P1
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 08:07:38 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-28865456abbso3093873a91.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 05:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702300055; x=1702904855;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TJO2a5gVr789qDoQZD9ho2farFuEs8Oy+mHOdO5jtP8=;
 b=ofCruyglrYtkn5Oq5ogi68QlIqyv3CjHurYpq2qhiSBx27AqcTbn38zy7Gf1pkhT+Z
 2dzQ6PIvGovxNBeyboCSKUtYsV3o1necP5UusyuvAPbfOEyLS51p1Gy4Ufe/mrAq+Uqd
 KWIMuHkZkcDlC9jAf7iFBM8k20PY9Wb5T8A1rtao9peg+SFhxCDFaCkD1XSi+QwMAUeT
 pwEvFmfZOpH1uaJupahQQ8JiCkF5ZbjlL6p/KTE5m91aBmIOFd4tCS49nGXClYIMXh7C
 5ixe3/zOCqR93fDBcdEpcEo5jAEXTcDhA1JwntWK6nDScp7ZgBa2YWks2rg9Rziz7FOj
 wJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702300055; x=1702904855;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJO2a5gVr789qDoQZD9ho2farFuEs8Oy+mHOdO5jtP8=;
 b=uv4TGHr1X2gMVCTmfInn70xPqLKMKCmECRq/LRsrmrCrHDC+skI48wflgO9gzkS4OR
 RxQx9BqLIRiHGxYGp3sXLVoXtPucFytFeguF0xDZLYD7EX1SFZ9WRqas8rATYgDPb2Vm
 AS4W34Nb/7GKBP5nGd9N8sWqjDIw5ekTUOTo6zTpIGqsD1nRbhInhX9lab8AVjRAOBR5
 2kqeUmxfupZ8qjBTrkkg3aiXctMNSCRv5TADPIPy8ij7DPGKhLtEDI4smTrRaF3Eyd2M
 Bt4UkHbxmtVeaeB8FNS7/aRrRbIWbwJ5Sl4rsGiyRlvvsQXrZR9PoEz9eQzhaqeCQlkp
 mo5w==
X-Gm-Message-State: AOJu0Yx7rE73shPIHSQrW8FhP2dfRqFdf92kZl1KsrM/qyKVpM3CqA0m
 3p6jED9cvNt/hLARPOTCJBDV/bcmSsPhrscGfkPKdQ==
X-Google-Smtp-Source: AGHT+IF25OM/Gpnl886SFjsmgNEqFXXDtvgD4TOZNZP9DJ0oRSuMp22CFNVQr22wC9LK0jqgeW04ng==
X-Received: by 2002:a17:90a:ad05:b0:286:6cc1:866f with SMTP id
 r5-20020a17090aad0500b002866cc1866fmr1879178pjq.84.1702300055039; 
 Mon, 11 Dec 2023 05:07:35 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 6-20020a17090a018600b00285621515e9sm7602540pjc.15.2023.12.11.05.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 05:07:34 -0800 (PST)
Message-ID: <5887d6ce-e985-4b7f-a4a0-3fd3e6840d2f@daynix.com>
Date: Mon, 11 Dec 2023 22:07:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] ebpf: Added eBPF initialization by fds.
Content-Language: en-US
To: Andrew Melnychenko <andrew@daynix.com>, jasowang@redhat.com,
 mst@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org,
 berrange@redhat.com
Cc: yuri.benditovich@daynix.com, yan@daynix.com
References: <20230831065140.496485-1-andrew@daynix.com>
 <20230831065140.496485-3-andrew@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230831065140.496485-3-andrew@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
> It allows using file descriptors of eBPF provided
> outside of QEMU.
> QEMU may be run without capabilities for eBPF and run
> RSS program provided by management tool(g.e. libvirt).
> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>   ebpf/ebpf_rss-stub.c |  6 ++++++
>   ebpf/ebpf_rss.c      | 27 +++++++++++++++++++++++++++
>   ebpf/ebpf_rss.h      |  5 +++++
>   3 files changed, 38 insertions(+)
> 
> diff --git a/ebpf/ebpf_rss-stub.c b/ebpf/ebpf_rss-stub.c
> index e71e229190..8d7fae2ad9 100644
> --- a/ebpf/ebpf_rss-stub.c
> +++ b/ebpf/ebpf_rss-stub.c
> @@ -28,6 +28,12 @@ bool ebpf_rss_load(struct EBPFRSSContext *ctx)
>       return false;
>   }
>   
> +bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
> +                       int config_fd, int toeplitz_fd, int table_fd)
> +{
> +    return false;
> +}
> +
>   bool ebpf_rss_set_all(struct EBPFRSSContext *ctx, struct EBPFRSSConfig *config,
>                         uint16_t *indirections_table, uint8_t *toeplitz_key)
>   {
> diff --git a/ebpf/ebpf_rss.c b/ebpf/ebpf_rss.c
> index 247f5eee1b..24bc6cc409 100644
> --- a/ebpf/ebpf_rss.c
> +++ b/ebpf/ebpf_rss.c
> @@ -146,6 +146,33 @@ error:
>       return false;
>   }
>   
> +bool ebpf_rss_load_fds(struct EBPFRSSContext *ctx, int program_fd,
> +                       int config_fd, int toeplitz_fd, int table_fd)
> +{
> +    if (ctx == NULL || ebpf_rss_is_loaded(ctx)) {

You can omit ctx == NULL here too.

