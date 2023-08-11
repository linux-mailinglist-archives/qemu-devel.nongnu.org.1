Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC53778F67
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 14:26:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qURCh-0002Dz-BJ; Fri, 11 Aug 2023 08:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qURCU-0002CV-B8
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:25:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qURCR-0007j1-Lu
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:25:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so6278320a12.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 05:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691756701; x=1692361501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4aYHUM94VO3BDPln/7WJPRoSZyQ6oJgnhLNoV7ckoDA=;
 b=W+66tjE3TTjfaSeu8aewV2relsNCcXStzwCzuxE7gPdvA7lAiggBT3DiwM/mE+/As0
 OBdwtDmhqtoLNtcWL7EGAoCQKhr4Xgei2BS/30FuQGbISG6bszagA8c3rbilkqK0BfXA
 0VPZapFrV/sTVgkdZX4zwk2lNsESl4/wDN4koMkBc2/ZSXV9Gn15njDK6XIc60DlLWTD
 QPtmLeW0YzM2cIhxa90x5kyGUT4BPIMntGblEp77sBKrNrcNLq3FalayPHL++eqIXVU7
 Fwr85NTuretSVciPpwyyPpYNLUZq1/qThsNYT275nzBwS5P53VwbGyd6+jBsTQ2G+g7o
 HCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691756701; x=1692361501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4aYHUM94VO3BDPln/7WJPRoSZyQ6oJgnhLNoV7ckoDA=;
 b=cnbpTfF+uYFJNmNNSGOJYksXWgFHhknMMTK9fq143RZZFTR1Wuoe8IY6XbKGhKKHcl
 QxVMXuMfcJdsxzzFl5eUEM45sbwe9fEZq5GPFth+BKM9Wd80mD4xhF8/QCFiemRa4OFS
 TmSbqTxOH0kbKGV7V2DulrLoF+Hwbq0UTgG9aEzL4QCFyLlsazA5/0zrTFLhoU0ztcYM
 gbXKJDPVjNOXavsZ2UnMB2W7Ku7iPy8mwybIScOM+YnPelImbhA+1f3MDPHuIQWruw5H
 4IpNNkKVk/Qzt9KKNBrGVTB/18Id1mpBdzzIo9Tr/hv3kNwuJiPeSPRZ2Xg8NyH2W5sS
 zHvQ==
X-Gm-Message-State: AOJu0Yx+697QL2xHf5UazrOW8OuwAM8YmYAJNii421wPAd9gtE4KCq6P
 ZpDQc/zhq0v0uPI46xGA6hJTyNQituZbPePDcJ8r3g==
X-Google-Smtp-Source: AGHT+IGFVXUfAcdws8J5u6u+bAiGeoUqvhkt/pE4vmYpWhzQm5VZNn8oU2NWTaTQQ1hCDko7mFya8gQdPTxZoEvqPUU=
X-Received: by 2002:a05:6402:26c6:b0:522:ab20:368a with SMTP id
 x6-20020a05640226c600b00522ab20368amr6278244edd.13.1691756700333; Fri, 11 Aug
 2023 05:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-17-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 13:24:49 +0100
Message-ID: <CAFEAcA8FPkmcJM7evL6aCN4ZkQD76d6xaaOJXL=pB+Qq93rbZw@mail.gmail.com>
Subject: Re: [PATCH 16/24] tcg/sparc64: Implement negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

