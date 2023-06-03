Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFB2720CA3
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 02:34:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5FCf-00041R-Nc; Fri, 02 Jun 2023 20:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5FCe-000418-CP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 20:33:08 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5FCc-00007O-IH
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 20:33:08 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-25695bb6461so3044835a91.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685752385; x=1688344385;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6rHjiDZNSWH8EsREmupLCsS82+u5llOZ/gpLk6O/iE=;
 b=gC/1EFM7d7gjUvc8Fx2r0fDQJ6nM29IYEGYarsxndLxIM+HF2JV6N/J3+LBcB4MSeW
 jUn90VbK+HMnbkkLNGi1S0cP//gSz9w91SIvK5uYvDsLWV2FhTLVO4nSARbCKJBLtg2q
 wrVKiH1HlDU//lCscsTa76I2zlJNOtbIziKsw59yiMHZDynBP82G1Wok7gSRUNy5isRC
 a+gbQzQOzMUpD1/BqVyVKWlKC1DRXYpqOgAajtC8PEM+Nh0rnjwuzgng5foMT9qY7rzg
 UqrMNCA3mZTmvAExI93AjHPjSAThJeQ4/sL7HjqI2GMILXdcTAeRvBKWWZICrBL0m7ND
 0pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685752385; x=1688344385;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D6rHjiDZNSWH8EsREmupLCsS82+u5llOZ/gpLk6O/iE=;
 b=S5mEOdnnlkiUqVm6/AVcgYLeo39VSDedjfMisnEvwFOXuqgnbGEJdiIsCNVrH8EZFd
 lVONuQ9izGJbCUKpchzt/WqLrG2fY7HX+5ZdYoA5dDGvcqQWbwoP60v6ayQUK2MV+6jA
 PVLRLVh38T+VJrHcr+IQKOcOtupgRLplykghHyV2dydU7iZo5PKvVnVdTR4cSOJBpl0p
 L/D0LsPLnjBBF+Mo8euxmVTU20Cpo3NB3dA2N+KEfnuLkmL8/ahTQx0WtfGdkA0UBrzd
 mTvF3q8hjXJiPAl1eSRp4GNqqQllbxEQvDwGm00Bn42QqWtSuCk1hK/Jd+/TN7gis48y
 b1Zw==
X-Gm-Message-State: AC+VfDw7ShMEUUASiAhnnAIO3ngChEghwFGJzghFaWjOz45KzD81lDTO
 pvwaXwY5PWSjn44y+aigXXIkvA==
X-Google-Smtp-Source: ACHHUZ4pIcDACYWO/H+mGrpfvY0zlX/OvqGoCgft15QpxYzcoAfo3uC6kzgYAUbtLBPzkLN/aUp7WA==
X-Received: by 2002:a17:90b:1c09:b0:258:c3e9:e9c4 with SMTP id
 oc9-20020a17090b1c0900b00258c3e9e9c4mr1216681pjb.15.1685752384740; 
 Fri, 02 Jun 2023 17:33:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:66a6:82c2:d794:68f6?
 ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 11-20020a17090a19cb00b002568f2f8102sm3856334pjj.30.2023.06.02.17.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 17:33:04 -0700 (PDT)
Message-ID: <3c286957-df93-780d-297b-9117d2f4bbdd@linaro.org>
Date: Fri, 2 Jun 2023 17:33:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v2 00/21] NBD and miscellaneous patches for 2023-06-01
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20230602173324.2233690-1-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230602173324.2233690-1-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 6/2/23 10:33, Eric Blake wrote:
> The following changes since commit a86d7b9ec0adb2f1efce8ab30d9ed2b72db0236e:
> 
>    Merge tag 'migration-20230601-pull-request' ofhttps://gitlab.com/juan.quintela/qemu  into staging (2023-06-01 20:59:28 -0700)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/ericb.git  tags/pull-nbd-2023-06-01-v2
> 
> for you to fetch changes up to 42cc08d13ab8e68f76882b216da0b28d06f29e11:
> 
>    cutils: Improve qemu_strtosz handling of fractions (2023-06-02 12:29:27 -0500)
> 
> In v2:
> - fix build failure on mingw [CI, via Richard]
> - drop dead comparisons to UINT64_MAX [Markus]
> 
> only the changed patches are re-posted
> 
> ----------------------------------------------------------------
> nbd and misc patches for 2023-06-01
> 
> - Eric Blake: Fix iotest 104 for NBD
> - Eric Blake: Improve qcow2 spec on padding bytes
> - Eric Blake: Fix read-beyond-bounds bug in qemu_strtosz

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


