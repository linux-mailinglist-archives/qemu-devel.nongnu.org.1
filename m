Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E2573CD83
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 02:04:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDDDR-0006M8-JB; Sat, 24 Jun 2023 20:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDDDP-0006Lv-9G
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 20:02:51 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pizhenwei@bytedance.com>)
 id 1qDDDL-0005PS-8A
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 20:02:50 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-54fac329a71so1058231a12.1
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 17:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1687651358; x=1690243358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k0LcLl7qKKN0XH+BMTx3wAWSJazE7CfH/odpL9i7NcM=;
 b=QGnlG7FGga8+FNb3aW0XmwOSIOLv1WSH7aTmbtMLcksQTqeIaxdC67iIevc9PbLk1O
 2xMVSJ2JX0J0adC+Kkdo/tO2YcDvNfe83YaqwgKTJUms7uFOVkt7eNxJJWtfbHyHdPSV
 vg5k55ncT0JZVDD09rDCHqxq1T4orhyqZQVaPs4NX5pxAVrpJnavk8CD2onSbf/JKnaz
 3wrnE1dOwOBTeTvPXOqRRnDZHsay1XQ9VEkNAmp4tllewPJOK6wQy6dwiOWTvckZgY3A
 8RnWAAPje91z2fYt3m+QPsQ77sDcJS9U2dIsCo/IIQDAWGZgU0/3UQhtltU+aftBmnVx
 +bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687651358; x=1690243358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k0LcLl7qKKN0XH+BMTx3wAWSJazE7CfH/odpL9i7NcM=;
 b=j0p2qoXu7AhCBTb7rzhroRJzmOYBOTxqck6Eo7/Sj3Z/u82qA1Zdd6ZFrPBfRLIuko
 YmxYJkTJHvZh8y/K58yfUUAQMFKYMxcoc499XZVdD6nBWYH1ay3UW83weAVnPU8RFHla
 3EWzrgVpbCrXpcX7lutfOzYSakZ1xihjSyU1/P2KgpUftq17W6XY7wy34Wq2QVKuOuw5
 M5t3gVyssqbyM60PIxpuMkfJ5TyjkZdUqLj72C2tEMypbnx/quWhfm1lvy7tgmwCcR59
 jqY67A6mhhijcxfH2RBlzwaAqXoBKClOFMhoWcw5kJPaifRSOpu3F5HUTds/qEiDw0Ql
 kN2g==
X-Gm-Message-State: AC+VfDx7R7DIGBQI7bBLmgR3Av1CBFlo2BggFmto5EqgbnylrLibJ/yL
 M1vGf7/Lie9ZLPqHc+aQynWxHg==
X-Google-Smtp-Source: ACHHUZ5MdwEBSFBME6W/a326VEdwujvIUWe4k/5yeMZS+CUJafmyUZ0lHYhYsmzXKdAjs7+teMXCJQ==
X-Received: by 2002:a17:902:9a02:b0:1b2:1942:9106 with SMTP id
 v2-20020a1709029a0200b001b219429106mr928216plp.64.1687651357637; 
 Sat, 24 Jun 2023 17:02:37 -0700 (PDT)
Received: from [10.3.43.196] ([61.213.176.7]) by smtp.gmail.com with ESMTPSA id
 g12-20020a170902740c00b001b6674b6140sm1661697pll.290.2023.06.24.17.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jun 2023 17:02:37 -0700 (PDT)
Message-ID: <b22dd57c-6e39-cfc7-7128-33447252468f@bytedance.com>
Date: Sun, 25 Jun 2023 08:00:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] cryptodev: Handle unexpected request to avoid crash
Content-Language: en-US
To: mst@redhat.com
Cc: Lei He <helei.sig11@bytedance.com>, arei.gonglei@huawei.com,
 qemu-devel@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 Xiao Lei <nop.leixiao@gmail.com>, Yongkang Jia <kangel@zju.edu.cn>,
 Yiming Tao <taoym@zju.edu.cn>
References: <20230427080509.172477-1-pizhenwei@bytedance.com>
 <A4856378-68F6-440B-A0C8-B13EEEF452BC@bytedance.com>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <A4856378-68F6-440B-A0C8-B13EEEF452BC@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pizhenwei@bytedance.com; helo=mail-pg1-x52e.google.com
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

Hi Michael

Could you please apply this patch?

On 5/26/23 11:38, Lei He wrote:
> 
>> On Apr 27, 2023, at 16:05, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>
>> Generally guest side should discover which services the device is
>> able to offer, then do requests on device.
>>
>> However it's also possible to break this rule in a guest. Handle
>> unexpected request here to avoid NULL pointer dereference.
>>
>> Fixes: e7a775fd ('cryptodev: Account statistics')
>> Cc: Gonglei <arei.gonglei@huawei.com>
>> Cc: Mauro Matteo Cascella <mcascell@redhat.com>
>> Cc: Xiao Lei <nop.leixiao@gmail.com>
>> Cc: Yongkang Jia <kangel@zju.edu.cn>
>> Reported-by: Yiming Tao <taoym@zju.edu.cn>
>> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
>> ---
>> backends/cryptodev.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>
>> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
>> index 94ca393cee..d3fe92d8c0 100644
>> --- a/backends/cryptodev.c
>> +++ b/backends/cryptodev.c
>> @@ -191,6 +191,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
>>      if (algtype == QCRYPTODEV_BACKEND_ALG_ASYM) {
>>          CryptoDevBackendAsymOpInfo *asym_op_info = op_info->u.asym_op_info;
>>          len = asym_op_info->src_len;
>> +
>> +        if (unlikely(!backend->asym_stat)) {
>> +            error_report("cryptodev: Unexpected asym operation");
>> +            return -VIRTIO_CRYPTO_NOTSUPP;
>> +        }
>>          switch (op_info->op_code) {
>>          case VIRTIO_CRYPTO_AKCIPHER_ENCRYPT:
>>              CryptodevAsymStatIncEncrypt(backend, len);
>> @@ -210,6 +215,11 @@ static int cryptodev_backend_account(CryptoDevBackend *backend,
>>      } else if (algtype == QCRYPTODEV_BACKEND_ALG_SYM) {
>>          CryptoDevBackendSymOpInfo *sym_op_info = op_info->u.sym_op_info;
>>          len = sym_op_info->src_len;
>> +
>> +        if (unlikely(!backend->sym_stat)) {
>> +            error_report("cryptodev: Unexpected sym operation");
>> +            return -VIRTIO_CRYPTO_NOTSUPP;
>> +        }
>>          switch (op_info->op_code) {
>>          case VIRTIO_CRYPTO_CIPHER_ENCRYPT:
>>              CryptodevSymStatIncEncrypt(backend, len);
>> -- 
>> 2.34.1
>>
> 
> Reviewed-by: Lei He <helei.sig11@bytedance.com>
> 
> 
> Best regards,
> Lei He
> --
> helei.sig11@bytedance.com
> 
> 
> 

-- 
zhenwei pi

