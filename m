Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70927781E71
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 17:08:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXk1x-0003Az-CM; Sun, 20 Aug 2023 11:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXk1v-0003Ab-1r
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:07:51 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXk1r-0006JX-Tx
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 11:07:50 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so512196b3a.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692544066; x=1693148866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IgQ5j9DStC31gUgU4AeKIRfVM2UMWogdzdmNkmxJ1Lg=;
 b=ikrpvok4YHuETBEGomZ3xY/7TxXnjSZV/fug4R5nC/wWVSFCsTpj1fVCKWkmdS1PS5
 GihKoGsbASn7RhR7XZFTnFgf46VzXrP+xW0E7JKWRAopReT4v7qte8iRQN+PIQXszYpV
 nYrLPZ7ErbhXHYRgV5fiR87v1cun1ga1138cqkWcYES9SXYxHSeqKpAaEbb/ucrKiZHi
 /CvQCpa/27sOGzfKkwt6YcIpknKXO/3ItRpCO8Rj7GiBpEP4ENyA8FXztREAACdi7L8V
 pnvXOw8MdKQBedvbMO55G2use9VhGtMlOCY9CRFhGnNyROlA3zPz5EWnS4m+pn4QjTFa
 E/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692544066; x=1693148866;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IgQ5j9DStC31gUgU4AeKIRfVM2UMWogdzdmNkmxJ1Lg=;
 b=I8jiLI2od+3Ho4W+N/QxHUoU6GEGizlNMvElpqG5S3Cwb3wPbmKbOJeoLyFXXj9Lp3
 6zBOGupByxEyB8XB7qlHVPnUQEzW19o77+YOBGriPQMoePOO4O/tAZwt5qjOFZ/Wv5lP
 JDn7UVrMcnn4P6/Vn0stNJqV5Br5PLcdnfW0CSFK+l1R4kyXbCIBpvjATd4anGKkQEpU
 5EoKcYC2BM9tduBuLNOk+ZeFL7ruBv9wxaRcncZUihTaAehpwoQi+L0iUCav6wKiYHRe
 k32sGjqTzGqLqwH4NDYFDIY+egsiIUiZAHaZxOxHSAA2oWn4CneWn2qWD7e2EHIfrENK
 0cBA==
X-Gm-Message-State: AOJu0Yxv7miv/HxPkRKdqF+oFc13KsU0JsfCCxSnMLo2mN8XGh7locd1
 elD+zhKGdPBhCvPEmZrEC/LmEA==
X-Google-Smtp-Source: AGHT+IFWr8SnJ1reX4OacsnAnnmuBHcA2zqFQuqc+h2zo072oZI//Z3dDBJaf9T6z07JO4VqTIWfXg==
X-Received: by 2002:a05:6a20:1585:b0:13d:860e:e346 with SMTP id
 h5-20020a056a20158500b0013d860ee346mr6846356pzj.5.1692544066311; 
 Sun, 20 Aug 2023 08:07:46 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a633307000000b005642314f05fsm4827557pgz.1.2023.08.20.08.07.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 08:07:45 -0700 (PDT)
Message-ID: <a14d0ddf-98b9-e1c7-4b89-4af9cbc0d10f@linaro.org>
Date: Sun, 20 Aug 2023 08:07:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 19/22] Implement shm_unlink(2) and shmget(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-20-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-20-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:48, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++++++
>   2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

