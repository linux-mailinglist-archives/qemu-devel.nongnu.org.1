Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E66752835
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 18:20:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJz22-00015C-QB; Thu, 13 Jul 2023 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJz21-000154-AP
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:19:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJz1z-0002zV-Or
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 12:19:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso1438105f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 09:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689265141; x=1691857141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fz8qM6jYwA5oTqTmR2coWXTIMFP2Hl6L2QEQhIy+yCY=;
 b=TOvj5RsFulW6n4pcMwTzWLQDLZqNPk9esk4qS8GLr9yWTziUQvTAnZeX0iK1tg8mfe
 AVvQgZMKPK3WyHiUDHuzY9J+5sQWpz7oc4pe83DqijGILArtFH5YlF1R6TySEGze2umt
 Bj3O6TYPvXvhJDfYvFlXcRjfBelPRzK9L3vymOivUkSkOQca2jY0wZ4Tu0/p0/+opxVX
 gFAN8zStX63G3qBJ43xh7ozfauqioCDQd/JzzRlX6dqOy0o2/E9LrhSe+fS8a3P04sQ8
 yNeXoST/fPq1w7zR5TiV/vT1WPY7+QxYNHlk7qy7xJInSyUTvSza2aZ8FlsAx5gZsdx5
 21Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689265141; x=1691857141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fz8qM6jYwA5oTqTmR2coWXTIMFP2Hl6L2QEQhIy+yCY=;
 b=JzGaXtRX6kI2qD+VPuMSMEwpck6zvfXlvpGcz9ngofPcCoTUD17Cww0o1NVtBtByuh
 EcyFCwyH4gjm42wnoCdVa7qoPNzrRbDlP9souDrg4TpTmUJvxyRIyIMVPWYFpSd8v6j5
 8+QMbLmdGcKVM2FEFCvGu3KXNaODE/L2nPIJkd7Qr11HbtMDsuXA/C+dsRDxKLMPS3Sy
 lB2FwySvo+SOLnG9yfvj9kfjKnRK3Q5VO+DpmKASKkESjkuDzLqmPnRw/11TBIbS67mD
 R1RGH9pO0Fo+fspcQBe3V3538h2gaH80El173WyFWpYOwRF0eJov3JRfiQhv/DODdb0H
 VIWw==
X-Gm-Message-State: ABy/qLZpuJ3eLyqSk56JxreCZyYB0C02oDiEIwYxg0Afi8s59vCyQffr
 GCp9ibjSXIdN9Ku3Ohmho8lxqA==
X-Google-Smtp-Source: APBJJlGvxxl7I6SKwnluuTN4Ss6rk/lhvUM8+bR0zBXzwWbE+EX5lbqfvDjjoaTIPICvNNC4cy2CLA==
X-Received: by 2002:a05:6000:1815:b0:313:df09:acfb with SMTP id
 m21-20020a056000181500b00313df09acfbmr153206wrh.11.1689265141502; 
 Thu, 13 Jul 2023 09:19:01 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 x10-20020adff64a000000b003142e438e8csm8335414wrp.26.2023.07.13.09.19.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 09:19:01 -0700 (PDT)
Message-ID: <dbe4d887-7ea5-70f7-ffbd-8dac852c9de1@linaro.org>
Date: Thu, 13 Jul 2023 18:18:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] target/hexagon/idef-parser: Remove self-assignment
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: bcain@quicinc.com, peter.maydell@linaro.org
References: <20230713120853.27023-1-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230713120853.27023-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 13/7/23 14:08, Anton Johansson via wrote:
> The self assignment is clearly useless, and @1.last_column does not have
> to be set for an expression with only a single token, so remove it.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/hexagon/idef-parser/idef-parser.y | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


