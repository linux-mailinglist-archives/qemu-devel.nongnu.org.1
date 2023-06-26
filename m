Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7973D9F1
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:38:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhjk-0000XP-Iv; Mon, 26 Jun 2023 04:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhja-0000Wv-BW
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:38:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDhjU-0006aL-84
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:38:03 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313df030ccaso2592918f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687768678; x=1690360678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6Xq8YdmsRT+TYXM68KwwuCP9fDryuTb/8QHBalT+9A=;
 b=aJZKRctIwf+fwqtPIixhn+/QbFmhrtDnDxZEkNGu4GoP7UqcHslW8ytLBLfUtu8mOH
 NaWzKRcyHUg+HMJa4veXGwI8XmozCnIYdQZieYlDPMTwMSDHLc2QTVNj+D06e3vAgXH5
 yMi5QNrj5bzdeh6+D3qFexEP/y+ok2jPCsnL0HECaM+2UAguyXYC27ELfHB3xPQd00WS
 HlNv0VlbUPh5l0MbS7nOWpEL7/1KAiA/MbSYXGN6VZVbmphDxbYbedgxvOJ2v7RpTYg9
 MFotcK8kvXkxdfvA2yK2baYIIJnSyH4pOckpueGlrenlkiCiBmsODhmykW18On36P22c
 Cmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768678; x=1690360678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6Xq8YdmsRT+TYXM68KwwuCP9fDryuTb/8QHBalT+9A=;
 b=QzPi34axnINTYSIYkC1EdQH6vzCNOQHaf9Lgybz4WxkrAuI3aHXQO2SVMz/UbJBXvk
 KzkWg2q5BbUuZEm0KZKBDgt++/WQfURCZv4gWC0xzYo0WP9f8h9HzqB4Z8ytck7rXX1X
 /Zjv7iyRn9nFU3A9U8xFhOvrpGxGoyPK2MdI5RFUi0+Kw7uC5uT+myRJalP5ad/QyNzL
 V0g6FU8B5Lf7iqPwXBuUz9iwXPfW3w8gufOwmdRV5PqCY9O4tWRoiOFqmiR7vXsuKmio
 Y6A6apFU+TH/za5eNg6gDENwHpKvTmWlSfaCNLHKLdLZII8Xl0RkF/yMszX5kf9aK7EF
 QcRQ==
X-Gm-Message-State: AC+VfDwrgu0kRf7hMy/nVMCZ+SkBElnW0t+Rq61Xt7l6hJsf8Qy6o5s2
 PqgSDJrB9Sy7qCqIduG8atMts2RNLO+FijxH/jal6G7e
X-Google-Smtp-Source: ACHHUZ64zJ9q49L/IAtKVdTsAXpk4CxuQaCO7gBXuXtaqeaUjJVL9oLfT6QoEbfchmRHCZ8Tm17SLw==
X-Received: by 2002:a5d:6106:0:b0:313:ec5d:95b5 with SMTP id
 v6-20020a5d6106000000b00313ec5d95b5mr3100226wrt.60.1687768678204; 
 Mon, 26 Jun 2023 01:37:58 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a056000054300b002c70ce264bfsm6700158wrf.76.2023.06.26.01.37.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 01:37:57 -0700 (PDT)
Message-ID: <4e8c6fa7-90e1-de33-17f6-63b2fd08181a@linaro.org>
Date: Mon, 26 Jun 2023 10:37:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/30] ppc queue
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230626055647.1147743-1-clg@kaod.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230626055647.1147743-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/26/23 07:56, Cédric Le Goater wrote:
> The following changes since commit 79dbd910c9ea6ca38f8e1b2616b1e5e885b85bd3:
> 
>    Merge tag 'hppa-boot-reboot-fixes-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2023-06-25 08:58:49 +0200)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-ppc-20230626
> 
> for you to fetch changes up to 5eb63b88d0ac259c2f49e62b6dcc6527a5caf255:
> 
>    tests/avocado: ppc test VOF bios Linux boot (2023-06-25 22:41:31 +0200)
> 
> ----------------------------------------------------------------
> ppc queue:
> 
> * New maintainers
> * Nested implementation cleanups
> * Various cleanups of the CPU implementation
> * SMT support for pseries
> * Improvements of the XIVE2 TIMA modeling
> * Extra avocado tests for pseries

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


