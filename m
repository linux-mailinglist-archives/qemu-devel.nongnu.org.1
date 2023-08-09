Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F25775FFE
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTikB-0005Bh-C3; Wed, 09 Aug 2023 08:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qTik9-0005BH-15
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:56:53 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qTik7-0008Rk-CR
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:56:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3175f17a7baso5101447f8f.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691585809; x=1692190609;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=dcYS0Wd/jw+aWeI1jT+vtv/OqXYGSYwSV0tZ70QuqCI=;
 b=o818Up4vdTZNg/P9kFjWuLsmfBZVlJN0j7rW8i8jXBoMr6156OtKoG/pKh2gVlZ1ej
 JTLYHMjqcFGuAiaGc85Ki437pwKdgV5qusqnL2s7N69lq8lxbLRHAdkImV1lDVdG5kBF
 w4rlVamGp0z3Nic/uouMw+9UwgZRy3ER7fo+8TwNsr/5rjDiEhERO39C8sGwTdIAslCz
 MbYNukqbKrq/WqVMRlfs2VzuRxQ74NN0Oc3BPTh6xB2rdJkjQ2UoOUPs/nAxrzbPQdLz
 xpUBUq0+ahchVvnXWKw5HvmH4iOqSRtGM7g3gyhC2MIeo+NziNjcc3cbvHbU5JeYieE1
 Hvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691585809; x=1692190609;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dcYS0Wd/jw+aWeI1jT+vtv/OqXYGSYwSV0tZ70QuqCI=;
 b=QXrS+5SEpfW0LAClI0Dx/hrlsnAuSFxIW9Yijnkei0gnzg6K6NF4izNdoWYUeNlC46
 AanfOIvwyZnOCZc0lcgyvTyJBhxR0/BNYzAKKMpHgxdsqorp+hKz/ijniyZHzciCOMy1
 if8pSHQq6CqzgocfjAGuyGtzQ4jX2EsOZVvtinIShxgwxKMeTlSTfYjNvuae2BZb8A0+
 z98yumCyjTpejPuCxibq7AfEETYoeG3mvoffuzcxyUU5v35AI5TOPYNa7BKIEjROM+nZ
 CPDwr1HxMUA3HK2OznkQVkZ0rxWQEgIVR4rMyVX74tIgk1VPd9nZvTl7tBo54+7fuhkp
 0zbQ==
X-Gm-Message-State: AOJu0YxskwZpfR5tBphwXiI7yeUGBHvcYY/ETc5xwYvRVSSn0iO3GIyB
 1DeirfTJ+fLblNGH4yAiywSpUP5Oio14XcjrjuNimA==
X-Google-Smtp-Source: AGHT+IGFD8DZWq50vKeUpUjBqF2FiP/FsCdJKOZV8oVwCUNr7zawSxemtVfVit3WnvUXHKMeOXqd8Q==
X-Received: by 2002:a5d:6046:0:b0:314:10d8:b482 with SMTP id
 j6-20020a5d6046000000b0031410d8b482mr1852271wrt.65.1691585809423; 
 Wed, 09 Aug 2023 05:56:49 -0700 (PDT)
Received: from meli.delivery (75.53-176-91.adsl-dyn.isp.belgacom.be.
 [91.176.53.75]) by smtp.gmail.com with ESMTPSA id
 z14-20020adfe54e000000b00317e9f8f194sm9579795wrm.34.2023.08.09.05.56.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Aug 2023 05:56:49 -0700 (PDT)
Date: Wed, 09 Aug 2023 14:51:28 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Yeqi Fu <fufuyqqqqqq@gmail.com>,
 alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>
Subject: Re: [RFC v4 11/11] docs/user: Add doc for native library calls
User-Agent: meli 0.7.3
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-12-fufuyqqqqqq@gmail.com>
In-Reply-To: <20230808141739.3110740-12-fufuyqqqqqq@gmail.com>
Message-ID: <z4jyo.wmks0dt3bth1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 08 Aug 2023 16:17, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
>+arm and aarch64
>+---------------
>+HLT is an invalid instruction for userspace and usefully has 16
>+bits of spare immeadiate data which we can stuff data in.

s/immeadiate/immediate

With that fix, you can add

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

