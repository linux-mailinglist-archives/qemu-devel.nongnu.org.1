Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4487F73BBB1
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:33:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCimK-00074Z-5J; Fri, 23 Jun 2023 11:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCimI-00074P-Mq
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:32:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCimH-0003vX-7D
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:32:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3112d202363so837509f8f.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687534367; x=1690126367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wt8IUXNx2SEKkdIBG9YNVd50utkjtl8qtMQ1ymttCY=;
 b=tkmDpFIozbHyNMAH0mv/zX3iyhu7Pj65A+Ut0rsu24seJwPU92LLQeNET/bnnixVQm
 ASvkCuOO3X/tQ61PwF2kBvQDyyMKNNFVpbjqAPbjTBadCCUx//Gw73aK1LC4Aw4evQNr
 byBrwGtQ+rT1isQRCVtX9+qi0GNPPO8sooa5UZMojR9TDE+pN3c5pduc1vWX7e1vDQdm
 jEJiOB0xZgkBtXO0F5JmHWrBDSpwyWoCfIAS+6dTe7Jj7GNTqPrIoW+M/gRgzQUy8SEg
 D6EP4Wj3or8KpyqpT0Zr3YCayHRd4gxWto/rQqdY0Ni4P2pS/s8Obl7AhpxR+iyJTMkw
 Vnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687534367; x=1690126367;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wt8IUXNx2SEKkdIBG9YNVd50utkjtl8qtMQ1ymttCY=;
 b=XA8+Zxv1ztYZ6RGUOc5iltt3VxFyfaL7RldvF3gBbrwR0PNNK7zWaSikde6Me0g7l9
 PTwZW+T5LkfkUqNzM7dfAxeZrTTPT0mfQV0v0nu9uQXOHpB6koUS2uJ5yRfPrcaX+gWn
 CPBOcMCaFVe95hgsLjQQYRyG9YNXXtQ1bvPEVOz7UiFpJqoObli34XWGc1uUzfw8HWZz
 BkZTMFaqp4ABFYHG3vSctk2gcfhBH6xYcrpQwZPHZQBSr05R/IJZIAHOERmHYNBSuzZw
 dVVSSCJ2MR0/1Eb4evsu/hpOyD10sFkofleil91NkVBGpr0m1Ry+w5nHOyb236N/O6vr
 C6Mg==
X-Gm-Message-State: AC+VfDza80THlBgJqcZXaH7Yn6qXI3nlU61TXZIXbtJ5LtBnSQBAp2H1
 +7FpCEeYC1hy6YzImiINNxsy3A==
X-Google-Smtp-Source: ACHHUZ627jKdti6OlY8MIgR6M5bO1YzhIy9JhFzP1AkZaYN5uZu4uZjxegkq4cVCNmtp2uPCMuXFXQ==
X-Received: by 2002:a5d:43c2:0:b0:311:1cd8:b97a with SMTP id
 v2-20020a5d43c2000000b003111cd8b97amr4307734wrr.47.1687534367680; 
 Fri, 23 Jun 2023 08:32:47 -0700 (PDT)
Received: from [192.168.93.175] (94.red-88-29-173.dynamicip.rima-tde.net.
 [88.29.173.94]) by smtp.gmail.com with ESMTPSA id
 f17-20020a056000037100b00311334c7fabsm9946156wrf.16.2023.06.23.08.32.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 08:32:47 -0700 (PDT)
Message-ID: <1d254072-7929-8d04-4549-0bc7757ca707@linaro.org>
Date: Fri, 23 Jun 2023 17:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v4 3/3] softmmu/physmem: Fixup qemu_ram_block_from_host()
 documentation
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20230523185915.540373-1-david@redhat.com>
 <20230523185915.540373-4-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230523185915.540373-4-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 23/5/23 20:59, David Hildenbrand wrote:
> Let's fixup the documentation (e.g., removing traces of the ram_addr
> parameter that no longer exists) and move it to the header file while at
> it.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   include/exec/cpu-common.h | 15 +++++++++++++++
>   softmmu/physmem.c         | 17 -----------------
>   2 files changed, 15 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


