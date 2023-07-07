Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0BC74B701
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 21:22:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHr0g-0001jB-Ik; Fri, 07 Jul 2023 15:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHr0e-0001ik-AY
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:20:52 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHr0c-0006wv-Jp
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:20:52 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so2333899f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688757649; x=1691349649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6D99qbsKWAQ4j1jtCMFGW5LgO9TnT0JWPkY4Ys3hzKY=;
 b=DGe9MtaGC1dvB1iScwil3ZFAcHxpPGTQJzCxRsXgm48SDFz66kl58BEs3rRkV3kQ3p
 5V4QilCFvLgKV7rnOHLJ+1Y+NNBHqvtg3kumJm56eeAGiJF/DjU7CigbIJcLHe9KfrlH
 tV6aTptvmEGC5Y3y7nymaAWqIUkN5eA58FOFPIGXusF1klv/cKj4OxUFfkQxl198E15B
 k9x2dbodZZ7qsmTt7j6dBfOxXIb9vAkT932KeGWq22eCZVv8j8IFAXg9wRF6o328gym5
 DaR1kS4m5giRUMG6KV+F5cIZUqkN9mNMVlms6W+QaJbMHwBCgX9zJs/jmNqdanhuffex
 hSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688757649; x=1691349649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6D99qbsKWAQ4j1jtCMFGW5LgO9TnT0JWPkY4Ys3hzKY=;
 b=JFEgMm3amixpVnOH/fFxFuuxHPxYjTBfScP31lQU7RTcJGBtwGT3fHLEj3A2u+E5mG
 IL4ePXkQ7mGDdNwoj407eQqhep+/OQIrfOHV3PGzwOvNXqMBhQfVNy6eE8jOlVh97Bhg
 CLbuOV+iI2FMLSHNhE5taSzZmbtADWnTIfgWa5p7J7j56IMwLBctFb6XodfNZEe2DWfe
 SkblBQC+5/+RUTFnbBrEpkCLEjfMrTVajEZK3AgeUqQC01dxAWxi/9wdvyFWs7035FZW
 29oBfMNHapSwcQ35bM3fJZd+qXe3X0Yn2TtkxFs0+A7An778xvFCceGbMSbD/2Ti0Qxo
 i0XQ==
X-Gm-Message-State: ABy/qLaCWvNrICh+s9BdDS1CzKT+co2Ae0xFHcgaZu8zAcjKt2lu0hPR
 T2HOr0UTgayKlmSbqGY9EjYcdg==
X-Google-Smtp-Source: APBJJlGfs/EQWluyXgbLosjjF6gudMWduht8Gm3rmkOk8/2Fuzmhd8GPseR4MYeociLnVTNQASyqDg==
X-Received: by 2002:adf:fed1:0:b0:30e:4515:1529 with SMTP id
 q17-20020adffed1000000b0030e45151529mr4265962wrs.37.1688757648680; 
 Fri, 07 Jul 2023 12:20:48 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 i4-20020adfefc4000000b003143be36d99sm5135728wrp.58.2023.07.07.12.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 12:20:48 -0700 (PDT)
Message-ID: <40da81d1-ba63-1fbd-2a21-219352cc3278@linaro.org>
Date: Fri, 7 Jul 2023 20:20:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/15] Net patches
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
References: <20230707090628.2210346-1-jasowang@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707090628.2210346-1-jasowang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 10:06, Jason Wang wrote:
> The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:
> 
>    Merge tag 'pull-9p-20230706' ofhttps://github.com/cschoenebeck/qemu  into staging (2023-07-06 18:19:42 +0100)
> 
> are available in the git repository at:
> 
>    https://github.com/jasowang/qemu.git  tags/net-pull-request
> 
> for you to fetch changes up to da9f7f7769e8e65f6423095e978f9a375e33515c:
> 
>    igb: Remove obsolete workaround for Windows (2023-07-07 16:35:12 +0800)
> 
> ----------------------------------------------------------------
> 
> ----------------------------------------------------------------
> Akihiko Odaki (2):
>        e1000e: Add ICR clearing by corresponding IMS bit
>        igb: Remove obsolete workaround for Windows
> 
> Bin Meng (9):
>        hw/net: e1000: Remove the logic of padding short frames in the receive path
>        hw/net: vmxnet3: Remove the logic of padding short frames in the receive path
>        hw/net: i82596: Remove the logic of padding short frames in the receive path
>        hw/net: ne2000: Remove the logic of padding short frames in the receive path
>        hw/net: pcnet: Remove the logic of padding short frames in the receive path
>        hw/net: rtl8139: Remove the logic of padding short frames in the receive path
>        hw/net: sungem: Remove the logic of padding short frames in the receive path
>        hw/net: sunhme: Remove the logic of padding short frames in the receive path
>        hw/net: ftgmac100: Drop the small packet check in the receive path
> 
> Laurent Vivier (4):
>        virtio-net: correctly report maximum tx_queue_size value
>        net: socket: prepare to cleanup net_init_socket()
>        net: socket: move fd type checking to its own function
>        net: socket: remove net_init_socket()

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


