Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5770E48D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 20:23:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Wex-0002c5-P5; Tue, 23 May 2023 14:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Wev-0002W1-Qx
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:22:57 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1Weu-00031U-9O
 for qemu-devel@nongnu.org; Tue, 23 May 2023 14:22:57 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-53202149ae2so5324177a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684866174; x=1687458174;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ReuRMDWfkusmzpmqhmh61egEzQtaznz6WpdIV+WgyrQ=;
 b=iZzkR2gotaZIC4fm4CkvsIaHixJQJi4zrFq69RFPpqwYVrhEuoNR7WU1EOflLMENyx
 N4rkGjQiOCU659a7LlNTSuUS5O14aRdecXhbC777vSXADjQlrlhVtWxFP028tSE+446x
 qymqc5MExFClxYqVdu8H6wqepNqfIVd0kPapB4hh7UIN6MXIOphVdDKwfjdtF3bNTowT
 +IJUX7cgaxPzl+49uAV9VzTdGeptwXS/IcdMrJhAHGKSQ9Fd4L5Z9gvEq2zWrW4+lIoc
 yTMSfMecTqvCbrB8dcuTe7aw2qIajay8/EJhDDRCYPxmO37+1gu/07lxIAPN9km/2sfa
 BQkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684866175; x=1687458175;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReuRMDWfkusmzpmqhmh61egEzQtaznz6WpdIV+WgyrQ=;
 b=NsS5Wh1B/JjVdvE1kfLHoOJM3aJ3t3k+P4LmfgThBW/44vNvtMf+e87YFh+HOEs+BY
 pA0Tfk9sVJAVcqzybLEGivma5S8UVpODZc0K7osCcf6OvuvyY03PTEEUykhvZLSTue0z
 FHlcRYMHVohxtaMDE5d2D6MRALVQ48EE0qWNlK2gABX3X18qu4KYuiIoqBNSr1caGYvK
 byIJQFM2gUMT97IJXIGiZZ2yoHthk9HQkW1dq3TZqhWfnYwAm8kAQ/rbiM+Lzub12ish
 zSYHSyrfgSJCmHGWZn6aOemWtdfpZTL4pWe9Zdy79jEpqecoHn1RLx4EJGsxJlBwlipN
 JYJQ==
X-Gm-Message-State: AC+VfDw0CKllijIOJwyHQBT5Kkm7T1bNyeDZ2nXXBcekzkal+ICJCgwF
 Cvna9B/C+32W4BYosY710Thwgp+iU3rRSxs+PdA=
X-Google-Smtp-Source: ACHHUZ5bPmghIR1k/Tj7e6E2t1CAMC10j1iFgksIbq+j1VGk9DBtGzgEprcGOqk0JHTHqtJQKTcJeA==
X-Received: by 2002:a17:902:e785:b0:1ad:dac0:5125 with SMTP id
 cp5-20020a170902e78500b001addac05125mr11743504plb.11.1684866174673; 
 Tue, 23 May 2023 11:22:54 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a170902ce8a00b001a64011899asm7101642plg.25.2023.05.23.11.22.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 11:22:54 -0700 (PDT)
Message-ID: <abedf5b1-cfcb-7abd-7355-bfc62107eccd@linaro.org>
Date: Tue, 23 May 2023 11:22:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] hw/i386/microvm: Simplify using object_dynamic_cast()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, qemu-trivial@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20230523061207.48818-1-philmd@linaro.org>
 <20230523061207.48818-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523061207.48818-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/22/23 23:12, Philippe Mathieu-Daudé wrote:
> Use object_dynamic_cast() to determine if 'dev' is a TYPE_VIRTIO_MMIO.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/i386/microvm.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

