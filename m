Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F053E715FE3
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:35:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yZK-0001CC-09; Tue, 30 May 2023 08:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yYk-0000rs-0k
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:34:42 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q3yYh-0002CC-Uo
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:34:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3078a3f3b5fso4303551f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685450077; x=1688042077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cubOGQyCCJasrYp/RJ3aUpJA52BQgzLpy0ZOYvw5bfA=;
 b=S6E/lmLPh5vvuYf3VkZT1lbmezEL6OnkdCOjY/+dd3xSCfMrXYSh9rxYyJnBRInIZJ
 w9WvMV7SbZHYyaV0KD750qEKc7WUIxqv1rM3ynPZI86d6LOs0zv7s0451nUzxo9wCDBO
 mK1OFOPWRKNUVmyvTTSr51qpCMoQbyBL07C5q2djdobx7n10Ga+XNBQh7QOWrQKm7lxH
 Ej4/JId8sDIo02GKb0w+l/XTSHv9ylX3crzWcPHVAGA185baV46LWxCwmwZhs8Z8ffoK
 5sbBfzg8NnYno9d9OBTh/8n3ecASUbqq87jIOR6mpG27D+Oj+AKZ2YClVenn3Q/YbH6s
 jfiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685450077; x=1688042077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cubOGQyCCJasrYp/RJ3aUpJA52BQgzLpy0ZOYvw5bfA=;
 b=GrNL3u2XQlAtY24nBVbdv0lTJ4XYe45uH3ZBZ0Jhrn2EJ58pa9BFm+MRnittw6gBfU
 7VjPgwU7g8gYE95j+StbMNbH5H4cS09JR61dAfXASA+6DSiw4Qpr8ZzUCiv5JLvlx84M
 FEku9PwhjMhwyOgv8d6994dWGqA0AzB4P5yE+9DHktl55uqZ0ejCjNzeYxxXXPnnnnWa
 u1mzjmlMDQvujYyxjVCGTkOxltYGpDd0ppYl8y1BZL8AzlvTomnnaFqEMPINPbyNg82P
 YdaJ4qB0kYRzSPJaTvJnLCIzN18gd9ZwmlzKhrBtSyBNm7p+VWt5lPF9ZBUZOw5bWzTn
 fxUg==
X-Gm-Message-State: AC+VfDw3WHeN5Ky+sirtmlh4SD9PATbM/S6te8adlvX+MogUqKK2XA4E
 oUfnBifDD9j/BLndLIezvGxlnw==
X-Google-Smtp-Source: ACHHUZ7CSLf+pt26gVsJQy/kJlTtAP5o4TfxYQKuFO0fmxiA1FNlCZdNWP4IKZWkXj6B5Mbk7/IS+w==
X-Received: by 2002:a05:6000:1c7:b0:30a:e6d4:f2b8 with SMTP id
 t7-20020a05600001c700b0030ae6d4f2b8mr1388537wrx.25.1685450077508; 
 Tue, 30 May 2023 05:34:37 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.180.1])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a5d4bcc000000b003062b2c5255sm3217493wrt.40.2023.05.30.05.34.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:34:37 -0700 (PDT)
Message-ID: <8f54dbb5-b005-2154-b323-e75e67ec6d12@linaro.org>
Date: Tue, 30 May 2023 14:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 11/16] migration: migration_transferred_bytes() don't need
 the QEMUFile
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Peter Xu <peterx@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20230530122813.2674-1-quintela@redhat.com>
 <20230530122813.2674-12-quintela@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230530122813.2674-12-quintela@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 30/5/23 14:28, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>   migration/migration-stats.h | 4 +---
>   migration/migration-stats.c | 6 +++---
>   migration/migration.c       | 6 +++---
>   3 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


