Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AFEAA90A6
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 12:11:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsmt-0001OA-V6; Mon, 05 May 2025 06:11:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBsmc-0001Mp-PO
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:10:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBsma-0007Xq-MT
 for qemu-devel@nongnu.org; Mon, 05 May 2025 06:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746439843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2rbs7uE9AzW5Lz6299cFbziFS9WPgT/b3YpLtHriDIw=;
 b=YxNaTMiaO1TODyW60Deqed4cCIVRp2J5cHML5RyzfY6MuRlo/paFAfV/yAi1CqVtJ/CRBt
 3uo2qDv7xPfqK9cgDSZS17TaAi9+iOsv5D0fxxR70YjQwRFlJyl8yEeA2uyME3PQrKbB29
 IC1L651xZvyd+frVSrvGikaDchGK8Ak=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-X6BrCSimOxed-dHB89DSKQ-1; Mon, 05 May 2025 06:10:42 -0400
X-MC-Unique: X6BrCSimOxed-dHB89DSKQ-1
X-Mimecast-MFC-AGG-ID: X6BrCSimOxed-dHB89DSKQ_1746439841
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a08a1c0fc5so2205793f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 03:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746439841; x=1747044641;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2rbs7uE9AzW5Lz6299cFbziFS9WPgT/b3YpLtHriDIw=;
 b=vrHhQnQt6mhnQcQHJNc46aF0hPGIrlOY6lmNz3GKW+3kw54REJHrpQge3n+kdaMG1I
 R36M6HRxmkVchcJDlFdRStCj3jFpIDSPKwAftS4tY0/ThfuFb7eWq3uL0CuwYDmLDPYK
 sU1Bm2u1/7V6SdfGMHqi4Gyc/ahtrFh9898uNeAytCUSMUoFTR+rqSqHDnZBh9QYwjsq
 tZyS7ioUuRveTxnw6ZqgcTlrIE2grNgFLpsHga1TPyLbinuNVml8kjeVSBdpz/MtWIyT
 KhnurDldh7CEQ7P0pgelWEA9fQs3OWpgDaXZd5zADf8UZNFaDJJA+W6nLwD/T14jQUn+
 FZng==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2H5LYOwNurWhGuR3LOQVtnDY2LDmcKwqAgGLesjatTH7r79IwBVp/cteNNMpBM7S8N95mvvVTlihY@nongnu.org
X-Gm-Message-State: AOJu0Yzm5VsAjWSbpuEiclimp6IYcM4uovA68NpBoKPNeHkkonR656cd
 mFpwxZe8ivQ51zYFyTk+e2O93kpqtJKXurlREuaTvf94N24FkH6V2hVQ5JlgUdO6Jy8lKY8Fg28
 daPafTlvRIahmr6xQN/yw0l3hfP/8nUVqBjtno6FrtUuZ2ZDMVr94
X-Gm-Gg: ASbGnct46IaIqZXy7tW8kN/UEYStzi8APp7hAcq9B8J+iJIofIyiSqHk0OfukaDMV+e
 CaL2Q4uNi7+KHpUHh4M4CVFBQDz3l9aWtkaGpnNoxEptNc5pCrga8J8zP/MxxT4KGQaIYIOCW/e
 mk94rseODIvECxUz75CkeU8VjiCzouHez11oqR1kl4CV7ukOl6l6qLcIf3+SzA2nODJxAxFCuFD
 ve0wbsIBsIe18XHGGHtl5q5EU4lO9FluYL3FcysKhxcMqDKabn9zsmhOd3DOYffgpk+L3Bs7qjb
 0rSlL/EJE9StYfyYb4khXPs2TcXEf1eQVf6oEigi
X-Received: by 2002:a05:6000:290c:b0:39c:cc7:3db6 with SMTP id
 ffacd0b85a97d-3a09fd753b0mr4464787f8f.19.1746439841273; 
 Mon, 05 May 2025 03:10:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqMp8144TKwRQUvjzBAcpiE64upZdMtXFUOiZXlIH54mSRhiNKOGP+j4x1rCu3IbfvmiMTHA==
X-Received: by 2002:a05:6000:290c:b0:39c:cc7:3db6 with SMTP id
 ffacd0b85a97d-3a09fd753b0mr4464771f8f.19.1746439840931; 
 Mon, 05 May 2025 03:10:40 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae7b45sm9766225f8f.46.2025.05.05.03.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 03:10:40 -0700 (PDT)
Message-ID: <55970655-386d-4cac-a70b-1eca0fad8696@redhat.com>
Date: Mon, 5 May 2025 12:10:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/e1000: Remove stray empty comment in header
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org
References: <20250504215639.54860-4-gustavo.romero@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250504215639.54860-4-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 04/05/2025 23.56, Gustavo Romero wrote:
> In the header file, remove a stray empty comment in the Offload Context
> Descriptor struct.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   hw/net/e1000x_regs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/net/e1000x_regs.h b/hw/net/e1000x_regs.h
> index cd896fc0ca..e9a74de6f4 100644
> --- a/hw/net/e1000x_regs.h
> +++ b/hw/net/e1000x_regs.h
> @@ -900,7 +900,7 @@ struct e1000_context_desc {
>               uint16_t tucse;     /* TCP checksum end */
>           } tcp_fields;
>       } upper_setup;
> -    uint32_t cmd_and_length;    /* */
> +    uint32_t cmd_and_length;
>       union {
>           uint32_t data;
>           struct {

There is another one in hw/net/eepro100.c ...

Anyway,
Reviewed-by: Thomas Huth <thuth@redhat.com>


