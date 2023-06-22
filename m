Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCA573A668
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNV0-0005Mp-OB; Thu, 22 Jun 2023 12:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1qCNUx-0005Ku-CJ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:49:31 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thiago.bauermann@linaro.org>)
 id 1qCNUv-0006ul-Nw
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:49:31 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fa74d06d72so7785945e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687452567; x=1690044567;
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fb1boCvjAsx9mWVXiB/4mB52CgFpGNj1KWlRTjdHkgY=;
 b=QGSzombm3WVNVMJ2GceMSHM+M0WwhJu7D9rGwmQbVrra/+XuOy8j06kdr/8Dag0fCu
 SnvijFcXXX3f1lePgd6FNPG8JX024ptuNGOZeALRMzTxDw0vp2VQbIC57+P1VNM76nHt
 hhVxf7U80V5IPGVZ+B1BGu7Zgxci/qY10/EPEU+5PICzwWm8aBbuLdiIgFHj9JPNL38u
 eGTIDcnixn5DayP0m3MtUVN0M0XDJwcTr9JGvFKuW6s2yQa3y1D0SchDh7QBhxHNc9p9
 IAXARH+IdzEDESnBdjXaUoMNA7PAgSvmvbYJDndVsY+rhAQd2vHF+86KUO8eMEEccAWE
 NlHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687452567; x=1690044567;
 h=content-transfer-encoding:mime-version:message-id:date:in-reply-to
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fb1boCvjAsx9mWVXiB/4mB52CgFpGNj1KWlRTjdHkgY=;
 b=P7RkUSAUMAyV+UQV3iaLgYps12Ou0Shzwk8EqihrqtMmjiwz9S2Vq1xCR3tGL95C4W
 iMqpUB8nNM7/FG0XBpsdxyjUjQ0TxVOISBF2vkQhdzSfghbjUpVE/YATPmFkctB9NPbT
 R7bULgsT/p/fTkCLz8gQ8Jopm3AZ8cznkV46oGd/t7YKTwqls9y2VtxBl12t5NVn5xRv
 vlD9OeeJn9eBhoNhJulSN1OeA5OmY5nB1OqdsXumnez1FcuLLykFFRBJRQrprW2HqBkG
 s/8kDLDqJicfRo4L2c09EIBQ91pDXdsJXOiepAhGLe3SsT+VMHg4cnERFqKB3QqsBWxX
 sbSg==
X-Gm-Message-State: AC+VfDx3wDtKrKr2Z636azu2C4YN7OwPLU3KvZR8m2SWPMf0PtzzcLpe
 eCGN+zBZLtb1x6F2cMTleYaDkw==
X-Google-Smtp-Source: ACHHUZ5UtQMVM4mX+RubsJJtsD4HZAjooiEwXzvZMkqg/FJFaQ4yIRhJsyoIE59PXTYDQbUp/D5NrQ==
X-Received: by 2002:adf:fc47:0:b0:30f:ca87:8e09 with SMTP id
 e7-20020adffc47000000b0030fca878e09mr2066039wrs.30.1687452567540; 
 Thu, 22 Jun 2023 09:49:27 -0700 (PDT)
Received: from localhost ([2a02:908:f60:bc60:5cc2:6b46:d8fa:2a2b])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a5d6581000000b0030fa3567541sm7368513wru.48.2023.06.22.09.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 09:49:27 -0700 (PDT)
References: <20230620175712.1331625-1-peter.maydell@linaro.org>
 <5b2bf86d-44fa-35ae-8049-b395d715adcb@linaro.org>
 <97cace68-b1d3-73f7-fa69-266ea0f36229@linaro.org>
 <780c8505-9cd7-87fd-c5cc-23f0e8aa455c@linaro.org>
User-agent: mu4e 1.10.3; emacs 28.2
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas
 Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Revert "cputlb: Restrict SavedIOTLB to system emulation"
In-reply-to: <780c8505-9cd7-87fd-c5cc-23f0e8aa455c@linaro.org>
Date: Thu, 22 Jun 2023 18:49:26 +0200
Message-ID: <87wmzvh27d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=thiago.bauermann@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Hello,

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 21/6/23 11:39, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 21/6/23 07:19, Richard Henderson wrote:
>>> On 6/20/23 19:57, Peter Maydell wrote:
>>>> This manifests specifically in 'make check-tcg' failing, because code
>>>> in cpus-common.c that sets up the CPUState::cpu_index field puts it
>>>> at a different offset from the code in plugins/core.c in
>>>> qemu_plugin_vcpu_init_hook() which reads the cpu_index field.=C2=A0 The
>>>> latter then hits an assert because from its point of view every
>>>> thread has a 0 cpu_index. There might be other weird behaviour too.
>> Why isn't this covered by CI, and where could we add a such check?
>
> Actually it is covered and failed on staging:
> https://gitlab.com/qemu-project/qemu/-/jobs/4503766933

Just for the record, it was also caught yesterday by the TCWG CI:

https://ci.linaro.org/job/tcwg_gnu_cross_check_gcc--master-arm-bisect/87/

--=20
Thiago

