Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C962F73D905
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:59:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh7j-0001Lo-VG; Mon, 26 Jun 2023 03:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh7g-0001L3-Ts
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:58:56 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDh7f-0005CA-5o
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 03:58:56 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fb7589b187so748940e87.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687766333; x=1690358333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I3Y32WY9GXAQ3WulsRyGWXIz4sqave2+2AtNlGeCFJg=;
 b=EuzFEgXsLWFh4azhq6z7+LFsyuPb3HAJMbiG52dS2bdQwSpLrlmpV8yKpyb6wh8tW7
 2xWpEHLdBP1l+wzGpZrG1e/nNICX+4qDsHPvtoNz2RKq5uyvZqpYzSOKhGnmoqhSon1o
 s4J6lEIDupha5vwgwJfwxlQwwG1nUUClztmDPiaqZ+jhth8TjdTlp39Soq/6b3TE0LpH
 GgYCOuZBKLtZUaOSOFuPvg/mADpEsmT/wobLm5c9qR5SAvnHGOnaP5PF3W9xd7jK8uHn
 3rwqS1VQskYIXNWKbrvE8Dj71ZHzTB8Ls2KswgxgGH4r9bDcF3pMcMbFvysh/Xy/bnxY
 QoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687766333; x=1690358333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3Y32WY9GXAQ3WulsRyGWXIz4sqave2+2AtNlGeCFJg=;
 b=PXAocGkD+3pJnJE484ivBhyBioXxjfBfXx7bOIJrLkl/VG0H/39nkggge8tQHSQt4t
 LCuz/cNe5jUvCrFHf0hLulwlhSLJrci+4+T70e1VZiGe1LtX/qxn9e+I1XMJMBmZEOqK
 Knqn0x2CxjU8x41KFP3WPuHdYcmGe6MBYynDxNcqb94J9gnJl2gVEiaZimlScjN+UY3q
 jyzx22i0H518pWKZvwf/v0Inrh4kh5g4A4LXXkcmUQXmexGBGyP5sVSmdMIIIGYDB4fY
 z2Mo1STgTtXDOstU95QCDIqaDNnSowsURaY808O/jlEHtGNnaeTMbL6AvRP0Cxfcq7R8
 jLrg==
X-Gm-Message-State: AC+VfDzpPS44XfbXo26nN7SQQOQNSNqx6Gz0Of1uObE7/h56it7LX0v4
 4tFn5XO0JnT41tiTBHe2zldVPQ==
X-Google-Smtp-Source: ACHHUZ6wNGrrSUGui4TNmK/Y0TKpKAHg5Ia5jTH8UD1l4x/P0Fuc6i3XTqIcgaVLeO98l/ifk73FXA==
X-Received: by 2002:a19:641e:0:b0:4f9:556b:93c5 with SMTP id
 y30-20020a19641e000000b004f9556b93c5mr9787646lfb.40.1687766332927; 
 Mon, 26 Jun 2023 00:58:52 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t12-20020a7bc3cc000000b003f604793989sm9575031wmj.18.2023.06.26.00.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 00:58:52 -0700 (PDT)
Message-ID: <8d03a491-8589-e8a4-e4bd-d02657e4d209@linaro.org>
Date: Mon, 26 Jun 2023 09:58:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/26] gitlab: explicit set artifacts publishing criteria
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, Riku Voipio <riku.voipio@iki.fi>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Bulekov <alxndr@bu.edu>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Yanan Wang <wangyanan55@huawei.com>
References: <20230623122100.1640995-1-alex.bennee@linaro.org>
 <20230623122100.1640995-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230623122100.1640995-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 6/23/23 14:20, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> If not set explicitly, gitlab assumes 'when: on_success" as the
> publishing criteria for artifacts. This is reasonable if the
> artifact is an output deliverable of the job. This is useless
> if the artifact is a log file to be used for debugging job
> failures.
> 
> This change makes the desired criteria explicit for every job
> that publishes artifacts.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Message-Id: <20230503145535.91325-2-berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

