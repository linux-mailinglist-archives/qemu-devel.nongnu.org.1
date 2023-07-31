Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93448769951
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:21:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTli-0003PA-EJ; Mon, 31 Jul 2023 10:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTlg-0003Oo-9k
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:21:04 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qQTle-0000Ef-KO
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:21:04 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so49890825e9.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690813261; x=1691418061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BCP/6rJR8Z4ywb61kGEudrHUFQ9M5QFvs6yWYM+1hSs=;
 b=caE9F18YKhEs/Avn3sln5LeJ2cr2M4d7b2KxcLIMtRN9BHFiZEp0r/2yQzfU1Di5Zc
 ajxJ1+YjJUWtj2IVGKDSviFxyM5qjGJQQYzxW61CEkgh/Ty3EjnUSDyM/kcPvcoin3Zr
 g+OwJG/XT6G+n4vuq3pddss/HVSd8BMBWgNBtKsgv6Z+0iygHvtGymVZtfmK/XWWcre5
 epu1xkU4t5yQHTy4ph7NLxs2hgO4ahviaHmMQdWfw2ACcUX3kues435UZcj5UxC6hOkq
 UaFLMDnayCsS/8eMFaPvDrcWyOYD8OWs3qRVSMcj00YhSOntLdyn/c0q1wtSgxbZ6UpB
 GVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690813261; x=1691418061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BCP/6rJR8Z4ywb61kGEudrHUFQ9M5QFvs6yWYM+1hSs=;
 b=lmv/fttCbGVMlGGYQPuiJjS41Q117uS7eRi4eGM+sXXEr8BnjlCmqtvmTXQz9UijOR
 br3Xx7yERqLh8d++V+IKIvTW3qCb+ipbgKnkdGjs8W8Rj/R+szTZ8QJIOJdfq0cyCY8F
 /3VUWykkzGou3Dt0ELGDYem5F5E11ABi87njw5tkZo7Nf9SAfKtDH56w5PyA5Ia7lJ1A
 MEBZC0MvdcpJmFZVlQJs/ly0gTxoXZpWdDSMqiZLWcPLh4WI/mNe8VV9Sbafllm8hdR0
 7xC+X4x6Rp+wmN0EIYx2RSgF9TIOY4dzhPwQzgEV3sJRB2E0gtT8rjxWCDyUQ9x/jw0B
 EBFw==
X-Gm-Message-State: ABy/qLYr7iI/IOidPiUSKyaUB9fW9SvIMO+DnTqoaLjKAFA2Cqm6syuR
 6Zu3X8uC5kKcxVV9ZX9CjuzJIw==
X-Google-Smtp-Source: APBJJlEvWlG+ufLkmNxRqeaX4PL9VtJHBR63mQOxEVt/pETljqjP/bD4e+sxXAbmUa8B2OMWZUlVIQ==
X-Received: by 2002:a05:600c:2286:b0:3fe:1871:1826 with SMTP id
 6-20020a05600c228600b003fe18711826mr55340wmf.27.1690813260896; 
 Mon, 31 Jul 2023 07:21:00 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.198.42])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a7bcc11000000b003fd2d33ea53sm11700610wmh.14.2023.07.31.07.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 07:21:00 -0700 (PDT)
Message-ID: <835a0b9e-6477-941a-743c-eda3a6a15eb6@linaro.org>
Date: Mon, 31 Jul 2023 16:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 3/6] util/oslib-win32: Fix compiling with Clang from
 MSYS2
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230728142748.305341-4-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 28/7/23 16:27, Thomas Huth wrote:
> Clang complains:
> 
> ../util/oslib-win32.c:483:56: error: omitting the parameter name in a
>   function definition is a C2x extension [-Werror,-Wc2x-extensions]
> win32_close_exception_handler(struct _EXCEPTION_RECORD*,
>                                                         ^
> 
> Fix it by adding parameter names.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   util/oslib-win32.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index 429542face..070bb455d3 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -480,8 +480,8 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr *addr,
>   }
>   
>   EXCEPTION_DISPOSITION
> -win32_close_exception_handler(struct _EXCEPTION_RECORD*,
> -                              void*, struct _CONTEXT*, void*)
> +win32_close_exception_handler(struct _EXCEPTION_RECORD *exrec,
> +                              void *ptr1, struct _CONTEXT *cntx, void *ptr2)

Per https://learn.microsoft.com/en-us/cpp/c-runtime-library/except-handler3:

-- >8 --
diff --git a/include/sysemu/os-win32.h b/include/sysemu/os-win32.h
index 91aa0d7ec0..cb42508745 100644
--- a/include/sysemu/os-win32.h
+++ b/include/sysemu/os-win32.h
@@ -260,8 +260,9 @@ ssize_t qemu_recvfrom_wrap(int sockfd, void *buf, 
size_t len, int flags,
                             struct sockaddr *addr, socklen_t *addrlen);

  EXCEPTION_DISPOSITION
-win32_close_exception_handler(struct _EXCEPTION_RECORD*, void*,
-                              struct _CONTEXT*, void*);
+win32_close_exception_handler(struct _EXCEPTION_RECORD *exception_record,
+                              void *registration, struct _CONTEXT *context,
+                              void *dispatcher);

  void *qemu_win32_map_alloc(size_t size, HANDLE *h, Error **errp);
  void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp);
diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index 429542face..19a0ea7fbe 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -480,8 +480,9 @@ int qemu_bind_wrap(int sockfd, const struct sockaddr 
*addr,
  }

  EXCEPTION_DISPOSITION
-win32_close_exception_handler(struct _EXCEPTION_RECORD*,
-                              void*, struct _CONTEXT*, void*)
+win32_close_exception_handler(struct _EXCEPTION_RECORD *exception_record,
+                              void *registration, struct _CONTEXT *context,
+                              void *dispatcher)
  {
      return EXCEPTION_EXECUTE_HANDLER;
  }
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


