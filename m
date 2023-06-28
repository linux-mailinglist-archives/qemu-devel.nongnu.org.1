Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18046740BCB
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 10:43:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEQlO-0002Ej-NV; Wed, 28 Jun 2023 04:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEQlM-0002EQ-OU
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:42:56 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qEQlL-000755-5d
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 04:42:56 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b698371937so61551901fa.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687941772; x=1690533772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FIMYxIjfgrJTa4Sr5WYwWDlTONw1iuSwOUaxogh89fI=;
 b=PvQjEHW12dQYdIrIyKByCVrugYlqvHXSlynYIqA5si7Ix3pU0hBammuMRio9jnu1R9
 H81u6/cPTZfmaEL7WzEMo3VGRIZZEl1BcQYItEC3wwMaec4x2cDcjquA9ChpGgu7/+be
 XJ9y0OIF9DT4tHJtDfFduWBCio30GJje22xDBr9I/15SHBAKX8WXzjmk+tjtbcYoq75r
 ungXt9I/TSYQ4I21yr4iLQb4s9Kdmr7KFrgaYXr8Zn6ZfRcGbhlIaW9UeGQP8U6fiIbF
 4kNVW32FbvtJc6zT/E7PKlaWTXN7968Aj8JuWAQuhQjIC047vc6c9rTfmnKXIluot5GH
 +B2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687941772; x=1690533772;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FIMYxIjfgrJTa4Sr5WYwWDlTONw1iuSwOUaxogh89fI=;
 b=ikotCS/BoDhlkr7xI6At9yIDe6jnm0M9RWzP5gZ/H37lo7bnJVwlV4KYoZKCQGRKIO
 Z6a0oOI0VWarKxT1UNS5kSydfyAMnTpPWW8l4uY9hgCty4Lsksrdgae5b5R9IuWa/Ghm
 wTqpabW2njJVtasVDzBhkEs7bSx9rAn2nJRZ87VIvZeOgUtN2VM9gRpwzo/v0H1P9U1M
 qL7n34usY/kog3kW1ghAJEFT0Yb8TRQNwyg7HmQC2l3bJJVmIuejqcVUjzIwxO0IXbtg
 lxT5RmfHYxQzpYKp1OObnHkBcev7Vxc4bGjqXrfVb7r6q+dTVkNFtjGwn6or1+jR/tgo
 PfTw==
X-Gm-Message-State: AC+VfDwUYWH4uXqkGD1NmXjraOLxNEOz10DlIyrZPYDqb0TeGP+Aujab
 vgz06zhF1bq857j8npm4DSuy+g==
X-Google-Smtp-Source: ACHHUZ7/xU90SYDSgotyG0ljoYcC3VK0BeCu+UI1CBhuuo2T1+zV3t3/UmIYF6m9eWsIGHcQKWGDBw==
X-Received: by 2002:a05:651c:109:b0:2b4:78f6:d330 with SMTP id
 a9-20020a05651c010900b002b478f6d330mr18685318ljb.2.1687941771826; 
 Wed, 28 Jun 2023 01:42:51 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.41.103])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003fa74bff02asm12994082wmb.26.2023.06.28.01.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 01:42:51 -0700 (PDT)
Message-ID: <7658f042-15d1-7d4f-f316-756b2a299dee@linaro.org>
Date: Wed, 28 Jun 2023 10:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 28/36] gdbstub: clean-up vcont handling to avoid goto
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Bandan Das <bsd@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Laurent Vivier <lvivier@redhat.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Riku Voipio <riku.voipio@iki.fi>
References: <20230627160943.2956928-1-alex.bennee@linaro.org>
 <20230627160943.2956928-29-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230627160943.2956928-29-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 6/27/23 18:09, Alex Bennée wrote:
> We can handle all the error exit cases by using g_autofree() for the
> one thing that needs cleaning up on the exit.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   gdbstub/gdbstub.c | 28 +++++++++-------------------
>   1 file changed, 9 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

