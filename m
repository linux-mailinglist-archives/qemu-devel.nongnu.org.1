Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B674673F630
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE3X0-0003yK-T2; Tue, 27 Jun 2023 03:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qE3Wz-0003xh-8p
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:54:33 -0400
Received: from esa15.hc2706-39.iphmx.com ([216.71.140.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1qE3Wv-0007Vp-8n
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:54:33 -0400
X-IronPort-RemoteIP: 209.85.214.200
X-IronPort-MID: 284382986
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:52BYRa9lc2XGO1YAkfn1DrUDPnyTJUtcMsCJ2f8bNWPcYEJGY0x3y
 zMYXW6OP/eCMDP1fopxYYi+8BtQ68LdzNBnHQNtrnwxFiIbosf7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yI6jefQHeCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYqdDpNg06/gEk35q+q5mlH5gVWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVHmZkh+AsBOsTAbzsAG6ZvXAdJHAathZ5RlqPgqo
 DlFncTYpQ7EpcQgksxEO/VTO3gW0aGrZNYriJVw2CCe5xSuTpfi/xlhJBgqZr8B0NgqOmBf7
 cIGNw0LdCy4qtvjldpXSsE07igiBMziPYdaonU5iD+DVa5gTpfETKHHo9Rf2V/chOgURaeYN
 5dfM2MzKk6YO3WjOX9OYH46tO6sln/zaRVStRSYqbdfD237llwti+i3YYqLEjCMbZxwoHyHh
 GbYxD/4JhMTZMS4wAWi9m3504cjmgu+Aur+DoaQ7/NvnRify3IeDDUQUl20p+T/jVSxM++zM
 GQR8ysq6LA2rQmlFIGlGRK/p3GAs1gXXN84//AG1TxhA5H8u26xblXohBYYADD6nKfanQAX6
 2I=
IronPort-HdrOrdr: A9a23:wjv886BwlQWb6OTlHejzsceALOsnbusQ8zAXPh9KJyC9I/b2qy
 nxppgmPGzP+UQssRAb6KG90cy7MAvhHPFOkPUs1SnLZniShILFFvAY0WKA+UyfJ8SdzJ8j6U
 4IScEXYrCAaykCsS+Q2njELz9U+qj1zEnHv5al815dCSVBL4Fm4Rx0EBzeL01zSGB9dP0EPa
 vZwuACgjynYDAsbsq9DmQYROSrnayuqLvWJTotQyUq7QGf5AnJ1JfKVzyR3hI1UjtJxrsm6y
 zsjxH5ooWv2svLqCP05iv255RSstrozdxOAdbJsMQTJzn2qgvAXvUDZ1T7hkFEnAnEhWxA8e
 XkklMbJsJ15X+URW2xqQbs3Q6I6kdK10Pf
X-Talos-CUID: 9a23:o0zrdWCwoXjcORP6E3B7r3wNMP54SXzM1EnOPHK+E1pSZYTAHA==
X-Talos-MUID: 9a23:gfuHDwjn58h1+6rb3aM+r8MpbeJW2buMDF42ypQiucDULQt5BBCZk2Hi
Received: from mail-pl1-f200.google.com ([209.85.214.200])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 27 Jun 2023 03:54:26 -0400
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b7fd27e107so8883315ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1687852466; x=1690444466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iYsUDDZF71fmZPwovKwRMlCt04dLbouDq2b1Jpkhego=;
 b=nBpPssUcv0HCP+mOepBHW/b9kop8ggXBgueHa4h0HMBfBSwTJqg8xx0VyNJ80JFNjn
 pNGPfs+CJiTwCCcHhz74t67lrfqDaQePM69q69Xp5IxVEMcElbn8LmB9eNy3YoDT7VJj
 6x+iFptt80BBGp/0kR3pZin4+XWLxvqbPC6czCBshebonIaSGrgMQi8cB8thQMCI9i0G
 5/FZuEpq8uhphqKTz+kIKyBzlq+BQA0pYXkinfJFR5183hwx7H0DSNjQdxiJuQcZXl0g
 Tawn6I/iVuvabXqlTMdSm15eooDivoCD5CpguXTFxyuIuhVw3tKoHzvdCBH4ptaD67ot
 fYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687852466; x=1690444466;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iYsUDDZF71fmZPwovKwRMlCt04dLbouDq2b1Jpkhego=;
 b=Q6hCVldSUKI79t7YaaK0FdeLHTANylNqzLEq4abxcUQx1kEPC3IQKsLSIPWmMWJKJi
 CMM4HeAA11QHVrvywG7EJLAd65+n4ZPZuAdqsCQ8nDH7TOoL73PnIWcRDxPaomDT4gos
 rFcs299HQBGrQOV/dfWI+vidmdKtdFJXjl77wNUsge97xEUgl1h/MnPsYrd9GW8g0q7C
 fO7D/xhUhb0+WwniuwsVBZbvweTYZRqKtMridquxpxsaC4Bcw1Butc6Lun4Cs+UzcuJx
 N3MRkFUJxQc8GahAhXayXtPvwIMalw8r88DbopCixneX7WRFl99qzSH+8xRD5UIAubex
 z8Aw==
X-Gm-Message-State: AC+VfDxJ564GXPYgGqNuC1rq20oWG94cWF55yc7H5tn+vb6OrShLf2HJ
 fyyBz+ehSDnL+4uAqze/pXf/a8c4eoc+MSL1kXHvWK+FnjZS5hE6V2hhYy64nXZLAuZTO4Le1yJ
 V18hu2Ko/lSJdNiyYiyx20kvJ2gDckw==
X-Received: by 2002:a05:6214:242c:b0:635:e113:a0ff with SMTP id
 gy12-20020a056214242c00b00635e113a0ffmr5725017qvb.30.1687852445629; 
 Tue, 27 Jun 2023 00:54:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MuUE7pHmGAU/f+yzEzo78p86PF+1as5n2EbSiG4A0k+Ud1RVLxm329AjfFLOCpH5Vc2nLng==
X-Received: by 2002:a05:6214:242c:b0:635:e113:a0ff with SMTP id
 gy12-20020a056214242c00b00635e113a0ffmr5724998qvb.30.1687852445355; 
 Tue, 27 Jun 2023 00:54:05 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05620a071500b007621b1bcbbfsm3644006qkc.102.2023.06.27.00.54.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 00:54:04 -0700 (PDT)
Date: Tue, 27 Jun 2023 03:54:00 -0400
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
Subject: Re: [PATCH v2 08/26] tests/qtests: clean-up and fix leak in
 generic_fuzz
Message-ID: <20230627075400.fnasthl3r54sn6l2@mozz.bu.edu>
References: <20230626215926.2522656-1-alex.bennee@linaro.org>
 <20230626215926.2522656-9-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230626215926.2522656-9-alex.bennee@linaro.org>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.200; envelope-from=alxndr@bu.edu;
 helo=esa15.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
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

On 230626 2259, Alex Bennée wrote:
> An update to the clang tooling detects more issues with the code
> including a memory leak from the g_string_new() allocation. Clean up
> the code with g_autoptr and use ARRAY_SIZE while we are at it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thank you

> ---
>  tests/qtest/fuzz/generic_fuzz.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index c525d22951..a4841181cc 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -954,17 +954,14 @@ static void register_generic_fuzz_targets(void)
>              .crossover = generic_fuzz_crossover
>      });
>  
> -    GString *name;
> +    g_autoptr(GString) name = g_string_new("");
>      const generic_fuzz_config *config;
>  
> -    for (int i = 0;
> -         i < sizeof(predefined_configs) / sizeof(generic_fuzz_config);
> -         i++) {
> +    for (int i = 0; i < ARRAY_SIZE(predefined_configs); i++) {
>          config = predefined_configs + i;
> -        name = g_string_new("generic-fuzz");
> -        g_string_append_printf(name, "-%s", config->name);
> +        g_string_printf(name, "generic-fuzz-%s", config->name);
>          fuzz_add_target(&(FuzzTarget){
> -                .name = name->str,
> +                .name = g_strdup(name->str),
>                  .description = "Predefined generic-fuzz config.",
>                  .get_init_cmdline = generic_fuzz_predefined_config_cmdline,
>                  .pre_fuzz = generic_pre_fuzz,
> -- 
> 2.39.2
> 

