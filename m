Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7870DFDE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1TY9-0006dg-TI; Tue, 23 May 2023 11:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TY8-0006dR-4J
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:03:44 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1TY6-00043P-Gw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:03:43 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-253340db64fso6887925a91.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684854220; x=1687446220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DVqxtjeMBePEoSH8KIIPUk0TPTfmmrqkmrhw8+PbQgM=;
 b=Z0ekEtKn7hybRRAA8TER19QV04ieFsZ35Anpk8u8yznmpmSGqNUllcLOb6xagMH56j
 /dvw0A6W//8hBlZydOfiEX0UjHHEI7rlGiTNcHeUwOPYfnE7ap2ENIO1ryiKwv2g9MH6
 DSjLLpSnE2Pf9kC3u7WX4ERKBxONppehxyCz6OdITlHnZjr2RsKvtMqBJMUJYDIBX+ze
 iPn29pIzD4OaGmDuH+OAWm21qEnucwVJ7c48/XOJr9EwrIC6LpmkiwMChPGzgq6Hroq6
 GbuNati0bf5DEYOa6HdpLhgA/qcE8z99xqaU1r/QvoA66bljqp6LEcNugONorw+Nvct3
 Kmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684854220; x=1687446220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DVqxtjeMBePEoSH8KIIPUk0TPTfmmrqkmrhw8+PbQgM=;
 b=U06GIXI/R8La+eEgQkmYYkA5ssynO4BDkOrVGtdsW90PvDfcDi+2K7QtXngWJtyngN
 O3HCEyIaozUcl2651E94kmw9SDzT3ASZuGqgukMSGzuzMw0ZhhssnMJXDEISfPKteztn
 vzwPPKPLFZ4J4iEFBI4xPqlGCcHE67/JphuYPPh26V5ntWuliOhMrXF1GPPtC93l5sX9
 KXYZaWPiFt7yuh6h85gyHnXrrEqv5UwlQtPLadBcwNM/cR8DpmMdWqNEv8FemSnJjtr/
 7FkrTd0PjviKXJxoVhY3lSGbu2mRY9cAVOQ1pwx1coR1wQZ2z2kGw4jWK1sgTXxQ1cpb
 eOlg==
X-Gm-Message-State: AC+VfDwdooqRWHEf/5ySr1HcXQJrwWuzUgr6oeCiodwtwnRKrMjHNQjs
 pNlAwPGryl+6vToP9cPH7Xfi4g==
X-Google-Smtp-Source: ACHHUZ4KjEfgiSWlZUpGvFF6MAnWSyD4NYdo3TB3KCqe3Qwsbi7tLZ9NRBm+XJWl+DCQ3rwpnjxjvw==
X-Received: by 2002:a17:90a:c082:b0:255:6174:1588 with SMTP id
 o2-20020a17090ac08200b0025561741588mr6392597pjs.42.1684854220512; 
 Tue, 23 May 2023 08:03:40 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 ch9-20020a17090af40900b0024df7d7c35esm5939603pjb.43.2023.05.23.08.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 08:03:40 -0700 (PDT)
Message-ID: <f1f64bb0-8c35-5653-5556-3acaa74f72ea@linaro.org>
Date: Tue, 23 May 2023 08:03:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/5] Use MachineClass->default_nic in more machines
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Max Filippov <jcmvbkbc@gmail.com>, Jason Wang <jasowang@redhat.com>
References: <20230523110435.1375774-1-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523110435.1375774-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 04:04, Thomas Huth wrote:
> These patches are required for running more tests with "make check"
> on builds that use "--without-default-devices". By marking the
> default NIC in the generic MachineClass, the main code can decide
> whether the NIC is available in the binary or not, so the instantiation
> can be skipped if it has not been compiled in.
> 
> Seehttps://lore.kernel.org/qemu-devel/20230512124033.502654-5-thuth@redhat.com/
> and the other patches in that series for more information.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

