Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A065A74AC79
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:06:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgSF-0008Iz-QO; Fri, 07 Jul 2023 04:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgSD-0008Iq-3i
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:04:37 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qHgSA-0006Z1-Jq
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:04:36 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e43473ee0so127739a12.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688717072; x=1691309072;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YJeRqIbgb4g1gLODNjMVt6Bz39+Pe/64pQB0SmLgnVs=;
 b=TEAITajMGNK74AGp+X/GZHmAXYsinUBu8FxtfAD9huDc572Trbg/wj89UgYD/DcIBB
 q3+9XzMLXnuBHOmVBK+9pNJxfMkamtla+nNXNzqqpIajM7/WdUsVTh6tL+reV42u4ozq
 IclCWHcFMiYYLgh57+uomuHBmoDyxqYGNg8M5n0HPt148Ir4wio6wjJb9NGr6y30sTJw
 daav0fv9KhMDrSGiddEkOa+8DKSWqrVSi6cW4yQY98YcFDTHpSPAcXNEtvbs4QQzyYMP
 T+7Pj1j1p4fh/2r/8YWuO/BLtsMjF9symAosRqAFheLZJnoBSPULfKPiWLHxVRBCv088
 IADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688717072; x=1691309072;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YJeRqIbgb4g1gLODNjMVt6Bz39+Pe/64pQB0SmLgnVs=;
 b=NH/kTVIMnDb6jm8XJcxSuNNciwfcDRtj5fnN8xaPaOEAcBoDTWz7N/bT3p4jGyCTE9
 XlbF6T/hq61oCoEHRozgpzq++4Llmi6iH8rX9kIKvZr7lCA6T0buTcffNwNUxcG1Cqqr
 Nwg8YGrZ868EaeNnGK1XSCtEMRTp6ldpWT/Fxig+SeNunFvW1iBSZ2B2dZbb0J7e7ufE
 zDL8VYMaITkTWfAkdWBEsKoPXYdjHfBH1s77w4ef4EPeAxziT6s2xzvED2A+oG1h20CK
 SGEzC9FgB1c9vsKkrvCyy0j0kv7uYLZwoZmncNRBbe3wtuUqnjUKWZmrYFlFGD380RPt
 t+rg==
X-Gm-Message-State: ABy/qLZtOxtCp49uM4AZ79f7bhHhsAu0mmvARUh7bqKsbQlkTySeu12s
 1qNkJgjLngJffrA2aSV5Se4KgWkubz0CbdvXPbw=
X-Google-Smtp-Source: APBJJlG5KX3Ki+ROHPjtRXDy7Sp/X6hZ6CckrnvtcjB6p8T2DeLpXd4jrVAAOEzClp+wY1isew4VEw==
X-Received: by 2002:a17:906:6485:b0:98e:419b:4cbc with SMTP id
 e5-20020a170906648500b0098e419b4cbcmr3471893ejm.12.1688717072443; 
 Fri, 07 Jul 2023 01:04:32 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.215.192])
 by smtp.gmail.com with ESMTPSA id
 a17-20020a1709062b1100b00992ea405a79sm1824639ejg.166.2023.07.07.01.04.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:04:32 -0700 (PDT)
Message-ID: <fb1ebb07-6452-9ba1-f394-9b43a44a4d80@linaro.org>
Date: Fri, 7 Jul 2023 10:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: Addition of qtest_irq_intercept_out_named, or modify
 qtest_irq_interrupt_out?
Content-Language: en-US
To: Chris Laplante <chris@laplante.io>, Thomas Huth <thuth@redhat.com>
References: <v4-CFRWoJDePdhYGwXmcoZ4pJoJVk37oEGjiSx0aN-3K4aBwDF3_5SVTlspGOZnwk9QA7ewsCyGgitkgaxtSLRiqe2euhsY1klbjIdCkHf8=@laplante.io>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <v4-CFRWoJDePdhYGwXmcoZ4pJoJVk37oEGjiSx0aN-3K4aBwDF3_5SVTlspGOZnwk9QA7ewsCyGgitkgaxtSLRiqe2euhsY1klbjIdCkHf8=@laplante.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

Hi Chris,

On 7/7/23 00:10, Chris Laplante wrote:
> Hello all,
> 
> I have a test case that needs to intercept a named GPIO out interrupt. 
> qtest_irq_intercept_out doesn't support this currently. I would like to 
> send a patch to add this functionality. Does anyone have a preference if 
> I implement it is a new function (qtest_irq_intercept_out_named), vs add 
> the functionality to qtest_irq_intercept_out in the form of an optional 
> additional parameter?

qtest_irq_intercept_out() takes a QOM path argument. Whether it is
a named IRQ or not should be irrelevant at this layer.

IMO qtest_process_command() need to be improved to handle named IRQs,
see the "/* We don't support intercept of named GPIOs yet */" comment
from commit a5f54290ce ("qdev: Implement named GPIOs"). Few days later
commit 60a79016ae ("qtest/irq: Rework IRQ interception") improved the
support. Few is missing IMO.

Regards,

Phil.

