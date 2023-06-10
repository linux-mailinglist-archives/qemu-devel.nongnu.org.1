Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B76472AC85
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 17:16:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q80IY-0005jN-RY; Sat, 10 Jun 2023 11:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80IV-0005iw-HG
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:14:35 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q80IT-0005nC-F2
 for qemu-devel@nongnu.org; Sat, 10 Jun 2023 11:14:35 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b01d3bb571so13356215ad.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jun 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686410071; x=1689002071;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C1EOsK7gadUyhQcOQ7qCMR11eZzRlu5tKA6PaqX4ujg=;
 b=b0umLvSZXrER8UjAwEE99u7JJqOycMIr9c5wyBWRosRnldc9FsupD6wGiItPS1mutD
 p1Jaix82dTERK/jdG9jTLtitXC0GOibdrD+/gLl6LMc0f9g+3ECH4ROQgDgkCjHXvezS
 si0j3yWfFa/ns2TnjaOK5ZCM2Uhykwy3pwFHKiLVuAIeS0/tNMKB4H5kJdXbgqmnNVY0
 oyt7uNcexddtkUjK8kkgUj3edbSZbXiPZPSCY0cJiLDlvuv7qF42TRUGIIFIfmrMf7ld
 FzJMS9DqVL4A5RJdnq3bWjMP6wI7NJLCWGzh7H3Hz7BO2CuFP1FFugeo3oyEXbqA4Spm
 mVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686410071; x=1689002071;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C1EOsK7gadUyhQcOQ7qCMR11eZzRlu5tKA6PaqX4ujg=;
 b=lFqLg8cGHBfCiz2bIJKxUUPDLiw96vOXD74Q8h3phb8/sgNbrfY1iMsKmeuXcT1Iad
 9+8In0o4PN9mD2XxHYVgML9XfCwSy+YXjpx363UOZDsy18EfT7+j52Mrqy8jJ5yQn98k
 1GzZFtsXBkGRsz/zDhtS7xFUDxYdhbu5AZ7pzQmKo2CZoY6RB7KIwUPW4JRx0zho8VLP
 c3iNE2qAPBGWW5+2T2Q3qT577oLzD2trw3e3tlrqywDmDT9jqfEk9Nv90f2B8cqHeY+3
 CXfNCBL8SyMsatTSuQ1chMOjXO5sVThzQ5gK9j9QWJxy5j0+QDiysQsVR5qt+/esPLmy
 IuxQ==
X-Gm-Message-State: AC+VfDxtAJkmC/afa2DLZw/h28pTWI8NbhAWpPP/0RoGf+cKLmIeX2sN
 eg90nG3X8FMVVApEu100dAcY/3wBtD24XFHeE2c=
X-Google-Smtp-Source: ACHHUZ710x4Lrf1ZzE26ABrilAiJ3TbPE7Z0x9ffKaggpVIDlLtBf8ABSjTQOZ/0q+Kr4xl0RGi9wA==
X-Received: by 2002:a17:902:b489:b0:1b3:7de7:f83f with SMTP id
 y9-20020a170902b48900b001b37de7f83fmr2021823plr.26.1686410071580; 
 Sat, 10 Jun 2023 08:14:31 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:2db6:3c02:bd87:f559?
 ([2602:ae:1598:4c01:2db6:3c02:bd87:f559])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a17090a3e0900b00258f9597e9fsm4525035pjc.45.2023.06.10.08.14.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jun 2023 08:14:31 -0700 (PDT)
Message-ID: <39723809-6201-d4db-1a09-8171f6ad4139@linaro.org>
Date: Sat, 10 Jun 2023 08:14:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/6] target/tricore: Add LHA insn
Content-Language: en-US
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20230610105547.159148-1-kbastian@mail.uni-paderborn.de>
 <20230610105547.159148-4-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230610105547.159148-4-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/10/23 03:55, Bastian Koppelmann wrote:
> Signed-off-by: Bastian Koppelmann<kbastian@mail.uni-paderborn.de>
> ---
>   target/tricore/translate.c       | 14 ++++++++++++--
>   target/tricore/tricore-opcodes.h |  9 ++++++++-
>   2 files changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

