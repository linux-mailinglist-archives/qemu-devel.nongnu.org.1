Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA43B7203A0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 15:43:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q552I-0001Xp-R6; Fri, 02 Jun 2023 09:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q552H-0001XT-HY
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:41:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1q552F-0000sW-MH
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 09:41:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30c4c1fd511so1364039f8f.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685713301; x=1688305301;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CYGbY9Cd8ghZDlLaDrXXqCRZM4eJM2SrVXLG7dB1t5E=;
 b=kr3Xa1RbXFB6BA2KsmMEQ4a3SthmO64RdcahNYMwtBiBd7edzEwN/XdK/zreTc27XT
 WaFAq9GKw4JUfaa4xN/G6Sr9nS3YIALoR+mvKv1+SKqiixPCbLnbJkDF+/11XzDjr2zq
 ZSvFNQLiO03cj1IcmYruzaRxVGip/T0gk6nNCAmr7w4kP9ka5NOOZIhnrE59U/0cYAZM
 oYk9z1eq30k1CAAnOZhSJuOvTaoi+8XwOfVL3Q1dM1PurxBZxHV3aDRu0kbp9muO4j2z
 TAyuKNNLSCjZ8cjt/Sv1rNNbIjq2j4Xm9NLu98eml6kIqs/LdXC/RVlydvaE/hVZz4ou
 6dCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685713301; x=1688305301;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CYGbY9Cd8ghZDlLaDrXXqCRZM4eJM2SrVXLG7dB1t5E=;
 b=bkPDVAwHLwz/Q9d1RmU/Yu9vyYa7JSPtfj1kUp9oDVquN8d27I469kQWh8ogYXGVP6
 jbQTKSoTO3tdgWMRJMVWTBNtECJyJOPl/8neM+tesUICuyXPuvBGuhSWGXPDtLnnO7P3
 D+7acYjZoCYkUMjMnkvw6domSEDOVch5xGtZUKnsRh7F6ET1Oa4rXP5pIeGukNgPR72G
 RH11mV2dBl50ulm1SDoIIJ4iujK7OblO7dF8EbOrVKRl9xPUfW6L14+Ax8g0Fp4dRrGk
 VYNH+amjLVfHEYzbR3Tgm9UI0YItWv9v/JKQ+lRCNsDTS33qAFQg4AMLPEUT7YFaqwPD
 UPSw==
X-Gm-Message-State: AC+VfDxyf0VLi34U1aO3FUR59rx1+1sWQpTJdr7jAq2V03Dcqb4sqCLT
 /lrwKgiWn+PePpBcTEQ0CWJG1Q==
X-Google-Smtp-Source: ACHHUZ7SOsTM+jc+E6fyfo1FhNngw7oPAzinLel9OiRGGeI0XFMQ/nG9hRVbiWk4XLJhE3i6SmI/2A==
X-Received: by 2002:a5d:690a:0:b0:30a:f22b:a61f with SMTP id
 t10-20020a5d690a000000b0030af22ba61fmr21970wru.38.1685713300803; 
 Fri, 02 Jun 2023 06:41:40 -0700 (PDT)
Received: from meli.delivery (adsl-127.37.6.162.tellas.gr. [37.6.162.127])
 by smtp.gmail.com with ESMTPSA id
 l3-20020a7bc343000000b003f423508c6bsm1995849wmj.44.2023.06.02.06.41.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Jun 2023 06:41:40 -0700 (PDT)
Date: Fri, 02 Jun 2023 16:36:55 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Add virtio-sound and virtio-sound-pci devices
User-Agent: meli 0.7.2
References: <20230526204845.673031-1-manos.pitsidianakis@linaro.org>
 <87a5xkde0c.fsf@linaro.org>
In-Reply-To: <87a5xkde0c.fsf@linaro.org>
Message-ID: <vmope.urd1m26bujz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 31 May 2023 12:36, Alex Bennée <alex.bennee@linaro.org> wrote:
>If it's based of shouldn't we keep the author attribution and their
>original s-o-b?
>

I kept the Copyright in the headers but not the Signed-off-by lines, 
I'll add them in v2.


>What about:
>
>  https://patchew.org/QEMU/20220211221319.193404-1-chouhan.shreyansh2702@gmail.com/
>
>(which is also much more nicely split up).

Comments in that thread were:

> IMHO, all your patches can be merged in only one

and

> Possibly also patches adding
> significant functionality in the future (i.e. one patch with all
> basics and playback support, one patch adding recording
> functionality, ...).

which is why capture was left unimplemented for a future patch:

>> +
>> +    } else {
>> +        /*
>> +         * Unimplemented.
>> +         * stream->voice.in = AUD_open_in(&s->card,
>> +         *                                stream->voice.in,
>> +         *                                "virtio_snd_card",
>> +         *                                stream,
>> +         *                                virtio_snd_input_cb,
>> +         *                                &as);
>> +         */
>
>  qemu_log(LOG_UNIMP, ) - although why not implement it?
>
>> +    }

