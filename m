Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A76775F81
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 14:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTiYS-0000d9-PF; Wed, 09 Aug 2023 08:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qTiYN-0000c9-UC
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:44:44 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qTiYM-00053w-Av
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 08:44:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe4cdb72b9so38663565e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691585079; x=1692189879;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HzxjJI06QVK0ZERHty9VicTRXeoE8EIx9KWh/tywwxg=;
 b=JhYmO/zcpv3dW78hzsN8L9nofpgM+YNzeTA2BvGCa3/cVSNtwmuCGNOVi88tA9yM1M
 oQjSXLI0uOD8nq9zixsq34MlOozdDI/0pgMTSUoB/BYnlmLJz5w7sZaVC155JgV8YWDU
 0dgi0eQh/ucfDH8MJxBftLoMKjx3jGI9R+zxoYDzQCOEBC4ioltlOba8U6zxcMRuTPpj
 gFeOMW/ghSxLbyRCabg0LSOp7CuvdGWzSPdhNIFzq0x9AKBxHNbvwDvlvZUgbENKTcRT
 DlFKnRgG896pEyBQ0bNHUcQkvU3ArfMGaSgVLbc6O0OyDGtUocrBHHCW1v3AYol8LOIF
 L9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691585079; x=1692189879;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HzxjJI06QVK0ZERHty9VicTRXeoE8EIx9KWh/tywwxg=;
 b=d+yC//7qVjpMgusEXy2S1YPL+w/hSEVJfSK1CSXIgOBTkPgP1laPz3p0/eGdARVecg
 E+Eam1rlRo1LREzX+3xrb7A7wUGTJrTRDvQadG5VG+Xt3snCbC508RocMFJ40XtJ7tKv
 nvMMrhgYd9zhLDDmJrAc4FEgDcw4t7K9C+HtXSDxBDisxMbHp8YK3WFt9TmCTGbkel+R
 iMtF8TnF+HB6xgVTeR7Fvulme1I6tOka0Ak27rqPs/fEF8nsc79fxuDiQS1yFlBy+2O9
 dexWSWISpf3Rdx/uH/SmYyEflK0zNMaFStwQuLR/ZEHiFr5UYZo/XyIFF+cVuvoVWHMo
 Pnfw==
X-Gm-Message-State: AOJu0YxCcoD5uJU9xZmEPIhsMcluP/c3kV87j4xKUFjvlhtGQ1bUJaDo
 qLuKYPk4PuaXp2SVaT0a2pg8faj0GKtPEyd1ypSHfQ==
X-Google-Smtp-Source: AGHT+IGVv/O2UFrAgzzwsvzwL5s8RqfentALEOWwlEpm4ruc3NfYYMlOG7a6PYuMQhWZ7Ue8+jFf1g==
X-Received: by 2002:a7b:c458:0:b0:3fe:1f2c:df2b with SMTP id
 l24-20020a7bc458000000b003fe1f2cdf2bmr2061076wmi.11.1691585079467; 
 Wed, 09 Aug 2023 05:44:39 -0700 (PDT)
Received: from meli.delivery (75.53-176-91.adsl-dyn.isp.belgacom.be.
 [91.176.53.75]) by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c220a00b003fe1ca92151sm1947983wml.26.2023.08.09.05.44.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 09 Aug 2023 05:44:38 -0700 (PDT)
Date: Wed, 09 Aug 2023 14:24:10 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Yeqi Fu <fufuyqqqqqq@gmail.com>,
 alex.bennee@linaro.org
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Yeqi Fu <fufuyqqqqqq@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC v4 01/11] build: Implement logic for sharing cross-building
 config files
User-Agent: meli 0.7.3
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
In-Reply-To: <20230808141739.3110740-2-fufuyqqqqqq@gmail.com>
Message-ID: <z4jee.pl8rqox2wvup@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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

This patch needs a detailed commit message, since it's not obvious why 
these changes are made at all. It'd also be helpful for reviewing.

General style comment for shell scripts: Always put curly braces around 
variables even if they are unnecessary. a $source_path could become 
$source_pathPREFIX in the future and instead of ${source_path} it would 
expand to ${source_pathPREFIX}.

On Tue, 08 Aug 2023 16:17, Yeqi Fu <fufuyqqqqqq@gmail.com> wrote:
>+tcg_tests_targets=
>+for target in $target_list; do
>+  case $target in
>+    *-softmmu)
>+      test -f "$source_path/tests/tcg/$arch/Makefile.softmmu-target" || continue
>+      ;;
>+  esac
> 
>+  if test -f cross-build/$target/config-target.mak; then

targets will never have spaces but I'd still double quote ${target} for 
consistency and style


>+      mkdir -p "tests/tcg/$target"
>+      ln -srf cross-build/$target/config-target.mak tests/tcg/$target/config-target.mak
>+      ln -sf $source_path/tests/tcg/Makefile.target tests/tcg/$target/Makefile

This ln definitely needs double quoting.

>       echo "run-tcg-tests-$target: $qemu\$(EXESUF)" >> Makefile.prereqs
>       tcg_tests_targets="$tcg_tests_targets $target"
>   fi
>-- 
>2.34.1
>
>

