Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A5676BF81
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 23:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQxDJ-0000A8-6o; Tue, 01 Aug 2023 17:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxDA-0008VU-PQ
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:47:25 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQxD9-0003i4-99
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 17:47:24 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9bee2d320so95287471fa.1
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 14:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690926441; x=1691531241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYMMq9e7P+r7qkWxFI53mAai3xKAlkShesGACJc6bpM=;
 b=EhaZWUJrL5+Po2IMELp7a+IWnmCfCa5oVrrfCESJBWPo0r1TQM96kXIKJ+YCRcJoIl
 /LBf6bmHweolR0D/CnjoAho9cS/bqjFe5iOzcEr/OqKDggsFooQPcKyAwZI2+2WJieYr
 lxJdThXI8nQb+N6f9wbugXj7ZaFPg09uSlzXQq0c+Q6DZB5BUmmN2q+XzHznwHjJvIN3
 gPzjNDZO2UGYCnxM27c+/oliFKXywQq6P2rd2pUSnVb0Mny02WpAzGHxZVIzKFbzaph/
 X0kGtrY9f1L1xfxRsMfyHPyIGWq5O5d75sftNZDDcKnRzCaQFsP0ZyhTf/r57Ej7DwTp
 XvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690926441; x=1691531241;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYMMq9e7P+r7qkWxFI53mAai3xKAlkShesGACJc6bpM=;
 b=Ld/oJyaazC7uGqtn2hMSwrYdhZavwAvdjc+9WK/cMlX4E9zboh/Lj67zNWJ/GUuvQe
 cCMVx1okgFkthdlWhXfrpwvudGtalwwW/Kv2/QPAWANV5qdmEvwy14LqCqwu2wEejrDQ
 RahKrI9CwO+fkWYwURULu5FoQwXNGZhLR5rgp4HvVnX8/Iua7bPr8BRdyq++ZWjzmn7O
 kL4pMJLVO3RK9UMSoEhGhi8IzvDPzEaInx+RUadhNY4J+KEsvnczR2kpttEqplIm3dKz
 kssUXNVP8w7RYEBS62OPdcbTStq5Ogn9FyV/KA4kntRDAU44YIdqwJ6raglsLQTegJUv
 mOig==
X-Gm-Message-State: ABy/qLbK60COBsxRV9sV0VfUdg7jdGEn/3Z06+f3D91+3FTl4vatZT0a
 cmkDRHByloVcyRxNoTTqGsXi2g==
X-Google-Smtp-Source: APBJJlFunJs9CVY7zIW9RsZCPbiBswd3MUSc+OGqbPfGu6GJZ7jgXMT7mgW4pxaUDtT1qRB1I8oFHw==
X-Received: by 2002:a2e:9bc3:0:b0:2b7:1dd:b416 with SMTP id
 w3-20020a2e9bc3000000b002b701ddb416mr3517101ljj.15.1690926441018; 
 Tue, 01 Aug 2023 14:47:21 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.174.59])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a7bc4c8000000b003fe1a092925sm9312096wmk.19.2023.08.01.14.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Aug 2023 14:47:20 -0700 (PDT)
Message-ID: <503dac94-9b5f-f4b1-2499-ed4682256e36@linaro.org>
Date: Tue, 1 Aug 2023 23:47:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] ui/dbus: fix win32 compilation when !opengl
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: thuth@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
References: <20230725112540.53284-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230725112540.53284-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
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

On 25/7/23 13:25, marcandre.lureau@redhat.com wrote:
> From: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1782
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/dbus-listener.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, queued via misc-fixes.

