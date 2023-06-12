Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2475072BC6E
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 11:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8dsI-00030c-1G; Mon, 12 Jun 2023 05:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8drm-0002oc-GC
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:29:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8drR-0006mL-NM
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 05:29:38 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30af56f5f52so2593606f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 02:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686562156; x=1689154156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3+saw8sIB4ViPXj353Xj7nlNtXRry+DrYgI2yzwGtIE=;
 b=Qz0ljW8CozMytRjDyvenTrBhQyEm81gLrrZ8o4nA0y6GKQLBa8a1rDtWv0/Y+9cTpc
 zLYyhYrtcGE6Y9UapgBuCbC0yyS/gWcJ9L/S+rfiQ94/5JB76odAlmJYZyTnK37x4v9R
 QPtQPHQ31KTlSzTG383mj3zek2iKYrnQ6kdf76qHkd7QNZ3bViDJJdirvrtl7X/xdaVR
 unpdxgqUuKeZ04hz+8TyvkNuxOyvmPRRxo3RGeLc/Dr1lF8+PkNieCDtP4E/GYrm4SMt
 /VrHkm1QBvxbQFxG9nl3SesCyPqkiu6O4CfH8onzdPAYp0VAvq3pVjKPH5QBbJ3nra4/
 L/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686562156; x=1689154156;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3+saw8sIB4ViPXj353Xj7nlNtXRry+DrYgI2yzwGtIE=;
 b=B+XaP0K2cveL5RQ2+M1e9Ru9RtXfwhTI8lhptdyqARhB4L3m6H7BPkV5yXU7mfNZFf
 dmu0v17naUf+Sel5Qgi9OiL8YWl+WDxao+0M+heq1lKU4VYs6NoK6iVOWwswBuZhSDSW
 c56R2xbIZE5KNJWJxxmu2HpcNPMTkR+sL7hBFaTvOzcGsGI26u2IVy76dctt6SHHaY/1
 sQD10AJl5o4XeG5XzH7y6bfcfMTT+MmD1eoqFuCvcwAx3h0enGJj/Jyxk7JMFOWPJl1X
 4tguXZS9yj6ttOKhRAbWcdAgdsXCjWbtsBeg+KBrsSBZIavoD5qKGWQGV5tj1f3rIyFA
 0/xQ==
X-Gm-Message-State: AC+VfDw+md5JuFMuEJT5CK02MivjFUwxeqRRUlwVz2h4U3qQfiCON9iH
 B7cjbI30CpMcsHN4AuDDbCufDw==
X-Google-Smtp-Source: ACHHUZ4r00w2uzUwEtk8r+HnmJPu2gIJtUBGsEAfPr1koUrJPNwGd/TyI+IJPVHDin9e/Kcj3b0a8g==
X-Received: by 2002:adf:de0e:0:b0:30f:b949:f7d1 with SMTP id
 b14-20020adfde0e000000b0030fb949f7d1mr2992532wrm.63.1686562155958; 
 Mon, 12 Jun 2023 02:29:15 -0700 (PDT)
Received: from [192.168.143.175] (17.red-88-29-166.dynamicip.rima-tde.net.
 [88.29.166.17]) by smtp.gmail.com with ESMTPSA id
 s3-20020adfdb03000000b003047dc162f7sm11934494wri.67.2023.06.12.02.29.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jun 2023 02:29:15 -0700 (PDT)
Message-ID: <1773d598-3b63-4bec-e08a-160dd14023d5@linaro.org>
Date: Mon, 12 Jun 2023 11:29:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 07/10] target/ppd: Remove unused define
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <13f743d961c10d03c5b4f745a1b26ece3a7e1494.1686522199.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <13f743d961c10d03c5b4f745a1b26ece3a7e1494.1686522199.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 12/6/23 00:42, BALATON Zoltan wrote:
> Commit 7a3fe174b12d removed usage of POWERPC_SYSCALL_VECTORED, drop
> the unused define as well.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   target/ppc/translate.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



