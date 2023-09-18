Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502BE7A4C53
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 17:31:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiGD7-0002wu-Hk; Mon, 18 Sep 2023 11:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGD2-0002mo-UP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:30:51 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qiGD0-000502-9V
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 11:30:48 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-502fdfeb1d9so3666399e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 08:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695051044; x=1695655844; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eqBrWZvsFYrL6L9jg67rMHsZ5vhxS3RpB050HxrcuEc=;
 b=Ab7Wn0WAWDqgy+dAppCnpq8MU4Y4x/3HudrFgyFk/5C9ghpUAMG/7LaUCjU7m1HE/g
 ORp4yd6y6yT0Hf/i0e7I1uo178xFTVDIV16Re411DrHkMiG9IXBur01CA/NdMSCV2XiC
 k6+QLUjiSxFzichc9ijimrJ9WpuNkPMXVREVBMuJhso685phBU0tjDmIk45gFrUBHTmb
 W/7R4D7dZGwbT8oVdSiEYJAlZrJcL9h++nOVjNrDPEXHZ2Hvo01ibvG3INsvKomqJgZr
 0Rke6l/FroifPUofXfE8qQhQ4nGF/EQX3QvraugxuAiIOmx9r5BwHtKFo65LYHfTsal9
 61XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695051044; x=1695655844;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eqBrWZvsFYrL6L9jg67rMHsZ5vhxS3RpB050HxrcuEc=;
 b=DNVfMTDup/69fIx2TQXFVy22RZFFRoARf4zfXNoRC+K5yeT8L/gsFGWROygU0bByNh
 kk96g0L1g15SQaG6Qy4As0DV7gfjoVjTeBjdrpyXQ9klKYAuAU03jX9cCRu4BihQwr60
 TON0HaKWN3diZfojpX2sD4GEwUBeQsm5O8Z1ilWbExT1DOa0yUHLf8PSoRhvMml03VPk
 UsCmx3J3rvcVQxhYI6LMlYU56EM6qv+KBDDyqGQdKuQ+kedmtFqZQXHWZOq0bxqWp+Le
 fQrVUBj9FStYGO/zAV6vOncL8pky2B9p7jtBk7Kzfyj5gBwqlPerAJxy8Ig8oauaTAt9
 OYfA==
X-Gm-Message-State: AOJu0YxR0TFV+W+Gcm1oXkBA7e59Hu19JwBsLINDc2yJMAFhGo2MXnf6
 yH0oi9VKLkceIUZ8nRxQCrKeWQ==
X-Google-Smtp-Source: AGHT+IF5KgMAo6Vl3vhkmc/AFCZgBlQH5j9JPkjDycc2shrMASrD+72ptZlM2hIjzrf+o+00Z7RcMg==
X-Received: by 2002:a05:6512:32a9:b0:502:cc8d:f1fc with SMTP id
 q9-20020a05651232a900b00502cc8df1fcmr6599309lfe.37.1695051044307; 
 Mon, 18 Sep 2023 08:30:44 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 cm8-20020a0564020c8800b00530bc7cf377sm3679739edb.12.2023.09.18.08.30.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 08:30:41 -0700 (PDT)
Message-ID: <e81b785e-495b-609f-12e8-f2bd973b6f24@linaro.org>
Date: Mon, 18 Sep 2023 17:30:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] spapr/drc: Clean up local variable shadowing in
 prop_get_fdt()
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>
References: <20230918145850.241074-1-clg@kaod.org>
 <20230918145850.241074-9-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230918145850.241074-9-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/9/23 16:58, Cédric Le Goater wrote:
> Rename 'name' variable to avoid this warning :
> 
>    ../hw/ppc/spapr_drc.c: In function ‘prop_get_fdt’:
>    ../hw/ppc/spapr_drc.c:344:21: warning: declaration of ‘name’ shadows a parameter [-Wshadow=compatible-local]
>      344 |         const char *name = NULL;
>          |                     ^~~~
>    ../hw/ppc/spapr_drc.c:325:63: note: shadowed declaration is here
>      325 | static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
>          |                                                   ~~~~~~~~~~~~^~~~
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/ppc/spapr_drc.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


