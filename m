Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B35673F88C
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 11:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4qM-0000Nh-Ip; Tue, 27 Jun 2023 05:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qE4qK-0000NX-Qo
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:18:36 -0400
Received: from esa5.hc2706-39.iphmx.com ([216.71.137.63])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qE4qJ-0004Ol-4z
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 05:18:36 -0400
X-IronPort-RemoteIP: 209.85.160.198
X-IronPort-MID: 300108997
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:7J4wZKPFZK5pcrzvrR0blcFynXyQoLVcMsEvi/4bfWQNrUom1zYPy
 zQXWm6GaarbZWugfd1xaIq+900A7cfXz9JhHAZtpSBmQkwRlceUXt7xwmUcns+xwm8vaGo9s
 q3yv/GZdJhcokf0/0vraf656yEnj8lkf5KkYMbcICd9WAR4fykojBNnioYRj5VhxNO0GGthg
 /uryyHkEAHjg2cc3l48sfrZ80sx5quq4lv0g3RlDRx1lA6G/5UqJM9HTU2BByOQapVZGOe8W
 9HCwNmRlo8O105wYj8Nuu+TnnwiG9Y+DyDX4pZlc/HKbix5m8AH+v1T2MzwyKtgo27hc9hZk
 L2hvHErIOsjFvSkdO81CnG0H8ziVEHvFXCuzXWX6KSuI0P6n3TEmqo0XEcsAtEh58FIDn9t+
 6MxIwoiYUXW7w626OrTpuhEg80iKIzyINpatCgxnXfWCvEpRZ2FSKLPjTNa9G1o14YeQLCHO
 ZJfMGs/BPjDS0Qn1lM/AZYumuuyrnPiNTBUtTp5oIJsuzCKlFwggeeF3Nz9ZcGuXc9fw3ek+
 0HM/DvcBU0WMoSc4G/Qmp6rrqqV9c/hY6oLGbils/JnnlCX7moUDhIQSB28u/bRt6Klc9dWK
 khR4zZ36KZrpRztQd76UBm15nWDu3bwRuZtLgHz0ynVooK83upTLjFsouJpADD+iPILeA==
IronPort-HdrOrdr: A9a23:5lmQaqyA5whPHY7rk+ZyKrPwo71zdoMgy1knxilNoH1uHPBw8v
 rFoB1173DJYUkqKQwdcLy7SdK9qFnnhPtICPAqTMuftWrd2VdATrsP0WKK+VSJJ8SZzJ8m6U
 4KSdkHNDSfNzVHpPe/ygm0euxQo+VvoJrCuc7ui01gShwvV7th6AkRMHf9LmRGADRcDZ0iDZ
 yG+6N8xwaISDArddi/BnFAdeDGvtXKmpWOW29hOzcXrDSUkTap4PrCGwic2B8Scz4n+8ZazU
 H11zHj+qCiu7WDzxfA2GnJ6/1t6b/c49VeBMHksLl2FgnR
