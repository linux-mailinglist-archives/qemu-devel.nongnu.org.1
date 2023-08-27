Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAB578A15A
	for <lists+qemu-devel@lfdr.de>; Sun, 27 Aug 2023 22:19:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaMDE-0005L1-65; Sun, 27 Aug 2023 16:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaMD9-0005Kq-Or
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 16:18:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qaMD7-00074Y-It
 for qemu-devel@nongnu.org; Sun, 27 Aug 2023 16:18:15 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401187f8071so15965385e9.0
 for <qemu-devel@nongnu.org>; Sun, 27 Aug 2023 13:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693167490; x=1693772290;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5JwKQPKzLFbQaO2GRnHlFb9f1n5OV8iirp8sj2u2wQ=;
 b=RaZLDkSbslldL26aMkzvsgDItP4300YB5eg03g1icJD6aEO/3XnDN7YUuyHB0NDHHd
 5ofklx/8njZTBxuisRJS9lB3syuSgg120Ca5n4SquBS8p1ofXFj4dKvpUjPz+ft/XoYM
 oiy/POAHQ8c2qwhKLBBnRfGEs7xDwNPqqte1XmOEJdphcvckPU+uoi3HY/8q9Rw1uRSq
 j0B8/PIaTOzpW8YkH1C+/hu+nq9VUmasxGzRF0af9gVtz51EYx9jH+Y9ggskJOPKoM+Q
 H9Xie7oGnS83G81u5ojIuc+NCqbhqE3U0Oig6m8/b0gGZ5ZCKsnT3uOSNGbWft/ATGoF
 X3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693167490; x=1693772290;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=K5JwKQPKzLFbQaO2GRnHlFb9f1n5OV8iirp8sj2u2wQ=;
 b=M0VCbtk7bvReaMD1wi69kqu3lpHo7pWA9QoMwAlbzdjaRpQvDVAMUdLwPqs8t3BwuX
 En+7nUUO7sjN9d4SIv2pONgNIc9/2clvufVQWDvMQYx9A2FgkjnRTj5aVonNUsREbBi0
 9ml2s1MNkr4mWIb5IoGo+EFcwlV/kfcGgxlPfJWizK/SatwSwvczbg81G2Z2qY9NvgnL
 hB67fqv21+fj//30hdB1V8D7hoqTemcGlYusk/i8FKU5B7kLkzOTXfMOuDdO/ztZMwr7
 yP91mT7uQ4hKLBfM0Upvjkf791P9vrCNY+pHM29qSOw3YUw6PY1P8HKqplWAvSObJPBy
 7qsQ==
X-Gm-Message-State: AOJu0YyyVxSkeVnCrnyk1qVVq3wmGD3QhQuH7CGBwOYWLGvH1GMnKV+T
 qwmf1FBmaf3FxNlS5f7pjKSKDw==
X-Google-Smtp-Source: AGHT+IEsHxzqSQz/xIXPvgmyiUphyVgdYDOeEKNWFtBe3gwL0KdcHNCnhumFg+DNYdw4N0BZuOj46w==
X-Received: by 2002:a05:600c:2307:b0:3fb:c075:b308 with SMTP id
 7-20020a05600c230700b003fbc075b308mr18840130wmo.12.1693167489953; 
 Sun, 27 Aug 2023 13:18:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 13-20020a05600c024d00b003fe2bea77ccsm8704848wmj.5.2023.08.27.13.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 13:18:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2835B1FFBB;
 Sun, 27 Aug 2023 21:18:09 +0100 (BST)
References: <20230826232415.80233-1-richard.henderson@linaro.org>
 <20230826232415.80233-3-richard.henderson@linaro.org>
 <2f239df2-5cdf-9eef-98af-b208d3ead39b@linaro.org>
User-agent: mu4e 1.11.15; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH 2/3] softmmu: Use async_run_on_cpu in tcg_commit
Date: Sun, 27 Aug 2023 21:17:48 +0100
In-reply-to: <2f239df2-5cdf-9eef-98af-b208d3ead39b@linaro.org>
Message-ID: <87o7is44u6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/26/23 16:24, Richard Henderson wrote:
>> +static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
>> +{
>> +    CPUAddressSpace *cpuas =3D data.host_ptr;
>> +
>> +    cpuas->memory_dispatch =3D address_space_to_dispatch(cpuas->as);
>> +    tlb_flush(cpu);
>> +}
>
> Question: do I need to take the iothread lock here, while
> re-generating the address space dispatch?

Does it regenerate or just collect a current live version under RCU?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

