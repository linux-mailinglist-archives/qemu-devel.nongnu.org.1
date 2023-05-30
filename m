Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F39F8715F34
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:27:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3yR2-00007g-Sc; Tue, 30 May 2023 08:26:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yR0-00006d-Oj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:26:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3yQz-0000JQ-77
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:26:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5147aee9d7cso6179419a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685449599; x=1688041599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5eWQJL+mF2LJ72zBTYOzXce0OnrQOtwB9QtQWnw1fOc=;
 b=HOoTRS6KLBjeXHXp7wtlOKidVVqEpMTfSExe0kjzlEd2W3r0YYRBvd2uFyU9PQZI55
 Ingt6KFt+oAbU/y0uzqhukK4LwQOUN9d1g+10cHB9jrNgur1qigCBWHVil2tj4tL8rpr
 +odHGUAi9xeQFHbfZKIv0spWpvmm16TDLqXnWTLroZvkOvd9PaCVphq2CyZFF8pv2njw
 nkt4E44ZwaZ6c1cKqoyftqM+bKr3CBRr2ILbeV7PiQvcjUOLmNr4qVy7qw7P9Zjtqisi
 19SkLKZILmS5l2y4JtzUkorg9pwhIFVoT6fxU5WeVNdoZ6eDfi+VcPBmz8dtfZmGZqaC
 gTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685449599; x=1688041599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5eWQJL+mF2LJ72zBTYOzXce0OnrQOtwB9QtQWnw1fOc=;
 b=Ijt5nC2BAJmOyGHbb5zLvqN+svUECVnGvzJ4zJ2to5oypvsW6aYdxesFioEfdUPNHq
 kMT51FqL+4V4cD8tNDtBDmx9mfEG9b7kjswCGvYCM9Ey4Cpf0u9nrCkQlF3M5J23F/8p
 FXJfoCSCCyeNdfWxYqHg5QD1TPVunhq63mO4+Qr5I2B01PZSEnq1o1xdxmOVb5onjUbj
 4NGE/iiwemQ17DYkTGAtCFFfzpEiuQCneXIRHrxRYoJB/iQAKOVHewu/CLu/yxlNM+yG
 fhcWktxUJ95skS382MFZJzmOWvH6ajABmB9JxepJD5KJWkvke7lfIjmlgi1MMJxJ0ENl
 OBQg==
X-Gm-Message-State: AC+VfDw+AoKMmxbSERhcto+FEBsyAJ2LfwPIMMFNzh3ayhpm9ru9Tb7e
 xCJk7wSlng152CLxvvJYyUbtmQzCyWMfQCKWGRZpwA==
X-Google-Smtp-Source: ACHHUZ7jyN7iBwhkrKsliFCd5GFUq/vZHHmDXSnMSfNoG69+8t90IuglY9vyt4eiPDMSgebLy8dqKK0r/nP6STX6Uv4=
X-Received: by 2002:a05:6402:b0a:b0:514:98c8:9d7c with SMTP id
 bm10-20020a0564020b0a00b0051498c89d7cmr1475963edb.4.1685449599300; Tue, 30
 May 2023 05:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <DS7PR12MB63096EDD683DE70EBC472E97AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
 <DS7PR12MB63098739F9B61D53062B74F6AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB63098739F9B61D53062B74F6AC7C9@DS7PR12MB6309.namprd12.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 13:26:28 +0100
Message-ID: <CAFEAcA_QEnUHEcPe8VwGatgrdOGTXq_kcA3CHWaSBeGTa4120Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] target/arm: allow DC CVA[D]P in user mode emulation
To: Zhuojia Shen <chaosdefinition@hotmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 19 May 2023 at 22:55, Zhuojia Shen <chaosdefinition@hotmail.com> wrote:
>
> DC CVAP and DC CVADP instructions can be executed in EL0 on Linux,
> either directly when SCTLR_EL1.UCI == 1 or emulated by the kernel (see
> user_cache_maint_handler() in arch/arm64/kernel/traps.c).
>
> This patch enables execution of the two instructions in user mode
> emulation.
>
> Signed-off-by: Zhuojia Shen <chaosdefinition@hotmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