X-Talos-CUID: 9a23:CNMOLW1VBiu+GFDiaUIPRLxfQ59/InvH8yvpPmiHBnhKRuK8QmW/9/Yx
X-Talos-MUID: 9a23:+RLmbAiFUd2bhoQUeQlqHsMpK9pM+66kVXExzLYMuJahMnB8PW+epWHi
Received: from mail-qt1-f198.google.com ([209.85.160.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2023 05:18:32 -0400
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4025c7fba31so5308321cf.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 02:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1687857511; x=1690449511;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5S5Sc/3LZ+1++TQ1I0NqLGe2624ob6nHo/y/BztKGiQ=;
 b=CfQfy+kcH7kiUY+UoxH+oqamwZ2/0W3hEFpMOB4FsnxKXJAUk5PRTcsxtcPNS1NONg
 84LQdNjlbCjkLJO/hx5p+iG65YkN9R2UmV45V23oXJWkWfs5ruaXWPzPHERRyPdtO55g
 abwixsc6m43AngmZ460msf5bBpsvspLlYASyG6e5ve7aztRzZiSUkMFT/p7d9e7BOYFA
 kf+hg5A5QrVmdTg4psvlRMfO3+JmgOawOwHVxND5BFI/5FqOidqjDC4WPLMvk1MSGc3Y
 BGpPelnjVM3jwwJI3MMbYyMRc9r/Tez3868psV4OdZtbq3xto/NoLR0y/RgT9RW/hgZC
 lNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687857511; x=1690449511;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5S5Sc/3LZ+1++TQ1I0NqLGe2624ob6nHo/y/BztKGiQ=;
 b=XJoRAZU6bOjFz41owuFaWA/vtqR8gOisZOSt/bnz3HhLEbpczNBM7OEs+Xoh+Lpq4p
 CeJg9UTK/FE4emPN+mHfaLBEd8jk4T4EWtMXAwqnVvsQe7JeAmHVXWauKz6oMfk/ohF1
 E5KtGc920lEffJLTM16/6scwWumQvjNw+ftpNIIHiU/irpic7beYiqG6gUyr0nzoMHKG
 Xd+9dghiWhqm6fkLt0jLD4idPyKSQTyXZHevhp9Rvat9w7YHfb1bQZCgs1Z6+9INorOz
 6yd0ZL6oNwTYQllQQaOwqX29Cn1nTKIv0k5FcmSdSg1TAJO4pPB2ENqEgN3+tgmUSFo0
 tXJw==
X-Gm-Message-State: AC+VfDwVF/aZyBL4MPpruFWFAbJjFL3CtIUeyAXgeJG3+L6wVaxiLPAg
 V9PscVY24T4lYkHjd1w2ncdsYLlKQSLefdRU6UCen4uwa2MUI/2WFuBBP4FJm9HMg4p17FnJ89p
 Ts7UmRSW8CIZUnobe/Buk4TlPMd7QKQ==
X-Received: by 2002:ac8:5c50:0:b0:3ff:466b:da7 with SMTP id
 j16-20020ac85c50000000b003ff466b0da7mr20010152qtj.45.1687857511514; 
 Tue, 27 Jun 2023 02:18:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5jAHWDUiFAnH2yrB/bk38APdO15GUDtyrr1F9l7pgdBLsbL03tzEqjTjZcpRM6ExqwGb2YnA==
X-Received: by 2002:ac8:5c50:0:b0:3ff:466b:da7 with SMTP id
 j16-20020ac85c50000000b003ff466b0da7mr20010108qtj.45.1687857511241; 
 Tue, 27 Jun 2023 02:18:31 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 j7-20020ac84c87000000b003ff654694b6sm4268578qtv.46.2023.06.27.02.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 02:18:31 -0700 (PDT)
Date: Tue, 27 Jun 2023 05:18:27 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Riku Voipio <riku.voipio@iki.fi>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Peter Xu <peterx@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 09/26] tests/docker: add test-fuzz
Message-ID: <20230627091827.5zil4m6anxwmrulp@mozz.bu.edu>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-10-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626215926.2522656-10-alex.bennee@linaro.org>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.63; envelope-from=alxndr@bu.edu;
 helo=esa5.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 230626 2259, Alex Bennée wrote:
> Running the fuzzer requires some hoop jumping and some problems only
> show up in containers. This basically replicates the build-oss-fuzz
> job from our CI so we can run in the same containers we use in CI.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thanks

> ---
>  tests/docker/test-fuzz | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100755 tests/docker/test-fuzz
> 
> diff --git a/tests/docker/test-fuzz b/tests/docker/test-fuzz
> new file mode 100755
> index 0000000000..7e506ae1f6
> --- /dev/null
> +++ b/tests/docker/test-fuzz
> @@ -0,0 +1,28 @@
> +#!/bin/bash -e
> +#
> +# Compile and check with oss-fuzz.
> +#
> +# Copyright (c) 2023 Linaro Ltd.
> +#
> +# Authors:
> +#  Alex Bennée <alex.bennee@linaro.org>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +. common.rc
> +
> +requires_binary clang
> +
> +# the build script runs out of $src so we need to copy across
> +cd "$BUILD_DIR"
> +cp -a $QEMU_SRC .
> +cd src
> +mkdir build-oss-fuzz
> +export LSAN_OPTIONS=suppressions=scripts/oss-fuzz/lsan_suppressions.txt
> +env CC="clang" CXX="clang++" CFLAGS="-fsanitize=address" ./scripts/oss-fuzz/build.sh
> +export ASAN_OPTIONS="fast_unwind_on_malloc=0"
> +for fuzzer in $(find ./build-oss-fuzz/DEST_DIR/ -executable -type f | grep -v slirp); do
> +        grep "LLVMFuzzerTestOneInput" ${fuzzer} > /dev/null 2>&1 || continue ;
> +        echo Testing ${fuzzer} ... ;
> +        "${fuzzer}" -runs=1 -seed=1 || exit 1 ;
> +done
> -- 
> 2.39.2
> 

