Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3677F754542
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 01:05:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKRpg-0006Ho-6j; Fri, 14 Jul 2023 19:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKRpe-0006HL-OO
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 19:04:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKRpd-0000pE-4J
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 19:04:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6687446eaccso2380692b3a.3
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 16:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689375851; x=1691967851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vp+G5IX/UsdWEFRF/AMlbsUgpxdncA0tb+pOKPOENXU=;
 b=eNn6SdDuZwltwQsIVb8Mt7483+8XjqPHEAkUUXjYxaY7cL0LN71W3HIhpaP4cBMuca
 HXk/purq58/M+EG3Hwi88+D9KYwXVJA3xi5ZRVjkKTDSIFcjt+K8jw73N547QCk67Imq
 2dUY+yNtiRXOVYQwjImJvGEECKmwPA1wJ8v7M0d7JG02O8Dj2MBuKEMWNEFkLLDwoj0Y
 NKTNu7Jd+6n7u2zr2TIMlpr7gw1Zo3yeqaMHR2KTLxtG3udy2estdjuq9JhWKcwm3OX9
 phkaSOZh62ewD6Woiwjx3azE8j5/Uxnz1BDzzUc1IfPDd2SBbzGqvVBrN4uUNxJls5/y
 iQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689375851; x=1691967851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp+G5IX/UsdWEFRF/AMlbsUgpxdncA0tb+pOKPOENXU=;
 b=V8Iq2WjKb6ckhk8ueCL8isS0ZBtl5iVUB+fFT/EYTf56hRnRzeOzMjz0p+68XhOmhX
 ygnhHZFO92J1LP3OsZL91drJ8vPstat0BlPA5XgvntmJJC73b6zhw5SNMFNdjCEO470s
 dX2gZsXVnTkXx2ePpE5n+oCSdXokrgjmTlnPgKye0Ug2FSTA3VfmCRUujVx3fT4IQhtS
 gY4mexYy5J5s3hGvrdxSKZD45rwqUvkDsxLeKLfL59C4Okbkzfiro3Tr+sB4+A+csNwx
 5MhQve3o8Bd2HHKQGzgAXp8+eyPLpkY4Fuuci4/Qpu9PmJ8eGKymXKDE+UVNPCN8b67c
 i0sQ==
X-Gm-Message-State: ABy/qLYP9BkhYJdbBr9hFRymSM1YFUtscss5BwBko438TvuwmsElARiT
 YECBAo7qhdCfIWz1CPVpl0TZww==
X-Google-Smtp-Source: APBJJlEchJk5CX9iMhSm3DF/H4hdcmFVJBKKRBplZvdXGUaH2cxAEo01oE9HSjmhOR8l5HwXTWGDcg==
X-Received: by 2002:a05:6a00:2406:b0:66f:912b:d6f with SMTP id
 z6-20020a056a00240600b0066f912b0d6fmr6966289pfh.0.1689375851257; 
 Fri, 14 Jul 2023 16:04:11 -0700 (PDT)
Received: from [192.168.88.227] ([172.58.30.129])
 by smtp.gmail.com with ESMTPSA id
 d9-20020a639909000000b0054f9936accesm8042188pge.55.2023.07.14.16.04.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jul 2023 16:04:10 -0700 (PDT)
Message-ID: <2163d89b-ca30-f111-6107-a37be0fb2d54@linaro.org>
Date: Sat, 15 Jul 2023 00:04:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/5] Patches for QEMU 8.1 hard freeze
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230714105953.223485-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230714105953.223485-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/14/23 11:59, Paolo Bonzini wrote:
> The following changes since commit 3dd9e54703e6ae4f9ab3767f5cecc99edf066668:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu  into staging (2023-07-12 20:46:10 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 2eb5599e8a73e70a9e86a97120818ff95a43a23a:
> 
>    scsi: clear unit attention only for REPORT LUNS commands (2023-07-14 11:10:58 +0200)
> 
> ----------------------------------------------------------------
> * SCSI unit attention fix
> * add PCIe devices to s390x emulator
> * IDE unplug fix for Xen

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


