Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E41B3792231
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:38:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUNm-0002tX-Cp; Tue, 05 Sep 2023 07:38:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUNk-0002tG-29
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:38:08 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUNh-0008Cd-TN
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:38:07 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401da71b7c5so23922415e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693913884; x=1694518684; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5jwuaVeTeS3EZUGNkQmtYQOtiKoes+P8TiazohduLXM=;
 b=n9RWxvBo++V8VCTMisgu+qA8xeMRdGbxWG2BOZ6DWIVju4ucX8b9Cyg0xIhyJg0Ju1
 WNniCfzLo9diMlnDbB+TIJ+EltkxumiocsBBtBMlV+utV1wxl4JNB64K/Xupfmv2/P3V
 B/ReWiHNoTpDhhrJamLl5ozePpXz7JlHU4Rg/k9S3wku5plUOqas0rtlkDmAD4gMiips
 GM1Kr0A5uJmDFDLLVrM6SOHkUKMNfo8tr9HHHdPGvDi9Zcd45T+lOR+hyzySPh5EZ98Q
 btza0wwBBLddgDIh2IrgrDKd3cvqlQKIGDAAaROh8WwyYfQgNLhaJEokl1VP90mRxNJp
 IqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693913884; x=1694518684;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jwuaVeTeS3EZUGNkQmtYQOtiKoes+P8TiazohduLXM=;
 b=DQp3Bp1OoradGFskuCRwVDe4lYuI+8CrMx8eH5rUsxEc+q5oCH1UmDK27V60LlB6ca
 4WyRJFaYmEYl8UJo+KhBog02wqlu+Dr6Wm33X8SCNew7Jb+Z8FHNTplQsRCbVxc85NEg
 e/71WJ1p1UYGSm1iPXdJix0DCYC1+bkK4kY/Uzn+DmXAZmK/i1dS2CZe3HbnBmeo+VD9
 PRNDOxGNhL6wWxHxRBxGH8XhK2teaB6XKLIlS8NYAntNJAKdKMoHA6B3rOrOSqgeI+6K
 Aoc9calrnMeaXevrTjMUST4F0574WjsHDPhm05vSPmMx4JJLG4UkLVhDwf0/GW9zihdO
 Vdyg==
X-Gm-Message-State: AOJu0Yzglkr2I/QF7qIidivGdFaiMm51k0VclagFaPS2mkrmQFxX3U2l
 Y9Q2dmym29gYAJvFm5RHotcA4J+NadjX20sVSR4=
X-Google-Smtp-Source: AGHT+IHGvcbRdKDNi4QT8Iuj8oys3wCXVztvxDQDpE0iltdkGWGfS/RkgKieqpf+Zg4hII0z0jrQvA==
X-Received: by 2002:a7b:cd88:0:b0:3fe:d448:511a with SMTP id
 y8-20020a7bcd88000000b003fed448511amr9539870wmj.9.1693913884322; 
 Tue, 05 Sep 2023 04:38:04 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 y23-20020a7bcd97000000b003fbc9d178a8sm20109103wmj.4.2023.09.05.04.38.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:38:03 -0700 (PDT)
Message-ID: <478a2ff6-8c5e-c1fe-0ba6-b95bbfff6bc1@linaro.org>
Date: Tue, 5 Sep 2023 13:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 13/14] MAINTAINERS: add maintainer of simpletrace.py
Content-Language: en-US
To: Mads Ynddal <mads@ynddal.dk>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-14-mads@ynddal.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823085429.20519-14-mads@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 23/8/23 10:54, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> In my work to refactor simpletrace.py, I noticed that there's no
> maintainer of it, and has the status of "odd fixes". I'm using it from
> time to time, so I'd like to maintain the script.
> 
> I've added myself as reviewer under "Tracing" to be informed of changes
> that might affect simpletrace.py.
> 
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


