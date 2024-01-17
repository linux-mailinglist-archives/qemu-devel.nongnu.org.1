Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A683010F
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:10:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ0zO-0000GK-U9; Wed, 17 Jan 2024 03:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ0zM-0000Fm-NZ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:09:32 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ0zL-0003si-7s
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:09:32 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e8cf57d63so183535e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705478969; x=1706083769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fGLnRf8fEK+y1kSlwppMbXcML5NETQCCf4+m2VA/VbI=;
 b=BePrrQKXzkfkV2P8N9EUrbZpKTKiP1ZIzAFmIrPFgfrirvSO8gFfvOP8ps6L+kTBzH
 UnaBcjmZZSw4Tsy/gDOaVsqeDt6d9Ulql8dIhhXD5FcusSp8k8MbdCddn8q3S5dRg9CV
 CaG7QbOaPOD3HHV3k501aslxw5Jsy0agUN6isBZ1KEau7h9CET8kedpP2D9WEwzYqZQK
 sH+pfNt9XE8LTZHH7NL/8iZ9UON0oi1eo3eWO0PpwCwj7sOzXbNo6vI+B6lkATshA4GL
 dLV9KT4v4QCg1ef7qTCQr5NrQzDl/SpDx56dTi0X+cJhdXl06CeHfp6jtjg8ScnfQDZ7
 hbVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705478969; x=1706083769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fGLnRf8fEK+y1kSlwppMbXcML5NETQCCf4+m2VA/VbI=;
 b=qsjURbL3sZXOu+WeaFOc6fyBV57h74OLxEEQNb0fDFpwt8idNFCGp9e8J15IfZv0Fi
 OAOYDPQfPyw7HtFu9Fo3dV82m65J8z2CXi5HvK7BUQ3oPtTqJ4YLCftZR1KSAcJjjD29
 Rq53N5GgvMUz2bEsJFtNjnZKOd+NZ0EaZuSlCb1qzh2OMacddMYimwrCRQD2p1d3xqBt
 dOLfq+mFEOVPmklDZBn27XK34Cf8tqt9IVdE1bqLOCU+n8KFBe404mRFivA+CIYgVYAc
 X3vuyaK5O+mznEco5BknFNhYBJ3fUxYCoWEss655d2EJ51bLOvqfhtzFKmLAOf91xL5t
 uvXw==
X-Gm-Message-State: AOJu0Yybj0HrclrfExchXtzfWZ9gCLLfQQsvFVxI0fe24oldCpN8gO6J
 IkjmRnR1NhbQv+KBMWw+eO+D4z/MTgzw7Q==
X-Google-Smtp-Source: AGHT+IHFaEPNULyjopr50JOFLidv3zLF/2vT8JJKbM2mzBYRKqc5AVDdKp6Nu3FAS0mGcIIa0wJENg==
X-Received: by 2002:a7b:ca50:0:b0:40e:5535:b499 with SMTP id
 m16-20020a7bca50000000b0040e5535b499mr4311350wml.88.1705478969572; 
 Wed, 17 Jan 2024 00:09:29 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 fk4-20020a05600c0cc400b0040e7efb1ff2sm7325596wmb.37.2024.01.17.00.09.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:09:29 -0800 (PST)
Message-ID: <b91f763a-3d06-45aa-97af-3971e843514b@linaro.org>
Date: Wed, 17 Jan 2024 09:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] migration: Make threshold_size an uint64_t
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Bandan Das <bdas@redhat.com>, Julia Suvorova <jusual@redhat.com>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-2-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240117075848.139045-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/1/24 08:58, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> It's always used to compare against another uint64_t.  Make it always clear
> that it's never a negative.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   migration/migration.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



