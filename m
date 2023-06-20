Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E79737112
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:58:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBdkV-0004cy-Eh; Tue, 20 Jun 2023 11:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdkE-0004bm-Q9
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:58:15 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBdkC-0005zX-Ct
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:58:14 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4f7677a94d1so6562720e87.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687276689; x=1689868689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bX7xD1gi/Zj6TIgOtdEm/yhxqYg6z3RCy8XN1DX+kvw=;
 b=IIIUrse2r13BC62uNFUygApX6FrEMYYUTSY8k+9PEGIPXYutb+hRNhaNBwcsb5sTrw
 xQFRQhfgIBywrnhSYi2I6qWJ2clHWfD+zgPodxLIat3+/TbpBbv2Kz/N9+oOQeVwcho4
 I9wj/YDhd2WxzPc3DkLo3FzzwuFmn8nh3l15ax/md0/MLPQwFEM2g2mVgGkH0uK5t/pK
 XncQ3pglExhhFY/FznaxVgB9ecHC1O20yzMoSLYA413KqY2R6g+uPQA78v5Rl5Cqltf9
 fX/VM8EonVLBD4mR95E0hJZxb8KajF9yXPV8MbXuiwOAs8I0WfZjnMhh0q9jTox1BtPh
 gPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687276689; x=1689868689;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bX7xD1gi/Zj6TIgOtdEm/yhxqYg6z3RCy8XN1DX+kvw=;
 b=ZlIfGTegS8ZAQZNp4r6fMGjgm3KKVwVFSEae0FUFeKBZMh0C//v2/9tKVqb5KERuw0
 tZOOFW1CcvvFiDVoOjwVRlSh1LNfoppfvONqNOc+b+NigrUvW13sMDlIsz9uHnaTCCK2
 dGwl/Jh/DjaMgR0ylZKKzmamu2e4jShe7YrZq72niTGzpymnJK02l4HTvQQzWzN1vnsC
 Ep3cZlAxx9e59WFtO7tOkqkk0g4/m0aNH9cOrGljx3P1iOkqWTQUtT0PrGy812+elenW
 xk68ZoIuJymHPerqlYojg+BogSgWR1NC2y4ZT8jlhsg8wkYa9ce06oYQEYZohCr65R//
 Bw9Q==
X-Gm-Message-State: AC+VfDxOz58xlW5YtRmAvl7b/xeYTUp7jYH8x9iV2UCNUPuml4z5qdpq
 3UVbBNdnisWAVqqf5E1gDUPag48MH37mcSGIFCH0Cw==
X-Google-Smtp-Source: ACHHUZ5myQi4NBiO04UrN6DJ/I1PNwfLLVYa6RQjMgIE+ILtgixFMKn7K+TwfhczopD3TiUF2s0y19HeKaJnAh2rX4o=
X-Received: by 2002:a19:6558:0:b0:4f8:6abe:5249 with SMTP id
 c24-20020a196558000000b004f86abe5249mr4606846lfj.3.1687276689535; Tue, 20 Jun
 2023 08:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230620124418.805717-1-richard.henderson@linaro.org>
In-Reply-To: <20230620124418.805717-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 16:57:58 +0100
Message-ID: <CAFEAcA91RPvuC_GArpu=x3rEpv1-HsfdEOTGf50N7VY9ZwgtjA@mail.gmail.com>
Subject: Re: [PATCH v5 00/20] target/arm: Implement FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 20 Jun 2023 at 13:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Changes for v5:
>   * Enabled only by cpu property x-rme=on, not -cpu max.
>   * Rebase vs SecEL2 fixes, now in master.
>
> This doesn't have the magic RMM memory, which previous patch sets
> included for booting Huawei's forked TF-A.  Upstream TF-A does not
> have sufficient code to build either PLAT={qemu,qemu_sbsa} with
> the RMM enabled, so that can't be tested either at the moment.
>
> All I can say is that this doesn't appear to break anything else
> with x-rme=on.  Which is less than satisfying.

Have you tried 'make check-tcg' ? I get:

make: Leaving directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
make: Entering directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'
  BUILD   arm-softmmu guest-tests
  RUN     arm-softmmu guest-tests
  TEST    test-armv6m-undef on arm
  BUILD   arm-linux-user guest-tests
  RUN     arm-linux-user guest-tests
  TEST    semihosting on arm
  SKIPPED semiconsole on arm because MANUAL ONLY
  TEST    convd on arm
  DIFF    float_convd.out with
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/arm/float_convd.ref
  TEST    convs on arm
  DIFF    float_convs.out with
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/arm/float_convs.ref
  TEST    madds on arm
  DIFF    float_madds.out with
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/tcg/arm/float_madds.ref
  TEST    munmap-pthread on arm
**
ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
failed: (success)
make[1]: *** [Makefile:174: run-munmap-pthread] Error 124
make: *** [/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/Makefile.include:56:
run-tcg-tests-arm-linux-user] Error 2
make: Leaving directory
'/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang'

But I haven't run 'check-tcg' recently, so maybe that's an
existing bug rather than something in this series.

-- PMM

