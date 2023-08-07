Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A83772D9D
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 20:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT4ny-0005Cv-Vy; Mon, 07 Aug 2023 14:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT4nm-0005Bh-Jx
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:17:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT4nk-00027R-VH
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:17:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bbf8cb694aso41538705ad.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691432275; x=1692037075;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GoVVMuPgL0FlWms/s3UjiL6a16iL25KjRwXThS0TcQY=;
 b=Y2TjtBAOyWQe0/s4Mo8h7BfykDShcRVQN3jVZz3gTRfcbb012PqP0uLGA4ThhyaJl8
 UEhJFTgUnsM95Wn16MvpKzppwkbt6mLd+anEQRIY7RN4BRkqexj1P+56hfjjDkKHlZrC
 CW1yeG+wd+fW3DvEkyebYVtn67VyOHOuBnNFABtoRJr0UrPDd+YyXsy4w/8rTBaC5tAo
 E+pgY+0I2QXOevQru+JFgEeb70kLYGfMefA8C313lsFrpcAvxbfeBY97iIiRI4gCxrHH
 XwO52FPM5mcTeUhWNmySkDPncllPOs/hNDv+1YWlz4jN9E5W2C+Rn4zN49zPKqzwUOOk
 0ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691432275; x=1692037075;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GoVVMuPgL0FlWms/s3UjiL6a16iL25KjRwXThS0TcQY=;
 b=PQCjlLt9jbIYt/XOlPvZcv6JFvPjwpTjauL3gF5/5lBrsTbvOknDdptwtp66YUQggf
 Ly8EocF9LDxMNADrG02EP08bxkY/FzDcv0juorTsU0yNCKTSozHXcdYi1XS6uNe34SUt
 NTvSH8lPO/cwjcMPTd1uD+vsz/KDiBkh/1a6AoKKOsdRiB7VO5YZ0j4wt/8y+vevOMlq
 PSjo7kCa2sJmC2PbTMbSBariskztT7f9bqwzLi3+7j4KQ1++Vt64tqKFiyT3BFcJaOo3
 f7obyBzcP5JuQ4VAn58X/FKRLGh1FysOYRMkwsBqwh8jamNO/5iIOr50It1Lfd/WPy7J
 vsOA==
X-Gm-Message-State: AOJu0YyRM7SOEI5we/MWH1sWLfBUCh0l/XVSfn3rqjPFl3yNR0D01vdH
 FpQ5ah9D1VKGCETs3hhTdTvEF4Iw4Oh/ygiqRKE=
X-Google-Smtp-Source: AGHT+IHMIj46khAr4BmYaVw+SJI4fPORBNThkFRBsf7+o6ZU7uFGXcCE3k9KY0EKhteadzbD/kKm6g==
X-Received: by 2002:a17:902:6b47:b0:1b8:76ce:9d91 with SMTP id
 g7-20020a1709026b4700b001b876ce9d91mr9158118plt.1.1691432275215; 
 Mon, 07 Aug 2023 11:17:55 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a170902e81000b001ab2b4105ddsm7215822plg.60.2023.08.07.11.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 11:17:54 -0700 (PDT)
Message-ID: <d2842004-ce3e-325f-69a7-3eec6e4cd1d5@linaro.org>
Date: Mon, 7 Aug 2023 11:17:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH for-8.1 v10 10/14] util/selfmap: Rewrite using
 qemu/interval-tree.h
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, 
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-11-richard.henderson@linaro.org>
In-Reply-To: <20230807163705.9848-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
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

On 8/7/23 09:37, Richard Henderson wrote:
> We will want to be able to search the set of mappings.
> For this patch, the two users iterate the tree in order.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/selfmap.h |  20 ++++----
>   linux-user/elfload.c   |  14 +++--
>   linux-user/syscall.c   |  15 +++---
>   util/selfmap.c         | 114 +++++++++++++++++++++++++----------------
>   4 files changed, 96 insertions(+), 67 deletions(-)

I should note that, for 8.2, this will enable a rewrite of open_self_maps_1 so that it 
does not require page-by-page checking of page_get_flags.

My idea is that open_self_maps_1 would use walk_memory_regions to see all guest memory 
regions.  The per-region callback would cross-check with the host-region interval tree to 
find the dev+inode+path.

Cc Ilya and Helge, since there are two outstanding changes to open_self_maps.


r~

