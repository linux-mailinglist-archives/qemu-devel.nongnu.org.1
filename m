Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AF7735885
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:27:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEuY-0001fA-0t; Mon, 19 Jun 2023 09:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBEuR-0001Y1-Ob
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:27:07 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBEuO-0008Ay-PM
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:27:06 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5147e40bbbbso3562084a12.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687181222; x=1689773222;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RhowFXpi1cFZ7sxyOGnudnNyzi3VjFDEKyZY08LIEfo=;
 b=Kc/teJsi/arOMSxQO3Lhkpxi+sYdrU5SPtvv+QZ/4kc+brJxRwagW79C8fehmJQoHS
 LjkO7xQ4c99a2ZdqJD7271/s0Jsy92UKPYkYQFXyTiGGLCl6l0ItZVHZddOu0/1Z6MWg
 bcoEKwEMpmGPSDAH78zOdSz3dyA30hJT5P7picSmqe23pdi6lfi/sZG3RhHyhhFl/TU+
 R+IaRmwedIpkCNRDw8W+NA+ES4gQyskbLBNgVq9VEWYNUIL0U58sQk2lUcjVXrnpEMUn
 bcdIb4wzylY2dK3PtAZZWu8ohMkQaJOINtuh9NPx8HI2LIIq7Ig+0pL1Ozv5Hx1k2zpm
 0jTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687181222; x=1689773222;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RhowFXpi1cFZ7sxyOGnudnNyzi3VjFDEKyZY08LIEfo=;
 b=LNE4XJLhpjuCfq3SqXp9MaZ8fJW+FghoKI3yi59YMZ1a+03DOni+Es7Ff/pnDE//ix
 4bYGHVtyYKhNMtEoIChXLloYX8Z+GxDKmC/RYEEsUOlUv/PI+BX34Yq44NDK8G4l9aAi
 MrwH1PN7ydPdrbccyaCsTJRgmPjzHn4i3yNjGWcki9h82V6NkXEtzRBy2gPfRscuFrDI
 nxjnJRKKy2a71qfKSmvs2su3AxzD2juSDXkgnPiwOPr7GUWrcwUQrHcSi9btfXl/JSjz
 /j90fQdkgyqa+RO1LCLKmeuRUTeispWgMNXtdQT21mTivU6i9+QUS3pY+5zK9hspPYyJ
 xh7g==
X-Gm-Message-State: AC+VfDzsnuGsz/9CzPk3sDfmV89yetP6gCOfmJL/9vX4kb/gktvN1Pwz
 mMOB3ZbA0vdcYZk7gDQhpN+9YjeDpM1Pz7QNDEPlix5Q
X-Google-Smtp-Source: ACHHUZ7R92SGRZwvVnmY+Jpf3z2YnNntRPWUocgO0Z7M1QpFNwLyS5TRQ30IcpDmcrGZYHMrZGLISg==
X-Received: by 2002:a05:6402:3da:b0:51a:42b2:cb83 with SMTP id
 t26-20020a05640203da00b0051a42b2cb83mr3610249edw.42.1687181222535; 
 Mon, 19 Jun 2023 06:27:02 -0700 (PDT)
Received: from [192.168.200.206] (83.11.39.176.ipv4.supernova.orange.pl.
 [83.11.39.176]) by smtp.gmail.com with ESMTPSA id
 u8-20020aa7d988000000b0051a4c1dc813sm2263007eds.82.2023.06.19.06.27.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 06:27:02 -0700 (PDT)
Message-ID: <dfd62e0a-6fb5-e93c-c2c6-d68025fb9999@linaro.org>
Date: Mon, 19 Jun 2023 15:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] hw/arm/sbsa-ref: add GIC ITS to DeviceTree
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 Shashi Mallela <shashi.mallela@linaro.org>
References: <20230606182414.637467-1-marcin.juszkiewicz@linaro.org>
 <20230606182414.637467-3-marcin.juszkiewicz@linaro.org>
 <CAFEAcA8eGEeMJwUSe5Ok9QvYUReO_awe3-+R5Vbc9MobDc2JLg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA8eGEeMJwUSe5Ok9QvYUReO_awe3-+R5Vbc9MobDc2JLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x532.google.com
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

W dniu 19.06.2023 o 14:55, Peter Maydell pisze:
> On Tue, 6 Jun 2023 at 19:24, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> We need GIC ITS information in DeviceTree so TF-A can pass it to EDK2.
>>
>> Bumping platform version to 0.2 as this is important hardware change.


> We should fold this patch into the previous one.

Will do. With "Co-authored-by:" tag as ITS stuff was done by Shashi 
Mallela while I did DT part. And S-o-b too.

> If we are bumping the version-minor, we should add something
> to the documentation that says what the difference between
> 0.1 and 0.2 is. (And if we can remember what 0.0 was that
> would be worth noting.)

Will rebase on top of target-arm.next once you push it with 
documentation updates.


