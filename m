Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F60722DCE
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 19:44:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6EFC-0001L3-Ow; Mon, 05 Jun 2023 13:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EEv-00011P-UE
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:43:34 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6EEt-0006oe-HY
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 13:43:32 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30aef0499b6so4087198f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 10:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685987009; x=1688579009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GI3b1FP48roN4zKkjYZtTd9YuNtjTIxjls2QIOxJeIA=;
 b=xCHwNHkOLAaDgYaC2m/fnpsKdEIRd/vE3+8X5zl1NgEFEbbCoNUFRGRtSMknx/Zv3U
 uPLJwCeWR7Yl7fVulpMoKvkdYRjEnqjrcNKbHxFzHhGdh50PLzonrnKhfu4B2oEsT9aS
 +djvvIOGfcTO7tC4AX/QpVqg5n9y+SVuEg61bZOahn3rkiTWGqXkFjLufHqW9CxtEXuv
 xM4s9X5t2gdzYIHj1adQqBe+ehLSjNOCZNNQM6772P1g1jLNOkUjqQ8D3U5MOx/m3YDP
 C9kFmK7RHP3+LV+vWqhpfInTPhIEYOkf9FJFnwl208FbKIbWnaB9Z8myEX4xvBo9MKZv
 NvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685987009; x=1688579009;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GI3b1FP48roN4zKkjYZtTd9YuNtjTIxjls2QIOxJeIA=;
 b=X/4orW5YHQKSTeANhq2Yfbxb0c7RPziYnDmyUxjqnoTAm4ZLOKEJkz23kKANbuEAl+
 hxpSbCXoraByNW7Jq5iNVFKz7hUkgmLcd+/SUTfMoBhhN1VFnMnHsoRghFPEIm5YTGvi
 6idEROsWZPwR9YRbFc8c4sACiQ4xZC+bK6rdu4BeeYjEEBerJrHA+TVhtznwM9AeNwjw
 T9l4jCt7ToXT5fjjEglxAfqTzxrpNFE+KHgS14OTOx1dJOl7KFc6Chu1mkxoY6eLEHAV
 so63u5W6PAiMUGwaaZIprSpun8vehBoE8/5ny9Gq3G2e7R2uA9VPe2QMFmVFZNFYddrg
 E6Tg==
X-Gm-Message-State: AC+VfDxWCrpPIqgtpK0DBTJoqs1ayt8A24yOMeIwj6LTtPG85TVp67Ej
 RXd/QNGa35/k1kVSc5p3VIKA3jiJUA4vSxV26OQ=
X-Google-Smtp-Source: ACHHUZ7OqkVOBeHrNwg4djdvUzIWTQW8UFvO3ZbCzOxiabtfbcbFtscYQjpecmg7P7p1nEi+fk+eHg==
X-Received: by 2002:adf:ec04:0:b0:309:41d8:eec4 with SMTP id
 x4-20020adfec04000000b0030941d8eec4mr5529992wrn.39.1685987009639; 
 Mon, 05 Jun 2023 10:43:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b003f1978bbcd6sm25721353wmo.3.2023.06.05.10.43.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 10:43:29 -0700 (PDT)
Message-ID: <23fb6e83-1d29-5f82-55d9-a02995fb71c4@linaro.org>
Date: Mon, 5 Jun 2023 19:43:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 0/2] scsi/qemu-pr-helper: Drop 'old' lib and use default
 config helpers
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230605174146.87440-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230605174146.87440-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/6/23 19:41, Philippe Mathieu-Daudé wrote:
> The 'old' lib check was added for CentOS 7 which we don't support
> anymore.
> 
> We don't need to implement particular [get/set]_multipath_config()
> helpers: use the defaults.
> 
> Philippe Mathieu-Daudé (2):
>    scsi/qemu-pr-helper: Drop support for 'old' libmultipath API
>    scsi/qemu-pr-helper: Use defaults [get/set]_multipath_config() impl

PD: Only build-tested...


