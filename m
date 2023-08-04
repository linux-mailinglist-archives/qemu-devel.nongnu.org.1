Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A476F988
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:25:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnIe-0006rN-Sy; Fri, 04 Aug 2023 01:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnIU-0006p6-OR
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:24:25 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnIT-0001bv-7C
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:24:22 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3a741f46fadso1329193b6e.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126659; x=1691731459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ulANK/Raa2yHkL0nTj8LyiH0Jhs9skQSzKSJpK/fciY=;
 b=LNRa08nB3re6j9dGKCcwD7vaanjCh4fUEdGwhWG+0Nf7f7H8BgDPW/+0tALdIdPBt5
 csuwkpwC0XRkM/DuoVtF3n3uZTVUsAYrivF0mnxeEwBAZ6f5+2bOM/lCHRg2xKXO78qF
 C2l3V7jQVR/kCyX0TRYwW4RKp7IrTnRITB2laQjuOxDJlq4ucFkLYYgZ/pulYFJixqwQ
 kTQvw/Z/Z3j13O+25qi/qFcZVhfwXlzb4uCyABVMVs91dXrQjUTJvj4sci4NFSYdNNV0
 4Ok9v8spNI2YjFQdEZ5y5FHijhWYK6D81aXMMIyjXrHp3Ka218LAX/Pd/irfeDJXAV2F
 cbgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126659; x=1691731459;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ulANK/Raa2yHkL0nTj8LyiH0Jhs9skQSzKSJpK/fciY=;
 b=g6Moj9ybwOWdeLq+BfzaKMRvqjl3R/Ra2qi3+U7HD2LwfrzLWmHFU5J/08XpT/oKdO
 gFeJ1Y54CaqXp6BhepxGQo3p846DKxNqmTxZWRhXplRzxxz+Y5YNbsCDp/6nUi6dj8Tj
 9XAEkU8NTejp/Uwd9pXO/fxNBtZGJDwZxeyo6/l7DnbDPlEagGDt4E5E84hzrzlibcmY
 Lyh5egPEzCCMTDJVGy8gR5EIbgcgW0/CE3EHEPj/kTKNcp0Lj/ROS4RWjqN4p3DJy+4j
 IDnYggniW5e0LTj3RDmC6EFE2OuWpsmT6ixcRrJEwfkqpUOMkDPZ7zdQdWN/OLdeyu07
 J7bA==
X-Gm-Message-State: AOJu0YyI32tkYecPAvj8+UWA8xaGK7psFu5uSZyXpckBAgEAzRIlR9tT
 /B7mc5vNOd2XHy7XhCK73CK6IQ==
X-Google-Smtp-Source: AGHT+IGIl7mFvkVGpSgyZRyqdCgYap2P0RXRbRzniAwge8n5pBgE/b6Hvd1fKUXCWEzFwaBJ1rEpqg==
X-Received: by 2002:a05:6808:199f:b0:3a2:62f3:c2d0 with SMTP id
 bj31-20020a056808199f00b003a262f3c2d0mr1186873oib.24.1691126659665; 
 Thu, 03 Aug 2023 22:24:19 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 fm21-20020a056a002f9500b0068709861cb6sm701633pfb.137.2023.08.03.22.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:24:19 -0700 (PDT)
Message-ID: <37254a2c-a96b-81c8-2d33-92aee77bae19@daynix.com>
Date: Fri, 4 Aug 2023 14:24:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/17] linux-user: Use elf_et_dyn_base for ET_DYN with
 interpreter
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-13-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> Follow the lead of the linux kernel in fs/binfmt_elf.c,
> in which an ET_DYN executable which uses an interpreter
> (usually a PIE executable) is loaded away from where the
> interpreter itself will be loaded.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

