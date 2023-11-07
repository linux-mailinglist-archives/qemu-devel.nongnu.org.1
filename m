Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4FF7E3863
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:05:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0IwY-0006CI-TP; Tue, 07 Nov 2023 05:04:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0IwW-0006A1-Vs
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:04:21 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0IwV-00010g-9X
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:04:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32fadd4ad09so3536684f8f.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351457; x=1699956257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7vNQvsBCfS6b/bHw4Id5RTs+WrOWQKLbbdfZpu4FsL4=;
 b=NOK+aGBdb64vJ8sQWsPFEnTQCNVxeu4BPxaEVcLN8IubZ8NbJpQYQUqaCHffWepWWZ
 CjHQdBfBQZrqWkGRU0ugmE1yzx9B94NJS+uVdlW0mm5IyMRM3xLfE1FArKdhWyIBO8Uj
 aYpZFRAW9wQcPLSAA3UVcpnf/+dtO66kQXcSearGuXP2Q9cvRfumt0LGYdU3zhhYDlQ9
 KQ4edaJWuFsA0mjSQsjZ/K53X9pZ3p+fm05b52v8ixYa0PhR0rCjMCkFHRbDvyGQcBqt
 80VaGh+pjiaDmca5pWjuUEcdoO1PTOBtNoEj0Vr6qmRPkXceTPv50JugQhykxE/03zs5
 JOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351457; x=1699956257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7vNQvsBCfS6b/bHw4Id5RTs+WrOWQKLbbdfZpu4FsL4=;
 b=iBcOk8vmCxLGB9P8oI2oJyuGVuEp7S10dVmSAQCkMDXOau4LRX5clZqp9qiXk+SKvv
 8CdtoBUemXXyRvVSQN4Eqw/XFSwghvDTPpmvRCh79HOGTsWw6Bi3ULHPN5DfIufRawAX
 8pixostiRvLf1DP36nP4Iye9ARmkrfgqZpR1h9AgxHZhUuDqqzbgFMlbMVCHypn9lECm
 fX+pet2MXUhkIY7Fg2K+z6j4IQhyyYo70lcfffC+xt+4ZqzsMmqN416EZP2y6XL0oWt5
 beSAMHfwaAZ8lLuHr8Ji0c6bOnKjA1S5xp1rb66wNg+teHeSzWs7GC7u41tiLIKxGv6J
 RzlA==
X-Gm-Message-State: AOJu0Yy1dzf+nP7dHiQBA3eJjWCeu1hLgvXYXjug0j0znIBpn3TWOMgx
 9z2AI8EZjZfcP9kxxk1yyXL1X8xnNfixvGkYCLo=
X-Google-Smtp-Source: AGHT+IFSNUP6BixpddTjwct03/aKUthvMZYskFrYdaR/REoQ6SNwJ7LXa950l2Xm5T7zs8ezJsvlEw==
X-Received: by 2002:a5d:64ce:0:b0:32d:b031:9719 with SMTP id
 f14-20020a5d64ce000000b0032db0319719mr26469382wri.42.1699351457492; 
 Tue, 07 Nov 2023 02:04:17 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 d7-20020adffd87000000b0032fb7b4f191sm1881485wrr.91.2023.11.07.02.04.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 02:04:17 -0800 (PST)
Message-ID: <690f6ba4-6b4c-4e7b-b340-39c51759f8db@linaro.org>
Date: Tue, 7 Nov 2023 11:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] gdb-xml: fix duplicate register in arm-neon.xml
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>, Richard Henderson <richard.henderson@linaro.org>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231106185112.2755262-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 6/11/23 19:50, Alex Bennée wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20231103195956.1998255-3-alex.bennee@linaro.org>
> ---
>   gdb-xml/arm-neon.xml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Cc: qemu-stable@nongnu.org
Fixes: 56aebc8916 ("Add GDB XML register description support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


