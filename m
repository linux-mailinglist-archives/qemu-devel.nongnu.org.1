Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DF378CB66
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:37:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2dy-00034g-CK; Tue, 29 Aug 2023 13:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2di-00031v-25
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:36:31 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb2df-0003xr-LD
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:36:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1c0bae4da38so421715ad.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693330585; x=1693935385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d9rQR8TVfv5BPut7+v92pkKqlx8IauvJo5L6h5R7qTg=;
 b=z6oBW/xj+7cp0/NZbVoc1l/88fZx8CjxEtMJ39G/E7evCzlF+z5U1FA8AaFo24gj/U
 9I5C3GaqaiDbL9AcuxL6KznqNXcZW9dLL/qocjbmfBet/ew4IbRe4Gkuu0c0Pyxupxph
 l7/lMS0Z0VYjn/f2sHPJutRZlyxQSLiMOkS8WzDucIT3L7+AreBcmFcZ4jFuEz/+TZZ7
 QzzSsovADxm3ukfYr7FQdIC9jnzISuVLOrJ8EHzIXgBxkYFKRAknW4MJOyHcAagrjFac
 BQvYy6C5M9xq8pzRnqwPqZIePiMyMzvsoranbXVETjZyCrjyrZ9bU1DBVK89edAWK73r
 pV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693330585; x=1693935385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d9rQR8TVfv5BPut7+v92pkKqlx8IauvJo5L6h5R7qTg=;
 b=ZVBCOkVEbgH4KsowTur/LXINToOAvZFNLidUkrjgkoHdKBIajMOM5NeMOjBVPrXgvN
 2dsEacpG2v62H3B6jqRf1kuTf1Ks0ipQECDcUBLXowspKe7BnlUn0LFYpJqPb5W2n8eq
 bzAzfABnSpapQZVEXDLnjvIGZlEzdSrxlTe3h++yDTcYBAB2LU/wIc6zsaA2FsK99nDW
 hUZE17NAWU8gn1fJapdwd6tuIrWmJsejMe+Wb74FCl9qnNS43zdmfL4J0JfwlRyEqFls
 MTO4EHOHsrD8kupu51iR8mhpSeiBSdV1zqcSa5INp7cLGG9/YE5VHELLFxLKjUTZlHpG
 bLzA==
X-Gm-Message-State: AOJu0YzW8faz/DpxnhcZiRS9VnM/AJ4dGZRHn6a88gs7rfDgPwaox4YB
 H7MAsq/hrIzqek6dMGMyVcrvzzPlkiiTR348udk=
X-Google-Smtp-Source: AGHT+IHc4S7hHuoJycFp4VmSfILzI227CzMrRKOOeK69SOMgQtr52YwtgtyR92432wRkjFsd5Lv3UA==
X-Received: by 2002:a17:902:ec8e:b0:1bf:f70:a8a6 with SMTP id
 x14-20020a170902ec8e00b001bf0f70a8a6mr4241294plg.30.1693330585515; 
 Tue, 29 Aug 2023 10:36:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a1709029f8800b001b8b2a6c4a4sm9611934plq.172.2023.08.29.10.36.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 10:36:25 -0700 (PDT)
Message-ID: <ec3067fc-f654-4e63-b99a-5b22a765ba87@linaro.org>
Date: Tue, 29 Aug 2023 10:36:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] target/i386: fix memory operand size for CVTPS2PD
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230829165304.114948-1-pbonzini@redhat.com>
 <20230829165304.114948-3-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230829165304.114948-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 09:53, Paolo Bonzini wrote:
> CVTPS2PD only loads a half-register for memory, unlike the other
> operations under 0x0F 0x5A.  "Unpack" the group into separate
> emission functions instead of using gen_unary_fp_sse.
> 
> Cc:qemu-stable@nongnu.org
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/1377
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 14 ++++++++++++--
>   target/i386/tcg/emit.c.inc       | 30 +++++++++++++++++++++++++-----
>   2 files changed, 37

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

