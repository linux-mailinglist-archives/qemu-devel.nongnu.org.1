Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C974879B160
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:53:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqih-0003bS-Rj; Mon, 11 Sep 2023 19:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqid-0003bB-CI
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:53:27 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqia-0008U4-U9
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:53:27 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c0a3a2cc20so3500131a34.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694476402; x=1695081202; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZwdALQtEE/eq5MbAxA7bgLjoUwufFzYQGKynPH1ts9E=;
 b=wFvXG66TMkRhm1g0BJs7MrjjQhGbYWJL8Z9QwIF9UtUBlJkkWUHBCfLEbZTAhQ5+9D
 GZEdhZEu1Nyg/ax4zEs55+9xufC8AQ90kMD9bDhBlEmzSywq67sdZ2wD73rnGv6astwi
 +dkAVpyrzkqZxsM7ZkjFQz5LBIQpiidPQRxCKJLJ5Qoyi3kjg2AFZOrxVCiH+NsI1KQe
 j/e2QRxDCbPHFoBZ+IHJAdabYWVR8rbPDUZLl9Hvgv2VnR55Tre9vKBKuA/3NhA6Tpgj
 9yj6GMhCDQJ9urYTtQrmO9/IYWx5bg6ph2aBG1L1PcK+jooefjEi4TFgcyES7xIQssJY
 om6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694476402; x=1695081202;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwdALQtEE/eq5MbAxA7bgLjoUwufFzYQGKynPH1ts9E=;
 b=M2ynoY1pOaI680Oc44syvzOEeTpCofSkT4UTHK6V094GpdsPz+r7Yd7MsVUTojKTWV
 RNww7AVkgaxhd57c/jnKj9eXxy7iy979WD+LbHGFd0uLS3Ks8/4u8z09pnJb94hA4Rxj
 4PvsTvPKRB7CrHWPfNf6D8BM8yQvj9OZixTZdPGnTaKBKHJnDokQTHhD8jPYImBOms1q
 JCQxX+O6F879KjmeLoSNVEMJFaqOnuPEUJptMtt1li60UPWK6grKFurFbsPpRXzJS5ov
 0BOYyxoUvKZ0n/2LQ+VikobJN0+fh8P4OBBC/SzbPXe7VsyGp+XQbKzK0q4jdlg8EwED
 Ebkw==
X-Gm-Message-State: AOJu0YyBeFtAYkLKMm9ubD/WS8Ry0j9bP7YYA1YPyuQVqvR5MXCuzx/r
 kFK80wZ7wCEh4uOOt6l4P7C/HQ==
X-Google-Smtp-Source: AGHT+IEsy5snVHKNHO7rnKCsIfdYo2qL68vYfau9VfZ7I3IsQ5IkzbQ2lNy5Ao6qOjYRCijA2NI7qg==
X-Received: by 2002:a05:6358:7f0f:b0:139:833c:53f8 with SMTP id
 p15-20020a0563587f0f00b00139833c53f8mr11610171rwn.24.1694476402481; 
 Mon, 11 Sep 2023 16:53:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 ay29-20020a056a00301d00b0068fd653321esm1354350pfb.58.2023.09.11.16.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:53:22 -0700 (PDT)
Message-ID: <74115987-6d08-70d7-c904-d5f0ddee4ac0@linaro.org>
Date: Mon, 11 Sep 2023 16:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 10/23] bsd-user: Implement shmid_ds conversion between
 host and target.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-11-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-11-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/9/23 12:36, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 43 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

