Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE9722DA5
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:28:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Dyr-0004RB-Pm; Mon, 05 Jun 2023 13:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Dyn-0004QH-K7
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:26:54 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Dym-000260-1E
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:26:53 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6563ccf5151so2334872b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685986008; x=1688578008;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uJWjucmDPTXfbMwe1SRcLRIuk2JWHcCbplyVpJ51KmY=;
 b=kna1XIYeRYxN5BAw9r2H+nGsRWPYaNfbo8YlUgDKKW5ckqEd/YZlhQnJt4EwBNv54j
 CChEsSJtOcL2viwmYooGcCPW3brpnUyiiwMItnPgrzkdg8mohllhI7UvxzAVicAr2Kvv
 ZGsPOMzgCjT42000YNxYXFMpkD1kIPmqzs0CWcP92YyWqldXpVlelEgDHz84o+HMFmB0
 ede25s4VKMHMwfC+wRc/nZg/q6qGyDbxs2gUhziw3whJxpiI19L22azzaacfPaNs9UHr
 zBqYfVYmlCAhmB779g2u41W0WncExRs//P8jf7T2xkVzhsCoiLtkz5A7JEqZuRZqLGhI
 xRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685986008; x=1688578008;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uJWjucmDPTXfbMwe1SRcLRIuk2JWHcCbplyVpJ51KmY=;
 b=ZWajqwgvnSU34m1w7aq8/KZRE+kZs9K34S5MHXo/1/nAUZ2UNPwRjk8pAtuPWX1sCw
 35K0hoaGuVN12e3fGFuX5Oq+n5QuMU9n+Yo2vvnEbh4DRYaeTDNtALf+3CmOa4ne+1Xp
 o2W1DkNyQHzF0H3EWsXF6ph6VZZSELBYkgsU8TmYm8CNVXKhg/zh+3FloGy32Zc/4CFp
 W9xXUylZN3Rm9PpuZ+ZsCpOpzpGAtt5HjOLwArLT7g5REIWVae01ntDIc2Qk7/JXzqKA
 PeI2oXIiNJMaNWuDw2fJ6DMEfe+H6xnWgT1ADkn8o7QzYzPN9esXmAeh7dm7nntWZpl3
 9bAA==
X-Gm-Message-State: AC+VfDwzojYRx1EwKLGm28yPvKeRfzWouR4rq4fTt2h6MW/ipLoVs3VY
 xmkd38fCVLx14QlU7mT6fJBnqA==
X-Google-Smtp-Source: ACHHUZ4Q/JSG5ZCobxYFUIMK8aognRgThDT6XJKa1od56/fVj35sYmGCu0CAG68EvO+ELk2oKFcgHQ==
X-Received: by 2002:a05:6a20:9388:b0:10d:d18b:95ce with SMTP id
 x8-20020a056a20938800b0010dd18b95cemr9854181pzh.22.1685986008563; 
 Mon, 05 Jun 2023 10:26:48 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 x41-20020a056a000be900b006468222af91sm5482292pfu.48.2023.06.05.10.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 10:26:48 -0700 (PDT)
Message-ID: <f3070fb9-e175-eadc-e4bd-c0395b593195@linaro.org>
Date: Mon, 5 Jun 2023 10:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/3] qemu-sparc queue 20230605
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/5/23 04:32, Mark Cave-Ayland wrote:
> The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:
> 
>    Merge tag 'migration-20230602-pull-request' ofhttps://gitlab.com/juan.quintela/qemu  into staging (2023-06-02 17:33:29 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/mcayland/qemu.git  tags/qemu-sparc-20230605
> 
> for you to fetch changes up to 36c9189890bfb936b1b086da639e37fd92b50215:
> 
>    hw/isa/i82378: Remove unused "io" attribute (2023-06-05 07:43:23 +0100)
> 
> ----------------------------------------------------------------
> qemu-sparc queue
> 
> Hi Richard,
> 
> This is one of Bernhard's cleanup series where all patches have been
> reviewed/acked. Please apply.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

