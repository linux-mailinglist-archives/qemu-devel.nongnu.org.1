Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A779B157
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 01:52:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfqh8-0002oh-5C; Mon, 11 Sep 2023 19:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqh2-0002oR-Ux
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:51:48 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfqgx-0008DN-Cq
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 19:51:48 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68fe2470d81so498852b3a.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694476301; x=1695081101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+qJJTuoYkk08Q8HTLqL7yM+zwzmMMMk+2mjraQjh32A=;
 b=X+cPZoA/n7PDK/K7yeW255HXhuutD80tNR29fMqxkHr/GnMAr5WUnljZQ2iL0bVVCQ
 JddClUOAsJpcgxU4Ulq6OzzPGYthEMUUpD8+QCW8jCPqeZcXRJvfhkc/C3GPXaSVzLD8
 riS9Kkqz2fo6k4gJ4wjNoZsd+0PqAoVglzI/Ax7K0g7DXejNr8fPzoxXZxZTXB+nnnkp
 CGpRTvTcjpgIfFvTb/JkzOMqu7tYX9VgcvOj/5bOCz5avd97TF3HiZXmWcJ+fGmdq3qG
 XAbl38IyNcSoRc3fphOdyrI9w7YXiCLKrepmOOKV3m9Ro13kEt0Ep8uWsdv0oR3gf5LC
 FRFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694476301; x=1695081101;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+qJJTuoYkk08Q8HTLqL7yM+zwzmMMMk+2mjraQjh32A=;
 b=nZIjXP9DGBxmLpJG3UeEZkP0cD+SNzQv8iugQ64lAeB0kx8H5sjwdce7S9v3ua+Rsm
 uLnAXWe7BKlTkXw0h8yItaEOQjAAB5sIhWXJEIfYpeNmR9VGQUyGb7W3ROe2MS10VZD2
 od9JJ1NDfj+E2aX7hy9tOLu81uf9UVjv/Rd9rSB07N9ExqoMZodTYWQQ5cod3vicrL58
 1vNHIopVZUYKY/k9dNQ+4hV9pfybM302r/5Qh45oPOZU/3gHnAWQdOUS+JtGOrpup2Yz
 lu9O3Y+i5176sEGQmdMPzaRkWGWjLGwoU31R2ycrgkERji6Cx8tLtAdJ0Gs9SEbdjSXm
 A5cQ==
X-Gm-Message-State: AOJu0Yx6r1UGf5TrKJDZ0kty7Kzu1l3FUpoK5AVTm6XMcUnD/vEEzB/1
 1UmCLhdu/9jwjKlAlA/2A2ca3A==
X-Google-Smtp-Source: AGHT+IG1/lS5StM6gdI6TeGQn4vRtciBlDDRQGWj66s9RqZxcscFhU6kDZjcT/3P8ukguUDQA+2FRA==
X-Received: by 2002:a05:6a20:8e06:b0:140:61f8:53f3 with SMTP id
 y6-20020a056a208e0600b0014061f853f3mr15029884pzj.21.1694476301516; 
 Mon, 11 Sep 2023 16:51:41 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a170902bd8a00b001b9e9f191f2sm7039728pls.15.2023.09.11.16.51.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 16:51:41 -0700 (PDT)
Message-ID: <58a9b5e7-c1a3-2729-bc27-7c3d758ca086@linaro.org>
Date: Mon, 11 Sep 2023 16:51:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 05/23] bsd-user: Implement shm_open2(2) system call
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-6-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230909193704.1827-6-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/9/23 12:36, Karim Taha wrote:
> From: Kyle Evans<kevans@FreeBSD.org>
> 
> Signed-off-by: Kyle Evans<kevans@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-misc.h    | 42 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c | 13 +++++++++++
>   2 files changed, 55 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

